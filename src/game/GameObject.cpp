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
#include "QuestDef.h"
#include "GameObject.h"
#include "ObjectMgr.h"
#include "PoolManager.h"
#include "SpellMgr.h"
#include "Spell.h"
#include "UpdateMask.h"
#include "Opcodes.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "World.h"
#include "Database/DatabaseEnv.h"
#include "MapManager.h"
#include "LootMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "InstanceData.h"
#include "BattleGround.h"
#include "Util.h"
#include "OutdoorPvPMgr.h"
#include "BattleGroundAV.h"
#include "Map.h"
#include "ScriptMgr.h"

GameObject::GameObject() : WorldObject()
{
    m_objectType |= TYPEMASK_GAMEOBJECT;
    m_objectTypeId = TYPEID_GAMEOBJECT;
                                                            // 2.3.2 - 0x58
    m_updateFlag = (UPDATEFLAG_LOWGUID | UPDATEFLAG_HIGHGUID | UPDATEFLAG_HAS_POSITION);

    m_valuesCount = GAMEOBJECT_END;
    m_respawnTime = 0;
    m_respawnDelayTime = 25;
    m_lootState = GO_NOT_READY;
    m_spawnedByDefault = true;
    m_usetimes = 0;
    m_spellId = 0;
    m_charges = 5;
    m_cooldownTime = 0;
    m_goInfo = NULL;
    m_goData = NULL;

    m_DBTableGuid = 0;
}

GameObject::~GameObject()
{
    CleanupsBeforeDelete();
}

void GameObject::CleanupsBeforeDelete()
{
    if (m_uint32Values)                                      // field array can be not exist if GameOBject not loaded
    {
        // crash possible at access to deleted GO in Unit::m_gameobj
        if (uint64 owner_guid = GetOwnerGUID())
        {
            Unit* owner = NULL;
            if (IS_PLAYER_GUID(owner_guid))
                owner = ObjectAccessor::GetPlayer(owner_guid);
            else
                owner = GetMap()->GetUnit(owner_guid);

            if (owner)
                owner->RemoveGameObject(this,false);
            else
            {
                const char * ownerType = "creature";
                if (IS_PLAYER_GUID(owner_guid))
                    ownerType = "player";
                else if (IS_PET_GUID(owner_guid))
                    ownerType = "pet";

                sLog.outLog(LOG_DEFAULT, "ERROR: Delete GameObject (GUID: %u Entry: %u SpellId %u LinkedGO %u) that lost references to owner (GUID %u Type '%s') GO list. Crash possible later.",
                    GetGUIDLow(), GetGOInfo()->id, m_spellId, GetLinkedGameObjectEntry(), GUID_LOPART(owner_guid), ownerType);
            }
        }
    }
}

void GameObject::SendCustomAnimation()
{
    WorldPacket data(SMSG_GAMEOBJECT_CUSTOM_ANIM,8+4);
    data << GetGUID();
    data << (uint32)(GetGoAnimProgress());
    BroadcastPacket(&data, false);
}

void GameObject::SendSpawnAnimation()
{
    WorldPacket data(SMSG_GAMEOBJECT_SPAWN_ANIM_OBSOLETE, 8);
    data << GetGUID();
    BroadcastPacket(&data, true);
}

void GameObject::AddToWorld()
{
    ///- Register the gameobject for guid lookup
    if (!IsInWorld())
    {
        GetMap()->InsertIntoObjMap(this);
        WorldObject::AddToWorld();

        if (m_zoneScript)
            m_zoneScript->OnGameObjectCreate(this, true);
    }
}

void GameObject::RemoveFromWorld()
{
    ///- Remove the gameobject from the accessor
    if (IsInWorld())
    {
        if (m_zoneScript)
            m_zoneScript->OnGameObjectCreate(this, false);

        WorldObject::RemoveFromWorld();
        GetMap()->RemoveFromObjMap(GetGUID());
    }
}

bool GameObject::Create(uint32 guidlow, uint32 name_id, Map *map, float x, float y, float z, float ang, float rotation0, float rotation1, float rotation2, float rotation3, uint32 animprogress, GOState go_state, uint32 ArtKit)
{
    Relocate(x,y,z,ang);
    SetMapId(map->GetId());
    SetInstanceId(map->GetInstanceId());

    SetMap(map);

    if (!IsPositionValid())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Gameobject (GUID: %u Entry: %u) not created. Suggested coordinates isn't valid (X: %f Y: %f)",guidlow,name_id,x,y);
        return false;
    }

    GameObjectInfo const* goinfo = ObjectMgr::GetGameObjectInfo(name_id);
    if (!goinfo)
    {
        sLog.outLog(LOG_DB_ERR, "Gameobject (GUID: %u Entry: %u) not created: it have not exist entry in `gameobject_template`. Map: %u  (X: %f Y: %f Z: %f) ang: %f rotation0: %f rotation1: %f rotation2: %f rotation3: %f",guidlow, name_id, map->GetId(), x, y, z, ang, rotation0, rotation1, rotation2, rotation3);
        return false;
    }

    Object::_Create(guidlow, goinfo->id, HIGHGUID_GAMEOBJECT);

    m_goInfo = goinfo;

    if (goinfo->type >= MAX_GAMEOBJECT_TYPE)
    {
        sLog.outLog(LOG_DB_ERR, "Gameobject (GUID: %u Entry: %u) not created: it have not exist GO type '%u' in `gameobject_template`. It's will crash client if created.",guidlow,name_id,goinfo->type);
        return false;
    }

    SetFloatValue(GAMEOBJECT_POS_X, x);
    SetFloatValue(GAMEOBJECT_POS_Y, y);
    SetFloatValue(GAMEOBJECT_POS_Z, z);

    SetFloatValue(GAMEOBJECT_ROTATION+0, rotation0);
    SetFloatValue(GAMEOBJECT_ROTATION+1, rotation1);

    UpdateRotationFields(rotation2, rotation3);              // GAMEOBJECT_FACING, GAMEOBJECT_ROTATION+2/3

    SetFloatValue(OBJECT_FIELD_SCALE_X, goinfo->size);

    SetUInt32Value(GAMEOBJECT_FACTION, goinfo->faction);
    SetUInt32Value(GAMEOBJECT_FLAGS, goinfo->flags);

    SetUInt32Value(OBJECT_FIELD_ENTRY, goinfo->id);

    SetUInt32Value(GAMEOBJECT_DISPLAYID, goinfo->displayId);

    SetGoState(go_state);
    SetGoType(GameobjectTypes(goinfo->type));

    SetGoAnimProgress(animprogress);

    SetUInt32Value (GAMEOBJECT_ARTKIT, ArtKit);

    // Spell charges for GAMEOBJECT_TYPE_SPELLCASTER (22)
    if (goinfo->type == GAMEOBJECT_TYPE_SPELLCASTER)
        m_charges = goinfo->spellcaster.charges;

    SetZoneScript();

    return true;
}

