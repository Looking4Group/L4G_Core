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

#include "Common.h"
#include "WorldPacket.h"
#include "Opcodes.h"
#include "Log.h"
#include "Player.h"
#include "ObjectMgr.h"
#include "WorldSession.h"
#include "World.h"
#include "MapManager.h"
#include "ObjectAccessor.h"
#include "Object.h"
#include "Chat.h"
#include "BattleGroundMgr.h"
#include "BattleGroundWS.h"
#include "BattleGround.h"
#include "ArenaTeam.h"
#include "Language.h"

void WorldSession::HandleBattleGroundHelloOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data, 8);

    uint64 guid;
    recv_data >> guid;
    sLog.outDebug("WORLD: Recvd CMSG_BATTLEMASTER_HELLO Message from: " I64FMT, guid);

    Creature *unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
        return;

    if (!unit->isBattleMaster())                             // it's not battlemaster
        return;

    // Stop the npc if moving
    unit->StopMoving();

    BattleGroundTypeId bgTypeId = sBattleGroundMgr.GetBattleMasterBG(unit->GetEntry());

    if (!_player->GetBGAccessByLevel(bgTypeId))
    {
                                                            // temp, must be gossip message...
        SendNotification(LANG_YOUR_BG_LEVEL_REQ_ERROR);
        return;
    }

    SendBattlegGroundList(ObjectGuid(guid), bgTypeId);
}

void WorldSession::SendBattlegGroundList(ObjectGuid guid, BattleGroundTypeId bgTypeId )
{
    WorldPacket data;
    sBattleGroundMgr.BuildBattleGroundListPacket(&data, guid, _player, bgTypeId);
    SendPacket( &data );
}

