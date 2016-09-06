/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/* ScriptData
SDName: Boss_Doomwalker
SD%Complete: 100
SDComment:
SDCategory: Shadowmoon Valley
EndScriptData */

#include "precompiled.h"

#define SAY_AGGRO                   -1000387
#define SAY_EARTHQUAKE_1            -1000388
#define SAY_EARTHQUAKE_2            -1000389
#define SAY_OVERRUN_1               -1000390
#define SAY_OVERRUN_2               -1000391
#define SAY_SLAY_1                  -1000392
#define SAY_SLAY_2                  -1000393
#define SAY_SLAY_3                  -1000394
#define SAY_DEATH                   -1000395

#define SPELL_EARTHQUAKE            32686
#define SPELL_SUNDER_ARMOR          33661
#define SPELL_CHAIN_LIGHTNING       33665
#define SPELL_OVERRUN               32636
#define SPELL_ENRAGE                33653
#define SPELL_MARK_DEATH            37128

struct boss_doomwalkerAI : public ScriptedAI
{
    boss_doomwalkerAI(Creature *c) : ScriptedAI(c)
    {
        m_creature->GetPosition(wLoc);
        // On script initialisation we want to make Doomwalker invisible in case he shouldn't spawn due to server crash/restart
        m_creature->SetVisibility(VISIBILITY_OFF);
    }

    uint32 Chain_Timer;
    uint32 Enrage_Timer;
    uint32 Overrun_Timer;
    uint32 Quake_Timer;
    uint32 Armor_Timer;
    uint32 Check_Timer;
    uint32 Earthquake_Channel_Timer;
    bool isEarthquake;

    WorldLocation wLoc;

    bool InEnrage;

    void Reset()
    {
        Enrage_Timer    = 0;
        Armor_Timer     = 5000 + rand()%8000;
        Chain_Timer     = 10000 + rand()%20000;
        Quake_Timer     = 25000 + rand()%10000;
        Overrun_Timer   = 30000 + rand()%15000;
        Earthquake_Channel_Timer = 0;

        InEnrage = false;
        isEarthquake = false;
        
        QueryResultAutoPtr resultWorldBossRespawn = QueryResultAutoPtr(NULL); 
        resultWorldBossRespawn = GameDataDatabase.PQuery("SELECT RespawnTime FROM worldboss_respawn WHERE BossEntry = %i", m_creature->GetEntry());
        if (resultWorldBossRespawn)
        {
            Field* fieldsWBR = resultWorldBossRespawn->Fetch();
            uint64 respawn_time = fieldsWBR[0].GetUInt64();
            if (respawn_time > time(0))
            {
                // If Doomwalker shouldn't be spawned then despawn him and make him invisible for any future attempted respawns
                me->SetVisibility(VISIBILITY_OFF);
                me->DisappearAndDie();
            } else {
                // If Doomwalker should be spawned, make him visible
                me->SetVisibility(VISIBILITY_ON);
            }
        }        
    }

    void KilledUnit(Unit* victim)
    {
        if(!victim->HasAura(SPELL_MARK_DEATH,0))
        {
            m_creature->AddAura(SPELL_MARK_DEATH,victim);
        }

        DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2, SAY_SLAY_3), m_creature);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, m_creature);
        uint64 respawn_time = urand(302400, 604800); // set the next respawn time between 3.5 to 7 days
        GameDataDatabase.PExecute("REPLACE INTO worldboss_respawn VALUES (%i, %i)", m_creature->GetEntry(), respawn_time+time(0));
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, m_creature);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if(who->HasAura(SPELL_MARK_DEATH,0) && !who->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
            m_creature->Kill(who,true);

        ScriptedAI::MoveInLineOfSight(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(Check_Timer < diff)
        {
            if(!m_creature->IsWithinDistInMap(&wLoc, 80.0f))
                EnterEvadeMode();

            Check_Timer = 2000;
        }else Check_Timer -= diff;


        // Do not do anything during Earthquake channeling
        // Fixed issue of Doomwalker autoattacking / lightning and interruping earthquake
        if (Earthquake_Channel_Timer < diff) {
            isEarthquake = false;
        }
        else if (isEarthquake) {
            Earthquake_Channel_Timer -= diff;
            return;
        }

        //Spell Enrage, when hp <= 20% gain enrage
        if (((m_creature->GetHealth()*100)/ m_creature->GetMaxHealth()) <= 20)
        {
            if(Enrage_Timer < diff)
            {
                m_creature->RemoveAurasDueToSpell(SPELL_ENRAGE);
                DoCast(m_creature,SPELL_ENRAGE);
                Enrage_Timer = 600000;
                InEnrage = true;
            }else Enrage_Timer -= diff;
        }

        //Spell Overrun
        if (Overrun_Timer < diff)
        {
            DoScriptText(RAND(SAY_OVERRUN_1, SAY_OVERRUN_2), m_creature);

            DoCast(m_creature->getVictim(),SPELL_OVERRUN);

            DoResetThreat();

            Overrun_Timer = 25000 + rand()%15000;
        }else Overrun_Timer -= diff;

        //Spell Earthquake
        if (Quake_Timer < diff)
        {
            if (rand()%2)
                return;

            DoScriptText(RAND(SAY_EARTHQUAKE_1, SAY_EARTHQUAKE_2), m_creature);

            //remove enrage before casting earthquake because enrage + earthquake = 16000dmg over 8sec and all dead
            if (InEnrage)
                m_creature->RemoveAura(SPELL_ENRAGE, 0);

            DoCast(m_creature,SPELL_EARTHQUAKE);
            isEarthquake = true;
            Enrage_Timer = 8000;
            Earthquake_Channel_Timer = 8000;
            Quake_Timer = 30000 + rand()%25000;
        }else Quake_Timer -= diff;

        //Spell Chain Lightning
        if (Chain_Timer < diff)
        {
            Unit* target = NULL;
            target = SelectUnit(SELECT_TARGET_RANDOM,1, GetSpellMaxRange(SPELL_CHAIN_LIGHTNING), true, m_creature->getVictimGUID());

            if (!target)
                target = m_creature->getVictim();

            if (target)
                DoCast(target,SPELL_CHAIN_LIGHTNING);

            Chain_Timer = 10000 + rand()%25000;
        }else Chain_Timer -= diff;

        //Spell Sunder Armor
        if (Armor_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_SUNDER_ARMOR);
            Armor_Timer = 10000 + rand()%15000;
        }else Armor_Timer -= diff;


        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_doomwalker(Creature *_Creature)
{
    return new boss_doomwalkerAI (_Creature);
}

void AddSC_boss_doomwalker()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_doomwalker";
    newscript->GetAI = &GetAI_boss_doomwalker;
    newscript->RegisterSelf();
}
