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

#ifndef __BATTLEGROUNDMGR_H
#define __BATTLEGROUNDMGR_H

#include "ace/Singleton.h"

#include "Common.h"
#include "BattleGround.h"

typedef std::map<uint32, BattleGround*> BattleGroundSet;

//this container can't be deque, because deque doesn't like removing the last element - if you remove it, it invalidates next iterator and crash appears
typedef std::list<BattleGround*> BGFreeSlotQueueType;

#define MAX_BATTLEGROUND_QUEUES 7                           // for level ranges 10-19, 20-29, 30-39, 40-49, 50-59, 60-69, 70+

typedef UNORDERED_MAP<uint32, BattleGroundTypeId> BattleMastersMap;

#define BATTLEGROUND_ARENA_POINT_DISTRIBUTION_DAY   86400   // seconds in a day

struct GroupQueueInfo;                                      // type predefinition
struct PlayerQueueInfo                                      // stores information for players in queue
{
    uint32  InviteTime;                                     // first invite time
    uint32  LastInviteTime;                                 // last invite time
    uint32  LastOnlineTime;                                 // for tracking and removing offline players from queue after 5 minutes
    GroupQueueInfo * GroupInfo;                             // pointer to the associated groupqueueinfo
};

struct GroupQueueInfo                                       // stores information about the group in queue (also used when joined as solo!)
{
    std::map<uint64, PlayerQueueInfo*> Players;             // player queue info map
    uint32  Team;                                           // Player team (ALLIANCE/HORDE)
    BattleGroundTypeId BgTypeId;                            // battleground type id
    bool    IsRated;                                        // rated
    uint8   ArenaType;                                      // 2v2, 3v3, 5v5 or 0 when BG
    uint32  ArenaTeamId;                                    // team id if rated match
    uint32  JoinTime;                                       // time when group was added
    uint32  IsInvitedToBGInstanceGUID;                      // was invited to certain BG
    uint32  ArenaTeamRating;                                // if rated match, inited to the rating of the team
    uint32  HiddenRating;                                   // if rated match, inited to the rating of the team
    uint32  OpponentsTeamRating;                            // for rated arena matches
    uint32  OpponentsHiddenRating;                          // for rated arena matches

    BattleGroundTeamId GetBGTeam()
    {
        return Team == HORDE ? BG_TEAM_HORDE : BG_TEAM_ALLIANCE;
    }
};

enum BattleGroundQueueGroupTypes
{
    BG_QUEUE_PREMADE_ALLIANCE   = 0,
    BG_QUEUE_PREMADE_HORDE      = 1,
    BG_QUEUE_NORMAL_ALLIANCE    = 2,
    BG_QUEUE_NORMAL_HORDE       = 3
};
#define BG_QUEUE_GROUP_TYPES_COUNT 4

class BattleGround;
class BattleGroundQueue
{
    public:
        BattleGroundQueue();
        ~BattleGroundQueue();

        void Update(BattleGroundTypeId bgTypeId, BattleGroundBracketId bracket_id, uint8 arenaType = 0, bool isRated = false, uint32 minRating = 0, uint32 hiddenRating = 0);
 
        bool CheckMixedMatch(BattleGround* bg_template, BattleGroundBracketId bracket_id, uint32 minPlayers, uint32 maxPlayers);
        bool MixPlayersToBG(BattleGround* bg, BattleGroundBracketId bracket_id);

        void FillPlayersToBG(BattleGround* bg, BattleGroundBracketId bracket_id);
        bool CheckPremadeMatch(BattleGroundBracketId bracket_id, uint32 MaxPlayersPerTeam, uint32 MinPlayersPerTeam);
        bool CheckNormalMatch(BattleGround* bg_template, BattleGroundBracketId bracket_id, uint32 minPlayers, uint32 maxPlayers);
        bool CheckSkirmishForSameFaction(BattleGroundBracketId bracket_id, uint32 minPlayersPerTeam);
        GroupQueueInfo * AddGroup(Player* leader, BattleGroundTypeId bgTypeId, BattleGroundBracketId bracket_id, uint8 ArenaType, bool isRated, bool isPremade, uint32 ArenaRating, uint32 hiddenRating, uint32 ArenaTeamId = 0);
        void AddPlayer(Player *plr, GroupQueueInfo *ginfo);
        void RemovePlayer(const uint64& guid, bool decreaseInvitedCount);
        void DecreaseGroupLength(uint32 queueId, uint32 AsGroup);
        void BGEndedRemoveInvites(BattleGround * bg);

        uint32 GetQueuedPlayersCount(BattleGroundTeamId team, BattleGroundBracketId bracketId);
        uint32 GetQueuedPlayersCountCrossfaction(BattleGroundBracketId bracketId);

        typedef std::map<uint64, PlayerQueueInfo> QueuedPlayersMap;
        QueuedPlayersMap m_QueuedPlayers;