void WorldSession::HandleBattleGroundJoinOpcode(WorldPacket & recv_data )
{
    uint64 guid;
    uint32 bgTypeId_;
    uint32 instanceId;
    uint8 joinAsGroup;
    bool isPremade = false;
    Group * grp;

    recv_data >> guid;                                      // battlemaster guid
    recv_data >> bgTypeId_;                                 // battleground type id (DBC id)
    recv_data >> instanceId;                                // instance id, 0 if First Available selected
    recv_data >> joinAsGroup;                               // join as group

    if (!sBattlemasterListStore.LookupEntry(bgTypeId_))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Battleground: invalid bgtype (%u) received. possible cheater? player guid %u",bgTypeId_,_player->GetGUIDLow());
        return;
    }

    BattleGroundTypeId bgTypeId = BattleGroundTypeId(bgTypeId_);

    DEBUG_LOG( "WORLD: Recvd CMSG_BATTLEMASTER_JOIN Message from (GUID: %u TypeId:%u)", GUID_LOPART(guid), GuidHigh2TypeId(GUID_HIPART(guid)));

    // can do this, since it's battleground, not arena
    BattleGroundQueueTypeId bgQueueTypeId = BattleGroundMgr::BGQueueTypeId(bgTypeId, 0);

    // ignore if player is already in BG
    if (_player->InBattleGround())
        return;

    Creature *unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
        return;

    if (!unit->isBattleMaster())                            // it's not battlemaster
        return;

    // get bg instance or bg template if instance not found
    BattleGround *bg = NULL;
    if (instanceId)
        bg = sBattleGroundMgr.GetBattleGround(instanceId, bgTypeId);

    if (!bg && !(bg = sBattleGroundMgr.GetBattleGroundTemplate(bgTypeId)))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Battleground: no available bg / template found");
        return;
    }

    BattleGroundBracketId bgBracketId = _player->GetBattleGroundBracketIdFromLevel(bgTypeId);

    // check queue conditions
    if (!joinAsGroup)
    {
        // check Deserter debuff
        if (!_player->CanJoinToBattleground())
        {
            WorldPacket data(SMSG_GROUP_JOINED_BATTLEGROUND, 4);
            data << (uint32) 0xFFFFFFFE;
            _player->SendPacketToSelf(&data);
            return;
        }
        // check if already in queue
        if (_player->GetBattleGroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES)
            //player is already in this queue
            return;
        // check if has free queue slots
        if (!_player->HasFreeBattleGroundQueueId())
            return;
    }
    else
    {
        grp = _player->GetGroup();
        // no group found, error
        if (!grp)
            return;
        uint32 err = grp->CanJoinBattleGroundQueue(bgTypeId, bgQueueTypeId, 0, bg->GetMaxPlayersPerTeam(), false, 0);
        isPremade = sWorld.getConfig(CONFIG_BATTLEGROUND_PREMADE_GROUP_WAIT_FOR_MATCH) && (grp->GetMembersCount() >= bg->GetMaxPlayersPerTeam()*0.6f);
        if (err != BG_JOIN_ERR_OK)
        {
            SendBattleGroundOrArenaJoinError(err);
            return;
        }
    }
    // if we're here, then the conditions to join a bg are met. We can proceed in joining.

    // _player->GetGroup() was already checked, grp is already initialized
    if (joinAsGroup)
    {
        DEBUG_LOG("Battleground: the following players are joining as group:");
        GroupQueueInfo * ginfo = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].AddGroup(_player, bgTypeId, bgBracketId, 0, false, isPremade, 0, 0);
        for (GroupReference *itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
        {
            Player *member = itr->getSource();
            if (!member) continue;   // this should never happen

            uint32 queueSlot = member->AddBattleGroundQueueId(bgQueueTypeId);           // add to queue

            // store entry point coords (same as leader entry point)
            member->SetBattleGroundEntryPoint(_player->GetMapId(), _player->GetPositionX(), _player->GetPositionY(), _player->GetPositionZ(), _player->GetOrientation());

            WorldPacket data;
                                                            // send status packet (in queue)
            sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg, member->GetTeam(), queueSlot, STATUS_WAIT_QUEUE, 0, 0);
            member->SendPacketToSelf(&data);
            sBattleGroundMgr.BuildGroupJoinedBattlegroundPacket(&data, bgTypeId);
            member->SendPacketToSelf(&data);
            sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].AddPlayer(member, ginfo);
            DEBUG_LOG("Battleground: player joined queue for bg queue type %u bg type %u: GUID %u, NAME %s",bgQueueTypeId,bgTypeId,member->GetGUIDLow(), member->GetName());
        }
        DEBUG_LOG("Battleground: group end");
        sBattleGroundMgr.ScheduleQueueUpdate(bgQueueTypeId, bgTypeId, _player->GetBattleGroundBracketIdFromLevel(bgTypeId));
    }
    else
    {
        // already checked if queueSlot is valid, now just get it
        uint32 queueSlot = _player->AddBattleGroundQueueId(bgQueueTypeId);
        // store entry point coords
        _player->SetBattleGroundEntryPoint(_player->GetMapId(), _player->GetPositionX(), _player->GetPositionY(), _player->GetPositionZ(), _player->GetOrientation());

        WorldPacket data;
                                                            // send status packet (in queue)
        sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg, _player->GetBGTeam(), queueSlot, STATUS_WAIT_QUEUE, 0, 0);
        SendPacket(&data);

        GroupQueueInfo * ginfo = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].AddGroup(_player, bgTypeId, bgBracketId, 0, false, false, 0, 0);
        sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].AddPlayer(_player, ginfo);
        sBattleGroundMgr.ScheduleQueueUpdate(bgQueueTypeId, bgTypeId, _player->GetBattleGroundBracketIdFromLevel(bgTypeId));
        DEBUG_LOG("Battleground: player joined queue for bg queue type %u bg type %u: GUID %u, NAME %s",bgQueueTypeId,bgTypeId,_player->GetGUIDLow(), _player->GetName());
    }

    if (sWorld.getConfig(CONFIG_BATTLEGROUND_QUEUE_INFO))
    {
        uint32 minPlayers = bg->GetMinPlayersPerTeam();
        if (sWorld.getConfig(CONFIG_BG_CROSSFRACTION))
        {
            uint32 queuedTotal = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].GetQueuedPlayersCountCrossfaction(bgBracketId);
            ChatHandler(_player).PSendSysMessage("Player queued: %u, Minimum: %u", queuedTotal, minPlayers*2);
        }
        else
        {
            uint32 queuedHorde = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].GetQueuedPlayersCount(BG_TEAM_HORDE, bgBracketId);
            uint32 queuedAlliance = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].GetQueuedPlayersCount(BG_TEAM_ALLIANCE, bgBracketId);
            ChatHandler(_player).PSendSysMessage("Horde queued: %u, Alliance queued: %u. Minimum per team: %u", queuedHorde, queuedAlliance, minPlayers);
        }
    }
}

