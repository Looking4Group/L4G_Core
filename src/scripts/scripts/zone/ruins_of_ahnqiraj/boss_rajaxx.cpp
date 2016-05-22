/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/* ScriptData
SDName: Boss_Rajaxx
SD%Complete: 30
SDComment: Waves event NYI, timers may be wrong, lieutenant AI NYI
SDCategory: Ruins of Ahn'Qiraj
EndScriptData */

#include "precompiled.h"
#include "def_ruins_of_ahnqiraj.h"

#define SAY_ANDOROV_INTRO   -1509003 //They come now. Try not to get yourself killed, young blood.
#define SAY_ANDOROV_ATTACK  -1509004 //Remember, Rajaxx, when I said I'd kill you last? I lied...

#define SAY_WAVE3           -1509005 //The time of our retribution is at hand! Let darkness reign in the hearts of our enemies!
#define SAY_WAVE4           -1509006 //No longer will we wait behind barred doors and walls of stone! No longer will our vengeance be denied! The dragons themselves will tremble before our wrath!
#define SAY_WAVE5           -1509007 //Fear is for the enemy! Fear and death!
#define SAY_WAVE6           -1509008 //Staghelm will whimper and beg for his life, just as his whelp of a son did! One thousand years of injustice will end this day!
#define SAY_WAVE7           -1509009 //Fandral! Your time has come! Go and hide in the Emerald Dream and pray we never find you!
#define SAY_INTRO           -1509010 //Impudent fool! I will kill you myself!

#define SAY_UNK1            -1509011 //Attack and make them pay dearly!
#define SAY_UNK2            -1509012 //Crush them! Drive them out!
#define SAY_UNK3            -1509013 //Do not hesitate! Destroy them!
#define SAY_UNK4            -1509014 //Warriors! Captains! Continue the fight!

#define SAY_DEAGGRO         -1509015 //You are not worth my time $N!
#define SAY_KILLS_ANDOROV   -1509016 //Breath your last!

#define SAY_COMPLETE_QUEST  -1509017                        //Yell when realm complete quest 8743 for world event

#define SPELL_DISARM        6713
#define SPELL_FRENZY        8269
#define SPELL_THUNDERCRASH  25599

//Lieutenant
#define SAY_START       // Remember, Rajaxx, when I said I'd kill you last? I lied...
#define SAY_BEFORE      // They come now. Try not to get yourself killed, young blood.
#define SAY_FIRST_WAVE  // Kill first, ask questions later... Incoming!

#define SPELL_AURA          25516
#define SPELL_BASH          25515
#define SPELL_STRIKE        22591

//Officers
#define SPELL_CLEAVE                40504
#define SPELL_SUNDER_ARMOR          24317
#define SPELL_FRIGHTENING_SHOUT     19134       //Captain Queez 15391
#define SPELL_ATTACK_ORDER          25471       //Captain Tuubid 15392
#define SPELL_LIGHTNING_CLOUD       26550       //Captain Drenn 15389
#define SPELL_SHOCKWAVE             25425       //Captain Xurrem 15390
#define SPELL_SHIELD_OF_RAJAXX      25282       //Major Yeggeth 15386
#define SPELL_SWEEPING_SLAM         25322       //Major Pakkon 15388
#define SPELL_ENLARGE               25462       //Colonel Zerran 15385

