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
#include "Database/DatabaseEnv.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "Log.h"
#include "UpdateMask.h"
#include "World.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "Player.h"
#include "SkillExtraItems.h"
#include "Unit.h"
#include "Spell.h"
#include "DynamicObject.h"
#include "SpellAuras.h"
#include "Group.h"
#include "UpdateData.h"
#include "MapManager.h"
#include "ObjectAccessor.h"
#include "SharedDefines.h"
#include "Pet.h"
#include "GameObject.h"
#include "GossipDef.h"
#include "Creature.h"
#include "Totem.h"
#include "CreatureAI.h"
#include "BattleGroundMgr.h"
#include "BattleGround.h"
#include "BattleGroundEY.h"
#include "BattleGroundWS.h"
#include "OutdoorPvPMgr.h"
#include "VMapFactory.h"
#include "Language.h"
#include "SocialMgr.h"
#include "Util.h"
#include "TemporarySummon.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "PathFinder.h"

pEffect SpellEffects[TOTAL_SPELL_EFFECTS]=
{
    &Spell::EffectNULL,                                     //  0
    &Spell::EffectInstaKill,                                //  1 SPELL_EFFECT_INSTAKILL
    &Spell::EffectSchoolDMG,                                //  2 SPELL_EFFECT_SCHOOL_DAMAGE
    &Spell::EffectDummy,                                    //  3 SPELL_EFFECT_DUMMY
    &Spell::EffectUnused,                                   //  4 SPELL_EFFECT_PORTAL_TELEPORT          unused
    &Spell::EffectTeleportUnits,                            //  5 SPELL_EFFECT_TELEPORT_UNITS
    &Spell::EffectApplyAura,                                //  6 SPELL_EFFECT_APPLY_AURA
    &Spell::EffectEnvirinmentalDMG,                         //  7 SPELL_EFFECT_ENVIRONMENTAL_DAMAGE
    &Spell::EffectPowerDrain,                               //  8 SPELL_EFFECT_POWER_DRAIN
    &Spell::EffectHealthLeech,                              //  9 SPELL_EFFECT_HEALTH_LEECH
    &Spell::EffectHeal,                                     // 10 SPELL_EFFECT_HEAL
    &Spell::EffectUnused,                                   // 11 SPELL_EFFECT_BIND
    &Spell::EffectNULL,                                     // 12 SPELL_EFFECT_PORTAL
    &Spell::EffectUnused,                                   // 13 SPELL_EFFECT_RITUAL_BASE              unused
    &Spell::EffectUnused,                                   // 14 SPELL_EFFECT_RITUAL_SPECIALIZE        unused
    &Spell::EffectUnused,                                   // 15 SPELL_EFFECT_RITUAL_ACTIVATE_PORTAL   unused
    &Spell::EffectQuestComplete,                            // 16 SPELL_EFFECT_QUEST_COMPLETE
    &Spell::EffectWeaponDmg,                                // 17 SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL
    &Spell::EffectResurrect,                                // 18 SPELL_EFFECT_RESURRECT
    &Spell::EffectAddExtraAttacks,                          // 19 SPELL_EFFECT_ADD_EXTRA_ATTACKS
    &Spell::EffectUnused,                                   // 20 SPELL_EFFECT_DODGE                    one spell: Dodge
    &Spell::EffectUnused,                                   // 21 SPELL_EFFECT_EVADE                    one spell: Evade (DND)
    &Spell::EffectParry,                                    // 22 SPELL_EFFECT_PARRY
    &Spell::EffectBlock,                                    // 23 SPELL_EFFECT_BLOCK                    one spell: Block
    &Spell::EffectCreateItem,                               // 24 SPELL_EFFECT_CREATE_ITEM
    &Spell::EffectUnused,                                   // 25 SPELL_EFFECT_WEAPON
    &Spell::EffectUnused,                                   // 26 SPELL_EFFECT_DEFENSE                  one spell: Defense
    &Spell::EffectPersistentAA,                             // 27 SPELL_EFFECT_PERSISTENT_AREA_AURA
    &Spell::EffectSummonType,                               // 28 SPELL_EFFECT_SUMMON
    &Spell::EffectLeapForward,                              // 29 SPELL_EFFECT_LEAP
    &Spell::EffectEnergize,                                 // 30 SPELL_EFFECT_ENERGIZE
    &Spell::EffectWeaponDmg,                                // 31 SPELL_EFFECT_WEAPON_PERCENT_DAMAGE
    &Spell::EffectTriggerMissileSpell,                      // 32 SPELL_EFFECT_TRIGGER_MISSILE
    &Spell::EffectOpenLock,                                 // 33 SPELL_EFFECT_OPEN_LOCK
    &Spell::EffectSummonChangeItem,                         // 34 SPELL_EFFECT_SUMMON_CHANGE_ITEM
    &Spell::EffectApplyAreaAura,                            // 35 SPELL_EFFECT_APPLY_AREA_AURA_PARTY
    &Spell::EffectLearnSpell,                               // 36 SPELL_EFFECT_LEARN_SPELL
    &Spell::EffectUnused,                                   // 37 SPELL_EFFECT_SPELL_DEFENSE            one spell: SPELLDEFENSE (DND)
    &Spell::EffectDispel,                                   // 38 SPELL_EFFECT_DISPEL
    &Spell::EffectUnused,                                   // 39 SPELL_EFFECT_LANGUAGE
    &Spell::EffectDualWield,                                // 40 SPELL_EFFECT_DUAL_WIELD
    &Spell::EffectSummonWild,                               // 41 SPELL_EFFECT_SUMMON_WILD
    &Spell::EffectSummonGuardian,                           // 42 SPELL_EFFECT_SUMMON_GUARDIAN
    &Spell::EffectTeleUnitsFaceCaster,                      // 43 SPELL_EFFECT_TELEPORT_UNITS_FACE_CASTER
    &Spell::EffectLearnSkill,                               // 44 SPELL_EFFECT_SKILL_STEP
    &Spell::EffectAddHonor,                                 // 45 SPELL_EFFECT_ADD_HONOR                honor/pvp related
    &Spell::EffectNULL,                                     // 46 SPELL_EFFECT_SPAWN                    we must spawn pet there
    &Spell::EffectTradeSkill,                               // 47 SPELL_EFFECT_TRADE_SKILL
    &Spell::EffectUnused,                                   // 48 SPELL_EFFECT_STEALTH                  one spell: Base Stealth
    &Spell::EffectUnused,                                   // 49 SPELL_EFFECT_DETECT                   one spell: Detect
    &Spell::EffectTransmitted,                              // 50 SPELL_EFFECT_TRANS_DOOR
    &Spell::EffectUnused,                                   // 51 SPELL_EFFECT_FORCE_CRITICAL_HIT       unused
    &Spell::EffectUnused,                                   // 52 SPELL_EFFECT_GUARANTEE_HIT            one spell: zzOLDCritical Shot
    &Spell::EffectEnchantItemPerm,                          // 53 SPELL_EFFECT_ENCHANT_ITEM
    &Spell::EffectEnchantItemTmp,                           // 54 SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY
    &Spell::EffectTameCreature,                             // 55 SPELL_EFFECT_TAMECREATURE
    &Spell::EffectSummonPet,                                // 56 SPELL_EFFECT_SUMMON_PET
    &Spell::EffectLearnPetSpell,                            // 57 SPELL_EFFECT_LEARN_PET_SPELL
    &Spell::EffectWeaponDmg,                                // 58 SPELL_EFFECT_WEAPON_DAMAGE
    &Spell::EffectOpenSecretSafe,                           // 59 SPELL_EFFECT_OPEN_LOCK_ITEM
    &Spell::EffectProficiency,                              // 60 SPELL_EFFECT_PROFICIENCY
    &Spell::EffectSendEvent,                                // 61 SPELL_EFFECT_SEND_EVENT
    &Spell::EffectPowerBurn,                                // 62 SPELL_EFFECT_POWER_BURN
    &Spell::EffectThreat,                                   // 63 SPELL_EFFECT_THREAT
    &Spell::EffectTriggerSpell,                             // 64 SPELL_EFFECT_TRIGGER_SPELL
    &Spell::EffectUnused,                                   // 65 SPELL_EFFECT_HEALTH_FUNNEL            unused
    &Spell::EffectUnused,                                   // 66 SPELL_EFFECT_POWER_FUNNEL             unused
    &Spell::EffectHealMaxHealth,                            // 67 SPELL_EFFECT_HEAL_MAX_HEALTH
    &Spell::EffectInterruptCast,                            // 68 SPELL_EFFECT_INTERRUPT_CAST
    &Spell::EffectDistract,                                 // 69 SPELL_EFFECT_DISTRACT
    &Spell::EffectPull,                                     // 70 SPELL_EFFECT_PULL                     one spell: Distract Move
    &Spell::EffectPickPocket,                               // 71 SPELL_EFFECT_PICKPOCKET
    &Spell::EffectAddFarsight,                              // 72 SPELL_EFFECT_ADD_FARSIGHT
    &Spell::EffectSummonPossessed,                          // 73 SPELL_EFFECT_SUMMON_POSSESSED
    &Spell::EffectSummonTotem,                              // 74 SPELL_EFFECT_SUMMON_TOTEM
    &Spell::EffectHealMechanical,                           // 75 SPELL_EFFECT_HEAL_MECHANICAL          one spell: Mechanical Patch Kit
    &Spell::EffectSummonObjectWild,                         // 76 SPELL_EFFECT_SUMMON_OBJECT_WILD
    &Spell::EffectScriptEffect,                             // 77 SPELL_EFFECT_SCRIPT_EFFECT
    &Spell::EffectUnused,                                   // 78 SPELL_EFFECT_ATTACK
    &Spell::EffectSanctuary,                                // 79 SPELL_EFFECT_SANCTUARY
    &Spell::EffectAddComboPoints,                           // 80 SPELL_EFFECT_ADD_COMBO_POINTS
    &Spell::EffectUnused,                                   // 81 SPELL_EFFECT_CREATE_HOUSE             one spell: Create House (TEST)
    &Spell::EffectNULL,                                     // 82 SPELL_EFFECT_BIND_SIGHT
    &Spell::EffectDuel,                                     // 83 SPELL_EFFECT_DUEL
    &Spell::EffectStuck,                                    // 84 SPELL_EFFECT_STUCK
    &Spell::EffectSummonPlayer,                             // 85 SPELL_EFFECT_SUMMON_PLAYER
    &Spell::EffectActivateObject,                           // 86 SPELL_EFFECT_ACTIVATE_OBJECT
    &Spell::EffectSummonTotem,                              // 87 SPELL_EFFECT_SUMMON_TOTEM_SLOT1
    &Spell::EffectSummonTotem,                              // 88 SPELL_EFFECT_SUMMON_TOTEM_SLOT2
    &Spell::EffectSummonTotem,                              // 89 SPELL_EFFECT_SUMMON_TOTEM_SLOT3
    &Spell::EffectSummonTotem,                              // 90 SPELL_EFFECT_SUMMON_TOTEM_SLOT4
    &Spell::EffectUnused,                                   // 91 SPELL_EFFECT_THREAT_ALL               one spell: zzOLDBrainwash
    &Spell::EffectEnchantHeldItem,                          // 92 SPELL_EFFECT_ENCHANT_HELD_ITEM
    &Spell::EffectUnused,                                   // 93 SPELL_EFFECT_SUMMON_PHANTASM
    &Spell::EffectSelfResurrect,                            // 94 SPELL_EFFECT_SELF_RESURRECT
    &Spell::EffectSkinning,                                 // 95 SPELL_EFFECT_SKINNING
    &Spell::EffectUnused,                                   // 96 SPELL_EFFECT_CHARGE
    &Spell::EffectSummonCritter,                            // 97 SPELL_EFFECT_SUMMON_CRITTER
    &Spell::EffectKnockBack,                                // 98 SPELL_EFFECT_KNOCK_BACK
    &Spell::EffectDisEnchant,                               // 99 SPELL_EFFECT_DISENCHANT
    &Spell::EffectInebriate,                                //100 SPELL_EFFECT_INEBRIATE
    &Spell::EffectFeedPet,                                  //101 SPELL_EFFECT_FEED_PET
    &Spell::EffectDismissPet,                               //102 SPELL_EFFECT_DISMISS_PET
    &Spell::EffectReputation,                               //103 SPELL_EFFECT_REPUTATION
    &Spell::EffectSummonObject,                             //104 SPELL_EFFECT_SUMMON_OBJECT_SLOT1
    &Spell::EffectSummonObject,                             //105 SPELL_EFFECT_SUMMON_OBJECT_SLOT2
    &Spell::EffectSummonObject,                             //106 SPELL_EFFECT_SUMMON_OBJECT_SLOT3
    &Spell::EffectSummonObject,                             //107 SPELL_EFFECT_SUMMON_OBJECT_SLOT4
    &Spell::EffectDispelMechanic,                           //108 SPELL_EFFECT_DISPEL_MECHANIC
    &Spell::EffectSummonDeadPet,                            //109 SPELL_EFFECT_SUMMON_DEAD_PET
    &Spell::EffectDestroyAllTotems,                         //110 SPELL_EFFECT_DESTROY_ALL_TOTEMS
    &Spell::EffectDurabilityDamage,                         //111 SPELL_EFFECT_DURABILITY_DAMAGE
    &Spell::EffectSummonDemon,                              //112 SPELL_EFFECT_SUMMON_DEMON
    &Spell::EffectResurrectNew,                             //113 SPELL_EFFECT_RESURRECT_NEW
    &Spell::EffectTaunt,                                    //114 SPELL_EFFECT_ATTACK_ME
    &Spell::EffectDurabilityDamagePCT,                      //115 SPELL_EFFECT_DURABILITY_DAMAGE_PCT
    &Spell::EffectSkinPlayerCorpse,                         //116 SPELL_EFFECT_SKIN_PLAYER_CORPSE       one spell: Remove Insignia, bg usage, required special corpse flags...
    &Spell::EffectSpiritHeal,                               //117 SPELL_EFFECT_SPIRIT_HEAL              one spell: Spirit Heal
    &Spell::EffectSkill,                                    //118 SPELL_EFFECT_SKILL                    professions and more
    &Spell::EffectApplyAreaAura,                            //119 SPELL_EFFECT_APPLY_AREA_AURA_PET
    &Spell::EffectUnused,                                   //120 SPELL_EFFECT_TELEPORT_GRAVEYARD       one spell: Graveyard Teleport Test
    &Spell::EffectWeaponDmg,                                //121 SPELL_EFFECT_NORMALIZED_WEAPON_DMG
    &Spell::EffectUnused,                                   //122 SPELL_EFFECT_122                      unused
    &Spell::EffectSendTaxi,                                 //123 SPELL_EFFECT_SEND_TAXI                taxi/flight related (misc value is taxi path id)
    &Spell::EffectPlayerPull,                               //124 SPELL_EFFECT_PLAYER_PULL              opposite of knockback effect (pulls player twoard caster)
    &Spell::EffectModifyThreatPercent,                      //125 SPELL_EFFECT_MODIFY_THREAT_PERCENT
    &Spell::EffectStealBeneficialBuff,                      //126 SPELL_EFFECT_STEAL_BENEFICIAL_BUFF    spell steal effect?
    &Spell::EffectProspecting,                              //127 SPELL_EFFECT_PROSPECTING              Prospecting spell
    &Spell::EffectApplyAreaAura,                            //128 SPELL_EFFECT_APPLY_AREA_AURA_FRIEND
    &Spell::EffectApplyAreaAura,                            //129 SPELL_EFFECT_APPLY_AREA_AURA_ENEMY
    &Spell::EffectRedirectThreat,                           //130 SPELL_EFFECT_REDIRECT_THREAT
    &Spell::EffectUnused,                                   //131 SPELL_EFFECT_131                      used in some test spells
    &Spell::EffectPlayMusic,                                //132 SPELL_EFFECT_PLAY_MUSIC               sound id in misc value
    &Spell::EffectUnlearnSpecialization,                    //133 SPELL_EFFECT_UNLEARN_SPECIALIZATION   unlearn profession specialization
    &Spell::EffectKillCredit,                               //134 SPELL_EFFECT_KILL_CREDIT              misc value is creature entry
    &Spell::EffectNULL,                                     //135 SPELL_EFFECT_CALL_PET
    &Spell::EffectHealPct,                                  //136 SPELL_EFFECT_HEAL_PCT
    &Spell::EffectEnergisePct,                              //137 SPELL_EFFECT_ENERGIZE_PCT
    &Spell::EffectLeapBack,                                 //138 SPELL_EFFECT_LEAP_BACK                Leap Back
    &Spell::EffectUnused,                                   //139 SPELL_EFFECT_139                      unused
    &Spell::EffectForceCast,                                //140 SPELL_EFFECT_FORCE_CAST
    &Spell::EffectNULL,                                     //141 SPELL_EFFECT_141                      Only one spell, using SPELL_EFFECT_SCHOOL_DAMAGE, and there triggering spell
    &Spell::EffectTriggerSpellWithValue,                    //142 SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE
    &Spell::EffectApplyAreaAura,                            //143 SPELL_EFFECT_APPLY_AREA_AURA_OWNER
    &Spell::EffectKnockBack,                                //144 SPELL_EFFECT_KNOCK_BACK_2             Spectral Blast
    &Spell::EffectSuspendGravity,                           //145 SPELL_EFFECT_SUSPEND_GRAVITY          Black Hole Effect
    &Spell::EffectUnused,                                   //146 SPELL_EFFECT_146                      unused
    &Spell::EffectQuestFail,                                //147 SPELL_EFFECT_QUEST_FAIL               quest fail
    &Spell::EffectUnused,                                   //148 SPELL_EFFECT_148                      unused
    &Spell::EffectCharge2,                                  //149 SPELL_EFFECT_CHARGE2                  swoop
    &Spell::EffectUnused,                                   //150 SPELL_EFFECT_150                      unused
    &Spell::EffectTriggerRitualOfSummoning,                 //151 SPELL_EFFECT_TRIGGER_SPELL_2
    &Spell::EffectNULL,                                     //152 SPELL_EFFECT_152                      summon Refer-a-Friend
    &Spell::EffectNULL,                                     //153 SPELL_EFFECT_CREATE_PET               misc value is creature entry
};

void Spell::EffectNULL(uint32 /*i*/)
{
    sLog.outDebug("WORLD: Spell Effect DUMMY");
}

void Spell::EffectUnused(uint32 /*i*/)
{
    // NOT USED BY ANY SPELL OR USELESS OR IMPLEMENTED IN DIFFERENT WAY IN MANGOS
}

void Spell::EffectResurrectNew(uint32 i)
{
    if (!unitTarget || !unitTarget->IsInWorld() || unitTarget->isAlive())
        return;

    if (Player* pTarget = unitTarget->ToPlayer())
    {
        if (pTarget->isRessurectRequested())       // already have one active request
            return;

        uint32 health = damage;
        uint32 mana = GetSpellInfo()->EffectMiscValue[i];
        pTarget->setResurrectRequestData(m_caster->GetGUID(), m_caster->GetMapId(), m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ(), health, mana);
        SendResurrectRequest(pTarget);
    }
    else if (Pet* pet = unitTarget->ToPet())
    {
        if (pet->getPetType() != HUNTER_PET || pet->isAlive())
            return;

        float x, y, z;
        m_caster->GetPosition(x, y, z);
        pet->NearTeleportTo(x, y, z, m_caster->GetOrientation());

        pet->SetUInt32Value(UNIT_DYNAMIC_FLAGS, 0);
        pet->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);
        pet->setDeathState(ALIVE);
        pet->clearUnitState(UNIT_STAT_ALL_STATE);
        pet->SetHealth(uint32(damage));

        pet->SavePetToDB(PET_SAVE_AS_CURRENT);
    }
}

void Spell::EffectInstaKill(uint32 /*i*/)
{
    if (!unitTarget || !unitTarget->isAlive())
        return;

    // Demonic Sacrifice
    if (GetSpellInfo()->Id==18788 && unitTarget->GetTypeId()==TYPEID_UNIT)
    {
        uint32 entry = unitTarget->GetEntry();
        uint32 spellID;
        switch (entry)
        {
            case   416: spellID=18789; break;               //imp
            case   417: spellID=18792; break;               //fellhunter
            case  1860: spellID=18790; break;               //void
            case  1863: spellID=18791; break;               //succubus
            case 17252: spellID=35701; break;               //fellguard
            default:
                sLog.outLog(LOG_DEFAULT, "ERROR: EffectInstaKill: Unhandled creature entry (%u) case.",entry);
                return;
        }

        m_caster->CastSpell(m_caster,spellID,true);
    }

    if (m_caster==unitTarget)                                // prevent interrupt message
        finish();

    uint32 health = unitTarget->GetHealth();
    m_caster->DealDamage(unitTarget, health, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
}

void Spell::EffectEnvirinmentalDMG(uint32 i)
{
    uint32 absorb = 0;
    uint32 resist = 0;

    // Note: this hack with damage replace required until GO casting not implemented
    // environment damage spells already have around enemies targeting but this not help in case not existed GO casting support
    // currently each enemy selected explicitly and self cast damage, we prevent apply self casted spell bonuses/etc
    damage = GetSpellInfo()->CalculateSimpleValue(i);

    m_caster->CalcAbsorbResist(m_caster,SpellMgr::GetSpellSchoolMask(GetSpellInfo()), SPELL_DIRECT_DAMAGE, damage, &absorb, &resist);

    m_caster->SendSpellNonMeleeDamageLog(m_caster, GetSpellInfo()->Id, damage, SpellMgr::GetSpellSchoolMask(GetSpellInfo()), absorb, resist, false, 0, false);
    if (m_caster->GetTypeId() == TYPEID_PLAYER)
        ((Player*)m_caster)->EnvironmentalDamage(DAMAGE_FIRE,damage);
}

void Spell::EffectSchoolDMG(uint32 effect_idx)
{
}

void Spell::SpellDamageSchoolDmg(uint32 effect_idx)
{
    // what the fuck is done here? o.O
    SpellEntry const* spellInfo = sSpellStore.LookupEntry(GetSpellInfo()->Id);
    if (!spellInfo)
        return;

    if (unitTarget && unitTarget->isAlive())
    {
        float totalDmgModPct = 1.0f;
        float attackPowerCoefficient = 0.0f;
        float rangedAttackPowerCoefficient = 0.0f;
        switch (spellInfo->SpellFamilyName)
        {
            case SPELLFAMILY_GENERIC:
            {
                //Gore
                if (spellInfo->SpellIconID == 2269)
                {
                     damage += (rand32()%2 ? damage : 0);
                }

                if (spellInfo->Id == 37841)
                {
                    if (unitTarget->GetTypeId() == TYPEID_PLAYER)
                    {
                        if (unitTarget->HasAura(37830, 0))
                        {
                            damage += 500;
                            ((Player*)unitTarget)->KilledMonster(21910, 0);
                        }
                    }
                }

                // Self-damage
                if (spellInfo->Id == 44998)
                {
                    if (100*unitTarget->GetHealth()/unitTarget->GetMaxHealth() <= 50)
                    {
                        damage = 0;
                        unitTarget->RemoveAurasDueToSpell(44986);   //triggering self damage
                        unitTarget->CastSpell(unitTarget, 44994, true);   // cast self-repair
                    }
                    else
                        damage = 350;
                }

                // Meteor like spells (divided damage to targets)
                if (spellInfo->AttributesCu & SPELL_ATTR_CU_SHARE_DAMAGE)
                {
                    uint32 count = 0;
                    for (std::list<TargetInfo>::iterator ihit= m_UniqueTargetInfo.begin();ihit != m_UniqueTargetInfo.end();++ihit)
                    {
                        if (ihit->deleted)
                            continue;

                        if (ihit->effectMask & (1<<effect_idx))
                            ++count;
                    }

                    damage /= count;                    // divide to all targets
                }

                switch (spellInfo->Id)                     // better way to check unknown
                {
                    // Priestess of Torment - whirlwind dmg should also mana burn
                    case 46271:
                    {
                        if (unitTarget && unitTarget->GetTypeId() == TYPEID_PLAYER)
                            m_caster->CastSpell(unitTarget, 46266, true);
                        break;
                    }
                    case 35354: //Hand of Death
                    {
                        if (unitTarget && unitTarget->HasAura(38528,0)) //Protection of Elune
                        {
                            damage = 0;
                        }
                        break;
                    }
                    // percent from health with min
                    case 25599:                             // Thundercrash
                    {
                        damage = unitTarget->GetHealth() / 2;
                        if (damage < 200)
                            damage = 200;
                        break;
                    }
                    // arcane charge. must only affect demons (also undead?)
                    case 45072:
                    {
                        if (unitTarget->GetCreatureType() != CREATURE_TYPE_DEMON
                            && unitTarget->GetCreatureType() != CREATURE_TYPE_UNDEAD)
                            return;
                        break;
                    }
                    // gruul's shatter
                    case 33671:
                    {
                        // don't damage self and only players
                        if (unitTarget->GetGUID() == m_caster->GetGUID() || unitTarget->GetTypeId() != TYPEID_PLAYER)
                            return;

                        float radius = SpellMgr::GetSpellRadius(spellInfo,0,false);
                        if (!radius) return;
                        float distance = m_caster->GetDistance2d(unitTarget);
                        damage = (distance > radius) ? 0 : (int32)(spellInfo->EffectBasePoints[0]*((radius - distance)/radius));
                        // Set the damage directly without spell bonus damage
                        m_damage += damage;
                        damage = 0;
                        break;
                    }
                    // Cataclysmic Bolt
                    case 38441:
                        damage = unitTarget->GetMaxHealth() / 2;
                        break;
                    //sonic boom
                    case 33666:
                    case 38795:
                        damage = unitTarget->GetHealth()*90/100;
                        break;
                }
                break;
            }

            case SPELLFAMILY_MAGE:
            {
                // Arcane Blast
                if (spellInfo->SpellFamilyFlags & 0x20000000LL)
                {
                    m_caster->CastSpell(m_caster,36032,true);
                }
                break;
            }
            case SPELLFAMILY_WARRIOR:
            {
                // Bloodthirst
                if (spellInfo->SpellFamilyFlags & 0x40000000000LL)
                {
                    attackPowerCoefficient += float(damage) *0.01f; // Base damage shows us percentage of AP that need be added
                    damage = 0; // clear this, we have now how much AP should be taken
                }
                // Shield Slam
                else if (spellInfo->SpellFamilyFlags & 0x100000000LL)
                    damage += int32(m_caster->GetShieldBlockValue());
                // Victory Rush
                else if (spellInfo->SpellFamilyFlags & 0x10000000000LL)
                {
                    attackPowerCoefficient += float(damage) *0.01f; // Base damage shows us percentage of AP that need be added
                    damage = 0; // clear this, we have now how much AP should be taken
                    m_caster->ModifyAuraState(AURA_STATE_WARRIOR_VICTORY_RUSH, false);
                }
                break;
            }
            case SPELLFAMILY_WARLOCK:
            {
                // Incinerate Rank 1 & 2
                if ((spellInfo->SpellFamilyFlags & 0x00004000000000LL) && spellInfo->SpellIconID==2128)
                {
                    // Incinerate does more dmg (dmg*0.25) if the target is Immolated.
                    if (unitTarget->HasAuraState(AURA_STATE_IMMOLATE))
                        damage += int32(damage*0.25);
                    // T5 bonus - increase immolate damage on incinerate hit
                    if (m_caster->HasAura(37384, 0))
                    {
                        // look for immolate casted by m_caster
                        Unit::AuraList const &mPeriodic = unitTarget->GetAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
                        for (Unit::AuraList::const_iterator i = mPeriodic.begin(); i != mPeriodic.end(); ++i)
                        {
                            if ((*i)->GetSpellProto()->SpellFamilyName == SPELLFAMILY_WARLOCK && ((*i)->GetSpellProto()->SpellFamilyFlags & 4) &&
                                (*i)->GetCasterGUID()==m_caster->GetGUID())
                            {
                                // store number of incinerate hits in m_miscvalue
                                (*i)->GetModifier()->m_miscvalue++;
                                break;
                            }
                        }
                    }
                }
                // Incinerate, Sunwell Warlock in MgT
                if (spellInfo->Id == 44519 || spellInfo->Id == 46043)
                {
                    // Incinerate does more dmg (dmg*0.25) if the target is Immolated.
                    if (unitTarget->HasAura(44518, 0) || unitTarget->HasAura(46042, 0))
                        damage += int32(damage*0.25);
                }
                // Shadow bolt
                if (spellInfo->SpellFamilyFlags & 1)
                {
                    // T5 bonus - increase corruption on shadow bolt hit
                    if (m_caster->HasAura(37384, 0))
                    {
                        // look for corruption casted by m_caster
                        Unit::AuraList const &mPeriodic = unitTarget->GetAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
                        for (Unit::AuraList::const_iterator i = mPeriodic.begin(); i != mPeriodic.end(); ++i)
                        {
                            if ((*i)->GetSpellProto()->SpellFamilyName == SPELLFAMILY_WARLOCK && ((*i)->GetSpellProto()->SpellFamilyFlags & 2) &&
                                (*i)->GetCasterGUID()==m_caster->GetGUID())
                            {
                                // store number of shadow bolt hits in m_miscvalue
                                (*i)->GetModifier()->m_miscvalue++;
                                break;
                            }
                        }
                    }
                }
                // Conflagrate - consumes immolate
                if (spellInfo->TargetAuraState == AURA_STATE_IMMOLATE)
                {
                    // for caster applied auras only
                    Unit::AuraList const &mPeriodic = unitTarget->GetAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
                    for (Unit::AuraList::const_iterator i = mPeriodic.begin(); i != mPeriodic.end(); ++i)
                    {
                        if ((*i)->GetSpellProto()->SpellFamilyName == SPELLFAMILY_WARLOCK && ((*i)->GetSpellProto()->SpellFamilyFlags & 4) &&
                            (*i)->GetCasterGUID()==m_caster->GetGUID())
                        {
                            unitTarget->RemoveAurasByCasterSpell((*i)->GetId(), m_caster->GetGUID());
                            break;
                        }
                    }
                }
                break;
            }
            case SPELLFAMILY_DRUID:
            {
                // Ferocious Bite
                if ((spellInfo->SpellFamilyFlags & 0x000800000) && spellInfo->SpellVisual==6587)
                {
                    // converts each extra point of energy into ($f1+$AP/630) additional damage
                    int extraEnergy = (m_caster->GetPower(POWER_ENERGY) - GetPowerCost());
                    damage += int32(extraEnergy * spellInfo->DmgMultiplier[effect_idx]);
                    m_caster->SetPower(POWER_ENERGY, GetPowerCost());
                    attackPowerCoefficient += extraEnergy / 630.0f + 0.1526f;
                }
                // Rake
                else if (spellInfo->SpellFamilyFlags & 0x0000000000001000LL && spellInfo->SpellIconID == 494)
                {
                    attackPowerCoefficient += 0.01f;
                }
                // Swipe
                else if (spellInfo->SpellFamilyFlags & 0x0010000000000000LL)
                {
                    attackPowerCoefficient += 0.08f;
                }
                // Starfire
                else if (spellInfo->SpellFamilyFlags & 0x0004LL)
                {
                    Unit::AuraList const& m_OverrideClassScript = m_caster->GetAurasByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
                    for (Unit::AuraList::const_iterator i = m_OverrideClassScript.begin(); i != m_OverrideClassScript.end(); ++i)
                    {
                        // Starfire Bonus (caster)
                        switch ((*i)->GetModifier()->m_miscvalue)
                        {
                            case 5481:                      // Nordrassil Regalia - bonus
                            {
                                Unit::AuraList const& m_periodicDamageAuras = unitTarget->GetAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
                                for (Unit::AuraList::const_iterator itr = m_periodicDamageAuras.begin(); itr != m_periodicDamageAuras.end(); ++itr)
                                {
                                    // Moonfire or Insect Swarm (target debuff from any casters)
                                    if ((*itr)->GetSpellProto()->SpellFamilyFlags & 0x00200002LL)
                                    {
                                        totalDmgModPct *= 1 + ((*i)->GetModifierValue() / 100.0f);
                                        break;
                                    }
                                }
                                break;
                            }
                            case 5148:                      //Improved Starfire - Ivory Idol of the Moongoddes Aura
                            {
                                damage += (*i)->GetModifier()->m_amount;
                                break;
                            }
                        }
                    }
                }
                //Mangle Bonus for the initial damage of Lacerate and Rake
                if ((spellInfo->SpellFamilyFlags==0x0000000000001000LL && spellInfo->SpellIconID==494) ||
                    (spellInfo->SpellFamilyFlags==0x0000010000000000LL && spellInfo->SpellIconID==2246))
                {
                    Unit::AuraList const& mDummyAuras = unitTarget->GetAurasByType(SPELL_AURA_DUMMY);
                    for (Unit::AuraList::const_iterator i = mDummyAuras.begin(); i != mDummyAuras.end(); ++i)
                        if ((*i)->GetSpellProto()->SpellFamilyFlags & 0x0000044000000000LL && (*i)->GetSpellProto()->SpellFamilyName==SPELLFAMILY_DRUID)
                        {
                            totalDmgModPct *= 1 + (*i)->GetModifierValue() / 100.0f;
                            break;
                        }
                }
                // L5 Arcane Charge (its weird that it is claimed to be DRUID spell :D)
                if (spellInfo->Id == 41360)
                    damage = unitTarget->GetMaxHealth();
                break;
            }
            case SPELLFAMILY_ROGUE:
            {
                // Envenom
                if (m_caster->GetTypeId()==TYPEID_PLAYER && (spellInfo->SpellFamilyFlags & 0x800000000LL))
                {
                    // consume from stack dozes not more that have combo-points
                    if (uint32 combo = ((Player*)m_caster)->GetComboPoints())
                    {
                        // count consumed deadly poison doses at target
                        uint32 doses = 0;

                        // remove consumed poison doses
                        Unit::AuraList const& auras = unitTarget->GetAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
                        for (Unit::AuraList::const_iterator itr = auras.begin(); itr!=auras.end() && combo;)
                        {
                            // Deadly poison (only attacker applied)
                            if ((*itr)->GetSpellProto()->SpellFamilyName==SPELLFAMILY_ROGUE && ((*itr)->GetSpellProto()->SpellFamilyFlags & 0x10000) &&
                                (*itr)->GetSpellProto()->SpellVisual==5100 && (*itr)->GetCasterGUID()==m_caster->GetGUID())
                            {
                                --combo;
                                ++doses;

                                unitTarget->RemoveSingleAuraFromStackByCaster((*itr)->GetId(), (*itr)->GetEffIndex(), m_caster->GetGUID());

                                itr = auras.begin();
                            }
                            else
                                ++itr;
                        }

                        damage *= doses;
                        attackPowerCoefficient += 0.03f * doses;

                        // Eviscerate and Envenom Bonus Damage (item set effect)
                        if (m_caster->GetDummyAura(37169))
                            damage += ((Player*)m_caster)->GetComboPoints()*40;
                    }
                }
                // Eviscerate
                else if ((spellInfo->SpellFamilyFlags & 0x00020000LL) && m_caster->GetTypeId()==TYPEID_PLAYER)
                {
                    if (uint32 combo = ((Player*)m_caster)->GetComboPoints())
                    {
                        attackPowerCoefficient += combo * 0.03f;

                        // Eviscerate and Envenom Bonus Damage (item set effect)
                        if (m_caster->GetDummyAura(37169))
                            damage += combo*40;
                    }
                }
                break;
            }
            case SPELLFAMILY_HUNTER:
            {
                // Mongoose Bite
                if ((spellInfo->SpellFamilyFlags & 0x000000002) && spellInfo->SpellVisual==342)
                {
                    attackPowerCoefficient += 0.2f;
                }
                // Arcane Shot
                else if ((spellInfo->SpellFamilyFlags & 0x00000800) && spellInfo->maxLevel > 0)
                {
                    rangedAttackPowerCoefficient += 0.15f;
                }
                // Steady Shot
                else if (spellInfo->SpellFamilyFlags & 0x100000000LL)
                {
                    int32 base = irand((int32)m_caster->GetWeaponDamageRange(RANGED_ATTACK, MINDAMAGE),(int32)m_caster->GetWeaponDamageRange(RANGED_ATTACK, MAXDAMAGE));
                    damage += int32(float(base)/m_caster->GetAttackTime(RANGED_ATTACK)*2800);
                    rangedAttackPowerCoefficient += 0.2f;

                    bool found = false;

                    // check dazed affect
                    Unit::AuraList const& decSpeedList = unitTarget->GetAurasByType(SPELL_AURA_MOD_DECREASE_SPEED);
                    for (Unit::AuraList::const_iterator iter = decSpeedList.begin(); iter != decSpeedList.end(); ++iter)
                    {
                        if ((*iter)->GetSpellProto()->SpellIconID==15 && (*iter)->GetSpellProto()->Dispel==0)
                        {
                            found = true;
                            break;
                        }
                    }

                    //TODO: should this be put on taken but not done?
                    if (found)
                        damage += spellInfo->EffectBasePoints[1];
                }
                //Explosive Trap Effect
                else if (spellInfo->SpellFamilyFlags & 0x00000004)
                {
                    rangedAttackPowerCoefficient += 0.1f;
                }
                break;
            }
            case SPELLFAMILY_PALADIN:
            {
                //Judgement of Vengeance
                if ((spellInfo->SpellFamilyFlags & 0x800000000LL) && spellInfo->SpellIconID==2292 && spellInfo->Id != 42463)
                {
                    uint32 stacks = 0;
                    Unit::AuraList const& auras = unitTarget->GetAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
                    for (Unit::AuraList::const_iterator itr = auras.begin(); itr!=auras.end(); ++itr)
                        if ((*itr)->GetId() == 31803 && (*itr)->GetCasterGUID()==m_caster->GetGUID())
                        {
                            stacks = (*itr)->GetStackAmount();
                            break;
                        }

                    if (!stacks)
                        //No damage if the target isn't affected by this
                        damage = -1;
                    else
                        damage *= stacks;
                }
                break;
            }
            case SPELLFAMILY_SHAMAN:
            {
                // Lightning Bolt & Chain Lightning
                if (spellInfo->SpellFamilyFlags & 0x0003LL)
                {
                    bool stop = false;
                    Unit::AuraList const& auras = m_caster->GetAurasByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
                    for (Unit::AuraList::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
                    {
                        switch ((*itr)->GetId())
                        {
                            case 28857:
                            case 34230:
                            case 41040:
                                damage += (*itr)->GetModifierValue();
                                stop = true;
                                break;
                        }

                        if (stop)
                            break;
                    }
                }
                break;
            }
        }

        if (attackPowerCoefficient)
        {
            float attackPower = m_caster->GetTotalAttackPowerValue(BASE_ATTACK) + unitTarget->GetMeleeApAttackerBonus();
            attackPower += m_caster->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_MELEE_ATTACK_POWER_VERSUS, unitTarget->GetCreatureTypeMask());

            damage += attackPowerCoefficient * attackPower;
        }

        if (rangedAttackPowerCoefficient)
        {
            float attackPower = m_caster->GetTotalAttackPowerValue(RANGED_ATTACK) + unitTarget->GetTotalAuraModifier(SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS);
            attackPower += m_caster->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_RANGED_ATTACK_POWER_VERSUS, unitTarget->GetCreatureTypeMask());

            damage += rangedAttackPowerCoefficient * attackPower;
        }

        if (m_originalCaster && damage > 0)
            damage = m_originalCaster->SpellDamageBonus(unitTarget, spellInfo, (uint32)damage, SPELL_DIRECT_DAMAGE);

        damage *= totalDmgModPct;

        m_damage += damage;
    }
}

