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

#ifndef _SPELLMGR_H
#define _SPELLMGR_H

// For static or at-server-startup loaded spell data
// For more high level function for sSpellStore data
#include <ace/Singleton.h>
#include <ace/Null_Mutex.h>

#include "SharedDefines.h"
#include "DBCStructure.h"
#include "DBCStores.h"
#include "Database/SQLStorage.h"

#include "Utilities/UnorderedMap.h"
#include <map>

class Player;
class Spell;

extern SQLStorage sSpellThreatStore;

enum SpellFamilyNames
{
    SPELLFAMILY_GENERIC     = 0,
    SPELLFAMILY_UNK1        = 1,                            // events, holidays
    // 2 - unused
    SPELLFAMILY_MAGE        = 3,
    SPELLFAMILY_WARRIOR     = 4,
    SPELLFAMILY_WARLOCK     = 5,
    SPELLFAMILY_PRIEST      = 6,
    SPELLFAMILY_DRUID       = 7,
    SPELLFAMILY_ROGUE       = 8,
    SPELLFAMILY_HUNTER      = 9,
    SPELLFAMILY_PALADIN     = 10,
    SPELLFAMILY_SHAMAN      = 11,
    SPELLFAMILY_UNK2        = 12,
    SPELLFAMILY_POTION      = 13
};

enum SpellDisableTypes
{
    SPELL_DISABLE_PLAYER = 1,
    SPELL_DISABLE_CREATURE = 2,
    SPELL_DISABLE_PET = 4
};

enum SpellEffectTargetTypes
{
    SPELL_REQUIRE_NONE,
    SPELL_REQUIRE_UNIT,
    SPELL_REQUIRE_DEST,
    SPELL_REQUIRE_ITEM,
    SPELL_REQUIRE_CASTER,
};

enum SpellSelectTargetTypes
{
    TARGET_TYPE_DEFAULT,
    TARGET_TYPE_UNIT_CASTER,
    TARGET_TYPE_UNIT_TARGET,
    TARGET_TYPE_UNIT_NEARBY,
    TARGET_TYPE_AREA_SRC,
    TARGET_TYPE_AREA_DST,
    TARGET_TYPE_AREA_CONE,
    TARGET_TYPE_DEST_CASTER,
    TARGET_TYPE_DEST_TARGET,
    TARGET_TYPE_DEST_DEST,
    TARGET_TYPE_DEST_SPECIAL,
    TARGET_TYPE_CHANNEL,
};

//Some SpellFamilyFlags
#define SPELLFAMILYFLAG_ROGUE_VANISH            0x000000800LL
#define SPELLFAMILYFLAG_ROGUE_STEALTH           0x000400000LL
#define SPELLFAMILYFLAG_ROGUE_BACKSTAB          0x000800004LL
#define SPELLFAMILYFLAG_ROGUE_SAP               0x000000080LL
#define SPELLFAMILYFLAG_ROGUE_FEINT             0x008000000LL
#define SPELLFAMILYFLAG_ROGUE_KIDNEYSHOT        0x000200000LL
#define SPELLFAMILYFLAG_ROGUE__FINISHING_MOVE   0x9003E0000LL
#define SPELLFAMILYFLAG_WARRIOR_SUNDERARMOR     0x000004000LL
#define SPELLFAMILYFLAG_SHAMAN_FROST_SHOCK      0x080000000LL

// Spell clasification
enum SpellSpecific
{
    SPELL_NORMAL            = 0,
    SPELL_SEAL              = 1,
    SPELL_BLESSING          = 2,
    SPELL_AURA              = 3,
    SPELL_STING             = 4,
    SPELL_CURSE             = 5,
    SPELL_ASPECT            = 6,
    SPELL_TRACKER           = 7,
    SPELL_WARLOCK_ARMOR     = 8,
    SPELL_MAGE_ARMOR        = 9,
    SPELL_ELEMENTAL_SHIELD  = 10,
    SPELL_MAGE_POLYMORPH    = 11,
    SPELL_POSITIVE_SHOUT    = 12,
    SPELL_JUDGEMENT         = 13,
    SPELL_BATTLE_ELIXIR     = 14,
    SPELL_GUARDIAN_ELIXIR   = 15,
    SPELL_FLASK_ELIXIR      = 16,
    SPELL_WARLOCK_CORRUPTION= 17,
    SPELL_WELL_FED          = 18,
    SPELL_DRINK             = 19,
    SPELL_FOOD              = 20,
    SPELL_CHARM             = 21,
    SPELL_WARRIOR_ENRAGE    = 22,
};

