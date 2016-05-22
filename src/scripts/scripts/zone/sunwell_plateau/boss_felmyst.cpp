/* Copyright (C) 2009 Trinity <http://www.trinitycore.org/>
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
SDName: Boss_Felmyst
SD%Complete: 95
SDComment: Make Kalecgos outro cut-scene. Final debugging
EndScriptData */

#include "precompiled.h"
#include "def_sunwell_plateau.h"

enum Quotes
{
    YELL_BIRTH      =       -1580036,
    YELL_KILL1      =       -1580037,
    YELL_KILL2      =       -1580038,
    YELL_BREATH     =       -1580039,
    YELL_TAKEOFF    =       -1580040,
    YELL_BERSERK    =       -1580041,
    YELL_DEATH      =       -1580042,
    EMOTE_BREATH    =       -1811004
};

enum Spells
{
    //Aura
    AURA_NOXIOUS_FUMES          =   47002,

    //Land phase
    SPELL_CLEAVE                =   19983,
    SPELL_CORROSION             =   45866,
    SPELL_GAS_NOVA              =   45855,
    SPELL_ENCAPSULATE_CHANNEL   =   45661,
    SPELL_ENCAPSULATE_EFFECT    =   45665, // linked in DB

    //Flight phase
    SPELL_VAPOR_SELECT          =   45391,   // fel to player, force cast 45392, 50000y selete target
    SPELL_VAPOR_SUMMON          =   45392,   // player summon vapor, radius around caster, 5y,
    SPELL_VAPOR_FORCE           =   45388,   // vapor to fel, force cast 45389
    SPELL_VAPOR_CHANNEL         =   45389,   // fel to vapor, green beam channel
    SPELL_VAPOR_TRIGGER         =   45411,   // linked to 45389, vapor to self, trigger 45410 and 46931
    SPELL_VAPOR_DAMAGE          =   46931,   // vapor damage, 4000
    SPELL_TRAIL_SUMMON          =   45410,   // vapor summon trail
    SPELL_TRAIL_TRIGGER         =   45399,   // trail to self, trigger 45402
    SPELL_TRAIL_DAMAGE          =   45402,   // trail damage, 2000 + 2000 dot
    SPELL_DEAD_SUMMON           =   45400,   // summon blazing dead, 5min
    SPELL_DEAD_PASSIVE          =   45415,   // aura in creature_template_addon
    SPELL_FOG_BREATH            =   45495,   // fel to self, speed burst
    SPELL_FOG_TRIGGER           =   45582,   // fog to self, trigger 45782
    SPELL_FOG_FORCE             =   45782,   // fog to player, force cast 45714
    SPELL_FOG_INFORM            =   45714,   // player let fel cast 45717, script effect
    SPELL_FOG_CHARM             =   45717,   // fel to player
    SPELL_FOG_CHARM2            =   45726,   // link to 45717

    //Other
    SPELL_BERSERK               =   46587,
};

enum Creatures
{
    MOB_FLY_TRIGGER          =   22515,
    MOB_FELMYST              =   25038,
    MOB_UNYIELDING_DEAD      =   25268,
    MOB_MADRIGOSA            =   25160,
    MOB_FELMYST_VISUAL       =   25041,
    MOB_FLIGHT_LEFT          =   25357,
    MOB_FLIGHT_RIGHT         =   25358,
    MOB_FOG_OF_CORRUPTION    =   25266,
    MOB_VAPOR                =   25265,
    MOB_VAPOR_TRAIL          =   25267,
    MOB_KALECGOS             =   25319  // it is the same Kalecgos dragon that used id KJ script
};

enum PhaseFelmyst
{
    PHASE_NULL      = 0,
    PHASE_GROUND    = 1,
    PHASE_FLIGHT    = 2,
    PHASE_RESPAWNING   = 3
};

enum EventFelmyst
{
    EVENT_NULL          =   0,
    EVENT_BERSERK       =   1,
    EVENT_CHECK         =   2,

