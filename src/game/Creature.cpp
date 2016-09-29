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
#include "World.h"
#include "ObjectMgr.h"
#include "SpellMgr.h"
#include "ScriptMgr.h"
#include "Creature.h"
#include "QuestDef.h"
#include "GossipDef.h"
#include "Player.h"
#include "PoolManager.h"
#include "Opcodes.h"
#include "Log.h"
#include "LootMgr.h"
#include "MapManager.h"
#include "CreatureAI.h"
#include "PlayerAI.h"
#include "CreatureAISelector.h"
#include "Formulas.h"
#include "SpellAuras.h"
#include "WaypointMovementGenerator.h"
#include "InstanceData.h"
#include "BattleGroundMgr.h"
#include "Util.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "OutdoorPvPMgr.h"
#include "GameEvent.h"
#include "CreatureGroups.h"

#include "movement/MoveSplineInit.h"
#include "movement/MoveSpline.h"

// apply implementation of the singletons
#include "Map.h"

std::map<uint32, uint32> CreatureAIReInitialize;

TrainerSpell const* TrainerSpellData::Find(uint32 spell_id) const
{
    TrainerSpellMap::const_iterator itr = spellList.find(spell_id);
    if (itr != spellList.end())
        return &itr->second;

    return NULL;
}

bool VendorItemData::RemoveItem(uint32 item_id)
{
    for (VendorItemList::iterator i = m_items.begin(); i != m_items.end(); ++i)
    {
        if ((*i)->item==item_id)
        {
            m_items.erase(i);
            return true;
        }
    }
    return false;
}

size_t VendorItemData::FindItemSlot(uint32 item_id) const
{
    for (size_t i = 0; i < m_items.size(); ++i)
        if (m_items[i]->item==item_id)
            return i;
    return m_items.size();
}

VendorItem const* VendorItemData::FindItem(uint32 item_id) const
{
    for (VendorItemList::const_iterator i = m_items.begin(); i != m_items.end(); ++i)
        if ((*i)->item==item_id)
            return *i;
    return NULL;
}

uint32 CreatureInfo::GetRandomValidModelId() const
{
    uint32 c = 0;
    uint32 modelIDs[4];

    if (Modelid_A1) modelIDs[c++] = Modelid_A1;
    if (Modelid_A2) modelIDs[c++] = Modelid_A2;
    if (Modelid_H1) modelIDs[c++] = Modelid_H1;
    if (Modelid_H2) modelIDs[c++] = Modelid_H2;

    return ((c>0) ? modelIDs[urand(0,c-1)] : 0);
}

uint32 CreatureInfo::GetFirstValidModelId() const
{
    if (Modelid_A1) return Modelid_A1;
    if (Modelid_A2) return Modelid_A2;
    if (Modelid_H1) return Modelid_H1;
    if (Modelid_H2) return Modelid_H2;
    return 0;
}

bool AssistDelayEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    Unit* victim = Unit::GetUnit(m_owner, m_victim);
    if (victim)
    {
        while (!m_assistants.empty())
        {
            Creature* assistant = Unit::GetCreature(m_owner, *m_assistants.begin());
            m_assistants.pop_front();

            if (assistant && assistant->CanAssistTo(&m_owner, victim))
            {
                assistant->SetNoCallAssistance(true);
                assistant->CombatStart(victim);
                if (assistant->IsAIEnabled)
                    assistant->AI()->AttackStart(victim);
            }
        }
    }
    return true;
}

bool ForcedDespawnDelayEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    m_owner.ForcedDespawn();
    return true;
}

Creature::Creature() :
Unit(), m_aggroRange(0.0), m_ignoreSelection (false),
lootForPickPocketed(false), lootForBody(false), m_lootMoney(0), m_lootRecipient(0),
m_deathTimer(0), m_respawnTime(0), m_respawnDelay(300), m_corpseDelay(60), m_respawnradius(0.0f),
m_gossipOptionLoaded(false), m_isPet(false), m_isTotem(false), m_reactState(REACT_AGGRESSIVE),
m_defaultMovementType(IDLE_MOTION_TYPE), m_equipmentId(0), m_AlreadyCallAssistance(false),
m_regenHealth(true), m_isDeadByDefault(false), m_AlreadySearchedAssistance(false), m_creatureData(NULL),
m_meleeDamageSchoolMask(SPELL_SCHOOL_MASK_NORMAL),m_creatureInfo(NULL), m_DBTableGuid(0), m_formation(NULL), m_PlayerDamageReq(0),
m_tempSummon(false)
{
    m_regenTimer = 2000;
    m_valuesCount = UNIT_END;
    m_xpMod = 0;
    FightStart = 0;

    for (int i =0; i < CREATURE_MAX_SPELLS; ++i)
        m_spells[i] = 0;

    m_CreatureSpellCooldowns.clear();
    m_CreatureCategoryCooldowns.clear();

    DisableReputationGain = false;

    TriggerJustRespawned = false;
}

Creature::~Creature()
{
    m_vendorItemCounts.clear();

    if (i_AI)
    {
        delete i_AI;
        i_AI = NULL;
    }

    if (m_uint32Values)
        sLog.outDetail("Deconstruct Creature Entry = %u", GetEntry());
}

void Creature::AddToWorld()
{
    ///- Register the creature for guid lookup
    if (!IsInWorld())
    {
        GetMap()->InsertIntoObjMap(this);
        Unit::AddToWorld();
        SearchFormation();
        AIM_Initialize();

        if (m_zoneScript)
            m_zoneScript->OnCreatureCreate(this, true);
    }
}

void Creature::RemoveFromWorld()
{
    ///- Remove the creature from the accessor
    if (IsInWorld())
    {
        if (m_zoneScript)
            m_zoneScript->OnCreatureCreate(this, false);

        if (m_formation)
            CreatureGroupManager::RemoveCreatureFromGroup(m_formation, this);

        Unit::RemoveFromWorld();
        GetMap()->RemoveFromObjMap(this);
    }
}

void Creature::DisappearAndDie()
{
    DestroyForNearbyPlayers();
    if (isAlive())
        setDeathState(JUST_DIED);
    RemoveCorpse();
}

void Creature::SearchFormation()
{
    if (isPet())
        return;

    uint32 lowguid = GetDBTableGUIDLow();
    if (!lowguid)
        return;

    CreatureGroupInfoType::iterator frmdata = CreatureGroupMap.find(lowguid);
    if (frmdata != CreatureGroupMap.end())
        CreatureGroupManager::AddCreatureToGroup(frmdata->second->leaderGUID, this);

}

void Creature::RemoveCorpse()
{
    if (getDeathState()!=CORPSE && !m_isDeadByDefault || getDeathState()!=ALIVE && m_isDeadByDefault)
        return;

    setDeathState(DEAD);
    UpdateObjectVisibility();

    m_deathTimer = 0;
    loot.clear();
    m_respawnTime = time(NULL) + m_respawnDelay;

    float x,y,z,o;
    GetRespawnCoord(x, y, z, &o);
    SetHomePosition(x,y,z,o);
    Relocate(x,y,z,o);
}

/**
 * change the entry of creature until respawn
 */
bool Creature::InitEntry(uint32 Entry, uint32 team, const CreatureData *data)
{
    CreatureInfo const *normalInfo = ObjectMgr::GetCreatureTemplate(Entry);
    if (!normalInfo)
    {
        sLog.outLog(LOG_DB_ERR, "Creature::UpdateEntry creature entry %u does not exist.", Entry);
        return false;
    }

    // get heroic mode entry
    uint32 actualEntry = Entry;
    CreatureInfo const *cinfo = normalInfo;
    if (normalInfo->HeroicEntry)
    {
        Map *map = GetMap();
        if (map && map->IsHeroic())
        {
            cinfo = ObjectMgr::GetCreatureTemplate(normalInfo->HeroicEntry);
            if (!cinfo)
            {
                sLog.outLog(LOG_DB_ERR, "Creature::UpdateEntry creature heroic entry %u does not exist.", actualEntry);
                return false;
            }
        }
    }

    SetEntry(Entry);                                        // normal entry always
    m_creatureInfo = cinfo;                                 // map mode related always

    // Cancel load if no model defined
    if (!(cinfo->GetFirstValidModelId()))
    {
        sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has no model defined in table `creature_template`, can't load. ",Entry);
        return false;
    }

    uint32 display_id = sObjectMgr.ChooseDisplayId(team, GetCreatureInfo(), data);
    CreatureModelInfo const *minfo = sObjectMgr.GetCreatureModelRandomGender(display_id);
    if (!minfo)
    {
        sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has model %u not found in table `creature_model_info`, can't load. ", Entry, display_id);
        return false;
    }
    else
        display_id = minfo->modelid;                        // it can be different (for another gender)

    SetDisplayId(display_id);
    SetNativeDisplayId(display_id);
    SetByteValue(UNIT_FIELD_BYTES_0, 2, minfo->gender);

    // Load creature equipment
    if (!data || data->equipmentId == 0)
    {                                                       // use default from the template
        LoadEquipment(cinfo->equipmentId);
    }
    else if (data && data->equipmentId != -1)
    {                                                       // override, -1 means no equipment
        LoadEquipment(data->equipmentId);
    }

    SetName(normalInfo->Name);                              // at normal entry always

    SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS,minfo->bounding_radius);
    SetFloatValue(UNIT_FIELD_COMBATREACH,minfo->combat_reach);

    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f);

    float m_baseSpeed = GetBaseSpeed();
    SetSpeed(MOVE_WALK, m_baseSpeed);
    SetSpeed(MOVE_RUN,  m_baseSpeed);
    SetSpeed(MOVE_SWIM, m_baseSpeed);

    SetFloatValue(OBJECT_FIELD_SCALE_X, cinfo->scale);
    SetLevitate(CanFly());

    // checked at loading
    m_defaultMovementType = MovementGeneratorType(cinfo->MovementType);
    if (!m_respawnradius && m_defaultMovementType == RANDOM_MOTION_TYPE)
        m_defaultMovementType = IDLE_MOTION_TYPE;

    m_spells[0] = GetCreatureInfo()->spell1;
    m_spells[1] = GetCreatureInfo()->spell2;
    m_spells[2] = GetCreatureInfo()->spell3;
    m_spells[3] = GetCreatureInfo()->spell4;
    m_spells[4] = GetCreatureInfo()->spell5;

    return true;
}

