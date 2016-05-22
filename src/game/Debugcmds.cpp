/*
 * Copyright (C) 2005-2008 MaNGOS <http://www.mangosproject.org/>
 *
 * Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
 *
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
#include <iomanip>

#include "Common.h"
#include "Database/DatabaseEnv.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Player.h"
#include "Opcodes.h"
#include "Chat.h"
#include "Log.h"
#include "Unit.h"
#include "ObjectAccessor.h"
#include "GossipDef.h"
#include "Language.h"
#include "MapManager.h"
#include "BattleGroundMgr.h"
#include <fstream>
#include "ObjectMgr.h"
#include "InstanceData.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"

#define COMMAND_COOLDOWN 2

bool ChatHandler::HandleWPToFileCommand(const char* args)
{
    std::ofstream file;
    file.open("waypoints.txt", std::ios_base::out | std::ios_base::app);
    if (file.fail())
        return false;

    file << "INSERT INTO `waypoint_data` VALUES ('0', '1', '"
         << m_session->GetPlayer()->GetPositionX() << "', '"
         << m_session->GetPlayer()->GetPositionY() << "', '"
         << m_session->GetPlayer()->GetPositionZ() << "', '0', '0', '0', '100', '0');" << std::endl;
    if (*args)
    {
        int dist = atoi((char*)args);
        float x = m_session->GetPlayer()->GetPositionX() + dist*cos(m_session->GetPlayer()->GetOrientation());
        float y = m_session->GetPlayer()->GetPositionY() + dist*sin(m_session->GetPlayer()->GetOrientation());
        float z = m_session->GetPlayer()->GetTerrain()->GetHeight(x, y, m_session->GetPlayer()->GetPositionZ(), false);
        file << "'" << x << "', '" << y << "', '" << z << "'" << std::endl;
    }
    file.close();
    return true;
}

bool ChatHandler::HandleDebugAddFormationToFileCommand(const char* args)
{
    if (!args)
        return false;

    std::fstream file;
    file.open("formations.txt", std::ios_base::app);
    if (file.fail())
        return false;

    uint32 leader = atoi((char*)args);
    uint32 member = 0;
    if (Unit *sel = getSelectedUnit())
        member = ((Creature *)sel)->GetDBTableGUIDLow();

    file << "INSERT INTO `creature_formations` VALUES ('" << leader << "', '" << member << "', '0', '0', '2');" << std::endl;
    file.close();
    return true;
}

bool ChatHandler::HandleRelocateCreatureCommand(const char* args)
{
    if (!args)
        return false;

    std::fstream file;
    file.open("position.txt", std::ios_base::app);
    if (file.fail())
        return false;

    uint32 guid = atoi((char*)args);

    file << "UPDATE `creature` SET `position_x`='" << m_session->GetPlayer()->GetPositionX()
         << "', `position_y`='" << m_session->GetPlayer()->GetPositionY()
         << "', `position_z`='" << m_session->GetPlayer()->GetPositionZ()
         << "' WHERE `guid`='" << guid << "';" << std::endl;
    file.close();
    return true;
}

bool ChatHandler::HandleDebugSendSpellFailCommand(const char* args)
{
    if (!args)
        return false;

    char* px = strtok((char*)args, " ");
    if (!px)
        return false;

    uint8 failnum = (uint8)atoi(px);

    if (!failnum && *px!='0')
        return false;

    char* p1 = strtok(NULL, " ");
    uint8 failarg1 = p1 ? (uint8)atoi(p1) : 0;

    char* p2 = strtok(NULL, " ");
    uint8 failarg2 = p2 ? (uint8)atoi(p2) : 0;

    WorldPacket data(SMSG_CAST_FAILED, 5);
    data << uint32(133);
    data << uint8(failnum);
    if (p1 || p2)
        data << uint32(failarg1);
    if (p2)
        data << uint32(failarg2);

    m_session->SendPacket(&data);

    return true;
}

bool ChatHandler::HandleDebugSendPoiCommand(const char* args)
{
    Player *pPlayer = m_session->GetPlayer();
    Unit* target = getSelectedUnit();
    if (!target)
    {
        SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
        return true;
    }

    if (!args)
        return false;

    char* icon_text = strtok((char*)args, " ");
    char* flags_text = strtok(NULL, " ");
    if (!icon_text || !flags_text)
        return false;

    uint32 icon = atol(icon_text);
    uint32 flags = atol(flags_text);

    sLog.outDetail("Command : POI, NPC = %u, icon = %u flags = %u", target->GetGUIDLow(), icon,flags);
    pPlayer->PlayerTalkClass->SendPointOfInterest(target->GetPositionX(), target->GetPositionY(), Poi_Icon(icon), flags, 30, "Test POI");
    return true;
}

bool ChatHandler::HandleDebugSendEquipErrorCommand(const char* args)
{
    if (!args)
        return false;

    uint8 msg = atoi(args);
    m_session->GetPlayer()->SendEquipError(msg, 0, 0);
    return true;
}

bool ChatHandler::HandleDebugSendSellErrorCommand(const char* args)
{
    if (!args)
        return false;

    uint8 msg = atoi(args);
    m_session->GetPlayer()->SendSellError(msg, 0, 0, 0);
    return true;
}

bool ChatHandler::HandleDebugSendBuyErrorCommand(const char* args)
{
    if (!args)
        return false;

    uint8 msg = atoi(args);
    m_session->GetPlayer()->SendBuyError(msg, 0, 0, 0);
    return true;
}

bool ChatHandler::HandleDebugSendOpcodeCommand(const char* /*args*/)
{
    Unit *unit = getSelectedUnit();
    Player *player = NULL;
    if (!unit || (unit->GetTypeId() != TYPEID_PLAYER))
        player = m_session->GetPlayer();
    else
        player = (Player*)unit;
    if (!unit) unit = player;

    std::ifstream ifs("opcode.txt");
    if (ifs.bad())
        return false;

    uint32 opcode;
    ifs >> opcode;

    WorldPacket data(opcode, 0);

    while (!ifs.eof())
    {
        std::string type;
        ifs >> type;

        if (type == "")
            break;

        if (type == "uint8")
        {
            uint16 val1;
            ifs >> val1;
            data << uint8(val1);
        }
        else if (type == "uint16")
        {
            uint16 val2;
            ifs >> val2;
            data << val2;
        }
        else if (type == "uint32")
        {
            uint32 val3;
            ifs >> val3;
            data << val3;
        }
        else if (type == "uint64")
        {
            uint64 val4;
            ifs >> val4;
            data << val4;
        }
        else if (type == "float")
        {
            float val5;
            ifs >> val5;
            data << val5;
        }
        else if (type == "string")
        {
            std::string val6;
            ifs >> val6;
            data << val6;
        }
        else if (type == "pguid")
        {
            data << unit->GetPackGUID();
        }
        else if (type == "myguid")
        {
            data << player->GetPackGUID();
        }
        else if (type == "pos")
        {
            data << unit->GetPositionX();
            data << unit->GetPositionY();
            data << unit->GetPositionZ();
        }
        else if (type == "mypos")
        {
            data << player->GetPositionX();
            data << player->GetPositionY();
            data << player->GetPositionZ();
        }
        else
        {
            sLog.outDebug("Sending opcode: unknown type '%s'", type.c_str());
            break;
        }
    }
    ifs.close();
    sLog.outDebug("Sending opcode %u", data.GetOpcode());
    data.hexlike();
    ((Player*)unit)->SendPacketToSelf(&data);
    PSendSysMessage(LANG_COMMAND_OPCODESENT, data.GetOpcode(), unit->GetName());
    return true;
}

