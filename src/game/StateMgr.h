/*
 * Copyright (C) 2009-2012 /dev/rsa for MaNGOS <http://getmangos.com/>
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
/* StateMgr based on idea and part of code from SilverIce (http:://github.com/SilverIce
*/
#ifndef _STATEMGR_H
#define _STATEMGR_H

#include "LockedVector.h"
#include "Common.h"
#include "MotionMaster.h"
#include "StateMgrImpl.h"
#include "MovementGenerator.h"
#include "Log.h"
#include <sstream>
#include <algorithm>
#pragma once

class Unit;
class UnitStateMgr;

struct ActionInfo
{
    ActionInfo(UnitActionId _Id, UnitActionPtr _action, UnitActionPriority _priority, bool _restoreable)
        : Id(_Id), action(_action), priority(_priority), restoreable(_restoreable), m_flags(0)
    {
    }
    ~ActionInfo() {};

    bool operator < (const ActionInfo& val) const;
    bool operator == (ActionInfo& val);
    bool operator == (UnitActionPtr _action);
    bool operator != (ActionInfo& val);
    bool operator != (UnitActionPtr _action);

    void Delete();
    void Initialize(UnitStateMgr* mgr);
    void Finalize(UnitStateMgr* mgr);
    void Interrupt(UnitStateMgr* mgr);
    bool Update(UnitStateMgr* mgr, uint32 diff);
    UnitActionPtr Action() { return action; };

    const char* TypeName() const;

    uint32 const&  GetFlags();
    void           SetFlags(uint32 flags);
    void           AddFlag(ActionUpdateState state) { m_flags |= (1 << state); };
    void           RemoveFlag(ActionUpdateState state) { m_flags &= ~(1 << state); };
    bool           HasFlag(ActionUpdateState state) const { return (m_flags & (1 << state)); };

    UnitActionId       Id;
    UnitActionPtr      action;
    UnitActionPriority priority;
    uint32             m_flags;
    bool               restoreable;
};

//typedef std::map<UnitActionPriority, ActionInfo> UnitActionStorage;
typedef ACE_Based::LockedVector<ActionInfo> UnitActionStorage;

class LOOKING4GROUP_IMPORT_EXPORT UnitStateMgr
{

protected:
    UnitStateMgr(const UnitStateMgr&);
    UnitStateMgr& operator = (const UnitStateMgr&);

public:
    explicit UnitStateMgr(Unit* owner);
    ~UnitStateMgr();

    void InitDefaults(bool immediate = true);

    void Update(uint32 diff);

    static UnitActionPtr CreateStandartState(UnitActionId stateId, ...);

    void DropAction(UnitActionId actionId);
    void DropAction(UnitActionId actionId, UnitActionPriority priority);
    void DropAction(UnitActionPriority priority);
    void DropActionHigherThen(UnitActionPriority priority);

    void DropAllStates();

    void PushAction(UnitActionId actionId);
    void PushAction(UnitActionId actionId, UnitActionPriority priority);
    void PushAction(UnitActionId actionId, UnitActionPtr state);
    void PushAction(UnitActionId actionId, UnitActionPtr state, UnitActionPriority priority, eActionType restoreable);

    ActionInfo* GetAction(UnitActionPriority priority);
    ActionInfo* GetAction(UnitActionPtr _action);

    UnitActionPtr CurrentAction();
    ActionInfo*   CurrentState();

    UnitActionId  GetCurrentState() { return CurrentState() ? CurrentState()->Id : UNIT_ACTION_IDLE; };
    Unit*         GetOwner() const  { return m_owner; };

    std::string const GetOwnerStr();

    // State counters
    uint32 const&     GetCounter(UnitActionId id) { return m_stateCounter[id]; };
    void              IncreaseCounter(UnitActionId id) { ++m_stateCounter[id]; };

private:
    UnitActionStorage m_actions;
    Unit*             m_owner;
    UnitActionPtr     m_oldAction;
    uint32            m_stateCounter[UNIT_ACTION_END];
    bool              m_needReinit;

};

#endif