void Spell::EffectDummy(uint32 i)
{
    if (!unitTarget && !gameObjTarget && !itemTarget)
        return;

    uint32 spell_id = 0;
    int32 bp = 0;

    // selection by spell family
    switch (GetSpellInfo()->SpellFamilyName)
    {
        case SPELLFAMILY_GENERIC:
        {
            switch (GetSpellInfo()->Id)
            {
                case 17950:                                 // Shadow Portal
                {
                    if (!unitTarget)
                        return;
                    // Shadow Portal
                    const uint32 spell_list[6] = {17863, 17939, 17943, 17944, 17946, 17948};

                    m_caster->CastSpell(unitTarget, spell_list[urand(0, 5)], true);
                    return;
                }
                case 32785:                                 // Infernal Rain
                {
                    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_UNIT /*|| unitTarget->GetEntry() != 19215*/)
                        return;

                    // Summon Infernal Siegebreaker
                    m_caster->SummonCreature(18946, unitTarget->GetPositionX(), unitTarget->GetPositionY(), unitTarget->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                    return;
                }
                case 46292:                                 // Cataclysm Breath
                {
                    // Cataclysm Spells
                    const uint32 spell_list[8] =
                    {
                        46293,  // Corrosive Poison
                        46294,  // Fevered Fatigue
                        46295,  // Hex
                        46296,  // Necrotic Poison
                        46297,  // Piercing Shadow
                        46298,  // Shrink
                        46299,  // Wavering Will
                        46300   // Withered Touch
                    };

                    std::vector<uint32> debuff_list;
                    for (uint8 i = 0; i < 8; ++i)
                        debuff_list.push_back(spell_list[i]);
                    std::random_shuffle(debuff_list.begin(), debuff_list.end());
                    debuff_list.resize(urand(5, 6));
                    for (std::vector<uint32>::iterator itr = debuff_list.begin(); itr != debuff_list.end(); itr++)
                        m_caster->CastSpell((Unit*)NULL, *itr, true);
                    return;
                }
                case 46476:                                 // Sunblade Protector Activated
                {
                    if(!m_originalCaster)
                        return;

                    if(unitTarget->GetTypeId() == TYPEID_UNIT && m_originalCaster->getVictim())
                    {
                        ((Creature*)unitTarget)->AI()->AttackStart(m_originalCaster->getVictim());
                        m_originalCaster->GetMotionMaster()->MoveChase(m_originalCaster->getVictim(), 0, 0);
                    }
                    return;
                }
                case 38782:
                {
                    if (i == 0)
                    {
                        float x,y,z;
                        m_caster->GetNearPoint(x,y,z, 0.0f, 10.0f, 0.0f);
                        if (Creature *pDruid = m_caster->SummonCreature(22423, x,y,z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 40000))
                        {
                            pDruid->CastSpell(pDruid, 39158, true);
                            //pDruid->UpdateEntry(22425);
                        }
                    }
                    break;
                }
                case 32146:
                {
                    if (unitTarget->GetTypeId() == TYPEID_UNIT)
                        ((Creature*)unitTarget)->DisappearAndDie();

                    break;
                }
                case 41082:
                {
                    unitTarget->CastSpell(unitTarget, 41083, true, 0, 0, m_caster->GetGUID());
                    m_caster->CastSpell(unitTarget, 39123, true);

                    float x, y, z;
                    unitTarget->GetNearPoint(x,y,z, 0.0f, 0.0f, unitTarget->GetAngle(m_caster));

                    m_caster->GetMotionMaster()->MovePoint(0, x, y, z);
                    break;
                }
                case 37573:
                {
                    if (unitTarget->GetTypeId() == TYPEID_UNIT)
                    {
                        uint32 entry = 0;
                        switch(urand(0,2))
                        {
                            case 0: entry = 21817; break;
                            case 1: entry = 21820; break;
                            case 2: entry = 21821; break;
                        }
                        ((Creature*)unitTarget)->UpdateEntry(entry);
                    }
                    break;
                }
                // Illidan Stormrage: Throw Glaive (Summon Glaive after throw;p
                case 39849:
                {
                    unitTarget->CastSpell(unitTarget, 41466, true);
                    if (unitTarget->GetTypeId() == TYPEID_UNIT)
                    {
                        ((Creature*)unitTarget)->Kill(unitTarget, false);
                        ((Creature*)unitTarget)->RemoveCorpse();
                    }
                    return;
                }
                // Illidan Stormrage: Return Glaive
                case 39873:
                {
                    if (unitTarget->GetTypeId() == TYPEID_PLAYER)
                        return;

                    m_caster->CastSpell(unitTarget, 39635, true);
                }
                case 38002:
                {
                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    m_caster->CastSpell((Unit*)NULL, 38003, false);
                }

                // Fatal Attraction
                case 40869:
                {
                    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
                        return;

                    m_caster->CastSpell(unitTarget, 41001, true);
                }
                break;
                // Tag Subbued Talbuk (for Quest Creatures of the Eco-Domes - 10427)
                case 35771:
                {
                    if (((Player*)m_caster)->GetQuestStatus(10427) == QUEST_STATUS_INCOMPLETE)
                    {
                        // Get Sleep Visual (34664)
                        SpellEntry const *sleepSpellInfo = sSpellStore.LookupEntry(34664);
                        if (sleepSpellInfo) // Make the creature sleep in peace :)
                        {
                            m_caster->AttackStop();
                            unitTarget->RemoveAllAuras();
                            unitTarget->DeleteThreatList();
                            unitTarget->CombatStop();
                            SpellEntry const *sleepSpellInfo = sSpellStore.LookupEntry(34664);
                            Aura* sleepAura = CreateAura(sleepSpellInfo, 0, NULL, unitTarget,unitTarget, 0);

                            unitTarget->AddAura(sleepAura); // Apply Visual Sleep
                            unitTarget->addUnitState(UNIT_STAT_STUNNED);
                            // Cant use q item again on this target untill creature awakes
                            unitTarget->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        }
                        // Add q objecive + 1
                        ((Player*)m_caster)->CastedCreatureOrGO(20982, unitTarget->GetGUID(), 35771);
                    }
                return;
                }
                 // Skyguard Blasting Charge (for quest Fires Over Skettis - 11008)
                case 39844:
                {
                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    if (((Player*)m_caster)->GetQuestStatus(11008) == QUEST_STATUS_INCOMPLETE)
                    {
                        if (unitTarget && unitTarget->GetEntry() == 22991) // trigger
                        {
                            // Handle associated GO - monstrous kaliri egg
                            GameObject* target = NULL;
                            Looking4group::AllGameObjectsWithEntryInGrid go_check(185549);
                            Looking4group::ObjectSearcher<GameObject, Looking4group::AllGameObjectsWithEntryInGrid> searcher(target, go_check);

                            // Find GO that matches this trigger:
                            Cell::VisitGridObjects(unitTarget, searcher, 3.0f);

                            // Add q objective and clean up
                            if (target)
                                m_caster->DealDamage(unitTarget, unitTarget->GetMaxHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                        }
                    }
					return;
                }
                // SixDeamonBag
                case 14537: 
                { 
                    if (!unitTarget || !unitTarget->isAlive())
                        return; 
                    uint32 ClearSpellId[6] = 
                    { 
                        15662,   // Feuerball 
                        11538,   // Frostball  
                        21179,   // Blitzschlag  
                        14621,   // Verwandeln 
                        25189,   // Wirbel
                        14642    // Felhunter
                    };

                    uint32 rand = urand(0, 100);
                    if (rand >= 0 && rand < 25)         // Feuerball (25% chance)
                        spell_id = ClearSpellId[0];
                    else if (rand >= 25 && rand < 50)   // Frostblitz (25% chance)
                        spell_id = ClearSpellId[1];
                    else if (rand >=50 && rand < 70)    // Blitzschlag (20% chance)
                        spell_id = ClearSpellId[2];
                    else if (rand >= 70 && rand < 80)   // Verwandeln (10% chance)
                    {
                        spell_id = ClearSpellId[3];
                        if (urand(0, 100) <= 30)        // 30% chance auf Selbstzauber
                            unitTarget = m_caster;
                    } 
                    else if (rand >=80 && rand < 95)    // Wirbelwind (15% chance)
                         spell_id = ClearSpellId[4];
                    else                                // Felhunter (5% chance)
                    {
                         spell_id = ClearSpellId[5];
                         unitTarget = m_caster;
                    }

					m_caster->CastSpell(unitTarget, spell_id, true, NULL);
                    return;
                }
                // Salvage Wreckage
                case 42287:
                {
                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    if (roll_chance_i(66))
                        m_caster->CastSpell(m_caster, 42289, true, m_CastItem);
                    else
                        m_caster->CastSpell(m_caster, 42288, true);

                    return;
                }
                 // Demon Broiled Surprise
                case 43723:
                {
                    m_caster->CastSpell(m_caster, 43753, false);
                    return;
                }
                // Wrath of the Astromancer
                case 42784:
                {
                    uint32 count = 0;
                    for (std::list<TargetInfo>::iterator ihit= m_UniqueTargetInfo.begin();ihit != m_UniqueTargetInfo.end();++ihit)
                    {
                        if (ihit->deleted)
                            continue;

                        if (ihit->effectMask & (1<<i))
                            ++count;
                    }

                    damage = 12000; // maybe wrong value
                    damage /= count;

                    SpellEntry const *spellInfo = sSpellStore.LookupEntry(42784);

                     // now deal the damage
                    for (std::list<TargetInfo>::iterator ihit= m_UniqueTargetInfo.begin();ihit != m_UniqueTargetInfo.end();++ihit)
                    {
                        if (ihit->deleted)
                            continue;

                        if (ihit->effectMask & (1<<i))
                        {
                            Unit* casttarget = Unit::GetUnit((*unitTarget), ihit->targetGUID);
                            if (casttarget)
                                m_caster->DealDamage(casttarget, damage, SPELL_DIRECT_DAMAGE, SPELL_SCHOOL_MASK_ARCANE, spellInfo, false);
                        }
                    }
                }
                // Encapsulate Voidwalker
                /*case 29364: // It's never used. The spell has other effects
                {
                    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_UNIT || ((Creature*)unitTarget)->isPet())
                        return;

                    Creature* creatureTarget = (Creature*)unitTarget;
                    GameObject* pGameObj = new GameObject;

                    if (!creatureTarget || !pGameObj)
                        return;

                    if (!pGameObj->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT), 181574, creatureTarget->GetMap(),
                        creatureTarget->GetPositionX(), creatureTarget->GetPositionY(), creatureTarget->GetPositionZ(),
                        creatureTarget->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 100, GO_STATE_READY))
                    {
                        delete pGameObj;
                        return;
                    }

                    pGameObj->SetRespawnTime(0);
                    pGameObj->SetOwnerGUID(m_caster->GetGUID());
                    //pGameObj->SetUInt32Value(GAMEOBJECT_LEVEL, m_caster->getLevel());
                    pGameObj->SetSpellId(GetSpellInfo()->Id);

                    creatureTarget->GetMap()->Add(pGameObj);

                    WorldPacket data(SMSG_GAMEOBJECT_SPAWN_ANIM_OBSOLETE, 8);
                    data << uint64(pGameObj->GetGUID());
                    m_caster->BroadcastPacket(&data,true);

                    return;
                }*/
                case 8063:                                  // Deviate Fish
                {
                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    uint32 spell_id = 0;
                    switch (urand(1,5))
                    {
                        case 1: spell_id = 8064; break;     // Sleepy
                        case 2: spell_id = 8065; break;     // Invigorate
                        case 3: spell_id = 8066; break;     // Shrink
                        case 4: spell_id = 8067; break;     // Party Time!
                        case 5: spell_id = 8068; break;     // Healthy Spirit
                    }
                    m_caster->CastSpell(m_caster,spell_id,true,NULL);
                    return;
                }
                case 8213:                                  // Savory Deviate Delight
                {
                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    uint32 spell_id = 0;
                    switch (urand(1,2))
                    {
                        // Flip Out - ninja
                        case 1: spell_id = (m_caster->getGender() == GENDER_MALE ? 8219 : 8220); break;
                        // Yaaarrrr - pirate
                        case 2: spell_id = (m_caster->getGender() == GENDER_MALE ? 8221 : 8222); break;
                    }
                    m_caster->CastSpell(m_caster,spell_id,true,NULL);
                    return;
                }
                case 8593:                                  // Symbol of life (restore creature to life)
                case 31225:                                 // Shimmering Vessel (restore creature to life)
                {
                    if (!unitTarget || unitTarget->GetTypeId()!=TYPEID_UNIT)
                        return;

                    ((Creature*)unitTarget)->setDeathState(JUST_ALIVED);
                    return;
                }
                case 12975:                                 //Last Stand
                {
                    int32 healthModSpellBasePoints0 = int32(m_caster->GetMaxHealth()*0.3);
                    m_caster->CastCustomSpell(m_caster, 12976, &healthModSpellBasePoints0, NULL, NULL, true, NULL);
                    return;
                }
                case 8344:                                  // Universal Remote
                {
                    if (!unitTarget)
                        return;

                    if (urand(0, 99) > 20)
                        m_caster->CastSpell(unitTarget, 8345, true);
                    else                                    // 20% (?guessed) chance for malfunction
                    {
                        switch (urand(0, 1))
                        {
                            case 0:
                                m_caster->CastSpell(unitTarget, 8346, true);
                                break;
                            case 1:
                                m_caster->CastSpell(unitTarget, 8347, true);
                                break;
                        }
                    }
                    return;
                }
                // Gnomish Death Ray
                // TODO: poprawic animacje, oraz skalowanie dmg z poziomem
                case 13280:
                    m_caster->CastSpell(unitTarget, 13279, true);     // Gnomish Death Ray direct damage
                    return;
                case 13278:
                    m_caster->CastSpell(unitTarget, 13493, true);  // Gnomish Death Ray self DOT
                    return;
                case 13180:                                 // Gnomish Mind Control Cap
                {
                    if (!unitTarget)
                        return;

                    int32 failureChance = unitTarget->getLevel() > 60 ? 20 : 5;            // guessed chance of failure
                    if (urand(0, 99) > failureChance)
                        m_caster->CastSpell(unitTarget, 13181, true);
                    else
                        unitTarget->CastSpell(m_caster, 13181, true);

                    return;
                }
                case 13006:                                 // gnomish shrink ray
                {
                    if (!unitTarget)
                        return;

                    if (urand(0, 99) > 10)
                        m_caster->CastSpell(unitTarget, 13003, true);
                    else                                    // 10% (?guessed) chance for malfunction
                    {
                        switch (urand(0, 3))
                        {
                            case 0:
                                m_caster->CastSpell(unitTarget, 13004, true);
                                break;
                            case 1:
                                m_caster->CastSpell(m_caster, 13003, true);
                                break;
                            case 2:
                                m_caster->CastSpell(m_caster, 13004, true);
                                break;
                            case 3:
                                m_caster->CastSpell(m_caster, 13010, true);
                                break;
                        }
                    }
                    return;
                }
                case 13120:                                 // net-o-matic
                {
                    if (!unitTarget)
                        return;

                    uint32 spell_id = 0;

                    uint32 roll = urand(0, 99);

                    if (roll < 2)                            // 2% for 30 sec self root (off-like chance unknown)
                        spell_id = 16566;
                    else if (roll < 10)                      // 8% for 20 sec root, charge to target (off-like chance unknown)
                        spell_id = 13119;
                    else
                        spell_id = 13099;

                    m_caster->CastSpell(unitTarget,spell_id,true,NULL);
                    return;
                }
                case 13567:                                 // Dummy Trigger
                {
                    // can be used for different aura triggering, so select by aura
                    if (!m_triggeredByAuraSpell || !unitTarget)
                        return;

                    switch (m_triggeredByAuraSpell->Id)
                    {
                        case 26467:                         // Persistent Shield
                            m_caster->CastCustomSpell(unitTarget, 26470, &damage, NULL, NULL, true);
                            break;
                        default:
                            sLog.outLog(LOG_DEFAULT, "ERROR: EffectDummy: Non-handled case for spell 13567 for triggered aura %u",m_triggeredByAuraSpell->Id);
                            break;
                    }
                    return;
                }
                case 14185:                                 // Preparation Rogue
                {
                    if (m_caster->GetTypeId()!=TYPEID_PLAYER)
                        return;

                    //immediately finishes the cooldown on certain Rogue abilities
                    const PlayerSpellMap& sp_list = ((Player *)m_caster)->GetSpellMap();
                    for (PlayerSpellMap::const_iterator itr = sp_list.begin(); itr != sp_list.end(); ++itr)
                    {
                        uint32 classspell = itr->first;
                        SpellEntry const *spellInfo = sSpellStore.LookupEntry(classspell);

                        if (spellInfo->SpellFamilyName == SPELLFAMILY_ROGUE && (spellInfo->SpellFamilyFlags & 0x26000000860LL))
                            ((Player*)m_caster)->RemoveSpellCooldown(classspell, true);
                    }
                    return;
                }
                case 21050:                                 // Melodious Rapture
                {
                    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_UNIT || unitTarget->GetEntry() != 13016)
                        return;

                    WorldLocation wLoc;
                    Creature* cTarget = (Creature*)unitTarget;
                    cTarget->GetPosition(wLoc);
                    float ang = cTarget->GetAngle(wLoc.coord_x,wLoc.coord_y);

                    if (Creature * rat = m_caster->SummonCreature(13017,wLoc.coord_x,wLoc.coord_y,wLoc.coord_z,ang,TEMPSUMMON_TIMED_DESPAWN,600000))
                        rat->GetMotionMaster()->MoveFollow(m_caster, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);

                    cTarget->setDeathState(JUST_DIED);
                    cTarget->RemoveCorpse();
                    cTarget->SetHealth(0);                  // just for nice GM-mode view
                    return;
                }
                case 15998:                                 // Capture Worg Pup
                case 29435:                                 // Capture Female Kaliri Hatchling
                {
                    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_UNIT)
                        return;

                    Creature* creatureTarget = (Creature*)unitTarget;
                    creatureTarget->setDeathState(JUST_DIED);
                    creatureTarget->RemoveCorpse();
                    creatureTarget->SetHealth(0);           // just for nice GM-mode view
                    return;
                }
                case 16589:                                 // Noggenfogger Elixir
                {
                    if (m_caster->GetTypeId()!=TYPEID_PLAYER)
                        return;

                    uint32 spell_id = 0;
                    switch (urand(1,3))
                    {
                        case 1: spell_id = 16595; break;
                        case 2: spell_id = 16593; break;
                        default:spell_id = 16591; break;
                    }

                    m_caster->CastSpell(m_caster,spell_id,true,NULL);
                    return;
                }
                case 17251:                                 // Spirit Healer Res
                {
                    if (!unitTarget || !m_originalCaster)
                        return;

                    if (m_originalCaster->GetTypeId() == TYPEID_PLAYER)
                    {
                        WorldPacket data(SMSG_SPIRIT_HEALER_CONFIRM, 8);
                        data << unitTarget->GetGUID();
                        ((Player*)m_originalCaster)->SendPacketToSelf(&data);
                    }
                    return;
                }
                case 17271:                                 // Test Fetid Skull
                {
                    if (!itemTarget && m_caster->GetTypeId()!=TYPEID_PLAYER)
                        return;

                    uint32 spell_id = roll_chance_i(50) ? 17269 : 17270;

                    m_caster->CastSpell(m_caster,spell_id,true,NULL);
                    return;
                }
                case 19250:                                 // Placing Smokey's Explosives
                {
                    if(i == 0)
                    {
                        focusObject->SetLootState(GO_JUST_DEACTIVATED);
                        m_caster->CastSpell(m_caster, 19237, true);
                        ((Player*)m_caster)->KilledMonster(12247, m_caster->GetMap()->GetCreatureGUID(12247));
                    }
                    return;
                }
                case 20577:                                 // Cannibalize
                    if (unitTarget)
                        m_caster->CastSpell(m_caster,20578,false,NULL);
                    return;
                case 21147:                                 // Arcane Vacuum
                {
                    if (!unitTarget)
                        return;

                    // Spell used by Azuregos to teleport all the players to him
                    // This also resets the target threat
                    if (m_caster->getThreatManager().getThreat(unitTarget))
                        m_caster->getThreatManager().modifyThreatPercent(unitTarget, -100);

                    // cast summon player
                    m_caster->CastSpell(unitTarget, 21150, true);
                    return;
                }
                case 23019:                                 // Crystal Prison Dummy DND
                {
                    if (!unitTarget || !unitTarget->isAlive() || unitTarget->GetTypeId() != TYPEID_UNIT || ((Creature*)unitTarget)->isPet())
                        return;

                    Creature* creatureTarget = (Creature*)unitTarget;
                    creatureTarget->setDeathState(JUST_DIED);
                    creatureTarget->RemoveCorpse();
                    creatureTarget->SetHealth(0);                   // just for nice GM-mode view

                    GameObject* Crystal_Prison = m_caster->SummonGameObject(179644, creatureTarget->GetPositionX(), creatureTarget->GetPositionY(), creatureTarget->GetPositionZ(), creatureTarget->GetOrientation(), 0, 0, 0, 0, creatureTarget->GetRespawnTime()-time(NULL));
                    sLog.outDebug("SummonGameObject at SpellEfects.cpp EffectDummy for Spell 23019\n");
                    WorldPacket data(SMSG_GAMEOBJECT_SPAWN_ANIM_OBSOLETE, 8);
                    data << uint64(Crystal_Prison->GetGUID());
                    m_caster->BroadcastPacket(&data,true);

                    return;
                }
                case 23074:                                 // Arc. Dragonling
                    if (!m_CastItem) return;
                    m_caster->CastSpell(m_caster,19804,true,m_CastItem);
                    return;
                case 23075:                                 // Mithril Mechanical Dragonling
                    if (!m_CastItem) return;
                    m_caster->CastSpell(m_caster,12749,true,m_CastItem);
                    return;
                case 23076:                                 // Mechanical Dragonling
                    if (!m_CastItem) return;
                    m_caster->CastSpell(m_caster,4073,true,m_CastItem);
                    return;
                case 23133:                                 // Gnomish Battle Chicken
                    if (!m_CastItem) return;
                    m_caster->CastSpell(m_caster,13166,true,m_CastItem);
                    return;
                case 23448:                                 // Ultrasafe Transporter: Gadgetzan - backfires
                {
                  int32 r = irand(0, 119);
                    if (r < 20)                           // 1/6 polymorph
                        m_caster->CastSpell(m_caster,23444,true);
                    else if (r < 100)                     // 4/6 evil twin
                        m_caster->CastSpell(m_caster,23445,true);
                    else                                    // 1/6 miss the target
                        m_caster->CastSpell(m_caster,36902,true);
                    return;
                }
                case 23453:                                 // Ultrasafe Transporter: Gadgetzan
                    if (roll_chance_i(50))                // success
                        m_caster->CastSpell(m_caster,23441,true);
                    else                                    // failure
                        m_caster->CastSpell(m_caster,23446,true);
                    return;
                case 23645:                                 // Hourglass Sand
                    m_caster->RemoveAurasDueToSpell(23170);
                    return;
                case 23725:                                 // Gift of Life (warrior bwl trinket)
                    m_caster->CastSpell(m_caster,23782,true);
                    m_caster->CastSpell(m_caster,23783,true);
                    return;
                case 24930:                                 // Hallow's End Candy
                    if (m_caster->GetTypeId()!=TYPEID_PLAYER)
                        return;

                    switch (irand(0,3))
                    {
                    case 0:
                        m_caster->CastSpell(m_caster,24927,true); // Ghost
                        break;
                    case 1:
                        m_caster->CastSpell(m_caster,24926,true); // Pirate
                        if (m_caster->getGender() == GENDER_MALE)
                        {
                            m_caster->CastSpell(m_caster,44743,true);
                        }
                        else
                        {
                            m_caster->CastSpell(m_caster,44742,true);
                        }
                        break;
                    case 2:
                        m_caster->CastSpell(m_caster,24925,true); // Skeleton
                        break;
                    case 3:
                        m_caster->CastSpell(m_caster,24924,true); // Huge and Orange
                        break;
                    }
                    return;
                case 25860:                                 // Reindeer Transformation
                {
                    if (!m_caster->HasAuraType(SPELL_AURA_MOUNTED))
                        return;

                    float flyspeed = m_caster->GetSpeedRate(MOVE_FLIGHT);
                    float speed = m_caster->GetSpeedRate(MOVE_RUN);

                    m_caster->RemoveSpellsCausingAura(SPELL_AURA_MOUNTED);

                    //5 different spells used depending on mounted speed and if mount can fly or not
                    if (flyspeed >= 4.1f)
                        m_caster->CastSpell(m_caster, 44827, true); //310% flying Reindeer
                    else if (flyspeed >= 3.8f)
                        m_caster->CastSpell(m_caster, 44825, true); //280% flying Reindeer
                    else if (flyspeed >= 1.6f)
                        m_caster->CastSpell(m_caster, 44824, true); //60% flying Reindeer
                    else if (speed >= 2.0f)
                        m_caster->CastSpell(m_caster, 25859, true); //100% ground Reindeer
                    else
                        m_caster->CastSpell(m_caster, 25858, true); //60% ground Reindeer

                    return;
                }
                //case 26074:                               // Holiday Cheer
                //    return; -- implemented at client side
                case 28006:                                 // Arcane Cloaking
                {
                    if (unitTarget && unitTarget->GetTypeId() == TYPEID_PLAYER)
                    {
                        unitTarget->ToPlayer()->RewardDNDQuest(9378);
                        m_caster->CastSpell(unitTarget,29294,true);
                    }
                    return;
                }
                /*case 28730:                                 // Arcane Torrent (Mana)
                {
                    Aura * dummy = m_caster->GetDummyAura(28734);
                    if (dummy)
                    {
                        int32 bp = damage * dummy->GetStackAmount();
                        m_caster->CastCustomSpell(m_caster, 28733, &bp, NULL, NULL, true);
                        m_caster->RemoveAurasDueToSpell(28734);
                    }
                    return;
                }*/
                // Polarity Shift (Thaddius)
                case 28089:
                {
                    if (!unitTarget)
                        break;
                    uint32 spellId = roll_chance_i(50) ? 28059 : 28084;
                    unitTarget->RemoveAurasDueToSpell(spellId == 28059 ? 28084 : 28059);
                    unitTarget->CastSpell(unitTarget, spellId, true, NULL, NULL, m_caster->GetGUID());
                    break;
                }
                // Polarity Shift (Mechano-Lord Capacitus)
                case 39096:
                    if (unitTarget)
                        unitTarget->CastSpell(unitTarget, roll_chance_i(50) ? 39088 : 39091, true, NULL, NULL, m_caster->GetGUID());
                    break;
                case 29200:                                 // Purify Helboar Meat
                {
                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    uint32 spell_id = roll_chance_i(50) ? 29277 : 29278;

                    m_caster->CastSpell(m_caster,spell_id,true,NULL);
                    return;
                }
                case 29858:                                 // Soulshatter
                    if (unitTarget && unitTarget->CanHaveThreatList()
                        && unitTarget->getThreatManager().getThreat(m_caster) > 0.0f)
                        m_caster->CastSpell(unitTarget,32835,true);
                    return;
                case 30458:                                 // Nigh Invulnerability
                    if (!m_CastItem) return;
                    if (roll_chance_i(86))                   // success
                        m_caster->CastSpell(m_caster, 30456, true, m_CastItem);
                    else                                    // backfire in 14% casts
                        m_caster->CastSpell(m_caster, 30457, true, m_CastItem);
                    return;
                case 30507:                                 // Poultryizer
                    if (!m_CastItem) return;
                    if (roll_chance_i(80))                   // success
                        m_caster->CastSpell(unitTarget, 30501, true, m_CastItem);
                    else                                    // backfire 20%
                        m_caster->CastSpell(unitTarget, 30504, true, m_CastItem);
                    return;
                case 33060:                                         // Make a Wish
                {
                    if (m_caster->GetTypeId()!=TYPEID_PLAYER)
                        return;

                    uint32 spell_id = 0;

                    switch (urand(1,5))
                    {
                        case 1: spell_id = 33053; break;
                        case 2: spell_id = 33057; break;
                        case 3: spell_id = 33059; break;
                        case 4: spell_id = 33062; break;
                        case 5: spell_id = 33064; break;
                    }

                    m_caster->CastSpell(m_caster,spell_id,true,NULL);
                    return;
                }
                case 35745:                                 // Socrethar's Stone
                {
                    uint32 spell_id;
                    uint32 areaid = m_caster->GetTypeId() == TYPEID_PLAYER ? ((Player*)m_caster)->GetCachedArea() : m_caster->GetAreaId();

                    switch (areaid)
                    {
                        case 3900: spell_id = 35743; break;
                        case 3742: spell_id = 35744; break;
                        default: return;
                    }

                    m_caster->CastSpell(m_caster,spell_id,true);
                    return;
                }
                case 37674:                                 // Chaos Blast
                {
                    if (!unitTarget)
                        return;

                    int32 basepoints0 = 100;
                    m_caster->CastCustomSpell(unitTarget,37675,&basepoints0,NULL,NULL,true);
                    return;
                }
                case 40109:                                 // Knockdown Fel Cannon: The Bolt
                {
                    if (unitTarget)
                        unitTarget->CastSpell(unitTarget, 40075, true);
                    return;
                }
                case 40802:                                 // Mingo's Fortune Generator (Mingo's Fortune Giblets)
                {
                    // selecting one from Bloodstained Fortune item
                    uint32 newitemid;
                    switch (urand(1,20))
                    {
                        case 1:  newitemid = 32688; break;
                        case 2:  newitemid = 32689; break;
                        case 3:  newitemid = 32690; break;
                        case 4:  newitemid = 32691; break;
                        case 5:  newitemid = 32692; break;
                        case 6:  newitemid = 32693; break;
                        case 7:  newitemid = 32700; break;
                        case 8:  newitemid = 32701; break;
                        case 9:  newitemid = 32702; break;
                        case 10: newitemid = 32703; break;
                        case 11: newitemid = 32704; break;
                        case 12: newitemid = 32705; break;
                        case 13: newitemid = 32706; break;
                        case 14: newitemid = 32707; break;
                        case 15: newitemid = 32708; break;
                        case 16: newitemid = 32709; break;
                        case 17: newitemid = 32710; break;
                        case 18: newitemid = 32711; break;
                        case 19: newitemid = 32712; break;
                        case 20: newitemid = 32713; break;
                        default:
                            return;
                    }

                    DoCreateItem(i,newitemid);
                    return;
                }
                case 40834: // Agonizing Flames
                {
                    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
                        return;

                    m_caster->CastSpell(unitTarget,40932,true);
                    break;
                }
                case 44875:                                 // Complete Raptor Capture
                {
                    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_UNIT)
                        return;

                    Creature* creatureTarget = (Creature*)unitTarget;

                    creatureTarget->setDeathState(JUST_DIED);
                    creatureTarget->RemoveCorpse();
                    creatureTarget->SetHealth(0);           // just for nice GM-mode view

                    //cast spell Raptor Capture Credit
                    m_caster->CastSpell(m_caster,42337,true,NULL);
                    return;
                }
                case 34665:                                 //Administer Antidote
                {
                    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_UNIT || m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    Creature* pCreature = (Creature*)unitTarget;

                    pCreature->UpdateEntry(16992); // change into dreadtusk
                    pCreature->AIM_Initialize();

                    if (pCreature->IsAIEnabled)
                        pCreature->AI()->AttackStart(m_caster);

                    return;
                }
                case 44935:                                 // Expose Razorthorn Root
                {
                    if(!unitTarget)
                        return;

                    Player* plr = unitTarget->GetCharmerOrOwnerPlayerOrPlayerItself();

                    GameObject* ok = NULL;
                    Looking4group::GameObjectFocusCheck go_check(plr,GetSpellInfo()->RequiresSpellFocus);
                    Looking4group::ObjectSearcher<GameObject, Looking4group::GameObjectFocusCheck> checker(ok,go_check);

                    Cell::VisitGridObjects(plr, checker, plr->GetMap()->GetVisibilityDistance());

                    if (!ok)
                    {
                        WorldPacket data(SMSG_CAST_FAILED, (4+1+1));
                        data << uint32(GetSpellInfo()->Id);
                        data << uint8(SPELL_FAILED_REQUIRES_SPELL_FOCUS);
                        data << uint8(m_cast_count);
                        data << uint32(GetSpellInfo()->RequiresSpellFocus);
                        plr->SendPacketToSelf(&data);
                        return;
                    }

                    if(unitTarget->GetTypeId() == TYPEID_UNIT)
                        unitTarget->GetMotionMaster()->MovePoint(1, ok->GetPositionX(), ok->GetPositionY(), ok->GetPositionZ());

                    return;
                }
                case 44997:                                 // Converting Sentry remove corpse
                {
                    if(unitTarget && unitTarget->GetTypeId() == TYPEID_UNIT)
                        unitTarget->ToCreature()->DisappearAndDie();
                    return;
                }
                case 45030:                                 // Impale Emissary
                {
                    // Emissary of Hate Credit
                    m_caster->CastSpell(m_caster, 45088, true);
                    return;
                }
                case 46573:                                 // Blink (Sunblade Arch Mage)
                {
                    if (m_caster->GetTypeId() == TYPEID_UNIT)
                    {
                        //firts AoE stun
                        m_caster->CastSpell(unitTarget, 41421, true);

                        Position dest;
                        m_caster->GetValidPointInAngle(dest, 45.0f, 0.0f, true);

                        m_caster->NearTeleportTo(dest.x, dest.y, dest.z, unitTarget->GetOrientation(), true);

                        if (m_caster->getVictim())
                            m_caster->GetMotionMaster()->MoveChase(m_caster->getVictim());
                    }
                }
                case 50243:                                 // Teach Language
                {
                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    // spell has a 1/3 chance to trigger one of the below
                    if (roll_chance_i(66))
                        return;
                    if (((Player*)m_caster)->GetTeam() == ALLIANCE)
                    {
                        // 1000001 - gnomish binary
                        m_caster->CastSpell(m_caster, 50242, true);
                    }
                    else
                    {
                        // 01001000 - goblin binary
                        m_caster->CastSpell(m_caster, 50246, true);
                    }

                    return;
                }
                case 51582:                                 //Rocket Boots Engaged (Rocket Boots Xtreme and Rocket Boots Xtreme Lite)
                {
                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    if (BattleGround* bg = ((Player*)m_caster)->GetBattleGround())
                        bg->EventPlayerDroppedFlag((Player*)m_caster);

                    m_caster->CastSpell(m_caster, 30452, true, NULL);
                    return;
                }
                case 39992:                                 //Needle Spine Targeting
                {
                    m_caster->CastSpell(unitTarget,39835,true);
                    break;
                }
                case 39581:                                 // Storm Blink
                {
                    m_caster->CastSpell(m_caster, 39582, true);
                    break;
                }
                case 32225:                                 //Chess Event: Take Action (melee)
                {
                    switch (m_caster->GetEntry())
                    {
                        case 17211:     //alliance pawn (Human Footman)
                            m_caster->CastSpell((Unit*)NULL, 32227, true);
                            break;
                        case 17469:     //horde pawn (Orc Grunt)
                            m_caster->CastSpell((Unit*)NULL, 32228, true);
                            break;
                        case 21160:     //alliance rook (Conjured Water Elemental)
                            m_caster->CastSpell((Unit*)NULL, 37142, true);
                            break;
                        case 21726:     //horde rook (Summoned Daemon)
                            m_caster->CastSpell((Unit*)NULL, 37220, true);
                            break;
                        case 21664:     //alliance knight (Human Charger)
                            m_caster->CastSpell((Unit*)NULL, 37143, true);       //proper spell ??
                            break;
                        case 21748:     //horde knight (Orc Wolf)
                            m_caster->CastSpell((Unit*)NULL, 37339, true);
                            break;
                        case 21682:     //Alliance bishop (Human Cleric)
                            m_caster->CastSpell((Unit*)NULL, 37147, true);
                            break;
                        case 21747:     //Horde bishop (Orc Necrolyte)
                            m_caster->CastSpell((Unit*)NULL, 37337, true);
                            break;
                        case 21683:     //Alliance Queen (Human Conjurer)
                            m_caster->CastSpell((Unit*)NULL, 37149, true);
                            break;
                        case 21750:     //Horde Queen (Orc Warlock)
                            m_caster->CastSpell((Unit*)NULL, 37345, true);
                            break;
                        case 21684:     //Alliance King (King Llane)
                            m_caster->CastSpell((Unit*)NULL, 37150, true);
                            break;
                        case 21752:     //Horde King (Warchief Blackhand)
                            m_caster->CastSpell((Unit*)NULL, 37348, true);
                            break;
                        default:
                            m_caster->CastSpell((Unit*)NULL, 37348, true);
                            break;
                    }
                    break;
                }
                // Summon Thelrin DND (Banner of Provocation)
                case 27517:
                    m_caster->SummonCreature(16059, 590.6309, -181.061, -53.90, 5.33, TEMPSUMMON_DEAD_DESPAWN, 0);
                    break;
                case 43755:
                {
                    Aura * aur = unitTarget->GetAura(43880, 0);
                    if(aur)
                    {
                        aur->SetAuraDuration(aur->GetAuraDuration() + 30000);
                        aur->UpdateAuraDuration();
                    }
                    break;
                }
            }

            //All IconID Check in there
            switch (GetSpellInfo()->SpellIconID)
            {
                // Berserking (troll racial traits)
                case 1661:
                {
                    uint32 healthPerc = uint32((float(m_caster->GetHealth())/m_caster->GetMaxHealth())*100);
                    int32 melee_mod = 10;
                    if (healthPerc <= 40)
                        melee_mod = 30;
                    if (healthPerc < 100 && healthPerc > 40)
                        melee_mod = 10+(100-healthPerc)/3;

                    int32 hasteModBasePoints0 = melee_mod;          // (EffectBasePoints[0]+1)-1+(5-melee_mod) = (melee_mod-1+1)-1+5-melee_mod = 5-1
                    int32 hasteModBasePoints1 = (5-melee_mod);
                    int32 hasteModBasePoints2 = 5;

                    // FIXME: custom spell required this aura state by some unknown reason, we not need remove it anyway
                    m_caster->ModifyAuraState(AURA_STATE_BERSERKING,true);
                    m_caster->CastCustomSpell(m_caster,26635,&hasteModBasePoints0,&hasteModBasePoints1,&hasteModBasePoints2,true,NULL);
                    return;
                }
            }
            break;
        }
        case SPELLFAMILY_MAGE:
            switch (GetSpellInfo()->Id)
            {
                case 30610: // Wrath of the Titans
                {
                    
                    if (!m_caster->getVictim())
                        return;

                    switch (rand()%5)
                    {
                        case 0: m_caster->CastSpell(m_caster->getVictim(), 30605, true); break;  // Blast of Aman'Thul: Arcane
                        case 1: m_caster->CastSpell(m_caster->getVictim(), 30606, true); break;  // Bolt of Eonar: Nature
                        case 2: m_caster->CastSpell(m_caster->getVictim(), 30607, true); break;  // Flame of Khaz'goroth: Fire
                        case 3: m_caster->CastSpell(m_caster->getVictim(), 30608, true); break;  // Spite of Sargeras: Shadow
                        case 4: m_caster->CastSpell(m_caster->getVictim(), 30609, true); break;  // Chill of Norgannon: Frost
                    }
                    return;
                }
                case 11958:                                 // Cold Snap
                {
                    if (m_caster->GetTypeId()!=TYPEID_PLAYER)
                        return;

                    // immediately finishes the cooldown on Frost spells
                    const PlayerSpellMap& sp_list = ((Player *)m_caster)->GetSpellMap();
                    for (PlayerSpellMap::const_iterator itr = sp_list.begin(); itr != sp_list.end(); ++itr)
                    {
                        if (itr->second.state == PLAYERSPELL_REMOVED)
                            continue;

                        uint32 classspell = itr->first;
                        SpellEntry const *spellInfo = sSpellStore.LookupEntry(classspell);

                        if (spellInfo->SpellFamilyName == SPELLFAMILY_MAGE &&
                            (SpellMgr::GetSpellSchoolMask(spellInfo) & SPELL_SCHOOL_MASK_FROST) &&
                            spellInfo->Id != 11958 && SpellMgr::GetSpellRecoveryTime(spellInfo) > 0)
                        {
                            ((Player*)m_caster)->RemoveSpellCooldown(classspell, true);
                        }
                    }
                    return;
                }
                case 32826:
                {
                    if (unitTarget && unitTarget->GetTypeId() == TYPEID_UNIT)
                    {
                        //Polymorph Cast Visual Rank 1
                        const uint32 spell_list[6] = {32813, 32816, 32817, 32818, 32819, 32820};
                        unitTarget->CastSpell(unitTarget, spell_list[urand(0, 5)], true);
                    }
                    return;
                }
                case 26373: // Lunar Invitation teleports
                {
                    static uint32 LunarEntry[6] =
                    {
                        15905, // Darnassus
                        15906, // Ironforge
                        15694, // Stormwind
                        15908, // Orgrimmar
                        15719, // Thunderbluff
                        15907 // Undercity
                    };

                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    if (((Player*)m_caster)->GetCachedZone() != 493)   // Moonglade
                        m_caster->CastSpell(m_caster, 26451, false);
                    else
                    {
                        uint32 LunarId = -1;
                        for (uint8 i=0;i<6;++i)
                        {
                            Creature *pCreature = NULL;
                            Looking4group::NearestCreatureEntryWithLiveStateInObjectRangeCheck creature_check(*m_caster, LunarEntry[i], true, 7.0, false);
                            Looking4group::ObjectLastSearcher<Creature, Looking4group::NearestCreatureEntryWithLiveStateInObjectRangeCheck> searcher(pCreature, creature_check);
                            Cell::VisitGridObjects(m_caster, searcher, 7.0);

                            if (pCreature)
                            {
                                LunarId = i;
                                break;
                            }
                        }

                        switch (((Player*)m_caster)->GetTeam())
                        {
                            case ALLIANCE:
                            {
                                switch (LunarId)
                                {
                                    case 0:
                                        m_caster->CastSpell(m_caster, 26450, false);  // Darnassus
                                        return;
                                    case 1:
                                        m_caster->CastSpell(m_caster, 26452, false); // Ironforge
                                        return;
                                    case 2:
                                        m_caster->CastSpell(m_caster, 26454, false); // Stormwind
                                        return;
                                    default:
                                        break;
                                }
                                break;
                            }
                            case HORDE:
                            {
                                switch (LunarId)
                                {
                                    case 3:
                                        m_caster->CastSpell(m_caster, 26453, false);  // Orgrimmar
                                        return;
                                    case 4:
                                        m_caster->CastSpell(m_caster, 26455, false); // Thunderbluff
                                        return;
                                    case 5:
                                        m_caster->CastSpell(m_caster, 26456, false); // Undercity
                                        return;
                                    default:
                                        break;
                                }
                                break;
                            }
                        }
                    }
                    return;
                }
                case 38642: // Blink
                {
                    if(!unitTarget)
                        return;
                    m_caster->CastSpell(unitTarget, 29884, true);
                    return;
                }
            }
            break;
        case SPELLFAMILY_WARRIOR:
            // Charge
            if (GetSpellInfo()->SpellFamilyFlags & 0x1 && GetSpellInfo()->SpellVisual == 867)
            {
                int32 chargeBasePoints0 = damage;
                m_caster->CastCustomSpell(m_caster,34846,&chargeBasePoints0,NULL,NULL,true);
                return;
            }
            // Execute
            if (GetSpellInfo()->SpellFamilyFlags & 0x20000000)
            {
                if (!unitTarget)
                    return;

                spell_id = 20647;
                bp = damage + int32((m_caster->GetPower(POWER_RAGE) - GetPowerCost()) * GetSpellInfo()->DmgMultiplier[i]);
                m_caster->SetPower(POWER_RAGE,0);
                break;
            }
            if (GetSpellInfo()->Id==21977)                      //Warrior's Wrath
            {
                if (!unitTarget)
                    return;

                m_caster->CastSpell(unitTarget,21887,true); // spell mod
                return;
            }
            break;
        case SPELLFAMILY_WARLOCK:
            //Life Tap (only it have this with dummy effect)
            if (GetSpellInfo()->SpellFamilyFlags == 0x40000)
            {
                float cost = damage;

                if (Player* modOwner = m_caster->GetSpellModOwner())
                    modOwner->ApplySpellMod(GetSpellInfo()->Id, SPELLMOD_COST, cost,this);

                int32 dmg = m_caster->SpellDamageBonus(m_caster, GetSpellInfo(),uint32(cost > 0 ? cost : 0), SPELL_DIRECT_DAMAGE);

                if (int32(m_caster->GetHealth()) > dmg)
                {
                    // Shouldn't Appear in Combat Log
                    m_caster->ModifyHealth(-dmg);

                    int32 mana = dmg;

                    Unit::AuraList const& auraDummy = m_caster->GetAurasByType(SPELL_AURA_DUMMY);
                    for (Unit::AuraList::const_iterator itr = auraDummy.begin(); itr != auraDummy.end(); ++itr)
                    {
                        // only Imp. Life Tap have this in combination with dummy aura
                        if ((*itr)->GetSpellProto()->SpellFamilyName==SPELLFAMILY_WARLOCK && (*itr)->GetSpellProto()->SpellIconID == 208)
                            mana = ((*itr)->GetModifier()->m_amount + 100)* mana / 100;
                    }

                    m_caster->CastCustomSpell(m_caster,31818,&mana,NULL,NULL,true,NULL);

                    // Mana Feed
                    int32 manaFeedVal = m_caster->CalculateSpellDamage(GetSpellInfo(),1, GetSpellInfo()->EffectBasePoints[1],m_caster);
                    manaFeedVal = manaFeedVal * mana / 100;
                    if (manaFeedVal > 0)
                        m_caster->CastCustomSpell(m_caster,32553,&manaFeedVal,NULL,NULL,true,NULL);
                }
                else
                    SendCastResult(SPELL_FAILED_FIZZLE);
                return;
            }
            break;
        case SPELLFAMILY_PRIEST:
            switch (GetSpellInfo()->Id)
            {
                case 28598:                                 // Touch of Weakness triggered spell
                {
                    if (!unitTarget || !m_triggeredByAuraSpell)
                        return;

                    uint32 spellid = 0;
                    switch (m_triggeredByAuraSpell->Id)
                    {
                        case 2652:  spellid =  2943; break; // Rank 1
                        case 19261: spellid = 19249; break; // Rank 2
                        case 19262: spellid = 19251; break; // Rank 3
                        case 19264: spellid = 19252; break; // Rank 4
                        case 19265: spellid = 19253; break; // Rank 5
                        case 19266: spellid = 19254; break; // Rank 6
                        case 25461: spellid = 25460; break; // Rank 7
                        default:
                            sLog.outLog(LOG_DEFAULT, "ERROR: Spell::EffectDummy: Spell 28598 triggered by unhandled spell %u",m_triggeredByAuraSpell->Id);
                            return;
                    }
                    m_caster->CastSpell(unitTarget, spellid, true, NULL);
                    return;
                }
            }
            break;
        case SPELLFAMILY_DRUID:
            switch (GetSpellInfo()->Id)
            {
                case 5420:                                  // Tree of Life passive
                {
                    // Tree of Life area effect
                    int32 health_mod = int32(m_caster->GetStat(STAT_SPIRIT)/4);
                    if (Aura *aur = m_caster->GetAura(39926, 0))         // Idol of the Raven Goddess
                        health_mod += aur->GetModifierValue();
                    m_caster->CastCustomSpell(m_caster,34123,&health_mod,NULL,NULL,true,NULL);
                    return;
                }
            }
            break;
        case SPELLFAMILY_ROGUE:
            switch (GetSpellInfo()->Id)
            {
                case 31231:                                 // Cheat Death
                {
                    m_caster->CastSpell(m_caster,45182,true);
                    return;
                }
                case 5938:                                  // Shiv
                {
                    if (m_caster->GetTypeId() != TYPEID_PLAYER)
                        return;

                    Player *pCaster = ((Player*)m_caster);

                    Item *item = pCaster->GetWeaponForAttack(OFF_ATTACK);
                    if (!item)
                        return;

                    // all poison enchantments is temporary
                    if (uint32 enchant_id = item->GetEnchantmentId(TEMP_ENCHANTMENT_SLOT))
                    {
                        if (SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id))
                        {
                            for (int s=0;s<3;s++)
                            {
                                if (pEnchant->type[s]!=ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL)
                                    continue;

                                SpellEntry const* combatEntry = sSpellStore.LookupEntry(pEnchant->spellid[s]);
                                if (!combatEntry || combatEntry->Dispel != DISPEL_POISON)
                                    continue;

                                m_caster->CastSpell(unitTarget, combatEntry, true, item);
                            }
                        }
                    }

                    m_caster->CastSpell(unitTarget, 5940, true);
                    return;
                }
                // slice and dice
                case 5171:
                case 6774:
                {
                    Unit::AuraList procTriggerAuras = m_caster->GetAurasByType(SPELL_AURA_PROC_TRIGGER_SPELL);
                    for (Unit::AuraList::iterator i = procTriggerAuras.begin(); i != procTriggerAuras.end(); i++)
                    {
                        switch ((*i)->GetSpellProto()->Id)
                        {
                            // find weakness
                            case 31239:
                            case 31233:
                            case 31240:
                            case 31241:
                            case 31242:
                                m_caster->CastSpell(unitTarget, (*i)->GetSpellProto()->EffectTriggerSpell[(*i)->GetEffIndex()], true, NULL, (*i));
                                return;
                        }
                    }
                    return;
                }
            }
            break;
        case SPELLFAMILY_HUNTER:
            // Kill command
            if (GetSpellInfo()->SpellFamilyFlags & 0x00080000000000LL)
            {
                if (m_caster->getClass()!=CLASS_HUNTER)
                    return;

                // clear hunter crit aura state
                m_caster->ModifyAuraState(AURA_STATE_HUNTER_CRIT_STRIKE,false);

                // additional damage from pet to pet target
                Pet* pet = m_caster->GetPet();
                if (!pet || !pet->getVictim())
                    return;

                uint32 spell_id = 0;
                switch (GetSpellInfo()->Id)
                {
                case 34026: spell_id = 34027; break;        // rank 1
                default:
                    sLog.outLog(LOG_DEFAULT, "ERROR: Spell::EffectDummy: Spell %u not handled in KC",GetSpellInfo()->Id);
                    return;
                }

                pet->CastSpell(pet->getVictim(), spell_id, true);
                return;
            }

            switch (GetSpellInfo()->Id)
            {
                case 23989:                                 //Readiness talent
                {
                    if (m_caster->GetTypeId()!=TYPEID_PLAYER)
                        return;

                    //immediately finishes the cooldown for hunter abilities
                    const PlayerSpellMap& sp_list = ((Player *)m_caster)->GetSpellMap();
                    for (PlayerSpellMap::const_iterator itr = sp_list.begin(); itr != sp_list.end(); ++itr)
                    {
                        uint32 classspell = itr->first;
                        SpellEntry const *spellInfo = sSpellStore.LookupEntry(classspell);

                        if (spellInfo->SpellFamilyName == SPELLFAMILY_HUNTER && spellInfo->Id != 23989 && SpellMgr::GetSpellRecoveryTime(spellInfo) > 0)
                            ((Player*)m_caster)->RemoveSpellCooldown(classspell, true);
                    }
                    return;
                }
                case 37506:                                 // Scatter Shot
                {
                    if (m_caster->GetTypeId()!=TYPEID_PLAYER)
                        return;

                    // break Auto Shot and autohit
                    m_caster->InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
                    m_caster->AttackStop();
                    ((Player*)m_caster)->SendAttackSwingCancelAttack();
                    return;
                }
            }
            break;
        case SPELLFAMILY_PALADIN:
            switch (GetSpellInfo()->SpellIconID)
            {
                case  156:                                  // Holy Shock
                {
                    if (!unitTarget)
                        return;

                    int hurt = 0;
                    int heal = 0;

                    switch (GetSpellInfo()->Id)
                    {
                        case 20473: hurt = 25912; heal = 25914; break;
                        case 20929: hurt = 25911; heal = 25913; break;
                        case 20930: hurt = 25902; heal = 25903; break;
                        case 27174: hurt = 27176; heal = 27175; break;
                        case 33072: hurt = 33073; heal = 33074; break;
                        default:
                            sLog.outLog(LOG_DEFAULT, "ERROR: Spell::EffectDummy: Spell %u not handled in HS",GetSpellInfo()->Id);
                            return;
                    }

                    if (m_caster->IsFriendlyTo(unitTarget))
                        m_caster->CastSpell(unitTarget, heal, true, 0);
                    else
                        m_caster->CastSpell(unitTarget, hurt, true, 0);

                    return;
                }
                case 561:                                   // Judgement of command
                {
                    if (!unitTarget)
                        return;

                    uint32 spell_id = GetSpellInfo()->EffectBasePoints[i]+1;//m_currentBasePoints[i]+1;
                    SpellEntry const* spell_proto = sSpellStore.LookupEntry(spell_id);
                    if (!spell_proto)
                        return;

                    if (!unitTarget->hasUnitState(UNIT_STAT_STUNNED) && m_caster->GetTypeId()==TYPEID_PLAYER)
                    {
                        // decreased damage (/2) for non-stunned target.
                        SpellModifier *mod = new SpellModifier;
                        mod->op = SPELLMOD_DAMAGE;
                        mod->value = -50;
                        mod->type = SPELLMOD_PCT;
                        mod->spellId = GetSpellInfo()->Id;
                        mod->effectId = i;
                        mod->lastAffected = NULL;
                        mod->mask = 0x0000020000000000LL;
                        mod->charges = 0;

                        ((Player*)m_caster)->AddSpellMod(mod, true);
                        m_caster->CastSpell(unitTarget,spell_proto,true,NULL);
                                                            // mod deleted
                        ((Player*)m_caster)->AddSpellMod(mod, false);
                    }
                    else
                        m_caster->CastSpell(unitTarget,spell_proto,true,NULL);

                    return;
                }
            }

            switch (GetSpellInfo()->Id)
            {
                case 31789:                                 // Righteous Defense (step 1)
                {
                    // 31989 -> dummy effect (step 1) + dummy effect (step 2) -> 31709 (taunt like spell for each target)

                    // non-standard cast requirement check
                    if (!unitTarget || unitTarget->getAttackers().empty())
                    {
                        // clear cooldown at fail
                        if (m_caster->GetTypeId() == TYPEID_PLAYER)
                            ((Player*) m_caster)->RemoveSpellCooldown(GetSpellInfo()->Id, true);

                        SendCastResult(SPELL_FAILED_TARGET_AFFECTING_COMBAT);
                        return;
                    }

                    // Righteous Defense (step 2) (in old version 31980 dummy effect)
                    // Clear targets for eff 1
                    for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
                    {
                        if (ihit->deleted)
                            continue;

                        ihit->effectMask &= ~(1<<1);
                    }

                    // not empty (checked)
                    Unit::AttackerSet attackers(unitTarget->getAttackers());

                    // chance to be selected from list
                    uint32 maxTargets = std::min<uint32>(3, attackers.size());
                    for (uint32 i = 0; i < maxTargets; ++i)
                    {
                        Unit::AttackerSet::const_iterator aItr = attackers.begin();
                        std::advance(aItr, urand(0, attackers.size() - 1));
                        AddUnitTarget(*aItr, 1);
                        attackers.erase(*aItr);
                    }

                    // now let next effect cast spell at each target.
                    return;
                }
                case 37877:                                 // Blessing of Faith
                {
                    if (!unitTarget)
                        return;

                    uint32 spell_id = 0;
                    switch (unitTarget->getClass())
                    {
                        case CLASS_DRUID:   spell_id = 37878; break;
                        case CLASS_PALADIN: spell_id = 37879; break;
                        case CLASS_PRIEST:  spell_id = 37880; break;
                        case CLASS_SHAMAN:  spell_id = 37881; break;
                        default: return;                    // ignore for not healing classes
                    }

                    m_caster->CastSpell(m_caster,spell_id,true);
                    return;
                }
            }
            break;
        case SPELLFAMILY_SHAMAN:

            // Flametongue Weapon Proc
            if (GetSpellInfo()->SpellFamilyFlags & 0x200000)
            {
                if (m_caster->GetTypeId() != TYPEID_PLAYER)
                    return;

                bool mainhand = false;

                if (m_CastItem && m_CastItem->GetSlot() == EQUIPMENT_SLOT_MAINHAND)
                    mainhand = true;

                bp = m_caster->GetAttackTime(mainhand ? BASE_ATTACK : OFF_ATTACK) * (GetSpellInfo()->EffectBasePoints[0]+1) / 100000;
                spell_id = 10444;
                break;
            }

            // Flametongue Totem Proc
            if (GetSpellInfo()->SpellFamilyFlags & 0x400000000)
            {
                bp = m_caster->GetAttackTime(BASE_ATTACK) * (GetSpellInfo()->EffectBasePoints[0]+1) / 100000;
                spell_id = 16368;
                break;
            }

            //Shaman Rockbiter Weapon
            if (GetSpellInfo()->SpellFamilyFlags == 0x400000)
            {
                uint32 spell_id = 0;
                switch (GetSpellInfo()->Id)
                {
                    case  8017: spell_id = 36494; break;    // Rank 1
                    case  8018: spell_id = 36750; break;    // Rank 2
                    case  8019: spell_id = 36755; break;    // Rank 3
                    case 10399: spell_id = 36759; break;    // Rank 4
                    case 16314: spell_id = 36763; break;    // Rank 5
                    case 16315: spell_id = 36766; break;    // Rank 6
                    case 16316: spell_id = 36771; break;    // Rank 7
                    case 25479: spell_id = 36775; break;    // Rank 8
                    case 25485: spell_id = 36499; break;    // Rank 9
                    default:
                        sLog.outLog(LOG_DEFAULT, "ERROR: Spell::EffectDummy: Spell %u not handled in RW",GetSpellInfo()->Id);
                        return;
                }

                SpellEntry const *spellInfo = sSpellStore.LookupEntry(spell_id);

                if (!spellInfo)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: WORLD: unknown spell id %i\n", spell_id);
                    return;
                }

                if (m_caster->GetTypeId() != TYPEID_PLAYER)
                    return;

                for (int j = BASE_ATTACK; j <= OFF_ATTACK; ++j)
                {
                    if (Item* item = ((Player*)m_caster)->GetWeaponForAttack(WeaponAttackType(j)))
                    {
                        if (item->IsFitToSpellRequirements(GetSpellInfo()))
                        {
                            Spell *spell = new Spell(m_caster, spellInfo, true);

                            // enchanting spell selected by calculated damage-per-sec in enchanting effect
                            // at calculation applied affect from Elemental Weapons talent
                            // real enchantment damage-1
                            spell->m_currentBasePoints[1] = damage-1;

                            SpellCastTargets targets;
                            targets.setItemTarget(item);
                            spell->prepare(&targets);
                        }
                    }
                }
                return;
            }

            if (GetSpellInfo()->Id == 39610)                    // Mana-Tide Totem effect
            {
                if (!unitTarget || unitTarget->getPowerType() != POWER_MANA)
                    return;

                // Regenerate 6% of Total Mana Every 3 secs
                int32 EffectBasePoints0 = unitTarget->GetMaxPower(POWER_MANA) * damage / 100;
                m_caster->CastCustomSpell(unitTarget,39609,&EffectBasePoints0,NULL,NULL,true,NULL,NULL,m_originalCasterGUID);
                return;
            }

            break;
    }

    //spells triggered by dummy effect should not miss
    if (spell_id)
    {
        SpellEntry const *spellInfo = sSpellStore.LookupEntry(spell_id);

        if (!spellInfo)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: EffectDummy of spell %u: triggering unknown spell id %i\n", GetSpellInfo()->Id, spell_id);
            return;
        }

        Spell* spell = new Spell(m_caster, spellInfo, true, m_originalCasterGUID, NULL, true);
        if (bp) spell->m_currentBasePoints[0] = bp;
        SpellCastTargets targets;
        targets.setUnitTarget(unitTarget);
        spell->prepare(&targets);
    }

    // pet auras
    if (PetAura const* petSpell = sSpellMgr.GetPetAura(GetSpellInfo()->Id))
    {
        m_caster->AddPetAura(petSpell);
        return;
    }

    // Script based implementation. Must be used only for not good for implementation in core spell effects
    // So called only for not proccessed cases
    if (gameObjTarget)
        sScriptMgr.OnEffectDummy(m_caster, GetSpellInfo()->Id, i, gameObjTarget);
    else if (unitTarget && unitTarget->GetTypeId() == TYPEID_UNIT)
        sScriptMgr.OnEffectDummy(m_caster, GetSpellInfo()->Id, i, (Creature*)unitTarget);
    else if (itemTarget)
        sScriptMgr.OnEffectDummy(m_caster, GetSpellInfo()->Id, i, itemTarget);
}

