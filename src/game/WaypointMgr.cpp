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

#include "Database/DatabaseEnv.h"
#include "GridDefines.h"
#include "WaypointMgr.h"
#include "ProgressBar.h"
#include "MapManager.h"

void WaypointMgr::Free()
{
    _waypointPathMap.clear();
}

void WaypointMgr::Load()
{
    QueryResultAutoPtr result = GameDataDatabase.PQuery("SELECT MAX(`id`) FROM `waypoint_data`");
    if (!result)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: an error occurred while loading the table `waypoint_data` (maybe it doesn't exist ?)\n");
        exit(1);                                            // Stop server at loading non exited table or not accessible table
    }

    records = (*result)[0].GetUInt32();

    result = GameDataDatabase.PQuery("SELECT `id`,`point`,`position_x`,`position_y`,`position_z`,`move_type`,`delay`,`action`,`action_chance` FROM `waypoint_data` ORDER BY `id`, `point`");
    if (!result)
    {
        sLog.outLog(LOG_DB_ERR, "The table `creature_addon` is empty or corrupted");
        return;
    }

    WaypointPath* path_data;
    uint32 total_records = result->GetRowCount();

    BarGoLink bar(total_records);
    Field *fields;
    uint32 last_id = 0;

    do
    {
        fields = result->Fetch();
        uint32 id = fields[0].GetUInt32();
        bar.step();
        WaypointData *wp = new WaypointData;

        if (last_id != id)
            path_data = new WaypointPath;

        float x,y,z;
        x = fields[2].GetFloat();
        y = fields[3].GetFloat();
        z = fields[4].GetFloat();

        Looking4group::NormalizeMapCoord(x);
        Looking4group::NormalizeMapCoord(y);

        wp->id = fields[1].GetUInt32();
        wp->x = x;
        wp->y = y;
        wp->z = z;
        wp->moveType = WaypointMoveType(fields[5].GetUInt8());
        wp->delay = fields[6].GetUInt32();
        wp->event_id = fields[7].GetUInt32();
        wp->event_chance = fields[8].GetUInt8();

        path_data->push_back(wp);

        if (id != last_id)
            _waypointPathMap[id] = path_data;

        last_id = id;

    }
    while (result->NextRow()) ;
}

void WaypointMgr::UpdatePath(uint32 id)
{

    if (_waypointPathMap.find(id)!= _waypointPathMap.end())
        _waypointPathMap[id]->clear();

    QueryResultAutoPtr result = GameDataDatabase.PQuery("SELECT `id`,`point`,`position_x`,`position_y`,`position_z`,`move_type`,`delay`,`action`,`action_chance` FROM `waypoint_data` WHERE id = %u ORDER BY `point`", id);

    if (!result)
        return;

    WaypointPath* path_data;

    path_data = new WaypointPath;

    Field *fields;

    do
    {
        fields = result->Fetch();
        uint32 id = fields[0].GetUInt32();

        WaypointData *wp = new WaypointData;

        float x,y,z;
        x = fields[2].GetFloat();
        y = fields[3].GetFloat();
        z = fields[4].GetFloat();

        Looking4group::NormalizeMapCoord(x);
        Looking4group::NormalizeMapCoord(y);

        wp->id = fields[1].GetUInt32();
        wp->x = x;
        wp->y = y;
        wp->z = z;
        wp->moveType = WaypointMoveType(fields[5].GetUInt8());
        wp->delay = fields[6].GetUInt32();
        wp->event_id = fields[7].GetUInt32();
        wp->event_chance = fields[8].GetUInt8();

        path_data->push_back(wp);

    }
    while (result->NextRow());

   _waypointPathMap[id] = path_data;
}
