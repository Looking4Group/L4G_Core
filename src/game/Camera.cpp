/*
 * Copyright (C) 2005-2012 MaNGOS <http://getmangos.com/>
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

#include "Camera.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "Log.h"
#include "Player.h"
#include "ObjectAccessor.h"

Camera::Camera(Player* pl) : _owner(*pl), _source(pl)
{
    _source->GetViewPoint().Attach(this);
}

Camera::~Camera()
{
    // view of camera should be already reseted to owner (RemoveFromWorld -> Event_RemovedFromWorld -> ResetView)
    ASSERT(_source == &_owner);

    // for symmetry with constructor and way to make viewpoint's list empty
    _source->GetViewPoint().Detach(this);
}

void Camera::ReceivePacket(WorldPacket *data)
{
    _owner.SendPacketToSelf(data);
}

void Camera::UpdateForCurrentViewPoint()
{
    _gridRef.unlink();

    if (GridType* grid = _source->GetViewPoint()._grid)
        grid->AddWorldObject(this);

    UpdateVisibilityForOwner();
}

void Camera::SetView(WorldObject *obj, bool update_far_sight_field /*= true*/)
{
    ASSERT(obj);

    if (_source == obj)
        return;

    if (!_owner.IsInMap(obj))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Camera::SetView, viewpoint is not in map with camera's owner");
        return;
    }

    if (!obj->isType(TypeMask(TYPEMASK_DYNAMICOBJECT | TYPEMASK_UNIT)))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Camera::SetView, viewpoint type is not available for client");
        return;
    }

    // detach and deregister from active objects if there are no more reasons to be active
    _source->GetViewPoint().Detach(this);
    if (!_source->isActiveObject())
        _source->GetMap()->RemoveFromActive(_source);

    _source = obj;

    if (!_source->isActiveObject())
        _source->GetMap()->AddToActive(_source);

    _source->GetViewPoint().Attach(this);

    if (update_far_sight_field)
        _owner.SetGuidValue(PLAYER_FARSIGHT, (_source == &_owner ? ObjectGuid() : _source->GetObjectGuid()));

    UpdateForCurrentViewPoint();
}

void Camera::Event_ViewPointVisibilityChanged()
{
    if (!_owner.HaveAtClient(_source))
        ResetView();
}

void Camera::ResetView(bool update_far_sight_field /*= true*/)
{
    SetView(&_owner, update_far_sight_field);
}

void Camera::Event_AddedToWorld()
{
    GridType* grid = _source->GetViewPoint()._grid;
    ASSERT(grid);
    grid->AddWorldObject(this);

    UpdateVisibilityForOwner();
}

void Camera::Event_RemovedFromWorld()
{
    if (_source == &_owner)
    {
        _gridRef.unlink();
        return;
    }

    ResetView();
}

void Camera::Event_Moved()
{
    _gridRef.unlink();
    _source->GetViewPoint()._grid->AddWorldObject(this);
}

void Camera::UpdateVisibilityOf(WorldObject* target)
{
    _owner.UpdateVisibilityOf(_source, target);
}

template<class T>
void Camera::UpdateVisibilityOf(T * target, UpdateData &data, std::set<WorldObject*>& vis)
{
    _owner.template UpdateVisibilityOf<T>(_source, target, data, vis);
}

template void Camera::UpdateVisibilityOf(Player*       , UpdateData&, std::set<WorldObject*>&);
template void Camera::UpdateVisibilityOf(Creature*     , UpdateData&, std::set<WorldObject*>&);
template void Camera::UpdateVisibilityOf(Corpse*       , UpdateData&, std::set<WorldObject*>&);
template void Camera::UpdateVisibilityOf(GameObject*   , UpdateData&, std::set<WorldObject*>&);
template void Camera::UpdateVisibilityOf(DynamicObject*, UpdateData&, std::set<WorldObject*>&);

void Camera::UpdateVisibilityForOwner()
{
    Looking4group::VisibleNotifier notifier(*this);
    Cell::VisitAllObjects(_source, notifier, _source->GetMap()->GetVisibilityDistance(_source, &_owner), false);
    notifier.SendToSelf();
}

//////////////////

ViewPoint::~ViewPoint()
{
    if (!_cameras.empty())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: ViewPoint destructor called, but some cameras referenced to it");
        _cameras.clear();
    }
}