void Spell::EffectTriggerSpellWithValue(uint32 i)
{
    uint32 triggered_spell_id = GetSpellInfo()->EffectTriggerSpell[i];

    // normal case
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(triggered_spell_id);

    if (!spellInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: EffectTriggerSpellWithValue of spell %u: triggering unknown spell id %i\n", GetSpellInfo()->Id,triggered_spell_id);
        return;
    }

    int32 bp = damage;
    m_caster->CastCustomSpell(unitTarget,triggered_spell_id,&bp,&bp,&bp,true,NULL,NULL,m_originalCasterGUID);
}

void Spell::EffectTriggerRitualOfSummoning(uint32 i)
{
    uint32 triggered_spell_id = GetSpellInfo()->EffectTriggerSpell[i];
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(triggered_spell_id);

    if (!spellInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: EffectTriggerRitualOfSummoning of spell %u: triggering unknown spell id %i", GetSpellInfo()->Id,triggered_spell_id);
        return;
    }

    finish();
    Spell *spell = new Spell(m_caster, spellInfo, true);

    SpellCastTargets targets;
    targets.setUnitTarget(unitTarget);
    spell->prepare(&targets);

    m_caster->SetCurrentCastedSpell(spell);
    spell->m_selfContainer = &(m_caster->m_currentSpells[spell->GetCurrentContainer()]);

}

void Spell::EffectForceCast(uint32 i)
{
    if (!unitTarget)
        return;

    uint32 triggered_spell_id = GetSpellInfo()->EffectTriggerSpell[i];

    // normal case
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(triggered_spell_id);

    if (!spellInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: EffectForceCast of spell %u: triggering unknown spell id %i", GetSpellInfo()->Id,triggered_spell_id);
        return;
    }

    unitTarget->CastSpell((Unit*)NULL,spellInfo,true,NULL,NULL,m_originalCasterGUID);
}

void Spell::EffectTriggerSpell(uint32 i)
{
    uint32 triggered_spell_id = GetSpellInfo()->EffectTriggerSpell[i];

    // special cases
    switch (triggered_spell_id)
    {
        //Explosives with self-kill when triggered
        case 3617:
        {
            if (m_caster->GetTypeId() == TYPEID_UNIT)
                m_caster->Kill(m_caster, false);
        }
        // Vanish
        case 18461:
        {
            m_caster->RemoveMovementImpairingAuras();
            m_caster->RemoveSpellsCausingAura(SPELL_AURA_MOD_STALKED);

            // if this spell is given to NPC it must handle rest by it's own AI
            if (m_caster->GetTypeId() != TYPEID_PLAYER)
                return;

            // get highest rank of the Stealth spell
            bool found = false;
            SpellEntry const *spellInfo;
            const PlayerSpellMap& sp_list = ((Player*)m_caster)->GetSpellMap();
            for (PlayerSpellMap::const_iterator itr = sp_list.begin(); itr != sp_list.end(); ++itr)
            {
                // only highest rank is shown in spell book, so simply check if shown in spell book
                if (!itr->second.active || itr->second.disabled || itr->second.state == PLAYERSPELL_REMOVED)
                    continue;

                spellInfo = sSpellStore.LookupEntry(itr->first);
                if (!spellInfo)
                    continue;

                if (spellInfo->SpellFamilyName == SPELLFAMILY_ROGUE && spellInfo->SpellFamilyFlags & SPELLFAMILYFLAG_ROGUE_STEALTH)
                {
                    found=true;
                    break;
                }
            }

            // no Stealth spell found
            if (!found)
                return;

            // reset cooldown on it if needed
            if (((Player*)m_caster)->HasSpellCooldown(spellInfo->Id))
                ((Player*)m_caster)->RemoveSpellCooldown(spellInfo->Id);

            AddTriggeredSpell(spellInfo);
            return;
        }
        // just skip
        case 23770:                                         // Sayge's Dark Fortune of *
        case 47531:                                         // Dismiss Pet handled elsewhere
        case 32186:                                         // Fire Elemental Totem not known effect
        case 32184:                                         // Earth Elemental Totem not known effect
            // not exist, common cooldown can be implemented in scripts if need.
            return;
        // Brittle Armor - (need add max stack of 24575 Brittle Armor)
        case 29284:
        {
            const SpellEntry *spell = sSpellStore.LookupEntry(24575);
            if (!spell)
                return;

            for (int j = 0; j < spell->StackAmount; ++j)
                m_caster->CastSpell(unitTarget,spell->Id, true, m_CastItem, NULL, m_originalCasterGUID);
            return;
        }
        // Mercurial Shield - (need add max stack of 26464 Mercurial Shield)
        case 29286:
        {
            const SpellEntry *spell = sSpellStore.LookupEntry(26464);
            if (!spell)
                return;

            for (int j = 0; j < spell->StackAmount; ++j)
                m_caster->CastSpell(unitTarget,spell->Id, true, m_CastItem, NULL, m_originalCasterGUID);
            return;
        }
        // Righteous Defense
        case 31980:
        {
            m_caster->CastSpell(unitTarget, 31790, true,m_CastItem,NULL,m_originalCasterGUID);
            return;
        }
        // Unstable Mushroom Primer
        case 35256:
            triggered_spell_id = 35362;
            break;
        // Cloak of Shadows
        case 35729 :
        {
            uint32 dispelMask = SpellMgr::GetDispellMask(DISPEL_ALL);
            Unit::AuraMap& Auras = m_caster->GetAuras();
            for (Unit::AuraMap::iterator iter = Auras.begin(); iter != Auras.end(); ++iter)
            {
                // remove all harmful spells on you...
                SpellEntry const* spell = iter->second->GetSpellProto();
                if ((spell->DmgClass == SPELL_DAMAGE_CLASS_MAGIC // only affect magic spells
                    || ((1<<spell->Dispel) & dispelMask))
                    // ignore positive and passive auras
                    && !iter->second->IsPositive() && !iter->second->IsPassive() && spell->SchoolMask != SPELL_SCHOOL_MASK_NORMAL)
                {
                    m_caster->RemoveAurasDueToSpell(spell->Id);
                    iter = Auras.begin();
                }
            }
            return;
        }
        // Priest Shadowfiend (34433) need apply mana gain trigger aura on pet
        case 41967:
        {
            if (Unit *pet = m_caster->GetPet())
                pet->CastSpell(pet, 28305, true);
            return;
        }
        // Support for quest To Legion Hold
        case 37492:
        {
            std::list<Creature*> pList;
            Looking4group::AllCreaturesOfEntryInRange u_check(m_caster, 21633, 70.0f);
            Looking4group::ObjectListSearcher<Creature, Looking4group::AllCreaturesOfEntryInRange> searcher(pList, u_check);

            Cell::VisitAllObjects(m_caster, searcher, 70.0f);

            if (pList.size() == 0)
            {
                if (Creature * summon = m_caster->SummonCreature(21633, -3361, 2962, 170, 5.83, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000))
                    summon->setActive(true);
            }
            return;
        }
        // Desperate Defense (self root)
        case 33897:
        {
            m_caster->CastSpell(m_caster, 33356, true, NULL, NULL, m_originalCasterGUID);
            return;
        }
        // Electrical Storm
        case 43657:
        {
            int32 damage = 800;
            if (m_caster->HasAura(43648, 1))
            {
                uint32 tick = 0;
                if (Aura* Aur = m_caster->GetAura(43648, 1))
                {
                    tick = Aur->GetTickNumber();
                    // FIXME: disable last tick damage until we find easy way to remove from
                    // target list players within eye of the storm;
                    // If not in eye of the storm all should be dead before anyway ;]
                    if (tick == 8)
                        damage = 0;
                    else
                        damage = urand(800, 1200)*tick;
                }
            }
            m_caster->CastCustomSpell((Unit*)NULL, triggered_spell_id, &damage, NULL, NULL, true, m_CastItem, NULL, m_originalCasterGUID);
            return;
        }
        // Activate Crystal Ward
        case 44969:
            unitTarget = m_caster;
            break;
        // Self Repair
        case 44994:
            if(100*unitTarget->GetHealth()/unitTarget->GetMaxHealth() > 70)
                return;
            break;
        // Explosion from Flame Wreath (Shade of Aran)
        case 29950:
            m_caster->RemoveAurasDueToSpell(29947);
            return;
    }

    // normal case
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(triggered_spell_id);

    if (!spellInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: EffectTriggerSpell of spell %u: triggering unknown spell id %i", GetSpellInfo()->Id,triggered_spell_id);
        return;
    }

    // some triggered spells require specific equipment
    if (spellInfo->EquippedItemClass >=0 && m_caster->GetTypeId()==TYPEID_PLAYER)
    {
        // main hand weapon required
        if (spellInfo->AttributesEx3 & SPELL_ATTR_EX3_MAIN_HAND)
        {
            Item* item = ((Player*)m_caster)->GetWeaponForAttack(BASE_ATTACK);

            // skip spell if no weapon in slot or broken
            if (!item || item->IsBroken())
                return;

            // skip spell if weapon not fit to triggered spell
            if (!item->IsFitToSpellRequirements(spellInfo))
                return;
        }

        // offhand hand weapon required
        if (spellInfo->AttributesEx3 & SPELL_ATTR_EX3_REQ_OFFHAND)
        {
            Item* item = ((Player*)m_caster)->GetWeaponForAttack(OFF_ATTACK);

            // skip spell if no weapon in slot or broken
            if (!item || item->IsBroken())
                return;

            // skip spell if weapon not fit to triggered spell
            if (!item->IsFitToSpellRequirements(spellInfo))
                return;
        }
    }

    // some triggered spells must be casted instantly (for example, if next effect case instant kill caster)
    /*bool instant = false;
    for (uint32 j = i+1; j < 3; ++j)
    {
        if (GetSpellInfo()->EffectImplicitTargetA[j] == TARGET_UNIT_CASTER
            && (GetSpellInfo()->Effect[j]==SPELL_EFFECT_INSTAKILL))
        {
            instant = true;
            break;
        }
    }
    */

    if (unitTarget)
        m_caster->CastSpell(unitTarget, spellInfo, true, m_CastItem, NULL, m_originalCasterGUID);
}

void Spell::EffectTriggerMissileSpell(uint32 effect_idx)
{
    uint32 triggered_spell_id = GetSpellInfo()->EffectTriggerSpell[effect_idx];

    // normal case
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(triggered_spell_id);

    if (!spellInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: EffectTriggerMissileSpell of spell %u (eff: %u): triggering unknown spell id %u",
            GetSpellInfo()->Id,effect_idx,triggered_spell_id);
        return;
    }

    if (m_CastItem)
        DEBUG_LOG("WORLD: cast Item spellId - %i", spellInfo->Id);

    // some triggered spells require specific equipment
    if (spellInfo->EquippedItemClass >=0 && m_caster->GetTypeId()==TYPEID_PLAYER)
    {
        // main hand weapon required
        if (spellInfo->AttributesEx3 & SPELL_ATTR_EX3_MAIN_HAND)
        {
            Item* item = ((Player*)m_caster)->GetWeaponForAttack(BASE_ATTACK);

            // skip spell if no weapon in slot or broken
            if (!item || item->IsBroken())
                return;

            // skip spell if weapon not fit to triggered spell
            if (!item->IsFitToSpellRequirements(spellInfo))
                return;
        }

        // offhand hand weapon required
        if (spellInfo->AttributesEx3 & SPELL_ATTR_EX3_REQ_OFFHAND)
        {
            Item* item = ((Player*)m_caster)->GetWeaponForAttack(OFF_ATTACK);

            // skip spell if no weapon in slot or broken
            if (!item || item->IsBroken())
                return;

            // skip spell if weapon not fit to triggered spell
            if (!item->IsFitToSpellRequirements(spellInfo))
                return;
        }
    }

    Spell *spell = new Spell(m_caster, spellInfo, true, m_originalCasterGUID);

    SpellCastTargets targets;

    if (!spellInfo->IsDestTargetEffect(effect_idx))
//    if (triggered_spell_id == 44008)     // Static Disruption needs direct targeting
        targets.setUnitTarget(unitTarget);
    else
        targets.setDestination(m_targets.m_destX,m_targets.m_destY,m_targets.m_destZ);

    spell->m_CastItem = m_CastItem;
    spell->prepare(&targets, NULL);
}

