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
#include "ConfusedMovementGenerator.h"
#include "TargetedMovementGenerator.h"
#include "IdleMovementGenerator.h"
#include "WaypointMovementGenerator.h"
#include "Timer.h"
#include "StateMgr.h"
#include "Player.h"
#include "Creature.h"

static const class staticActionInfo
{
    public:
    staticActionInfo()
    {
        actionInfo[UNIT_ACTION_IDLE](UNIT_ACTION_PRIORITY_IDLE);
        actionInfo[UNIT_ACTION_DOWAYPOINTS](UNIT_ACTION_PRIORITY_DOWAYPOINTS);
        actionInfo[UNIT_ACTION_HOME](UNIT_ACTION_PRIORITY_HOME,ACTION_TYPE_NONRESTOREABLE);
        actionInfo[UNIT_ACTION_CHASE](UNIT_ACTION_PRIORITY_CHASE);
        actionInfo[UNIT_ACTION_ASSISTANCE](UNIT_ACTION_PRIORITY_ASSISTANCE,ACTION_TYPE_NONRESTOREABLE);
        actionInfo[UNIT_ACTION_CONTROLLED](UNIT_ACTION_PRIORITY_CONTROLLED);
        actionInfo[UNIT_ACTION_CONFUSED](UNIT_ACTION_PRIORITY_CONFUSED);
        actionInfo[UNIT_ACTION_FEARED]( UNIT_ACTION_PRIORITY_FEARED);
        actionInfo[UNIT_ACTION_ROOT](UNIT_ACTION_PRIORITY_ROOT);
        actionInfo[UNIT_ACTION_STUN](UNIT_ACTION_PRIORITY_STUN);
        actionInfo[UNIT_ACTION_FEIGNDEATH](UNIT_ACTION_PRIORITY_FEIGNDEATH);
        actionInfo[UNIT_ACTION_TAXI](UNIT_ACTION_PRIORITY_TAXI,ACTION_TYPE_NONRESTOREABLE);
        actionInfo[UNIT_ACTION_EFFECT](UNIT_ACTION_PRIORITY_EFFECT,ACTION_TYPE_NONRESTOREABLE);
    }

    const StaticActionInfo& operator[](UnitActionId i) const { return actionInfo[i];}

    private:
    StaticActionInfo actionInfo[UNIT_ACTION_END];
} staticActionInfo;

// derived from IdleState_ to not write new GetMovementGeneratorType, Update
class StunnedState : public IdleMovementGenerator
{
public:

    const char* Name() const { return "<Stunned>"; }
    void Interrupt(Unit &u) {Finalize(u);}
    void Reset(Unit &u) {Initialize(u);}
    void Initialize(Unit &u)
    {
        Unit* const target = &u;
        if (!target)
            return;

        target->InterruptNonMeleeSpells(false);

        target->addUnitState(UNIT_STAT_STUNNED);

        target->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_ROTATE);

        //Clear unit movement flags
        target->m_movementInfo.RemoveMovementFlag(MOVEFLAG_MOVING);
        target->m_movementInfo.AddMovementFlag(MOVEFLAG_ROOT);

        target->StopMoving();

        if (target->GetTypeId() == TYPEID_PLAYER)
            target->SetStandState(UNIT_STAND_STATE_STAND);

        target->SendMeleeAttackStop(NULL);

        WorldPacket data(SMSG_FORCE_MOVE_ROOT, target->GetPackGUID().size() + 4);
        data << target->GetPackGUID();
        data << uint32(0);
        target->BroadcastPacket(&data, true);

        //target->SetFacingTo(target->GetOrientation());
    }

    bool Update(Unit &unit, const uint32 &)
    {
        unit.SetSelection(0);
        //unit.SetFacingToObject(&unit);
        return true;
    }

    void Finalize(Unit &u)
    {
        Unit* const target = &u;
        if (!target)
            return;

        target->clearUnitState(UNIT_STAT_STUNNED);

        if (!target->GetOwner() || !target->GetOwner()->IsMounted())
            target->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_ROTATE);

        WorldPacket data(SMSG_FORCE_MOVE_UNROOT, target->GetPackGUID().size() + 4);
        data << target->GetPackGUID();
        data << uint32(0);
        target->BroadcastPacket(&data, true);
        target->m_movementInfo.RemoveMovementFlag(MOVEFLAG_ROOT);

        target->AddEvent(new AttackResumeEvent(*target), ATTACK_DISPLAY_DELAY);
    }

};

