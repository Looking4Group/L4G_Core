/*
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * Copyright (C) 2008-2009 Trinity <http://www.trinitycore.org/>
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

#include "MapManager.h"
#include "Player.h"
#include "TemporarySummon.h"
#include "GridNotifiers.h"
#include "WorldSession.h"
#include "Log.h"
#include "GridStates.h"
#include "CellImpl.h"
#include "InstanceData.h"
#include "Map.h"
#include "GridNotifiersImpl.h"
#include "Transports.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "World.h"
#include "ScriptMgr.h"
#include "Group.h"
#include "MapRefManager.h"
#include "WaypointMgr.h"
#include "BattleGround.h"
#include "GridMap.h"

#include "InstanceSaveMgr.h"
#include "VMapFactory.h"
#include "MoveMap.h"

#define DEFAULT_GRID_EXPIRY     300
#define MAX_GRID_LOAD_TIME      50
#define MAX_CREATURE_ATTACK_RADIUS  (45.0f * sWorld.getRate(RATE_CREATURE_AGGRO))

struct ScriptAction
{
    uint64 sourceGUID;
    uint64 targetGUID;
    uint64 ownerGUID;                                       // owner of source if source is item
    ScriptInfo const* script;                               // pointer to static script data
};

GridState* si_GridStates[MAX_GRID_STATE];

Map::~Map()
{
    UnloadAll();

    if (!m_scriptSchedule.empty())
        sWorld.DecreaseScheduledScriptCount(m_scriptSchedule.size());

     MMAP::MMapFactory::createOrGetMMapManager()->unloadMapInstance(m_TerrainData->GetMapId(), GetInstanceId());

    //release reference count
    if (m_TerrainData->Release())
        sTerrainMgr.UnloadTerrain(m_TerrainData->GetMapId());
}

void Map::LoadMapAndVMap(int gx,int gy)
{
    if (m_bLoadedGrids[gx][gx])
        return;

    GridMap * pInfo = m_TerrainData->Load(gx, gy);
    if (pInfo)
        m_bLoadedGrids[gx][gy] = true;
}

void Map::InitStateMachine()
{
    si_GridStates[GRID_STATE_INVALID] = new InvalidState;
    si_GridStates[GRID_STATE_ACTIVE] = new ActiveState;
    si_GridStates[GRID_STATE_IDLE] = new IdleState;
    si_GridStates[GRID_STATE_REMOVAL] = new RemovalState;
}

void Map::DeleteStateMachine()
{
    delete si_GridStates[GRID_STATE_INVALID];
    delete si_GridStates[GRID_STATE_ACTIVE];
    delete si_GridStates[GRID_STATE_IDLE];
    delete si_GridStates[GRID_STATE_REMOVAL];
}

Map::Map(uint32 id, time_t expiry, uint32 InstanceId, uint8 SpawnMode)
   : i_mapEntry (sMapStore.LookupEntry(id)), i_spawnMode(SpawnMode),
     i_id(id), i_InstanceId(InstanceId), m_unloadTimer(0), i_gridExpiry(expiry), m_TerrainData(sTerrainMgr.LoadTerrain(id)),
     m_activeNonPlayersIter(m_activeNonPlayers.end()), i_scriptLock(true)
{
    for (unsigned int j=0; j < MAX_NUMBER_OF_GRIDS; ++j)
    {
        for (unsigned int idx=0; idx < MAX_NUMBER_OF_GRIDS; ++idx)
        {
            //z code
            m_bLoadedGrids[idx][j] = false;
            setNGrid(NULL, idx, j);
        }
    }

    //lets initialize visibility distance for map
    Map::InitVisibilityDistance();

    //add reference for TerrainData object
    m_TerrainData->AddRef();

    SetBroken(false);
}

void Map::InitVisibilityDistance()
{
    //init visibility for continents
    m_ActiveObjectUpdateDistance = sWorld.GetActiveObjectUpdateDistanceOnContinents();
}

// Template specialization of utility methods
template<class T>
void Map::AddToGrid(T* obj, NGridType *grid, Cell const& cell)
{
    (*grid)(cell.CellX(), cell.CellY()).template AddGridObject<T>(obj);
}

template<>
void Map::AddToGrid(Player* obj, NGridType *grid, Cell const& cell)
{
    (*grid)(cell.CellX(), cell.CellY()).AddWorldObject(obj);
}

template<>
void Map::AddToGrid(Corpse *obj, NGridType *grid, Cell const& cell)
{
    // add to world object registry in grid
    if (obj->GetType()!=CORPSE_BONES)
    {
        (*grid)(cell.CellX(), cell.CellY()).AddWorldObject(obj);
    }
    // add to grid object store
    else
    {
        (*grid)(cell.CellX(), cell.CellY()).AddGridObject(obj);
    }
}

template<>
void Map::AddToGrid(Creature* obj, NGridType *grid, Cell const& cell)
{
    // add to world object registry in grid
    if (obj->isPet() || obj->IsTempWorldObject)
    {
        (*grid)(cell.CellX(), cell.CellY()).AddWorldObject<Creature>(obj);
    }
    // add to grid object store
    else
    {
        (*grid)(cell.CellX(), cell.CellY()).AddGridObject<Creature>(obj);
    }
    obj->SetCurrentCell(cell);
}

template<>
void Map::AddToGrid(DynamicObject* obj, NGridType *grid, Cell const& cell)
{
    if (obj->isActiveObject()) // only farsight
        (*grid)(cell.CellX(), cell.CellY()).AddWorldObject<DynamicObject>(obj);
    else
        (*grid)(cell.CellX(), cell.CellY()).AddGridObject<DynamicObject>(obj);
}

template<class T>
void Map::RemoveFromGrid(T* obj, NGridType *grid, Cell const& cell)
{
    (*grid)(cell.CellX(), cell.CellY()).template RemoveGridObject<T>(obj);
}

template<>
void Map::RemoveFromGrid(Player* obj, NGridType *grid, Cell const& cell)
{
    (*grid)(cell.CellX(), cell.CellY()).RemoveWorldObject(obj);
}

template<>
void Map::RemoveFromGrid(Corpse *obj, NGridType *grid, Cell const& cell)
{
    // remove from world object registry in grid
    if (obj->GetType()!=CORPSE_BONES)
    {
        (*grid)(cell.CellX(), cell.CellY()).RemoveWorldObject(obj);
    }
    // remove from grid object store
    else
    {
        (*grid)(cell.CellX(), cell.CellY()).RemoveGridObject(obj);
    }
}

template<>
void Map::RemoveFromGrid(Creature* obj, NGridType *grid, Cell const& cell)
{
    // remove from world object registry in grid
    if (obj->isPet() || obj->IsTempWorldObject)
    {
        (*grid)(cell.CellX(), cell.CellY()).RemoveWorldObject<Creature>(obj);
    }
    // remove from grid object store
    else
    {
        (*grid)(cell.CellX(), cell.CellY()).RemoveGridObject<Creature>(obj);
    }
}

template<>
void Map::RemoveFromGrid(DynamicObject* obj, NGridType *grid, Cell const& cell)
{
    if (obj->isActiveObject()) // only farsight
        (*grid)(cell.CellX(), cell.CellY()).RemoveWorldObject<DynamicObject>(obj);
    else
        (*grid)(cell.CellX(), cell.CellY()).RemoveGridObject<DynamicObject>(obj);
}

template<class T>
void Map::SwitchGridContainers(T* obj, bool on)
{
    CellPair p = Looking4group::ComputeCellPair(obj->GetPositionX(), obj->GetPositionY());
    if (p.x_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP || p.y_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Map::SwitchGridContainers: Object " I64FMT " have invalid coordinates X:%f Y:%f grid cell [%u:%u]", obj->GetGUID(), obj->GetPositionX(), obj->GetPositionY(), p.x_coord, p.y_coord);
        return;
    }

    Cell cell(p);
    if (!loaded(GridPair(cell.data.Part.grid_x, cell.data.Part.grid_y)))
        return;

    DEBUG_LOG("Switch object " I64FMT " from grid[%u,%u] %u", obj->GetGUID(), cell.data.Part.grid_x, cell.data.Part.grid_y, on);
    NGridType *ngrid = getNGrid(cell.GridX(), cell.GridY());
    ASSERT(ngrid != NULL);

    GridType &grid = (*ngrid)(cell.CellX(), cell.CellY());

    if (on)
    {
        grid.RemoveGridObject<T>(obj);
        grid.AddWorldObject<T>(obj);
    }
    else
    {
        grid.RemoveWorldObject<T>(obj);
        grid.AddGridObject<T>(obj);
    }
    obj->IsTempWorldObject = on;
}

template void Map::SwitchGridContainers(Creature *, bool);
template void Map::SwitchGridContainers(DynamicObject *, bool);

template<class T>
void Map::DeleteFromWorld(T* obj)
{
    // Note: In case resurrectable corpse and pet its removed from global lists in own destructor
    delete obj;
}

void Map::EnsureGridCreated(const GridPair &p)
{
    if (!getNGrid(p.x_coord, p.y_coord))
    {
        ACE_GUARD(ACE_Thread_Mutex, Guard, Lock);
        if (!getNGrid(p.x_coord, p.y_coord))
        {
            sLog.outDebug("Loading grid[%u,%u] for map %u", p.x_coord, p.y_coord, i_id);

            setNGrid(new NGridType(p.x_coord*MAX_NUMBER_OF_GRIDS + p.y_coord, p.x_coord, p.y_coord, i_gridExpiry, sWorld.getConfig(CONFIG_GRID_UNLOAD)),
                p.x_coord, p.y_coord);

            // build a linkage between this map and NGridType
            buildNGridLinkage(getNGrid(p.x_coord, p.y_coord));

            getNGrid(p.x_coord, p.y_coord)->SetGridState(GRID_STATE_IDLE);

            //z coord
            int gx = (MAX_NUMBER_OF_GRIDS - 1) - p.x_coord;
            int gy = (MAX_NUMBER_OF_GRIDS - 1) - p.y_coord;

            if (!m_bLoadedGrids[gx][gy])
                LoadMapAndVMap(gx,gy);
        }
    }
}

void Map::EnsureGridLoadedAtEnter(const Cell &cell, Player *player)
{
    EnsureGridLoaded(cell);
    NGridType *grid = getNGrid(cell.GridX(), cell.GridY());
    ASSERT(grid != NULL);


    // refresh grid state & timer
    if (grid->GetGridState() != GRID_STATE_ACTIVE)
    {
        ResetGridExpiry(*grid, 0.1f);;
        grid->SetGridState(GRID_STATE_ACTIVE);
    }
}

bool Map::EnsureGridLoaded(const Cell &cell)
{
    EnsureGridCreated(GridPair(cell.GridX(), cell.GridY()));
    NGridType *grid = getNGrid(cell.GridX(), cell.GridY());

    ASSERT(grid != NULL);
    if (!isGridObjectDataLoaded(cell.GridX(), cell.GridY()))
    {
        sLog.outDebug("Loading grid[%u,%u] for map %u instance %u", cell.GridX(), cell.GridY(), GetId(), i_InstanceId);

        ObjectGridLoader loader(*grid, this, cell);
        loader.LoadN();

        // Add resurrectable corpses to world object list in grid
        sObjectAccessor.AddCorpsesToGrid(GridPair(cell.GridX(),cell.GridY()),(*grid)(cell.CellX(), cell.CellY()), this);

        setGridObjectDataLoaded(true,cell.GridX(), cell.GridY());
        return true;
    }
    return false;
}

void Map::LoadGrid(float x, float y)
{
    CellPair pair = Looking4group::ComputeCellPair(x, y);
    Cell cell(pair);
    EnsureGridLoaded(cell);
}

bool Map::Add(Player *player)
{
    player->SetInstanceId(GetInstanceId());

    CellPair p = Looking4group::ComputeCellPair(player->GetPositionX(), player->GetPositionY());
    if(p.x_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP || p.y_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP )
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Map::Add: Player (GUID: %u) have invalid coordinates X:%f Y:%f grid cell [%u:%u]", player->GetGUIDLow(), player->GetPositionX(), player->GetPositionY(), p.x_coord, p.y_coord);
        return false;
    }

    player->GetMapRef().link(this, player);

    Cell cell(p);
    EnsureGridLoadedAtEnter(cell, player);
    NGridType *grid = getNGrid(cell.GridX(), cell.GridY());
    ASSERT(grid != NULL);
    AddToGrid(player, grid, cell);

    player->AddToWorld();

    SendInitSelf(player);
    SendInitTransports(player);

    player->GetViewPoint().Event_AddedToWorld(&(*grid)(cell.CellX(), cell.CellY()));
    //player->UpdateObjectVisibility();
    player->m_clientGUIDs.clear();
    return true;
}

template<class T>
void Map::Add(T *obj)
{
    CellPair p = Looking4group::ComputeCellPair(obj->GetPositionX(), obj->GetPositionY());

    if (p.x_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP || p.y_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Map::Add: Object " UI64FMTD " have invalid coordinates X:%f Y:%f grid cell [%u:%u]", obj->GetGUID(), obj->GetPositionX(), obj->GetPositionY(), p.x_coord, p.y_coord);
        return;
    }

    Cell cell(p);
    if (obj->IsInWorld()) // need some clean up later
    {
        obj->UpdateObjectVisibility();
        return;
    }

    if (obj->isActiveObject())
        EnsureGridLoadedAtEnter(cell);
    else
        EnsureGridCreated(GridPair(cell.GridX(), cell.GridY()));

    NGridType *grid = getNGrid(cell.GridX(), cell.GridY());
    ASSERT(grid != NULL);

    AddToGrid(obj,grid,cell);
    obj->AddToWorld();

    if (obj->isActiveObject())
        AddToActive(obj);

    DEBUG_LOG("Object %u enters grid[%u,%u]", GUID_LOPART(obj->GetGUID()), cell.GridX(), cell.GridY());

    obj->GetViewPoint().Event_AddedToWorld(&(*grid)(cell.CellX(), cell.CellY()));
    obj->UpdateObjectVisibility();
}

void Map::BroadcastPacket(WorldObject* sender, WorldPacket *msg, bool toSelf)
{
    Looking4group::PacketBroadcaster post_man(*sender, msg, toSelf ? NULL : sender->ToPlayer());
    Cell::VisitWorldObjects(sender, post_man, GetVisibilityDistance());
}

void Map::BroadcastPacketInRange(WorldObject* sender, WorldPacket *msg, float dist, bool toSelf, bool ownTeam)
{
    Looking4group::PacketBroadcaster post_man(*sender, msg, toSelf ? NULL : sender->ToPlayer(), dist, ownTeam);
    Cell::VisitWorldObjects(sender, post_man, GetVisibilityDistance());
}

void Map::BroadcastPacketExcept(WorldObject* sender, WorldPacket* msg, Player* except)
{
    Looking4group::PacketBroadcaster post_man(*sender, msg, except);
    Cell::VisitWorldObjects(sender, post_man, GetVisibilityDistance());
}

bool Map::loaded(const GridPair &p) const
{
    if (NGridType* grid_type = getNGrid(p.x_coord, p.y_coord))
    {
        return grid_type->isGridObjectDataLoaded();
    }
    return false;
}

void Map::Update(const uint32 &t_diff)
{
    MAP_UPDATE_DIFF(DiffRecorder diff("", 0))

    /// update worldsessions for existing players
    for (m_mapRefIter = m_mapRefManager.begin(); m_mapRefIter != m_mapRefManager.end(); ++m_mapRefIter)
    {
        Player* plr = m_mapRefIter->getSource();
        if (plr && plr->IsInWorld())
        {
            WorldSession * pSession = plr->GetSession();
            MapSessionFilter updater(pSession);
            pSession->Update(t_diff, updater);
        }
    }

    MAP_UPDATE_DIFF(sWorld.MapUpdateDiff().CumulateDiffFor(DIFF_SESSION_UPDATE, diff.RecordTimeFor(""), GetId()))

    /// update players at tick
    for (m_mapRefIter = m_mapRefManager.begin(); m_mapRefIter != m_mapRefManager.end(); ++m_mapRefIter)
    {
        Player* plr = m_mapRefIter->getSource();
        if (plr && plr->IsInWorld())
        {
            WorldObject::UpdateHelper helper(plr);
            helper.Update(t_diff);
        }
    }

    MAP_UPDATE_DIFF(sWorld.MapUpdateDiff().CumulateDiffFor(DIFF_PLAYER_UPDATE, diff.RecordTimeFor(""), GetId()))

    resetMarkedCells();

    Looking4group::ObjectUpdater updater(t_diff);
    // for creature
    TypeContainerVisitor<Looking4group::ObjectUpdater, GridTypeMapContainer> grid_object_update(updater);

    MAP_UPDATE_DIFF(sWorld.MapUpdateDiff().CumulateDiffFor(DIFF_CREATURE_UPDATE, diff.RecordTimeFor(""), GetId()))

    // for pets
    TypeContainerVisitor<Looking4group::ObjectUpdater, WorldTypeMapContainer> world_object_update(updater);

    MAP_UPDATE_DIFF(sWorld.MapUpdateDiff().CumulateDiffFor(DIFF_PET_UPDATE, diff.RecordTimeFor(""), GetId()))

    // the player iterator is stored in the map object
    // to make sure calls to Map::Remove don't invalidate it
    for (m_mapRefIter = m_mapRefManager.begin(); m_mapRefIter != m_mapRefManager.end(); ++m_mapRefIter)
    {
        Player* plr = m_mapRefIter->getSource();

        if (!plr->IsInWorld() || !plr->IsPositionValid())
            continue;

        CheckHostileRefFor(plr);

        CellArea area = Cell::CalculateCellArea(plr->GetPositionX(), plr->GetPositionY(), GetVisibilityDistance() + World::GetVisibleObjectGreyDistance());

        for (uint32 x = area.low_bound.x_coord; x < area.high_bound.x_coord; ++x)
        {
            for (uint32 y = area.low_bound.y_coord; y < area.high_bound.y_coord; ++y)
            {
                // marked cells are those that have been visited
                // don't visit the same cell twice
                uint32 cell_id = (y * TOTAL_NUMBER_OF_CELLS_PER_MAP) + x;
                if (!isCellMarked(cell_id))
                {
                    markCell(cell_id);
                    CellPair pair(x,y);
                    Cell cell(pair);
                    cell.SetNoCreate();
                    Visit(cell, grid_object_update);
                    Visit(cell, world_object_update);
                }
            }
        }
    }

    MAP_UPDATE_DIFF(sWorld.MapUpdateDiff().CumulateDiffFor(DIFF_PLAYER_GRID_VISIT, diff.RecordTimeFor(""), GetId()))

    // non-player active objects
    if (!m_activeNonPlayers.empty())
    {
        for (m_activeNonPlayersIter = m_activeNonPlayers.begin(); m_activeNonPlayersIter != m_activeNonPlayers.end();)
        {
            // skip not in world
            WorldObject* obj = *m_activeNonPlayersIter;

            // step before processing, in this case if Map::Remove remove next object we correctly
            // step to next-next, and if we step to end() then newly added objects can wait next update.
            ++m_activeNonPlayersIter;

            if (!obj->IsInWorld() || !obj->IsPositionValid())
                continue;

            CellArea area = Cell::CalculateCellArea(obj->GetPositionX(), obj->GetPositionY(), GetActiveObjectUpdateDistance());

            for (uint32 x = area.low_bound.x_coord; x < area.high_bound.x_coord; ++x)
            {
                for (uint32 y = area.low_bound.y_coord; y < area.high_bound.y_coord; ++y)
                {
                    // marked cells are those that have been visited
                    // don't visit the same cell twice
                    uint32 cell_id = (y * TOTAL_NUMBER_OF_CELLS_PER_MAP) + x;
                    if (!isCellMarked(cell_id))
                    {
                        markCell(cell_id);
                        CellPair pair(x,y);
                        Cell cell(pair);
                        cell.SetNoCreate();
                        Visit(cell, grid_object_update);
                        Visit(cell, world_object_update);
                    }
                }
            }
        }
    }

    MAP_UPDATE_DIFF(sWorld.MapUpdateDiff().CumulateDiffFor(DIFF_ACTIVEUNIT_GRID_VISIT, diff.RecordTimeFor(""), GetId()))

    // Send world objects and item update field changes
    SendObjectUpdates();

    MAP_UPDATE_DIFF(sWorld.MapUpdateDiff().CumulateDiffFor(DIFF_SEND_OBJECTS_UPDATE, diff.RecordTimeFor(""), GetId()))

    ///- Process necessary scripts
    if (!m_scriptSchedule.empty())
    {
        i_scriptLock = true;
        ScriptsProcess();
        i_scriptLock = false;
    }

    MAP_UPDATE_DIFF(sWorld.MapUpdateDiff().CumulateDiffFor(DIFF_PROCESS_SCRIPTS, diff.RecordTimeFor(""), GetId()))

    MoveAllCreaturesInMoveList();

    MAP_UPDATE_DIFF(sWorld.MapUpdateDiff().CumulateDiffFor(DIFF_MOVE_CREATURES_IN_LIST, diff.RecordTimeFor(""), GetId()))
}

void Map::CheckHostileRefFor(Player* plr)
{
    if (IsDungeon())
        return;

}

void Map::SendObjectUpdates()
{
    UpdateDataMapType update_players;
    for (ObjectSet::const_iterator it = i_objectsToClientUpdate.begin(); it != i_objectsToClientUpdate.end(); ++it)
    {
        if ((*it)->IsInWorld())
            (*it)->BuildUpdate(update_players);
    }

    i_objectsToClientUpdate.clear();

    WorldPacket packet;                                     // here we allocate a std::vector with a size of 0x10000
    for (UpdateDataMapType::iterator iter = update_players.begin(); iter != update_players.end(); ++iter)
    {
        if (iter->second.BuildPacket(&packet))
            iter->first->SendPacketToSelf(&packet);

        packet.clear();                                     // clean the string
    }
}



void Map::Remove(Player *player, bool remove)
{
    // this may be called during Map::Update
    // after decrement+unlink, ++m_mapRefIter will continue correctly
    // when the first element of the list is being removed
    // nocheck_prev will return the padding element of the RefManager
    // instead of NULL in the case of prev
    if (m_mapRefIter == player->GetMapRef())
        m_mapRefIter = m_mapRefIter->nocheck_prev();

    player->GetMapRef().unlink();
    CellPair p = Looking4group::ComputeCellPair(player->GetPositionX(), player->GetPositionY());
    if (p.x_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP || p.y_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP)
    {
        // invalid coordinates
        player->RemoveFromWorld();
        if (remove)
            DeleteFromWorld(player);
        else
            player->TeleportToHomebind();
        return;
    }

    Cell cell(p);

    if (!getNGrid(cell.data.Part.grid_x, cell.data.Part.grid_y))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Map::Remove() i_grids was NULL x:%d, y:%d",cell.data.Part.grid_x,cell.data.Part.grid_y);
        return;
    }

    DEBUG_LOG("Remove player %s from grid[%u,%u]", player->GetName(), cell.GridX(), cell.GridY());
    NGridType *grid = getNGrid(cell.GridX(), cell.GridY());
    ASSERT(grid != NULL);

    player->DestroyForNearbyPlayers();
    
    player->RemoveFromWorld();
    player->UpdateObjectVisibility();
    player->UpdateVisibilityAndView();

    RemoveFromGrid(player,grid,cell);
    SendRemoveTransports(player);

    if (remove)
        DeleteFromWorld(player);
}

template<class T>
void Map::Remove(T *obj, bool remove)
{
    CellPair p = Looking4group::ComputeCellPair(obj->GetPositionX(), obj->GetPositionY());
    if (p.x_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP || p.y_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Map::Remove: Object " I64FMT " have invalid coordinates X:%f Y:%f grid cell [%u:%u]", obj->GetGUID(), obj->GetPositionX(), obj->GetPositionY(), p.x_coord, p.y_coord);
        return;
    }

    Cell cell(p);
    if (!loaded(GridPair(cell.data.Part.grid_x, cell.data.Part.grid_y)))
        return;

    DEBUG_LOG("Remove object " I64FMT " from grid[%u,%u]", obj->GetGUID(), cell.data.Part.grid_x, cell.data.Part.grid_y);
    NGridType *grid = getNGrid(cell.GridX(), cell.GridY());
    ASSERT(grid != NULL);

    obj->RemoveFromWorld();
    if (obj->isActiveObject())
        RemoveFromActive(obj);

    obj->UpdateObjectVisibility();

    RemoveFromGrid(obj,grid,cell);

    if (remove)
    {
        // if option set then object already saved at this moment
        if (!sWorld.getConfig(CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY))
            obj->SaveRespawnTime();

        DeleteFromWorld(obj);
    }
}

void Map::PlayerRelocation(Player* player, float x, float y, float z, float orientation)
{
    Cell old_cell(Looking4group::ComputeCellPair(player->GetPositionX(), player->GetPositionY()));
    Cell new_cell(Looking4group::ComputeCellPair(x, y));

    player->Relocate(x, y, z, orientation);

    if (old_cell.DiffGrid(new_cell) || old_cell.DiffCell(new_cell))
    {
        // update player position for group at taxi flight
        if (player->GetGroup() && player->IsTaxiFlying())
            player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_POSITION);

        NGridType* oldGrid = getNGrid(old_cell.GridX(), old_cell.GridY());
        RemoveFromGrid(player, oldGrid,old_cell);

        if (old_cell.DiffGrid(new_cell))
            EnsureGridLoadedAtEnter(new_cell, player);

        NGridType* newGrid = getNGrid(new_cell.GridX(), new_cell.GridY());
        AddToGrid(player, newGrid, new_cell);
        player->GetViewPoint().Event_GridChanged(&(*newGrid)(new_cell.CellX(),new_cell.CellY()));
    }

    player->OnRelocated();
}

void Map::CreatureRelocation(Creature *creature, float x, float y, float z, float ang)
{
    ASSERT(CheckGridIntegrity(creature,false));

    Cell old_cell = creature->GetCurrentCell();

    CellPair new_val = Looking4group::ComputeCellPair(x, y);
    Cell new_cell(new_val);

    // delay creature move for grid/cell to grid/cell moves
    if (old_cell.DiffCell(new_cell) || old_cell.DiffGrid(new_cell))
        AddCreatureToMoveList(creature,x,y,z,ang);
    else
    {
        creature->Relocate(x, y, z, ang);
        creature->OnRelocated();
    }
}

void Map::AddCreatureToMoveList(Creature *c, float x, float y, float z, float ang)
{
    if (!c)
        return;

    i_creaturesToMove[c] = CreatureMover(x,y,z,ang);
}

void Map::MoveAllCreaturesInMoveList()
{
    while (!i_creaturesToMove.empty())
    {
        // get data and remove element;
        CreatureMoveList::iterator iter = i_creaturesToMove.begin();

        Creature* c = iter->first;
        CreatureMover cm = iter->second;

        i_creaturesToMove.erase(iter);

        // calculate cells
        CellPair new_val = Looking4group::ComputeCellPair(cm.x, cm.y);
        Cell new_cell(new_val);

        // do move or do move to respawn or remove creature if previous all fail
        if (CreatureCellRelocation(c,new_cell))
        {
            // update pos
            c->Relocate(cm.x, cm.y, cm.z, cm.ang);
            c->OnRelocated();
        }
        else
        {
            // if creature can't be moved to new cell/grid (not loaded) move it to respawn cell/grid
            // creature coordinates will be updated and notifiers send
            if (!CreatureRespawnRelocation(c))
                AddObjectToRemoveList(c);
        }
    }
}

bool Map::CreatureCellRelocation(Creature *c, Cell new_cell)
{
    Cell const& old_cell = c->GetCurrentCell();
    // same grid
    if (!old_cell.DiffGrid(new_cell))
    {
        // different cell
        if (old_cell.DiffCell(new_cell))
        {
            RemoveFromGrid(c,getNGrid(old_cell.GridX(), old_cell.GridY()),old_cell);
            AddToGrid(c,getNGrid(new_cell.GridX(), new_cell.GridY()),new_cell);
        }
        return true;
    }

    if (c->isActiveObject())
        EnsureGridLoadedAtEnter(new_cell);
    else if (loaded(GridPair(new_cell.GridX(), new_cell.GridY())))
        EnsureGridCreated(GridPair(new_cell.GridX(), new_cell.GridY()));
    else
        return false;

    NGridType* oldGrid = getNGrid(old_cell.GridX(), old_cell.GridY());
    NGridType* newGrid = getNGrid(new_cell.GridX(), new_cell.GridY());

    RemoveFromGrid(c, oldGrid, old_cell);
    AddToGrid(c, newGrid, new_cell);

    c->GetViewPoint().Event_GridChanged(&(*newGrid)(new_cell.CellX(),new_cell.CellY()));
    return true;
}

bool Map::CreatureRespawnRelocation(Creature *c)
{
    float resp_x, resp_y, resp_z, resp_o;
    c->GetRespawnCoord(resp_x, resp_y, resp_z, &resp_o);

    CellPair resp_val = Looking4group::ComputeCellPair(resp_x, resp_y);
    Cell resp_cell(resp_val);

    c->CombatStop();

    // teleport it to respawn point (like normal respawn if player see)
    if (CreatureCellRelocation(c,resp_cell))
    {
        c->Relocate(resp_x, resp_y, resp_z, resp_o);
        c->GetUnitStateMgr().InitDefaults(true);
        c->GetMotionMaster()->Initialize();

        c->OnRelocated();
        return true;
    }
    else
        return false;
}

bool Map::UnloadGrid(const uint32 &x, const uint32 &y, bool unloadAll)
{
    NGridType *grid = getNGrid(x, y);
    ASSERT(grid != NULL);

    {
        if (!unloadAll && ActiveObjectsNearGrid(x, y))
             return false;

        sLog.outDebug("Unloading grid[%u,%u] for map %u", x,y, i_id);

        ObjectGridUnloader unloader(*grid);

        if (!unloadAll)
        {
            // Finish creature moves, remove and delete all creatures with delayed remove before moving to respawn grids
            // Must know real mob position before move
            MoveAllCreaturesInMoveList();

            // move creatures to respawn grids if this is diff.grid or to remove list
            unloader.MoveToRespawnN();

            // Finish creature moves, remove and delete all creatures with delayed remove before unload
            MoveAllCreaturesInMoveList();
        }

        ObjectGridCleaner cleaner(*grid);
        cleaner.CleanN();

        RemoveAllObjectsInRemoveList();

        unloader.UnloadN();

        ASSERT(i_objectsToRemove.empty());

        delete grid;
        setNGrid(NULL, x, y);
    }
    int gx = (MAX_NUMBER_OF_GRIDS - 1) - x;
    int gy = (MAX_NUMBER_OF_GRIDS - 1) - y;

    // unload GridMap - it is reference-countable so will be deleted safely when lockCount < 1
    // also simply set Map's pointer to corresponding GridMap object to NULL
    if (m_bLoadedGrids[gx][gy])
    {
        m_bLoadedGrids[gx][gy] = false;
        m_TerrainData->Unload(gx, gy);
    }

    DEBUG_LOG("Unloading grid[%u,%u] for map %u finished", x,y, i_id);
    return true;
}

void Map::UnloadAll()
{
    // clear all delayed moves, useless anyway do this moves before map unload.
    i_creaturesToMove.clear();

    for (GridRefManager<NGridType>::iterator i = GridRefManager<NGridType>::begin(); i != GridRefManager<NGridType>::end();)
    {
        NGridType &grid(*i->getSource());
        ++i;
        UnloadGrid(grid.getX(), grid.getY(), true);       // deletes the grid and removes it from the GridRefManager
    }
}

bool Map::CheckGridIntegrity(Creature* c, bool moved) const
{
    Cell const& cur_cell = c->GetCurrentCell();

    CellPair xy_val = Looking4group::ComputeCellPair(c->GetPositionX(), c->GetPositionY());
    Cell xy_cell(xy_val);
    if (xy_cell != cur_cell)
    {
        sLog.outDebug("Creature (GUIDLow: %u) X: %f Y: %f (%s) in grid[%u,%u]cell[%u,%u] instead grid[%u,%u]cell[%u,%u]",
            c->GetGUIDLow(),
            c->GetPositionX(),c->GetPositionY(),(moved ? "final" : "original"),
            cur_cell.GridX(), cur_cell.GridY(), cur_cell.CellX(), cur_cell.CellY(),
            xy_cell.GridX(),  xy_cell.GridY(),  xy_cell.CellX(),  xy_cell.CellY());
        return true;                                        // not crash at error, just output error in debug mode
    }

    return true;
}

const char* Map::GetMapName() const
{
    return i_mapEntry ? i_mapEntry->name[sWorld.GetDefaultDbcLocale()] : "UNNAMEDMAP\x0";
}

void Map::SendInitSelf(Player * player)
{
    sLog.outDetail("Creating player data for himself %u", player->GetGUIDLow());

    UpdateData data;

    bool hasTransport = false;

    // attach to player data current transport data
    if (Transport* transport = player->GetTransport())
    {
        hasTransport = true;
        transport->BuildCreateUpdateBlockForPlayer(&data, player);
    }

    // build data for self presence in world at own client (one time for map)
    player->BuildCreateUpdateBlockForPlayer(&data, player);

    // build other passengers at transport also (they always visible and marked as visible and will not send at visibility update at add to map
    if (Transport* transport = player->GetTransport())
    {
        for (Transport::PlayerSet::const_iterator itr = transport->GetPassengers().begin();itr!=transport->GetPassengers().end();++itr)
        {
            if (player!=(*itr) && player->HaveAtClient(*itr))
            {
                hasTransport = true;
                (*itr)->BuildCreateUpdateBlockForPlayer(&data, player);
            }
        }
    }

    WorldPacket packet;
    data.BuildPacket(&packet, hasTransport);
    player->SendPacketToSelf(&packet);
}

void Map::SendInitTransports(Player * player)
{
    // Hack to send out transports
    MapManager::TransportMap& tmap = sMapMgr.m_TransportsByMap;

    // no transports at map
    if (tmap.find(player->GetMapId()) == tmap.end())
        return;

    UpdateData transData;

    MapManager::TransportSet& tset = tmap[player->GetMapId()];

    bool hasTransport = false;

    for (MapManager::TransportSet::iterator i = tset.begin(); i != tset.end(); ++i)
    {
        // send data for current transport in other place
        if ((*i) != player->GetTransport()  && (*i)->GetMapId() == GetId())
        {
            hasTransport = true;
            (*i)->BuildCreateUpdateBlockForPlayer(&transData, player);
        }
    }

    WorldPacket packet;
    transData.BuildPacket(&packet, hasTransport);
    player->SendPacketToSelf(&packet);
}

void Map::SendRemoveTransports(Player * player)
{
    // Hack to send out transports
    MapManager::TransportMap& tmap = sMapMgr.m_TransportsByMap;

    // no transports at map
    if (tmap.find(player->GetMapId()) == tmap.end())
        return;

    UpdateData transData;

    MapManager::TransportSet& tset = tmap[player->GetMapId()];

    // except used transport
    for (MapManager::TransportSet::iterator i = tset.begin(); i != tset.end(); ++i)
        if ((*i) != player->GetTransport() && (*i)->GetMapId() != GetId())
            (*i)->BuildOutOfRangeUpdateBlock(&transData);

    WorldPacket packet;
    transData.BuildPacket(&packet);
    player->SendPacketToSelf(&packet);
}

inline void Map::setNGrid(NGridType *grid, uint32 x, uint32 y)
{
    if (x >= MAX_NUMBER_OF_GRIDS || y >= MAX_NUMBER_OF_GRIDS)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: map::setNGrid() Invalid grid coordinates found: %d, %d!",x,y);
        ASSERT(false);
    }
    i_grids[x][y] = grid;
}

void Map::DelayedUpdate(const uint32 t_diff)
{
    RemoveAllObjectsInRemoveList();

    // Don't unload grids if it's battleground, since we may have manually added GOs,creatures, those doesn't load from DB at grid re-load !
    // This isn't really bother us, since as soon as we have instanced BG-s, the whole map unloads as the BG gets ended
    if (!IsBattleGroundOrArena())
    {
        for (GridRefManager<NGridType>::iterator i = GridRefManager<NGridType>::begin(); i != GridRefManager<NGridType>::end();)
        {
            NGridType *grid = i->getSource();
            GridInfo *info = i->getSource()->getGridInfoRef();
            ++i;                                                // The update might delete the map and we need the next map before the iterator gets invalid
            ASSERT(grid->GetGridState() >= 0 && grid->GetGridState() < MAX_GRID_STATE);
            si_GridStates[grid->GetGridState()]->Update(*this, *grid, *info, grid->getX(), grid->getY(), t_diff);
        }
    }
}

void Map::AddObjectToRemoveList(WorldObject *obj)
{
    ASSERT(obj->GetMapId()==GetId() && obj->GetInstanceId()==GetInstanceId());

    obj->CleanupsBeforeDelete();                    // remove or simplify at least cross referenced links

    i_objectsToRemove.insert(obj);
    //sLog.outDebug("Object (GUID: %u TypeId: %u) added to removing list.",obj->GetGUIDLow(),obj->GetTypeId());
}

void Map::AddObjectToSwitchList(WorldObject *obj, bool on)
{
    ASSERT(obj->GetMapId()==GetId() && obj->GetInstanceId()==GetInstanceId());

    std::map<WorldObject*, bool>::iterator itr = i_objectsToSwitch.find(obj);
    if (itr == i_objectsToSwitch.end())
        i_objectsToSwitch.insert(itr, std::make_pair(obj, on));
    else if (itr->second != on)
        i_objectsToSwitch.erase(itr);
    else
        ASSERT(false);
}

void Map::RemoveAllObjectsInRemoveList()
{
    while (!i_objectsToSwitch.empty())
    {
        std::map<WorldObject*, bool>::iterator itr = i_objectsToSwitch.begin();
        WorldObject *obj = itr->first;
        bool on = itr->second;
        i_objectsToSwitch.erase(itr);

        switch (obj->GetTypeId())
        {
            case TYPEID_UNIT:
                if (!((Creature*)obj)->isPet())
                    SwitchGridContainers((Creature*)obj, on);
                break;
            default:
                break;
        }
    }

    //sLog.outDebug("Object remover 1 check.");
    while (!i_objectsToRemove.empty())
    {
        std::set<WorldObject*>::iterator itr = i_objectsToRemove.begin();
        WorldObject* obj = *itr;

        switch (obj->GetTypeId())
        {
            case TYPEID_CORPSE:
            {
                Corpse* corpse = sObjectAccessor.GetCorpse(obj->GetGUID());
                if (!corpse)
                    sLog.outLog(LOG_DEFAULT, "ERROR: Try delete corpse/bones %u that not in map", obj->GetGUIDLow());
                else
                    Remove(corpse,true);
                break;
            }
            case TYPEID_DYNAMICOBJECT:
                Remove((DynamicObject*)obj,true);
                break;
            case TYPEID_GAMEOBJECT:
                Remove((GameObject*)obj,true);
                break;
            case TYPEID_UNIT:
                // in case triggered sequence some spell can continue casting after prev CleanupsBeforeDelete call
                // make sure that like sources auras/etc removed before destructor start
                Remove((Creature*)obj,true);
                break;
            default:
                sLog.outLog(LOG_DEFAULT, "ERROR: Non-grid object (TypeId: %u) in grid object removing list, ignored.",obj->GetTypeId());
                break;
        }

        i_objectsToRemove.erase(itr);
    }
    //sLog.outDebug("Object remover 2 check.");
}

uint32 Map::GetPlayersCountExceptGMs() const
{
    uint32 count = 0;
    for (MapRefManager::const_iterator itr = m_mapRefManager.begin(); itr != m_mapRefManager.end(); ++itr)
        if (!itr->getSource()->isGameMaster())
            ++count;
    return count;
}

uint32 Map::GetAlivePlayersCountExceptGMs() const
{
    uint32 count = 0;
    for (MapRefManager::const_iterator itr = m_mapRefManager.begin(); itr != m_mapRefManager.end(); ++itr)
    {
        if (!itr->getSource()->isGameMaster() && itr->getSource()->isAlive())
            ++count;
    }
    return count;
}

bool Map::ActiveObjectsNearGrid(uint32 x, uint32 y) const
{
    CellPair cell_min(x*MAX_NUMBER_OF_CELLS, y*MAX_NUMBER_OF_CELLS);
    CellPair cell_max(cell_min.x_coord + MAX_NUMBER_OF_CELLS, cell_min.y_coord+MAX_NUMBER_OF_CELLS);

    //we must find visible range in cells so we unload only non-visible cells...
    float viewDist = GetVisibilityDistance();
    int cell_range = (int)ceilf(viewDist / SIZE_OF_GRID_CELL) + 1;

    cell_min << cell_range;
    cell_min -= cell_range;
    cell_max >> cell_range;
    cell_max += cell_range;

    for (MapRefManager::const_iterator iter = m_mapRefManager.begin(); iter != m_mapRefManager.end(); ++iter)
    {
        Player* plr = iter->getSource();

        CellPair p = Looking4group::ComputeCellPair(plr->GetPositionX(), plr->GetPositionY());
        if ((cell_min.x_coord <= p.x_coord && p.x_coord <= cell_max.x_coord) &&
            (cell_min.y_coord <= p.y_coord && p.y_coord <= cell_max.y_coord))
            return true;
    }

    for (ActiveNonPlayers::const_iterator iter = m_activeNonPlayers.begin(); iter != m_activeNonPlayers.end(); ++iter)
    {
        WorldObject* obj = *iter;

        CellPair p = Looking4group::ComputeCellPair(obj->GetPositionX(), obj->GetPositionY());
        if ((cell_min.x_coord <= p.x_coord && p.x_coord <= cell_max.x_coord) &&
            (cell_min.y_coord <= p.y_coord && p.y_coord <= cell_max.y_coord))
            return true;
    }

    return false;
}

void Map::AddToActive(WorldObject* obj)
{
    m_activeNonPlayers.insert(obj);

    // also not allow unloading spawn grid to prevent creating creature clone at load
    if (Creature* c = obj->ToCreature())
    {
        if (!c->isPet() && c->GetDBTableGUIDLow())
        {
            float x,y,z;
            c->GetRespawnCoord(x,y,z);
            GridPair p = Looking4group::ComputeGridPair(x, y);
            if (getNGrid(p.x_coord, p.y_coord))
                getNGrid(p.x_coord, p.y_coord)->incUnloadActiveLock();
            else
            {
                GridPair p2 = Looking4group::ComputeGridPair(c->GetPositionX(), c->GetPositionY());
                sLog.outLog(LOG_DEFAULT, "ERROR: Active creature (GUID: %u Entry: %u) added to grid[%u,%u] but spawn grid[%u,%u] not loaded.",
                              c->GetGUIDLow(), c->GetEntry(), p.x_coord, p.y_coord, p2.x_coord, p2.y_coord);
            }
        }
    }
}

void Map::RemoveFromActive(WorldObject* obj)
{
    if (!obj)
        return;

    // Map::Update for active object in proccess
    if (m_activeNonPlayersIter != m_activeNonPlayers.end())
    {
        ActiveNonPlayers::iterator itr = m_activeNonPlayers.find(obj);
        if (itr == m_activeNonPlayers.end())
            return;

        if (itr == m_activeNonPlayersIter)
            ++m_activeNonPlayersIter;

        m_activeNonPlayers.erase(itr);
    }
    else
        m_activeNonPlayers.erase(obj);

    if (Creature* c = obj->ToCreature())
    {
        // also allow unloading spawn grid
        if (!c->isPet() && c->GetDBTableGUIDLow())
        {
            float x,y,z;
            c->GetRespawnCoord(x,y,z);
            GridPair p = Looking4group::ComputeGridPair(x, y);
            if (getNGrid(p.x_coord, p.y_coord))
                getNGrid(p.x_coord, p.y_coord)->decUnloadActiveLock();
            else
            {
                GridPair p2 = Looking4group::ComputeGridPair(c->GetPositionX(), c->GetPositionY());
                sLog.outLog(LOG_DEFAULT, "ERROR: Active creature (GUID: %u Entry: %u) removed from grid[%u,%u] but spawn grid[%u,%u] not loaded.",
                              c->GetGUIDLow(), c->GetEntry(), p.x_coord, p.y_coord, p2.x_coord, p2.y_coord);
            }
        }
    }
}

void Map::ScriptsStart(ScriptMapMap const& scripts, uint32 id, Object* source, Object* target)
{
    ///- Find the script map
    ScriptMapMap::const_iterator s = scripts.find(id);
    if (s == scripts.end())
        return;

    // prepare static data
    uint64 sourceGUID = source ? source->GetGUID() : (uint64)0; //some script commands doesn't have source
    uint64 targetGUID = target ? target->GetGUID() : (uint64)0;
    uint64 ownerGUID  = (source->GetTypeId()==TYPEID_ITEM) ? ((Item*)source)->GetOwnerGUID() : (uint64)0;

    ///- Schedule script execution for all scripts in the script map
    ScriptMap const *s2 = &(s->second);
    bool immedScript = false;
    for (ScriptMap::const_iterator iter = s2->begin(); iter != s2->end(); ++iter)
    {
        ScriptAction sa;
        sa.sourceGUID = sourceGUID;
        sa.targetGUID = targetGUID;
        sa.ownerGUID  = ownerGUID;

        sa.script = &iter->second;
        m_scriptSchedule.insert(std::pair<time_t, ScriptAction>(time_t(sWorld.GetGameTime() + iter->first), sa));
        if (iter->first == 0)
            immedScript = true;

        sWorld.IncreaseScheduledScriptsCount();
    }
    ///- If one of the effects should be immediate, launch the script execution
    if (/*start &&*/ immedScript && !i_scriptLock)
    {
        i_scriptLock = true;
        ScriptsProcess();
        i_scriptLock = false;
    }
}

