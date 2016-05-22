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

#include "Common.h"
#include "Corpse.h"
#include "Player.h"
#include "UpdateMask.h"
#include "MapManager.h"
#include "ObjectAccessor.h"
#include "Database/DatabaseEnv.h"
#include "Opcodes.h"
#include "WorldSession.h"
#include "WorldPacket.h"
#include "GossipDef.h"
#include "World.h"

Corpse::Corpse(CorpseType type) : WorldObject()
{
    m_objectType |= TYPEMASK_CORPSE;
    m_objectTypeId = TYPEID_CORPSE;
                                                            // 2.3.2 - 0x58
    m_updateFlag = (UPDATEFLAG_LOWGUID | UPDATEFLAG_HIGHGUID | UPDATEFLAG_HAS_POSITION);

    m_valuesCount = CORPSE_END;

    m_type = type;

    m_time = time(NULL);

    lootForBody = false;
}

Corpse::~Corpse()
{
}

void Corpse::AddToWorld()
{
    ///- Register the corpse for guid lookup
    HashMapHolder<Corpse>::Insert(this);

    Object::AddToWorld();
}

void Corpse::RemoveFromWorld()
{
    ///- Remove the corpse from the accessor
    HashMapHolder<Corpse>::Remove(this);

    Object::RemoveFromWorld();
}

bool Corpse::Create(uint32 guidlow)
{
    Object::_Create(guidlow, 0, HIGHGUID_CORPSE);
    return true;
}

bool Corpse::Create(uint32 guidlow, Player *owner)
{
    SetInstanceId(owner->GetInstanceId());

    WorldObject::_Create(guidlow, HIGHGUID_CORPSE, owner->GetMapId());

    Relocate(owner->GetPositionX(), owner->GetPositionY(), owner->GetPositionZ(), owner->GetOrientation());

    if (!IsPositionValid())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Corpse (guidlow %d, owner %s) not created. Suggested coordinates isn't valid (X: %f Y: %f)",
            guidlow,owner->GetName(),owner->GetPositionX(), owner->GetPositionY());
        return false;
    }

    SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
    SetFloatValue(CORPSE_FIELD_POS_X, GetPositionX());
    SetFloatValue(CORPSE_FIELD_POS_Y, GetPositionY());
    SetFloatValue(CORPSE_FIELD_POS_Z, GetPositionZ());
    SetFloatValue(CORPSE_FIELD_FACING, GetOrientation());
    SetUInt64Value(CORPSE_FIELD_OWNER, owner->GetGUID());

    m_grid = Looking4group::ComputeGridPair(GetPositionX(), GetPositionY());

    return true;
}

void Corpse::SaveToDB()
{
    // prevent DB data inconsistence problems and duplicates
    RealmDataDatabase.BeginTransaction();
    DeleteFromDB();

    static SqlStatementID saveCorpse;
    SqlStatement stmt = RealmDataDatabase.CreateStatement(saveCorpse, "INSERT INTO corpse (guid,player,position_x,position_y,position_z,orientation,zone,map,data,time,corpse_type,instance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    stmt.addUInt64(GetGUIDLow());
    stmt.addUInt64(GUID_LOPART(GetOwnerGUID()));
    stmt.addFloat(GetPositionX());
    stmt.addFloat(GetPositionY());
    stmt.addFloat(GetPositionZ());
    stmt.addFloat(GetOrientation());
    stmt.addUInt32(GetZoneId());
    stmt.addUInt32(GetMapId());
    stmt.addString(GetUInt32ValuesString());
    stmt.addUInt64(m_time);
    stmt.addUInt32(GetType());
    stmt.addInt32(GetInstanceId());

    stmt.Execute();
    RealmDataDatabase.CommitTransaction();
}

void Corpse::DeleteBonesFromWorld()
{
    ASSERT(GetType()==CORPSE_BONES);
    Corpse* corpse = ObjectAccessor::GetCorpse(*this, GetGUID());

    if (!corpse)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Bones %u not found in world.", GetGUIDLow());
        return;
    }

    AddObjectToRemoveList();
}

