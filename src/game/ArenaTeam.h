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

#ifndef TRINITYCORE_ARENATEAM_H
#define TRINITYCORE_ARENATEAM_H

enum ArenaTeamCommandTypes
{
    ERR_ARENA_TEAM_CREATE_S                 = 0x00,
    ERR_ARENA_TEAM_INVITE_SS                = 0x01,
    //ERR_ARENA_TEAM_QUIT_S                   = 0x02,
    ERR_ARENA_TEAM_QUIT_S                   = 0x03,
    ERR_ARENA_TEAM_FOUNDER_S                = 0x0C          // need check, probably wrong...
};

enum ArenaTeamCommandErrors
{
    //ARENA_TEAM_PLAYER_NO_MORE_IN_ARENA_TEAM = 0x00,
    ERR_ARENA_TEAM_INTERNAL                 = 0x01,
    ERR_ALREADY_IN_ARENA_TEAM               = 0x02,
    ERR_ALREADY_IN_ARENA_TEAM_S             = 0x03,
    ERR_INVITED_TO_ARENA_TEAM               = 0x04,
    ERR_ALREADY_INVITED_TO_ARENA_TEAM_S     = 0x05,
    ERR_ARENA_TEAM_NAME_INVALID             = 0x06,
    ERR_ARENA_TEAM_NAME_EXISTS_S            = 0x07,
    ERR_ARENA_TEAM_LEADER_LEAVE_S           = 0x08,
    ERR_ARENA_TEAM_PERMISSIONS              = 0x08,
    ERR_ARENA_TEAM_PLAYER_NOT_IN_TEAM       = 0x09,
    ERR_ARENA_TEAM_PLAYER_NOT_IN_TEAM_SS    = 0x0A,
    ERR_ARENA_TEAM_PLAYER_NOT_FOUND_S       = 0x0B,
    ERR_ARENA_TEAM_NOT_ALLIED               = 0x0C,
    ERR_ARENA_TEAM_PLAYER_TO_LOW            = 0x15,
    ERR_ARENA_TEAM_FULL                     = 0x16
};

enum ArenaTeamEvents
{
    ERR_ARENA_TEAM_JOIN_SS                  = 3,            // player name + arena team name
    ERR_ARENA_TEAM_LEAVE_SS                 = 4,            // player name + arena team name
    ERR_ARENA_TEAM_REMOVE_SSS               = 5,            // player name + arena team name + captain name
    ERR_ARENA_TEAM_LEADER_IS_SS             = 6,            // player name + arena team name
    ERR_ARENA_TEAM_LEADER_CHANGED_SSS       = 7,            // old captain + new captain + arena team name
    ERR_ARENA_TEAM_DISBANDED_S              = 8             // captain name + arena team name
};

/*
need info how to send these ones:
ERR_ARENA_TEAM_YOU_JOIN_S - client show it automatically when accept invite
ERR_ARENA_TEAM_TARGET_TOO_LOW_S
ERR_ARENA_TEAM_TOO_MANY_MEMBERS_S
ERR_ARENA_TEAM_LEVEL_TOO_LOW_I
*/

enum ArenaTeamStatTypes
{
    STAT_TYPE_RATING        = 0,
    STAT_TYPE_GAMES_WEEK    = 1,
    STAT_TYPE_WINS_WEEK     = 2,
    STAT_TYPE_GAMES_SEASON  = 3,
    STAT_TYPE_WINS_SEASON   = 4,
    STAT_TYPE_RANK          = 5
};

enum ArenaTeamTypes
{
    ARENA_TEAM_2v2      = 2,
    ARENA_TEAM_3v3      = 3,
    ARENA_TEAM_5v5      = 5
};

struct ArenaTeamMember
{
    uint64 guid;
    std::string name;
    uint8 Class;
    uint32 games_week;
    uint32 wins_week;
    uint32 games_season;
    uint32 wins_season;
    uint32 personal_rating;
    uint32 matchmaker_rating;

    void ModifyPersonalRating(Player* plr, int32 mod, uint32 slot)
    {
        if (personal_rating + mod < 0)
            personal_rating = 0;
        else
            personal_rating += mod;

        if (plr)
            plr->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (slot*6) + 5, personal_rating);
            plr->SaveToDB();
    }

    void ModifyMatchmakerRating(int32 mod, int type)
    {
        static SqlStatementID updateH2Rating;
        static SqlStatementID updateH3Rating;
        static SqlStatementID updateH5Rating;

        if (int32(matchmaker_rating) + mod <  0)
            matchmaker_rating = 0;
        else
            matchmaker_rating += mod;

        switch (type)
        {
            case 2:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(updateH2Rating, "UPDATE hidden_rating SET rating2 = ? WHERE guid = ?");
                stmt.addUInt32(matchmaker_rating);
                stmt.addUInt32(guid);
                stmt.Execute();
                break;
            }
            case 3:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(updateH3Rating, "UPDATE hidden_rating SET rating3 = ? WHERE guid = ?");
                stmt.addUInt32(matchmaker_rating);
                stmt.addUInt32(guid);
                stmt.Execute();
                break;
            }
            case 5:
            {
                SqlStatement stmt = RealmDataDatabase.CreateStatement(updateH5Rating, "UPDATE hidden_rating SET rating5 = ? WHERE guid = ?");
                stmt.addUInt32(matchmaker_rating);
                stmt.addUInt32(guid);
                stmt.Execute();
                break;
            }
            default:
                return;
        }
    }
};

