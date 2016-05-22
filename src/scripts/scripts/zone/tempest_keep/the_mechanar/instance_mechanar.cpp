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
SDName: Instance_Mechanar
SD%Complete: 99
SDComment:
SDCategory: Mechanar
EndScriptData */

#include "precompiled.h"
#include "def_mechanar.h"

#define ENCOUNTERS      6

#define GO_MOARGDOOR1           184632
#define GO_MOARGDOOR2           184322
#define GO_NETHERMANCERDOOR     184449

#define NPC_IRONHAND            19710
#define NPC_GYROKILL            19218
#define NPC_PATHALEON           19220

#define NPC_ASTROMAGE           19168
#define NPC_PHYSICIAN           20990
#define NPC_CENTURION           19510
#define NPC_ENGINEER            20988
#define NPC_NETHERBINDER        20059
#define NPC_FORGE_DESTROYER     19735

#define MAX_BRIDGE_LOCATIONS    6
#define MAX_BRIDGE_TRASH        4

#define SPELL_ETHEREAL_TELEPORT 34427

#define SAY_PATHALEON_INTRO     -1554028


struct SpawnLocation
{
    uint32 m_uiSpawnEntry;
    float x, y, z, o;
};

static const SpawnLocation BridgeEventLocs[MAX_BRIDGE_LOCATIONS][4] =
{
    {
        {NPC_ASTROMAGE, 243.9323f, -24.53621f, 26.3284f, 0},
        {NPC_ASTROMAGE, 240.5847f, -21.25438f, 26.3284f, 0},
        {NPC_PHYSICIAN, 238.4178f, -25.92982f, 26.3284f, 0},
        {NPC_CENTURION, 237.1122f, -19.14261f, 26.3284f, 0},
    },
    {
        {NPC_FORGE_DESTROYER, 199.945f, -22.85885f, 24.95783f, 0},
        {0, 0, 0, 0, 0},
    },
    {
        {NPC_ENGINEER, 179.8642f, -25.84609f, 24.8745f, 0},
        {NPC_ENGINEER, 181.9983f, -17.56084f, 24.8745f, 0},
        {NPC_PHYSICIAN, 183.4078f, -22.46612f, 24.8745f, 0},
        {0, 0, 0, 0, 0},
    },
    {
        {NPC_ENGINEER, 141.0496f, 37.86048f, 24.87399f, 4.65f},
        {NPC_ASTROMAGE, 137.6626f, 34.89631f, 24.8742f, 4.65f},
        {NPC_PHYSICIAN, 135.3587f, 38.03816f, 24.87417f, 4.65f},
        {0, 0, 0, 0, 0},
    },
    {
        {NPC_FORGE_DESTROYER, 137.8275f, 53.18128f, 24.95783f, 4.65f},
        {0, 0, 0, 0, 0},
    },
    {
        {NPC_PHYSICIAN, 134.3062f, 109.1506f, 26.45663f, 4.65f},
        {NPC_ASTROMAGE, 135.3307f, 99.96439f, 26.45663f, 4.65f},
        {NPC_NETHERBINDER, 141.3976f, 102.7863f, 26.45663f, 4.65f},
        {NPC_ENGINEER, 140.8281f, 112.0363f, 26.45663f, 4.65f},
    },
};

struct instance_mechanar : public ScriptedInstance
{
    instance_mechanar(Map *map) : ScriptedInstance(map) {Initialize();};

    bool Heroic;
    uint32 Encounters[ENCOUNTERS];
    uint64 MoargDoor1;
    uint64 MoargDoor2;
    uint64 NethermancerDoor;
    uint64 PathaleonGUID;
    uint32 CheckTimer;
    bool CleanupCharges;
    uint32 BridgeEventTimer;
    uint32 EventTimer;
    uint8 BridgeEventPhase;

    std::list<uint64> BridgeTrashGuidList;

    void Initialize()
    {
        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            Encounters[i] = NOT_STARTED;

        Heroic = instance->IsHeroic();
        MoargDoor1 = 0;
        MoargDoor2 = 0;
        NethermancerDoor = 0;
        PathaleonGUID = 0;
        CheckTimer = 3000;
        CleanupCharges = false;
        BridgeEventTimer = 0;
        BridgeEventPhase = 0;
        EventTimer = 0;
        BridgeTrashGuidList.clear();
    }

    bool IsEncounterInProgress() const
    {
        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if(Encounters[i] == IN_PROGRESS)
                return true;

        return false;
    }

    void OnCreatureCreate (Creature *creature, uint32 creature_entry)
    {
        switch (creature->GetEntry())
        {
            case NPC_PATHALEON: PathaleonGUID = creature->GetGUID(); break;
        }
    }

