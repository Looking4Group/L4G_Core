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

#ifndef _PLAYER_H
#define _PLAYER_H

#include "Common.h"

#include "ItemPrototype.h"
#include "Unit.h"
#include "Item.h"

#include "Database/DatabaseEnv.h"
#include "BattleGround.h"
#include "NPCHandler.h"
#include "QuestDef.h"
#include "Group.h"
#include "Object.h"
#include "Bag.h"
#include "WorldSession.h"
#include "Pet.h"
#include "MapReference.h"
#include "Util.h"                                           // for Tokens typedef
#include "ReputationMgr.h"
#include "World.h"

#include "SpellMgr.h"       // for GetSpellBaseCastTime

#include <string>
#include <vector>

struct Mail;
class Channel;
class DynamicObject;
class Creature;
class Pet;
class PlayerMenu;
class Transport;
class UpdateMask;
class PlayerSocial;
class OutdoorPvP;
struct PlayerAI;

typedef std::deque<Mail*> PlayerMails;

#define PLAYER_MAX_SKILLS       127

//lovely colors :>
#define MSG_COLOR_LIGHTRED     "|cffff6060"
#define MSG_COLOR_LIGHTBLUE    "|cff00ccff"
#define MSG_COLOR_ANN_GREEN    "|c1f40af20"
#define MSG_COLOR_RED          "|cffff0000"
#define MSG_COLOR_GOLD         "|cffffcc00"
#define MSG_COLOR_SUBWHITE     "|cffbbbbbb"
#define MSG_COLOR_MAGENTA      "|cffff00ff"
#define MSG_COLOR_YELLOW       "|cffffff00"
#define MSG_COLOR_CYAN         "|cff00ffff"
#define MSG_COLOR_DARKBLUE     "|cff0000ff"

#define MSG_COLOR_GREY         "|cff9d9d9d"
#define MSG_COLOR_WHITE        "|cffffffff"
#define MSG_COLOR_GREEN        "|cff1eff00"
#define MSG_COLOR_BLUE         "|cff0080ff"
#define MSG_COLOR_PURPLE       "|cffb048f8"
#define MSG_COLOR_ORANGE       "|cffff8000"

#define MSG_COLOR_DRUID        "|cffff7d0a"
#define MSG_COLOR_HUNTER       "|cffabd473"
#define MSG_COLOR_MAGE         "|cff69ccf0"
#define MSG_COLOR_PALADIN      "|cfff58cba"
#define MSG_COLOR_PRIEST       "|cffffffff"
#define MSG_COLOR_ROGUE        "|cfffff569"
#define MSG_COLOR_SHAMAN       "|cff0070de"
#define MSG_COLOR_WARLOCK      "|cff9482c9"
#define MSG_COLOR_WARRIOR      "|cffc79c6e"

// Note: SPELLMOD_* values is aura types in fact
enum SpellModType
{
    SPELLMOD_FLAT         = 107,                            // SPELL_AURA_ADD_FLAT_MODIFIER
    SPELLMOD_PCT          = 108                             // SPELL_AURA_ADD_PCT_MODIFIER
};

// 2^n values, Player::m_isunderwater is a bitmask. These are internal values, they are never send to any client
enum PlayerUnderwaterState
{
    UNDERWATER_NONE                     = 0x00,
    UNDERWATER_INWATER                  = 0x01,             // terrain type is water and player is afflicted by it
    UNDERWATER_INLAVA                   = 0x02,             // terrain type is lava and player is afflicted by it
    UNDERWATER_INSLIME                  = 0x04,             // terrain type is lava and player is afflicted by it
    UNDERWATER_INDARKWATER              = 0x08,             // terrain type is dark water and player is afflicted by it

    UNDERWATER_EXIST_TIMERS             = 0x10
};

enum PlayerSpellState
{
    PLAYERSPELL_UNCHANGED = 0,
    PLAYERSPELL_CHANGED   = 1,
    PLAYERSPELL_NEW       = 2,
    PLAYERSPELL_REMOVED   = 3
};

struct PlayerSpell
{
    uint16 slotId          : 16;
    PlayerSpellState state : 8;
    bool active            : 1;
    bool disabled          : 1;
};

#define SPELL_WITHOUT_SLOT_ID uint16(-1)

struct SpellModifier
{
    SpellModOp   op   : 8;
    SpellModType type : 8;
    int16 charges     : 16;
    int32 value;
    uint64 mask;
    uint32 spellId;
    uint32 effectId;
    Spell const* lastAffected;
};

typedef UNORDERED_MAP<uint16, PlayerSpell> PlayerSpellMap;
typedef std::list<SpellModifier*> SpellModList;

struct SpellCooldown
{
    time_t end;
    uint16 itemid;
};

typedef std::map<uint32, SpellCooldown> SpellCooldowns;

#define MAX_INSTANCES_PER_HOUR 5
typedef UNORDERED_MAP<uint32 /*instanceId*/, time_t/*releaseTime*/> InstanceTimeMap;

enum TrainerSpellState
{
    TRAINER_SPELL_GREEN = 0,
    TRAINER_SPELL_RED   = 1,
    TRAINER_SPELL_GRAY  = 2
};

enum ActionButtonUpdateState
{
    ACTIONBUTTON_UNCHANGED = 0,
    ACTIONBUTTON_CHANGED   = 1,
    ACTIONBUTTON_NEW       = 2,
    ACTIONBUTTON_DELETED   = 3
};

struct ActionButton
{
    ActionButton() : action(0), type(0), misc(0), uState(ACTIONBUTTON_NEW) {}
    ActionButton(uint16 _action, uint8 _type, uint8 _misc) : action(_action), type(_type), misc(_misc), uState(ACTIONBUTTON_NEW) {}

    uint16 action;
    uint8 type;
    uint8 misc;
    ActionButtonUpdateState uState;
};

enum ActionButtonType
{
    ACTION_BUTTON_SPELL = 0,
    ACTION_BUTTON_MACRO = 64,
    ACTION_BUTTON_CMACRO= 65,
    ACTION_BUTTON_ITEM  = 128
};

#define  MAX_ACTION_BUTTONS 132                             //checked in 2.3.0

enum RestState
{
    REST_STATE_RESTED = 0x01,
    REST_STATE_NORMAL = 0x02,
    REST_STATE_RAF = 0x06
};

enum ReferAFriendError
{
    ERR_REFER_A_FRIEND_NONE = 0x00,
    ERR_REFER_A_FRIEND_NOT_REFERRED_BY = 0x01,
    ERR_REFER_A_FRIEND_TARGET_TOO_HIGH = 0x02,
    ERR_REFER_A_FRIEND_INSUFFICIENT_GRANTABLE_LEVELS = 0x03,
    ERR_REFER_A_FRIEND_TOO_FAR = 0x04,
    ERR_REFER_A_FRIEND_DIFFERENT_FACTION = 0x05,
    ERR_REFER_A_FRIEND_NOT_NOW = 0x06,
    ERR_REFER_A_FRIEND_GRANT_LEVEL_MAX_I = 0x07,
    ERR_REFER_A_FRIEND_NO_TARGET = 0x08,
    ERR_REFER_A_FRIEND_NOT_IN_GROUP = 0x09,
    ERR_REFER_A_FRIEND_SUMMON_LEVEL_MAX_I = 0x0A,
    ERR_REFER_A_FRIEND_SUMMON_COOLDOWN = 0x0B,
    ERR_REFER_A_FRIEND_INSUF_EXPAN_LVL = 0x0C,
    ERR_REFER_A_FRIEND_SUMMON_OFFLINE_S = 0x0D
};

enum AccountLinkedState
{
    STATE_NOT_LINKED = 0x00,
    STATE_REFER = 0x01,
    STATE_REFERRAL = 0x02,
    STATE_DUAL = 0x04,
};


typedef std::map<uint8,ActionButton> ActionButtonList;

typedef std::pair<uint16, uint8> CreateSpellPair;

struct PlayerCreateInfoItem
{
    PlayerCreateInfoItem(uint32 id, uint32 amount) : item_id(id), item_amount(amount) {}

    uint32 item_id;
    uint32 item_amount;
};

typedef std::list<PlayerCreateInfoItem> PlayerCreateInfoItems;

struct PlayerClassLevelInfo
{
    PlayerClassLevelInfo() : basehealth(0), basemana(0) {}
    uint16 basehealth;
    uint16 basemana;
};

struct PlayerClassInfo
{
    PlayerClassInfo() : levelInfo(NULL) { }

    PlayerClassLevelInfo* levelInfo;                        //[level-1] 0..MaxPlayerLevel-1
};

struct PlayerLevelInfo
{
    PlayerLevelInfo() { for (int i=0; i < MAX_STATS; ++i) stats[i] = 0; }

    uint8 stats[MAX_STATS];
};

struct PlayerInfo
{
                                                            // existence checked by displayId != 0             // existence checked by displayId != 0
    PlayerInfo() : displayId_m(0),displayId_f(0),levelInfo(NULL)
    {
    }

    uint32 mapId;
    uint32 zoneId;
    float positionX;
    float positionY;
    float positionZ;
    uint16 displayId_m;
    uint16 displayId_f;
    PlayerCreateInfoItems item;
    std::list<CreateSpellPair> spell;
    std::list<uint16> action[4];

    PlayerLevelInfo* levelInfo;                             //[level-1] 0..MaxPlayerLevel-1
};

struct PvPInfo
{
    PvPInfo() : inHostileArea(false), endTimer(0) {}

    bool inHostileArea;
    time_t endTimer;
};

struct DuelInfo
{
    DuelInfo() : initiator(NULL), opponent(NULL), startTimer(0), startTime(0), outOfBound(0) {}

    Player *initiator;
    Player *opponent;
    time_t startTimer;
    time_t startTime;
    time_t outOfBound;
};

struct Areas
{
    uint32 areaID;
    uint32 areaFlag;
    float x1;
    float x2;
    float y1;
    float y2;
};

typedef std::set<uint64> GuardianPetList;

struct EnchantDuration
{
    EnchantDuration() : item(NULL), slot(MAX_ENCHANTMENT_SLOT), leftduration(0) {};
    EnchantDuration(Item * _item, EnchantmentSlot _slot, uint32 _leftduration) : item(_item), slot(_slot), leftduration(_leftduration) { ASSERT(item); };

    Item * item;
    EnchantmentSlot slot;
    uint32 leftduration;
};

typedef std::list<EnchantDuration> EnchantDurationList;
typedef std::list<Item*> ItemDurationList;


#define MAX_LOOKING_FOR_GROUP_SLOT 3
#define LFG_COMBINE(a, b)   uint32(a | (b << 24))

struct LookingForGroupSlot
{
    LookingForGroupSlot() : entry(0), type(0) {}
    bool Empty() const { return !entry || !type; }
    void Clear() { entry = 0; type = 0; }
    void Set(uint32 _entry, uint32 _type) { entry = _entry; type = _type; }
    bool Is(uint32 _entry, uint32 _type) const { return entry==_entry && type==_type; }
    bool canAutoJoin() const { return entry && (type == 1 || type == 5); }
    uint32 Combine() { return LFG_COMBINE(entry, type); }

    uint32 entry;
    uint32 type;
};

struct LookingForGroup
{
    LookingForGroup() {}
    bool HaveInSlot(LookingForGroupSlot const& slot) const { return HaveInSlot(slot.entry,slot.type); }
    bool HaveInSlot(uint32 _entry, uint32 _type) const
    {
        for (uint8 i = 0; i < MAX_LOOKING_FOR_GROUP_SLOT; ++i)
            if (slots[i].Is(_entry,_type))
                return true;
        return false;
    }

    bool Have(uint32 type, uint32 entry)
    {
        if (Empty())
            return false;

        for (uint8 i = 0; i < MAX_LOOKING_FOR_GROUP_SLOT; ++i)
            if (slots[i].Is(entry, type))
                return true;

        return more.Is(entry, type);
    }

    bool canAutoJoin() const
    {
        for (uint8 i = 0; i < MAX_LOOKING_FOR_GROUP_SLOT; ++i)
            if (slots[i].canAutoJoin())
                return true;

        return false;
    }

    bool Empty() const
    {
        for (uint8 i = 0; i < MAX_LOOKING_FOR_GROUP_SLOT; ++i)
            if (!slots[i].Empty())
                return false;

        return more.Empty();
    }

    LookingForGroupSlot slots[MAX_LOOKING_FOR_GROUP_SLOT];
    LookingForGroupSlot more;
    std::string comment;
};

enum PlayerMovementType
{
    MOVE_ROOT       = 1,
    MOVE_UNROOT     = 2,
    MOVE_WATER_WALK = 3,
    MOVE_LAND_WALK  = 4
};

enum DrunkenState
{
    DRUNKEN_SOBER   = 0,
    DRUNKEN_TIPSY   = 1,
    DRUNKEN_DRUNK   = 2,
    DRUNKEN_SMASHED = 3
};

enum PlayerStateType
{
    /*
        PLAYER_STATE_DANCE
        PLAYER_STATE_SLEEP
        PLAYER_STATE_SIT
        PLAYER_STATE_STAND
        PLAYER_STATE_READYUNARMED
        PLAYER_STATE_WORK
        PLAYER_STATE_POINT(DNR)
        PLAYER_STATE_NONE // not used or just no state, just standing there?
        PLAYER_STATE_STUN
        PLAYER_STATE_DEAD
        PLAYER_STATE_KNEEL
        PLAYER_STATE_USESTANDING
        PLAYER_STATE_STUN_NOSHEATHE
        PLAYER_STATE_USESTANDING_NOSHEATHE
        PLAYER_STATE_WORK_NOSHEATHE
        PLAYER_STATE_SPELLPRECAST
        PLAYER_STATE_READYRIFLE
        PLAYER_STATE_WORK_NOSHEATHE_MINING
        PLAYER_STATE_WORK_NOSHEATHE_CHOPWOOD
        PLAYER_STATE_AT_EASE
        PLAYER_STATE_READY1H
        PLAYER_STATE_SPELLKNEELSTART
        PLAYER_STATE_SUBMERGED
    */

    PLAYER_STATE_NONE              = 0,
    PLAYER_STATE_SIT               = 1,
    PLAYER_STATE_SIT_CHAIR         = 2,
    PLAYER_STATE_SLEEP             = 3,
    PLAYER_STATE_SIT_LOW_CHAIR     = 4,
    PLAYER_STATE_SIT_MEDIUM_CHAIR  = 5,
    PLAYER_STATE_SIT_HIGH_CHAIR    = 6,
    PLAYER_STATE_DEAD              = 7,
    PLAYER_STATE_KNEEL             = 8,

    PLAYER_STATE_FORM_ALL          = 0x00FF0000,

    PLAYER_STATE_FLAG_ALWAYS_STAND = 0x01,                  // byte 4
    PLAYER_STATE_FLAG_CREEP        = 0x02000000,
    PLAYER_STATE_FLAG_UNTRACKABLE  = 0x04000000,
    PLAYER_STATE_FLAG_ALL          = 0xFF000000,
};