bool Creature::UpdateEntry(uint32 Entry, uint32 team, const CreatureData *data)
{
    if (!InitEntry(Entry,team,data))
        return false;

    m_regenHealth = GetCreatureInfo()->RegenHealth;

    // creatures always have melee weapon ready if any
    SetByteValue(UNIT_FIELD_BYTES_2, 0, SHEATH_STATE_MELEE);
    SetByteValue(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_AURAS);

    SelectLevel(GetCreatureInfo());
    if (team == HORDE)
        SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, GetCreatureInfo()->faction_H);
    else
        SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, GetCreatureInfo()->faction_A);

    if (GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_WORLDEVENT)
        SetUInt32Value(UNIT_NPC_FLAGS,GetCreatureInfo()->npcflag | sGameEventMgr.GetNPCFlag(this));
    else
        SetUInt32Value(UNIT_NPC_FLAGS,GetCreatureInfo()->npcflag);

    SetAttackTime(BASE_ATTACK,  GetCreatureInfo()->baseattacktime);
    SetAttackTime(OFF_ATTACK,   GetCreatureInfo()->baseattacktime);
    SetAttackTime(RANGED_ATTACK,GetCreatureInfo()->rangeattacktime);

    SetUInt32Value(UNIT_FIELD_FLAGS,GetCreatureInfo()->unit_flags);
    SetUInt32Value(UNIT_DYNAMIC_FLAGS,GetCreatureInfo()->dynamicflags);

    RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);

    SetMeleeDamageSchool(SpellSchools(GetCreatureInfo()->dmgschool));
    SetModifierValue(UNIT_MOD_ARMOR,             BASE_VALUE, float(GetCreatureInfo()->armor));
    if (GetCreatureInfo()->resistance1 < 0)
    {
        ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_HOLY, true);
        SetModifierValue(UNIT_MOD_RESISTANCE_HOLY, BASE_VALUE, 0);
    }
    else
        SetModifierValue(UNIT_MOD_RESISTANCE_HOLY, BASE_VALUE, float(GetCreatureInfo()->resistance1));

    if (GetCreatureInfo()->resistance2 < 0)
    {
        ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
        SetModifierValue(UNIT_MOD_RESISTANCE_FIRE, BASE_VALUE, 0);
    }
    else
        SetModifierValue(UNIT_MOD_RESISTANCE_FIRE, BASE_VALUE, float(GetCreatureInfo()->resistance2));

    if (GetCreatureInfo()->resistance3 < 0)
    {
        ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
        SetModifierValue(UNIT_MOD_RESISTANCE_NATURE, BASE_VALUE, 0);
    }
    else
        SetModifierValue(UNIT_MOD_RESISTANCE_NATURE, BASE_VALUE, float(GetCreatureInfo()->resistance3));

    if (GetCreatureInfo()->resistance4 < 0)
    {
        ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FROST, true);
        SetModifierValue(UNIT_MOD_RESISTANCE_FROST, BASE_VALUE, 0);
    }
    else
        SetModifierValue(UNIT_MOD_RESISTANCE_FROST, BASE_VALUE, float(GetCreatureInfo()->resistance4));

    if (GetCreatureInfo()->resistance5 < 0)
    {
        ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_SHADOW, true);
        SetModifierValue(UNIT_MOD_RESISTANCE_SHADOW, BASE_VALUE, 0);
    }
    else
        SetModifierValue(UNIT_MOD_RESISTANCE_SHADOW, BASE_VALUE, float(GetCreatureInfo()->resistance5));

    if (GetCreatureInfo()->resistance6 < 0)
    {
        ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_ARCANE, true);
        SetModifierValue(UNIT_MOD_RESISTANCE_ARCANE, BASE_VALUE, 0);
    }
    else
        SetModifierValue(UNIT_MOD_RESISTANCE_ARCANE, BASE_VALUE, float(GetCreatureInfo()->resistance6));

    SetCanModifyStats(true);
    UpdateAllStats();

    FactionTemplateEntry const* factionTemplate = sFactionTemplateStore.LookupEntry(GetCreatureInfo()->faction_A);
    if (factionTemplate)                                    // check and error show at loading templates
    {
        FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionTemplate->faction);
        if (factionEntry)
            if (!(GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_CIVILIAN) &&
                (factionEntry->team == ALLIANCE || factionEntry->team == HORDE))
                SetPvP(true);
    }

    // HACK: trigger creature is always not selectable
    if (isTrigger())
        SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

    if (isTotem() || isTrigger()
        || GetCreatureType() == CREATURE_TYPE_CRITTER)
        SetReactState(REACT_PASSIVE);
    /*else if (isCivilian())
        SetReactState(REACT_DEFENSIVE);*/
    else
        SetReactState(REACT_AGGRESSIVE);

    if (GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_NO_TAUNT)
    {
        ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
        ApplySpellImmune(0, IMMUNITY_EFFECT,SPELL_EFFECT_ATTACK_ME, true);
    }

    return true;
}

void Creature::Update(uint32 update_diff, uint32 diff)
{
    if (IsAIEnabled && TriggerJustRespawned)
    {
        TriggerJustRespawned = false;
        AI()->JustRespawned();
    }

    switch (m_deathState)
    {
        case JUST_ALIVED:
            // Don't must be called, see Creature::setDeathState JUST_ALIVED -> ALIVE promoting.
            sLog.outLog(LOG_DEFAULT, "ERROR: Creature (GUIDLow: %u Entry: %u) in wrong state: JUST_ALIVED (4)",GetGUIDLow(),GetEntry());
            break;
        case JUST_DIED:
            // Don't must be called, see Creature::setDeathState JUST_DIED -> CORPSE promoting.
            sLog.outLog(LOG_DEFAULT, "ERROR: Creature (GUIDLow: %u Entry: %u) in wrong state: JUST_DEAD (1)",GetGUIDLow(),GetEntry());
            break;
        case DEAD:
        {
            if (m_respawnTime <= time(NULL))
            {
                // encounter in progress - don't respawn
                if (GetMap()->EncounterInProgress(NULL))
                {
                    SetRespawnTime(MINUTE);
                    SaveRespawnTime();
                }
                else if (!GetLinkedCreatureRespawnTime()) // Can respawn
                    Respawn();
                else // the master is dead
                {
                    if (uint32 targetGuid = sObjectMgr.GetLinkedRespawnGuid(m_DBTableGuid))
                    {
                        if (targetGuid == m_DBTableGuid) // if linking self, never respawn (check delayed to next day)
                            SetRespawnTime(DAY);
                        else
                            m_respawnTime = (time(NULL)>GetLinkedCreatureRespawnTime()? time(NULL):GetLinkedCreatureRespawnTime())+urand(5,MINUTE); // else copy time from master and add a little
                        SaveRespawnTime(); // also save to DB immediately
                    }
                    else
                        Respawn();
                }
            }
            break;
        }
        case CORPSE:
        {
            Unit::Update(update_diff, diff);

            if (m_isDeadByDefault)
                break;

            if (m_deathTimer <= update_diff)
            {
                RemoveCorpse();
                DEBUG_LOG("Removing corpse... %u ", GetUInt32Value(OBJECT_FIELD_ENTRY));
            }
            else
            {
                m_deathTimer -= update_diff;
            }

            if (loot.looterTimer && loot.looterTimer < time(NULL))
            {
                loot.looterTimer = 0;
                loot.looterGUID = 0;
                if (GetLootRecipient() && GetLootRecipient()->GetGroup())
                    GetLootRecipient()->GetGroup()->SendRoundRobin(&loot, this);
            }
            if (loot.looterGUID && loot.looterCheckTimer < time(NULL))
            {
                Player* player = GetPlayer(loot.looterGUID);
                if (!player || !IsWithinDist(player, sWorld.getConfig(CONFIG_GROUP_XP_DISTANCE), false))
                {
                    loot.looterTimer = 0;
                    loot.looterGUID = 0;
                    if (GetLootRecipient() && GetLootRecipient()->GetGroup())
                        GetLootRecipient()->GetGroup()->SendRoundRobin(&loot, this);
                }
                else
                    loot.looterCheckTimer = time(NULL) + 1; // 1 second
            }

            break;
        }
        case ALIVE:
        {
            if (m_isDeadByDefault)
            {
                if (m_deathTimer <= update_diff)
                {
                    RemoveCorpse();
                    DEBUG_LOG("Removing alive corpse... %u ", GetUInt32Value(OBJECT_FIELD_ENTRY));
                }
                else
                {
                    m_deathTimer -= update_diff;
                }
            }

            Unit::Update(update_diff, diff);

            if (m_respawnTime > time(NULL))
                setDeathState(JUST_DIED);

            // creature can be dead after Unit::Update call
            // CORPSE/DEAD state will processed at next tick (in other case death timer will be updated unexpectedly)
            if (!isAlive())
                break;

            // if creature is charmed, switch to charmed AI
            if (NeedChangeAI)
            {
                UpdateCharmAI();
                NeedChangeAI = false;
                IsAIEnabled = true;
            }

            if (!(isTotem() || isPet() || IsTempSummon() || IS_CREATURE_GUID(GetOwnerGUID()) && GetOwner()->ToCreature()->isTotem()) && GetMap() && !GetMap()->IsDungeon() && !AI()->IsEscorted() && 
                GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE &&
                GetMotionMaster()->GetCurrentMovementGeneratorType() != FOLLOW_MOTION_TYPE)
            {
                uint32 distToHome = sWorld.getConfig(CONFIG_EVADE_HOMEDIST) * 3;
                if (!IsWithinDistInMap(&homeLocation, distToHome))
                    AI()->EnterEvadeMode();
            }

            if (!IsInEvadeMode() && IsAIEnabled)
            {
                // do not allow the AI to be changed during update
                m_AI_locked = true;
                i_AI->UpdateAI(diff);
                m_AI_locked = false;
            }

            // creature can be dead after UpdateAI call
            // CORPSE/DEAD state will processed at next tick (in other case death timer will be updated unexpectedly)
            if (!isAlive())
                break;
            if (m_regenTimer > 0)
            {
                if (update_diff >= m_regenTimer)
                    m_regenTimer = 0;
                else
                    m_regenTimer -= update_diff;
            }

            if (m_regenTimer != 0)
                break;

            if (!isInCombat())
            {
                if (HasFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_OTHER_TAGGER))
                    SetUInt32Value(UNIT_DYNAMIC_FLAGS, GetCreatureInfo()->dynamicflags);

                RegenerateHealth();
            }
            else if (IsPolymorphed())
                    RegenerateHealth();

            RegenerateMana();

            m_regenTimer = 2000;
            break;
        }
        default:
            break;
    }

    if (m_aiReinitializeCheckTimer <= update_diff)
    {
        if (!isInCombat() && !IsInEvadeMode() && !isCharmed() && m_aiInitializeTime < CreatureAIReInitialize[GetEntry()])
            AIM_Initialize();

        m_aiReinitializeCheckTimer = 10000;
    }
    else
        m_aiReinitializeCheckTimer -= update_diff;
}

void Creature::RegenerateMana()
{
    uint32 curValue = GetPower(POWER_MANA);
    uint32 maxValue = GetMaxPower(POWER_MANA);

    if (curValue >= maxValue)
        return;

    if(GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_NOT_REGEN_MANA)
        return;

    uint32 addvalue = 0;

    // Combat and any controlled creature
    if (isInCombat() || GetCharmerOrOwnerGUID())
    {
        if (!IsUnderLastManaUseEffect())
        {
            float ManaIncreaseRate = sWorld.getRate(RATE_POWER_MANA);
            float Spirit = GetStat(STAT_SPIRIT);

            addvalue = uint32((Spirit/5.0f + 17.0f) * ManaIncreaseRate);
        }
    }
    else
        addvalue = maxValue/3;

    ModifyPower(POWER_MANA, addvalue);
}

void Creature::RegenerateHealth()
{
    if (!isRegeneratingHealth())
        return;

    uint32 curValue = GetHealth();
    uint32 maxValue = GetMaxHealth();

    if (curValue >= maxValue)
        return;

    if(GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_NOT_REGEN_HEALTH)
        return;

    uint32 addvalue = 0;

    // Not only pet, but any controlled creature
    if (GetCharmerOrOwnerGUID())
    {
        float HealthIncreaseRate = sWorld.getRate(RATE_HEALTH);
        float Spirit = GetStat(STAT_SPIRIT);

        if (GetPower(POWER_MANA) > 0)
            addvalue = uint32(Spirit * 0.25 * HealthIncreaseRate);
        else
            addvalue = uint32(Spirit * 0.80 * HealthIncreaseRate);
    }
    else
        addvalue = maxValue/3;

    ModifyHealth(addvalue);
}

bool Creature::AIM_Initialize(CreatureAI* ai)
{
    // make sure nothing can change the AI during AI update
    if (m_AI_locked)
    {
        sLog.outDebug("AIM_Initialize: failed to init, locked.");
        return false;
    }

    UnitAI * oldAI = i_AI;

    GetMotionMaster()->Initialize();
    i_AI = FactorySelector::selectAI(this);

    if (oldAI)
        delete oldAI;

    IsAIEnabled = true;
    i_AI->InitializeAI();
    m_aiInitializeTime = WorldTimer::getMSTime();

    return true;
}

bool Creature::Create(uint32 guidlow, Map *map, uint32 Entry, uint32 team, float x, float y, float z, float ang, const CreatureData *data)
{
    Relocate(x, y, z, ang);
    if (!IsPositionValid())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Creature (guidlow %d, entry %d) not loaded. Suggested coordinates isn't valid (X: %f Y: %f)",guidlow,Entry,x,y);
        return false;
    }

    SetMapId(map->GetId());
    SetInstanceId(map->GetInstanceId());

    SetMap(map);

    //oX = x;     oY = y;    dX = x;    dY = y;    m_moveTime = 0;    m_startMove = 0;
    const bool bResult = CreateFromProto(guidlow, Entry, team, data);

    if (bResult)
    {
        switch (GetCreatureInfo()->rank)
        {
            case CREATURE_ELITE_RARE:
                m_corpseDelay = sWorld.getConfig(CONFIG_CORPSE_DECAY_RARE);
                break;
            case CREATURE_ELITE_ELITE:
                m_corpseDelay = sWorld.getConfig(CONFIG_CORPSE_DECAY_ELITE);
                break;
            case CREATURE_ELITE_RAREELITE:
                m_corpseDelay = sWorld.getConfig(CONFIG_CORPSE_DECAY_RAREELITE);
                break;
            case CREATURE_ELITE_WORLDBOSS:
                m_corpseDelay = sWorld.getConfig(CONFIG_CORPSE_DECAY_WORLDBOSS);
                break;
            default:
                m_corpseDelay = sWorld.getConfig(CONFIG_CORPSE_DECAY_NORMAL);
                break;
        }
        LoadCreaturesAddon();

        if (GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_HASTE_IMMUNE)
            ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_HASTE_SPELLS, true);

        if (GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_NORMAL_MOVEMENT_IMMUNE)
            ApplySpellImmune(1, IMMUNITY_STATE, SPELL_AURA_USE_NORMAL_MOVEMENT_SPEED, true);

        //Ugly Hackfix to prevent cripple (spell of wl pet) on bosses
        if (isWorldBoss())
            ApplySpellImmune(0, IMMUNITY_ID, 20812, true);
    }
    return bResult;
}