void WorldSession::HandleBattleGroundPlayerPositionsOpcode(WorldPacket & /*recv_data*/)
{
                                                            // empty opcode
    sLog.outDebug("WORLD: Recvd MSG_BATTLEGROUND_PLAYER_POSITIONS Message");

    BattleGround *bg = _player->GetBattleGround();
    if (!bg)                                                 // can't be received if player not in battleground
        return;

    if (bg->GetTypeID() == BATTLEGROUND_WS)
    {
        uint32 count1 = 0;
        uint32 count2 = 0;

        Player *ap = sObjectMgr.GetPlayer(((BattleGroundWS*)bg)->GetAllianceFlagPickerGUID());
        if (ap) ++count2;

        Player *hp = sObjectMgr.GetPlayer(((BattleGroundWS*)bg)->GetHordeFlagPickerGUID());
        if (hp) ++count2;

        WorldPacket data(MSG_BATTLEGROUND_PLAYER_POSITIONS, (4+4+16*count1+16*count2));
        data << count1;                                     // alliance flag holders count
        /*for (uint8 i = 0; i < count1; i++)
        {
            data << uint64(0);                              // guid
            data << (float)0;                               // x
            data << (float)0;                               // y
        }*/
        data << count2;                                     // horde flag holders count
        if (ap)
        {
            // Horde team can always track alliance flag picker
            if (_player->GetBGTeam() == HORDE)
            {
                data << (uint64)ap->GetGUID();
                data << (float)ap->GetPositionX();
                data << (float)ap->GetPositionY();
            }

            if (_player->GetBGTeam() == ALLIANCE)
            {
                if (BG_WS_FLAG_UPDATE_TIME < (time(NULL) - ((BattleGroundWS*)bg)->m_AllianceFlagUpdate))
                {
                    data << (uint64)ap->GetGUID();
                    data << (float)ap->GetPositionX();
                    data << (float)ap->GetPositionY();
                }
            }
        }
        if (hp)
        {
            // Alliance team can always track horde flag picker
            if (_player->GetBGTeam() == ALLIANCE)
            {
                data << (uint64)hp->GetGUID();
                data << (float)hp->GetPositionX();
                data << (float)hp->GetPositionY();
            }

            if (_player->GetBGTeam() == HORDE)
            {
                if (BG_WS_FLAG_UPDATE_TIME < (time(NULL) - ((BattleGroundWS*)bg)->m_HordeFlagUpdate))
                {
                    data << (uint64)hp->GetGUID();
                    data << (float)hp->GetPositionX();
                    data << (float)hp->GetPositionY();
                }
            }
        }

        SendPacket(&data);
    }
}

void WorldSession::HandleBattleGroundPVPlogdataOpcode(WorldPacket & /*recv_data*/)
{
    sLog.outDebug("WORLD: Recvd MSG_PVP_LOG_DATA Message");

    BattleGround *bg = _player->GetBattleGround();
    if (!bg || bg->isArena())
        return;

    WorldPacket data;
    sBattleGroundMgr.BuildPvpLogDataPacket(&data, bg);
    SendPacket(&data);

    sLog.outDebug("WORLD: Sent MSG_PVP_LOG_DATA Message");
}

void WorldSession::HandleBattleGroundListOpcode(WorldPacket &recv_data)
{
    CHECK_PACKET_SIZE(recv_data, 4);

    sLog.outDebug("WORLD: Recvd CMSG_BATTLEFIELD_LIST Message");

    uint32 bgTypeId;
    recv_data >> bgTypeId;                                  // id from DBC

    BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(bgTypeId);
    if (!bl)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Battleground: invalid bgtype received.");
        return;
    }

    WorldPacket data;
    sBattleGroundMgr.BuildBattleGroundListPacket(&data, ObjectGuid(_player->GetGUID()), _player, BattleGroundTypeId(bgTypeId));
    SendPacket(&data);
}