enum PlayerFlags
{
    PLAYER_FLAGS_GROUP_LEADER   = 0x00000001,
    PLAYER_FLAGS_AFK            = 0x00000002,
    PLAYER_FLAGS_DND            = 0x00000004,
    PLAYER_FLAGS_GM             = 0x00000008,
    PLAYER_FLAGS_GHOST          = 0x00000010,
    PLAYER_FLAGS_RESTING        = 0x00000020,
    PLAYER_FLAGS_FFA_PVP        = 0x00000080,
    PLAYER_FLAGS_CONTESTED_PVP  = 0x00000100,               // Player has been involved in a PvP combat and will be attacked by contested guards
    PLAYER_FLAGS_IN_PVP         = 0x00000200,
    PLAYER_FLAGS_HIDE_HELM      = 0x00000400,
    PLAYER_FLAGS_HIDE_CLOAK     = 0x00000800,
    PLAYER_FLAGS_UNK1           = 0x00001000,               // played long time
    PLAYER_FLAGS_UNK2           = 0x00002000,               // played too long time
    PLAYER_FLAGS_UNK3           = 0x00008000,               // strange visual effect (2.0.1), looks like PLAYER_FLAGS_GHOST flag
    PLAYER_FLAGS_SANCTUARY      = 0x00010000,               // player entered sanctuary
    PLAYER_FLAGS_UNK4           = 0x00020000,               // taxi benchmark mode (on/off) (2.0.1)
    PLAYER_UNK                  = 0x00040000,               // in 3.0.2, pvp timer active (after you disable pvp manually)
};

// used for PLAYER__FIELD_KNOWN_TITLES field (uint64), (1<<bit_index) without (-1)
// can't use enum for uint64 values
#define PLAYER_TITLE_DISABLED              0x0000000000000000LL
#define PLAYER_TITLE_NONE                  0x0000000000000001LL
#define PLAYER_TITLE_PRIVATE               0x0000000000000002LL // 1
#define PLAYER_TITLE_CORPORAL              0x0000000000000004LL // 2
#define PLAYER_TITLE_SERGEANT_A            0x0000000000000008LL // 3
#define PLAYER_TITLE_MASTER_SERGEANT       0x0000000000000010LL // 4
#define PLAYER_TITLE_SERGEANT_MAJOR        0x0000000000000020LL // 5
#define PLAYER_TITLE_KNIGHT                0x0000000000000040LL // 6
#define PLAYER_TITLE_KNIGHT_LIEUTENANT     0x0000000000000080LL // 7
#define PLAYER_TITLE_KNIGHT_CAPTAIN        0x0000000000000100LL // 8
#define PLAYER_TITLE_KNIGHT_CHAMPION       0x0000000000000200LL // 9
#define PLAYER_TITLE_LIEUTENANT_COMMANDER  0x0000000000000400LL // 10
#define PLAYER_TITLE_COMMANDER             0x0000000000000800LL // 11
#define PLAYER_TITLE_MARSHAL               0x0000000000001000LL // 12
#define PLAYER_TITLE_FIELD_MARSHAL         0x0000000000002000LL // 13
#define PLAYER_TITLE_GRAND_MARSHAL         0x0000000000004000LL // 14
#define PLAYER_TITLE_SCOUT                 0x0000000000008000LL // 15
#define PLAYER_TITLE_GRUNT                 0x0000000000010000LL // 16
#define PLAYER_TITLE_SERGEANT_H            0x0000000000020000LL // 17
#define PLAYER_TITLE_SENIOR_SERGEANT       0x0000000000040000LL // 18
#define PLAYER_TITLE_FIRST_SERGEANT        0x0000000000080000LL // 19
#define PLAYER_TITLE_STONE_GUARD           0x0000000000100000LL // 20
#define PLAYER_TITLE_BLOOD_GUARD           0x0000000000200000LL // 21
#define PLAYER_TITLE_LEGIONNAIRE           0x0000000000400000LL // 22
#define PLAYER_TITLE_CENTURION             0x0000000000800000LL // 23
#define PLAYER_TITLE_CHAMPION              0x0000000001000000LL // 24
#define PLAYER_TITLE_LIEUTENANT_GENERAL    0x0000000002000000LL // 25
#define PLAYER_TITLE_GENERAL               0x0000000004000000LL // 26
#define PLAYER_TITLE_WARLORD               0x0000000008000000LL // 27
#define PLAYER_TITLE_HIGH_WARLORD          0x0000000010000000LL // 28
#define PLAYER_TITLE_GLADIATOR             0x0000000020000000LL // 29
#define PLAYER_TITLE_DUELIST               0x0000000040000000LL // 30
#define PLAYER_TITLE_RIVAL                 0x0000000080000000LL // 31
#define PLAYER_TITLE_CHALLENGER            0x0000000100000000LL // 32
#define PLAYER_TITLE_SCARAB_LORD           0x0000000200000000LL // 33
#define PLAYER_TITLE_CONQUEROR             0x0000000400000000LL // 34
#define PLAYER_TITLE_JUSTICAR              0x0000000800000000LL // 35
#define PLAYER_TITLE_CHAMPION_OF_THE_NAARU 0x0000001000000000LL // 36
#define PLAYER_TITLE_MERCILESS_GLADIATOR   0x0000002000000000LL // 37
#define PLAYER_TITLE_OF_THE_SHATTERED_SUN  0x0000004000000000LL // 38
#define PLAYER_TITLE_HAND_OF_ADAL          0x0000008000000000LL // 39
#define PLAYER_TITLE_VENGEFUL_GLADIATOR    0x0000010000000000LL // 40

#define MAX_PVP_RANKS 14

#define PLAYER_TITLE_PVP \
       (PLAYER_TITLE_PRIVATE | PLAYER_TITLE_CORPORAL |  \
        PLAYER_TITLE_SERGEANT_A | PLAYER_TITLE_MASTER_SERGEANT | \
        PLAYER_TITLE_SERGEANT_MAJOR | PLAYER_TITLE_KNIGHT | \
        PLAYER_TITLE_KNIGHT_LIEUTENANT | PLAYER_TITLE_KNIGHT_CAPTAIN | \
        PLAYER_TITLE_KNIGHT_CHAMPION | PLAYER_TITLE_LIEUTENANT_COMMANDER | \
        PLAYER_TITLE_COMMANDER | PLAYER_TITLE_MARSHAL | \
        PLAYER_TITLE_FIELD_MARSHAL | PLAYER_TITLE_GRAND_MARSHAL | \
        PLAYER_TITLE_SCOUT | PLAYER_TITLE_GRUNT | \
        PLAYER_TITLE_SERGEANT_H | PLAYER_TITLE_SENIOR_SERGEANT | \
        PLAYER_TITLE_FIRST_SERGEANT | PLAYER_TITLE_STONE_GUARD | \
        PLAYER_TITLE_BLOOD_GUARD | PLAYER_TITLE_LEGIONNAIRE | \
        PLAYER_TITLE_CENTURION | PLAYER_TITLE_CHAMPION | \
        PLAYER_TITLE_LIEUTENANT_GENERAL | PLAYER_TITLE_GENERAL | \
        PLAYER_TITLE_WARLORD | PLAYER_TITLE_HIGH_WARLORD)

// used in PLAYER_FIELD_BYTES values
enum PlayerFieldByteFlags
{
    PLAYER_FIELD_BYTE_TRACK_STEALTHED   = 0x00000002,
    PLAYER_FIELD_BYTE_RELEASE_TIMER     = 0x00000008,       // Display time till auto release spirit
    PLAYER_FIELD_BYTE_NO_RELEASE_WINDOW = 0x00000010        // Display no "release spirit" window at all
};

// used in PLAYER_FIELD_BYTES2 values
enum PlayerFieldByte2Flags
{
    PLAYER_FIELD_BYTE2_NONE              = 0x0000,
    PLAYER_FIELD_BYTE2_INVISIBILITY_GLOW = 0x4000
};

enum ActivateTaxiReplies
{
    ERR_TAXIOK                      = 0,
    ERR_TAXIUNSPECIFIEDSERVERERROR  = 1,
    ERR_TAXINOSUCHPATH              = 2,
    ERR_TAXINOTENOUGHMONEY          = 3,
    ERR_TAXITOOFARAWAY              = 4,
    ERR_TAXINOVENDORNEARBY          = 5,
    ERR_TAXINOTVISITED              = 6,
    ERR_TAXIPLAYERBUSY              = 7,
    ERR_TAXIPLAYERALREADYMOUNTED    = 8,
    ERR_TAXIPLAYERSHAPESHIFTED      = 9,
    ERR_TAXIPLAYERMOVING            = 10,
    ERR_TAXISAMENODE                = 11,
    ERR_TAXINOTSTANDING             = 12
};

enum LootType
{
    LOOT_CORPSE                 = 1,
    LOOT_SKINNING               = 2,
    LOOT_FISHING                = 3,
    LOOT_PICKPOCKETING          = 4,                        // unsupported by client, sending LOOT_SKINNING instead
    LOOT_DISENCHANTING          = 5,                        // unsupported by client, sending LOOT_SKINNING instead
    LOOT_PROSPECTING            = 6,                        // unsupported by client, sending LOOT_SKINNING instead
    LOOT_INSIGNIA               = 7,                        // unsupported by client, sending LOOT_SKINNING instead
    LOOT_FISHINGHOLE            = 8                         // unsupported by client, sending LOOT_FISHING instead
};

enum MirrorTimerType
{
    FATIGUE_TIMER      = 0,
    BREATH_TIMER       = 1,
    FIRE_TIMER         = 2
};
#define MAX_TIMERS      3
#define DISABLED_MIRROR_TIMER   -1

// 2^n values
enum PlayerExtraFlags
{
    // gm abilities
    PLAYER_EXTRA_GM_ON              = 0x0001,
    PLAYER_EXTRA_ACCEPT_WHISPERS    = 0x0004,
    PLAYER_EXTRA_TAXICHEAT          = 0x0008,
    PLAYER_EXTRA_GM_INVISIBLE       = 0x0010,
    PLAYER_EXTRA_GM_CHAT            = 0x0020,               // Show GM badge in chat messages

    // other states
    PLAYER_EXTRA_PVP_DEATH          = 0x0100                // store PvP death status until corpse creating.
};

// 2^n values
enum AtLoginFlags
{
    AT_LOGIN_NONE           = 0x0,
    AT_LOGIN_RENAME         = 0x1,
    AT_LOGIN_RESET_SPELLS   = 0x2,
    AT_LOGIN_RESET_TALENTS  = 0x4,
    AT_LOGIN_DISPLAY_CHANGE = 0x8
};

typedef std::map<uint32, QuestStatusData> QuestStatusMap;

enum QuestSlotOffsets
{
    QUEST_ID_OFFSET     = 0,
    QUEST_STATE_OFFSET  = 1,
    QUEST_COUNTS_OFFSET = 2,
    QUEST_TIME_OFFSET   = 3
};

#define MAX_QUEST_OFFSET 4

enum QuestSlotStateMask
{
    QUEST_STATE_NONE     = 0x0000,
    QUEST_STATE_COMPLETE = 0x0001,
    QUEST_STATE_FAIL     = 0x0002
};

class Quest;
class Spell;
class Item;
class WorldSession;

enum PlayerSlots
{
    // first slot for item stored (in any way in player m_items data)
    PLAYER_SLOT_START           = 0,
    // last+1 slot for item stored (in any way in player m_items data)
    PLAYER_SLOT_END             = 118,
    PLAYER_SLOTS_COUNT          = (PLAYER_SLOT_END - PLAYER_SLOT_START)
};

enum EquipmentSlots
{
    EQUIPMENT_SLOT_START        = 0,
    EQUIPMENT_SLOT_HEAD         = 0,
    EQUIPMENT_SLOT_NECK         = 1,
    EQUIPMENT_SLOT_SHOULDERS    = 2,
    EQUIPMENT_SLOT_BODY         = 3,
    EQUIPMENT_SLOT_CHEST        = 4,
    EQUIPMENT_SLOT_WAIST        = 5,
    EQUIPMENT_SLOT_LEGS         = 6,
    EQUIPMENT_SLOT_FEET         = 7,
    EQUIPMENT_SLOT_WRISTS       = 8,
    EQUIPMENT_SLOT_HANDS        = 9,
    EQUIPMENT_SLOT_FINGER1      = 10,
    EQUIPMENT_SLOT_FINGER2      = 11,
    EQUIPMENT_SLOT_TRINKET1     = 12,
    EQUIPMENT_SLOT_TRINKET2     = 13,
    EQUIPMENT_SLOT_BACK         = 14,
    EQUIPMENT_SLOT_MAINHAND     = 15,
    EQUIPMENT_SLOT_OFFHAND      = 16,
    EQUIPMENT_SLOT_RANGED       = 17,
    EQUIPMENT_SLOT_TABARD       = 18,
    EQUIPMENT_SLOT_END          = 19
};

enum InventorySlots
{
    INVENTORY_SLOT_BAG_0        = 255,
    INVENTORY_SLOT_BAG_START    = 19,
    INVENTORY_SLOT_BAG_1        = 19,
    INVENTORY_SLOT_BAG_2        = 20,
    INVENTORY_SLOT_BAG_3        = 21,
    INVENTORY_SLOT_BAG_4        = 22,
    INVENTORY_SLOT_BAG_END      = 23,

    INVENTORY_SLOT_ITEM_START   = 23,
    INVENTORY_SLOT_ITEM_1       = 23,
    INVENTORY_SLOT_ITEM_2       = 24,
    INVENTORY_SLOT_ITEM_3       = 25,
    INVENTORY_SLOT_ITEM_4       = 26,
    INVENTORY_SLOT_ITEM_5       = 27,
    INVENTORY_SLOT_ITEM_6       = 28,
    INVENTORY_SLOT_ITEM_7       = 29,
    INVENTORY_SLOT_ITEM_8       = 30,
    INVENTORY_SLOT_ITEM_9       = 31,
    INVENTORY_SLOT_ITEM_10      = 32,
    INVENTORY_SLOT_ITEM_11      = 33,
    INVENTORY_SLOT_ITEM_12      = 34,
    INVENTORY_SLOT_ITEM_13      = 35,
    INVENTORY_SLOT_ITEM_14      = 36,
    INVENTORY_SLOT_ITEM_15      = 37,
    INVENTORY_SLOT_ITEM_16      = 38,
    INVENTORY_SLOT_ITEM_END     = 39
};

enum BankSlots
{
    BANK_SLOT_ITEM_START        = 39,
    BANK_SLOT_ITEM_1            = 39,
    BANK_SLOT_ITEM_2            = 40,
    BANK_SLOT_ITEM_3            = 41,
    BANK_SLOT_ITEM_4            = 42,
    BANK_SLOT_ITEM_5            = 43,
    BANK_SLOT_ITEM_6            = 44,
    BANK_SLOT_ITEM_7            = 45,
    BANK_SLOT_ITEM_8            = 46,
    BANK_SLOT_ITEM_9            = 47,
    BANK_SLOT_ITEM_10           = 48,
    BANK_SLOT_ITEM_11           = 49,
    BANK_SLOT_ITEM_12           = 50,
    BANK_SLOT_ITEM_13           = 51,
    BANK_SLOT_ITEM_14           = 52,
    BANK_SLOT_ITEM_15           = 53,
    BANK_SLOT_ITEM_16           = 54,
    BANK_SLOT_ITEM_17           = 55,
    BANK_SLOT_ITEM_18           = 56,
    BANK_SLOT_ITEM_19           = 57,
    BANK_SLOT_ITEM_20           = 58,
    BANK_SLOT_ITEM_21           = 59,
    BANK_SLOT_ITEM_22           = 60,
    BANK_SLOT_ITEM_23           = 61,
    BANK_SLOT_ITEM_24           = 62,
    BANK_SLOT_ITEM_25           = 63,
    BANK_SLOT_ITEM_26           = 64,
    BANK_SLOT_ITEM_27           = 65,
    BANK_SLOT_ITEM_28           = 66,
    BANK_SLOT_ITEM_END          = 67,

