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
#include "Database/SQLStorage.h"
#include "Database/SQLStorageImpl.h"

#include "Log.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "SpellMgr.h"
#include "ScriptMgr.h"
#include "UpdateMask.h"
#include "World.h"
#include "WorldSession.h"
#include "Group.h"
#include "Guild.h"
#include "ArenaTeam.h"
#include "Transports.h"
#include "ProgressBar.h"
#include "Language.h"
#include "GameEvent.h"
#include "Spell.h"
#include "Chat.h"
#include "AccountMgr.h"
#include "InstanceSaveMgr.h"
#include "SpellAuras.h"
#include "Util.h"
#include "WaypointMgr.h"
#include "InstanceData.h" //for condition_instance_data

bool normalizePlayerName(std::string& name)
{
    if (name.empty())
        return false;

    wchar_t wstr_buf[MAX_INTERNAL_PLAYER_NAME+1];
    size_t wstr_len = MAX_INTERNAL_PLAYER_NAME;

    if (!Utf8toWStr(name,&wstr_buf[0],wstr_len))
        return false;

    wstr_buf[0] = wcharToUpper(wstr_buf[0]);
    for (size_t i = 1; i < wstr_len; ++i)
        wstr_buf[i] = wcharToLower(wstr_buf[i]);

    if (!WStrToUtf8(wstr_buf,wstr_len,name))
        return false;

    return true;
}

LanguageDesc lang_description[LANGUAGES_COUNT] =
{
    { LANG_ADDON,           0, 0                       },
    { LANG_UNIVERSAL,       0, 0                       },
    { LANG_ORCISH,        669, SKILL_LANG_ORCISH       },
    { LANG_DARNASSIAN,    671, SKILL_LANG_DARNASSIAN   },
    { LANG_TAURAHE,       670, SKILL_LANG_TAURAHE      },
    { LANG_DWARVISH,      672, SKILL_LANG_DWARVEN      },
    { LANG_COMMON,        668, SKILL_LANG_COMMON       },
    { LANG_DEMONIC,       815, SKILL_LANG_DEMON_TONGUE },
    { LANG_TITAN,         816, SKILL_LANG_TITAN        },
    { LANG_THALASSIAN,    813, SKILL_LANG_THALASSIAN   },
    { LANG_DRACONIC,      814, SKILL_LANG_DRACONIC     },
    { LANG_KALIMAG,       817, SKILL_LANG_OLD_TONGUE   },
    { LANG_GNOMISH,      7340, SKILL_LANG_GNOMISH      },
    { LANG_TROLL,        7341, SKILL_LANG_TROLL        },
    { LANG_GUTTERSPEAK, 17737, SKILL_LANG_GUTTERSPEAK  },
    { LANG_DRAENEI,     29932, SKILL_LANG_DRAENEI      },
    { LANG_ZOMBIE,          0, 0                       },
    { LANG_GNOMISH_BINARY,  0, 0                       },
    { LANG_GOBLIN_BINARY,   0, 0                       }
};

LanguageDesc const* GetLanguageDescByID(uint32 lang)
{
    for (int i = 0; i < LANGUAGES_COUNT; ++i)
    {
        if (uint32(lang_description[i].lang_id) == lang)
            return &lang_description[i];
    }

    return NULL;
}

ObjectMgr::ObjectMgr()
{
    m_hiCharGuid        = 1;
    m_hiCreatureGuid    = 1;
    m_hiPetGuid         = 1;
    m_hiItemGuid        = 1;
    m_hiGoGuid          = 1;
    m_hiDoGuid          = 1;
    m_hiCorpseGuid      = 1;
    m_hiPetNumber       = 1;
    m_ItemTextId        = 1;
    m_mailid            = 1;
    m_arenaTeamId       = 1;
    m_auctionid         = 1;

    // Only zero condition left, others will be added while loading DB tables
    mConditions.resize(1);
}

ObjectMgr::~ObjectMgr()
{
    for (QuestMap::iterator i = mQuestTemplates.begin(); i != mQuestTemplates.end(); ++i)
        delete i->second;
    mQuestTemplates.clear();

    mGossipText.clear();
    mAreaTriggers.clear();

    for (PetLevelInfoMap::iterator i = petInfo.begin(); i != petInfo.end(); ++i)
        delete[] i->second;
    petInfo.clear();

    // free only if loaded
    for (int class_ = 0; class_ < MAX_CLASSES; ++class_)
        delete[] playerClassInfo[class_].levelInfo;

    for (int race = 0; race < MAX_RACES; ++race)
        for (int class_ = 0; class_ < MAX_CLASSES; ++class_)
            delete[] playerInfo[race][class_].levelInfo;

    // free group and guild objects
    for (GroupSet::iterator itr = mGroupSet.begin(); itr != mGroupSet.end(); ++itr)
        delete (*itr);

    for (CacheVendorItemMap::iterator itr = m_mCacheVendorItemMap.begin(); itr != m_mCacheVendorItemMap.end(); ++itr)
        itr->second.Clear();

    for (CacheTrainerSpellMap::iterator itr = m_mCacheTrainerSpellMap.begin(); itr != m_mCacheTrainerSpellMap.end(); ++itr)
        itr->second.Clear();
}

Group * ObjectMgr::GetGroupByLeader(const uint64 &guid) const
{
    for (GroupSet::const_iterator itr = mGroupSet.begin(); itr != mGroupSet.end(); ++itr)
        if ((*itr)->GetLeaderGUID() == guid)
            return *itr;

    return NULL;
}

ArenaTeam* ObjectMgr::GetArenaTeamById(const uint32 arenateamid) const
{
    ArenaTeamMap::const_iterator itr = mArenaTeamMap.find(arenateamid);
    if (itr != mArenaTeamMap.end())
        return itr->second;

    return NULL;
}


ArenaTeam* ObjectMgr::GetArenaTeamByName(const std::string& arenateamname) const
{
    std::string search = arenateamname;
    std::transform(search.begin(), search.end(), search.begin(), toupper);
    for (ArenaTeamMap::const_iterator itr = mArenaTeamMap.begin(); itr != mArenaTeamMap.end(); ++itr)
    {
        std::string teamname = itr->second->GetName();
        std::transform(teamname.begin(), teamname.end(), teamname.begin(), toupper);
        if (search == teamname)
            return itr->second;
    }
    return NULL;
}

ArenaTeam* ObjectMgr::GetArenaTeamByCaptain(uint64 const& guid) const
{
    for (ArenaTeamMap::const_iterator itr = mArenaTeamMap.begin(); itr != mArenaTeamMap.end(); ++itr)
        if (itr->second->GetCaptain() == guid)
            return itr->second;

    return NULL;
}

void ObjectMgr::AddArenaTeam(ArenaTeam* arenaTeam)
{
    mArenaTeamMap[arenaTeam->GetId()] = arenaTeam;
}

void ObjectMgr::RemoveArenaTeam(uint32 Id)
{
    mArenaTeamMap.erase(Id);
}

CreatureInfo const* ObjectMgr::GetCreatureTemplate(uint32 id)
{
    return sCreatureStorage.LookupEntry<CreatureInfo>(id);
}

void ObjectMgr::LoadCreatureLocales()
{
    mCreatureLocaleMap.clear();                              // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry,name_loc1,subname_loc1,name_loc2,subname_loc2,name_loc3,subname_loc3,name_loc4,subname_loc4,name_loc5,subname_loc5,name_loc6,subname_loc6,name_loc7,subname_loc7,name_loc8,subname_loc8 FROM locales_creature");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outString(">> Loaded 0 creature locale strings. DB table `locales_creature` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 entry = fields[0].GetUInt32();

        CreatureLocale& data = mCreatureLocaleMap[entry];

        for (int i = 1; i < MAX_LOCALE; ++i)
        {
            std::string str = fields[1+2*(i-1)].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.Name.size() <= idx)
                        data.Name.resize(idx+1);

                    data.Name[idx] = str;
                }
            }
            str = fields[1+2*(i-1)+1].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.SubName.size() <= idx)
                        data.SubName.resize(idx+1);

                    data.SubName[idx] = str;
                }
            }
        }
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u creature locale strings", mCreatureLocaleMap.size());
}

void ObjectMgr::LoadNpcOptionLocales()
{
    mNpcOptionLocaleMap.clear();                              // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry,"
        "option_text_loc1,box_text_loc1,option_text_loc2,box_text_loc2,"
        "option_text_loc3,box_text_loc3,option_text_loc4,box_text_loc4,"
        "option_text_loc5,box_text_loc5,option_text_loc6,box_text_loc6,"
        "option_text_loc7,box_text_loc7,option_text_loc8,box_text_loc8 "
        "FROM locales_npc_option");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outString(">> Loaded 0 npc_option locale strings. DB table `locales_npc_option` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 entry = fields[0].GetUInt32();

        NpcOptionLocale& data = mNpcOptionLocaleMap[entry];

        for (int i = 1; i < MAX_LOCALE; ++i)
        {
            std::string str = fields[1+2*(i-1)].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.OptionText.size() <= idx)
                        data.OptionText.resize(idx+1);

                    data.OptionText[idx] = str;
                }
            }
            str = fields[1+2*(i-1)+1].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.BoxText.size() <= idx)
                        data.BoxText.resize(idx+1);

                    data.BoxText[idx] = str;
                }
            }
        }
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u npc_option locale strings", mNpcOptionLocaleMap.size());
}

struct SQLCreatureLoader : public SQLStorageLoaderBase<SQLCreatureLoader>
{
    template<class D>
    void convert_from_str(uint32 field_pos, const char *src, D &dst)
    {
        dst = D(sScriptMgr.GetScriptId(src));
    }
};

void ObjectMgr::LoadCreatureTemplates()
{
    SQLCreatureLoader loader;
    loader.Load(sCreatureStorage);

    sLog.outString(">> Loaded %u creature definitions", sCreatureStorage.RecordCount);
    sLog.outString();

    std::set<uint32> heroicEntries;                         // already loaded heroic value in creatures
    std::set<uint32> hasHeroicEntries;                      // already loaded creatures with heroic entry values

    // check data correctness
    for (uint32 i = 1; i < sCreatureStorage.MaxEntry; ++i)
    {
        CreatureInfo const* cInfo = sCreatureStorage.LookupEntry<CreatureInfo>(i);
        if (!cInfo)
            continue;

        if (cInfo->HeroicEntry)
        {
            CreatureInfo const* heroicInfo = GetCreatureTemplate(cInfo->HeroicEntry);
            if (!heroicInfo)
            {
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) have `heroic_entry`=%u but creature entry %u not exist.",cInfo->HeroicEntry,cInfo->HeroicEntry);
                continue;
            }

            if (heroicEntries.find(i)!=heroicEntries.end())
            {
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) listed as heroic but have value in `heroic_entry`.",i);
                continue;
            }

            if (heroicEntries.find(cInfo->HeroicEntry)!=heroicEntries.end())
            {
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) already listed as heroic for another entry.",cInfo->HeroicEntry);
                continue;
            }

            if (hasHeroicEntries.find(cInfo->HeroicEntry)!=hasHeroicEntries.end())
            {
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) have `heroic_entry`=%u but creature entry %u have heroic entry also.",i,cInfo->HeroicEntry,cInfo->HeroicEntry);
                continue;
            }

            if (cInfo->npcflag != heroicInfo->npcflag)
            {
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) listed in `creature_template_substitution` has different `npcflag` in heroic mode.",i);
                continue;
            }

            if (cInfo->classNum != heroicInfo->classNum)
            {
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) listed in `creature_template_substitution` has different `classNum` in heroic mode.",i);
                continue;
            }

            if (cInfo->race != heroicInfo->race)
            {
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) listed in `creature_template_substitution` has different `race` in heroic mode.",i);
                continue;
            }

            if (cInfo->trainer_type != heroicInfo->trainer_type)
            {
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) listed in `creature_template_substitution` has different `trainer_type` in heroic mode.",i);
                continue;
            }

            if (cInfo->trainer_spell != heroicInfo->trainer_spell)
            {
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) listed in `creature_template_substitution` has different `trainer_spell` in heroic mode.",i);
                continue;
            }

            hasHeroicEntries.insert(i);
            heroicEntries.insert(cInfo->HeroicEntry);
        }

        FactionTemplateEntry const* factionTemplate = sFactionTemplateStore.LookupEntry(cInfo->faction_A);
        if (!factionTemplate)
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has non-existing faction_A template (%u)", cInfo->Entry, cInfo->faction_A);

        factionTemplate = sFactionTemplateStore.LookupEntry(cInfo->faction_H);
        if (!factionTemplate)
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has non-existing faction_H template (%u)", cInfo->Entry, cInfo->faction_H);

        // check model ids, supplying and sending non-existent ids to the client might crash them
        if (cInfo->Modelid_A1 && !sCreatureModelStorage.LookupEntry<CreatureModelInfo>(cInfo->Modelid_A1))
        {
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has non-existing Modelid_A1 (%u), setting it to 0", cInfo->Entry, cInfo->Modelid_A1);
            const_cast<CreatureInfo*>(cInfo)->Modelid_A1 = 0;
        }
        if (cInfo->Modelid_A2 && !sCreatureModelStorage.LookupEntry<CreatureModelInfo>(cInfo->Modelid_A2))
        {
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has non-existing Modelid_A2 (%u), setting it to 0", cInfo->Entry, cInfo->Modelid_A2);
            const_cast<CreatureInfo*>(cInfo)->Modelid_A2 = 0;
        }
        if (cInfo->Modelid_H1 && !sCreatureModelStorage.LookupEntry<CreatureModelInfo>(cInfo->Modelid_H1))
        {
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has non-existing Modelid_H1 (%u), setting it to 0", cInfo->Entry, cInfo->Modelid_H1);
            const_cast<CreatureInfo*>(cInfo)->Modelid_H1 = 0;
        }
        if (cInfo->Modelid_H2 && !sCreatureModelStorage.LookupEntry<CreatureModelInfo>(cInfo->Modelid_H2))
        {
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has non-existing Modelid_H2 (%u), setting it to 0", cInfo->Entry, cInfo->Modelid_H2);
            const_cast<CreatureInfo*>(cInfo)->Modelid_H2 = 0;
        }

        if (cInfo->dmgschool >= MAX_SPELL_SCHOOL)
        {
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has invalid spell school value (%u) in `dmgschool`",cInfo->Entry,cInfo->dmgschool);
            const_cast<CreatureInfo*>(cInfo)->dmgschool = SPELL_SCHOOL_NORMAL;
        }

        if (cInfo->baseattacktime == 0)
            const_cast<CreatureInfo*>(cInfo)->baseattacktime  = BASE_ATTACK_TIME;

        if (cInfo->rangeattacktime == 0)
            const_cast<CreatureInfo*>(cInfo)->rangeattacktime = BASE_ATTACK_TIME;

        if ((cInfo->npcflag & UNIT_NPC_FLAG_TRAINER) && cInfo->trainer_type >= MAX_TRAINER_TYPE)
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has wrong trainer type %u",cInfo->Entry,cInfo->trainer_type);

        if (cInfo->InhabitType <= 0 || cInfo->InhabitType > INHABIT_ANYWHERE)
        {
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has wrong value (%u) in `InhabitType`, creature will not correctly walk/swim/fly",cInfo->Entry,cInfo->InhabitType);
            const_cast<CreatureInfo*>(cInfo)->InhabitType = INHABIT_ANYWHERE;
        }

        if (cInfo->PetSpellDataId)
        {
            CreatureSpellDataEntry const* spellDataId = sCreatureSpellDataStore.LookupEntry(cInfo->PetSpellDataId);
            if (!spellDataId)
                sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has non-existing PetSpellDataId (%u)", cInfo->Entry, cInfo->PetSpellDataId);
        }

        if (cInfo->MovementType >= MAX_DB_MOTION_TYPE)
        {
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) has wrong movement generator type (%u), ignore and set to IDLE.",cInfo->Entry,cInfo->MovementType);
            const_cast<CreatureInfo*>(cInfo)->MovementType = IDLE_MOTION_TYPE;
        }

        if (cInfo->equipmentId > 0)                          // 0 no equipment
        {
            if (!GetEquipmentInfo(cInfo->equipmentId))
            {
                sLog.outLog(LOG_DB_ERR, "Table `creature_template` have creature (Entry: %u) with equipment_id %u not found in table `creature_equip_template`, set to no equipment.", cInfo->Entry, cInfo->equipmentId);
                const_cast<CreatureInfo*>(cInfo)->equipmentId = 0;
            }
        }

        /// if not set custom creature scale then load scale from CreatureDisplayInfo.dbc
        if (cInfo->scale <= 0.0f)
        {
            uint32 modelid = cInfo->GetFirstValidModelId();
            CreatureDisplayInfoEntry const* ScaleEntry = sCreatureDisplayInfoStore.LookupEntry(modelid);
            const_cast<CreatureInfo*>(cInfo)->scale = ScaleEntry ? ScaleEntry->scale : 1.0f;
        }

        if (cInfo->xpMod < 0)
        {
            sLog.outLog(LOG_DB_ERR, "Table `creature_template` have creature (Entry: %u) with wrong xpMod: %u. Defaulting to 0.0f", cInfo->Entry, cInfo->equipmentId);
            const_cast<CreatureInfo*>(cInfo)->xpMod = 0.0f;
        }
    }
}

void ObjectMgr::ConvertCreatureAddonAuras(CreatureDataAddon* addon, char const* table, char const* guidEntryStr)
{
    // Now add the auras, format "spellid effectindex spellid effectindex..."
    char *p,*s;
    std::vector<int> val;
    s=p=(char*)reinterpret_cast<char const*>(addon->auras);
    if (p)
    {
        while (p[0]!=0)
        {
            ++p;
            if (p[0]==' ')
            {
                val.push_back(atoi(s));
                s=++p;
            }
        }
        if (p!=s)
            val.push_back(atoi(s));

        // free char* loaded memory
        delete[] (char*)reinterpret_cast<char const*>(addon->auras);

        // wrong list
        if (val.size()%2)
        {
            addon->auras = NULL;
            sLog.outLog(LOG_DB_ERR, "Creature (%s: %u) has wrong `auras` data in `%s`.",guidEntryStr,addon->guidOrEntry,table);
            return;
        }
    }

    // empty list
    if (val.empty())
    {
        addon->auras = NULL;
        return;
    }

    // replace by new structures array
    const_cast<CreatureDataAddonAura*&>(addon->auras) = new CreatureDataAddonAura[val.size()/2+1];

    int i=0;
    for (int j=0;j<val.size()/2;++j)
    {
        CreatureDataAddonAura& cAura = const_cast<CreatureDataAddonAura&>(addon->auras[i]);
        cAura.spell_id = (uint32)val[2*j+0];
        cAura.effect_idx  = (uint32)val[2*j+1];
        if (cAura.effect_idx > 2)
        {
            sLog.outLog(LOG_DB_ERR, "Creature (%s: %u) has wrong effect %u for spell %u in `auras` field in `%s`.",guidEntryStr,addon->guidOrEntry,cAura.effect_idx,cAura.spell_id,table);
            continue;
        }
        SpellEntry const *AdditionalSpellInfo = sSpellStore.LookupEntry(cAura.spell_id);
        if (!AdditionalSpellInfo)
        {
            sLog.outLog(LOG_DB_ERR, "Creature (%s: %u) has wrong spell %u defined in `auras` field in `%s`.",guidEntryStr,addon->guidOrEntry,cAura.spell_id,table);
            continue;
        }

        if (!AdditionalSpellInfo->Effect[cAura.effect_idx] || !AdditionalSpellInfo->EffectApplyAuraName[cAura.effect_idx])
        {
            sLog.outLog(LOG_DB_ERR, "Creature (%s: %u) has not aura effect %u of spell %u defined in `auras` field in `%s`.",guidEntryStr,addon->guidOrEntry,cAura.effect_idx,cAura.spell_id,table);
            continue;
        }

        ++i;
    }

    // fill terminator element (after last added)
    CreatureDataAddonAura& endAura = const_cast<CreatureDataAddonAura&>(addon->auras[i]);
    endAura.spell_id   = 0;
    endAura.effect_idx = 0;
}

void ObjectMgr::LoadCreatureAddons()
{
    sCreatureInfoAddonStorage.Load();

    sLog.outString(">> Loaded %u creature template addons", sCreatureInfoAddonStorage.RecordCount);
    sLog.outString();

    // check data correctness and convert 'auras'
    for (uint32 i = 1; i < sCreatureInfoAddonStorage.MaxEntry; ++i)
    {
        CreatureDataAddon const* addon = sCreatureInfoAddonStorage.LookupEntry<CreatureDataAddon>(i);
        if (!addon)
            continue;

        if (!sEmotesStore.LookupEntry(addon->emote))
            sLog.outLog(LOG_DB_ERR, "Creature (GUID: %u) have invalid emote (%u) defined in `creature_addon`.", addon->guidOrEntry, addon->emote);

        ConvertCreatureAddonAuras(const_cast<CreatureDataAddon*>(addon), "creature_template_addon", "Entry");

        if (!sCreatureStorage.LookupEntry<CreatureInfo>(addon->guidOrEntry))
            sLog.outLog(LOG_DB_ERR, "Creature (Entry: %u) does not exist but has a record in `creature_template_addon`",addon->guidOrEntry);
    }

    sCreatureDataAddonStorage.Load();

    sLog.outString(">> Loaded %u creature addons", sCreatureDataAddonStorage.RecordCount);
    sLog.outString();

    // check data correctness and convert 'auras'
    for (uint32 i = 1; i < sCreatureDataAddonStorage.MaxEntry; ++i)
    {
        CreatureDataAddon const* addon = sCreatureDataAddonStorage.LookupEntry<CreatureDataAddon>(i);
        if (!addon)
            continue;

        if (!sEmotesStore.LookupEntry(addon->emote))
            sLog.outLog(LOG_DB_ERR, "Creature (GUID: %u) have invalid emote (%u) defined in `creature_template_addon`.", addon->guidOrEntry, addon->emote);

        ConvertCreatureAddonAuras(const_cast<CreatureDataAddon*>(addon), "creature_addon", "GUIDLow");

        if (mCreatureDataMap.find(addon->guidOrEntry)==mCreatureDataMap.end())
            sLog.outLog(LOG_DB_ERR, "Creature (GUID: %u) does not exist but has a record in `creature_addon`",addon->guidOrEntry);
    }
}

EquipmentInfo const* ObjectMgr::GetEquipmentInfo(uint32 entry)
{
    return sEquipmentStorage.LookupEntry<EquipmentInfo>(entry);
}

void ObjectMgr::LoadEquipmentTemplates()
{
    sEquipmentStorage.Load();

    sLog.outString(">> Loaded %u equipment template", sEquipmentStorage.RecordCount);
    sLog.outString();
}

CreatureModelInfo const* ObjectMgr::GetCreatureModelInfo(uint32 modelid)
{
    return sCreatureModelStorage.LookupEntry<CreatureModelInfo>(modelid);
}

uint32 ObjectMgr::ChooseDisplayId(uint32 team, const CreatureInfo *cinfo, const CreatureData *data)
{
    // Load creature model (display id)
    uint32 display_id = 0;

    if (!data || data->displayid == 0) // use defaults from the template
    {
        display_id = cinfo->GetRandomValidModelId();
    } else display_id = data->displayid; // overwritten from creature data

    return display_id;
}

CreatureModelInfo const* ObjectMgr::GetCreatureModelRandomGender(uint32 display_id)
{
    CreatureModelInfo const *minfo = GetCreatureModelInfo(display_id);
    if (!minfo)
        return NULL;

    // If a model for another gender exists, 50% chance to use it
    if (minfo->modelid_other_gender != 0 && urand(0,1) == 0)
    {
        CreatureModelInfo const *minfo_tmp = GetCreatureModelInfo(minfo->modelid_other_gender);
        if (!minfo_tmp)
        {
            sLog.outLog(LOG_DB_ERR, "Model (Entry: %u) has modelid_other_gender %u not found in table `creature_model_info`. ", minfo->modelid, minfo->modelid_other_gender);
            return minfo;                                   // not fatal, just use the previous one
        }
        else
            return minfo_tmp;
    }
    else
        return minfo;
}

void ObjectMgr::LoadCreatureModelInfo()
{
    sCreatureModelStorage.Load();

    sLog.outString(">> Loaded %u creature model based info", sCreatureModelStorage.RecordCount);
    sLog.outString();

    // check if combat_reach is valid
    for (uint32 i = 1; i < sCreatureModelStorage.MaxEntry; ++i)
    {
        CreatureModelInfo const* mInfo = sCreatureModelStorage.LookupEntry<CreatureModelInfo>(i);
        if (!mInfo)
            continue;

        if (mInfo->combat_reach < 0.1f)
        {
            //sLog.outLog(LOG_DB_ERR, "Creature model (Entry: %u) has invalid combat reach (%f), setting it to 0.5", mInfo->modelid, mInfo->combat_reach);
            const_cast<CreatureModelInfo*>(mInfo)->combat_reach = DEFAULT_COMBAT_REACH;
        }
    }
}

bool ObjectMgr::CheckCreatureLinkedRespawn(uint32 guid, uint32 linkedGuid) const
{
    const CreatureData* const slave = GetCreatureData(guid);
    const CreatureData* const master = GetCreatureData(linkedGuid);

    if (!slave || !master) // they must have a corresponding entry in db
    {
        sLog.outLog(LOG_DB_ERR, "LinkedRespawn: Creature '%u' linking to '%u' which doesn't exist",guid,linkedGuid);
        return false;
    }

    const MapEntry* const map = sMapStore.LookupEntry(master->mapid);

    if (master->mapid != slave->mapid        // link only to same map
        && (!map || map->Instanceable()))   // or to unistanced world
    {
        sLog.outLog(LOG_DB_ERR, "LinkedRespawn: Creature '%u' linking to '%u' on an unpermitted map",guid,linkedGuid);
        return false;
    }

    if (!(master->spawnMask & slave->spawnMask)  // they must have a possibility to meet (normal/heroic difficulty)
        && (!map || map->Instanceable()))
    {
        sLog.outLog(LOG_DB_ERR, "LinkedRespawn: Creature '%u' linking to '%u' with not corresponding spawnMask",guid,linkedGuid);
        return false;
    }

    return true;
}

void ObjectMgr::LoadCreatureLinkedRespawn()
{
    mCreatureLinkedRespawnMap.clear();
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT guid, linkedGuid FROM creature_linked_respawn ORDER BY guid ASC");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outLog(LOG_DB_ERR, ">> Loaded 0 linked respawns. DB table `creature_linked_respawn` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 guid = fields[0].GetUInt32();
        uint32 linkedGuid = fields[1].GetUInt32();

        if (CheckCreatureLinkedRespawn(guid,linkedGuid))
            mCreatureLinkedRespawnMap[guid] = linkedGuid;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u linked respawns", mCreatureLinkedRespawnMap.size());
}

bool ObjectMgr::SetCreatureLinkedRespawn(uint32 guid, uint32 linkedGuid)
{
    if (!guid)
        return false;

    if (!linkedGuid) // we're removing the linking
    {
        mCreatureLinkedRespawnMap.erase(guid);
        GameDataDatabase.DirectPExecute("DELETE FROM `creature_linked_respawn` WHERE `guid` = '%u'",guid);
        return true;
    }

    if (CheckCreatureLinkedRespawn(guid,linkedGuid)) // we add/change linking
    {
        mCreatureLinkedRespawnMap[guid] = linkedGuid;
        GameDataDatabase.DirectPExecute("REPLACE INTO `creature_linked_respawn`(`guid`,`linkedGuid`) VALUES ('%u','%u')",guid,linkedGuid);
        return true;
    }
    return false;
}

void ObjectMgr::LoadUnqueuedAccountList()
{
    m_UnqueuedAccounts.clear();
    QueryResultAutoPtr result = AccountsDatabase.Query("SELECT accid FROM unqueue_account ORDER BY accid ASC");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outString(">> Loaded 0 unqueued accounts. DB table `unqueue_account` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        m_UnqueuedAccounts.insert(fields[0].GetUInt32());

    }while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u unqueued accounts", m_UnqueuedAccounts.size());
}

bool ObjectMgr::IsUnqueuedAccount(uint64 accid)
{
    return (m_UnqueuedAccounts.count(accid) != 0);
}

