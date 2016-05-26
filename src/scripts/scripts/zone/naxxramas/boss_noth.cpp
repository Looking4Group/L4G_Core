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
SDName: Boss_Noth
SD%Complete: 40
SDComment: Missing Balcony stage !
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

#define SOUND_DEATH         8848

#define BALCONY_LOC 2631.370, -3529.680, 274.040, 6.277

enum NothSummmonIds
{
    PLAGUED_WARRIOR         = 16984,
    PLAGUED_CHAMPION        = 16983,
    PLAGUED_GUARDIAN        = 16981
};

enum NothTexts
{
    SAY_AGGRO1              = -1533075,
    SAY_AGGRO2              = -1533076,
    SAY_AGGRO3              = -1533077,
    SAY_SUMMON              = -1533078,
    SAY_SLAY1               = -1533079,
    SAY_SLAY2               = -1533080,
    SAY_DEATH               = -1533081
};

enum NothSpells
{
    SPELL_BLINK                     = 29211,    //29208, 29209 and 29210 too
    SPELL_CRIPPLE                   = 29212,
    SPELL_CURSE_PLAGUEBRINGER       = 29213
};

enum NothEvents
{
    EVENT_BLINK             = 1,
    EVENT_CURSE             = 2,
    EVENT_SKELETONS         = 3,
    EVENT_TELEPORT_1        = 4,
    EVENT_TELEPORT_2        = 5,
    EVENT_TELEPORT_3        = 6,
    EVENT_SUMMON_1          = 7,
    EVENT_SUMMON_2          = 8,

    EVENT_TELEPORT_BACK     = 9
};

enum NothPhases
{
    NOTH_PHASE_NORMAL       = 1,
    NOTH_PHASE_BALCONY      = 2
};

const float NothSummonLocations[3][4] =
{
    { 2724.83, -3526.62, 261.96, 3.00 },
    { 2716.68, -3463.05, 262.05, 4.14 },
    { 2646.88, -3461.90, 263.53, 5.28 }
};

struct boss_nothAI : public BossAI
{
    boss_nothAI(Creature *c) : BossAI(c, DATA_NOTH_THE_PLAGUEBRINGER) { }

    uint32 Blink_Timer;
    uint32 Curse_Timer;
    uint32 Summon_Timer;
    uint32 tpCount;
    bool checkSummons;

