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
SDName: boss_illidan_stormrage
SD%Complete: 90
SDComment: Somewhat of a workaround for Parasitic Shadowfiend, unable to summon GOs for Cage Trap.
SDCategory: Black Temple
EndScriptData */

#include "precompiled.h"
#include "def_black_temple.h"

/************* Quotes and Sounds ***********************/
// Gossip for when a player clicks Akama
#define GOSSIP_ITEM           "We are ready to face Illidan"


// Yells for/by Akama
#define SAY_AKAMA_BEWARE      -1999988

// I think I'll fly now and let my subordinates take you on
#define SAY_SUMMONFLAMES      -1999994

#define SPELL_SHADOWFIEND_PASSIVE       41913 // Passive aura for shadowfiends

// Other defines
#define CENTER_X            676.740
#define CENTER_Y            305.297
#define CENTER_Z            354.519

#define SPELL_CAGED                     40695 // Caged Trap triggers will cast this on Illidan if he is within 3 yards

struct Locations
{
    float x, y, z;
};

static Locations HoverPosition[]=
{
    {657, 340, 354.519f},
    {657, 275, 354.519f},
    {705, 275, 354.519f},
    {705, 340, 354.519f}
};

static Locations GlaivePosition[]=
{
    {676.226f, 325.230f, 354.319f},
    {678.059f, 285.220f, 354.319f}
};

static Locations EyeBlast[]=
{
    {640.839f, 276.951f, 354.519f},
    {638.110f, 306.876f, 354.519f},
    {710.786f, 266.433f, 354.519f},
    {711.203f, 343.015f, 354.519f},
    {711.649f, 267.606f, 354.519f}
};

enum IllidanPhase
{
    PHASE_NULL    = 0,
    PHASE_ONE     = 1,
    PHASE_TWO     = 2,
    PHASE_THREE   = 3,
    PHASE_FOUR    = 4,
    PHASE_FIVE    = 5,
    PHASE_MAIEV   = 6,
    PHASE_DEATH   = 7
};

enum IllidanSpell
{
    SPELL_ILLIDAN_DUAL_WIELD             = 42459,
    SPELL_ILLIDAN_KNEEL_INTRO            = 39656,

    // Phase 1 spells
    SPELL_ILLIDAN_SHEAR                  = 41032, // proper
    SPELL_ILLIDAN_DRAW_SOUL              = 40904, // need to implement scripteffect
    SPELL_ILLIDAN_FLAME_CRASH            = 40832,
    SPELL_ILLIDAN_PARASITIC_SHADOWFIEND  = 41917,

    // Phase 3 spells
    SPELL_ILLIDAN_AGONIZING_FLAMES       = 40932,

    // Phase 5 spells
    SPELL_ILLIDAN_ENRAGE                 = 40683,

    // Phase 2 spells
    SPELL_ILLIDAN_THROW_GLAIVE           = 39849,
    SPELL_ILLIDAN_GLAIVE_RETURN          = 39873,
    SPELL_ILLIDAN_FIREBALL               = 40598,
    SPELL_ILLIDAN_DARK_BARRAGE           = 40585,
    SPELL_ILLIDAN_EYE_BLAST              = 39908,

    // Phase 4 spells
    SPELL_ILLIDAN_DEMON_TRANSFORM_1      = 40511,
    SPELL_ILLIDAN_DEMON_TRANSFORM_2      = 40398,
    SPELL_ILLIDAN_DEMON_TRANSFORM_3      = 40510,
    SPELL_ILLIDAN_DEMON_FORM             = 40506,
    SPELL_ILLIDAN_SHADOW_BLAST           = 41078,
    SPELL_ILLIDAN_FLAME_BURST            = 41126,
    SPELL_ILLIDAN_SHADOW_DEMON           = 41120,
    SPELL_ILLIDAN_SHADOW_DEMON_CAST      = 41117,

    SPELL_ILLIDAN_INPRISON_RAID          = 40647,
    SPELL_ILLIDAN_SUMMON_MAIEV           = 40403,

    SPELL_ILLIDAN_HARD_ENRAGE            = 45078,

    SPELL_ILLIDAN_DEATH_OUTRO            = 41220
};

enum IllidanEvent
{
    EVENT_ILLIDAN_START                  = 1,
    EVENT_ILLIDAN_CHANGE_PHASE           = 2,
    EVENT_ILLIDAN_SUMMON_MINIONS         = 3,

    // Phase 1,3,5 events
    EVENT_ILLIDAN_SHEAR                  = 5,
    EVENT_ILLIDAN_DRAW_SOUL              = 6,
    EVENT_ILLIDAN_FLAME_CRASH            = 7,
    EVENT_ILLIDAN_PARASITIC_SHADOWFIEND  = 8,

    EVENT_ILLIDAN_AGONIZING_FLAMES       = 9,
    EVENT_ILLIDAN_SOFT_ENRAGE            = 10,

    // Phase 2 events
    EVENT_ILLIDAN_THROW_GLAIVE           = 11,
    EVENT_ILLIDAN_EYE_BLAST              = 12,
    EVENT_ILLIDAN_DARK_BARRAGE           = 13,
    EVENT_ILLIDAN_SUMMON_TEAR            = 14,
    EVENT_ILLIDAN_RETURN_GLAIVE          = 15,
    EVENT_ILLIDAN_LAND                   = 16,

    EVENT_ILLIDAN_TRANSFORM_NO1          = 17,
    EVENT_ILLIDAN_TRANSFORM_NO2          = 18,
    EVENT_ILLIDAN_TRANSFORM_NO3          = 19,
    EVENT_ILLIDAN_TRANSFORM_NO4          = 20,
    EVENT_ILLIDAN_TRANSFORM_NO5          = 21,
    EVENT_ILLIDAN_FLAME_BURST            = 22,
    EVENT_ILLIDAN_SHADOW_DEMON           = 23,
    EVENT_ILLIDAN_TRANSFORM_BACKNO1      = 24,
    EVENT_ILLIDAN_TRANSFORM_BACKNO2      = 25,
    EVENT_ILLIDAN_TRANSFORM_BACKNO3      = 26,
    EVENT_ILLIDAN_TRANSFORM_BACKNO4      = 27,

    // Phase: Maiev summon
    EVENT_ILLIDAN_SUMMON_MAIEV           = 28,
    EVENT_ILLIDAN_INPRISON_RAID          = 29,
    EVENT_ILLIDAN_CAGE_TRAP              = 30,

    EVENT_ILLIDAN_KILL                   = 31,
    EVENT_ILLIDAN_DEATH_SPEECH           = 32,

    EVENT_ILLIDAN_FLAME_DEATH            = 33,

    EVENT_ILLIDAN_RANDOM_YELL
};

enum IllidanTexts
{
    YELL_ILLIDAN_AGGRO                   = -1529002,
    YELL_ILLIDAN_SUMMON_MINIONS          = -1999989,

    YELL_ILLIDAN_SLAIN                   = -1999991,
    YELL_ILLIDAN_SLAIN2                  = -1999992,

    YELL_ILLIDAN_PHASE_TWO               = -1999993,
    YELL_ILLIDAN_EYE_BLAST               = -1999995,
    YELL_ILLIDAN_DEMON_FORM              = -1999996,

    YELL_ILLIDAN_TAUNT_NO1               = -1529016,
    YELL_ILLIDAN_TAUNT_NO2               = -1529017,
    YELL_ILLIDAN_TAUNT_NO3               = -1529018,
    YELL_ILLIDAN_TAUNT_NO4               = -1529019,

    YELL_ILLIDAN_INPRISON_RAID           = -1529003,
    YELL_ILLIDAN_DEATH_SPEECH            = -1529009,
    YELL_ILLIDAN_HARD_ENRAGE             = -1999997
};

enum CreatureEntries
{
    BLADE_OF_AZZINOTH       =   22996,
    FLAME_OF_AZZINOTH       =   22997,
    GLAIVE_TARGET           =   23448,
    ILLIDARI_ELITE          =   23226,
    PARASITIC_SHADOWFIEND   =   23498,
    CAGE_TRAP_TRIGGER       =   23292
};

class GlaiveTargetRespawner
{
    public:
        GlaiveTargetRespawner() {}

        void operator()(Creature* u) const
        {
            if (u->GetEntry() == GLAIVE_TARGET)
                u->Respawn();
        }
        void operator()(GameObject* u) const { }
        void operator()(WorldObject*) const {}
        void operator()(Corpse*) const {}
};

struct boss_illidan_stormrageAI : public BossAI
{
    boss_illidan_stormrageAI(Creature* c) : BossAI(c, 1)
    {
        ForceSpellCast(me, SPELL_ILLIDAN_KNEEL_INTRO, INTERRUPT_AND_CAST_INSTANTLY);
    }

    uint8 m_flameCount;
    uint32 m_hoverPoint;

