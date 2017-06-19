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

/// \addtogroup world The World
/// @{
/// \file

#ifndef __WORLD_H
#define __WORLD_H

#include "ace/Singleton.h"

#include "Common.h"
#include "Timer.h"
#include "SharedDefines.h"
#include "ace/Atomic_Op.h"
#include "DelayExecutor.h"
#include "QueryResult.h"
#include "WorldSession.h"

#include <map>
#include <set>
#include <list>
#include <tbb/concurrent_hash_map.h>
#include <tbb/blocked_range.h>

class Object;
class WorldPacket;
class WorldSession;
class Player;
class Weather;
struct ScriptAction;
struct ScriptInfo;
class SqlResultQueue;
class QueryResult;
class WorldSocket;
class AntiCheat;

// ServerMessages.dbc
enum ServerMessageType
{
    SERVER_MSG_SHUTDOWN_TIME      = 1,
    SERVER_MSG_RESTART_TIME       = 2,
    SERVER_MSG_STRING             = 3,
    SERVER_MSG_SHUTDOWN_CANCELLED = 4,
    SERVER_MSG_RESTART_CANCELLED  = 5
};

enum ShutdownMask
{
    SHUTDOWN_MASK_RESTART = 1,
    SHUTDOWN_MASK_IDLE    = 2,
};

enum ShutdownExitCode
{
    SHUTDOWN_EXIT_CODE = 0,
    ERROR_EXIT_CODE    = 1,
    RESTART_EXIT_CODE  = 2,
};

/// Timers for different object refresh rates
enum WorldTimers
{
    WUPDATE_OBJECTS         = 0,
    WUPDATE_SESSIONS        = 1,
    WUPDATE_AUCTIONS        = 2,
    WUPDATE_WEATHERS        = 3,
    WUPDATE_UPTIME          = 4,
    WUPDATE_CORPSES         = 5,
    WUPDATE_EVENTS          = 6,
    WUPDATE_AUTOBROADCAST   = 7,
    WUPDATE_GUILD_ANNOUNCES = 8,
    WUPDATE_DELETECHARS     = 9,
    WUPDATE_OLDMAILS        = 10,

    WUPDATE_COUNT
};

