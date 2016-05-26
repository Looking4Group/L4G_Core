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
SDName: Boss_Loatheb
SD%Complete: 100?
SDComment:
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

enum LoathebTexts
{
    SAY_AGGRO_1     = -1533200,
    SAY_AGGRO_2     = -1533201,
    SAY_AGGRO_3     = -1533202,
    SAY_SLAY_1      = -1533203,
    SAY_SLAY_2      = -1533204,
    SAY_SLAY_3      = -1533205,
    SAY_SLAY_4      = -1533206,
    SAY_SLAY_5      = -1533207,
    SAY_SLAY_6      = -1533208,
    SAY_DEATH       = -1533209
};

enum LoathebSpells
{
    SPELL_CORRUPTED_MIND        = 29198,
    SPELL_POISON_AURA           = 29865,
    SPELL_INEVITABLE_DOOM       = 29204,
    SPELL_REMOVE_CURSE          = 30281
};

enum LoathebEvents
{
    EVENT_CORRUPTED_MIND        = 1,
    EVENT_POISON_AURA           = 2,
    EVENT_INEVITABLE_DOOM_5MIN  = 3,
    EVENT_INEVITABLE_DOOM       = 4,
    EVENT_REMOVE_CURSE          = 5,
    EVENT_SUMMON_SPORE          = 6
};

float SporesLocations[3][3] = {
        {2957.040, -3997.590, 274.280},
        {2909.130, -4042.970, 274.280},
        {2861.102, -3997.901, 274.280}};

struct boss_loathebAI : public BossAI
{
    boss_loathebAI(Creature *c) : BossAI(c, DATA_LOATHEB) { }

    uint32 inevitableTimer;

    void Reset()
    {
        events.Reset();
        events.ScheduleEvent(EVENT_CORRUPTED_MIND, 4000);
        events.ScheduleEvent(EVENT_POISON_AURA, 2500);
        events.ScheduleEvent(EVENT_INEVITABLE_DOOM_5MIN, 300000);
        events.ScheduleEvent(EVENT_INEVITABLE_DOOM, 120000);
        events.ScheduleEvent(EVENT_REMOVE_CURSE, 2000);
        events.ScheduleEvent(EVENT_SUMMON_SPORE, 12000);

        inevitableTimer = 30000;
        instance->SetData(DATA_LOATHEB, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO_1, SAY_AGGRO_2, SAY_AGGRO_3), me);
        instance->SetData(DATA_LOATHEB, IN_PROGRESS);
    }

    void KilledUnit(Unit* victim)
    {
        if (roll_chance_f(20.0f))
            DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2, SAY_SLAY_3, SAY_SLAY_4, SAY_SLAY_5, SAY_SLAY_6), me);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, me);
        instance->SetData(DATA_LOATHEB, DONE);
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
                case EVENT_CORRUPTED_MIND:
                {
                    AddSpellToCast(SPELL_CORRUPTED_MIND, CAST_NULL);
                    events.ScheduleEvent(EVENT_CORRUPTED_MIND, 62000);
                    break;
                }
                case EVENT_POISON_AURA:
                {
                    AddSpellToCast(SPELL_POISON_AURA, CAST_NULL);
                    events.ScheduleEvent(EVENT_POISON_AURA, 12000);
                    break;
                }
                case EVENT_INEVITABLE_DOOM_5MIN:
                {
                    inevitableTimer = 15000;
                    break;
                }
                case EVENT_INEVITABLE_DOOM:
                {
                    AddSpellToCast(SPELL_INEVITABLE_DOOM, CAST_NULL);
                    events.ScheduleEvent(EVENT_INEVITABLE_DOOM, inevitableTimer);
                    break;
                }
                case EVENT_REMOVE_CURSE:
                {
                    AddSpellToCast(SPELL_REMOVE_CURSE, CAST_SELF);
                    events.ScheduleEvent(EVENT_REMOVE_CURSE, 30000);
                    break;
                }
                case EVENT_SUMMON_SPORE:
                {
                    for (uint8 i = 0; i < 3; ++i)
                        m_creature->SummonCreature(16286, SporesLocations[i][0], SporesLocations[i][1], SporesLocations[i][2], 0, TEMPSUMMON_TIMED_DESPAWN, 12000);
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

CreatureAI* GetAI_boss_loatheb(Creature *_Creature)
{
    return new boss_loathebAI (_Creature);
}

void AddSC_boss_loatheb()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_loatheb";
    newscript->GetAI = &GetAI_boss_loatheb;
    newscript->RegisterSelf();
}
