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
#include "Log.h"
#include "WorldSession.h"
#include "WorldPacket.h"
#include "ObjectMgr.h"
#include "SpellMgr.h"
#include "Pet.h"
#include "MapManager.h"
#include "Formulas.h"
#include "SpellAuras.h"
#include "CreatureAI.h"
#include "Unit.h"
#include "Util.h"

char const* petTypeSuffix[MAX_PET_TYPE] =
{
    "'s Minion",                                            // SUMMON_PET
    "'s Pet",                                               // HUNTER_PET
    "'s Guardian",                                          // GUARDIAN_PET
    "'s Companion"                                          // MINI_PET
};

uint32 const LevelStartLoyalty[6] =
{
    2000,
    4500,
    7000,
    10000,
    13500,
    17500,
};

Pet::Pet(PetType type) : Creature()
{
    m_isPet = true;
    m_name = "Pet";
    m_petType = type;

    m_loading = false;
    m_removed = false;
    m_happinessTimer = 7500;
    m_loyaltyTimer = 12000;
    m_duration = 0;
    m_bonusdamage = 0;

    m_loyaltyPoints = 0;
    m_TrainingPoints = 0;
    m_resetTalentsCost = 0;
    m_resetTalentsTime = 0;

    m_auraUpdateMask = 0;

    // pets always have a charminfo, even if they are not actually charmed
    InitCharmInfo();

    if (type == MINI_PET || type == POSSESSED_PET)                                    // always passive
        SetReactState(REACT_PASSIVE);
    else if (type == GUARDIAN_PET)                           // always aggressive
        SetReactState(REACT_AGGRESSIVE);

    m_spells.clear();
    m_Auras.clear();
    m_CreatureSpellCooldowns.clear();
    m_CreatureCategoryCooldowns.clear();
    m_autospells.clear();
    m_declinedname = NULL;
    
    focusTimer.Reset(4000);
}

Pet::~Pet()
{
    if (m_uint32Values)                                      // only for fully created Object
    {
        for (PetSpellMap::iterator i = m_spells.begin(); i != m_spells.end(); ++i)
            delete i->second;
        GetMap()->RemoveFromObjMap(GetGUID());
    }

    delete m_declinedname;
}

void Pet::AddToWorld()
{
    ///- Register the pet for guid lookup
    if (!IsInWorld())
    {
        sObjectAccessor.AddPet(this);
        Unit::AddToWorld();
        AIM_Initialize();
    }
}

void Pet::RemoveFromWorld()
{
    ///- Remove the pet from the accessor
    if (IsInWorld())
    {
        Unit::RemoveFromWorld();
        sObjectAccessor.RemovePet(this);
    }
}

bool Pet::LoadPetFromDB(Unit* owner, uint32 petentry, uint32 petnumber, bool current, float x, float y, float z, float ang)
{
    m_loading = true;

    uint32 ownerid = owner->GetGUIDLow();

    QueryResultAutoPtr result;

    if (petnumber)
        // known petnumber entry                  0   1      2      3        4      5    6           7              8        9           10    11    12       13         14       15            16      17              18        19                 20                 21              22
        result = RealmDataDatabase.PQuery("SELECT id, entry, owner, modelid, level, exp, Reactstate, loyaltypoints, loyalty, trainpoint, slot, name, renamed, curhealth, curmana, curhappiness, abdata, TeachSpelldata, savetime, resettalents_cost, resettalents_time, CreatedBySpell, PetType FROM character_pet WHERE owner = '%u' AND id = '%u'",ownerid, petnumber);
    else if (current)
        // current pet (slot 0)                   0   1      2      3        4      5    6           7              8        9           10    11    12       13         14       15            16      17              18        19                 20                 21              22
        result = RealmDataDatabase.PQuery("SELECT id, entry, owner, modelid, level, exp, Reactstate, loyaltypoints, loyalty, trainpoint, slot, name, renamed, curhealth, curmana, curhappiness, abdata, TeachSpelldata, savetime, resettalents_cost, resettalents_time, CreatedBySpell, PetType FROM character_pet WHERE owner = '%u' AND slot = '0'",ownerid);
    else if (petentry)
        // known petentry entry (unique for summoned pet, but non unique for hunter pet (only from current or not stabled pets)
        //                                        0   1      2      3        4      5    6           7              8        9           10    11    12       13         14       15            16      17              18        19                 20                 21              22
        result = RealmDataDatabase.PQuery("SELECT id, entry, owner, modelid, level, exp, Reactstate, loyaltypoints, loyalty, trainpoint, slot, name, renamed, curhealth, curmana, curhappiness, abdata, TeachSpelldata, savetime, resettalents_cost, resettalents_time, CreatedBySpell, PetType FROM character_pet WHERE owner = '%u' AND entry = '%u' AND (slot = '0' OR slot = '3') ",ownerid, petentry);
    else
        // any current or other non-stabled pet (for hunter "call pet")
        //                                        0   1      2      3        4      5    6           7              8        9           10    11    12       13         14       15            16      17              18        19                 20                 21              22
        result = RealmDataDatabase.PQuery("SELECT id, entry, owner, modelid, level, exp, Reactstate, loyaltypoints, loyalty, trainpoint, slot, name, renamed, curhealth, curmana, curhappiness, abdata, TeachSpelldata, savetime, resettalents_cost, resettalents_time, CreatedBySpell, PetType FROM character_pet WHERE owner = '%u' AND (slot = '0' OR slot = '3') ",ownerid);

    if (!result)
        return false;

    Field *fields = result->Fetch();

    // update for case of current pet "slot = 0"
    petentry = fields[1].GetUInt32();
    if (!petentry)
        return false;

    uint32 summon_spell_id = fields[21].GetUInt32();
    SpellEntry const* spellInfo = sSpellStore.LookupEntry(summon_spell_id);

    bool is_temporary_summoned = spellInfo && SpellMgr::GetSpellDuration(spellInfo) > 0;

    // check temporary summoned pets like mage water elemental
    if (current && is_temporary_summoned)
        return false;

    Map *map = owner->GetMap();
    uint32 guid = sObjectMgr.GenerateLowGuid(HIGHGUID_PET);
    uint32 pet_number = fields[0].GetUInt32();
    if (!Create(guid, map, petentry, pet_number))
        return false;

    if (!x || !y)
    {
        owner->GetNearPoint(x, y, z, GetObjectSize(), PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
        ang = owner->GetOrientation();
    }

    Relocate(x, y, z, ang);

    if (!IsPositionValid())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Pet (guidlow %d, entry %d) not loaded. Suggested coordinates isn't valid (X: %f Y: %f)",
            GetGUIDLow(), GetEntry(), GetPositionX(), GetPositionY());
        return false;
    }

    setPetType(PetType(fields[22].GetUInt8()));
    SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE,owner->getFaction());
    SetUInt32Value(UNIT_CREATED_BY_SPELL, summon_spell_id);

    CreatureInfo const *cinfo = GetCreatureInfo();
    if (cinfo->type == CREATURE_TYPE_CRITTER)
    {
        map->Add((Creature*)this);
        return true;
    }

    if (getPetType()==HUNTER_PET || (getPetType()==SUMMON_PET && cinfo->type == CREATURE_TYPE_DEMON && owner->getClass() == CLASS_WARLOCK))
        m_charmInfo->SetPetNumber(pet_number, true);
    else
        m_charmInfo->SetPetNumber(pet_number, false);
    SetOwnerGUID(owner->GetGUID());
    SetDisplayId(fields[3].GetUInt32());
    SetNativeDisplayId(fields[3].GetUInt32());
    uint32 petlevel=fields[4].GetUInt32();
    SetUInt32Value(UNIT_NPC_FLAGS , 0);
    SetName(fields[11].GetString());

    switch (getPetType())
    {

        case SUMMON_PET:
            petlevel=owner->getLevel();

            SetUInt32Value(UNIT_FIELD_BYTES_0,2048);
            SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
                                                            // this enables popup window (pet dismiss, cancel)
            break;
        case HUNTER_PET:
            SetUInt32Value(UNIT_FIELD_BYTES_0, 0x02020100);
            SetByteValue(UNIT_FIELD_BYTES_1, 1, fields[8].GetUInt32());
            SetByteValue(UNIT_FIELD_BYTES_2, 0, SHEATH_STATE_MELEE);
            SetByteValue(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_SANCTUARY | UNIT_BYTE2_FLAG_AURAS);

            if (fields[12].GetBool())
                SetByteValue(UNIT_FIELD_BYTES_2, 2, UNIT_RENAME_NOT_ALLOWED);
            else
                SetByteValue(UNIT_FIELD_BYTES_2, 2, UNIT_RENAME_ALLOWED);

            SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
                                                            // this enables popup window (pet abandon, cancel)
            SetTP(fields[9].GetInt32());
            SetMaxPower(POWER_HAPPINESS,GetCreatePowers(POWER_HAPPINESS));
            SetPower(  POWER_HAPPINESS,fields[15].GetUInt32());
            setPowerType(POWER_FOCUS);
            break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: Pet have incorrect type (%u) for pet loading.",getPetType());
    }
    InitStatsForLevel(petlevel);
    SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, time(NULL));
    SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, fields[5].GetUInt32());
    SetCreatorGUID(owner->GetGUID());

    SetReactState(ReactStates(fields[6].GetUInt8()));
    m_loyaltyPoints = fields[7].GetInt32();

    uint32 savedhealth = fields[13].GetUInt32();
    uint32 savedmana = fields[14].GetUInt32();

    // set current pet as current
    if (fields[10].GetUInt32() != 0)
    {
        RealmDataDatabase.BeginTransaction();
        RealmDataDatabase.PExecute("UPDATE character_pet SET slot = '3' WHERE owner = '%u' AND slot = '0' AND id <> '%u'",ownerid, m_charmInfo->GetPetNumber());
        RealmDataDatabase.PExecute("UPDATE character_pet SET slot = '0' WHERE owner = '%u' AND id = '%u'",ownerid, m_charmInfo->GetPetNumber());
        RealmDataDatabase.CommitTransaction();
    }

    if (!is_temporary_summoned)
    {
        // permanent controlled pets store state in DB
        Tokens tokens = StrSplit(fields[16].GetString(), " ");

        if (tokens.size() != 20)
            return false;

        int index;
        Tokens::iterator iter;
        for (iter = tokens.begin(), index = 0; index < 10; ++iter, ++index)
        {
            m_charmInfo->GetActionBarEntry(index)->Type = atol((*iter).c_str());
            ++iter;
            m_charmInfo->GetActionBarEntry(index)->SpellOrAction = atol((*iter).c_str());

            // patch for old data where some spells have ACT_DECIDE but should have ACT_CAST
            // so overwrite old state
            SpellEntry const *spellInfo = sSpellStore.LookupEntry(m_charmInfo->GetActionBarEntry(index)->SpellOrAction);
            if (spellInfo && spellInfo->AttributesEx & SPELL_ATTR_EX_UNAUTOCASTABLE_BY_PET) m_charmInfo->GetActionBarEntry(index)->Type = ACT_CAST;
        }

        //init teach spells
        tokens = StrSplit(fields[17].GetString(), " ");
        for (iter = tokens.begin(), index = 0; index < 4; ++iter, ++index)
        {
            uint32 tmp = atol((*iter).c_str());

            ++iter;

            if (tmp)
                AddTeachSpell(tmp, atol((*iter).c_str()));
            else
                break;
        }
    }

    // since last save (in seconds)
    uint32 timediff = (time(NULL) - fields[18].GetUInt32());

    //load spells/cooldowns/auras
    SetCanModifyStats(true);
    _LoadAuras(timediff);

    //init AB
    if (is_temporary_summoned)
    {
        // Temporary summoned pets always have initial spell list at load
        InitPetCreateSpells();
    }
    else
    {
        LearnPetPassives();
        CastPetAuras(current);
    }

    if (getPetType() == SUMMON_PET && !current)              //all (?) summon pets come with full health when called, but not when they are current
    {
        SetHealth(GetMaxHealth());
        SetPower(POWER_MANA, GetMaxPower(POWER_MANA));
    }
    else
    {
        if (!savedhealth && getPetType() == HUNTER_PET)
            setDeathState(JUST_DIED);
        else
        {
            SetHealth(savedhealth > GetMaxHealth() ? GetMaxHealth() : (!savedhealth ? 1 : savedhealth));
            SetPower(POWER_MANA, savedmana > GetMaxPower(POWER_MANA) ? GetMaxPower(POWER_MANA) : savedmana);
        }
    }

    map->Add((Creature*)this);

    // Spells should be loaded after pet is added to map, because in CheckCast is check on it
    _LoadSpells();
    _LoadSpellCooldowns();

    owner->SetPet(this);                                    // in DB stored only full controlled creature
    sLog.outDebug("New Pet has guid %u", GetGUIDLow());

    if (owner->GetTypeId() == TYPEID_PLAYER)
    {
        ((Player*)owner)->PetSpellInitialize();
        if (((Player*)owner)->GetGroup())
            ((Player*)owner)->SetGroupUpdateFlag(GROUP_UPDATE_PET);
    }

    if (owner->GetTypeId() == TYPEID_PLAYER && getPetType() == HUNTER_PET)
    {
        result = RealmDataDatabase.PQuery("SELECT genitive, dative, accusative, instrumental, prepositional FROM character_pet_declinedname WHERE owner = '%u' AND id = '%u'", owner->GetGUIDLow(), GetCharmInfo()->GetPetNumber());

        if (result)
        {
            if (m_declinedname)
                delete m_declinedname;

            m_declinedname = new DeclinedName;
            Field *fields2 = result->Fetch();
            for (int i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
            {
                m_declinedname->name[i] = fields2[i].GetCppString();
            }
        }
    }

    //set last used pet number (for use in BG's)
    if (owner->GetTypeId() == TYPEID_PLAYER && isControlled() && !isTemporarySummoned() && (getPetType() == SUMMON_PET || getPetType() == HUNTER_PET))
        owner->ToPlayer()->SetLastPetNumber(pet_number);

    m_loading = false;
    return true;
}