/// Configuration elements
enum WorldConfigs
{
    CONFIG_COMPRESSION = 0,
    CONFIG_GRID_UNLOAD,
    CONFIG_VMAP_INDOOR_CHECK,
    CONFIG_INTERVAL_SAVE,
    CONFIG_INTERVAL_GRIDCLEAN,
    CONFIG_INTERVAL_MAPUPDATE,
    CONFIG_INTERVAL_CHANGEWEATHER,
    CONFIG_INTERVAL_DISCONNECT_TOLERANCE,
    CONFIG_PORT_WORLD,
    CONFIG_SOCKET_SELECTTIME,
    CONFIG_GROUP_XP_DISTANCE,
    CONFIG_SIGHT_MONSTER,
    CONFIG_SIGHT_GUARDER,
    CONFIG_GAME_TYPE,
    CONFIG_REALM_ZONE,
    CONFIG_ALLOW_TWO_SIDE_ACCOUNTS,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHAT,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_MAIL,
    CONFIG_ALLOW_TWO_SIDE_WHO_LIST,
    CONFIG_ALLOW_TWO_SIDE_ADD_FRIEND,
    CONFIG_ALLOW_TWO_SIDE_TRADE,
    CONFIG_GM_BLUE_CHAT_ENABLE,
    CONFIG_STRICT_PLAYER_NAMES,
    CONFIG_STRICT_CHARTER_NAMES,
    CONFIG_STRICT_PET_NAMES,
    CONFIG_CHARACTERS_CREATING_DISABLED,
    CONFIG_CHARACTERS_PER_ACCOUNT,
    CONFIG_CHARACTERS_PER_REALM,
    CONFIG_SKIP_CINEMATICS,
    CONFIG_MAX_PLAYER_LEVEL,
    CONFIG_START_PLAYER_LEVEL,
    CONFIG_START_PLAYER_MONEY,
    CONFIG_MIN_PLAYER_EXPLORE_LEVEL,
    CONFIG_MAX_HONOR_POINTS,
    CONFIG_START_HONOR_POINTS,
    CONFIG_MAX_ARENA_POINTS,
    CONFIG_START_ARENA_POINTS,
    CONFIG_INSTANCE_IGNORE_LEVEL,
    CONFIG_INSTANCE_IGNORE_RAID,
    CONFIG_BATTLEGROUND_CAST_DESERTER,
    CONFIG_INSTANCE_RESET_TIME_HOUR,
    CONFIG_INSTANCE_UNLOAD_DELAY,
    CONFIG_CAST_UNSTUCK,
    CONFIG_RABBIT_DAY,
    CONFIG_MAX_PRIMARY_TRADE_SKILL,
    CONFIG_MIN_PETITION_SIGNS,
    CONFIG_GM_LOGIN_STATE,
    CONFIG_GM_VISIBLE_STATE,
    CONFIG_GM_CHAT,
    CONFIG_GM_WISPERING_TO,
    CONFIG_GM_IN_GM_LIST,
    CONFIG_GM_IN_WHO_LIST,
    CONFIG_GM_LOG_TRADE,
    CONFIG_GM_TRUSTED_LEVEL,
    CONFIG_START_GM_LEVEL,
    CONFIG_ALLOW_GM_GROUP,
    CONFIG_ALLOW_GM_FRIEND,
    CONFIG_GROUP_VISIBILITY,
    CONFIG_MAIL_DELIVERY_DELAY,
    CONFIG_EXTERNAL_MAIL,
    CONFIG_EXTERNAL_MAIL_INTERVAL,
    CONFIG_GM_MAIL,
    CONFIG_UPTIME_UPDATE,
    CONFIG_SKILL_CHANCE_ORANGE,
    CONFIG_SKILL_CHANCE_YELLOW,
    CONFIG_SKILL_CHANCE_GREEN,
    CONFIG_SKILL_CHANCE_GREY,
    CONFIG_SKILL_CHANCE_MINING_STEPS,
    CONFIG_SKILL_CHANCE_SKINNING_STEPS,
    CONFIG_SKILL_PROSPECTING,
    CONFIG_SKILL_GAIN_CRAFTING,
    CONFIG_SKILL_GAIN_DEFENSE,
    CONFIG_SKILL_GAIN_GATHERING,
    CONFIG_SKILL_GAIN_WEAPON,
    CONFIG_MAX_OVERSPEED_PINGS,
    CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY,
    CONFIG_ALWAYS_MAX_SKILL_FOR_LEVEL,
    CONFIG_WEATHER,
    CONFIG_EXPANSION,
    CONFIG_CHATFLOOD_MESSAGE_COUNT,
    CONFIG_CHATFLOOD_MESSAGE_DELAY,
    CONFIG_CHATFLOOD_MUTE_TIME,
    CONFIG_CHATFLOOD_CAPS_LENGTH,
    CONFIG_CHATFLOOD_CAPS_PCT,
    CONFIG_CHATFLOOD_REPEAT_MESSAGES,
    CONFIG_CHATFLOOD_REPEAT_TIMEOUT,
    CONFIG_CHATFLOOD_REPEAT_MUTE,
    CONFIG_CHATFLOOD_CHATTYPE,
    CONFIG_CHATFLOOD_EMOTE_COUNT,
    CONFIG_CHATFLOOD_EMOTE_DELAY,
    CONFIG_SPAMREPORT_TICKETS,
    CONFIG_SPAMREPORT_TICKET_THRESHOLD_CHAT,
    CONFIG_SPAMREPORT_TICKET_THRESHOLD_MAIL,
    CONFIG_EVENT_ANNOUNCE,
    CONFIG_CREATURE_FAMILY_FLEE_ASSISTANCE_RADIUS,
    CONFIG_CREATURE_FAMILY_ASSISTANCE_RADIUS,
    CONFIG_CREATURE_FAMILY_ASSISTANCE_DELAY,
    CONFIG_CREATURE_FAMILY_FLEE_DELAY,
    CONFIG_WORLD_BOSS_LEVEL_DIFF,
    CONFIG_QUEST_LOW_LEVEL_HIDE_DIFF,
    CONFIG_QUEST_HIGH_LEVEL_HIDE_DIFF,
    CONFIG_RESTRICTED_LFG_CHANNEL,
    CONFIG_SILENTLY_GM_JOIN_TO_CHANNEL,
    CONFIG_TALENTS_INSPECTING,
    CONFIG_CHAT_FAKE_MESSAGE_PREVENTING,
    CONFIG_CORPSE_DECAY_NORMAL,
    CONFIG_CORPSE_DECAY_RARE,
    CONFIG_CORPSE_DECAY_ELITE,
    CONFIG_CORPSE_DECAY_RAREELITE,
    CONFIG_CORPSE_DECAY_WORLDBOSS,
    CONFIG_ADDON_CHANNEL,
    CONFIG_DEATH_SICKNESS_LEVEL,
    CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP,
    CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE,
    CONFIG_DEATH_BONES_WORLD,
    CONFIG_DEATH_BONES_BG_OR_ARENA,
    CONFIG_EVADE_HOMEDIST,
    CONFIG_EVADE_TARGETDIST,
    CONFIG_INSTANT_LOGOUT,
    CONFIG_GROUPLEADER_RECONNECT_PERIOD,
    CONFIG_DISABLE_BREATHING,
    CONFIG_ALL_TAXI_PATHS,
    CONFIG_DECLINED_NAMES_USED,
    CONFIG_LISTEN_RANGE_SAY,
    CONFIG_LISTEN_RANGE_TEXTEMOTE,
    CONFIG_LISTEN_RANGE_YELL,
    CONFIG_ARENA_MAX_RATING_DIFFERENCE,
    CONFIG_ARENA_RATING_DISCARD_TIMER,
    CONFIG_ARENA_AUTO_DISTRIBUTE_POINTS,
    CONFIG_ARENA_AUTO_DISTRIBUTE_INTERVAL_DAYS,
    CONFIG_ARENA_LOG_EXTENDED_INFO,

    CONFIG_ENABLE_ARENA_STEP_BY_STEP_MATCHING,
    CONFIG_ARENA_STEP_BY_STEP_TIME,
    CONFIG_ARENA_STEP_BY_STEP_VALUE,

    CONFIG_BATTLEGROUND_INVITATION_TYPE,
    CONFIG_BATTLEGROUND_PREMADE_GROUP_WAIT_FOR_MATCH,
    CONFIG_BATTLEGROUND_PREMATURE_FINISH_TIMER,
    CONFIG_BATTLEGROUND_ANNOUNCE_START,
    CONFIG_BATTLEGROUND_QUEUE_INFO,
    CONFIG_BATTLEGROUND_TIMER_INFO,
    CONFIG_BATTLEGROUND_LOWLEVEL_MINPLAYER,
    CONFIG_BG_CROSSFRACTION,
    CONFIG_BATTLEGROUND_SCORE_STATISTICS,