    BANK_SLOT_BAG_START         = 67,
    BANK_SLOT_BAG_1             = 67,
    BANK_SLOT_BAG_2             = 68,
    BANK_SLOT_BAG_3             = 69,
    BANK_SLOT_BAG_4             = 70,
    BANK_SLOT_BAG_5             = 71,
    BANK_SLOT_BAG_6             = 72,
    BANK_SLOT_BAG_7             = 73,
    BANK_SLOT_BAG_END           = 74
};

enum BuyBackSlots
{
    // stored in m_buybackitems
    BUYBACK_SLOT_START          = 74,
    BUYBACK_SLOT_1              = 74,
    BUYBACK_SLOT_2              = 75,
    BUYBACK_SLOT_3              = 76,
    BUYBACK_SLOT_4              = 77,
    BUYBACK_SLOT_5              = 78,
    BUYBACK_SLOT_6              = 79,
    BUYBACK_SLOT_7              = 80,
    BUYBACK_SLOT_8              = 81,
    BUYBACK_SLOT_9              = 82,
    BUYBACK_SLOT_10             = 83,
    BUYBACK_SLOT_11             = 84,
    BUYBACK_SLOT_12             = 85,
    BUYBACK_SLOT_END            = 86
};

enum KeyRingSlots
{
    KEYRING_SLOT_START          = 86,
    KEYRING_SLOT_END            = 118
};

struct ItemPosCount
{
    ItemPosCount(uint16 _pos, uint8 _count) : pos(_pos), count(_count) {}
    bool isContainedIn(std::vector<ItemPosCount> const& vec) const;
    uint16 pos;
    uint8 count;
};
typedef std::vector<ItemPosCount> ItemPosCountVec;

enum TradeSlots
{
    TRADE_SLOT_COUNT            = 7,
    TRADE_SLOT_TRADED_COUNT     = 6,
    TRADE_SLOT_NONTRADED        = 6
};

enum TransferAbortReason
{
    TRANSFER_ABORT_MAX_PLAYERS          = 0x0001,           // Transfer Aborted: instance is full
    TRANSFER_ABORT_NOT_FOUND            = 0x0002,           // Transfer Aborted: instance not found
    TRANSFER_ABORT_TOO_MANY_INSTANCES   = 0x0003,           // You have entered too many instances recently.
    TRANSFER_ABORT_ZONE_IN_COMBAT       = 0x0005,           // Unable to zone in while an encounter is in progress.
    TRANSFER_ABORT_INSUF_EXPAN_LVL1     = 0x0106,           // You must have TBC expansion installed to access this area.
    TRANSFER_ABORT_DIFFICULTY1          = 0x0007,           // Normal difficulty mode is not available for %s.
    TRANSFER_ABORT_DIFFICULTY2          = 0x0107,           // Heroic difficulty mode is not available for %s.
    TRANSFER_ABORT_DIFFICULTY3          = 0x0207            // Epic difficulty mode is not available for %s.
};

enum InstanceResetWarningType
{
    RAID_INSTANCE_WARNING_HOURS     = 1,                    // WARNING! %s is scheduled to reset in %d hour(s).
    RAID_INSTANCE_WARNING_MIN       = 2,                    // WARNING! %s is scheduled to reset in %d minute(s)!
    RAID_INSTANCE_WARNING_MIN_SOON  = 3,                    // WARNING! %s is scheduled to reset in %d minute(s). Please exit the zone or you will be returned to your bind location!
    RAID_INSTANCE_WELCOME           = 4                     // Welcome to %s. This raid instance is scheduled to reset in %s.
};

class InstanceSave;

enum RestType
{
    REST_TYPE_NO        = 0,
    REST_TYPE_IN_TAVERN = 1,
    REST_TYPE_IN_CITY   = 2
};

enum DuelCompleteType
{
    DUEL_INTERUPTED = 0,
    DUEL_WON        = 1,
    DUEL_FLED       = 2
};

enum TeleportToOptions
{
    TELE_TO_GM_MODE             = 0x01,
    TELE_TO_NOT_LEAVE_TRANSPORT = 0x02,
    TELE_TO_NOT_LEAVE_COMBAT    = 0x04,
    TELE_TO_NOT_UNSUMMON_PET    = 0x08,
    TELE_TO_SPELL               = 0x10,
};

/// Type of environmental damages
enum EnviromentalDamage
{
    DAMAGE_EXHAUSTED = 0,
    DAMAGE_DROWNING  = 1,
    DAMAGE_FALL      = 2,
    DAMAGE_LAVA      = 3,
    DAMAGE_SLIME     = 4,
    DAMAGE_FIRE      = 5,
    DAMAGE_FALL_TO_VOID = 6                                 // custom case for fall without durability loss
};

enum PlayedTimeIndex
{
    PLAYED_TIME_TOTAL = 0,
    PLAYED_TIME_LEVEL = 1
};

#define MAX_PLAYED_TIME_INDEX 2

// used at player loading query list preparing, and later result selection
enum PlayerLoginQueryIndex
{
    PLAYER_LOGIN_QUERY_LOADFROM                 = 0,
    PLAYER_LOGIN_QUERY_LOADGROUP                = 1,
    PLAYER_LOGIN_QUERY_LOADBOUNDINSTANCES       = 2,
    PLAYER_LOGIN_QUERY_LOADAURAS                = 3,
    PLAYER_LOGIN_QUERY_LOADSPELLS               = 4,
    PLAYER_LOGIN_QUERY_LOADQUESTSTATUS          = 5,
    PLAYER_LOGIN_QUERY_LOADDAILYQUESTSTATUS     = 6,
    PLAYER_LOGIN_QUERY_LOADTUTORIALS            = 7,        // common for all characters for some account at specific realm
    PLAYER_LOGIN_QUERY_LOADREPUTATION           = 8,
    PLAYER_LOGIN_QUERY_LOADINVENTORY            = 9,
    PLAYER_LOGIN_QUERY_LOADACTIONS              = 10,
    PLAYER_LOGIN_QUERY_LOADSOCIALLIST           = 11,
    PLAYER_LOGIN_QUERY_LOADHOMEBIND             = 12,
    PLAYER_LOGIN_QUERY_LOADSPELLCOOLDOWNS       = 13,
    PLAYER_LOGIN_QUERY_LOADDECLINEDNAMES        = 14,
    PLAYER_LOGIN_QUERY_LOADGUILD                = 15,
    PLAYER_LOGIN_QUERY_LOADARENAINFO            = 16,
    PLAYER_LOGIN_QUERY_LOADBGCOORD              = 17,
    PLAYER_LOGIN_QUERY_LOADMAILS                = 18,
    PLAYER_LOGIN_QUERY_LOADMAILEDITEMS          = 19,
    PLAYER_LOGIN_QUERY_LOAD_MONTHLY_QUEST_STATUS= 20,
    PLAYER_LOGIN_QUERY_LOADINSTANCELOCKTIMES    = 21,

    MAX_PLAYER_LOGIN_QUERY
};

enum ReputationSource
{
    REPUTATION_SOURCE_KILL,
    REPUTATION_SOURCE_QUEST,
    REPUTATION_SOURCE_SPELL,
    REPUTATION_SOURCE_BG
};

// Player summoning auto-decline time (in secs)
#define MAX_PLAYER_SUMMON_DELAY                   (2*MINUTE)
#define MAX_MONEY_AMOUNT                       (0x7FFFFFFF-1)

struct InstancePlayerBind
{
    InstanceSave *save;
    bool perm;
    /* permanent PlayerInstanceBinds are created in Raid/Heroic instances for players
       that aren't already permanently bound when they are inside when a boss is killed
       or when they enter an instance that the group leader is permanently bound to. */
    InstancePlayerBind() : save(nullptr), perm(false) {}
};

struct AccessRequirement
{
    uint8  levelMin;
    uint8  levelMax;
    uint32 item;
    uint32 item2;
    uint32 heroicKey;
    uint32 heroicKey2;
    uint32 quest;
    std::string questFailedText;
    uint32 heroicQuest;
    std::string heroicQuestFailedText;
    uint32 auraId;
    std::string missingAuraText;
};

class LOOKING4GROUP_IMPORT_EXPORT PlayerTaxi
{
    public:
        PlayerTaxi();
        ~PlayerTaxi() {}
        // Nodes
        void InitTaxiNodesForLevel(uint32 race, uint32 level);
        void LoadTaxiMask(const char* data);

        bool IsTaximaskNodeKnown(uint32 nodeidx) const
        {
            uint8  field   = uint8((nodeidx - 1) / 32);
            uint32 submask = 1<<((nodeidx-1)%32);
            return (m_taximask[field] & submask) == submask;
        }

        bool SetTaximaskNode(uint32 nodeidx)
        {
            uint8  field   = uint8((nodeidx - 1) / 32);
            uint32 submask = 1<<((nodeidx-1)%32);
            if ((m_taximask[field] & submask) != submask)
            {
                m_taximask[field] |= submask;
                return true;
            }
            else
                return false;
        }

        std::string GetTaxiMaskString()
        {
            std::ostringstream ss;
            for(int i = 0; i < TaxiMaskSize; ++i)
                ss << m_taximask[i] << " ";

            return ss.str();
        }

        void AppendTaximaskTo(ByteBuffer& data,bool all);

        // Destinations
        bool LoadTaxiDestinationsFromString(const std::string& values);
        std::string SaveTaxiDestinationsToString();

        void ClearTaxiDestinations() { m_TaxiDestinations.clear(); }
        void AddTaxiDestination(uint32 dest) { m_TaxiDestinations.push_back(dest); }
        uint32 GetTaxiSource() const { return m_TaxiDestinations.empty() ? 0 : m_TaxiDestinations.front(); }
        uint32 GetTaxiDestination() const { return m_TaxiDestinations.size() < 2 ? 0 : m_TaxiDestinations[1]; }
        uint32 GetCurrentTaxiPath() const;
        uint32 NextTaxiDestination()
        {
            m_TaxiDestinations.pop_front();
            return GetTaxiDestination();
        }
        bool empty() const { return m_TaxiDestinations.empty(); }

        friend std::ostringstream& operator<< (std::ostringstream& ss, PlayerTaxi const& taxi);

    private:
        TaxiMask m_taximask;
        std::deque<uint32> m_TaxiDestinations;
};

class LOOKING4GROUP_EXPORT Player : public Unit
{
    friend class WorldSession;
    friend void Item::AddToUpdateQueueOf(Player *player);
    friend void Item::RemoveFromUpdateQueueOf(Player *player);
    friend uint32 Unit::SpellDamageBonus(Unit *, SpellEntry const *, uint32, DamageEffectType, CasterModifiers *);
    friend uint32 Unit::SpellHealingBonus(SpellEntry const *, uint32, DamageEffectType, Unit *, CasterModifiers *);
    public:
        explicit Player (WorldSession *session);
        ~Player ();

        void CleanupsBeforeDelete();

        static UpdateMask updateVisualBits;
        static void InitVisibleBits();

        void AddToWorld();
        void RemoveFromWorld();

        void StopCastingCharm() { Uncharm(); }
        void StopCastingBindSight();
        WorldObject* GetFarsightTarget() const;
        void ClearFarsight();
        void SetFarsightTarget(WorldObject* target);
        // Controls if vision is currently on farsight object, updated in FAR_SIGHT opcode
        void SetFarsightVision(bool apply) { m_farsightVision = apply; }
        bool HasFarsightVision() const { return m_farsightVision; }

        bool TeleportTo(uint32 mapid, float x, float y, float z, float orientation, uint32 options = 0);

        bool TeleportTo(WorldLocation const &loc, uint32 options = 0)
        {
            return TeleportTo(loc.mapid, loc.coord_x, loc.coord_y, loc.coord_z, loc.orientation, options);
        }

        void SetSummonPoint(uint32 mapid, float x, float y, float z)
        {
            m_summon_expire = time(NULL) + MAX_PLAYER_SUMMON_DELAY;
            m_summon_mapid = mapid;
            m_summon_x = x;
            m_summon_y = y;
            m_summon_z = z;
        }
        void SummonIfPossible(bool agree, uint64 summonerGUID);
        bool CanBeSummonedBy(uint64 summoner);
        bool CanBeSummonedBy(const Unit * summoner);

        bool Create(uint32 guidlow, const std::string& name, uint8 race, uint8 class_, uint8 gender, uint8 skin, uint8 face, uint8 hairStyle, uint8 hairColor, uint8 facialHair, uint8 outfitId);

        bool updating;
        bool inDelete;
        void Update(uint32 update_diff, uint32 diff);

        static bool BuildEnumData(QueryResultAutoPtr result,  WorldPacket * p_data);

        void SetInWater(bool apply);

        bool IsInWater() const { return m_isInWater; }
        bool IsUnderWater() const;

        void SendInitialPacketsBeforeAddToMap();
        void SendInitialPacketsAfterAddToMap();
        void SendTransferAborted(uint32 mapid, uint16 reason);
        void SendInstanceResetWarning(uint32 mapid, uint32 time);

        // Server First Announcement PvE
        void CheckAndAnnounceServerFirst(Creature* creature);

        GameObject* GetGameObjectIfCanInteractWith(uint64 guid, GameobjectTypes type = GAMEOBJECT_TYPE_GUILD_BANK) const;
        Creature* GetNPCIfCanInteractWith(uint64 guid, uint32 npcflagmask);
        bool CanInteractWithNPCs(bool alive = true) const;

        bool ToggleAFK();
        bool ToggleDND();

        bool isAFK() const { return HasFlag(PLAYER_FLAGS,PLAYER_FLAGS_AFK); };
        bool isDND() const { return HasFlag(PLAYER_FLAGS,PLAYER_FLAGS_DND); };

        uint8 chatTag() const;
        std::string afkMsg;
        std::string dndMsg;

        PlayerSocial *GetSocial() { return m_social; }

        PlayerTaxi m_taxi;
        void InitTaxiNodesForLevel() { m_taxi.InitTaxiNodesForLevel(getRace(),getLevel()); }
        bool ActivateTaxiPathTo(std::vector<uint32> const& nodes, uint32 mount_id = 0 , Creature* npc = NULL);
        void CleanupAfterTaxiFlight();

        bool isAcceptWhispers() const { return m_ExtraFlags & PLAYER_EXTRA_ACCEPT_WHISPERS; }
        void SetAcceptWhispers(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_ACCEPT_WHISPERS; else m_ExtraFlags &= ~PLAYER_EXTRA_ACCEPT_WHISPERS; }
        bool isGameMaster() const { return m_ExtraFlags & PLAYER_EXTRA_GM_ON; }
        void SetGameMaster(bool on);
        bool isGMChat() const { return GetSession()->HasPermissions(VIP) && (m_ExtraFlags & PLAYER_EXTRA_GM_CHAT); }
        void SetGMChat(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_GM_CHAT; else m_ExtraFlags &= ~PLAYER_EXTRA_GM_CHAT; }
        bool isTaxiCheater() const { return m_ExtraFlags & PLAYER_EXTRA_TAXICHEAT; }
        void SetTaxiCheater(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_TAXICHEAT; else m_ExtraFlags &= ~PLAYER_EXTRA_TAXICHEAT; }
        bool isGMVisible() const { return !(m_ExtraFlags & PLAYER_EXTRA_GM_INVISIBLE); }
        void SetGMVisible(bool on);
        void SetPvPDeath(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_PVP_DEATH; else m_ExtraFlags &= ~PLAYER_EXTRA_PVP_DEATH; }

