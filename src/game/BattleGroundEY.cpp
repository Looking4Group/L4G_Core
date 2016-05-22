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

#include "Object.h"
#include "Player.h"
#include "BattleGround.h"
#include "BattleGroundEY.h"
#include "Creature.h"
#include "Chat.h"
#include "ObjectMgr.h"
#include "MapManager.h"
#include "Language.h"
#include "World.h"
#include "Util.h"
#include "WorldPacket.h"

// these variables aren't used outside of this file, so declare them only here
uint32 BG_EY_HonorScoreTicks[BG_HONOR_MODE_NUM] = {
    330, // normal honor
    200  // holiday
};

BattleGroundEY::BattleGroundEY()
{
    m_BuffChange = true;
    m_BgObjects.resize(BG_EY_OBJECT_MAX);
    m_BgCreatures.resize(BG_EY_CREATURES_MAX);
    m_Points_Trigger[FEL_REALVER] = TR_FEL_REALVER_BUFF;
    m_Points_Trigger[BLOOD_ELF] = TR_BLOOD_ELF_BUFF;
    m_Points_Trigger[DRAENEI_RUINS] = TR_DRAENEI_RUINS_BUFF;
    m_Points_Trigger[MAGE_TOWER] = TR_MAGE_TOWER_BUFF;
}

BattleGroundEY::~BattleGroundEY()
{
}

void BattleGroundEY::Update(uint32 diff)
{
    BattleGround::Update(diff);
    // after bg start we get there (once)
    if (GetStatus() == STATUS_WAIT_JOIN && GetPlayersSize())
    {
        ModifyStartDelayTime(diff);

        if (!(m_Events & 0x01))
        {
            m_Events |= 0x01;

            // setup here, only when at least one player has ported to the map
            if (!SetupBattleGround())
            {
                EndNow();
                return;
            }

            SpawnBGObject(BG_EY_OBJECT_DOOR_A, RESPAWN_IMMEDIATELY);
            SpawnBGObject(BG_EY_OBJECT_DOOR_H, RESPAWN_IMMEDIATELY);

            DoorClose(BG_EY_OBJECT_DOOR_A);
            DoorClose(BG_EY_OBJECT_DOOR_H);

//            SpawnBGCreature(EY_SPIRIT_MAIN_ALLIANCE, RESPAWN_IMMEDIATELY);
//            SpawnBGCreature(EY_SPIRIT_MAIN_HORDE, RESPAWN_IMMEDIATELY);
            for (uint32 i = BG_EY_OBJECT_A_BANNER_FEL_REALVER_CENTER; i < BG_EY_OBJECT_MAX; ++i)
                SpawnBGObject(i, RESPAWN_ONE_DAY);

            SetStartDelayTime(START_DELAY0);
        }
        // After 1 minute, warning is signalled
        else if (GetStartDelayTime() <= START_DELAY1 && !(m_Events & 0x04))
        {
            m_Events |= 0x04;
            SendMessageToAll(GetTrinityString(LANG_BG_EY_ONE_MINUTE));
        }
        // After 1,5 minute, warning is signalled
        else if (GetStartDelayTime() <= START_DELAY2 && !(m_Events & 0x08))
        {
            m_Events |= 0x08;
            SendMessageToAll(GetTrinityString(LANG_BG_EY_HALF_MINUTE));
        }
        // After 2 minutes, gates OPEN ! x)
        else if (GetStartDelayTime() < 0 && !(m_Events & 0x10))
        {
            m_Events |= 0x10;
            SpawnBGObject(BG_EY_OBJECT_DOOR_A, RESPAWN_ONE_DAY);
            SpawnBGObject(BG_EY_OBJECT_DOOR_H, RESPAWN_ONE_DAY);

            DoorOpen(BG_EY_OBJECT_DOOR_A);
            DoorOpen(BG_EY_OBJECT_DOOR_H);

            for (uint32 i = BG_EY_OBJECT_N_BANNER_FEL_REALVER_CENTER; i <= BG_EY_OBJECT_FLAG_NETHERSTORM; ++i)
                SpawnBGObject(i, RESPAWN_IMMEDIATELY);
            for (uint32 i = 0; i < EY_POINTS_MAX; ++i)
            {
                //randomly spawn buff
                uint8 buff = urand(0, 2);
                SpawnBGObject(BG_EY_OBJECT_SPEEDBUFF_FEL_REALVER + buff + i * 3, RESPAWN_IMMEDIATELY);
            }

            SendMessageToAll(GetTrinityString(LANG_BG_EY_BEGIN));

            PlaySoundToAll(SOUND_BG_START);
            if (sWorld.getConfig(CONFIG_BG_START_MUSIC))
                PlaySoundToAll(SOUND_BG_START_L70ETC); //MUSIC
            SetStatus(STATUS_IN_PROGRESS);

            for (BattleGroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
                if (Player *plr = sObjectMgr.GetPlayer(itr->first))
                    plr->RemoveAurasDueToSpell(SPELL_PREPARATION);
        }
    }
    else if (GetStatus() == STATUS_IN_PROGRESS)
    {
        m_PointAddingTimer -= diff;
        if (m_PointAddingTimer <= 0)
        {
            m_PointAddingTimer = BG_EY_FPOINTS_TICK_TIME;
            if (m_TeamPointsCount[BG_TEAM_ALLIANCE] > 0)
                AddPoints(ALLIANCE, BG_EY_TickPoints[m_TeamPointsCount[BG_TEAM_ALLIANCE] - 1]);
            if (m_TeamPointsCount[BG_TEAM_HORDE] > 0)
                AddPoints(HORDE, BG_EY_TickPoints[m_TeamPointsCount[BG_TEAM_HORDE] - 1]);
        }

        if (m_FlagState == BG_EY_FLAG_STATE_WAIT_RESPAWN || m_FlagState == BG_EY_FLAG_STATE_ON_GROUND)
        {
            m_FlagsTimer -= diff;

            if (m_FlagsTimer < 0)
            {
                m_FlagsTimer = 0;
                if (m_FlagState == BG_EY_FLAG_STATE_WAIT_RESPAWN)
                    RespawnFlag(true);
                else
                    RespawnFlagAfterDrop();
            }
        }

        m_TowerCapCheckTimer -= diff;
        if (m_TowerCapCheckTimer <= 0)
        {
            //check if player joined point
            /*I used this order of calls, because although we will check if one player is in gameobject's distance 2 times
              but we can count of players on current point in CheckSomeoneLeftPoint
            */
            this->CheckSomeoneJoinedPoint();
            //check if player left point
            this->CheckSomeoneLeftPoint();
            this->UpdatePointStatuses();
            m_TowerCapCheckTimer = BG_EY_FPOINTS_TICK_TIME;
        }
    }
}

void BattleGroundEY::AddPoints(uint32 Team, uint32 Points)
{
    uint8 team_index = GetTeamIndexByTeamId(Team);
    m_TeamScores[team_index] += Points;
    m_score[team_index] = m_TeamScores[team_index];
    m_HonorScoreTics[team_index] += Points;
    if (m_HonorScoreTics[team_index] >= BG_EY_HonorScoreTicks[m_HonorMode])
    {
        RewardHonorToTeam(20, Team);
        m_HonorScoreTics[team_index] -= BG_EY_HonorScoreTicks[m_HonorMode];
    }
    UpdateTeamScore(Team);
}

void BattleGroundEY::CheckSomeoneJoinedPoint()
{
    GameObject *obj = NULL;
    Map * tmpMap = GetMap();

    if (!tmpMap)
        return;

    for (uint8 i = 0; i < EY_POINTS_MAX; ++i)
    {
        obj = tmpMap->GetGameObject(m_BgObjects[BG_EY_OBJECT_TOWER_CAP_FEL_REALVER + i]);
        if (obj)
        {
            uint8 j = 0;
            while (j < m_PlayersNearPoint[EY_POINTS_MAX].size())
            {
                Player *plr = sObjectMgr.GetPlayer(m_PlayersNearPoint[EY_POINTS_MAX][j]);
                if (!plr)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: BattleGroundEY: Player " UI64FMTD " not found!", m_PlayersNearPoint[EY_POINTS_MAX][j]);
                    m_PlayersNearPoint[EY_POINTS_MAX].erase(m_PlayersNearPoint[EY_POINTS_MAX].begin() + j);
                    ++j;
                    continue;
                }
                if (plr->isAllowedToJoinPoint() && plr->IsWithinDistInMap(obj, BG_EY_POINT_RADIUS))
                {
                    //player joined point!
                    //show progress bar
                    UpdateWorldStateForPlayer(PROGRESS_BAR_PERCENT_GREY, BG_EY_PROGRESS_BAR_PERCENT_GREY, plr);
                    UpdateWorldStateForPlayer(PROGRESS_BAR_STATUS, m_PointBarStatus[i], plr);
                    UpdateWorldStateForPlayer(PROGRESS_BAR_SHOW, BG_EY_PROGRESS_BAR_SHOW, plr);
                    //add player to point
                    m_PlayersNearPoint[i].push_back(m_PlayersNearPoint[EY_POINTS_MAX][j]);
                    //remove player from "free space"
                    m_PlayersNearPoint[EY_POINTS_MAX].erase(m_PlayersNearPoint[EY_POINTS_MAX].begin() + j);
                }
                else
                    ++j;
            }
        }
    }
}