    CONFIG_MAX_WHO,
    CONFIG_BG_START_MUSIC,
    CONFIG_START_ALL_SPELLS,
    CONFIG_HONOR_AFTER_DUEL,
    CONFIG_START_ALL_EXPLORED,
    CONFIG_START_ALL_REP,
    CONFIG_ALWAYS_MAXSKILL,
    CONFIG_PVP_TOKEN_ENABLE,
    CONFIG_PVP_TOKEN_MAP_TYPE,
    CONFIG_PVP_TOKEN_ID,
    CONFIG_PVP_TOKEN_COUNT,
    CONFIG_NO_RESET_TALENT_COST,
    CONFIG_CUSTOM_TALENT_RESET_TOKEN,
    CONFIG_SHOW_KICK_IN_WORLD,
    CONFIG_INTERVAL_LOG_UPDATE,
    CONFIG_MIN_LOG_UPDATE,
    CONFIG_MIN_LOG_SESSION_UPDATE,
    CONFIG_ENABLE_SINFO_LOGIN,
    CONFIG_PREMATURE_BG_REWARD,
    CONFIG_PET_LOS,
    CONFIG_VMAP_TOTEM,
    CONFIG_NUMTHREADS,
    CONFIG_CUMULATIVE_LOG_METHOD,
    CONFIG_MAPUPDATE_MAXVISITORS,
    CONFIG_AUTOBROADCAST_INTERVAL,
    CONFIG_GUILD_ANN_INTERVAL,
    CONFIG_GUILD_ANN_COOLDOWN,
    CONFIG_GUILD_ANN_LENGTH,
    CONFIG_DISABLE_DUEL,
    CONFIG_DISABLE_PVP,
    CONFIG_MIN_GM_TEXT_LVL,
    CONFIG_WARDEN_ENABLED,
    CONFIG_WARDEN_KICK,
    CONFIG_WARDEN_BAN,

    CONFIG_DONT_DELETE_CHARS,
    CONFIG_DONT_DELETE_CHARS_LVL,
    CONFIG_KEEP_DELETED_CHARS_TIME,

    CONFIG_ENABLE_SORT_AUCTIONS,

    CONFIG_RETURNOLDMAILS_MODE,
    CONFIG_RETURNOLDMAILS_INTERVAL,

    CONFIG_CHAT_DENY_MASK,
    CONFIG_CHAT_MINIMUM_LVL,

    CONFIG_ENABLE_HIDDEN_RATING,
    CONFIG_ENABLE_HIDDEN_RATING_PENALTY,
    CONFIG_HIDDEN_RATING_PENALTY,
    CONFIG_ENABLE_HIDDEN_RATING_LOWER_LOSS,

    CONFIG_ENABLE_FAKE_WHO_ON_ARENA,
    CONFIG_ENABLE_FAKE_WHO_IN_GUILD,

    CONFIG_VMSS_MAPFREEMETHOD,
    CONFIG_VMSS_FREEZECHECKPERIOD,
    CONFIG_VMSS_FREEZEDETECTTIME,
    CONFIG_VMSS_ENABLE,

    CONFIG_ENABLE_CUSTOM_XP_RATES,
    CONFIG_GET_CUSTOM_XP_RATE_LEVEL,
    CONFIG_XP_RATE_MODIFY_ITEM_ENTRY,
    CONFIG_XP_RATE_MODIFY_ITEM_PCT,

    CONFIG_ENABLE_PASSIVE_ANTICHEAT,

    CONFIG_SESSION_UPDATE_MAX_TIME,
    CONFIG_SESSION_UPDATE_OVERTIME_METHOD,
    CONFIG_SESSION_UPDATE_VERBOSE_LOG,
    CONFIG_SESSION_UPDATE_IDLE_KICK,

    CONFIG_KICK_PLAYER_ON_BAD_PACKET,

    CONFIG_MIN_GM_COMMAND_LOG_LEVEL,

    CONFIG_WAYPOINT_MOVEMENT_ACTIVE_ON_CONTINENTS,
    CONFIG_WAYPOINT_MOVEMENT_ACTIVE_IN_INSTANCES,
    CONFIG_COMBAT_ACTIVE_ON_CONTINENTS,
    CONFIG_COMBAT_ACTIVE_IN_INSTANCES,
    CONFIG_COMBAT_ACTIVE_FOR_PLAYERS_ONLY,

    CONFIG_WAYPOINT_MOVEMENT_PATHFINDING_ON_CONTINENTS,
    CONFIG_WAYPOINT_MOVEMENT_PATHFINDING_IN_INSTANCES,

    CONFIG_TARGET_POS_RECALCULATION_RANGE,
    CONFIG_TARGET_POS_RECHECK_TIMER,

    CONFIG_HEALTH_IN_PERCENTS,

    CONFIG_PRIVATE_CHANNEL_LIMIT,

    CONFIG_BG_MARKS_WINNER_COUNT,
    CONFIG_BG_MARKS_LOSER_COUNT,

    CONFIG_VMAP_LOS_ENABLED,
    CONFIG_MMAP_ENABLED,

    CONFIG_COREBALANCER_ENABLED,
    CONFIG_COREBALANCER_PLAYABLE_DIFF,
    CONFIG_COREBALANCER_INTERVAL,
    CONFIG_COREBALANCER_VISIBILITY_PENALTY,

    CONFIG_DAILY_BLIZZLIKE,
    CONFIG_DAILY_MAX_PER_DAY,

    CONFIG_CREATURE_RESTORE_STATE,
    CONFIG_FFA_DISALLOWGROUP,

    CONFIG_UINT32_RAF_MAXGRANTLEVEL,
    CONFIG_UINT32_RAF_MAXREFERALS,
    CONFIG_UINT32_RAF_MAXREFERERS,

    CONFIG_VALUE_COUNT
};