#define SPELL_LINKED_MAX_SPELLS  200000

enum SpellLinkedType
{
    SPELL_LINK_CAST     = 0,            // +: cast; -: remove
    SPELL_LINK_HIT      = 1 * 200000,
    SPELL_LINK_AURA     = 2 * 200000,   // +: aura; -: immune
    SPELL_LINK_PRECAST  = 3 * 200000,
    SPELL_LINK_REMOVE   = 0,
};

// Spell affects related declarations (accessed using SpellMgr functions)
typedef std::map<uint32, uint64> SpellAffectMap;

// Spell proc event related declarations (accessed using SpellMgr functions)
enum ProcFlags
{
   PROC_FLAG_NONE                            = 0x00000000,

   PROC_FLAG_KILLED                          = 0x00000001,    // 00 Killed by agressor
   PROC_FLAG_KILL_AND_GET_XP                 = 0x00000002,    // 01 Kill that yields experience or honor

   PROC_FLAG_SUCCESSFUL_MELEE_HIT            = 0x00000004,    // 02 Successful melee attack
   PROC_FLAG_TAKEN_MELEE_HIT                 = 0x00000008,    // 03 Taken damage from melee strike hit

   PROC_FLAG_SUCCESSFUL_MELEE_SPELL_HIT      = 0x00000010,    // 04 Successful attack by Spell that use melee weapon
   PROC_FLAG_TAKEN_MELEE_SPELL_HIT           = 0x00000020,    // 05 Taken damage by Spell that use melee weapon

   PROC_FLAG_SUCCESSFUL_RANGED_HIT           = 0x00000040,    // 06 Successful Ranged attack (all ranged attack deal as spell so newer set :()
   PROC_FLAG_TAKEN_RANGED_HIT                = 0x00000080,    // 07 Taken damage from ranged attack (all ranged attack deal as spell so newer set :()

   PROC_FLAG_SUCCESSFUL_RANGED_SPELL_HIT     = 0x00000100,    // 08 Successful Ranged attack by Spell that use ranged weapon
   PROC_FLAG_TAKEN_RANGED_SPELL_HIT          = 0x00000200,    // 09 Taken damage by Spell that use ranged weapon

   PROC_FLAG_SUCCESSFUL_POSITIVE_AOE_HIT     = 0x00000400,    // 10 Successful AoE (not 100% shure unused)
   PROC_FLAG_TAKEN_POSITIVE_AOE              = 0x00000800,    // 11 Taken AoE      (not 100% shure unused)

   PROC_FLAG_SUCCESSFUL_AOE_SPELL_HIT        = 0x00001000,    // 12 Successful AoE damage spell hit (not 100% shure unused)
   PROC_FLAG_TAKEN_AOE_SPELL_HIT             = 0x00002000,    // 13 Taken AoE damage spell hit      (not 100% shure unused)

   PROC_FLAG_SUCCESSFUL_POSITIVE_SPELL       = 0x00004000,    // 14 Successful cast positive spell (by default only on healing)
   PROC_FLAG_TAKEN_POSITIVE_SPELL            = 0x00008000,    // 15 Taken positive spell hit (by default only on healing)

   PROC_FLAG_SUCCESSFUL_NEGATIVE_SPELL_HIT   = 0x00010000,    // 16 Successful negative spell cast (by default only on damage)
   PROC_FLAG_TAKEN_NEGATIVE_SPELL_HIT        = 0x00020000,    // 17 Taken negative spell (by default only on damage)

   PROC_FLAG_ON_DO_PERIODIC                  = 0x00040000,    // 18 Successful do periodic (damage / healing, determined from 14-17 flags)
   PROC_FLAG_ON_TAKE_PERIODIC                = 0x00080000,    // 19 Taken spell periodic (damage / healing, determined from 14-17 flags)

   PROC_FLAG_TAKEN_ANY_DAMAGE                = 0x00100000,    // 20 Taken any damage
   PROC_FLAG_ON_TRAP_ACTIVATION              = 0x00200000,    // 21 On trap activation

   PROC_FLAG_TAKEN_OFFHAND_HIT               = 0x00400000,    // 22 Taken off-hand melee attacks(not used)
   PROC_FLAG_SUCCESSFUL_OFFHAND_HIT          = 0x00800000,    // 23 Successful off-hand melee attacks