void BattleGroundEY::CheckSomeoneLeftPoint()
{
    //reset current point counts
    for (uint8 i = 0; i < 2*EY_POINTS_MAX; ++i)
        m_CurrentPointPlayersCount[i] = 0;

    Map * tmpMap = GetMap();

    if (!tmpMap)
        return;

    GameObject *obj = NULL;
    for (uint8 i = 0; i < EY_POINTS_MAX; ++i)
    {
        obj = tmpMap->GetGameObject(m_BgObjects[BG_EY_OBJECT_TOWER_CAP_FEL_REALVER + i]);
        if (obj)
        {
            uint8 j = 0;
            while (j < m_PlayersNearPoint[i].size())
            {
                Player *plr = sObjectMgr.GetPlayer(m_PlayersNearPoint[i][j]);
                if (!plr)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: BattleGroundEY: Player " UI64FMTD " not found!", m_PlayersNearPoint[i][j]);
                    ////move not existed player to "free space" - this will cause many error showing in log, but it is a very important bug
                    //m_PlayersNearPoint[EY_POINTS_MAX].push_back(m_PlayersNearPoint[i][j]);
                    m_PlayersNearPoint[i].erase(m_PlayersNearPoint[i].begin() + j);
                    ++j;
                    continue;
                }
                if (!plr->isAllowedToJoinPoint() || !plr->IsWithinDistInMap(obj, BG_EY_POINT_RADIUS))
                    //move player out of point (add him to players that are out of points
                {
                    m_PlayersNearPoint[EY_POINTS_MAX].push_back(m_PlayersNearPoint[i][j]);
                    m_PlayersNearPoint[i].erase(m_PlayersNearPoint[i].begin() + j);
                    this->UpdateWorldStateForPlayer(PROGRESS_BAR_SHOW, BG_EY_PROGRESS_BAR_DONT_SHOW, plr);
                }
                else
                {
                    //player is neat flag, so update count:
                    m_CurrentPointPlayersCount[2 * i + GetTeamIndexByTeamId(plr->GetBGTeam())]++;
                    ++j;
                }
            }
        }
    }
}

void BattleGroundEY::UpdatePointStatuses()
{
    for (uint8 point = 0; point < EY_POINTS_MAX; ++point)
    {
        if (m_PlayersNearPoint[point].empty())
            continue;
        //count new point bar status:
        m_PointBarStatus[point] += (m_CurrentPointPlayersCount[2 * point] - m_CurrentPointPlayersCount[2 * point + 1] < BG_EY_POINT_MAX_CAPTURERS_COUNT) ? m_CurrentPointPlayersCount[2 * point] - m_CurrentPointPlayersCount[2 * point + 1] : BG_EY_POINT_MAX_CAPTURERS_COUNT;

        if (m_PointBarStatus[point] > BG_EY_PROGRESS_BAR_ALI_CONTROLLED)
            //point is fully alliance's
            m_PointBarStatus[point] = BG_EY_PROGRESS_BAR_ALI_CONTROLLED;
        if (m_PointBarStatus[point] < BG_EY_PROGRESS_BAR_HORDE_CONTROLLED)
            //point is fully horde's
            m_PointBarStatus[point] = BG_EY_PROGRESS_BAR_HORDE_CONTROLLED;

        uint32 pointOwnerTeamId = 0;
        //find which team should own this point
        if (m_PointBarStatus[point] <= BG_EY_PROGRESS_BAR_NEUTRAL_LOW)
            pointOwnerTeamId = HORDE;
        else if (m_PointBarStatus[point] >= BG_EY_PROGRESS_BAR_NEUTRAL_HIGH)
            pointOwnerTeamId = ALLIANCE;
        else
            pointOwnerTeamId = EY_POINT_NO_OWNER;

        for (uint8 i = 0; i < m_PlayersNearPoint[point].size(); ++i)
        {
            Player *plr = sObjectMgr.GetPlayer(m_PlayersNearPoint[point][i]);
            if (plr)
            {
                this->UpdateWorldStateForPlayer(PROGRESS_BAR_STATUS, m_PointBarStatus[point], plr);
                                                            //if point owner changed we must evoke event!
                if (pointOwnerTeamId != m_PointOwnedByTeam[point])
                {
                    //point was uncontrolled and player is from team which captured point
                    if (m_PointState[point] == EY_POINT_STATE_UNCONTROLLED && plr->GetBGTeam() == pointOwnerTeamId)
                        this->EventTeamCapturedPoint(plr, point);

                    //point was under control and player isn't from team which controlled it
                    if (m_PointState[point] == EY_POINT_UNDER_CONTROL && plr->GetBGTeam() != m_PointOwnedByTeam[point])
                        this->EventTeamLostPoint(plr, point);
                }
            }
        }
    }
}