bool Creature::isCanTrainingOf(Player* pPlayer, bool msg) const
{
    if (!isTrainer())
        return false;

    TrainerSpellData const* trainer_spells = GetTrainerSpells();

    if (!trainer_spells || trainer_spells->spellList.empty())
    {
        sLog.outLog(LOG_DB_ERR, "Creature %u (Entry: %u) have UNIT_NPC_FLAG_TRAINER but have empty trainer spell list.",
            GetGUIDLow(),GetEntry());
        return false;
    }

    switch (GetCreatureInfo()->trainer_type)
    {
        case TRAINER_TYPE_CLASS:
            if (pPlayer->getClass()!=GetCreatureInfo()->classNum)
            {
                if (msg)
                {
                    pPlayer->PlayerTalkClass->ClearMenus();
                    switch (GetCreatureInfo()->classNum)
                    {
                        case CLASS_DRUID:  pPlayer->PlayerTalkClass->SendGossipMenu(4913,GetGUID()); break;
                        case CLASS_HUNTER: pPlayer->PlayerTalkClass->SendGossipMenu(10090,GetGUID()); break;
                        case CLASS_MAGE:   pPlayer->PlayerTalkClass->SendGossipMenu( 328,GetGUID()); break;
                        case CLASS_PALADIN:pPlayer->PlayerTalkClass->SendGossipMenu(1635,GetGUID()); break;
                        case CLASS_PRIEST: pPlayer->PlayerTalkClass->SendGossipMenu(4436,GetGUID()); break;
                        case CLASS_ROGUE:  pPlayer->PlayerTalkClass->SendGossipMenu(4797,GetGUID()); break;
                        case CLASS_SHAMAN: pPlayer->PlayerTalkClass->SendGossipMenu(5003,GetGUID()); break;
                        case CLASS_WARLOCK:pPlayer->PlayerTalkClass->SendGossipMenu(5836,GetGUID()); break;
                        case CLASS_WARRIOR:pPlayer->PlayerTalkClass->SendGossipMenu(4985,GetGUID()); break;
                    }
                }
                return false;
            }
            break;
        case TRAINER_TYPE_PETS:
            if (pPlayer->getClass()!=CLASS_HUNTER)
            {
                pPlayer->PlayerTalkClass->ClearMenus();
                pPlayer->PlayerTalkClass->SendGossipMenu(3620,GetGUID());
                return false;
            }
            break;
        case TRAINER_TYPE_MOUNTS:
            if (GetCreatureInfo()->race && pPlayer->getRace() != GetCreatureInfo()->race)
            {
                if (msg)
                {
                    pPlayer->PlayerTalkClass->ClearMenus();
                    switch (GetCreatureInfo()->classNum)
                    {
                        case RACE_DWARF:        pPlayer->PlayerTalkClass->SendGossipMenu(5865,GetGUID()); break;
                        case RACE_GNOME:        pPlayer->PlayerTalkClass->SendGossipMenu(4881,GetGUID()); break;
                        case RACE_HUMAN:        pPlayer->PlayerTalkClass->SendGossipMenu(5861,GetGUID()); break;
                        case RACE_NIGHTELF:     pPlayer->PlayerTalkClass->SendGossipMenu(5862,GetGUID()); break;
                        case RACE_ORC:          pPlayer->PlayerTalkClass->SendGossipMenu(5863,GetGUID()); break;
                        case RACE_TAUREN:       pPlayer->PlayerTalkClass->SendGossipMenu(5864,GetGUID()); break;
                        case RACE_TROLL:        pPlayer->PlayerTalkClass->SendGossipMenu(5816,GetGUID()); break;
                        case RACE_UNDEAD_PLAYER:pPlayer->PlayerTalkClass->SendGossipMenu(624,GetGUID()); break;
                        case RACE_BLOODELF:     pPlayer->PlayerTalkClass->SendGossipMenu(5862,GetGUID()); break;
                        case RACE_DRAENEI:      pPlayer->PlayerTalkClass->SendGossipMenu(5864,GetGUID()); break;
                    }
                }
                return false;
            }
            break;
        case TRAINER_TYPE_TRADESKILLS:
            if (GetCreatureInfo()->trainer_spell && !pPlayer->HasSpell(GetCreatureInfo()->trainer_spell))
            {
                if (msg)
                {
                    pPlayer->PlayerTalkClass->ClearMenus();
                    pPlayer->PlayerTalkClass->SendGossipMenu(11031,GetGUID());
                }
                return false;
            }
            break;
        default:
            return false;                                   // checked and error output at creature_template loading
    }
    return true;
}

bool Creature::isCanInteractWithBattleMaster(Player* pPlayer, bool msg) const
{
    if (!isBattleMaster())
        return false;

    BattleGroundTypeId bgTypeId = sBattleGroundMgr.GetBattleMasterBG(GetEntry());
    if (!msg)
        return pPlayer->GetBGAccessByLevel(bgTypeId);

    if (!pPlayer->GetBGAccessByLevel(bgTypeId))
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        switch (bgTypeId)
        {
            case BATTLEGROUND_AV:  pPlayer->PlayerTalkClass->SendGossipMenu(7616,GetGUID()); break;
            case BATTLEGROUND_WS:  pPlayer->PlayerTalkClass->SendGossipMenu(7599,GetGUID()); break;
            case BATTLEGROUND_AB:  pPlayer->PlayerTalkClass->SendGossipMenu(7642,GetGUID()); break;
            case BATTLEGROUND_EY:
            case BATTLEGROUND_NA:
            case BATTLEGROUND_BE:
            case BATTLEGROUND_AA:
            case BATTLEGROUND_RL:  pPlayer->PlayerTalkClass->SendGossipMenu(10024,GetGUID()); break;
            break;
        }
        return false;
    }
    return true;
}

bool Creature::isCanTrainingAndResetTalentsOf(Player* pPlayer) const
{
    return pPlayer->getLevel() >= 10
        && GetCreatureInfo()->trainer_type == TRAINER_TYPE_CLASS
        && pPlayer->getClass() == GetCreatureInfo()->classNum;
}

void Creature::prepareGossipMenu(Player *pPlayer,uint32 gossipid)
{
    //Prevent gossip from NPCs that are possessed.
    Unit* Charmed = Unit::GetCharmer();
    if (Charmed)
        return;

    // don't prepere menu for dueling players
    if (pPlayer->duel)
        return;

    PlayerMenu* pm=pPlayer->PlayerTalkClass;
    pm->ClearMenus();

    // lazy loading single time at use
    LoadGossipOptions();

    for (GossipOptionList::iterator i = m_goptions.begin(); i != m_goptions.end(); ++i)
    {
        GossipOption* gso=&*i;
        if (gso->GossipId == gossipid)
        {
            bool cantalking=true;
            if (gso->Id==1)
            {
                uint32 textid=GetNpcTextId();
                GossipText const * gossiptext=sObjectMgr.GetGossipText(textid);
                if (!gossiptext)
                    cantalking=false;
            }
            else
            {
                switch (gso->Action)
                {
                    case GOSSIP_OPTION_QUESTGIVER:
                        pPlayer->PrepareQuestMenu(GetGUID());
                        //if (pm->GetQuestMenu()->MenuItemCount() == 0)
                        cantalking=false;
                        //pm->GetQuestMenu()->ClearMenu();
                        break;
                    case GOSSIP_OPTION_ARMORER:
                        cantalking=false;                   // added in special mode
                        break;
                    case GOSSIP_OPTION_SPIRITHEALER:
                        if (!pPlayer->isDead())
                            cantalking=false;
                        break;
                    case GOSSIP_OPTION_VENDOR:
                    {
                        VendorItemData const* vItems = GetVendorItems();
                        if (!vItems || vItems->Empty())
                        {
                            sLog.outLog(LOG_DB_ERR, "Creature %u (Entry: %u) have UNIT_NPC_FLAG_VENDOR but have empty trading item list.",
                                GetGUIDLow(),GetEntry());
                            cantalking=false;
                        }
                        break;
                    }
                    case GOSSIP_OPTION_TRAINER:
                        if (!isCanTrainingOf(pPlayer,false))
                            cantalking=false;
                        break;
                    case GOSSIP_OPTION_UNLEARNTALENTS:
                        if (!isCanTrainingAndResetTalentsOf(pPlayer))
                            cantalking=false;
                        break;
                    case GOSSIP_OPTION_UNLEARNPETSKILLS:
                        if (!pPlayer->GetPet() || pPlayer->GetPet()->getPetType() != HUNTER_PET || pPlayer->GetPet()->m_spells.size() <= 1 || GetCreatureInfo()->trainer_type != TRAINER_TYPE_PETS || GetCreatureInfo()->classNum != CLASS_HUNTER)
                            cantalking=false;
                        break;
                    case GOSSIP_OPTION_TAXIVENDOR:
                        if (pPlayer->GetSession()->SendLearnNewTaxiNode(this))
                            return;
                        break;
                    case GOSSIP_OPTION_BATTLEFIELD:
                        if (!isCanInteractWithBattleMaster(pPlayer,false))
                            cantalking=false;
                        break;
                    case GOSSIP_OPTION_SPIRITGUIDE:
                    case GOSSIP_OPTION_INNKEEPER:
                    case GOSSIP_OPTION_BANKER:
                    case GOSSIP_OPTION_PETITIONER:
                    case GOSSIP_OPTION_STABLEPET:
                    case GOSSIP_OPTION_TABARDDESIGNER:
                    case GOSSIP_OPTION_AUCTIONEER:
                        break;                              // no checks
                    case GOSSIP_OPTION_OUTDOORPVP:
                        if (!sOutdoorPvPMgr.CanTalkTo(pPlayer,this,(*gso)))
                            cantalking = false;
                        break;
                    default:
                        sLog.outLog(LOG_DB_ERR, "Creature %u (entry: %u) have unknown gossip option %u",GetDBTableGUIDLow(),GetEntry(),gso->Action);
                        break;
                }
            }

            //note for future dev: should have database fields for BoxMessage & BoxMoney
            if (!gso->OptionText.empty() && cantalking)
            {
                std::string OptionText = gso->OptionText;
                std::string BoxText = gso->BoxText;
                int loc_idx = pPlayer->GetSession()->GetSessionDbLocaleIndex();
                if (loc_idx >= 0)
                {
                    NpcOptionLocale const *no = sObjectMgr.GetNpcOptionLocale(gso->Id);
                    if (no)
                    {
                        if (no->OptionText.size() > loc_idx && !no->OptionText[loc_idx].empty())
                            OptionText=no->OptionText[loc_idx];
                        if (no->BoxText.size() > loc_idx && !no->BoxText[loc_idx].empty())
                            BoxText=no->BoxText[loc_idx];
                    }
                }
                pm->GetGossipMenu().AddMenuItem((uint8)gso->Icon,OptionText, gossipid,gso->Action,BoxText,gso->BoxMoney,gso->Coded);
            }
        }
    }

    ///some gossips aren't handled in normal way ... so we need to do it this way .. TODO: handle it in normal way ;-)
    if (pm->Empty())
    {
        if (HasFlag(UNIT_NPC_FLAGS,UNIT_NPC_FLAG_TRAINER))
        {
            isCanTrainingOf(pPlayer,true);                  // output error message if need
        }
        if (HasFlag(UNIT_NPC_FLAGS,UNIT_NPC_FLAG_BATTLEMASTER))
        {
            isCanInteractWithBattleMaster(pPlayer,true);     // output error message if need
        }
    }
}

