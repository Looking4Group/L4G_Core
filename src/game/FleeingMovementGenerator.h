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

#ifndef LOOKING4GROUP_FLEEINGMOVEMENTGENERATOR_H
#define LOOKING4GROUP_FLEEINGMOVEMENTGENERATOR_H

#include "MovementGenerator.h"

#include "Creature.h"

template<class UNIT>
class FleeingMovementGenerator : public MovementGeneratorMedium< UNIT, FleeingMovementGenerator<UNIT> >
{
    public:
        FleeingMovementGenerator(uint64 frightGUID) : _nextCheckTime(0), _frightGUID(frightGUID) {}

        void Initialize(UNIT &);
        void Finalize(UNIT &);
        void Interrupt(UNIT &);
        void Reset(UNIT &);
        bool Update(UNIT &, const uint32 &);

        const char* Name() const { return "<Fleeing>"; }
        MovementGeneratorType GetMovementGeneratorType() const { return FLEEING_MOTION_TYPE; }

    private:
        void _moveToNextLocation(UNIT &);
        bool _getPoint(UNIT &, Position &);

        float _angle;
        uint64 _frightGUID;
        TimeTracker _nextCheckTime;
};

class TimedFleeingMovementGenerator : public FleeingMovementGenerator<Creature>
{
    public:
        TimedFleeingMovementGenerator(uint64 fright, uint32 time) : FleeingMovementGenerator<Creature>(fright), _totalFleeTime(time) {}

        MovementGeneratorType GetMovementGeneratorType() const { return TIMED_FLEEING_MOTION_TYPE; }

        bool Update(Unit &, const uint32 &);

    private:
        TimeTracker _totalFleeTime;
};

#endif
