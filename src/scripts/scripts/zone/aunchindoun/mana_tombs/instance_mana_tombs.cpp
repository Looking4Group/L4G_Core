#include "precompiled.h"
#include "def_mana_tombs.h"

#define ENCOUNTERS 4

struct instance_mana_tombs : public ScriptedInstance
{
    instance_mana_tombs(Map *map) : ScriptedInstance(map) {Initialize();};

    uint32 Encounter[ENCOUNTERS];

    void Initialize()
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounter[i] = NOT_STARTED;
    }

    bool IsEncounterInProgress() const
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            if(Encounter[i] == IN_PROGRESS) return true;

        return false;
    }

    void OnObjectCreate(GameObject *go)
    {
        switch(go->GetEntry())
        {
            case 185522:
                if(GetData(DATA_YOREVENT) == DONE)
                    go->Delete();
                break;
        }
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
            case DATA_YOREVENT:
                if(Encounter[0] != DONE)
                    Encounter[0] = data;
                break;
            case DATA_PANDEMONIUSEVENT:
                if(Encounter[1] != DONE)
                    Encounter[1] = data;
                break;
            case DATA_NEXUSPRINCEEVENT:
                if(Encounter[2] != DONE)
                    Encounter[2] = data;
                break;
            case DATA_SHAHEENEVENT:
                if(Encounter[3] != DONE)
                    Encounter[3] = data;
                break;
        }

        if (data == DONE)
            SaveToDB();
        
    }

    uint32 GetData(uint32 type)
    {
        switch( type )
        {
            case DATA_YOREVENT:         return Encounter[0];
            case DATA_PANDEMONIUSEVENT: return Encounter[1];
            case DATA_NEXUSPRINCEEVENT: return Encounter[2];
            case DATA_SHAHEENEVENT:     return Encounter[3];
                        
        }
        return false;
    }

   std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << Encounter[0] << " "
                << Encounter[1] << " "
                << Encounter[2] << " "
                << Encounter[3];

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
        loadStream >> Encounter[0] >> Encounter[1] >> Encounter[2];

        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounter[i] == IN_PROGRESS)
                Encounter[i] = NOT_STARTED;

        OUT_LOAD_INST_DATA_COMPLETE;
    }

};

InstanceData* GetInstanceData_instance_mana_tombs(Map* map)
{
    return new instance_mana_tombs(map);
}

void AddSC_instance_mana_tombs()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_mana_tombs";
    newscript->GetInstanceData = &GetInstanceData_instance_mana_tombs;
    newscript->RegisterSelf();
}