void Creature::sendPreparedGossip(Player* player)
{
    if (!player)
        return;

    if (GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_WORLDEVENT) // if world event npc then
        sGameEventMgr.HandleWorldEventGossip(player, this);      // update world state with progress

    // in case no gossip flag and quest menu not empty, open quest menu (client expect gossip menu with this flag)
    if (!HasFlag(UNIT_NPC_FLAGS,UNIT_NPC_FLAG_GOSSIP) && !player->PlayerTalkClass->GetQuestMenu().Empty())
    {
        player->SendPreparedQuest(GetGUID());
        return;
    }

    // in case non empty gossip menu (that not included quests list size) show it
    // (quest entries from quest menu will be included in list)
    player->PlayerTalkClass->SendGossipMenu(GetNpcTextId(), GetGUID());
}

void Creature::OnGossipSelect(Player* player, uint32 option)
{
    // player can't select gossip if in duel
    if (player->duel)
        return;

    GossipMenu& gossipmenu = player->PlayerTalkClass->GetGossipMenu();

    if (option >= gossipmenu.MenuItemCount())
        return;

    uint32 action=gossipmenu.GetItem(option).m_gAction;
    uint32 zoneid=GetZoneId();
    uint64 guid=GetGUID();

    GossipOption const *gossip=GetGossipOption(action);
    if (!gossip)
    {
        zoneid=0;
        gossip=GetGossipOption(action);
        if (!gossip)
            return;
    }

    switch (gossip->Action)
    {
        case GOSSIP_OPTION_GOSSIP:
        {
            uint32 textid = GetGossipTextId(action, zoneid);
            if (textid == 0)
                textid=GetNpcTextId();

            player->PlayerTalkClass->CloseGossip();
            player->PlayerTalkClass->SendTalking(textid);
            break;
        }
        case GOSSIP_OPTION_OUTDOORPVP:
            sOutdoorPvPMgr.HandleGossipOption(player, GetGUID(), option);
            break;
        case GOSSIP_OPTION_SPIRITHEALER:
            if (player->isDead())
                CastSpell(this,17251,true,NULL,NULL,player->GetGUID());
            break;
        case GOSSIP_OPTION_QUESTGIVER:
            player->PrepareQuestMenu(guid);
            player->SendPreparedQuest(guid);
            break;
        case GOSSIP_OPTION_VENDOR:
        case GOSSIP_OPTION_ARMORER:
            player->GetSession()->SendListInventory(guid);
            break;
        case GOSSIP_OPTION_STABLEPET:
            player->GetSession()->SendStablePet(guid);
            break;
        case GOSSIP_OPTION_TRAINER:
            player->GetSession()->SendTrainerList(guid);
            break;
        case GOSSIP_OPTION_UNLEARNTALENTS:
            player->PlayerTalkClass->CloseGossip();
            player->SendTalentWipeConfirm(guid);
            break;
        case GOSSIP_OPTION_UNLEARNPETSKILLS:
            player->PlayerTalkClass->CloseGossip();
            player->SendPetSkillWipeConfirm();
            break;
        case GOSSIP_OPTION_TAXIVENDOR:
            player->GetSession()->SendTaxiMenu(this);
            break;
        case GOSSIP_OPTION_INNKEEPER:
            player->PlayerTalkClass->CloseGossip();
            player->SetBindPoint(guid);
            break;
        case GOSSIP_OPTION_BANKER:
            player->GetSession()->SendShowBank(guid);
            break;
        case GOSSIP_OPTION_PETITIONER:
            player->PlayerTalkClass->CloseGossip();
            player->GetSession()->SendPetitionShowList(guid);
            break;
        case GOSSIP_OPTION_TABARDDESIGNER:
            player->PlayerTalkClass->CloseGossip();
            player->GetSession()->SendTabardVendorActivate(guid);
            break;
        case GOSSIP_OPTION_AUCTIONEER:
            player->GetSession()->SendAuctionHello(this);
            break;
        case GOSSIP_OPTION_SPIRITGUIDE:
        case GOSSIP_GUARD_SPELLTRAINER:
        case GOSSIP_GUARD_SKILLTRAINER:
            prepareGossipMenu(player,gossip->Id);
            sendPreparedGossip(player);
            break;
        case GOSSIP_OPTION_BATTLEFIELD:
        {
            BattleGroundTypeId bgTypeId = sBattleGroundMgr.GetBattleMasterBG(GetEntry());
            player->GetSession()->SendBattlegGroundList(ObjectGuid(GetGUID()), bgTypeId);
            break;
        }
        default:
            OnPoiSelect(player, gossip);
            break;
    }

}

void Creature::OnPoiSelect(Player* player, GossipOption const *gossip)
{
    if (gossip->GossipId==GOSSIP_GUARD_SPELLTRAINER || gossip->GossipId==GOSSIP_GUARD_SKILLTRAINER)
    {
        Poi_Icon icon = ICON_POI_0;
        //need add more case.
        switch (gossip->Action)
        {
            case GOSSIP_GUARD_BANK:
                icon=ICON_POI_HOUSE;
                break;
            case GOSSIP_GUARD_RIDE:
                icon=ICON_POI_RWHORSE;
                break;
            case GOSSIP_GUARD_GUILD:
                icon=ICON_POI_BLUETOWER;
                break;
            default:
                icon=ICON_POI_TOWER;
                break;
        }
        uint32 textid = GetGossipTextId(gossip->Action, GetZoneId());
        player->PlayerTalkClass->SendTalking(textid);
        // std::string areaname= gossip->OptionText;
        // how this could worked player->PlayerTalkClass->SendPointOfInterest(x, y, icon, 2, 15, areaname.c_str());
    }
}

uint32 Creature::GetGossipTextId(uint32 action, uint32 zoneid)
{
    QueryResultAutoPtr result= GameDataDatabase.PQuery("SELECT textid FROM npc_gossip_textid WHERE action = '%u' AND zoneid ='%u'", action, zoneid);

    if (!result)
        return 0;

    Field *fields = result->Fetch();
    uint32 id = fields[0].GetUInt32();

    return id;
}

uint32 Creature::GetNpcTextId()
{
    // don't cache / use cache in case it's a world event announcer
    if (GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_WORLDEVENT)
        if (uint32 textid = sGameEventMgr.GetNpcTextId(m_DBTableGuid))
            return textid;

    if (!m_DBTableGuid)
        return DEFAULT_GOSSIP_MESSAGE;

    if (uint32 pos = sObjectMgr.GetNpcGossip(m_DBTableGuid))
        return pos;

    return DEFAULT_GOSSIP_MESSAGE;
}

GossipOption const* Creature::GetGossipOption(uint32 id) const
{
    for (GossipOptionList::const_iterator i = m_goptions.begin(); i != m_goptions.end(); ++i)
    {
        if (i->Action==id)
            return &*i;
    }
    return NULL;
}

void Creature::ResetGossipOptions()
{
    m_gossipOptionLoaded = false;
    m_goptions.clear();
}

void Creature::LoadGossipOptions()
{
    if (m_gossipOptionLoaded)
        return;

    uint32 npcflags=GetUInt32Value(UNIT_NPC_FLAGS);

    CacheNpcOptionList const& noList = sObjectMgr.GetNpcOptions ();
    for (CacheNpcOptionList::const_iterator i = noList.begin (); i != noList.end (); ++i)
        if (i->NpcFlag & npcflags)
            addGossipOption(*i);

    m_gossipOptionLoaded = true;
}

Player *Creature::GetLootRecipient() const
{
    if (!m_lootRecipient) return NULL;
    else return ObjectAccessor::FindPlayer(m_lootRecipient);
}

void Creature::SetLootRecipient(Unit *unit)
{
    // set the player whose group should receive the right
    // to loot the creature after it dies
    // should be set to NULL after the loot disappears

    if (!unit)
    {
        loot.RemoveSavedLootFromDB();

        m_lootRecipient = 0;
        m_playersAllowedToLoot.clear();

        RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_OTHER_TAGGER);

        return;
    }

    Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (!player)                                             // normal creature, no player involved
        return;

    m_lootRecipient = player->GetGUID();

    // special case for world bosses
    Group* group = player->GetGroup();
    if (isWorldBoss() && group)
    {
        if (GetUnit(group->GetLeaderGUID()))
            m_lootRecipient = group->GetLeaderGUID();
        else if (GetUnit(group->GetLooterGuid()))
            m_lootRecipient = group->GetLooterGuid();

        Map* map = GetMap();
        if (map && map->IsDungeon())
        {
            Map::PlayerList const &PlayerList = map->GetPlayers();
            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                if (Player* i_pl = i->getSource())
                    if (i_pl->GetGroup() == player->GetGroup())
                        m_playersAllowedToLoot.insert(i_pl->GetGUID());
        }
    }

    SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_OTHER_TAGGER);
}

void Creature::SaveToDB()
{
    // this should only be used when the creature has already been loaded
    // preferably after adding to map, because mapid may not be valid otherwise
    CreatureData const *data = sObjectMgr.GetCreatureData(m_DBTableGuid);
    if (!data)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Creature::SaveToDB failed, cannot get creature data!");
        return;
    }

    SaveToDB(GetMapId(), data->spawnMask);
}

void Creature::SaveToDB(uint32 mapid, uint8 spawnMask)
{
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT MAX(guid) FROM creature");
    if (result)
        m_DBTableGuid = (*result)[0].GetUInt32()+1;

    // update in loaded data
    if (!m_DBTableGuid)
        m_DBTableGuid = GetGUIDLow();

    CreatureData& data = sObjectMgr.NewOrExistCreatureData(m_DBTableGuid);

    uint32 displayId = GetNativeDisplayId();

    // check if it's a custom model and if not, use 0 for displayId
    CreatureInfo const *cinfo = GetCreatureInfo();
    if (cinfo)
    {
        if (displayId == cinfo->Modelid_A1 || displayId == cinfo->Modelid_A2 ||
            displayId == cinfo->Modelid_H1 || displayId == cinfo->Modelid_H2) displayId = 0;
    }

    // data->guid = guid don't must be update at save
    data.id = GetEntry();
    data.mapid = mapid;
    data.displayid = displayId;
    data.equipmentId = GetEquipmentId();
    data.posX = GetPositionX();
    data.posY = GetPositionY();
    data.posZ = GetPositionZ();
    data.orientation = GetOrientation();
    data.spawntimesecs = m_respawnDelay;
    // prevent add data integrity problems
    data.spawndist = GetDefaultMovementType() == IDLE_MOTION_TYPE ? 0 : m_respawnradius;
    data.currentwaypoint = 0;
    data.curhealth = GetHealth();
    data.curmana = GetPower(POWER_MANA);
    data.is_dead = m_isDeadByDefault;
    // prevent add data integrity problems
    data.movementType = !m_respawnradius && GetDefaultMovementType() == RANDOM_MOTION_TYPE ? IDLE_MOTION_TYPE : GetDefaultMovementType();
    data.spawnMask = spawnMask;

    // updated in DB
    GameDataDatabase.BeginTransaction();

    //GameDataDatabase.PExecuteLog("DELETE FROM creature WHERE guid = '%u'", m_DBTableGuid);

    std::ostringstream ss;
    ss << "INSERT INTO creature VALUES ("
            << m_DBTableGuid << ","
            << GetEntry() << ","
            << mapid << ","
            << (uint32) spawnMask << ","
            << displayId << ","
            << GetEquipmentId() << ","
            << GetPositionX() << ","
            << GetPositionY() << ","
            << GetPositionZ() << ","
            << GetOrientation() << ","
            << m_respawnDelay << "," //respawn time
            << (float) m_respawnradius << "," //spawn distance (float)
            << (uint32) (0) << "," //currentwaypoint
            << GetHealth() << "," //curhealth
            << GetPower(POWER_MANA) << "," //curmana
            << (m_isDeadByDefault ? 1 : 0) << "," //is_dead
            << GetDefaultMovementType() << ")"; //default movement generator type

    GameDataDatabase.PExecuteLog(ss.str().c_str());

    GameDataDatabase.CommitTransaction();
}

