/*
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * Copyright (C) 2008-2009 Trinity <http://www.trinitycore.org/>
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

#include "Creature.h"
#include "CreatureGroups.h"
#include "ObjectMgr.h"
#include "ProgressBar.h"
#include "CreatureAI.h"

#define MAX_DESYNC 5.0f

CreatureGroupInfoType   CreatureGroupMap;

void CreatureGroupManager::AddCreatureToGroup(uint32 groupId, Creature *member)
{
    Map *map = member->GetMap();
    if (!map)
        return;

    CreatureGroupHolderType::iterator itr = map->CreatureGroupHolder.find(groupId);

    //Add member to an existing group
    if (itr != map->CreatureGroupHolder.end())
    {
        sLog.outDebug("Group found: %u, inserting creature GUID: %u, Group InstanceID %u", groupId, member->GetGUIDLow(), member->GetInstanceId());
        itr->second->AddMember(member);
    }
    //Create new group
    else
    {
        sLog.outDebug("Group not found: %u. Creating new group.", groupId);
        CreatureGroup* group = new CreatureGroup(groupId);
        map->CreatureGroupHolder[groupId] = group;
        group->AddMember(member);
    }
}

void CreatureGroupManager::RemoveCreatureFromGroup(CreatureGroup *group, Creature *member)
{
    sLog.outDebug("Deleting member pointer to GUID: %u from group %u", group->GetId(), member->GetDBTableGUIDLow());
    group->RemoveMember(member);

    if (group->isEmpty())
    {
        Map *map = member->GetMap();
        if (!map)
            return;

        sLog.outDebug("Deleting group with InstanceID %u", member->GetInstanceId());
        map->CreatureGroupHolder.erase(group->GetId());
        delete group;
    }
}

void CreatureGroupManager::LoadCreatureFormations()
{
    //Clear existing map
    CreatureGroupMap.clear();

    //Check Integrity of the table
    QueryResultAutoPtr result = GameDataDatabase.PQuery("SELECT MAX(`leaderGUID`) FROM `creature_formations`");

    if (!result)
    {
        sLog.outLog(LOG_DB_ERR, " ...an error occured while loading the table `creature_formations` (maybe it doesn't exist ?)\n");
        return;
    }

    //Get group data
    result = GameDataDatabase.PQuery("SELECT `leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI` FROM `creature_formations` ORDER BY `leaderGUID`");

    if (!result)
    {
        sLog.outLog(LOG_DB_ERR, "The table `creature_formations` is empty or corrupted");
        return;
    }

    uint32 total_records = result->GetRowCount();
    BarGoLink bar(total_records);
    Field *fields;

    FormationInfo *group_member;
    //Loading data...
    do
    {
        fields = result->Fetch();

        bar.step();
        //Load group member data
        group_member                        = new FormationInfo;
        group_member->leaderGUID            = fields[0].GetUInt32();
        uint32 memberGUID                   = fields[1].GetUInt32();
        group_member->groupAI                = fields[4].GetUInt8();
        //If creature is group leader we may skip loading of dist/angle
        if (group_member->leaderGUID != memberGUID)
        {
            group_member->follow_dist            = fields[2].GetUInt32();
            group_member->follow_angle            = fields[3].GetFloat();
        }

        // check data correctness
        const CreatureData* leader = sObjectMgr.GetCreatureData(group_member->leaderGUID);
        const CreatureData* member = sObjectMgr.GetCreatureData(memberGUID);
        if (!leader || !member || leader->mapid != member->mapid)
        {
            sLog.outLog(LOG_DB_ERR, "Table `creature_formations` has an invalid record (leaderGUID: '%u', memberGUID: '%u')", group_member->leaderGUID, memberGUID);
            delete group_member;
            continue;
        }

        CreatureGroupMap[memberGUID] = group_member;
    }
    while (result->NextRow()) ;

    sLog.outString();
    sLog.outString(">> Loaded %u creatures in formations", total_records);
    sLog.outString();
}

void CreatureGroup::AddMember(Creature *member)
{
    sLog.outDebug("CreatureGroup::AddMember: Adding unit GUIDLow: %u.", member->GetGUIDLow());

    //Check if it is a leader
    if (member->GetDBTableGUIDLow() == m_groupID)
    {
        sLog.outDebug("Unit GUID: %u is formation leader. Adding group.", member->GetGUIDLow());
        m_leader = member;
    }

    CreatureGroupInfoType::iterator iter = CreatureGroupMap.find(member->GetDBTableGUIDLow());

    m_members[member->GetGUID()] = iter->second;
    member->SetFormation(this);
}

void CreatureGroup::RemoveMember(Creature *member)
{
    if (m_leader == member)
        m_leader = NULL;

    if (member->GetGUID())
        m_members.erase(member->GetGUID());
    member->SetFormation(NULL);
}

void CreatureGroup::MemberAttackStart(Creature *member, Unit *target)
{
    if (!member || !target)
        return;

    const CreatureGroupInfoType::iterator fInfo = CreatureGroupMap.find(member->GetDBTableGUIDLow());
    if (fInfo == CreatureGroupMap.end() || !fInfo->second)
        return;

    uint8 groupAI = fInfo->second->groupAI;
    if (!groupAI)
        return;

    if (groupAI == 1 && member != m_leader)
        return;

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        sLog.outDebug("GROUP ATTACK: group instance id %u calls member instid %u", m_leader ? m_leader->GetInstanceId() : 0, member->GetInstanceId());
        //sLog.outDebug("AI:%u:Group member found: %u, attacked by %s.", groupAI, itr->second->GetGUIDLow(), member->getVictim()->GetName());

        //Skip one check
        if (itr->first == member->GetGUID())
            continue;

        if (Creature *mem = member->GetMap()->GetCreature(itr->first))
        {
            if (!mem->isAlive())
                continue;

            if (mem->getVictim())
                continue;

            if (mem->canAttack(target))
                mem->AI()->AttackStart(target);
        }
    }

    m_Respawned = false;
    m_Evaded = false;
}

void CreatureGroup::FormationReset(bool dismiss)
{
    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        if (itr->first != m_leader->GetGUID())
        {
            if (Creature *mem = m_leader->GetMap()->GetCreature(itr->first))
            {
                if (!mem->isAlive() || mem->isInCombat())
                    continue;

                if (dismiss)
                    mem->GetMotionMaster()->Initialize();
                else
                    mem->GetMotionMaster()->MoveIdle();

                sLog.outDebug("Set %s movement for member GUID: %u", dismiss ? "default" : "idle", mem->GetGUIDLow());
            }
        }
    }
    m_Formed = !dismiss;
}

void CreatureGroup::RespawnFormation(Creature *member)
{
    if(!member || m_Respawned)
        return;

    m_Respawned = true;

    if (Map* map = member->GetMap())
    {
        for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
        {
            // Called at EnterEvadeMode, do not check self
            if (itr->first == member->GetGUID())
                continue;

            if (Creature* mem = map->GetCreature(itr->first))
            {
                if (mem->isAlive())
                    continue;

                if (map->IsDungeon() && (map->IsRaid() || map->IsHeroic()))
                    if (mem->GetCreatureInfo()->flags_extra & CREATURE_FLAG_EXTRA_INSTANCE_BIND)
                        continue;

                mem->Respawn();
            }
        }
    }
}

void CreatureGroup::EvadeFormation(Creature *member)
{
    if (!member || m_Evaded)
        return;

    m_Evaded = true;
    RespawnFormation(member);

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        // Called at EnterEvadeMode, do not check self
        if (itr->first == member->GetGUID())
            continue;

        if (Creature *mem = member->GetMap()->GetCreature(itr->first))
            mem->AI()->EnterEvadeMode();
    }
}

void CreatureGroup::LeaderMoveTo(float x, float y, float z)
{
    m_movingUnits = 0;
    if (!m_leader)
        return;

    float pathangle = atan2(m_leader->GetPositionY() - y, m_leader->GetPositionX() - x);

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        Creature *member = m_leader->GetMap()->GetCreature(itr->first);
        if (!member || member == m_leader || !member->isAlive() || member->getVictim())
            continue;

        float angle = itr->second->follow_angle;
        float dist = itr->second->follow_dist;

        // if follow distance is 0 then don't follow leader
        if (!dist)
            continue;

        float dx = x + cos(angle + pathangle) * dist;
        float dy = y + sin(angle + pathangle) * dist;
        float dz = z;

        Looking4group::NormalizeMapCoord(dx);
        Looking4group::NormalizeMapCoord(dy);

        member->UpdateGroundPositionZ(dx, dy, dz);

        if (member->IsWithinDistInMap(m_leader, dist + MAX_DESYNC))
        {
            uint32 moveFlags = m_leader->GetUnitMovementFlags();
            if (!member->m_movementInfo.HasMovementFlag(MOVEFLAG_SPLINE_ENABLED))
                moveFlags &= ~MOVEFLAG_SPLINE_ENABLED;

            member->SetUnitMovementFlags(moveFlags);
        }
        else
        {
            // jak sie za bardzo rozjada xO
            if (!member->IsWithinDistInMap(m_leader, 40.0f))
                member->NearTeleportTo(m_leader->GetPositionX(), m_leader->GetPositionY(), m_leader->GetPositionZ(), 0.0f);
            else
                member->SetWalk(false);
        }

        member->GetMotionMaster()->MovePoint(0, dx, dy, dz, true, true, UNIT_ACTION_HOME);
        member->SetHomePosition(m_leader->GetPositionX(), m_leader->GetPositionY(), m_leader->GetPositionZ(), pathangle);
        m_movingUnits++;
    }
}

Creature* CreatureGroup::GetNextRandomCreatureGroupMember(Creature* member, float radius)
{
    std::vector<Creature*> nearMembers;
    nearMembers.reserve(m_members.size()*2);

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        if (Creature *mem = member->GetMap()->GetCreature(itr->first))
        {
            // IsHostileTo check controlled by enemy
            if (itr->first != member->GetGUID() && member->IsWithinDistInMap(mem, radius)
            && !member->IsHostileTo(mem) && mem->isAlive() && !mem->HasAuraType(SPELL_AURA_MOD_UNATTACKABLE))
                nearMembers.push_back(mem);
        }
    }

    if (nearMembers.empty())
        return NULL;

    uint32 randTarget = urand(0,nearMembers.size()-1);
    return nearMembers[randTarget];
}