void Map::ScriptCommandStart(ScriptInfo const& script, uint32 delay, Object* source, Object* target)
{
    // NOTE: script record _must_ exist until command executed

    // prepare static data
    uint64 sourceGUID = source ? source->GetGUID() : (uint64)0;
    uint64 targetGUID = target ? target->GetGUID() : (uint64)0;
    uint64 ownerGUID  = (source->GetTypeId()==TYPEID_ITEM) ? ((Item*)source)->GetOwnerGUID() : (uint64)0;

    ScriptAction sa;
    sa.sourceGUID = sourceGUID;
    sa.targetGUID = targetGUID;
    sa.ownerGUID  = ownerGUID;

    sa.script = &script;
    m_scriptSchedule.insert(std::pair<time_t, ScriptAction>(time_t(sWorld.GetGameTime() + delay), sa));

    sWorld.IncreaseScheduledScriptsCount();

    ///- If effects should be immediate, launch the script execution
    if (delay == 0 && !i_scriptLock)
    {
        i_scriptLock = true;
        ScriptsProcess();
        i_scriptLock = false;
    }
}

/// Process queued scripts
void Map::ScriptsProcess()
{
    if (m_scriptSchedule.empty())
        return;

    ///- Process overdue queued scripts
    std::multimap<time_t, ScriptAction>::iterator iter = m_scriptSchedule.begin();
                                                            // ok as multimap is a *sorted* associative container
    while (!m_scriptSchedule.empty() && (iter->first <= sWorld.GetGameTime()))
    {
        ScriptAction const& step = iter->second;

        Object* source = NULL;

        if (step.sourceGUID)
        {
            switch (GUID_HIPART(step.sourceGUID))
            {
                case HIGHGUID_ITEM:
                    // case HIGHGUID_CONTAINER: ==HIGHGUID_ITEM
                    {
                        Player* player = HashMapHolder<Player>::Find(step.ownerGUID);
                        if (player)
                            source = player->GetItemByGuid(step.sourceGUID);
                        break;
                    }
                case HIGHGUID_UNIT:
                    source = GetCreature(step.sourceGUID);
                    break;
                case HIGHGUID_PET:
                    source = HashMapHolder<Pet>::Find(step.sourceGUID);
                    break;
                case HIGHGUID_PLAYER:
                    source = HashMapHolder<Player>::Find(step.sourceGUID);
                    break;
                case HIGHGUID_GAMEOBJECT:
                    source = GetGameObject(step.sourceGUID);
                    break;
                case HIGHGUID_CORPSE:
                    source = HashMapHolder<Corpse>::Find(step.sourceGUID);
                    break;
                case HIGHGUID_MO_TRANSPORT:
                    for (MapManager::TransportSet::iterator iter = sMapMgr.m_Transports.begin(); iter != sMapMgr.m_Transports.end(); ++iter)
                    {
                        if ((*iter)->GetGUID() == step.sourceGUID)
                        {
                            source = reinterpret_cast<Object*>(*iter);
                            break;
                        }
                    }
                    break;
                default:
                    sLog.outLog(LOG_DEFAULT, "ERROR: *_script source with unsupported high guid value %u",GUID_HIPART(step.sourceGUID));
                    break;
            }
        }

        //if(source && !source->IsInWorld()) source = NULL;

        Object* target = NULL;

        if (step.targetGUID)
        {
            switch (GUID_HIPART(step.targetGUID))
            {
                case HIGHGUID_UNIT:
                    target = GetCreature(step.targetGUID);
                    break;
                case HIGHGUID_PET:
                    target = HashMapHolder<Pet>::Find(step.targetGUID);
                    break;
                case HIGHGUID_PLAYER:                       // empty GUID case also
                    target = HashMapHolder<Player>::Find(step.targetGUID);
                    break;
                case HIGHGUID_GAMEOBJECT:
                    target = GetGameObject(step.targetGUID);
                    break;
                case HIGHGUID_CORPSE:
                    target = HashMapHolder<Corpse>::Find(step.targetGUID);
                    break;
                default:
                    sLog.outLog(LOG_DEFAULT, "ERROR: *_script source with unsupported high guid value %u",GUID_HIPART(step.targetGUID));
                    break;
            }
        }

        //if(target && !target->IsInWorld()) target = NULL;

        switch (step.script->command)
        {
            case SCRIPT_COMMAND_TALK:
            {
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TALK call for NULL creature.");
                    break;
                }

                if (source->GetTypeId()!=TYPEID_UNIT)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TALK call for non-creature (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }
                if (step.script->datalong > 3)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TALK invalid chat type (%u), skipping.",step.script->datalong);
                    break;
                }

                uint64 unit_target = target ? target->GetGUID() : 0;

                //datalong 0=normal say, 1=whisper, 2=yell, 3=emote text
                switch (step.script->datalong)
                {
                    case 0:                                 // Say
                        ((Creature *)source)->Say(step.script->dataint, LANG_UNIVERSAL, unit_target);
                        break;
                    case 1:                                 // Whisper
                        if (!unit_target)
                        {
                            sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TALK attempt to whisper (%u) NULL, skipping.",step.script->datalong);
                            break;
                        }
                        ((Creature *)source)->Whisper(step.script->dataint,unit_target);
                        break;
                    case 2:                                 // Yell
                        ((Creature *)source)->Yell(step.script->dataint, LANG_UNIVERSAL, unit_target);
                        break;
                    case 3:                                 // Emote text
                        ((Creature *)source)->TextEmote(step.script->dataint, unit_target);
                        break;
                    default:
                        break;                              // must be already checked at load
                }
                break;
            }

            case SCRIPT_COMMAND_EMOTE:
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_EMOTE call for NULL creature.");
                    break;
                }

                if (source->GetTypeId()!=TYPEID_UNIT)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_EMOTE call for non-creature (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                ((Creature *)source)->HandleEmoteCommand(step.script->datalong);
                break;
            case SCRIPT_COMMAND_FIELD_SET:
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_FIELD_SET call for NULL object.");
                    break;
                }
                if (step.script->datalong <= OBJECT_FIELD_ENTRY || step.script->datalong >= source->GetValuesCount())
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_FIELD_SET call for wrong field %u (max count: %u) in object (TypeId: %u).",
                        step.script->datalong,source->GetValuesCount(),source->GetTypeId());
                    break;
                }

                source->SetUInt32Value(step.script->datalong, step.script->datalong2);
                break;
            case SCRIPT_COMMAND_MOVE_TO:
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_MOVE_TO call for NULL creature.");
                    break;
                }

                if (source->GetTypeId()!=TYPEID_UNIT)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_MOVE_TO call for non-creature (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                if (step.script->datalong2 != 0)
                {
                    float speed = ((Unit*)source)->GetDistance(step.script->x, step.script->y, step.script->z) / ((float)step.script->datalong2 * 0.001f);
                    ((Unit*)source)->MonsterMoveWithSpeed(step.script->x, step.script->y, step.script->z, speed);
                }
                else
                    ((Unit*)source)->NearTeleportTo(step.script->x, step.script->y, step.script->z, ((Unit*)source)->GetOrientation());

                break;
            case SCRIPT_COMMAND_FLAG_SET:
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_FLAG_SET call for NULL object.");
                    break;
                }
                if (step.script->datalong <= OBJECT_FIELD_ENTRY || step.script->datalong >= source->GetValuesCount())
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_FLAG_SET call for wrong field %u (max count: %u) in object (TypeId: %u).",
                        step.script->datalong,source->GetValuesCount(),source->GetTypeId());
                    break;
                }

                source->SetFlag(step.script->datalong, step.script->datalong2);

                if (source->GetTypeId() == TYPEID_UNIT && step.script->datalong == UNIT_NPC_FLAGS)
                    ((Creature *)source)->ResetGossipOptions();

                break;
            case SCRIPT_COMMAND_FLAG_REMOVE:
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_FLAG_REMOVE call for NULL object.");
                    break;
                }
                if (step.script->datalong <= OBJECT_FIELD_ENTRY || step.script->datalong >= source->GetValuesCount())
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_FLAG_REMOVE call for wrong field %u (max count: %u) in object (TypeId: %u).",
                        step.script->datalong,source->GetValuesCount(),source->GetTypeId());
                    break;
                }

                source->RemoveFlag(step.script->datalong, step.script->datalong2);

                if (source->GetTypeId() == TYPEID_UNIT && step.script->datalong == UNIT_NPC_FLAGS)
                    ((Creature *)source)->ResetGossipOptions();

                break;

            case SCRIPT_COMMAND_TELEPORT_TO:
            {
                // accept player in any one from target/source arg
                if (!target && !source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TELEPORT_TO call for NULL object.");
                    break;
                }

                                                            // must be only Player
                if ((!target || target->GetTypeId() != TYPEID_PLAYER) && (!source || source->GetTypeId() != TYPEID_PLAYER))
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TELEPORT_TO call for non-player (TypeIdSource: %u)(TypeIdTarget: %u), skipping.", source ? source->GetTypeId() : 0, target ? target->GetTypeId() : 0);
                    break;
                }

                Player* pSource = target && target->GetTypeId() == TYPEID_PLAYER ? (Player*)target : (Player*)source;

                pSource->TeleportTo(step.script->datalong, step.script->x, step.script->y, step.script->z, step.script->o);
                break;
            }

            case SCRIPT_COMMAND_TEMP_SUMMON_CREATURE:
            {
                if (!step.script->datalong)                  // creature not specified
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TEMP_SUMMON_CREATURE call for NULL creature.");
                    break;
                }

                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TEMP_SUMMON_CREATURE call for NULL world object.");
                    break;
                }

                WorldObject* summoner = dynamic_cast<WorldObject*>(source);

                if (!summoner)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TEMP_SUMMON_CREATURE call for non-WorldObject (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                float x = step.script->x;
                float y = step.script->y;
                float z = step.script->z;
                float o = step.script->o;

                Creature* pCreature = summoner->SummonCreature(step.script->datalong, x, y, z, o,TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,step.script->datalong2);
                if (!pCreature)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_TEMP_SUMMON failed for creature (entry: %u).",step.script->datalong);
                    break;
                }

                break;
            }

            case SCRIPT_COMMAND_RESPAWN_GAMEOBJECT:
            {
                if (!step.script->datalong)                  // gameobject not specified
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_RESPAWN_GAMEOBJECT call for NULL gameobject.");
                    break;
                }

                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_RESPAWN_GAMEOBJECT call for NULL world object.");
                    break;
                }

                WorldObject* summoner = dynamic_cast<WorldObject*>(source);

                if (!summoner)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_RESPAWN_GAMEOBJECT call for non-WorldObject (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                GameObject *go = NULL;
                int32 time_to_despawn = step.script->datalong2<5 ? 5 : (int32)step.script->datalong2;

                Looking4group::GameObjectWithDbGUIDCheck go_check(*summoner,step.script->datalong);
                Looking4group::ObjectSearcher<GameObject, Looking4group::GameObjectWithDbGUIDCheck> checker(go,go_check);

                Cell::VisitGridObjects(summoner, checker, GetVisibilityDistance());

                if (!go)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_RESPAWN_GAMEOBJECT failed for gameobject(guid: %u).", step.script->datalong);
                    break;
                }

                if (go->GetGoType()==GAMEOBJECT_TYPE_FISHINGNODE ||
                    go->GetGoType()==GAMEOBJECT_TYPE_FISHINGNODE ||
                    go->GetGoType()==GAMEOBJECT_TYPE_DOOR        ||
                    go->GetGoType()==GAMEOBJECT_TYPE_BUTTON      ||
                    go->GetGoType()==GAMEOBJECT_TYPE_TRAP)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_RESPAWN_GAMEOBJECT can not be used with gameobject of type %u (guid: %u).", uint32(go->GetGoType()), step.script->datalong);
                    break;
                }

                if (go->isSpawned())
                    break;                                  //gameobject already spawned

                go->SetLootState(GO_READY);
                go->SetRespawnTime(time_to_despawn);        //despawn object in ? seconds

                go->GetMap()->Add(go);
                break;
            }
            case SCRIPT_COMMAND_OPEN_DOOR:
            {
                if (!step.script->datalong)                  // door not specified
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_OPEN_DOOR call for NULL door.");
                    break;
                }

                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_OPEN_DOOR call for NULL unit.");
                    break;
                }

                if (!source->isType(TYPEMASK_UNIT))          // must be any Unit (creature or player)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_OPEN_DOOR call for non-unit (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                Unit* caster = (Unit*)source;

                GameObject *door = NULL;
                int32 time_to_close = step.script->datalong2 < 15 ? 15 : (int32)step.script->datalong2;

                Looking4group::GameObjectWithDbGUIDCheck go_check(*caster,step.script->datalong);
                Looking4group::ObjectSearcher<GameObject, Looking4group::GameObjectWithDbGUIDCheck> checker(door,go_check);

                Cell::VisitGridObjects(caster, checker, GetVisibilityDistance());

                if (!door)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_OPEN_DOOR failed for gameobject(guid: %u).", step.script->datalong);
                    break;
                }
                if (door->GetGoType() != GAMEOBJECT_TYPE_DOOR)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_OPEN_DOOR failed for non-door(GoType: %u).", door->GetGoType());
                    break;
                }

                if (door->GetGoState() != GO_STATE_READY)
                    break;                                  //door already  open

                door->UseDoorOrButton(time_to_close);

                if (target && target->isType(TYPEMASK_GAMEOBJECT) && ((GameObject*)target)->GetGoType()==GAMEOBJECT_TYPE_BUTTON)
                    ((GameObject*)target)->UseDoorOrButton(time_to_close);
                break;
            }
            case SCRIPT_COMMAND_CLOSE_DOOR:
            {
                if (!step.script->datalong)                  // guid for door not specified
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_CLOSE_DOOR call for NULL door.");
                    break;
                }

                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_CLOSE_DOOR call for NULL unit.");
                    break;
                }

                if (!source->isType(TYPEMASK_UNIT))          // must be any Unit (creature or player)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_CLOSE_DOOR call for non-unit (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                Unit* caster = (Unit*)source;

                GameObject *door = NULL;
                int32 time_to_open = step.script->datalong2 < 15 ? 15 : (int32)step.script->datalong2;

                Looking4group::GameObjectWithDbGUIDCheck go_check(*caster,step.script->datalong);
                Looking4group::ObjectSearcher<GameObject, Looking4group::GameObjectWithDbGUIDCheck> checker(door,go_check);

                Cell::VisitGridObjects(caster, checker, GetVisibilityDistance());

                if (!door)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_CLOSE_DOOR failed for gameobject(guid: %u).", step.script->datalong);
                    break;
                }

                if (door->GetGoType() != GAMEOBJECT_TYPE_DOOR)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_CLOSE_DOOR failed for non-door(GoType: %u).", door->GetGoType());
                    break;
                }

                if (door->GetGoState() == GO_STATE_READY)
                    break;                                  //door already closed

                door->UseDoorOrButton(time_to_open);

                if (target && target->isType(TYPEMASK_GAMEOBJECT) && ((GameObject*)target)->GetGoType()==GAMEOBJECT_TYPE_BUTTON)
                    ((GameObject*)target)->UseDoorOrButton(time_to_open);

                break;
            }
            case SCRIPT_COMMAND_QUEST_EXPLORED:
            {
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_QUEST_EXPLORED call for NULL source.");
                    break;
                }

                if (!target)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_QUEST_EXPLORED call for NULL target.");
                    break;
                }

                // when script called for item spell casting then target == (unit or GO) and source is player
                WorldObject* worldObject;
                Player* player;

                if (target->GetTypeId()==TYPEID_PLAYER)
                {
                    if (source->GetTypeId()!=TYPEID_UNIT && source->GetTypeId()!=TYPEID_GAMEOBJECT)
                    {
                        sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_QUEST_EXPLORED call for non-creature and non-gameobject (TypeId: %u), skipping.",source->GetTypeId());
                        break;
                    }

                    worldObject = (WorldObject*)source;
                    player = (Player*)target;
                }
                else
                {
                    if (target->GetTypeId()!=TYPEID_UNIT && target->GetTypeId()!=TYPEID_GAMEOBJECT)
                    {
                        sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_QUEST_EXPLORED call for non-creature and non-gameobject (TypeId: %u), skipping.",target->GetTypeId());
                        break;
                    }

                    if (source->GetTypeId()!=TYPEID_PLAYER)
                    {
                        sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_QUEST_EXPLORED call for non-player(TypeId: %u), skipping.",source->GetTypeId());
                        break;
                    }

                    worldObject = (WorldObject*)target;
                    player = (Player*)source;
                }

                // quest id and flags checked at script loading
                if ((worldObject->GetTypeId()!=TYPEID_UNIT || ((Unit*)worldObject)->isAlive()) &&
                    (step.script->datalong2==0 || worldObject->IsWithinDistInMap(player,float(step.script->datalong2))))
                    player->AreaExploredOrEventHappens(step.script->datalong);
                else
                    player->FailQuest(step.script->datalong);

                break;
            }

            case SCRIPT_COMMAND_ACTIVATE_OBJECT:
            {
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_ACTIVATE_OBJECT must have source caster.");
                    break;
                }

                if (!source->isType(TYPEMASK_UNIT))
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_ACTIVATE_OBJECT source caster isn't unit (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                if (!target)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_ACTIVATE_OBJECT call for NULL gameobject.");
                    break;
                }

                if (target->GetTypeId()!=TYPEID_GAMEOBJECT)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_ACTIVATE_OBJECT call for non-gameobject (TypeId: %u), skipping.",target->GetTypeId());
                    break;
                }

                Unit* caster = (Unit*)source;

                GameObject *go = (GameObject*)target;

                go->Use(caster);
                break;
            }

            case SCRIPT_COMMAND_REMOVE_AURA:
            {
                Object* cmdTarget = step.script->datalong2 ? source : target;

                if (!cmdTarget)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_REMOVE_AURA call for NULL %s.",step.script->datalong2 ? "source" : "target");
                    break;
                }

                if (!cmdTarget->isType(TYPEMASK_UNIT))
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_REMOVE_AURA %s isn't unit (TypeId: %u), skipping.",step.script->datalong2 ? "source" : "target",cmdTarget->GetTypeId());
                    break;
                }

                ((Unit*)cmdTarget)->RemoveAurasDueToSpell(step.script->datalong);
                break;
            }

            case SCRIPT_COMMAND_CAST_SPELL:
            {
                if (!source)
                {
                    sLog.outDebug("SCRIPT_COMMAND_CAST_SPELL must have source caster.");
                    break;
                }

                if (!source->isType(TYPEMASK_UNIT))
                {
                    sLog.outDebug("SCRIPT_COMMAND_CAST_SPELL source caster isn't unit (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                Object* cmdTarget = step.script->datalong2 ? source : target;

                if (!cmdTarget)
                {
                    sLog.outDebug("SCRIPT_COMMAND_CAST_SPELL call for NULL %s.",step.script->datalong2 ? "source" : "target");
                    break;
                }

                if (!cmdTarget->isType(TYPEMASK_UNIT))
                {
                    sLog.outDebug("SCRIPT_COMMAND_CAST_SPELL %s isn't unit (TypeId: %u), skipping.",step.script->datalong2 ? "source" : "target",cmdTarget->GetTypeId());
                    break;
                }

                Unit* spellTarget = (Unit*)cmdTarget;

                //TODO: when GO cast implemented, code below must be updated accordingly to also allow GO spell cast
                ((Unit*)source)->CastSpell(spellTarget,step.script->datalong,false);

                break;
            }

            case SCRIPT_COMMAND_LOAD_PATH:
            {
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_START_MOVE is tried to apply to NON-existing unit.");
                    break;
                }

                if (!source->isType(TYPEMASK_UNIT))
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_START_MOVE source mover isn't unit (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                if (!sWaypointMgr.GetPath(step.script->datalong) && step.script->datalong != 0)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_START_MOVE source mover has an invallid path, skipping.", step.script->datalong2);
                    break;
                }
                // If path ID is 0, stop movement.
                if (step.script->datalong == 0)
                {
                    dynamic_cast<Unit*>(source)->GetMotionMaster()->MoveIdle();
                    break;
                }
                else
                {
                    // Stop moving on old path and load the new one
                    dynamic_cast<Unit*>(source)->GetMotionMaster()->MovementExpired();
                    dynamic_cast<Unit*>(source)->GetMotionMaster()->MovePath(step.script->datalong, step.script->datalong2);
                    break;
                }
                break;
            }

            case SCRIPT_COMMAND_CALLSCRIPT_TO_UNIT:
            {
                if (!step.script->datalong || !step.script->datalong2)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_CALLSCRIPT calls invallid db_script_id or lowguid not present: skipping.");
                    break;
                }
                //our target
                Creature* target = NULL;

                if (source) //using grid searcher
                {
                    //sLog.outDebug("Attempting to find Creature: Db GUID: %i", step.script->datalong);
                    Looking4group::CreatureWithDbGUIDCheck target_check(((Unit*)source), step.script->datalong);
                    Looking4group::ObjectSearcher<Creature, Looking4group::CreatureWithDbGUIDCheck> checker(target,target_check);

                    Cell::VisitGridObjects((Unit*)source, checker, GetVisibilityDistance());
                }
                else //check hashmap holders
                {
                    if (CreatureData const* data = sObjectMgr.GetCreatureData(step.script->datalong))
                        target = GetCreature(MAKE_NEW_GUID(step.script->datalong, data->id, HIGHGUID_UNIT), data->posX, data->posY);
                }
                //sLog.outDebug("attempting to pass target...");
                if (!target)
                    break;
                //sLog.outDebug("target passed");
                //Lets choose our ScriptMap map
                ScriptMapMap *datamap = NULL;
                switch (step.script->dataint)
                {
                    case 1://QUEST END SCRIPTMAP
                        datamap = &sQuestEndScripts;
                        break;
                    case 2://QUEST START SCRIPTMAP
                        datamap = &sQuestStartScripts;
                        break;
                    case 3://SPELLS SCRIPTMAP
                        datamap = &sSpellScripts;
                        break;
                    case 4://GAMEOBJECTS SCRIPTMAP
                        datamap = &sGameObjectScripts;
                        break;
                    case 5://EVENTS SCRIPTMAP
                        datamap = &sEventScripts;
                        break;
                    case 6://WAYPOINTS SCRIPTMAP
                        datamap = &sWaypointScripts;
                        break;
                    default:
                        sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_CALLSCRIPT ERROR: no scriptmap present... ignoring");
                        break;
                }
                //if no scriptmap present...
                if (!datamap)
                    break;

                uint32 script_id = step.script->datalong2;
                //insert script into schedule but do not start it
                ScriptsStart(*datamap, script_id, target, NULL/*, false*/);
                break;
            }

            case SCRIPT_COMMAND_PLAY_SOUND:
            {
                if (!source)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_PLAY_SOUND call for NULL creature.");
                    break;
                }

                WorldObject* pSource = dynamic_cast<WorldObject*>(source);
                if (!pSource)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_PLAY_SOUND call for non-world object (TypeId: %u), skipping.",source->GetTypeId());
                    break;
                }

                // bitmask: 0/1=anyone/target, 0/2=with distance dependent
                Player* pTarget = NULL;
                if (step.script->datalong2 & 1)
                {
                    if (!target)
                    {
                        sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_PLAY_SOUND in targeted mode call for NULL target.");
                        break;
                    }

                    if (target->GetTypeId()!=TYPEID_PLAYER)
                    {
                        sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_PLAY_SOUND in targeted mode call for non-player (TypeId: %u), skipping.",target->GetTypeId());
                        break;
                    }

                    pTarget = (Player*)target;
                }

                // bitmask: 0/1=anyone/target, 0/2=with distance dependent
                if (step.script->datalong2 & 2)
                    pSource->PlayDistanceSound(step.script->datalong, pTarget);
                else
                    pSource->PlayDirectSound(step.script->datalong, pTarget);
                break;
            }

            case SCRIPT_COMMAND_KILL:
            {
                if (!source || ((Creature*)source)->isDead())
                    break;

                switch (step.script->datalong)
                {
                    default: // backward compatibility (defaults to 0)
                    case 0: // source kills source
                        ((Creature*)source)->DealDamage(((Creature*)source), ((Creature*)source)->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                        break;
                    case 1: // target kills source
                        ((Creature*)target)->DealDamage(((Creature*)source), ((Creature*)source)->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                        break;
                    case 2: // source kills target
                        if (target)
                            ((Creature*)source)->DealDamage(((Creature*)target), ((Creature*)target)->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                        break;
                }


                switch (step.script->dataint)
                {
                case 0: break; //return false not remove corpse
                case 1: ((Creature*)source)->RemoveCorpse(); break;
                }
                break;
            }
            case SCRIPT_COMMAND_SET_INST_DATA:
            {
                if (!source)
                    break;

                InstanceData* pInst = (InstanceData*)((WorldObject*)source)->GetInstanceData();
                if (!pInst)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_SET_INST_DATA %d attempt to set instance data without instance script.", step.script->id);
                    return;
                }

                pInst->SetData(step.script->datalong, step.script->datalong2);
                break;
            }

			case SCRIPT_COMMAND_DESPAWN_SELF:
				{
					// Source must be Creature. 
					if (!source)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_DESPAWN_SELF call for NULL creature.");
						break;
					}

					if (source->GetTypeId()!=TYPEID_UNIT)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_DESPAWN_SELF call for non-creature (TypeId: %u), skipping.",source->GetTypeId());
						break;
					}
					((Creature*)source)->ForcedDespawn(step.script->datalong);
					break;
				}

			case SCRIPT_COMMAND_VISIBILITY_SET:
				{
					// Source must be Creature. 
					if (!source)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_VISIBILITY_SET call for NULL creature.");
						break;
					}

					if (source->GetTypeId()!=TYPEID_UNIT)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_VISIBILITY_SET call for non-creature (TypeId: %u), skipping.",source->GetTypeId());
						break;
					}
					((Creature*)source)->SetVisibility(UnitVisibility(step.script->datalong));
					break;
				}

			case SCRIPT_COMMAND_EQUIP:
				{
					// Source must be Creature.
					if (!source)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_EQUIP call for NULL creature.");
						break;
					}

					if (source->GetTypeId()!=TYPEID_UNIT)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_EQUIP call for non-creature (TypeId: %u), skipping.",source->GetTypeId());
						break;
					}
					((Creature*)source)->LoadEquipment(step.script->datalong);
				}
				break;

			case SCRIPT_COMMAND_MODEL:
				{
					// Source must be Creature.
					if (!source)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_MODEL call for NULL creature.");
						break;
					}

					if (source->GetTypeId()!=TYPEID_UNIT)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_MODEL call for non-creature (TypeId: %u), skipping.",source->GetTypeId());
						break;
					}
					((Creature*)source)->SetDisplayId(step.script->datalong);	
					break;
				}

			case SCRIPT_COMMAND_ORIENTATION:
				{
					// Source must be Unit.
					if (!source)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_ORIENTATION call for NULL creature.");
						break;
					}

					if (source->GetTypeId()!=TYPEID_UNIT)
					{
						sLog.outLog(LOG_DEFAULT, "ERROR: SCRIPT_COMMAND_ORIENTATION call for non-creature (TypeId: %u), skipping.",source->GetTypeId());
						break;
					}
					dynamic_cast<Unit*>(source)->SetFacingTo(step.script->o);
					break;
				}

            default:
                sLog.outLog(LOG_DEFAULT, "ERROR: Unknown script command %u called.",step.script->command);
                break;
        }

        m_scriptSchedule.erase(iter);
        sWorld.DecreaseScheduledScriptCount();

        iter = m_scriptSchedule.begin();
    }
}