bool ChatHandler::HandleDebugUpdateWorldStateCommand(const char* args)
{
    char* w = strtok((char*)args, " ");
    char* s = strtok(NULL, " ");

    if (!w || !s)
        return false;

    uint32 world = (uint32)atoi(w);
    uint32 state = (uint32)atoi(s);
    m_session->GetPlayer()->SendUpdateWorldState(world, state);
    return true;
}

bool ChatHandler::HandleDebugPlayCinematicCommand(const char* args)
{
    // USAGE: .debug play cinematic #cinematicid
    // #cinematicid - ID decimal number from CinemaicSequences.dbc (1st column)
    if (!*args)
    {
        SendSysMessage(LANG_BAD_VALUE);
        SetSentErrorMessage(true);
        return false;
    }

    uint32 dwId = atoi((char*)args);

    if (!sCinematicSequencesStore.LookupEntry(dwId))
    {
        PSendSysMessage(LANG_CINEMATIC_NOT_EXIST, dwId);
        SetSentErrorMessage(true);
        return false;
    }

    m_session->GetPlayer()->SendCinematicStart(dwId);
    return true;
}

//Play sound
bool ChatHandler::HandleDebugPlaySoundCommand(const char* args)
{
    // USAGE: .debug playsound #soundid
    // #soundid - ID decimal number from SoundEntries.dbc (1st column)
    if (!*args)
    {
        SendSysMessage(LANG_BAD_VALUE);
        SetSentErrorMessage(true);
        return false;
    }

    uint32 dwSoundId = atoi((char*)args);

    if (!sSoundEntriesStore.LookupEntry(dwSoundId))
    {
        PSendSysMessage(LANG_SOUND_NOT_EXIST, dwSoundId);
        SetSentErrorMessage(true);
        return false;
    }

    Unit* unit = getSelectedUnit();
    if (!unit)
    {
        SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
        SetSentErrorMessage(true);
        return false;
    }

    if (m_session->GetPlayer()->GetSelection())
        unit->PlayDistanceSound(dwSoundId,m_session->GetPlayer());
    else
        unit->PlayDirectSound(dwSoundId,m_session->GetPlayer());

    PSendSysMessage(LANG_YOU_HEAR_SOUND, dwSoundId);
    return true;
}

