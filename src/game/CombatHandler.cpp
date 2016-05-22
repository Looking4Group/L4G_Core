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

#include "Common.h"
#include "Log.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "ObjectAccessor.h"
#include "CreatureAI.h"
#include "ObjectGuid.h"

void WorldSession::HandleAttackSwingOpcode(WorldPacket & recv_data)
{
    uint64 guid;
    recv_data >> guid;

    DEBUG_LOG("WORLD: Recvd CMSG_ATTACKSWING Message guidlow:%u guidhigh:%u", GUID_LOPART(guid), GUID_HIPART(guid));

    Unit *pEnemy = _player->GetMap()->GetUnit(guid);

    if (!pEnemy)
    {
        // stop attack state at client
        SendAttackStop(NULL);
        return;
    }

    if (!_player->canAttack(pEnemy))
    {
        sLog.outDebug("WORLD: Enemy %s %u is friendly",(IS_PLAYER_GUID(guid) ? "player" : "creature"),GUID_LOPART(guid));

        // stop attack state at client
        SendAttackStop(pEnemy);
        return;
    }

    _player->Attack(pEnemy,true);
}

void WorldSession::HandleAttackStopOpcode(WorldPacket & /*recv_data*/)
{
    GetPlayer()->AttackStop();
}

void WorldSession::HandleSetSheathedOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data,4);

    uint32 sheathed;
    recv_data >> sheathed;

    if (sheathed >= MAX_SHEATH_STATE)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Unknown sheath state %u ??",sheathed);
        return;
    }

    GetPlayer()->SetSheath(sheathed);
}

void WorldSession::SendAttackStop(Unit const* enemy)
{
    WorldPacket data(SMSG_ATTACKSTOP, (4+20));            // we guess size
    data << GetPlayer()->GetPackGUID();
    data << (enemy ? enemy->GetPackGUID() : PackedGuid());  // must be packed guid
    data << uint32(0);                                      // unk, can be 1 also
    SendPacket(&data);
}