    EVENT_CLEAVE        =   3,
    EVENT_CORROSION     =   4,
    EVENT_GAS_NOVA      =   5,
    EVENT_ENCAPSULATE   =   6,
    EVENT_FLIGHT        =   7,

    EVENT_FLIGHT_SEQUENCE   =   8,
    EVENT_SUMMON_FOG        =   9
};

#define FELMYST_OOC_PATH    2500

enum Side
{
    LEFT_SIDE = 0,
    RIGHT_SIDE = 1
};

float FlightMarker[3][2][3] = 
{
   //left                     //right
    {{1446.56, 702.57, 50.08}, {1441.64, 502.52, 50.08}},
    {{1469.94, 704.24, 50.08}, {1467.22, 516.32, 50.08}},
    {{1494.76, 705.00, 50.08}, {1492.82, 515.67, 50.08}}
};

float FlightSide[2][3] = 
{
    {1468.38, 730.27, 60.08},   // left
    {1458.17, 501.3, 60.08}     // right
};

float FallCoord[2][3] = 
{
    {1476.30, 649, 21.5},     // left
    {1472.55, 580, 22.5}     // right
};

float FogCoords[25][3][3] =
{
     //left side
               //[0]                     [1]                       [2]
    {{1451.98, 660.00, 23.05}, {1472.56, 680.00, 22.36}, {1507.31, 693.96, 28.85}}, //0
    {{1451.98, 640.00, 23.06}, {1472.54, 660.00, 20.81}, {1495.10, 680.00, 21.22}}, //1
    {{1451.98, 620.00, 23.06}, {1472.56, 640.00, 21.33}, {1513.84, 672.90, 25.21}}, //2
    {{1451.98, 600.00, 23.06}, {1472.57, 620.00, 22.27}, {1531.06, 666.55, 27.41}}, //3
    {{1451.98, 580.00, 23.06}, {1472.57, 600.00, 23.27}, {1495.10, 659.94, 22.84}}, //4
    {{1451.98, 560.00, 23.06}, {1472.56, 580.02, 22.45}, {1530.79, 650.80, 35.89}}, //5
    {{1451.98, 540.00, 23.06}, {1472.58, 560.00, 22.87}, {1495.29, 639.84, 23.64}}, //6
    {{                      }, {1451.98, 560.00, 23.06}, {1516.20, 642.40, 27.16}}, //7
    {{                      }, {                      }, {1526.31, 636.49, 36.26}}, //8
    {{                      }, {                      }, {1495.13, 620.01, 25.37}}, //9
    {{                      }, {                      }, {1525.77, 622.45, 35.69}}, //10
    {{                      }, {                      }, {1517.40, 614.23, 29.78}}, //11
    {{                      }, {                      }, {1530.97, 609.00, 35.89}}, //12
    {{                      }, {                      }, {1494.96, 599.91, 25.30}}, //13
    {{                      }, {                      }, {1545.40, 594.88, 35.95}}, //14
    {{                      }, {                      }, {1523.57, 587.71, 31.00}}, //15
    {{                      }, {                      }, {1495.94, 580.00, 23.84}}, //16
    {{                      }, {                      }, {1513.26, 571.21, 28.79}}, //17
    {{                      }, {                      }, {1494.96, 560.01, 25.24}}, //18
    {{                      }, {                      }, {1532.74, 556.12, 33.09}}, //19
    {{                      }, {                      }, {1514.72, 549.31, 30.14}}, //20
    {{                      }, {                      }, {1494.97, 540.02, 25.81}}, //21
    {{                      }, {                      }, {1527.60, 536.79, 30.63}}, //22
    {{                      }, {                      }, {1550.99, 537.98, 33.60}}, //23
    {{                      }, {                      }, {1510.45, 524.35, 26.63}}  //24
     //right side
};