//Send notification in channel
bool ChatHandler::HandleDebugSendChannelNotifyCommand(const char* args)
{
    if (!args)
        return false;

    const char *name = "test";
    uint8 code = atoi(args);

    WorldPacket data(SMSG_CHANNEL_NOTIFY, (1+10));
    data << code;                                           // notify type
    data << name;                                           // channel name
    data << uint32(0);
    data << uint32(0);
    m_session->SendPacket(&data);
    return true;
}

//Send notification in chat
bool ChatHandler::HandleDebugSendChatMsgCommand(const char* args)
{
    if (!args)
        return false;

    const char *msg = "testtest";
    uint8 type = atoi(args);
    WorldPacket data;
    ChatHandler::FillMessageData(&data, m_session, type, 0, "test", m_session->GetPlayer()->GetGUID(), msg, m_session->GetPlayer());
    m_session->SendPacket(&data);
    return true;
}

bool ChatHandler::HandleDebugSendQuestPartyMsgCommand(const char* args)
{
    uint32 msg = atol((char*)args);
    m_session->GetPlayer()->SendPushToPartyResponse(m_session->GetPlayer(), msg);
    return true;
}

bool ChatHandler::HandleDebugGetLootRecipient(const char* /*args*/)
{
    Creature* target = getSelectedCreature();
    if (!target)
        return false;

    PSendSysMessage("loot recipient: %s", target->hasLootRecipient()?(target->GetLootRecipient()?target->GetLootRecipient()->GetName():"offline"):"no loot recipient");
    return true;
}

bool ChatHandler::HandleDebugSendQuestInvalidMsgCommand(const char* args)
{
    uint32 msg = atol((char*)args);
    m_session->GetPlayer()->SendCanTakeQuestResponse(msg);
    return true;
}