void WorldSession::HandleBattleGroundPlayerPortOpcode(WorldPacket &recv_data)
{
    DEBUG_LOG( "WORLD: Recvd CMSG_BATTLEFIELD_PORT Message");

    uint8 type;                                             // arenatype if arena
    uint8 unk2;                                             // unk, can be 0x0 (may be if was invited?) and 0x1
    uint32 instanceId;
    uint32 bgTypeId_;                                       // type id from dbc
    uint16 unk;                                             // 0x1F90 constant?
    uint8 action;                                           // enter battle 0x1, leave queue 0x0

    recv_data >> type >> unk2 >> bgTypeId_ >> unk >> action;

    if (!sBattlemasterListStore.LookupEntry(bgTypeId_))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Battleground: invalid bgtype (%u) received.",bgTypeId_);
        // update battleground slots for the player to fix his UI and sent data.
        // this is a HACK, I don't know why the client starts sending invalid packets in the first place.
        // it usually happens with extremely high latency (if debugging / stepping in the code for example)
        if (_player->InBattleGroundQueue())
        {
            // update all queues, send invitation info if player is invited, queue info if queued
            for (uint32 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
            {
                BattleGroundQueueTypeId bgQueueTypeId = _player->GetBattleGroundQueueTypeId(i);
                if (!bgQueueTypeId)
                    continue;

                BattleGroundTypeId bgTypeId = BattleGroundMgr::BGTemplateId(bgQueueTypeId);
                BattleGroundQueue::QueuedPlayersMap& qpMap = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].m_QueuedPlayers;
                BattleGroundQueue::QueuedPlayersMap::iterator itrPlayerStatus = qpMap.find(_player->GetGUID());
                // if the player is not in queue, continue
                if (itrPlayerStatus == qpMap.end())
                    continue;

                // no group information, this should never happen
                if (!itrPlayerStatus->second.GroupInfo)
                    continue;

                BattleGround * bg = NULL;

                // get possibly needed data from groupinfo
                uint8 arenatype = itrPlayerStatus->second.GroupInfo->ArenaType;
                uint8 israted = itrPlayerStatus->second.GroupInfo->IsRated;
                uint8 status = 0;


                if (!itrPlayerStatus->second.GroupInfo->IsInvitedToBGInstanceGUID)
                {
                    // not invited to bg, get template
                    bg = sBattleGroundMgr.GetBattleGroundTemplate(bgTypeId);
                    status = STATUS_WAIT_QUEUE;
                }
                else
                {
                    // get the bg we're invited to
                    bg = sBattleGroundMgr.GetBattleGround(itrPlayerStatus->second.GroupInfo->IsInvitedToBGInstanceGUID, bgTypeId);
                    status = STATUS_WAIT_JOIN;
                }

                // if bg not found, then continue
                if (!bg)
                    continue;

                // don't invite if already in the instance
                if (_player->InBattleGround() && _player->GetBattleGround() && _player->GetBattleGround()->GetInstanceID() == bg->GetInstanceID())
                    continue;

                // re - invite player with proper data
                WorldPacket data;
                sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg, itrPlayerStatus->second.GroupInfo->Team?itrPlayerStatus->second.GroupInfo->Team:_player->GetBGTeam(), i, status, INVITE_ACCEPT_WAIT_TIME, 0, arenatype, israted);
                SendPacket(&data);
            }
        }
        return;
    }

    BattleGroundTypeId bgTypeId = BattleGroundTypeId(bgTypeId_);

    // get the bg what we were invited to
    BattleGroundQueueTypeId bgQueueTypeId = BattleGroundMgr::BGQueueTypeId(bgTypeId,type);
    BattleGroundQueue::QueuedPlayersMap& qpMap = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].m_QueuedPlayers;
    BattleGroundQueue::QueuedPlayersMap::iterator itrPlayerStatus = qpMap.find(_player->GetGUID());
    if (itrPlayerStatus == qpMap.end())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Battleground: itrplayerstatus not found.");
        return;
    }
    instanceId = itrPlayerStatus->second.GroupInfo->IsInvitedToBGInstanceGUID;

    // if action == 1, then instanceId is _required_
    if (!instanceId && action == 1)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Battleground: instance not found.");
        return;
    }

    BattleGround *bg = sBattleGroundMgr.GetBattleGround(instanceId, bgTypeId);

    // bg template might and must be used in case of leaving queue, when instance is not created yet
    if (!bg && action == 0)
        bg = sBattleGroundMgr.GetBattleGroundTemplate(bgTypeId);
    if (!bg)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: BattlegroundHandler: bg_template not found for type id %u.", bgTypeId);
        return;
    }

    bgTypeId = bg->GetTypeID();

    if (_player->InBattleGroundQueue())
    {
        uint32 queueSlot = 0;
        uint32 team = 0;
        uint32 arenatype = 0;
        uint32 israted = 0;
        uint32 rating = 0;
        uint32 opponentsRating = 0;
        uint32 hiddenRating = 0;

        BattleGroundQueue::QueuedPlayersMap& qpMap2 = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].m_QueuedPlayers;
        BattleGroundQueue::QueuedPlayersMap::iterator pitr = qpMap2.find(_player->GetGUID());
        if (pitr !=qpMap2.end() && pitr->second.GroupInfo)
        {
            team = pitr->second.GroupInfo->Team;
            arenatype = pitr->second.GroupInfo->ArenaType;
            israted = pitr->second.GroupInfo->IsRated;
            rating = pitr->second.GroupInfo->ArenaTeamRating;
            opponentsRating = pitr->second.GroupInfo->OpponentsTeamRating;
            hiddenRating = pitr->second.GroupInfo->OpponentsHiddenRating;
        }
        else
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Battleground: Invalid player queue info!");
            return;
        }

        //if player is trying to enter battleground (not arena!) and he has deserter debuff, we must just remove him from queue
        if (arenatype == 0 && !_player->CanJoinToBattleground())
        {
            sLog.outDebug("Battleground: player %s (%u) has a deserter debuff, do not port him to battleground!", _player->GetName(), _player->GetGUIDLow());
            action = 0;
        }

        WorldPacket data;
        switch (action)
        {
            case 1:                                     // port to battleground
                if (!_player->IsInvitedForBattleGroundQueueType(bgQueueTypeId))
                    return;                                     // cheating?
                // resurrect the player
                if (!_player->isAlive())
                {
                    _player->ResurrectPlayer(1.0f);
                    _player->SpawnCorpseBones();
                }
                // stop taxi flight at port
                _player->InterruptTaxiFlying();

                queueSlot = _player->GetBattleGroundQueueIndex(bgQueueTypeId);
                sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg, _player->GetBGTeam(), queueSlot, STATUS_IN_PROGRESS, 0, bg->GetStartTime());
                _player->SendPacketToSelf(&data);
                // remove battleground queue status from BGmgr
                sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].RemovePlayer(_player->GetGUID(), false);
                // this is still needed here if battleground "jumping" shouldn't add deserter debuff
                // also this required to prevent stuck at old battleground after SetBattleGroundId set to new
                if ( BattleGround *currentBg = _player->GetBattleGround() )
                    currentBg->RemovePlayerAtLeave(_player->GetGUID(), false, true);

                // set the destination instance id
                _player->SetBattleGroundId(bg->GetInstanceID(), bgTypeId);
                // set the destination team
                _player->SetBGTeam(team);

                sBattleGroundMgr.SendToBattleGround(_player, instanceId, bgTypeId);
                // add only in HandleMoveWorldPortAck()
                // bg->AddPlayer(_player,team);
                DEBUG_LOG("Battleground: player %s (%u) joined battle for bg %u, bgtype %u, queue type %u.",_player->GetName(),_player->GetGUIDLow(),bg->GetInstanceID(),bg->GetTypeID(),bgQueueTypeId);
                break;
            case 0:                                         // leave queue
                queueSlot = _player->GetBattleGroundQueueIndex(bgQueueTypeId);
                /*
                if player leaves rated arena match before match start, it is counted as he played but he lost
                */
                if (israted)
                {
                    ArenaTeam * at = sObjectMgr.GetArenaTeamById(team);
                    if (at)
                    {
                        DEBUG_LOG("UPDATING memberLost's personal arena rating for %u by opponents rating: %u, because he has left queue!", GUID_LOPART(_player->GetGUID()), opponentsRating);
                        at->MemberLost(_player, opponentsRating, hiddenRating);
                        at->SaveToDB();
                    }
                }
                _player->RemoveBattleGroundQueueId(bgQueueTypeId); // must be called this way, because if you move this call to queue->removeplayer, it causes bugs
                sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg, _player->GetTeam(), queueSlot, STATUS_NONE, 0, 0);
                sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].RemovePlayer(_player->GetGUID(), true);
                // player left queue, we should update it, maybe now his group fits in
                sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].Update(bgTypeId,_player->GetBattleGroundBracketIdFromLevel(bgTypeId),arenatype,israted,rating,hiddenRating);
                SendPacket(&data);
                DEBUG_LOG("Battleground: player %s (%u) left queue for bgtype %u, queue type %u.",_player->GetName(),_player->GetGUIDLow(),bg->GetTypeID(),bgQueueTypeId);
                break;
            default:
                sLog.outLog(LOG_DEFAULT, "ERROR: Battleground port: unknown action %u", action);
                break;
        }
    }
}

