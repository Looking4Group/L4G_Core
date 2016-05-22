/* Copyright (C) 2008 - 2010 HelgroundDev <http://gamefreedom.pl/>
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
*/

/* ScriptData
SDName: Instance_Slave_Pens
SD%Complete: 100
SDComment: Instance Data with save to database for Ahune, Slave Pens
SDCategory: Slave Pens
EndScriptData */

#include "precompiled.h"

#define ENCOUNTERS          1

#define DATA_AHUNEEVENT     1

struct instance_slave_pens : public ScriptedInstance
{
    instance_slave_pens(Map* map) : ScriptedInstance(map)
    {
        Heroic = map->IsHeroic();
        Initialize();
    };

    uint64 AhuneGUID;
    bool Heroic;

    uint32 Encounters[ENCOUNTERS];

    void Initialize()
    {
        AhuneGUID = 0;

        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            Encounters[i] = NOT_STARTED;
    }

    bool IsEncounterInProgress() const
    {
        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if(Encounters[i] == IN_PROGRESS)
                return true;

        return false;
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
    }

    void OnObjectCreate(GameObject* go) //placeholder for GO
    {/*
        switch(go->GetEntry())
        {
        default:
            break;
        }*/
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        if(Heroic)
        {
            switch(creature_entry)
            {
                case 25740: AhuneGUID = creature->GetGUID();            break;
            }
        }
    }

    uint64 GetData64(uint32 identifier)
    {
        if(Heroic)
        {
            switch(identifier)
            {
                case DATA_AHUNEEVENT:           return AhuneGUID;
            }
        }
        return 0;
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
        case DATA_AHUNEEVENT:
            if(Encounters[0] != DONE)
                Encounters[0] = data;
            break;
        default:
            break;
        }

        if (Heroic && data == DONE)
            SaveToDB();
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
        case DATA_AHUNEEVENT:         return Encounters[0];
        }

        return 0;
    }

    std::string GetSaveData()
    {
       OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << Encounters[0];

        OUT_SAVE_INST_DATA_COMPLETE;

        return stream.str();
    }

    void Load(const char* in)
    {
        if (!in)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }

        OUT_LOAD_INST_DATA(in);

        std::istringstream loadStream(in);
        loadStream >> Encounters[0];

        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounters[i] == IN_PROGRESS)
                Encounters[i] = NOT_STARTED;

        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_slave_pens(Map* map)
{
    return new instance_slave_pens(map);
}

void AddSC_instance_slave_pens()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_slave_pens";
    newscript->GetInstanceData = &GetInstanceData_instance_slave_pens;
    newscript->RegisterSelf();
}
