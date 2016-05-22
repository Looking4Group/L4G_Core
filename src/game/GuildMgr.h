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

#ifndef HELLGROUND_GUILDMGR_H
#define HELLGROUND_GUILDMGR_H

#include "ace/Singleton.h"
#include "Utilities/UnorderedMap.h"

class Guild;

typedef UNORDERED_MAP< uint32, Guild * >    GuildMap;
typedef std::vector< uint32 >               GuildBankTabPriceMap;
typedef UNORDERED_MAP<uint32,time_t>        GuildCooldowns;

class GuildMgr
{
    friend class ACE_Singleton<GuildMgr, ACE_Null_Mutex>;
    GuildMgr();

    public:
        ~GuildMgr();

        uint32 GenerateGuildId();

        Guild* GetGuildByLeader( const uint64 & guid ) const;
        Guild* GetGuildById( const uint32 & GuildId ) const;
        Guild* GetGuildByName( const std::string & guildname ) const;

        std::string GetGuildNameById( const uint32 & GuildId ) const;

        void AddGuild( Guild* guild) ;
        void RemoveGuild( const uint32 & Id );

        void LoadGuilds();
        void LoadGuildAnnCooldowns();

        time_t GetGuildAnnCooldown(uint32 guild_id) { return m_guildCooldownTimes[guild_id]; }
        void SaveGuildAnnCooldown(uint32 guild_id);

        // guild bank tabs
        uint32 GetGuildBankTabPrice( const uint8 & Index ) const;

    protected:
        uint32                  m_guildId;
        GuildMap                m_guildsMap;
        GuildCooldowns          m_guildCooldownTimes;
        GuildBankTabPriceMap    m_guildBankTabPrices;

};

#define sGuildMgr (*ACE_Singleton<GuildMgr, ACE_Null_Mutex>::instance())

#endif
