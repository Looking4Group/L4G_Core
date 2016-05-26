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
SDName: Boss_Grobbulus
SD%Complete: ??
SDComment: Initial script.
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

enum GrobbulusSpells
{
    SPELL_POISON_CLOUD          = 26590,
    SPELL_SLIME_SPRAY           = 28157,
    SPELL_FALLOUT_SLIME         = 28218,
    SPELL_MUTATING_INFECTION    = 28169,
    SPELL_ENRAGES               = 26527,
    SPELL_SLIME_STREAM          = 28137
};

enum GrobbulusEvents
{
    EVENT_POISON_CLOUD          = 1,
    EVENT_SLIME_SPRAY           = 2,
    EVENT_MUTATING_INFECTION    = 3,
    EVENT_ENRAGE                = 4
};

struct boss_grobbulusAI : public BossAI
{
    boss_grobbulusAI(Creature *c) : BossAI(c, DATA_GROBBULUS) { }

    void Reset()
    {
        events.Reset();
        events.ScheduleEvent(EVENT_POISON_CLOUD, 15000);
        events.ScheduleEvent(EVENT_SLIME_SPRAY, 15000);
        events.ScheduleEvent(EVENT_MUTATING_INFECTION, urand(18000, 22000));
        events.ScheduleEvent(EVENT_ENRAGE, 720000);

        instance->SetData(DATA_GROBBULUS, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        instance->SetData(DATA_GROBBULUS, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        instance->SetData(DATA_GROBBULUS, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVERYTHING);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_POISON_CLOUD:
                {
                    AddSpellToCast(SPELL_POISON_CLOUD, CAST_SELF);
                    events.ScheduleEvent(EVENT_POISON_CLOUD, 15000);
                    break;
                }
                case EVENT_SLIME_SPRAY:
                {
                    AddSpellToCast(SPELL_SLIME_SPRAY, CAST_NULL);
                    events.ScheduleEvent(EVENT_SLIME_SPRAY, 15000);
                    break;
                }
                case EVENT_MUTATING_INFECTION:
                {
                    AddSpellToCast(SPELL_MUTATING_INFECTION, CAST_RANDOM_WITHOUT_TANK);
                    events.ScheduleEvent(EVENT_MUTATING_INFECTION, urand(18000, 22000));
                    break;
                }
                case EVENT_ENRAGE:
                {
                    AddSpellToCast(SPELL_ENRAGES, CAST_SELF);
                    break;
                }
                default:
                    break;
            }
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_grobbulus(Creature *_Creature)
{
    return new boss_grobbulusAI (_Creature);
}

void AddSC_boss_grobbulus()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_grobbulus";
    newscript->GetAI = &GetAI_boss_grobbulus;
    newscript->RegisterSelf();
}