void Spell::EffectTeleportUnits(uint32 i)
{
    if (!unitTarget || unitTarget->IsTaxiFlying())
        return;

    // If not exist data for dest location - return
    if (!m_targets.HasDst())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Spell::EffectTeleportUnits - does not have destination for spell ID %u\n", GetSpellInfo()->Id);
        return;
    }
    // Init dest coordinates
    int32 mapid = m_targets.m_mapId;
    if (mapid < 0)
        mapid = (int32)unitTarget->GetMapId();

    Position dest;
    dest.x = m_targets.m_destX;
    dest.y = m_targets.m_destY;
    dest.z = m_targets.m_destZ;
    dest.o = m_targets.m_orientation;

    if(dest.o < 0)
        dest.o = m_targets.getUnitTarget() ? m_targets.getUnitTarget()->GetOrientation() : unitTarget->GetOrientation();
    sLog.outDebug("Spell::EffectTeleportUnits - teleport unit to %u %f %f %f\n", mapid, dest.x, dest.y, dest.z);
    // Get not in LOS position
    if (m_targets.getUnitTarget() && m_targets.getUnitTarget() != unitTarget)
    {
        if (!m_targets.getUnitTarget()->IsWithinLOS(dest.x, dest.y, dest.z))
             m_targets.getUnitTarget()->GetPosition(dest);
    }
    // Teleport
    if (mapid == unitTarget->GetMapId())
        unitTarget->NearTeleportTo(dest.x, dest.y, dest.z, dest.o, unitTarget == m_caster);
    else if (unitTarget->GetTypeId() == TYPEID_PLAYER)
        ((Player*)unitTarget)->TeleportTo(mapid, dest.x, dest.y, dest.z, dest.o, unitTarget == m_caster ? TELE_TO_SPELL : 0);

    // post effects for TARGET_DST_DB
    switch (GetSpellInfo()->Id)
    {
        // Dimensional Ripper - Everlook
        case 23442:
        {
          int32 r = irand(0, 119);
            if (r >= 70)                                  // 7/12 success
            {
                if (r < 100)                              // 4/12 evil twin
                    m_caster->CastSpell(m_caster,23445,true);
                else                                        // 1/12 fire
                    m_caster->CastSpell(m_caster,23449,true);
            }
            return;
        }
        // Ultrasafe Transporter: Toshley's Station
        case 36941:
        {
            if (roll_chance_i(50))                        // 50% success
            {
              int32 rand_eff = urand(1,7);
                switch (rand_eff)
                {
                    case 1:
                        // soul split - evil
                        m_caster->CastSpell(m_caster,36900,true);
                        break;
                    case 2:
                        // soul split - good
                        m_caster->CastSpell(m_caster,36901,true);
                        break;
                    case 3:
                        // Increase the size
                        m_caster->CastSpell(m_caster,36895,true);
                        break;
                    case 4:
                        // Decrease the size
                        m_caster->CastSpell(m_caster,36893,true);
                        break;
                    case 5:
                    // Transform
                    {
                        if (((Player*)m_caster)->GetTeam() == ALLIANCE)
                            m_caster->CastSpell(m_caster,36897,true);
                        else
                            m_caster->CastSpell(m_caster,36899,true);
                        break;
                    }
                    case 6:
                        // chicken
                        m_caster->CastSpell(m_caster,36940,true);
                        break;
                    case 7:
                        // evil twin
                        m_caster->CastSpell(m_caster,23445,true);
                        break;
                }
            }
            return;
        }
        // Dimensional Ripper - Area 52
        case 36890:
        {
            if (roll_chance_i(50))                        // 50% success
            {
              int32 rand_eff = urand(1,4);
                switch (rand_eff)
                {
                    case 1:
                        // soul split - evil
                        m_caster->CastSpell(m_caster,36900,true);
                        break;
                    case 2:
                        // soul split - good
                        m_caster->CastSpell(m_caster,36901,true);
                        break;
                    case 3:
                        // Increase the size
                        m_caster->CastSpell(m_caster,36895,true);
                        break;
                    case 4:
                    // Transform
                    {
                        if (((Player*)m_caster)->GetTeam() == ALLIANCE)
                            m_caster->CastSpell(m_caster,36897,true);
                        else
                            m_caster->CastSpell(m_caster,36899,true);
                        break;
                    }
                }
            }
            return;
        }
        // Teleport: Spectral Realm - also teleport pets
        case 46019:
        {
            if(unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;
            if(Pet* targets_pet = unitTarget->GetPet())
                targets_pet->CastSpell(targets_pet, 46019, true);
            return;
        }
    }
}

void Spell::EffectApplyAura(uint32 i)
{
    if (!unitTarget)
        return;

    // what the fuck is done here? o.O
    SpellEntry const* spellInfo = sSpellStore.LookupEntry(GetSpellInfo()->Id);
    if (!spellInfo)
        return;

    SpellImmuneList const& list = unitTarget->m_spellImmune[IMMUNITY_STATE];
    for (SpellImmuneList::const_iterator itr = list.begin(); itr != list.end(); ++itr)
        if (itr->type == spellInfo->EffectApplyAuraName[i])
            return;

    // ghost spell check, allow apply any auras at player loading in ghost mode (will be cleanup after load)
    if (!unitTarget->isAlive() && spellInfo->Id != 20584 && spellInfo->Id != 8326 &&
        (unitTarget->GetTypeId()!=TYPEID_PLAYER || !((Player*)unitTarget)->GetSession()->PlayerLoading()))
        return;
        
      // hacky GCD for Black Hole Effect dummy aura

    if (spellInfo->Id == 46230 && unitTarget->HasAura(46230, 2))
    {
        if(Aura* aur = unitTarget->GetAura(46230, 2))
            if(aur->GetAuraDuration() >= 3400)
                return;
    }

    Unit* caster = m_originalCasterGUID ? m_originalCaster : m_caster;
    if (!caster)
        return;

    sLog.outDebug("Spell: Aura is: %u", spellInfo->EffectApplyAuraName[i]);

    Aura* Aur = CreateAura(spellInfo, i, &damage, unitTarget, caster, m_CastItem);

    // Now Reduce spell duration using data received at spell hit
    int32 duration = Aur->GetAuraMaxDuration();
    if (!SpellMgr::IsPositiveSpell(spellInfo->Id))
    {
        if (unitTarget != caster || !SpellMgr::IsChanneledSpell(spellInfo))
        {
            unitTarget->ApplyDiminishingToDuration(m_diminishGroup,duration,caster,m_diminishLevel, spellInfo);
            Aur->setDiminishGroup(m_diminishGroup);
        }
    }

    //mod duration of channeled aura by spell haste
    if (SpellMgr::IsChanneledSpell(spellInfo))
    {
        caster->ModSpellCastTime(spellInfo, duration, this);
        SendChannelStart(duration);
    }

    // if Aura removed and deleted, do not continue.
    if (duration== 0 && !(Aur->IsPermanent()))
    {
        delete Aur;
        return;
    }

    if (duration != Aur->GetAuraMaxDuration())
    {
        Aur->SetAuraMaxDuration(duration);
        Aur->SetAuraDuration(duration);
    }

    bool added = unitTarget->AddAura(Aur);

    // Aura not added and deleted in AddAura call;
    if (!added)
        return;

    // found crash at character loading, broken pointer to Aur...
    // Aur was deleted in AddAura()...
    if (!Aur)
        return;

    // TODO Make a way so it works for every related spell!
    if (unitTarget->GetTypeId()==TYPEID_PLAYER ||(unitTarget->GetTypeId()==TYPEID_UNIT && ((Creature*)unitTarget)->isPet()))              // Negative buff should only be applied on players
    {
        uint32 spellId = 0;
        if (spellInfo->CasterAuraStateNot==AURA_STATE_WEAKENED_SOUL || spellInfo->TargetAuraStateNot==AURA_STATE_WEAKENED_SOUL)
            spellId = 6788;                                 // Weakened Soul
        else if (spellInfo->CasterAuraStateNot==AURA_STATE_FORBEARANCE || spellInfo->TargetAuraStateNot==AURA_STATE_FORBEARANCE)
            spellId = 25771;                                // Forbearance
        else if (spellInfo->CasterAuraStateNot==AURA_STATE_HYPOTHERMIA)
            spellId = 41425;                                // Hypothermia
        else if (spellInfo->Mechanic == MECHANIC_BANDAGE) // Bandages
            spellId = 11196;                                // Recently Bandaged
        else if ((spellInfo->AttributesEx & 0x20) && (spellInfo->AttributesEx2 & 0x20000))
            spellId = 23230;                                // Blood Fury - Healing Reduction

        SpellEntry const *AdditionalSpellInfo = sSpellStore.LookupEntry(spellId);
        if (AdditionalSpellInfo)
        {
            // applied at target by target
            Aura* AdditionalAura = CreateAura(AdditionalSpellInfo, 0, NULL, unitTarget,unitTarget, 0);
            unitTarget->AddAura(AdditionalAura);
            sLog.outDebug("Spell: Additional Aura is: %u", AdditionalSpellInfo->EffectApplyAuraName[0]);
        }
    }

    // Prayer of Mending (jump animation), we need formal caster instead original for correct animation
    if (spellInfo->SpellFamilyName == SPELLFAMILY_PRIEST && (spellInfo->SpellFamilyFlags & 0x00002000000000LL))
        m_caster->CastSpell(unitTarget, 41637, true, NULL, Aur, m_originalCasterGUID);

   
    if ((spellInfo->SpellFamilyName==SPELLFAMILY_MAGE) && (spellInfo->SpellFamilyFlags & 0x1000000))
    {
        m_caster->SetInCombatWith(unitTarget);
        unitTarget->SetInCombatWith(m_caster);
        unitTarget->AddThreat(m_caster, 0.0f);
    }
}

void Spell::EffectUnlearnSpecialization(uint32 i)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    Player *_player = (Player*)unitTarget;
    uint32 spellToUnlearn = GetSpellInfo()->EffectTriggerSpell[i];

    _player->removeSpell(spellToUnlearn);

    sLog.outDebug("Spell: Player %u have unlearned spell %u from NpcGUID: %u", _player->GetGUIDLow(), spellToUnlearn, m_caster->GetGUIDLow());
}

void Spell::EffectPowerDrain(uint32 i)
{
    if (GetSpellInfo()->EffectMiscValue[i] < 0 || GetSpellInfo()->EffectMiscValue[i] >= MAX_POWERS)
        return;

    Powers drain_power = Powers(GetSpellInfo()->EffectMiscValue[i]);

    if (!unitTarget)
        return;
    if (!unitTarget->isAlive())
        return;
    if (unitTarget->getPowerType() != drain_power)
        return;
    if (damage < 0)
        return;

    uint32 curPower = unitTarget->GetPower(drain_power);

    //add spell damage bonus
    damage=m_caster->SpellDamageBonus(unitTarget,GetSpellInfo(),uint32(damage),SPELL_DIRECT_DAMAGE);

    // resilience reduce mana draining effect at spell crit damage reduction (added in 2.4)
    uint32 power = damage;
    if (drain_power == POWER_MANA && unitTarget->GetTypeId() == TYPEID_PLAYER)
        power -= ((Player*)unitTarget)->GetSpellCritDamageReduction(power);

    int32 new_damage;
    if (curPower < power)
        new_damage = curPower;
    else
        new_damage = power;

    unitTarget->ModifyPower(drain_power,-new_damage);

    if (drain_power == POWER_MANA)
    {
        float manaMultiplier = GetSpellInfo()->EffectMultipleValue[i];
        if (manaMultiplier==0)
            manaMultiplier = 1;

        if (Player *modOwner = m_caster->GetSpellModOwner())
            modOwner->ApplySpellMod(GetSpellInfo()->Id, SPELLMOD_MULTIPLE_VALUE, manaMultiplier);

        int32 gain = int32(new_damage*manaMultiplier);

        m_caster->ModifyPower(POWER_MANA,gain);
        //send log
        m_caster->SendEnergizeSpellLog(m_caster, GetSpellInfo()->Id,gain,POWER_MANA);
    }
}

void Spell::EffectSendEvent(uint32 EffectIndex)
{
    switch (GetSpellInfo()->Id)
    {
        // Summon Arcane Elemental
        case 40134:
        {
            if (m_caster->GetTypeId() == TYPEID_UNIT)
            {
                if (Unit* Arcane = m_caster->SummonCreature(23100, -2469.59, 4700.71, 155.86, 3.15, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 300000))
                    Arcane->setFaction(35);
            }
            break;
        }
        // Summon Infernals
        // TO-DO now the event is handled in stair_of_destiny.cpp
        //case 33393: { break; }
        // Place Belmara's Tome
        case 34140:
        {
            if (m_caster->GetTypeId() != TYPEID_PLAYER)
                return;

            if (Creature *pBelmara = m_caster->SummonCreature(19546, m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ(), 3.15, TEMPSUMMON_TIMED_DESPAWN, 10000))
            {
                pBelmara->setFaction(35);
                pBelmara->MonsterSay("I can't sleep without a good bedtime story. Now I'm cerain to rest well.", LANG_UNIVERSAL, 0);

                ((Player*)m_caster)->CastedCreatureOrGO(19547, pBelmara->GetGUID(), GetSpellInfo()->Id);
            }
            break;
        }
        // Place Luminrath's Mantle
        case 34142:
        {
            if (m_caster->GetTypeId() != TYPEID_PLAYER)
                return;

            if (Creature *pLuminrath = m_caster->SummonCreature(19580, m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ(), 3.15, TEMPSUMMON_TIMED_DESPAWN, 10000))
            {
                pLuminrath->setFaction(35);
                pLuminrath->MonsterSay("I can't possibly go out without my cloak. I hope it's in here...", LANG_UNIVERSAL, 0);

                ((Player*)m_caster)->CastedCreatureOrGO(19548, pLuminrath->GetGUID(), GetSpellInfo()->Id);
            }
            break;
        }
        // Place Cohlien's Hat
        case 34144:
        {
            if (m_caster->GetTypeId() != TYPEID_PLAYER)
                return;

            if (Creature *pCohlien = m_caster->SummonCreature(19579, m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ(), 3.15, TEMPSUMMON_TIMED_DESPAWN, 10000))
            {
                pCohlien->setFaction(35);
                pCohlien->MonsterSay("Phew! There's my lucky hat. I've been looking for it everywhere.", LANG_UNIVERSAL, 0);

                ((Player*)m_caster)->CastedCreatureOrGO(19550, pCohlien->GetGUID(), GetSpellInfo()->Id);
            }
            break;
        }
        // Place Dathric's Blade
        case 34141:
        {
            if (m_caster->GetTypeId() != TYPEID_PLAYER)
                return;

            if (Creature *pDathric = m_caster->SummonCreature(19543, m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ(), 3.15, TEMPSUMMON_TIMED_DESPAWN, 10000))
            {
                pDathric->setFaction(35);
                pDathric->MonsterSay("I don't know what I was thinking, going out without my sword. I would've put it on if I'd seen it here...", LANG_UNIVERSAL, 0);

                ((Player*)m_caster)->CastedCreatureOrGO(19549, pDathric->GetGUID(), GetSpellInfo()->Id);
            }
            break;
        }
    }

    if (m_caster->GetTypeId() == TYPEID_PLAYER && ((Player*)m_caster)->InBattleGround())
    {
        BattleGround* bg = ((Player *)m_caster)->GetBattleGround();
        if (bg && bg->GetStatus() == STATUS_IN_PROGRESS)
        {
            switch (GetSpellInfo()->Id)
            {
                case 23333:                                 // Pickup Horde Flag
                    /*do not uncomment .
                    if (bg->GetTypeID()==BATTLEGROUND_WS)
                        bg->EventPlayerClickedOnFlag((Player*)m_caster, gameObjTarget);
                    sLog.outDebug("Send Event Horde Flag Picked Up");
                    break;
                    /* not used :
                    case 23334:                                 // Drop Horde Flag
                        if (bg->GetTypeID()==BATTLEGROUND_WS)
                            bg->EventPlayerDroppedFlag((Player*)m_caster);
                        sLog.outDebug("Drop Horde Flag");
                        break;
                    */
                case 23335:                                 // Pickup Alliance Flag
                    /*do not uncomment ... (it will cause crash, because of null targetobject!) anyway this is a bad way to call that event, because it would cause recursion
                    if (bg->GetTypeID()==BATTLEGROUND_WS)
                        bg->EventPlayerClickedOnFlag((Player*)m_caster, gameObjTarget);
                    sLog.outDebug("Send Event Alliance Flag Picked Up");
                    break;
                    /* not used :
                    case 23336:                                 // Drop Alliance Flag
                        if (bg->GetTypeID()==BATTLEGROUND_WS)
                            bg->EventPlayerDroppedFlag((Player*)m_caster);
                        sLog.outDebug("Drop Alliance Flag");
                        break;
                    case 23385:                                 // Alliance Flag Returns
                        if (bg->GetTypeID()==BATTLEGROUND_WS)
                            bg->EventPlayerClickedOnFlag((Player*)m_caster, gameObjTarget);
                        sLog.outDebug("Alliance Flag Returned");
                        break;
                    case 23386:                                   // Horde Flag Returns
                        if (bg->GetTypeID()==BATTLEGROUND_WS)
                            bg->EventPlayerClickedOnFlag((Player*)m_caster, gameObjTarget);
                        sLog.outDebug("Horde Flag Returned");
                        break;*/
                case 34976:
                    /*
                    if (bg->GetTypeID()==BATTLEGROUND_EY)
                        bg->EventPlayerClickedOnFlag((Player*)m_caster, gameObjTarget);
                    */
                    break;
                default:
                    sLog.outDebug("Unknown spellid %u in BG event", GetSpellInfo()->Id);
                    break;
            }
        }
    }
    sLog.outDebug("Spell ScriptStart %u for spellid %u in EffectSendEvent ", GetSpellInfo()->EffectMiscValue[EffectIndex], GetSpellInfo()->Id);
    if (!sScriptMgr.OnProcessEvent(GetSpellInfo()->EffectMiscValue[EffectIndex], m_caster, focusObject, true))
        m_caster->GetMap()->ScriptsStart(sEventScripts, GetSpellInfo()->EffectMiscValue[EffectIndex], m_caster, focusObject);
}

void Spell::EffectPowerBurn(uint32 i)
{
    if (GetSpellInfo()->EffectMiscValue[i] < 0 || GetSpellInfo()->EffectMiscValue[i] >= MAX_POWERS)
        return;

    Powers powertype = Powers(GetSpellInfo()->EffectMiscValue[i]);

    if (!unitTarget)
        return;
    if (!unitTarget->isAlive())
        return;
    if (unitTarget->getPowerType()!=powertype)
        return;
    if (damage < 0)
        return;

    int32 curPower = int32(unitTarget->GetPower(powertype));

    // resilience reduce mana draining effect at spell crit damage reduction (added in 2.4)
    uint32 power = damage;
    if (powertype == POWER_MANA && unitTarget->GetTypeId() == TYPEID_PLAYER)
        power -= ((Player*)unitTarget)->GetSpellCritDamageReduction(power);

    int32 new_damage = (curPower < power) ? curPower : power;

    unitTarget->ModifyPower(powertype,-new_damage);
    float multiplier = GetSpellInfo()->EffectMultipleValue[i];

    if (Player *modOwner = m_caster->GetSpellModOwner())
        modOwner->ApplySpellMod(GetSpellInfo()->Id, SPELLMOD_MULTIPLE_VALUE, multiplier);

    new_damage = int32(new_damage*multiplier);
    //m_damage+=new_damage; should not apply spell bonus
    //TODO: no log
    //unitTarget->ModifyHealth(-new_damage);
    if (m_originalCaster)
        m_damage = new_damage;
        //m_originalCaster->DealDamage(unitTarget, new_damage);
}

void Spell::EffectHeal(uint32 /*i*/)
{
}

void Spell::SpellDamageHeal(uint32 /*i*/)
{
    if (unitTarget && unitTarget->isAlive() && damage >= 0)
    {
        // Try to get original caster
        Unit *caster = m_originalCasterGUID ? m_originalCaster : m_caster;

        // Skip if m_originalCaster not available
        if (!caster)
            return;

        int32 addhealth = damage;

        // Vessel of the Naaru (Vial of the Sunwell trinket)
        if (GetSpellInfo()->Id == 45064)
        {
            // Amount of heal - depends from stacked Holy Energy
            int damageAmount = 0;
            Unit::AuraList const& mDummyAuras = m_caster->GetAurasByType(SPELL_AURA_DUMMY);
            for (Unit::AuraList::const_iterator i = mDummyAuras.begin();i != mDummyAuras.end(); ++i)
                if ((*i)->GetId() == 45062)
                    damageAmount+=(*i)->GetModifierValue();
            if (damageAmount)
                m_caster->RemoveAurasDueToSpell(45062);

            addhealth += damageAmount;
        }
        // Swiftmend - consumes Regrowth or Rejuvenation
        else if (GetSpellInfo()->TargetAuraState == AURA_STATE_SWIFTMEND && unitTarget->HasAuraState(AURA_STATE_SWIFTMEND))
        {
            Unit::AuraList const& RejorRegr = unitTarget->GetAurasByType(SPELL_AURA_PERIODIC_HEAL);
            // find most short by duration
            Aura *targetAura = NULL;
            for (Unit::AuraList::const_iterator i = RejorRegr.begin(); i != RejorRegr.end(); ++i)
            {
                if ((*i)->GetSpellProto()->SpellFamilyName == SPELLFAMILY_DRUID
                    && ((*i)->GetSpellProto()->SpellFamilyFlags == 0x40 || (*i)->GetSpellProto()->SpellFamilyFlags == 0x10))
                {
                    if (!targetAura || (*i)->GetAuraDuration() < targetAura->GetAuraDuration())
                        targetAura = *i;
                }
            }

            if (!targetAura)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Target(GUID:" UI64FMTD ") has aurastate AURA_STATE_SWIFTMEND but no matching aura.", unitTarget->GetGUID());
                return;
            }

            int32 tickheal = targetAura->GetModifierValuePerStack();
            if (Unit* auraCaster = targetAura->GetCaster())
                tickheal = auraCaster->SpellHealingBonus(targetAura->GetSpellProto(), tickheal, DOT, unitTarget);
            //int32 tickheal = targetAura->GetSpellProto()->EffectBasePoints[idx] + 1;
            //It is said that talent bonus should not be included
            //int32 tickheal = targetAura->GetModifierValue();
            int32 tickcount = 0;
            if (targetAura->GetSpellProto()->SpellFamilyName == SPELLFAMILY_DRUID)
            {
                switch (targetAura->GetSpellProto()->SpellFamilyFlags)//TODO: proper spellfamily for 3.0.x
                {
                    case 0x10:  tickcount = 4;  break; // Rejuvenation
                    case 0x40:  tickcount = 6;  break; // Regrowth
                }
            }
            addhealth += tickheal * tickcount;
            unitTarget->RemoveAurasByCasterSpell(targetAura->GetId(), targetAura->GetCasterGUID());

            //addhealth += tickheal * tickcount;
            //addhealth = caster->SpellHealingBonus(GetSpellInfo(), addhealth,HEAL, unitTarget);
        }
        else
            addhealth = caster->SpellHealingBonus(GetSpellInfo(), addhealth,HEAL, unitTarget);

        m_damage -= addhealth;
    }
}

void Spell::EffectHealPct(uint32 /*i*/)
{
    if (unitTarget && unitTarget->isAlive() && damage >= 0)
    {
        // Try to get original caster
        Unit *caster = m_originalCasterGUID ? m_originalCaster : m_caster;

        // Skip if m_originalCaster not available
        if (!caster)
            return;

        uint32 addhealth = unitTarget->GetMaxHealth() * damage / 100;
        caster->SendHealSpellLog(unitTarget, GetSpellInfo()->Id, addhealth, false);

        int32 gain = unitTarget->ModifyHealth(int32(addhealth));
        unitTarget->getHostilRefManager().threatAssist(m_caster, float(gain) * 0.5f, GetSpellInfo());

        if (caster->GetTypeId()==TYPEID_PLAYER)
        {
            if (BattleGround *bg = ((Player*)caster)->GetBattleGround())
                bg->UpdatePlayerScore(((Player*)caster), SCORE_HEALING_DONE, gain);
            if ((Player*)caster->GetMap()->IsRaid() && (Player*)caster->isInCombat())
            {
                if (Unit *boss = ((Player*)caster)->GetNearBossInCombat())
                {
                    std::list<HostilReference*> PlayerList = boss->getThreatManager().getThreatList();
                    for(std::list<HostilReference*>::iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        Unit* pUnit = boss->GetMap()->GetUnit((*i)->getUnitGuid());
                        /*if (pUnit->GetTypeId() == TYPEID_PLAYER)
                            if (pUnit->ToPlayer() == caster)
                                boss->ToCreature()->UpdatePvEScore(((Player*)caster), 1, gain);
                        */
                    }                    
                }
            }
        }
    }
}

void Spell::EffectHealMechanical(uint32 /*i*/)
{
    // Mechanic creature type should be correctly checked by targetCreatureType field
    if (unitTarget && unitTarget->isAlive() && damage >= 0)
    {
        // Try to get original caster
        Unit *caster = m_originalCasterGUID ? m_originalCaster : m_caster;

        // Skip if m_originalCaster not available
        if (!caster)
            return;

        uint32 addhealth = caster->SpellHealingBonus(GetSpellInfo(), uint32(damage), HEAL, unitTarget);
        caster->SendHealSpellLog(unitTarget, GetSpellInfo()->Id, addhealth, false);
        unitTarget->ModifyHealth(int32(damage));
    }
}

void Spell::EffectHealthLeech(uint32 i)
{
    if (!unitTarget)
        return;
    if (!unitTarget->isAlive())
        return;

    if (damage < 0)
        return;

    sLog.outDebug("HealthLeech :%i", damage);

    float multiplier = GetSpellInfo()->EffectMultipleValue[i];
    multiplier = multiplier ? multiplier : 1.0;

    if (Player *modOwner = m_caster->GetSpellModOwner())
        modOwner->ApplySpellMod(GetSpellInfo()->Id, SPELLMOD_MULTIPLE_VALUE, multiplier);

    int32 new_damage = 0;
    uint32 curHealth = unitTarget->GetHealth();
    new_damage = m_caster->SpellNonMeleeDamageLog(unitTarget, GetSpellInfo()->Id, damage, m_IsTriggeredSpell, true);
    if (curHealth < new_damage)
        new_damage = curHealth;

    // multipier only affects gains of HP!
    new_damage = int32(new_damage*multiplier);

    if (m_caster->isAlive())
    {
        new_damage = m_caster->SpellHealingBonus(GetSpellInfo(), new_damage, HEAL, m_caster);

        int32 gain = m_caster->ModifyHealth(new_damage);
        m_caster->getHostilRefManager().threatAssist(m_caster, gain * 0.5f, GetSpellInfo());

        m_caster->SendHealSpellLog(m_caster, GetSpellInfo()->Id, uint32(new_damage));
    }
//    m_healthLeech+=tmpvalue;
//    m_damage+=new_damage;
}

void Spell::DoCreateItem(uint32 i, uint32 itemtype)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* player = (Player*)unitTarget;

    uint32 newitemid = itemtype;
    ItemPrototype const *pProto = ObjectMgr::GetItemPrototype(newitemid);
    if (!pProto)
    {
        player->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, NULL, NULL);
        return;
    }

    uint32 num_to_add;

    // TODO: maybe all this can be replaced by using correct calculated `damage` value
    if (pProto->Class != ITEM_CLASS_CONSUMABLE || GetSpellInfo()->SpellFamilyName != SPELLFAMILY_MAGE)
    {
        num_to_add = damage;
        /*int32 basePoints = m_currentBasePoints[i];
        int32 randomPoints = GetSpellInfo()->EffectDieSides[i];
        if (randomPoints)
            num_to_add = basePoints + irand(1, randomPoints);
        else
            num_to_add = basePoints + 1;*/
    }
    else if (pProto->MaxCount == 1)
        num_to_add = 1;
    else if (player->getLevel() >= GetSpellInfo()->spellLevel)
    {
        num_to_add = damage;
        /*int32 basePoints = m_currentBasePoints[i];
        float pointPerLevel = GetSpellInfo()->EffectRealPointsPerLevel[i];
        num_to_add = basePoints + 1 + uint32((player->getLevel() - GetSpellInfo()->spellLevel)*pointPerLevel);*/
    }
    else
        num_to_add = 2;

    if (num_to_add < 1)
        num_to_add = 1;
    if (num_to_add > pProto->Stackable)
        num_to_add = pProto->Stackable;

    // init items_count to 1, since 1 item will be created regardless of specialization
    int items_count=1;
    // the chance to create additional items
    float additionalCreateChance=0.0f;
    // the maximum number of created additional items
    uint8 additionalMaxNum=0;
    // get the chance and maximum number for creating extra items
    if (canCreateExtraItems(player, GetSpellInfo()->Id, additionalCreateChance, additionalMaxNum))
    {
        // roll with this chance till we roll not to create or we create the max num
        while (roll_chance_f(additionalCreateChance) && items_count<=additionalMaxNum)
            ++items_count;
    }

    // really will be created more items
    num_to_add *= items_count;

    // can the player store the new item?
    ItemPosCountVec dest;
    uint32 no_space = 0;
    uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, newitemid, num_to_add, &no_space);
    if (msg != EQUIP_ERR_OK)
    {
        // convert to possible store amount
        if (msg == EQUIP_ERR_INVENTORY_FULL || msg == EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)
            num_to_add -= no_space;
        else
        {
            // if not created by another reason from full inventory or unique items amount limitation
            player->SendEquipError(msg, NULL, NULL);
            return;
        }
    }

    if (num_to_add)
    {
        // create the new item and store it
        Item* pItem = player->StoreNewItem(dest, newitemid, true, Item::GenerateItemRandomPropertyId(newitemid));

        // was it successful? return error if not
        if (!pItem)
        {
            player->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, NULL, NULL);
            return;
        }

        // set the "Crafted by ..." property of the item
        if (pItem->GetProto()->Class != ITEM_CLASS_CONSUMABLE && pItem->GetProto()->Class != ITEM_CLASS_QUEST)
            pItem->SetUInt32Value(ITEM_FIELD_CREATOR,player->GetGUIDLow());

        // send info to the client
        if (pItem)
            player->SendNewItem(pItem, num_to_add, true, true);

        // we succeeded in creating at least one item, so a levelup is possible
        player->UpdateCraftSkill(GetSpellInfo()->Id);
    }
}

void Spell::EffectCreateItem(uint32 i)
{
    DoCreateItem(i,GetSpellInfo()->EffectItemType[i]);
}

void Spell::EffectPersistentAA(uint32 i)
{
   float radius = SpellMgr::GetSpellRadius(GetSpellInfo(),i,false);
    if (Player* modOwner = m_originalCaster->GetSpellModOwner())
        modOwner->ApplySpellMod(GetSpellInfo()->Id, SPELLMOD_RADIUS, radius);

    Unit *caster = m_caster->GetEntry() == WORLD_TRIGGER ? m_originalCaster : m_caster;
    int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());
    if (Player* modOwner = m_originalCaster->GetSpellModOwner())
        modOwner->ApplySpellMod(GetSpellInfo()->Id, SPELLMOD_DURATION, duration);
    DynamicObject* dynObj = new DynamicObject;
    if (!dynObj->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_DYNAMICOBJECT), caster, GetSpellInfo()->Id, i, m_targets.m_destX, m_targets.m_destY, m_targets.m_destZ, duration, radius))
    {
        delete dynObj;
        return;
    }
    dynObj->SetUInt32Value(OBJECT_FIELD_TYPE, 65);
    //dynObj->SetUInt32Value(DYNAMICOBJECT_BYTES, 0x01eeeeee);
    caster->AddDynObject(dynObj);
    dynObj->GetMap()->Add(dynObj);
}

void Spell::EffectEnergize(uint32 i)
{
    if (!unitTarget || !m_caster)
        return;

    if (!unitTarget->IsInWorld() || !m_caster->IsInWorld())
        return;

    if (!m_caster->IsInMap(unitTarget))
        return;

    if (!unitTarget->isAlive())
        return;

    if (GetSpellInfo()->EffectMiscValue[i] < 0 || GetSpellInfo()->EffectMiscValue[i] >= MAX_POWERS)
        return;

    // Don't energize targets with other power type
    if (unitTarget->getPowerType() != GetSpellInfo()->EffectMiscValue[i])
        return;

    //Serpent Coil Braid
    if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_MAGE && GetSpellInfo()->SpellFamilyFlags == 0x10000000000LL)
        if (unitTarget->HasAura(37447, 0))
            unitTarget->CastSpell(unitTarget,37445,true);

    // Alchemist Stone
    if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_POTION)
        if (Aura *aura = unitTarget->GetAura(17619, 0))
        {
            int32 bp = damage * 4 / 10;
            unitTarget->CastCustomSpell(unitTarget,21400,&bp,NULL,NULL,true,NULL,aura);
        }

    // Some level depends spells
    int multiplier = 0;
    int level_diff = 0;
    switch (GetSpellInfo()->Id)
    {
        // Restore Energy
        case 9512:
            level_diff = m_caster->getLevel() - 40;
            multiplier = 2;
            break;
        // Blood Fury
        case 24571:
            level_diff = m_caster->getLevel() - 60;
            multiplier = 10;
            break;
        // Burst of Energy
        case 24532:
            level_diff = m_caster->getLevel() - 60;
            multiplier = 4;
            break;
        default:
            break;
    }

    if (level_diff > 0)
        damage -= multiplier * level_diff;

    if (damage < 0)
        return;

    Powers power = Powers(GetSpellInfo()->EffectMiscValue[i]);

    if (unitTarget->GetMaxPower(power) == 0)
        return;

    int32 gain = unitTarget->ModifyPower(power,damage);

    //No threat from life tap
    if (GetSpellInfo()->Id != 31818)
        unitTarget->getHostilRefManager().threatAssist(m_caster, float(gain) * 0.5f, GetSpellInfo());

    m_caster->SendEnergizeSpellLog(unitTarget, GetSpellInfo()->Id, damage, power);

    // Mad Alchemist's Potion
    if (GetSpellInfo()->Id == 45051)
    {
        // find elixirs on target
        uint32 elixir_mask = 0;
        Unit::AuraMap& Auras = unitTarget->GetAuras();
        for (Unit::AuraMap::iterator itr = Auras.begin(); itr != Auras.end(); ++itr)
        {
            uint32 spell_id = itr->second->GetId();
            if (uint32 mask = sSpellMgr.GetSpellElixirMask(spell_id))
                elixir_mask |= mask;
        }

        // get available elixir mask any not active type from battle/guardian (and flask if no any)
        elixir_mask = (elixir_mask & ELIXIR_FLASK_MASK) ^ ELIXIR_FLASK_MASK;

        // get all available elixirs by mask and spell level
        std::vector<uint32> elixirs;
        SpellElixirMap const& m_spellElixirs = sSpellMgr.GetSpellElixirMap();
        for (SpellElixirMap::const_iterator itr = m_spellElixirs.begin(); itr != m_spellElixirs.end(); ++itr)
        {
            if (itr->second & elixir_mask)
            {
                if (itr->second & (ELIXIR_UNSTABLE_MASK | ELIXIR_SHATTRATH_MASK))
                    continue;

                SpellEntry const *spellInfo = sSpellStore.LookupEntry(itr->first);
                if (spellInfo && (spellInfo->spellLevel < GetSpellInfo()->spellLevel || spellInfo->spellLevel > unitTarget->getLevel()))
                    continue;

                elixirs.push_back(itr->first);
            }
        }

        if (!elixirs.empty())
        {
            // cast random elixir on target
            uint32 rand_spell = urand(0,elixirs.size()-1);
            m_caster->CastSpell(unitTarget,elixirs[rand_spell],true,m_CastItem);
        }
    }
}

void Spell::EffectEnergisePct(uint32 i)
{
    if (!unitTarget)
        return;
    if (!unitTarget->isAlive())
        return;

    if (GetSpellInfo()->EffectMiscValue[i] < 0 || GetSpellInfo()->EffectMiscValue[i] >= MAX_POWERS)
        return;

    Powers power = Powers(GetSpellInfo()->EffectMiscValue[i]);

    uint32 maxPower = unitTarget->GetMaxPower(power);
    if (maxPower == 0)
        return;

    uint32 gain = damage * maxPower / 100;
    int32 realGain = unitTarget->ModifyPower(power, gain);
    unitTarget->getHostilRefManager().threatAssist(m_caster, float(realGain) * 0.5f, GetSpellInfo());
    m_caster->SendEnergizeSpellLog(unitTarget, GetSpellInfo()->Id, realGain, power);
}


void Spell::EffectOpenLock(uint32 effIndex)
{
    if (!m_caster || m_caster->GetTypeId() != TYPEID_PLAYER)
    {
        sLog.outDebug("WORLD: Open Lock - No Player Caster!");
        return;
    }

    Player* player = (Player*)m_caster;

    uint32 lockId = 0;
    uint64 guid = 0;

    // Get lockId
    if (gameObjTarget)
    {
        GameObjectInfo const* goInfo = gameObjTarget->GetGOInfo();
        // Arathi Basin banner opening !
        if (goInfo->type == GAMEOBJECT_TYPE_BUTTON && goInfo->button.noDamageImmune ||
            goInfo->type == GAMEOBJECT_TYPE_GOOBER && goInfo->goober.losOK)
        {
            //isAllowUseBattleGroundObject() already called in CheckCast()
            // in battleground check
            if (BattleGround *bg = player->GetBattleGround())
            {
                // check if it's correct bg
                if (bg->GetTypeID() == BATTLEGROUND_AB || bg->GetTypeID() == BATTLEGROUND_AV)
                    bg->EventPlayerClickedOnFlag(player, gameObjTarget);
                return;
            }
        }
        else if (goInfo->type == GAMEOBJECT_TYPE_FLAGSTAND)
        {
            //isAllowUseBattleGroundObject() already called in CheckCast()
            // in battleground check
            if (BattleGround *bg = player->GetBattleGround())
            {
                if (bg->GetTypeID() == BATTLEGROUND_EY)
                    bg->EventPlayerClickedOnFlag(player, gameObjTarget);
                return;
            }
        }
        // handle outdoor pvp object opening, return true if go was registered for handling
        // these objects must have been spawned by outdoorpvp!
        else if (gameObjTarget->GetGOInfo()->type == GAMEOBJECT_TYPE_GOOBER && sOutdoorPvPMgr.HandleOpenGo(player, gameObjTarget->GetGUID()))
            return;
        lockId = gameObjTarget->GetLockId();
        guid = gameObjTarget->GetGUID();
    }
    else if (itemTarget)
    {
        lockId = itemTarget->GetProto()->LockID;
        guid = itemTarget->GetGUID();
    }
    else
    {
        sLog.outDebug("WORLD: Open Lock - No GameObject/Item Target!");
        return;
    }

    SkillType skillId = SKILL_NONE;
    int32 reqSkillValue = 0;
    int32 skillValue;

    SpellCastResult res = CanOpenLock(effIndex, lockId, skillId, reqSkillValue, skillValue);
    if (res != SPELL_CAST_OK)
    {
        SendCastResult(res);
        return;
    }

    if (gameObjTarget)
        gameObjTarget->Use(m_caster);
    else
        player->SendLoot(guid, LOOT_SKINNING);

    // not allow use skill grow at item base open
    if(!m_CastItem && skillId != SKILL_NONE)
    {
        // update skill if really known
        if (uint32 pureSkillValue = player->GetPureSkillValue(skillId))
        {
            if (gameObjTarget)
            {
                // Allow one skill-up until respawned
                if (!gameObjTarget->IsInSkillupList(player->GetGUIDLow()) &&
                    player->UpdateGatherSkill(skillId, pureSkillValue, reqSkillValue))
                    gameObjTarget->AddToSkillupList(player->GetGUIDLow());
            }
            else if (itemTarget)
            {
                // Do one skill-up
                player->UpdateGatherSkill(skillId, pureSkillValue, reqSkillValue);
            }
        }
    }
}

