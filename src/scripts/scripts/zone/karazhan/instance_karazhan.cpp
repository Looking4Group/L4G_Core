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
SDName: Instance_Karazhan
SD%Complete: 70
SDComment: Instance Script for Karazhan to help in various encounters. TODO: GameObject visibility for Opera event.
SDCategory: Karazhan
EndScriptData */

#include "precompiled.h"
#include "instance_karazhan.h"

instance_karazhan::instance_karazhan(Map* map) : ScriptedInstance(map) {Initialize();}

void instance_karazhan::Initialize()
{
    for (uint8 i = 0; i < ENCOUNTERS; ++i)
        Encounters[i] = NOT_STARTED;

    OperaEvent          = urand(1,3);                   // 1 - OZ, 2 - HOOD, 3 - RAJ, this never gets altered.
    OzDeathCount        = 0;

    CurtainGUID         = 0;
    StageDoorLeftGUID   = 0;
    StageDoorRightGUID  = 0;

    KilrekGUID          = 0;
    TerestianGUID       = 0;
    MoroesGUID          = 0;
    AranGUID            = 0;
    BlizzardGUID        = 0;
    BarnesGUID          = 0;
    ChessTriggerGUID    = 0;

    NightbaneGUID       = 0;

    LibraryDoor         = 0;
    MassiveDoor         = 0;
    GamesmansDoor       = 0;
    GamesmansExitDoor   = 0;
    NetherspaceDoor     = 0;
    MastersTerraceDoor[0]= 0;
    MastersTerraceDoor[1]= 0;
    SideEntranceDoor    = 0;
    ServentAccessDoor   = 0;
    ImageGUID           = 0;
    MedivhGUID          = 0;
    CheckTimer          = 5000;

    needRespawn         = false;
}

bool instance_karazhan::IsEncounterInProgress() const
{
    for (uint8 i = 0; i < ENCOUNTERS - 3; ++i)
        if (Encounters[i] != DONE && Encounters[i] != NOT_STARTED)
            return true;

    return false;
}

uint32 instance_karazhan::GetData(uint32 identifier)
{
    switch (identifier)
    {
        case DATA_ATTUMEN_EVENT:          return Encounters[0];
        case DATA_MOROES_EVENT:           return Encounters[1];
        case DATA_MAIDENOFVIRTUE_EVENT:   return Encounters[2];
        case DATA_OPTIONAL_BOSS_EVENT:    return Encounters[3];
        case DATA_OPERA_EVENT:            return Encounters[4];
        case DATA_CURATOR_EVENT:          return Encounters[5];
        case DATA_SHADEOFARAN_EVENT:      return Encounters[6];
        case DATA_TERESTIAN_EVENT:        return Encounters[7];
        case DATA_NETHERSPITE_EVENT:      return Encounters[8];
        case DATA_CHESS_EVENT:            return Encounters[9];
        case DATA_MALCHEZZAR_EVENT:       return Encounters[10];
        case DATA_NIGHTBANE_EVENT:        return Encounters[11];
        case DATA_DUST_COVERED_CHEST:     return Encounters[12];
        case CHESS_EVENT_TEAM:            return Encounters[13];
        case DATA_CHESS_DAMAGE:           return Encounters[14];
        case DATA_OPERA_PERFORMANCE:      return OperaEvent;
        case DATA_OPERA_OZ_DEATHCOUNT:    return OzDeathCount;
        case DATA_IMAGE_OF_MEDIVH:        return ImageGUID;
    }

    return 0;
}

uint32 GetEncounterForEntry(uint32 entry)
{
    switch(entry)
    {
        case 15688:
            return DATA_TERESTIAN_EVENT;
        case 15687:
            return DATA_MOROES_EVENT;
        case 16524:
            return DATA_SHADEOFARAN_EVENT;
        case 15691:
            return DATA_CURATOR_EVENT;
        case 16457:
            return DATA_MAIDENOFVIRTUE_EVENT;
        case 16151:
            return DATA_ATTUMEN_EVENT;
        case 15689:
            return DATA_NETHERSPITE_EVENT;
        case 17225:
            return DATA_NIGHTBANE_EVENT;
        case 15690:
            return DATA_MALCHEZZAR_EVENT;
        case 18654:
            return DATA_OPERA_EVENT;
        default:
            return 0;
    }
}

void instance_karazhan::HandleInitCreatureState(Creature * mob)
{
    if (!mob->GetTerrain()->IsLineOfSightEnabled())
        mob->SetAggroRange(15);

    InstanceData::HandleInitCreatureState(mob);
}