        void GiveXP(uint32 xp, Unit* victim);
        void GiveLevel(uint32 level);
        void InitStatsForLevel(bool reapplyMods = false);

        // Played Time Stuff
        time_t m_logintime;
        time_t m_Last_tick;
        uint32 m_Played_time[2];
        uint32 GetTotalPlayedTime() { return m_Played_time[0]; };
        uint32 GetLevelPlayedTime() { return m_Played_time[1]; };

        void setDeathState(DeathState s);                   // overwrite Unit::setDeathState

        void InnEnter (int time,uint32 mapid, float x,float y,float z)
        {
            inn_pos_mapid = mapid;
            inn_pos_x = x;
            inn_pos_y = y;
            inn_pos_z = z;
            time_inn_enter = time;
        };

        float GetRestBonus() const { return m_rest_bonus; };
        void SetRestBonus(float rest_bonus_new);

        RestType GetRestType() const { return rest_type; };
        void SetRestType(RestType n_r_type) { rest_type = n_r_type; };

        uint32 GetInnPosMapId() const { return inn_pos_mapid; };
        float GetInnPosX() const { return inn_pos_x; };
        float GetInnPosY() const { return inn_pos_y; };
        float GetInnPosZ() const { return inn_pos_z; };

        int GetTimeInnEnter() const { return time_inn_enter; };
        void UpdateInnerTime (int time) { time_inn_enter = time; };

        Pet* SummonPet(uint32 entry, float x, float y, float z, float ang, PetType petType, uint32 despwtime);
        void RemovePet(Pet* pet, PetSaveMode mode, bool returnreagent = false, bool isDying = false);
        void RemoveMiniPet();
        Pet* GetMiniPet();
        void SetMiniPet(Pet* pet) { m_miniPet = pet->GetGUID(); }
        void RemoveGuardians();
        bool HasGuardianWithEntry(uint32 entry);
        void AddGuardian(Pet* pet) { m_guardianPets.insert(pet->GetGUID()); }
        GuardianPetList const& GetGuardians() const { return m_guardianPets; }
        void Uncharm();

        void Say(const std::string& text, const uint32 language);
        void Yell(const std::string& text, const uint32 language);
        void TextEmote(const std::string& text);
        void Whisper(const std::string& text, const uint32 language,uint64 receiver);
        void BuildPlayerChat(WorldPacket *data, uint8 msgtype, const std::string& text, uint32 language) const;

        /*********************************************************/
        /***                    STORAGE SYSTEM                 ***/
        /*********************************************************/

