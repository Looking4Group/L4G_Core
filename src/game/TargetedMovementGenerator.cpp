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

#include "ByteBuffer.h"
#include "TargetedMovementGenerator.h"
#include "Log.h"
#include "Player.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "World.h"

#include "Spell.h"

#include "movement/MoveSplineInit.h"
#include "movement/MoveSpline.h"

#include <cmath>

template<class T, typename D>
void TargetedMovementGeneratorMedium<T,D>::_setTargetLocation(T &owner)
{
    if (!_target.isValid() || !_target->IsInWorld())
        return;

    float x, y, z;
    bool targetIsVictim = owner.getVictimGUID() == _target->GetGUID();

    if (_offset && _target->IsWithinDistInMap(&owner, 2*_offset))
    {
        if (!owner.IsStopped())
            return;

        owner.GetPosition(x, y, z);
    }
    else if (!_offset)
    {
        if (_target->IsWithinMeleeRange(&owner))
        {
            if (!owner.IsStopped())
                owner.StopMoving();

            return;
        }

        // this should prevent weird behavior on tight spaces like lines between columns and bridge on BEM
        if (Pet* pet = owner.ToPet())
            _target->GetPosition(x, y, z);
        else
            // to nearest random contact position
            _target->GetRandomContactPoint(&owner, x, y, z, 0, MELEE_RANGE - 0.5f);
    }
    else
    {
        if (_target->IsWithinDistInMap(&owner, _offset))
        {
            if (!owner.IsStopped())
                owner.StopMoving();

            return;
        }

        // to at _offset distance from target and _angle from target facing
        _target->GetNearPoint(x, y, z, owner.GetObjectSize(), _offset, _angle);
    }

    if (!_path)
        _path = new PathFinder(&owner);
    // allow pets following their master to cheat while generating paths
    bool forceDest = (owner.GetObjectGuid().IsPet() && owner.hasUnitState(UNIT_STAT_FOLLOW));
    bool result = _path->calculate(x, y, z, forceDest);
    
    if (!result || _path->getPathType() & PATHFIND_NOPATH)
    {
        init.MoveTo(x, y, z);
        init.SetWalk(false);
        init.Launch();

        arrived = false;
        owner.clearUnitState(UNIT_STAT_ALL_STATE);
        return;
    }

    else if (owner.GetObjectGuid().IsPet())
         owner.clearUnitState(UNIT_STAT_IGNORE_PATHFINDING);

    init.MovebyPath(_path->getPath());
    init.SetWalk(false);
    init.Launch();

    arrived = false;
    owner.clearUnitState(UNIT_STAT_ALL_STATE);

    _targetReached = false;
    static_cast<MovementGenerator*>(this)->_recalculateTravel = false;

    Movement::MoveSplineInit init(owner);
    init.MovebyPath(_path->getPath());
    init.SetWalk(((D*)this)->EnableWalking(owner));
    init.Launch();
}

template<>
void TargetedMovementGeneratorMedium<Player,ChaseMovementGenerator<Player> >::UpdateFinalDistance(float /*fDistance*/)
{
    // nothing to do for Player
}

template<>
void TargetedMovementGeneratorMedium<Player,FollowMovementGenerator<Player> >::UpdateFinalDistance(float /*fDistance*/)
{
    // nothing to do for Player
}

template<>
void TargetedMovementGeneratorMedium<Creature,ChaseMovementGenerator<Creature> >::UpdateFinalDistance(float fDistance)
{
    _offset = fDistance;
    static_cast<MovementGenerator*>(this)->_recalculateTravel = true;
}

template<>
void TargetedMovementGeneratorMedium<Creature,FollowMovementGenerator<Creature> >::UpdateFinalDistance(float fDistance)
{
    _offset = fDistance;
    static_cast<MovementGenerator*>(this)->_recalculateTravel = true;
}