   PROC_FLAG_DELAYED_NEGATIVE_SPELL_CAST_END = 0x01000000,    // 24 end of negative delayed spell cast
   PROC_FLAG_DELAYED_POSITIVE_SPELL_CAST_END = 0x02000000,    // 25 end of positive delayed spell cast
   PROC_FLAG_DELAYED_RANGED_SPELL_CAST_END   = 0x04000000,    // 26 end of ranged delayed spell cast
   PROC_FLAG_DELAYED_MELEE_SPELL_CAST_END    = 0x04000000,    // 27 end of melee delayed spell cast
};

#define MELEE_BASED_TRIGGER_MASK (PROC_FLAG_SUCCESSFUL_MELEE_HIT        | \
                                  PROC_FLAG_TAKEN_MELEE_HIT             | \
                                  PROC_FLAG_SUCCESSFUL_MELEE_SPELL_HIT  | \
                                  PROC_FLAG_TAKEN_MELEE_SPELL_HIT       | \
                                  PROC_FLAG_SUCCESSFUL_RANGED_HIT       | \
                                  PROC_FLAG_TAKEN_RANGED_HIT            | \
                                  PROC_FLAG_SUCCESSFUL_RANGED_SPELL_HIT | \
                                  PROC_FLAG_TAKEN_RANGED_SPELL_HIT)

enum ProcFlagsEx
{
   PROC_EX_NONE                = 0x0000000,                 // If none can tigger on Hit/Crit only (passive spells MUST defined by SpellFamily flag)
   PROC_EX_NORMAL_HIT          = 0x0000001,                 // If set only from normal hit (only damage spells)
   PROC_EX_CRITICAL_HIT        = 0x0000002,
   PROC_EX_MISS                = 0x0000004,
   PROC_EX_RESIST              = 0x0000008,
   PROC_EX_DODGE               = 0x0000010,
   PROC_EX_PARRY               = 0x0000020,
   PROC_EX_BLOCK               = 0x0000040,
   PROC_EX_EVADE               = 0x0000080,
   PROC_EX_IMMUNE              = 0x0000100,
   PROC_EX_DEFLECT             = 0x0000200,
   PROC_EX_ABSORB              = 0x0000400,
   PROC_EX_REFLECT             = 0x0000800,
   PROC_EX_INTERRUPT           = 0x0001000,                 // Melle hit result can be Interrupt (not used)
   PROC_EX_RESERVED1           = 0x0002000,
   PROC_EX_RESERVED2           = 0x0004000,
   PROC_EX_RESERVED3           = 0x0008000,
   PROC_EX_EX_TRIGGER_ALWAYS   = 0x0010000,                 // If set trigger always (no matter another flags) used for drop charges
   PROC_EX_EX_ONE_TIME_TRIGGER = 0x0020000,                 // If set trigger always but only one time
   PROC_EX_INTERNAL_HOT        = 0x1000000,                 // Only for internal use
   PROC_EX_INTERNAL_DOT        = 0x2000000,                 // Only for internal use
   PROC_EX_DAMAGE_OR_HEAL      = 0x4000000,                 // Used with PROC_FLAG_SUCCESSFUL_NEGATIVE/POSITIVE_SPELL_HIT
                                                            // will trigger only when damaging/healing spell (direct or periodic)
   PROC_EX_DIRECT_DAMAGE       = 0x8000000                  // do not proc from absorbed damage
};

struct SpellProcEventEntry
{
    uint32      schoolMask;                                 // if nonzero - bit mask for matching proc condition based on spell candidate's school: Fire=2, Mask=1<<(2-1)=2
    uint32      spellFamilyName;                            // if nonzero - for matching proc condition based on candidate spell's SpellFamilyNamer value
    uint64      spellFamilyMask;                            // if nonzero - for matching proc condition based on candidate spell's SpellFamilyFlags (like auras 107 and 108 do)
    uint32      procFlags;                                  // bitmask for matching proc event
    uint32      procEx;                                     // proc Extend info (see ProcFlagsEx)
    float       ppmRate;                                    // for melee (ranged?) damage spells - proc rate per minute. if zero, falls back to flat chance from Spell.dbc
    float       customChance;                               // Owerride chance (in most cases for debug only)
    uint32      cooldown;                                   // hidden cooldown used for some spell proc events, applied to _triggered_spell_
};

typedef UNORDERED_MAP<uint32, SpellProcEventEntry> SpellProcEventMap;

struct SpellEnchantProcEntry
{
    uint32      customChance;
    float       PPMChance;
    uint32      procFlags;
    uint32      procEx;
};