struct boss_felmystAI : public ScriptedAI
{
    boss_felmystAI(Creature *c) : ScriptedAI(c), summons(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance *pInstance;
    PhaseFelmyst Phase;
    EventFelmyst Event;
    uint32 Timer[10];
    uint32 PulseCombat;

    SummonList summons;

    uint8 side;
    uint8 path;
    uint8 counter;
    uint32 FlightCount;
    uint32 BreathCount;
    uint32 IntroPhase;
    uint32 IntroTimer;

    void Reset()
    {
        Phase = PHASE_NULL;
        Event = EVENT_NULL;
        Timer[EVENT_BERSERK] = 600000;
        Timer[EVENT_CHECK] = 1000;
        PulseCombat = 2000;
        FlightCount = 0;
        IntroPhase = 0;
        IntroTimer = 0;
        side = 0;
        path = 0;
        counter = 0;

        me->addUnitState(UNIT_STAT_IGNORE_PATHFINDING);

        me->SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, 10);
        me->SetFloatValue(UNIT_FIELD_COMBATREACH, 10);
        me->setActive(true);
        me->SetWalk(false);
        DespawnSummons();   // for unyielding dead summoned by trigger

        if(pInstance)
            pInstance->SetData(DATA_FELMYST_EVENT, NOT_STARTED);

        summons.DespawnAll();   // for any other summons? (should not be needed?)

         me->setActive(false);
    }

    void EnterCombat(Unit *who)
    {
        me->setActive(true);

        DoZoneInCombat();
        RemoveMCAuraIfExist();  // just in case
        EnterPhase(PHASE_GROUND);
        Phase = PHASE_NULL; // not attack yet, but counters on
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->MoveIdle();
        me->SetSpeed(MOVE_FLIGHT, 2);
        if(Unit* target = SelectUnit(SELECT_TARGET_TOPAGGRO, 0))
        {
            float x, y, z;
            target->GetNearPoint(x, y, z, 0, 2, me->GetAngle(target));
            me->UpdateAllowedPositionZ(x, y, z);
            me->GetMotionMaster()->MovePoint(0, x, y, z);
        }
        else
        {
            EnterEvadeMode();
            return;
        }
        if(pInstance)
        {
            pInstance->SetData(DATA_FELMYST_EVENT, IN_PROGRESS);
            if(Creature* pBrutallus = me->GetCreature(pInstance->GetData64(DATA_BRUTALLUS)))
                pBrutallus->RemoveCorpse();
        }
    }

    void AttackStart(Unit *who)
    {
        if (Phase == PHASE_NULL)
            return;

        if (Phase != PHASE_FLIGHT && Phase != PHASE_RESPAWNING)
            ScriptedAI::AttackStart(who);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (Phase == PHASE_NULL)
            return;

        if(Phase != PHASE_FLIGHT && Phase != PHASE_RESPAWNING)
            ScriptedAI::MoveInLineOfSight(who);
    }

    void RemoveMCAuraIfExist()
    {
        Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
        for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
        {
            Player* i_pl = i->getSource();
            i_pl->RemoveAurasDueToSpell(SPELL_FOG_CHARM);
            i_pl->RemoveAurasDueToSpell(SPELL_FOG_CHARM2);
        }
    }

    void KilledUnit(Unit* victim)
    {
        if(roll_chance_i(15))
            DoScriptText(RAND(YELL_KILL1, YELL_KILL2), me);
    }

    void JustRespawned()
    {
        Phase = PHASE_RESPAWNING;
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        me->SetStandState(PLAYER_STATE_SLEEP);
        IntroTimer = 4000;
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(YELL_DEATH, me);
        pInstance->SetData(DATA_FELMYST_EVENT, DONE);
        me->SummonCreature(MOB_KALECGOS, 1555, 737, 88, 0, TEMPSUMMON_TIMED_DESPAWN, 300000);
    }