void Spell::EffectSummonChangeItem(uint32 i)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player *player = (Player*)m_caster;

    // applied only to using item
    if (!m_CastItem)
        return;

    // ... only to item in own inventory/bank/equip_slot
    if (m_CastItem->GetOwnerGUID()!=player->GetGUID())
        return;

    uint32 newitemid = GetSpellInfo()->EffectItemType[i];
    if (!newitemid)
        return;

    uint16 pos = m_CastItem->GetPos();

    Item *pNewItem = Item::CreateItem(newitemid, 1, player);
    if (!pNewItem)
        return;

    for (uint8 j = PERM_ENCHANTMENT_SLOT; j <= TEMP_ENCHANTMENT_SLOT; ++j)
    {
        if (m_CastItem->GetEnchantmentId(EnchantmentSlot(j)))
            pNewItem->SetEnchantment(EnchantmentSlot(j), m_CastItem->GetEnchantmentId(EnchantmentSlot(j)), m_CastItem->GetEnchantmentDuration(EnchantmentSlot(j)), m_CastItem->GetEnchantmentCharges(EnchantmentSlot(j)));
    }

    if (m_CastItem->GetUInt32Value(ITEM_FIELD_DURABILITY) < m_CastItem->GetUInt32Value(ITEM_FIELD_MAXDURABILITY))
    {
        double loosePercent = 1 - m_CastItem->GetUInt32Value(ITEM_FIELD_DURABILITY) / double(m_CastItem->GetUInt32Value(ITEM_FIELD_MAXDURABILITY));
        player->DurabilityLoss(pNewItem, loosePercent);
    }

    if (player->IsInventoryPos(pos))
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(), dest, pNewItem, true);
        if (msg == EQUIP_ERR_OK)
        {
            player->DestroyItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(),true);

            // prevent crash at access and unexpected charges counting with item update queue corrupt
            if (m_CastItem==m_targets.getItemTarget())
                m_targets.setItemTarget(NULL);

            m_CastItem = NULL;
            m_castItemGUID = 0;

            player->StoreItem(dest, pNewItem, true);
            player->ItemAddedQuestCheck(newitemid, 1);
            return;
        }
    }
    else if (player->IsBankPos (pos))
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanBankItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(), dest, pNewItem, true);
        if (msg == EQUIP_ERR_OK)
        {
            player->DestroyItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(),true);

            // prevent crash at access and unexpected charges counting with item update queue corrupt
            if (m_CastItem==m_targets.getItemTarget())
                m_targets.setItemTarget(NULL);

            m_CastItem = NULL;
            m_castItemGUID = 0;

            player->BankItem(dest, pNewItem, true);
            return;
        }
    }
    else if (player->IsEquipmentPos (pos))
    {
        uint16 dest;
        uint8 msg = player->CanEquipItem(m_CastItem->GetSlot(), dest, pNewItem, true);
        if (msg == EQUIP_ERR_OK)
        {
            player->DestroyItem(m_CastItem->GetBagSlot(), m_CastItem->GetSlot(),true);

            // prevent crash at access and unexpected charges counting with item update queue corrupt
            if (m_CastItem==m_targets.getItemTarget())
                m_targets.setItemTarget(NULL);

            m_CastItem = NULL;
            m_castItemGUID = 0;

            player->EquipItem(dest, pNewItem, true);
            player->AutoUnequipOffhandIfNeed();
            return;
        }
    }

    // fail
    delete pNewItem;
}

void Spell::EffectOpenSecretSafe(uint32 i)
{
    EffectOpenLock(i);                                      //no difference for now
}

void Spell::EffectProficiency(uint32 /*i*/)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;
    Player *p_target = (Player*)unitTarget;

    uint32 subClassMask = GetSpellInfo()->EquippedItemSubClassMask;
    if (GetSpellInfo()->EquippedItemClass == 2 && !(p_target->GetWeaponProficiency() & subClassMask))
    {
        p_target->AddWeaponProficiency(subClassMask);
        p_target->SendProficiency(uint8(0x02),p_target->GetWeaponProficiency());
    }
    if (GetSpellInfo()->EquippedItemClass == 4 && !(p_target->GetArmorProficiency() & subClassMask))
    {
        p_target->AddArmorProficiency(subClassMask);
        p_target->SendProficiency(uint8(0x04),p_target->GetArmorProficiency());
    }
}

void Spell::EffectApplyAreaAura(uint32 i)
{
    if (!unitTarget)
        return;
    if (!unitTarget->isAlive())
        return;

    AreaAura* Aur = new AreaAura(GetSpellInfo(), i, &damage, unitTarget, m_caster, m_CastItem);
    unitTarget->AddAura(Aur);
}

void Spell::EffectSummonType(uint32 i)
{
    switch (GetSpellInfo()->EffectMiscValueB[i])
    {
        case SUMMON_TYPE_GUARDIAN:
            EffectSummonGuardian(i);
            break;
        case SUMMON_TYPE_POSESSED:
        case SUMMON_TYPE_POSESSED2:
        case SUMMON_TYPE_POSESSED3:
            EffectSummonPossessed(i);
            break;
        case SUMMON_TYPE_WILD:
            EffectSummonWild(i);
            break;
        case SUMMON_TYPE_DEMON:
            EffectSummonDemon(i);
            break;
        case SUMMON_TYPE_SUMMON:
            EffectSummon(i);
            break;
        case SUMMON_TYPE_CRITTER:
        case SUMMON_TYPE_CRITTER2:
        case SUMMON_TYPE_CRITTER3:
            EffectSummonCritter(i);
            break;
        case SUMMON_TYPE_TOTEM_SLOT1:
        case SUMMON_TYPE_TOTEM_SLOT2:
        case SUMMON_TYPE_TOTEM_SLOT3:
        case SUMMON_TYPE_TOTEM_SLOT4:
        case SUMMON_TYPE_TOTEM:
            EffectSummonTotem(i);
            break;
        case SUMMON_TYPE_UNKNOWN1:
        case SUMMON_TYPE_UNKNOWN3:
        case SUMMON_TYPE_UNKNOWN4:
        case SUMMON_TYPE_UNKNOWN5:
            break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: EffectSummonType: Unhandled summon type %u", GetSpellInfo()->EffectMiscValueB[i]);
            break;
    }
}

void Spell::EffectSummon(uint32 i)
{
    uint32 pet_entry = GetSpellInfo()->EffectMiscValue[i];
    if (!pet_entry)
        return;

    if (!m_originalCaster || m_originalCaster->GetTypeId() != TYPEID_PLAYER)
    {
        EffectSummonWild(i);
        return;
    }

    Player *owner = (Player*)m_originalCaster;

    if (owner->GetPetGUID())
        return;

    // Summon in dest location
    float x,y,z;
    if (m_targets.HasDst())
    {
        x = m_targets.m_destX;
        y = m_targets.m_destY;
        z = m_targets.m_destZ;
    }
    else
        m_caster->GetNearPoint(x,y,z,owner->GetObjectSize());

    Pet *spawnCreature = owner->SummonPet(pet_entry, x, y, z, m_caster->GetOrientation(), SUMMON_PET, SpellMgr::GetSpellDuration(GetSpellInfo()));
    if (!spawnCreature)
        return;

    spawnCreature->SetUInt32Value(UNIT_NPC_FLAGS, 0);
    spawnCreature->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, 0);
    spawnCreature->SetUInt32Value(UNIT_CREATED_BY_SPELL, GetSpellInfo()->Id);

    std::string name = owner->GetName();
    name.append(petTypeSuffix[spawnCreature->getPetType()]);
    spawnCreature->SetName(name);

    spawnCreature->SetReactState(REACT_DEFENSIVE);
}

void Spell::EffectLearnSpell(uint32 i)
{
    if (!unitTarget)
        return;

    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
    {
        if (m_caster->GetTypeId() == TYPEID_PLAYER)
            EffectLearnPetSpell(i);

        return;
    }

    Player *player = (Player*)unitTarget;

    uint32 spellToLearn = (GetSpellInfo()->Id==SPELL_ID_GENERIC_LEARN) ? damage : GetSpellInfo()->EffectTriggerSpell[i];
    player->learnSpell(spellToLearn);

    sLog.outDebug("Spell: Player %u have learned spell %u from NpcGUID=%u", player->GetGUIDLow(), spellToLearn, m_caster->GetGUIDLow());
}

void Spell::EffectDispel(uint32 i)
{
    if (!unitTarget)
        return;

    if (unitTarget->IsHostileTo(m_caster))
    {
        // make this additional immunity check here for mass dispel
        if (unitTarget->IsImmunedToDamage(SpellMgr::GetSpellSchoolMask(GetSpellInfo()),true))
            return;
        m_caster->SetInCombatWith(unitTarget);
        unitTarget->SetInCombatWith(m_caster);
    }

    // Fill possible dispel list
    std::vector <Aura *> dispel_list;

    // Create dispel mask by dispel type
    uint32 dispel_type = GetSpellInfo()->EffectMiscValue[i];
    uint32 dispelMask  = SpellMgr::GetDispellMask(DispelType(dispel_type));
    Unit::AuraMap const& auras = unitTarget->GetAuras();
    for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
    {
        Aura *aur = (*itr).second;
        if (aur && (1<<aur->GetSpellProto()->Dispel) & dispelMask)
        {
            if (aur->GetSpellProto()->Dispel == DISPEL_MAGIC)
            {
                // do not remove positive auras if friendly target
                //               negative auras if non-friendly target
                if (aur->IsPositive() == unitTarget->IsFriendlyTo(m_caster))
                    continue;
            }

            // Add every aura stack to dispel list
            for (uint32 stack_amount = 0; stack_amount < aur->GetStackAmount(); ++stack_amount)
                dispel_list.push_back(aur);
        }
    }
    // Ok if exist some buffs for dispel try dispel it
    if (!dispel_list.empty())
    {
        std::list < std::pair<uint32,uint64> > success_list;// (spell_id,casterGuid)
        std::list < uint32 > fail_list;                     // spell_id
        int32 list_size = dispel_list.size();
        // dispel N = damage buffs (or while exist buffs for dispel)
        for (int32 count=0; count < damage && list_size > 0; ++count)
        {
            // Random select buff for dispel
          Aura *aur = dispel_list[urand(0, list_size-1)];

            SpellEntry const* spellInfo = aur->GetSpellProto();
            // Base dispel chance
            // TODO: possible chance depend from spell level??
            int32 miss_chance = 0;
            // Apply dispel mod from aura caster
            if (Unit *caster = aur->GetCaster())
            {
                if (Player* modOwner = caster->GetSpellModOwner())
                    modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_RESIST_DISPEL_CHANCE, miss_chance, this);
            }

            if (miss_chance < 100)
            {
                // Try dispel
                if (roll_chance_i(miss_chance))
                    fail_list.push_back(aur->GetId());
                else
                    success_list.push_back(std::pair<uint32,uint64>(aur->GetId(),aur->GetCasterGUID()));
            }
            // don't try to dispell effects with 100% dispell resistance (patch 2.4.3 notes)
            else
                count--;

            // Remove buff from list for prevent doubles
            for (std::vector<Aura *>::iterator j = dispel_list.begin(); j != dispel_list.end();)
            {
                Aura *dispelled = *j;
                if (dispelled->GetId() == aur->GetId() && dispelled->GetCasterGUID() == aur->GetCasterGUID())
                {
                    j = dispel_list.erase(j);
                    --list_size;
                    break;
                }
                else
                    ++j;
            }
        }
        // Send success log and really remove auras
        if (!success_list.empty())
        {
            int32 count = success_list.size();
            WorldPacket data(SMSG_SPELLDISPELLOG, 8+8+4+1+4+count*5);
            data << unitTarget->GetPackGUID();              // Victim GUID
            data << m_caster->GetPackGUID();                // Caster GUID
            data << uint32(GetSpellInfo()->Id);                // dispel spell id
            data << uint8(0);                               // not used
            data << uint32(count);                          // count
            for (std::list<std::pair<uint32,uint64> >::iterator j = success_list.begin(); j != success_list.end(); ++j)
            {
                SpellEntry const* spellInfo = sSpellStore.LookupEntry(j->first);
                data << uint32(spellInfo->Id);              // Spell Id
                data << uint8(0);                           // 0 - dispelled !=0 cleansed
                if (spellInfo->StackAmount!= 0)
                {
                    //Why are Aura's Removed by EffIndex? Auras should be removed as a whole.....
                    unitTarget->RemoveSingleAuraFromStackByDispel(spellInfo->Id);
                }
                else
                unitTarget->RemoveAurasDueToSpellByDispel(spellInfo->Id, j->second, m_caster);
             }
            m_caster->BroadcastPacket(&data, true);

            // On succes dispel
            // Devour Magic
            if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_WARLOCK && GetSpellInfo()->Category == 12)
            {
                uint32 heal_spell = 0;
                switch (GetSpellInfo()->Id)
                {
                    case 19505: heal_spell = 19658; break;
                    case 19731: heal_spell = 19732; break;
                    case 19734: heal_spell = 19733; break;
                    case 19736: heal_spell = 19735; break;
                    case 27276: heal_spell = 27278; break;
                    case 27277: heal_spell = 27279; break;
                    default:
                        sLog.outDebug("Spell for Devour Magic %d not handled in Spell::EffectDispel", GetSpellInfo()->Id);
                        break;
                }
                if (heal_spell)
                    m_caster->CastSpell(m_caster, heal_spell, true);
            }
        }
        // Send fail log to client
        if (!fail_list.empty())
        {
            // Failed to dispell
            WorldPacket data(SMSG_DISPEL_FAILED, 8+8+4+4*fail_list.size());
            data << uint64(m_caster->GetGUID());            // Caster GUID
            data << uint64(unitTarget->GetGUID());          // Victim GUID
            data << uint32(GetSpellInfo()->Id);                // dispel spell id
            for (std::list< uint32 >::iterator j = fail_list.begin(); j != fail_list.end(); ++j)
                data << uint32(*j);                         // Spell Id
            m_caster->BroadcastPacket(&data, true);
        }
    }
}

void Spell::EffectDualWield(uint32 /*i*/)
{
    unitTarget->SetCanDualWield(true);
    if (unitTarget->GetTypeId() == TYPEID_UNIT)
        ((Creature*)unitTarget)->UpdateDamagePhysical(OFF_ATTACK);
}

void Spell::EffectPull(uint32 /*i*/)
{
    // TODO: create a proper pull towards distract spell center for distract
    sLog.outDebug("WORLD: Spell Effect DUMMY");
}

void Spell::EffectDistract(uint32 /*i*/)
{
    // Check for possible target
    if (!unitTarget || unitTarget->isInCombat())
        return;

    // target must be OK to do this
    if (unitTarget->hasUnitState(UNIT_STAT_CONFUSED | UNIT_STAT_STUNNED | UNIT_STAT_FLEEING))
        return;

    unitTarget->SetFacingTo(unitTarget->GetAngle(m_targets.m_destX, m_targets.m_destY));

    unitTarget->SetStandState(PLAYER_STATE_NONE);

    if (unitTarget->GetTypeId() == TYPEID_UNIT)
        unitTarget->GetMotionMaster()->MoveDistract(damage * IN_MILISECONDS);
}

void Spell::EffectPickPocket(uint32 /*i*/)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    // victim must be creature and attackable
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_UNIT || m_caster->IsFriendlyTo(unitTarget))
        return;

    // victim have to be alive and humanoid or undead
    if (unitTarget->isAlive() && (unitTarget->GetCreatureTypeMask() &CREATURE_TYPEMASK_HUMANOID_OR_UNDEAD) != 0)
    {
        int32 chance = 10 + int32(m_caster->getLevel()) - int32(unitTarget->getLevel());

        if (chance > irand(0, 19))
        {
            // Stealing successful
            //sLog.outDebug("Sending loot from pickpocket");
            ((Player*)m_caster)->SendLoot(unitTarget->GetGUID(),LOOT_PICKPOCKETING);
        }
        else
        {
            // Reveal action + get attack
            m_caster->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TALK);
            if (((Creature*)unitTarget)->IsAIEnabled)
                ((Creature*)unitTarget)->AI()->AttackStart(m_caster);
        }
    }
}

void Spell::EffectAddFarsight(uint32 i)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    float radius = SpellMgr::GetSpellRadius(GetSpellInfo(),i,false);
    int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());
    DynamicObject* dynObj = new DynamicObject;
    if (!dynObj->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_DYNAMICOBJECT), m_caster, GetSpellInfo()->Id, 4, m_targets.m_destX, m_targets.m_destY, m_targets.m_destZ, duration, radius))
    {
        delete dynObj;
        return;
    }

    dynObj->SetUInt32Value(OBJECT_FIELD_TYPE, 65);
    dynObj->SetUInt32Value(DYNAMICOBJECT_BYTES, 0x80000002);
    m_caster->AddDynObject(dynObj);

    //dynObj->setActive(true);    //must before add to map to be put in world container
    m_caster->GetMap()->Add(dynObj); //grid will also be loaded

    m_caster->UpdateVisibilityAndView();

    ((Player*)m_caster)->GetCamera().SetView(dynObj, true);
}

void Spell::EffectSummonWild(uint32 i)
{
    uint32 creature_entry = GetSpellInfo()->EffectMiscValue[i];
    if (!creature_entry)
        return;

    if (m_caster->HasEventAISummonedUnits())
        return;

    uint32 level = m_caster->getLevel();

    // level of creature summoned using engineering item based at engineering skill level
    if (m_caster->GetTypeId()==TYPEID_PLAYER && m_CastItem)
    {
        ItemPrototype const *proto = m_CastItem->GetProto();
        if (proto && proto->RequiredSkill == SKILL_ENGINERING)
        {
            uint16 skill202 = ((Player*)m_caster)->GetSkillValue(SKILL_ENGINERING);
            if (skill202)
            {
                level = skill202/5;
            }
        }
    }

    // select center of summon position
    float center_x = m_targets.m_destX;
    float center_y = m_targets.m_destY;
    float center_z = m_targets.m_destZ;

    float radius = SpellMgr::GetSpellRadius(GetSpellInfo(),i,false);

    int32 amount = damage > 0 ? damage : 1;

    for (int32 count = 0; count < amount; ++count)
    {
        float px, py, pz;
        // If dest location if present
        if (m_targets.m_targetMask & TARGET_FLAG_DEST_LOCATION)
        {
            // Summon 1 unit in dest location
            if (count == 0)
            {
                px = m_targets.m_destX;
                py = m_targets.m_destY;
                pz = m_targets.m_destZ;
            }
            // Summon in random point all other units if location present
            else
                m_caster->GetRandomPoint(center_x,center_y,center_z,radius,px,py,pz);
        }
        // Summon if dest location not present near caster
        else
            m_caster->GetNearPoint(px,py,pz,3.0f);

        int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());

        TempSummonType summonType = (duration == 0) ? TEMPSUMMON_DEAD_DESPAWN : TEMPSUMMON_TIMED_DESPAWN;

        if (m_originalCaster)
            m_originalCaster->SummonCreature(creature_entry,px,py,pz,m_caster->GetOrientation(),summonType,duration);
        else
            m_caster->SummonCreature(creature_entry,px,py,pz,m_caster->GetOrientation(),summonType,duration);
    }
}

void Spell::EffectSummonGuardian(uint32 i)
{
    uint32 pet_entry = GetSpellInfo()->EffectMiscValue[i];
    if (!pet_entry)
        return;

    // Jewelery statue case (totem like)
    if (GetSpellInfo()->SpellIconID==2056)
    {
        EffectSummonTotem(i);
        return;
    }

    // set timer for unsummon
    int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());

    Player *caster = NULL;
    if (m_originalCaster)
    {
        if (m_originalCaster->GetTypeId() == TYPEID_PLAYER)
            caster = (Player*)m_originalCaster;
        else if (((Creature*)m_originalCaster)->isTotem())
        {
            if (((Creature*)m_originalCaster)->GetEntry() == 15439 || ((Creature*)m_originalCaster)->GetEntry() == 15430)
            {
                float px, py, pz;
                m_caster->GetNearPoint(px,py,pz,m_caster->GetObjectSize());
                if (caster = m_originalCaster->GetCharmerOrOwnerPlayerOrPlayerItself())
                if (Pet *spawnCreature = caster->SummonPet(GetSpellInfo()->EffectMiscValue[i], px, py, pz, m_caster->GetOrientation(), GUARDIAN_PET, duration))
                {
                    spawnCreature->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP,0);
                    spawnCreature->SetUInt32Value(UNIT_CREATED_BY_SPELL, GetSpellInfo()->Id);
                    spawnCreature->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_PVP_ATTACKABLE);
                    spawnCreature->SetOwnerGUID(m_caster->GetGUID());
                    spawnCreature->SetReactState(REACT_DEFENSIVE);

                    float healthfactor = (frand(0.15, 0.30));
                    float manafactor = (frand(0.2, 0.8));
                    spawnCreature->SetMaxHealth(spawnCreature->GetMaxHealth() + caster->GetHealthBonusFromStamina() * healthfactor);
                    spawnCreature->SetHealth(spawnCreature->GetMaxHealth() + caster->GetHealthBonusFromStamina() * healthfactor);
                    if(spawnCreature->GetEntry() == 15438)
                    {
                        spawnCreature->SetMaxPower(POWER_MANA, (spawnCreature->GetMaxPower(POWER_MANA) + caster->GetManaBonusFromIntellect() * manafactor));
                        spawnCreature->SetPower(POWER_MANA,(spawnCreature->GetMaxPower(POWER_MANA) + caster->GetManaBonusFromIntellect() * manafactor));
                    }

                   //Precise values are impossible to find. This values (+ 10-30%) are the conclusion of all available proofs, lovered by 10%.
                   //After checking the impact on the game if may be lowered to 10%.
                   //Mana bonus must be much lover, due to conclusion of spells costs.
                   //Bonus spell damage is not confirmed, so it's NOT implemented.
                   return;
                }
            }
            else
                caster = m_originalCaster->GetCharmerOrOwnerPlayerOrPlayerItself();
        }
    }

    if (!caster)
    {
        EffectSummonWild(i);
        return;
    }

    // Search old Guardian only for players (if casted spell not have duration or cooldown)
    // FIXME: some guardians have control spell applied and controlled by player and anyway player can't summon in this time
    //        so this code hack in fact
    if (duration <= 0 || SpellMgr::GetSpellRecoveryTime(GetSpellInfo())==0)
        if (caster->HasGuardianWithEntry(pet_entry))
            return;                                         // find old guardian, ignore summon

    // in another case summon new
    uint32 level = caster->getLevel();

    // level of pet summoned using engineering item based at engineering skill level
    if (m_CastItem)
    {
        ItemPrototype const *proto = m_CastItem->GetProto();
        if (proto && proto->RequiredSkill == SKILL_ENGINERING)
        {
            uint16 skill202 = caster->GetSkillValue(SKILL_ENGINERING);
            if (skill202)
            {
                level = skill202/5;
            }
        }
    }

    // select center of summon position
    float center_x = m_targets.m_destX;
    float center_y = m_targets.m_destY;
    float center_z = m_targets.m_destZ;

    float radius = SpellMgr::GetSpellRadius(GetSpellInfo(),i,false);

    int32 amount = damage > 0 ? damage : 1;

    for (int32 count = 0; count < amount; ++count)
    {
        float px, py, pz;
        // If dest location if present
        if (m_targets.m_targetMask & TARGET_FLAG_DEST_LOCATION)
        {
            // Summon 1 unit in dest location
            if (count == 0)
            {
                px = m_targets.m_destX;
                py = m_targets.m_destY;
                pz = m_targets.m_destZ;
            }
            // Summon in random point all other units if location present
            else
                m_caster->GetRandomPoint(center_x,center_y,center_z,radius,px,py,pz);
        }
        // Summon if dest location not present near caster
        else
            m_caster->GetNearPoint(px,py,pz,m_caster->GetObjectSize());

        Pet *spawnCreature = caster->SummonPet(GetSpellInfo()->EffectMiscValue[i], px, py, pz, m_caster->GetOrientation(), GUARDIAN_PET, duration);
        if (!spawnCreature)
            return;

        spawnCreature->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP,0);
        spawnCreature->SetUInt32Value(UNIT_CREATED_BY_SPELL, GetSpellInfo()->Id);
        spawnCreature->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_PVP_ATTACKABLE);
    }
}

void Spell::EffectSummonPossessed(uint32 i)
{
    uint32 entry = GetSpellInfo()->EffectMiscValue[i];
    if (!entry)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    uint32 level = m_caster->getLevel();

    float x, y, z;
    m_caster->GetNearPoint(x, y, z, DEFAULT_WORLD_OBJECT_SIZE);

    int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());

    Pet* pet = ((Player*)m_caster)->SummonPet(entry, x, y, z + 0.5f, m_caster->GetOrientation(), POSSESSED_PET, duration);
    if (!pet)
        return;

    pet->SetUInt32Value(UNIT_CREATED_BY_SPELL, GetSpellInfo()->Id);
    pet->SetCharmedOrPossessedBy(m_caster, true);
}

void Spell::EffectTeleUnitsFaceCaster(uint32 i)
{
    if (!unitTarget)
        return;

    if (unitTarget->IsTaxiFlying())
        return;

    uint32 mapid = m_caster->GetMapId();

    if(!m_targets.HasDst())
    {
        float dis = SpellMgr::GetSpellRadius(GetSpellInfo(),i,false);

        float fx,fy,fz;
        m_caster->GetNearPoint(fx,fy,fz,unitTarget->GetObjectSize(),dis);

        if (mapid == unitTarget->GetMapId())
            unitTarget->NearTeleportTo(fx, fy, fz, -m_caster->GetOrientation(), unitTarget == m_caster);
        else if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            ((Player*)unitTarget)->TeleportTo(mapid, fx, fy, fz, -m_caster->GetOrientation(), unitTarget == m_caster ? TELE_TO_SPELL : 0);
    }
    else
    {
        if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            ((Player*)unitTarget)->TeleportTo(mapid, m_targets.m_destX, m_targets.m_destY, m_targets.m_destZ, unitTarget->GetOrientation());
    }

}

void Spell::EffectLearnSkill(uint32 i)
{
    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    if (damage < 0)
        return;

    uint32 skillid =  GetSpellInfo()->EffectMiscValue[i];
    uint16 skillval = ((Player*)unitTarget)->GetPureSkillValue(skillid);
    ((Player*)unitTarget)->SetSkill(skillid, skillval?skillval:1, damage*75);
}

void Spell::EffectAddHonor(uint32 /*i*/)
{
    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    sLog.outDebug("SpellEffect::AddHonor called for spell_id %u , that rewards %d honor points to player: %u", GetSpellInfo()->Id, damage, ((Player*)unitTarget)->GetGUIDLow());

    // TODO: find formula for honor reward based on player's level!

    // now fixed only for level 70 players:
    if (((Player*)unitTarget)->getLevel() == 70)
        ((Player*)unitTarget)->RewardHonor(NULL, 1, damage);
}

void Spell::EffectTradeSkill(uint32 /*i*/)
{
    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;
    // uint32 skillid =  GetSpellInfo()->EffectMiscValue[i];
    // uint16 skillmax = ((Player*)unitTarget)->(skillid);
    // ((Player*)unitTarget)->SetSkill(skillid,skillval?skillval:1,skillmax+75);
}

void Spell::EffectEnchantItemPerm(uint32 i)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;
    if (!itemTarget)
        return;

    Player* p_caster = (Player*)m_caster;

    p_caster->UpdateCraftSkill(GetSpellInfo()->Id);

    if (GetSpellInfo()->EffectMiscValue[i])
    {
        uint32 enchant_id = GetSpellInfo()->EffectMiscValue[i];

        SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
        if (!pEnchant)
            return;

        // item can be in trade slot and have owner diff. from caster
        Player* item_owner = itemTarget->GetOwner();
        if (!item_owner)
            return;

        if (item_owner!=p_caster && p_caster->GetSession()->HasPermissions(PERM_GMT) && sWorld.getConfig(CONFIG_GM_LOG_TRADE))
        {
            sLog.outCommand(p_caster->GetSession()->GetAccountId(),"GM %s (Account: %u) enchanting(perm): %s (Entry: %d) for player: %s (Account: %u)",
                p_caster->GetName(),p_caster->GetSession()->GetAccountId(),
                itemTarget->GetProto()->Name1,itemTarget->GetEntry(),
                item_owner->GetName(),item_owner->GetSession()->GetAccountId());
        }

        // remove old enchanting before applying new if equipped
        item_owner->ApplyEnchantment(itemTarget,PERM_ENCHANTMENT_SLOT,false);

        itemTarget->SetEnchantment(PERM_ENCHANTMENT_SLOT, enchant_id, 0, 0);

        // add new enchanting if equipped
        item_owner->ApplyEnchantment(itemTarget,PERM_ENCHANTMENT_SLOT,true);
    }
}

void Spell::EffectEnchantItemTmp(uint32 i)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* p_caster = (Player*)m_caster;

    if (!itemTarget)
        return;

    uint32 enchant_id = GetSpellInfo()->EffectMiscValue[i];

    // Shaman Rockbiter Weapon
    if (i==0 && GetSpellInfo()->Effect[1]==SPELL_EFFECT_DUMMY)
    {
        int32 enchanting_damage = CalculateDamage(1, NULL);//+1;

        // enchanting id selected by calculated damage-per-sec stored in Effect[1] base value
        // with already applied percent bonus from Elemental Weapons talent
        // Note: damage calculated (correctly) with rounding int32(float(v)) but
        // RW enchantments applied damage int32(float(v)+0.5), this create  0..1 difference sometime
        switch (enchanting_damage)
        {
            // Rank 1
            case  2: enchant_id =   29; break;              //  0% [ 7% ==  2, 14% == 2, 20% == 2]
            // Rank 2
            case  4: enchant_id =    6; break;              //  0% [ 7% ==  4, 14% == 4]
            case  5: enchant_id = 3025; break;              // 20%
            // Rank 3
            case  6: enchant_id =    1; break;              //  0% [ 7% ==  6, 14% == 6]
            case  7: enchant_id = 3027; break;              // 20%
            // Rank 4
            case  9: enchant_id = 3032; break;              //  0% [ 7% ==  6]
            case 10: enchant_id =  503; break;              // 14%
            case 11: enchant_id = 3031; break;              // 20%
            // Rank 5
            case 15: enchant_id = 3035; break;              // 0%
            case 16: enchant_id = 1663; break;              // 7%
            case 17: enchant_id = 3033; break;              // 14%
            case 18: enchant_id = 3034; break;              // 20%
            // Rank 6
            case 28: enchant_id = 3038; break;              // 0%
            case 29: enchant_id =  683; break;              // 7%
            case 31: enchant_id = 3036; break;              // 14%
            case 33: enchant_id = 3037; break;              // 20%
            // Rank 7
            case 40: enchant_id = 3041; break;              // 0%
            case 42: enchant_id = 1664; break;              // 7%
            case 45: enchant_id = 3039; break;              // 14%
            case 48: enchant_id = 3040; break;              // 20%
            // Rank 8
            case 49: enchant_id = 3044; break;              // 0%
            case 52: enchant_id = 2632; break;              // 7%
            case 55: enchant_id = 3042; break;              // 14%
            case 58: enchant_id = 3043; break;              // 20%
            // Rank 9
            case 62: enchant_id = 2633; break;              // 0%
            case 66: enchant_id = 3018; break;              // 7%
            case 70: enchant_id = 3019; break;              // 14%
            case 74: enchant_id = 3020; break;              // 20%
            default:
                sLog.outLog(LOG_DEFAULT, "ERROR: Spell::EffectEnchantItemTmp: Damage %u not handled in S'RW",enchanting_damage);
                return;
        }
    }

    if (!enchant_id)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Spell %u Effect %u (SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY) have 0 as enchanting id",GetSpellInfo()->Id,i);
        return;
    }

    SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
    if (!pEnchant)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Spell %u Effect %u (SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY) have not existed enchanting id %u ",GetSpellInfo()->Id,i,enchant_id);
        return;
    }

    // select enchantment duration
    uint32 duration;

    // rogue family enchantments exception by duration
    if (GetSpellInfo()->Id==38615)
        duration = 1800;                                    // 30 mins
    // other rogue family enchantments always 1 hour (some have spell damage=0, but some have wrong data in EffBasePoints)
    else if (GetSpellInfo()->SpellFamilyName==SPELLFAMILY_ROGUE)
        duration = 3600;                                    // 1 hour
    // shaman family enchantments
    else if (GetSpellInfo()->SpellFamilyName==SPELLFAMILY_SHAMAN)
        duration = 1800;                                    // 30 mins
    // other cases with this SpellVisual already selected
    else if (GetSpellInfo()->SpellVisual==215)
        duration = 1800;                                    // 30 mins
    // some fishing pole bonuses
    else if (GetSpellInfo()->SpellVisual==563)
        duration = 600;                                     // 10 mins
    // shaman rockbiter enchantments
    else if (GetSpellInfo()->SpellVisual==0)
        duration = 1800;                                    // 30 mins
    else if (GetSpellInfo()->Id==29702)
        duration = 300;                                     // 5 mins
    else if (GetSpellInfo()->Id==37360)
        duration = 300;                                     // 5 mins
    // default case
    else
        duration = 3600;                                    // 1 hour

    // item can be in trade slot and have owner diff. from caster
    Player* item_owner = itemTarget->GetOwner();
    if (!item_owner)
        return;

    if (item_owner!=p_caster && p_caster->GetSession()->HasPermissions(PERM_GMT) && sWorld.getConfig(CONFIG_GM_LOG_TRADE))
    {
        sLog.outCommand(p_caster->GetSession()->GetAccountId(),"GM %s (Account: %u) enchanting(temp): %s (Entry: %d) for player: %s (Account: %u)",
            p_caster->GetName(),p_caster->GetSession()->GetAccountId(),
            itemTarget->GetProto()->Name1,itemTarget->GetEntry(),
            item_owner->GetName(),item_owner->GetSession()->GetAccountId());
    }

    // remove old enchanting before applying new if equipped
    item_owner->ApplyEnchantment(itemTarget,TEMP_ENCHANTMENT_SLOT,false);

    itemTarget->SetEnchantment(TEMP_ENCHANTMENT_SLOT, enchant_id, duration*1000, 0);

    // add new enchanting if equipped
    item_owner->ApplyEnchantment(itemTarget,TEMP_ENCHANTMENT_SLOT,true);
}

void Spell::EffectTameCreature(uint32 /*i*/)
{
    if (m_caster->GetPetGUID())
        return;

    if (!unitTarget)
        return;

    if (unitTarget->GetTypeId() == TYPEID_PLAYER)
        return;

    Creature* creatureTarget = (Creature*)unitTarget;

    if (creatureTarget->isPet())
        return;

    if (m_caster->getClass() != CLASS_HUNTER)
        return;

    // cast finish successfully
    //SendChannelUpdate(0);
    finish();

    Pet* pet = m_caster->CreateTamedPetFrom(creatureTarget,GetSpellInfo()->Id);
    if (!pet) return;

    // kill original creature
    creatureTarget->setDeathState(JUST_DIED);
    creatureTarget->RemoveCorpse();
    creatureTarget->SetHealth(0);                       // just for nice GM-mode view

    // prepare visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL,creatureTarget->getLevel()-1);

    // add to world
    pet->GetMap()->Add((Creature*)pet);

    // visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL,creatureTarget->getLevel());

    // caster have pet now
    m_caster->SetPet(pet);

    if (m_caster->GetTypeId() == TYPEID_PLAYER)
    {
        pet->SavePetToDB(PET_SAVE_AS_CURRENT);
        ((Player*)m_caster)->PetSpellInitialize();
    }
}