void ObjectMgr::LoadCreatures()
{
    uint32 count = 0;
    //                                                       0              1   2    3
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT creature.guid, id, map, modelid,"
    //   4             5           6           7           8            9              10         11
        "equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint,"
    //   12         13       14          15            16         17     18
        "curhealth, curmana, DeathState, MovementType, spawnMask, event, pool_entry "
        "FROM creature LEFT OUTER JOIN game_event_creature ON creature.guid = game_event_creature.guid "
        "LEFT OUTER JOIN pool_creature ON creature.guid = pool_creature.guid");


    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outLog(LOG_DB_ERR, ">> Loaded 0 creature. DB table `creature` is empty.");
        return;
    }

    // build single time for check creature data
    std::set<uint32> heroicCreatures;
    for (uint32 i = 0; i < sCreatureStorage.MaxEntry; ++i)
        if (CreatureInfo const* cInfo = sCreatureStorage.LookupEntry<CreatureInfo>(i))
            if (cInfo->HeroicEntry)
                heroicCreatures.insert(cInfo->HeroicEntry);

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 guid         = fields[ 0].GetUInt32();
        uint32 entry        = fields[ 1].GetUInt32();

        CreatureInfo const* cInfo = GetCreatureTemplate(entry);
        if (!cInfo)
        {
            sLog.outLog(LOG_DB_ERR, "Table `creature` has creature (GUID: %u) with non existing creature entry %u, skipped.", guid, entry);
            continue;
        }

        CreatureData& data = mCreatureDataMap[guid];

        data.id             = entry;
        data.mapid          = fields[ 2].GetUInt32();
        data.displayid      = fields[ 3].GetUInt32();
        data.equipmentId    = fields[ 4].GetUInt32();
        data.posX           = fields[ 5].GetFloat();
        data.posY           = fields[ 6].GetFloat();
        data.posZ           = fields[ 7].GetFloat();
        data.orientation    = fields[ 8].GetFloat();
        data.spawntimesecs  = fields[ 9].GetUInt32();
        data.spawndist      = fields[10].GetFloat();
        data.currentwaypoint= fields[11].GetUInt32();
        data.curhealth      = fields[12].GetUInt32();
        data.curmana        = fields[13].GetUInt32();
        data.is_dead        = fields[14].GetBool();
        data.movementType   = fields[15].GetUInt8();
        data.spawnMask      = fields[16].GetUInt8();
        int16 gameEvent     = fields[17].GetInt16();
        int16 PoolId        = fields[18].GetInt16();

        if (heroicCreatures.find(data.id)!=heroicCreatures.end())
        {
            sLog.outLog(LOG_DB_ERR, "Table `creature` have creature (GUID: %u) that listed as heroic template in `creature_template_substitution`, skipped.",guid,data.id);
            continue;
        }

        if (data.equipmentId > 0)                            // -1 no equipment, 0 use default
        {
            if (!GetEquipmentInfo(data.equipmentId))
            {
                sLog.outLog(LOG_DB_ERR, "Table `creature` have creature (Entry: %u) with equipment_id %u not found in table `creature_equip_template`, set to no equipment.", data.id, data.equipmentId);
                data.equipmentId = -1;
            }
        }

        if (cInfo->RegenHealth && data.curhealth < cInfo->minhealth)
        {
            sLog.outLog(LOG_DB_ERR, "Table `creature` have creature (GUID: %u Entry: %u) with `creature_template`.`RegenHealth`=1 and low current health (%u), `creature_template`.`minhealth`=%u.",guid,data.id,data.curhealth, cInfo->minhealth);
            data.curhealth = cInfo->minhealth;
        }

        if (data.curmana < cInfo->minmana)
        {
            sLog.outLog(LOG_DB_ERR, "Table `creature` have creature (GUID: %u Entry: %u) with low current mana (%u), `creature_template`.`minmana`=%u.",guid,data.id,data.curmana, cInfo->minmana);
            data.curmana = cInfo->minmana;
        }

        if (data.spawndist < 0.0f)
        {
            sLog.outLog(LOG_DB_ERR, "Table `creature` have creature (GUID: %u Entry: %u) with `spawndist`< 0, set to 0.",guid,data.id);
            data.spawndist = 0.0f;
        }
        else if (data.movementType == RANDOM_MOTION_TYPE)
        {
            if (data.spawndist == 0.0f)
            {
                sLog.outLog(LOG_DB_ERR, "Table `creature` have creature (GUID: %u Entry: %u) with `MovementType`=1 (random movement) but with `spawndist`=0, replace by idle movement type (0).",guid,data.id);
                data.movementType = IDLE_MOTION_TYPE;
            }
        }
        else if (data.movementType == IDLE_MOTION_TYPE)
        {
            if (data.spawndist != 0.0f)
            {
                sLog.outLog(LOG_DB_ERR, "Table `creature` have creature (GUID: %u Entry: %u) with `MovementType`=0 (idle) have `spawndist`<>0, set to 0.",guid,data.id);
                data.spawndist = 0.0f;
            }
        }

        if (gameEvent == 0 && PoolId == 0)                    // if not this is to be managed by GameEvent System
        {
            AddCreatureToGrid(guid, &data);

            if (cInfo->flags_extra & CREATURE_FLAG_EXTRA_ACTIVE)
                m_activeCreatures.insert(ActiveCreatureGuidsOnMap::value_type(data.mapid, guid));
        }

        ++count;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u creatures", mCreatureDataMap.size());
}

void ObjectMgr::AddCreatureToGrid(uint32 guid, CreatureData const* data)
{
    uint8 mask = data->spawnMask;
    for (uint8 i = 0; mask != 0; i++, mask >>= 1)
    {
        if (mask & 1)
        {
            CellPair cell_pair = Looking4group::ComputeCellPair(data->posX, data->posY);
            uint32 cell_id = (cell_pair.y_coord*TOTAL_NUMBER_OF_CELLS_PER_MAP) + cell_pair.x_coord;

            CellObjectGuids& cell_guids = mMapObjectGuids[MAKE_PAIR32(data->mapid,i)][cell_id];
            cell_guids.creatures.insert(guid);
        }
    }
}

void ObjectMgr::RemoveCreatureFromGrid(uint32 guid, CreatureData const* data)
{
    uint8 mask = data->spawnMask;
    for (uint8 i = 0; mask != 0; i++, mask >>= 1)
    {
        if (mask & 1)
        {
            CellPair cell_pair = Looking4group::ComputeCellPair(data->posX, data->posY);
            uint32 cell_id = (cell_pair.y_coord*TOTAL_NUMBER_OF_CELLS_PER_MAP) + cell_pair.x_coord;

            CellObjectGuids& cell_guids = mMapObjectGuids[MAKE_PAIR32(data->mapid,i)][cell_id];
            cell_guids.creatures.erase(guid);
        }
    }
}

uint32 ObjectMgr::AddGOData(uint32 entry, uint32 artKit, uint32 mapId, float x, float y, float z, float o, uint32 spawntimedelay, float rotation0, float rotation1, float rotation2, float rotation3)
{
    GameObjectInfo const* goinfo = GetGameObjectInfo(entry);
    if (!goinfo)
        return 0;

    uint32 guid = GenerateLowGuid(HIGHGUID_GAMEOBJECT);
    GameObjectData& data = NewGOData(guid);
    data.id             = entry;
    data.mapid          = mapId;
    data.posX           = x;
    data.posY           = y;
    data.posZ           = z;
    data.orientation    = o;
    data.rotation0      = rotation0;
    data.rotation1      = rotation1;
    data.rotation2      = rotation2;
    data.rotation3      = rotation3;
    data.spawntimesecs  = spawntimedelay;
    data.animprogress   = 100;
    data.spawnMask      = 1;
    data.go_state       = GO_STATE_READY;
    data.ArtKit         = artKit;
    data.dbData = false;

    AddGameobjectToGrid(guid, &data);

    // Spawn if necessary (loaded grids only)
    if (Map* map = sMapMgr.FindMap(mapId))
    {
        // We use spawn coords to spawn
        if (!map->Instanceable() && !map->IsRemovalGrid(x, y))
        {
            GameObject *go = new GameObject;
            if (!go->LoadFromDB(guid, map))
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: AddGameObject: cannot add gameobject entry %u to map", entry);
                delete go;
                return 0;
            }
            map->Add(go);
        }
    }

    return guid;
}

uint32 ObjectMgr::AddCreData(uint32 entry, uint32 team, uint32 mapId, float x, float y, float z, float o, uint32 spawntimedelay)
{
    CreatureInfo const *cInfo = GetCreatureTemplate(entry);
    if (!cInfo)
        return 0;

    uint32 guid = GenerateLowGuid(HIGHGUID_UNIT);
    CreatureData& data = NewOrExistCreatureData(guid);
    data.id = entry;
    data.mapid = mapId;
    data.displayid = 0;
    data.equipmentId = cInfo->equipmentId;
    data.posX = x;
    data.posY = y;
    data.posZ = z;
    data.orientation = o;
    data.spawntimesecs = spawntimedelay;
    data.spawndist = 0;
    data.currentwaypoint = 0;
    data.curhealth = cInfo->maxhealth;
    data.curmana = cInfo->maxmana;
    data.is_dead = false;
    data.movementType = cInfo->MovementType;
    data.spawnMask = 1;
    data.dbData = false;

    AddCreatureToGrid(guid, &data);

    // Spawn if necessary (loaded grids only)
    if (Map* map = sMapMgr.FindMap(mapId))
    {
        // We use spawn coords to spawn
        if (!map->Instanceable() && !map->IsRemovalGrid(x, y))
        {
            Creature* creature = new Creature;
            if (!creature->LoadFromDB(guid, map))
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: AddCreature: cannot add creature entry %u to map", entry);
                delete creature;
                return 0;
            }

            map->Add(creature);
        }
    }

    return guid;
}

void ObjectMgr::LoadGameobjects()
{
    uint32 count = 0;

    //                                                       0                1   2    3           4           5           6
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT gameobject.guid, id, map, position_x, position_y, position_z, orientation,"
    //   7          8          9          10         11             12            13     14         15     16
        "rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state, spawnMask, event, pool_entry "
        "FROM gameobject LEFT OUTER JOIN game_event_gameobject ON gameobject.guid = game_event_gameobject.guid "
        "LEFT OUTER JOIN pool_gameobject ON gameobject.guid = pool_gameobject.guid");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded 0 gameobjects. DB table `gameobject` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 guid         = fields[ 0].GetUInt32();
        uint32 entry        = fields[ 1].GetUInt32();

        GameObjectInfo const* gInfo = GetGameObjectInfo(entry);
        if (!gInfo)
        {
            sLog.outLog(LOG_DB_ERR, "Table `gameobject` has gameobject (GUID: %u) with non existing gameobject entry %u, skipped.", guid, entry);
            continue;
        }


        GameObjectData& data = mGameObjectDataMap[guid];

        data.id             = entry;
        data.mapid          = fields[ 2].GetUInt32();
        data.posX           = fields[ 3].GetFloat();
        data.posY           = fields[ 4].GetFloat();
        data.posZ           = fields[ 5].GetFloat();
        data.orientation    = fields[ 6].GetFloat();
        data.rotation0      = fields[ 7].GetFloat();
        data.rotation1      = fields[ 8].GetFloat();
        data.rotation2      = fields[ 9].GetFloat();
        data.rotation3      = fields[10].GetFloat();
        data.spawntimesecs  = fields[11].GetInt32();
        data.animprogress   = fields[12].GetUInt32();
        data.ArtKit         = 0;
        data.spawnMask      = fields[14].GetUInt8();
        int16 gameEvent     = fields[15].GetInt16();
        int16 PoolId        = fields[16].GetInt16();

        uint32 go_state     = fields[13].GetUInt32();
        if (go_state >= MAX_GO_STATE)
        {
            sLog.outLog(LOG_DB_ERR, "Table `gameobject` have gameobject (GUID: %u Entry: %u) with invalid `state` (%u) value, skip",guid,data.id,go_state);
            continue;
        }
        data.go_state       = GOState(go_state);

        if (data.rotation2 < -1.0f || data.rotation2 > 1.0f)
        {
            sLog.outLog(LOG_DB_ERR, "Table `gameobject` have gameobject (GUID: %u Entry: %u) with invalid rotation2 (%f) value, skip",guid,data.id,data.rotation2 );
            continue;
        }

        if (data.rotation3 < -1.0f || data.rotation3 > 1.0f)
        {
            sLog.outLog(LOG_DB_ERR, "Table `gameobject` have gameobject (GUID: %u Entry: %u) with invalid rotation3 (%f) value, skip",guid,data.id,data.rotation3 );
            continue;
        }

        if (!MapManager::IsValidMapCoord(data.mapid,data.posX,data.posY,data.posZ,data.orientation))
        {
            sLog.outLog(LOG_DB_ERR, "Table `gameobject` have gameobject (GUID: %u Entry: %u) with invalid coordinates, skip",guid,data.id );
            continue;
        }

        if (gameEvent == 0 && PoolId == 0)                          // if not this is to be managed by GameEvent System
            AddGameobjectToGrid(guid, &data);
        ++count;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u gameobjects", mGameObjectDataMap.size());
}

void ObjectMgr::AddGameobjectToGrid(uint32 guid, GameObjectData const* data)
{
    uint8 mask = data->spawnMask;
    for (uint8 i = 0; mask != 0; i++, mask >>= 1)
    {
        if (mask & 1)
        {
            CellPair cell_pair = Looking4group::ComputeCellPair(data->posX, data->posY);
            uint32 cell_id = (cell_pair.y_coord*TOTAL_NUMBER_OF_CELLS_PER_MAP) + cell_pair.x_coord;

            CellObjectGuids& cell_guids = mMapObjectGuids[MAKE_PAIR32(data->mapid,i)][cell_id];
            cell_guids.gameobjects.insert(guid);
        }
    }
}

void ObjectMgr::RemoveGameobjectFromGrid(uint32 guid, GameObjectData const* data)
{
    uint8 mask = data->spawnMask;
    for (uint8 i = 0; mask != 0; i++, mask >>= 1)
    {
        if (mask & 1)
        {
            CellPair cell_pair = Looking4group::ComputeCellPair(data->posX, data->posY);
            uint32 cell_id = (cell_pair.y_coord*TOTAL_NUMBER_OF_CELLS_PER_MAP) + cell_pair.x_coord;

            CellObjectGuids& cell_guids = mMapObjectGuids[MAKE_PAIR32(data->mapid,i)][cell_id];
            cell_guids.gameobjects.erase(guid);
        }
    }
}

void ObjectMgr::LoadCreatureRespawnTimes()
{
    uint32 count = 0;

    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT guid,respawntime,instance FROM creature_respawn");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded 0 creature respawn time.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 loguid       = fields[0].GetUInt32();
        uint64 respawn_time = fields[1].GetUInt64();
        uint32 instance     = fields[2].GetUInt32();

        mCreatureRespawnTimes[MAKE_PAIR64(loguid,instance)] = time_t(respawn_time);

        ++count;
    } while (result->NextRow());

    sLog.outString(">> Loaded %u creature respawn times", mCreatureRespawnTimes.size());
    sLog.outString();
}

void ObjectMgr::LoadGameobjectRespawnTimes()
{
    // remove outdated data
    RealmDataDatabase.DirectExecute("DELETE FROM gameobject_respawn WHERE respawntime <= UNIX_TIMESTAMP()");

    uint32 count = 0;

    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT guid,respawntime,instance FROM gameobject_respawn");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded 0 gameobject respawn time.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 loguid       = fields[0].GetUInt32();
        uint64 respawn_time = fields[1].GetUInt64();
        uint32 instance     = fields[2].GetUInt32();

        mGORespawnTimes[MAKE_PAIR64(loguid,instance)] = time_t(respawn_time);

        ++count;
    } while (result->NextRow());

    sLog.outString(">> Loaded %u gameobject respawn times", mGORespawnTimes.size());
    sLog.outString();
}

// name must be checked to correctness (if received) before call this function
uint64 ObjectMgr::GetPlayerGUIDByName(std::string name) const
{
    uint64 guid = 0;

    RealmDataDatabase.escape_string(name);

    // Player name safe to sending to DB (checked at login) and this function using
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT guid FROM characters WHERE name = '%s'", name.c_str());
    if (result)
        guid = MAKE_NEW_GUID((*result)[0].GetUInt32(), 0, HIGHGUID_PLAYER);

    return guid;
}

bool ObjectMgr::GetPlayerNameByGUID(const uint64 &guid, std::string &name) const
{
    // prevent DB access for online player
    if (Player* player = GetPlayer(guid))
    {
        name = player->GetName();
        return true;
    }

    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT name FROM characters WHERE guid = '%u'", GUID_LOPART(guid));

    if (result)
    {
        name = (*result)[0].GetCppString();
        return true;
    }

    return false;
}

uint32 ObjectMgr::GetPlayerTeamByGUID(const uint64 &guid) const
{
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT race FROM characters WHERE guid = '%u'", GUID_LOPART(guid));

    if (result)
    {
        uint8 race = (*result)[0].GetUInt8();
        return Player::TeamForRace(race);
    }

    return 0;
}

uint32 ObjectMgr::GetPlayerAccountIdByGUID(const uint64 &guid) const
{
    if (!IS_PLAYER_GUID(guid))
        return 0;

    // prevent DB access for online player
    if(Player* player = GetPlayer(guid))
        return player->GetSession()->GetAccountId();

    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT account FROM characters WHERE guid = '%u'", GUID_LOPART(guid));
    if (result)
    {
        uint32 acc = (*result)[0].GetUInt32();
        return acc;
    }

    return 0;
}

uint32 ObjectMgr::GetPlayerAccountIdByPlayerName(const std::string& name) const
{
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT account FROM characters WHERE name = '%s'", name.c_str());
    if (result)
    {
        uint32 acc = (*result)[0].GetUInt32();
        return acc;
    }

    return 0;
}

void ObjectMgr::LoadItemLocales()
{
    mItemLocaleMap.clear();                                 // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry,name_loc1,description_loc1,name_loc2,description_loc2,name_loc3,description_loc3,name_loc4,description_loc4,name_loc5,description_loc5,name_loc6,description_loc6,name_loc7,description_loc7,name_loc8,description_loc8 FROM locales_item");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outString(">> Loaded 0 Item locale strings. DB table `locales_item` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 entry = fields[0].GetUInt32();

        ItemLocale& data = mItemLocaleMap[entry];

        for (int i = 1; i < MAX_LOCALE; ++i)
        {
            std::string str = fields[1+2*(i-1)].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.Name.size() <= idx)
                        data.Name.resize(idx+1);

                    data.Name[idx] = str;
                }
            }

            str = fields[1+2*(i-1)+1].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.Description.size() <= idx)
                        data.Description.resize(idx+1);

                    data.Description[idx] = str;
                }
            }
        }
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u Item locale strings", mItemLocaleMap.size());
}

struct SQLItemLoader : public SQLStorageLoaderBase<SQLItemLoader>
{
    template<class D>
    void convert_from_str(uint32 field_pos, const char *src, D &dst)
    {
        dst = D(sScriptMgr.GetScriptId(src));
    }
};

void ObjectMgr::LoadItemPrototypes()
{
    SQLItemLoader loader;
    loader.Load(sItemStorage);
    sLog.outString(">> Loaded %u item prototypes", sItemStorage.RecordCount);
    sLog.outString();

    // check data correctness
    for (uint32 i = 1; i < sItemStorage.MaxEntry; ++i)
    {
        ItemPrototype const* proto = sItemStorage.LookupEntry<ItemPrototype >(i);
        ItemEntry const *dbcitem = sItemStore.LookupEntry(i);
        if (!proto)
        {
            /* to many errors, and possible not all items really used in game
            if (dbcitem)
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) doesn't exists in DB, but must exist.",i);
            */
            continue;
        }

        if (dbcitem)
        {
            if (proto->InventoryType != dbcitem->InventoryType)
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) not correct %u inventory type, must be %u (still using DB value).",i,proto->InventoryType,dbcitem->InventoryType);
                // It safe let use InventoryType from DB
            }

            if (proto->DisplayInfoID != dbcitem->DisplayId)
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) not correct %u display id, must be %u (using it).",i,proto->DisplayInfoID,dbcitem->DisplayId);
                const_cast<ItemPrototype*>(proto)->DisplayInfoID = dbcitem->DisplayId;
            }
            if (proto->Sheath != dbcitem->Sheath)
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) not correct %u sheath, must be %u  (using it).",i,proto->Sheath,dbcitem->Sheath);
                const_cast<ItemPrototype*>(proto)->Sheath = dbcitem->Sheath;
            }
        }
        else
        {
            sLog.outLog(LOG_DEFAULT, "WARNING: Item (Entry: %u) not listed in list of existed items. Maybe Custom Item?",i);
        }

        if (proto->Class >= MAX_ITEM_CLASS)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong Class value (%u)",i,proto->Class);
            const_cast<ItemPrototype*>(proto)->Class = ITEM_CLASS_JUNK;
        }

        if (proto->SubClass >= MaxItemSubclassValues[proto->Class])
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong Subclass value (%u) for class %u",i,proto->SubClass,proto->Class);
            const_cast<ItemPrototype*>(proto)->SubClass = 0;// exist for all item classes
        }

        if (proto->Quality >= MAX_ITEM_QUALITY)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong Quality value (%u)",i,proto->Quality);
            const_cast<ItemPrototype*>(proto)->Quality = ITEM_QUALITY_NORMAL;
        }

        if (proto->BuyCount <= 0)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong BuyCount value (%u), set to default(1).",i,proto->BuyCount);
            const_cast<ItemPrototype*>(proto)->BuyCount = 1;
        }

        if (proto->InventoryType >= MAX_INVTYPE)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong InventoryType value (%u)",i,proto->InventoryType);
            const_cast<ItemPrototype*>(proto)->InventoryType = INVTYPE_NON_EQUIP;
        }

        if (proto->RequiredSkill >= MAX_SKILL_TYPE)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong RequiredSkill value (%u)",i,proto->RequiredSkill);
            const_cast<ItemPrototype*>(proto)->RequiredSkill = 0;
        }

        {
            // can be used in equip slot, as page read use in inventory, or spell casting at use
            bool req = proto->InventoryType!=INVTYPE_NON_EQUIP || proto->PageText;
            if(!req)
            {
                for (int j = 0; j < MAX_ITEM_PROTO_SPELLS; ++j)
                {
                    if(proto->Spells[j].SpellId)
                    {
                        req = true;
                        break;
                    }
                }
            }

            if(req)
            {
                if(!(proto->AllowableClass & CLASSMASK_ALL_PLAYABLE))
                    sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) not have in `AllowableClass` any playable classes (%u) and can't be equipped or use.",i,proto->AllowableClass);

                if(!(proto->AllowableRace & RACEMASK_ALL_PLAYABLE))
                    sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) not have in `AllowableRace` any playable races (%u) and can't be equipped or use.",i,proto->AllowableRace);
            }
        }

        if (proto->RequiredSpell && !sSpellStore.LookupEntry(proto->RequiredSpell))
       {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) have wrong (non-existed) spell in RequiredSpell (%u)",i,proto->RequiredSpell);
            const_cast<ItemPrototype*>(proto)->RequiredSpell = 0;
        }

        if (proto->RequiredReputationRank >= MAX_REPUTATION_RANK)
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong reputation rank in RequiredReputationRank (%u), item can't be used.",i,proto->RequiredReputationRank);

        if (proto->RequiredReputationFaction)
        {
            if (!sFactionStore.LookupEntry(proto->RequiredReputationFaction))
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong (not existing) faction in RequiredReputationFaction (%u)",i,proto->RequiredReputationFaction);
                const_cast<ItemPrototype*>(proto)->RequiredReputationFaction = 0;
            }

            if (proto->RequiredReputationRank == MIN_REPUTATION_RANK)
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has min. reputation rank in RequiredReputationRank (0) but RequiredReputationFaction > 0, faction setting is useless.",i);
        }
        else if (proto->RequiredReputationRank > MIN_REPUTATION_RANK)
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has RequiredReputationFaction ==0 but RequiredReputationRank > 0, rank setting is useless.",i);

        if (proto->Stackable==0)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong value in stackable (%u), replace by default 1.",i,proto->Stackable);
            const_cast<ItemPrototype*>(proto)->Stackable = 1;
        }
        else if (proto->Stackable > 255)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has too large value in stackable (%u), replace by hardcoded upper limit (255).",i,proto->Stackable);
            const_cast<ItemPrototype*>(proto)->Stackable = 255;
        }

        if (proto->ContainerSlots > MAX_BAG_SIZE)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has too large value in ContainerSlots (%u), replace by hardcoded limit (%u).",i,proto->ContainerSlots,MAX_BAG_SIZE);
            const_cast<ItemPrototype*>(proto)->ContainerSlots = MAX_BAG_SIZE;
        }

        for (int j = 0; j < MAX_ITEM_PROTO_STATS; ++j)
        {
            // for ItemStatValue != 0
            if (proto->ItemStat[j].ItemStatValue && proto->ItemStat[j].ItemStatType >= MAX_ITEM_MOD)
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong stat_type%d (%u)",i,j+1,proto->ItemStat[j].ItemStatType);
                const_cast<ItemPrototype*>(proto)->ItemStat[j].ItemStatType = 0;
            }
        }

        for (int j = 0; j < MAX_ITEM_PROTO_DAMAGES; ++j)
        {
            if (proto->Damage[j].DamageType >= MAX_SPELL_SCHOOL)
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong dmg_type%d (%u)",i,j+1,proto->Damage[j].DamageType);
                const_cast<ItemPrototype*>(proto)->Damage[j].DamageType = 0;
            }
        }

        // special format
        if (proto->Spells[0].SpellId == SPELL_ID_GENERIC_LEARN)
        {
            // spell_1
            if (proto->Spells[0].SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong item spell trigger value in spelltrigger_%d (%u) for special learning format",i,0+1,proto->Spells[0].SpellTrigger);
                const_cast<ItemPrototype*>(proto)->Spells[0].SpellId = 0;
                const_cast<ItemPrototype*>(proto)->Spells[0].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                const_cast<ItemPrototype*>(proto)->Spells[1].SpellId = 0;
                const_cast<ItemPrototype*>(proto)->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
            }

            // spell_2 have learning spell
            if (proto->Spells[1].SpellTrigger != ITEM_SPELLTRIGGER_LEARN_SPELL_ID)
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong item spell trigger value in spelltrigger_%d (%u) for special learning format.",i,1+1,proto->Spells[1].SpellTrigger);
                const_cast<ItemPrototype*>(proto)->Spells[0].SpellId = 0;
                const_cast<ItemPrototype*>(proto)->Spells[1].SpellId = 0;
                const_cast<ItemPrototype*>(proto)->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
            }
            else if (!proto->Spells[1].SpellId)
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) not has expected spell in spellid_%d in special learning format.",i,1+1);
                const_cast<ItemPrototype*>(proto)->Spells[0].SpellId = 0;
                const_cast<ItemPrototype*>(proto)->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
            }
            else
            {
                SpellEntry const* spellInfo = sSpellStore.LookupEntry(proto->Spells[1].SpellId);
                if (!spellInfo)
                {
                    sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong (not existing) spell in spellid_%d (%u)",i,1+1,proto->Spells[1].SpellId);
                    const_cast<ItemPrototype*>(proto)->Spells[0].SpellId = 0;
                    const_cast<ItemPrototype*>(proto)->Spells[1].SpellId = 0;
                    const_cast<ItemPrototype*>(proto)->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }
                // allowed only in special format
                else if (proto->Spells[1].SpellId==SPELL_ID_GENERIC_LEARN)
                {
                    sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has broken spell in spellid_%d (%u)",i,1+1,proto->Spells[1].SpellId);
                    const_cast<ItemPrototype*>(proto)->Spells[0].SpellId = 0;
                    const_cast<ItemPrototype*>(proto)->Spells[1].SpellId = 0;
                    const_cast<ItemPrototype*>(proto)->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }
            }

            // spell_3*,spell_4*,spell_5* is empty
            for (int j = 2; j < MAX_ITEM_PROTO_SPELLS; j++)
            {
                if (proto->Spells[j].SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
                {
                    sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong item spell trigger value in spelltrigger_%d (%u)",i,j+1,proto->Spells[j].SpellTrigger);
                    const_cast<ItemPrototype*>(proto)->Spells[j].SpellId = 0;
                    const_cast<ItemPrototype*>(proto)->Spells[j].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }
                else if (proto->Spells[j].SpellId != 0)
                {
                    sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong spell in spellid_%d (%u) for learning special format",i,j+1,proto->Spells[j].SpellId);
                    const_cast<ItemPrototype*>(proto)->Spells[j].SpellId = 0;
                }
            }
        }
        // normal spell list
        else
        {
            for (int j = 0; j < MAX_ITEM_PROTO_SPELLS; j++)
            {
                if (proto->Spells[j].SpellTrigger >= MAX_ITEM_SPELLTRIGGER || proto->Spells[j].SpellTrigger == ITEM_SPELLTRIGGER_LEARN_SPELL_ID)
                {
                    sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong item spell trigger value in spelltrigger_%d (%u)",i,j+1,proto->Spells[j].SpellTrigger);
                    const_cast<ItemPrototype*>(proto)->Spells[j].SpellId = 0;
                    const_cast<ItemPrototype*>(proto)->Spells[j].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }

                if (proto->Spells[j].SpellId)
                {
                    SpellEntry const* spellInfo = sSpellStore.LookupEntry(proto->Spells[j].SpellId);
                    if (!spellInfo)
                    {
                        sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong (not existing) spell in spellid_%d (%u)",i,j+1,proto->Spells[j].SpellId);
                        const_cast<ItemPrototype*>(proto)->Spells[j].SpellId = 0;
                    }
                    // allowed only in special format
                    else if (proto->Spells[j].SpellId==SPELL_ID_GENERIC_LEARN)
                    {
                        sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has broken spell in spellid_%d (%u)",i,j+1,proto->Spells[j].SpellId);
                        const_cast<ItemPrototype*>(proto)->Spells[j].SpellId = 0;
                    }
                    else if (proto->Spells[j].SpellCategory)
                    {
                        sSpellCategoryStore[proto->Spells[j].SpellCategory].insert(proto->Spells[j].SpellId);
                    }
                }
            }
        }

        if (proto->Bonding >= MAX_BIND_TYPE)
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong Bonding value (%u)",i,proto->Bonding);

        if (proto->PageText && !sPageTextStore.LookupEntry<PageText>(proto->PageText))
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has non existing first page (Id:%u)", i,proto->PageText);

        if (proto->LockID && !sLockStore.LookupEntry(proto->LockID))
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong LockID (%u)",i,proto->LockID);

        if (proto->Sheath >= MAX_SHEATHETYPE)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong Sheath (%u)",i,proto->Sheath);
            const_cast<ItemPrototype*>(proto)->Sheath = SHEATHETYPE_NONE;
        }

        if (proto->RandomProperty && !sItemRandomPropertiesStore.LookupEntry(GetItemEnchantMod(proto->RandomProperty)))
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has unknown (wrong or not listed in `item_enchantment_template`) RandomProperty (%u)",i,proto->RandomProperty);
            const_cast<ItemPrototype*>(proto)->RandomProperty = 0;
        }

        if (proto->RandomSuffix && !sItemRandomSuffixStore.LookupEntry(GetItemEnchantMod(proto->RandomSuffix)))
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong RandomSuffix (%u)",i,proto->RandomSuffix);
            const_cast<ItemPrototype*>(proto)->RandomSuffix = 0;
        }

        if (proto->ItemSet && !sItemSetStore.LookupEntry(proto->ItemSet))
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) have wrong ItemSet (%u)",i,proto->ItemSet);
            const_cast<ItemPrototype*>(proto)->ItemSet = 0;
        }

        if (proto->Area && !GetAreaEntryByAreaID(proto->Area))
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong Area (%u)",i,proto->Area);

        if (proto->Map && !sMapStore.LookupEntry(proto->Map))
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong Map (%u)",i,proto->Map);

        if (proto->BagFamily)
        {
            // check bits
            for(uint32 j = 0; j < sizeof(proto->BagFamily)*8; ++j)
            {
                uint32 mask = 1 << j;
                if((proto->BagFamily & mask)==0)
                    continue;

                ItemBagFamilyEntry const* bf = sItemBagFamilyStore.LookupEntry(j+1);
                if(!bf)
                {
                    sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has bag family bit set not listed in ItemBagFamily.dbc, remove bit", j);
                    const_cast<ItemPrototype*>(proto)->BagFamily &= ~mask;
                }
            }
        }

        if (proto->TotemCategory && !sTotemCategoryStore.LookupEntry(proto->TotemCategory))
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong TotemCategory (%u)",i,proto->TotemCategory);

        for (int j = 0; j < MAX_ITEM_PROTO_SOCKETS; j++)
        {
            if (proto->Socket[j].Color && (proto->Socket[j].Color & SOCKET_COLOR_ALL) != proto->Socket[j].Color)
            {
                sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong socketColor_%d (%u)",i,j+1,proto->Socket[j].Color);
                const_cast<ItemPrototype*>(proto)->Socket[j].Color = 0;
            }
        }

        if (proto->GemProperties && !sGemPropertiesStore.LookupEntry(proto->GemProperties))
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong GemProperties (%u)",i,proto->GemProperties);

        if (proto->FoodType >= MAX_PET_DIET)
        {
            sLog.outLog(LOG_DB_ERR, "Item (Entry: %u) has wrong FoodType value (%u)",i,proto->FoodType);
            const_cast<ItemPrototype*>(proto)->FoodType = 0;
        }
    }

    // this DBC used currently only for check item templates in DB.
    sItemStore.Clear();
}