class RootState : public IdleMovementGenerator
{
public:

    const char* Name() const { return "<Rooted>"; }
    void Interrupt(Unit &u) {Finalize(u);}
    void Reset(Unit &u) {Initialize(u);}
    void Initialize(Unit &u)
    {
        Unit* const target = &u;
        if (!target)
            return;

        target->addUnitState(UNIT_STAT_ROOT);
        target->SetSelection(0);

        target->StopMoving();

        //Save last orientation
        if (target->getVictim())
            target->SetOrientation(target->GetAngle(target->getVictim()));

        //Clear unit movement flags
        target->m_movementInfo.RemoveMovementFlag(MOVEFLAG_MOVING);
        target->m_movementInfo.AddMovementFlag(MOVEFLAG_ROOT);

        target->SendMeleeAttackStop(NULL);

        if (target->GetTypeId() == TYPEID_PLAYER)
        {
            WorldPacket data(SMSG_FORCE_MOVE_ROOT, target->GetPackGUID().size() + 4);
            data << target->GetPackGUID();
            data << target->GetUnitStateMgr().GetCounter(UNIT_ACTION_ROOT);
            target->BroadcastPacket(&data, true);
        }
        else
        {
            target->StopMoving();
            WorldPacket data(SMSG_SPLINE_MOVE_ROOT, target->GetPackGUID().size());
            data << target->GetPackGUID();
            target->BroadcastPacket(&data, true);
        }

    }

    void Finalize(Unit &u)
    {
        Unit* const target = &u;
        if (!target)
            return;

        target->clearUnitState(UNIT_STAT_ROOT);

        if (target->GetTypeId() == TYPEID_PLAYER)
        {
            WorldPacket data(SMSG_FORCE_MOVE_UNROOT, target->GetPackGUID().size() + 4);
            data << target->GetPackGUID();
            data << target->GetUnitStateMgr().GetCounter(UNIT_ACTION_ROOT);
            target->BroadcastPacket(&data, true);
        }
        else
        {
            WorldPacket data(SMSG_SPLINE_MOVE_UNROOT, target->GetPackGUID().size());
            data << target->GetPackGUID();
            target->BroadcastPacket(&data, true);
        }
        target->m_movementInfo.RemoveMovementFlag(MOVEFLAG_ROOT);

        target->SetSelection(target->getVictimGUID());
        
        if(target->GetTypeId() == TYPEID_UNIT && ((Creature*)target)->hasIgnoreVictimSelection())
            target->SetSelection(0);

        target->AddEvent(new AttackResumeEvent(*target), ATTACK_DISPLAY_DELAY);
    }
};

class FeignDeathState : public IdleMovementGenerator
{
public:

    const char* Name() const { return "<FeignDeath>"; }
    void Interrupt(Unit &u) {Finalize(u);}
    void Reset(Unit &u) {Initialize(u);}
    void Initialize(Unit &u)
    {
        Unit* const target = &u;
        if (!target)
            return;

        if (target->GetTypeId() != TYPEID_PLAYER)
            target->StopMoving();

        target->m_movementInfo.RemoveMovementFlag(MOVEFLAG_MOVING);

        target->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNKNOWN6);
        target->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
        target->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);

        target->InterruptNonMeleeSpells(true);
        target->CombatStop();
        target->getHostilRefManager().deleteReferences();
        target->addUnitState(UNIT_STAT_DIED);
        //target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_IMMUNE_OR_LOST_SELECTION);

    }

    void Finalize(Unit &u)
    {
        Unit* const target = &u;
        if (!target)
            return;

        target->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNKNOWN6);
        target->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
        target->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
        target->clearUnitState(UNIT_STAT_DIED);
    }
};