        //we need constant add to begin and constant remove / add from the end, therefore deque suits our problem well
        typedef std::list<GroupQueueInfo*> GroupsQueueType;

        /*
        This two dimensional array is used to store All queued groups
        First dimension specifies the bgTypeId
        Second dimension specifies the player's group types -
             BG_QUEUE_PREMADE_ALLIANCE  is used for premade alliance groups and alliance rated arena teams
             BG_QUEUE_PREMADE_HORDE     is used for premade horde groups and horde rated arena teams
             BG_QUEUE_NORMAL_ALLIANCE   is used for normal (or small) alliance groups or non-rated arena matches
             BG_QUEUE_NORMAL_HORDE      is used for normal (or small) horde groups or non-rated arena matches
        */
        GroupsQueueType m_QueuedGroups[MAX_BATTLEGROUND_BRACKETS][BG_QUEUE_GROUP_TYPES_COUNT];

        // class to select and invite groups to bg
        class SelectionPool
        {
        public:
            void Init();
            bool AddGroup(GroupQueueInfo *ginfo, uint32 desiredCount);
            bool KickGroup(uint32 size);
            uint32 GetPlayerCount() const {return PlayerCount;}
        public:
            GroupsQueueType SelectedGroups;
        private:
            uint32 PlayerCount;
        };

        //one selection pool for horde, other one for alliance
        SelectionPool m_SelectionPools[BG_TEAMS_COUNT];

        typedef ACE_Atomic_Op<ACE_Thread_Mutex, uint32> atomicUInt32;
        atomicUInt32 queuedPlayersCount[BG_TEAMS_COUNT][MAX_BATTLEGROUND_BRACKETS];
        atomicUInt32 queuedPlayersCountCrossfaction[MAX_BATTLEGROUND_BRACKETS];

    private:

        bool InviteGroupToBG(GroupQueueInfo * ginfo, BattleGround * bg, uint32 side);
};

/*
    This class is used to invite player to BG again, when minute lasts from his first invitation
    it is capable to solve all possibilities
*/
class BGQueueInviteEvent : public BasicEvent
{
    public:
        BGQueueInviteEvent(const uint64& pl_guid, uint32 BgInstanceGUID, BattleGroundTypeId BgTypeId) :
          m_PlayerGuid(pl_guid), m_BgInstanceGUID(BgInstanceGUID), m_BgTypeId(BgTypeId)
          {
          };
        virtual ~BGQueueInviteEvent() {};

        virtual bool Execute(uint64 e_time, uint32 p_time);
        virtual void Abort(uint64 e_time);
    private:
        uint64 m_PlayerGuid;
        uint32 m_BgInstanceGUID;
        BattleGroundTypeId m_BgTypeId;
};

/*
    This class is used to remove player from BG queue after 2 minutes from first invitation
*/
class BGQueueRemoveEvent : public BasicEvent
{
    public:
        BGQueueRemoveEvent(const uint64& pl_guid, uint32 bgInstanceGUID, BattleGroundTypeId BgTypeId, uint32 playersTeam)
            : m_PlayerGuid(pl_guid), m_BgInstanceGUID(bgInstanceGUID), m_BgTypeId(BgTypeId), m_PlayersTeam(playersTeam)
        {}

        virtual ~BGQueueRemoveEvent() {}

        virtual bool Execute(uint64 e_time, uint32 p_time);
        virtual void Abort(uint64 e_time);
    private:
        uint64 m_PlayerGuid;
        uint32 m_BgInstanceGUID;
        uint32 m_PlayersTeam;
        BattleGroundTypeId m_BgTypeId;
};

class BattleGroundMgr
{
    friend class ACE_Singleton<BattleGroundMgr, ACE_Null_Mutex>;
    BattleGroundMgr();

    public:
        ~BattleGroundMgr();

        void Update(uint32 diff);
        void ScheduleQueueUpdate(BattleGroundQueueTypeId bgQueueTypeId, BattleGroundTypeId bgTypeId, BattleGroundBracketId bracket_id);

        /* Packet Building */
        void BuildPlayerJoinedBattleGroundPacket(WorldPacket *data, Player *plr);
        void BuildPlayerLeftBattleGroundPacket(WorldPacket *data, Player *plr);
        void BuildBattleGroundListPacket(WorldPacket *data, ObjectGuid guid, Player *plr, BattleGroundTypeId bgTypeId);
        void BuildGroupJoinedBattlegroundPacket(WorldPacket *data, BattleGroundTypeId bgTypeId);
        void BuildUpdateWorldStatePacket(WorldPacket *data, uint32 field, uint32 value);
        void BuildPvpLogDataPacket(WorldPacket *data, BattleGround *bg);
        void BuildBattleGroundStatusPacket(WorldPacket *data, BattleGround *bg, uint32 team, uint8 QueueSlot, uint8 StatusID, uint32 Time1, uint32 Time2, uint32 arenatype = 0, uint8 israted = 0);
        void BuildPlaySoundPacket(WorldPacket *data, uint32 soundid);