    void Reset()
    {
        events.Reset();
        // phase normal spells
        events.ScheduleEvent(EVENT_BLINK, 25000, 0, NOTH_PHASE_NORMAL);
        events.ScheduleEvent(EVENT_CURSE, 4000, 0, NOTH_PHASE_NORMAL);
        events.ScheduleEvent(EVENT_SKELETONS, 12000, 0, NOTH_PHASE_NORMAL);

        // not phased spells
        events.ScheduleEvent(EVENT_TELEPORT_1, 90000);                      // 90 s after pull
        events.ScheduleEvent(EVENT_TELEPORT_2, 90000 + 110000);             // 110 s after first tp
        events.ScheduleEvent(EVENT_TELEPORT_3, 90000 + 110000 + 180000);    // 180 s after second tp

        events.SetPhase(NOTH_PHASE_NORMAL);

        tpCount = 0;
        instance->SetData(DATA_NOTH_THE_PLAGUEBRINGER, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), m_creature);
        instance->SetData(DATA_NOTH_THE_PLAGUEBRINGER, IN_PROGRESS);
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2), m_creature);
    }

    void JustSummoned(Creature* summoned)
    {
        summoned->AI()->DoZoneInCombat();
        if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0))
            summoned->AI()->AttackStart(target);

        if (summoned->GetEntry() != PLAGUED_WARRIOR)
            BossAI::JustSummoned(summoned);
    }

    void SummonedCreatureDespawn(Creature * summoned)
    {
        BossAI::SummonedCreatureDespawn(summoned);

        // if all summons was killed we should teleport back
        if (checkSummons && m_creature->isAlive() && events.GetPhase() == NOTH_PHASE_BALCONY && summons.isEmpty())
            events.RescheduleEvent(EVENT_TELEPORT_BACK, 1000, 0, NOTH_PHASE_BALCONY);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, m_creature);
        instance->SetData(DATA_NOTH_THE_PLAGUEBRINGER, DONE);
    }

    void SummonAdds()
    {
        int champCount = 0;

        if (tpCount == 1)
            champCount = 3;
        else if (tpCount == 2)
            champCount = 2;

        int guardCount = 3 - champCount;

        for (int i = 0; i < champCount; ++i)
            m_creature->SummonCreature(PLAGUED_CHAMPION, NothSummonLocations[i][0], NothSummonLocations[i][1], NothSummonLocations[i][2], NothSummonLocations[i][3], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);

        for (int i = 0; i < guardCount; ++i)
            m_creature->SummonCreature(PLAGUED_GUARDIAN, NothSummonLocations[3-i][0], NothSummonLocations[3-i][1], NothSummonLocations[3-i][2], NothSummonLocations[3-i][3], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
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
                case EVENT_BLINK:
                {
                    AddSpellToCast(SPELL_CRIPPLE, CAST_NULL);
                    AddSpellToCast(SPELL_BLINK, CAST_SELF);
                    events.ScheduleEvent(EVENT_BLINK, 25000, 0, NOTH_PHASE_NORMAL);
                    break;
                }
                case EVENT_CURSE:
                {
                    AddSpellToCast(SPELL_CURSE_PLAGUEBRINGER, CAST_NULL);
                    events.ScheduleEvent(EVENT_CURSE, urand(10000, 20000), 0, NOTH_PHASE_NORMAL);
                    break;
                }
                case EVENT_SKELETONS:
                {
                    DoScriptText(SAY_SUMMON, m_creature);

                    for (uint8 i = 0; i < 6; ++i)
                        m_creature->SummonCreature(PLAGUED_WARRIOR, NothSummonLocations[i%3][0], NothSummonLocations[i%3][1], NothSummonLocations[i%3][2], NothSummonLocations[i%3][3], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);

                    events.ScheduleEvent(EVENT_SKELETONS, 30000, 0, NOTH_PHASE_NORMAL);
                    break;
                }
                case EVENT_TELEPORT_1:
                {
                    events.RescheduleEvent(EVENT_TELEPORT_BACK, 70000, 0, NOTH_PHASE_BALCONY);
                }
                case EVENT_TELEPORT_2:
                {
                    if (eventId == EVENT_TELEPORT_2)
                        events.RescheduleEvent(EVENT_TELEPORT_BACK, 90000, 0, NOTH_PHASE_BALCONY);
                }
                case EVENT_TELEPORT_3:
                {
                    if (eventId == EVENT_TELEPORT_3)
                        events.RescheduleEvent(EVENT_TELEPORT_BACK, 110000, 0, NOTH_PHASE_BALCONY);  // guessed

                    m_creature->NearTeleportTo(BALCONY_LOC);
                    events.ScheduleEvent(EVENT_SUMMON_1, 2000, 0, NOTH_PHASE_BALCONY);
                    events.SetPhase(NOTH_PHASE_BALCONY);
                    m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

                    ++tpCount;
                    break;
                }
                case EVENT_SUMMON_1:
                {
                    SummonAdds();
                    events.ScheduleEvent(EVENT_SUMMON_2, 25000, 0, NOTH_PHASE_BALCONY);
                    break;
                }
                case EVENT_SUMMON_2:
                {
                    SummonAdds();
                    checkSummons = true;
                    break;
                }
                case EVENT_TELEPORT_BACK:
                {
                    WorldLocation home = m_creature->GetHomePosition();
                    m_creature->NearTeleportTo(home.coord_x, home.coord_y, home.coord_z, home.orientation);
                    // guessed
                    events.RescheduleEvent(EVENT_BLINK, 2000, 0, NOTH_PHASE_NORMAL);
                    events.RescheduleEvent(EVENT_CURSE, 4000, 0, NOTH_PHASE_NORMAL);
                    events.RescheduleEvent(EVENT_SKELETONS, 15000, 0, NOTH_PHASE_NORMAL);
                    events.SetPhase(NOTH_PHASE_NORMAL);
                    checkSummons = false;

                    m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
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

CreatureAI* GetAI_boss_noth(Creature *_Creature)
{
    return new boss_nothAI (_Creature);
}

void AddSC_boss_noth()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_noth";
    newscript->GetAI = &GetAI_boss_noth;
    newscript->RegisterSelf();
}