/// Server rates
enum Rates
{
    RATE_HEALTH=0,
    RATE_POWER_MANA,
    RATE_POWER_RAGE_INCOME,
    RATE_POWER_RAGE_LOSS,
    RATE_POWER_FOCUS,
    RATE_SKILL_DISCOVERY,
    RATE_DROP_ITEM_POOR,
    RATE_DROP_ITEM_NORMAL,
    RATE_DROP_ITEM_UNCOMMON,
    RATE_DROP_ITEM_RARE,
    RATE_DROP_ITEM_EPIC,
    RATE_DROP_ITEM_LEGENDARY,
    RATE_DROP_ITEM_ARTIFACT,
    RATE_DROP_ITEM_REFERENCED,
    RATE_DROP_MONEY,
    RATE_XP_KILL,
    RATE_XP_QUEST,
    RATE_XP_EXPLORE,
    RATE_XP_PAST_70,
    RATE_CUSTOM_XP_VALUE,
    RATE_REPUTATION_GAIN,
    RATE_REPUTATION_LOWLEVEL_KILL,
    RATE_REPUTATION_LOWLEVEL_QUEST,
    RATE_CREATURE_NORMAL_HP,
    RATE_CREATURE_ELITE_ELITE_HP,
    RATE_CREATURE_ELITE_RAREELITE_HP,
    RATE_CREATURE_ELITE_WORLDBOSS_HP,
    RATE_CREATURE_ELITE_RARE_HP,
    RATE_CREATURE_NORMAL_DAMAGE,
    RATE_CREATURE_ELITE_ELITE_DAMAGE,
    RATE_CREATURE_ELITE_RAREELITE_DAMAGE,
    RATE_CREATURE_ELITE_WORLDBOSS_DAMAGE,
    RATE_CREATURE_ELITE_RARE_DAMAGE,
    RATE_CREATURE_NORMAL_SPELLDAMAGE,
    RATE_CREATURE_ELITE_ELITE_SPELLDAMAGE,
    RATE_CREATURE_ELITE_RAREELITE_SPELLDAMAGE,
    RATE_CREATURE_ELITE_WORLDBOSS_SPELLDAMAGE,
    RATE_CREATURE_ELITE_RARE_SPELLDAMAGE,
    RATE_CREATURE_AGGRO,
    RATE_CREATURE_GUARD_AGGRO,
    RATE_REST_INGAME,
    RATE_REST_OFFLINE_IN_TAVERN_OR_CITY,
    RATE_REST_OFFLINE_IN_WILDERNESS,
    RATE_DAMAGE_FALL,
    RATE_AUCTION_TIME,
    RATE_AUCTION_DEPOSIT,
    RATE_AUCTION_CUT,
    RATE_HONOR,
    RATE_ARENA_POINTS,
    RATE_MINING_AMOUNT,
    RATE_MINING_NEXT,
    RATE_TALENT,
    RATE_LOYALTY,
    RATE_CORPSE_DECAY_LOOTED,
    RATE_INSTANCE_RESET_TIME,
    RATE_DURABILITY_LOSS_DAMAGE,
    RATE_DURABILITY_LOSS_PARRY,
    RATE_DURABILITY_LOSS_ABSORB,
    RATE_DURABILITY_LOSS_BLOCK,

    CONFIG_FLOAT_RATE_RAF_XP,
    CONFIG_FLOAT_RATE_RAF_LEVELPERLEVEL,

    MAX_RATES
};

/// Type of server
enum RealmType
{
    REALM_TYPE_NORMAL = 0,
    REALM_TYPE_PVP = 1,
    REALM_TYPE_NORMAL2 = 4,
    REALM_TYPE_RP = 6,
    REALM_TYPE_RPPVP = 8,
    REALM_TYPE_FFA_PVP = 16                                 // custom, free for all pvp mode like arena PvP in all zones except rest activated places and sanctuaries
                                                            // replaced by REALM_PVP in realm list
};

enum RealmZone
{
    REALM_ZONE_UNKNOWN       = 0,                           // any language
    REALM_ZONE_DEVELOPMENT   = 1,                           // any language
    REALM_ZONE_UNITED_STATES = 2,                           // extended-Latin
    REALM_ZONE_OCEANIC       = 3,                           // extended-Latin
    REALM_ZONE_LATIN_AMERICA = 4,                           // extended-Latin
    REALM_ZONE_TOURNAMENT_5  = 5,                           // basic-Latin at create, any at login
    REALM_ZONE_KOREA         = 6,                           // East-Asian
    REALM_ZONE_TOURNAMENT_7  = 7,                           // basic-Latin at create, any at login
    REALM_ZONE_ENGLISH       = 8,                           // extended-Latin
    REALM_ZONE_GERMAN        = 9,                           // extended-Latin
    REALM_ZONE_FRENCH        = 10,                          // extended-Latin
    REALM_ZONE_SPANISH       = 11,                          // extended-Latin
    REALM_ZONE_RUSSIAN       = 12,                          // Cyrillic
    REALM_ZONE_TOURNAMENT_13 = 13,                          // basic-Latin at create, any at login
    REALM_ZONE_TAIWAN        = 14,                          // East-Asian
    REALM_ZONE_TOURNAMENT_15 = 15,                          // basic-Latin at create, any at login
    REALM_ZONE_CHINA         = 16,                          // East-Asian
    REALM_ZONE_CN1           = 17,                          // basic-Latin at create, any at login
    REALM_ZONE_CN2           = 18,                          // basic-Latin at create, any at login
    REALM_ZONE_CN3           = 19,                          // basic-Latin at create, any at login
    REALM_ZONE_CN4           = 20,                          // basic-Latin at create, any at login
    REALM_ZONE_CN5           = 21,                          // basic-Latin at create, any at login
    REALM_ZONE_CN6           = 22,                          // basic-Latin at create, any at login
    REALM_ZONE_CN7           = 23,                          // basic-Latin at create, any at login
    REALM_ZONE_CN8           = 24,                          // basic-Latin at create, any at login
    REALM_ZONE_TOURNAMENT_25 = 25,                          // basic-Latin at create, any at login
    REALM_ZONE_TEST_SERVER   = 26,                          // any language
    REALM_ZONE_TOURNAMENT_27 = 27,                          // basic-Latin at create, any at login
    REALM_ZONE_QA_SERVER     = 28,                          // any language
    REALM_ZONE_CN9           = 29                           // basic-Latin at create, any at login
};

