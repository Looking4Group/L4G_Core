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

#ifndef CAMERA_H
#define CAMERA_H

#include "Common.h"
#include "GridDefines.h"

class ViewPoint;
class WorldObject;
class UpdateData;
class WorldPacket;
class Player;

/// Camera - object-receiver. Receives broadcast packets from nearby worldobjects, object visibility changes and sends them to client
class LOOKING4GROUP_IMPORT_EXPORT Camera
{
    friend class ViewPoint;
    public:

        explicit Camera(Player* pl);
        ~Camera();

        WorldObject* GetBody() { return _source;}
        Player* GetOwner() { return &_owner;}

        // set camera's view to any worldobject
        // Note: this worldobject must be in same map, in same phase with camera's owner(player)
        // client supports only unit and dynamic objects as farsight objects
        void SetView(WorldObject *obj, bool update_far_sight_field = true);

        // set view to camera's owner
        void ResetView(bool update_far_sight_field = true);

        template<class T>
        void UpdateVisibilityOf(T * obj, UpdateData &d, std::set<WorldObject*>& vis);
        void UpdateVisibilityOf(WorldObject* obj);

        void ReceivePacket(WorldPacket *data);

        // updates visibility of worldobjects around viewpoint for camera's owner
        void UpdateVisibilityForOwner();

    private:
        // called when viewpoint changes visibility state
        void Event_AddedToWorld();
        void Event_RemovedFromWorld();
        void Event_Moved();
        void Event_ViewPointVisibilityChanged();

        Player& _owner;
        WorldObject* _source;

        void UpdateForCurrentViewPoint();

    public:
        GridReference<Camera>& GetGridRef() { return _gridRef; }
        bool isActiveObject() const { return false; }
    private:
        GridReference<Camera> _gridRef;
};

/// Object-observer, notifies farsight object state to cameras that attached to it
class LOOKING4GROUP_IMPORT_EXPORT ViewPoint
{
    friend class Camera;

    typedef std::list<Camera*> CameraList;

    CameraList _cameras;
    GridType * _grid;

    void Attach(Camera* c) { _cameras.push_back(c); }
    void Detach(Camera* c) { 
        if(c && !_cameras.empty())
            _cameras.remove(c); 
    }

    void CameraCall(void (Camera::*handler)())
    {
        if (!_cameras.empty())
        {
            for(CameraList::iterator itr = _cameras.begin(); itr != _cameras.end();)
            {
                if (Camera *c = *(itr++))
                    (c->*handler)();
            }
        }
    }

public:

    ViewPoint() : _grid(0) {}
    ~ViewPoint();

    bool hasViewers() const { return !_cameras.empty(); }

    // these events are called when viewpoint changes visibility state
    void Event_AddedToWorld(GridType *grid)
    {
        _grid = grid;
        CameraCall(&Camera::Event_AddedToWorld);
    }

    void Event_RemovedFromWorld()
    {
        _grid = NULL;
        CameraCall(&Camera::Event_RemovedFromWorld);
    }

    void Event_GridChanged(GridType *grid)
    {
        _grid = grid;
        CameraCall(&Camera::Event_Moved);
    }

    void Event_ViewPointVisibilityChanged()
    {
        CameraCall(&Camera::Event_ViewPointVisibilityChanged);
    }

    void Call_UpdateVisibilityForOwner()
    {
        CameraCall(&Camera::UpdateVisibilityForOwner);
    }
};

#endif
