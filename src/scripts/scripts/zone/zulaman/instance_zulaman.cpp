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
SDName: instance_zulaman
SD%Complete: 80
SDComment:
SDCategory: Zul'Aman
EndScriptData */

#include "precompiled.h"
#include "def_zulaman.h"

#define ENCOUNTERS     8
#define RAND_VENDOR    2

SHostageInfo HostageInfo[] =
{
    {23790, 24442, 187377, 186648, -146, 1347, 48, 6.17}, // bear - Tanzar
    {23999, 24443, 187378, 187021, 408, 1488, 81.65, 4.49}, // eagle - Harkor
    {24024, 24444, 187379, 186667, -90, 1154, 6, 5.9}, // dragonhawk - Kraz
    {24001, 24441, 187380, 186672, 337, 1087,  6.34, 3.1}  // lynx - Ashli
};


struct instance_zulaman : public ScriptedInstance
{
    instance_zulaman(Map *map) : ScriptedInstance(map) {Initialize();};


    uint64 StrangeGongGUID;

    uint64 MassiveGateGUID;
    uint64 AkilzonDoorGUID;
    uint64 HalazziEntranceDoorGUID;
    uint64 HalazziExitDoorGUID;
    uint64 HexLordEntranceGateGUID;
    uint64 HexLordExitGateGUID;
    uint64 ZulJinDoorGUID;

    uint64 AkilzonFlameGUID;
    uint64 NalorakkFlameGUID;
    uint64 JanalaiFlameGUID;
    uint64 HalazziFlameGUID;

    uint64 HarrisonGUID;
    uint64 AkilzonGUID;
    uint64 HexLordGUID;
    uint64 ZulJinGUID;

    uint32 QuestTimer;
    uint16 BossKilled;
    uint16 QuestMinute;
    uint16 ChestLooted;
    bool EventDone;
    uint32 AkilzonGauntlet;

    uint32 Hostages[4];
    uint64 HostagesGUID[4];
    uint64 RewardsGUID[4];


    uint32 Encounters[ENCOUNTERS];
    uint32 RandVendor[RAND_VENDOR];