typedef UNORDERED_MAP<uint32, SpellEnchantProcEntry> SpellEnchantProcEventMap;

struct SpellBonusData
{
    float    direct_co;
    float       dot_co;
    float direct_ap_co;
    float    dot_ap_co;
};
typedef std::map<uint32, SpellBonusData> SpellBonusDataMap;

#define ELIXIR_BATTLE_MASK    0x1
#define ELIXIR_GUARDIAN_MASK  0x2
#define ELIXIR_FLASK_MASK     (ELIXIR_BATTLE_MASK|ELIXIR_GUARDIAN_MASK)
#define ELIXIR_UNSTABLE_MASK  0x4
#define ELIXIR_SHATTRATH_MASK 0x8

typedef std::map<uint32, uint8> SpellElixirMap;

// Spell script target related declarations (accessed using SpellMgr functions)
enum SpellScriptTargetType
{
    SPELL_TARGET_TYPE_GAMEOBJECT    = 0,
    SPELL_TARGET_TYPE_CREATURE      = 1,
    SPELL_TARGET_TYPE_DEAD          = 2,

    SPELL_TARGET_TYPE_NONE
};

#define MAX_SPELL_TARGET_TYPE 3

struct SpellTargetEntry
{
    SpellTargetEntry(SpellScriptTargetType type_,uint32 targetEntry_) : type(type_), targetEntry(targetEntry_) {}
    SpellScriptTargetType type;
    uint32 targetEntry;
};

typedef std::multimap<uint32,SpellTargetEntry> SpellScriptTarget;

// coordinates for spells (accessed using SpellMgr functions)
struct SpellTargetPosition
{
    uint32 target_mapId;
    float  target_X;
    float  target_Y;
    float  target_Z;
    float  target_Orientation;
};

typedef UNORDERED_MAP<uint32, SpellTargetPosition> SpellTargetPositionMap;

// Spell pet auras
class PetAura
{
    public:
        PetAura()
        {
            auras.clear();
        }

        PetAura(uint16 petEntry, uint16 aura, bool _removeOnChangePet, int _damage) :
        removeOnChangePet(_removeOnChangePet), damage(_damage)
        {
            auras[petEntry] = aura;
        }

        uint16 GetAura(uint16 petEntry) const
        {
            std::map<uint16, uint16>::const_iterator itr = auras.find(petEntry);
            if (itr != auras.end())
                return itr->second;
            else
            {
                std::map<uint16, uint16>::const_iterator itr2 = auras.find(0);
                if (itr2 != auras.end())
                    return itr2->second;
                else
                    return 0;
            }
        }

        void AddAura(uint16 petEntry, uint16 aura)
        {
            auras[petEntry] = aura;
        }

        bool IsRemovedOnChangePet() const
        {
            return removeOnChangePet;
        }

        int32 GetDamage() const
        {
            return damage;
        }

    private:
        std::map<uint16, uint16> auras;
        bool removeOnChangePet;
        int32 damage;
};
typedef std::map<uint16, PetAura> SpellPetAuraMap;

// Spell rank chain  (accessed using SpellMgr functions)
struct SpellChainNode
{
    uint32 prev;
    uint32 next;
    uint32 first;
    uint32 last;
    uint32 cur;
    uint8  rank;
};

typedef UNORDERED_MAP<uint32, SpellChainNode> SpellChainMap;

//                 spell_id  req_spell
typedef UNORDERED_MAP<uint32, uint32> SpellRequiredMap;

typedef std::multimap<uint32, uint32> SpellsRequiringSpellMap;

// Spell learning properties (accessed using SpellMgr functions)
struct SpellLearnSkillNode
{
    uint32 skill;
    uint32 value;                                           // 0  - max skill value for player level
    uint32 maxvalue;                                        // 0  - max skill value for player level
};

typedef std::map<uint32, SpellLearnSkillNode> SpellLearnSkillMap;

struct SpellLearnSpellNode
{
    uint32 spell;
    bool autoLearned;
};

typedef std::multimap<uint32, SpellLearnSpellNode> SpellLearnSpellMap;

typedef std::multimap<uint32, SkillLineAbilityEntry const*> SkillLineAbilityMap;