    uint32 m_combatTimer;
    uint32 m_enrageTimer;

    bool b_maievPhase;
    bool b_maievDone;

    IllidanPhase m_phase;

    void Reset()
    {
        events.Reset();
        ClearCastQueue();
        summons.DespawnAll();

        m_combatTimer = 1000;
        m_enrageTimer = 25*60000 +34000; // DBM value

        m_hoverPoint = 0;
        m_flameCount = 0;

        b_maievDone = false;
        b_maievPhase = false;

        m_phase = PHASE_NULL;

        SetWarglaivesEquipped(false);

        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        me->SetLevitate(false);
        me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
        me->SetSelection(0);

        instance->SetData(EVENT_ILLIDANSTORMRAGE, NOT_STARTED);
    }

    void SetWarglaivesEquipped(bool equip)
    {
        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, equip ? 45479 : 0);
        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY+1, equip ? 45481 : 0);
        me->SetByteValue(UNIT_FIELD_BYTES_2, 0, equip ? SHEATH_STATE_MELEE : SHEATH_STATE_UNARMED);
    }

    void ChangePhase(IllidanPhase phase)
    {
        StopAutocast();
        ClearCastQueue();
        events.CancelEventsByGCD(m_phase);

        me->SetWalk(false);

        switch (m_phase = phase)
        {
            case PHASE_FIVE:
            {
                events.ScheduleEvent(EVENT_ILLIDAN_SOFT_ENRAGE, 40000, m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_CAGE_TRAP, urand(25000, 32000), m_phase);
            }
            case PHASE_THREE:
            {
                events.ScheduleEvent(EVENT_ILLIDAN_AGONIZING_FLAMES, urand(28000, 35000), m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_CHANGE_PHASE, m_phase == PHASE_FIVE ? 60000 : urand(40000, 55000), m_phase);

                if (Creature *pMaiev = GetClosestCreatureWithEntry(me, 23197, 200.0f))
                    pMaiev->AI()->DoAction(4); // SET MELEE ATTACK TYPE
            }
            case PHASE_ONE:
            {
                events.ScheduleEvent(EVENT_ILLIDAN_SHEAR, 10000, m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_FLAME_CRASH, urand(25000, 35000), m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_DRAW_SOUL, urand(35000, 45000), m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_PARASITIC_SHADOWFIEND, 30000, m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_RANDOM_YELL, urand(32000, 35000), m_phase);

                SetWarglaivesEquipped(true);

                DoResetThreat();

                if (m_phase == PHASE_ONE)
                {
                    me->SetReactState(REACT_AGGRESSIVE);
                    instance->SetData(EVENT_ILLIDANSTORMRAGE, IN_PROGRESS);

                    me->setActive(true);

                    Map::PlayerList const &plList = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator i = plList.begin(); i != plList.end(); ++i)
                    {
                        if (Player* pPlayer = i->getSource())
                        {
                            if (pPlayer->isGameMaster())
                                continue;

                            if (pPlayer->isAlive() && me->IsWithinDistInMap(pPlayer, 150.0f))
                                me->AddThreat(pPlayer, 3000.0f);
                        }
                    }

                    ForceSpellCast(me, SPELL_ILLIDAN_DUAL_WIELD);
                    events.ScheduleEvent(EVENT_ILLIDAN_SUMMON_MINIONS, 1000, m_phase);
                }
                break;
            }
            case PHASE_TWO:
            {
                m_flameCount = 0;

                DoScriptText(YELL_ILLIDAN_PHASE_TWO, me);

                me->RemoveAllAuras();
                me->InterruptNonMeleeSpells(false);

                me->AttackStop();
                me->SetReactState(REACT_PASSIVE);

                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                me->SetLevitate(true);

                me->GetMotionMaster()->MovePoint(0, CENTER_X +5.0f, CENTER_Y, CENTER_Z, UNIT_ACTION_CONTROLLED);

                RespawnGlaiveTargets();

                SetAutocast(SPELL_ILLIDAN_FIREBALL, 3000, false, CAST_RANDOM, 0, true);

                events.ScheduleEvent(EVENT_ILLIDAN_THROW_GLAIVE, 15000, m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_THROW_GLAIVE, 16000, m_phase);

                events.ScheduleEvent(EVENT_ILLIDAN_SUMMON_TEAR, 17000, m_phase);

                events.ScheduleEvent(EVENT_ILLIDAN_EYE_BLAST, urand(30000, 40000), m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_DARK_BARRAGE, 80000, m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_CHANGE_PHASE, 2000, m_phase);
                break;
            }
            case PHASE_FOUR:
            {
                if (Creature *pMaiev = GetClosestCreatureWithEntry(me, 23197, 200.0f))
                    pMaiev->AI()->DoAction(4); // SET RANGE ATTACK TYPE

                SetAutocast(SPELL_ILLIDAN_SHADOW_BLAST, 3000, false, CAST_TANK);

                events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_NO1, 0, m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_FLAME_BURST, 20000, m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_SHADOW_DEMON, 30000, m_phase);
                break;
            }
            case PHASE_MAIEV:
            {
                b_maievPhase = false;

                me->AttackStop();
                me->SetReactState(REACT_PASSIVE);

                events.ScheduleEvent(EVENT_ILLIDAN_INPRISON_RAID, 500, m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_SUMMON_MAIEV, 6000, m_phase);
                break;
            }
            case PHASE_DEATH:
            {
                me->AttackStop();
                me->RemoveAllAuras();

                ForceSpellCast(me, SPELL_ILLIDAN_DEATH_OUTRO, INTERRUPT_AND_CAST_INSTANTLY);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                if (Creature *pMaiev = GetClosestCreatureWithEntry(me, 23197, 200.0f))
                {
                    pMaiev->AttackStop();
                    pMaiev->AI()->DoAction(7); // teleport to Illidan, and speech
                }

                events.ScheduleEvent(EVENT_ILLIDAN_DEATH_SPEECH, 6000, m_phase);
                break;
            }
        }
    }

    bool PhaseOneThreeFive()
    {
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ILLIDAN_SUMMON_MINIONS:
                {
                    if (HealthBelowPct(90.0f))
                    {
                        DoScriptText(YELL_ILLIDAN_SUMMON_MINIONS, me);

                        // Call back Akama to deal with minions
                        if (Creature *pAkama = instance->GetCreature(instance->GetData64(DATA_AKAMA)))
                        {
                            pAkama->AttackStop();
                            pAkama->DeleteThreatList();
                            pAkama->SetReactState(REACT_PASSIVE);

                            DoModifyThreatPercent(pAkama, -101);

                            if (me->getThreatManager().isThreatListEmpty())
                            {
                                me->AI()->EnterEvadeMode();
                                return false;
                            }

                            pAkama->AI()->DoAction(8); // EVENT_AKAMA_MINIONS_FIGHT
                        }
                    }
                    else
                        events.ScheduleEvent(EVENT_ILLIDAN_SUMMON_MINIONS, 1000, PHASE_ONE);

                    break;
                }
                case EVENT_ILLIDAN_CHANGE_PHASE:
                {
                    ChangePhase(PHASE_FOUR);
                    return false;
                }
                case EVENT_ILLIDAN_RANDOM_YELL:
                {
                    DoScriptText(RAND(YELL_ILLIDAN_TAUNT_NO1, YELL_ILLIDAN_TAUNT_NO2, YELL_ILLIDAN_TAUNT_NO3, YELL_ILLIDAN_TAUNT_NO4), me);
                    events.ScheduleEvent(EVENT_ILLIDAN_RANDOM_YELL, urand(30000, 35000));
                    break;
                }
                case EVENT_ILLIDAN_SHEAR:
                {
                    AddSpellToCast(me->getVictim(), SPELL_ILLIDAN_SHEAR);
                    events.ScheduleEvent(EVENT_ILLIDAN_SHEAR, 10000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_FLAME_CRASH:
                {
                    AddSpellToCast(me->getVictim(), SPELL_ILLIDAN_FLAME_CRASH);
                    events.ScheduleEvent(EVENT_ILLIDAN_FLAME_CRASH, urand(25000, 30000), m_phase);
                    break;
                }
                case EVENT_ILLIDAN_DRAW_SOUL:
                {
                    AddSpellToCast(me, SPELL_ILLIDAN_DRAW_SOUL);
                    events.ScheduleEvent(EVENT_ILLIDAN_DRAW_SOUL, urand(35000, 45000), m_phase);
                    break;
                }
                case EVENT_ILLIDAN_PARASITIC_SHADOWFIEND:
                {
                    if (Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 250.0f, true, me->getVictimGUID()))
                        AddSpellToCast(pTarget, SPELL_ILLIDAN_PARASITIC_SHADOWFIEND, false, true);

                    events.ScheduleEvent(EVENT_ILLIDAN_PARASITIC_SHADOWFIEND, 30000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_AGONIZING_FLAMES:
                {
                    if (Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0 , 250.0f, true, 0, 15.0f))
                        AddSpellToCast(pTarget, SPELL_ILLIDAN_AGONIZING_FLAMES, false, true);

                    events.ScheduleEvent(EVENT_ILLIDAN_AGONIZING_FLAMES, urand(30000, 35000), m_phase);
                    break;
                }
                case EVENT_ILLIDAN_SOFT_ENRAGE:
                {
                    ForceSpellCast(me, SPELL_ILLIDAN_ENRAGE);
                    break;
                }
                case EVENT_ILLIDAN_CAGE_TRAP:
                {
                    if (Creature *pMaiev = GetClosestCreatureWithEntry(me, 23197, 200.0f))
                        pMaiev->AI()->DoAction(5); // Force to place trap

                    events.ScheduleEvent(EVENT_ILLIDAN_CAGE_TRAP, urand(20000,30000), m_phase);
                    break;
                }
            }
        }
        return true;
    }

    void RespawnGlaiveTargets()
    {
        GlaiveTargetRespawner respawner;
        Looking4group::ObjectWorker<Creature, GlaiveTargetRespawner> worker(respawner);
        Cell::VisitGridObjects(me, worker, 200.0f);
    }

    void CastEyeBlast()
    {
        Locations initial = EyeBlast[urand(0,4)];
        if (Creature* pTrigger = me->SummonTrigger(initial.x, initial.y, initial.z, 0, 13000))
        {
            RespawnGlaiveTargets();

            if (Creature *pGlaive = GetClosestCreatureWithEntry(pTrigger, GLAIVE_TARGET, 70.0f, true))
            {
                WorldLocation final;
                pTrigger->GetNearPoint(final.coord_x, final.coord_y, final.coord_z, 80.0f, false, pTrigger->GetAngle(pGlaive));
                final.coord_z = 354.519f;
                pTrigger->SetSpeed(MOVE_RUN, 1.0f);
                pTrigger->GetMotionMaster()->MovePoint(0, final.coord_x, final.coord_y, final.coord_z, true, UNIT_ACTION_CONTROLLED);

                pTrigger->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

                m_hoverPoint = urand(0,3);
                me->GetMotionMaster()->MovePoint(1, HoverPosition[m_hoverPoint].x, HoverPosition[m_hoverPoint].y, HoverPosition[m_hoverPoint].z);

                ForceSpellCastWithScriptText(pTrigger, SPELL_ILLIDAN_EYE_BLAST, YELL_ILLIDAN_EYE_BLAST, INTERRUPT_AND_CAST_INSTANTLY, false, true);
            }
        }
    }

    bool PhaseTwo()
    {
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ILLIDAN_CHANGE_PHASE:
                {
                    if (m_flameCount >= 2)
                    {
                        StopAutocast();
                        me->GetMotionMaster()->MovePoint(0, CENTER_X, CENTER_Y, CENTER_Z);
                        events.ScheduleEvent(EVENT_ILLIDAN_RETURN_GLAIVE, 3000, m_phase);
                        break;
                    }

                    events.ScheduleEvent(EVENT_ILLIDAN_CHANGE_PHASE, 2000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_LAND:
                {
                    me->SetLevitate(false);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    me->SetReactState(REACT_AGGRESSIVE);
                    ChangePhase(PHASE_THREE);
                    break;
                }
                case EVENT_ILLIDAN_RETURN_GLAIVE:
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    summons.Cast(BLADE_OF_AZZINOTH, SPELL_ILLIDAN_GLAIVE_RETURN, me);
                    summons.DespawnEntry(BLADE_OF_AZZINOTH);
                    events.ScheduleEvent(EVENT_ILLIDAN_LAND, 1000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_THROW_GLAIVE:
                {
                    AddSpellToCast(SPELL_ILLIDAN_THROW_GLAIVE, CAST_NULL);

                    SetWarglaivesEquipped(false);
                    break;
                }
                case EVENT_ILLIDAN_SUMMON_TEAR:
                {
                    StartAutocast();
                    break;
                }
                case EVENT_ILLIDAN_EYE_BLAST:
                {
                    CastEyeBlast();
                    events.ScheduleEvent(EVENT_ILLIDAN_EYE_BLAST, urand(30000, 35000), m_phase);
                    break;
                }
                case EVENT_ILLIDAN_DARK_BARRAGE:
                {
                    if (Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 200.0f, true))
                        AddSpellToCast(pTarget, SPELL_ILLIDAN_DARK_BARRAGE);

                    events.ScheduleEvent(EVENT_ILLIDAN_DARK_BARRAGE, 44000, m_phase);
                    break;
                }
            }
        }
        return false;
    }

    bool PhaseFour()
    {
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ILLIDAN_TRANSFORM_NO1:
                {
                    me->GetMotionMaster()->Clear(false);

                    DoScriptText(YELL_ILLIDAN_DEMON_FORM, me);

                    ForceSpellCast(me, SPELL_ILLIDAN_DEMON_TRANSFORM_1, INTERRUPT_AND_CAST_INSTANTLY);
                    events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_NO2, 1300, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_TRANSFORM_NO2:
                {
                    me->RemoveAurasDueToSpell(SPELL_ILLIDAN_DEMON_TRANSFORM_1);
                    ForceSpellCast(me, SPELL_ILLIDAN_DEMON_TRANSFORM_2, INTERRUPT_AND_CAST_INSTANTLY);
                    events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_NO3, 4000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_TRANSFORM_NO3:
                {
                    DoResetThreat();
                    SetWarglaivesEquipped(false);

                    me->RemoveAurasDueToSpell(SPELL_ILLIDAN_DEMON_TRANSFORM_2);
                    ForceSpellCast(me, SPELL_ILLIDAN_DEMON_FORM, INTERRUPT_AND_CAST_INSTANTLY, true);
                    ForceSpellCast(me, SPELL_ILLIDAN_DEMON_TRANSFORM_2, INTERRUPT_AND_CAST_INSTANTLY);
                    events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_NO4, 3000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_TRANSFORM_NO4:
                {
                    StartAutocast();

                    me->RemoveAurasDueToSpell(SPELL_ILLIDAN_DEMON_TRANSFORM_2);
                    ForceSpellCast(me, SPELL_ILLIDAN_DEMON_TRANSFORM_3, INTERRUPT_AND_CAST_INSTANTLY);
                    events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_NO5, 3500, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_TRANSFORM_NO5:
                {
                    me->RemoveAurasDueToSpell(SPELL_ILLIDAN_DEMON_TRANSFORM_3);
                    events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_BACKNO1, 61000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_FLAME_BURST:
                {
                    AddSpellToCast(me, SPELL_ILLIDAN_FLAME_BURST);
                    events.ScheduleEvent(EVENT_ILLIDAN_FLAME_BURST, 20000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_SHADOW_DEMON:
                {
                    ForceSpellCast(me, SPELL_ILLIDAN_SHADOW_DEMON_CAST, INTERRUPT_AND_CAST_INSTANTLY);

                    for (uint8 i = 0; i < 4; i++)
                    {
                        // Yes we can have multiple demons assigned to one person, Tank shouldn't be excluded from search :]
                        if (Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 150.0f, true))
                            pTarget->CastSpell(me, SPELL_ILLIDAN_SHADOW_DEMON, true);
                    }
                    break;
                }
                case EVENT_ILLIDAN_TRANSFORM_BACKNO1:
                {
                    ClearCastQueue();
                    StopAutocast();
                    ForceSpellCast(me, SPELL_ILLIDAN_DEMON_TRANSFORM_1, INTERRUPT_AND_CAST_INSTANTLY);
                    events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_BACKNO2, 1500, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_TRANSFORM_BACKNO2:
                {
                    me->RemoveAurasDueToSpell(SPELL_ILLIDAN_DEMON_TRANSFORM_1);
                    ForceSpellCast(me, SPELL_ILLIDAN_DEMON_TRANSFORM_2, INTERRUPT_AND_CAST_INSTANTLY);
                    events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_BACKNO3, 4000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_TRANSFORM_BACKNO3:
                {
                    me->RemoveAurasDueToSpell(SPELL_ILLIDAN_DEMON_FORM);

                    SetWarglaivesEquipped(true);
                    events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_BACKNO4, 3000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_TRANSFORM_BACKNO4:
                {
                    me->RemoveAurasDueToSpell(SPELL_ILLIDAN_DEMON_TRANSFORM_2);
                    ForceSpellCast(me, SPELL_ILLIDAN_DEMON_TRANSFORM_3, INTERRUPT_AND_CAST_INSTANTLY);
                    events.ScheduleEvent(EVENT_ILLIDAN_CHANGE_PHASE, 3500, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_CHANGE_PHASE:
                {
                    if (b_maievPhase)
                    {
                        ChangePhase(PHASE_MAIEV);
                        break;
                    }

                    if (HealthBelowPct(30.0f))
                        ChangePhase(PHASE_FIVE);
                    else
                        ChangePhase(PHASE_THREE);

                    me->GetMotionMaster()->MoveChase(me->getVictim());
                    break;
                }
            }
        }
        return false;
    }

    bool PhaseMaiev()
    {
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ILLIDAN_INPRISON_RAID:
                {
                    ForceSpellCastWithScriptText(SPELL_ILLIDAN_INPRISON_RAID, CAST_SELF, YELL_ILLIDAN_INPRISON_RAID, INTERRUPT_AND_CAST_INSTANTLY, true);
                    break;
                }
                case EVENT_ILLIDAN_SUMMON_MAIEV:
                {
                    ForceSpellCast(me, SPELL_ILLIDAN_SUMMON_MAIEV);
                    break;
                }
            }
        }
        return false;
    }

    bool PhaseDeath()
    {
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ILLIDAN_DEATH_SPEECH:
                {
                    DoScriptText(YELL_ILLIDAN_DEATH_SPEECH, me);
                    events.ScheduleEvent(EVENT_ILLIDAN_KILL, 20000, m_phase);
                    break;
                }
                case EVENT_ILLIDAN_KILL:
                {
                    if (Creature *pAkama = instance->GetCreature(instance->GetData64(DATA_AKAMA)))
                        pAkama->AI()->DoAction(15);

                    me->Kill(me, false);
                    instance->SetData(EVENT_ILLIDANSTORMRAGE, DONE);
                    break;
                }
            }
        }
        return false;
    }

    bool HandlePhase(IllidanPhase m_phase)
    {
        switch(m_phase)
        {
            case PHASE_ONE:
            case PHASE_THREE:
            case PHASE_FIVE:
                return PhaseOneThreeFive();
            case PHASE_TWO:
                return PhaseTwo();
            case PHASE_FOUR:
                return PhaseFour();
            case PHASE_MAIEV:
                return PhaseMaiev();
            case PHASE_DEATH:
                return PhaseDeath();
            default:
                return true;
        }
    }

    void JustDied(Unit* killer)
    {
        summons.DespawnAll();
    }

    void KilledUnit(Unit *pWho)
    {
        if (pWho == me)
            return;

        DoScriptText(RAND(YELL_ILLIDAN_SLAIN, YELL_ILLIDAN_SLAIN2), me);
    }

    void AttackStart(Unit *pWho)
    {
        if (m_phase == PHASE_TWO || m_phase == PHASE_NULL)
            return;

        if (m_phase == PHASE_FOUR)
            ScriptedAI::AttackStartNoMove(pWho);
        else
            ScriptedAI::AttackStart(pWho);
    }

    void MoveInLineOfSight(Unit *pWho)
    {
        if (m_phase == PHASE_TWO || m_phase == PHASE_NULL)
            return;

        ScriptedAI::MoveInLineOfSight(pWho);
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (damage > me->GetHealth() && done_by != me)
        {
            damage = 0;
            if (m_phase != PHASE_DEATH)
                ChangePhase(PHASE_DEATH);
        }
    }

    void MovementInform(uint32 MovementType, uint32 uiData)
    {
        if (MovementType == POINT_MOTION_TYPE)
            me->setHover(true);
    }

    void EnterEvadeMode()
    {
        me->setActive(false);

        summons.DespawnAll();
        events.Reset();

        me->SetReactState(REACT_PASSIVE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        instance->SetData(EVENT_ILLIDANSTORMRAGE, NOT_STARTED);

        if (Creature *pAkama = instance->GetCreature(instance->GetData64(DATA_AKAMA)))
        {
            pAkama->AI()->EnterEvadeMode();
            pAkama->GetMotionMaster()->Clear(false); // need reset waypoint movegen, to test
            pAkama->AI()->Reset();
            pAkama->GetMotionMaster()->MoveTargetedHome();
        }

        BossAI::EnterEvadeMode();
    }

    void JustReachedHome()
    {
        ForceSpellCast(me, SPELL_ILLIDAN_KNEEL_INTRO, INTERRUPT_AND_CAST_INSTANTLY);
    }

    void JustRespawned()
    {
        ForceSpellCast(me, SPELL_ILLIDAN_KNEEL_INTRO, INTERRUPT_AND_CAST_INSTANTLY);
    }

    void OnAuraApply(Aura *aura, Unit *, bool stackApply)
    {
        if (aura->GetId() == 40695)
            events.RescheduleEvent(EVENT_ILLIDAN_CHANGE_PHASE, 15000, m_phase);
    }

    void DoAction(const int32 action)
    {
        switch (action)
        {
            case EVENT_ILLIDAN_START:
            {
                DoScriptText(YELL_ILLIDAN_AGGRO, me);
                me->SetReactState(REACT_AGGRESSIVE);

                me->RemoveAurasDueToSpell(SPELL_ILLIDAN_KNEEL_INTRO);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                ChangePhase(PHASE_ONE);
                break;
            }
            case EVENT_ILLIDAN_CHANGE_PHASE:
            {
                ChangePhase(PHASE_FIVE);
                break;
            }
            case EVENT_ILLIDAN_FLAME_DEATH:
            {
                m_flameCount++;
                break;
            }
        }
    }

    bool UpdateVictim()
    {
        switch (m_phase)
        {
            case PHASE_TWO:
            case PHASE_MAIEV:
            case PHASE_DEATH:
            {
                if (me->GetMap()->GetAlivePlayersCountExceptGMs() == 0)
                {
                    EnterEvadeMode();
                    return false;
                }
                return true;
            }
            default:
                return ScriptedAI::UpdateVictim();
        }
    }
   
    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVERYTHING, 200.0f, 2.5f);

        if (m_combatTimer < diff)
        {
            if (Creature *pAkama = instance->GetCreature(instance->GetData64(DATA_AKAMA)))
                DoModifyThreatPercent(pAkama, -101);

            if (Creature *pMaiev = GetClosestCreatureWithEntry(me, 23197, 200.0f))
                DoModifyThreatPercent(pMaiev, -101);

            m_combatTimer = 2000;
        }
        else
            m_combatTimer -= diff;

        if (m_enrageTimer < diff)
        {
            ForceSpellCastWithScriptText(me, SPELL_ILLIDAN_HARD_ENRAGE, YELL_ILLIDAN_HARD_ENRAGE, INTERRUPT_AND_CAST_INSTANTLY);
            m_enrageTimer = 25000;
        }
        else
            m_enrageTimer -= diff;

        if (m_phase == PHASE_ONE && HealthBelowPct(65.0f))
        {
            ChangePhase(PHASE_TWO);
            return;
        }

        if (!b_maievDone && HealthBelowPct(30.0f))
        {
            if (m_phase == PHASE_FOUR)
            {
                me->InterruptNonMeleeSpells(false);

                events.CancelEventsByGCD(m_phase);
                events.ScheduleEvent(EVENT_ILLIDAN_TRANSFORM_BACKNO1, 0, m_phase);
                b_maievPhase = true;
            }
            else
                ChangePhase(PHASE_MAIEV);

            b_maievDone = true;
        }

        events.Update(diff);
        if (HandlePhase(m_phase))
            DoMeleeAttackIfReady();

        CastNextSpellIfAnyAndReady(diff);
    }
};

static float SpiritSpawns[][4] =
{
    {23411, 755.5426, 309.9156, 312.2129},
    {23410, 755.5426, 298.7923, 312.0834}
};

//Akama spells
enum AkamaSpells
{
    SPELL_AKAMA_DOOR_CAST_SUCCESS = 41268,
    SPELL_AKAMA_DOOR_CAST_FAIL    = 41271,
    SPELL_DEATHSWORN_DOOR_CHANNEL = 41269,
    SPELL_AKAMA_POTION            = 40535,
    SPELL_AKAMA_CHAIN_LIGHTNING   = 40536  // 6938 to 8062 for 5 targets
};

enum ConversationText
{
    SAY_ILLIDAN_NO1 = -1999998,
    SAY_AKAMA_NO1   = -1529099,
    SAY_ILLIDAN_NO2 = -1529000,
    SAY_AKAMA_NO2   = -1529001,
};

enum AkamaEvents
{
    EVENT_AKAMA_START             = 1,
    EVENT_AKAMA_TALK_SEQUENCE_NO1 = 2,
    EVENT_AKAMA_TALK_SEQUENCE_NO2 = 3,
    EVENT_AKAMA_TALK_SEQUENCE_NO3 = 4,
    EVENT_AKAMA_TALK_SEQUENCE_NO4 = 5,

    EVENT_AKAMA_SET_DOOR_EVENT    = 6,

    EVENT_AKAMA_ILLIDAN_FIGHT     = 7,
    EVENT_AKAMA_MINIONS_FIGHT     = 8,
    EVENT_AKAMA_SUMMON_ELITE,

    EVENT_AKAMA_DOOR_CAST_FAIL,
    EVENT_AKAMA_SUMMON_SPIRITS,
    EVENT_AKAMA_DOOR_CAST_SUCCESS,
    EVENT_AKAMA_DOOR_OPEN,
    EVENT_AKAMA_DOOR_MOVE_PATH,
    EVENT_AKAMA_RETURN_ILLIDAN
};

enum AkamaTexts
{
    SAY_AKAMA_DOOR_SPEECH_NO1    = -1309025,
    SAY_AKAMA_DOOR_SPEECH_NO2    = -1309024,
    SAY_AKAMA_DOOR_SPEECH_NO3    = -1309028,

    YELL_AKAMA_FIGHT_MINIONS     = -1999990,

    SAY_SPIRIT_DOOR_SPEECH_NO1   = -1309026,
    SAY_SPIRIT_DOOR_SPEECH_NO2   = -1309027,
};

enum AkamaPath
{
    PATH_AKAMA_MINION_EVENT       = 2111,
    PATH_AKAMA_DOOR_EVENT_AFTER   = 2109,
    PATH_AKAMA_DOOR_EVENT_BEFORE  = 2110
};

struct boss_illidan_akamaAI : public BossAI
{
    boss_illidan_akamaAI(Creature* c) : BossAI(c, 2){}

    bool allowUpdate;
    bool doorEvent;

    uint32 m_pathId;

    void Reset()
    {
        ClearCastQueue();
        events.Reset();
        summons.DespawnAll();

        allowUpdate = false;
        doorEvent = false;

        m_pathId = 0;

        SetAutocast(SPELL_AKAMA_CHAIN_LIGHTNING, 10000, false, CAST_TANK);

        me->SetUInt32Value(UNIT_NPC_FLAGS, 0);
        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

        if (instance->GetData(EVENT_ILLIDARIDOOR) == DONE)
            me->SetVisibility(VISIBILITY_ON);
        else
        {
            me->SetVisibility(VISIBILITY_OFF);
            me->DestroyForNearbyPlayers();
        }

        me->SetReactState(REACT_PASSIVE);

        float x,y,z;
        me->GetRespawnCoord(x,y,z);
        me->SetHomePosition(x,y,z, 2.53f);
    }

    void MoveInLineOfSight(Unit *pWho)
    {
        if (!me->GetDBTableGUIDLow())
            return;

        ScriptedAI::MoveInLineOfSight(pWho);
    }

    void MovementInform(uint32 type, uint32 data)
    {
        if (type == WAYPOINT_MOTION_TYPE)
        {
            if (doorEvent)
            {
                if (data == 15 && m_pathId == PATH_AKAMA_DOOR_EVENT_BEFORE)
                {
                    m_pathId = 0;
                    events.ScheduleEvent(EVENT_AKAMA_DOOR_CAST_FAIL, 2000);
                }

                if (data == 17 && m_pathId == PATH_AKAMA_DOOR_EVENT_AFTER)
                {
                    if (Creature *pAkama = instance->GetCreature(instance->GetData64(DATA_AKAMA)))
                        pAkama->SetVisibility(VISIBILITY_ON);

                    m_pathId = 0;
                    me->DisappearAndDie();
                }
            }
            else
            {
                if (m_pathId == PATH_AKAMA_MINION_EVENT)
                {
                   if (data == 0)
                       DoScriptText(YELL_AKAMA_FIGHT_MINIONS, me);

                   if (data == 9)
                   {
                       m_pathId = 0;
                       events.ScheduleEvent(EVENT_AKAMA_SUMMON_ELITE, 1000);
                   }
                }
            }
        }

        if (type == POINT_MOTION_TYPE)
        {
            if (data == 0)
            {
                me->SetSelection(instance->GetData64(DATA_ILLIDANSTORMRAGE));
                events.ScheduleEvent(EVENT_AKAMA_TALK_SEQUENCE_NO1, 500);
            }
        }
    }

    void HandleDoorEvent()
    {
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_AKAMA_DOOR_CAST_FAIL:
                {
                    AddSpellToCastWithScriptText(SPELL_AKAMA_DOOR_CAST_FAIL, CAST_NULL, SAY_AKAMA_DOOR_SPEECH_NO1);
                    events.ScheduleEvent(EVENT_AKAMA_TALK_SEQUENCE_NO1, 8500);
                    break;
                }
                case EVENT_AKAMA_TALK_SEQUENCE_NO1:
                {
                    DoScriptText(SAY_AKAMA_DOOR_SPEECH_NO2, me);
                    events.ScheduleEvent(EVENT_AKAMA_SUMMON_SPIRITS, 10000);
                    break;
                }
                case EVENT_AKAMA_SUMMON_SPIRITS:
                {
                    for (uint8 i = 0; i < 2; i++)
                    {
                        if (Creature *pSpirit = me->SummonCreature(uint32(SpiritSpawns[i][0]), SpiritSpawns[i][1], SpiritSpawns[i][2], SpiritSpawns[i][3], me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 35000))
                            pSpirit->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    }

                    events.ScheduleEvent(EVENT_AKAMA_TALK_SEQUENCE_NO2, 1000);
                    break;
                }
                case EVENT_AKAMA_TALK_SEQUENCE_NO2:
                {
                    if (Creature *pCreature = GetClosestCreatureWithEntry(me, SpiritSpawns[0][0], 30.0f))
                        DoScriptText(SAY_SPIRIT_DOOR_SPEECH_NO1, pCreature);

                    events.ScheduleEvent(EVENT_AKAMA_TALK_SEQUENCE_NO3, 3000);
                    break;
                }
                case EVENT_AKAMA_TALK_SEQUENCE_NO3:
                {
                    if (Creature *pCreature = GetClosestCreatureWithEntry(me, SpiritSpawns[1][0], 30.0f))
                        DoScriptText(SAY_SPIRIT_DOOR_SPEECH_NO2, pCreature);

                    events.ScheduleEvent(EVENT_AKAMA_DOOR_CAST_SUCCESS, 8000);
                    break;
                }
                case EVENT_AKAMA_DOOR_CAST_SUCCESS:
                {
                    for (uint8 i = 0; i < 2; i++)
                    {
                        if (Creature *pSpirit = GetClosestCreatureWithEntry(me, uint32(SpiritSpawns[i][0]), 30.0f))
                            pSpirit->CastSpell((Unit*)NULL, SPELL_DEATHSWORN_DOOR_CHANNEL, false);
                    }

                    AddSpellToCast(SPELL_AKAMA_DOOR_CAST_SUCCESS, CAST_NULL);
                    events.ScheduleEvent(EVENT_AKAMA_DOOR_OPEN, 15000);
                    break;
                }
                case EVENT_AKAMA_DOOR_OPEN:
                {
                    instance->SetData(EVENT_ILLIDARIDOOR, DONE);
                    instance->HandleGameObject(instance->GetData64(DATA_GAMEOBJECT_ILLIDAN_GATE), true);
                    events.ScheduleEvent(EVENT_AKAMA_TALK_SEQUENCE_NO4, 3000);
                    break;
                }
                case EVENT_AKAMA_TALK_SEQUENCE_NO4:
                {
                    DoScriptText(SAY_AKAMA_DOOR_SPEECH_NO3, me);
                    events.ScheduleEvent(EVENT_AKAMA_DOOR_MOVE_PATH, 10000);
                    break;
                }
                case EVENT_AKAMA_DOOR_MOVE_PATH:
                {
                    m_pathId = PATH_AKAMA_DOOR_EVENT_AFTER;
                    me->GetMotionMaster()->MovePath(PATH_AKAMA_DOOR_EVENT_AFTER, false);
                    break;
                }
            }
        }
        CastNextSpellIfAnyAndReady();
    }

    void EnterEvadeMode()
    {
        ClearCastQueue();
        events.Reset();
        summons.DespawnAll();

        me->InterruptNonMeleeSpells(true);
        me->RemoveAllAuras();
        me->DeleteThreatList();
        me->CombatStop(true);
    }

    void KilledUnit(Unit *pWho)
    {
        if (summons.isEmpty())
            return;

        if (Unit *pUnit = GetClosestCreatureWithEntry(me, 23226, 40.0f))
            AttackStartNoMove(pUnit);
    }

    void DoAction(const int32 action)
    {
        switch (action)
        {
            case EVENT_AKAMA_RETURN_ILLIDAN:
            {
                events.CancelEvent(EVENT_AKAMA_SUMMON_ELITE);
                summons.DespawnAll();

                EnterEvadeMode();

                if (Creature *pIllidan = instance->GetCreature(instance->GetData64(DATA_ILLIDANSTORMRAGE)))
                {
                    float x,y,z;
                    pIllidan->GetNearPoint(x, y, z, 0.0f, 8.0f, -pIllidan->GetAngle(CENTER_X, CENTER_Y));

                    me->Relocate(x, y, z);
                    me->SendHeartBeat();
                    me->StopMoving();
                }
                break;
            }
            case EVENT_AKAMA_SET_DOOR_EVENT:
            {
                doorEvent = true;
                me->SetVisibility(VISIBILITY_ON);
                break;
            }
            case EVENT_AKAMA_START:
            {
                Creature *pIllidan = instance->GetCreature(instance->GetData64(DATA_ILLIDANSTORMRAGE));
                if (!pIllidan || !pIllidan->isAlive())
                    return;

                allowUpdate = true;

                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

                if (doorEvent)
                {
                    m_pathId = PATH_AKAMA_DOOR_EVENT_BEFORE;
                    me->GetMotionMaster()->MovePath(PATH_AKAMA_DOOR_EVENT_BEFORE, false);
                }
                else
                {
                    me->SetWalk(false);
                    me->GetMotionMaster()->MovePoint(0, 728.379f, 314.462f, 352.996f);
                }
                break;
            }
            case EVENT_AKAMA_MINIONS_FIGHT:
            {
                StopAutocast();
                me->InterruptNonMeleeSpells(true);

                m_pathId = PATH_AKAMA_MINION_EVENT;

                me->GetMotionMaster()->Clear(false);
                me->GetMotionMaster()->MovePath(PATH_AKAMA_MINION_EVENT, false);
                break;
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!allowUpdate && !UpdateVictim())
            return;

        events.Update(diff);

        if (doorEvent)
        {
            HandleDoorEvent();
            return;
        }

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_AKAMA_TALK_SEQUENCE_NO1:
                {
                    if (Creature *pIllidan = instance->GetCreature(instance->GetData64(DATA_ILLIDANSTORMRAGE)))
                    {
                        me->SetSelection(pIllidan->GetGUID());
                        pIllidan->SetSelection(me->GetGUID());
                        pIllidan->RemoveAurasDueToSpell(SPELL_ILLIDAN_KNEEL_INTRO);
                        me->SetFacingToObject(pIllidan);
                        DoScriptText(SAY_ILLIDAN_NO1, pIllidan);
                    }

                    events.ScheduleEvent(EVENT_AKAMA_TALK_SEQUENCE_NO2, 11000);
                    return;
                }
                case EVENT_AKAMA_TALK_SEQUENCE_NO2:
                {
                    DoScriptText(SAY_AKAMA_NO1, me);
                    events.ScheduleEvent(EVENT_AKAMA_TALK_SEQUENCE_NO3, 10000);
                    return;
                }
                case EVENT_AKAMA_TALK_SEQUENCE_NO3:
                {
                    if (Creature *pIllidan = instance->GetCreature(instance->GetData64(DATA_ILLIDANSTORMRAGE)))
                        DoScriptText(SAY_ILLIDAN_NO2, pIllidan);

                    events.ScheduleEvent(EVENT_AKAMA_TALK_SEQUENCE_NO4, 7000);
                    return;
                }
                case EVENT_AKAMA_TALK_SEQUENCE_NO4:
                {
                    DoScriptText(SAY_AKAMA_NO2, me);
                    events.ScheduleEvent(EVENT_AKAMA_ILLIDAN_FIGHT, 5000);
                    return;
                }
                case EVENT_AKAMA_ILLIDAN_FIGHT:
                {
                    if (Creature *pIllidan = instance->GetCreature(instance->GetData64(DATA_ILLIDANSTORMRAGE)))
                    {
                        pIllidan->AI()->DoAction(EVENT_ILLIDAN_START);
                        AttackStart(pIllidan);

                        StartAutocast();
                    }
                    break;
                }
                case EVENT_AKAMA_SUMMON_ELITE:
                {
                    if (Creature *pElite = DoSummon(23226, me, 5.0f, 10000.0f, TEMPSUMMON_DEAD_DESPAWN))
                    {
                        pElite->AddThreat(me, 10000.0f);
                        pElite->AI()->AttackStart(me);

                        if (!me->getVictim())
                            AttackStartNoMove(pElite);

                        StartAutocast();

                        events.ScheduleEvent(EVENT_AKAMA_SUMMON_ELITE, 9000);
                    }
                    break;
                }
            }
        }

        if (HealthBelowPct(20.0f))
        {
            ForceSpellCast(me, SPELL_AKAMA_POTION, INTERRUPT_AND_CAST_INSTANTLY);
            return;
        }

        CastNextSpellIfAnyAndReady(diff);
        DoMeleeAttackIfReady();
    }
};

