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

#ifndef LOOKING4GROUP_IDLEMOVEMENTGENERATOR_H
#define LOOKING4GROUP_IDLEMOVEMENTGENERATOR_H

#include "MovementGenerator.h"

class LOOKING4GROUP_IMPORT_EXPORT IdleMovementGenerator : public MovementGenerator
{
    public:
        void Initialize(Unit &) {}
        void Finalize(Unit &) {}
        void Interrupt(Unit &) {}
        void Reset(Unit &);
        bool Update(Unit &, const uint32 &) { return true; }

        const char* Name() const { return "<Idle>"; };
        MovementGeneratorType GetMovementGeneratorType() const { return IDLE_MOTION_TYPE; }
};

extern IdleMovementGenerator si_idleMovement;

class LOOKING4GROUP_IMPORT_EXPORT RotateMovementGenerator : public MovementGenerator
{
    public:
        explicit RotateMovementGenerator(uint32 time, RotateDirection direction) : m_duration(time), m_maxDuration(time), m_direction(direction) {}

        void Initialize(Unit& owner);
        void Finalize(Unit& owner);
        void Interrupt(Unit& );
        void Reset(Unit& owner) { Initialize(owner); }
        bool Update(Unit& owner, const uint32& time_diff);

        const char* Name() const { return "<Rotate>"; }
        MovementGeneratorType GetMovementGeneratorType() const { return ROTATE_MOTION_TYPE; }

    private:
        uint32 m_duration, m_maxDuration;
        RotateDirection m_direction;
};

class LOOKING4GROUP_IMPORT_EXPORT DistractMovementGenerator : public MovementGenerator
{
    public:
        explicit DistractMovementGenerator(uint32 timer) : m_timer(timer) {}

        void Initialize(Unit& owner);
        void Finalize(Unit& owner);
        void Interrupt(Unit& );
        void Reset(Unit& );
        bool Update(Unit& owner, const uint32& time_diff);

        const char* Name() const { return "<Distract>"; }
        MovementGeneratorType GetMovementGeneratorType() const { return DISTRACT_MOTION_TYPE; }

    private:
        uint32 m_timer;
};

class LOOKING4GROUP_IMPORT_EXPORT AssistanceDistractMovementGenerator : public DistractMovementGenerator
{
    public:
        AssistanceDistractMovementGenerator(uint32 timer) :
            DistractMovementGenerator(timer) {}

        const char* Name() const { return "<AssistanceDistract>"; }
        MovementGeneratorType GetMovementGeneratorType() const { return ASSISTANCE_DISTRACT_MOTION_TYPE; }
        void Finalize(Unit& unit);
};

#endif
