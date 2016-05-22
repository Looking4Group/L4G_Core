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

#ifndef LOOKING4GROUP_RANDOMMOTIONGENERATOR_H
#define LOOKING4GROUP_RANDOMMOTIONGENERATOR_H

#include "MovementGenerator.h"

template<class T>
class RandomMovementGenerator : public MovementGeneratorMedium< T, RandomMovementGenerator<T> >
{
    public:
        explicit RandomMovementGenerator(const Unit &) : i_nextMoveTime(0) {}
        explicit RandomMovementGenerator(float dist) : i_nextMoveTime(0), wander_distance(dist) {}

        void _setRandomLocation(T &);
        void Initialize(T &);
        void Finalize(T &);
        void Interrupt(T &);
        void Reset(T &);
        bool Update(T &, const uint32 &);

        const char* Name() const { return "<Random>"; }
        MovementGeneratorType GetMovementGeneratorType() const { return RANDOM_MOTION_TYPE; }

        bool GetResetPosition(T&, float& x, float& y, float& z);

    private:
        TimeTrackerSmall i_nextMoveTime;
        uint32 i_nextMove;

        float wander_distance;
};

#endif
