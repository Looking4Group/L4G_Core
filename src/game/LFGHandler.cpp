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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "WorldSession.h"
#include "Log.h"
#include "Database/DatabaseEnv.h"
#include "Player.h"
#include "WorldPacket.h"
#include "ObjectMgr.h"
#include "World.h"

void WorldSession::HandleLfgAutoJoinOpcode(WorldPacket & /*recv_data*/)
{
    sLog.outDebug("CMSG_SET_LFG_AUTO_JOIN");
    LookingForGroup_auto_join = true;

    if (!_player)                                            // needed because STATUS_AUTHED
        return;

    GetPlayer()->LFGAttemptJoin();
}

void WorldSession::HandleLfgCancelAutoJoinOpcode(WorldPacket & /*recv_data*/)
{
    sLog.outDebug("CMSG_UNSET_LFG_AUTO_JOIN");
    LookingForGroup_auto_join = false;
}

void WorldSession::HandleLfmAutoAddMembersOpcode(WorldPacket & /*recv_data*/)
{
    sLog.outDebug("CMSG_SET_LFM_AUTOADD");
    LookingForGroup_auto_add = true;

    if (!_player)                                            // needed because STATUS_AUTHED
        return;

    GetPlayer()->LFMAttemptAddMore();
}

void WorldSession::HandleLfmCancelAutoAddmembersOpcode(WorldPacket & /*recv_data*/)
{
    sLog.outDebug("CMSG_UNSET_LFM_AUTOADD");
    LookingForGroup_auto_add = false;
}

void WorldSession::HandleLfgClearOpcode(WorldPacket & /*recv_data */)
{
    sLog.outDebug("CMSG_LOOKING_FOR_GROUP_CLEAR");

    GetPlayer()->ClearLFG();
}

void WorldSession::HandleLfmSetNoneOpcode(WorldPacket & /*recv_data */)
{
    sLog.outDebug("CMSG_SET_LOOKING_FOR_NONE");

    GetPlayer()->ClearLFM();
}

void WorldSession::HandleLfmSetOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data,4);

    sLog.outDebug("CMSG_SET_LOOKING_FOR_MORE");
    //recv_data.hexlike();
    uint32 temp, entry, type;

    recv_data >> temp;

    entry = (temp & 0xFFFF);
    type = ((temp >> 24) & 0xFFFF);

    GetPlayer()->LFMSet(entry, type);
    sLog.outDebug("LFM set: temp %u, zone %u, type %u", temp, entry, type);

    if (LookingForGroup_auto_add)
        GetPlayer()->LFMAttemptAddMore();

    SendLFM(type, entry);
}

void WorldSession::HandleLfgSetCommentOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data,1);

    sLog.outDebug("CMSG_SET_COMMENTARY");
    //recv_data.hexlike();

    std::string comment;
    recv_data >> comment;
    sLog.outDebug("LFG comment %s", comment.c_str());

    GetPlayer()->m_lookingForGroup.comment = comment;
}

void WorldSession::HandleLookingForGroup(WorldPacket& recv_data)
{
    CHECK_PACKET_SIZE(recv_data,4+4+4);

    sLog.outDebug("MSG_LOOKING_FOR_GROUP");
    //recv_data.hexlike();
    uint32 type, entry, unk;

    recv_data >> type >> entry >> unk;
    sLog.outDebug("MSG_LOOKING_FOR_GROUP: type %u, entry %u, unk %u", type, entry, unk);

    if (LookingForGroup_auto_add)
        _player->LFMAttemptAddMore();

    if (LookingForGroup_auto_join)
        _player->LFGAttemptJoin();

    SendLFM(type, entry);
}