enum AttributesCu
{
    SPELL_ATTR_CU_IGNORE_ARMOR          = 0x00000001,
    SPELL_ATTR_CU_CONE_BACK             = 0x00000002,
    SPELL_ATTR_CU_CONE_LINE             = 0x00000004,
    SPELL_ATTR_CU_SHARE_DAMAGE          = 0x00000008,
    SPELL_ATTR_CU_AURA_HOT              = 0x00000010,
    SPELL_ATTR_CU_AURA_DOT              = 0x00000020,
    SPELL_ATTR_CU_AURA_CC               = 0x00000040,
    SPELL_ATTR_CU_AURA_SPELL            = 0x00000080,
    SPELL_ATTR_CU_DIRECT_DAMAGE         = 0x00000100,
    SPELL_ATTR_CU_CHARGE                = 0x00000200,
    SPELL_ATTR_CU_LINK_CAST             = 0x00000400,     // after cast bar
    SPELL_ATTR_CU_LINK_HIT              = 0x00000800,
    SPELL_ATTR_CU_LINK_AURA             = 0x00001000,
    SPELL_ATTR_CU_LINK_REMOVE           = 0x00002000,
    SPELL_ATRR_CU_LINK_PRECAST          = 0x00004000,     // before cast barem
    SPELL_ATTR_CU_MOVEMENT_IMPAIR       = 0x00008000,
    SPELL_ATTR_CU_FAKE_DELAY            = 0x00010000,
    SPELL_ATTR_CU_FIXED_DAMAGE          = 0x00020000, // ignore all %dmg done, %dmg taken auras
    SPELL_ATTR_CU_NO_SPELL_DMG_COEFF    = 0x00040000, // to those spells won't be applied and bonuses from spell dmg
    SPELL_ATTR_CU_TREAT_AS_WELL_FEED    = 0x00080000,
    SPELL_ATTR_CU_NO_SCROLL_STACK       = 0x00100000  // for spells which can't stack with scrolls (must be also applied to scroll spells)
};

#define SPELL_FAKE_DELAY 200LL

typedef std::map<int32, std::vector<int32> > SpellLinkedMap;

extern bool IsAreaEffectTarget[TOTAL_SPELL_TARGETS];

class LOOKING4GROUP_IMPORT_EXPORT SpellMgr
{
    friend class ACE_Singleton<SpellMgr, ACE_Null_Mutex >;

    // Constructors
    public:
        SpellMgr();
        ~SpellMgr();

        // Accessors (const or static functions)
    public:
        // Spell affects
        uint64 GetSpellAffectMask(uint16 spellId, uint8 effectId) const;

        bool IsAffectedBySpell(SpellEntry const *spellInfo, uint32 spellId, uint8 effectId, uint64 familyFlags) const;

        bool IsPositionTarget(uint32 target);

        SpellElixirMap const& GetSpellElixirMap() const { return mSpellElixirs; }

        uint32 GetSpellElixirMask(uint32 spellid) const
        {
            SpellElixirMap::const_iterator itr = mSpellElixirs.find(spellid);
            if (itr==mSpellElixirs.end())
                return 0x0;

            return itr->second;
        }

        SpellSpecific GetSpellElixirSpecific(uint32 spellid) const
        {
            uint32 mask = GetSpellElixirMask(spellid);
            if ((mask & ELIXIR_FLASK_MASK)==ELIXIR_FLASK_MASK)
                return SPELL_FLASK_ELIXIR;
            else if (mask & ELIXIR_BATTLE_MASK)
                return SPELL_BATTLE_ELIXIR;
            else if (mask & ELIXIR_GUARDIAN_MASK)
                return SPELL_GUARDIAN_ELIXIR;
            else
                return SPELL_NORMAL;
        }

        // Spell proc events
        SpellProcEventEntry const* GetSpellProcEvent(uint32 spellId) const
        {
            SpellProcEventMap::const_iterator itr = mSpellProcEventMap.find(spellId);
            if (itr != mSpellProcEventMap.end())
                return &itr->second;
            return NULL;
        }

        static bool IsSpellProcEventCanTriggeredBy(SpellProcEventEntry const * spellProcEvent, uint32 EventProcFlag, SpellEntry const * procSpell, uint32 procFlags, uint32 procExtra, bool active);

        SpellEnchantProcEntry const* GetSpellEnchantProcEvent(uint32 enchId) const
        {
            SpellEnchantProcEventMap::const_iterator itr = mSpellEnchantProcEventMap.find(enchId);
            if (itr != mSpellEnchantProcEventMap.end())
                return &itr->second;
            return NULL;
        }

        // Spell target coordinates
        SpellTargetPosition const* GetSpellTargetPosition(uint32 spell_id) const
        {
            SpellTargetPositionMap::const_iterator itr = mSpellTargetPositions.find(spell_id);
            if (itr != mSpellTargetPositions.end())
                return &itr->second;
            return NULL;
        }