template<class T, typename D>
bool TargetedMovementGeneratorMedium<T,D>::Update(T &owner, const uint32 & time_diff)
{
    if (!_target.isValid() || !_target->IsInWorld())
        return false;

    if (!owner.isAlive())
        return true;

    // prevent crash after creature killed pet
    if (static_cast<D*>(this)->_lostTarget(owner))
        return true;

    _recheckDistance.Update(time_diff);
    if (_recheckDistance.Passed())
    {
        uint32 recheckTimer = sWorld.getConfig(CONFIG_TARGET_POS_RECHECK_TIMER);
        uint32 recalculateRange = sWorld.getConfig(CONFIG_TARGET_POS_RECALCULATION_RANGE);

         if (owner.GetObjectGuid().IsPet())
         {
             recheckTimer /= 2;
             recalculateRange /= 2;
         }

        _recheckDistance.Reset(recheckTimer);

        float allowed_dist = _offset + owner.GetObjectBoundingRadius() + recalculateRange;

        G3D::Vector3 dest = owner.movespline->FinalDestination();
        
        bool targetMoved = !_target->IsWithinDist3d(dest.x, dest.y, dest.z, allowed_dist);
        if (owner.getVictimGUID() == _target->GetGUID())
        {
            Unit* victim = owner.getVictim();
            if (!victim || !victim->isAlive())
                return false;

            if (owner.GetObjectGuid().IsPet() || owner.GetObjectGuid().IsCreature() && owner.IsStopped())
                targetMoved = !owner.IsWithinMeleeRange(victim, MELEE_RANGE + _offset);
        }

        if (targetMoved)
            _setTargetLocation(owner);
    }

    if (owner.IsStopped())
    {
        if (_angle == 0.f && !owner.HasInArc(0.01f, _target.getTarget()))
            owner.SetInFront(_target.getTarget());

        if (!_targetReached)
        {
            _targetReached = true;
            static_cast<D*>(this)->_reachTarget(owner);
        }
    }
    else
    {
        if (static_cast<MovementGenerator*>(this)->_recalculateTravel)
            _setTargetLocation(owner);
    }

    return true;
}

//-----------------------------------------------//
template<class T>
void ChaseMovementGenerator<T>::_reachTarget(T &owner)
{
    if (Creature *creature = owner.ToCreature())
        if (creature->IsAIEnabled)
            creature->AI()->MovementInform(CHASE_MOTION_TYPE, 2);

    if (owner.IsWithinMeleeRange(this->_target.getTarget()))
        owner.Attack(this->_target.getTarget(),true);
}

template<>
void ChaseMovementGenerator<Player>::Initialize(Player &owner)
{
    owner.StopMoving();
    owner.addUnitState(UNIT_STAT_CHASE);
    _setTargetLocation(owner);
}

template<>
void ChaseMovementGenerator<Creature>::Initialize(Creature &owner)
{
    owner.StopMoving();
    owner.SetWalk(false);
    owner.addUnitState(UNIT_STAT_CHASE);
    _setTargetLocation(owner);

    if (owner.IsAIEnabled)
        owner.AI()->MovementInform(CHASE_MOTION_TYPE, 1);
}

template<class T>
void ChaseMovementGenerator<T>::Finalize(T &owner)
{
    Interrupt(owner);

    if (Creature* creature = owner.ToCreature())
    {
        if (creature->IsAIEnabled)
            creature->AI()->MovementInform(CHASE_MOTION_TYPE, 0);

        if (creature->isPet())
            return;

        if (!creature->isInCombat())
            creature->GetMotionMaster()->MoveTargetedHome();
    }
}

template<class T>
void ChaseMovementGenerator<T>::Interrupt(T &owner)
{
    owner.StopMoving();
    owner.clearUnitState(UNIT_STAT_CHASE);
}

template<class T>
void ChaseMovementGenerator<T>::Reset(T &owner)
{
    Initialize(owner);
}

template<>
bool ChaseMovementGenerator<Creature>::EnableWalking(Creature &creature) const
{
    return creature.GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_ALWAYS_WALK;
}

template<>
bool ChaseMovementGenerator<Player>::EnableWalking(Player &) const
{
    return false;
}

