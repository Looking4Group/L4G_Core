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

/* Serpentshrine cavern encounters:
0 - Hydross the Unstable
1 - The Lurker Below
2 - Leotheras the Blind
3 - Fathom-Lord Karathress
4 - Morogrim Tidewalker
5 - Lady Vashj
*/

ObjectGuid ConsoleGuids[5]; 
ObjectGuid BridgeConsoleGuid;

bool GOUse_go_vashj_console_access_panel(Player *player, GameObject* go)
{
    ScriptedInstance* instance = (ScriptedInstance*) go->GetInstanceData();

    if (!instance)
    {
        return false;
    }

    ObjectGuid id;
    id = go->GetGUID();

    if (id == ConsoleGuids[0])
    {
        instance->SetData(DATA_HYDROSS_EVENT, SPECIAL);
        player->TextEmote("activates console #1 [Hydross the Unstable].");
        return true;
    }
    if (id == ConsoleGuids[1])
    {
        instance->SetData(DATA_LURKER_EVENT, SPECIAL);
        player->TextEmote("activates console #2 [The Lurker Below].");
        return true;
    }
    if (id == ConsoleGuids[2])
    {
        instance->SetData(DATA_LEOTHERAS_EVENT, SPECIAL);
        player->TextEmote("activates console #3 [Leotheras the Blind].");
        return true;
    }
    if (id == ConsoleGuids[3])
    {
        instance->SetData(DATA_KARATHRESS_EVENT, SPECIAL);
        player->TextEmote("activates console #4 [Fathom-Lord Karathress].");
        return true;
    }
    if (id == ConsoleGuids[4])
    {
        instance->SetData(DATA_MOROGRIM_EVENT, SPECIAL);
        player->TextEmote("activates console #5 [Morogrim Tidewalker].");
        return true;
    }
    if (id == BridgeConsoleGuid) {
        instance->SetData(DATA_BRIDGE_CONSOLE, DONE);
        player->TextEmote("activates console #6 [Access to Lady Vashj].");
        return true;
    }
    return false;
}

struct instance_serpentshrine_cavern : public ScriptedInstance
{
    instance_serpentshrine_cavern(Map *map) : ScriptedInstance(map)
    {
        Initialize();
    };

    /* Encounters */
    uint32 Encounters[MAX_ENCOUNTER];

    /* Creatures */
    uint64 LurkerBelowGuid;
    uint64 SharkkisGuid;
    uint64 SharkkisPetGuid;
    uint64 TidalvessGuid;
    uint64 CaribdisGuid;
    uint64 LadyVashjGuid;
    uint64 KarathressGuid;
    uint64 KarathressEventStarterGuid;
    uint64 LeotherasTheBlindGuid;
    uint64 LeotherasEventStarterGuid;

    uint64 StrangePoolGuid;
    uint64 BridgePartGuids[3];
    uint32 FishingTimer;
    uint32 FrenzySpawnTimer;
    uint32 LurkerFishingEvent;
    uint32 LurkerFishingInternalCooldown;
    uint32 WaterCheckTimer;
    uint32 Water;
    uint32 TrashCheckTimer;

    bool ShieldGeneratorDeactivated[4];
    bool DoSpawnFrenzy;

    void Initialize()
    {
        // Set all encounters to EncounterState:NOT_STARTED (0)
        memset(&Encounters, NOT_STARTED, sizeof(Encounters));

        // Set Lurker Fishing Event to EncounterState:NOT_STARTED (0)
        LurkerFishingEvent = NOT_STARTED;

        // Set Lurker Fishing cooldown to 0
        LurkerFishingInternalCooldown = 0;

        // Strange pool gameobject GUID
        StrangePoolGuid = 0;
        
        /* Creature GUIDs */
        LurkerBelowGuid = 0;
        SharkkisGuid = 0;
        SharkkisPetGuid = 0;
        TidalvessGuid = 0;
        CaribdisGuid = 0;
        LadyVashjGuid = 0;
        KarathressGuid = 0;
        KarathressEventStarterGuid = 0;
        LeotherasTheBlindGuid = 0;
        LeotherasEventStarterGuid = 0;

        /* Console and Bridge Gameobjects */
        memset(&ConsoleGuids, 0, sizeof(ConsoleGuids));
        BridgeConsoleGuid = 0;
        memset(&BridgePartGuids, 0, sizeof(BridgePartGuids));
     

        Water = WATERSTATE_FRENZY;
        ShieldGeneratorDeactivated[0] = false;
        ShieldGeneratorDeactivated[1] = false;
        ShieldGeneratorDeactivated[2] = false;
        ShieldGeneratorDeactivated[3] = false;
        WaterCheckTimer = 500;
        TrashCheckTimer = 10000;
    }