template void Map::Add(Corpse *);
template void Map::Add(Creature *);
template void Map::Add(GameObject *);
template void Map::Add(DynamicObject *);

template void Map::Remove(Corpse *,bool);
template void Map::Remove(Creature *,bool);
template void Map::Remove(GameObject *, bool);
template void Map::Remove(DynamicObject *, bool);

/* ******* Dungeon Instance Maps ******* */

InstanceMap::InstanceMap(uint32 id, time_t expiry, uint32 InstanceId, uint8 SpawnMode)
  : Map(id, expiry, InstanceId, SpawnMode), i_data(NULL),
    m_resetAfterUnload(false), m_unloadWhenEmpty(false), m_unlootedCreaturesSummoned(false)
{

    InstanceMap::InitVisibilityDistance();

    // the timer is started by default, and stopped when the first player joins
    // this make sure it gets unloaded if for some reason no player joins
    m_unloadTimer = std::max(sWorld.getConfig(CONFIG_INSTANCE_UNLOAD_DELAY), (uint32)MIN_UNLOAD_DELAY);
}

InstanceMap::~InstanceMap()
{
    if (i_data)
    {
        delete i_data;
        i_data = NULL;
    }
}

void InstanceMap::InitVisibilityDistance()
{
    m_ActiveObjectUpdateDistance = sWorld.GetActiveObjectUpdateDistanceInInstances();
}