bool ChatHandler::HandleDebugGetItemState(const char* args)
{
    if (!args)
        return false;

    std::string state_str = args;

    ItemUpdateState state = ITEM_UNCHANGED;
    bool list_queue = false, check_all = false;
    if (state_str == "unchanged") state = ITEM_UNCHANGED;
    else if (state_str == "changed") state = ITEM_CHANGED;
    else if (state_str == "new") state = ITEM_NEW;
    else if (state_str == "removed") state = ITEM_REMOVED;
    else if (state_str == "queue") list_queue = true;
    else if (state_str == "check_all") check_all = true;
    else return false;

    Player* player = getSelectedPlayer();
    if (!player) player = m_session->GetPlayer();

    if (!list_queue && !check_all)
    {
        state_str = "The player has the following " + state_str + " items: ";
        SendSysMessage(state_str.c_str());
        for (uint8 i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; i++)
        {
            if (i >= BUYBACK_SLOT_START && i < BUYBACK_SLOT_END)
                continue;

            Item *item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (!item) continue;
            if (!item->IsBag())
            {
                if (item->GetState() == state)
                    PSendSysMessage("bag: 255 slot: %d guid: %d owner: %d", item->GetSlot(), item->GetGUIDLow(), GUID_LOPART(item->GetOwnerGUID()));
            }
            else
            {
                Bag *bag = (Bag*)item;
                for (uint8 j = 0; j < bag->GetBagSize(); ++j)
                {
                    Item* item2 = bag->GetItemByPos(j);
                    if (item2 && item2->GetState() == state)
                        PSendSysMessage("bag: 255 slot: %d guid: %d owner: %d", item2->GetSlot(), item2->GetGUIDLow(), GUID_LOPART(item2->GetOwnerGUID()));
                }
            }
        }
    }

    if (list_queue)
    {
        std::vector<Item *> &updateQueue = player->GetItemUpdateQueue();
        for (size_t i = 0; i < updateQueue.size(); i++)
        {
            Item *item = updateQueue[i];
            if (!item) continue;

            Bag *container = item->GetContainer();
            uint8 bag_slot = container ? container->GetSlot() : uint8(INVENTORY_SLOT_BAG_0);

            std::string st;
            switch (item->GetState())
            {
                case ITEM_UNCHANGED: st = "unchanged"; break;
                case ITEM_CHANGED: st = "changed"; break;
                case ITEM_NEW: st = "new"; break;
                case ITEM_REMOVED: st = "removed"; break;
            }

            PSendSysMessage("bag: %d slot: %d guid: %d - state: %s", bag_slot, item->GetSlot(), item->GetGUIDLow(), st.c_str());
        }
        if (updateQueue.empty())
            PSendSysMessage("updatequeue empty");
    }

    if (check_all)
    {
        bool error = false;
        std::vector<Item *> &updateQueue = player->GetItemUpdateQueue();
        for (uint8 i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; i++)
        {
            if (i >= BUYBACK_SLOT_START && i < BUYBACK_SLOT_END)
                continue;

            Item *item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (!item) continue;

            if (item->GetSlot() != i)
            {
                PSendSysMessage("item at slot %d, guid %d has an incorrect slot value: %d", i, item->GetGUIDLow(), item->GetSlot());
                error = true; continue;
            }

            if (item->GetOwnerGUID() != player->GetGUID())
            {
                PSendSysMessage("for the item at slot %d and itemguid %d, owner's guid (%d) and player's guid (%d) don't match!", item->GetSlot(), item->GetGUIDLow(), GUID_LOPART(item->GetOwnerGUID()), player->GetGUIDLow());
                error = true; continue;
            }

            if (Bag *container = item->GetContainer())
            {
                PSendSysMessage("item at slot: %d guid: %d has a container (slot: %d, guid: %d) but shouldnt!", item->GetSlot(), item->GetGUIDLow(), container->GetSlot(), container->GetGUIDLow());
                error = true; continue;
            }

            if (item->IsInUpdateQueue())
            {
                uint16 qp = item->GetQueuePos();
                if (qp > updateQueue.size())
                {
                    PSendSysMessage("item at slot: %d guid: %d has a queuepos (%d) larger than the update queue size! ", item->GetSlot(), item->GetGUIDLow(), qp);
                    error = true; continue;
                }

                if (updateQueue[qp] == NULL)
                {
                    PSendSysMessage("item at slot: %d guid: %d has a queuepos (%d) that points to NULL in the queue!", item->GetSlot(), item->GetGUIDLow(), qp);
                    error = true; continue;
                }

                if (updateQueue[qp] != item)
                {
                    PSendSysMessage("item at slot: %d guid: %d has has a queuepos (%d) that points to another item in the queue (bag: %d, slot: %d, guid: %d)", item->GetSlot(), item->GetGUIDLow(), qp, updateQueue[qp]->GetBagSlot(), updateQueue[qp]->GetSlot(), updateQueue[qp]->GetGUIDLow());
                    error = true; continue;
                }
            }
            else if (item->GetState() != ITEM_UNCHANGED)
            {
                PSendSysMessage("item at slot: %d guid: %d is not in queue but should be (state: %d)!", item->GetSlot(), item->GetGUIDLow(), item->GetState());
                error = true; continue;
            }

            if (item->IsBag())
            {
                Bag *bag = (Bag*)item;
                for (uint8 j = 0; j < bag->GetBagSize(); ++j)
                {
                    Item* item2 = bag->GetItemByPos(j);
                    if (!item2) continue;

                    if (item2->GetSlot() != j)
                    {
                        PSendSysMessage("the item in bag %d slot %d, guid %d has an incorrect slot value: %d", bag->GetSlot(), j, item2->GetGUIDLow(), item2->GetSlot());
                        error = true; continue;
                    }

                    if (item2->GetOwnerGUID() != player->GetGUID())
                    {
                        PSendSysMessage("for the item in bag %d at slot %d and itemguid %d, owner's guid (%d) and player's guid (%d) don't match!", bag->GetSlot(), item2->GetSlot(), item2->GetGUIDLow(), GUID_LOPART(item2->GetOwnerGUID()), player->GetGUIDLow());
                        error = true; continue;
                    }

                    Bag *container = item2->GetContainer();
                    if (!container)
                    {
                        PSendSysMessage("the item in bag %d at slot %d with guid %d has no container!", bag->GetSlot(), item2->GetSlot(), item2->GetGUIDLow());
                        error = true; continue;
                    }

                    if (container != bag)
                    {
                        PSendSysMessage("the item in bag %d at slot %d with guid %d has a different container(slot %d guid %d)!", bag->GetSlot(), item2->GetSlot(), item2->GetGUIDLow(), container->GetSlot(), container->GetGUIDLow());
                        error = true; continue;
                    }

                    if (item2->IsInUpdateQueue())
                    {
                        uint16 qp = item2->GetQueuePos();
                        if (qp > updateQueue.size())
                        {
                            PSendSysMessage("item in bag: %d at slot: %d guid: %d has a queuepos (%d) larger than the update queue size! ", bag->GetSlot(), item2->GetSlot(), item2->GetGUIDLow(), qp);
                            error = true; continue;
                        }

                        if (updateQueue[qp] == NULL)
                        {
                            PSendSysMessage("item in bag: %d at slot: %d guid: %d has a queuepos (%d) that points to NULL in the queue!", bag->GetSlot(), item2->GetSlot(), item2->GetGUIDLow(), qp);
                            error = true; continue;
                        }

                        if (updateQueue[qp] != item2)
                        {
                            PSendSysMessage("item in bag: %d at slot: %d guid: %d has has a queuepos (%d) that points to another item in the queue (bag: %d, slot: %d, guid: %d)", bag->GetSlot(), item2->GetSlot(), item2->GetGUIDLow(), qp, updateQueue[qp]->GetBagSlot(), updateQueue[qp]->GetSlot(), updateQueue[qp]->GetGUIDLow());
                            error = true; continue;
                        }
                    }
                    else if (item2->GetState() != ITEM_UNCHANGED)
                    {
                        PSendSysMessage("item in bag: %d at slot: %d guid: %d is not in queue but should be (state: %d)!", bag->GetSlot(), item2->GetSlot(), item2->GetGUIDLow(), item2->GetState());
                        error = true; continue;
                    }
                }
            }
        }

        for (size_t i = 0; i < updateQueue.size(); i++)
        {
            Item *item = updateQueue[i];
            if (!item) continue;

            if (item->GetOwnerGUID() != player->GetGUID())
            {
                PSendSysMessage("queue(%d): for the an item (guid %d), the owner's guid (%d) and player's guid (%d) don't match!", i, item->GetGUIDLow(), GUID_LOPART(item->GetOwnerGUID()), player->GetGUIDLow());
                error = true; continue;
            }

            if (item->GetQueuePos() != i)
            {
                PSendSysMessage("queue(%d): for the an item (guid %d), the queuepos doesn't match it's position in the queue!", i, item->GetGUIDLow());
                error = true; continue;
            }

            if (item->GetState() == ITEM_REMOVED) continue;
            Item *test = player->GetItemByPos(item->GetBagSlot(), item->GetSlot());

            if (test == NULL)
            {
                PSendSysMessage("queue(%d): the bag(%d) and slot(%d) values for the item with guid %d are incorrect, the player doesn't have an item at that position!", i, item->GetBagSlot(), item->GetSlot(), item->GetGUIDLow());
                error = true; continue;
            }

            if (test != item)
            {
                PSendSysMessage("queue(%d): the bag(%d) and slot(%d) values for the item with guid %d are incorrect, the item with guid %d is there instead!", i, item->GetBagSlot(), item->GetSlot(), item->GetGUIDLow(), test->GetGUIDLow());
                error = true; continue;
            }
        }
        if (!error)
            SendSysMessage("All OK!");
    }

    return true;
}