void Pet::SavePetToDB(PetSaveMode mode)
{
    if (!GetEntry())
        return;

    // save only fully controlled creature
    if (!isControlled())
        return;

    uint32 curhealth = GetHealth();
    uint32 curmana = GetPower(POWER_MANA);

    // save auras before possibly removing them
    _SaveAuras();

    switch (mode)
    {
        case PET_SAVE_IN_STABLE_SLOT_1:
        case PET_SAVE_IN_STABLE_SLOT_2:
        case PET_SAVE_NOT_IN_SLOT:
        {
            if (getPetType() != HUNTER_PET || !isAlive())
                RemoveAllAuras();
        }
        default:
            break;
    }

    //save pet's data as one single transaction
    RealmDataDatabase.BeginTransaction();
    _SaveSpells();
    _SaveSpellCooldowns();

    switch (mode)
    {
        case PET_SAVE_AS_CURRENT:
        case PET_SAVE_IN_STABLE_SLOT_1:
        case PET_SAVE_IN_STABLE_SLOT_2:
        case PET_SAVE_NOT_IN_SLOT:
        {
            uint32 loyalty =1;
            if (getPetType()!=HUNTER_PET)
                loyalty = GetLoyaltyLevel();

            uint32 owner = GUID_LOPART(GetOwnerGUID());
            std::string name = m_name;
            RealmDataDatabase.escape_string(name);
            // remove current data
            RealmDataDatabase.PExecute("DELETE FROM character_pet WHERE owner = '%u' AND id = '%u'", owner,m_charmInfo->GetPetNumber());

            // prevent duplicate using slot (except PET_SAVE_NOT_IN_SLOT)
            if (mode!=PET_SAVE_NOT_IN_SLOT)
                RealmDataDatabase.PExecute("UPDATE character_pet SET slot = 3 WHERE owner = '%u' AND slot = '%u'", owner, uint32(mode));

            // prevent existence another hunter pet in PET_SAVE_AS_CURRENT and PET_SAVE_NOT_IN_SLOT
            if (getPetType()==HUNTER_PET && (mode==PET_SAVE_AS_CURRENT||mode==PET_SAVE_NOT_IN_SLOT))
                RealmDataDatabase.PExecute("DELETE FROM character_pet WHERE owner = '%u' AND (slot = '0' OR slot = '3')", owner);
            // save pet
            std::ostringstream ss;
            ss  << "INSERT INTO character_pet (id, entry,  owner, modelid, level, exp, Reactstate, loyaltypoints, loyalty, trainpoint, slot, name, renamed, curhealth, curmana, curhappiness, abdata,TeachSpelldata,savetime,resettalents_cost,resettalents_time,CreatedBySpell,PetType) "
                << "VALUES ("
                << m_charmInfo->GetPetNumber() << ", "
                << GetEntry() << ", "
                << owner << ", "
                << GetNativeDisplayId() << ", "
                << getLevel() << ", "
                << GetUInt32Value(UNIT_FIELD_PETEXPERIENCE) << ", "
                << uint32(GetReactState()) << ", "
                << m_loyaltyPoints << ", "
                << GetLoyaltyLevel() << ", "
                << m_TrainingPoints << ", "
                << uint32(mode) << ", '"
                << name.c_str() << "', "
                << uint32((GetByteValue(UNIT_FIELD_BYTES_2, 2) == UNIT_RENAME_ALLOWED)?0:1) << ", "
                << curhealth << ", "
                << curmana << ", "
                << GetPower(POWER_HAPPINESS) << ", '";

            for (uint32 i = 0; i < 10; i++)
                ss << uint32(m_charmInfo->GetActionBarEntry(i)->Type) << " " << uint32(m_charmInfo->GetActionBarEntry(i)->SpellOrAction) << " ";
            ss << "', '";

            //save spells the pet can teach to it's Master
            {
                int i = 0;
                for (TeachSpellMap::iterator itr = m_teachspells.begin(); i < 4 && itr != m_teachspells.end(); ++i, ++itr)
                    ss << itr->first << " " << itr->second << " ";
                for (; i < 4; ++i)
                    ss << uint32(0) << " " << uint32(0) << " ";
            }

            ss  << "', "
                << time(NULL) << ", "
                << uint32(m_resetTalentsCost) << ", "
                << uint64(m_resetTalentsTime) << ", "
                << GetUInt32Value(UNIT_CREATED_BY_SPELL) << ", "
                << uint32(getPetType()) << ")";

            RealmDataDatabase.Execute(ss.str().c_str());
            break;
        }
        case PET_SAVE_AS_DELETED:
        {
            RemoveAllAuras();
            DeleteFromDB(m_charmInfo->GetPetNumber(), false);
            break;
        }
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: Unknown pet save/remove mode: %d",mode);
    }
    RealmDataDatabase.CommitTransaction();
}