    void EnterEvadeMode()
    {
        CreatureAI::EnterEvadeMode();
        me->SetSpeed(MOVE_FLIGHT, 1.7, false);
        me->GetMotionMaster()->MovePath(FELMYST_OOC_PATH, true);
        IntroPhase = 6; // to make proper landing on next EnterCombat

        Map::PlayerList const &players = me->GetMap()->GetPlayers();
        for(Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
            if(Player *p = i->getSource())
            {
                if(p->isAlive() && p->HasAura(SPELL_FOG_CHARM, 0))
                    me->Kill(p, false);
            }
        summons.DespawnAll();
    }

    void DespawnSummons()
    {
        std::list<uint64> AddList = me->GetMap()->GetCreaturesGUIDList(MOB_UNYIELDING_DEAD, GET_FIRST_CREATURE_GUID, 0);
        if (AddList.empty())
            return;

        for (std::list<uint64>::iterator i = AddList.begin(); i!= AddList.end(); ++i)
        {
            if(Creature* Skeleton = me->GetCreature(*i))
                Skeleton->ForcedDespawn();
        }
    }

    void JustSummoned(Creature *summon)
    {
        if(summon->GetEntry() == MOB_KALECGOS)
        {
            summon->setActive(true);
            summon->SetLevitate(true);
            summon->setHover(true);
            summon->SetSpeed(MOVE_FLIGHT, 1.2);
            summon->GetMotionMaster()->MovePoint(50, 1471, 632, 37);
        }

        summons.Summon(summon);
    }

    void DamageTaken(Unit*, uint32 &damage)
    {
        if(Phase != PHASE_GROUND && ((uint32(me->GetHealth()*100/me->GetMaxHealth()) <= 1)))
            damage = 0;
    }

    void EnterPhase(PhaseFelmyst NextPhase)
    {
        switch(NextPhase)
        {
            case PHASE_GROUND:
                Timer[EVENT_CLEAVE] = urand(5000, 10000);
                Timer[EVENT_CORROSION] = urand(12000, 20000);
                Timer[EVENT_GAS_NOVA] = urand(20000, 25000);
                Timer[EVENT_ENCAPSULATE] = 30000;
                Timer[EVENT_FLIGHT] = 60000;
                Timer[EVENT_CHECK] = 1000;
                //DoResetThreat();
                break;
            case PHASE_FLIGHT:
                side = RAND(LEFT_SIDE, RIGHT_SIDE);
                Timer[EVENT_FLIGHT_SEQUENCE] = 1000;
                Timer[EVENT_SUMMON_FOG] = 0;
                Timer[EVENT_CHECK] = 1000;
                FlightCount = 0;
                BreathCount = 0;
                break;
            default:
                break;
        }
        Phase = NextPhase;
    }

    void DoIntro()
    {
        switch(IntroPhase)
        {
            case 0:
                DoScriptText(YELL_BIRTH, me);
                IntroTimer = 1000;
                break;
            case 1:
                me->SetStandState(PLAYER_STATE_NONE);
                IntroTimer = 2000;
                break;
            case 2:
                me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                IntroTimer = 2500;
                break;
            case 3:
                me->SetLevitate(true);
                me->GetMotionMaster()->MovePoint(6, me->GetPositionX()-0.5, me->GetPositionY()-0.5, me->GetPositionZ()+20);
                IntroTimer = 0;
                break;
            case 4:
                me->SetSpeed(MOVE_FLIGHT, 1.7, false);
                me->GetMotionMaster()->MovePath(FELMYST_OOC_PATH, true);
                IntroTimer = 10000;
                break;
            case 5:
                Phase = PHASE_NULL;
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                IntroTimer = 0;
                break;
            case 6:
                Phase = PHASE_GROUND;
                if (!me->HasAura(AURA_NOXIOUS_FUMES))
                    me->CastSpell(me, AURA_NOXIOUS_FUMES, true);
                AttackStart(me->getVictim());
                break;
        }
        IntroPhase++;
    }
    
    void JustReachedHome()
    {
        me->SetLevitate(true);
    }

    void MovementInform(uint32 Type, uint32 Id)
    {
        if(Type == POINT_MOTION_TYPE)
        {
            // stop moving on each waypoint
            me->GetMotionMaster()->MoveIdle();
            if(me->getVictim()) // cosmetics: to be tested if working
                me->SetInFront(me->getVictim());
            switch(Id)
            {
                case 0: // on landing after aggroing
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    me->SetLevitate(false);
                    me->setHover(false);
                    me->SetSpeed(MOVE_RUN, 2.0,false);
                    IntroTimer = 3000;
                    break;
                case 1: // on starting phase 2
                    me->setHover(true);
                    Timer[EVENT_FLIGHT_SEQUENCE] = 1000;
                    break;
                case 2: // on left/right side marker
                    me->setHover(true);
                    Timer[EVENT_FLIGHT_SEQUENCE] = 3000;
                    break;
                case 3: // on path start node
                    me->setHover(true);
                    me->SetSpeed(MOVE_FLIGHT, 3.5, false);
                    Timer[EVENT_FLIGHT_SEQUENCE] = urand(3000, 4000);
                    break;
                case 4: // on path stop node
                    me->setHover(true);
                    me->SetSpeed(MOVE_FLIGHT, 1.7, false);
                    me->RemoveAurasDueToSpell(SPELL_FOG_BREATH);
                    side = side?LEFT_SIDE:RIGHT_SIDE;
                    BreathCount++;
                    if(BreathCount < 3)
                        FlightCount = 4;
                    else
                        FlightCount = 7;
                    Timer[EVENT_FLIGHT_SEQUENCE] = 3000;
                    break;
                case 5: // on landing after phase 2
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    Timer[EVENT_FLIGHT_SEQUENCE] = 1500;
                    break;
                case 6:
                    me->setHover(true);
                    IntroTimer = 8000;
                default:
                    break;
            }
        }
    }

    void HandleFlightSequence()
    {
        switch(FlightCount)
        {
        case 0: // fly up
            BreathCount = 0;
            me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
            me->SetLevitate(true);
            me->setHover(true);
            DoScriptText(YELL_TAKEOFF, me);
            Timer[EVENT_FLIGHT_SEQUENCE] = 2000;
            break;
        case 1:
            me->GetMotionMaster()->MovePoint(1, me->GetPositionX()+10, me->GetPositionY(), me->GetPositionZ()+20);
            Timer[EVENT_FLIGHT_SEQUENCE] = 0;
            break;
        case 2: // summon vapor on player 2 times
        case 3:
            {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 200, true);
            if(target)
                target->CastSpell((Unit*)NULL, SPELL_VAPOR_SUMMON, true);
            else
            {
                EnterEvadeMode();
                return;
            }
            Timer[EVENT_FLIGHT_SEQUENCE] = 11000;
            break;
            }
        case 4: // go to side left/right marker
            me->SetSpeed(MOVE_FLIGHT, 1.7, false);
            me->GetMotionMaster()->MovePoint(2, FlightSide[side][0], FlightSide[side][1], FlightSide[side][2]);
            Timer[EVENT_FLIGHT_SEQUENCE] = 0;
            break;
        case 5: // decide path to go breathing
            {
            path = urand(0,2);
            float *pos = FlightMarker[path][side];
            counter = side ? (path ? (path%2 ? 7 : 24) : 6) : 0;
            me->GetMotionMaster()->MovePoint(3, pos[0], pos[1], pos[2]);
            Timer[EVENT_FLIGHT_SEQUENCE] = 0;
            break;
            }
        case 6: // start fog breath
            {
            float *pos = FlightMarker[path][side?LEFT_SIDE:RIGHT_SIDE];
            me->GetMotionMaster()->MovePoint(4, pos[0], pos[1], pos[2]);
            DoScriptText(EMOTE_BREATH, me);
            AddSpellToCast(me, SPELL_FOG_BREATH);
            Timer[EVENT_SUMMON_FOG] = 50;
            Timer[EVENT_FLIGHT_SEQUENCE] = 0;
            break;
            }
        case 7: // start landing..
            if(Unit* target = SelectUnit(SELECT_TARGET_TOPAGGRO, 0))
            {
                float x, y, z;
                target->GetPosition(x, y, z);
                me->GetMotionMaster()->MovePoint(5, x, y, z);
            }
            else
            {
                EnterEvadeMode();
                return;
            }
            Timer[EVENT_FLIGHT_SEQUENCE] = 0;
            break;
        case 9: // ..and go for phase 1
            me->SetSpeed(MOVE_RUN, 2.0, false);
            me->SetLevitate(false);
            me->SetWalk(false);
            me->setHover(false);
            me->SendHeartBeat();
            EnterPhase(PHASE_GROUND);
            AttackStart(me->getVictim());
            DoStartMovement(me->getVictim());
            break;
        default:
            break;
        }
        FlightCount++;
    }

