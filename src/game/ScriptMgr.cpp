/*
 * Copyright (C) 2005-2010 MaNGOS <http://getmangos.com/>
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

#include "ScriptMgr.h"
#include "Log.h"
#include "ProgressBar.h"
#include "ObjectMgr.h"
#include "WaypointMgr.h"
#include "World.h"

#include "../shared/Config/Config.h"

ScriptMapMap sQuestEndScripts;
ScriptMapMap sQuestStartScripts;
ScriptMapMap sSpellScripts;
ScriptMapMap sGameObjectScripts;
ScriptMapMap sEventScripts;
ScriptMapMap sGossipScripts;
ScriptMapMap sWaypointScripts;

ScriptMgr::ScriptMgr() :
    m_hScriptLib(NULL),
    m_pOnInitScriptLibrary(NULL),
    m_pOnFreeScriptLibrary(NULL),
    m_pGetScriptLibraryVersion(NULL),
    m_pGetCreatureAI(NULL),
    m_pCreateInstanceData(NULL),

    m_pOnGossipHello(NULL),
    m_pOnGossipSelect(NULL),
    m_pOnGOGossipSelect(NULL),
    m_pOnGossipSelectWithCode(NULL),
    m_pOnGOGossipSelectWithCode(NULL),
    m_pOnQuestAccept(NULL),
    m_pOnGOQuestAccept(NULL),
    m_pOnItemQuestAccept(NULL),
    m_pOnQuestRewarded(NULL),
    m_pOnGOQuestRewarded(NULL),
    m_pGetNPCDialogStatus(NULL),
    m_pGetGODialogStatus(NULL),
    m_pOnGOUse(NULL),
    m_pOnItemUse(NULL),
    m_pOnAreaTrigger(NULL),
    m_pOnCompletedCinematic(NULL),
    m_pOnProcessEvent(NULL),
    m_pOnEffectDummyCreature(NULL),
    m_pOnEffectDummyGO(NULL),
    m_pOnEffectDummyItem(NULL),
    m_pOnAuraDummy(NULL),
    m_pOnReceiveEmote(NULL),

    // spell scripts
    m_pOnSpellSetTargetMap(NULL),
    m_pOnSpellHandleEffect(NULL)
{
}

ScriptMgr::~ScriptMgr()
{
    UnloadScriptLibrary();
}

void ScriptMgr::LoadScripts(ScriptMapMap& scripts, char const* tablename)
{
    if (sWorld.IsScriptScheduled())                          // function don't must be called in time scripts use.
        return;

    sLog.outString("%s :", tablename);

    scripts.clear();                                        // need for reload support

    QueryResultAutoPtr result = GameDataDatabase.PQuery("SELECT id,delay,command,datalong,datalong2,dataint, x, y, z, o FROM %s", tablename);

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u script definitions", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        bar.step();

        Field *fields = result->Fetch();
        ScriptInfo tmp;
        tmp.id        = fields[0].GetUInt32();
        tmp.delay     = fields[1].GetUInt32();
        tmp.command   = fields[2].GetUInt32();
        tmp.datalong  = fields[3].GetUInt32();
        tmp.datalong2 = fields[4].GetUInt32();
        tmp.dataint   = fields[5].GetInt32();
        tmp.x         = fields[6].GetFloat();
        tmp.y         = fields[7].GetFloat();
        tmp.z         = fields[8].GetFloat();
        tmp.o         = fields[9].GetFloat();

        // generic command args check
        switch (tmp.command)
        {
            case SCRIPT_COMMAND_TALK:
            {
                if (tmp.datalong > 3)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid talk type (datalong = %u) in SCRIPT_COMMAND_TALK for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }

                if (tmp.dataint==0)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid talk text id (dataint = %i) in SCRIPT_COMMAND_TALK for script id %u",tablename,tmp.dataint,tmp.id);
                    continue;
                }

                if (tmp.dataint < MIN_DB_SCRIPT_STRING_ID || tmp.dataint >= MAX_DB_SCRIPT_STRING_ID)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has out of range text id (dataint = %i expected %u-%u) in SCRIPT_COMMAND_TALK for script id %u",tablename,tmp.dataint,MIN_DB_SCRIPT_STRING_ID,MAX_DB_SCRIPT_STRING_ID,tmp.id);
                    continue;
                }
                break;
            }

            case SCRIPT_COMMAND_EMOTE:
            {
                if (!sEmotesStore.LookupEntry(tmp.datalong))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid emote id (datalong = %u) in SCRIPT_COMMAND_EMOTE for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }
                break;
            }

            case SCRIPT_COMMAND_TELEPORT_TO:
            {
                if (!sMapStore.LookupEntry(tmp.datalong))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid map (Id: %u) in SCRIPT_COMMAND_TELEPORT_TO for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }

                if (!Looking4group::IsValidMapCoord(tmp.x,tmp.y,tmp.z,tmp.o))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid coordinates (X: %f Y: %f) in SCRIPT_COMMAND_TELEPORT_TO for script id %u",tablename,tmp.x,tmp.y,tmp.id);
                    continue;
                }
                break;
            }

            case SCRIPT_COMMAND_TEMP_SUMMON_CREATURE:
            {
                if (!Looking4group::IsValidMapCoord(tmp.x,tmp.y,tmp.z,tmp.o))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid coordinates (X: %f Y: %f) in SCRIPT_COMMAND_TEMP_SUMMON_CREATURE for script id %u",tablename,tmp.x,tmp.y,tmp.id);
                    continue;
                }

                if (!sObjectMgr.GetCreatureTemplate(tmp.datalong))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid creature (Entry: %u) in SCRIPT_COMMAND_TEMP_SUMMON_CREATURE for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }
                break;
            }

            case SCRIPT_COMMAND_RESPAWN_GAMEOBJECT:
            {
                GameObjectData const* data = sObjectMgr.GetGOData(tmp.datalong);
                if (!data)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid gameobject (GUID: %u) in SCRIPT_COMMAND_RESPAWN_GAMEOBJECT for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }

                GameObjectInfo const* info = GetGameObjectInfo(data->id);
                if (!info)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has gameobject with invalid entry (GUID: %u Entry: %u) in SCRIPT_COMMAND_RESPAWN_GAMEOBJECT for script id %u",tablename,tmp.datalong,data->id,tmp.id);
                    continue;
                }

                if (info->type==GAMEOBJECT_TYPE_FISHINGNODE ||
                    info->type==GAMEOBJECT_TYPE_FISHINGHOLE ||
                    info->type==GAMEOBJECT_TYPE_DOOR        ||
                    info->type==GAMEOBJECT_TYPE_BUTTON      ||
                    info->type==GAMEOBJECT_TYPE_TRAP)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` have gameobject type (%u) unsupported by command SCRIPT_COMMAND_RESPAWN_GAMEOBJECT for script id %u",tablename,info->id,tmp.id);
                    continue;
                }
                break;
            }
            case SCRIPT_COMMAND_OPEN_DOOR:
            case SCRIPT_COMMAND_CLOSE_DOOR:
            {
                GameObjectData const* data = sObjectMgr.GetGOData(tmp.datalong);
                if (!data)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid gameobject (GUID: %u) in %s for script id %u",tablename,tmp.datalong,(tmp.command==SCRIPT_COMMAND_OPEN_DOOR ? "SCRIPT_COMMAND_OPEN_DOOR" : "SCRIPT_COMMAND_CLOSE_DOOR"),tmp.id);
                    continue;
                }

                GameObjectInfo const* info = GetGameObjectInfo(data->id);
                if (!info)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has gameobject with invalid entry (GUID: %u Entry: %u) in %s for script id %u",tablename,tmp.datalong,data->id,(tmp.command==SCRIPT_COMMAND_OPEN_DOOR ? "SCRIPT_COMMAND_OPEN_DOOR" : "SCRIPT_COMMAND_CLOSE_DOOR"),tmp.id);
                    continue;
                }

                if (info->type!=GAMEOBJECT_TYPE_DOOR)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has gameobject type (%u) non supported by command %s for script id %u",tablename,info->id,(tmp.command==SCRIPT_COMMAND_OPEN_DOOR ? "SCRIPT_COMMAND_OPEN_DOOR" : "SCRIPT_COMMAND_CLOSE_DOOR"),tmp.id);
                    continue;
                }
                break;
            }
            case SCRIPT_COMMAND_QUEST_EXPLORED:
            {
                Quest const* quest = sObjectMgr.GetQuestTemplate(tmp.datalong);
                if (!quest)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid quest (ID: %u) in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }

                if (!quest->HasFlag(QUEST_LOOKING4GROUP_FLAGS_EXPLORATION_OR_EVENT))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has quest (ID: %u) in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u, but quest not have flag QUEST_LOOKING4GROUP_FLAGS_EXPLORATION_OR_EVENT in quest flags. Script command or quest flags wrong. Quest modified to require objective.",tablename,tmp.datalong,tmp.id);

                    // this will prevent quest completing without objective
                    const_cast<Quest*>(quest)->SetFlag(QUEST_LOOKING4GROUP_FLAGS_EXPLORATION_OR_EVENT);

                    // continue; - quest objective requirement set and command can be allowed
                }

                if (float(tmp.datalong2) > DEFAULT_VISIBILITY_DISTANCE)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has too large distance (%u) for exploring objective complete in `datalong2` in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u",
                        tablename,tmp.datalong2,tmp.id);
                    continue;
                }

                if (tmp.datalong2 && float(tmp.datalong2) > DEFAULT_VISIBILITY_DISTANCE)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has too large distance (%u) for exploring objective complete in `datalong2` in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u, max distance is %f or 0 for disable distance check",
                        tablename,tmp.datalong2,tmp.id,DEFAULT_VISIBILITY_DISTANCE);
                    continue;
                }

                if (tmp.datalong2 && float(tmp.datalong2) < INTERACTION_DISTANCE)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has too small distance (%u) for exploring objective complete in `datalong2` in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u, min distance is %f or 0 for disable distance check",
                        tablename,tmp.datalong2,tmp.id,INTERACTION_DISTANCE);
                    continue;
                }

                break;
            }

            case SCRIPT_COMMAND_REMOVE_AURA:
            case SCRIPT_COMMAND_CAST_SPELL:
            {
                if (!sSpellStore.LookupEntry(tmp.datalong))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` using non-existent spell (id: %u) in SCRIPT_COMMAND_REMOVE_AURA or SCRIPT_COMMAND_CAST_SPELL for script id %u",
                        tablename,tmp.datalong,tmp.id);
                    continue;
                }
                break;
            }
            case SCRIPT_COMMAND_SET_INST_DATA:
            {
                if (tmp.datalong2 < 0 || tmp.datalong2 > 5)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has wrong value (%u) for instance data in `datalong2` in SCRIPT_COMMAND_SET_INST_DATA in `datalong2` for script id %u",
                        tablename,tmp.datalong2,tmp.id);
                    continue;
                }
                break;
            }
        }

        if (scripts.find(tmp.id) == scripts.end())
        {
            ScriptMap emptyMap;
            scripts[tmp.id] = emptyMap;
        }
        scripts[tmp.id].insert(std::pair<uint32, ScriptInfo>(tmp.delay, tmp));

        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u script definitions", count);
}

void ScriptMgr::CheckScripts(ScriptMapMap const& scripts,std::set<int32>& ids)
{
    for (ScriptMapMap::const_iterator itrMM = scripts.begin(); itrMM != scripts.end(); ++itrMM)
    {
        for (ScriptMap::const_iterator itrM = itrMM->second.begin(); itrM != itrMM->second.end(); ++itrM)
        {
            if (itrM->second.dataint)
            {
                if (!sObjectMgr.GetTrinityStringLocale (itrM->second.dataint))
                    sLog.outLog(LOG_DB_ERR, "Table `db_script_string` has not existed string id  %u", itrM->first);

                if (ids.count(itrM->second.dataint))
                    ids.erase(itrM->second.dataint);
            }
        }
    }
}

void ScriptMgr::LoadGameObjectScripts()
{
    LoadScripts(sGameObjectScripts, "gameobject_scripts");

    // check ids
    for (ScriptMapMap::const_iterator itr = sGameObjectScripts.begin(); itr != sGameObjectScripts.end(); ++itr)
    {
        if (!sObjectMgr.GetGOData(itr->first))
            sLog.outLog(LOG_DB_ERR, "Table `gameobject_scripts` has not existing gameobject (GUID: %u) as script id", itr->first);
    }
}

void ScriptMgr::LoadQuestEndScripts()
{
    LoadScripts(sQuestEndScripts, "quest_end_scripts");

    // check ids
    for (ScriptMapMap::const_iterator itr = sQuestEndScripts.begin(); itr != sQuestEndScripts.end(); ++itr)
    {
        if (!sObjectMgr.GetQuestTemplate(itr->first))
            sLog.outLog(LOG_DB_ERR, "Table `quest_end_scripts` has not existing quest (Id: %u) as script id", itr->first);
    }
}

void ScriptMgr::LoadQuestStartScripts()
{
    LoadScripts(sQuestStartScripts,"quest_start_scripts");

    // check ids
    for (ScriptMapMap::const_iterator itr = sQuestStartScripts.begin(); itr != sQuestStartScripts.end(); ++itr)
    {
        if (!sObjectMgr.GetQuestTemplate(itr->first))
            sLog.outLog(LOG_DB_ERR, "Table `quest_start_scripts` has not existing quest (Id: %u) as script id", itr->first);
    }
}

void ScriptMgr::LoadSpellScripts()
{
    LoadScripts(sSpellScripts, "spell_scripts");

    // check ids
    for (ScriptMapMap::const_iterator itr = sSpellScripts.begin(); itr != sSpellScripts.end(); ++itr)
    {
        SpellEntry const* spellInfo = sSpellStore.LookupEntry(itr->first);
        if (!spellInfo)
        {
            sLog.outLog(LOG_DB_ERR, "Table `spell_scripts` has not existing spell (Id: %u) as script id", itr->first);
            continue;
        }

        //check for correct spellEffect
        bool found = false;
        for (int i=0; i<3; ++i)
        {
            // skip empty effects
            if (!spellInfo->Effect[i])
                continue;

            if (spellInfo->Effect[i] == SPELL_EFFECT_SCRIPT_EFFECT)
            {
                found =  true;
                break;
            }
        }

        if (!found)
            sLog.outLog(LOG_DB_ERR, "Table `spell_scripts` has unsupported spell (Id: %u) without SPELL_EFFECT_SCRIPT_EFFECT (%u) spell effect",itr->first,SPELL_EFFECT_SCRIPT_EFFECT);
    }
}

void ScriptMgr::LoadEventScripts()
{
    LoadScripts(sEventScripts, "event_scripts");

    std::set<uint32> evt_scripts;
    // Load all possible script entries from gameobjects
    for (uint32 i = 1; i < sGOStorage.MaxEntry; ++i)
    {
        if (GameObjectInfo const * goInfo = sGOStorage.LookupEntry<GameObjectInfo>(i))
            if (uint32 eventId = goInfo->GetEventScriptId())
                evt_scripts.insert(eventId);
    }

    // Load all possible script entries from spells
    for (uint32 i = 1; i < sSpellStore.GetNumRows(); ++i)
    {
        SpellEntry const * spell = sSpellStore.LookupEntry(i);
        if (spell)
        {
            for (int j=0; j<3; ++j)
            {
                if (spell->Effect[j] == SPELL_EFFECT_SEND_EVENT)
                {
                    if (spell->EffectMiscValue[j])
                        evt_scripts.insert(spell->EffectMiscValue[j]);
                }
            }
        }
    }

    for (size_t path_idx = 0; path_idx < sTaxiPathNodesByPath.size(); ++path_idx)
    {
        for (size_t node_idx = 0; node_idx < sTaxiPathNodesByPath[path_idx].size(); ++node_idx)
        {
            TaxiPathNodeEntry const& node = sTaxiPathNodesByPath[path_idx][node_idx];

            if (node.arrivalEventID)
                evt_scripts.insert(node.arrivalEventID);

            if (node.departureEventID)
                evt_scripts.insert(node.departureEventID);
        }
    }

    // Then check if all scripts are in above list of possible script entries
    for (ScriptMapMap::const_iterator itr = sEventScripts.begin(); itr != sEventScripts.end(); ++itr)
    {
        std::set<uint32>::const_iterator itr2 = evt_scripts.find(itr->first);
        if (itr2 == evt_scripts.end())
            sLog.outLog(LOG_DB_ERR, "Table `event_scripts` has script (Id: %u) not referring to any gameobject_template type 10 data2 field or type 3 data6 field or any spell effect %u", itr->first, SPELL_EFFECT_SEND_EVENT);
    }
}

void ScriptMgr::LoadEventIdScripts()
{
    m_EventIdScripts.clear();                           // need for reload case
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT id, ScriptName FROM scripted_event_id");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u scripted event id", count);
        return;
    }

    BarGoLink bar((int)result->GetRowCount());

    // TODO: remove duplicate code below, same way to collect event id's used in LoadEventScripts()
    std::set<uint32> evt_scripts;

    // Load all possible event entries from gameobjects
    for(uint32 i = 1; i < sGOStorage.MaxEntry; ++i)
        if (GameObjectInfo const* goInfo = sGOStorage.LookupEntry<GameObjectInfo>(i))
            if (uint32 eventId = goInfo->GetEventScriptId())
                evt_scripts.insert(eventId);

    // Load all possible event entries from spells
    for(uint32 i = 1; i < sSpellStore.GetNumRows(); ++i)
    {
        SpellEntry const* spell = sSpellStore.LookupEntry(i);
        if (spell)
        {
            for(int j = 0; j < 3; ++j)
            {
                if (spell->Effect[j] == SPELL_EFFECT_SEND_EVENT)
                {
                    if (spell->EffectMiscValue[j])
                        evt_scripts.insert(spell->EffectMiscValue[j]);
                }
            }
        }
    }

    // Load all possible event entries from taxi path nodes
    for(size_t path_idx = 0; path_idx < sTaxiPathNodesByPath.size(); ++path_idx)
    {
        for(size_t node_idx = 0; node_idx < sTaxiPathNodesByPath[path_idx].size(); ++node_idx)
        {
            TaxiPathNodeEntry const& node = sTaxiPathNodesByPath[path_idx][node_idx];

            if (node.arrivalEventID)
                evt_scripts.insert(node.arrivalEventID);

            if (node.departureEventID)
                evt_scripts.insert(node.departureEventID);
        }
    }

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 eventId          = fields[0].GetUInt32();
        const char *scriptName  = fields[1].GetString();

        std::set<uint32>::const_iterator itr = evt_scripts.find(eventId);
        if (itr == evt_scripts.end())
            sLog.outLog(LOG_DB_ERR, "Table `scripted_event_id` has id %u not referring to any gameobject_template type 10 data2 field, type 3 data6 field, type 13 data 2 field or any spell effect %u or path taxi node data",
                eventId, SPELL_EFFECT_SEND_EVENT);

        m_EventIdScripts[eventId] = GetScriptId(scriptName);
    } while(result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u scripted event id", count);
}

void ScriptMgr::LoadSpellIdScripts()
{
    m_SpellIdScripts.clear();                           // need for reload case
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT id, ScriptName FROM scripted_spell_id");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u scripted spell id", count);
        return;
    }

    BarGoLink bar(int(result->GetRowCount()));

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 spellId          = fields[0].GetUInt32();
        const char *scriptName  = fields[1].GetString();

        SpellEntry const *pSpell = GetSpellStore()->LookupEntry(spellId);
        if (!pSpell)
            sLog.outLog(LOG_DB_ERR, "Table `scripted_spell_id` has id %u referring to non-existing spell", spellId);

        m_SpellIdScripts[spellId] = GetScriptId(scriptName);
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u scripted spell id", count);
}

//Load WP Scripts
void ScriptMgr::LoadWaypointScripts()
{
    LoadScripts(sWaypointScripts, "waypoint_scripts");

    for (ScriptMapMap::const_iterator itr = sWaypointScripts.begin(); itr != sWaypointScripts.end(); ++itr)
    {
        QueryResultAutoPtr query = GameDataDatabase.PQuery("SELECT * FROM `waypoint_scripts` WHERE `id` = %u", itr->first);
        if (!query || !query->GetRowCount())
            sLog.outLog(LOG_DB_ERR, "There is no waypoint which links to the waypoint script %u", itr->first);
    }
}

void ScriptMgr::LoadDbScriptStrings()
{
    LoadLooking4groupStrings(GameDataDatabase,"db_script_string",MIN_DB_SCRIPT_STRING_ID,MAX_DB_SCRIPT_STRING_ID);

    std::set<int32> ids;

    for (int32 i = MIN_DB_SCRIPT_STRING_ID; i < MAX_DB_SCRIPT_STRING_ID; ++i)
        if (sObjectMgr.GetTrinityStringLocale(i))
            ids.insert(i);

    CheckScripts(sQuestEndScripts,ids);
    CheckScripts(sQuestStartScripts,ids);
    CheckScripts(sSpellScripts,ids);
    CheckScripts(sGameObjectScripts,ids);
    CheckScripts(sEventScripts,ids);

    CheckScripts(sWaypointScripts,ids);

    for (std::set<int32>::const_iterator itr = ids.begin(); itr != ids.end(); ++itr)
        sLog.outLog(LOG_DB_ERR, "Table `db_script_string` has unused string id  %u", *itr);
}

void ScriptMgr::LoadScriptNames()
{
    m_scriptNames.push_back("");
    QueryResultAutoPtr result = GameDataDatabase.Query(
      "SELECT DISTINCT(ScriptName) FROM creature_template WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM gameobject_template WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM item_template WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM areatrigger_scripts WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM completed_cinematic_scripts WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM scripted_event_id WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM scripted_spell_id WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(script) FROM instance_template WHERE script <> ''");
    if (result)
    {
        do
        {
            m_scriptNames.push_back((*result)[0].GetString());
        } while (result->NextRow());
    }

    std::sort(m_scriptNames.begin(), m_scriptNames.end());
}

void ScriptMgr::LoadAreaTriggerScripts()
{
    m_AreaTriggerScripts.clear();                            // need for reload case
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry, ScriptName FROM areatrigger_scripts");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u areatrigger scripts", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 Trigger_ID      = fields[0].GetUInt32();
        const char *scriptName = fields[1].GetString();

        AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(Trigger_ID);
        if (!atEntry)
        {
            sLog.outLog(LOG_DB_ERR, "Area trigger (ID:%u) does not exist in `AreaTrigger.dbc`.",Trigger_ID);
            continue;
        }
        m_AreaTriggerScripts[Trigger_ID] = GetScriptId(scriptName);
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u areatrigger scripts", count);
}

void ScriptMgr::LoadCompletedCinematicScripts()
{
    m_CompletedCinematicScripts.clear();                            // need for reload case
    QueryResultAutoPtr result = GameDataDatabase.Query("SELECT entry, ScriptName FROM completed_cinematic_scripts");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u after completed cinematic scripts", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 Cinematic_ID    = fields[0].GetUInt32();
        const char *scriptName = fields[1].GetString();

        CinematicSequencesEntry const* cinematic = sCinematicSequencesStore.LookupEntry(Cinematic_ID);
        if (!cinematic)
        {
            sLog.outLog(LOG_DB_ERR, "Cinematic sequence (ID:%u) does not exist in `CinematicSequeces.dbc`.",Cinematic_ID);
            continue;
        }
        m_CompletedCinematicScripts[Cinematic_ID] = GetScriptId(scriptName);
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u after completed cinematic scripts", count);
}


CreatureAI* ScriptMgr::GetCreatureAI(Creature* pCreature)
{
    if (!m_pGetCreatureAI)
        return NULL;

    return m_pGetCreatureAI(pCreature);
}

InstanceData* ScriptMgr::CreateInstanceData(Map* pMap)
{
    if (!m_pCreateInstanceData)
        return NULL;

    return m_pCreateInstanceData(pMap);
}

bool ScriptMgr::OnGossipHello(Player* pPlayer, Creature* pCreature)
{
    return m_pOnGossipHello != NULL && m_pOnGossipHello(pPlayer, pCreature);
}

bool ScriptMgr::OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 action, const char* code)
{
    if (code)
        return m_pOnGossipSelectWithCode != NULL && m_pOnGossipSelectWithCode(pPlayer, pCreature, sender, action, code);
    else
        return m_pOnGossipSelect != NULL && m_pOnGossipSelect(pPlayer, pCreature, sender, action);
}

bool ScriptMgr::OnGossipSelect(Player* pPlayer, GameObject* pGameObject, uint32 sender, uint32 action, const char* code)
{
    if (code)
        return m_pOnGOGossipSelectWithCode != NULL && m_pOnGOGossipSelectWithCode(pPlayer, pGameObject, sender, action, code);
    else
        return m_pOnGOGossipSelect != NULL && m_pOnGOGossipSelect(pPlayer, pGameObject, sender, action);
}

bool ScriptMgr::OnQuestAccept(Player* pPlayer, Creature* pCreature, Quest const* pQuest)
{
    return m_pOnQuestAccept != NULL && m_pOnQuestAccept(pPlayer, pCreature, pQuest);
}

bool ScriptMgr::OnQuestAccept(Player* pPlayer, GameObject* pGameObject, Quest const* pQuest)
{
    return m_pOnGOQuestAccept != NULL && m_pOnGOQuestAccept(pPlayer, pGameObject, pQuest);
}

bool ScriptMgr::OnQuestAccept(Player* pPlayer, Item* pItem, Quest const* pQuest)
{
    return m_pOnItemQuestAccept != NULL && m_pOnItemQuestAccept(pPlayer, pItem, pQuest);
}

bool ScriptMgr::OnQuestRewarded(Player* pPlayer, Creature* pCreature, Quest const* pQuest)
{
    return m_pOnQuestRewarded != NULL && m_pOnQuestRewarded(pPlayer, pCreature, pQuest);
}

bool ScriptMgr::OnQuestRewarded(Player* pPlayer, GameObject* pGameObject, Quest const* pQuest)
{
    return m_pOnGOQuestRewarded != NULL && m_pOnGOQuestRewarded(pPlayer, pGameObject, pQuest);
}

uint32 ScriptMgr::GetDialogStatus(Player* pPlayer, Creature* pCreature)
{
    if (!m_pGetNPCDialogStatus)
        return 100;

    return m_pGetNPCDialogStatus(pPlayer, pCreature);
}

uint32 ScriptMgr::GetDialogStatus(Player* pPlayer, GameObject* pGameObject)
{
    if (!m_pGetGODialogStatus)
        return 100;

    return m_pGetGODialogStatus(pPlayer, pGameObject);
}

bool ScriptMgr::OnGameObjectUse(Player* pPlayer, GameObject* pGameObject)
{
    return m_pOnGOUse != NULL && m_pOnGOUse(pPlayer, pGameObject);
}

bool ScriptMgr::OnItemUse(Player* pPlayer, Item* pItem, SpellCastTargets const& targets)
{
    return m_pOnItemUse != NULL && m_pOnItemUse(pPlayer, pItem, targets);
}

bool ScriptMgr::OnAreaTrigger(Player* pPlayer, AreaTriggerEntry const* atEntry)
{
    return m_pOnAreaTrigger != NULL && m_pOnAreaTrigger(pPlayer, atEntry);
}

bool ScriptMgr::OnCompletedCinematic(Player* pPlayer, CinematicSequencesEntry const* cinematic)
{
    return m_pOnCompletedCinematic != NULL && m_pOnCompletedCinematic(pPlayer, cinematic);
}

bool ScriptMgr::OnProcessEvent(uint32 eventId, Object* pSource, Object* pTarget, bool isStart)
{
    return m_pOnProcessEvent != NULL && m_pOnProcessEvent(eventId, pSource, pTarget, isStart);
}

bool ScriptMgr::OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, Creature* pTarget)
{
    return m_pOnEffectDummyCreature != NULL && m_pOnEffectDummyCreature(pCaster, spellId, effIndex, pTarget);
}

bool ScriptMgr::OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, GameObject* pTarget)
{
    return m_pOnEffectDummyGO != NULL && m_pOnEffectDummyGO(pCaster, spellId, effIndex, pTarget);
}

bool ScriptMgr::OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, Item* pTarget)
{
    return m_pOnEffectDummyItem != NULL && m_pOnEffectDummyItem(pCaster, spellId, effIndex, pTarget);
}

bool ScriptMgr::OnAuraDummy(Aura const* pAura, bool apply)
{
    return m_pOnAuraDummy != NULL && m_pOnAuraDummy(pAura, apply);
}

bool ScriptMgr::OnReceiveEmote(Player *pPlayer, Creature *pCreature, uint32 emote)
{
    return m_pOnReceiveEmote != NULL && m_pOnReceiveEmote(pPlayer, pCreature, emote);
}

// spell scripts
bool ScriptMgr::OnSpellSetTargetMap(Unit* pCaster, std::list<Unit*> &unitList, SpellCastTargets const& targets, SpellEntry const *pSpell, uint32 effectIndex)
{
    return m_pOnSpellSetTargetMap != NULL && m_pOnSpellSetTargetMap(pCaster, unitList, targets, pSpell, effectIndex);
}

bool ScriptMgr::OnSpellHandleEffect(Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex)
{
    return m_pOnSpellHandleEffect != NULL && m_pOnSpellHandleEffect(pCaster, pUnit, pItem, pGameObject, pSpell, effectIndex);
}

bool ScriptMgr::LoadScriptLibrary(const char* libName)
{
    UnloadScriptLibrary();

    std::string name = libName;
    name = LOOKING4GROUP_SCRIPT_PREFIX + name + LOOKING4GROUP_SCRIPT_SUFFIX;

    m_hScriptLib = LOOKING4GROUP_LOAD_LIBRARY(name.c_str());

    if (!m_hScriptLib)
        return false;

    GetScriptHookPtr(m_pOnInitScriptLibrary,        "InitScriptLibrary");
    GetScriptHookPtr(m_pOnFreeScriptLibrary,        "FreeScriptLibrary");
    GetScriptHookPtr(m_pGetScriptLibraryVersion,    "GetScriptLibraryVersion");

    GetScriptHookPtr(m_pGetCreatureAI,              "GetCreatureAI");
    GetScriptHookPtr(m_pCreateInstanceData,         "CreateInstanceData");

    GetScriptHookPtr(m_pOnGossipHello,              "GossipHello");
    GetScriptHookPtr(m_pOnGossipSelect,             "GossipSelect");
    GetScriptHookPtr(m_pOnGOGossipSelect,           "GOGossipSelect");
    GetScriptHookPtr(m_pOnGossipSelectWithCode,     "GossipSelectWithCode");
    GetScriptHookPtr(m_pOnGOGossipSelectWithCode,   "GOGossipSelectWithCode");
    GetScriptHookPtr(m_pOnQuestAccept,              "QuestAccept");
    GetScriptHookPtr(m_pOnGOQuestAccept,            "GOQuestAccept");
    GetScriptHookPtr(m_pOnItemQuestAccept,          "ItemQuestAccept");
    GetScriptHookPtr(m_pOnQuestRewarded,            "QuestRewarded");
    GetScriptHookPtr(m_pOnGOQuestRewarded,          "GOQuestRewarded");
    GetScriptHookPtr(m_pGetNPCDialogStatus,         "GetNPCDialogStatus");
    GetScriptHookPtr(m_pGetGODialogStatus,          "GetGODialogStatus");
    GetScriptHookPtr(m_pOnGOUse,                    "GOUse");
    GetScriptHookPtr(m_pOnItemUse,                  "ItemUse");
    GetScriptHookPtr(m_pOnAreaTrigger,              "AreaTrigger");
    GetScriptHookPtr(m_pOnCompletedCinematic,       "CompletedCinematic");
    GetScriptHookPtr(m_pOnProcessEvent,             "ProcessEvent");
    GetScriptHookPtr(m_pOnEffectDummyCreature,      "EffectDummyCreature");
    GetScriptHookPtr(m_pOnEffectDummyGO,            "EffectDummyGameObject");
    GetScriptHookPtr(m_pOnEffectDummyItem,          "EffectDummyItem");
    GetScriptHookPtr(m_pOnAuraDummy,                "AuraDummy");

    GetScriptHookPtr(m_pOnReceiveEmote,             "ReceiveEmote");

    // spell scripts
    GetScriptHookPtr(m_pOnSpellSetTargetMap,         "SpellSetTargetMap");
    GetScriptHookPtr(m_pOnSpellHandleEffect,         "SpellHandleEffect");


    if (m_pOnInitScriptLibrary)
        m_pOnInitScriptLibrary(sConfig.GetFilename().c_str());

    if (m_pGetScriptLibraryVersion)
        sWorld.SetScriptsVersion(m_pGetScriptLibraryVersion());

    return true;
}

void ScriptMgr::UnloadScriptLibrary()
{
    if (!m_hScriptLib)
        return;

    if (m_pOnFreeScriptLibrary)
        m_pOnFreeScriptLibrary();

    LOOKING4GROUP_CLOSE_LIBRARY(m_hScriptLib);
    m_hScriptLib = NULL;

    m_pOnInitScriptLibrary      = NULL;
    m_pOnFreeScriptLibrary      = NULL;
    m_pGetScriptLibraryVersion  = NULL;

    m_pGetCreatureAI            = NULL;
    m_pCreateInstanceData       = NULL;

    m_pOnGossipHello            = NULL;
    m_pOnGossipSelect           = NULL;
    m_pOnGOGossipSelect         = NULL;
    m_pOnGossipSelectWithCode   = NULL;
    m_pOnGOGossipSelectWithCode = NULL;
    m_pOnQuestAccept            = NULL;
    m_pOnGOQuestAccept          = NULL;
    m_pOnItemQuestAccept        = NULL;
    m_pOnQuestRewarded          = NULL;
    m_pOnGOQuestRewarded        = NULL;
    m_pGetNPCDialogStatus       = NULL;
    m_pGetGODialogStatus        = NULL;
    m_pOnGOUse                  = NULL;
    m_pOnItemUse                = NULL;
    m_pOnAreaTrigger            = NULL;
    m_pOnCompletedCinematic     = NULL;
    m_pOnProcessEvent           = NULL;
    m_pOnEffectDummyCreature    = NULL;
    m_pOnEffectDummyGO          = NULL;
    m_pOnEffectDummyItem        = NULL;
    m_pOnAuraDummy              = NULL;
}

uint32 ScriptMgr::GetEventIdScriptId(uint32 eventId) const
{
    EventIdScriptMap::const_iterator itr = m_EventIdScripts.find(eventId);
    if (itr != m_EventIdScripts.end())
        return itr->second;

    return 0;
}

uint32 ScriptMgr::GetSpellIdScriptId(uint32 eventId) const
{
    SpellIdScriptMap::const_iterator itr = m_SpellIdScripts.find(eventId);
    if (itr != m_SpellIdScripts.end())
        return itr->second;

    return 0;
}

uint32 ScriptMgr::GetScriptId(const char *name)
{
    // use binary search to find the script name in the sorted vector
    // assume "" is the first element
    if (!name) return 0;
    ScriptNameMap::const_iterator itr =
        std::lower_bound(m_scriptNames.begin(), m_scriptNames.end(), name);
    if (itr == m_scriptNames.end() || *itr != name) return 0;
    return itr - m_scriptNames.begin();
}

uint32 ScriptMgr::GetAreaTriggerScriptId(uint32 trigger_id) const
{
    AreaTriggerScriptMap::const_iterator i = m_AreaTriggerScripts.find(trigger_id);
    if (i!= m_AreaTriggerScripts.end())
        return i->second;
    return 0;
}

uint32 ScriptMgr::GetCompletedCinematicScriptId(uint32 cinematic_id) const
{
    CompletedCinematicScriptMap::const_iterator i = m_CompletedCinematicScripts.find(cinematic_id);
    if (i!= m_CompletedCinematicScripts.end())
        return i->second;
    return 0;
}

uint32 GetEventIdScriptId(uint32 eventId)
{
    return sScriptMgr.GetEventIdScriptId(eventId);
}

uint32 GetSpellIdScriptId(uint32 eventId)
{
    return sScriptMgr.GetSpellIdScriptId(eventId);
}

// Functions for scripting access
uint32 GetAreaTriggerScriptId(uint32 trigger_id)
{
    return sScriptMgr.GetAreaTriggerScriptId(trigger_id);
}

uint32 GetCompletedCinematicScriptId(uint32 cinematic_id)
{
    return sScriptMgr.GetCompletedCinematicScriptId(cinematic_id);
}

uint32 GetScriptId(const char *name)
{
    return sScriptMgr.GetScriptId(name);
}