        // Spell ranks chains
        SpellChainNode const* GetSpellChainNode(uint32 spell_id) const
        {
            SpellChainMap::const_iterator itr = mSpellChains.find(spell_id);
            if (itr == mSpellChains.end())
                return NULL;

            return &itr->second;
        }

        uint32 GetSpellRequired(uint32 spell_id) const
        {
            SpellRequiredMap::const_iterator itr = mSpellReq.find(spell_id);
            if (itr == mSpellReq.end())
                return 0;

            return itr->second;
        }

        uint32 GetFirstSpellInChain(uint32 spell_id) const
        {
            if (SpellChainNode const* node = GetSpellChainNode(spell_id))
                return node->first;

            return spell_id;
        }

        uint32 GetPrevSpellInChain(uint32 spell_id) const
        {
            if (SpellChainNode const* node = GetSpellChainNode(spell_id))
                return node->prev;

            return 0;
        }

        SpellsRequiringSpellMap const& GetSpellsRequiringSpell() const { return mSpellsReqSpell; }

        // Note: not use rank for compare to spell ranks: spell chains isn't linear order
        // Use IsHighRankOfSpell instead
        uint8 GetSpellRank(uint32 spell_id) const
        {
            if (SpellChainNode const* node = GetSpellChainNode(spell_id))
                return node->rank;

            return 0;
        }

        uint32 GetLastSpellInChain(uint32 spell_id) const
        {
            if (SpellChainNode const* node = GetSpellChainNode(spell_id))
                return node->last;

            return spell_id;
        }

        uint8 IsHighRankOfSpell(uint32 spell1,uint32 spell2) const
        {
            SpellChainMap::const_iterator itr = mSpellChains.find(spell1);

            uint32 rank2 = GetSpellRank(spell2);

            // not ordered correctly by rank value
            if (itr == mSpellChains.end() || !rank2 || itr->second.rank <= rank2)
                return false;

            // check present in same rank chain
            for (; itr != mSpellChains.end(); itr = mSpellChains.find(itr->second.prev))
                if (itr->second.prev==spell2)
                    return true;

            return false;
        }

        bool IsRankSpellDueToSpell(SpellEntry const *spellInfo_1,uint32 spellId_2) const;

        static bool canStackSpellRanks(SpellEntry const *spellInfo);
        static bool IsNoStackSpellDueToSpell(uint32 spellId_1, uint32 spellId_2, bool sameCaster);
        static bool IsSpecialStackCase(SpellEntry const *spellInfo_1, SpellEntry const *spellInfo_2, bool sameCaster, bool recur = true);
        static bool IsSpecialNoStackCase(SpellEntry const *spellInfo_1, SpellEntry const *spellInfo_2, bool sameCaster, bool recur = true);

        SpellEntry const* SelectAuraRankForPlayerLevel(SpellEntry const* spellInfo, uint32 playerLevel) const;

        // Spell learning
        SpellLearnSkillNode const* GetSpellLearnSkill(uint32 spell_id) const
        {
            SpellLearnSkillMap::const_iterator itr = mSpellLearnSkills.find(spell_id);
            if (itr != mSpellLearnSkills.end())
                return &itr->second;
            else
                return NULL;
        }

        bool IsSpellLearnSpell(uint32 spell_id) const
        {
            return mSpellLearnSpells.find(spell_id) != mSpellLearnSpells.end();
        }

        SpellLearnSpellMap::const_iterator GetBeginSpellLearnSpell(uint32 spell_id) const
        {
            return mSpellLearnSpells.lower_bound(spell_id);
        }

        SpellLearnSpellMap::const_iterator GetEndSpellLearnSpell(uint32 spell_id) const
        {
            return mSpellLearnSpells.upper_bound(spell_id);
        }

        bool IsSpellLearnToSpell(uint32 spell_id1,uint32 spell_id2) const
        {
            SpellLearnSpellMap::const_iterator b = GetBeginSpellLearnSpell(spell_id1);
            SpellLearnSpellMap::const_iterator e = GetEndSpellLearnSpell(spell_id1);
            for (SpellLearnSpellMap::const_iterator i = b; i != e; ++i)
                if (i->second.spell==spell_id2)
                    return true;
            return false;
        }

        static bool IsProfessionSpell(uint32 spellId);
        static bool IsPrimaryProfessionSpell(uint32 spellId);
        bool IsPrimaryProfessionFirstRankSpell(uint32 spellId) const;

