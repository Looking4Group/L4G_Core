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

#ifndef LOOKING4GROUP_GAMEEVENT_H
#define LOOKING4GROUP_GAMEEVENT_H

#include "ace/Singleton.h"

#include "Common.h"
#include "SharedDefines.h"
#include "Platform/Define.h"

#define max_ge_check_delay 86400                            // 1 day in seconds

enum GameEventState
{
    GAMEEVENT_NORMAL = 0,   // standard game events
    GAMEEVENT_WORLD_INACTIVE,   // not yet started
    GAMEEVENT_WORLD_CONDITIONS,  // condition matching phase
    GAMEEVENT_WORLD_NEXTPHASE,   // conditions are met, now 'lenght' timer to start next event
    GAMEEVENT_WORLD_FINISHED    // next events are started, unapply this one
};

enum GameEventFlag
{
    GAMEEVENT_FLAG_NONE = 0x0,
    GAMEEVENT_FLAG_REMOVE_QUESTS_AT_END = 0x01
};

struct GameEventFinishCondition
{
    float reqNum;  // required number // use float, since some events use percent
    float done;    // done number
    uint32 max_world_state;  // max resource count world state update id
    uint32 done_world_state; // done resource count world state update id
};

struct GameEventQuestToEventConditionNum
{
    uint16 event_id;
    uint32 condition;
    float num;
};

struct GameEventData
{
    GameEventData() : start(1),end(0),nextstart(0),occurence(0),length(0),state(GAMEEVENT_NORMAL), flags(GAMEEVENT_FLAG_NONE) {}
    time_t start;   // occurs after this time
    time_t end;     // occurs before this time
    time_t nextstart; // after this time the follow-up events count this phase completed
    uint32 occurence;   // time between end and start
    uint32 length;  // length of the event (minutes) after finishing all conditions
    GameEventState state;   // state of the game event, these are saved into the game_event table on change!
    std::map<uint32 /*condition id*/, GameEventFinishCondition> conditions;  // conditions to finish
    std::set<uint16 /*gameevent id*/> prerequisite_events;  // events that must be completed before starting this event
    std::string description;
    GameEventFlag flags;

    bool isValid() const { return ((length > 0) || (state > GAMEEVENT_NORMAL)); }
};

struct ModelEquip
{
    uint32 modelid;
    uint32 equipment_id;
    uint32 modelid_prev;
    uint32 equipement_id_prev;
};

struct NPCVendorEntry
{
    uint32 entry;                                           // creature entry
    uint32 item;                                            // item id
    uint32 maxcount;                                        // 0 for infinite
    uint32 incrtime;                                        // time for restore items amount if maxcount != 0
    uint32 ExtendedCost;
};

class Player;
class Creature;

class GameEventMgr
{
    friend class ACE_Singleton<GameEventMgr, ACE_Null_Mutex>;
    GameEventMgr();

