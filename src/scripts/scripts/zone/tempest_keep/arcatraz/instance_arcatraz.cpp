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
SDName: Instance_Arcatraz
SD%Complete: 80
SDComment: Mainly Harbringer Skyriss event
SDCategory: Tempest Keep, The Arcatraz
EndScriptData */

#include "precompiled.h"
#include "def_arcatraz.h"

#define ENCOUNTERS 8

#define CONTAINMENT_CORE_SECURITY_FIELD_ALPHA 184318        //door opened when Wrath-Scryer Soccothrates dies
#define CONTAINMENT_CORE_SECURITY_FIELD_BETA  184319        //door opened when Dalliah the Doomsayer dies
#define POD_ALPHA   183961                                  //pod first boss wave
#define POD_BETA    183963                                  //pod second boss wave
#define POD_DELTA   183964                                  //pod third boss wave
#define POD_GAMMA   183962                                  //pod fourth boss wave
#define POD_OMEGA   183965                                  //pod fifth boss wave
#define SEAL_SPHERE 184802                                  //shield 'protecting' mellichar

#define MELLICHAR   20904                                   //skyriss will kill this unit


/* Arcatraz encounters:
1 - Zereketh the Unbound event
2 - Dalliah the Doomsayer event
3 - Wrath-Scryer Soccothrates event
4 - Harbinger Skyriss event, 5 sub-events
*/

struct instance_arcatraz : public ScriptedInstance
{
    instance_arcatraz(Map *map) : ScriptedInstance(map) {Initialize();};

    uint32 Encounter[ENCOUNTERS];

    uint64 Containment_Core_Security_Field_Alpha;
    uint64 Containment_Core_Security_Field_Beta;
    uint64 Pod_Alpha;
    uint64 Pod_Gamma;
    uint64 Pod_Beta;
    uint64 Pod_Delta;
    uint64 Pod_Omega;

    uint64 GoSphereGUID;
    uint64 MellicharGUID;

    void Initialize()
    {
        Containment_Core_Security_Field_Alpha = 0;
        Containment_Core_Security_Field_Beta  = 0;
        Pod_Alpha = 0;
        Pod_Beta  = 0;
        Pod_Delta = 0;
        Pod_Gamma = 0;
        Pod_Omega = 0;

        GoSphereGUID = 0;
        MellicharGUID = 0;

        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounter[i] = NOT_STARTED;
    }

    bool IsEncounterInProgress() const
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            if(Encounter[i] == IN_PROGRESS)
                return true;