/*
    Do map specific checks to see if the player can enter
*/
bool InstanceMap::EncounterInProgress(Player *player)
{
    bool inProgress = GetInstanceData() && GetInstanceData()->IsEncounterInProgress();
    bool CanEnterDuringEvent = false;
    //Mapid 560 is instance_old_hillsbrad           Skarloc                                       Epoch_hunter                                    Leutenant_drake
    if (GetId() == 560 && !(GetInstanceData()->GetData(10) == IN_PROGRESS || GetInstanceData()->GetData(12) == IN_PROGRESS || GetInstanceData()->GetData(11) == IN_PROGRESS))
        CanEnterDuringEvent = true;

    //woraround for nazan in remparts... should be solved in an other way...
    //Mapid 543 is instance_hellfire_remparts          gargolmar                                       omor      
    if (GetId() == 543 && !(GetInstanceData()->GetData(1) == IN_PROGRESS || GetInstanceData()->GetData(2) == IN_PROGRESS))
        CanEnterDuringEvent = true;

    if (player && inProgress)
    {
        if (player->isGameMaster() || CanEnterDuringEvent)
            return false;

        sLog.outDebug("InstanceMap: Player '%s' can't enter instance '%s' while an encounter is in progress.", player->GetName(),GetMapName());
        player->SendTransferAborted(GetId(),TRANSFER_ABORT_ZONE_IN_COMBAT);
    }
    return inProgress;
}

