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

#include "FleeingMovementGenerator.h"

#include "Unit.h"
#include "CreatureAIImpl.h"

#include "VMapFactory.h"

#include "movement/MoveSplineInit.h"
#include "movement/MoveSpline.h"

template<>
void FleeingMovementGenerator<Creature>::_moveToNextLocation(Creature &unit)
{
    Position dest;
    if (!_getPoint(unit, dest))
        return;

    PathFinder path(&unit);
    path.setPathLengthLimit(30.0f);

    bool resultHitPosition;
    resultHitPosition = VMAP::VMapFactory::createOrGetVMapManager()->getObjectHitPos(unit.GetMapId(), unit.GetPositionX(), unit.GetPositionY(), unit.GetPositionZ() + 0.5f, dest.x, dest.y, dest.z + 0.5f, dest.x, dest.y, dest.z, -0.5f);

    bool result = path.calculate(dest.x, dest.y, dest.z);

    if (!result || path.getPathType() & PATHFIND_NOPATH)
        unit.GetPosition(dest);

    Movement::MoveSplineInit init(unit);
    if (path.getPathType() & PATHFIND_NOPATH)
        init.MoveTo(dest.x, dest.y, dest.z);
    else
        init.MovebyPath(path.getPath());

    init.SetWalk(false);
    init.Launch();

    static_cast<MovementGenerator*>(this)->_recalculateTravel = false;

    if (unit.GetExactDist2d(_startPosition.x, _startPosition.y) > 30.0f)
        _nextCheckTime.Reset(2000);
    else
        _nextCheckTime.Reset(0);

    ((Creature*)&unit)->SetNoCallAssistance(false);
    ((Creature*)&unit)->CallAssistance();
}

template<>
void FleeingMovementGenerator<Player>::_moveToNextLocation(Player &unit)
{
    Position dest;
    if (!_getPoint(unit, dest))
        return;

    PathFinder path(&unit);
    path.setPathLengthLimit(30.0f);

    bool result = path.calculate(dest.x, dest.y, dest.z);

    if (!result || path.getPathType() & PATHFIND_NOPATH)
        unit.GetPosition(dest);

    Movement::MoveSplineInit init(unit);
    if (path.getPathType() & PATHFIND_NOPATH)
        init.MoveTo(dest.x, dest.y, dest.z);
    else
        init.MovebyPath(path.getPath());

    init.SetWalk(false);
    init.Launch();

    static_cast<MovementGenerator*>(this)->_recalculateTravel = false;

    if (unit.GetExactDist2d(_startPosition.x, _startPosition.y) > 30.0f)
        _nextCheckTime.Reset(2000);
    else
        _nextCheckTime.Reset(0);
}

template<class UNIT>
bool FleeingMovementGenerator<UNIT>::_getPoint(UNIT &unit, Position &dest)
{
    Position tmp;
    float angle_inc = 0.0f;
    float angle_dec = 0.0f;

    // If distance from start position > 30.0f, get random angle (blizzlike)
    if (unit.GetExactDist2d(_startPosition.x, _startPosition.y) > 30.0f)
        _angle_rand = frand(0, M_PI * 2.0f);
    else
        _angle_rand = 0.0f;

    // Get temp point (for check)
    unit.GetValidPointInAngle(tmp, 12.0f, _isFirstPoint ? _angle : _angle_rand, true, true);

    // Get correct angle (for destination point)
    if (unit.GetExactDist2d(tmp.x, tmp.y) < 10.0f)
    {
        for (uint8 i = 0; i < 6; ++i)
        {
            angle_inc += M_PI/6;
            unit.GetValidPointInAngle(tmp, 9.5f, angle_inc, true, true);
            if (unit.GetExactDist2d(tmp.x, tmp.y) < 9.0f || fabs(_startPosition.z - tmp.z) > COMMON_ALLOW_HEIGHT_DIFF)
                continue;
            else
                break;
        }
        for (uint8 i = 0; i < 6; ++i)
        {
            angle_dec -= M_PI/6;
            unit.GetValidPointInAngle(tmp, 9.5f, angle_dec, true, true);
            if (unit.GetExactDist2d(tmp.x, tmp.y) < 9.0f || fabs(_startPosition.z - tmp.z) > COMMON_ALLOW_HEIGHT_DIFF)
                continue;
            else
                break;
        }

        // Get destination point with correct angle
        unit.GetValidPointInAngle(dest, 8.0f, angle_inc < -angle_dec ? angle_inc : angle_dec, true, true);
        _isFirstPoint = false;
        return true;
    }
    else
    {
        unit.GetValidPointInAngle(dest, 8.0f, _isFirstPoint ? _angle : _angle_rand, true, true);

        _isFirstPoint = false;
        return true;
    }
}