void ObjectMgr::LoadPetLevelInfo()
{
    // Loading levels data
    {
        //                                                        0               1      2   3     4    5    6    7     8    9
        QueryResultAutoPtr result  = GameDataDatabase.Query("SELECT creature_entry, level, hp, mana, str, agi, sta, inte, spi, armor FROM pet_levelstats");

        uint32 count = 0;

        if (!result)
        {
            BarGoLink bar(1);

            sLog.outString();
            sLog.outString(">> Loaded %u level pet stats definitions", count);
            sLog.outLog(LOG_DB_ERR, "Error loading `pet_levelstats` table or empty table.");
            return;
        }

        BarGoLink bar(result->GetRowCount());

        do
        {
            Field* fields = result->Fetch();

            uint32 creature_id = fields[0].GetUInt32();
            if (!sCreatureStorage.LookupEntry<CreatureInfo>(creature_id))
            {
                sLog.outLog(LOG_DB_ERR, "Wrong creature id %u in `pet_levelstats` table, ignoring.",creature_id);
                continue;
            }

            uint32 current_level = fields[1].GetUInt32();
            if (current_level > sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
            {
                if (current_level > STRONG_MAX_LEVEL)        // hardcoded level maximum
                    sLog.outLog(LOG_DB_ERR, "Wrong (> %u) level %u in `pet_levelstats` table, ignoring.",STRONG_MAX_LEVEL,current_level);
                else
                    sLog.outDetail("Unused (> MaxPlayerLevel in Trinityd.conf) level %u in `pet_levelstats` table, ignoring.",current_level);
                continue;
            }
            else if (current_level < 1)
            {
                sLog.outLog(LOG_DB_ERR, "Wrong (<1) level %u in `pet_levelstats` table, ignoring.",current_level);
                continue;
            }

            PetLevelInfo*& pInfoMapEntry = petInfo[creature_id];

            if (pInfoMapEntry==NULL)
                pInfoMapEntry =  new PetLevelInfo[sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL)];

            // data for level 1 stored in [0] array element, ...
            PetLevelInfo* pLevelInfo = &pInfoMapEntry[current_level-1];

            pLevelInfo->health = fields[2].GetUInt16();
            pLevelInfo->mana   = fields[3].GetUInt16();
            pLevelInfo->armor  = fields[9].GetUInt16();

            for (int i = 0; i < MAX_STATS; i++)
            {
                pLevelInfo->stats[i] = fields[i+4].GetUInt16();
            }

            bar.step();
            ++count;
        }
        while (result->NextRow());

        sLog.outString();
        sLog.outString(">> Loaded %u level pet stats definitions", count);
    }

    // Fill gaps and check integrity
    for (PetLevelInfoMap::iterator itr = petInfo.begin(); itr != petInfo.end(); ++itr)
    {
        PetLevelInfo* pInfo = itr->second;

        // fatal error if no level 1 data
        if (!pInfo || pInfo[0].health == 0)
        {
            sLog.outLog(LOG_DB_ERR, "Creature %u does not have pet stats data for Level 1!",itr->first);
            exit(1);
        }

        // fill level gaps
        for (uint32 level = 1; level < sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL); ++level)
        {
            if (pInfo[level].health == 0)
            {
                sLog.outLog(LOG_DB_ERR, "Creature %u has no data for Level %i pet stats data, using data of Level %i.",itr->first,level+1, level);
                pInfo[level] = pInfo[level-1];
            }
        }
    }
}

PetLevelInfo const* ObjectMgr::GetPetLevelInfo(uint32 creature_id, uint32 level) const
{
    if (level > sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
        level = sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL);

    PetLevelInfoMap::const_iterator itr = petInfo.find(creature_id);
    if (itr == petInfo.end())
        return NULL;
        
    if (level < 1)
        return NULL;

    return &itr->second[level-1];                           // data for level 1 stored in [0] array element, ...
}

void ObjectMgr::LoadPlayerInfo()
{
    // Load playercreate
    {
        //                                                       0     1      2    3     4           5           6
        QueryResultAutoPtr result = GameDataDatabase.Query("SELECT race, class, map, zone, position_x, position_y, position_z FROM playercreateinfo");

        uint32 count = 0;

        if (!result)
        {
            BarGoLink bar(1);

            sLog.outString();
            sLog.outString(">> Loaded %u player create definitions", count);
            sLog.outLog(LOG_DB_ERR, "Error loading `playercreateinfo` table or empty table.");
            exit(1);
        }

        BarGoLink bar(result->GetRowCount());

        do
        {
            Field* fields = result->Fetch();

            uint32 current_race = fields[0].GetUInt32();
            uint32 current_class = fields[1].GetUInt32();
            uint32 mapId     = fields[2].GetUInt32();
            uint32 zoneId    = fields[3].GetUInt32();
            float  positionX = fields[4].GetFloat();
            float  positionY = fields[5].GetFloat();
            float  positionZ = fields[6].GetFloat();

            if (current_race >= MAX_RACES)
            {
                sLog.outLog(LOG_DB_ERR, "Wrong race %u in `playercreateinfo` table, ignoring.",current_race);
                continue;
            }

            ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(current_race);
            if (!rEntry)
            {
                sLog.outLog(LOG_DB_ERR, "Wrong race %u in `playercreateinfo` table, ignoring.",current_race);
                continue;
            }

            if (current_class >= MAX_CLASSES)
            {
                sLog.outLog(LOG_DB_ERR, "Wrong class %u in `playercreateinfo` table, ignoring.",current_class);
                continue;
            }

            if (!sChrClassesStore.LookupEntry(current_class))
            {
                sLog.outLog(LOG_DB_ERR, "Wrong class %u in `playercreateinfo` table, ignoring.",current_class);
                continue;
            }

            // accept DB data only for valid position (and non instanceable)
            if (!MapManager::IsValidMapCoord(mapId,positionX,positionY,positionZ))
            {
                sLog.outLog(LOG_DB_ERR, "Wrong home position for class %u race %u pair in `playercreateinfo` table, ignoring.",current_class,current_race);
                continue;
            }

            if (sMapStore.LookupEntry(mapId)->Instanceable())
            {
                sLog.outLog(LOG_DB_ERR, "Home position in instanceable map for class %u race %u pair in `playercreateinfo` table, ignoring.",current_class,current_race);
                continue;
            }

            PlayerInfo* pInfo = &playerInfo[current_race][current_class];

            pInfo->mapId     = mapId;
            pInfo->zoneId    = zoneId;
            pInfo->positionX = positionX;
            pInfo->positionY = positionY;
            pInfo->positionZ = positionZ;

            pInfo->displayId_m = rEntry->model_m;
            pInfo->displayId_f = rEntry->model_f;

            bar.step();
            ++count;
        }
        while (result->NextRow());

        sLog.outString();
        sLog.outString(">> Loaded %u player create definitions", count);
    }

    // Load playercreate items
    {
        //                                                       0     1      2       3
        QueryResultAutoPtr result = GameDataDatabase.Query("SELECT race, class, itemid, amount FROM playercreateinfo_item");

        uint32 count = 0;

        if (!result)
        {
            BarGoLink bar(1);

            bar.step();

            sLog.outString();
            sLog.outString(">> Loaded %u custom player create items", count);
        }
        else
        {
            BarGoLink bar(result->GetRowCount());

            do
            {
                Field* fields = result->Fetch();

                uint32 current_race = fields[0].GetUInt32();
                if (current_race >= MAX_RACES)
                {
                    sLog.outLog(LOG_DB_ERR, "Wrong race %u in `playercreateinfo_item` table, ignoring.",current_race);
                    continue;
                }

                uint32 current_class = fields[1].GetUInt32();
                if (current_class >= MAX_CLASSES)
                {
                    sLog.outLog(LOG_DB_ERR, "Wrong class %u in `playercreateinfo_item` table, ignoring.",current_class);
                    continue;
                }

                PlayerInfo* pInfo = &playerInfo[current_race][current_class];

                uint32 item_id = fields[2].GetUInt32();

                if (!GetItemPrototype(item_id))
                {
                    sLog.outLog(LOG_DB_ERR, "Item id %u (race %u class %u) in `playercreateinfo_item` table but not listed in `item_template`, ignoring.",item_id,current_race,current_class);
                    continue;
                }

                uint32 amount  = fields[3].GetUInt32();

                if (!amount)
                {
                    sLog.outLog(LOG_DB_ERR, "Item id %u (class %u race %u) have amount==0 in `playercreateinfo_item` table, ignoring.",item_id,current_race,current_class);
                    continue;
                }

                pInfo->item.push_back(PlayerCreateInfoItem(item_id, amount));

                bar.step();
                ++count;
            }
            while (result->NextRow());

            sLog.outString();
            sLog.outString(">> Loaded %u custom player create items", count);
        }
    }

    // Load playercreate spells
    {

        QueryResultAutoPtr result = QueryResultAutoPtr(NULL);
        if (sWorld.getConfig(CONFIG_START_ALL_SPELLS))
            result = GameDataDatabase.Query("SELECT race, class, Spell, Active FROM playercreateinfo_spell_custom");
        else
            result = GameDataDatabase.Query("SELECT race, class, Spell, Active FROM playercreateinfo_spell");

        uint32 count = 0;

        if (!result)
        {
            BarGoLink bar(1);

            sLog.outString();
            sLog.outString(">> Loaded %u player create spells", count);
            sLog.outLog(LOG_DB_ERR, "Error loading player starting spells or empty table.");
        }
        else
        {
            BarGoLink bar(result->GetRowCount());

            do
            {
                Field* fields = result->Fetch();

                uint32 current_race = fields[0].GetUInt32();
                if (current_race >= MAX_RACES)
                {
                    sLog.outLog(LOG_DB_ERR, "Wrong race %u in `playercreateinfo_spell` table, ignoring.",current_race);
                    continue;
                }

                uint32 current_class = fields[1].GetUInt32();
                if (current_class >= MAX_CLASSES)
                {
                    sLog.outLog(LOG_DB_ERR, "Wrong class %u in `playercreateinfo_spell` table, ignoring.",current_class);
                    continue;
                }

                PlayerInfo* pInfo = &playerInfo[current_race][current_class];
                pInfo->spell.push_back(CreateSpellPair(fields[2].GetUInt16(), fields[3].GetUInt8()));

                bar.step();
                ++count;
            }
            while (result->NextRow());

            sLog.outString();
            sLog.outString(">> Loaded %u player create spells", count);
        }
    }

    // Load playercreate actions
    {
        //                                                0     1      2       3       4     5
        QueryResultAutoPtr result = GameDataDatabase.Query("SELECT race, class, button, action, type, misc FROM playercreateinfo_action");

        uint32 count = 0;

        if (!result)
        {
            BarGoLink bar(1);

            sLog.outString();
            sLog.outString(">> Loaded %u player create actions", count);
            sLog.outLog(LOG_DB_ERR, "Error loading `playercreateinfo_action` table or empty table.");
        }
        else
        {
            BarGoLink bar(result->GetRowCount());

            do
            {
                Field* fields = result->Fetch();

                uint32 current_race = fields[0].GetUInt32();
                if (current_race >= MAX_RACES)
                {
                    sLog.outLog(LOG_DB_ERR, "Wrong race %u in `playercreateinfo_action` table, ignoring.",current_race);
                    continue;
                }

                uint32 current_class = fields[1].GetUInt32();
                if (current_class >= MAX_CLASSES)
                {
                    sLog.outLog(LOG_DB_ERR, "Wrong class %u in `playercreateinfo_action` table, ignoring.",current_class);
                    continue;
                }

                PlayerInfo* pInfo = &playerInfo[current_race][current_class];
                pInfo->action[0].push_back(fields[2].GetUInt16());
                pInfo->action[1].push_back(fields[3].GetUInt16());
                pInfo->action[2].push_back(fields[4].GetUInt16());
                pInfo->action[3].push_back(fields[5].GetUInt16());

                bar.step();
                ++count;
            }
            while (result->NextRow());

            sLog.outString();
            sLog.outString(">> Loaded %u player create actions", count);
        }
    }

    // Loading levels data (class only dependent)
    {
        //                                                 0      1      2       3
        QueryResultAutoPtr result  = GameDataDatabase.Query("SELECT class, level, basehp, basemana FROM player_classlevelstats");

        uint32 count = 0;

        if (!result)
        {
            BarGoLink bar(1);

            sLog.outString();
            sLog.outString(">> Loaded %u level health/mana definitions", count);
            sLog.outLog(LOG_DB_ERR, "Error loading `player_classlevelstats` table or empty table.");
            exit(1);
        }

        BarGoLink bar(result->GetRowCount());

        do
        {
            Field* fields = result->Fetch();

            uint32 current_class = fields[0].GetUInt32();
            if (current_class >= MAX_CLASSES)
            {
                sLog.outLog(LOG_DB_ERR, "Wrong class %u in `player_classlevelstats` table, ignoring.",current_class);
                continue;
            }

            uint32 current_level = fields[1].GetUInt32();
            if (current_level > sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
            {
                if (current_level > STRONG_MAX_LEVEL)        // hardcoded level maximum
                    sLog.outLog(LOG_DB_ERR, "Wrong (> %u) level %u in `player_classlevelstats` table, ignoring.",STRONG_MAX_LEVEL,current_level);
                else
                    sLog.outDetail("Unused (> MaxPlayerLevel in Trinityd.conf) level %u in `player_classlevelstats` table, ignoring.",current_level);
                continue;
            }

            PlayerClassInfo* pClassInfo = &playerClassInfo[current_class];

            if (!pClassInfo->levelInfo)
                pClassInfo->levelInfo = new PlayerClassLevelInfo[sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL)];

            PlayerClassLevelInfo* pClassLevelInfo = &pClassInfo->levelInfo[current_level-1];

            pClassLevelInfo->basehealth = fields[2].GetUInt16();
            pClassLevelInfo->basemana   = fields[3].GetUInt16();

            bar.step();
            ++count;
        }
        while (result->NextRow());

        sLog.outString();
        sLog.outString(">> Loaded %u level health/mana definitions", count);
    }

    // Fill gaps and check integrity
    for (int class_ = 0; class_ < MAX_CLASSES; ++class_)
    {
        // skip non existed classes
        if (!sChrClassesStore.LookupEntry(class_))
            continue;

        PlayerClassInfo* pClassInfo = &playerClassInfo[class_];

        // fatal error if no level 1 data
        if (!pClassInfo->levelInfo || pClassInfo->levelInfo[0].basehealth == 0)
        {
            sLog.outLog(LOG_DB_ERR, "Class %i Level 1 does not have health/mana data!",class_);
            exit(1);
        }

        // fill level gaps
        for (uint32 level = 1; level < sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL); ++level)
        {
            if (pClassInfo->levelInfo[level].basehealth == 0)
            {
                sLog.outLog(LOG_DB_ERR, "Class %i Level %i does not have health/mana data. Using stats data of level %i.",class_,level+1, level);
                pClassInfo->levelInfo[level] = pClassInfo->levelInfo[level-1];
            }
        }
    }

    // Loading levels data (class/race dependent)
    {
        //                                                        0     1      2      3    4    5    6    7
        QueryResultAutoPtr result  = GameDataDatabase.Query("SELECT race, class, level, str, agi, sta, inte, spi FROM player_levelstats");

        uint32 count = 0;

        if (!result)
        {
            BarGoLink bar(1);

            sLog.outString();
            sLog.outString(">> Loaded %u level stats definitions", count);
            sLog.outLog(LOG_DB_ERR, "Error loading `player_levelstats` table or empty table.");
            exit(1);
        }

        BarGoLink bar(result->GetRowCount());

        do
        {
            Field* fields = result->Fetch();

            uint32 current_race = fields[0].GetUInt32();
            if (current_race >= MAX_RACES)
            {
                sLog.outLog(LOG_DB_ERR, "Wrong race %u in `player_levelstats` table, ignoring.",current_race);
                continue;
            }

            uint32 current_class = fields[1].GetUInt32();
            if (current_class >= MAX_CLASSES)
            {
                sLog.outLog(LOG_DB_ERR, "Wrong class %u in `player_levelstats` table, ignoring.",current_class);
                continue;
            }

            uint32 current_level = fields[2].GetUInt32();
            if (current_level > sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
            {
                if (current_level > STRONG_MAX_LEVEL)        // hardcoded level maximum
                    sLog.outLog(LOG_DB_ERR, "Wrong (> %u) level %u in `player_levelstats` table, ignoring.",STRONG_MAX_LEVEL,current_level);
                else
                    sLog.outDetail("Unused (> MaxPlayerLevel in Trinityd.conf) level %u in `player_levelstats` table, ignoring.",current_level);
                continue;
            }

            PlayerInfo* pInfo = &playerInfo[current_race][current_class];

            if (!pInfo->levelInfo)
                pInfo->levelInfo = new PlayerLevelInfo[sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL)];

            PlayerLevelInfo* pLevelInfo = &pInfo->levelInfo[current_level-1];

            for (int i = 0; i < MAX_STATS; i++)
            {
                pLevelInfo->stats[i] = fields[i+3].GetUInt8();
            }

            bar.step();
            ++count;
        }
        while (result->NextRow());

        sLog.outString();
        sLog.outString(">> Loaded %u level stats definitions", count);
    }

    // Fill gaps and check integrity
    for (int race = 0; race < MAX_RACES; ++race)
    {
        // skip non existed races
        if (!sChrRacesStore.LookupEntry(race))
            continue;

        for (int class_ = 0; class_ < MAX_CLASSES; ++class_)
        {
            // skip non existed classes
            if (!sChrClassesStore.LookupEntry(class_))
                continue;

            PlayerInfo* pInfo = &playerInfo[race][class_];

            // skip non loaded combinations
            if (!pInfo->displayId_m || !pInfo->displayId_f)
                continue;

            // skip expansion races if not playing with expansion
            if (sWorld.getConfig(CONFIG_EXPANSION) < 1 && (race == RACE_BLOODELF || race == RACE_DRAENEI))
                continue;

            // skip expansion classes if not playing with expansion
            if (sWorld.getConfig(CONFIG_EXPANSION) < 2 && class_ == CLASS_DEATH_KNIGHT)
                continue;

            // fatal error if no level 1 data
            if (!pInfo->levelInfo || pInfo->levelInfo[0].stats[0] == 0)
            {
                sLog.outLog(LOG_DB_ERR, "Race %i Class %i Level 1 does not have stats data!",race,class_);
                exit(1);
            }

            // fill level gaps
            for (uint32 level = 1; level < sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL); ++level)
            {
                if (pInfo->levelInfo[level].stats[0] == 0)
                {
                    sLog.outLog(LOG_DB_ERR, "Race %i Class %i Level %i does not have stats data. Using stats data of level %i.",race,class_,level+1, level);
                    pInfo->levelInfo[level] = pInfo->levelInfo[level-1];
                }
            }
        }
    }
}

void ObjectMgr::GetPlayerClassLevelInfo(uint32 class_, uint32 level, PlayerClassLevelInfo* info) const
{
    if (level < 1 || class_ >= MAX_CLASSES)
        return;

    PlayerClassInfo const* pInfo = &playerClassInfo[class_];

    if (level > sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
        level = sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL);

    *info = pInfo->levelInfo[level-1];
}

void ObjectMgr::GetPlayerLevelInfo(uint32 race, uint32 class_, uint32 level, PlayerLevelInfo* info) const
{
    if (level < 1 || race   >= MAX_RACES || class_ >= MAX_CLASSES)
        return;

    PlayerInfo const* pInfo = &playerInfo[race][class_];
    if (pInfo->displayId_m==0 || pInfo->displayId_f==0)
        return;

    if (level <= sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL))
        *info = pInfo->levelInfo[level-1];
    else
        BuildPlayerLevelInfo(race,class_,level,info);
}

void ObjectMgr::BuildPlayerLevelInfo(uint8 race, uint8 _class, uint8 level, PlayerLevelInfo* info) const
{
    // base data (last known level)
    *info = playerInfo[race][_class].levelInfo[sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL)-1];

    for (int lvl = sWorld.getConfig(CONFIG_MAX_PLAYER_LEVEL)-1; lvl < level; ++lvl)
    {
        switch (_class)
        {
            case CLASS_WARRIOR:
                info->stats[STAT_STRENGTH]  += (lvl > 23 ? 2: (lvl > 1  ? 1: 0));
                info->stats[STAT_STAMINA]   += (lvl > 23 ? 2: (lvl > 1  ? 1: 0));
                info->stats[STAT_AGILITY]   += (lvl > 36 ? 1: (lvl > 6 && (lvl%2) ? 1: 0));
                info->stats[STAT_INTELLECT] += (lvl > 9 && !(lvl%2) ? 1: 0);
                info->stats[STAT_SPIRIT]    += (lvl > 9 && !(lvl%2) ? 1: 0);
                break;
            case CLASS_PALADIN:
                info->stats[STAT_STRENGTH]  += (lvl > 3  ? 1: 0);
                info->stats[STAT_STAMINA]   += (lvl > 33 ? 2: (lvl > 1 ? 1: 0));
                info->stats[STAT_AGILITY]   += (lvl > 38 ? 1: (lvl > 7 && !(lvl%2) ? 1: 0));
                info->stats[STAT_INTELLECT] += (lvl > 6 && (lvl%2) ? 1: 0);
                info->stats[STAT_SPIRIT]    += (lvl > 7 ? 1: 0);
                break;
            case CLASS_HUNTER:
                info->stats[STAT_STRENGTH]  += (lvl > 4  ? 1: 0);
                info->stats[STAT_STAMINA]   += (lvl > 4  ? 1: 0);
                info->stats[STAT_AGILITY]   += (lvl > 33 ? 2: (lvl > 1 ? 1: 0));
                info->stats[STAT_INTELLECT] += (lvl > 8 && (lvl%2) ? 1: 0);
                info->stats[STAT_SPIRIT]    += (lvl > 38 ? 1: (lvl > 9 && !(lvl%2) ? 1: 0));
                break;
            case CLASS_ROGUE:
                info->stats[STAT_STRENGTH]  += (lvl > 5  ? 1: 0);
                info->stats[STAT_STAMINA]   += (lvl > 4  ? 1: 0);
                info->stats[STAT_AGILITY]   += (lvl > 16 ? 2: (lvl > 1 ? 1: 0));
                info->stats[STAT_INTELLECT] += (lvl > 8 && !(lvl%2) ? 1: 0);
                info->stats[STAT_SPIRIT]    += (lvl > 38 ? 1: (lvl > 9 && !(lvl%2) ? 1: 0));
                break;
            case CLASS_PRIEST:
                info->stats[STAT_STRENGTH]  += (lvl > 9 && !(lvl%2) ? 1: 0);
                info->stats[STAT_STAMINA]   += (lvl > 5  ? 1: 0);
                info->stats[STAT_AGILITY]   += (lvl > 38 ? 1: (lvl > 8 && (lvl%2) ? 1: 0));
                info->stats[STAT_INTELLECT] += (lvl > 22 ? 2: (lvl > 1 ? 1: 0));
                info->stats[STAT_SPIRIT]    += (lvl > 3  ? 1: 0);
                break;
            case CLASS_SHAMAN:
                info->stats[STAT_STRENGTH]  += (lvl > 34 ? 1: (lvl > 6 && (lvl%2) ? 1: 0));
                info->stats[STAT_STAMINA]   += (lvl > 4 ? 1: 0);
                info->stats[STAT_AGILITY]   += (lvl > 7 && !(lvl%2) ? 1: 0);
                info->stats[STAT_INTELLECT] += (lvl > 5 ? 1: 0);
                info->stats[STAT_SPIRIT]    += (lvl > 4 ? 1: 0);
                break;
            case CLASS_MAGE:
                info->stats[STAT_STRENGTH]  += (lvl > 9 && !(lvl%2) ? 1: 0);
                info->stats[STAT_STAMINA]   += (lvl > 5  ? 1: 0);
                info->stats[STAT_AGILITY]   += (lvl > 9 && !(lvl%2) ? 1: 0);
                info->stats[STAT_INTELLECT] += (lvl > 24 ? 2: (lvl > 1 ? 1: 0));
                info->stats[STAT_SPIRIT]    += (lvl > 33 ? 2: (lvl > 2 ? 1: 0));
                break;
            case CLASS_WARLOCK:
                info->stats[STAT_STRENGTH]  += (lvl > 9 && !(lvl%2) ? 1: 0);
                info->stats[STAT_STAMINA]   += (lvl > 38 ? 2: (lvl > 3 ? 1: 0));
                info->stats[STAT_AGILITY]   += (lvl > 9 && !(lvl%2) ? 1: 0);
                info->stats[STAT_INTELLECT] += (lvl > 33 ? 2: (lvl > 2 ? 1: 0));
                info->stats[STAT_SPIRIT]    += (lvl > 38 ? 2: (lvl > 3 ? 1: 0));
                break;
            case CLASS_DRUID:
                info->stats[STAT_STRENGTH]  += (lvl > 38 ? 2: (lvl > 6 && (lvl%2) ? 1: 0));
                info->stats[STAT_STAMINA]   += (lvl > 32 ? 2: (lvl > 4 ? 1: 0));
                info->stats[STAT_AGILITY]   += (lvl > 38 ? 2: (lvl > 8 && (lvl%2) ? 1: 0));
                info->stats[STAT_INTELLECT] += (lvl > 38 ? 3: (lvl > 4 ? 1: 0));
                info->stats[STAT_SPIRIT]    += (lvl > 38 ? 3: (lvl > 5 ? 1: 0));
        }
    }
}

void ObjectMgr::LoadArenaTeams()
{
    uint32 count = 0;

    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT arenateamid FROM arena_team");

    if (!result)
    {

        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u arenateam definitions", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();

        bar.step();
        ++count;

        ArenaTeam *newarenateam = new ArenaTeam;
        if (!newarenateam->LoadArenaTeamFromDB(fields[0].GetUInt32()))
        {
            delete newarenateam;
            continue;
        }
        AddArenaTeam(newarenateam);
    }while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u arenateam definitions", count);
}

void ObjectMgr::LoadGroups()
{
    // -- loading groups --
    Group *group = NULL;
    uint64 leaderGuid = 0;
    uint32 count = 0;
    //                                                           0         1              2           3           4              5      6      7      8      9      10     11     12     13      14          15
    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT mainTank, mainAssistant, lootMethod, looterGuid, lootThreshold, icon1, icon2, icon3, icon4, icon5, icon6, icon7, icon8, isRaid, difficulty, leaderGuid FROM groups");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u group definitions", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        bar.step();
        Field *fields = result->Fetch();
        ++count;
        leaderGuid = MAKE_NEW_GUID(fields[15].GetUInt32(),0,HIGHGUID_PLAYER);

        group = new Group;
        if (!group->LoadGroupFromDB(leaderGuid, result, false))
        {
            group->Disband();
            delete group;
            continue;
        }
        AddGroup(group);
    }while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u group definitions", count);

    // -- loading members --
    count = 0;
    group = NULL;
    leaderGuid = 0;
    //                                        0           1          2         3
    result = RealmDataDatabase.Query("SELECT memberGuid, assistant, subgroup, leaderGuid FROM group_member ORDER BY leaderGuid");
    if (!result)
    {
        BarGoLink bar2(1);
        bar2.step();
    }
    else
    {
        BarGoLink bar2(result->GetRowCount());
        do
        {
            bar2.step();
            Field *fields = result->Fetch();
            count++;
            leaderGuid = MAKE_NEW_GUID(fields[3].GetUInt32(), 0, HIGHGUID_PLAYER);
            if (!group || group->GetLeaderGUID() != leaderGuid)
            {
                group = GetGroupByLeader(leaderGuid);
                if (!group)
                {
                    sLog.outLog(LOG_DB_ERR, "Incorrect entry in group_member table : no group with leader %d for member %d!", fields[3].GetUInt32(), fields[0].GetUInt32());
                    RealmDataDatabase.PExecute("DELETE FROM group_member WHERE memberGuid = '%d'", fields[0].GetUInt32());
                    continue;
                }
            }

            if (!group->LoadMemberFromDB(fields[0].GetUInt32(), fields[2].GetUInt8(), fields[1].GetBool()))
            {
                sLog.outLog(LOG_DB_ERR, "Incorrect entry in group_member table : member %d cannot be added to player %d's group!", fields[0].GetUInt32(), fields[3].GetUInt32());
                RealmDataDatabase.PExecute("DELETE FROM group_member WHERE memberGuid = '%d'", fields[0].GetUInt32());
            }
        }
        while (result->NextRow());
    }

    // clean groups
    // TODO: maybe delete from the DB before loading in this case
    for (GroupSet::iterator itr = mGroupSet.begin(); itr != mGroupSet.end();)
    {
        if ((*itr)->GetMembersCount() < 2)
        {
            (*itr)->Disband();
            Group *temp = *itr;
            mGroupSet.erase(itr++);
            delete temp;
        }
        else
            ++itr;
    }

    // -- loading instances --
    count = 0;
    group = NULL;
    leaderGuid = 0;
    result = RealmDataDatabase.Query(
        //      0           1    2         3          4           5
        "SELECT leaderGuid, map, instance, permanent, difficulty, resettime, "
        // 6
        "(SELECT COUNT(*) FROM character_instance WHERE guid = leaderGuid AND instance = group_instance.instance AND permanent = 1 LIMIT 1) "
        "FROM group_instance LEFT JOIN instance ON instance = id ORDER BY leaderGuid"
   );

    if (!result)
    {
        BarGoLink bar2(1);
        bar2.step();
    }
    else
    {
        BarGoLink bar2(result->GetRowCount());
        do
        {
            bar2.step();
            Field *fields = result->Fetch();
            count++;
            leaderGuid = MAKE_NEW_GUID(fields[0].GetUInt32(), 0, HIGHGUID_PLAYER);
            if (!group || group->GetLeaderGUID() != leaderGuid)
            {
                group = GetGroupByLeader(leaderGuid);
                if (!group)
                {
                    sLog.outLog(LOG_DB_ERR, "Incorrect entry in group_instance table : no group with leader %d", fields[0].GetUInt32());
                    continue;
                }
            }

            MapEntry const* mapEntry = sMapStore.LookupEntry(fields[1].GetUInt32());
            if (!mapEntry || !mapEntry->IsDungeon())
            {
                sLog.outLog(LOG_DB_ERR, "Incorrect entry in group_instance table : no dungeon map %d", fields[1].GetUInt32());
                continue;
            }

            InstanceSave *save = sInstanceSaveManager.AddInstanceSave(mapEntry->MapID, fields[2].GetUInt32(), fields[4].GetUInt8(), (time_t)fields[5].GetUInt64(), (fields[6].GetUInt32() == 0), true);
            group->BindToInstance(save, fields[3].GetBool(), true);
        }
        while (result->NextRow());
    }

    sLog.outString();
    sLog.outString(">> Loaded %u group-instance binds total", count);

    sLog.outString();
    sLog.outString(">> Loaded %u group members total", count);
}