        // Spell script targets
        SpellScriptTarget::const_iterator GetBeginSpellScriptTarget(uint32 spell_id) const
        {
            return mSpellScriptTarget.lower_bound(spell_id);
        }

        SpellScriptTarget::const_iterator GetEndSpellScriptTarget(uint32 spell_id) const
        {
            return mSpellScriptTarget.upper_bound(spell_id);
        }

        // Spell correctess for client using
        static bool IsSpellValid(SpellEntry const * spellInfo, Player* pl = NULL, bool msg = true);

        SkillLineAbilityMap::const_iterator GetBeginSkillLineAbilityMap(uint32 spell_id) const
        {
            return mSkillLineAbilityMap.lower_bound(spell_id);
        }

        SkillLineAbilityMap::const_iterator GetEndSkillLineAbilityMap(uint32 spell_id) const
        {
            return mSkillLineAbilityMap.upper_bound(spell_id);
        }

        PetAura const* GetPetAura(uint16 spell_id)
        {
            SpellPetAuraMap::const_iterator itr = mSpellPetAuraMap.find(spell_id);
            if (itr != mSpellPetAuraMap.end())
                return &itr->second;
            else
                return NULL;
        }

        const std::vector<int32> *GetSpellLinked(int32 spell_id) const
        {
            SpellLinkedMap::const_iterator itr = mSpellLinkedMap.find(spell_id);
            return itr != mSpellLinkedMap.end() ? &(itr->second) : NULL;
        }

        const SpellBonusData *getSpellBonusData(uint32 spell_id)
        {
            SpellBonusDataMap::const_iterator itr = mSpellBonusDataMap.find(spell_id);
            return itr != mSpellBonusDataMap.end() ? &(itr->second) : NULL;
        }

        SpellEffectTargetTypes EffectTargetType[TOTAL_SPELL_EFFECTS];
        SpellSelectTargetTypes SpellTargetType[TOTAL_SPELL_TARGETS];

        static void ApplySpellThreatModifiers(SpellEntry const *spellInfo, float &threat);

        // Different spell properties
        static uint32 GetSpellCastTime(SpellEntry const* spellInfo, Spell const* spell = NULL);
        static SpellSpecific GetSpellSpecific(uint32);

        static float GetSpellRadiusForHostile(SpellRadiusEntry const*);
        static float GetSpellRadiusForFriend(SpellRadiusEntry const*);
        static float GetSpellMaxRange(SpellEntry const*);
        static float GetSpellMinRange(SpellEntry const*);
        static float GetSpellMinRange(uint32);
        static float GetSpellMaxRange(uint32);
        static float GetSpellMinRange(SpellRangeEntry const *range);
        static float GetSpellMaxRange(SpellRangeEntry const *range);
        static uint32 GetSpellRangeType(SpellRangeEntry const *range);

        static uint32 GetSpellBaseCastTime(SpellEntry const *spellInfo);
        static uint32 GetSpellRecoveryTime(SpellEntry const *spellInfo);
        static int32 GetSpellDuration(SpellEntry const *spellInfo);
        static int32 GetSpellMaxDuration(SpellEntry const *spellInfo);

        static float GetSpellRadius(SpellEntry const *spellInfo, uint32 effectIdx, bool positive);

        static bool IsSplashBuffAura(SpellEntry const* spellInfo);

        static bool IsSealSpell(SpellEntry const *spellInfo);

        static bool IsElementalShield(SpellEntry const *spellInfo);

        static uint32 CalculatePowerCost(SpellEntry const * spellInfo, Unit const * caster, SpellSchoolMask schoolMask);
        static int32 CompareAuraRanks(uint32 spellId_1, uint32 effIndex_1, uint32 spellId_2, uint32 effIndex_2);
        static bool IsSingleFromSpellSpecificPerCaster(SpellSpecific spellSpec1, SpellSpecific spellSpec2);
        static bool IsSingleFromSpellSpecificPerTarget(SpellSpecific spellSpec1, SpellSpecific spellSpec2);
        static bool IsSingleFromSpellSpecificRanksPerTarget(SpellSpecific spellId_spec, SpellSpecific i_spellId_spec);

        static bool IsPassiveSpell(uint32 spellId);
        static bool IsPassiveSpell(SpellEntry const* spellProto);
        static bool IsPassiveSpellStackableWithRanks(SpellEntry const* spellProto);

        static bool IsDeathOnlySpell(SpellEntry const *spellInfo);
        static bool IsDeathPersistentSpell(SpellEntry const *spellInfo);

