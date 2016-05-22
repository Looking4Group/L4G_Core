/* ScriptData
SDName: instance_zul_farrak
SD%Complete: 70
SDComment: basicaly pyramid event, TODO: make captives fight together against mobs and players; proper implementation of end door
SDCategory: Zul'Farrak
EndScriptData */

#include "precompiled.h"
#include "def_zul_farrak.h"

#define ENCOUNTERS 2

float ZFWPs[10][3] = {
{1887.35,1263.67,41.48},
{1890.87,1263.86,41.41},
{1883.12,1263.76,41.59},
{1890.72,1268.39,41.47},
{1882.84,1267.99,41.73},
{1885.85,1202.20,8.88},
{1889.46,1204.23,8.88},
{1887.41,1208.92,8.88},
{1895.49,1204.23,8.88},
{1876.23,1207.52,8.88}};

float spawns[26][4] ={
{1902.83,    1223.41,    8.96,    3.95},
{1894.64,    1206.29,    8.87,    2.22},
{1874.45,    1204.44,    8.87,    0.88},
{1874.18,    1221.24,    9.21,    0.84},
{1879.02,    1223.06,    9.12,    5.91},
{1882.07,    1225.70,    9.32,    5.69},
{1886.97,    1225.86,    9.85,    5.79},
{1892.28,    1225.49,    9.57,    5.63},
{1894.72,    1221.91,    8.87,    2.34},
{1890.08,    1218.68,    8.87,    1.59},
{1883.50,    1218.25,    8.90,    0.67},
{1886.93,    1221.40,    8.94,    1.60},
{1883.76,    1222.30,    9.11,    6.26},
{1889.82,    1222.51,    9.03,    0.97},
{1898.23,    1217.97,    8.87,    3.42},
{1877.40,    1216.41,    8.97,    0.37},
{1893.07,    1215.26,    8.87,    3.08},
{1878.57,    1214.16,    8.87,    3.12},
{1889.94,    1212.21,    8.87,    1.59},
{1883.74,    1212.35,    8.87,    1.59},
{1877.00,    1207.27,    8.87,    3.80},
{1873.63,    1204.65,    8.87,    0.61},
{1896.46,    1205.62,    8.87,    5.72},
{1899.63,    1202.52,    8.87,    2.46},
{1889.23,    1207.72,    8.87,    1.47},
{1879.77,    1207.96,    8.87,    1.55}
};

uint32 spawnentries[8] = {7789,7787,7787,8876,7788,8877,7275,7796};

struct instance_zul_farrak : public ScriptedInstance
{
    instance_zul_farrak(Map *map) : ScriptedInstance(map) {Initialize();};

    uint32 Encounter[ENCOUNTERS];
    uint8 waves;
    uint32 wavecounter;
    uint64 captives[5];
    uint64 doorsGUID;