void Pet::DeleteFromDB(uint32 guidlow, bool separate_transaction)
{
    if (separate_transaction)
        RealmDataDatabase.BeginTransaction();

    RealmDataDatabase.PExecute("DELETE FROM character_pet WHERE id = '%u'", guidlow);
    RealmDataDatabase.PExecute("DELETE FROM character_pet_declinedname WHERE id = '%u'", guidlow);
    RealmDataDatabase.PExecute("DELETE FROM pet_aura WHERE guid = '%u'", guidlow);
    RealmDataDatabase.PExecute("DELETE FROM pet_spell WHERE guid = '%u'", guidlow);
    RealmDataDatabase.PExecute("DELETE FROM pet_spell_cooldown WHERE guid = '%u'", guidlow);

    if (separate_transaction)
        RealmDataDatabase.CommitTransaction();
}

void Pet::setDeathState(DeathState s)                       // overwrite virtual Creature::setDeathState and Unit::setDeathState
{
    Creature::setDeathState(s);
    if (getDeathState()==CORPSE)
    {
        //remove summoned pet (no corpse)
        if (getPetType()==SUMMON_PET)
            Remove(PET_SAVE_NOT_IN_SLOT);
        // other will despawn at corpse desppawning (Pet::Update code)
        else
        {
            // pet corpse non lootable and non skinnable
            SetUInt32Value(UNIT_DYNAMIC_FLAGS, 0x00);
            RemoveFlag (UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE);

             //lose happiness when died and not in BG/Arena
            MapEntry const* mapEntry = sMapStore.LookupEntry(GetMapId());
            if (!mapEntry || (mapEntry->map_type != MAP_ARENA && mapEntry->map_type != MAP_BATTLEGROUND))
                ModifyPower(POWER_HAPPINESS, -HAPPINESS_LEVEL_SIZE);

            SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_ROTATE);
        }
    }
    else if (getDeathState()==ALIVE)
    {
        RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_ROTATE);
        CastPetAuras(true);
    }
}

void Pet::Update(uint32 update_diff, uint32 p_diff)
{
    if (m_removed || m_loading)                                           // pet already removed, just wait in remove queue, no updates
        return;

    switch (m_deathState)
    {
        case CORPSE:
        {
            if (m_deathTimer <= update_diff)
            {
                ASSERT(getPetType()!=SUMMON_PET && "Must be already removed.");
                Remove(PET_SAVE_NOT_IN_SLOT);               //hunters' pets never get removed because of death, NEVER!
                return;
            }
            break;
        }
        case ALIVE:
        {
            // unsummon pet that lost owner
            Unit* owner = GetOwner();
            if (!owner || (!IsWithinDistInMap(owner, GetMap()->GetVisibilityDistance()) && !isPossessed()) || isControlled() && !owner->GetPetGUID())
            {
                Remove(PET_SAVE_NOT_IN_SLOT, true);
                return;
            }

            if (isControlled())
            {
                if (owner->GetPetGUID() != GetGUID())
                {
                    Remove(getPetType()==HUNTER_PET?PET_SAVE_AS_DELETED:PET_SAVE_NOT_IN_SLOT);
                    return;
                }
            }

            if (m_duration > 0)
            {
                if (m_duration > update_diff)
                    m_duration -= update_diff;
                else
                {
                    Remove(getPetType() != SUMMON_PET ? PET_SAVE_AS_DELETED:PET_SAVE_NOT_IN_SLOT);
                    return;
                }
            }

            if (getPetType() == SUMMON_PET && owner->getClass() == CLASS_WARLOCK)
            {
                for (PetAuraSet::iterator i = owner->m_petAuras.begin(); i != owner->m_petAuras.end(); i++)
                {
                    if ((*i)->GetAura(GetEntry()) == 35696)
                    {
                        CastPetAura(*i);
                        break;
                    }
                }
            }

            if (getPetType() != HUNTER_PET)
                break;

            //regenerate Focus
            focusTimer.Update(update_diff);
            if (focusTimer.Passed())
            {
                RegenerateFocus();
                focusTimer.Reset(4000);
            }

            if (m_happinessTimer <= update_diff)
            {
                LooseHappiness();
                m_happinessTimer = 7500;
            }
            else
                m_happinessTimer -= update_diff;

            if (m_loyaltyTimer <= update_diff)
            {
                TickLoyaltyChange();
                m_loyaltyTimer = 12000;
            }
            else
                m_loyaltyTimer -= update_diff;

            break;
        }
        default:
            break;
    }
    Creature::Update(update_diff, p_diff);
}

void Pet::RegenerateFocus()
{
    uint32 curValue = GetPower(POWER_FOCUS);
    uint32 maxValue = GetMaxPower(POWER_FOCUS);

    if (curValue >= maxValue)
        return;

    float addvalue = 24 * sWorld.getRate(RATE_POWER_FOCUS);

    AuraList const& ModPowerRegenPCTAuras = GetAurasByType(SPELL_AURA_MOD_POWER_REGEN_PERCENT);
    for (AuraList::const_iterator i = ModPowerRegenPCTAuras.begin(); i != ModPowerRegenPCTAuras.end(); ++i)
        if ((*i)->GetModifier()->m_miscvalue == POWER_FOCUS)
            addvalue *= ((*i)->GetModifierValue() + 100) / 100.0f;

    ModifyPower(POWER_FOCUS, (int32)addvalue);
}

void Pet::LooseHappiness()
{
    uint32 curValue = GetPower(POWER_HAPPINESS);
    if (curValue <= 0)
        return;
    int32 addvalue = (140 >> GetLoyaltyLevel()) * 125;      //value is 70/35/17/8/4 (per min) * 1000 / 8 (timer 7.5 secs)
    if (isInCombat())                                        //we know in combat happiness fades faster, multiplier guess
        addvalue = int32(addvalue * 1.5);
    ModifyPower(POWER_HAPPINESS, -addvalue);
}

void Pet::ModifyLoyalty(int32 addvalue)
{
    uint32 loyaltylevel = GetLoyaltyLevel();

    if (addvalue > 0)                                        //only gain influenced, not loss
        addvalue = int32((float)addvalue * sWorld.getRate(RATE_LOYALTY));

    if (loyaltylevel >= BEST_FRIEND && (addvalue + m_loyaltyPoints) > int32(GetMaxLoyaltyPoints(loyaltylevel)))
        return;

    m_loyaltyPoints += addvalue;

    if (m_loyaltyPoints < 0)
    {
        if (loyaltylevel > REBELLIOUS)
        {
            //level down
            --loyaltylevel;
            SetLoyaltyLevel(LoyaltyLevel(loyaltylevel));
            m_loyaltyPoints = GetStartLoyaltyPoints(loyaltylevel);
            SetTP(m_TrainingPoints - int32(getLevel()));
        }
        else
        {
            m_loyaltyPoints = 0;
            Unit* owner = GetOwner();
            if (owner && owner->GetTypeId() == TYPEID_PLAYER)
            {
                WorldPacket data(SMSG_PET_BROKEN, 0);
                ((Player*)owner)->SendPacketToSelf(&data);

                //run away
                ((Player*)owner)->RemovePet(this,PET_SAVE_AS_DELETED);
            }
        }
    }
    //level up
    else if (m_loyaltyPoints > int32(GetMaxLoyaltyPoints(loyaltylevel)))
    {
        ++loyaltylevel;
        SetLoyaltyLevel(LoyaltyLevel(loyaltylevel));
        m_loyaltyPoints = GetStartLoyaltyPoints(loyaltylevel);
        SetTP(m_TrainingPoints + getLevel());
    }
}

void Pet::TickLoyaltyChange()
{
    int32 addvalue;

    switch (GetHappinessState())
    {
        case HAPPY:   addvalue =  20; break;
        case CONTENT: addvalue =  10; break;
        case UNHAPPY: addvalue = -20; break;
        default:
            return;
    }
    ModifyLoyalty(addvalue);
}

void Pet::KillLoyaltyBonus(uint32 level)
{
    if (level > 100)
        return;

                                                            //at lower levels gain is faster | the lower loyalty the more loyalty is gained
    uint32 bonus = uint32(((100 - level) / 10) + (6 - GetLoyaltyLevel()));
    ModifyLoyalty(bonus);
}

HappinessState Pet::GetHappinessState()
{
    if (GetPower(POWER_HAPPINESS) < HAPPINESS_LEVEL_SIZE)
        return UNHAPPY;
    else if (GetPower(POWER_HAPPINESS) >= HAPPINESS_LEVEL_SIZE * 2)
        return HAPPY;
    else
        return CONTENT;
}