enum MaievTaunts
{
    MAIEV_TAUNT_NO1 = -1529020,
    MAIEV_TAUNT_NO2 = -1529021,
    MAIEV_TAUNT_NO3 = -1529022,
    MAIEV_TAUNT_NO4 = -1529023
};

enum MaievTexts
{
    YELL_MAIEV_TALK_SEQUENCE_NO1  = -1529004,
    YELL_MAIEV_TALK_SEQUENCE_NO2  = -1529006,
    YELL_ILLIDAN_TALK_SQUENCE_NO1 = -1529005,
    YELL_MAIEV_ILLIDAN_END        = -1529008
};

enum MaievEvents
{
    EVENT_MAIEV_TALK_SEQUENCE_NO1 = 1,
    EVENT_MAIEV_TALK_SEQUENCE_NO2 = 2,
    EVENT_MAIEV_TALK_SEQUENCE_NO3 = 3,
    EVENT_MAIEV_RANGE_ATTACK      = 4,
    EVENT_MAIEV_CAGE_TRAP         = 5,
    EVENT_MAIEV_BEGIN_FIGHT       = 6,
    EVENT_MAIEV_END_FIGHT_SPEECH  = 7,
    EVENT_MAIEV_RANDOM_TAUNT      = 8
};

enum MaievSpells
{
    SPELL_MAIEV_TELEPORT_VISUAL   = 41232,
    SPELL_MAIEV_THROW_DAGGER      = 41152,
    SPELL_MAIEV_SUMMON_CAGE_TRAP  = 40694,
    SPELL_MAIEV_CAGE_TRAP_TRIGGER = 40761
};