    public:
        char const* getActiveEventsString();
        ~GameEventMgr() {};
        typedef std::set<uint16> ActiveEvents;
        typedef std::vector<GameEventData> GameEventDataMap;
        ActiveEvents const& GetActiveEventList() const { return m_ActiveEvents; }
        GameEventDataMap /*const*/& GetEventMap() /*const*/ { return mGameEvent; }
        bool CheckOneGameEvent(uint16 entry) const;
        uint32 NextCheck(uint16 entry) const;
        void LoadFromDB();
        uint32 Update();
        bool IsActiveEvent(uint16 event_id) { return (m_ActiveEvents.find(event_id)!=m_ActiveEvents.end()); }
        uint32 Initialize();
        bool StartEvent(uint16 event_id, bool overwrite = false);
        void StopEvent(uint16 event_id, bool overwrite = false);
        void HandleQuestComplete(uint32 quest_id);  // called on world event type quest completions
        void HandleWorldEventGossip(Player * plr, Creature * c);
        uint32 GetNPCFlag(Creature * cr);
        uint32 GetNpcTextId(uint32 guid);
    private:
        void SendWorldStateUpdate(Player * plr, uint16 event_id);
        void AddActiveEvent(uint16 event_id) { m_ActiveEvents.insert(event_id); }
        void RemoveActiveEvent(uint16 event_id) { m_ActiveEvents.erase(event_id); }
        void ApplyNewEvent(uint16 event_id);
        void UnApplyEvent(uint16 event_id);
        void GameEventSpawn(int16 event_id);
        void GameEventUnspawn(int16 event_id);
        void ChangeEquipOrModel(int16 event_id, bool activate);
        void UpdateEventQuests(uint16 event_id, bool Activate);
        void UpdateEventNPCFlags(uint16 event_id);
        void UpdateEventNPCVendor(uint16 event_id, bool activate);
        bool CheckOneGameEventConditions(uint16 event_id);
        void SaveWorldEventStateToDB(uint16 event_id);
        bool hasCreatureQuestActiveEventExcept(uint32 quest_id, uint16 event_id);
        bool hasGameObjectQuestActiveEventExcept(uint32 quest_id, uint16 event_id);
        bool hasCreatureActiveEventExcept(uint32 creature_guid, uint16 event_id);
        bool hasGameObjectActiveEventExcept(uint32 go_guid, uint16 event_id);
    protected:
        typedef std::list<uint32> GuidList;
        typedef std::list<uint16> IdList;
        typedef std::vector<GuidList> GameEventGuidMap;
        typedef std::vector<IdList> GameEventIdMap;
        typedef std::pair<uint32, ModelEquip> ModelEquipPair;
        typedef std::list<ModelEquipPair> ModelEquipList;
        typedef std::vector<ModelEquipList> GameEventModelEquipMap;
        typedef std::pair<uint32, uint32> QuestRelation;
        typedef std::list<QuestRelation> QuestRelList;
        typedef std::vector<QuestRelList> GameEventQuestMap;
        typedef std::list<NPCVendorEntry> NPCVendorList;
        typedef std::vector<NPCVendorList> GameEventNPCVendorMap;
        typedef std::map<uint32 /*quest id*/, GameEventQuestToEventConditionNum> QuestIdToEventConditionMap;
        typedef std::pair<uint32 /*guid*/, uint32 /*npcflag*/> GuidNPCFlagPair;
        typedef std::list<GuidNPCFlagPair> NPCFlagList;
        typedef std::vector<NPCFlagList> GameEventNPCFlagMap;
        typedef std::pair<uint16 /*event id*/, uint32 /*gossip id*/> EventNPCGossipIdPair;
        typedef std::multimap<uint32 /*guid*/, EventNPCGossipIdPair> GuidEventNpcGossipIdMap;
        typedef std::vector<uint32> GameEventBitmask;
        GameEventQuestMap mGameEventCreatureQuests;
        GameEventQuestMap mGameEventGameObjectQuests;
        GameEventNPCVendorMap mGameEventVendors;
        GameEventModelEquipMap mGameEventModelEquip;
        GameEventGuidMap  mGameEventCreatureGuids;
        GameEventGuidMap  mGameEventGameobjectGuids;
        GameEventIdMap    mGameEventPoolIds;
        GameEventDataMap  mGameEvent;
        GameEventBitmask  mGameEventBattleGroundHolidays;
        QuestIdToEventConditionMap mQuestToEventConditions;
        GameEventNPCFlagMap mGameEventNPCFlags;
        GuidEventNpcGossipIdMap mNPCGossipIds;
        ActiveEvents m_ActiveEvents;
        bool isSystemInit;
};

#define sGameEventMgr (*ACE_Singleton<GameEventMgr, ACE_Null_Mutex>::instance())
#endif

LOOKING4GROUP_IMPORT_EXPORT bool isGameEventActive(uint16 event_id);
LOOKING4GROUP_IMPORT_EXPORT void HandleWorldEventGossip(Player*, Creature*);