bool ChatHandler::HandleDebugArenaCommand(const char * /*args*/)
{
    sBattleGroundMgr.ToggleArenaTesting();
    return true;
}

bool ChatHandler::HandleDebugBattleGroundCommand(const char * /*args*/)
{
    sBattleGroundMgr.ToggleTesting();
    return true;
}
bool ChatHandler::HandleDebugUnitState(const char * /*args*/)
{
    Player* player = m_session->GetPlayer();
    PSendSysMessage("You have state: %u", player->m_state);
    if (player->IsBeingTeleported())
        PSendSysMessage("If You see this line and cannot move please report it");
    return true;
}

bool ChatHandler::HandleDebugThreatList(const char * /*args*/)
{
    Creature* target = getSelectedCreature();
    if (!target || target->isTotem() || target->isPet())
        return false;

    Player *pOwner = m_session->GetPlayer();
    if (!pOwner || pOwner->HasSpellCooldown(COMMAND_COOLDOWN))
        return false;

    uint32 max_count = 0;
    if (!m_session->HasPermissions(PERM_GMT_DEV))
    {
        pOwner->AddSpellCooldown(COMMAND_COOLDOWN, 0, time(NULL) +10);
        max_count = 3;
    }

    std::list<HostilReference*>& tlist = target->getThreatManager().getThreatList();
    std::list<HostilReference*>::iterator itr;
    uint32 cnt = 0;

    PSendSysMessage("Threat list of %s (guid %u)",target->GetName(), target->GetGUIDLow());
    for (itr = tlist.begin(); itr != tlist.end(); ++itr)
    {
        if (max_count &&  cnt > max_count)
            break;

        Unit *unit = (*itr)->getTarget();
        if (!unit)
            continue;

        ++cnt;
        PSendSysMessage("   %u.   %s   (guid %u)  - threat %f",cnt,unit->GetName(), unit->GetGUIDLow(), (*itr)->getThreat());
    }
    SendSysMessage("End of threat list.");
    return true;
}