//-----------------------------------------------//
template<>
bool FollowMovementGenerator<Creature>::EnableWalking(Creature &creature) const
{
    return _target.isValid() && _target->IsWalking();
}

template<>
bool FollowMovementGenerator<Player>::EnableWalking(Player &) const
{
    return false;
}

template<>
void FollowMovementGenerator<Player>::_updateSpeed(Player &/*u*/)
{
    // nothing to do for Player
}

template<>
void FollowMovementGenerator<Creature>::_updateSpeed(Creature &u)
{
    // pet only sync speed with owner
    if (!((Creature&)u).isPet() || !_target.isValid() || _target->GetGUID() != u.GetOwnerGUID())
        return;

    u.UpdateSpeed(MOVE_RUN,true);
    u.UpdateSpeed(MOVE_WALK,true);
    u.UpdateSpeed(MOVE_SWIM,true);
}

template<>
void FollowMovementGenerator<Player>::Initialize(Player &owner)
{
    owner.StopMoving();

    owner.addUnitState(UNIT_STAT_FOLLOW);
    _updateSpeed(owner);
    _setTargetLocation(owner);
}

template<>
void FollowMovementGenerator<Creature>::Initialize(Creature &owner)
{
    owner.StopMoving();

    owner.addUnitState(UNIT_STAT_FOLLOW);
    _updateSpeed(owner);
    _setTargetLocation(owner);
}

template<class T>
void FollowMovementGenerator<T>::Finalize(T &owner)
{
    Interrupt(owner);
}

template<class T>
void FollowMovementGenerator<T>::Interrupt(T &owner)
{
    owner.StopMoving();

    owner.clearUnitState(UNIT_STAT_FOLLOW);
    _updateSpeed(owner);
}

template<class T>
void FollowMovementGenerator<T>::Reset(T &owner)
{
    Initialize(owner);
}

//-----------------------------------------------//
template void TargetedMovementGeneratorMedium<Player,ChaseMovementGenerator<Player> >::_setTargetLocation(Player &);
template void TargetedMovementGeneratorMedium<Player,FollowMovementGenerator<Player> >::_setTargetLocation(Player &);
template void TargetedMovementGeneratorMedium<Creature,ChaseMovementGenerator<Creature> >::_setTargetLocation(Creature &);
template void TargetedMovementGeneratorMedium<Creature,FollowMovementGenerator<Creature> >::_setTargetLocation(Creature &);
template bool TargetedMovementGeneratorMedium<Player,ChaseMovementGenerator<Player> >::Update(Player &, const uint32 &);
template bool TargetedMovementGeneratorMedium<Player,FollowMovementGenerator<Player> >::Update(Player &, const uint32 &);
template bool TargetedMovementGeneratorMedium<Creature,ChaseMovementGenerator<Creature> >::Update(Creature &, const uint32 &);
template bool TargetedMovementGeneratorMedium<Creature,FollowMovementGenerator<Creature> >::Update(Creature &, const uint32 &);

template void ChaseMovementGenerator<Player>::_reachTarget(Player &);
template void ChaseMovementGenerator<Creature>::_reachTarget(Creature &);
template void ChaseMovementGenerator<Player>::Finalize(Player &);
template void ChaseMovementGenerator<Creature>::Finalize(Creature &);
template void ChaseMovementGenerator<Player>::Interrupt(Player &);
template void ChaseMovementGenerator<Creature>::Interrupt(Creature &);
template void ChaseMovementGenerator<Player>::Reset(Player &);
template void ChaseMovementGenerator<Creature>::Reset(Creature &);

template void FollowMovementGenerator<Player>::Finalize(Player &);
template void FollowMovementGenerator<Creature>::Finalize(Creature &);
template void FollowMovementGenerator<Player>::Interrupt(Player &);
template void FollowMovementGenerator<Creature>::Interrupt(Creature &);
template void FollowMovementGenerator<Player>::Reset(Player &);
template void FollowMovementGenerator<Creature>::Reset(Creature &);