// DB scripting commands
#define SCRIPT_COMMAND_TALK                  0              // source = unit, target=any, datalong (0=say, 1=whisper, 2=yell, 3=emote text)
#define SCRIPT_COMMAND_EMOTE                 1              // source = unit, datalong = anim_id
#define SCRIPT_COMMAND_FIELD_SET             2              // source = any, datalong = field_id, datalog2 = value
#define SCRIPT_COMMAND_MOVE_TO               3              // source = Creature, datalog2 = time, x/y/z
#define SCRIPT_COMMAND_FLAG_SET              4              // source = any, datalong = field_id, datalog2 = bitmask
#define SCRIPT_COMMAND_FLAG_REMOVE           5              // source = any, datalong = field_id, datalog2 = bitmask
#define SCRIPT_COMMAND_TELEPORT_TO           6              // source or target with Player, datalong = map_id, x/y/z
#define SCRIPT_COMMAND_QUEST_EXPLORED        7              // one from source or target must be Player, another GO/Creature, datalong=quest_id, datalong2=distance or 0
#define SCRIPT_COMMAND_RESPAWN_GAMEOBJECT    9              // source = any (summoner), datalong=db_guid, datalong2=despawn_delay
#define SCRIPT_COMMAND_TEMP_SUMMON_CREATURE 10              // source = any (summoner), datalong=creature entry, datalong2=despawn_delay
#define SCRIPT_COMMAND_OPEN_DOOR            11              // source = unit, datalong=db_guid, datalong2=reset_delay
#define SCRIPT_COMMAND_CLOSE_DOOR           12              // source = unit, datalong=db_guid, datalong2=reset_delay
#define SCRIPT_COMMAND_ACTIVATE_OBJECT      13              // source = unit, target=GO
#define SCRIPT_COMMAND_REMOVE_AURA          14              // source (datalong2!=0) or target (datalong==0) unit, datalong = spell_id
#define SCRIPT_COMMAND_CAST_SPELL           15              // source (datalong2!=0) or target (datalong==0) unit, datalong = spell_id
#define SCRIPT_COMMAND_LOAD_PATH            16              // source = unit, path = datalong, repeatable datalong2
#define SCRIPT_COMMAND_CALLSCRIPT_TO_UNIT   17              // source = WorldObject (if present used as a search center), datalong = unit lowguid, datalong2 = script id, dataint = script table to use
#define SCRIPT_COMMAND_PLAY_SOUND           18              // source = any object, target=any/player, datalong (sound_id), datalong2 (bitmask: 0/1=anyone/target, 0/2=with distance dependent, so 1|2 = 3 is target with distance dependent)
#define SCRIPT_COMMAND_KILL                 19              // datalong = (0=source kills source, 1=target kills source, 2=source kills target), dataint = 1 to remove corpse.
#define SCRIPT_COMMAND_SET_INST_DATA        20              // source = any, datalong = type, datalong2 = data
#define SCRIPT_COMMAND_DESPAWN_SELF         21              // target/source = Creature, datalong = despawn delay
#define SCRIPT_COMMAND_VISIBILITY_SET       22              // source = unit, datalong = Visibility State (VISIBILITY_OFF = 0, VISIBILITY_ON = 1, VISIBILITY_GROUP_STEALTH = 2, VISIBILITY_RESPAWN = 5)
#define SCRIPT_COMMAND_ORIENTATION          30              // source = Unit. o = orientation
#define SCRIPT_COMMAND_EQUIP                31              // soucre = Creature, datalong = equipment id
#define SCRIPT_COMMAND_MODEL                32              // source = Creature, datalong = model id

/// Storage class for commands issued for delayed execution
struct CliCommandHolder
{
    typedef void Print(const char*);

    char *m_command;
    Print* m_print;

    CliCommandHolder(const char *command, Print* zprint)
        : m_print(zprint)
    {
        size_t len = strlen(command)+1;
        m_command = new char[len];
        memcpy(m_command, command, len);
    }

    ~CliCommandHolder() { delete[] m_command; }
};

// ye place for this sucks
#define MAX_PVP_RANKS 14

typedef tbb::concurrent_hash_map<uint32, std::list<uint64> > LfgContainerType;
typedef UNORDERED_MAP<uint32, WorldSession*> SessionMap;

enum CumulateMapDiff
{
    DIFF_SESSION_UPDATE          = 0,
    DIFF_PLAYER_UPDATE           = 1,
    DIFF_CREATURE_UPDATE         = 2,
    DIFF_PET_UPDATE              = 3,

    DIFF_PLAYER_GRID_VISIT       = 4,
    DIFF_ACTIVEUNIT_GRID_VISIT   = 5,

    DIFF_SEND_OBJECTS_UPDATE     = 6,
    DIFF_PROCESS_SCRIPTS         = 7,
    DIFF_MOVE_CREATURES_IN_LIST  = 8,

    DIFF_PROCESS_RELOCATION      = 9,

    DIFF_MAP_SPECIAL_DATA_UPDATE = 10,

    DIFF_MAX_CUMULATIVE_INFO     = 11
};

typedef ACE_Atomic_Op<ACE_Thread_Mutex, uint32> atomic_uint;

struct MapUpdateDiffInfo
{

    ~MapUpdateDiffInfo()
    {
        for (CumulativeDiffMap::iterator itr = _cumulativeDiffInfo.begin(); itr != _cumulativeDiffInfo.end(); ++itr)
            delete itr->second;
    }

    void InitializeMapData();

    void ClearDiffInfo()
    {
        for (CumulativeDiffMap::iterator itr = _cumulativeDiffInfo.begin(); itr != _cumulativeDiffInfo.end(); ++itr)
        {
            for (int i = DIFF_SESSION_UPDATE; i < DIFF_MAX_CUMULATIVE_INFO; i++)
                itr->second[i] = 0;
        }
    }