    void OnObjectCreate(GameObject *go)
    {
        uint32 data = NOT_STARTED;
        switch (go->GetEntry())
        {
            case 185114: // Serpentshrine Console [Hydross the Lurker]
                ConsoleGuids[0] = go->GetGUID();
                data = GetData(DATA_HYDROSS_EVENT);
                if ((data == DONE) || (data == SPECIAL))
                {
                    UnlockGameObject(ConsoleGuids[0]);
                }
                break;
            case 185115: // Serpentshrine Console [The Lurker Below]
                ConsoleGuids[1] = go->GetGUID();
                data = GetData(DATA_LURKER_EVENT);
                if ((data == DONE) || (data == SPECIAL))
                {
                    UnlockGameObject(ConsoleGuids[1]);
                }
                break;
            case 185116: // Serpentshrine Console [Leotheras the Blind]
                ConsoleGuids[2] = go->GetGUID();
                data = GetData(DATA_LEOTHERAS_EVENT);
                if ((data == DONE) || (data == SPECIAL))
                {
                    UnlockGameObject(ConsoleGuids[2]);
                }
                break;
            case 185117: // Serpentshrine Console [Fathom-Lord Karathress]
                ConsoleGuids[3] = go->GetGUID();
                data = GetData(DATA_KARATHRESS_EVENT);
                if ((data == DONE) || (data == SPECIAL))
                {
                    UnlockGameObject(ConsoleGuids[3]);
                }
                break;
            case 185118: // Serpentshrine Console [Morogrim Tidewalker]
                ConsoleGuids[4] = go->GetGUID();
                data = GetData(DATA_MOROGRIM_EVENT);
                if ((data == DONE) || (data == SPECIAL))
                {
                    UnlockGameObject(ConsoleGuids[4]);
                }
                break;
            case 184568: // Lady Vashj Bridge Console
                BridgeConsoleGuid = go->GetGUID();
                if (AllSerpentshrineConsolesActivated())
                {
                    UnlockGameObject(BridgeConsoleGuid); 
                }  
                break;
            case 184203: // Doodad_Coilfang_Raid_Bridge_Part01
                BridgePartGuids[0] = go->GetGUID();
                break;
            case 184204: // Doodad_Coilfang_Raid_Bridge_Part02
                BridgePartGuids[1] = go->GetGUID();
                break;
            case 184205: // Doodad_Coilfang_Raid_Bridge_Part03
                BridgePartGuids[2] = go->GetGUID();
                break;
            case 184956: // Strange Pool
                StrangePoolGuid = go->GetGUID();
                break;
            case GAMEOBJECT_FISHINGNODE_ENTRY: // Fishing Bobber
                if(LurkerFishingEvent == NOT_STARTED)
                {
                    if (Unit *lurker = instance->GetCreature(LurkerBelowGuid))
                    {
                        if (go->GetDistance2d(lurker) > 16.0f)
                        {
                            return;
                        }
                        if (LurkerFishingInternalCooldown > 0)
                        {
                            return;
                        }

                        Player *player = (Player*) go->GetOwner();
                        uint32 FishingLevel = player->GetSkillValue(SKILL_FISHING);

                        if (FishingLevel < 300)
                        {
                            return;
                        }

                        uint32 chance = static_cast<unsigned int>((exp(0.013 * FishingLevel) * 0.1) + 0.5);
                        uint32 rand = urand(1, 100);

                        if (rand <= chance)
                        {   
                            player->TextEmote("casts their lure into the strange pool and disturbs a creature in the shadowy depths below...");
                            SetData(DATA_LURKER_FISHING_EVENT, DONE);
                        }
                        else
                        {
                            player->TextEmote("casts their lure into the strange pool expectantly.");
                        }
                        LurkerFishingInternalCooldown = LURKER_FISHING_INTERNAL_COOLDOWN;
                    }
                }
                break;
        }
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        switch(creature_entry)
        {
            case 21212:
                LadyVashjGuid = creature->GetGUID();
                break;
            case 21214:
                KarathressGuid = creature->GetGUID();
                break;
            case 21966:
                SharkkisGuid = creature->GetGUID();
                break;
            case 21217:
                LurkerBelowGuid = creature->GetGUID();
                break;
            case 21965:
                TidalvessGuid = creature->GetGUID();
                break;
            case 21964:
                CaribdisGuid = creature->GetGUID();
                break;
            case 21215:
                LeotherasTheBlindGuid = creature->GetGUID();
                break;
        }
        HandleInitCreatureState(creature);
    }

    void OpenDoor(uint64 DoorGUID, bool open)
    {
        if (GameObject *Door = instance->GetGameObject(DoorGUID))
        {
            Door->SetUInt32Value(GAMEOBJECT_STATE, open ? 0 : 1);
        }
    }

