/*
 * Copyright (C) 2005-2008 MaNGOS <http://getmangos.com/>
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

#include "WorldPacket.h"
#include "ObjectMgr.h"
#include "ArenaTeam.h"
#include "World.h"

ArenaTeam::ArenaTeam()
{
    Id                  = 0;
    Type                = 0;
    Name                = "";
    CaptainGuid         = 0;
    BackgroundColor     = 0;                                // background
    EmblemStyle         = 0;                                // icon
    EmblemColor         = 0;                                // icon color
    BorderStyle         = 0;                                // border
    BorderColor         = 0;                                // border color
    stats.games_week    = 0;
    stats.games_season  = 0;
    stats.rank          = 0;
    stats.rating        = 1500;
    stats.wins_week     = 0;
    stats.wins_season   = 0;
}

ArenaTeam::~ArenaTeam()
{
}

bool ArenaTeam::Create(uint64 captainGuid, uint32 type, std::string ArenaTeamName)
{
    if (!sObjectMgr.GetPlayer(captainGuid))                      // player not exist
        return false;
    if (sObjectMgr.GetArenaTeamByName(ArenaTeamName))            // arena team with this name already exist
        return false;

    sLog.outDebug("GUILD: creating arena team %s to leader: %u", ArenaTeamName.c_str(), GUID_LOPART(captainGuid));

    CaptainGuid = captainGuid;
    Name = ArenaTeamName;
    Type = type;

    Id = sObjectMgr.GenerateArenaTeamId();

    // ArenaTeamName already assigned to ArenaTeam::name, use it to encode string for DB
    RealmDataDatabase.escape_string(ArenaTeamName);

    RealmDataDatabase.BeginTransaction();
    // CharacterDatabase.PExecute("DELETE FROM arena_team WHERE arenateamid='%u'", Id); - MAX(arenateam)+1 not exist
    RealmDataDatabase.PExecute("DELETE FROM arena_team_member WHERE arenateamid='%u'", Id);
    RealmDataDatabase.PExecute("INSERT INTO arena_team (arenateamid,name,captainguid,type,BackgroundColor,EmblemStyle,EmblemColor,BorderStyle,BorderColor) "
        "VALUES('%u','%s','%u','%u','%u','%u','%u','%u','%u')",
        Id, ArenaTeamName.c_str(), GUID_LOPART(CaptainGuid), Type, BackgroundColor, EmblemStyle, EmblemColor, BorderStyle, BorderColor);
    RealmDataDatabase.PExecute("INSERT INTO arena_team_stats (arenateamid, rating, games, wins, played, wins2, rank) VALUES "
        "('%u', '%u', '%u', '%u', '%u', '%u', '%u')", Id, stats.rating, stats.games_week, stats.wins_week, stats.games_season, stats.wins_season, stats.rank);

    RealmDataDatabase.CommitTransaction();

    AddMember(CaptainGuid);
    sLog.outLog(LOG_ARENA, "New ArenaTeam created [Name: %s] [Id: %u] [Type: %u] [Captain GUID: %u]", ArenaTeamName.c_str(), GetId(), GetType(), GetCaptain());
    return true;
}

bool ArenaTeam::AddMember(const uint64& PlayerGuid)
{
    std::string plName;
    uint8 plClass;

    // arena team is full (can't have more than type * 2 players!)
    if (GetMembersSize() >= GetType() * 2)
        return false;

    Player *pl = sObjectMgr.GetPlayer(PlayerGuid);
    if (pl)
    {
        if (pl->GetArenaTeamId(GetSlot()))
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Arena::AddMember() : player already in this sized team");
            return false;
        }

        plClass = (uint8)pl->getClass();
        plName = pl->GetName();
    }
    else
    {
        //                                                     0     1
        QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT name, class FROM characters WHERE guid='%u'", GUID_LOPART(PlayerGuid));
        if (!result)
            return false;

        plName = (*result)[0].GetCppString();
        plClass = (*result)[1].GetUInt8();

        // check if player already in arenateam of that size
        if (Player::GetArenaTeamIdFromDB(PlayerGuid, GetType()) != 0)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Arena::AddMember() : player already in this sized team");
            return false;
        }
    }

    // remove all player signs from another petitions
    // this will be prevent attempt joining player to many arenateams and corrupt arena team data integrity
    Player::RemovePetitionsAndSigns(PlayerGuid, GetType());

    ArenaTeamMember newmember;
    newmember.name              = plName;
    newmember.guid              = PlayerGuid;
    newmember.Class             = plClass;
    newmember.games_season      = 0;
    newmember.games_week        = 0;
    newmember.wins_season       = 0;
    newmember.wins_week         = 0;
    newmember.personal_rating   = 1500;

    {
        QueryResultAutoPtr result;
        switch (GetType())
        {
            case 2:
                result = RealmDataDatabase.PQuery("SELECT rating2 FROM hidden_rating WHERE guid='%u'", GUID_LOPART(newmember.guid));
                break;
            case 3:
                result = RealmDataDatabase.PQuery("SELECT rating3 FROM hidden_rating WHERE guid='%u'", GUID_LOPART(newmember.guid));
                break;
            case 5:
                result = RealmDataDatabase.PQuery("SELECT rating5 FROM hidden_rating WHERE guid='%u'", GUID_LOPART(newmember.guid));
                break;
            default:
                break;
        }

        if (!result)
        {
            newmember.matchmaker_rating = 1500;
            RealmDataDatabase.PExecute("INSERT INTO hidden_rating(guid) VALUES ('%u')", GUID_LOPART(newmember.guid));
        }
        else
        {
            Field * fields = result->Fetch();
            newmember.matchmaker_rating = fields[0].GetUInt32();
        }
    }

    members.push_back(newmember);

    RealmDataDatabase.PExecute("INSERT INTO arena_team_member (arenateamid, guid, personal_rating) VALUES ('%u', '%u', '%u')", Id, GUID_LOPART(newmember.guid), newmember.personal_rating);

    if (pl)
    {
        pl->SetInArenaTeam(Id, GetSlot());
        pl->SetArenaTeamIdInvited(0);
        pl->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (GetSlot()*6) + 5, newmember.personal_rating);

        // hide promote/remove buttons
        if (CaptainGuid != PlayerGuid)
            pl->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (GetSlot() * 6) + 1, 1);
        sLog.outLog(LOG_ARENA, "Player: %s [GUID: %u] joined arena team type: %u [Id: %u].", pl->GetName(), pl->GetGUIDLow(), GetType(), GetId());
    }
    return true;
}

bool ArenaTeam::LoadArenaTeamFromDB(uint32 ArenaTeamId)
{
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT arenateamid,name,captainguid,type,BackgroundColor,EmblemStyle,EmblemColor,BorderStyle,BorderColor FROM arena_team WHERE arenateamid = '%u'", ArenaTeamId);

    if (!result)
        return false;

    Field *fields = result->Fetch();

    Id = fields[0].GetUInt32();
    Name = fields[1].GetCppString();
    CaptainGuid  = MAKE_NEW_GUID(fields[2].GetUInt32(), 0, HIGHGUID_PLAYER);
    Type = fields[3].GetUInt32();
    BackgroundColor = fields[4].GetUInt32();
    EmblemStyle = fields[5].GetUInt32();
    EmblemColor = fields[6].GetUInt32();
    BorderStyle = fields[7].GetUInt32();
    BorderColor = fields[8].GetUInt32();

    // only load here, so additional checks can be made
    LoadStatsFromDB(ArenaTeamId);
    LoadMembersFromDB(ArenaTeamId);

    if (Empty())
    {
        // arena team is empty, delete from db
        RealmDataDatabase.BeginTransaction();
        RealmDataDatabase.PExecute("DELETE FROM arena_team WHERE arenateamid = '%u'", ArenaTeamId);
        RealmDataDatabase.PExecute("DELETE FROM arena_team_member WHERE arenateamid = '%u'", ArenaTeamId);
        RealmDataDatabase.PExecute("DELETE FROM arena_team_stats WHERE arenateamid = '%u'", ArenaTeamId);
        RealmDataDatabase.CommitTransaction();
        return false;
    }

    return true;
}

void ArenaTeam::LoadStatsFromDB(uint32 ArenaTeamId)
{
    //                                                     0      1     2    3      4     5
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT rating,games,wins,played,wins2,rank FROM arena_team_stats WHERE arenateamid = '%u'", ArenaTeamId);

    if (!result)
        return;

    Field *fields = result->Fetch();

    stats.rating        = fields[0].GetUInt32();
    stats.games_week    = fields[1].GetUInt32();
    stats.wins_week     = fields[2].GetUInt32();
    stats.games_season  = fields[3].GetUInt32();
    stats.wins_season   = fields[4].GetUInt32();
    stats.rank          = fields[5].GetUInt32();
}

void ArenaTeam::LoadMembersFromDB(uint32 ArenaTeamId)
{
    //                                                                 0           1          2            3              4             5           6      7       8       9         10
    QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT member.guid, played_week, wons_week, played_season, wons_season, personal_rating, chars.name, chars.class, hidden.rating2, hidden.rating3, hidden.rating5 "
                                                   "FROM arena_team_member member "
                                                   "INNER JOIN characters chars on member.guid = chars.guid "
                                                   "JOIN hidden_rating hidden ON member.guid = hidden.guid "
                                                   "WHERE member.arenateamid = '%u'", ArenaTeamId);
    if (!result)
        return;

    do
    {
        Field *fields = result->Fetch();
        ArenaTeamMember newmember;
        newmember.guid          = MAKE_NEW_GUID(fields[0].GetUInt32(), 0, HIGHGUID_PLAYER);
        newmember.games_week    = fields[1].GetUInt32();
        newmember.wins_week     = fields[2].GetUInt32();
        newmember.games_season  = fields[3].GetUInt32();
        newmember.wins_season   = fields[4].GetUInt32();
        newmember.personal_rating = fields[5].GetUInt32();
        newmember.name          = fields[6].GetCppString();
        newmember.Class         = fields[7].GetUInt8();


        switch (GetType())
        {
            case 2:
                newmember.matchmaker_rating = fields[8].GetUInt32();
                break;
            case 3:
                newmember.matchmaker_rating = fields[9].GetUInt32();
                break;
            case 5:
                newmember.matchmaker_rating = fields[10].GetUInt32();
                break;
            default:
                newmember.matchmaker_rating = 1500;
                break;
        }

        members.push_back(newmember);
    }
    while (result->NextRow());
}

void ArenaTeam::SetCaptain(const uint64& guid)
{
    // disable remove/promote buttons
    Player *oldcaptain = sObjectMgr.GetPlayer(GetCaptain());
    if (oldcaptain)
        oldcaptain->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + 1 + (GetSlot() * 6), 1);

    // set new captain
    CaptainGuid = guid;

    // update database
    RealmDataDatabase.PExecute("UPDATE arena_team SET captainguid = '%u' WHERE arenateamid = '%u'", GUID_LOPART(guid), Id);

    // enable remove/promote buttons
    Player *newcaptain = sObjectMgr.GetPlayer(guid);
    if (newcaptain)
    {
        newcaptain->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + 1 + (GetSlot() * 6), 0);
        sLog.outLog(LOG_ARENA, "Player: %s [GUID: %u] promoted player: %s [GUID: %u] to leader of arena team [Id: %u] [Type: %u].", oldcaptain->GetName(), oldcaptain->GetGUIDLow(), newcaptain->GetName(), newcaptain->GetGUID(), GetId(), GetType());
    }
}

void ArenaTeam::DelMember(uint64 guid)
{
    for (MemberList::iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        if (itr->guid == guid)
        {
            members.erase(itr);
            break;
        }
    }

    Player *player = sObjectMgr.GetPlayer(guid);

    if (player)
    {
        player->SetInArenaTeam(0, GetSlot());
        player->GetSession()->SendArenaTeamCommandResult(ERR_ARENA_TEAM_QUIT_S, GetName(), "", 0);
        // delete all info regarding this team
        for (int i = 0; i < 6; ++i)
        {
            player->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + (GetSlot() * 6) + i, 0);
        }
        sLog.outLog(LOG_ARENA, "Player: %s [GUID: %u] left arena team type: %u [Id: %u].", player->GetName(), player->GetGUIDLow(), GetType(), GetId());
    }
    RealmDataDatabase.PExecute("DELETE FROM arena_team_member WHERE arenateamid = '%u' AND guid = '%u'", GetId(), GUID_LOPART(guid));
}

void ArenaTeam::Disband(WorldSession *session)
{
    // event
    WorldPacket data;
    session->BuildArenaTeamEventPacket(&data, ERR_ARENA_TEAM_DISBANDED_S, 2, session->GetPlayerName(), GetName(), "");
    BroadcastPacket(&data);

    while (!members.empty())
    {
        // Removing from members is done in DelMember.
        DelMember(members.front().guid);
    }

    if (Player *player = session->GetPlayer())
        sLog.outLog(LOG_ARENA, "Player: %s [GUID: %u] disbanded arena team type: %u [Id: %u].", player->GetName(), player->GetGUIDLow(), GetType(), GetId());

    RealmDataDatabase.BeginTransaction();
    RealmDataDatabase.PExecute("DELETE FROM arena_team WHERE arenateamid = '%u'", Id);
    RealmDataDatabase.PExecute("DELETE FROM arena_team_member WHERE arenateamid = '%u'", Id); //< this should be alredy done by calling DelMember(memberGuids[j]); for each member
    RealmDataDatabase.PExecute("DELETE FROM arena_team_stats WHERE arenateamid = '%u'", Id);
    RealmDataDatabase.CommitTransaction();
    sObjectMgr.RemoveArenaTeam(Id);
}

void ArenaTeam::Roster(WorldSession *session)
{
    Player *pl = NULL;

    WorldPacket data(SMSG_ARENA_TEAM_ROSTER, 100);
    data << uint32(GetId());                                // arena team id
    data << uint32(GetMembersSize());                       // members count
    data << uint32(GetType());                              // arena team type?

    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        pl = sObjectMgr.GetPlayer(itr->guid);

        data << uint64(itr->guid);                          // guid
        data << uint8((pl ? 1 : 0));                        // online flag
        data << itr->name;                                  // member name
        data << uint32((itr->guid == GetCaptain() ? 0 : 1));// captain flag 0 captain 1 member
        data << uint8((pl ? pl->getLevel() : 0));           // unknown, level?
        data << uint8(itr->Class);                          // class
        data << uint32(itr->games_week);                    // played this week
        data << uint32(itr->wins_week);                     // wins this week
        data << uint32(itr->games_season);                  // played this season
        data << uint32(itr->wins_season);                   // wins this season
        data << uint32(itr->personal_rating);               // personal rating
    }

    session->SendPacket(&data);
    sLog.outDebug("WORLD: Sent SMSG_ARENA_TEAM_ROSTER");
}

void ArenaTeam::Query(WorldSession *session)
{
    WorldPacket data(SMSG_ARENA_TEAM_QUERY_RESPONSE, 4*7+GetName().size()+1);
    data << uint32(GetId());                                // team id
    data << GetName();                                      // team name
    data << uint32(GetType());                              // arena team type (2=2x2, 3=3x3 or 5=5x5)
    data << uint32(BackgroundColor);                        // background color
    data << uint32(EmblemStyle);                            // emblem style
    data << uint32(EmblemColor);                            // emblem color
    data << uint32(BorderStyle);                            // border style
    data << uint32(BorderColor);                            // border color
    session->SendPacket(&data);
    sLog.outDebug("WORLD: Sent SMSG_ARENA_TEAM_QUERY_RESPONSE");
}

void ArenaTeam::Stats(WorldSession *session)
{
    WorldPacket data(SMSG_ARENA_TEAM_STATS, 4*7);
    data << uint32(GetId());                                // arena team id
    data << uint32(stats.rating);                           // rating
    data << uint32(stats.games_week);                       // games this week
    data << uint32(stats.wins_week);                        // wins this week
    data << uint32(stats.games_season);                     // played this season
    data << uint32(stats.wins_season);                      // wins this season
    data << uint32(stats.rank);                             // rank
    session->SendPacket(&data);
}

void ArenaTeam::NotifyStatsChanged()
{
    // this is called after a rated match ended
    // updates arena team stats for every member of the team (not only the ones who participated!)
    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        Player * plr = sObjectMgr.GetPlayer(itr->guid);
        if (plr)
            Stats(plr->GetSession());
    }
}

void ArenaTeam::InspectStats(WorldSession *session, uint64 guid)
{
    ArenaTeamMember* member = GetMember(guid);
    if (!member)
        return;

    WorldPacket data(MSG_INSPECT_ARENA_TEAMS, 8+1+4*6);
    data << uint64(guid);                                   // player guid
    data << uint8(GetSlot());                               // slot (0...2)
    data << uint32(GetId());                                // arena team id
    data << uint32(stats.rating);                           // rating
    data << uint32(stats.games_season);                     // season played
    data << uint32(stats.wins_season);                      // season wins
    data << uint32(member->games_season);                   // played (count of all games, that the inspected member participated...)
    data << uint32(member->personal_rating);                // personal rating
    session->SendPacket(&data);
}

void ArenaTeam::SetEmblem(uint32 backgroundColor, uint32 emblemStyle, uint32 emblemColor, uint32 borderStyle, uint32 borderColor)
{
    BackgroundColor = backgroundColor;
    EmblemStyle = emblemStyle;
    EmblemColor = emblemColor;
    BorderStyle = borderStyle;
    BorderColor = borderColor;

    RealmDataDatabase.PExecute("UPDATE arena_team SET BackgroundColor='%u', EmblemStyle='%u', EmblemColor='%u', BorderStyle='%u', BorderColor='%u' WHERE arenateamid='%u'", BackgroundColor, EmblemStyle, EmblemColor, BorderStyle, BorderColor, Id);
}

void ArenaTeam::SetStats(uint32 stat_type, uint32 value)
{
    switch (stat_type)
    {
        case STAT_TYPE_RATING:
            stats.rating = value;
            RealmDataDatabase.PExecute("UPDATE arena_team_stats SET rating = '%u' WHERE arenateamid = '%u'", value, GetId());
            break;
        case STAT_TYPE_GAMES_WEEK:
            stats.games_week = value;
            RealmDataDatabase.PExecute("UPDATE arena_team_stats SET games = '%u' WHERE arenateamid = '%u'", value, GetId());
            break;
        case STAT_TYPE_WINS_WEEK:
            stats.wins_week = value;
            RealmDataDatabase.PExecute("UPDATE arena_team_stats SET wins = '%u' WHERE arenateamid = '%u'", value, GetId());
            break;
        case STAT_TYPE_GAMES_SEASON:
            stats.games_season = value;
            RealmDataDatabase.PExecute("UPDATE arena_team_stats SET played = '%u' WHERE arenateamid = '%u'", value, GetId());
            break;
        case STAT_TYPE_WINS_SEASON:
            stats.wins_season = value;
            RealmDataDatabase.PExecute("UPDATE arena_team_stats SET wins2 = '%u' WHERE arenateamid = '%u'", value, GetId());
            break;
        case STAT_TYPE_RANK:
            stats.rank = value;
            RealmDataDatabase.PExecute("UPDATE arena_team_stats SET rank = '%u' WHERE arenateamid = '%u'", value, GetId());
            break;
        default:
            sLog.outDebug("unknown stat type in ArenaTeam::SetStats() %u", stat_type);
            break;
    }
}

void ArenaTeam::BroadcastPacket(WorldPacket *packet)
{
    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        Player *player = sObjectMgr.GetPlayer(itr->guid);
        if (player)
            player->SendPacketToSelf(packet);
    }
}

uint8 ArenaTeam::GetSlotByType(uint32 type)
{
    switch (type)
    {
        case ARENA_TEAM_2v2: return 0;
        case ARENA_TEAM_3v3: return 1;
        case ARENA_TEAM_5v5: return 2;
        default:
            break;
    }
    sLog.outLog(LOG_DEFAULT, "FATAL ERROR: Unknown arena team type %u for some arena team", type);
    return 0xFF;
}

bool ArenaTeam::HaveMember(const uint64& guid) const
{
    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
        if (itr->guid == guid)
            return true;

    return false;
}

uint32 ArenaTeam::GetPoints(uint32 MemberRating)
{
    // returns how many points would be awarded with this team type with this rating
    float points;

    uint32 rating = MemberRating + 150 < stats.rating ? MemberRating : stats.rating;

    if (rating<=1500)
        points = (float)rating * 0.22f + 14.0f;
    else
        points = 1511.26f / (1.0f + 1639.28f * exp(-0.00412f * (float)rating));

    // type penalties for <5v5 teams
    if (Type == ARENA_TEAM_2v2)
        points *= 0.76f;
    else if (Type == ARENA_TEAM_3v3)
        points *= 0.88f;

    return (uint32) points;
}

float ArenaTeam::GetChanceAgainst(uint32 own_rating, uint32 enemy_rating)
{
    // returns the chance to win against a team with the given rating, used in the rating adjustment calculation
    // ELO system
    return 1.0f/(1.0f+exp(log(10.0f)*(float)((float)enemy_rating - (float)own_rating)/400.0f));
}

int32 ArenaTeam::WonAgainst(uint32 againstRating)
{
    // called when the team has won
    //'chance' calculation - to beat the opponent
    float chance = GetChanceAgainst(stats.rating, againstRating);
    // calculate the rating modification (ELO system with k=32)
    int32 mod = (int32)floor(32.0f * (1.0f - chance));
    // modify the team stats accordingly
    stats.rating += mod;
    stats.games_week += 1;
    stats.wins_week += 1;
    stats.games_season += 1;
    stats.wins_season += 1;
    //update team's rank
    stats.rank = 1;
    ObjectMgr::ArenaTeamMap::iterator i = sObjectMgr.GetArenaTeamMapBegin();
    for (; i != sObjectMgr.GetArenaTeamMapEnd(); ++i)
    {
        if (i->second->GetType() == this->Type && i->second->GetStats().rating > stats.rating)
            ++stats.rank;
    }

    // return the rating change, used to display it on the results screen
    return mod;
}

int32 ArenaTeam::LostAgainst(uint32 againstRating)
{
    // called when the team has lost
    //'chance' calculation - to loose to the opponent
    float chance = GetChanceAgainst(stats.rating, againstRating);
    // calculate the rating modification (ELO system with k=32)
    int32 mod = (int32)ceil(32.0f * (0.0f - chance));
    // modify the team stats accordingly
    stats.rating += mod;
    stats.games_week += 1;
    stats.games_season += 1;
    //update team's rank

    stats.rank = 1;
    ObjectMgr::ArenaTeamMap::iterator i = sObjectMgr.GetArenaTeamMapBegin();
    for (; i != sObjectMgr.GetArenaTeamMapEnd(); ++i)
    {
        if (i->second->GetType() == this->Type && i->second->GetStats().rating > stats.rating)
            ++stats.rank;
    }

    // return the rating change, used to display it on the results screen
    return mod;
}

void ArenaTeam::MemberLost(Player * plr, uint32 againstRating, uint32 againstHiddenRating)
{
    // called for each participant of a match after losing
    for (MemberList::iterator itr = members.begin(); itr !=  members.end(); ++itr)
    {
        if (itr->guid == plr->GetGUID())
        {
            // update personal rating
            float chance = GetChanceAgainst(itr->personal_rating, againstRating);
            int32 mod = (int32)ceil(32.0f * (0.0f - chance));

            // NEED to check hiddenRatingbeforePenalty
            if (sWorld.getConfig(CONFIG_ENABLE_HIDDEN_RATING) && sWorld.getConfig(CONFIG_ENABLE_HIDDEN_RATING_LOWER_LOSS))
            {
                if (againstRating + 150 < againstHiddenRating)
                    mod /= 2;
            }

            itr->ModifyPersonalRating(plr, mod, GetSlot());

            // update matchmaker rating
            chance = GetChanceAgainst(itr->matchmaker_rating, againstHiddenRating);
            mod = (int32)ceil(32.0f * (0.0f - chance));
            itr->ModifyMatchmakerRating(mod, GetType());

            // update personal played stats
            itr->games_week +=1;
            itr->games_season +=1;

            // update the unit fields
            plr->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + 6 * GetSlot() + 2, itr->games_week);
            plr->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + 6 * GetSlot() + 3, itr->games_season);
            return;
        }
    }
}

void ArenaTeam::MemberWon(Player * plr, uint32 againstRating, uint32 againstHiddenRating)
{
    // called for each participant after winning a match
    for (MemberList::iterator itr = members.begin(); itr !=  members.end(); ++itr)
    {
        if (itr->guid == plr->GetGUID())
        {
            // update personal rating
            float chance = GetChanceAgainst(itr->personal_rating, againstRating);
            int32 mod = (int32)floor(32.0f * (1.0f - chance));
            itr->ModifyPersonalRating(plr, mod, GetSlot());

            // update matchmaker rating
            chance = GetChanceAgainst(itr->matchmaker_rating, againstHiddenRating);
            mod = (int32)ceil(32.0f * (1.0f - chance));
            itr->ModifyMatchmakerRating(mod, GetType());

            // update personal stats
            itr->games_week +=1;
            itr->games_season +=1;
            itr->wins_season += 1;
            itr->wins_week += 1;
            // update unit fields
            plr->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + 6 * GetSlot() + 2, itr->games_week);
            plr->SetUInt32Value(PLAYER_FIELD_ARENA_TEAM_INFO_1_1 + 6 * GetSlot() + 3, itr->games_season);
            return;
        }
    }
}

void ArenaTeam::UpdateArenaPointsHelper(std::map<uint32, uint32>& PlayerPoints)
{
    // called after a match has ended and the stats are already modified
    // helper function for arena point distribution (this way, when distributing, no actual calculation is required, just a few comparisons)
    // 10 played games per week is a minimum
    if (stats.games_week < 10)
        return;
    // to get points, a player has to participate in at least 30% of the matches
    uint32 min_plays = (uint32) ceil(stats.games_week * 0.3);
    for (MemberList::iterator itr = members.begin(); itr !=  members.end(); ++itr)
    {
        // the player participated in enough games, update his points
        uint32 points_to_add = 0;
        if (itr->games_week >= min_plays)
            points_to_add = GetPoints(itr->personal_rating);
        // OBSOLETE : CharacterDatabase.PExecute("UPDATE arena_team_member SET points_to_add = '%u' WHERE arenateamid = '%u' AND guid = '%u'", points_to_add, Id, itr->guid);

        std::map<uint32, uint32>::iterator plr_itr = PlayerPoints.find(GUID_LOPART(itr->guid));
        if (plr_itr != PlayerPoints.end())
        {
            //check if there is already more points
            if (plr_itr->second < points_to_add)
                PlayerPoints[GUID_LOPART(itr->guid)] = points_to_add;
        }
        else
            PlayerPoints[GUID_LOPART(itr->guid)] = points_to_add;
    }
}

void ArenaTeam::SaveToDB()
{
    static SqlStatementID updateATeam;
    static SqlStatementID updateAMembers;
    static SqlStatementID updateH2Rating;
    static SqlStatementID updateH3Rating;
    static SqlStatementID updateH5Rating;

    RealmDataDatabase.BeginTransaction();

    SqlStatement stmt = RealmDataDatabase.CreateStatement(updateATeam, "UPDATE arena_team_stats SET rating = ?, games = ?, played = ?, rank = ?, wins = ?, wins2 = ? WHERE arenateamid = ?");
    stmt.addUInt32(stats.rating);
    stmt.addUInt32(stats.games_week);
    stmt.addUInt32(stats.games_season);
    stmt.addUInt32(stats.rank);
    stmt.addUInt32(stats.wins_week);
    stmt.addUInt32(stats.wins_season);
    stmt.addUInt32(GetId());

    stmt.Execute();

    // save team and member stats to db
    // called after a match has ended, or when calculating arena_points
    for (MemberList::iterator itr = members.begin(); itr !=  members.end(); ++itr)
    {
        stmt = RealmDataDatabase.CreateStatement(updateAMembers, "UPDATE arena_team_member SET played_week = ?, wons_week = ?, played_season = ?, wons_season = ?, personal_rating = ? WHERE arenateamid = ? AND guid = ?");

        stmt.addUInt32(itr->games_week);
        stmt.addUInt32(itr->wins_week);
        stmt.addUInt32(itr->games_season);
        stmt.addUInt32(itr->wins_season);
        stmt.addUInt32(itr->personal_rating);
        stmt.addUInt32(Id);
        stmt.addUInt32(itr->guid);

        stmt.Execute();

        switch (GetType())
        {
            case 2:
                stmt = RealmDataDatabase.CreateStatement(updateH2Rating, "UPDATE hidden_rating SET rating2 = ? WHERE guid = ?");
                break;
            case 3:
                stmt = RealmDataDatabase.CreateStatement(updateH3Rating, "UPDATE hidden_rating SET rating3 = ? WHERE guid = ?");
                break;
            case 5:
                stmt = RealmDataDatabase.CreateStatement(updateH5Rating, "UPDATE hidden_rating SET rating5 = ? WHERE guid = ?");
                break;
            default:
                continue;
        }

        stmt.addUInt32(itr->matchmaker_rating);
        stmt.addUInt32(itr->guid);
        stmt.Execute();
    }

    RealmDataDatabase.CommitTransaction();
}

void ArenaTeam::FinishWeek()
{
    stats.games_week = 0;                                   // played this week
    stats.wins_week = 0;                                    // wins this week
    for (MemberList::iterator itr = members.begin(); itr !=  members.end(); ++itr)
    {
        itr->games_week = 0;
        itr->wins_week = 0;
    }
}

uint32 ArenaTeam::GetAverageMMR(Group *group) const
{
    if (!group) //should never happen
        return 0;
    uint32 matchmakerrating = 0;
    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        if (group->IsMember(itr->guid))
            matchmakerrating += itr->matchmaker_rating;
    }

    matchmakerrating /= GetType();

    return matchmakerrating;
}

bool ArenaTeam::IsFighting() const
{
    for (MemberList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
    {
        if (Player *p = sObjectMgr.GetPlayer(itr->guid))
        {
            if (p->GetMap()->IsBattleArena())
                return true;
        }
    }
    return false;
}

/*
arenateam fields (id from 2.3.3 client):
1414 - arena team id 2v2
1415 - 0=captain, 1=member
1416 - played this week
1417 - played this season
1418 - unk - rank?
1419 - personal arena rating
1420 - arena team id 3v3
1421 - 0=captain, 1=member
1422 - played this week
1423 - played this season
1424 - unk - rank?
1425 - personal arena rating
1426 - arena team id 5v5
1427 - 0=captain, 1=member
1428 - played this week
1429 - played this season
1430 - unk - rank?
1431 - personal arena rating
*/