void WorldSession::HandleBattleGroundLeaveOpcode(WorldPacket &recv_data)
{
    sLog.outDebug("WORLD: Recvd CMSG_LEAVE_BATTLEFIELD Message");

    recv_data.read_skip<uint8>();                           // unk1
    recv_data.read_skip<uint8>();                           // unk2
    recv_data.read_skip<uint32>();                          // BattleGroundTypeId
    recv_data.read_skip<uint16>();                          // unk3

    _player->LeaveBattleground();
}

void WorldSession::HandleBattlefieldStatusOpcode(WorldPacket & /*recv_data*/)
{
    // empty opcode
    DEBUG_LOG( "WORLD: Battleground status" );

    WorldPacket data;

    // TODO: we must put player back to battleground in case disconnect (< 5 minutes offline time) or teleport player on login(!) from battleground map to entry point
    if (_player->InBattleGround())
    {
        BattleGround *bg = _player->GetBattleGround();
        if (bg)
        {
            BattleGroundQueueTypeId bgQueueTypeId_tmp = BattleGroundMgr::BGQueueTypeId(bg->GetTypeID(), bg->GetArenaType());
            uint32 queueSlot = _player->GetBattleGroundQueueIndex(bgQueueTypeId_tmp);
            if ((bg->GetStatus() <= STATUS_IN_PROGRESS))
            {
                sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg, _player->GetBGTeam(), queueSlot, STATUS_IN_PROGRESS, 0, bg->GetStartTime());
                SendPacket(&data);
            }
            for (uint32 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; i++)
            {
                BattleGroundQueueTypeId bgQueueTypeId = _player->GetBattleGroundQueueTypeId(i);
                if (i == queueSlot || !bgQueueTypeId)
                    continue;
                BattleGroundTypeId bgTypeId = BattleGroundMgr::BGTemplateId(bgQueueTypeId);
                uint8 arenatype = BattleGroundMgr::BGArenaType(bgQueueTypeId);
                uint8 isRated = 0;
                BattleGroundQueue::QueuedPlayersMap& qpMap = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].m_QueuedPlayers;
                BattleGroundQueue::QueuedPlayersMap::iterator itrPlayerStatus = qpMap.find(_player->GetGUID());
                if (itrPlayerStatus == qpMap.end())
                    continue;
                if (itrPlayerStatus->second.GroupInfo)
                {
                    arenatype = itrPlayerStatus->second.GroupInfo->ArenaType;
                    isRated = itrPlayerStatus->second.GroupInfo->IsRated;
                }
                BattleGround *bg2 = sBattleGroundMgr.GetBattleGroundTemplate(bgTypeId);
                if (bg2)
                {
                    //in this call is small bug, this call should be filled by player's waiting time in queue
                    //this call nulls all timers for client :
                    sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg2, _player->GetTeam(), i, STATUS_WAIT_QUEUE, 0, 0,arenatype,isRated);
                    SendPacket(&data);
                }
            }
        }
    }
    else
    {
        // we should update all queues? .. i'm not sure if this code is correct
        for (uint32 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; i++)
        {
            BattleGroundQueueTypeId bgQueueTypeId = _player->GetBattleGroundQueueTypeId(i);
            if (!bgQueueTypeId)
                continue;

            BattleGroundTypeId bgTypeId = BattleGroundMgr::BGTemplateId(bgQueueTypeId);
            uint8 arenatype = BattleGroundMgr::BGArenaType(bgQueueTypeId);
            uint8 isRated = 0;
            BattleGround *bg = sBattleGroundMgr.GetBattleGroundTemplate(bgTypeId);
            BattleGroundQueue::QueuedPlayersMap& qpMap = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].m_QueuedPlayers;
            BattleGroundQueue::QueuedPlayersMap::iterator itrPlayerStatus = qpMap.find(_player->GetGUID());
            if (itrPlayerStatus == qpMap.end())
                continue;
            if (itrPlayerStatus->second.GroupInfo)
            {
                arenatype = itrPlayerStatus->second.GroupInfo->ArenaType;
                isRated = itrPlayerStatus->second.GroupInfo->IsRated;
            }
            if (bg)
            {
                sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg, _player->GetTeam(), i, STATUS_WAIT_QUEUE, 0, 0, arenatype, isRated);
                SendPacket(&data);
            }
        }
    }
}