void Pet::SetLoyaltyLevel(LoyaltyLevel level)
{
    SetByteValue(UNIT_FIELD_BYTES_1, 1, level);
}

bool Pet::CanTakeMoreActiveSpells(uint32 spellid)
{
    uint8  activecount = 1;
    uint32 chainstartstore[ACTIVE_SPELLS_MAX];

    if (SpellMgr::IsPassiveSpell(spellid))
        return true;

    chainstartstore[0] = sSpellMgr.GetFirstSpellInChain(spellid);

    for (PetSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        if (SpellMgr::IsPassiveSpell(itr->first))
            continue;

        uint32 chainstart = sSpellMgr.GetFirstSpellInChain(itr->first);

        uint8 x;

        for (x = 0; x < activecount; x++)
        {
            if (chainstart == chainstartstore[x])
                break;
        }

        if (x == activecount)                                //spellchain not yet saved -> add active count
        {
            ++activecount;
            if (activecount > ACTIVE_SPELLS_MAX)
                return false;
            chainstartstore[x] = chainstart;
        }
    }
    return true;
}

bool Pet::HasTPForSpell(uint32 spellid)
{
    int32 neededtrainp = GetTPForSpell(spellid);
    if ((m_TrainingPoints - neededtrainp < 0 || neededtrainp < 0) && neededtrainp != 0)
        return false;
    return true;
}

int32 Pet::GetTPForSpell(uint32 spellid)
{
    uint32 basetrainp = 0;

    SkillLineAbilityMap::const_iterator lower = sSpellMgr.GetBeginSkillLineAbilityMap(spellid);
    SkillLineAbilityMap::const_iterator upper = sSpellMgr.GetEndSkillLineAbilityMap(spellid);
    for (SkillLineAbilityMap::const_iterator _spell_idx = lower; _spell_idx != upper; ++_spell_idx)
    {
        if (!_spell_idx->second->reqtrainpoints)
            return 0;

        basetrainp = _spell_idx->second->reqtrainpoints;
        break;
    }

    uint32 spenttrainp = 0;
    uint32 chainstart = sSpellMgr.GetFirstSpellInChain(spellid);

    for (PetSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        if (itr->second->state == PETSPELL_REMOVED)
            continue;

        if (sSpellMgr.GetFirstSpellInChain(itr->first) == chainstart)
        {
            SkillLineAbilityMap::const_iterator _lower = sSpellMgr.GetBeginSkillLineAbilityMap(itr->first);
            SkillLineAbilityMap::const_iterator _upper = sSpellMgr.GetEndSkillLineAbilityMap(itr->first);

            for (SkillLineAbilityMap::const_iterator _spell_idx2 = _lower; _spell_idx2 != _upper; ++_spell_idx2)
            {
                if (_spell_idx2->second->reqtrainpoints > spenttrainp)
                {
                    spenttrainp = _spell_idx2->second->reqtrainpoints;
                    break;
                }
            }
        }
    }

    return int32(basetrainp) - int32(spenttrainp);
}

uint32 Pet::GetMaxLoyaltyPoints(uint32 level)
{
    //numbers represent minutes * 100 while happy (you get 100 loyalty points per min while happy)
    const uint32 LevelUpLoyalty[6] =
    {
        5500,
        11500,
        17000,
        23500,
        31000,
        39500,
    };

    if (level -1 > 5)
        return LevelUpLoyalty[5];

    return LevelUpLoyalty[level - 1];
}

uint32 Pet::GetStartLoyaltyPoints(uint32 level)
{
    return LevelStartLoyalty[level - 1];
}

void Pet::SetTP(int32 TP)
{
    m_TrainingPoints = TP;
    SetUInt32Value(UNIT_TRAINING_POINTS, (uint32)GetDispTP());
}

int32 Pet::GetDispTP()
{
    if (getPetType()!= HUNTER_PET)
        return(0);
    if (m_TrainingPoints < 0)
        return -m_TrainingPoints;
    else
        return -(m_TrainingPoints + 1);
}

void Pet::Remove(PetSaveMode mode, bool returnreagent)
{
    Unit* owner = GetOwner();

    if (owner)
    {
        if (owner->GetTypeId()==TYPEID_PLAYER)
        {
            ((Player*)owner)->RemovePet(this,mode,returnreagent);
            return;
        }

        // only if current pet in slot
        if (owner->GetPetGUID()==GetGUID())
            owner->SetPet(0);
    }

    AddObjectToRemoveList();
    m_removed = true;
}

void Pet::GivePetXP(uint32 xp)
{
    if (getPetType() != HUNTER_PET)
        return;

    if (xp < 1)
        return;

    if (!isAlive())
        return;

    uint32 level = getLevel();

    // XP to money conversion processed in Player::RewardQuest
    if (level >= sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
        return;

    uint32 curXP = GetUInt32Value(UNIT_FIELD_PETEXPERIENCE);
    uint32 nextLvlXP = GetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP);
    uint32 newXP = curXP + xp;

    if (newXP >= nextLvlXP && level+1 > GetOwner()->getLevel())
    {
        SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, nextLvlXP-1);
        return;
    }

    while (newXP >= nextLvlXP && level < sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
    {
        newXP -= nextLvlXP;

        SetLevel(level + 1);
        SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, uint32((Looking4group::XP::xp_to_level(level+1))/4));

        level = getLevel();
        nextLvlXP = GetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP);
        GivePetLevel(level);
    }

    SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, newXP);

    if (getPetType() == HUNTER_PET)
        KillLoyaltyBonus(level);
}

void Pet::GivePetLevel(uint32 level)
{
    if (!level)
        return;

    InitStatsForLevel(level);

    SetTP(m_TrainingPoints + (GetLoyaltyLevel() - 1));
}

bool Pet::CreateBaseAtCreature(Creature* creature)
{
    if (!creature)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: CRITICAL ERROR: NULL pointer parsed into CreateBaseAtCreature()");
        return false;
    }
    uint32 guid=sObjectMgr.GenerateLowGuid(HIGHGUID_PET);

    sLog.outDebug("SetInstanceID()");
    SetInstanceId(creature->GetInstanceId());

    sLog.outDebug("Create pet");
    uint32 pet_number = sObjectMgr.GeneratePetNumber();
    if (!Create(guid, creature->GetMap(), creature->GetEntry(), pet_number))
        return false;

    Relocate(creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), creature->GetOrientation());

    if (!IsPositionValid())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Pet (guidlow %d, entry %d) not created base at creature. Suggested coordinates isn't valid (X: %f Y: %f)",
            GetGUIDLow(), GetEntry(), GetPositionX(), GetPositionY());
        return false;
    }

    CreatureInfo const *cinfo = GetCreatureInfo();
    if (!cinfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: CreateBaseAtCreature() failed, creatureInfo is missing!");
        return false;
    }

    if (cinfo->type == CREATURE_TYPE_CRITTER)
    {
        setPetType(MINI_PET);
        return true;
    }
    SetDisplayId(creature->GetDisplayId());
    SetNativeDisplayId(creature->GetNativeDisplayId());
    SetMaxPower(POWER_HAPPINESS, GetCreatePowers(POWER_HAPPINESS));
    SetPower(POWER_HAPPINESS, 166500);
    setPowerType(POWER_FOCUS);
    SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, 0);
    SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, 0);
    SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, uint32((Looking4group::XP::xp_to_level(creature->getLevel()))/4));
    SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
    SetUInt32Value(UNIT_NPC_FLAGS, 0);

    CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(creature->GetCreatureInfo()->family);
    if (char* familyname = cFamily->Name[sWorld.GetDefaultDbcLocale()])
        SetName(familyname);
    else
        SetName(creature->GetName());

    m_loyaltyPoints = 1000;
    if (cinfo->type == CREATURE_TYPE_BEAST)
    {
        SetUInt32Value(UNIT_FIELD_BYTES_0, 0x02020100);
        SetByteValue(UNIT_FIELD_BYTES_2, 0, SHEATH_STATE_MELEE);
        SetByteValue(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_SANCTUARY | UNIT_BYTE2_FLAG_AURAS | UNIT_BYTE2_FLAG_UNK5);
        SetByteValue(UNIT_FIELD_BYTES_2, 2, UNIT_RENAME_ALLOWED);

        SetUInt32Value(UNIT_MOD_CAST_SPEED, creature->GetUInt32Value(UNIT_MOD_CAST_SPEED));
        SetLoyaltyLevel(REBELLIOUS);
    }
    return true;
}

