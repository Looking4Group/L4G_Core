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
SDName: Boss_Wushoolay
SD%Complete: 100
SDComment:
SDCategory: Zul'Gurub
EndScriptData */

#include "precompiled.h"
#include "def_zulgurub.h"

#define SPELL_LIGHTNINGCLOUD         25033
#define SPELL_LIGHTNINGWAVE          24819

struct boss_wushoolayAI : public ScriptedAI
{
    boss_wushoolayAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    uint32 LightningCloud_Timer;
    uint32 LightningWave_Timer;
    ScriptedInstance * pInstance;

    void Reset()
    {
        LightningCloud_Timer = 5000 + rand()%5000;
        LightningWave_Timer = 8000 + rand()%8000;
        pInstance->SetData(DATA_EDGEOFMADNESSEVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        pInstance->SetData(DATA_EDGEOFMADNESSEVENT, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        pInstance->SetData(DATA_EDGEOFMADNESSEVENT, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //LightningCloud_Timer
        if (LightningCloud_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_LIGHTNINGCLOUD);
            LightningCloud_Timer = 15000 + rand()%5000;
        }
        else
            LightningCloud_Timer -= diff;

        //LightningWave_Timer
        if (LightningWave_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0, GetSpellMaxRange(SPELL_LIGHTNINGWAVE), true))
                DoCast(target,SPELL_LIGHTNINGWAVE);

            LightningWave_Timer = 12000 + rand()%4000;
        }
        else
            LightningWave_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_wushoolay(Creature *_Creature)
{
    return new boss_wushoolayAI (_Creature);
}

void AddSC_boss_wushoolay()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_wushoolay";
    newscript->GetAI = &GetAI_boss_wushoolay;
    newscript->RegisterSelf();
}

