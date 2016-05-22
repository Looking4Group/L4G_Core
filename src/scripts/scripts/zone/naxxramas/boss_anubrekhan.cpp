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
SDName: Boss_Anubrekhan
SD%Complete: 70
SDComment:
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

enum AnubTexts
{
    SAY_GREET           = -1533000,
    SAY_AGGRO1          = -1533001,
    SAY_AGGRO2          = -1533002,
    SAY_AGGRO3          = -1533003,
    SAY_TAUNT1          = -1533004,
    SAY_TAUNT2          = -1533005,
    SAY_TAUNT3          = -1533006,
    SAY_TAUNT4          = -1533007,
    SAY_SLAY            = -1533008
};

enum AnubSpells
{
    SPELL_IMPALE        = 28783,        // May be wrong spell id. Causes more dmg than I expect
    SPELL_LOCUSTSWARM   = 28785,        // This is a self buff that triggers the dmg debuff

    // invalid ?
    SPELL_SUMMONGUARD   = 29508,        // Summons 1 crypt guard at targeted location
    SPELL_SELF_SPAWN_10 = 28864         // This is used by the crypt guards when they die
};

enum AnubEvents
{
    EVENT_IMPALE    = 1,
    EVENT_SWARM     = 2,
    EVENT_SUMMON    = 3,
};

struct boss_anubrekhanAI : public BossAI
{
    boss_anubrekhanAI(Creature *c) : BossAI(c, DATA_ANUB_REKHAN) { }

    bool greeted;

    void Reset()
    {
        greeted = false;
        uint32 tmpSwarmTimer = urand(80000, 120000);

        events.Reset();
        events.ScheduleEvent(EVENT_IMPALE, 15000);
        events.ScheduleEvent(EVENT_SWARM, tmpSwarmTimer);
        events.ScheduleEvent(EVENT_SUMMON, tmpSwarmTimer + 45000);  //45 seconds after initial locust swarm

        instance->SetData(DATA_ANUB_REKHAN, NOT_STARTED);
    }

    void KilledUnit(Unit* Victim)
    {
        if (roll_chance_f(20.0f))
            DoScriptText(SAY_SLAY, m_creature);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), m_creature);
        instance->SetData(DATA_ANUB_REKHAN, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        instance->SetData(DATA_ANUB_REKHAN, DONE);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (!greeted && m_creature->IsWithinDistInMap(who, 60.0f))
        {
            DoScriptText(RAND(SAY_GREET, SAY_TAUNT1, SAY_TAUNT2, SAY_TAUNT3, SAY_TAUNT4), m_creature);
            greeted = true;
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVERYTHING, 120.0f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_IMPALE:
                {
                    //Cast Impale on a random target
                    //Do NOT cast it when we are afflicted by locust swarm
                    if (!m_creature->HasAura(SPELL_LOCUSTSWARM,1))
                        AddSpellToCast(SPELL_IMPALE, CAST_RANDOM);

                    events.ScheduleEvent(EVENT_IMPALE, 15000);
                    break;
                }
                case EVENT_SWARM:
                {
                    AddSpellToCast(SPELL_LOCUSTSWARM, CAST_SELF);
                    events.ScheduleEvent(EVENT_SWARM, 90000);
                    break;
                }
                case EVENT_SUMMON:
                {
                    AddSpellToCast(SPELL_SUMMONGUARD, CAST_SELF);
                    events.ScheduleEvent(EVENT_SUMMON, 45000);
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

CreatureAI* GetAI_boss_anubrekhan(Creature *_Creature)
{
    return new boss_anubrekhanAI (_Creature);
}

void AddSC_boss_anubrekhan()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_anubrekhan";
    newscript->GetAI = &GetAI_boss_anubrekhan;
    newscript->RegisterSelf();
}