void BattleGroundEY::UpdateTeamScore(uint32 Team)
{
    uint32 score = GetTeamScore(Team);
    if (score >= EY_MAX_TEAM_SCORE)
    {
        score = EY_MAX_TEAM_SCORE;
        EndBattleGround(Team);
    }

    if (Team == ALLIANCE)
        UpdateWorldState(EY_ALLIANCE_RESOURCES, score);
    else
        UpdateWorldState(EY_HORDE_RESOURCES, score);
}

void BattleGroundEY::UpdatePointsCount(uint32 Team)
{
    if (Team == ALLIANCE)
        UpdateWorldState(EY_ALLIANCE_BASE, m_TeamPointsCount[BG_TEAM_ALLIANCE]);
    else
        UpdateWorldState(EY_HORDE_BASE, m_TeamPointsCount[BG_TEAM_HORDE]);
}

void BattleGroundEY::UpdatePointsIcons(uint32 Team, uint32 Point)
{
    //we MUST firstly send 0, after that we can send 1!!!
    if (m_PointState[Point] == EY_POINT_UNDER_CONTROL)
    {
        UpdateWorldState(m_PointsIconStruct[Point].WorldStateControlIndex, 0);
        if (Team == ALLIANCE)
            UpdateWorldState(m_PointsIconStruct[Point].WorldStateAllianceControlledIndex, 1);
        else
            UpdateWorldState(m_PointsIconStruct[Point].WorldStateHordeControlledIndex, 1);
    }
    else
    {
        if (Team == ALLIANCE)
            UpdateWorldState(m_PointsIconStruct[Point].WorldStateAllianceControlledIndex, 0);
        else
            UpdateWorldState(m_PointsIconStruct[Point].WorldStateHordeControlledIndex, 0);
        UpdateWorldState(m_PointsIconStruct[Point].WorldStateControlIndex, 1);
    }
}

void BattleGroundEY::AddPlayer(Player *plr)
{
    BattleGround::AddPlayer(plr);
    //create score and add it to map
    BattleGroundEYScore* sc = new BattleGroundEYScore;

    m_PlayersNearPoint[EY_POINTS_MAX].push_back(plr->GetGUID());

    m_PlayerScores[plr->GetGUID()] = sc;
}

void BattleGroundEY::RemovePlayer(Player *plr, uint64 guid)
{
    // sometimes flag aura not removed :(
    for (int j = EY_POINTS_MAX; j >= 0; --j)
    {
        for (int i = 0; i < m_PlayersNearPoint[j].size(); ++i)
            if (m_PlayersNearPoint[j][i] == guid)
                m_PlayersNearPoint[j].erase(m_PlayersNearPoint[j].begin() + i);
    }
    if (IsFlagPickedup())
    {
        if (m_FlagKeeper == guid)
        {
            if (plr)
                this->EventPlayerDroppedFlag(plr);
            else
            {
                SetFlagPicker(0);
                RespawnFlag(true);
            }
        }
    }
}

void BattleGroundEY::HandleAreaTrigger(Player *Source, uint32 Trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    if (!Source->isAlive())                                  //hack code, must be removed later
        return;

    switch (Trigger)
    {
        case TR_BLOOD_ELF_POINT:
            if (m_PointState[BLOOD_ELF] == EY_POINT_UNDER_CONTROL && m_PointOwnedByTeam[BLOOD_ELF] == Source->GetBGTeam())
                if (m_FlagState && GetFlagPickerGUID() == Source->GetGUID())
                    EventPlayerCapturedFlag(Source, BG_EY_OBJECT_FLAG_BLOOD_ELF);
            break;
        case TR_FEL_REALVER_POINT:
            if (m_PointState[FEL_REALVER] == EY_POINT_UNDER_CONTROL && m_PointOwnedByTeam[FEL_REALVER] == Source->GetBGTeam())
                if (m_FlagState && GetFlagPickerGUID() == Source->GetGUID())
                    EventPlayerCapturedFlag(Source, BG_EY_OBJECT_FLAG_FEL_REALVER);
            break;
        case TR_MAGE_TOWER_POINT:
            if (m_PointState[MAGE_TOWER] == EY_POINT_UNDER_CONTROL && m_PointOwnedByTeam[MAGE_TOWER] == Source->GetBGTeam())
                if (m_FlagState && GetFlagPickerGUID() == Source->GetGUID())
                    EventPlayerCapturedFlag(Source, BG_EY_OBJECT_FLAG_MAGE_TOWER);
            break;
        case TR_DRAENEI_RUINS_POINT:
            if (m_PointState[DRAENEI_RUINS] == EY_POINT_UNDER_CONTROL && m_PointOwnedByTeam[DRAENEI_RUINS] == Source->GetBGTeam())
                if (m_FlagState && GetFlagPickerGUID() == Source->GetGUID())
                    EventPlayerCapturedFlag(Source, BG_EY_OBJECT_FLAG_DRAENEI_RUINS);
            break;
        case 4512:
        case 4515:
        case 4517:
        case 4519:
        case 4530:
        case 4531:
        case 4568:
        case 4569:
        case 4570:
        case 4571:
            break;
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: WARNING: Unhandled AreaTrigger in Battleground: %u", Trigger);
            Source->GetSession()->SendAreaTriggerMessage("Warning: Unhandled AreaTrigger in Battleground: %u", Trigger);
            break;
    }
}

