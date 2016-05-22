/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Instance_ZulGurub
SD%Complete: 80
SDComment: Missing reset function after killing a boss for Ohgan, Thekal.
SDCategory: Zul'Gurub
EndScriptData */

#include "precompiled.h"
#include "def_zulgurub.h"

#define ENCOUNTERS 10

/* Zul'Gurub encounters:
0 - High Priestess Jeklik Event
1 - High Priest Venoxis Event
2 - High Priestess Mar'li Event
3 - High Priest Thekal Event
4 - High Priestess Arlokk Event
5 - Hakkar the Soulflayer Event
6 - Bloodlord Mandokir Event
7 - Jin'do the Hexxer Event
8 - Gahz'ranka Event
9 - Edge of Madness Event
*/

struct instance_zulgurub : public ScriptedInstance
{
    instance_zulgurub(Map *map) : ScriptedInstance(map) {Initialize();};

    uint32 encounters[ENCOUNTERS+3];

    //Storing Lorkhan, Zath and Thekal because we need to cast on them later. Jindo is needed for healfunction too.
    uint64 LorKhanGUID;
    uint64 ZathGUID;
    uint64 ThekalGUID;
    uint64 JindoGUID;
    uint64 OhganGUID;
    uint64 GongGUID;

    void OnObjectCreate(GameObject* pGo)
    {
        if(pGo->GetEntry() == GO_GONG_OF_BETHEKK)
            GongGUID = pGo->GetGUID();
    }

    uint32 GetEncounterForEntry(uint32 entry)
    {
        switch (entry)
        {
            case 14517:
                return DATA_JEKLIKEVENT;
            case 14507:
                return DATA_VENOXISEVENT;
            case 11382:
            case 14988:
                return DATA_MANDOKIREVENT;
            case 14510:
                return DATA_MARLIEVENT;
            case 14509:
                return DATA_THEKALEVENT;
            case 15114:
                return DATA_GAHZRANKAEVENT;
            case 14515:
                return DATA_ARLOKKEVENT;
            case 11380:
                return DATA_JINDOEVENT;
            case 14834:
                return DATA_HAKKAREVENT;
            case 15082:
            case 15084:
            case 15083:
            case 15085:
                return DATA_EDGEOFMADNESSEVENT;
            default:
                return 0;
        }
    }

    void OnCreatureCreate (Creature *creature, uint32 creature_entry)
    {
        switch (creature_entry)
        {
            case 11347:
                LorKhanGUID = creature->GetGUID();
                break;

            case 11348:
                ZathGUID = creature->GetGUID();
                break;

            case 14509:
                ThekalGUID = creature->GetGUID();
                break;

            case 11380:
                JindoGUID = creature->GetGUID();
                break;

            case 14988:
                OhganGUID = creature->GetGUID();
                break;
        }

        HandleInitCreatureState(creature);
    }

    void Initialize()
    {
        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            encounters[i] = NOT_STARTED;
    }

    bool IsEncounterInProgress() const
    {
        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            if (encounters[i] == IN_PROGRESS)
                return true;

        return false;
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case DATA_JEKLIKEVENT:
                return encounters[0];

            case DATA_VENOXISEVENT:
                return encounters[1];

            case DATA_MARLIEVENT:
                return encounters[2];

            case DATA_THEKALEVENT:
                return encounters[3];

            case DATA_ARLOKKEVENT:
                return encounters[4];

            case DATA_HAKKAREVENT:
                return encounters[5];

            case DATA_MANDOKIREVENT:
                return encounters[6];

            case DATA_JINDOEVENT:
                return encounters[7];

            case DATA_GAHZRANKAEVENT:
                return encounters[8];

            case DATA_EDGEOFMADNESSEVENT:
                return encounters[9];

            case DATA_THEKALFAKEDEATH:
                return encounters[10];

            case DATA_LORKHANISDEAD:
                return encounters[11];

            case DATA_ZATHISDEAD:
                return encounters[12];
        }

        return 0;
    }

    uint64 GetData64 (uint32 identifier)
    {
        switch(identifier)
        {
            case DATA_LORKHAN:
                return LorKhanGUID;

            case DATA_ZATH:
                return ZathGUID;

            case DATA_THEKAL:
                return ThekalGUID;

            case DATA_JINDO:
                return JindoGUID;

            case DATA_OHGAN:
                return OhganGUID;
        }

        return 0;
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
            case DATA_JEKLIKEVENT:
                if (encounters[0] != DONE)
                    encounters[0] = data;
                break;

            case DATA_VENOXISEVENT:
                if (encounters[1] != DONE)
                    encounters[1] = data;
                break;

            case DATA_MARLIEVENT:
                if (encounters[2] != DONE)
                    encounters[2] = data;
                break;

            case DATA_THEKALEVENT:
                if (encounters[3] != DONE)
                    encounters[3] = data;
                break;

            case DATA_ARLOKKEVENT:
                {
                if (data == IN_PROGRESS && encounters[4] != IN_PROGRESS)
                    if (GameObject * pGo = instance->GetGameObject(GongGUID))
                    {
                        pGo->SetFlag(GAMEOBJECT_FLAGS,GO_FLAG_NOTSELECTABLE);
                        pGo->SummonCreature(14515,-11540.7,-1627.71,41.27,0.1,TEMPSUMMON_CORPSE_TIMED_DESPAWN,600000);
                    }
                if (encounters[4] != DONE)
                    encounters[4] = data;
                break;
                }

            case DATA_HAKKAREVENT:
                if (encounters[5] != DONE)
                    encounters[5] = data;
                break;

            case DATA_MANDOKIREVENT:
                if (encounters[6] != DONE)
                    encounters[6] = data;
                break;

            case DATA_JINDOEVENT:
                if (encounters[7] != DONE)
                    encounters[7] = data;
                break;

            case DATA_GAHZRANKAEVENT:
                if (encounters[8] != DONE)
                    encounters[8] = data;
                break;

            case DATA_EDGEOFMADNESSEVENT:
                if (encounters[9] != DONE)
                    encounters[9] = data;
                break;

            case DATA_THEKALFAKEDEATH:
                encounters[10] = data;
                break;

            case DATA_LORKHANISDEAD:
                encounters[11] = data;
                break;

            case DATA_ZATHISDEAD:
                encounters[12] = data;
                break;
        }

        if (data == DONE)
            SaveToDB();
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << encounters[0] << " ";
        stream << encounters[1] << " ";
        stream << encounters[2] << " ";
        stream << encounters[3] << " ";
        stream << encounters[4] << " ";
        stream << encounters[5] << " ";
        stream << encounters[6] << " ";
        stream << encounters[7] << " ";
        stream << encounters[8] << " ";
        stream << encounters[9];

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
        loadStream >> encounters[0] >> encounters[1] >> encounters[2] >>
                    encounters[3] >> encounters[4] >> encounters[5] >>
                    encounters[6] >> encounters[7] >> encounters[8] >> encounters[9];

        for(uint8 i = 0; i < ENCOUNTERS; ++i)
        {
            if (encounters[i] == IN_PROGRESS)
                encounters[i] = NOT_STARTED;
        }

        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_zulgurub(Map* map)
{
    return new instance_zulgurub(map);
}

void AddSC_instance_zulgurub()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_zulgurub";
    newscript->GetInstanceData = &GetInstanceData_instance_zulgurub;
    newscript->RegisterSelf();
}

