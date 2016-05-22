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
SDName: Boss_Gluth
SD%Complete: ??
SDComment: ??
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

#define ZOMBIE_CHOW_ID  16360

enum GluthSpells
{
    SPELL_MORTALWOUND           = 25646,
    SPELL_DECIMATE              = 28374,
    SPELL_DECIMATE2             = 28375,
    SPELL_TERRIFYING_ROAR       = 29685,
    SPELL_FRENZY                = 19812,
    SPELL_ZOMBIE_CHOW_SEARCH    = 28404, //28239,    // 28404?
    SPELL_ENRAGE                = 28747
};

enum GluthEvents
{
    EVENT_MORTALWOUND       = 1,
    EVENT_DECIMATE          = 2,
    EVENT_TERRIFYING_ROAR   = 3,
    EVENT_FRENZY            = 4,
    EVENT_ZOMBIES           = 5,
    EVENT_EAT_ZOMBIES       = 6,
    EVENT_ENRAGE            = 7
};

float GluthAddPos[9][3] = {
        {3269.590, -3161.287, 297.423},
        {3277.797, -3170.352, 297.423},
        {3267.049, -3172.820, 297.423},
        {3252.157, -3132.135, 297.423},
        {3259.990, -3126.590, 297.423},
        {3259.815, -3137.576, 297.423},
        {3308.030, -3132.135, 297.423},
        {3303.046, -3180.682, 297.423},
        {3313.283, -3180.766, 297.423}};

struct boss_gluthAI : public BossAI
{
    boss_gluthAI(Creature *c) : BossAI(c, DATA_GLUTH) { }

    void Reset()
    {
        events.Reset();
        events.ScheduleEvent(EVENT_MORTALWOUND, 8000);
        events.ScheduleEvent(EVENT_DECIMATE, 105000);
        events.ScheduleEvent(EVENT_TERRIFYING_ROAR, 21000);
        events.ScheduleEvent(EVENT_FRENZY, 15000);
        events.ScheduleEvent(EVENT_ZOMBIES, 10000);
        events.ScheduleEvent(EVENT_EAT_ZOMBIES, 12000);
        events.ScheduleEvent(EVENT_ENRAGE, 315000);

        instance->SetData(DATA_GLUTH, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        instance->SetData(DATA_GLUTH, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        instance->SetData(DATA_GLUTH, DONE);
    }

    void KilledUnit(Unit * unit)
    {
        if (m_creature->isAlive() && unit->GetTypeId() == TYPEID_UNIT && unit->GetEntry() == ZOMBIE_CHOW_ID)
            m_creature->ModifyHealth(m_creature->GetMaxHealth()*0.05);  // if zombie was eaten grow hp by 5%
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
                case EVENT_MORTALWOUND:
                {
                    AddSpellToCast(me->getVictim(), SPELL_MORTALWOUND);
                    events.ScheduleEvent(EVENT_MORTALWOUND, 10000);
                    break;
                }
                case EVENT_DECIMATE:
                {
                    AddSpellToCast(SPELL_DECIMATE, CAST_NULL);
                    AddSpellToCast(SPELL_DECIMATE2, CAST_NULL);
                    events.ScheduleEvent(EVENT_DECIMATE, urand(100000, 110000));
                    break;
                }
                case EVENT_TERRIFYING_ROAR:
                {
                    AddSpellToCast(SPELL_TERRIFYING_ROAR, CAST_NULL);
                    events.ScheduleEvent(EVENT_TERRIFYING_ROAR, 20000);
                    break;
                }
                case EVENT_FRENZY:
                {
                    AddSpellToCast(SPELL_FRENZY, CAST_SELF);
                    events.ScheduleEvent(EVENT_FRENZY, 10000);
                    break;
                }
                case EVENT_ZOMBIES:
                {
                    for (uint8 i = 0; i < 9; ++i)
                    {
                        if (Creature* SummonedZombies = m_creature->SummonCreature(ZOMBIE_CHOW_ID, GluthAddPos[i][0], GluthAddPos[i][1], GluthAddPos[i][2], 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 80000))
                        {
                            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                                SummonedZombies->AI()->AttackStart(target);
                        }
                    }

                    events.ScheduleEvent(EVENT_ZOMBIES, 10000);
                    break;
                }
                case EVENT_EAT_ZOMBIES:
                {
                    AddSpellToCast(SPELL_ZOMBIE_CHOW_SEARCH, CAST_NULL);
                    events.ScheduleEvent(EVENT_EAT_ZOMBIES, 2000);
                    break;
                }
                case EVENT_ENRAGE:
                {
                    AddSpellToCast(SPELL_ENRAGE, CAST_SELF);
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

CreatureAI* GetAI_boss_gluth(Creature *_Creature)
{
    return new boss_gluthAI (_Creature);
}

void AddSC_boss_gluth()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_gluth";
    newscript->GetAI = &GetAI_boss_gluth;
    newscript->RegisterSelf();
}
