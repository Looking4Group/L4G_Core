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
SDName: Boss_Watchkeeper_Gargolmar
SD%Complete: 90
SDComment: Fix Charge Spell
SDCategory: Hellfire Citadel, Hellfire Ramparts
EndScriptData */

#include "precompiled.h"
#include "hellfire_ramparts.h"

enum WatchkeeperGargolmar
{
    SAY_TAUNT               = -1543000,
    SAY_HEAL                = -1543001,
    SAY_SURGE               = -1543002,
    SAY_AGGRO_1             = -1543003,
    SAY_AGGRO_2             = -1543004,
    SAY_AGGRO_3             = -1543005,
    SAY_KILL_1              = -1543006,
    SAY_KILL_2              = -1543007,
    SAY_DIE                 = -1543008,

    SPELL_MORTAL_WOUND      = 30641,
    H_SPELL_MORTAL_WOUND    = 36814,
    SPELL_SURGE             = 34645,
    SPELL_RETALIATION       = 22857,
    SPELL_OVERPOWER         = 32154,

    SPELL_CHARGE_VISUAL     = 40602
};

struct boss_watchkeeper_gargolmarAI : public ScriptedAI
{
    boss_watchkeeper_gargolmarAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        HeroicMode = me->GetMap()->IsHeroic();
    }

    ScriptedInstance* pInstance;

    bool HeroicMode;

    uint32 Surge_Timer;
    uint32 MortalWound_Timer;
    uint32 Retaliation_Timer;
    uint32 Overpower_Timer;

    bool HasTaunted;
    bool YelledForHeal;

    void Reset()
    {
        Surge_Timer = 5000;
        MortalWound_Timer = 4000;
        Retaliation_Timer = 0;
        Overpower_Timer = 0;

        HasTaunted = false;
        YelledForHeal = false;

        if (pInstance)
            pInstance->SetData(DATA_GARGOLMAR, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO_1, SAY_AGGRO_2, SAY_AGGRO_3), me);

        if (pInstance)
            pInstance->SetData(DATA_GARGOLMAR, IN_PROGRESS);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (!me->getVictim() && who->isTargetableForAttack() && ( me->IsHostileTo( who )) && who->isInAccessiblePlacefor(me) )
        {
            if (!me->CanFly() && me->GetDistanceZ(who) > CREATURE_Z_ATTACK_RANGE)
                return;

            float attackRadius = me->GetAttackDistance(who);
            if (me->IsWithinDistInMap(who, attackRadius) && me->IsWithinLOSInMap(who))
            {
                //who->RemoveSpellsCausingAura(SPELL_AURA_MOD_STEALTH);
                AttackStart(who);
            }
            else if (!HasTaunted && me->IsWithinDistInMap(who, 60.0f))
            {
                DoScriptText(SAY_TAUNT, me);
                HasTaunted = true;
            }
        }
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(RAND(SAY_KILL_1, SAY_KILL_2), me);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DIE, me);

        if (pInstance)
            pInstance->SetData(DATA_GARGOLMAR, DONE);
    }

    void DoMeleeAttackIfReady()
    {
        if (!m_creature->IsNonMeleeSpellCasted(false))
        {
            if (m_creature->isAttackReady() && m_creature->IsWithinMeleeRange(m_creature->getVictim()))
            {
                if (!Overpower_Timer)
                {
                    uint32 health = m_creature->getVictim()->GetHealth();
                    m_creature->AttackerStateUpdate(m_creature->getVictim());
                    if (m_creature->getVictim() && health == m_creature->getVictim()->GetHealth())
                    {
                        DoCast(m_creature->getVictim(), SPELL_OVERPOWER, false);
                        Overpower_Timer = 5000;
                    }
                }
                else m_creature->AttackerStateUpdate(m_creature->getVictim());
                m_creature->resetAttackTimer();
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (MortalWound_Timer < diff)
        {
            DoCast(me->getVictim(),HeroicMode ? H_SPELL_MORTAL_WOUND : SPELL_MORTAL_WOUND);
            MortalWound_Timer = urand(5000, 13000);
        }else MortalWound_Timer -= diff;

        if (Surge_Timer < diff)
        {
            DoScriptText(SAY_SURGE, me);

            if (Unit * target = SelectUnit(SELECT_TARGET_FARTHEST, 0, 40.0f, true, 0, 1.0f))
            {
                DoCast(target, SPELL_CHARGE_VISUAL,true);
                DoCast(target, SPELL_SURGE, true);    
            }
            Surge_Timer = urand(5000, 13000);
        }else Surge_Timer -= diff;

        if (Overpower_Timer < diff)
        {
            // implemented in DoMeleeAttackIfReady()
            Overpower_Timer = 0;
        }
        else Overpower_Timer -= diff;

        if ((me->GetHealthPct() <= 20))
        {
            if (Retaliation_Timer < diff)
            {
                DoCast(me,SPELL_RETALIATION);
                Retaliation_Timer = 30000;
            }else Retaliation_Timer -= diff;
        }

        if (!YelledForHeal)
        {
            if ((me->GetHealthPct() <= 40))
            {
                DoScriptText(SAY_HEAL, me);
                YelledForHeal = true;
            }
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_watchkeeper_gargolmarAI(Creature *_Creature)
{
    return new boss_watchkeeper_gargolmarAI (_Creature);
}

void AddSC_boss_watchkeeper_gargolmar()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_watchkeeper_gargolmar";
    newscript->GetAI = &GetAI_boss_watchkeeper_gargolmarAI;
    newscript->RegisterSelf();
}