bool InstanceMap::CanEnter(Player *player)
{
    if (player->GetMapRef().getTarget() == this)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: InstanceMap::CanEnter - player %s(%u) already in map %d,%d,%d!", player->GetName(), player->GetGUIDLow(), GetId(), GetInstanceId(), GetSpawnMode());
        ASSERT(false);
        return false;
    }

    // cannot enter if the instance is full (player cap), GMs don't count
    uint32 maxPlayers = GetMaxPlayers();
    if (!player->isGameMaster() && GetPlayersCountExceptGMs() >= maxPlayers)
    {
        sLog.outDetail("MAP: Instance '%u' of map '%s' cannot have more than '%u' players. Player '%s' rejected", GetInstanceId(), GetMapName(), maxPlayers, player->GetName());
        player->SendTransferAborted(GetId(), TRANSFER_ABORT_MAX_PLAYERS);
        return false;
    }

    if (IsHeroic() && (player->getLevel() < 70))
    {
        sLog.outDetail("MAP: Player '%s' try to get into Instance '%u' of map '%s' in Heroic-Mode with Level '%u'. ",player->GetName(), GetInstanceId(), GetMapName(), player->getLevel());
        player->SendTransferAborted(GetId(), TRANSFER_ABORT_DIFFICULTY2);
        return false;
    }

    if (EncounterInProgress(player))
        return false;

    return Map::CanEnter(player);
}