    void CumulateDiffFor(CumulateMapDiff type, uint32 diff, uint32 mapid)
    {
        _cumulativeDiffInfo[mapid][type] += diff;
    }

    void PrintCumulativeMapUpdateDiff();

    typedef std::map<uint32, atomic_uint*> CumulativeDiffMap;

    CumulativeDiffMap _cumulativeDiffInfo;
};

enum CBTresholds
{
    CB_DISABLE_NONE           = 0,
    CB_DISABLE_LOW_PRIORITY   = 1,
    CB_DISABLE_MID_PRIORITY   = 2,
    CB_DISABLE_HIGH_PRIORITY  = 3,
    CB_VISIBILITY_PENALTY     = 4,

    CB_TRESHOLD_MAX,
};


inline
bool operator>(FeaturePriority rhs, CBTresholds lhs)
{
    return static_cast<int>(rhs) > static_cast<int>(lhs);
}

inline
bool operator<=(FeaturePriority rhs, CBTresholds lhs)
{
    return !(rhs > lhs);
}

class CoreBalancer
{
    public:
        CoreBalancer();

        void Initialize();
        void Update(const uint32);
        void IncreaseTreshold();
        void DecreaseTreshold();

        CBTresholds GetTreshold() const { return _treshold; }

    private:
        uint32 _diffSum;
        uint32 _diffCount;
        CBTresholds _treshold;
        TimeTrackerSmall _balanceTimer;
};

/// The World
class LOOKING4GROUP_EXPORT World
{
    friend class ACE_Singleton<World, ACE_Null_Mutex>;

    public:
        World();
        ~World();

        DelayExecutor m_ac;

        uint32 m_honorRanks[MAX_PVP_RANKS];

        static volatile uint32 m_worldLoopCounter;

        WorldSession* FindSession(uint32 id) const;
        void AddSession(WorldSession *s);
        bool RemoveSession(uint32 id);
        void AddSessionToRemove(SessionMap::iterator itr) { removedSessions.push_back(itr); }

        /// Get the number of current active sessions
        void UpdateMaxSessionCounters();
        uint32 GetActiveAndQueuedSessionCount() const { return m_sessions.size(); }
        uint32 GetActiveSessionCount() const { return m_sessions.size() - m_QueuedPlayer.size(); }
        uint32 GetQueuedSessionCount() const { return m_QueuedPlayer.size(); }

        uint32 GetLoggedInCharsCount(TeamId team);
        uint32 ModifyLoggedInCharsCount(TeamId team, int val);
        void SetLoggedInCharsCount(TeamId team, uint32 val);

        /// Get the maximum number of parallel sessions on the server since last reboot
        uint32 GetMaxQueuedSessionCount() const { return m_maxQueuedSessionCount; }
        uint32 GetMaxActiveSessionCount() const { return m_maxActiveSessionCount; }
        uint32 GetMaxAllianceSessionCount() const { return m_maxAllianceSessionCount; }
        uint32 GetMaxHordeSessionCount() const { return m_maxHordeSessionCount; }
        Player* FindPlayerInZone(uint32 zone);

        Weather* FindWeather(uint32 id) const;
        Weather* AddWeather(uint32 zone_id);
        void RemoveWeather(uint32 zone_id);

        /// Get the active session server limit (or security level limitations)
        uint32 GetPlayerAmountLimit() const { return m_playerLimit >= 0 ? m_playerLimit : 0; }
        uint64 GetMinimumPermissionMask() const { return m_requiredPermissionMask; }

        /// Set the active session server limit (or security level limitation)
        void SetPlayerLimit(int32 limit, bool needUpdate = false);
        void SetMinimumPermissionMask(uint64 perms) { m_requiredPermissionMask = perms; }

        //player Queue
        typedef std::list<WorldSession*> Queue;
        void AddQueuedPlayer(WorldSession*);
        bool RemoveQueuedPlayer(WorldSession* session);
        int32 GetQueuePos(WorldSession*);
        bool HasRecentlyDisconnected(WorldSession*);
        uint32 GetQueueSize() const { return m_QueuedPlayer.size(); }

        /// \todo Actions on m_allowMovement still to be implemented
        /// Is movement allowed?
        bool getAllowMovement() const { return m_allowMovement; }
        /// Allow/Disallow object movements
        void SetAllowMovement(bool allow) { m_allowMovement = allow; }

        /// Set a new Message of the Day
        void SetMotd(std::string motd) { m_motd = motd; }
        /// Get the current Message of the Day
        const char* GetMotd() const { return m_motd.c_str(); }

        /// Set the string for new characters (first login)
        void SetNewCharString(std::string str) { m_newCharString = str; }
        /// Get the string for new characters (first login)
        const std::string& GetNewCharString() const { return m_newCharString; }

        uint32 GetDefaultDbcLocale() const { return m_defaultDbcLocale; }

        /// Get the path where data (dbc, maps) are stored on disk
        std::string GetDataPath() const { return m_dataPath; }

        /// When server started?
        time_t const& GetStartTime() const { return m_startTime; }
        /// What time is it?
        time_t const& GetGameTime() const { return m_gameTime; }
        /// Uptime (in secs)
        uint32 GetUptime() const { return uint32(m_gameTime - m_startTime); }
        /// Update time
        uint32 GetUpdateTime() const { return m_updateTime; }
        void SetRecordDiffInterval(int32 t) { if (t >= 0) m_configs[CONFIG_INTERVAL_LOG_UPDATE] = (uint32)t; }

        /// Get the maximum skill level a player can reach
        uint16 GetConfigMaxSkillValue() const
        {
            uint32 lvl = getConfig(CONFIG_MAX_PLAYER_LEVEL);
            return lvl > 60 ? 300 + ((lvl - 60) * 75) / 10 : lvl*5;
        }