bool Pet::InitStatsForLevel(uint32 petlevel)
{
    CreatureInfo const *cinfo = GetCreatureInfo();
    ASSERT(cinfo);

    Unit* owner = GetOwner();
    if (!owner)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: attempt to summon pet (Entry %u) without owner! Attempt terminated.", cinfo->Entry);
        return false;
    }

    uint32 creature_ID = (getPetType() == HUNTER_PET) ? 1 : cinfo->Entry;

    SetLevel(petlevel);

    SetMeleeDamageSchool(SpellSchools(cinfo->dmgschool));

    SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, float(petlevel*50));

    SetAttackTime(BASE_ATTACK, BASE_ATTACK_TIME);
    SetAttackTime(OFF_ATTACK, BASE_ATTACK_TIME);
    SetAttackTime(RANGED_ATTACK, BASE_ATTACK_TIME);

    SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0);

    CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(cinfo->family);
    if (cFamily && cFamily->minScale > 0.0f && getPetType()==HUNTER_PET)
    {
        float scale;
        if (getLevel() >= cFamily->maxScaleLevel)
            scale = cFamily->maxScale;
        else if (getLevel() <= cFamily->minScaleLevel)
            scale = cFamily->minScale;
        else
          scale = cFamily->minScale + float(getLevel() - cFamily->minScaleLevel) / (float)cFamily->maxScaleLevel * (cFamily->maxScale - cFamily->minScale);

        SetFloatValue(OBJECT_FIELD_SCALE_X, scale);
    }
    m_bonusdamage = 0;

    int32 createResistance[MAX_SPELL_SCHOOL] = {0,0,0,0,0,0,0};

    if (cinfo && getPetType() != HUNTER_PET)
    {
        createResistance[SPELL_SCHOOL_HOLY]   = cinfo->resistance1;
        createResistance[SPELL_SCHOOL_FIRE]   = cinfo->resistance2;
        createResistance[SPELL_SCHOOL_NATURE] = cinfo->resistance3;
        createResistance[SPELL_SCHOOL_FROST]  = cinfo->resistance4;
        createResistance[SPELL_SCHOOL_SHADOW] = cinfo->resistance5;
        createResistance[SPELL_SCHOOL_ARCANE] = cinfo->resistance6;
    }

    switch (getPetType())
    {
        case SUMMON_PET:
        {
            if (owner->GetTypeId() == TYPEID_PLAYER)
            {
                switch (owner->getClass())
                {
                    case CLASS_WARLOCK:
                    {

                        //the damage bonus used for pets is either fire or shadow damage, whatever is higher
                        uint32 fire  = owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_FIRE);
                        uint32 shadow = owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_SHADOW);
                        uint32 val  = (fire > shadow) ? fire : shadow;

                        SetBonusDamage(int32 (val * 0.15f));
                        //bonusAP += val * 0.57;
                        break;
                    }
                    case CLASS_MAGE:
                    {
                                                            //40% damage bonus of mage's frost damage
                        float val = owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_FROST) * 0.4;
                        if (val < 0)
                            val = 0;
                        SetBonusDamage(int32(val));
                        break;
                    }
                    default:
                        break;
                }
            }

            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - (petlevel / 4)));
            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel + (petlevel / 4)));

            //SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, float(cinfo->attackpower));

            PetLevelInfo const* pInfo = sObjectMgr.GetPetLevelInfo(creature_ID, petlevel);
            if (pInfo)                                       // exist in DB
            {
                SetCreateHealth(pInfo->health);
                SetCreateMana(pInfo->mana);

                if (pInfo->armor > 0)
                    SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, float(pInfo->armor));

                for (int stat = 0; stat < MAX_STATS; ++stat)
                {
                    SetCreateStat(Stats(stat), float(pInfo->stats[stat]));
                }
            }
            else                                            // not exist in DB, use some default fake data
            {
                sLog.outLog(LOG_DB_ERR, "Summoned pet (Entry: %u) not have pet stats data in DB",cinfo->Entry);

                // remove elite bonuses included in DB values
                SetCreateHealth(uint32(((float(cinfo->maxhealth) / cinfo->maxlevel) / (1 + 2 * cinfo->rank)) * petlevel));
                SetCreateMana( uint32(((float(cinfo->maxmana)   / cinfo->maxlevel) / (1 + 2 * cinfo->rank)) * petlevel));

                SetCreateStat(STAT_STRENGTH, 22);
                SetCreateStat(STAT_AGILITY, 22);
                SetCreateStat(STAT_STAMINA, 25);
                SetCreateStat(STAT_INTELLECT, 28);
                SetCreateStat(STAT_SPIRIT, 27);
            }
            break;
        }
        case HUNTER_PET:
        {
            SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, uint32((Looking4group::XP::xp_to_level(petlevel))/4));

            //these formula may not be correct; however, it is designed to be close to what it should be
            //this makes dps 0.5 of pets level
            SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - (petlevel / 4)));
            //damage range is then petlevel / 2
            SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel + (petlevel / 4)));
            //damage is increased afterwards as strength and pet scaling modify attack power

            //stored standard pet stats are entry 1 in pet_levelinfo
            PetLevelInfo const* pInfo = sObjectMgr.GetPetLevelInfo(creature_ID, petlevel);
            if (pInfo)                                       // exist in DB
            {
                SetCreateHealth(pInfo->health);
                SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, float(pInfo->armor));
                //SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, float(cinfo->attackpower));

                for (int i = STAT_STRENGTH; i < MAX_STATS; i++)
                {
                    SetCreateStat(Stats(i),  float(pInfo->stats[i]));
                }
            }
            else                                            // not exist in DB, use some default fake data
            {
                sLog.outLog(LOG_DB_ERR, "Hunter pet levelstats missing in DB");

                // remove elite bonuses included in DB values
                SetCreateHealth(uint32(((float(cinfo->maxhealth) / cinfo->maxlevel) / (1 + 2 * cinfo->rank)) * petlevel));

                SetCreateStat(STAT_STRENGTH, 22);
                SetCreateStat(STAT_AGILITY, 22);
                SetCreateStat(STAT_STAMINA, 25);
                SetCreateStat(STAT_INTELLECT, 28);
                SetCreateStat(STAT_SPIRIT, 27);
            }
            break;
        }
        case GUARDIAN_PET:
            SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, 0);
            SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, 1000);

            switch (GetEntry())
            {
                case 1964: //force of nature
                    SetCreateHealth(30 + 30*petlevel);
                    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel * 2.5f - (petlevel / 2)));
                    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel * 2.5f + (petlevel / 2)));
                    break;
                case 15352: //earth elemental 36213
                    SetCreateHealth(100 + 120*petlevel);
                    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - (petlevel / 4)));
                    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel + (petlevel / 4)));
                    ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
                    break;
                case 15438: //fire elemental
                    SetCreateHealth(40*petlevel);
                    SetCreateMana(28 + 10*petlevel);
                    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel * 4 - petlevel));
                    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel * 4 + petlevel));
                    ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
                    break;
                case 17503: //Woeful Healer
                    SetCreateMana(100000);  //arbitrary
                    SetCreateHealth(28 + 30*petlevel);
                    break;
                case 19833: //Snake Trap - Venomous Snake
                    SetCreateHealth(uint32(107 * (petlevel - 40) * 0.025f));
                    SetCreateMana(0);
                    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float((petlevel / 2) - 25));
                    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float((petlevel / 2) - 18));
                    break;
                case 19921: //Snake Trap - Viper
                    SetCreateHealth(uint32(107 * (petlevel - 40) * 0.025f));
                    SetCreateMana(0);
                    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel / 2 - 10));
                    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel / 2));
                    break;
                default:
                    SetCreateMana(28 + 10*petlevel);
                    SetCreateHealth(28 + 30*petlevel);

                    // FIXME: this is wrong formula, possible each guardian pet have own damage formula
                    //these formula may not be correct; however, it is designed to be close to what it should be
                    //this makes dps 0.5 of pets level
                    SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - (petlevel / 4)));
                    //damage range is then petlevel / 2
                    SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel + (petlevel / 4)));
                    break;
            }
            break;
        default:
            SetCreateHealth(urand(cinfo->minhealth, cinfo->maxhealth));
            SetCreateMana(urand(cinfo->minmana, cinfo->maxmana));
            //sLog.outLog(LOG_DEFAULT, "ERROR: Pet have incorrect type (%u) for levelup.", getPetType());
            break;
    }

    for (int i = SPELL_SCHOOL_HOLY; i < MAX_SPELL_SCHOOL; ++i)
        SetModifierValue(UnitMods(UNIT_MOD_RESISTANCE_START + i), BASE_VALUE, float(createResistance[i]));

    UpdateAllStats();
    UpdateSpeed(MOVE_RUN, true);

    SetHealth(GetMaxHealth());
    SetPower(POWER_MANA, GetMaxPower(POWER_MANA));

    return true;
}

bool Pet::HaveInDiet(ItemPrototype const* item) const
{
    if (!item || !item->FoodType)
        return false;

    CreatureInfo const* cInfo = GetCreatureInfo();
    if (!cInfo)
        return false;

    CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(cInfo->family);
    if (!cFamily)
        return false;

    uint32 diet = cFamily->petFoodMask;
    uint32 FoodMask = 1 << (item->FoodType-1);
    return diet & FoodMask;
}

uint32 Pet::GetCurrentFoodBenefitLevel(uint32 itemlevel)
{
    // -5 or greater food level
    if (getLevel() <= itemlevel + 5)                         //possible to feed level 60 pet with level 55 level food for full effect
        return 35000;
    // -10..-6
    else if (getLevel() <= itemlevel + 10)                   //pure guess, but sounds good
        return 17000;
    // -14..-11
    else if (getLevel() <= itemlevel + 14)                   //level 55 food gets green on 70, makes sense to me
        return 8000;
    // -15 or less
    else
        return 0;                                           //food too low level
}