class TaxiState : public FlightPathMovementGenerator
{
public:
    TaxiState(uint32 mountDisplayId, uint32 path, uint32 startNode = 0) :
        m_displayId(mountDisplayId), FlightPathMovementGenerator(sTaxiPathNodesByPath[path], startNode), m_previewDisplayId(0)
    {
    };

public:
    const char* Name() const { return "<FlightPath>"; }
    void Interrupt(Player &u) 
    {
        _Interrupt(u);
        u.clearUnitState(UNIT_STAT_TAXI_FLIGHT);
        if (m_displayId)
            u.Unmount();
        u.RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);
        if (m_previewDisplayId)
        {
            u.Mount(m_previewDisplayId);
        }
    };

    void Reset(Player &u) 
    {
        Initialize(u);
    };

    void Initialize(Player &u)
    {
        if (m_displayId)
        {
            if (!m_previewDisplayId)
                m_previewDisplayId = u.GetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID);
            u.Mount(m_displayId);
        }
        u.getHostilRefManager().setOnlineOfflineState(false);
        u.addUnitState(UNIT_STAT_TAXI_FLIGHT);
        u.SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);
        _Initialize(u);
    };

    void Finalize(Player &u)
    {
        // remove flag to prevent send object build movement packets for flight state and crash (movement generator already not at top of stack)
        if (m_displayId)
            u.Unmount();
        u.clearUnitState(UNIT_STAT_TAXI_FLIGHT);
        u.RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);
        u.getHostilRefManager().setOnlineOfflineState(true);
        if(u.pvpInfo.inHostileArea)
            u.CastSpell(&u, 2479, true);

        _Finalize(u);

        if (m_previewDisplayId)
        {
            u.Mount(m_previewDisplayId);
        }
    };

private:
    uint32 m_displayId;
    uint32 m_previewDisplayId;
};

class ControlledState : public IdleMovementGenerator
{
public:
    ControlledState(int32 _type) : m_state(uint8(_type))
    {};

    const char* Name() const { return "<Controlled>"; }
    void Interrupt(Unit &u) {Finalize(u);}
    void Reset(Unit &u) {Initialize(u);}
    void Initialize(Unit &u)
    {
        Unit* const target = &u;
        if (!target)
            return;
    }

    void Finalize(Unit &u)
    {
        Unit* const target = &u;
        if (!target)
            return;
    }

private:
    uint8 m_state;
};

UnitActionPtr UnitStateMgr::CreateStandartState(UnitActionId stateId, ...)
{
    va_list vargs;
    va_start(vargs, stateId);

    UnitActionPtr state = NULL;
    switch (stateId)
    {
        case UNIT_ACTION_CONFUSED:
        case UNIT_ACTION_FEARED:
        case UNIT_ACTION_CHASE:
            break;
        case UNIT_ACTION_STUN:
            state = new StunnedState();
            break;
        case UNIT_ACTION_FEIGNDEATH:
            state = new FeignDeathState();
            break;
        case UNIT_ACTION_ROOT:
            state = new RootState();
            break;
        case UNIT_ACTION_CONTROLLED:
        {
            uint32 param = va_arg(vargs,int32);
            state = new ControlledState(param);
            break;
        }
        case UNIT_ACTION_TAXI:
        {
            uint32 mountDisplayId = va_arg(vargs,uint32);
            uint32 path           = va_arg(vargs,uint32);
            uint32 startNode      = va_arg(vargs,uint32);
            state = new TaxiState(mountDisplayId, path, startNode);
            break;
        }
        default:
            break;
    }

    va_end(vargs);

    if (!state)
        state = new IdleMovementGenerator();

    return state;
}

UnitStateMgr::UnitStateMgr(Unit* owner) : m_owner(owner), m_needReinit(false)
{
    for (int32 i = UNIT_ACTION_IDLE; i != UNIT_ACTION_END; ++i)
        m_stateCounter[i] = 0;

    InitDefaults(true);
}

UnitStateMgr::~UnitStateMgr()
{
}

void UnitStateMgr::InitDefaults(bool immediate)
{
    if (immediate)
    {
        m_oldAction = NULL;
        DropAllStates();
    }
    else
        m_needReinit = true;
}

