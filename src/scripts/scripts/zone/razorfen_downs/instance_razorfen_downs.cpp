/*
 * Copyright (C) 2010 Trinity <http://www.trinitycore.org/>
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

//#include "ScriptedPch.h"
#include "precompiled.h"
#include "razorfen_downs.h"

#define    MAX_ENCOUNTER  2

struct instance_razorfen_downs : public ScriptedInstance
{
    instance_razorfen_downs(Map* pMap) : ScriptedInstance(pMap)
    {
        Initialize();
    };

    uint64 uiGongGUID;
    std::list<uint64> flamesGUID;
    uint32 m_auiEncounter[MAX_ENCOUNTER];

    uint8 uiGongWaves;

    void Initialize()
    {
        uiGongGUID = 0;

        uiGongWaves = 0;
        flamesGUID.clear();
        memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;

        stream << "T C ";
        stream << m_auiEncounter[0]  << m_auiEncounter[1]  << " ";
        stream << uiGongWaves;

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

        char dataHead1, dataHead2;
        uint16 data0, data1, data2;

        std::istringstream loadStream(in);
        loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2;

        if (dataHead1 == 'T' && dataHead2 == 'C')
        {
            m_auiEncounter[0] = data0;
            m_auiEncounter[1] = data1;

            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS)
                    m_auiEncounter[i] = NOT_STARTED;

            uiGongWaves = data2;
        } else OUT_LOAD_INST_DATA_FAIL;

        OUT_LOAD_INST_DATA_COMPLETE;
    }

    void OnObjectCreate(GameObject* pGo)
    {
        switch(pGo->GetEntry())
        {
            case GO_GONG:
                uiGongGUID = pGo->GetGUID();
                if (m_auiEncounter[0] == DONE)
                    pGo->SetFlag(GAMEOBJECT_FLAGS,GO_FLAG_NOTSELECTABLE);
                break;
            case GO_IDOL_MOUTH:
            case GO_IDOL_CUP:
            case GO_IDOL_OVEN:
                    flamesGUID.push_back(pGo->GetGUID());break;
            default:
                break;
        }
    }

    void OnCreatureCreate(Creature* c, uint32 id)
    {
        if (id == CREATURE_BELNISTRASZ && m_auiEncounter[1] == DONE)
            c->ForcedDespawn();
    }

    void SetData(uint32 uiType, uint32 uiData)
    {
        if (uiType == DATA_GONG_WAVES)
        {
            uiGongWaves = uiData;

            switch(uiGongWaves)
            {
                case 9:
                case 14:
                    if (GameObject* pGo = instance->GetGameObject(uiGongGUID))
                        pGo->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_NOTSELECTABLE);
                    break;
                case 1:
                case 10:
                case 16:
                {
                    GameObject* pGo = instance->GetGameObject(uiGongGUID);

                    if (!pGo)
                        return;

                    pGo->SetFlag(GAMEOBJECT_FLAGS,GO_FLAG_NOTSELECTABLE);

                    uint32 uiCreature = 0;
                    uint8 uiSummonTimes = 0;

                    switch(uiGongWaves)
                    {
                        case 1:
                            uiCreature = CREATURE_TOMB_FIEND;
                            uiSummonTimes = 7;
                            break;
                        case 10:
                            uiCreature = CREATURE_TOMB_REAVER;
                            uiSummonTimes = 3;
                            break;
                        case 16:
                            uiCreature = CREATURE_TUTEN_KASH;
                            break;
                        default:
                            break;
                    }


                    if (Creature* pCreature = pGo->SummonCreature(uiCreature,2502.635,844.140,46.896,0.633, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000))
                    {
                        if (uiGongWaves == 10 || uiGongWaves == 1)
                        {
                            for (uint8 i = 0; i < uiSummonTimes; ++i)
                            {
                                if (Creature* pSummon = pGo->SummonCreature(uiCreature,2502.635 + float(irand(-5,5)),844.140 + float(irand(-5,5)),46.896,0.633,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000))
                                    pSummon->GetMotionMaster()->MovePoint(0,2533.479 + float(irand(-5,5)),870.020 + float(irand(-5,5)),47.678);
                            }
                        }
                        pCreature->GetMotionMaster()->MovePoint(0,2533.479 + float(irand(-5,5)),870.020 + float(irand(-5,5)),47.678);
                    }
                    break;
                }
                default:
                    break;
            }
        }

        if (uiType == BOSS_TUTEN_KASH || uiType == DATA_BELNISTRASZ)
        {
            m_auiEncounter[uiType] = uiData;

            if (uiData == DONE)
                SaveToDB();
        }
        if (uiType == DATA_BELNISTRASZ)
        {
            for( std::list<uint64>::iterator itr = flamesGUID.begin() ; itr != flamesGUID.end(); itr++)
                instance->GetGameObject(*itr)->AddObjectToRemoveList();
        }
    }

    uint32 GetData(uint32 uiType)
    {
        switch(uiType)
        {
            case DATA_GONG_WAVES:
                return uiGongWaves;
        }

        return 0;
    }

    uint64 GetData64(uint32 uiType)
    {
        switch(uiType)
        {
            case DATA_GONG: return uiGongGUID;
        }

        return 0;
    }
};

InstanceData* GetInstanceData_instance_razorfen_downs(Map* pMap)
{
    return new instance_razorfen_downs(pMap);
}

void AddSC_instance_razorfen_downs()
{
    Script* newscript;

    newscript = new Script;
    newscript->Name = "instance_razorfen_downs";
    newscript->GetInstanceData = &GetInstanceData_instance_razorfen_downs;
    newscript->RegisterSelf();
}