void GameObject::Update(uint32 update_diff, uint32 p_time)
{
    if (IS_MO_TRANSPORT(GetGUID()))
    {
        //((Transport*)this)->Update(p_time);
        return;
    }

    if (m_respawnTime > 0)
    {
        if (m_respawnTime <= time(NULL))
        {
            if(m_spawnedByDefault)
            {
                Respawn();
            }
            else
            {
                Despawn();
            }
        }
    }

    if(!isSpawned())
        return;


    switch (m_lootState)
    {
        case GO_NOT_READY:
        {
            switch (GetGoType())
            {
                case GAMEOBJECT_TYPE_TRAP:
                {
                    // Arming Time for GAMEOBJECT_TYPE_TRAP (6)
                    if (Unit* owner = GetOwner())
                        m_cooldownTime = time(NULL) + GetGOInfo()->trap.startDelay;
                    m_lootState = GO_READY;
                    break;
                }
                case GAMEOBJECT_TYPE_FISHINGNODE:
                {
                    // fishing code (bobber ready)
                    if (time(NULL) > m_respawnTime - FISHING_BOBBER_READY_TIME)
                    {
                        // splash bobber (bobber ready now)
                        Unit* caster = GetOwner();
                        if (caster && caster->GetTypeId()==TYPEID_PLAYER)
                        {
                            SetGoState(GO_STATE_ACTIVE);
                            //SetUInt32Value(GAMEOBJECT_FLAGS, GO_FLAG_NODESPAWN);

                            UpdateData udata;
                            WorldPacket packet;
                            BuildValuesUpdateBlockForPlayer(&udata,((Player*)caster));
                            udata.BuildPacket(&packet);
                            ((Player*)caster)->SendPacketToSelf(&packet);

                            SendGameObjectCustomAnim(GetGUID());
                        }

                        m_lootState = GO_READY;                 // can be successfully open with some chance
                    }
                    return;
                }
                default:
                    m_lootState = GO_READY;                         // for other GOis same switched without delay to GO_READY
                    break;
            }
            // NO BREAK for switch (m_lootState)
        }
        case GO_READY:
        {
            // traps can have time and can not have
            GameObjectInfo const* goInfo = GetGOInfo();
            if (goInfo && goInfo->type == GAMEOBJECT_TYPE_TRAP)
            {
                // traps
                Unit* owner = GetOwner();
                Unit* ok = NULL;                            // pointer to appropriate target if found any

                if (m_cooldownTime >= time(NULL))
                    return;

                bool IsBattleGroundTrap = false;
                //FIXME: this is activation radius (in different casting radius that must be selected from spell data)
                //TODO: move activated state code (cast itself) to GO_ACTIVATED, in this place only check activating and set state
                float radius = float(goInfo->trap.radius);///2; // TODO rename radius to diameter (goInfo->trap.radius) should be (goInfo->trap.diameter)

                if (!radius)
                {
                    if (goInfo->trap.cooldown != 3)            // cast in other case (at some triggering/linked go/etc explicit call)
                    {
                        // try to read radius from trap spell
                        if (const SpellEntry *spellEntry = sSpellStore.LookupEntry(goInfo->trap.spellId))
                            radius = SpellMgr::GetSpellRadius(spellEntry,0,false);

                        if (!radius)
                            break;
                    }
                    else
                    {
                        if (m_respawnTime > 0)
                            break;

                        radius = goInfo->trap.cooldown;       // battlegrounds gameobjects has data2 == 0 && data5 == 3
                        IsBattleGroundTrap = true;
                    }
                }

                bool NeedDespawn = (goInfo->trap.charges != 0);

                // Note: this hack with search required until GO casting not implemented
                // search unfriendly creature
                if (owner && NeedDespawn)                    // hunter trap
                {
                    Looking4group::AnyUnfriendlyNoTotemUnitInObjectRangeCheck u_check(this, owner, radius);
                    Looking4group::UnitSearcher<Looking4group::AnyUnfriendlyNoTotemUnitInObjectRangeCheck> checker(ok, u_check);

                    Cell::VisitGridObjects(this, checker, radius);

                    if (!ok)
                        Cell::VisitWorldObjects(this, checker, radius);
                }
                else if (isSpawnedByDefault())                                        // environmental trap
                {
                    // affect only players
                    Player* p_ok = NULL;
                    Looking4group::AnyPlayerInObjectRangeCheck p_check(this, radius);
                    Looking4group::ObjectSearcher<Player, Looking4group::AnyPlayerInObjectRangeCheck>  checker(p_ok, p_check);

                    Cell::VisitWorldObjects(this,checker, radius);

                    ok = p_ok;
                }
                else                                                                 // creature spawned traps
                {
                    CastSpell((Unit*)NULL, goInfo->trap.spellId);
                    m_cooldownTime = time(NULL) + goInfo->trap.cooldown;
                }

                if (ok)
                {
                    CastSpell(ok, goInfo->trap.spellId);
                    m_cooldownTime = time(NULL) + (goInfo->trap.cooldown ? goInfo->trap.cooldown : 4);    // default 4 sec cooldown??
                    SendCustomAnimation();

                    if (NeedDespawn)
                        SetLootState(GO_JUST_DEACTIVATED);  // can be despawned or destroyed

                    if (IsBattleGroundTrap && ok->GetTypeId() == TYPEID_PLAYER)
                    {
                        //BattleGround gameobjects case
                        if (((Player*)ok)->InBattleGround())
                            if (BattleGround *bg = ((Player*)ok)->GetBattleGround())
                                bg->HandleTriggerBuff(GetGUID());
                    }
                }
            }
            break;
        }
        case GO_ACTIVATED:
        {
            switch (GetGoType())
            {
                case GAMEOBJECT_TYPE_DOOR:
                {
                    if(!GetGOInfo()->door.autoCloseTime)
                        return;

                    if(m_cooldownTime > time(NULL))
                        return;

                    SetGoState(GetGOInfo()->door.startOpen ? GO_STATE_ACTIVE : GO_STATE_READY);
                    SetLootState(GO_READY);
                    m_cooldownTime = 0;
                    break;
                }
                case GAMEOBJECT_TYPE_BUTTON:
                {
                    if(!GetGOInfo()->button.autoCloseTime)
                        return;

                    if(m_cooldownTime > time(NULL))
                        return;

                    SetGoState(GetGOInfo()->button.startOpen ? GO_STATE_ACTIVE : GO_STATE_READY);
                    SetLootState(GO_READY);
                    m_cooldownTime = 0;
                    break;
                }
                case GAMEOBJECT_TYPE_GOOBER:
                    if (m_cooldownTime < time(NULL))
                    {
                        RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);

                        SetLootState(GO_JUST_DEACTIVATED);
                        m_cooldownTime = 0;
                    }
                    break;
                case GAMEOBJECT_TYPE_CHEST:
                    if(loot.isLooted())
                    {
                        if ((GetUseCount() >= GetGOInfo()->chest.maxSuccessOpens) ||
                            ((GetUseCount() >= GetGOInfo()->chest.minSuccessOpens) && (GetUseCount() >= irand(GetGOInfo()->chest.minSuccessOpens, GetGOInfo()->chest.maxSuccessOpens))))
                        {
                            SetLootState(GO_JUST_DEACTIVATED);
                        }
                        else
                        {
                            SetLootState(GO_READY);
                        }
                    }

                    break;
                case GAMEOBJECT_TYPE_SUMMONING_RITUAL:
                {
                    if (!m_unique_users.empty())
                    {
                        std::set<uint32>::iterator i = m_unique_users.begin();
                        for(; i != m_unique_users.end(); i++)
                        {
                            Unit* caster = Unit::GetUnit(*this, uint64(*i));
                            if (!(caster && caster->GetCurrentSpell(CURRENT_CHANNELED_SPELL)))
                            {
                                m_lootState = GO_JUST_DEACTIVATED;
                                break;
                            }
                        }
                        SendGameObjectCustomAnim(GetGUID());
                    }
                    else
                        m_lootState = GO_JUST_DEACTIVATED;
                    break;
                }
                default:
                {
                    m_lootState = GO_JUST_DEACTIVATED;
                    break;
                }
            }
            break;
        }
        case GO_JUST_DEACTIVATED:
        {
            switch (GetGoType())
            {
                case GAMEOBJECT_TYPE_SUMMONING_RITUAL:
                {
                    if(m_target)
                    {
                        if(Player* target = Player::GetPlayer(m_target))
                        {
                            if(GetGOInfo()->summoningRitual.spellId == 7720)
                            {
                                WorldPacket data(SMSG_SUMMON_CANCEL, 0);
                                target->SendPacketToSelf(&data);

                            }
                        }
                    }
                    std::set<uint32>::iterator i = m_unique_users.begin();
                    for(; i != m_unique_users.end(); i++)
                    {
                        if (Unit* caster = Unit::GetUnit(*this, uint64(*i)))
                        {
                            if (caster->m_currentSpells[CURRENT_CHANNELED_SPELL])
                            {
                                caster->m_currentSpells[CURRENT_CHANNELED_SPELL]->SendChannelUpdate(0);
                                caster->m_currentSpells[CURRENT_CHANNELED_SPELL]->finish();
                            }
                        }
                    }
                    break;
                }
            }

            if (GetDespawnPossibility())
                Despawn();

            break;
        }
    }
}