    void ProcessEvent(EventFelmyst Event)
    {
        switch(Event)
        {
            case EVENT_BERSERK:
                DoScriptText(YELL_BERSERK, me);
                ForceSpellCast(me, SPELL_BERSERK, INTERRUPT_AND_CAST_INSTANTLY);
                Timer[EVENT_BERSERK] = 300000;   // 5 min just in case :)
                break;
            case EVENT_CHECK:
                DoZoneInCombat();
                me->SetSpeed(MOVE_RUN, 2.0, false);
                Timer[EVENT_CHECK]=1000;
                break;
            case EVENT_CLEAVE:
                AddSpellToCast(me->getVictim(), SPELL_CLEAVE);
                Timer[EVENT_CLEAVE] = urand(5000, 10000);
                break;
            case EVENT_CORROSION:
                AddSpellToCast(me->getVictim(), SPELL_CORROSION);
                Timer[EVENT_CORROSION] = urand(20000, 30000);
                break;
            case EVENT_GAS_NOVA:
                AddSpellToCastWithScriptText(me, SPELL_GAS_NOVA, YELL_BREATH);
                // gas nova should only be used 2 times in phase 1
                Timer[EVENT_GAS_NOVA] =(Timer[EVENT_FLIGHT] <= 20000)?40000:urand(20000, 25000);
                break;
            case EVENT_ENCAPSULATE:
                if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 60, true))
                {
                    ClearCastQueue();
                    me->SetSelection(target->GetGUID());
                    AddSpellToCast(target, SPELL_ENCAPSULATE_CHANNEL, false, true);
                    Timer[EVENT_ENCAPSULATE] = urand(22000, 35000);
                    if(Timer[EVENT_FLIGHT] < 7000)
                        Timer[EVENT_FLIGHT] = 7000;
                }
                break;
            case EVENT_FLIGHT:
                EnterPhase(PHASE_FLIGHT);
                break;
            case EVENT_FLIGHT_SEQUENCE:
                HandleFlightSequence();
                break;
            case EVENT_SUMMON_FOG:
                float *posFog = FogCoords[counter][path];
                if(Creature *Fog = me->SummonCreature(MOB_FOG_OF_CORRUPTION, posFog[0], posFog[1], posFog[2], 0, TEMPSUMMON_TIMED_DESPAWN, 15000))
                    Fog->CastSpell(Fog, SPELL_FOG_TRIGGER, true);
                if((side && !counter) || (!side && counter == (path ? (path%2 ? 7 : 24) : 6)))
                    Timer[EVENT_SUMMON_FOG] = 0;
                else
                {
                    side ? counter-- : counter++;
                    Timer[EVENT_SUMMON_FOG] = (6000/(path ? (path%2 ? 8 : 25) : 7));  // check this timer
                }
                break;
        }
    }

    bool UpdateVictim()
    {
        switch (Phase)
        {
            case PHASE_FLIGHT:
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
        if(IntroTimer)
        {
            if(IntroTimer <= diff)
                DoIntro();
            else
                IntroTimer -= diff;
        }

        if (!UpdateVictim())
            return;

        if(PulseCombat < diff)
        {
            DoZoneInCombat();
            PulseCombat = 2000;
        }
        else
            PulseCombat -= diff;

        // use enrage timer both phases
        if(Timer[EVENT_BERSERK] <= diff)
            ProcessEvent(EVENT_BERSERK);
        else
            Timer[EVENT_BERSERK] -= diff;

        if(Phase == PHASE_GROUND || Phase == PHASE_NULL)
        {
            for(uint32 i = 2; i <= 7; i++)
            {
                if(Timer[i])
                {
                    if(Timer[i] <= diff)
                        ProcessEvent((EventFelmyst)i);
                    else
                        Timer[i] -= diff;
                }
            }
            CastNextSpellIfAnyAndReady();
            if(Phase == PHASE_GROUND)
                DoMeleeAttackIfReady();
        }

        if(Phase == PHASE_FLIGHT)
        {
            for(uint32 i = 8; i < 10; i++)
            {
                if(Timer[i])
                {
                    if(Timer[i] <= diff)
                        ProcessEvent((EventFelmyst)i);
                    else
                        Timer[i] -= diff;
                }
            }
            CastNextSpellIfAnyAndReady();
        }
    }
};