bool ChatHandler::HandleDebugHostilRefList(const char * /*args*/)
{
    Unit* target = getSelectedUnit();
    if (!target)
        target = m_session->GetPlayer();
    HostilReference* ref = target->getHostilRefManager().getFirst();
    uint32 cnt = 0;
    PSendSysMessage("Hostile reference list of %s (guid %u)",target->GetName(), target->GetGUIDLow());
    while (ref)
    {
        if (Unit* unit = ref->getSource()->getOwner())
        {
            CellPair p = Looking4group::ComputeCellPair(unit->GetPositionX(), unit->GetPositionY());
            uint8 gridstate = unit->GetMap()->getNGrid(Cell(p).GridX(), Cell(p).GridY())->GetGridState();

            ++cnt;
            PSendSysMessage("   %u.   %s   (guid %u)  - threat %f [GridState: %u]",cnt,unit->GetName(), unit->GetGUIDLow(), ref->getThreat(), gridstate);
        }
        ref = ref->next();
    }
    SendSysMessage("End of hostile reference list.");
    return true;
}

bool ChatHandler::HandleDebugSetInstanceDataCommand(const char *args)
{
    if (!args || !m_session->GetPlayer())
        return false;

    InstanceData *pInstance = m_session->GetPlayer()->GetInstanceData();
    if (!pInstance)
    {
        PSendSysMessage("You are not in scripted instance.");
        SetSentErrorMessage(true);
        return false;
    }

    char *id = strtok((char*)args, " ");
    char *data = strtok(NULL, " ");
    char *trash = strtok(NULL, " ");

    if (!id || !data)
        return false;

    uint32 _id = uint32(atoi(id));
    uint32 _data = uint32(atoi(data));

    pInstance->SetData(_id, _data);
    return true;
}

