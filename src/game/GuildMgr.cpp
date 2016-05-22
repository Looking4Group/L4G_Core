/*
 * Copyright (C) 2005-2008 MaNGOS <http://getmangos.com/>
 * Copyright (C) 2008 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2008-2014 Looking4Group <http://looking4group.de/>
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

#include "GuildMgr.h"

#include "Database/DatabaseEnv.h"
#include "Database/SQLStorage.h"
#include "Database/SQLStorageImpl.h"

#include "Common.h"
#include "SharedDefines.h"
#include "Guild.h"
#include "ProgressBar.h"
#include "World.h"
#include "Log.h"

GuildMgr::GuildMgr()
{
    m_guildId = 1;

    m_guildBankTabPrices.resize( GUILD_BANK_MAX_TABS );
    m_guildBankTabPrices[0] = 100;
    m_guildBankTabPrices[1] = 250;
    m_guildBankTabPrices[2] = 500;
    m_guildBankTabPrices[3] = 1000;
    m_guildBankTabPrices[4] = 2500;
    m_guildBankTabPrices[5] = 5000;
}

GuildMgr::~GuildMgr()
{
    for (GuildMap::iterator itr = m_guildsMap.begin(); itr != m_guildsMap.end(); ++itr)
        delete itr->second;
    
    m_guildsMap.clear();
}


Guild * GuildMgr::GetGuildById(const uint32 & GuildId) const
{
    GuildMap::const_iterator itr = m_guildsMap.find(GuildId);
    if (itr != m_guildsMap.end())
        return itr->second;

    return nullptr;
}

Guild * GuildMgr::GetGuildByName(const std::string& guildname) const
{
    std::string search = guildname;
    std::transform(search.begin(), search.end(), search.begin(), toupper);
    for (GuildMap::const_iterator itr = m_guildsMap.begin(); itr != m_guildsMap.end(); ++itr)
    {
        std::string gname = itr->second->GetName();
        std::transform(gname.begin(), gname.end(), gname.begin(), toupper);
        if (search == gname)
            return itr->second;
    }
    return nullptr;
}

std::string GuildMgr::GetGuildNameById(const uint32 & GuildId) const
{
    GuildMap::const_iterator itr = m_guildsMap.find(GuildId);
    if (itr != m_guildsMap.end())
        return itr->second->GetName();

    return "";
}

Guild* GuildMgr::GetGuildByLeader(const uint64 &guid) const
{
    for (GuildMap::const_iterator itr = m_guildsMap.begin(); itr != m_guildsMap.end(); ++itr)
        if (itr->second->GetLeader() == guid)
            return itr->second;

    return nullptr;
}

void GuildMgr::AddGuild(Guild* guild)
{
    m_guildsMap[guild->GetId()] = guild;
}

void GuildMgr::RemoveGuild(const uint32 & Id)
{
    m_guildsMap.erase(Id);
}

uint32 GuildMgr::GetGuildBankTabPrice( const uint8 & Index ) const
{
    return Index < GUILD_BANK_MAX_TABS ? m_guildBankTabPrices[Index] : 0;
}

void GuildMgr::LoadGuildAnnCooldowns()
{
    uint32 count = 0;

    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT guild_id, cooldown_end FROM guild_announce_cooldown");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded 0 guildann_cooldowns.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 guild_id       = fields[0].GetUInt32();
        uint64 respawn_time = fields[1].GetUInt64();

        m_guildCooldownTimes[guild_id] = time_t(respawn_time);

        ++count;
    } while (result->NextRow());

    sLog.outString(">> Loaded %u guild ann cooldowns.", m_guildCooldownTimes.size());
    sLog.outString();
}


void GuildMgr::LoadGuilds()
{
    Guild *newguild;
    uint32 count = 0;

    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT guildid FROM guild");

    if (!result)
    {

        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u guild definitions", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();

        bar.step();
        ++count;

        newguild = new Guild;
        if ( !newguild->LoadGuildFromDB( fields[0].GetUInt32() ) )
        {
            newguild->Disband();
            delete newguild;
            continue;
        }
        AddGuild(newguild);

    }
    while ( result->NextRow( ));


    result = RealmDataDatabase.Query("SELECT MAX(guildid) FROM guild");
    if (result)
        m_guildId = (*result)[0].GetUInt32()+1;

    sLog.outString();
    sLog.outString(">> Loaded %u guild definitions, next guild ID: %u", count, m_guildId);
}


uint32 GuildMgr::GenerateGuildId()
{
    if (m_guildId >= 0xFFFFFFFE)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Guild ids overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return m_guildId++;
}

void GuildMgr::SaveGuildAnnCooldown(uint32 guild_id)
{
    time_t tmpTime = time_t(time(NULL) + sWorld.getConfig(CONFIG_GUILD_ANN_COOLDOWN));
    m_guildCooldownTimes[guild_id] = tmpTime;
    RealmDataDatabase.PExecute("REPLACE INTO guild_announce_cooldown VALUES ('%u', '" UI64FMTD "')", guild_id, uint64(tmpTime));
}