        void SetVirtualItemSlot(uint8 i, Item* item);
        void SetSheath(uint32 sheathed);
        uint8 FindEquipSlot(ItemPrototype const* proto, uint32 slot, bool swap) const;
        uint32 GetItemCount(uint32 item, bool inBankAlso = false, Item* skipItem = NULL) const;
        Item* GetItemByGuid(uint64 guid) const;
        Item* GetItemByPos(uint16 pos) const;
        Item* GetItemByPos(uint8 bag, uint8 slot) const;
        uint32 GetItemDisplayIdInSlot(uint8 bag, uint8 slot) const;
        Item* GetWeaponForAttack(WeaponAttackType attackType, bool useable = false) const;
        Item* GetShield(bool useable = false) const;
        static uint32 GetAttackBySlot(uint8 slot);        // MAX_ATTACK if not weapon slot
        std::vector<Item *> &GetItemUpdateQueue() { return m_itemUpdateQueue; }
        static bool IsInventoryPos(uint16 pos) { return IsInventoryPos(pos >> 8,pos & 255); }
        static bool IsInventoryPos(uint8 bag, uint8 slot);
        static bool IsEquipmentPos(uint16 pos) { return IsEquipmentPos(pos >> 8,pos & 255); }
        static bool IsEquipmentPos(uint8 bag, uint8 slot);
        static bool IsBagPos(uint16 pos);
        static bool IsBankPos(uint16 pos) { return IsBankPos(pos >> 8,pos & 255); }
        static bool IsBankPos(uint8 bag, uint8 slot);
        bool IsValidPos(uint16 pos) { return IsBankPos(pos >> 8,pos & 255); }
        bool IsValidPos(uint8 bag, uint8 slot) const;
        bool HasBankBagSlot(uint8 slot) const;
        Item * HasEquiped(uint32 item) const;
        bool HasItemCount(uint32 item, uint32 count, bool inBankAlso = false) const;
        bool HasItemFitToSpellReqirements(SpellEntry const* spellInfo, Item const* ignoreItem = NULL);
        bool CanNoReagentCast(SpellEntry const* spellInfo) const;
        Item* GetItemOrItemWithGemEquipped(uint32 item) const;
        uint8 CanTakeMoreSimilarItems(Item* pItem) const { return _CanTakeMoreSimilarItems(pItem->GetEntry(),pItem->GetCount(),pItem); }
        uint8 CanTakeMoreSimilarItems(uint32 entry, uint32 count) const { return _CanTakeMoreSimilarItems(entry,count,NULL); }
        uint8 CanStoreNewItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, uint32 item, uint32 count, uint32* no_space_count = NULL) const
        {
            return _CanStoreItem(bag, slot, dest, item, count, NULL, false, no_space_count);
        }
        uint8 CanStoreItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, Item *pItem, bool swap = false) const
        {
            if (!pItem)
                return EQUIP_ERR_ITEM_NOT_FOUND;
            uint32 count = pItem->GetCount();
            return _CanStoreItem(bag, slot, dest, pItem->GetEntry(), count, pItem, swap, NULL);

        }
        uint8 CanStoreItems(Item **pItem,int count) const;
        uint8 CanEquipNewItem(uint8 slot, uint16 &dest, uint32 item, bool swap) const;
        uint8 CanEquipItem(uint8 slot, uint16 &dest, Item *pItem, bool swap, bool not_loading = true) const;
        uint8 CanUnequipItems(uint32 item, uint32 count) const;
        uint8 CanUnequipItem(uint16 src, bool swap) const;
        uint8 CanBankItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, Item *pItem, bool swap, bool not_loading = true) const;
        uint8 CanUseItem(Item *pItem, bool not_loading = true) const;
        bool HasItemTotemCategory(uint32 TotemCategory) const;
        bool CanUseItem(ItemPrototype const *pItem);
        uint8 CanUseAmmo(uint32 item) const;
        Item* StoreNewItem(ItemPosCountVec const& pos, uint32 item, bool update,int32 randomPropertyId = 0);
        Item* StoreItem(ItemPosCountVec const& pos, Item *pItem, bool update);
        Item* EquipNewItem(uint16 pos, uint32 item, bool update);
        Item* EquipItem(uint16 pos, Item *pItem, bool update);
        void AutoUnequipOffhandIfNeed();
        bool StoreNewItemInBestSlots(uint32 item_id, uint32 item_count);
        void AutoStoreLoot(uint8 bag, uint8 slot, uint32 loot_id, LootStore const& store, bool broadcast = false);
        void AutoStoreLoot(uint32 loot_id, LootStore const& store, bool broadcast = false) { AutoStoreLoot(NULL_BAG,NULL_SLOT,loot_id,store,broadcast); }

        uint8 _CanTakeMoreSimilarItems(uint32 entry, uint32 count, Item* pItem, uint32* no_space_count = NULL) const;
        uint8 _CanStoreItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, uint32 entry, uint32 count, Item *pItem = NULL, bool swap = false, uint32* no_space_count = NULL) const;

        void ApplyEquipCooldown(Item * pItem);
        void SetAmmo(uint32 item);
        void RemoveAmmo();
        float GetAmmoDPS() const { return m_ammoDPS; }
        bool CheckAmmoCompatibility(const ItemPrototype *ammo_proto) const;
        void QuickEquipItem(uint16 pos, Item *pItem);
        void VisualizeItem(uint8 slot, Item *pItem);
        void SetVisibleItemSlot(uint8 slot, Item *pItem);
        Item* BankItem(ItemPosCountVec const& dest, Item *pItem, bool update)
        {
            return StoreItem(dest, pItem, update);
        }
        Item* BankItem(uint16 pos, Item *pItem, bool update);
        void RemoveItem(uint8 bag, uint8 slot, bool update);
        void MoveItemFromInventory(uint8 bag, uint8 slot, bool update);
                                                            // in trade, auction, guild bank, mail....
        void MoveItemToInventory(ItemPosCountVec const& dest, Item* pItem, bool update, bool in_characterInventoryDB = false);
                                                            // in trade, guild bank, mail....
        void RemoveItemDependentAurasAndCasts(Item * pItem);
        void DestroyItem(uint8 bag, uint8 slot, bool update);
        void DestroyItemCount(uint32 item, uint32 count, bool update, bool unequip_check = false, bool inBankAlso = false);
        void DestroyItemCount(Item* item, uint32& count, bool update);
        void DestroyConjuredItems(bool update);
        void DestroyZoneLimitedItem(bool update, uint32 new_zone);
        void SplitItem(uint16 src, uint16 dst, uint32 count);
        void SwapItem(uint16 src, uint16 dst);
        void AddItemToBuyBackSlot(Item *pItem);
        Item* GetItemFromBuyBackSlot(uint32 slot);
        void RemoveItemFromBuyBackSlot(uint32 slot, bool del);
        uint32 GetMaxKeyringSize() const { return KEYRING_SLOT_END-KEYRING_SLOT_START; }
        void SendEquipError(uint8 msg, Item* pItem, Item *pItem2);
        void SendBuyError(uint8 msg, Creature* pCreature, uint32 item, uint32 param);
        void SendSellError(uint8 msg, Creature* pCreature, uint64 guid, uint32 param);
        void AddWeaponProficiency(uint32 newflag) { m_WeaponProficiency |= newflag; }
        void AddArmorProficiency(uint32 newflag) { m_ArmorProficiency |= newflag; }
        uint32 GetWeaponProficiency() const { return m_WeaponProficiency; }
        uint32 GetArmorProficiency() const { return m_ArmorProficiency; }
        bool IsUseEquipedWeapon(bool mainhand) const
        {
            // disarm applied only to mainhand weapon
            return !IsInFeralForm() && (!mainhand || !HasFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_DISARMED));
        }
        void SendNewItem(Item *item, uint32 count, bool received, bool created, bool broadcast = false);
        bool BuyItemFromVendor(uint64 vendorguid, uint32 item, uint8 count, uint64 bagguid, uint8 slot);

        float GetReputationPriceDiscount(Creature const* pCreature) const;
        Player* GetTrader() const { return pTrader; }
        void ClearTrade();
        void TradeCancel(bool sendback);
        uint16 GetItemPosByTradeSlot(uint32 slot) const { return tradeItems[slot]; }

        void UpdateEnchantTime(uint32 time);
        void UpdateItemDuration(uint32 time, bool realtimeonly=false);
        void AddEnchantmentDurations(Item *item);
        void RemoveEnchantmentDurations(Item *item);
        void RemoveAllEnchantments(EnchantmentSlot slot, bool arena);
        void AddEnchantmentDuration(Item *item,EnchantmentSlot slot,uint32 duration);
        void ApplyEnchantment(Item *item,EnchantmentSlot slot,bool apply, bool apply_dur = true, bool ignore_condition = false);
        void ApplyEnchantment(Item *item,bool apply);
        void SendEnchantmentDurations();
        void EnchantItem(uint32 spellid, uint8 slot); //Neue enchant funktion f�r den NPC :>
        void AddItemDurations(Item *item);
        void RemoveItemDurations(Item *item);
        void SendItemDurations();
        void LoadCorpse();
        void LoadPet();

        uint32 m_stableSlots;

        /*********************************************************/
        /***                    QUEST SYSTEM                   ***/
        /*********************************************************/

        uint32 GetQuestOrPlayerLevel(Quest const* pQuest) const { return pQuest && (pQuest->GetQuestLevel()>0) ? pQuest->GetQuestLevel() : getLevel(); }

        void PrepareQuestMenu(uint64 guid);
        void SendPreparedQuest(uint64 guid);
        bool IsActiveQuest(uint32 quest_id) const;
        Quest const *GetNextQuest(uint64 guid, Quest const *pQuest);
        bool CanSeeStartQuest(Quest const *pQuest);
        bool CanTakeQuest(Quest const *pQuest, bool msg);
        bool CanAddQuest(Quest const *pQuest, bool msg);
        bool CanCompleteQuest(uint32 quest_id);
        bool CanCompleteRepeatableQuest(Quest const *pQuest);
        bool CanRewardQuest(Quest const *pQuest, bool msg);
        bool CanRewardQuest(Quest const *pQuest, uint32 reward, bool msg);
        void AddQuest(Quest const *pQuest, Object *questGiver);
        void CompleteQuest(uint32 quest_id);
        void IncompleteQuest(uint32 quest_id);
        void RewardQuest(Quest const *pQuest, uint32 reward, Object* questGiver, bool announce = true);
        void RewardDNDQuest(uint32 questId);
        void FailQuest(uint32 quest_id);
        void FailTimedQuest(uint32 quest_id);
        bool SatisfyQuestSkillOrClass(Quest const* qInfo, bool msg);
        bool SatisfyQuestLevel(Quest const* qInfo, bool msg);
        bool SatisfyQuestLog(bool msg);
        bool SatisfyQuestPreviousQuest(Quest const* qInfo, bool msg);
        bool SatisfyQuestRace(Quest const* qInfo, bool msg);
        bool SatisfyQuestReputation(Quest const* qInfo, bool msg);
        bool SatisfyQuestStatus(Quest const* qInfo, bool msg);
        bool SatisfyQuestTimed(Quest const* qInfo, bool msg);
        bool SatisfyQuestExclusiveGroup(Quest const* qInfo, bool msg);
        bool SatisfyQuestNextChain(Quest const* qInfo, bool msg);
        bool SatisfyQuestPrevChain(Quest const* qInfo, bool msg);
        bool SatisfyQuestDay(Quest const* qInfo, bool msg);
        bool SatisfyQuestMonth(Quest const* qInfo, bool msg);
        bool GiveQuestSourceItem(Quest const *pQuest);
        bool TakeQuestSourceItem(uint32 quest_id, bool msg);
        bool GetQuestRewardStatus(uint32 quest_id) const;
        QuestStatus GetQuestStatus(uint32 quest_id) const;
        void SetQuestStatus(uint32 quest_id, QuestStatus status);

        void SetDailyQuestStatus(uint32 quest_id);
        void SetMonthlyQuestStatus(uint32 quest_id);
        void ResetDailyQuestStatus();
        void ResetMonthlyQuestStatus();

        uint16 FindQuestSlot(uint32 quest_id) const;
        uint32 GetQuestSlotQuestId(uint16 slot) const { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_ID_OFFSET); }
        uint32 GetQuestSlotState(uint16 slot)   const { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_STATE_OFFSET); }
        uint32 GetQuestSlotCounters(uint16 slot)const { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET); }
        uint8 GetQuestSlotCounter(uint16 slot,uint8 counter) const { return GetByteValue(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET,counter); }
        uint32 GetQuestSlotTime(uint16 slot)    const { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_TIME_OFFSET); }
        void SetQuestSlot(uint16 slot,uint32 quest_id, uint32 timer = 0)
        {
            SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_ID_OFFSET,quest_id);
            SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_STATE_OFFSET,0);
            SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET,0);
            SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_TIME_OFFSET,timer);
        }
        void SetQuestSlotCounter(uint16 slot,uint8 counter,uint8 count) { SetByteValue(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET,counter,count); }
        void SetQuestSlotState(uint16 slot,uint32 state) { SetFlag(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_STATE_OFFSET,state); }
        void RemoveQuestSlotState(uint16 slot,uint32 state) { RemoveFlag(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_STATE_OFFSET,state); }
        void SetQuestSlotTimer(uint16 slot,uint32 timer) { SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot*MAX_QUEST_OFFSET + QUEST_TIME_OFFSET,timer); }
        void SwapQuestSlot(uint16 slot1,uint16 slot2)
        {
            for (int i = 0; i < MAX_QUEST_OFFSET ; ++i)
            {
                uint32 temp1 = GetUInt32Value(PLAYER_QUEST_LOG_1_1 + MAX_QUEST_OFFSET *slot1 + i);
                uint32 temp2 = GetUInt32Value(PLAYER_QUEST_LOG_1_1 + MAX_QUEST_OFFSET *slot2 + i);

                SetUInt32Value(PLAYER_QUEST_LOG_1_1 + MAX_QUEST_OFFSET *slot1 + i, temp2);
                SetUInt32Value(PLAYER_QUEST_LOG_1_1 + MAX_QUEST_OFFSET *slot2 + i, temp1);
            }
        }
        uint32 GetReqKillOrCastCurrentCount(uint32 quest_id, int32 entry);
        void AreaExploredOrEventHappens(uint32 questId);
        void GroupEventHappens(uint32 questId, WorldObject const* pEventObject);
        void ItemAddedQuestCheck(uint32 entry, uint32 count);
        void ItemRemovedQuestCheck(uint32 entry, uint32 count);
        void KilledMonster(uint32 entry, uint64 guid);
        void CastedCreatureOrGO(uint32 entry, uint64 guid, uint32 spell_id);
        void TalkedToCreature(uint32 entry, uint64 guid);
        void MoneyChanged(uint32 value);
        void ReputationChanged(FactionEntry const* factionEntry);
        bool HasQuestForItem(uint32 itemid) const;
        bool HasQuestForGO(int32 GOId) const;
        void UpdateForQuestsGO();
        bool CanShareQuest(uint32 quest_id) const;

        void SendQuestComplete(uint32 quest_id);
        void SendQuestReward(Quest const *pQuest, uint32 XP, Object* questGiver);
        void SendQuestFailed(uint32 quest_id);
        void SendQuestTimerFailed(uint32 quest_id);
        void SendCanTakeQuestResponse(uint32 msg);
        void SendQuestConfirmAccept(Quest const* pQuest, Player* pReceiver);
        void SendPushToPartyResponse(Player *pPlayer, uint32 msg);
        void SendQuestUpdateAddItem(Quest const* pQuest, uint32 item_idx, uint32 count);
        void SendQuestUpdateAddCreatureOrGo(Quest const* pQuest, uint64 guid, uint32 creatureOrGO_idx, uint32 old_count, uint32 add_count);

        uint64 GetDivider() { return m_divider; };
        void SetDivider(uint64 guid) { m_divider = guid; };

        uint32 GetInGameTime() { return m_ingametime; };

        void SetInGameTime(uint32 time) { m_ingametime = time; };

        void AddTimedQuest(uint32 quest_id) { m_timedquests.insert(quest_id); }

        /*********************************************************/
        /***                   LOAD SYSTEM                     ***/
        /*********************************************************/

        bool LoadFromDB(uint32 guid, SqlQueryHolder *holder);
        bool MinimalLoadFromDB(QueryResultAutoPtr result, uint32 guid);
        static bool   LoadValuesArrayFromDB(Tokens& data,uint64 guid);
        static uint32 GetUInt32ValueFromArray(Tokens const& data, uint16 index);
        static float  GetFloatValueFromArray(Tokens const& data, uint16 index);
        static uint32 GetUInt32ValueFromDB(uint16 index, uint64 guid);
        static float  GetFloatValueFromDB(uint16 index, uint64 guid);
        static uint32 GetZoneIdFromDB(uint64 guid);
        static uint32 GetLevelFromDB(uint64 guid);
        static bool   LoadPositionFromDB(uint32& mapid, float& x,float& y,float& z,float& o, bool& in_flight, uint64 guid);

        /*********************************************************/
        /***                   SAVE SYSTEM                     ***/
        /*********************************************************/

        void SaveToDB();
        void SaveInventoryAndGoldToDB();                    // fast save function for item/money cheating preventing
        void SaveGoldToDB();
        void SaveDataFieldToDB();
        static bool SaveValuesArrayInDB(Tokens const& data,uint64 guid);
        static void SetUInt32ValueInArray(Tokens& data,uint16 index, uint32 value);
        static void SetFloatValueInArray(Tokens& data,uint16 index, float value);
        static void SetUInt32ValueInDB(uint16 index, uint32 value, uint64 guid);
        static void SetFloatValueInDB(uint16 index, float value, uint64 guid);
        static void SavePositionInDB(uint32 mapid, float x,float y,float z,float o,uint32 zone,uint64 guid);

        bool m_mailsUpdated;

        void SetBindPoint(uint64 guid);
        void SendTalentWipeConfirm(uint64 guid);
        void RewardRage(uint32 damage, uint32 weaponSpeedHitFactor, bool attacker);
        void SendPetSkillWipeConfirm();
        void CalcRage(uint32 damage,bool attacker);
        void RegenerateAll();
        void Regenerate(Powers power);
        void RegenerateHealth();
        void setRegenTimer(uint32 time) {m_regenTimer = time;}
        void setWeaponChangeTimer(uint32 time) {m_weaponChangeTimer = time;}

        uint32 GetMoney() { return GetUInt32Value (PLAYER_FIELD_COINAGE); }
        void ModifyMoney(int32 d)
        {
            if (d < 0)
                SetMoney (GetMoney() > uint32(-d) ? GetMoney() + d : 0);
            else
                SetMoney (GetMoney() < uint32(MAX_MONEY_AMOUNT - d) ? GetMoney() + d : MAX_MONEY_AMOUNT);

            // "At Gold Limit"
            if (GetMoney() >= MAX_MONEY_AMOUNT)
                SendEquipError(EQUIP_ERR_TOO_MUCH_GOLD,NULL,NULL);
        }
        void SetMoney(uint32 value)
        {
            SetUInt32Value (PLAYER_FIELD_COINAGE, value);
            MoneyChanged(value);
        }

        uint32 GetTutorialInt(uint32 intId)
        {
            ASSERT((intId < 8));
            return m_Tutorials[intId];
        }

        void SetTutorialInt(uint32 intId, uint32 value)
        {
            ASSERT((intId < 8));
            if (m_Tutorials[intId]!=value)
            {
                m_Tutorials[intId] = value;
                m_TutorialsChanged = true;
            }
        }

        QuestStatusMap& getQuestStatusMap() { return mQuestStatus; };

        const uint64& GetSelection() const { return m_curSelection; }
        void SetSelection(const uint64 &guid) { m_curSelection = guid; SetUInt64Value(UNIT_FIELD_TARGET, guid); }

        uint8 GetComboPoints() { return m_comboPoints; }
        uint64 GetComboTarget() { return m_comboTarget; }

        void AddComboPoints(Unit* target, int8 count);
        void ClearComboPoints();
        void SendComboPoints();

        void SendMailResult(uint32 mailId, uint32 mailAction, uint32 mailError, uint32 equipError = 0, uint32 item_guid = 0, uint32 item_count = 0);
        void SendNewMail();
        void UpdateNextMailTimeAndUnreads();
        void AddNewMailDeliverTime(time_t deliver_time);

        //void SetMail(Mail *m);
        void RemoveMail(uint32 id);

        void AddMail(Mail* mail) { m_mail.push_front(mail);}// for call from WorldSession::SendMailTo
        uint32 GetMailSize() { return m_mail.size();};
        Mail* GetMail(uint32 id);

        PlayerMails::iterator GetmailBegin() { return m_mail.begin();};
        PlayerMails::iterator GetmailEnd() { return m_mail.end();};

        /*********************************************************/
        /***               MAILED ITEMS SYSTEM                 ***/
        /*********************************************************/

        uint8 unReadMails;
        time_t m_nextMailDelivereTime;

        typedef UNORDERED_MAP<uint32, Item*> ItemMap;

        ItemMap mMitems;                                    //template defined in objectmgr.cpp

        Item* GetMItem(uint32 id)
        {
            ItemMap::const_iterator itr = mMitems.find(id);
            if (itr != mMitems.end())
                return itr->second;

            return NULL;
        }

        void AddMItem(Item* it)
        {
            ASSERT(it);
            //assert deleted, because items can be added before loading
            mMitems[it->GetGUIDLow()] = it;
        }

        bool RemoveMItem(uint32 id)
        {
            ItemMap::iterator i = mMitems.find(id);
            if (i == mMitems.end())
                return false;

            mMitems.erase(i);
            return true;
        }

        void CreateCharmAI();
        void DeleteCharmAI();
        void CharmAI(bool enable = true);

        void PetSpellInitialize();
        void CharmSpellInitialize();
        void PossessSpellInitialize();
        bool HasSpell(uint32 spell) const;
        TrainerSpellState GetTrainerSpellState(TrainerSpell const* trainer_spell) const;
        bool IsSpellFitByClassAndRace(uint32 spell_id) const;
        void ChangeRace(uint8 new_raceID);

        Unit* GetNearBossInCombat();

        void SendProficiency(uint8 pr1, uint32 pr2);
        void SendInitialSpells();
        bool addSpell(uint32 spell_id, bool active, bool learning = true, bool loading = false, uint16 slot_id=SPELL_WITHOUT_SLOT_ID, bool disabled = false);
        void learnSpell(uint32 spell_id);
        void removeSpell(uint32 spell_id, bool disabled = false);
        void resetSpells();
        void learnDefaultSpells(bool loading = false);
        void learnQuestRewardedSpells();
        void learnQuestRewardedSpells(Quest const* quest);

        uint32 GetFreeTalentPoints() const { return GetUInt32Value(PLAYER_CHARACTER_POINTS1); }
        void SetFreeTalentPoints(uint32 points) { SetUInt32Value(PLAYER_CHARACTER_POINTS1,points); }
        bool resetTalents(bool no_cost = false);
        uint32 resetTalentsCost() const;
        void UpdateFreeTalentPoints(bool resetIfNeed = true);
        void InitTalentForLevel();

        uint32 CalculateTalentsPoints() const;

        uint32 GetFreePrimaryProfessionPoints() const { return GetUInt32Value(PLAYER_CHARACTER_POINTS2); }
        void SetFreePrimaryProfessions(uint16 profs) { SetUInt32Value(PLAYER_CHARACTER_POINTS2,profs); }
        void InitPrimaryProffesions();

        PlayerSpellMap const& GetSpellMap() const { return m_spells; }
        PlayerSpellMap      & GetSpellMap()       { return m_spells; }

        void AddSpellMod(SpellModifier* mod, bool apply);
        int32 GetTotalFlatMods(uint32 spellId, SpellModOp op);
        int32 GetTotalPctMods(uint32 spellId, SpellModOp op);
        bool IsAffectedBySpellmod(SpellEntry const *spellInfo, SpellModifier *mod, Spell const* spell = NULL);
        template <class T> T ApplySpellMod(uint32 spellId, SpellModOp op, T &basevalue, Spell const* spell = NULL);
        void RemoveSpellMods(Spell const* spell);
        void RestoreSpellMods(Spell const* spell);
        void ResetSpellModsDueToCanceledSpell(Spell const* spell);

        CooldownMgr& GetCooldownMgr() { return m_CooldownMgr; }

        bool HasSpellCooldown(uint32 spell_id) const
        {
            SpellCooldowns::const_iterator itr = m_spellCooldowns.find(spell_id);
            if (HasEquiped(29179) && HasEquiped(29132) && spell_id == 35337 && (itr != m_spellCooldowns.end() && itr->second.end > time(NULL)))
            {
                return false;
            }
            return itr != m_spellCooldowns.end() && itr->second.end > time(NULL);
        }
        uint32 GetSpellCooldownDelay(uint32 spell_id) const
        {
            SpellCooldowns::const_iterator itr = m_spellCooldowns.find(spell_id);
            time_t t = time(NULL);
            return itr != m_spellCooldowns.end() && itr->second.end > t ? itr->second.end - t : 0;
        }
        void AddSpellCooldown(uint32 spell_id, uint32 itemid, time_t end_time);
        void SendCooldownEvent(SpellEntry const *spellInfo);
        void LockSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs) override;
        void RemoveSpellCooldown(uint32 spell_id, bool update = false);
        void RemoveArenaSpellCooldowns();
        void RemoveAllSpellCooldown();
        void _LoadSpellCooldowns(QueryResultAutoPtr result);
        void _SaveSpellCooldowns();

        void setResurrectRequestData(uint64 guid, uint32 mapId, float X, float Y, float Z, uint32 health, uint32 mana)
        {
            m_resurrectGUID = guid;
            m_resurrectMap = mapId;
            m_resurrectX = X;
            m_resurrectY = Y;
            m_resurrectZ = Z;
            m_resurrectHealth = health;
            m_resurrectMana = mana;
        };
        void clearResurrectRequestData() { setResurrectRequestData(0,0,0.0f,0.0f,0.0f,0,0); }
        bool isRessurectRequestedBy(uint64 guid) const { return m_resurrectGUID == guid; }
        bool isRessurectRequested() const { return m_resurrectGUID != 0; }
        void ResurectUsingRequestData();

        bool getCinematic()
        {
            return m_cinematic;
        }
        void setCinematic(bool cine)
        {
            m_cinematic = cine;
        }
        uint32 getWatchingCinematic()
        {
            return m_watchingCinematicId;
        }
        void setWatchingCinematic(uint32 cinematicId)
        {
            m_watchingCinematicId = cinematicId;
        }

        void addActionButton(uint8 button, uint16 action, uint8 type, uint8 misc);
        void removeActionButton(uint8 button);
        void SendInitialActionButtons();

        PvPInfo pvpInfo;
        void UpdatePvP(bool state, bool ovrride=false);
        bool IsFFAPvP() const { return HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_FFA_PVP); }
        void SetFFAPvP(bool state);

        void UpdateZone(uint32 newZone);
        void UpdateArea(uint32 newArea);

        void UpdatePvpTitles();
        void UpdateBgTitle();

        void UpdateZoneDependentAuras(uint32 zone_id);    // zones
        void UpdateAreaDependentAuras(uint32 area_id);    // subzones

        void UpdateAfkReport(time_t currTime);
        void UpdatePvPFlag(time_t currTime);
        void UpdateContestedPvP(uint32 currTime);
        void SetContestedPvPTimer(uint32 newTime) {m_contestedPvPTimer = newTime;}
        void ResetContestedPvP()
        {
            clearUnitState(UNIT_STAT_ATTACK_PLAYER);
            RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_CONTESTED_PVP);
            m_contestedPvPTimer = 0;
        }

        /** todo: -maybe move UpdateDuelFlag+DuelComplete to independent DuelHandler.. **/
        DuelInfo *duel;
        void UpdateDuelFlag(time_t currTime);
        void CheckDuelDistance(time_t currTime);
        void DuelComplete(DuelCompleteType type);

        bool IsGroupVisiblefor (Player* p) const;
        bool IsInSameGroupWith(Player const* p) const;
        bool IsInSameRaidWith(Player const* p) const { return p==this || (GetGroup() != NULL && GetGroup() == p->GetGroup()); }
        void UninviteFromGroup();
        static void RemoveFromGroup(Group* group, uint64 guid);
        void RemoveFromGroup() { RemoveFromGroup(GetGroup(),GetGUID()); }
        void SendUpdateToOutOfRangeGroupMembers();

        void SetInGuild(uint32 GuildId) { SetUInt32Value(PLAYER_GUILDID, GuildId); }
        void SetRank(uint32 rankId){ SetUInt32Value(PLAYER_GUILDRANK, rankId); }
        void SetGuildIdInvited(uint32 GuildId) { m_GuildIdInvited = GuildId; }
        uint32 GetGuildId() { return GetUInt32Value(PLAYER_GUILDID);  }
        static uint32 GetGuildIdFromDB(uint64 guid);
        uint32 GetRank(){ return GetUInt32Value(PLAYER_GUILDRANK); }
        static uint32 GetRankFromDB(uint64 guid);
        int GetGuildIdInvited() { return m_GuildIdInvited; }
        static void RemovePetitionsAndSigns(uint64 guid, uint32 type);

        // Arena Team
        void SetInArenaTeam(uint32 ArenaTeamId, uint8 slot)
        {
            SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (slot * 6), ArenaTeamId);
        }
        uint32 GetArenaTeamId(uint8 slot) { return GetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (slot * 6)); }
        static uint32 GetArenaTeamIdFromDB(uint64 guid, uint8 slot);
        void SetArenaTeamIdInvited(uint32 ArenaTeamId) { m_ArenaTeamIdInvited = ArenaTeamId; }
        uint32 GetArenaTeamIdInvited() { return m_ArenaTeamIdInvited; }

        void SetDifficulty(uint32 dungeon_difficulty) { m_dungeonDifficulty = dungeon_difficulty; }
        uint8 GetDifficulty() { return m_dungeonDifficulty; }

        bool UpdateSkill(uint32 skill_id, uint32 step);
        bool UpdateSkillPro(uint16 SkillId, int32 Chance, uint32 step);

        bool UpdateCraftSkill(uint32 spellid);
        bool UpdateGatherSkill(uint32 SkillId, uint32 SkillValue, uint32 RedLevel, uint32 Multiplicator = 1);
        bool UpdateFishingSkill();

        uint32 GetBaseDefenseSkillValue() const { return GetBaseSkillValue(SKILL_DEFENSE); }
        uint32 GetBaseWeaponSkillValue(WeaponAttackType attType) const;

        uint32 GetSpellByProto(ItemPrototype *proto);

        float GetHealthBonusFromStamina();
        float GetManaBonusFromIntellect();

        bool UpdateStats(Stats stat);
        bool UpdateAllStats();
        void UpdateResistances(uint32 school);
        void UpdateArmor();
        void UpdateMaxHealth();
        void UpdateMaxPower(Powers power);
        void UpdateAttackPowerAndDamage(bool ranged = false);
        void UpdateShieldBlockValue();
        void UpdateDamagePhysical(WeaponAttackType attType);
        void UpdateSpellDamageAndHealingBonus();

        void CalculateMinMaxDamage(WeaponAttackType attType, bool normalized, float& min_damage, float& max_damage);

        void UpdateDefenseBonusesMod();
        void ApplyRatingMod(CombatRating cr, int32 value, bool apply);
        float GetMeleeCritFromAgility();
        float GetDodgeFromAgility();
        float GetSpellCritFromIntellect();
        float OCTRegenHPPerSpirit();
        float OCTRegenMPPerSpirit();
        float GetRatingCoefficient(CombatRating cr) const;
        float GetRatingBonusValue(CombatRating cr) const;
        uint32 GetMeleeCritDamageReduction(uint32 damage) const;
        uint32 GetRangedCritDamageReduction(uint32 damage) const;
        uint32 GetSpellCritDamageReduction(uint32 damage) const;
        uint32 GetDotDamageReduction(uint32 damage) const;
        int32 GetSpellPenetrationItemMod() const { return m_spellPenetrationItemMod; }

        float GetExpertiseDodgeOrParryReduction(WeaponAttackType attType) const;
        void UpdateBlockPercentage();
        void UpdateCritPercentage(WeaponAttackType attType);
        void UpdateAllCritPercentages();
        void UpdateParryPercentage();
        void UpdateDodgePercentage();
        void UpdateAllSpellCritChances();
        void UpdateSpellCritChance(uint32 school);
        void UpdateExpertise(WeaponAttackType attType);
        void UpdateManaRegen();

        const uint64& GetLootGUID() const { return m_lootGuid; }
        void SetLootGUID(const uint64 &guid) { m_lootGuid = guid; }

        void RemovedInsignia(Player* looterPlr);

        WorldSession* GetSession() const { return m_session; }
        void SetSession(WorldSession *s) { m_session = s; }

        void BuildCreateUpdateBlockForPlayer(UpdateData *data, Player *target) const;
        void DestroyForPlayer(Player *target) const;
        void SendDelayResponse(const uint32);
        void SendLogXPGain(uint32 GivenXP, Unit* victim, uint32 BonusXP, bool ReferAFriend);

        //notifiers
        void SendAttackSwingCantAttack();
        void SendAttackSwingCancelAttack();
        void SendAttackSwingDeadTarget();
        void SendAttackSwingNotStanding();
        void SendAttackSwingNotInRange();
        void SendAttackSwingBadFacingAttack();
        void SendAutoRepeatCancel();
        void SendExplorationExperience(uint32 Area, uint32 Experience);

        void SendDungeonDifficulty(bool IsInGroup);
        void ResetInstances(uint8 method);
        void SendResetInstanceSuccess(uint32 MapId);
        void SendResetInstanceFailed(uint32 reason, uint32 MapId);
        void SendResetFailedNotify(uint32 mapid);

        bool SetPosition(float x, float y, float z, float orientation, bool teleport = false);
        void UpdateUnderwaterState(Map * m, float x, float y, float z);

        static void DeleteFromDB(uint64 playerguid, uint32 accountId, bool updateRealmChars = true);
        static void DeleteCharacterInfoFromDB(uint32 playerGUIDLow);

        Corpse *GetCorpse() const;
        void SpawnCorpseBones();
        void CreateCorpse();
        void KillPlayer();
        uint32 GetResurrectionSpellId();
        void ResurrectPlayer(float restore_percent, bool applySickness = false);
        void BuildPlayerRepop();
        void RepopAtGraveyard();
        void TeleportToNearestGraveyard();

        void DurabilityLossAll(double percent, bool inventory);
        void DurabilityLoss(Item* item, double percent);
        void DurabilityPointsLossAll(int32 points, bool inventory);
        void DurabilityPointsLoss(Item* item, int32 points);
        void DurabilityPointLossForEquipSlot(EquipmentSlots slot);
        uint32 DurabilityRepairAll(bool cost, float discountMod, bool guildBank);
        uint32 DurabilityRepair(uint16 pos, bool cost, float discountMod, bool guildBank);

        void UpdateMirrorTimers();
        void StopMirrorTimers()
        {
            StopMirrorTimer(FATIGUE_TIMER);
            StopMirrorTimer(BREATH_TIMER);
            StopMirrorTimer(FIRE_TIMER);
        }

        void SetMovement(PlayerMovementType pType);

        void JoinedChannel(Channel *c);
        void LeftChannel(Channel *c);
        void CleanupChannels();
        void UpdateLocalChannels(uint32 newZone);
        void LeaveLFGChannel();
        void JoinLFGChannel();

        // BattleGround Group System
        void SetBattleGroundRaid(Group *group, int8 subgroup = -1);
        void RemoveFromBattleGroundRaid();

        Group * GetOriginalGroup() { return m_originalGroup.getTarget(); }
        GroupReference& GetOriginalGroupRef() { return m_originalGroup; }
        uint8 GetOriginalSubGroup() const { return m_originalGroup.getSubGroup(); }
        void SetOriginalGroup(Group *group, int8 subgroup = -1);

        void UpdateDefense();
        void UpdateWeaponSkill (WeaponAttackType attType);
        void UpdateCombatSkills(Unit *pVictim, WeaponAttackType attType, bool defence);

        void SetSkill(uint32 id, uint16 currVal, uint16 maxVal);
        uint16 GetMaxSkillValue(uint32 skill) const;        // max + perm. bonus
        uint16 GetPureMaxSkillValue(uint32 skill) const;    // max
        uint16 GetSkillValue(uint32 skill) const;           // skill value + perm. bonus + temp bonus
        uint16 GetBaseSkillValue(uint32 skill) const;       // skill value + perm. bonus
        uint16 GetPureSkillValue(uint32 skill) const;       // skill value
        int16 GetSkillTempBonusValue(uint32 skill) const;
        bool HasSkill(uint32 skill) const;
        void learnSkillRewardedSpells(uint32 id);
        void learnSkillRewardedSpells();

        WorldLocation& GetTeleportDest() { return m_teleport_dest; }
        bool IsBeingTeleported() const { return mSemaphoreTeleport_Near || mSemaphoreTeleport_Far; }
        bool IsBeingTeleportedNear() const { return mSemaphoreTeleport_Near; }
        bool IsBeingTeleportedFar() const { return mSemaphoreTeleport_Far; }
        void SetSemaphoreTeleportNear(bool semphsetting) { mSemaphoreTeleport_Near = semphsetting; }
        void SetSemaphoreTeleportFar(bool semphsetting) { mSemaphoreTeleport_Far = semphsetting; }

        void CheckAreaExploreAndOutdoor(void);

        static uint32 TeamForRace(uint8 race);
        uint32 GetTeam() const { return m_team; }
        TeamId GetTeamId() const { return m_team == ALLIANCE ? TEAM_ALLIANCE : TEAM_HORDE; }
        static uint32 getFactionForRace(uint8 race);
        void setFactionForRace(uint8 race);

        bool IsAtGroupRewardDistance(WorldObject const* pRewardSource) const;
        bool RewardPlayerAndGroupAtKill(Unit* pVictim);
        void RewardPlayerAndGroupAtEvent(uint32 creature_id, WorldObject* pRewardSource);

        ReputationMgr&       GetReputationMgr()       { return m_reputationMgr; }
        ReputationMgr const& GetReputationMgr() const { return m_reputationMgr; }
        ReputationRank GetReputationRank(uint32 faction_id) const;
        void RewardReputation(Unit *pVictim, float rate);
        void RewardReputation(Quest const *pQuest);

        int32 CalculateReputationGain(ReputationSource source, int32 rep, int32 faction, uint32 creatureOrQuestLevel = 0, bool noAuraBonus = false);

        void UpdateSkillsForLevel();
        void UpdateSkillsToMaxSkillsForLevel(bool lockpickInclude = false);             // for .levelup
        void ModifySkillBonus(uint32 skillid,int32 val, bool talent);

        /*********************************************************/
        /***              REFER-A-FRIEND SYSTEM                ***/
        /*********************************************************/
        void SendReferFriendError(ReferAFriendError err, Player * target = NULL);
        ReferAFriendError GetReferFriendError(Player * target, bool summon);
        void AccessGrantableLevel(ObjectGuid guid)
        {
            m_curGrantLevelGiverGuid = guid;
        }
        bool IsAccessGrantableLevel(ObjectGuid guid)
        {
            return m_curGrantLevelGiverGuid == guid;
        }
        uint32 GetGrantableLevels()
        {
            return m_GrantableLevelsCount;
        }
        void ChangeGrantableLevels(uint8 increase = 0);
        bool CheckRAFConditions();
        AccountLinkedState GetAccountLinkedState();
        bool IsReferAFriendLinked(Player * target);
        void LoadAccountLinkedState();
        std::vector<uint32> m_referredAccounts;
        std::vector<uint32> m_referalAccounts;

        // Refer-A-Friend
        ObjectGuid m_curGrantLevelGiverGuid;

        int32 m_GrantableLevelsCount;

        /*********************************************************/
        /***                 ANTICHEAT SYSTEM                  ***/
        /*********************************************************/
        uint32 m_AC_timer;
        uint32 m_AC_NoFall_count;

        /*********************************************************/
        /***                  PVP SYSTEM                       ***/
        /*********************************************************/
        void UpdateArenaFields();
        void UpdateHonorFields();
        bool RewardHonor(Unit *pVictim, uint32 groupsize, float honor = -1, bool pvptoken = false, bool killer = true);
        uint32 GetHonorPoints() { return GetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY); }
        uint32 GetArenaPoints() { return GetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY); }
        void ModifyHonorPoints(int32 value);
        void ModifyArenaPoints(int32 value);
        uint32 GetMaxPersonalArenaRatingRequirement();

        //End of PvP System

        void SetDrunkValue(uint16 newDrunkValue, uint32 itemid=0);
        uint16 GetDrunkValue() const { return m_drunk; }
        static DrunkenState GetDrunkenstateByValue(uint16 value);

        uint32 GetDeathTimer() const { return m_deathTimer; }
        uint32 GetCorpseReclaimDelay(bool pvp) const;
        void UpdateCorpseReclaimDelay();
        void SendCorpseReclaimDelay(bool load = false);

        uint32 GetShieldBlockValue() const;                 // overwrite Unit version (virtual)
        bool CanParry() const { return m_canParry; }
        void SetCanParry(bool value);
        bool CanBlock() const { return m_canBlock; }
        void SetCanBlock(bool value);

        void SetRegularAttackTime();
        void SetBaseModValue(BaseModGroup modGroup, BaseModType modType, float value) { m_auraBaseMod[modGroup][modType] = value; }
        void HandleBaseModValue(BaseModGroup modGroup, BaseModType modType, float amount, bool apply);
        float GetBaseModValue(BaseModGroup modGroup, BaseModType modType) const;
        float GetTotalBaseModValue(BaseModGroup modGroup) const;
        float GetTotalPercentageModValue(BaseModGroup modGroup) const { return m_auraBaseMod[modGroup][FLAT_MOD] + m_auraBaseMod[modGroup][PCT_MOD]; }
        void _ApplyAllStatBonuses();
        void _RemoveAllStatBonuses();

        void _ApplyWeaponDependentAuraMods(Item *item, WeaponAttackType attackType, bool apply);
        void _ApplyWeaponDependentAuraCritMod(Item *item, WeaponAttackType attackType, Aura* aura, bool apply);
        void _ApplyWeaponDependentAuraDamageMod(Item *item, WeaponAttackType attackType, Aura* aura, bool apply);

        void _ApplyItemMods(Item *item,uint8 slot,bool apply);
        void _RemoveAllItemMods();
        void _ApplyAllItemMods();
        void _ApplyItemBonuses(ItemPrototype const *proto,uint8 slot,bool apply);
        void _ApplyAmmoBonuses();
        bool EnchantmentFitsRequirements(uint32 enchantmentcondition, int8 slot);
        void ToggleMetaGemsActive(uint8 exceptslot, bool apply);
        void CorrectMetaGemEnchants(uint8 slot, bool apply);
        void InitDataForForm(bool reapplyMods = false);

        void ApplyItemEquipSpell(Item *item, bool apply, bool form_change = false);
        void ApplyEquipSpell(SpellEntry const* spellInfo, Item* item, bool apply, bool form_change = false);
        void UpdateEquipSpellsAtFormChange();
        void CastItemCombatSpell(Unit *target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, SpellEntry const *spellInfo = NULL);
        void CastItemCombatSpell(Unit *target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item *item, ItemPrototype const * proto, SpellEntry const *spell = NULL);

        void SendInitWorldStates(bool force = false, uint32 forceZoneId = 0);
        void SendUpdateWorldState(uint32 Field, uint32 Value);

        void SendPacketToSelf(WorldPacket*);

        void SendAuraDurationsForTarget(Unit* target);

        PlayerMenu* PlayerTalkClass;
        std::vector<ItemSetEffect *> ItemSetEff;

        void SendLoot(uint64 guid, LootType loot_type);
        void SendLootRelease(uint64 guid);
        void SendNotifyLootItemRemoved(uint8 lootSlot);
        void SendNotifyLootMoneyRemoved();

        uint8 GetValidForPush();
        bool GetValidForPushSeventy();
        void PushSixty();
        void PushSeventy();
        void PushFaction(uint16 factionId, uint32 repValue);
        void FinishTransferQuests();
        void Push();
        void EquipForPush(uint16 items[]);
        void EquipForPushSeventy(uint16 items[]);
        void EquipForPushSixty(uint16 items[]);
        void FinishPush();
        void FinishPushTransfer();
        void FinishPushSixty();
        void PvpPush(uint16 items[]);
        void AddItem(uint32 itemID, uint32 Count);

        /* Addon Helper functions */
        void SendAddonMessage(std::string& text, char* prefix);
        WorldPacket CreateAddonMessage(std::string& text, char* prefix);
        WorldPacket BuildGladdyUpdate();
        void SendGladdyNotification();

        /*********************************************************/
        /***               BATTLEGROUND SYSTEM                 ***/
        /*********************************************************/

        bool InBattleGround()       const                   { return m_bgBattleGroundID != 0; }
        bool InArena()              const;
        bool InArenaOrBG()          const                   { return InBattleGround() || InArena(); }
        uint32 GetBattleGroundId()  const                   { return m_bgBattleGroundID; }
        BattleGroundTypeId GetBattleGroundTypeId() const    { return m_bgTypeID; }
        BattleGround* GetBattleGround() const;


        static uint32 GetMinLevelForBattleGroundBracketId(BattleGroundBracketId bracket_id, BattleGroundTypeId bgTypeId);
        static uint32 GetMaxLevelForBattleGroundBracketId(BattleGroundBracketId bracket_id, BattleGroundTypeId bgTypeId);
        BattleGroundBracketId GetBattleGroundBracketIdFromLevel(BattleGroundTypeId bgTypeId) const;

        bool InBattleGroundQueue() const
        {
            for (int i=0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
                if (m_bgBattleGroundQueueID[i].bgQueueTypeId != BATTLEGROUND_QUEUE_NONE)
                    return true;
            return false;
        }

        BattleGroundQueueTypeId GetBattleGroundQueueTypeId(uint32 index) const { return m_bgBattleGroundQueueID[index].bgQueueTypeId; }
        uint32 GetBattleGroundQueueIndex(BattleGroundQueueTypeId bgQueueTypeId) const
        {
            for (int i=0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
                if (m_bgBattleGroundQueueID[i].bgQueueTypeId == bgQueueTypeId)
                    return i;
            return PLAYER_MAX_BATTLEGROUND_QUEUES;
        }

        bool IsInvitedForBattleGroundQueueType(BattleGroundQueueTypeId bgQueueTypeId) const
        {
            for (int i=0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
                if (m_bgBattleGroundQueueID[i].bgQueueTypeId == bgQueueTypeId)
                    return m_bgBattleGroundQueueID[i].invitedToInstance != 0;
            return false;
        }

        bool InBattleGroundQueueForBattleGroundQueueType(BattleGroundQueueTypeId bgQueueTypeId) const
        {
            return GetBattleGroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES;
        }

        void SetBattleGroundId(uint32 val, BattleGroundTypeId bgTypeId)
        {
            m_bgBattleGroundID = val;
            m_bgTypeID = bgTypeId;
        }

        uint32 AddBattleGroundQueueId(BattleGroundQueueTypeId val)
        {
            for (int i=0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
            {
                if (m_bgBattleGroundQueueID[i].bgQueueTypeId == BATTLEGROUND_QUEUE_NONE || m_bgBattleGroundQueueID[i].bgQueueTypeId == val)
                {
                    m_bgBattleGroundQueueID[i].bgQueueTypeId = val;
                    m_bgBattleGroundQueueID[i].invitedToInstance = 0;
                    return i;
                }
            }
            return PLAYER_MAX_BATTLEGROUND_QUEUES;
        }

        bool HasFreeBattleGroundQueueId()
        {
            for (int i=0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
                if (m_bgBattleGroundQueueID[i].bgQueueTypeId == BATTLEGROUND_QUEUE_NONE)
                    return true;
            return false;
        }

        void RemoveBattleGroundQueueId(BattleGroundQueueTypeId val)
        {
            for (int i=0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
            {
                if (m_bgBattleGroundQueueID[i].bgQueueTypeId == val)
                {
                    m_bgBattleGroundQueueID[i].bgQueueTypeId = BATTLEGROUND_QUEUE_NONE;
                    m_bgBattleGroundQueueID[i].invitedToInstance = 0;
                    return;
                }
            }
        }

        void SetInviteForBattleGroundQueueType(BattleGroundQueueTypeId bgQueueTypeId, uint32 instanceId)
        {
            for (int i=0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
                if (m_bgBattleGroundQueueID[i].bgQueueTypeId == bgQueueTypeId)
                    m_bgBattleGroundQueueID[i].invitedToInstance = instanceId;
        }

        bool IsInvitedForBattleGroundInstance(uint32 instanceId) const
        {
            for (int i=0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
                if (m_bgBattleGroundQueueID[i].invitedToInstance == instanceId)
                    return true;
            return false;
        }

        uint32 GetBattleGroundEntryPointMap() const { return m_bgEntryPointMap; }
        float GetBattleGroundEntryPointX() const { return m_bgEntryPointX; }
        float GetBattleGroundEntryPointY() const { return m_bgEntryPointY; }
        float GetBattleGroundEntryPointZ() const { return m_bgEntryPointZ; }
        float GetBattleGroundEntryPointO() const { return m_bgEntryPointO; }
        void SetBattleGroundEntryPoint(uint32 Map, float PosX, float PosY, float PosZ, float PosO)
        {
            m_bgEntryPointMap = Map;
            m_bgEntryPointX = PosX;
            m_bgEntryPointY = PosY;
            m_bgEntryPointZ = PosZ;
            m_bgEntryPointO = PosO;
        }

        void SetBGTeam(uint32 team) { m_bgTeam = team; }
        uint32 GetBGTeam() const { return m_bgTeam ? m_bgTeam : GetTeam(); }

        Creature* GetBGCreature(uint32 type);

        void LeaveBattleground(bool teleportToEntryPoint = true);
        bool CanJoinToBattleground() const;
        bool CanReportAfkDueToLimit();
        void ReportedAfkBy(Player* reporter);
        void ClearAfkReports() { m_bgAfkReporter.clear(); }

        bool GetBGAccessByLevel(BattleGroundTypeId bgTypeId) const;
        bool isAllowUseBattleGroundObject();
        bool isAllowedToJoinPoint();
        bool isTotalImmunity();

        /*********************************************************/
        /***               OUTDOOR PVP SYSTEM                  ***/
        /*********************************************************/

        OutdoorPvP * GetOutdoorPvP() const;
        // returns true if the player is in active state for outdoor pvp objective capturing, false otherwise
        bool IsOutdoorPvPActive();

        /*********************************************************/
        /***                    REST SYSTEM                    ***/
        /*********************************************************/

        bool isRested() const { return GetRestTime() >= 10000; }
        uint32 GetXPRestBonus(uint32 xp);
        uint32 GetRestTime() const { return m_restTime;};
        void SetRestTime(uint32 v) { m_restTime = v;};

        /*********************************************************/
        /***              ENVIROMENTAL SYSTEM                  ***/
        /*********************************************************/

        void EnvironmentalDamage(EnviromentalDamage type, uint32 damage);
        void UpdateFallInformationIfNeed(MovementInfo const& minfo,uint16 opcode);

        /*********************************************************/
        /***               FLOOD FILTER SYSTEM                 ***/
        /*********************************************************/

        std::vector<std::string> MessageCache;        // The message cache for the messages will be cleared every x seconds
        uint32 m_repeatIT;                            // Repeating messages in specific time. When this exceeds CONFIG_CHATFLOOD_REPEAT_MESSAGES the player gets muted (from all channels)
        uint32 m_repeatTO;                            // The time until the player is allowed to use the same phrase again in the specific channel. (Timeout)
        uint32 m_speakTimer;                          // The time since we last spoke
        uint32 m_speakCount;                          // The total messages

        bool DoSpamCheck(std::string message);
        bool SpamCheckForType(uint32 Type, uint32 Lang);

        void UpdateSpeakTime(bool Emote = false);
        bool CanSpeak() const;
        void ChangeSpeakTime(int utime);

        /*********************************************************/
        /***                 VARIOUS SYSTEMS                   ***/
        /*********************************************************/

        uint32 m_lastFallTime;
        float  m_lastFallZ;
        void SetFallInformation(uint32 time, float z)
        {
            m_lastFallTime = time;
            m_lastFallZ = z;
        }

        void BuildTeleportAckMsg(WorldPacket & data, float x, float y, float z, float ang) const;

        bool isMentor();
        bool isMenteeWithoutMentor();
        int  isMenteeOfAccount();
        int  GetOnlineChar(uint32 acc_id);

        bool isInSanctuary();
        bool isMoving() const { return HasUnitMovementFlag(MOVEFLAG_MOVING); }
        bool isTurning() const { return HasUnitMovementFlag(MOVEFLAG_TURNING); }
        bool isMovingOrTurning() const { return HasUnitMovementFlag(MOVEFLAG_TURNING | MOVEFLAG_MOVING); }

        bool CanFly() const { return HasUnitMovementFlag(MOVEFLAG_CAN_FLY); }
        bool IsFlying() const { return HasUnitMovementFlag(MOVEFLAG_FLYING); }

        void HandleDrowning(uint32 time_diff);
        void HandleFallDamage(MovementInfo& movementInfo);
        void HandleFallUnderMap(float);

        void SetMover(Unit* target) { m_mover = target ? target : this; }
        Unit* GetMover() const { return m_mover; }
        bool IsSelfMover() const { return m_mover == this; }// normal case for player not controlling other unit
        void SetClientControl(Unit* target, uint8 allowMove);

        Unit* m_mover;

        uint64 GetFarSight() const { return GetUInt64Value(PLAYER_FARSIGHT); }
        void SetFarSight(uint64 guid) { SetUInt64Value(PLAYER_FARSIGHT, guid); }

        // Transports
        Transport * GetTransport() const { return m_transport; }
        void SetTransport(Transport * t) { m_transport = t; }

        float GetTransOffsetX() const { return m_movementInfo.GetTransportPos()->x; }
        float GetTransOffsetY() const { return m_movementInfo.GetTransportPos()->y; }
        float GetTransOffsetZ() const { return m_movementInfo.GetTransportPos()->z; }
        float GetTransOffsetO() const { return m_movementInfo.GetTransportPos()->o; }
        uint32 GetTransTime() const { return m_movementInfo.GetTransportTime(); }

        uint32 GetSaveTimer() const { return m_nextSave; }
        void   SetSaveTimer(uint32 timer) { m_nextSave = timer; }

        void SaveRecallPosition(TaxiNodesEntry const* = NULL);

        // Recall position
        WorldLocation _recallPosition;

        // Homebind coordinates
        uint32 m_homebindMapId;
        uint16 m_homebindZoneId;
        float m_homebindX;
        float m_homebindY;
        float m_homebindZ;

        void RelocateToHomebind() { SetMapId(m_homebindMapId); Relocate(m_homebindX,m_homebindY,m_homebindZ); }
        bool TeleportToHomebind(uint32 options = 0) { return TeleportTo(m_homebindMapId, m_homebindX, m_homebindY, m_homebindZ, GetOrientation(), options); }

        // currently visible objects at player client
        typedef std::set<uint64> ClientGUIDs;
        ClientGUIDs m_clientGUIDs;

        bool HaveAtClient(WorldObject const* u) const { return u == this || m_clientGUIDs.find(u->GetGUID()) != m_clientGUIDs.end(); }

        bool canSeeOrDetect(Unit const* u, WorldObject const*, bool detect, bool inVisibleList = false, bool is3dDistance = true) const;
        bool IsVisibleInGridForPlayer(Player const* pl) const;
        bool IsVisibleGloballyfor (Player* pl) const;

        void SendInitialVisiblePackets(Unit* target);

        template<class T>
        void UpdateVisibilityOf(WorldObject const*, T*, UpdateData&, std::set<WorldObject*>&);
        void UpdateVisibilityOf(WorldObject const*, WorldObject*);

        // Stealth detection system
        uint32 m_DetectInvTimer;
        void HandleStealthedUnitsDetection();

        uint8 m_forced_speed_changes[MAX_MOVE_TYPE];

        bool HasAtLoginFlag(AtLoginFlags f) const { return m_atLoginFlags & f; }
        void SetAtLoginFlag(AtLoginFlags f) { m_atLoginFlags |= f; }

        LookingForGroup m_lookingForGroup;

        // Temporarily removed pet cache
        uint32 GetTemporaryUnsummonedPetNumber() const { return m_temporaryUnsummonedPetNumber; }
        void SetTemporaryUnsummonedPetNumber(uint32 petnumber) { m_temporaryUnsummonedPetNumber = petnumber; }
        uint32 GetOldPetSpell() const { return m_oldpetspell; }
        void SetOldPetSpell(uint32 petspell) { m_oldpetspell = petspell; }
        void UnsummonPetTemporaryIfAny();
        void UnsummonPetIfAny();
        void ResummonPetTemporaryUnSummonedIfAny();
        bool IsPetNeedBeTemporaryUnsummoned() const;

        void SendCinematicStart(uint32 CinematicSequenceId);

        float GetXPRate(Rates rate);

        /*********************************************************/
        /***                 INSTANCE SYSTEM                   ***/
        /*********************************************************/

        typedef UNORDERED_MAP< uint32 /*mapId*/, InstancePlayerBind > BoundInstancesMap;

        void UpdateHomebindTime(uint32 time);

        uint32 m_HomebindTimer;
        bool m_InstanceValid;
        // permanent binds and solo binds by difficulty
        BoundInstancesMap m_boundInstances[TOTAL_DIFFICULTIES];
        InstancePlayerBind* GetBoundInstance(uint32 mapid, uint8 difficulty);
        BoundInstancesMap& GetBoundInstances(uint8 difficulty) { return m_boundInstances[difficulty]; }
        InstanceSave * GetInstanceSave(uint32 mapid);
        void UnbindInstance(uint32 mapid, uint8 difficulty, bool unload = false);
        void UnbindInstance(BoundInstancesMap::iterator &itr, uint8 difficulty, bool unload = false);
        InstancePlayerBind* BindToInstance(InstanceSave *save, bool permanent, bool load = false);
        void SendRaidInfo();
        void SendSavedInstances();
        static void ConvertInstancesToGroup(Player *player, Group *group = NULL, uint64 player_guid = 0);
        bool Satisfy(AccessRequirement const*, uint32 target_map, bool report = false);

        bool CheckInstanceCount(uint32 instanceId) const
        {
            if (_instanceResetTimes.size() < MAX_INSTANCES_PER_HOUR)
                return true;
            return _instanceResetTimes.find(instanceId) != _instanceResetTimes.end();
        }

        void AddInstanceEnterTime(uint32 instanceId, time_t enterTime)
        {
            if (_instanceResetTimes.find(instanceId) == _instanceResetTimes.end())
                _instanceResetTimes.insert(InstanceTimeMap::value_type(instanceId, enterTime + HOUR));
        }

        // last used pet number (for BG's)
        uint32 GetLastPetNumber() const { return m_lastpetnumber; }
        void SetLastPetNumber(uint32 petnumber) { m_lastpetnumber = petnumber; }

        /*********************************************************/
        /***                   GROUP SYSTEM                    ***/
        /*********************************************************/

        Group * GetGroupInvite() { return m_groupInvite; }
        void SetGroupInvite(Group *group) { m_groupInvite = group; }
        Group * GetGroup() { return m_group.getTarget(); }
        const Group * GetGroup() const { return (const Group*)m_group.getTarget(); }
        GroupReference& GetGroupRef() { return m_group; }
        void SetGroup(Group *group, int8 subgroup = -1);
        uint8 GetSubGroup() const { return m_group.getSubGroup(); }
        uint32 GetGroupUpdateFlag() { return m_groupUpdateMask; }
        void SetGroupUpdateFlag(uint32 flag) { m_groupUpdateMask |= flag; }
        uint64 GetAuraUpdateMask() { return m_auraUpdateMask; }
        void SetAuraUpdateMask(uint8 slot) { m_auraUpdateMask |= (uint64(1) << slot); }
        void UnsetAuraUpdateMask(uint8 slot) { m_auraUpdateMask &= ~(uint64(1) << slot); }
        void SetPassOnGroupLoot(bool bPassOnGroupLoot) { m_bPassOnGroupLoot = bPassOnGroupLoot; }
        bool GetPassOnGroupLoot() const { return m_bPassOnGroupLoot; }
        PartyResult CanUninviteFromGroup() const;

        void LFGAttemptJoin();
        void LFMAttemptAddMore();
        void LFGSet(uint8 slot, uint32 entry, uint32 type);
        void LFMSet(uint32 entry, uint32 type);
        void ClearLFG(bool leaveChannel = true);
        void ClearLFM(bool leaveChannel = true);
        uint8 IsLFM(uint32 type, uint32 entry);
        uint32 GetLFGCombined(uint8 slot);
        uint32 GetLFMCombined();

        GridReference<Player> &GetGridRef() { return m_gridRef; }
        MapReference &GetMapRef() { return m_mapRef; }

        bool isAllowedToLoot(Creature* creature);

        DeclinedName const* GetDeclinedNames() const { return m_declinedname; }
        bool HasTitle(uint32 bitIndex);
        bool HasTitle(CharTitlesEntry const* title) { return HasTitle(title->bit_index); }
        void SetTitle(CharTitlesEntry const* title);

        void ResetTimeSync();
        void SendTimeSync();

        // you can't follow while being followed
        void setGMFollow(uint64 guid) {m_GMfollow_GUID = guid; m_GMfollowtarget_GUID = 0;}
        void setFollowTarget(uint64 guid) {m_GMfollowtarget_GUID = guid; m_GMfollow_GUID = 0;}
        uint64 getFollowTarget() {return m_GMfollowtarget_GUID;}
        uint64 getFollowingGM() {return m_GMfollow_GUID;}

        PlayerAI *AI() const{ return (PlayerAI*)i_AI; }

        uint32 GetCachedZone() const { return m_zoneUpdateId; }
        uint32 GetCachedArea() const { return m_areaUpdateId; }

        void InterruptTaxiFlying();

        Camera& GetCamera() { return m_camera; }
        bool StopLevel(uint64 charid);
        bool ShowLowLevelQuest();

        void SendItemByMail(Player *plr,uint32 item, uint32 count);

    protected:
        TimeTrackerSmall positionStatus;

        /*********************************************************/
        /***               BATTLEGROUND SYSTEM                 ***/
        /*********************************************************/

        /* this variable is set to bg->m_InstanceID, when player is teleported to BG - (it is battleground's GUID)*/
        uint32 m_bgBattleGroundID;
        BattleGroundTypeId m_bgTypeID;
        /*
        this is an array of BG queues (BgTypeIDs) in which is player
        */
        struct BgBattleGroundQueueID_Rec
        {
            BattleGroundQueueTypeId bgQueueTypeId;
            uint32 invitedToInstance;
        };

        BgBattleGroundQueueID_Rec m_bgBattleGroundQueueID[PLAYER_MAX_BATTLEGROUND_QUEUES];
        uint32 m_bgEntryPointMap;
        float m_bgEntryPointX;
        float m_bgEntryPointY;
        float m_bgEntryPointZ;
        float m_bgEntryPointO;

        std::set<uint32> m_bgAfkReporter;
        uint8 m_bgAfkReportedCount;
        time_t m_bgAfkReportedTimer;
        uint32 m_contestedPvPTimer;

        uint32 m_bgTeam;    // what side the player will be added to

        /*********************************************************/
        /***                    QUEST SYSTEM                   ***/
        /*********************************************************/

        std::set<uint32> m_timedquests;
        std::set<uint32> m_monthlyquests;

        uint64 m_divider;
        uint32 m_ingametime;

        /*********************************************************/
        /***                   LOAD SYSTEM                     ***/
        /*********************************************************/

        void _LoadActions(QueryResultAutoPtr result);
        void _LoadAuras(QueryResultAutoPtr result, uint32 timediff);
        void _LoadBoundInstances(QueryResultAutoPtr result);
        void _LoadInventory(QueryResultAutoPtr result, uint32 timediff);
        void _LoadMails(QueryResultAutoPtr result);
        void _LoadMailedItems(QueryResultAutoPtr result);
        void _LoadQuestStatus(QueryResultAutoPtr result);
        void _LoadDailyQuestStatus(QueryResultAutoPtr result);
        void _LoadMonthlyQuestStatus(QueryResultAutoPtr result);
        void _LoadGroup(QueryResultAutoPtr result);
        void _LoadSpells(QueryResultAutoPtr result);
        void _LoadTutorials(QueryResultAutoPtr result);
        void _LoadFriendList(QueryResultAutoPtr result);
        bool _LoadHomeBind(QueryResultAutoPtr result);
        void _LoadDeclinedNames(QueryResultAutoPtr result);
        void _LoadArenaTeamInfo(QueryResultAutoPtr result);
        void _LoadInstanceTimeRestrictions(QueryResultAutoPtr result);

        /*********************************************************/
        /***                   SAVE SYSTEM                     ***/
        /*********************************************************/

        void _SaveActions();
        void _SaveAuras();
        void _SaveBattleGroundCoord();
        void _SaveInventory();
        void _SaveMail();
        void _SaveQuestStatus();
        void _SaveDailyQuestStatus();
        void _SaveMonthlyQuestStatus();
        void _SaveSpells();
        void _SaveTutorials();
        void _SaveInstanceTimeRestrictions();

        void _SetCreateBits(UpdateMask *updateMask, Player *target) const;
        void _SetUpdateBits(UpdateMask *updateMask, Player *target) const;

        /*********************************************************/
        /***              ENVIRONMENTAL SYSTEM                 ***/
        /*********************************************************/
        void HandleSobering();
        void SendMirrorTimer(MirrorTimerType Type, uint32 MaxValue, uint32 CurrentValue, int32 Regen);
        void StopMirrorTimer(MirrorTimerType Type);
        int32 getMaxTimer(MirrorTimerType timer);

        /*********************************************************/
        /***                  HONOR SYSTEM                     ***/
        /*********************************************************/
        time_t m_lastHonorUpdateTime;

        void outDebugValues() const;
        bool _removeSpell(uint16 spell_id);
        uint64 m_lootGuid;

        uint32 m_team;
        uint32 m_nextSave;
        uint32 m_dungeonDifficulty;

        uint32 m_atLoginFlags;

        Item* m_items[PLAYER_SLOTS_COUNT];
        uint32 m_currentBuybackSlot;

        std::vector<Item*> m_itemUpdateQueue;
        bool m_itemUpdateQueueBlocked;

        uint32 m_ExtraFlags;
        uint64 m_curSelection;

        uint64 m_comboTarget;
        int8 m_comboPoints;

        QuestStatusMap mQuestStatus;

        uint32 m_GuildIdInvited;
        uint32 m_ArenaTeamIdInvited;

        PlayerMails m_mail;
        PlayerSpellMap m_spells;
        SpellCooldowns m_spellCooldowns;

        ActionButtonList m_actionButtons;

        float m_auraBaseMod[BASEMOD_END][MOD_END];

        SpellModList m_spellMods[MAX_SPELLMOD];
        int32 m_SpellModRemoveCount;
        EnchantDurationList m_enchantDuration;
        ItemDurationList m_itemDuration;

        int32 m_spellPenetrationItemMod;

        uint64 m_resurrectGUID;
        uint32 m_resurrectMap;
        float m_resurrectX, m_resurrectY, m_resurrectZ;
        uint32 m_resurrectHealth, m_resurrectMana;

        WorldSession *m_session;

        typedef std::list<Channel*> JoinedChannelsList;
        JoinedChannelsList m_channels;

        bool m_cinematic;
        uint32 m_watchingCinematicId;

        Player *pTrader;
        bool acceptTrade;
        uint16 tradeItems[TRADE_SLOT_COUNT];
        uint32 tradeGold;

        time_t m_nextThinkTime;

        uint32 m_Tutorials[8];
        bool m_TutorialsChanged;

        bool m_DailyQuestChanged;
        time_t m_lastDailyQuestTime;

        bool m_MonthlyQuestChanged;
        time_t m_lastMonthlyQuestTime;

        uint32 m_drunkTimer;
        uint16 m_drunk;
        uint32 m_weaponChangeTimer;

        uint32 m_zoneUpdateId;
        uint32 m_zoneUpdateTimer;
        uint32 m_areaUpdateId;

        uint32 m_deathTimer;
        time_t m_deathExpireTime;

        uint32 m_restTime;

        uint32 m_WeaponProficiency;
        uint32 m_ArmorProficiency;
        bool m_canParry;
        bool m_canBlock;
        uint8 m_swingErrorMsg;
        float m_ammoDPS;
        ////////////////////Rest System/////////////////////
        int time_inn_enter;
        uint32 inn_pos_mapid;
        float  inn_pos_x;
        float  inn_pos_y;
        float  inn_pos_z;
        float m_rest_bonus;
        RestType rest_type;
        ////////////////////Rest System/////////////////////

        // Transports
        Transport * m_transport;

        uint32 m_resetTalentsCost;
        time_t m_resetTalentsTime;
        uint32 m_usedTalentCount;

        // Social
        PlayerSocial *m_social;

        // Groups
        GroupReference m_group;
        GroupReference m_originalGroup;

        Group *m_groupInvite;
        uint32 m_groupUpdateMask;
        uint64 m_auraUpdateMask;
        bool m_bPassOnGroupLoot;

        uint64 m_miniPet;
        GuardianPetList m_guardianPets;

        // last used pet number (for BG's)
        uint32 m_lastpetnumber;

        // Player summoning
        time_t m_summon_expire;
        uint32 m_summon_mapid;
        float  m_summon_x;
        float  m_summon_y;
        float  m_summon_z;

        bool m_farsightVision;

        bool _preventSave;
        bool _preventUpdate;

        DeclinedName *m_declinedname;

        ACE_Thread_Mutex updateMutex;

    private:
        // internal common parts for CanStore/StoreItem functions
        uint8 _CanStoreItem_InSpecificSlot(uint8 bag, uint8 slot, ItemPosCountVec& dest, ItemPrototype const *pProto, uint32& count, bool swap, Item *pSrcItem) const;
        uint8 _CanStoreItem_InBag(uint8 bag, ItemPosCountVec& dest, ItemPrototype const *pProto, uint32& count, bool merge, bool non_specialized, Item *pSrcItem, uint8 skip_bag, uint8 skip_slot) const;
        uint8 _CanStoreItem_InInventorySlots(uint8 slot_begin, uint8 slot_end, ItemPosCountVec& dest, ItemPrototype const *pProto, uint32& count, bool merge, Item *pSrcItem, uint8 skip_bag, uint8 skip_slot) const;
        Item* _StoreItem(uint16 pos, Item *pItem, uint32 count, bool clone, bool update);

        void UpdateKnownCurrencies(uint32 itemId, bool apply);
        void AdjustQuestReqItemCount(Quest const* pQuest, QuestStatusData& questStatusData);

        int32 m_MirrorTimer[MAX_TIMERS];
        uint8 m_MirrorTimerFlags;
        uint8 m_MirrorTimerFlagsLast;
        bool m_isInWater;

        GridReference<Player> m_gridRef;
        MapReference m_mapRef;

        uint64 m_GMfollowtarget_GUID; // za kim chodzi
        uint64 m_GMfollow_GUID;       // gm ktory chodzi za playerem

        uint32 m_timeSyncCounter;
        uint32 m_timeSyncTimer;
        uint32 m_timeSyncClient;
        uint32 m_timeSyncServer;
        
        // Current teleport data
        WorldLocation m_teleport_dest;
        bool mSemaphoreTeleport_Near;
        bool mSemaphoreTeleport_Far;

        // Temporary removed pet cache
        uint32 m_temporaryUnsummonedPetNumber;
        uint32 m_oldpetspell;

        CooldownMgr m_CooldownMgr;

        ReputationMgr  m_reputationMgr;

        Camera m_camera;

        bool m_outdoors;

        InstanceTimeMap _instanceResetTimes;
};

typedef std::set<Player*> PlayerSet;
typedef std::list<Player*> PlayerList;

void AddItemsSetItem(Player*player,Item *item);
void RemoveItemsSetItem(Player*player,ItemPrototype const *proto);

// "the bodies of template functions must be made available in a header file"
template <class T> T Player::ApplySpellMod(uint32 spellId, SpellModOp op, T &basevalue, Spell const* spell)
{
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);
    if (!spellInfo) return 0;
    int32 totalpct = 0;
    int32 totalflat = 0;
    for (SpellModList::iterator itr = m_spellMods[op].begin(); itr != m_spellMods[op].end(); ++itr)
    {
        SpellModifier *mod = *itr;

        if (!IsAffectedBySpellmod(spellInfo,mod,spell))
            continue;

        if (mod->type == SPELLMOD_FLAT)
            totalflat += mod->value;
        else if (mod->type == SPELLMOD_PCT)
        {
            // skip percent mods for null basevalue (most important for spell mods with charges)
            if (basevalue == T(0))
                continue;

            // special case (skip > 10sec spell casts for instant cast setting)
            if (mod->op == SPELLMOD_CASTING_TIME)
                if (SpellMgr::GetSpellBaseCastTime(spellInfo) >= T(10000))
                    continue;
            totalpct += mod->value;
        }

        if (mod->charges > 0)
        {
          if (!(spellInfo->SpellFamilyName == 8 && spellInfo->SpellFamilyFlags & 0x200000000LL))
            --mod->charges;
            if (mod->charges == 0)
            {
                mod->charges = -1;
                mod->lastAffected = spell;
                if (!mod->lastAffected)
                    mod->lastAffected = FindCurrentSpellBySpellId(spellId);
                ++m_SpellModRemoveCount;
            }
        }
    }

    float diff = (float)basevalue*(float)totalpct/100.0f + (float)totalflat;
    basevalue = T((float)basevalue + diff);
    return T(diff);
}
#endif