void ObjectMgr::LoadQuests()
{
    // For reload case
    if (!mQuestTemplates.empty())
    {
        for (QuestMap::const_iterator itr = mQuestTemplates.begin(); itr != mQuestTemplates.end(); ++itr)
            delete itr->second;
    }

    mQuestTemplates.clear();
    mExclusiveQuestGroups.clear();

    //                                                       0      1       2           3             4         5           6     7              8
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry, Method, ZoneOrSort, SkillOrClass, MinLevel, QuestLevel, Type, RequiredRaces, RequiredSkillValue,"
    //   9                    10                 11                     12                   13                     14                   15                16
        "RepObjectiveFaction, RepObjectiveValue, RequiredMinRepFaction, RequiredMinRepValue, RequiredMaxRepFaction, RequiredMaxRepValue, SuggestedPlayers, LimitTime,"
    //   17          18            19           20           21           22              23                24         25            26
        "QuestFlags, SpecialFlags, CharTitleId, PrevQuestId, NextQuestId, ExclusiveGroup, NextQuestInChain, SrcItemId, SrcItemCount, SrcSpell,"
    //   27     28       29          30               31                32       33              34              35              36
        "Name, Details, Objectives, OfferRewardText, RequestItemsText, EndText, ObjectiveText1, ObjectiveText2, ObjectiveText3, ObjectiveText4,"
    //   37          38          39          40          41             42             43             44
        "ReqItemId1, ReqItemId2, ReqItemId3, ReqItemId4, ReqItemCount1, ReqItemCount2, ReqItemCount3, ReqItemCount4,"
    //   45            46            47            48            49               50               51               52               53             54             54             55
        "ReqSourceId1, ReqSourceId2, ReqSourceId3, ReqSourceId4, ReqSourceCount1, ReqSourceCount2, ReqSourceCount3, ReqSourceCount4, ReqSourceRef1, ReqSourceRef2, ReqSourceRef3, ReqSourceRef4,"
    //   57                  58                  59                  60                  61                     62                     63                     64
        "ReqCreatureOrGOId1, ReqCreatureOrGOId2, ReqCreatureOrGOId3, ReqCreatureOrGOId4, ReqCreatureOrGOCount1, ReqCreatureOrGOCount2, ReqCreatureOrGOCount3, ReqCreatureOrGOCount4,"
    //   65             66             67             68
        "ReqSpellCast1, ReqSpellCast2, ReqSpellCast3, ReqSpellCast4,"
    //   69                70                71                72                73                74
        "RewChoiceItemId1, RewChoiceItemId2, RewChoiceItemId3, RewChoiceItemId4, RewChoiceItemId5, RewChoiceItemId6,"
    //   75                   76                   77                   78                   79                   80
        "RewChoiceItemCount1, RewChoiceItemCount2, RewChoiceItemCount3, RewChoiceItemCount4, RewChoiceItemCount5, RewChoiceItemCount6,"
    //   81          82          83          84          85             86             87             88
        "RewItemId1, RewItemId2, RewItemId3, RewItemId4, RewItemCount1, RewItemCount2, RewItemCount3, RewItemCount4,"
    //   89              90              91              92              93              94            95            96            97            98
        "RewRepFaction1, RewRepFaction2, RewRepFaction3, RewRepFaction4, RewRepFaction5, RewRepValue1, RewRepValue2, RewRepValue3, RewRepValue4, RewRepValue5,"
    //   99                 100            101               102       103           104                105               106         107     108    109
        "RewHonorableKills, RewOrReqMoney, RewMoneyMaxLevel, RewSpell, RewSpellCast, RewMailTemplateId, RewMailDelaySecs, PointMapId, PointX, PointY, PointOpt,"
    //   110            111            112           113              114            115                116                117                118             119
        "DetailsEmote1, DetailsEmote2, DetailsEmote3, DetailsEmote4,IncompleteEmote, CompleteEmote, OfferRewardEmote1, OfferRewardEmote2, OfferRewardEmote3, OfferRewardEmote4,"
    //   120            121
        "StartScript, CompleteScript"
        " FROM quest_template");

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded 0 quests definitions");
        sLog.outLog(LOG_DB_ERR, "`quest_template` table is empty!");
        return;
    }

    // create multimap previous quest for each existed quest
    // some quests can have many previous maps set by NextQuestId in previous quest
    // for example set of race quests can lead to single not race specific quest
    BarGoLink bar(result->GetRowCount());
    do
    {
        bar.step();
        Field *fields = result->Fetch();

        Quest * newQuest = new Quest(fields);
        mQuestTemplates[newQuest->GetQuestId()] = newQuest;
    }
    while (result->NextRow());

    // Post processing
    for (QuestMap::iterator iter = mQuestTemplates.begin(); iter != mQuestTemplates.end(); ++iter)
    {
        Quest *qinfo = iter->second;

        // additional quest integrity checks (GO, creature_template and item_template must be loaded already)

        if (qinfo->GetQuestMethod() >= 3)
            sLog.outLog(LOG_DB_ERR, "Quest %u has `Method` = %u, expected values are 0, 1 or 2.",qinfo->GetQuestId(),qinfo->GetQuestMethod());

        if (qinfo->QuestFlags & ~QUEST_LOOKING4GROUP_FLAGS_DB_ALLOWED)
        {
            sLog.outLog(LOG_DB_ERR, "Quest %u has `SpecialFlags` = %u > max allowed value. Correct `SpecialFlags` to value <= %u",
                qinfo->GetQuestId(),qinfo->QuestFlags,QUEST_LOOKING4GROUP_FLAGS_DB_ALLOWED >> 16);
            qinfo->QuestFlags &= QUEST_LOOKING4GROUP_FLAGS_DB_ALLOWED;
        }

        if (qinfo->QuestFlags & QUEST_FLAGS_DAILY)
        {
            if (!(qinfo->QuestFlags & QUEST_LOOKING4GROUP_FLAGS_REPEATABLE))
            {
                sLog.outLog(LOG_DB_ERR, "Daily Quest %u not marked as repeatable in `SpecialFlags`, added.",qinfo->GetQuestId());
                qinfo->QuestFlags |= QUEST_LOOKING4GROUP_FLAGS_REPEATABLE;
            }
        }

        if (qinfo->QuestFlags & QUEST_FLAGS_MONTHLY)
        {
            if (!(qinfo->QuestFlags & QUEST_LOOKING4GROUP_FLAGS_REPEATABLE))
            {
                sLog.outLog(LOG_DB_ERR, "Monthly quest %u not marked as repeatable in `SpecialFlags`, added.", qinfo->GetQuestId());
                qinfo->QuestFlags |= QUEST_LOOKING4GROUP_FLAGS_REPEATABLE;
            }
        }
 
        if (qinfo->QuestFlags & QUEST_FLAGS_AUTO_REWARDED)
        {
            // at auto-reward can be rewarded only RewChoiceItemId[0]
            for (int j = 1; j < QUEST_REWARD_CHOICES_COUNT; ++j)
            {
                if (uint32 id = qinfo->RewChoiceItemId[j])
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `RewChoiceItemId%d` = %u but item from `RewChoiceItemId%d` can't be rewarded with quest flag QUEST_FLAGS_AUTO_REWARDED.", qinfo->GetQuestId(),j+1,id,j+1);
            }
        }

        // client quest log visual (area case)
        if (qinfo->ZoneOrSort > 0)
        {
            if (!GetAreaEntryByAreaID(qinfo->ZoneOrSort))
                sLog.outLog(LOG_DB_ERR, "Quest %u has `ZoneOrSort` = %u (zone case) but zone with this id does not exist.", qinfo->GetQuestId(),qinfo->ZoneOrSort);
        }

        // client quest log visual (sort case)
        if (qinfo->ZoneOrSort < 0)
        {
            QuestSortEntry const* qSort = sQuestSortStore.LookupEntry(-int32(qinfo->ZoneOrSort));
            if (!qSort)
                sLog.outLog(LOG_DB_ERR, "Quest %u has `ZoneOrSort` = %i (sort case) but quest sort with this id does not exist.", qinfo->GetQuestId(),qinfo->ZoneOrSort);

            //check SkillOrClass value (class case).
            if (ClassByQuestSort(-int32(qinfo->ZoneOrSort)))
            {
                // SkillOrClass should not have class case when class case already set in ZoneOrSort.
                if (qinfo->SkillOrClass < 0)
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ZoneOrSort` = %i (class sort case) and `SkillOrClass` = %i (class case), redundant.", qinfo->GetQuestId(),qinfo->ZoneOrSort,qinfo->SkillOrClass);
            }

            //check for proper SkillOrClass value (skill case)
            if (int32 skill_id =  SkillByQuestSort(-int32(qinfo->ZoneOrSort)))
            {
                // skill is positive value in SkillOrClass
                if (qinfo->SkillOrClass != skill_id)
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ZoneOrSort` = %i (skill sort case) but `SkillOrClass` does not have a corresponding value (%i).", qinfo->GetQuestId(),qinfo->ZoneOrSort,skill_id);
            }
        }

        // SkillOrClass (class case)
        if (qinfo->SkillOrClass < 0)
        {
            if (!sChrClassesStore.LookupEntry(-int32(qinfo->SkillOrClass)))
                sLog.outLog(LOG_DB_ERR, "Quest %u has `SkillOrClass` = %i (class case) but class (%i) does not exist", qinfo->GetQuestId(),qinfo->SkillOrClass,-qinfo->SkillOrClass);
        }
        // SkillOrClass (skill case)
        if (qinfo->SkillOrClass > 0)
        {
            if (!sSkillLineStore.LookupEntry(qinfo->SkillOrClass))
                sLog.outLog(LOG_DB_ERR, "Quest %u has `SkillOrClass` = %u (skill case) but skill (%i) does not exist", qinfo->GetQuestId(),qinfo->SkillOrClass,qinfo->SkillOrClass);
        }

        if (qinfo->RequiredSkillValue)
        {
            if (qinfo->RequiredSkillValue > sWorld.GetConfigMaxSkillValue())
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RequiredSkillValue` = %u but max possible skill is %u, quest can't be done.", qinfo->GetQuestId(),qinfo->RequiredSkillValue,sWorld.GetConfigMaxSkillValue());

            if (qinfo->SkillOrClass <= 0)
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RequiredSkillValue` = %u but `SkillOrClass` = %i (class case), value ignored.", qinfo->GetQuestId(),qinfo->RequiredSkillValue,qinfo->SkillOrClass);
        }

        if (qinfo->RepObjectiveFaction && !sFactionStore.LookupEntry(qinfo->RepObjectiveFaction))
            sLog.outLog(LOG_DB_ERR, "Quest %u has `RepObjectiveFaction` = %u but faction template %u does not exist, quest can't be done.", qinfo->GetQuestId(),qinfo->RepObjectiveFaction,qinfo->RepObjectiveFaction);

        if (qinfo->RequiredMinRepFaction && !sFactionStore.LookupEntry(qinfo->RequiredMinRepFaction))
            sLog.outLog(LOG_DB_ERR, "Quest %u has `RequiredMinRepFaction` = %u but faction template %u does not exist, quest can't be done.", qinfo->GetQuestId(),qinfo->RequiredMinRepFaction,qinfo->RequiredMinRepFaction);

        if (qinfo->RequiredMaxRepFaction && !sFactionStore.LookupEntry(qinfo->RequiredMaxRepFaction))
            sLog.outLog(LOG_DB_ERR, "Quest %u has `RequiredMaxRepFaction` = %u but faction template %u does not exist, quest can't be done.", qinfo->GetQuestId(),qinfo->RequiredMaxRepFaction,qinfo->RequiredMaxRepFaction);

        if (qinfo->RequiredMinRepValue && qinfo->RequiredMinRepValue > ReputationMgr::Reputation_Cap)
            sLog.outLog(LOG_DB_ERR, "Quest %u has `RequiredMinRepValue` = %d but max reputation is %u, quest can't be done.", qinfo->GetQuestId(),qinfo->RequiredMinRepValue, ReputationMgr::Reputation_Cap);

        if (qinfo->RequiredMinRepValue && qinfo->RequiredMaxRepValue && qinfo->RequiredMaxRepValue <= qinfo->RequiredMinRepValue)
            sLog.outLog(LOG_DB_ERR, "Quest %u has `RequiredMaxRepValue` = %d and `RequiredMinRepValue` = %d, quest can't be done.", qinfo->GetQuestId(),qinfo->RequiredMaxRepValue,qinfo->RequiredMinRepValue);

        if (!qinfo->RepObjectiveFaction && qinfo->RepObjectiveValue > 0)
            sLog.outLog(LOG_DB_ERR, "Quest %u has `RepObjectiveValue` = %d but `RepObjectiveFaction` is 0, value has no effect", qinfo->GetQuestId(),qinfo->RepObjectiveValue);

        if (!qinfo->RequiredMinRepFaction && qinfo->RequiredMinRepValue > 0)
            sLog.outLog(LOG_DB_ERR, "Quest %u has `RequiredMinRepValue` = %d but `RequiredMinRepFaction` is 0, value has no effect", qinfo->GetQuestId(),qinfo->RequiredMinRepValue);

        if (!qinfo->RequiredMaxRepFaction && qinfo->RequiredMaxRepValue > 0)
            sLog.outLog(LOG_DB_ERR, "Quest %u has `RequiredMaxRepValue` = %d but `RequiredMaxRepFaction` is 0, value has no effect", qinfo->GetQuestId(),qinfo->RequiredMaxRepValue);

        if (qinfo->CharTitleId && !sCharTitlesStore.LookupEntry(qinfo->CharTitleId))
        {
            sLog.outLog(LOG_DB_ERR, "Quest %u has `CharTitleId` = %u but CharTitle Id %u does not exist, quest can't be rewarded with title.", qinfo->GetQuestId(),qinfo->GetCharTitleId(),qinfo->GetCharTitleId());

            qinfo->CharTitleId = 0;
        }

        if (qinfo->SrcItemId)
        {
            if (!sItemStorage.LookupEntry<ItemPrototype>(qinfo->SrcItemId))
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `SrcItemId` = %u but item with entry %u does not exist, quest can't be done.", qinfo->GetQuestId(),qinfo->SrcItemId,qinfo->SrcItemId);

                qinfo->SrcItemId = 0;                       // quest can't be done for this requirement
            }
            else if (qinfo->SrcItemCount == 0)
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `SrcItemId` = %u but `SrcItemCount` = 0, set to 1 but need fix in DB.", qinfo->GetQuestId(),qinfo->SrcItemId);

                qinfo->SrcItemCount = 1;                    // update to 1 for allow quest work for backward compatibility with DB
            }
        }
        else if (qinfo->SrcItemCount > 0)
        {
            sLog.outLog(LOG_DB_ERR, "Quest %u has `SrcItemId` = 0 but `SrcItemCount` = %u, useless value.", qinfo->GetQuestId(),qinfo->SrcItemCount);

            qinfo->SrcItemCount=0;                          // no quest work changes in fact
        }

        if (qinfo->SrcSpell)
        {
            SpellEntry const* spellInfo = sSpellStore.LookupEntry(qinfo->SrcSpell);
            if (!spellInfo)
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `SrcSpell` = %u but spell %u doesn't exist, quest can't be done.", qinfo->GetQuestId(),qinfo->SrcSpell,qinfo->SrcSpell);

                qinfo->SrcSpell = 0;                        // quest can't be done for this requirement
            }
            else if (!SpellMgr::IsSpellValid(spellInfo))
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `SrcSpell` = %u but spell %u is broken, quest can't be done.", qinfo->GetQuestId(),qinfo->SrcSpell,qinfo->SrcSpell);

                qinfo->SrcSpell = 0;                        // quest can't be done for this requirement
            }
        }

        for (int j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
        {
            if (uint32 id = qinfo->ReqItemId[j])
            {
                if (qinfo->ReqItemCount[j] == 0)
                {
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqItemId%d` = %u but `ReqItemCount%d` = 0, quest can't be done.",
                        qinfo->GetQuestId(),j+1,id,j+1);

                    continue;
                }

                qinfo->SetFlag(QUEST_LOOKING4GROUP_FLAGS_DELIVER);

                if (!sItemStorage.LookupEntry<ItemPrototype>(id))
                {
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqItemId%d` = %u but item with entry %u does not exist, quest can't be done.", qinfo->GetQuestId(),j+1,id,id);

                    qinfo->ReqItemCount[j] = 0;             // prevent incorrect work of quest
                }
            }
            else if (qinfo->ReqItemCount[j] > 0)
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqItemId%d` = 0 but `ReqItemCount%d` = %u, quest can't be done.", qinfo->GetQuestId(),j+1,j+1,qinfo->ReqItemCount[j]);

                qinfo->ReqItemCount[j] = 0;                 // prevent incorrect work of quest
            }
        }

        for (int j = 0; j < QUEST_SOURCE_ITEM_IDS_COUNT; ++j)
        {
            if (uint32 id = qinfo->ReqSourceId[j])
            {
                if (!sItemStorage.LookupEntry<ItemPrototype>(id))
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqSourceId%d` = %u but item with entry %u does not exist, quest can't be done.", qinfo->GetQuestId(),j+1,id,id);

                if (!qinfo->ReqSourceCount[j])
                {
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqSourceId%d` = %u but `ReqSourceCount%d` = 0, quest can't be done.", qinfo->GetQuestId(),j+1,id,j+1);
                    qinfo->ReqSourceId[j] = 0;              // prevent incorrect work of quest
                }

                if (!qinfo->ReqSourceRef[j])
                {
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqSourceId%d` = %u but `ReqSourceRef%d` = 0, quest can't be done.", qinfo->GetQuestId(),j+1,id,j+1);
                    qinfo->ReqSourceId[j] = 0;              // prevent incorrect work of quest
                }
            }
            else
            {
                if (qinfo->ReqSourceCount[j]>0)
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqSourceId%d` = 0 but `ReqSourceCount%d` = %u.", qinfo->GetQuestId(),j+1,j+1,qinfo->ReqSourceCount[j]);

                if (qinfo->ReqSourceRef[j]>0)
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqSourceId%d` = 0 but `ReqSourceRef%d` = %u.", qinfo->GetQuestId(),j+1,j+1,qinfo->ReqSourceRef[j]);
            }
        }

        for (int j = 0; j < QUEST_SOURCE_ITEM_IDS_COUNT; ++j)
        {
            if (uint32 ref = qinfo->ReqSourceRef[j])
            {
                if (ref > QUEST_OBJECTIVES_COUNT)
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqSourceRef%d` = %u but max value in `ReqSourceRef%d` is %u, quest can't be done.", qinfo->GetQuestId(),j+1,ref,j+1,QUEST_OBJECTIVES_COUNT);
                else
                {
                     if (!qinfo->ReqItemId[ref-1] && !qinfo->ReqSpell[ref-1])
                         sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqSourceRef%d` = %u but `ReqItemId%u` = 0 and `ReqSpellCast%u` = 0, quest can't be done.", qinfo->GetQuestId(),j+1,ref,ref,ref);
                     else if (qinfo->ReqItemId[ref-1] && qinfo->ReqSpell[ref-1])
                     {
                         sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqItemId%u` = %u and `ReqSpellCast%u` = %u, quest can't have both fields <> 0, then can't be done.", qinfo->GetQuestId(),ref,qinfo->ReqItemId[ref-1],ref,qinfo->ReqSpell[ref-1]);
                         // no changes, quest can't be done for this requirement
                         qinfo->ReqSourceId[j] = 0;              // prevent incorrect work of quest
                     }
                }
            }
        }

        for (int j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
        {
            if (uint32 id = qinfo->ReqSpell[j])
            {
                SpellEntry const* spellInfo = sSpellStore.LookupEntry(id);
                if (!spellInfo)
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqSpellCast%d` = %u but spell %u does not exist, quest can't be done.", qinfo->GetQuestId(),j+1,id,id);

                if (!qinfo->ReqCreatureOrGOId[j])
                {
                    bool found = false;
                    for (int k = 0; k < 3; ++k)
                    {
                        if (spellInfo->Effect[k] == SPELL_EFFECT_QUEST_COMPLETE && uint32(spellInfo->EffectMiscValue[k]) == qinfo->QuestId || spellInfo->Effect[k] == SPELL_EFFECT_SEND_EVENT)
                        {
                            found = true;
                            break;
                        }
                    }

                    if (found)
                    {
                        if (!qinfo->HasFlag(QUEST_LOOKING4GROUP_FLAGS_EXPLORATION_OR_EVENT))
                            sLog.outLog(LOG_DB_ERR, "Spell (id: %u) have SPELL_EFFECT_QUEST_COMPLETE or SPELL_EFFECT_SEND_EVENT for quest %u and ReqCreatureOrGOId%d = 0, but quest not have flag QUEST_LOOKING4GROUP_FLAGS_EXPLORATION_OR_EVENT. Quest flags or ReqCreatureOrGOId%d must be fixed, quest modified to enable objective.",spellInfo->Id,qinfo->QuestId,j+1,j+1);
                    }
                    else
                        sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqSpellCast%d` = %u and ReqCreatureOrGOId%d = 0 but spell %u does not have SPELL_EFFECT_QUEST_COMPLETE or SPELL_EFFECT_SEND_EVENT effect for this quest, quest can't be done.", qinfo->GetQuestId(),j+1,id,j+1,id);
                }
            }
        }

        for (int j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
        {
            int32 id = qinfo->ReqCreatureOrGOId[j];
            if (id < 0 && !sGOStorage.LookupEntry<GameObjectInfo>(-id))
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqCreatureOrGOId%d` = %i but gameobject %u does not exist, quest can't be done.", qinfo->GetQuestId(),j+1,id,uint32(-id));
                qinfo->ReqCreatureOrGOId[j] = 0;            // quest can't be done for this requirement
            }

            if (id > 0 && !sCreatureStorage.LookupEntry<CreatureInfo>(id))
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqCreatureOrGOId%d` = %i but creature with entry %u does not exist, quest can't be done.", qinfo->GetQuestId(),j+1,id,uint32(id));
                qinfo->ReqCreatureOrGOId[j] = 0;            // quest can't be done for this requirement
            }

            if (id)
            {
                // In fact SpeakTo and Kill are quite same: either you can speak to mob:SpeakTo or you can't:Kill/Cast
                qinfo->SetFlag(QUEST_LOOKING4GROUP_FLAGS_KILL_OR_CAST | QUEST_LOOKING4GROUP_FLAGS_SPEAKTO);

                if (!qinfo->ReqCreatureOrGOCount[j])
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqCreatureOrGOId%d` = %u but `ReqCreatureOrGOCount%d` = 0, quest can't be done.", qinfo->GetQuestId(),j+1,id,j+1);
            }
            else if (qinfo->ReqCreatureOrGOCount[j]>0)
                sLog.outLog(LOG_DB_ERR, "Quest %u has `ReqCreatureOrGOId%d` = 0 but `ReqCreatureOrGOCount%d` = %u.", qinfo->GetQuestId(),j+1,j+1,qinfo->ReqCreatureOrGOCount[j]);
        }

        for (int j = 0; j < QUEST_REWARD_CHOICES_COUNT; ++j)
        {
            if (uint32 id = qinfo->RewChoiceItemId[j])
            {
                if (!sItemStorage.LookupEntry<ItemPrototype>(id))
                {
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `RewChoiceItemId%d` = %u but item with entry %u does not exist, quest will not reward this item.", qinfo->GetQuestId(),j+1,id,id);
                    qinfo->RewChoiceItemId[j] = 0;          // no changes, quest will not reward this
                }

                if (!qinfo->RewChoiceItemCount[j])
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `RewChoiceItemId%d` = %u but `RewChoiceItemCount%d` = 0, quest can't be done.", qinfo->GetQuestId(),j+1,id,j+1);
            }
            else if (qinfo->RewChoiceItemCount[j]>0)
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RewChoiceItemId%d` = 0 but `RewChoiceItemCount%d` = %u.", qinfo->GetQuestId(),j+1,j+1,qinfo->RewChoiceItemCount[j]);
        }

        for (int j = 0; j < QUEST_REWARDS_COUNT; ++j)
        {
            if (uint32 id = qinfo->RewItemId[j])
            {
                if (!sItemStorage.LookupEntry<ItemPrototype>(id))
                {
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `RewItemId%d` = %u but item with entry %u does not exist, quest will not reward this item.", qinfo->GetQuestId(),j+1,id,id);
                    qinfo->RewItemId[j] = 0;                // no changes, quest will not reward this item
                }

                if (!qinfo->RewItemCount[j])
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `RewItemId%d` = %u but `RewItemCount%d` = 0, quest will not reward this item.", qinfo->GetQuestId(),j+1,id,j+1);
            }
            else if (qinfo->RewItemCount[j]>0)
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RewItemId%d` = 0 but `RewItemCount%d` = %u.", qinfo->GetQuestId(),j+1,j+1,qinfo->RewItemCount[j]);
        }

        for (int j = 0; j < QUEST_REPUTATIONS_COUNT; ++j)
        {
            if (qinfo->RewRepFaction[j])
            {
                if (!qinfo->RewRepValue[j])
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `RewRepFaction%d` = %u but `RewRepValue%d` = 0, quest will not reward this reputation.", qinfo->GetQuestId(),j+1,qinfo->RewRepValue[j],j+1);

                if (!sFactionStore.LookupEntry(qinfo->RewRepFaction[j]))
                {
                    sLog.outLog(LOG_DB_ERR, "Quest %u has `RewRepFaction%d` = %u but raw faction (faction.dbc) %u does not exist, quest will not reward reputation for this faction.", qinfo->GetQuestId(),j+1,qinfo->RewRepFaction[j] ,qinfo->RewRepFaction[j]);
                    qinfo->RewRepFaction[j] = 0;            // quest will not reward this
                }
            }
            else if (qinfo->RewRepValue[j]!=0)
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RewRepFaction%d` = 0 but `RewRepValue%d` = %u.", qinfo->GetQuestId(),j+1,j+1,qinfo->RewRepValue[j]);
        }

        if (qinfo->RewSpell)
        {
            SpellEntry const* spellInfo = sSpellStore.LookupEntry(qinfo->RewSpell);

            if (!spellInfo)
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RewSpell` = %u but spell %u does not exist, spell removed as display reward.", qinfo->GetQuestId(),qinfo->RewSpell,qinfo->RewSpell);
                qinfo->RewSpell = 0;                        // no spell reward will display for this quest
            }

            else if (!SpellMgr::IsSpellValid(spellInfo))
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RewSpell` = %u but spell %u is broken, quest can't be done.", qinfo->GetQuestId(),qinfo->RewSpell,qinfo->RewSpell);
                qinfo->RewSpell = 0;                        // no spell reward will display for this quest
            }

        }

        if (qinfo->RewSpellCast)
        {
            SpellEntry const* spellInfo = sSpellStore.LookupEntry(qinfo->RewSpellCast);
            if (!spellInfo)
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RewSpellCast` = %u but spell %u does not exist, quest will not have a spell reward.", qinfo->GetQuestId(),qinfo->RewSpellCast,qinfo->RewSpellCast);
                qinfo->RewSpellCast = 0;                    // no spell will be casted on player
            }

            else if (!SpellMgr::IsSpellValid(spellInfo))
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RewSpellCast` = %u but spell %u is broken, quest can't be done.", qinfo->GetQuestId(),qinfo->RewSpellCast,qinfo->RewSpellCast);
                qinfo->RewSpellCast = 0;                    // no spell will be casted on player
            }

        }

        if (qinfo->RewMailTemplateId)
        {
            if (!sMailTemplateStore.LookupEntry(qinfo->RewMailTemplateId))
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `RewMailTemplateId` = %u but mail template  %u does not exist, quest will not have a mail reward.", qinfo->GetQuestId(),qinfo->RewMailTemplateId,qinfo->RewMailTemplateId);
                qinfo->RewMailTemplateId = 0;               // no mail will send to player
                qinfo->RewMailDelaySecs = 0;                // no mail will send to player
            }
        }

        if (qinfo->NextQuestInChain)
        {
            QuestMap::iterator qNextItr = mQuestTemplates.find(qinfo->NextQuestInChain);
            if(qNextItr == mQuestTemplates.end())
            {
                sLog.outLog(LOG_DB_ERR, "Quest %u has `NextQuestInChain` = %u but quest %u does not exist, quest chain will not work.", qinfo->GetQuestId(),qinfo->NextQuestInChain ,qinfo->NextQuestInChain);
                qinfo->NextQuestInChain = 0;
            }
            else
                qNextItr->second->prevChainQuests.push_back(qinfo->GetQuestId());
        }

        // fill additional data stores
        if (qinfo->PrevQuestId)
        {
            if (mQuestTemplates.find(abs(qinfo->GetPrevQuestId())) == mQuestTemplates.end())
                sLog.outLog(LOG_DB_ERR, "Quest %d has PrevQuestId %i, but no such quest", qinfo->GetQuestId(), qinfo->GetPrevQuestId());
            else
                qinfo->prevQuests.push_back(qinfo->PrevQuestId);
        }

        if (qinfo->NextQuestId)
        {
            QuestMap::iterator qNextItr = mQuestTemplates.find(abs(qinfo->GetNextQuestId()));
            if (qNextItr == mQuestTemplates.end())
                sLog.outLog(LOG_DB_ERR, "Quest %d has NextQuestId %i, but no such quest", qinfo->GetQuestId(), qinfo->GetNextQuestId());
            else
            {
                int32 signedQuestId = qinfo->NextQuestId < 0 ? -int32(qinfo->GetQuestId()) : int32(qinfo->GetQuestId());
                qNextItr->second->prevQuests.push_back(signedQuestId);
            }
        }

        if (qinfo->ExclusiveGroup)
            mExclusiveQuestGroups.insert(std::pair<int32, uint32>(qinfo->ExclusiveGroup, qinfo->GetQuestId()));

        if (qinfo->LimitTime)
            qinfo->SetFlag(QUEST_LOOKING4GROUP_FLAGS_TIMED);
    }

    sLog.outString();
    sLog.outString(">> Loaded %u quests definitions", mQuestTemplates.size());
}

void ObjectMgr::LoadQuestLocales()
{
    mQuestLocaleMap.clear();                                // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry,"
        "Title_loc1,Details_loc1,Objectives_loc1,OfferRewardText_loc1,RequestItemsText_loc1,EndText_loc1,ObjectiveText1_loc1,ObjectiveText2_loc1,ObjectiveText3_loc1,ObjectiveText4_loc1,"
        "Title_loc2,Details_loc2,Objectives_loc2,OfferRewardText_loc2,RequestItemsText_loc2,EndText_loc2,ObjectiveText1_loc2,ObjectiveText2_loc2,ObjectiveText3_loc2,ObjectiveText4_loc2,"
        "Title_loc3,Details_loc3,Objectives_loc3,OfferRewardText_loc3,RequestItemsText_loc3,EndText_loc3,ObjectiveText1_loc3,ObjectiveText2_loc3,ObjectiveText3_loc3,ObjectiveText4_loc3,"
        "Title_loc4,Details_loc4,Objectives_loc4,OfferRewardText_loc4,RequestItemsText_loc4,EndText_loc4,ObjectiveText1_loc4,ObjectiveText2_loc4,ObjectiveText3_loc4,ObjectiveText4_loc4,"
        "Title_loc5,Details_loc5,Objectives_loc5,OfferRewardText_loc5,RequestItemsText_loc5,EndText_loc5,ObjectiveText1_loc5,ObjectiveText2_loc5,ObjectiveText3_loc5,ObjectiveText4_loc5,"
        "Title_loc6,Details_loc6,Objectives_loc6,OfferRewardText_loc6,RequestItemsText_loc6,EndText_loc6,ObjectiveText1_loc6,ObjectiveText2_loc6,ObjectiveText3_loc6,ObjectiveText4_loc6,"
        "Title_loc7,Details_loc7,Objectives_loc7,OfferRewardText_loc7,RequestItemsText_loc7,EndText_loc7,ObjectiveText1_loc7,ObjectiveText2_loc7,ObjectiveText3_loc7,ObjectiveText4_loc7,"
        "Title_loc8,Details_loc8,Objectives_loc8,OfferRewardText_loc8,RequestItemsText_loc8,EndText_loc8,ObjectiveText1_loc8,ObjectiveText2_loc8,ObjectiveText3_loc8,ObjectiveText4_loc8"
        " FROM locales_quest"
       );

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outString(">> Loaded 0 Quest locale strings. DB table `locales_quest` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 entry = fields[0].GetUInt32();

        QuestLocale& data = mQuestLocaleMap[entry];
        for (int i = 1; i < MAX_LOCALE; ++i)
        {
            std::string str = fields[1+10*(i-1)].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.Title.size() <= idx)
                        data.Title.resize(idx+1);

                    data.Title[idx] = str;
                }
            }
            str = fields[1+10*(i-1)+1].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.Details.size() <= idx)
                        data.Details.resize(idx+1);

                    data.Details[idx] = str;
                }
            }

            str = fields[1+10*(i-1)+2].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.Objectives.size() <= idx)
                        data.Objectives.resize(idx+1);

                    data.Objectives[idx] = str;
                }
            }
            str = fields[1+10*(i-1)+3].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.OfferRewardText.size() <= idx)
                        data.OfferRewardText.resize(idx+1);

                    data.OfferRewardText[idx] = str;
                }
            }

            str = fields[1+10*(i-1)+4].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.RequestItemsText.size() <= idx)
                        data.RequestItemsText.resize(idx+1);

                    data.RequestItemsText[idx] = str;
                }
            }

            str = fields[1+10*(i-1)+5].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.EndText.size() <= idx)
                        data.EndText.resize(idx+1);

                    data.EndText[idx] = str;
                }
            }

            for (int k = 0; k < 4; ++k)
            {
                str = fields[1+10*(i-1)+6+k].GetCppString();
                if (!str.empty())
                {
                    int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                    if (idx >= 0)
                    {
                        if (data.ObjectiveText[k].size() <= idx)
                            data.ObjectiveText[k].resize(idx+1);

                        data.ObjectiveText[k][idx] = str;
                    }
                }
            }
        }
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u Quest locale strings", mQuestLocaleMap.size());
}

void ObjectMgr::LoadPetCreateSpells()
{
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry, Spell1, Spell2, Spell3, Spell4 FROM petcreateinfo_spell");
    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded 0 pet create spells");
        sLog.outLog(LOG_DB_ERR, "`petcreateinfo_spell` table is empty!");
        return;
    }

    uint32 count = 0;
    BarGoLink bar(result->GetRowCount());

    mPetCreateSpell.clear();

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 creature_id = fields[0].GetUInt32();

        if (!creature_id || !sCreatureStorage.LookupEntry<CreatureInfo>(creature_id))
            continue;

        PetCreateSpellEntry PetCreateSpell;
        for (int i = 0; i < 4; i++)
        {
            PetCreateSpell.spellid[i] = fields[i + 1].GetUInt32();

            if (PetCreateSpell.spellid[i] && !sSpellStore.LookupEntry(PetCreateSpell.spellid[i]))
                sLog.outLog(LOG_DB_ERR, "Spell %u listed in `petcreateinfo_spell` does not exist",PetCreateSpell.spellid[i]);
        }

        mPetCreateSpell[creature_id] = PetCreateSpell;
        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u pet create spells", count);
}

void ObjectMgr::LoadPageTexts()
{
    sPageTextStore.Free();                                  // for reload case

    sPageTextStore.Load();
    sLog.outString(">> Loaded %u page texts", sPageTextStore.RecordCount);
    sLog.outString();

    for (uint32 i = 1; i < sPageTextStore.MaxEntry; ++i)
    {
        // check data correctness
        PageText const* page = sPageTextStore.LookupEntry<PageText>(i);
        if (!page)
            continue;

        if (page->Next_Page && !sPageTextStore.LookupEntry<PageText>(page->Next_Page))
        {
            sLog.outLog(LOG_DB_ERR, "Page text (Id: %u) has not existing next page (Id:%u)", i,page->Next_Page);
            continue;
        }

        // detect circular reference
        std::set<uint32> checkedPages;
        for (PageText const* pageItr = page; pageItr; pageItr = sPageTextStore.LookupEntry<PageText>(pageItr->Next_Page))
        {
            if (!pageItr->Next_Page)
                break;

            checkedPages.insert(pageItr->Page_ID);
            if (checkedPages.find(pageItr->Next_Page)!=checkedPages.end())
            {
                std::ostringstream ss;
                ss<< "The text page(s) ";
                for (std::set<uint32>::iterator itr= checkedPages.begin();itr!=checkedPages.end(); ++itr)
                    ss << *itr << " ";
                ss << "create(s) a circular reference, which can cause the server to freeze. Changing Next_Page of page "
                    << pageItr->Page_ID <<" to 0";
                sLog.outLog(LOG_DB_ERR, ss.str().c_str());
                const_cast<PageText*>(pageItr)->Next_Page = 0;
                break;
            }
        }
    }
}

void ObjectMgr::LoadPageTextLocales()
{
    mPageTextLocaleMap.clear();                             // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry,text_loc1,text_loc2,text_loc3,text_loc4,text_loc5,text_loc6,text_loc7,text_loc8 FROM locales_page_text");
    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outString(">> Loaded 0 PageText locale strings. DB table `locales_page_text` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 entry = fields[0].GetUInt32();

        PageTextLocale& data = mPageTextLocaleMap[entry];

        for (int i = 1; i < MAX_LOCALE; ++i)
        {
            std::string str = fields[i].GetCppString();
            if (str.empty())
                continue;

            int idx = GetOrNewIndexForLocale(LocaleConstant(i));
            if (idx >= 0)
            {
                if (data.Text.size() <= idx)
                    data.Text.resize(idx+1);

                data.Text[idx] = str;
            }
        }

    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u PageText locale strings", mPageTextLocaleMap.size());
}

struct SQLInstanceLoader : public SQLStorageLoaderBase<SQLInstanceLoader>
{
    template<class D>
    void convert_from_str(uint32 field_pos, const char *src, D &dst)
    {
        dst = D(sScriptMgr.GetScriptId(src));
    }
};

void ObjectMgr::LoadInstanceTemplate()
{
    SQLInstanceLoader loader;
    loader.Load(sInstanceTemplate);

    for (uint32 i = 0; i < sInstanceTemplate.MaxEntry; i++)
    {
        InstanceTemplate* temp = (InstanceTemplate*)GetInstanceTemplate(i);
        if (!temp)
            continue;

        const MapEntry* entry = sMapStore.LookupEntry(temp->map);
        if (!entry)
        {
            sLog.outLog(LOG_DB_ERR, "ObjectMgr::LoadInstanceTemplate: bad mapid %d for template!", temp->map);
            continue;
        }
        else if (!entry->HasResetTime())
            continue;

        if (temp->reset_delay == 0)
        {
            // use defaults from the DBC
            if (entry->SupportsHeroicMode())
            {
                temp->reset_delay = entry->resetTimeHeroic / DAY;
            }
            else if (entry->resetTimeRaid && entry->map_type == MAP_RAID)
            {
                temp->reset_delay = entry->resetTimeRaid / DAY;
            }
        }

        // the reset_delay must be at least one day
        temp->reset_delay = std::max((uint32)1, (uint32)(temp->reset_delay * sWorld.getRate(RATE_INSTANCE_RESET_TIME)));
    }

    sLog.outString(">> Loaded %u Instance Template definitions", sInstanceTemplate.RecordCount);
    sLog.outString();
}

GossipText const *ObjectMgr::GetGossipText(uint32 Text_ID) const
{
    GossipTextMap::const_iterator itr = mGossipText.find(Text_ID);
    if(itr != mGossipText.end())
        return &itr->second;
     return NULL;
 }

void ObjectMgr::LoadGossipText()
{
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT * FROM npc_text");

    int count = 0;
    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u npc texts", count);
        return;
    }

    int cic;

    BarGoLink bar(result->GetRowCount());

    do
    {
        ++count;
        cic = 0;

        Field *fields = result->Fetch();

        bar.step();

        uint32 Text_ID      = fields[cic++].GetUInt32();

        if (!Text_ID)
        {
            sLog.outLog(LOG_DB_ERR, "Table `npc_text` has record with reserved id 0, ignore.");
            continue;
        }

        GossipText& gText = mGossipText[Text_ID];

        for (uint8 i = 0; i < MAX_GOSSIP_TEXT_OPTIONS; ++i)
        {
            gText.Options[i].Text_0           = fields[cic++].GetCppString();
            gText.Options[i].Text_1           = fields[cic++].GetCppString();

            gText.Options[i].Language         = fields[cic++].GetUInt32();
            gText.Options[i].Probability      = fields[cic++].GetFloat();

            for(uint8 j = 0; j < 3; ++j)
            {
                gText.Options[i].Emotes[j]._Delay  = fields[cic++].GetUInt32();
                gText.Options[i].Emotes[j]._Emote  = fields[cic++].GetUInt32();
            }
        }
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u npc texts", count);
}

void ObjectMgr::LoadNpcTextLocales()
{
    mNpcTextLocaleMap.clear();                              // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry,"
        "Text0_0_loc1,Text0_1_loc1,Text1_0_loc1,Text1_1_loc1,Text2_0_loc1,Text2_1_loc1,Text3_0_loc1,Text3_1_loc1,Text4_0_loc1,Text4_1_loc1,Text5_0_loc1,Text5_1_loc1,Text6_0_loc1,Text6_1_loc1,Text7_0_loc1,Text7_1_loc1,"
        "Text0_0_loc2,Text0_1_loc2,Text1_0_loc2,Text1_1_loc2,Text2_0_loc2,Text2_1_loc2,Text3_0_loc2,Text3_1_loc1,Text4_0_loc2,Text4_1_loc2,Text5_0_loc2,Text5_1_loc2,Text6_0_loc2,Text6_1_loc2,Text7_0_loc2,Text7_1_loc2,"
        "Text0_0_loc3,Text0_1_loc3,Text1_0_loc3,Text1_1_loc3,Text2_0_loc3,Text2_1_loc3,Text3_0_loc3,Text3_1_loc1,Text4_0_loc3,Text4_1_loc3,Text5_0_loc3,Text5_1_loc3,Text6_0_loc3,Text6_1_loc3,Text7_0_loc3,Text7_1_loc3,"
        "Text0_0_loc4,Text0_1_loc4,Text1_0_loc4,Text1_1_loc4,Text2_0_loc4,Text2_1_loc4,Text3_0_loc4,Text3_1_loc1,Text4_0_loc4,Text4_1_loc4,Text5_0_loc4,Text5_1_loc4,Text6_0_loc4,Text6_1_loc4,Text7_0_loc4,Text7_1_loc4,"
        "Text0_0_loc5,Text0_1_loc5,Text1_0_loc5,Text1_1_loc5,Text2_0_loc5,Text2_1_loc5,Text3_0_loc5,Text3_1_loc1,Text4_0_loc5,Text4_1_loc5,Text5_0_loc5,Text5_1_loc5,Text6_0_loc5,Text6_1_loc5,Text7_0_loc5,Text7_1_loc5,"
        "Text0_0_loc6,Text0_1_loc6,Text1_0_loc6,Text1_1_loc6,Text2_0_loc6,Text2_1_loc6,Text3_0_loc6,Text3_1_loc1,Text4_0_loc6,Text4_1_loc6,Text5_0_loc6,Text5_1_loc6,Text6_0_loc6,Text6_1_loc6,Text7_0_loc6,Text7_1_loc6,"
        "Text0_0_loc7,Text0_1_loc7,Text1_0_loc7,Text1_1_loc7,Text2_0_loc7,Text2_1_loc7,Text3_0_loc7,Text3_1_loc1,Text4_0_loc7,Text4_1_loc7,Text5_0_loc7,Text5_1_loc7,Text6_0_loc7,Text6_1_loc7,Text7_0_loc7,Text7_1_loc7, "
        "Text0_0_loc8,Text0_1_loc8,Text1_0_loc8,Text1_1_loc8,Text2_0_loc8,Text2_1_loc8,Text3_0_loc8,Text3_1_loc1,Text4_0_loc8,Text4_1_loc8,Text5_0_loc8,Text5_1_loc8,Text6_0_loc8,Text6_1_loc8,Text7_0_loc8,Text7_1_loc8 "
        " FROM locales_npc_text");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outString(">> Loaded 0 Quest locale strings. DB table `locales_npc_text` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 entry = fields[0].GetUInt32();

        NpcTextLocale& data = mNpcTextLocaleMap[entry];

        for (int i=1; i<MAX_LOCALE; ++i)
        {
            for (int j=0; j<8; ++j)
            {
                std::string str0 = fields[1+8*2*(i-1)+2*j].GetCppString();
                if (!str0.empty())
                {
                    int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                    if (idx >= 0)
                    {
                        if (data.Text_0[j].size() <= idx)
                            data.Text_0[j].resize(idx+1);

                        data.Text_0[j][idx] = str0;
                    }
                }
                std::string str1 = fields[1+8*2*(i-1)+2*j+1].GetCppString();
                if (!str1.empty())
                {
                    int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                    if (idx >= 0)
                    {
                        if (data.Text_1[j].size() <= idx)
                            data.Text_1[j].resize(idx+1);

                        data.Text_1[j][idx] = str1;
                    }
                }
            }
        }
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u NpcText locale strings", mNpcTextLocaleMap.size());
}

//not very fast function but it is called only once a day, or on starting-up
void ObjectMgr::ReturnOrDeleteOldMails(bool serverUp)
{
    time_t basetime = time(NULL);
    sLog.outDebug("Returning mails current time: hour: %d, minute: %d, second: %d ", localtime(&basetime)->tm_hour, localtime(&basetime)->tm_min, localtime(&basetime)->tm_sec);
    //delete all old mails without item and without body immediately, if starting server
    if (!serverUp)
        RealmDataDatabase.PExecute("DELETE FROM mail WHERE expire_time < '" UI64FMTD "' AND has_items = '0' AND itemTextId = 0", (uint64)basetime);
    //                                                            0  1           2      3        4          5         6           7   8       9
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT id,messageType,sender,receiver,itemTextId,has_items,expire_time,cod,checked,mailTemplateId FROM mail WHERE expire_time < '" UI64FMTD "'", (uint64)basetime);
    if (!result)
        return;                                             // any mails need to be returned or deleted
    Field *fields;
    //std::ostringstream delitems, delmails; //will be here for optimization
    //bool deletemail = false, deleteitem = false;
    //delitems << "DELETE FROM item_instance WHERE guid IN (";
    //delmails << "DELETE FROM mail WHERE id IN ("
    do
    {
        fields = result->Fetch();
        Mail *m = new Mail;
        m->messageID = fields[0].GetUInt32();
        m->messageType = fields[1].GetUInt8();
        m->sender = fields[2].GetUInt32();
        m->receiverGuid = ObjectGuid(HIGHGUID_PLAYER, fields[3].GetUInt32());
        m->itemTextId = fields[4].GetUInt32();
        bool has_items = fields[5].GetBool();
        m->expire_time = (time_t)fields[6].GetUInt64();
        m->deliver_time = 0;
        m->COD = fields[7].GetUInt32();
        m->checked = fields[8].GetUInt32();
        m->mailTemplateId = fields[9].GetInt16();

        Player *pl = 0;
        if (serverUp)
            pl = GetPlayer(m->receiverGuid.GetRawValue());

        if (pl)
        {
            delete m;
            continue;
        }

        //delete or return mail:
        if (has_items)
        {
            QueryResultAutoPtr resultItems = RealmDataDatabase.PQuery("SELECT item_guid,item_template FROM mail_items WHERE mail_id='%u'", m->messageID);
            if (resultItems)
            {
                do
                {
                    Field *fields2 = resultItems->Fetch();

                    uint32 item_guid_low = fields2[0].GetUInt32();
                    uint32 item_template = fields2[1].GetUInt32();

                    m->AddItem(item_guid_low, item_template);
                }
                while (resultItems->NextRow());
            }

            // mail should be deleted if:
            // - it's from AH
            // - it's readed mail from GM (or meybe all readed mails should be deleted not returned ?)
            if (m->messageType != MAIL_NORMAL || (m->checked & (MAIL_CHECK_MASK_COD_PAYMENT | MAIL_CHECK_MASK_RETURNED)) || (m->stationery == MAIL_STATIONERY_GM && m->checked & MAIL_CHECK_MASK_READ))
            {
                // mail open and then not returned
                for (std::vector<MailItemInfo>::iterator itr2 = m->items.begin(); itr2 != m->items.end(); ++itr2)
                    RealmDataDatabase.PExecute("DELETE FROM item_instance WHERE guid = '%u'", itr2->item_guid);
            }
            else
            {
                //mail will be returned:
                RealmDataDatabase.PExecute("UPDATE mail SET sender = '%u', receiver = '%u', expire_time = '" UI64FMTD "', deliver_time = '" UI64FMTD "',cod = '0', checked = '%u' WHERE id = '%u'", m->receiverGuid.GetCounter(), m->sender, (uint64)(basetime + 30*DAY), (uint64)basetime, MAIL_CHECK_MASK_RETURNED, m->messageID);
                for (std::vector<MailItemInfo>::iterator itr2 = m->items.begin(); itr2 != m->items.end(); ++itr2)
                {
                    RealmDataDatabase.PExecute("UPDATE mail_items SET receiver = %u WHERE item_guid = '%u'", m->sender, itr2->item_guid);
                    RealmDataDatabase.PExecute("UPDATE item_instance SET owner_guid = %u WHERE guid = '%u'", m->sender, itr2->item_guid);
                }
                delete m;
                continue;
            }
        }

        if (m->itemTextId)
            RealmDataDatabase.PExecute("DELETE FROM item_text WHERE id = '%u'", m->itemTextId);

        //deletemail = true;
        //delmails << m->messageID << ", ";
        RealmDataDatabase.PExecute("DELETE FROM mail WHERE id = '%u'", m->messageID);
        delete m;
    } while (result->NextRow());
}

void ObjectMgr::LoadQuestAreaTriggers()
{
    mQuestAreaTriggerMap.clear();                           // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT id,quest FROM areatrigger_involvedrelation");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u quest trigger points", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 trigger_ID = fields[0].GetUInt32();
        uint32 quest_ID   = fields[1].GetUInt32();

        AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(trigger_ID);
        if (!atEntry)
        {
            sLog.outLog(LOG_DB_ERR, "Area trigger (ID:%u) does not exist in `AreaTrigger.dbc`.",trigger_ID);
            continue;
        }

        Quest const* quest = GetQuestTemplate(quest_ID);

        if (!quest)
        {
            sLog.outLog(LOG_DB_ERR, "Table `areatrigger_involvedrelation` has record (id: %u) for not existing quest %u",trigger_ID,quest_ID);
            continue;
        }

        if (!quest->HasFlag(QUEST_LOOKING4GROUP_FLAGS_EXPLORATION_OR_EVENT))
        {
            sLog.outLog(LOG_DB_ERR, "Table `areatrigger_involvedrelation` has record (id: %u) for not quest %u, but quest not have flag QUEST_LOOKING4GROUP_FLAGS_EXPLORATION_OR_EVENT. Trigger or quest flags must be fixed, quest modified to require objective.",trigger_ID,quest_ID);

            // this will prevent quest completing without objective
            const_cast<Quest*>(quest)->SetFlag(QUEST_LOOKING4GROUP_FLAGS_EXPLORATION_OR_EVENT);

            // continue; - quest modified to required objective and trigger can be allowed.
        }

        mQuestAreaTriggerMap[trigger_ID] = quest_ID;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u quest trigger points", count);
}

void ObjectMgr::LoadTavernAreaTriggers()
{
    mTavernAreaTriggerSet.clear();                          // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT id FROM areatrigger_tavern");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u tavern triggers", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 Trigger_ID      = fields[0].GetUInt32();

        AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(Trigger_ID);
        if (!atEntry)
        {
            sLog.outLog(LOG_DB_ERR, "Area trigger (ID:%u) does not exist in `AreaTrigger.dbc`.",Trigger_ID);
            continue;
        }

        mTavernAreaTriggerSet.insert(Trigger_ID);
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u tavern triggers", count);
}

uint32 ObjectMgr::GetNearestTaxiNode(float x, float y, float z, uint32 mapid, uint32 team)
{
    bool found = false;
    float dist;
    uint32 id = 0;

    for (uint32 i = 1; i < sTaxiNodesStore.GetNumRows(); ++i)
    {
        TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(i);
        if (!node || node->map_id != mapid)
            continue;

        uint32 MountCreatureID = team == ALLIANCE ? node->alliance_mount_type : node->horde_mount_type;
        if (!MountCreatureID)
            continue;

        uint8  field   = (uint8)((i - 1) / 32);
        uint32 submask = 1<<((i-1)%32);

        // skip not taxi network nodes
        if ((sTaxiNodesMask[field] & submask)==0)
            continue;

        float dist2 = (node->x - x)*(node->x - x)+(node->y - y)*(node->y - y)+(node->z - z)*(node->z - z);
        if (found)
        {
            if(dist2 < dist)
            {
                dist = dist2;
                id = i;
            }
        }
        else
        {
            found = true;
            dist = dist2;
            id = i;
        }
    }

    return id;
}

void ObjectMgr::GetTaxiPath(uint32 source, uint32 destination, uint32 &path, uint32 &cost)
{
    TaxiPathSetBySource::iterator src_i = sTaxiPathSetBySource.find(source);
    if (src_i==sTaxiPathSetBySource.end())
    {
        path = 0;
        cost = 0;
        return;
    }

    TaxiPathSetForSource& pathSet = src_i->second;

    TaxiPathSetForSource::iterator dest_i = pathSet.find(destination);
    if (dest_i==pathSet.end())
    {
        path = 0;
        cost = 0;
        return;
    }

    cost = dest_i->second.price;
    path = dest_i->second.ID;
}

uint16 ObjectMgr::GetTaxiMount(uint32 id, uint32 team)
{
    uint16 mount_entry = 0;
    uint16 mount_id = 0;

    TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(id);
    if (node)
    {
        if (team == ALLIANCE) mount_entry = node->alliance_mount_type;
        else mount_entry = node->horde_mount_type;

        CreatureInfo const *cinfo = GetCreatureTemplate(mount_entry);
        if (cinfo)
        {
            if (! (mount_id = cinfo->GetRandomValidModelId()))
            {
                sLog.outLog(LOG_DB_ERR, "No displayid found for the taxi mount with the entry %u! Can't load it!", mount_entry);
                return false;
            }
        }
    }

    CreatureModelInfo const *minfo = GetCreatureModelInfo(mount_id);
    if (!minfo)
    {
        sLog.outLog(LOG_DB_ERR, "Taxi mount (Entry: %u) for taxi node (Id: %u) for team %u has model %u not found in table `creature_model_info`, can't load. ",
            mount_entry,id,team,mount_id);

        return false;
    }
    if (minfo->modelid_other_gender!=0)
        mount_id = urand(0,1) ? mount_id : minfo->modelid_other_gender;

    return mount_id;
}

void ObjectMgr::LoadGraveyardZones()
{
    mGraveYardMap.clear();                                  // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT id,ghost_zone,faction FROM game_graveyard_zone");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u graveyard-zone links", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 safeLocId = fields[0].GetUInt32();
        uint32 zoneId = fields[1].GetUInt32();
        uint32 team   = fields[2].GetUInt32();

        WorldSafeLocsEntry const* entry = sWorldSafeLocsStore.LookupEntry(safeLocId);
        if (!entry)
        {
            sLog.outLog(LOG_DB_ERR, "Table `game_graveyard_zone` has record for not existing graveyard (WorldSafeLocs.dbc id) %u, skipped.",safeLocId);
            continue;
        }

        AreaTableEntry const *areaEntry = GetAreaEntryByAreaID(zoneId);
        if (!areaEntry)
        {
            sLog.outLog(LOG_DB_ERR, "Table `game_graveyard_zone` has record for not existing zone id (%u), skipped.",zoneId);
            continue;
        }

        if (areaEntry->zone != 0)
        {
            sLog.outLog(LOG_DB_ERR, "Table `game_graveyard_zone` has record subzone id (%u) instead of zone, skipped.",zoneId);
            continue;
        }

        if (team!=0 && team!=HORDE && team!=ALLIANCE)
        {
            sLog.outLog(LOG_DB_ERR, "Table `game_graveyard_zone` has record for non player faction (%u), skipped.",team);
            continue;
        }

        if (!AddGraveYardLink(safeLocId,zoneId,team,false))
            sLog.outLog(LOG_DB_ERR, "Table `game_graveyard_zone` has a duplicate record for Graveyard (ID: %u) and Zone (ID: %u), skipped.",safeLocId,zoneId);
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u graveyard-zone links", count);
}

WorldSafeLocsEntry const *ObjectMgr::GetClosestGraveYard(float x, float y, float z, uint32 MapId, uint32 team)
{
    // search for zone associated closest graveyard
    uint32 zoneId = sTerrainMgr.GetZoneId(MapId,x,y,z);

    // Simulate std. algorithm:
    //   found some graveyard associated to (ghost_zone,ghost_map)
    //
    //   if mapId == graveyard.mapId (ghost in plain zone or city or battleground) and search graveyard at same map
    //     then check faction
    //   if mapId != graveyard.mapId (ghost in instance) and search any graveyard associated
    //     then check faction
    GraveYardMap::const_iterator graveLow  = mGraveYardMap.lower_bound(zoneId);
    GraveYardMap::const_iterator graveUp   = mGraveYardMap.upper_bound(zoneId);
    if (graveLow==graveUp)
    {
        sLog.outDebug("Table `game_graveyard_zone` incomplete: Zone %u Team %u does not have a linked graveyard.",zoneId,team);
        return NULL;
    }

    // at corpse map
    bool foundNear = false;
    float distNear;
    WorldSafeLocsEntry const* entryNear = NULL;

    // at entrance map for corpse map
    bool foundEntr = false;
    float distEntr;
    WorldSafeLocsEntry const* entryEntr = NULL;

    // some where other
    WorldSafeLocsEntry const* entryFar = NULL;

    MapEntry const* mapEntry = sMapStore.LookupEntry(MapId);

    for (GraveYardMap::const_iterator itr = graveLow; itr != graveUp; ++itr)
    {
        GraveYardData const& data = itr->second;

        WorldSafeLocsEntry const* entry = sWorldSafeLocsStore.LookupEntry(data.safeLocId);
        if (!entry)
        {
            sLog.outLog(LOG_DB_ERR, "Table `game_graveyard_zone` has record for not existing graveyard (WorldSafeLocs.dbc id) %u, skipped.",data.safeLocId);
            continue;
        }

        // skip enemy faction graveyard
        // team == 0 case can be at call from .neargrave
        if (data.team != 0 && team != 0 && data.team != team)
            continue;

        // find now nearest graveyard at other map
        if (MapId != entry->map_id)
        {
            // if find graveyard at different map from where entrance placed (or no entrance data), use any first
            if (!mapEntry || mapEntry->entrance_map < 0 || mapEntry->entrance_map != entry->map_id ||
                mapEntry->entrance_x == 0 && mapEntry->entrance_y == 0)
            {
                // not have any corrdinates for check distance anyway
                entryFar = entry;
                continue;
            }

            // at entrance map calculate distance (2D);
            float dist2 = (entry->x - mapEntry->entrance_x)*(entry->x - mapEntry->entrance_x)
                +(entry->y - mapEntry->entrance_y)*(entry->y - mapEntry->entrance_y);
            if (foundEntr)
            {
                if (dist2 < distEntr)
                {
                    distEntr = dist2;
                    entryEntr = entry;
                }
            }
            else
            {
                foundEntr = true;
                distEntr = dist2;
                entryEntr = entry;
            }
        }
        // find now nearest graveyard at same map
        else
        {
            float dist2 = (entry->x - x)*(entry->x - x)+(entry->y - y)*(entry->y - y)+(entry->z - z)*(entry->z - z);
            if (foundNear)
            {
                if (dist2 < distNear)
                {
                    distNear = dist2;
                    entryNear = entry;
                }
            }
            else
            {
                foundNear = true;
                distNear = dist2;
                entryNear = entry;
            }
        }
    }

    if (entryNear)
        return entryNear;

    if (entryEntr)
        return entryEntr;

    return entryFar;
}

GraveYardData const* ObjectMgr::FindGraveYardData(uint32 id, uint32 zoneId)
{
    GraveYardMap::const_iterator graveLow  = mGraveYardMap.lower_bound(zoneId);
    GraveYardMap::const_iterator graveUp   = mGraveYardMap.upper_bound(zoneId);

    for (GraveYardMap::const_iterator itr = graveLow; itr != graveUp; ++itr)
    {
        if (itr->second.safeLocId==id)
            return &itr->second;
    }

    return NULL;
}

bool ObjectMgr::AddGraveYardLink(uint32 id, uint32 zoneId, uint32 team, bool inDB)
{
    if (FindGraveYardData(id,zoneId))
        return false;

    // add link to loaded data
    GraveYardData data;
    data.safeLocId = id;
    data.team = team;

    mGraveYardMap.insert(GraveYardMap::value_type(zoneId,data));

    // add link to DB
    if (inDB)
    {
        GameDataDatabase.PExecuteLog("INSERT INTO game_graveyard_zone (id,ghost_zone,faction) "
            "VALUES ('%u', '%u','%u')",id,zoneId,team);
    }

    return true;
}

void ObjectMgr::RemoveGraveYardLink(uint32 id, uint32 zoneId, uint32 team, bool inDB)
{
    GraveYardMap::iterator graveLow  = mGraveYardMap.lower_bound(zoneId);
    GraveYardMap::iterator graveUp   = mGraveYardMap.upper_bound(zoneId);
    if (graveLow==graveUp)
    {
        //sLog.outLog(LOG_DB_ERR, "Table `game_graveyard_zone` incomplete: Zone %u Team %u does not have a linked graveyard.",zoneId,team);
        return;
    }

    bool found = false;

    GraveYardMap::iterator itr;

    for (itr = graveLow; itr != graveUp; ++itr)
    {
        GraveYardData & data = itr->second;

        // skip not matching safezone id
        if (data.safeLocId != id)
            continue;

        // skip enemy faction graveyard at same map (normal area, city, or battleground)
        // team == 0 case can be at call from .neargrave
        if (data.team != 0 && team != 0 && data.team != team)
            continue;

        found = true;
        break;
    }

    // no match, return
    if (!found)
        return;

    // remove from links
    mGraveYardMap.erase(itr);

    // remove link from DB
    if (inDB)
    {
        GameDataDatabase.PExecute("DELETE FROM game_graveyard_zone WHERE id = '%u' AND ghost_zone = '%u' AND faction = '%u'",id,zoneId,team);
    }

    return;
}


void ObjectMgr::LoadAreaTriggerTeleports()
{
    mAreaTriggers.clear();                                  // need for reload case

    uint32 count = 0;

    //                                                       0       1           2              3               4                   5                   6
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT id, access_id, target_map, target_position_x, target_position_y, target_position_z, target_orientation FROM areatrigger_teleport");
    if (!result)
    {

        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u area trigger teleport definitions", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();

        bar.step();

        ++count;

        uint32 Trigger_ID = fields[0].GetUInt32();

        AreaTrigger at;

        at.access_id                = fields[1].GetUInt32();
        at.target_mapId             = fields[2].GetUInt32();
        at.target_X                 = fields[3].GetFloat();
        at.target_Y                 = fields[4].GetFloat();
        at.target_Z                 = fields[5].GetFloat();
        at.target_Orientation       = fields[6].GetFloat();

        AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(Trigger_ID);
        if (!atEntry)
        {
            sLog.outLog(LOG_DB_ERR, "Area trigger (ID:%u) does not exist in `AreaTrigger.dbc`.",Trigger_ID);
            continue;
        }

        MapEntry const* mapEntry = sMapStore.LookupEntry(at.target_mapId);
        if (!mapEntry)
        {
            sLog.outLog(LOG_DB_ERR, "Area trigger (ID:%u) target map (ID: %u) does not exist in `Map.dbc`.",Trigger_ID,at.target_mapId);
            continue;
        }

        if (at.target_X==0 && at.target_Y==0 && at.target_Z==0)
        {
            sLog.outLog(LOG_DB_ERR, "Area trigger (ID:%u) target coordinates not provided.",Trigger_ID);
            continue;
        }

        mAreaTriggers[Trigger_ID] = at;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u area trigger teleport definitions", count);
}

void ObjectMgr::LoadAccessRequirements()
{
    mAccessRequirements.clear();                                  // need for reload case

    uint32 count = 0;

    //                                                       0       1          2       3      4        5           6             7              8                   9                  10                11           12
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT id, level_min, level_max, item, item2, heroic_key, heroic_key2, quest_done, quest_failed_text, heroic_quest_done, heroic_quest_failed_text, aura_id, missing_aura_text FROM access_requirement");
    if (!result)
    {

        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u access requirement definitions", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();

        bar.step();

        ++count;

        uint32 requiremt_ID = fields[0].GetUInt32();

        AccessRequirement ar;

        ar.levelMin                 = fields[1].GetUInt8();
        ar.levelMax                 = fields[2].GetUInt32();
        ar.item                     = fields[3].GetUInt32();
        ar.item2                    = fields[4].GetUInt32();
        ar.heroicKey                = fields[5].GetUInt32();
        ar.heroicKey2               = fields[6].GetUInt32();
        ar.quest                    = fields[7].GetUInt32();
        ar.questFailedText          = fields[8].GetCppString();
        ar.heroicQuest              = fields[9].GetUInt32();
        ar.heroicQuestFailedText    = fields[10].GetCppString();
        ar.auraId                   = fields[11].GetUInt32();
        ar.missingAuraText          = fields[12].GetCppString();

        if (ar.item)
        {
            ItemPrototype const *pProto = GetItemPrototype(ar.item);
            if (!pProto)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Key item %u does not exist for requirement %u, removing key requirement.", ar.item, requiremt_ID);
                ar.item = 0;
            }
        }

        if (ar.item2)
        {
            ItemPrototype const *pProto = GetItemPrototype(ar.item2);
            if (!pProto)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Second item %u does not exist for requirement %u, removing key requirement.", ar.item2, requiremt_ID);
                ar.item2 = 0;
            }
        }

        if (ar.heroicKey)
        {
            ItemPrototype const *pProto = GetItemPrototype(ar.heroicKey);
            if (!pProto)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Heroic key %u not exist for trigger %u, remove key requirement.", ar.heroicKey, requiremt_ID);
                ar.heroicKey = 0;
            }
        }

        if (ar.heroicKey2)
        {
            ItemPrototype const *pProto = GetItemPrototype(ar.heroicKey2);
            if (!pProto)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Second heroic key %u not exist for trigger %u, remove key requirement.", ar.heroicKey2, requiremt_ID);
                ar.heroicKey2 = 0;
            }
        }

        if (ar.heroicQuest)
        {
            if (!GetQuestTemplate(ar.heroicQuest))
            {
                sLog.outLog(LOG_DB_ERR, "Required Heroic Quest %u not exist for trigger %u, remove heroic quest done requirement.",ar.heroicQuest,requiremt_ID);
                ar.heroicQuest = 0;
            }
        }

        if (ar.quest)
        {
            if (!GetQuestTemplate(ar.quest))
            {
                sLog.outLog(LOG_DB_ERR, "Required Quest %u not exist for trigger %u, remove quest done requirement.",ar.quest,requiremt_ID);
                ar.quest = 0;
            }
        }

        if (ar.auraId)
        {
            if (!GetSpellStore()->LookupEntry(ar.auraId))
            {
                sLog.outLog(LOG_DB_ERR, "Required aura %u not exist for trigger %u, remove aura requirement.", ar.auraId, requiremt_ID);
                ar.auraId = 0;
            }
        }

        mAccessRequirements[requiremt_ID] = ar;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u access requirement definitions", count);
}

AreaTrigger const* ObjectMgr::GetGoBackTrigger(uint32 Map) const
{
    const MapEntry *mapEntry = sMapStore.LookupEntry(Map);
    if (!mapEntry) return NULL;
    for (AreaTriggerMap::const_iterator itr = mAreaTriggers.begin(); itr != mAreaTriggers.end(); ++itr)
    {
        if (itr->second.target_mapId == mapEntry->entrance_map)
        {
            AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(itr->first);
            if (atEntry && atEntry->mapid == Map)
                return &itr->second;
        }
    }
    return NULL;
}

/**
 * Searches for the areatrigger which teleports players to the given map
 */
AreaTrigger const* ObjectMgr::GetMapEntranceTrigger(uint32 Map) const
{
    for (AreaTriggerMap::const_iterator itr = mAreaTriggers.begin(); itr != mAreaTriggers.end(); ++itr)
    {
        if (itr->second.target_mapId == Map)
        {
            AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(itr->first);
            if (atEntry)
                return &itr->second;
        }
    }
    return NULL;
}

void ObjectMgr::SetHighestGuids()
{
    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT MAX(guid) FROM characters");
    if (result)
        m_hiCharGuid = (*result)[0].GetUInt32()+1;

    result = GameDataDatabase.Query("SELECT MAX(guid) FROM creature");
    if (result)
        m_hiCreatureGuid = (*result)[0].GetUInt32()+1;

    result = RealmDataDatabase.Query("SELECT MAX(guid) FROM item_instance");
    if (result)
        m_hiItemGuid = (*result)[0].GetUInt32()+1;

    // Cleanup other tables from not existed guids (>=m_hiItemGuid)
    RealmDataDatabase.BeginTransaction();
    RealmDataDatabase.PExecute("DELETE FROM character_inventory WHERE item >= '%u'", m_hiItemGuid);
    RealmDataDatabase.PExecute("DELETE FROM mail_items WHERE item_guid >= '%u'", m_hiItemGuid);
    RealmDataDatabase.PExecute("DELETE FROM auctionhouse WHERE itemguid >= '%u'", m_hiItemGuid);
    RealmDataDatabase.PExecute("DELETE FROM guild_bank_item WHERE item_guid >= '%u'", m_hiItemGuid);
    RealmDataDatabase.CommitTransaction();

    result = GameDataDatabase.Query("SELECT MAX(guid) FROM gameobject");
    if (result)
        m_hiGoGuid = (*result)[0].GetUInt32()+1;

    result = RealmDataDatabase.Query("SELECT MAX(id) FROM auctionhouse");
    if (result)
        m_auctionid = (*result)[0].GetUInt32()+1;

    result = RealmDataDatabase.Query("SELECT MAX(id) FROM mail");
    if (result)
        m_mailid = (*result)[0].GetUInt32()+1;

    result = RealmDataDatabase.Query("SELECT MAX(id) FROM item_text");
    if (result)
        m_ItemTextId = (*result)[0].GetUInt32()+1;

    result = RealmDataDatabase.Query("SELECT MAX(guid) FROM corpse");
    if (result)
        m_hiCorpseGuid = (*result)[0].GetUInt32()+1;

    result = RealmDataDatabase.Query("SELECT MAX(arenateamid) FROM arena_team");
    if (result)
        m_arenaTeamId = (*result)[0].GetUInt32()+1;
}

uint32 ObjectMgr::GenerateArenaTeamId()
{
    if (m_arenaTeamId>=0xFFFFFFFE)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Arena team ids overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return m_arenaTeamId++;
}

uint32 ObjectMgr::GenerateAuctionID()
{
    if (m_auctionid>=0xFFFFFFFE)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Auctions ids overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return m_auctionid++;
}

uint32 ObjectMgr::GenerateMailID()
{
    if (m_mailid>=0xFFFFFFFE)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Mail ids overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return m_mailid++;
}

uint32 ObjectMgr::GenerateItemTextID()
{
    if (m_ItemTextId>=0xFFFFFFFE)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Item text ids overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return m_ItemTextId++;
}

uint32 ObjectMgr::CreateItemText(std::string text)
{
    uint32 newItemTextId = GenerateItemTextID();
    //insert new itempage to container
    mItemTexts[ newItemTextId ] = text;
    //save new itempage
    RealmDataDatabase.escape_string(text);
    //any Delete query needed, itemTextId is maximum of all ids
    std::ostringstream query;
    query << "INSERT INTO item_text (id,text) VALUES ('" << newItemTextId << "', '" << text << "')";
    RealmDataDatabase.Execute(query.str().c_str());         //needs to be run this way, because mail body may be more than 1024 characters
    return newItemTextId;
}

uint32 ObjectMgr::GenerateLowGuid(HighGuid guidhigh)
{
    switch (guidhigh)
    {
        case HIGHGUID_ITEM:
            if (m_hiItemGuid>=0xFFFFFFFE)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Item guid overflow!! Can't continue, shutting down server. ");
                World::StopNow(ERROR_EXIT_CODE);
            }
            return m_hiItemGuid++;
        case HIGHGUID_UNIT:
            if (m_hiCreatureGuid>=0xFFFFFFFE)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Creature guid overflow!! Can't continue, shutting down server. ");
                World::StopNow(ERROR_EXIT_CODE);
            }
            return m_hiCreatureGuid++;
        case HIGHGUID_PET:
            if (m_hiPetGuid>=0x00FFFFFE)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Pet guid overflow!! Can't continue, shutting down server. ");
                World::StopNow(ERROR_EXIT_CODE);
            }
            return m_hiPetGuid++;
        case HIGHGUID_PLAYER:
            if (m_hiCharGuid>=0xFFFFFFFE)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Players guid overflow!! Can't continue, shutting down server. ");
                World::StopNow(ERROR_EXIT_CODE);
            }
            return m_hiCharGuid++;
        case HIGHGUID_GAMEOBJECT:
            if (m_hiGoGuid>=0x00FFFFFE)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Gameobject guid overflow!! Can't continue, shutting down server. ");
                World::StopNow(ERROR_EXIT_CODE);
            }
            return m_hiGoGuid++;
        case HIGHGUID_CORPSE:
            if (m_hiCorpseGuid>=0xFFFFFFFE)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Corpse guid overflow!! Can't continue, shutting down server. ");
                World::StopNow(ERROR_EXIT_CODE);
            }
            return m_hiCorpseGuid++;
        case HIGHGUID_DYNAMICOBJECT:
            if (m_hiDoGuid>=0xFFFFFFFE)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: DynamicObject guid overflow!! Can't continue, shutting down server. ");
                World::StopNow(ERROR_EXIT_CODE);
            }
            return m_hiDoGuid++;
        default:
            ASSERT(0);
    }

    ASSERT(0);
    return 0;
}

void ObjectMgr::LoadGameObjectLocales()
{
    mGameObjectLocaleMap.clear();                           // need for reload case

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry,"
        "name_loc1,name_loc2,name_loc3,name_loc4,name_loc5,name_loc6,name_loc7,name_loc8,"
        "castbarcaption_loc1,castbarcaption_loc2,castbarcaption_loc3,castbarcaption_loc4,"
        "castbarcaption_loc5,castbarcaption_loc6,castbarcaption_loc7,castbarcaption_loc8 FROM locales_gameobject");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outString(">> Loaded 0 gameobject locale strings. DB table `locales_gameobject` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 entry = fields[0].GetUInt32();

        GameObjectLocale& data = mGameObjectLocaleMap[entry];

        for (int i = 1; i < MAX_LOCALE; ++i)
        {
            std::string str = fields[i].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.Name.size() <= idx)
                        data.Name.resize(idx+1);

                    data.Name[idx] = str;
                }
            }
        }

        for(int i = 1; i < MAX_LOCALE; ++i)
        {
            std::string str = fields[i+(MAX_LOCALE-1)].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    if (data.CastBarCaption.size() <= idx)
                        data.CastBarCaption.resize(idx+1);

                    data.CastBarCaption[idx] = str;
                }
            }
        }

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u gameobject locale strings", mGameObjectLocaleMap.size());
}

struct SQLGameObjectLoader : public SQLStorageLoaderBase<SQLGameObjectLoader>
{
    template<class D>
    void convert_from_str(uint32 field_pos, const char *src, D &dst)
    {
        dst = D(sScriptMgr.GetScriptId(src));
    }
};

inline void CheckGOLockId(GameObjectInfo const* goInfo, uint32 dataN, uint32 N)
{
    if (sLockStore.LookupEntry(dataN))
        return;

    sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u GoType: %u) have data%d=%u but lock (Id: %u) not found.",
        goInfo->id, goInfo->type, N, goInfo->door.lockId, goInfo->door.lockId);
}

inline void CheckGOLinkedTrapId(GameObjectInfo const* goInfo, uint32 dataN, uint32 N)
{
    if (GameObjectInfo const* trapInfo = sGOStorage.LookupEntry<GameObjectInfo>(dataN))
    {
        if (trapInfo->type != GAMEOBJECT_TYPE_TRAP)
            sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u GoType: %u) have data%d=%u but GO (Entry %u) have not GAMEOBJECT_TYPE_TRAP (%u) type.",
            goInfo->id, goInfo->type, N, dataN, dataN, GAMEOBJECT_TYPE_TRAP);
    }
    /* disable check for while (too many error reports baout not existed in trap templates
    else
        sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u GoType: %u) have data%d=%u but trap GO (Entry %u) not exist in `gameobject_template`.",
            goInfo->id,goInfo->type,N,dataN,dataN);
    */
}

inline void CheckGOSpellId(GameObjectInfo const* goInfo, uint32 dataN, uint32 N)
{
    if (sSpellStore.LookupEntry(dataN))
        return;

    sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u GoType: %u) have data%d=%u but Spell (Entry %u) not exist.",
        goInfo->id, goInfo->type, N, dataN, dataN);
}

inline void CheckAndFixGOChairHeightId(GameObjectInfo const* goInfo, uint32 const& dataN, uint32 N)
{
    if (dataN <= (PLAYER_STATE_SIT_HIGH_CHAIR-PLAYER_STATE_SIT_LOW_CHAIR) )
        return;

    sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u GoType: %u) have data%d=%u but correct chair height in range 0..%i.",
        goInfo->id, goInfo->type, N, dataN, PLAYER_STATE_SIT_HIGH_CHAIR-PLAYER_STATE_SIT_LOW_CHAIR);

    // prevent client and server unexpected work
    const_cast<uint32&>(dataN) = 0;
}

inline void CheckGONoDamageImmuneId(GameObjectInfo const* goInfo, uint32 dataN, uint32 N)
{
    // 0/1 correct values
    if (dataN <= 1)
        return;

    sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u GoType: %u) have data%d=%u but expected boolean (0/1) noDamageImmune field value.",
        goInfo->id, goInfo->type, N, dataN);
}

void ObjectMgr::LoadGameobjectInfo()
{
    SQLGameObjectLoader loader;
    loader.Load(sGOStorage);

    // some checks
    for (uint32 id = 1; id < sGOStorage.MaxEntry; id++)
    {
        GameObjectInfo const* goInfo = sGOStorage.LookupEntry<GameObjectInfo>(id);
        if (!goInfo)
            continue;

        switch (goInfo->type)
        {
            case GAMEOBJECT_TYPE_DOOR:                      //0
            {
                if (goInfo->door.lockId)
                    CheckGOLockId(goInfo, goInfo->door.lockId, 1);
                CheckGONoDamageImmuneId(goInfo, goInfo->door.noDamageImmune, 3);
                break;
            }
            case GAMEOBJECT_TYPE_BUTTON:                    //1
            {
                if (goInfo->button.lockId)
                    CheckGOLockId(goInfo, goInfo->button.lockId, 1);
                CheckGONoDamageImmuneId(goInfo, goInfo->button.noDamageImmune, 4);
                break;
            }
            case GAMEOBJECT_TYPE_QUESTGIVER:                //2
            {
                if (goInfo->questgiver.lockId)
                    CheckGOLockId(goInfo, goInfo->questgiver.lockId, 0);
                CheckGONoDamageImmuneId(goInfo, goInfo->questgiver.noDamageImmune, 5);
                break;
            }
            case GAMEOBJECT_TYPE_CHEST:                     //3
            {
                if (goInfo->chest.lockId)
                    CheckGOLockId(goInfo, goInfo->chest.lockId, 0);

                if (goInfo->chest.linkedTrapId)              // linked trap
                    CheckGOLinkedTrapId(goInfo, goInfo->chest.linkedTrapId, 7);
                break;
            }
            case GAMEOBJECT_TYPE_TRAP:                      //6
            {
                if(goInfo->trap.lockId)
                    CheckGOLockId(goInfo, goInfo->trap.lockId, 0);

                /* disable check for while, too many not existed spells
                if (goInfo->trap.spellId)                   // spell
                    CheckGOSpellId(goInfo, goInfo->trap.spellId, 3);
                */
                break;
            }
            case GAMEOBJECT_TYPE_CHAIR:                     //7
                CheckAndFixGOChairHeightId(goInfo, goInfo->chair.height, 1);
                break;
            case GAMEOBJECT_TYPE_SPELL_FOCUS:               //8
            {
                if (goInfo->spellFocus.focusId)
                {
                    if (!sSpellFocusObjectStore.LookupEntry(goInfo->spellFocus.focusId))
                        sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u GoType: %u) have data0=%u but SpellFocus (Id: %u) not exist.",
                            id,goInfo->type,goInfo->spellFocus.focusId,goInfo->spellFocus.focusId);
                }

                if (goInfo->spellFocus.linkedTrapId)         // linked trap
                    CheckGOLinkedTrapId(goInfo, goInfo->spellFocus.linkedTrapId, 2);
                break;
            }
            case GAMEOBJECT_TYPE_GOOBER:                    //10
            {
                if(goInfo->goober.lockId)
                    CheckGOLockId(goInfo, goInfo->goober.lockId, 0);

                if (goInfo->goober.pageId)                   // pageId
                {
                    if (!sPageTextStore.LookupEntry<PageText>(goInfo->goober.pageId))
                        sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u GoType: %u) have data7=%u but PageText (Entry %u) not exist.",
                            id,goInfo->type,goInfo->goober.pageId,goInfo->goober.pageId);
                }
                /* disable check for while, too many not existed spells
                if (goInfo->goober.spellId)                 // spell
                    CheckGOSpellId(goInfo, goInfo->goober.spellId, 10);
                */
                CheckGONoDamageImmuneId(goInfo, goInfo->goober.noDamageImmune, 11);
                if (goInfo->goober.linkedTrapId)             // linked trap
                    CheckGOLinkedTrapId(goInfo, goInfo->goober.linkedTrapId, 12);
                break;
            }
            case GAMEOBJECT_TYPE_AREADAMAGE:                //12
            {
                if (goInfo->areadamage.lockId)
                    CheckGOLockId(goInfo, goInfo->areadamage.lockId, 0);
                break;
            }
            case GAMEOBJECT_TYPE_CAMERA:                    //13
            {
                if (goInfo->camera.lockId)
                    CheckGOLockId(goInfo, goInfo->camera.lockId, 0);
                break;
            }
            case GAMEOBJECT_TYPE_MO_TRANSPORT:              //15
            {
                if (goInfo->moTransport.taxiPathId)
                {
                    if (goInfo->moTransport.taxiPathId >= sTaxiPathNodesByPath.size() || sTaxiPathNodesByPath[goInfo->moTransport.taxiPathId].empty())
                        sLog.outLog(LOG_DB_ERR, "Gameobject (Entry: %u GoType: %u) have data0=%u but TaxiPath (Id: %u) not exist.",
                            id,goInfo->type,goInfo->moTransport.taxiPathId,goInfo->moTransport.taxiPathId);
                }
                break;
            }
            case GAMEOBJECT_TYPE_SUMMONING_RITUAL:          //18
            {
                /* disable check for while, too many not existed spells
                // always must have spell
                CheckGOSpellId(goInfo, goInfo->summoningRitual.spellId, 1);
                */
                break;
            }
            case GAMEOBJECT_TYPE_SPELLCASTER:               //22
            {
                // always must have spell
                CheckGOSpellId(goInfo, goInfo->spellcaster.spellId, 0);
                break;
            }
            case GAMEOBJECT_TYPE_FLAGSTAND:                 //24
            {
                if (goInfo->flagstand.lockId)
                    CheckGOLockId(goInfo, goInfo->flagstand.lockId, 0);
                CheckGONoDamageImmuneId(goInfo, goInfo->flagstand.noDamageImmune, 5);
                break;
            }
            case GAMEOBJECT_TYPE_FISHINGHOLE:               //25
            {
                if (goInfo->fishinghole.lockId)
                    CheckGOLockId(goInfo, goInfo->fishinghole.lockId, 4);
                break;
            }
            case GAMEOBJECT_TYPE_FLAGDROP:                  //26
            {
                if (goInfo->flagdrop.lockId)
                    CheckGOLockId(goInfo, goInfo->flagdrop.lockId, 0);
                CheckGONoDamageImmuneId(goInfo, goInfo->flagdrop.noDamageImmune, 3);
                break;
            }
        }
    }

    sLog.outString(">> Loaded %u game object templates", sGOStorage.RecordCount);
    sLog.outString();
}

void ObjectMgr::LoadExplorationBaseXP()
{
    uint32 count = 0;
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT level,basexp FROM exploration_basexp");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u BaseXP definitions", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        bar.step();

        Field *fields = result->Fetch();
        uint32 level  = fields[0].GetUInt32();
        uint32 basexp = fields[1].GetUInt32();
        mBaseXPTable[level] = basexp;
        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u BaseXP definitions", count);
}

uint32 ObjectMgr::GetBaseXP(uint32 level)
{
    return mBaseXPTable[level] ? mBaseXPTable[level] : 0;
}

void ObjectMgr::LoadPetNames()
{
    uint32 count = 0;
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT word,entry,half FROM pet_name_generation");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u pet name parts", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        bar.step();

        Field *fields = result->Fetch();
        std::string word = fields[0].GetString();
        uint32 entry     = fields[1].GetUInt32();
        bool   half      = fields[2].GetBool();
        if (half)
            PetHalfName1[entry].push_back(word);
        else
            PetHalfName0[entry].push_back(word);
        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u pet name parts", count);
}

void ObjectMgr::LoadPetNumber()
{
    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT MAX(id) FROM character_pet");
    if (result)
    {
        Field *fields = result->Fetch();
        m_hiPetNumber = fields[0].GetUInt32()+1;
    }

    BarGoLink bar(1);
    bar.step();

    sLog.outString();
    sLog.outString(">> Loaded the max pet number: %d", m_hiPetNumber-1);
}

std::string ObjectMgr::GeneratePetName(uint32 entry)
{
    std::vector<std::string> & list0 = PetHalfName0[entry];
    std::vector<std::string> & list1 = PetHalfName1[entry];

    if (list0.empty() || list1.empty())
    {
        CreatureInfo const *cinfo = GetCreatureTemplate(entry);
        char* petname = GetPetName(cinfo->family, sWorld.GetDefaultDbcLocale());
        if (!petname)
            petname = cinfo->Name;
        return std::string(petname);
    }

    return *(list0.begin()+urand(0, list0.size()-1)) + *(list1.begin()+urand(0, list1.size()-1));
}

uint32 ObjectMgr::GeneratePetNumber()
{
    return ++m_hiPetNumber;
}

void ObjectMgr::LoadCorpses()
{
    uint32 count = 0;
    //                                                           0           1           2           3            4    5     6     7            8         10
    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT position_x, position_y, position_z, orientation, map, data, time, corpse_type, instance, guid FROM corpse WHERE corpse_type <> 0");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u corpses", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        bar.step();

        Field *fields = result->Fetch();

        uint32 guid = fields[result->GetFieldCount()-1].GetUInt32();

        Corpse *corpse = new Corpse;
        if (!corpse->LoadFromDB(guid,fields))
        {
            delete corpse;
            continue;
        }

        sObjectAccessor.AddCorpse(corpse);

        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u corpses", count);
}

void ObjectMgr::LoadReputationRewardRate()
{
    m_RepRewardRateMap.clear();         // for reload case

    uint32 count = 0;
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT faction, quest_rate, creature_rate, spell_rate FROM reputation_reward_rate");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded `reputation_reward_rate`, table is empty!");
        return;
    }

    BarGoLink bar((int)result->GetRowCount());

    do
    {
        bar.step();

        Field *fields = result->Fetch();

        uint32 factionId        = fields[0].GetUInt32();

        RepRewardRate repRate;

        repRate.quest_rate      = fields[1].GetFloat();
        repRate.creature_rate   = fields[2].GetFloat();
        repRate.spell_rate      = fields[3].GetFloat();

        FactionEntry const *factionEntry = sFactionStore.LookupEntry(factionId);
        if (!factionEntry)
        {
            sLog.outLog(LOG_DB_ERR, "Faction (faction.dbc) %u does not exist but is used in `reputation_reward_rate`", factionId);
            continue;
        }

        if (repRate.quest_rate < 0.0f)
        {
            sLog.outLog(LOG_DB_ERR, "Table reputation_reward_rate has quest_rate with invalid rate %f, skipping data for faction %u", repRate.quest_rate, factionId);
            continue;
        }

        if (repRate.creature_rate < 0.0f)
        {
            sLog.outLog(LOG_DB_ERR, "Table reputation_reward_rate has creature_rate with invalid rate %f, skipping data for faction %u", repRate.creature_rate, factionId);
            continue;
        }

        if (repRate.spell_rate < 0.0f)
        {
            sLog.outLog(LOG_DB_ERR, "Table reputation_reward_rate has spell_rate with invalid rate %f, skipping data for faction %u", repRate.spell_rate, factionId);
            continue;
        }

        m_RepRewardRateMap[factionId] = repRate;

        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u reputation_reward_rate", count);
}

void ObjectMgr::LoadReputationOnKill()
{
    uint32 count = 0;

    //                                                       0            1                     2
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT creature_id, RewOnKillRepFaction1, RewOnKillRepFaction2,"
    //   3             4             5                   6             7             8                   9
        "IsTeamAward1, MaxStanding1, RewOnKillRepValue1, IsTeamAward2, MaxStanding2, RewOnKillRepValue2, TeamDependent "
        "FROM creature_onkill_reputation");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded 0 creature award reputation definitions. DB table `creature_onkill_reputation` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 creature_id = fields[0].GetUInt32();

        ReputationOnKillEntry repOnKill;
        repOnKill.repfaction1          = fields[1].GetUInt32();
        repOnKill.repfaction2          = fields[2].GetUInt32();
        repOnKill.is_teamaward1        = fields[3].GetBool();
        repOnKill.reputation_max_cap1  = fields[4].GetUInt32();
        repOnKill.repvalue1            = fields[5].GetInt32();
        repOnKill.is_teamaward2        = fields[6].GetBool();
        repOnKill.reputation_max_cap2  = fields[7].GetUInt32();
        repOnKill.repvalue2            = fields[8].GetInt32();
        repOnKill.team_dependent       = fields[9].GetUInt8();

        if (!GetCreatureTemplate(creature_id))
        {
            sLog.outLog(LOG_DB_ERR, "Table `creature_onkill_reputation` have data for not existed creature entry (%u), skipped",creature_id);
            continue;
        }

        if (repOnKill.repfaction1)
        {
            FactionEntry const *factionEntry1 = sFactionStore.LookupEntry(repOnKill.repfaction1);
            if (!factionEntry1)
            {
                sLog.outLog(LOG_DB_ERR, "Faction (faction.dbc) %u does not exist but is used in `creature_onkill_reputation`",repOnKill.repfaction1);
                continue;
            }
        }

        if (repOnKill.repfaction2)
        {
            FactionEntry const *factionEntry2 = sFactionStore.LookupEntry(repOnKill.repfaction2);
            if (!factionEntry2)
            {
                sLog.outLog(LOG_DB_ERR, "Faction (faction.dbc) %u does not exist but is used in `creature_onkill_reputation`",repOnKill.repfaction2);
                continue;
            }
        }

        mRepOnKill[creature_id] = repOnKill;

        ++count;
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u creature award reputation definitions", count);
}

void ObjectMgr::LoadReputationSpilloverTemplate()
{
    m_RepSpilloverTemplateMap.clear(); // for reload case

    uint32 count = 0;
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT faction, faction1, rate_1, rank_1, faction2, rate_2, rank_2, faction3, rate_3, rank_3, faction4, rate_4, rank_4 FROM reputation_spillover_template");

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded `reputation_spillover_template`, table is empty!");
        return;
    }

    BarGoLink bar((int)result->GetRowCount());

    do
    {
        bar.step();

        Field *fields = result->Fetch();

        uint32 factionId                = fields[0].GetUInt32();

        RepSpilloverTemplate repTemplate;

        repTemplate.faction[0]          = fields[1].GetUInt32();
        repTemplate.faction_rate[0]     = fields[2].GetFloat();
        repTemplate.faction_rank[0]     = fields[3].GetUInt32();
        repTemplate.faction[1]          = fields[4].GetUInt32();
        repTemplate.faction_rate[1]     = fields[5].GetFloat();
        repTemplate.faction_rank[1]     = fields[6].GetUInt32();
        repTemplate.faction[2]          = fields[7].GetUInt32();
        repTemplate.faction_rate[2]     = fields[8].GetFloat();
        repTemplate.faction_rank[2]     = fields[9].GetUInt32();
        repTemplate.faction[3]          = fields[10].GetUInt32();
        repTemplate.faction_rate[3]     = fields[11].GetFloat();
        repTemplate.faction_rank[3]     = fields[12].GetUInt32();

        FactionEntry const *factionEntry = sFactionStore.LookupEntry(factionId);

        if (!factionEntry)
        {
            sLog.outLog(LOG_DB_ERR, "Faction (faction.dbc) %u does not exist but is used in `reputation_spillover_template`", factionId);
            continue;
        }

        if (factionEntry->team == 0)
        {
            sLog.outLog(LOG_DB_ERR, "Faction (faction.dbc) %u in `reputation_spillover_template` does not belong to any team, skipping", factionId);
            continue;
        }

        for (uint32 i = 0; i < MAX_SPILLOVER_FACTIONS; ++i)
        {
            if (repTemplate.faction[i])
            {
                FactionEntry const *factionSpillover = sFactionStore.LookupEntry(repTemplate.faction[i]);

                if (!factionSpillover)
                {
                    sLog.outLog(LOG_DB_ERR, "Spillover faction (faction.dbc) %u does not exist but is used in `reputation_spillover_template` for faction %u, skipping", repTemplate.faction[i], factionId);
                    continue;
                }

                if (factionSpillover->reputationListID < 0)
                {
                    sLog.outLog(LOG_DB_ERR, "Spillover faction (faction.dbc) %u for faction %u in `reputation_spillover_template` can not be listed for client, and then useless, skipping", repTemplate.faction[i], factionId);
                    continue;
                }

                if (repTemplate.faction_rank[i] >= MAX_REPUTATION_RANK)
                {
                    sLog.outLog(LOG_DB_ERR, "Rank %u used in `reputation_spillover_template` for spillover faction %u is not valid, skipping", repTemplate.faction_rank[i], repTemplate.faction[i]);
                    continue;
                }
            }
        }

        FactionEntry const *factionEntry0 = sFactionStore.LookupEntry(repTemplate.faction[0]);
        if (repTemplate.faction[0] && !factionEntry0)
        {
            sLog.outLog(LOG_DB_ERR, "Faction (faction.dbc) %u does not exist but is used in `reputation_spillover_template`", repTemplate.faction[0]);
            continue;
        }

        FactionEntry const *factionEntry1 = sFactionStore.LookupEntry(repTemplate.faction[1]);
        if (repTemplate.faction[1] && !factionEntry1)
        {
            sLog.outLog(LOG_DB_ERR, "Faction (faction.dbc) %u does not exist but is used in `reputation_spillover_template`", repTemplate.faction[1]);
            continue;
        }

        FactionEntry const *factionEntry2 = sFactionStore.LookupEntry(repTemplate.faction[2]);
        if (repTemplate.faction[2] && !factionEntry2)
        {
            sLog.outLog(LOG_DB_ERR, "Faction (faction.dbc) %u does not exist but is used in `reputation_spillover_template`", repTemplate.faction[2]);
            continue;
        }

        FactionEntry const *factionEntry3 = sFactionStore.LookupEntry(repTemplate.faction[3]);
        if (repTemplate.faction[3] && !factionEntry3)
        {
            sLog.outLog(LOG_DB_ERR, "Faction (faction.dbc) %u does not exist but is used in `reputation_spillover_template`", repTemplate.faction[3]);
            continue;
        }

        m_RepSpilloverTemplateMap[factionId] = repTemplate;

        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u reputation_spillover_template", count);
}

void ObjectMgr::LoadWeatherZoneChances()
{
    uint32 count = 0;

    //                                                       0     1                   2                   3                    4                   5                   6                    7                 8                 9                  10                  11                  12
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT zone, spring_rain_chance, spring_snow_chance, spring_storm_chance, summer_rain_chance, summer_snow_chance, summer_storm_chance, fall_rain_chance, fall_snow_chance, fall_storm_chance, winter_rain_chance, winter_snow_chance, winter_storm_chance FROM game_weather");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded 0 weather definitions. DB table `game_weather` is empty.");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 zone_id = fields[0].GetUInt32();

        WeatherZoneChances& wzc = mWeatherZoneMap[zone_id];

        for (int season = 0; season < WEATHER_SEASONS; ++season)
        {
            wzc.data[season].rainChance  = fields[season * (MAX_WEATHER_TYPE-1) + 1].GetUInt32();
            wzc.data[season].snowChance  = fields[season * (MAX_WEATHER_TYPE-1) + 2].GetUInt32();
            wzc.data[season].stormChance = fields[season * (MAX_WEATHER_TYPE-1) + 3].GetUInt32();

            if (wzc.data[season].rainChance > 100)
            {
                wzc.data[season].rainChance = 25;
                sLog.outLog(LOG_DB_ERR, "Weather for zone %u season %u has wrong rain chance > 100%",zone_id,season);
            }

            if (wzc.data[season].snowChance > 100)
            {
                wzc.data[season].snowChance = 25;
                sLog.outLog(LOG_DB_ERR, "Weather for zone %u season %u has wrong snow chance > 100%",zone_id,season);
            }

            if (wzc.data[season].stormChance > 100)
            {
                wzc.data[season].stormChance = 25;
                sLog.outLog(LOG_DB_ERR, "Weather for zone %u season %u has wrong storm chance > 100%",zone_id,season);
            }
        }

        ++count;
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u weather definitions", count);
}

void ObjectMgr::SaveCreatureRespawnTime(uint32 loguid, uint32 instance, time_t t)
{
    mCreatureRespawnTimes[MAKE_PAIR64(loguid,instance)] = t;
    RealmDataDatabase.BeginTransaction();
    RealmDataDatabase.PExecute("DELETE FROM creature_respawn WHERE guid = '%u' AND instance = '%u'", loguid, instance);
    if (t)
        RealmDataDatabase.PExecute("INSERT INTO creature_respawn VALUES ('%u', '" UI64FMTD "', '%u')", loguid, uint64(t), instance);
    RealmDataDatabase.CommitTransaction();
}

void ObjectMgr::DeleteCreatureData(uint32 guid)
{
    // remove mapid*cellid -> guid_set map
    CreatureData const* data = GetCreatureData(guid);
    if (data)
        RemoveCreatureFromGrid(guid, data);

    mCreatureDataMap.erase(guid);
}

void ObjectMgr::SaveGORespawnTime(uint32 loguid, uint32 instance, time_t t)
{
    mGORespawnTimes[MAKE_PAIR64(loguid,instance)] = t;
    RealmDataDatabase.BeginTransaction();
    RealmDataDatabase.PExecute("DELETE FROM gameobject_respawn WHERE guid = '%u' AND instance = '%u'", loguid, instance);
    if (t)
        RealmDataDatabase.PExecute("INSERT INTO gameobject_respawn VALUES ('%u', '" UI64FMTD "', '%u')", loguid, uint64(t), instance);
    RealmDataDatabase.CommitTransaction();
}

void ObjectMgr::DeleteRespawnTimeForInstance(uint32 instance)
{
    RespawnTimes::iterator next;

    for (RespawnTimes::iterator itr = mGORespawnTimes.begin(); itr != mGORespawnTimes.end(); itr = next)
    {
        next = itr;
        ++next;

        if (GUID_HIPART(itr->first)==instance)
            mGORespawnTimes.erase(itr);
    }

    for (RespawnTimes::iterator itr = mCreatureRespawnTimes.begin(); itr != mCreatureRespawnTimes.end(); itr = next)
    {
        next = itr;
        ++next;

        if (GUID_HIPART(itr->first)==instance)
            mCreatureRespawnTimes.erase(itr);
    }

    RealmDataDatabase.BeginTransaction();
    RealmDataDatabase.PExecute("DELETE FROM creature_respawn WHERE instance = '%u'", instance);
    RealmDataDatabase.PExecute("DELETE FROM gameobject_respawn WHERE instance = '%u'", instance);
    RealmDataDatabase.CommitTransaction();
}

void ObjectMgr::DeleteGOData(uint32 guid)
{
    // remove mapid*cellid -> guid_set map
    GameObjectData const* data = GetGOData(guid);
    if (data)
        RemoveGameobjectFromGrid(guid, data);

    mGameObjectDataMap.erase(guid);
}

void ObjectMgr::AddCorpseCellData(uint32 mapid, uint32 cellid, uint32 player_guid, uint32 instance)
{
    // corpses are always added to spawn mode 0 and they are spawned by their instance id
    CellObjectGuids& cell_guids = mMapObjectGuids[MAKE_PAIR32(mapid,0)][cellid];
    cell_guids.corpses[player_guid] = instance;
}

void ObjectMgr::DeleteCorpseCellData(uint32 mapid, uint32 cellid, uint32 player_guid)
{
    // corpses are always added to spawn mode 0 and they are spawned by their instance id
    CellObjectGuids& cell_guids = mMapObjectGuids[MAKE_PAIR32(mapid,0)][cellid];
    cell_guids.corpses.erase(player_guid);
}

void ObjectMgr::LoadQuestRelationsHelper(QuestRelations& map,char const* table)
{
    map.clear();                                            // need for reload case

    uint32 count = 0;

    QueryResultAutoPtr result = GameDataDatabase.PQuery("SELECT id,quest FROM %s",table);

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded 0 quest relations from %s. DB table `%s` is empty.",table,table);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 id    = fields[0].GetUInt32();
        uint32 quest = fields[1].GetUInt32();

        if (mQuestTemplates.find(quest) == mQuestTemplates.end())
        {
            sLog.outLog(LOG_DB_ERR, "Table `%s: Quest %u listed for entry %u does not exist.",table,quest,id);
            continue;
        }

        map.insert(QuestRelations::value_type(id,quest));

        ++count;
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u quest relations from %s", count,table);
}