        void SetInitialWorldSettings();
        void LoadConfigSettings(bool reload = false);

        void QueueGuildAnnounce(uint32 guildid, uint32 team, std::string &msg);
        void SendGuildAnnounce(uint32 team, ...);

        void SendWorldText(int32 string_id, uint32 preventFlags, ...);
        void SendWorldTextForLevels(uint32 minLevel, uint32 maxLevel, uint32 preventFlags, int32 string_id, ...);
        void SendGlobalText(const char* text, WorldSession *self);
        void SendGMText(int32 string_id, ...);
        void SendGlobalMessage(WorldPacket *packet, WorldSession *self = 0, uint32 team = 0);
        void SendGlobalGMMessage(WorldPacket *packet, WorldSession *self = 0, uint32 team = 0);
        void SendGlobalMentoringMessage(WorldPacket *packet, WorldSession *self = 0, uint32 team = 0);
        void SendZoneMessage(uint32 zone, WorldPacket *packet, WorldSession *self = 0, uint32 team = 0);
        void SendZoneText(uint32 zone, const char *text, WorldSession *self = 0, uint32 team = 0);
        void SendServerMessage(ServerMessageType type, const char *text = "", Player* player = NULL);

        /// Are we in the middle of a shutdown?
        bool IsShutdowning() const { return m_ShutdownTimer > 0; }
        uint32 GetShutdownMask() const { return m_ShutdownMask; }
        uint32 GetShutdownTimer() const { return m_ShutdownTimer; }
        char const* GetShutdownReason() { return m_ShutdownReason.c_str(); }

        void ShutdownServ(uint32 time, uint32 options, uint8 exitcode, char const* = "no reason");
        void ShutdownCancel();
        void ShutdownMsg(bool show = false, Player* player = NULL);
        static uint8 GetExitCode() { return m_ExitCode; }
        static void StopNow(uint8 exitcode) { m_stopEvent = true; m_ExitCode = exitcode; }
        static bool IsStopped() { return m_stopEvent; }

        void LoadAutobroadcasts();
        void Update(uint32 diff);
        void UpdateSessions(const uint32 & diff);

        /// Set a server rate (see #Rates)
        void setRate(Rates rate,float value) { rate_values[rate]=value; }
        /// Get a server rate (see #Rates)
        float getRate(Rates rate) const { return rate_values[rate]; }

        /// Set a server configuration element (see #WorldConfigs)
        void setConfig(WorldConfigs index,uint32 value)
        {
            if (index<CONFIG_VALUE_COUNT)
                m_configs[index]=value;
        }

        void setConfig(Rates index, float value)
        {
            setRate(index, value);
        }

        /// Get a server configuration element (see #WorldConfigs)
        uint32 getConfig(WorldConfigs index) const
        {
            if (index<CONFIG_VALUE_COUNT)
                return m_configs[index];
            else
                return 0;
        }

        float getConfig(Rates index) const
        {
            return getRate(index);
        }

        /// Get configuration about force-loaded maps
        std::set<uint32>* getConfigForceLoadMapIds() const { return m_configForceLoadMapIds; }

        /// Are we on a "Player versus Player" server?
        bool IsPvPRealm() { return (getConfig(CONFIG_GAME_TYPE) == REALM_TYPE_PVP || getConfig(CONFIG_GAME_TYPE) == REALM_TYPE_RPPVP || getConfig(CONFIG_GAME_TYPE) == REALM_TYPE_FFA_PVP); }
        bool IsFFAPvPRealm() { return getConfig(CONFIG_GAME_TYPE) == REALM_TYPE_FFA_PVP; }

        bool KickPlayer(const std::string& playerName);
        void KickAll();
        void KickAllWithoutPermissions(uint64 perms);
        BanReturn BanAccount(BanMode mode, std::string nameIPOrMail, std::string duration, std::string reason, std::string author);
        bool RemoveBanAccount(BanMode mode, std::string nameIPOrMail);

        uint32 IncreaseScheduledScriptsCount() { return (uint32)++m_scheduledScripts; }
        uint32 DecreaseScheduledScriptCount() { return (uint32)--m_scheduledScripts; }
        uint32 DecreaseScheduledScriptCount(size_t count) { return (uint32)(m_scheduledScripts -= count); }
        bool IsScriptScheduled() const { return m_scheduledScripts > 0; }

        bool IsAllowedMap(uint32 mapid) { return m_forbiddenMapIds.count(mapid) == 0 ;}

        static float GetVisibleObjectGreyDistance()         { return m_VisibleObjectGreyDistance;     }

        static int32 GetActiveObjectUpdateDistanceOnContinents() { return m_activeObjectUpdateDistanceOnContinents; }
        static int32 GetActiveObjectUpdateDistanceInInstances() { return m_activeObjectUpdateDistanceInInstances; }

        void ProcessCliCommands();
        void QueueCliCommand(CliCommandHolder::Print* zprintf, char const* input) { cliCmdQueue.add(new CliCommandHolder(input, zprintf)); }

        void UpdateResultQueue();
        void InitResultQueue();

        void ForceGameEventUpdate();

        void UpdateRealmCharCount(uint32 accid);

        void UpdateRequiredPermissions();

        LocaleConstant GetAvailableDbcLocale(LocaleConstant locale) const { if (m_availableDbcLocaleMask & (1 << locale)) return locale; else return m_defaultDbcLocale; }

        //used World DB version
        void LoadDBVersion();
        char const* GetDBVersion() { return m_DBVersion.c_str(); }

        //used Script version
        void SetScriptsVersion(char const* version) { m_ScriptsVersion = version ? version : "unknown scripting library"; }
        char const* GetScriptsVersion() { return m_ScriptsVersion.c_str(); }

        void addDisconnectTime(std::pair<uint32,time_t> tPair){ m_disconnects.insert(tPair); }

        void CleanupDeletedChars();