void Creature::SelectLevel(const CreatureInfo *cinfo)
{
    uint32 rank = isPet()? 0 : cinfo->rank;

    // level
    uint32 minlevel = std::min(cinfo->maxlevel, cinfo->minlevel);
    uint32 maxlevel = std::max(cinfo->maxlevel, cinfo->minlevel);
    uint32 level = minlevel == maxlevel ? minlevel : urand(minlevel, maxlevel);
    SetLevel(level);

    float rellevel = maxlevel == minlevel ? 0 : (float(level - minlevel))/(maxlevel - minlevel);

    // health
    float healthmod = _GetHealthMod(rank);

    uint32 minhealth = std::min(cinfo->maxhealth, cinfo->minhealth);
    uint32 maxhealth = std::max(cinfo->maxhealth, cinfo->minhealth);
    uint32 health = (rellevel == 0 ? uint32(healthmod * urand(minhealth, maxhealth)) : uint32(healthmod * (minhealth + uint32(rellevel*(maxhealth - minhealth)))));
    if (health < 1)
        health = 1;

    SetCreateHealth(health);
    SetMaxHealth(health);
    SetHealth(health);
    ResetPlayerDamageReq();

    // mana
    uint32 minmana = std::min(cinfo->maxmana, cinfo->minmana);
    uint32 maxmana = std::max(cinfo->maxmana, cinfo->minmana);
    uint32 mana = minmana + uint32(rellevel*(maxmana - minmana));

    SetCreateMana(mana);
    SetMaxPower(POWER_MANA, mana);                          //MAX Mana
    SetPower(POWER_MANA, mana);

    SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, health);
    SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, mana);

    // damage
    float damagemod = _GetDamageMod(rank);

    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, cinfo->mindmg * damagemod);
    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, cinfo->maxdmg * damagemod);
    SetBaseWeaponDamage(OFF_ATTACK, MINDAMAGE, cinfo->mindmg * damagemod);
    SetBaseWeaponDamage(OFF_ATTACK, MAXDAMAGE, cinfo->maxdmg * damagemod);
    SetBaseWeaponDamage(RANGED_ATTACK, MINDAMAGE, cinfo->minrangedmg * damagemod);
    SetBaseWeaponDamage(RANGED_ATTACK, MAXDAMAGE, cinfo->maxrangedmg * damagemod);

    // this value is not accurate, but should be close to the real value
    SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, level * 5);
    SetModifierValue(UNIT_MOD_ATTACK_POWER_RANGED, BASE_VALUE, level * 5);
    //SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, cinfo->attackpower * damagemod);
    //SetModifierValue(UNIT_MOD_ATTACK_POWER_RANGED, BASE_VALUE, cinfo->rangedattackpower * damagemod);
}

float Creature::_GetHealthMod(int32 Rank)
{
    switch (Rank)                                           // define rates for each elite rank
    {
        case CREATURE_ELITE_NORMAL:
            return sWorld.getRate(RATE_CREATURE_NORMAL_HP);
        case CREATURE_ELITE_ELITE:
            return sWorld.getRate(RATE_CREATURE_ELITE_ELITE_HP);
        case CREATURE_ELITE_RAREELITE:
            return sWorld.getRate(RATE_CREATURE_ELITE_RAREELITE_HP);
        case CREATURE_ELITE_WORLDBOSS:
            return sWorld.getRate(RATE_CREATURE_ELITE_WORLDBOSS_HP);
        case CREATURE_ELITE_RARE:
            return sWorld.getRate(RATE_CREATURE_ELITE_RARE_HP);
        default:
            return sWorld.getRate(RATE_CREATURE_ELITE_ELITE_HP);
    }
}

float Creature::_GetDamageMod(int32 Rank)
{
    switch (Rank)                                           // define rates for each elite rank
    {
        case CREATURE_ELITE_NORMAL:
            return sWorld.getRate(RATE_CREATURE_NORMAL_DAMAGE);
        case CREATURE_ELITE_ELITE:
            return sWorld.getRate(RATE_CREATURE_ELITE_ELITE_DAMAGE);
        case CREATURE_ELITE_RAREELITE:
            return sWorld.getRate(RATE_CREATURE_ELITE_RAREELITE_DAMAGE);
        case CREATURE_ELITE_WORLDBOSS:
            return sWorld.getRate(RATE_CREATURE_ELITE_WORLDBOSS_DAMAGE);
        case CREATURE_ELITE_RARE:
            return sWorld.getRate(RATE_CREATURE_ELITE_RARE_DAMAGE);
        default:
            return sWorld.getRate(RATE_CREATURE_ELITE_ELITE_DAMAGE);
    }
}

float Creature::GetSpellDamageMod(int32 Rank)
{
    switch (Rank)                                           // define rates for each elite rank
    {
        case CREATURE_ELITE_NORMAL:
            return sWorld.getRate(RATE_CREATURE_NORMAL_SPELLDAMAGE);
        case CREATURE_ELITE_ELITE:
            return sWorld.getRate(RATE_CREATURE_ELITE_ELITE_SPELLDAMAGE);
        case CREATURE_ELITE_RAREELITE:
            return sWorld.getRate(RATE_CREATURE_ELITE_RAREELITE_SPELLDAMAGE);
        case CREATURE_ELITE_WORLDBOSS:
            return sWorld.getRate(RATE_CREATURE_ELITE_WORLDBOSS_SPELLDAMAGE);
        case CREATURE_ELITE_RARE:
            return sWorld.getRate(RATE_CREATURE_ELITE_RARE_SPELLDAMAGE);
        default:
            return sWorld.getRate(RATE_CREATURE_ELITE_ELITE_SPELLDAMAGE);
    }
}

bool Creature::CreateFromProto(uint32 guidlow, uint32 Entry, uint32 team, const CreatureData *data)
{
    SetZoneScript();
    if (m_zoneScript && data)
    {
        Entry = m_zoneScript->GetCreatureEntry(guidlow, data);
        if (!Entry)
            return false;
    }

    CreatureInfo const *cinfo = ObjectMgr::GetCreatureTemplate(Entry);
    if (!cinfo)
    {
        sLog.outLog(LOG_DB_ERR, "Error: creature entry %u does not exist.", Entry);
        return false;
    }
    m_originalEntry = Entry;

    Object::_Create(guidlow, Entry, HIGHGUID_UNIT);

    if (!UpdateEntry(Entry, team, data))
        return false;

    return true;
}

bool Creature::LoadFromDB(uint32 guid, Map *map)
{
    CreatureData const* data = sObjectMgr.GetCreatureData(guid);

    if (!data)
    {
        sLog.outLog(LOG_DB_ERR, "Creature (GUID: %u) not found in table `creature`, can't load. ",guid);
        return false;
    }

    m_DBTableGuid = guid;
    if (map->GetInstanceId() != 0)
        guid = sObjectMgr.GenerateLowGuid(HIGHGUID_UNIT);

    uint16 team = 0;
    if (!Create(guid,map,data->id,team,data->posX,data->posY,data->posZ,data->orientation,data))
        return false;

    //We should set first home position, because then AI calls home movement
    SetHomePosition(data->posX, data->posY, data->posZ, data->orientation);

    m_respawnradius = data->spawndist;

    m_respawnDelay = data->spawntimesecs;
    m_isDeadByDefault = data->is_dead;
    m_deathState = m_isDeadByDefault ? DEAD : ALIVE;

    m_respawnTime = sObjectMgr.GetCreatureRespawnTime(m_DBTableGuid,GetInstanceId());
    if (m_respawnTime)                          // respawn on Update
    {
        m_deathState = DEAD;
        if (isWorldBoss() && map->IsDungeon())
            loot.FillLootFromDB(this, NULL);

        if (CanFly())
        {
            float tz = GetTerrain()->GetHeight(data->posX,data->posY,data->posZ,false);
            if (data->posZ - tz > 0.1)
                Relocate(data->posX,data->posY,tz);
        }
    }

    uint32 curhealth = data->curhealth;
    if (curhealth)
    {
        curhealth = uint32(curhealth*_GetHealthMod(GetCreatureInfo()->rank));
        if (curhealth < 1)
            curhealth = 1;
    }

    SetHealth(m_deathState == ALIVE ? curhealth : 0);
    SetPower(POWER_MANA,data->curmana);

    // checked at creature_template loading
    m_defaultMovementType = MovementGeneratorType(data->movementType);
    

    if (CreatureInfo const* info = sObjectMgr.GetCreatureTemplate(data->id))
        m_xpMod = info->xpMod;
    else
        m_xpMod = 0.0f;

    m_creatureData = data;

    // check if it is rabbit day
    if (isAlive() && sWorld.getConfig(CONFIG_RABBIT_DAY))
    {
        time_t rabbit_day = time_t(sWorld.getConfig(CONFIG_RABBIT_DAY));
        tm rabbit_day_tm = *localtime(&rabbit_day);
        tm now_tm = *localtime(&sWorld.GetGameTime());

        if (now_tm.tm_mon == rabbit_day_tm.tm_mon && now_tm.tm_mday == rabbit_day_tm.tm_mday)
            CastSpell(this, 10710 + urand(0, 2), true);
    }

    return true;
}

void Creature::LoadEquipment(uint32 equip_entry, bool force)
{
    if (equip_entry == 0)
    {
        if (force)
        {
            for (uint8 i = 0; i < 3; i++)
            {
                SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + i, 0);
                SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO + (i * 2), 0);
                SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO + (i * 2) + 1, 0);
            }
            m_equipmentId = 0;
        }
        return;
    }

    EquipmentInfo const *einfo = sObjectMgr.GetEquipmentInfo(equip_entry);
    if (!einfo)
        return;

    m_equipmentId = equip_entry;
    for (uint8 i = 0; i < 3; i++)
    {
        SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + i, einfo->equipmodel[i]);
        SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO + (i * 2), einfo->equipinfo[i]);
        SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO + (i * 2) + 1, einfo->equipslot[i]);
    }
}

bool Creature::hasQuest(uint32 quest_id) const
{
    QuestRelations const& qr = sObjectMgr.mCreatureQuestRelations;
    for (QuestRelations::const_iterator itr = qr.lower_bound(GetEntry()); itr != qr.upper_bound(GetEntry()); ++itr)
    {
        if (itr->second == quest_id)
            return true;
    }
    return false;
}

bool Creature::hasInvolvedQuest(uint32 quest_id) const
{
    QuestRelations const& qr = sObjectMgr.mCreatureQuestInvolvedRelations;
    for (QuestRelations::const_iterator itr = qr.lower_bound(GetEntry()); itr != qr.upper_bound(GetEntry()); ++itr)
    {
        if (itr->second==quest_id)
            return true;
    }
    return false;
}

void Creature::DeleteFromDB()
{
    if (!m_DBTableGuid)
    {
        sLog.outDebug("Trying to delete not saved creature!");
        return;
    }

    sObjectMgr.SaveCreatureRespawnTime(m_DBTableGuid,GetInstanceId(),0);
    sObjectMgr.DeleteCreatureData(m_DBTableGuid);

    static SqlStatementID deleteCreature;
    static SqlStatementID deleteCreatureAddon;
    static SqlStatementID deleteGECreature;
    static SqlStatementID deleteGEModelEquip;

    GameDataDatabase.BeginTransaction();
    GameDataDatabase.PExecuteLog("DELETE FROM creature WHERE guid = '%u'", m_DBTableGuid);
    GameDataDatabase.PExecuteLog("DELETE FROM creature_addon WHERE guid = '%u'", m_DBTableGuid);
    GameDataDatabase.PExecuteLog("DELETE FROM game_event_creature WHERE guid = '%u'", m_DBTableGuid);
    GameDataDatabase.PExecuteLog("DELETE FROM game_event_model_equip WHERE guid = '%u'", m_DBTableGuid);
    GameDataDatabase.CommitTransaction();
}

bool Creature::canSeeOrDetect(Unit const* u, WorldObject const* viewPoint, bool detect, bool inVisibleList, bool is3dDistance) const
{
    // not in world
    if (!IsInWorld() || !u->IsInWorld())
        return false;

    // all dead creatures/players not visible for any creatures
    if (!u->isAlive() || !isAlive())
        return false;

    // Always can see self
    if (u == this)
        return true;

    // always seen by owner
    if (GetGUID() == u->GetCharmerOrOwnerGUID())
        return true;

    if (u->GetVisibility() == VISIBILITY_OFF) //GM
        return false;

    if (u->GetObjectGuid().IsAnyTypeCreature() && u->ToCreature()->IsAIEnabled && !u->ToCreature()->AI()->IsVisible())
        return false;

    // invisible aura
    if ((m_invisibilityMask || u->m_invisibilityMask) && !canDetectInvisibilityOf(u, viewPoint))
        return false;

    // unit got in stealth in this moment and must ignore old detected state
    //if (m_Visibility == VISIBILITY_GROUP_NO_DETECT)
    //    return false;

    // GM invisibility checks early, invisibility if any detectable, so if not stealth then visible
    if (u->GetVisibility() == VISIBILITY_GROUP_STEALTH)
    {
        //do not know what is the use of this detect
        if (!detect || !canDetectStealthOf(u, viewPoint, viewPoint->GetDistance(u)))
            return false;
    }

    // Now check is target visible with LoS
    //return u->IsWithinLOS(GetPositionX(),GetPositionY(),GetPositionZ());
    return true;
}

