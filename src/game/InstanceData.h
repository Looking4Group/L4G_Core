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

#ifndef LOOKING4GROUP_INSTANCE_DATA_H
#define LOOKING4GROUP_INSTANCE_DATA_H

#include <vector>

#include "ZoneScript.h"
//#include "GameObject.h"
#include "Map.h"


class Map;
class Unit;
class Player;
class GameObject;
class Creature;

enum EncounterState
{
    NOT_STARTED   = 0,
    IN_PROGRESS   = 1,
    FAIL          = 2,
    DONE          = 3,
    SPECIAL       = 4,
    TO_BE_DECIDED = 5,
};

typedef std::set<GameObject*> DoorSet;

enum DoorType
{
    DOOR_TYPE_ROOM = 0,
    DOOR_TYPE_PASSAGE,
    MAX_DOOR_TYPES,
};

struct BossInfo
{
    BossInfo() : state(TO_BE_DECIDED) {}
    EncounterState state;
    DoorSet door[MAX_DOOR_TYPES];
};

struct DoorInfo
{
    explicit DoorInfo(BossInfo *_bossInfo, DoorType _type)
        : bossInfo(_bossInfo), type(_type) {}
    BossInfo *bossInfo;
    DoorType type;
};

typedef std::multimap<uint32 /*entry*/, DoorInfo> DoorInfoMap;

struct DoorData
{
    uint32 entry, bossId;
    DoorType type;
};

class LOOKING4GROUP_IMPORT_EXPORT InstanceData : public ZoneScript
{
    public:

        explicit InstanceData(Map *map) : instance(map) {}
        virtual ~InstanceData() {}

        Map *instance;

        //On creation, NOT load.
        virtual void Initialize() {}

        //On load
        virtual void Load(const char * data) { LoadBossState(data); }

        //When save is needed, this function generates the data
        virtual std::string GetSaveData() { return GetBossSaveData(); }

        void SaveToDB();

        virtual void Update(uint32 /*diff*/) {}

        //Used by the map's CanEnter function.
        //This is to prevent players from entering during boss encounters.
        virtual bool IsEncounterInProgress() const;
        virtual void ResetEncounterInProgress();

        //Called when a player successfully enters the instance.
        virtual void OnPlayerEnter(Player *) {}

        //Called when a player deaths in the instance.
        virtual void OnPlayerDeath(Player *) {}

        //Called on creature death (after CreatureAI::JustDied)
        virtual void OnCreatureDeath(Creature *) {}

        //Called when a gameobject is created
        void OnGameObjectCreate(GameObject *go, bool add) { if (add) OnObjectCreate(go); }

        //called on creature creation
        void OnCreatureCreate(Creature *, bool add);

        //Handle open / close objects
        //use HandleGameObject(NULL,boolen,GO); in OnObjectCreate in instance scripts
        //use HandleGameObject(GUID,boolen,NULL); in any other script
        void HandleGameObject(uint64 GUID, bool open, GameObject *go = NULL);

        virtual bool SetBossState(uint32 id, EncounterState state);

        Creature *GetCreature(uint64 guid){ return instance->GetCreature(guid); }

        virtual uint32 GetEncounterForEntry(uint32 entry) { return 0; }
        virtual uint32 GetRequiredEncounterForEntry(uint32 entry) { return 0; }

        virtual void HandleInitCreatureState(Creature * mob);
        virtual void HandleRequiredEncounter(uint32 encounter);

    protected:
        void SetBossNumber(uint32 number) { bosses.resize(number); }
        void LoadDoorData(const DoorData *data);

        void AddDoor(GameObject *door, bool add);
        void UpdateDoorState(GameObject *door);

        std::string LoadBossState(const char * data);
        std::string GetBossSaveData();

        UNORDERED_MAP<uint32, std::vector<uint64> > requiredEncounterToMobs;

    private:
        std::vector<BossInfo> bosses;
        DoorInfoMap doors;


        virtual void OnObjectCreate(GameObject *) {}
        virtual void OnCreatureCreate(Creature *, uint32 entry) {}
};

#endif
