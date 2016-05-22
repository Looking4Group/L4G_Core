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
SDName: Boss_The_Maker
SD%Complete: 85
SDComment:
SDCategory: Hellfire Citadel, Blood Furnace
EndScriptData */

#include "precompiled.h"
#include "def_blood_furnace.h"

#define SAY_AGGRO_1                 -1542009
#define SAY_AGGRO_2                 -1542010
#define SAY_AGGRO_3                 -1542011
#define SAY_KILL_1                  -1542012
#define SAY_KILL_2                  -1542013
#define SAY_DIE                     -1542014

#define SPELL_ACID_SPRAY            38153
#define SPELL_EXPLODING_BREAKER     (HeroicMode ? 40059 : 30925)
#define SPELL_KNOCKDOWN             20276
#define SPELL_DOMINATION            30923

struct boss_the_makerAI : public ScriptedAI
{
    boss_the_makerAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    uint32 AcidSpray_Timer;
    uint32 ExplodingBreaker_Timer;
    uint32 Domination_Timer;
    uint32 Knockdown_Timer;

    ScriptedInstance *pInstance;

    void Reset()
    {
        AcidSpray_Timer = 15000;
        ExplodingBreaker_Timer = 6000;
        Domination_Timer = 20000;
        Knockdown_Timer = 10000;

        if (pInstance)
            pInstance->SetData(DATA_MAKEREVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO_1, SAY_AGGRO_2, SAY_AGGRO_3), m_creature);

        if (pInstance)
            pInstance->SetData(DATA_MAKEREVENT, IN_PROGRESS);
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(RAND(SAY_KILL_1, SAY_KILL_2), m_creature);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DIE, m_creature);
        
        if (pInstance)
            pInstance->SetData(DATA_MAKEREVENT, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (AcidSpray_Timer < diff)
        {
            AddSpellToCast(me->getVictim(), SPELL_ACID_SPRAY);
            AcidSpray_Timer = 35000+rand()%8000; // not the correct spell. why spam ?
        }
        else
            AcidSpray_Timer -=diff;

        if (ExplodingBreaker_Timer < diff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                AddSpellToCast(target,SPELL_EXPLODING_BREAKER);

            ExplodingBreaker_Timer = urand(4000, 12000);
        }
        else
            ExplodingBreaker_Timer -=diff;

        if (Domination_Timer < diff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                AddSpellToCast(target, SPELL_DOMINATION);

            Domination_Timer = 120000;
        }
        else
            Domination_Timer -=diff;

        if (Knockdown_Timer < diff)
        {
            AddSpellToCast(me->getVictim(),SPELL_KNOCKDOWN);
            Knockdown_Timer = urand(4000, 12000);
        }
        else
            Knockdown_Timer -=diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_the_makerAI(Creature *_Creature)
{
    return new boss_the_makerAI (_Creature);
}

void AddSC_boss_the_maker()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_the_maker";
    newscript->GetAI = &GetAI_boss_the_makerAI;
    newscript->RegisterSelf();
}