void ObjectMgr::LoadGameobjectQuestRelations()
{
    LoadQuestRelationsHelper(mGOQuestRelations,"gameobject_questrelation");

    for (QuestRelations::iterator itr = mGOQuestRelations.begin(); itr != mGOQuestRelations.end(); ++itr)
    {
        GameObjectInfo const* goInfo = GetGameObjectInfo(itr->first);
        if (!goInfo)
            sLog.outLog(LOG_DB_ERR, "Table `gameobject_questrelation` have data for not existed gameobject entry (%u) and existed quest %u",itr->first,itr->second);
        else if (goInfo->type != GAMEOBJECT_TYPE_QUESTGIVER)
            sLog.outLog(LOG_DB_ERR, "Table `gameobject_questrelation` have data gameobject entry (%u) for quest %u, but GO is not GAMEOBJECT_TYPE_QUESTGIVER",itr->first,itr->second);
    }
}

void ObjectMgr::LoadGameobjectInvolvedRelations()
{
    LoadQuestRelationsHelper(mGOQuestInvolvedRelations,"gameobject_involvedrelation");

    for (QuestRelations::iterator itr = mGOQuestInvolvedRelations.begin(); itr != mGOQuestInvolvedRelations.end(); ++itr)
    {
        GameObjectInfo const* goInfo = GetGameObjectInfo(itr->first);
        if (!goInfo)
            sLog.outLog(LOG_DB_ERR, "Table `gameobject_involvedrelation` have data for not existed gameobject entry (%u) and existed quest %u",itr->first,itr->second);
        else if (goInfo->type != GAMEOBJECT_TYPE_QUESTGIVER)
            sLog.outLog(LOG_DB_ERR, "Table `gameobject_involvedrelation` have data gameobject entry (%u) for quest %u, but GO is not GAMEOBJECT_TYPE_QUESTGIVER",itr->first,itr->second);
    }
}