void WorldSession::SendLFM(uint32 type, uint32 entry)
{
    uint32 number = 0;

    // start prepare packet;
    WorldPacket data(MSG_LOOKING_FOR_GROUP);
    data << uint32(type);                                   // type
    data << uint32(entry);                                  // entry from LFGDungeons.dbc
    data << uint32(0);                                      // count, placeholder
    data << uint32(0);                                      // count again, strange, placeholder

    LfgContainerType::const_accessor a;

    bool clearNeeded = false;

    // get player container for LFM id
    LfgContainerType & lfgContainer = sWorld.GetLfgContainer(GetPlayer()->GetTeam());
    if (lfgContainer.find(a, LFG_COMBINE(entry, type)))
    {
        for (std::list<uint64>::const_iterator itr = a->second.begin(); itr != a->second.end(); ++itr)
        {
            Player * plr = ObjectAccessor::GetPlayer(*itr);

            if (!plr)
            {
                clearNeeded = true;
                continue;
            }

            // skip not in world
            if (!plr->IsInWorld())
                continue;

            // skip not have in slot and not group leader cases
            if (!plr->m_lookingForGroup.Have(type, entry) || (plr->GetGroup() && !plr->GetGroup()->IsLeader(plr->GetGUID())))
            {
                clearNeeded = true;
                continue;
            }

            ++number;

            uint8 lfgType = plr->IsLFM(type, entry);
            data << plr->GetPackGUID();                         // packed guid
            data << plr->getLevel();                            // level
            data << plr->GetCachedZone();                       // current zone
            data << lfgType;                                    // 0x00 - LFG, 0x01 - LFM

            switch (lfgType)
            {
                case 0: // LFG
                    for (uint8 j = 0; j < MAX_LOOKING_FOR_GROUP_SLOT; ++j)
                        data << plr->GetLFGCombined(j);
                    break;
                case 1: // LFM
                    data << plr->GetLFMCombined();
                    for (uint8 j = 0; j < MAX_LOOKING_FOR_GROUP_SLOT-1; ++j)
                        data << uint32(0x00);
                    break;
                default:
                    sLog.outLog(LOG_DEFAULT, "ERROR: WorldSession::SendLFM: wrong lfgtype (%u) for player %u (acc %u)", lfgType, plr->GetGUIDLow(), plr->GetSession()->GetAccountId());
                    for (uint8 j = 0; j < MAX_LOOKING_FOR_GROUP_SLOT; ++j)
                        data << uint32(0x00);
                    break;
            }

            data << plr->m_lookingForGroup.comment;

            Group *group = plr->GetGroup();
            if (group)
            {
                data << group->GetMembersCount()-1;             // count of group members without group leader
                for (GroupReference * gItr = group->GetFirstMember(); gItr != NULL; gItr = gItr->next())
                {
                    Player *member = gItr->getSource();
                    if (member && member->GetGUID() != plr->GetGUID())
                    {
                        data << member->GetPackGUID();          // packed guid
                        data << member->getLevel();             // player level
                    }
                }
            }
            else
            {
                data << uint32(0x00);
            }
        }
    }

    a.release();

    // fill count placeholders
    data.put<uint32>(4+4,   number);
    data.put<uint32>(4+4+4, number);

    SendPacket(&data);


    if (clearNeeded)
    {
        LfgContainerType::accessor accessor;

        // get player container for LFM id
        if (lfgContainer.find(accessor, LFG_COMBINE(entry, type)))
        {
            for (std::list<uint64>::iterator itr = accessor->second.begin(); itr != accessor->second.end();)
            {
                std::list<uint64>::iterator tmpItr = itr;
                ++itr;
                Player * plr = ObjectAccessor::GetPlayer(*tmpItr);

                if (!plr || !plr->m_lookingForGroup.Have(type, entry) ||
                    (plr->GetGroup() && !plr->GetGroup()->IsLeader(plr->GetGUID())))
                    accessor->second.erase(tmpItr);
            }
        }
    }
}

void WorldSession::SendLFGDisabled()
{
    DEBUG_LOG("SMSG_LFG_DISABLED %u", GetPlayer()->GetGUIDLow());
    WorldPacket data(SMSG_LFG_DISABLED, 0);
    SendPacket(&data);
}

void WorldSession::SendLFG(uint32 type, uint32 entry)
{
    if (!_player || !_player->IsInWorld())
        return;

    // hmm should be implemented ? Oo

    /*
    // start prepare packet;
    WorldPacket data(MSG_LOOKING_FOR_GROUP);
    data << uint32(type);                                   // type
    data << uint32(entry);                                  // entry from LFGDungeons.dbc
    data << uint32(0);                                      // count, placeholder
    data << uint32(0);                                      // count again, strange, placeholder

    data << plr->GetPackGUID();                         // packed guid
    data << plr->getLevel();                            // level
    data << plr->GetZoneId();                           // current zone
    data << 0;                                    // 0x00 - LFG, 0x01 - LFM

    for (uint8 j = 0; j < MAX_LOOKING_FOR_GROUP_SLOT; ++j)
        data << plr->GetLFGCombined(j);

    // fill count placeholders
    data.put<uint32>(4+4,   1);
    data.put<uint32>(4+4+4, 1);

    SendPacket(&data);*/
}

void WorldSession::SendUpdateLFG()
{
    if (!_player || !_player->IsInWorld())
        return;

    // start prepare packet;
    WorldPacket data(SMSG_LFG_UPDATE_LFG);

    for (uint32 i = 0; i < MAX_LOOKING_FOR_GROUP_SLOT; ++i)
    {
        data << i;
        data << _player->GetLFGCombined(i);
    }

    SendPacket(&data);
}

void WorldSession::SendUpdateLFM()
{
    if (!_player || !_player->IsInWorld())
        return;

    // start prepare packet;
    WorldPacket data(SMSG_LFG_UPDATE_LFM);

    data << _player->GetLFMCombined();

    SendPacket(&data);
}

void WorldSession::SendLfgResult(uint32 type, uint32 entry, uint8 lfg_type)
{
    switch (lfg_type)
    {
        case 0:
            SendLFG(type, entry);
            break;
        case 1:
            SendLFM(type, entry);
            break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: WorldSession::SendLfgResult: Wrong lfg_type (%u) for player %u (acc: %u)", lfg_type, _player ? _player->GetGUIDLow() : 0, GetAccountId());
            break;
    }
}

void WorldSession::HandleSetLfgOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data,4+4);

    sLog.outDebug("CMSG_SET_LOOKING_FOR_GROUP");
    //recv_data.hexlike();
    uint32 slot, temp, entry, type;

    recv_data >> slot >> temp;

    entry = (temp & 0xFFFF);
    type = ((temp >> 24) & 0xFFFF);

    if (slot >= MAX_LOOKING_FOR_GROUP_SLOT)
        return;

    _player->LFGSet(slot, entry, type);
    sLog.outDebug("LFG set: looknumber %u, temp %X, type %u, entry %u", slot, temp, type, entry);

    if (LookingForGroup_auto_join)
        _player->LFGAttemptJoin();

    SendLfgResult(type, entry, 0);
}