void GameObject::Refresh()
{
    // not refresh despawned not casted GO (despawned casted GO destroyed in all cases anyway)
    if (m_respawnTime > 0 && m_spawnedByDefault)
        return;

    if (isSpawned())
        GetMap()->Add(this);
}

void GameObject::AddUniqueUse(Player* player)
{
    if (m_unique_users.find(player->GetGUIDLow()) != m_unique_users.end())
        return;
    AddUse();
    m_unique_users.insert(player->GetGUIDLow());
}

void GameObject::Delete(bool setGoState)
{
    SendObjectDeSpawnAnim(GetGUID());

    if (setGoState)
        SetGoState(GO_STATE_READY);

    SetUInt32Value(GAMEOBJECT_FLAGS, GetGOInfo()->flags);

    uint16 poolid = sPoolMgr.IsPartOfAPool<GameObject>(GetGUIDLow());
    if (poolid)
        sPoolMgr.UpdatePool<GameObject>(poolid, GetGUIDLow());
    else
        AddObjectToRemoveList();
}

void GameObject::getFishLoot(Loot *fishloot, Player* loot_owner)
{
    fishloot->clear();

    uint32 subzone = GetAreaId();

    // if subzone loot exist use it
    if (LootTemplates_Fishing.HaveLootfor (subzone))
        fishloot->FillLoot(subzone, LootTemplates_Fishing, loot_owner,true);
    // else use zone loot
    else
        fishloot->FillLoot(GetZoneId(), LootTemplates_Fishing, loot_owner,true);
}

void GameObject::SaveToDB()
{
    // this should only be used when the gameobject has already been loaded
    // preferably after adding to map, because mapid may not be valid otherwise
    GameObjectData const *data = sObjectMgr.GetGOData(m_DBTableGuid);
    if (!data)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: GameObject::SaveToDB failed, cannot get gameobject data!");
        return;
    }

    SaveToDB(GetMapId(), data->spawnMask);
}

void GameObject::SaveToDB(uint32 mapid, uint8 spawnMask)
{
    const GameObjectInfo *goI = GetGOInfo();

    if (!goI)
        return;

    if (!m_DBTableGuid)
        m_DBTableGuid = GetGUIDLow();
    // update in loaded data (changing data only in this place)
    GameObjectData& data = sObjectMgr.NewGOData(m_DBTableGuid);

    // data->guid = guid don't must be update at save
    data.id = GetEntry();
    data.mapid = mapid;
    data.posX = GetFloatValue(GAMEOBJECT_POS_X);
    data.posY = GetFloatValue(GAMEOBJECT_POS_Y);
    data.posZ = GetFloatValue(GAMEOBJECT_POS_Z);
    data.orientation = GetFloatValue(GAMEOBJECT_FACING);
    data.rotation0 = GetFloatValue(GAMEOBJECT_ROTATION+0);
    data.rotation1 = GetFloatValue(GAMEOBJECT_ROTATION+1);
    data.rotation2 = GetFloatValue(GAMEOBJECT_ROTATION+2);
    data.rotation3 = GetFloatValue(GAMEOBJECT_ROTATION+3);
    data.spawntimesecs = m_spawnedByDefault ? m_respawnDelayTime : -(int32)m_respawnDelayTime;
    data.animprogress = GetGoAnimProgress();
    data.go_state = GetGoState();
    data.spawnMask = spawnMask;
    data.ArtKit = GetUInt32Value (GAMEOBJECT_ARTKIT);

    // updated in DB
        std::ostringstream ss;
    ss << "INSERT INTO gameobject VALUES ( "
            << m_DBTableGuid << ", "
            << GetUInt32Value(OBJECT_FIELD_ENTRY) << ", "
            << mapid << ", "
            << (uint32) spawnMask << ", "
            << GetFloatValue(GAMEOBJECT_POS_X) << ", "
            << GetFloatValue(GAMEOBJECT_POS_Y) << ", "
            << GetFloatValue(GAMEOBJECT_POS_Z) << ", "
            << GetFloatValue(GAMEOBJECT_FACING) << ", "
            << GetFloatValue(GAMEOBJECT_ROTATION) << ", "
            << GetFloatValue(GAMEOBJECT_ROTATION + 1) << ", "
            << GetFloatValue(GAMEOBJECT_ROTATION + 2) << ", "
            << GetFloatValue(GAMEOBJECT_ROTATION + 3) << ", "
            << m_respawnDelayTime << ", "
            << GetGoAnimProgress() << ", "
            << GetGoState() << ")";

    GameDataDatabase.BeginTransaction();
    GameDataDatabase.PExecuteLog("DELETE FROM gameobject WHERE guid = '%u'", m_DBTableGuid);
    GameDataDatabase.PExecuteLog(ss.str().c_str());
    GameDataDatabase.CommitTransaction();
}