bool BattleGroundEY::SetupBattleGround()
{
        // doors
    if (  !AddObject(BG_EY_OBJECT_DOOR_A, BG_OBJECT_A_DOOR_EY_ENTRY, 2527.6f, 1596.91f, 1262.13f, -3.12414f, -0.173642f, -0.001515f, 0.98477f, -0.008594f, RESPAWN_IMMEDIATELY)
        || !AddObject(BG_EY_OBJECT_DOOR_H, BG_OBJECT_H_DOOR_EY_ENTRY, 1803.21f, 1539.49f, 1261.09f, 3.14159f, 0.173648f, 0, 0.984808f, 0, RESPAWN_IMMEDIATELY)
        // banners (alliance)
        || !AddObject(BG_EY_OBJECT_A_BANNER_FEL_REALVER_CENTER, BG_OBJECT_A_BANNER_EY_ENTRY, 2057.46f, 1735.07f, 1187.91f, -0.925024f, 0, 0, 0.446198f, -0.894934f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_FEL_REALVER_LEFT, BG_OBJECT_A_BANNER_EY_ENTRY, 2032.25f, 1729.53f, 1190.33f, 1.8675f, 0, 0, 0.803857f, 0.594823f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_FEL_REALVER_RIGHT, BG_OBJECT_A_BANNER_EY_ENTRY, 2092.35f, 1775.46f, 1187.08f, -0.401426f, 0, 0, 0.199368f, -0.979925f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_BLOOD_ELF_CENTER, BG_OBJECT_A_BANNER_EY_ENTRY, 2047.19f, 1349.19f, 1189.0f, -1.62316f, 0, 0, 0.725374f, -0.688354f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_BLOOD_ELF_LEFT, BG_OBJECT_A_BANNER_EY_ENTRY, 2074.32f, 1385.78f, 1194.72f, 0.488692f, 0, 0, 0.241922f, 0.970296f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_BLOOD_ELF_RIGHT, BG_OBJECT_A_BANNER_EY_ENTRY, 2025.13f, 1386.12f, 1192.74f, 2.3911f, 0, 0, 0.930418f, 0.366501f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_CENTER, BG_OBJECT_A_BANNER_EY_ENTRY, 2276.8f, 1400.41f, 1196.33f, 2.44346f, 0, 0, 0.939693f, 0.34202f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_LEFT, BG_OBJECT_A_BANNER_EY_ENTRY, 2305.78f, 1404.56f, 1199.38f, 1.74533f, 0, 0, 0.766044f, 0.642788f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_RIGHT, BG_OBJECT_A_BANNER_EY_ENTRY, 2245.4f, 1366.41f, 1195.28f, 2.21657f, 0, 0, 0.894934f, 0.446198f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_MAGE_TOWER_CENTER, BG_OBJECT_A_BANNER_EY_ENTRY, 2270.84f, 1784.08f, 1186.76f, 2.42601f, 0, 0, 0.936672f, 0.350207f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_MAGE_TOWER_LEFT, BG_OBJECT_A_BANNER_EY_ENTRY, 2269.13f, 1737.7f, 1186.66f, 0.994838f, 0, 0, 0.477159f, 0.878817f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_A_BANNER_MAGE_TOWER_RIGHT, BG_OBJECT_A_BANNER_EY_ENTRY, 2300.86f, 1741.25f, 1187.7f, -0.785398f, 0, 0, 0.382683f, -0.92388f, RESPAWN_ONE_DAY)
        // banners (horde)
        || !AddObject(BG_EY_OBJECT_H_BANNER_FEL_REALVER_CENTER, BG_OBJECT_H_BANNER_EY_ENTRY, 2057.46f, 1735.07f, 1187.91f, -0.925024f, 0, 0, 0.446198f, -0.894934f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_FEL_REALVER_LEFT, BG_OBJECT_H_BANNER_EY_ENTRY, 2032.25f, 1729.53f, 1190.33f, 1.8675f, 0, 0, 0.803857f, 0.594823f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_FEL_REALVER_RIGHT, BG_OBJECT_H_BANNER_EY_ENTRY, 2092.35f, 1775.46f, 1187.08f, -0.401426f, 0, 0, 0.199368f, -0.979925f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_BLOOD_ELF_CENTER, BG_OBJECT_H_BANNER_EY_ENTRY, 2047.19f, 1349.19f, 1189.0f, -1.62316f, 0, 0, 0.725374f, -0.688354f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_BLOOD_ELF_LEFT, BG_OBJECT_H_BANNER_EY_ENTRY, 2074.32f, 1385.78f, 1194.72f, 0.488692f, 0, 0, 0.241922f, 0.970296f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_BLOOD_ELF_RIGHT, BG_OBJECT_H_BANNER_EY_ENTRY, 2025.13f, 1386.12f, 1192.74f, 2.3911f, 0, 0, 0.930418f, 0.366501f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_CENTER, BG_OBJECT_H_BANNER_EY_ENTRY, 2276.8f, 1400.41f, 1196.33f, 2.44346f, 0, 0, 0.939693f, 0.34202f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_LEFT, BG_OBJECT_H_BANNER_EY_ENTRY, 2305.78f, 1404.56f, 1199.38f, 1.74533f, 0, 0, 0.766044f, 0.642788f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_RIGHT, BG_OBJECT_H_BANNER_EY_ENTRY, 2245.4f, 1366.41f, 1195.28f, 2.21657f, 0, 0, 0.894934f, 0.446198f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_MAGE_TOWER_CENTER, BG_OBJECT_H_BANNER_EY_ENTRY, 2270.84f, 1784.08f, 1186.76f, 2.42601f, 0, 0, 0.936672f, 0.350207f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_MAGE_TOWER_LEFT, BG_OBJECT_H_BANNER_EY_ENTRY, 2269.13f, 1737.7f, 1186.66f, 0.994838f, 0, 0, 0.477159f, 0.878817f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_H_BANNER_MAGE_TOWER_RIGHT, BG_OBJECT_H_BANNER_EY_ENTRY, 2300.86f, 1741.25f, 1187.7f, -0.785398f, 0, 0, 0.382683f, -0.92388f, RESPAWN_ONE_DAY)
        // banners (natural)
        || !AddObject(BG_EY_OBJECT_N_BANNER_FEL_REALVER_CENTER, BG_OBJECT_N_BANNER_EY_ENTRY, 2057.46f, 1735.07f, 1187.91f, -0.925024f, 0, 0, 0.446198f, -0.894934f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_FEL_REALVER_LEFT, BG_OBJECT_N_BANNER_EY_ENTRY, 2032.25f, 1729.53f, 1190.33f, 1.8675f, 0, 0, 0.803857f, 0.594823f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_FEL_REALVER_RIGHT, BG_OBJECT_N_BANNER_EY_ENTRY, 2092.35f, 1775.46f, 1187.08f, -0.401426f, 0, 0, 0.199368f, -0.979925f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_BLOOD_ELF_CENTER, BG_OBJECT_N_BANNER_EY_ENTRY, 2047.19f, 1349.19f, 1189.0f, -1.62316f, 0, 0, 0.725374f, -0.688354f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_BLOOD_ELF_LEFT, BG_OBJECT_N_BANNER_EY_ENTRY, 2074.32f, 1385.78f, 1194.72f, 0.488692f, 0, 0, 0.241922f, 0.970296f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_BLOOD_ELF_RIGHT, BG_OBJECT_N_BANNER_EY_ENTRY, 2025.13f, 1386.12f, 1192.74f, 2.3911f, 0, 0, 0.930418f, 0.366501f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_CENTER, BG_OBJECT_N_BANNER_EY_ENTRY, 2276.8f, 1400.41f, 1196.33f, 2.44346f, 0, 0, 0.939693f, 0.34202f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_LEFT, BG_OBJECT_N_BANNER_EY_ENTRY, 2305.78f, 1404.56f, 1199.38f, 1.74533f, 0, 0, 0.766044f, 0.642788f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_RIGHT, BG_OBJECT_N_BANNER_EY_ENTRY, 2245.4f, 1366.41f, 1195.28f, 2.21657f, 0, 0, 0.894934f, 0.446198f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_MAGE_TOWER_CENTER, BG_OBJECT_N_BANNER_EY_ENTRY, 2270.84f, 1784.08f, 1186.76f, 2.42601f, 0, 0, 0.936672f, 0.350207f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_MAGE_TOWER_LEFT, BG_OBJECT_N_BANNER_EY_ENTRY, 2269.13f, 1737.7f, 1186.66f, 0.994838f, 0, 0, 0.477159f, 0.878817f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_N_BANNER_MAGE_TOWER_RIGHT, BG_OBJECT_N_BANNER_EY_ENTRY, 2300.86f, 1741.25f, 1187.7f, -0.785398f, 0, 0, 0.382683f, -0.92388f, RESPAWN_ONE_DAY)
        // flags
        || !AddObject(BG_EY_OBJECT_FLAG_NETHERSTORM, BG_OBJECT_FLAG2_EY_ENTRY, 2174.782227f, 1569.054688f, 1160.361938f, -1.448624f, 0, 0, 0.662620f, -0.748956f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_FLAG_FEL_REALVER, BG_OBJECT_FLAG1_EY_ENTRY, 2044.28f, 1729.68f, 1189.96f, -0.017453f, 0, 0, 0.008727f, -0.999962f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_FLAG_BLOOD_ELF, BG_OBJECT_FLAG1_EY_ENTRY, 2048.83f, 1393.65f, 1194.49f, 0.20944f, 0, 0, 0.104528f, 0.994522f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_FLAG_DRAENEI_RUINS, BG_OBJECT_FLAG1_EY_ENTRY, 2286.56f, 1402.36f, 1197.11f, 3.72381f, 0, 0, 0.957926f, -0.287016f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_FLAG_MAGE_TOWER, BG_OBJECT_FLAG1_EY_ENTRY, 2284.48f, 1731.23f, 1189.99f, 2.89725f, 0, 0, 0.992546f, 0.121869f, RESPAWN_ONE_DAY)
        // tower cap
        || !AddObject(BG_EY_OBJECT_TOWER_CAP_FEL_REALVER, BG_OBJECT_FR_TOWER_CAP_EY_ENTRY, 2024.600708f, 1742.819580f, 1195.157715f, 2.443461f, 0, 0, 0.939693f, 0.342020f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_TOWER_CAP_BLOOD_ELF, BG_OBJECT_BE_TOWER_CAP_EY_ENTRY, 2050.493164f, 1372.235962f, 1194.563477f, 1.710423f, 0, 0, 0.754710f, 0.656059f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_TOWER_CAP_DRAENEI_RUINS, BG_OBJECT_DR_TOWER_CAP_EY_ENTRY, 2301.010498f, 1386.931641f, 1197.183472f, 1.570796f, 0, 0, 0.707107f, 0.707107f, RESPAWN_ONE_DAY)
        || !AddObject(BG_EY_OBJECT_TOWER_CAP_MAGE_TOWER, BG_OBJECT_HU_TOWER_CAP_EY_ENTRY, 2282.121582f, 1760.006958f, 1189.707153f, 1.919862f, 0, 0, 0.819152f, 0.573576f, RESPAWN_ONE_DAY)
       )
    {
        sLog.outLog(LOG_DB_ERR, "BatteGroundEY: Failed to spawn some object BattleGround not created!");
        return false;
    }

    //buffs
    for (int i = 0; i < EY_POINTS_MAX; ++i)
    {
        AreaTriggerEntry const* at = sAreaTriggerStore.LookupEntry(m_Points_Trigger[i]);
        if (!at)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: BattleGroundEY: Unknown trigger: %u", m_Points_Trigger[i]);
            continue;
        }
        if ( !AddObject(BG_EY_OBJECT_SPEEDBUFF_FEL_REALVER + i * 3, Buff_Entries[0], at->x, at->y, at->z, 0.907571f, 0, 0, 0.438371f, 0.898794f, RESPAWN_ONE_DAY)
            || !AddObject(BG_EY_OBJECT_SPEEDBUFF_FEL_REALVER + i * 3 + 1, Buff_Entries[1], at->x, at->y, at->z, 0.907571f, 0, 0, 0.438371f, 0.898794f, RESPAWN_ONE_DAY)
            || !AddObject(BG_EY_OBJECT_SPEEDBUFF_FEL_REALVER + i * 3 + 2, Buff_Entries[2], at->x, at->y, at->z, 0.907571f, 0, 0, 0.438371f, 0.898794f, RESPAWN_ONE_DAY)
           )
            sLog.outLog(LOG_DEFAULT, "ERROR: BattleGroundEY: Cannot spawn buff");
    }

    WorldSafeLocsEntry const *sg = NULL;
    sg = sWorldSafeLocsStore.LookupEntry(EY_GRAVEYARD_MAIN_ALLIANCE);
    if (!sg || !AddSpiritGuide(EY_SPIRIT_MAIN_ALLIANCE, sg->x, sg->y, sg->z, 3.124139f, ALLIANCE))
    {
        sLog.outLog(LOG_DB_ERR, "BatteGroundEY: Failed to spawn spirit guide! BattleGround not created!");
        return false;
    }

    sg = sWorldSafeLocsStore.LookupEntry(EY_GRAVEYARD_MAIN_HORDE);
    if (!sg || !AddSpiritGuide(EY_SPIRIT_MAIN_HORDE, sg->x, sg->y, sg->z, 3.193953f, HORDE))
    {
        sLog.outLog(LOG_DB_ERR, "BatteGroundEY: Failed to spawn spirit guide! BattleGround not created!");
        return false;
    }

    return true;
}