bool ChatHandler::HandleDebugGetInstanceDataCommand(const char *args)
{
    if (!args || !m_session->GetPlayer())
        return false;

    InstanceData *pInstance = m_session->GetPlayer()->GetInstanceData();
    if (!pInstance)
    {
        PSendSysMessage("You are not in scripted instance.");
        SetSentErrorMessage(true);
        return false;
    }

    char *id = strtok((char*)args, " ");
    char *trash = strtok(NULL, " ");

    if (!id)
        return false;

    uint32 _id = uint32(atoi(id));

    PSendSysMessage("Result: %u", pInstance->GetData(_id));
    return true;
}

bool ChatHandler::HandleDebugSetInstanceData64Command(const char *args)
{
    if (!args || !m_session->GetPlayer())
        return false;

    InstanceData *pInstance = m_session->GetPlayer()->GetInstanceData();
    if (!pInstance)
    if (!pInstance)
    {
    PSendSysMessage("You are not in scripted instance.");
        SetSentErrorMessage(true);
      return false;
    }

    char *id = strtok((char*)args, " ");
    char *data = strtok(NULL, " ");
    char *trash = strtok(NULL, " ");

    if (!id || !data)
        return false;

    uint32 _id = uint32(atoi(id));
    uint64 _data = uint64(atoi(data));

    pInstance->SetData64(_id, _data);
    return true;
}

bool ChatHandler::HandleDebugGetInstanceData64Command(const char *args)
{
    if (!args || !m_session->GetPlayer())
        return false;

    InstanceData *pInstance = m_session->GetPlayer()->GetInstanceData();
    if (!pInstance)
    {
        PSendSysMessage("You are not in scripted instance.");
        SetSentErrorMessage(true);
        return false;
    }

    char *id = strtok((char*)args, " ");
    char *trash = strtok(NULL, " ");

    if (!id)
        return false;

    uint32 _id = uint32(atoi(id));

    PSendSysMessage("Result: %u", pInstance->GetData64(_id));
    return true;
}