#define SPELL_SHADOW_STRIKE             40685 // 4375 to 5625 every 3 seconds for 12 seconds
#define SPELL_FAN_BLADES                39954 // bugged visual

struct boss_illidan_maievAI : public BossAI
{
    boss_illidan_maievAI(Creature *c) : BossAI(c, 3){};

    bool m_canMelee;

    void Reset()
    {
        m_canMelee = false;
    }

    void IsSummonedBy(Unit *pSummoner)
    {
        me->Relocate(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() +1.0f);
        me->SendHeartBeat();

        ForceSpellCast(me, SPELL_MAIEV_TELEPORT_VISUAL);

        me->StopMoving();

        if (pSummoner->GetTypeId() == TYPEID_UNIT)
            ((Creature*)pSummoner)->SetSelection(me->GetGUID());

        me->SetReactState(REACT_PASSIVE);
        me->SetSelection(pSummoner->GetGUID());
        events.ScheduleEvent(EVENT_MAIEV_TALK_SEQUENCE_NO1, 6000);
    }

    void DoAction(const int32 action)
    {
        switch (action)
        {
            case EVENT_MAIEV_RANGE_ATTACK:
            {
                if (m_canMelee)
                {
                    m_canMelee = false;
                    me->GetMotionMaster()->Clear(false);

                    if (Creature *pIllidan = instance->GetCreature(instance->GetData64(DATA_ILLIDANSTORMRAGE)))
                    {
                        float x, y, z;
                        pIllidan->GetNearPoint(x, y, z, 0.0f, 45.0f, -pIllidan->GetAngle(CENTER_X, CENTER_Y));
                        z = 354.519;

                        me->Relocate(x, y, z);
                        me->UpdateObjectVisibility();

                        ForceSpellCast(me, SPELL_MAIEV_TELEPORT_VISUAL, INTERRUPT_AND_CAST_INSTANTLY);
                        me->StopMoving();

                        me->SetSelection(pIllidan->GetGUID());
                    }

                    SetAutocast(SPELL_MAIEV_THROW_DAGGER, 2000, false, CAST_TANK);
                    StartAutocast();
                }
                else
                {
                    m_canMelee = true;
                    StopAutocast();

                    if (me->getVictim())
                        DoStartMovement(me->getVictim());
                }
                break;
            }
            case EVENT_MAIEV_CAGE_TRAP:
            {
                me->GetMotionMaster()->Clear(false);

                float x, y, z;
                me->GetNearPoint(x, y, z, 0.0f, 25.0f, frand(0, 2*M_PI));
                z = 354.519;

                me->Relocate(x, y, z);
                me->SendHeartBeat();

                ForceSpellCast(me, SPELL_MAIEV_TELEPORT_VISUAL, INTERRUPT_AND_CAST_INSTANTLY);
                ForceSpellCast(me, SPELL_MAIEV_SUMMON_CAGE_TRAP, INTERRUPT_AND_CAST_INSTANTLY, true);

                if (me->getVictim())
                    DoStartMovement(me->getVictim());

                break;
            }
            case EVENT_MAIEV_END_FIGHT_SPEECH:
            {
                me->GetMotionMaster()->Clear(false);

                if (Creature *pIllidan = instance->GetCreature(instance->GetData64(DATA_ILLIDANSTORMRAGE)))
                {
                    float x, y, z;
                    pIllidan->GetNearPoint(x, y, z, 0.0f, 7.0f, pIllidan->GetOrientation());
                    z = 354.519;

                    me->Relocate(x, y, z);
                    me->SendHeartBeat();

                    me->SetSelection(pIllidan->GetGUID());
                }
                events.CancelEvent(EVENT_MAIEV_RANDOM_TAUNT);

                ForceSpellCast(me, SPELL_MAIEV_TELEPORT_VISUAL, INTERRUPT_AND_CAST_INSTANTLY);

                DoScriptText(YELL_MAIEV_ILLIDAN_END, me);
                break;
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_MAIEV_TALK_SEQUENCE_NO1:
                {
                    DoScriptText(YELL_MAIEV_TALK_SEQUENCE_NO1, me);
                    events.ScheduleEvent(EVENT_MAIEV_TALK_SEQUENCE_NO2, 9000);
                    break;
                }
                case EVENT_MAIEV_TALK_SEQUENCE_NO2:
                {
                    if (Creature *pIllidan = instance->GetCreature(instance->GetData64(DATA_ILLIDANSTORMRAGE)))
                        DoScriptText(YELL_ILLIDAN_TALK_SQUENCE_NO1, pIllidan);

                    events.ScheduleEvent(EVENT_MAIEV_TALK_SEQUENCE_NO3, 6000);
                    break;
                }
                case EVENT_MAIEV_TALK_SEQUENCE_NO3:
                {
                    DoScriptText(YELL_MAIEV_TALK_SEQUENCE_NO2, me);
                    events.ScheduleEvent(EVENT_MAIEV_BEGIN_FIGHT, 3000);
                    break;
                }
                case EVENT_MAIEV_BEGIN_FIGHT:
                {
                    if (Creature *pIllidan = instance->GetCreature(instance->GetData64(DATA_ILLIDANSTORMRAGE)))
                    {
                        pIllidan->SetReactState(REACT_AGGRESSIVE);
                        pIllidan->AI()->DoAction(EVENT_ILLIDAN_CHANGE_PHASE);
                        pIllidan->AI()->AttackStart(me);
                        me->SetSelection(pIllidan->GetGUID());
                        AttackStart(pIllidan);
                    }
                    events.ScheduleEvent(EVENT_MAIEV_RANDOM_TAUNT, urand(30000, 40000));
                    break;
                }
                case EVENT_MAIEV_RANDOM_TAUNT:
                {
                    DoScriptText(RAND(MAIEV_TAUNT_NO1, MAIEV_TAUNT_NO2, MAIEV_TAUNT_NO3, MAIEV_TAUNT_NO4), me);
                    events.ScheduleEvent(EVENT_MAIEV_RANDOM_TAUNT, urand(30000, 40000));
                    break;
                }
            }
        }

        if (!UpdateVictim())
            return;

        CastNextSpellIfAnyAndReady(diff);

        if (m_canMelee)
            DoMeleeAttackIfReady();
    }
};