void ObjectMgr::LoadCreatureQuestRelations()
{
    LoadQuestRelationsHelper(mCreatureQuestRelations,"creature_questrelation");

    for (QuestRelations::iterator itr = mCreatureQuestRelations.begin(); itr != mCreatureQuestRelations.end(); ++itr)
    {
        CreatureInfo const* cInfo = GetCreatureTemplate(itr->first);
        if (!cInfo)
            sLog.outLog(LOG_DB_ERR, "Table `creature_questrelation` have data for not existed creature entry (%u) and existed quest %u",itr->first,itr->second);
        else if (!(cInfo->npcflag & UNIT_NPC_FLAG_QUESTGIVER))
            sLog.outLog(LOG_DB_ERR, "Table `creature_questrelation` has creature entry (%u) for quest %u, but npcflag does not include UNIT_NPC_FLAG_QUESTGIVER",itr->first,itr->second);
    }
}

void ObjectMgr::LoadCreatureInvolvedRelations()
{
    LoadQuestRelationsHelper(mCreatureQuestInvolvedRelations,"creature_involvedrelation");

    for (QuestRelations::iterator itr = mCreatureQuestInvolvedRelations.begin(); itr != mCreatureQuestInvolvedRelations.end(); ++itr)
    {
        CreatureInfo const* cInfo = GetCreatureTemplate(itr->first);
        if (!cInfo)
            sLog.outLog(LOG_DB_ERR, "Table `creature_involvedrelation` have data for not existed creature entry (%u) and existed quest %u",itr->first,itr->second);
        else if (!(cInfo->npcflag & UNIT_NPC_FLAG_QUESTGIVER))
            sLog.outLog(LOG_DB_ERR, "Table `creature_involvedrelation` has creature entry (%u) for quest %u, but npcflag does not include UNIT_NPC_FLAG_QUESTGIVER",itr->first,itr->second);
    }
}