void Pet::_LoadSpellCooldowns()
{
    m_CreatureSpellCooldowns.clear();
    m_CreatureCategoryCooldowns.clear();

    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT spell,time FROM pet_spell_cooldown WHERE guid = '%u'",m_charmInfo->GetPetNumber());

    if (result)
    {
        time_t curTime = time(NULL);

        WorldPacket data(SMSG_SPELL_COOLDOWN, (8+1+result->GetRowCount()*8));
        data << GetGUID();
        data << uint8(0x0);                                 // flags (0x1, 0x2)

        do
        {
            Field *fields = result->Fetch();

            uint32 spell_id = fields[0].GetUInt32();
            time_t db_time  = (time_t)fields[1].GetUInt64();

            if (!sSpellStore.LookupEntry(spell_id))
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Pet %u have unknown spell %u in `pet_spell_cooldown`, skipping.",m_charmInfo->GetPetNumber(),spell_id);
                continue;
            }

            // skip outdated cooldown
            if (db_time <= curTime)
                continue;

            data << uint32(spell_id);
            data << uint32(uint32(db_time-curTime)*1000);   // in m.secs

            _AddCreatureSpellCooldown(spell_id,db_time);

            sLog.outDebug("Pet (Number: %u) spell %u cooldown loaded (%u secs).", m_charmInfo->GetPetNumber(), spell_id, uint32(db_time-curTime));
        }
        while (result->NextRow());

        if (!m_CreatureSpellCooldowns.empty() && GetOwner())
        {
            if (GetOwner()->GetTypeId() == TYPEID_PLAYER)
                ((Player*)GetOwner())->SendPacketToSelf(&data);
        }
    }
}

void Pet::_SaveSpellCooldowns()
{
    if (getPetType() == SUMMON_PET) //don't save cooldowns for temp pets, thats senseless
        return;

    RealmDataDatabase.PExecute("DELETE FROM pet_spell_cooldown WHERE guid = '%u'", m_charmInfo->GetPetNumber());

    time_t curTime = time(NULL);

    // remove oudated and save active
    for (CreatureSpellCooldowns::iterator itr = m_CreatureSpellCooldowns.begin();itr != m_CreatureSpellCooldowns.end();)
    {
        if (itr->second <= curTime)
            m_CreatureSpellCooldowns.erase(itr++);
        else
        {
            RealmDataDatabase.PExecute("INSERT INTO pet_spell_cooldown (guid,spell,time) VALUES ('%u', '%u', '" UI64FMTD "')", m_charmInfo->GetPetNumber(), itr->first, uint64(itr->second));
            ++itr;
        }
    }
}

void Pet::_LoadSpells()
{
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT spell,slot,active FROM pet_spell WHERE guid = '%u'",m_charmInfo->GetPetNumber());

    if (result)
    {
        do
        {
            Field *fields = result->Fetch();

            addSpell(fields[0].GetUInt16(), fields[2].GetUInt16(), PETSPELL_UNCHANGED, fields[1].GetUInt16());
        }
        while (result->NextRow());
    }
}

void Pet::_SaveSpells()
{
    for (PetSpellMap::const_iterator itr = m_spells.begin(), next = m_spells.begin(); itr != m_spells.end(); itr = next)
    {
        ++next;
        if (itr->second->type == PETSPELL_FAMILY) continue; // prevent saving family passives to DB
        if (itr->second->state == PETSPELL_REMOVED || itr->second->state == PETSPELL_CHANGED)
            RealmDataDatabase.PExecute("DELETE FROM pet_spell WHERE guid = '%u' and spell = '%u'", m_charmInfo->GetPetNumber(), itr->first);
        if (itr->second->state == PETSPELL_NEW || itr->second->state == PETSPELL_CHANGED)
            RealmDataDatabase.PExecute("INSERT INTO pet_spell (guid,spell,slot,active) VALUES ('%u', '%u', '%u','%u')", m_charmInfo->GetPetNumber(), itr->first, itr->second->slotId,itr->second->active);

        if (itr->second->state == PETSPELL_REMOVED)
            _removeSpell(itr->first);
        else
            itr->second->state = PETSPELL_UNCHANGED;
    }
}

void Pet::_LoadAuras(uint32 timediff)
{
    m_Auras.clear();
    for (int i = 0; i < TOTAL_AURAS; i++)
        m_modAuras[i].clear();

    // all aura related fields
    for (int i = UNIT_FIELD_AURA; i <= UNIT_FIELD_AURASTATE; ++i)
        SetUInt32Value(i, 0);

    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT caster_guid,spell,effect_index,stackcount,amount,maxduration,remaintime,remaincharges FROM pet_aura WHERE guid = '%u'",m_charmInfo->GetPetNumber());

    if (result)
    {
        do
        {
            Field *fields = result->Fetch();
            uint64 caster_guid = fields[0].GetUInt64();
            uint32 spellid = fields[1].GetUInt32();
            uint32 effindex = fields[2].GetUInt32();
            uint32 stackcount= fields[3].GetUInt32();
            int32 damage     = (int32)fields[4].GetUInt32();
            int32 maxduration = (int32)fields[5].GetUInt32();
            int32 remaintime = (int32)fields[6].GetUInt32();
            int32 remaincharges = (int32)fields[7].GetUInt32();

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

            /// do not load single target auras (unless they were cast by the player)
            if (caster_guid != GetGUID() && SpellMgr::IsSingleTargetSpell(spellproto))
                continue;

            for (uint32 i=0; i<stackcount; i++)
            {
                Aura* aura = CreateAura(spellproto, effindex, NULL, this, NULL);

                if (!damage)
                    damage = aura->GetModifier()->m_amount;
                aura->SetLoadedState(caster_guid,damage,maxduration,remaintime,remaincharges);
                AddAura(aura);
            }
        }
        while (result->NextRow());
    }
}

void Pet::_SaveAuras()
{
    RealmDataDatabase.PExecute("DELETE FROM pet_aura WHERE guid = '%u'", m_charmInfo->GetPetNumber());

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
            /// do not save single target auras (unless they were cast by the player)
            if (!(itr2->second->GetCasterGUID() != GetGUID() && SpellMgr::IsSingleTargetSpell(spellInfo)))
            {
                if (!itr2->second->IsPassive())
                {
                    // skip all auras from spell that apply at cast SPELL_AURA_MOD_SHAPESHIFT or pet area auras.
                    uint8 i;
                    for (i = 0; i < 3; i++)
                        if (spellInfo->EffectApplyAuraName[i] == SPELL_AURA_MOD_STEALTH ||
                            spellInfo->Effect[i] == SPELL_EFFECT_APPLY_AREA_AURA_OWNER ||
                            spellInfo->Effect[i] == SPELL_EFFECT_APPLY_AREA_AURA_PET)
                            break;

                    if (i == 3)
                    {
                        RealmDataDatabase.PExecute("INSERT INTO pet_aura (guid,caster_guid,spell,effect_index,stackcount,amount,maxduration,remaintime,remaincharges) "
                            "VALUES ('%u', '" UI64FMTD "', '%u', '%u', '%u', '%d', '%d', '%d', '%d')",
                            m_charmInfo->GetPetNumber(), itr2->second->GetCasterGUID(),(uint32)itr2->second->GetId(), (uint32)itr2->second->GetEffIndex(), (uint32)itr2->second->GetStackAmount(), itr2->second->GetModifier()->m_amount,int(itr2->second->GetAuraMaxDuration()),int(itr2->second->GetAuraDuration()),int(itr2->second->m_procCharges));
                    }
                }
            }
            if (itr == auras.end())
                break;
        }

        if (lastEffectPair == itr->first)
            stackCounter++;
        else
        {
            lastEffectPair = itr->first;
            stackCounter = 1;
        }
    }
}