bool ChatHandler::HandleGetPoolObjectStatsCommand(const char *args)
{
   /* if(!m_session->GetPlayer())
        return false;

    if(!args)
        return false;

    char *sEntry = strtok((char*)args, " ");
    char *sRange = strtok(NULL, " ");

    if(!sEntry || !sRange)
        return false;

    uint32 entry = atoi(sEntry);
    uint32 range = atoi(sRange);

    Map *map = m_session->GetPlayer()->GetMap();

    std::list<GameObject*> pList;
    Looking4group::AllGameObjectsWithEntryInGrid u_check(entry);
    Looking4group::ObjectListSearcher<GameObject, Looking4group::AllGameObjectsWithEntryInGrid> searcher(pList, u_check);
    Cell::VisitAllObjects(m_session->GetPlayer(), searcher, range, false);

    UNORDERED_MAP<uint16, uint32> map_unspawned;
    UNORDERED_MAP<uint16, uint32> map_poolspawned;
    UNORDERED_MAP<uint16, uint32> map_worldspawned;

    for(std::list<GameObject*>::iterator it = pList.begin(); it != pList.end(); it++)
    {
        GameObject *pGO = *it;
        uint16 poolid = poolhandler.IsPartOfAPool(pGO->GetGUIDLow(), TYPEID_GAMEOBJECT);
        bool poolspawned = poolhandler.IsSpawnedObject(poolid, pGO->GetGUIDLow(), TYPEID_GAMEOBJECT);
        bool gospawned = pGO->isSpawned();

        if(poolid && gospawned && !poolspawned)
        {
            PSendSysMessage("Gameobject %u is part of pool %u and is spawned in world but not spawned in pool", pGO->GetGUIDLow(), poolid);
        }
        else
        {
            if(map_unspawned.find(poolid) == map_unspawned.end())
            {
                map_unspawned[poolid] = 0; // .insert(UNORDERED_MAP<unit16, uint32>::mapped_type(poolid, 0));
                map_poolspawned[poolid] = 0; //.insert(UNORDERED_MAP<unit16, uint32>::mapped_type(poolid, 0));
                map_worldspawned[poolid] = 0; //.insert(UNORDERED_MAP<unit16, uint32>::mapped_type(poolid, 0));
            }
            UNORDERED_MAP<uint16, uint32> *mapToAdd = NULL;
            if(gospawned)
                mapToAdd = &map_worldspawned;
            else if(poolspawned)
                mapToAdd = &map_poolspawned;
            else
                mapToAdd = &map_unspawned;
            (*mapToAdd)[poolid]++;
        }
    }

    if(map_unspawned.empty())
        PSendSysMessage("No objects found");
    else
        PSendSysMessage("Poolid | spawned in world | spawned in pool | not spawned");

    for(UNORDERED_MAP<uint16, uint32>::iterator it = map_unspawned.begin(); it != map_unspawned.end(); it++)
    {
        PSendSysMessage("%u | %u | %u | %u", (uint32)(it->first), map_worldspawned.find(it->first)->second, map_poolspawned.find(it->first)->second, it->second);
    }*/
    return true;
}

bool ChatHandler::HandleDebugSetItemFlagCommand(const char* args)
{
    if (!args)
        return false;

    char* e = strtok((char*)args, " ");
    char* f = strtok(NULL, " ");

    if (!e || !f)
        return false;

    uint32 guid = (uint32)atoi(e);
    uint32 flag = (uint32)atoi(f);

    Item *i = m_session->GetPlayer()->GetItemByGuid(MAKE_NEW_GUID(guid, 0, HIGHGUID_ITEM));

    if (!i)
        return false;

    i->SetUInt32Value(ITEM_FIELD_FLAGS, flag);

    return true;
}

//show animation
bool ChatHandler::HandleDebugAnimCommand(const char* args)
{
    if (!*args)
        return false;

    Unit *pTarget = NULL;

    if (m_session->GetPlayer()->GetSelection())
        pTarget = m_session->GetPlayer()->GetMap()->GetUnit(m_session->GetPlayer()->GetSelection());

    if (!pTarget)
        pTarget = m_session->GetPlayer();

    uint32 anim_id = atoi((char*)args);
    pTarget->HandleEmoteCommand(anim_id);
    return true;
}

bool ChatHandler::HandleDebugShowCombatStats(const char* args)
{
    if(!args)
        return false;

    Unit *target = getSelectedUnit();

    if(!target)
        return false;

    if(strcmp(args, "on") == 0)
    {
        target->SetGMToSendCombatStats(m_session->GetPlayer()->GetGUID());
        PSendSysMessage("Combat stats for unit %s (%d) enabled", target->GetName(), target->GetGUID());
    }
    else if(strcmp(args, "off") == 0)
    {
        target->SetGMToSendCombatStats(0);
        PSendSysMessage("Combat stats for unit %s (%d) disabled", target->GetName(), target->GetGUID());
    }
    else
        return false;

    return true;
}