void Spell::EffectSummonPet(uint32 i)
{
    Player *owner = NULL;
    if (m_originalCaster)
    {
        if (m_originalCaster->GetTypeId() == TYPEID_PLAYER)
            owner = (Player*)m_originalCaster;
        else if (((Creature*)m_originalCaster)->isTotem())
            owner = m_originalCaster->GetCharmerOrOwnerPlayerOrPlayerItself();
    }

    if (!owner)
    {
        EffectSummonWild(i);
        return;
    }

    uint32 petentry = GetSpellInfo()->EffectMiscValue[i];

    Pet *OldSummon = owner->GetPet();

    // if pet requested type already exist
    if (OldSummon)
    {
        if (petentry == 0 || OldSummon->GetEntry() == petentry)
        {
            // pet in corpse state can't be summoned
            if (OldSummon->isDead())
                return;
	        // if warlock allow summoning pet with same pet active
            if (owner->getClass() != CLASS_WARLOCK)
                OldSummon->GetMap()->Remove((Creature*)OldSummon,false);
            OldSummon->SetMapId(owner->GetMapId());

            float px, py, pz;

            if (m_targets.HasDst())
            {
                px = m_targets.m_destX;
                py = m_targets.m_destY;
                pz = m_targets.m_destZ;
            }
            else
                owner->GetNearPoint(px, py, pz, OldSummon->GetObjectSize());

            OldSummon->Relocate(px, py, pz, OldSummon->GetOrientation());
            owner->GetMap()->Add((Creature*)OldSummon);

            if (owner->GetTypeId() == TYPEID_PLAYER && OldSummon->isControlled())
            {
                ((Player*)owner)->PetSpellInitialize();
            }

            if (OldSummon->getPetType() == SUMMON_PET)
             {
                 OldSummon->SetHealth(OldSummon->GetMaxHealth());
                 OldSummon->SetPower(POWER_MANA, OldSummon->GetMaxPower(POWER_MANA));
                 OldSummon->RemoveAllAurasButPermanent();
                 OldSummon->m_CreatureSpellCooldowns.clear();
                 OldSummon->m_CreatureCategoryCooldowns.clear();
            }
            return;
        }

        if (owner->GetTypeId() == TYPEID_PLAYER)
            ((Player*)owner)->RemovePet(OldSummon,(OldSummon->getPetType()==HUNTER_PET ? PET_SAVE_AS_DELETED : PET_SAVE_NOT_IN_SLOT),false);
        else
            return;
    }

    float x, y, z;
    if (m_targets.HasDst())
    {
        x = m_targets.m_destX;
        y = m_targets.m_destY;
        z = m_targets.m_destZ;
    }
    else
        owner->GetNearPoint(x, y, z, owner->GetObjectSize());

    Pet* pet = owner->SummonPet(petentry, x, y, z, owner->GetOrientation(), SUMMON_PET, 0);
    if (!pet)
        return;

    if (m_caster->GetTypeId() == TYPEID_UNIT)
    {
        if (((Creature*)m_caster)->isTotem())
            pet->SetReactState(REACT_AGGRESSIVE);
        else
            pet->SetReactState(REACT_DEFENSIVE);
    }

    pet->SetUInt32Value(UNIT_CREATED_BY_SPELL, GetSpellInfo()->Id);

    // this enables popup window (pet dismiss, cancel), hunter pet additional flags set later
    pet->SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_PVP_ATTACKABLE);
    pet->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, time(NULL));

    // generate new name for summon pet
    std::string new_name=sObjectMgr.GeneratePetName(petentry);
    if (!new_name.empty())
        pet->SetName(new_name);
}

void Spell::EffectLearnPetSpell(uint32 i)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player *_player = (Player*)m_caster;

    Pet *pet = _player->GetPet();
    if (!pet)
        return;
    if (!pet->isAlive())
        return;

    SpellEntry const *learn_spellproto = sSpellStore.LookupEntry(GetSpellInfo()->EffectTriggerSpell[i]);
    if (!learn_spellproto)
        return;

    pet->SetTP(pet->m_TrainingPoints - pet->GetTPForSpell(learn_spellproto->Id));
    pet->learnSpell(learn_spellproto->Id);

    pet->SavePetToDB(PET_SAVE_AS_CURRENT);
    _player->PetSpellInitialize();
}

void Spell::EffectTaunt(uint32 /*i*/)
{
    if (!unitTarget)
        return;

    // this effect use before aura Taunt apply for prevent taunt already attacking target
    // for spell as marked "non effective at already attacking target"
    if (!unitTarget->CanHaveThreatList()
        || unitTarget->getVictim() == m_caster)
    {
        SendCastResult(SPELL_FAILED_DONT_REPORT);
        return;
    }

    if (unitTarget->IsImmunedToSpellEffect(SPELL_EFFECT_ATTACK_ME,MECHANIC_NONE))
    {
        SendCastResult(SPELL_FAILED_IMMUNE);
        return;
    }

    // Also use this effect to set the taunter's threat to the taunted creature's highest value
    if (unitTarget->getThreatManager().getCurrentVictim())
    {
        float myThreat = unitTarget->getThreatManager().getThreat(m_caster);
        float itsThreat = unitTarget->getThreatManager().getCurrentVictim()->getThreat();
        if (itsThreat > myThreat)
            unitTarget->AddThreat(m_caster, itsThreat - myThreat);
    }

    //Set aggro victim to caster
    if (!unitTarget->getThreatManager().getOnlineContainer().empty())
        if (HostilReference* forcedVictim = unitTarget->getThreatManager().getOnlineContainer().getReferenceByTarget(m_caster))
            unitTarget->getThreatManager().setCurrentVictim(forcedVictim);

    if (((Creature*)unitTarget)->IsAIEnabled)
        ((Creature*)unitTarget)->AI()->AttackStart(m_caster);
}

void Spell::EffectWeaponDmg(uint32 i)
{
}

void Spell::SpellDamageWeaponDmg(uint32 i)
{
    if (!unitTarget)
        return;
    if (!unitTarget->isAlive())
        return;

    // multiple weapon dmg effect workaround
    // execute only the last weapon damage
    // and handle all effects at once
    for (int j = 0; j < 3; j++)
    {
        switch (GetSpellInfo()->Effect[j])
        {
            case SPELL_EFFECT_WEAPON_DAMAGE:
            case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
            case SPELL_EFFECT_NORMALIZED_WEAPON_DMG:
            case SPELL_EFFECT_WEAPON_PERCENT_DAMAGE:
                if (j < i)                                  // we must calculate only at last weapon effect
                    return;
            break;
        }
    }

    // some spell specific modifiers
    //float weaponDamagePercentMod = 1.0f;                    // applied to weapon damage (and to fixed effect damage bonus if customBonusDamagePercentMod not set
    float totalDamagePercentMod  = 1.0f;                    // applied to final bonus+weapon damage
    int32 fixed_bonus = 0;
    int32 spell_bonus = 0;                                  // bonus specific for spell

    switch (GetSpellInfo()->SpellFamilyName)
    {
        case SPELLFAMILY_WARRIOR:
        {
            // Heroic Strike
            if (GetSpellInfo()->SpellFamilyFlags & 0x40)
            {
                switch (GetSpellInfo()->Id)
                {
                    // Heroic Strike r10 + r11
                    case 29707:
                    case 30324:
                    {
                        Unit::AuraList const& decSpeedList = unitTarget->GetAurasByType(SPELL_AURA_MOD_DECREASE_SPEED);
                        for (Unit::AuraList::const_iterator iter = decSpeedList.begin(); iter != decSpeedList.end(); ++iter)
                        {
                            if ((*iter)->GetSpellProto()->SpellIconID == 15 && (*iter)->GetSpellProto()->Dispel == 0)
                            {
                                fixed_bonus += (GetSpellInfo()->Id == 29707) ? 61 : 72;
                                break;
                            }
                        }
                        break;
                    }
                }
                break;
            }
            // Devastate bonus and sunder armor refresh
            else if (GetSpellInfo()->SpellVisual == 671 && GetSpellInfo()->SpellIconID == 1508)
            {
                uint32 stack = 0;

                Unit::AuraList const& list = unitTarget->GetAurasByType(SPELL_AURA_MOD_RESISTANCE);
                for (Unit::AuraList::const_iterator itr=list.begin();itr!=list.end();++itr)
                {
                    SpellEntry const *proto = (*itr)->GetSpellProto();
                    if (proto->SpellFamilyName == SPELLFAMILY_WARRIOR
                        && proto->SpellFamilyFlags == SPELLFAMILYFLAG_WARRIOR_SUNDERARMOR)
                    {
                        int32 duration = SpellMgr::GetSpellDuration(proto);
                        (*itr)->SetAuraDuration(duration);
                        (*itr)->UpdateAuraDuration();
                        stack = (*itr)->GetStackAmount();
                        break;
                    }
                }

                for (int j = 0; j < 3; j++)
                {
                    if (GetSpellInfo()->Effect[j] == SPELL_EFFECT_NORMALIZED_WEAPON_DMG)
                    {
                        fixed_bonus += (stack - 1) * CalculateDamage(j, unitTarget);
                        break;
                    }
                }

                if (stack < 5)
                {
                    // get highest rank of the Sunder Armor spell
                    const PlayerSpellMap& sp_list = ((Player*)m_caster)->GetSpellMap();
                    for (PlayerSpellMap::const_iterator itr = sp_list.begin(); itr != sp_list.end(); ++itr)
                    {
                        // only highest rank is shown in spell book, so simply check if shown in spell book
                        if (!itr->second.active || itr->second.disabled || itr->second.state == PLAYERSPELL_REMOVED)
                            continue;

                        SpellEntry const *spellInfo = sSpellStore.LookupEntry(itr->first);
                        if (!spellInfo)
                            continue;

                        if (spellInfo->SpellFamilyFlags == SPELLFAMILYFLAG_WARRIOR_SUNDERARMOR
                            && spellInfo->Id != GetSpellInfo()->Id
                            && spellInfo->SpellFamilyName == SPELLFAMILY_WARRIOR)
                        {
                            m_caster->CastSpell(unitTarget, spellInfo, true);
                            break;
                        }
                    }
                }
            }
            break;
        }
        case SPELLFAMILY_ROGUE:
        {
            // Hemorrhage
            if (GetSpellInfo()->SpellFamilyFlags & 0x2000000)
            {
                if (m_caster->GetTypeId()==TYPEID_PLAYER)
                    ((Player*)m_caster)->AddComboPoints(unitTarget, 1);
            }
            // Mutilate (for each hand)
            else if (GetSpellInfo()->SpellFamilyFlags & 0x600000000LL)
            {
                Unit::AuraMap const& auras = unitTarget->GetAuras();
                for (Unit::AuraMap::const_iterator itr = auras.begin(); itr!=auras.end(); ++itr)
                {
                    if (itr->second->GetSpellProto()->Dispel == DISPEL_POISON)
                    {
                        totalDamagePercentMod *= 1.5f;          // 150% if poisoned
                        break;
                    }
                }
            }
            break;
        }
        case SPELLFAMILY_PALADIN:
        {
            // Seal of Command - receive benefit from Spell Damage and Healing
            if (GetSpellInfo()->SpellFamilyFlags & 0x00000002000000LL)
            {
                spell_bonus += int32(0.20f*m_caster->SpellBaseDamageBonus(SpellMgr::GetSpellSchoolMask(GetSpellInfo())));
                spell_bonus += int32(0.20f*m_caster->SpellBaseDamageBonusForVictim(SpellMgr::GetSpellSchoolMask(GetSpellInfo()), unitTarget));
            }
            break;
        }
        case SPELLFAMILY_SHAMAN:
        {
            // Skyshatter Harness item set bonus
            // Stormstrike
            if (GetSpellInfo()->SpellFamilyFlags & 0x001000000000LL)
            {
                Unit::AuraList const& m_OverrideClassScript = m_caster->GetAurasByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
                for (Unit::AuraList::const_iterator citr = m_OverrideClassScript.begin(); citr != m_OverrideClassScript.end(); ++citr)
                {
                    // Stormstrike AP Buff
                    if ((*citr)->GetModifier()->m_miscvalue == 5634)
                    {
                        m_caster->CastSpell(m_caster,38430, true, NULL, *citr);
                        break;
                    }
                }
            }
            break;
        }
        case SPELLFAMILY_DRUID:
        {
            // Mangle (Cat): CP
            if (GetSpellInfo()->SpellFamilyFlags==0x0000040000000000LL)
            {
                if (m_caster->GetTypeId()==TYPEID_PLAYER)
                    ((Player*)m_caster)->AddComboPoints(unitTarget,1);
            }
            // Maim interrupt (s3, s4 gloves bonus)
            if (GetSpellInfo()->Id == 22570 && m_caster->HasAura(44835, 0))
                m_caster->CastSpell(unitTarget, 32747, true);
            break;
        }
    }

    bool normalized = false;
    float weaponDamagePercentMod = 1.0;
    for (int j = 0; j < 3; ++j)
    {
        switch (GetSpellInfo()->Effect[j])
        {
            case SPELL_EFFECT_WEAPON_DAMAGE:
            case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
                fixed_bonus += CalculateDamage(j,unitTarget);
                break;
            case SPELL_EFFECT_NORMALIZED_WEAPON_DMG:
                fixed_bonus += CalculateDamage(j,unitTarget);
                normalized = true;
                break;
            case SPELL_EFFECT_WEAPON_PERCENT_DAMAGE:
                weaponDamagePercentMod *= float(CalculateDamage(j,unitTarget)) / 100.0f;
            default:
                break;                                      // not weapon damage effect, just skip
        }
    }

    // apply to non-weapon bonus weapon total pct effect, weapon total flat effect included in weapon damage
    if (fixed_bonus || spell_bonus)
    {
        UnitMods unitMod;
        switch (m_attackType)
        {
            default:
            case BASE_ATTACK:   unitMod = UNIT_MOD_DAMAGE_MAINHAND; break;
            case OFF_ATTACK:    unitMod = UNIT_MOD_DAMAGE_OFFHAND;  break;
            case RANGED_ATTACK: unitMod = UNIT_MOD_DAMAGE_RANGED;   break;
        }

        float weapon_total_pct  = m_caster->GetModifierValue(unitMod, TOTAL_PCT);

        // 50% offhand damage reduction should not affect bonus damage
        if(unitMod == UNIT_MOD_DAMAGE_OFFHAND)
            weapon_total_pct /= 0.5f;

        if (fixed_bonus)
            fixed_bonus = int32(fixed_bonus * weapon_total_pct);
        if (spell_bonus)
            spell_bonus = int32(spell_bonus * weapon_total_pct);
    }

    int32 weaponDamage = m_caster->CalculateDamage(m_attackType, normalized);

    // Sequence is important
    for (int j = 0; j < 3; ++j)
    {
        // We assume that a spell have at most one fixed_bonus
        // and at most one weaponDamagePercentMod
        switch (GetSpellInfo()->Effect[j])
        {
            case SPELL_EFFECT_WEAPON_DAMAGE:
            case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
            case SPELL_EFFECT_NORMALIZED_WEAPON_DMG:
                weaponDamage += fixed_bonus;
                break;
            case SPELL_EFFECT_WEAPON_PERCENT_DAMAGE:
                weaponDamage = int32(weaponDamage * weaponDamagePercentMod);
            default:
                break;                                      // not weapon damage effect, just skip
        }
    }

    // only for Seal of Command
    if (spell_bonus)
        weaponDamage += spell_bonus;

    // only for Mutilate
    if (totalDamagePercentMod != 1.0f)
        weaponDamage = int32(weaponDamage * totalDamagePercentMod);

    // prevent negative damage
    uint32 eff_damage = uint32(weaponDamage > 0 ? weaponDamage : 0);

    // Add melee damage bonuses (also check for negative)
    m_caster->MeleeDamageBonus(unitTarget, &eff_damage, m_attackType, GetSpellInfo());
    m_damage+= eff_damage;

    // take ammo
    if (m_attackType == RANGED_ATTACK && m_caster->GetTypeId() == TYPEID_PLAYER)
    {
        Item *pItem = ((Player*)m_caster)->GetWeaponForAttack(RANGED_ATTACK);

        // wands don't have ammo
        if (!pItem  || pItem->IsBroken() || pItem->GetProto()->SubClass==ITEM_SUBCLASS_WEAPON_WAND)
            return;

        if (pItem->GetProto()->InventoryType == INVTYPE_THROWN)
        {
            if (pItem->GetMaxStackCount()==1)
            {
                // decrease durability for non-stackable throw weapon
                ((Player*)m_caster)->DurabilityPointLossForEquipSlot(EQUIPMENT_SLOT_RANGED);
            }
            else
            {
                // decrease items amount for stackable throw weapon
                uint32 count = 1;
                ((Player*)m_caster)->DestroyItemCount(pItem, count, true);
            }
        }
        else if (uint32 ammo = ((Player*)m_caster)->GetUInt32Value(PLAYER_AMMO_ID))
            ((Player*)m_caster)->DestroyItemCount(ammo, 1, true);
    }
}

void Spell::EffectThreat(uint32 /*i*/)
{
    if (!unitTarget || !unitTarget->isAlive() || !m_caster->isAlive())
        return;

    if (!unitTarget->CanHaveThreatList())
        return;

    unitTarget->AddThreat(m_caster, float(damage));
}

void Spell::EffectHealMaxHealth(uint32 /*i*/)
{
    if (!unitTarget)
        return;

    if (!unitTarget->isAlive())
        return;

    if (unitTarget->GetMaxNegativeAuraModifier(SPELL_AURA_MOD_HEALING_PCT) <= -100)
        return;

    uint32 addhealth = unitTarget->GetMaxHealth() - unitTarget->GetHealth();

    // Lay on Hands
    if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_PALADIN && GetSpellInfo()->SpellFamilyFlags & 0x0000000000008000)
    {
        if (!m_originalCaster || m_originalCaster->IsHostileTo(unitTarget))
            return;

        addhealth = addhealth > m_originalCaster->GetMaxHealth() ? m_originalCaster->GetMaxHealth() : addhealth;
        uint32 LoHamount = unitTarget->GetHealth() + m_originalCaster->GetMaxHealth();
        LoHamount = LoHamount > unitTarget->GetMaxHealth() ? unitTarget->GetMaxHealth() : LoHamount;

        unitTarget->SetHealth(LoHamount);
    }
    else
        unitTarget->SetHealth(unitTarget->GetMaxHealth());

    if (m_originalCaster)
        m_originalCaster->SendHealSpellLog(unitTarget, GetSpellInfo()->Id, addhealth, false);
}

void Spell::EffectInterruptCast(uint32 i)
{
    if (!unitTarget || !unitTarget->isAlive())
        return;

    // TODO: not all spells that used this effect apply cooldown at school spells
    // also exist case: apply cooldown to interrupted cast only and to all spells
    for (uint32 k = CURRENT_FIRST_NON_MELEE_SPELL; k < CURRENT_MAX_SPELL; k++)
    {
        if (Spell* spell = unitTarget->m_currentSpells[k])
        {
            const SpellEntry* curSpellInfo = spell->GetSpellInfo();
            // check if we can interrupt spell
            if ((spell->getState() == SPELL_STATE_CASTING || (spell->getState() == SPELL_STATE_PREPARING && spell->GetCastTime() > 0.0f)) &&
                curSpellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE &&
                ((k == CURRENT_GENERIC_SPELL && curSpellInfo->InterruptFlags & SPELL_INTERRUPT_FLAG_INTERRUPT) ||
                (k == CURRENT_CHANNELED_SPELL && curSpellInfo->ChannelInterruptFlags & CHANNEL_INTERRUPT_FLAG_MOVEMENT) ||
                (k == CURRENT_CHANNELED_SPELL && curSpellInfo->ChannelInterruptFlags & CHANNEL_INTERRUPT_FLAG_INTERRUPT)))
            {
                if (m_originalCaster)
                {
                    int32 duration = m_originalCaster->CalculateSpellDuration(GetSpellInfo(), i, unitTarget);
                    unitTarget->LockSpellSchool(SpellMgr::GetSpellSchoolMask(curSpellInfo), duration /* GetSpellDuration(GetSpellInfo())? */);
                }
                // has to be sent before InterruptSpell call
                WorldPacket data(SMSG_SPELLLOGEXECUTE, (8+4+4+4+4+8+4));
                data << m_caster->GetPackGUID();
                data << uint32(GetSpellInfo()->Id);
                data << uint32(1); // effect count
                data << uint32(SPELL_EFFECT_INTERRUPT_CAST);
                data << uint32(1); // target count
                data << unitTarget->GetPackGUID();
                data << uint32(curSpellInfo->Id);
                m_caster->BroadcastPacket(&data, true);
                unitTarget->InterruptSpell(k, false);
            }
        }
    }
}

void Spell::EffectSummonObjectWild(uint32 i)
{
    uint32 gameobject_id = GetSpellInfo()->EffectMiscValue[i];

    GameObject* pGameObj = new GameObject;

    WorldObject* target = focusObject;
    if (!target)
        target = m_caster;

    float x,y,z;
    if (m_targets.m_targetMask & TARGET_FLAG_DEST_LOCATION)
    {
        x = m_targets.m_destX;
        y = m_targets.m_destY;
        z = m_targets.m_destZ;
    }
    else
        m_caster->GetNearPoint(x,y,z,DEFAULT_WORLD_OBJECT_SIZE);

    Map *map = target->GetMap();

    if (!pGameObj->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT), gameobject_id, map,
        x, y, z, target->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 100, GO_STATE_READY))
    {
        delete pGameObj;
        return;
    }

    int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());
    pGameObj->SetRespawnTime(duration > 0 ? duration/1000 : 0);
    pGameObj->SetSpellId(GetSpellInfo()->Id);

    if (pGameObj->GetGoType() != GAMEOBJECT_TYPE_FLAGDROP)   // make dropped flag clickable for other players (not set owner guid (created by) for this)...
    {
        if (m_originalCaster)
            m_originalCaster->AddGameObject(pGameObj);
        else
            m_caster->AddGameObject(pGameObj);
    }
    map->Add(pGameObj);

    if (pGameObj->GetMapId() == 489 && pGameObj->GetGoType() == GAMEOBJECT_TYPE_FLAGDROP)  //WS
    {
        if (m_caster->GetTypeId() == TYPEID_PLAYER)
        {
            Player *pl = (Player*)m_caster;
            BattleGround* bg = ((Player *)m_caster)->GetBattleGround();
            if (bg && bg->GetTypeID()==BATTLEGROUND_WS && bg->GetStatus() == STATUS_IN_PROGRESS)
            {
                 uint32 team = ALLIANCE;

                 if (pl->GetBGTeam() == team)
                     team = HORDE;

                 if (pl->HasAura(46392))
                     pl->RemoveAurasDueToSpell(46392);

                ((BattleGroundWS*)bg)->SetDroppedFlagGUID(pGameObj->GetGUID(),team);
            }
        }
    }

    if (pGameObj->GetMapId() == 566 && pGameObj->GetGoType() == GAMEOBJECT_TYPE_FLAGDROP)  //EY
    {
        if (m_caster->GetTypeId() == TYPEID_PLAYER)
        {
            BattleGround* bg = ((Player *)m_caster)->GetBattleGround();
            if (bg && bg->GetTypeID()==BATTLEGROUND_EY && bg->GetStatus() == STATUS_IN_PROGRESS)
            {
                ((BattleGroundEY*)bg)->SetDroppedFlagGUID(pGameObj->GetGUID());
            }
        }
    }

    if (uint32 linkedEntry = pGameObj->GetLinkedGameObjectEntry())
    {
        GameObject* linkedGO = new GameObject;
        if (linkedGO->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT), linkedEntry, map,
            x, y, z, target->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 100, GO_STATE_READY))
        {
            linkedGO->SetRespawnTime(duration > 0 ? duration/1000 : 0);
            linkedGO->SetSpellId(GetSpellInfo()->Id);

            m_caster->AddGameObject(linkedGO);
            map->Add(linkedGO);
        }
        else
        {
            delete linkedGO;
            linkedGO = NULL;
            return;
        }
    }
}