bool Creature::IsWithinSightDist(Unit const* u) const
{
    if (!IsWithinDistInMap(u, sWorld.getConfig(CONFIG_SIGHT_MONSTER)))
        return false;

    return IsWithinLOSInMap(u);
}

bool Creature::canStartAttack(Unit const* who) const
{
    if (isCivilian()
        || HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PASSIVE)
        || !who->isInAccessiblePlacefor (this)
        || (!CanFly() && GetDistanceZ(who) > CREATURE_Z_ATTACK_RANGE)
        || !IsWithinDistInMap(who, GetAttackDistance(who))
        || !isAlive())
        return false;

    if (IsInEvadeMode())
        return false;

    if (!canAttack(who, false))
        return false;

    return IsWithinLOSInMap(who);
}

float Creature::GetAttackDistance(Unit const* pl) const
{
    float aggroRate = sWorld.getRate(isGuard() ? RATE_CREATURE_GUARD_AGGRO : RATE_CREATURE_AGGRO);

    if (aggroRate==0)
        return 0.0f;

    int32 playerlevel   = pl->getLevelForTarget(this);
    int32 creaturelevel = getLevelForTarget(pl);

    int32 leveldif       = playerlevel - creaturelevel;

    // "The maximum Aggro Radius has a cap of 25 levels under. Example: A level 30 char has the same Aggro Radius of a level 5 char on a level 60 mob."
    if (leveldif < - 25)
        leveldif = -25;

    // "The aggro radius of a mob having the same level as the player is roughly 20 yards"
    float RetDistance = m_aggroRange ? m_aggroRange : 20.0;

    // "Aggro Radius varies with level difference at a rate of roughly 1 yard/level"
    // radius grow if playlevel < creaturelevel
    RetDistance -= (float)leveldif;

    int32 CreatureMod = 0;
    int32 PlayerMod = 0;
    //get detect range aura modifiers on creatures
    AuraList const& mTotalAuraList = GetAurasByType(SPELL_AURA_MOD_DETECT_RANGE);
    for (AuraList::const_iterator i = mTotalAuraList.begin();i != mTotalAuraList.end(); ++i)
    {
        if(creaturelevel <= (*i)->GetSpellProto()->MaxTargetLevel)
            CreatureMod += (*i)->GetModifierValue();
    }
    //get detect range aura modifiers on players
    AuraList const& mTotalPlayerAuraList = pl->GetAurasByType(SPELL_AURA_MOD_DETECT_RANGE);
    for (AuraList::const_iterator i = mTotalPlayerAuraList.begin();i != mTotalPlayerAuraList.end(); ++i)
    {
        if(playerlevel <= (*i)->GetSpellProto()->MaxTargetLevel)
            PlayerMod += (*i)->GetModifierValue();
    }

    RetDistance += (CreatureMod + PlayerMod);

    // "Minimum Aggro Radius for a mob seems to be combat range (5 yards)"
    if (RetDistance < 5)
        RetDistance = 5;

    return RetDistance*aggroRate;
}

void Creature::setDeathState(DeathState s)
{
    if ((s == JUST_DIED && !m_isDeadByDefault)||(s == JUST_ALIVED && m_isDeadByDefault))
    {
        m_deathTimer = m_corpseDelay*IN_MILISECONDS;

        // if no loot in DB, remove corpse quickly (20 sec ?)
        CreatureInfo const* cInfo = GetCreatureInfo();
        if (cInfo && !cInfo->lootid && !(cInfo->mingold || cInfo->maxgold) && !isWorldBoss())
            m_deathTimer = 20*IN_MILISECONDS;

        // always save boss respawn time at death to prevent crash cheating
        if (sWorld.getConfig(CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY) || isWorldBoss())
            SaveRespawnTime();

        SetNoSearchAssistance(false);

        //Dismiss group if is leader
        if (m_formation && m_formation->getLeader() == this)
            m_formation->FormationReset(true);

        if (m_zoneScript)
            m_zoneScript->OnCreatureDeath(this);
    }

    Unit::setDeathState(s);

    if (s == JUST_DIED)
    {
        SetSelection(0);                       // remove target selection in any cases (can be set at aura remove in Unit::setDeathState)
        SetUInt32Value(UNIT_NPC_FLAGS, 0);

        setActive(false, ACTIVE_BY_ALL);

        if (!isPet() && GetCreatureInfo()->SkinLootId)
            if (LootTemplates_Skinning.HaveLootfor (GetCreatureInfo()->SkinLootId))
                SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);

        if (CanFly() && !(GetEntry() == 21217)) //Lurker Hack - should not fall to ground
            i_motionMaster.MoveFall();

        if (!loot.empty())
        {
            // Loot is filled in Unit:Kill, here we just do some additional work
            loot.looterTimer = time(NULL) + (m_deathTimer * 3 / 4 / IN_MILISECONDS);
            loot.looterCheckTimer = time(NULL) + 1;
            if (GetLootRecipient() && GetLootRecipient()->GetGroup())
                GetLootRecipient()->GetGroup()->SendRoundRobin(&loot, this);
        }

        Unit::setDeathState(CORPSE);
    }

    if (s == JUST_ALIVED)
    {
        SetHealth(GetMaxHealth(), true);
        SetLootRecipient(NULL);
        ResetPlayerDamageReq();

        Unit::setDeathState(ALIVE);

        CreatureInfo const *cinfo = GetCreatureInfo();
        RemoveFlag (UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);

        SetWalk(true);

        SetUInt32Value(UNIT_NPC_FLAGS, cinfo->npcflag);

        clearUnitState(UNIT_STAT_ALL_STATE);
        GetMotionMaster()->Initialize();

        SetMeleeDamageSchool(SpellSchools(cinfo->dmgschool));
        LoadCreaturesAddon(true);

        //reset map changes
        GetMap()->CreatureRespawnRelocation(this);

        UpdateVisibilityAndView();
        SetVisibility(GetVisibility());
        
        if (!this->IsTempSummon())
        {
            SpellEntry *TempSpell = (SpellEntry*)GetSpellStore()->LookupEntry(30615);
            if(TempSpell)
                TempSpell->DurationIndex = 407; // 100 ms fear duration

            //fear
            CastSpell(this, TempSpell, true); //what a fucking hack - after fear respawned mobs with an ai cast again xDD
        }
    }
}

void Creature::Respawn()
{
    RemoveCorpse();

    // forced recreate creature object at clients
    UnitVisibility currentVis = GetVisibility();
    SetVisibility(VISIBILITY_RESPAWN);
    SetVisibility(currentVis);                              // restore visibility state
    UpdateVisibilityAndView();


    if (getDeathState()==DEAD)
    {
        if (m_DBTableGuid)
            sObjectMgr.SaveCreatureRespawnTime(m_DBTableGuid,GetInstanceId(),0);

        DEBUG_LOG("Respawning...");
        m_respawnTime = 0;
        lootForPickPocketed = false;
        lootForBody         = false;

        if (m_originalEntry != GetEntry())
            UpdateEntry(m_originalEntry);

        CreatureInfo const *cinfo = GetCreatureInfo();
        SelectLevel(cinfo);

        if (m_isDeadByDefault)
        {
            setDeathState(JUST_DIED);
            SetHealth(0);
            GetUnitStateMgr().InitDefaults(true);
            clearUnitState(UNIT_STAT_ALL_STATE);
            LoadCreaturesAddon(true);
        }
        else
            setDeathState(JUST_ALIVED);

        //Call AI respawn virtual function
        if (IsAIEnabled)
        {
            AI()->Reset();
            TriggerJustRespawned = true;    //delay event to next tick so all creatures are created on the map before processing
        }

        //GetMap()->Add(this);
        uint16 poolid = sPoolMgr.IsPartOfAPool<Creature>(GetGUIDLow());
        if (poolid)
            sPoolMgr.UpdatePool<Creature>(poolid, GetGUIDLow());
    }

    SendMonsterStop();
}

void Creature::ForcedDespawn(uint32 timeMSToDespawn)
{
    if (timeMSToDespawn)
    {
        ForcedDespawnDelayEvent *pEvent = new ForcedDespawnDelayEvent(*this);

        m_Events.AddEvent(pEvent, m_Events.CalculateTime(timeMSToDespawn));
        return;
    }

    if (isAlive())
        setDeathState(JUST_DIED);

    RemoveCorpse();
    SetHealth(0);                                           // just for nice GM-mode view
}

bool Creature::IsImmunedToSpell(SpellEntry const* spellInfo, bool useCharges)
{
    if (!spellInfo)
        return false;

    if (GetCreatureInfo()->MechanicImmuneMask & (1 << (spellInfo->Mechanic - 1)))
        return true;

    return Unit::IsImmunedToSpell(spellInfo, useCharges);
}

bool Creature::IsImmunedToSpellEffect(uint32 effect, uint32 mechanic) const
{
    if (GetCreatureInfo()->MechanicImmuneMask & (1 << (mechanic-1)))
        return true;

    return Unit::IsImmunedToSpellEffect(effect, mechanic);
}

SpellEntry const *Creature::reachWithSpellAttack(Unit *pVictim)
{
    if (!pVictim)
        return NULL;

    for (uint32 i=0; i < CREATURE_MAX_SPELLS; i++)
    {
        if (!m_spells[i])
            continue;
        SpellEntry const *spellInfo = sSpellStore.LookupEntry(m_spells[i]);
        if (!spellInfo)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: WORLD: unknown spell id %i\n", m_spells[i]);
            continue;
        }

        bool bcontinue = true;
        for (uint32 j=0;j<3;j++)
        {
            if ((spellInfo->Effect[j] == SPELL_EFFECT_SCHOOL_DAMAGE)       ||
                (spellInfo->Effect[j] == SPELL_EFFECT_INSTAKILL)            ||
                (spellInfo->Effect[j] == SPELL_EFFECT_ENVIRONMENTAL_DAMAGE) ||
                (spellInfo->Effect[j] == SPELL_EFFECT_HEALTH_LEECH)
               )
            {
                bcontinue = false;
                break;
            }
        }
        if (bcontinue) continue;

        if (spellInfo->manaCost > GetPower(POWER_MANA))
            continue;
        SpellRangeEntry const* srange = sSpellRangeStore.LookupEntry(spellInfo->rangeIndex);
        float range = SpellMgr::GetSpellMaxRange(srange);
        float minrange = SpellMgr::GetSpellMinRange(srange);

        float dist = GetCombatDistance(pVictim);

        //if(!isInFront(pVictim, range) && spellInfo->AttributesEx)
        //    continue;
        if (dist > range || dist < minrange)
            continue;
        if (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED))
            continue;
        return spellInfo;
    }
    return NULL;
}

SpellEntry const *Creature::reachWithSpellCure(Unit *pVictim)
{
    if (!pVictim)
        return NULL;

    for (uint32 i=0; i < CREATURE_MAX_SPELLS; i++)
    {
        if (!m_spells[i])
            continue;
        SpellEntry const *spellInfo = sSpellStore.LookupEntry(m_spells[i]);
        if (!spellInfo)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: WORLD: unknown spell id %i\n", m_spells[i]);
            continue;
        }

        bool bcontinue = true;
        for (uint32 j=0;j<3;j++)
        {
            if ((spellInfo->Effect[j] == SPELL_EFFECT_HEAL))
            {
                bcontinue = false;
                break;
            }
        }
        if (bcontinue) continue;

        if (spellInfo->manaCost > GetPower(POWER_MANA))
            continue;
        SpellRangeEntry const* srange = sSpellRangeStore.LookupEntry(spellInfo->rangeIndex);
        float range = SpellMgr::GetSpellMaxRange(srange);
        float minrange = SpellMgr::GetSpellMinRange(srange);

        float dist = GetCombatDistance(pVictim);

        //if(!isInFront(pVictim, range) && spellInfo->AttributesEx)
        //    continue;
        if (dist > range || dist < minrange)
            continue;
        if (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED))
            continue;
        return spellInfo;
    }
    return NULL;
}