    void UnlockGameObject(uint64 GameObjectGUID)
    {
        if (GameObject *go = instance->GetGameObject(GameObjectGUID)) 
        {
            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
        }
    }
    
    bool AllSerpentshrineConsolesActivated()
    {
        return ((GetData(DATA_HYDROSS_EVENT) == SPECIAL) &&
                (GetData(DATA_LURKER_EVENT) == SPECIAL) &&
                (GetData(DATA_LEOTHERAS_EVENT) == SPECIAL) &&
                (GetData(DATA_KARATHRESS_EVENT) == SPECIAL) &&
                (GetData(DATA_MOROGRIM_EVENT) == SPECIAL));
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
            case DATA_HYDROSS_EVENT:
                Encounters[0] = data;
                if (data == DONE)
                {
                    UnlockGameObject(ConsoleGuids[0]);           
                }
                if ((data == SPECIAL) && (AllSerpentshrineConsolesActivated()))
                {
                    UnlockGameObject(BridgeConsoleGuid); 
                }     
                break;
            case DATA_LURKER_EVENT:
                Encounters[1] = data;
                if (data == DONE)
                {
                    UnlockGameObject(ConsoleGuids[1]);           
                }
                if ((data == SPECIAL) && (AllSerpentshrineConsolesActivated()))
                {
                    UnlockGameObject(BridgeConsoleGuid); 
                }     
                break;
            case DATA_LEOTHERAS_EVENT:
                Encounters[2] = data;
                if (data == DONE)
                {
                    UnlockGameObject(ConsoleGuids[2]);           
                }
                if ((data == SPECIAL) && (AllSerpentshrineConsolesActivated()))
                {
                    UnlockGameObject(BridgeConsoleGuid); 
                }     
                break;
            case DATA_KARATHRESS_EVENT:
                Encounters[3] = data;
                if (data == DONE)
                {
                    UnlockGameObject(ConsoleGuids[3]);           
                }
                if ((data == SPECIAL) && (AllSerpentshrineConsolesActivated()))
                {
                    UnlockGameObject(BridgeConsoleGuid); 
                }     
                break;
            case DATA_MOROGRIM_EVENT:
                Encounters[4] = data;
                if (data == DONE)
                {
                    UnlockGameObject(ConsoleGuids[4]);           
                }
                if ((data == SPECIAL) && (AllSerpentshrineConsolesActivated()))
                {
                    UnlockGameObject(BridgeConsoleGuid); 
                }     
                break;
            case DATA_VASHJ_EVENT:
                Encounters[5] = data;
                if(data == NOT_STARTED)
                {
                    ShieldGeneratorDeactivated[0] = false;
                    ShieldGeneratorDeactivated[1] = false;
                    ShieldGeneratorDeactivated[2] = false;
                    ShieldGeneratorDeactivated[3] = false;
                }
                break;
            case DATA_SHIELD_GENERATOR_ONE:
                ShieldGeneratorDeactivated[0] = (data) ? true : false; break;
            case DATA_SHIELD_GENERATOR_TWO:
                ShieldGeneratorDeactivated[1] = (data) ? true : false; break;
            case DATA_SHIELD_GENERATOR_THREE:
                ShieldGeneratorDeactivated[2] = (data) ? true : false; break;
            case DATA_SHIELD_GENERATOR_FOUR:
                ShieldGeneratorDeactivated[3] = (data) ? true : false; break;
            case DATA_BRIDGE_CONSOLE:
                OpenDoor(BridgeConsoleGuid, true);
                OpenDoor(BridgePartGuids[0], true);
                OpenDoor(BridgePartGuids[1], true);
                OpenDoor(BridgePartGuids[2], true);
                break;
            case DATA_LURKER_FISHING_EVENT:
                LurkerFishingEvent = data;
                break;
        }