bool GameObject::LoadFromDB(uint32 guid, Map *map)
{
    GameObjectData const* data = sObjectMgr.GetGOData(guid);

    if (!data)
    {
        sLog.outLog(LOG_DB_ERR, "ERROR: Gameobject (GUID: %u) not found in table `gameobject`, can't load. ",guid);
        return false;
    }

    uint32 entry = data->id;
    uint32 map_id = data->mapid;
    float x = data->posX;
    float y = data->posY;
    float z = data->posZ;
    float ang = data->orientation;

    float rotation0 = data->rotation0;
    float rotation1 = data->rotation1;
    float rotation2 = data->rotation2;
    float rotation3 = data->rotation3;

    uint32 animprogress = data->animprogress;
    GOState go_state = data->go_state;
    uint32 ArtKit = data->ArtKit;

    m_DBTableGuid = guid;
    if (map->GetInstanceId() != 0)
        guid = sObjectMgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT);

    if (!Create(guid,entry, map, x, y, z, ang, rotation0, rotation1, rotation2, rotation3, animprogress, go_state, ArtKit))
    {
        sLog.outDetail("Couldn't create gameobject with entry: %u", entry);
        return false;
    }

    if (!GetDespawnPossibility())
    {
        SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NODESPAWN);
        m_spawnedByDefault = true;
        m_respawnDelayTime = 0;
        m_respawnTime = 0;
    }
    else
    {
        if (data->spawntimesecs >= 0)
        {
            m_spawnedByDefault = true;
            m_respawnDelayTime = data->spawntimesecs;
            m_respawnTime = sObjectMgr.GetGORespawnTime(m_DBTableGuid, map->GetInstanceId());

            // ready to respawn
            if (m_respawnTime && m_respawnTime <= time(NULL))
            {
                m_respawnTime = 0;
                sObjectMgr.SaveGORespawnTime(m_DBTableGuid,GetInstanceId(),0);
            }
        }
        else
        {
            m_spawnedByDefault = false;
            m_respawnDelayTime = -data->spawntimesecs;
        }
    }
    m_goData = data;

    return true;
}

void GameObject::DeleteFromDB()
{
    sObjectMgr.SaveGORespawnTime(m_DBTableGuid,GetInstanceId(),0);
    sObjectMgr.DeleteGOData(m_DBTableGuid);
    GameDataDatabase.PExecuteLog("DELETE FROM gameobject WHERE guid = '%u'", m_DBTableGuid);
    GameDataDatabase.PExecuteLog("DELETE FROM game_event_gameobject WHERE guid = '%u'", m_DBTableGuid);
}

GameObject* GameObject::GetGameObject(WorldObject& object, uint64 guid)
{
    return object.GetMap()->GetGameObject(guid);
}

uint32 GameObject::GetLootId(GameObjectInfo const* ginfo)
{
    if (!ginfo)
        return 0;

    switch (ginfo->type)
    {
        case GAMEOBJECT_TYPE_CHEST:
            return ginfo->chest.lootId;
        case GAMEOBJECT_TYPE_FISHINGHOLE:
            return ginfo->fishinghole.lootId;
        case GAMEOBJECT_TYPE_FISHINGNODE:
            return ginfo->fishnode.lootId;
        default:
            return 0;
    }
}

/*********************************************************/
/***                    QUEST SYSTEM                   ***/
/*********************************************************/
bool GameObject::hasQuest(uint32 quest_id) const
{
    QuestRelations const& qr = sObjectMgr.mGOQuestRelations;
    for (QuestRelations::const_iterator itr = qr.lower_bound(GetEntry()); itr != qr.upper_bound(GetEntry()); ++itr)
    {
        if (itr->second==quest_id)
            return true;
    }
    return false;
}

bool GameObject::hasInvolvedQuest(uint32 quest_id) const
{
    QuestRelations const& qr = sObjectMgr.mGOQuestInvolvedRelations;
    for (QuestRelations::const_iterator itr = qr.lower_bound(GetEntry()); itr != qr.upper_bound(GetEntry()); ++itr)
    {
        if (itr->second==quest_id)
            return true;
    }
    return false;
}

bool GameObject::IsTransport() const
{
    // If something is marked as a transport, don't transmit an out of range packet for it.
    GameObjectInfo const * gInfo = GetGOInfo();
    if (!gInfo) return false;
    return gInfo->type == GAMEOBJECT_TYPE_TRANSPORT || gInfo->type == GAMEOBJECT_TYPE_MO_TRANSPORT;
}

Unit* GameObject::GetOwner() const
{
    return GetMap()->GetUnit(GetOwnerGUID());
}

void GameObject::SaveRespawnTime()
{
    if (m_goData && m_goData->dbData && m_respawnTime > time(NULL) && m_spawnedByDefault)
        sObjectMgr.SaveGORespawnTime(m_DBTableGuid,GetInstanceId(),m_respawnTime);
}

bool GameObject::isVisibleForInState(Player const* player, WorldObject const* viewPoint, bool inVisibleList) const
{
    // Not in world
    if (!IsInWorld() || !player->IsInWorld())
        return false;

    // Transport always visible at this step implementation
    if (IsTransport() && IsInMap(player))
        return true;

    // quick check visibility false cases for non-GM-mode
    if (!player->isGameMaster())
    {
        // despawned and then not visible for non-GM in GM-mode
        if (!isSpawned())
            return false;

        // special invisibility cases
        if (GetGOInfo()->type == GAMEOBJECT_TYPE_TRAP && GetGOInfo()->trap.stealthed)
        {
            Unit *owner = GetOwner();
            if (owner && player->IsHostileTo(owner) && !canDetectTrap(player, GetDistance(player)))
                return false;
        }

        // Smuggled Mana Cell required 10 invisibility type detection/state
        if (GetEntry() == 187039 && ((player->m_detectInvisibilityMask | player->m_invisibilityMask) & (1<<10))==0)
            return false;
    }

    return IsWithinDistInMap(viewPoint, GetMap()->GetVisibilityDistance(const_cast<GameObject*>(this), const_cast<Player*>(player)) + (inVisibleList ? World::GetVisibleObjectGreyDistance() : 0.0f), false);
}