        static bool IsNonCombatSpell(SpellEntry const *spellInfo);

        static bool IsPositiveSpell(uint32 spellId);
        static bool IsPositiveEffect(uint32 spellId, uint32 effIndex);
        static bool IsPositiveTarget(uint32 targetA, uint32 targetB);

        static bool IsSingleTargetSpell(SpellEntry const *spellInfo);
        static bool IsSingleTargetSpells(SpellEntry const *spellInfo1, SpellEntry const *spellInfo2);

        static bool IsAuraAddedBySpell(uint32 auraType, uint32 spellId);

        static bool IsSpellAllowedInLocation(SpellEntry const *spellInfo,uint32 map_id,uint32 zone_id,uint32 area_id);

        static bool IsAreaOfEffectSpell(SpellEntry const *spellInfo);
        static bool IsAreaAuraEffect(uint32 effect);

        static bool IsDispel(SpellEntry const *spellInfo);
        static bool IsDispelSpell(SpellEntry const *spellInfo);
        static uint32 GetDispellMask(DispelType dispel);

        static SpellCastResult GetErrorAtShapeshiftedCast (SpellEntry const *spellInfo, uint32 form);

        static bool IsChanneledSpell(SpellEntry const* spellInfo);

        static bool NeedsComboPoints(SpellEntry const* spellInfo);

        static SpellSchoolMask GetSpellSchoolMask(SpellEntry const* spellInfo);

        static uint32 GetSpellMechanicMask(SpellEntry const* spellInfo, int32 effect);
        static Mechanics GetEffectMechanic(SpellEntry const* spellInfo, int32 effect);

        // Diminishing Returns interaction with spells
        static DiminishingGroup GetDiminishingReturnsGroupForSpell(SpellEntry const* spellproto, bool triggered);
        static bool IsDiminishingReturnsGroupDurationLimited(DiminishingGroup group);
        static DiminishingReturnsType GetDiminishingReturnsGroupType(DiminishingGroup group);

        static bool IsTauntSpell(SpellEntry const* spellInfo);
        static bool IsBinaryResistable(SpellEntry const* spellInfo);
        static bool IsPartialyResistable(SpellEntry const* spellInfo);
        static bool SpellIgnoreLOS(SpellEntry const* spellInfo, uint8 effIdx);
        static bool isSpellBreakStealth(SpellEntry const* spellInfo);

        static bool IsPrimaryProfessionSkill(uint32 skill);
        static bool IsProfessionSkill(uint32 skill);

        static bool EffectCanScaleWithLevel(const SpellEntry* spellInfo, uint8 eff);
        static bool CanSpellCrit(const SpellEntry* spellInfo);

        static SpellEntry const *GetHighestSpellRankForPlayer(uint32, Player*);

        // Modifiers
    public:

        // Loading data at server startup
        void LoadSpellChains();
        void LoadSpellRequired();
        void LoadSpellLearnSkills();
        void LoadSpellLearnSpells();
        void LoadSpellScriptTarget();
        void LoadSpellAffects();
        void LoadSpellElixirs();
        void LoadSpellProcEvents();
        void LoadSpellTargetPositions();
        void LoadSpellThreats();
        void LoadSkillLineAbilityMap();
        void LoadSpellPetAuras();
        void LoadSpellCustomAttr();
        void LoadCustomSpellCooldowns(SpellEntry* spellInfo);
        void LoadSpellLinked();
        void LoadSpellEnchantProcData();
        void LoadSpellBonusData();

    private:
        SpellScriptTarget  mSpellScriptTarget;
        SpellChainMap      mSpellChains;
        SpellsRequiringSpellMap   mSpellsReqSpell;
        SpellRequiredMap   mSpellReq;
        SpellLearnSkillMap mSpellLearnSkills;
        SpellLearnSpellMap mSpellLearnSpells;
        SpellTargetPositionMap mSpellTargetPositions;
        SpellAffectMap     mSpellAffectMap;
        SpellElixirMap     mSpellElixirs;
        SpellProcEventMap  mSpellProcEventMap;
        SkillLineAbilityMap mSkillLineAbilityMap;
        SpellPetAuraMap     mSpellPetAuraMap;
        SpellLinkedMap      mSpellLinkedMap;
        SpellEnchantProcEventMap     mSpellEnchantProcEventMap;
        SpellBonusDataMap    mSpellBonusDataMap;
};

#define sSpellMgr (*ACE_Singleton<SpellMgr, ACE_Null_Mutex >::instance())
#endif