void ObjectMgr::LoadReservedPlayersNames()
{
    m_ReservedNames.clear();                                // need for reload case

    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT name FROM reserved_name");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u reserved player names", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    Field* fields;
    do
    {
        bar.step();
        fields = result->Fetch();
        std::string name= fields[0].GetCppString();
        if (normalizePlayerName(name))
        {
            m_ReservedNames.insert(name);
            ++count;
        }
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u reserved player names", count);
}

enum LanguageType
{
    LT_BASIC_LATIN    = 0x0000,
    LT_EXTENDEN_LATIN = 0x0001,
    LT_CYRILLIC       = 0x0002,
    LT_EAST_ASIA      = 0x0004,
    LT_ANY            = 0xFFFF
};

static LanguageType GetRealmLanguageType(bool create)
{
    switch (sWorld.getConfig(CONFIG_REALM_ZONE))
    {
        case REALM_ZONE_UNKNOWN:                            // any language
        case REALM_ZONE_DEVELOPMENT:
        case REALM_ZONE_TEST_SERVER:
        case REALM_ZONE_QA_SERVER:
            return LT_ANY;
        case REALM_ZONE_UNITED_STATES:                      // extended-Latin
        case REALM_ZONE_OCEANIC:
        case REALM_ZONE_LATIN_AMERICA:
        case REALM_ZONE_ENGLISH:
        case REALM_ZONE_GERMAN:
        case REALM_ZONE_FRENCH:
        case REALM_ZONE_SPANISH:
            return LT_EXTENDEN_LATIN;
        case REALM_ZONE_KOREA:                              // East-Asian
        case REALM_ZONE_TAIWAN:
        case REALM_ZONE_CHINA:
            return LT_EAST_ASIA;
        case REALM_ZONE_RUSSIAN:                            // Cyrillic
            return LT_CYRILLIC;
        default:
            return create ? LT_BASIC_LATIN : LT_ANY;        // basic-Latin at create, any at login
    }
}

bool isValidString(std::wstring wstr, uint32 strictMask, bool numericOrSpace, bool create = false)
{
    if (strictMask==0)                                       // any language, ignore realm
    {
        if (isExtendedLatinString(wstr,numericOrSpace))
            return true;
        if (isCyrillicString(wstr,numericOrSpace))
            return true;
        if (isEastAsianString(wstr,numericOrSpace))
            return true;
        return false;
    }

    if (strictMask & 0x2)                                    // realm zone specific
    {
        LanguageType lt = GetRealmLanguageType(create);
        if (lt & LT_EXTENDEN_LATIN)
            if (isExtendedLatinString(wstr,numericOrSpace))
                return true;
        if (lt & LT_CYRILLIC)
            if (isCyrillicString(wstr,numericOrSpace))
                return true;
        if (lt & LT_EAST_ASIA)
            if (isEastAsianString(wstr,numericOrSpace))
                return true;
    }

    if (strictMask & 0x1)                                    // basic Latin
    {
        if (isBasicLatinString(wstr,numericOrSpace))
            return true;
    }

    return false;
}

bool ObjectMgr::IsValidName(const std::string& name, bool create)
{
    std::wstring wname;
    if (!Utf8toWStr(name,wname))
        return false;

    if (wname.size() < 1 || wname.size() > MAX_PLAYER_NAME)
        return false;

    uint32 strictMask = sWorld.getConfig(CONFIG_STRICT_PLAYER_NAMES);

    return isValidString(wname,strictMask,false,create);
}

bool ObjectMgr::IsValidCharterName(const std::string& name)
{
    std::wstring wname;
    if (!Utf8toWStr(name,wname))
        return false;

    if (wname.size() < 1)
        return false;

    uint32 strictMask = sWorld.getConfig(CONFIG_STRICT_CHARTER_NAMES);

    return isValidString(wname,strictMask,true);
}

bool ObjectMgr::IsValidPetName(const std::string& name)
{
    std::wstring wname;
    if (!Utf8toWStr(name,wname))
        return false;

    if (wname.size() < 1)
        return false;

    uint32 strictMask = sWorld.getConfig(CONFIG_STRICT_PET_NAMES);

    return isValidString(wname,strictMask,false);
}

int ObjectMgr::GetIndexForLocale(LocaleConstant loc)
{
    if (loc==LOCALE_enUS)
        return -1;

    for (size_t i=0;i < m_LocalForIndex.size(); ++i)
        if (m_LocalForIndex[i]==loc)
            return i;

    return -1;
}

LocaleConstant ObjectMgr::GetLocaleForIndex(int i)
{
    if (i<0 || i>=m_LocalForIndex.size())
        return LOCALE_enUS;

    return m_LocalForIndex[i];
}

int ObjectMgr::GetOrNewIndexForLocale(LocaleConstant loc)
{
    if (loc==LOCALE_enUS)
        return -1;

    for (size_t i=0;i < m_LocalForIndex.size(); ++i)
        if (m_LocalForIndex[i]==loc)
            return i;

    m_LocalForIndex.push_back(loc);
    return m_LocalForIndex.size()-1;
}

bool ObjectMgr::LoadLooking4groupStrings(DatabaseType& db, char const* table, int32 min_value, int32 max_value)
{
    int32 start_value = min_value;
    int32 end_value   = max_value;
    // some string can have negative indexes range
    if (start_value < 0)
    {
        if (end_value >= start_value)
        {
            sLog.outLog(LOG_DB_ERR, "Table '%s' attempt loaded with invalid range (%d - %d), strings not loaded.",table,min_value,max_value);
            return false;
        }

        // real range (max+1,min+1) exaple: (-10,-1000) -> -999...-10+1
        std::swap(start_value,end_value);
        ++start_value;
        ++end_value;
    }
    else
    {
        if (start_value >= end_value)
        {
            sLog.outLog(LOG_DB_ERR, "Table '%s' attempt loaded with invalid range (%d - %d), strings not loaded.",table,min_value,max_value);
            return false;
        }
    }

    // cleanup affected map part for reloading case
    for (Looking4groupStringLocaleMap::iterator itr = mLooking4groupStringLocaleMap.begin(); itr != mLooking4groupStringLocaleMap.end();)
    {
        if (itr->first >= start_value && itr->first < end_value)
            mLooking4groupStringLocaleMap.erase(itr++);
        else
            ++itr;
    }

    QueryResultAutoPtr result = db.PQuery("SELECT entry,content_default,content_loc1,content_loc2,content_loc3,content_loc4,content_loc5,content_loc6,content_loc7,content_loc8 FROM %s",table);

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        if (min_value == MIN_LOOKING4GROUP_STRING_ID)              // error only in case internal strings
            sLog.outLog(LOG_DB_ERR, ">> Loaded 0 trinity strings. DB table `%s` is empty. Cannot continue.",table);
        else
            sLog.outString(">> Loaded 0 string templates. DB table `%s` is empty.",table);
        return false;
    }

    uint32 count = 0;

    BarGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        int32 entry = fields[0].GetInt32();

        if (entry==0)
        {
            sLog.outLog(LOG_DB_ERR, "Table `%s` contain reserved entry 0, ignored.",table);
            continue;
        }
        else if (entry < start_value || entry >= end_value)
        {
            sLog.outLog(LOG_DB_ERR, "Table `%s` contain entry %i out of allowed range (%d - %d), ignored.",table,entry,min_value,max_value);
            continue;
        }

        TrinityStringLocale& data = mLooking4groupStringLocaleMap[entry];

        if (data.Content.size() > 0)
        {
            sLog.outLog(LOG_DB_ERR, "Table `%s` contain data for already loaded entry  %i (from another table?), ignored.",table,entry);
            continue;
        }

        data.Content.resize(1);
        ++count;

        // 0 -> default, idx in to idx+1
        data.Content[0] = fields[1].GetCppString();

        for (int i = 1; i < MAX_LOCALE; ++i)
        {
            std::string str = fields[i+1].GetCppString();
            if (!str.empty())
            {
                int idx = GetOrNewIndexForLocale(LocaleConstant(i));
                if (idx >= 0)
                {
                    // 0 -> default, idx in to idx+1
                    if (data.Content.size() <= idx+1)
                        data.Content.resize(idx+2);

                    data.Content[idx+1] = str;
                }
            }
        }
    } while (result->NextRow());

    sLog.outString();
    if (min_value == MIN_LOOKING4GROUP_STRING_ID)               // internal Trinity strings
        sLog.outString(">> Loaded %u Trinity strings from table %s", count,table);
    else
        sLog.outString(">> Loaded %u string templates from %s", count,table);

    return true;
}

const char *ObjectMgr::GetTrinityString(int32 entry, int locale_idx) const
{
    // locale_idx==-1 -> default, locale_idx >= 0 in to idx+1
    // Content[0] always exist if exist TrinityStringLocale
    if (TrinityStringLocale const *msl = GetTrinityStringLocale(entry))
    {
        if (msl->Content.size() > locale_idx+1 && !msl->Content[locale_idx+1].empty())
            return msl->Content[locale_idx+1].c_str();
        else
            return msl->Content[0].c_str();
    }

    if (entry > 0)
        sLog.outLog(LOG_DB_ERR, "Entry %i not found in `LOOKING4GROUP_string` table.",entry);
    else
        sLog.outLog(LOG_DB_ERR, "Trinity string entry %i not found in DB.",entry);
    return "<error>";
}

void ObjectMgr::LoadSpellDisabledEntrys()
{
    m_DisabledPlayerSpells.clear();                                // need for reload case
    m_DisabledCreatureSpells.clear();
    m_DisabledPetSpells.clear();
    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT entry, disable_mask FROM spell_disabled");

    uint32 total_count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u disabled spells", total_count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    Field* fields;
    do
    {
        bar.step();
        fields = result->Fetch();
        uint32 spellid = fields[0].GetUInt32();
        if (!sSpellStore.LookupEntry(spellid))
        {
            sLog.outLog(LOG_DB_ERR, "Spell entry %u from `spell_disabled` doesn't exist in dbc, ignoring.",spellid);
            continue;
        }
        uint32 disable_mask = fields[1].GetUInt32();
        if (disable_mask & SPELL_DISABLE_PLAYER)
            m_DisabledPlayerSpells.insert(spellid);
        if (disable_mask & SPELL_DISABLE_CREATURE)
            m_DisabledCreatureSpells.insert(spellid);
        if (disable_mask & SPELL_DISABLE_PET)
            m_DisabledPetSpells.insert(spellid);
        ++total_count;
   } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u disabled spells from `spell_disabled`", total_count);
}

void ObjectMgr::LoadFishingBaseSkillLevel()
{
    mFishingBaseForArea.clear();                            // for reload case

    uint32 count = 0;
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry,skill FROM skill_fishing_base_level");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded `skill_fishing_base_level`, table is empty!");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        bar.step();

        Field *fields = result->Fetch();
        uint32 entry  = fields[0].GetUInt32();
        int32 skill   = fields[1].GetInt32();

        AreaTableEntry const* fArea = GetAreaEntryByAreaID(entry);
        if (!fArea)
        {
            sLog.outLog(LOG_DB_ERR, "AreaId %u defined in `skill_fishing_base_level` does not exist",entry);
            continue;
        }

        mFishingBaseForArea[entry] = skill;
        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u areas for fishing base skill level", count);
}

// Searches for the same condition already in Conditions store
// Returns Id if found, else adds it to Conditions and returns Id
uint16 ObjectMgr::GetConditionId(ConditionType condition, uint32 value1, uint32 value2)
{
    PlayerCondition lc = PlayerCondition(condition, value1, value2);
    for (uint16 i=0; i < mConditions.size(); ++i)
    {
        if (lc == mConditions[i])
            return i;
    }

    mConditions.push_back(lc);

    if (mConditions.size() > 0xFFFF)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Conditions store overflow! Current and later loaded conditions will ignored!");
        return 0;
    }

    return mConditions.size() - 1;
}

bool ObjectMgr::CheckDeclinedNames(std::wstring mainpart, DeclinedName const& names)
{
    for (int i =0; i < MAX_DECLINED_NAME_CASES; ++i)
    {
        std::wstring wname;
        if (!Utf8toWStr(names.name[i],wname))
            return false;

        if (mainpart!=GetMainPartOfName(wname,i+1))
            return false;
    }
    return true;
}

