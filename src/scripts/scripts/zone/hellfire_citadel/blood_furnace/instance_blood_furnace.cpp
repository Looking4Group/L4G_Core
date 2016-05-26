/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Instance_Blood_Furnace
SD%Complete: 95
SDComment:
SDCategory: Hellfire Citadel, Blood Furnace
EndScriptData */

#include "precompiled.h"
#include "def_blood_furnace.h"

#define ENCOUNTERS    3

enum Doors
{
    NOT_OPENED    = 0,
    WAIT_FOR_OPEN = 1,
    OPENED        = 2
};

struct instance_blood_furnace : public ScriptedInstance
{
    instance_blood_furnace(Map *map) : ScriptedInstance(map) {Initialize();};

    uint32 Encounter[ENCOUNTERS];

    uint64 Sewer1GUID;
    uint64 Sewer2GUID;
    uint64 BroggokDoor1GUID;
    uint64 BroggokDoor2GUID;
    uint64 MakerDoor1GUID;
    uint64 MakerDoor2GUID;
    uint64 MakerGUID;
    uint64 BroggokGUID;
    uint64 KelidanGUID;

    uint64 CellDoor[4];

    Doors door;

    void Initialize()
    {
        Sewer1GUID = 0;
        Sewer2GUID = 0;
        MakerDoor1GUID = 0;
        MakerDoor2GUID = 0;
        BroggokDoor1GUID = 0;
        BroggokDoor2GUID = 0;
        MakerGUID = 0;
        BroggokGUID = 0;
        KelidanGUID = 0;

        for(int i = 0; i < 4; i++)
            CellDoor[i] = 0;

        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounter[i] = NOT_STARTED;

        door = NOT_OPENED;
    }

    void OnPlayerEnter(Player* player)
    {
        if (door == NOT_OPENED)
            door = WAIT_FOR_OPEN;
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        switch(creature->GetEntry())
        {
            case 17381: MakerGUID = creature->GetGUID(); break;
            case 17380: BroggokGUID = creature->GetGUID(); break;
            case 17377: KelidanGUID = creature->GetGUID(); break;
        }
    }

    void OnObjectCreate(GameObject *go)
    {
        switch (go->GetEntry())
        {
            case 181811: MakerDoor1GUID = go->GetGUID(); break;
            case 181812: MakerDoor2GUID = go->GetGUID(); break;
            case 181821: CellDoor[0] = go->GetGUID(); break;
            case 181820: CellDoor[1] = go->GetGUID(); break;
            case 181818: CellDoor[2] = go->GetGUID(); break;
            case 181817: CellDoor[3] = go->GetGUID(); break;
            case 181822: BroggokDoor1GUID = go->GetGUID(); break;
            case 181819: BroggokDoor2GUID = go->GetGUID(); break;
            case 181823: Sewer1GUID = go->GetGUID(); break;
            case 181766: Sewer2GUID = go->GetGUID(); break;
        }
    }

    Player* GetPlayerInMap()
    {
        Map::PlayerList const& players = instance->GetPlayers();

        if (!players.isEmpty())
        {
            for(Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* plr = itr->getSource())
                    return plr;
            }
        }

        debug_log("TSCR: Instance Blood Furnace: GetPlayerInMap, but PlayerList is empty!");
        return NULL;
    }

    void HandleGameObject(uint64 guid, uint32 state)
    {
        Player *player = GetPlayerInMap();

        if (!player || !guid)
        {
            debug_log("TSCR: Blood Furnace: HandleGameObject fail");
            return;
        }

        if (GameObject *go = GameObject::GetGameObject(*player, guid))
            go->SetGoState(GOState(state));
    }

    void SetData(uint32 type, uint32 data)
    {
        switch (type)
        {
            case DATA_MAKEREVENT:
                if (data == DONE)
                    HandleGameObject(MakerDoor2GUID, 0);

                if (Encounter[0] != DONE)
                    Encounter[0] = data;
                break;
            case DATA_BROGGOKEVENT:
                if (data == DONE)
                    HandleGameObject(BroggokDoor2GUID, 0);

                if (Encounter[1] != DONE)
                    Encounter[1] = data;
                break;
            case DATA_KELIDANEVENT:
                if (data == DONE)
                {
                    HandleGameObject(Sewer1GUID, 0);
                    HandleGameObject(Sewer2GUID, 0);
                }

                if (Encounter[2] != DONE)
                    Encounter[2] = data;
                break;

            if (data == DONE)
            {
                SaveToDB();
                OUT_SAVE_INST_DATA_COMPLETE;
            }
        }
    }

    uint32 GetData(uint32 type)
    {
        switch (type)
        {
            case DATA_MAKEREVENT:
                return Encounter[0];
            case DATA_BROGGOKEVENT:
                return Encounter[1];
            case DATA_KELIDANEVENT:
                return Encounter[2];
        }
        return 0;
    }

    uint64 GetData64(uint32 type)
    {
        switch (type)
        {
            case 1:
            case 2:
            case 3:
            case 4:
                return CellDoor[type-1];
            case 5:
                return BroggokDoor2GUID;
            default:
                return 0;
        }
    }

    void Update(uint32 diff)
    {
        if (door == WAIT_FOR_OPEN)
        {
            if (Creature* Maker = instance->GetCreature(MakerGUID))
            {
                HandleGameObject(MakerDoor1GUID, 0);

                if (Maker && !Maker->isAlive())
                    HandleGameObject(MakerDoor2GUID, 0);
            }

            if (Creature* Broggok = instance->GetCreature(BroggokGUID))
            {
                HandleGameObject(BroggokDoor1GUID, 0);

                if (Broggok && !Broggok->isAlive())
                    HandleGameObject(BroggokDoor2GUID, 0);
            }

            if (Creature* Kelidan = instance->GetCreature(KelidanGUID))
            {
                if (Kelidan && !Kelidan->isAlive())
                {
                    HandleGameObject(Sewer1GUID, 0);
                    HandleGameObject(Sewer2GUID, 0);
                }
            }

            door = OPENED;
        }
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << Encounter[0] << " ";
        stream << Encounter[1] << " ";
        stream << Encounter[2] ;

        OUT_SAVE_INST_DATA_COMPLETE;

        return stream.str();
    }

    void Load(const char* in)
    {
        if(!in)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }

        OUT_LOAD_INST_DATA(in);

        std::istringstream stream(in);
        stream  >> Encounter[0] >> Encounter[1] >> Encounter[2];

        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounter[i] == IN_PROGRESS)
                Encounter[i] = NOT_STARTED;

        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_blood_furnace(Map* map)
{
    return new instance_blood_furnace(map);
}

void AddSC_instance_blood_furnace()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_blood_furnace";
    newscript->GetInstanceData = &GetInstanceData_instance_blood_furnace;
    newscript->RegisterSelf();
}