void BattleGroundEY::ResetBGSubclass()
{
    m_TeamScores[BG_TEAM_ALLIANCE] = 0;
    m_TeamScores[BG_TEAM_HORDE] = 0;
    m_TeamPointsCount[BG_TEAM_ALLIANCE] = 0;
    m_TeamPointsCount[BG_TEAM_HORDE] = 0;
    m_HonorScoreTics[BG_TEAM_ALLIANCE] = 0;
    m_HonorScoreTics[BG_TEAM_HORDE] = 0;
    m_FlagState = BG_EY_FLAG_STATE_ON_BASE;
    m_FlagCapturedBgObjectType = 0;
    m_FlagKeeper = 0;
    m_DroppedFlagGUID = 0;
    m_PointAddingTimer = 0;
    m_TowerCapCheckTimer = 0;

    for (uint8 i = 0; i < EY_POINTS_MAX; ++i)
    {
        m_PointOwnedByTeam[i] = EY_POINT_NO_OWNER;
        m_PointState[i] = EY_POINT_STATE_UNCONTROLLED;
        m_PointBarStatus[i] = BG_EY_PROGRESS_BAR_STATE_MIDDLE;
        m_PlayersNearPoint[i].clear();
        m_PlayersNearPoint[i].reserve(15);                  //tip size
    }
    m_PlayersNearPoint[EY_PLAYERS_OUT_OF_POINTS].clear();
    m_PlayersNearPoint[EY_PLAYERS_OUT_OF_POINTS].reserve(30);
}