bool Creature::IsVisibleInGridForPlayer(Player const* pl) const
{
    // gamemaster in GM mode see all, including ghosts
    if (pl->isGameMaster())
        return true;

    // Live player (or with not release body see live creatures or death creatures with corpse disappearing time > 0
    if (pl->isAlive() || pl->GetDeathTimer() > 0)
    {
        if (GetEntry() == VISUAL_WAYPOINT && !pl->isGameMaster())
            return false;
        return isAlive() || m_deathTimer > 0 || m_isDeadByDefault && m_deathState==CORPSE;
    }

    // Dead player see creatures near own corpse
    Corpse *corpse = pl->GetCorpse();
    if (corpse)
    {
        // 20 - aggro distance for same level, 25 - max additional distance if player level less that creature level
        if (corpse->IsWithinDistInMap(this, (20 + 25) * sWorld.getRate(RATE_CREATURE_AGGRO)))
            return true;
    }

    // Dead player see Spirit Healer or Spirit Guide
    if (isSpiritService())
        return true;

    // Dead player can see ghost creatures
    if (GetCreatureInfo()->type_flags & CREATURE_TYPEFLAGS_GHOST)
        return true;

    // and not see any other
    return false;
}

void Creature::DoFleeToGetAssistance()
{
    if (!getVictim())
        return;

    if (HasAuraType(SPELL_AURA_PREVENTS_FLEEING) || hasUnitState(UNIT_STAT_NOT_MOVE) || HasCCAura())
        return;

    float radius = sWorld.getConfig(CONFIG_CREATURE_FAMILY_FLEE_ASSISTANCE_RADIUS);
    if (radius > 0)
    {
        Creature* pCreature = NULL;

        Looking4group::NearestAssistCreatureInCreatureRangeCheck u_check(this, getVictim(), radius);
        Looking4group::ObjectLastSearcher<Creature, Looking4group::NearestAssistCreatureInCreatureRangeCheck> searcher(pCreature, u_check);

        Cell::VisitGridObjects(this, searcher, radius);

        SetNoSearchAssistance(true);
        UpdateSpeed(MOVE_RUN, false);

        if (!pCreature)
            SetFeared(true, getVictim(), sWorld.getConfig(CONFIG_CREATURE_FAMILY_FLEE_DELAY));
        else
            GetMotionMaster()->MoveSeekAssistance(pCreature->GetPositionX(), pCreature->GetPositionY(), pCreature->GetPositionZ());
    }
}

Unit* Creature::SelectNearestTarget(float dist) const
{
    Unit *target = NULL;
    {
        Looking4group::NearestHostileUnitInAttackDistanceCheck u_check(this, dist);
        Looking4group::UnitLastSearcher<Looking4group::NearestHostileUnitInAttackDistanceCheck> searcher(target, u_check);

        Cell::VisitAllObjects(this, searcher, dist);
    }

    return target;
}

void Creature::CallAssistance()
{
    if (!getVictim() || isPet() || isCharmed())
        return;

    if (CreatureGroup *formation = GetFormation())
    {
        formation->MemberAttackStart(this, getVictim());
    }
    else
    {
        if (m_AlreadyCallAssistance)
            return;

        SetNoCallAssistance(true);

        float radius = sWorld.getConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_RADIUS);
        if (radius > 0)
        {
            std::list<Creature*> assistList;
            {
                Looking4group::AnyAssistCreatureInRangeCheck u_check(this, getVictim(), radius);
                Looking4group::ObjectListSearcher<Creature, Looking4group::AnyAssistCreatureInRangeCheck> searcher(assistList, u_check);

                Cell::VisitGridObjects(this, searcher, radius);
            }

            if (!assistList.empty())
            {
                AssistDelayEvent *e = new AssistDelayEvent(getVictimGUID(), *this);
                while (!assistList.empty())
                {
                    // Pushing guids because in delay can happen some creature gets despawned => invalid pointer
                    e->AddAssistant((*assistList.begin())->GetGUID());
                    assistList.pop_front();
                }
                m_Events.AddEvent(e, m_Events.CalculateTime(sWorld.getConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_DELAY)));
            }
        }
    }
}

void Creature::CallForHelp(float fRadius)
{
    if (fRadius <= 0.0f || !getVictim() || isPet() || isCharmed())
        return;

    Looking4group::CallOfHelpCreatureInRangeDo u_do(this, getVictim(), fRadius);
    Looking4group::ObjectWorker<Creature, Looking4group::CallOfHelpCreatureInRangeDo> worker(u_do);

    Cell::VisitGridObjects(this, worker, fRadius);
}

bool Creature::CanAssistTo(const Unit* u, const Unit* enemy, bool checkfaction /*= true*/) const
{
    // is it true?
    if (!HasReactState(REACT_AGGRESSIVE))
        return false;

    // we don't need help from zombies :)
    if (!isAlive())
        return false;

    // skip fighting creature
    if (isInCombat())
        return false;

    // only from same creature faction
    if (checkfaction)
    {
        if (getFaction() != u->getFaction())
            return false;
    }
    else
    {
        if (!IsFriendlyTo(u))
            return false;
    }

    // only free creature
    if (GetCharmerOrOwnerGUID())
        return false;

    // skip non hostile to caster enemy creatures
    if (!IsHostileTo(enemy))
        return false;

    return true;
}

void Creature::SaveRespawnTime()
{
    if (isPet() || !m_DBTableGuid || m_creatureData && !m_creatureData->dbData)
        return;

    if (m_respawnTime > time(NULL))                          // dead (no corpse)
        sObjectMgr.SaveCreatureRespawnTime(m_DBTableGuid,GetInstanceId(),m_respawnTime);
    else if (m_deathTimer > 0)                               // dead (corpse)
        sObjectMgr.SaveCreatureRespawnTime(m_DBTableGuid,GetInstanceId(),time(NULL)+m_respawnDelay+m_deathTimer/1000);
}

bool Creature::IsOutOfThreatArea(Unit* pVictim) const
{
    if (!pVictim)
        return true;

    if (!pVictim->IsInMap(this))
        return true;

    if (!canAttack(pVictim))
        return true;

    if (!pVictim->isInAccessiblePlacefor(this))
        return true;

    if (IsAIEnabled && !AI()->CanAIAttack(pVictim))
        return true;

    if (sMapStore.LookupEntry(GetMapId())->IsDungeon())
        return false;

    uint32 AttackDist = GetAttackDistance(pVictim);

    uint32 distToHome = std::max(AttackDist, sWorld.getConfig(CONFIG_EVADE_HOMEDIST));
    uint32 distToTarget = std::max(AttackDist, sWorld.getConfig(CONFIG_EVADE_TARGETDIST));

    if (!IsWithinDistInMap(&homeLocation, distToHome))
        return true;

    if (!IsWithinDistInMap(pVictim, distToTarget))
        return true;

    if (!pVictim->IsWithinDistInMap(&homeLocation, distToHome))
        return true;

    return  false;
}

CreatureDataAddon const* Creature::GetCreatureAddon() const
{
    if (m_DBTableGuid)
    {
        if (CreatureDataAddon const* addon = ObjectMgr::GetCreatureAddon(m_DBTableGuid))
            return addon;
    }

    // dependent from heroic mode entry
    return ObjectMgr::GetCreatureTemplateAddon(GetCreatureInfo()->Entry);
}

//creature_addon table
bool Creature::LoadCreaturesAddon(bool reload)
{
    CreatureDataAddon const *cainfo = GetCreatureAddon();
    if (!cainfo)
        return false;

    if (cainfo->mount != 0)
        Mount(cainfo->mount);

    if (cainfo->bytes0 != 0)
        SetUInt32Value(UNIT_FIELD_BYTES_0, cainfo->bytes0);

    if (cainfo->bytes1 != 0)
        SetUInt32Value(UNIT_FIELD_BYTES_1, cainfo->bytes1);

    if (cainfo->bytes2 != 0)
        SetUInt32Value(UNIT_FIELD_BYTES_2, cainfo->bytes2);

    if (cainfo->emote != 0)
        SetUInt32Value(UNIT_NPC_EMOTESTATE, cainfo->emote);

    if (cainfo->move_flags != 0)
        SetUnitMovementFlags(cainfo->move_flags);

    //Load Path
    if (cainfo->path_id != 0)
        m_path_id = cainfo->path_id;

    if (cainfo->auras)
    {
        for (CreatureDataAddonAura const* cAura = cainfo->auras; cAura->spell_id; ++cAura)
        {
            SpellEntry const *AdditionalSpellInfo = sSpellStore.LookupEntry(cAura->spell_id);
            if (!AdditionalSpellInfo)
            {
                sLog.outLog(LOG_DB_ERR, "Creature (GUIDLow: %u Entry: %u) has wrong spell %u defined in `auras` field.",GetGUIDLow(),GetEntry(),cAura->spell_id);
                continue;
            }

            // skip already applied aura
            if (HasAura(cAura->spell_id,cAura->effect_idx))
            {
                if (!reload)
                    sLog.outDebug("Creature (GUIDLow: %u Entry: %u) has duplicate aura (spell %u effect %u) in `auras` field.",GetGUIDLow(),GetEntry(),cAura->spell_id,cAura->effect_idx);

                continue;
            }

            Aura* AdditionalAura = CreateAura(AdditionalSpellInfo, cAura->effect_idx, NULL, this, this, 0);
            AddAura(AdditionalAura);
            sLog.outDebug("Spell: %u with Aura %u added to creature (GUIDLow: %u Entry: %u)", cAura->spell_id, AdditionalSpellInfo->EffectApplyAuraName[0],GetGUIDLow(),GetEntry());
        }
    }
    return true;
}

/// Send a message to LocalDefense channel for players opposition team in the zone
void Creature::SendZoneUnderAttackMessage(Player* attacker)
{
    uint32 enemy_team = 0;
    if (attacker->GetBattleGround() && !attacker->GetBattleGround()->isArena())
        enemy_team = attacker->GetBGTeam();
    else
        enemy_team = attacker->GetTeam();

    WorldPacket data(SMSG_ZONE_UNDER_ATTACK,4);
    data << (uint32)GetZoneId();
    sWorld.SendGlobalMessage(&data,NULL,(enemy_team==ALLIANCE ? HORDE : ALLIANCE));
}

void Creature::SetInCombatWithZone()
{
    if (!CanHaveThreatList())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Creature entry %u call SetInCombatWithZone but creature cannot have threat list.", GetEntry());
        return;
    }

    Map* pMap = GetMap();

    if (!pMap->IsDungeon())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Creature entry %u call SetInCombatWithZone for map (id: %u) that isn't an instance.", GetEntry(), pMap->GetId());
        return;
    }

    Map::PlayerList const &PlList = pMap->GetPlayers();

    if (PlList.isEmpty())
        return;

    for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
    {
        if (Player* pPlayer = i->getSource())
        {
            if (pPlayer->isGameMaster())
                continue;

            if (pPlayer->isAlive())
            {
                pPlayer->SetInCombatWith(this);
                AddThreat(pPlayer, 0.0f);
            }
        }
    }
}

void Creature::_AddCreatureSpellCooldown(uint32 spell_id, time_t end_time)
{
    m_CreatureSpellCooldowns[spell_id] = end_time;
}

void Creature::_AddCreatureSchoolLock(uint32 idSchoolMask, time_t end_time)
{
    m_CreatureSchoolLock[idSchoolMask] = end_time;
}

void Creature::_AddCreatureCategoryCooldown(uint32 category, time_t end_time)
{
    m_CreatureCategoryCooldowns[category] = end_time;
}

void Creature::AddCreatureSpellCooldown(uint32 spellid)
{
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellid);
    if (!spellInfo)
        return;

    uint32 cooldown = SpellMgr::GetSpellRecoveryTime(spellInfo);
    uint32 CategoryCooldown = spellInfo->CategoryRecoveryTime;

    if (isPet())
        if (Unit* Owner = GetOwner())
            if (Owner->GetTypeId() == TYPEID_PLAYER)
            {
                Owner->ToPlayer()->ApplySpellMod(spellid, SPELLMOD_COOLDOWN, CategoryCooldown);
                if (CategoryCooldown < 0)
                    CategoryCooldown = 0;
                cooldown = CategoryCooldown;
            }

     if (cooldown)
         _AddCreatureSpellCooldown(spellid, time(NULL) + cooldown/1000);

     if (spellInfo->Category && CategoryCooldown)
         _AddCreatureCategoryCooldown(spellInfo->Category, time(NULL) + CategoryCooldown/1000);
}