void Spell::EffectScriptEffect(uint32 effIndex)
{
    // TODO: we must implement hunter pet summon at login there (spell 6962)
    switch (GetSpellInfo()->Id)
    {
        // we need script here, because KillCreadit in DB is used for diff quest :p
        case 32314:
        {
            uint32 const CREDIT_MARKER = 18393;
            if (Player* caster = m_caster->ToPlayer())
            {
                caster->KilledMonster(CREDIT_MARKER, unitTarget->GetGUID());
                if (Creature* creature = unitTarget->ToCreature())
                    creature->RemoveCorpse();
            }
            break;
        }
        case 32307:
        {
            uint32 const CREDIT_MARKER = 18388;
            if (Player* caster = m_caster->ToPlayer())
            {
                caster->KilledMonster(CREDIT_MARKER, unitTarget->GetGUID());
                if (Creature* creature = unitTarget->ToCreature())
                    creature->RemoveCorpse();
            }
            break;
        }
        case 28338:
        case 28339:
        {
            if (m_caster->ToCreature() && unitTarget->ToCreature())
            {
                if (Unit *pVictim = unitTarget->getVictim())
                {
                    unitTarget->getThreatManager().modifyThreatPercent(pVictim, -100);
                    m_caster->CastSpell(pVictim, 28337, true);

                    // need to add threat to new victim, but if unitTarget need to cast MagneticPull on us we will bring same victim back to us :p
                }
            }
            break;
        }
        // Flame of Azzinoth Blaze
        case 40609:
        {
            unitTarget->CastSpell(unitTarget, 40637, true, 0, 0, m_caster->GetGUID());
            break;
        }
        case 38530:
        {
            m_caster->RemoveAurasDueToSpell(38495);
            break;
        }
        // Cage Trap Trigger (Maiev)
        case 40761:
        {
            if (unitTarget->GetTypeId() == TYPEID_UNIT)
                ((Creature*)unitTarget)->AI()->DoAction();

            break;
        }
        // Capacitor Overload visual
        case 45014:
        {
            for(uint8 i = 0; i < 8; ++i)
            {
                m_caster->CastSpell(m_caster, damage, true);
            }
            break;
        }
        // Electrical Overload & visual
        case 45336:
        {
            uint8 effect = urand(0, 1);
            // visual
            for(uint8 i = 0; i < 8; ++i)
            {
                m_caster->CastSpell(m_caster, 44993, true);
            }
            // effect
            switch(effect)
            {
                // self stun
                case 0:
                    m_caster->CastSpell(m_caster, 35856, true);
                    break;
                // cast Broken Capacitor
                case 1:
                {
                    int32 selfdamage = 350;
                    m_caster->CastCustomSpell(m_caster, 44986, 0, &selfdamage, 0, true);
                    break;
                }
            }
            break;
        }
        // Fog of Corruption (Felmyst)
        case 45714:
        {
            // unitTarget is here Felmyst, and affected player is a caster
            if(!m_caster->HasAura(45717))
            {
                m_caster->CastSpell(m_caster, 46411, true); // self-stun for a few sec
                unitTarget->CastSpell(m_caster, 45717, true);
            }
            break;
        }
        // Unbanish Azaloth
        case 37834:
        {
            if (unitTarget->HasAura(37833,0))
            {
                unitTarget->RemoveAurasDueToSpell(37833);

                if (m_caster->GetTypeId() == TYPEID_PLAYER)
                {
                    if( Group* pGroup = ((Player*)m_caster)->GetGroup() )
                    {
                        for(GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
                        {
                            Player *pGroupie = itr->getSource();
                            if( pGroupie && pGroupie->GetQuestStatus(10637) == QUEST_STATUS_INCOMPLETE)
                            {
                                pGroupie->CompleteQuest(10637);
                                pGroupie->AreaExploredOrEventHappens(10637);
                            }
                            if( pGroupie && pGroupie->GetQuestStatus(10688) == QUEST_STATUS_INCOMPLETE)
                            {
                                pGroupie->CompleteQuest(10688);
                                pGroupie->AreaExploredOrEventHappens(10688);
                            }
                        }
                    } else
                    {
                        if (((Player*)m_caster)->GetQuestStatus(10637) == QUEST_STATUS_INCOMPLETE)
                        {
                            ((Player*)m_caster)->CompleteQuest(10637);
                            ((Player*)m_caster)->AreaExploredOrEventHappens(10637);
                        }
                        if (((Player*)m_caster)->GetQuestStatus(10688) == QUEST_STATUS_INCOMPLETE)
                        {
                            ((Player*)m_caster)->CompleteQuest(10688);
                            ((Player*)m_caster)->AreaExploredOrEventHappens(10688);
                        }
                    }
                }
            }
            else
                 SendCastResult(SPELL_FAILED_BAD_TARGETS);
            break;
        }
        // Draenei Tomb Relic
        case 36867:
        {
            if (m_caster->GetTypeId() == TYPEID_PLAYER)
                if (((Player*)m_caster)->GetQuestStatus(10842) == QUEST_STATUS_INCOMPLETE)
                    m_caster->SummonCreature(21445, m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ(), m_caster->GetOrientation(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                else SendCastResult(SPELL_FAILED_NOT_READY);
                break;
        }
        // Destroy Deathforged Infernal
        case 38055:
        {
            m_caster->CastSpell(m_caster, 38054, true);
            return;
        }
        // Gathios the Shatterer: Judgement
        case 41467:
        {
            if (m_caster->GetTypeId() != TYPEID_UNIT)
                return;

            if (m_caster->HasAura(41459, 2)) // Seal of Blood
            {
                m_caster->CastSpell(m_caster->getVictim(), 41461, true); // Judgement of Blood
                m_caster->RemoveAurasDueToSpell(41459);
                return;
            }
            if (m_caster->HasAura(41469, 2)) // Seal of Command
            {
                m_caster->CastSpell(m_caster->getVictim(), 41470, true); // Judgement of Command
                m_caster->RemoveAurasDueToSpell(41469);
                return;
            }
            break;
        }
        // Gurtogg Bloodboil: Eject
        case 40486:
        {
            if (!m_caster->CanHaveThreatList())
                return;

            m_caster->getThreatManager().modifyThreatPercent(unitTarget, -40.0f);
            break;
        }
        // Bloodbolt & Blood Splash workaround
        case 41072:
        {
            const int32 damage = irand(3238, 3762);
            const int32 reduction = 0;
            m_caster->CastCustomSpell(unitTarget, 41229, &damage, &reduction, NULL, true);  // workaround not to implement spell effect 141 only for 1 spell
            unitTarget->CastCustomSpell(unitTarget, 41067, &damage, NULL, NULL, true, 0, 0, m_caster->GetGUID());
            break;
        }
        // Gravity Lapse teleports for Kael'thas in MgT
        case 44224:
        {
            if(!m_caster->CanHaveThreatList())
                return;

            uint32 GravityLapseSpellId = 44219; // Id for first teleport spell
            uint32 GravityLapseDOT = (m_caster->GetMap()->IsHeroic()?44226:49887); // knocback + damage
            uint32 GravityLapseChannel = 44251; // visual self-casted, triggers AoE beams
            uint8 counter = 0;

            std::list<HostilReference*> PlayerList = m_caster->getThreatManager().getThreatList();

            if(PlayerList.empty() && m_caster->isInCombat())
                ((Creature*)m_caster)->AI()->EnterEvadeMode();

            for(std::list<HostilReference*>::iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                Unit* pUnit = m_caster->GetMap()->GetUnit((*i)->getUnitGuid());
                if(!pUnit)
                    continue;
                if(pUnit->GetTypeId() != TYPEID_PLAYER)
                    continue;
                if(((Player*)pUnit)->isGameMaster())
                    continue;
                if(pUnit->IsInWorld() && pUnit->IsInMap(m_caster))
                {
                    if(counter < 5) // safety counter for not to pass 5 teleporting spells
                        counter++;
                    else
                        break;
                    m_caster->CastSpell(pUnit, GravityLapseSpellId, true);
                    pUnit->CastSpell(pUnit, GravityLapseDOT, true, 0, 0, m_caster->GetGUID());
                    GravityLapseSpellId++;
                }
            }
            m_caster->CastSpell(m_caster, GravityLapseChannel, true);
            break;
        }
        // Void Reaver: Knock Back
        case 25778:
        {
            if (!m_caster->CanHaveThreatList())
                return;

            m_caster->getThreatManager().modifyThreatPercent(unitTarget, -25.0f);
            break;
        }
        // Incite Chaos
        case 33676:
        {
            m_caster->CastSpell(unitTarget, 33684, true);
            break;
        }

        // PX-238 Winter Wondervolt TRAP
        case 26275:
        {
            if (unitTarget->HasAura(26272,0)
             || unitTarget->HasAura(26157,0)
             || unitTarget->HasAura(26273,0)
             || unitTarget->HasAura(26274,0))
                return;

            uint32 iTmpSpellId;

            switch (urand(0,3))
            {
                case 0:
                    iTmpSpellId = 26272;
                    break;
                case 1:
                    iTmpSpellId = 26157;
                    break;
                case 2:
                    iTmpSpellId = 26273;
                    break;
                case 3:
                    iTmpSpellId = 26274;
                    break;
            }

            unitTarget->CastSpell(unitTarget, iTmpSpellId, true);
            return;
        }

        // Bending Shinbone
        case 8856:
        {
            if (!itemTarget && m_caster->GetTypeId()!=TYPEID_PLAYER)
                return;

            uint32 spell_id = 0;
            switch (urand(1,5))
            {
                case 1:  spell_id = 8854; break;
                default: spell_id = 8855; break;
            }

            m_caster->CastSpell(m_caster,spell_id,true,NULL);
            return;
        }

        // Healthstone creating spells
        case  6201:
        case  6202:
        case  5699:
        case 11729:
        case 11730:
        case 27230:
        {
            uint32 itemtype;
            uint32 rank = 0;

            // imp healthstone rank 1
            if (unitTarget->HasAura(18692))
                rank = 1;

            // imp healthstone rank 2
            if (unitTarget->HasAura(18693))
                rank = 2;

            static uint32 const itypes[6][3] = {
                { 5512,19004,19005},                        // Minor Healthstone
                { 5511,19006,19007},                        // Lesser Healthstone
                { 5509,19008,19009},                        // Healthstone
                { 5510,19010,19011},                        // Greater Healthstone
                { 9421,19012,19013},                        // Major Healthstone
                {22103,22104,22105}                         // Master Healthstone
            };

            switch (GetSpellInfo()->Id)
            {
                case  6201: itemtype=itypes[0][rank];break; // Minor Healthstone
                case  6202: itemtype=itypes[1][rank];break; // Lesser Healthstone
                case  5699: itemtype=itypes[2][rank];break; // Healthstone
                case 11729: itemtype=itypes[3][rank];break; // Greater Healthstone
                case 11730: itemtype=itypes[4][rank];break; // Major Healthstone
                case 27230: itemtype=itypes[5][rank];break; // Master Healthstone
                default:
                    return;
            }
            DoCreateItem(effIndex, itemtype);
            return;
        }
        // Brittle Armor - need remove one 24575 Brittle Armor aura
        case 24590:
            unitTarget->RemoveSingleAuraFromStack(24575, 0);
            unitTarget->RemoveSingleAuraFromStack(24575, 1);
            return;
        // Mercurial Shield - need remove one 26464 Mercurial Shield aura
        case 26465:
            unitTarget->RemoveSingleAuraFromStack(26464, 0);
            return;
        // Orb teleport spells
        case 25140:
        case 25143:
        case 25650:
        case 25652:
        case 29128:
        case 29129:
        case 35376:
        case 35727:
        {
            if (!unitTarget)
                return;

            uint32 spellid = 0;
            switch (GetSpellInfo()->Id)
            {
                case 25140: spellid =  32571; break;
                case 25143: spellid =  32572; break;
                case 25650: spellid =  30140; break;
                case 25652: spellid =  30141; break;
                case 29128: spellid =  32568; break;
                case 29129: spellid =  32569; break;
                case 35376: spellid =  25649; break;
                case 35727: spellid =  35730; break;
                default:
                    return;
            }

            unitTarget->CastSpell(unitTarget, spellid, false);
            return;
        }

        // Shadow Flame (All script effects, not just end ones to prevent player from dodging the last triggered spell)
        case 22539:
        case 22972:
        case 22975:
        case 22976:
        case 22977:
        case 22978:
        case 22979:
        case 22980:
        case 22981:
        case 22982:
        case 22983:
        case 22984:
        case 22985:
        {
            if (!unitTarget || !unitTarget->isAlive())
                return;

            // Onyxia Scale Cloak
            if (unitTarget->GetDummyAura(22683))
                return;

            // Shadow Flame
            m_caster->CastSpell(unitTarget, 22682, true);
            return;
        }
        break;
        case 24194:                                 // Uther's Tribute
        case 24195:                                 // Grom's Tribute
        {
            if (m_caster->GetTypeId() != TYPEID_PLAYER)
                return;

            uint8 race = m_caster->getRace();
            uint32 spellId = 0;

            switch (GetSpellInfo()->Id)
            {
                case 24194:
                    switch (race)
                    {
                        case RACE_HUMAN:            spellId = 24105; break;
                        case RACE_DWARF:            spellId = 24107; break;
                        case RACE_NIGHTELF:         spellId = 24108; break;
                        case RACE_GNOME:            spellId = 24106; break;
                    }
                break;
                case 24195:
                    switch (race)
                    {
                        case RACE_ORC:              spellId = 24104; break;
                        case RACE_UNDEAD_PLAYER:    spellId = 24103; break;
                        case RACE_TAUREN:           spellId = 24102; break;
                        case RACE_TROLL:            spellId = 24101; break;
                    }
                break;
            }

            if (spellId)
                m_caster->CastSpell(m_caster, spellId, true);

            return;
        }
        // Hallowed Wand
        // Random Costume
        case 24720:
        {
            if (!unitTarget || !unitTarget->isAlive())
                return;

            uint32 spellId;
            switch ((uint32)rand32()%7)
            {
                case 0: spellId = 24717; break; // Pirate Costume
                case 1: spellId = 24741; break; // Wisp Costume
                case 2: spellId = 24724; break; // Skeleton Costume
                case 3: spellId = 24719; break; // Leper Gnome Costume
                case 4: spellId = 24718; break; // Ninja Costume
                case 5: spellId = 24737; break; // Ghost Costume
                case 6: spellId = 24733; break; // Bat Costume
            }
            m_caster->CastSpell(unitTarget, spellId, true);
        }
        break;
        // Pirate Costume
        case 24717:
        {
            if (!unitTarget || !unitTarget->isAlive())
                return;

            if (unitTarget->getGender() == GENDER_MALE)
                m_caster->CastSpell(unitTarget,24708,true);
            else
                m_caster->CastSpell(unitTarget,24709,true);
        }
        break;
        // Ninja Costume
        case 24718:
        {
            if (!unitTarget || !unitTarget->isAlive())
                return;

            if (unitTarget->getGender() == GENDER_MALE)
                m_caster->CastSpell(unitTarget,24711,true);
            else
                m_caster->CastSpell(unitTarget,24710,true);
        }
        break;
        // Leper Gnome Costume
        case 24719:
        {
            if (!unitTarget || !unitTarget->isAlive())
                return;

            if (unitTarget->getGender() == GENDER_MALE)
                m_caster->CastSpell(unitTarget,24712,true);
            else
                m_caster->CastSpell(unitTarget,24713,true);
        }
        break;
        // Ghost Costume
        case 24737:
        {
            if (!unitTarget || !unitTarget->isAlive())
                return;

            if (unitTarget->getGender() == GENDER_MALE)
                m_caster->CastSpell(unitTarget,24735,true);
            else
                m_caster->CastSpell(unitTarget,24736,true);
        }
        break;
        case 26218:
        {
            if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            uint32 spells[3] = {26206, 26207, 45036};

            m_caster->CastSpell(unitTarget, spells[urand(0, 2)], true);
            return;
        }
        // Summon Black Qiraji Battle Tank
        case 26656:
        {
            if (!unitTarget)
                return;

            bool dismountOnly = false;

            if (unitTarget->HasAura(25863) || unitTarget->HasAura(26655))
                dismountOnly = true;

            // Prevent stacking of mounts
            unitTarget->RemoveSpellsCausingAura(SPELL_AURA_MOUNTED);

            if (dismountOnly)
                return;

            // Two separate mounts depending on area id (allows use both in and out of specific instance)
            uint32 areaid = unitTarget->GetTypeId() == TYPEID_PLAYER ? ((Player*)unitTarget)->GetCachedArea() : unitTarget->GetAreaId();
            if (areaid == 3428)
                unitTarget->CastSpell(unitTarget, 25863, false);
            else
                unitTarget->CastSpell(unitTarget, 26655, false);
            break;
        }
        // Piccolo of the Flaming Fire
        case 17512:
        {
            if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;
            unitTarget->HandleEmoteCommand(EMOTE_STATE_DANCE);
            break;
        }
        // Netherbloom
        case 28702:
        {
            if (!unitTarget)
                return;
            // 25% chance of casting a random buff
            if (roll_chance_i(75))
                return;

            // triggered spells are 28703 to 28707
            // Note: some sources say, that there was the possibility of
            //       receiving a debuff. However, this seems to be removed by a patch.
            const uint32 spellid = 28703;

            // don't overwrite an existing aura
            for (uint8 i=0; i<5; i++)
                if (unitTarget->HasAura(spellid+i, 0))
                    return;
            unitTarget->CastSpell(unitTarget, spellid+urand(0, 4), true);
            break;
        }

        // Nightmare Vine
        case 28720:
        {
            if (!unitTarget)
                return;
            // 25% chance of casting Nightmare Pollen
            if (roll_chance_i(75))
                return;
            unitTarget->CastSpell(unitTarget, 28721, true);
            break;
        }

        // Mirren's Drinking Hat
        case 29830:
        {
            uint32 item = 0;
            switch (urand(1,6))
            {
                case 1: case 2: case 3: item = 23584; break;// Loch Modan Lager
                case 4: case 5:         item = 23585; break;// Stouthammer Lite
                case 6:                 item = 23586; break;// Aerie Peak Pale Ale
            }
            if (item)
                DoCreateItem(effIndex,item);
            break;
        }
        // Improved Sprint
        case 30918:
        {
            // Removes snares and roots.
            uint32 mechanic_mask = (1<<MECHANIC_ROOT) | (1<<MECHANIC_SNARE);
            Unit::AuraMap& Auras = unitTarget->GetAuras();
            for (Unit::AuraMap::iterator iter = Auras.begin(), next; iter != Auras.end(); iter = next)
            {
                next = iter;
                ++next;
                Aura *aur = iter->second;
                if (!aur->IsPositive())             //only remove negative spells
                {
                    // check for mechanic mask
                    if (SpellMgr::GetSpellMechanicMask(aur->GetSpellProto(), aur->GetEffIndex()) & mechanic_mask)
                    {
                        unitTarget->RemoveAurasDueToSpell(aur->GetId());
                        if (Auras.empty())
                            break;
                        else
                            next = Auras.begin();
                    }
                }
            }
            break;
        }
        // Gruul's Ground Slam
        case 33525:
        {
            if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            // knock back for random distance with random angle
            unitTarget->KnockBack(frand(0.0f, 2*M_PI), frand(2.0f, 40.0f), 15.0f);
            break;
        }
        // Gruul's shatter
        case 33654:
        {
            if (!unitTarget)
                return;

            //Remove Stoned
            unitTarget->RemoveAurasDueToSpell(33652);

            // Only player cast this
            if (unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            unitTarget->CastSpell(unitTarget, 33671, true, 0, 0, m_caster->GetGUID());
            break;
        }
        case 41055:                                 // Copy Weapon
        {
            if (m_caster->GetTypeId() != TYPEID_UNIT || !unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            if (Item* pItem = ((Player*)unitTarget)->GetWeaponForAttack(BASE_ATTACK))
            {
                if (const ItemEntry *dbcitem = sItemStore.LookupEntry(pItem->GetProto()->ItemId))
                {
                    m_caster->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + 0, dbcitem->ID);

                    // Unclear what this spell should do
                    unitTarget->CastSpell(m_caster, GetSpellInfo()->EffectBasePoints[effIndex], true);
                }
            }
            return;
        }
        // Goblin Weather Machine
        case 46203:
        {
            if (!unitTarget)
                return;

            uint32 spellId;
            switch (urand(0,3))
            {
                case 0:
                    spellId=46740;
                    break;
                case 1:
                    spellId=46739;
                    break;
                case 2:
                    spellId=46738;
                    break;
                case 3:
                    spellId=46736;
                    break;
            }
            unitTarget->CastSpell(unitTarget, spellId, true);
            break;
        }
        // Chilling Burst
        case 46541:
        {
            if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            int32 ChillDamage = urand(490, 670);
            Aura* ChillingAura = m_caster->GetAuraByCasterSpell(46542, m_caster->GetGUID());

            unitTarget->CastCustomSpell(unitTarget, 46576, &ChillDamage, NULL, NULL, true, 0, ChillingAura, m_caster->GetGUID());
            break;
        }
        // Headless Horseman's Mount
        case 48025:
        {
                if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
                    return;

                unitTarget->Mount(22653);

                if (GetVirtualMapForMapAndZone(unitTarget->GetMapId(), ((Player*)unitTarget)->GetCachedZone()) != 530)
                {
                    switch (((Player*)unitTarget)->GetBaseSkillValue(SKILL_RIDING))
                    {
                    case 75: unitTarget->CastSpell(unitTarget, 51621, true); break;;
                    case 150: case 225: case 300: unitTarget->CastSpell(unitTarget, 48024, true); break;
                    default: break;
                    }
                }else
                {
                    switch (((Player*)unitTarget)->GetBaseSkillValue(SKILL_RIDING))
                    {
                    case 75: unitTarget->CastSpell(unitTarget, 51621, true); break;;
                    case 150: unitTarget->CastSpell(unitTarget, 48024, true); break;
                    case 225: unitTarget->CastSpell(unitTarget, 51617, true); break;
                    case 300: unitTarget->CastSpell(unitTarget, 48023, true); break;
                    default: break;
                    }
                }
                break;
        }
        case 47977:                                     // Magic Broom
        {
            if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            if (GetVirtualMapForMapAndZone(unitTarget->GetMapId(), ((Player*)unitTarget)->GetCachedZone()) != 530)
            {
                switch (((Player*)unitTarget)->GetBaseSkillValue(SKILL_RIDING))
                {
                case 75: unitTarget->CastSpell(unitTarget, 42681, true); break;;
                case 150: case 225: case 300: unitTarget->CastSpell(unitTarget, 42683, true); break;
                default: break;
                }
            }
            else
            {
                switch (((Player*)unitTarget)->GetBaseSkillValue(SKILL_RIDING))
                {
                case 75: unitTarget->CastSpell(unitTarget, 42681, true); break;;
                case 150: unitTarget->CastSpell(unitTarget, 42684, true); break;
                case 225: unitTarget->CastSpell(unitTarget, 42673, true); break;
                case 300: unitTarget->CastSpell(unitTarget, 42679, true); break;
                default: break;
                }
            }
            break;
        }
        // Fixated
        case 40893:
        {
            m_caster->CastSpell(m_caster, 40893, false);
        }
        // Summon Shadowfiends
        case 39649:
        {
            uint8 random = urand(8, 12);
            for (uint8 i = 0; i < random; ++i)
            {
                m_caster->CastSpell(m_caster, 41159, true);
            }
            break;
        }
        // Green Helper Box, Red Helper Box, Snowman Kit, Jingling Bell
        case 26532:
        case 26541:
        case 26469:
        case 26528:
        {
            uint32 summon_spell_entry = 0;
            switch (GetSpellInfo()->Id)
            {
                case 26532: //green
                    summon_spell_entry = 26533;
                    break;
                case 26541: //red
                    summon_spell_entry = 26536;
                    break;
                case 26469: //snowman
                    summon_spell_entry = 26045;
                    break;
                case 26528: //reindeer
                    summon_spell_entry = 26529;
                    break;
            }

            if (!summon_spell_entry)
                return;

            m_caster->CastSpell(m_caster, summon_spell_entry, false);

            break;
        }
        case 42924:
        {
            Aura* aur = m_caster->GetAura(42924, 0);
            if(aur && aur->GetStackAmount() < 4)
                break;

            if(aur && aur->GetStackAmount() == 11)
            {
                m_caster->CastSpell(m_caster, 42936, true);
                break;
            }

            if(m_caster->HasAura(42993, 2))
            {
                m_caster->RemoveAurasDueToSpell(42993);
                m_caster->CastSpell(m_caster, 42994, true);
            }
            else if(m_caster->HasAura(42992, 2))
            {
                m_caster->RemoveAurasDueToSpell(42992);
                m_caster->CastSpell(m_caster, 42993, true);
            }
            else if(m_caster->HasAura(43310, 2))
            {
                m_caster->RemoveAurasDueToSpell(43310);
                m_caster->CastSpell(m_caster, 42992, true);
            }
            break;
        }
        case 51508:
        {
            m_caster->HandleEmoteCommand(EMOTE_STATE_DANCE);
            break;
        }
        case 42436:
        {
            switch(unitTarget->GetEntry())
            {
            case 24108:
                //((Player*)m_caster)->CastedCreatureOrGO(unitTarget->GetEntry(), unitTarget->GetGUID(), 0);
                m_caster->CastSpell(m_caster, 47173, true);
                break;
            case 23709:
                m_caster->CastSpell(m_caster, 47171, true);
                m_caster->Kill(unitTarget, false);
                break;
            default:
                break;
            }
            break;
        }
        case 40638: //Willy Focus
        {
            m_caster->CastSpell(unitTarget, damage ,false);
            break;
        }
    }

    if (!unitTarget || !unitTarget->isAlive()) // can we remove this check?
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Spell %u in EffectScriptEffect does not have unitTarget", GetSpellInfo()->Id);
        return;
    }

    switch (GetSpellInfo()->Id)
    {
        // Dreaming Glory
        case 28698:
            unitTarget->CastSpell(unitTarget, 28694, true);
            return;
        // Needle Spine
        //case 39835: unitTarget->CastSpell(unitTarget, 39968, true); break;
        // Draw Soul
        case 40904:
            unitTarget->CastSpell(m_caster, 40903, true);
            return;
        // Flame Crash
        case 41126:
            unitTarget->CastSpell(unitTarget, 41131, true);
            return;
        case 41931:
        {
            int bag=19;
            int slot=0;
            Item* item = NULL;

            while (bag < 256)
            {
                item = ((Player*)m_caster)->GetItemByPos(bag,slot);
                if (item && item->GetEntry() == 38587) break;
                slot++;
                if (slot == 39)
                {
                    slot = 0;
                    bag++;
                }
            }

            if (bag < 256)
            {
                if (((Player*)m_caster)->GetItemByPos(bag,slot)->GetCount() == 1) ((Player*)m_caster)->RemoveItem(bag,slot,true);
                else ((Player*)m_caster)->GetItemByPos(bag,slot)->SetCount(((Player*)m_caster)->GetItemByPos(bag,slot)->GetCount()-1);
                // Spell 42518 (Braufest - Gratisprobe des Braufest herstellen)
                m_caster->CastSpell(m_caster,42518,true);
            }

            return;
        }
        // Force Cast - Portal Effect: Sunwell Isle
        case 44876:
        {
            unitTarget->CastSpell(unitTarget, 44870, true);
            return;
        }
        //Brutallus - Burn
        case 45141: case 45151:
        {
            //Workaround for Range ... should be global for every ScriptEffect
            float radius = SpellMgr::GetSpellRadius(GetSpellInfo(), effIndex, false);
            //if (unitTarget && unitTarget->GetTypeId() == TYPEID_PLAYER && unitTarget->GetDistance(m_caster) <= radius && !unitTarget->HasAura(46394,0) && unitTarget != m_caster)
            if(!unitTarget->HasAura(46394, 0) && unitTarget != m_caster)
                unitTarget->CastSpell(unitTarget,46394,true, 0, 0, m_originalCasterGUID);

            return;
        }
        // spell of Brutallus - Stomp
        case 45185:
        {
            if (unitTarget->HasAura(46394, 0)) // spell of Brutallus - Burn
                unitTarget->RemoveAurasDueToSpell(46394);
            return;
        }
        case 45206:                                 // Copy Off-hand Weapon
        {
            if (m_caster->GetTypeId() != TYPEID_UNIT || !unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            if (Item* pItem = ((Player*)unitTarget)->GetWeaponForAttack(OFF_ATTACK))
            {
                if (const ItemEntry *dbcitem = sItemStore.LookupEntry(pItem->GetProto()->ItemId))
                {
                    m_caster->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + 1, dbcitem->ID);

                    // Unclear what this spell should do
                    unitTarget->CastSpell(m_caster, GetSpellInfo()->EffectBasePoints[effIndex], true);
                }
            }
            return;
        }
        // Negative Energy - Entropius
        case 46289:
        {
            if(unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;
            int32 damage = irand(1885, 2115);
            m_caster->CastCustomSpell(unitTarget, 46285, &damage, 0, 0, true, 0, 0, m_caster->GetGUID());
            damage /= 2;
            if(Unit* target_2 = unitTarget->ToPlayer()->GetNextRandomRaidMember(10.0f, true))
            {
                unitTarget->CastCustomSpell(target_2, 46285, &damage, 0, 0, true, 0, 0, m_caster->GetGUID());
                damage /= 2;
                if(Unit* target_3 = target_2->ToPlayer()->GetNextRandomRaidMember(10.0f, true))
                    target_2->CastCustomSpell(target_3, 46285, &damage, 0, 0, true, 0, 0, m_caster->GetGUID());
            }
            return;
        }
        //5,000 Gold
        case 46642:
        {
            //if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            //    ((Player*)unitTarget)->ModifyMoney(50000000);
            return;
        }
        case 48917:
        {
            if (unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            // Male Shadowy Disguise / Female Shadowy Disguise
            unitTarget->CastSpell(unitTarget, unitTarget->getGender() == GENDER_MALE ? 38080 : 38081, true);
            // Shadowy Disguise
            unitTarget->CastSpell(unitTarget, 32756, true);
            return;
        }
        // Listening to Music (Parent)
        case 50499:
        {
            if (unitTarget->GetTypeId() != TYPEID_PLAYER)
                return;

            unitTarget->CastSpell(unitTarget, 50493, true);
            return;
        }
        // Cleansing Flames
        case 29137: // Stormwind
            if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            {
                Player * tmpPl = (Player*)unitTarget;
                // check horde only quest status: Stealing Stormwind's Flame
                if (tmpPl->GetTeam() == HORDE)
                    if (tmpPl->GetQuestStatus(9330) != QUEST_STATUS_COMPLETE && !tmpPl->GetQuestRewardStatus(9330))
                        if (!tmpPl->HasItemCount(23182, 1, true))
                            tmpPl->CastSpell(tmpPl, 29101, true);
            }
            break;
        case 29126: // Darnasus
            if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            {
                Player * tmpPl = (Player*)unitTarget;
                // check horde only quest status: Stealing Darnasus's Flame
                if (tmpPl->GetTeam() == HORDE)
                    if (tmpPl->GetQuestStatus(9332) != QUEST_STATUS_COMPLETE && !tmpPl->GetQuestRewardStatus(9332))
                        if (!tmpPl->HasItemCount(23184, 1, true))
                            tmpPl->CastSpell(tmpPl, 29099, true);
            }
            break;
        case 29135: // Ironforge
            if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            {
                Player * tmpPl = (Player*)unitTarget;
                // check horde only quest status: Stealing Ironforge's Flame
                if (tmpPl->GetTeam() == HORDE)
                    if (tmpPl->GetQuestStatus(9331) != QUEST_STATUS_COMPLETE && !tmpPl->GetQuestRewardStatus(9331))
                        if (!tmpPl->HasItemCount(23183, 1, true))
                            tmpPl->CastSpell(tmpPl, 29102, true);
            }
            break;
        case 29136: // Orgrimmar
            if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            {
                Player * tmpPl = (Player*)unitTarget;
                // check alliance only quest status: Stealing Orgrimmar's Flame
                if (tmpPl->GetTeam() == ALLIANCE)
                    if (tmpPl->GetQuestStatus(9324) != QUEST_STATUS_COMPLETE && !tmpPl->GetQuestRewardStatus(9324))
                        if (!tmpPl->HasItemCount(23179, 1, true))
                            tmpPl->CastSpell(tmpPl, 29130, true);
            }
            break;
        case 46672: // Silvermoon
            if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            {
                Player * tmpPl = (Player*)unitTarget;
                // check alliance only quest status: Stealing Silvermoon's Flame
                if (tmpPl->GetTeam() == ALLIANCE)
                    if (tmpPl->GetQuestStatus(11935) != QUEST_STATUS_COMPLETE && !tmpPl->GetQuestRewardStatus(11935))
                        if (!tmpPl->HasItemCount(35568, 1, true))
                            tmpPl->CastSpell(tmpPl, 46689, true);
            }
            break;
        case 29138: // Thunder Bluff
            if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            {
                Player * tmpPl = (Player*)unitTarget;
                // check alliance only quest status: Stealing Thunder Bluff's Flame
                if (tmpPl->GetTeam() == ALLIANCE)
                    if (tmpPl->GetQuestStatus(9325) != QUEST_STATUS_COMPLETE && !tmpPl->GetQuestRewardStatus(9325))
                        if (!tmpPl->HasItemCount(23180, 1, true))
                            tmpPl->CastSpell(tmpPl, 29132, true);
            }
            break;
        case 46671: // Exodar
            if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            {
                Player * tmpPl = (Player*)unitTarget;
                // check horde only quest status: Stealing the Exodar's Flame
                if (tmpPl->GetTeam() == HORDE)
                    if (tmpPl->GetQuestStatus(11933) != QUEST_STATUS_COMPLETE && !tmpPl->GetQuestRewardStatus(11933))
                        if (!tmpPl->HasItemCount(35569, 1, true))
                            tmpPl->CastSpell(tmpPl, 46690, true);
            }
            break;
        case 29139: // Undercity
            if (unitTarget->GetTypeId() == TYPEID_PLAYER)
            {
                Player * tmpPl = (Player*)unitTarget;
                // check alliance only quest status: Stealing the Undercity's Flame
                if (tmpPl->GetTeam() == ALLIANCE)
                    if (tmpPl->GetQuestStatus(9326) != QUEST_STATUS_COMPLETE && !tmpPl->GetQuestRewardStatus(9326))
                        if (!tmpPl->HasItemCount(23181, 1, true))
                            tmpPl->CastSpell(tmpPl, 29133, true);
            }
            break;
        case 38650: // Rancid Mushroom
            m_caster->SummonCreature(22250, unitTarget->GetPositionX(), unitTarget->GetPositionY(), unitTarget->GetPositionZ(), unitTarget->GetOrientation(),
                    TEMPSUMMON_DEAD_DESPAWN, 0);
            break;
        case 45235: // Eredar Twins: Blaze
            unitTarget->CastSpell(unitTarget, 45236, true, NULL, NULL, m_caster->GetGUID());
            break;
        case 30541: // Magtheridon's Blaze
            unitTarget->CastSpell(unitTarget, 30542, true, NULL, NULL, m_caster->GetGUID());
            break;
    }

    if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_PALADIN)
    {
        switch (GetSpellInfo()->SpellFamilyFlags)
        {
            // Judgement
            case 0x800000:
            {
                uint32 spellId2 = 0;

                // all seals have aura dummy
                Unit::AuraList const& m_dummyAuras = m_caster->GetAurasByType(SPELL_AURA_DUMMY);
                for (Unit::AuraList::const_iterator itr = m_dummyAuras.begin(); itr != m_dummyAuras.end(); ++itr)
                {
                    SpellEntry const *spellInfo = (*itr)->GetSpellProto();

                    // search seal (all seals have judgement's aura dummy spell id in 2 effect
                    if (!spellInfo || !SpellMgr::IsSealSpell((*itr)->GetSpellProto()) || (*itr)->GetEffIndex() != 2)
                        continue;

                    // must be calculated base at raw base points in spell proto, GetModifier()->m_value for S.Righteousness modified by SPELLMOD_DAMAGE
                    spellId2 = (*itr)->GetSpellProto()->EffectBasePoints[2]+1;

                    if (spellId2 <= 1)
                        continue;

                    // found, remove seal
                    m_caster->RemoveAurasDueToSpell((*itr)->GetId());

                    // Sanctified Judgement
                    Unit::AuraList const& m_auras = m_caster->GetAurasByType(SPELL_AURA_DUMMY);
                    for (Unit::AuraList::const_iterator i = m_auras.begin(); i != m_auras.end(); ++i)
                    {
                        if ((*i)->GetSpellProto()->SpellIconID == 205 && (*i)->GetSpellProto()->Attributes == 0x01D0LL)
                        {
                            int32 chance = (*i)->GetModifier()->m_amount;
                            if (roll_chance_i(chance))
                            {
                                int32 mana = SpellMgr::CalculatePowerCost(spellInfo, m_caster, SPELL_SCHOOL_MASK_NONE);
                                mana = int32(mana* 0.8f);
                                m_caster->CastCustomSpell(m_caster,31930,&mana,NULL,NULL,true,NULL,*i);
                            }
                            break;
                        }
                    }

                    break;
                }

                m_caster->CastSpell(unitTarget,spellId2,false);
                return;
            }
        }
    }

    // normal DB scripted effect
    sLog.outDebug("Spell ScriptStart spellid %u in EffectScriptEffect ", GetSpellInfo()->Id);
    m_caster->GetMap()->ScriptsStart(sSpellScripts, GetSpellInfo()->Id, m_caster, unitTarget);
}

void Spell::EffectSanctuary(uint32 /*i*/)
{
    if (!unitTarget)
        return;

    std::list<Unit*> targets;

    Looking4group::AnyUnfriendlyUnitInObjectRangeCheck u_check(unitTarget, unitTarget, m_caster->GetMap()->GetVisibilityDistance());
    Looking4group::UnitListSearcher<Looking4group::AnyUnfriendlyUnitInObjectRangeCheck> searcher(targets, u_check);

    Cell::VisitAllObjects(unitTarget, searcher, m_caster->GetMap()->GetVisibilityDistance());

    for (std::list<Unit*>::iterator iter = targets.begin(); iter != targets.end(); ++iter)
    {
        if (!(*iter)->hasUnitState(UNIT_STAT_CASTING))
            continue;

        for (uint32 i = CURRENT_FIRST_NON_MELEE_SPELL; i < CURRENT_MAX_SPELL; i++)
        {
            if ((*iter)->m_currentSpells[i]
            && (*iter)->m_currentSpells[i]->m_targets.getUnitTargetGUID() == unitTarget->GetGUID())
            {
                (*iter)->InterruptSpell(i, false);
            }
        }
    }

    unitTarget->CombatStop();
    unitTarget->getHostilRefManager().deleteReferences();   // stop all fighting
    // Vanish allows to remove all threat and cast regular stealth so other spells can be used
    if (GetSpellInfo()->SpellFamilyName == SPELLFAMILY_ROGUE && (GetSpellInfo()->SpellFamilyFlags & SPELLFAMILYFLAG_ROGUE_VANISH))
    {
        ((Player *)m_caster)->RemoveSpellsCausingAura(SPELL_AURA_MOD_ROOT);
    }
}

void Spell::EffectAddComboPoints(uint32 /*i*/)
{
    if (!unitTarget)
        return;

    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    if (damage <= 0)
        return;

    ((Player*)m_caster)->AddComboPoints(unitTarget, damage);
}

void Spell::EffectDuel(uint32 i)
{
    if (sWorld.getConfig(CONFIG_DISABLE_DUEL))
        return;

    if (!m_caster || !unitTarget || m_caster->GetTypeId() != TYPEID_PLAYER || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    Player *caster = (Player*)m_caster;
    Player *target = (Player*)unitTarget;

    // caster or target already have requested duel
    if (caster->duel || target->duel || !target->GetSocial() || target->GetSocial()->HasIgnore(caster->GetGUIDLow()))
        return;

    // Players can only fight a duel in zones with this flag
    AreaTableEntry const* casterAreaEntry = GetAreaEntryByAreaID(caster->GetCachedArea());
    if (casterAreaEntry && !(casterAreaEntry->flags & AREA_FLAG_ALLOW_DUELS))
    {
        SendCastResult(SPELL_FAILED_NO_DUELING);            // Dueling isn't allowed here
        return;
    }

    AreaTableEntry const* targetAreaEntry = GetAreaEntryByAreaID(target->GetCachedArea());
    if (targetAreaEntry && !(targetAreaEntry->flags & AREA_FLAG_ALLOW_DUELS))
    {
        SendCastResult(SPELL_FAILED_NO_DUELING);            // Dueling isn't allowed here
        return;
    }

    //CREATE DUEL FLAG OBJECT
    GameObject* pGameObj = new GameObject;

    uint32 gameobject_id = GetSpellInfo()->EffectMiscValue[i];

    Map *map = m_caster->GetMap();
    if (!pGameObj->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT), gameobject_id, map,
        m_caster->GetPositionX()+(unitTarget->GetPositionX()-m_caster->GetPositionX())/2 ,
        m_caster->GetPositionY()+(unitTarget->GetPositionY()-m_caster->GetPositionY())/2 ,
        m_caster->GetPositionZ(),
        m_caster->GetOrientation(), 0, 0, 0, 0, 0, GO_STATE_READY))
    {
        delete pGameObj;
        return;
    }

    pGameObj->SetUInt32Value(GAMEOBJECT_FACTION, m_caster->getFaction());
    pGameObj->SetUInt32Value(GAMEOBJECT_LEVEL, m_caster->getLevel()+1);
    int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());
    pGameObj->SetRespawnTime(duration > 0 ? duration/1000 : 0);
    pGameObj->SetSpellId(GetSpellInfo()->Id);

    m_caster->AddGameObject(pGameObj);
    map->Add(pGameObj);
    //END

    // Send request
    WorldPacket data(SMSG_DUEL_REQUESTED, 16);
    data << pGameObj->GetGUID();
    data << caster->GetGUID();
    caster->SendPacketToSelf(&data);
    target->SendPacketToSelf(&data);

    // create duel-info
    DuelInfo *duel   = new DuelInfo;
    duel->initiator  = caster;
    duel->opponent   = target;
    duel->startTime  = 0;
    duel->startTimer = 0;
    caster->duel     = duel;

    DuelInfo *duel2   = new DuelInfo;
    duel2->initiator  = caster;
    duel2->opponent   = caster;
    duel2->startTime  = 0;
    duel2->startTimer = 0;
    target->duel      = duel2;

    caster->SetUInt64Value(PLAYER_DUEL_ARBITER,pGameObj->GetGUID());
    target->SetUInt64Value(PLAYER_DUEL_ARBITER,pGameObj->GetGUID());
}

void Spell::EffectStuck(uint32 /*i*/)
{
    if (!unitTarget)
        return;

    Player* pTarget = unitTarget->ToPlayer();

    if (!pTarget || !sWorld.getConfig(CONFIG_CAST_UNSTUCK))
        return;

    sLog.outDetail("Player %s (guid %u) used auto-unstuck future at map %u (%f, %f, %f)", pTarget->GetName(), pTarget->GetGUIDLow(), m_caster->GetMapId(), m_caster->GetPositionX(), pTarget->GetPositionY(), pTarget->GetPositionZ());

    // player stucked on arena or bg just should leave ;]
    if (pTarget->IsTaxiFlying() || pTarget->InArenaOrBG())
        return;

    // if player isn't alive repop him on nearest graveyard (for stucking while in ghost)
    if (pTarget->isAlive())
    {
        // if player hasn't cooldown on HearthStone and have in bags then use him
        // otherwise teleport to player start location
        if (!pTarget->GetSpellCooldownDelay(8690) && pTarget->HasItemCount(6948, 1))
            pTarget->CastSpell(pTarget, 8690, true);
        else
            if (PlayerInfo const * tmpPlInfo = sObjectMgr.GetPlayerInfo(pTarget->getRace(), pTarget->getClass()))
                pTarget->TeleportTo(tmpPlInfo->mapId, tmpPlInfo->positionX, tmpPlInfo->positionY, tmpPlInfo->positionZ, 0.0f);
    }
    else
    {
        if (!pTarget->GetCorpse())
            pTarget->BuildPlayerRepop();
        pTarget->TeleportToNearestGraveyard();
    }
}

void Spell::EffectSummonPlayer(uint32 /*i*/)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    // Evil Twin (ignore player summon, but hide this for summoner)
    if (unitTarget->GetDummyAura(23445))
        return;

    if (!unitTarget->ToPlayer()->CanBeSummonedBy(m_caster->ToPlayer()))
        return;

    const Player * pCaster = m_caster->ToPlayer();
    float x,y,z;
    m_caster->GetPosition(x,y,z);

    unitTarget->ToPlayer()->SetSummonPoint(m_caster->GetMapId(),x,y,z+1.0f);

    uint32 zoneid = pCaster ? pCaster->GetCachedZone() : m_caster->GetZoneId();

    WorldPacket data(SMSG_SUMMON_REQUEST, 8+4+4);
    data << uint64(m_caster->GetGUID());                    // summoner guid
    data << uint32(zoneid);                                 // summoner zone
    data << uint32(MAX_PLAYER_SUMMON_DELAY*1000);           // auto decline after msecs
    unitTarget->ToPlayer()->SendPacketToSelf(&data);
}

static ScriptInfo generateActivateCommand()
{
    ScriptInfo si;
    si.command = SCRIPT_COMMAND_ACTIVATE_OBJECT;
    return si;
}

void Spell::EffectActivateObject(uint32 effect_idx)
{
    if (!gameObjTarget)
        return;

    static ScriptInfo activateCommand = generateActivateCommand();

    int32 delay_secs = GetSpellInfo()->EffectMiscValue[effect_idx];

    gameObjTarget->GetMap()->ScriptCommandStart(activateCommand, delay_secs, m_caster, gameObjTarget);
}

void Spell::EffectSummonTotem(uint32 i)
{
    uint8 slot = 0;
    switch (GetSpellInfo()->EffectMiscValueB[i])
    {
        case SUMMON_TYPE_TOTEM_SLOT1: slot = 0; break;
        case SUMMON_TYPE_TOTEM_SLOT2: slot = 1; break;
        case SUMMON_TYPE_TOTEM_SLOT3: slot = 2; break;
        case SUMMON_TYPE_TOTEM_SLOT4: slot = 3; break;
        // Battle standard case
        case SUMMON_TYPE_TOTEM:       slot = 254; break;
        // jewelery statue case, like totem without slot
        case SUMMON_TYPE_GUARDIAN:    slot = 255; break;
        default: return;
    }

    if (slot < MAX_TOTEM)
    {
        uint64 guid = m_caster->m_TotemSlot[slot];
        if (guid != 0)
        {
            Creature *OldTotem = m_caster->GetMap()->GetCreature(guid);
            if (OldTotem && OldTotem->isTotem())
                ((Totem*)OldTotem)->UnSummon();
        }
    }

    uint32 team = 0;
    if (m_caster->GetTypeId()==TYPEID_PLAYER)
        if (m_caster->ToPlayer()->GetBattleGround() && !m_caster->ToPlayer()->GetBattleGround()->isArena())
            team = ((Player*)m_caster)->GetBGTeam();
        else
            team = ((Player*)m_caster)->GetTeam();

    Position dest;
    dest.x = m_targets.m_destX;
    dest.y = m_targets.m_destY;
    dest.z = m_targets.m_destZ;

    Totem* pTotem = new Totem;
    if (!pTotem->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_UNIT), m_caster->GetMap(), GetSpellInfo()->EffectMiscValue[i], team, dest.x, dest.y, dest.z, m_caster->GetOrientation()))
    {
        delete pTotem;
        return;
    }

    if (slot < MAX_TOTEM)
        m_caster->m_TotemSlot[slot] = pTotem->GetGUID();

    pTotem->SetOwner(m_caster->GetGUID());
    pTotem->SetTypeBySummonSpell(GetSpellInfo());              // must be after Create call where m_spells initilized

    int32 duration=SpellMgr::GetSpellDuration(GetSpellInfo());
    if (Player* modOwner = m_caster->GetSpellModOwner())
        modOwner->ApplySpellMod(GetSpellInfo()->Id,SPELLMOD_DURATION, duration);

    pTotem->SetDuration(duration);

    if (damage)                                             // if not spell info, DB values used
    {
        pTotem->SetMaxHealth(damage);
        pTotem->SetHealth(damage);
    }

    pTotem->SetUInt32Value(UNIT_CREATED_BY_SPELL,GetSpellInfo()->Id);
    pTotem->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_PVP_ATTACKABLE);

    pTotem->ApplySpellImmune(GetSpellInfo()->Id,IMMUNITY_STATE,SPELL_AURA_MOD_FEAR,true);
    pTotem->ApplySpellImmune(GetSpellInfo()->Id,IMMUNITY_STATE,SPELL_AURA_TRANSFORM,true);

    if (slot < MAX_TOTEM && m_caster->GetTypeId() == TYPEID_PLAYER)
    {
        WorldPacket data(SMSG_TOTEM_CREATED, 17);
        data << uint8(slot);
        data << uint64(pTotem->GetGUID());
        data << uint32(duration);
        data << uint32(GetSpellInfo()->Id);
        ((Player*)m_caster)->SendPacketToSelf(&data);
    }

    pTotem->Summon(m_caster);
}

void Spell::EffectEnchantHeldItem(uint32 i)
{
    // this is only item spell effect applied to main-hand weapon of target player (players in area)
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* item_owner = (Player*)unitTarget;
    Item* item = item_owner->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);

    if (!item)
        return;

    // must be equipped
    if (!item ->IsEquipped())
        return;

    if (GetSpellInfo()->EffectMiscValue[i])
    {
        uint32 enchant_id = GetSpellInfo()->EffectMiscValue[i];
        int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());          //Try duration index first ..
        if (!duration)
            duration = damage;//+1;            //Base points after ..
        if (!duration)
            duration = 10;                                  //10 seconds for enchants which don't have listed duration

        SpellItemEnchantmentEntry const *pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
        if (!pEnchant)
            return;

        // Always go to temp enchantment slot
        EnchantmentSlot slot = TEMP_ENCHANTMENT_SLOT;

        // Enchantment will not be applied if a different one already exists
        if (item->GetEnchantmentId(slot) && item->GetEnchantmentId(slot) != enchant_id)
            return;

        // Apply the temporary enchantment
        item->SetEnchantment(slot, enchant_id, duration*1000, 0);
        item_owner->ApplyEnchantment(item,slot,true);
    }
}

void Spell::EffectDisEnchant(uint32 /*i*/)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* p_caster = (Player*)m_caster;
    if (!itemTarget || !itemTarget->GetProto()->DisenchantID)
        return;

    p_caster->UpdateCraftSkill(GetSpellInfo()->Id);

    ((Player*)m_caster)->SendLoot(itemTarget->GetGUID(),LOOT_DISENCHANTING);

    // item will be removed at disenchanting end
}

void Spell::EffectInebriate(uint32 /*i*/)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    Player *player = (Player*)unitTarget;
    uint16 currentDrunk = player->GetDrunkValue();
    uint16 drunkMod = damage * 256;
    if (currentDrunk + drunkMod > 0xFFFF)
        currentDrunk = 0xFFFF;
    else
        currentDrunk += drunkMod;
    player->SetDrunkValue(currentDrunk, m_CastItem?m_CastItem->GetEntry():0);
}

void Spell::EffectFeedPet(uint32 i)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player *_player = (Player*)m_caster;

    if (!itemTarget)
        return;

    Pet *pet = _player->GetPet();
    if (!pet)
        return;

    if (!pet->isAlive())
        return;

    int32 benefit = pet->GetCurrentFoodBenefitLevel(itemTarget->GetProto()->ItemLevel);
    if (benefit <= 0)
        return;

    uint32 count = 1;
    _player->DestroyItemCount(itemTarget,count,true);
    // TODO: fix crash when a spell has two effects, both pointed at the same item target

    m_caster->CastCustomSpell(m_caster,GetSpellInfo()->EffectTriggerSpell[i],&benefit,NULL,NULL,true);
}

void Spell::EffectDismissPet(uint32 /*i*/)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Pet* pet = m_caster->GetPet();

    // not let dismiss dead pet
    if (!pet||!pet->isAlive())
        return;

    ((Player*)m_caster)->RemovePet(pet,PET_SAVE_NOT_IN_SLOT);
}