bool GameObject::canDetectTrap(Player const* u, float distance) const
{
    if (u->hasUnitState(UNIT_STAT_STUNNED))
        return false;
    if (distance < GetGOInfo()->size) //collision
        return true;
    if (!u->HasInArc(M_PI, this)) //behind
        return false;
    if (u->HasAuraType(SPELL_AURA_DETECT_STEALTH))
        return true;

    //Visible distance is modified by -Level Diff (every level diff = 0.25f in visible distance)
    float visibleDistance = (int32(u->getLevel()) - int32(GetOwner()->getLevel()))* 0.25f;
    //GetModifier for trap (miscvalue 1)
    //35y for aura 2836
    //WARNING: these values are guessed, may be not blizzlike
    visibleDistance += u->GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_DETECT, 1)* 0.5f;

    return distance < visibleDistance;
}

void GameObject::Respawn()
{
    Reset();
    m_respawnTime = 0;
    SendSpawnAnimation();

    uint16 poolid = sPoolMgr.IsPartOfAPool<GameObject>(GetGUIDLow());
    if (poolid)
        sPoolMgr.UpdatePool<GameObject>(poolid, GetGUIDLow());
    else
        GetMap()->Add(this);

    UpdateObjectVisibility();
}

void GameObject::Activate()
{
    SendGameObjectCustomAnim(GetGUID());
    SetLootState(GO_ACTIVATED);
}

void GameObject::Reset()
{
    m_SkillupList.clear();
    m_usetimes = 0;
    loot.clear();
    SetUInt32Value(GAMEOBJECT_FLAGS, GetGOInfo()->flags);
    SetGoState(GetGOData() ? GetGOData()->go_state : GO_STATE_READY);
    SetLootState(GO_READY);
    if (!GetDespawnPossibility())
        SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NODESPAWN);// this flag is set in LoadFromDB() for some objects

}

void GameObject::Despawn()
{
    if (GetUInt32Value(GAMEOBJECT_FLAGS) & GO_FLAG_NODESPAWN)
        return;

    if (GetOwnerGUID())
    {
        if (Unit* owner = GetOwner())
            owner->RemoveGameObject(this, false);

        m_respawnTime = 0;
        Delete();
    }
    else
    {
        SendObjectDeSpawnAnim(GetGUID());
        m_respawnTime = m_spawnedByDefault ? time(NULL) + m_respawnDelayTime : 0;

        // if option not set then object will be saved at grid unload
        if (sWorld.getConfig(CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY))
            SaveRespawnTime();
    }

    UpdateObjectVisibility();
}

bool GameObject::ActivateToQuest(Player *pTarget)const
{
    switch (GetGoType())
    {
        case GAMEOBJECT_TYPE_CHEST:
        {
            //TODO: fix this hack
            //look for battlegroundAV for some objects which are only activated after mine gots captured by own team
            if (GetEntry() == BG_AV_OBJECTID_MINE_N || GetEntry() == BG_AV_OBJECTID_MINE_S)
                if (BattleGround *bg = pTarget->GetBattleGround())
                    if (bg->GetTypeID() == BATTLEGROUND_AV && !(((BattleGroundAV*)bg)->PlayerCanDoMineQuest(GetEntry(),pTarget->GetTeam())))
                        return false;
            return LootTemplates_Gameobject.HaveQuestLootForPlayer(GetLootId(), pTarget);
        }
        case GAMEOBJECT_TYPE_GOOBER:
        {
            return pTarget->GetQuestStatus(GetGOInfo()->goober.questId) == QUEST_STATUS_INCOMPLETE;
        }
        case GAMEOBJECT_TYPE_GENERIC:
        {
            return pTarget->GetQuestStatus(GetGOInfo()->_generic.questID) == QUEST_STATUS_INCOMPLETE;
        }
        default:
            return false;
    }
}

void GameObject::TriggeringLinkedGameObject(uint32 trapEntry, Unit* target)
{
    GameObjectInfo const* trapInfo = sGOStorage.LookupEntry<GameObjectInfo>(trapEntry);
    if (!trapInfo || trapInfo->type!=GAMEOBJECT_TYPE_TRAP)
        return;

    SpellEntry const* trapSpell = sSpellStore.LookupEntry(trapInfo->trap.spellId);
    if (!trapSpell)                                          // checked at load already
        return;

    float range = SpellMgr::GetSpellMaxRange(sSpellRangeStore.LookupEntry(trapSpell->rangeIndex));

    // search nearest linked GO
    GameObject* trapGO = NULL;
    {
        // using original GO distance
        Looking4group::NearestGameObjectEntryInObjectRangeCheck go_check(*target, trapEntry, range);
        Looking4group::ObjectLastSearcher<GameObject, Looking4group::NearestGameObjectEntryInObjectRangeCheck> checker(trapGO, go_check);

        Cell::VisitGridObjects(this, checker, range);
    }

    // found correct GO
    // FIXME: when GO casting will be implemented trap must cast spell to target
    if (trapGO)
        target->CastSpell(target, trapSpell ,true);
}

GameObject* GameObject::LookupFishingHoleAround(float range)
{
    GameObject* ok = NULL;

    Looking4group::NearestGameObjectFishingHole u_check(*this, range);
    Looking4group::ObjectSearcher<GameObject, Looking4group::NearestGameObjectFishingHole> checker(ok, u_check);

    Cell::VisitGridObjects(this, checker, range);
    return ok;
}

void GameObject::ResetDoorOrButton()
{
    m_cooldownTime = 0;
}

void GameObject::UseDoorOrButton(uint32 time_to_restore, bool alternative /* = false */)
{
    if (m_lootState != GO_READY)
        return;

    if (!time_to_restore)
        time_to_restore = GetAutoCloseTime();

    SwitchDoorOrButton();
    SetLootState(GO_ACTIVATED);

    m_cooldownTime = time(NULL) + time_to_restore;
}

void GameObject::SetGoArtKit(uint32 kit)
{
    SetUInt32Value(GAMEOBJECT_ARTKIT, kit);
    GameObjectData *data = const_cast<GameObjectData*>(sObjectMgr.GetGOData(m_DBTableGuid));
    if (data)
        data->ArtKit = kit;
}

void GameObject::SwitchDoorOrButton()
{
    if (GetGoState() == GO_STATE_READY)                     //if closed -> open
        SetGoState(GO_STATE_ACTIVE);
    else                                                    //if open -> close
        SetGoState(GO_STATE_READY);
}