        void SendAreaSpiritHealerQueryOpcode(Player *pl, BattleGround *bg, const uint64& guid);

        /* Player invitation */
        // called from Queue update, or from Addplayer to queue
        void InvitePlayer(Player* plr, uint32 bgInstanceGUID, BattleGroundTypeId bgTypeId, uint32 team);

        /* Battlegrounds */
        BattleGround* GetBattleGround(uint32 InstanceID, BattleGroundTypeId bgTypeId); //there must be uint32 because MAX_BATTLEGROUND_TYPE_ID means unknown

        BattleGround* GetBattleGroundTemplate(BattleGroundTypeId bgTypeId);
        BattleGround* CreateNewBattleGround(BattleGroundTypeId bgTypeId, BattleGroundBracketId bracket_id, uint8 arenaType, bool isRated);

        uint32 CreateBattleGround(BattleGroundTypeId bgTypeId, bool IsArena, uint32 MinPlayersPerTeam, uint32 MaxPlayersPerTeam, uint32 LevelMin, uint32 LevelMax, char* BattleGroundName, uint32 MapID, float Team1StartLocX, float Team1StartLocY, float Team1StartLocZ, float Team1StartLocO, float Team2StartLocX, float Team2StartLocY, float Team2StartLocZ, float Team2StacOrtLo);

        void AddBattleGround(uint32 InstanceID, BattleGroundTypeId bgTypeId, BattleGround* BG) { m_BattleGrounds[bgTypeId][InstanceID] = BG; };
        void RemoveBattleGround(uint32 instanceID, BattleGroundTypeId bgTypeId) { m_BattleGrounds[bgTypeId].erase(instanceID); }

        void CreateInitialBattleGrounds();
        void DeleteAllBattleGrounds();

        void SendToBattleGround(Player *pl, uint32 InstanceID, BattleGroundTypeId bgTypeId);
        virtual void HandleCrossfactionSendToBattle(Player* player, BattleGround* bg, uint32 InstanceID, BattleGroundTypeId bgTypeId);

        /* Battleground queues */
        //these queues are instantiated when creating BattlegroundMrg
        BattleGroundQueue m_BattleGroundQueues[MAX_BATTLEGROUND_QUEUE_TYPES]; // public, because we need to access them in BG handler code

        BGFreeSlotQueueType BGFreeSlotQueue[MAX_BATTLEGROUND_TYPE_ID];

        uint32 GetMaxRatingDifference() const;
        uint32 GetRatingDiscardTimer()  const;
        uint32 GetPrematureFinishTime() const;
        bool IsPrematureFinishTimerEnabled() {return sWorld.getConfig(CONFIG_BATTLEGROUND_TIMER_INFO);}

        void InitAutomaticArenaPointDistribution();
        void DistributeArenaPoints();
        void ToggleArenaTesting();
        void ToggleTesting();

        void LoadBattleMastersEntry();
        BattleGroundTypeId GetBattleMasterBG(uint32 entry) const
        {
            BattleMastersMap::const_iterator itr = mBattleMastersMap.find(entry);
            if (itr != mBattleMastersMap.end())
                return itr->second;
            return BATTLEGROUND_TYPE_NONE;
        }

        bool isArenaTesting() const { return m_ArenaTesting; }
        bool isTesting() const { return m_Testing; }

        static bool IsArenaType(BattleGroundTypeId bgTypeId);
        static bool IsBattleGroundType(BattleGroundTypeId bgTypeId) { return !BattleGroundMgr::IsArenaType(bgTypeId); }
        static BattleGroundQueueTypeId BGQueueTypeId(BattleGroundTypeId bgTypeId, uint8 arenaType);
        static BattleGroundTypeId BGTemplateId(BattleGroundQueueTypeId bgQueueTypeId);
        static uint8 BGArenaType(BattleGroundQueueTypeId bgQueueTypeId);

        static bool IsBGWeekend(BattleGroundTypeId bgTypeId);

    private:
        BattleMastersMap    mBattleMastersMap;
        std::vector<uint32> m_QueueUpdateScheduler;

        /* Battlegrounds */
        BattleGroundSet m_BattleGrounds[MAX_BATTLEGROUND_TYPE_ID];
        uint32 m_NextRatingDiscardUpdate;
        time_t m_NextAutoDistributionTime;
        uint32 m_AutoDistributionTimeChecker;
        bool   m_ArenaTesting;
        bool   m_Testing;
        bool   m_ApAnnounce;
};

#define sBattleGroundMgr (*ACE_Singleton<BattleGroundMgr, ACE_Null_Mutex>::instance())
#endif