// Checks if player meets the condition
bool PlayerCondition::Meets(Player const * player) const
{
    if (!player)
        return false;                                       // player not present, return false

    switch (condition)
    {
        case CONDITION_NONE:
            return true;                                    // empty condition, always met
        case CONDITION_AURA:
            return player->HasAura(value1, value2);
        case CONDITION_ITEM:
            return player->HasItemCount(value1, value2);
        case CONDITION_ITEM_EQUIPPED:
            return player->GetItemOrItemWithGemEquipped(value1) != NULL;
        case CONDITION_ZONEID:
            return player->GetCachedZone() == value1;
        case CONDITION_REPUTATION_RANK:
        {
            FactionEntry const* faction = sFactionStore.LookupEntry(value1);
            return faction && player->GetReputationMgr().GetRank(faction) >= value2;
        }
        case CONDITION_TEAM:
            return player->GetTeam() == value1;
        case CONDITION_SKILL:
            return player->HasSkill(value1) && player->GetBaseSkillValue(value1) >= value2;
        case CONDITION_QUESTREWARDED:
            return player->GetQuestRewardStatus(value1);
        case CONDITION_QUESTTAKEN:
        {
            QuestStatus status1 = player->GetQuestStatus(value1);
            if (status1 == QUEST_STATUS_INCOMPLETE)
                return true;
            if (value2 == 0)
                return false;
            QuestStatus status2 = player->GetQuestStatus(value2);
            return (status2 == QUEST_STATUS_INCOMPLETE);
        }
        case CONDITION_AD_COMMISSION_AURA:
        {
            Unit::AuraMap const& auras = player->GetAuras();
            for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
                if ((itr->second->GetSpellProto()->Attributes & 0x1000010) && itr->second->GetSpellProto()->SpellVisual==3580)
                    return true;
            return false;
        }
        case CONDITION_NO_AURA:
            return !player->HasAura(value1, value2);
        case CONDITION_ACTIVE_EVENT:
            return sGameEventMgr.IsActiveEvent(value1);
        case CONDITION_INSTANCE_DATA:
        {
            Map *map = player->GetMap();
            if (map && map->IsDungeon() && ((InstanceMap*)map)->GetInstanceData())
                return ((InstanceMap*)map)->GetInstanceData()->GetData(value1) == value2;
        }
        default:
            return false;
    }
}

// Verification of condition values validity
bool PlayerCondition::IsValid(ConditionType condition, uint32 value1, uint32 value2)
{
    if (condition >= MAX_CONDITION)                         // Wrong condition type
    {
        sLog.outLog(LOG_DB_ERR, "Condition has bad type of %u, skipped ", condition);
        return false;
    }

    switch (condition)
    {
        case CONDITION_AURA:
        {
            if (!sSpellStore.LookupEntry(value1))
            {
                sLog.outLog(LOG_DB_ERR, "Aura condition requires to have non existing spell (Id: %d), skipped", value1);
                return false;
            }
            if (value2 > 2)
            {
                sLog.outLog(LOG_DB_ERR, "Aura condition requires to have non existing effect index (%u) (must be 0..2), skipped", value2);
                return false;
            }
            break;
        }
        case CONDITION_ITEM:
        {
            ItemPrototype const *proto = ObjectMgr::GetItemPrototype(value1);
            if (!proto)
            {
                sLog.outLog(LOG_DB_ERR, "Item condition requires to have non existing item (%u), skipped", value1);
                return false;
            }
            break;
        }
        case CONDITION_ITEM_EQUIPPED:
        {
            ItemPrototype const *proto = ObjectMgr::GetItemPrototype(value1);
            if (!proto)
            {
                sLog.outLog(LOG_DB_ERR, "ItemEquipped condition requires to have non existing item (%u) equipped, skipped", value1);
                return false;
            }
            break;
        }
        case CONDITION_ZONEID:
        {
            AreaTableEntry const* areaEntry = GetAreaEntryByAreaID(value1);
            if (!areaEntry)
            {
                sLog.outLog(LOG_DB_ERR, "Zone condition requires to be in non existing area (%u), skipped", value1);
                return false;
            }
            if (areaEntry->zone != 0)
            {
                sLog.outLog(LOG_DB_ERR, "Zone condition requires to be in area (%u) which is a subzone but zone expected, skipped", value1);
                return false;
            }
            break;
        }
        case CONDITION_REPUTATION_RANK:
        {
            FactionEntry const* factionEntry = sFactionStore.LookupEntry(value1);
            if (!factionEntry)
            {
                sLog.outLog(LOG_DB_ERR, "Reputation condition requires to have reputation non existing faction (%u), skipped", value1);
                return false;
            }
            break;
        }
        case CONDITION_TEAM:
        {
            if (value1 != ALLIANCE && value1 != HORDE)
            {
                sLog.outLog(LOG_DB_ERR, "Team condition specifies unknown team (%u), skipped", value1);
                return false;
            }
            break;
        }
        case CONDITION_SKILL:
        {
            SkillLineEntry const *pSkill = sSkillLineStore.LookupEntry(value1);
            if (!pSkill)
            {
                sLog.outLog(LOG_DB_ERR, "Skill condition specifies non-existing skill (%u), skipped", value1);
                return false;
            }
            if (value2 < 1 || value2 > sWorld.GetConfigMaxSkillValue())
            {
                sLog.outLog(LOG_DB_ERR, "Skill condition specifies invalid skill value (%u), skipped", value2);
                return false;
            }
            break;
        }
        case CONDITION_QUESTREWARDED:
        case CONDITION_QUESTTAKEN:
        {
            Quest const *quest1 = sObjectMgr.GetQuestTemplate(value1);
            if (!quest1)
            {
                sLog.outLog(LOG_DB_ERR, "Quest condition specifies non-existing quest (%u), skipped", value1);
                return false;
            }
            if (!value2)
                return true;

            Quest const *quest2 = sObjectMgr.GetQuestTemplate(value1);
            if (!quest2)
            {
                sLog.outLog(LOG_DB_ERR, "Quest condition specifies non-existing secondary quest (%u), skipped", value2);
                return false;
            }
            break;
        }
        case CONDITION_AD_COMMISSION_AURA:
        {
            if (value1)
                sLog.outLog(LOG_DB_ERR, "Quest condition has useless data in value1 (%u)!", value1);
            if (value2)
                sLog.outLog(LOG_DB_ERR, "Quest condition has useless data in value2 (%u)!", value2);
            break;
        }
        case CONDITION_NO_AURA:
        {
            if (!sSpellStore.LookupEntry(value1))
            {
                sLog.outLog(LOG_DB_ERR, "Aura condition requires to have non existing spell (Id: %d), skipped", value1);
                return false;
            }
            if (value2 > 2)
            {
                sLog.outLog(LOG_DB_ERR, "Aura condition requires to have non existing effect index (%u) (must be 0..2), skipped", value2);
                return false;
            }
            break;
        }
        case CONDITION_ACTIVE_EVENT:
        {
            GameEventMgr::GameEventDataMap const& events = sGameEventMgr.GetEventMap();
            if (value1 >=events.size() || !events[value1].isValid())
            {
                sLog.outLog(LOG_DB_ERR, "Active event condition requires existed event id (%u), skipped", value1);
                return false;
            }
            break;
        }
        case CONDITION_INSTANCE_DATA:
            //TODO: need some check
            break;
    }
    return true;
}

SkillRangeType GetSkillRangeType(SkillLineEntry const *pSkill, bool racial)
{
    switch (pSkill->categoryId)
    {
        case SKILL_CATEGORY_LANGUAGES: return SKILL_RANGE_LANGUAGE;
        case SKILL_CATEGORY_WEAPON:
            if (pSkill->id!=SKILL_FIST_WEAPONS)
                return SKILL_RANGE_LEVEL;
            else
                return SKILL_RANGE_MONO;
        case SKILL_CATEGORY_ARMOR:
        case SKILL_CATEGORY_CLASS:
            if (pSkill->id != SKILL_POISONS && pSkill->id != SKILL_LOCKPICKING)
                return SKILL_RANGE_MONO;
            else
                return SKILL_RANGE_LEVEL;
        case SKILL_CATEGORY_SECONDARY:
        case SKILL_CATEGORY_PROFESSION:
            // not set skills for professions and racial abilities
            if (SpellMgr::IsProfessionSkill(pSkill->id))
                return SKILL_RANGE_RANK;
            else if (racial)
                return SKILL_RANGE_NONE;
            else
                return SKILL_RANGE_MONO;
        default:
        case SKILL_CATEGORY_ATTRIBUTES:                     //not found in dbc
        case SKILL_CATEGORY_GENERIC:                  //only GENEREC(DND)
            return SKILL_RANGE_NONE;
    }
}

void ObjectMgr::LoadGameTele()
{
    m_GameTeleMap.clear();                                  // for reload case

    uint32 count = 0;
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT id, position_x, position_y, position_z, orientation, map, name FROM game_tele");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded `game_tele`, table is empty!");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        bar.step();

        Field *fields = result->Fetch();

        uint32 id         = fields[0].GetUInt32();

        GameTele gt;

        gt.position_x     = fields[1].GetFloat();
        gt.position_y     = fields[2].GetFloat();
        gt.position_z     = fields[3].GetFloat();
        gt.orientation    = fields[4].GetFloat();
        gt.mapId          = fields[5].GetUInt32();
        gt.name           = fields[6].GetCppString();

        if (!MapManager::IsValidMapCoord(gt.mapId,gt.position_x,gt.position_y,gt.position_z,gt.orientation))
        {
            sLog.outLog(LOG_DB_ERR, "Wrong position for id %u (name: %s) in `game_tele` table, ignoring.",id,gt.name.c_str());
            continue;
        }

        if (!Utf8toWStr(gt.name,gt.wnameLow))
        {
            sLog.outLog(LOG_DB_ERR, "Wrong UTF8 name for id %u in `game_tele` table, ignoring.",id);
            continue;
        }

        wstrToLower(gt.wnameLow);

        m_GameTeleMap[id] = gt;

        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u game tele's", count);
}

GameTele const* ObjectMgr::GetGameTele(const std::string& name) const
{
    // explicit name case
    std::wstring wname;
    if (!Utf8toWStr(name,wname))
        return NULL;

    // converting string that we try to find to lower case
    wstrToLower(wname);

    // Alternative first GameTele what contains wnameLow as substring in case no GameTele location found
    const GameTele* alt = NULL;
    for (GameTeleMap::const_iterator itr = m_GameTeleMap.begin(); itr != m_GameTeleMap.end(); ++itr)
    {
        if (itr->second.wnameLow == wname)
            return &itr->second;
        else if (alt == NULL && itr->second.wnameLow.find(wname) != std::wstring::npos)
            alt = &itr->second;
    }

    return alt;
}

bool ObjectMgr::AddGameTele(GameTele& tele)
{
    // find max id
    uint32 new_id = 0;
    for (GameTeleMap::const_iterator itr = m_GameTeleMap.begin(); itr != m_GameTeleMap.end(); ++itr)
        if (itr->first > new_id)
            new_id = itr->first;

    // use next
    ++new_id;

    if (!Utf8toWStr(tele.name,tele.wnameLow))
        return false;

    wstrToLower(tele.wnameLow);

    m_GameTeleMap[new_id] = tele;

    return GameDataDatabase.PExecuteLog("INSERT INTO game_tele (id,position_x,position_y,position_z,orientation,map,name) VALUES (%u,%f,%f,%f,%f,%d,'%s')",
        new_id,tele.position_x,tele.position_y,tele.position_z,tele.orientation,tele.mapId,tele.name.c_str());
}

bool ObjectMgr::DeleteGameTele(const std::string& name)
{
    // explicit name case
    std::wstring wname;
    if (!Utf8toWStr(name,wname))
        return false;

    // converting string that we try to find to lower case
    wstrToLower(wname);

    for (GameTeleMap::iterator itr = m_GameTeleMap.begin(); itr != m_GameTeleMap.end(); ++itr)
    {
        if (itr->second.wnameLow == wname)
        {
            GameDataDatabase.PExecuteLog("DELETE FROM game_tele WHERE name = '%s'",itr->second.name.c_str());
            m_GameTeleMap.erase(itr);
            return true;
        }
    }

    return false;
}

void ObjectMgr::LoadTrainerSpell()
{
    // For reload case
    for (CacheTrainerSpellMap::iterator itr = m_mCacheTrainerSpellMap.begin(); itr != m_mCacheTrainerSpellMap.end(); ++itr)
        itr->second.Clear();
    m_mCacheTrainerSpellMap.clear();

    std::set<uint32> skip_trainers;

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry, spell,spellcost,reqskill,reqskillvalue,reqlevel FROM npc_trainer");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded `npc_trainer`, table is empty!");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    uint32 count = 0;
    do
    {
        bar.step();

        Field* fields = result->Fetch();

        uint32 entry  = fields[0].GetUInt32();
        uint32 spell  = fields[1].GetUInt32();

        CreatureInfo const* cInfo = GetCreatureTemplate(entry);

        if (!cInfo)
        {
            sLog.outLog(LOG_DB_ERR, "Table `npc_trainer` have entry for not existed creature template (Entry: %u), ignore", entry);
            continue;
        }

        if (!(cInfo->npcflag & UNIT_NPC_FLAG_TRAINER))
        {
            if (skip_trainers.count(entry) == 0)
            {
                sLog.outLog(LOG_DB_ERR, "Table `npc_trainer` have data for not creature template (Entry: %u) without trainer flag, ignore", entry);
                skip_trainers.insert(entry);
            }
            continue;
        }

        SpellEntry const *spellinfo = sSpellStore.LookupEntry(spell);
        if (!spellinfo)
        {
            sLog.outLog(LOG_DB_ERR, "Table `npc_trainer` for Trainer (Entry: %u) has non existing spell %u, ignore", entry,spell);
            continue;
        }

        if (!SpellMgr::IsSpellValid(spellinfo))
        {
            sLog.outLog(LOG_DB_ERR, "Table `npc_trainer` for Trainer (Entry: %u) has broken learning spell %u, ignore", entry, spell);
            continue;
        }

        TrainerSpellData& data = m_mCacheTrainerSpellMap[entry];

        if (SpellMgr::IsProfessionSpell(spell))
            data.trainerType = 2;

        TrainerSpell& trainerSpell = data.spellList[spell];
        trainerSpell.spell         = spell;
        trainerSpell.spellCost     = fields[2].GetUInt32();
        trainerSpell.reqSkill      = fields[3].GetUInt32();
        trainerSpell.reqSkillValue = fields[4].GetUInt32();
        trainerSpell.reqLevel      = fields[5].GetUInt32();

        if (!trainerSpell.reqLevel)
            trainerSpell.reqLevel = spellinfo->spellLevel;

        ++count;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded Trainers %d", count);
}

void ObjectMgr::LoadVendors()
{
    // For reload case
    for (CacheVendorItemMap::iterator itr = m_mCacheVendorItemMap.begin(); itr != m_mCacheVendorItemMap.end(); ++itr)
        itr->second.Clear();
    m_mCacheVendorItemMap.clear();

    std::set<uint32> skip_vendors;

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry, item, maxcount, incrtime, ExtendedCost FROM npc_vendor");
    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded `npc_vendor`, table is empty!");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    uint32 count = 0;
    do
    {
        bar.step();
        Field* fields = result->Fetch();

        uint32 entry        = fields[0].GetUInt32();
        uint32 item_id      = fields[1].GetUInt32();
        uint32 maxcount     = fields[2].GetUInt32();
        uint32 incrtime     = fields[3].GetUInt32();
        uint32 ExtendedCost = fields[4].GetUInt32();

        if (!IsVendorItemValid(entry,item_id,maxcount,incrtime,ExtendedCost,NULL,&skip_vendors))
            continue;

        VendorItemData& vList = m_mCacheVendorItemMap[entry];

        vList.AddItem(item_id,maxcount,incrtime,ExtendedCost);
        ++count;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %d Vendors ", count);
}

/* This function is supposed to take care of three things:
*  1) Load Transports on Map or on Continents
*  2) Load Active Npcs on Map or Continents
*  3) Load Everything dependend on config setting LoadAllGridsOnMaps
*
*  This function is currently WIP, hence parts exist only as draft.
*/
void ObjectMgr::LoadActiveEntities(Map* _map)
{
    // Special case on startup - load continents
    if (!_map)
    {
        uint32 continents[] = {0, 1, 530};
        for (int i = 0; i < 3; ++i)
        {
            _map = sMapMgr.FindMap(continents[i]);
            if (!_map)
                _map = sMapMgr.CreateMap(continents[i], NULL);

            if (_map)
                LoadActiveEntities(_map);
            else
                sLog.outLog(LOG_DEFAULT, "ERROR: ObjectMgr::LoadActiveEntities - Unable to create Map %u", continents[i]);
        }

        return;
    }

    // Load active objects for _map
    std::set<uint32> const* mapList = sWorld.getConfigForceLoadMapIds();
    if (mapList && mapList->find(_map->GetId()) != mapList->end())
    {
        for (CreatureDataMap::const_iterator itr = mCreatureDataMap.begin(); itr != mCreatureDataMap.end(); ++itr)
        {
            if (itr->second.mapid == _map->GetId())
                _map->LoadGrid(itr->second.posX, itr->second.posY);
        }
    }
    else                                                    // Normal case - Load all npcs that are active
    {
        std::pair<ActiveCreatureGuidsOnMap::const_iterator, ActiveCreatureGuidsOnMap::const_iterator> bounds = m_activeCreatures.equal_range(_map->GetId());
        for (ActiveCreatureGuidsOnMap::const_iterator itr = bounds.first; itr != bounds.second; ++itr)
        {
            CreatureData const& data = mCreatureDataMap[itr->second];
            _map->LoadGrid(data.posX, data.posY);
        }
    }

    // Load Transports on Map _map
}

void ObjectMgr::LoadNpcTextId()
{

    m_mCacheNpcTextIdMap.clear();

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT npc_guid, textid FROM npc_gossip");
    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded `npc_gossip`, table is empty!");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    uint32 count = 0;
    uint32 guid,textid;
    do
    {
        bar.step();

        Field* fields = result->Fetch();

        guid   = fields[0].GetUInt32();
        textid = fields[1].GetUInt32();

        if (!GetCreatureData(guid))
        {
            sLog.outLog(LOG_DB_ERR, "Table `npc_gossip` have not existed creature (GUID: %u) entry, ignore. ",guid);
            continue;
        }
        if (!GetGossipText(textid))
        {
            sLog.outLog(LOG_DB_ERR, "Table `npc_gossip` for creature (GUID: %u) have wrong Textid (%u), ignore. ", guid, textid);
            continue;
        }

        m_mCacheNpcTextIdMap[guid] = textid ;
        ++count;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %d NpcTextId ", count);
}

void ObjectMgr::LoadNpcOptions()
{
    m_mCacheNpcOptionList.clear();                          // For reload case

    QueryResultAutoPtr result = GameDataDatabase.Query(
        //      0  1         2       3    4      5         6     7           8
        "SELECT id,gossip_id,npcflag,icon,action,box_money,coded,option_text,box_text "
        "FROM npc_option");

    if (!result)
    {
        BarGoLink bar(1);

        bar.step();

        sLog.outString();
        sLog.outLog(LOG_DB_ERR, ">> Loaded `npc_option`, table is empty!");
        return;
    }

    BarGoLink bar(result->GetRowCount());

    uint32 count = 0;

    do
    {
        bar.step();

        Field* fields = result->Fetch();

        GossipOption go;
        go.Id               = fields[0].GetUInt32();
        go.GossipId         = fields[1].GetUInt32();
        go.NpcFlag          = fields[2].GetUInt32();
        go.Icon             = fields[3].GetUInt32();
        go.Action           = fields[4].GetUInt32();
        go.BoxMoney         = fields[5].GetUInt32();
        go.Coded            = fields[6].GetUInt8()!=0;
        go.OptionText       = fields[7].GetCppString();
        go.BoxText          = fields[8].GetCppString();

        m_mCacheNpcOptionList.push_back(go);

        ++count;

    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %d npc_option entries", count);
}

void ObjectMgr::AddVendorItem(uint32 entry,uint32 item, uint32 maxcount, uint32 incrtime, uint32 extendedcost, bool savetodb)
{
    VendorItemData& vList = m_mCacheVendorItemMap[entry];
    vList.AddItem(item,maxcount,incrtime,extendedcost);

    if (savetodb) GameDataDatabase.PExecuteLog("INSERT INTO npc_vendor (entry,item,maxcount,incrtime,extendedcost) VALUES('%u','%u','%u','%u','%u')",entry, item, maxcount,incrtime,extendedcost);
}

bool ObjectMgr::RemoveVendorItem(uint32 entry,uint32 item, bool savetodb)
{
    CacheVendorItemMap::iterator  iter = m_mCacheVendorItemMap.find(entry);
    if (iter == m_mCacheVendorItemMap.end())
        return false;

    if (!iter->second.FindItem(item))
        return false;

    iter->second.RemoveItem(item);
    if (savetodb) GameDataDatabase.PExecuteLog("DELETE FROM npc_vendor WHERE entry='%u' AND item='%u'",entry, item);
    return true;
}

bool ObjectMgr::IsVendorItemValid(uint32 vendor_entry, uint32 item_id, uint32 maxcount, uint32 incrtime, uint32 ExtendedCost, Player* pl, std::set<uint32>* skip_vendors, uint32 ORnpcflag) const
{
    CreatureInfo const* cInfo = GetCreatureTemplate(vendor_entry);
    if (!cInfo)
    {
        if (pl)
            ChatHandler(pl).SendSysMessage(LANG_COMMAND_VENDORSELECTION);
        else
            sLog.outLog(LOG_DB_ERR, "Table `(game_event_)npc_vendor` have data for not existed creature template (Entry: %u), ignore", vendor_entry);
        return false;
    }

    if (!((cInfo->npcflag | ORnpcflag) & UNIT_NPC_FLAG_VENDOR))
    {
        if (!skip_vendors || skip_vendors->count(vendor_entry)==0)
        {
            if (pl)
                ChatHandler(pl).SendSysMessage(LANG_COMMAND_VENDORSELECTION);
            else
                sLog.outLog(LOG_DB_ERR, "Table `(game_event_)npc_vendor` have data for not creature template (Entry: %u) without vendor flag, ignore", vendor_entry);

            if (skip_vendors)
                skip_vendors->insert(vendor_entry);
        }
        return false;
    }

    if (!GetItemPrototype(item_id))
    {
        if (pl)
            ChatHandler(pl).PSendSysMessage(LANG_ITEM_NOT_FOUND, item_id);
        else
            sLog.outLog(LOG_DB_ERR, "Table `(game_event_)npc_vendor` for Vendor (Entry: %u) have in item list non-existed item (%u), ignore",vendor_entry,item_id);
        return false;
    }

    if (ExtendedCost && !sItemExtendedCostStore.LookupEntry(ExtendedCost))
    {
        if (pl)
            ChatHandler(pl).PSendSysMessage(LANG_EXTENDED_COST_NOT_EXIST,ExtendedCost);
        else
            sLog.outLog(LOG_DB_ERR, "Table `(game_event_)npc_vendor` have Item (Entry: %u) with wrong ExtendedCost (%u) for vendor (%u), ignore",item_id,ExtendedCost,vendor_entry);
        return false;
    }

    if (maxcount > 0 && incrtime == 0)
    {
        if (pl)
            ChatHandler(pl).PSendSysMessage("MaxCount!=0 (%u) but IncrTime==0", maxcount);
        else
            sLog.outLog(LOG_DB_ERR, "Table `(game_event_)npc_vendor` has `maxcount` (%u) for item %u of vendor (Entry: %u) but `incrtime`=0, ignore", maxcount, item_id, vendor_entry);
        return false;
    }
    else if (maxcount==0 && incrtime > 0)
    {
        if (pl)
            ChatHandler(pl).PSendSysMessage("MaxCount==0 but IncrTime<>=0");
        else
            sLog.outLog(LOG_DB_ERR, "Table `(game_event_)npc_vendor` has `maxcount`=0 for item %u of vendor (Entry: %u) but `incrtime`<>0, ignore", item_id, vendor_entry);
        return false;
    }

    VendorItemData const* vItems = GetNpcVendorItemList(vendor_entry);
    if (!vItems)
        return true;                                        // later checks for non-empty lists

    if (vItems->FindItem(item_id))
    {
        if (pl)
            ChatHandler(pl).PSendSysMessage(LANG_ITEM_ALREADY_IN_LIST,item_id);
        else
            sLog.outLog(LOG_DB_ERR, "Table `(game_event_)npc_vendor` has duplicate items %u for vendor (Entry: %u), ignore", item_id, vendor_entry);
        return false;
    }

    if (vItems->GetItemCount() >= MAX_VENDOR_ITEMS)
    {
        if (pl)
            ChatHandler(pl).SendSysMessage(LANG_COMMAND_ADDVENDORITEMITEMS);
        else
            sLog.outLog(LOG_DB_ERR, "Table `npc_vendor` has too many items (%u >= %i) for vendor (Entry: %u), ignore", vItems->GetItemCount(), MAX_VENDOR_ITEMS, vendor_entry);
        return false;
    }

    return true;
}

void ObjectMgr::LoadItemTexts()
{
    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT id, text FROM item_text");

    uint32 count = 0;
    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u item pages", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    Field* fields;
    do
    {
        bar.step();

        fields = result->Fetch();

        mItemTexts[ fields[0].GetUInt32() ] = fields[1].GetCppString();
        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u item texts", count);
}

bool LoadLooking4groupStrings(DatabaseType& db, char const* table,int32 start_value, int32 end_value)
{
    return sObjectMgr.LoadLooking4groupStrings(db,table,start_value,end_value);
}

GameObjectInfo const *GetGameObjectInfo(uint32 id)
{
    return ObjectMgr::GetGameObjectInfo(id);
}

CreatureInfo const *GetCreatureInfo(uint32 id)
{
    return ObjectMgr::GetCreatureTemplate(id);
}

CreatureInfo const* GetCreatureTemplateStore(uint32 entry)
{
    return sCreatureStorage.LookupEntry<CreatureInfo>(entry);
}

Quest const* GetQuestTemplateStore(uint32 entry)
{
    return sObjectMgr.GetQuestTemplate(entry);
}

void ObjectMgr::LoadTransportEvents()
{

    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry, waypoint_id, event_id FROM transport_events");

    if (!result)
    {
        BarGoLink bar1(1);
        bar1.step();
        sLog.outString("\n>> Transport events table is empty \n");
        return;
    }

    BarGoLink bar1(result->GetRowCount());

    do
    {
        bar1.step();

        Field *fields = result->Fetch();

        //Load event values
        uint32 entry = fields[0].GetUInt32();
        uint32 waypoint_id = fields[1].GetUInt32();
        uint32 event_id = fields[2].GetUInt32();

        uint32 event_count = (entry*100)+waypoint_id;
        TransportEventMap[event_count] = event_id;
    }
    while (result->NextRow());

    sLog.outString("\n>> Loaded %u transport events \n", result->GetRowCount());
}

void ObjectMgr::GetCreatureLocaleStrings(uint32 entry, int32 loc_idx, char const** namePtr, char const** subnamePtr) const
{
    if (loc_idx >= 0)
    {
        if (CreatureLocale const *il = GetCreatureLocale(entry))
        {
            if (namePtr && il->Name.size() > size_t(loc_idx) && !il->Name[loc_idx].empty())
                *namePtr = il->Name[loc_idx].c_str();

            if (subnamePtr && il->SubName.size() > size_t(loc_idx) && !il->SubName[loc_idx].empty())
                *subnamePtr = il->SubName[loc_idx].c_str();
        }
    }
}

void ObjectMgr::GetItemLocaleStrings(uint32 entry, int32 loc_idx, std::string* namePtr, std::string* descriptionPtr) const
{
    if (loc_idx >= 0)
    {
        if(ItemLocale const *il = GetItemLocale(entry))
        {
            if (namePtr && il->Name.size() > size_t(loc_idx) && !il->Name[loc_idx].empty())
                *namePtr = il->Name[loc_idx];

            if (descriptionPtr && il->Description.size() > size_t(loc_idx) && !il->Description[loc_idx].empty())
                *descriptionPtr = il->Description[loc_idx];
        }
    }
}

void ObjectMgr::GetQuestLocaleStrings(uint32 entry, int32 loc_idx, std::string* titlePtr) const
{
    if (loc_idx >= 0)
    {
        if(QuestLocale const *il = GetQuestLocale(entry))
        {
            if (titlePtr && il->Title.size() > size_t(loc_idx) && !il->Title[loc_idx].empty())
                *titlePtr = il->Title[loc_idx];
        }
    }
}

void ObjectMgr::GetNpcTextLocaleStringsAll(uint32 entry, int32 loc_idx, ObjectMgr::NpcTextArray* text0_Ptr, ObjectMgr::NpcTextArray* text1_Ptr) const
{
    if (loc_idx >= 0)
    {
        if (NpcTextLocale const *nl = GetNpcTextLocale(entry))
        {
            if (text0_Ptr)
                for (int i = 0; i < MAX_GOSSIP_TEXT_OPTIONS; ++i)
                    if (nl->Text_0[i].size() > (size_t)loc_idx && !nl->Text_0[i][loc_idx].empty())
                        (*text0_Ptr)[i] = nl->Text_0[i][loc_idx];

            if (text1_Ptr)
                for (int i = 0; i < MAX_GOSSIP_TEXT_OPTIONS; ++i)
                    if (nl->Text_1[i].size() > (size_t)loc_idx && !nl->Text_1[i][loc_idx].empty())
                        (*text1_Ptr)[i] = nl->Text_1[i][loc_idx];
        }
    }
}

void ObjectMgr::GetNpcTextLocaleStrings0(uint32 entry, int32 loc_idx, std::string* text0_0_Ptr, std::string* text1_0_Ptr) const
{
    if (loc_idx >= 0)
    {
        if (NpcTextLocale const *nl = GetNpcTextLocale(entry))
        {
            if (text0_0_Ptr)
                if (nl->Text_0[0].size() > (size_t)loc_idx && !nl->Text_0[0][loc_idx].empty())
                    *text0_0_Ptr = nl->Text_0[0][loc_idx];

            if (text1_0_Ptr)
                if (nl->Text_1[0].size() > (size_t)loc_idx && !nl->Text_1[0][loc_idx].empty())
                    *text1_0_Ptr = nl->Text_1[0][loc_idx];
        }
    }
}

void ObjectMgr::LoadOpcodesCooldown()
{
    _opcodesCooldown.clear();

    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT `opcode`, `cooldown` FROM `opcodes_cooldown`");
    if (!result)
    {
        BarGoLink bar1(1);
        bar1.step();
        sLog.outString("\n>> Opcodes cooldown table is empty \n");
        return;
    }

    BarGoLink bar1(result->GetRowCount());

    do
    {
        bar1.step();

        Field *fields = result->Fetch();

        uint16 opcode = LookupOpcodeId(fields[0].GetCppString().c_str());
        if (opcode != MSG_NULL_ACTION)
        {
            uint32 cooldown = fields[1].GetUInt32();
            _opcodesCooldown[opcode].SetInterval(cooldown);
        }
    }
    while (result->NextRow());

    sLog.outString("\n>> Loaded %u opcode cooldowns \n", _opcodesCooldown.size());
}