bool Pet::addSpell(uint16 spell_id, uint16 active, PetSpellState state, uint16 slot_id, PetSpellType type)
{
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spell_id);
    if (!spellInfo)
    {
        // do pet spell book cleanup
        if (state == PETSPELL_UNCHANGED)                     // spell load case
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Pet::addSpell: Non-existed in SpellStore spell #%u request, deleting for all pets in `pet_spell`.",spell_id);
            RealmDataDatabase.PExecute("DELETE FROM pet_spell WHERE spell = '%u'",spell_id);
        }
        else
            sLog.outLog(LOG_DEFAULT, "ERROR: Pet::addSpell: Non-existed in SpellStore spell #%u request.",spell_id);

        return false;
    }

    // same spells don't have autocast option
    if (spellInfo->AttributesEx & SPELL_ATTR_EX_UNAUTOCASTABLE_BY_PET)
        active = ACT_CAST;

    if (spellInfo->Id == 31707)
        active = ACT_ENABLED;

    PetSpellMap::iterator itr = m_spells.find(spell_id);
    if (itr != m_spells.end())
    {
        if (itr->second->state == PETSPELL_REMOVED)
        {
            PetSpell *temp = itr->second;
            m_spells.erase(itr);
            delete temp;

            state = PETSPELL_CHANGED;
        }
        else if (state == PETSPELL_UNCHANGED && itr->second->state != PETSPELL_UNCHANGED)
        {
            // can be in case spell loading but learned at some previous spell loading
            itr->second->state = PETSPELL_UNCHANGED;

            if (active == ACT_ENABLED)
                ToggleAutocast(spell_id, true);
            else if (active == ACT_DISABLED)
                ToggleAutocast(spell_id, false);

            return false;
        }
        else
            return false;
    }

    uint32 oldspell_id = 0;

    PetSpell *newspell = new PetSpell;
    newspell->state = state;
    newspell->type = type;

    if (active == ACT_DECIDE)                                //active was not used before, so we save it's autocast/passive state here
    {
        if (SpellMgr::IsPassiveSpell(spell_id))
            newspell->active = ACT_PASSIVE;
        else
            newspell->active = ACT_DISABLED;
    }
    else
        newspell->active = active;

    uint32 chainstart = sSpellMgr.GetFirstSpellInChain(spell_id);

    for (PetSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        if (itr->second->state == PETSPELL_REMOVED) continue;

        if (sSpellMgr.GetFirstSpellInChain(itr->first) == chainstart)
        {
            slot_id = itr->second->slotId;
            newspell->active = itr->second->active;

            if (newspell->active == ACT_ENABLED)
                ToggleAutocast(itr->first, false);

            oldspell_id = itr->first;
            removeSpell(itr->first);
        }
    }

    uint16 tmpslot=slot_id;

    if (tmpslot == 0xffff)
    {
        uint16 maxid = 0;
        PetSpellMap::iterator itr;
        for (itr = m_spells.begin(); itr != m_spells.end(); ++itr)
        {
            if (itr->second->state == PETSPELL_REMOVED) continue;
            if (itr->second->slotId > maxid) maxid = itr->second->slotId;
        }
        tmpslot = maxid + 1;
    }

    newspell->slotId = tmpslot;
    m_spells[spell_id] = newspell;

    if (SpellMgr::IsPassiveSpell(spell_id))
        CastSpell(this, spell_id, true);
    else if (state == PETSPELL_NEW)
        m_charmInfo->AddSpellToActionBar(oldspell_id, spell_id, (ActiveStates)active);

    if (newspell->active == ACT_ENABLED)
        ToggleAutocast(spell_id, true);

    return true;
}

bool Pet::learnSpell(uint16 spell_id)
{
    // prevent duplicated entires in spell book
    if (!addSpell(spell_id))
        return false;

    Unit* owner = GetOwner();
    if (owner->GetTypeId()==TYPEID_PLAYER)
        ((Player*)owner)->PetSpellInitialize();
    return true;
}

void Pet::removeSpell(uint16 spell_id)
{
    PetSpellMap::iterator itr = m_spells.find(spell_id);
    if (itr == m_spells.end())
        return;

    if (itr->second->state == PETSPELL_REMOVED)
        return;

    if (itr->second->state == PETSPELL_NEW)
    {
        PetSpell *temp = itr->second;
        m_spells.erase(itr);
        delete temp;
    }
    else
        itr->second->state = PETSPELL_REMOVED;

    RemoveAurasDueToSpell(spell_id);
}

bool Pet::_removeSpell(uint16 spell_id)
{
    PetSpellMap::iterator itr = m_spells.find(spell_id);
    if (itr != m_spells.end())
    {
        PetSpell *temp = itr->second;
        m_spells.erase(itr);
        delete temp;
        return true;
    }
    return false;
}

void Pet::InitPetCreateSpells()
{
    m_charmInfo->InitPetActionBar();
    for (PetSpellMap::iterator i = m_spells.begin(); i != m_spells.end(); ++i)
        delete i->second;

    m_spells.clear();

    int32 usedtrainpoints = 0, petspellid;
    PetCreateSpellEntry const* CreateSpells = sObjectMgr.GetPetCreateSpellEntry(GetEntry());
    if (CreateSpells)
    {
        Unit* owner = GetOwner();
        Player* p_owner = owner && owner->GetTypeId() == TYPEID_PLAYER ? (Player*)owner : NULL;

        for (uint8 i = 0; i < 4; i++)
        {
            if (!CreateSpells->spellid[i])
                break;

            SpellEntry const *learn_spellproto = sSpellStore.LookupEntry(CreateSpells->spellid[i]);
            if (!learn_spellproto)
                continue;

            if (learn_spellproto->Effect[0] == SPELL_EFFECT_LEARN_SPELL || learn_spellproto->Effect[0] == SPELL_EFFECT_LEARN_PET_SPELL)
            {
                petspellid = learn_spellproto->EffectTriggerSpell[0];

                if (p_owner && !p_owner->HasSpell(learn_spellproto->Id))
                {
                    if (SpellMgr::IsPassiveSpell(petspellid))          //learn passive skills when tamed, not sure if thats right
                        p_owner->learnSpell(learn_spellproto->Id);
                    else
                        AddTeachSpell(learn_spellproto->EffectTriggerSpell[0], learn_spellproto->Id);
                }
            }
            else
                petspellid = learn_spellproto->Id;

            addSpell(petspellid);

            SkillLineAbilityMap::const_iterator lower = sSpellMgr.GetBeginSkillLineAbilityMap(learn_spellproto->EffectTriggerSpell[0]);
            SkillLineAbilityMap::const_iterator upper = sSpellMgr.GetEndSkillLineAbilityMap(learn_spellproto->EffectTriggerSpell[0]);

            for (SkillLineAbilityMap::const_iterator _spell_idx = lower; _spell_idx != upper; ++_spell_idx)
            {
                usedtrainpoints += _spell_idx->second->reqtrainpoints;
                break;
            }
        }
    }

    LearnPetPassives();

    CastPetAuras(false);

    SetTP(-usedtrainpoints);
}

void Pet::CheckLearning(uint32 spellid)
{
                                                            //charmed case -> prevent crash
    if (GetTypeId() == TYPEID_PLAYER || getPetType() != HUNTER_PET)
        return;

    Unit* owner = GetOwner();

    if (m_teachspells.empty() || !owner || owner->GetTypeId() != TYPEID_PLAYER)
        return;

    TeachSpellMap::iterator itr = m_teachspells.find(spellid);
    if (itr == m_teachspells.end())
        return;

    if (urand(0, 100) < 10)
    {
        ((Player*)owner)->learnSpell(itr->second);
        m_teachspells.erase(itr);
    }
}

uint32 Pet::resetTalentsCost() const
{
    uint32 days = (sWorld.GetGameTime() - m_resetTalentsTime)/DAY;

    // The first time reset costs 10 silver; after 1 day cost is reset to 10 silver
    if (m_resetTalentsCost < 10*SILVER || days > 0)
        return 10*SILVER;
    // then 50 silver
    else if (m_resetTalentsCost < 50*SILVER)
        return 50*SILVER;
    // then 1 gold
    else if (m_resetTalentsCost < 1*GOLD)
        return 1*GOLD;
    // then increasing at a rate of 1 gold; cap 10 gold
    else
        return (m_resetTalentsCost + 1*GOLD > 10*GOLD ? 10*GOLD : m_resetTalentsCost + 1*GOLD);
}

void Pet::ToggleAutocast(uint32 spellid, bool apply)
{
    if (SpellMgr::IsPassiveSpell(spellid))
        return;

    //if(const SpellEntry *tempSpell = GetSpellStore()->LookupEntry(spellid))
    //    if (tempSpell->EffectImplicitTargetA[0] != TARGET_SRC_CASTER
    //        && tempSpell->EffectImplicitTargetA[0] != TARGET_UNIT_TARGET_ENEMY)
    //        return;

    PetSpellMap::const_iterator itr = m_spells.find((uint16)spellid);

    int i;

    if (apply)
    {
        for (i = 0; i < m_autospells.size() && m_autospells[i] != spellid; i++);
        if (i == m_autospells.size())
        {
            m_autospells.push_back(spellid);
            if (itr->second->active != ACT_ENABLED)
            {
                itr->second->active = ACT_ENABLED;
                if (itr->second->state != PETSPELL_NEW)
                    itr->second->state = PETSPELL_CHANGED;
            }
        }
    }
    else
    {
        AutoSpellList::iterator itr2 = m_autospells.begin();
        for (i = 0; i < m_autospells.size() && m_autospells[i] != spellid; i++, itr2++);
        if (i < m_autospells.size())
        {
            m_autospells.erase(itr2);
            if (itr->second->active != ACT_DISABLED)
            {
                itr->second->active = ACT_DISABLED;
                if (itr->second->state != PETSPELL_NEW)
                    itr->second->state = PETSPELL_CHANGED;
            }
        }
    }
}