bool Creature::HasCategoryCooldown(uint32 spell_id) const
{
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spell_id);
    if (!spellInfo)
        return false;

    CreatureSpellCooldowns::const_iterator itr = m_CreatureCategoryCooldowns.find(spellInfo->Category);
    return(itr != m_CreatureCategoryCooldowns.end() && itr->second > time(NULL));
}

uint32 Creature::GetCreatureSpellCooldownDelay(uint32 spellId) const
{
    CreatureSpellCooldowns::const_iterator itr = m_CreatureSpellCooldowns.find(spellId);
    time_t t = time(nullptr);
    return uint32(itr != m_CreatureSpellCooldowns.end() && itr->second > t ? itr->second - t : 0);
}

bool Creature::HasSpellCooldown(uint32 spell_id) const
{
    CreatureSpellCooldowns::const_iterator itr = m_CreatureSpellCooldowns.find(spell_id);
    return (itr != m_CreatureSpellCooldowns.end() && itr->second > time(NULL)) || HasCategoryCooldown(spell_id);
}

bool Creature::HasSchoolLock(uint32 idSchoolMask)
{
    CreatureSpellCooldowns::const_iterator itr = m_CreatureSchoolLock.find(idSchoolMask);
    time_t t = time(nullptr);
    return uint32(itr != m_CreatureSchoolLock.end() && itr->second > t ? itr->second - t : 0);
}

bool Creature::IsInEvadeMode() const
{
    return /*!i_motionMaster.empty() &&*/ i_motionMaster.GetCurrentMovementGeneratorType() == HOME_MOTION_TYPE;
}

float Creature::GetBaseSpeed() const
{
    if (isPet())
    {
        switch (((Pet*)this)->getPetType())
        {
            case SUMMON_PET:
            case HUNTER_PET:
            {
                return 1.15;  // Blizzlike ;p
            }
            case GUARDIAN_PET:
            case MINI_PET:
            {
                break;
            }
        }
    }
    return m_creatureInfo->speed;
}

bool Creature::HasSpell(uint32 spellID) const
{
    for (uint8 i = 0; i < CREATURE_MAX_SPELLS; ++i)
        if (spellID == m_spells[i])
            return true;

    return false;
}

time_t Creature::GetRespawnTimeEx() const
{
    time_t now = time(NULL);
    if (m_respawnTime > now)                                 // dead (no corpse)
        return m_respawnTime;
    else if (m_deathTimer > 0)                               // dead (corpse)
        return now+m_respawnDelay+m_deathTimer/1000;
    else
        return now;
}

void Creature::GetRespawnCoord(float &x, float &y, float &z, float* ori, float* dist) const
{
    if (m_DBTableGuid)
    {
        if (CreatureData const* data = sObjectMgr.GetCreatureData(GetDBTableGUIDLow()))
        {
            x = data->posX;
            y = data->posY;
            z = data->posZ;
            if (ori)
                *ori = data->orientation;
            if (dist)
                *dist = data->spawndist;
        }
    }
    else
    {
        x = GetPositionX();
        y = GetPositionY();
        z = GetPositionZ();
        if (ori)
            *ori = GetOrientation();
        if (dist)
            *dist = 0;
    }
    //lets check if our creatures have valid spawn coordinates
    //ASSERT(false); crashes server, so ...
    if(!Looking4group::IsValidMapCoord(x, y, z))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Creature with invalid respawn coordinates: mapid = %u, guid = %u, x = %f, y = %f, z = %f", GetMapId(), GetGUIDLow(), x, y, z);
        //ASSERT(false);
    }
}

void Creature::AllLootRemovedFromCorpse()
{
    if (!HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE))
    {
        uint32 nDeathTimer;

        CreatureInfo const *cinfo = GetCreatureInfo();

        // corpse was not skinnable -> apply corpse looted timer
        if (!cinfo || !cinfo->SkinLootId)
            nDeathTimer = (uint32)((m_corpseDelay * 1000) * sWorld.getRate(RATE_CORPSE_DECAY_LOOTED));
        // corpse skinnable, but without skinning flag, and then skinned, corpse will despawn next update
        else
            nDeathTimer = 0;

        // update death timer only if looted timer is shorter
        if (m_deathTimer > nDeathTimer)
            m_deathTimer = nDeathTimer;
    }
}

uint32 Creature::getLevelForTarget(Unit const* target) const
{
    if (!isWorldBoss())
        return Unit::getLevelForTarget(target);

    uint32 level = target->getLevel()+sWorld.getConfig(CONFIG_WORLD_BOSS_LEVEL_DIFF);
    if (level < 1)
        return 1;
    if (level > 255)
        return 255;
    return level;
}

std::string Creature::GetAIName() const
{
    return ObjectMgr::GetCreatureTemplate(GetEntry())->AIName;
}

std::string Creature::GetScriptName()
{
    return sScriptMgr.GetScriptName(GetScriptId());
}

uint32 Creature::GetScriptId()
{
    return ObjectMgr::GetCreatureTemplate(GetEntry())->ScriptID;
}

VendorItemData const* Creature::GetVendorItems() const
{
    return sObjectMgr.GetNpcVendorItemList(GetEntry());
}

uint32 Creature::GetVendorItemCurrentCount(VendorItem const* vItem)
{
    if (!vItem->maxcount)
        return vItem->maxcount;

    VendorItemCounts::iterator itr = m_vendorItemCounts.begin();
    for (; itr != m_vendorItemCounts.end(); ++itr)
        if (itr->itemId==vItem->item)
            break;

    if (itr == m_vendorItemCounts.end())
        return vItem->maxcount;

    VendorItemCount* vCount = &*itr;

    time_t ptime = time(NULL);

    if (vCount->lastIncrementTime + vItem->incrtime <= ptime)
    {
        ItemPrototype const* pProto = ObjectMgr::GetItemPrototype(vItem->item);

        uint32 diff = uint32((ptime - vCount->lastIncrementTime)/vItem->incrtime);
        if ((vCount->count + diff * pProto->BuyCount) >= vItem->maxcount)
        {
            m_vendorItemCounts.erase(itr);
            return vItem->maxcount;
        }

        vCount->count += diff * pProto->BuyCount;
        vCount->lastIncrementTime = ptime;
    }

    return vCount->count;
}

uint32 Creature::UpdateVendorItemCurrentCount(VendorItem const* vItem, uint32 used_count)
{
    if (!vItem->maxcount)
        return 0;

    VendorItemCounts::iterator itr = m_vendorItemCounts.begin();
    for (; itr != m_vendorItemCounts.end(); ++itr)
        if (itr->itemId==vItem->item)
            break;

    if (itr == m_vendorItemCounts.end())
    {
        uint32 new_count = vItem->maxcount > used_count ? vItem->maxcount-used_count : 0;
        m_vendorItemCounts.push_back(VendorItemCount(vItem->item,new_count));
        return new_count;
    }

    VendorItemCount* vCount = &*itr;

    time_t ptime = time(NULL);

    if (vCount->lastIncrementTime + vItem->incrtime <= ptime)
    {
        ItemPrototype const* pProto = ObjectMgr::GetItemPrototype(vItem->item);

        uint32 diff = uint32((ptime - vCount->lastIncrementTime)/vItem->incrtime);
        if ((vCount->count + diff * pProto->BuyCount) < vItem->maxcount)
            vCount->count += diff * pProto->BuyCount;
        else
            vCount->count = vItem->maxcount;
    }

    vCount->count = vCount->count > used_count ? vCount->count-used_count : 0;
    vCount->lastIncrementTime = ptime;
    return vCount->count;
}

TrainerSpellData const* Creature::GetTrainerSpells() const
{
    return sObjectMgr.GetNpcTrainerSpells(GetEntry());
}

// overwrite WorldObject function for proper name localization
const char* Creature::GetNameForLocaleIdx(int32 loc_idx) const
{
    char const* name = GetName();
    sObjectMgr.GetCreatureLocaleStrings(GetEntry(), loc_idx, &name);
    return name;
}

const CreatureData* Creature::GetLinkedRespawnCreatureData() const
{
    if (!m_DBTableGuid) // only hard-spawned creatures from DB can have a linked master
        return NULL;

    if (uint32 targetGuid = sObjectMgr.GetLinkedRespawnGuid(m_DBTableGuid))
        return sObjectMgr.GetCreatureData(targetGuid);

    return NULL;
}

// returns master's remaining respawn time if any
time_t Creature::GetLinkedCreatureRespawnTime() const
{
    if (!m_DBTableGuid) // only hard-spawned creatures from DB can have a linked master
        return 0;

    if (uint32 targetGuid = sObjectMgr.GetLinkedRespawnGuid(m_DBTableGuid))
    {
        Map* targetMap = NULL;
        if (const CreatureData* data = sObjectMgr.GetCreatureData(targetGuid))
        {
            if (data->mapid == GetMapId())   // look up on the same map
                targetMap = GetMap();
            else                            // it shouldn't be instanceable map here
                targetMap = sMapMgr.FindMap(data->mapid);
        }
        if (targetMap)
            return sObjectMgr.GetCreatureRespawnTime(targetGuid,targetMap->GetInstanceId());
    }

    return 0;
}

void Creature::SetWalk(bool enable)
{
    if (enable)
        AddUnitMovementFlag(MOVEFLAG_WALK_MODE);
    else
        RemoveUnitMovementFlag(MOVEFLAG_WALK_MODE);

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_WALK_MODE : SMSG_SPLINE_MOVE_SET_RUN_MODE, 9);
    data << GetPackGUID();
    BroadcastPacket(&data, true);
}

void Creature::SetLevitate(bool enable)
{
    if (enable)
    {
        AddUnitMovementFlag(MOVEFLAG_LEVITATING);
        addUnitState(UNIT_STAT_IGNORE_PATHFINDING);
    }
    else
    {
        RemoveUnitMovementFlag(MOVEFLAG_LEVITATING);
        clearUnitState(UNIT_STAT_IGNORE_PATHFINDING);
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_FLYING : SMSG_SPLINE_MOVE_UNSET_FLYING, 9);
    data << GetPackGUID();
    BroadcastPacket(&data, true);
}

bool Creature::CanReactToPlayerOnTaxi()
{
    // hacky exception for Sunblade Lookout, Shattered Sun Bombardier and Brutallus
    switch (GetEntry())
    {
        case 25132:
        case 25144:
        case 25158:
            return true;
        default:
            return false;
    }
}

bool Creature::CanFly() const
{
    return GetCreatureInfo()->InhabitType & INHABIT_AIR || IsLevitating();
}


bool AttackResumeEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    if (!m_owner.isAlive())
        return true;

    if (m_owner.hasUnitState(UNIT_STAT_CAN_NOT_REACT) || m_owner.HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED))
        return true;

    Unit* victim = m_owner.getVictim();
    if (!victim || !victim->IsInMap(&m_owner))
        return true;

    switch(m_owner.GetObjectGuid().GetHigh())
    {
        case HIGHGUID_UNIT:
        {
            m_owner.AttackStop(/*!b_force*/);
            CreatureAI* ai = m_owner.ToCreature()->AI();
            if (ai)
                ai->AttackStart(victim);
            break;
        }
        case HIGHGUID_PET:
        {
            m_owner.AttackStop(/*!b_force*/);
            m_owner.ToPet()->AI()->AttackStart(victim);
            break;
        }
        case HIGHGUID_PLAYER:
            if (m_owner.IsAIEnabled)
                m_owner.ToPlayer()->AI()->AttackStart(victim);
            break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: AttackResumeEvent::Execute try execute for unsupported owner %s!", m_owner.GetObjectGuid().GetString().c_str());
            break;
    }
    return true;
}

RestoreReactState::RestoreReactState(Creature& owner) : BasicEvent(), _owner(owner)
{
    if (_owner.ToPet())
        return;

    _owner.addUnitState(UNIT_STAT_IGNORE_ATTACKERS);

    _oldState = _owner.GetReactState();
    _owner.SetReactState(REACT_PASSIVE);
}

bool RestoreReactState::Execute(uint64 e_time, uint32 p_time)
{
    if (_owner.ToPet())
        return true;

    _owner.clearUnitState(UNIT_STAT_IGNORE_ATTACKERS);
    _owner.SetReactState(_oldState);
    return true;
}

void Creature::LockSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs)
{
    // Take current time
    time_t curTime = time(NULL);
    uint8 i = 0;
    
    // Add a lock to spell school used that was being casted
    _AddCreatureSchoolLock(idSchoolMask, curTime + unTimeMs / 1000 );

}