/*
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

#include "OutdoorPvPMgr.h"
#include "OutdoorPvPHP.h"
#include "OutdoorPvPNA.h"
#include "OutdoorPvPTF.h"
#include "OutdoorPvPZM.h"
#include "OutdoorPvPSI.h"
#include "OutdoorPvPEP.h"
#include "Player.h"

#include "MapManager.h"

OutdoorPvPMgr::OutdoorPvPMgr()
{
    m_UpdateTimer = 0;
    //sLog.outDebug("Instantiating OutdoorPvPMgr");
}

OutdoorPvPMgr::~OutdoorPvPMgr()
{
    //sLog.outDebug("Deleting OutdoorPvPMgr");
    for (OutdoorPvPSet::iterator itr = m_OutdoorPvPSet.begin(); itr != m_OutdoorPvPSet.end(); ++itr)
        delete *itr;
}

void OutdoorPvPMgr::InitOutdoorPvP()
{
    // THIS CODE IS WRONG AND HACKISH !! Here we create continent maps, someday it will be done somewhere else ;]
    Map *pKingdom  = sMapMgr.CreateMap(0, NULL);       // Find Eastern Kingdom
    if (!pKingdom)
        sLog.outLog(LOG_DEFAULT, "ERROR: Couldn't find map with id: 0");

    Map *pKalimdor = sMapMgr.CreateMap(1, NULL);       // Find Kalimdor
    if (!pKalimdor)
        sLog.outLog(LOG_DEFAULT, "ERROR: Couldn't find map with id: 1");

    Map *pOutland  = sMapMgr.CreateMap(530, NULL);     // Find Outland
    if (!pOutland)
        sLog.outLog(LOG_DEFAULT, "ERROR: Couldn't find map with id: 530");

    // create new opvp
    OutdoorPvP * pOP = new OutdoorPvPHP;
    // respawn, init variables
    if (!pOP->SetupOutdoorPvP())
    {
        sLog.outDebug("OutdoorPvP : HP init failed.");
        delete pOP;
    }
    else
    {
        pOP->SetMap(pOutland);

        m_OutdoorPvPSet.push_back(pOP);
        sLog.outDebug("OutdoorPvP : HP successfully initiated.");
    }

    pOP = new OutdoorPvPNA;
    // respawn, init variables
    if (!pOP->SetupOutdoorPvP())
    {
        sLog.outDebug("OutdoorPvP : NA init failed.");
        delete pOP;
    }
    else
    {
        pOP->SetMap(pOutland);

        m_OutdoorPvPSet.push_back(pOP);
        sLog.outDebug("OutdoorPvP : NA successfully initiated.");
    }

    pOP = new OutdoorPvPTF;
    // respawn, init variables
    if (!pOP->SetupOutdoorPvP())
    {
        sLog.outDebug("OutdoorPvP : TF init failed.");
        delete pOP;
    }
    else
    {
        pOP->SetMap(pOutland);

        m_OutdoorPvPSet.push_back(pOP);
        sLog.outDebug("OutdoorPvP : TF successfully initiated.");
    }

    pOP = new OutdoorPvPZM;
    // respawn, init variables
    if (!pOP->SetupOutdoorPvP())
    {
        sLog.outDebug("OutdoorPvP : ZM init failed.");
        delete pOP;
    }
    else
    {
        pOP->SetMap(pOutland);

        m_OutdoorPvPSet.push_back(pOP);
        sLog.outDebug("OutdoorPvP : ZM successfully initiated.");
    }

    pOP = new OutdoorPvPSI;
    // respawn, init variables
    if (!pOP->SetupOutdoorPvP())
    {
        sLog.outDebug("OutdoorPvP : SI init failed.");
        delete pOP;
    }
    else
    {
        pOP->SetMap(pKalimdor);

        m_OutdoorPvPSet.push_back(pOP);
        sLog.outDebug("OutdoorPvP : SI successfully initiated.");
    }

    pOP = new OutdoorPvPEP;
    // respawn, init variables
    if (!pOP->SetupOutdoorPvP())
    {
        sLog.outDebug("OutdoorPvP : EP init failed.");
        delete pOP;
    }
    else
    {
        pOP->SetMap(pKingdom);

        m_OutdoorPvPSet.push_back(pOP);
        sLog.outDebug("OutdoorPvP : EP successfully initiated.");
    }
}

void OutdoorPvPMgr::AddZone(uint32 zoneid, OutdoorPvP *handle)
{
    m_OutdoorPvPMap[zoneid] = handle;
}

void OutdoorPvPMgr::HandlePlayerEnterZone(Player *plr, uint32 zoneid)
{
    OutdoorPvPMap::iterator itr = m_OutdoorPvPMap.find(zoneid);
    if (itr == m_OutdoorPvPMap.end())
        return;

    if (itr->second->HasPlayer(plr))
        return;

    itr->second->HandlePlayerEnterZone(plr, zoneid);
    plr->SendInitWorldStates();
    sLog.outDebug("Player %u entered outdoorpvp id %u", plr->GetGUIDLow(), itr->second->GetTypeId());
}

void OutdoorPvPMgr::HandlePlayerLeaveZone(Player *plr, uint32 zoneid)
{
    OutdoorPvPMap::iterator itr = m_OutdoorPvPMap.find(zoneid);
    if (itr == m_OutdoorPvPMap.end())
        return;

    // teleport: remove once in removefromworld, once in updatezone
    if (!itr->second->HasPlayer(plr))
        return;

    itr->second->HandlePlayerLeaveZone(plr, zoneid);
    sLog.outDebug("Player %u left outdoorpvp id %u",plr->GetGUIDLow(), itr->second->GetTypeId());
}

void OutdoorPvPMgr::HandlePlayerLeave(Player *plr)
{
    for (OutdoorPvPMap::iterator itr = m_OutdoorPvPMap.begin(); itr != m_OutdoorPvPMap.end(); ++itr)
    {
        // teleport: remove once in removefromworld, once in updatezone
        if (!itr->second->HasPlayer(plr))
            continue;
        else
        {
            itr->second->HandlePlayerLeaveZone(plr, itr->first);
            sLog.outDebug("Player %u left outdoorpvp id %u",plr->GetGUIDLow(), itr->second->GetTypeId());
        }
    }
}

OutdoorPvP * OutdoorPvPMgr::GetOutdoorPvPToZoneId(uint32 zoneid)
{
    OutdoorPvPMap::iterator itr = m_OutdoorPvPMap.find(zoneid);
    if (itr == m_OutdoorPvPMap.end())
    {
        // no handle for this zone, return
        return NULL;
    }
    return itr->second;
}

void OutdoorPvPMgr::Update(uint32 diff)
{
    m_UpdateTimer += diff;
    if (m_UpdateTimer > OUTDOORPVP_OBJECTIVE_UPDATE_INTERVAL)
    {
        for (OutdoorPvPSet::iterator itr = m_OutdoorPvPSet.begin(); itr != m_OutdoorPvPSet.end(); ++itr)
            (*itr)->Update(m_UpdateTimer);
        m_UpdateTimer = 0;
    }
}

bool OutdoorPvPMgr::HandleCustomSpell(Player *plr, uint32 spellId, GameObject * go)
{
    for (OutdoorPvPSet::iterator itr = m_OutdoorPvPSet.begin(); itr != m_OutdoorPvPSet.end(); ++itr)
    {
        if ((*itr)->HandleCustomSpell(plr,spellId,go))
            return true;
    }
    return false;
}

ZoneScript * OutdoorPvPMgr::GetZoneScript(uint32 zoneId)
{
    OutdoorPvPMap::iterator itr = m_OutdoorPvPMap.find(zoneId);
    if (itr != m_OutdoorPvPMap.end())
        return itr->second;
    else
        return NULL;
}

bool OutdoorPvPMgr::HandleOpenGo(Player *plr, uint64 guid)
{
    for (OutdoorPvPSet::iterator itr = m_OutdoorPvPSet.begin(); itr != m_OutdoorPvPSet.end(); ++itr)
    {
        if ((*itr)->HandleOpenGo(plr,guid))
            return true;
    }
    return false;
}

void OutdoorPvPMgr::HandleGossipOption(Player *plr, uint64 guid, uint32 gossipid)
{
    for (OutdoorPvPSet::iterator itr = m_OutdoorPvPSet.begin(); itr != m_OutdoorPvPSet.end(); ++itr)
    {
        if ((*itr)->HandleGossipOption(plr,guid,gossipid))
            return;
    }
}

bool OutdoorPvPMgr::CanTalkTo(Player * plr, Creature * c, GossipOption & gso)
{
    for (OutdoorPvPSet::iterator itr = m_OutdoorPvPSet.begin(); itr != m_OutdoorPvPSet.end(); ++itr)
    {
        if ((*itr)->CanTalkTo(plr,c,gso))
            return true;
    }
    return false;
}

void OutdoorPvPMgr::HandleDropFlag(Player *plr, uint32 spellId)
{
    for (OutdoorPvPSet::iterator itr = m_OutdoorPvPSet.begin(); itr != m_OutdoorPvPSet.end(); ++itr)
    {
        if ((*itr)->HandleDropFlag(plr,spellId))
            return;
    }
}