/*
    Do map specific checks and add the player to the map if successful.
*/
bool InstanceMap::Add(Player *player)
{
    // TODO: Not sure about checking player level: already done in HandleAreaTriggerOpcode
    // GMs still can teleport player in instance.
    // Is it needed?

    {
        ACE_GUARD_RETURN(ACE_Thread_Mutex, guard, Lock, false);
        if (!CanEnter(player))
            return false;

        // Dungeon only code
        if(IsDungeon())
        {
            // increase current instances (hourly limit)
            player->AddInstanceEnterTime(GetInstanceId(), time(NULL));

            // get or create an instance save for the map
            InstanceSave *mapSave = sInstanceSaveManager.GetInstanceSave(GetInstanceId());
            if(!mapSave)
            {
                sLog.outDetail("InstanceMap::Add: creating instance save for map %d spawnmode %d with instance id %d", GetId(), GetSpawnMode(), GetInstanceId());
                mapSave = sInstanceSaveManager.AddInstanceSave(GetId(), GetInstanceId(), GetSpawnMode(), 0, true);
            }
            // check for existing instance binds
            InstancePlayerBind *playerBind = player->GetBoundInstance(GetId(), GetSpawnMode());
            if(playerBind && playerBind->perm)
            {
                // cannot enter other instances if bound permanently
                if(playerBind->save != mapSave)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: InstanceMap::Add: player %s(%d) is permanently bound to instance %d,%d,%d,%d,%d,%d but he is being put in instance %d,%d,%d,%d,%d,%d", player->GetName(), player->GetGUIDLow(), playerBind->save->GetMapId(), playerBind->save->GetInstanceId(), playerBind->save->GetDifficulty(), playerBind->save->GetPlayerCount(), playerBind->save->GetGroupCount(), playerBind->save->CanReset(), mapSave->GetMapId(), mapSave->GetInstanceId(), mapSave->GetDifficulty(), mapSave->GetPlayerCount(), mapSave->GetGroupCount(), mapSave->CanReset());
                    return false;
                    //ASSERT(false);
                }
            }
            else
            {
                Group *pGroup = player->GetGroup();
                if (pGroup)
                {
                    // solo saves should be reset when entering a group
                    InstanceGroupBind *groupBind = pGroup->GetBoundInstance(GetId(), GetSpawnMode());
                    if (playerBind)
                    {
                        sLog.outLog(LOG_DEFAULT, "ERROR: InstanceMap::Add: player %s(%d) is being put in instance %d,%d,%d,%d,%d,%d but he is in group %d and is bound to instance %d,%d,%d,%d,%d,%d!", player->GetName(), player->GetGUIDLow(), mapSave->GetMapId(), mapSave->GetInstanceId(), mapSave->GetDifficulty(), mapSave->GetPlayerCount(), mapSave->GetGroupCount(), mapSave->CanReset(), GUID_LOPART(pGroup->GetLeaderGUID()), playerBind->save->GetMapId(), playerBind->save->GetInstanceId(), playerBind->save->GetDifficulty(), playerBind->save->GetPlayerCount(), playerBind->save->GetGroupCount(), playerBind->save->CanReset());
                        if (groupBind)
                            sLog.outLog(LOG_DEFAULT, "ERROR: InstanceMap::Add: the group is bound to instance %d,%d,%d,%d,%d,%d", groupBind->save->GetMapId(), groupBind->save->GetInstanceId(), groupBind->save->GetDifficulty(), groupBind->save->GetPlayerCount(), groupBind->save->GetGroupCount(), groupBind->save->CanReset());
                        sLog.outLog(LOG_DEFAULT, "ERROR: InstanceMap::Add: do not let player %s enter instance otherwise crash will happen", player->GetName());
                        return false;
                        //player->UnbindInstance(GetId(), GetSpawnMode());
                        //ASSERT(false);
                    }
                    // bind to the group or keep using the group save
                    if (!groupBind)
                        pGroup->BindToInstance(mapSave, false);
                    else
                    {
                        // cannot jump to a different instance without resetting it
                        if(groupBind->save != mapSave)
                        {
                            sLog.outLog(LOG_DEFAULT, "ERROR: InstanceMap::Add: player %s(%d) is being put in instance %d,%d,%d but he is in group %d which is bound to instance %d,%d,%d!", player->GetName(), player->GetGUIDLow(), mapSave->GetMapId(), mapSave->GetInstanceId(), mapSave->GetDifficulty(), GUID_LOPART(pGroup->GetLeaderGUID()), groupBind->save->GetMapId(), groupBind->save->GetInstanceId(), groupBind->save->GetDifficulty());
                            if(mapSave)
                                sLog.outLog(LOG_DEFAULT, "ERROR: MapSave players: %d, group count: %d", mapSave->GetPlayerCount(), mapSave->GetGroupCount());
                            else
                                sLog.outLog(LOG_DEFAULT, "ERROR: MapSave NULL");
                            if(groupBind->save)
                                sLog.outLog(LOG_DEFAULT, "ERROR: GroupBind save players: %d, group count: %d", groupBind->save->GetPlayerCount(), groupBind->save->GetGroupCount());
                            else
                                sLog.outLog(LOG_DEFAULT, "ERROR: GroupBind save NULL");
                            ASSERT(false);
                        }
                        // if the group/leader is permanently bound to the instance
                        // players also become permanently bound when they enter
                        if (groupBind->perm)
                        {
                            WorldPacket data(SMSG_INSTANCE_SAVE_CREATED, 4);
                            data << uint32(0);
                            player->SendPacketToSelf(&data);
                            player->BindToInstance(mapSave, true);
                        }
                    }
                }
                else
                {
                    // set up a solo bind or continue using it
                    if (!playerBind)
                        player->BindToInstance(mapSave, false);
                    else
                        // cannot jump to a different instance without resetting it
                        ASSERT(playerBind->save == mapSave);
                }
            }

            if (i_data) i_data->OnPlayerEnter(player);
            // for normal instances cancel the reset schedule when the
            // first player enters (no players yet)
            SetResetSchedule(false);

            player->SendInitWorldStates();
            sLog.outDetail("MAP: Player '%s' entered the instance '%u' of map '%s'", player->GetName(), GetInstanceId(), GetMapName());
            // initialize unload state
            m_unloadTimer = 0;
            m_resetAfterUnload = false;
            m_unloadWhenEmpty = false;
        }


        // get or create an instance save for the map
        InstanceSave *mapSave = sInstanceSaveManager.GetInstanceSave(GetInstanceId());
        if (!mapSave)
        {
            sLog.outDetail("InstanceMap::Add: creating instance save for map %d spawnmode %d with instance id %d", GetId(), GetSpawnMode(), GetInstanceId());
            mapSave = sInstanceSaveManager.AddInstanceSave(GetId(), GetInstanceId(), GetSpawnMode(), 0, true);
        }
    }

    // this will acquire the same mutex so it cannot be in the previous block
    Map::Add(player);
    return true;
}