void BattleGroundEY::RespawnFlag(bool send_message)
{
    if (m_FlagCapturedBgObjectType > 0)
        SpawnBGObject(m_FlagCapturedBgObjectType, RESPAWN_ONE_DAY);

    m_FlagCapturedBgObjectType = 0;
    m_FlagState = BG_EY_FLAG_STATE_ON_BASE;
    SpawnBGObject(BG_EY_OBJECT_FLAG_NETHERSTORM, RESPAWN_IMMEDIATELY);

    if (send_message)
    {
        SendMessageToAll(GetTrinityString(LANG_BG_EY_RESETED_FLAG));
        PlaySoundToAll(BG_EY_SOUND_FLAG_RESET);             // flags respawned sound...
    }

    UpdateWorldState(NETHERSTORM_FLAG, 1);
}

void BattleGroundEY::RespawnFlagAfterDrop()
{
    RespawnFlag(true);

    Map * tmpMap = GetMap();

    if (!tmpMap)
        return;

    GameObject *obj = tmpMap->GetGameObject(GetDroppedFlagGUID());
    if (obj)
        obj->Delete();
    else
        sLog.outLog(LOG_DEFAULT, "ERROR: BattleGroundEY: Unknown dropped flag guid: %u",GUID_LOPART(GetDroppedFlagGUID()));

    SetDroppedFlagGUID(0);
}

void BattleGroundEY::HandleKillPlayer(Player *player, Player *killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    BattleGround::HandleKillPlayer(player, killer);
    EventPlayerDroppedFlag(player);
}

void BattleGroundEY::EventPlayerDroppedFlag(Player *Source)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
    {
        // if not running, do not cast things at the dropper player, neither send unnecessary messages
        // just take off the aura
        if (IsFlagPickedup() && GetFlagPickerGUID() == Source->GetGUID())
        {
            SetFlagPicker(0);
            Source->RemoveAurasDueToSpell(BG_EY_NETHERSTORM_FLAG_SPELL);
        }
        return;
    }

    if (!IsFlagPickedup())
        return;

    if (GetFlagPickerGUID() != Source->GetGUID())
        return;

    const char *message = "";
    uint8 type = 0;

    SetFlagPicker(0);
    Source->RemoveAurasDueToSpell(BG_EY_NETHERSTORM_FLAG_SPELL);
    m_FlagState = BG_EY_FLAG_STATE_ON_GROUND;
    m_FlagsTimer = BG_EY_FLAG_RESPAWN_TIME;
    Source->CastSpell(Source, SPELL_RECENTLY_DROPPED_FLAG, true);
    Source->CastSpell(Source, BG_EY_PLAYER_DROPPED_FLAG_SPELL, true);
    if (Source->GetBGTeam() == ALLIANCE)
    {
        message = GetTrinityString(LANG_BG_EY_DROPPED_FLAG);
        type = CHAT_MSG_BG_SYSTEM_ALLIANCE;
    }
    else
    {
        message = GetTrinityString(LANG_BG_EY_DROPPED_FLAG);
        type = CHAT_MSG_BG_SYSTEM_HORDE;
    }
    //this does not work correctly :((it should remove flag carrier name)
    UpdateWorldState(NETHERSTORM_FLAG_STATE_HORDE, BG_EY_FLAG_STATE_WAIT_RESPAWN);
    UpdateWorldState(NETHERSTORM_FLAG_STATE_ALLIANCE, BG_EY_FLAG_STATE_WAIT_RESPAWN);

    WorldPacket data;
    ChatHandler::FillMessageData(&data, Source->GetSession(), type, LANG_UNIVERSAL, NULL, Source->GetGUID(), message, NULL);
    SendPacketToAll(&data);
}

void BattleGroundEY::EventPlayerClickedOnFlag(Player *Source, GameObject* target_obj)
{
    if (GetStatus() != STATUS_IN_PROGRESS || this->IsFlagPickedup() || !Source->IsWithinDistInMap(target_obj, 10))
        return;

    const char *message;
    uint8 type = 0;
    message = GetTrinityString(LANG_BG_EY_HAS_TAKEN_FLAG);

    if (Source->GetBGTeam() == ALLIANCE)
    {
        UpdateWorldState(NETHERSTORM_FLAG_STATE_ALLIANCE, BG_EY_FLAG_STATE_ON_PLAYER);
        type = CHAT_MSG_BG_SYSTEM_ALLIANCE;
        PlaySoundToAll(BG_EY_SOUND_FLAG_PICKED_UP_ALLIANCE);
    }
    else
    {
        UpdateWorldState(NETHERSTORM_FLAG_STATE_HORDE, BG_EY_FLAG_STATE_ON_PLAYER);
        type = CHAT_MSG_BG_SYSTEM_HORDE;
        PlaySoundToAll(BG_EY_SOUND_FLAG_PICKED_UP_HORDE);
    }

    if (m_FlagState == BG_EY_FLAG_STATE_ON_BASE)
        UpdateWorldState(NETHERSTORM_FLAG, 0);
    m_FlagState = BG_EY_FLAG_STATE_ON_PLAYER;

    SpawnBGObject(BG_EY_OBJECT_FLAG_NETHERSTORM, RESPAWN_ONE_DAY);
    SetFlagPicker(Source->GetGUID());
    //get flag aura on player
    Source->CastSpell(Source, BG_EY_NETHERSTORM_FLAG_SPELL, true);
    Source->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);

    WorldPacket data;
    ChatHandler::FillMessageData(&data, Source->GetSession(), type, LANG_UNIVERSAL, NULL, Source->GetGUID(), message, NULL);
    SendPacketToAll(&data);
}

