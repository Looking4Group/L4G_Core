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
SDName: Instance_The_Eye
SD%Complete: 100
SDComment:
SDCategory: Tempest Keep, The Eye
EndScriptData */

#include "precompiled.h"
#include "def_the_eye.h"

#define ENCOUNTERS 4

/* The Eye encounters:
0 - Al' ar event
1 - Solarian Event 
2 - Void Reaver event
3 - Kael'thas event
*/

struct instance_the_eye : public ScriptedInstance
{
    instance_the_eye(Map *map) : ScriptedInstance(map) {Initialize();};

    uint64 ThaladredTheDarkener;
    uint64 LordSanguinar;
    uint64 GrandAstromancerCapernian;
    uint64 MasterEngineerTelonicus;
    uint64 Kaelthas;
    std::set<uint64> DoorGUID;
    std::set<uint64> ExplodeObjectGUID;
    uint64 Astromancer;
    uint64 Alar;
    std::list<uint64> AstromancerTrash;
    std::list<uint64> VoidTrash;

    uint32 Encounters[ENCOUNTERS];

    void Initialize()
    {
        ThaladredTheDarkener = 0;
        LordSanguinar = 0;
        GrandAstromancerCapernian = 0;
        MasterEngineerTelonicus = 0;
        Kaelthas = 0;
        DoorGUID.clear();
        ExplodeObjectGUID.clear();
        Astromancer = 0;
        Alar = 0;
        AstromancerTrash.clear();
        VoidTrash.clear();

        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            Encounters[i] = NOT_STARTED;
    }

    bool IsEncounterInProgress() const
    {
        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounters[i] != DONE && Encounters[i] != NOT_STARTED)
                return true;