struct ArenaTeamStats
{
    uint32 rating;
    uint32 games_week;
    uint32 wins_week;
    uint32 games_season;
    uint32 wins_season;
    uint32 rank;
};

#define MAX_ARENA_SLOT 3                                    // 0..2 slots

class ArenaTeam
{
    public:
        ArenaTeam();
        ~ArenaTeam();

        bool Create(uint64 CaptainGuid, uint32 type, std::string ArenaTeamName);
        void Disband(WorldSession *session);

        typedef std::list<ArenaTeamMember> MemberList;

        uint32 GetId() const              { return Id; }
        uint32 GetType() const            { return Type; }
        uint8  GetSlot() const            { return GetSlotByType(GetType()); }
        static uint8 GetSlotByType(uint32 type);
        const uint64& GetCaptain() const  { return CaptainGuid; }
        std::string GetName() const       { return Name; }
        const ArenaTeamStats& GetStats() const { return stats; }
        void SetStats(uint32 stat_type, uint32 value);
        uint32 GetRating() const          { return stats.rating; }

        uint32 GetEmblemStyle() const     { return EmblemStyle; }
        uint32 GetEmblemColor() const     { return EmblemColor; }
        uint32 GetBorderStyle() const     { return BorderStyle; }
        uint32 GetBorderColor() const     { return BorderColor; }
        uint32 GetBackgroundColor() const { return BackgroundColor; }

        void SetCaptain(const uint64& guid);
        bool AddMember(const uint64& PlayerGuid);

        // Shouldn't be const uint64& ed, because than can reference guid from members on Disband
        // and this method removes given record from list. So invalid reference can happen.
        void DelMember(uint64 guid);

        void SetEmblem(uint32 backgroundColor, uint32 emblemStyle, uint32 emblemColor, uint32 borderStyle, uint32 borderColor);

        size_t GetMembersSize() const       { return members.size(); }
        bool   Empty() const                { return members.empty(); }
        MemberList::iterator membersBegin() { return members.begin(); }
        MemberList::iterator membersEnd()   { return members.end(); }
        bool HaveMember(const uint64& guid) const;

        ArenaTeamMember* GetMember(const uint64& guid)
        {
            for (MemberList::iterator itr = members.begin(); itr != members.end(); ++itr)
                if (itr->guid == guid)
                    return &(*itr);

            return NULL;
        }

        ArenaTeamMember* GetMember(const std::string& name)
        {
            for (MemberList::iterator itr = members.begin(); itr != members.end(); ++itr)
                if (itr->name == name)
                    return &(*itr);

            return NULL;
        }

        uint32 GetMemberMMR(const uint64 & guid)
        {
            for (MemberList::iterator itr = members.begin(); itr != members.end(); ++itr)
                if (itr->guid == guid)
                    return itr->matchmaker_rating;

            return 0;
        }

        bool IsFighting() const;

        bool LoadArenaTeamFromDB(uint32 ArenaTeamId);
        void LoadMembersFromDB(uint32 ArenaTeamId);
        void LoadStatsFromDB(uint32 ArenaTeamId);

        void SaveToDB();

        void BroadcastPacket(WorldPacket *packet);

        void Roster(WorldSession *session);
        void Query(WorldSession *session);
        void Stats(WorldSession *session);
        void InspectStats(WorldSession *session, uint64 guid);

        uint32 GetPoints(uint32 MemberRating);
        float GetChanceAgainst(uint32 own_rating, uint32 enemy_rating);
        int32 WonAgainst(uint32 againstRating);
        void MemberWon(Player * plr, uint32 againstRating, uint32 againstHiddenRating);
        int32 LostAgainst(uint32 againstRating);
        void MemberLost(Player * plr, uint32 againstRating, uint32 againstHiddenRating);

        void UpdateArenaPointsHelper(std::map<uint32, uint32> & PlayerPoints);

        void NotifyStatsChanged();

        void FinishWeek();

        uint32 GetAverageMMR(Group *group) const;

    protected:

        uint32 Id;
        uint32 Type;
        std::string Name;
        uint64 CaptainGuid;

        uint32 BackgroundColor; // ARGB format
        uint32 EmblemStyle;     // icon id
        uint32 EmblemColor;     // ARGB format
        uint32 BorderStyle;     // border image id
        uint32 BorderColor;     // ARGB format

        MemberList members;
        ArenaTeamStats stats;
};
#endif