enum GlaiveSpells
{
    SPELL_GLAIVE_SUMMON_TEAR      = 39855,
    SPELL_GLAIVE_CHANNEL          = 39857
};

struct boss_illidan_glaiveAI : public Scripted_NoMovementAI
{
    boss_illidan_glaiveAI(Creature *c) : Scripted_NoMovementAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance *pInstance;

    uint32 m_summonTimer;

    uint64 m_tearGUID;

    void MoveInLineOfSight(Unit *pWho){}

    void IsSummonedBy(Unit *pSummoner)
    {
        m_tearGUID = 0;

        m_summonTimer = 2000;

        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

        if (!pInstance)
            return;

        if (Creature *pIllidan = pInstance->GetCreature(pInstance->GetData64(DATA_ILLIDANSTORMRAGE)))
            pIllidan->AI()->JustSummoned(me);
    }

    void JustSummoned(Creature *pWho)
    {
        m_tearGUID = pWho->GetGUID();
        ForceSpellCast(pWho, SPELL_GLAIVE_CHANNEL);

        if (Creature *pIllidan = pInstance->GetCreature(pInstance->GetData64(DATA_ILLIDANSTORMRAGE)))
            pIllidan->AI()->JustSummoned(pWho);
    }

    void UpdateAI(const uint32 diff)
    {
        if (m_summonTimer)
        {
            if (m_summonTimer <= diff)
            {
                AddSpellToCast(me, SPELL_GLAIVE_SUMMON_TEAR);
                m_summonTimer = 0;
            }
            else
                m_summonTimer -= diff;
        }

        CastNextSpellIfAnyAndReady();
    }
};