    void Initialize()
    {
        StrangeGongGUID = 0;

        MassiveGateGUID = 0;
        AkilzonDoorGUID = 0;
        HalazziEntranceDoorGUID = 0;
        HalazziExitDoorGUID = 0;
        HexLordEntranceGateGUID= 0;
        HexLordExitGateGUID = 0;
        ZulJinDoorGUID= 0;

        AkilzonFlameGUID = 0;
        NalorakkFlameGUID = 0;
        JanalaiFlameGUID = 0;
        HalazziFlameGUID = 0;

        AkilzonGUID = 0;
        ZulJinGUID = 0;
        HarrisonGUID = 0;
        QuestTimer = 0;
        QuestMinute = 0;
        BossKilled = 0;
        ChestLooted = 0;
        EventDone = false;
        AkilzonGauntlet = 0;

        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounters[i] = NOT_STARTED;
        for(uint8 i = 0; i < RAND_VENDOR; i++)
            RandVendor[i] = NOT_STARTED;
        for(uint8 i = 0; i < 4; i++)
        {
            Hostages[i] = HOSTAGE_NOT_SAVED;
            HostagesGUID[i] = 0;
        }
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
            case 23574:
                return DATA_AKILZONEVENT;
            case 23576:
                return DATA_NALORAKKEVENT;
            case 23578:
                return DATA_JANALAIEVENT;
            case 23577:
                return DATA_HALAZZIEVENT;
            case 24239:
                return DATA_HEXLORDEVENT;
            case 23863:
                return DATA_ZULJINEVENT;
            default:
                return 0;
        }
    }

    void KillHostage(uint8 index)
    {
        if(!HostagesGUID[index])
            return;
        Creature *hostage = (Creature*)(instance->GetUnit(HostagesGUID[index]));
        if(!hostage)
            return;

        WorldLocation wLoc;
        hostage->GetPosition(wLoc);
        Creature *corpse = hostage->SummonCreature(HostageInfo[index].deadnpc, wLoc.coord_x, wLoc.coord_y, wLoc.coord_z, wLoc.orientation, TEMPSUMMON_MANUAL_DESPAWN, 0);
        if(corpse)
        {
            corpse->SetStandState(UNIT_STAND_STATE_DEAD);
            // TODO: add some burn effect
        }
        hostage->Kill(hostage, false);
        hostage->RemoveCorpse();
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        switch(creature_entry)
        {
        case 24375://harrison jones
            HarrisonGUID = creature->GetGUID();
            break;
        case 23574:
            AkilzonGUID = creature->GetGUID();
            break;
        case 23578://janalai
        case 23863://zuljin
            ZulJinGUID = creature->GetGUID();
            break;
        case 23577://halazzi
        case 23576://nalorakk
            break;

        case 24239://hexlord
            HexLordGUID = creature->GetGUID();
            break;
        case 23790: // hostages
        case 23999:
        case 24001:
        case 24024:
            {
                uint8 i = GetHostageIndex(creature_entry);
                HostagesGUID[i] = creature->GetGUID();
                if(Hostages[i] == HOSTAGE_NOT_SAVED && !QuestMinute && Encounters[0] != NOT_STARTED)
                    KillHostage(i);
                if(Hostages[i] >= HOSTAGE_FREED)
                    creature->Relocate(HostageInfo[i].x, HostageInfo[i].y, HostageInfo[i].z, HostageInfo[i].o);
            }
            break;
        default: break;
        }

        HandleInitCreatureState(creature);
    }

    void OnObjectCreate(GameObject *go)
    {
        switch(go->GetEntry())
        {
        case 187359: StrangeGongGUID = go->GetGUID(); break;
        case 186728:
            MassiveGateGUID = go->GetGUID();
            if (Encounters[0] != NOT_STARTED)
                go->SetGoState(GO_STATE_ACTIVE);  //opened
            else
                go->SetGoState(GO_STATE_READY);
            break;
        case 186303:
            HalazziExitDoorGUID = go->GetGUID();
            if(GetData(DATA_HALAZZIEVENT) == DONE)
                go->SetGoState(GO_STATE_ACTIVE);
            break;
        case 186304:
            HalazziEntranceDoorGUID  = go->GetGUID();
            go->SetGoState(GO_STATE_ACTIVE);
            break;

        case 186305:
            HexLordEntranceGateGUID = go->GetGUID();
            break;
        case 186306:
            HexLordExitGateGUID = go->GetGUID();
            break;
        case 186858:
            AkilzonDoorGUID = go->GetGUID();
            go->SetGoState(GO_STATE_ACTIVE);
            break;
        case 186859:
            ZulJinDoorGUID  = go->GetGUID();
            go->SetGoState(GO_STATE_ACTIVE);
            break;
        case 187035:
            AkilzonFlameGUID = go->GetGUID();
            break;
        case 186860:
            NalorakkFlameGUID = go->GetGUID();
            break;
        case 187036:
            JanalaiFlameGUID = go->GetGUID();
            break;
        case 187037:
            HalazziFlameGUID = go->GetGUID();
            break;
        case 187021:
        case 186648:
        case 186672:
        case 186667:
        {
            uint8 i = GetHostageIndex(go->GetEntry());
            RewardsGUID[i] = go->GetGUID();

            if(Hostages[i] & HOSTAGE_CHEST_UNLOCKED)
                go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
            else if(Hostages[i] & HOSTAGE_CHEST_LOOTED)
                go->Delete();
            break;
        }
        case 186622: // Harkor's Loot Box
            if(Hostages[1] >= HOSTAGE_CHEST_UNLOCKED)
                go->Delete();
            break;
        case 186671: // Ashli Vase
            if(Hostages[3] >= HOSTAGE_CHEST_UNLOCKED)
                go->Delete();
            break;
        default: break;

        }
        CheckInstanceStatus();
    }

    void BossJustKilled(uint8 num)
    {
        BossKilled++;
        if(num > 3 || !QuestMinute)
            return;
        Hostages[num] = HOSTAGE_SAVED | BossKilled;
    }

    void CheckInstanceStatus()
    {
        if(BossKilled >= 4)
            HandleGameObject(HexLordEntranceGateGUID, true);

        if(BossKilled >= 5)
            HandleGameObject(HexLordExitGateGUID, true);
    }

    void UpdateWorldState(uint32 field, uint32 value)
    {
        Map::PlayerList const& players = instance->GetPlayers();
        if (!players.isEmpty())
        {
            for(Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* player = itr->getSource())
                    player->SendUpdateWorldState(field, value);
            }
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
        stream << Encounters[5] << " ";
        stream << Encounters[6] << " ";

        stream << BossKilled << " ";
        stream << ChestLooted << " ";
        stream << EventDone << " ";
        stream << QuestMinute << " ";
        stream << Hostages[0] << " ";
        stream << Hostages[1] << " ";
        stream << Hostages[2] << " ";
        stream << Hostages[3];

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
        loadStream >> Encounters[0] >> Encounters[1] >> Encounters[2] >> Encounters[3] >> Encounters[4] >>
            Encounters[5] >> Encounters[6] >> BossKilled >> ChestLooted >> EventDone >> QuestMinute >> Hostages[0] >> Hostages[1] >> Hostages[2] >> Hostages[3];

        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounters[i] == IN_PROGRESS)
                Encounters[i] = NOT_STARTED;

        OUT_LOAD_INST_DATA_COMPLETE;
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
        case TYPE_EVENT_RUN:
            if (data == SPECIAL)
            {
                HandleGameObject(MassiveGateGUID, true);
                QuestMinute = 21;
                UpdateWorldState(WORLD_STATE_COUNTER, QuestMinute);
                UpdateWorldState(WORLD_STATE_ID,1);
                Encounters[0] = data;
            }
            break;
        case DATA_NALORAKKEVENT:
            if (Encounters[1] != DONE)
            {
                Encounters[1] = data;
                if(data == DONE)
                {
                    if(QuestMinute)
                    {
                        QuestMinute += 10;
                        UpdateWorldState(3106, QuestMinute);
                    }
                    BossJustKilled(0);
                    HandleGameObject(NalorakkFlameGUID, true);
                }   
            }
            break;
        case DATA_AKILZONEVENT:
            Encounters[2] = data;
            if (Encounters[2] != DONE)
            {
                if (data == IN_PROGRESS)
                    HandleGameObject(AkilzonDoorGUID, false);
                else if (data == NOT_STARTED)
                    HandleGameObject(AkilzonDoorGUID, true);
            }
            else if (Encounters[2] == DONE)
            if (data == DONE)
            {
                if (QuestMinute)
                {
                    QuestMinute += 10;
                    UpdateWorldState(3106, QuestMinute);
                }
                HandleGameObject(AkilzonDoorGUID, true);
                HandleGameObject(AkilzonFlameGUID, true);
                BossJustKilled(1);
            }
            break;
        case DATA_JANALAIEVENT:
            if (Encounters[3] != DONE)
            {
                Encounters[3] = data;
                if(data == DONE)
                {
                    BossJustKilled(2);
                    HandleGameObject(JanalaiFlameGUID, true);
                }
            }
            break;
        case DATA_HALAZZIEVENT:
            HandleGameObject(HalazziEntranceDoorGUID, data != IN_PROGRESS);
            if (Encounters[4] != DONE)
            {
                Encounters[4] = data;
                if(data == DONE)
                {
                    BossJustKilled(3);
                    HandleGameObject(HalazziExitDoorGUID, true);
                    HandleGameObject(HalazziFlameGUID, true);
                }
            }
            break;
        case DATA_HEXLORDEVENT:
            if(data == IN_PROGRESS)
                HandleGameObject(HexLordEntranceGateGUID, false);

            if (Encounters[5] != DONE)
            {
                Encounters[5] = data;
                if(data == DONE)
                    BossJustKilled(4);
            }

            if(data == NOT_STARTED)
                CheckInstanceStatus();
            break;
        case DATA_ZULJINEVENT:
            Encounters[6] = data;
            if (Encounters[6] != DONE)
            {
                if (data == IN_PROGRESS)
                    HandleGameObject(ZulJinDoorGUID, false);
                else if (data == NOT_STARTED)
                    HandleGameObject(ZulJinDoorGUID, true);
            }
            else if (Encounters[6] == DONE)
                if (data == DONE)
                    HandleGameObject(ZulJinDoorGUID, true);
            break;
        case DATA_CHESTLOOTED:
            ChestLooted++;
            SaveToDB();
            break;
        case DATA_ZJ_EVENT:
            EventDone = true;
            SaveToDB();
            break;
        case TYPE_RAND_VENDOR_1:
            RandVendor[0] = data;
            break;
        case TYPE_RAND_VENDOR_2:
            RandVendor[1] = data;
            break;
        case DATA_AKILZONGAUNTLET:
            AkilzonGauntlet = data;
            break;
        case DATA_HOSTAGE_TANZAR_STATE:
        case DATA_HOSTAGE_HARKOR_STATE:
        case DATA_HOSTAGE_KRAZ_STATE:
        case DATA_HOSTAGE_ASHLI_STATE:
            {
                int i = type - DATA_HOSTAGE_0_STATE;
                Hostages[i] = (Hostages[i] & 0xf) | data;
                SaveToDB();
                break;
            }
        }

        if(data == DONE)
        {
            if(QuestMinute && BossKilled >= 4)
            {
                QuestMinute = 0;
                UpdateWorldState(3104, 0);
            }
            CheckInstanceStatus();
            SaveToDB();
        }
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case TYPE_EVENT_RUN:            return Encounters[0];
            case DATA_NALORAKKEVENT:        return Encounters[1];
            case DATA_AKILZONEVENT:         return Encounters[2];
            case DATA_JANALAIEVENT:         return Encounters[3];
            case DATA_HALAZZIEVENT:         return Encounters[4];
            case DATA_HEXLORDEVENT:         return Encounters[5];
            case DATA_ZULJINEVENT:          return Encounters[6];
            case DATA_CHESTLOOTED:          return ChestLooted;
            case TYPE_RAND_VENDOR_1:        return RandVendor[0];
            case TYPE_RAND_VENDOR_2:        return RandVendor[1];
            case DATA_AKILZONGAUNTLET:      return AkilzonGauntlet;
            case DATA_HOSTAGE_TANZAR_STATE: return Hostages[0];
            case DATA_HOSTAGE_HARKOR_STATE: return Hostages[1];
            case DATA_HOSTAGE_KRAZ_STATE:   return Hostages[2];
            case DATA_HOSTAGE_ASHLI_STATE:  return Hostages[3];
            case DATA_CHEST_TANZAR_REWARD:  return Hostages[0] & 0xf;
            case DATA_CHEST_HARKOR_REWARD:  return Hostages[1] & 0xf;
            case DATA_CHEST_KRAZ_REWARD:    return Hostages[2] & 0xf;
            case DATA_CHEST_ASHLI_REWARD:   return Hostages[3] & 0xf;
            case DATA_ZJ_EVENT:             return EventDone;
            default:                        return 0;
        }
    }

    uint64 GetData64(uint32 data)
    {
        switch(data)
        {
            case DATA_AKILZONEVENT:
                return AkilzonGUID;
                /*
            case DATA_NALORAKKEVENT:
                return NalorakkGUID;
            case DATA_JANALAIEVENT:
                return JanalaiGUID;
            case DATA_HALAZZIEVENT:
                return HalazziGUID;
            case DATA_SPIRIT_LYNX:
                return SpiritLynxGUID;
            case DATA_ZULJINEVENT:
                return ZuljinGUID;
                */
            case DATA_ZULJINEVENT:
                return ZulJinGUID;
            case DATA_HEXLORDEVENT:
                return HexLordGUID;
            case DATA_HARRISON:
                return HarrisonGUID;
            case DATA_GO_GONG:
                return StrangeGongGUID;
            case DATA_GO_ENTRANCE:
                return MassiveGateGUID;
            case DATA_CHEST_TANZAR:     return RewardsGUID[0];
            case DATA_CHEST_HARKOR:     return RewardsGUID[1];
            case DATA_CHEST_KRAZ:       return RewardsGUID[2];
            case DATA_CHEST_ASHLI:      return RewardsGUID[3];
            /*case DATA_GO_MALACRASS_GATE:
                return MalacrassEntranceGUID;*/
        }
        return 0;
    }

    void OnPlayerEnter(Player *player)
    {
        if (QuestMinute)
        {
            player->SendUpdateWorldState(3104, 1);
            player->SendUpdateWorldState(3106, QuestMinute);
        }
    }


    void Update(uint32 diff)
    {
        if(QuestMinute)
        {
            if(QuestTimer < diff)
            {
                QuestMinute--;
                SaveToDB();
                QuestTimer += 60000;
                if(QuestMinute)
                {
                    UpdateWorldState(3104, 1);
                    UpdateWorldState(3106, QuestMinute);
                    if(QuestMinute > 5)
                    {
                        if(rand()%10 == 0)
                        {
                            if(GetData(DATA_NALORAKKEVENT) == NOT_STARTED)
                                DoGlobalScriptText(RAND(SAY_INST_PROGRESS_4, SAY_INST_PROGRESS_5), NALORAKK, instance);
                            else
                                DoGlobalScriptText(RAND(SAY_INST_PROGRESS_1, SAY_INST_PROGRESS_2, SAY_INST_PROGRESS_3), HEXLORD, instance);
                        }
                    }
                    else
                    {
                        int32 textid;
                        if(QuestMinute == 4) textid = SAY_INST_WARN_1;
                        if(QuestMinute == 3) textid = SAY_INST_WARN_2;
                        if(QuestMinute == 2) textid = SAY_INST_WARN_3;
                        if(QuestMinute == 1) textid = SAY_INST_WARN_4;
                        DoGlobalScriptText(textid, HEXLORD, instance);
                    }
                }
                else
                {
                    bool Killed = false;
                    for(uint8 i = 0; i < 4; i++)
                        if(Hostages[i] == HOSTAGE_NOT_SAVED)
                        {
                            KillHostage(i);
                            Killed = true;
                        }
                    if(Killed)
                        DoGlobalScriptText(RAND(SAY_INST_SACRIF1, SAY_INST_SACRIF2), HEXLORD, instance);
                    UpdateWorldState(3104, 0);
                }
            }
            QuestTimer -= diff;
        }
    }
};

InstanceData* GetInstanceData_instance_zulaman(Map* map)
{
    return new instance_zulaman(map);
}

uint8 GetHostageIndex(uint32 entry)
{
    for(uint8 i = 0; i < 4; i++)
        if(entry == HostageInfo[i].npc || entry == HostageInfo[i].go || entry == HostageInfo[i].cage)
            return i;
    return 0;
}

void AddSC_instance_zulaman()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_zulaman";
    newscript->GetInstanceData = &GetInstanceData_instance_zulaman;
    newscript->RegisterSelf();
}

