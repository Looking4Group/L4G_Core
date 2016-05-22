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
SDName: Boss_Baron_Geddon
SD%Complete: 100
SDComment: DMG in DB is propably wrong (30 on plate tank?)
SDCategory: Molten Core
EndScriptData */

#include "precompiled.h"
#include "def_molten_core.h"

#define EMOTE_SERVICE               -1409000

#define SPELL_INFERNO               19695
#define SPELL_IGNITEMANA            19659
#define SPELL_LIVINGBOMB            20475
#define SPELL_ARMAGEDDOM            20478 //20479 triggered
#define SPELL_SUMMONPLAYER          20477 //not implemented

struct boss_baron_geddonAI : public ScriptedAI
{
    boss_baron_geddonAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (ScriptedInstance*)c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 Inferno_Timer;
    uint32 IgniteMana_Timer;
    uint32 LivingBomb_Timer;
    uint32 Armageddon_Timer;

    void Reset()
    {
        Inferno_Timer = 10000;
        IgniteMana_Timer = 30000;
        LivingBomb_Timer = 35000;
        Armageddon_Timer = 0;

        if (pInstance && pInstance->GetData(DATA_BARON_GEDDON_EVENT) != DONE)
            pInstance->SetData(DATA_BARON_GEDDON_EVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        if (pInstance)
            pInstance->SetData(DATA_BARON_GEDDON_EVENT, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_BARON_GEDDON_EVENT, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (m_creature->HasAura(19695, 1))
            return;

        //If we are <2% hp cast Armageddom
        if (m_creature->GetHealth()*100 / m_creature->GetMaxHealth() <= 2 && Armageddon_Timer < diff)
        {
            Armageddon_Timer = 9000;    //We don't want him to cast while being under Armageddon effect
            Inferno_Timer = 9000;
            IgniteMana_Timer = 9000;
            LivingBomb_Timer = 9000;
            m_creature->InterruptNonMeleeSpells(true);
            DoCast(m_creature,SPELL_ARMAGEDDOM);
            DoScriptText(EMOTE_SERVICE, m_creature);
            return;
        }

        //Inferno_Timer
        if (Inferno_Timer < diff)
        {
            AddSpellToCast(m_creature, SPELL_INFERNO, false);
            Inferno_Timer = 22000;
        }else Inferno_Timer -= diff;

        //IgniteMana_Timer
        if (IgniteMana_Timer < diff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(target,SPELL_IGNITEMANA);

            IgniteMana_Timer = 30000;
        }else IgniteMana_Timer -= diff;

        //LivingBomb_Timer
        if (LivingBomb_Timer < diff)
        {
           if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
               DoCast(target,SPELL_LIVINGBOMB);

            LivingBomb_Timer = 35000;
        }else LivingBomb_Timer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_baron_geddon(Creature *_Creature)
{
    return new boss_baron_geddonAI (_Creature);
}

void AddSC_boss_baron_geddon()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_baron_geddon";
    newscript->GetAI = &GetAI_boss_baron_geddon;
    newscript->RegisterSelf();
}