enum FlameEvents
{
    EVENT_FLAME_RANGE_CHECK = 1,
    EVENT_FLAME_FLAME_BLAST = 2
};

enum FlameSpells
{
    SPELL_FLAME_FLAME_BLAST = 40631,
    SPELL_FLAME_BLAZE       = 40609,
    SPELL_FLAME_CHARGE      = 40602,
    SPELL_FLAME_ENRAGE      = 45078
};

struct boss_illidan_flameofazzinothAI : public ScriptedAI
{
    boss_illidan_flameofazzinothAI(Creature *c) : ScriptedAI(c), summons(me)
    {
        pInstance = c->GetInstanceData();

        me->SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, 8.0f);
        me->SetFloatValue(UNIT_FIELD_COMBATREACH, 8.0f);
        me->SetReactState(REACT_PASSIVE);
    }

    ScriptedInstance *pInstance;

    EventMap events;
    SummonList summons;
    uint32 check_timer;

    uint64 m_owner;

    void Reset()
    {
        events.Reset();
        summons.DespawnAll();
        ClearCastQueue();

        m_owner = 0;
        check_timer = 2000;

        m_creature->SetMeleeDamageSchool(SPELL_SCHOOL_FIRE);
        m_creature->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
    }

    void EnterCombat(Unit *pWho)
    {
        events.ScheduleEvent(EVENT_FLAME_RANGE_CHECK, 2000);
        events.ScheduleEvent(EVENT_FLAME_FLAME_BLAST, urand(15000, 20000));
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void JustDied(Unit *pKiller)
    {
        if (Creature *pIllidan = pInstance->GetCreature(pInstance->GetData64(DATA_ILLIDANSTORMRAGE)))
            pIllidan->AI()->DoAction(EVENT_ILLIDAN_FLAME_DEATH);

        me->RemoveCorpse();
    }

    void JustSummoned(Creature *pWho)
    {
        summons.Summon(pWho);
    }

    void IsSummonedBy(Unit *pWho)
    {
        m_owner = pWho->GetGUID();
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(check_timer < diff)
        {
            me->SetWalk(false);
            me->SetSpeed(MOVE_RUN, 2.5f);
            check_timer = 2000;
        }
        else
            check_timer -= diff;

        events.Update(diff);
        while(uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_FLAME_RANGE_CHECK:
                {
                    DoZoneInCombat();

                    if (Unit *pTarget = SelectUnit(SELECT_TARGET_FARTHEST, 0, 200.0f, true, 0, 48.0f))
                    {
                        AttackStart(pTarget);

                        me->SetSpeed(MOVE_RUN, 20.0f);
                        me->CastSpell(pTarget, SPELL_FLAME_CHARGE, true);

                        check_timer = 5000;
                    }

                    if (Creature *pOwner = me->GetMap()->GetCreature(m_owner))
                    {
                        if (!me->IsWithinDistInMap(pOwner, 30.0f) && !me->HasAura(SPELL_FLAME_ENRAGE, 0))
                            ForceSpellCast(me, SPELL_FLAME_ENRAGE);
                    }

                    events.ScheduleEvent(EVENT_FLAME_RANGE_CHECK, 2000);
                    break;
                }
                case EVENT_FLAME_FLAME_BLAST:
                {
                    AddSpellToCast(me->getVictim(), SPELL_FLAME_FLAME_BLAST);
                    AddSpellToCast(me->getVictim(), SPELL_FLAME_BLAZE);
                    events.ScheduleEvent(EVENT_FLAME_FLAME_BLAST, urand(10000, 15000));
                    break;
                }
            }
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

enum ShadowDemonSpells
{
    SPELL_SHADOW_DEMON_PASSIVE      = 41079,
    SPELL_SHADOW_DEMON_CONSUME_SOUL = 41080,
    SPELL_SHADOW_DEMON_FOUND_TARGET = 41082,
    SPELL_SHADOW_DEMON_BEAM         = 39123,
    SPELL_SHADOW_DEMON_PARALYZE     = 41083
};

struct boss_illidan_shadowdemonAI : public ScriptedAI
{
    boss_illidan_shadowdemonAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance *pInstance;

    uint64 m_targetGUID;
    uint32 m_checkTimer;

    void Reset()
    {
        me->SetReactState(REACT_PASSIVE);

        m_checkTimer = 2000;
        m_targetGUID = 0;
    }

    void MovementInform(uint32 type, uint32 data)
    {
        if (type != POINT_MOTION_TYPE)
            return;

        if (Unit *pTarget = me->GetUnit(m_targetGUID))
            ForceSpellCast(pTarget, SPELL_SHADOW_DEMON_CONSUME_SOUL, INTERRUPT_AND_CAST_INSTANTLY);
    }

    void IsSummonedBy(Unit *pSummoner)
    {
        DoZoneInCombat();

        m_targetGUID = pSummoner->GetGUID();

        ForceSpellCast(pSummoner, SPELL_SHADOW_DEMON_FOUND_TARGET);
        ForceSpellCast(me, SPELL_SHADOW_DEMON_PASSIVE);

        if (!pInstance)
            return;

        if (Creature *pIllidan = pInstance->GetCreature(pInstance->GetData64(DATA_ILLIDANSTORMRAGE)))
            pIllidan->AI()->JustSummoned(me);
    }

    void JustDied(Unit *pKiller)
    {
        if (Unit *pUnit = me->GetUnit(m_targetGUID))
        {
            pUnit->RemoveAurasByCasterSpell(SPELL_SHADOW_DEMON_BEAM, me->GetGUID());
            pUnit->RemoveAurasByCasterSpell(SPELL_SHADOW_DEMON_PARALYZE, me->GetGUID());
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (m_targetGUID)
        {
            if (m_checkTimer < diff)
            {
                Unit *pUnit = me->GetUnit(m_targetGUID);
                if (!pUnit || pUnit->isDead() || pUnit->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
                {
                    DoZoneInCombat();

                    if (Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                    {
                        m_targetGUID = pTarget->GetGUID();
                        ForceSpellCast(pTarget, SPELL_SHADOW_DEMON_FOUND_TARGET);
                    }
                }

                m_checkTimer = 2000;
            }
            else
                m_checkTimer -= diff;
        }

        CastNextSpellIfAnyAndReady();
    }
};

struct boss_illidan_parasite_shadowfiendAI : public ScriptedAI
{
    boss_illidan_parasite_shadowfiendAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance *pInstance;

    void IsSummonedBy(Unit *pSummoner)
    {
        if (!pInstance)
            return;

        ForceSpellCast(me, 41913, INTERRUPT_AND_CAST, true);

        if (Creature *pIllidan = pInstance->GetCreature(pInstance->GetData64(DATA_ILLIDANSTORMRAGE)))
            pIllidan->AI()->JustSummoned(me);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!me->getVictim() || me->getVictim()->GetTypeId() == TYPEID_UNIT)
        {
            DoZoneInCombat();
            if (Unit *pTemp = SelectUnit(SELECT_TARGET_RANDOM, 0, 200.0f, true, 0, 5.0f))
            {
                if (me->getVictim())
                    DoModifyThreatPercent(me->getVictim(), -101);

                me->AddThreat(pTemp, 10000.0f);
                ScriptedAI::AttackStart(pTemp);
            }
            else
                me->DisappearAndDie();
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

bool GossipSelect_boss_illidan_akama(Player *pPlayer, Creature *pCreature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF) // Time to begin the Event
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        pCreature->AI()->DoAction(EVENT_AKAMA_START);
    }
    else
        pPlayer->CLOSE_GOSSIP_MENU();

    return true;
}

bool GossipHello_boss_illidan_akama(Player *player, Creature *_Creature)
{
    player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
    player->SEND_GOSSIP_MENU(10465, _Creature->GetGUID());
    return true;
}

bool GOUse_boss_illidan_cage_trap(Player* pPlayer, GameObject* pGo)
{
    if (pGo->GetGoState() == GO_STATE_ACTIVE)
        return false;

    pGo->CastSpell((Unit*)NULL, SPELL_MAIEV_CAGE_TRAP_TRIGGER);
    pGo->SetGoState(GO_STATE_ACTIVE);
    return true;
}

struct boss_illidan_cage_beamerAI : public ScriptedAI
{
    boss_illidan_cage_beamerAI(Creature *c) : ScriptedAI(c), summons(c){}

    SummonList summons;

    void JustSummoned(Creature *pWho)
    {
        uint32 spellId = 0;
        uint32 entry = 0;

        switch (pWho->GetEntry())
        {
            case 23296:
                spellId = 40704;
                entry = 23292;
                break;
            case 23297:
                spellId = 40707;
                entry = 23293;
                break;
            case 23298:
                spellId = 40708;
                entry = 23294;
                break;
            case 23299:
                spellId = 40709;
                entry = 23295;
                break;
        }

        if (Creature *pTarget = GetClosestCreatureWithEntry(me, entry, 12.0f))
        {
            pWho->CastSpell(pTarget, spellId, false);
            pTarget->CastSpell(pWho, spellId, false);
        }
    }

    void DoAction(const int32 action)
    {
        if (Creature *pIllidan = GetClosestCreatureWithEntry(me, 22917, 8.0f))
        {
            if (pIllidan->HasAura(40695,0) || CAST_AI(boss_illidan_stormrageAI, pIllidan->AI())->m_phase == PHASE_FOUR)
                return;

            me->SetOrientation(me->GetAngle(pIllidan));

            // set 8 beam triggers
            for (uint32 i = 40696; i <= 40703; i++)
                me->CastSpell(pIllidan, i, false);

            pIllidan->RemoveAurasDueToSpell(SPELL_ILLIDAN_ENRAGE);
            pIllidan->CastSpell(pIllidan, 40695, true);
        }
        me->ForcedDespawn(15000);
    }
};

CreatureAI* GetAI_boss_illidan_stormrage(Creature *_Creature)
{
    return new boss_illidan_stormrageAI(_Creature);
}

CreatureAI* GetAI_boss_illidan_akama(Creature *_Creature)
{
    return new boss_illidan_akamaAI(_Creature);
}

CreatureAI* GetAI_boss_illidan_maiev(Creature *_Creature)
{
    return new boss_illidan_maievAI(_Creature);
}

CreatureAI* GetAI_boss_illidan_glaive(Creature *_Creature)
{
    return new boss_illidan_glaiveAI(_Creature);
}

CreatureAI* GetAI_boss_illidan_shadowdemon(Creature *_Creature)
{
    return new boss_illidan_shadowdemonAI(_Creature);
}

CreatureAI* GetAI_boss_illidan_flameofazzinoth(Creature *_Creature)
{
    return new boss_illidan_flameofazzinothAI(_Creature);
}

CreatureAI* GetAI_boss_illidan_cage_beamer(Creature *_Creature)
{
    return new boss_illidan_cage_beamerAI(_Creature);
}

CreatureAI* GetAI_boss_illidan_parasite_shadowfiend(Creature *_Creature)
{
    return new boss_illidan_parasite_shadowfiendAI(_Creature);
}

void AddSC_boss_illidan()
{
    Script* newscript;

    newscript = new Script;
    newscript->Name = "boss_illidan_stormrage";
    newscript->GetAI = &GetAI_boss_illidan_stormrage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_illidan_akama";
    newscript->GetAI = &GetAI_boss_illidan_akama;
    newscript->pGossipHello = &GossipHello_boss_illidan_akama;
    newscript->pGossipSelect = &GossipSelect_boss_illidan_akama;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_illidan_maiev";
    newscript->GetAI = &GetAI_boss_illidan_maiev;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_illidan_glaive";
    newscript->GetAI = &GetAI_boss_illidan_glaive;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_illidan_shadowdemon";
    newscript->GetAI = &GetAI_boss_illidan_shadowdemon;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_illidan_flameofazzinoth";
    newscript->GetAI = &GetAI_boss_illidan_flameofazzinoth;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_illidan_cage_trap";
    newscript->pGOUse = &GOUse_boss_illidan_cage_trap;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_illidan_cage_beamer";
    newscript->GetAI = &GetAI_boss_illidan_cage_beamer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_illidan_parasite_shadowfiend";
    newscript->GetAI = &GetAI_boss_illidan_parasite_shadowfiend;
    newscript->RegisterSelf();
}
