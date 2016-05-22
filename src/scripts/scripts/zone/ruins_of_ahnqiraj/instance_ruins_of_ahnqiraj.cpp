/* ScriptData
SDName: Instance_Ruins_of_Ahnqiraj
SD%Complete: 0
SDComment: Place holder
SDCategory: Ruins of Ahn'Qiraj
EndScriptData */

#include "precompiled.h"
#include "def_ruins_of_ahnqiraj.h"

#define ENCOUNTERS 6

/* AQ20 encounters:
0 - Kurinaxx
1 - General Rajaxx
2 - Moam
3 - Buru the Gorger
4 - Ayamiss the Hunter
5 - Ossirian the unscarred

Map: 509
*/

struct instance_ruins_of_ahnqiraj : public ScriptedInstance
{
    instance_ruins_of_ahnqiraj(Map *map) : ScriptedInstance(map) {Initialize();};

    uint32 Encounters[ENCOUNTERS];

    void Initialize()
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounters[i] = NOT_STARTED;
    }

    bool IsEncounterInProgress() const
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            if(Encounters[i] == IN_PROGRESS) return true;

        return false;
    }

    uint32 GetEncounterForEntry(uint32 entry)
    {
        switch(entry)
        {
            case 15348:
                return DATA_KURINNAXX;
            case 15341:
                return DATA_GENERAL_RAJAXX;
            case 15340:
                return DATA_MOAM;
            case 15370:
                return DATA_BURU_THE_GORGER;
            case 15369:
                return DATA_AYAMISS_THE_HUNTER;
            case 15339:
                return DATA_OSSIRIAN_THE_UNSCARRED;
            default:
                return 0;
        }
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        switch(creature_entry)
        {
            case 0:
                break;
            default:
                break;
        }

        HandleInitCreatureState(creature);
    }

    void OnObjectCreate(GameObject* go){}

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
            case DATA_KURINNAXX:
                if(Encounters[0] != DONE)
                    Encounters[0] = data;
                break;
            case DATA_GENERAL_RAJAXX:
                if(Encounters[1] != DONE)
                    Encounters[1] = data;
                break;
            case DATA_MOAM:
                if(Encounters[2] != DONE)
                    Encounters[2] = data;
                break;
            case DATA_BURU_THE_GORGER:
                if(Encounters[3] != DONE)
                    Encounters[3] = data;
                break;
            case DATA_AYAMISS_THE_HUNTER:
                if(Encounters[4] != DONE)
                    Encounters[4] = data;
                break;
            case DATA_OSSIRIAN_THE_UNSCARRED:
                if(Encounters[5] != DONE)
                    Encounters[5] = data;
                break;
        }

        if(data == DONE)
            SaveToDB();
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case DATA_KURINNAXX:
                return Encounters[0];
            case DATA_GENERAL_RAJAXX:
                return Encounters[1];
            case DATA_MOAM:
                return Encounters[2];
            case DATA_BURU_THE_GORGER:
                return Encounters[3];
            case DATA_AYAMISS_THE_HUNTER:
                return Encounters[4];
            case DATA_OSSIRIAN_THE_UNSCARRED:
                return Encounters[5];
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
        stream << Encounters[5];

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
        stream >> Encounters[0] >> Encounters[1] >> Encounters[2]
             >> Encounters[3] >> Encounters[4] >> Encounters[5];
        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if(Encounters[i] == IN_PROGRESS)                // Do not load an encounter as "In Progress" - reset it instead.
                Encounters[i] = NOT_STARTED;
        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_ruins_of_ahnqiraj(Map* map)
{
    return new instance_ruins_of_ahnqiraj(map);
}

void AddSC_instance_ruins_of_ahnqiraj()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_ruins_of_ahnqiraj";
    newscript->GetInstanceData = &GetInstanceData_instance_ruins_of_ahnqiraj;
    newscript->RegisterSelf();
}