void GameObject::Use(Unit* user)
{
    if (!isSpawned())
        return;

    // by default spell caster is user
    Unit* spellCaster = user;
    uint32 spellId = 0;

    Player *pPlayer = user->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (pPlayer)
    {
        if (sScriptMgr.OnGameObjectUse(pPlayer, this))
            return;
    }

    GetMap()->ScriptsStart(sGameObjectScripts, GetDBTableGUIDLow(), user, this);

    switch (GetGoType())
    {
        case GAMEOBJECT_TYPE_BUTTON:                        //1
            if (uint32 trapEntry = GetGOInfo()->button.linkedTrap)
                TriggeringLinkedGameObject(trapEntry, user);
        case GAMEOBJECT_TYPE_DOOR:                          //0
            if (GetGoState() == GO_STATE_READY)                     //if closed -> open
                SetGoState(GO_STATE_ACTIVE);
            else                                                    //if open -> close
                SetGoState(GO_STATE_READY);
            m_cooldownTime = time(NULL) + GetAutoCloseTime();
            Activate();
            break;
        case GAMEOBJECT_TYPE_QUESTGIVER:                    //2
        {
            if (!pPlayer)
                return;

            pPlayer->PrepareQuestMenu(GetGUID());
            pPlayer->SendPreparedQuest(GetGUID());
            return;
        }
        case GAMEOBJECT_TYPE_CHEST:                         // 3
        {
            if (!pPlayer)
                return;

            pPlayer->SendLoot(GetGUID(), LOOT_SKINNING);
            //SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
            SetLootState(GO_ACTIVATED);
            AddUse();

            if (GetGOInfo()->chest.eventId)
            {
                if (!sScriptMgr.OnProcessEvent(GetGOInfo()->chest.eventId, this, pPlayer, true))
                    pPlayer->GetMap()->ScriptsStart(sEventScripts, GetGOInfo()->chest.eventId, pPlayer, this);
            }

            // triggering linked GO
            if (uint32 trapEntry = GetGOInfo()->chest.linkedTrapId)
                TriggeringLinkedGameObject(trapEntry, pPlayer);

            return;
        }
        case GAMEOBJECT_TYPE_TRAP:                          // 6
        {
            GameObjectInfo const* info = GetGOInfo();

            if (!info)
                return;

            LockEntry const *lockInfo = sLockStore.LookupEntry(info->trap.lockId);

            if (!lockInfo)
                return;

            for (int j = 0; j < MAX_LOCK_CASE; ++j)
            {
                if ((lockInfo->Type[j] == LOCK_KEY_SKILL)
                    && ((LockType(lockInfo->Index[j])) == LOCKTYPE_DISARM_TRAP))
                {
                    SetLootState(GO_JUST_DEACTIVATED);
                    break;
                }
            }

            return;
        }
        case GAMEOBJECT_TYPE_CHAIR:                         // 7
        {
            GameObjectInfo const* info = GetGOInfo();
            if (!info)
                return;

            // a chair may have n slots. we have to calculate their positions and teleport the player to the nearest one
            // check if the db is sane
            if (info->chair.slots > 0)
            {
                float lowestDist = DEFAULT_VISIBILITY_DISTANCE;

                float x_lowest = GetPositionX();
                float y_lowest = GetPositionY();

                // the object orientation + 1/2 pi
                // every slot will be on that straight line
                float orthogonalOrientation = GetOrientation()+M_PI*0.5f;
                // find nearest slot
                for (uint32 i=0; i<info->chair.slots; i++)
                {
                    // the distance between this slot and the center of the go - imagine a 1D space
                    float relativeDistance = (info->size*i)-(info->size*(info->chair.slots-1)/2.0f);

                    float x_i = GetPositionX() + relativeDistance * cos(orthogonalOrientation);
                    float y_i = GetPositionY() + relativeDistance * sin(orthogonalOrientation);

                    // calculate the distance between the player and this slot
                    float thisDistance = spellCaster->GetDistance2d(x_i, y_i);
                    if (thisDistance <= lowestDist)
                    {
                        lowestDist = thisDistance;
                        x_lowest = x_i;
                        y_lowest = y_i;
                    }
                }
                spellCaster->NearTeleportTo(x_lowest, y_lowest, GetPositionZ(), GetOrientation());
            }
            else
                spellCaster->NearTeleportTo(GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());

            spellCaster->SetStandState(UNIT_STAND_STATE_SIT_LOW_CHAIR+info->chair.height);
            return;
        }
        case GAMEOBJECT_TYPE_SPELL_FOCUS:                   // 8
            // triggering linked GO
            if (uint32 trapEntry = GetGOInfo()->spellFocus.linkedTrapId)
                TriggeringLinkedGameObject(trapEntry, user);
            Activate();
            SetGoState(GO_STATE_ACTIVE);
            return;
        case GAMEOBJECT_TYPE_GOOBER:                        //10
        {
            GameObjectInfo const* info = GetGOInfo();
            if (pPlayer)
            {
                // show page
                if (info->goober.pageId)
                {
                    WorldPacket data(SMSG_GAMEOBJECT_PAGETEXT, 8);
                    data << GetGUID();
                    pPlayer->SendPacketToSelf(&data);
                }

                // possible quest objective for active quests
                if (info->goober.questId && sObjectMgr.GetQuestTemplate(info->goober.questId))
                {
                    //Quest require to be active for GO using
                    if (pPlayer->GetQuestStatus(info->goober.questId) != QUEST_STATUS_INCOMPLETE)
                        break;
                }

                pPlayer->CastedCreatureOrGO(GetEntry(), GetGUID(), 0);

                if (info->goober.eventId)
                {
                    if (!sScriptMgr.OnProcessEvent(info->goober.eventId, this, pPlayer, true))
                        pPlayer->GetMap()->ScriptsStart(sEventScripts, info->goober.eventId, pPlayer, this);
                }

                SetLootState(GO_ACTIVATED); // or SetLootState(GO_JUST_DEACTIVATED);
                SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                m_cooldownTime = time(NULL) + info->goober.cooldown;
            }

            GetMap()->ScriptsStart(sGameObjectScripts, GetDBTableGUIDLow(), pPlayer, this);

            if (uint32 trapEntry = info->goober.linkedTrapId)
                TriggeringLinkedGameObject(trapEntry, user);

            // cast this spell later if provided
            spellId = info->goober.spellId;
            break;
        }
        case GAMEOBJECT_TYPE_CAMERA:                        //13
        {
            GameObjectInfo const* info = GetGOInfo();
            if (!info)
                return;

            if (!pPlayer)
                return;

            if (info->camera.cinematicId)
                pPlayer->SendCinematicStart(info->camera.cinematicId);

            return;
        }
        case GAMEOBJECT_TYPE_FISHINGNODE:                   //17 fishing bobber
        {
            if (user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            if (player->GetGUID() != GetOwnerGUID())
                return;

            switch (getLootState())
            {
            case GO_READY:                              // ready for loot
                {
                    // 1) skill must be >= base_zone_skill
                    // 2) if skill == base_zone_skill => 5% chance
                    // 3) chance is linear dependence from (base_zone_skill-skill)

                    uint32 subzone = GetAreaId();

                    int32 zone_skill = sObjectMgr.GetFishingBaseSkillLevel(subzone);
                    if (!zone_skill)
                        zone_skill = sObjectMgr.GetFishingBaseSkillLevel(GetZoneId());

                    //provide error, no fishable zone or area should be 0
                    if (!zone_skill)
                        sLog.outLog(LOG_DB_ERR, "Fishable areaId %u are not properly defined in `skill_fishing_base_level`.",subzone);

                    int32 skill = player->GetSkillValue(SKILL_FISHING);
                    int32 chance = skill - zone_skill + 5;
                    int32 roll = irand(1,100);

                    DEBUG_LOG("Fishing check (skill: %i zone min skill: %i chance %i roll: %i",skill,zone_skill,chance,roll);

                    if (skill >= zone_skill && chance >= roll)
                    {
                        // prevent removing GO at spell cancel
                        player->RemoveGameObject(this,false);
                        SetOwnerGUID(player->GetGUID());
                        m_respawnTime = time(NULL) + 300;

                        //fish catched
                        player->UpdateFishingSkill();

                        //TODO: find reasonable value for fishing hole search
                        GameObject* ok = LookupFishingHoleAround(20.0f + CONTACT_DISTANCE);
                        if (ok)
                        {
                            player->SendLoot(ok->GetGUID(),LOOT_FISHINGHOLE);
                            SetLootState(GO_JUST_DEACTIVATED);
                        }
                        else
                            player->SendLoot(GetGUID(),LOOT_FISHING);
                    }
                    else
                    {
                        // fish escaped, can be deleted now
                        SetLootState(GO_JUST_DEACTIVATED);

                        WorldPacket data(SMSG_FISH_ESCAPED, 0);
                        player->SendPacketToSelf(&data);
                    }
                    break;
                }
            case GO_JUST_DEACTIVATED:                   // nothing to do, will be deleted at next update
                break;
            default:
                {
                    SetLootState(GO_JUST_DEACTIVATED);

                    WorldPacket data(SMSG_FISH_NOT_HOOKED, 0);
                    player->SendPacketToSelf(&data);
                    break;
                }
            }

            if (player->m_currentSpells[CURRENT_CHANNELED_SPELL])
            {
                player->m_currentSpells[CURRENT_CHANNELED_SPELL]->SendChannelUpdate(0);
                player->m_currentSpells[CURRENT_CHANNELED_SPELL]->finish();
            }
        }
        break;
        case GAMEOBJECT_TYPE_SUMMONING_RITUAL:              // 18
        {
            if (!pPlayer)
                return;

            if (pPlayer->isInCombat())
                return;

            Unit* owner = GetOwner();
            GameObjectInfo const* info = GetGOInfo();

            if(owner)
            {
                if (owner->GetTypeId()!=TYPEID_PLAYER)
                    return;

                spellCaster = owner;
                // accept only use by player from same raid/group for caster except caster itself
                if (((Player*)owner)==pPlayer || (info->summoningRitual.castersGrouped && !((Player*)owner)->IsInSameRaidWith(pPlayer)))
                    return;
            }

            m_lootState = GO_ACTIVATED;

            AddUniqueUse(pPlayer);
            if (info->summoningRitual.animSpell)
                pPlayer->CastSpell(pPlayer, info->summoningRitual.animSpell, false);
            else
            {
                if (m_spellId == 29893)
                    pPlayer->CastSpell(pPlayer, 43897, false);
                else
                    pPlayer->CastSpell(pPlayer, 32783, false);
            }

            if(m_unique_users.size() == GetGOInfo()->summoningRitual.reqParticipants)
            {
                SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                Player* target = Player::GetPlayer(m_target);
                if(!target) target = pPlayer;
                spellCaster->CastSpell(target, info->summoningRitual.spellId, true);

                if(info->summoningRitual.casterTargetSpell > 1)
                    spellCaster->CastSpell(pPlayer, info->summoningRitual.casterTargetSpell, true);
            }

            return;
        }
        case GAMEOBJECT_TYPE_SPELLCASTER:                   // 22
        {
            SetUInt32Value(GAMEOBJECT_FLAGS, 2);

            GameObjectInfo const* info = GetGOInfo();
            if (!info)
                return;

            Unit* caster = GetOwner();
            if (info->spellcaster.partyOnly)
            {
                if (!caster || caster->GetTypeId()!=TYPEID_PLAYER)
                    return;

                if (user->GetTypeId()!=TYPEID_PLAYER || !((Player*)user)->IsInSameRaidWith((Player*)caster))
                    return;
            }

            spellId = info->spellcaster.spellId;

            if(info->spellcaster.charges && m_usetimes >= info->spellcaster.charges)
                m_lootState = GO_JUST_DEACTIVATED;
            break;
        }
        case GAMEOBJECT_TYPE_MEETINGSTONE:                  // 23
        {
            GameObjectInfo const* info = GetGOInfo();

            if (user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            Player* targetPlayer = ObjectAccessor::FindPlayer(player->GetSelection());

            // accept only use by player from same raid/group for caster except caster itself
            if (!targetPlayer || targetPlayer == player || !targetPlayer->IsInSameRaidWith(player))
                return;

            //required lvl checks!
            uint8 level = player->getLevel();
            if (level < info->meetingstone.minLevel || level > info->meetingstone.maxLevel)
                return;
            level = targetPlayer->getLevel();
            if (level < info->meetingstone.minLevel || level > info->meetingstone.maxLevel)
                return;

            spellId = 23598;

            break;
        }

        case GAMEOBJECT_TYPE_FLAGSTAND:                     // 24
        {
            if (user->GetTypeId() != TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            if (player->isAllowUseBattleGroundObject())
            {
                // in battleground check
                BattleGround *bg = player->GetBattleGround();
                if (!bg)
                    return;

                 bg->EventPlayerClickedOnFlag(player, this);
                 return;    //we don;t need to delete flag ... it is despawned!
            }
            break;
        }
        case GAMEOBJECT_TYPE_FLAGDROP:                      // 26
        {
            if (user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            if (player->isAllowUseBattleGroundObject())
            {
                // in battleground check
                BattleGround *bg = player->GetBattleGround();
                if (!bg)
                    return;
                // BG flag dropped
                // WS:
                // 179785 - Silverwing Flag
                // 179786 - Warsong Flag
                // EotS:
                // 184142 - Netherstorm Flag
                GameObjectInfo const* info = GetGOInfo();
                if (info)
                {
                    switch (info->id)
                    {
                        case 179785:                        // Silverwing Flag
                            // check if it's correct bg
                            if (bg->GetTypeID() == BATTLEGROUND_WS)
                                bg->EventPlayerClickedOnFlag(player, this);
                            break;
                        case 179786:                        // Warsong Flag
                            if (bg->GetTypeID() == BATTLEGROUND_WS)
                                bg->EventPlayerClickedOnFlag(player, this);
                            break;
                        case 184142:                        // Netherstorm Flag
                            if (bg->GetTypeID() == BATTLEGROUND_EY)
                                bg->EventPlayerClickedOnFlag(player, this);
                            break;
                    }
                }
                //this cause to call return, all flags must be deleted here!!
                spellId = 0;
                Delete();
            }
            break;
        }
        default:
            sLog.outDebug("Unknown Object Type %u", GetGoType());
            break;
    }

    if (!spellId)
        return;

    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);
    if (!spellInfo)
    {
        if (user->GetTypeId() != TYPEID_PLAYER || sOutdoorPvPMgr.HandleCustomSpell((Player*)user,spellId,this))
            return;

        HandleNonDbcSpell(spellId, (Player*)user);
        return;
    }

    Spell *spell = new Spell(spellCaster, spellInfo, false, user->GetGUID());

    // Only take charges from GAMEOBJECT_TYPE_SPELLCASTER if cast was successful
    if (GetGoType() == GAMEOBJECT_TYPE_SPELLCASTER)
    {
        uint8 failResult = spell->CheckCast(true);
        if (!failResult)
            AddUse();
    }

    // spell target is user of GO
    SpellCastTargets targets;
    targets.setUnitTarget(user);

    spell->prepare(&targets);
}

void GameObject::CastSpell(Unit* target, uint32 spell)
{
    //summon world trigger
    Creature *trigger = SummonTrigger(GetPositionX(), GetPositionY(), GetPositionZ(), 0, 1);
    if (!trigger) return;

    trigger->SetVisibility(VISIBILITY_OFF); //should this be true?

    if(spell == 7353) // cozy fire, TODO: find general rule?
    {
        if (Unit *owner = GetOwner())
            trigger->setFaction(owner->getFaction());
        else
            trigger->setFaction(14);

        trigger->CastSpell(target, spell, true); // no orginal caster should prevent 'on spell cast' triggering
        return;
    }
    // Shadow sight remove stealth
    if (spell == 34709)
        target->RemoveSpellsCausingAura(SPELL_AURA_MOD_STEALTH);

    if (target)
    {
        const SpellEntry* spellInfo = sSpellStore.LookupEntry(spell);
        if (SpellMgr::isSpellBreakStealth(spellInfo))
            target->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CAST);
    }

    if (Unit *owner = GetOwner())
    {
        trigger->setFaction(owner->getFaction());
        trigger->CastSpell(target, spell, true, 0, 0, owner->GetGUID());
    }
    else
    {
        trigger->setFaction(14);
        trigger->CastSpell(target, spell, true, 0, 0, target != nullptr ? target->GetGUID() : NULL);
    }
    //trigger->setDeathState(JUST_DIED);
    //trigger->RemoveCorpse();
}

void GameObject::CastSpell(GameObject* target, uint32 spell)
{
    //summon world trigger
    Creature *trigger = SummonTrigger(GetPositionX(), GetPositionY(), GetPositionZ(), 0, 1);
    if (!trigger) return;

    trigger->SetVisibility(VISIBILITY_OFF); //should this be true?
    if (Unit *owner = GetOwner())
    {
        trigger->setFaction(owner->getFaction());
        trigger->CastSpell(target, spell, true, 0, 0, owner->GetGUID());
    }
    else
    {
        trigger->setFaction(14);
        trigger->CastSpell(target, spell, true, 0, 0, target != nullptr ? target->GetGUID() : 0);
    }
}

// overwrite WorldObject function for proper name localization
const char* GameObject::GetNameForLocaleIdx(int32 loc_idx) const
{
    if (loc_idx >= 0)
    {
        GameObjectLocale const *cl = sObjectMgr.GetGameObjectLocale(GetEntry());
        if (cl)
        {
            if (cl->Name.size() > loc_idx && !cl->Name[loc_idx].empty())
                return cl->Name[loc_idx].c_str();
        }
    }

    return GetName();
}

void GameObject::UpdateRotationFields(float rotation2 /*=0.0f*/, float rotation3 /*=0.0f*/)
{
    SetFloatValue(GAMEOBJECT_FACING, GetOrientation());

    if (rotation2==0.0f && rotation3==0.0f)
    {
        rotation2 = sin(GetOrientation()/2);
        rotation3 = cos(GetOrientation()/2);
    }

    SetFloatValue(GAMEOBJECT_ROTATION+2, rotation2);
    SetFloatValue(GAMEOBJECT_ROTATION+3, rotation3);
}

float GameObject::GetObjectBoundingRadius() const
{
    //FIXME:
    // 1. This is clearly hack way because GameObjectDisplayInfoEntry have 6 floats related to GO sizes, but better that use DEFAULT_WORLD_OBJECT_SIZE
    // 2. In some cases this must be only interactive size, not GO size, current way can affect creature target point auto-selection in strange ways for big underground/virtual GOs
    if (GameObjectDisplayInfoEntry const* dispEntry = sGameObjectDisplayInfoStore.LookupEntry(GetGOInfo()->displayId))
        return fabs(dispEntry->minX) * GetGOInfo()->size;

    return DEFAULT_WORLD_OBJECT_SIZE;
}

void GameObject::HandleNonDbcSpell(uint32 spellId, Player* pUser)
{
    switch(spellId)
    {
        case 37639: // Nether Drake Egg
        case 37264: // Power Converter
        {
            uint32 entry = spellId == 37639 ? 20021 : 21729;

            float x, y, z;
            pUser->GetNearPoint(x, y, z, 0.0f, 3.0f, frand(0, 2*M_PI));
            if (Creature *pSummon = pUser->SummonCreature(entry, x, y, z, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000))
                pSummon->AI()->AttackStart(pUser);

            break;
        }

        default:
            sLog.outDebug("Gameobject: %s, %u type: %u. casted non-handled and non-existing spell: %u", GetName(), GetEntry(), GetGoType(), spellId);
            break;
    }
}

float GameObject::GetDeterminativeSize() const
{
    if (!IsInWorld())
        return 0.0f;

    GameObjectDisplayInfoEntry const *info = sGameObjectDisplayInfoStore.LookupEntry(GetUInt32Value(GAMEOBJECT_DISPLAYID));
    if (!info)
        return 0.0f;

    float dx = info->maxX - info->minX;
    float dy = info->maxY - info->minY;
    float dz = info->maxZ - info->minZ;
    float _size = sqrt(dx*dx + dy*dy +dz*dz);

    return _size;
}