void InstanceMap::Update(const uint32& t_diff)
{
    Map::Update(t_diff);

    if (i_data)
        i_data->Update(t_diff);

    if (!m_unlootedCreaturesSummoned)
        SummonUnlootedCreatures();
}

void InstanceMap::Remove(Player *player, bool remove)
{
    sLog.outDetail("MAP: Removing player '%s' from instance '%u' of map '%s' before relocating to other map", player->GetName(), GetInstanceId(), GetMapName());
    //if last player set unload timer
    if (!m_unloadTimer && m_mapRefManager.getSize() == 1)
        m_unloadTimer = m_unloadWhenEmpty ? MIN_UNLOAD_DELAY : std::max(sWorld.getConfig(CONFIG_INSTANCE_UNLOAD_DELAY), (uint32)MIN_UNLOAD_DELAY);
    Map::Remove(player, remove);
    // for normal instances schedule the reset after all players have left
    SetResetSchedule(true);
}

void InstanceMap::CreateInstanceData(bool load)
{
    if (i_data != NULL)
        return;

    InstanceTemplate const* mInstance = ObjectMgr::GetInstanceTemplate(GetId());
    if (mInstance)
    {
        i_script_id = mInstance->script_id;
        i_data = sScriptMgr.CreateInstanceData(this);
    }

    if (!i_data)
        return;

    i_data->Initialize();

    if (load)
    {
        // TODO: make a global storage for this
        QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT data FROM instance WHERE map = '%u' AND id = '%u'", GetId(), i_InstanceId);
        if (result)
        {
            Field* fields = result->Fetch();
            const char* data = fields[0].GetString();
            if (data && data != "")
            {
                sLog.outDebug("Loading instance data for `%s` with id %u", sScriptMgr.GetScriptName(i_script_id), i_InstanceId);
                i_data->Load(data);
            }
        }
    }
}

/*
    Returns true if there are no players in the instance
*/
bool InstanceMap::Reset(uint8 method)
{
    // note: since the map may not be loaded when the instance needs to be reset
    // the instance must be deleted from the DB by InstanceSaveManager

    if (HavePlayers())
    {
        if (method == INSTANCE_RESET_ALL || method == INSTANCE_RESET_CHANGE_DIFFICULTY)
        {
            // notify the players to leave the instance so it can be reset
            for (MapRefManager::iterator itr = m_mapRefManager.begin(); itr != m_mapRefManager.end(); ++itr)
                itr->getSource()->SendResetFailedNotify(GetId());
        }
        else
        {
            if (method == INSTANCE_RESET_GLOBAL)
            {
                // set the homebind timer for players inside (1 minute)
                for (MapRefManager::iterator itr = m_mapRefManager.begin(); itr != m_mapRefManager.end(); ++itr)
                    itr->getSource()->m_InstanceValid = false;
            }

            // the unload timer is not started
            // instead the map will unload immediately after the players have left
            m_unloadWhenEmpty = true;
            m_resetAfterUnload = true;
        }
    }
    else
    {
        // unloaded at next update
        m_unloadTimer = MIN_UNLOAD_DELAY;
        m_resetAfterUnload = true;
    }

    return m_mapRefManager.isEmpty();
}

void InstanceMap::PermBindAllPlayers(Player *player)
{
    if (!IsDungeon())
        return;

    InstanceSave *save = sInstanceSaveManager.GetInstanceSave(GetInstanceId());
    if (!save)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Cannot bind players, no instance save available for map!\n");
        return;
    }

    Group *group = player->GetGroup();
    // group members outside the instance group don't get bound
    for (MapRefManager::iterator itr = m_mapRefManager.begin(); itr != m_mapRefManager.end(); ++itr)
    {
        Player* plr = itr->getSource();
        // players inside an instance cannot be bound to other instances
        // some players may already be permanently bound, in this case nothing happens
        InstancePlayerBind *bind = plr->GetBoundInstance(save->GetMapId(), save->GetDifficulty());
        if (!bind || !bind->perm)
        {
            plr->BindToInstance(save, true);
            WorldPacket data(SMSG_INSTANCE_SAVE_CREATED, 4);
            data << uint32(0);
            plr->SendPacketToSelf(&data);
        }

        // if the leader is not in the instance the group will not get a perm bind
        if (group && group->GetLeaderGUID() == plr->GetGUID())
            group->BindToInstance(save, true);
    }
}

void InstanceMap::UnloadAll()
{
    if (HavePlayers())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: InstanceMap::UnloadAll: there are still players in the instance at unload, should not happen!");
        for (MapRefManager::iterator itr = m_mapRefManager.begin(); itr != m_mapRefManager.end(); ++itr)
        {
            Player* plr = itr->getSource();
            plr->TeleportToHomebind();
        }
    }

    if (m_resetAfterUnload == true)
        sObjectMgr.DeleteRespawnTimeForInstance(GetInstanceId());

    Map::UnloadAll();
}

void InstanceMap::SendResetWarnings(uint32 timeLeft) const
{
    for (MapRefManager::const_iterator itr = m_mapRefManager.begin(); itr != m_mapRefManager.end(); ++itr)
        itr->getSource()->SendInstanceResetWarning(GetId(), timeLeft);
}

void InstanceMap::SetResetSchedule(bool on)
{
    // only for normal instances
    // the reset time is only scheduled when there are no players inside
    // it is assumed that the reset time will rarely (if ever) change while the reset is scheduled
    if (IsDungeon() && !HavePlayers() && !IsRaid() && !IsHeroic())
    {
        InstanceSave *save = sInstanceSaveManager.GetInstanceSave(GetInstanceId());
        if (!save)
            sLog.outLog(LOG_DEFAULT, "ERROR: InstanceMap::SetResetSchedule: cannot turn schedule %s, no save available for instance %d (mapid: %d)", on ? "on" : "off", GetInstanceId(), GetId());
        else
            sInstanceSaveManager.ScheduleReset(on, save->GetResetTime(), InstanceSaveManager::InstResetEvent(0, GetId(), GetInstanceId()));
    }
}

void InstanceMap::SummonUnlootedCreatures()
{
    m_unlootedCreaturesSummoned = true;
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT DISTINCT creatureId, position_x, position_y, position_z FROM group_saved_loot WHERE instanceId='%u' AND summoned = TRUE", GetInstanceId());
    if (result)
    {
        do
        {
            Field *fields = result->Fetch();

            uint32 creatureId = fields[0].GetUInt32();
            float pos_x = fields[1].GetFloat();
            float pos_y = fields[2].GetFloat();
            float pos_z = fields[3].GetFloat();

            TemporarySummon* pCreature = new TemporarySummon();
            if (!pCreature->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_UNIT), this, creatureId, 0, pos_x, pos_y, pos_z, 0))
            {
                delete pCreature;
                continue;
            }
            pCreature->Summon(TEMPSUMMON_MANUAL_DESPAWN, 0);
            pCreature->loot.FillLootFromDB(pCreature, NULL);
        }
        while (result->NextRow());
    }
}

uint32 InstanceMap::GetMaxPlayers() const
{
    InstanceTemplate const* iTemplate = sObjectMgr.GetInstanceTemplate(GetId());
    if(!iTemplate)
        return 0;
    return iTemplate->maxPlayers;
}

/* ******* Battleground Instance Maps ******* */

BattleGroundMap::BattleGroundMap(uint32 id, time_t expiry, uint32 InstanceId, BattleGround *bg)
    : Map(id, expiry, InstanceId, DIFFICULTY_NORMAL)
{
    m_bg = bg;
    BattleGroundMap::InitVisibilityDistance();
}

BattleGroundMap::~BattleGroundMap()
{
}

void BattleGroundMap::InitVisibilityDistance()
{
    m_ActiveObjectUpdateDistance = sWorld.GetActiveObjectUpdateDistanceInInstances();
}

bool BattleGroundMap::CanEnter(Player * player)
{
    if (player->GetMapRef().getTarget() == this)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: BGMap::CanEnter - player %u already in map!", player->GetGUIDLow());
        ASSERT(false);
        return false;
    }

    if (player->GetBattleGroundId() != GetInstanceId())
        return false;

    // player number limit is checked in bgmgr, no need to do it here

    return Map::CanEnter(player);
}

void BattleGroundMap::Update(const uint32& t_diff)
{
    Map::Update(t_diff);

    if (m_bg)
        m_bg->Update(time_t(t_diff));
}

bool BattleGroundMap::Add(Player * player)
{
    {
        ACE_GUARD_RETURN(ACE_Thread_Mutex, guard, Lock, false);
        if (!CanEnter(player))
            return false;
        // reset instance validity, battleground maps do not homebind
        player->m_InstanceValid = true;
    }
    return Map::Add(player);
}

void BattleGroundMap::Remove(Player *player, bool remove)
{
    sLog.outDetail("MAP: Removing player '%s' from bg '%u' of map '%s' before relocating to other map", player->GetName(), GetInstanceId(), GetMapName());
    Map::Remove(player, remove);
}

void BattleGroundMap::SetUnload()
{
    m_unloadTimer = MIN_UNLOAD_DELAY;
}

void BattleGroundMap::UnloadAll()
{
    while (HavePlayers())
    {
        if (Player * plr = m_mapRefManager.getFirst()->getSource())
        {
            plr->TeleportToHomebind();
            // TeleportTo removes the player from this map (if the map exists) -> calls BattleGroundMap::Remove -> invalidates the iterator.
            // just in case, remove the player from the list explicitly here as well to prevent a possible infinite loop
            // note that this remove is not needed if the code works well in other places
            plr->GetMapRef().unlink();
        }
    }

    Map::UnloadAll();
}

Creature * Map::GetCreature(uint64 guid)
{
    CreaturesMapType::const_accessor a;

    if (creaturesMap.find(a, guid))
    {
        if (a->second->GetInstanceId() != GetInstanceId())
            return NULL;
        else
            return a->second;
    }

    return NULL;
}

Creature * Map::GetCreature(uint64 guid, float x, float y)
{
    CreaturesMapType::const_accessor a;

    if (creaturesMap.find(a, guid))
    {
        CellPair p = Looking4group::ComputeCellPair(x,y);
        if (p.x_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP || p.y_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Map::GetCorpse: invalid coordinates supplied X:%f Y:%f grid cell [%u:%u]", x, y, p.x_coord, p.y_coord);
            return NULL;
        }

        CellPair q = Looking4group::ComputeCellPair(a->second->GetPositionX(), a->second->GetPositionY());
        if (q.x_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP || q.y_coord >= TOTAL_NUMBER_OF_CELLS_PER_MAP)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Map::GetCorpse: object " UI64FMTD " has invalid coordinates X:%f Y:%f grid cell [%u:%u]", a->second->GetGUID(), a->second->GetPositionX(), a->second->GetPositionY(), q.x_coord, q.y_coord);
            return NULL;
        }

        int32 dx = int32(p.x_coord) - int32(q.x_coord);
        int32 dy = int32(p.y_coord) - int32(q.y_coord);

        if (dx > -2 && dx < 2 && dy > -2 && dy < 2)
            return a->second;
        else
            return NULL;
    }

    return NULL;
}


Creature * Map::GetCreatureById(uint32 id, GetCreatureGuidType type)
{
    return GetCreature(GetCreatureGUID(id, type));
}

Creature * Map::GetCreatureOrPet(uint64 guid)
{
    if (IS_PLAYER_GUID(guid))
        return NULL;

    if (IS_PET_GUID(guid))
        return ObjectAccessor::GetPet(guid);

    return GetCreature(guid);
}

GameObject * Map::GetGameObject(uint64 guid)
{
    GObjectMapType::const_accessor a;

    if (gameObjectsMap.find(a, guid))
    {
        if (a->second->GetInstanceId() != GetInstanceId())
            return NULL;
        else
            return a->second;
    }

    return NULL;
}

DynamicObject * Map::GetDynamicObject(uint64 guid)
{
    DObjectMapType::const_accessor a;

    if (dynamicObjectsMap.find(a, guid))
    {
        if (a->second->GetInstanceId() != GetInstanceId())
            return NULL;
        else
            return a->second;
    }

    return NULL;
}

Unit * Map::GetUnit(uint64 guid)
{
    if (!guid)
        return NULL;

    if (IS_PLAYER_GUID(guid))
        return ObjectAccessor::FindPlayer(guid);

    return GetCreatureOrPet(guid);
}

Object* Map::GetObjectByTypeMask(Player const &p, uint64 guid, uint32 typemask)
{
    Object *obj = NULL;

    if (typemask & TYPEMASK_PLAYER)
    {
        obj = ObjectAccessor::FindPlayer(guid);
        if (obj) return obj;
    }

    if (typemask & TYPEMASK_UNIT)
    {
        obj = GetCreatureOrPet(guid);
        if (obj) return obj;
    }

    if (typemask & TYPEMASK_GAMEOBJECT)
    {
        obj = GetGameObject(guid);
        if (obj) return obj;
    }

    if (typemask & TYPEMASK_DYNAMICOBJECT)
    {
        obj = GetDynamicObject(guid);
        if (obj) return obj;
    }

    if (typemask & TYPEMASK_ITEM)
    {
        obj = p.GetItemByGuid(guid);
        if (obj) return obj;
    }

    return NULL;
}

