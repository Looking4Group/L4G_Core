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
SDName: Boss_Sapphiron
SD%Complete: ??
SDComment:
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

enum SapphironTexts
{
    EMOTE_BREATH            = -1533082,
    EMOTE_ENRAGE            = -1533083
};

enum SapphironSpells
{
    SPELL_ICEBOLT           = 28522,
    SPELL_FROST_BREATH      = 29318,
    SPELL_FROST_AURA        = 28531,
    SPELL_LIFE_DRAIN        = 28542,
    SPELL_BLIZZARD          = 28547,
    SPELL_BERSERK           = 26662
};

enum SapphironEvents
{
    EVENT_ICE_BOLT          = 1,
    EVENT_FROST_BREATH      = 2,
    EVENT_LIFE_DRAIN        = 3,
    EVENT_BLIZZARD          = 4,
    EVENT_BERSERK           = 5,
    EVENT_PHASE_2           = 6,
    EVENT_PHASE_1           = 7
};

enum SapphironPhase
{
    SAPPHIRON_GROUND_PHASE  = 1,
    SAPPHIRON_AIR_PHASE     = 2
};

struct boss_sapphironAI : public BossAI
{
    boss_sapphironAI(Creature* c) : BossAI(c, DATA_SAPPHIRON) { }

    uint32 iceboltCount;
    bool berserk;

    SapphironPhase phase;

    void Reset()
    {
        phase = SAPPHIRON_GROUND_PHASE;
        events.Reset();
        events.ScheduleEvent(EVENT_LIFE_DRAIN, 24000);
        events.ScheduleEvent(EVENT_BLIZZARD, 20000);
        events.ScheduleEvent(EVENT_PHASE_2, 45000);

        iceboltCount = 0;
        berserk = false;

        m_creature->SetLevitate(false);

        instance->SetData(DATA_SAPPHIRON, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        instance->SetData(DATA_SAPPHIRON, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        instance->SetData(DATA_SAPPHIRON, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVERYTHING, 120.0f);

        events.Update(diff);
        uint32 eventId;
        while (eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ICE_BOLT:
                {
                    AddSpellToCast(SPELL_ICEBOLT, CAST_RANDOM);

                    if (++iceboltCount < 5)
                        events.ScheduleEvent(EVENT_ICE_BOLT, 4000);
                    else
                        events.ScheduleEvent(EVENT_FROST_BREATH, 2000);

                    break;
                }
                case EVENT_FROST_BREATH:
                {
                    AddSpellToCastWithScriptText(SPELL_FROST_BREATH, CAST_SELF, EMOTE_BREATH);
                    events.ScheduleEvent(EVENT_PHASE_1, 2000);
                    break;
                }
                case EVENT_LIFE_DRAIN:
                {
                    AddSpellToCast(SPELL_LIFE_DRAIN, CAST_RANDOM);
                    events.ScheduleEvent(EVENT_LIFE_DRAIN, 24000);
                    break;
                }
                case EVENT_BLIZZARD:
                {
                    AddSpellToCast(SPELL_BLIZZARD, CAST_SELF);
                    events.ScheduleEvent(EVENT_BLIZZARD, 20000);
                    break;
                }
                case EVENT_PHASE_2:
                {
                    if (HealthBelowPct(10))
                        break;

                    iceboltCount = 0;
                    phase = SAPPHIRON_AIR_PHASE;
                    events.CancelEvent(EVENT_BLIZZARD);
                    events.CancelEvent(EVENT_LIFE_DRAIN);
                    events.ScheduleEvent(EVENT_ICE_BOLT, 4000);

                    m_creature->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                    m_creature->SetLevitate(true);
                    m_creature->GetMotionMaster()->Clear(false);
                    m_creature->GetMotionMaster()->MoveIdle();

                    break;
                }
                case EVENT_PHASE_1:
                {
                    phase = SAPPHIRON_GROUND_PHASE;
                    events.ScheduleEvent(EVENT_BLIZZARD, urand(10000, 20000));
                    events.ScheduleEvent(EVENT_LIFE_DRAIN, urand(12000, 24000));
                    events.ScheduleEvent(EVENT_PHASE_2, 67000);

                    m_creature->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    m_creature->SetLevitate(false);
                    m_creature->GetMotionMaster()->Clear(false);
                    m_creature->GetMotionMaster()->MoveChase(m_creature->getVictim());

                    break;
                }
            }
        }

        if (!berserk && HealthBelowPct(10))
        {
            berserk = true;
            ForceSpellCastWithScriptText(SPELL_BERSERK, CAST_SELF, EMOTE_ENRAGE);
        }

        CastNextSpellIfAnyAndReady();

        if (phase == SAPPHIRON_GROUND_PHASE)
            DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_sapphiron(Creature *_Creature)
{
    return new boss_sapphironAI (_Creature);
}

void AddSC_boss_sapphiron()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_sapphiron";
    newscript->GetAI = &GetAI_boss_sapphiron;
    newscript->RegisterSelf();
}