        return false;
    }

    void OnObjectCreate(GameObject *go)
    {
        switch(go->GetEntry())
        {
            case CONTAINMENT_CORE_SECURITY_FIELD_ALPHA:
                Containment_Core_Security_Field_Alpha = go->GetGUID();
                if (GetData(TYPE_SOCCOTHRATES) == DONE)
                    HandleGameObject(0, true, go);
                break;
            case CONTAINMENT_CORE_SECURITY_FIELD_BETA:
                Containment_Core_Security_Field_Beta =  go->GetGUID();
                if (GetData(TYPE_DALLIAH) == DONE)
                    HandleGameObject(0, true, go);
                break;
            case SEAL_SPHERE: GoSphereGUID = go->GetGUID(); break;
            case POD_ALPHA: Pod_Alpha = go->GetGUID(); break;
            case POD_BETA:  Pod_Beta =  go->GetGUID(); break;
            case POD_DELTA: Pod_Delta = go->GetGUID(); break;
            case POD_GAMMA: Pod_Gamma = go->GetGUID(); break;
            case POD_OMEGA: Pod_Omega = go->GetGUID(); break;
        }
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        if (creature->GetEntry() == MELLICHAR)
            MellicharGUID = creature->GetGUID();
    }

    void SetData(uint32 type, uint32 data)
    {
        switch (type)
        {
            case TYPE_ZEREKETH:
                Encounter[0] = data;
                break;

            case TYPE_DALLIAH:
                if (data == DONE)
                   HandleGameObject(Containment_Core_Security_Field_Beta, true);
                Encounter[1] = data;
                break;

            case TYPE_SOCCOTHRATES:
                if (data == DONE)
                    HandleGameObject(Containment_Core_Security_Field_Alpha, true);
                Encounter[2] = data;
                break;

            case TYPE_HARBINGERSKYRISS:
                if (data == NOT_STARTED || data == FAIL)
                {
                    Encounter[4] = NOT_STARTED;
                    Encounter[5] = NOT_STARTED;
                    Encounter[6] = NOT_STARTED;
                    Encounter[7] = NOT_STARTED;
                    HandleGameObject(Pod_Alpha,false);
                    HandleGameObject(Pod_Beta,false);
                    HandleGameObject(Pod_Gamma,false);
                    HandleGameObject(Pod_Delta,false);
                    HandleGameObject(Pod_Omega,false);
                    HandleGameObject(GoSphereGUID,true);
                    if (GetCreature(MellicharGUID) && GetCreature(MellicharGUID)->isDead())
                        GetCreature(MellicharGUID)->Respawn();
                }
                Encounter[3] = data;
                break;

            case TYPE_WARDEN_1:;
                Encounter[4] = data;
                break;

            case TYPE_WARDEN_2:;
                Encounter[5] = data;
                break;

            case TYPE_WARDEN_3:
                Encounter[6] = data;
                break;

            case TYPE_WARDEN_4:
                Encounter[7] = data;
                break;
        }

        if(data == DONE)
            SaveToDB();
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << Encounter[0] << " ";
        stream << Encounter[1] << " ";
        stream << Encounter[2]  << " ";
        stream << Encounter[3]  << " ";
        stream << Encounter[4]  << " ";
        stream << Encounter[5]  << " ";
        stream << Encounter[6]  << " ";
        stream << Encounter[7];

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
        stream >> Encounter[0] >> Encounter[1] >> Encounter[2] >> Encounter[3] >> Encounter[4] >> Encounter[5] >> Encounter[6]
            >> Encounter[7];
        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if(Encounter[i] == IN_PROGRESS)
                Encounter[i] = NOT_STARTED;

        if(GetData(TYPE_HARBINGERSKYRISS) == NOT_STARTED)
            SetData(TYPE_HARBINGERSKYRISS, NOT_STARTED);            // this will reset whole encounter
        OUT_LOAD_INST_DATA_COMPLETE;
    }

    uint32 GetData(uint32 type)
    {
         switch(type)
        {
            case TYPE_ZEREKETH:
                return Encounter[0];
            case TYPE_DALLIAH:
                return Encounter[1];
            case TYPE_SOCCOTHRATES:
                return Encounter[2];
            case TYPE_HARBINGERSKYRISS:
                return Encounter[3];
            case TYPE_WARDEN_1:
                return Encounter[4];
            case TYPE_WARDEN_2:
                return Encounter[5];
            case TYPE_WARDEN_3:
                return Encounter[6];
            case TYPE_WARDEN_4:
                return Encounter[7];
        }
        return 0;
    }

    uint64 GetData64(uint32 data)
    {
        switch(data)
        {
            case DATA_MELLICHAR:
                return MellicharGUID;
            case DATA_SPHERE_SHIELD:
                return GoSphereGUID;
            case DATA_POD_A:
                return Pod_Alpha;
            case DATA_POD_B:
                return Pod_Beta;
            case DATA_POD_D:
                return Pod_Delta;
            case DATA_POD_G:
                return Pod_Gamma;
            case DATA_POD_O:
                return Pod_Omega;
        }
        return 0;
    }
};

InstanceData* GetInstanceData_instance_arcatraz(Map* map)
{
    return new instance_arcatraz(map);
}

void AddSC_instance_arcatraz()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_arcatraz";
    newscript->GetInstanceData = &GetInstanceData_instance_arcatraz;
    newscript->RegisterSelf();
}