void BattleGroundEY::EventTeamLostPoint(Player *Source, uint32 Point)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    //Natural point
    uint8 message_type = 0;
    const char *message = "";
    uint32 Team = m_PointOwnedByTeam[Point];

    if (!Team)
        return;

    if (Team == ALLIANCE)
    {
        m_TeamPointsCount[BG_TEAM_ALLIANCE]--;
        message_type = CHAT_MSG_BG_SYSTEM_ALLIANCE;
        message = GetTrinityString(m_LoosingPointTypes[Point].MessageIdAlliance);
        SpawnBGObject(m_LoosingPointTypes[Point].DespawnObjectTypeAlliance, RESPAWN_ONE_DAY);
        SpawnBGObject(m_LoosingPointTypes[Point].DespawnObjectTypeAlliance + 1, RESPAWN_ONE_DAY);
        SpawnBGObject(m_LoosingPointTypes[Point].DespawnObjectTypeAlliance + 2, RESPAWN_ONE_DAY);
    }
    else
    {
        m_TeamPointsCount[BG_TEAM_HORDE]--;
        message_type = CHAT_MSG_BG_SYSTEM_HORDE;
        message = GetTrinityString(m_LoosingPointTypes[Point].MessageIdHorde);
        SpawnBGObject(m_LoosingPointTypes[Point].DespawnObjectTypeHorde, RESPAWN_ONE_DAY);
        SpawnBGObject(m_LoosingPointTypes[Point].DespawnObjectTypeHorde + 1, RESPAWN_ONE_DAY);
        SpawnBGObject(m_LoosingPointTypes[Point].DespawnObjectTypeHorde + 2, RESPAWN_ONE_DAY);
    }

    SpawnBGObject(m_LoosingPointTypes[Point].SpawnNeutralObjectType, RESPAWN_IMMEDIATELY);
    SpawnBGObject(m_LoosingPointTypes[Point].SpawnNeutralObjectType + 1, RESPAWN_IMMEDIATELY);
    SpawnBGObject(m_LoosingPointTypes[Point].SpawnNeutralObjectType + 2, RESPAWN_IMMEDIATELY);

    //buff isn't despawned

    m_PointOwnedByTeam[Point] = EY_POINT_NO_OWNER;
    m_PointState[Point] = EY_POINT_NO_OWNER;

    WorldPacket data;
    ChatHandler::FillMessageData(&data, Source->GetSession(), message_type, LANG_UNIVERSAL, NULL, Source->GetGUID(), message, NULL);
    SendPacketToAll(&data);

    UpdatePointsIcons(Team, Point);
    UpdatePointsCount(Team);
}

void BattleGroundEY::EventTeamCapturedPoint(Player *Source, uint32 Point)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    uint8 type = 0;
    const char *message = "";
    uint32 Team = Source->GetBGTeam();

    SpawnBGObject(m_CapturingPointTypes[Point].DespawnNeutralObjectType, RESPAWN_ONE_DAY);
    SpawnBGObject(m_CapturingPointTypes[Point].DespawnNeutralObjectType + 1, RESPAWN_ONE_DAY);
    SpawnBGObject(m_CapturingPointTypes[Point].DespawnNeutralObjectType + 2, RESPAWN_ONE_DAY);

    if (Team == ALLIANCE)
    {
        m_TeamPointsCount[BG_TEAM_ALLIANCE]++;
        type = CHAT_MSG_BG_SYSTEM_ALLIANCE;
        message = GetTrinityString(m_CapturingPointTypes[Point].MessageIdAlliance);
        SpawnBGObject(m_CapturingPointTypes[Point].SpawnObjectTypeAlliance, RESPAWN_IMMEDIATELY);
        SpawnBGObject(m_CapturingPointTypes[Point].SpawnObjectTypeAlliance + 1, RESPAWN_IMMEDIATELY);
        SpawnBGObject(m_CapturingPointTypes[Point].SpawnObjectTypeAlliance + 2, RESPAWN_IMMEDIATELY);
    }
    else
    {
        m_TeamPointsCount[BG_TEAM_HORDE]++;
        type = CHAT_MSG_BG_SYSTEM_HORDE;
        message = GetTrinityString(m_CapturingPointTypes[Point].MessageIdHorde);
        SpawnBGObject(m_CapturingPointTypes[Point].SpawnObjectTypeHorde, RESPAWN_IMMEDIATELY);
        SpawnBGObject(m_CapturingPointTypes[Point].SpawnObjectTypeHorde + 1, RESPAWN_IMMEDIATELY);
        SpawnBGObject(m_CapturingPointTypes[Point].SpawnObjectTypeHorde + 2, RESPAWN_IMMEDIATELY);
    }

    //buff isn't respawned

    m_PointOwnedByTeam[Point] = Team;
    m_PointState[Point] = EY_POINT_UNDER_CONTROL;

    WorldPacket data;
    ChatHandler::FillMessageData(&data, Source->GetSession(), type, LANG_UNIVERSAL, NULL, Source->GetGUID(), message, NULL);
    SendPacketToAll(&data);

    if (m_BgCreatures[Point])
        DelCreature(Point);

    WorldSafeLocsEntry const *sg = NULL;
    sg = sWorldSafeLocsStore.LookupEntry(m_CapturingPointTypes[Point].GraveYardId);
    if (!sg || !AddSpiritGuide(Point, sg->x, sg->y, sg->z, 3.124139f, Team))
        sLog.outLog(LOG_DEFAULT, "ERROR: BatteGroundEY: Failed to spawn spirit guide! point: %u, team: %u, graveyard_id: %u",
            Point, Team, m_CapturingPointTypes[Point].GraveYardId);

//    SpawnBGCreature(Point,RESPAWN_IMMEDIATELY);

    UpdatePointsIcons(Team, Point);
    UpdatePointsCount(Team);
}

void BattleGroundEY::EventPlayerCapturedFlag(Player *Source, uint32 BgObjectType)
{
    if (GetStatus() != STATUS_IN_PROGRESS || this->GetFlagPickerGUID() != Source->GetGUID())
        return;

    uint8 type = 0;
    uint8 team_id = 0;
    const char *message = "";

    SetFlagPicker(0);
    m_FlagState = BG_EY_FLAG_STATE_WAIT_RESPAWN;
    Source->RemoveAurasDueToSpell(BG_EY_NETHERSTORM_FLAG_SPELL);

    Source->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);
    if (Source->GetBGTeam() == ALLIANCE)
    {
        PlaySoundToAll(BG_EY_SOUND_FLAG_CAPTURED_ALLIANCE);
        team_id = BG_TEAM_ALLIANCE;
        message = GetTrinityString(LANG_BG_EY_CAPTURED_FLAG_A);
        type = CHAT_MSG_BG_SYSTEM_ALLIANCE;
    }
    else
    {
        PlaySoundToAll(BG_EY_SOUND_FLAG_CAPTURED_HORDE);
        team_id = BG_TEAM_HORDE;
        message = GetTrinityString(LANG_BG_EY_CAPTURED_FLAG_H);
        type = CHAT_MSG_BG_SYSTEM_HORDE;
    }

    SpawnBGObject(BgObjectType, RESPAWN_IMMEDIATELY);

    m_FlagsTimer = BG_EY_FLAG_RESPAWN_TIME;
    m_FlagCapturedBgObjectType = BgObjectType;

    WorldPacket data;
    ChatHandler::FillMessageData(&data, Source->GetSession(), type, LANG_UNIVERSAL, NULL, Source->GetGUID(), message, NULL);
    SendPacketToAll(&data);

    if (m_TeamPointsCount[team_id] > 0)
        AddPoints(Source->GetBGTeam(), BG_EY_FlagPoints[m_TeamPointsCount[team_id] - 1]);

    UpdatePlayerScore(Source, SCORE_FLAG_CAPTURES, 1);
}