void instance_karazhan::OnCreatureCreate(Creature *creature, uint32 entry)
{
    uint32 data = 0;
    switch (creature->GetEntry())
    {
        case 17229:
            KilrekGUID = creature->GetGUID();
            break;
        case 15688:
            TerestianGUID = creature->GetGUID();
            break;
        case 15687:
            MoroesGUID = creature->GetGUID();
            break;
        case 16524:
            AranGUID = creature->GetGUID();
            break;
        case 16816:
            MedivhGUID = creature->GetGUID();
            break;
        case 17161:
            BlizzardGUID = creature->GetGUID();
            creature->SetReactState(REACT_PASSIVE);
            break;
        case 16812:
            BarnesGUID = creature->GetGUID();
            break;
        case 22520:
            ChessTriggerGUID = creature->GetGUID();
            break;
        case 17645:
            if (creature->GetPositionZ() < 350.0f)
            {
                creature->SetFlying(true);
                m_LowerRelayGuid = creature->GetObjectGuid();
            }
            break;
        case 17644:
            m_lInfernalTargetsGuidList.push_back(creature->GetObjectGuid());
            break;
    }

    HandleInitCreatureState(creature);
}

uint64 instance_karazhan::GetData64(uint32 data)
{
    switch (data)
    {
        case DATA_KILREK:                       return KilrekGUID;
        case DATA_TERESTIAN:                    return TerestianGUID;
        case DATA_MOROES:                       return MoroesGUID;
        case DATA_NIGHTBANE:                    return NightbaneGUID;
        case DATA_GAMEOBJECT_STAGEDOORLEFT:     return StageDoorLeftGUID;
        case DATA_GAMEOBJECT_STAGEDOORRIGHT:    return StageDoorRightGUID;
        case DATA_GAMEOBJECT_CURTAINS:          return CurtainGUID;
        case DATA_GAMEOBJECT_LIBRARY_DOOR:      return LibraryDoor;
        case DATA_GAMEOBJECT_MASSIVE_DOOR:      return MassiveDoor;
        case DATA_GAMEOBJECT_GAME_DOOR:         return GamesmansDoor;
        case DATA_GAMEOBJECT_GAME_EXIT_DOOR:    return GamesmansExitDoor;
        case DATA_GAMEOBJECT_NETHER_DOOR:       return NetherspaceDoor;
        case DATA_MASTERS_TERRACE_DOOR_1:       return MastersTerraceDoor[0];
        case DATA_MASTERS_TERRACE_DOOR_2:       return MastersTerraceDoor[1];
        case DATA_ARAN:                         return AranGUID;
        case DATA_BLIZZARD:                     return BlizzardGUID;
        case DATA_BARNES:                       return BarnesGUID;
        case DATA_CHESS_ECHO_OF_MEDIVH:         return MedivhGUID;
    }

    return 0;
}

void instance_karazhan::SetData(uint32 type, uint32 data)
{
    switch (type)
    {
        case DATA_ATTUMEN_EVENT:
            if (Encounters[0] != DONE)
                Encounters[0] = data;
            break;
        case DATA_MOROES_EVENT:
            if (Encounters[1] != DONE)
                Encounters[1] = data;
            break;
        case DATA_MAIDENOFVIRTUE_EVENT:
            if (Encounters[2] != DONE)
                Encounters[2] = data;
            break;
        case DATA_OPTIONAL_BOSS_EVENT:
            if (Encounters[3] != DONE)
                Encounters[3] = data;
            break;
        case DATA_OPERA_EVENT:
            if (Encounters[4] == IN_PROGRESS && data == NOT_STARTED)
                if (Creature * barnes = GetCreature(BarnesGUID))
                    if (barnes->IsAIEnabled)
                        barnes->AI()->EnterEvadeMode();

            if (data == DONE)
            {
                HandleGameObject(SideEntranceDoor, true);
                HandleGameObject(ServentAccessDoor, true);
                HandleGameObject(StageDoorLeftGUID, true);
                HandleGameObject(StageDoorRightGUID, true);
            }

            if (Encounters[4] != DONE)
                Encounters[4] = data;

            if (data == NOT_STARTED)
                OzDeathCount = 0;
            break;
        case DATA_CURATOR_EVENT:
            if (Encounters[5] != DONE)
                Encounters[5] = data;

            if (data == DONE)
                HandleGameObject(GamesmansDoor, true);
            break;
        case DATA_SHADEOFARAN_EVENT:
            if (Encounters[6] != DONE)
                Encounters[6] = data;
            HandleGameObject(LibraryDoor, data != IN_PROGRESS);
            break;
        case DATA_TERESTIAN_EVENT:
            if (Encounters[7] != DONE)
                Encounters[7] = data;
            break;
        case DATA_NETHERSPITE_EVENT:
            if (Encounters[8] != DONE)
                Encounters[8] = data;
            break;
        case DATA_CHESS_EVENT:
            if(data == DONE)
            {
                if (GetData(DATA_DUST_COVERED_CHEST) != SPECIAL)
                    SetData(DATA_DUST_COVERED_CHEST, DONE);
            }
            else
            {
                if (data == FAIL)
                    SetData(DATA_DUST_COVERED_CHEST, SPECIAL);
            }

            Encounters[9] = data;
            break;
        case CHESS_EVENT_TEAM:
            Encounters[13] = data;
            break;
        case DATA_CHESS_DAMAGE:
            Encounters[14] = data;
            break;
        case DATA_DUST_COVERED_CHEST:
            if (Encounters[12] != DONE)
                Encounters[12] = data;

            if (data == DONE)
            {
                HandleGameObject(GamesmansExitDoor, true);
                if (Creature * chess = GetCreature(ChessTriggerGUID))
                    chess->DisappearAndDie();
            }
            break;
        case DATA_MALCHEZZAR_EVENT:
            if (Encounters[10] != DONE)
                Encounters[10] = data;
            break;
        case DATA_NIGHTBANE_EVENT:
            if (Encounters[11] != DONE)
                Encounters[11] = data;
            break;
        case DATA_OPERA_OZ_DEATHCOUNT:
            ++OzDeathCount;
            break;
    }

    if(data == DONE)
        SaveToDB();
}