        if (data == DONE || data == SPECIAL)
        {
            SaveToDB();
        }
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case DATA_HYDROSS_EVENT:
                return Encounters[0];
            case DATA_LURKER_EVENT:
                return Encounters[1];
            case DATA_LEOTHERAS_EVENT:
                return Encounters[2];
            case DATA_KARATHRESS_EVENT:
                return Encounters[3];
            case DATA_MOROGRIM_EVENT:
                return Encounters[4];
            case DATA_VASHJ_EVENT:
                return Encounters[5];
            case DATA_SHIELD_GENERATOR_ONE:
                return ShieldGeneratorDeactivated[0];
            case DATA_SHIELD_GENERATOR_TWO:
                return ShieldGeneratorDeactivated[1];
            case DATA_SHIELD_GENERATOR_THREE:
                return ShieldGeneratorDeactivated[2];
            case DATA_SHIELD_GENERATOR_FOUR:
                return ShieldGeneratorDeactivated[3];
            case DATA_LURKER_FISHING_EVENT:
                return LurkerFishingEvent;
            case DATA_CAN_START_PHASE_3:
                if (ShieldGeneratorDeactivated[0] && ShieldGeneratorDeactivated[1] && ShieldGeneratorDeactivated[2] && ShieldGeneratorDeactivated[3])
                {
                    return 1;
                }
            default:
                return 0;
        }
    }

    void SetData64(uint32 type, uint64 data)
    {
        switch(type)
        {
            case DATA_KARATHRESS_EVENT_STARTER:
                KarathressEventStarterGuid = data;
                break;
            case DATA_LEOTHERAS_EVENT_STARTER:
                LeotherasEventStarterGuid = data;
                break;
            case DATA_SHARKKIS_PET:
                SharkkisPetGuid = data;
                break;
        }
    }

    uint64 GetData64(uint32 type)
    {
        switch(type)
        {
            case DATA_LURKER:
                return LurkerBelowGuid;
            case DATA_LEOTHERAS:
                return LeotherasTheBlindGuid;
            case DATA_KARATHRESS:
                return KarathressGuid;
            case DATA_VASHJ:
                return LadyVashjGuid;
            case DATA_SHARKKIS:
                return SharkkisGuid;
            case DATA_TIDALVESS:
                return TidalvessGuid;
            case DATA_CARIBDIS:
                return CaribdisGuid;
            case DATA_SHARKKIS_PET:
                return SharkkisPetGuid;
            case DATA_LEOTHERAS_EVENT_STARTER:
                return LeotherasEventStarterGuid;
            case DATA_KARATHRESS_EVENT_STARTER:
                return KarathressEventStarterGuid;
            default:
                return 0;
        }
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
        if (!in)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }

        OUT_LOAD_INST_DATA(in);
        std::istringstream stream(in);
        stream >> Encounters[0] >> Encounters[1] >> Encounters[2] >> Encounters[3]
        >> Encounters[4] >> Encounters[5];

        for(uint8 i = 0; i < sizeof(Encounters); ++i)
        {
            if (Encounters[i] == IN_PROGRESS) // Do not load an encounter as "In Progress" - reset it instead.
            {
                Encounters[i] = NOT_STARTED;
            }
        }

        OUT_LOAD_INST_DATA_COMPLETE;
    }

    void Update(uint32 diff)
    {
        // If time left on LurkerFishingInternalCooldown is less than the update diff (usually 100ms~)
        // Then set it to 0, allowing further fishing
        // Else lower it closer to 0
        if (LurkerFishingInternalCooldown < diff)
        {
            LurkerFishingInternalCooldown = 0;
        }
        else
        {
            LurkerFishingInternalCooldown -= diff;
        }

        // If time left on TrashCheckTimer is less than the update diff (usually 100ms~)
        if (TrashCheckTimer < diff)
        {
            // If Lurker has not been started
            if (Encounters[1] == NOT_STARTED)
            {
                // If there are no Technicians alive
                // Then make the water scalding
                // Else make the water frenzied
                uint64 GreyheartTechnicianGuid = instance->GetCreatureGUID(MOB_GREYHEART_TECHNICIAN, GET_ALIVE_CREATURE_GUID);
                if (!GreyheartTechnicianGuid)
                    Water = WATERSTATE_SCALDING;
                else
                    Water = WATERSTATE_FRENZY;
            }
            // If Lurker has been completed
            // Then make the water normal
            else if ((Encounters[1] == DONE) || (Encounters[1] == SPECIAL))
            {
                Water = WATERSTATE_NONE;
            }
            TrashCheckTimer = 2000;
        }
        else
        {
            TrashCheckTimer -= diff;
        }

        // If time left on WaterCheckTimer is less than the update diff (usually 100ms~)
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
                                if (Creature* frenzy = pPlayer->SummonCreature(
                                        MOB_COILFANG_FRENZY,
                                        pPlayer->GetPositionX(),
                                        pPlayer->GetPositionY(),pPlayer->GetPositionZ(),
                                        pPlayer->GetOrientation(),
                                        TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,2000))
                                {
                                    frenzy->AddUnitMovementFlag(MOVEFLAG_SWIMMING);                                    
                                    frenzy->AI()->AttackStart(pPlayer);
                                }
                        }
                        else if (Water == WATERSTATE_NONE)
                        {
                            break;
                        }
                    }
                }
            }            
            WaterCheckTimer = 1500;
        }
        else
        {
            WaterCheckTimer -= diff;
        }

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

    newscript = new Script;
    newscript->Name="GOUse_go_vashj_console_access_panel";
    newscript->pGOUse = &GOUse_go_vashj_console_access_panel;
    newscript->RegisterSelf();
}