void UnitStateMgr::Update(uint32 diff)
{
    if (m_needReinit)
    {
        m_needReinit = false;
        InitDefaults(true);
    }

    ActionInfo* state = CurrentState();

    if (!m_oldAction)
        m_oldAction = state->Action();
    else if (m_oldAction && m_oldAction != state->Action())
    {
        if (ActionInfo* oldAction = GetAction(m_oldAction))
        {
            if (oldAction->HasFlag(ACTION_STATE_ACTIVE) &&
                !oldAction->HasFlag(ACTION_STATE_FINALIZED) &&
                !oldAction->HasFlag(ACTION_STATE_INTERRUPTED))
                oldAction->Interrupt(this);
        }
        // else do nothing - action be deleted without interrupt/finalize (may be need correct?)
        m_oldAction = state->Action();
    }

    if (!state->Update(this, diff))
        DropAction(state->priority);
}

void UnitStateMgr::DropAction(UnitActionId actionId)
{
    DropAction(actionId, staticActionInfo[actionId].priority);
}

void UnitStateMgr::DropAction(UnitActionId actionId, UnitActionPriority priority)
{
    if (!m_actions.empty())
    {
        for (UnitActionStorage::iterator itr = m_actions.begin(); itr != m_actions.end();)
        {
            if (itr->Id == actionId)
            {
                UnitActionPriority _priority = itr->priority;
                if (_priority <= priority)
                    DropAction(_priority);

                if (m_actions.empty() || itr == m_actions.end())
                    break;

                itr = m_actions.begin();
            }
            else
                ++itr;
        }
    }
}

void UnitStateMgr::DropAction(UnitActionPriority priority)
{
    // Don't remove action with NONE priority - static
    if (priority < UNIT_ACTION_PRIORITY_IDLE)
        return;

    ActionInfo* oldInfo = CurrentState();
    UnitActionStorage::iterator itr;
    {
        for (itr = m_actions.begin(); itr != m_actions.end(); ++itr)
            if (itr->priority == priority)
                break;
    }
    if (itr != m_actions.end())
    {
        bool bActiveActionChanged = false;
        UnitActionPtr oldAction = oldInfo ? oldInfo->Action() : NULL;
        // if dropped current active state...
        if (oldInfo && itr->Action() == oldInfo->Action() && !oldInfo->HasFlag(ACTION_STATE_FINALIZED))
            bActiveActionChanged = true;

        if (itr->Action() == m_oldAction)
            m_oldAction = NULL;
        m_actions.erase(itr);

        // Finalized not ActionInfo, but real action (saved before), due to ActionInfo wrapper already deleted.
        if (bActiveActionChanged && oldAction)
            oldAction->Finalize(*GetOwner());

        // in this point we delete last link to UnitActionPtr, after this UnitAction be auto-deleted...
    }
}

void UnitStateMgr::DropActionHigherThen(UnitActionPriority priority)
{
    for (int32 i = priority + 1; i != UNIT_ACTION_PRIORITY_END; ++i)
        DropAction(UnitActionPriority(i));
}

void UnitStateMgr::PushAction(UnitActionId actionId)
{
    UnitActionPtr state = CreateStandartState(actionId);
    PushAction(actionId, state, staticActionInfo[actionId].priority, staticActionInfo[actionId].restoreable); 
}

void UnitStateMgr::PushAction(UnitActionId actionId, UnitActionPriority priority)
{
    UnitActionPtr state = CreateStandartState(actionId);
    PushAction(actionId, state, priority, ACTION_TYPE_NONRESTOREABLE);
}

void UnitStateMgr::PushAction(UnitActionId actionId, UnitActionPtr state)
{
    PushAction(actionId, state, staticActionInfo[actionId].priority, staticActionInfo[actionId].restoreable); 
}

void UnitStateMgr::PushAction(UnitActionId actionId, UnitActionPtr state, UnitActionPriority priority, eActionType restoreable)
{
    ActionInfo* oldInfo = CurrentState();
    UnitActionPriority _priority = oldInfo ? oldInfo->priority : UNIT_ACTION_PRIORITY_IDLE;

    // Only interrupt action, if not drop his below and action lower by priority
    if (oldInfo &&
        oldInfo->HasFlag(ACTION_STATE_ACTIVE) && 
        oldInfo->Id != actionId &&
        _priority < priority)
        oldInfo->Interrupt(this);

    DropAction(actionId, priority);
    DropAction(priority);

    UnitActionStorage::iterator itr;

    for (itr = m_actions.begin(); itr != m_actions.end(); ++itr)
    {
        if (itr->priority > priority)
            break;
    }

    m_actions.insert(itr,UnitActionStorage::size_type(1),ActionInfo(actionId, state, priority, restoreable));
    IncreaseCounter(actionId);
}