void instance_karazhan::SetData64(uint32 identifier, uint64 data)
{
    switch(identifier)
    {
    case DATA_IMAGE_OF_MEDIVH:
        ImageGUID = data;
        break;
    case DATA_NIGHTBANE:
        NightbaneGUID = data;
        break;
    default:
        break;
    }
}

void instance_karazhan::OnObjectCreate(GameObject* go)
{
    switch(go->GetEntry())
    {
    case 183932:
        CurtainGUID           = go->GetGUID();
        if(Encounters[4] == DONE)
            HandleGameObject(0, true, go);
        break;
    case 184278:
        StageDoorLeftGUID     = go->GetGUID();
        if(Encounters[4] == DONE)
            HandleGameObject(0, true, go);
        break;
    case 184279:
        StageDoorRightGUID    = go->GetGUID();
        if(Encounters[4] == DONE)
            HandleGameObject(0, true, go);
        break;
    case 184517:
        LibraryDoor           = go->GetGUID();
        if(GetData(DATA_SHADEOFARAN_EVENT) == DONE) // open door from Shade of Aran whenever event is saved as DONE
            go->SetGoState(GO_STATE_ACTIVE);
        break;
    case 185521:
        MassiveDoor           = go->GetGUID();
        break;
    case 184276:
        GamesmansDoor         = go->GetGUID();
        if(Encounters[5] == DONE)
            HandleGameObject(0, true, go);
        break;
    case 184277:
        GamesmansExitDoor     = go->GetGUID();
        if(Encounters[12] == DONE)
            HandleGameObject(0, true, go);
        break;
    case 185134:
        NetherspaceDoor       = go->GetGUID();
        break;
    case 184274:
        MastersTerraceDoor[0] = go->GetGUID();
        break;
    case 184280:
        MastersTerraceDoor[1] = go->GetGUID();
        break;
    case 184275:
        SideEntranceDoor      = go->GetGUID();
        if(Encounters[4] == DONE)
            HandleGameObject(0, true, go);
        break;
    case 184281:
        ServentAccessDoor = go->GetGUID();
        if(Encounters[4] == DONE)
            HandleGameObject(0, true, go);
        break;
    }

    switch(OperaEvent)
    {
    //TODO: Set Object visibilities for Opera based on performance
    case EVENT_OZ:
        break;
    case EVENT_HOOD:
        break;
    case EVENT_RAJ:
        break;
    }
}

std::string instance_karazhan::GetSaveData()
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
    stream << Encounters[7] << " ";
    stream << Encounters[8] << " ";
    stream << Encounters[9]  << " ";
    stream << Encounters[10] << " ";
    stream << Encounters[11] << " ";
    stream << Encounters[12];

    OUT_SAVE_INST_DATA_COMPLETE;

    return stream.str();
}

void instance_karazhan::Load(const char* in)
{
    if(!in)
    {
        OUT_LOAD_INST_DATA_FAIL;
        return;
    }

    OUT_LOAD_INST_DATA(in);
    std::istringstream stream(in);

    stream  >> Encounters[0]
            >> Encounters[1]
            >> Encounters[2]
            >> Encounters[3]
            >> Encounters[4]
            >> Encounters[5]
            >> Encounters[6]
            >> Encounters[7]
            >> Encounters[8]
            >> Encounters[9]
            >> Encounters[10]
            >> Encounters[11]
            >> Encounters[12];

    for (uint8 i = 0; i < ENCOUNTERS; ++i)
        if (Encounters[i] == IN_PROGRESS)                // Do not load an encounter as "In Progress" - reset it instead.
            Encounters[i] = NOT_STARTED;

    OUT_LOAD_INST_DATA_COMPLETE;
}

void instance_karazhan::Update(uint32 diff){}

InstanceData* GetInstanceData_instance_karazhan(Map* map)
{
    return new instance_karazhan(map);
}

void AddSC_instance_karazhan()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_karazhan";
    newscript->GetInstanceData = &GetInstanceData_instance_karazhan;
    newscript->RegisterSelf();
}

