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
#include "Language.h"
#include "Database/DatabaseEnv.h"
#include "Log.h"
#include "Opcodes.h"
#include "SpellMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "UpdateMask.h"
#include "Player.h"
#include "SkillDiscovery.h"
#include "QuestDef.h"
#include "GossipDef.h"
#include "UpdateData.h"
#include "Channel.h"
#include "ChannelMgr.h"
#include "MapManager.h"
#include "InstanceSaveMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "ObjectMgr.h"
#include "ObjectAccessor.h"
#include "CreatureAI.h"
#include "Formulas.h"
#include "Group.h"
#include "Guild.h"
#include "Pet.h"
#include "SpellAuras.h"
#include "Util.h"
#include "Transports.h"
#include "Weather.h"
#include "BattleGround.h"
#include "BattleGroundAV.h"
#include "BattleGroundMgr.h"
#include "OutdoorPvP.h"
#include "OutdoorPvPMgr.h"
#include "ArenaTeam.h"
#include "Chat.h"
#include "Database/DatabaseImpl.h"
#include "Spell.h"
#include "ScriptMgr.h"
#include "SocialMgr.h"
#include "GameEvent.h"
#include "GridMap.h"
#include "WorldEventProcessor.h"
#include "GuildMgr.h"

#include "PlayerAI.h"

#include <cmath>
#include <cctype>
#include <iomanip>

#define ZONE_UPDATE_INTERVAL 1000

#define PLAYER_SKILL_INDEX(x)       (PLAYER_SKILL_INFO_1_1 + ((x)*3))
#define PLAYER_SKILL_VALUE_INDEX(x) (PLAYER_SKILL_INDEX(x)+1)
#define PLAYER_SKILL_BONUS_INDEX(x) (PLAYER_SKILL_INDEX(x)+2)

#define SKILL_VALUE(x)         PAIR32_LOPART(x)
#define SKILL_MAX(x)           PAIR32_HIPART(x)
#define MAKE_SKILL_VALUE(v, m) MAKE_PAIR32(v,m)

#define SKILL_TEMP_BONUS(x)    int16(PAIR32_LOPART(x))
#define SKILL_PERM_BONUS(x)    int16(PAIR32_HIPART(x))
#define MAKE_SKILL_BONUS(t, p) MAKE_PAIR32(t,p)

enum CharacterFlags
{
    CHARACTER_FLAG_NONE                 = 0x00000000,
    CHARACTER_FLAG_UNK1                 = 0x00000001,
    CHARACTER_FLAG_UNK2                 = 0x00000002,
    CHARACTER_LOCKED_FOR_TRANSFER       = 0x00000004,
    CHARACTER_FLAG_UNK4                 = 0x00000008,
    CHARACTER_FLAG_UNK5                 = 0x00000010,
    CHARACTER_FLAG_UNK6                 = 0x00000020,
    CHARACTER_FLAG_UNK7                 = 0x00000040,
    CHARACTER_FLAG_UNK8                 = 0x00000080,
    CHARACTER_FLAG_UNK9                 = 0x00000100,
    CHARACTER_FLAG_UNK10                = 0x00000200,
    CHARACTER_FLAG_HIDE_HELM            = 0x00000400,
    CHARACTER_FLAG_HIDE_CLOAK           = 0x00000800,
    CHARACTER_FLAG_UNK13                = 0x00001000,
    CHARACTER_FLAG_GHOST                = 0x00002000,
    CHARACTER_FLAG_RENAME               = 0x00004000,
    CHARACTER_FLAG_UNK16                = 0x00008000,
    CHARACTER_FLAG_UNK17                = 0x00010000,
    CHARACTER_FLAG_UNK18                = 0x00020000,
    CHARACTER_FLAG_UNK19                = 0x00040000,
    CHARACTER_FLAG_UNK20                = 0x00080000,
    CHARACTER_FLAG_UNK21                = 0x00100000,
    CHARACTER_FLAG_UNK22                = 0x00200000,
    CHARACTER_FLAG_UNK23                = 0x00400000,
    CHARACTER_FLAG_UNK24                = 0x00800000,
    CHARACTER_FLAG_LOCKED_BY_BILLING    = 0x01000000,
    CHARACTER_FLAG_DECLINED             = 0x02000000,
    CHARACTER_FLAG_UNK27                = 0x04000000,
    CHARACTER_FLAG_UNK28                = 0x08000000,
    CHARACTER_FLAG_UNK29                = 0x10000000,
    CHARACTER_FLAG_UNK30                = 0x20000000,
    CHARACTER_FLAG_UNK31                = 0x40000000,
    CHARACTER_FLAG_UNK32                = 0x80000000
};

// corpse reclaim times
#define DEATH_EXPIRE_STEP (5*MINUTE)
#define MAX_DEATH_COUNT 3

static uint32 copseReclaimDelay[MAX_DEATH_COUNT] = { 30, 60, 120 };

//== PlayerTaxi ================================================

PlayerTaxi::PlayerTaxi()
{
    // Taxi nodes
    memset(m_taximask, 0, sizeof(m_taximask));
}

void PlayerTaxi::InitTaxiNodesForLevel(uint32 race, uint32 level)
{
    // capital and taxi hub masks
    switch (race)
    {
        case RACE_HUMAN:    SetTaximaskNode(2);  break;     // Human
        case RACE_ORC:      SetTaximaskNode(23); break;     // Orc
        case RACE_DWARF:    SetTaximaskNode(6);  break;     // Dwarf
        case RACE_NIGHTELF: SetTaximaskNode(26);
                            SetTaximaskNode(27); break;     // Night Elf
        case RACE_UNDEAD_PLAYER: SetTaximaskNode(11); break;// Undead
        case RACE_TAUREN:   SetTaximaskNode(22); break;     // Tauren
        case RACE_GNOME:    SetTaximaskNode(6);  break;     // Gnome
        case RACE_TROLL:    SetTaximaskNode(23); break;     // Troll
        case RACE_BLOODELF: SetTaximaskNode(82); break;     // Blood Elf
        case RACE_DRAENEI:  SetTaximaskNode(94); break;     // Draenei
    }
    // new continent starting masks (It will be accessible only at new map)
    switch (Player::TeamForRace(race))
    {
        case ALLIANCE: SetTaximaskNode(100); break;
        case HORDE:    SetTaximaskNode(99);  break;
    }

    /*
    // level dependent taxi hubs
    if (level>=68)
        SetTaximaskNode(213);                               //Shattered Sun Staging Area
        */
}

void PlayerTaxi::LoadTaxiMask(const char* data)
{
    Tokens tokens = StrSplit(data, " ");

    int index;
    Tokens::iterator iter;
    for (iter = tokens.begin(), index = 0;
        (index < TaxiMaskSize) && (iter != tokens.end()); ++iter, ++index)
    {
        // load and set bits only for existed taxi nodes
        m_taximask[index] = sTaxiNodesMask[index] & uint32(atol((*iter).c_str()));
    }
}

void PlayerTaxi::AppendTaximaskTo(ByteBuffer& data, bool all)
{
    if (all)
    {
        for (uint8 i=0; i<TaxiMaskSize; i++)
            data << uint32(sTaxiNodesMask[i]);              // all existed nodes
    }
    else
    {
        for (uint8 i=0; i<TaxiMaskSize; i++)
            data << uint32(m_taximask[i]);                  // known nodes
    }
}

bool PlayerTaxi::LoadTaxiDestinationsFromString(const std::string& values)
{
    ClearTaxiDestinations();

    Tokens tokens = StrSplit(values," ");

    for (Tokens::iterator iter = tokens.begin(); iter != tokens.end(); ++iter)
    {
        uint32 node = uint32(atol(iter->c_str()));
        AddTaxiDestination(node);
    }

    if (m_TaxiDestinations.empty())
        return true;

    // Check integrity
    if (m_TaxiDestinations.size() < 2)
        return false;

    for (size_t i = 1; i < m_TaxiDestinations.size(); ++i)
    {
        uint32 cost;
        uint32 path;
        sObjectMgr.GetTaxiPath(m_TaxiDestinations[i-1],m_TaxiDestinations[i],path,cost);
        if (!path)
            return false;
    }

    return true;
}

std::string PlayerTaxi::SaveTaxiDestinationsToString()
{
    if (m_TaxiDestinations.empty())
        return "";

    std::ostringstream ss;

    for (size_t i=0; i < m_TaxiDestinations.size(); ++i)
        ss << m_TaxiDestinations[i] << " ";

    return ss.str();
}

uint32 PlayerTaxi::GetCurrentTaxiPath() const
{
    if (m_TaxiDestinations.size() < 2)
        return 0;

    uint32 path;
    uint32 cost;

    sObjectMgr.GetTaxiPath(m_TaxiDestinations[0],m_TaxiDestinations[1],path,cost);

    return path;
}

std::ostringstream& operator<< (std::ostringstream& ss, PlayerTaxi const& taxi)
{
    ss << "'";
    for(int i = 0; i < TaxiMaskSize; ++i)
        ss << taxi.m_taximask[i] << " ";
    ss << "'";
    return ss;
}

//== Player ====================================================

UpdateMask Player::updateVisualBits;

Player::Player (WorldSession *session): Unit(), m_reputationMgr(this), m_camera(this)
{
    m_transport = 0;

    m_mover = this;

    m_AC_timer = 0;
    m_AC_NoFall_count = 0;

    m_speakTime = 0;
    m_speakCount = 0;

    m_GMfollowtarget_GUID = 0;
    m_GMfollow_GUID = 0;

    m_objectType |= TYPEMASK_PLAYER;
    m_objectTypeId = TYPEID_PLAYER;

    m_valuesCount = PLAYER_END;

    m_session = session;

    m_divider = 0;

    m_ExtraFlags = 0;

    // players always accept
    if (!GetSession()->HasPermissions(PERM_GMT))
        SetAcceptWhispers(true);

    m_curSelection = 0;
    m_lootGuid = 0;

    m_comboTarget = 0;
    m_comboPoints = 0;

    m_usedTalentCount = 0;

    m_regenTimer = 0;
    m_weaponChangeTimer = 0;

    m_zoneUpdateId = 0;
    m_zoneUpdateTimer = 0;

    m_areaUpdateId = 0;

    m_nextSave = sWorld.getConfig(CONFIG_INTERVAL_SAVE);

    // randomize first save time in range [CONFIG_INTERVAL_SAVE] around [CONFIG_INTERVAL_SAVE]
    // this must help in case next save after mass player load after server startup
    m_nextSave = urand(m_nextSave/2,m_nextSave*3/2);

    clearResurrectRequestData();

    m_SpellModRemoveCount = 0;

    memset(m_items, 0, sizeof(Item*)*PLAYER_SLOTS_COUNT);

    m_social = NULL;

    // group is initialized in the reference constructor
    SetGroupInvite(NULL);
    m_groupUpdateMask = 0;
    m_auraUpdateMask = 0;
    m_bPassOnGroupLoot = false;

    duel = NULL;

    m_GuildIdInvited = 0;
    m_ArenaTeamIdInvited = 0;

    m_atLoginFlags = AT_LOGIN_NONE;

    pTrader = 0;

    ClearTrade();

    m_cinematic = false;
    m_watchingCinematicId = 0;

    PlayerTalkClass = new PlayerMenu(GetSession());
    m_currentBuybackSlot = BUYBACK_SLOT_START;

    for (int aX = 0 ; aX < 8 ; aX++)
        m_Tutorials[ aX ] = 0x00;

    m_TutorialsChanged = false;

    m_DailyQuestChanged = false;
    m_lastDailyQuestTime = 0;
    m_lastMonthlyQuestTime = 0;

    for (uint8 i=0; i< MAX_TIMERS; i++)
        m_MirrorTimer[i] = DISABLED_MIRROR_TIMER;

    m_MirrorTimerFlags = UNDERWATER_NONE;
    m_MirrorTimerFlagsLast = UNDERWATER_NONE;

    m_regenTimer = 0;
    m_weaponChangeTimer = 0;
    m_isInWater = false;
    m_drunkTimer = 0;
    m_drunk = 0;
    m_restTime = 0;
    m_deathTimer = 0;
    m_deathExpireTime = 0;

    m_swingErrorMsg = 0;

    m_DetectInvTimer = 1000;

    m_bgBattleGroundID = 0;
    m_bgTypeID = BATTLEGROUND_TYPE_NONE;
    for (int j=0; j < PLAYER_MAX_BATTLEGROUND_QUEUES; j++)
    {
        m_bgBattleGroundQueueID[j].bgQueueTypeId  = BATTLEGROUND_QUEUE_NONE;
        m_bgBattleGroundQueueID[j].invitedToInstance = 0;
    }
    m_bgTeam = 0;

    m_logintime = time(NULL);
    m_Last_tick = m_logintime;
    m_WeaponProficiency = 0;
    m_ArmorProficiency = 0;
    m_canParry = false;
    m_canBlock = false;
    m_canDualWield = false;
    m_ammoDPS = 0.0f;

    m_temporaryUnsummonedPetNumber = 0;
    //cache for UNIT_CREATED_BY_SPELL to allow
    //returning reagents for temporarily removed pets
    //when dying/logging out
    m_oldpetspell = 0;
    m_lastpetnumber = 0;

    ////////////////////Rest System/////////////////////
    time_inn_enter=0;
    inn_pos_mapid=0;
    inn_pos_x=0;
    inn_pos_y=0;
    inn_pos_z=0;
    m_rest_bonus=0;
    rest_type=REST_TYPE_NO;
    ////////////////////Rest System/////////////////////

    m_mailsUpdated = false;
    unReadMails = 0;
    m_nextMailDelivereTime = 0;

    m_resetTalentsCost = 0;
    m_resetTalentsTime = 0;
    m_itemUpdateQueueBlocked = false;

    for (int i = 0; i < MAX_MOVE_TYPE; ++i)
        m_forced_speed_changes[i] = 0;

    m_stableSlots = 0;

    /////////////////// Instance System /////////////////////

    m_HomebindTimer = 0;
    m_InstanceValid = true;
    m_dungeonDifficulty = DIFFICULTY_NORMAL;

    for (int i = 0; i < BASEMOD_END; i++)
    {
        m_auraBaseMod[i][FLAT_MOD] = 0.0f;
        m_auraBaseMod[i][PCT_MOD] = 1.0f;
    }

    m_spellPenetrationItemMod = 0;

    // Honor System
    m_lastHonorUpdateTime = time(NULL);

    // Player summoning
    m_summon_expire = 0;
    m_summon_mapid = 0;
    m_summon_x = 0.0f;
    m_summon_y = 0.0f;
    m_summon_z = 0.0f;

    m_miniPet = 0;
    m_bgAfkReportedTimer = 0;
    m_contestedPvPTimer = 0;

    m_declinedname = NULL;

    m_farsightVision = false;

    m_activeBy = 0;

    _preventSave = false;
    _preventUpdate = false;

    positionStatus.Reset(0);

    m_outdoors = GetTerrain()->IsOutdoors(GetPositionX(), GetPositionY(), GetPositionZ());
}

Player::~Player ()
{
    CleanupsBeforeDelete();

    // it must be unloaded already in PlayerLogout and accessed only for loggined player
    //m_social = NULL;

    // Note: buy back item already deleted from DB when player was saved
    for (int i = 0; i < PLAYER_SLOTS_COUNT; ++i)
    {
        if (m_items[i])
            delete m_items[i];
    }
    CleanupChannels();

    //all mailed items should be deleted, also all mail should be deallocated
    for (PlayerMails::iterator itr =  m_mail.begin(); itr != m_mail.end();++itr)
        delete *itr;

    for (ItemMap::iterator iter = mMitems.begin(); iter != mMitems.end(); ++iter)
        delete iter->second;                                //if item is duplicated... then server may crash ... but that item should be deallocated

    delete PlayerTalkClass;

    if (m_transport)
    {
        m_transport->RemovePassenger(this);
    }

    for (size_t x = 0; x < ItemSetEff.size(); x++)
        if (ItemSetEff[x])
            delete ItemSetEff[x];

    // clean up player-instance binds, may unload some instance saves
    for (uint8 i = 0; i < TOTAL_DIFFICULTIES; i++)
    {
        for (BoundInstancesMap::iterator itr = m_boundInstances[i].begin(); itr != m_boundInstances[i].end(); ++itr)
        {
            InstanceSave* save = itr->second.save;
            if (save != nullptr && save->HasPlayer(GetGUID()))
                save->RemovePlayer(GetGUID());
        }
    }

    delete m_declinedname;

    DeleteCharmAI();
}

void Player::CleanupsBeforeDelete()
{
    if (m_uint32Values)                                      // only for fully created Object
    {
        TradeCancel(false);
        DuelComplete(DUEL_INTERUPTED);

        if (getFollowingGM())
        {
            Player *gamemaster = Unit::GetPlayer(getFollowingGM());
            if (gamemaster)
            {
                gamemaster->setFollowTarget(0);
                gamemaster->GetUnitStateMgr().InitDefaults(true);
            }
            setGMFollow(0);
        }

        // just to be sure that we are removed from all outdoorpvp before we are deleted
        sOutdoorPvPMgr.HandlePlayerLeave(this);
    }

    ClearLFG();
    ClearLFM();

    Unit::CleanupsBeforeDelete();
}

bool Player::Create(uint32 guidlow, const std::string& name, uint8 race, uint8 class_, uint8 gender, uint8 skin, uint8 face, uint8 hairStyle, uint8 hairColor, uint8 facialHair, uint8 outfitId)
{
    //FIXME: outfitId not used in player creating

    Object::_Create(guidlow, 0, HIGHGUID_PLAYER);

    m_name = name;

    PlayerInfo const* info = sObjectMgr.GetPlayerInfo(race, class_);
    if (!info)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player have incorrect race/class pair. Can't be loaded.");
        return false;
    }

    for (int i = 0; i < PLAYER_SLOTS_COUNT; i++)
        m_items[i] = NULL;

    SetMapId(info->mapId);
    Relocate(info->positionX,info->positionY,info->positionZ);

    SetMap(sMapMgr.CreateMap(info->mapId, this));

    ChrClassesEntry const* cEntry = sChrClassesStore.LookupEntry(class_);
    if (!cEntry)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Class %u not found in DBC (Wrong DBC files?)",class_);
        return false;
    }

    uint8 powertype = cEntry->powerType;

    uint32 unitfield;

    switch (powertype)
    {
        case POWER_ENERGY:
        case POWER_MANA:
            unitfield = 0x00000000;
            break;
        case POWER_RAGE:
            unitfield = 0x00110000;
            break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: Invalid default powertype %u for player (class %u)",powertype,class_);
            return false;
    }

    SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, DEFAULT_WORLD_OBJECT_SIZE);
    SetFloatValue(UNIT_FIELD_COMBATREACH, DEFAULT_COMBAT_REACH);

    switch (gender)
    {
        case GENDER_FEMALE:
            SetDisplayId(info->displayId_f);
            SetNativeDisplayId(info->displayId_f);
            break;
        case GENDER_MALE:
            SetDisplayId(info->displayId_m);
            SetNativeDisplayId(info->displayId_m);
            break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: Invalid gender %u for player",gender);
            return false;
            break;
    }

    setFactionForRace(race);

    uint32 RaceClassGender = (race) | (class_ << 8) | (gender << 16);

    SetUInt32Value(UNIT_FIELD_BYTES_0, (RaceClassGender | (powertype << 24)));
    SetUInt32Value(UNIT_FIELD_BYTES_1, unitfield);
    SetByteValue(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_SANCTUARY | UNIT_BYTE2_FLAG_UNK5);
    SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);               // fix cast time showed in spell tooltip on client

                                                            //-1 is default value
    SetUInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX, uint32(-1));

    SetUInt32Value(PLAYER_BYTES, (skin | (face << 8) | (hairStyle << 16) | (hairColor << 24)));
    SetUInt32Value(PLAYER_BYTES_2, (facialHair | (0x00 << 8) | (0x00 << 16) | (0x02 << 24)));
    SetByteValue(PLAYER_BYTES_3, 0, gender);

    SetUInt32Value(PLAYER_GUILDID, 0);
    SetUInt32Value(PLAYER_GUILDRANK, 0);
    SetUInt32Value(PLAYER_GUILD_TIMESTAMP, 0);

    SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES, 0);        // 0=disabled
    SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
    SetUInt32Value(PLAYER_FIELD_KILLS, 0);
    SetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 0);
    SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, 0);
    SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, 0);

    // set starting level
    if (GetSession()->HasPermissions(PERM_GMT))
        SetUInt32Value (UNIT_FIELD_LEVEL, sWorld.getConfig(CONFIG_START_GM_LEVEL));
    else
        SetUInt32Value (UNIT_FIELD_LEVEL, sWorld.getConfig(CONFIG_START_PLAYER_LEVEL));

    SetUInt32Value (PLAYER_FIELD_COINAGE, sWorld.getConfig(CONFIG_START_PLAYER_MONEY));
    SetUInt32Value (PLAYER_FIELD_HONOR_CURRENCY, sWorld.getConfig(CONFIG_START_HONOR_POINTS));
    SetUInt32Value (PLAYER_FIELD_ARENA_CURRENCY, sWorld.getConfig(CONFIG_START_ARENA_POINTS));

    // start with every map explored
    if (sWorld.getConfig(CONFIG_START_ALL_EXPLORED))
    {
        for (uint8 i=0; i<64; i++)
            SetFlag(PLAYER_EXPLORED_ZONES_1+i,0xFFFFFFFF);
    }

    //Reputations if "StartAllReputation" is enabled, -- TODO: Fix this in a better way
    if (sWorld.getConfig(CONFIG_START_ALL_REP))
    {
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(942), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(935), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(936), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(1011), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(970), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(967), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(989), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(932), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(934), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(1038), 42999);
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(1077), 42999);

        // Factions depending on team, like cities and some more stuff
        switch (GetTeam())
        {
            case ALLIANCE:
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(72), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(47), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(69), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(930), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(730), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(978), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(54), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(946), 42999);
                break;
            case HORDE:
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(76), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(68), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(81), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(911), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(729), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(941), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(530), 42999);
                m_reputationMgr.SetReputation(sFactionStore.LookupEntry(947), 42999);
                break;
            default:
                break;
        }
    }

    // Played time
    m_Last_tick = time(NULL);
    m_Played_time[0] = 0;
    m_Played_time[1] = 0;

    // base stats and related field values
    InitStatsForLevel();
    InitTaxiNodesForLevel();
    InitTalentForLevel();
    InitPrimaryProffesions();                               // to max set before any spell added

    // apply original stats mods before spell loading or item equipment that call before equip _RemoveStatsMods()
    UpdateMaxHealth();                                      // Update max Health (for add bonus from stamina)
    SetHealth(GetMaxHealth());
    if (getPowerType()==POWER_MANA)
    {
        UpdateMaxPower(POWER_MANA);                         // Update max Mana (for add bonus from intellect)
        SetPower(POWER_MANA,GetMaxPower(POWER_MANA));
    }

    // original spells
    learnDefaultSpells(true);

    // original action bar
    std::list<uint16>::const_iterator action_itr[4];
    for (int i=0; i<4; i++)
        action_itr[i] = info->action[i].begin();

    for (; action_itr[0]!=info->action[0].end() && action_itr[1]!=info->action[1].end();)
    {
        uint16 taction[4];
        for (int i=0; i<4 ;i++)
            taction[i] = (*action_itr[i]);

        addActionButton((uint8)taction[0], taction[1], (uint8)taction[2], (uint8)taction[3]);

        for (int i=0; i<4 ;i++)
            ++action_itr[i];
    }

    // original items
    CharStartOutfitEntry const* oEntry = NULL;
    for (uint32 i = 1; i < sCharStartOutfitStore.GetNumRows(); ++i)
    {
        if (CharStartOutfitEntry const* entry = sCharStartOutfitStore.LookupEntry(i))
        {
            if (entry->RaceClassGender == RaceClassGender)
            {
                oEntry = entry;
                break;
            }
        }
    }

    if (oEntry)
    {
        for (int j = 0; j < MAX_OUTFIT_ITEMS; ++j)
        {
            if (oEntry->ItemId[j] <= 0)
                continue;

            uint32 item_id = oEntry->ItemId[j];

            ItemPrototype const* iProto = ObjectMgr::GetItemPrototype(item_id);
            if (!iProto)
            {
                sLog.outLog(LOG_DB_ERR, "Initial item id %u (race %u class %u) from CharStartOutfit.dbc not listed in `item_template`, ignoring.",item_id,getRace(),getClass());
                continue;
            }

            uint32 count = iProto->Stackable;               // max stack by default (mostly 1)
            if (iProto->Class==ITEM_CLASS_CONSUMABLE && iProto->SubClass==ITEM_SUBCLASS_FOOD)
            {
                switch (iProto->Spells[0].SpellCategory)
                {
                    case SPELL_CATEGORY_FOOD:                                // food
                        if (iProto->Stackable > 4)
                            count = 4;
                        break;
                    case SPELL_CATEGORY_DRINK:                                // drink
                        if (iProto->Stackable > 2)
                            count = 2;
                        break;
                }
            }

            StoreNewItemInBestSlots(item_id, count);
        }
    }

    for (PlayerCreateInfoItems::const_iterator item_id_itr = info->item.begin(); item_id_itr!=info->item.end(); ++item_id_itr++)
        StoreNewItemInBestSlots(item_id_itr->item_id, item_id_itr->item_amount);

    // bags and main-hand weapon must equipped at this moment
    // now second pass for not equipped (offhand weapon/shield if it attempt equipped before main-hand weapon)
    // or ammo not equipped in special bag
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            uint16 eDest;
            // equip offhand weapon/shield if it attempt equipped before main-hand weapon
            uint8 msg = CanEquipItem(NULL_SLOT, eDest, pItem, false);
            if (msg == EQUIP_ERR_OK)
            {
                RemoveItem(INVENTORY_SLOT_BAG_0, i,true);
                EquipItem(eDest, pItem, true);
            }
            // move other items to more appropriate slots (ammo not equipped in special bag)
            else
            {
                ItemPosCountVec sDest;
                msg = CanStoreItem(NULL_BAG, NULL_SLOT, sDest, pItem, false);
                if (msg == EQUIP_ERR_OK)
                {
                    RemoveItem(INVENTORY_SLOT_BAG_0, i,true);
                    pItem = StoreItem(sDest, pItem, true);
                }

                // if this is ammo then use it
                msg = CanUseAmmo(pItem->GetEntry());
                if (msg == EQUIP_ERR_OK)
                    SetAmmo(pItem->GetEntry());
            }
        }
    }
    // all item positions resolved

    return true;
}

bool Player::StoreNewItemInBestSlots(uint32 titem_id, uint32 titem_amount)
{
    sLog.outDebug("STORAGE: Creating initial item, itemId = %u, count = %u",titem_id, titem_amount);

    // attempt equip by one
    while (titem_amount > 0)
    {
        uint16 eDest;
        uint8 msg = CanEquipNewItem(NULL_SLOT, eDest, titem_id, false);
        if (msg != EQUIP_ERR_OK)
            break;

        EquipNewItem(eDest, titem_id, true);
        AutoUnequipOffhandIfNeed();
        --titem_amount;
    }

    if (titem_amount == 0)
        return true;                                        // equipped

    // attempt store
    ItemPosCountVec sDest;
    // store in main bag to simplify second pass (special bags can be not equipped yet at this moment)
    uint8 msg = CanStoreNewItem(INVENTORY_SLOT_BAG_0, NULL_SLOT, sDest, titem_id, titem_amount);
    if (msg == EQUIP_ERR_OK)
    {
        StoreNewItem(sDest, titem_id, true, Item::GenerateItemRandomPropertyId(titem_id));
        return true;                                        // stored
    }

    // item can't be added
    sLog.outLog(LOG_DEFAULT, "ERROR: STORAGE: Can't equip or store initial item %u for race %u class %u , error msg = %u",titem_id,getRace(),getClass(),msg);
    return false;
}

void Player::SendMirrorTimer(MirrorTimerType Type, uint32 MaxValue, uint32 CurrentValue, int32 Regen)
{
    if (int(MaxValue) == DISABLED_MIRROR_TIMER)
    {
        if (int(CurrentValue) != DISABLED_MIRROR_TIMER)
            StopMirrorTimer(Type);
        return;
    }
    WorldPacket data(SMSG_START_MIRROR_TIMER, (21));
    data << (uint32)Type;
    data << CurrentValue;
    data << MaxValue;
    data << Regen;
    data << (uint8)0;
    data << (uint32)0;                                      // spell id
    SendPacketToSelf(&data);
}

void Player::StopMirrorTimer(MirrorTimerType Type)
{
    m_MirrorTimer[Type] = DISABLED_MIRROR_TIMER;
    WorldPacket data(SMSG_STOP_MIRROR_TIMER, 4);
    data << (uint32)Type;
    SendPacketToSelf(&data);
}

void Player::UpdateFallInformationIfNeed(MovementInfo const& minfo,uint16 opcode)
{
    if (m_lastFallTime >= minfo.GetFallTime() || m_lastFallZ <= minfo.GetPos()->z || opcode == MSG_MOVE_FALL_LAND)
        SetFallInformation(minfo.GetFallTime(), minfo.GetPos()->z);
}

void Player::EnvironmentalDamage(EnviromentalDamage type, uint32 damage)
{
    if (!isAlive() || isGameMaster())
        return;

    WorldPacket data(SMSG_ENVIRONMENTALDAMAGELOG, (21));
    data << uint64(GetGUID());
    data << uint8(type != DAMAGE_FALL_TO_VOID ? type : DAMAGE_FALL);
    data << uint32(damage);
    data << uint32(0);
    data << uint32(0);
    BroadcastPacket(&data, true);

    DealDamage(this, damage, SELF_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);

    if (type==DAMAGE_FALL && !isAlive())                     // DealDamage not apply item durability loss at self damage
    {
        DEBUG_LOG("We are fall to death, loosing 10 percents durability");
        DurabilityLossAll(0.10f,false);
        // durability lost message
        WorldPacket data2(SMSG_DURABILITY_DAMAGE_DEATH, 0);
        SendPacketToSelf(&data2);
    }
}

int32 Player::getMaxTimer(MirrorTimerType timer)
{
    switch (timer)
    {
        case FATIGUE_TIMER:
            return MINUTE*IN_MILISECONDS;
        case BREATH_TIMER:
        {
            if (!isAlive() || HasAuraType(SPELL_AURA_WATER_BREATHING) || GetSession()->HasPermissions(sWorld.getConfig(CONFIG_DISABLE_BREATHING)))
                return DISABLED_MIRROR_TIMER;

            int32 UnderWaterTime = MINUTE*IN_MILISECONDS;
            AuraList const& mModWaterBreathing = GetAurasByType(SPELL_AURA_MOD_WATER_BREATHING);
            for (AuraList::const_iterator i = mModWaterBreathing.begin(); i != mModWaterBreathing.end(); ++i)
                UnderWaterTime = uint32(UnderWaterTime * (100.0f + (*i)->GetModifierValue()) / 100.0f);

            return UnderWaterTime;
        }
        case FIRE_TIMER:
        {
            if (!isAlive())
                return DISABLED_MIRROR_TIMER;

            return IN_MILISECONDS;
        }
        default:
            return 0;
    }
}

void Player::UpdateMirrorTimers()
{
    // Desync flags for update on next HandleDrowning
    if (m_MirrorTimerFlags)
        m_MirrorTimerFlagsLast = ~m_MirrorTimerFlags;
}

void Player::HandleDrowning(uint32 time_diff)
{
    if (!m_MirrorTimerFlags)
        return;

    // In water
    if (m_MirrorTimerFlags & UNDERWATER_INWATER)
    {
        // Breath timer not activated - activate it
        if (m_MirrorTimer[BREATH_TIMER] == DISABLED_MIRROR_TIMER)
        {
            m_MirrorTimer[BREATH_TIMER] = getMaxTimer(BREATH_TIMER);
            SendMirrorTimer(BREATH_TIMER, m_MirrorTimer[BREATH_TIMER], m_MirrorTimer[BREATH_TIMER], -1);
        }
        else                                                              // If activated - do tick
        {
            m_MirrorTimer[BREATH_TIMER]-=time_diff;
            // Timer limit - need deal damage
            if (m_MirrorTimer[BREATH_TIMER] < 0)
            {
                m_MirrorTimer[BREATH_TIMER]+= 1*IN_MILISECONDS;
                // Calculate and deal damage
                // TODO: Check this formula
                uint32 damage = GetMaxHealth() / 5 + urand(0, getLevel()-1);
                EnvironmentalDamage(DAMAGE_DROWNING, damage);
            }
            else if (!(m_MirrorTimerFlagsLast & UNDERWATER_INWATER))      // Update time in client if need
                SendMirrorTimer(BREATH_TIMER, getMaxTimer(BREATH_TIMER), m_MirrorTimer[BREATH_TIMER], -1);
        }
    }
    else if (m_MirrorTimer[BREATH_TIMER] != DISABLED_MIRROR_TIMER)        // Regen timer
    {
        int32 UnderWaterTime = getMaxTimer(BREATH_TIMER);
        // Need breath regen
        m_MirrorTimer[BREATH_TIMER]+=10*time_diff;
        if (m_MirrorTimer[BREATH_TIMER] >= UnderWaterTime || !isAlive())
            StopMirrorTimer(BREATH_TIMER);
        else if (m_MirrorTimerFlagsLast & UNDERWATER_INWATER)
            SendMirrorTimer(BREATH_TIMER, UnderWaterTime, m_MirrorTimer[BREATH_TIMER], 10);
    }

    // In dark water
    if (m_MirrorTimerFlags & UNDERWATER_INDARKWATER)
    {
        // Fatigue timer not activated - activate it
        if (m_MirrorTimer[FATIGUE_TIMER] == DISABLED_MIRROR_TIMER)
        {
            m_MirrorTimer[FATIGUE_TIMER] = getMaxTimer(FATIGUE_TIMER);
            SendMirrorTimer(FATIGUE_TIMER, m_MirrorTimer[FATIGUE_TIMER], m_MirrorTimer[FATIGUE_TIMER], -1);
        }
        else
        {
            m_MirrorTimer[FATIGUE_TIMER]-=time_diff;
            // Timer limit - need deal damage or teleport ghost to graveyard
            if (m_MirrorTimer[FATIGUE_TIMER] < 0)
            {
                m_MirrorTimer[FATIGUE_TIMER]+= 1*IN_MILISECONDS;
                if (isAlive())                                            // Calculate and deal damage
                {
                    uint32 damage = GetMaxHealth() / 5 + urand(0, getLevel()-1);
                    EnvironmentalDamage(DAMAGE_EXHAUSTED, damage);
                }
                else if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST))       // Teleport ghost to graveyard
                    RepopAtGraveyard();
            }
            else if (!(m_MirrorTimerFlagsLast & UNDERWATER_INDARKWATER))
                SendMirrorTimer(FATIGUE_TIMER, getMaxTimer(FATIGUE_TIMER), m_MirrorTimer[FATIGUE_TIMER], -1);
        }
    }
    else if (m_MirrorTimer[FATIGUE_TIMER] != DISABLED_MIRROR_TIMER)       // Regen timer
    {
        int32 DarkWaterTime = getMaxTimer(FATIGUE_TIMER);
        m_MirrorTimer[FATIGUE_TIMER]+=10*time_diff;
        if (m_MirrorTimer[FATIGUE_TIMER] >= DarkWaterTime || !isAlive())
            StopMirrorTimer(FATIGUE_TIMER);
        else if (m_MirrorTimerFlagsLast & UNDERWATER_INDARKWATER)
            SendMirrorTimer(FATIGUE_TIMER, DarkWaterTime, m_MirrorTimer[FATIGUE_TIMER], 10);
    }

    if (m_MirrorTimerFlags & (UNDERWATER_INLAVA|UNDERWATER_INSLIME))
    {
        // Breath timer not activated - activate it
        if (m_MirrorTimer[FIRE_TIMER] == DISABLED_MIRROR_TIMER)
            m_MirrorTimer[FIRE_TIMER] = getMaxTimer(FIRE_TIMER);
        else
        {
            m_MirrorTimer[FIRE_TIMER]-=time_diff;
            if (m_MirrorTimer[FIRE_TIMER] < 0)
            {
                m_MirrorTimer[FIRE_TIMER]+= 1*IN_MILISECONDS;
                // Calculate and deal damage
                // TODO: Check this formula
                uint32 damage = urand(600, 700);
                if (m_MirrorTimerFlags&UNDERWATER_INLAVA)
                    EnvironmentalDamage(DAMAGE_LAVA, damage);
                else if (m_zoneUpdateId != 1497)
                    EnvironmentalDamage(DAMAGE_SLIME, damage);
            }
        }
    }
    else
        m_MirrorTimer[FIRE_TIMER] = DISABLED_MIRROR_TIMER;

    // Recheck timers flag
    m_MirrorTimerFlags&=~UNDERWATER_EXIST_TIMERS;
    for (uint8 i = 0; i< MAX_TIMERS; ++i)
        if (m_MirrorTimer[i] != DISABLED_MIRROR_TIMER)
        {
            m_MirrorTimerFlags|=UNDERWATER_EXIST_TIMERS;
            break;
        }
    m_MirrorTimerFlagsLast = m_MirrorTimerFlags;
}

///The player sobers by 256 every 10 seconds
void Player::HandleSobering()
{
    m_drunkTimer = 0;

    uint32 drunk = (m_drunk <= 256) ? 0 : (m_drunk - 256);
    SetDrunkValue(drunk);
}

DrunkenState Player::GetDrunkenstateByValue(uint16 value)
{
    if (value >= 23000)
        return DRUNKEN_SMASHED;
    if (value >= 12800)
        return DRUNKEN_DRUNK;
    if (value & 0xFFFE)
        return DRUNKEN_TIPSY;
    return DRUNKEN_SOBER;
}

void Player::SetDrunkValue(uint16 newDrunkenValue, uint32 itemId)
{
    uint32 oldDrunkenState = Player::GetDrunkenstateByValue(m_drunk);

    m_drunk = newDrunkenValue;
    SetUInt32Value(PLAYER_BYTES_3,(GetUInt32Value(PLAYER_BYTES_3) & 0xFFFF0001) | (m_drunk & 0xFFFE));

    uint32 newDrunkenState = Player::GetDrunkenstateByValue(m_drunk);

    // special drunk invisibility detection
    if (newDrunkenState >= DRUNKEN_DRUNK)
        m_detectInvisibilityMask |= (1<<6);
    else
        m_detectInvisibilityMask &= ~(1<<6);

    if (newDrunkenState == oldDrunkenState)
        return;

    WorldPacket data(SMSG_CROSSED_INEBRIATION_THRESHOLD, (8+4+4));
    data << uint64(GetGUID());
    data << uint32(newDrunkenState);
    data << uint32(itemId);

    BroadcastPacket(&data, true);
}

void Player::CreateCharmAI()
{
    switch (getClass())
    {
        case CLASS_WARRIOR:
            i_AI = new WarriorAI(this);
            break;
        case CLASS_PALADIN:
            i_AI = new PaladinAI(this);
            break;
        case CLASS_HUNTER:
            i_AI = new HunterAI(this);
            break;
        case CLASS_ROGUE:
            i_AI = new RogueAI(this);
            break;
        case CLASS_PRIEST:
            i_AI = new PriestAI(this);
            break;
        case CLASS_SHAMAN:
            i_AI = new ShamanAI(this);
            break;
        case CLASS_MAGE:
            i_AI = new MageAI(this);
            break;
        case CLASS_WARLOCK:
            i_AI = new WarlockAI(this);
            break;
        case CLASS_DRUID:
            i_AI = new DruidAI(this);
            break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: Unhandled class type, while creating charmAI");
            break;
    }
}

void Player::DeleteCharmAI()
{
    if (i_AI)
        delete i_AI;
}

void Player::CharmAI(bool apply)
{
    if (IsAIEnabled = apply)
        AI()->Reset();

    GetMotionMaster()->MovementExpired();
}

void Player::Update(uint32 update_diff, uint32 p_time)
{
    if (!IsInWorld() || _preventUpdate)
        return;

    updateMutex.acquire();

    _preventUpdate = true;

    if (m_AC_timer)
    {
        if (m_AC_timer < update_diff)
            m_AC_timer = 0;
        else
            m_AC_timer -= update_diff;
    }

    positionStatus.Update(update_diff);

    // undelivered mail
    if (m_nextMailDelivereTime && m_nextMailDelivereTime <= time(NULL))
    {
        SendNewMail();
        ++unReadMails;

        // It will be recalculate at mailbox open (for unReadMails important non-0 until mailbox open, it also will be recalculated)
        m_nextMailDelivereTime = 0;
    }

    Unit::Update(update_diff, p_time);

    time_t now = time(NULL);

    UpdatePvPFlag(now);

    UpdateContestedPvP(update_diff);

    UpdateDuelFlag(now);

    CheckDuelDistance(now);

    UpdateAfkReport(now);

    // do not allow the AI to be changed during update
    if (IsAIEnabled)
    {
        m_AI_locked = true;
        i_AI->UpdateAI(p_time);
        m_AI_locked = false;
    }

    // Update items that have just a limited lifetime
    if (now>m_Last_tick)
        UpdateItemDuration(uint32(now- m_Last_tick));

    if (!m_timedquests.empty())
    {
        std::set<uint32>::iterator iter = m_timedquests.begin();
        while (iter != m_timedquests.end())
        {
            QuestStatusData& q_status = mQuestStatus[*iter];
            if (q_status.m_timer <= update_diff)
            {
                uint32 quest_id  = *iter;
                ++iter;                                     // current iter will be removed in FailTimedQuest
                FailTimedQuest(quest_id);
            }
            else
            {
                q_status.m_timer -= update_diff;
                if (q_status.uState != QUEST_NEW)
                    q_status.uState = QUEST_CHANGED;

                ++iter;
            }
        }
    }

    if (hasUnitState(UNIT_STAT_MELEE_ATTACKING) && !hasUnitState(UNIT_STAT_CANNOT_AUTOATTACK))
    {
        if (Unit *pVictim = getVictim())
        {
            if (isAttackReady(BASE_ATTACK))
            {
                if (!IsWithinMeleeRange(pVictim))
                {
                    setAttackTimer(BASE_ATTACK,100);
                    if (m_swingErrorMsg != 1)                // send single time (client auto repeat)
                    {
                        SendAttackSwingNotInRange();
                        m_swingErrorMsg = 1;
                    }
                }
                //120 degrees of radiant range
                else if (!HasInArc(2*M_PI/3, pVictim))
                {
                    setAttackTimer(BASE_ATTACK,100);
                    if (m_swingErrorMsg != 2)                // send single time (client auto repeat)
                    {
                        SendAttackSwingBadFacingAttack();
                        m_swingErrorMsg = 2;
                    }
                }
                else
                {
                    m_swingErrorMsg = 0;                    // reset swing error state

                    // prevent base and off attack in same time, delay attack at 0.2 sec
                    if (haveOffhandWeapon())
                    {
                        uint32 off_att = getAttackTimer(OFF_ATTACK);
                        if (off_att < ATTACK_DISPLAY_DELAY)
                            setAttackTimer(OFF_ATTACK,ATTACK_DISPLAY_DELAY);
                    }
                    AttackerStateUpdate(pVictim, BASE_ATTACK);
                    resetAttackTimer(BASE_ATTACK);
                }
            }

            if (haveOffhandWeapon() && isAttackReady(OFF_ATTACK))
            {
                if (!IsWithinMeleeRange(pVictim))
                {
                    setAttackTimer(OFF_ATTACK,100);
                }
                else if (!HasInArc(2*M_PI/3, pVictim))
                {
                    setAttackTimer(OFF_ATTACK,100);
                }
                else
                {
                    // prevent base and off attack in same time, delay attack at 0.2 sec
                    uint32 base_att = getAttackTimer(BASE_ATTACK);
                    if (base_att < ATTACK_DISPLAY_DELAY)
                        setAttackTimer(BASE_ATTACK,ATTACK_DISPLAY_DELAY);
                    // do attack
                    AttackerStateUpdate(pVictim, OFF_ATTACK);
                    resetAttackTimer(OFF_ATTACK);
                }
            }
        }
    }

    if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING))
    {
        if (roll_chance_i(3) && GetTimeInnEnter() > 0)       //freeze update
        {
            int time_inn = time(NULL)-GetTimeInnEnter();
            if (time_inn >= 10)                             //freeze update
            {
                float bubble = 0.125*sWorld.getRate(RATE_REST_INGAME);
                                                            //speed collect rest bonus (section/in hour)
                SetRestBonus(GetRestBonus()+ time_inn*((float)GetUInt32Value(PLAYER_NEXT_LEVEL_XP)/72000)*bubble);
                UpdateInnerTime(time(NULL));
            }
        }
    }

    if (m_regenTimer > 0)
    {
        if (update_diff >= m_regenTimer)
            m_regenTimer = 0;
        else
            m_regenTimer -= update_diff;
    }

    if (m_weaponChangeTimer > 0)
    {
        if (update_diff >= m_weaponChangeTimer)
            m_weaponChangeTimer = 0;
        else
            m_weaponChangeTimer -= update_diff;
    }

    if (m_zoneUpdateTimer > 0)
    {
        if (update_diff >= m_zoneUpdateTimer)
        {
            uint32 newzone = GetZoneId();
            if (m_zoneUpdateId != newzone)
                UpdateZone(newzone);                        // also update area
            else
            {
                // use area updates as well
                // needed for free far all arenas for example
                uint32 newarea = GetAreaId();
                if (m_areaUpdateId != newarea)
                    UpdateArea(newarea);

                m_zoneUpdateTimer = ZONE_UPDATE_INTERVAL;
            }
        }
        else
            m_zoneUpdateTimer -= update_diff;
    }

    if (m_timeSyncTimer > 0)
    {
        if (update_diff >= m_timeSyncTimer)
            SendTimeSync();
        else
            m_timeSyncTimer -= update_diff;
    }

    if (isAlive())
        RegenerateAll();

    if (m_deathState == JUST_DIED)
        KillPlayer();

    if (m_nextSave > 0)
    {
        if (update_diff >= m_nextSave)
        {
            // m_nextSave reseted in SaveToDB call
            SaveToDB();
            sLog.outDetail("Player '%s' (GUID: %u) saved", GetName(), GetGUIDLow());
        }
        else
            m_nextSave -= update_diff;
    }

    //Handle drowning
    HandleDrowning(update_diff);

    //Handle detect stealth players
    if (m_DetectInvTimer > 0)
    {
        if (update_diff >= m_DetectInvTimer)
        {
            HandleStealthedUnitsDetection();
            m_DetectInvTimer = InArena() ? 1000 : 3000;
        }
        else
            m_DetectInvTimer -= update_diff;
    }

    // Played time
    if (now > m_Last_tick)
    {
        uint32 elapsed = uint32(now - m_Last_tick);
        m_Played_time[0] += elapsed;                        // Total played time
        m_Played_time[1] += elapsed;                        // Level played time
        m_Last_tick = now;
    }

    if (m_drunk)
    {
        m_drunkTimer += update_diff;

        if (m_drunkTimer > 10000)
            HandleSobering();
    }

    // not auto-free ghost from body in instances
    if (m_deathTimer > 0  && !GetMap()->Instanceable())
    {
        if (update_diff >= m_deathTimer)
        {
            m_deathTimer = 0;
            BuildPlayerRepop();
            RepopAtGraveyard();
        }
        else
            m_deathTimer -= update_diff;
    }

    UpdateEnchantTime(update_diff);
    UpdateHomebindTime(update_diff);

    if (!_instanceResetTimes.empty())
    {
        for (InstanceTimeMap::iterator itr = _instanceResetTimes.begin(); itr != _instanceResetTimes.end();)
        {
            if (itr->second < now)
                _instanceResetTimes.erase(itr++);
            else
                ++itr;
        }
    }

    // group update
    SendUpdateToOutOfRangeGroupMembers();

    _preventUpdate = false;
    updateMutex.release();
}

void Player::setDeathState(DeathState s)
{
    uint32 ressSpellId = 0;

    bool cur = isAlive();

    if (s == JUST_DIED)
    {
        if (!cur)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: setDeathState: attempt to kill a dead player %s(%d)", GetName(), GetGUIDLow());
            return;
        }

        // drunken state is cleared on death
        SetDrunkValue(0);
        // lost combo points at any target (targeted combo points clear in Unit::setDeathState)
        ClearComboPoints();

        clearResurrectRequestData();

        // remove form before other mods to prevent incorrect stats calculation
        RemoveAurasDueToSpell(m_ShapeShiftFormSpellId);

        //FIXME: is pet dismissed at dying or releasing spirit? if second, add setDeathState(DEAD) to HandleRepopRequestOpcode and define pet unsummon here with (s == DEAD)
        RemovePet(NULL, PET_SAVE_NOT_IN_SLOT, true, true);

        // remove uncontrolled pets
        RemoveMiniPet();
        RemoveGuardians();

        // save value before aura remove in Unit::setDeathState
        ressSpellId = GetUInt32Value(PLAYER_SELF_RES_SPELL);

        // passive spell
        if (!ressSpellId)
            ressSpellId = GetResurrectionSpellId();
    }
    Unit::setDeathState(s);

    // restore resurrection spell id for player after aura remove
    if (s == JUST_DIED && cur && ressSpellId)
        SetUInt32Value(PLAYER_SELF_RES_SPELL, ressSpellId);

    if (isAlive() && !cur)
    {
        //clear aura case after resurrection by another way (spells will be applied before next death)
        SetUInt32Value(PLAYER_SELF_RES_SPELL, 0);

        // restore default warrior stance
        if (getClass() == CLASS_WARRIOR)
            CastSpell(this,SPELL_ID_PASSIVE_BATTLE_STANCE,true);
    }
}

bool Player::BuildEnumData(QueryResultAutoPtr result, WorldPacket * p_data)
{
    Field *fields = result->Fetch();
    uint32 guid = fields[0].GetUInt32();
    uint8 pRace = fields[2].GetUInt8();
    uint8 pClass = fields[3].GetUInt8();
    PlayerInfo const *info = sObjectMgr.GetPlayerInfo(pRace, pClass);
    if (!info)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player %u has incorrect race/class pair. Don't build enum.", guid);
        return false;
    }

    *p_data << uint64(MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER));
    *p_data << fields[1].GetString();                       // name
    *p_data << uint8(pRace);                                // race
    *p_data << uint8(pClass);                               // class
    *p_data << uint8(fields[4].GetUInt8());                 // gender
    uint32 playerBytes = fields[5].GetUInt32();
    *p_data << uint8(playerBytes);                          // skin
    *p_data << uint8(playerBytes >> 8);                     // face
    *p_data << uint8(playerBytes >> 16);                    // hair style
    *p_data << uint8(playerBytes >> 24);                    // hair color

    uint32 playerBytes2 = fields[6].GetUInt32();
    *p_data << uint8(playerBytes2 & 0xFF);                  // facial hair
    *p_data << uint8(fields[7].GetUInt8());                 // level
    *p_data << uint32(fields[8].GetUInt32());               // zone
    *p_data << uint32(fields[9].GetUInt32());               // map

    *p_data << fields[10].GetFloat();                       // x
    *p_data << fields[11].GetFloat();                       // y
    *p_data << fields[12].GetFloat();                       // z

    *p_data << (result ? result->Fetch()[13].GetUInt32() : 0);

    uint32 char_flags = 0;
    uint32 playerFlags = fields[14].GetUInt32();
    uint32 atLoginFlags = fields[15].GetUInt32();
    if (playerFlags & PLAYER_FLAGS_HIDE_HELM)
        char_flags |= CHARACTER_FLAG_HIDE_HELM;
    if (playerFlags & PLAYER_FLAGS_HIDE_CLOAK)
        char_flags |= CHARACTER_FLAG_HIDE_CLOAK;
    if (playerFlags & PLAYER_FLAGS_GHOST)
        char_flags |= CHARACTER_FLAG_GHOST;
    if (atLoginFlags & AT_LOGIN_RENAME)
        char_flags |= CHARACTER_FLAG_RENAME;
    if (sWorld.getConfig(CONFIG_DECLINED_NAMES_USED))
    {
        if (!fields[20].GetCppString().empty())
            char_flags |= CHARACTER_FLAG_DECLINED;
    }
    else
        char_flags |= CHARACTER_FLAG_DECLINED;

    *p_data << uint32(char_flags);                          // character flags

    *p_data << uint8(1);                                    // unknown

    // Pets info
    {
        uint32 petDisplayId = 0;
        uint32 petLevel   = 0;
        uint32 petFamily  = 0;

        // show pet at selection character in character list only for non-ghost character
        if (result && !(playerFlags & PLAYER_FLAGS_GHOST) && (pClass == CLASS_WARLOCK || pClass == CLASS_HUNTER))
        {
            uint32 entry = fields[16].GetUInt32();
            CreatureInfo const* cInfo = sCreatureStorage.LookupEntry<CreatureInfo>(entry);
            if (cInfo)
            {
                petDisplayId = fields[17].GetUInt32();
                petLevel     = fields[18].GetUInt32();
                petFamily    = cInfo->family;
            }
        }

        *p_data << uint32(petDisplayId);
        *p_data << uint32(petLevel);
        *p_data << uint32(petFamily);
    }
    Tokens data = StrSplit(fields[19].GetCppString(), " ");
    for (uint8 slot = 0; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        uint32 visualbase = PLAYER_VISIBLE_ITEM_1_0 + (slot * MAX_VISIBLE_ITEM_OFFSET);
        uint32 item_id = GetUInt32ValueFromArray(data, visualbase);
        const ItemPrototype * proto = ObjectMgr::GetItemPrototype(item_id);
        if (!proto)
        {
            *p_data << uint32(0);
            *p_data << uint8(0);
            *p_data << uint32(0);
            continue;
        }

        SpellItemEnchantmentEntry const *enchant = NULL;

        for (uint8 enchantSlot = PERM_ENCHANTMENT_SLOT; enchantSlot <= TEMP_ENCHANTMENT_SLOT; ++enchantSlot)
        {
            uint32 enchantId = GetUInt32ValueFromArray(data, visualbase+1+enchantSlot);
            if (!enchantId)
                continue;

            if (enchant = sSpellItemEnchantmentStore.LookupEntry(enchantId))
                break;
        }

        *p_data << uint32(proto->DisplayInfoID);
        *p_data << uint8(proto->InventoryType);
        *p_data << uint32(enchant ? enchant->aura_id : 0);
    }
    *p_data << uint32(0);                                   // first bag display id
    *p_data << uint8(0);                                    // first bag inventory type
    *p_data << uint32(0);                                   // enchant?

    return true;
}

bool Player::ToggleAFK()
{
    ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_AFK);

    // afk player not allowed in battleground
    if (isAFK() && InBattleGround() && !InArena())
        LeaveBattleground();

    return isAFK();
}

bool Player::ToggleDND()
{
    ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_DND);

    return HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_DND);
}

uint8 Player::chatTag() const
{
    // it's bitmask
    // 0x8 - ??
    // 0x4 - gm
    // 0x2 - dnd
    // 0x1 - afk
    if (isGMChat())
        return 4;
    else if (isDND())
        return 3;
    if (isAFK())
        return 1;
    else
        return 0;
}

bool Player::TeleportTo(uint32 mapid, float x, float y, float z, float orientation, uint32 options)
{
    if (!MapManager::IsValidMapCoord(mapid, x, y, z, orientation))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: TeleportTo: invalid map %d or absent instance template.", mapid);
        return false;
    }

    if (!GetSession()->HasPermissions(PERM_ADM) && !sWorld.IsAllowedMap(mapid))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player %s tried to enter a forbidden map", GetName());
        return false;
    }

    // preparing unsummon pet if lost (we must get pet before teleportation or will not find it later)
    Pet* pet = GetPet();

    MapEntry const* mEntry = sMapStore.LookupEntry(mapid);

    // don't let enter battlegrounds without assigned battleground id (for example through areatrigger)...
    // don't let gm level > 1 either
    if (!InBattleGround() && mEntry->IsBattleGroundOrArena())
        return false;

    // 449 - Champions' Hall (Alliance) // 450 - Hall of Legends (Horde)
    if (mapid == 449 && GetTeam()==HORDE && !isGameMaster())
    {
        GetSession()->SendNotification(LANG_NO_ENTER_CHAMPIONS_HALL);
        return false;
    }

    if (mapid == 450 && GetTeam() == ALLIANCE && !isGameMaster())
    {
        GetSession()->SendNotification(LANG_NO_ENTER_HALL_OF_LEGENDS);
        return false;
    }

    // client without expansion support
    if (GetSession()->Expansion() < mEntry->Expansion())
    {
        sLog.outDebug("Player %s using client without required expansion tried teleport to non accessible map %u", GetName(), mapid);

        if (GetTransport())
            RepopAtGraveyard();                             // teleport to near graveyard if on transport, looks blizz like :)

        SendTransferAborted(mapid, TRANSFER_ABORT_INSUF_EXPAN_LVL1);
        return false;                                       // normal client can't teleport to this map...
    }
    else
    {
        sLog.outDebug("Player %s will teleported to map %u", GetName(), mapid);
    }

    // if we were on a transport, leave
    if (!(options & TELE_TO_NOT_LEAVE_TRANSPORT) && m_transport)
    {
        m_transport->RemovePassenger(this);
        m_transport = NULL;
        m_movementInfo.ClearTransportData();
    }

    SetSemaphoreTeleport(true);

    m_AC_timer = 3000;

    // The player was ported to another map and looses the duel immediatly.
    // We have to perform this check before the teleport, otherwise the
    // ObjectAccessor won't find the flag.
    if (duel && GetMapId() != mapid)
    {
        GameObject* obj = GetMap()->GetGameObject(GetUInt64Value(PLAYER_DUEL_ARBITER));
        if (obj)
            DuelComplete(DUEL_FLED);
    }

    // reset movement flags at teleport, because player will continue move with these flags after teleport
    m_movementInfo.SetMovementFlags(MOVEFLAG_NONE);
    DisableSpline();

    if ((GetMapId() == mapid) && (!m_transport))
    {
        // prepare zone change detect
        uint32 old_zone = GetZoneId();

        WorldLocation tmpWLoc(mapid, x, y, z, orientation);

        if (!IsWithinDistInMap(&tmpWLoc, GetMap()->GetVisibilityDistance()))
            DestroyForNearbyPlayers();

        // near teleport
        if (!GetSession()->PlayerLogout())
        {
            // send transfer packet to display load screen
            WorldPacket data;
            BuildTeleportAckMsg(data, x, y, z, orientation);
            SendPacketToSelf(&data);
            SetPosition(x, y, z, orientation, true);
        }
        else
            // this will be used instead of the current location in SaveToDB
            m_teleport_dest = tmpWLoc;

        SetFallInformation(0, z);

        if (!(options & TELE_TO_NOT_UNSUMMON_PET))
        {
            //same map, only remove pet if out of range
            if (pet && !IsWithinDistInMap(pet, OWNER_MAX_DISTANCE))
            {
                if (pet->isControlled() && !pet->isTemporarySummoned())
                    m_temporaryUnsummonedPetNumber = pet->GetCharmInfo()->GetPetNumber();
                else
                    m_temporaryUnsummonedPetNumber = 0;

                RemovePet(pet, PET_SAVE_NOT_IN_SLOT);
            }
        }

        if (!(options & TELE_TO_NOT_LEAVE_COMBAT))
            CombatStop();

        if (!(options & TELE_TO_NOT_UNSUMMON_PET))
        {
            // resummon pet
            if (pet && m_temporaryUnsummonedPetNumber)
            {
                Pet* NewPet = new Pet;
                if (!NewPet->LoadPetFromDB(this, 0, m_temporaryUnsummonedPetNumber, true))
                    delete NewPet;

                m_temporaryUnsummonedPetNumber = 0;
            }
        }

        // near teleport, triggering send MSG_MOVE_TELEPORT_ACK from client at landing
        if (!GetSession()->PlayerLogout())
        {
            // don't reset teleport semaphore while logging out, otherwise m_teleport_dest won't be used in Player::SaveToDB
            SetSemaphoreTeleport(false);
            UpdateZone(GetZoneId());
        }

        // new zone
        if (old_zone != GetZoneId())
        {
            // honorless target
            if (pvpInfo.inHostileArea)
                CastSpell(this, 2479, true);
        }

        if (getFollowingGM())
        {
            setGMFollow(0);
        }
        else if (getFollowTarget())
        {
            setFollowTarget(0);
            GetMotionMaster()->Clear(true);
        }
    }
    else
    {
        // far teleport to another map
        Map* oldmap = IsInWorld() ? GetMap() : NULL;
        // check if we can enter before stopping combat / removing pet / totems / interrupting spells

        // Check enter rights before map getting to avoid creating instance copy for player
        // this check not dependent from map instance copy and same for all instance copies of selected map
        if (!sMapMgr.CanPlayerEnter(mapid, this))
        {
            SetSemaphoreTeleport(false);
            return false;
        }

        if (InstanceGroupBind *igb = GetGroup() ? GetGroup()->GetBoundInstance(mapid, GetDifficulty()) : NULL)
        {
            if (Map *iMap = sMapMgr.FindMap(mapid,igb->save->GetInstanceId()))
            {
                if (iMap->EncounterInProgress(this))
                {
                    SetSemaphoreTeleport(false);
                    return false;
                }
            }
        }

        // If the map is not created, assume it is possible to enter it.
        // It will be created in the WorldPortAck.
        Map *map = sMapMgr.FindMap(mapid);
        if (!map || map->CanEnter(this))
        {
            SetSelection(0);
            CombatStop();
            ResetContestedPvP();

            // remove player from battleground on far teleport (when changing maps)
            if (BattleGround const* bg = GetBattleGround())
            {
                // Note: at battleground join battleground id set before teleport
                // and we already will found "current" battleground
                // just need check that this is targeted map or leave
                if (bg->GetMapId() != mapid)
                    LeaveBattleground(false);                   // don't teleport to entry point
            }

            // remove pet on map change
            if (pet)
            {
                //leaving map -> delete pet right away (doing this later will cause problems)
                if (pet->isControlled() && !pet->isTemporarySummoned())
                    m_temporaryUnsummonedPetNumber = pet->GetCharmInfo()->GetPetNumber();
                else
                    m_temporaryUnsummonedPetNumber = 0;

                RemovePet(pet, PET_SAVE_NOT_IN_SLOT);
            }

            // remove all dyn objects
            RemoveAllDynObjects();

            // stop spellcasting
            // not attempt interrupt teleportation spell at caster teleport
            if (!(options & TELE_TO_SPELL))
                if (IsNonMeleeSpellCasted(true))
                    InterruptNonMeleeSpells(true);

            //remove auras before removing from map...
            RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CHANGE_MAP | AURA_INTERRUPT_FLAG_MOVE | AURA_INTERRUPT_FLAG_TURNING);
            if (mEntry->IsRaid())
                RemoveAurasDueToRaidTeleport();

            if (!GetSession()->PlayerLogout())
            {
                // send transfer packets
                WorldPacket data(SMSG_TRANSFER_PENDING, (4+4+4));
                data << uint32(mapid);
                if (m_transport)
                {
                    data << uint32(m_transport->GetEntry());
                    data << uint32(GetMapId());
                }
                SendPacketToSelf(&data);

                data.Initialize(SMSG_NEW_WORLD, (20));
                if (m_transport)
                {
                    data << uint32(mapid);
                    data << float(m_movementInfo.GetTransportPos()->x);
                    data << float(m_movementInfo.GetTransportPos()->y);
                    data << float(m_movementInfo.GetTransportPos()->z);
                    data << float(m_movementInfo.GetTransportPos()->o);
                }
                else
                {
                    data << uint32(mapid);
                    data << float(x);
                    data << float(y);
                    data << float(z);
                    data << float(orientation);
                }

                SendPacketToSelf(&data);
                SendSavedInstances();

                if (getFollowingGM())
                {
                    setGMFollow(0);
                }
                else if (getFollowTarget())
                {
                    setFollowTarget(0);
                    GetMotionMaster()->Clear(true);
                }

                // remove from old map now
                if(oldmap)
                    oldmap->Remove(this, false);
            }

            // new final coordinates
            float final_x = x;
            float final_y = y;
            float final_z = z;
            float final_o = orientation;

            if (m_transport)
            {
                final_x += m_movementInfo.GetTransportPos()->x;
                final_y += m_movementInfo.GetTransportPos()->y;
                final_z += m_movementInfo.GetTransportPos()->z;
                final_o += m_movementInfo.GetTransportPos()->o;
            }

            m_teleport_dest = WorldLocation(mapid, final_x, final_y, final_z, final_o);

            SetFallInformation(0, final_z);
            // if the player is saved before worldportack (at logout for example)
            // this will be used instead of the current location in SaveToDB
        }
        else
            return false;
    }

    return true;
}

void Player::AddToWorld()
{
    ///- Do not add/remove the player from the object storage
    ///- It will crash when updating the ObjectAccessor
    ///- The player should only be added when logging in
    Unit::AddToWorld();

    //Mentoren Program
    if (isMenteeWithoutMentor())
        ChatHandler(GetSession()).SendGlobalMentoringSysMessage("Der Mentee '%s' hat die Welt betreten! Willst du sein Mentor sein, dann tippe: '.mentoring %s' und melde dich einfach mal bei ihm ;)", GetName(), GetName());
   
    if (GetOnlineChar(isMenteeOfAccount()))    
        if (GetPlayer(GetOnlineChar(isMenteeOfAccount()))->isMentor())
            ChatHandler(GetPlayer(GetOnlineChar(isMenteeOfAccount()))).PSendSysMessage("Dein Mentee '%s' hat die Welt betreten!", GetName());

    for (int i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; i++)
    {
        if (m_items[i])
            m_items[i]->AddToWorld();
    }
}

void Player::RemoveFromWorld()
{
    // cleanup
    if (IsInWorld())
    {
        ///- Release charmed creatures, unsummon totems and remove pets/guardians
        StopCastingCharm();
        StopCastingBindSight();
        UnsummonAllTotems();
        RemoveMiniPet();
        RemoveGuardians();
    }

    sOutdoorPvPMgr.HandlePlayerLeave(this);

    for (int i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; i++)
    {
        if (m_items[i])
            m_items[i]->RemoveFromWorld();
    }

    ///- Do not add/remove the player from the object storage
    ///- It will crash when updating the ObjectAccessor
    ///- The player should only be removed when logging out
    Unit::RemoveFromWorld();
}

void Player::RewardRage(uint32 damage, uint32 weaponSpeedHitFactor, bool attacker)
{
    float addRage;

    float rageconversion = ((0.0091107836 * getLevel()*getLevel())+3.225598133*getLevel())+4.2652911;

    if (attacker)
    {
        addRage = ((damage/rageconversion*7.5 + weaponSpeedHitFactor)/2);

        if (addRage > 15*damage/rageconversion)
            addRage = 15*damage/rageconversion;

        // talent who gave more rage on attack
        addRage *= 1.0f + GetTotalAuraModifier(SPELL_AURA_MOD_RAGE_FROM_DAMAGE_DEALT) / 100.0f;
    }
    else
    {
        addRage = (damage/rageconversion)*2.5;

        // Berserker Rage effect
        if (HasAura(18499,0))
            addRage *= 2.0f;
    }

    addRage *= sWorld.getRate(RATE_POWER_RAGE_INCOME);

    ModifyPower(POWER_RAGE, uint32(addRage*10));
}

void Player::RegenerateAll()
{
    if (m_regenTimer != 0)
        return;
    uint32 regenDelay = 2000;

    // Not in combat or they have regeneration
    if (!isInCombat() || HasAuraType(SPELL_AURA_MOD_REGEN_DURING_COMBAT) ||
        HasAuraType(SPELL_AURA_MOD_HEALTH_REGEN_IN_COMBAT) || IsPolymorphed())
    {
        RegenerateHealth();
        if (!isInCombat() && !HasAuraType(SPELL_AURA_INTERRUPT_REGEN))
            Regenerate(POWER_RAGE);
    }

    Regenerate(POWER_ENERGY);

    Regenerate(POWER_MANA);

    m_regenTimer = regenDelay;
}

void Player::Regenerate(Powers power)
{
    uint32 curValue = GetPower(power);
    uint32 maxValue = GetMaxPower(power);

    float addvalue = 0.0f;

    switch (power)
    {
        case POWER_MANA:
        {
            bool recentCast = IsUnderLastManaUseEffect();
            float ManaIncreaseRate = sWorld.getRate(RATE_POWER_MANA);
            if (recentCast)
            {
                // Trinity Updates Mana in intervals of 2s, which is correct
                addvalue = GetFloatValue(PLAYER_FIELD_MOD_MANA_REGEN_INTERRUPT) *  ManaIncreaseRate * 2.00f;
            }
            else
            {
                addvalue = GetFloatValue(PLAYER_FIELD_MOD_MANA_REGEN) * ManaIncreaseRate * 2.00f;
            }
        }   break;
        case POWER_RAGE:                                    // Regenerate rage
        {
            float RageDecreaseRate = sWorld.getRate(RATE_POWER_RAGE_LOSS);

            int mult = 30;
            const AuraList &auras = GetAurasByType(SPELL_AURA_MOD_POWER_REGEN);
            for (AuraList::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
            {
                if ((*itr)->GetSpellProto()->Id == 12296)
                {
                    mult = 20;
                    break;
                }
            }
            addvalue = mult * RageDecreaseRate;               // 3 rage by tick
        }   break;
        case POWER_ENERGY:                                  // Regenerate energy (rogue)
            addvalue = 20;
            break;
        case POWER_FOCUS:
        case POWER_HAPPINESS:
            break;
    }

    // Mana regen calculated in Player::UpdateManaRegen()
    // Exist only for POWER_MANA, POWER_ENERGY, POWER_FOCUS auras
    if (power != POWER_MANA)
    {
        AuraList const& ModPowerRegenPCTAuras = GetAurasByType(SPELL_AURA_MOD_POWER_REGEN_PERCENT);
        for (AuraList::const_iterator i = ModPowerRegenPCTAuras.begin(); i != ModPowerRegenPCTAuras.end(); ++i)
            if ((*i)->GetModifier()->m_miscvalue == power)
                addvalue *= ((*i)->GetModifierValue() + 100) / 100.0f;
    }

    if (power != POWER_RAGE)
    {
        curValue += uint32(addvalue);
        if (curValue > maxValue)
            curValue = maxValue;
    }
    else
    {
        if (curValue <= uint32(addvalue))
            curValue = 0;
        else
            curValue -= uint32(addvalue);
    }
    SetPower(power, curValue);
}

void Player::RegenerateHealth()
{
    uint32 curValue = GetHealth();
    uint32 maxValue = GetMaxHealth();

    if (curValue >= maxValue) return;

    float HealthIncreaseRate = sWorld.getRate(RATE_HEALTH);

    float addvalue = 0.0f;

    // polymorphed case
    if (IsPolymorphed())
        addvalue = GetMaxHealth()/3;
    // normal regen case (maybe partly in combat case)
    else if (!isInCombat() || HasAuraType(SPELL_AURA_MOD_REGEN_DURING_COMBAT))
    {
        addvalue = OCTRegenHPPerSpirit()* HealthIncreaseRate;
        if (!isInCombat())
        {
            AuraList const& mModHealthRegenPct = GetAurasByType(SPELL_AURA_MOD_HEALTH_REGEN_PERCENT);
            for (AuraList::const_iterator i = mModHealthRegenPct.begin(); i != mModHealthRegenPct.end(); ++i)
                addvalue *= (100.0f + (*i)->GetModifierValue()) / 100.0f;
        }
        else if (HasAuraType(SPELL_AURA_MOD_REGEN_DURING_COMBAT))
            addvalue *= GetTotalAuraModifier(SPELL_AURA_MOD_REGEN_DURING_COMBAT) / 100.0f;

        if (!IsStandState())
            addvalue *= 1.5;
    }

    // always regeneration bonus (including combat)
    addvalue += GetTotalAuraModifier(SPELL_AURA_MOD_HEALTH_REGEN_IN_COMBAT);

    if (addvalue < 0)
        addvalue = 0;

    ModifyHealth(int32(addvalue));
}

bool Player::CanInteractWithNPCs(bool alive) const
{
    if (alive && !isAlive())
        return false;
    if (IsTaxiFlying())
        return false;

    return true;
}

Creature* Player::GetNPCIfCanInteractWith(uint64 guid, uint32 npcflagmask)
{
    // unit checks
    if (!guid)
        return NULL;

    // exist
    Creature *unit = GetMap()->GetCreature(guid);
    if (!unit)
        return NULL;

    // player check
    if (!CanInteractWithNPCs(!unit->isSpiritService() && !(unit->GetCreatureInfo()->type_flags & CREATURE_TYPEFLAGS_GHOST)))
        return NULL;

    if (IsHostileTo(unit))
        return NULL;

    // appropriate npc type
    if (npcflagmask && !unit->HasFlag(UNIT_NPC_FLAGS, npcflagmask))
        return NULL;

    // alive or spirit healer
    if (!unit->isAlive() && (!unit->isSpiritService() || isAlive()))
        return NULL;

    // not allow interaction under control
    if (unit->GetCharmerGUID())
        return NULL;

    // not enemy
    if (unit->IsHostileTo(this))
        return NULL;

    // not unfriendly
    FactionTemplateEntry const* factionTemplate = sFactionTemplateStore.LookupEntry(unit->getFaction());
    if (factionTemplate)
    {
        // check forced reactions if exist
        if (ReputationRank const * rank = m_reputationMgr.GetForcedRankIfAny(factionTemplate))
        {
            if ((*rank) <= REP_UNFRIENDLY)
                return NULL;
        }
        else    // normal case
        {
            FactionEntry const* faction = sFactionStore.LookupEntry(factionTemplate->faction);
            if (faction->reputationListID >= 0 && m_reputationMgr.GetRank(faction) <= REP_UNFRIENDLY)
                return NULL;
        }
    }

    // not too far
    if (!unit->IsWithinDistInMap(this, INTERACTION_DISTANCE))
        return NULL;

    return unit;
}

GameObject* Player::GetGameObjectIfCanInteractWith(uint64 guid, GameobjectTypes type) const
{
    if (GameObject *gObject = GetMap()->GetGameObject(guid))
    {
        if (gObject->GetGoType() == type)
        {
            float maxdist;
            switch (type)
            {
                case GAMEOBJECT_TYPE_GUILD_BANK:
                case GAMEOBJECT_TYPE_MAILBOX:
                    maxdist = 10.0f;
                    break;
                case GAMEOBJECT_TYPE_FISHINGHOLE:
                    maxdist = 20.0f + CONTACT_DISTANCE;       // max spell range
                    break;
                default:
                    maxdist = INTERACTION_DISTANCE;
                    break;
            }

            if (gObject->IsWithinDistInMap(this, maxdist))
                return gObject;
        }
    }
    return NULL;
}

bool Player::IsUnderWater() const
{
    return GetTerrain()->IsUnderWater(GetPositionX(), GetPositionY(), GetPositionZ()+2);
}

void Player::SetInWater(bool apply)
{
    if (m_isInWater == apply)
        return;

    //define player in water by opcodes
    //move player's guid into HateOfflineList of those mobs
    //which can't swim and move guid back into ThreatList when
    //on surface.
    //TODO: exist also swimming mobs, and function must be symmetric to enter/leave water
    m_isInWater = apply;

    // remove auras that need water/land
    RemoveAurasWithInterruptFlags(apply ? AURA_INTERRUPT_FLAG_NOT_ABOVEWATER : AURA_INTERRUPT_FLAG_NOT_UNDERWATER);

    getHostilRefManager().updateThreatTables();
}

void Player::SetGameMaster(bool on)
{
    if (on)
    {
        m_ExtraFlags |= PLAYER_EXTRA_GM_ON;
        setFaction(35);
        SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_GM);

        RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_FFA_PVP);
        ResetContestedPvP();

        CombatStop();
    }
    else
    {
        m_ExtraFlags &= ~ PLAYER_EXTRA_GM_ON;
        setFactionForRace(getRace());
        RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_GM);

        // restore FFA PvP Server state
        if (sWorld.IsFFAPvPRealm())
            SetFFAPvP(true);

        // restore FFA PvP area state, remove not allowed for GM mounts
        UpdateArea(m_areaUpdateId);
    }

    getHostilRefManager().setOnlineOfflineState(!on);
    UpdateVisibilityAndView();
}

void Player::SetGMVisible(bool on)
{
    if (on)
    {
        m_ExtraFlags &= ~PLAYER_EXTRA_GM_INVISIBLE;         //remove flag

        // Reapply stealth/invisibility if active or show if not any
        if (HasAuraType(SPELL_AURA_MOD_STEALTH))
            SetVisibility(VISIBILITY_GROUP_STEALTH);
        //else if (HasAuraType(SPELL_AURA_MOD_INVISIBILITY))
        //    SetVisibility(VISIBILITY_GROUP_INVISIBILITY);
        else
            SetVisibility(VISIBILITY_ON);
    }
    else
    {
        m_ExtraFlags |= PLAYER_EXTRA_GM_INVISIBLE;          //add flag

        //SetAcceptWhispers(false);
        SetGameMaster(true);

        SetVisibility(VISIBILITY_OFF);
    }
}

bool Player::IsGroupVisiblefor (Player* p) const
{
    switch (sWorld.getConfig(CONFIG_GROUP_VISIBILITY))
    {
        default: return IsInSameGroupWith(p);
        case 1:  return IsInSameRaidWith(p);
        case 2:  return GetTeam()==p->GetTeam() || GetBGTeam()==p->GetBGTeam();
    }
}

bool Player::IsInSameGroupWith(Player const* p) const
{
    return  p==this || GetGroup() != NULL &&
        GetGroup() == p->GetGroup() &&
        GetGroup()->SameSubGroup((Player*)this, (Player*)p);
}

///- If the player is invited, remove him. If the group if then only 1 person, disband the group.
/// \todo Shouldn't we also check if there is no other invitees before disbanding the group?
void Player::UninviteFromGroup()
{
    Group* group = GetGroupInvite();
    if (!group)
        return;

    group->RemoveInvite(this);

    if (group->GetMembersCount() <= 1)                   // group has just 1 member => disband
    {
        if (group->IsCreated())
        {
            group->Disband(true);
            sObjectMgr.RemoveGroup(group);
        }
        else
            group->RemoveAllInvites();

        delete group;
    }
}

void Player::RemoveFromGroup(Group* group, uint64 guid)
{
    if (group)
    {
        if (group->RemoveMember(guid, 0) <= 1)
        {
            // group->Disband(); already disbanded in RemoveMember
            sObjectMgr.RemoveGroup(group);
            delete group;
            // removemember sets the player's group pointer to NULL
        }
    }
}

bool ChatHandler::HandleGroupJoinCommand(const char *args)
{
    if (!*args)
        return false;

    Player* playerSource = NULL;
    Player* playerTarget = NULL;
    Group* groupSource = NULL;
    Group* groupTarget = NULL;
    uint64 guidSource = 0;
    uint64 guidTarget = 0;
    char* nameplgrStr = strtok((char*)args, " ");
    char* nameplStr = strtok(NULL, " ");

    if (GetPlayerGroupAndGUIDByName(nameplgrStr, playerSource, groupSource, guidSource, true))
    {
        if (groupSource)
        {
            if (GetPlayerGroupAndGUIDByName(nameplStr, playerTarget, groupTarget, guidTarget, true))
            {
                if (!groupTarget && playerTarget->GetGroup() != groupSource)
                {
                    if (!groupSource->IsFull())
                    {
                        groupSource->AddMember(guidTarget, playerTarget->GetName());
                        groupSource->BroadcastGroupUpdate();
                        PSendSysMessage(LANG_GROUP_PLAYER_JOINED, playerTarget->GetName(), playerSource->GetName());
                        return true;
                    }
                    else
                    {
                        // group is full
                        PSendSysMessage(LANG_GROUP_FULL);
                        return true;
                    }
                }
                else
                {
                    // group is full or target player already in a group
                    PSendSysMessage(LANG_GROUP_ALREADY_IN_GROUP, playerTarget->GetName());
                    return true;
                }
            }
        }
        else
        {
            // specified source player is not in a group
            PSendSysMessage(LANG_GROUP_NOT_IN_GROUP, playerSource->GetName());
            return true;
        }
    }

    return true;
}

void Player::SendLogXPGain(uint32 GivenXP, Unit* victim, uint32 RestXP)
{
    WorldPacket data(SMSG_LOG_XPGAIN, 21);
    data << uint64(victim ? victim->GetGUID() : 0);         // guid
    data << uint32(GivenXP+RestXP);                         // given experience
    data << uint8(victim ? 0 : 1);                          // 00-kill_xp type, 01-non_kill_xp type
    if (victim)
    {
        data << uint32(GivenXP);                            // experience without rested bonus
        data << float(1);                                   // 1 - none 0 - 100% group bonus output
    }
    data << uint8(0);                                       // new 2.4.0
    SendPacketToSelf(&data);
}

void Player::GiveXP(uint32 xp, Unit* victim)
{
    if (xp < 1)
        return;

    if (!isAlive())
        return;

    if (StopLevel(GetGUID()))
        return;

    uint32 level = getLevel();

    // Favored experience increase START
    uint32 zone = GetZoneId();
    uint32 tealm = GetTeam();
    float favored_exp_mult = 0;
    if( (HasAura(32096) || HasAura(32098)) && (zone == 3483 || zone == 3562 || zone == 3836 || zone == 3713 || zone == 3714) ) favored_exp_mult = 0.05; // Thrallmar's Favor and Honor Hold's Favor
    xp *= (1 + favored_exp_mult);
    // Favored experience increase END


    // XP to money conversion processed in Player::RewardQuest
    if (level >= sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
        return;

    // handle SPELL_AURA_MOD_XP_PCT auras
    Unit::AuraList const& ModXPPctAuras = GetAurasByType(SPELL_AURA_MOD_XP_PCT);
    for (Unit::AuraList::const_iterator i = ModXPPctAuras.begin();i != ModXPPctAuras.end(); ++i)
        xp = uint32(xp*(1.0f + (*i)->GetModifierValue() / 100.0f));

    if (uint32 goodEntry = sWorld.getConfig(CONFIG_XP_RATE_MODIFY_ITEM_ENTRY))
    {
        for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
        {
            Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem->GetEntry() == goodEntry)
            {
                xp = uint32(xp*(1.0f + sWorld.getConfig(CONFIG_XP_RATE_MODIFY_ITEM_PCT) / 100.0f));
                break;
            }
        }
    }

    // XP resting bonus for kill
    uint32 rested_bonus_xp = victim ? GetXPRestBonus(xp) : 0;

    SendLogXPGain(xp,victim,rested_bonus_xp);

    uint32 curXP = GetUInt32Value(PLAYER_XP);
    uint32 nextLvlXP = GetUInt32Value(PLAYER_NEXT_LEVEL_XP);
    uint32 newXP = curXP + xp + rested_bonus_xp;

    while (newXP >= nextLvlXP && level < sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
    {
        newXP -= nextLvlXP;

        if (level < sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
            GiveLevel(level + 1);

        level = getLevel();
        nextLvlXP = GetUInt32Value(PLAYER_NEXT_LEVEL_XP);
    }

    SetUInt32Value(PLAYER_XP, newXP);
}

// Update player to next level
// Current player experience not update (must be update by caller)
void Player::GiveLevel(uint32 level)
{
    if (level == getLevel())
        return;

    PlayerLevelInfo info;
    sObjectMgr.GetPlayerLevelInfo(getRace(),getClass(),level,&info);

    PlayerClassLevelInfo classInfo;
    sObjectMgr.GetPlayerClassLevelInfo(getClass(),level,&classInfo);

    // send levelup info to client
    WorldPacket data(SMSG_LEVELUP_INFO, (4+4+MAX_POWERS*4+MAX_STATS*4));
    data << uint32(level);
    data << uint32(int32(classInfo.basehealth) - int32(GetCreateHealth()));
    // for (int i = 0; i < MAX_POWERS; ++i)                  // Powers loop (0-6)
    data << uint32(int32(classInfo.basemana)   - int32(GetCreateMana()));
    data << uint32(0);
    data << uint32(0);
    data << uint32(0);
    data << uint32(0);
    // end for
    for (int i = STAT_STRENGTH; i < MAX_STATS; ++i)          // Stats loop (0-4)
        data << uint32(int32(info.stats[i]) - GetCreateStat(Stats(i)));

    SendPacketToSelf(&data);

    SetUInt32Value(PLAYER_NEXT_LEVEL_XP, Looking4group::XP::xp_to_level(level));

    //update level, max level of skills
    if (getLevel()!= level)
        m_Played_time[1] = 0;                               // Level Played Time reset
    SetLevel(level);
    UpdateSkillsForLevel ();

    // save base values (bonuses already included in stored stats
    for (int i = STAT_STRENGTH; i < MAX_STATS; ++i)
        SetCreateStat(Stats(i), info.stats[i]);

    SetCreateHealth(classInfo.basehealth);
    SetCreateMana(classInfo.basemana);

    InitTalentForLevel();
    InitTaxiNodesForLevel();

    UpdateAllStats();

    if (sWorld.getConfig(CONFIG_ALWAYS_MAXSKILL)) // Max weapon skill when leveling up
        UpdateSkillsToMaxSkillsForLevel();

    // set current level health and mana/energy to maximum after applying all mods.
    SetHealth(GetMaxHealth());
    SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
    SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));
    if (GetPower(POWER_RAGE) > GetMaxPower(POWER_RAGE))
        SetPower(POWER_RAGE, GetMaxPower(POWER_RAGE));
    SetPower(POWER_FOCUS, 0);
    SetPower(POWER_HAPPINESS, 0);

    // give level to summoned pet
    Pet* pet = GetPet();
    if (pet && pet->getPetType()==SUMMON_PET)
        pet->GivePetLevel(level);

    if (uint32 goodEntry = sWorld.getConfig(CONFIG_XP_RATE_MODIFY_ITEM_ENTRY))
    {
        DestroyItemCount(goodEntry, 1, true, false, true);
    }
}

void Player::UpdateFreeTalentPoints(bool resetIfNeed)
{
    uint32 level = getLevel();
    // talents base at level diff (talents = level - 9 but some can be used already)
    if (level < 10)
    {
        // Remove all talent points
        if (m_usedTalentCount > 0)                           // Free any used talents
        {
            if (resetIfNeed)
                resetTalents(true);
            SetFreeTalentPoints(0);
        }
    }
    else
    {
        uint32 talentPointsForLevel = CalculateTalentsPoints();
        // if used more that have then reset
        if (m_usedTalentCount > talentPointsForLevel)
        {
            if (resetIfNeed && !GetSession()->HasPermissions(PERM_ADM))
                resetTalents(true);
            else
                SetFreeTalentPoints(0);
        }
        // else update amount of free points
        else
            SetFreeTalentPoints(talentPointsForLevel-m_usedTalentCount);
    }
}

void Player::InitTalentForLevel()
{
    UpdateFreeTalentPoints();
}

void Player::InitStatsForLevel(bool reapplyMods)
{
    if (reapplyMods)                                         //reapply stats values only on .reset stats (level) command
        _RemoveAllStatBonuses();

    PlayerClassLevelInfo classInfo;
    sObjectMgr.GetPlayerClassLevelInfo(getClass(),getLevel(),&classInfo);

    PlayerLevelInfo info;
    sObjectMgr.GetPlayerLevelInfo(getRace(),getClass(),getLevel(),&info);

    SetUInt32Value(PLAYER_FIELD_MAX_LEVEL, sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL));
    SetUInt32Value(PLAYER_NEXT_LEVEL_XP, Looking4group::XP::xp_to_level(getLevel()));

    UpdateSkillsForLevel ();

    // set default cast time multiplier
    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);

    // reset size before reapply auras
    SetFloatValue(OBJECT_FIELD_SCALE_X,1.0f);

    // save base values (bonuses already included in stored stats
    for (int i = STAT_STRENGTH; i < MAX_STATS; ++i)
        SetCreateStat(Stats(i), info.stats[i]);

    for (int i = STAT_STRENGTH; i < MAX_STATS; ++i)
        SetStat(Stats(i), info.stats[i]);

    SetCreateHealth(classInfo.basehealth);

    //set create powers
    SetCreateMana(classInfo.basemana);

    SetArmor(int32(m_createStats[STAT_AGILITY]*2));

    InitStatBuffMods();

    //reset rating fields values
    for (uint16 index = PLAYER_FIELD_COMBAT_RATING_1; index < PLAYER_FIELD_COMBAT_RATING_1 + MAX_COMBAT_RATING; ++index)
        SetUInt32Value(index, 0);

    for (int i = 0; i < MAX_SPELL_SCHOOL; ++i)
    {
        SetInt32Value(UNIT_FIELD_POWER_COST_MODIFIER+i, 0);
        SetFloatValue(UNIT_FIELD_POWER_COST_MULTIPLIER+i, 0.0f);
    }

    SetUInt32Value(PLAYER_FIELD_MOD_HEALING_DONE_POS,0);
    for (int i = 0; i < 7; i++)
    {
        SetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG+i, 0);
        SetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS+i, 0);
        SetFloatValue(PLAYER_FIELD_MOD_DAMAGE_DONE_PCT+i, 1.00f);
    }

    //reset attack power, damage and attack speed fields
    SetFloatValue(UNIT_FIELD_BASEATTACKTIME, 2000.0f);
    SetFloatValue(UNIT_FIELD_BASEATTACKTIME + 1, 2000.0f); // offhand attack time
    SetFloatValue(UNIT_FIELD_RANGEDATTACKTIME, 2000.0f);

    SetFloatValue(UNIT_FIELD_MINDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MAXDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MINRANGEDDAMAGE, 0.0f);
    SetFloatValue(UNIT_FIELD_MAXRANGEDDAMAGE, 0.0f);

    SetInt32Value(UNIT_FIELD_ATTACK_POWER,            0);
    SetInt32Value(UNIT_FIELD_ATTACK_POWER_MODS,       0);
    SetFloatValue(UNIT_FIELD_ATTACK_POWER_MULTIPLIER,0.0f);
    SetInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER,     0);
    SetInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER_MODS,0);
    SetFloatValue(UNIT_FIELD_RANGED_ATTACK_POWER_MULTIPLIER,0.0f);

    // Base crit values (will be recalculated in UpdateAllStats() at loading and in _ApplyAllStatBonuses() at reset
    SetFloatValue(PLAYER_CRIT_PERCENTAGE,0.0f);
    SetFloatValue(PLAYER_OFFHAND_CRIT_PERCENTAGE,0.0f);
    SetFloatValue(PLAYER_RANGED_CRIT_PERCENTAGE,0.0f);

    // Init spell schools (will be recalculated in UpdateAllStats() at loading and in _ApplyAllStatBonuses() at reset
    for (uint8 i = 0; i < 7; ++i)
        SetFloatValue(PLAYER_SPELL_CRIT_PERCENTAGE1+i, 0.0f);

    SetFloatValue(PLAYER_PARRY_PERCENTAGE, 0.0f);
    SetFloatValue(PLAYER_BLOCK_PERCENTAGE, 0.0f);
    SetUInt32Value(PLAYER_SHIELD_BLOCK, 0);

    // Dodge percentage
    SetFloatValue(PLAYER_DODGE_PERCENTAGE, 0.0f);

    // set armor (resistance 0) to original value (create_agility*2)
    SetArmor(int32(m_createStats[STAT_AGILITY]*2));
    SetResistanceBuffMods(SpellSchools(0), true, 0.0f);
    SetResistanceBuffMods(SpellSchools(0), false, 0.0f);
    // set other resistance to original value (0)
    for (int i = 1; i < MAX_SPELL_SCHOOL; i++)
    {
        SetResistance(SpellSchools(i), 0);
        SetResistanceBuffMods(SpellSchools(i), true, 0.0f);
        SetResistanceBuffMods(SpellSchools(i), false, 0.0f);
    }

    SetUInt32Value(PLAYER_FIELD_MOD_TARGET_RESISTANCE,0);
    SetUInt32Value(PLAYER_FIELD_MOD_TARGET_PHYSICAL_RESISTANCE,0);

    // Init data for form but skip reapply item mods for form
    InitDataForForm(reapplyMods);

    // save new stats
    for (int i = POWER_MANA; i < MAX_POWERS; i++)
        SetMaxPower(Powers(i),  uint32(GetCreatePowers(Powers(i))));

    SetMaxHealth(classInfo.basehealth);                     // stamina bonus will applied later

    // cleanup mounted state (it will set correctly at aura loading if player saved at mount.
    SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);

    // cleanup unit flags (will be re-applied if need at aura load).
    RemoveFlag(UNIT_FIELD_FLAGS,
        UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NOT_ATTACKABLE_1 |
        UNIT_FLAG_PET_IN_COMBAT  | UNIT_FLAG_SILENCED     | UNIT_FLAG_PACIFIED         |
        UNIT_FLAG_DISABLE_ROTATE | UNIT_FLAG_IN_COMBAT    | UNIT_FLAG_DISARMED         |
        UNIT_FLAG_CONFUSED       | UNIT_FLAG_FLEEING      | UNIT_FLAG_NOT_SELECTABLE   |
        UNIT_FLAG_SKINNABLE      | UNIT_FLAG_MOUNT        | UNIT_FLAG_TAXI_FLIGHT     );
    SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);   // must be set

    // cleanup player flags (will be re-applied if need at aura load), to avoid have ghost flag without ghost aura, for example.
    RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_AFK | PLAYER_FLAGS_DND | PLAYER_FLAGS_GM | PLAYER_FLAGS_GHOST | PLAYER_FLAGS_FFA_PVP);

    SetByteValue(UNIT_FIELD_BYTES_1, 2, 0x00);              // one form stealth modified bytes

    // restore if need some important flags
    SetUInt32Value(PLAYER_FIELD_BYTES2, 0);                // flags empty by default

    if (reapplyMods)                                         //reapply stats values only on .reset stats (level) command
        _ApplyAllStatBonuses();

    // set current level health and mana/energy to maximum after applying all mods.
    SetHealth(GetMaxHealth());
    SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
    SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));
    if (GetPower(POWER_RAGE) > GetMaxPower(POWER_RAGE))
        SetPower(POWER_RAGE, GetMaxPower(POWER_RAGE));
    SetPower(POWER_FOCUS, 0);
    SetPower(POWER_HAPPINESS, 0);
}

void Player::SendInitialSpells()
{
    uint16 spellCount = 0;

    WorldPacket data(SMSG_INITIAL_SPELLS, (1+2+4*m_spells.size()+2+m_spellCooldowns.size()*(2+2+2+4+4)));
    data << uint8(0);

    size_t countPos = data.wpos();
    data << uint16(spellCount);                             // spell count placeholder

    for (PlayerSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        if (itr->second.state == PLAYERSPELL_REMOVED)
            continue;

        if (!itr->second.active || itr->second.disabled)
            continue;

        data << uint16(itr->first);
        data << uint16(0);                                  // it's not slot id

        spellCount +=1;
    }

    data.put<uint16>(countPos,spellCount);                  // write real count value

    uint16 spellCooldowns = m_spellCooldowns.size();
    data << uint16(spellCooldowns);
    for (SpellCooldowns::const_iterator itr=m_spellCooldowns.begin(); itr!=m_spellCooldowns.end(); ++itr)
    {
        SpellEntry const *sEntry = sSpellStore.LookupEntry(itr->first);
        if (!sEntry)
            continue;

        data << uint16(itr->first);

        time_t cooldown = 0;
        time_t curTime = time(NULL);
        if (itr->second.end > curTime)
            cooldown = (itr->second.end-curTime)*1000;

        data << uint16(itr->second.itemid);                 // cast item id
        data << uint16(sEntry->Category);                   // spell category
        if (sEntry->Category)                                // may be wrong, but anyway better than nothing...
        {
            data << uint32(0);                              // cooldown
            data << uint32(cooldown);                       // category cooldown
        }
        else
        {
            data << uint32(cooldown);                       // cooldown
            data << uint32(0);                              // category cooldown
        }
    }

    SendPacketToSelf(&data);

    sLog.outDetail("CHARACTER: Sent Initial Spells");
}

void Player::RemoveMail(uint32 id)
{
    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end();++itr)
    {
        if ((*itr)->messageID == id)
        {
            //do not delete item, because Player::removeMail() is called when returning mail to sender.
            m_mail.erase(itr);
            return;
        }
    }
}

void Player::SendMailResult(uint32 mailId, uint32 mailAction, uint32 mailError, uint32 equipError, uint32 item_guid, uint32 item_count)
{
    WorldPacket data(SMSG_SEND_MAIL_RESULT, (4+4+4+(mailError == MAIL_ERR_EQUIP_ERROR?4:(mailAction == MAIL_ITEM_TAKEN?4+4:0))));
    data << (uint32) mailId;
    data << (uint32) mailAction;
    data << (uint32) mailError;
    if (mailError == MAIL_ERR_EQUIP_ERROR)
        data << (uint32) equipError;
    else if (mailAction == MAIL_ITEM_TAKEN)
    {
        data << (uint32) item_guid;                         // item guid low?
        data << (uint32) item_count;                        // item count?
    }
    SendPacketToSelf(&data);
}

void Player::SendNewMail()
{
    // deliver undelivered mail
    WorldPacket data(SMSG_RECEIVED_MAIL, 4);
    data << (uint32) 0;
    SendPacketToSelf(&data);
}

void Player::UpdateNextMailTimeAndUnreads()
{
    // calculate next delivery time (min. from non-delivered mails
    // and recalculate unReadMail
    time_t cTime = time(NULL);
    m_nextMailDelivereTime = 0;
    unReadMails = 0;
    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
    {
        if ((*itr)->deliver_time > cTime)
        {
            if (!m_nextMailDelivereTime || m_nextMailDelivereTime > (*itr)->deliver_time)
                m_nextMailDelivereTime = (*itr)->deliver_time;
        }
        else if (((*itr)->checked & MAIL_CHECK_MASK_READ) == 0)
            ++unReadMails;
    }
}

void Player::AddNewMailDeliverTime(time_t deliver_time)
{
    if (deliver_time <= time(NULL))                          // ready now
    {
        ++unReadMails;
        SendNewMail();
    }
    else                                                    // not ready and no have ready mails
    {
        if (!m_nextMailDelivereTime || m_nextMailDelivereTime > deliver_time)
            m_nextMailDelivereTime =  deliver_time;
    }
}

bool Player::addSpell(uint32 spell_id, bool active, bool learning, bool loading, uint16 slot_id, bool disabled)
{
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spell_id);
    if (!spellInfo)
    {
        // do character spell book cleanup (all characters)
        if (loading && !learning)                            // spell load case
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Player::addSpell: Non-existed in SpellStore spell #%u request, deleting for all characters in `character_spell`.",spell_id);
            RealmDataDatabase.PExecute("DELETE FROM character_spell WHERE spell = '%u'",spell_id);
        }
        else
            sLog.outLog(LOG_DEFAULT, "ERROR: Player::addSpell: Non-existed in SpellStore spell #%u request.",spell_id);

        return false;
    }

    if (!SpellMgr::IsSpellValid(spellInfo,this,false))
    {
        // do character spell book cleanup (all characters)
        if (loading && !learning)                            // spell load case
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Player::addSpell: Broken spell #%u learning not allowed, deleting for all characters in `character_spell`.",spell_id);
            RealmDataDatabase.PExecute("DELETE FROM character_spell WHERE spell = '%u'",spell_id);
        }
        else
            sLog.outLog(LOG_DEFAULT, "ERROR: Player::addSpell: Broken spell #%u learning not allowed.",spell_id);

        return false;
    }

    PlayerSpellState state = learning ? PLAYERSPELL_NEW : PLAYERSPELL_UNCHANGED;

    bool disabled_case = false;
    bool superceded_old = false;

    PlayerSpellMap::iterator itr = m_spells.find(spell_id);
    if (itr != m_spells.end())
    {
        // update active state for known spell
        if (itr->second.active != active && itr->second.state != PLAYERSPELL_REMOVED && !itr->second.disabled)
        {
            itr->second.active = active;

            // loading && !learning == explicitly load from DB and then exist in it already and set correctly
            if (loading && !learning)
                itr->second.state = PLAYERSPELL_UNCHANGED;
            else if (itr->second.state != PLAYERSPELL_NEW)
                itr->second.state = PLAYERSPELL_CHANGED;

            if (!active)
            {
                WorldPacket data(SMSG_REMOVED_SPELL, 4);
                data << uint16(spell_id);
                SendPacketToSelf(&data);
            }
            return active;                                  // learn (show in spell book if active now)
        }

        if (itr->second.disabled != disabled && itr->second.state != PLAYERSPELL_REMOVED)
        {
            if (itr->second.state != PLAYERSPELL_NEW)
                itr->second.state = PLAYERSPELL_CHANGED;

            itr->second.disabled = disabled;

            if (disabled)
                return false;

            disabled_case = true;
        }
        else switch (itr->second.state)
        {
            case PLAYERSPELL_UNCHANGED:                     // known saved spell
                return false;
            case PLAYERSPELL_REMOVED:                       // re-learning removed not saved spell
            {
                m_spells.erase(itr);
                state = PLAYERSPELL_CHANGED;
                break;                                      // need re-add
            }
            default:                                        // known not saved yet spell (new or modified)
            {
                // can be in case spell loading but learned at some previous spell loading
                if (loading && !learning)
                    itr->second.state = PLAYERSPELL_UNCHANGED;

                return false;
            }
        }
    }

    TalentSpellPos const* talentPos = GetTalentSpellPos(spell_id);

    if (!disabled_case) // skip new spell adding if spell already known (disabled spells case)
    {
        // talent: unlearn all other talent ranks (high and low)
        if (talentPos)
        {
            if (TalentEntry const *talentInfo = sTalentStore.LookupEntry(talentPos->talent_id))
            {
                for (int i=0; i <5; ++i)
                {
                    // skip learning spell and no rank spell case
                    uint32 rankSpellId = talentInfo->RankID[i];
                    if (!rankSpellId || rankSpellId==spell_id)
                        continue;

                    // skip unknown ranks
                    if (!HasSpell(rankSpellId))
                        continue;

                    removeSpell(rankSpellId);
                }
            }
        }
        // non talent spell: learn low ranks (recursive call)
        else if (uint32 prev_spell = sSpellMgr.GetPrevSpellInChain(spell_id))
        {
            if (loading)                                     // at spells loading, no output, but allow save
                addSpell(prev_spell,active,true,loading,SPELL_WITHOUT_SLOT_ID,disabled);
            else                                            // at normal learning
                learnSpell(prev_spell);
        }

        PlayerSpell newspell;
        newspell.active = active;
        newspell.state = state;
        newspell.disabled = disabled;

        // replace spells in action bars and spell book to bigger rank if only one spell rank must be accessible
        if (newspell.active && !newspell.disabled && !SpellMgr::canStackSpellRanks(spellInfo) && sSpellMgr.GetSpellRank(spellInfo->Id) != 0)
        {
            for (PlayerSpellMap::iterator itr2 = m_spells.begin(); itr2 != m_spells.end(); ++itr2)
            {
                if (itr2->second.state == PLAYERSPELL_REMOVED) continue;
                SpellEntry const *i_spellInfo = sSpellStore.LookupEntry(itr2->first);
                if (!i_spellInfo)
                    continue;

                if (sSpellMgr.IsRankSpellDueToSpell(spellInfo, itr2->first))
                {
                    if (itr2->second.active)
                    {
                        if (sSpellMgr.IsHighRankOfSpell(spell_id, itr2->first))
                        {
                            if (!loading)                    // not send spell (re-/over-)learn packets at loading
                            {
                                WorldPacket data(SMSG_SUPERCEDED_SPELL, (4));
                                data << uint16(itr2->first);
                                data << uint16(spell_id);
                                SendPacketToSelf(&data);
                            }

                            // mark old spell as disable (SMSG_SUPERCEDED_SPELL replace it in client by new)
                            itr2->second.active = false;
                            itr2->second.state = PLAYERSPELL_CHANGED;
                            superceded_old = true;          // new spell replace old in action bars and spell book.
                        }
                        else if (sSpellMgr.IsHighRankOfSpell(itr2->first, spell_id))
                        {
                            if (!loading)                    // not send spell (re-/over-)learn packets at loading
                            {
                                WorldPacket data(SMSG_SUPERCEDED_SPELL, (4));
                                data << uint16(spell_id);
                                data << uint16(itr2->first);
                                SendPacketToSelf(&data);
                            }

                            // mark new spell as disable (not learned yet for client and will not learned)
                            newspell.active = false;
                            if (newspell.state != PLAYERSPELL_NEW)
                                newspell.state = PLAYERSPELL_CHANGED;
                        }
                    }
                }
            }
        }

        uint16 tmpslot=slot_id;

        if (tmpslot == SPELL_WITHOUT_SLOT_ID)
        {
            uint16 maxid = 0;
            for (PlayerSpellMap::iterator itr2 = m_spells.begin(); itr2 != m_spells.end(); ++itr2)
            {
                if (itr2->second.state == PLAYERSPELL_REMOVED)
                    continue;
                if (itr2->second.slotId > maxid)
                    maxid = itr2->second.slotId;
            }
            tmpslot = maxid + 1;
        }

        newspell.slotId = tmpslot;
        m_spells[spell_id] = newspell;

        // return false if spell disabled
        if (newspell.disabled)
            return false;
    }

    if (talentPos)
    {
        // update used talent points count
        m_usedTalentCount += GetTalentSpellCost(talentPos);
        UpdateFreeTalentPoints(false);
    }

    // update free primary prof.points (if any, can be none in case GM .learn prof. learning)
    if (uint32 freeProfs = GetFreePrimaryProfessionPoints())
    {
        if (sSpellMgr.IsPrimaryProfessionFirstRankSpell(spell_id))
            SetFreePrimaryProfessions(freeProfs-1);
    }

    // cast talents with SPELL_EFFECT_LEARN_SPELL (other dependent spells will learned later as not auto-learned)
    // note: all spells with SPELL_EFFECT_LEARN_SPELL isn't passive
    if (talentPos && spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
    {
        // ignore stance requirement for talent learn spell (stance set for spell only for client spell description show)
        CastSpell(this, spell_id, true);
    }
    // also cast passive spells (including all talents without SPELL_EFFECT_LEARN_SPELL) with additional checks
    else if (SpellMgr::IsPassiveSpell(spell_id))
    {
        // if spell doesn't require a stance or the player is in the required stance
        if ((!spellInfo->Stances &&
            spell_id != 5420 && spell_id != 5419 && spell_id != 7376 &&
            spell_id != 7381 && spell_id != 21156 && spell_id != 21009 &&
            spell_id != 21178 && spell_id != 33948 && spell_id != 40121) ||
            m_form != 0 && (spellInfo->Stances & (1<<(m_form-1))) ||
            (spell_id ==  5420 && m_form == FORM_TREE) ||
            (spell_id ==  5419 && m_form == FORM_TRAVEL) ||
            (spell_id ==  7376 && m_form == FORM_DEFENSIVESTANCE) ||
            (spell_id ==  7381 && m_form == FORM_BERSERKERSTANCE) ||
            (spell_id == 21156 && m_form == FORM_BATTLESTANCE)||
            (spell_id == 21178 && (m_form == FORM_BEAR || m_form == FORM_DIREBEAR)) ||
            (spell_id == 33948 && m_form == FORM_FLIGHT) ||
            (spell_id == 40121 && m_form == FORM_FLIGHT_EPIC))
                                                            //Check CasterAuraStates
            if (!spellInfo->CasterAuraState || HasAuraState(AuraState(spellInfo->CasterAuraState)))
                CastSpell(this, spell_id, true);
    }
    else if (spellInfo->HasEffect(SPELL_EFFECT_SKILL_STEP))
    {
        CastSpell(this, spell_id, true);
        return false;
    }

    // add dependent skills
    uint16 maxskill     = GetMaxSkillValueForLevel();

    SpellLearnSkillNode const* spellLearnSkill = sSpellMgr.GetSpellLearnSkill(spell_id);

    if (spellLearnSkill)
    {
        uint32 skill_value = GetPureSkillValue(spellLearnSkill->skill);
        uint32 skill_max_value = GetPureMaxSkillValue(spellLearnSkill->skill);

        if (skill_value < spellLearnSkill->value)
            skill_value = spellLearnSkill->value;

        uint32 new_skill_max_value = spellLearnSkill->maxvalue == 0 ? maxskill : spellLearnSkill->maxvalue;

        if (skill_max_value < new_skill_max_value)
            skill_max_value =  new_skill_max_value;

        SetSkill(spellLearnSkill->skill,skill_value,skill_max_value);
    }
    else
    {
        // not ranked skills
        SkillLineAbilityMap::const_iterator lower = sSpellMgr.GetBeginSkillLineAbilityMap(spell_id);
        SkillLineAbilityMap::const_iterator upper = sSpellMgr.GetEndSkillLineAbilityMap(spell_id);

        for (SkillLineAbilityMap::const_iterator _spell_idx = lower; _spell_idx != upper; ++_spell_idx)
        {
            SkillLineEntry const *pSkill = sSkillLineStore.LookupEntry(_spell_idx->second->skillId);
            if (!pSkill)
                continue;

            if (HasSkill(pSkill->id))
                continue;

            if (_spell_idx->second->learnOnGetSkill == ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL ||
                // poison special case, not have ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL
                pSkill->id==SKILL_POISONS && _spell_idx->second->max_value==0 ||
                // lockpicking special case, not have ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL
                pSkill->id==SKILL_LOCKPICKING && _spell_idx->second->max_value==0)
            {
                switch (GetSkillRangeType(pSkill,_spell_idx->second->racemask!=0))
                {
                    case SKILL_RANGE_LANGUAGE:
                        SetSkill(pSkill->id, 300, 300);
                        break;
                    case SKILL_RANGE_LEVEL:
                        SetSkill(pSkill->id, 1, GetMaxSkillValueForLevel());
                        break;
                    case SKILL_RANGE_MONO:
                        SetSkill(pSkill->id, 1, 1);
                        break;
                    default:
                        break;
                }
            }
        }
    }

    // learn dependent spells
    SpellLearnSpellMap::const_iterator spell_begin = sSpellMgr.GetBeginSpellLearnSpell(spell_id);
    SpellLearnSpellMap::const_iterator spell_end   = sSpellMgr.GetEndSpellLearnSpell(spell_id);

    for (SpellLearnSpellMap::const_iterator itr2 = spell_begin; itr2 != spell_end; ++itr2)
    {
        if (!itr2->second.autoLearned)
        {
            if (loading)                                     // at spells loading, no output, but allow save
                addSpell(itr2->second.spell,true,true,loading);
            else                                            // at normal learning
                learnSpell(itr2->second.spell);
        }
    }

    // return true (for send learn packet) only if spell active (in case ranked spells) and not replace old spell
    return active && !disabled && !superceded_old;
}

void Player::learnSpell(uint32 spell_id)
{
    PlayerSpellMap::iterator itr = m_spells.find(spell_id);

    bool disabled = (itr != m_spells.end()) ? itr->second.disabled : false;
    bool active = disabled ? itr->second.active : true;

    bool learning = addSpell(spell_id,active);

    // learn all disabled higher ranks (recursive)
    SpellChainNode const* node = sSpellMgr.GetSpellChainNode(spell_id);
    if (node)
    {
        PlayerSpellMap::iterator iter = m_spells.find(node->next);
        if (disabled && iter != m_spells.end() && iter->second.disabled)
            learnSpell(node->next);
    }

    // prevent duplicated entires in spell book
    if (!learning)
        return;

    WorldPacket data(SMSG_LEARNED_SPELL, 4);
    data << uint32(spell_id);
    SendPacketToSelf(&data);
}

void Player::removeSpell(uint32 spell_id, bool disabled)
{
    PlayerSpellMap::iterator itr = m_spells.find(spell_id);
    if (itr == m_spells.end())
        return;

    if (itr->second.state == PLAYERSPELL_REMOVED || disabled && itr->second.disabled)
        return;

    // unlearn non talent higher ranks (recursive)
    SpellChainNode const* node = sSpellMgr.GetSpellChainNode(spell_id);
    if (node)
    {
        if (HasSpell(node->next) && !GetTalentSpellPos(node->next))
            removeSpell(node->next,disabled);
    }
    //unlearn spells dependent from recently removed spells
    SpellsRequiringSpellMap const& reqMap = sSpellMgr.GetSpellsRequiringSpell();
    SpellsRequiringSpellMap::const_iterator itr2 = reqMap.find(spell_id);
    for (uint32 i=reqMap.count(spell_id);i>0;i--,itr2++)
        removeSpell(itr2->second,disabled);

    if (CanDualWield())
    {
        SpellEntry const *spellInfo = sSpellStore.LookupEntry(spell_id);

        if (spellInfo && spellInfo->HasEffect(SPELL_EFFECT_DUAL_WIELD))
            SetCanDualWield(false);
    }

    // removing
    WorldPacket data(SMSG_REMOVED_SPELL, 4);
    data << uint16(spell_id);
    SendPacketToSelf(&data);

    if (disabled)
    {
        itr->second.disabled = disabled;
        if (itr->second.state != PLAYERSPELL_NEW)
            itr->second.state = PLAYERSPELL_CHANGED;
    }
    else
    {
        if (itr->second.state == PLAYERSPELL_NEW)
            m_spells.erase(itr);
        else
            itr->second.state = PLAYERSPELL_REMOVED;
    }

    RemoveAurasDueToSpell(spell_id);

    // remove pet auras
    if (PetAura const* petSpell = sSpellMgr.GetPetAura(spell_id))
        RemovePetAura(petSpell);

    TalentSpellPos const* talentPos = GetTalentSpellPos(spell_id);
    if (talentPos)
    {
        // free talent points
        uint32 talentCosts = GetTalentSpellCost(talentPos);

        if (talentCosts < m_usedTalentCount)
            m_usedTalentCount -= talentCosts;
        else
            m_usedTalentCount = 0;

        UpdateFreeTalentPoints(false);
    }

    // update free primary prof.points (if not overflow setting, can be in case GM use before .learn prof. learning)
    if (sSpellMgr.IsPrimaryProfessionFirstRankSpell(spell_id))
    {
        uint32 freeProfs = GetFreePrimaryProfessionPoints()+1;
        if (freeProfs <= sWorld.getConfig(CONFIG_MAX_PRIMARY_TRADE_SKILL))
            SetFreePrimaryProfessions(freeProfs);
    }

    // remove dependent skill
    SpellLearnSkillNode const* spellLearnSkill = sSpellMgr.GetSpellLearnSkill(spell_id);
    if (spellLearnSkill)
    {
        uint32 prev_spell = sSpellMgr.GetPrevSpellInChain(spell_id);
        if (!prev_spell)                                     // first rank, remove skill
            SetSkill(spellLearnSkill->skill,0,0);
        else
        {
            // search prev. skill setting by spell ranks chain
            SpellLearnSkillNode const* prevSkill = sSpellMgr.GetSpellLearnSkill(prev_spell);
            while (!prevSkill && prev_spell)
            {
                prev_spell = sSpellMgr.GetPrevSpellInChain(prev_spell);
                prevSkill = sSpellMgr.GetSpellLearnSkill(sSpellMgr.GetFirstSpellInChain(prev_spell));
            }

            if (!prevSkill)                                  // not found prev skill setting, remove skill
                SetSkill(spellLearnSkill->skill,0,0);
            else                                            // set to prev. skill setting values
            {
                uint32 skill_value = GetPureSkillValue(prevSkill->skill);
                uint32 skill_max_value = GetPureMaxSkillValue(prevSkill->skill);

                if (skill_value >  prevSkill->value)
                    skill_value = prevSkill->value;

                uint32 new_skill_max_value = prevSkill->maxvalue == 0 ? GetMaxSkillValueForLevel() : prevSkill->maxvalue;

                if (skill_max_value > new_skill_max_value)
                    skill_max_value =  new_skill_max_value;

                SetSkill(prevSkill->skill,skill_value,skill_max_value);
            }
        }

    }
    else
    {
        // not ranked skills
        SkillLineAbilityMap::const_iterator lower = sSpellMgr.GetBeginSkillLineAbilityMap(spell_id);
        SkillLineAbilityMap::const_iterator upper = sSpellMgr.GetEndSkillLineAbilityMap(spell_id);

        for (SkillLineAbilityMap::const_iterator _spell_idx = lower; _spell_idx != upper; ++_spell_idx)
        {
            SkillLineEntry const *pSkill = sSkillLineStore.LookupEntry(_spell_idx->second->skillId);
            if (!pSkill)
                continue;

            if (_spell_idx->second->learnOnGetSkill == ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL ||
                // poison special case, not have ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL
                pSkill->id==SKILL_POISONS && _spell_idx->second->max_value==0 ||
                // lockpicking special case, not have ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL
                pSkill->id==SKILL_LOCKPICKING && _spell_idx->second->max_value==0)
            {
                // not reset skills for professions and racial abilities
                if ((pSkill->categoryId==SKILL_CATEGORY_SECONDARY || pSkill->categoryId==SKILL_CATEGORY_PROFESSION) &&
                    (SpellMgr::IsProfessionSkill(pSkill->id) || _spell_idx->second->racemask!=0))
                    continue;

                SetSkill(pSkill->id, 0, 0);
            }
        }
    }

    // remove dependent spells
    SpellLearnSpellMap::const_iterator spell_begin = sSpellMgr.GetBeginSpellLearnSpell(spell_id);
    SpellLearnSpellMap::const_iterator spell_end   = sSpellMgr.GetEndSpellLearnSpell(spell_id);

    for (SpellLearnSpellMap::const_iterator itr3 = spell_begin; itr3 != spell_end; ++itr3)
        removeSpell(itr3->second.spell, disabled);
}

void Player::RemoveSpellCooldown(uint32 spell_id, bool update /* = false */)
{
    m_spellCooldowns.erase(spell_id);

    if (update)
    {
        WorldPacket data(SMSG_CLEAR_COOLDOWN, (4+8));
        data << uint32(spell_id);
        data << uint64(GetGUID());
    SendPacketToSelf(&data);
    }
}

void Player::RemoveArenaSpellCooldowns()
{
    // remove cooldowns on spells that has < 15 min CD
    SpellCooldowns::iterator itr, next;
    // iterate spell cooldowns
    for (itr = m_spellCooldowns.begin();itr != m_spellCooldowns.end(); itr = next)
    {
        next = itr;
        ++next;
        SpellEntry const * entry = sSpellStore.LookupEntry(itr->first);
        // check if spellentry is present and if the cooldown is less than 15 mins
        if (entry && !(entry->AttributesEx4 & SPELL_ATTR_EX4_NOT_USABLE_IN_ARENA) && entry->RecoveryTime <= 15 * MINUTE * 1000 && entry->CategoryRecoveryTime <= 15 * MINUTE * 1000)
        {
            // notify player
            WorldPacket data(SMSG_CLEAR_COOLDOWN, (4+8));
            data << uint32(itr->first);
            data << GetGUID();
            SendPacketToSelf(&data);
            // remove cooldown
            m_spellCooldowns.erase(itr);
        }
    }
}

void Player::RemoveAllSpellCooldown()
{
    if (!m_spellCooldowns.empty())
    {
        for (SpellCooldowns::const_iterator itr = m_spellCooldowns.begin();itr != m_spellCooldowns.end(); ++itr)
        {
            WorldPacket data(SMSG_CLEAR_COOLDOWN, (4+8));
            data << uint32(itr->first);
            data << uint64(GetGUID());
            SendPacketToSelf(&data);
        }
        m_spellCooldowns.clear();
    }
}

void Player::_LoadSpellCooldowns(QueryResultAutoPtr result)
{
    m_spellCooldowns.clear();

    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT spell,item,time FROM character_spell_cooldown WHERE guid = '%u'",GetGUIDLow());

    if (result)
    {
        time_t curTime = time(NULL);

        do
        {
            Field *fields = result->Fetch();

            uint32 spell_id = fields[0].GetUInt32();
            uint32 item_id  = fields[1].GetUInt32();
            time_t db_time  = (time_t)fields[2].GetUInt64();

            if (!sSpellStore.LookupEntry(spell_id))
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Player %u have unknown spell %u in `character_spell_cooldown`, skipping.",GetGUIDLow(),spell_id);
                continue;
            }

            // skip outdated cooldown
            if (db_time <= curTime)
                continue;

            AddSpellCooldown(spell_id, item_id, db_time);

            sLog.outDebug("Player (GUID: %u) spell %u, item %u cooldown loaded (%u secs).", GetGUIDLow(), spell_id, item_id, uint32(db_time-curTime));
        }
        while (result->NextRow());
    }
}

void Player::_SaveSpellCooldowns()
{
    RealmDataDatabase.PExecute("DELETE FROM character_spell_cooldown WHERE guid = '%u'", GetGUIDLow());

    time_t curTime = time(NULL);

    // remove outdated and save active
    for (SpellCooldowns::iterator itr = m_spellCooldowns.begin();itr != m_spellCooldowns.end();)
    {
        if (itr->second.end <= curTime)
            m_spellCooldowns.erase(itr++);
        else
        {
            RealmDataDatabase.PExecute("INSERT INTO character_spell_cooldown (guid,spell,item,time) VALUES ('%u', '%u', '%u', '" UI64FMTD "')", GetGUIDLow(), itr->first, itr->second.itemid, uint64(itr->second.end));
            ++itr;
        }
    }
}

uint32 Player::resetTalentsCost() const
{
    // The first time reset costs 1 gold
    if (m_resetTalentsCost < 1*GOLD)
        return 1*GOLD;
    // then 5 gold
    else if (m_resetTalentsCost < 5*GOLD)
        return 5*GOLD;    
    else
    {
        uint32 months = (sWorld.GetGameTime() - m_resetTalentsTime)/MONTH;
        if (months > 0)
        {
            // This cost will be reduced by a rate of 5 gold per month
            int32 new_cost = int32(m_resetTalentsCost) - 5*GOLD*months;
            // to a minimum of 5 gold.
            return (new_cost < 5*GOLD ? 5*GOLD : new_cost);
        }
        else
        {
            // After that it increases in increments of 5 gold
            int32 new_cost = m_resetTalentsCost + 5*GOLD;
            // until it hits a cap of 20 gold.
            if (new_cost > 20*GOLD)
                new_cost = 20*GOLD;
            return new_cost;
        }
    }
}

bool Player::resetTalents(bool no_cost)
{
    // not need after this call
    if (HasAtLoginFlag(AT_LOGIN_RESET_TALENTS))
    {
        m_atLoginFlags = m_atLoginFlags & ~AT_LOGIN_RESET_TALENTS;
        RealmDataDatabase.PExecute("UPDATE characters set at_login = at_login & ~ %u WHERE guid ='%u'", uint32(AT_LOGIN_RESET_TALENTS), GetGUIDLow());
    }

    uint32 talentPointsForLevel = CalculateTalentsPoints();

    if (m_usedTalentCount == 0)
    {
        SetFreeTalentPoints(talentPointsForLevel);
        return false;
    }

    uint32 cost = 0;

    if (!no_cost && !sWorld.getConfig(CONFIG_NO_RESET_TALENT_COST))
    {
        cost = resetTalentsCost();

        if (GetMoney() < cost)
        {
            SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, 0, 0, 0);
            return false;
        }
    }

    for (unsigned int i = 0; i < sTalentStore.GetNumRows(); i++)
    {
        TalentEntry const *talentInfo = sTalentStore.LookupEntry(i);

        if (!talentInfo) continue;

        TalentTabEntry const *talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);

        if (!talentTabInfo)
            continue;

        // unlearn only talents for character class
        // some spell learned by one class as normal spells or know at creation but another class learn it as talent,
        // to prevent unexpected lost normal learned spell skip another class talents
        if ((getClassMask() & talentTabInfo->ClassMask) == 0)
            continue;

        for (int j = 0; j < 5; j++)
        {
            for (PlayerSpellMap::iterator itr = GetSpellMap().begin(); itr != GetSpellMap().end();)
            {
                if (itr->second.state == PLAYERSPELL_REMOVED || itr->second.disabled)
                {
                    ++itr;
                    continue;
                }

                // remove learned spells (all ranks)
                uint32 itrFirstId = sSpellMgr.GetFirstSpellInChain(itr->first);

                // unlearn if first rank is talent or learned by talent or spell itself is learned by talent
                if (itrFirstId == talentInfo->RankID[j] || sSpellMgr.IsSpellLearnToSpell(talentInfo->RankID[j],itrFirstId) || sSpellMgr.IsSpellLearnToSpell(talentInfo->RankID[j],itr->first))
                {
                    SpellEntry const * spellInfo = sSpellStore.LookupEntry(itrFirstId);
                    if (spellInfo)
                        for (uint8 i = 0; i < 3; ++i)
                        {
                            if (spellInfo->Effect[i] == SPELL_EFFECT_TRIGGER_SPELL && HasAura(spellInfo->EffectTriggerSpell[i]))
                                RemoveAurasDueToSpell(spellInfo->EffectTriggerSpell[i]);
                        }
                    // for dual wield
                    if (itrFirstId == 30798)
                        if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND)) // off hand here needed
                        {
                            uint16 dest;
                            if (CanEquipItem(EQUIPMENT_SLOT_OFFHAND, dest, item, false, false) != EQUIP_ERR_OK)
                            _ApplyItemMods(item,EQUIPMENT_SLOT_OFFHAND, false);
                        }
                    removeSpell(itr->first,!SpellMgr::IsPassiveSpell(itr->first));
                    itr = GetSpellMap().begin();
                    continue;
                }
                else
                    ++itr;
            }
        }
    }

    SetFreeTalentPoints(talentPointsForLevel);

    if (!no_cost)
    {
        ModifyMoney(-(int32)cost);

        m_resetTalentsCost = cost;
        m_resetTalentsTime = time(NULL);
    }

    //FIXME: remove pet before or after unlearn spells? for now after unlearn to allow removing of talent related, pet affecting auras
    RemovePet(NULL,PET_SAVE_NOT_IN_SLOT, true);

    return true;
}

bool Player::_removeSpell(uint16 spell_id)
{
    PlayerSpellMap::iterator itr = m_spells.find(spell_id);
    if (itr != m_spells.end())
    {
        m_spells.erase(itr);
        return true;
    }
    return false;
}

Mail* Player::GetMail(uint32 id)
{
    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
    {
        if ((*itr)->messageID == id)
        {
            return (*itr);
        }
    }
    return NULL;
}

void Player::_SetCreateBits(UpdateMask *updateMask, Player *target) const
{
    if (target == this)
    {
        Object::_SetCreateBits(updateMask, target);
    }
    else
    {
        for (uint16 index = 0; index < m_valuesCount; index++)
        {
            if (GetUInt32Value(index) != 0 && updateVisualBits.GetBit(index))
                updateMask->SetBit(index);
        }
    }
}

void Player::_SetUpdateBits(UpdateMask *updateMask, Player *target) const
{
    if (target == this)
    {
        Object::_SetUpdateBits(updateMask, target);
    }
    else
    {
        Object::_SetUpdateBits(updateMask, target);
        *updateMask &= updateVisualBits;
    }
}

void Player::InitVisibleBits()
{
    updateVisualBits.SetCount(PLAYER_END);

    // TODO: really implement OWNER_ONLY and GROUP_ONLY. Flags can be found in UpdateFields.h

    updateVisualBits.SetBit(OBJECT_FIELD_GUID);
    updateVisualBits.SetBit(OBJECT_FIELD_TYPE);
    updateVisualBits.SetBit(OBJECT_FIELD_SCALE_X);

    updateVisualBits.SetBit(UNIT_FIELD_CHARM);
    updateVisualBits.SetBit(UNIT_FIELD_CHARM+1);

    updateVisualBits.SetBit(UNIT_FIELD_SUMMON);
    updateVisualBits.SetBit(UNIT_FIELD_SUMMON+1);

    updateVisualBits.SetBit(UNIT_FIELD_CHARMEDBY);
    updateVisualBits.SetBit(UNIT_FIELD_CHARMEDBY+1);

    updateVisualBits.SetBit(UNIT_FIELD_TARGET);
    updateVisualBits.SetBit(UNIT_FIELD_TARGET+1);

    updateVisualBits.SetBit(UNIT_FIELD_CHANNEL_OBJECT);
    updateVisualBits.SetBit(UNIT_FIELD_CHANNEL_OBJECT+1);

    updateVisualBits.SetBit(UNIT_FIELD_HEALTH);
    updateVisualBits.SetBit(UNIT_FIELD_POWER1);
    updateVisualBits.SetBit(UNIT_FIELD_POWER2);
    updateVisualBits.SetBit(UNIT_FIELD_POWER3);
    updateVisualBits.SetBit(UNIT_FIELD_POWER4);
    updateVisualBits.SetBit(UNIT_FIELD_POWER5);

    updateVisualBits.SetBit(UNIT_FIELD_MAXHEALTH);
    updateVisualBits.SetBit(UNIT_FIELD_MAXPOWER1);
    updateVisualBits.SetBit(UNIT_FIELD_MAXPOWER2);
    updateVisualBits.SetBit(UNIT_FIELD_MAXPOWER3);
    updateVisualBits.SetBit(UNIT_FIELD_MAXPOWER4);
    updateVisualBits.SetBit(UNIT_FIELD_MAXPOWER5);

    updateVisualBits.SetBit(UNIT_FIELD_LEVEL);
    updateVisualBits.SetBit(UNIT_FIELD_FACTIONTEMPLATE);
    updateVisualBits.SetBit(UNIT_FIELD_BYTES_0);
    updateVisualBits.SetBit(UNIT_FIELD_FLAGS);
    updateVisualBits.SetBit(UNIT_FIELD_FLAGS_2);
    for (uint16 i = UNIT_FIELD_AURA; i < UNIT_FIELD_AURASTATE; ++i)
        updateVisualBits.SetBit(i);
    updateVisualBits.SetBit(UNIT_FIELD_AURASTATE);
    updateVisualBits.SetBit(UNIT_FIELD_BASEATTACKTIME);
    updateVisualBits.SetBit(UNIT_FIELD_BASEATTACKTIME + 1);
    updateVisualBits.SetBit(UNIT_FIELD_BOUNDINGRADIUS);
    updateVisualBits.SetBit(UNIT_FIELD_COMBATREACH);
    updateVisualBits.SetBit(UNIT_FIELD_DISPLAYID);
    updateVisualBits.SetBit(UNIT_FIELD_NATIVEDISPLAYID);
    updateVisualBits.SetBit(UNIT_FIELD_MOUNTDISPLAYID);
    updateVisualBits.SetBit(UNIT_FIELD_BYTES_1);
    updateVisualBits.SetBit(UNIT_FIELD_PETNUMBER);
    updateVisualBits.SetBit(UNIT_FIELD_PET_NAME_TIMESTAMP);
    updateVisualBits.SetBit(UNIT_DYNAMIC_FLAGS);
    updateVisualBits.SetBit(UNIT_CHANNEL_SPELL);
    updateVisualBits.SetBit(UNIT_MOD_CAST_SPEED);
    updateVisualBits.SetBit(UNIT_FIELD_BYTES_2);

    updateVisualBits.SetBit(PLAYER_DUEL_ARBITER);
    updateVisualBits.SetBit(PLAYER_DUEL_ARBITER+1);
    updateVisualBits.SetBit(PLAYER_FLAGS);
    updateVisualBits.SetBit(PLAYER_GUILDID);
    updateVisualBits.SetBit(PLAYER_GUILDRANK);
    updateVisualBits.SetBit(PLAYER_BYTES);
    updateVisualBits.SetBit(PLAYER_BYTES_2);
    updateVisualBits.SetBit(PLAYER_BYTES_3);
    updateVisualBits.SetBit(PLAYER_DUEL_TEAM);
    updateVisualBits.SetBit(PLAYER_GUILD_TIMESTAMP);

    // PLAYER_QUEST_LOG_x also visible bit on official (but only on party/raid)...
    for (uint16 i = PLAYER_QUEST_LOG_1_1; i < PLAYER_QUEST_LOG_25_2; i+=4)
        updateVisualBits.SetBit(i);

    //Players visible items are not inventory stuff
    //431) = 884 (0x374) = main weapon
    for (uint16 i = 0; i < EQUIPMENT_SLOT_END; i++)
    {
        // item creator
        updateVisualBits.SetBit(PLAYER_VISIBLE_ITEM_1_CREATOR + (i*MAX_VISIBLE_ITEM_OFFSET) + 0);
        updateVisualBits.SetBit(PLAYER_VISIBLE_ITEM_1_CREATOR + (i*MAX_VISIBLE_ITEM_OFFSET) + 1);

        uint16 visual_base = PLAYER_VISIBLE_ITEM_1_0 + (i*MAX_VISIBLE_ITEM_OFFSET);

        // item entry
        updateVisualBits.SetBit(visual_base + 0);

        // item enchantment IDs
        for (uint8 j = 0; j < MAX_INSPECTED_ENCHANTMENT_SLOT; ++j)
            updateVisualBits.SetBit(visual_base + 1 + j);

        // random properties
        updateVisualBits.SetBit(PLAYER_VISIBLE_ITEM_1_PROPERTIES + 0 + (i*MAX_VISIBLE_ITEM_OFFSET));
        updateVisualBits.SetBit(PLAYER_VISIBLE_ITEM_1_PROPERTIES + 1 + (i*MAX_VISIBLE_ITEM_OFFSET));
    }

    updateVisualBits.SetBit(PLAYER_CHOSEN_TITLE);
}

void Player::BuildCreateUpdateBlockForPlayer(UpdateData *data, Player *target) const
{
    if (target == this)
    {
        for (int i = 0; i < EQUIPMENT_SLOT_END; i++)
        {
            if (m_items[i] == NULL)
                continue;

            m_items[i]->BuildCreateUpdateBlockForPlayer(data, target);
        }

        for (int i = INVENTORY_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            if (m_items[i] == NULL)
                continue;

            m_items[i]->BuildCreateUpdateBlockForPlayer(data, target);
        }
        for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
        {
            if (m_items[i] == NULL)
                continue;

            m_items[i]->BuildCreateUpdateBlockForPlayer(data, target);
        }
    }

    Unit::BuildCreateUpdateBlockForPlayer(data, target);
}

void Player::DestroyForPlayer(Player *target) const
{
    Unit::DestroyForPlayer(target);

    for (int i = 0; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (m_items[i] == NULL)
            continue;

        m_items[i]->DestroyForPlayer(target);
    }

    if (target == this)
    {
        for (int i = INVENTORY_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            if (m_items[i] == NULL)
                continue;

            m_items[i]->DestroyForPlayer(target);
        }
        for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
        {
            if (m_items[i] == NULL)
                continue;

            m_items[i]->DestroyForPlayer(target);
        }
    }
}

bool Player::HasSpell(uint32 spell) const
{
    PlayerSpellMap::const_iterator itr = m_spells.find((uint16)spell);
    return (itr != m_spells.end() && itr->second.state != PLAYERSPELL_REMOVED && !itr->second.disabled);
}

TrainerSpellState Player::GetTrainerSpellState(TrainerSpell const* trainer_spell) const
{
    if (!trainer_spell)
        return TRAINER_SPELL_RED;

    if (!trainer_spell->spell)
        return TRAINER_SPELL_RED;

    // known spell
    if (HasSpell(trainer_spell->spell))
        return TRAINER_SPELL_GRAY;

    // check race/class requirement
    if (!IsSpellFitByClassAndRace(trainer_spell->spell))
        return TRAINER_SPELL_RED;

    // check level requirement
    if (getLevel() < trainer_spell->reqLevel)
        return TRAINER_SPELL_RED;

    if (SpellChainNode const* spell_chain = sSpellMgr.GetSpellChainNode(trainer_spell->spell))
    {
        // check prev.rank requirement
        if (spell_chain->prev && !HasSpell(spell_chain->prev))
            return TRAINER_SPELL_RED;
    }

    if (uint32 spell_req = sSpellMgr.GetSpellRequired(trainer_spell->spell))
    {
        // check additional spell requirement
        if (!HasSpell(spell_req))
            return TRAINER_SPELL_RED;
    }

    // check skill requirement
    if (trainer_spell->reqSkill && GetBaseSkillValue(trainer_spell->reqSkill) < trainer_spell->reqSkillValue)
        return TRAINER_SPELL_RED;

    // exist, already checked at loading
    SpellEntry const* spell = sSpellStore.LookupEntry(trainer_spell->spell);

    // secondary prof. or not prof. spell
    uint32 skill = spell->EffectMiscValue[1];

    if (spell->Effect[1] != SPELL_EFFECT_SKILL || !SpellMgr::IsPrimaryProfessionSkill(skill))
        return TRAINER_SPELL_GREEN;

    // check primary prof. limit
    if (sSpellMgr.IsPrimaryProfessionFirstRankSpell(spell->Id) && GetFreePrimaryProfessionPoints() == 0)
        return TRAINER_SPELL_RED;

    return TRAINER_SPELL_GREEN;
}

void Player::DeleteCharacterInfoFromDB(uint32 playerGUIDLow)
{
     // unsummon and delete for pets in world is not required: player deleted from CLI or character list with not loaded pet.
    // Get guids of character's pets, will deleted in transaction
    QueryResultAutoPtr resultPets = RealmDataDatabase.PQuery("SELECT id FROM character_pet WHERE owner = '%u'", playerGUIDLow);

    // NOW we can finally clear other DB data related to character
    RealmDataDatabase.BeginTransaction();
    if (resultPets)
    {
        do
        {
            Field *fields3 = resultPets->Fetch();
            uint32 petguidlow = fields3[0].GetUInt32();
            //do not create separate transaction for pet delete otherwise we will get fatal error!
            Pet::DeleteFromDB(petguidlow, false);
        }
        while (resultPets->NextRow());
    }

    RealmDataDatabase.PExecute("DELETE FROM characters WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_declinedname WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_action WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_aura WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_gifts WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_homebind WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_instance WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM group_instance WHERE leaderGuid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_inventory WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_queststatus WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_reputation WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_spell WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_spell_cooldown WHERE guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM gm_tickets WHERE playerGuid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM item_instance WHERE owner_guid = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_social WHERE guid = '%u' OR friend='%u'", playerGUIDLow, playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM mail WHERE receiver = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM mail_items WHERE receiver = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_pet WHERE owner = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM character_pet_declinedname WHERE owner = '%u'", playerGUIDLow);
    RealmDataDatabase.PExecute("DELETE FROM deleted_chars WHERE char_guid = '%u'", playerGUIDLow);
    RealmDataDatabase.CommitTransaction();
}

void Player::DeleteFromDB(uint64 playerguid, uint32 accountId, bool updateRealmChars)
{
    uint32 guid = GUID_LOPART(playerguid);

    // convert corpse to bones if exist (to prevent exiting Corpse in World without DB entry)
    // bones will be deleted by corpse/bones deleting thread shortly
    sObjectAccessor.ConvertCorpseForPlayer(playerguid);

    // remove from guild
    uint32 guildId = GetGuildIdFromDB(playerguid);
    if (guildId != 0)
    {
        Guild* guild = sGuildMgr.GetGuildById(guildId);
        if (guild)
            guild->DelMember(guid);
    }

    // remove from arena teams
    uint32 at_id = GetArenaTeamIdFromDB(playerguid,ARENA_TEAM_2v2);
    if (at_id != 0)
    {
        ArenaTeam * at = sObjectMgr.GetArenaTeamById(at_id);
        if (at)
            at->DelMember(playerguid);
    }
    at_id = GetArenaTeamIdFromDB(playerguid,ARENA_TEAM_3v3);
    if (at_id != 0)
    {
        ArenaTeam * at = sObjectMgr.GetArenaTeamById(at_id);
        if (at)
            at->DelMember(playerguid);
    }
    at_id = GetArenaTeamIdFromDB(playerguid,ARENA_TEAM_5v5);
    if (at_id != 0)
    {
        ArenaTeam * at = sObjectMgr.GetArenaTeamById(at_id);
        if (at)
            at->DelMember(playerguid);
    }

    // the player was uninvited already on logout so just remove from group
    QueryResultAutoPtr resultGroup = RealmDataDatabase.PQuery("SELECT leaderGuid FROM group_member WHERE memberGuid='%u'", guid);
    if (resultGroup)
    {
        uint64 leaderGuid = MAKE_NEW_GUID((*resultGroup)[0].GetUInt32(), 0, HIGHGUID_PLAYER);
        Group* group = sObjectMgr.GetGroupByLeader(leaderGuid);
        if (group)
        {
            RemoveFromGroup(group, playerguid);
        }
    }

    // remove signs from petitions (also remove petitions if owner);
    RemovePetitionsAndSigns(playerguid, 10);

    // return back all mails with COD and Item                        0     1              2         3       4          5      6       7
    QueryResultAutoPtr resultMail = RealmDataDatabase.PQuery("SELECT id,messageType,mailTemplateId,sender,subject,itemTextId,money,has_items FROM mail WHERE receiver='%u' AND has_items<>0 AND cod<>0", guid);
    if (resultMail)
    {
        do
        {
            Field *fields = resultMail->Fetch();

            uint32 mail_id          = fields[0].GetUInt32();
            uint16 mailType         = fields[1].GetUInt16();
            uint16 mailTemplateId   = fields[2].GetUInt16();
            uint32 sender           = fields[3].GetUInt32();
            std::string subject     = fields[4].GetCppString();
            uint32 itemTextId       = fields[5].GetUInt32();
            uint32 money            = fields[6].GetUInt32();
            bool has_items          = fields[7].GetBool();

            //we can return mail now
            //so firstly delete the old one
            RealmDataDatabase.PExecute("DELETE FROM mail WHERE id = '%u'", mail_id);

            // mail not from player
            if (mailType != MAIL_NORMAL)
            {
                if(has_items)
                    RealmDataDatabase.PExecute("DELETE FROM mail_items WHERE mail_id = '%u'", mail_id);
                continue;
            }

            MailDraft draft;
            if (mailTemplateId)
                draft.SetMailTemplate(mailTemplateId, false);// items already included
            else
                draft.SetSubjectAndBodyId(subject, itemTextId);

            if (has_items)
            {
                QueryResultAutoPtr resultItems = RealmDataDatabase.PQuery("SELECT item_guid,item_template FROM mail_items WHERE mail_id='%u'", mail_id);
                if (resultItems)
                {
                    do
                    {
                        Field *fields2 = resultItems->Fetch();

                        uint32 item_guidlow = fields2[0].GetUInt32();
                        uint32 item_template = fields2[1].GetUInt32();

                        ItemPrototype const* itemProto = ObjectMgr::GetItemPrototype(item_template);
                        if (!itemProto)
                        {
                            RealmDataDatabase.PExecute("DELETE FROM item_instance WHERE guid = '%u'", item_guidlow);
                            continue;
                        }

                        Item *pItem = NewItemOrBag(itemProto);
                        if (!pItem->LoadFromDB(item_guidlow, MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER)))
                        {
                            pItem->FSetState(ITEM_REMOVED);
                            pItem->SaveToDB();              // it also deletes item object !
                            continue;
                        }

                        draft.AddItem(pItem);
                    }
                    while (resultItems->NextRow());
                }
            }

            RealmDataDatabase.PExecute("DELETE FROM mail_items WHERE mail_id = '%u'", mail_id);

            uint32 pl_account = sObjectMgr.GetPlayerAccountIdByGUID(MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER));

            draft.SetMoney(money).SendReturnToSender(pl_account, ObjectGuid(playerguid), ObjectGuid(HIGHGUID_PLAYER, sender));
        }
        while (resultMail->NextRow());
    }

    if (sWorld.getConfig(CONFIG_DONT_DELETE_CHARS))
    {
        if (QueryResultAutoPtr result= RealmDataDatabase.PQuery("SELECT data FROM characters WHERE guid='%u'",guid))
        {
            Field *fields = result->Fetch();

            Tokens data = StrSplit(fields[0].GetCppString(), " ");
            uint32 plLevel = Player::GetUInt32ValueFromArray(data,UNIT_FIELD_LEVEL);

            if (plLevel >= sWorld.getConfig(CONFIG_DONT_DELETE_CHARS_LVL))
            {
                RealmDataDatabase.PExecute("Call PreventCharDelete(%u)", guid);

                if (updateRealmChars)
                    sWorld.UpdateRealmCharCount(accountId);
                return;
            }
        }
    }

    // finally delete rest character informations (pets, spells, auras, items etc)
    DeleteCharacterInfoFromDB(guid);

    //LoginDatabase.PExecute("UPDATE realmcharacters SET numchars = numchars - 1 WHERE acctid = %d AND realmid = %d", accountId, realmID);
    if (updateRealmChars)
        sWorld.UpdateRealmCharCount(accountId);
}

void Player::SetMovement(PlayerMovementType pType)
{
    WorldPacket data;
    switch (pType)
    {
        case MOVE_ROOT:       data.Initialize(SMSG_FORCE_MOVE_ROOT,   GetPackGUID().size()+4); break;
        case MOVE_UNROOT:     data.Initialize(SMSG_FORCE_MOVE_UNROOT, GetPackGUID().size()+4); break;
        case MOVE_WATER_WALK: data.Initialize(SMSG_MOVE_WATER_WALK,   GetPackGUID().size()+4); break;
        case MOVE_LAND_WALK:  data.Initialize(SMSG_MOVE_LAND_WALK,    GetPackGUID().size()+4); break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: Player::SetMovement: Unsupported move type (%d), data not sent to client.",pType);
            return;
    }
    data << GetPackGUID();
    data << uint32(0);
    SendPacketToSelf(&data);
}

/* Preconditions:
  - a resurrectable corpse must not be loaded for the player (only bones)
  - the player must be in world
*/
void Player::BuildPlayerRepop()
{
    if (getRace() == RACE_NIGHTELF)
        CastSpell(this, 20584, true);                       // auras SPELL_AURA_INCREASE_SPEED(+speed in wisp form), SPELL_AURA_INCREASE_SWIM_SPEED(+swim speed in wisp form), SPELL_AURA_TRANSFORM (to wisp form)
    CastSpell(this, 8326, true);                            // auras SPELL_AURA_GHOST, SPELL_AURA_INCREASE_SPEED(why?), SPELL_AURA_INCREASE_SWIM_SPEED(why?)

    // there must be SMSG.FORCE_RUN_SPEED_CHANGE, SMSG.FORCE_SWIM_SPEED_CHANGE, SMSG.MOVE_WATER_WALK
    // there must be SMSG.STOP_MIRROR_TIMER
    // there we must send 888 opcode

    // the player cannot have a corpse already, only bones which are not returned by GetCorpse
    if (GetCorpse())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: BuildPlayerRepop: player %s(%d) already has a corpse", GetName(), GetGUIDLow());
        ASSERT(false);
    }

    // create a corpse and place it at the player's location
    CreateCorpse();
    Corpse *corpse = GetCorpse();
    if (!corpse)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Error creating corpse for Player %s [%u]", GetName(), GetGUIDLow());
        return;
    }
    GetMap()->Add(corpse);

    SetHealth(1, true);

    SetMovement(MOVE_WATER_WALK);
    if (!GetSession()->isLogingOut())
        SetMovement(MOVE_UNROOT);

    // BG - remove insignia related
    RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);

//    SendCorpseReclaimDelay();

    // to prevent cheating
    corpse->ResetGhostTime();

    StopMirrorTimers();                                     //disable timers(bars)

    SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, (float)1.0);   //see radius of death player?

    SetByteValue(UNIT_FIELD_BYTES_1, 3, PLAYER_STATE_FLAG_ALWAYS_STAND);
}

void Player::SendDelayResponse(const uint32 ml_seconds)
{
    //FIXME: is this delay time arg really need? 50msec by default in code
    WorldPacket data(SMSG_QUERY_TIME_RESPONSE, 4+4);
    data << (uint32)time(NULL);
    data << (uint32)0;
    SendPacketToSelf(&data);
}

void Player::ResurrectPlayer(float restore_percent, bool applySickness)
{
    WorldPacket data(SMSG_DEATH_RELEASE_LOC, 4*4);          // remove spirit healer position
    data << uint32(-1);
    data << float(0);
    data << float(0);
    data << float(0);
    SendPacketToSelf(&data);

    // speed change, land walk

    // remove death flag + set aura
    SetByteValue(UNIT_FIELD_BYTES_1, 3, 0x00);
    if (getRace() == RACE_NIGHTELF)
        RemoveAurasDueToSpell(20584);                       // speed bonuses
    RemoveAurasDueToSpell(8326);                            // SPELL_AURA_GHOST

    setDeathState(ALIVE);

    SetMovement(MOVE_LAND_WALK);
    SetMovement(MOVE_UNROOT);

    m_deathTimer = 0;

    // set health/powers (0- will be set in caller)
    if (restore_percent>0.0f)
    {
        SetHealth(uint32(GetMaxHealth()*restore_percent));
        SetPower(POWER_MANA, uint32(GetMaxPower(POWER_MANA)*restore_percent));
        SetPower(POWER_RAGE, 0);
        SetPower(POWER_ENERGY, uint32(GetMaxPower(POWER_ENERGY)*restore_percent));
    }

    //HACK restore Alchemist stone aura
    Item * item = NULL;
    if ((item = HasEquiped(13503)) ||
        (item = HasEquiped(35751)) ||
        (item = HasEquiped(35748)) ||
        (item = HasEquiped(35750)) ||
        (item = HasEquiped(35749)))
        CastSpell(this, 17619, true, item);

    UpdateZone(GetZoneId());

    UpdateVisibilityAndView();

    if (!applySickness)
        return;

    //Characters from level 1-10 are not affected by resurrection sickness.
    //Characters from level 11-19 will suffer from one minute of sickness
    //for each level they are above 10.
    //Characters level 20 and up suffer from ten minutes of sickness.
    int32 startLevel = sWorld.getConfig(CONFIG_DEATH_SICKNESS_LEVEL);

    if (int32(getLevel()) >= startLevel)
    {
        // set resurrection sickness
        CastSpell(this,SPELL_ID_PASSIVE_RESURRECTION_SICKNESS,true);

        // not full duration
        if (int32(getLevel()) < startLevel+9)
        {
            int32 delta = (int32(getLevel()) - startLevel + 1)*MINUTE;

            for (int i =0; i < 3; ++i)
            {
                if (Aura* Aur = GetAura(SPELL_ID_PASSIVE_RESURRECTION_SICKNESS,i))
                {
                    Aur->SetAuraDuration(delta*1000);
                    Aur->UpdateAuraDuration();
                }
            }
        }
    }
}

void Player::KillPlayer()
{
    SetMovement(MOVE_ROOT);

    StopMirrorTimers();                                     //disable timers(bars)

    setDeathState(CORPSE);
    //SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_IN_PVP);

    SetFlag(UNIT_DYNAMIC_FLAGS, 0x00);
    ApplyModFlag(PLAYER_FIELD_BYTES, PLAYER_FIELD_BYTE_RELEASE_TIMER, !sMapStore.LookupEntry(GetMapId())->Instanceable());

    // 6 minutes until repop at graveyard
    m_deathTimer = 6*MINUTE*1000;

    UpdateCorpseReclaimDelay();                             // dependent at use SetDeathPvP() call before kill
    SendCorpseReclaimDelay();

    // don't create corpse at this moment, player might be falling

    // update visibility
    UpdateObjectVisibility();
}

void Player::CreateCorpse()
{
    // prevent existence 2 corpse for player
    SpawnCorpseBones();

    uint32 _uf, _pb, _pb2, _cfb1, _cfb2;

    Corpse *corpse = new Corpse((m_ExtraFlags & PLAYER_EXTRA_PVP_DEATH) ? CORPSE_RESURRECTABLE_PVP : CORPSE_RESURRECTABLE_PVE);
    SetPvPDeath(false);

    if (!corpse->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_CORPSE), this))
    {
        delete corpse;
        return;
    }

    _uf = GetUInt32Value(UNIT_FIELD_BYTES_0);
    _pb = GetUInt32Value(PLAYER_BYTES);
    _pb2 = GetUInt32Value(PLAYER_BYTES_2);

    uint8 race       = (uint8)(_uf);
    uint8 skin       = (uint8)(_pb);
    uint8 face       = (uint8)(_pb >> 8);
    uint8 hairstyle  = (uint8)(_pb >> 16);
    uint8 haircolor  = (uint8)(_pb >> 24);
    uint8 facialhair = (uint8)(_pb2);

    _cfb1 = ((0x00) | (race << 8) | (getGender() << 16) | (skin << 24));
    _cfb2 = ((face) | (hairstyle << 8) | (haircolor << 16) | (facialhair << 24));

    corpse->SetUInt32Value(CORPSE_FIELD_BYTES_1, _cfb1);
    corpse->SetUInt32Value(CORPSE_FIELD_BYTES_2, _cfb2);

    uint32 flags = CORPSE_FLAG_UNK2;
    if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM))
        flags |= CORPSE_FLAG_HIDE_HELM;
    if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_CLOAK))
        flags |= CORPSE_FLAG_HIDE_CLOAK;
    if (InBattleGround() && !InArena())
        flags |= CORPSE_FLAG_LOOTABLE;                      // to be able to remove insignia
    corpse->SetUInt32Value(CORPSE_FIELD_FLAGS, flags);

    corpse->SetUInt32Value(CORPSE_FIELD_DISPLAY_ID, GetNativeDisplayId());

    corpse->SetUInt32Value(CORPSE_FIELD_GUILD, GetGuildId());

    uint32 iDisplayID;
    uint16 iIventoryType;
    uint32 _cfi;
    for (int i = 0; i < EQUIPMENT_SLOT_END; i++)
    {
        if (m_items[i])
        {
            iDisplayID = m_items[i]->GetProto()->DisplayInfoID;
            iIventoryType = (uint16)m_items[i]->GetProto()->InventoryType;

            _cfi =  (uint16(iDisplayID)) | (iIventoryType)<< 24;
            corpse->SetUInt32Value(CORPSE_FIELD_ITEM + i,_cfi);
        }
    }

    // we don't SaveToDB for players in battlegrounds so don't do it for corpses either
    const MapEntry *entry = sMapStore.LookupEntry(corpse->GetMapId());
    ASSERT(entry);
    if (entry->map_type != MAP_BATTLEGROUND)
        corpse->SaveToDB();

    // register for player, but not show
    sObjectAccessor.AddCorpse(corpse);
}

void Player::SpawnCorpseBones()
{
    if (sObjectAccessor.ConvertCorpseForPlayer(GetGUID()))
    {
        if (!GetSession()->PlayerLogoutWithSave())
            SaveToDB();                                         // prevent loading as ghost without corpse
    }
}

Corpse* Player::GetCorpse() const
{
    return sObjectAccessor.GetCorpseForPlayerGUID(GetGUID());
}

void Player::DurabilityLossAll(double percent, bool inventory)
{
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
        if (Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            DurabilityLoss(pItem,percent);

    if (inventory)
    {
        // bags not have durability
        // for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)

        for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
            if (Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                DurabilityLoss(pItem,percent);

        // keys not have durability
        //for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)

        for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
            if (Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                    if (Item* pItem = GetItemByPos(i, j))
                        DurabilityLoss(pItem,percent);
    }
}

void Player::DurabilityLoss(Item* item, double percent)
{
    if (!item)
        return;

    uint32 pMaxDurability =  item ->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);

    if (!pMaxDurability)
        return;

    uint32 pDurabilityLoss = uint32(pMaxDurability*percent);

    if (pDurabilityLoss < 1)
        pDurabilityLoss = 1;

    DurabilityPointsLoss(item,pDurabilityLoss);
}

void Player::DurabilityPointsLossAll(int32 points, bool inventory)
{
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
        if (Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            DurabilityPointsLoss(pItem,points);

    if (inventory)
    {
        // bags not have durability
        // for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)

        for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
            if (Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                DurabilityPointsLoss(pItem,points);

        // keys not have durability
        //for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)

        for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
            if (Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                    if (Item* pItem = GetItemByPos(i, j))
                        DurabilityPointsLoss(pItem,points);
    }
}

void Player::DurabilityPointsLoss(Item* item, int32 points)
{
    int32 pMaxDurability = item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);
    int32 pOldDurability = item->GetUInt32Value(ITEM_FIELD_DURABILITY);
    int32 pNewDurability = pOldDurability - points;

    if (pNewDurability < 0)
        pNewDurability = 0;
    else if (pNewDurability > pMaxDurability)
        pNewDurability = pMaxDurability;

    if (pOldDurability != pNewDurability)
    {
        // modify item stats _before_ Durability set to 0 to pass _ApplyItemMods internal check
        if (pNewDurability == 0 && pOldDurability > 0 && item->IsEquipped())
            _ApplyItemMods(item,item->GetSlot(), false);

        item->SetUInt32Value(ITEM_FIELD_DURABILITY, pNewDurability);

        // modify item stats _after_ restore durability to pass _ApplyItemMods internal check
        if (pNewDurability > 0 && pOldDurability == 0 && item->IsEquipped())
            _ApplyItemMods(item,item->GetSlot(), true);

        item->SetState(ITEM_CHANGED, this);
    }
}

void Player::DurabilityPointLossForEquipSlot(EquipmentSlots slot)
{
    if (Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
        DurabilityPointsLoss(pItem,1);
}

uint32 Player::DurabilityRepairAll(bool cost, float discountMod, bool guildBank)
{
    uint32 TotalCost = 0;
    // equipped, backpack, bags itself
    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
        TotalCost += DurabilityRepair(((INVENTORY_SLOT_BAG_0 << 8) | i),cost,discountMod, guildBank);

    // bank, buyback and keys not repaired

    // items in inventory bags
    for (int j = INVENTORY_SLOT_BAG_START; j < INVENTORY_SLOT_BAG_END; j++)
        for (int i = 0; i < MAX_BAG_SIZE; i++)
            TotalCost += DurabilityRepair(((j << 8) | i),cost,discountMod, guildBank);
    return TotalCost;
}

uint32 Player::DurabilityRepair(uint16 pos, bool cost, float discountMod, bool guildBank)
{
    Item* item = GetItemByPos(pos);

    uint32 TotalCost = 0;
    if (!item)
        return TotalCost;

    uint32 maxDurability = item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);
    if (!maxDurability)
        return TotalCost;

    uint32 curDurability = item->GetUInt32Value(ITEM_FIELD_DURABILITY);

    if (cost)
    {
        uint32 LostDurability = maxDurability - curDurability;
        if (LostDurability>0)
        {
            ItemPrototype const *ditemProto = item->GetProto();

            DurabilityCostsEntry const *dcost = sDurabilityCostsStore.LookupEntry(ditemProto->ItemLevel);
            if (!dcost)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: RepairDurability: Wrong item lvl %u", ditemProto->ItemLevel);
                return TotalCost;
            }

            uint32 dQualitymodEntryId = (ditemProto->Quality+1)*2;
            DurabilityQualityEntry const *dQualitymodEntry = sDurabilityQualityStore.LookupEntry(dQualitymodEntryId);
            if (!dQualitymodEntry)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: RepairDurability: Wrong dQualityModEntry %u", dQualitymodEntryId);
                return TotalCost;
            }

            uint32 dmultiplier = dcost->multiplier[ItemSubClassToDurabilityMultiplierId(ditemProto->Class,ditemProto->SubClass)];
            uint32 costs = uint32(LostDurability*dmultiplier*double(dQualitymodEntry->quality_mod));

            costs = uint32(costs * discountMod);

            if (costs==0)                                   //fix for ITEM_QUALITY_ARTIFACT
                costs = 1;

            if (guildBank)
            {
                if (GetGuildId()==0)
                {
                    DEBUG_LOG("You are not member of a guild");
                    return TotalCost;
                }

                Guild *pGuild = sGuildMgr.GetGuildById(GetGuildId());
                if (!pGuild)
                    return TotalCost;

                if (!pGuild->HasRankRight(GetRank(), GR_RIGHT_WITHDRAW_REPAIR))
                {
                    DEBUG_LOG("You do not have rights to withdraw for repairs");
                    return TotalCost;
                }

                if (pGuild->GetMemberMoneyWithdrawRem(GetGUIDLow()) < costs)
                {
                    DEBUG_LOG("You do not have enough money withdraw amount remaining");
                    return TotalCost;
                }

                if (pGuild->GetGuildBankMoney() < costs)
                {
                    DEBUG_LOG("There is not enough money in bank");
                    return TotalCost;
                }

                pGuild->MemberMoneyWithdraw(costs, GetGUIDLow());
                TotalCost = costs;
            }
            else if (GetMoney() < costs)
            {
                DEBUG_LOG("You do not have enough money");
                return TotalCost;
            }
            else
                ModifyMoney(-int32(costs));
        }
    }

    item->SetUInt32Value(ITEM_FIELD_DURABILITY, maxDurability);
    item->SetState(ITEM_CHANGED, this);

    // reapply mods for total broken and repaired item if equipped
    if (IsEquipmentPos(pos) && !curDurability)
        _ApplyItemMods(item,pos & 255, true);
    return TotalCost;
}

void Player::RepopAtGraveyard()
{
    // note: this can be called also when the player is alive
    // for example from WorldSession::HandleMovementOpcodes

    AreaTableEntry const *zone = GetAreaEntryByAreaID(GetCachedArea());

    // Such zones are considered unreachable as a ghost and the player must be automatically revived
    if (!isAlive() && zone && zone->flags & AREA_FLAG_NEED_FLY || GetTransport() || GetPositionZ() < -500.0f)
    {
        ResurrectPlayer(0.5f);
        SpawnCorpseBones();
    }

    TeleportToNearestGraveyard();
}

void Player::TeleportToNearestGraveyard()
{
    WorldSafeLocsEntry const *ClosestGrave = NULL;

    // Special handle for battleground maps
    if (BattleGround *bg = GetBattleGround())
    {
        switch (bg->GetTypeID())
        {
            case BATTLEGROUND_AB:
            case BATTLEGROUND_EY:
            case BATTLEGROUND_AV:
            case BATTLEGROUND_WS:
                ClosestGrave = bg->GetClosestGraveYard(GetPositionX(), GetPositionY(), GetPositionZ(), GetBGTeam());
                break;
            default:
                ClosestGrave = sObjectMgr.GetClosestGraveYard(GetPositionX(), GetPositionY(), GetPositionZ(), GetMapId(), GetTeam());
                break;

        }
    }
    else
        ClosestGrave = sObjectMgr.GetClosestGraveYard(GetPositionX(), GetPositionY(), GetPositionZ(), GetMapId(), GetTeam());

    // stop countdown until repop
    m_deathTimer = 0;

    // if no grave found, stay at the current location
    // and don't show spirit healer location
    if (ClosestGrave)
    {
        TeleportTo(ClosestGrave->map_id, ClosestGrave->x, ClosestGrave->y, ClosestGrave->z, GetOrientation());
        if (isDead())                                        // not send if alive, because it used in TeleportTo()
        {
            WorldPacket data(SMSG_DEATH_RELEASE_LOC, 4*4);  // show spirit healer position on minimap
            data << ClosestGrave->map_id;
            data << ClosestGrave->x;
            data << ClosestGrave->y;
            data << ClosestGrave->z;
            SendPacketToSelf(&data);
        }
    }
}

void Player::JoinedChannel(Channel *c)
{
    m_channels.push_back(c);
}

void Player::LeftChannel(Channel *c)
{
    m_channels.remove(c);
}

void Player::CleanupChannels()
{
    while (!m_channels.empty())
    {
        Channel* ch = *m_channels.begin();
        m_channels.erase(m_channels.begin());               // remove from player's channel list
        ch->Leave(GetGUID(), false);                        // not send to client, not remove from player's channel list
        if (ChannelMgr* cMgr = channelMgr(GetTeam()))
            cMgr->LeftChannel(ch->GetName());               // deleted channel if empty

    }
    sLog.outDebug("Player: channels cleaned up!");
}

void Player::UpdateLocalChannels(uint32 newZone)
{
    if (m_channels.empty())
        return;

    AreaTableEntry const* current_zone = GetAreaEntryByAreaID(newZone);
    if (!current_zone)
        return;

    ChannelMgr* cMgr = channelMgr(GetTeam());
    if (!cMgr)
        return;

    std::string current_zone_name = current_zone->area_name[GetSession()->GetSessionDbcLocale()];

    for (JoinedChannelsList::iterator i = m_channels.begin(), next; i != m_channels.end(); i = next)
    {
        next = i; ++next;

        // skip non built-in channels
        if (!(*i)->IsConstant())
            continue;

        ChatChannelsEntry const* ch = GetChannelEntryFor((*i)->GetChannelId());
        if (!ch)
            continue;

        if ((ch->flags & 4) == 4)                            // global channel without zone name in pattern
            continue;

        //  new channel
        char new_channel_name_buf[100];
        snprintf(new_channel_name_buf,100,ch->pattern[m_session->GetSessionDbcLocale()],current_zone_name.c_str());
        Channel* new_channel = cMgr->GetJoinChannel(new_channel_name_buf,ch->ChannelID);

        if ((*i)!=new_channel)
        {
            new_channel->Join(GetGUID(),"");                // will output Changed Channel: N. Name

            // leave old channel
            (*i)->Leave(GetGUID(),false);                   // not send leave channel, it already replaced at client
            std::string name = (*i)->GetName();             // store name, (*i)erase in LeftChannel
            LeftChannel(*i);                                // remove from player's channel list
            cMgr->LeftChannel(name);                        // delete if empty
        }
    }
    sLog.outDebug("Player: channels cleaned up!");
}

void Player::LeaveLFGChannel()
{
    if (!sWorld.getConfig(CONFIG_RESTRICTED_LFG_CHANNEL) || GetSession()->HasPermissions(PERM_GMT))
        return;

    // don't kick if on lfg or lfm
    if (!m_lookingForGroup.Empty())
        return;

    for (JoinedChannelsList::iterator i = m_channels.begin(); i != m_channels.end(); ++i)
    {
        if ((*i)->IsLFG())
        {
            (*i)->Leave(GetGUID());
            break;
        }
    }
}

void Player::JoinLFGChannel()
{
    if (m_lookingForGroup.Empty())
        return;

    for (JoinedChannelsList::iterator i = m_channels.begin(); i != m_channels.end(); ++i)
        if ((*i)->IsLFG())
            return;

    /*if (ChannelMgr* cMgr = channelMgr(GetTeam()))
        if (Channel *chn = cMgr->GetJoinChannel("LookingForGroup", 26))
            chn->Invite(GetGUID(), GetName());*/

    WorldPacket data;

    data.Initialize(SMSG_CHANNEL_NOTIFY, 17);   // "LookingForGroup count + 2
    data << uint8(0x18);        // CHAT_INVITE_NOTICE
    data << "LookingForGroup";  // channel name
    data << GetGUID();          // player guid

    SendPacketToSelf(&data);
}

void Player::UpdateDefense()
{
    uint32 defense_skill_gain = sWorld.getConfig(CONFIG_SKILL_GAIN_DEFENSE);

    if (UpdateSkill(SKILL_DEFENSE,defense_skill_gain))
    {
        // update dependent from defense skill part
        UpdateDefenseBonusesMod();
    }
}

void Player::HandleBaseModValue(BaseModGroup modGroup, BaseModType modType, float amount, bool apply)
{
    if (modGroup >= BASEMOD_END || modType >= MOD_END)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: ERROR in HandleBaseModValue(): non existed BaseModGroup of wrong BaseModType!");
        return;
    }

    float val = 1.0f;

    switch (modType)
    {
        case FLAT_MOD:
            m_auraBaseMod[modGroup][modType] += apply ? amount : -amount;
            break;
        case PCT_MOD:
            if (amount <= -100.0f)
                amount = -200.0f;

            val = (100.0f + amount) / 100.0f;
            m_auraBaseMod[modGroup][modType] *= apply ? val : (1.0f/val);
            break;
    }

    if (!CanModifyStats())
        return;

    switch (modGroup)
    {
        case CRIT_PERCENTAGE:              UpdateCritPercentage(BASE_ATTACK);                          break;
        case RANGED_CRIT_PERCENTAGE:       UpdateCritPercentage(RANGED_ATTACK);                        break;
        case OFFHAND_CRIT_PERCENTAGE:      UpdateCritPercentage(OFF_ATTACK);                           break;
        case SHIELD_BLOCK_VALUE:           UpdateShieldBlockValue();                                   break;
        default: break;
    }
}

float Player::GetBaseModValue(BaseModGroup modGroup, BaseModType modType) const
{
    if (modGroup >= BASEMOD_END || modType > MOD_END)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: trial to access non existed BaseModGroup or wrong BaseModType!");
        return 0.0f;
    }

    if (modType == PCT_MOD && m_auraBaseMod[modGroup][PCT_MOD] <= 0.0f)
        return 0.0f;

    return m_auraBaseMod[modGroup][modType];
}

float Player::GetTotalBaseModValue(BaseModGroup modGroup) const
{
    if (modGroup >= BASEMOD_END)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: wrong BaseModGroup in GetTotalBaseModValue()!");
        return 0.0f;
    }

    if (m_auraBaseMod[modGroup][PCT_MOD] <= 0.0f)
        return 0.0f;

    return m_auraBaseMod[modGroup][FLAT_MOD] * m_auraBaseMod[modGroup][PCT_MOD];
}

uint32 Player::GetShieldBlockValue() const
{
    BaseModGroup modGroup = SHIELD_BLOCK_VALUE;

    float value = (m_auraBaseMod[SHIELD_BLOCK_VALUE][FLAT_MOD] + GetStat(STAT_STRENGTH) * 0.05f - 1)*m_auraBaseMod[SHIELD_BLOCK_VALUE][PCT_MOD];

    value = (value < 0) ? 0 : value;

    return uint32(value);
}

float Player::GetMeleeCritFromAgility()
{
    uint32 level = getLevel();
    uint32 pclass = getClass();

    if (level>GT_MAX_LEVEL) level = GT_MAX_LEVEL;

    GtChanceToMeleeCritBaseEntry const *critBase  = sGtChanceToMeleeCritBaseStore.LookupEntry(pclass-1);
    GtChanceToMeleeCritEntry     const *critRatio = sGtChanceToMeleeCritStore.LookupEntry((pclass-1)*GT_MAX_LEVEL + level-1);
    if (critBase==NULL || critRatio==NULL)
        return 0.0f;

    float crit=critBase->base + GetStat(STAT_AGILITY)*critRatio->ratio;
    return crit*100.0f;
}

float Player::GetDodgeFromAgility()
{
    // Table for base dodge values
    float dodge_base[MAX_CLASSES] = {
         0.0075f,   // Warrior
         0.00652f,  // Paladin
        -0.0545f,   // Hunter
        -0.0059f,   // Rogue
         0.03183f,  // Priest
         0.0114f,   // DK
         0.0167f,   // Shaman
         0.034575f, // Mage
         0.02011f,  // Warlock
         0.0f,      // ??
        -0.0187f    // Druid
    };
    // Crit/agility to dodge/agility coefficient multipliers
    float crit_to_dodge[MAX_CLASSES] = {
         1.1f,      // Warrior
         1.0f,      // Paladin
         1.6f,      // Hunter
         2.0f,      // Rogue
         1.0f,      // Priest
         1.0f,      // DK?
         1.0f,      // Shaman
         1.0f,      // Mage
         1.0f,      // Warlock
         0.0f,      // ??
         1.7f       // Druid
    };

    uint32 level = getLevel();
    uint32 pclass = getClass();

    if (level>GT_MAX_LEVEL) level = GT_MAX_LEVEL;

    // Dodge per agility for most classes equal crit per agility (but for some classes need apply some multiplier)
    GtChanceToMeleeCritEntry  const *dodgeRatio = sGtChanceToMeleeCritStore.LookupEntry((pclass-1)*GT_MAX_LEVEL + level-1);
    if (dodgeRatio==NULL || pclass > MAX_CLASSES)
        return 0.0f;

    float dodge=dodge_base[pclass-1] + GetStat(STAT_AGILITY) * dodgeRatio->ratio * crit_to_dodge[pclass-1];
    return dodge*100.0f;
}

float Player::GetSpellCritFromIntellect()
{
    uint32 level = getLevel();
    uint32 pclass = getClass();

    if (level>GT_MAX_LEVEL) level = GT_MAX_LEVEL;

    GtChanceToSpellCritBaseEntry const *critBase  = sGtChanceToSpellCritBaseStore.LookupEntry(pclass-1);
    GtChanceToSpellCritEntry     const *critRatio = sGtChanceToSpellCritStore.LookupEntry((pclass-1)*GT_MAX_LEVEL + level-1);
    if (critBase==NULL || critRatio==NULL)
        return 0.0f;

    float crit=critBase->base + GetStat(STAT_INTELLECT)*critRatio->ratio;
    return crit*100.0f;
}

float Player::GetRatingCoefficient(CombatRating cr) const
{
    uint32 level = getLevel();

    if (level>GT_MAX_LEVEL) level = GT_MAX_LEVEL;

    GtCombatRatingsEntry const *Rating = sGtCombatRatingsStore.LookupEntry(cr*GT_MAX_LEVEL+level-1);
    if (Rating == NULL)
        return 1.0f;                                        // By default use minimum coefficient (not must be called)

    return Rating->ratio;
}

float Player::GetRatingBonusValue(CombatRating cr) const
{
    return float(GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + cr)) / GetRatingCoefficient(cr);
}

uint32 Player::GetMeleeCritDamageReduction(uint32 damage) const
{
    float melee  = GetRatingBonusValue(CR_CRIT_TAKEN_MELEE)*2.0f;
    if (melee>25.0f) melee = 25.0f;
    return uint32 (melee * damage /100.0f);
}

uint32 Player::GetRangedCritDamageReduction(uint32 damage) const
{
    float ranged = GetRatingBonusValue(CR_CRIT_TAKEN_RANGED)*2.0f;
    if (ranged>25.0f) ranged=25.0f;
    return uint32 (ranged * damage /100.0f);
}

uint32 Player::GetSpellCritDamageReduction(uint32 damage) const
{
    float spell = GetRatingBonusValue(CR_CRIT_TAKEN_SPELL)*2.0f;
    // In wow script resilience limited to 25%
    if (spell>25.0f)
        spell = 25.0f;
    return uint32 (spell * damage / 100.0f);
}

uint32 Player::GetDotDamageReduction(uint32 damage) const
{
    float spellDot = GetRatingBonusValue(CR_CRIT_TAKEN_SPELL);
    // Dot resilience not limited (limit it by 100%)
    if (spellDot > 100.0f)
        spellDot = 100.0f;
    return uint32 (spellDot * damage / 100.0f);
}

float Player::GetExpertiseDodgeOrParryReduction(WeaponAttackType attType) const
{
    switch (attType)
    {
        case BASE_ATTACK:
            return GetUInt32Value(PLAYER_EXPERTISE) / 4.0f;
        case OFF_ATTACK:
            return GetUInt32Value(PLAYER_OFFHAND_EXPERTISE) / 4.0f;
        default:
            break;
    }
    return 0.0f;
}

float Player::OCTRegenHPPerSpirit()
{
    uint32 level = getLevel();
    uint32 pclass = getClass();

    if (level>GT_MAX_LEVEL) level = GT_MAX_LEVEL;

    GtOCTRegenHPEntry     const *baseRatio = sGtOCTRegenHPStore.LookupEntry((pclass-1)*GT_MAX_LEVEL + level-1);
    GtRegenHPPerSptEntry  const *moreRatio = sGtRegenHPPerSptStore.LookupEntry((pclass-1)*GT_MAX_LEVEL + level-1);
    if (baseRatio==NULL || moreRatio==NULL)
        return 0.0f;

    // Formula from PaperDollFrame script
    float spirit = GetStat(STAT_SPIRIT);
    float baseSpirit = spirit;
    if (baseSpirit>50) baseSpirit = 50;
    float moreSpirit = spirit - baseSpirit;
    float regen = baseSpirit * baseRatio->ratio + moreSpirit * moreRatio->ratio;
    return regen;
}

float Player::OCTRegenMPPerSpirit()
{
    uint32 level = getLevel();
    uint32 pclass = getClass();

    if (level>GT_MAX_LEVEL) level = GT_MAX_LEVEL;

//    GtOCTRegenMPEntry     const *baseRatio = sGtOCTRegenMPStore.LookupEntry((pclass-1)*GT_MAX_LEVEL + level-1);
    GtRegenMPPerSptEntry  const *moreRatio = sGtRegenMPPerSptStore.LookupEntry((pclass-1)*GT_MAX_LEVEL + level-1);
    if (moreRatio==NULL)
        return 0.0f;

    // Formula get from PaperDollFrame script
    float spirit    = GetStat(STAT_SPIRIT);
    float regen     = spirit * moreRatio->ratio;
    return regen;
}

void Player::ApplyRatingMod(CombatRating cr, int32 value, bool apply)
{
    ApplyModUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + cr, value, apply);

    float RatingCoeffecient = GetRatingCoefficient(cr);
    float RatingChange = 0.0f;

    bool affectStats = CanModifyStats();

    switch (cr)
    {
        case CR_WEAPON_SKILL:                               // Implemented in Unit::RollMeleeOutcomeAgainst
        case CR_DEFENSE_SKILL:
            UpdateDefenseBonusesMod();
            break;
        case CR_DODGE:
            UpdateDodgePercentage();
            break;
        case CR_PARRY:
            UpdateParryPercentage();
            break;
        case CR_BLOCK:
            UpdateBlockPercentage();
            break;
        case CR_HIT_MELEE:
            RatingChange = value / RatingCoeffecient;
            m_modMeleeHitChance += apply ? RatingChange : -RatingChange;
            break;
        case CR_HIT_RANGED:
            RatingChange = value / RatingCoeffecient;
            m_modRangedHitChance += apply ? RatingChange : -RatingChange;
            break;
        case CR_HIT_SPELL:
            RatingChange = value / RatingCoeffecient;
            m_modSpellHitChance += apply ? RatingChange : -RatingChange;
            break;
        case CR_CRIT_MELEE:
            if (affectStats)
            {
                UpdateCritPercentage(BASE_ATTACK);
                UpdateCritPercentage(OFF_ATTACK);
            }
            break;
        case CR_CRIT_RANGED:
            if (affectStats)
                UpdateCritPercentage(RANGED_ATTACK);
            break;
        case CR_CRIT_SPELL:
            if (affectStats)
                UpdateAllSpellCritChances();
            break;
        case CR_HIT_TAKEN_MELEE:                            // Implemented in Unit::MeleeMissChanceCalc
        case CR_HIT_TAKEN_RANGED:
            break;
        case CR_HIT_TAKEN_SPELL:                            // Implemented in Unit::MagicSpellHitResult
            break;
        case CR_CRIT_TAKEN_MELEE:                           // Implemented in Unit::RollMeleeOutcomeAgainst (only for chance to crit)
        case CR_CRIT_TAKEN_RANGED:
            break;
        case CR_CRIT_TAKEN_SPELL:                           // Implemented in Unit::SpellCriticalBonus (only for chance to crit)
            break;
        case CR_HASTE_MELEE:
            RatingChange = value / RatingCoeffecient;
            ApplyAttackTimePercentMod(BASE_ATTACK,RatingChange,apply);
            ApplyAttackTimePercentMod(OFF_ATTACK,RatingChange,apply);
            break;
        case CR_HASTE_RANGED:
            RatingChange = value / RatingCoeffecient;
            ApplyAttackTimePercentMod(RANGED_ATTACK, RatingChange, apply);
            break;
        case CR_HASTE_SPELL:
            RatingChange = value / RatingCoeffecient;
            ApplyCastTimePercentMod(RatingChange,apply);
            break;
        case CR_WEAPON_SKILL_MAINHAND:                      // Implemented in Unit::RollMeleeOutcomeAgainst
        case CR_WEAPON_SKILL_OFFHAND:
        case CR_WEAPON_SKILL_RANGED:
            break;
        case CR_EXPERTISE:
            if (affectStats)
            {
                UpdateExpertise(BASE_ATTACK);
                UpdateExpertise(OFF_ATTACK);
            }
            break;
    }
}

void Player::SetRegularAttackTime()
{
    for (int i = 0; i < MAX_ATTACK; ++i)
    {
        Item *tmpitem = GetWeaponForAttack(WeaponAttackType(i));
        if (tmpitem && !tmpitem->IsBroken())
        {
            ItemPrototype const *proto = tmpitem->GetProto();
            if (proto->Delay)
                SetAttackTime(WeaponAttackType(i), proto->Delay);
            else
                SetAttackTime(WeaponAttackType(i), BASE_ATTACK_TIME);
        }
    }
}

//skill+step, checking for max value
bool Player::UpdateSkill(uint32 skill_id, uint32 step)
{
    if (!skill_id)
        return false;

    if (skill_id == SKILL_FIST_WEAPONS)
        skill_id = SKILL_UNARMED;

    uint16 i=0;
    for (; i < PLAYER_MAX_SKILLS; i++)
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == skill_id)
            break;

    if (i>=PLAYER_MAX_SKILLS)
        return false;

    uint32 data = GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i));
    uint32 value = SKILL_VALUE(data);
    uint32 max = SKILL_MAX(data);

    if ((!max) || (!value) || (value >= max))
        return false;

    //if (value*512 < max*urand(0,512))
    {
        uint32 new_value = value+step;
        if (new_value > max)
            new_value = max;

        SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i),MAKE_SKILL_VALUE(new_value,max));
        return true;
    }

    return false;
}

inline int SkillGainChance(uint32 SkillValue, uint32 GrayLevel, uint32 GreenLevel, uint32 YellowLevel)
{
    if (SkillValue >= GrayLevel)
        return sWorld.getConfig(CONFIG_SKILL_CHANCE_GREY)*10;
    if (SkillValue >= GreenLevel)
        return sWorld.getConfig(CONFIG_SKILL_CHANCE_GREEN)*10;
    if (SkillValue >= YellowLevel)
        return sWorld.getConfig(CONFIG_SKILL_CHANCE_YELLOW)*10;
    return sWorld.getConfig(CONFIG_SKILL_CHANCE_ORANGE)*10;
}

bool Player::UpdateCraftSkill(uint32 spellid)
{
    sLog.outDebug("UpdateCraftSkill spellid %d", spellid);

    SkillLineAbilityMap::const_iterator lower = sSpellMgr.GetBeginSkillLineAbilityMap(spellid);
    SkillLineAbilityMap::const_iterator upper = sSpellMgr.GetEndSkillLineAbilityMap(spellid);

    for (SkillLineAbilityMap::const_iterator _spell_idx = lower; _spell_idx != upper; ++_spell_idx)
    {
        if (_spell_idx->second->skillId)
        {
            uint32 SkillValue = GetPureSkillValue(_spell_idx->second->skillId);

            // Alchemy Discoveries here
            SpellEntry const* spellEntry = sSpellStore.LookupEntry(spellid);
            if (spellEntry && spellEntry->Mechanic==MECHANIC_DISCOVERY)
            {
                if (uint32 discoveredSpell = GetSkillDiscoverySpell(_spell_idx->second->skillId, spellid, this))
                    learnSpell(discoveredSpell);
            }

            uint32 craft_skill_gain = sWorld.getConfig(CONFIG_SKILL_GAIN_CRAFTING);

            return UpdateSkillPro(_spell_idx->second->skillId, SkillGainChance(SkillValue,
                _spell_idx->second->max_value,
                (_spell_idx->second->max_value + _spell_idx->second->min_value)/2,
                _spell_idx->second->min_value),
                craft_skill_gain);
        }
    }
    return false;
}

bool Player::UpdateGatherSkill(uint32 SkillId, uint32 SkillValue, uint32 RedLevel, uint32 Multiplicator)
{
    sLog.outDebug("UpdateGatherSkill(SkillId %d SkillLevel %d RedLevel %d)", SkillId, SkillValue, RedLevel);

    uint32 gathering_skill_gain = sWorld.getConfig(CONFIG_SKILL_GAIN_GATHERING);

    // For skinning and Mining chance decrease with level. 1-74 - no decrease, 75-149 - 2 times, 225-299 - 8 times
    switch (SkillId)
    {
        case SKILL_HERBALISM:
        case SKILL_LOCKPICKING:
        case SKILL_JEWELCRAFTING:
            return UpdateSkillPro(SkillId, SkillGainChance(SkillValue, RedLevel+100, RedLevel+50, RedLevel+25)*Multiplicator,gathering_skill_gain);
        case SKILL_SKINNING:
            if (sWorld.getConfig(CONFIG_SKILL_CHANCE_SKINNING_STEPS)==0)
                return UpdateSkillPro(SkillId, SkillGainChance(SkillValue, RedLevel+100, RedLevel+50, RedLevel+25)*Multiplicator,gathering_skill_gain);
            else
                return UpdateSkillPro(SkillId, (SkillGainChance(SkillValue, RedLevel+100, RedLevel+50, RedLevel+25)*Multiplicator) >> (SkillValue/sWorld.getConfig(CONFIG_SKILL_CHANCE_SKINNING_STEPS)), gathering_skill_gain);
        case SKILL_MINING:
            if (sWorld.getConfig(CONFIG_SKILL_CHANCE_MINING_STEPS)==0)
                return UpdateSkillPro(SkillId, SkillGainChance(SkillValue, RedLevel+100, RedLevel+50, RedLevel+25)*Multiplicator,gathering_skill_gain);
            else
                return UpdateSkillPro(SkillId, (SkillGainChance(SkillValue, RedLevel+100, RedLevel+50, RedLevel+25)*Multiplicator) >> (SkillValue/sWorld.getConfig(CONFIG_SKILL_CHANCE_MINING_STEPS)),gathering_skill_gain);
    }
    return false;
}

bool Player::UpdateFishingSkill()
{
    sLog.outDebug("UpdateFishingSkill");

    uint32 SkillValue = GetPureSkillValue(SKILL_FISHING);

    int32 chance = SkillValue < 75 ? 100 : 2500/(SkillValue-50);

    uint32 gathering_skill_gain = sWorld.getConfig(CONFIG_SKILL_GAIN_GATHERING);

    return UpdateSkillPro(SKILL_FISHING,chance*10,gathering_skill_gain);
}

bool Player::UpdateSkillPro(uint16 SkillId, int32 Chance, uint32 step)
{
    sLog.outDebug("UpdateSkillPro(SkillId %d, Chance %3.1f%%)", SkillId, Chance/10.0);
    if (!SkillId)
        return false;

    if (Chance <= 0)                                         // speedup in 0 chance case
    {
        sLog.outDebug("Player::UpdateSkillPro Chance=%3.1f%% missed", Chance/10.0);
        return false;
    }

    uint16 i=0;
    for (; i < PLAYER_MAX_SKILLS; i++)
        if (SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_INDEX(i))) == SkillId) break;
    if (i >= PLAYER_MAX_SKILLS)
        return false;

    uint32 data = GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i));
    uint16 SkillValue = SKILL_VALUE(data);
    uint16 MaxValue   = SKILL_MAX(data);

    if (!MaxValue || !SkillValue || SkillValue >= MaxValue)
        return false;

    int32 Roll = irand(1,1000);

    if (Roll <= Chance)
    {
        uint32 new_value = SkillValue+step;
        if (new_value > MaxValue)
            new_value = MaxValue;

        SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i),MAKE_SKILL_VALUE(new_value,MaxValue));
        sLog.outDebug("Player::UpdateSkillPro Chance=%3.1f%% taken", Chance/10.0);
        return true;
    }

    sLog.outDebug("Player::UpdateSkillPro Chance=%3.1f%% missed", Chance/10.0);
    return false;
}

void Player::UpdateWeaponSkill(WeaponAttackType attType)
{
    // no skill gain in pvp
    Unit* pVictim = getVictim();
    if (pVictim && pVictim->isCharmedOwnedByPlayerOrPlayer())
        return;

    if (IsInFeralForm())
        return;                                             // always maximized SKILL_FERAL_COMBAT in fact

    uint32 weaponSkillGain = sWorld.getConfig(CONFIG_SKILL_GAIN_WEAPON);

    Item* pWeapon = GetWeaponForAttack(attType, true);
    if (pWeapon && pWeapon->GetProto()->SubClass != ITEM_SUBCLASS_WEAPON_FISHING_POLE)
        UpdateSkill(pWeapon->GetSkill(), weaponSkillGain);
    else if (!pWeapon && attType == BASE_ATTACK)
        UpdateSkill(SKILL_UNARMED, weaponSkillGain);

    UpdateAllCritPercentages();
}

void Player::UpdateCombatSkills(Unit* pVictim, WeaponAttackType attType, bool defence)
{
    uint32 plevel = getLevel();                             // if defense than pVictim == attacker
    uint32 greylevel = Looking4group::XP::GetGrayLevel(plevel);
    uint32 moblevel = pVictim->getLevelForTarget(this);
    if (moblevel < greylevel)
        return;

    if (moblevel > plevel + 5)
        moblevel = plevel + 5;

    uint32 lvldif = moblevel - greylevel;
    if (lvldif < 3)
        lvldif = 3;

    int32 skilldif = 5 * plevel - (defence ? GetBaseDefenseSkillValue() : GetBaseWeaponSkillValue(attType));

    // Max skill reached for level.
    // Can in some cases be less than 0: having max skill and then .level -1 as example.
    if (skilldif <= 0)
        return;

    float chance = float(3 * lvldif * skilldif) / plevel;
    if (!defence)
        chance *= 0.1f * GetStat(STAT_INTELLECT);

    chance = chance < 1.0f ? 1.0f : chance;                 // minimum chance to increase skill is 1%

    if (roll_chance_f(chance))
    {
        if (defence)
            UpdateDefense();
        else
            UpdateWeaponSkill(attType);
    }
    else
        return;
}

void Player::ModifySkillBonus(uint32 skillid,int32 val, bool talent)
{
    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == skillid)
    {
        uint32 bonus_val = GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i));
        int16 temp_bonus = SKILL_TEMP_BONUS(bonus_val);
        int16 perm_bonus = SKILL_PERM_BONUS(bonus_val);

        if (talent)                                          // permanent bonus stored in high part
            SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i),MAKE_SKILL_BONUS(temp_bonus,perm_bonus+val));
        else                                                // temporary/item bonus stored in low part
            SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i),MAKE_SKILL_BONUS(temp_bonus+val,perm_bonus));
        return;
    }
}

void Player::UpdateSkillsForLevel()
{
    uint16 maxconfskill = sWorld.GetConfigMaxSkillValue();
    uint32 maxSkill = GetMaxSkillValueForLevel();

    bool alwaysMaxSkill = sWorld.getConfig(CONFIG_ALWAYS_MAX_SKILL_FOR_LEVEL);

    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
        if (GetUInt32Value(PLAYER_SKILL_INDEX(i)))
    {
        uint32 pskill = GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF;

        SkillLineEntry const *pSkill = sSkillLineStore.LookupEntry(pskill);
        if (!pSkill)
            continue;

        if (GetSkillRangeType(pSkill,false) != SKILL_RANGE_LEVEL)
            continue;

        uint32 data = GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i));
        uint32 max = SKILL_MAX(data);
        uint32 val = SKILL_VALUE(data);

        /// update only level dependent max skill values
        if (max!=1)
        {
            /// miximize skill always
            if (alwaysMaxSkill)
                SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i),MAKE_SKILL_VALUE(maxSkill,maxSkill));
            /// update max skill value if current max skill not maximized
            else if (max != maxconfskill)
                SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i),MAKE_SKILL_VALUE(val,maxSkill));
        }
    }
}

void Player::UpdateSkillsToMaxSkillsForLevel(bool lockpickInclude)
{
    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
        if (GetUInt32Value(PLAYER_SKILL_INDEX(i)))
    {
        uint32 pskill = GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF;
        if (SpellMgr::IsProfessionSkill(pskill) || pskill == SKILL_RIDING || (pskill == SKILL_LOCKPICKING && lockpickInclude))
            continue;
        uint32 data = GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i));

        uint32 max = SKILL_MAX(data);

        if (max > 1)
            SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i),MAKE_SKILL_VALUE(max,max));

        if (pskill == SKILL_DEFENSE)
            UpdateDefenseBonusesMod();
    }
}

// This functions sets a skill line value (and adds if doesn't exist yet)
// To "remove" a skill line, set it's values to zero
void Player::SetSkill(uint32 id, uint16 currVal, uint16 maxVal)
{
    if (!id)
        return;

    uint16 i=0;
    for (; i < PLAYER_MAX_SKILLS; i++)
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == id) break;

    if (i<PLAYER_MAX_SKILLS)                                 //has skill
    {
        if (currVal)
            SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i),MAKE_SKILL_VALUE(currVal,maxVal));
        else                                                //remove
        {
            // clear skill fields
            SetUInt32Value(PLAYER_SKILL_INDEX(i),0);
            SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i),0);
            SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i),0);

            // remove spells that depend on this skill when removing the skill
            for (PlayerSpellMap::const_iterator itr = m_spells.begin(), next = m_spells.begin(); itr != m_spells.end(); itr = next)
            {
                ++next;
                if (itr->second.state == PLAYERSPELL_REMOVED)
                    continue;

                SkillLineAbilityMap::const_iterator lower = sSpellMgr.GetBeginSkillLineAbilityMap(itr->first);
                SkillLineAbilityMap::const_iterator upper = sSpellMgr.GetEndSkillLineAbilityMap(itr->first);

                for (SkillLineAbilityMap::const_iterator _spell_idx = lower; _spell_idx != upper; ++_spell_idx)
                {
                    if (_spell_idx->second->skillId == id)
                    {
                        // this may remove more than one spell (dependents)
                        removeSpell(itr->first);
                        next = m_spells.begin();
                        break;
                    }
                }
            }
        }
    }
    else if (currVal)                                        //add
    {
        for (i=0; i < PLAYER_MAX_SKILLS; i++)
            if (!GetUInt32Value(PLAYER_SKILL_INDEX(i)))
        {
            SkillLineEntry const *pSkill = sSkillLineStore.LookupEntry(id);
            if (!pSkill)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Skill not found in SkillLineStore: skill #%u", id);
                return;
            }
            // enable unlearn button for primary professions only
            if (pSkill->categoryId == SKILL_CATEGORY_PROFESSION)
                SetUInt32Value(PLAYER_SKILL_INDEX(i), MAKE_PAIR32(id,1));
            else
                SetUInt32Value(PLAYER_SKILL_INDEX(i), MAKE_PAIR32(id,0));
            SetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i),MAKE_SKILL_VALUE(currVal,maxVal));

            // apply skill bonuses
            SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i),0);

            // temporary bonuses
            AuraList const& mModSkill = GetAurasByType(SPELL_AURA_MOD_SKILL);
            for (AuraList::const_iterator j = mModSkill.begin(); j != mModSkill.end(); ++j)
                if ((*j)->GetModifier()->m_miscvalue == int32(id))
                    (*j)->ApplyModifier(true);

            // permanent bonuses
            AuraList const& mModSkillTalent = GetAurasByType(SPELL_AURA_MOD_SKILL_TALENT);
            for (AuraList::const_iterator j = mModSkillTalent.begin(); j != mModSkillTalent.end(); ++j)
                if ((*j)->GetModifier()->m_miscvalue == int32(id))
                    (*j)->ApplyModifier(true);

            // Learn all spells for skill
            learnSkillRewardedSpells(id);
            return;
        }
    }
}

bool Player::HasSkill(uint32 skill) const
{
    if (!skill)return false;
    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
    {
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == skill)
        {
            return true;
        }
    }
    return false;
}

uint16 Player::GetSkillValue(uint32 skill) const
{
    if (!skill)
        return 0;

    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
    {
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == skill)
        {
            uint32 bonus = GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i));

            int32 result = int32(SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i))));
            result += SKILL_TEMP_BONUS(bonus);
            result += SKILL_PERM_BONUS(bonus);
            return result < 0 ? 0 : result;
        }
    }
    return 0;
}

uint16 Player::GetMaxSkillValue(uint32 skill) const
{
    if (!skill)return 0;
    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
    {
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == skill)
        {
            uint32 bonus = GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i));

            int32 result = int32(SKILL_MAX(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i))));
            result += SKILL_TEMP_BONUS(bonus);
            result += SKILL_PERM_BONUS(bonus);
            return result < 0 ? 0 : result;
        }
    }
    return 0;
}

uint16 Player::GetPureMaxSkillValue(uint32 skill) const
{
    if (!skill)return 0;
    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
    {
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == skill)
        {
            return SKILL_MAX(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i)));
        }
    }
    return 0;
}

uint16 Player::GetBaseSkillValue(uint32 skill) const
{
    if (!skill)return 0;
    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
    {
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == skill)
        {
            int32 result = int32(SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i))));
            result +=  SKILL_PERM_BONUS(GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i)));
            return result < 0 ? 0 : result;
        }
    }
    return 0;
}

uint16 Player::GetPureSkillValue(uint32 skill) const
{
    if (!skill)return 0;
    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
    {
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == skill)
        {
            return SKILL_VALUE(GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(i)));
        }
    }
    return 0;
}

int16 Player::GetSkillTempBonusValue(uint32 skill) const
{
    if (!skill)
        return 0;

    for (int i = 0; i < PLAYER_MAX_SKILLS; i++)
    {
        if ((GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF) == skill)
        {
            return SKILL_TEMP_BONUS(GetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i)));
        }
    }

    return 0;
}

void Player::SendInitialActionButtons()
{
    sLog.outDetail("Initializing Action Buttons for '%u'", GetGUIDLow());

    WorldPacket data(SMSG_ACTION_BUTTONS, (MAX_ACTION_BUTTONS*4));
    for (int button = 0; button < MAX_ACTION_BUTTONS; ++button)
    {
        ActionButtonList::const_iterator itr = m_actionButtons.find(button);
        if (itr != m_actionButtons.end() && itr->second.uState != ACTIONBUTTON_DELETED)
        {
            data << uint16(itr->second.action);
            data << uint8(itr->second.misc);
            data << uint8(itr->second.type);
        }
        else
        {
            data << uint32(0);
        }
    }

    SendPacketToSelf(&data);
    sLog.outDetail("Action Buttons for '%u' Initialized", GetGUIDLow());
}

void Player::addActionButton(const uint8 button, const uint16 action, const uint8 type, const uint8 misc)
{
    if (button >= MAX_ACTION_BUTTONS)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Action %u not added into button %u for player %s: button must be < 132", action, button, GetName());
        return;
    }

    // check cheating with adding non-known spells to action bar
    if (type==ACTION_BUTTON_SPELL)
    {
        if (!sSpellStore.LookupEntry(action))
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Action %u not added into button %u for player %s: spell not exist", action, button, GetName());
            return;
        }

        if (!HasSpell(action))
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Action %u not added into button %u for player %s: player don't known this spell", action, button, GetName());
            return;
        }
    }

    ActionButtonList::iterator buttonItr = m_actionButtons.find(button);

    if (buttonItr==m_actionButtons.end())
    {                                                       // just add new button
        m_actionButtons[button] = ActionButton(action,type,misc);
    }
    else
    {                                                       // change state of current button
        ActionButtonUpdateState uState = buttonItr->second.uState;
        buttonItr->second = ActionButton(action,type,misc);
        if (uState != ACTIONBUTTON_NEW) buttonItr->second.uState = ACTIONBUTTON_CHANGED;
    };

    sLog.outDetail("Player '%u' Added Action '%u' to Button '%u'", GetGUIDLow(), action, button);
}

void Player::removeActionButton(uint8 button)
{
    ActionButtonList::iterator buttonItr = m_actionButtons.find(button);
    if (buttonItr==m_actionButtons.end())
        return;

    if (buttonItr->second.uState==ACTIONBUTTON_NEW)
        m_actionButtons.erase(buttonItr);                   // new and not saved
    else
        buttonItr->second.uState = ACTIONBUTTON_DELETED;    // saved, will deleted at next save

    sLog.outDetail("Action Button '%u' Removed from Player '%u'", button, GetGUIDLow());
}

bool Player::SetPosition(float x, float y, float z, float orientation, bool teleport)
{
    bool groupUpdate = (GetGroup() && (teleport || abs(GetPositionX() - x) > 1.0f || abs(GetPositionY() - y) > 1.0f));
    if (!Unit::SetPosition(x, y, z, orientation, teleport))
        return false;

    if(GetTrader() && !IsWithinDistInMap(GetTrader(), 5.0f))
        GetSession()->SendCancelTrade();

    if (!positionStatus.Passed())
        return true;

    positionStatus.Reset(100);

    // code block for underwater state update
    // Unit::SetPosition() checks for validity and updates our coordinates
    // so we re-fetch them instead of using "raw" coordinates from function params
    UpdateUnderwaterState(GetMap(), GetPositionX(), GetPositionY(), GetPositionZ());

    // group update
    if (groupUpdate)
        SetGroupUpdateFlag(GROUP_UPDATE_FLAG_POSITION);

    CheckAreaExploreAndOutdoor();
    return true;
}

void Player::SaveRecallPosition(TaxiNodesEntry const* taxinode)
{
    if (taxinode)
    {
        _recallPosition.mapid = taxinode->map_id;
        _recallPosition.coord_x = taxinode->x;
        _recallPosition.coord_y = taxinode->y;
        _recallPosition.coord_z = taxinode->z;

    }
    else
        GetPosition(_recallPosition);
}

void Player::SendPacketToSelf(WorldPacket *data)
{
    GetSession()->SendPacket(data);
}

void Player::SendCinematicStart(uint32 CinematicSequenceId)
{
    WorldPacket data(SMSG_TRIGGER_CINEMATIC, 4);
    data << uint32(CinematicSequenceId);
    SendPacketToSelf(&data);

    setWatchingCinematic(CinematicSequenceId);
    GetCamera().UpdateVisibilityForOwner();
}

void Player::CheckAreaExploreAndOutdoor()
{
    if (!isAlive())
        return;

    if (IsTaxiFlying())
        return;

    bool isOutdoor;
    uint16 areaFlag = GetTerrain()->GetAreaFlag(GetPositionX(),GetPositionY(),GetPositionZ(), &isOutdoor);

    if ((m_outdoors != isOutdoor) && !isGameMaster())
    {
        UpdateSpeed(MOVE_RUN, true);
        UpdateSpeed(MOVE_SWIM, true);
        UpdateSpeed(MOVE_FLIGHT, true);

        m_outdoors = isOutdoor;
    }

    if (!isOutdoor && sWorld.getConfig(CONFIG_VMAP_INDOOR_CHECK) && !isGameMaster())
        RemoveAurasWithAttribute(SPELL_ATTR_OUTDOORS_ONLY, true);

    if (areaFlag==0xffff)
        return;

    int offset = areaFlag / 32;

    if (offset >= 128)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Wrong area flag %u in map data for (X: %f Y: %f) point to field PLAYER_EXPLORED_ZONES_1 + %u (%u must be < 64).",areaFlag,GetPositionX(),GetPositionY(),offset,offset);
        return;
    }

    uint32 val = (uint32)(1 << (areaFlag % 32));
    uint32 currFields = GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset);

    if (!(currFields & val))
    {
        SetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset, (uint32)(currFields | val));

        AreaTableEntry const *p = GetAreaEntryByAreaFlagAndMap(areaFlag,GetMapId());
        if (!p)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: PLAYER: Player %u discovered unknown area (x: %f y: %f map: %u", GetGUIDLow(), GetPositionX(),GetPositionY(),GetMapId());
        }
        else if (p->area_level > 0)
        {
            uint32 area = p->ID;
            if (getLevel() >= sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
            {
                SendExplorationExperience(area,0);
            }
            else
            {
                int32 diff = int32(getLevel()) - p->area_level;
                uint32 XP = 0;
                if (diff < -5)
                {
                    XP = uint32(sObjectMgr.GetBaseXP(getLevel()+5)*GetXPRate(RATE_XP_EXPLORE));
                }
                else if (diff > 5)
                {
                    int32 exploration_percent = (100-((diff-5)*5));
                    if (exploration_percent > 100)
                        exploration_percent = 100;
                    else if (exploration_percent < 0)
                        exploration_percent = 0;

                    XP = uint32(sObjectMgr.GetBaseXP(p->area_level)*exploration_percent/100*GetXPRate(RATE_XP_EXPLORE));
                }
                else
                {
                    XP = uint32(sObjectMgr.GetBaseXP(p->area_level)*GetXPRate(RATE_XP_EXPLORE));
                }

                if (!StopLevel(GetGUID()))
                    GiveXP(XP, NULL);
                SendExplorationExperience(area,XP);
            }
            sLog.outDetail("PLAYER: Player %u discovered a new area: %u", GetGUIDLow(), area);
        }
    }
}

uint32 Player::TeamForRace(uint8 race)
{
    ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(race);
    if (!rEntry)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Race %u not found in DBC: wrong DBC files?",uint32(race));
        return ALLIANCE;
    }

    switch (rEntry->TeamID)
    {
        case 7: return ALLIANCE;
        case 1: return HORDE;
    }

    sLog.outLog(LOG_DEFAULT, "ERROR: Race %u have wrong team id in DBC: wrong DBC files?",uint32(race),rEntry->TeamID);
    return ALLIANCE;
}

uint32 Player::getFactionForRace(uint8 race)
{
    ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(race);
    if (!rEntry)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Race %u not found in DBC: wrong DBC files?",uint32(race));
        return 0;
    }

    return rEntry->FactionID;
}

void Player::setFactionForRace(uint8 race)
{
    m_team = TeamForRace(race);
    setFaction(getFactionForRace(race));
}

ReputationRank Player::GetReputationRank(uint32 faction) const
{
    FactionEntry const* factionEntry = sFactionStore.LookupEntry(faction);
    return GetReputationMgr().GetRank(factionEntry);
}

//Calculate total reputation percent player gain with quest/creature level
int32 Player::CalculateReputationGain(ReputationSource source, int32 rep, int32 faction, uint32 creatureOrQuestLevel, bool noAuraBonus)
{
    float percent = 100.0f;

    float repMod = noAuraBonus ? 0.0f : (float)GetTotalAuraModifier(SPELL_AURA_MOD_REPUTATION_GAIN);

    // faction specific auras only seem to apply to kills
    if (source == REPUTATION_SOURCE_KILL)
        repMod += GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_FACTION_REPUTATION_GAIN, faction);

    percent += rep > 0 ? repMod : -repMod;

    float rate = 1.0f;
    switch (source)
    {
        case REPUTATION_SOURCE_KILL:
            rate = sWorld.getRate(RATE_REPUTATION_LOWLEVEL_KILL);
            break;
        case REPUTATION_SOURCE_QUEST:
            rate = sWorld.getRate(RATE_REPUTATION_LOWLEVEL_QUEST);
            break;
    }

    if (rate != 1.0f && creatureOrQuestLevel <= Looking4group::XP::GetGrayLevel(getLevel()))
        percent *= rate;

    if (percent <= 0.0f)
        return 0;

    // Multiply result with the faction specific rate
    if (const RepRewardRate *repData = sObjectMgr.GetRepRewardRate(faction))
    {
        float repRate = 0.0f;
        switch (source)
        {
            case REPUTATION_SOURCE_KILL:
                repRate = repData->creature_rate;
                break;
            case REPUTATION_SOURCE_QUEST:
                repRate = repData->quest_rate;
                break;
            case REPUTATION_SOURCE_SPELL:
                repRate = repData->spell_rate;
                break;
            default:
                repRate = 1.0;
                break;
        }

        // for custom, a rate of 0.0 will totally disable reputation gain for this faction/type
        if (repRate <= 0.0f)
            return 0;

        percent *= repRate;
    }

    return int32(0.01f + sWorld.getRate(RATE_REPUTATION_GAIN)*rep*percent/100.0f);
}

//Calculates how many reputation points player gains in victim's enemy factions
void Player::RewardReputation(Unit *pVictim, float rate)
{
    if (!pVictim || pVictim->GetTypeId() == TYPEID_PLAYER)
        return;

    if (((Creature*)pVictim)->IsReputationGainDisabled())
        return;

    ReputationOnKillEntry const* Rep = sObjectMgr.GetReputationOnKillEntry(((Creature*)pVictim)->GetCreatureInfo()->Entry);

    if (!Rep)
        return;

    // Favored reputation increase START
     uint32 zone = GetZoneId();
     uint32 team = GetTeam();
    float favored_rep_mult = 0;

    if( (HasAura(32096) || HasAura(32098)) && (zone == 3483 || zone == 3562 || zone == 3836 || zone == 3713 || zone == 3714) ) 
        favored_rep_mult = 0.25; // Thrallmar's Favor and Honor Hold's Favor
    else if( HasAura(30754) && (Rep->repfaction1 == 609 || Rep->repfaction2 == 609) )                   
        favored_rep_mult = 0.25; // Cenarion Favor

    if(favored_rep_mult > 0) favored_rep_mult *= 2; // Multiplied by 2 because the reputation is divided by 2 for some reason (See "donerep1 / 2" and "donerep2 / 2") -- if you know why this is done, please update/explain :)
    // Favored reputation increase END


    if (Rep->repfaction1 && (!Rep->team_dependent || GetTeam()==ALLIANCE))
    {
        int32 donerep1 = CalculateReputationGain(REPUTATION_SOURCE_KILL, Rep->repvalue1, Rep->repfaction1, pVictim->getLevel());
        donerep1 = int32(donerep1*(rate + favored_rep_mult));
        FactionEntry const *factionEntry1 = sFactionStore.LookupEntry(Rep->repfaction1);
        uint32 current_reputation_rank1 = GetReputationMgr().GetRank(factionEntry1);
        if (factionEntry1 && current_reputation_rank1 <= Rep->reputation_max_cap1)
            GetReputationMgr().ModifyReputation(factionEntry1, donerep1);

        // Wiki: Team factions value divided by 2
        if (factionEntry1 && Rep->is_teamaward1)
        {
            FactionEntry const *team1_factionEntry = sFactionStore.LookupEntry(factionEntry1->team);
            if (team1_factionEntry)
                GetReputationMgr().ModifyReputation(factionEntry1, donerep1 / 2);
        }
    }

    if (Rep->repfaction2 && (!Rep->team_dependent || GetTeam() == HORDE))
    {
        int32 donerep2 = CalculateReputationGain(REPUTATION_SOURCE_KILL, Rep->repvalue2, Rep->repfaction2, pVictim->getLevel());
        donerep2 = int32(donerep2*(rate + favored_rep_mult));
        FactionEntry const *factionEntry2 = sFactionStore.LookupEntry(Rep->repfaction2);
        uint32 current_reputation_rank2 = GetReputationMgr().GetRank(factionEntry2);
        if (factionEntry2 && current_reputation_rank2 <= Rep->reputation_max_cap2)
            GetReputationMgr().ModifyReputation(factionEntry2, donerep2);

        // Wiki: Team factions value divided by 2
        if (factionEntry2 && Rep->is_teamaward2)
        {
            FactionEntry const *team2_factionEntry = sFactionStore.LookupEntry(factionEntry2->team);
            if (team2_factionEntry)
                GetReputationMgr().ModifyReputation(team2_factionEntry, donerep2 / 2);
        }
    }
}

//Calculate how many reputation points player gain with the quest
void Player::RewardReputation(Quest const *pQuest)
{
    // quest reputation reward/loss
    for (int i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
    {
        if (!pQuest->RewRepFaction[i])
            continue;

        if (pQuest->RewRepValue[i])
        {
            int32 rep = CalculateReputationGain(REPUTATION_SOURCE_QUEST, pQuest->RewRepValue[i], pQuest->RewRepFaction[i], GetQuestOrPlayerLevel(pQuest));
            if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(pQuest->RewRepFaction[i]))
                GetReputationMgr().ModifyReputation(factionEntry, rep);
        }
    }

    // TODO: implement reputation spillover
}

void Player::UpdateArenaFields(void)
{
    /* arena calcs go here */
}

void Player::UpdatePvpTitles()
{
    uint32 kills = GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS);
    uint64 titles = GetUInt64Value(PLAYER__FIELD_KNOWN_TITLES);
    uint64 pvp_title = titles & PLAYER_TITLE_PVP;

    uint32 offset = GetTeam() == HORDE ? MAX_PVP_RANKS : 0;

    uint32 index = 0;
    bool search = pvp_title;
    for (uint32 i = 1 + offset; i <= MAX_PVP_RANKS + offset; ++i)
    {
        if (search)
        {
            if (pvp_title & uint64(1) << i)
            {
                index = i;
                search = false;
            }
        }
        else
        {
            if (kills >= sWorld.m_honorRanks[i-offset-1])
                index = i;
        }
    }

    uint64 new_title = uint64(1) << index;
    if (pvp_title != new_title)
    {
        SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES, (titles & ~PLAYER_TITLE_PVP) | new_title);
        SetUInt32Value(PLAYER_CHOSEN_TITLE, index);
    }
}

void Player::UpdateBgTitle()
{
    uint64 titles = GetUInt64Value(PLAYER__FIELD_KNOWN_TITLES);

    uint32 index = GetUInt32Value(PLAYER_CHOSEN_TITLE); //shouldn't we use that ? i don't know, but we can try it

    if (m_team == HORDE && (~titles & PLAYER_TITLE_CONQUEROR) && m_reputationMgr.GetRank(729) == REP_EXALTED && m_reputationMgr.GetRank(510) == REP_EXALTED && m_reputationMgr.GetRank(889) == REP_EXALTED)
    {
        SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES, titles | PLAYER_TITLE_CONQUEROR);
        SetUInt32Value(PLAYER_CHOSEN_TITLE, index);
    }
    else if (m_team == ALLIANCE && (~titles & PLAYER_TITLE_JUSTICAR) && m_reputationMgr.GetRank(730) == REP_EXALTED && m_reputationMgr.GetRank(509) == REP_EXALTED && m_reputationMgr.GetRank(890) == REP_EXALTED)
    {
        SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES, titles | PLAYER_TITLE_JUSTICAR);
        SetUInt32Value(PLAYER_CHOSEN_TITLE, index);
    }
}

void Player::UpdateHonorFields()
{
    /// called when rewarding honor and at each save
    uint64 now = time(NULL);
    uint64 today = uint64(time(NULL) / DAY) * DAY;

    if (m_lastHonorUpdateTime < today)
    {
        uint64 yesterday = today - DAY;

        uint16 kills_today = PAIR32_LOPART(GetUInt32Value(PLAYER_FIELD_KILLS));

        // update yesterday's contribution
        if (m_lastHonorUpdateTime >= yesterday)
        {
            SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, GetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION));

            // this is the first update today, reset today's contribution
            SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, 0);
            SetUInt32Value(PLAYER_FIELD_KILLS, MAKE_PAIR32(0,kills_today));
        }
        else
        {
            // no honor/kills yesterday or today, reset
            SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, 0);
            SetUInt32Value(PLAYER_FIELD_KILLS, 0);
        }
    }

    m_lastHonorUpdateTime = now;
}

///Calculate the amount of honor gained based on the victim
///and the size of the group for which the honor is divided
///An exact honor value can also be given (overriding the calcs)
bool Player::RewardHonor(Unit *uVictim, uint32 groupsize, float honor, bool pvptoken, bool killer)
{
    // do not reward honor in arenas, but enable onkill spellproc
    if (InArena())
    {
        if (!uVictim || uVictim == this || uVictim->GetTypeId() != TYPEID_PLAYER)
            return false;

        if (GetBGTeam() == ((Player*)uVictim)->GetBGTeam())
            return false;

        return true;
    }

    // 'Inactive' this aura prevents the player from gaining honor points and battleground tokens
    if (GetDummyAura(SPELL_AURA_PLAYER_INACTIVE))
        return false;

    uint64 victim_guid = 0;
    uint32 victim_rank = 0;
    time_t now = time(NULL);

    // need call before fields update to have chance move yesterday data to appropriate fields before today data change.
    UpdateHonorFields();

    // do not reward honor in arenas, but return true to enable onkill spellproc
    if (InBattleGround() && GetBattleGround() && GetBattleGround()->isArena())
        return true;

    if (honor <= 0)
    {
        if (!uVictim || uVictim == this || uVictim->HasAuraType(SPELL_AURA_NO_PVP_CREDIT) || uVictim->WorthHonor || uVictim->HasAura(SPELL_ID_PASSIVE_RESURRECTION_SICKNESS))
            return false;

        victim_guid = uVictim->GetGUID();

        if (uVictim->GetTypeId() == TYPEID_PLAYER)
        {
            Player *pVictim = (Player *)uVictim;

            if ((GetTeam() == pVictim->GetTeam() && GetBGTeam() == pVictim->GetBGTeam()) && !sWorld.IsFFAPvPRealm())
                return false;

            float f = 1;                                    //need for total kills (?? need more info)
            uint32 k_grey = 0;
            uint32 k_level = getLevel();
            uint32 v_level = pVictim->getLevel();

            {
                // PLAYER_CHOSEN_TITLE VALUES DESCRIPTION
                //  [0]      Just name
                //  [1..14]  Alliance honor titles and player name
                //  [15..28] Horde honor titles and player name
                //  [29..38] Other title and player name
                //  [39+]    Nothing
                uint32 victim_title = pVictim->GetUInt64Value(PLAYER__FIELD_KNOWN_TITLES) & PLAYER_TITLE_PVP;//pVictim->GetUInt32Value(PLAYER_CHOSEN_TITLE);

                // Ranks:
                //  title[1..14]  -> rank[5..18]
                //  title[15..28] -> rank[5..18]
                //  title[other]  -> 0
                if (!killer || victim_title == 0)
                    victim_guid = 0;                        // Don't show HK: <rank> message, only log.
                else
                {
                    uint32 offset = pVictim->GetTeam() == HORDE ? MAX_PVP_RANKS : 0;
                    for (uint32 i = 1 + offset; i <= MAX_PVP_RANKS + offset; ++i)
                    {
                        if (victim_title & (uint64(1) << i))
                        {
                            victim_rank = i - offset + 4;
                            break;
                        }
                    }
                }
            }

            if (k_level <= 5)
                k_grey = 0;
            else if (k_level <= 39)
                k_grey = k_level - 5 - k_level/10;
            else
                k_grey = k_level - 1 - k_level/5;

            if (v_level<=k_grey)
                return false;

            float diff_level = (k_level == k_grey) ? 1 : ((float(v_level) - float(k_grey)) / (float(k_level) - float(k_grey)));

            int32 v_rank =1;                                //need more info

            honor = ((f * diff_level * (190 + v_rank*10))/6);
            honor *= ((float)k_level) / 70.0f;              //factor of dependence on levels of the killer

            // count the number of playerkills in one day
            ApplyModUInt32Value(PLAYER_FIELD_KILLS, 1, true);
            // and those in a lifetime
            ApplyModUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 1, true);
        }
        else
        {
            Creature *cVictim = (Creature *)uVictim;

            if (!cVictim->isRacialLeader())
                return false;

            honor = 100;                                    // ??? need more info
            victim_rank = 19;                               // HK: Leader
        }
    }

    if (uVictim != NULL)
    {
        honor *= sWorld.getRate(RATE_HONOR);

        if (groupsize > 1)
            honor /= groupsize;

        honor *= (((float)urand(8,12))/10);                 // approx honor: 80% - 120% of real honor
    }

    // honor - for show honor points in log
    // victim_guid - for show victim name in log
    // victim_rank [1..4]  HK: <dishonored rank>
    // victim_rank [5..19] HK: <alliance\horde rank>
    // victim_rank [0,20+] HK: <>
    WorldPacket data(SMSG_PVP_CREDIT,4+8+4);
    data << (uint32) honor;
    data << (uint64) victim_guid;
    data << (uint32) victim_rank;

    SendPacketToSelf(&data);

    // add honor points
    ModifyHonorPoints(int32(honor));
    UpdatePvpTitles();
    ApplyModUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, uint32(honor), true);

    if (sWorld.getConfig(CONFIG_PVP_TOKEN_ENABLE) && pvptoken)
    {
        if (!uVictim || uVictim == this || uVictim->HasAuraType(SPELL_AURA_NO_PVP_CREDIT) || uVictim->WorthHonor || uVictim->HasAura(SPELL_ID_PASSIVE_RESURRECTION_SICKNESS))
            return true;

        if (uVictim->GetTypeId() == TYPEID_PLAYER)
        {
            // Check if allowed to receive it in current map
            uint8 MapType = sWorld.getConfig(CONFIG_PVP_TOKEN_MAP_TYPE);
            if ((MapType == 1 && !InBattleGround() && !IsFFAPvP())
                || (MapType == 2 && !IsFFAPvP())
                || (MapType == 3 && !InBattleGround()))
                return true;

            uint32 noSpaceForCount = 0;
            uint32 itemId = sWorld.getConfig(CONFIG_PVP_TOKEN_ID);
            int32 count = sWorld.getConfig(CONFIG_PVP_TOKEN_COUNT);

            // check space and find places
            ItemPosCountVec dest;
            uint8 msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, count, &noSpaceForCount);
            if (msg != EQUIP_ERR_OK)   // convert to possible store amount
                count = noSpaceForCount;

            if (count == 0 || dest.empty()) // can't add any
            {
                // -- TODO: Send to mailbox if no space
                ChatHandler(this).PSendSysMessage("You don't have any space in your bags for a token.");
                return true;
            }

            Item* item = StoreNewItem(dest, itemId, true, Item::GenerateItemRandomPropertyId(itemId));
            SendNewItem(item,count,true,false);
            ChatHandler(this).PSendSysMessage("You have been awarded a token for slaying another player.");
        }
    }

    return true;
}

void Player::ModifyHonorPoints(int32 value)
{
    if (value < 0)
    {
        if (GetHonorPoints() > sWorld.getConfig(CONFIG_MAX_HONOR_POINTS))
            SetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY, sWorld.getConfig(CONFIG_MAX_HONOR_POINTS) + value);
        else
            SetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY, GetHonorPoints() > uint32(-value) ? GetHonorPoints() + value : 0);
    }
    else
        SetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY, GetHonorPoints() < sWorld.getConfig(CONFIG_MAX_HONOR_POINTS) - value ? GetHonorPoints() + value : sWorld.getConfig(CONFIG_MAX_HONOR_POINTS));
}

void Player::ModifyArenaPoints(int32 value)
{
    if (value < 0)
    {
        if (GetArenaPoints() > sWorld.getConfig(CONFIG_MAX_ARENA_POINTS))
            SetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY, sWorld.getConfig(CONFIG_MAX_ARENA_POINTS) + value);
        else
            SetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY, GetArenaPoints() > uint32(-value) ? GetArenaPoints() + value : 0);
    }
    else
        SetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY, GetArenaPoints() < sWorld.getConfig(CONFIG_MAX_ARENA_POINTS) - value ? GetArenaPoints() + value : sWorld.getConfig(CONFIG_MAX_ARENA_POINTS));
}

uint32 Player::GetGuildIdFromDB(uint64 guid)
{
    std::ostringstream ss;
    ss<<"SELECT guildid FROM guild_member WHERE guid='"<<guid<<"'";
    QueryResultAutoPtr result = RealmDataDatabase.Query(ss.str().c_str());
    if (result)
    {
        uint32 v = result->Fetch()[0].GetUInt32();
        return v;
    }
    else
        return 0;
}

uint32 Player::GetRankFromDB(uint64 guid)
{
    std::ostringstream ss;
    ss<<"SELECT rank FROM guild_member WHERE guid='"<<guid<<"'";
    QueryResultAutoPtr result = RealmDataDatabase.Query(ss.str().c_str());
    if (result)
    {
        uint32 v = result->Fetch()[0].GetUInt32();
        return v;
    }
    else
        return 0;
}

uint32 Player::GetArenaTeamIdFromDB(uint64 guid, uint8 type)
{
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT arena_team_member.arenateamid FROM arena_team_member JOIN arena_team ON arena_team_member.arenateamid = arena_team.arenateamid WHERE guid='%u' AND type='%u' LIMIT 1", GUID_LOPART(guid), type);
    if (!result)
        return 0;

    uint32 id = (*result)[0].GetUInt32();
    return id;
}

uint32 Player::GetZoneIdFromDB(uint64 guid)
{
    std::ostringstream ss;

    ss<<"SELECT zone FROM characters WHERE guid='"<<GUID_LOPART(guid)<<"'";
    QueryResultAutoPtr result = RealmDataDatabase.Query(ss.str().c_str());
    if (!result)
        return 0;
    Field* fields = result->Fetch();
    uint32 zone = fields[0].GetUInt32();

    if (!zone)
    {
        // stored zone is zero, use generic and slow zone detection
        ss.str("");
        ss<<"SELECT map,position_x,position_y,position_z FROM characters WHERE guid='"<<GUID_LOPART(guid)<<"'";
        result = RealmDataDatabase.Query(ss.str().c_str());
        if (!result)
            return 0;
        fields = result->Fetch();
        uint32 map  = fields[0].GetUInt32();
        float posx = fields[1].GetFloat();
        float posy = fields[2].GetFloat();

        float posz = fields[3].GetFloat();
        zone = sTerrainMgr.GetZoneId(map,posx,posy,posz);

        ss.str("");
        ss << "UPDATE characters SET zone='"<<zone<<"' WHERE guid='"<<GUID_LOPART(guid)<<"'";
        RealmDataDatabase.Execute(ss.str().c_str());
    }

    return zone;
}

uint32 Player::GetLevelFromDB(uint64 guid)

{
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT level FROM characters WHERE guid='%u'", GUID_LOPART(guid));
    if (!result)
        return 0;

    Field* fields = result->Fetch();
    uint32 level = fields[0].GetUInt32();
    return level;
}

void Player::UpdateArea(uint32 newArea)
{
    // FFA_PVP flags are area and not zone id dependent
    // so apply them accordingly
    m_areaUpdateId    = newArea;

    AreaTableEntry const* area = GetAreaEntryByAreaID(newArea);

    if (area && (area->flags & AREA_FLAG_ARENA))
    {
        if (!isGameMaster())
            SetFFAPvP(true);
    }
    else
    {
        // remove ffa flag only if not ffapvp realm
        // removal in sanctuaries and capitals is handled in zone update
        if (IsFFAPvP() && !sWorld.IsFFAPvPRealm())
            SetFFAPvP(false);
    }

    UpdateAreaDependentAuras(newArea);
}

class LocalChannelUpdate : public WorldEvent
{
    public:
        LocalChannelUpdate(Player* player, uint32 zone) : WorldEvent(player), _zone(zone) {}

        bool Execute()/* override*/
        {
            if (!_owner->IsInWorld())
                return false;

            _owner->UpdateLocalChannels(_zone);
            return true;
        }

    private:
        uint32 _zone;
};

void Player::UpdateZone(uint32 newZone)
{
    uint32 oldZoneId  = m_zoneUpdateId;
    m_zoneUpdateId    = newZone;
    m_zoneUpdateTimer = ZONE_UPDATE_INTERVAL;

    // zone changed, so area changed as well, update it
    UpdateArea(GetAreaId());

    AreaTableEntry const* zone = GetAreaEntryByAreaID(newZone);
    if (!zone)
        return;

    // inform outdoor pvp
    if (oldZoneId != m_zoneUpdateId)
    {
        sOutdoorPvPMgr.HandlePlayerLeaveZone(this, oldZoneId);
        sOutdoorPvPMgr.HandlePlayerEnterZone(this, m_zoneUpdateId);
    }

    if (sWorld.getConfig(CONFIG_WEATHER))
    {
        Weather *wth = sWorld.FindWeather(zone->ID);
        if (wth)
        {
            wth->SendWeatherUpdateToPlayer(this);
        }
        else
        {
            if (!sWorld.AddWeather(zone->ID))
            {
                // send fine weather packet to remove old zone's weather
                Weather::SendFineWeatherUpdateToPlayer(this);
            }
        }
    }

    pvpInfo.inHostileArea =
        GetTeam() == ALLIANCE && zone->team == AREATEAM_HORDE ||
        GetTeam() == HORDE    && zone->team == AREATEAM_ALLY  ||
        sWorld.IsPvPRealm()   && zone->team == AREATEAM_NONE  ||
        InBattleGround();                                   // overwrite for battlegrounds, maybe batter some zone flags but current known not 100% fit to this

    if (pvpInfo.inHostileArea)                               // in hostile area
    {
        if (!IsPvP() || pvpInfo.endTimer != 0)
            UpdatePvP(true, true);
    }
    else                                                    // in friendly area
    {
        if (IsPvP() && !HasFlag(PLAYER_FLAGS,PLAYER_FLAGS_IN_PVP) && pvpInfo.endTimer == 0)
            pvpInfo.endTimer = time(0);                     // start toggle-off
    }

    if (zone->flags & AREA_FLAG_SANCTUARY)                   // in sanctuary
    {
        SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_SANCTUARY);
        if (sWorld.IsFFAPvPRealm())
           SetFFAPvP(false);
    }
    else
    {
        RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_SANCTUARY);
    }

    if (zone->flags & AREA_FLAG_CAPITAL)                     // in capital city
    {
        SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING);
        SetRestType(REST_TYPE_IN_CITY);
        InnEnter(time(0),GetMapId(),0,0,0);

        if (sWorld.IsFFAPvPRealm())
            SetFFAPvP(false);
    }
    else                                                    // anywhere else
    {
        if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING))     // but resting (walk from city or maybe in tavern or leave tavern recently)
        {
            if (GetRestType()==REST_TYPE_IN_TAVERN)          // has been in tavern. Is still in?
            {
                if (GetMapId()!=GetInnPosMapId() || sqrt((GetPositionX()-GetInnPosX())*(GetPositionX()-GetInnPosX())+(GetPositionY()-GetInnPosY())*(GetPositionY()-GetInnPosY())+(GetPositionZ()-GetInnPosZ())*(GetPositionZ()-GetInnPosZ()))>40)
                {
                    RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING);
                    SetRestType(REST_TYPE_NO);

                    if (sWorld.IsFFAPvPRealm())
                        SetFFAPvP(true);
                }
            }
            else                                            // not in tavern (leave city then)
            {
                RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING);
                SetRestType(REST_TYPE_NO);

                // Set player to FFA PVP when not in rested environment.
                if (sWorld.IsFFAPvPRealm())
                    SetFFAPvP(true);
            }
        }
    }

    // remove items with area/map limitations (delete only for alive player to allow back in ghost mode)
    // if player resurrected at teleport this will be applied in resurrect code
    if (isAlive())
        DestroyZoneLimitedItem(true, newZone);

    // recent client version not send leave/join channel packets for built-in local channels
    sWorldEventProcessor.ScheduleEvent(this, new LocalChannelUpdate(this, newZone));

    // group update
    if (GetGroup())
        SetGroupUpdateFlag(GROUP_UPDATE_FLAG_ZONE);

    UpdateZoneDependentAuras(newZone);
}

//If players are too far way of duel flag... then player loose the duel
void Player::CheckDuelDistance(time_t currTime)
{
    if (!duel)
        return;

    uint64 duelFlagGUID = GetUInt64Value(PLAYER_DUEL_ARBITER);
    GameObject* obj = GetMap()->GetGameObject(duelFlagGUID);
    if (!obj)
        return;

    if (duel->outOfBound == 0)
    {
        if (!IsWithinDistInMap(obj, 75))
        {
            duel->outOfBound = currTime;

            WorldPacket data(SMSG_DUEL_OUTOFBOUNDS, 0);
            SendPacketToSelf(&data);
        }
    }
    else
    {
        if (IsWithinDistInMap(obj, 75))
        {
            duel->outOfBound = 0;

            WorldPacket data(SMSG_DUEL_INBOUNDS, 0);
            SendPacketToSelf(&data);
        }
        else if (currTime >= (duel->outOfBound+10))
        {
            CombatStopWithPets(true);
            if (duel->opponent)
                duel->opponent->CombatStopWithPets(true);
            DuelComplete(DUEL_FLED);
        }
    }
}

bool Player::IsOutdoorPvPActive()
{
    return (isAlive() && !HasInvisibilityAura() && !HasStealthAura() && (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP) || sWorld.IsPvPRealm())  && !HasUnitMovementFlag(MOVEFLAG_FLYING) && !IsTaxiFlying());
}

void Player::DuelComplete(DuelCompleteType type)
{
    // duel not requested
    if (!duel)
        return;

    WorldPacket data(SMSG_DUEL_COMPLETE, (1));
    data << (uint8)((type != DUEL_INTERUPTED) ? 1 : 0);
    SendPacketToSelf(&data);
    duel->opponent->SendPacketToSelf(&data);

    if (type != DUEL_INTERUPTED)
    {
        data.Initialize(SMSG_DUEL_WINNER, (1+20));          // we guess size
        data << (uint8)((type==DUEL_WON) ? 0 : 1);          // 0 = just won; 1 = fled
        data << duel->opponent->GetName();
        data << GetName();
        BroadcastPacket(&data,true);
        if (type == DUEL_WON)
            HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
    }

    // cool-down duel spell
    /*data.Initialize(SMSG_SPELL_COOLDOWN, 17);

    data<<GetGUID();
    data<<uint8(0x0);

    data<<(uint32)7266;
    data<<uint32(0x0);
    BroadcastPacketToSelf(&data);
    data.Initialize(SMSG_SPELL_COOLDOWN, 17);
    data<<duel->opponent->GetGUID();
    data<<uint8(0x0);
    data<<(uint32)7266;
    data<<uint32(0x0);
    duel->opponent->BroadcastPacketToSelf(&data);*/

    //Remove Duel Flag object
    GameObject* obj = GetMap()->GetGameObject(GetUInt64Value(PLAYER_DUEL_ARBITER));
    if (obj)
        duel->initiator->RemoveGameObject(obj,true);

    /* remove auras */
    std::vector<uint32> auras2remove;
    AuraMap const& vAuras = duel->opponent->GetAuras();
    for (AuraMap::const_iterator i = vAuras.begin(); i != vAuras.end(); ++i)
    {
        if (!i->second->IsPositive() && i->second->GetCasterGUID() == GetGUID() && i->second->GetAuraApplyTime() >= duel->startTime)
            auras2remove.push_back(i->second->GetId());
    }

    for (size_t i=0; i<auras2remove.size(); i++)
        duel->opponent->RemoveAurasDueToSpell(auras2remove[i]);

    auras2remove.clear();
    AuraMap const& auras = GetAuras();
    for (AuraMap::const_iterator i = auras.begin(); i != auras.end(); ++i)
    {
        if (!i->second->IsPositive() && i->second->GetCasterGUID() == duel->opponent->GetGUID() && i->second->GetAuraApplyTime() >= duel->startTime)
            auras2remove.push_back(i->second->GetId());
    }
    for (size_t i=0; i<auras2remove.size(); i++)
        RemoveAurasDueToSpell(auras2remove[i]);

    // cleanup combo points
    if (GetComboTarget()==duel->opponent->GetGUID())
        ClearComboPoints();
    else if (GetComboTarget()==duel->opponent->GetPetGUID())
        ClearComboPoints();

    if (duel->opponent->GetComboTarget()==GetGUID())
        duel->opponent->ClearComboPoints();
    else if (duel->opponent->GetComboTarget()==GetPetGUID())
        duel->opponent->ClearComboPoints();

    // Honor points after duel (the winner) - ImpConfig
    if (uint32 amount = sWorld.getConfig(CONFIG_HONOR_AFTER_DUEL))
        duel->opponent->RewardHonor(NULL,1,amount);

    if (duel->initiator->GetAreaId() == 3674 || duel->initiator->GetAreaId() == 3701 || duel->initiator->GetAreaId() == 3519) {
        duel->opponent->duel->opponent->SetHealth(duel->opponent->duel->opponent->GetMaxHealth());
        duel->opponent->duel->opponent->SetPower(POWER_MANA, (duel->opponent->duel->opponent->GetMaxPower(POWER_MANA)));
        duel->opponent->duel->opponent->RemoveArenaSpellCooldowns();

        duel->opponent->SetHealth(duel->opponent->GetMaxHealth());
        duel->opponent->SetPower(POWER_MANA, (duel->opponent->GetMaxPower(POWER_MANA)));
        duel->opponent->RemoveArenaSpellCooldowns();
    }

    //cleanups
    SetUInt64Value(PLAYER_DUEL_ARBITER, 0);
    SetUInt32Value(PLAYER_DUEL_TEAM, 0);
    duel->opponent->SetUInt64Value(PLAYER_DUEL_ARBITER, 0);
    duel->opponent->SetUInt32Value(PLAYER_DUEL_TEAM, 0);

    delete duel->opponent->duel;
    duel->opponent->duel = NULL;
    delete duel;
    duel = NULL;
}

//---------------------------------------------------------//

void Player::_ApplyItemMods(Item *item, uint8 slot,bool apply)
{
    if (slot >= INVENTORY_SLOT_BAG_END || !item)
        return;

    ItemPrototype const *proto = item->GetProto();

    if (!proto)
        return;

    // not apply/remove mods for broken item (_ApplyItemMods is used before setting durability to 0 when item
    // loss durability so there is no need to check for 'apply' (prevent bug abuse by stats stacking))
    if (item->IsBroken())
    {
        if (proto->Socket[0].Color)
            CorrectMetaGemEnchants(slot, apply);
        return;
    }

    sLog.outDetail("applying mods for item %u ",item->GetGUIDLow());

    uint32 attacktype = Player::GetAttackBySlot(slot);
    if (attacktype < MAX_ATTACK)
        _ApplyWeaponDependentAuraMods(item,WeaponAttackType(attacktype),apply);

    _ApplyItemBonuses(proto,slot,apply);

    if (slot==EQUIPMENT_SLOT_RANGED)
        _ApplyAmmoBonuses();

    ApplyItemEquipSpell(item,apply);
    ApplyEnchantment(item, apply);

    if (proto->Socket[0].Color)                              //only (un)equipping of items with sockets can influence metagems, so no need to waste time with normal items
        CorrectMetaGemEnchants(slot, apply);

    sLog.outDebug("_ApplyItemMods complete.");
}

void Player::_ApplyItemBonuses(ItemPrototype const *proto,uint8 slot,bool apply)
{
    if (slot >= INVENTORY_SLOT_BAG_END || !proto)
        return;

    for (int i = 0; i < MAX_ITEM_PROTO_STATS; i++)
    {
        float val = float (proto->ItemStat[i].ItemStatValue);

        if (val==0)
            continue;

        switch (proto->ItemStat[i].ItemStatType)
        {
            case ITEM_MOD_MANA:
                HandleStatModifier(UNIT_MOD_MANA, BASE_VALUE, float(val), apply);
                break;
            case ITEM_MOD_HEALTH:                           // modify HP
                HandleStatModifier(UNIT_MOD_HEALTH, BASE_VALUE, float(val), apply);
                break;
            case ITEM_MOD_AGILITY:                          // modify agility
                HandleStatModifier(UNIT_MOD_STAT_AGILITY, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_AGILITY, float(val), apply);
                break;
            case ITEM_MOD_STRENGTH:                         //modify strength
                HandleStatModifier(UNIT_MOD_STAT_STRENGTH, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_STRENGTH, float(val), apply);
                break;
            case ITEM_MOD_INTELLECT:                        //modify intellect
                HandleStatModifier(UNIT_MOD_STAT_INTELLECT, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_INTELLECT, float(val), apply);
                break;
            case ITEM_MOD_SPIRIT:                           //modify spirit
                HandleStatModifier(UNIT_MOD_STAT_SPIRIT, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_SPIRIT, float(val), apply);
                break;
            case ITEM_MOD_STAMINA:                          //modify stamina
                HandleStatModifier(UNIT_MOD_STAT_STAMINA, BASE_VALUE, float(val), apply);
                ApplyStatBuffMod(STAT_STAMINA, float(val), apply);
                break;
            case ITEM_MOD_DEFENSE_SKILL_RATING:
                ApplyRatingMod(CR_DEFENSE_SKILL, int32(val), apply);
                break;
            case ITEM_MOD_DODGE_RATING:
                ApplyRatingMod(CR_DODGE, int32(val), apply);
                break;
            case ITEM_MOD_PARRY_RATING:
                ApplyRatingMod(CR_PARRY, int32(val), apply);
                break;
            case ITEM_MOD_BLOCK_RATING:
                ApplyRatingMod(CR_BLOCK, int32(val), apply);
                break;
            case ITEM_MOD_HIT_MELEE_RATING:
                ApplyRatingMod(CR_HIT_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_HIT_RANGED_RATING:
                ApplyRatingMod(CR_HIT_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_HIT_SPELL_RATING:
                ApplyRatingMod(CR_HIT_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_MELEE_RATING:
                ApplyRatingMod(CR_CRIT_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_RANGED_RATING:
                ApplyRatingMod(CR_CRIT_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_SPELL_RATING:
                ApplyRatingMod(CR_CRIT_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HIT_TAKEN_MELEE_RATING:
                ApplyRatingMod(CR_HIT_TAKEN_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_HIT_TAKEN_RANGED_RATING:
                ApplyRatingMod(CR_HIT_TAKEN_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_HIT_TAKEN_SPELL_RATING:
                ApplyRatingMod(CR_HIT_TAKEN_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_TAKEN_MELEE_RATING:
                ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_TAKEN_RANGED_RATING:
                ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_TAKEN_SPELL_RATING:
                ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HASTE_MELEE_RATING:
                ApplyRatingMod(CR_HASTE_MELEE, int32(val), apply);
                break;
            case ITEM_MOD_HASTE_RANGED_RATING:
                ApplyRatingMod(CR_HASTE_RANGED, int32(val), apply);
                break;
            case ITEM_MOD_HASTE_SPELL_RATING:
                ApplyRatingMod(CR_HASTE_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HIT_RATING:
                ApplyRatingMod(CR_HIT_MELEE, int32(val), apply);
                ApplyRatingMod(CR_HIT_RANGED, int32(val), apply);
                //ApplyRatingMod(CR_HIT_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_RATING:
                ApplyRatingMod(CR_CRIT_MELEE, int32(val), apply);
                ApplyRatingMod(CR_CRIT_RANGED, int32(val), apply);
                //ApplyRatingMod(CR_CRIT_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HIT_TAKEN_RATING:
                ApplyRatingMod(CR_HIT_TAKEN_MELEE, int32(val), apply);
                ApplyRatingMod(CR_HIT_TAKEN_RANGED, int32(val), apply);
                ApplyRatingMod(CR_HIT_TAKEN_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_CRIT_TAKEN_RATING:
                ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
                ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
                ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_RESILIENCE_RATING:
                ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
                ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
                ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_HASTE_RATING:
                ApplyRatingMod(CR_HASTE_MELEE, int32(val), apply);
                ApplyRatingMod(CR_HASTE_RANGED, int32(val), apply);
                //ApplyRatingMod(CR_HASTE_SPELL, int32(val), apply);
                break;
            case ITEM_MOD_EXPERTISE_RATING:
                ApplyRatingMod(CR_EXPERTISE, int32(val), apply);
                break;
            case ITEM_MOD_SPELL_PENETRATION:
                ApplyModInt32Value(PLAYER_FIELD_MOD_TARGET_RESISTANCE, int32(-val), apply);
                m_spellPenetrationItemMod += apply ? int32(val) : int32(-val);
                break;
        }
    }

    if (proto->Armor)
        HandleStatModifier(UNIT_MOD_ARMOR, BASE_VALUE, float(proto->Armor), apply);

    if (proto->Block)
        HandleBaseModValue(SHIELD_BLOCK_VALUE, FLAT_MOD, float(proto->Block), apply);

    if (proto->HolyRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_HOLY, BASE_VALUE, float(proto->HolyRes), apply);

    if (proto->FireRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_FIRE, BASE_VALUE, float(proto->FireRes), apply);

    if (proto->NatureRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_NATURE, BASE_VALUE, float(proto->NatureRes), apply);

    if (proto->FrostRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_FROST, BASE_VALUE, float(proto->FrostRes), apply);

    if (proto->ShadowRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_SHADOW, BASE_VALUE, float(proto->ShadowRes), apply);

    if (proto->ArcaneRes)
        HandleStatModifier(UNIT_MOD_RESISTANCE_ARCANE, BASE_VALUE, float(proto->ArcaneRes), apply);

    WeaponAttackType attType = BASE_ATTACK;
    float damage = 0.0f;

    if (slot == EQUIPMENT_SLOT_RANGED && (
        proto->InventoryType == INVTYPE_RANGED || proto->InventoryType == INVTYPE_THROWN ||
        proto->InventoryType == INVTYPE_RANGEDRIGHT))
    {
        attType = RANGED_ATTACK;
    }
    else if (slot==EQUIPMENT_SLOT_OFFHAND)
    {
        attType = OFF_ATTACK;
    }

    if (proto->Damage[0].DamageMin > 0)
    {
        damage = apply ? proto->Damage[0].DamageMin : BASE_MINDAMAGE;
        SetBaseWeaponDamage(attType, MINDAMAGE, damage);
        //sLog.outLog(LOG_DEFAULT, "ERROR: applying mindam: assigning %f to weapon mindamage, now is: %f", damage, GetWeaponDamageRange(attType, MINDAMAGE));
    }

    if (proto->Damage[0].DamageMax  > 0)
    {
        damage = apply ? proto->Damage[0].DamageMax : BASE_MAXDAMAGE;
        SetBaseWeaponDamage(attType, MAXDAMAGE, damage);
    }

    if (!IsUseEquipedWeapon(slot==EQUIPMENT_SLOT_MAINHAND))
        return;

    if (proto->Delay)
    {
        if (slot == EQUIPMENT_SLOT_RANGED)
            SetAttackTime(RANGED_ATTACK, apply ? proto->Delay: BASE_ATTACK_TIME);
        else if (slot==EQUIPMENT_SLOT_MAINHAND)
            SetAttackTime(BASE_ATTACK, apply ? proto->Delay: BASE_ATTACK_TIME);
        else if (slot==EQUIPMENT_SLOT_OFFHAND)
            SetAttackTime(OFF_ATTACK, apply ? proto->Delay: BASE_ATTACK_TIME);
    }

    if (CanModifyStats() && (damage || proto->Delay))
        UpdateDamagePhysical(attType);
}

void Player::_ApplyWeaponDependentAuraMods(Item *item,WeaponAttackType attackType,bool apply)
{
    AuraList const& auraCritList = GetAurasByType(SPELL_AURA_MOD_CRIT_PERCENT);
    for (AuraList::const_iterator itr = auraCritList.begin(); itr!=auraCritList.end();++itr)
        _ApplyWeaponDependentAuraCritMod(item,attackType,*itr,apply);

    AuraList const& auraDamageFlatList = GetAurasByType(SPELL_AURA_MOD_DAMAGE_DONE);
    for (AuraList::const_iterator itr = auraDamageFlatList.begin(); itr!=auraDamageFlatList.end();++itr)
        _ApplyWeaponDependentAuraDamageMod(item,attackType,*itr,apply);

    AuraList const& auraDamagePCTList = GetAurasByType(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
    for (AuraList::const_iterator itr = auraDamagePCTList.begin(); itr!=auraDamagePCTList.end();++itr)
        _ApplyWeaponDependentAuraDamageMod(item,attackType,*itr,apply);
}

void Player::_ApplyWeaponDependentAuraCritMod(Item *item, WeaponAttackType attackType, Aura* aura, bool apply)
{
    // generic not weapon specific case processes in aura code
    if (aura->GetSpellProto()->EquippedItemClass == -1)
        return;

    BaseModGroup mod = BASEMOD_END;
    switch (attackType)
    {
        case BASE_ATTACK:   mod = CRIT_PERCENTAGE;        break;
        case OFF_ATTACK:    mod = OFFHAND_CRIT_PERCENTAGE;break;
        case RANGED_ATTACK: mod = RANGED_CRIT_PERCENTAGE; break;
        default: return;
    }

    if (item->IsFitToSpellRequirements(aura->GetSpellProto()))
    {
        HandleBaseModValue(mod, FLAT_MOD, float (aura->GetModifierValue()), apply);
    }
}

void Player::_ApplyWeaponDependentAuraDamageMod(Item *item, WeaponAttackType attackType, Aura* aura, bool apply)
{
    // ignore spell mods for not wands
    Modifier const* modifier = aura->GetModifier();
    if ((modifier->m_miscvalue & SPELL_SCHOOL_MASK_NORMAL)==0 && (getClassMask() & CLASSMASK_WAND_USERS)==0)
        return;

    // generic not weapon specific case processes in aura code
    if (aura->GetSpellProto()->EquippedItemClass == -1)
        return;

    UnitMods unitMod = UNIT_MOD_END;
    switch (attackType)
    {
        case BASE_ATTACK:   unitMod = UNIT_MOD_DAMAGE_MAINHAND; break;
        case OFF_ATTACK:    unitMod = UNIT_MOD_DAMAGE_OFFHAND;  break;
        case RANGED_ATTACK: unitMod = UNIT_MOD_DAMAGE_RANGED;   break;
        default: return;
    }

    UnitModifierType unitModType = TOTAL_VALUE;
    switch (modifier->m_auraname)
    {
        case SPELL_AURA_MOD_DAMAGE_DONE:         unitModType = TOTAL_VALUE; break;
        case SPELL_AURA_MOD_DAMAGE_PERCENT_DONE: unitModType = TOTAL_PCT;   break;
        default: return;
    }

    if (item->IsFitToSpellRequirements(aura->GetSpellProto()))
    {
        HandleStatModifier(unitMod, unitModType, float(aura->GetModifierValue()),apply);
    }
}

void Player::ApplyItemEquipSpell(Item *item, bool apply, bool form_change)
{
    if (!item)
        return;

    ItemPrototype const *proto = item->GetProto();
    if (!proto)
        return;

    for (int i = 0; i < MAX_ITEM_PROTO_SPELLS; i++)
    {
        _Spell const& spellData = proto->Spells[i];

        // no spell
        if (!spellData.SpellId)
            continue;

        // wrong triggering type
        if (apply && spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_EQUIP)
            continue;

        // check if it is valid spell
        SpellEntry const* spellproto = sSpellStore.LookupEntry(spellData.SpellId);
        if (!spellproto)
            continue;

        ApplyEquipSpell(spellproto,item,apply,form_change);
    }
}

void Player::ApplyEquipSpell(SpellEntry const* spellInfo, Item* item, bool apply, bool form_change)
{
    if (apply)
    {
        // Cannot be used in this stance/form
        if (SpellMgr::GetErrorAtShapeshiftedCast(spellInfo, m_form) != SPELL_CAST_OK)
            return;

        if (form_change)                                     // check aura active state from other form
        {
            for (int k = 0; k < 3; ++k)
            {
                spellEffectPair spair = spellEffectPair(spellInfo->Id, k);
                for (AuraMap::iterator iter = m_Auras.lower_bound(spair); iter != m_Auras.upper_bound(spair); ++iter)
                    if (!item || iter->second->GetCastItemGUID() == item->GetGUID())
                        return;     // and skip re-cast already active aura at form change
            }
        }

        DEBUG_LOG("WORLD: cast %s Equip spellId - %i", (item ? "item" : "itemset"), spellInfo->Id);

        CastSpell(this, spellInfo, true, item);
    }
    else
    {
        if (form_change)                                     // check aura compatibility
        {
            // Cannot be used in this stance/form
            if (SpellMgr::GetErrorAtShapeshiftedCast(spellInfo, m_form) == SPELL_CAST_OK)
                return;                                     // and remove only not compatible at form change
        }

        if (item)
            RemoveAurasDueToItemSpell(item,spellInfo->Id);  // un-apply all spells , not only at-equipped
        else
            RemoveAurasDueToSpell(spellInfo->Id);           // un-apply spell (item set case)
    }
}

void Player::UpdateEquipSpellsAtFormChange()
{
    for (int i = 0; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (m_items[i] && !m_items[i]->IsBroken())
        {
            ApplyItemEquipSpell(m_items[i],false,true);     // remove spells that not fit to form
            ApplyItemEquipSpell(m_items[i],true,true);      // add spells that fit form but not active
        }
    }

    // item set bonuses not dependent from item broken state
    for (size_t setindex = 0; setindex < ItemSetEff.size(); ++setindex)
    {
        ItemSetEffect* eff = ItemSetEff[setindex];
        if (!eff)
            continue;

        for (uint32 y=0;y<8; ++y)
        {
            SpellEntry const* spellInfo = eff->spells[y];
            if (!spellInfo)
                continue;

            ApplyEquipSpell(spellInfo,NULL,false,true);       // remove spells that not fit to form
            ApplyEquipSpell(spellInfo,NULL,true,true);        // add spells that fit form but not active
        }
    }
}

void Player::CastItemCombatSpell(Unit *target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, SpellEntry const *spellInfo)
{
    if (spellInfo && ((spellInfo->Attributes & SPELL_ATTR_STOP_ATTACK_TARGET) ||
      (spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MAGIC || spellInfo->DmgClass == SPELL_DAMAGE_CLASS_NONE)))
        return;

    if (!target || !target->isAlive() || target == this)
        return;

    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
    {
        // If usable, try to cast item spell
        if (Item * item = ((Player*)this)->GetItemByPos(INVENTORY_SLOT_BAG_0,i))
        {
            if (!item->IsBroken())
            {
                if (ItemPrototype const *proto = item->GetProto())
                {
                    // Additional check for weapons
                    if (proto->Class == ITEM_CLASS_WEAPON)
                    {
                        // offhand item cannot proc from main hand hit etc
                        EquipmentSlots slot;
                        switch (attType)
                        {
                            case BASE_ATTACK:   slot = EQUIPMENT_SLOT_MAINHAND; break;
                            case OFF_ATTACK:    slot = EQUIPMENT_SLOT_OFFHAND;  break;
                            case RANGED_ATTACK: slot = EQUIPMENT_SLOT_RANGED;   break;
                            default: slot = EQUIPMENT_SLOT_END; break;
                        }

                        if (attType == RANGED_ATTACK && i == EQUIPMENT_SLOT_MAINHAND)
                        {
                            // exception for Righteous Weapon Coating, enchant on main hand should also proc from ranged attacks
                            if(uint32 enchant_id = item->GetEnchantmentId(EnchantmentSlot(TEMP_ENCHANTMENT_SLOT)))
                            {
                                SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
                                if(pEnchant && pEnchant->ID == 3266) // Blessed Weapon Coating
                                {
                                    ((Player*)this)->CastItemCombatSpell(target, attType, procVictim, procEx, item, proto, spellInfo);
                                    continue;
                                }
                            }
                        }

                        if (slot != i)
                            continue;

                        // Check if item is useable (forms or disarm)
                        if (attType == BASE_ATTACK && HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED))
                            continue;

                        /*if (IsInFeralForm(true))
                            continue;*/
                    }

                    bool canProcInFeralForm = false;
                    // check for exception combat item spells that can proc in feral form
                    for (int e_slot = 0; e_slot < MAX_ENCHANTMENT_SLOT; ++e_slot)
                    {
                        uint32 enchant_id = item->GetEnchantmentId(EnchantmentSlot(e_slot));
                        SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
                        if (!pEnchant) continue;
                        for (int s = 0; s < 3; ++s)
                        {
                            uint32 spell_id = 0;
                            if (pEnchant->type[s] != ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL)
                            {
                                switch (pEnchant->ID)
                                {
                                    // Righteous Weapon Coating can proc in feral form
                                    case 3266: canProcInFeralForm = true; break;
                                    default:
                                        continue;
                                }
                            }
                        }
                    }
                    if(!IsInFeralForm(true) || (!IsInFeralForm(true) && canProcInFeralForm))
                        ((Player*)this)->CastItemCombatSpell(target, attType, procVictim, procEx, item, proto, spellInfo);
                }
            }
        }
    }
}

void Player::CastItemCombatSpell(Unit *target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item *item, ItemPrototype const * proto, SpellEntry const *spell)
{
    // Can do effect if any damage done to target
    if (procVictim & PROC_FLAG_TAKEN_ANY_DAMAGE)
    {
        for (int i = 0; i < MAX_ITEM_PROTO_SPELLS; i++)
        {
            _Spell const& spellData = proto->Spells[i];

            // no spell
            if (!spellData.SpellId)
                continue;

            // wrong triggering type
            if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_CHANCE_ON_HIT)
                continue;

            SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellData.SpellId);
            if (!spellInfo)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: WORLD: unknown Item spellid %i", spellData.SpellId);
                continue;
            }

            // not allow proc extra attack spell at extra attack
            if (m_extraAttacks && spellInfo->HasEffect(SPELL_EFFECT_ADD_EXTRA_ATTACKS))
                return;

            float chance = spellInfo->procChance;

            if (spellData.SpellPPMRate)
            {
                uint32 WeaponSpeed = GetAttackTime(attType);
                chance = GetPPMProcChance(WeaponSpeed, spellData.SpellPPMRate);
            }
            else if (chance > 100.0f)
            {
                chance = GetWeaponProcChance();
            }

            if (roll_chance_f(chance))
                CastSpell(target, spellInfo->Id, true, item);
        }
    }

    // item combat enchantments
    for (int e_slot = 0; e_slot < MAX_ENCHANTMENT_SLOT; ++e_slot)
    {
        uint32 enchant_id = item->GetEnchantmentId(EnchantmentSlot(e_slot));
        SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
        if (!pEnchant) continue;
        for (int s = 0; s < 3; ++s)
        {
            uint32 spell_id = 0;
            if (pEnchant->type[s] != ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL)
            {
                // Flametongue Weapon support
                switch (pEnchant->ID)
                {
                    case 3:    spell_id =  8029; break; // Rank1
                    case 4:    spell_id =  8028; break; // Rank2
                    case 5:    spell_id =  8026; break; // Rank3
                    case 523:  spell_id = 10445; break; // Rank4
                    case 1665: spell_id = 16343; break; // Rank5
                    case 1666: spell_id = 16344; break; // Rank6
                    case 2634: spell_id = 25488; break; // Rank7
                    // Righteous Weapon Coating enchantment
                    case 3266: spell_id = 45401; break; // Righteousness spell proc
                    default:
                        continue;
                }
            }

            SpellEnchantProcEntry const* entry = sSpellMgr.GetSpellEnchantProcEvent(enchant_id);
            if (entry && (entry->procEx || entry->procFlags))
            {
                if (entry->procFlags)
                {
                    if ((procVictim & entry->procFlags) == 0)
                        continue;
                }

                if (entry->procEx)
                {
                    // Check hit/crit/dodge/parry requirement
                    if ((entry->procEx & procEx) == 0)
                        continue;
                }
            }
            else
            {
                // Can do effect if any damage done to target
                if (!(procVictim & PROC_FLAG_TAKEN_ANY_DAMAGE))
                    continue;
            }

            if (!spell_id)
                spell_id = pEnchant->spellid[s];

            SpellEntry const *spellInfo = sSpellStore.LookupEntry(spell_id);
            if (!spellInfo)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Player::CastItemCombatSpell Enchant %i, cast unknown spell %i", pEnchant->ID, spell_id);
                continue;
            }

            // not allow proc extra attack spell at extra attack
            if (m_extraAttacks && spellInfo->HasEffect(SPELL_EFFECT_ADD_EXTRA_ATTACKS))
                return;

            float chance = pEnchant->amount[s] != 0 ? float(pEnchant->amount[s]) : GetWeaponProcChance();

            if (entry && entry->PPMChance)
            {
                uint32 WeaponSpeed = GetAttackTime(attType);
                chance = GetPPMProcChance(WeaponSpeed, entry->PPMChance);
            }
            else if (entry && entry->customChance)
                chance = entry->customChance;

            // Apply spell mods
            ApplySpellMod(spell_id,SPELLMOD_CHANCE_OF_SUCCESS,chance);

            if (roll_chance_f(chance))
            {
                if (SpellMgr::IsPositiveSpell(spell_id))
                    CastSpell(this, spell_id, true, item);
                else
                    CastSpell(target, spell_id, true, item);
            }
        }
    }
}

void Player::_RemoveAllItemMods()
{
    sLog.outDebug("_RemoveAllItemMods start.");

    for (int i = 0; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (m_items[i])
        {
            ItemPrototype const *proto = m_items[i]->GetProto();
            if (!proto)
                continue;

            // item set bonuses not dependent from item broken state
            if (proto->ItemSet)
                RemoveItemsSetItem(this,proto);

            if (m_items[i]->IsBroken())
                continue;

            ApplyItemEquipSpell(m_items[i],false);
            ApplyEnchantment(m_items[i], false);
        }
    }

    for (int i = 0; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (m_items[i])
        {
            if (m_items[i]->IsBroken())
                continue;
            ItemPrototype const *proto = m_items[i]->GetProto();
            if (!proto)
                continue;

            uint32 attacktype = Player::GetAttackBySlot(i);
            if (attacktype < MAX_ATTACK)
                _ApplyWeaponDependentAuraMods(m_items[i],WeaponAttackType(attacktype),false);

            _ApplyItemBonuses(proto,i, false);

            if (i == EQUIPMENT_SLOT_RANGED)
                _ApplyAmmoBonuses();
        }
    }

    sLog.outDebug("_RemoveAllItemMods complete.");
}

void Player::_ApplyAllItemMods()
{
    sLog.outDebug("_ApplyAllItemMods start.");

    for (int i = 0; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (m_items[i])
        {
            if (m_items[i]->IsBroken())
                continue;

            ItemPrototype const *proto = m_items[i]->GetProto();
            if (!proto)
                continue;

            uint32 attacktype = Player::GetAttackBySlot(i);
            if (attacktype < MAX_ATTACK)
                _ApplyWeaponDependentAuraMods(m_items[i],WeaponAttackType(attacktype),true);

            _ApplyItemBonuses(proto,i, true);

            if (i == EQUIPMENT_SLOT_RANGED)
                _ApplyAmmoBonuses();
        }
    }

    for (int i = 0; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (m_items[i])
        {
            ItemPrototype const *proto = m_items[i]->GetProto();
            if (!proto)
                continue;

            // item set bonuses not dependent from item broken state
            if (proto->ItemSet)
                AddItemsSetItem(this,m_items[i]);

            if (m_items[i]->IsBroken())
                continue;

            ApplyItemEquipSpell(m_items[i],true);
            ApplyEnchantment(m_items[i], true);
        }
    }

    sLog.outDebug("_ApplyAllItemMods complete.");
}

void Player::_ApplyAmmoBonuses()
{
    // check ammo
    uint32 ammo_id = GetUInt32Value(PLAYER_AMMO_ID);
    if (!ammo_id)
        return;

    float currentAmmoDPS;

    ItemPrototype const *ammo_proto = ObjectMgr::GetItemPrototype(ammo_id);
    if (!ammo_proto || ammo_proto->Class!=ITEM_CLASS_PROJECTILE || !CheckAmmoCompatibility(ammo_proto))
        currentAmmoDPS = 0.0f;
    else
        currentAmmoDPS = ammo_proto->Damage[0].DamageMin;

    if (currentAmmoDPS == GetAmmoDPS())
        return;

    m_ammoDPS = currentAmmoDPS;

    if (CanModifyStats())
        UpdateDamagePhysical(RANGED_ATTACK);
}

bool Player::CheckAmmoCompatibility(const ItemPrototype *ammo_proto) const
{
    if (!ammo_proto)
        return false;

    // check ranged weapon
    Item *weapon = GetWeaponForAttack(RANGED_ATTACK);
    if (!weapon  || weapon->IsBroken())
        return false;

    ItemPrototype const* weapon_proto = weapon->GetProto();
    if (!weapon_proto || weapon_proto->Class!=ITEM_CLASS_WEAPON)
        return false;

    // check ammo ws. weapon compatibility
    switch (weapon_proto->SubClass)
    {
        case ITEM_SUBCLASS_WEAPON_BOW:
        case ITEM_SUBCLASS_WEAPON_CROSSBOW:
            if (ammo_proto->SubClass!=ITEM_SUBCLASS_ARROW)
                return false;
            break;
        case ITEM_SUBCLASS_WEAPON_GUN:
            if (ammo_proto->SubClass!=ITEM_SUBCLASS_BULLET)
                return false;
            break;
        default:
            return false;
    }

    return true;
}

/*  If in a battleground a player dies, and an enemy removes the insignia, the player's bones is lootable
    Called by remove insignia spell effect    */
void Player::RemovedInsignia(Player* looterPlr)
{
    if (!GetBattleGroundId())
        return;

    // If not released spirit, do it !
    if (m_deathTimer > 0)
    {
        m_deathTimer = 0;
        BuildPlayerRepop();
        RepopAtGraveyard();
    }

    Corpse *corpse = GetCorpse();
    if (!corpse)
        return;

    // We have to convert player corpse to bones, not to be able to resurrect there
    // SpawnCorpseBones isn't handy, 'cos it saves player while he in BG
    Corpse *bones = sObjectAccessor.ConvertCorpseForPlayer(GetGUID(),true);
    if (!bones)
        return;

    // Now we must make bones lootable, and send player loot
    bones->SetFlag(CORPSE_FIELD_DYNAMIC_FLAGS, CORPSE_DYNFLAG_LOOTABLE);

    // We store the level of our player in the gold field
    // We retrieve this information at Player::SendLoot()
    bones->loot.gold = getLevel();
    bones->lootRecipient = looterPlr;
    looterPlr->SendLoot(bones->GetGUID(), LOOT_INSIGNIA);
}

/*Loot type MUST be
1-corpse, go
2-skinning
3-Fishing
*/

void Player::SendLootRelease(uint64 guid)
{
    WorldPacket data(SMSG_LOOT_RELEASE_RESPONSE, (8+1));
    data << uint64(guid) << uint8(1);
    SendPacketToSelf(&data);
}

void Player::SendLoot(uint64 guid, LootType loot_type)
{
    // release old loot
    if (uint64 lguid = GetLootGUID())
        m_session->DoLootRelease(lguid);

    Loot    *loot = 0;
    PermissionTypes permission = ALL_PERMISSION;

    sLog.outDebug("Player::SendLoot");
    if (IS_GAMEOBJECT_GUID(guid))
    {
        sLog.outDebug("       IS_GAMEOBJECT_GUID(guid)");
        GameObject* go = GetMap()->GetGameObject(guid);

        // not check distance for GO in case owned GO (fishing bobber case, for example)
        // And permit out of range GO with no owner in case fishing hole
        if (!go || (loot_type != LOOT_FISHINGHOLE && (loot_type != LOOT_FISHING || go->GetOwnerGUID() != GetGUID()) && !go->IsWithinDistInMap(this,INTERACTION_DISTANCE*2)))
        {
            SendLootRelease(guid);
            return;
        }

        loot = &go->loot;

        if (go->getLootState() == GO_READY)
        {
            uint32 lootid =  go->GetLootId();

            //TODO: fix this big hack
            if ((go->GetEntry() == BG_AV_OBJECTID_MINE_N || go->GetEntry() == BG_AV_OBJECTID_MINE_S))
                if (BattleGround *bg = GetBattleGround())
                    if (bg->GetTypeID() == BATTLEGROUND_AV)
                        if (!(((BattleGroundAV*)bg)->PlayerCanDoMineQuest(go->GetEntry(),GetBGTeam())))
                        {
                            SendLootRelease(guid);
                            return;
                        }

            if (lootid)
            {
                sLog.outDebug("       if (lootid)");
                loot->clear();
                loot->FillLoot(lootid, LootTemplates_Gameobject, this, false);

                //if chest apply 2.1.x rules
                if ((go->GetGoType() == GAMEOBJECT_TYPE_CHEST)&&(go->GetGOInfo()->chest.groupLootRules))
                {
                    if (Group* group = this->GetGroup())
                    {
                        group->UpdateLooterGuid((WorldObject*)go, true);

                        group->PrepareLootRolls(this->GetGUID(), loot, (WorldObject*) go);
                        if (group->GetLootMethod() == MASTER_LOOT)
                            group->SendMasterLoot(loot, (WorldObject*) go);

                    }
                }
            }

            if (loot_type == LOOT_FISHING)
                go->getFishLoot(loot, this);

        }
    }
    else if (IS_ITEM_GUID(guid))
    {
        Item *item = GetItemByGuid(guid);

        if (!item)
        {
            SendLootRelease(guid);
            return;
        }

        if (loot_type == LOOT_DISENCHANTING)
        {
            loot = &item->loot;

            if (!item->m_lootGenerated)
            {
                item->m_lootGenerated = true;
                loot->clear();
                loot->FillLoot(item->GetProto()->DisenchantID, LootTemplates_Disenchant, this,true);
            }
        }
        else if (loot_type == LOOT_PROSPECTING)
        {
            loot = &item->loot;

            if (!item->m_lootGenerated)
            {
                item->m_lootGenerated = true;
                loot->clear();
                loot->FillLoot(item->GetEntry(), LootTemplates_Prospecting, this,true);
            }
        }
        else
        {
            loot = &item->loot;

            if (!item->m_lootGenerated)
            {
                item->m_lootGenerated = true;
                loot->clear();
                loot->FillLoot(item->GetEntry(), LootTemplates_Item, this,true);

                loot->generateMoneyLoot(item->GetProto()->MinMoneyLoot,item->GetProto()->MaxMoneyLoot);
            }
        }
    }
    else if (IS_CORPSE_GUID(guid))                          // remove insignia
    {
        Corpse *bones = ObjectAccessor::GetCorpse(*this, guid);

        if (!bones || !((loot_type == LOOT_CORPSE) || (loot_type == LOOT_INSIGNIA)) || (bones->GetType() != CORPSE_BONES))
        {
            SendLootRelease(guid);
            return;
        }

        loot = &bones->loot;

        if (!bones->lootForBody)
        {
            bones->lootForBody = true;
            uint32 pLevel = bones->loot.gold;
            bones->loot.clear();
            if (BattleGround *bg = GetBattleGround())
                if (bg->GetTypeID() == BATTLEGROUND_AV)
                    loot->FillLoot(1, LootTemplates_Creature, this, true);
            // It may need a better formula
            // Now it works like this: lvl10: ~6copper, lvl70: ~9silver
            bones->loot.gold = (uint32)(urand(50, 150) * 0.016f * pow(((float)pLevel)/5.76f, 2.5f) * sWorld.getRate(RATE_DROP_MONEY));
        }

        if (bones->lootRecipient != this)
            permission = NONE_PERMISSION;
    }
    else
    {
        Creature *creature = GetMap()->GetCreature(guid);

        // must be in range and creature must be alive for pickpocket and must be dead for another loot
        if (!creature || creature->isAlive() != (loot_type == LOOT_PICKPOCKETING) || !creature->IsWithinDistInMap(this,INTERACTION_DISTANCE))
        {
            SendLootRelease(guid);
            return;
        }

        if (loot_type == LOOT_PICKPOCKETING && IsFriendlyTo(creature))
        {
            SendLootRelease(guid);
            return;
        }

        loot = &creature->loot;

        if (loot_type == LOOT_PICKPOCKETING)
        {
            if (!creature->lootForPickPocketed)
            {
                creature->lootForPickPocketed = true;
                loot->clear();

                if (uint32 lootid = creature->GetCreatureInfo()->pickpocketLootId)
                    loot->FillLoot(lootid, LootTemplates_Pickpocketing, this, false);

                // Generate extra money for pick pocket loot
                const uint32 a = urand(0, creature->getLevel()/2);
                const uint32 b = urand(0, getLevel()/2);
                loot->gold = uint32(10 * (a + b) * sWorld.getRate(RATE_DROP_MONEY));
            }
        }
        else
        {
            // the player whose group may loot the corpse
            Player *recipient = creature->GetLootRecipient();
            if (!recipient)
            {
                creature->SetLootRecipient(this);
                recipient = this;
            }

            if (!creature->lootForBody)
            {
                creature->lootForBody = true;
                if (Group* group = recipient->GetGroup())
                {
                    group->PrepareLootRolls(recipient->GetGUID(), loot, creature);
                    if (group->GetLootMethod() == MASTER_LOOT)
                        group->SendMasterLoot(loot, creature);
                }
            }

            // possible only if creature->lootForBody && loot->empty() at spell cast check
            if (loot_type == LOOT_SKINNING)
            {
                loot->clear();
                loot->FillLoot(creature->GetCreatureInfo()->SkinLootId, LootTemplates_Skinning, this, false);
            }
            // set group rights only for loot_type != LOOT_SKINNING
            else
            {
                if (Group* group = GetGroup())
                {
                    permission = NONE_PERMISSION;
                    if (group == recipient->GetGroup() && creature->IsPlayerAllowedToLoot(this))
                    {
                        switch(group->GetLootMethod())
                        {
                            case FREE_FOR_ALL:
                                permission = ALL_PERMISSION;
                                break;
                            case MASTER_LOOT:
                                if (group->GetLooterGuid() == GetGUID())
                                    permission = MASTER_PERMISSION;
                                else
                                    permission = GROUP_NONE_PERMISSION;
                                break;
                            case GROUP_LOOT:
                            case NEED_BEFORE_GREED:
                            case ROUND_ROBIN:
                                if (!loot->looterGUID || loot->looterGUID == GetGUID())
                                    permission = GROUP_LOOTER_PERMISSION;   // can take items below threshold
                                else
                                    permission = GROUP_NONE_PERMISSION;     // only see items, cant take
                                break;
                        }
                    }
                }
                else if (recipient == this) // not in group
                    permission = ALL_PERMISSION;
                else
                    permission = NONE_PERMISSION;
            }
        }
    }

    SetLootGUID(guid);

    // LOOT_PICKPOCKETING, LOOT_PROSPECTING, LOOT_DISENCHANTING and LOOT_INSIGNIA unsupported by client, sending LOOT_SKINNING instead
    if (loot_type == LOOT_PICKPOCKETING || loot_type == LOOT_DISENCHANTING || loot_type == LOOT_PROSPECTING || loot_type == LOOT_INSIGNIA)
        loot_type = LOOT_SKINNING;

    if (loot_type == LOOT_FISHINGHOLE)
        loot_type = LOOT_FISHING;

    WorldPacket data(SMSG_LOOT_RESPONSE, (9+50));           // we guess size

    data << uint64(guid);
    data << uint8(loot_type);
    data << LootView(*loot, this, permission);

    SendPacketToSelf(&data);

    // add 'this' player as one of the players that are looting 'loot'
    if (permission != NONE_PERMISSION)
        loot->AddLooter(GetGUID());

    if (loot_type == LOOT_CORPSE && !IS_ITEM_GUID(guid))
        SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_LOOTING);
}

void Player::SendNotifyLootMoneyRemoved()
{
    WorldPacket data(SMSG_LOOT_CLEAR_MONEY, 0);
    SendPacketToSelf(&data);
}

void Player::SendNotifyLootItemRemoved(uint8 lootSlot)
{
    WorldPacket data(SMSG_LOOT_REMOVED, 1);
    data << uint8(lootSlot);
    SendPacketToSelf(&data);
}

void Player::SendUpdateWorldState(uint32 Field, uint32 Value)
{
    WorldPacket data(SMSG_UPDATE_WORLD_STATE, 8);
    data << Field;
    data << Value;
    SendPacketToSelf(&data);
}

void Player::SendInitWorldStates(bool forceZone, uint32 forceZoneId)
{
    // data depends on zoneid/mapid...
    BattleGround* bg = GetBattleGround();
    uint16 NumberOfFields = 0;
    uint32 mapid = GetMapId();
    uint32 zoneid;
    if (forceZone)
        zoneid = forceZoneId;
    else
        zoneid = GetZoneId();
    OutdoorPvP * pvp = sOutdoorPvPMgr.GetOutdoorPvPToZoneId(zoneid);
    uint32 areaid = GetCachedArea();
    sLog.outDebug("Sending SMSG_INIT_WORLD_STATES to Map:%u, Zone: %u", mapid, zoneid);
    // may be exist better way to do this...
    switch (zoneid)
    {
        case 0:
        case 1:
        case 4:
        case 8:
        case 10:
        case 11:
        case 12:
        case 36:
        case 38:
        case 40:
        case 41:
        case 51:
        case 267:
        case 1519:
        case 1537:
        case 2257:
        case 2918:
            NumberOfFields = 6;
            break;
        case 139:
            NumberOfFields = 39;
            break;
        case 1377:
            NumberOfFields = 13;
            break;
        case 2597:
            NumberOfFields = 81;
            break;
        case 3277:
            NumberOfFields = 14;
            break;
        case 3358:
        case 3820:
            NumberOfFields = 38;
            break;
        case 3483:
            NumberOfFields = 25;
            break;
        case 3518:
            NumberOfFields = 37;
            break;
        case 3519:
            NumberOfFields = 36;
            break;
        case 3521:
            NumberOfFields = 35;
            break;
        case 3698:
        case 3702:
        case 3968:
            NumberOfFields = 9;
            break;
        case 3703:
            NumberOfFields = 9;
            break;
        default:
            NumberOfFields = 10;
            break;
    }

    WorldPacket data(SMSG_INIT_WORLD_STATES, (4+4+4+2+(NumberOfFields*8)));
    data << uint32(mapid);                                  // mapid
    data << uint32(zoneid);                                 // zone id
    data << uint32(areaid);                                 // area id, new 2.1.0
    data << uint16(NumberOfFields);                         // count of uint64 blocks
    data << uint32(0x8d8) << uint32(0x0);                   // 1
    data << uint32(0x8d7) << uint32(0x0);                   // 2
    data << uint32(0x8d6) << uint32(0x0);                   // 3
    data << uint32(0x8d5) << uint32(0x0);                   // 4
    data << uint32(0x8d4) << uint32(0x0);                   // 5
    data << uint32(0x8d3) << uint32(0x0);                   // 6
    if (mapid == 530)                                        // Outland
    {
        data << uint32(0x9bf) << uint32(0x0);               // 7
        data << uint32(0x9bd) << uint32(0xF);               // 8
        data << uint32(0x9bb) << uint32(0xF);               // 9
    }
    switch (zoneid)
    {
        case 1:
        case 11:
        case 12:
        case 38:
        case 40:
        case 51:
        case 1519:
        case 1537:
        case 2257:
            break;
        case 139: // EPL
            {
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_EP)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x97a) << uint32(0x0); // 10 2426
                    data << uint32(0x917) << uint32(0x0); // 11 2327
                    data << uint32(0x918) << uint32(0x0); // 12 2328
                    data << uint32(0x97b) << uint32(0x32); // 13 2427
                    data << uint32(0x97c) << uint32(0x32); // 14 2428
                    data << uint32(0x933) << uint32(0x1); // 15 2355
                    data << uint32(0x946) << uint32(0x0); // 16 2374
                    data << uint32(0x947) << uint32(0x0); // 17 2375
                    data << uint32(0x948) << uint32(0x0); // 18 2376
                    data << uint32(0x949) << uint32(0x0); // 19 2377
                    data << uint32(0x94a) << uint32(0x0); // 20 2378
                    data << uint32(0x94b) << uint32(0x0); // 21 2379
                    data << uint32(0x932) << uint32(0x0); // 22 2354
                    data << uint32(0x934) << uint32(0x0); // 23 2356
                    data << uint32(0x935) << uint32(0x0); // 24 2357
                    data << uint32(0x936) << uint32(0x0); // 25 2358
                    data << uint32(0x937) << uint32(0x0); // 26 2359
                    data << uint32(0x938) << uint32(0x0); // 27 2360
                    data << uint32(0x939) << uint32(0x1); // 28 2361
                    data << uint32(0x930) << uint32(0x1); // 29 2352
                    data << uint32(0x93a) << uint32(0x0); // 30 2362
                    data << uint32(0x93b) << uint32(0x0); // 31 2363
                    data << uint32(0x93c) << uint32(0x0); // 32 2364
                    data << uint32(0x93d) << uint32(0x0); // 33 2365
                    data << uint32(0x944) << uint32(0x0); // 34 2372
                    data << uint32(0x945) << uint32(0x0); // 35 2373
                    data << uint32(0x931) << uint32(0x1); // 36 2353
                    data << uint32(0x93e) << uint32(0x0); // 37 2366
                    data << uint32(0x931) << uint32(0x1); // 38 2367 ??  grey horde not in dbc! send for consistency's sake, and to match field count
                    data << uint32(0x940) << uint32(0x0); // 39 2368
                    data << uint32(0x941) << uint32(0x0); // 7 2369
                    data << uint32(0x942) << uint32(0x0); // 8 2370
                    data << uint32(0x943) << uint32(0x0); // 9 2371
                }
            }
            break;
        case 1377: // Silithus
            {
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_SI)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    // states are always shown
                    data << uint32(2313) << uint32(0x0); // 7 ally silityst gathered
                    data << uint32(2314) << uint32(0x0); // 8 horde silityst gathered
                    data << uint32(2317) << uint32(0x0); // 9 max silithyst
                }
                // dunno about these... aq opening event maybe?
                data << uint32(2322) << uint32(0x0); // 10 sandworm N
                data << uint32(2323) << uint32(0x0); // 11 sandworm S
                data << uint32(2324) << uint32(0x0); // 12 sandworm SW
                data << uint32(2325) << uint32(0x0); // 13 sandworm E
            }
            break;
        case 2597:                                          // AV
            if (bg && bg->GetTypeID() == BATTLEGROUND_AV)
                bg->FillInitialWorldStates(data);
            else
            {
                data << uint32(0x7ae) << uint32(0x1);           // 7 snowfall n
                data << uint32(0x532) << uint32(0x1);           // 8 frostwolfhut hc
                data << uint32(0x531) << uint32(0x0);           // 9 frostwolfhut ac
                data << uint32(0x52e) << uint32(0x0);           // 10 stormpike firstaid a_a
                data << uint32(0x571) << uint32(0x0);           // 11 east frostwolf tower horde assaulted -unused
                data << uint32(0x570) << uint32(0x0);           // 12 west frostwolf tower horde assaulted - unused
                data << uint32(0x567) << uint32(0x1);           // 13 frostwolfe c
                data << uint32(0x566) << uint32(0x1);           // 14 frostwolfw c
                data << uint32(0x550) << uint32(0x1);           // 15 irondeep (N) ally
                data << uint32(0x544) << uint32(0x0);           // 16 ice grave a_a
                data << uint32(0x536) << uint32(0x0);           // 17 stormpike grave h_c
                data << uint32(0x535) << uint32(0x1);           // 18 stormpike grave a_c
                data << uint32(0x518) << uint32(0x0);           // 19 stoneheart grave a_a
                data << uint32(0x517) << uint32(0x0);           // 20 stoneheart grave h_a
                data << uint32(0x574) << uint32(0x0);           // 21 1396 unk
                data << uint32(0x573) << uint32(0x0);           // 22 iceblood tower horde assaulted -unused
                data << uint32(0x572) << uint32(0x0);           // 23 towerpoint horde assaulted - unused
                data << uint32(0x56f) << uint32(0x0);           // 24 1391 unk
                data << uint32(0x56e) << uint32(0x0);           // 25 iceblood a
                data << uint32(0x56d) << uint32(0x0);           // 26 towerp a
                data << uint32(0x56c) << uint32(0x0);           // 27 frostwolfe a
                data << uint32(0x56b) << uint32(0x0);           // 28 froswolfw a
                data << uint32(0x56a) << uint32(0x1);           // 29 1386 unk
                data << uint32(0x569) << uint32(0x1);           // 30 iceblood c
                data << uint32(0x568) << uint32(0x1);           // 31 towerp c
                data << uint32(0x565) << uint32(0x0);           // 32 stoneh tower a
                data << uint32(0x564) << uint32(0x0);           // 33 icewing tower a
                data << uint32(0x563) << uint32(0x0);           // 34 dunn a
                data << uint32(0x562) << uint32(0x0);           // 35 duns a
                data << uint32(0x561) << uint32(0x0);           // 36 stoneheart bunker alliance assaulted - unused
                data << uint32(0x560) << uint32(0x0);           // 37 icewing bunker alliance assaulted - unused
                data << uint32(0x55f) << uint32(0x0);           // 38 dunbaldar south alliance assaulted - unused
                data << uint32(0x55e) << uint32(0x0);           // 39 dunbaldar north alliance assaulted - unused
                data << uint32(0x55d) << uint32(0x0);           // 40 stone tower d
                data << uint32(0x3c6) << uint32(0x0);           // 41 966 unk
                data << uint32(0x3c4) << uint32(0x0);           // 42 964 unk
                data << uint32(0x3c2) << uint32(0x0);           // 43 962 unk
                data << uint32(0x516) << uint32(0x1);           // 44 stoneheart grave a_c
                data << uint32(0x515) << uint32(0x0);           // 45 stonheart grave h_c
                data << uint32(0x3b6) << uint32(0x0);           // 46 950 unk
                data << uint32(0x55c) << uint32(0x0);           // 47 icewing tower d
                data << uint32(0x55b) << uint32(0x0);           // 48 dunn d
                data << uint32(0x55a) << uint32(0x0);           // 49 duns d
                data << uint32(0x559) << uint32(0x0);           // 50 1369 unk
                data << uint32(0x558) << uint32(0x0);           // 51 iceblood d
                data << uint32(0x557) << uint32(0x0);           // 52 towerp d
                data << uint32(0x556) << uint32(0x0);           // 53 frostwolfe d
                data << uint32(0x555) << uint32(0x0);           // 54 frostwolfw d
                data << uint32(0x554) << uint32(0x1);           // 55 stoneh tower c
                data << uint32(0x553) << uint32(0x1);           // 56 icewing tower c
                data << uint32(0x552) << uint32(0x1);           // 57 dunn c
                data << uint32(0x551) << uint32(0x1);           // 58 duns c
                data << uint32(0x54f) << uint32(0x0);           // 59 irondeep (N) horde
                data << uint32(0x54e) << uint32(0x0);           // 60 irondeep (N) ally
                data << uint32(0x54d) << uint32(0x1);           // 61 mine (S) neutral
                data << uint32(0x54c) << uint32(0x0);           // 62 mine (S) horde
                data << uint32(0x54b) << uint32(0x0);           // 63 mine (S) ally
                data << uint32(0x545) << uint32(0x0);           // 64 iceblood h_a
                data << uint32(0x543) << uint32(0x1);           // 65 iceblod h_c
                data << uint32(0x542) << uint32(0x0);           // 66 iceblood a_c
                data << uint32(0x540) << uint32(0x0);           // 67 snowfall h_a
                data << uint32(0x53f) << uint32(0x0);           // 68 snowfall a_a
                data << uint32(0x53e) << uint32(0x0);           // 69 snowfall h_c
                data << uint32(0x53d) << uint32(0x0);           // 70 snowfall a_c
                data << uint32(0x53c) << uint32(0x0);           // 71 frostwolf g h_a
                data << uint32(0x53b) << uint32(0x0);           // 72 frostwolf g a_a
                data << uint32(0x53a) << uint32(0x1);           // 73 frostwolf g h_c
                data << uint32(0x539) << uint32(0x0);           // 74 frostwolf g a_c
                data << uint32(0x538) << uint32(0x0);           // 75 stormpike grave h_a
                data << uint32(0x537) << uint32(0x0);           // 76 stormpike grave a_a
                data << uint32(0x534) << uint32(0x0);           // 77 frostwolf hut h_a
                data << uint32(0x533) << uint32(0x0);           // 78 frostwolf hut a_a
                data << uint32(0x530) << uint32(0x0);           // 79 stormpike first aid h_a
                data << uint32(0x52f) << uint32(0x0);           // 80 stormpike first aid h_c
                data << uint32(0x52d) << uint32(0x1);           // 81 stormpike first aid a_c
            }
            break;
        case 3277:                                          // WS
            if (bg && bg->GetTypeID() == BATTLEGROUND_WS)
                bg->FillInitialWorldStates(data);
            else
            {
                data << uint32(0x62d) << uint32(0x0);       // 7 1581 alliance flag captures
                data << uint32(0x62e) << uint32(0x0);       // 8 1582 horde flag captures
                data << uint32(0x609) << uint32(0x0);       // 9 1545 unk, set to 1 on alliance flag pickup...
                data << uint32(0x60a) << uint32(0x0);       // 10 1546 unk, set to 1 on horde flag pickup, after drop it's -1
                data << uint32(0x60b) << uint32(0x2);       // 11 1547 unk
                data << uint32(0x641) << uint32(0x3);       // 12 1601 unk (max flag captures?)
                data << uint32(0x922) << uint32(0x1);       // 13 2338 horde (0 - hide, 1 - flag ok, 2 - flag picked up (flashing), 3 - flag picked up (not flashing)
                data << uint32(0x923) << uint32(0x1);       // 14 2339 alliance (0 - hide, 1 - flag ok, 2 - flag picked up (flashing), 3 - flag picked up (not flashing)
            }
            break;
        case 3358:                                          // AB
            if (bg && bg->GetTypeID() == BATTLEGROUND_AB)
                bg->FillInitialWorldStates(data);
            else
            {
                data << uint32(0x6e7) << uint32(0x0);       // 7 1767 stables alliance
                data << uint32(0x6e8) << uint32(0x0);       // 8 1768 stables horde
                data << uint32(0x6e9) << uint32(0x0);       // 9 1769 unk, ST?
                data << uint32(0x6ea) << uint32(0x0);       // 10 1770 stables (show/hide)
                data << uint32(0x6ec) << uint32(0x0);       // 11 1772 farm (0 - horde controlled, 1 - alliance controlled)
                data << uint32(0x6ed) << uint32(0x0);       // 12 1773 farm (show/hide)
                data << uint32(0x6ee) << uint32(0x0);       // 13 1774 farm color
                data << uint32(0x6ef) << uint32(0x0);       // 14 1775 gold mine color, may be FM?
                data << uint32(0x6f0) << uint32(0x0);       // 15 1776 alliance resources
                data << uint32(0x6f1) << uint32(0x0);       // 16 1777 horde resources
                data << uint32(0x6f2) << uint32(0x0);       // 17 1778 horde bases
                data << uint32(0x6f3) << uint32(0x0);       // 18 1779 alliance bases
                data << uint32(0x6f4) << uint32(0x7d0);     // 19 1780 max resources (2000)
                data << uint32(0x6f6) << uint32(0x0);       // 20 1782 blacksmith color
                data << uint32(0x6f7) << uint32(0x0);       // 21 1783 blacksmith (show/hide)
                data << uint32(0x6f8) << uint32(0x0);       // 22 1784 unk, bs?
                data << uint32(0x6f9) << uint32(0x0);       // 23 1785 unk, bs?
                data << uint32(0x6fb) << uint32(0x0);       // 24 1787 gold mine (0 - horde contr, 1 - alliance contr)
                data << uint32(0x6fc) << uint32(0x0);       // 25 1788 gold mine (0 - conflict, 1 - horde)
                data << uint32(0x6fd) << uint32(0x0);       // 26 1789 gold mine (1 - show/0 - hide)
                data << uint32(0x6fe) << uint32(0x0);       // 27 1790 gold mine color
                data << uint32(0x700) << uint32(0x0);       // 28 1792 gold mine color, wtf?, may be LM?
                data << uint32(0x701) << uint32(0x0);       // 29 1793 lumber mill color (0 - conflict, 1 - horde contr)
                data << uint32(0x702) << uint32(0x0);       // 30 1794 lumber mill (show/hide)
                data << uint32(0x703) << uint32(0x0);       // 31 1795 lumber mill color color
                data << uint32(0x732) << uint32(0x1);       // 32 1842 stables (1 - uncontrolled)
                data << uint32(0x733) << uint32(0x1);       // 33 1843 gold mine (1 - uncontrolled)
                data << uint32(0x734) << uint32(0x1);       // 34 1844 lumber mill (1 - uncontrolled)
                data << uint32(0x735) << uint32(0x1);       // 35 1845 farm (1 - uncontrolled)
                data << uint32(0x736) << uint32(0x1);       // 36 1846 blacksmith (1 - uncontrolled)
                data << uint32(0x745) << uint32(0x2);       // 37 1861 unk
                data << uint32(0x7a3) << uint32(0x708);     // 38 1955 warning limit (1800)
            }
            break;
        case 3820:                                          // EY
            if (bg && bg->GetTypeID() == BATTLEGROUND_EY)
                bg->FillInitialWorldStates(data);
            else
            {
                data << uint32(0xac1) << uint32(0x0);       // 7  2753 Horde Bases
                data << uint32(0xac0) << uint32(0x0);       // 8  2752 Alliance Bases
                data << uint32(0xab6) << uint32(0x0);       // 9  2742 Mage Tower - Horde conflict
                data << uint32(0xab5) << uint32(0x0);       // 10 2741 Mage Tower - Alliance conflict
                data << uint32(0xab4) << uint32(0x0);       // 11 2740 Fel Reaver - Horde conflict
                data << uint32(0xab3) << uint32(0x0);       // 12 2739 Fel Reaver - Alliance conflict
                data << uint32(0xab2) << uint32(0x0);       // 13 2738 Draenei - Alliance conflict
                data << uint32(0xab1) << uint32(0x0);       // 14 2737 Draenei - Horde conflict
                data << uint32(0xab0) << uint32(0x0);       // 15 2736 unk // 0 at start
                data << uint32(0xaaf) << uint32(0x0);       // 16 2735 unk // 0 at start
                data << uint32(0xaad) << uint32(0x0);       // 17 2733 Draenei - Horde control
                data << uint32(0xaac) << uint32(0x0);       // 18 2732 Draenei - Alliance control
                data << uint32(0xaab) << uint32(0x1);       // 19 2731 Draenei uncontrolled (1 - yes, 0 - no)
                data << uint32(0xaaa) << uint32(0x0);       // 20 2730 Mage Tower - Alliance control
                data << uint32(0xaa9) << uint32(0x0);       // 21 2729 Mage Tower - Horde control
                data << uint32(0xaa8) << uint32(0x1);       // 22 2728 Mage Tower uncontrolled (1 - yes, 0 - no)
                data << uint32(0xaa7) << uint32(0x0);       // 23 2727 Fel Reaver - Horde control
                data << uint32(0xaa6) << uint32(0x0);       // 24 2726 Fel Reaver - Alliance control
                data << uint32(0xaa5) << uint32(0x1);       // 25 2725 Fel Reaver uncontrolled (1 - yes, 0 - no)
                data << uint32(0xaa4) << uint32(0x0);       // 26 2724 Boold Elf - Horde control
                data << uint32(0xaa3) << uint32(0x0);       // 27 2723 Boold Elf - Alliance control
                data << uint32(0xaa2) << uint32(0x1);       // 28 2722 Boold Elf uncontrolled (1 - yes, 0 - no)
                data << uint32(0xac5) << uint32(0x1);       // 29 2757 Flag (1 - show, 0 - hide) - doesn't work exactly this way!
                data << uint32(0xad2) << uint32(0x1);       // 30 2770 Horde top-stats (1 - show, 0 - hide) // 02 -> horde picked up the flag
                data << uint32(0xad1) << uint32(0x1);       // 31 2769 Alliance top-stats (1 - show, 0 - hide) // 02 -> alliance picked up the flag
                data << uint32(0xabe) << uint32(0x0);       // 32 2750 Horde resources
                data << uint32(0xabd) << uint32(0x0);       // 33 2749 Alliance resources
                data << uint32(0xa05) << uint32(0x8e);      // 34 2565 unk, constant?
                data << uint32(0xaa0) << uint32(0x0);       // 35 2720 Capturing progress-bar (100 -> empty (only grey), 0 -> blue|red (no grey), default 0)
                data << uint32(0xa9f) << uint32(0x0);       // 36 2719 Capturing progress-bar (0 - left, 100 - right)
                data << uint32(0xa9e) << uint32(0x0);       // 37 2718 Capturing progress-bar (1 - show, 0 - hide)
                data << uint32(0xc0d) << uint32(0x17b);     // 38 3085 unk
                // and some more ... unknown
            }
            break;
        // any of these needs change! the client remembers the prev setting!
        // ON EVERY ZONE LEAVE, RESET THE OLD ZONE'S WORLD STATE, BUT AT LEAST THE UI STUFF!
        case 3483:                                          // Hellfire Peninsula
            {
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_HP)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x9ba) << uint32(0x1);           // 10 // add ally tower main gui icon       // maybe should be sent only on login?
                    data << uint32(0x9b9) << uint32(0x1);           // 11 // add horde tower main gui icon      // maybe should be sent only on login?
                    data << uint32(0x9b5) << uint32(0x0);           // 12 // show neutral broken hill icon      // 2485
                    data << uint32(0x9b4) << uint32(0x1);           // 13 // show icon above broken hill        // 2484
                    data << uint32(0x9b3) << uint32(0x0);           // 14 // show ally broken hill icon         // 2483
                    data << uint32(0x9b2) << uint32(0x0);           // 15 // show neutral overlook icon         // 2482
                    data << uint32(0x9b1) << uint32(0x1);           // 16 // show the overlook arrow            // 2481
                    data << uint32(0x9b0) << uint32(0x0);           // 17 // show ally overlook icon            // 2480
                    data << uint32(0x9ae) << uint32(0x0);           // 18 // horde pvp objectives captured      // 2478
                    data << uint32(0x9ac) << uint32(0x0);           // 19 // ally pvp objectives captured       // 2476
                    data << uint32(2475)  << uint32(100); //: ally / horde slider grey area                              // show only in direct vicinity!
                    data << uint32(2474)  << uint32(50);  //: ally / horde slider percentage, 100 for ally, 0 for horde  // show only in direct vicinity!
                    data << uint32(2473)  << uint32(0);   //: ally / horde slider display                                // show only in direct vicinity!
                    data << uint32(0x9a8) << uint32(0x0);           // 20 // show the neutral stadium icon      // 2472
                    data << uint32(0x9a7) << uint32(0x0);           // 21 // show the ally stadium icon         // 2471
                    data << uint32(0x9a6) << uint32(0x1);           // 22 // show the horde stadium icon        // 2470
                }
            }
            break;
        case 3518:
            {
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_NA)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(2503) << uint32(0x0);    // 10
                    data << uint32(2502) << uint32(0x0);    // 11
                    data << uint32(2493) << uint32(0x0);    // 12
                    data << uint32(2491) << uint32(0x0);    // 13

                    data << uint32(2495) << uint32(0x0);    // 14
                    data << uint32(2494) << uint32(0x0);    // 15
                    data << uint32(2497) << uint32(0x0);    // 16

                    data << uint32(2762) << uint32(0x0);    // 17
                    data << uint32(2662) << uint32(0x0);    // 18
                    data << uint32(2663) << uint32(0x0);    // 19
                    data << uint32(2664) << uint32(0x0);    // 20

                    data << uint32(2760) << uint32(0x0);    // 21
                    data << uint32(2670) << uint32(0x0);    // 22
                    data << uint32(2668) << uint32(0x0);    // 23
                    data << uint32(2669) << uint32(0x0);    // 24

                    data << uint32(2761) << uint32(0x0);    // 25
                    data << uint32(2667) << uint32(0x0);    // 26
                    data << uint32(2665) << uint32(0x0);    // 27
                    data << uint32(2666) << uint32(0x0);    // 28

                    data << uint32(2763) << uint32(0x0);    // 29
                    data << uint32(2659) << uint32(0x0);    // 30
                    data << uint32(2660) << uint32(0x0);    // 31
                    data << uint32(2661) << uint32(0x0);    // 32

                    data << uint32(2671) << uint32(0x0);    // 33
                    data << uint32(2676) << uint32(0x0);    // 34
                    data << uint32(2677) << uint32(0x0);    // 35
                    data << uint32(2672) << uint32(0x0);    // 36
                    data << uint32(2673) << uint32(0x0);    // 37
                }
            }
            break;
        case 3519:                                          // Terokkar Forest
            {
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_TF)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0xa41) << uint32(0x0);           // 10 // 2625 capture bar pos
                    data << uint32(0xa40) << uint32(0x14);          // 11 // 2624 capture bar neutral
                    data << uint32(0xa3f) << uint32(0x0);           // 12 // 2623 show capture bar
                    data << uint32(0xa3e) << uint32(0x0);           // 13 // 2622 horde towers controlled
                    data << uint32(0xa3d) << uint32(0x5);           // 14 // 2621 ally towers controlled
                    data << uint32(0xa3c) << uint32(0x0);           // 15 // 2620 show towers controlled
                    data << uint32(0xa88) << uint32(0x0);           // 16 // 2696 SE Neu
                    data << uint32(0xa87) << uint32(0x0);           // 17 // SE Horde
                    data << uint32(0xa86) << uint32(0x0);           // 18 // SE Ally
                    data << uint32(0xa85) << uint32(0x0);           // 19 //S Neu
                    data << uint32(0xa84) << uint32(0x0);           // 20 S Horde
                    data << uint32(0xa83) << uint32(0x0);           // 21 S Ally
                    data << uint32(0xa82) << uint32(0x0);           // 22 NE Neu
                    data << uint32(0xa81) << uint32(0x0);           // 23 NE Horde
                    data << uint32(0xa80) << uint32(0x0);           // 24 NE Ally
                    data << uint32(0xa7e) << uint32(0x0);           // 25 // 2686 N Neu
                    data << uint32(0xa7d) << uint32(0x0);           // 26 N Horde
                    data << uint32(0xa7c) << uint32(0x0);           // 27 N Ally
                    data << uint32(0xa7b) << uint32(0x0);           // 28 NW Ally
                    data << uint32(0xa7a) << uint32(0x0);           // 29 NW Horde
                    data << uint32(0xa79) << uint32(0x0);           // 30 NW Neutral
                    data << uint32(0x9d0) << uint32(0x5);           // 31 // 2512 locked time remaining seconds first digit
                    data << uint32(0x9ce) << uint32(0x0);           // 32 // 2510 locked time remaining seconds second digit
                    data << uint32(0x9cd) << uint32(0x0);           // 33 // 2509 locked time remaining minutes
                    data << uint32(0x9cc) << uint32(0x0);           // 34 // 2508 neutral locked time show
                    data << uint32(0xad0) << uint32(0x0);           // 35 // 2768 horde locked time show
                    data << uint32(0xacf) << uint32(0x1);           // 36 // 2767 ally locked time show
                }
            }
            break;
        case 3521:                                          // Zangarmarsh
            {
                if (pvp && pvp->GetTypeId() == OUTDOOR_PVP_ZM)
                    pvp->FillInitialWorldStates(data);
                else
                {
                    data << uint32(0x9e1) << uint32(0x0);           // 10 //2529
                    data << uint32(0x9e0) << uint32(0x0);           // 11
                    data << uint32(0x9df) << uint32(0x0);           // 12
                    data << uint32(0xa5d) << uint32(0x1);           // 13 //2653
                    data << uint32(0xa5c) << uint32(0x0);           // 14 //2652 east beacon neutral
                    data << uint32(0xa5b) << uint32(0x1);           // 15 horde
                    data << uint32(0xa5a) << uint32(0x0);           // 16 ally
                    data << uint32(0xa59) << uint32(0x1);           // 17 // 2649 Twin spire graveyard horde  12???
                    data << uint32(0xa58) << uint32(0x0);           // 18 ally     14 ???
                    data << uint32(0xa57) << uint32(0x0);           // 19 neutral  7???
                    data << uint32(0xa56) << uint32(0x0);           // 20 // 2646 west beacon neutral
                    data << uint32(0xa55) << uint32(0x1);           // 21 horde
                    data << uint32(0xa54) << uint32(0x0);           // 22 ally
                    data << uint32(0x9e7) << uint32(0x0);           // 23 // 2535
                    data << uint32(0x9e6) << uint32(0x0);           // 24
                    data << uint32(0x9e5) << uint32(0x0);           // 25
                    data << uint32(0xa00) << uint32(0x0);           // 26 // 2560
                    data << uint32(0x9ff) << uint32(0x1);           // 27
                    data << uint32(0x9fe) << uint32(0x0);           // 28
                    data << uint32(0x9fd) << uint32(0x0);           // 29
                    data << uint32(0x9fc) << uint32(0x1);           // 30
                    data << uint32(0x9fb) << uint32(0x0);           // 31
                    data << uint32(0xa62) << uint32(0x0);           // 32 // 2658
                    data << uint32(0xa61) << uint32(0x1);           // 33
                    data << uint32(0xa60) << uint32(0x1);           // 34
                    data << uint32(0xa5f) << uint32(0x0);           // 35
                }
            }
            break;
        case 3698:                                          // Nagrand Arena
            if (bg && bg->GetTypeID() == BATTLEGROUND_NA)
                bg->FillInitialWorldStates(data);
            else
            {
                data << uint32(0xa0f) << uint32(0x0);           // 7
                data << uint32(0xa10) << uint32(0x0);           // 8
                data << uint32(0xa11) << uint32(0x0);           // 9 show
            }
            break;
        case 3702:                                          // Blade's Edge Arena
            if (bg && bg->GetTypeID() == BATTLEGROUND_BE)
                bg->FillInitialWorldStates(data);
            else
            {
                data << uint32(0x9f0) << uint32(0x0);           // 7 gold
                data << uint32(0x9f1) << uint32(0x0);           // 8 green
                data << uint32(0x9f3) << uint32(0x0);           // 9 show
            }
            break;
        case 3968:                                          // Ruins of Lordaeron
            if (bg && bg->GetTypeID() == BATTLEGROUND_RL)
                bg->FillInitialWorldStates(data);
            else
            {
                data << uint32(0xbb8) << uint32(0x0);           // 7 gold
                data << uint32(0xbb9) << uint32(0x0);           // 8 green
                data << uint32(0xbba) << uint32(0x0);           // 9 show
            }
            break;
        case 3703:                                          // Shattrath City
            break;
        default:
            data << uint32(0x914) << uint32(0x0);           // 7
            data << uint32(0x913) << uint32(0x0);           // 8
            data << uint32(0x912) << uint32(0x0);           // 9
            data << uint32(0x915) << uint32(0x0);           // 10
            break;
    }
    SendPacketToSelf(&data);
}

uint32 Player::GetXPRestBonus(uint32 xp)
{
    uint32 rested_bonus = (uint32)GetRestBonus();           // xp for each rested bonus

    if (rested_bonus > xp)                                   // max rested_bonus == xp or (r+x) = 200% xp
        rested_bonus = xp;

    SetRestBonus(GetRestBonus() - rested_bonus);

    sLog.outDetail("Player gain %u xp (+ %u Rested Bonus). Rested points=%f",xp+rested_bonus,rested_bonus,GetRestBonus());
    return rested_bonus;
}

void Player::SetBindPoint(uint64 guid)
{
    WorldPacket data(SMSG_BINDER_CONFIRM, 8);
    data << uint64(guid);
    SendPacketToSelf(&data);
}

void Player::SendTalentWipeConfirm(uint64 guid)
{
    WorldPacket data(MSG_TALENT_WIPE_CONFIRM, (8+4));
    data << uint64(guid);
    uint32 cost = sWorld.getConfig(CONFIG_NO_RESET_TALENT_COST) ? 0 : resetTalentsCost();
    data << cost;
    SendPacketToSelf(&data);
}

void Player::SendPetSkillWipeConfirm()
{
    Pet* pet = GetPet();
    if (!pet)
        return;
    WorldPacket data(SMSG_PET_UNLEARN_CONFIRM, (8+4));
    data << pet->GetGUID();
    data << uint32(pet->resetTalentsCost());
    SendPacketToSelf(&data);
}

/*********************************************************/
/***                    STORAGE SYSTEM                 ***/
/*********************************************************/

void Player::SetVirtualItemSlot(uint8 i, Item* item)
{
    ASSERT(i < 3);
    if (i < 2 && item)
    {
        if (!item->GetEnchantmentId(TEMP_ENCHANTMENT_SLOT))
            return;
        uint32 charges = item->GetEnchantmentCharges(TEMP_ENCHANTMENT_SLOT);
        if (charges == 0)
            return;
        if (charges > 1)
            item->SetEnchantmentCharges(TEMP_ENCHANTMENT_SLOT,charges-1);
        else if (charges <= 1)
        {
            ApplyEnchantment(item,TEMP_ENCHANTMENT_SLOT,false);
            item->ClearEnchantment(TEMP_ENCHANTMENT_SLOT);
        }
    }
}

void Player::SetSheath(uint32 sheathed)
{
    switch (sheathed)
    {
        case SHEATH_STATE_UNARMED:                          // no prepared weapon
            SetVirtualItemSlot(0,NULL);
            SetVirtualItemSlot(1,NULL);
            SetVirtualItemSlot(2,NULL);
            break;
        case SHEATH_STATE_MELEE:                            // prepared melee weapon
        {
            SetVirtualItemSlot(0,GetWeaponForAttack(BASE_ATTACK,true));
            SetVirtualItemSlot(1,GetWeaponForAttack(OFF_ATTACK,true));
            SetVirtualItemSlot(2,NULL);
        };  break;
        case SHEATH_STATE_RANGED:                           // prepared ranged weapon
            SetVirtualItemSlot(0,NULL);
            SetVirtualItemSlot(1,NULL);
            SetVirtualItemSlot(2,GetWeaponForAttack(RANGED_ATTACK,true));
            break;
        default:
            SetVirtualItemSlot(0,NULL);
            SetVirtualItemSlot(1,NULL);
            SetVirtualItemSlot(2,NULL);
            break;
    }
    SetByteValue(UNIT_FIELD_BYTES_2, 0, sheathed);          // this must visualize Sheath changing for other players...
}

uint8 Player::FindEquipSlot(ItemPrototype const* proto, uint32 slot, bool swap) const
{
    uint8 pClass = getClass();

    uint8 slots[4];
    slots[0] = NULL_SLOT;
    slots[1] = NULL_SLOT;
    slots[2] = NULL_SLOT;
    slots[3] = NULL_SLOT;
    switch (proto->InventoryType)
    {
        case INVTYPE_HEAD:
            slots[0] = EQUIPMENT_SLOT_HEAD;
            break;
        case INVTYPE_NECK:
            slots[0] = EQUIPMENT_SLOT_NECK;
            break;
        case INVTYPE_SHOULDERS:
            slots[0] = EQUIPMENT_SLOT_SHOULDERS;
            break;
        case INVTYPE_BODY:
            slots[0] = EQUIPMENT_SLOT_BODY;
            break;
        case INVTYPE_CHEST:
            slots[0] = EQUIPMENT_SLOT_CHEST;
            break;
        case INVTYPE_ROBE:
            slots[0] = EQUIPMENT_SLOT_CHEST;
            break;
        case INVTYPE_WAIST:
            slots[0] = EQUIPMENT_SLOT_WAIST;
            break;
        case INVTYPE_LEGS:
            slots[0] = EQUIPMENT_SLOT_LEGS;
            break;
        case INVTYPE_FEET:
            slots[0] = EQUIPMENT_SLOT_FEET;
            break;
        case INVTYPE_WRISTS:
            slots[0] = EQUIPMENT_SLOT_WRISTS;
            break;
        case INVTYPE_HANDS:
            slots[0] = EQUIPMENT_SLOT_HANDS;
            break;
        case INVTYPE_FINGER:
            slots[0] = EQUIPMENT_SLOT_FINGER1;
            slots[1] = EQUIPMENT_SLOT_FINGER2;
            break;
        case INVTYPE_TRINKET:
            slots[0] = EQUIPMENT_SLOT_TRINKET1;
            slots[1] = EQUIPMENT_SLOT_TRINKET2;
            break;
        case INVTYPE_CLOAK:
            slots[0] =  EQUIPMENT_SLOT_BACK;
            break;
        case INVTYPE_WEAPON:
        {
            slots[0] = EQUIPMENT_SLOT_MAINHAND;

            // suggest offhand slot only if know dual wielding
            // (this will be replace mainhand weapon at auto equip instead unwonted "you don't known dual wielding" ...
            if (CanDualWield())
                slots[1] = EQUIPMENT_SLOT_OFFHAND;
        };break;
        case INVTYPE_SHIELD:
            slots[0] = EQUIPMENT_SLOT_OFFHAND;
            break;
        case INVTYPE_RANGED:
            slots[0] = EQUIPMENT_SLOT_RANGED;
            break;
        case INVTYPE_2HWEAPON:
            slots[0] = EQUIPMENT_SLOT_MAINHAND;
            break;
        case INVTYPE_TABARD:
            slots[0] = EQUIPMENT_SLOT_TABARD;
            break;
        case INVTYPE_WEAPONMAINHAND:
            slots[0] = EQUIPMENT_SLOT_MAINHAND;
            break;
        case INVTYPE_WEAPONOFFHAND:
            slots[0] = EQUIPMENT_SLOT_OFFHAND;
            break;
        case INVTYPE_HOLDABLE:
            slots[0] = EQUIPMENT_SLOT_OFFHAND;
            break;
        case INVTYPE_THROWN:
            slots[0] = EQUIPMENT_SLOT_RANGED;
            break;
        case INVTYPE_RANGEDRIGHT:
            slots[0] = EQUIPMENT_SLOT_RANGED;
            break;
        case INVTYPE_BAG:
            slots[0] = INVENTORY_SLOT_BAG_1;
            slots[1] = INVENTORY_SLOT_BAG_2;
            slots[2] = INVENTORY_SLOT_BAG_3;
            slots[3] = INVENTORY_SLOT_BAG_4;
            break;
        case INVTYPE_RELIC:
        {
            switch (proto->SubClass)
            {
                case ITEM_SUBCLASS_ARMOR_LIBRAM:
                    if (pClass == CLASS_PALADIN)
                        slots[0] = EQUIPMENT_SLOT_RANGED;
                    break;
                case ITEM_SUBCLASS_ARMOR_IDOL:
                    if (pClass == CLASS_DRUID)
                        slots[0] = EQUIPMENT_SLOT_RANGED;
                    break;
                case ITEM_SUBCLASS_ARMOR_TOTEM:
                    if (pClass == CLASS_SHAMAN)
                        slots[0] = EQUIPMENT_SLOT_RANGED;
                    break;
                case ITEM_SUBCLASS_ARMOR_MISC:
                    if (pClass == CLASS_WARLOCK)
                        slots[0] = EQUIPMENT_SLOT_RANGED;
                    break;
            }
            break;
        }
        default :
            return NULL_SLOT;
    }

    if (slot != NULL_SLOT)
    {
        if (swap || !GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
        {
            for (int i = 0; i < 4; i++)
            {
                if (slots[i] == slot)
                    return slot;
            }
        }
    }
    else
    {
        // search free slot at first
        for (int i = 0; i < 4; i++)
        {
            if (slots[i] != NULL_SLOT && !GetItemByPos(INVENTORY_SLOT_BAG_0, slots[i]))
            {
                // in case 2hand equipped weapon offhand slot empty but not free
                if (slots[i]==EQUIPMENT_SLOT_OFFHAND)
                {
                    Item* mainItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
                    if (!mainItem || mainItem->GetProto()->InventoryType != INVTYPE_2HWEAPON)
                        return slots[i];
                }
                else
                    return slots[i];
            }
        }

        // if not found free and can swap return first appropriate from used
        for (int i = 0; i < 4; i++)
        {
            if (slots[i] != NULL_SLOT && swap)
                return slots[i];
        }
    }

    // no free position
    return NULL_SLOT;
}

uint8 Player::CanUnequipItems(uint32 item, uint32 count) const
{
    Item *pItem;
    uint32 tempcount = 0;

    uint8 res = EQUIP_ERR_OK;

    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
        {
            uint8 ires = CanUnequipItem(INVENTORY_SLOT_BAG_0 << 8 | i, false);
            if (ires==EQUIP_ERR_OK)
            {
                tempcount += pItem->GetCount();
                if (tempcount >= count)
                    return EQUIP_ERR_OK;
            }
            else
                res = ires;
        }
    }
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
        {
            tempcount += pItem->GetCount();
            if (tempcount >= count)
                return EQUIP_ERR_OK;
        }
    }
    for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
    {
        pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
        {
            tempcount += pItem->GetCount();
            if (tempcount >= count)
                return EQUIP_ERR_OK;
        }
    }
    Bag *pBag;
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pBag)
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                pItem = GetItemByPos(i, j);
                if (pItem && pItem->GetEntry() == item)
                {
                    tempcount += pItem->GetCount();
                    if (tempcount >= count)
                        return EQUIP_ERR_OK;
                }
            }
        }
    }

    // not found req. item count and have unequippable items
    return res;
}

uint32 Player::GetItemCount(uint32 item, bool inBankAlso, Item* skipItem) const
{
    uint32 count = 0;
    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem != skipItem &&  pItem->GetEntry() == item)
            count += pItem->GetCount();
    }
    for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem != skipItem && pItem->GetEntry() == item)
            count += pItem->GetCount();
    }
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pBag)
            count += pBag->GetItemCount(item,skipItem);
    }

    if (skipItem && skipItem->GetProto()->GemProperties)
    {
        for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
        {
            Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem != skipItem && pItem->GetProto()->Socket[0].Color)
                count += pItem->GetGemCountWithID(item);
        }
    }

    if (inBankAlso)
    {
        for (int i = BANK_SLOT_ITEM_START; i < BANK_SLOT_BAG_END; i++)
        {
            Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem != skipItem && pItem->GetEntry() == item)
                count += pItem->GetCount();
        }
        for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pBag)
                count += pBag->GetItemCount(item,skipItem);
        }

        if (skipItem && skipItem->GetProto()->GemProperties)
        {
            for (int i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; i++)
            {
                Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
                if (pItem && pItem != skipItem && pItem->GetProto()->Socket[0].Color)
                    count += pItem->GetGemCountWithID(item);
            }
        }
    }

    return count;
}

Item* Player::GetItemByGuid(uint64 guid) const
{
    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetGUID() == guid)
            return pItem;
    }
    for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetGUID() == guid)
            return pItem;
    }

    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        Bag *pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pBag)
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                Item* pItem = pBag->GetItemByPos(j);
                if (pItem && pItem->GetGUID() == guid)
                    return pItem;
            }
        }
    }
    for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
    {
        Bag *pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pBag)
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                Item* pItem = pBag->GetItemByPos(j);
                if (pItem && pItem->GetGUID() == guid)
                    return pItem;
            }
        }
    }

    return NULL;
}

Item* Player::GetItemByPos(uint16 pos) const
{
    uint8 bag = pos >> 8;
    uint8 slot = pos & 255;
    return GetItemByPos(bag, slot);
}

Item* Player::GetItemByPos(uint8 bag, uint8 slot) const
{
    if (bag == INVENTORY_SLOT_BAG_0 && (slot < BANK_SLOT_BAG_END || slot >= KEYRING_SLOT_START && slot < KEYRING_SLOT_END))
        return m_items[slot];
    else if (bag >= INVENTORY_SLOT_BAG_START && bag < INVENTORY_SLOT_BAG_END
        || bag >= BANK_SLOT_BAG_START && bag < BANK_SLOT_BAG_END)
    {
        Bag *pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, bag);
        if (pBag)
            return pBag->GetItemByPos(slot);
    }
    return NULL;
}

uint32 Player::GetItemDisplayIdInSlot(uint8 bag, uint8 slot) const
{
    const Item* pItem = GetItemByPos(bag, slot);

    if (!pItem)
        return 0;

    return pItem->GetProto()->DisplayInfoID;
}

Item* Player::GetWeaponForAttack(WeaponAttackType attackType, bool useable) const
{
    uint16 slot;
    switch (attackType)
    {
        case BASE_ATTACK:   slot = EQUIPMENT_SLOT_MAINHAND; break;
        case OFF_ATTACK:    slot = EQUIPMENT_SLOT_OFFHAND;  break;
        case RANGED_ATTACK: slot = EQUIPMENT_SLOT_RANGED;   break;
        default: return NULL;
    }

    Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
    if (!item || item->GetProto()->Class != ITEM_CLASS_WEAPON)
        return NULL;

    if (!useable)
        return item;

    if (item->IsBroken() || !IsUseEquipedWeapon(attackType==BASE_ATTACK))
        return NULL;

    return item;
}

Item* Player::GetShield(bool useable) const
{
    Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
    if (!item || item->GetProto()->Class != ITEM_CLASS_ARMOR)
        return NULL;

    if (!useable)
        return item;

    if (item->IsBroken())
        return NULL;

    return item;
}

uint32 Player::GetAttackBySlot(uint8 slot)
{
    switch (slot)
    {
        case EQUIPMENT_SLOT_MAINHAND: return BASE_ATTACK;
        case EQUIPMENT_SLOT_OFFHAND:  return OFF_ATTACK;
        case EQUIPMENT_SLOT_RANGED:   return RANGED_ATTACK;
        default:                      return MAX_ATTACK;
    }
}

bool Player::HasBankBagSlot(uint8 slot) const
{
    uint32 maxslot = GetByteValue(PLAYER_BYTES_2, 2) + BANK_SLOT_BAG_START;
    if (slot < maxslot)
        return true;
    return false;
}

bool Player::IsInventoryPos(uint8 bag, uint8 slot)
{
    if (bag == INVENTORY_SLOT_BAG_0 && slot == NULL_SLOT)
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= INVENTORY_SLOT_ITEM_START && slot < INVENTORY_SLOT_ITEM_END))
        return true;
    if (bag >= INVENTORY_SLOT_BAG_START && bag < INVENTORY_SLOT_BAG_END)
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= KEYRING_SLOT_START && slot < KEYRING_SLOT_END))
        return true;
    return false;
}

bool Player::IsEquipmentPos(uint8 bag, uint8 slot)
{
    if (bag == INVENTORY_SLOT_BAG_0 && (slot < EQUIPMENT_SLOT_END))
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= INVENTORY_SLOT_BAG_START && slot < INVENTORY_SLOT_BAG_END))
        return true;
    return false;
}

bool Player::IsBankPos(uint8 bag, uint8 slot)
{
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= BANK_SLOT_ITEM_START && slot < BANK_SLOT_ITEM_END))
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END))
        return true;
    if (bag >= BANK_SLOT_BAG_START && bag < BANK_SLOT_BAG_END)
        return true;
    return false;
}

bool Player::IsBagPos(uint16 pos)
{
    uint8 bag = pos >> 8;
    uint8 slot = pos & 255;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= INVENTORY_SLOT_BAG_START && slot < INVENTORY_SLOT_BAG_END))
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END))
        return true;
    return false;
}

bool Player::IsValidPos(uint8 bag, uint8 slot) const
{
    // post selected
    if (bag == NULL_BAG)
        return true;

    if (bag == INVENTORY_SLOT_BAG_0)
    {
        // any post selected
        if (slot == NULL_SLOT)
            return true;

        // equipment
        if (slot < EQUIPMENT_SLOT_END)
            return true;

        // bag equip slots
        if (slot >= INVENTORY_SLOT_BAG_START && slot < INVENTORY_SLOT_BAG_END)
            return true;

        // backpack slots
        if (slot >= INVENTORY_SLOT_ITEM_START && slot < INVENTORY_SLOT_ITEM_END)
            return true;

        // keyring slots
        if (slot >= KEYRING_SLOT_START && slot < KEYRING_SLOT_END)
            return true;

        // bank main slots
        if (slot >= BANK_SLOT_ITEM_START && slot < BANK_SLOT_ITEM_END)
            return true;

        // bank bag slots
        if (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END)
            return true;

        return false;
    }

    // bag content slots
    if (bag >= INVENTORY_SLOT_BAG_START && bag < INVENTORY_SLOT_BAG_END)
    {
        Bag* pBag = (Bag*)GetItemByPos (INVENTORY_SLOT_BAG_0, bag);
        if (!pBag)
            return false;

        // any post selected
        if (slot == NULL_SLOT)
            return true;

        return slot < pBag->GetBagSize();
    }

    // bank bag content slots
    if (bag >= BANK_SLOT_BAG_START && bag < BANK_SLOT_BAG_END)
    {
        Bag* pBag = (Bag*)GetItemByPos (INVENTORY_SLOT_BAG_0, bag);
        if (!pBag)
            return false;

        // any post selected
        if (slot == NULL_SLOT)
            return true;

        return slot < pBag->GetBagSize();
    }

    // where this?
    return false;
}

Item * Player::HasEquiped(uint32 item) const
{
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
            return pItem;
    }

    return NULL;
}

bool Player::HasItemCount(uint32 item, uint32 count, bool inBankAlso) const
{
    uint32 tempcount = 0;
    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
        {
            tempcount += pItem->GetCount();
            if (tempcount >= count)
                return true;
        }
    }
    for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
        {
            tempcount += pItem->GetCount();
            if (tempcount >= count)
                return true;
        }
    }
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                Item* pItem = GetItemByPos(i, j);
                if (pItem && pItem->GetEntry() == item)
                {
                    tempcount += pItem->GetCount();
                    if (tempcount >= count)
                        return true;
                }
            }
        }
    }

    if (inBankAlso)
    {
        for (int i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; i++)
        {
            Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem->GetEntry() == item)
            {
                tempcount += pItem->GetCount();
                if (tempcount >= count)
                    return true;
            }
        }
        for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            if (Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                {
                    Item* pItem = GetItemByPos(i, j);
                    if (pItem && pItem->GetEntry() == item)
                    {
                        tempcount += pItem->GetCount();
                        if (tempcount >= count)
                            return true;
                    }
                }
            }
        }
    }

    return false;
}

Item* Player::GetItemOrItemWithGemEquipped(uint32 item) const
{
    Item *pItem;
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
    {
        pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
            return pItem;
    }

    ItemPrototype const *pProto = ObjectMgr::GetItemPrototype(item);
    if (pProto && pProto->GemProperties)
    {
        for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
        {
            pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem->GetProto()->Socket[0].Color)
            {
                if (pItem->GetGemCountWithID(item) > 0)
                    return pItem;
            }
        }
    }

    return NULL;
}

uint8 Player::_CanTakeMoreSimilarItems(uint32 entry, uint32 count, Item* pItem, uint32* no_space_count) const
{
    ItemPrototype const *pProto = ObjectMgr::GetItemPrototype(entry);
    if (!pProto)
    {
        if (no_space_count)
            *no_space_count = count;
        return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
    }

    // no maximum
    if (pProto->MaxCount == 0)
        return EQUIP_ERR_OK;

    uint32 curcount = GetItemCount(pProto->ItemId,true,pItem);

    if (curcount + count > pProto->MaxCount)
    {
        if (no_space_count)
            *no_space_count = count +curcount - pProto->MaxCount;
        return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
    }

    return EQUIP_ERR_OK;
}

bool Player::HasItemTotemCategory(uint32 TotemCategory) const
{
    Item *pItem;
    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; ++i)
    {
        pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && IsTotemCategoryCompatiableWith(pItem->GetProto()->TotemCategory,TotemCategory))
            return true;
    }
    for (uint8 i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; ++i)
    {
        pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && IsTotemCategoryCompatiableWith(pItem->GetProto()->TotemCategory,TotemCategory))
            return true;
    }
    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
    {
        if (Bag *pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
            {
                pItem = GetItemByPos(i, j);
                if (pItem && IsTotemCategoryCompatiableWith(pItem->GetProto()->TotemCategory,TotemCategory))
                    return true;
            }
        }
    }
    return false;
}

uint8 Player::_CanStoreItem_InSpecificSlot(uint8 bag, uint8 slot, ItemPosCountVec &dest, ItemPrototype const *pProto, uint32& count, bool swap, Item* pSrcItem) const
{
    Item* pItem2 = GetItemByPos(bag, slot);

    // ignore move item (this slot will be empty at move)
    if (pItem2==pSrcItem)
        pItem2 = NULL;

    uint32 need_space;

    if (pSrcItem && pSrcItem->IsBag() && !((Bag*)pSrcItem)->IsEmpty() && !IsBagPos(uint16(bag) << 8 | slot))
        return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

    // empty specific slot - check item fit to slot
    if (!pItem2 || swap)
    {
        if (bag == INVENTORY_SLOT_BAG_0)
        {
            // keyring case
            if (slot >= KEYRING_SLOT_START && slot < KEYRING_SLOT_START+GetMaxKeyringSize() && !(pProto->BagFamily & BAG_FAMILY_MASK_KEYS))
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

            // prevent cheating
            if (slot >= BUYBACK_SLOT_START && slot < BUYBACK_SLOT_END || slot >= PLAYER_SLOT_END)
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;
        }
        else
        {
            Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, bag);
            if (!pBag)
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

            ItemPrototype const* pBagProto = pBag->GetProto();
            if (!pBagProto)
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

            if (slot >= pBagProto->ContainerSlots)
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

            if (!ItemCanGoIntoBag(pProto,pBagProto))
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;
        }

        // non empty stack with space
        need_space = pProto->Stackable;
    }
    // non empty slot, check item type
    else
    {
        // check item type
        if (pItem2->GetEntry() != pProto->ItemId)
            return EQUIP_ERR_ITEM_CANT_STACK;

        // check free space
        if (pItem2->GetCount() >= pProto->Stackable)
            return EQUIP_ERR_ITEM_CANT_STACK;

        need_space = pProto->Stackable - pItem2->GetCount();
    }

    if (need_space > count)
        need_space = count;

    ItemPosCount newPosition = ItemPosCount((bag << 8) | slot, need_space);
    if (!newPosition.isContainedIn(dest))
    {
        dest.push_back(newPosition);
        count -= need_space;
    }
    return EQUIP_ERR_OK;
}

uint8 Player::_CanStoreItem_InBag(uint8 bag, ItemPosCountVec &dest, ItemPrototype const *pProto, uint32& count, bool merge, bool non_specialized, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const
{
    // skip specific bag already processed in first called _CanStoreItem_InBag
    if (bag==skip_bag)
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, bag);
    if (!pBag || pBag==pSrcItem)
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    if (pSrcItem && pSrcItem->IsBag() && !((Bag*)pSrcItem)->IsEmpty())
        return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

    ItemPrototype const* pBagProto = pBag->GetProto();
    if (!pBagProto)
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    // specialized bag mode or non-specilized
    if (non_specialized != (pBagProto->Class == ITEM_CLASS_CONTAINER && pBagProto->SubClass == ITEM_SUBCLASS_CONTAINER))
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    if (!ItemCanGoIntoBag(pProto,pBagProto))
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    for (uint32 j = 0; j < pBag->GetBagSize(); j++)
    {
        // skip specific slot already processed in first called _CanStoreItem_InSpecificSlot
        if (j==skip_slot)
            continue;

        Item* pItem2 = GetItemByPos(bag, j);

        // ignore move item (this slot will be empty at move)
        if (pItem2==pSrcItem)
            pItem2 = NULL;

        // if merge skip empty, if !merge skip non-empty
        if ((pItem2!=NULL)!=merge)
            continue;

        if (pItem2)
        {
            if (pItem2->GetEntry() == pProto->ItemId && pItem2->GetCount() < pProto->Stackable)
            {
                uint32 need_space = pProto->Stackable - pItem2->GetCount();
                if (need_space > count)
                    need_space = count;

                ItemPosCount newPosition = ItemPosCount((bag << 8) | j, need_space);
                if (!newPosition.isContainedIn(dest))
                {
                    dest.push_back(newPosition);
                    count -= need_space;

                    if (count==0)
                        return EQUIP_ERR_OK;
                }
            }
        }
        else
        {
            uint32 need_space = pProto->Stackable;
            if (need_space > count)
                need_space = count;

            ItemPosCount newPosition = ItemPosCount((bag << 8) | j, need_space);
            if (!newPosition.isContainedIn(dest))
            {
                dest.push_back(newPosition);
                count -= need_space;

                if (count==0)
                    return EQUIP_ERR_OK;
            }
        }
    }
    return EQUIP_ERR_OK;
}

uint8 Player::_CanStoreItem_InInventorySlots(uint8 slot_begin, uint8 slot_end, ItemPosCountVec &dest, ItemPrototype const *pProto, uint32& count, bool merge, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const
{
    // this is never called for non-bag slots so we can do this
    if (pSrcItem && pSrcItem->IsBag() && !((Bag*)pSrcItem)->IsEmpty())
        return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

    for (uint32 j = slot_begin; j < slot_end; j++)
    {
        // skip specific slot already processed in first called _CanStoreItem_InSpecificSlot
        if (INVENTORY_SLOT_BAG_0==skip_bag && j==skip_slot)
            continue;

        Item* pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, j);

        // ignore move item (this slot will be empty at move)
        if (pItem2==pSrcItem)
            pItem2 = NULL;

        // if merge skip empty, if !merge skip non-empty
        if ((pItem2!=NULL)!=merge)
            continue;

        if (pItem2)
        {
            if (pItem2->GetEntry() == pProto->ItemId && pItem2->GetCount() < pProto->Stackable)
            {
                uint32 need_space = pProto->Stackable - pItem2->GetCount();
                if (need_space > count)
                    need_space = count;
                ItemPosCount newPosition = ItemPosCount((INVENTORY_SLOT_BAG_0 << 8) | j, need_space);
                if (!newPosition.isContainedIn(dest))
                {
                    dest.push_back(newPosition);
                    count -= need_space;

                    if (count==0)
                        return EQUIP_ERR_OK;
                }
            }
        }
        else
        {
            uint32 need_space = pProto->Stackable;
            if (need_space > count)
                need_space = count;

            ItemPosCount newPosition = ItemPosCount((INVENTORY_SLOT_BAG_0 << 8) | j, need_space);
            if (!newPosition.isContainedIn(dest))
            {
                dest.push_back(newPosition);
                count -= need_space;

                if (count==0)
                    return EQUIP_ERR_OK;
            }
        }
    }
    return EQUIP_ERR_OK;
}

uint8 Player::_CanStoreItem(uint8 bag, uint8 slot, ItemPosCountVec &dest, uint32 entry, uint32 count, Item *pItem, bool swap, uint32* no_space_count) const
{
    sLog.outDebug("STORAGE: CanStoreItem bag = %u, slot = %u, item = %u, count = %u", bag, slot, entry, count);

    ItemPrototype const *pProto = ObjectMgr::GetItemPrototype(entry);
    if (!pProto)
    {
        if (no_space_count)
            *no_space_count = count;
        return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED :EQUIP_ERR_ITEM_NOT_FOUND;
    }

    if (pItem && pItem->IsBindedNotWith(GetGUID()))
    {
        if (no_space_count)
            *no_space_count = count;
        return EQUIP_ERR_DONT_OWN_THAT_ITEM;
    }

    // check count of items (skip for auto move for same player from bank)
    uint32 no_similar_count = 0;                            // can't store this amount similar items
    uint8 res = _CanTakeMoreSimilarItems(entry,count,pItem,&no_similar_count);
    if (res!=EQUIP_ERR_OK)
    {
        if (count==no_similar_count)
        {
            if (no_space_count)
                *no_space_count = no_similar_count;
            return res;
        }
        count -= no_similar_count;
    }

    // in specific slot
    if (bag != NULL_BAG && slot != NULL_SLOT)
    {
        if (!IsValidPos(bag, slot))
            return EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT;
        res = _CanStoreItem_InSpecificSlot(bag,slot,dest,pProto,count,swap,pItem);
        if (res!=EQUIP_ERR_OK)
        {
            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return res;
        }

        if (count==0)
        {
            if (no_similar_count==0)
                return EQUIP_ERR_OK;

            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
        }
    }

    // not specific slot or have space for partly store only in specific slot

    // in specific bag
    if (bag != NULL_BAG)
    {
        // search stack in bag for merge to
        if (pProto->Stackable > 1)
        {
            if (bag == INVENTORY_SLOT_BAG_0)               // inventory
            {
                res = _CanStoreItem_InInventorySlots(KEYRING_SLOT_START,KEYRING_SLOT_END,dest,pProto,count,true,pItem,bag,slot);
                if (res!=EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count==0)
                {
                    if (no_similar_count==0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }

                res = _CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START,INVENTORY_SLOT_ITEM_END,dest,pProto,count,true,pItem,bag,slot);
                if (res!=EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count==0)
                {
                    if (no_similar_count==0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }
            }
            else                                            // equipped bag
            {
                // we need check 2 time (specialized/non_specialized), use NULL_BAG to prevent skipping bag
                res = _CanStoreItem_InBag(bag,dest,pProto,count,true,false,pItem,NULL_BAG,slot);
                if (res!=EQUIP_ERR_OK)
                    res = _CanStoreItem_InBag(bag,dest,pProto,count,true,true,pItem,NULL_BAG,slot);

                if (res!=EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count==0)
                {
                    if (no_similar_count==0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }
            }
        }

        // search free slot in bag for place to
        if (bag == INVENTORY_SLOT_BAG_0)                   // inventory
        {
            // if src item is bag don't search empty slot to avoid puting bag into self
            // it can happen because bag is removed after finding free slot which can be in swaping bag
            //if (pItem->IsBag())
            //    return EQUIP_ERR_ITEMS_CANT_BE_SWAPPED;

            // search free slot - keyring case
            if (pProto->BagFamily & BAG_FAMILY_MASK_KEYS)
            {
                uint32 keyringSize = GetMaxKeyringSize();
                res = _CanStoreItem_InInventorySlots(KEYRING_SLOT_START,KEYRING_SLOT_START+keyringSize,dest,pProto,count,false,pItem,bag,slot);
                if (res!=EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count==0)
                {
                    if (no_similar_count==0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }
            }

            res = _CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START,INVENTORY_SLOT_ITEM_END,dest,pProto,count,false,pItem,bag,slot);
            if (res!=EQUIP_ERR_OK)
            {
                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return res;
            }

            if (count==0)
            {
                if (no_similar_count==0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }
        else                                                // equipped bag
        {
            res = _CanStoreItem_InBag(bag,dest,pProto,count,false,false,pItem,NULL_BAG,slot);
            if (res!=EQUIP_ERR_OK)
                res = _CanStoreItem_InBag(bag,dest,pProto,count,false,true,pItem,NULL_BAG,slot);

            if (res!=EQUIP_ERR_OK)
            {
                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return res;
            }

            if (count==0)
            {
                if (no_similar_count==0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }
    }

    // not specific bag or have space for partly store only in specific bag

    // search stack for merge to
    if (pProto->Stackable > 1)
    {
        res = _CanStoreItem_InInventorySlots(KEYRING_SLOT_START,KEYRING_SLOT_END,dest,pProto,count,true,pItem,bag,slot);
        if (res!=EQUIP_ERR_OK)
        {
            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return res;
        }

        if (count==0)
        {
            if (no_similar_count==0)
                return EQUIP_ERR_OK;

            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
        }

        res = _CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START,INVENTORY_SLOT_ITEM_END,dest,pProto,count,true,pItem,bag,slot);
        if (res!=EQUIP_ERR_OK)
        {
            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return res;
        }

        if (count==0)
        {
            if (no_similar_count==0)
                return EQUIP_ERR_OK;

            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
        }

        if (pProto->BagFamily)
        {
            for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
            {
                res = _CanStoreItem_InBag(i,dest,pProto,count,true,false,pItem,bag,slot);
                if (res!=EQUIP_ERR_OK)
                    continue;

                if (count==0)
                {
                    if (no_similar_count==0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }
            }
        }

        for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        {
            res = _CanStoreItem_InBag(i,dest,pProto,count,true,true,pItem,bag,slot);
            if (res!=EQUIP_ERR_OK)
                continue;

            if (count==0)
            {
                if (no_similar_count==0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }
    }

    // search free slot - special bag case
    if (pProto->BagFamily)
    {
        if (pProto->BagFamily & BAG_FAMILY_MASK_KEYS)
        {
            uint32 keyringSize = GetMaxKeyringSize();
            res = _CanStoreItem_InInventorySlots(KEYRING_SLOT_START,KEYRING_SLOT_START+keyringSize,dest,pProto,count,false,pItem,bag,slot);
            if (res!=EQUIP_ERR_OK)
            {
                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return res;
            }

            if (count==0)
            {
                if (no_similar_count==0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }

        for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        {
            res = _CanStoreItem_InBag(i,dest,pProto,count,false,false,pItem,bag,slot);
            if (res!=EQUIP_ERR_OK)
                continue;

            if (count==0)
            {
                if (no_similar_count==0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }
    }

/*  TODO: rewrite to avoid crash when adding any item to bag
    // Normally it would be impossible to autostore not empty bags
    if (pItem->IsBag() && !((Bag*)pItem)->IsEmpty())
        return EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG;
*/

    // search free slot
    res = _CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START,INVENTORY_SLOT_ITEM_END,dest,pProto,count,false,pItem,bag,slot);
    if (res!=EQUIP_ERR_OK)
    {
        if (no_space_count)
            *no_space_count = count + no_similar_count;
        return res;
    }

    if (count==0)
    {
        if (no_similar_count==0)
            return EQUIP_ERR_OK;

        if (no_space_count)
            *no_space_count = count + no_similar_count;
        return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
    }

    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        res = _CanStoreItem_InBag(i,dest,pProto,count,false,true,pItem,bag,slot);
        if (res!=EQUIP_ERR_OK)
            continue;

        if (count==0)
        {
            if (no_similar_count==0)
                return EQUIP_ERR_OK;

            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
        }
    }

    if (no_space_count)
        *no_space_count = count + no_similar_count;

    return EQUIP_ERR_INVENTORY_FULL;
}

//////////////////////////////////////////////////////////////////////////
uint8 Player::CanStoreItems(Item **pItems,int count) const
{
    Item    *pItem2;

    // fill space table
    int inv_slot_items[INVENTORY_SLOT_ITEM_END-INVENTORY_SLOT_ITEM_START];
    int inv_bags[INVENTORY_SLOT_BAG_END-INVENTORY_SLOT_BAG_START][MAX_BAG_SIZE];
    int inv_keys[KEYRING_SLOT_END-KEYRING_SLOT_START];

    memset(inv_slot_items,0,sizeof(int)*(INVENTORY_SLOT_ITEM_END-INVENTORY_SLOT_ITEM_START));
    memset(inv_bags,0,sizeof(int)*(INVENTORY_SLOT_BAG_END-INVENTORY_SLOT_BAG_START)*MAX_BAG_SIZE);
    memset(inv_keys,0,sizeof(int)*(KEYRING_SLOT_END-KEYRING_SLOT_START));

    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);

        if (pItem2 && !pItem2->IsInTrade())
        {
            inv_slot_items[i-INVENTORY_SLOT_ITEM_START] = pItem2->GetCount();
        }
    }

    for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
    {
        pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);

        if (pItem2 && !pItem2->IsInTrade())
        {
            inv_keys[i-KEYRING_SLOT_START] = pItem2->GetCount();
        }
    }

    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                pItem2 = GetItemByPos(i, j);
                if (pItem2 && !pItem2->IsInTrade())
                {
                    inv_bags[i-INVENTORY_SLOT_BAG_START][j] = pItem2->GetCount();
                }
            }
        }
    }

    // check free space for all items
    for (int k=0;k<count;k++)
    {
        Item  *pItem = pItems[k];

        // no item
        if (!pItem)  continue;

        sLog.outDebug("STORAGE: CanStoreItems %i. item = %u, count = %u", k+1, pItem->GetEntry(), pItem->GetCount());
        ItemPrototype const *pProto = pItem->GetProto();

        // strange item
        if (!pProto)
            return EQUIP_ERR_ITEM_NOT_FOUND;

        // item it 'bind'
        if (pItem->IsBindedNotWith(GetGUID()))
            return EQUIP_ERR_DONT_OWN_THAT_ITEM;

        Bag *pBag;
        ItemPrototype const *pBagProto;

        // item is 'one item only'
        uint8 res = CanTakeMoreSimilarItems(pItem);
        if (res != EQUIP_ERR_OK)
            return res;

        // search stack for merge to
        if (pProto->Stackable > 1)
        {
            bool b_found = false;

            for (int t = KEYRING_SLOT_START; t < KEYRING_SLOT_END; t++)
            {
                pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, t);
                if (pItem2 && pItem2->GetEntry() == pItem->GetEntry() && inv_keys[t-KEYRING_SLOT_START] + pItem->GetCount() <= pProto->Stackable)
                {
                    inv_keys[t-KEYRING_SLOT_START] += pItem->GetCount();
                    b_found = true;
                    break;
                }
            }
            if (b_found) continue;

            for (int t = INVENTORY_SLOT_ITEM_START; t < INVENTORY_SLOT_ITEM_END; t++)
            {
                pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, t);
                if (pItem2 && pItem2->GetEntry() == pItem->GetEntry() && inv_slot_items[t-INVENTORY_SLOT_ITEM_START] + pItem->GetCount() <= pProto->Stackable)
                {
                    inv_slot_items[t-INVENTORY_SLOT_ITEM_START] += pItem->GetCount();
                    b_found = true;
                    break;
                }
            }
            if (b_found) continue;

            for (int t = INVENTORY_SLOT_BAG_START; !b_found && t < INVENTORY_SLOT_BAG_END; t++)
            {
                pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, t);
                if (pBag)
                {
                    for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                    {
                        pItem2 = GetItemByPos(t, j);
                        if (pItem2 && pItem2->GetEntry() == pItem->GetEntry() && inv_bags[t-INVENTORY_SLOT_BAG_START][j] + pItem->GetCount() <= pProto->Stackable)
                        {
                            inv_bags[t-INVENTORY_SLOT_BAG_START][j] += pItem->GetCount();
                            b_found = true;
                            break;
                        }
                    }
                }
            }
            if (b_found) continue;
        }

        // special bag case
        if (pProto->BagFamily)
        {
            bool b_found = false;
            if (pProto->BagFamily & BAG_FAMILY_MASK_KEYS)
            {
                uint32 keyringSize = GetMaxKeyringSize();
                for (uint32 t = KEYRING_SLOT_START; t < KEYRING_SLOT_START+keyringSize; ++t)
                {
                    if (inv_keys[t-KEYRING_SLOT_START] == 0)
                    {
                        inv_keys[t-KEYRING_SLOT_START] = 1;
                        b_found = true;
                        break;
                    }
                }
            }

            if (b_found) continue;

            for (int t = INVENTORY_SLOT_BAG_START; !b_found && t < INVENTORY_SLOT_BAG_END; t++)
            {
                pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, t);
                if (pBag)
                {
                    pBagProto = pBag->GetProto();

                    // not plain container check
                    if (pBagProto && (pBagProto->Class != ITEM_CLASS_CONTAINER || pBagProto->SubClass != ITEM_SUBCLASS_CONTAINER) &&
                        ItemCanGoIntoBag(pProto,pBagProto))
                    {
                        for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                        {
                            if (inv_bags[t-INVENTORY_SLOT_BAG_START][j] == 0)
                            {
                                inv_bags[t-INVENTORY_SLOT_BAG_START][j] = 1;
                                b_found = true;
                                break;
                            }
                        }
                    }
                }
            }
            if (b_found) continue;
        }

        // search free slot
        bool b_found = false;
        for (int t = INVENTORY_SLOT_ITEM_START; t < INVENTORY_SLOT_ITEM_END; t++)
        {
            if (inv_slot_items[t-INVENTORY_SLOT_ITEM_START] == 0)
            {
                inv_slot_items[t-INVENTORY_SLOT_ITEM_START] = 1;
                b_found = true;
                break;
            }
        }
        if (b_found) continue;

        // search free slot in bags
        for (int t = INVENTORY_SLOT_BAG_START; !b_found && t < INVENTORY_SLOT_BAG_END; t++)
        {
            pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, t);
            if (pBag)
            {
                pBagProto = pBag->GetProto();

                // special bag already checked
                if (pBagProto && (pBagProto->Class != ITEM_CLASS_CONTAINER || pBagProto->SubClass != ITEM_SUBCLASS_CONTAINER))
                    continue;

                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                {
                    if (inv_bags[t-INVENTORY_SLOT_BAG_START][j] == 0)
                    {
                        inv_bags[t-INVENTORY_SLOT_BAG_START][j] = 1;
                        b_found = true;
                        break;
                    }
                }
            }
        }

        // no free slot found?
        if (!b_found)
            return EQUIP_ERR_INVENTORY_FULL;
    }

    return EQUIP_ERR_OK;
}

//////////////////////////////////////////////////////////////////////////
uint8 Player::CanEquipNewItem(uint8 slot, uint16 &dest, uint32 item, bool swap) const
{
    dest = 0;
    Item *pItem = Item::CreateItem(item, 1, this);
    if (pItem)
    {
        uint8 result = CanEquipItem(slot, dest, pItem, swap);
        delete pItem;
        return result;
    }

    return EQUIP_ERR_ITEM_NOT_FOUND;
}

uint8 Player::CanEquipItem(uint8 slot, uint16 &dest, Item *pItem, bool swap, bool not_loading) const
{
    dest = 0;
    if (pItem)
    {
        sLog.outDebug("STORAGE: CanEquipItem slot = %u, item = %u, count = %u", slot, pItem->GetEntry(), pItem->GetCount());
        ItemPrototype const *pProto = pItem->GetProto();
        if (pProto)
        {
            if (pItem->IsBindedNotWith(GetGUID()))
                return EQUIP_ERR_DONT_OWN_THAT_ITEM;

            // check count of items (skip for auto move for same player from bank)
            uint8 res = CanTakeMoreSimilarItems(pItem);
            if (res != EQUIP_ERR_OK)
                return res;

            // check this only in game
            if (not_loading)
            {
                // May be here should be more stronger checks; STUNNED checked
                // ROOT, CONFUSED, DISTRACTED, FLEEING this needs to be checked.
                if (hasUnitState(UNIT_STAT_STUNNED))
                    return EQUIP_ERR_YOU_ARE_STUNNED;

                // do not allow equipping gear except weapons, offhands, projectiles, relics in
                // - combat
                // - in-progress arenas
                if (!pProto->CanChangeEquipStateInCombat())
                {
                    if (isInCombat())
                        return EQUIP_ERR_NOT_IN_COMBAT;

                    if (BattleGround* bg = GetBattleGround())
                        if (bg->isArena() && bg->GetStatus() == STATUS_IN_PROGRESS)
                            return EQUIP_ERR_NOT_DURING_ARENA_MATCH;
                }

                if (isInCombat()&& pProto->Class == ITEM_CLASS_WEAPON && m_weaponChangeTimer != 0)
                    return EQUIP_ERR_CANT_DO_RIGHT_NOW;         // maybe exist better err

                if (IsNonMeleeSpellCasted(false))
                {
                    // exclude spells with transform item effect
                    if (!m_currentSpells[CURRENT_GENERIC_SPELL] ||
                        (m_currentSpells[CURRENT_GENERIC_SPELL]->GetSpellInfo()->Effect[0] != SPELL_EFFECT_SUMMON_CHANGE_ITEM &&
                        m_currentSpells[CURRENT_GENERIC_SPELL]->GetSpellInfo()->Effect[1] != SPELL_EFFECT_SUMMON_CHANGE_ITEM &&
                        m_currentSpells[CURRENT_GENERIC_SPELL]->GetSpellInfo()->Effect[2] != SPELL_EFFECT_SUMMON_CHANGE_ITEM))

                        return EQUIP_ERR_CANT_DO_RIGHT_NOW;
                }

            }

            uint8 eslot = FindEquipSlot(pProto, slot, swap);
            if (eslot == NULL_SLOT)
                return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

            uint8 msg = CanUseItem(pItem , not_loading);
            if (msg != EQUIP_ERR_OK)
                return msg;
            if (!swap && GetItemByPos(INVENTORY_SLOT_BAG_0, eslot))
                return EQUIP_ERR_NO_EQUIPMENT_SLOT_AVAILABLE;

            // check unique-equipped on item
            if (pProto->Flags & ITEM_FLAGS_UNIQUE_EQUIPPED)
            {
                // there is an equip limit on this item
                Item* tItem = GetItemOrItemWithGemEquipped(pProto->ItemId);
                if (tItem && (!swap || tItem->GetSlot() != eslot))
                    return EQUIP_ERR_ITEM_UNIQUE_EQUIPABLE;
            }

            // check unique-equipped on gems
            for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT+3; ++enchant_slot)
            {
                uint32 enchant_id = pItem->GetEnchantmentId(EnchantmentSlot(enchant_slot));
                if (!enchant_id)
                    continue;
                SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
                if (!enchantEntry)
                    continue;

                ItemPrototype const* pGem = ObjectMgr::GetItemPrototype(enchantEntry->GemID);
                if (pGem && (pGem->Flags & ITEM_FLAGS_UNIQUE_EQUIPPED))
                {
                    Item* tItem = GetItemOrItemWithGemEquipped(enchantEntry->GemID);
                    if (tItem && (!swap || tItem->GetSlot() != eslot))
                        return EQUIP_ERR_ITEM_UNIQUE_EQUIPABLE;
                }
            }

            // check unique-equipped special item classes
            if (pProto->Class == ITEM_CLASS_QUIVER)
            {
                for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
                {
                    if (Item* pBag = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                    {
                        if (ItemPrototype const* pBagProto = pBag->GetProto())
                        {
                            if (pBagProto->Class==pProto->Class && (!swap || pBag->GetSlot() != eslot))
                            {
                                if (pBagProto->SubClass == ITEM_SUBCLASS_AMMO_POUCH)
                                    return EQUIP_ERR_CAN_EQUIP_ONLY1_AMMOPOUCH;
                                else
                                    return EQUIP_ERR_CAN_EQUIP_ONLY1_QUIVER;
                            }
                        }
                    }
                }
            }

            uint32 type = pProto->InventoryType;

            if (eslot == EQUIPMENT_SLOT_OFFHAND)
            {
                if (type == INVTYPE_WEAPON || type == INVTYPE_WEAPONOFFHAND)
                {
                    if (!CanDualWield())
                        return EQUIP_ERR_CANT_DUAL_WIELD;
                }

                Item *mainItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
                if (mainItem)
                {
                    if (mainItem->GetProto()->InventoryType == INVTYPE_2HWEAPON)
                        return EQUIP_ERR_CANT_EQUIP_WITH_TWOHANDED;
                }
            }

            // equip two-hand weapon case (with possible unequip 2 items)
            if (type == INVTYPE_2HWEAPON)
            {
                if (eslot != EQUIPMENT_SLOT_MAINHAND)
                    return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

                // offhand item must can be stored in inventory for offhand item and it also must be unequipped
                Item *offItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
                ItemPosCountVec off_dest;
                if (offItem && (!not_loading ||
                    CanUnequipItem(uint16(INVENTORY_SLOT_BAG_0) << 8 | EQUIPMENT_SLOT_OFFHAND,false) !=  EQUIP_ERR_OK ||
                    CanStoreItem(NULL_BAG, NULL_SLOT, off_dest, offItem, false) !=  EQUIP_ERR_OK))
                    return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_INVENTORY_FULL;
            }
            dest = ((INVENTORY_SLOT_BAG_0 << 8) | eslot);
            return EQUIP_ERR_OK;
        }
    }
    if (!swap)
        return EQUIP_ERR_ITEM_NOT_FOUND;
    else
        return EQUIP_ERR_ITEMS_CANT_BE_SWAPPED;
}

uint8 Player::CanUnequipItem(uint16 pos, bool swap) const
{
    // Applied only to equipped items and bank bags
    if (!IsEquipmentPos(pos) && !IsBagPos(pos))
        return EQUIP_ERR_OK;

    Item* pItem = GetItemByPos(pos);

    // Applied only to existed equipped item
    if (!pItem)
        return EQUIP_ERR_OK;

    sLog.outDebug("STORAGE: CanUnequipItem slot = %u, item = %u, count = %u", pos, pItem->GetEntry(), pItem->GetCount());

    ItemPrototype const *pProto = pItem->GetProto();
    if (!pProto)
        return EQUIP_ERR_ITEM_NOT_FOUND;

    // do not allow unequipping gear except weapons, offhands, projectiles, relics in
    // - combat
    // - in-progress arenas
    if (!pProto->CanChangeEquipStateInCombat())
    {
        if (isInCombat())
            return EQUIP_ERR_NOT_IN_COMBAT;

        if (BattleGround* bg = GetBattleGround())
            if (bg->isArena() && bg->GetStatus() == STATUS_IN_PROGRESS)
                return EQUIP_ERR_NOT_DURING_ARENA_MATCH;
    }

    // prevent swaping bags if player is trading
    if (swap && pItem->IsBag() && pTrader)
        return EQUIP_ERR_ITEMS_CANT_BE_SWAPPED;

    if (!swap && pItem->IsBag() && !((Bag*)pItem)->IsEmpty())
        return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

    return EQUIP_ERR_OK;
}

uint8 Player::CanBankItem(uint8 bag, uint8 slot, ItemPosCountVec &dest, Item *pItem, bool swap, bool not_loading) const
{
    if (!pItem)
        return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_ITEM_NOT_FOUND;

    if (pItem->m_lootGenerated)
    {
        GetSession()->DoLootRelease(GetLootGUID());
        return EQUIP_ERR_OK;
    }

    uint32 count = pItem->GetCount();

    sLog.outDebug("STORAGE: CanBankItem bag = %u, slot = %u, item = %u, count = %u", bag, slot, pItem->GetEntry(), pItem->GetCount());
    ItemPrototype const *pProto = pItem->GetProto();
    if (!pProto)
        return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_ITEM_NOT_FOUND;

    if (pItem->IsBindedNotWith(GetGUID()))
        return EQUIP_ERR_DONT_OWN_THAT_ITEM;

    // check count of items (skip for auto move for same player from bank)
    uint8 res = CanTakeMoreSimilarItems(pItem);
    if (res != EQUIP_ERR_OK)
        return res;

    // in specific slot
    if (bag != NULL_BAG && slot != NULL_SLOT)
    {
        if (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END)
        {
            if (!pItem->IsBag())
                 return EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT;

            if(!HasBankBagSlot(slot))
                return EQUIP_ERR_MUST_PURCHASE_THAT_BAG_SLOT;

            if (uint8 cantuse = CanUseItem(pItem, not_loading) != EQUIP_ERR_OK)
                return cantuse;
        }

        res = _CanStoreItem_InSpecificSlot(bag,slot,dest,pProto,count,swap,pItem);
        if (res!=EQUIP_ERR_OK)
            return res;

        if (count==0)
            return EQUIP_ERR_OK;
    }

    // not specific slot or have space for partly store only in specific slot

    // in specific bag
    if (bag != NULL_BAG)
    {
        if (pProto->InventoryType == INVTYPE_BAG)
        {
            Bag *pBag = (Bag*)pItem;
            if (pBag && !pBag->IsEmpty())
                return EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG;
        }

        // search stack in bag for merge to
        if (pProto->Stackable > 1)
        {
            if (bag == INVENTORY_SLOT_BAG_0)
            {
                res = _CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START,BANK_SLOT_ITEM_END,dest,pProto,count,true,pItem,bag,slot);
                if (res!=EQUIP_ERR_OK)
                    return res;

                if (count==0)
                    return EQUIP_ERR_OK;
            }
            else
            {
                res = _CanStoreItem_InBag(bag,dest,pProto,count,true,false,pItem,NULL_BAG,slot);
                if (res!=EQUIP_ERR_OK)
                    res = _CanStoreItem_InBag(bag,dest,pProto,count,true,true,pItem,NULL_BAG,slot);

                if (res!=EQUIP_ERR_OK)
                    return res;

                if (count==0)
                    return EQUIP_ERR_OK;
            }
        }

        // search free slot in bag
        if (bag == INVENTORY_SLOT_BAG_0)
        {
            res = _CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START,BANK_SLOT_ITEM_END,dest,pProto,count,false,pItem,bag,slot);
            if (res!=EQUIP_ERR_OK)
                return res;

            if (count==0)
                return EQUIP_ERR_OK;
        }
        else
        {
            res = _CanStoreItem_InBag(bag,dest,pProto,count,false,false,pItem,NULL_BAG,slot);
            if (res!=EQUIP_ERR_OK)
                res = _CanStoreItem_InBag(bag,dest,pProto,count,false,true,pItem,NULL_BAG,slot);

            if (res!=EQUIP_ERR_OK)
                return res;

            if (count==0)
                return EQUIP_ERR_OK;
        }
    }

    // not specific bag or have space for partly store only in specific bag

    // search stack for merge to
    if (pProto->Stackable > 1)
    {
        // in slots
        res = _CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START,BANK_SLOT_ITEM_END,dest,pProto,count,true,pItem,bag,slot);
        if (res!=EQUIP_ERR_OK)
            return res;

        if (count==0)
            return EQUIP_ERR_OK;

        // in special bags
        if (pProto->BagFamily)
        {
            for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
            {
                res = _CanStoreItem_InBag(i,dest,pProto,count,true,false,pItem,bag,slot);
                if (res!=EQUIP_ERR_OK)
                    continue;

                if (count==0)
                    return EQUIP_ERR_OK;
            }
        }

        for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            res = _CanStoreItem_InBag(i,dest,pProto,count,true,true,pItem,bag,slot);
            if (res!=EQUIP_ERR_OK)
                continue;

            if (count==0)
                return EQUIP_ERR_OK;
        }
    }

    // search free place in special bag
    if (pProto->BagFamily)
    {
        for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            res = _CanStoreItem_InBag(i,dest,pProto,count,false,false,pItem,bag,slot);
            if (res!=EQUIP_ERR_OK)
                continue;

            if (count==0)
                return EQUIP_ERR_OK;
        }
    }

    // search free space
    res = _CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START,BANK_SLOT_ITEM_END,dest,pProto,count,false,pItem,bag,slot);
    if (res!=EQUIP_ERR_OK)
        return res;

    if (count==0)
        return EQUIP_ERR_OK;

    for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
    {
        res = _CanStoreItem_InBag(i,dest,pProto,count,false,true,pItem,bag,slot);
        if (res!=EQUIP_ERR_OK)
            continue;

        if (count==0)
            return EQUIP_ERR_OK;
    }
    return EQUIP_ERR_BANK_FULL;
}

uint8 Player::CanUseItem(Item *pItem, bool not_loading) const
{
    if (pItem)
    {
        sLog.outDebug("STORAGE: CanUseItem item = %u", pItem->GetEntry());
        if (!isAlive() && not_loading)
            return EQUIP_ERR_YOU_ARE_DEAD;
        //if(isStunned())
        //    return EQUIP_ERR_YOU_ARE_STUNNED;
        ItemPrototype const *pProto = pItem->GetProto();
        if (pProto)
        {
            if (pItem->IsBindedNotWith(GetGUID()))
                return EQUIP_ERR_DONT_OWN_THAT_ITEM;
            if ((pProto->AllowableClass & getClassMask()) == 0 || (pProto->AllowableRace & getRaceMask()) == 0)
                return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;
            if (pItem->GetSkill() != 0 )
            {
                if (GetSkillValue(pItem->GetSkill()) == 0)
                    return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
            }
            if (pProto->RequiredSkill != 0 )
            {
                if (GetSkillValue(pProto->RequiredSkill) == 0)
                    return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
                else if (GetSkillValue(pProto->RequiredSkill) < pProto->RequiredSkillRank)
                    return EQUIP_ERR_ERR_CANT_EQUIP_SKILL;
            }
            if (pProto->RequiredSpell != 0 && !HasSpell(pProto->RequiredSpell))
                return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
            if (pProto->RequiredReputationFaction && uint32(GetReputationMgr().GetRank(pProto->RequiredReputationFaction)) < pProto->RequiredReputationRank)
                return EQUIP_ERR_CANT_EQUIP_REPUTATION;
            if (getLevel() < pProto->RequiredLevel)
                return EQUIP_ERR_CANT_EQUIP_LEVEL_I;
            return EQUIP_ERR_OK;
        }
    }
    return EQUIP_ERR_ITEM_NOT_FOUND;
}

bool Player::CanUseItem(ItemPrototype const *pProto)
{
    // Used by group, function NeedBeforeGreed, to know if a prototype can be used by a player

    if (pProto)
    {
        if ((pProto->AllowableClass & getClassMask()) == 0 || (pProto->AllowableRace & getRaceMask()) == 0)
            return false;

        if (pProto->RequiredSkill != 0 )
        {
            if (GetSkillValue(pProto->RequiredSkill) == 0)
                return false;
            else if (GetSkillValue(pProto->RequiredSkill) < pProto->RequiredSkillRank)
                return false;
        }

        if (pProto->RequiredSpell != 0 && !HasSpell(pProto->RequiredSpell))
            return false;

        if (getLevel() < pProto->RequiredLevel)
            return false;

        if (pProto->Class == ITEM_CLASS_RECIPE)
        {
            if (pProto->Spells[0].SpellId == SPELL_ID_GENERIC_LEARN)
            {
                if (HasSpell(pProto->Spells[1].SpellId))
                    return false;
            }
            else
            {
                SpellEntry const * spellInfo = GetSpellStore()->LookupEntry(pProto->Spells[0].SpellId);

                if (spellInfo)
                    for (uint8 i = 0; i < 3; ++i)
                        if (spellInfo->Effect[i] == SPELL_EFFECT_LEARN_SPELL)
                            if (HasSpell(spellInfo->EffectTriggerSpell[i]))
                                return false;
            }
        }

        return true;
    }

    return false;
}

uint8 Player::CanUseAmmo(uint32 item) const
{
    sLog.outDebug("STORAGE: CanUseAmmo item = %u", item);
    if (!isAlive())
        return EQUIP_ERR_YOU_ARE_DEAD;
    //if(isStunned())
    //    return EQUIP_ERR_YOU_ARE_STUNNED;
    ItemPrototype const *pProto = ObjectMgr::GetItemPrototype(item);
    if (pProto)
    {
        if (pProto->InventoryType!= INVTYPE_AMMO)
            return EQUIP_ERR_ONLY_AMMO_CAN_GO_HERE;
        if ((pProto->AllowableClass & getClassMask()) == 0 || (pProto->AllowableRace & getRaceMask()) == 0)
            return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;
        if (pProto->RequiredSkill != 0 )
        {
            if (GetSkillValue(pProto->RequiredSkill) == 0)
                return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
            else if (GetSkillValue(pProto->RequiredSkill) < pProto->RequiredSkillRank)
                return EQUIP_ERR_ERR_CANT_EQUIP_SKILL;
        }
        if (pProto->RequiredSpell != 0 && !HasSpell(pProto->RequiredSpell))
            return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
        /*if(GetReputation() < pProto->RequiredReputation)
        return EQUIP_ERR_CANT_EQUIP_REPUTATION;
        */
        if (getLevel() < pProto->RequiredLevel)
            return EQUIP_ERR_CANT_EQUIP_LEVEL_I;

        // Requires No Ammo
        if (GetDummyAura(46699))
            return EQUIP_ERR_BAG_FULL6;

        return EQUIP_ERR_OK;
    }
    return EQUIP_ERR_ITEM_NOT_FOUND;
}

void Player::SetAmmo(uint32 item)
{
    if (!item)
        return;

    // already set
    if (GetUInt32Value(PLAYER_AMMO_ID) == item)
        return;

    // check ammo
    if (item)
    {
        uint8 msg = CanUseAmmo(item);
        if (msg != EQUIP_ERR_OK)
        {
            SendEquipError(msg, NULL, NULL);
            return;
        }
    }

    SetUInt32Value(PLAYER_AMMO_ID, item);

    _ApplyAmmoBonuses();
}

void Player::RemoveAmmo()
{
    SetUInt32Value(PLAYER_AMMO_ID, 0);

    m_ammoDPS = 0.0f;

    if (CanModifyStats())
        UpdateDamagePhysical(RANGED_ATTACK);
}

// Return stored item (if stored to stack, it can diff. from pItem). And pItem ca be deleted in this case.
Item* Player::StoreNewItem(ItemPosCountVec const& dest, uint32 item, bool update,int32 randomPropertyId)
{
    uint32 count = 0;
    for (ItemPosCountVec::const_iterator itr = dest.begin(); itr != dest.end(); ++itr)
        count += itr->count;

    Item *pItem = Item::CreateItem(item, count, this);
    if (pItem)
    {
        ItemAddedQuestCheck(item, count);
        if (randomPropertyId)
            pItem->SetItemRandomProperties(randomPropertyId);
        pItem = StoreItem(dest, pItem, update);
    }
    return pItem;
}

Item* Player::StoreItem(ItemPosCountVec const& dest, Item* pItem, bool update)
{
    if (!pItem)
        return NULL;

    Item* lastItem = pItem;

    for (ItemPosCountVec::const_iterator itr = dest.begin(); itr != dest.end();)
    {
        uint16 pos = itr->pos;
        uint32 count = itr->count;

        ++itr;

        if (itr == dest.end())
        {
            lastItem = _StoreItem(pos,pItem,count,false,update);
            break;
        }

        lastItem = _StoreItem(pos,pItem,count,true,update);
    }

    return lastItem;
}

// Return stored item (if stored to stack, it can diff. from pItem). And pItem ca be deleted in this case.
Item* Player::_StoreItem(uint16 pos, Item *pItem, uint32 count, bool clone, bool update)
{
    if (!pItem)
        return NULL;

    uint8 bag = pos >> 8;
    uint8 slot = pos & 255;

    sLog.outDebug("STORAGE: StoreItem bag = %u, slot = %u, item = %u, count = %u", bag, slot, pItem->GetEntry(), count);

    Item *pItem2 = GetItemByPos(bag, slot);

    if (!pItem2)
    {
        if (clone)
            pItem = pItem->CloneItem(count,this);
        else
            pItem->SetCount(count);

        if (!pItem)
            return NULL;

        if (pItem->GetProto()->Bonding == BIND_WHEN_PICKED_UP ||
            pItem->GetProto()->Bonding == BIND_QUEST_ITEM ||
            pItem->GetProto()->Bonding == BIND_WHEN_EQUIPED && IsBagPos(pos))
            pItem->SetBinding(true);

        if (bag == INVENTORY_SLOT_BAG_0)
        {
            m_items[slot] = pItem;
            SetUInt64Value((uint16)(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2)), pItem->GetGUID());
            pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, GetGUID());
            pItem->SetUInt64Value(ITEM_FIELD_OWNER, GetGUID());

            pItem->SetSlot(slot);
            pItem->SetContainer(NULL);

            if (IsInWorld() && update)
            {
                pItem->AddToWorld();
                pItem->SendCreateUpdateToPlayer(this);
            }

            pItem->SetState(ITEM_CHANGED, this);
        }
        else
        {
            Bag *pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, bag);
            if (pBag)
            {
                pBag->StoreItem(slot, pItem, update);
                if (IsInWorld() && update)
                {
                    pItem->AddToWorld();
                    pItem->SendCreateUpdateToPlayer(this);
                }
                pItem->SetState(ITEM_CHANGED, this);
                pBag->SetState(ITEM_CHANGED, this);
            }
        }

        AddEnchantmentDurations(pItem);
        AddItemDurations(pItem);

        return pItem;
    }
    else
    {
        if (pItem2->GetProto()->Bonding == BIND_WHEN_PICKED_UP ||
            pItem2->GetProto()->Bonding == BIND_QUEST_ITEM ||
            pItem2->GetProto()->Bonding == BIND_WHEN_EQUIPED && IsBagPos(pos))
            pItem2->SetBinding(true);

        pItem2->SetCount(pItem2->GetCount() + count);
        if (IsInWorld() && update)
            pItem2->SendCreateUpdateToPlayer(this);

        if (!clone)
        {
            // delete item (it not in any slot currently)
            if (IsInWorld() && update)
            {
                pItem->RemoveFromWorld();
                pItem->DestroyForPlayer(this);
            }

            RemoveEnchantmentDurations(pItem);
            RemoveItemDurations(pItem);

            pItem->SetOwnerGUID(GetGUID());                 // prevent error at next SetState in case trade/mail/buy from vendor
            pItem->SetState(ITEM_REMOVED, this);
        }
        // AddItemDurations(pItem2); - pItem2 already have duration listed for player
        AddEnchantmentDurations(pItem2);

        pItem2->SetState(ITEM_CHANGED, this);

        return pItem2;
    }
}

Item* Player::EquipNewItem(uint16 pos, uint32 item, bool update)
{
    Item *pItem = Item::CreateItem(item, 1, this);
    if (pItem)
    {
        ItemAddedQuestCheck(item, 1);
        Item * retItem = EquipItem(pos, pItem, update);

        return retItem;
    }
    return NULL;
}

Item* Player::EquipItem(uint16 pos, Item *pItem, bool update)
{
    AddEnchantmentDurations(pItem);
    AddItemDurations(pItem);

    uint8 bag = pos >> 8;
    uint8 slot = pos & 255;

    Item *pItem2 = GetItemByPos(bag, slot);

    if (!pItem2)
    {
        VisualizeItem(slot, pItem);

        if (isAlive())
        {
            ItemPrototype const *pProto = pItem->GetProto();

            // item set bonuses applied only at equip and removed at unequip, and still active for broken items
            if (pProto && pProto->ItemSet)
                AddItemsSetItem(this,pItem);

            _ApplyItemMods(pItem, slot, true);
                                        // weapon or idol/relic
            if (pProto && isInCombat()&& (pProto->Class == ITEM_CLASS_WEAPON || pProto->Class == ITEM_CLASS_ARMOR) && m_weaponChangeTimer == 0)
            {
                uint32 cooldownSpell = SPELL_ID_WEAPON_SWITCH_COOLDOWN_1_5s;

                if (getClass() == CLASS_ROGUE)
                    cooldownSpell = SPELL_ID_WEAPON_SWITCH_COOLDOWN_1_0s;

                SpellEntry const* spellProto = sSpellStore.LookupEntry(cooldownSpell);

                if (!spellProto)
                    sLog.outLog(LOG_DEFAULT, "ERROR: Weapon switch cooldown spell %u couldn't be found in Spell.dbc", cooldownSpell);
                else
                {
                    m_weaponChangeTimer = spellProto->StartRecoveryTime;

                    if (getClass() != CLASS_ROGUE)
                        GetCooldownMgr().AddGlobalCooldown(spellProto, m_weaponChangeTimer);

                    WorldPacket data(SMSG_SPELL_COOLDOWN, 8+1+4);
                    data << uint64(GetGUID());
                    data << uint8(1);
                    data << uint32(cooldownSpell);
                    data << uint32(0);
                    SendPacketToSelf(&data);
                }
            }
        }

        if (IsInWorld() && update)
        {
            pItem->AddToWorld();
            pItem->SendCreateUpdateToPlayer(this);
        }

        ApplyEquipCooldown(pItem);

        if (slot == EQUIPMENT_SLOT_MAINHAND)
            UpdateExpertise(BASE_ATTACK);
        else if (slot == EQUIPMENT_SLOT_OFFHAND)
            UpdateExpertise(OFF_ATTACK);
    }
    else
    {
        pItem2->SetCount(pItem2->GetCount() + pItem->GetCount());
        if (IsInWorld() && update)
            pItem2->SendCreateUpdateToPlayer(this);

        // delete item (it not in any slot currently)
        //pItem->DeleteFromDB();
        if (IsInWorld() && update)
        {
            pItem->RemoveFromWorld();
            pItem->DestroyForPlayer(this);
        }

        RemoveEnchantmentDurations(pItem);
        RemoveItemDurations(pItem);

        pItem->SetOwnerGUID(GetGUID());                 // prevent error at next SetState in case trade/mail/buy from vendor
        pItem->SetState(ITEM_REMOVED, this);
        pItem2->SetState(ITEM_CHANGED, this);

        ApplyEquipCooldown(pItem2);

        return pItem2;
    }

    return pItem;
}

void Player::QuickEquipItem(uint16 pos, Item *pItem)
{
    if (pItem)
    {
        AddEnchantmentDurations(pItem);
        AddItemDurations(pItem);

        uint8 slot = pos & 255;
        VisualizeItem(slot, pItem);

        if (IsInWorld())
        {
            pItem->AddToWorld();
            pItem->SendCreateUpdateToPlayer(this);
        }
    }
}

void Player::SetVisibleItemSlot(uint8 slot, Item *pItem)
{
    // PLAYER_VISIBLE_ITEM_i_CREATOR    // Size: 2
    // PLAYER_VISIBLE_ITEM_i_0          // Size: 12
    //    entry                         //      Size: 1
    //    inspected enchantments        //      Size: 6
    //    ?                             //      Size: 5
    // PLAYER_VISIBLE_ITEM_i_PROPERTIES // Size: 1 (property,suffix factor)
    // PLAYER_VISIBLE_ITEM_i_PAD        // Size: 1
    //                                  //     = 16

    if (pItem)
    {
        SetUInt64Value(PLAYER_VISIBLE_ITEM_1_CREATOR + (slot * MAX_VISIBLE_ITEM_OFFSET), pItem->GetUInt64Value(ITEM_FIELD_CREATOR));

        int VisibleBase = PLAYER_VISIBLE_ITEM_1_0 + (slot * MAX_VISIBLE_ITEM_OFFSET);
        SetUInt32Value(VisibleBase + 0, pItem->GetEntry());

        for (int i = 0; i < MAX_INSPECTED_ENCHANTMENT_SLOT; ++i)
            SetUInt32Value(VisibleBase + 1 + i, pItem->GetEnchantmentId(EnchantmentSlot(i)));

        // Use SetInt16Value to prevent set high part to FFFF for negative value
        SetInt16Value(PLAYER_VISIBLE_ITEM_1_PROPERTIES + (slot * MAX_VISIBLE_ITEM_OFFSET), 0, pItem->GetItemRandomPropertyId());
        SetUInt32Value(PLAYER_VISIBLE_ITEM_1_PROPERTIES + 1 + (slot * MAX_VISIBLE_ITEM_OFFSET), pItem->GetItemSuffixFactor());
    }
    else
    {
        SetUInt64Value(PLAYER_VISIBLE_ITEM_1_CREATOR + (slot * MAX_VISIBLE_ITEM_OFFSET), 0);

        int VisibleBase = PLAYER_VISIBLE_ITEM_1_0 + (slot * MAX_VISIBLE_ITEM_OFFSET);
        SetUInt32Value(VisibleBase + 0, 0);

        for (int i = 0; i < MAX_INSPECTED_ENCHANTMENT_SLOT; ++i)
            SetUInt32Value(VisibleBase + 1 + i, 0);

        SetUInt32Value(PLAYER_VISIBLE_ITEM_1_PROPERTIES + 0 + (slot * MAX_VISIBLE_ITEM_OFFSET), 0);
        SetUInt32Value(PLAYER_VISIBLE_ITEM_1_PROPERTIES + 1 + (slot * MAX_VISIBLE_ITEM_OFFSET), 0);
    }
}

void Player::VisualizeItem(uint8 slot, Item *pItem)
{
    if (!pItem)
        return;

    // check also  BIND_WHEN_PICKED_UP and BIND_QUEST_ITEM for .additem or .additemset case by GM (not binded at adding to inventory)
    if (pItem->GetProto()->Bonding == BIND_WHEN_EQUIPED || pItem->GetProto()->Bonding == BIND_WHEN_PICKED_UP || pItem->GetProto()->Bonding == BIND_QUEST_ITEM)
        pItem->SetBinding(true);

    sLog.outDebug("STORAGE: EquipItem slot = %u, item = %u", slot, pItem->GetEntry());

    m_items[slot] = pItem;
    SetUInt64Value((uint16)(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2)), pItem->GetGUID());
    pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, GetGUID());
    pItem->SetUInt64Value(ITEM_FIELD_OWNER, GetGUID());
    pItem->SetSlot(slot);
    pItem->SetContainer(NULL);

    if (slot < EQUIPMENT_SLOT_END)
        SetVisibleItemSlot(slot,pItem);

    pItem->SetState(ITEM_CHANGED, this);
}

void Player::RemoveItem(uint8 bag, uint8 slot, bool update)
{
    // note: removeitem does not actually change the item
    // it only takes the item out of storage temporarily
    // note2: if removeitem is to be used for delinking
    // the item must be removed from the player's updatequeue

    Item *pItem = GetItemByPos(bag, slot);
    if (pItem)
    {
        sLog.outDebug("STORAGE: RemoveItem bag = %u, slot = %u, item = %u", bag, slot, pItem->GetEntry());

        RemoveEnchantmentDurations(pItem);
        RemoveItemDurations(pItem);

        if (bag == INVENTORY_SLOT_BAG_0)
        {
            if (slot < INVENTORY_SLOT_BAG_END)
            {
                ItemPrototype const *pProto = pItem->GetProto();
                // item set bonuses applied only at equip and removed at unequip, and still active for broken items

                if (pProto && pProto->ItemSet)
                    RemoveItemsSetItem(this,pProto);

                _ApplyItemMods(pItem, slot, false);

                // remove item dependent auras and casts (only weapon and armor slots)
                if (slot < EQUIPMENT_SLOT_END)
                {
                    RemoveItemDependentAurasAndCasts(pItem);

                    // remove held enchantments
                    if (slot == EQUIPMENT_SLOT_MAINHAND)
                    {
                        if (pItem->GetItemSuffixFactor())
                        {
                            pItem->ClearEnchantment(PROP_ENCHANTMENT_SLOT_3);
                            pItem->ClearEnchantment(PROP_ENCHANTMENT_SLOT_4);
                        }
                        else
                        {
                            pItem->ClearEnchantment(PROP_ENCHANTMENT_SLOT_0);
                            pItem->ClearEnchantment(PROP_ENCHANTMENT_SLOT_1);
                        }

                        UpdateExpertise(BASE_ATTACK);
                    }
                    else if( slot == EQUIPMENT_SLOT_OFFHAND )
                        UpdateExpertise(OFF_ATTACK);
                }
            }

            m_items[slot] = NULL;
            SetUInt64Value((uint16)(PLAYER_FIELD_INV_SLOT_HEAD + (slot*2)), 0);

            if (slot < EQUIPMENT_SLOT_END)
                SetVisibleItemSlot(slot,NULL);
        }
        else
        {
            Bag *pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, bag);
            if (pBag)
                pBag->RemoveItem(slot, update);
        }
        pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, 0);
        // pItem->SetUInt64Value(ITEM_FIELD_OWNER, 0); not clear owner at remove (it will be set at store). This used in mail and auction code
        pItem->SetSlot(NULL_SLOT);
        if (IsInWorld() && update)
            pItem->SendCreateUpdateToPlayer(this);
    }
}

// Common operation need to remove item from inventory without delete in trade, auction, guild bank, mail....
void Player::MoveItemFromInventory(uint8 bag, uint8 slot, bool update)
{
    if (Item* it = GetItemByPos(bag,slot))
    {
        ItemRemovedQuestCheck(it->GetEntry(),it->GetCount());
        RemoveItem(bag,slot,update);
        it->RemoveFromUpdateQueueOf(this);
        if (it->IsInWorld())
        {
            it->RemoveFromWorld();
            it->DestroyForPlayer(this);
        }
    }
}

// Common operation need to add item from inventory without delete in trade, guild bank, mail....
void Player::MoveItemToInventory(ItemPosCountVec const& dest, Item* pItem, bool update, bool in_characterInventoryDB)
{
    // update quest counters
    ItemAddedQuestCheck(pItem->GetEntry(),pItem->GetCount());

    // store item
    Item* pLastItem = StoreItem(dest, pItem, update);

    // only set if not merged to existed stack (pItem can be deleted already but we can compare pointers any way)
    if (pLastItem==pItem)
    {
        // update owner for last item (this can be original item with wrong owner
        if (pLastItem->GetOwnerGUID() != GetGUID())
            pLastItem->SetOwnerGUID(GetGUID());

        // if this original item then it need create record in inventory
        // in case trade we already have item in other player inventory
        pLastItem->SetState(in_characterInventoryDB ? ITEM_CHANGED : ITEM_NEW, this);
    }
}

void Player::DestroyItem(uint8 bag, uint8 slot, bool update)
{
    Item *pItem = GetItemByPos(bag, slot);
    if (pItem)
    {
        sLog.outDebug("STORAGE: DestroyItem bag = %u, slot = %u, item = %u", bag, slot, pItem->GetEntry());

        // start from destroy contained items (only equipped bag can have its)
        if (pItem->IsBag() && pItem->IsEquipped())          // this also prevent infinity loop if empty bag stored in bag==slot
        {
            for (int i = 0; i < MAX_BAG_SIZE; i++)
                DestroyItem(slot,i,update);
        }

        if (pItem->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAGS_WRAPPED))
            RealmDataDatabase.PExecute("DELETE FROM character_gifts WHERE item_guid = '%u'", pItem->GetGUIDLow());

        RemoveEnchantmentDurations(pItem);
        RemoveItemDurations(pItem);

        ItemRemovedQuestCheck(pItem->GetEntry(), pItem->GetCount());

        if (bag == INVENTORY_SLOT_BAG_0)
        {
            SetUInt64Value((uint16)(PLAYER_FIELD_INV_SLOT_HEAD + (slot*2)), 0);

            // equipment and equipped bags can have applied bonuses
            if (slot < INVENTORY_SLOT_BAG_END)
            {
                ItemPrototype const *pProto = pItem->GetProto();

                // item set bonuses applied only at equip and removed at unequip, and still active for broken items
                if (pProto && pProto->ItemSet)
                    RemoveItemsSetItem(this,pProto);

                _ApplyItemMods(pItem, slot, false);
            }

            if (slot < EQUIPMENT_SLOT_END)
            {
                // remove item dependent auras and casts (only weapon and armor slots)
                RemoveItemDependentAurasAndCasts(pItem);

                // update expertise
                if ( slot == EQUIPMENT_SLOT_MAINHAND )
                    UpdateExpertise(BASE_ATTACK);
                else if( slot == EQUIPMENT_SLOT_OFFHAND )
                    UpdateExpertise(OFF_ATTACK);

                // equipment visual show
                SetVisibleItemSlot(slot,NULL);
            }

            m_items[slot] = NULL;
        }
        else if (Bag *pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, bag))
            pBag->RemoveItem(slot, update);

        if (IsInWorld() && update)
        {
            pItem->RemoveFromWorld();
            pItem->DestroyForPlayer(this);
        }

        //pItem->SetOwnerGUID(0);
        pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, 0);
        pItem->SetSlot(NULL_SLOT);
        pItem->SetState(ITEM_REMOVED, this);
    }
}

void Player::DestroyItemCount(uint32 item, uint32 count, bool update, bool unequip_check, bool inBankAlso)
{
    sLog.outDebug("STORAGE: DestroyItemCount item = %u, count = %u", item, count);
    uint32 remcount = 0;

    // in inventory
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
        {
            if (pItem->GetCount() + remcount <= count)
            {
                // all items in inventory can unequipped
                remcount += pItem->GetCount();
                DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

                if (remcount >=count)
                    return;
            }
            else
            {
                ItemRemovedQuestCheck(pItem->GetEntry(), count - remcount);
                pItem->SetCount(pItem->GetCount() - count + remcount);
                if (IsInWorld() & update)
                    pItem->SendCreateUpdateToPlayer(this);
                pItem->SetState(ITEM_CHANGED, this);
                return;
            }
        }
    }
    for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
        {
            if (pItem->GetCount() + remcount <= count)
            {
                // all keys can be unequipped
                remcount += pItem->GetCount();
                DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

                if (remcount >=count)
                    return;
            }
            else
            {
                ItemRemovedQuestCheck(pItem->GetEntry(), count - remcount);
                pItem->SetCount(pItem->GetCount() - count + remcount);
                if (IsInWorld() & update)
                    pItem->SendCreateUpdateToPlayer(this);
                pItem->SetState(ITEM_CHANGED, this);
                return;
            }
        }
    }

    // in inventory bags
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (Bag *pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                Item *pItem = pBag->GetItemByPos(j);
                if (pItem && pItem->GetEntry() == item)
                {
                    // all items in bags can be unequipped
                    if (pItem->GetCount() + remcount <= count)
                    {
                        remcount += pItem->GetCount();
                        DestroyItem(i, j, update);

                        if (remcount >=count)
                            return;
                    }
                    else
                    {
                        ItemRemovedQuestCheck(pItem->GetEntry(), count - remcount);
                        pItem->SetCount(pItem->GetCount() - count + remcount);
                        if (IsInWorld() && update)
                            pItem->SendCreateUpdateToPlayer(this);
                        pItem->SetState(ITEM_CHANGED, this);
                        return;
                    }
                }
            }
        }
    }

    // in equipment and bag list
    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
        {
            if (pItem->GetCount() + remcount <= count)
            {
                if (!unequip_check || CanUnequipItem(INVENTORY_SLOT_BAG_0 << 8 | i,false) == EQUIP_ERR_OK)
                {
                    remcount += pItem->GetCount();
                    DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

                    if (remcount >=count)
                        return;
                }
            }
            else
            {
                ItemRemovedQuestCheck(pItem->GetEntry(), count - remcount);
                pItem->SetCount(pItem->GetCount() - count + remcount);
                if (IsInWorld() & update)
                    pItem->SendCreateUpdateToPlayer(this);
                pItem->SetState(ITEM_CHANGED, this);
                return;
            }
        }
    }

    //in Bank also
    if (inBankAlso)
    {
        for (int i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; i++)
        {
            Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem->GetEntry() == item)
                DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
        }

        for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            if (Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                {
                    Item* pItem = GetItemByPos(i, j);
                    if (pItem && pItem->GetEntry() == item)
                    {
                        pBag->RemoveItem(j, update);
                    }
                }
            }
        }
    }
}

void Player::DestroyZoneLimitedItem(bool update, uint32 new_zone)
{
    sLog.outDebug("STORAGE: DestroyZoneLimitedItem in map %u and area %u", GetMapId(), new_zone);

    // in inventory
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->IsLimitedToAnotherMapOrZone(GetMapId(),new_zone))
            DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
    }
    for (int i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
    {
        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->IsLimitedToAnotherMapOrZone(GetMapId(),new_zone))
            DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
    }

    // in inventory bags
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pBag)
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                Item* pItem = pBag->GetItemByPos(j);
                if (pItem && pItem->IsLimitedToAnotherMapOrZone(GetMapId(),new_zone))
                    DestroyItem(i, j, update);
            }
        }
    }

    // in equipment and bag list
    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->IsLimitedToAnotherMapOrZone(GetMapId(),new_zone))
            DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
    }
}

void Player::DestroyConjuredItems(bool update)
{
    // used when entering arena
    // destroys all conjured items
    sLog.outDebug("STORAGE: DestroyConjuredItems");

    // in inventory
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->IsConjuredConsumable())
            DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
    }

    // in inventory bags
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pBag)
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                Item* pItem = pBag->GetItemByPos(j);
                if (pItem && pItem->IsConjuredConsumable())
                    DestroyItem(i, j, update);
            }
        }
    }

    // in equipment and bag list
    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->IsConjuredConsumable())
            DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
    }
}

void Player::DestroyItemCount(Item* pItem, uint32 &count, bool update)
{
    if (!pItem)
        return;

    sLog.outDebug("STORAGE: DestroyItemCount item (GUID: %u, Entry: %u) count = %u", pItem->GetGUIDLow(),pItem->GetEntry(), count);

    if (pItem->GetCount() <= count)
    {
        count-= pItem->GetCount();

        DestroyItem(pItem->GetBagSlot(),pItem->GetSlot(), update);
    }
    else
    {
        ItemRemovedQuestCheck(pItem->GetEntry(), count);
        pItem->SetCount(pItem->GetCount() - count);
        count = 0;
        if (IsInWorld() & update)
            pItem->SendCreateUpdateToPlayer(this);
        pItem->SetState(ITEM_CHANGED, this);
    }
}

void Player::SplitItem(uint16 src, uint16 dst, uint32 count)
{
    uint8 srcbag = src >> 8;
    uint8 srcslot = src & 255;

    uint8 dstbag = dst >> 8;
    uint8 dstslot = dst & 255;

    Item *pSrcItem = GetItemByPos(srcbag, srcslot);
    if (!pSrcItem)
    {
        SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pSrcItem, NULL);
        return;
    }

    // not let split all items (can be only at cheating)
    if (pSrcItem->GetCount() == count)
    {
        SendEquipError(EQUIP_ERR_COULDNT_SPLIT_ITEMS, pSrcItem, NULL);
        return;
    }

    // not let split more existed items (can be only at cheating)
    if (pSrcItem->GetCount() < count)
    {
        SendEquipError(EQUIP_ERR_TRIED_TO_SPLIT_MORE_THAN_COUNT, pSrcItem, NULL);
        return;
    }

    if (pSrcItem->m_lootGenerated)                           // prevent split looting item (item
    {
        //best error message found for attempting to split while looting
        SendEquipError(EQUIP_ERR_COULDNT_SPLIT_ITEMS, pSrcItem, NULL);
        return;
    }

    sLog.outDebug("STORAGE: SplitItem bag = %u, slot = %u, item = %u, count = %u", dstbag, dstslot, pSrcItem->GetEntry(), count);
    Item *pNewItem = pSrcItem->CloneItem(count, this);
    if (!pNewItem)
    {
        SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pSrcItem, NULL);
        return;
    }

    if (IsInventoryPos(dst))
    {
        // change item amount before check (for unique max count check)
        pSrcItem->SetCount(pSrcItem->GetCount() - count);

        ItemPosCountVec dest;
        uint8 msg = CanStoreItem(dstbag, dstslot, dest, pNewItem, false);
        if (msg != EQUIP_ERR_OK)
        {
            delete pNewItem;
            pSrcItem->SetCount(pSrcItem->GetCount() + count);
            SendEquipError(msg, pSrcItem, NULL);
            return;
        }

        if (IsInWorld())
            pSrcItem->SendCreateUpdateToPlayer(this);
        pSrcItem->SetState(ITEM_CHANGED, this);
        StoreItem(dest, pNewItem, true);
    }
    else if (IsBankPos (dst))
    {
        // change item amount before check (for unique max count check)
        pSrcItem->SetCount(pSrcItem->GetCount() - count);

        ItemPosCountVec dest;
        uint8 msg = CanBankItem(dstbag, dstslot, dest, pNewItem, false);
        if (msg != EQUIP_ERR_OK)
        {
            delete pNewItem;
            pSrcItem->SetCount(pSrcItem->GetCount() + count);
            SendEquipError(msg, pSrcItem, NULL);
            return;
        }

        if (IsInWorld())
            pSrcItem->SendCreateUpdateToPlayer(this);
        pSrcItem->SetState(ITEM_CHANGED, this);
        BankItem(dest, pNewItem, true);
    }
    else if (IsEquipmentPos (dst))
    {
        // change item amount before check (for unique max count check), provide space for splitted items
        pSrcItem->SetCount(pSrcItem->GetCount() - count);

        uint16 dest;
        uint8 msg = CanEquipItem(dstslot, dest, pNewItem, false);
        if (msg != EQUIP_ERR_OK)
        {
            delete pNewItem;
            pSrcItem->SetCount(pSrcItem->GetCount() + count);
            SendEquipError(msg, pSrcItem, NULL);
            return;
        }

        if (IsInWorld())
            pSrcItem->SendCreateUpdateToPlayer(this);
        pSrcItem->SetState(ITEM_CHANGED, this);
        EquipItem(dest, pNewItem, true);
        AutoUnequipOffhandIfNeed();
    }
}

void Player::SwapItem(uint16 src, uint16 dst)
{
    uint8 srcbag = src >> 8;
    uint8 srcslot = src & 255;

    uint8 dstbag = dst >> 8;
    uint8 dstslot = dst & 255;

    Item *pSrcItem = GetItemByPos(srcbag, srcslot);
    Item *pDstItem = GetItemByPos(dstbag, dstslot);

    if (!pSrcItem)
        return;

    sLog.outDebug("STORAGE: SwapItem bag = %u, slot = %u, item = %u", dstbag, dstslot, pSrcItem->GetEntry());

    if (!isAlive())
    {
        SendEquipError(EQUIP_ERR_YOU_ARE_DEAD, pSrcItem, pDstItem);
        return;
    }

    if (pSrcItem->m_lootGenerated)                           // prevent swap looting item
    {
        //best error message found for attempting to swap while looting
        SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pSrcItem, NULL);
        return;
    }

    // check unequip potability for equipped items and bank bags
    if (IsEquipmentPos (src) || IsBagPos (src))
    {
        // bags can be swapped with empty bag slots
        uint8 msg = CanUnequipItem(src, !IsBagPos (src) || IsBagPos (dst) || (pDstItem && pDstItem->IsBag() && ((Bag*)pDstItem)->IsEmpty()));
        if (msg != EQUIP_ERR_OK)
        {
            SendEquipError(msg, pSrcItem, pDstItem);
            return;
        }
    }

    // prevent put equipped/bank bag in self
    if (IsBagPos (src) && srcslot == dstbag)
    {
        SendEquipError(EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG, pSrcItem, pDstItem);
        return;
    }

    // prevent equipping bag in the same slot from its inside
    if (IsBagPos(dst) && srcbag == dstslot)
    {
        SendEquipError(EQUIP_ERR_ITEMS_CANT_BE_SWAPPED, pSrcItem, pDstItem);
        return;
    }

    if (isInCombat())
    {
        InterruptNonMeleeSpells(false);
        resetAttackTimer(BASE_ATTACK);
        resetAttackTimer(OFF_ATTACK);
        resetAttackTimer(RANGED_ATTACK);
    }

    // DST checks
    if (pDstItem)
    {
        if (pDstItem->m_lootGenerated)                       // prevent swap looting item
        {
            //best error message found for attempting to swap while looting
            SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pDstItem, NULL);
            return;
        }

        // check unequip potability for equipped items and bank bags
        if (IsEquipmentPos (dst) || IsBagPos (dst))
        {
            // bags can be swapped with empty bag slots, or with empty bag (items move possibility checked later)
            uint8 msg = CanUnequipItem(dst, !IsBagPos (dst) || IsBagPos (src) || (pSrcItem->IsBag() && ((Bag*)pSrcItem)->IsEmpty()));
            if (msg != EQUIP_ERR_OK)
            {
                SendEquipError(msg, pSrcItem, pDstItem);
                return;
            }
        }
    }

    // NOW this is or item move (swap with empty), or swap with another item (including bags in bag possitions)
    // or swap empty bag with another empty or not empty bag (with items exchange)

    // Move case
    if (!pDstItem)
    {
        if (IsInventoryPos(dst))
        {
            ItemPosCountVec dest;
            uint8 msg = CanStoreItem(dstbag, dstslot, dest, pSrcItem, false);
            if (msg != EQUIP_ERR_OK)
            {
                SendEquipError(msg, pSrcItem, NULL);
                return;
            }

            RemoveItem(srcbag, srcslot, true);
            StoreItem(dest, pSrcItem, true);
        }
        else if (IsBankPos (dst))
        {
            ItemPosCountVec dest;
            uint8 msg = CanBankItem(dstbag, dstslot, dest, pSrcItem, false);
            if (msg != EQUIP_ERR_OK)
            {
                SendEquipError(msg, pSrcItem, NULL);
                return;
            }

            RemoveItem(srcbag, srcslot, true);
            BankItem(dest, pSrcItem, true);
        }
        else if (IsEquipmentPos (dst))
        {
            uint16 dest;
            uint8 msg = CanEquipItem(dstslot, dest, pSrcItem, false);
            if (msg != EQUIP_ERR_OK)
            {
                SendEquipError(msg, pSrcItem, NULL);
                return;
            }

            RemoveItem(srcbag, srcslot, true);
            EquipItem(dest, pSrcItem, true);
            AutoUnequipOffhandIfNeed();
        }
        return;
    }

    // attempt merge to / fill target item
    if (!pSrcItem->IsBag() && !pDstItem->IsBag())
    {
        uint8 msg;
        ItemPosCountVec sDest;
        uint16 eDest = 0;
        if (IsInventoryPos(dst))
            msg = CanStoreItem(dstbag, dstslot, sDest, pSrcItem, false);
        else if (IsBankPos (dst))
            msg = CanBankItem(dstbag, dstslot, sDest, pSrcItem, false);
        else if (IsEquipmentPos (dst))
            msg = CanEquipItem(dstslot, eDest, pSrcItem, false);
        else
            return;

        // can be merge/fill
        if (msg == EQUIP_ERR_OK)
        {
            if (pSrcItem->GetCount() + pDstItem->GetCount() <= pSrcItem->GetProto()->Stackable)
            {
                RemoveItem(srcbag, srcslot, true);

                if (IsInventoryPos(dst))
                    StoreItem(sDest, pSrcItem, true);
                else if (IsBankPos (dst))
                    BankItem(sDest, pSrcItem, true);
                else if (IsEquipmentPos (dst))
                {
                    EquipItem(eDest, pSrcItem, true);
                    AutoUnequipOffhandIfNeed();
                }
            }
            else
            {
                pSrcItem->SetCount(pSrcItem->GetCount() + pDstItem->GetCount() - pSrcItem->GetProto()->Stackable);
                pDstItem->SetCount(pSrcItem->GetProto()->Stackable);
                pSrcItem->SetState(ITEM_CHANGED, this);
                pDstItem->SetState(ITEM_CHANGED, this);
                if (IsInWorld())
                {
                    pSrcItem->SendCreateUpdateToPlayer(this);
                    pDstItem->SendCreateUpdateToPlayer(this);
                }
            }
            return;
        }
    }

    // impossible merge/fill, do real swap
    uint8 msg = EQUIP_ERR_OK;

    // check src->dest move possibility
    ItemPosCountVec sDest;
    uint16 eDest = 0;
    if (IsInventoryPos(dst))
        msg = CanStoreItem(dstbag, dstslot, sDest, pSrcItem, true);
    else if (IsBankPos(dst))
        msg = CanBankItem(dstbag, dstslot, sDest, pSrcItem, true);
    else if (IsEquipmentPos(dst))
    {
        msg = CanEquipItem(dstslot, eDest, pSrcItem, true);
        if (msg == EQUIP_ERR_OK)
            msg = CanUnequipItem(eDest, true);
    }

    if (msg != EQUIP_ERR_OK)
    {
        SendEquipError(msg, pSrcItem, pDstItem);
        return;
    }

    // check dest->src move possibility
    ItemPosCountVec sDest2;
    uint16 eDest2 = 0;
    if (IsInventoryPos(src))
        msg = CanStoreItem(srcbag, srcslot, sDest2, pDstItem, true);
    else if (IsBankPos(src))
        msg = CanBankItem(srcbag, srcslot, sDest2, pDstItem, true);
    else if (IsEquipmentPos(src))
    {
        msg = CanEquipItem(srcslot, eDest2, pDstItem, true);
        if (msg == EQUIP_ERR_OK)
            msg = CanUnequipItem(eDest2, true);
    }

    if (msg != EQUIP_ERR_OK)
    {
        SendEquipError(msg, pDstItem, pSrcItem);
        return;
    }

    // Check bag swap with item exchange (one from empty in not bag possition (equipped (not possible in fact) or store)
    if (pSrcItem->IsBag() && pDstItem->IsBag())
    {
        Bag* emptyBag = NULL;
        Bag* fullBag = NULL;
        if (((Bag*)pSrcItem)->IsEmpty() && !IsBagPos(src))
        {
            emptyBag = (Bag*)pSrcItem;
            fullBag  = (Bag*)pDstItem;
        }
        else if (((Bag*)pDstItem)->IsEmpty() && !IsBagPos(dst))
        {
            emptyBag = (Bag*)pDstItem;
            fullBag  = (Bag*)pSrcItem;
        }

        // bag swap (with items exchange) case
        if (emptyBag && fullBag)
        {
            ItemPrototype const* emptyProto = emptyBag->GetProto();

            uint32 count = 0;

            for (uint32 i=0; i < fullBag->GetBagSize(); ++i)
            {
                Item *bagItem = fullBag->GetItemByPos(i);
                if (!bagItem)
                    continue;

                ItemPrototype const* bagItemProto = bagItem->GetProto();
                if (!bagItemProto || !ItemCanGoIntoBag(bagItemProto, emptyProto))
                {
                    // one from items not go to empty target bag
                    SendEquipError(EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG, pSrcItem, pDstItem);
                    return;
                }

                ++count;
            }

            if (count > emptyBag->GetBagSize())
            {
                // too small targeted bag
                SendEquipError(EQUIP_ERR_ITEMS_CANT_BE_SWAPPED, pSrcItem, pDstItem);
                return;
            }

            // Items swap
            count = 0;                                      // will pos in new bag
            for (uint32 i = 0; i< fullBag->GetBagSize(); ++i)
            {
                Item *bagItem = fullBag->GetItemByPos(i);
                if (!bagItem)
                    continue;

                fullBag->RemoveItem(i, true);
                emptyBag->StoreItem(count, bagItem, true);
                bagItem->SetState(ITEM_CHANGED, this);

                ++count;
            }
        }
    }

    // now do moves, remove...
    RemoveItem(dstbag, dstslot, false);
    RemoveItem(srcbag, srcslot, false);

    // add to dest
    if (IsInventoryPos(dst))
        StoreItem(sDest, pSrcItem, true);
    else if (IsBankPos(dst))
        BankItem(sDest, pSrcItem, true);
    else if (IsEquipmentPos(dst))
        EquipItem(eDest, pSrcItem, true);

    // add to src
    if (IsInventoryPos(src))
        StoreItem(sDest2, pDstItem, true);
    else if (IsBankPos(src))
        BankItem(sDest2, pDstItem, true);
    else if (IsEquipmentPos(src))
        EquipItem(eDest2, pDstItem, true);

    // if player is moving bags and is looting an item inside this bag
    // release the loot
    if (GetLootGUID())
    {
        bool released = false;
        if (IsBagPos(src))
        {
            Bag* bag = (Bag*)pSrcItem;
            for (int i=0; i < bag->GetBagSize(); ++i)
            {
                if (Item *bagItem = bag->GetItemByPos(i))
                {
                    if (bagItem->m_lootGenerated)
                    {
                        m_session->DoLootRelease(GetLootGUID());
                        released = true;                    // so we don't need to look at dstBag
                        break;
                    }
                }
            }
        }

        if (!released && IsBagPos(dst) && pDstItem)
        {
            Bag* bag = (Bag*)pDstItem;
            for (int i=0; i < bag->GetBagSize(); ++i)
            {
                if (Item *bagItem = bag->GetItemByPos(i))
                {
                    if (bagItem->m_lootGenerated)
                    {
                        m_session->DoLootRelease(GetLootGUID());
                        released = true;                    // not realy needed here
                        break;
                    }
                }
            }
        }
    }

    AutoUnequipOffhandIfNeed();
}

void Player::AddItemToBuyBackSlot(Item *pItem)
{
    if (pItem)
    {
        uint32 slot = m_currentBuybackSlot;
        // if current back slot non-empty search oldest or free
        if (m_items[slot])
        {
            uint32 oldest_time = GetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1);
            uint32 oldest_slot = BUYBACK_SLOT_START;

            for (uint32 i = BUYBACK_SLOT_START+1; i < BUYBACK_SLOT_END; ++i)
            {
                // found empty
                if (!m_items[i])
                {
                    slot = i;
                    break;
                }

                uint32 i_time = GetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + i - BUYBACK_SLOT_START);

                if (oldest_time > i_time)
                {
                    oldest_time = i_time;
                    oldest_slot = i;
                }
            }

            // find oldest
            slot = oldest_slot;
        }

        RemoveItemFromBuyBackSlot(slot, true);
        sLog.outDebug("STORAGE: AddItemToBuyBackSlot item = %u, slot = %u", pItem->GetEntry(), slot);

        m_items[slot] = pItem;
        time_t base = time(NULL);
        uint32 etime = uint32(base - m_logintime + (30 * 3600));
        uint32 eslot = slot - BUYBACK_SLOT_START;

        SetUInt64Value(PLAYER_FIELD_VENDORBUYBACK_SLOT_1 + eslot * 2, pItem->GetGUID());
        ItemPrototype const *pProto = pItem->GetProto();
        if (pProto)
            SetUInt32Value(PLAYER_FIELD_BUYBACK_PRICE_1 + eslot, pProto->SellPrice * pItem->GetCount());
        else
            SetUInt32Value(PLAYER_FIELD_BUYBACK_PRICE_1 + eslot, 0);
        SetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + eslot, (uint32)etime);

        // move to next (for non filled list is move most optimized choice)
        if (m_currentBuybackSlot < BUYBACK_SLOT_END-1)
            ++m_currentBuybackSlot;
    }
}

Item* Player::GetItemFromBuyBackSlot(uint32 slot)
{
    sLog.outDebug("STORAGE: GetItemFromBuyBackSlot slot = %u", slot);
    if (slot >= BUYBACK_SLOT_START && slot < BUYBACK_SLOT_END)
        return m_items[slot];
    return NULL;
}

void Player::RemoveItemFromBuyBackSlot(uint32 slot, bool del)
{
    sLog.outDebug("STORAGE: RemoveItemFromBuyBackSlot slot = %u", slot);
    if (slot >= BUYBACK_SLOT_START && slot < BUYBACK_SLOT_END)
    {
        Item *pItem = m_items[slot];
        if (pItem)
        {
            pItem->RemoveFromWorld();
            if (del) pItem->SetState(ITEM_REMOVED, this);
        }

        m_items[slot] = NULL;

        uint32 eslot = slot - BUYBACK_SLOT_START;
        SetUInt64Value(PLAYER_FIELD_VENDORBUYBACK_SLOT_1 + eslot * 2, 0);
        SetUInt32Value(PLAYER_FIELD_BUYBACK_PRICE_1 + eslot, 0);
        SetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + eslot, 0);

        // if current backslot is filled set to now free slot
        if (m_items[m_currentBuybackSlot])
            m_currentBuybackSlot = slot;
    }
}

void Player::SendEquipError(uint8 msg, Item* pItem, Item *pItem2)
{
    sLog.outDebug("WORLD: Sent SMSG_INVENTORY_CHANGE_FAILURE (%u)",msg);
    WorldPacket data(SMSG_INVENTORY_CHANGE_FAILURE, (msg == EQUIP_ERR_CANT_EQUIP_LEVEL_I ? 22 : 18));
    data << uint8(msg);

    if (msg)
    {
        data << uint64(pItem ? pItem->GetGUID() : 0);
        data << uint64(pItem2 ? pItem2->GetGUID() : 0);
        data << uint8(0);                                   // not 0 there...

        if (msg == EQUIP_ERR_CANT_EQUIP_LEVEL_I)
        {
            uint32 level = 0;

            if (pItem)
                if (ItemPrototype const* proto =  pItem->GetProto())
                    level = proto->RequiredLevel;

            data << uint32(level);                          // new 2.4.0
        }
    }
    SendPacketToSelf(&data);
}

void Player::SendBuyError(uint8 msg, Creature* pCreature, uint32 item, uint32 param)
{
    sLog.outDebug("WORLD: Sent SMSG_BUY_FAILED");
    WorldPacket data(SMSG_BUY_FAILED, (8+4+4+1));
    data << uint64(pCreature ? pCreature->GetGUID() : 0);
    data << uint32(item);
    if (param > 0)
        data << uint32(param);
    data << uint8(msg);
    SendPacketToSelf(&data);
}

void Player::SendSellError(uint8 msg, Creature* pCreature, uint64 guid, uint32 param)
{
    sLog.outDebug("WORLD: Sent SMSG_SELL_ITEM");
    WorldPacket data(SMSG_SELL_ITEM,(8+8+(param?4:0)+1));  // last check 2.0.10
    data << uint64(pCreature ? pCreature->GetGUID() : 0);
    data << uint64(guid);
    if (param > 0)
        data << uint32(param);
    data << uint8(msg);
    SendPacketToSelf(&data);
}

void Player::ClearTrade()
{
    tradeGold = 0;
    acceptTrade = false;
    for (int i = 0; i < TRADE_SLOT_COUNT; i++)
        tradeItems[i] = NULL_SLOT;
}

void Player::TradeCancel(bool sendback)
{
    if (pTrader)
    {
        // send yellow "Trade canceled" message to both traders
        WorldSession* ws;
        ws = GetSession();
        if (sendback)
            ws->SendCancelTrade();
        ws = pTrader->GetSession();
        if (!ws->PlayerLogout())
            ws->SendCancelTrade();

        // cleanup
        ClearTrade();
        pTrader->ClearTrade();
        // prevent loss of reference
        pTrader->pTrader = NULL;
        pTrader = NULL;
    }
}

void Player::UpdateItemDuration(uint32 time, bool realtimeonly)
{
    if (m_itemDuration.empty())
        return;

    sLog.outDebug("Player::UpdateItemDuration(%u,%u)", time,realtimeonly);

    for (ItemDurationList::iterator itr = m_itemDuration.begin();itr != m_itemDuration.end();)
    {
        Item* item = *itr;
        ++itr;                                              // current element can be erased in UpdateDuration

        if (realtimeonly && item->GetProto()->Duration < 0 || !realtimeonly)
            item->UpdateDuration(this,time);
    }
}

void Player::UpdateEnchantTime(uint32 time)
{
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(),next;itr != m_enchantDuration.end();itr=next)
    {
        ASSERT(itr->item);
        next=itr;
        if (!itr->item->GetEnchantmentId(itr->slot))
        {
            next = m_enchantDuration.erase(itr);
        }
        else if (itr->leftduration <= time)
        {
            ApplyEnchantment(itr->item,itr->slot,false,false);
            itr->item->ClearEnchantment(itr->slot);
            next = m_enchantDuration.erase(itr);
        }
        else if (itr->leftduration > time)
        {
            itr->leftduration -= time;
            ++next;
        }
    }
}

void Player::AddEnchantmentDurations(Item *item)
{
    for (int x=0;x<MAX_ENCHANTMENT_SLOT;++x)
    {
        if (!item->GetEnchantmentId(EnchantmentSlot(x)))
            continue;

        uint32 duration = item->GetEnchantmentDuration(EnchantmentSlot(x));
        if (duration > 0)
            AddEnchantmentDuration(item,EnchantmentSlot(x),duration);
    }
}

void Player::RemoveEnchantmentDurations(Item *item)
{
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin();itr != m_enchantDuration.end();)
    {
        if (itr->item == item)
        {
            // save duration in item
            item->SetEnchantmentDuration(EnchantmentSlot(itr->slot),itr->leftduration);
            itr = m_enchantDuration.erase(itr);
        }
        else
            ++itr;
    }
}

void Player::RemoveAllEnchantments(EnchantmentSlot slot, bool arena)
{
    // remove enchantments from equipped items first to clean up the m_enchantDuration list
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(),next;itr != m_enchantDuration.end();itr=next)
    {
        next = itr;
        if (itr->slot == slot)
        {
            if (arena && itr->item)
            {
                uint32 enchant_id = itr->item->GetEnchantmentId(slot);
                if (enchant_id)
                {
                    SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
                    if (pEnchant && pEnchant->aura_id == ITEM_ENCHANTMENT_AURAID_POISON)
                    {
                        ++next;
                        continue;
                    }
                }
            }

            if (itr->item && itr->item->GetEnchantmentId(slot))
            {
                // remove from stats
                ApplyEnchantment(itr->item,slot,false,false);
                // remove visual
                itr->item->ClearEnchantment(slot);
            }
            // remove from update list
            next = m_enchantDuration.erase(itr);
        }
        else
            ++next;
    }

    // remove enchants from inventory items
    // NOTE: no need to remove these from stats, since these aren't equipped
    // in inventory
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEnchantmentId(slot))
        {
            if (arena)
            {
                SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(pItem->GetEnchantmentId(slot));
                if (pEnchant && pEnchant->aura_id == ITEM_ENCHANTMENT_AURAID_POISON)
                    continue;
            }
            pItem->ClearEnchantment(slot);
        }
    }

    // in inventory bags
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        Bag *pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pBag)
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                Item *pItem = pBag->GetItemByPos(j);
                if (pItem && pItem->GetEnchantmentId(slot))
                {
                    if (arena)
                    {
                        SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(pItem->GetEnchantmentId(slot));
                        if (pEnchant && pEnchant->aura_id == ITEM_ENCHANTMENT_AURAID_POISON)
                            continue;
                    }
                    pItem->ClearEnchantment(slot);
                }
            }
        }
    }
}

// duration == 0 will remove item enchant
void Player::AddEnchantmentDuration(Item *item,EnchantmentSlot slot,uint32 duration)
{
    if (!item)
        return;

    if (slot >= MAX_ENCHANTMENT_SLOT)
        return;

    for (EnchantDurationList::iterator itr = m_enchantDuration.begin();itr != m_enchantDuration.end();++itr)
    {
        if (itr->item == item && itr->slot == slot)
        {
            itr->item->SetEnchantmentDuration(itr->slot,itr->leftduration);
            m_enchantDuration.erase(itr);
            break;
        }
    }
    if (item && duration > 0)
    {
        GetSession()->SendItemEnchantTimeUpdate(GetGUID(), item->GetGUID(),slot,uint32(duration/1000));
        m_enchantDuration.push_back(EnchantDuration(item,slot,duration));
    }
}

void Player::ApplyEnchantment(Item *item,bool apply)
{
    for (uint32 slot = 0; slot < MAX_ENCHANTMENT_SLOT; ++slot)
        ApplyEnchantment(item, EnchantmentSlot(slot), apply);
}

void Player::ApplyEnchantment(Item *item,EnchantmentSlot slot,bool apply, bool apply_dur, bool ignore_condition)
{
    if (!item)
        return;

    if (!item->IsEquipped())
        return;

    if (slot >= MAX_ENCHANTMENT_SLOT)
        return;

    uint32 enchant_id = item->GetEnchantmentId(slot);
    if (!enchant_id)
        return;

    SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
    if (!pEnchant)
        return;

    if (!ignore_condition && pEnchant->EnchantmentCondition && !((Player*)this)->EnchantmentFitsRequirements(pEnchant->EnchantmentCondition, -1))
        return;

    if (!item->IsBroken() || !apply)
    {
        for (int s=0; s<3; s++)
        {
            uint32 enchant_display_type = pEnchant->type[s];
            uint32 enchant_amount = pEnchant->amount[s];
            uint32 enchant_spell_id = pEnchant->spellid[s];

            switch (enchant_display_type)
            {
            case ITEM_ENCHANTMENT_TYPE_NONE:
                break;
            case ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL:
                // processed in Player::CastItemCombatSpell
                break;
            case ITEM_ENCHANTMENT_TYPE_DAMAGE:
                if (item->GetSlot() == EQUIPMENT_SLOT_MAINHAND)
                    HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_VALUE, float(enchant_amount), apply);
                else if (item->GetSlot() == EQUIPMENT_SLOT_OFFHAND)
                    HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_VALUE, float(enchant_amount), apply);
                else if (item->GetSlot() == EQUIPMENT_SLOT_RANGED)
                    HandleStatModifier(UNIT_MOD_DAMAGE_RANGED, TOTAL_VALUE, float(enchant_amount), apply);
                break;
            case ITEM_ENCHANTMENT_TYPE_EQUIP_SPELL:
                if (enchant_spell_id)
                {
                    SpellEntry const *temp = sSpellStore.LookupEntry(enchant_spell_id);
                    if (!temp) // unsupported enchant support
                    {
                        switch(enchant_spell_id)
                        {
                            case 22841: //arcanum of rapidity
                                {
                                    enchant_spell_id=13928;
                                    break;
                                }
                            case 22847: //arcanum of protection
                                {
                                    enchant_spell_id=13669;
                                    break;
                                }
                            case 22755: //elemental sharpening stone
                                {
                                    enchant_spell_id=7598;
                                    break;
                                }
                            case 22843: //arcanum of focus
                                {
                                    enchant_spell_id=9398;
                                    break;
                                }
                            case 28162: //savage guard
                                {
                                    enchant_spell_id=14630;
                                    break;
                                }
                            case 28164: //ice guard
                                {
                                    enchant_spell_id=14550;
                                    break;
                                }
                            case 28166: //shadow guard 
                                {
                                    enchant_spell_id=14673;
                                    break;
                                }
                        }
                    }

                    if (apply)
                    {
                        int32 basepoints = 0;
                        // Random Property Exist - try found basepoints for spell (basepoints depends from item suffix factor)
                        if (item->GetItemRandomPropertyId())
                        {
                            ItemRandomSuffixEntry const *item_rand = sItemRandomSuffixStore.LookupEntry(abs(item->GetItemRandomPropertyId()));
                            if (item_rand)
                            {
                                // Search enchant_amount
                                for (int k=0; k<3; k++)
                                {
                                    if (item_rand->enchant_id[k] == enchant_id)
                                    {
                                        basepoints = int32((item_rand->prefix[k]*item->GetItemSuffixFactor()) / 10000);
                                        break;
                                    }
                                }
                            }
                        }
                        // Cast custom spell vs all equal basepoints getted from enchant_amount
                        if (basepoints)
                            CastCustomSpell(this,enchant_spell_id,&basepoints,&basepoints,&basepoints,true,item);
                        else
                            CastSpell(this,enchant_spell_id,true,item);
                    }
                    else
                        RemoveAurasDueToItemSpell(item,enchant_spell_id);
                }
                break;
            case ITEM_ENCHANTMENT_TYPE_RESISTANCE:
                if (!enchant_amount)
                {
                    ItemRandomSuffixEntry const *item_rand = sItemRandomSuffixStore.LookupEntry(abs(item->GetItemRandomPropertyId()));
                    if (item_rand)
                    {
                        for (int k=0; k<3; k++)
                        {
                            if (item_rand->enchant_id[k] == enchant_id)
                            {
                                enchant_amount = uint32((item_rand->prefix[k]*item->GetItemSuffixFactor()) / 10000);
                                break;
                            }
                        }
                    }
                }

                HandleStatModifier(UnitMods(UNIT_MOD_RESISTANCE_START + enchant_spell_id), TOTAL_VALUE, float(enchant_amount), apply);
                break;
            case ITEM_ENCHANTMENT_TYPE_STAT:
                {
                    if (!enchant_amount)
                    {
                        ItemRandomSuffixEntry const *item_rand_suffix = sItemRandomSuffixStore.LookupEntry(abs(item->GetItemRandomPropertyId()));
                        if (item_rand_suffix)
                        {
                            for (int k=0; k<3; k++)
                            {
                                if (item_rand_suffix->enchant_id[k] == enchant_id)
                                {
                                    enchant_amount = uint32((item_rand_suffix->prefix[k]*item->GetItemSuffixFactor()) / 10000);
                                    break;
                                }
                            }
                        }
                    }

                    sLog.outDebug("Adding %u to stat nb %u",enchant_amount,enchant_spell_id);
                    switch (enchant_spell_id)
                    {
                    case ITEM_MOD_AGILITY:
                        sLog.outDebug("+ %u AGILITY",enchant_amount);
                        HandleStatModifier(UNIT_MOD_STAT_AGILITY, TOTAL_VALUE, float(enchant_amount), apply);
                        ApplyStatBuffMod(STAT_AGILITY, enchant_amount, apply);
                        break;
                    case ITEM_MOD_STRENGTH:
                        sLog.outDebug("+ %u STRENGTH",enchant_amount);
                        HandleStatModifier(UNIT_MOD_STAT_STRENGTH, TOTAL_VALUE, float(enchant_amount), apply);
                        ApplyStatBuffMod(STAT_STRENGTH, enchant_amount, apply);
                        break;
                    case ITEM_MOD_INTELLECT:
                        sLog.outDebug("+ %u INTELLECT",enchant_amount);
                        HandleStatModifier(UNIT_MOD_STAT_INTELLECT, TOTAL_VALUE, float(enchant_amount), apply);
                        ApplyStatBuffMod(STAT_INTELLECT, enchant_amount, apply);
                        break;
                    case ITEM_MOD_SPIRIT:
                        sLog.outDebug("+ %u SPIRIT",enchant_amount);
                        HandleStatModifier(UNIT_MOD_STAT_SPIRIT, TOTAL_VALUE, float(enchant_amount), apply);
                        ApplyStatBuffMod(STAT_SPIRIT, enchant_amount, apply);
                        break;
                    case ITEM_MOD_STAMINA:
                        sLog.outDebug("+ %u STAMINA",enchant_amount);
                        HandleStatModifier(UNIT_MOD_STAT_STAMINA, TOTAL_VALUE, float(enchant_amount), apply);
                        ApplyStatBuffMod(STAT_STAMINA, enchant_amount, apply);
                        break;
                    case ITEM_MOD_DEFENSE_SKILL_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_DEFENSE_SKILL, enchant_amount, apply);
                        sLog.outDebug("+ %u DEFENCE", enchant_amount);
                        break;
                    case  ITEM_MOD_DODGE_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_DODGE, enchant_amount, apply);
                        sLog.outDebug("+ %u DODGE", enchant_amount);
                        break;
                    case ITEM_MOD_PARRY_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_PARRY, enchant_amount, apply);
                        sLog.outDebug("+ %u PARRY", enchant_amount);
                        break;
                    case ITEM_MOD_BLOCK_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_BLOCK, enchant_amount, apply);
                        sLog.outDebug("+ %u SHIELD_BLOCK", enchant_amount);
                        break;
                    case ITEM_MOD_HIT_MELEE_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_HIT_MELEE, enchant_amount, apply);
                        sLog.outDebug("+ %u MELEE_HIT", enchant_amount);
                        break;
                    case ITEM_MOD_HIT_RANGED_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_HIT_RANGED, enchant_amount, apply);
                        sLog.outDebug("+ %u RANGED_HIT", enchant_amount);
                        break;
                    case ITEM_MOD_HIT_SPELL_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_HIT_SPELL, enchant_amount, apply);
                        sLog.outDebug("+ %u SPELL_HIT", enchant_amount);
                        break;
                    case ITEM_MOD_CRIT_MELEE_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_CRIT_MELEE, enchant_amount, apply);
                        sLog.outDebug("+ %u MELEE_CRIT", enchant_amount);
                        break;
                    case ITEM_MOD_CRIT_RANGED_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_CRIT_RANGED, enchant_amount, apply);
                        sLog.outDebug("+ %u RANGED_CRIT", enchant_amount);
                        break;
                    case ITEM_MOD_CRIT_SPELL_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_CRIT_SPELL, enchant_amount, apply);
                        sLog.outDebug("+ %u SPELL_CRIT", enchant_amount);
                        break;
                        //                    Values from ITEM_STAT_MELEE_HA_RATING to ITEM_MOD_HASTE_RANGED_RATING are never used
                        //                    in Enchantments
                        //                    case ITEM_MOD_HIT_TAKEN_MELEE_RATING:
                        //                        ((Player*)this)->ApplyRatingMod(CR_HIT_TAKEN_MELEE, enchant_amount, apply);
                        //                        break;
                        //                    case ITEM_MOD_HIT_TAKEN_RANGED_RATING:
                        //                        ((Player*)this)->ApplyRatingMod(CR_HIT_TAKEN_RANGED, enchant_amount, apply);
                        //                        break;
                        //                    case ITEM_MOD_HIT_TAKEN_SPELL_RATING:
                        //                        ((Player*)this)->ApplyRatingMod(CR_HIT_TAKEN_SPELL, enchant_amount, apply);
                        //                        break;
                        //                    case ITEM_MOD_CRIT_TAKEN_MELEE_RATING:
                        //                        ((Player*)this)->ApplyRatingMod(CR_CRIT_TAKEN_MELEE, enchant_amount, apply);
                        //                        break;
                        //                    case ITEM_MOD_CRIT_TAKEN_RANGED_RATING:
                        //                        ((Player*)this)->ApplyRatingMod(CR_CRIT_TAKEN_RANGED, enchant_amount, apply);
                        //                        break;
                        //                    case ITEM_MOD_CRIT_TAKEN_SPELL_RATING:
                        //                        ((Player*)this)->ApplyRatingMod(CR_CRIT_TAKEN_SPELL, enchant_amount, apply);
                        //                        break;
                        //                    case ITEM_MOD_HASTE_MELEE_RATING:
                        //                        ((Player*)this)->ApplyRatingMod(CR_HASTE_MELEE, enchant_amount, apply);
                        //                        break;
                        //                    case ITEM_MOD_HASTE_RANGED_RATING:
                        //                        ((Player*)this)->ApplyRatingMod(CR_HASTE_RANGED, enchant_amount, apply);
                        //                        break;
                    case ITEM_MOD_HASTE_SPELL_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_HASTE_SPELL, enchant_amount, apply);
                        break;
                    case ITEM_MOD_HIT_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_HIT_MELEE, enchant_amount, apply);
                        ((Player*)this)->ApplyRatingMod(CR_HIT_RANGED, enchant_amount, apply);
                        //((Player*)this)->ApplyRatingMod(CR_HIT_SPELL, enchant_amount, apply);
                        sLog.outDebug("+ %u HIT", enchant_amount);
                        break;
                    case ITEM_MOD_CRIT_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_CRIT_MELEE, enchant_amount, apply);
                        ((Player*)this)->ApplyRatingMod(CR_CRIT_RANGED, enchant_amount, apply);
                        //((Player*)this)->ApplyRatingMod(CR_CRIT_SPELL, enchant_amount, apply);
                        sLog.outDebug("+ %u CRITICAL", enchant_amount);
                        break;
                        //                    Values ITEM_MOD_HIT_TAKEN_RATING and ITEM_MOD_CRIT_TAKEN_RATING are never used in Enchantment
                        //                    case ITEM_MOD_HIT_TAKEN_RATING:
                        //                          ((Player*)this)->ApplyRatingMod(CR_HIT_TAKEN_MELEE, enchant_amount, apply);
                        //                          ((Player*)this)->ApplyRatingMod(CR_HIT_TAKEN_RANGED, enchant_amount, apply);
                        //                          ((Player*)this)->ApplyRatingMod(CR_HIT_TAKEN_SPELL, enchant_amount, apply);
                        //                        break;
                        //                    case ITEM_MOD_CRIT_TAKEN_RATING:
                        //                          ((Player*)this)->ApplyRatingMod(CR_CRIT_TAKEN_MELEE, enchant_amount, apply);
                        //                          ((Player*)this)->ApplyRatingMod(CR_CRIT_TAKEN_RANGED, enchant_amount, apply);
                        //                          ((Player*)this)->ApplyRatingMod(CR_CRIT_TAKEN_SPELL, enchant_amount, apply);
                        //                        break;
                    case ITEM_MOD_RESILIENCE_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_CRIT_TAKEN_MELEE, enchant_amount, apply);
                        ((Player*)this)->ApplyRatingMod(CR_CRIT_TAKEN_RANGED, enchant_amount, apply);
                        ((Player*)this)->ApplyRatingMod(CR_CRIT_TAKEN_SPELL, enchant_amount, apply);
                        sLog.outDebug("+ %u RESILIENCE", enchant_amount);
                        break;
                    case ITEM_MOD_HASTE_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_HASTE_MELEE, enchant_amount, apply);
                        ((Player*)this)->ApplyRatingMod(CR_HASTE_RANGED, enchant_amount, apply);
                        ((Player*)this)->ApplyRatingMod(CR_HASTE_SPELL, enchant_amount, apply);
                        sLog.outDebug("+ %u HASTE", enchant_amount);
                        break;
                    case ITEM_MOD_EXPERTISE_RATING:
                        ((Player*)this)->ApplyRatingMod(CR_EXPERTISE, enchant_amount, apply);
                        sLog.outDebug("+ %u EXPERTISE", enchant_amount);
                        break;
                    default:
                        break;
                    }
                    break;
                }
            case ITEM_ENCHANTMENT_TYPE_TOTEM:               // Shaman Rockbiter Weapon
                {
                    if (getClass() == CLASS_SHAMAN)
                    {
                        float addValue = 0.0f;
                        if (item->GetSlot() == EQUIPMENT_SLOT_MAINHAND)
                        {
                            addValue = float(enchant_amount * item->GetProto()->Delay/1000.0f);
                            HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_VALUE, addValue, apply);
                        }
                        else if (item->GetSlot() == EQUIPMENT_SLOT_OFFHAND)
                        {
                            addValue = float(enchant_amount * item->GetProto()->Delay/1000.0f);
                            HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_VALUE, addValue, apply);
                        }
                    }
                    break;
                }
            default:
                sLog.outLog(LOG_DEFAULT, "ERROR: Unknown item enchantment display type: %d",enchant_display_type);
                break;
            }                                                   /*switch (enchant_display_type)*/
        }                                                       /*for*/
    }

    // visualize enchantment at player and equipped items
    if (slot < MAX_INSPECTED_ENCHANTMENT_SLOT)
    {
        int VisibleBase = PLAYER_VISIBLE_ITEM_1_0 + (item->GetSlot() * MAX_VISIBLE_ITEM_OFFSET);
        SetUInt32Value(VisibleBase + 1 + slot, apply? item->GetEnchantmentId(slot) : 0);
    }

    if (apply_dur)
    {
        if (apply)
        {
            // set duration
            uint32 duration = item->GetEnchantmentDuration(slot);
            if (duration > 0)
                AddEnchantmentDuration(item,slot,duration);
        }
        else
        {
            // duration == 0 will remove EnchantDuration
            AddEnchantmentDuration(item,slot,0);
        }
    }
}

void Player::SendEnchantmentDurations()
{
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin();itr != m_enchantDuration.end();++itr)
    {
        GetSession()->SendItemEnchantTimeUpdate(GetGUID(), itr->item->GetGUID(),itr->slot,uint32(itr->leftduration)/1000);
    }
}

void Player::SendItemDurations()
{
    for (ItemDurationList::iterator itr = m_itemDuration.begin();itr != m_itemDuration.end();++itr)
    {
        (*itr)->SendTimeUpdate(this);
    }
}

void Player::SendNewItem(Item *item, uint32 count, bool received, bool created, bool broadcast)
{
    if (!item)                                               // prevent crash
        return;

                                                            // last check 2.0.10
    WorldPacket data(SMSG_ITEM_PUSH_RESULT, (8+4+4+4+1+4+4+4+4+4));
    data << GetGUID();                                      // player GUID
    data << uint32(received);                               // 0=looted, 1=from npc
    data << uint32(created);                                // 0=received, 1=created
    data << uint32(1);                                      // always 0x01 (probably meant to be count of listed items)
    data << item->GetBagSlot();                             // bagslot
                                                            // item slot, but when added to stack: 0xFFFFFFFF
    data << (uint32) ((item->GetCount()==count) ? item->GetSlot() : -1);
    data << uint32(item->GetEntry());                       // item id
    data << uint32(item->GetItemSuffixFactor());            // SuffixFactor
    data << uint32(item->GetItemRandomPropertyId());        // random item property id
    data << uint32(count);                                  // count of items
    data << GetItemCount(item->GetEntry());                 // count of items in inventory

    if (broadcast && GetGroup())
        GetGroup()->BroadcastPacket(&data, false);
    else
        SendPacketToSelf(&data);
}

/*********************************************************/
/***                    QUEST SYSTEM                   ***/
/*********************************************************/

void Player::PrepareQuestMenu(uint64 guid)
{
    Object *pObject;
    QuestRelations* pObjectQR;
    QuestRelations* pObjectQIR;
    Creature *pCreature = GetMap()->GetCreature(guid);
    if (pCreature)
    {
        pObject = (Object*)pCreature;
        pObjectQR  = &sObjectMgr.mCreatureQuestRelations;
        pObjectQIR = &sObjectMgr.mCreatureQuestInvolvedRelations;
    }
    else
    {
        //we should obtain map pointer from GetMap() in 99% of cases. Special case
        //only for quests which cast teleport spells on player
        Map * _map = IsInWorld() ? GetMap() : sMapMgr.FindMap(GetMapId(), GetInstanceId());
        ASSERT(_map);
        GameObject *pGameObject = _map->GetGameObject(guid);
        if (pGameObject)
        {
            pObject = (Object*)pGameObject;
            pObjectQR  = &sObjectMgr.mGOQuestRelations;
            pObjectQIR = &sObjectMgr.mGOQuestInvolvedRelations;
        }
        else
            return;
    }

    QuestMenu &qm = PlayerTalkClass->GetQuestMenu();
    qm.ClearMenu();

    for (QuestRelations::const_iterator i = pObjectQIR->lower_bound(pObject->GetEntry()); i != pObjectQIR->upper_bound(pObject->GetEntry()); ++i)
    {
        uint32 quest_id = i->second;
        QuestStatus status = GetQuestStatus(quest_id);
        if (status == QUEST_STATUS_COMPLETE && !GetQuestRewardStatus(quest_id))
            qm.AddMenuItem(quest_id, DIALOG_STATUS_REWARD_REP);
        else if (status == QUEST_STATUS_INCOMPLETE)
            qm.AddMenuItem(quest_id, DIALOG_STATUS_INCOMPLETE);
        else if (status == QUEST_STATUS_AVAILABLE)
            qm.AddMenuItem(quest_id, DIALOG_STATUS_CHAT);
    }

    for (QuestRelations::const_iterator i = pObjectQR->lower_bound(pObject->GetEntry()); i != pObjectQR->upper_bound(pObject->GetEntry()); ++i)
    {
        uint32 quest_id = i->second;
        Quest const* pQuest = sObjectMgr.GetQuestTemplate(quest_id);
        if (!pQuest) continue;

        QuestStatus status = GetQuestStatus(quest_id);

        if (pQuest->IsAutoComplete() && CanTakeQuest(pQuest, false))
            qm.AddMenuItem(quest_id, DIALOG_STATUS_REWARD_REP);
        else if (status == QUEST_STATUS_NONE && CanTakeQuest(pQuest, false))
            qm.AddMenuItem(quest_id, DIALOG_STATUS_AVAILABLE);
    }
}

void Player::SendPreparedQuest(uint64 guid)
{
    QuestMenu& questMenu = PlayerTalkClass->GetQuestMenu();
    if (questMenu.Empty())
        return;

    QuestMenuItem const& qmi0 = questMenu.GetItem(0);

    uint32 status = qmi0.m_qIcon;

    // single element case
    if (questMenu.MenuItemCount() == 1)
    {
        // Auto open -- maybe also should verify there is no greeting
        uint32 quest_id = qmi0.m_qId;
        Quest const* pQuest = sObjectMgr.GetQuestTemplate(quest_id);
        if (pQuest)
        {
            if (status == DIALOG_STATUS_REWARD_REP && !GetQuestRewardStatus(quest_id))
                PlayerTalkClass->SendQuestGiverRequestItems(pQuest, guid, CanRewardQuest(pQuest,false), true);
            else if (status == DIALOG_STATUS_INCOMPLETE)
                PlayerTalkClass->SendQuestGiverRequestItems(pQuest, guid, false, true);
            // Send completable on repeatable quest if player don't have quest
            else if (pQuest->IsRepeatable() && !pQuest->IsDaily())
                PlayerTalkClass->SendQuestGiverRequestItems(pQuest, guid, CanCompleteRepeatableQuest(pQuest), true);
            else
                PlayerTalkClass->SendQuestGiverQuestDetails(pQuest, guid, true);
        }
    }
    // multiply entries
    else
    {
        QEmote qe;
        qe._Delay = 0;
        qe._Emote = 0;
        std::string title = "";
        Creature *pCreature = GetMap()->GetCreature(guid);
        if (pCreature)
        {
            uint32 textid = pCreature->GetNpcTextId();
            GossipText const * gossiptext = sObjectMgr.GetGossipText(textid);
            if (!gossiptext)
            {
                qe._Delay = 0;                              //TEXTEMOTE_MESSAGE;              //zyg: player emote
                qe._Emote = 0;                              //TEXTEMOTE_HELLO;                //zyg: NPC emote
                title = "";
            }
            else
            {
                qe = gossiptext->Options[0].Emotes[0];

                int loc_idx = GetSession()->GetSessionDbLocaleIndex();

                std::string title0 = gossiptext->Options[0].Text_0;
                std::string title1 = gossiptext->Options[0].Text_1;
                sObjectMgr.GetNpcTextLocaleStrings0(textid, loc_idx, &title0, &title1);

                title = !title0.empty() ? title0 : title1;
            }
        }
        PlayerTalkClass->SendQuestGiverQuestList(qe, title, guid);
    }
}

bool Player::IsActiveQuest(uint32 quest_id) const
{
    QuestStatusMap::const_iterator itr = mQuestStatus.find(quest_id);

    return itr != mQuestStatus.end() && itr->second.m_status != QUEST_STATUS_NONE;
}

Quest const * Player::GetNextQuest(uint64 guid, Quest const *pQuest)
{
    Object *pObject;
    QuestRelations* pObjectQR;
    QuestRelations* pObjectQIR;

    Creature *pCreature = GetMap()->GetCreature(guid);
    if (pCreature)
    {
        pObject = (Object*)pCreature;
        pObjectQR  = &sObjectMgr.mCreatureQuestRelations;
        pObjectQIR = &sObjectMgr.mCreatureQuestInvolvedRelations;
    }
    else
    {
        //we should obtain map pointer from GetMap() in 99% of cases. Special case
        //only for quests which cast teleport spells on player
        Map * _map = IsInWorld() ? GetMap() : sMapMgr.FindMap(GetMapId(), GetInstanceId());
        ASSERT(_map);
        GameObject *pGameObject = _map->GetGameObject(guid);
        if (pGameObject)
        {
            pObject = (Object*)pGameObject;
            pObjectQR  = &sObjectMgr.mGOQuestRelations;
            pObjectQIR = &sObjectMgr.mGOQuestInvolvedRelations;
        }
        else
            return NULL;
    }

    uint32 nextQuestID = pQuest->GetNextQuestInChain();
    for (QuestRelations::const_iterator itr = pObjectQR->lower_bound(pObject->GetEntry()); itr != pObjectQR->upper_bound(pObject->GetEntry()); ++itr)
    {
        if (itr->second == nextQuestID)
            return sObjectMgr.GetQuestTemplate(nextQuestID);
    }

    return NULL;
}

bool Player::CanSeeStartQuest(Quest const *pQuest)
{
    if (SatisfyQuestRace(pQuest, false) && SatisfyQuestSkillOrClass(pQuest, false) &&
        SatisfyQuestExclusiveGroup(pQuest, false) && SatisfyQuestReputation(pQuest, false) &&
        SatisfyQuestPreviousQuest(pQuest, false) && SatisfyQuestNextChain(pQuest, false) &&
        SatisfyQuestPrevChain(pQuest, false) && SatisfyQuestDay(pQuest, false) &&
        SatisfyQuestMonth(pQuest, false))
    {
        return getLevel() + sWorld.getConfig(CONFIG_QUEST_HIGH_LEVEL_HIDE_DIFF) >= pQuest->GetMinLevel();
    }

    return false;
}

bool Player::CanTakeQuest(Quest const *pQuest, bool msg)
{
    return SatisfyQuestStatus(pQuest, msg) && SatisfyQuestExclusiveGroup(pQuest, msg)
        && SatisfyQuestRace(pQuest, msg) && SatisfyQuestLevel(pQuest, msg)
        && SatisfyQuestSkillOrClass(pQuest, msg) && SatisfyQuestReputation(pQuest, msg)
        && SatisfyQuestPreviousQuest(pQuest, msg) && SatisfyQuestTimed(pQuest, msg)
        && SatisfyQuestNextChain(pQuest, msg) && SatisfyQuestPrevChain(pQuest, msg)
        && SatisfyQuestDay(pQuest, msg) && SatisfyQuestMonth(pQuest, msg);
}

bool Player::CanAddQuest(Quest const *pQuest, bool msg)
{
    if (!SatisfyQuestLog(msg))
        return false;

    uint32 srcitem = pQuest->GetSrcItemId();
    if (srcitem > 0)
    {
        uint32 count = pQuest->GetSrcItemCount();
        ItemPosCountVec dest;
        uint8 msg2 = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, srcitem, count);

        // player already have max number (in most case 1) source item, no additional item needed and quest can be added.
        if (msg2 == EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)
            return true;
        else if (msg2 != EQUIP_ERR_OK)
        {
            SendEquipError(msg2, NULL, NULL);
            return false;
        }
    }
    return true;
}

bool Player::CanCompleteQuest(uint32 quest_id)
{
    if (quest_id)
    {
        QuestStatusData& q_status = mQuestStatus[quest_id];
        if (q_status.m_status == QUEST_STATUS_COMPLETE)
            return false;                                   // not allow re-complete quest

        Quest const* qInfo = sObjectMgr.GetQuestTemplate(quest_id);

        if (!qInfo)
            return false;

        // auto complete quest
        if (qInfo->IsAutoComplete() && CanTakeQuest(qInfo, false))
            return true;

        if (q_status.m_status == QUEST_STATUS_INCOMPLETE)
        {

            if (qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_DELIVER))
            {
                for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
                {
                    if (qInfo->ReqItemCount[i]!= 0 && q_status.m_itemcount[i] < qInfo->ReqItemCount[i])
                        return false;
                }
            }

            if (qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_KILL_OR_CAST | QUEST_LOOKING4GROUP_FLAGS_SPEAKTO))
            {
                for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
                {
                    if (qInfo->ReqCreatureOrGOId[i] == 0)
                        continue;

                    if (qInfo->ReqCreatureOrGOCount[i] != 0 && q_status.m_creatureOrGOcount[i] < qInfo->ReqCreatureOrGOCount[i])
                        return false;
                }
            }

            if (qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_EXPLORATION_OR_EVENT) && !q_status.m_explored)
                return false;

            if (qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_TIMED) && q_status.m_timer == 0)
                return false;

            if (qInfo->GetRewOrReqMoney() < 0)
            {
                if (GetMoney() < uint32(-qInfo->GetRewOrReqMoney()))
                    return false;
            }

            uint32 repFacId = qInfo->GetRepObjectiveFaction();
            if (repFacId && m_reputationMgr.GetReputation(repFacId) < qInfo->GetRepObjectiveValue())
                return false;

            return true;
        }
    }
    return false;
}

bool Player::CanCompleteRepeatableQuest(Quest const *pQuest)
{
    // Solve problem that player don't have the quest and try complete it.
    // if repeatable she must be able to complete event if player don't have it.
    // Seem that all repeatable quest are DELIVER Flag so, no need to add more.
    if (!CanTakeQuest(pQuest, false))
        return false;

    if (pQuest->HasFlag(QUEST_LOOKING4GROUP_FLAGS_DELIVER))
        for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
            if (pQuest->ReqItemId[i] && pQuest->ReqItemCount[i] && !HasItemCount(pQuest->ReqItemId[i],pQuest->ReqItemCount[i]))
                return false;

    if (!CanRewardQuest(pQuest, false))
        return false;

    return true;
}

bool Player::CanRewardQuest(Quest const *pQuest, bool msg)
{
    // not auto complete quest and not completed quest (only cheating case, then ignore without message)
    if (!pQuest->IsAutoComplete() && GetQuestStatus(pQuest->GetQuestId()) != QUEST_STATUS_COMPLETE)
        return false;

    // daily quest can't be rewarded (25 daily quest already completed)
    if (!SatisfyQuestDay(pQuest,true) || !SatisfyQuestMonth(pQuest, true))
        return false;

    // rewarded and not repeatable quest (only cheating case, then ignore without message)
    if (GetQuestRewardStatus(pQuest->GetQuestId()))
        return false;

    // prevent receive reward with quest items in bank
    if (pQuest->HasFlag(QUEST_LOOKING4GROUP_FLAGS_DELIVER))
    {
        for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
        {
            if (pQuest->ReqItemCount[i]!= 0 &&
                GetItemCount(pQuest->ReqItemId[i]) < pQuest->ReqItemCount[i])
            {
                if (msg)
                    SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, NULL, NULL);
                return false;
            }
        }
    }

    // prevent receive reward with low money and GetRewOrReqMoney() < 0
    if (pQuest->GetRewOrReqMoney() < 0 && GetMoney() < uint32(-pQuest->GetRewOrReqMoney()))
        return false;

    return true;
}

bool Player::CanRewardQuest(Quest const *pQuest, uint32 reward, bool msg)
{
    // prevent receive reward with quest items in bank or for not completed quest
    if (!CanRewardQuest(pQuest,msg))
        return false;

    if (pQuest->GetRewChoiceItemsCount() > 0)
    {
        if (pQuest->RewChoiceItemId[reward])
        {
            ItemPosCountVec dest;
            uint8 res = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, pQuest->RewChoiceItemId[reward], pQuest->RewChoiceItemCount[reward]);
            if (res != EQUIP_ERR_OK)
            {
                SendEquipError(res, NULL, NULL);
                return false;
            }
        }
    }

    if (pQuest->GetRewItemsCount() > 0)
    {
        for (uint32 i = 0; i < pQuest->GetRewItemsCount(); ++i)
        {
            if (pQuest->RewItemId[i])
            {
                ItemPosCountVec dest;
                uint8 res = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, pQuest->RewItemId[i], pQuest->RewItemCount[i]);
                if (res != EQUIP_ERR_OK)
                {
                    SendEquipError(res, NULL, NULL);
                    return false;
                }
            }
        }
    }

    return true;
}

void Player::AddQuest(Quest const *pQuest, Object *questGiver)
{
    uint16 log_slot = FindQuestSlot(0);
    ASSERT(log_slot < MAX_QUEST_LOG_SIZE);

    uint32 quest_id = pQuest->GetQuestId();

    // if not exist then created with set uState==NEW and rewarded=false
    QuestStatusData& questStatusData = mQuestStatus[quest_id];

    // check for repeatable quests status reset
    questStatusData.m_status = QUEST_STATUS_INCOMPLETE;
    questStatusData.m_explored = false;

    if (pQuest->HasFlag(QUEST_LOOKING4GROUP_FLAGS_DELIVER))
    {
        for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
            questStatusData.m_itemcount[i] = 0;
    }

    if (pQuest->HasFlag(QUEST_LOOKING4GROUP_FLAGS_KILL_OR_CAST | QUEST_LOOKING4GROUP_FLAGS_SPEAKTO))
    {
        for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
            questStatusData.m_creatureOrGOcount[i] = 0;
    }

    GiveQuestSourceItem(pQuest);
    AdjustQuestReqItemCount(pQuest, questStatusData);

    if (pQuest->GetRepObjectiveFaction())
        if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(pQuest->GetRepObjectiveFaction()))
            m_reputationMgr.SetVisible(factionEntry);

    uint32 qtime = 0;
    if (pQuest->HasFlag(QUEST_LOOKING4GROUP_FLAGS_TIMED))
    {
        uint32 limittime = pQuest->GetLimitTime();

        // shared timed quest
        if (questGiver && questGiver->GetTypeId()==TYPEID_PLAYER)
            limittime = ((Player*)questGiver)->getQuestStatusMap()[quest_id].m_timer / 1000;

        AddTimedQuest(quest_id);
        questStatusData.m_timer = limittime * 1000;
        qtime = static_cast<uint32>(time(NULL)) + limittime;
    }
    else
        questStatusData.m_timer = 0;

    SetQuestSlot(log_slot, quest_id, qtime);

    if (questStatusData.uState != QUEST_NEW)
        questStatusData.uState = QUEST_CHANGED;

    //starting initial quest script
    if (questGiver && pQuest->GetQuestStartScript()!=0)
        GetMap()->ScriptsStart(sQuestStartScripts, pQuest->GetQuestStartScript(), questGiver, this);

    UpdateForQuestsGO();
}

void Player::CompleteQuest(uint32 quest_id)
{
    if (quest_id)
    {
        SetQuestStatus(quest_id, QUEST_STATUS_COMPLETE);

        uint16 log_slot = FindQuestSlot(quest_id);
        if (log_slot < MAX_QUEST_LOG_SIZE)
            SetQuestSlotState(log_slot,QUEST_STATE_COMPLETE);

        if (Quest const* qInfo = sObjectMgr.GetQuestTemplate(quest_id))
        {
            if (qInfo->HasFlag(QUEST_FLAGS_AUTO_REWARDED))
                RewardQuest(qInfo,0,this,false);
            else
                SendQuestComplete(quest_id);
        }
    }
}

void Player::IncompleteQuest(uint32 quest_id)
{
    if (quest_id)
    {
        SetQuestStatus(quest_id, QUEST_STATUS_INCOMPLETE);

        uint16 log_slot = FindQuestSlot(quest_id);
        if (log_slot < MAX_QUEST_LOG_SIZE)
            RemoveQuestSlotState(log_slot,QUEST_STATE_COMPLETE);
    }
}

void Player::RewardQuest(Quest const *pQuest, uint32 reward, Object* questGiver, bool announce)
{
    uint32 quest_id = pQuest->GetQuestId();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
    {
        if (pQuest->ReqItemId[i])
            DestroyItemCount(pQuest->ReqItemId[i], pQuest->ReqItemCount[i], true);
    }

    //if(qInfo->HasSpecialFlag(QUEST_FLAGS_TIMED))
    //    SetTimedQuest(0);
    m_timedquests.erase(pQuest->GetQuestId());

    if (pQuest->GetRewChoiceItemsCount() > 0)
    {
        if (pQuest->RewChoiceItemId[reward])
        {
            ItemPosCountVec dest;
            if (CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, pQuest->RewChoiceItemId[reward], pQuest->RewChoiceItemCount[reward]) == EQUIP_ERR_OK)
            {
                Item* item = StoreNewItem(dest, pQuest->RewChoiceItemId[reward], true);
                SendNewItem(item, pQuest->RewChoiceItemCount[reward], true, false);
            }
        }
    }

    if (pQuest->GetRewItemsCount() > 0)
    {
        for (uint32 i=0; i < pQuest->GetRewItemsCount(); ++i)
        {
            if (pQuest->RewItemId[i])
            {
                ItemPosCountVec dest;
                if (CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, pQuest->RewItemId[i], pQuest->RewItemCount[i]) == EQUIP_ERR_OK)
                {
                    Item* item = StoreNewItem(dest, pQuest->RewItemId[i], true);
                    SendNewItem(item, pQuest->RewItemCount[i], true, false);
                }
            }
        }
    }

    RewardReputation(pQuest);

    uint16 log_slot = FindQuestSlot(quest_id);
    if (log_slot < MAX_QUEST_LOG_SIZE)
        SetQuestSlot(log_slot,0);

    QuestStatusData& q_status = mQuestStatus[quest_id];

    // Not give XP in case already completed once repeatable quest
    uint32 XP = q_status.m_rewarded ? 0 : uint32(pQuest->XPValue(this)*GetXPRate(RATE_XP_QUEST));

    //SWP QUESTS AUCH FÜR EVENT
    uint32 SWPQuests[19] = {11525, 11535, 11540, 11524, 11547, 11536, 11542, 11546, 11523, 11548, 11526, 11537, 11533, 11496, 11539, 11543, 11541, 11532, 11545};
    uint32 actualQuestId;
    bool validRepeatableQuestforXP;
    validRepeatableQuestforXP = false;
    actualQuestId = pQuest->GetQuestId();

    uint32 SWPQuests_new[21] = {11488, 11514, 11515, 11516, 11521, 11523, 11525, 11526, 11533, 11536, 11537, 11540, 11541, 11543, 11544, 11546, 11547, 11548, 11549, 11875, 11877};
    for (uint32 i=0; i<21; i++)
    {
        if (actualQuestId == SWPQuests_new[i])
        {
            //Quest for 1k Gold (not repeatable) will rate like 50 Quests
            if (actualQuestId == 11549)
            {
                GameDataDatabase.PExecute("UPDATE `new_swp_event` SET `quests_done`= `quests_done`+100 WHERE `id`= 1");
                GameDataDatabase.PExecute("INSERT INTO `new_swp_event_stats` SET accountid = '%i', timestamp = NOW(), player_name = '%s', `guild_id` = '%i', count = '150', quest_id = '%u'", GetSession()->GetAccountId(), GetName(), GetGuildId(), actualQuestId);
            }
            else
            {
                GameDataDatabase.PExecute("UPDATE `new_swp_event` SET `quests_done`= `quests_done`+2 WHERE `id`= 1");
                GameDataDatabase.PExecute("INSERT INTO `new_swp_event_stats` SET accountid = '%i', timestamp = NOW(), player_name = '%s', `guild_id` = '%i', count = '3', quest_id = '%u'", GetSession()->GetAccountId(), GetName(), GetGuildId(), actualQuestId);         

            }
        }
    }

    for (uint32 i=0; i<19; i++)
    {
        if (actualQuestId == SWPQuests[i])
        {
            validRepeatableQuestforXP = true;
        }
    }    

    if (getLevel() < sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL) && (!StopLevel(GetGUID())))
        GiveXP(XP , NULL);
    else
        ModifyMoney(int32(pQuest->GetRewMoneyMaxLevel() * sWorld.getRate(RATE_DROP_MONEY)));

    // Give player extra money if GetRewOrReqMoney > 0 and get ReqMoney if negative
    ModifyMoney(pQuest->GetRewOrReqMoney());

    // honor reward
    if (pQuest->GetRewHonorableKills())
        RewardHonor(NULL, 0, Looking4group::Honor::hk_honor_at_level(getLevel(), pQuest->GetRewHonorableKills()));

    // title reward
    if (pQuest->GetCharTitleId())
    {
        if (CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(pQuest->GetCharTitleId()))
            SetTitle(titleEntry);
    }

    // Send reward mail
    if (uint32 mail_template_id = pQuest->GetRewMailTemplateId())
        MailDraft(mail_template_id).SendMailTo(this, questGiver, MAIL_CHECK_MASK_NONE, pQuest->GetRewMailDelaySecs());

    if (pQuest->IsDaily())
        SetDailyQuestStatus(quest_id);
    else if (pQuest->IsMonthly())
        SetMonthlyQuestStatus(quest_id);

    if (!pQuest->IsRepeatable())
        SetQuestStatus(quest_id, QUEST_STATUS_COMPLETE);
    else
        SetQuestStatus(quest_id, QUEST_STATUS_NONE);

    q_status.m_rewarded = true;

    if (announce)
        SendQuestReward(pQuest, XP, questGiver);

    bool handled = false;

    switch (questGiver->GetTypeId())
    {
        case TYPEID_UNIT:
            handled = sScriptMgr.OnQuestRewarded(this, (Creature*)questGiver, pQuest);
            break;
        case TYPEID_GAMEOBJECT:
            handled = sScriptMgr.OnQuestRewarded(this, (GameObject*)questGiver, pQuest);
            break;
    }

    if (!handled && pQuest->GetQuestCompleteScript() != 0)
        GetMap()->ScriptsStart(sQuestEndScripts, pQuest->GetQuestCompleteScript(), questGiver, this);

    if (q_status.uState != QUEST_NEW) q_status.uState = QUEST_CHANGED;

    if (pQuest->GetRewSpellCast() > 0)
        CastSpell(this, pQuest->GetRewSpellCast(), true);
    else if (pQuest->GetRewSpell() > 0)
        CastSpell(this, pQuest->GetRewSpell(), true);
}

void Player::RewardDNDQuest(uint32 questId)
{
    const Quest * tmpQ = sObjectMgr.GetQuestTemplate(questId);
    if (!tmpQ)
        return;

    QuestStatusData& q_status = mQuestStatus[questId];

    // Not give XP in case already completed once repeatable quest
    uint32 XP = q_status.m_rewarded ? 0 : uint32(tmpQ->XPValue(this)*GetXPRate(RATE_XP_QUEST));

    if (getLevel() < sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
        GiveXP(XP , NULL);
    else
        ModifyMoney(int32(tmpQ->GetRewMoneyMaxLevel() * sWorld.getRate(RATE_DROP_MONEY)));

    RewardReputation(tmpQ);

    // Give player extra money if GetRewOrReqMoney > 0 and get ReqMoney if negative
    ModifyMoney(tmpQ->GetRewOrReqMoney());

    q_status.m_rewarded = true;
    q_status.m_status = QUEST_STATUS_COMPLETE;

    if (q_status.uState != QUEST_NEW)
        q_status.uState = QUEST_CHANGED;

    if (tmpQ->GetRewSpellCast() > 0)
        CastSpell(this, tmpQ->GetRewSpellCast(), true);
    else if (tmpQ->GetRewSpell() > 0)
        CastSpell(this, tmpQ->GetRewSpell(), true);
}

void Player::FailQuest(uint32 quest_id)
{
    if (quest_id)
    {
        IncompleteQuest(quest_id);

        uint16 log_slot = FindQuestSlot(quest_id);
        if (log_slot < MAX_QUEST_LOG_SIZE)
        {
            SetQuestSlotTimer(log_slot, 1);
            SetQuestSlotState(log_slot,QUEST_STATE_FAIL);
        }
        SendQuestFailed(quest_id);
    }
}

void Player::FailTimedQuest(uint32 quest_id)
{
    if (quest_id)
    {
        QuestStatusData& q_status = mQuestStatus[quest_id];

        q_status.m_timer = 0;
        if (q_status.uState != QUEST_NEW)
            q_status.uState = QUEST_CHANGED;

        IncompleteQuest(quest_id);

        uint16 log_slot = FindQuestSlot(quest_id);
        if (log_slot < MAX_QUEST_LOG_SIZE)
        {
            SetQuestSlotTimer(log_slot, 1);
            SetQuestSlotState(log_slot,QUEST_STATE_FAIL);
        }
        SendQuestTimerFailed(quest_id);
    }
}

bool Player::SatisfyQuestSkillOrClass(Quest const* qInfo, bool msg)
{
    int32 zoneOrSort   = qInfo->GetZoneOrSort();
    int32 skillOrClass = qInfo->GetSkillOrClass();

    // skip zone zoneOrSort and 0 case skillOrClass
    if (zoneOrSort >= 0 && skillOrClass == 0)
        return true;

    int32 questSort = -zoneOrSort;
    uint8 reqSortClass = ClassByQuestSort(questSort);

    // check class sort cases in zoneOrSort
    if (reqSortClass != 0 && getClass() != reqSortClass)
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        return false;
    }

    // check class
    if (skillOrClass < 0)
    {
        uint8 reqClass = -int32(skillOrClass);
        if (getClass() != reqClass)
        {
            if (msg)
                SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
            return false;
        }
    }
    // check skill
    else if (skillOrClass > 0)
    {
        uint32 reqSkill = skillOrClass;
        if (GetSkillValue(reqSkill) < qInfo->GetRequiredSkillValue())
        {
            if (msg)
                SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
            return false;
        }
    }

    return true;
}

bool Player::SatisfyQuestLevel(Quest const* qInfo, bool msg)
{
    if (getLevel() < qInfo->GetMinLevel())
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        return false;
    }
    return true;
}

bool Player::SatisfyQuestLog(bool msg)
{
    // exist free slot
    if (FindQuestSlot(0) < MAX_QUEST_LOG_SIZE)
        return true;

    if (msg)
    {
        WorldPacket data(SMSG_QUESTLOG_FULL, 0);
        SendPacketToSelf(&data);
        sLog.outDebug("WORLD: Sent QUEST_LOG_FULL_MESSAGE");
    }
    return false;
}

bool Player::SatisfyQuestPreviousQuest(Quest const* qInfo, bool msg)
{
    // No previous quest (might be first quest in a series)
    if (qInfo->prevQuests.empty())
        return true;

    for (Quest::PrevQuests::const_iterator iter = qInfo->prevQuests.begin(); iter != qInfo->prevQuests.end(); ++iter)
    {
        uint32 prevId = abs(*iter);

        QuestStatusMap::iterator i_prevstatus = mQuestStatus.find(prevId);
        Quest const* qPrevInfo = sObjectMgr.GetQuestTemplate(prevId);

        if (qPrevInfo && i_prevstatus != mQuestStatus.end())
        {
            // If any of the positive previous quests completed, return true
            if (*iter > 0 && i_prevstatus->second.m_rewarded)
            {
                // skip one-from-all exclusive group
                if (qPrevInfo->GetExclusiveGroup() >= 0)
                    return true;

                // each-from-all exclusive group (< 0)
                // can be start if only all quests in prev quest exclusive group completed and rewarded
                ObjectMgr::ExclusiveQuestGroups::iterator iter2 = sObjectMgr.mExclusiveQuestGroups.lower_bound(qPrevInfo->GetExclusiveGroup());
                ObjectMgr::ExclusiveQuestGroups::iterator end  = sObjectMgr.mExclusiveQuestGroups.upper_bound(qPrevInfo->GetExclusiveGroup());

                ASSERT(iter2!=end);                          // always must be found if qPrevInfo->ExclusiveGroup != 0

                for (; iter2 != end; ++iter2)
                {
                    uint32 exclude_Id = iter2->second;

                    // skip checked quest id, only state of other quests in group is interesting
                    if (exclude_Id == prevId)
                        continue;

                    QuestStatusMap::iterator i_exstatus = mQuestStatus.find(exclude_Id);

                    // alternative quest from group also must be completed and rewarded(reported)
                    if (i_exstatus == mQuestStatus.end() || !i_exstatus->second.m_rewarded)
                    {
                        if (msg)
                            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
                        return false;
                    }
                }
                return true;
            }
            // If any of the negative previous quests active, return true
            if (*iter < 0 && (i_prevstatus->second.m_status == QUEST_STATUS_INCOMPLETE
                || (i_prevstatus->second.m_status == QUEST_STATUS_COMPLETE && !GetQuestRewardStatus(prevId))))
            {
                // skip one-from-all exclusive group
                if (qPrevInfo->GetExclusiveGroup() >= 0)
                    return true;

                // each-from-all exclusive group (< 0)
                // can be start if only all quests in prev quest exclusive group active
                ObjectMgr::ExclusiveQuestGroups::iterator iter2 = sObjectMgr.mExclusiveQuestGroups.lower_bound(qPrevInfo->GetExclusiveGroup());
                ObjectMgr::ExclusiveQuestGroups::iterator end  = sObjectMgr.mExclusiveQuestGroups.upper_bound(qPrevInfo->GetExclusiveGroup());

                ASSERT(iter2!=end);                          // always must be found if qPrevInfo->ExclusiveGroup != 0

                for (; iter2 != end; ++iter2)
                {
                    uint32 exclude_Id = iter2->second;

                    // skip checked quest id, only state of other quests in group is interesting
                    if (exclude_Id == prevId)
                        continue;

                    QuestStatusMap::iterator i_exstatus = mQuestStatus.find(exclude_Id);

                    // alternative quest from group also must be active
                    if (i_exstatus == mQuestStatus.end() ||
                        i_exstatus->second.m_status != QUEST_STATUS_INCOMPLETE &&
                        (i_prevstatus->second.m_status != QUEST_STATUS_COMPLETE || GetQuestRewardStatus(prevId)))
                    {
                        if (msg)
                            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
                        return false;
                    }
                }
                return true;
            }
        }
    }

    // Has only positive prev. quests in non-rewarded state
    // and negative prev. quests in non-active state
    if (msg)
        SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);

    return false;
}

bool Player::SatisfyQuestRace(Quest const* qInfo, bool msg)
{
    uint32 reqraces = qInfo->GetRequiredRaces();
    if (reqraces == 0)
        return true;
    if ((reqraces & getRaceMask()) == 0)
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_QUEST_FAILED_WRONG_RACE);
        return false;
    }
    return true;
}

bool Player::SatisfyQuestReputation(Quest const* qInfo, bool msg)
{
    uint32 fIdMin = qInfo->GetRequiredMinRepFaction();      //Min required rep
    if (fIdMin && m_reputationMgr.GetReputation(fIdMin) < qInfo->GetRequiredMinRepValue())
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        return false;
    }

    uint32 fIdMax = qInfo->GetRequiredMaxRepFaction();      //Max required rep
    if (fIdMax && m_reputationMgr.GetReputation(fIdMax) >= qInfo->GetRequiredMaxRepValue())
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        return false;
    }

    return true;
}

bool Player::SatisfyQuestStatus(Quest const* qInfo, bool msg)
{
    QuestStatusMap::iterator itr = mQuestStatus.find(qInfo->GetQuestId());
    if  (itr != mQuestStatus.end() && itr->second.m_status != QUEST_STATUS_NONE)
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_QUEST_ALREADY_ON);
        return false;
    }
    return true;
}

bool Player::SatisfyQuestTimed(Quest const* qInfo, bool msg)
{
    if ((find(m_timedquests.begin(), m_timedquests.end(), qInfo->GetQuestId()) != m_timedquests.end()) && qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_TIMED))
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_QUEST_ONLY_ONE_TIMED);
        return false;
    }
    return true;
}

bool Player::SatisfyQuestExclusiveGroup(Quest const* qInfo, bool msg)
{
    // non positive exclusive group, if > 0 then can be start if any other quest in exclusive group already started/completed
    if (qInfo->GetExclusiveGroup() <= 0)
        return true;

    if (qInfo->IsDaily() && !sWorld.getConfig(CONFIG_DAILY_BLIZZLIKE))
        return true;

    ObjectMgr::ExclusiveQuestGroups::iterator iter = sObjectMgr.mExclusiveQuestGroups.lower_bound(qInfo->GetExclusiveGroup());
    ObjectMgr::ExclusiveQuestGroups::iterator end  = sObjectMgr.mExclusiveQuestGroups.upper_bound(qInfo->GetExclusiveGroup());

    ASSERT(iter!=end);                                      // always must be found if qInfo->ExclusiveGroup != 0

    for (; iter != end; ++iter)
    {
        uint32 exclude_Id = iter->second;

        // skip checked quest id, only state of other quests in group is interesting
        if (exclude_Id == qInfo->GetQuestId())
            continue;

        // not allow have daily quest if daily quest from exclusive group already recently completed
        Quest const* Nquest = sObjectMgr.GetQuestTemplate(exclude_Id);
        if (!SatisfyQuestDay(Nquest, false))
        {
            if (msg)
                SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
            return false;
        }

        QuestStatusMap::iterator i_exstatus = mQuestStatus.find(exclude_Id);

        // alternative quest already started or completed
        if (i_exstatus != mQuestStatus.end()
            && (i_exstatus->second.m_status == QUEST_STATUS_COMPLETE || i_exstatus->second.m_status == QUEST_STATUS_INCOMPLETE))
        {
            if (msg)
                SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
            return false;
        }
    }
    return true;
}

bool Player::SatisfyQuestNextChain(Quest const* qInfo, bool msg)
{
    if (!qInfo->GetNextQuestInChain())
        return true;

    // next quest in chain already started or completed
    QuestStatusMap::iterator itr = mQuestStatus.find(qInfo->GetNextQuestInChain());
    if (itr != mQuestStatus.end()
        && (itr->second.m_status == QUEST_STATUS_COMPLETE || itr->second.m_status == QUEST_STATUS_INCOMPLETE))
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
        return false;
    }

    // check for all quests further up the chain
    // only necessary if there are quest chains with more than one quest that can be skipped
    //return SatisfyQuestNextChain(qInfo->GetNextQuestInChain(), msg);
    return true;
}

bool Player::SatisfyQuestPrevChain(Quest const* qInfo, bool msg)
{
    // No previous quest in chain
    if (qInfo->prevChainQuests.empty())
        return true;

    for (Quest::PrevChainQuests::const_iterator iter = qInfo->prevChainQuests.begin(); iter != qInfo->prevChainQuests.end(); ++iter)
    {
        uint32 prevId = *iter;

        QuestStatusMap::iterator i_prevstatus = mQuestStatus.find(prevId);

        if (i_prevstatus != mQuestStatus.end())
        {
            // If any of the previous quests in chain active, return false
            if (i_prevstatus->second.m_status == QUEST_STATUS_INCOMPLETE
                || (i_prevstatus->second.m_status == QUEST_STATUS_COMPLETE && !GetQuestRewardStatus(prevId)))
            {
                if (msg)
                    SendCanTakeQuestResponse(INVALIDREASON_DONT_HAVE_REQ);
                return false;
            }
        }

        // check for all quests further down the chain
        // only necessary if there are quest chains with more than one quest that can be skipped
        //if(!SatisfyQuestPrevChain(prevId, msg))
        //    return false;
    }

    // No previous quest in chain active
    return true;
}

bool Player::SatisfyQuestDay(Quest const* qInfo, bool msg)
{
    if (!qInfo->IsDaily())
        return true;

    bool have_slot = false;
    for (uint32 quest_daily_idx = 0; quest_daily_idx < sWorld.getConfig(CONFIG_DAILY_MAX_PER_DAY); ++quest_daily_idx)
    {
        uint32 id = GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1+quest_daily_idx);
        if (qInfo->GetQuestId()==id)
            return false;

        if (!id)
            have_slot = true;
    }

    if (!have_slot)
    {
        if (msg)
            SendCanTakeQuestResponse(INVALIDREASON_DAILY_QUESTS_REMAINING);
        return false;
    }

    return true;
}

bool Player::GiveQuestSourceItem(Quest const *pQuest)
{
    uint32 srcitem = pQuest->GetSrcItemId();
    if (srcitem > 0)
    {
        uint32 count = pQuest->GetSrcItemCount();
        if (count <= 0)
            count = 1;

        ItemPosCountVec dest;
        uint8 msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, srcitem, count);
        if (msg == EQUIP_ERR_OK)
        {
            Item * item = StoreNewItem(dest, srcitem, true);
            SendNewItem(item, count, true, false);
            return true;
        }
        // player already have max amount required item, just report success
        else if (msg == EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)
            return true;
        else
            SendEquipError(msg, NULL, NULL);
        return false;
    }

    return true;
}

bool Player::TakeQuestSourceItem(uint32 quest_id, bool msg)
{
    Quest const* qInfo = sObjectMgr.GetQuestTemplate(quest_id);
    if (qInfo)
    {
        uint32 srcitem = qInfo->GetSrcItemId();
        if (srcitem > 0)
        {
            uint32 count = qInfo->GetSrcItemCount();
            if (count <= 0)
                count = 1;

            // exist one case when destroy source quest item not possible:
            // non un-equippable item (equipped non-empty bag, for example)
            uint8 res = CanUnequipItems(srcitem,count);
            if (res != EQUIP_ERR_OK)
            {
                if (msg)
                    SendEquipError(res, NULL, NULL);
                return false;
            }

            DestroyItemCount(srcitem, count, true, true);
        }
    }
    return true;
}

bool Player::GetQuestRewardStatus(uint32 quest_id) const
{
    Quest const* qInfo = sObjectMgr.GetQuestTemplate(quest_id);
    if (qInfo)
    {
        // for repeatable quests: rewarded field is set after first reward only to prevent getting XP more than once
        QuestStatusMap::const_iterator itr = mQuestStatus.find(quest_id);
        if (itr != mQuestStatus.end() && itr->second.m_status != QUEST_STATUS_NONE
            && !qInfo->IsRepeatable())
            return itr->second.m_rewarded;

        return false;
    }
    return false;
}

QuestStatus Player::GetQuestStatus(uint32 quest_id) const
{
    if (quest_id)
    {
        QuestStatusMap::const_iterator itr = mQuestStatus.find(quest_id);
        if (itr != mQuestStatus.end())
            return itr->second.m_status;
    }
    return QUEST_STATUS_NONE;
}

bool Player::CanShareQuest(uint32 quest_id) const
{
    Quest const* qInfo = sObjectMgr.GetQuestTemplate(quest_id);
    if (qInfo && qInfo->HasFlag(QUEST_FLAGS_SHARABLE))
    {
        QuestStatusMap::const_iterator itr = mQuestStatus.find(quest_id);
        if (itr != mQuestStatus.end())
            return itr->second.m_status == QUEST_STATUS_NONE || itr->second.m_status == QUEST_STATUS_INCOMPLETE;
    }
    return false;
}

void Player::SetQuestStatus(uint32 quest_id, QuestStatus status)
{
    Quest const* qInfo = sObjectMgr.GetQuestTemplate(quest_id);
    if (qInfo)
    {
        if (status == QUEST_STATUS_NONE || status == QUEST_STATUS_INCOMPLETE || status == QUEST_STATUS_COMPLETE)
        {
            if (qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_TIMED))
                m_timedquests.erase(qInfo->GetQuestId());
        }

        QuestStatusData& q_status = mQuestStatus[quest_id];

        q_status.m_status = status;
        if (q_status.uState != QUEST_NEW) q_status.uState = QUEST_CHANGED;
    }

    UpdateForQuestsGO();
}

// not used in TrinIty, but used in scripting code
uint32 Player::GetReqKillOrCastCurrentCount(uint32 quest_id, int32 entry)
{
    Quest const* qInfo = sObjectMgr.GetQuestTemplate(quest_id);
    if (!qInfo)
        return 0;

    for (int j = 0; j < QUEST_OBJECTIVES_COUNT; j++)
        if (qInfo->ReqCreatureOrGOId[j] == entry)
            return mQuestStatus[quest_id].m_creatureOrGOcount[j];

    return 0;
}

void Player::AdjustQuestReqItemCount(Quest const* pQuest, QuestStatusData& questStatusData)
{
    if (pQuest->HasFlag(QUEST_LOOKING4GROUP_FLAGS_DELIVER))
    {
        for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
        {
            uint32 reqitemcount = pQuest->ReqItemCount[i];
            if (reqitemcount != 0)
            {
                uint32 quest_id = pQuest->GetQuestId();
                uint32 curitemcount = GetItemCount(pQuest->ReqItemId[i],true);

                questStatusData.m_itemcount[i] = std::min(curitemcount, reqitemcount);
                if (questStatusData.uState != QUEST_NEW)
                    questStatusData.uState = QUEST_CHANGED;
            }
        }
    }
}

uint16 Player::FindQuestSlot(uint32 quest_id) const
{
    for (uint16 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
        if (GetQuestSlotQuestId(i) == quest_id)
            return i;

    return MAX_QUEST_LOG_SIZE;
}

void Player::AreaExploredOrEventHappens(uint32 questId)
{
    if (questId)
    {
        uint16 log_slot = FindQuestSlot(questId);
        if (log_slot < MAX_QUEST_LOG_SIZE)
        {
            QuestStatusData& q_status = mQuestStatus[questId];

            if (!q_status.m_explored)
            {
                q_status.m_explored = true;
                if (q_status.uState != QUEST_NEW)
                    q_status.uState = QUEST_CHANGED;
            }

            if (CanCompleteQuest(questId))
                CompleteQuest(questId);
            else
                SendQuestComplete(questId);
        }
    }
}

//not used in Trinityd, function for external script library
void Player::GroupEventHappens(uint32 questId, WorldObject const* pEventObject)
{
    if (Group *pGroup = GetGroup())
    {
        for (GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
        {
            Player *pGroupGuy = itr->getSource();

            // for any leave or dead (with not released body) group member at appropriate distance
            if (pGroupGuy && pGroupGuy->IsAtGroupRewardDistance(pEventObject) && !pGroupGuy->GetCorpse())
                pGroupGuy->AreaExploredOrEventHappens(questId);
        }
    }
    else
        AreaExploredOrEventHappens(questId);
}

void Player::ItemAddedQuestCheck(uint32 entry, uint32 count)
{
    for (int i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (questid == 0)
            continue;

        QuestStatusData& q_status = mQuestStatus[questid];

        if (q_status.m_status != QUEST_STATUS_INCOMPLETE)
            continue;

        Quest const* qInfo = sObjectMgr.GetQuestTemplate(questid);
        if (!qInfo || !qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_DELIVER))
            continue;

        for (int j = 0; j < QUEST_OBJECTIVES_COUNT; j++)
        {
            uint32 reqitem = qInfo->ReqItemId[j];
            if (reqitem == entry)
            {
                uint32 reqitemcount = qInfo->ReqItemCount[j];
                uint32 curitemcount = q_status.m_itemcount[j];
                if (curitemcount < reqitemcount)
                {
                    uint32 additemcount = (curitemcount + count <= reqitemcount ? count : reqitemcount - curitemcount);
                    q_status.m_itemcount[j] += additemcount;
                    if (q_status.uState != QUEST_NEW) q_status.uState = QUEST_CHANGED;

                    SendQuestUpdateAddItem(qInfo, j, additemcount);
                }
                if (CanCompleteQuest(questid))
                    CompleteQuest(questid);
                return;
            }
        }
    }
    UpdateForQuestsGO();
}

void Player::ItemRemovedQuestCheck(uint32 entry, uint32 count)
{
    for (int i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;
        Quest const* qInfo = sObjectMgr.GetQuestTemplate(questid);
        if (!qInfo)
            continue;
        if (!qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_DELIVER))
            continue;

        for (int j = 0; j < QUEST_OBJECTIVES_COUNT; j++)
        {
            uint32 reqitem = qInfo->ReqItemId[j];
            if (reqitem == entry)
            {
                QuestStatusData& q_status = mQuestStatus[questid];

                uint32 reqitemcount = qInfo->ReqItemCount[j];
                uint32 curitemcount;
                if (q_status.m_status != QUEST_STATUS_COMPLETE)
                    curitemcount = q_status.m_itemcount[j];
                else
                    curitemcount = GetItemCount(entry,true);
                if (curitemcount < reqitemcount + count)
                {
                    uint32 remitemcount = (curitemcount <= reqitemcount ? count : count + reqitemcount - curitemcount);
                    q_status.m_itemcount[j] = curitemcount - remitemcount;
                    if (q_status.uState != QUEST_NEW) q_status.uState = QUEST_CHANGED;

                    IncompleteQuest(questid);
                }
                return;
            }
        }
    }
    UpdateForQuestsGO();
}

void Player::KilledMonster(uint32 entry, uint64 guid)
{
    uint32 addkillcount = 1;
    for (int i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        Quest const* qInfo = sObjectMgr.GetQuestTemplate(questid);
        if (!qInfo)
            continue;
        // just if !ingroup || !noraidgroup || raidgroup
        QuestStatusData& q_status = mQuestStatus[questid];
        if (q_status.m_status == QUEST_STATUS_INCOMPLETE && (!GetGroup() || !GetGroup()->isRaidGroup() || qInfo->GetType() == QUEST_TYPE_RAID || qInfo->GetType() == QUEST_TYPE_PVP))
        {
            if (qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_KILL_OR_CAST))
            {
                for (int j = 0; j < QUEST_OBJECTIVES_COUNT; j++)
                {
                    // skip GO activate objective or none
                    if (qInfo->ReqCreatureOrGOId[j] <=0)
                        continue;

                    // skip Cast at creature objective
                    if (qInfo->ReqSpell[j] !=0)
                        continue;

                    uint32 reqkill = qInfo->ReqCreatureOrGOId[j];

                    if (reqkill == entry)
                    {
                        uint32 reqkillcount = qInfo->ReqCreatureOrGOCount[j];
                        uint32 curkillcount = q_status.m_creatureOrGOcount[j];
                        if (curkillcount < reqkillcount)
                        {
                            q_status.m_creatureOrGOcount[j] = curkillcount + addkillcount;
                            if (q_status.uState != QUEST_NEW) q_status.uState = QUEST_CHANGED;

                            SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curkillcount, addkillcount);
                        }
                        if (CanCompleteQuest(questid))
                            CompleteQuest(questid);

                        // same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
                        continue;
                    }
                }
            }
        }
    }
}

void Player::CastedCreatureOrGO(uint32 entry, uint64 guid, uint32 spell_id)
{
    bool isCreature = IS_CREATURE_GUID(guid);

    uint32 addCastCount = 1;
    for (int i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        Quest const* qInfo = sObjectMgr.GetQuestTemplate(questid);
        if (!qInfo )
            continue;

        QuestStatusData& q_status = mQuestStatus[questid];

        if (q_status.m_status == QUEST_STATUS_INCOMPLETE)
        {
            if (qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_KILL_OR_CAST))
            {
                for (int j = 0; j < QUEST_OBJECTIVES_COUNT; j++)
                {
                    // skip kill creature objective (0) or wrong spell casts
                    if (qInfo->ReqSpell[j] != spell_id)
                        continue;

                    uint32 reqTarget = 0;

                    if (isCreature)
                    {
                        // creature activate objectives
                        if (qInfo->ReqCreatureOrGOId[j] > 0)
                            // checked at quest_template loading
                            reqTarget = qInfo->ReqCreatureOrGOId[j];
                    }
                    else
                    {
                        // GO activate objective
                        if (qInfo->ReqCreatureOrGOId[j] < 0)
                            // checked at quest_template loading
                            reqTarget = - qInfo->ReqCreatureOrGOId[j];
                    }

                    // other not this creature/GO related objectives
                    if (reqTarget != entry)
                        continue;

                    uint32 reqCastCount = qInfo->ReqCreatureOrGOCount[j];
                    uint32 curCastCount = q_status.m_creatureOrGOcount[j];
                    if (curCastCount < reqCastCount)
                    {
                        q_status.m_creatureOrGOcount[j] = curCastCount + addCastCount;
                        if (q_status.uState != QUEST_NEW) q_status.uState = QUEST_CHANGED;

                        SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curCastCount, addCastCount);
                    }

                    if (CanCompleteQuest(questid))
                        CompleteQuest(questid);

                    // same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
                    break;
                }
            }
        }
    }
}

void Player::TalkedToCreature(uint32 entry, uint64 guid)
{
    uint32 addTalkCount = 1;
    for (int i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        Quest const* qInfo = sObjectMgr.GetQuestTemplate(questid);
        if (!qInfo)
            continue;

        QuestStatusData& q_status = mQuestStatus[questid];

        if (q_status.m_status == QUEST_STATUS_INCOMPLETE)
        {
            if (qInfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_KILL_OR_CAST | QUEST_LOOKING4GROUP_FLAGS_SPEAKTO))
            {
                for (int j = 0; j < QUEST_OBJECTIVES_COUNT; j++)
                {
                                                            // skip spell casts and Gameobject objectives
                    if (qInfo->ReqSpell[j] > 0 || qInfo->ReqCreatureOrGOId[j] < 0)
                        continue;

                    uint32 reqTarget = 0;

                    if (qInfo->ReqCreatureOrGOId[j] > 0)     // creature activate objectives
                                                            // checked at quest_template loading
                        reqTarget = qInfo->ReqCreatureOrGOId[j];
                    else
                        continue;

                    if (reqTarget == entry)
                    {
                        uint32 reqTalkCount = qInfo->ReqCreatureOrGOCount[j];
                        uint32 curTalkCount = q_status.m_creatureOrGOcount[j];
                        if (curTalkCount < reqTalkCount)
                        {
                            q_status.m_creatureOrGOcount[j] = curTalkCount + addTalkCount;
                            if (q_status.uState != QUEST_NEW) q_status.uState = QUEST_CHANGED;

                            SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curTalkCount, addTalkCount);
                        }
                        if (CanCompleteQuest(questid))
                            CompleteQuest(questid);

                        // same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
                        continue;
                    }
                }
            }
        }
    }
}

void Player::MoneyChanged(uint32 count)
{
    for (int i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        Quest const* qInfo = sObjectMgr.GetQuestTemplate(questid);
        if (qInfo && qInfo->GetRewOrReqMoney() < 0)
        {
            QuestStatusData& q_status = mQuestStatus[questid];

            if (q_status.m_status == QUEST_STATUS_INCOMPLETE)
            {
                if (int32(count) >= -qInfo->GetRewOrReqMoney())
                {
                    if (CanCompleteQuest(questid))
                        CompleteQuest(questid);
                }
            }
            else if (q_status.m_status == QUEST_STATUS_COMPLETE)
            {
                if (int32(count) < -qInfo->GetRewOrReqMoney())
                    IncompleteQuest(questid);
            }
        }
    }
}

void Player::ReputationChanged(FactionEntry const* factionEntry )
{
    for (int i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        if (uint32 questid = GetQuestSlotQuestId(i))
        {
            if (Quest const* qInfo = sObjectMgr.GetQuestTemplate(questid))
            {
                if (qInfo->GetRepObjectiveFaction() == factionEntry->ID)
                {
                    QuestStatusData& q_status = mQuestStatus[questid];
                    if (q_status.m_status == QUEST_STATUS_INCOMPLETE)
                    {
                        if (m_reputationMgr.GetReputation(factionEntry) >= qInfo->GetRepObjectiveValue())
                            if (CanCompleteQuest(questid))
                                CompleteQuest(questid);
                    }
                    else if (q_status.m_status == QUEST_STATUS_COMPLETE)
                    {
                        if (m_reputationMgr.GetReputation(factionEntry) < qInfo->GetRepObjectiveValue())
                            IncompleteQuest(questid);
                    }
                }
            }
        }
    }
}

bool Player::HasQuestForItem(uint32 itemid) const
{
    for (int i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (questid == 0)
            continue;

        QuestStatusMap::const_iterator qs_itr = mQuestStatus.find(questid);
        if(qs_itr == mQuestStatus.end())
            continue;

        QuestStatusData const& q_status = qs_itr->second;

        if (q_status.m_status == QUEST_STATUS_INCOMPLETE)
        {
            Quest const* qinfo = sObjectMgr.GetQuestTemplate(questid);
            if (!qinfo)
                continue;

            // hide quest if player is in raid-group and quest is no raid quest
            if (GetGroup() && GetGroup()->isRaidGroup() && qinfo->GetType() != QUEST_TYPE_RAID)
                if (!InBattleGround()) //there are two ways.. we can make every bg-quest a raidquest, or add this code here.. i don't know if this can be exploited by other quests, but i think all other quests depend on a specific area.. but keep this in mind, if something strange happens later
                    continue;

            // There should be no mixed ReqItem/ReqSource drop
            // This part for ReqItem drop
            for (int j = 0; j < QUEST_OBJECTIVES_COUNT; j++)
            {
                if (itemid == qinfo->ReqItemId[j] && q_status.m_itemcount[j] < qinfo->ReqItemCount[j])
                    return true;
            }
            // This part - for ReqSource
            for (int j = 0; j < QUEST_SOURCE_ITEM_IDS_COUNT; j++)
            {
                // examined item is a source item
                if (qinfo->ReqSourceId[j] == itemid && qinfo->ReqSourceRef[j] > 0 && qinfo->ReqSourceRef[j] <= QUEST_OBJECTIVES_COUNT)
                {
                    uint32 idx = qinfo->ReqSourceRef[j]-1;

                    // total count of created ReqItems and SourceItems is less than ReqItemCount
                    if (qinfo->ReqItemId[idx] != 0 &&
                        q_status.m_itemcount[idx] * qinfo->ReqSourceCount[j] + GetItemCount(itemid,true) < qinfo->ReqItemCount[idx] * qinfo->ReqSourceCount[j])
                        return true;

                    // total count of casted ReqCreatureOrGOs and SourceItems is less than ReqCreatureOrGOCount
                    if (qinfo->ReqCreatureOrGOId[idx] != 0)
                    {
                        if (q_status.m_creatureOrGOcount[idx] * qinfo->ReqSourceCount[j] + GetItemCount(itemid,true) < qinfo->ReqCreatureOrGOCount[idx] * qinfo->ReqSourceCount[j])
                            return true;
                    }
                    // spell with SPELL_EFFECT_QUEST_COMPLETE or SPELL_EFFECT_SEND_EVENT (with script) case
                    else if (qinfo->ReqSpell[idx] != 0)
                    {
                        // not casted and need more reagents/item for use.
                        if (!q_status.m_explored && GetItemCount(itemid,true) < qinfo->ReqSourceCount[j])
                            return true;
                    }
                }
            }
        }
    }
    return false;
}

void Player::SendQuestComplete(uint32 quest_id)
{
    if (quest_id)
    {
        WorldPacket data(SMSG_QUESTUPDATE_COMPLETE, 4);
        data << uint32(quest_id);
        SendPacketToSelf(&data);
        sLog.outDebug("WORLD: Sent SMSG_QUESTUPDATE_COMPLETE quest = %u", quest_id);
    }
}

void Player::SendQuestReward(Quest const *pQuest, uint32 XP, Object * questGiver)
{
    uint32 questid = pQuest->GetQuestId();
    sLog.outDebug("WORLD: Sent SMSG_QUESTGIVER_QUEST_COMPLETE quest = %u", questid);
    sGameEventMgr.HandleQuestComplete(questid);
    WorldPacket data(SMSG_QUESTGIVER_QUEST_COMPLETE, (4+4+4+4+4+4+pQuest->GetRewItemsCount()*8));
    data << questid;
    data << uint32(0x03);

    if (getLevel() < sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
    {
        data << XP;
        data << uint32(pQuest->GetRewOrReqMoney());
    }
    else
    {
        data << uint32(0);
        data << uint32(pQuest->GetRewOrReqMoney() + int32(pQuest->GetRewMoneyMaxLevel() * sWorld.getRate(RATE_DROP_MONEY)));
    }
    data << uint32(0);                                      // new 2.3.0, HonorPoints?
    data << uint32(pQuest->GetRewItemsCount());           // max is 5

    for (uint32 i = 0; i < pQuest->GetRewItemsCount(); ++i)
    {
        if (pQuest->RewItemId[i] > 0)
            data << pQuest->RewItemId[i] << pQuest->RewItemCount[i];
        else
            data << uint32(0) << uint32(0);
    }
    SendPacketToSelf(&data);
}

void Player::SendQuestFailed(uint32 quest_id)
{
    if (quest_id)
    {
        WorldPacket data(SMSG_QUESTGIVER_QUEST_FAILED, 4);
        data << quest_id;
        SendPacketToSelf(&data);
        sLog.outDebug("WORLD: Sent SMSG_QUESTGIVER_QUEST_FAILED");
    }
}

void Player::SendQuestTimerFailed(uint32 quest_id)
{
    if (quest_id)
    {
        WorldPacket data(SMSG_QUESTUPDATE_FAILEDTIMER, 4);
        data << quest_id;
        SendPacketToSelf(&data);
        sLog.outDebug("WORLD: Sent SMSG_QUESTUPDATE_FAILEDTIMER");
    }
}

void Player::SendQuestConfirmAccept(const Quest* pQuest, Player* pReceiver)
{
    if (pReceiver)
    {
        int loc_idx = pReceiver->GetSession()->GetSessionDbLocaleIndex();
        std::string name = pQuest->GetName();
        sObjectMgr.GetQuestLocaleStrings(pQuest->GetQuestId(), loc_idx, &name);

        WorldPacket data(SMSG_QUEST_CONFIRM_ACCEPT, (4 + name.size() + 8));
        data << uint32(pQuest->GetQuestId());
        data << name;
        data << uint64(GetGUID());
        pReceiver->SendPacketToSelf(&data);

        sLog.outDebug("WORLD: Sent SMSG_QUEST_CONFIRM_ACCEPT");
    }
}

void Player::SendCanTakeQuestResponse(uint32 msg)
{
    WorldPacket data(SMSG_QUESTGIVER_QUEST_INVALID, 4);
    data << uint32(msg);
    SendPacketToSelf(&data);
    sLog.outDebug("WORLD: Sent SMSG_QUESTGIVER_QUEST_INVALID");
}

void Player::SendPushToPartyResponse(Player *pPlayer, uint32 msg)
{
    if (pPlayer)
    {
        WorldPacket data(MSG_QUEST_PUSH_RESULT, (8+1));
        data << uint64(pPlayer->GetGUID());
        data << uint8(msg);                                 // valid values: 0-8
        SendPacketToSelf(&data);
        sLog.outDebug("WORLD: Sent MSG_QUEST_PUSH_RESULT");
    }
}

void Player::SendQuestUpdateAddItem(Quest const* pQuest, uint32 item_idx, uint32 count)
{
    WorldPacket data(SMSG_QUESTUPDATE_ADD_ITEM, (4+4));
    sLog.outDebug("WORLD: Sent SMSG_QUESTUPDATE_ADD_ITEM");
    data << pQuest->ReqItemId[item_idx];
    data << count;
    SendPacketToSelf(&data);
}

void Player::SendQuestUpdateAddCreatureOrGo(Quest const* pQuest, uint64 guid, uint32 creatureOrGO_idx, uint32 old_count, uint32 add_count)
{
    ASSERT(old_count + add_count < 256 && "mob/GO count store in 8 bits 2^8 = 256 (0..256)");

    int32 entry = pQuest->ReqCreatureOrGOId[ creatureOrGO_idx ];
    if (entry < 0)
        // client expected gameobject template id in form (id|0x80000000)
        entry = (-entry) | 0x80000000;

    WorldPacket data(SMSG_QUESTUPDATE_ADD_KILL, (4*4+8));
    sLog.outDebug("WORLD: Sent SMSG_QUESTUPDATE_ADD_KILL");
    data << uint32(pQuest->GetQuestId());
    data << uint32(entry);
    data << uint32(old_count + add_count);
    data << uint32(pQuest->ReqCreatureOrGOCount[ creatureOrGO_idx ]);
    data << uint64(guid);
    SendPacketToSelf(&data);

    uint16 log_slot = FindQuestSlot(pQuest->GetQuestId());
    if (log_slot < MAX_QUEST_LOG_SIZE)
        SetQuestSlotCounter(log_slot,creatureOrGO_idx,GetQuestSlotCounter(log_slot,creatureOrGO_idx)+add_count);
}

/*********************************************************/
/***                   LOAD SYSTEM                     ***/
/*********************************************************/

bool Player::MinimalLoadFromDB(QueryResultAutoPtr result, uint32 guid)
{
    if (!result)
    {
        //                                        0     1     2     3           4           5           6    7          8          9
        result = RealmDataDatabase.PQuery("SELECT guid, data, name, position_x, position_y, position_z, map, totaltime, leveltime, at_login FROM characters WHERE guid = '%u'",guid);
        if (!result)
            return false;
    }

    Field *fields = result->Fetch();

    if (!LoadValues(fields[1].GetString()))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player #%d have broken data in data field. Can't be loaded for character list.",GUID_LOPART(guid));
        return false;
    }

    // overwrite possible wrong/corrupted guid
    SetUInt64Value(OBJECT_FIELD_GUID, MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER));

    m_name = fields[2].GetCppString();

    Relocate(fields[3].GetFloat(),fields[4].GetFloat(),fields[5].GetFloat());
    SetMapId(fields[6].GetUInt32());
    // the instance id is not needed at character enum

    m_Played_time[0] = fields[7].GetUInt32();
    m_Played_time[1] = fields[8].GetUInt32();

    m_atLoginFlags = fields[9].GetUInt32();

    // I don't see these used anywhere ..
    /*_LoadGroup();

    _LoadBoundInstances();*/

    for (int i = 0; i < PLAYER_SLOTS_COUNT; i++)
        m_items[i] = NULL;

    if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST))
        m_deathState = DEAD;

    return true;
}

void Player::_LoadDeclinedNames(QueryResultAutoPtr result)
{
    if (!result)
        return;

    if (m_declinedname)
        delete m_declinedname;

    m_declinedname = new DeclinedName;
    Field *fields = result->Fetch();
    for (int i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
        m_declinedname->name[i] = fields[i].GetCppString();
}

void Player::_LoadArenaTeamInfo(QueryResultAutoPtr result)
{
    // arenateamid, played_week, played_season, personal_rating
    memset((void*)&m_uint32Values[PLAYER_FIELD_ARENA_TEAM_INFO_1_1], 0, sizeof(uint32)*18);
    if (!result)
        return;

    do
    {
        Field *fields = result->Fetch();

        uint32 arenateamid     = fields[0].GetUInt32();
        uint32 played_week     = fields[1].GetUInt32();
        uint32 played_season   = fields[2].GetUInt32();
        uint32 personal_rating = fields[3].GetUInt32();

        ArenaTeam* aTeam = sObjectMgr.GetArenaTeamById(arenateamid);
        if (!aTeam)
        {
            sLog.outLog(LOG_DEFAULT, "FATAL ERROR: couldn't load arenateam %u", arenateamid);
            continue;
        }
        uint8  arenaSlot = aTeam->GetSlot();

        m_uint32Values[PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + arenaSlot * 6]     = arenateamid;      // TeamID
        m_uint32Values[PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + arenaSlot * 6 + 1] = ((aTeam->GetCaptain() == GetGUID()) ? (uint32)0 : (uint32)1); // Captain 0, member 1
        m_uint32Values[PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + arenaSlot * 6 + 2] = played_week;      // Played Week
        m_uint32Values[PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + arenaSlot * 6 + 3] = played_season;    // Played Season
        m_uint32Values[PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + arenaSlot * 6 + 4] = 0;                // Unk
        m_uint32Values[PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + arenaSlot * 6 + 5] = personal_rating;  // Personal Rating

    }while (result->NextRow());
}

bool Player::LoadPositionFromDB(uint32& mapid, float& x,float& y,float& z,float& o, bool& in_flight, uint64 guid)
{
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT position_x,position_y,position_z,orientation,map,taxi_path FROM characters WHERE guid = '%u'",GUID_LOPART(guid));
    if (!result)
        return false;

    Field *fields = result->Fetch();

    x = fields[0].GetFloat();
    y = fields[1].GetFloat();
    z = fields[2].GetFloat();
    o = fields[3].GetFloat();
    mapid = fields[4].GetUInt32();
    in_flight = !fields[5].GetCppString().empty();

    return true;
}

bool Player::LoadValuesArrayFromDB(Tokens& data, uint64 guid)
{
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT data FROM characters WHERE guid='%u'",GUID_LOPART(guid));
    if (!result)
        return false;

    Field *fields = result->Fetch();

    data = StrSplit(fields[0].GetCppString(), " ");

    return true;
}

uint32 Player::GetUInt32ValueFromArray(Tokens const& data, uint16 index)
{
    if (index >= data.size())
        return 0;

    return (uint32)atoi(data[index].c_str());
}

float Player::GetFloatValueFromArray(Tokens const& data, uint16 index)
{
    float result;
    uint32 temp = Player::GetUInt32ValueFromArray(data,index);
    memcpy(&result, &temp, sizeof(result));

    return result;
}

uint32 Player::GetUInt32ValueFromDB(uint16 index, uint64 guid)
{
    Tokens data;
    if (!LoadValuesArrayFromDB(data,guid))
        return 0;

    return GetUInt32ValueFromArray(data,index);
}

float Player::GetFloatValueFromDB(uint16 index, uint64 guid)
{
    float result;
    uint32 temp = Player::GetUInt32ValueFromDB(index, guid);
    memcpy(&result, &temp, sizeof(result));

    return result;
}

bool Player::LoadFromDB(uint32 guid, SqlQueryHolder *holder)
{
    QueryResultAutoPtr result = holder->GetResult(PLAYER_LOGIN_QUERY_LOADFROM);

    if (!result)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player (GUID: %u) not found in table `characters`, can't load. ",guid);
        return false;
    }

    Field *fields = result->Fetch();

    uint32 dbAccountId = fields[1].GetUInt32();

    // check if the character's account in the db and the logged in account match.
    // player should be able to load/delete character only with correct account!
    if (dbAccountId != GetSession()->GetAccountId())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player (GUID: %u) loading from wrong account (is: %u, should be: %u)", guid, GetSession()->GetAccountId(), dbAccountId);
        return false;
    }

    Object::_Create(guid, 0, HIGHGUID_PLAYER);

    m_name = fields[3].GetCppString();

    // check name limitations
    if (!ObjectMgr::IsValidName(m_name) || !GetSession()->HasPermissions(PERM_GMT) && sObjectMgr.IsReservedName(m_name))
    {
        RealmDataDatabase.PExecute("UPDATE characters SET at_login = at_login | '%u' WHERE guid ='%u'", uint32(AT_LOGIN_RENAME),guid);
        return false;
    }

    if (!LoadValues(fields[2].GetString()))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player #%d have broken data in `data` field. Can't be loaded.",GUID_LOPART(guid));
        return false;
    }

    // overwrite possible wrong/corrupted guid
    SetUInt64Value(OBJECT_FIELD_GUID, MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER));

    // overwrite some data fields
    uint32 bytes0 = GetUInt32Value(UNIT_FIELD_BYTES_0) & 0xFF000000;
    bytes0 |= fields[4].GetUInt8();                         // race
    bytes0 |= fields[5].GetUInt8() << 8;                    // class
    bytes0 |= fields[6].GetUInt8() << 16;                   // gender

    uint32 pBytes = fields[10].GetUInt32();
    uint32 pBytes2 = fields[11].GetUInt32();

    m_atLoginFlags = fields[34].GetUInt32();

    uint8 gender = fields[6].GetUInt8();
    if (HasAtLoginFlag(AT_LOGIN_DISPLAY_CHANGE))
    {
        std::string name = std::string("Hg") + GetName();
        name[2] = std::tolower(name[2]);
        if (name.length() > 12)
            name.resize(12, '\0');

        uint64 guid = sObjectMgr.GetPlayerGUIDByName(name);
        if (guid && sObjectMgr.GetPlayerAccountIdByGUID(guid) == GetSession()->GetAccountId())
        {
            // & will clear class and rest of stuff
            uint32 newBytes0 = GetUInt32ValueFromDB(UNIT_FIELD_BYTES_0, guid) & 0x00FF00FF;

            // same race, continue
            if ((newBytes0 & 0x000000FF) == fields[4].GetUInt8())
            {
                newBytes0 |= fields[5].GetUInt8() << 8;  // class
                newBytes0 |= bytes0 & 0xFF000000; // powertype

                bytes0 = newBytes0;

                pBytes = GetUInt32ValueFromDB(PLAYER_BYTES, guid);

                pBytes2 = (pBytes2 & 0xFFFFFF00) | (GetUInt32ValueFromDB(PLAYER_BYTES_2, guid) & 0x000000FF);

                gender = (newBytes0 & 0x00FF0000) >> 16;
                uint32 display = GetUInt32ValueFromDB(UNIT_FIELD_NATIVEDISPLAYID, guid);

                SetNativeDisplayId(display);
                SetDisplayId(display);

                DeleteFromDB(guid, GetSession()->GetAccountId(), true);

                m_atLoginFlags = m_atLoginFlags & ~AT_LOGIN_DISPLAY_CHANGE;
                RealmDataDatabase.PExecute("UPDATE characters SET at_login = at_login & ~ %u WHERE guid ='%u'", uint32(AT_LOGIN_DISPLAY_CHANGE), GetGUIDLow());
                sLog.outLog(LOG_SPECIAL, "Player: %s [%u] changed character display successfully.", GetName(), GetGUIDLow());
            }
        }
    }

    SetUInt32Value(UNIT_FIELD_BYTES_0, bytes0);
    SetUInt32Value(UNIT_FIELD_LEVEL, fields[7].GetUInt8());
    SetUInt32Value(PLAYER_XP, fields[8].GetUInt32());
    SetUInt32Value(PLAYER_FIELD_COINAGE, fields[9].GetUInt32());

    SetUInt32Value(PLAYER_BYTES, pBytes);
    SetUInt32Value(PLAYER_BYTES_2, pBytes2);
    SetUInt32Value(PLAYER_BYTES_3, (GetUInt32Value(PLAYER_BYTES_3) & ~1));
    SetByteValue(PLAYER_BYTES_3, 0, gender);

    SetUInt32Value(PLAYER_FLAGS, fields[12].GetUInt32());

    // cleanup inventory related item value fields (its will be filled correctly in _LoadInventory)
    for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        SetUInt64Value((uint16)(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2)), 0);
        SetVisibleItemSlot(slot, NULL);

        if (m_items[slot])
        {
            delete m_items[slot];
            m_items[slot] = NULL;
        }
    }

    // update money limits
    if (GetMoney() > MAX_MONEY_AMOUNT)
        SetMoney(MAX_MONEY_AMOUNT);

    sLog.outDebug("Load Basic value of player %s is: ", m_name.c_str());
    outDebugValues();

    // Need to call it to initialize m_team (m_team can be calculated from race)
    // Other way is to saves m_team into characters table.
    setFactionForRace(getRace());
    SetCharm(NULL);

    if (!_LoadHomeBind(holder->GetResult(PLAYER_LOGIN_QUERY_LOADHOMEBIND)))
        return false;

    InitPrimaryProffesions();                               // to max set before any spell loaded

    uint32 transGUID = fields[31].GetUInt32();
    Relocate(fields[13].GetFloat(),fields[14].GetFloat(),fields[15].GetFloat(),fields[17].GetFloat());
    SetMapId(fields[16].GetUInt32());
    SetFallInformation(0, fields[15].GetFloat());
    SetInstanceId(fields[41].GetFloat());
    SetDifficulty(fields[39].GetUInt32());                  // may be changed in _LoadGroup

    _LoadGroup(holder->GetResult(PLAYER_LOGIN_QUERY_LOADGROUP));

    _LoadArenaTeamInfo(holder->GetResult(PLAYER_LOGIN_QUERY_LOADARENAINFO));

    uint32 arena_currency = GetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY) + fields[40].GetUInt32();
    if (arena_currency > sWorld.getConfig(CONFIG_MAX_ARENA_POINTS))
        arena_currency = sWorld.getConfig(CONFIG_MAX_ARENA_POINTS);

    SetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY, arena_currency);

    // check arena teams integrity
    for (uint32 arena_slot = 0; arena_slot < MAX_ARENA_SLOT; ++arena_slot)
    {
        uint32 arena_team_id = GetArenaTeamId(arena_slot);
        if (!arena_team_id)
            continue;

        if (ArenaTeam * at = sObjectMgr.GetArenaTeamById(arena_team_id))
            if (at->HaveMember(GetGUID()))
                continue;

        // arena team not exist or not member, cleanup fields
        for (int j = 0; j < 6; ++j)
            SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + arena_slot * 6 + j, 0);
    }

    _LoadInstanceTimeRestrictions(holder->GetResult(PLAYER_LOGIN_QUERY_LOADINSTANCELOCKTIMES));
    _LoadBoundInstances(holder->GetResult(PLAYER_LOGIN_QUERY_LOADBOUNDINSTANCES));

    if (!IsPositionValid())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player (guidlow %d) have invalid coordinates (X: %f Y: %f Z: %f O: %f). Teleport to default race/class locations.",guid,GetPositionX(),GetPositionY(),GetPositionZ(),GetOrientation());

        RelocateToHomebind();

        transGUID = 0;

        m_movementInfo.ClearTransportData();
    }

    ////                                                            0     1       2      3    4    5    6
    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT bgid, bgteam, bgmap, bgx, bgy, bgz, bgo FROM character_bgcoord WHERE guid = '%u'", GUID_LOPART(m_guid));
    QueryResultAutoPtr resultbg = holder->GetResult(PLAYER_LOGIN_QUERY_LOADBGCOORD);

    if (resultbg)
    {
        Field *fieldsbg = resultbg->Fetch();

        uint32 bgid = fieldsbg[0].GetUInt32();
        uint32 bgteam = fieldsbg[1].GetUInt32();

        if (bgid) //saved in BattleGround
        {
            SetBattleGroundEntryPoint(fieldsbg[2].GetUInt32(),fieldsbg[3].GetFloat(),fieldsbg[4].GetFloat(),fieldsbg[5].GetFloat(),fieldsbg[6].GetFloat());

            BattleGround *currentBg = sBattleGroundMgr.GetBattleGround(bgid, BATTLEGROUND_TYPE_NONE);

            if (currentBg && currentBg->IsPlayerInBattleGround(GetGUID()))
            {
                BattleGroundQueueTypeId bgQueueTypeId = sBattleGroundMgr.BGQueueTypeId(currentBg->GetTypeID(), currentBg->GetArenaType());
                uint32 queueSlot = AddBattleGroundQueueId(bgQueueTypeId);

                SetBattleGroundId(currentBg->GetInstanceID(), currentBg->GetTypeID());
                SetBGTeam(bgteam);
                currentBg->AddOrSetPlayerToCorrectBgGroup(this, GetGUID(), bgteam);

                if (GetBGTeam() == HORDE)
                    setFaction(2); // orc, and generic for horde
                else if (GetBGTeam() == ALLIANCE)
                    setFaction(1); // dwarf/gnome, and generic for alliance

                if (TeamForRace(getRace()) != GetBGTeam())
                {
                    switch (urand(1,2))
                    {
                    case 1:
                        // Human / Bloodelf
                        if (GetBGTeam() == ALLIANCE && getGender() == GENDER_MALE)
                        {
                            SetDisplayId(19723);
                            SetNativeDisplayId(19723);
                        }
                        else if (GetBGTeam() == ALLIANCE && getGender() == GENDER_FEMALE)
                        {
                            SetDisplayId(19724);
                            SetNativeDisplayId(19724);
                        }
                        else if (GetBGTeam() == HORDE && getGender() == GENDER_MALE)
                        {
                            SetDisplayId(20578);
                            SetNativeDisplayId(20578);
                        }
                        else if (GetBGTeam() == HORDE && getGender() == GENDER_FEMALE)
                        {
                            SetDisplayId(20579);
                            SetNativeDisplayId(20579);
                        }
                        break;
                    case 2:
                        // Gnome / Tauren
                        if (GetBGTeam() == HORDE && getGender() == GENDER_MALE)
                        {
                            SetDisplayId(20585);
                            SetNativeDisplayId(20585);
                        }
                        else if (GetBGTeam() == HORDE && getGender() == GENDER_FEMALE)
                        {
                            SetDisplayId(20584);
                            SetNativeDisplayId(20584);
                        }
                        else if (GetBGTeam() == ALLIANCE && getGender() == GENDER_MALE)
                        {
                            SetDisplayId(20580);
                            SetNativeDisplayId(20580);
                        }
                        else if (GetBGTeam() == ALLIANCE && getGender() == GENDER_FEMALE)
                        {
                            SetDisplayId(20581);
                            SetNativeDisplayId(20581);
                        }
                        break;
                    }
                }

                SetInviteForBattleGroundQueueType(bgQueueTypeId,currentBg->GetInstanceID());
            }
            else
            {
                SetMapId(GetBattleGroundEntryPointMap());
                Relocate(GetBattleGroundEntryPointX(),GetBattleGroundEntryPointY(),GetBattleGroundEntryPointZ(),GetBattleGroundEntryPointO());
                //RemoveArenaAuras(true);
                if (!isAlive())// resurrect on bg exit
                {
                    ResurrectPlayer(1.0f);
                    SpawnCorpseBones();
                }
            }
        }
    }

    if (transGUID != 0)
    {
        m_movementInfo.SetTransportData(transGUID, fields[27].GetFloat(), fields[28].GetFloat(), fields[29].GetFloat(), fields[30].GetFloat(), 0);

        if (!Looking4group::IsValidMapCoord(
            GetPositionX() + m_movementInfo.GetTransportPos()->x, GetPositionY() + m_movementInfo.GetTransportPos()->y,
            GetPositionZ() + m_movementInfo.GetTransportPos()->z, GetOrientation() + m_movementInfo.GetTransportPos()->o) ||

            // transport size limited
            m_movementInfo.GetTransportPos()->x > 50 || m_movementInfo.GetTransportPos()->y > 50 || m_movementInfo.GetTransportPos()->z > 50)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Player (guidlow %d) have invalid transport coordinates (X: %f Y: %f Z: %f O: %f). Teleport to default race/class locations.",
                 guid, GetPositionX() + m_movementInfo.GetTransportPos()->x, GetPositionY() + m_movementInfo.GetTransportPos()->y,
                GetPositionZ() + m_movementInfo.GetTransportPos()->z, GetOrientation() + m_movementInfo.GetTransportPos()->o);

            RelocateToHomebind();

            m_movementInfo.ClearTransportData();

            transGUID = 0;
        }
    }

    if (transGUID != 0)
    {
        for (MapManager::TransportSet::iterator iter = sMapMgr.m_Transports.begin(); iter != sMapMgr.m_Transports.end(); ++iter)
        {
            if ((*iter)->GetGUIDLow() == transGUID)
            {
                MapEntry const* transMapEntry = sMapStore.LookupEntry((*iter)->GetMapId());
                // client without expansion support
                if(GetSession()->Expansion() < transMapEntry->Expansion())
                {
                    sLog.outDebug("Player %s using client without required expansion tried login at transport at non accessible map %u", GetName(), (*iter)->GetMapId());
                    break;
                }

                m_transport = *iter;
                m_transport->AddPassenger(this);
                SetMapId(m_transport->GetMapId());
                break;
            }
        }

        if (!m_transport)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Player (guidlow %d) have problems with transport guid (%u). Teleport to default race/class locations.",
                guid,transGUID);

            RelocateToHomebind();

            m_movementInfo.ClearTransportData();

            transGUID = 0;
        }
    }
    else                                                    // not transport case
    {
        MapEntry const* mapEntry = sMapStore.LookupEntry(GetMapId());
        // client without expansion support
        if(GetSession()->Expansion() < mapEntry->Expansion())
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Player %s (%u acc: %u) using client without required expansion tried login at non accessible map %u", GetName(), GetGUIDLow(), GetSession()->GetAccountId(), GetMapId());
            RelocateToHomebind();
        }
    }

    if (InstanceSave *pSave = GetInstanceSave(GetMapId()))
        if (pSave->GetInstanceId() != GetInstanceId())
            SetInstanceId(pSave->GetInstanceId());

    // load the player's map here if it's not already loaded
    SetMap(sMapMgr.CreateMap(GetMapId(), this));

    Map *map = GetMap();
    if (!map)
    {
        AreaTrigger const* at = sObjectMgr.GetGoBackTrigger(GetMapId());
        if (at)
        {
            SetMapId(at->target_mapId);
            Relocate(at->target_X, at->target_Y, at->target_Z, GetOrientation());
            sLog.outLog(LOG_DEFAULT, "ERROR: Player (guidlow %d) is teleported to gobacktrigger (Map: %u X: %f Y: %f Z: %f O: %f).",guid,GetMapId(),GetPositionX(),GetPositionY(),GetPositionZ(),GetOrientation());
        }
        else
        {
            SetMapId(m_homebindMapId);
            Relocate(m_homebindX, m_homebindY, m_homebindZ, GetOrientation());
            sLog.outLog(LOG_DEFAULT, "ERROR: Player (guidlow %d) is teleported to home (Map: %u X: %f Y: %f Z: %f O: %f).",guid,GetMapId(),GetPositionX(),GetPositionY(),GetPositionZ(),GetOrientation());
        }

        map = sMapMgr.CreateMap(GetMapId(), this);
        if (!map)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Player (guidlow %d) have invalid coordinates (X: %f Y: %f Z: %f O: %f). Teleport to default race/class locations.",guid,GetPositionX(),GetPositionY(),GetPositionZ(),GetOrientation());

            RelocateToHomebind();

            map = sMapMgr.CreateMap(GetMapId(), this);
            if (!map)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Player (guidlow %d) have invalid coordinates (X: %f Y: %f Z: %f O: %f). Teleport to default race/class locations.",guid,GetPositionX(),GetPositionY(),GetPositionZ(),GetOrientation());
                sLog.outLog(LOG_DEFAULT, "ERROR: CRASH.");
                ASSERT(false);
            }
        }
    }

    SetInstanceId(map->GetInstanceId());

    if (GetInstanceId())
    {
        if (map->IsBattleGroundOrArena())
        {
            if (!sBattleGroundMgr.GetBattleGround(GetInstanceId(), BATTLEGROUND_TYPE_NONE))
            {
                SetMapId(GetBattleGroundEntryPointMap());
                Relocate(GetBattleGroundEntryPointX(), GetBattleGroundEntryPointY(), GetBattleGroundEntryPointZ(), GetBattleGroundEntryPointO());

                RemoveFromBattleGroundRaid();
                map = sMapMgr.CreateMap(GetMapId(), this);
            }
        }
        else if (!sInstanceSaveManager.GetInstanceSave(GetInstanceId()))
        {
            PlayerInfo const * tmpPlInfo = sObjectMgr.GetPlayerInfo(getRace(), getClass());
            if (tmpPlInfo)
            {
                SetMapId(tmpPlInfo->mapId);
                Relocate(tmpPlInfo->positionX, tmpPlInfo->positionY, tmpPlInfo->positionZ);
            }
            else
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Player %s(GUID: %u) logged in to a reset instance (map: %u) and there is no area-trigger leading to this map. Thus he can't be ported back to the entrance. This _might_ be an exploit attempt. Relocate to homebind.", GetName(), GetGUIDLow(), GetMapId());
                RelocateToHomebind();
            }

            map = sMapMgr.CreateMap(GetMapId(), this);
        }
    }
    SetMap(map);

    SaveRecallPosition();

    time_t now = time(NULL);
    time_t logoutTime = time_t(fields[23].GetUInt64());

    // since last logout (in seconds)
    uint64 time_diff = uint64(now - logoutTime);

    // set value, including drunk invisibility detection
    // calculate sobering. after 15 minutes logged out, the player will be sober again
    float soberFactor;
    if (time_diff > 15*MINUTE)
        soberFactor = 0;
    else
        soberFactor = 1-time_diff/(15.0f*MINUTE);
    uint16 newDrunkenValue = uint16(soberFactor*(GetUInt32Value(PLAYER_BYTES_3) & 0xFFFE));
    SetDrunkValue(newDrunkenValue);

    m_rest_bonus = fields[22].GetFloat();
    //speed collect rest bonus in offline, in logout, far from tavern, city (section/in hour)
    float bubble0 = 0.031;
    //speed collect rest bonus in offline, in logout, in tavern, city (section/in hour)
    float bubble1 = 0.125;

    if ((int32)fields[23].GetUInt32() > 0)
    {
        float bubble = fields[24].GetUInt32() > 0
            ? bubble1*sWorld.getRate(RATE_REST_OFFLINE_IN_TAVERN_OR_CITY)
            : bubble0*sWorld.getRate(RATE_REST_OFFLINE_IN_WILDERNESS);

        SetRestBonus(GetRestBonus()+ time_diff*((float)GetUInt32Value(PLAYER_NEXT_LEVEL_XP)/72000)*bubble);
    }

    m_cinematic = fields[19].GetBool();
    m_Played_time[PLAYED_TIME_TOTAL]= fields[20].GetUInt32();
    m_Played_time[PLAYED_TIME_LEVEL]= fields[21].GetUInt32();
    m_resetTalentsCost = fields[25].GetUInt32();
    m_resetTalentsTime = time_t(fields[26].GetUInt64());

    // reserve some flags
    uint32 old_safe_flags = GetUInt32Value(PLAYER_FLAGS) & (PLAYER_FLAGS_HIDE_CLOAK | PLAYER_FLAGS_HIDE_HELM);

    if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_GM))
        SetUInt32Value(PLAYER_FLAGS, 0 | old_safe_flags);

    m_taxi.LoadTaxiMask(fields[18].GetString());          // must be before InitTaxiNodesForLevel

    uint32 extraflags = fields[32].GetUInt32();

    m_stableSlots = fields[33].GetUInt32();
    if (m_stableSlots > 2)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player can have not more 2 stable slots, but have in DB %u",uint32(m_stableSlots));
        m_stableSlots = 2;
    }

    // Honor system
    // Update Honor kills data
    m_lastHonorUpdateTime = logoutTime;
    UpdateHonorFields();

    m_deathExpireTime = (time_t)fields[37].GetUInt64();
    if (m_deathExpireTime > now+MAX_DEATH_COUNT*DEATH_EXPIRE_STEP)
        m_deathExpireTime = now+MAX_DEATH_COUNT*DEATH_EXPIRE_STEP-1;

    std::string taxi_nodes = fields[38].GetCppString();

    // clear channel spell data (if saved at channel spell casting)
    SetUInt64Value(UNIT_FIELD_CHANNEL_OBJECT, 0);
    SetUInt32Value(UNIT_CHANNEL_SPELL,0);

    // clear charm/summon related fields
    SetCharm(NULL);
    SetPet(NULL);
    SetCharmerGUID(0);
    SetOwnerGUID(0);
    SetCreatorGUID(0);

    // reset some aura modifiers before aura apply
    SetFarSight(0);
    SetUInt32Value(PLAYER_TRACK_CREATURES, 0);
    SetUInt32Value(PLAYER_TRACK_RESOURCES, 0);

    // reset skill modifiers and set correct unlearn flags
    for (uint32 i = 0; i < PLAYER_MAX_SKILLS; i++)
    {
        SetUInt32Value(PLAYER_SKILL_BONUS_INDEX(i),0);

        // set correct unlearn bit
        uint32 id = GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF;
        if (!id) continue;

        SkillLineEntry const *pSkill = sSkillLineStore.LookupEntry(id);
        if (!pSkill) continue;

        // enable unlearn button for primary professions only
        if (pSkill->categoryId == SKILL_CATEGORY_PROFESSION)
            SetUInt32Value(PLAYER_SKILL_INDEX(i), MAKE_PAIR32(id,1));
        else
            SetUInt32Value(PLAYER_SKILL_INDEX(i), MAKE_PAIR32(id,0));
    }

    // make sure the unit is considered out of combat for proper loading
    ClearInCombat();

    // make sure the unit is considered not in duel for proper loading
    SetUInt64Value(PLAYER_DUEL_ARBITER, 0);
    SetUInt32Value(PLAYER_DUEL_TEAM, 0);

    // remember loaded power/health values to restore after stats initialization and modifier applying
    uint32 savedHealth = GetHealth();
    uint32 savedPower[MAX_POWERS];
    for (uint32 i = 0; i < MAX_POWERS; ++i)
        savedPower[i] = GetPower(Powers(i));

    // reset stats before loading any modifiers
    InitStatsForLevel();
    InitTaxiNodesForLevel();

    // apply original stats mods before spell loading or item equipment that call before equip _RemoveStatsMods()

    // Mail

    _LoadMails(holder->GetResult(PLAYER_LOGIN_QUERY_LOADMAILS));
    _LoadMailedItems(holder->GetResult(PLAYER_LOGIN_QUERY_LOADMAILEDITEMS));
    UpdateNextMailTimeAndUnreads();

    _LoadAuras(holder->GetResult(PLAYER_LOGIN_QUERY_LOADAURAS), time_diff);

    // add ghost flag (must be after aura load: PLAYER_FLAGS_GHOST set in aura)
    if (HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST))
        m_deathState = DEAD;

    _LoadSpells(holder->GetResult(PLAYER_LOGIN_QUERY_LOADSPELLS));

    // after spell load
    InitTalentForLevel();
    learnSkillRewardedSpells();

    // after spell load, learn rewarded spell if need also
    _LoadQuestStatus(holder->GetResult(PLAYER_LOGIN_QUERY_LOADQUESTSTATUS));
    _LoadDailyQuestStatus(holder->GetResult(PLAYER_LOGIN_QUERY_LOADDAILYQUESTSTATUS));
    _LoadMonthlyQuestStatus(holder->GetResult(PLAYER_LOGIN_QUERY_LOAD_MONTHLY_QUEST_STATUS));

    _LoadTutorials(holder->GetResult(PLAYER_LOGIN_QUERY_LOADTUTORIALS));

    // must be before inventory (some items required reputation check)
    m_reputationMgr.LoadFromDB(holder->GetResult(PLAYER_LOGIN_QUERY_LOADREPUTATION));

    _LoadInventory(holder->GetResult(PLAYER_LOGIN_QUERY_LOADINVENTORY), time_diff);

    // update items with duration and realtime
    UpdateItemDuration(time_diff, true);

    _LoadActions(holder->GetResult(PLAYER_LOGIN_QUERY_LOADACTIONS));

    m_social = sSocialMgr.LoadFromDB(holder->GetResult(PLAYER_LOGIN_QUERY_LOADSOCIALLIST), GetGUIDLow());

    //if(!_LoadHomeBind(holder->GetResult(PLAYER_LOGIN_QUERY_LOADHOMEBIND)))
    //    return false;

    // check PLAYER_CHOSEN_TITLE compatibility with PLAYER__FIELD_KNOWN_TITLES
    // note: PLAYER__FIELD_KNOWN_TITLES updated at quest status loaded
    SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES, fields[42].GetUInt64());
    if (uint32 curTitle = GetUInt32Value(PLAYER_CHOSEN_TITLE))
    {
        if (!HasTitle(curTitle))
            SetUInt32Value(PLAYER_CHOSEN_TITLE,0);
    }

    // Not finish taxi flight path
    if (!m_taxi.LoadTaxiDestinationsFromString(taxi_nodes))
    {
        // problems with taxi path loading
        TaxiNodesEntry const* nodeEntry = NULL;
        if (uint32 node_id = m_taxi.GetTaxiSource())
            nodeEntry = sTaxiNodesStore.LookupEntry(node_id);

        if (!nodeEntry)                                      // don't know taxi start node, to homebind
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Character %u have wrong data in taxi destination list, teleport to homebind.",GetGUIDLow());
            SetMapId(m_homebindMapId);
            Relocate(m_homebindX, m_homebindY, m_homebindZ,0.0f);
        }
        else                                                // have start node, to it
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Character %u have too short taxi destination list, teleport to original node.",GetGUIDLow());
            SetMapId(nodeEntry->map_id);
            Relocate(nodeEntry->x, nodeEntry->y, nodeEntry->z,0.0f);
        }

        SaveRecallPosition();                           // save as recall also to prevent recall and fall from sky

        SetMap(sMapMgr.CreateMap(GetMapId(), this));
        CleanupAfterTaxiFlight();
    }
    else if (uint32 node_id = m_taxi.GetTaxiSource())
    {
        // save source node as recall coord to prevent recall and fall from sky
        TaxiNodesEntry const* nodeEntry = sTaxiNodesStore.LookupEntry(node_id);
        ASSERT(nodeEntry);                                  // checked in m_taxi.LoadTaxiDestinationsFromString

        SaveRecallPosition(nodeEntry);

        // flight will started later
    }

    _LoadSpellCooldowns(holder->GetResult(PLAYER_LOGIN_QUERY_LOADSPELLCOOLDOWNS));

    // Spell code allow apply any auras to dead character in load time in aura/spell/item loading
    // Do now before stats re-calculation cleanup for ghost state unexpected auras
    if (!isAlive())
        RemoveAllAurasOnDeath();

    //apply all stat bonuses from items and auras
    SetCanModifyStats(true);
    UpdateAllStats();

    // prevent restoring wrong HP for ghosts
    if (HasAura(20584) || HasAura(8326))
        savedHealth = 1;

    // restore remembered power/health values (but not more max values)
    SetHealth(savedHealth > GetMaxHealth() ? GetMaxHealth() : savedHealth, true);

    for (uint32 i = 0; i < MAX_POWERS; ++i)
        SetPower(Powers(i),savedPower[i] > GetMaxPower(Powers(i)) ? GetMaxPower(Powers(i)) : savedPower[i]);

    sLog.outDebug("The value of player %s after load item and aura is: ", m_name.c_str());
    outDebugValues();

    // GM state
    if (GetSession()->HasPermissions(PERM_GMT))
    {
        switch (sWorld.getConfig(CONFIG_GM_LOGIN_STATE))
        {
            default:
            case 0:                      break;             // disable
            case 1: SetGameMaster(true); break;             // enable
            case 2:                                         // save state
                if (extraflags & PLAYER_EXTRA_GM_ON)
                    SetGameMaster(true);
                break;
        }

        switch (sWorld.getConfig(CONFIG_GM_VISIBLE_STATE))
        {
            default:
            case 0: SetGMVisible(false); break;             // invisible
            case 1:                      break;             // visible
            case 2:                                         // save state
                if (extraflags & PLAYER_EXTRA_GM_INVISIBLE)
                    SetGMVisible(false);
                break;
        }

        switch (sWorld.getConfig(CONFIG_GM_CHAT))
        {
            default:
            case 0:                  break;                 // disable
            case 1: SetGMChat(true); break;                 // enable
            case 2:                                         // save state
                if (extraflags & PLAYER_EXTRA_GM_CHAT)
                    SetGMChat(true);
                break;
        }

        switch (sWorld.getConfig(CONFIG_GM_WISPERING_TO))
        {
            default:
            case 0:                          break;         // disable
            case 1: SetAcceptWhispers(true); break;         // enable
            case 2:                                         // save state
                if (extraflags & PLAYER_EXTRA_ACCEPT_WHISPERS)
                    SetAcceptWhispers(true);
                break;
        }
    }

    _LoadDeclinedNames(holder->GetResult(PLAYER_LOGIN_QUERY_LOADDECLINEDNAMES));

    if (getClass() == CLASS_SHAMAN && getRace() == RACE_DRAENEI)
    {
        if (!HasAura(28878,0))
            learnSpell(28878);

        removeSpell(6562);
    }

    //HACK restore Netherwing aura
    if (!HasAura(40214) && m_reputationMgr.GetRank(1015) >= REP_NEUTRAL && GetQuestRewardStatus(10870))
        CastSpell(this, 40214, true);

    //HACK restore Arcane Cloaking aura (Naxx attu)
    if (!HasAura(28006) && (GetQuestRewardStatus(9121) || GetQuestRewardStatus(9122) || GetQuestRewardStatus(9123)))
        CastSpell(this, 28006, true);

    uint8 changeRaceTo = fields[43].GetUInt8();
    if (changeRaceTo)
    {
        ChangeRace(changeRaceTo);
        RealmDataDatabase.PExecute("UPDATE characters SET changeRaceTo = '0' WHERE guid ='%u'", GetGUIDLow());
    }

    return true;
}

bool Player::isAllowedToLoot(Creature* creature)
{
    if (creature->isDead() && !creature->IsDamageEnoughForLootingAndReward())
        return false;

    if (Player* recipient = creature->GetLootRecipient())
    {
        if (Group* otherGroup = recipient->GetGroup())
        {
            Group* thisGroup = GetGroup();

            if (!thisGroup)
                return false;

            if (thisGroup != otherGroup)
                return false;

            if (!creature->IsPlayerAllowedToLoot(this))
                return false;

            if (creature->isAlive())
                return true;

            if (!thisGroup->IsRoundRobinLootType())
                return true;

            // round robin rules
            if (!creature->loot.looterGUID)
                return true;

            ItemQualities threshold = thisGroup->GetLootMethod() == ROUND_ROBIN ? ITEM_QUALITY_ARTIFACT : thisGroup->GetLootThreshold();
            if (creature->loot.everyone_can_open || creature->loot.max_quality >= threshold)
                return true;

            return GetGUID() == creature->loot.looterGUID;
        }
        else if (recipient == this)
            return true;
        else
            return false;
    }
    else
    {
        // recipient may be offline, maybe there is list of players allowed to loot
        if (creature->HasPlayersAllowedToLoot() && creature->IsPlayerAllowedToLoot(this))
            return true;

        // prevent other players from looting if the recipient got disconnected
        return !creature->hasLootRecipient();
    }
}

void Player::_LoadActions(QueryResultAutoPtr result)
{
    m_actionButtons.clear();

    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT button,action,type,misc FROM character_action WHERE guid = '%u' ORDER BY button",GetGUIDLow());

    if (result)
    {
        do
        {
            Field *fields = result->Fetch();

            uint8 button = fields[0].GetUInt8();

            addActionButton(button, fields[1].GetUInt16(), fields[2].GetUInt8(), fields[3].GetUInt8());

            m_actionButtons[button].uState = ACTIONBUTTON_UNCHANGED;
        }
        while (result->NextRow());
    }
}

void Player::_LoadAuras(QueryResultAutoPtr result, uint32 timediff)
{
    m_Auras.clear();
    for (int i = 0; i < TOTAL_AURAS; i++)
        m_modAuras[i].clear();

    // all aura related fields
    for (int i = UNIT_FIELD_AURA; i <= UNIT_FIELD_AURASTATE; ++i)
        SetUInt32Value(i, 0);

    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT caster_guid,spell,effect_index,stackcount,amount,maxduration,remaintime,remaincharges FROM character_aura WHERE guid = '%u'",GetGUIDLow());

    if (result)
    {
        do
        {
            Field *fields = result->Fetch();
            uint64 caster_guid = fields[0].GetUInt64();
            uint32 spellid = fields[1].GetUInt32();
            uint32 effindex = fields[2].GetUInt32();
            uint32 stackcount = fields[3].GetUInt32();
            int32 damage     = (int32)fields[4].GetUInt32();
            int32 maxduration = (int32)fields[5].GetUInt32();
            int32 remaintime = (int32)fields[6].GetUInt32();
            int32 remaincharges = (int32)fields[7].GetUInt32();

            if (spellid == SPELL_ARENA_PREPARATION || spellid == SPELL_PREPARATION)
            {
               if (BattleGround const *bg = GetBattleGround())
                   if (bg->GetStatus() == STATUS_IN_PROGRESS)
                       continue;
            }

            SpellEntry const* spellproto = sSpellStore.LookupEntry(spellid);
            if (!spellproto)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Unknown aura (spellid %u, effindex %u), ignore.",spellid,effindex);
                continue;
            }

            if (effindex >= 3)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Invalid effect index (spellid %u, effindex %u), ignore.",spellid,effindex);
                continue;
            }

            if (spellproto->Effect[effindex] == SPELL_EFFECT_APPLY_AURA)
            {
                switch (spellproto->EffectApplyAuraName[effindex])
                {
                case SPELL_AURA_MOD_CHARM:
                case SPELL_AURA_MOD_POSSESS:
                    continue;
                }
            }

            // negative effects should continue counting down after logout
            if (remaintime != -1 && !SpellMgr::IsPositiveEffect(spellid, effindex))
            {
                if (remaintime/IN_MILISECONDS <= int32(timediff))
                    continue;

                remaintime -= timediff*IN_MILISECONDS;
            }

            // prevent wrong values of remaincharges
            if (spellproto->procCharges)
            {
                if (remaincharges <= 0 || remaincharges > spellproto->procCharges)
                    remaincharges = spellproto->procCharges;
            }
            else
                remaincharges = -1;

            for (uint32 i=0; i<stackcount; i++)
            {
                Aura* aura = CreateAura(spellproto, effindex, NULL, this, NULL);
                if (!damage)
                    damage = aura->GetModifier()->m_amount;

                // reset stolen single target auras
                if (caster_guid != GetGUID() && aura->IsSingleTarget())
                    aura->SetIsSingleTarget(false);

                aura->SetLoadedState(caster_guid,damage,maxduration,remaintime,remaincharges);
                AddAura(aura);
                sLog.outDetail("Added aura spellid %u, effect %u", spellproto->Id, effindex);
            }
        }
        while (result->NextRow());
    }

    if (getClass() == CLASS_WARRIOR)
        CastSpell(this,SPELL_ID_PASSIVE_BATTLE_STANCE,true);
}

void Player::LoadCorpse()
{
    if (isAlive())
    {
        sObjectAccessor.ConvertCorpseForPlayer(GetGUID());
    }
    else
    {
        if (Corpse *corpse = GetCorpse())
        {
            ApplyModFlag(PLAYER_FIELD_BYTES, PLAYER_FIELD_BYTE_RELEASE_TIMER, corpse && !sMapStore.LookupEntry(corpse->GetMapId())->Instanceable());
        }
        else
        {
            //Prevent Dead Player login without corpse
            ResurrectPlayer(0.5f);
        }
    }
}

void Player::_LoadInventory(QueryResultAutoPtr result, uint32 timediff)
{
    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT data,bag,slot,item,item_template FROM character_inventory JOIN item_instance ON character_inventory.item = item_instance.guid WHERE character_inventory.guid = '%u' ORDER BY bag,slot", GetGUIDLow());
    std::map<uint64, Bag*> bagMap;                          // fast guid lookup for bags
    //NOTE: the "order by `bag`" is important because it makes sure
    //the bagMap is filled before items in the bags are loaded
    //NOTE2: the "order by `slot`" is needed because mainhand weapons are (wrongly?)
    //expected to be equipped before offhand items (TODO: fixme)

    uint32 zone = GetZoneId();

    if (result)
    {
        std::list<Item*> problematicItems;

        // prevent items from being added to the queue when stored
        m_itemUpdateQueueBlocked = true;
        do
        {
            Field *fields = result->Fetch();
            uint32 bag_guid  = fields[1].GetUInt32();
            uint8  slot      = fields[2].GetUInt8();
            uint32 item_guid = fields[3].GetUInt32();
            uint32 item_id   = fields[4].GetUInt32();

            ItemPrototype const * proto = ObjectMgr::GetItemPrototype(item_id);

            if (!proto)
            {
                RealmDataDatabase.PExecute("DELETE FROM character_inventory WHERE item = '%u'", item_guid);
                RealmDataDatabase.PExecute("DELETE FROM item_instance WHERE guid = '%u'", item_guid);
                sLog.outLog(LOG_DEFAULT, "ERROR: Player::_LoadInventory: Player %s has an unknown item (id: #%u) in inventory, deleted.", GetName(),item_id);
                continue;
            }

            Item *item = NewItemOrBag(proto);

            if (!item->LoadFromDB(item_guid, GetGUID(), result))
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Player::_LoadInventory: Player %s has broken item (id: #%u) in inventory, deleted.", GetName(),item_id);
                RealmDataDatabase.PExecute("DELETE FROM character_inventory WHERE item = '%u'", item_guid);
                item->FSetState(ITEM_REMOVED);
                item->SaveToDB();                           // it also deletes item object !
                continue;
            }

            // not allow have in alive state item limited to another map/zone
            if (isAlive() && item->IsLimitedToAnotherMapOrZone(GetMapId(),zone))
            {
                RealmDataDatabase.PExecute("DELETE FROM character_inventory WHERE item = '%u'", item_guid);
                item->FSetState(ITEM_REMOVED);
                item->SaveToDB();                           // it also deletes item object !
                continue;
            }

            // "Conjured items disappear if you are logged out for more than 15 minutes"
            if ((timediff > 15*60) && (item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAGS_CONJURED)))
            {
                RealmDataDatabase.PExecute("DELETE FROM character_inventory WHERE item = '%u'", item_guid);
                item->FSetState(ITEM_REMOVED);
                item->SaveToDB();                           // it also deletes item object !
                continue;
            }

            bool success = true;

            if (!bag_guid)
            {
                // the item is not in a bag
                item->SetContainer(NULL);
                item->SetSlot(slot);

                if (IsInventoryPos(INVENTORY_SLOT_BAG_0, slot))
                {
                    ItemPosCountVec dest;
                    if (CanStoreItem(INVENTORY_SLOT_BAG_0, slot, dest, item, false) == EQUIP_ERR_OK)
                        item = StoreItem(dest, item, true);
                    else
                        success = false;
                }
                else if (IsEquipmentPos(INVENTORY_SLOT_BAG_0, slot))
                {
                    uint16 dest;
                    if (CanEquipItem(slot, dest, item, false, false) == EQUIP_ERR_OK)
                        QuickEquipItem(dest, item);
                    else
                        success = false;
                }
                else if (IsBankPos(INVENTORY_SLOT_BAG_0, slot))
                {
                    ItemPosCountVec dest;
                    if (CanBankItem(INVENTORY_SLOT_BAG_0, slot, dest, item, false, false) == EQUIP_ERR_OK)
                        item = BankItem(dest, item, true);
                    else
                        success = false;
                }

                if (success)
                {
                    // store bags that may contain items in them
                    if (item->IsBag() && IsBagPos(item->GetPos()))
                        bagMap[item_guid] = (Bag*)item;
                }
            }
            else
            {
                item->SetSlot(NULL_SLOT);
                // the item is in a bag, find the bag
                std::map<uint64, Bag*>::iterator itr = bagMap.find(bag_guid);
                if (itr != bagMap.end())
                {
                    itr->second->StoreItem(slot, item, true);
                    AddItemDurations(item); // FIXME shouldn't be here. As for now fixes a bug with an infinity of items which should have time duration limit.
                }
                else
                    success = false;
            }

            // item's state may have changed after stored
            if (success)
                item->SetState(ITEM_UNCHANGED, this);
            else
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Player::_LoadInventory: Player %s has item (GUID: %u Entry: %u) can't be loaded to inventory (Bag GUID: %u Slot: %u) by some reason, will send by mail.", GetName(),item_guid, item_id, bag_guid, slot);
                RealmDataDatabase.PExecute("DELETE FROM character_inventory WHERE item = '%u'", item_guid);
                if (!GetSession()->IsAccountFlagged(ACC_SPECIAL_LOG))
                    problematicItems.push_back(item);
            }
        } while (result->NextRow());

        m_itemUpdateQueueBlocked = false;

        // send by mail problematic items
        while (!problematicItems.empty())
        {
            std::string subject = GetSession()->GetTrinityString(LANG_NOT_EQUIPPED_ITEM);

            // fill mail
            MailDraft draft(subject);

            for (int i = 0; !problematicItems.empty() && i < MAX_MAIL_ITEMS; ++i)
            {
                Item* item = problematicItems.front();
                problematicItems.pop_front();

                draft.AddItem(item);
            }

            draft.SendMailTo(this, MailSender(this, MAIL_STATIONERY_GM));
        }
    }
    //if(isAlive())
    _ApplyAllItemMods();
}

// load mailed item which should receive current player
void Player::_LoadMailedItems(QueryResultAutoPtr result)
{
    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT item_guid, item_template FROM mail_items WHERE mail_id='%u'", mail->messageID);
    if (!result)
        return;

    do
    {
        Field *fields = result->Fetch();
        uint32 mail_id       = fields[1].GetUInt32();
        uint32 item_guid_low = fields[2].GetUInt32();
        uint32 item_template = fields[3].GetUInt32();

        Mail* mail = GetMail(mail_id);
        if(!mail)
            continue;
        mail->AddItem(item_guid_low, item_template);

        ItemPrototype const *proto = ObjectMgr::GetItemPrototype(item_template);

        if(!proto)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Player %u has unknown item_template (ProtoType) in mailed items(GUID: %u template: %u) in mail (%u), deleted.", GetGUIDLow(), item_guid_low, item_template, mail->messageID);
            RealmDataDatabase.PExecute("DELETE FROM mail_items WHERE item_guid = '%u'", item_guid_low);
            RealmDataDatabase.PExecute("DELETE FROM item_instance WHERE guid = '%u'", item_guid_low);
            continue;
        }

        Item *item = NewItemOrBag(proto);

        if (!item->LoadFromDB(item_guid_low, 0))
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Player::_LoadMailedItems - Item in mail (%u) doesn't exist !!!! - item guid: %u, deleted from mail", mail->messageID, item_guid_low);
            RealmDataDatabase.PExecute("DELETE FROM mail_items WHERE item_guid = '%u'", item_guid_low);
            item->FSetState(ITEM_REMOVED);
            item->SaveToDB();                               // it also deletes item object !
            continue;
        }

        AddMItem(item);
    } while (result->NextRow());
}

void Player::_LoadMails(QueryResultAutoPtr result)
{
    m_mail.clear();
    //mails are in right order                                     0      1         2       3        4       5           6           7           8   9   10         11            12         13
    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT id,messageType,sender,receiver,subject,itemTextId,expire_time,deliver_time,money,cod,checked,stationery,mailTemplateId,has_items FROM mail WHERE receiver = '%u' ORDER BY id DESC",GetGUIDLow());
    if(!result)
        return;

    do
    {
        Field *fields = result->Fetch();
        Mail *m = new Mail;
        m->messageID = fields[0].GetUInt32();
        m->messageType = fields[1].GetUInt8();
        m->sender = fields[2].GetUInt32();
        m->receiverGuid = ObjectGuid(HIGHGUID_PLAYER, fields[3].GetUInt32());
        m->subject = fields[4].GetCppString();
        m->itemTextId = fields[5].GetUInt32();
        m->expire_time = (time_t)fields[6].GetUInt64();
        m->deliver_time = (time_t)fields[7].GetUInt64();
        m->money = fields[8].GetUInt32();
        m->COD = fields[9].GetUInt32();
        m->checked = fields[10].GetUInt32();
        m->stationery = fields[11].GetUInt8();
        m->mailTemplateId = fields[12].GetInt16();
        m->has_items = fields[13].GetBool();                // true, if mail have items or mail have template and items generated (maybe none)

        if (m->mailTemplateId && !sMailTemplateStore.LookupEntry(m->mailTemplateId))
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Player::_LoadMail - Mail (%u) have not existed MailTemplateId (%u), remove at load", m->messageID, m->mailTemplateId);
            m->mailTemplateId = 0;
        }

        m->state = MAIL_STATE_UNCHANGED;

        m_mail.push_back(m);

        if (m->mailTemplateId && !m->has_items)
            m->prepareTemplateItems(this);

    }
    while (result->NextRow());
}

void Player::LoadPet()
{
    //fixme: the pet should still be loaded if the player is not in world
    // just not added to the map
    if (IsInWorld())
    {
        Pet *pet = new Pet;
        if (!pet->LoadPetFromDB(this,0,0,true))
            delete pet;
    }
}

void Player::_LoadQuestStatus(QueryResultAutoPtr result)
{
    mQuestStatus.clear();

    uint32 slot = 0;

    ////                                                            0      1       2         3         4      5          6          7          8          9           10          11          12
    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT quest, status, rewarded, explored, timer, mobcount1, mobcount2, mobcount3, mobcount4, itemcount1, itemcount2, itemcount3, itemcount4 FROM character_queststatus WHERE guid = '%u'", GetGUIDLow());

    if (result)
    {
        do
        {
            Field *fields = result->Fetch();

            uint32 quest_id = fields[0].GetUInt32();
                                                            // used to be new, no delete?
            Quest const* pQuest = sObjectMgr.GetQuestTemplate(quest_id);
            if (pQuest)
            {
                // find or create
                QuestStatusData& questStatusData = mQuestStatus[quest_id];

                uint32 qstatus = fields[1].GetUInt32();
                if (qstatus < MAX_QUEST_STATUS)
                    questStatusData.m_status = QuestStatus(qstatus);
                else
                {
                    questStatusData.m_status = QUEST_STATUS_NONE;
                    sLog.outLog(LOG_DEFAULT, "ERROR: Player %s have invalid quest %d status (%d), replaced by QUEST_STATUS_NONE(0).",GetName(),quest_id,qstatus);
                }

                questStatusData.m_rewarded = (fields[2].GetUInt8() > 0);
                questStatusData.m_explored = (fields[3].GetUInt8() > 0);

                time_t quest_time = time_t(fields[4].GetUInt64());

                if (pQuest->HasFlag(QUEST_LOOKING4GROUP_FLAGS_TIMED) && !GetQuestRewardStatus(quest_id) &&  questStatusData.m_status != QUEST_STATUS_NONE)
                {
                    AddTimedQuest(quest_id);

                    if (quest_time <= sWorld.GetGameTime())
                        questStatusData.m_timer = 1;
                    else
                        questStatusData.m_timer = (quest_time - sWorld.GetGameTime()) * 1000;
                }
                else
                    quest_time = 0;

                questStatusData.m_creatureOrGOcount[0] = fields[5].GetUInt32();
                questStatusData.m_creatureOrGOcount[1] = fields[6].GetUInt32();
                questStatusData.m_creatureOrGOcount[2] = fields[7].GetUInt32();
                questStatusData.m_creatureOrGOcount[3] = fields[8].GetUInt32();
                questStatusData.m_itemcount[0] = fields[9].GetUInt32();
                questStatusData.m_itemcount[1] = fields[10].GetUInt32();
                questStatusData.m_itemcount[2] = fields[11].GetUInt32();
                questStatusData.m_itemcount[3] = fields[12].GetUInt32();

                questStatusData.uState = QUEST_UNCHANGED;

                // add to quest log
                if (slot < MAX_QUEST_LOG_SIZE &&
                    (questStatusData.m_status==QUEST_STATUS_INCOMPLETE ||
                    questStatusData.m_status==QUEST_STATUS_COMPLETE &&
                    (!questStatusData.m_rewarded || pQuest->IsDaily())))
                {
                    SetQuestSlot(slot,quest_id,quest_time);

                    if (questStatusData.m_status == QUEST_STATUS_COMPLETE)
                        SetQuestSlotState(slot,QUEST_STATE_COMPLETE);

                    for (uint8 idx = 0; idx < QUEST_OBJECTIVES_COUNT; ++idx)
                        if (questStatusData.m_creatureOrGOcount[idx])
                            SetQuestSlotCounter(slot,idx,questStatusData.m_creatureOrGOcount[idx]);

                    ++slot;
                }

                if (questStatusData.m_rewarded)
                {
                    // learn rewarded spell if unknown
                    learnQuestRewardedSpells(pQuest);

                    // set rewarded title if any
                    if (pQuest->GetCharTitleId())
                    {
                        if (CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(pQuest->GetCharTitleId()))
                            SetTitle(titleEntry);
                    }
                }

                sLog.outDebug("Quest status is {%u} for quest {%u} for player (GUID: %u)", questStatusData.m_status, quest_id, GetGUIDLow());
            }
        }
        while (result->NextRow());
    }

    // clear quest log tail
    for (uint16 i = slot; i < MAX_QUEST_LOG_SIZE; ++i)
        SetQuestSlot(i,0);
}

void Player::_LoadDailyQuestStatus(QueryResultAutoPtr result)
{
    for (uint32 quest_daily_idx = 0; quest_daily_idx < sWorld.getConfig(CONFIG_DAILY_MAX_PER_DAY); ++quest_daily_idx)
        SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1+quest_daily_idx,0);

    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT quest,time FROM character_queststatus_daily WHERE guid = '%u'", GetGUIDLow());

    if (result)
    {
        uint32 quest_daily_idx = 0;

        do
        {
            if (quest_daily_idx >= sWorld.getConfig(CONFIG_DAILY_MAX_PER_DAY))  // max amount with exist data in query
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Player (GUID: %u) have more 25 daily quest records in `charcter_queststatus_daily`",GetGUIDLow());
                break;
            }

            Field *fields = result->Fetch();

            uint32 quest_id = fields[0].GetUInt32();

            // save _any_ from daily quest times (it must be after last reset anyway)
            m_lastDailyQuestTime = (time_t)fields[1].GetUInt64();

            Quest const* pQuest = sObjectMgr.GetQuestTemplate(quest_id);
            if (!pQuest)
                continue;

            SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1+quest_daily_idx,quest_id);
            ++quest_daily_idx;

            sLog.outDebug("Daily quest {%u} cooldown for player (GUID: %u)", quest_id, GetGUIDLow());
        }
        while (result->NextRow());
    }

    m_DailyQuestChanged = false;
}

void Player::_LoadSpells(QueryResultAutoPtr result)
{
    m_spells.clear();

    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT spell,slot,active FROM character_spell WHERE guid = '%u'",GetGUIDLow());

    if (result)
    {
        do
        {
            Field *fields = result->Fetch();

            addSpell(fields[0].GetUInt16(), fields[2].GetBool(), false, true, fields[1].GetUInt16(), fields[3].GetBool());
        }
        while (result->NextRow());
    }
}

void Player::_LoadTutorials(QueryResultAutoPtr result)
{
    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT tut0,tut1,tut2,tut3,tut4,tut5,tut6,tut7 FROM character_tutorial WHERE account = '%u' AND realmid = '%u'", GetAccountId(), realmid);

    if (result)
    {
        do
        {
            Field *fields = result->Fetch();

            for (int iI=0; iI<8; iI++)
                m_Tutorials[iI] = fields[iI].GetUInt32();
        }
        while (result->NextRow());
    }

    m_TutorialsChanged = false;
}

void Player::_LoadGroup(QueryResultAutoPtr result)
{
    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT leaderGuid FROM group_member WHERE memberGuid='%u'", GetGUIDLow());
    if (result)
    {
        uint64 leaderGuid = MAKE_NEW_GUID((*result)[0].GetUInt32(), 0, HIGHGUID_PLAYER);
        Group* group = sObjectMgr.GetGroupByLeader(leaderGuid);
        if (group)
        {
            uint8 subgroup = group->GetMemberGroup(GetGUID());
            SetGroup(group, subgroup);
            if (getLevel() >= LEVELREQUIREMENT_HEROIC)
            {
                // the group leader may change the instance difficulty while the player is offline
                SetDifficulty(group->GetDifficulty());
            }
        }
    }
}

void Player::_LoadBoundInstances(QueryResultAutoPtr result)
{
    for (uint8 i = 0; i < TOTAL_DIFFICULTIES; i++)
        m_boundInstances[i].clear();

    Group *group = GetGroup();

    //QueryResultAutoPtr result = CharacterDatabase.PQuery("SELECT id, permanent, map, difficulty, resettime FROM character_instance LEFT JOIN instance ON instance = id WHERE guid = '%u'", GUID_LOPART(m_guid));
    if (result)
    {
        do
        {
            Field *fields = result->Fetch();
            bool perm = fields[1].GetBool();
            uint32 mapId = fields[2].GetUInt32();
            uint32 instanceId = fields[0].GetUInt32();
            uint8 difficulty = fields[3].GetUInt8();
            time_t resetTime = (time_t)fields[4].GetUInt64();
            // the resettime for normal instances is only saved when the InstanceSave is unloaded
            // so the value read from the DB may be wrong here but only if the InstanceSave is loaded
            // and in that case it is not used

            MapEntry const* mapEntry = sMapStore.LookupEntry(mapId);
            if (!mapEntry || !mapEntry->IsDungeon())
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: _LoadBoundInstances: player %s(%d) has bind to not existed or not dungeon map %d", GetName(), GetGUIDLow(), mapId);
                RealmDataDatabase.PExecute("DELETE FROM character_instance WHERE guid = '%d' AND instance = '%d'", GetGUIDLow(), instanceId);
                continue;
            }

            if (!perm && group)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: _LoadBoundInstances: player %s(%d) is in group %d but has a non-permanent character bind to map %d,%d,%d", GetName(), GetGUIDLow(), GUID_LOPART(group->GetLeaderGUID()), mapId, instanceId, difficulty);
                RealmDataDatabase.PExecute("DELETE FROM character_instance WHERE guid = '%d' AND instance = '%d'", GetGUIDLow(), instanceId);
                continue;
            }

            // since non permanent binds are always solo bind, they can always be reset
            InstanceSave *save = sInstanceSaveManager.AddInstanceSave(mapId, instanceId, difficulty, resetTime, !perm, true);
            if (save) BindToInstance(save, perm, true);
        } while (result->NextRow());
    }
}

InstancePlayerBind* Player::GetBoundInstance(uint32 mapid, uint8 difficulty)
{
    // some instances only have one difficulty
    const MapEntry* entry = sMapStore.LookupEntry(mapid);
    if (!entry || !entry->SupportsHeroicMode()) difficulty = DIFFICULTY_NORMAL;

    BoundInstancesMap::iterator itr = m_boundInstances[difficulty].find(mapid);
    if (itr != m_boundInstances[difficulty].end())
        return &itr->second;
    else
        return NULL;
}

InstanceSave * Player::GetInstanceSave(uint32 mapid)
{
    InstancePlayerBind *pBind = GetBoundInstance(mapid, GetDifficulty());
    InstanceSave *pSave = pBind ? pBind->save : NULL;
    if (!pBind || !pBind->perm)
    {
        if (Group *group = GetGroup())
            if (InstanceGroupBind *groupBind = group->GetBoundInstance(mapid, GetDifficulty()))
                pSave = groupBind->save;
    }
    return pSave;
}

void Player::UnbindInstance(uint32 mapid, uint8 difficulty, bool unload)
{
    BoundInstancesMap::iterator itr = m_boundInstances[difficulty].find(mapid);
    UnbindInstance(itr, difficulty, unload);
}

void Player::UnbindInstance(BoundInstancesMap::iterator &itr, uint8 difficulty, bool unload)
{
    if (itr != m_boundInstances[difficulty].end())
    {
        if (!unload)
            RealmDataDatabase.PExecute("DELETE FROM character_instance WHERE guid = '%u' AND instance = '%u'", GetGUIDLow(), itr->second.save->GetInstanceId());
        
        InstanceSave* save = itr->second.save;
        if (save != nullptr)
            save->RemovePlayer(GetGUID());

        m_boundInstances[difficulty].erase(itr++);
    }
}

InstancePlayerBind* Player::BindToInstance(InstanceSave *save, bool permanent, bool load)
{
    if (save != nullptr)
    {
        InstancePlayerBind& bind = m_boundInstances[save->GetDifficulty()][save->GetMapId()];
        if (bind.save)
        {
            // update the save when the group kills a boss
            if (permanent != bind.perm || save != bind.save)
                if (!load) RealmDataDatabase.PExecute("UPDATE character_instance SET instance = '%u', permanent = '%u' WHERE guid = '%u' AND instance = '%u'", save->GetInstanceId(), permanent, GetGUIDLow(), bind.save->GetInstanceId());
        }
        else
            if (!load) RealmDataDatabase.PExecute("INSERT INTO character_instance (guid, instance, permanent) VALUES ('%u', '%u', '%u')", GetGUIDLow(), save->GetInstanceId(), permanent);

        if (bind.save != save)
        {
            if (bind.save != nullptr)
                bind.save->RemovePlayer(GetGUID());

            save->AddPlayer(GetGUID());
        }

        if (permanent) save->SetCanReset(false);

        bind.save = save;
        bind.perm = permanent;
        if (!load) sLog.outDebug("Player::BindToInstance: %s(%d) is now bound to map %d, instance %d, difficulty %d", GetName(), GetGUIDLow(), save->GetMapId(), save->GetInstanceId(), save->GetDifficulty());
        return &bind;
    }
    else
        return nullptr;
}

void Player::SendRaidInfo()
{
    WorldPacket data(SMSG_RAID_INSTANCE_INFO, 4);

    uint32 counter = 0, i;
    for (i = 0; i < TOTAL_DIFFICULTIES; i++)
        for (BoundInstancesMap::iterator itr = m_boundInstances[i].begin(); itr != m_boundInstances[i].end(); ++itr)
            if (itr->second.perm) counter++;

    data << counter;
    for (i = 0; i < TOTAL_DIFFICULTIES; i++)
    {
        for (BoundInstancesMap::iterator itr = m_boundInstances[i].begin(); itr != m_boundInstances[i].end(); ++itr)
        {
            if (itr->second.perm)
            {
                InstanceSave *save = itr->second.save;
                data << (save->GetMapId());
                data << (uint32)(save->GetResetTime() - time(NULL));
                data << save->GetInstanceId();
                data << uint32(counter);
                counter--;
            }
        }
    }
    SendPacketToSelf(&data);
}

/*
- called on every successful teleportation to a map
*/
void Player::SendSavedInstances()
{
    bool hasBeenSaved = false;
    WorldPacket data;

    for (uint8 i = 0; i < TOTAL_DIFFICULTIES; i++)
    {
        for (BoundInstancesMap::iterator itr = m_boundInstances[i].begin(); itr != m_boundInstances[i].end(); ++itr)
        {
            if (itr->second.perm)                                // only permanent binds are sent
            {
                hasBeenSaved = true;
                break;
            }
        }
    }

    //Send opcode 811. true or false means, whether you have current raid/heroic instances
    data.Initialize(SMSG_UPDATE_INSTANCE_OWNERSHIP);
    data << uint32(hasBeenSaved);
    SendPacketToSelf(&data);

    if (!hasBeenSaved)
        return;

    for (uint8 i = 0; i < TOTAL_DIFFICULTIES; i++)
    {
        for (BoundInstancesMap::iterator itr = m_boundInstances[i].begin(); itr != m_boundInstances[i].end(); ++itr)
        {
            if (itr->second.perm)
            {
                data.Initialize(SMSG_UPDATE_LAST_INSTANCE);
                data << uint32(itr->second.save->GetMapId());
                SendPacketToSelf(&data);
            }
        }
    }
}

/// convert the player's binds to the group
void Player::ConvertInstancesToGroup(Player *player, Group *group, uint64 player_guid)
{
    bool has_binds = false;
    bool has_solo = false;

    if (player) { player_guid = player->GetGUID(); if (!group) group = player->GetGroup(); }
    ASSERT(player_guid);

    // copy all binds to the group, when changing leader it's assumed the character
    // will not have any solo binds

    if (player)
    {
        for (uint8 i = 0; i < TOTAL_DIFFICULTIES; i++)
        {
            for (BoundInstancesMap::iterator itr = player->m_boundInstances[i].begin(); itr != player->m_boundInstances[i].end();)
            {
                has_binds = true;
                if (group) group->BindToInstance(itr->second.save, itr->second.perm, true);
                // permanent binds are not removed
                if (!itr->second.perm)
                {
                    player->UnbindInstance(itr, i, true);   // increments itr
                    has_solo = true;
                }
                else
                    ++itr;
            }
        }
    }

    // if the player's not online we don't know what binds it has
    if (!player || !group || has_binds) RealmDataDatabase.PExecute("REPLACE INTO group_instance SELECT guid, instance, permanent FROM character_instance WHERE guid = '%u'", GUID_LOPART(player_guid));
    // the following should not get executed when changing leaders
    if (!player || has_solo) RealmDataDatabase.PExecute("DELETE FROM character_instance WHERE guid = '%d' AND permanent = 0", GUID_LOPART(player_guid));
}

bool Player::Satisfy(AccessRequirement const *ar, uint32 target_map, bool report)
{
    if (!isGameMaster() && ar)
    {
        uint32 LevelMin = 0;
        if (getLevel() < ar->levelMin && !sWorld.getConfig(CONFIG_INSTANCE_IGNORE_LEVEL))
            LevelMin = ar->levelMin;

        uint32 LevelMax = 0;
        if (ar->levelMax >= ar->levelMin && getLevel() > ar->levelMax && !sWorld.getConfig(CONFIG_INSTANCE_IGNORE_LEVEL))
            LevelMax = ar->levelMax;

        uint32 missingItem = 0;
        if (ar->item)
        {
            if (!HasItemCount(ar->item, 1) &&
                (!ar->item2 || !HasItemCount(ar->item2, 1)))
                missingItem = ar->item;
        }
        else if (ar->item2 && !HasItemCount(ar->item2, 1))
            missingItem = ar->item2;

        uint32 missingKey = 0;
        uint32 missingHeroicQuest = 0;
        if (GetDifficulty() == DIFFICULTY_HEROIC)
        {
            if (ar->heroicKey)
            {
                if (!HasItemCount(ar->heroicKey, 1) &&
                    (!ar->heroicKey2 || !HasItemCount(ar->heroicKey2, 1)))
                    missingKey = ar->heroicKey;
            }
            else if (ar->heroicKey2 && !HasItemCount(ar->heroicKey2, 1))
                missingKey = ar->heroicKey2;

            if (ar->heroicQuest && !GetQuestRewardStatus(ar->heroicQuest))
                missingHeroicQuest = ar->heroicQuest;
        }

        uint32 missingQuest = 0;
        if (ar->quest && !GetQuestRewardStatus(ar->quest))
            missingQuest = ar->quest;

        uint32 missingAura = 0;
        if (ar->auraId && !HasAura(ar->auraId))
            missingAura = ar->auraId;

        if (LevelMin || LevelMax || missingItem || missingKey || missingQuest || missingHeroicQuest || missingAura)
        {
            if (report)
            {
                if (missingItem)
                    GetSession()->SendAreaTriggerMessage(GetSession()->GetTrinityString(LANG_LEVEL_MINREQUIRED_AND_ITEM), ar->levelMin, ObjectMgr::GetItemPrototype(missingItem)->Name1);
                else if (missingKey)
                    SendTransferAborted(target_map, TRANSFER_ABORT_DIFFICULTY2);
                else if (missingHeroicQuest)
                    GetSession()->SendAreaTriggerMessage(ar->heroicQuestFailedText.c_str());
                else if (missingQuest)
                    GetSession()->SendAreaTriggerMessage(ar->questFailedText.c_str());
                else if (LevelMin)
                    GetSession()->SendAreaTriggerMessage(GetSession()->GetTrinityString(LANG_LEVEL_MINREQUIRED), LevelMin);
                else if (missingAura)
                    GetSession()->SendAreaTriggerMessage(ar->missingAuraText.c_str());
            }
            return false;
        }
    }
    return true;
}

bool Player::_LoadHomeBind(QueryResultAutoPtr result)
{
    PlayerInfo const *info = sObjectMgr.GetPlayerInfo(getRace(), getClass());
    if (!info)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player have incorrect race/class pair. Can't be loaded.");
        return false;
    }

    bool ok = false;
    if (result)
    {
        Field *fields = result->Fetch();
        m_homebindMapId = fields[0].GetUInt32();
        m_homebindZoneId = fields[1].GetUInt16();
        m_homebindX = fields[2].GetFloat();
        m_homebindY = fields[3].GetFloat();
        m_homebindZ = fields[4].GetFloat();

        MapEntry const* bindMapEntry = sMapStore.LookupEntry(m_homebindMapId);

        // accept saved data only for valid position (and non instanceable), and accessable
        if (MapManager::IsValidMapCoord(m_homebindMapId,m_homebindX,m_homebindY,m_homebindZ) &&
            !bindMapEntry->Instanceable() && GetSession()->Expansion() >= bindMapEntry->Expansion())
        {
            ok = true;
        }
        else
            RealmDataDatabase.PExecute("DELETE FROM character_homebind WHERE guid = '%u'", GetGUIDLow());
    }

    if (!ok)
    {
        m_homebindMapId = info->mapId;
        m_homebindZoneId = info->zoneId;
        m_homebindX = info->positionX;
        m_homebindY = info->positionY;
        m_homebindZ = info->positionZ;

        RealmDataDatabase.PExecute("INSERT INTO character_homebind (guid,map,zone,position_x,position_y,position_z) VALUES ('%u', '%u', '%u', '%f', '%f', '%f')", GetGUIDLow(), m_homebindMapId, (uint32)m_homebindZoneId, m_homebindX, m_homebindY, m_homebindZ);
    }

    DEBUG_LOG("Setting player home position: mapid is: %u, zoneid is %u, X is %f, Y is %f, Z is %f\n",
        m_homebindMapId, m_homebindZoneId, m_homebindX, m_homebindY, m_homebindZ);

    return true;
}

/*********************************************************/
/***                   SAVE SYSTEM                     ***/
/*********************************************************/

void Player::SaveToDB()
{
    if (_preventSave)
        return;

    _preventSave = true;

    // delay auto save at any saves (manual, in code, or autosave)
    m_nextSave = sWorld.getConfig(CONFIG_INTERVAL_SAVE);

    // first save/honor gain after midnight will also update the player's honor fields
    UpdateHonorFields();

    uint32 mapid = IsBeingTeleported() ? GetTeleportDest().mapid : GetMapId();
    const MapEntry * me = sMapStore.LookupEntry(mapid);
    // players aren't saved on arena maps
    if (!me || me->IsBattleArena())
    {
        _preventSave = false;
        return;
    }

    int is_save_resting = HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_RESTING) ? 1 : 0;
                                                            //save, far from tavern/city
                                                            //save, but in tavern/city
    sLog.outDebug("The value of player %s at save: ", m_name.c_str());
    outDebugValues();

    // save state (after auras removing), if aura remove some flags then it must set it back by self)
    uint32 tmp_bytes = GetUInt32Value(UNIT_FIELD_BYTES_1);
    uint32 tmp_bytes2 = GetUInt32Value(UNIT_FIELD_BYTES_2);
    uint32 tmp_flags = GetUInt32Value(UNIT_FIELD_FLAGS);
    uint32 tmp_pflags = GetUInt32Value(PLAYER_FLAGS);
    uint32 tmp_displayid = GetDisplayId();

    // Set player sit state to standing on save, also stealth and shifted form
    SetByteValue(UNIT_FIELD_BYTES_1, 0, 0);                 // stand state
    SetByteValue(UNIT_FIELD_BYTES_2, 3, 0);                 // shapeshift
    SetByteValue(UNIT_FIELD_BYTES_1, 3, 0);                 // stand flags?
    RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_ROTATE);
    
    PlayerInfo const* info = sObjectMgr.GetPlayerInfo(getRace(), getClass());
    if (!info)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player have incorrect race/class pair. Can't be loaded.");
    }
                
    switch (getGender())
    {
    case GENDER_FEMALE:
        SetDisplayId(info->displayId_f);
        SetNativeDisplayId(info->displayId_f);
        break;
    case GENDER_MALE:
        SetDisplayId(info->displayId_m);
        SetNativeDisplayId(info->displayId_m);
        break;
    default:
        SetDisplayId(GetNativeDisplayId());
        sLog.outLog(LOG_DEFAULT, "ERROR: Invalid gender %u for player",getGender());
        break;
    }

    bool inworld = IsInWorld();

    RealmDataDatabase.BeginTransaction();

    //CharacterDatabase.PExecute("DELETE FROM characters WHERE guid = '%u'",GetGUIDLow());
    static SqlStatementID deleteStats;
    SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteStats, "DELETE FROM character_stats_ro WHERE guid = ?");
    stmt.PExecute(GetGUIDLow());

    static SqlStatementID updateStats;
    stmt = RealmDataDatabase.CreateStatement(updateStats, "INSERT INTO character_stats_ro VALUES (?, ?, ?)");
    stmt.PExecute(GetGUIDLow(), GetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY), GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS));

    static SqlStatementID deleteCharacter;
    static SqlStatementID insertCharacter;

    stmt = RealmDataDatabase.CreateStatement(deleteCharacter, "DELETE FROM characters WHERE guid = ?");
    stmt.PExecute(GetGUIDLow());

    stmt = RealmDataDatabase.CreateStatement(insertCharacter, "INSERT INTO characters (guid, account, name, race, class, gender, level, xp, money, playerBytes, playerBytes2, playerFlags, "
                                            "map, instance_id, dungeon_difficulty, position_x, position_y, position_z, orientation, data, "
                                            "taximask, online, cinematic, "
                                            "totaltime, leveltime, rest_bonus, logout_time, is_logout_resting, resettalents_cost, resettalents_time, "
                                            "trans_x, trans_y, trans_z, trans_o, transguid, extra_flags, stable_slots, at_login, zone, "
                                            "death_expire_time, taxi_path, arena_pending_points, latency, title) "
                                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
                                                "?, ?, ?, ?, ?, ?, ?, ?, "
                                                "?, ?, ?, "
                                                "?, ?, ?, ?, ?, ?, ?, "
                                                "?, ?, ?, ?, ?, ?, ?, ?, ?, "
                                                "?, ?, ?, ?, ?)");

    stmt.addUInt32(GetGUIDLow());
    stmt.addUInt32(GetSession()->GetAccountId());
    stmt.addString(m_name);
    stmt.addUInt32(uint32(getRace()));
    stmt.addUInt32(uint32(getClass()));
    stmt.addUInt32(uint32(getGender()));
    stmt.addUInt32(uint32(getLevel()));
    stmt.addUInt32(GetUInt32Value(PLAYER_XP));
    stmt.addUInt32(GetMoney());
    stmt.addUInt32(GetUInt32Value(PLAYER_BYTES));
    stmt.addUInt32(GetUInt32Value(PLAYER_BYTES_2));
    stmt.addUInt32(GetUInt32Value(PLAYER_FLAGS));

    bool save_to_dest = false;
    if (IsBeingTeleported())
    {
        // don't save to battlegrounds or arenas
        //const MapEntry *entry = sMapStore.LookupEntry(GetTeleportDest().mapid);
        //if(entry && entry->map_type != MAP_BATTLEGROUND && entry->map_type != MAP_ARENA)
            save_to_dest = true;
    }

    if (!save_to_dest)
    {
        stmt.addUInt32(GetMapId());
        stmt.addUInt32(GetInstanceId());
        stmt.addUInt32(uint32(GetDifficulty()));
        stmt.addFloat(finiteAlways(GetPositionX()));
        stmt.addFloat(finiteAlways(GetPositionY()));
        stmt.addFloat(finiteAlways(GetPositionZ()));
        stmt.addFloat(finiteAlways(GetOrientation()));
    }
    else
    {
        stmt.addUInt32(GetTeleportDest().mapid);
        stmt.addUInt32(0);
        stmt.addUInt32(uint32(GetDifficulty()));
        stmt.addFloat(finiteAlways(GetTeleportDest().coord_x));
        stmt.addFloat(finiteAlways(GetTeleportDest().coord_y));
        stmt.addFloat(finiteAlways(GetTeleportDest().coord_z));
        stmt.addFloat(finiteAlways(GetTeleportDest().orientation));", '";
    }

    std::string tmpStr = GetUInt32ValuesString();

    stmt.addString(tmpStr);

    tmpStr = m_taxi.GetTaxiMaskString();
    stmt.addString(tmpStr);
    stmt.addBool(inworld ? true : false);
    stmt.addBool(m_cinematic);
    stmt.addUInt32(m_Played_time[0]);
    stmt.addUInt32(m_Played_time[1]);
    stmt.addFloat(finiteAlways(m_rest_bonus));
    stmt.addUInt64(uint64(time(NULL)));
    stmt.addBool(is_save_resting);
    stmt.addUInt32(m_resetTalentsCost);
    stmt.addUInt64(uint64(m_resetTalentsTime));
    stmt.addFloat(finiteAlways(m_movementInfo.GetTransportPos()->x));
    stmt.addFloat(finiteAlways(m_movementInfo.GetTransportPos()->y));
    stmt.addFloat(finiteAlways(m_movementInfo.GetTransportPos()->z));
    stmt.addFloat(finiteAlways(m_movementInfo.GetTransportPos()->o));

    if (m_transport)
        stmt.addUInt32(m_transport->GetGUIDLow());
    else
        stmt.addUInt32(0);

    stmt.addUInt32(m_ExtraFlags);
    stmt.addUInt8(m_stableSlots);                  // to prevent save uint8 as char
    stmt.addUInt32(m_atLoginFlags);
    stmt.addUInt32(GetCachedZone());
    stmt.addUInt64(uint64(m_deathExpireTime));
    stmt.addString(m_taxi.SaveTaxiDestinationsToString());
    stmt.addUInt32(0);
    stmt.addUInt32(GetSession()->GetLatency());
    stmt.addUInt64(GetUInt64Value(PLAYER__FIELD_KNOWN_TITLES));
    stmt.Execute();

    if (m_mailsUpdated)                                      //save mails only when needed
        _SaveMail();

    _SaveBattleGroundCoord();
    _SaveInventory();
    _SaveQuestStatus();
    _SaveDailyQuestStatus();
    _SaveMonthlyQuestStatus();
    _SaveTutorials();
    _SaveSpells();
    _SaveSpellCooldowns();
    _SaveActions();
    _SaveAuras();
    _SaveInstanceTimeRestrictions();
    m_reputationMgr.SaveToDB(false);

    RealmDataDatabase.CommitTransaction();

    // restore state (before aura apply, if aura remove flag then aura must set it ack by self)
    SetDisplayId(tmp_displayid);
    SetUInt32Value(UNIT_FIELD_BYTES_1, tmp_bytes);
    SetUInt32Value(UNIT_FIELD_BYTES_2, tmp_bytes2);
    SetUInt32Value(UNIT_FIELD_FLAGS, tmp_flags);
    SetUInt32Value(PLAYER_FLAGS, tmp_pflags);

    // save pet (hunter pet level and experience and all type pets health/mana).
    if (Pet* pet = GetPet())
        pet->SavePetToDB(PET_SAVE_AS_CURRENT);

    _preventSave = false;
}

// fast save function for item/money cheating preventing - save only inventory and money state
void Player::SaveInventoryAndGoldToDB()
{
    _SaveInventory();
    SaveGoldToDB();
}

void Player::SaveGoldToDB()
{
    static SqlStatementID updateMoney;
    SqlStatement stmt = RealmDataDatabase.CreateStatement(updateMoney, "UPDATE characters SET money = ? WHERE guid = ?");
    stmt.PExecute(GetMoney(), GetGUIDLow());
}

void Player::_SaveActions()
{
    static SqlStatementID insertCharacterAction;
    static SqlStatementID updateCharacterAction;
    static SqlStatementID deleteCharacterAction;

    for (ActionButtonList::iterator itr = m_actionButtons.begin(); itr != m_actionButtons.end();)
    {
        switch (itr->second.uState)
        {
            case ACTIONBUTTON_NEW:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(insertCharacterAction, "INSERT INTO character_action (guid, button, action, type, misc) VALUES (?, ?, ?, ?, ?)");
                stmt.addUInt32(GetGUIDLow());
                stmt.addUInt32(uint32(itr->first));
                stmt.addUInt32(uint32(itr->second.action));
                stmt.addUInt32(uint32(itr->second.type));
                stmt.addUInt32(uint32(itr->second.misc));
                stmt.Execute();

                itr->second.uState = ACTIONBUTTON_UNCHANGED;
                ++itr;
                break;
            }
            case ACTIONBUTTON_CHANGED:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(updateCharacterAction, "UPDATE character_action  SET action = ?, type = ?, misc = ? WHERE guid = ? AND button = ?");
                stmt.addUInt32(uint32(itr->second.action));
                stmt.addUInt32(uint32(itr->second.type));
                stmt.addUInt32(uint32(itr->second.misc));
                stmt.addUInt32(GetGUIDLow());
                stmt.addUInt32(uint32(itr->first));
                stmt.Execute();

                itr->second.uState = ACTIONBUTTON_UNCHANGED;
                ++itr;
                break;
            }
            case ACTIONBUTTON_DELETED:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteCharacterAction, "DELETE FROM character_action WHERE guid = ? and button = ?");
                stmt.PExecute(GetGUIDLow(), uint32(itr->first));

                m_actionButtons.erase(itr++);
                break;
            }
            default:
                ++itr;
                break;
        };
    }
}

void Player::_SaveAuras()
{
    static SqlStatementID deleteAuras;
    static SqlStatementID insertAura;

    SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteAuras, "DELETE FROM character_aura WHERE guid = ?");
    stmt.PExecute(GetGUIDLow());

    AuraMap const& auras = GetAuras();

    if (auras.empty())
        return;

    spellEffectPair lastEffectPair = auras.begin()->first;
    uint32 stackCounter = 1;

    for (AuraMap::const_iterator itr = auras.begin(); ; ++itr)
    {
        if (itr == auras.end() || lastEffectPair != itr->first)
        {
            AuraMap::const_iterator itr2 = itr;
            // save previous spellEffectPair to db
            itr2--;
            SpellEntry const *spellInfo = itr2->second->GetSpellProto();

            //skip all auras from spells that are passive or need a shapeshift
            if (!(itr2->second->IsPassive() || itr2->second->IsRemovedOnShapeLost()))
            {
                //do not save single target auras (unless they were cast by the player)
                if (!(itr2->second->GetCasterGUID() != GetGUID() && itr2->second->IsSingleTarget()))
                {
                    uint8 i;
                    // or apply at cast SPELL_AURA_MOD_SHAPESHIFT or SPELL_AURA_MOD_STEALTH auras
                    for (i = 0; i < 3; i++)
                        if (spellInfo->EffectApplyAuraName[i] == SPELL_AURA_MOD_SHAPESHIFT ||
                        spellInfo->EffectApplyAuraName[i] == SPELL_AURA_MOD_STEALTH)
                            break;

                    if (i == 3)
                    {
                        stmt = RealmDataDatabase.CreateStatement(insertAura, "INSERT INTO character_aura (guid, caster_guid, spell, effect_index, stackcount, amount, maxduration, remaintime, remaincharges) "
                                                                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                        stmt.addUInt32(GetGUIDLow());
                        stmt.addUInt64(itr2->second->GetCasterGUID());
                        stmt.addUInt32(uint32(itr2->second->GetId()));
                        stmt.addUInt32(uint32(itr2->second->GetEffIndex()));
                        stmt.addUInt32(uint32(itr2->second->GetStackAmount()));
                        stmt.addInt32(itr2->second->GetModifier()->m_amount);
                        stmt.addInt32(itr2->second->GetAuraMaxDuration());
                        stmt.addInt32(itr2->second->GetAuraDuration());
                        stmt.addInt32(itr2->second->m_procCharges);
                        stmt.Execute();
                    }
                }
            }

            if (itr == auras.end())
                break;
        }

        //TODO: if need delete this
        if (lastEffectPair == itr->first)
            stackCounter++;
        else
        {
            lastEffectPair = itr->first;
            stackCounter = 1;
        }
    }
}

void Player::_SaveBattleGroundCoord()
{
    static SqlStatementID deleteBGCoord;
    static SqlStatementID insertBGCoord;

    SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteBGCoord, "DELETE FROM character_bgcoord WHERE guid = ?");
    stmt.PExecute(GetGUIDLow());

    // don't save if not needed
    if (!InBattleGround())
        return;

    stmt = RealmDataDatabase.CreateStatement(insertBGCoord, "INSERT INTO character_bgcoord (guid, bgid, bgteam, bgmap, bgx, bgy, bgz, bgo) "
                                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    stmt.addUInt32(GetGUIDLow());
    stmt.addUInt32(GetBattleGroundId());
    stmt.addUInt32(GetBGTeam());
    stmt.addUInt32(GetBattleGroundEntryPointMap());
    stmt.addFloat(finiteAlways(GetBattleGroundEntryPointX()));
    stmt.addFloat(finiteAlways(GetBattleGroundEntryPointY()));
    stmt.addFloat(finiteAlways(GetBattleGroundEntryPointZ()));
    stmt.addFloat(finiteAlways(GetBattleGroundEntryPointO()));
    stmt.Execute();
}

void Player::_SaveInventory()
{
    static SqlStatementID deleteCharInvByItem;
    static SqlStatementID deleteItemInstance;
    static SqlStatementID deleteCharInvByPlace;
    static SqlStatementID insertBan;
    static SqlStatementID insertCharInv;
    static SqlStatementID updateCharInv;

    // force items in buyback slots to new state
    // and remove those that aren't already
    for (uint8 i = BUYBACK_SLOT_START; i < BUYBACK_SLOT_END; i++)
    {
        Item *item = m_items[i];
        if (!item || item->GetState() == ITEM_NEW)
            continue;

        SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteCharInvByItem, "DELETE FROM character_inventory WHERE item = ?");
        stmt.PExecute(item->GetGUIDLow());

        stmt = RealmDataDatabase.CreateStatement(deleteItemInstance, "DELETE FROM item_instance WHERE guid = ?");
        stmt.PExecute(item->GetGUIDLow());

        m_items[i]->FSetState(ITEM_NEW);
    }

    // update enchantment durations
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end(); ++itr)
        itr->item->SetEnchantmentDuration(itr->slot, itr->leftduration);

    // if no changes
    if (m_itemUpdateQueue.empty())
        return;

    // do not save if the update queue is corrupt
    uint32 lowGuid = GetGUIDLow();
    for (size_t i = 0; i < m_itemUpdateQueue.size(); ++i)
    {
        Item *item = m_itemUpdateQueue[i];
        if (!item)
            continue;

        Bag *container = item->GetContainer();
        uint32 bag_guid = container ? container->GetGUIDLow() : 0;

        if (item->GetState() != ITEM_REMOVED)
        {
            Item *test = GetItemByPos(item->GetBagSlot(), item->GetSlot());
            if (test == NULL)
            {
                uint32 bagTestGUID = 0;

                if (Item* test2 = GetItemByPos(INVENTORY_SLOT_BAG_0, item->GetBagSlot()))
                    bagTestGUID = test2->GetGUIDLow();

                sLog.outLog(LOG_DEFAULT, "ERROR: Player(GUID: %u Name: %s)::_SaveInventory - the bag(%u) and slot(%u) values for the item with guid %u (state %d) are incorrect, the player doesn't have an item at that position!", lowGuid, GetName(), item->GetBagSlot(), item->GetSlot(), item->GetGUIDLow(), (int32)item->GetState());

                // according to the test that was just performed nothing should be in this slot, delete
                SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteCharInvByPlace, "DELETE FROM character_inventory WHERE bag = ? AND slot = ?");
                stmt.PExecute(bagTestGUID, item->GetSlot());

                // also THIS item should be somewhere else, cheat attempt
                item->FSetState(ITEM_REMOVED); // we are IN updateQueue right now, can't use SetState which modifies the queue
                item->RemoveFromWorld();

                // don't skip, let the switch delete it
                //continue;

                AccountsDatabase.BeginTransaction();
                if (!GetSession()->IsAccountFlagged(ACC_SPECIAL_LOG))
                    GetSession()->AddAccountFlag(ACC_SPECIAL_LOG);

                stmt = AccountsDatabase.CreateStatement(insertBan, "INSERT INTO account_punishment VALUES (?, ?, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '[CONSOLE]', 'With love: cheater -.-')");
                stmt.PExecute(GetSession()->GetAccountId(), uint32(PUNISHMENT_BAN));

                AccountsDatabase.CommitTransaction();
                //GetSession()->KickPlayer();
            }
            else if (test != item)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Player(GUID: %u Name: %s)::_SaveInventory - the bag(%u) and slot(%u) values for the item with guid %u are incorrect, the item with guid %u is there instead!", lowGuid, GetName(), item->GetBagSlot(), item->GetSlot(), item->GetGUIDLow(), test->GetGUIDLow());
                // save all changes to the item...
                if (item->GetState() != ITEM_NEW) // only for existing items, no dupes
                    item->SaveToDB();
                // ...but do not save position in invntory

                AccountsDatabase.BeginTransaction();

                SqlStatement stmt = AccountsDatabase.CreateStatement(insertBan, "INSERT INTO account_punishment VALUES (?, ?, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '[CONSOLE]', 'With love: cheater -.-')");
                stmt.PExecute(GetSession()->GetAccountId(), uint32(PUNISHMENT_BAN));

                if (!GetSession()->IsAccountFlagged(ACC_SPECIAL_LOG))
                    GetSession()->AddAccountFlag(ACC_SPECIAL_LOG);

                AccountsDatabase.CommitTransaction();
                GetSession()->KickPlayer();

                continue;
            }
        }

        switch (item->GetState())
        {
            case ITEM_NEW:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(insertCharInv, "INSERT INTO character_inventory (guid, bag, slot, item, item_template) VALUES (?, ?, ?, ?, ?)");
                stmt.addUInt32(lowGuid);
                stmt.addUInt32(bag_guid);
                stmt.addUInt32(item->GetSlot());
                stmt.addUInt32(item->GetGUIDLow());
                stmt.addUInt32(item->GetEntry());
                stmt.Execute();
                break;
            }
            case ITEM_CHANGED:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(updateCharInv, "UPDATE character_inventory SET guid = ?, bag = ?, slot = ?, item_template = ? WHERE item = ?");
                stmt.addUInt32(lowGuid);
                stmt.addUInt32(bag_guid);
                stmt.addUInt32(item->GetSlot());
                stmt.addUInt32(item->GetEntry());
                stmt.addUInt32(item->GetGUIDLow());
                stmt.Execute();
                break;
            }
            case ITEM_REMOVED:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteCharInvByItem, "DELETE FROM character_inventory WHERE item = ?");
                stmt.PExecute(item->GetGUIDLow());
                break;
            }
            case ITEM_UNCHANGED:
                break;
        }

        item->SaveToDB();                                   // item have unchanged inventory record and can be save standalone
    }
    m_itemUpdateQueue.clear();
}

void Player::_SaveMail()
{
    static SqlStatementID updateMail;
    static SqlStatementID deleteMailItemsByGuid;
    static SqlStatementID deleteMailItemsById;
    static SqlStatementID deleteMail;
    static SqlStatementID deleteItemText;
    static SqlStatementID deleteItemInstance;

    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
    {
        Mail *m = (*itr);
        if (m->state == MAIL_STATE_CHANGED)
        {
            SqlStatement stmt = RealmDataDatabase.CreateStatement(updateMail, "UPDATE mail SET itemTextId = ?, has_items = ?, expire_time = ?, deliver_time = ?, money = ?, cod = ?, checked = ? WHERE id = ?");
            stmt.addUInt32(m->itemTextId);
            stmt.addBool(m->HasItems() ? true : false);
            stmt.addUInt64(uint64(m->expire_time));
            stmt.addUInt64(uint64(m->deliver_time));
            stmt.addUInt32(m->money);
            stmt.addUInt32(m->COD);
            stmt.addBool(m->checked);
            stmt.addUInt32(m->messageID);
            stmt.Execute();

            if (m->removedItems.size())
            {
                for (std::vector<uint32>::iterator itr2 = m->removedItems.begin(); itr2 != m->removedItems.end(); ++itr2)
                {
                    stmt = RealmDataDatabase.CreateStatement(deleteMailItemsByGuid, "DELETE FROM mail_items WHERE item_guid = ?");
                    stmt.PExecute(*itr2);
                }
                m->removedItems.clear();
            }
            m->state = MAIL_STATE_UNCHANGED;
        }
        else if (m->state == MAIL_STATE_DELETED)
        {
            SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteMail, "DELETE FROM mail WHERE id = ?");
            stmt.PExecute(m->messageID);

            stmt = RealmDataDatabase.CreateStatement(deleteMailItemsById, "DELETE FROM mail_items WHERE mail_id = ?");
            stmt.PExecute(m->messageID);

            if (m->HasItems())
            {
                for (std::vector<MailItemInfo>::iterator itr2 = m->items.begin(); itr2 != m->items.end(); ++itr2)
                {
                    stmt = RealmDataDatabase.CreateStatement(deleteItemInstance, "DELETE FROM item_instance WHERE guid = ?");
                    stmt.PExecute(itr2->item_guid);
                }
            }

            if (m->itemTextId)
            {
                stmt = RealmDataDatabase.CreateStatement(deleteItemText, "DELETE FROM item_text WHERE id = ?");
                stmt.PExecute(m->itemTextId);
            }
        }
    }

    //deallocate deleted mails...
    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end();)
    {
        if ((*itr)->state == MAIL_STATE_DELETED)
        {
            Mail* m = *itr;
            m_mail.erase(itr);
            delete m;
            itr = m_mail.begin();
        }
        else
            ++itr;
    }

    m_mailsUpdated = false;
}

void Player::_SaveQuestStatus()
{
    static SqlStatementID insertQuestStatus;
    static SqlStatementID updateQuestStatus;

    for (QuestStatusMap::iterator i = mQuestStatus.begin(); i != mQuestStatus.end(); ++i)
    {
        switch (i->second.uState)
        {
            case QUEST_NEW:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(insertQuestStatus, "INSERT INTO character_queststatus (guid, quest, status, rewarded, explored, timer, mobcount1, mobcount2, mobcount3, mobcount4, itemcount1, itemcount2, itemcount3, itemcount4) "
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                stmt.addUInt32(GetGUIDLow());
                stmt.addUInt32(i->first);
                stmt.addUInt8(i->second.m_status);
                stmt.addBool(i->second.m_rewarded);
                stmt.addBool(i->second.m_explored);
                stmt.addUInt64(uint64(i->second.m_timer / 1000 + sWorld.GetGameTime()));
                stmt.addUInt32(i->second.m_creatureOrGOcount[0]);
                stmt.addUInt32(i->second.m_creatureOrGOcount[1]);
                stmt.addUInt32(i->second.m_creatureOrGOcount[2]);
                stmt.addUInt32(i->second.m_creatureOrGOcount[3]);
                stmt.addUInt32(i->second.m_itemcount[0]);
                stmt.addUInt32(i->second.m_itemcount[1]);
                stmt.addUInt32(i->second.m_itemcount[2]);
                stmt.addUInt32(i->second.m_itemcount[3]);
                stmt.Execute();

                break;
            }
            case QUEST_CHANGED:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(updateQuestStatus, "UPDATE character_queststatus SET status = ?, rewarded = ?, explored = ?, timer = ?, mobcount1 = ?, mobcount2 = ?, mobcount3 = ?, mobcount4 = ?, itemcount1 = ?, itemcount2 = ?, itemcount3 = ?, itemcount4 = ? WHERE guid = ? AND quest = ?");
                stmt.addUInt8(i->second.m_status);
                stmt.addBool(i->second.m_rewarded);
                stmt.addBool(i->second.m_explored);
                stmt.addUInt64(uint64(i->second.m_timer / 1000 + sWorld.GetGameTime()));
                stmt.addUInt32(i->second.m_creatureOrGOcount[0]);
                stmt.addUInt32(i->second.m_creatureOrGOcount[1]);
                stmt.addUInt32(i->second.m_creatureOrGOcount[2]);
                stmt.addUInt32(i->second.m_creatureOrGOcount[3]);
                stmt.addUInt32(i->second.m_itemcount[0]);
                stmt.addUInt32(i->second.m_itemcount[1]);
                stmt.addUInt32(i->second.m_itemcount[2]);
                stmt.addUInt32(i->second.m_itemcount[3]);
                stmt.addUInt32(GetGUIDLow());
                stmt.addUInt32(i->first);
                stmt.Execute();

                break;
            }
            case QUEST_UNCHANGED:
                break;
        };

        i->second.uState = QUEST_UNCHANGED;
    }
}

void Player::_SaveDailyQuestStatus()
{
    if (!m_DailyQuestChanged)
        return;

    m_DailyQuestChanged = false;

    // save last daily quest time for all quests: we need only mostly reset time for reset check anyway

    static SqlStatementID deleteDailies;
    static SqlStatementID insertDaily;

    SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteDailies, "DELETE FROM character_queststatus_daily WHERE guid = ?");
    stmt.PExecute(GetGUIDLow());

    for (uint32 quest_daily_idx = 0; quest_daily_idx < sWorld.getConfig(CONFIG_DAILY_MAX_PER_DAY); ++quest_daily_idx)
    {
        if (GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1+quest_daily_idx))
        {
            stmt = RealmDataDatabase.CreateStatement(insertDaily, "INSERT INTO character_queststatus_daily (guid, quest, time) VALUES (?, ?, ?)");
            stmt.addUInt32(GetGUIDLow());
            stmt.addUInt32(GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1+quest_daily_idx));
            stmt.addUInt64(uint64(m_lastDailyQuestTime));
            stmt.Execute();
        }
    }
}

void Player::_SaveMonthlyQuestStatus()
{
    if (!m_MonthlyQuestChanged || m_monthlyquests.empty())
        return;

    
    static SqlStatementID deleteMonthlyDailies;
    static SqlStatementID insertMonthlyDaily;

    // we don't need transactions here.
    SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteMonthlyDailies, "DELETE FROM character_queststatus_monthly WHERE guid = ?");
    stmt.PExecute(GetGUIDLow());
    
    for (std::set<uint32>::const_iterator iter = m_monthlyquests.begin(); iter != m_monthlyquests.end(); ++iter)
    {
        uint32 quest_id = *iter;
        stmt = RealmDataDatabase.CreateStatement(insertMonthlyDaily, "INSERT INTO character_queststatus_monthly (guid, quest,time) VALUES (?, ?, ?)");
        stmt.addUInt32(GetGUIDLow());
        stmt.addUInt32(quest_id);
        stmt.addUInt64(uint64(m_lastMonthlyQuestTime));
        stmt.Execute();
    }

    m_MonthlyQuestChanged = false;
}

void Player::_SaveSpells()
{
    static SqlStatementID deleteSpell;
    static SqlStatementID insertSpell;

    for (PlayerSpellMap::iterator itr = m_spells.begin(), next = m_spells.begin(); itr != m_spells.end(); itr = next)
    {
        ++next;

        if (itr->second.state == PLAYERSPELL_REMOVED || itr->second.state == PLAYERSPELL_CHANGED)
        {
            SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteSpell, "DELETE FROM character_spell WHERE guid = ? and spell = ?");
            stmt.PExecute(GetGUIDLow(), itr->first);
        }

        if (itr->second.state == PLAYERSPELL_NEW || itr->second.state == PLAYERSPELL_CHANGED)
        {
            SqlStatement stmt = RealmDataDatabase.CreateStatement(insertSpell, "INSERT INTO character_spell (guid, spell, slot, active, disabled) VALUES (?, ?, ?, ?, ?)");
            stmt.addUInt32(GetGUIDLow());
            stmt.addUInt32(itr->first);
            stmt.addUInt32(itr->second.slotId);
            stmt.addBool(itr->second.active);
            stmt.addBool(itr->second.disabled);
            stmt.Execute();
        }

        if (itr->second.state == PLAYERSPELL_REMOVED)
            _removeSpell(itr->first);
        else
            itr->second.state = PLAYERSPELL_UNCHANGED;
    }
}

void Player::_SaveTutorials()
{
    if (!m_TutorialsChanged)
        return;

    static SqlStatementID updateTutorial;
    static SqlStatementID insertTutorial;

    uint32 Rows=0;
    // it's better than rebuilding indexes multiple times
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT count(*) AS r FROM character_tutorial WHERE account = '%u' AND realmid = '%u'", GetSession()->GetAccountId(), realmID);
    if (result)
        Rows = result->Fetch()[0].GetUInt32();

    if (Rows)
    {
        SqlStatement stmt = RealmDataDatabase.CreateStatement(updateTutorial, "UPDATE character_tutorial SET tut0 = ?, tut1 = ?, tut2 = ? , tut3 = ?, tut4 = ?, tut5 = ?, tut6 = ?, tut7 = ? WHERE account = ? AND realmid = ?");
        stmt.addUInt32(m_Tutorials[0]);
        stmt.addUInt32(m_Tutorials[1]);
        stmt.addUInt32(m_Tutorials[2]);
        stmt.addUInt32(m_Tutorials[3]);
        stmt.addUInt32(m_Tutorials[4]);
        stmt.addUInt32(m_Tutorials[5]);
        stmt.addUInt32(m_Tutorials[6]);
        stmt.addUInt32(m_Tutorials[7]);
        stmt.addUInt32(GetSession()->GetAccountId());
        stmt.addUInt32(realmID);
        stmt.Execute();
    }
    else
    {
        SqlStatement stmt = RealmDataDatabase.CreateStatement(insertTutorial, "INSERT INTO character_tutorial (account, realmid, tut0, tut1, tut2, tut3, tut4, tut5, tut6, tut7) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        stmt.addUInt32(GetSession()->GetAccountId());
        stmt.addUInt32(realmID);
        stmt.addUInt32(m_Tutorials[0]);
        stmt.addUInt32(m_Tutorials[1]);
        stmt.addUInt32(m_Tutorials[2]);
        stmt.addUInt32(m_Tutorials[3]);
        stmt.addUInt32(m_Tutorials[4]);
        stmt.addUInt32(m_Tutorials[5]);
        stmt.addUInt32(m_Tutorials[6]);
        stmt.addUInt32(m_Tutorials[7]);
        stmt.Execute();
    }

    m_TutorialsChanged = false;
}

void Player::outDebugValues() const
{
    if (!sLog.IsOutDebug())                                  // optimize disabled debug output
        return;

    sLog.outDebug("HP is: \t\t\t%u\t\tMP is: \t\t\t%u",GetMaxHealth(), GetMaxPower(POWER_MANA));
    sLog.outDebug("AGILITY is: \t\t%f\t\tSTRENGTH is: \t\t%f",GetStat(STAT_AGILITY), GetStat(STAT_STRENGTH));
    sLog.outDebug("INTELLECT is: \t\t%f\t\tSPIRIT is: \t\t%f",GetStat(STAT_INTELLECT), GetStat(STAT_SPIRIT));
    sLog.outDebug("STAMINA is: \t\t%f\t\tSPIRIT is: \t\t%f",GetStat(STAT_STAMINA), GetStat(STAT_SPIRIT));
    sLog.outDebug("Armor is: \t\t%u\t\tBlock is: \t\t%f",GetArmor(), GetFloatValue(PLAYER_BLOCK_PERCENTAGE));
    sLog.outDebug("HolyRes is: \t\t%u\t\tFireRes is: \t\t%u",GetResistance(SPELL_SCHOOL_HOLY), GetResistance(SPELL_SCHOOL_FIRE));
    sLog.outDebug("NatureRes is: \t\t%u\t\tFrostRes is: \t\t%u",GetResistance(SPELL_SCHOOL_NATURE), GetResistance(SPELL_SCHOOL_FROST));
    sLog.outDebug("ShadowRes is: \t\t%u\t\tArcaneRes is: \t\t%u",GetResistance(SPELL_SCHOOL_SHADOW), GetResistance(SPELL_SCHOOL_ARCANE));
    sLog.outDebug("MIN_DAMAGE is: \t\t%f\tMAX_DAMAGE is: \t\t%f",GetFloatValue(UNIT_FIELD_MINDAMAGE), GetFloatValue(UNIT_FIELD_MAXDAMAGE));
    sLog.outDebug("MIN_OFFHAND_DAMAGE is: \t%f\tMAX_OFFHAND_DAMAGE is: \t%f",GetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE), GetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE));
    sLog.outDebug("MIN_RANGED_DAMAGE is: \t%f\tMAX_RANGED_DAMAGE is: \t%f",GetFloatValue(UNIT_FIELD_MINRANGEDDAMAGE), GetFloatValue(UNIT_FIELD_MAXRANGEDDAMAGE));
    sLog.outDebug("ATTACK_TIME is: \t%u\t\tRANGE_ATTACK_TIME is: \t%u",GetAttackTime(BASE_ATTACK), GetAttackTime(RANGED_ATTACK));
}

/*********************************************************/
/***               FLOOD FILTER SYSTEM                 ***/
/*********************************************************/

void Player::UpdateSpeakTime()
{
    // ignore chat spam protection for GMs in any mode
    if (GetSession()->HasPermissions(PERM_GMT))
        return;

    time_t current = time (NULL);
    if (m_speakTime > current)
    {
        uint32 max_count = sWorld.getConfig(CONFIG_CHATFLOOD_MESSAGE_COUNT);
        if (!max_count)
            return;

        ++m_speakCount;
        if (m_speakCount >= max_count)
        {
            // prevent overwrite mute time, if message send just before mutes set, for example.
            time_t new_mute = current + sWorld.getConfig(CONFIG_CHATFLOOD_MUTE_TIME);
            if (GetSession()->m_muteTime < new_mute)
            {
                GetSession()->m_muteTime = new_mute;
                GetSession()->m_muteReason = "Flood protection";
            }

            m_speakCount = 0;
        }
    }
    else
        m_speakCount = 0;

    m_speakTime = current + sWorld.getConfig(CONFIG_CHATFLOOD_MESSAGE_DELAY);
}

bool Player::CanSpeak() const
{
    return GetSession()->m_muteTime <= time (NULL);
}

/*********************************************************/
/***              LOW LEVEL FUNCTIONS:Notifiers        ***/
/*********************************************************/

void Player::SendAttackSwingNotInRange()
{
    WorldPacket data(SMSG_ATTACKSWING_NOTINRANGE, 0);
    SendPacketToSelf(&data);
}

void Player::SavePositionInDB(uint32 mapid, float x,float y,float z,float o,uint32 zone,uint64 guid)
{
    static SqlStatementID updatePosition;
    SqlStatement stmt = RealmDataDatabase.CreateStatement(updatePosition, "UPDATE characters SET position_x = ?, position_y = ?, position_z = ?, "
                                                            "orientation = ?, map = ?, zone = ?, trans_x = '0', trans_y = '0', trans_z = '0', transguid = '0', taxi_path = '' WHERE guid = ?");

    stmt.addFloat(x);
    stmt.addFloat(y);
    stmt.addFloat(z);
    stmt.addFloat(o);
    stmt.addUInt32(mapid);
    stmt.addUInt32(zone);
    stmt.addUInt32(GUID_LOPART(guid));
    stmt.Execute();
}

void Player::SaveDataFieldToDB()
{
    static SqlStatementID updateCharData;
    SqlStatement stmt = RealmDataDatabase.CreateStatement(updateCharData, "UPDATE characters SET data = ?  WHERE guid = ?");
    stmt.addString(GetUInt32ValuesString());
    stmt.addUInt32(GetGUIDLow());
    stmt.Execute();
}

bool Player::SaveValuesArrayInDB(Tokens const& tokens, uint64 guid)
{
    static SqlStatementID updateCharData;

    int cnt = tokens.size();
    std::ostringstream ss;
    for (int i = 0; i < cnt; ++i)
        ss << tokens[i] << " ";

    SqlStatement stmt = RealmDataDatabase.CreateStatement(updateCharData, "UPDATE characters SET data = ?  WHERE guid = ?");
    stmt.addString(ss);
    stmt.addUInt32(GUID_LOPART(guid));

    return stmt.Execute();
}

void Player::SetUInt32ValueInArray(Tokens& tokens,uint16 index, uint32 value)
{
    char buf[11];
    snprintf(buf,11,"%u",value);

    if (index >= tokens.size())
        return;

    tokens[index] = buf;
}

void Player::SetUInt32ValueInDB(uint16 index, uint32 value, uint64 guid)
{
    Tokens tokens;
    if (!LoadValuesArrayFromDB(tokens,guid))
        return;

    if (index >= tokens.size())
        return;

    char buf[11];
    snprintf(buf,11,"%u",value);
    tokens[index] = buf;

    SaveValuesArrayInDB(tokens,guid);
}

void Player::SetFloatValueInDB(uint16 index, float value, uint64 guid)
{
    uint32 temp;
    memcpy(&temp, &value, sizeof(value));
    Player::SetUInt32ValueInDB(index, temp, guid);
}

void Player::SendAttackSwingNotStanding()
{
    WorldPacket data(SMSG_ATTACKSWING_NOTSTANDING, 0);
    SendPacketToSelf(&data);
}

void Player::SendAttackSwingDeadTarget()
{
    WorldPacket data(SMSG_ATTACKSWING_DEADTARGET, 0);
    SendPacketToSelf(&data);
}

void Player::SendAttackSwingCantAttack()
{
    WorldPacket data(SMSG_ATTACKSWING_CANT_ATTACK, 0);
    SendPacketToSelf(&data);
}

void Player::SendAttackSwingCancelAttack()
{
    WorldPacket data(SMSG_CANCEL_COMBAT, 0);
    SendPacketToSelf(&data);
}

void Player::SendAttackSwingBadFacingAttack()
{
    WorldPacket data(SMSG_ATTACKSWING_BADFACING, 0);
    SendPacketToSelf(&data);
}

void Player::SendAutoRepeatCancel()
{
    WorldPacket data(SMSG_CANCEL_AUTO_REPEAT, 0);
    SendPacketToSelf(&data);
}

void Player::SendExplorationExperience(uint32 Area, uint32 Experience)
{
    WorldPacket data(SMSG_EXPLORATION_EXPERIENCE, 8);
    data << Area;
    data << Experience;
    SendPacketToSelf(&data);
}

void Player::SendDungeonDifficulty(bool IsInGroup)
{
    uint8 val = 0x00000001;
    WorldPacket data(MSG_SET_DUNGEON_DIFFICULTY, 12);
    data << (uint32)GetDifficulty();
    data << uint32(val);
    data << uint32(IsInGroup);
    SendPacketToSelf(&data);
}

void Player::SendResetFailedNotify(uint32 mapid)
{
    WorldPacket data(SMSG_RESET_FAILED_NOTIFY, 4);
    data << uint32(mapid);
    SendPacketToSelf(&data);
}

/// Reset all solo instances and optionally send a message on success for each
void Player::ResetInstances(uint8 method)
{
    // method can be INSTANCE_RESET_ALL, INSTANCE_RESET_CHANGE_DIFFICULTY, INSTANCE_RESET_GROUP_JOIN

    // we assume that when the difficulty changes, all instances that can be reset will be
    uint8 dif = GetDifficulty();

    for (BoundInstancesMap::iterator itr = m_boundInstances[dif].begin(); itr != m_boundInstances[dif].end();)
    {
        InstanceSave *p = itr->second.save;
        const MapEntry *entry = sMapStore.LookupEntry(itr->first);
        if (!entry || !p->CanReset() || p == nullptr)
        {
            ++itr;
            continue;
        }

        if (method == INSTANCE_RESET_ALL)
        {
            // the "reset all instances" method can only reset normal maps
            if (dif == DIFFICULTY_HEROIC || entry->map_type == MAP_RAID)
            {
                ++itr;
                continue;
            }
        }

        // if the map is loaded, reset it
        Map *map = sMapMgr.FindMap(p->GetMapId(), p->GetInstanceId());
        if (map && map->IsDungeon())
        {
            if (!((InstanceMap*)map)->Reset(method))
            {
                ++itr;
                continue;
            }
        }

        // since this is a solo instance there should not be any players inside
        if (method == INSTANCE_RESET_ALL || method == INSTANCE_RESET_CHANGE_DIFFICULTY)
            SendResetInstanceSuccess(p->GetMapId());

        p->DeleteFromDB();
        m_boundInstances[dif].erase(itr++);

        // the following should remove the instance save from the manager and delete it as well
        p->RemovePlayer(GetGUID());
    }
}

void Player::SendResetInstanceSuccess(uint32 MapId)
{
    WorldPacket data(SMSG_INSTANCE_RESET, 4);
    data << MapId;
    SendPacketToSelf(&data);
}

void Player::SendResetInstanceFailed(uint32 reason, uint32 MapId)
{
    // TODO: find what other fail reasons there are besides players in the instance
    WorldPacket data(SMSG_INSTANCE_RESET_FAILED, 4);
    data << reason;
    data << MapId;
    SendPacketToSelf(&data);
}

/*********************************************************/
/***              Update timers                        ***/
/*********************************************************/

///checks the 15 afk reports per 5 minutes limit
void Player::UpdateAfkReport(time_t currTime)
{
    if (m_bgAfkReportedTimer <= currTime)
    {
        m_bgAfkReportedCount = 0;
        m_bgAfkReportedTimer = currTime+5*MINUTE;
    }
}

void Player::UpdateContestedPvP(uint32 diff)
{
    if (!m_contestedPvPTimer||isInCombat())
        return;
    if (m_contestedPvPTimer <= diff)
    {
        ResetContestedPvP();
    }
    else
        m_contestedPvPTimer -= diff;
}

void Player::UpdatePvPFlag(time_t currTime)
{
    if (!IsPvP())
        return;
    if (pvpInfo.endTimer == 0 || currTime < (pvpInfo.endTimer + 300))
        return;

    UpdatePvP(false);
}

void Player::SetFFAPvP(bool state)
{
    if (state){
        SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_FFA_PVP);
        if (sWorld.getConfig(CONFIG_FFA_DISALLOWGROUP) && !GetMap()->IsBattleGroundOrArena())
            RemoveFromGroup();
    }
    else
        RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_FFA_PVP);
}

void Player::UpdateDuelFlag(time_t currTime)
{
    if (!duel || duel->startTimer == 0 ||currTime < duel->startTimer + 3)
        return;

    SetUInt32Value(PLAYER_DUEL_TEAM, 1);
    duel->opponent->SetUInt32Value(PLAYER_DUEL_TEAM, 2);

    duel->startTimer = 0;
    duel->startTime  = currTime;
    duel->opponent->duel->startTimer = 0;
    duel->opponent->duel->startTime  = currTime;
}

void Player::RemovePet(Pet* pet, PetSaveMode mode, bool returnreagent, bool isDying)
{
    if (!pet)
        pet = GetPet();
    
    // Remove auras off unsummoned pet when owner dies
    if (isDying && !pet && GetTemporaryUnsummonedPetNumber())
        RealmDataDatabase.PExecute("DELETE FROM pet_aura WHERE guid = '%u'", GetTemporaryUnsummonedPetNumber());

    if (returnreagent && (pet || m_temporaryUnsummonedPetNumber) && !InBattleGround())
    {
        //returning of reagents only for players, so best done here
        uint32 spellId = pet ? pet->GetUInt32Value(UNIT_CREATED_BY_SPELL) : m_oldpetspell;
        SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);

        if (spellInfo)
        {
            for (uint32 i = 0; i < 7; ++i)
            {
                if (spellInfo->Reagent[i] > 0)
                {
                    ItemPosCountVec dest;                   //for succubus, voidwalker, felhunter and felguard credit soulshard when despawn reason other than death (out of range, logout)
                    uint8 msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, spellInfo->Reagent[i], spellInfo->ReagentCount[i]);
                    if (msg == EQUIP_ERR_OK)
                    {
                        Item* item = StoreNewItem(dest, spellInfo->Reagent[i], true);
                        if (IsInWorld())
                            SendNewItem(item,spellInfo->ReagentCount[i],true,false);
                    }
                }
            }
        }
        m_temporaryUnsummonedPetNumber = 0;
    }

    if (!pet || pet->GetOwnerGUID()!=GetGUID())
        return;

    // only if current pet in slot
    switch (pet->getPetType())
    {
        case MINI_PET:
            m_miniPet = 0;
            break;
        case GUARDIAN_PET:
            m_guardianPets.erase(pet->GetGUID());
            break;
        case POSSESSED_PET:
            m_guardianPets.erase(pet->GetGUID());
            pet->RemoveCharmedOrPossessedBy(NULL);
            break;
        default:
            if (GetPetGUID() == pet->GetGUID())
                SetPet(NULL);
            break;
    }

    pet->CombatStop();

    // Clear auras when owner dies
    if (isDying)
        pet->RemoveAllAuras();

    pet->SavePetToDB(mode);

    pet->AddObjectToRemoveList();
    pet->m_removed = true;

    if (pet->isControlled())
    {
        WorldPacket data(SMSG_PET_SPELLS, 8);
        data << uint64(0);
        SendPacketToSelf(&data);

        if (GetGroup())
            SetGroupUpdateFlag(GROUP_UPDATE_PET);
    }
}

void Player::RemoveMiniPet()
{
    if (Pet* pet = GetMiniPet())
    {
        pet->Remove(PET_SAVE_AS_DELETED);
        m_miniPet = 0;
    }
}

Pet* Player::GetMiniPet()
{
    if (!m_miniPet)
        return NULL;
    return ObjectAccessor::GetPet(m_miniPet);
}

void Player::RemoveGuardians()
{
    while (!m_guardianPets.empty())
    {
        uint64 guid = *m_guardianPets.begin();
        if (Pet* pet = ObjectAccessor::GetPet(guid))
            pet->Remove(PET_SAVE_AS_DELETED);

        m_guardianPets.erase(guid);
    }
}

bool Player::HasGuardianWithEntry(uint32 entry)
{
    // pet guid middle part is entry (and creature also)
    // and in guardian list must be guardians with same entry _always_
    for (GuardianPetList::const_iterator itr = m_guardianPets.begin(); itr != m_guardianPets.end(); ++itr)
        if (GUID_ENPART(*itr)==entry)
            return true;

    return false;
}

void Player::Uncharm()
{
    Unit* charm = GetCharm();
    if (!charm)
        return;

    if (charm->GetTypeId() == TYPEID_UNIT && ((Creature*)charm)->isPet()
        && ((Pet*)charm)->getPetType() == POSSESSED_PET)
    {
        ((Pet*)charm)->Remove(PET_SAVE_AS_DELETED);
    }
    else
    {
        charm->RemoveSpellsCausingAura(SPELL_AURA_MOD_CHARM);
        charm->RemoveSpellsCausingAura(SPELL_AURA_AOE_CHARM);
        charm->RemoveSpellsCausingAura(SPELL_AURA_MOD_POSSESS_PET);
        charm->RemoveSpellsCausingAura(SPELL_AURA_MOD_POSSESS);
    }

    if (GetCharmGUID())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: CRASH ALARM! Player %s is not able to uncharm unit (Entry: %u, Type: %u)", GetName(), charm->GetEntry(), charm->GetTypeId());
    }
}

void Player::BuildPlayerChat(WorldPacket *data, uint8 msgtype, const std::string& text, uint32 language) const
{
    *data << (uint8)msgtype;
    *data << (uint32)language;
    *data << (uint64)GetGUID();
    *data << (uint32)language;                               //language 2.1.0 ?
    *data << (uint64)GetGUID();
    *data << (uint32)(text.length()+1);
    *data << text;
    *data << (uint8)chatTag();
}

void Player::Say(const std::string& text, const uint32 language)
{
    WorldPacket data(SMSG_MESSAGECHAT, 200);
    BuildPlayerChat(&data, CHAT_MSG_SAY, text, language);
    BroadcastPacketInRange(&data,sWorld.getConfig(CONFIG_LISTEN_RANGE_SAY),true);
}

void Player::Yell(const std::string& text, const uint32 language)
{
    WorldPacket data(SMSG_MESSAGECHAT, 200);
    BuildPlayerChat(&data, CHAT_MSG_YELL, text, language);
    BroadcastPacketInRange(&data,sWorld.getConfig(CONFIG_LISTEN_RANGE_YELL),true);
}

void Player::TextEmote(const std::string& text)
{
    WorldPacket data(SMSG_MESSAGECHAT, 200);
    BuildPlayerChat(&data, CHAT_MSG_EMOTE, text, LANG_UNIVERSAL);
    BroadcastPacketInRange(&data,sWorld.getConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE), true, !sWorld.getConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHAT));
}

void Player::Whisper(const std::string& text, uint32 language,uint64 receiver)
{
    if (language != LANG_ADDON)                             // if not addon data
        language = LANG_UNIVERSAL;                          // whispers should always be readable

    Player *rPlayer = sObjectMgr.GetPlayer(receiver);

    std::string tmpText = text;

    // when player you are whispering to is dnd, he cannot receive your message, unless you are in gm mode
    if (!rPlayer->isDND() || isGameMaster())
    {
        WorldPacket data(SMSG_MESSAGECHAT, 200);
        BuildPlayerChat(&data, CHAT_MSG_WHISPER, text, language);
        rPlayer->SendPacketToSelf(&data);

        data.Initialize(SMSG_MESSAGECHAT, 200);
        rPlayer->BuildPlayerChat(&data, CHAT_MSG_REPLY, text, language);
        SendPacketToSelf(&data);
    }
    else
    {
        // announce to player that player he is whispering to is dnd and cannot receive his message
        ChatHandler(this).PSendSysMessage(LANG_PLAYER_DND, rPlayer->GetName(), rPlayer->dndMsg.c_str());

        tmpText = "receiver DND ! text: " + tmpText;
    }

    if (language != LANG_ADDON)
    {
        if (rPlayer->GetSession()->IsAccountFlagged(ACC_WHISPER_LOG))
            sLog.outWhisp(rPlayer->GetSession()->GetAccountId(), "[%s | %u] FROM: %u (%s) : %s ", rPlayer->GetName(), rPlayer->GetGUID(), GetGUID(), GetName(), tmpText.c_str());

        if (GetSession()->IsAccountFlagged(ACC_WHISPER_LOG))
            sLog.outWhisp(GetSession()->GetAccountId(), "[%s | %u] TO: %u (%s) : %s", GetName(), GetGUID(), rPlayer->GetGUID(), rPlayer->GetName(), tmpText.c_str());
    }

    if (language == LANG_ADDON)
        return;

    if (!isAcceptWhispers() && !isGameMaster() && !rPlayer->isGameMaster())
    {
        SetAcceptWhispers(true);
        ChatHandler(this).SendSysMessage(LANG_COMMAND_WHISPERON);
    }

    // announce to player that player he is whispering to is afk
    if (rPlayer->isAFK())
        ChatHandler(this).PSendSysMessage(LANG_PLAYER_AFK, rPlayer->GetName(), rPlayer->afkMsg.c_str());

    // if player whisper someone, auto turn of dnd to be able to receive an answer
    if (isDND() && !rPlayer->isGameMaster())
        ToggleDND();
}

void Player::PetSpellInitialize()
{
    Pet* pet = GetPet();

    if (pet)
    {
        uint8 addlist = 0;

        sLog.outDebug("Pet Spells Groups");

        CreatureInfo const *cinfo = pet->GetCreatureInfo();

        if (pet->isControlled() && (pet->getPetType() == HUNTER_PET || cinfo && cinfo->type == CREATURE_TYPE_DEMON && getClass() == CLASS_WARLOCK))
        {
            for (PetSpellMap::iterator itr = pet->m_spells.begin();itr != pet->m_spells.end();++itr)
            {
                if (itr->second->state == PETSPELL_REMOVED)
                    continue;
                ++addlist;
            }
        }

        // first line + actionbar + spellcount + spells + last adds
        WorldPacket data(SMSG_PET_SPELLS, 16+40+1+4*addlist+25);

        CharmInfo *charmInfo = pet->GetCharmInfo();

                                                            //16
        data << (uint64)pet->GetGUID() << uint32(0x00000000) << uint8(pet->GetReactState()) << uint8(charmInfo->GetCommandState()) << uint16(0);

        for (uint32 i = 0; i < 10; i++)                      //40
        {
            data << uint16(charmInfo->GetActionBarEntry(i)->SpellOrAction) << uint16(charmInfo->GetActionBarEntry(i)->Type);
        }

        data << uint8(addlist);                             //1

        if (addlist && pet->isControlled())
        {
            for (PetSpellMap::iterator itr = pet->m_spells.begin(); itr != pet->m_spells.end(); ++itr)
            {
                if (itr->second->state == PETSPELL_REMOVED)
                    continue;

                data << uint16(itr->first);
                data << uint16(itr->second->active);        // pet spell active state isn't boolean
            }
        }

        //data << uint8(0x01) << uint32(0x6010) << uint32(0x01) << uint32(0x05) << uint16(0x00);    //15
        uint8 count = 3;                                    //1+8+8+8=25

        // if count = 0, then end of packet...
        data << count;
        // uint32 value is spell id...
        // uint64 value is constant 0, unknown...
        data << uint32(0x6010) << uint64(0);                // if count = 1, 2 or 3
        //data << uint32(0x5fd1) << uint64(0);  // if count = 2
        data << uint32(0x8e8c) << uint64(0);                // if count = 3
        data << uint32(0x8e8b) << uint64(0);                // if count = 3

        SendPacketToSelf(&data);
    }
}

void Player::PossessSpellInitialize()
{
    Unit* charm = GetCharm();

    if (!charm)
        return;

    CharmInfo *charmInfo = charm->GetCharmInfo();

    if (!charmInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player::PossessSpellInitialize(): charm (" UI64FMTD ") has no charminfo!", charm->GetGUID());
        return;
    }

    uint8 addlist = 0;
    WorldPacket data(SMSG_PET_SPELLS, 16+40+1+4*addlist+25);// first line + actionbar + spellcount + spells + last adds

                                                            //16
    data << (uint64)charm->GetGUID() << uint32(0x00000000) << uint8(0) << uint8(0) << uint16(0);

    for (uint32 i = 0; i < 10; i++)                          //40
    {
        data << uint16(charmInfo->GetActionBarEntry(i)->SpellOrAction) << uint16(charmInfo->GetActionBarEntry(i)->Type);
    }

    data << uint8(addlist);                                 //1

    uint8 count = 3;
    data << count;
    data << uint32(0x6010) << uint64(0);                    // if count = 1, 2 or 3
    data << uint32(0x8e8c) << uint64(0);                    // if count = 3
    data << uint32(0x8e8b) << uint64(0);                    // if count = 3

    SendPacketToSelf(&data);
}

void Player::CharmSpellInitialize()
{
    Unit* charm = GetCharm();

    if (!charm)
        return;

    CharmInfo *charmInfo = charm->GetCharmInfo();
    if (!charmInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player::CharmSpellInitialize(): the player's charm (" UI64FMTD ") has no charminfo!", charm->GetGUID());
        return;
    }

    uint8 addlist = 0;

    if (charm->GetTypeId() != TYPEID_PLAYER)
    {
        CreatureInfo const *cinfo = ((Creature*)charm)->GetCreatureInfo();

        if (cinfo && cinfo->type == CREATURE_TYPE_DEMON && getClass() == CLASS_WARLOCK)
        {
            for (uint32 i = 0; i < CREATURE_MAX_SPELLS; ++i)
            {
                if (charmInfo->GetCharmSpell(i)->spellId)
                    ++addlist;
            }
        }
    }

    WorldPacket data(SMSG_PET_SPELLS, 16+40+1+4*addlist+25);// first line + actionbar + spellcount + spells + last adds

    data << (uint64)charm->GetGUID() << uint32(0x00000000);

    if (charm->GetTypeId() != TYPEID_PLAYER)
        data << uint8(((Creature*)charm)->GetReactState()) << uint8(charmInfo->GetCommandState());
    else
        data << uint8(0) << uint8(0);

    data << uint16(0);

    for (uint32 i = 0; i < 10; i++)                          //40
    {
        data << uint16(charmInfo->GetActionBarEntry(i)->SpellOrAction) << uint16(charmInfo->GetActionBarEntry(i)->Type);
    }

    data << uint8(addlist);                                 //1

    if (addlist)
    {
        for (uint32 i = 0; i < CREATURE_MAX_SPELLS; ++i)
        {
            CharmSpellEntry *cspell = charmInfo->GetCharmSpell(i);
            if (cspell->spellId)
            {
                data << uint16(cspell->spellId);
                data << uint16(cspell->active);
            }
        }
    }

    uint8 count = 3;
    data << count;
    data << uint32(0x6010) << uint64(0);                    // if count = 1, 2 or 3
    data << uint32(0x8e8c) << uint64(0);                    // if count = 3
    data << uint32(0x8e8b) << uint64(0);                    // if count = 3

    SendPacketToSelf(&data);
}

int32 Player::GetTotalFlatMods(uint32 spellId, SpellModOp op)
{
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);
    if (!spellInfo) return 0;
    int32 total = 0;
    for (SpellModList::iterator itr = m_spellMods[op].begin(); itr != m_spellMods[op].end(); ++itr)
    {
        SpellModifier *mod = *itr;

        if (!IsAffectedBySpellmod(spellInfo,mod))
            continue;

        if (mod->type == SPELLMOD_FLAT)
            total += mod->value;
    }
    return total;
}

int32 Player::GetTotalPctMods(uint32 spellId, SpellModOp op)
{
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);
    if (!spellInfo) return 0;
    int32 total = 0;
    for (SpellModList::iterator itr = m_spellMods[op].begin(); itr != m_spellMods[op].end(); ++itr)
    {
        SpellModifier *mod = *itr;

        if (!IsAffectedBySpellmod(spellInfo,mod))
            continue;

        if (mod->type == SPELLMOD_PCT)
            total += mod->value;
    }
    return total;
}

bool Player::IsAffectedBySpellmod(SpellEntry const *spellInfo, SpellModifier *mod, Spell const* spell)
{
    if (!mod || !spellInfo)
        return false;

    if (mod->charges == -1 && mod->lastAffected)            // marked as expired but locked until spell casting finish
    {
        // prevent apply to any spell except spell that trigger expire
        if (spell)
        {
            if (mod->lastAffected != spell)
                return false;
        }
        else if (mod->lastAffected != FindCurrentSpellBySpellId(spellInfo->Id))
            return false;
    }

    return sSpellMgr.IsAffectedBySpell(spellInfo,mod->spellId,mod->effectId,mod->mask);
}

void Player::AddSpellMod(SpellModifier* mod, bool apply)
{
    uint16 Opcode= (mod->type == SPELLMOD_FLAT) ? SMSG_SET_FLAT_SPELL_MODIFIER : SMSG_SET_PCT_SPELL_MODIFIER;

    for (int eff=0;eff<64;++eff)
    {
        uint64 _mask = uint64(1) << eff;
        if (mod->mask & _mask)
        {
            int32 val = 0;
            for (SpellModList::iterator itr = m_spellMods[mod->op].begin(); itr != m_spellMods[mod->op].end(); ++itr)
            {
                if ((*itr)->type == mod->type && (*itr)->mask & _mask)
                    val += (*itr)->value;
            }
            val += apply ? mod->value : -(mod->value);
            WorldPacket data(Opcode, (1+1+4));
            data << uint8(eff);
            data << uint8(mod->op);
            data << int32(val);
        SendPacketToSelf(&data);
        }
    }

    if (apply)
        m_spellMods[mod->op].push_back(mod);
    else
    {
        if (mod->charges == -1)
            --m_SpellModRemoveCount;
        m_spellMods[mod->op].remove(mod);
        delete mod;
    }
}

// Restore spellmods in case of failed cast
void Player::RestoreSpellMods(Spell const* spell)
{
    if (!spell || (m_SpellModRemoveCount == 0))
        return;

    for (int i=0;i<MAX_SPELLMOD;++i)
    {
        for (SpellModList::iterator itr = m_spellMods[i].begin(); itr != m_spellMods[i].end();++itr)
        {
            SpellModifier *mod = *itr;

            if (mod && mod->charges == -1 && mod->lastAffected == spell)
            {
                mod->lastAffected = NULL;
                mod->charges = 1;
                m_SpellModRemoveCount--;
            }
        }
    }
}

void Player::ResetSpellModsDueToCanceledSpell(Spell const* spell)
{
    for (int i = 0; i < MAX_SPELLMOD; ++i)
    {
        for (SpellModList::const_iterator itr = m_spellMods[i].begin(); itr != m_spellMods[i].end(); ++itr)
        {
            SpellModifier* mod = *itr;

            if (mod->lastAffected != spell)
                continue;

            mod->lastAffected = nullptr;

            if (mod->charges == -1)
            {
                mod->charges = 1;
                if (m_SpellModRemoveCount > 0)
                    --m_SpellModRemoveCount;
            }
            else if (mod->charges > 0)
                ++mod->charges;
        }
    }
}

void Player::RemoveSpellMods(Spell const* spell)
{
    if (!spell || (m_SpellModRemoveCount == 0))
        return;

    for (int i=0;i<MAX_SPELLMOD;++i)
    {
        for (SpellModList::iterator itr = m_spellMods[i].begin(); itr != m_spellMods[i].end();)
        {
            SpellModifier *mod = *itr;
            ++itr;

            if (mod && mod->charges == -1 && (mod->lastAffected == spell || mod->lastAffected==NULL))
            {
                RemoveAurasDueToSpell(mod->spellId);
                if (m_spellMods[i].empty())
                    break;
                else
                    itr = m_spellMods[i].begin();
            }
        }
    }
}

// send Proficiency
void Player::SendProficiency(uint8 pr1, uint32 pr2)
{
    WorldPacket data(SMSG_SET_PROFICIENCY, 8);
    data << pr1 << pr2;
   SendPacketToSelf (&data);
}

void Player::RemovePetitionsAndSigns(uint64 guid, uint32 type)
{
    QueryResultAutoPtr result = QueryResultAutoPtr(NULL);
    if (type==10)
        result = RealmDataDatabase.PQuery("SELECT ownerguid,petitionguid FROM petition_sign WHERE playerguid = '%u'", GUID_LOPART(guid));
    else
        result = RealmDataDatabase.PQuery("SELECT ownerguid,petitionguid FROM petition_sign WHERE playerguid = '%u' AND type = '%u'", GUID_LOPART(guid), type);
    if (result)
    {
        do                                                  // this part effectively does nothing, since the deletion / modification only takes place _after_ the PetitionQuery. Though I don't know if the result remains intact if I execute the delete query beforehand.
        {                                                   // and SendPetitionQueryOpcode reads data from the DB
            Field *fields = result->Fetch();
            uint64 ownerguid   = MAKE_NEW_GUID(fields[0].GetUInt32(), 0, HIGHGUID_PLAYER);
            uint64 petitionguid = MAKE_NEW_GUID(fields[1].GetUInt32(), 0, HIGHGUID_ITEM);

            // send update if charter owner in game
            Player* owner = sObjectMgr.GetPlayer(ownerguid);
            if (owner)
                owner->GetSession()->SendPetitionQueryOpcode(petitionguid);

        } while (result->NextRow());

        if (type==10)
            RealmDataDatabase.PExecute("DELETE FROM petition_sign WHERE playerguid = '%u'", GUID_LOPART(guid));
        else
            RealmDataDatabase.PExecute("DELETE FROM petition_sign WHERE playerguid = '%u' AND type = '%u'", GUID_LOPART(guid), type);
    }

    RealmDataDatabase.BeginTransaction();
    if (type == 10)
    {
        RealmDataDatabase.PExecute("DELETE FROM petition WHERE ownerguid = '%u'", GUID_LOPART(guid));
        RealmDataDatabase.PExecute("DELETE FROM petition_sign WHERE ownerguid = '%u'", GUID_LOPART(guid));
    }
    else
    {
        RealmDataDatabase.PExecute("DELETE FROM petition WHERE ownerguid = '%u' AND type = '%u'", GUID_LOPART(guid), type);
        RealmDataDatabase.PExecute("DELETE FROM petition_sign WHERE ownerguid = '%u' AND type = '%u'", GUID_LOPART(guid), type);
    }
    RealmDataDatabase.CommitTransaction();
}

void Player::SetRestBonus (float rest_bonus_new)
{
    // Prevent resting on max level
    if (getLevel() >= sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
        rest_bonus_new = 0;

    if (rest_bonus_new < 0)
        rest_bonus_new = 0;

    float rest_bonus_max = (float)GetUInt32Value(PLAYER_NEXT_LEVEL_XP)*1.5/2;

    if (rest_bonus_new > rest_bonus_max)
        m_rest_bonus = rest_bonus_max;
    else
        m_rest_bonus = rest_bonus_new;

    // update data for client
    if (m_rest_bonus>10)
        SetByteValue(PLAYER_BYTES_2, 3, 0x01);              // Set Reststate = Rested
    else if (m_rest_bonus<=1)
        SetByteValue(PLAYER_BYTES_2, 3, 0x02);              // Set Reststate = Normal

    //RestTickUpdate
    SetUInt32Value(PLAYER_REST_STATE_EXPERIENCE, uint32(m_rest_bonus));
}

void Player::HandleStealthedUnitsDetection()
{
    std::list<Unit*> stealthedUnits;
    Looking4group::AnyStealthedCheck u_check;
    Looking4group::UnitListSearcher<Looking4group::AnyStealthedCheck > searcher(stealthedUnits, u_check);

    Cell::VisitAllObjects(this, searcher, MAX_PLAYER_STEALTH_DETECT_RANGE);

    // NYI
    //WorldObject const* viewPoint = GetCamera().GetBody();

    for (std::list<Unit*>::const_iterator i = stealthedUnits.begin(); i != stealthedUnits.end(); ++i)
    {
        if ((*i) == this)
            continue;

        bool hasAtClient = HaveAtClient((*i));
        bool hasDetected = canSeeOrDetect(*i, GetCamera().GetBody(), true);

        if (hasDetected)
        {
            if (!hasAtClient)
            {
                (*i)->SendCreateUpdateToPlayer(this);
                m_clientGUIDs.insert((*i)->GetGUID());

                // target aura duration for caster show only if target exist at caster client
                // send data at target visibility change (adding to client)
                SendInitialVisiblePackets(*i);
            }
        }
        else
        {
            if (hasAtClient)
            {
                (*i)->DestroyForPlayer(this);
                m_clientGUIDs.erase((*i)->GetGUID());
            }
        }
    }
}

bool Player::ActivateTaxiPathTo(std::vector<uint32> const& nodes, uint32 mount_id, Creature* npc)
{
    if (nodes.size() < 2)
        return false;

    // not let cheating with start flight mounted
    if (IsMounted())
    {
        WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
        data << uint32(ERR_TAXIPLAYERALREADYMOUNTED);
        SendPacketToSelf(&data);
        return false;
    }

    if (GetSession()->isLogingOut() || isInCombat() || hasUnitState(UNIT_STAT_STUNNED) || hasUnitState(UNIT_STAT_ROOT))
    {
        WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
        data << uint32(ERR_TAXIPLAYERBUSY);
        SendPacketToSelf(&data);
        return false;
    }

    if (m_ShapeShiftFormSpellId && m_form != FORM_BATTLESTANCE && m_form != FORM_BERSERKERSTANCE && m_form != FORM_DEFENSIVESTANCE && m_form != FORM_SHADOW)
    {
        WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
        data << uint32(ERR_TAXIPLAYERSHAPESHIFTED);
        SendPacketToSelf(&data);
        return false;
    }

    // not let cheating with start flight in time of logout process || if casting not finished || while in combat || if not use Spell's with EffectSendTaxi
    if (GetSession()->isLogingOut() ||
        (!m_currentSpells[CURRENT_GENERIC_SPELL] ||
        m_currentSpells[CURRENT_GENERIC_SPELL]->GetSpellInfo()->Effect[0] != SPELL_EFFECT_SEND_TAXI)&&
        IsNonMeleeSpellCasted(false) ||
        isInCombat())
    {
        WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
        data << uint32(ERR_TAXIPLAYERBUSY);
        SendPacketToSelf(&data);
        return false;
    }

    if (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return false;

    uint32 sourcenode = nodes[0];

    // starting node too far away (cheat?)
    TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(sourcenode);
    if (!node || node->map_id != GetMapId() ||
        (node->x - GetPositionX())*(node->x - GetPositionX())+
        (node->y - GetPositionY())*(node->y - GetPositionY())+
        (node->z - GetPositionZ())*(node->z - GetPositionZ()) >
        (2*INTERACTION_DISTANCE)*(2*INTERACTION_DISTANCE)*(2*INTERACTION_DISTANCE))
    {
        WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
        data << uint32(ERR_TAXIUNSPECIFIEDSERVERERROR);
        SendPacketToSelf(&data);
        return false;
    }

    // Prepare to flight start now

    // stop combat at start taxi flight if any
    CombatStop();

    // stop trade (client cancel trade at taxi map open but cheating tools can be used for reopen it)
    TradeCancel(true);

    // clean not finished taxi path if any
    CleanupAfterTaxiFlight();

    // 0 element current node
    m_taxi.AddTaxiDestination(sourcenode);

    // fill destinations path tail
    uint32 sourcepath = 0;
    uint32 totalcost = 0;

    uint32 prevnode = sourcenode;
    uint32 lastnode = 0;

    for (uint32 i = 1; i < nodes.size(); ++i)
    {
        uint32 path, cost;

        lastnode = nodes[i];
        sObjectMgr.GetTaxiPath(prevnode, lastnode, path, cost);

        if (!path)
        {
            CleanupAfterTaxiFlight();
            return false;
        }

        totalcost += cost;

        if (prevnode == sourcenode)
            sourcepath = path;

        m_taxi.AddTaxiDestination(lastnode);

        prevnode = lastnode;
    }

    if (!mount_id)                                           // if not provide then attempt use default.
        mount_id = sObjectMgr.GetTaxiMount(sourcenode, GetTeam());

    if (mount_id == 0 || sourcepath == 0)
    {
        WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
        data << uint32(ERR_TAXIUNSPECIFIEDSERVERERROR);
        SendPacketToSelf(&data);
        CleanupAfterTaxiFlight();
        return false;
    }

    uint32 money = GetMoney();

    if (npc)
    {
        totalcost = (uint32)ceil(totalcost*GetReputationPriceDiscount(npc));
    }

    if (money < totalcost)
    {
        WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
        data << uint32(ERR_TAXINOTENOUGHMONEY);
        SendPacketToSelf(&data);
        CleanupAfterTaxiFlight();
        return false;
    }

    //Checks and preparations done, DO FLIGHT
    ModifyMoney(-(int32)totalcost);

    // prevent stealth flight
    //RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TALK);

    WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
    data << uint32(ERR_TAXIOK);
    SendPacketToSelf(&data);

    sLog.outDebug("WORLD: Sent SMSG_ACTIVATETAXIREPLY");

    GetSession()->SendDoFlight(mount_id, sourcepath);

    return true;
}

void Player::CleanupAfterTaxiFlight()
{
    m_taxi.ClearTaxiDestinations();        // not destinations, clear source node
    Unmount();
    RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);
    getHostilRefManager().setOnlineOfflineState(true);
}

void Player::LockSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs)
{
                                                            // last check 2.0.10
    WorldPacket data(SMSG_SPELL_COOLDOWN, 8+1+m_spells.size()*8);
    data << GetGUID();
    data << uint8(0x0);                                     // flags (0x1, 0x2)
    time_t curTime = time(NULL);
    for (PlayerSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        if (itr->second.state == PLAYERSPELL_REMOVED)
            continue;
        uint32 unSpellId = itr->first;
        SpellEntry const *spellInfo = sSpellStore.LookupEntry(unSpellId);
        if (!spellInfo)
        {
            ASSERT(spellInfo);
            continue;
        }

        // Not send cooldown for this spells
        if (spellInfo->Attributes & SPELL_ATTR_DISABLED_WHILE_ACTIVE)
            continue;

        if (spellInfo->PreventionType != SPELL_PREVENTION_TYPE_SILENCE)
            continue;

        if ((idSchoolMask & SpellMgr::GetSpellSchoolMask(spellInfo)) && GetSpellCooldownDelay(unSpellId) < unTimeMs)
        {
            data << unSpellId;
            data << unTimeMs;                               // in m.secs
            AddSpellCooldown(unSpellId, 0, curTime + unTimeMs/1000);
        }
    }
    SendPacketToSelf(&data);
}

void Player::InitDataForForm(bool reapplyMods)
{
    SpellShapeshiftEntry const* ssEntry = sSpellShapeshiftStore.LookupEntry(m_form);
    if (ssEntry && ssEntry->attackSpeed)
    {
        SetAttackTime(BASE_ATTACK,ssEntry->attackSpeed);
        SetAttackTime(OFF_ATTACK,ssEntry->attackSpeed);
        SetAttackTime(RANGED_ATTACK, BASE_ATTACK_TIME);
    }
    else
        SetRegularAttackTime();

    switch (m_form)
    {
        case FORM_CAT:
        {
            if (getPowerType()!=POWER_ENERGY)
                setPowerType(POWER_ENERGY);
            break;
        }
        case FORM_BEAR:
        case FORM_DIREBEAR:
        {
            if (getPowerType()!=POWER_RAGE)
                setPowerType(POWER_RAGE);
            break;
        }
        default:                                            // 0, for example
        {
            ChrClassesEntry const* cEntry = sChrClassesStore.LookupEntry(getClass());
            if (cEntry && cEntry->powerType < MAX_POWERS && uint32(getPowerType()) != cEntry->powerType)
                setPowerType(Powers(cEntry->powerType));
            break;
        }
    }

    // update auras at form change, ignore this at mods reapply (.reset stats/etc) when form not change.
    if (!reapplyMods)
        UpdateEquipSpellsAtFormChange();

    UpdateAttackPowerAndDamage();
    UpdateAttackPowerAndDamage(true);
}

// Return true is the bought item has a max count to force refresh of window by caller
bool Player::BuyItemFromVendor(uint64 vendorguid, uint32 item, uint8 count, uint64 bagguid, uint8 slot)
{
    // cheating attempt
    if (count < 1) count = 1;

    // cheating attempt
    if (slot > MAX_BAG_SIZE && slot != NULL_SLOT)
        return false;

    if (!isAlive())
        return false;

    ItemPrototype const *pProto = ObjectMgr::GetItemPrototype(item);
    if (!pProto)
    {
        SendBuyError(BUY_ERR_CANT_FIND_ITEM, NULL, item, 0);
        return false;
    }

    Creature *pCreature = GetNPCIfCanInteractWith(vendorguid, UNIT_NPC_FLAG_VENDOR);
    if (!pCreature)
    {
        sLog.outDebug("WORLD: BuyItemFromVendor - Unit (GUID: %u) not found or you can't interact with him.", uint32(GUID_LOPART(vendorguid)));
        SendBuyError(BUY_ERR_DISTANCE_TOO_FAR, NULL, item, 0);
        return false;
    }

    VendorItemData const* vItems = pCreature->GetVendorItems();
    if (!vItems || vItems->Empty())
    {
        SendBuyError(BUY_ERR_CANT_FIND_ITEM, pCreature, item, 0);
        return false;
    }

    size_t vendor_slot = vItems->FindItemSlot(item);
    if (vendor_slot >= vItems->GetItemCount())
    {
        SendBuyError(BUY_ERR_CANT_FIND_ITEM, pCreature, item, 0);
        return false;
    }

    VendorItem const* crItem = vItems->m_items[vendor_slot];

    // check current item amount if it limited
    if (crItem->maxcount != 0)
    {
        if (pCreature->GetVendorItemCurrentCount(crItem) < pProto->BuyCount * count)
        {
            SendBuyError(BUY_ERR_ITEM_ALREADY_SOLD, pCreature, item, 0);
            return false;
        }
    }

    if (uint32(m_reputationMgr.GetRank(pProto->RequiredReputationFaction)) < pProto->RequiredReputationRank)
    {
        SendBuyError(BUY_ERR_REPUTATION_REQUIRE, pCreature, item, 0);
        return false;
    }

    if (crItem->ExtendedCost)
    {
        ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(crItem->ExtendedCost);
        if (!iece)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Item %u have wrong ExtendedCost field value %u", pProto->ItemId, crItem->ExtendedCost);
            return false;
        }

        // honor points price
        if (GetHonorPoints() < (iece->reqhonorpoints * count))
        {
            SendEquipError(EQUIP_ERR_NOT_ENOUGH_HONOR_POINTS, NULL, NULL);
            return false;
        }

        // arena points price
        if (GetArenaPoints() < (iece->reqarenapoints * count))
        {
            SendEquipError(EQUIP_ERR_NOT_ENOUGH_ARENA_POINTS, NULL, NULL);
            return false;
        }

        // item base price
        for (uint8 i = 0; i < 5; ++i)
        {
            if (iece->reqitem[i] && !HasItemCount(iece->reqitem[i], (iece->reqitemcount[i] * count)))
            {
                SendEquipError(EQUIP_ERR_VENDOR_MISSING_TURNINS, NULL, NULL);
                return false;
            }
        }

        // check for personal arena rating requirement
        if (GetMaxPersonalArenaRatingRequirement() < iece->reqpersonalarenarating)
        {
            // probably not the proper equip err
            SendEquipError(EQUIP_ERR_CANT_EQUIP_RANK,NULL,NULL);
            return false;
        }
    }

    uint32 price  = pProto->BuyPrice * count;

    // reputation discount
    price = uint32(floor(price * GetReputationPriceDiscount(pCreature)));

    if (GetMoney() < price)
    {
        SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, pCreature, item, 0);
        return false;
    }

    uint8 bag = 0;                                          // init for case invalid bagGUID

    if (bagguid != NULL_BAG && slot != NULL_SLOT)
    {
        Bag *pBag;
        if (bagguid == GetGUID())
        {
            bag = INVENTORY_SLOT_BAG_0;
        }
        else
        {
            for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END;i++)
            {
                pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0,i);
                if (pBag)
                {
                    if (bagguid == pBag->GetGUID())
                    {
                        bag = i;
                        break;
                    }
                }
            }
        }
    }

    if (IsInventoryPos(bag, slot) || (bagguid == NULL_BAG && slot == NULL_SLOT))
    {
        ItemPosCountVec dest;
        uint8 msg = CanStoreNewItem(bag, slot, dest, item, pProto->BuyCount * count);
        if (msg != EQUIP_ERR_OK)
        {
            SendEquipError(msg, NULL, NULL);
            return false;
        }

        ModifyMoney(-(int32)price);
        if (crItem->ExtendedCost)                            // case for new honor system
        {
            ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(crItem->ExtendedCost);
            if (iece->reqhonorpoints)
                ModifyHonorPoints(- int32(iece->reqhonorpoints * count));
            if (iece->reqarenapoints)
                ModifyArenaPoints(- int32(iece->reqarenapoints * count));
            for (uint8 i = 0; i < 5; ++i)
            {
                if (iece->reqitem[i])
                    DestroyItemCount(iece->reqitem[i], (iece->reqitemcount[i] * count), true);
            }
        }

        if (Item *it = StoreNewItem(dest, item, true))
        {
            uint32 new_count = pCreature->UpdateVendorItemCurrentCount(crItem,pProto->BuyCount * count);

            WorldPacket data(SMSG_BUY_ITEM, (8+4+4+4));
            data << pCreature->GetGUID();
            data << (uint32)(vendor_slot+1);                // numbered from 1 at client
            data << (uint32)(crItem->maxcount > 0 ? new_count : 0xFFFFFFFF);
            data << (uint32)count;
            SendPacketToSelf(&data);

            SendNewItem(it, pProto->BuyCount*count, true, false, false);
        }
    }
    else if (IsEquipmentPos(bag, slot))
    {
        if (pProto->BuyCount * count != 1)
        {
            SendEquipError(EQUIP_ERR_ITEM_CANT_BE_EQUIPPED, NULL, NULL);
            return false;
        }

        uint16 dest;
        uint8 msg = CanEquipNewItem(slot, dest, item, false);
        if (msg != EQUIP_ERR_OK)
        {
            SendEquipError(msg, NULL, NULL);
            return false;
        }

        ModifyMoney(-(int32)price);
        if (crItem->ExtendedCost)                            // case for new honor system
        {
            ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(crItem->ExtendedCost);
            if (iece->reqhonorpoints)
                ModifyHonorPoints(- int32(iece->reqhonorpoints));
            if (iece->reqarenapoints)
                ModifyArenaPoints(- int32(iece->reqarenapoints));
            for (uint8 i = 0; i < 5; ++i)
            {
                if (iece->reqitem[i])
                    DestroyItemCount(iece->reqitem[i], iece->reqitemcount[i], true);
            }
        }

        if (Item *it = EquipNewItem(dest, item, true))
        {
            uint32 new_count = pCreature->UpdateVendorItemCurrentCount(crItem,pProto->BuyCount * count);

            WorldPacket data(SMSG_BUY_ITEM, (8+4+4+4));
            data << pCreature->GetGUID();
            data << uint32(vendor_slot+1);                // numbered from 1 at client
            data << uint32(crItem->maxcount > 0 ? new_count : 0xFFFFFFFF);
            data << uint32(count);
            SendPacketToSelf(&data);

            SendNewItem(it, pProto->BuyCount*count, true, false, false);

            AutoUnequipOffhandIfNeed();
        }
    }
    else
    {
        SendEquipError(EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT, NULL, NULL);
        return false;
    }

    return crItem->maxcount!=0;
}

uint32 Player::GetMaxPersonalArenaRatingRequirement()
{
    // returns the maximal personal arena rating that can be used to purchase items requiring this condition
    // the personal rating of the arena team must match the required limit as well
    // so return max[in arenateams](min(personalrating[teamtype], teamrating[teamtype]))
    uint32 max_personal_rating = 0;
    for (int i = 0; i < MAX_ARENA_SLOT; ++i)
    {
        if (ArenaTeam * at = sObjectMgr.GetArenaTeamById(GetArenaTeamId(i)))
        {
            uint32 p_rating = GetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (i * 6) + 5);
            uint32 t_rating = at->GetRating();
            p_rating = p_rating<t_rating? p_rating : t_rating;
            if (max_personal_rating < p_rating)
                max_personal_rating = p_rating;
        }
    }
    return max_personal_rating;
}

void Player::UpdateHomebindTime(uint32 time)
{
    // GMs never get homebind timer online
    if (m_InstanceValid || isGameMaster())
    {
        if (m_HomebindTimer)                                 // instance valid, but timer not reset
        {
            // hide reminder
            WorldPacket data(SMSG_RAID_GROUP_ONLY, 4+4);
            data << uint32(0);
            data << uint32(0);
            SendPacketToSelf(&data);
        }
        // instance is valid, reset homebind timer
        m_HomebindTimer = 0;
    }
    else if (m_HomebindTimer > 0)
    {
        if (time >= m_HomebindTimer)
        {
            // teleport to homebind location
            TeleportToHomebind();
        }
        else
            m_HomebindTimer -= time;
    }
    else
    {
        // instance is invalid, start homebind timer
        m_HomebindTimer = 60000;
        // send message to player
        WorldPacket data(SMSG_RAID_GROUP_ONLY, 4+4);
        data << m_HomebindTimer;
        data << uint32(1);
        SendPacketToSelf(&data);
        sLog.outDebug("PLAYER: Player '%s' (GUID: %u) will be teleported to homebind in 60 seconds", GetName(),GetGUIDLow());
    }
}

void Player::UpdatePvP(bool state, bool ovrride)
{
    if (sWorld.getConfig(CONFIG_DISABLE_PVP))
    {
        state = false;
        ovrride = true;
        ApplyModFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP, false);
    }
    
    SetPvP(state);
    if (Pet* pet = GetPet())
        pet->SetPvP(state);
    if (Unit* charmed = GetCharm())
        charmed->SetPvP(state);
            
    if (!state || ovrride)
        pvpInfo.endTimer = 0;    
    else if (!pvpInfo.inHostileArea && !HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP))
        pvpInfo.endTimer = time(NULL);
}

void Player::AddSpellCooldown(uint32 spellid, uint32 itemid, time_t end_time)
{
    SpellCooldown sc;
    sc.end = end_time;
    sc.itemid = itemid;
    m_spellCooldowns[spellid] = sc;
}

void Player::SendCooldownEvent(SpellEntry const *spellInfo)
{
    if (!(spellInfo->Attributes & SPELL_ATTR_DISABLED_WHILE_ACTIVE))
        return;

    // Get spell cooldown
    int32 cooldown = SpellMgr::GetSpellRecoveryTime(spellInfo);
    // Apply spellmods
    ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, cooldown);
    if (cooldown < 0)
        cooldown = 0;
    // Add cooldown
    AddSpellCooldown(spellInfo->Id, 0, time(NULL) +  cooldown / 1000);
    // Send activate
    WorldPacket data(SMSG_COOLDOWN_EVENT, (4+8));
    data << spellInfo->Id;
    data << GetGUID();
    SendPacketToSelf(&data);
}
                                                           //slot to be excluded while counting
bool Player::EnchantmentFitsRequirements(uint32 enchantmentcondition, int8 slot)
{
    if (!enchantmentcondition)
        return true;

    SpellItemEnchantmentConditionEntry const *Condition = sSpellItemEnchantmentConditionStore.LookupEntry(enchantmentcondition);

    if (!Condition)
        return true;

    uint8 curcount[4] = {0, 0, 0, 0};

    //counting current equipped gem colors
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        if (i == slot)
            continue;
        Item *pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem2 && !pItem2->IsBroken() && pItem2->GetProto()->Socket[0].Color)
        {
            for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT+3; ++enchant_slot)
            {
                uint32 enchant_id = pItem2->GetEnchantmentId(EnchantmentSlot(enchant_slot));
                if (!enchant_id)
                    continue;

                SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
                if (!enchantEntry)
                    continue;

                uint32 gemid = enchantEntry->GemID;
                if (!gemid)
                    continue;

                ItemPrototype const* gemProto = sItemStorage.LookupEntry<ItemPrototype>(gemid);
                if (!gemProto)
                    continue;

                GemPropertiesEntry const* gemProperty = sGemPropertiesStore.LookupEntry(gemProto->GemProperties);
                if (!gemProperty)
                    continue;

                uint8 GemColor = gemProperty->color;

                for (uint8 b = 0, tmpcolormask = 1; b < 4; b++, tmpcolormask <<= 1)
                {
                    if (tmpcolormask & GemColor)
                        ++curcount[b];
                }
            }
        }
    }

    bool activate = true;

    for (int i = 0; i < 5; i++)
    {
        if (!Condition->Color[i])
            continue;

        uint32 _cur_gem = curcount[Condition->Color[i] - 1];

        // if have <CompareColor> use them as count, else use <value> from Condition
        uint32 _cmp_gem = Condition->CompareColor[i] ? curcount[Condition->CompareColor[i] - 1]: Condition->Value[i];

        switch (Condition->Comparator[i])
        {
            case 2:                                         // requires less <color> than (<value> || <comparecolor>) gems
                activate &= (_cur_gem < _cmp_gem) ? true : false;
                break;
            case 3:                                         // requires more <color> than (<value> || <comparecolor>) gems
                activate &= (_cur_gem > _cmp_gem) ? true : false;
                break;
            case 5:                                         // requires at least <color> than (<value> || <comparecolor>) gems
                activate &= (_cur_gem >= _cmp_gem) ? true : false;
                break;
        }
    }

    sLog.outDebug("Checking Condition %u, there are %u Meta Gems, %u Red Gems, %u Yellow Gems and %u Blue Gems, Activate:%s", enchantmentcondition, curcount[0], curcount[1], curcount[2], curcount[3], activate ? "yes" : "no");

    return activate;
}

void Player::CorrectMetaGemEnchants(uint8 exceptslot, bool apply)
{
                                                            //cycle all equipped items
    for (uint32 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        //enchants for the slot being socketed are handled by Player::ApplyItemMods
        if (slot == exceptslot)
            continue;

        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

        if (!pItem || !pItem->GetProto()->Socket[0].Color)
            continue;

        for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT+3; ++enchant_slot)
        {
            uint32 enchant_id = pItem->GetEnchantmentId(EnchantmentSlot(enchant_slot));
            if (!enchant_id)
                continue;

            SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
            if (!enchantEntry)
                continue;

            uint32 condition = enchantEntry->EnchantmentCondition;
            if (condition)
            {
                                                            //was enchant active with/without item?
                bool wasactive = EnchantmentFitsRequirements(condition, apply ? exceptslot : -1);
                                                            //should it now be?
                if (wasactive ^ EnchantmentFitsRequirements(condition, apply ? -1 : exceptslot))
                {
                    // ignore item gem conditions
                                                            //if state changed, (dis)apply enchant
                    ApplyEnchantment(pItem,EnchantmentSlot(enchant_slot),!wasactive,true,true);
                }
            }
        }
    }
}

                                                            //if false -> then toggled off if was on| if true -> toggled on if was off AND meets requirements
void Player::ToggleMetaGemsActive(uint8 exceptslot, bool apply)
{
    //cycle all equipped items
    for (int slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        //enchants for the slot being socketed are handled by WorldSession::HandleSocketOpcode(WorldPacket& recv_data)
        if (slot == exceptslot)
            continue;

        Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

        if (!pItem || !pItem->GetProto()->Socket[0].Color)   //if item has no sockets or no item is equipped go to next item
            continue;

        //cycle all (gem)enchants
        for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT+3; ++enchant_slot)
        {
            uint32 enchant_id = pItem->GetEnchantmentId(EnchantmentSlot(enchant_slot));
            if (!enchant_id)                                 //if no enchant go to next enchant(slot)
                continue;

            SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
            if (!enchantEntry)
                continue;

            //only metagems to be (de)activated, so only enchants with condition
            uint32 condition = enchantEntry->EnchantmentCondition;
            if (condition)
                ApplyEnchantment(pItem,EnchantmentSlot(enchant_slot), apply);
        }
    }
}

void Player::LeaveBattleground(bool teleportToEntryPoint)
{
    if (BattleGround *bg = GetBattleGround())
    {
        if (bg->isArena() && !isGameMaster())
        {
            SetVisibility(VISIBILITY_ON);
            SetFlying(false);

            GetCamera().ResetView(true);
        }

        if(bg->isArena() && bg->isRated() && bg->GetStatus() != STATUS_WAIT_LEAVE) //if game has not end then make sure that personal raiting is decreased
        {
            //decrease private raiting here
            Team Winner = GetTeam() == ALLIANCE ? HORDE : ALLIANCE;
            Team Looser = GetTeam() == ALLIANCE ? ALLIANCE : HORDE;
            ArenaTeam* WinnerTeam = sObjectMgr.GetArenaTeamById(bg->GetArenaTeamIdForTeam(Winner));
            ArenaTeam* LooserTeam = sObjectMgr.GetArenaTeamById(bg->GetArenaTeamIdForTeam(Looser));
            LooserTeam->MemberLost(this,WinnerTeam->GetStats().rating, 0);
        }
        bg->RemovePlayerAtLeave(GetGUID(), teleportToEntryPoint, true);

        if (bg->isBattleGround() && sWorld.getConfig(CONFIG_BATTLEGROUND_CAST_DESERTER))
            if (bg->GetStatus() == STATUS_IN_PROGRESS || bg->GetStatus() == STATUS_WAIT_JOIN)
                CastSpell(this, 26013, true);               // Deserter
    }
}

bool Player::CanJoinToBattleground() const
{
    // check Deserter debuff
    if (GetDummyAura(26013))
        return false;

    return true;
}

bool Player::CanReportAfkDueToLimit()
{
    // a player can complain about 15 people per 5 minutes
    if (m_bgAfkReportedCount >= 15)
        return false;
    ++m_bgAfkReportedCount;
    return true;
}

///This player has been blamed to be inactive in a battleground
void Player::ReportedAfkBy(Player* reporter)
{
    BattleGround *bg = GetBattleGround();
    if (!bg || bg != reporter->GetBattleGround() || GetBGTeam() != reporter->GetBGTeam())
        return;

    // check if player has 'Idle' or 'Inactive' debuff
    if (m_bgAfkReporter.find(reporter->GetGUIDLow()) == m_bgAfkReporter.end() && !HasAura(43680,0) && !HasAura(43681,0) && reporter->CanReportAfkDueToLimit())
    {
        m_bgAfkReporter.insert(reporter->GetGUIDLow());
        // 3 players have to complain to apply debuff
        if (m_bgAfkReporter.size() >= 3)
        {
            bool alive = isAlive();
            if (!alive)
                ResurrectPlayer(1.0f);

            // cast 'Idle' spell
            CastSpell(this, 43680, true);

            if (!alive)
                Kill(this, true);

            m_bgAfkReporter.clear();
        }
    }
}

bool Player::canSeeOrDetect(Unit const* u, WorldObject const* viewPoint, bool detect, bool inVisibleList, bool is3dDistance) const
{
    // Always can see self
    if (u == this)
        return true;

    if (u->GetObjectGuid().IsAnyTypeCreature() && u->ToCreature()->IsAIEnabled && !u->ToCreature()->AI()->IsVisible())
        return false;

    // player visible for other player if not logout and at same transport
    // including case when player is out of world
    bool at_same_transport =
        GetTransport() && u->GetTypeId() == TYPEID_PLAYER
        && !GetSession()->PlayerLogout() && !((Player*)u)->GetSession()->PlayerLogout()
        && !GetSession()->PlayerLoading() && !((Player*)u)->GetSession()->PlayerLoading()
        && GetTransport() == ((Player*)u)->GetTransport();

    // not in world
    if (!at_same_transport && (!IsInWorld() || !u->IsInWorld()))
        return false;

    // forbidden to seen (at GM respawn command)
    if (u->GetVisibility() == VISIBILITY_RESPAWN)
        return false;

    // always seen by owner
    if (GetGUID() == u->GetCharmerOrOwnerGUID())
        return true;

    Map& _map = *u->GetMap();
    // Grid dead/alive checks
    // non visible at grid for any stealth state
    if (!u->IsVisibleInGridForPlayer(this))
        return false;

    // different visible distance checks
    if (IsTaxiFlying())                                     // what see player in flight
    {
        if (!viewPoint->IsWithinDistInMap(u, _map.GetVisibilityDistance(const_cast<Unit*>(u), const_cast<Player*>(this)) + (inVisibleList ? World::GetVisibleObjectGreyDistance() : 0.0f), is3dDistance))
            return false;
    }
    else if (!u->isAlive())                                     // distance for show body
    {
        if (!viewPoint->IsWithinDistInMap(u, _map.GetVisibilityDistance(const_cast<Unit*>(u), const_cast<Player*>(this)) + (inVisibleList ? World::GetVisibleObjectGreyDistance() : 0.0f), is3dDistance))
            return false;
    }
    else if (u->GetTypeId()==TYPEID_PLAYER)                     // distance for show player
    {
        // Players far than max visible distance for player or not in our map are not visible too
        if (!at_same_transport && !viewPoint->IsWithinDistInMap(u, _map.GetVisibilityDistance(const_cast<Unit*>(u), const_cast<Player*>(this)) + (inVisibleList ? World::GetVisibleObjectGreyDistance() : 0.0f), is3dDistance))
            return false;
    }
    else if (u->GetCharmerOrOwnerGUID())                        // distance for show pet/charmed
    {
        // Pet/charmed far than max visible distance for player or not in our map are not visible too
        if (!viewPoint->IsWithinDistInMap(u, _map.GetVisibilityDistance(const_cast<Unit*>(u), const_cast<Player*>(this)) + (inVisibleList ? World::GetVisibleObjectGreyDistance() : 0.0f), is3dDistance))
            return false;
    }
    else                                                    // distance for show creature
    {
        // Units far than max visible distance for creature or not in our map are not visible too
        if (!viewPoint->IsWithinDistInMap(u, u->isActiveObject() ? (MAX_VISIBILITY_DISTANCE - (inVisibleList ? 0.0f : World::GetVisibleObjectGreyDistance()))
            : (_map.GetVisibilityDistance(const_cast<Unit*>(u), const_cast<Player*>(this)) + (inVisibleList ? World::GetVisibleObjectGreyDistance() : 0.0f))
            , is3dDistance))
            return false;
    }

    if (u->GetVisibility() == VISIBILITY_OFF)
    {
        // GMs see any players, not higher GMs and all units
        if (isGameMaster())
        {
            if (u->GetTypeId() == TYPEID_PLAYER)
                return ((Player *)u)->GetSession()->GetPermissions() <= GetSession()->GetPermissions();
            else
                return true;
        }
        return false;
    }

    // GM's can see everyone with invisibilitymask with less or equal security level
    if (m_invisibilityMask || u->m_invisibilityMask)
    {
        if (isGameMaster())
        {
            if (u->GetTypeId() == TYPEID_PLAYER)
                return ((Player*)u)->GetSession()->GetPermissions() <= GetSession()->GetPermissions();
            else
                return true;
        }

        // why do we need this?
        if (u->GetTypeId() == TYPEID_PLAYER && u->canDetectInvisibilityOf(this, ((Player*)u)->GetCamera().GetBody()))
            return true;

        // player see other player with stealth/invisibility only if he in same group or raid or same team (raid/team case dependent from conf setting)
        if (!canDetectInvisibilityOf(u, viewPoint))
            if (!(u->GetTypeId()==TYPEID_PLAYER && !IsHostileTo(u) && IsGroupVisiblefor(((Player*)u))))
                return false;
    }

    // GM invisibility checks early, invisibility if any detectable, so if not stealth then visible
    if (u->GetVisibility() == VISIBILITY_GROUP_STEALTH && !isGameMaster())
    {
        // if player is dead then he can't detect anyone in any cases
        //do not know what is the use of this detect
        // stealth and detected and visible for some seconds
        if (!isAlive())
            detect = false;
        if (m_DetectInvTimer < 300 || !HaveAtClient(u))
            if (!(u->GetTypeId()==TYPEID_PLAYER && !IsHostileTo(u) && IsGroupVisiblefor (((Player*)u))))
                if (!detect || !canDetectStealthOf(u, viewPoint, viewPoint->GetDistance(u)))
                    return false;
    }

    // If use this server will be too laggy
    // Now check is target visible with LoS
    //return u->IsWithinLOS(GetPositionX(),GetPositionY(),GetPositionZ());
    return true;
}

bool Player::IsVisibleInGridForPlayer(Player const * pl) const
{
    // gamemaster in GM mode see all, including ghosts
    if (pl->isGameMaster() && GetSession()->GetPermissions() <= pl->GetSession()->GetPermissions())
        return true;

    // It seems in battleground everyone sees everyone, except the enemy-faction ghosts
    if (InBattleGround())
    {
        if (!(isAlive() || m_deathTimer > 0) && !IsFriendlyTo(pl))
            return false;
        return true;
    }

    // Live player see live player or dead player with not realized corpse
    if (pl->isAlive() || pl->m_deathTimer > 0)
    {
        return isAlive() || m_deathTimer > 0;
    }

    // Ghost see other friendly ghosts, that's for sure
    if (!(isAlive() || m_deathTimer > 0) && IsFriendlyTo(pl))
        return true;

    // Dead player see live players near own corpse
    if (isAlive())
    {
        Corpse *corpse = pl->GetCorpse();
        if (corpse)
        {
            // 20 - aggro distance for same level, 25 - max additional distance if player level less that creature level
            if (corpse->IsWithinDistInMap(this,(20+25)*sWorld.getRate(RATE_CREATURE_AGGRO)))
                return true;
        }
    }

    // and not see any other
    return false;
}

bool Player::IsVisibleGloballyfor (Player* u) const
{
    if (!u)
        return false;

    // Always can see self
    if (u==this)
        return true;

    // Visible units, always are visible for all players
    if (GetVisibility() == VISIBILITY_ON)
        return true;

    // GMs are visible for higher gms (or players are visible for gms)
    if (u->GetSession()->HasPermissions(PERM_GMT))
        return GetSession()->GetPermissions() <= u->GetSession()->GetPermissions();

    // non faction visibility non-breakable for non-GMs
    if (GetVisibility() == VISIBILITY_OFF)
        return false;

    // non-gm stealth/invisibility not hide from global player lists
    return true;
}

template<class T>
inline void UpdateVisibilityOf_helper(std::set<uint64>& s64, T* target, std::set<WorldObject*>& v)
{
    s64.insert(target->GetGUID());
}

template<>
inline void UpdateVisibilityOf_helper(std::set<uint64>& s64, GameObject* target, std::set<WorldObject*>& v)
{
    if(!target->IsTransport())
        s64.insert(target->GetGUID());
}

template<>
inline void UpdateVisibilityOf_helper(std::set<uint64>& s64, Creature* target, std::set<WorldObject*>& v)
{
    s64.insert(target->GetGUID());
    v.insert(target);
}

template<>
inline void UpdateVisibilityOf_helper(std::set<uint64>& s64, Player* target, std::set<WorldObject*>& v)
{
    s64.insert(target->GetGUID());
    v.insert(target);
}

template<class T>
inline void BeforeVisibilityDestroy(T* /*t*/, Player* /*p*/)
{
}

template<>
inline void BeforeVisibilityDestroy<Creature>(Creature* t, Player* p)
{
    if (p->GetPetGUID() == t->GetGUID() && t->GetObjectGuid().IsPet())
        p->RemovePet(t->ToPet(), PET_SAVE_NOT_IN_SLOT, true);
}

void Player::UpdateVisibilityOf(WorldObject const* viewPoint, WorldObject* target)
{
    if (HaveAtClient(target))
    {
        if (!target->isVisibleForInState(this, viewPoint, true))
        {
            if (Creature* c = target->ToCreature())
                BeforeVisibilityDestroy<Creature>(c, this);

            target->DestroyForPlayer(this);
            m_clientGUIDs.erase(target->GetGUID());
        }
    }
    else
    {
        if (target->isVisibleForInState(this, viewPoint, false))
        {
            target->SendCreateUpdateToPlayer(this);
            if (!target->GetObjectGuid().IsTransport())
                m_clientGUIDs.insert(target->GetGUID());

            // target aura duration for caster show only if target exist at caster client
            // send data at target visibility change (adding to client)
            if (target->isType(TYPEMASK_UNIT))
                SendInitialVisiblePackets((Unit*)target);
        }
    }
}

void Player::RewardPlayerAndGroupAtEvent(uint32 creature_id, WorldObject* pRewardSource)
{
    uint64 creature_guid = pRewardSource->GetTypeId()==TYPEID_UNIT ? pRewardSource->GetGUID() : uint64(0);

    // prepare data for near group iteration
    if (Group *pGroup = GetGroup())
    {
        for (GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
        {
            Player* pGroupGuy = itr->getSource();
            if (!pGroupGuy)
                continue;

            if (!pGroupGuy->IsAtGroupRewardDistance(pRewardSource))
                continue;                               // member (alive or dead) or his corpse at req. distance

            // quest objectives updated only for alive group member or dead but with not released body
            if (pGroupGuy->isAlive()|| !pGroupGuy->GetCorpse())
                pGroupGuy->KilledMonster(creature_id, creature_guid);
        }
    }
    else                                                    // if (!pGroup)
        KilledMonster(creature_id, creature_guid);
}

void Player::SendInitialVisiblePackets(Unit* target)
{
    SendAuraDurationsForTarget(target);
    if (target->isAlive())
    {
        if (target->hasUnitState(UNIT_STAT_MELEE_ATTACKING) && target->getVictim())
            target->SendMeleeAttackStart(target->getVictim());
    }
}

template<class T>
void Player::UpdateVisibilityOf(WorldObject const* viewPoint, T* target, UpdateData& data, std::set<WorldObject*>& visibleNow)
{
    if (!target)
        return;

    if (HaveAtClient(target))
    {
        if (!target->isVisibleForInState(this, viewPoint, true))
        {
            target->BuildOutOfRangeUpdateBlock(&data);
            m_clientGUIDs.erase(target->GetGUID());
        }
    }
    else
    {
        if (target->isVisibleForInState(this, viewPoint, false))
        {
            target->BuildCreateUpdateBlockForPlayer(&data, this);
            UpdateVisibilityOf_helper(m_clientGUIDs, target, visibleNow);
        }
    }
}

template void Player::UpdateVisibilityOf(WorldObject const*, Player*       , UpdateData&, std::set<WorldObject*>&);
template void Player::UpdateVisibilityOf(WorldObject const*, Creature*     , UpdateData&, std::set<WorldObject*>&);
template void Player::UpdateVisibilityOf(WorldObject const*, Corpse*       , UpdateData&, std::set<WorldObject*>&);
template void Player::UpdateVisibilityOf(WorldObject const*, GameObject*   , UpdateData&, std::set<WorldObject*>&);
template void Player::UpdateVisibilityOf(WorldObject const*, DynamicObject*, UpdateData&, std::set<WorldObject*>&);

void Player::InitPrimaryProffesions()
{
    SetFreePrimaryProfessions(sWorld.getConfig(CONFIG_MAX_PRIMARY_TRADE_SKILL));
}

void Player::SendComboPoints()
{
    Unit *combotarget = GetMap()->GetUnit(m_comboTarget);
    if (combotarget)
    {
        WorldPacket data(SMSG_UPDATE_COMBO_POINTS, combotarget->GetPackGUID().size()+1);
        data << combotarget->GetPackGUID();
        data << uint8(m_comboPoints);
        SendPacketToSelf(&data);
    }
}

void Player::AddComboPoints(Unit* target, int8 count)
{
    if (!count)
        return;

    // without combo points lost (duration checked in aura)
    RemoveSpellsCausingAura(SPELL_AURA_RETAIN_COMBO_POINTS);

    if (target->GetGUID() == m_comboTarget)
    {
        m_comboPoints += count;
    }
    else
    {
        if (m_comboTarget)
            if (Unit* target2 = GetMap()->GetUnit(m_comboTarget))
                target2->RemoveComboPointHolder(GetGUIDLow());

        m_comboTarget = target->GetGUID();
        m_comboPoints = count;

        target->AddComboPointHolder(GetGUIDLow());
    }

    if (m_comboPoints > 5) m_comboPoints = 5;
    if (m_comboPoints < 0) m_comboPoints = 0;

    SendComboPoints();
}

void Player::ClearComboPoints()
{
    if (!m_comboTarget)
        return;

    // without combopoints lost (duration checked in aura)
    RemoveSpellsCausingAura(SPELL_AURA_RETAIN_COMBO_POINTS);

    m_comboPoints = 0;

    Unit* target = GetMap()->GetUnit(m_comboTarget);
    SendComboPoints();

    if (target)
        target->RemoveComboPointHolder(GetGUIDLow());

    m_comboTarget = 0;
}

void Player::SetGroup(Group *group, int8 subgroup)
{
    if (group == NULL)
        m_group.unlink();
    else
    {
        // never use SetGroup without a subgroup unless you specify NULL for group
        ASSERT(subgroup >= 0);
        m_group.link(group, this);
        m_group.setSubGroup((uint8)subgroup);
    }
}

void Player::SendInitialPacketsBeforeAddToMap()
{
    WorldPacket data(SMSG_SET_REST_START, 4);
    data << uint32(0);                                      // unknown, may be rest state time or experience
    SendPacketToSelf(&data);

    // Homebind
    data.Initialize(SMSG_BINDPOINTUPDATE, 5*4);
    data << m_homebindX << m_homebindY << m_homebindZ;
    data << (uint32) m_homebindMapId;
    data << (uint32) m_homebindZoneId;
    SendPacketToSelf(&data);

    // SMSG_SET_PROFICIENCY
    // SMSG_UPDATE_AURA_DURATION

    // tutorial stuff
    data.Initialize(SMSG_TUTORIAL_FLAGS, 8*4);
    for (int i = 0; i < 8; ++i)
        data << uint32(GetTutorialInt(i));
    SendPacketToSelf(&data);

    SendInitialSpells();

    data.Initialize(SMSG_SEND_UNLEARN_SPELLS, 4);
    data << uint32(0);                                      // count, for (count) uint32;
    SendPacketToSelf(&data);

    SendInitialActionButtons();

    m_reputationMgr.SendInitialReputations();

    UpdateZone(GetZoneId());
    SendInitWorldStates();

    // SMSG_SET_AURA_SINGLE

    data.Initialize(SMSG_LOGIN_SETTIMESPEED, 8);
    data << uint32(secsToTimeBitFields(sWorld.GetGameTime()));
    data << (float)0.01666667f;                             // game speed
    SendPacketToSelf(&data);

    // set fly flag if in fly form or taxi flight to prevent visually drop at ground in showup moment
    if (HasAuraType(SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED) || IsTaxiFlying())
        AddUnitMovementFlag(MOVEFLAG_FLYING);
}

class VisibilityAndViewUpdateEvent : public BasicEvent
{
    public:
        VisibilityAndViewUpdateEvent(Player& owner) : BasicEvent(), _owner(owner) {}

    bool Execute(uint64 /*e_time*/, uint32 /*p_time*/)
    {
        _owner.UpdateVisibilityAndView();
        return true;
    }

    private:
        Player& _owner;
};

void Player::SendInitialPacketsAfterAddToMap()
{
    // Delay visibility update by 5s after porting to new map

    UpdateVisibilityAndView();
    AddEvent(new VisibilityAndViewUpdateEvent(*this), 3000);

    ResetTimeSync();
    SendTimeSync();

    CastSpell(this, 836, true);                             // LOGINEFFECT

    // set some aura effects that send packet to player client after add player to map
    // SendMessageToSet not send it to player not it map, only for aura that not changed anything at re-apply
    // same auras state lost at far teleport, send it one more time in this case also
    static const AuraType auratypes[] =
    {
        SPELL_AURA_MOD_FEAR,     SPELL_AURA_TRANSFORM,                 SPELL_AURA_WATER_WALK,
        SPELL_AURA_FEATHER_FALL, SPELL_AURA_HOVER,                     SPELL_AURA_SAFE_FALL,
        SPELL_AURA_FLY,          SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED, SPELL_AURA_NONE
    };

    for (AuraType const* itr = &auratypes[0]; itr && itr[0] != SPELL_AURA_NONE; ++itr)
    {
        Unit::AuraList const& auraList = GetAurasByType(*itr);
        if (!auraList.empty())
            auraList.front()->ApplyModifier(true,true);
    }

    if (HasAuraType(SPELL_AURA_MOD_STUN))
        SetMovement(MOVE_ROOT);

    // manual send package (have code in ApplyModifier(true,true); that don't must be re-applied.
    if (HasAuraType(SPELL_AURA_MOD_ROOT))
    {
        WorldPacket data(SMSG_FORCE_MOVE_ROOT, 10);
        data << GetPackGUID();
        data << (uint32)2;
        BroadcastPacket(&data,true);
    }

    SendEnchantmentDurations();                             // must be after add to map
    SendItemDurations();                                    // must be after add to map
}

void Player::SendUpdateToOutOfRangeGroupMembers()
{
    if (m_groupUpdateMask == GROUP_UPDATE_FLAG_NONE)
        return;

    if (Group* group = GetGroup())
        group->UpdatePlayerOutOfRange(this);

    m_groupUpdateMask = GROUP_UPDATE_FLAG_NONE;
    m_auraUpdateMask = 0;
    if (Pet *pet = GetPet())
        pet->ResetAuraUpdateMask();
}

void Player::SendTransferAborted(uint32 mapid, uint16 reason)
{
    WorldPacket data(SMSG_TRANSFER_ABORTED, 4+2);
    data << uint32(mapid);
    data << uint16(reason);                                 // transfer abort reason
    SendPacketToSelf(&data);
}

void Player::SendInstanceResetWarning(uint32 mapid, uint32 time)
{
    // type of warning, based on the time remaining until reset
    uint32 type;
    if (time > 3600)
        type = RAID_INSTANCE_WELCOME;
    else if (time > 900 && time <= 3600)
        type = RAID_INSTANCE_WARNING_HOURS;
    else if (time > 300 && time <= 900)
        type = RAID_INSTANCE_WARNING_MIN;
    else
        type = RAID_INSTANCE_WARNING_MIN_SOON;
    WorldPacket data(SMSG_RAID_INSTANCE_MESSAGE, 4+4+4);
    data << uint32(type);
    data << uint32(mapid);
    data << uint32(time);
    SendPacketToSelf(&data);
}

void Player::ApplyEquipCooldown(Item * pItem)
{
    for (int i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
    {
        _Spell const& spellData = pItem->GetProto()->Spells[i];

        // no spell
        if (!spellData.SpellId)
            continue;

        // wrong triggering type (note: ITEM_SPELLTRIGGER_ON_NO_DELAY_USE not have cooldown)
        if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
            continue;

        AddSpellCooldown(spellData.SpellId, pItem->GetEntry(), time(NULL) + 30);

        WorldPacket data(SMSG_ITEM_COOLDOWN, 12);
        data << pItem->GetGUID();
        data << uint32(spellData.SpellId);
        SendPacketToSelf(&data);
    }
}

void Player::resetSpells()
{
    // not need after this call
    if (HasAtLoginFlag(AT_LOGIN_RESET_SPELLS))
    {
        m_atLoginFlags = m_atLoginFlags & ~AT_LOGIN_RESET_SPELLS;
        RealmDataDatabase.PExecute("UPDATE characters SET at_login = at_login & ~ %u WHERE guid ='%u'", uint32(AT_LOGIN_RESET_SPELLS), GetGUIDLow());
    }

    // make full copy of map (spells removed and marked as deleted at another spell remove
    // and we can't use original map for safe iterative with visit each spell at loop end
    PlayerSpellMap smap = GetSpellMap();

    for (PlayerSpellMap::const_iterator iter = smap.begin();iter != smap.end(); ++iter)
        removeSpell(iter->first);                           // only iter->first can be accessed, object by iter->second can be deleted already

    learnDefaultSpells();
    learnQuestRewardedSpells();
}

void Player::learnDefaultSpells(bool loading)
{
    // learn default race/class spells
    PlayerInfo const *info = sObjectMgr.GetPlayerInfo(getRace(),getClass());
    std::list<CreateSpellPair>::const_iterator spell_itr;
    for (spell_itr = info->spell.begin(); spell_itr!=info->spell.end(); ++spell_itr)
    {
        uint16 tspell = spell_itr->first;
        if (tspell)
        {
            sLog.outDebug("PLAYER: Adding initial spell, id = %u",tspell);
            if (loading || !spell_itr->second)               // not care about passive spells or loading case
                addSpell(tspell,spell_itr->second);
            else                                            // but send in normal spell in game learn case
                learnSpell(tspell);
        }
    }
}

void Player::learnQuestRewardedSpells(Quest const* quest)
{
    uint32 spell_id = quest->GetRewSpellCast();

    // skip quests without rewarded spell
    if (!spell_id)
        return;

    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spell_id);
    if (!spellInfo)
        return;

    // check learned spells state
    bool found = false;
    for (int i=0; i < 3; ++i)
    {
        if (spellInfo->Effect[i] == SPELL_EFFECT_LEARN_SPELL && !HasSpell(spellInfo->EffectTriggerSpell[i]))
        {
            found = true;
            break;
        }
    }

    // skip quests with not teaching spell or already known spell
    if (!found)
        return;

    // prevent learn non first rank unknown profession and second specialization for same profession)
    uint32 learned_0 = spellInfo->EffectTriggerSpell[0];
    if (sSpellMgr.GetSpellRank(learned_0) > 1 && !HasSpell(learned_0))
    {
        // not have first rank learned (unlearned prof?)
        uint32 first_spell = sSpellMgr.GetFirstSpellInChain(learned_0);
        if (!HasSpell(first_spell))
            return;

        SpellEntry const *learnedInfo = sSpellStore.LookupEntry(learned_0);
        if (!learnedInfo)
            return;

        // specialization
        if (learnedInfo->Effect[0]==SPELL_EFFECT_TRADE_SKILL && learnedInfo->Effect[1]==0)
        {
            // search other specialization for same prof
            for (PlayerSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
            {
                if (itr->second.state == PLAYERSPELL_REMOVED || itr->first==learned_0)
                    continue;

                SpellEntry const *itrInfo = sSpellStore.LookupEntry(itr->first);
                if (!itrInfo)
                    return;

                // compare only specializations
                if (itrInfo->Effect[0]!=SPELL_EFFECT_TRADE_SKILL || itrInfo->Effect[1]!=0)
                    continue;

                // compare same chain spells
                if (sSpellMgr.GetFirstSpellInChain(itr->first) != first_spell)
                    continue;

                // now we have 2 specialization, learn possible only if found is lesser specialization rank
                if (!sSpellMgr.IsHighRankOfSpell(learned_0,itr->first))
                    return;
            }
        }
    }

    CastSpell(this, spell_id, true);
}

void Player::learnQuestRewardedSpells()
{
    // learn spells received from quest completing
    for (QuestStatusMap::const_iterator itr = mQuestStatus.begin(); itr != mQuestStatus.end(); ++itr)
    {
        // skip no rewarded quests
        if (!itr->second.m_rewarded)
            continue;

        Quest const* quest = sObjectMgr.GetQuestTemplate(itr->first);
        if (!quest)
            continue;

        learnQuestRewardedSpells(quest);
    }
}

void Player::learnSkillRewardedSpells(uint32 skill_id)
{
    uint32 raceMask  = getRaceMask();
    uint32 classMask = getClassMask();
    for (uint32 j=0; j<sSkillLineAbilityStore.GetNumRows(); ++j)
    {
        SkillLineAbilityEntry const *pAbility = sSkillLineAbilityStore.LookupEntry(j);
        if (!pAbility || pAbility->skillId!=skill_id || pAbility->learnOnGetSkill != ABILITY_LEARNED_ON_GET_PROFESSION_SKILL)
            continue;
        // Check race if set
        if (pAbility->racemask && !(pAbility->racemask & raceMask))
            continue;
        // Check class if set
        if (pAbility->classmask && !(pAbility->classmask & classMask))
            continue;

        if (sSpellStore.LookupEntry(pAbility->spellId))
        {
            // Ok need learn spell
            learnSpell(pAbility->spellId);
        }
    }
}

void Player::learnSkillRewardedSpells()
{
    for (uint16 i=0; i < PLAYER_MAX_SKILLS; i++)
    {
        if (!GetUInt32Value(PLAYER_SKILL_INDEX(i)))
            continue;

        uint32 pskill = GetUInt32Value(PLAYER_SKILL_INDEX(i)) & 0x0000FFFF;

        learnSkillRewardedSpells(pskill);
    }
}

void Player::SendAuraDurationsForTarget(Unit* target)
{
    for (Unit::AuraMap::const_iterator itr = target->GetAuras().begin(); itr != target->GetAuras().end(); ++itr)
    {
        Aura* aura = itr->second;
        if (aura->GetAuraSlot() >= MAX_AURAS || aura->IsPassive() || aura->GetCasterGUID()!=GetGUID())
            continue;

        aura->SendAuraDurationForCaster(this);
    }
}

void Player::SetDailyQuestStatus(uint32 quest_id)
{
    for (uint32 quest_daily_idx = 0; quest_daily_idx < sWorld.getConfig(CONFIG_DAILY_MAX_PER_DAY); ++quest_daily_idx)
    {
        if (!GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1+quest_daily_idx))
        {
            SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1+quest_daily_idx,quest_id);
            m_lastDailyQuestTime = time(NULL);              // last daily quest time
            m_DailyQuestChanged = true;
            break;
        }
    }
}

void Player::ResetDailyQuestStatus()
{
    for (uint32 quest_daily_idx = 0; quest_daily_idx < sWorld.getConfig(CONFIG_DAILY_MAX_PER_DAY); ++quest_daily_idx)
        SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1+quest_daily_idx,0);

    // DB data deleted in caller
    m_DailyQuestChanged = false;
    m_lastDailyQuestTime = 0;
}

BattleGround* Player::GetBattleGround() const
{
    if (GetBattleGroundId() == 0)
        return NULL;

    return sBattleGroundMgr.GetBattleGround(GetBattleGroundId(), m_bgTypeID);
}

bool Player::InArena() const
{
    BattleGround *bg = GetBattleGround();
    if (!bg || !bg->isArena())
        return false;

    return true;
}

bool Player::GetBGAccessByLevel(BattleGroundTypeId bgTypeId) const
{
    // get a template bg instead of running one
    BattleGround *bg = sBattleGroundMgr.GetBattleGroundTemplate(bgTypeId);
    if (!bg)
        return false;

    if (getLevel() < bg->GetMinLevel() || getLevel() > bg->GetMaxLevel())
        return false;

    return true;
}

uint32 Player::GetMinLevelForBattleGroundBracketId(BattleGroundBracketId bracket_id, BattleGroundTypeId bgTypeId)
{
    if (bracket_id < 1)
        return 0;

    if (bracket_id > BG_BRACKET_ID_LAST)
        bracket_id = BG_BRACKET_ID_LAST;

    BattleGround *bg = sBattleGroundMgr.GetBattleGroundTemplate(bgTypeId);
    ASSERT(bg);
    return 10 * bracket_id + bg->GetMinLevel();
}

uint32 Player::GetMaxLevelForBattleGroundBracketId(BattleGroundBracketId bracket_id, BattleGroundTypeId bgTypeId)
{
    if (bracket_id >= BG_BRACKET_ID_LAST)
        return 255;                                         // hardcoded max level

    return GetMinLevelForBattleGroundBracketId(bracket_id, bgTypeId) + 10;
}

Creature* Player::GetBGCreature(uint32 type)
{
    if (BattleGround* pBG = GetBattleGround())
        return pBG->GetBGCreature(type);

    return NULL;
}

float Player::GetReputationPriceDiscount(Creature const* pCreature) const
{
    FactionTemplateEntry const* vendor_faction = pCreature->getFactionTemplateEntry();
    if (!vendor_faction || !vendor_faction->faction)
        return 1.0f;

    ReputationRank rank = m_reputationMgr.GetRank(vendor_faction->faction);
    if (rank <= REP_NEUTRAL)
        return 1.0f;

    return 1.0f - 0.05f* (rank - REP_NEUTRAL);
}

bool Player::IsSpellFitByClassAndRace(uint32 spell_id) const
{
    uint32 racemask  = getRaceMask();
    uint32 classmask = getClassMask();

    SkillLineAbilityMap::const_iterator lower = sSpellMgr.GetBeginSkillLineAbilityMap(spell_id);
    SkillLineAbilityMap::const_iterator upper = sSpellMgr.GetEndSkillLineAbilityMap(spell_id);

    for (SkillLineAbilityMap::const_iterator _spell_idx = lower; _spell_idx != upper; ++_spell_idx)
    {
        // skip wrong race skills
        if (_spell_idx->second->racemask && (_spell_idx->second->racemask & racemask) == 0)
            return false;

        // skip wrong class skills
        if (_spell_idx->second->classmask && (_spell_idx->second->classmask & classmask) == 0)
            return false;
    }
    return true;
}

bool Player::HasQuestForGO(int32 GOId) const
{
    for (int i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = GetQuestSlotQuestId(i);
        if (questid == 0)
            continue;

        QuestStatusMap::const_iterator qs_itr = mQuestStatus.find(questid);
        if (qs_itr == mQuestStatus.end())
            continue;

        QuestStatusData const& qs = qs_itr->second;

        if (qs.m_status == QUEST_STATUS_INCOMPLETE)
        {
            Quest const* qinfo = sObjectMgr.GetQuestTemplate(questid);
            if (!qinfo)
                continue;

            if (GetGroup() && GetGroup()->isRaidGroup() && qinfo->GetType() != QUEST_TYPE_RAID)
                continue;

            for (int j = 0; j < QUEST_OBJECTIVES_COUNT; j++)
            {
                if (qinfo->ReqCreatureOrGOId[j]>=0)         //skip non GO case
                    continue;

                if ((-1)*GOId == qinfo->ReqCreatureOrGOId[j] && qs.m_creatureOrGOcount[j] < qinfo->ReqCreatureOrGOCount[j])
                    return true;
            }
        }
    }
    return false;
}

void Player::UpdateForQuestsGO()
{
    if (m_clientGUIDs.empty())
        return;

    UpdateData udata;
    WorldPacket packet;
    for (ClientGUIDs::iterator itr=m_clientGUIDs.begin(); itr!=m_clientGUIDs.end(); ++itr)
    {
        if (IS_GAMEOBJECT_GUID(*itr))
        {
            GameObject *obj = GetMap()->GetGameObject(*itr);
            if (obj)
                obj->BuildValuesUpdateBlockForPlayer(&udata,this);
        }
    }
    udata.BuildPacket(&packet);
    SendPacketToSelf(&packet);
}

bool Player::CanBeSummonedBy(const Unit * summoner)
{
    if (!summoner)
        return false;

    // if summoning to instance
    if (summoner->GetMap()->IsDungeon())
    {
        // check for permbinded id's
        InstanceSave * tmpInst = GetInstanceSave(summoner->GetMapId());
        if (tmpInst)
        {
            if (tmpInst->GetInstanceId() != summoner->GetInstanceId())
                return false;
        }
        // check for temp id's
        else if (GetMap()->IsDungeon() && GetMapId() == summoner->GetMapId() && GetInstanceId() != summoner->GetInstanceId())
            return false;
    }

    return true;
}

bool Player::CanBeSummonedBy(uint64 summoner)
{
    return CanBeSummonedBy(GetUnit(summoner));
}

void Player::SummonIfPossible(bool agree, uint64 summonerGUID)
{
    Unit* summoner = GetUnit(summonerGUID);
    if (summoner)
    {
        if (summoner->m_currentSpells[CURRENT_CHANNELED_SPELL])
        {
            summoner->m_currentSpells[CURRENT_CHANNELED_SPELL]->SendChannelUpdate(0);
            summoner->m_currentSpells[CURRENT_CHANNELED_SPELL]->finish();
        }

        if (!CanBeSummonedBy(summoner))
            return;
    }

    if (!agree)
    {
        m_summon_expire = 0;
        return;
    }

    // expire and auto declined
    if (m_summon_expire < time(NULL))
        return;

    // stop taxi flight at summon
    InterruptTaxiFlying();

    // drop flag at summon
    if (BattleGround *bg = GetBattleGround())
        bg->EventPlayerDroppedFlag(this);

    m_summon_expire = 0;

    TeleportTo(m_summon_mapid, m_summon_x, m_summon_y, m_summon_z,GetOrientation());
}

void Player::RemoveItemDurations(Item *item)
{
    for (ItemDurationList::iterator itr = m_itemDuration.begin();itr != m_itemDuration.end(); ++itr)
    {
        if (*itr==item)
        {
            m_itemDuration.erase(itr);
            break;
        }
    }
}

void Player::AddItemDurations(Item *item)
{
    if (item->GetUInt32Value(ITEM_FIELD_DURATION))
    {
        m_itemDuration.push_back(item);
        item->SendTimeUpdate(this);
    }
}

void Player::AutoUnequipOffhandIfNeed()
{
    Item *offItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
    if (!offItem)
        return;

    Item *mainItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);

    if (!mainItem || mainItem->GetProto()->InventoryType != INVTYPE_2HWEAPON)
        return;

    ItemPosCountVec off_dest;
    uint8 off_msg = CanStoreItem(NULL_BAG, NULL_SLOT, off_dest, offItem, false);
    if (off_msg == EQUIP_ERR_OK)
    {
        RemoveItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
        StoreItem(off_dest, offItem, true);
    }
    else
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player::EquipItem: Can's store offhand item at 2hand item equip for player (GUID: %u).",GetGUIDLow());
    }
}

OutdoorPvP * Player::GetOutdoorPvP() const
{
    return sOutdoorPvPMgr.GetOutdoorPvPToZoneId(GetCachedZone());
}

bool Player::HasItemFitToSpellReqirements(SpellEntry const* spellInfo, Item const* ignoreItem)
{
    if (spellInfo->EquippedItemClass < 0)
        return true;

    // scan other equipped items for same requirements (mostly 2 daggers/etc)
    // for optimize check 2 used cases only
    switch (spellInfo->EquippedItemClass)
    {
        case ITEM_CLASS_WEAPON:
        {
            for (int i= EQUIPMENT_SLOT_MAINHAND; i < EQUIPMENT_SLOT_TABARD; ++i)
                if (Item *item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                    if (item!=ignoreItem && item->IsFitToSpellRequirements(spellInfo))
                        return true;
            break;
        }
        case ITEM_CLASS_ARMOR:
        {
            // tabard not have dependent spells
            for (int i= EQUIPMENT_SLOT_START; i< EQUIPMENT_SLOT_MAINHAND; ++i)
                if (Item *item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                    if (item!=ignoreItem && item->IsFitToSpellRequirements(spellInfo))
                        return true;

            // shields can be equipped to offhand slot
            if (Item *item = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND))
                if (item!=ignoreItem && item->IsFitToSpellRequirements(spellInfo))
                    return true;

            // ranged slot can have some armor subclasses
            if (Item *item = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED))
                if (item!=ignoreItem && item->IsFitToSpellRequirements(spellInfo))
                    return true;

            break;
        }
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: HasItemFitToSpellReqirements: Not handled spell requirement for item class %u",spellInfo->EquippedItemClass);
            break;
    }

    return false;
}

bool Player::CanNoReagentCast(SpellEntry const* spellInfo) const
{
    // don't take reagents for spells with SPELL_ATTR_EX5_NO_REAGENT_WHILE_PREP
    if (spellInfo->AttributesEx5 & SPELL_ATTR_EX5_NO_REAGENT_WHILE_PREP &&
        HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PREPARATION))
        return true;

    return false;
}

void Player::RemoveItemDependentAurasAndCasts(Item * pItem)
{
    AuraMap& auras = GetAuras();
    for (AuraMap::iterator itr = auras.begin(); itr != auras.end();)
    {
        Aura* aura = itr->second;

        // skip passive (passive item dependent spells work in another way) and not self applied auras
        SpellEntry const* spellInfo = aura->GetSpellProto();
        if (aura->IsPassive() ||  aura->GetCasterGUID()!=GetGUID())
        {
            ++itr;
            continue;
        }

        // skip if not item dependent or have alternative item
        if (HasItemFitToSpellReqirements(spellInfo,pItem))
        {
            ++itr;
            continue;
        }

        // no alt item, remove aura, restart check
        RemoveAurasDueToSpell(aura->GetId());
        itr = auras.begin();
    }

    // currently casted spells can be dependent from item
    for (uint32 i = 0; i < CURRENT_MAX_SPELL; i++)
    {
        if (m_currentSpells[i] && m_currentSpells[i]->getState()!=SPELL_STATE_DELAYED &&
            !HasItemFitToSpellReqirements(m_currentSpells[i]->GetSpellInfo(),pItem))
            InterruptSpell(i);
    }
}

uint32 Player::GetResurrectionSpellId()
{
    // search priceless resurrection possibilities
    uint32 prio = 0;
    uint32 spell_id = 0;
    AuraList const& dummyAuras = GetAurasByType(SPELL_AURA_DUMMY);
    for (AuraList::const_iterator itr = dummyAuras.begin(); itr != dummyAuras.end(); ++itr)
    {
        // Soulstone Resurrection                           // prio: 3 (max, non death persistent)
        if (prio < 2 && (*itr)->GetSpellProto()->SpellVisual == 99 && (*itr)->GetSpellProto()->SpellIconID == 92)
        {
            switch ((*itr)->GetId())
            {
                case 20707: spell_id =  3026; break;        // rank 1
                case 20762: spell_id = 20758; break;        // rank 2
                case 20763: spell_id = 20759; break;        // rank 3
                case 20764: spell_id = 20760; break;        // rank 4
                case 20765: spell_id = 20761; break;        // rank 5
                case 27239: spell_id = 27240; break;        // rank 6
                default:
                    sLog.outLog(LOG_DEFAULT, "ERROR: Unhandled spell %%u: S.Resurrection",(*itr)->GetId());
                    continue;
            }

            prio = 3;
        }
        // Twisting Nether                                  // prio: 2 (max)
        else if ((*itr)->GetId()==23701 && roll_chance_i(10))
        {
            prio = 2;
            spell_id = 23700;
        }
    }

    // Reincarnation (passive spell)                        // prio: 1
    if (prio < 1 && HasSpell(20608) && !HasSpellCooldown(21169) && HasItemCount(17030,1))
        spell_id = 21169;

    return spell_id;
}

bool Player::RewardPlayerAndGroupAtKill(Unit* pVictim)
{
    bool PvP = pVictim->isCharmedOwnedByPlayerOrPlayer();

    // prepare data for near group iteration (PvP and !PvP cases)
    uint32 xp = 0;
    bool honored_kill = false;

    if (Group *pGroup = GetGroup())
    {
        uint32 count = 0;
        uint32 sum_level = 0;
        Player* member_with_max_level = NULL;
        Player* not_gray_member_with_max_level = NULL;

        pGroup->GetDataForXPAtKill(pVictim,count,sum_level,member_with_max_level,not_gray_member_with_max_level);

        if (member_with_max_level)
        {
            // PvP kills doesn't yield experience
            // also no XP gained if there is no member below gray level
            xp = (PvP || !not_gray_member_with_max_level) ? 0 : Looking4group::XP::Gain(not_gray_member_with_max_level, pVictim);

            /// skip in check PvP case (for speed, not used)
            bool is_raid = PvP ? false : sMapStore.LookupEntry(GetMapId())->IsRaid() && pGroup->isRaidGroup();
            bool is_dungeon = PvP ? false : sMapStore.LookupEntry(GetMapId())->IsDungeon();
            float group_rate = Looking4group::XP::xp_in_group_rate(count,is_raid);

            for (GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
            {
                Player* pGroupGuy = itr->getSource();
                if (!pGroupGuy)
                    continue;

                if (!pGroupGuy->IsAtGroupRewardDistance(pVictim))
                    continue;                               // member (alive or dead) or his corpse at req. distance

                // honor can be in PvP and !PvP (racial leader) cases (for alive)
                if (pGroupGuy->isAlive() && pGroupGuy->RewardHonor(pVictim,count, -1, true, pGroupGuy == this) && pGroupGuy==this)
                    honored_kill = true;

                // xp and reputation only in !PvP case
                if (!PvP)
                {
                    float rate = group_rate * float(pGroupGuy->getLevel()) / sum_level;

                    // if is in dungeon then all receive full reputation at kill
                    // rewarded any alive/dead/near_corpse group member
                    pGroupGuy->RewardReputation(pVictim,is_dungeon ? 1.0f : rate);

                    // XP updated only for alive group member
                    if (pGroupGuy->isAlive() && not_gray_member_with_max_level &&
                       pGroupGuy->getLevel() <= not_gray_member_with_max_level->getLevel())
                    {
                        uint32 itr_xp = (member_with_max_level == not_gray_member_with_max_level) ? uint32(xp*rate) : uint32((xp*rate/2)+1);

                        pGroupGuy->GiveXP(itr_xp, pVictim);
                        if (Pet* pet = pGroupGuy->GetPet())
                            pet->GivePetXP(itr_xp/2);
                    }

                    // quest objectives updated only for alive group member or dead but with not released body
                    if (pGroupGuy->isAlive()|| !pGroupGuy->GetCorpse())
                    {
                        // normal creature (not pet/etc) can be only in !PvP case
                        if (pVictim->GetTypeId() == TYPEID_UNIT)
                        {
                            pGroupGuy->KilledMonster(pVictim->GetEntry(), pVictim->GetGUID());

                            if (uint32 KillCredit = ((Creature*)pVictim)->GetCreatureInfo()->KillCredit)
                                pGroupGuy->KilledMonster(KillCredit, pVictim->GetGUID());
                        }
                    }
                }
            }
        }
    }
    else                                                    // if (!pGroup)
    {
        xp = PvP ? 0 : Looking4group::XP::Gain(this, pVictim);

        // honor can be in PvP and !PvP (racial leader) cases
        if (RewardHonor(pVictim,1, -1, true))
            honored_kill = true;

        // xp and reputation only in !PvP case
        if (!PvP)
        {
            RewardReputation(pVictim,1);
            GiveXP(xp, pVictim);

            if (Pet* pet = GetPet())
                pet->GivePetXP(xp);

            //Custom case: If gaining of xp is freezed pet should get custom xp
            if (StopLevel(GetGUID()))
            {
               xp = Looking4group::XP::BaseGain(getLevel(), pVictim->getLevel(), GetContentLevelsForMapAndZone(pVictim->GetMapId(), pVictim->GetZoneId()));
               xp *= sWorld.getRate(RATE_XP_KILL); 
               if (Pet* pet = GetPet())
                    pet->GivePetXP(xp*2);
               xp = 0;
            }

            // normal creature (not pet/etc) can be only in !PvP case
            if (pVictim->GetTypeId()==TYPEID_UNIT)
            {
                KilledMonster(pVictim->GetEntry(),pVictim->GetGUID());

                if (uint32 KillCredit = ((Creature*)pVictim)->GetCreatureInfo()->KillCredit)
                    KilledMonster(KillCredit, pVictim->GetGUID());
            }
        }
    }
    return xp || honored_kill;
}

bool Player::IsAtGroupRewardDistance(WorldObject const* pRewardSource) const
{
    WorldObject const* player = GetCorpse();
    if (!player || isAlive())
        player = this;

    if (player->GetMapId() != pRewardSource->GetMapId() || player->GetInstanceId() != pRewardSource->GetInstanceId())
        return false;

    return pRewardSource->GetDistance(player) <= sWorld.getConfig(CONFIG_GROUP_XP_DISTANCE);
}

uint32 Player::GetBaseWeaponSkillValue (WeaponAttackType attType) const
{
    Item* item = GetWeaponForAttack(attType,true);

    // unarmed only with base attack
    if (attType != BASE_ATTACK && !item)
        return 0;

    // weapon skill or (unarmed for base attack)
    uint32  skill = (item && item->GetSkill() != SKILL_FIST_WEAPONS) ? item->GetSkill() : uint32(SKILL_UNARMED);
    return GetBaseSkillValue(skill);
}

void Player::ResurectUsingRequestData()
{
    SpawnCorpseBones();

    /// Teleport before resurrecting by player, otherwise the player might get attacked from creatures near his corpse
    if (IS_PLAYER_GUID(m_resurrectGUID))
        TeleportTo(m_resurrectMap, m_resurrectX, m_resurrectY, m_resurrectZ, GetOrientation());

    ResurrectPlayer(0.0f,false);

    if (GetMaxHealth() > m_resurrectHealth)
        SetHealth(m_resurrectHealth);
    else
        SetHealth(GetMaxHealth());

    if (GetMaxPower(POWER_MANA) > m_resurrectMana)
        SetPower(POWER_MANA, m_resurrectMana);
    else
        SetPower(POWER_MANA, GetMaxPower(POWER_MANA));

    SetPower(POWER_RAGE, 0);

    SetPower(POWER_ENERGY, GetMaxPower(POWER_ENERGY));
}

void Player::SetClientControl(Unit* target, uint8 allowMove)
{
    if (target->GetObjectGuid().IsPlayer())
    {
        if (allowMove && this == target && target->isPossessed())
            return;
    }

    WorldPacket data(SMSG_CLIENT_CONTROL_UPDATE, target->GetPackGUID().size()+1);
    data << target->GetPackGUID();
    data << uint8(allowMove);
    SendPacketToSelf(&data);
}

void Player::UpdateZoneDependentAuras(uint32 newZone)
{
    // remove new continent flight forms
    if (!isGameMaster() &&
    GetVirtualMapForMapAndZone(GetMapId(),newZone) != 530)
    {
        RemoveSpellsCausingAura(SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED);
        RemoveSpellsCausingAura(SPELL_AURA_FLY);
    }

    // Some spells applied at enter into zone (with subzones)
    // Human Illusion
    // NOTE: these are removed by RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CHANGE_MAP);
    if (newZone == 2367)                                  // Old Hillsbrad Foothills
    {
        uint32 spellid = 0;
        // all horde races
        if (GetTeam() == HORDE)
            spellid = (getGender() == GENDER_FEMALE ? 35481 : 35480);
        // and some alliance races
        else if (getRace() == RACE_NIGHTELF || getRace() == RACE_DRAENEI)
            spellid = (getGender() == GENDER_FEMALE ? 35483 : 35482);

        if (spellid && !HasAura(spellid,0))
            CastSpell(this,spellid,true);
    }
}

void Player::UpdateAreaDependentAuras(uint32 newArea)
{
    // remove auras from spells with area limitations
    for (AuraMap::iterator iter = m_Auras.begin(); iter != m_Auras.end();)
    {
        // use m_zoneUpdateId for speed: UpdateArea called from UpdateZone or instead UpdateZone in both cases m_zoneUpdateId up-to-date
        if (!SpellMgr::IsSpellAllowedInLocation(iter->second->GetSpellProto(),GetMapId(),m_zoneUpdateId,newArea))
        {
            for (uint8 i = 0; i < 3; ++i)
            {
                if (iter->second->GetSpellProto()->Effect[i] == SPELL_EFFECT_TRIGGER_SPELL && HasAura(iter->second->GetSpellProto()->EffectTriggerSpell[i],0))
                    RemoveAurasDueToSpell(iter->second->GetSpellProto()->EffectTriggerSpell[i]);
            }
            if (sSpellMgr.GetSpellElixirMask(iter->second->GetSpellProto()->Id) & ELIXIR_SHATTRATH_MASK)        // for shattrath flasks we want only to remove it's triggered effect, not flask itself.
                iter++;
            else
                RemoveAura(iter);
        }
        else
        {
            // reapply bonus for shattrath flask if we are back in allowed location
            if (sSpellMgr.GetSpellElixirMask(iter->second->GetSpellProto()->Id) & ELIXIR_SHATTRATH_MASK)
            {
                if (iter->second->GetSpellProto()->Effect[1] == SPELL_EFFECT_TRIGGER_SPELL &&  // always true for shattrath flasks, check it anyway
                        !HasAura(iter->second->GetSpellProto()->EffectTriggerSpell[1],0))
                {
                    CastSpell(this, iter->second->GetSpellProto()->EffectTriggerSpell[1], true);
                }
            }
            ++iter;
        }
    }

    switch (newArea)
    {
        // unmount if enter in this subzone
        case 35:
            RemoveSpellsCausingAura(SPELL_AURA_MOUNTED);
            break;
        // Dragonmaw Illusion
        case 3759:
        case 3966:
        case 3939:
        case 3965:
        case 3967:
            if (GetDummyAura(40214))
            {
                if (!HasAura(40216,0))
                    CastSpell(this, 40216, true);
                if (!HasAura(42016,0))
                    CastSpell(this, 42016, true);
            }
            break;
    }
}

uint32 Player::GetCorpseReclaimDelay(bool pvp) const
{
    if (pvp)
    {
        if (!sWorld.getConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP))
            return copseReclaimDelay[0];
    }
    else if (!sWorld.getConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE))
        return 0;

    time_t now = time(NULL);
    // 0..2 full period
    // should be ceil(x)-1 but not floor(x)
    uint32 count = (now < m_deathExpireTime - 1) ? (m_deathExpireTime - 1 - now)/DEATH_EXPIRE_STEP : 0;
    return copseReclaimDelay[count];
}

void Player::UpdateCorpseReclaimDelay()
{
    bool pvp = m_ExtraFlags & PLAYER_EXTRA_PVP_DEATH;

    if (pvp && !sWorld.getConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP) ||
        !pvp && !sWorld.getConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE))
        return;

    time_t now = time(NULL);
    if (now < m_deathExpireTime)
    {
        // full and partly periods 1..3
        uint32 count = (m_deathExpireTime - now)/DEATH_EXPIRE_STEP +1;
        if (count < MAX_DEATH_COUNT)
            m_deathExpireTime = now+(count+1)*DEATH_EXPIRE_STEP;
        else
            m_deathExpireTime = now+MAX_DEATH_COUNT*DEATH_EXPIRE_STEP;
    }
    else
        m_deathExpireTime = now+DEATH_EXPIRE_STEP;
}

void Player::SendCorpseReclaimDelay(bool load)
{
    Corpse* corpse = GetCorpse();
    if (load && !corpse)
        return;

    bool pvp;
    if (corpse)
        pvp = (corpse->GetType() == CORPSE_RESURRECTABLE_PVP);
    else
        pvp = (m_ExtraFlags & PLAYER_EXTRA_PVP_DEATH);

    uint32 delay;
    if (load)
    {
        if (corpse->GetGhostTime() > m_deathExpireTime)
            return;

        uint32 count;
        if (pvp && sWorld.getConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP) ||
           !pvp && sWorld.getConfig(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE))
        {
            count = (m_deathExpireTime-corpse->GetGhostTime())/DEATH_EXPIRE_STEP;
            if (count>=MAX_DEATH_COUNT)
                count = MAX_DEATH_COUNT-1;
        }
        else
            count=0;

        time_t expected_time = corpse->GetGhostTime()+copseReclaimDelay[count];

        time_t now = time(NULL);
        if (now >= expected_time)
            return;

        delay = expected_time-now;
    }
    else
        delay = GetCorpseReclaimDelay(pvp);

    if (!delay) return;

    //! corpse reclaim delay 30 * 1000ms or longer at often deaths
    WorldPacket data(SMSG_CORPSE_RECLAIM_DELAY, 4);
    data << uint32(delay*1000);
    SendPacketToSelf(&data);
}

PartyResult Player::CanUninviteFromGroup() const
{
    const Group* grp = GetGroup();
    if (!grp)
        return PARTY_RESULT_YOU_NOT_IN_GROUP;

    if (!grp->IsLeader(GetGUID()) && !grp->IsAssistant(GetGUID()))
        return PARTY_RESULT_YOU_NOT_LEADER;

    if (InBattleGround())
        return PARTY_RESULT_INVITE_RESTRICTED;

    return PARTY_RESULT_OK;
}

void Player::LFGAttemptJoin()
{
    // skip autojoin disabled and player in group cases
    if (m_lookingForGroup.canAutoJoin() || GetGroup())
        return;

    bool found = false;
    std::list<uint64> fullList;

    LfgContainerType & lfgContainer = sWorld.GetLfgContainer(GetTeam());
    for (uint8 i = 0; i < MAX_LOOKING_FOR_GROUP_SLOT; ++i)
    {
        // skip empty slot
        if (m_lookingForGroup.slots[i].Empty())
            continue;

        LfgContainerType::const_accessor a; // const_accessor -> write lock only

        // skip if container doesn't exist
        if (!lfgContainer.find(a, m_lookingForGroup.slots[i].Combine()))
            continue;

        for (std::list<uint64>::const_iterator itr = a->second.begin(); itr != a->second.end(); ++itr)
        {
            // skip self
            if ((*itr) == GetGUID())
                continue;

            Player * plr = ObjectAccessor::GetPlayer(*itr);

            // skip not existed
            if (!plr)
                continue;

            if (!plr->IsInWorld())
                continue;

             // skip not auto add, not group leader cases
            if (!plr->GetSession()->LookingForGroup_auto_add || plr->GetGroup() && plr->GetGroup()->GetLeaderGUID()!=plr->GetGUID())
                continue;

            // skip non auto-join or empty slots, or non compatible slots
            if (!plr->m_lookingForGroup.more.canAutoJoin() || !m_lookingForGroup.HaveInSlot(plr->m_lookingForGroup.more))
                continue;

            // attempt create group, or skip
            if (!plr->GetGroup())
            {
                Group* group = new Group;
                if (!group->Create(plr->GetGUID(), plr->GetName(), true))
                {
                    delete group;
                    continue;
                }

                sObjectMgr.AddGroup(group);
            }

            // stop at success join
            if (plr->GetGroup()->AddMember(GetGUID(), GetName(), true))
            {
                LeaveLFGChannel();
                found = true;
                break;
            }
            // full
            else
            {
                plr->LeaveLFGChannel();

                fullList.push_back(*itr);
            }
        }
    }

    if (found)
    {
        ClearLFG();
        ClearLFM();
    }

    for (std::list<uint64>::const_iterator itr = fullList.begin(); itr != fullList.end(); ++itr)
    {
        Player * plr = ObjectAccessor::GetPlayer(*itr);

        if (!plr)
            continue;

        plr->ClearLFM();
    }
}

void Player::LFMAttemptAddMore()
{
     // skip not group leader case
    if (GetGroup() && GetGroup()->GetLeaderGUID() != GetGUID())
        return;

    // skip not autojoin and empty cases
    if (!m_lookingForGroup.more.canAutoJoin() || m_lookingForGroup.more.Empty())
        return;

    LfgContainerType::const_accessor a;

    // get player container for LFM id
    LfgContainerType & lfgContainer = sWorld.GetLfgContainer(GetTeam());
    if (!lfgContainer.find(a, m_lookingForGroup.more.Combine()))
        return;

    std::list<uint64> joinedList;

    for (std::list<uint64>::const_iterator iter = a->second.begin(); iter != a->second.end(); ++iter)
    {
        Player *plr = ObjectAccessor::GetPlayer(*iter);

        if (!plr || !plr->IsInWorld())
            continue;

        // skip self
        if (plr->GetGUID() == GetGUID())
            continue;

        // skip not auto join or in group
        if (!plr->GetSession()->LookingForGroup_auto_join || plr->GetGroup())
            continue;

        if (!plr->m_lookingForGroup.HaveInSlot(m_lookingForGroup.more))
            continue;

        // attempt create group if need, or stop attempts
        if (!GetGroup())
        {
            Group* group = new Group;
            if (!group->Create(GetGUID(), GetName(), true))
            {
                delete group;
                return;                                     // can't create group (??)
            }

            sObjectMgr.AddGroup(group);
        }

        // stop at join fail (full)
        if (!GetGroup()->AddMember(plr->GetGUID(), plr->GetName(), true))
        {
            LeaveLFGChannel();

            break;
        }

        // joined
        plr->LeaveLFGChannel();

        joinedList.push_back(*iter);

        // and group full
        if (GetGroup()->IsFull())
        {
            LeaveLFGChannel();
            break;
        }
    }

    a.release();

    // clear LFG and LFM for players joined to our pt
    for (std::list<uint64>::const_iterator itr = joinedList.begin(); itr != joinedList.end(); ++itr)
    {
        Player *plr = ObjectAccessor::GetPlayer(*itr);

        if (!plr)
            continue;

        plr->ClearLFG();
        plr->ClearLFM();
    }
}

void Player::LFGSet(uint8 slot, uint32 entry, uint32 type)
{
    if (slot >= MAX_LOOKING_FOR_GROUP_SLOT)
        return;

    // don't add GM to lfg list
    if (GetSession()->HasPermissions(PERM_GMT))
        return;

    LfgContainerType::accessor a;
    uint64 guid = GetGUID();
    uint32 combined;

    // if not empty then clear slot
    LfgContainerType & lfgContainer = sWorld.GetLfgContainer(GetTeam());
    if (!m_lookingForGroup.slots[slot].Empty())
    {
        combined = m_lookingForGroup.slots[slot].Combine();

        if (lfgContainer.find(a, combined))
        {
            // remove player from list
            for (std::list<uint64>::iterator itr = a->second.begin(); itr != a->second.end();)
            {
                std::list<uint64>::iterator tmpItr = itr;
                ++itr;

                if ((*tmpItr) == guid)
                    a->second.erase(tmpItr);
            }
        }

        m_lookingForGroup.slots[slot].Clear();
        a.release();
    }

    combined = LFG_COMBINE(entry, type);

    // if he want set empty then only clean slot
    if (!combined)
    {
        for (uint8 i = 0; i < MAX_LOOKING_FOR_GROUP_SLOT; ++i)
            if (!m_lookingForGroup.slots[i].Empty())
                return;

        // clear LFM (for sure, client resets presets in LFM when LFG is empty) if lfg is cleaned
        ClearLFM(false);
        LeaveLFGChannel();
        return;
    }

    // if we can't find list in container or add new list
    if (!lfgContainer.find(a, combined))
        if (!lfgContainer.insert(a, combined))
            return;

    m_lookingForGroup.slots[slot].Set(entry, type);
    a->second.push_back(guid);

    JoinLFGChannel();
}

void Player::LFMSet(uint32 entry, uint32 type)
{
    // don't add GM to lfm list
    if (GetSession()->HasPermissions(PERM_GMT))
        return;

    // don't add to lfm list if still in lfg
    for (uint8 i = 0; i < MAX_LOOKING_FOR_GROUP_SLOT; ++i)
        if (!m_lookingForGroup.slots[i].Empty())
            return;

    // don't add to lfm if in group and not leader (for cases when group member wants check instance list or for raid assists)
    if (GetGroup() && !GetGroup()->IsLeader(GetGUID()))
        return;

    // clear lfg when player want looking for more
    ClearLFG(false);
    LfgContainerType::accessor a;   // accessor - read and write lock

    uint64 guid = GetGUID();
    uint32 combined;

    LfgContainerType & lfgContainer = sWorld.GetLfgContainer(GetTeam());
    if (!m_lookingForGroup.more.Empty())
    {
        combined = m_lookingForGroup.more.Combine();

        if (lfgContainer.find(a, combined))
        {
            // remove player from list
            for (std::list<uint64>::iterator itr = a->second.begin(); itr != a->second.end();)
            {
                std::list<uint64>::iterator tmpItr = itr;
                ++itr;

                if ((*tmpItr) == guid)
                    a->second.erase(tmpItr);
            }
        }

        m_lookingForGroup.more.Clear();
        a.release();
    }

    combined = LFG_COMBINE(entry, type);

    // if we can't find list in container or add new list
    if (!lfgContainer.find(a, combined))
        if (!lfgContainer.insert(a, combined))
            return;

    m_lookingForGroup.more.Set(entry, type);
    a->second.push_back(guid);
    GetSession()->SendUpdateLFM();

    JoinLFGChannel();
}

void Player::ClearLFG(bool leaveChannel)
{
    bool wasEmpty = true;
    LfgContainerType & lfgContainer = sWorld.GetLfgContainer(GetTeam());
    for (uint8 i = 0; i < MAX_LOOKING_FOR_GROUP_SLOT; ++i)
    {
        if (m_lookingForGroup.slots[i].Empty())
            continue;

        wasEmpty = false;

        LfgContainerType::accessor a;

        if (!lfgContainer.find(a, GetLFGCombined(i)))
            continue;

        // remove player from list
        for (std::list<uint64>::iterator itr = a->second.begin(); itr != a->second.end();)
        {
            std::list<uint64>::iterator tmpItr = itr;
            ++itr;

            if ((*tmpItr) == GetGUID())
                a->second.erase(tmpItr);
        }

        m_lookingForGroup.slots[i].Clear();
    }

    if (leaveChannel)
        LeaveLFGChannel();

    // don't send update lfg if lfg was empty
    if (!wasEmpty)
        GetSession()->SendUpdateLFG();
}

void Player::ClearLFM(bool leaveChannel)
{
    // don't clear empty slot
    if (m_lookingForGroup.more.Empty())
        return;

    LfgContainerType::accessor a;

    LfgContainerType & lfgContainer = sWorld.GetLfgContainer(GetTeam());
    if (!lfgContainer.find(a, m_lookingForGroup.more.Combine()))
        return;

    // remove player from list
    for (std::list<uint64>::iterator itr = a->second.begin(); itr != a->second.end();)
    {
        std::list<uint64>::iterator tmpItr = itr;
        ++itr;

        if ((*tmpItr) == GetGUID())
            a->second.erase(tmpItr);
    }

    m_lookingForGroup.more.Clear();

    if (leaveChannel)
        LeaveLFGChannel();

    GetSession()->SendUpdateLFM();
}

uint8 Player::IsLFM(uint32 type, uint32 entry)
{
    if (m_lookingForGroup.more.Is(entry, type))
        return 1;

    return 0;
}

uint32 Player::GetLFGCombined(uint8 slot)
{
    if (slot >= MAX_LOOKING_FOR_GROUP_SLOT)
        return 0;

    return m_lookingForGroup.slots[slot].Combine();
}

uint32 Player::GetLFMCombined()
{
    return m_lookingForGroup.more.Combine();
}

void Player::SetBattleGroundRaid(Group* group, int8 subgroup)
{
    //we must move references from m_group to m_originalGroup
    SetOriginalGroup(GetGroup(), GetSubGroup());

    m_group.unlink();
    m_group.link(group, this);
    m_group.setSubGroup((uint8)subgroup);
}

void Player::RemoveFromBattleGroundRaid()
{
    //remove existing reference
    m_group.unlink();
    if (Group* group = GetOriginalGroup())
    {
         m_group.link(group, this);
        m_group.setSubGroup(GetOriginalSubGroup());
    }
    SetOriginalGroup(NULL);
}

void Player::SetOriginalGroup(Group *group, int8 subgroup)
{
    if (group == NULL)
        m_originalGroup.unlink();
    else
    {
        // never use SetOriginalGroup without a subgroup unless you specify NULL for group
        ASSERT(subgroup >= 0);
        m_originalGroup.link(group, this);
        m_originalGroup.setSubGroup((uint8)subgroup);
    }
}

void Player::UpdateUnderwaterState(Map* m, float x, float y, float z)
{
    GridMapLiquidData liquid_status;
    GridMapLiquidStatus res = m->GetTerrain()->getLiquidStatus(x, y, z, MAP_ALL_LIQUIDS, &liquid_status);
    if (!res)
    {
        m_MirrorTimerFlags &= ~(UNDERWATER_INWATER|UNDERWATER_INLAVA|UNDERWATER_INSLIME|UNDERWATER_INDARKWATER);
        // Small hack for enable breath in WMO
        /* if (IsInWater())
            m_MirrorTimerFlags|=UNDERWATER_INWATER; */
        return;
    }

    // All liquids type - check under water position
    if (liquid_status.type&(MAP_LIQUID_TYPE_WATER|MAP_LIQUID_TYPE_OCEAN|MAP_LIQUID_TYPE_MAGMA|MAP_LIQUID_TYPE_SLIME))
    {
        if (res & LIQUID_MAP_UNDER_WATER)
            m_MirrorTimerFlags |= UNDERWATER_INWATER;
        else
            m_MirrorTimerFlags &= ~UNDERWATER_INWATER;
    }

    // Allow travel in dark water on taxi or transport
    if ((liquid_status.type & MAP_LIQUID_TYPE_DARK_WATER) && !IsTaxiFlying() && !GetTransport())
        m_MirrorTimerFlags |= UNDERWATER_INDARKWATER;
    else
        m_MirrorTimerFlags &= ~UNDERWATER_INDARKWATER;

    // in lava check, anywhere in lava level
    if ((liquid_status.type&MAP_LIQUID_TYPE_MAGMA) || GetAreaId() == 25 || GetAreaId() == 1584)
    {
        if (res & (LIQUID_MAP_UNDER_WATER|LIQUID_MAP_IN_WATER|LIQUID_MAP_WATER_WALK))
            m_MirrorTimerFlags |= UNDERWATER_INLAVA;
        else
            m_MirrorTimerFlags &= ~UNDERWATER_INLAVA;
    }
    // in slime check, anywhere in slime level
    if (liquid_status.type&MAP_LIQUID_TYPE_SLIME)
    {
        if (res & (LIQUID_MAP_UNDER_WATER|LIQUID_MAP_IN_WATER|LIQUID_MAP_WATER_WALK))
            m_MirrorTimerFlags |= UNDERWATER_INSLIME;
        else
            m_MirrorTimerFlags &= ~UNDERWATER_INSLIME;
    }
}

void Player::SetCanParry(bool value)
{
    if (m_canParry == value)
        return;

    m_canParry = value;
    UpdateParryPercentage();
}

void Player::SetCanBlock(bool value)
{
    if (m_canBlock == value)
        return;

    m_canBlock = value;
    UpdateBlockPercentage();
}

bool ItemPosCount::isContainedIn(ItemPosCountVec const& vec) const
{
    for (ItemPosCountVec::const_iterator itr = vec.begin(); itr != vec.end();++itr)
    {
        if (itr->pos == pos)
            return true;
    }

    return false;
}

//***********************************
//-------------TRINITY---------------
//***********************************

void Player::HandleFallDamage(MovementInfo& movementInfo)
{
    if (movementInfo.GetFallTime() < 1500)
        return;

    // calculate total z distance of the fall
    float z_diff = m_lastFallZ - movementInfo.GetPos()->z;
    uint32 areaID = GetMap()->GetId();
    sLog.outDebug("zDiff = %f", z_diff);

    //Players with low fall distance, Feather Fall or physical immunity (charges used) are ignored
    // 14.57 can be calculated by resolving damageperc formular below to 0
    if (z_diff >= 14.57f && !isDead() && !isGameMaster() &&
        !HasAuraType(SPELL_AURA_HOVER) && !HasAuraType(SPELL_AURA_FEATHER_FALL) &&
        !(HasAuraType(SPELL_AURA_FLY) && areaID != 550) && !IsImmunedToDamage(SPELL_SCHOOL_MASK_NORMAL,true))  //do not check for fly aura in Tempest Keep:Eye to properly deal fall dmg when after knockback (Gravity Lapse)
    {
        //Safe fall, fall height reduction
        int32 safe_fall = GetTotalAuraModifier(SPELL_AURA_SAFE_FALL);

        float damageperc = 0.018f*(z_diff-safe_fall)-0.2426f;

        if (damageperc >0)
        {
            uint32 damage = (uint32)(damageperc * GetMaxHealth()*sWorld.getRate(RATE_DAMAGE_FALL));

            float height = movementInfo.GetPos()->z;
            UpdateAllowedPositionZ(movementInfo.GetPos()->x, movementInfo.GetPos()->y, height);

            if (damage > 0)
            {
                //Prevent fall damage from being more than the player maximum health
                if (damage > GetMaxHealth())
                    damage = GetMaxHealth();

                // Gust of Wind
                if (GetDummyAura(43621))
                    damage = GetMaxHealth()/2;

                EnvironmentalDamage(DAMAGE_FALL, damage);
            }
        }
    }
}

void Player::HandleFallUnderMap(float z)
{
    //Hacky - this fixes movement if player died in an instance .i.e. zangarmarsh TODO: Find better solution
    if (m_deathState != ALIVE)
        SetMovement(MOVE_WATER_WALK);

    if (InBattleGround() && GetBattleGround())
        GetBattleGround()->HandlePlayerUnderMap(this, z);
    else
    {
        if (z > -500.0f)
            return;

        // NOTE: this is actually called many times while falling
        // even after the player has been teleported away
        // TODO: discard movement packets after the player is rooted
        if (isAlive())
        {
            EnvironmentalDamage(DAMAGE_FALL_TO_VOID, GetMaxHealth());
            // change the death state to CORPSE to prevent the death timer from
            // starting in the next player update
            KillPlayer();
            BuildPlayerRepop();
        }

        // cancel the death timer here if started
        RepopAtGraveyard();
    }
}

WorldObject* Player::GetFarsightTarget() const
{
    // Players can have in farsight field another player's guid, a creature's guid, or a dynamic object's guid
    if (uint64 guid = GetUInt64Value(PLAYER_FARSIGHT))
        return (WorldObject*)GetMap()->GetObjectByTypeMask(*this, guid, TYPEMASK_PLAYER | TYPEMASK_UNIT | TYPEMASK_DYNAMICOBJECT);
    return NULL;
}

void Player::StopCastingBindSight()
{
    if (WorldObject* target = GetFarsightTarget())
    {
        if (target->isType(TYPEMASK_UNIT))
        {
            ((Unit*)target)->RemoveAuraTypeByCaster(SPELL_AURA_BIND_SIGHT, GetGUID());
            ((Unit*)target)->RemoveAuraTypeByCaster(SPELL_AURA_MOD_POSSESS, GetGUID());
            ((Unit*)target)->RemoveAuraTypeByCaster(SPELL_AURA_MOD_POSSESS_PET, GetGUID());
        }
    }
}

void Player::ClearFarsight()
{
    if (GetUInt64Value(PLAYER_FARSIGHT))
    {
        SetUInt64Value(PLAYER_FARSIGHT, 0);
        WorldPacket data(SMSG_CLEAR_FAR_SIGHT_IMMEDIATE, 0);
        SendPacketToSelf(&data);
    }
}

void Player::SetFarsightTarget(WorldObject* obj)
{
    if (!obj || !obj->isType(TYPEMASK_PLAYER | TYPEMASK_UNIT | TYPEMASK_DYNAMICOBJECT))
        return;

    // Remove the current target if there is one
    StopCastingBindSight();

    SetUInt64Value(PLAYER_FARSIGHT, obj->GetGUID());
}

bool Player::isAllowUseBattleGroundObject()
{
    if (HasAuraType(SPELL_AURA_MOD_STEALTH))
        RemoveSpellsCausingAura(SPELL_AURA_MOD_STEALTH);

    return (//InBattleGround() &&                               // in battleground - not need, check in other cases
             !IsMounted() &&                                    // not mounted
             !isTotalImmunity() &&                              // not totally immuned
             //!HasStealthAura() &&                               // not stealthed
             !HasInvisibilityAura() &&                          // not invisible
             !HasAura(SPELL_RECENTLY_DROPPED_FLAG) &&           // can't pickup
             isAlive() &&                                       // live player
             !HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION)      // isn't in Spirit of Redemption form
          );
}

bool Player::isAllowedToJoinPoint()
{
        return (!isTotalImmunity() &&                           // not totally immuned
             !HasStealthAura() &&                               // not stealthed
             !HasInvisibilityAura() &&                          // not invisible
             isAlive() &&                                       // live player
             !HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION)      // isn't in Spirit of Redemption form
          );
}

bool Player::HasTitle(uint32 bitIndex)
{
    if (bitIndex > 128)
        return false;

    uint32 fieldIndexOffset = bitIndex/32;
    uint32 flag = 1 << (bitIndex%32);
    return HasFlag(PLAYER__FIELD_KNOWN_TITLES+fieldIndexOffset, flag);
}

void Player::SetTitle(CharTitlesEntry const* title)
{
    uint32 fieldIndexOffset = title->bit_index/32;
    uint32 flag = 1 << (title->bit_index%32);
    SetFlag(PLAYER__FIELD_KNOWN_TITLES+fieldIndexOffset, flag);
}

void Player::AutoStoreLoot(uint8 bag, uint8 slot, uint32 loot_id, LootStore const& store, bool broadcast)
{
    Loot loot;
    loot.FillLoot (loot_id,store,this,true);
    if(loot.items.empty ())
        return;
    LootItem const* lootItem = &loot.items[0];

    ItemPosCountVec dest;
    uint8 msg = CanStoreNewItem (bag,slot,dest,lootItem->itemid,lootItem->count);
    if(msg != EQUIP_ERR_OK && slot != NULL_SLOT)
        msg = CanStoreNewItem( bag, NULL_SLOT,dest,lootItem->itemid,lootItem->count);
    if( msg != EQUIP_ERR_OK && bag != NULL_BAG)
        msg = CanStoreNewItem( NULL_BAG, NULL_SLOT,dest,lootItem->itemid,lootItem->count);
    if(msg != EQUIP_ERR_OK)
    {
        SendEquipError( msg, NULL, NULL );
        return;
    }

    Item* pItem = StoreNewItem (dest,lootItem->itemid,true,lootItem->randomPropertyId);
    SendNewItem(pItem, lootItem->count, false, false,broadcast);
}


/*-----------------------TRINITY--------------------------*/
bool Player::isTotalImmunity()
{
    AuraList const& immune = GetAurasByType(SPELL_AURA_SCHOOL_IMMUNITY);

    for (AuraList::const_iterator itr = immune.begin(); itr != immune.end(); ++itr)
    {
        if (((*itr)->GetModifier()->m_miscvalue & SPELL_SCHOOL_MASK_ALL) !=0)   // total immunity
        {
            return true;
        }
        if (((*itr)->GetModifier()->m_miscvalue & SPELL_SCHOOL_MASK_NORMAL) !=0)   // physical damage immunity
        {
            for (AuraList::const_iterator i = immune.begin(); i != immune.end(); ++i)
            {
                if (((*i)->GetModifier()->m_miscvalue & SPELL_SCHOOL_MASK_MAGIC) !=0)   // magic immunity
                {
                    return true;
                }
            }
        }
    }
    return false;
}


void Player::BuildTeleportAckMsg(WorldPacket& data, float x, float y, float z, float ang) const
{
    MovementInfo mi = m_movementInfo;
    mi.ChangePosition(x, y, z, ang);
    data.Initialize(MSG_MOVE_TELEPORT_ACK, 41);
    data << GetPackGUID();
    data << uint32(0); // this value increments every time
    data << mi;
}

void Player::ResetTimeSync()
{
    m_timeSyncCounter = 0;
    m_timeSyncTimer = 0;
    m_timeSyncClient = 0;
    m_timeSyncServer = WorldTimer::getMSTime();
}

void Player::SendTimeSync()
{
    WorldPacket data(SMSG_TIME_SYNC_REQ, 4);
    data << uint32(m_timeSyncCounter++);
    SendPacketToSelf(&data);

    // Schedule next sync in 10 sec
    m_timeSyncTimer = 10000;
    m_timeSyncServer = WorldTimer::getMSTime();
}

float Player::GetXPRate(Rates rate)
{
    return sWorld.getRate(Rates(rate));
}

uint32 Player::CalculateTalentsPoints() const
{
    uint32 talentPointsForLevel = getLevel() < 10 ? 0 : getLevel()-9;
    return uint32(talentPointsForLevel * sWorld.getRate(RATE_TALENT));
}

BattleGroundBracketId Player::GetBattleGroundBracketIdFromLevel(BattleGroundTypeId bgTypeId) const
{
    BattleGround *bg = sBattleGroundMgr.GetBattleGroundTemplate(bgTypeId);
    ASSERT(bg);
    if (getLevel() < bg->GetMinLevel())
        return BG_BRACKET_ID_FIRST;

    uint32 bracket_id = (getLevel() - bg->GetMinLevel()) / 10;
    if (bracket_id > MAX_BATTLEGROUND_BRACKETS)
        return BG_BRACKET_ID_LAST;

    return BattleGroundBracketId(bracket_id);
}

void Player::InterruptTaxiFlying()
{
    // stop flight if need
    if (IsTaxiFlying())
    {
        GetUnitStateMgr().DropAction(UNIT_ACTION_TAXI);
        m_taxi.ClearTaxiDestinations();
        GetUnitStateMgr().InitDefaults(false);
    }
    // save only in non-flight case
    else
        SaveRecallPosition();
}

uint8 Player::GetValidForPush()
{
// return: 1 = zu hohes level; 2 = bereits zu viele auf zu hohem level; 3 = alles okay, gib feuer; 4 = second account, nix machen
    if (getLevel() >= 60)
        return 0;

    return 5;
}

void Player::Push()
{
    GiveLevel(60);
    learnSpell(33392); //riding skill of 150
    SaveToDB();
}

void Player::PushSixty()
{
    GiveLevel(60);
    
    // Alliance
    if (GetTeam() == ALLIANCE)
        learnSpell(33391); //riding skill of 100
    else
        learnSpell(33389); //riding skill of 75
    
    SaveToDB();
}

void Player::EquipForPush(uint16 items[])
{
    if (!HasItemCount(6948, 1, true))
        AddItem(6948,1); //Hearthstone

    AddItem(22895, 20); //something to eat
    AddItem(30703, 20); //something to drink

    switch (GetTeam())
    {
        case ALLIANCE:
        {
            switch (getRace())
            {
                case RACE_HUMAN:
                    if (!HasItemCount(18778, 1, true))  //Mount
                        AddItem(18778, 1);
                    break;
                case RACE_DWARF:
                    if (!HasItemCount(18787, 1, true))  //Mount
                        AddItem(18787, 1);
                    break;
                case RACE_NIGHTELF:
                    if (!HasItemCount(18767, 1, true))  //Mount
                        AddItem(18767, 1);
                    break;
                case RACE_GNOME:
                    if (!HasItemCount(18772, 1, true))  //Mount
                    AddItem(18772, 1);
                    break;
                case RACE_DRAENEI:
                    if (!HasItemCount(29745, 1, true))  //Mount
                        AddItem(29745, 1);
                    break;
            }

            switch (getClass())
            {
                case CLASS_WARRIOR:
                    learnSpell(71);
                    learnSpell(355);
                    learnSpell(7386);
                    learnSpell(2458);
                    learnSpell(20252);
                    learnSpell(750);
                    learnSpell(197);
                    learnSpell(196);
                    learnSpell(201);
                    learnSpell(2567);
                    learnSpell(266);
                    learnSpell(15590);
                    learnSpell(264);
                    learnSpell(674);
                    learnSpell(198);
                    break;
                case CLASS_PALADIN:
                    learnSpell(750);
                    learnSpell(7328);
                    learnSpell(198);
                    learnSpell(199);
                    learnSpell(201);
                    learnSpell(200);
                    if (!HasItemCount(21177, 100, true))
                        AddItem(21177, 100);
                    if (!HasItemCount(17033, 5, true))
                    AddItem(17033, 5);
                    break;
                case CLASS_HUNTER:
                {
                    learnSpell(1515);
                    learnSpell(883);
                    learnSpell(2641);
                    learnSpell(5149);
                    learnSpell(6991);
                    learnSpell(982);
                    learnSpell(200);
                    learnSpell(264);
                    learnSpell(197);
                    learnSpell(1180);
                    learnSpell(674);
                    learnSpell(5011);
                    if (!HasItemCount(28056, 1000, true)) //arrows
                        AddItem(28056, 1000);
                    learnSpell(8737);
                    if (getRace() == RACE_DWARF)
                        if (!HasItemCount(2101, 1, true)) //quiver
                            AddItem(2101, 1);
                }
                    break;
                case CLASS_ROGUE:
                    learnSpell(1804);
                    SetSkill(633, 350, 300);
                    learnSpell(2842);
                    SetSkill(40, 350, 300);
                    learnSpell(201);
                    learnSpell(674);
                    learnSpell(2567);
                    learnSpell(15590);
                    if (!HasItemCount(5140, 20, true))
                        AddItem(5140, 20);
                    break;
                case CLASS_PRIEST:
                    learnSpell(198);
                    learnSpell(227);
                    if (!HasItemCount(17029, 20, true))
                        AddItem(17029, 20);
                    break;
                case CLASS_SHAMAN:
                    AddItem(5175, 1);
                    AddItem(5176, 1);
                    AddItem(5177, 1);
                    AddItem(5178, 1);
                    learnSpell(8071);
                    learnSpell(3599);
                    learnSpell(5394);
                    learnSpell(196);
                    learnSpell(15590);
                    learnSpell(8737);
                    learnSpell(227);
                    learnSpell(198);
                    learnSpell(197);
                    learnSpell(1180);
                    AddItem(17030, 10);
                    AddItem(17058, 20);
                    AddItem(17057, 20);
                    break;
                case CLASS_MAGE:
                    learnSpell(227);
                    if (!HasItemCount(17020, 20, true))
                        AddItem(17020, 20);
                    if (!HasItemCount(17032, 5, true))
                        AddItem(17032, 5);
                    if (!HasItemCount(17031, 5, true))
                        AddItem(17031, 5);
                    learnSpell(201);
                    break;
                case CLASS_DRUID:
                    learnSpell(18960);
                    learnSpell(1066);
                    learnSpell(6795);
                    learnSpell(5487);
                    learnSpell(6807);
                    learnSpell(227);
                    learnSpell(198);
                    if (!HasItemCount(17026, 20, true))
                        AddItem(17026, 20);
                    if (!HasItemCount(22147, 10, true))
                        AddItem(22147, 10);
                    break;
                case CLASS_WARLOCK:
                    learnSpell(688);
                    learnSpell(697);
                    learnSpell(712);
                    learnSpell(691);
                    if (!HasItemCount(6265, 5, true))
                        AddItem(6265, 5);
                    learnSpell(227);
                    learnSpell(201);
                    break;
            }
            break;
    }
        case HORDE:
        {
            switch (getRace())
            {
                case RACE_BLOODELF:
                    if (!HasItemCount(29223, 1, true))
                        AddItem(29223, 1);
                    break;
                case RACE_ORC:
                    if (!HasItemCount(18797, 1, true))
                        AddItem(18797, 1);
                    break;
                case RACE_UNDEAD_PLAYER:
                    if (!HasItemCount(13334, 1, true))
                        AddItem(13334, 1);
                    break;
                case RACE_TAUREN:
                    if (!HasItemCount(18795, 1, true))
                        AddItem(18795, 1);
                    break;
                case RACE_TROLL:
                    if (!HasItemCount(18788, 1, true))
                        AddItem(18788, 1);
                    break;
            }

            switch (getClass())
            {
                case CLASS_WARRIOR:
                    learnSpell(71);
                    learnSpell(355);
                    learnSpell(7386);
                    learnSpell(2458);
                    learnSpell(20252);
                    learnSpell(750);
                    learnSpell(197);
                    learnSpell(196);
                    learnSpell(201);
                    learnSpell(2567);
                    learnSpell(266);
                    learnSpell(264);
                    learnSpell(15590);
                    learnSpell(15590);
                    learnSpell(674);
                    learnSpell(198);
                    break;
                case CLASS_PALADIN:
                    learnSpell(7328);
                    learnSpell(750);
                    learnSpell(198);
                    learnSpell(199);
                    learnSpell(201);
                    learnSpell(200);
                    learnSpell(202);
                    if (!HasItemCount(21177, 100, true))
                        AddItem(21177, 100);
                    if (!HasItemCount(17033, 5, true))
                        AddItem(17033, 5);
                    break;
                case CLASS_HUNTER:
                {
                    learnSpell(1515);
                    learnSpell(883);
                    learnSpell(2641);
                    learnSpell(5149);
                    learnSpell(6991);
                    learnSpell(982);
                    learnSpell(200);
                    learnSpell(264);
                    learnSpell(197);
                    learnSpell(1180);
                    learnSpell(674);
                    learnSpell(5011);
                    if (!HasItemCount(28056, 1000, true))
                        AddItem(28056, 1000);
                    learnSpell(8737);
                    if (getRace() == RACE_TAUREN)
                        if (!HasItemCount(2101, 1, true))
                            AddItem(2101, 1);
                }
                    break;
                case CLASS_ROGUE:
                    learnSpell(1804);
                    SetSkill(633, 350, 300);
                    learnSpell(2842);
                    SetSkill(40, 350, 300);
                    learnSpell(201);
                    learnSpell(674);
                    learnSpell(2567);
                    learnSpell(15590);
                    if (!HasItemCount(5140, 20, true))
                        AddItem(5140, 20);
                    break;
                case CLASS_PRIEST:
                    learnSpell(198);
                    learnSpell(227);
                    if (!HasItemCount(17029, 20, true))
                        AddItem(17029, 20);
                    break;
                case CLASS_SHAMAN:
                    AddItem(5175, 1);
                    AddItem(5176, 1);
                    AddItem(5177, 1);
                    AddItem(5178, 1);
                    learnSpell(8071);
                    learnSpell(3599);
                    learnSpell(5394);
                    learnSpell(196);
                    learnSpell(15590);
                    learnSpell(8737);
                    learnSpell(227);
                    learnSpell(198);
                    learnSpell(197);
                    learnSpell(1180);
                    AddItem(17030, 10);
                    AddItem(17058, 20);
                    AddItem(17057, 20);
                    break;
                case CLASS_MAGE:
                    learnSpell(227);
                    if (!HasItemCount(17020, 20, true))
                        AddItem(17020, 20);
                    if (!HasItemCount(17032, 5, true))
                        AddItem(17032, 5);
                    if (!HasItemCount(17031, 5, true))
                        AddItem(17031, 5);
                    break;
                case CLASS_DRUID:
                    learnSpell(18960);
                    learnSpell(1066);
                    learnSpell(6795);
                    learnSpell(5487);
                    learnSpell(6807);
                    learnSpell(227);
                    learnSpell(198);
                    if (!HasItemCount(17026, 20, true))
                        AddItem(17026, 20);
                    if (!HasItemCount(22147, 10, true))
                        AddItem(22147, 10);
                    break;
                case CLASS_WARLOCK:
                    learnSpell(688);
                    learnSpell(697);
                    learnSpell(712);
                    learnSpell(691);
                    if (!HasItemCount(6265, 5, true))
                        AddItem(6265, 5);
                    learnSpell(227);
                    break;
            }
            break;
        }
    }
    UpdateSkillsToMaxSkillsForLevel();

    for (uint16 i = 0; i < 18; i++)
    {
        DestroyItem(255, i, true);
    }

    for (uint16 i = 0; i < 18; i++)
    {
        if (items[i] != 0)
        {
            Item *item = EquipNewItem(i, items[i], true);
            if (item)
                item->SendCreateUpdateToPlayer(this);
        }
    }
    SaveToDB();
}

// obsolete
void Player::PvpPush(uint16 items[])
{
    for (uint16 i = 0; i < 18; i++)
    {
        if (items[i] != 0)
        {
            AddItem(items[i],1);
            SaveToDB();
        }
    }
}

void Player::EquipForPushSixty(uint16 items[])
{
    if (!HasItemCount(6948, 1, true))
        AddItem(6948,1); //Ruhestein Adden

    AddItem(22895, 20); //something to eat
    AddItem(30703, 20); //something to drink
    
    switch (GetTeam())
    {
        case ALLIANCE:
        {
            switch (getRace())
            {
            case RACE_HUMAN:
                if (!HasItemCount(18778, 1, true))  //Mount
                    AddItem(18778, 1);
                    break;
            case RACE_DWARF:
                if (!HasItemCount(18787, 1, true))  //Mount
                    AddItem(18787, 1);
                    break;
            case RACE_NIGHTELF:
                if (!HasItemCount(18767, 1, true))  //Mount
                    AddItem(18767, 1);
                    break;
            case RACE_GNOME:
                if (!HasItemCount(18772, 1, true))  //Mount
                    AddItem(18772, 1);
                    break;
            case RACE_DRAENEI:
                if (!HasItemCount(29745, 1, true))  //Mount
                    AddItem(29745, 1);
                    break;
            }

            switch (getClass())
            {
                case CLASS_WARRIOR:
                    learnSpell(71);
                    learnSpell(355);
                    learnSpell(7386);
                    learnSpell(2458);
                    learnSpell(20252);
                    learnSpell(750);
                    learnSpell(197);
                    learnSpell(196);
                    learnSpell(201);
                    learnSpell(2567);
                    learnSpell(266);
                    learnSpell(15590);
                    learnSpell(264);
                    learnSpell(674);
                    learnSpell(198);
                    break;
                case CLASS_PALADIN:
                    learnSpell(750);
                    learnSpell(7328);
                    learnSpell(198);
                    learnSpell(199);
                    learnSpell(201);
                    learnSpell(200);
                    if (!HasItemCount(21177, 100, true))
                        AddItem(21177, 100);
                    if (!HasItemCount(17033, 5, true))
                    AddItem(17033, 5);
                    break;
                case CLASS_HUNTER:
                {
                    learnSpell(1515);
                    learnSpell(883);
                    learnSpell(2641);
                    learnSpell(5149);
                    learnSpell(6991);
                    learnSpell(982);
                    learnSpell(200);
                    learnSpell(264);
                    learnSpell(197);
                    learnSpell(1180);
                    learnSpell(674);
                    if (!HasItemCount(28053, 1000, true))
                        AddItem(28053, 1000);
                    learnSpell(8737);
                    if (getRace() == RACE_DWARF)
                        if (!HasItemCount(2101, 1, true))
                            AddItem(2101, 1);
                }
                    break;
                case CLASS_ROGUE:
                    learnSpell(1804);
                    SetSkill(633, 350, 350);
                    learnSpell(2842);
                    SetSkill(40, 350, 350);
                    learnSpell(201);
                    learnSpell(674);
                    learnSpell(2567);
                    learnSpell(15590);
                    if (!HasItemCount(5140, 20, true))
                        AddItem(5140, 20);
                    break;
                case CLASS_PRIEST:
                    learnSpell(198);
                    learnSpell(227);
                    if (!HasItemCount(17029, 20, true))
                        AddItem(17029, 20);
                    break;
                case CLASS_SHAMAN:
                    AddItem(5175, 1);
                    AddItem(5176, 1);
                    AddItem(5177, 1);
                    AddItem(5178, 1);
                    learnSpell(8071);
                    learnSpell(3599);
                    learnSpell(5394);
                    learnSpell(196);
                    learnSpell(15590);
                    learnSpell(8737);
                    learnSpell(227);
                    learnSpell(198);
                    learnSpell(197);
                    learnSpell(1180);
                    AddItem(17030, 10);
                    AddItem(17058, 20);
                    AddItem(17057, 20);
                    break;
                case CLASS_MAGE:
                    learnSpell(227);
                    if (!HasItemCount(17020, 20, true))
                        AddItem(17020, 20);
                    learnSpell(201);
                    break;
                case CLASS_DRUID:
                    learnSpell(18960);
                    learnSpell(1066);
                    learnSpell(6795);
                    learnSpell(5487);
                    learnSpell(6807);
                    learnSpell(227);
                    learnSpell(198);
                    if (!HasItemCount(17026, 20, true))
                        AddItem(17026, 20);
                    if (!HasItemCount(17038, 10, true))
                        AddItem(17038, 10);
                    break;
                case CLASS_WARLOCK:
                    learnSpell(688);
                    learnSpell(697);
                    learnSpell(712);
                    learnSpell(691);
                    if (!HasItemCount(6265, 5, true))
                        AddItem(6265, 5);
                    learnSpell(227);
                    learnSpell(201);
                    break;
            }
            break;
    }
        case HORDE:
        {
            switch (getRace())
            {
                case RACE_BLOODELF:
                    if (!HasItemCount(29222, 1, true))
                        AddItem(29222, 1);
                    break;
                case RACE_ORC:
                    if (!HasItemCount(1132, 1, true))
                        AddItem(1132, 1);
                    break;
                case RACE_UNDEAD_PLAYER:
                    if (!HasItemCount(13333, 1, true))
                        AddItem(13333, 1);
                    break;
                case RACE_TAUREN:
                    if (!HasItemCount(15290, 1, true))
                        AddItem(15290, 1);
                    break;
                case RACE_TROLL:
                    if (!HasItemCount(8588, 1, true))
                        AddItem(8588, 1);
                    break;
            }

            switch (getClass())
            {
                case CLASS_WARRIOR:
                    learnSpell(71);
                    learnSpell(355);
                    learnSpell(7386);
                    learnSpell(2458);
                    learnSpell(20252);
                    learnSpell(750);
                    learnSpell(197);
                    learnSpell(196);
                    learnSpell(201);
                    learnSpell(2567);
                    learnSpell(266);
                    learnSpell(264);
                    learnSpell(15590);
                    learnSpell(15590);
                    learnSpell(674);
                    learnSpell(198);
                    break;
                case CLASS_PALADIN:
                    learnSpell(7328);
                    learnSpell(750);
                    learnSpell(198);
                    learnSpell(199);
                    learnSpell(201);
                    learnSpell(200);
                    if (!HasItemCount(21177, 100, true))
                        AddItem(21177, 100);
                    if (!HasItemCount(17033, 5, true))
                        AddItem(17033, 5);
                    break;
                case CLASS_HUNTER:
                {
                    learnSpell(1515);
                    learnSpell(883);
                    learnSpell(2641);
                    learnSpell(5149);
                    learnSpell(6991);
                    learnSpell(982);
                    learnSpell(200);
                    learnSpell(264);
                    learnSpell(197);
                    learnSpell(1180);
                    learnSpell(674);
                    if (!HasItemCount(28053, 1000, true))
                        AddItem(28053, 1000);
                    learnSpell(8737);
                    if (getRace() == RACE_TAUREN)
                        if (!HasItemCount(2101, 1, true))
                            AddItem(2101, 1);
                }
                    break;
                case CLASS_ROGUE:
                    learnSpell(1804);
                    SetSkill(633, 350, 300);
                    learnSpell(2842);
                    SetSkill(40, 350, 300);
                    learnSpell(201);
                    learnSpell(674);
                    learnSpell(2567);
                    learnSpell(15590);
                    if (!HasItemCount(5140, 20, true))
                        AddItem(5140, 20);
                    break;
                case CLASS_PRIEST:
                    learnSpell(198);
                    learnSpell(227);
                    if (!HasItemCount(17029, 20, true))
                        AddItem(17029, 20);
                    break;
                case CLASS_SHAMAN:
                    AddItem(5175, 1);
                    AddItem(5176, 1);
                    AddItem(5177, 1);
                    AddItem(5178, 1);
                    learnSpell(8071);
                    learnSpell(3599);
                    learnSpell(5394);
                    learnSpell(196);
                    learnSpell(15590);
                    learnSpell(8737);
                    learnSpell(227);
                    learnSpell(198);
                    learnSpell(197);
                    learnSpell(1180);
                    AddItem(17030, 10);
                    AddItem(17058, 20);
                    AddItem(17057, 20);
                    break;
                case CLASS_MAGE:
                    learnSpell(227);
                    if (!HasItemCount(17020, 20, true))
                        AddItem(17020, 20);
                    break;
                case CLASS_DRUID:
                    learnSpell(18960);
                    learnSpell(1066);
                    learnSpell(6795);
                    learnSpell(5487);
                    learnSpell(6807);
                    learnSpell(227);
                    learnSpell(198);
                    if (!HasItemCount(17026, 20, true))
                        AddItem(17026, 20);
                    if (!HasItemCount(17038, 10, true))
                        AddItem(17038, 10);
                    break;
                case CLASS_WARLOCK:
                    learnSpell(688);
                    learnSpell(697);
                    learnSpell(712);
                    learnSpell(691);
                    if (!HasItemCount(6265, 5, true))
                        AddItem(6265, 5);
                    learnSpell(227);
                    break;
            }
            break;
        }
    }
    UpdateSkillsToMaxSkillsForLevel();

    for (uint16 i = 0; i < 18; i++)
    {
        DestroyItem(255, i, true);
    }

    for (uint16 i = 0; i < 18; i++)
    {
        if (items[i] != 0)
        {
            Item *item = EquipNewItem(i, items[i], true);
            if (item)
                item->SendCreateUpdateToPlayer(this);
        }
    }
    SaveToDB();
}


void Player::FinishPush()
{
    m_homebindMapId = 530;
    m_homebindZoneId = 3703;
    m_homebindX = -1853.01f;
    m_homebindY = 5460.62f;
    m_homebindZ = -12.40f;

    RealmDataDatabase.PExecute("UPDATE character_homebind SET map='%u', zone='%u', position_x='%f', position_y='%f', position_z='%f' WHERE guid='%u'", m_homebindMapId, m_homebindZoneId, m_homebindX, m_homebindY, m_homebindZ, GUID_LOPART(GetGUID()));

    WorldPacket data(SMSG_BINDPOINTUPDATE, (4 + 4 + 4 + 4 + 4));
    data << float(m_homebindX);
    data << float(m_homebindY);
    data << float(m_homebindZ);
    data << uint32(m_homebindMapId);
    data << uint32(m_homebindZoneId);
    GetSession()->SendPacket(&data);

    SaveToDB();

        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(942), 6999); // cenarius
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(935), 4999); //shatar
        m_reputationMgr.SetReputation(sFactionStore.LookupEntry(1011), 6999); //under city

    switch (GetTeam())
    {
        case ALLIANCE:
        {
            //only classic: 3456411898 2148078929 805356359 8 0 262240 4100 0
            m_taxi.LoadTaxiMask("3456411898 2148078929 805356359 2605711384 137366529 262240 1052676 0 ");
            InitTaxiNodesForLevel();

            m_reputationMgr.SetReputation(sFactionStore.LookupEntry(946), 6999); //honor hold
            switch (getClass())
            {
                case CLASS_WARRIOR:
                    TeleportTo(0, -8687.632812, 321.413391, 110.480995, 2.250117, 0);
                    break;
                case CLASS_PALADIN:
                    TeleportTo(0, -8574.831055, 878.700256, 106.518562, 2.232057, 0);
                    break;
                case CLASS_HUNTER:
                    TeleportTo(0, -8415.0, 553.182007, 95.703003, 3.923000, 0);
                    break;
                case CLASS_ROGUE:
                    TeleportTo(0, -8795.99707, 328.733734, 103.087486, 6.149279, 0);
                    break;
                case CLASS_PRIEST:
                    TeleportTo(0, -8728.0, 1102.959961, 92.602997, 3.875, 0);
                    break;
                case CLASS_SHAMAN:
                    TeleportTo(0, -9029.720703, 547.543884, 71.682114, 2.240351, 0);
                    break;
                case CLASS_MAGE:
                    TeleportTo(0, -8990.582031, 859.554565, 29.620600, 1.389934, 0);
                    break;
                case CLASS_DRUID:
                    TeleportTo(0, -8775.655273, 1095.394775, 92.537529, 1.685111, 0);
                    break;
                case CLASS_WARLOCK:
                    TeleportTo(0, -8985.674805, 1033.822632, 102.565697, 6.088196, 0);
                    break;
            }
            break;
        }
        case HORDE:
        {
            //only classic: 830150144 315656864 449720 4 0 262176 1052672 0
            m_taxi.LoadTaxiMask("830150144 315656864 449720 3869245476 3227522050 262180 1048576 0 ");
            InitTaxiNodesForLevel();

            m_reputationMgr.SetReputation(sFactionStore.LookupEntry(947), 6999); //thrallmar
            switch (getClass())
            {
                case CLASS_WARRIOR:
                    TeleportTo(1, 1980.852173, -4797.317383, 56.038826, 4.276412, 0);
                    break;
                case CLASS_PALADIN:
                    TeleportTo(1, 1936.041260, -4137.010254, 40.918613, 0.832872, 0);
                    break;
                case CLASS_HUNTER:
                    TeleportTo(1, 2084.959961, -4623.77002, 58.676102, 0.15708, 0);
                    break;
                case CLASS_ROGUE:
                    TeleportTo(1, 1777.062012, -4286.221680, 7.113022, 2.162591, 0);
                    break;
                case CLASS_PRIEST:
                    TeleportTo(1, 1455.801880, -4180.849609, 44.063820, 2.869229, 0);
                    break;
                case CLASS_SHAMAN:
                    TeleportTo(1, 1930.528076, -4210.815430, 42.095303, 6.012136, 0);
                    break;
                case CLASS_MAGE:
                    TeleportTo(1, 1468.180054, -4219.879883, 43.0424, 5.95157, 0);
                    break;
                case CLASS_DRUID:
                    TeleportTo(1, -1042.834351, -289.17746, 159.030426, 0.138817, 0);
                    break;
                case CLASS_WARLOCK:
                    TeleportTo(1, 1844.067139, -4357.225586, -14.88052, 5.99207, 0);
                    break;
            }
            break;
        }
    }
    SaveToDB();
}

void Player::FinishPushSixty()
{
    RealmDataDatabase.PExecute("UPDATE character_homebind SET map='%u', zone='%u', position_x='%f', position_y='%f', position_z='%f' WHERE guid='%u'", 0, 4, -11789.0f, -3171.169922f, -29.0f, GUID_LOPART(GetGUID()));
    m_homebindMapId = 0;
    m_homebindZoneId = 4;
    m_homebindX = -11778.870117f;
    m_homebindY = -3200.828369f;
    m_homebindZ = -26.389161f;

    WorldPacket data(SMSG_BINDPOINTUPDATE, (4 + 4 + 4 + 4 + 4));
    data << float(m_homebindX);
    data << float(m_homebindY);
    data << float(m_homebindZ);
    data << uint32(m_homebindMapId);
    data << uint32(m_homebindZoneId);
    GetSession()->SendPacket(&data);

    SaveToDB();

    switch (GetTeam())
    {
        case ALLIANCE:
        {
            m_taxi.LoadTaxiMask("3456411898 2148078929 805356359 8 0 262240 4100 0 ");
            InitTaxiNodesForLevel();
            switch (getClass())
            {
                case CLASS_WARRIOR:
                    TeleportTo(0, -8687.632812, 321.413391, 110.480995, 2.250117, 0);
                    break;
                case CLASS_PALADIN:
                    TeleportTo(0, -8574.831055, 878.700256, 106.518562, 2.232057, 0);
                    break;
                case CLASS_HUNTER:
                    TeleportTo(0, -8415.0, 553.182007, 95.703003, 3.923000, 0);
                    break;
                case CLASS_ROGUE:
                    TeleportTo(0, -8795.99707, 328.733734, 103.087486, 6.149279, 0);
                    break;
                case CLASS_PRIEST:
                    TeleportTo(0, -8728.0, 1102.959961, 92.602997, 3.875, 0);
                    break;
                case CLASS_SHAMAN:
                    TeleportTo(0, -9029.720703, 547.543884, 71.682114, 2.240351, 0);
                    break;
                case CLASS_MAGE:
                    TeleportTo(0, -8990.582031, 859.554565, 29.620600, 1.389934, 0);
                    break;
                case CLASS_DRUID:
                    TeleportTo(0, -8775.655273, 1095.394775, 92.537529, 1.685111, 0);
                    break;
                case CLASS_WARLOCK:
                    TeleportTo(0, -8985.674805, 1033.822632, 102.565697, 6.088196, 0);
                    break;
            }
            break;
        }
        case HORDE:
        {
            m_taxi.LoadTaxiMask("830150144 315656864 449720 4 0 262176 1052672 0 ");
            InitTaxiNodesForLevel();
            switch (getClass())
            {
                case CLASS_WARRIOR:
                    TeleportTo(1, 1980.852173, -4797.317383, 56.038826, 4.276412, 0);
                    break;
                case CLASS_PALADIN:
                    TeleportTo(1, 1936.041260, -4137.010254, 40.918613, 0.832872, 0);
                    break;
                case CLASS_HUNTER:
                    TeleportTo(1, 2084.959961, -4623.77002, 58.676102, 0.15708, 0);
                    break;
                case CLASS_ROGUE:
                    TeleportTo(1, 1777.062012, -4286.221680, 7.113022, 2.162591, 0);
                    break;
                case CLASS_PRIEST:
                    TeleportTo(1, 1455.801880, -4180.849609, 44.063820, 2.869229, 0);
                    break;
                case CLASS_SHAMAN:
                    TeleportTo(1, 1930.528076, -4210.815430, 42.095303, 6.012136, 0);
                    break;
                case CLASS_MAGE:
                    TeleportTo(1, 1468.180054, -4219.879883, 43.0424, 5.95157, 0);
                    break;
                case CLASS_DRUID:
                    TeleportTo(1, -1042.834351, -289.17746, 159.030426, 0.138817, 0);
                    break;
                case CLASS_WARLOCK:
                    TeleportTo(1, 1844.067139, -4357.225586, -14.88052, 5.99207, 0);
                    break;
            }
            break;
        }
    }
    SaveToDB();
}


void Player::AddItem(uint32 itemID, uint32 Count)
{
        uint32 noSpaceForCount = 0;
        uint32 count = Count;

        // check space and find places
        ItemPosCountVec dest;
        uint8 msg = CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemID, count, &noSpaceForCount);
        if (msg != EQUIP_ERR_OK) // convert to possible store amount
            count = noSpaceForCount;

        if (count == 0 || dest.empty()) // can't add any
        {
            ChatHandler(this).PSendSysMessage("You don't have any space in your bags for a new item.");
            SendItemByMail(this, itemID, count);
            return;
        }

        Item* item = StoreNewItem(dest, itemID, true, Item::GenerateItemRandomPropertyId(itemID));
        if (item)
        {
         SendNewItem(item, count, true, false);
            item->SendCreateUpdateToPlayer(this);
        }
}

bool Player::StopLevel(uint64 charid)
{
    if (!charid)
        return false;

    QueryResultAutoPtr stoplevelresult = RealmDataDatabase.PQuery ("SELECT 1 "
     "FROM character_stop_level "
     "WHERE id = '%u' "
     "AND active = 1",
     charid);
    if (stoplevelresult) // if char stopped gaining of xp
    {
        return true;
    }
    return false;
}

void Player::SendItemByMail(Player *plr,uint32 item, uint32 count)
{

    ItemPrototype const* itemProto = ObjectMgr::GetItemPrototype(item);
    if (!itemProto)
        return;

    if (Item* mailItem = Item::CreateItem(item,count,plr))
    {
        // save new item before send
        mailItem->SaveToDB();                               // save for prevent lost at next mail load, if send fail then item will deleted

        int loc_idx = plr->GetSession()->GetSessionDbLocaleIndex();

        // subject: item name
        std::string subject = itemProto->Name1;
        sObjectMgr.GetItemLocaleStrings(itemProto->ItemId, loc_idx, &subject);

        // text
        std::stringstream mail_text;
        mail_text << "Ein Item konnte nicht in deiner Tasche platziert werden.\n\n";
        uint32 itemTextId = sObjectMgr.CreateItemText(mail_text.str());

        MailDraft(subject, itemTextId)
            .AddItem(mailItem)
            .SendMailTo(plr, MailSender(this, MAIL_STATIONERY_GM));
    }
}

bool Player::ShowLowLevelQuest(){
    // Check if account premium
    QueryResultAutoPtr levelresult = RealmDataDatabase.PQuery ("SELECT 1 "
     "FROM character_quest "
     "WHERE guid = '%u' "
     "AND show_low_level_quest = 1",
     GetGUID());
    if (levelresult) // if account premium
    {
        return true;
    }
    return false;
}

void Player::EnchantItem(uint32 spellid, uint8 slot)
{
    Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

    if (spellid == 0)
        return;

    if (!pItem)
    {
        ChatHandler(GetSession()).PSendSysMessage("%s[VZ NPC]%s Dein Item konnte leider nicht verzaubert werden, da sich kein Item in dem angegebenen Slot befindet.",MSG_COLOR_MAGENTA,MSG_COLOR_WHITE);
        return;
    }
    /*Special cases für die Schilde, die sind doof ._.*/
    if(pItem->GetProto()->Class == 4 && pItem->GetProto()->SubClass == 6)
        if (spellid == 44383 || spellid == 34009 || spellid == 27945 || spellid == 27947 || spellid == 27946 || spellid == 20016 || spellid == 11224 || spellid == 13464 || spellid == 23530){}
        else
        {
            ChatHandler(GetSession()).PSendSysMessage("%s[VZ NPC]%s Dein Item konnte nicht verzaubert werden, da ein falsches item angelegt ist.",MSG_COLOR_MAGENTA,MSG_COLOR_WHITE);
            return;
        }
    if (pItem->GetEntry() == 33681 || pItem->GetEntry() == 33736 || pItem->GetEntry() == 34033)
        return;

    SpellEntry const* spellInfo = sSpellStore.LookupEntry(spellid);
    if (!spellInfo)
    {
        ChatHandler(GetSession()).PSendSysMessage("Invalid spellid %u report to devs",spellid);
        return;
    }
    uint32 enchantid = spellInfo->EffectMiscValue[0];
    if (!enchantid)
    {
        ChatHandler(GetSession()).PSendSysMessage("Invalid enchantid %u report to devs", enchantid);
        return;
    }

    if (!((1 << pItem->GetProto()->SubClass) & spellInfo->EquippedItemSubClassMask) &&
        !((1 << pItem->GetProto()->InventoryType) & spellInfo->EquippedItemInventoryTypeMask))
    {
        ChatHandler(GetSession()).PSendSysMessage("%s[VZ NPC]%s Dein Item konnte nicht verzaubert werden, da ein falsches Item angelegt ist.",MSG_COLOR_MAGENTA,MSG_COLOR_WHITE);
        return;
    }
    //Item *item, EnchantmentSlot slot, bool apply, bool apply_dur, bool ignore_condition
    ApplyEnchantment(pItem, PERM_ENCHANTMENT_SLOT, false);
    pItem->SetEnchantment(PERM_ENCHANTMENT_SLOT, enchantid, 0, 0);
    ApplyEnchantment(pItem, PERM_ENCHANTMENT_SLOT, true);
    ChatHandler(GetSession()).PSendSysMessage("%s[VZ NPC]%s Dein Item wurde erfolgreich verzaubert!",MSG_COLOR_MAGENTA,MSG_COLOR_WHITE);
}

bool Player::isInSanctuary()
{
    return HasFlag(PLAYER_FLAGS,PLAYER_FLAGS_SANCTUARY);
}

bool Player::isMentor()
{
    uint32 isMentor = 0;
    uint32 accid = sObjectMgr.GetPlayerAccountIdByGUID(GetGUID());
    QueryResultAutoPtr result = AccountsDatabase.PQuery("SELECT acc_id FROM account_mentor WHERE acc_id = %u", accid);
    if (result)
    {
        Field* fields = result->Fetch();
        isMentor = fields[0].GetInt32();
    }

    if (isMentor == accid)
        return true;
    else
        return false;
    
}

bool Player::isMenteeWithoutMentor()
{
    uint32 isMentee = 0;
    uint32 accid = sObjectMgr.GetPlayerAccountIdByGUID(GetGUID());
    QueryResultAutoPtr result = AccountsDatabase.PQuery("SELECT mentee FROM mentoring_program WHERE mentee = %u AND mentor = 0", accid);
    if (result)
    {
        Field* fields = result->Fetch();
        isMentee = fields[0].GetInt32();
    }

    if (isMentee == accid)
        return true;
    else
        return false;
    
}

int Player::isMenteeOfAccount()
{
    uint32 acc_mentor = 0;
    uint32 accid = sObjectMgr.GetPlayerAccountIdByGUID(GetGUID());
    QueryResultAutoPtr result = AccountsDatabase.PQuery("SELECT mentor FROM mentoring_program WHERE mentee = %u", accid);
    if (result)
    {
        Field* fields = result->Fetch();
        acc_mentor = fields[0].GetInt32();
    }

    if (acc_mentor)
        return acc_mentor;
    else
        return 0;
}

int Player::GetOnlineChar(uint32 acc_id)
{
    
    uint32 char_mentor = 0;
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT guid FROM characters WHERE account = %u AND online = 1", acc_id);
    if (result)
    {
        Field* fields = result->Fetch();
        char_mentor = fields[0].GetInt32();
    }
    if (char_mentor)
        return char_mentor;
    else
        return 0;
}

void Player::ChangeRace(uint8 new_race)
{

    static uint16 CapitalForRace[12] = {0,72,76,47,69,68,81,54,530,0,911,930};

    static uint16 MountsForRace[12][7] = {
        {0,0,0,0,0,0,0},
        {2411,2414,5655,5656,18776,18777,18778},
        {1132,5665,5668,1132,18796,18797,18798},
        {5864,5872,5873,5864,18785,18786,18787},
        {8629,8631,8632,8629,18766,18767,18902},
        {13331,13332,13333,13331,13334,18791,13334},
        {15277,15290,15277,15290,18793,18794,18795},
        {8595,8563,13321,13322,18772,18773,18774},
        {8588,8591,8592,8588,18788,18789,18790},
        {0,0,0,0,0,0,0},
        {28927,29220,29221,29222,29223,29224,28936},
        {28481,29743,29744,28481,29745,29746,29747}
    };

    sLog.outLog(LOG_CHAR,"[%u] Starting race change for player %s from %u to %u",GetGUIDLow(),GetName(),getRace(),new_race);
    Races old_race = Races(getRace());

    if (bool((1 << new_race) & 0x89A) != bool((1 << old_race) & 0x89A))
    {
        sLog.outLog(LOG_CHAR,"[%u] Invalid race change, trans-faction NYI",GetGUIDLow());
        return;
    }

    const PlayerInfo* new_info = sObjectMgr.GetPlayerInfo(new_race,getClass());
    if (!new_info)
    {
        sLog.outLog(LOG_CHAR,"[%u] Invalid race/class pair: %u / %u",GetGUIDLow(),new_race,getClass());
        return;
    }

    QueryResultAutoPtr result = RealmDataDatabase.PQuery(
        "SELECT skin1,skin2,skin3 FROM race_change_skins WHERE race = %u AND gender = %u",new_race,getGender());
    if (!result)
    {
        sLog.outLog(LOG_CHAR,"[%u] skins not found (race %u gender %u)",GetGUIDLow(),new_race,getGender());
        return;
    }
    SetUInt32Value(PLAYER_BYTES,result->Fetch()[urand(0,2)].GetUInt32());

    if (getGender() == GENDER_FEMALE)
    {
        SetDisplayId(new_info->displayId_f);
        SetNativeDisplayId(new_info->displayId_f);
    }
    else
    {
        SetDisplayId(new_info->displayId_m);
        SetNativeDisplayId(new_info->displayId_m);
    }

    uint32 unitbytes0 = GetUInt32Value(UNIT_FIELD_BYTES_0) & 0xFFFFFF00;
    unitbytes0 |= new_race;
    SetUInt32Value(UNIT_FIELD_BYTES_0, unitbytes0);

    //spells
    result = RealmDataDatabase.PQuery("SELECT spell FROM race_change_spells WHERE race = %u AND class = %u",old_race,getClass());
    Field* fields;
    if (result)
    {
        do
        {
            fields = result->Fetch();
            removeSpell(fields[0].GetUInt32());
        }
        while (result->NextRow());
    }

    if (getClass() == CLASS_PRIEST)
    {
        removeSpell(2651);
        removeSpell(2652);
        removeSpell(2944);
        removeSpell(9035);
        removeSpell(10797);
        removeSpell(13896);
        removeSpell(13908);
        removeSpell(18137);
        removeSpell(32548);
        removeSpell(32676);
        removeSpell(44041);
    }

    result = RealmDataDatabase.PQuery("SELECT spell FROM race_change_spells WHERE race = %u AND class = %u",new_race,getClass());
    if (result)
    {
        do
        {
            fields = result->Fetch();
            learnSpell(fields[0].GetUInt32());
        }
        while (result->NextRow());
    }

    //reps
    setFaction(Player::getFactionForRace(new_race));
    if (!GetReputationMgr().SwitchReputation(CapitalForRace[old_race],CapitalForRace[new_race]))
        sLog.outLog(LOG_CHAR,"[%u] Problem encountered while changing reputation",GetGUIDLow());

    //Mounts
    for (uint8 type = 0;type<7;type++){
        for (uint16 i = INVENTORY_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; i++)
        {
            Item *pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem->GetEntry() == MountsForRace[old_race][type])
            {
                DestroyItem(INVENTORY_SLOT_BAG_0,i,true);
                ItemPosCountVec vector;
                vector.push_back(ItemPosCount((INVENTORY_SLOT_BAG_0 <<8) + i,1));
                StoreNewItem(vector,MountsForRace[new_race][type],true);
            }
        }
        for (uint16 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        {
            Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pBag)
            {
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                {
                    Item* pItem = pBag->GetItemByPos(j);
                    if (pItem &&  pItem->GetEntry() == MountsForRace[old_race][type])
                    {
                        DestroyItem(i,j,true);
                        ItemPosCountVec vector;
                        vector.push_back(ItemPosCount((i <<8) + j,1));
                        StoreNewItem(vector,MountsForRace[new_race][type],true);
                    }
                }
            }
        }
        for (uint16 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            Bag* pBag = (Bag*)GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pBag)
            {
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                {
                    Item* pItem = pBag->GetItemByPos(j);
                    if (pItem &&  pItem->GetEntry() == MountsForRace[old_race][type])
                    {
                        DestroyItem(i,j,true);
                        ItemPosCountVec vector;
                        vector.push_back(ItemPosCount((i <<8) + j,1));
                        StoreNewItem(vector,MountsForRace[new_race][type],true);
                    }
                }
            }
        }
    }
    sLog.outLog(LOG_CHAR,"[%u] Race change for player %s succesful",GetGUIDLow(),GetName());
}

bool Player::SatisfyQuestMonth(Quest const* qInfo, bool /*msg*/)
{
    if (!qInfo->IsMonthly() || m_monthlyquests.empty())
        return true;

    // if not found in cooldown list
    return m_monthlyquests.find(qInfo->GetQuestId()) == m_monthlyquests.end();
}

void Player::_LoadMonthlyQuestStatus(QueryResultAutoPtr result)
{
    m_monthlyquests.clear();

   if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 quest_id = fields[0].GetUInt32();
            m_lastMonthlyQuestTime = (time_t)fields[1].GetUInt64(); 
            Quest const* quest = sObjectMgr.GetQuestTemplate(quest_id);
            if (!quest)
                continue;

            m_monthlyquests.insert(quest_id);
            sLog.outDebug("Monthly quest {%u} cooldown for player (GUID: %u)", quest_id, GetGUIDLow());
        }
        while (result->NextRow());
    }

    m_MonthlyQuestChanged = false;
}

void Player::SetMonthlyQuestStatus(uint32 quest_id)
{
    m_monthlyquests.insert(quest_id);
    m_lastMonthlyQuestTime = time(NULL);   
    m_MonthlyQuestChanged = true;
}

void Player::ResetMonthlyQuestStatus()
{
    if (m_monthlyquests.empty())
        return;

    m_monthlyquests.clear();
    // DB data deleted in caller
    m_lastMonthlyQuestTime = 0;   
    m_MonthlyQuestChanged = false;
}


Unit* Player::GetNearBossInCombat()
{
    uint32 BossEntrys[61] = {18728, 17711, 16179, 16180, 16181, 15550, 15687, 16457, 17533, 17534, 17521, 18168, 15691, 15688, 16524, 15689, 17225, 15690, 18831, 19044, 17257, 21216, 21217, 21215, 21214, 21213, 21212, 19514, 18805, 19516, 19622, 23576, 23574, 23577, 23578, 24239, 23863, 17767, 17808, 17888, 17842, 17968, 22887, 22898, 22871, 22948, 22841, 23420, 22947, 22949, 22950, 22951, 22952, 22917, 24850, 24882, 25038, 25166, 25165, 25741, 25608};
    for (uint32 i=0; i<61; i++)
    {
        if (Unit *boss = FindCreature2(BossEntrys[i], 100, this))
        {
            if (boss->isInCombat()) 
                return boss;
        }
    }
    return NULL;
}

void Player::_LoadInstanceTimeRestrictions(QueryResultAutoPtr result)
{
    if (!result)
        return;

    do 
    {
        Field* fields = result->Fetch();
        _instanceResetTimes.insert(InstanceTimeMap::value_type(fields[0].GetUInt32(), fields[1].GetUInt64()));
    } while (result->NextRow());
}

void Player::_SaveInstanceTimeRestrictions()
{
    if (_instanceResetTimes.empty() || !GetSession())  
        return;

    static SqlStatementID deleteAccountInstance;
    static SqlStatementID insertIntoAccountInstance;

    SqlStatement stmt = RealmDataDatabase.CreateStatement(deleteAccountInstance, "DELETE FROM account_instance_times WHERE accountId = ?");
    stmt.PExecute(GetSession()->GetAccountId());
    
    for (InstanceTimeMap::const_iterator itr = _instanceResetTimes.begin(); itr != _instanceResetTimes.end(); ++itr)
    {
        SqlStatement stmt = RealmDataDatabase.CreateStatement(insertIntoAccountInstance, "INSERT INTO account_instance_times (accountId, instanceId, releaseTime) VALUES (?, ?, ?)");
        stmt.PExecute(GetSession()->GetAccountId(), itr->first, itr->second);
    }
}

/* Addon Helper START */

void Player::SendAddonMessage(std::string& text, char* prefix)
{
    std::string message;
    message.append(prefix);
    message.push_back(9);
    message.append(text);

    WorldPacket data(SMSG_MESSAGECHAT, 200);
    data << uint8(CHAT_MSG_WHISPER);
    data << uint32(LANG_ADDON);
    data << uint64(0); // guid
    data << uint32(LANG_ADDON);                               //language 2.1.0 ?
    data << uint64(0); // guid
    data << uint32(message.length() + 1);
    data << message;
    data << uint8(0);
    BroadcastPacketInRange(&data, MAX_VISIBILITY_DISTANCE, false, false);
}

WorldPacket Player::CreateAddonMessage(std::string& text, char* prefix)
{
    std::string message;
    message.append(prefix);
    message.push_back(9);
    message.append(text);

    WorldPacket data(SMSG_MESSAGECHAT, 200);
    data << uint8(CHAT_MSG_WHISPER);
    data << uint32(LANG_ADDON);
    data << uint64(0); // guid
    data << uint32(LANG_ADDON);                               //language 2.1.0 ?
    data << uint64(0); // guid
    data << uint32(message.length() + 1);
    data << message;
    data << uint8(0);
    return data;
}

char *GetClassString(uint8 _Class)
{
    switch (_Class)
    {
        case CLASS_WARRIOR: return "WARRIOR"; break;
        case CLASS_PALADIN: return "PALADIN"; break;
        case CLASS_HUNTER:  return "HUNTER";  break;
        case CLASS_ROGUE:   return "ROGUE";   break;
        case CLASS_PRIEST:  return "PRIEST";  break;
        case CLASS_SHAMAN:  return "SHAMAN";  break;
        case CLASS_MAGE:    return "MAGE";    break;
        case CLASS_WARLOCK: return "WARLOCK"; break;
        case CLASS_DRUID:   return "DRUID";   break;
        default: return ""; break;
    }
}

char *GetClassLocalString(uint8 _Class)
{
    switch (_Class)
    {
        case CLASS_WARRIOR: return "Warrior"; break;
        case CLASS_PALADIN: return "Paladin"; break;
        case CLASS_HUNTER:  return "Hunter";  break;
        case CLASS_ROGUE:   return "Rogue";   break;
        case CLASS_PRIEST:  return "Priest";  break;
        case CLASS_SHAMAN:  return "Shaman";  break;
        case CLASS_MAGE:    return "Mage";    break;
        case CLASS_WARLOCK: return "Warlock"; break;
        case CLASS_DRUID:   return "Druid";   break;
        default: return ""; break;
    }
}

char *GetRaceLocalString(uint8 _Race)
{
    switch (_Race)
    {
        case RACE_HUMAN:         return "Human";    break;
        case RACE_ORC:           return "Orc";      break;
        case RACE_DWARF:         return "Dwarf";    break;
        case RACE_NIGHTELF:      return "Nightelf"; break;
        case RACE_UNDEAD_PLAYER: return "Undead";   break;
        case RACE_TAUREN:        return "Tauren";   break;
        case RACE_GNOME:         return "Gnome";    break;
        case RACE_TROLL:         return "Troll";    break;
        case RACE_BLOODELF:      return "Bloodelf"; break;
        case RACE_DRAENEI:       return "Draenei";  break;
        default: return ""; break;
    }
}

class GladdyUpdate
{
public:
    std::string msg;

    GladdyUpdate(Player *p)
    {
        msg = "";
        msg.append(p->GetName());
        msg.push_back(',');
    }

    void AppendGUID(uint64 unitGUID)
    {
        std::stringstream sstream;
        sstream << "0x" << std::setfill('0') << std::setw(sizeof(uint64) * 2) << std::hex << std::uppercase << unitGUID;
        msg.append(sstream.str());
        msg.push_back(',');
    }

    void Append(uint32 data)
    {
        std::ostringstream os;
        os << data;
        msg.append(os.str());
        msg.push_back(',');
    }

    void AppendChar(char* prefix)
    {
        msg.append(prefix);
        msg.push_back(',');
    }

    void AppendLast(uint32 data)
    {
        std::ostringstream os;
        os << data;
        msg.append(os.str());
    }
};

WorldPacket Player::BuildGladdyUpdate()
{
    Powers type = getPowerType();
    int32 maxPower;
    int32 currentPower;
    if (type == POWER_RAGE)
    {
        currentPower = GetPower(type) / 10;
        maxPower = GetMaxPower(type) / 10;
    }
    else
    {
        currentPower = GetPower(type);
        maxPower = GetMaxPower(type);
    }

    GladdyUpdate update(this);
    update.AppendGUID(GetGUID());
    update.AppendChar(GetClassString(getClass())); // class
    update.AppendChar(GetClassLocalString(getClass())); // locclass
    update.AppendChar(GetRaceLocalString(getRace())); // locrace
    update.AppendChar(""); // correct
    update.Append(GetHealth());
    update.Append(GetMaxHealth());
    update.Append(currentPower);
    update.Append(maxPower);
    update.AppendLast(type);

    return CreateAddonMessage(update.msg, "Gladdy");
}

void Player::SendGladdyNotification()
{
    std::stringstream sstream;
    sstream << "0x" << std::setfill('0') << std::setw(sizeof(uint64) * 2) << std::hex << std::uppercase << GetGUID();
    std::string result = sstream.str();

    SendAddonMessage(result, "GladdyTrinketUsed");
}

/* Addon Helper FINISH */
