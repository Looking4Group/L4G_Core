/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Instance_Blackwing_Lair
SD%Complete: 0
SDComment:
SDCategory: Blackwing Lair
EndScriptData */

#include "precompiled.h"
#include "def_blackwing_lair.h"

#define ENCOUNTERS 8

/* Blackwing lair encounters:
0 - Razorgore the Untamed event
1 - Vaelastrasz the Corrupt Event
2 - Broodlord Lashlayer Event
3 - Firemaw Event
4 - Ebonroc Event
5 - Flamegor Event
6 - Chromaggus Event
7 - Nefarian Event
*/

struct instance_blackwing_lair : public ScriptedInstance
{
    instance_blackwing_lair(Map *map) : ScriptedInstance(map) {Initialize();};

    uint32 Encounters[ENCOUNTERS];

    void Initialize()
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounters[i] = NOT_STARTED;
    }

    bool IsEncounterInProgress() const
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            if(Encounters[i] != NOT_STARTED && Encounters[i] != DONE)
                return true;
        return false;
    }

    void OnObjectCreate(GameObject *go){}

    uint32 GetEncounterForEntry(uint32 entry)
    {
        switch(entry)
        {
            case 12435:
                return DATA_RAZORGORE_THE_UNTAMED_EVENT;
            case 13020:
                return DATA_VAELASTRASZ_THE_CORRUPT_EVENT;
            case 12017:
                return DATA_BROODLORD_LASHLAYER_EVENT;
            case 11983:
                return DATA_FIREMAW_EVENT;
            case 14601:
                return DATA_EBONROC_EVENT;
            case 11981:
                return DATA_FLAMEGOR_EVENT;
            case 14020:
                return DATA_CHROMAGGUS_EVENT;
            case 11583:
            case 10162:
                return DATA_NEFARIAN_EVENT;
            default:
                return 0;
        }
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        const CreatureData *tmp = creature->GetLinkedRespawnCreatureData();
        if (!tmp)
            return;

        if (GetEncounterForEntry(tmp->id) && creature->isAlive() && GetData(GetEncounterForEntry(tmp->id)) == DONE)
        {
            creature->setDeathState(JUST_DIED);
            creature->RemoveCorpse();
        }
    }

    void SetData64(uint32 type, uint64 data){}

    uint64 GetData64(uint32 identifier)
    {
        switch(identifier)
        {
            case 0:
                return 0;
            default:
                return 0;
        }
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
            case DATA_RAZORGORE_THE_UNTAMED_EVENT:
                if(Encounters[0] != DONE)
                    Encounters[0] = data;
                break;
            case DATA_VAELASTRASZ_THE_CORRUPT_EVENT:
                if(Encounters[1] != DONE)
                    Encounters[1] = data;
                break;
            case DATA_BROODLORD_LASHLAYER_EVENT:
                if(Encounters[2] != DONE)
                    Encounters[2] = data;
                break;
            case DATA_FIREMAW_EVENT:
                if(Encounters[3] != DONE)
                    Encounters[3] = data;
                break;
            case DATA_EBONROC_EVENT:
                if(Encounters[4] != DONE)
                    Encounters[4] = data;
                break;
            case DATA_FLAMEGOR_EVENT:
                if(Encounters[5] != DONE)
                    Encounters[5] = data;
                break;
            case DATA_CHROMAGGUS_EVENT:
                if(Encounters[6] != DONE)
                    Encounters[6] = data;
                break;
            case DATA_NEFARIAN_EVENT:
                if(Encounters[7] != DONE)
                    Encounters[7] = data;
                break;
        }

        if(data == DONE)
            SaveToDB();
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case DATA_RAZORGORE_THE_UNTAMED_EVENT:
                return Encounters[0];
            case DATA_VAELASTRASZ_THE_CORRUPT_EVENT:
                return Encounters[1];
            case DATA_BROODLORD_LASHLAYER_EVENT:
                return Encounters[2];
            case DATA_FIREMAW_EVENT:
                return Encounters[3];
            case DATA_EBONROC_EVENT:
                return Encounters[4];
            case DATA_FLAMEGOR_EVENT:
                return Encounters[5];
            case DATA_CHROMAGGUS_EVENT:
                return Encounters[6];
            case DATA_NEFARIAN_EVENT:
                return Encounters[7];
        }
        return 0;
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << Encounters[0] << " ";
        stream << Encounters[1] << " ";
        stream << Encounters[2] << " ";
        stream << Encounters[3] << " ";
        stream << Encounters[4] << " ";
        stream << Encounters[5] << " ";
        stream << Encounters[6] << " ";
        stream << Encounters[7];

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
        stream >> Encounters[0] >> Encounters[1] >> Encounters[2] >> Encounters[3]
        >> Encounters[4] >> Encounters[5] >> Encounters[6] >> Encounters[7];
        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if(Encounters[i] == IN_PROGRESS)                // Do not load an encounter as "In Progress" - reset it instead.
                Encounters[i] = NOT_STARTED;
        OUT_LOAD_INST_DATA_COMPLETE;
    }
    void Update (uint32 diff){}
};

InstanceData* GetInstanceData_instance_blackwing_lair(Map* map)
{
    return new instance_blackwing_lair(map);
}

void AddSC_instance_blackwing_lair()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "instance_blackwing_lair";
    newscript->GetInstanceData = &GetInstanceData_instance_blackwing_lair;
    newscript->RegisterSelf();
}