        return false;
    }

    void HandleKaelDoors() {        
        uint32 kaelData = GetData(DATA_KAELTHASEVENT);        
        if (kaelData == NOT_STARTED || kaelData == DONE)
        {
            //open Kael'thas doors
            for (std::set<uint64>::iterator i = DoorGUID.begin(); i != DoorGUID.end(); ++i)
            {
                if (GameObject *Door = instance->GetGameObject(*i))
                {
                    Door->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }
        if((GetData(DATA_ALAREVENT) != DONE || GetData(DATA_HIGHASTROMANCERSOLARIANEVENT) != DONE || GetData(DATA_VOIDREAVEREVENT) != DONE) || kaelData == IN_PROGRESS || kaelData == SPECIAL || kaelData == TO_BE_DECIDED)
        {
            //close Kael'thas doors
            for (std::set<uint64>::iterator i = DoorGUID.begin(); i != DoorGUID.end(); ++i)
            {
                if (GameObject *Door = instance->GetGameObject(*i))
                {
                    Door->SetGoState(GO_STATE_READY);
                }
            }
        }
    }

    uint32 GetEncounterForEntry(uint32 entry)
    {
        switch(entry)
        {
            case 19622:
                return DATA_KAELTHASEVENT;
            case 18805:
                return DATA_HIGHASTROMANCERSOLARIANEVENT;
            case 19514:
                return DATA_ALAREVENT;
            case 19516:
                return DATA_VOIDREAVEREVENT;
            default:
                return 0;
        }
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        switch(creature_entry)
        {
            case 20064:
                ThaladredTheDarkener = creature->GetGUID();
                break;
            case 20063:
                MasterEngineerTelonicus = creature->GetGUID();
                break;
            case 20062:
                GrandAstromancerCapernian = creature->GetGUID();
                break;
            case 20060:
                LordSanguinar = creature->GetGUID();
                break;
            case 19622:
                Kaelthas = creature->GetGUID();
                break;
            case 18805:
                Astromancer = creature->GetGUID();
                break;
            case 19514:
                Alar = creature->GetGUID();
                break;
            case 20031:
            case 20036:
            case 20043:
            case 20044:
            case 20045:
                if (creature->GetDistance(433,-373,18)<150)
                    AstromancerTrash.push_front(creature->GetGUID());
                break;
            case 20040:
            case 20041:
            case 20042:
            case 20052:
                if (creature->GetDistance(425,404,15)<150)
                    VoidTrash.push_front(creature->GetGUID());
                break;
        }

        HandleInitCreatureState(creature);
    }

    void OnObjectCreate(GameObject *go)
    {
        switch (go->GetEntry())
        {
            case 184324:
                DoorGUID.insert(go->GetGUID());
                break;
            case 184069: // main window
            case 184596: // statues
            case 184597:
                ExplodeObjectGUID.insert(go->GetGUID());
                break;
        }
    }

    uint64 GetData64(uint32 identifier)
    {
        switch (identifier)
        {
            case DATA_THALADREDTHEDARKENER:         return ThaladredTheDarkener;
            case DATA_LORDSANGUINAR:                return LordSanguinar;
            case DATA_GRANDASTROMANCERCAPERNIAN:    return GrandAstromancerCapernian;
            case DATA_MASTERENGINEERTELONICUS:      return MasterEngineerTelonicus;
            case DATA_KAELTHAS:                     return Kaelthas;
            case DATA_ASTROMANCER:                  return Astromancer;
            case DATA_ALAR:                         return Alar;
        }
        return 0;
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
            case DATA_ALAREVENT:
                if (Encounters[0] != DONE)
                {
                    Encounters[0] = data;
                }
                HandleKaelDoors();
                break;
            case DATA_HIGHASTROMANCERSOLARIANEVENT:
                if(Encounters[1] != DONE)
                {
                    Encounters[1] = data;
                    if (data == IN_PROGRESS && !AstromancerTrash.empty())
                        for(std::list<uint64>::iterator i = AstromancerTrash.begin(); i != AstromancerTrash.end(); ++i)
                        {
                            Creature* trashmob = GetCreature(*i);
                            if (trashmob && trashmob->isAlive())
                            {
                                trashmob->AI()->DoZoneInCombat();
                            }
                        }
                }
                HandleKaelDoors();
                break;
            case DATA_VOIDREAVEREVENT:
                if(Encounters[2] != DONE)
                {
                    Encounters[2] = data;
                    if (data == IN_PROGRESS && !VoidTrash.empty())
                        for(std::list<uint64>::iterator i = VoidTrash.begin(); i != VoidTrash.end(); ++i)
                        {
                            Creature* trashmob = GetCreature(*i);
                            if (trashmob && trashmob->isAlive())
                            {
                                trashmob->AI()->DoZoneInCombat();
                            }
                        }
                }
                HandleKaelDoors();
                break;
            case DATA_KAELTHASEVENT:     
                if (Encounters[3] != DONE)
                {
                    Encounters[3] = data;
                }
                HandleKaelDoors();                                
                break;
            case DATA_EXPLODE:
                // true - explode / false - reset
                for(std::set<uint64>::iterator i = ExplodeObjectGUID.begin(); i != ExplodeObjectGUID.end(); ++i)
                {
                    if (GameObject *ExplodeObject = instance->GetGameObject(*i))
                    {
                        ExplodeObject->SetGoState(GOState(!data));
                    }
                }            
        }                       

        if(data == DONE)
            SaveToDB();
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case DATA_ALAREVENT:                    return Encounters[0];
            case DATA_HIGHASTROMANCERSOLARIANEVENT: return Encounters[1];
            case DATA_VOIDREAVEREVENT:              return Encounters[2];
            case DATA_KAELTHASEVENT:                return Encounters[3];
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
        stream << Encounters[3];

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
        stream >> Encounters[0] >> Encounters[1] >> Encounters[2] >> Encounters[3];
        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if(Encounters[i] == IN_PROGRESS)                // Do not load an encounter as "In Progress" - reset it instead.
                Encounters[i] = NOT_STARTED;
        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_the_eye(Map* map)
{
    return new instance_the_eye(map);
}

void AddSC_instance_the_eye()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_the_eye";
    newscript->GetInstanceData = &GetInstanceData_instance_the_eye;
    newscript->RegisterSelf();
}

