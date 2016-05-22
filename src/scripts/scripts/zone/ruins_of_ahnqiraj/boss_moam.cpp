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
SDName: Boss_Moam
SD%Complete: 90
SDComment: Mana Fiends not 100% scripted, rest should be OK
SDCategory: Ruins of Ahn'Qiraj
EndScriptData */

#include "precompiled.h"
#include "def_ruins_of_ahnqiraj.h"

#define EMOTE_AGGRO             -1509000
#define EMOTE_MANA_FULL         -1509001

#define SPELL_TRAMPLE           15550
#define SPELL_DRAINMANA         25671 //27256
#define SPELL_ARCANEERUPTION    25672
#define SPELL_SUMMONMANA        25681
#define SPELL_ENERGIZE          25685                       //Energize

//mana fiends
#define SPELL_ARCANEEXPLOSION   25679
#define SPELL_COUNTERSPELL      15122

struct boss_moamAI : public ScriptedAI
{
    boss_moamAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (ScriptedInstance*)c->GetInstanceData();
    }

    ScriptedInstance * pInstance;

    Unit *pTarget;
    uint32 TRAMPLE_Timer;
    uint32 DRAINMANA_Timer;
    uint32 SUMMONMANA_Timer;
    uint32 DrainTargets;
    bool stoned;

    void Reset()
    {
        pTarget = NULL;
        TRAMPLE_Timer = 30000;
        DRAINMANA_Timer = 5000;
        SUMMONMANA_Timer = 90000;
        DrainTargets = 0;
        stoned = false;

        if (pInstance)
            pInstance->SetData(DATA_MOAM, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(EMOTE_AGGRO, m_creature);
        pTarget = who;
        m_creature->SetPower(POWER_MANA, 0); //starts without any mana

        if (pInstance)
            pInstance->SetData(DATA_MOAM, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_MOAM, DONE);
    }

    void JustSummoned(Creature *creature)
    {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0);
            if(target)
            {
                creature->setActive(true);
                creature->AI()->AttackStart(target);
            }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //If we are 100%MANA cast Arcane Erruption and remove aura due to being stoned
        if (m_creature->GetPower(POWER_MANA)*100 / m_creature->GetMaxPower(POWER_MANA) == 100)
        {
            if (stoned)
            {
                m_creature->RemoveAurasDueToSpell(SPELL_ENERGIZE);
                stoned = false;
                SUMMONMANA_Timer = 90000;
                DRAINMANA_Timer = 5000;
            }
            DoCast(m_creature->getVictim(),SPELL_ARCANEERUPTION);
            DoScriptText(EMOTE_MANA_FULL, m_creature);
        }

        //SUMMONMANA_Timer
        if (SUMMONMANA_Timer < diff)
        {
            if (stoned)
            {
                m_creature->RemoveAurasDueToSpell(SPELL_ENERGIZE);
                stoned = false;
                SUMMONMANA_Timer = 90000;
                DRAINMANA_Timer = 5000;
            }
            else if (!stoned)
            {
                //3 different spells, because of 3 different positions
                DoCast(m_creature->getVictim(),SPELL_SUMMONMANA);
                DoCast(m_creature->getVictim(),SPELL_SUMMONMANA+1);
                DoCast(m_creature->getVictim(),SPELL_SUMMONMANA+2);
                DoCast(m_creature, SPELL_ENERGIZE);
                SUMMONMANA_Timer = 90000;
                DRAINMANA_Timer = 90000;
                stoned = true;
            }
        }
        else SUMMONMANA_Timer -= diff;

        //TRAMPLE_Timer
        if (TRAMPLE_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_TRAMPLE);
            TRAMPLE_Timer = 30000;
        }
        else TRAMPLE_Timer -= diff;

        //DRAINMANA_Timer
        if (DRAINMANA_Timer < diff)
        {
            DrainTargets = m_creature->getThreatManager().getThreatList().size();
                            for (uint32 i = 0; i < DrainTargets && i < 6; i++)
                            {
                                Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 80.0, true);
                                if(!target)
                                    target = m_creature->getVictim();

                                if(target)
                                    DoCast(target, SPELL_DRAINMANA, true);
                            }
            DRAINMANA_Timer = 5000;
        }
        else DRAINMANA_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_moam(Creature *_Creature)
{
    return new boss_moamAI (_Creature);
}

struct mana_fiendAI : public ScriptedAI
{
    mana_fiendAI(Creature *c) : ScriptedAI(c) {}

    Unit *pTarget;
    uint32 Arcane_Timer;

    void Reset()
    {
        Arcane_Timer = 3000;
    }

    void EnterCombat(Unit *who)
    {
        pTarget = who;
    }

 //TODO counterspell
    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;
        if (Arcane_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_ARCANEEXPLOSION);
            Arcane_Timer = 3000;
        }
        else Arcane_Timer -= diff;
        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_mana_fiend(Creature *_Creature)
{
    return new mana_fiendAI (_Creature);
}

void AddSC_boss_moam()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_moam";
    newscript->GetAI = &GetAI_boss_moam;
    newscript->RegisterSelf();
}

void AddSC_mana_fiend()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="mana_fiend";
    newscript->GetAI = &GetAI_mana_fiend;
    newscript->RegisterSelf();
}

