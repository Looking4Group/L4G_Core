/*
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

#ifndef OUTDOOR_PVP_ZM_
#define OUTDOOR_PVP_ZM_

#include "OutdoorPvPImpl.h"
#include "Language.h"

const uint32 OutdoorPvPZMBuffZonesNum = 5;
// the buff is cast in these zones
const uint32 OutdoorPvPZMBuffZones[OutdoorPvPZMBuffZonesNum] = {3521,3607,3717,3715,3716};
// linked when the central tower is controlled
const uint32 ZM_GRAVEYARD_ZONE = 3521;
// linked when the central tower is controlled
const uint32 ZM_GRAVEYARD_ID = 969;

enum OutdoorPvPZMSpells
{
    // cast on the players of the controlling faction
    ZM_CAPTURE_BUFF = 33779,  // twin spire blessing
    // spell that the field scout casts on the player to carry the flag
    ZM_BATTLE_STANDARD_A = 32430,
    // spell that the field scout casts on the player to carry the flag
    ZM_BATTLE_STANDARD_H = 32431,
    // token create spell
    ZM_AlliancePlayerKillReward = 32155,
    // token create spell
    ZM_HordePlayerKillReward = 32158
};

// banners 182527, 182528, 182529, gotta check them ingame
const go_type ZM_Banner_A = { 182527,530,253.54,7083.81,36.7728,-0.017453,0,0,0.008727,-0.999962 };
const go_type ZM_Banner_H = { 182528,530,253.54,7083.81,36.7728,-0.017453,0,0,0.008727,-0.999962 };
const go_type ZM_Banner_N = { 182529,530,253.54,7083.81,36.7728,-0.017453,0,0,0.008727,-0.999962 };

// horde field scout spawn data
const creature_type ZM_HordeFieldScout = {18564,67,530,296.625,7818.4,42.6294,5.18363};
// alliance field scout spawn data
const creature_type ZM_AllianceFieldScout = {18581,469,530,374.395,6230.08,22.8351,0.593412};

enum ZMCreatureTypes{
    ZM_ALLIANCE_FIELD_SCOUT = 0,
    ZM_HORDE_FIELD_SCOUT,
    ZM_CREATURE_NUM
};

struct zm_beacon {
    uint32 slider_disp;
    uint32 slider_n;
    uint32 slider_pos;
    uint32 ui_tower_n;
    uint32 ui_tower_h;
    uint32 ui_tower_a;
    uint32 map_tower_n;
    uint32 map_tower_h;
    uint32 map_tower_a;
    uint32 event_enter;
    uint32 event_leave;
};

enum ZM_BeaconType{
    ZM_BEACON_EAST = 0,
    ZM_BEACON_WEST,
    ZM_NUM_BEACONS
};

const zm_beacon ZMBeaconInfo[ZM_NUM_BEACONS] = {
    {2533,2535,2534,2560,2559,2558,2652,2651,2650,11807,11806},
    {2527,2529,2528,2557,2556,2555,2646,2645,2644,11805,11804}
};

const uint32 ZMBeaconCaptureA[ZM_NUM_BEACONS] = {
    LANG_OPVP_ZM_CAPTURE_EAST_A,
    LANG_OPVP_ZM_CAPTURE_WEST_A
};

const uint32 ZMBeaconCaptureH[ZM_NUM_BEACONS] = {
    LANG_OPVP_ZM_CAPTURE_EAST_H,
    LANG_OPVP_ZM_CAPTURE_WEST_H
};

const uint32 ZMBeaconLooseA[ZM_NUM_BEACONS] = {
    LANG_OPVP_ZM_LOOSE_EAST_A,
    LANG_OPVP_ZM_LOOSE_WEST_A
};

const uint32 ZMBeaconLooseH[ZM_NUM_BEACONS] = {
    LANG_OPVP_ZM_LOOSE_EAST_H,
    LANG_OPVP_ZM_LOOSE_WEST_H
};

const go_type ZMCapturePoints[ZM_NUM_BEACONS] = {
    {182523,530,303.243,6841.36,40.1245,-1.58825,0,0,0.71325,-0.700909},
    {182522,530,336.466,7340.26,41.4984,-1.58825,0,0,0.71325,-0.700909}
};

enum OutdoorPvPZMWorldStates
{
    ZM_UI_TOWER_SLIDER_N_W = 2529,
    ZM_UI_TOWER_SLIDER_POS_W = 2528,
    ZM_UI_TOWER_SLIDER_DISPLAY_W = 2527,

    ZM_UI_TOWER_SLIDER_N_E = 2535,
    ZM_UI_TOWER_SLIDER_POS_E = 2534,
    ZM_UI_TOWER_SLIDER_DISPLAY_E = 2533,

    ZM_WORLDSTATE_UNK_1 = 2653,

    ZM_UI_TOWER_EAST_N = 2560,
    ZM_UI_TOWER_EAST_H = 2559,
    ZM_UI_TOWER_EAST_A = 2558,
    ZM_UI_TOWER_WEST_N = 2557,
    ZM_UI_TOWER_WEST_H = 2556,
    ZM_UI_TOWER_WEST_A = 2555,

    ZM_MAP_TOWER_EAST_N = 2652,
    ZM_MAP_TOWER_EAST_H = 2651,
    ZM_MAP_TOWER_EAST_A = 2650,
    ZM_MAP_GRAVEYARD_H = 2649,
    ZM_MAP_GRAVEYARD_A = 2648,
    ZM_MAP_GRAVEYARD_N = 2647,
    ZM_MAP_TOWER_WEST_N = 2646,
    ZM_MAP_TOWER_WEST_H = 2645,
    ZM_MAP_TOWER_WEST_A = 2644,

    ZM_MAP_HORDE_FLAG_READY = 2658,
    ZM_MAP_HORDE_FLAG_NOT_READY = 2657,
    ZM_MAP_ALLIANCE_FLAG_NOT_READY = 2656,
    ZM_MAP_ALLIANCE_FLAG_READY = 2655
};

enum ZM_TowerStateMask{
    ZM_TOWERSTATE_N = 1,
    ZM_TOWERSTATE_A = 2,
    ZM_TOWERSTATE_H = 4
};

class OutdoorPvPZM;
class OPvPCapturePointZM_Beacon : public OPvPCapturePoint
{
friend class OutdoorPvPZM;
public:
    OPvPCapturePointZM_Beacon(OutdoorPvP * pvp, ZM_BeaconType type);
    void ChangeState();
    void SendChangePhase();
    void FillInitialWorldStates(WorldPacket & data);
    // used when player is activated/inactivated in the area
    bool HandlePlayerEnter(Player * plr);
    void HandlePlayerLeave(Player * plr);
    void UpdateTowerState();
protected:
    ZM_BeaconType m_TowerType;
    uint32 m_TowerState;
};

enum ZM_GraveYardState{
    ZM_GRAVEYARD_N = 1,
    ZM_GRAVEYARD_A = 2,
    ZM_GRAVEYARD_H = 4
};

class OPvPCapturePointZM_GraveYard : public OPvPCapturePoint
{
friend class OutdoorPvPZM;
public:
    OPvPCapturePointZM_GraveYard(OutdoorPvP * pvp);
    bool Update(uint32 diff);
    void ChangeState() {}
    void FillInitialWorldStates(WorldPacket & data);
    void UpdateTowerState();
    int32 HandleOpenGo(Player *plr, uint64 guid);
    void SetBeaconState(uint32 controlling_team); // not good atm
    bool HandleGossipOption(Player * plr, uint64 guid, uint32 gossipid);
    bool HandleDropFlag(Player * plr, uint32 spellId);
    bool CanTalkTo(Player * plr, Creature * c, GossipOption &gso);
private:
    uint32 m_GraveYardState;
protected:
    uint32 m_BothControllingFaction;
    uint64 m_FlagCarrierGUID;
};

class OutdoorPvPZM : public OutdoorPvP
{
friend class OPvPCapturePointZM_Beacon;
public:
    OutdoorPvPZM();
    bool SetupOutdoorPvP();
    void HandlePlayerEnterZone(Player *plr, uint32 zone);
    void HandlePlayerLeaveZone(Player *plr, uint32 zone);
    bool Update(uint32 diff);
    void FillInitialWorldStates(WorldPacket &data);
    void SendRemoveWorldStates(Player * plr);
    void HandleKillImpl(Player * plr, Unit * killed);
private:
    OPvPCapturePointZM_GraveYard * m_GraveYard;
    uint32 m_AllianceTowersControlled;
    uint32 m_HordeTowersControlled;
};

// todo: flag carrier death/leave/mount/activitychange should give back the gossip options
#endif

