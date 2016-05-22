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
SDName: Boss_Doctor_Theolen_Krastinov
SD%Complete: 100
SDComment:
SDCategory: Scholomance
EndScriptData */

#include "precompiled.h"
#include "def_scholomance.h"

#define SPELL_REND              18106
#define SPELL_BLACKHAND         18103
#define SPELL_FRENZY            28371

struct boss_theolenkrastinovAI : public ScriptedAI
{
    boss_theolenkrastinovAI(Creature *c) : ScriptedAI(c) {}

    uint32 Rend_Timer;
    uint32 Blackhand_Timer;
    uint32 Frenzy_Timer;

    void Reset()
    {
        Rend_Timer = 8000;
        Blackhand_Timer = 9000;
        Frenzy_Timer =0;
    }

    void JustDied(Unit *killer)
    {
        ScriptedInstance *pInstance = (m_creature->GetInstanceData()) ? (m_creature->GetInstanceData()) : NULL;
        if(pInstance)
        {
            pInstance->SetData(DATA_DOCTORTHEOLENKRASTINOV_DEATH, 0);

            if(pInstance->GetData(DATA_CANSPAWNGANDLING))
                m_creature->SummonCreature(1853, 180.73, -9.43856, 75.507, 1.61399, TEMPSUMMON_DEAD_DESPAWN, 0);
        }
    }

    void EnterCombat(Unit *who)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //Rend_Timer
        if (Rend_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_REND);
            Rend_Timer = 10000;
        }else Rend_Timer -= diff;

        if (Blackhand_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_BLACKHAND);
            Blackhand_Timer = 10000;
        }else Blackhand_Timer -= diff;

        //Frenzy_Timer
        if ( m_creature->GetHealth()*100 / m_creature->GetMaxHealth() < 26 )
        {
            if (Frenzy_Timer < diff)
            {
                DoCast(m_creature,SPELL_FRENZY);
                DoTextEmote("goes into a killing frenzy!",NULL);

                Frenzy_Timer = 8000;
            }else Frenzy_Timer -= diff;
        }

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_theolenkrastinov(Creature *_Creature)
{
    return new boss_theolenkrastinovAI (_Creature);
}

void AddSC_boss_theolenkrastinov()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_doctor_theolen_krastinov";
    newscript->GetAI = &GetAI_boss_theolenkrastinov;
    newscript->RegisterSelf();
}