void WorldSession::HandleAreaSpiritHealerQueryOpcode(WorldPacket & recv_data)
{
    sLog.outDebug("WORLD: CMSG_AREA_SPIRIT_HEALER_QUERY");

    CHECK_PACKET_SIZE(recv_data, 8);

    BattleGround *bg = _player->GetBattleGround();
    if (!bg)
        return;

    uint64 guid;
    recv_data >> guid;

    Creature *unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
        return;

    if (!unit->isSpiritService())                            // it's not spirit service
        return;

    sBattleGroundMgr.SendAreaSpiritHealerQueryOpcode(_player, bg, guid);
}

void WorldSession::HandleAreaSpiritHealerQueueOpcode(WorldPacket & recv_data)
{
    sLog.outDebug("WORLD: CMSG_AREA_SPIRIT_HEALER_QUEUE");

    CHECK_PACKET_SIZE(recv_data, 8);

    BattleGround *bg = _player->GetBattleGround();
    if (!bg)
        return;

    uint64 guid;
    recv_data >> guid;

    Creature *unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
        return;

    if (!unit->isSpiritService())                            // it's not spirit service
        return;

    bg->AddPlayerToResurrectQueue(guid, _player->GetGUID());
}

void WorldSession::AnnounceArenaStart(uint8 arenatype, uint32 arenaRating, std::string teamName)
{    
    std::stringstream ss;
    switch (arenatype)
    {
    case 2:
        ss << "2v2: ";
        break;
    case 3:
        ss << "3v3: ";
        break;
    case 5:
        ss << "5v5: ";
        break;   
    default: 
        return;
    }

    ss << "\"" <<teamName << "\" with rating " << arenaRating << " just queued!";

    sWorld.SendWorldTextForLevels(60, 70, ACC_DISABLED_BGANN, LANG_BG_START_ANNOUNCE, ss.str().c_str());
}

