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

#include <algorithm>

#include "InstanceData.h"
#include "Database/DatabaseEnv.h"
#include "Map.h"
#include "GameObject.h"
#include "Creature.h"

void InstanceData::SaveToDB()
{
    std::string data = GetSaveData();
    if (data.empty())
        return;

    static SqlStatementID updateInstance;

    SqlStatement stmt = RealmDataDatabase.CreateStatement(updateInstance, "UPDATE instance SET data = ? WHERE id = ?");
    stmt.addString(data);
    stmt.addUInt32(instance->GetInstanceId());
    stmt.Execute();
}

void InstanceData::HandleGameObject(uint64 GUID, bool open, GameObject *go)
{
    if (!go)
        go = instance->GetGameObject(GUID);

    if (go)
        go->SetGoState(open ? GO_STATE_ACTIVE : GO_STATE_READY);
    else
        debug_log("TSCR: InstanceData: HandleGameObject failed");
}

bool InstanceData::IsEncounterInProgress() const
{
    for (std::vector<BossInfo>::const_iterator itr = bosses.begin(); itr != bosses.end(); ++itr)
        if (itr->state == IN_PROGRESS)
            return true;

    return false;
}

//This will be removed in the future, just compitiable with Mangos
void InstanceData::OnCreatureCreate(Creature *creature, bool add)
{
   OnCreatureCreate(creature, creature->GetEntry());
}

void InstanceData::LoadDoorData(const DoorData *data)
{
    while (data->entry)
    {
        if (data->bossId < bosses.size())
            doors.insert(std::make_pair(data->entry, DoorInfo(&bosses[data->bossId], data->type)));

        ++data;
    }
    sLog.outDebug("InstanceData::LoadDoorData: %u doors loaded.", doors.size());
}

void InstanceData::UpdateDoorState(GameObject *door)
{
    DoorInfoMap::iterator lower = doors.lower_bound(door->GetEntry());
    DoorInfoMap::iterator upper = doors.upper_bound(door->GetEntry());
    if (lower == upper)
        return;

    bool open = true;
    for (DoorInfoMap::iterator itr = lower; itr != upper; ++itr)
    {
        if (itr->second.type == DOOR_TYPE_ROOM)
        {
            if (itr->second.bossInfo->state == IN_PROGRESS)
            {
                open = false;
                break;
            }
        }
        else if (itr->second.type == DOOR_TYPE_PASSAGE)
        {
            if (itr->second.bossInfo->state != DONE)
            {
                open = false;
                break;
            }
        }
    }

    door->SetGoState(open ? GO_STATE_ACTIVE : GO_STATE_READY);
}

void InstanceData::AddDoor(GameObject *door, bool add)
{
    DoorInfoMap::iterator lower = doors.lower_bound(door->GetEntry());
    DoorInfoMap::iterator upper = doors.upper_bound(door->GetEntry());
    if (lower == upper)
        return;

    for (DoorInfoMap::iterator itr = lower; itr != upper; ++itr)
    {
        if (add)
            itr->second.bossInfo->door[itr->second.type].insert(door);
        else
            itr->second.bossInfo->door[itr->second.type].erase(door);
    }

    if (add)
        UpdateDoorState(door);
}

bool InstanceData::SetBossState(uint32 id, EncounterState state)
{
    if (id < bosses.size())
    {
        BossInfo *bossInfo = &bosses[id];
        if (bossInfo->state == TO_BE_DECIDED) // loading
        {
            bossInfo->state = state;
            return false;
        }
        else
        {
            if (bossInfo->state == state)
                return false;
            bossInfo->state = state;
            SaveToDB();
        }

        for (uint32 type = 0; type < MAX_DOOR_TYPES; ++type)
            for (DoorSet::iterator i = bossInfo->door[type].begin(); i != bossInfo->door[type].end(); ++i)
                UpdateDoorState(*i);

        return true;
    }
    return false;
}

std::string InstanceData::LoadBossState(const char * data)
{
    if (!data) return NULL;
    std::istringstream loadStream(data);
    uint32 buff;
    uint32 bossId = 0;
    for (std::vector<BossInfo>::iterator i = bosses.begin(); i != bosses.end(); ++i, ++bossId)
    {
        loadStream >> buff;
        if (buff < TO_BE_DECIDED)
            SetBossState(bossId, (EncounterState)buff);
    }
    return loadStream.str();
}

std::string InstanceData::GetBossSaveData()
{
    std::ostringstream saveStream;
    for (std::vector<BossInfo>::iterator i = bosses.begin(); i != bosses.end(); ++i)
        saveStream << (uint32)i->state << " ";
    return saveStream.str();
}

void InstanceData::ResetEncounterInProgress()
{
    // this will only reset encounter state to NOT_STARTED, it won't evade creatures inside of map, better option is to override it in instance script
    Load(GetSaveData().c_str());
}

void InstanceData::HandleInitCreatureState(Creature * mob)
{
    if (mob == nullptr)
        return;

    const CreatureData *tmp = mob->GetLinkedRespawnCreatureData();
    if (!tmp)
        return;

    uint32 encounter = GetEncounterForEntry(tmp->id);

    if (encounter && mob->isAlive() && GetData(encounter) == DONE)
    {
        mob->setDeathState(JUST_DIED);
        mob->RemoveCorpse();
        return;
    }

    encounter = GetRequiredEncounterForEntry(tmp->id);

    if (encounter && mob->isAlive() && GetData(encounter) != DONE)
    {
        mob->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        requiredEncounterToMobs[encounter].push_back(mob->GetGUID());
    }
}

void InstanceData::HandleRequiredEncounter(uint32 encounter)
{
    if (GetData(encounter) != DONE)
        return;

    auto itr = requiredEncounterToMobs.find(encounter);
    if (itr != requiredEncounterToMobs.end())
    {
        std::vector<uint64> & tmpVec = itr->second;

        std::for_each(tmpVec.begin(), tmpVec.end(), [this] (uint64& var)
                                                    {
                                                        Creature * tmp = GetCreature(var);
                                                        if (tmp != nullptr)
                                                            tmp->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                                    });
    }
}
