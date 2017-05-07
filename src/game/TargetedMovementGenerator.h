/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef LOOKING4GROUP_TARGETEDMOVEMENTGENERATOR_H
#define LOOKING4GROUP_TARGETEDMOVEMENTGENERATOR_H

#include "MovementGenerator.h"

#include "FollowerReference.h"
#include "Timer.h"
#include "Unit.h"

#include "movemap/PathFinder.h"

class TargetedMovementGeneratorBase
{
    public:
        TargetedMovementGeneratorBase(Unit &target) { _target.link(&target, this); }
        void stopFollowing() {}

    protected:
        FollowerReference _target;
};

template<class T, typename D>
class TargetedMovementGeneratorMedium
: public MovementGeneratorMedium< T, D >, public TargetedMovementGeneratorBase
{
    protected:
        TargetedMovementGeneratorMedium(Unit &target, float offset, float angle) :
            TargetedMovementGeneratorBase(target), _offset(offset), _angle(angle),
            _targetReached(false), _recheckDistance(0),
            _path(NULL)
        {
        }
        ~TargetedMovementGeneratorMedium() { delete _path; }

    public:
        bool Update(T &, const uint32 &);

        bool IsReachable() const
        {
            return (_path) ? (_path->getPathType() & PATHFIND_NORMAL) : true;
        }

        Unit* GetTarget() const { return _target.getTarget(); }

        void UpdateFinalDistance(float fDistance);

    protected:
        void _setTargetLocation(T &);

        TimeTracker _recheckDistance;
        float _offset;
        float _angle;
        bool _targetReached : 1;

        PathFinder* _path;
};

template<class T>
class ChaseMovementGenerator : public TargetedMovementGeneratorMedium<T, ChaseMovementGenerator<T> >
{
    public:
        ChaseMovementGenerator(Unit &target)
            : TargetedMovementGeneratorMedium<T, ChaseMovementGenerator<T> >(target) {}
        ChaseMovementGenerator(Unit &target, float offset, float angle)
            : TargetedMovementGeneratorMedium<T, ChaseMovementGenerator<T> >(target, offset, angle) {}
        ~ChaseMovementGenerator() {}

        const char* Name() const { return "<Chase>"; }
        MovementGeneratorType GetMovementGeneratorType() const { return CHASE_MOTION_TYPE; }

        void Initialize(T &);
        void Finalize(T &);
        void Interrupt(T &);
        void Reset(T &);

        bool EnableWalking(T &) const;
        bool _lostTarget(T &u) const { return u.getVictim() != this->GetTarget(); }
        void _reachTarget(T &);
};

template<class T>
class FollowMovementGenerator : public TargetedMovementGeneratorMedium<T, FollowMovementGenerator<T> >
{
    public:
        FollowMovementGenerator(Unit &target)
            : TargetedMovementGeneratorMedium<T, FollowMovementGenerator<T> >(target) {}
        FollowMovementGenerator(Unit &target, float offset, float angle)
            : TargetedMovementGeneratorMedium<T, FollowMovementGenerator<T> >(target, offset, angle) {}
        ~FollowMovementGenerator() {}

        const char* Name() const { return "<Follow>"; }
        MovementGeneratorType GetMovementGeneratorType() const { return FOLLOW_MOTION_TYPE; }

        void Initialize(T &);
        void Finalize(T &);
        void Interrupt(T &);
        void Reset(T &);

        bool EnableWalking(T &) const;
        bool _lostTarget(T &) const { return false; }
        void _reachTarget(T &) {}

    private:
        void _updateSpeed(T&);
};

#endif