    void OnObjectCreate(GameObject* go)
    {
        switch(go->GetEntry())
        {
            case GO_MOARGDOOR1:
                MoargDoor1 = go->GetGUID();
                if(GetData(DATA_IRONHAND_EVENT) == DONE)
                    HandleGameObject(0, true, go);
                break;
            case GO_MOARGDOOR2:
                MoargDoor2 = go->GetGUID();
                if(GetData(DATA_GYROKILL_EVENT) == DONE)
                    HandleGameObject(0, true, go);
                break;
            case GO_NETHERMANCERDOOR:
                NethermancerDoor = go->GetGUID();
                HandleGameObject(0, true, go);
                break;
        }
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
        case DATA_NETHERMANCER_EVENT:       return Encounters[0];
        case DATA_IRONHAND_EVENT:           return Encounters[1];
        case DATA_GYROKILL_EVENT:           return Encounters[2];
        case DATA_CACHE_OF_LEGION_EVENT:    return Encounters[3];
        case DATA_MECHANO_LORD_EVENT:       return Encounters[4];
        case DATA_BRIDGE_EVENT:             return Encounters[5];
        }

        return false;
    }

    uint64 GetData64 (uint32 identifier)
    {
        return 0;
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
            case DATA_NETHERMANCER_EVENT:
                if (data == DONE)
                    BridgeEventTimer = 10000;

                if(Encounters[0] != DONE)
                {
                    Encounters[0] = data;
                    if(data == IN_PROGRESS)
                        HandleGameObject(NethermancerDoor, false);
                    else
                        HandleGameObject(NethermancerDoor, true);
                }
                break;
            case DATA_IRONHAND_EVENT:
                if(Encounters[1] != DONE)
                {
                    Encounters[1] = data;
                    if(data == DONE)
                        HandleGameObject(MoargDoor1, true);
                }
                break;
            case DATA_GYROKILL_EVENT:
                if(Encounters[2] != DONE)
                {
                    Encounters[2] = data;
                    if(data == DONE)
                        HandleGameObject(MoargDoor2, true);
                }
                break;
            case DATA_CACHE_OF_LEGION_EVENT:
                if(Encounters[3] != DONE)
                    Encounters[3] = data;
                break;
            case DATA_MECHANO_LORD_EVENT:
                if(Encounters[4] != DONE)
                    Encounters[4] = data;
                if(data == DONE)
                    CleanupCharges = true;
                break;
            case DATA_BRIDGE_EVENT:
                if(Encounters[5] != DONE)
                    Encounters[5] = data;
                break;
        }
        if(data == DONE)
            SaveToDB();
    }

    void DoSpawnBridgeWave()
    {
        if (BridgeEventPhase > MAX_BRIDGE_LOCATIONS)
            return;
        if (Player* player = instance->GetPlayers().begin()->getSource())
        {
            switch (BridgeEventPhase)
            {
                case 0:
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                    for (uint8 i = 0; i < MAX_BRIDGE_TRASH; ++i)
                    {
                        if (BridgeEventLocs[BridgeEventPhase][i].m_uiSpawnEntry == 0)
                            break;

                        if (Creature* temp = player->SummonCreature(BridgeEventLocs[BridgeEventPhase][i].m_uiSpawnEntry, BridgeEventLocs[BridgeEventPhase][i].x, BridgeEventLocs[BridgeEventPhase][i].y, BridgeEventLocs[BridgeEventPhase][i].z, BridgeEventLocs[BridgeEventPhase][i].o, TEMPSUMMON_DEAD_DESPAWN, 0))
                        {
                            BridgeTrashGuidList.push_back(temp->GetGUID());
                            temp->CastSpell(temp, SPELL_ETHEREAL_TELEPORT, false);

                            switch (BridgeEventPhase)
                            {
                                case 1:
                                case 2:
                                case 3:
                                case 4:
                                case 5:
                                    if (player->isAlive())
                                        temp->AI()->AttackStart(player);
                                    break;
                            }
                        }
                    }
                    break;
                case 6:
                    if (Creature* Pathaleon = instance->GetCreature(PathaleonGUID))
                    {
                        Pathaleon->SetVisibility(VISIBILITY_ON);
                        Pathaleon->SetReactState(REACT_AGGRESSIVE);
                        Pathaleon->CastSpell(Pathaleon, SPELL_ETHEREAL_TELEPORT, false);
                        DoScriptText(SAY_PATHALEON_INTRO, Pathaleon, player);
                        BridgeEventTimer = 0;
                        EventTimer = 0;
                    }
                    break;
            }
            ++BridgeEventPhase;
        }
        
    }

    void Update(uint32 diff)
    {
        if(Heroic && GetData(DATA_MECHANO_LORD_EVENT) == IN_PROGRESS)
        {
            if(CheckTimer < diff)
            {
                const Map::PlayerList& players = instance->GetPlayers();
                for(Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
                {
                    Player *sourcePlayer = i->getSource();
                    if(sourcePlayer->isGameMaster())
                        continue;

                    sourcePlayer->RemoveAurasDueToSpell(39089);
                    sourcePlayer->RemoveAurasDueToSpell(39092);

                    int chargeid = GET_CHARGE_ID(sourcePlayer);
                    if(!chargeid)
                        continue;
                    int counter = 0;
                    for(Map::PlayerList::const_iterator j = players.begin(); j != players.end(); ++j)
                    {
                        Player *checkPlayer = j->getSource();
                        if(checkPlayer->isGameMaster() || sourcePlayer == checkPlayer)
                            continue;

                        if(chargeid == GET_CHARGE_ID(checkPlayer) && sourcePlayer->IsWithinDist(checkPlayer, 10))
                            counter++;
                    }
                    while(counter--)
                        sourcePlayer->CastSpell(sourcePlayer, chargeid == 1 ? 39089 : 39092, true);
                }

                CheckTimer = 3000;
            } else
                CheckTimer -= diff;
        }
        if(Heroic && CleanupCharges)
        {
            const Map::PlayerList& players = instance->GetPlayers();
            for(Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
            {
                Player *sourcePlayer = i->getSource();
                if(sourcePlayer->isGameMaster())
                    continue;

                sourcePlayer->RemoveAurasDueToSpell(39089);
                sourcePlayer->RemoveAurasDueToSpell(39092);
            }
            CleanupCharges = false;
        }

        if (BridgeEventTimer)
        {
            if (BridgeEventTimer <= diff)
            {
                DoSpawnBridgeWave();
                BridgeEventTimer = 0;
                EventTimer = 2000;

                if (GetData(DATA_BRIDGE_EVENT) != DONE)
                    SetData(DATA_BRIDGE_EVENT, DONE);
            }
            else
                BridgeEventTimer -= diff;
        }

        if (EventTimer)
        {
            if (EventTimer <= diff)
            {
                bool alive = false;
                for (std::list<uint64>::iterator itr = BridgeTrashGuidList.begin(); itr != BridgeTrashGuidList.end(); ++itr)
                {
                    if (Creature *tmp = instance->GetCreature(*itr))
                    {
                        if (tmp->isAlive())
                        {
                            alive = true;
                            break;
                        }
                    }
                }

                EventTimer = 2000;

                if (!alive)
                {
                    if (BridgeEventPhase == 3)
                    {
                        BridgeEventTimer = 10000;
                        EventTimer = 0;
                        return;
                    }
                    else
                        DoSpawnBridgeWave();
                }

            }
            else
                EventTimer -= diff;
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
        if(!in)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }
        OUT_LOAD_INST_DATA(in);

        std::istringstream stream(in);
        stream >> Encounters[0] >> Encounters[1] >>  Encounters[2] >>  Encounters[3] >>  Encounters[4] >> Encounters[5];

        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if(Encounters[i] == IN_PROGRESS)
                Encounters[i] = NOT_STARTED;

        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_mechanar(Map* map)
{
    return new instance_mechanar(map);
}

bool GOUse_go_cache_of_the_legion(Player *player, GameObject* _GO)
{
    Map* m = player->GetMap();
    if (!m->IsHeroic())
        return false;

    if (ScriptedInstance* pInstance = (_GO->GetInstanceData()))
    {
        if (pInstance->GetData(DATA_CACHE_OF_LEGION_EVENT) == NOT_STARTED)
        {
            const Map::PlayerList& players = _GO->GetMap()->GetPlayers();

            for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
            {
                Player *player = i->getSource();
                if (player->isGameMaster())
                    continue;

                ItemPosCountVec dest;
                uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 29434, 1);
                if (msg == EQUIP_ERR_OK )
                {
                    Item* item = player->StoreNewItem(dest,29434,true);
                    if (item)
                        player->SendNewItem(item,1,false,true);
                    else
                        player->SendEquipError(msg,NULL,NULL);
                }
            }

            ((InstanceMap*)m)->PermBindAllPlayers(player);
            pInstance->SetData(DATA_CACHE_OF_LEGION_EVENT, DONE);
            return false;
        }
    }
    return true;
}

void AddSC_instance_mechanar()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_mechanar";
    newscript->GetInstanceData = &GetInstanceData_instance_mechanar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_cache_of_the_legion";
    newscript->pGOUse = &GOUse_go_cache_of_the_legion;
    newscript->RegisterSelf();
}
