/*
 * Copyright (C) 2005-2008 MaNGOS <http://www.mangosproject.org/>
 *
 * Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
 *
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

#include "PointMovementGenerator.h"
#include "Log.h"
#include "Creature.h"
#include "Player.h"
#include "CreatureAI.h"
#include "MapManager.h"
#include "World.h"

#include "movement/MoveSplineInit.h"
#include "movement/MoveSpline.h"

//----- Point Movement Generator
template<class UNIT>
void PointMovementGenerator<UNIT>::Initialize(UNIT &unit)
{
    if ( m_callStopMove )
        unit.StopMoving();

    unit.addUnitState(UNIT_STAT_ROAMING);

    Movement::MoveSplineInit init(unit);

    if (Creature *creature = unit.ToCreature())
    {
        if (creature->GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_ALWAYS_WALK)
            init.SetWalk(true);
    }

    init.MoveTo(_x, _y, _z, _generatePath);
    init.Launch();

    static_cast<MovementGenerator*>(this)->_recalculateTravel = false;
}

template<class UNIT>
void PointMovementGenerator<UNIT>::Interrupt(UNIT &unit)
{
    unit.StopMoving();
    unit.clearUnitState(UNIT_STAT_ROAMING);
}

template<class UNIT>
void PointMovementGenerator<UNIT>::Reset(UNIT &unit)
{
    Initialize(unit);
}

template<class UNIT>
bool PointMovementGenerator<UNIT>::Update(UNIT &unit, const uint32 &diff)
{
    if (static_cast<MovementGenerator*>(this)->_recalculateTravel)
        Initialize(unit);

    return !unit.IsStopped();
}

template<class UNIT>
void PointMovementGenerator<UNIT>::Finalize(UNIT &unit)
{
    unit.clearUnitState(UNIT_STAT_ROAMING);

    if (!unit.isAlive())
        return;

    if (Creature *creature = unit.ToCreature())
    {
        if (creature->AI())
            creature->AI()->MovementInform(POINT_MOTION_TYPE, _id);

        if (creature->GetFormation() && creature->GetFormation()->getLeader() && creature->GetFormation()->getLeader()->GetGUID() != creature->GetGUID())
        {
            creature->GetFormation()->ReachedWaypoint();
            creature->SetOrientation(creature->GetFormation()->getLeader()->GetOrientation());
        }
    }

    unit.AddEvent(new AttackResumeEvent(unit), ATTACK_DISPLAY_DELAY);
}

template void PointMovementGenerator<Player>::Initialize(Player&);
template void PointMovementGenerator<Creature>::Initialize(Creature&);
template void PointMovementGenerator<Player>::Finalize(Player&);
template void PointMovementGenerator<Creature>::Finalize(Creature&);
template void PointMovementGenerator<Player>::Interrupt(Player&);
template void PointMovementGenerator<Creature>::Interrupt(Creature&);
template void PointMovementGenerator<Player>::Reset(Player&);
template void PointMovementGenerator<Creature>::Reset(Creature&);
template bool PointMovementGenerator<Player>::Update(Player &, const uint32 &diff);
template bool PointMovementGenerator<Creature>::Update(Creature&, const uint32 &diff);

void AssistanceMovementGenerator::Finalize(Unit &unit)
{
    unit.clearUnitState(UNIT_STAT_ROAMING);

    ((Creature*)&unit)->SetNoCallAssistance(false);
    ((Creature*)&unit)->CallAssistance();
    if (unit.isAlive())
        unit.GetMotionMaster()->MoveSeekAssistanceDistract(sWorld.getConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_DELAY));
}

bool EffectMovementGenerator::Update(Unit &unit, const uint32 &)
{
    return !unit.movespline->Finalized();
}

void EffectMovementGenerator::Finalize(Unit &unit)
{
    if (EffectId() == EVENT_CHARGE)
        unit.clearUnitState(UNIT_STAT_CHARGING);

    if (unit.GetTypeId() != TYPEID_UNIT)
        return;

    if (((Creature&)unit).AI() && unit.movespline->Finalized())
        ((Creature&)unit).AI()->MovementInform(EFFECT_MOTION_TYPE, m_Id);

    unit.AddEvent(new AttackResumeEvent(unit), ATTACK_DISPLAY_DELAY);
}

void EffectMovementGenerator::Initialize(Unit &unit)
{
    if (EffectId() == EVENT_CHARGE)
        unit.addUnitState(UNIT_STAT_CHARGING);
}