void Spell::EffectSummonObject(uint32 i)
{
    uint32 go_id = GetSpellInfo()->EffectMiscValue[i];

    uint8 slot = 0;
    switch (GetSpellInfo()->Effect[i])
    {
        case SPELL_EFFECT_SUMMON_OBJECT_SLOT1: slot = 0; break;
        case SPELL_EFFECT_SUMMON_OBJECT_SLOT2: slot = 1; break;
        case SPELL_EFFECT_SUMMON_OBJECT_SLOT3: slot = 2; break;
        case SPELL_EFFECT_SUMMON_OBJECT_SLOT4: slot = 3; break;
        default: return;
    }

    uint64 guid = m_caster->m_ObjectSlot[slot];
    if (guid)
    {
        if (GameObject* obj = m_caster ? m_caster->GetMap()->GetGameObject(guid) : NULL)
            obj->SetLootState(GO_JUST_DEACTIVATED);

        m_caster->m_ObjectSlot[slot] = 0;
    }

    GameObject* pGameObj = new GameObject;

    float x,y,z;
    // If dest location if present
    if (m_targets.m_targetMask & TARGET_FLAG_DEST_LOCATION)
    {
        x = m_targets.m_destX;
        y = m_targets.m_destY;
        z = m_targets.m_destZ;
    }
    // Summon in random point all other units if location present
    else
        m_caster->GetNearPoint(x,y,z,DEFAULT_WORLD_OBJECT_SIZE);

    Map *map = m_caster->GetMap();
    if (!pGameObj->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT), go_id, map, x, y, z, m_caster->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 0, GO_STATE_READY))
    {
        delete pGameObj;
        return;
    }

    //pGameObj->SetUInt32Value(GAMEOBJECT_LEVEL,m_caster->getLevel());
    int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());
    pGameObj->SetRespawnTime(duration > 0 ? duration/1000 : 0);
    pGameObj->SetSpellId(GetSpellInfo()->Id);
    m_caster->AddGameObject(pGameObj);

    map->Add(pGameObj);
    WorldPacket data(SMSG_GAMEOBJECT_SPAWN_ANIM_OBSOLETE, 8);
    data << pGameObj->GetGUID();
    m_caster->BroadcastPacket(&data,true);

    m_caster->m_ObjectSlot[slot] = pGameObj->GetGUID();
}

void Spell::EffectResurrect(uint32 /*effIndex*/)
{
    if (!unitTarget || !unitTarget->IsInWorld() || unitTarget->isAlive())
        return;

    switch (GetSpellInfo()->Id)
    {
        // Defibrillate (Goblin Jumper Cables) have 33% chance on success
        case 8342:
            if (roll_chance_i(67))
            {
                m_caster->CastSpell(m_caster, 8338, true, m_CastItem);
                return;
            }
            break;
        // Defibrillate (Goblin Jumper Cables XL) have 50% chance on success
        case 22999:
            if (roll_chance_i(50))
            {
                m_caster->CastSpell(m_caster, 23055, true, m_CastItem);
                return;
            }
            break;
        default:
            break;
    }

    if (Player* pTarget = unitTarget->ToPlayer())
    {
        if (pTarget->isRessurectRequested())       // already have one active request
            return;

        uint32 health = pTarget->GetMaxHealth() * damage / 100;
        uint32 mana   = pTarget->GetMaxPower(POWER_MANA) * damage / 100;

        pTarget->setResurrectRequestData(m_caster->GetGUID(), m_caster->GetMapId(), m_caster->GetPositionX(), m_caster->GetPositionY(), m_caster->GetPositionZ(), health, mana);
        SendResurrectRequest(pTarget);
    }
    else if (Pet* pet = unitTarget->ToPet())
    {
        if (pet->getPetType() != HUNTER_PET || pet->isAlive())
            return;

        float x, y, z;
        m_caster->GetPosition(x, y, z);
        pet->NearTeleportTo(x, y, z, m_caster->GetOrientation());

        pet->SetUInt32Value(UNIT_DYNAMIC_FLAGS, 0);
        pet->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);
        pet->setDeathState(ALIVE);
        pet->clearUnitState(UNIT_STAT_ALL_STATE);
        pet->SetHealth(uint32(pet->GetMaxHealth() * damage / 100));

        pet->SavePetToDB(PET_SAVE_AS_CURRENT);
    }
}

void Spell::EffectAddExtraAttacks(uint32 /*i*/)
{
    if (!unitTarget || !unitTarget->isAlive())
        return;

    if (unitTarget->m_extraAttacks)
        return;

    Unit *victim = unitTarget->getVictim();

    // attack prevented
    // fixme, some attacks may not target current victim, this is right now not handled
    if (!victim || !unitTarget->IsWithinMeleeRange(victim) || !unitTarget->HasInArc(2*M_PI/3, victim))
        return;

    // Only for proc/log informations
    unitTarget->m_extraAttacks = damage;

    // Need to send log before attack is made
    SendLogExecute();
    m_needSpellLog = false;

    unitTarget->HandleProcExtraAttackFor(victim);
}

void Spell::EffectParry(uint32 /*i*/)
{
    if (unitTarget->GetTypeId() == TYPEID_PLAYER)
    {
        ((Player*)unitTarget)->SetCanParry(true);
    }
}

void Spell::EffectBlock(uint32 /*i*/)
{
    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    ((Player*)unitTarget)->SetCanBlock(true);
}

void Spell::EffectLeapForward(uint32 i)
{
    if (unitTarget->IsTaxiFlying())
        return;

    if (GetSpellInfo()->rangeIndex == 1)                        //self range
    {
        Position dest;
        dest.x = m_targets.m_destX;
        dest.y = m_targets.m_destY;
        dest.z = m_targets.m_destZ;

        unitTarget->NearTeleportTo(dest.x, dest.y, dest.z, unitTarget->GetOrientation(), unitTarget == m_caster);
    }
}

void Spell::EffectLeapBack(uint32 i)
{
    if (unitTarget->IsTaxiFlying())
        return;

    m_caster->KnockBackFrom(unitTarget,float(GetSpellInfo()->EffectMiscValue[i])/10,float(damage)/10);
}

void Spell::EffectReputation(uint32 i)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    Player *_player = (Player*)unitTarget;

    int32  rep_change = damage;//+1;           // field store reputation change -1

    uint32 faction_id = GetSpellInfo()->EffectMiscValue[i];

    FactionEntry const* factionEntry = sFactionStore.LookupEntry(faction_id);

    if (!factionEntry)
        return;

    rep_change = _player->CalculateReputationGain(REPUTATION_SOURCE_SPELL, rep_change, faction_id);

    _player->GetReputationMgr().ModifyReputation(factionEntry,rep_change);
}

void Spell::EffectQuestComplete(uint32 i)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player *_player = (Player*)m_caster;

    uint32 quest_id = GetSpellInfo()->EffectMiscValue[i];
    _player->AreaExploredOrEventHappens(quest_id);
}

void Spell::EffectSelfResurrect(uint32 i)
{
    if (!unitTarget || unitTarget->isAlive())
        return;
    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;
    if (!unitTarget->IsInWorld())
        return;

    uint32 health = 0;
    uint32 mana = 0;

    // flat case
    if (damage < 0)
    {
        health = uint32(-damage);
        mana = GetSpellInfo()->EffectMiscValue[i];
    }
    // percent case
    else
    {
        health = uint32(damage/100.0f*unitTarget->GetMaxHealth());
        if (unitTarget->GetMaxPower(POWER_MANA) > 0)
            mana = uint32(damage/100.0f*unitTarget->GetMaxPower(POWER_MANA));
    }

    Player *plr = ((Player*)unitTarget);
    plr->ResurrectPlayer(0.0f);

    plr->SetHealth(health);
    plr->SetPower(POWER_MANA, mana);
    plr->SetPower(POWER_RAGE, 0);
    plr->SetPower(POWER_ENERGY, plr->GetMaxPower(POWER_ENERGY));

    plr->SpawnCorpseBones();
}

void Spell::EffectSkinning(uint32 /*i*/)
{
    if (unitTarget->GetTypeId() != TYPEID_UNIT)
        return;
    if (!m_caster || m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Creature* creature = (Creature*) unitTarget;
    int32 targetLevel = creature->getLevel();

    uint32 skill = creature->GetCreatureInfo()->GetRequiredLootSkill();

    ((Player*)m_caster)->SendLoot(creature->GetGUID(), LOOT_SKINNING);
    creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);

    int32 reqValue = targetLevel < 10 ? 0 : targetLevel < 20 ? (targetLevel-10)*10 : targetLevel*5;

    int32 skillValue = ((Player*)m_caster)->GetPureSkillValue(skill);

    // Double chances for elites
    ((Player*)m_caster)->UpdateGatherSkill(skill, skillValue, reqValue, creature->isElite() ? 2 : 1);
}

void Spell::EffectCharge(uint32 /*i*/)
{
    if (!m_caster)
        return;

    Unit *target = m_targets.getUnitTarget();
    if (!target)
        return;


    if (m_caster->GetTypeId() == TYPEID_PLAYER)
        ((Player *)m_caster)->m_AC_timer = 3000;

    if ((_path.getPathType() & PATHFIND_NOPATH) || target->IsInWater())
    {
        Position dest;
        target->GetPosition(dest);

        float angle = m_caster->GetAngle(target) - m_caster->GetOrientation() - M_PI;
        m_caster->GetValidPointInAngle(dest, 2.0f, angle, false);
        m_caster->GetMotionMaster()->MoveCharge(dest.x, dest.y, dest.z);
    }
    else
        m_caster->GetMotionMaster()->MoveCharge(_path);

    // not all charge effects used in negative spells
    if (!SpellMgr::IsPositiveSpell(GetSpellInfo()->Id) && m_caster->GetTypeId() == TYPEID_PLAYER)
        m_caster->Attack(target, true);
}

void Spell::EffectCharge2(uint32 /*i*/)
{
    Unit *target = m_targets.getUnitTarget();
    if (!target && !(m_targets.m_targetMask & TARGET_FLAG_DEST_LOCATION))
        return;

    if (_path.getPathType() & PATHFIND_NOPATH)
    {
        Position dest;
        if (m_targets.m_targetMask & TARGET_FLAG_DEST_LOCATION)
        {
            dest.x = m_targets.m_destX;
            dest.y = m_targets.m_destY;
            dest.z = m_targets.m_destZ;
        }
        else
        {
            target->GetPosition(dest);

            float angle = m_caster->GetAngle(target) - m_caster->GetOrientation() - M_PI;
            m_caster->GetValidPointInAngle(dest, 2.0f, angle, false);
        }

        m_caster->GetMotionMaster()->MoveCharge(dest.x, dest.y, dest.z);
    }
    else
        m_caster->GetMotionMaster()->MoveCharge(_path);

    // not all charge effects used in negative spells
    if (!SpellMgr::IsPositiveSpell(GetSpellInfo()->Id))
        m_caster->Attack(unitTarget, true);
}

void Spell::EffectSummonCritter(uint32 i)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;
    Player* player = (Player*)m_caster;

    uint32 pet_entry = GetSpellInfo()->EffectMiscValue[i];
    if (!pet_entry)
        return;

    Pet* old_critter = player->GetMiniPet();

    // for same pet just despawn
    if (old_critter && old_critter->GetEntry() == pet_entry)
    {
        player->RemoveMiniPet();
        return;
    }

    // despawn old pet before summon new
    if (old_critter)
        player->RemoveMiniPet();

    // summon new pet
    Pet* critter = new Pet(MINI_PET);

    Map *map = m_caster->GetMap();
    uint32 pet_number = sObjectMgr.GeneratePetNumber();
    if (!critter->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_PET),
        map, pet_entry, pet_number))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Spell::EffectSummonCritter, spellid %u: no such creature entry %u", GetSpellInfo()->Id, pet_entry);
        delete critter;
        return;
    }

    float x,y,z;
    // If dest location if present
    if (m_targets.m_targetMask & TARGET_FLAG_DEST_LOCATION)
    {
         x = m_targets.m_destX;
         y = m_targets.m_destY;
         z = m_targets.m_destZ;
     }
     // Summon if dest location not present near caster
     else
         m_caster->GetNearPoint(x,y,z,critter->GetObjectSize());

    critter->Relocate(x,y,z,m_caster->GetOrientation());

    if (!critter->IsPositionValid())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Pet (guidlow %d, entry %d) not summoned. Suggested coordinates isn't valid (X: %f Y: %f)",
            critter->GetGUIDLow(), critter->GetEntry(), critter->GetPositionX(), critter->GetPositionY());
        delete critter;
        return;
    }

    critter->SetOwnerGUID(m_caster->GetGUID());
    critter->SetCreatorGUID(m_caster->GetGUID());
    critter->SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE,m_caster->getFaction());
    critter->SetUInt32Value(UNIT_CREATED_BY_SPELL, GetSpellInfo()->Id);

    critter->InitPetCreateSpells();                         // e.g. disgusting oozeling has a create spell as critter...
    critter->SetMaxHealth(1);
    critter->SetHealth(1);
    critter->SelectLevel(critter->GetCreatureInfo());       // some summoned creaters have different from 1 DB data for level/hp
    critter->SetUInt32Value(UNIT_NPC_FLAGS, critter->GetCreatureInfo()->npcflag); // some mini-pets have quests

    // set timer for unsummon
    int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());
    if (duration > 0)
        critter->SetDuration(duration);

    std::string name = player->GetName();
    name.append(petTypeSuffix[critter->getPetType()]);
    critter->SetName(name);
    player->SetMiniPet(critter);

    map->Add((Creature*)critter);
}

void Spell::EffectKnockBack(uint32 i)
{
    if (!unitTarget)
        return;

    unitTarget->CastStop();
        
    if (GetSpellInfo()->Id == 37852)    // Watery Grave Explosion;
        unitTarget->SetStunned(false);  // stunned state has to be removed manually here before aura expires to allow self knockback

    unitTarget->KnockBackFrom(m_caster,float(GetSpellInfo()->EffectMiscValue[i])/10,float(damage)/10);
}

void Spell::EffectSendTaxi(uint32 i)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    TaxiPathEntry const* entry = sTaxiPathStore.LookupEntry(GetSpellInfo()->EffectMiscValue[i]);
    if (!entry)
        return;

    std::vector<uint32> nodes;

    nodes.resize(2);
    nodes[0] = entry->from;
    nodes[1] = entry->to;

    uint32 mountid = 0;
    switch (GetSpellInfo()->Id)
    {
        case 31606:       // Stormcrow Amulet
            mountid = 17447;
            break;
        case 45071:      // Quest - Sunwell Daily - Dead Scar Bombing Run
        case 45113:      // Quest - Sunwell Daily - Ship Bombing Run
        case 45353:      // Quest - Sunwell Daily - Ship Bombing Run Return
            mountid = 22840;
            break;
        case 34905:      //Stealth Flight
            mountid = 6851;
            break;
        case 41533:      // Fly of the Netherwing
        case 41540:      // Fly of the Netherwing
            mountid = 23468;
            break;
        case 42295:     // Alcaz Island Survey
            mountid = 17697;
            break;
    }

    ((Player*)unitTarget)->ActivateTaxiPathTo(nodes,mountid);
}

void Spell::EffectPlayerPull(uint32 i)
{
    if (!unitTarget)
        return;

    float dist = unitTarget->GetDistance2d(m_caster);
    if (damage && dist > damage)
        dist = damage;

    unitTarget->KnockBackFrom(m_caster, -dist, GetSpellInfo()->EffectMiscValue[i]/10.0);
}

void Spell::EffectSuspendGravity(uint32 i)
{
    if (!unitTarget)
        return;

    float dist = unitTarget->GetDistance2d(m_caster);
    WorldLocation wLoc;
    float diff_z;
    unitTarget->GetPosition(wLoc);
    float ground_z = m_caster->GetTerrain()->GetHeight(wLoc.coord_x, wLoc.coord_y, wLoc.coord_z, true);
    diff_z = unitTarget->GetPositionZ() - ground_z;
    
    // for now this has to only support one spell
    if(unitTarget->HasAura(46230, 2))
    {
        if(Aura* aur = unitTarget->GetAura(46230, 2))
            if(aur->GetAuraDuration() < 3400)
                unitTarget->KnockBackFrom(m_caster, dist-frand(7, 14), diff_z < 1.5 ? GetSpellInfo()->EffectMiscValue[i]/10.0 : 0);
    }
    else
        unitTarget->KnockBackFrom(m_caster, dist-frand(7, 14), diff_z < 1.5 ? GetSpellInfo()->EffectMiscValue[i]/10.0 : 0);
}

void Spell::EffectDispelMechanic(uint32 i)
{
   if (!unitTarget)
        return;

    if (unitTarget->IsHostileTo(m_caster))
    {
        m_caster->SetInCombatWith(unitTarget);
        unitTarget->SetInCombatWith(m_caster);
    }

    // Fill possible dispel list
    std::list <Aura *> dispel_list;
    uint32 mechanic = GetSpellInfo()->EffectMiscValue[i];
    Unit::AuraMap& Auras = unitTarget->GetAuras();
    for (Unit::AuraMap::iterator iter = Auras.begin(), next; iter != Auras.end(); ++iter)
    {
        SpellEntry const *spell = sSpellStore.LookupEntry(iter->second->GetSpellProto()->Id);
        if (spell->Mechanic == mechanic || spell->EffectMechanic[iter->second->GetEffIndex()] == mechanic)
        {
            dispel_list.push_back(iter->second);
        }
    }

    // Ok if exist some buffs for dispel try dispel it
    if (!dispel_list.empty())
    {
        std::list < std::pair<uint32,uint64> > success_list;// (spell_id,casterGuid)
        std::list < uint32 > fail_list;                     // spell_id

        while (!dispel_list.empty())
        {
            Aura *aur = dispel_list.back();
           // dispel_list.pop_back();
            SpellEntry const* spellInfo = aur->GetSpellProto();

            // Base dispel chance
            // TODO: possible chance depend from spell level??
            int32 miss_chance = 0;
            // Apply dispel mod from aura caster
            if (Unit *caster = aur->GetCaster())
            {
                if (Player* modOwner = caster->GetSpellModOwner())
                {
                    modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_RESIST_DISPEL_CHANCE, miss_chance, this);
                }
            }

            // Try dispel
            if (roll_chance_i(miss_chance))
                fail_list.push_back(aur->GetId());
            else
                unitTarget->RemoveAurasByCasterSpell(spellInfo->Id, aur->GetCasterGUID());


            for (std::list<Aura *>::iterator j = dispel_list.begin(); j != dispel_list.end();)
            {
                Aura *dispelled = *j;
                if (dispelled->GetId() == aur->GetId() && dispelled->GetCasterGUID() == aur->GetCasterGUID())
                {
                    j = dispel_list.erase(j);
                }
                else
                    ++j;
            }
        }

        // Send fail log to client
        if (!fail_list.empty())
        {
            // Failed to dispell
            WorldPacket data(SMSG_DISPEL_FAILED, 8+8+4+4*fail_list.size());
            data << uint64(m_caster->GetGUID());            // Caster GUID
            data << uint64(unitTarget->GetGUID());          // Victim GUID
            data << uint32(GetSpellInfo()->Id);                // dispel spell id
            for (std::list< uint32 >::iterator j = fail_list.begin(); j != fail_list.end(); ++j)
                data << uint32(*j);                         // Spell Id
            m_caster->BroadcastPacket(&data, true);
        }
    }

    return;
}

void Spell::EffectSummonDeadPet(uint32 /*i*/)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player *_player = (Player*)m_caster;

    Pet *pet = _player->GetPet();
    if (!pet)
        return;

    if (pet->isAlive())
        return;

    if (damage < 0)
        return;

    float x,y,z;
    _player->GetPosition(x, y, z);
    pet->NearTeleportTo(x, y, z, _player->GetOrientation());

    pet->SetUInt32Value(UNIT_DYNAMIC_FLAGS, 0);
    pet->RemoveFlag (UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);
    pet->setDeathState(ALIVE);
    pet->clearUnitState(UNIT_STAT_ALL_STATE);
    pet->SetHealth(uint32(pet->GetMaxHealth()*(float(damage)/100)));

    pet->SavePetToDB(PET_SAVE_AS_CURRENT);
}

void Spell::EffectDestroyAllTotems(uint32 /*i*/)
{
    float mana = 0;
    for (int slot = 0;  slot < MAX_TOTEM; ++slot)
    {
        if (!m_caster->m_TotemSlot[slot])
            continue;

        Creature* totem = m_caster->GetMap()->GetCreature(m_caster->m_TotemSlot[slot]);
        if (totem && totem->isTotem())
        {
            uint32 spell_id = totem->GetUInt32Value(UNIT_CREATED_BY_SPELL);
            SpellEntry const* spellInfo = sSpellStore.LookupEntry(spell_id);
            if (spellInfo)
            {
                mana += spellInfo->manaCost * damage / 100;
                if(spellInfo->ManaCostPercentage)
                    mana += spellInfo->ManaCostPercentage * m_caster->GetCreateMana() / 100 * damage / 100;
            }
            ((Totem*)totem)->UnSummon();
        }
    }

    int32 gain = m_caster->ModifyPower(POWER_MANA,int32(mana));
    m_caster->SendEnergizeSpellLog(m_caster, GetSpellInfo()->Id, gain, POWER_MANA);
}

void Spell::EffectDurabilityDamage(uint32 i)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    int32 slot = GetSpellInfo()->EffectMiscValue[i];

    // FIXME: some spells effects have value -1/-2
    // Possibly its mean -1 all player equipped items and -2 all items
    if (slot < 0)
    {
        ((Player*)unitTarget)->DurabilityPointsLossAll(damage,(slot < -1));
        return;
    }

    // invalid slot value
    if (slot >= INVENTORY_SLOT_BAG_END)
        return;

    if (Item* item = ((Player*)unitTarget)->GetItemByPos(INVENTORY_SLOT_BAG_0,slot))
        ((Player*)unitTarget)->DurabilityPointsLoss(item,damage);
}

void Spell::EffectDurabilityDamagePCT(uint32 i)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    int32 slot = GetSpellInfo()->EffectMiscValue[i];

    // FIXME: some spells effects have value -1/-2
    // Possibly its mean -1 all player equipped items and -2 all items
    if (slot < 0)
    {
        ((Player*)unitTarget)->DurabilityLossAll(double(damage)/100.0f,(slot < -1));
        return;
    }

    // invalid slot value
    if (slot >= INVENTORY_SLOT_BAG_END)
        return;

    if (damage <= 0)
        return;

    if (Item* item = ((Player*)unitTarget)->GetItemByPos(INVENTORY_SLOT_BAG_0,slot))
        ((Player*)unitTarget)->DurabilityLoss(item,double(damage)/100.0f);
}

void Spell::EffectModifyThreatPercent(uint32 /*effIndex*/)
{
    if (!unitTarget)
        return;

    unitTarget->getThreatManager().modifyThreatPercent(m_caster, damage);
}

void Spell::EffectTransmitted(uint32 effIndex)
{
    uint32 name_id = GetSpellInfo()->EffectMiscValue[effIndex];

    // Create Soulwell hack
    if (GetSpellInfo()->Id == 29886)
    {
        if (m_caster->HasAura(18693, 0))    //imp healthstone rank 2
            name_id = 183511;
        else
            if (m_caster->HasAura(18692, 0))//imp healthstone rank 1
                name_id = 183510;
    }

    GameObjectInfo const* goinfo = ObjectMgr::GetGameObjectInfo(name_id);

    if (!goinfo)
    {
        sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u) not exist and not created at spell (ID: %u) cast",name_id, GetSpellInfo()->Id);
        return;
    }

    float fx,fy,fz;

    if (m_targets.m_targetMask & TARGET_FLAG_DEST_LOCATION)
    {
        fx = m_targets.m_destX;
        fy = m_targets.m_destY;
        fz = m_targets.m_destZ;
    }
    //FIXME: this can be better check for most objects but still hack
    else if (GetSpellInfo()->EffectRadiusIndex[effIndex] && GetSpellInfo()->speed==0)
    {
        float dis = SpellMgr::GetSpellRadius(GetSpellInfo(),effIndex,false);
        m_caster->GetNearPoint(fx,fy,fz,DEFAULT_WORLD_OBJECT_SIZE, dis);
    }
    else
    {
        float min_dis = SpellMgr::GetSpellMinRange(sSpellRangeStore.LookupEntry(GetSpellInfo()->rangeIndex));
        float max_dis = SpellMgr::GetSpellMaxRange(sSpellRangeStore.LookupEntry(GetSpellInfo()->rangeIndex));
        float dis = rand_norm() * (max_dis - min_dis) + min_dis;

        m_caster->GetNearPoint(fx,fy,fz,DEFAULT_WORLD_OBJECT_SIZE, dis);
    }

    Map *cMap = m_caster->GetMap();

    if (goinfo->type==GAMEOBJECT_TYPE_SUMMONING_RITUAL)
    {
        m_caster->GetPosition(fx,fy,fz);
    }

    GameObject* pGameObj = new GameObject;

    if (!pGameObj->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT), name_id, cMap,
        fx, fy, fz, m_caster->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 100, GO_STATE_READY))
    {
        delete pGameObj;
        return;
    }

    int32 duration = SpellMgr::GetSpellDuration(GetSpellInfo());

    switch (goinfo->type)
    {
        case GAMEOBJECT_TYPE_FISHINGNODE:
        {
            m_caster->SetUInt64Value(UNIT_FIELD_CHANNEL_OBJECT,pGameObj->GetGUID());
            m_caster->AddGameObject(pGameObj);              // will removed at spell cancel

            // end time of range when possible catch fish (FISHING_BOBBER_READY_TIME..GetDuration(GetSpellInfo()))
            // start time == fish-FISHING_BOBBER_READY_TIME (0..GetDuration(GetSpellInfo())-FISHING_BOBBER_READY_TIME)
            int32 lastSec = 0;
            switch (urand(0, 3))
            {
                case 0: lastSec =  3; break;
                case 1: lastSec =  7; break;
                case 2: lastSec = 13; break;
                case 3: lastSec = 17; break;
            }

            duration = duration - lastSec*1000 + FISHING_BOBBER_READY_TIME*1000;
            break;
        }
        case GAMEOBJECT_TYPE_SUMMONING_RITUAL:
        {
            if (m_caster->GetTypeId()==TYPEID_PLAYER)
            {
                pGameObj->AddUniqueUse((Player*)m_caster);
                m_caster->AddGameObject(pGameObj);          // will removed at spell cancel
                pGameObj->SetLootState(GO_ACTIVATED);
                pGameObj->SetTarget(((Player*)m_caster)->GetSelection());
            }
            break;
        }
        case GAMEOBJECT_TYPE_FISHINGHOLE:
        case GAMEOBJECT_TYPE_CHEST:
        default:
        {
            break;
        }
    }

    pGameObj->SetRespawnTime(duration > 0 ? duration/1000 : 0);

    pGameObj->SetOwnerGUID(m_caster->GetGUID());

    //pGameObj->SetUInt32Value(GAMEOBJECT_LEVEL, m_caster->getLevel());
    pGameObj->SetSpellId(GetSpellInfo()->Id);

    DEBUG_LOG("AddObject at SpellEfects.cpp EffectTransmitted\n");
    //m_caster->AddGameObject(pGameObj);
    //m_ObjToDel.push_back(pGameObj);

    cMap->Add(pGameObj);

    WorldPacket data(SMSG_GAMEOBJECT_SPAWN_ANIM_OBSOLETE, 8);
    data << uint64(pGameObj->GetGUID());
    m_caster->BroadcastPacket(&data,true);

    if (uint32 linkedEntry = pGameObj->GetLinkedGameObjectEntry())
    {
        GameObject* linkedGO = new GameObject;
        if (linkedGO->Create(sObjectMgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT), linkedEntry, cMap,
            fx, fy, fz, m_caster->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 100, GO_STATE_READY))
        {
            linkedGO->SetRespawnTime(duration > 0 ? duration/1000 : 0);
            //linkedGO->SetUInt32Value(GAMEOBJECT_LEVEL, m_caster->getLevel());
            linkedGO->SetSpellId(GetSpellInfo()->Id);
            linkedGO->SetOwnerGUID(m_caster->GetGUID());

            linkedGO->GetMap()->Add(linkedGO);
        }
        else
        {
            delete linkedGO;
            linkedGO = NULL;
            return;
        }
    }
}

void Spell::EffectProspecting(uint32 /*i*/)
{
    if (m_caster->GetTypeId() != TYPEID_PLAYER)
        return;

    Player* p_caster = (Player*)m_caster;
    if (!itemTarget || !(itemTarget->GetProto()->BagFamily & BAG_FAMILY_MASK_MINING_SUPP))
        return;

    if (itemTarget->GetCount() < 5)
        return;

    if (sWorld.getConfig(CONFIG_SKILL_PROSPECTING))
    {
        uint32 SkillValue = p_caster->GetPureSkillValue(SKILL_JEWELCRAFTING);
        uint32 reqSkillValue = itemTarget->GetProto()->RequiredSkillRank;
        p_caster->UpdateGatherSkill(SKILL_JEWELCRAFTING, SkillValue, reqSkillValue);
    }

    ((Player*)m_caster)->SendLoot(itemTarget->GetGUID(), LOOT_PROSPECTING);
}

void Spell::EffectSkill(uint32 /*i*/)
{
    sLog.outDebug("WORLD: SkillEFFECT");
}

void Spell::EffectSummonDemon(uint32 i)
{
    float px = m_targets.m_destX;
    float py = m_targets.m_destY;
    float pz = m_targets.m_destZ;
    int32 creature_ID = GetSpellInfo()->EffectMiscValue[i];

    Creature* Charmed = m_caster->SummonCreature(creature_ID, px, py, pz, m_caster->GetOrientation(),TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,3600000);
    if (!Charmed)
        return;

    // might not always work correctly, maybe the creature that dies from CoD casts the effect on itself and is therefore the caster?
    Charmed->SetLevel(m_caster->getLevel());

    // Add damage/mana/hp according to level
    //PetLevelInfo const* pInfo = sObjectMgr.GetPetLevelInfo(creature_ID, m_caster->getLevel());
    if (creature_ID == 89 || creature_ID == 11859)
    {
        int lvldiff = (m_caster->getLevel() - 52);
        if (lvldiff > 0)
        {
            if (creature_ID == 89)
            {
                Charmed->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, Charmed->GetMaxHealth() + 350 * lvldiff);
                Charmed->SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, Charmed->GetMaxPower(POWER_MANA) + 80 * lvldiff);
                Charmed->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, 20 * lvldiff);
                Charmed->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, 20 * lvldiff);
                Charmed->SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, Charmed->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE) * (1 + lvldiff * 0.1f));

                m_caster->CastSpell(Charmed, 20882, true);          // Enslave demon effect, without mana cost and cooldown
                Charmed->CastSpell(Charmed, 22703, true, 0);        // Inferno effect
            }
            else if (creature_ID == 11859)
            {
                Charmed->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, Charmed->GetMaxHealth() + 400 * lvldiff);
                Charmed->SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, Charmed->GetMaxPower(POWER_MANA) + 100 * lvldiff);
                Charmed->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, 30 * lvldiff);
                Charmed->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, 30 * lvldiff);
                Charmed->SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, Charmed->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE) * (1 + lvldiff * 0.1f));
            }

            Charmed->UpdateAllStats();
            Charmed->SetHealth(Charmed->GetMaxHealth());
            Charmed->SetPower(POWER_MANA, Charmed->GetMaxPower(POWER_MANA));
        }
    }

}

/* There is currently no need for this effect. We handle it in BattleGround.cpp
   If we would handle the resurrection here, the spiritguide would instantly disappear as the
   player revives, and so we wouldn't see the spirit heal visual effect on the npc.
   This is why we use a half sec delay between the visual effect and the resurrection itself */
void Spell::EffectSpiritHeal(uint32 /*i*/)
{
    /*
    if (!unitTarget || unitTarget->isAlive())
        return;
    if (unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;
    if (!unitTarget->IsInWorld())
        return;

    //GetSpellInfo()->EffectBasePoints[i]; == 99 (percent?)
    //((Player*)unitTarget)->setResurrect(m_caster->GetGUID(), unitTarget->GetPositionX(), unitTarget->GetPositionY(), unitTarget->GetPositionZ(), unitTarget->GetMaxHealth(), unitTarget->GetMaxPower(POWER_MANA));
    ((Player*)unitTarget)->ResurrectPlayer(1.0f);
    ((Player*)unitTarget)->SpawnCorpseBones();
    */
}

// remove insignia spell effect
void Spell::EffectSkinPlayerCorpse(uint32 /*i*/)
{
    sLog.outDebug("Effect: SkinPlayerCorpse");
    if ((m_caster->GetTypeId() != TYPEID_PLAYER) || (unitTarget->GetTypeId() != TYPEID_PLAYER) || (unitTarget->isAlive()))
        return;

    ((Player*)unitTarget)->RemovedInsignia((Player*)m_caster);
}

void Spell::EffectStealBeneficialBuff(uint32 i)
{
    sLog.outDebug("Effect: StealBeneficialBuff");

    if (!unitTarget || unitTarget==m_caster)                 // can't steal from self
        return;

    std::vector <Aura *> steal_list;
    // Create dispel mask by dispel type
    uint32 dispelMask  = SpellMgr::GetDispellMask(DispelType(GetSpellInfo()->EffectMiscValue[i]));
    Unit::AuraMap const& auras = unitTarget->GetAuras();
    for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
    {
        Aura *aur = (*itr).second;
        if (aur && (1<<aur->GetSpellProto()->Dispel) & dispelMask)
        {
            // Need check for passive? this
            if (aur->IsPositive() && !aur->IsPassive()  && !(aur->GetSpellProto()->AttributesEx4 & SPELL_ATTR_EX4_NOT_STEALABLE))
                steal_list.push_back(aur);
        }
    }
    // Ok if exist some buffs for dispel try dispel it
    if (!steal_list.empty())
    {
        std::list < std::pair<uint32,uint64> > success_list;    // (spellId, casterGUID)
        std::list < uint32 > fail_list;                         // spellId
        int32 list_size = steal_list.size();
        // dispel N = damage buffs (or while exist buffs for dispel)
        for (int32 count=0; count < damage && list_size > 0; ++count)
        {
            // Random select buff for dispel
            Aura *aur = steal_list[urand(0, list_size-1)];

            // Base dispel chance
            // TODO: possible chance depend from spell level??
            int32 miss_chance = 0;
            // Apply dispel mod from aura caster
            if (Unit *caster = aur->GetCaster())
            {
                if (Player* modOwner = caster->GetSpellModOwner())
                    modOwner->ApplySpellMod(aur->GetSpellProto()->Id, SPELLMOD_RESIST_DISPEL_CHANCE, miss_chance, this);
            }


            if (miss_chance < 100)
            {
                // Try dispel
                if (roll_chance_i(miss_chance))
                    fail_list.push_back(aur->GetId());
                else
                    success_list.push_back(std::pair<uint32,uint64>(aur->GetId(),aur->GetCasterGUID()));
            }
            // don't try to dispell effects with 100% dispell resistance (patch 2.4.3 notes)
            else
                count--;

            // Remove buff from list for prevent doubles
            for (std::vector<Aura *>::iterator j = steal_list.begin(); j != steal_list.end();)
            {
                Aura *stealed = *j;
                if (stealed->GetId() == aur->GetId() && stealed->GetCasterGUID() == aur->GetCasterGUID())
                {
                    j = steal_list.erase(j);
                    --list_size;
                }
                else
                    ++j;
            }
        }
        // Really try steal and send log
        if (!success_list.empty())
        {
            int32 count = success_list.size();
            WorldPacket data(SMSG_SPELLSTEALLOG, 8+8+4+1+4+count*5);
            data << unitTarget->GetPackGUID();       // Victim GUID
            data << m_caster->GetPackGUID();         // Caster GUID
            data << uint32(GetSpellInfo()->Id);         // dispel spell id
            data << uint8(0);                        // not used
            data << uint32(count);                   // count
            for (std::list<std::pair<uint32,uint64> >::iterator j = success_list.begin(); j != success_list.end(); ++j)
            {
                SpellEntry const* spellInfo = sSpellStore.LookupEntry(j->first);
                data << uint32(spellInfo->Id);       // Spell Id
                data << uint8(0);                    // 0 - steals !=0 transfers
                unitTarget->RemoveAurasDueToSpellBySteal(spellInfo->Id, j->second, m_caster);
            }
            m_caster->BroadcastPacket(&data, true);
        }
        // Is there other way to send spellsteal resists?
        // Send fail log to client
        if (!fail_list.empty())
        {
            // Failed to dispell
            WorldPacket data(SMSG_DISPEL_FAILED, 8+8+4+4*fail_list.size());
            data << uint64(m_caster->GetGUID());            // Caster GUID
            data << uint64(unitTarget->GetGUID());          // Victim GUID
            data << uint32(GetSpellInfo()->Id);                // dispel spell id
            for (std::list< uint32 >::iterator j = fail_list.begin(); j != fail_list.end(); ++j)
                data << uint32(*j);                         // Spell Id
            m_caster->BroadcastPacket(&data, true);
        }
    }
}

void Spell::EffectKillCredit(uint32 i)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    ((Player*)unitTarget)->RewardPlayerAndGroupAtEvent(GetSpellInfo()->EffectMiscValue[i], unitTarget);
}

void Spell::EffectQuestFail(uint32 i)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    ((Player*)unitTarget)->FailQuest(GetSpellInfo()->EffectMiscValue[i]);
}

void Spell::EffectRedirectThreat(uint32 /*i*/)
{
    if (unitTarget)
        m_caster->SetReducedThreatPercent(100, unitTarget->GetGUID());
}

void Spell::EffectPlayMusic(uint32 i)
{
    if (!unitTarget || unitTarget->GetTypeId() != TYPEID_PLAYER)
        return;

    uint32 soundid = GetSpellInfo()->EffectMiscValue[i];

    if (!sSoundEntriesStore.LookupEntry(soundid))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: EffectPlayMusic: Sound (Id: %u) not exist in spell %u.",soundid,GetSpellInfo()->Id);
        return;
    }

    WorldPacket data(SMSG_PLAY_MUSIC, 4);
    data << uint32(soundid);
    ((Player*)unitTarget)->SendPacketToSelf(&data);
}