ActionInfo* UnitStateMgr::GetAction(UnitActionPriority priority)
{
    for (UnitActionStorage::reverse_iterator itr = m_actions.rbegin(); itr != m_actions.rend(); ++itr)
        if (itr->priority == priority)
            return &(*itr);
    return NULL;
}

ActionInfo* UnitStateMgr::GetAction(UnitActionPtr _action)
{
    for (UnitActionStorage::iterator itr = m_actions.begin(); itr != m_actions.end(); ++itr)
        if (itr->Action() == _action)
            return &(*itr);
    return NULL;
}

UnitActionPtr UnitStateMgr::CurrentAction()
{
    ActionInfo* action = CurrentState();
    return action ? action->Action() : NULL;
}

ActionInfo* UnitStateMgr::CurrentState()
{
    return m_actions.empty() ? NULL : &m_actions.back();
}

void UnitStateMgr::DropAllStates()
{
    DropActionHigherThen(UNIT_ACTION_PRIORITY_IDLE);
    PushAction(UNIT_ACTION_IDLE);
}

std::string const UnitStateMgr::GetOwnerStr() 
{
    return GetOwner()->IsInWorld() ? GetOwner()->GetGuidStr() : "<Uninitialized>"; 
};

bool ActionInfo::operator < (const ActionInfo& val) const
{
    if (priority > val.priority)
        return true;
    return false;
};

bool ActionInfo::operator == (ActionInfo& val)
{
    return (Action() == val.Action());
};

bool ActionInfo::operator == (UnitActionPtr _action)
{
    return (Action() == _action);
};

bool ActionInfo::operator != (ActionInfo& val)
{
    return (Action() != val.Action());
};

bool ActionInfo::operator != (UnitActionPtr _action)
{
    return (Action() != _action);
};

void ActionInfo::Delete()
{
    delete this;
}

void ActionInfo::Initialize(UnitStateMgr* mgr)
{
    if (HasFlag(ACTION_STATE_FINALIZED))
        return;

    if (!HasFlag(ACTION_STATE_INITIALIZED) && Action())
    {
        Action()->Initialize(*mgr->GetOwner());
        AddFlag(ACTION_STATE_INITIALIZED);
    }
    else if (Action())
    {
        Action()->Reset(*mgr->GetOwner());
        RemoveFlag(ACTION_STATE_INTERRUPTED);
    }
    RemoveFlag(ACTION_STATE_INTERRUPTED);
}

void ActionInfo::Finalize(UnitStateMgr* mgr)
{
    if (!HasFlag(ACTION_STATE_INITIALIZED) || 
        HasFlag(ACTION_STATE_FINALIZED))
        return;

    AddFlag(ACTION_STATE_FINALIZED);
    RemoveFlag(ACTION_STATE_ACTIVE);

    if (Action())
        Action()->Finalize(*mgr->GetOwner());
}

void ActionInfo::Interrupt(UnitStateMgr* mgr)
{
    if (!HasFlag(ACTION_STATE_INITIALIZED) || 
        HasFlag(ACTION_STATE_FINALIZED) ||
        HasFlag(ACTION_STATE_INTERRUPTED))
        return;

    AddFlag(ACTION_STATE_INTERRUPTED);
    RemoveFlag(ACTION_STATE_ACTIVE);

    if (Action())
        Action()->Interrupt(*mgr->GetOwner());
}

bool ActionInfo::Update(UnitStateMgr* mgr, uint32 diff)
{
    if (Action() && 
        (!HasFlag(ACTION_STATE_INITIALIZED) ||
        HasFlag(ACTION_STATE_INTERRUPTED)))
        Initialize(mgr);

    AddFlag(ACTION_STATE_ACTIVE);

    // DEBUG_FILTER_LOG(LOG_FILTER_AI_AND_MOVEGENSS, "ActionInfo: %s update action %s", mgr->GetOwnerStr().c_str(), TypeName());

    if (Action())
        return Action()->Update(*mgr->GetOwner(), diff);
    else
        return false;
}

const char* ActionInfo::TypeName() const 
{
    return (action ? action->Name() : "<empty>");
}
