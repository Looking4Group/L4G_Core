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
SDName: Boss_Jin'do the Hexxer
SD%Complete: 85
SDComment: Mind Control not working because of core bug. Shades visible for all.
SDCategory: Zul'Gurub
EndScriptData */

#include "precompiled.h"
#include "def_zulgurub.h"

#define SAY_AGGRO                       -1309014

#define SPELL_BRAINWASHTOTEM            24262
#define SPELL_POWERFULLHEALINGWARD      24309
#define SPELL_HEX                       24053
#define SPELL_DELUSIONSOFJINDO          24306

//Shade of Jindo Spell
#define SPELL_SHADOWSHOCK               19460
#define SPELL_INVISIBLE                 24307

struct boss_jindoAI : public ScriptedAI
{
    boss_jindoAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    uint32 BrainWashTotem_Timer;
    uint32 HealingWard_Timer;
    uint32 Hex_Timer;
    uint32 Delusions_Timer;
    uint32 Teleport_Timer;

    Creature *Shade;
    Creature *Skeletons;
    Creature *HealingWard;

    void Reset()
    {
        BrainWashTotem_Timer = 20000;
        HealingWard_Timer = 16000;
        Hex_Timer = 8000;
        Delusions_Timer = 10000;
        Teleport_Timer = 5000;
        pInstance->SetData(DATA_JINDOEVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, m_creature);
        pInstance->SetData(DATA_JINDOEVENT, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        pInstance->SetData(DATA_JINDOEVENT, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //BrainWashTotem_Timer
        if (BrainWashTotem_Timer < diff)
        {
            DoCast(m_creature, SPELL_BRAINWASHTOTEM);
            BrainWashTotem_Timer = 18000 + rand()%8000;
        }
        else
            BrainWashTotem_Timer -= diff;

        //HealingWard_Timer
        if (HealingWard_Timer < diff)
        {
            DoCast(m_creature, SPELL_POWERFULLHEALINGWARD);
            HealingWard_Timer = 14000 + rand()%6000;
        }
        else
            HealingWard_Timer -= diff;

        //Hex_Timer
        if (Hex_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_HEX);

            if(DoGetThreat(m_creature->getVictim()))
                DoModifyThreatPercent(m_creature->getVictim(),-80);

            Hex_Timer = 12000 + rand()%8000;
        }
        else
            Hex_Timer -= diff;

        //Casting the delusion curse with a shade. So shade will attack the same target with the curse.
        if(Delusions_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0, GetSpellMaxRange(SPELL_DELUSIONSOFJINDO), true))
            {
                DoCast(target, SPELL_DELUSIONSOFJINDO);

                Shade = m_creature->SummonCreature(14986, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Shade)
                    Shade->AI()->AttackStart(target);
            }
            Delusions_Timer = 4000 + rand()%8000;
        }
        else
            Delusions_Timer -= diff;

        //Teleporting a random gamer and spawning 9 skeletons that will attack this gamer
        if(Teleport_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0, 200, true))
            {
                DoTeleportPlayer(target, -11583.7783,-1249.4278,77.5471,4.745);

                if(DoGetThreat(m_creature->getVictim()))
                    DoModifyThreatPercent(target,-100);

                Skeletons = m_creature->SummonCreature(14826, target->GetPositionX()+2, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Skeletons)
                    Skeletons->AI()->AttackStart(target);
                Skeletons = m_creature->SummonCreature(14826, target->GetPositionX()-2, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Skeletons)
                    Skeletons->AI()->AttackStart(target);
                Skeletons = m_creature->SummonCreature(14826, target->GetPositionX()+4, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Skeletons)
                    Skeletons->AI()->AttackStart(target);
                Skeletons = m_creature->SummonCreature(14826, target->GetPositionX()-4, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Skeletons)
                    Skeletons->AI()->AttackStart(target);
                Skeletons = m_creature->SummonCreature(14826, target->GetPositionX(), target->GetPositionY()+2, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Skeletons)
                    Skeletons->AI()->AttackStart(target);
                Skeletons = m_creature->SummonCreature(14826, target->GetPositionX(), target->GetPositionY()-2, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Skeletons)
                    Skeletons->AI()->AttackStart(target);
                Skeletons = m_creature->SummonCreature(14826, target->GetPositionX(), target->GetPositionY()+4, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Skeletons)
                    Skeletons->AI()->AttackStart(target);
                Skeletons = m_creature->SummonCreature(14826, target->GetPositionX(), target->GetPositionY()-4, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Skeletons)
                    Skeletons->AI()->AttackStart(target);
                Skeletons = m_creature->SummonCreature(14826, target->GetPositionX()+3, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                if(Skeletons)
                    Skeletons->AI()->AttackStart(target);
            }

            Teleport_Timer = 15000 + rand()%8000;
        }
        else
            Teleport_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};


//Shade of Jindo
struct mob_shade_of_jindoAI : public ScriptedAI
{
    mob_shade_of_jindoAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    uint32 ShadowShock_Timer;

    ScriptedInstance *pInstance;

    void Reset()
    {
        ShadowShock_Timer = 1000;
        m_creature->CastSpell(m_creature, SPELL_INVISIBLE,true);
    }

    void EnterCombat(Unit *who)
    {
    }

    void UpdateAI (const uint32 diff)
    {

        //ShadowShock_Timer
        if(ShadowShock_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_SHADOWSHOCK);
            ShadowShock_Timer = 2000;
        }
        else
            ShadowShock_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_jindo(Creature *_Creature)
{
    return new boss_jindoAI (_Creature);
}

CreatureAI* GetAI_mob_shade_of_jindo(Creature *_Creature)
{
    return new mob_shade_of_jindoAI (_Creature);
}

void AddSC_boss_jindo()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_jindo";
    newscript->GetAI = &GetAI_boss_jindo;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_shade_of_jindo";
    newscript->GetAI = &GetAI_mob_shade_of_jindo;
    newscript->RegisterSelf();
}