void Corpse::DeleteFromDB()
{
    static SqlStatementID deleteCorpse;
    static SqlStatementID deleteCorpseByPlayer;

    if (GetType() == CORPSE_BONES)
    {
        // only specific bones
        SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteCorpse, "DELETE FROM corpse WHERE guid = ?");
        stmt.PExecute(GetGUIDLow());
    }
    else
    {
        // all corpses (not bones)
        SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteCorpseByPlayer, "DELETE FROM corpse WHERE player = ? AND corpse_type <> '0'");
        stmt.PExecute(GUID_LOPART(GetOwnerGUID()));
    }
}

bool Corpse::LoadFromDB(uint32 guid, QueryResultAutoPtr result, uint32 InstanceId)
{
    if (! result)
        //                                        0          1          2          3           4   5    6    7           8
        result = RealmDataDatabase.PQuery("SELECT position_x,position_y,position_z,orientation,map,data,time,corpse_type,instance FROM corpse WHERE guid = '%u'",guid);

    if (! result)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Corpse (GUID: %u) not found in table `corpse`, can't load. ",guid);
        return false;
    }

    Field *fields = result->Fetch();

    if (!LoadFromDB(guid,fields))
        return false;

    return true;
}

bool Corpse::LoadFromDB(uint32 guid, Field *fields)
{
    //                                          0          1          2          3           4   5    6    7           8
    //result = CharacterDatabase.PQuery("SELECT position_x,position_y,position_z,orientation,map,data,time,corpse_type,instance FROM corpse WHERE guid = '%u'",guid);
    float positionX = fields[0].GetFloat();
    float positionY = fields[1].GetFloat();
    float positionZ = fields[2].GetFloat();
    float ort       = fields[3].GetFloat();
    uint32 mapid    = fields[4].GetUInt32();

    if (!LoadValues(fields[5].GetString()))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Corpse #%d have broken data in `data` field. Can't be loaded.",guid);
        return false;
    }

    m_time             = time_t(fields[6].GetUInt64());
    m_type             = CorpseType(fields[7].GetUInt32());
    if (m_type >= MAX_CORPSE_TYPE)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Corpse (guidlow %d, owner %d) have wrong corpse type, not load.",GetGUIDLow(),GUID_LOPART(GetOwnerGUID()));
        return false;
    }
    uint32 instanceid  = fields[8].GetUInt32();

    // overwrite possible wrong/corrupted guid
    SetUInt64Value(OBJECT_FIELD_GUID, MAKE_NEW_GUID(guid, 0, HIGHGUID_CORPSE));

    // place
    SetInstanceId(instanceid);
    SetMapId(mapid);
    Relocate(positionX,positionY,positionZ,ort);

    if (!IsPositionValid())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Corpse (guidlow %d, owner %d) not created. Suggested coordinates isn't valid (X: %f Y: %f)",
            GetGUIDLow(),GUID_LOPART(GetOwnerGUID()),GetPositionX(),GetPositionY());
        return false;
    }

    m_grid = Looking4group::ComputeGridPair(GetPositionX(), GetPositionY());

    return true;
}

bool Corpse::isVisibleForInState(Player const* player, WorldObject const* viewPoint, bool inVisibleList) const
{
    if (m_type == CORPSE_BONES && player->GetSession()->IsAccountFlagged(ACC_HIDE_BONES))
        return false;

    if (!IsInWorld() || !player->IsInWorld())
        return false;

    return IsWithinDistInMap(viewPoint, viewPoint->GetMap()->GetVisibilityDistance(const_cast<Corpse*>(this), const_cast<Player*>(player)) + (inVisibleList ? World::GetVisibleObjectGreyDistance() : 0.0f), false);
}

bool Corpse::IsExpired(time_t t) const
{
    if (m_type == CORPSE_BONES)
        return m_time < t - 60*MINUTE;
    else
        return m_time < t - 3*DAY;
}