std::list<uint64> Map::GetCreaturesGUIDList(uint32 id, GetCreatureGuidType type , uint32 max)
{
    std::list<uint64> returnList;
    CreatureIdToGuidListMapType::const_accessor a;
    if (creatureIdToGuidMap.find(a, id))
    {
        std::list<uint64> tmpList = a->second;

        if (!max || max > tmpList.size())
        {
            max = tmpList.size();
            if (type == GET_RANDOM_CREATURE_GUID)
                type = GET_FIRST_CREATURE_GUID;
        }
        uint64 count = 0;
        switch (type)
        {
            case GET_FIRST_CREATURE_GUID:
                for (std::list<uint64>::iterator itr = tmpList.begin(); count != max; ++itr, ++count)
                    returnList.push_back(*itr);
                break;
            case GET_LAST_CREATURE_GUID:
                for (std::list<uint64>::reverse_iterator itr = tmpList.rbegin(); count != max; ++itr, ++count)
                    returnList.push_back(*itr);
                break;
            case GET_RANDOM_CREATURE_GUID:
                for (count = 0; count != max; ++count)
                {
                    std::list<uint64>::iterator itr = tmpList.begin();
                    std::advance(itr, rand()%(tmpList.size()-1));
                    returnList.push_back(*itr);
                    tmpList.erase(itr);
                }
                break;
            case GET_ALIVE_CREATURE_GUID:
            {
                for (std::list<uint64>::iterator itr = tmpList.begin(); itr != tmpList.end(); ++itr)
                {
                    Creature * tmpC = GetCreature(*itr);
                    if (tmpC && tmpC->isAlive())
                    {
                        returnList.push_back(*itr);
                        ++count;
                    }

                    if (count == max)
                        break;
                }
                break;
            }
            default:
                break;
        }
    }

    return returnList;
}

uint64 Map::GetCreatureGUID(uint32 id, GetCreatureGuidType type)
{
    uint64 returnGUID = 0;

    CreatureIdToGuidListMapType::const_accessor a;
    if (creatureIdToGuidMap.find(a, id))
    {
        switch (type)
        {
            case GET_FIRST_CREATURE_GUID:
                returnGUID = a->second.front();
                break;
            case GET_LAST_CREATURE_GUID:
                returnGUID = a->second.back();
                break;
            case GET_RANDOM_CREATURE_GUID:
            {
                std::list<uint64>::const_iterator itr= a->second.begin();
                std::advance(itr, urand(0, a->second.size()-1));
                returnGUID = *itr;
                break;
            }
            case GET_ALIVE_CREATURE_GUID:
            {
                for (std::list<uint64>::const_iterator itr = a->second.begin(); itr != a->second.end(); ++itr)
                {
                    Creature * tmpC = GetCreature(*itr);
                    if (tmpC && tmpC->isAlive())
                    {
                        returnGUID = *itr;
                        break;
                    }
                }
                break;
            }
            default:
                break;
        }
    }

    return returnGUID;
}

void Map::InsertIntoCreatureGUIDList(Creature * obj)
{
    CreatureIdToGuidListMapType::accessor a;
    if (creatureIdToGuidMap.insert(a, obj->GetEntry()))
    {
        std::list<uint64> tmp;
        tmp.push_back(obj->GetGUID());
        a->second = tmp;
    }
    else
    {
        a.release();
        if (creatureIdToGuidMap.find(a, obj->GetEntry()))
            a->second.push_back(obj->GetGUID());
    }
}

void Map::RemoveFromCreatureGUIDList(Creature * obj)
{
    CreatureIdToGuidListMapType::accessor a;
    if (creatureIdToGuidMap.find(a, obj->GetEntry()))
        a->second.remove(obj->GetGUID());
}


void Map::InsertIntoObjMap(Object * obj)
{
    ObjectGuid guid(obj->GetGUID());

    switch (guid.GetHigh())
    {
        case HIGHGUID_UNIT:
            {
                CreaturesMapType::accessor a;

                if (creaturesMap.insert(a, guid.GetRawValue()))
                {
                    a->second = (Creature*)obj;
                    InsertIntoCreatureGUIDList(a->second);
                }
                else
                    error_log("Map::InsertIntoCreatureMap: GUID %u already in map", guid.GetRawValue());

                a.release();
                break;
            }
        case HIGHGUID_GAMEOBJECT:
            {
                GObjectMapType::accessor a;

                if (gameObjectsMap.insert(a, guid.GetRawValue()))
                    a->second = (GameObject*)obj;
                else
                    error_log("Map::InsertIntoGameObjectMap: GUID %u already in map", guid.GetRawValue());

                a.release();
                break;
            }
        case HIGHGUID_DYNAMICOBJECT:
            {
                DObjectMapType::accessor a;

                if (dynamicObjectsMap.insert(a, guid.GetRawValue()))
                    a->second = (DynamicObject*)obj;
                else
                    error_log("Map::InsertIntoDynamicObjectMap: GUID %u already in map", guid.GetRawValue());

                a.release();
                break;
            }
        case HIGHGUID_PET:
            sObjectAccessor.AddPet((Pet*)obj);
            break;

        case HIGHGUID_PLAYER:
            sObjectAccessor.AddPlayer((Player*)obj);
            break;

        case HIGHGUID_CORPSE:
            sObjectAccessor.AddCorpse((Corpse*)obj);
            break;
        default:
            break;
    }
}

void Map::RemoveFromObjMap(uint64 guid)
{
    ObjectGuid objGuid(guid);

    switch (objGuid.GetHigh())
    {
        case HIGHGUID_UNIT:
            if (!creaturesMap.erase(guid))
                error_log("Map::RemoveFromCreatureMap: Creature GUID %u not in map", guid);
            break;

        case HIGHGUID_GAMEOBJECT:
            if (!gameObjectsMap.erase(guid))
                error_log("Map::RemoveFromGameObjectMap: Game Object GUID %u not in map", guid);
            break;

        case HIGHGUID_DYNAMICOBJECT:
            if (!dynamicObjectsMap.erase(guid))
                error_log("Map::RemoveFromDynamicObjectMap: Dynamic Object GUID %u not in map", guid);
            break;

        case HIGHGUID_PET:
            sObjectAccessor.RemovePet(guid);
            break;

        case HIGHGUID_PLAYER:
            sObjectAccessor.RemovePlayer(guid);
            break;

        case HIGHGUID_CORPSE:
            HashMapHolder<Corpse>::Remove(guid);
            break;
        default:
            break;
    }
}

void Map::RemoveFromObjMap(Object * obj)
{
    ObjectGuid objGuid(obj->GetGUID());

    switch (objGuid.GetHigh())
    {
        case HIGHGUID_UNIT:
        {
            CreaturesMapType::accessor a;
            RemoveFromCreatureGUIDList((Creature*)obj);
            if (creaturesMap.find(a, objGuid.GetRawValue()))
                creaturesMap.erase(a);
            else
                sLog.outLog(LOG_DEFAULT, "ERROR: Map::RemoveFromCreatureMap: Creature GUID Low %u not in map", objGuid.GetCounter());
            break;
        }
        case HIGHGUID_GAMEOBJECT:
        {
            GObjectMapType::accessor a;
            if (gameObjectsMap.find(a, objGuid.GetRawValue()))
                gameObjectsMap.erase(a);
            else
                sLog.outLog(LOG_DEFAULT, "ERROR: Map::RemoveFromGameObjectMap: Game Object GUID Low %u not in map", objGuid.GetCounter());
            break;
        }
        case HIGHGUID_DYNAMICOBJECT:
        {
            DObjectMapType::accessor a;
            if (dynamicObjectsMap.find(a, objGuid.GetRawValue()))
                dynamicObjectsMap.erase(a);
            else
                sLog.outLog(LOG_DEFAULT, "ERROR: Map::RemoveFromDynamicObjectMap: Dynamic Object GUID Low %u not in map", objGuid.GetCounter());
            break;
        }
        case HIGHGUID_PET:
        {
            sObjectAccessor.RemovePet(objGuid.GetRawValue());
            break;
        }
        case HIGHGUID_PLAYER:
        {
            sObjectAccessor.RemovePlayer(objGuid.GetRawValue());
            break;
        }
        case HIGHGUID_CORPSE:
        {
            HashMapHolder<Corpse>::Remove(objGuid.GetRawValue());
            break;
        }
        default:
            break;
    }
}

void Map::ForcedUnload()
{
    sLog.outLog(LOG_DEFAULT, "ERROR: Map::ForcedUnload called for map %u instance %u. Map crushed. Cleaning up...", GetId(), GetInstanceId());
    sLog.outLog(LOG_CRASH, "Map::ForcedUnload called for map %u instance %u. Map crushed. Cleaning up...", GetId(), GetInstanceId());

    // Immediately cleanup update sets/queues
    i_objectsToClientUpdate.clear();

    Map::PlayerList const pList = GetPlayers();

    for (PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
    {
        Player* player = itr->getSource();
        if (!player || !player->GetSession())
            continue;

        if (player->IsBeingTeleported())
        {
            WorldLocation old_loc;
            player->GetPosition(old_loc);
            if (!player->TeleportTo(old_loc))
            {
                sLog.outDetail("Map::ForcedUnload: %u is in teleport state, cannot be ported to his previous place, teleporting him to his homebind place...",
                    player->GetGUIDLow());
                player->TeleportToHomebind();
            }
            player->SetSemaphoreTeleportFar(false);
        }

        switch (sWorld.getConfig(CONFIG_VMSS_MAPFREEMETHOD))
        {
            case 0:
            {
                player->RemoveAllAurasOnDeath();
                if (Pet* pet = player->GetPet())
                    pet->RemoveAllAurasOnDeath();
                player->GetSession()->LogoutPlayer(true);
                break;
            }
            case 1:
            {
                player->GetSession()->KickPlayer();
                break;
            }
            case 2:
            {
                player->GetSession()->LogoutPlayer(false);
                break;
            }
            default:
                break;
        }
    }

    switch (sWorld.getConfig(CONFIG_VMSS_MAPFREEMETHOD))
    {
        case 0:
            if (InstanceMap *instance = dynamic_cast<InstanceMap*>(this))
                if (InstanceData* iData = instance->GetInstanceData())
                    iData->SaveToDB();
            break;
        default:
            break;
    }

    UnloadAll();

    SetBroken(false);
}

float Map::GetVisibilityDistance(WorldObject* obj, Player* invoker) const
{
    if (!obj)
        return DEFAULT_VISIBILITY_DISTANCE;

    if (invoker && invoker->getWatchingCinematic() != 0)
        return MAX_VISIBILITY_DISTANCE;

    if (m_TerrainData == nullptr)
         return DEFAULT_VISIBILITY_DISTANCE;
    
    float dist = m_TerrainData->GetVisibilityDistance();
    if (obj != nullptr)
    {
        if (obj->GetObjectGuid().IsGameObject())
            return (dist + obj->ToGameObject()->GetDeterminativeSize());    // or maybe should be GetMaxVisibleDistanceForObject instead m_VisibleDistance ?
        else if(obj->GetObjectGuid().IsCreature())
            return (dist + obj->ToCreature()->GetDeterminativeSize());
    }

    return dist;
}

bool Map::WaypointMovementAutoActive() const
{
    if(Instanceable())
        return sWorld.getConfig(CONFIG_WAYPOINT_MOVEMENT_ACTIVE_IN_INSTANCES);
    else
        return sWorld.getConfig(CONFIG_WAYPOINT_MOVEMENT_ACTIVE_ON_CONTINENTS);
}

bool Map::WaypointMovementPathfinding() const
{
    if(Instanceable())
        return sWorld.getConfig(CONFIG_WAYPOINT_MOVEMENT_ACTIVE_IN_INSTANCES);
    else
        return sWorld.getConfig(CONFIG_WAYPOINT_MOVEMENT_ACTIVE_ON_CONTINENTS);
}

bool Map::CanUnload(uint32 diff)
{
    if (!m_unloadTimer)
        return false;

    if (m_unloadTimer <= diff)
        return true;

    m_unloadTimer -= diff;
    return false;
}

bool Map::IsRemovalGrid(float x, float y) const
{
    GridPair p = Looking4group::ComputeGridPair(x, y);
    return(!getNGrid(p.x_coord, p.y_coord) || getNGrid(p.x_coord, p.y_coord)->GetGridState() == GRID_STATE_REMOVAL);
}

bool Map::IsLoaded(float x, float y) const
{
    GridPair p = Looking4group::ComputeGridPair(x, y);
    return loaded(p);
}

void Map::ResetGridExpiry(NGridType &grid, float factor /*= 1*/) const
{
    grid.ResetTimeTracker((time_t)((float)i_gridExpiry*factor));
}

bool Map::GetEntrancePos( int32 &mapid, float &x, float &y )
{
    if (!i_mapEntry)
        return false;
    if (i_mapEntry->entrance_map < 0)
        return false;
    mapid = i_mapEntry->entrance_map;
    x = i_mapEntry->entrance_x;
    y = i_mapEntry->entrance_y;
    return true;
}

void Map::UpdateHelper::Update( DelayedMapList& delayedUpdate )
{
    sMapMgr.GetMapUpdater()->schedule_update(*m_map, GetTimeElapsed());
    delayedUpdate.push_back(std::make_pair(m_map, uint32(GetTimeElapsed())));

    m_map->m_updateTracker.Reset();
}

bool Map::UpdateHelper::ProcessUpdate() const
{
    return GetTimeElapsed() >= sWorld.getConfig(CONFIG_INTERVAL_MAPUPDATE);
}

time_t Map::UpdateHelper::GetTimeElapsed() const
{
    return m_map->m_updateTracker.timeElapsed();
}