    void Initialize()
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounter[i] = NOT_STARTED;
        waves = 0;
        wavecounter = 0;
        for(uint8 i = 0; i < 5; i++)
            captives[i] = 0;
        doorsGUID = 0;
    }

    void OnGameObjectCreate(GameObject *go, bool)
    {
        if (go->GetEntry() >= CAGES_BEGIN && go->GetEntry() <= CAGES_END )
            if (Encounter[0] > IN_PROGRESS)
                go->SetGoState(GO_STATE_ACTIVE);
        if (go->GetEntry() == DOOR_ENTRY && Encounter[1] == DONE)
        {
            go->SetGoState(GO_STATE_ACTIVE);
            doorsGUID = go->GetGUID();
        }
    }

    void OnCreatureCreate(Creature *c, bool)
    {
        if (c->GetEntry() >= CAPTIVES_BEGIN && c->GetEntry() <= CAPTIVES_END )
        {
            if (Encounter[0] != NOT_STARTED)
                c->ForcedDespawn();
            captives[c->GetEntry() - CAPTIVES_BEGIN] = c->GetGUID();
        }
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << Encounter[0] << " " << Encounter[1];

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
        loadStream >> Encounter[0] >> Encounter[1];

        if (Encounter[0] == IN_PROGRESS)
            Encounter[0] = NOT_STARTED;

        OUT_LOAD_INST_DATA_COMPLETE;
    }

    void SetData(uint32 Data, uint32 Value)
    {
        if (Data == DATA_PYRAMID_BATTLE)
        {
            if (Value == IN_PROGRESS && Encounter[0] == NOT_STARTED)
            Encounter[0] = Value;
            else if (Value == SPECIAL)
            --wavecounter;
        }
        else if (Data == DATA_DOOR_EVENT && Encounter[1] != DONE)
            Encounter[1] = Value;
        if (Data == DATA_DOOR_EVENT && Value == DONE)
            if (GameObject * go = instance->GetGameObject(doorsGUID))
                go->SetGoState(GO_STATE_ACTIVE);
        if (Value >= FAIL)
            SaveToDB();

    }

    uint32 GetData(uint32 Data)
    {
        if (Data == DATA_PYRAMID_BATTLE)
            return Encounter[0];
        if (Data == DATA_DOOR_EVENT)
            return Encounter[1];
        return 0;
    }

    void Update(uint32 diff)
    {
        if (Encounter[0] == IN_PROGRESS && wavecounter == 0)
        {
            if (waves == 0)
                for (uint8 i = 0; i < 5; i++)
                    if (Creature *c = GetCreature(captives[i]))
                        {
                            c->SetWalk(true);
                            c->GetMotionMaster()->MovePoint(0,ZFWPs[i][0],ZFWPs[i][1],ZFWPs[i][2]);
                        }
            if (waves == 0 || waves == 1 || waves == 2)
                for (uint8 j = 0; j < 4; j++)
                    for (uint8 i = 0; i < 6; i++)
                        if (Player * p = instance->GetPlayers().begin()->getSource())
                            if (Creature* c = p->SummonCreature(spawnentries[i],spawns[j*6 + i][0],spawns[j*6 + i][1],spawns[j*6 + i][2],spawns[j*6 + i][3],TEMPSUMMON_CORPSE_TIMED_DESPAWN,60000))
                                wavecounter++;
            if (waves == 3)
                wavecounter = 15000;
            if (waves >= 4)
                Encounter[0] = DONE;

            if (waves == 2)
            {
                for (uint8 i = 0; i < 5; i++)
                    if (Creature *c = GetCreature(captives[i]))
                    {
                        c->GetMotionMaster()->MovePoint(1,ZFWPs[i+5][0],ZFWPs[i+5][1],ZFWPs[i+5][2]);
                        c->SetHomePosition(ZFWPs[i+5][0],ZFWPs[i+5][1],ZFWPs[i+5][2],0);
                    }
                if (Player * p = instance->GetPlayers().begin()->getSource())
                {
                    if (Creature* c = p->SummonCreature(spawnentries[6],spawns[24][0],spawns[24][1],spawns[24][2],spawns[24][3],TEMPSUMMON_CORPSE_TIMED_DESPAWN,60000))
                        wavecounter++;
                    if (Creature* c = p->SummonCreature(spawnentries[7],spawns[25][0],spawns[25][1],spawns[25][2],spawns[25][3],TEMPSUMMON_CORPSE_TIMED_DESPAWN,60000))
                        wavecounter++;
                }
            }
            
            waves++;
        }
        
        if (waves == 4)
        {
            if (wavecounter < diff)
                wavecounter = 0;
            else
                wavecounter -= diff;
        }
    }
};

InstanceData* GetInstanceData_instance_zul_farrak(Map* map)
{
    return new instance_zul_farrak(map);
}

void AddSC_instance_zul_farrak()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_zul_farrak";
    newscript->GetInstanceData = &GetInstanceData_instance_zul_farrak;
    newscript->RegisterSelf();
}