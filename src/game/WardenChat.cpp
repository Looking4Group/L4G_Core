/*
 * Copyright (C) 2013 Looking4Group <http://looking4group.net>
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

#include "WardenChat.h"

#include "WorldSession.h"

WardenChat::WardenChat()
{
}

WardenChat::~WardenChat()
{
}

void WardenChat::Init(WorldSession *pClient, BigNumber *K)
{
    Client = pClient;
    Module = GetModuleForClient(Client);
}

ClientWardenModule *WardenChat::GetModuleForClient(WorldSession *session)
{
    return NULL;
}

void WardenChat::InitializeModule()
{
}

void WardenChat::RequestHash()
{
}

void WardenChat::HandleHashResult(ByteBuffer &buff)
{
}

void WardenChat::RequestData()
{
}

void WardenChat::HandleData(ByteBuffer &buff)
{
}