void BattleGroundEY::UpdatePlayerScore(Player *Source, uint32 type, uint32 value)
{
    std::map<uint64, BattleGroundScore*>::iterator itr = m_PlayerScores.find(Source->GetGUID());

    if (itr == m_PlayerScores.end())                         // player not found
        return;

    switch (type)
    {
        case SCORE_FLAG_CAPTURES:                           // flags captured
            ((BattleGroundEYScore*)itr->second)->FlagCaptures += value;
            break;
        default:
            BattleGround::UpdatePlayerScore(Source, type, value);
            break;
    }
}

void BattleGroundEY::FillInitialWorldStates(WorldPacket& data)
{
    data << uint32(EY_HORDE_BASE) << uint32(m_TeamPointsCount[BG_TEAM_HORDE]);
    data << uint32(EY_ALLIANCE_BASE) << uint32(m_TeamPointsCount[BG_TEAM_ALLIANCE]);
    data << uint32(0xab6) << uint32(0x0);
    data << uint32(0xab5) << uint32(0x0);
    data << uint32(0xab4) << uint32(0x0);
    data << uint32(0xab3) << uint32(0x0);
    data << uint32(0xab2) << uint32(0x0);
    data << uint32(0xab1) << uint32(0x0);
    data << uint32(0xab0) << uint32(0x0);
    data << uint32(0xaaf) << uint32(0x0);

    data << uint32(DRAENEI_RUINS_HORDE_CONTROL)     << uint32(m_PointOwnedByTeam[DRAENEI_RUINS] == HORDE && m_PointState[DRAENEI_RUINS] == EY_POINT_UNDER_CONTROL);

    data << uint32(DRAENEI_RUINS_ALLIANCE_CONTROL)  << uint32(m_PointOwnedByTeam[DRAENEI_RUINS] == ALLIANCE && m_PointState[DRAENEI_RUINS] == EY_POINT_UNDER_CONTROL);

    data << uint32(DRAENEI_RUINS_UNCONTROL)         << uint32(m_PointState[DRAENEI_RUINS] != EY_POINT_UNDER_CONTROL);

    data << uint32(MAGE_TOWER_ALLIANCE_CONTROL)     << uint32(m_PointOwnedByTeam[MAGE_TOWER] == ALLIANCE && m_PointState[MAGE_TOWER] == EY_POINT_UNDER_CONTROL);

    data << uint32(MAGE_TOWER_HORDE_CONTROL)        << uint32(m_PointOwnedByTeam[MAGE_TOWER] == HORDE && m_PointState[MAGE_TOWER] == EY_POINT_UNDER_CONTROL);

    data << uint32(MAGE_TOWER_UNCONTROL)            << uint32(m_PointState[MAGE_TOWER] != EY_POINT_UNDER_CONTROL);

    data << uint32(FEL_REAVER_HORDE_CONTROL)        << uint32(m_PointOwnedByTeam[FEL_REALVER] == HORDE && m_PointState[FEL_REALVER] == EY_POINT_UNDER_CONTROL);

    data << uint32(FEL_REAVER_ALLIANCE_CONTROL)     << uint32(m_PointOwnedByTeam[FEL_REALVER] == ALLIANCE && m_PointState[FEL_REALVER] == EY_POINT_UNDER_CONTROL);

    data << uint32(FEL_REAVER_UNCONTROL)            << uint32(m_PointState[FEL_REALVER] != EY_POINT_UNDER_CONTROL);

    data << uint32(BLOOD_ELF_HORDE_CONTROL)         << uint32(m_PointOwnedByTeam[BLOOD_ELF] == HORDE && m_PointState[BLOOD_ELF] == EY_POINT_UNDER_CONTROL);

    data << uint32(BLOOD_ELF_ALLIANCE_CONTROL)      << uint32(m_PointOwnedByTeam[BLOOD_ELF] == ALLIANCE && m_PointState[BLOOD_ELF] == EY_POINT_UNDER_CONTROL);

    data << uint32(BLOOD_ELF_UNCONTROL)             << uint32(m_PointState[BLOOD_ELF] != EY_POINT_UNDER_CONTROL);

    data << uint32(NETHERSTORM_FLAG)                << uint32(m_FlagState == BG_EY_FLAG_STATE_ON_BASE);

    data << uint32(0xad2) << uint32(0x1);
    data << uint32(0xad1) << uint32(0x1);
    data << uint32(0xabe) << uint32(GetTeamScore(HORDE));
    data << uint32(0xabd) << uint32(GetTeamScore(ALLIANCE));
    data << uint32(0xa05) << uint32(0x8e);
    data << uint32(0xaa0) << uint32(0x0);
    data << uint32(0xa9f) << uint32(0x0);
    data << uint32(0xa9e) << uint32(0x0);
    data << uint32(0xc0d) << uint32(0x17b);
}

WorldSafeLocsEntry const *BattleGroundEY::GetClosestGraveYard(float x, float y, float z, uint32 team)
{
    WorldSafeLocsEntry const* good_entry = NULL;
    float mindist = 999999.0f;
    for (uint8 i = 0; i < EY_POINTS_MAX; ++i)
    {
        WorldSafeLocsEntry const*entry = sWorldSafeLocsStore.LookupEntry(i+EY_GRAVEYARD_FEL_REALVER);
        if (!entry || !(m_PointOwnedByTeam[i]==team) || !(m_PointState[i]==EY_POINT_UNDER_CONTROL))
            continue;
        float dist = (entry->x - x)*(entry->x - x)+(entry->y - y)*(entry->y - y)+(entry->z - z)*(entry->z - z);
        if (mindist > dist)
        {
            mindist = dist;
            good_entry = entry;
        }
    }
    // If not, place ghost on starting location
    if (!good_entry)
    {
        if (team== ALLIANCE)
        good_entry = sWorldSafeLocsStore.LookupEntry(EY_GRAVEYARD_MAIN_ALLIANCE);
        else
        good_entry = sWorldSafeLocsStore.LookupEntry(EY_GRAVEYARD_MAIN_HORDE);
    }

    return good_entry;
}