void WorldSession::HandleBattleGroundArenaJoin(WorldPacket & recv_data)
{
    DEBUG_LOG("WORLD: CMSG_BATTLEMASTER_JOIN_ARENA");
    //recv_data.hexlike();

    uint64 guid;                                            // arena Battlemaster guid
    uint8 arenaslot;                                        // 2v2, 3v3 or 5v5
    uint8 asGroup;                                          // asGroup
    uint8 isRated;                                          // isRated
    Group * grp;

    recv_data >> guid >> arenaslot >> asGroup >> isRated;

    // ignore if we already in BG or BG queue
    if (_player->InBattleGround())
        return;

    Creature *unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
        return;

    if (!unit->isBattleMaster())                             // it's not battle master
        return;

    uint8 arenatype = 0;
    uint32 arenaRating = 0;
    uint32 hiddenRating = 0;

    switch (arenaslot)
    {
        case 0:
            arenatype = ARENA_TYPE_2v2;
            break;
        case 1:
            arenatype = ARENA_TYPE_3v3;
            break;
        case 2:
            arenatype = ARENA_TYPE_5v5;
            break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: Unknown arena slot %u at HandleBattlemasterJoinArena()", arenaslot);
            return;
    }

    // check existance
    BattleGround* bg = sBattleGroundMgr.GetBattleGroundTemplate(BATTLEGROUND_AA);
    if (!bg)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Battleground: template bg (all arenas) not found");
        return;
    }

    BattleGroundTypeId bgTypeId = bg->GetTypeID();
    BattleGroundQueueTypeId bgQueueTypeId = BattleGroundMgr::BGQueueTypeId(bgTypeId, arenatype);
    BattleGroundBracketId bgBracketId = _player->GetBattleGroundBracketIdFromLevel(bgTypeId);

    // check queue conditions
    if (!asGroup)
    {
        // check if already in queue
        if (_player->GetBattleGroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES)
            //player is already in this queue
            return;
        // check if has free queue slots
        if (!_player->HasFreeBattleGroundQueueId())
            return;
    }
    else
    {
        grp = _player->GetGroup();
        // no group found, error
        if (!grp)
            return;
        uint32 err = grp->CanJoinBattleGroundQueue(bgTypeId, bgQueueTypeId, arenatype, arenatype, (bool)isRated, arenaslot);
        if (err != BG_JOIN_ERR_OK)
        {
            SendBattleGroundOrArenaJoinError(err);
            return;
        }
    }

    uint32 ateamId = 0;

    if (isRated)
    {
        ateamId = _player->GetArenaTeamId(arenaslot);
        // check real arena team existence only here (if it was moved to group->CanJoin .. () then we would have to get it twice)
        ArenaTeam * at = sObjectMgr.GetArenaTeamById(ateamId);
        if (!at)
        {
            _player->GetSession()->SendNotInArenaTeamPacket(arenatype);
            return;
        }
        // get the team rating for queue
        arenaRating = at->GetRating();
        hiddenRating = at->GetAverageMMR(_player->GetGroup());
        // the arena team id must match for everyone in the group
        // get the personal ratings for queue
        uint32 avg_pers_rating = 0;
        if (sWorld.getConfig(CONFIG_ENABLE_HIDDEN_RATING))
        {
            for (Group::member_citerator citr = grp->GetMemberSlots().begin(); citr != grp->GetMemberSlots().end(); ++citr)
            {
                ArenaTeamMember const* at_member = at->GetMember(citr->guid);
                if (!at_member)                                 // group member joining to arena must be in leader arena team
                    return;

                avg_pers_rating += at_member->matchmaker_rating;
            }

            if (sWorld.getConfig(CONFIG_ENABLE_HIDDEN_RATING_PENALTY) && hiddenRating > (arenaRating + sWorld.getConfig(CONFIG_HIDDEN_RATING_PENALTY)))
                hiddenRating -= sWorld.getConfig(CONFIG_HIDDEN_RATING_PENALTY);
        }
        else
        {
            for (GroupReference *itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
            {
                Player *member = itr->getSource();

                // calc avg personal rating
                avg_pers_rating += member->GetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (arenaslot*6) + 5);
            }
        }

        avg_pers_rating /= grp->GetMembersCount();
    }

    if (asGroup)
    {
        GroupQueueInfo * ginfo = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].AddGroup(_player, bgTypeId, bgBracketId, arenatype, isRated, false, arenaRating, hiddenRating, ateamId);
        DEBUG_LOG("Battleground: arena join as group start");
        if (isRated) {
            DEBUG_LOG("Battleground: arena team id %u, leader %s queued with rating %u for type %u", _player->GetArenaTeamId(arenaslot), _player->GetName(), arenaRating, arenatype);
            
            ateamId = _player->GetArenaTeamId(arenaslot);
            ArenaTeam * at = sObjectMgr.GetArenaTeamById(ateamId);
            if (at) {
                AnnounceArenaStart(arenatype, arenaRating, at->GetName());
            }
        }            
        for (GroupReference *itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
        {
            Player *member = itr->getSource();
            if (!member) continue;

            uint32 queueSlot = member->AddBattleGroundQueueId(bgQueueTypeId);// add to queue

            // store entry point coords (same as leader entry point)
            member->SetBattleGroundEntryPoint(_player->GetMapId(), _player->GetPositionX(), _player->GetPositionY(), _player->GetPositionZ(), _player->GetOrientation());

            WorldPacket data;
            // send status packet (in queue)
            sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg, member->GetTeam(), queueSlot, STATUS_WAIT_QUEUE, 0, 0, arenatype, isRated);
            member->SendPacketToSelf(&data);
            sBattleGroundMgr.BuildGroupJoinedBattlegroundPacket(&data, bgTypeId);
            member->SendPacketToSelf(&data);
            sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].AddPlayer(member, ginfo);
            DEBUG_LOG("Battleground: player joined queue for arena as group bg queue type %u bg type %u: GUID %u, NAME %s",bgQueueTypeId,bgTypeId,member->GetGUIDLow(), member->GetName());
        }
        DEBUG_LOG("Battleground: arena join as group end");
        sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].Update(bgTypeId, _player->GetBattleGroundBracketIdFromLevel(bgTypeId), arenatype, isRated, arenaRating, hiddenRating);
    }
    else
    {
        uint32 queueSlot = _player->AddBattleGroundQueueId(bgQueueTypeId);

        // store entry point coords
        _player->SetBattleGroundEntryPoint(_player->GetMapId(), _player->GetPositionX(), _player->GetPositionY(), _player->GetPositionZ(), _player->GetOrientation());

        WorldPacket data;
        // send status packet (in queue)
        sBattleGroundMgr.BuildBattleGroundStatusPacket(&data, bg, _player->GetTeam(), queueSlot, STATUS_WAIT_QUEUE, 0, 0, arenatype, isRated);
        SendPacket(&data);
        GroupQueueInfo * ginfo = sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].AddGroup(_player, bgTypeId, bgBracketId, arenatype, isRated, false, arenaRating, hiddenRating);
        sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].AddPlayer(_player, ginfo);
        sBattleGroundMgr.m_BattleGroundQueues[bgQueueTypeId].Update(bgTypeId, _player->GetBattleGroundBracketIdFromLevel(bgTypeId), arenatype, isRated, arenaRating, hiddenRating);
        DEBUG_LOG("Battleground: player joined queue for arena, skirmish, bg queue type %u bg type %u: GUID %u, NAME %s",bgQueueTypeId,bgTypeId,_player->GetGUIDLow(), _player->GetName());
    }
}

