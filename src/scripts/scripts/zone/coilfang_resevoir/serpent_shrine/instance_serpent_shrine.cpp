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
SDName: Instance_Serpent_Shrine
SD%Complete: 100
SDComment: Instance Data Scripts and functions to acquire mobs and set encounter status for use in various Serpent Shrine Scripts
SDCategory: Coilfang Resevoir, Serpent Shrine Cavern
EndScriptData */

#include "precompiled.h"
#include "def_serpent_shrine.h"

#define ENCOUNTERS 6

#define SPELL_SCALDINGWATER 37284
#define MOB_COILFANG_FRENZY 21508
#define TRASHMOB_COILFANG_TECHNI 21263

uint64 consoles[6] = {0,0,0,0,0,0};

bool c1_used = false, c2_used = false, c3_used = false, c4_used = false, c5_used = false;

uint64 ControlConsole = 0;


/* Serpentshrine cavern encounters:
0 - Hydross The Unstable event
1 - Leotheras The Blind Event
2 - The Lurker Below Event
3 - Fathom-Lord Karathress Event
4 - Morogrim Tidewalker Event
5 - Lady Vashj Event
*/
/*
bool GOUse_go_bridge_console(Player *player, GameObject* go)
{
ScriptedInstance* pInstance = (ScriptedInstance*)go->GetInstanceData();

if(!pInstance )
return false;

if (c1_used && c2_used && c3_used && c4_used && c5_used){
pInstance->SetData(DATA_CONTROL_CONSOLE, DONE);
return true;
}

return false;
}*/

bool GOUse_go_vashj_console_access_panel(Player *player, GameObject* go)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)go->GetInstanceData();

    if(!pInstance)
        return false;

    if (go->GetGUID() == consoles[1])
        if (!c1_used && (pInstance->GetData(DATA_HYDROSSTHEUNSTABLEEVENT) == DONE)){
            c1_used = true;
            go->Say("c1_activated", LANG_UNIVERSAL,player->GetGUID());
        }

        if (go->GetGUID() == consoles[2])
            if (!c2_used && (pInstance->GetData(DATA_THELURKERBELOWEVENT) == DONE)){
                c2_used = true;
                go->Say("c2_activated", LANG_UNIVERSAL,player->GetGUID());
            }

            if (go->GetGUID() == consoles[3])
                if (!c3_used && (pInstance->GetData(DATA_LEOTHERASTHEBLINDEVENT) == DONE)){
                    c3_used = true;
                    go->Say("c3_activated", LANG_UNIVERSAL,player->GetGUID());
                }

                if (go->GetGUID() == consoles[4])
                    if (!c4_used && (pInstance->GetData(DATA_KARATHRESSEVENT) == DONE)){
                        c4_used = true;
                        go->Say("c4_activated", LANG_UNIVERSAL,player->GetGUID());
                    }

                    if (go->GetGUID() == consoles[5])
                        if (!c5_used && (pInstance->GetData(DATA_MOROGRIMTIDEWALKEREVENT) == DONE)){
                            c5_used = true;
                            go->Say("c5_activated", LANG_UNIVERSAL,player->GetGUID());
                        }

                        if (c1_used && c2_used && c3_used && c4_used && c5_used){
                            if (player && ControlConsole)
                                if (GameObject *go_console = GameObject::GetGameObject(*player,ControlConsole)){
                                    go_console->SetGoState(GOState(0));
                                    go->Say("all_activated", LANG_UNIVERSAL,player->GetGUID());
                                    pInstance->SetData(DATA_CONTROL_CONSOLE, DONE);
                                }
                        }

                        return true;
}

struct instance_serpentshrine_cavern : public ScriptedInstance
{
    instance_serpentshrine_cavern(Map *map) : ScriptedInstance(map) {Initialize();};

    uint64 LurkerBelow;
    uint64 Sharkkis;
    uint64 SharkkisPet;
    uint64 Tidalvess;
    uint64 Caribdis;
    uint64 LadyVashj;
    uint64 Karathress;
    uint64 KarathressEvent_Starter;
    uint64 LeotherasTheBlind;
    uint64 LeotherasEventStarter;

    uint64 BridgePart[3];
    uint32 StrangePool;
    uint32 FishingTimer;
    uint32 LurkerSubEvent;
    uint32 WaterCheckTimer;
    uint32 Water;
    uint32 trashCheckTimer;

