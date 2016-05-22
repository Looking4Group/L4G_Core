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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef LOOKING4GROUP_MAPMANAGER_H
#define LOOKING4GROUP_MAPMANAGER_H

#include "ace/Singleton.h"
#include "ace/Thread_Mutex.h"

#include "Platform/Define.h"
#include "Common.h"
#include "Map.h"
#include "GridStates.h"
#include "MapUpdater.h"

class Transport;

struct MapID
{
    explicit MapID(uint32 id) : nMapId(id), nInstanceId(0) {}
    MapID(uint32 id, uint32 instid) : nMapId(id), nInstanceId(instid) {}

    bool operator<(const MapID& val) const
    {
        if(nMapId == val.nMapId)
            return nInstanceId < val.nInstanceId;

        return nMapId < val.nMapId;
    }

    bool operator==(const MapID& val) const { return nMapId == val.nMapId && nInstanceId == val.nInstanceId; }

    uint32 nMapId;
    uint32 nInstanceId;
};

class MapManager
{
    friend class ACE_Singleton<MapManager, ACE_Thread_Mutex>;
    public:
        typedef std::map<MapID, Map* > MapMapType;

        Map* CreateMap(uint32, WorldObject const* obj);
        Map* CreateBgMap(uint32 mapid, uint32, BattleGround* bg);
        Map* FindMap(uint32 mapid, uint32 instanceId = 0) const;

        // only const version for outer users
        void DeleteInstance(uint32 mapid, uint32 instanceId);

        void Initialize(void);
        void Update(uint32 diff);

        void SetGridCleanUpDelay(uint32 t)
        {
            if (t < MIN_GRID_DELAY)
                i_gridCleanUpDelay = MIN_GRID_DELAY;
            else
                i_gridCleanUpDelay = t;
        }

        //void LoadGrid(int mapid, float x, float y, WorldObject const* obj, bool no_unload = false);
        void UnloadAll();

        static bool ExistMapAndVMap(uint32 mapid, float x, float y);
        static bool IsValidMAP(uint32 mapid);

        static bool IsValidMapCoord(uint32 mapid, float x,float y)
        {
            return IsValidMAP(mapid) && Looking4group::IsValidMapCoord(x,y);
        }

        static bool IsValidMapCoord(uint32 mapid, float x,float y,float z)
        {
            return IsValidMAP(mapid) && Looking4group::IsValidMapCoord(x,y,z);
        }

        static bool IsValidMapCoord(WorldLocation const& loc)
        {
            return IsValidMapCoord(loc.mapid,loc.coord_x,loc.coord_y,loc.coord_z,loc.orientation);
        }

        static bool IsValidMapCoord(uint32 mapid, float x,float y,float z,float o)
        {
            return IsValidMAP(mapid) && Looking4group::IsValidMapCoord(x,y,z,o);
        }

        // modulos a radian orientation to the range of 0..2PI
        static float NormalizeOrientation(float o)
        {
            // fmod only supports positive numbers. Thus we have
            // to emulate negative numbers
            if (o < 0)
            {
                float mod = o *-1;
                mod = fmod(mod, float(2.0f * M_PI));
                mod = -mod + 2.0f * M_PI;
                return mod;
            }
            return fmod(o, float(2.0f * M_PI));
        }

        void DoDelayedMovesAndRemoves();

        void LoadTransports();

        typedef std::set<Transport *> TransportSet;
        TransportSet m_Transports;

        typedef std::map<uint32, TransportSet> TransportMap;
        TransportMap m_TransportsByMap;

        bool CanPlayerEnter(uint32 mapid, Player* player);
        uint32 GenerateInstanceId() { return ++i_MaxInstanceId; }

        void InitMaxInstanceId();
        void InitializeVisibilityDistanceInfo();

        /* statistics */
        uint32 GetNumInstances();
        uint32 GetNumPlayersInInstances();

        MapUpdater* GetMapUpdater() { return &m_updater; };

        //get list of all maps
        const MapMapType& Maps() const { return i_maps; }

    private:
        GridState* i_GridStates[MAX_GRID_STATE];            // shadow entries to the global array in Map.cpp

    private:
        MapManager();
        ~MapManager();

        MapManager(const MapManager &);
        MapManager& operator=(const MapManager &);

        Map* CreateInstance(uint32 id, Player * player);
        InstanceMap* CreateInstanceMap(uint32 id, uint32 InstanceId, DungeonDifficulties difficulty, InstanceSave *save = NULL);
        BattleGroundMap* CreateBattleGroundMap(uint32 id, uint32 InstanceId, BattleGround* bg);

        uint32 i_gridCleanUpDelay;
        MapMapType i_maps;

        MapUpdater m_updater;
        uint32 i_MaxInstanceId;

        ACE_Thread_Mutex Lock;
};

#define sMapMgr (*ACE_Singleton<MapManager, ACE_Thread_Mutex>::instance())
#endif