// AI for invisible mob that is following player while Felmyst is casting Demonic Vapor on him
struct mob_felmyst_vaporAI : public ScriptedAI
{
    mob_felmyst_vaporAI(Creature *c) : ScriptedAI(c)
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        me->SetSpeed(MOVE_RUN, 1.0);
        me->SetFloatValue(UNIT_FIELD_COMBATREACH, 0.01);
    }
    void Reset() {}
    void JustRespawned()
    {
        DoZoneInCombat();
        me->CastSpell(me, SPELL_VAPOR_TRIGGER, false);  // summons 9 trail triggers, so..
        me->CastSpell(me, SPELL_TRAIL_SUMMON, true);    // ..summon one more trail trigger just on spawn
        me->CastSpell((Unit*)NULL, SPELL_VAPOR_FORCE, false);
        me->setFaction(1771);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->getVictim() || !me->getVictim()->isTargetableForAttack())
            AttackStart(SelectUnit(SELECT_TARGET_NEAREST, 0, 100.0, true));
    }
};

// AI for invisible mob leaving on felmyst vapor trail (summoned by SPELL_VAPOR_FORCE)
struct mob_felmyst_trailAI : public Scripted_NoMovementAI
{
    mob_felmyst_trailAI(Creature *c) : Scripted_NoMovementAI(c)
    {
        me->CastSpell(me, SPELL_TRAIL_TRIGGER, true);
        me->setFaction(1771);
        Delay = 6000;
        Despawn = 20000;
    }