template<class UNIT>
void FleeingMovementGenerator<UNIT>::Initialize(UNIT &unit)
{
    _angle = frand(0, M_PI * 2.0f);

    _nextCheckTime.Reset(0);

    unit.InterruptNonMeleeSpells(false);

    unit.StopMoving();
    unit.addUnitState(UNIT_STAT_FLEEING);

    _isFirstPoint = true;
    unit.GetPosition(_startPosition);
}

template<class UNIT>
bool FleeingMovementGenerator<UNIT>::Update(UNIT &unit, const uint32 & time_diff)
{
    unit.SetSelection(0);

    _nextCheckTime.Update(time_diff);
    if (_nextCheckTime.Passed() && unit.IsStopped())
        _moveToNextLocation(unit);
    else
    {
        if (static_cast<MovementGenerator*>(this)->_recalculateTravel)
            _moveToNextLocation(unit);
    }

    return true;
}

template<class UNIT>
void FleeingMovementGenerator<UNIT>::Finalize(UNIT &unit)
{
    Interrupt(unit);

    unit.clearUnitState(UNIT_STAT_FLEEING);
    unit.AddEvent(new AttackResumeEvent(unit), ATTACK_DISPLAY_DELAY);
}

template<class UNIT>
void FleeingMovementGenerator<UNIT>::Interrupt(UNIT &unit)
{
    unit.StopMoving();
    unit.clearUnitState(UNIT_STAT_FLEEING);
}

template<class UNIT>
void FleeingMovementGenerator<UNIT>::Reset(UNIT &unit)
{
    Initialize(unit);
}

template void FleeingMovementGenerator<Player>::Initialize(Player &);
template void FleeingMovementGenerator<Creature>::Initialize(Creature &);
template bool FleeingMovementGenerator<Player>::_getPoint(Player &, Position &);
template bool FleeingMovementGenerator<Creature>::_getPoint(Creature &, Position &);
template void FleeingMovementGenerator<Player>::_moveToNextLocation(Player &);
template void FleeingMovementGenerator<Creature>::_moveToNextLocation(Creature &);
template void FleeingMovementGenerator<Player>::Interrupt(Player &);
template void FleeingMovementGenerator<Creature>::Interrupt(Creature &);
template void FleeingMovementGenerator<Player>::Reset(Player &);
template void FleeingMovementGenerator<Creature>::Reset(Creature &);
template bool FleeingMovementGenerator<Player>::Update(Player &, const uint32 &);
template bool FleeingMovementGenerator<Creature>::Update(Creature &, const uint32 &);
template void FleeingMovementGenerator<Player>::Finalize(Player &);
template void FleeingMovementGenerator<Creature>::Finalize(Creature &);

bool TimedFleeingMovementGenerator::Update(Unit & unit, const uint32 & time_diff)
{
    _totalFleeTime.Update(time_diff);
    if (_totalFleeTime.Passed())
        return false;

    // This calls grant-parent Update method hiden by FleeingMovementGenerator::Update(Creature &, const uint32 &) version
    // This is done instead of casting Unit& to Creature& and call parent method, then we can use Unit directly
    return MovementGeneratorMedium< Creature, FleeingMovementGenerator<Creature> >::Update(unit, time_diff);
}
