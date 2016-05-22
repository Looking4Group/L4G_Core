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
SDName: Boss_Ramstein_The_Gorger
SD%Complete: 70
SDComment:
SDCategory: Stratholme
EndScriptData */

#include "precompiled.h"
#include "def_stratholme.h"

#define SPELL_TRAMPLE       5568
#define SPELL_KNOCKOUT    17307

 #define C_MINDLESS_UNDEAD   11030

struct boss_ramstein_the_gorgerAI : public ScriptedAI
{
    boss_ramstein_the_gorgerAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (ScriptedInstance*)m_creature->GetInstanceData();
    }

    ScriptedInstance* pInstance;

    uint32 Trample_Timer;
    uint32 Knockout_Timer;
    std::list<uint64> summons;

    void Reset()
    {
        Trample_Timer = 3000;
        Knockout_Timer = 12000;
        summons.clear();
    }

    void EnterCombat(Unit *who)
    {
    }

    void JustDied(Unit* Killer)
    {
        for(uint8 i = 0; i < 30; i++)
            m_creature->SummonCreature(C_MINDLESS_UNDEAD,3969.35,-3391.87,119.11,5.91,TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,1800000);

        if (pInstance)
            pInstance->SetData(TYPE_RAMSTEIN,SPECIAL);
    }

    void JustSummoned(Creature* c)
    {
        c->AI()->DoZoneInCombat();
        summons.push_back(c->GetGUID());
    }

    void SummonedCreatureDespawn(Creature*)
    {
        if (pInstance && pInstance->GetData(TYPE_RAMSTEIN) == SPECIAL && std::none_of(summons.begin(),summons.end(),[this](uint64 guid)-> bool {Creature *c = pInstance->GetCreature(guid) ; return c ? c->isAlive():false;}))
            pInstance->SetData(TYPE_RAMSTEIN,DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        //Trample
        if (Trample_Timer < diff)
        {
            DoCast(m_creature,SPELL_TRAMPLE);
            Trample_Timer = 7000;
        }else Trample_Timer -= diff;

        //Knockout
        if (Knockout_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_KNOCKOUT);
            Knockout_Timer = 10000;
        }else Knockout_Timer -= diff;

        DoMeleeAttackIfReady();
    }

    void EnterEvadeMode()
    {
        CreatureAI::EnterEvadeMode();
        if(pInstance)
        {
            pInstance->SetData(TYPE_RAMSTEIN,FAIL);
        }
    }
};
CreatureAI* GetAI_boss_ramstein_the_gorger(Creature *_Creature)
{
    return new boss_ramstein_the_gorgerAI (_Creature);
}

void AddSC_boss_ramstein_the_gorger()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_ramstein_the_gorger";
    newscript->GetAI = &GetAI_boss_ramstein_the_gorger;
    newscript->RegisterSelf();
}