struct boss_rajaxxAI : public ScriptedAI
{
    boss_rajaxxAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (ScriptedInstance*)c->GetInstanceData();
    }

    ScriptedInstance * pInstance;

    uint32 Disarm_Timer;
    uint32 Thundercrash_Timer;
    bool frenzied;

    void Reset()
    {
        Thundercrash_Timer = 30000; //propably wrong
        Disarm_Timer = 20000;
        frenzied = false;

        if (pInstance)
            pInstance->SetData(DATA_GENERAL_RAJAXX, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_INTRO, m_creature);

        if (pInstance)
            pInstance->SetData(DATA_GENERAL_RAJAXX, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_GENERAL_RAJAXX, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //Thundercrash_Timer
        if (Thundercrash_Timer < diff)
        {
            DoCast(m_creature, SPELL_THUNDERCRASH);
            Thundercrash_Timer = 30000;
        }
        else Thundercrash_Timer -= diff;

        if (Disarm_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_DISARM);
            Disarm_Timer = 20000;
        }
        else Disarm_Timer -= diff;

        //keep being frenzied if hp<30%
        if (/*!frenzied*/ !m_creature->GetAura(SPELL_FRENZY, 0) && m_creature->GetHealth()*100 / m_creature->GetMaxHealth() < 30)
        {
            DoCast(m_creature, SPELL_FRENZY);
            //frenzied = true;
        }
        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_rajaxx(Creature *_Creature)
{
    return new boss_rajaxxAI (_Creature);
}

struct lieutenant_general_andorovAI : public ScriptedAI
{
    lieutenant_general_andorovAI(Creature *c) : ScriptedAI(c) {}

    void Reset()
    {
    }

    void EnterCombat(Unit *who)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;
        DoMeleeAttackIfReady();
    }
};


CreatureAI* GetAI_lieutenant_general_andorov(Creature *_Creature)
{
    return new lieutenant_general_andorovAI (_Creature);
}

struct rajaxx_officerAI : public ScriptedAI
{
    rajaxx_officerAI(Creature *c) : ScriptedAI(c) {}

    uint32 SunderTimer;
    uint32 CleaveTimer;
    uint32 SpecialTimer;
    uint32 GUID;
    Unit *tempTarget;

    void Reset()
    {
        SunderTimer=5000;
        CleaveTimer=10000;
        SpecialTimer=15000;
        tempTarget = NULL;
    }

    void EnterCombat(Unit *who)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (SunderTimer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_SUNDER_ARMOR);
            SunderTimer = 5000 + urand(0, 5000);
        }
        else SunderTimer -= diff;

        if (CleaveTimer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_CLEAVE);
            CleaveTimer = 7500 + urand (0, 5000);
        }
        else CleaveTimer -= diff;

        //TODO Cast buffs on mobs, not only officers
        if (SpecialTimer < diff)
        {
            switch (GUID)
            {
            case 15391:
                DoCast(m_creature->getVictim(), SPELL_FRIGHTENING_SHOUT);
                SpecialTimer = 30000 + urand (0, 10000);
                break;
            case 15392:
                tempTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 100, true);
                DoCast(tempTarget, SPELL_ATTACK_ORDER);
                SpecialTimer = 30000;
                break;
            case 15389:
                DoCast(m_creature->getVictim(), SPELL_LIGHTNING_CLOUD);
                SpecialTimer = 30000;
                break;
            case 15390:
                DoCast(m_creature->getVictim(), SPELL_SHOCKWAVE);
                SpecialTimer = 30000;
                break;
            case 15386:
                DoCast(m_creature, SPELL_SHIELD_OF_RAJAXX);
                SpecialTimer = 15000;
                break;
            case 15388:
                DoCast(m_creature->getVictim(), SPELL_SWEEPING_SLAM);
                SpecialTimer = 30000;
                break;
            case 15385:
                DoCast(m_creature, SPELL_ENLARGE);
                SpecialTimer = 60000;
                break;
            }

        }
        else SpecialTimer -=diff;

        DoMeleeAttackIfReady();
    }
};


CreatureAI* GetAI_rajaxx_officer(Creature *_Creature)
{
    return new rajaxx_officerAI (_Creature);
}

void AddSC_boss_rajaxx()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_rajaxx";
    newscript->GetAI = &GetAI_boss_rajaxx;
    newscript->RegisterSelf();
}

void AddSC_lieutenant_general_andorov()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="lieutenant_general_andorov";
    newscript->GetAI = &GetAI_lieutenant_general_andorov;
    newscript->RegisterSelf();
}

void AddSC_rajaxx_officer()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="rajaxx_officer";
    newscript->GetAI = &GetAI_rajaxx_officer;
    newscript->RegisterSelf();
}