void WorldSession::HandleBattleGroundReportAFK(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data, 8);

    uint64 playerGuid;
    recv_data >> playerGuid;
    Player *reportedPlayer = sObjectMgr.GetPlayer(playerGuid);

    if (!reportedPlayer)
    {
        sLog.outDebug("WorldSession::HandleBattleGroundReportAFK: player not found");
        return;
    }

    sLog.outDebug("WorldSession::HandleBattleGroundReportAFK: %s reported %s", _player->GetName(), reportedPlayer->GetName());

    reportedPlayer->ReportedAfkBy(_player);
}

void WorldSession::SendBattleGroundOrArenaJoinError(uint8 err)
{
    WorldPacket data;
    int32 msg;
    switch (err)
    {
        case BG_JOIN_ERR_OFFLINE_MEMBER:
            msg = LANG_BG_GROUP_OFFLINE_MEMBER;
            break;
        case BG_JOIN_ERR_GROUP_TOO_MANY:
            msg = LANG_BG_GROUP_TOO_LARGE;
            break;
        case BG_JOIN_ERR_MIXED_FACTION:
            msg = LANG_BG_GROUP_MIXED_FACTION;
            break;
        case BG_JOIN_ERR_MIXED_LEVELS:
            msg = LANG_BG_GROUP_MIXED_LEVELS;
            break;
        case BG_JOIN_ERR_GROUP_MEMBER_ALREADY_IN_QUEUE:
            msg = LANG_BG_GROUP_MEMBER_ALREADY_IN_QUEUE;
            break;
        case BG_JOIN_ERR_GROUP_DESERTER:
            msg = LANG_BG_GROUP_MEMBER_DESERTER;
            break;
        case BG_JOIN_ERR_ALL_QUEUES_USED:
            msg = LANG_BG_GROUP_MEMBER_NO_FREE_QUEUE_SLOTS;
            break;
        case BG_JOIN_ERR_GROUP_NOT_ENOUGH:
        case BG_JOIN_ERR_MIXED_ARENATEAM:
        default:
            return;
            break;
    }
    ChatHandler::FillMessageData(&data, NULL, CHAT_MSG_BG_SYSTEM_NEUTRAL, LANG_UNIVERSAL, NULL, 0, GetTrinityString(msg), NULL);
    SendPacket(&data);
    return;
}