bool Pet::Create(uint32 guidlow, Map *map, uint32 Entry, uint32 pet_number)
{
    SetMapId(map->GetId());
    SetInstanceId(map->GetInstanceId());

    SetMap(map);

    Object::_Create(guidlow, pet_number, HIGHGUID_PET);

    m_DBTableGuid = guidlow;
    m_originalEntry = Entry;

    if (!InitEntry(Entry))
        return false;

    SetByteValue(UNIT_FIELD_BYTES_2, 0, SHEATH_STATE_MELEE);
    SetByteValue(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_SANCTUARY | UNIT_BYTE2_FLAG_AURAS);
    if (getPetType() == MINI_PET)                            // always non-attackable
        SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

    return true;
}

bool Pet::HasSpell(uint32 spell) const
{
    if(getPetType() == POSSESSED_PET)
        return Creature::HasSpell(spell);
    else
    {
        PetSpellMap::const_iterator itr = m_spells.find(spell);
        return (itr != m_spells.end() && itr->second->state != PETSPELL_REMOVED);
    }
}

// Get all passive spells in our skill line
void Pet::LearnPetPassives()
{
    CreatureInfo const* cInfo = GetCreatureInfo();
    if (!cInfo)
        return;

    CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(cInfo->family);
    if (!cFamily)
        return;

    PetFamilySpellsStore::const_iterator petStore = sPetFamilySpellsStore.find(cFamily->ID);
    if (petStore != sPetFamilySpellsStore.end())
    {
        // For general hunter pets skill 270
        // Passive 01~10, Passive 00 (20782, not used), Ferocious Inspiration (34457)
        // Scale 01~03 (34902~34904, bonus from owner, not used)
        for (PetFamilySpellsSet::const_iterator petSet = petStore->second.begin(); petSet != petStore->second.end(); ++petSet)
            addSpell(*petSet, ACT_DECIDE, PETSPELL_NEW, 0xffff, PETSPELL_FAMILY);
    }
}

void Pet::CastPetAuras(bool current)
{
    Unit* owner = GetOwner();
    if (!owner)
        return;

    if (getPetType() != HUNTER_PET && (getPetType() != SUMMON_PET || owner->getClass() != CLASS_WARLOCK))
        return;

    for (PetAuraSet::iterator itr = owner->m_petAuras.begin(); itr != owner->m_petAuras.end();)
    {
        PetAura const* pa = *itr;
        ++itr;

        if (!current && pa->IsRemovedOnChangePet())
            owner->RemovePetAura(pa);
        else
            CastPetAura(pa);
    }
}

void Pet::CastPetAura(PetAura const* aura)
{
    uint16 auraId = aura->GetAura(GetEntry());
    if (!auraId)
        return;

    if (auraId == 35696)                                       // Demonic Knowledge
    {
        int32 basePoints = int32(aura->GetDamage() * (GetStat(STAT_STAMINA) + GetStat(STAT_INTELLECT)) / 100);
        Unit *owner = GetOwner();
        Aura *aura = owner->GetAura(35696, 0);
        if (aura)
        {
            if (aura->GetModifierValue() == basePoints)
                return;
            else
                owner->RemoveAurasDueToSpell(35696);
        }
        CastCustomSpell(this, auraId, &basePoints, NULL, NULL, true);
    }
    else
        CastSpell(this, auraId, true);
}

void Pet::ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs)
{
    Unit* unitOwner = GetOwner();
    if (!unitOwner || unitOwner->GetTypeId() != TYPEID_PLAYER)
        return;
    Player *owner = (Player*)unitOwner;

                                                            // last check 2.0.10
    WorldPacket data(SMSG_SPELL_COOLDOWN, 8+1+m_spells.size()*8);
    data << GetGUID();
    data << uint8(0x0);                                     // flags (0x1, 0x2)
    time_t curTime = time(NULL);

    for (PetSpellMap::const_iterator itr = m_spells.begin(); itr != m_spells.end(); ++itr)
    {
        //if (itr->second.state == PLAYERSPELL_REMOVED)
        //    continue;
        uint32 unSpellId = itr->first;
        SpellEntry const *spellInfo = sSpellStore.LookupEntry(unSpellId);
        if (!spellInfo)
            continue;

        // Not send cooldown for this spells
        if (spellInfo->Attributes & SPELL_ATTR_DISABLED_WHILE_ACTIVE)
            continue;

        if (spellInfo->PreventionType != SPELL_PREVENTION_TYPE_SILENCE)
            continue;

        if ((idSchoolMask & SpellMgr::GetSpellSchoolMask(spellInfo)))// && owner->GetSpellCooldownDelay(unSpellId) < unTimeMs)
        {
            data << unSpellId;
            data << unTimeMs;                               // in m.secs
            //owner->AddSpellCooldown(unSpellId, 0, curTime + unTimeMs/1000);
        }
    }
    owner->SendPacketToSelf(&data);
}

bool Pet::IsRightSpellIdForPet(uint32 spellid)
{
    CreatureInfo const *cinfo = GetCreatureInfo();
    uint32 RightSkillId = 0;
    bool ThereIsInfo = false;
    switch (cinfo->family)
    {
        case CREATURE_FAMILY_WOLF: RightSkillId = SKILL_PET_WOLF; break;
        case CREATURE_FAMILY_CAT: RightSkillId = SKILL_PET_CAT; break;
        case CREATURE_FAMILY_SPIDER: RightSkillId = SKILL_PET_SPIDER; break;
        case CREATURE_FAMILY_BEAR: RightSkillId = SKILL_PET_BEAR; break;
        case CREATURE_FAMILY_BOAR: RightSkillId = SKILL_PET_BOAR; break;
        case CREATURE_FAMILY_CROCOLISK: RightSkillId = SKILL_PET_CROCILISK; break;
        case CREATURE_FAMILY_CARRION_BIRD: RightSkillId = SKILL_PET_CARRION_BIRD; break;
        case CREATURE_FAMILY_CRAB: RightSkillId = SKILL_PET_CRAB; break;
        case CREATURE_FAMILY_GORILLA: RightSkillId = SKILL_PET_GORILLA; break;
        case CREATURE_FAMILY_RAPTOR: RightSkillId = SKILL_PET_RAPTOR; break;
        case CREATURE_FAMILY_TALLSTRIDER: RightSkillId = SKILL_PET_TALLSTRIDER; break;
        case CREATURE_FAMILY_FELHUNTER: RightSkillId = SKILL_PET_FELHUNTER; break;
        case CREATURE_FAMILY_VOIDWALKER: RightSkillId = SKILL_PET_VOIDWALKER; break;
        case CREATURE_FAMILY_SUCCUBUS: RightSkillId = SKILL_PET_SUCCUBUS; break;
        case CREATURE_FAMILY_SCORPID: RightSkillId = SKILL_PET_SCORPID; break;
        case CREATURE_FAMILY_TURTLE: RightSkillId = SKILL_PET_TURTLE; break;
        case CREATURE_FAMILY_IMP: RightSkillId = SKILL_PET_IMP; break;
        case CREATURE_FAMILY_BAT: RightSkillId = SKILL_PET_BAT; break;
        case CREATURE_FAMILY_HYENA: RightSkillId = SKILL_PET_HYENA; break;
        case CREATURE_FAMILY_OWL: RightSkillId = SKILL_PET_OWL; break;
        case CREATURE_FAMILY_WIND_SERPENT: RightSkillId = SKILL_PET_WIND_SERPENT; break;
        case CREATURE_FAMILY_FELGUARD: RightSkillId = SKILL_PET_FELGUARD; break;
        case CREATURE_FAMILY_DRAGONHAWK: RightSkillId = SKILL_PET_DRAGONHAWK; break;
        case CREATURE_FAMILY_RAVAGER: RightSkillId = SKILL_PET_RAVAGER; break;
        case CREATURE_FAMILY_WARP_STALKER: RightSkillId = SKILL_PET_WARP_STALKER; break;
        case CREATURE_FAMILY_SPOREBAT: RightSkillId = SKILL_PET_SPOREBAT; break;
        case CREATURE_FAMILY_NETHER_RAY: RightSkillId = SKILL_PET_NETHER_RAY; break;
        case CREATURE_FAMILY_SERPENT: RightSkillId = SKILL_PET_SERPENT; break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: Unhandled case for IsRightSkillIdForPet for creaturefamily %u", cinfo->family);
            break;
    }

    for (uint32 j=0; j<sSkillLineAbilityStore.GetNumRows(); ++j)
    {
        SkillLineAbilityEntry const *pAbility = sSkillLineAbilityStore.LookupEntry(j);
        if (!pAbility)
            continue;

        if (pAbility->spellId == spellid)
        {
            if (RightSkillId == pAbility->skillId || pAbility->skillId == SKILL_PET_TALENTS)
                return true;
            else
            ThereIsInfo = true;
        }
    }

    if (!ThereIsInfo)
        return true;
    else
        return false;
}

bool Pet::canSeeOrDetect(Unit const* u, WorldObject const* vp, bool detect, bool inVisibleList /*= false*/, bool is3dDistance /*= true*/) const
{
    if (Unit* owner = GetOwner())
    {
        if (Player* playerOwner = owner->ToPlayer())
            return playerOwner->canSeeOrDetect(u, vp, detect, inVisibleList, is3dDistance);
    }

    return Creature::canSeeOrDetect(u, vp, detect, inVisibleList, is3dDistance);
}