    bool ShieldGeneratorDeactivated[4];
    uint32 Encounters[ENCOUNTERS];

    void Initialize()
    {
        LurkerBelow = 0;
        Sharkkis = 0;
        SharkkisPet = 0;
        Tidalvess = 0;
        Caribdis = 0;
        LadyVashj = 0;
        Karathress = 0;
        KarathressEvent_Starter = 0;
        LeotherasTheBlind = 0;
        LeotherasEventStarter = 0;

        ControlConsole = 0;
        BridgePart[0] = 0;
        BridgePart[1] = 0;
        BridgePart[2] = 0;

        StrangePool = 0;
        Water = WATERSTATE_FRENZY;

        ShieldGeneratorDeactivated[0] = false;
        ShieldGeneratorDeactivated[1] = false;
        ShieldGeneratorDeactivated[2] = false;
        ShieldGeneratorDeactivated[3] = false;
        FishingTimer = 1000;
        LurkerSubEvent = 0;
        WaterCheckTimer = 500;
        trashCheckTimer = 10000;

        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounters[i] = NOT_STARTED;
    }

    bool IsEncounterInProgress() const
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            if (Encounters[i] == IN_PROGRESS)
                return true;

        return false;
    }

    void OnObjectCreate(GameObject *go)
    {
        switch(go->GetEntry())
        {
        case 184568:
            ControlConsole = go->GetGUID();
            if (c1_used && c2_used && c3_used && c4_used && c5_used)
                HandleGameObject(ControlConsole, 0);
            break;

        case 184203:
            BridgePart[0] = go->GetGUID();
            go->setActive(true);
            break;

        case 184204:
            BridgePart[1] = go->GetGUID();
            go->setActive(true);
            break;

        case 184205:
            BridgePart[2] = go->GetGUID();
            go->setActive(true);
            break;
        case 184956:
            StrangePool = go->GetGUID();
            if(go->isActiveObject())
                SetData(DATA_STRANGE_POOL, DONE);
            break;
        case GAMEOBJECT_FISHINGNODE_ENTRY:
            if(LurkerSubEvent == LURKER_NOT_STARTED)
            {
                if (Unit *pTemp = instance->GetCreature(LurkerBelow))
                {
                    if (go->GetDistance2d(pTemp) > 16.0f)
                        return;

                    FishingTimer = 10000+rand()%30000;//random time before lurker emerges
                    LurkerSubEvent = LURKER_FISHING;
                }
            }
            break;

        case 185114:
            consoles[1] = go->GetGUID();
            go->setActive(true);
            break;

        case 185118:
            consoles[5] = go->GetGUID();
            go->setActive(true);
            break;

        case 185115:
            consoles[2] = go->GetGUID();
            go->setActive(true);
            break;

        case 185116:
            consoles[3] = go->GetGUID();
            go->setActive(true);
            break;

        case 185117:
            consoles[4] = go->GetGUID();
            go->setActive(true);
            break;
        }
    }

    void OpenDoor(uint64 DoorGUID, bool open)
    {
        if(GameObject *Door = instance->GetGameObject(DoorGUID))
            Door->SetUInt32Value(GAMEOBJECT_STATE, open ? 0 : 1);
    }

    uint32 GetEncounterForEntry(uint32 entry)
    {
        switch(entry)
        {
        case 21212:
            return DATA_LADYVASHJEVENT;
        case 21214:
            return DATA_KARATHRESSEVENT;
        case 21217:
            return DATA_THELURKERBELOWEVENT;
        case 21215:
            return DATA_LEOTHERASTHEBLINDEVENT;
        case 21213:
            return DATA_MOROGRIMTIDEWALKEREVENT;
        case 21216:
            return DATA_HYDROSSTHEUNSTABLEEVENT;
        default:
            return 0;
        }
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        switch(creature_entry)
        {
        case 21212:
            LadyVashj = creature->GetGUID();
            break;
        case 21214:
            Karathress = creature->GetGUID();
            break;
        case 21966:
            Sharkkis = creature->GetGUID();
            break;
        case 21217:
            LurkerBelow = creature->GetGUID();
            break;
        case 21965:
            Tidalvess = creature->GetGUID();
            break;
        case 21964:
            Caribdis = creature->GetGUID();
            break;
        case 21215:
            LeotherasTheBlind = creature->GetGUID();
            break;
        }

        HandleInitCreatureState(creature);
    }

    void SetData64(uint32 type, uint64 data)
    {
        if(type == DATA_KARATHRESSEVENT_STARTER)
            KarathressEvent_Starter = data;
        if(type == DATA_LEOTHERAS_EVENT_STARTER)
            LeotherasEventStarter = data;
        if(type == DATA_SHARKKIS_PET)
            SharkkisPet = data;
    }

    uint64 GetData64(uint32 identifier)
    {
        switch(identifier)
        {
        case DATA_THELURKERBELOW:           return LurkerBelow;
        case DATA_SHARKKIS:                 return Sharkkis;
        case DATA_SHARKKIS_PET:             return SharkkisPet;
        case DATA_TIDALVESS:                return Tidalvess;
        case DATA_CARIBDIS:                 return Caribdis;
        case DATA_LADYVASHJ:                return LadyVashj;
        case DATA_KARATHRESS:               return Karathress;
        case DATA_KARATHRESSEVENT_STARTER:  return KarathressEvent_Starter;
        case DATA_LEOTHERAS:                return LeotherasTheBlind;
        case DATA_LEOTHERAS_EVENT_STARTER:  return LeotherasEventStarter;
        }
        return 0;
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
        case DATA_STRANGE_POOL:
            {
                StrangePool = data;
                if(data == NOT_STARTED)
                    LurkerSubEvent = LURKER_NOT_STARTED;
            }
            break;
        case DATA_WATER : Water = data; break;
        case DATA_CONTROL_CONSOLE:
            if(data == DONE)
            {
                OpenDoor(BridgePart[0], true);
                OpenDoor(BridgePart[1], true);
                OpenDoor(BridgePart[2], true);
            }
            ControlConsole = data;
            break;
        case DATA_HYDROSSTHEUNSTABLEEVENT:
            if(Encounters[0] != DONE)
                Encounters[0] = data;
            break;
        case DATA_LEOTHERASTHEBLINDEVENT:
            if(Encounters[1] != DONE)
                Encounters[1] = data;
            break;
        case DATA_THELURKERBELOWEVENT:
            if(Encounters[2] != DONE)
                Encounters[2] = data;
            break;
        case DATA_KARATHRESSEVENT:
            if(Encounters[3] != DONE)
                Encounters[3] = data;
            break;
        case DATA_MOROGRIMTIDEWALKEREVENT:
            if(Encounters[4] != DONE)
                Encounters[4] = data;
            break;
            //Lady Vashj
        case DATA_LADYVASHJEVENT:
            if(data == NOT_STARTED)
            {
                ShieldGeneratorDeactivated[0] = false;
                ShieldGeneratorDeactivated[1] = false;
                ShieldGeneratorDeactivated[2] = false;
                ShieldGeneratorDeactivated[3] = false;
            }
            if (Encounters[5] != DONE)
                Encounters[5] = data;
            break;
        case DATA_SHIELDGENERATOR1:ShieldGeneratorDeactivated[0] = (data) ? true : false;   break;
        case DATA_SHIELDGENERATOR2:ShieldGeneratorDeactivated[1] = (data) ? true : false;   break;
        case DATA_SHIELDGENERATOR3:ShieldGeneratorDeactivated[2] = (data) ? true : false;   break;
        case DATA_SHIELDGENERATOR4:ShieldGeneratorDeactivated[3] = (data) ? true : false;   break;
        }

        if (data == DONE)
            SaveToDB();
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
        case DATA_HYDROSSTHEUNSTABLEEVENT:  return Encounters[0];
        case DATA_LEOTHERASTHEBLINDEVENT:   return Encounters[1];
        case DATA_THELURKERBELOWEVENT:      return Encounters[2];
        case DATA_KARATHRESSEVENT:          return Encounters[3];
        case DATA_MOROGRIMTIDEWALKEREVENT:  return Encounters[4];
            //Lady Vashj
        case DATA_LADYVASHJEVENT:           return Encounters[5];
        case DATA_SHIELDGENERATOR1:         return ShieldGeneratorDeactivated[0];
        case DATA_SHIELDGENERATOR2:         return ShieldGeneratorDeactivated[1];
        case DATA_SHIELDGENERATOR3:         return ShieldGeneratorDeactivated[2];
        case DATA_SHIELDGENERATOR4:         return ShieldGeneratorDeactivated[3];
        case DATA_CANSTARTPHASE3:
            if (ShieldGeneratorDeactivated[0] && ShieldGeneratorDeactivated[1] && ShieldGeneratorDeactivated[2] && ShieldGeneratorDeactivated[3])
                return 1;
            break;
        case DATA_STRANGE_POOL:             return StrangePool;
        case DATA_WATER:                    return Water;
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
        stream >> Encounters[0] >> Encounters[1] >> Encounters[2] >> Encounters[3]
        >> Encounters[4] >> Encounters[5];
        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if(Encounters[i] == IN_PROGRESS)                // Do not load an encounter as "In Progress" - reset it instead.
                Encounters[i] = NOT_STARTED;
        OUT_LOAD_INST_DATA_COMPLETE;
    }

    void Update (uint32 diff)
    {
        //Lurker Fishing event
        if (LurkerSubEvent == LURKER_FISHING)
        {
            if (FishingTimer < diff)
            {
                LurkerSubEvent = LURKER_HOOKED;
                SetData(DATA_STRANGE_POOL, IN_PROGRESS);//just fished, signal Lurker script to emerge and start fight, we use IN_PROGRESS so it won't get saved and lurker will be alway invis at start if server restarted
            }
            else
                FishingTimer -= diff;
        }

        if (trashCheckTimer < diff)
        {
            if (Encounters[2] == NOT_STARTED)
            {
                //uint64 tmpPriestessGuid = instance->GetCreatureGUID(TRASHMOB_COILFANG_PRIESTESS, GET_ALIVE_CREATURE_GUID);
                uint64 tmpTechniGuid = instance->GetCreatureGUID(TRASHMOB_COILFANG_TECHNI, GET_ALIVE_CREATURE_GUID);
                if (/*!tmpPriestessGuid && */!tmpTechniGuid)
                    Water = WATERSTATE_SCALDING;
                else
                    Water = WATERSTATE_FRENZY;
            }
            else if (Encounters[2] == DONE)
            {
                Water = WATERSTATE_NONE;
            }

            trashCheckTimer = 2000;
        }
        else
            trashCheckTimer -= diff;

        //Water checks
        if (WaterCheckTimer < diff)
        {
            Map::PlayerList const &PlayerList = instance->GetPlayers();
            if (PlayerList.isEmpty())
                return;

            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if(Player* pPlayer = i->getSource())
                {
                    if (pPlayer->isAlive() && (pPlayer->GetPositionZ() < -20.6f) && pPlayer->IsInWater())
                    {
                        if (Water == WATERSTATE_SCALDING)
                        {
                            if (!pPlayer->HasAura(SPELL_SCALDINGWATER))
                                pPlayer->CastSpell(pPlayer, SPELL_SCALDINGWATER, true);
                        }
                        else if (Water == WATERSTATE_FRENZY)
                        {
                            //spawn frenzy
                            {
                                if (Creature* frenzy = pPlayer->SummonCreature(MOB_COILFANG_FRENZY,pPlayer->GetPositionX(),pPlayer->GetPositionY(),pPlayer->GetPositionZ(),pPlayer->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,5000))
                                {
                                    frenzy->AddUnitMovementFlag(MOVEFLAG_SWIMMING);
                                    frenzy->SetLevitate(true);
                                    frenzy->AI()->AttackStart(pPlayer);
                                }
                            }
                        }
                        else if (Water == WATERSTATE_NONE)
                        {
                            break;
                        }
                    }
                }
            }
            WaterCheckTimer = 2000;
        }
        else
            WaterCheckTimer -= diff;
    }
};

InstanceData* GetInstanceData_instance_serpentshrine_cavern(Map* map)
{
    return new instance_serpentshrine_cavern(map);
}

void AddSC_instance_serpentshrine_cavern()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "instance_serpent_shrine";
    newscript->GetInstanceData = &GetInstanceData_instance_serpentshrine_cavern;
    newscript->RegisterSelf();
    /*
    newscript = new Script;
    newscript->Name="go_bridge_console";
    newscript->pGOUse = &GOUse_go_bridge_console;
    newscript->RegisterSelf();
    */
    newscript = new Script;
    newscript->Name="GOUse_go_vashj_console_access_panel";
    newscript->pGOUse = &GOUse_go_vashj_console_access_panel;
    newscript->RegisterSelf();
}