    uint32 Delay;   // timer for Unyielding Dead summoning
    uint32 Despawn; // for despawning

    void SpellHitTarget(Unit* target, const SpellEntry *entry)
    {
        if(entry->Id == SPELL_TRAIL_DAMAGE && target->isTargetableForAttack())
            DoCast(me, SPELL_DEAD_SUMMON);
    }

    void JustSummoned(Creature* summon)
    {
        Map::PlayerList const& players = me->GetMap()->GetPlayers();
        if (!players.isEmpty())
        {
            for(Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if(Player* plr = itr->getSource())
                {
                    summon->SetInCombatWith(plr);
                    summon->AddThreat(plr, 0.0f);
                }
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(Delay < diff)
        {
            DoCast(me, SPELL_DEAD_SUMMON);
            Delay = 30000;  // will despawn sooner
        }
        else
            Delay -= diff;

        if(Despawn < diff)
            me->ForcedDespawn();
        else
            Despawn -= diff;
    }
};

CreatureAI* GetAI_boss_felmyst(Creature *_Creature)
{
    return new boss_felmystAI(_Creature);
}

CreatureAI* GetAI_mob_felmyst_vapor(Creature *_Creature)
{
    return new mob_felmyst_vaporAI(_Creature);
}

CreatureAI* GetAI_mob_felmyst_trail(Creature *_Creature)
{
    return new mob_felmyst_trailAI(_Creature);
}

void AddSC_boss_felmyst()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_felmyst";
    newscript->GetAI = &GetAI_boss_felmyst;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_felmyst_vapor";
    newscript->GetAI = &GetAI_mob_felmyst_vapor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_felmyst_trail";
    newscript->GetAI = &GetAI_mob_felmyst_trail;
    newscript->RegisterSelf();
}