        void SelectRandomHeroicDungeonDaily();
        void SelectRandomDungeonDaily();
        void SelectRandomCookingDaily();
        void SelectRandomFishingDaily();
        void SelectRandomPvPDaily();

        void SetMassMute(uint64 time, const char * reason)
        {
            m_massMuteTime = time;

            if (reason)
                m_massMuteReason = reason;
            else
                m_massMuteReason = "no-reason";
        }

        uint64 GetMassMuteTime() { return m_massMuteTime; }
        const char * GetMassMuteReason() { return m_massMuteReason.c_str(); }

        LfgContainerType & GetLfgContainer(uint32 team)
        {
            switch (team)
            {
                case ALLIANCE:
                    return lfgAllyContainer;
                default:
                    return lfgHordeContainer;
            }
        }

        // LFG container, lfg instance id to player guid list. Should be less lockable than prev implementation
        LfgContainerType lfgHordeContainer;
        LfgContainerType lfgAllyContainer;

        CBTresholds GetCoreBalancerTreshold();

        MAP_UPDATE_DIFF(MapUpdateDiffInfo& MapUpdateDiff() { return m_mapUpdateDiffInfo; })

        uint8 GetSwpStatus();

    protected:
        void _UpdateGameTime();
        void InitDailyQuestResetTime();
        void InitMonthlyQuestResetTime();
        void ResetDailyQuests();
        void ResetMonthlyQuests();

    private:
        static volatile bool m_stopEvent;
        static uint8 m_ExitCode;
        uint32 m_ShutdownTimer;
        uint32 m_ShutdownMask;
        std::string m_ShutdownReason;

        uint32 sessionThreads;

        std::list<SessionMap::iterator> removedSessions;

        //atomic op counter for active scripts amount
        ACE_Atomic_Op<ACE_Thread_Mutex, long> m_scheduledScripts;

        time_t m_startTime;
        time_t m_gameTime;
        IntervalTimer extmail_timer; 
        IntervalTimer m_timers[WUPDATE_COUNT];
        uint32 mail_timer;
        uint32 mail_timer_expires;
        uint32 m_updateTime, m_updateTimeSum, m_avgUpdateTime, m_curAvgUpdateTime;

        uint32 m_updateTimeCount;

        MAP_UPDATE_DIFF(MapUpdateDiffInfo m_mapUpdateDiffInfo)
        uint64 m_serverUpdateTimeSum, m_serverUpdateTimeCount;

        CoreBalancer _coreBalancer;

        typedef UNORDERED_MAP<uint32, Weather*> WeatherMap;
        WeatherMap m_weathers;
        SessionMap m_sessions;
        typedef UNORDERED_MAP<uint32, time_t> DisconnectMap;
        DisconnectMap m_disconnects;
        uint32 m_maxActiveSessionCount;
        uint32 m_maxQueuedSessionCount;
        uint32 m_maxAllianceSessionCount;
        uint32 m_maxHordeSessionCount;

        std::string m_newCharString;

        float rate_values[MAX_RATES];
        uint32 m_configs[CONFIG_VALUE_COUNT];
        int32 m_playerLimit;
        uint64 m_requiredPermissionMask;
        LocaleConstant m_defaultDbcLocale;                     // from config for one from loaded DBC locales
        uint32 m_availableDbcLocaleMask;                       // by loaded DBC
        void DetectDBCLang();
        bool m_allowMovement;
        std::string m_motd;
        std::string m_dataPath;
        std::set<uint32> m_forbiddenMapIds;

        uint64 m_massMuteTime;
        std::string m_massMuteReason;

        static float m_VisibleObjectGreyDistance;

        static int32 m_activeObjectUpdateDistanceOnContinents;
        static int32 m_activeObjectUpdateDistanceInInstances;

        static uint32 m_relocationLowerLimitSq;
        static uint32 m_relocationAINotifyDelay;

        // CLI command holder to be thread safe
        ACE_Based::LockedQueue<CliCommandHolder*, ACE_Thread_Mutex> cliCmdQueue;

        // next daily quests reset time
        time_t m_NextDailyQuestReset;
        time_t m_NextMonthlyQuestReset;

        // Player Queue
        Queue m_QueuedPlayer;

        // characters count
        atomic_uint loggedInAlliances;
        atomic_uint loggedInHordes;

        // sessions that are added async
        void AddSession_(WorldSession* s);
        ACE_Based::LockedQueue<WorldSession*, ACE_Thread_Mutex> addSessQueue;

        std::list<std::string> m_Autobroadcasts;
        std::list<std::pair<uint64, std::string> > m_GuildAnnounces[2];

        //used versions
        std::string m_DBVersion;
        std::string m_ScriptsVersion;

        // List of Maps that should be force-loaded on startup
        std::set<uint32>* m_configForceLoadMapIds;
};

extern uint32 realmID;

#define sWorld (*ACE_Singleton<World, ACE_Null_Mutex>::instance())

class SessionsUpdater
{
private:
    SessionMap * sessions;
    uint32 diff;

public:
    SessionsUpdater(SessionMap * sess, uint32 diff) : sessions(sess), diff(diff) {}

    void operator () (const tbb::blocked_range<int>& r) const
    {
        SessionMap::iterator itr = sessions->begin();
        advance(itr, r.begin());
        SessionMap::iterator itrEnd = sessions->begin();
        advance(itrEnd, r.end());

        for (; itr != itrEnd; ++itr)
        {
            if (!itr->second)
                continue;

            ///- and remove not active sessions from the list
            WorldSession * pSession = itr->second;
            WorldSessionFilter updater(pSession);
            if (!pSession->Update(diff, updater))    // As interval = 0
            {
                sWorld.RemoveQueuedPlayer(pSession);

                sWorld.AddSessionToRemove(itr);
            }
        }
    }
};

#endif
/// @}
