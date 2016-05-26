/*
 * Copyright (C) 2005-2010 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "Creature.h"
#include "MapManager.h"
#include "RandomMovementGenerator.h"
#include "Map.h"
#include "Util.h"

#include "movement/MoveSplineInit.h"
#include "movement/MoveSpline.h"

template<>
void RandomMovementGenerator<Creature>::_setRandomLocation(Creature &creature)
{
    Position dest;
    creature.GetRespawnCoord(dest.x, dest.y, dest.z, &dest.o, &wander_distance);

    bool is_air_ok = creature.CanFly();

    const float angle = frand(0.0f, M_PI*2.0f);
    const float range = frand(0.0f, wander_distance);

    creature.GetValidPointInAngle(dest, range, angle, false);

    Movement::MoveSplineInit init(creature);
    init.MoveTo(dest.x, dest.y, dest.z);
    init.SetWalk(true);
    init.Launch();

    static_cast<MovementGenerator*>(this)->_recalculateTravel = false;
    i_nextMoveTime.Reset(urand(500, 10000));
}

template<>
void RandomMovementGenerator<Creature>::Initialize(Creature &creature)
{
    if (!creature.isAlive())
        return;

    creature.addUnitState(UNIT_STAT_ROAMING);
    _setRandomLocation(creature);
}

template<>
void RandomMovementGenerator<Creature>::Reset(Creature &creature)
{
    Initialize(creature);
}

template<>
void RandomMovementGenerator<Creature>::Interrupt(Creature &creature)
{
    creature.clearUnitState(UNIT_STAT_ROAMING);
    creature.SetWalk(false);
}

template<>
void RandomMovementGenerator<Creature>::Finalize(Creature &creature)
{
    creature.clearUnitState(UNIT_STAT_ROAMING);
    creature.SetWalk(false);
}

template<>
bool RandomMovementGenerator<Creature>::Update(Creature &creature, const uint32 &diff)
{
    if (creature.IsStopped() || static_cast<MovementGenerator*>(this)->_recalculateTravel)
    {
        i_nextMoveTime.Update(diff);
        if (i_nextMoveTime.Passed() || static_cast<MovementGenerator*>(this)->_recalculateTravel)
            _setRandomLocation(creature);
    }
    return true;
}

template<>
bool RandomMovementGenerator<Creature>::GetResetPosition(Creature& c, float& x, float& y, float& z)
{
    float radius;
    c.GetRespawnCoord(x, y, z, NULL, &radius);

    // use current if in range
    if (c.IsInRange2d(x,y, 0, radius))
        c.GetPosition(x,y,z);

    return true;
}
