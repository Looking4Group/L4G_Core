/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Westfall
SD%Complete: 90
SDComment: Quest support: 155
SDCategory: Westfall
EndScriptData */

/* ContentData
npc_defias_traitor
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"

/*#####
# npc_daphne_stilwell
######*/

//Quest
#define QUEST_PROTECT_DAPHNE 1651

//Paths
#define PATH_FIRST 1651
#define PATH_SECOND 1652

//Thug definitions
#define DEFIAS_RAIDER 6180

#define THUG_SPAWN_X -11443
#define THUG_SPAWN_Y 1581
#define THUG_SPAWN_Z 59.018
#define THUG_SPAWN_O 4.164382
#define THUG_SPAWN_R  5

//Speech
#define SAY_KILL_HER "Kill her! Take the farm!"
#define SAY_MOVE "To the house! Stay close to me no matter what! I have my gun and ammo there!"
#define SAY_BEGIN "You won't ruin my lands, you scum!"
#define SAY_WAVE "One more down!"
#define SAY_END "We've done it, we won!"
#define SAY_MOVE_BACK "Meet me at the orchad--I just need to put my gun away."

struct npc_daphne_stilwellAI : public npc_escortAI
{
    npc_daphne_stilwellAI(Creature *c) : npc_escortAI(c)
    {
        SetVariables();
    }


    std::vector<uint64> enemies;
    uint8 thug_wave;
    bool IsWalking;
    bool initial_movement;
    bool real_event_started;
    bool yeller_spawned;
    bool say_end;

    void SetVariables()
    {
        thug_wave = 0;
        initial_movement = true;
        real_event_started = false;
        yeller_spawned = false;
        IsWalking = false;
        say_end = false;
    }

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();

        if (!player)
            return;

        if (IsWalking && !m_creature->IsWalking())
            m_creature->SetWalk(true);

        switch (i)
        {
        case 0:
            SetVariables();
            break;
        case 3:
            if (!yeller_spawned)
            {
                Creature *yeller = m_creature->SummonCreature(DEFIAS_RAIDER, THUG_SPAWN_X, THUG_SPAWN_Y, THUG_SPAWN_Z, THUG_SPAWN_O, TEMPSUMMON_TIMED_DESPAWN, 3000);
                yeller->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                yeller->Yell(SAY_KILL_HER, LANG_UNIVERSAL, 0);
                yeller_spawned = true;
            }
            break;
        case 5:
            real_event_started = true;
            NextEvent();
            break;
        case 6:
            IsWalking = true;
            break;
        case 11:
            if (thug_wave > 3)
            {
                player->CompleteQuest(QUEST_PROTECT_DAPHNE);
            }
            if (player && player->GetTypeId() == TYPEID_PLAYER)
                ((Player*)player)->GroupEventHappens(QUEST_PROTECT_DAPHNE,m_creature);

            m_creature->GetMotionMaster()->MovementExpired();
            m_creature->GetMotionMaster()->MoveTargetedHome();
            SetVariables();
            break;
        }
    }

    void EnterCombat(Unit* who){}

    void Reset()
    {
        if (IsWalking && !m_creature->IsWalking())
        {
            m_creature->SetWalk(true);
            return;
        }
        IsWalking = false;
    }

    void JustDied(Unit* killer)
    {
        if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_PROTECT_DAPHNE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (real_event_started)
        {
            if (initial_movement)
            {
                DoYell(SAY_BEGIN, LANG_UNIVERSAL, NULL);
                initial_movement = false;
            }

            Player* player = GetPlayerForEscort();
            if (player)
            {
                if(player->isDead())
                {
                    player->FailQuest(QUEST_PROTECT_DAPHNE);
                    SetVariables();
                }

                if(m_creature->isDead() && player)
                    player->FailQuest(QUEST_PROTECT_DAPHNE);
            }

            UpdateEvent(diff);
        }

        npc_escortAI::UpdateAI(diff);
    }

    void UpdateEvent(uint32 diff)
    {
        if(!thug_wave)
            return;

        if(enemies.empty())
            NextEvent();

        bool alldead = true;

        for(std::vector<uint64>::iterator itr = enemies.begin(), next; itr!= enemies.end(); ++itr)
        {
            Unit *enemy = Unit::GetUnit(*m_creature, *itr);
            if(enemy && enemy->isAlive())
            {
                alldead = false;
            }
        }

        if(alldead)
            enemies.clear();
    }

    void NextEvent()
    {
        thug_wave++;

        if(thug_wave > 3 && !say_end)
        {
            DoSay(SAY_END, LANG_UNIVERSAL, NULL);
            m_creature->HandleEmoteCommand(4);
            DoSay(SAY_MOVE_BACK, LANG_UNIVERSAL, NULL, true);
            say_end = true;
            real_event_started = false;
        }
        else
        {
            if(thug_wave!=1)
                DoSay(SAY_WAVE, LANG_UNIVERSAL, NULL);
            ActivateAmbush(DEFIAS_RAIDER, 2 + thug_wave, THUG_SPAWN_R, THUG_SPAWN_X, THUG_SPAWN_Y, THUG_SPAWN_Z, THUG_SPAWN_O, &enemies);
        }
    }

    void ActivateAmbush(uint32 creature_id, uint32 count, uint32 spawn_radius, float x, float y, float z, float o, std::vector<uint64> *store)
    {
        for( ; count > 0; count--)
        {
            float posX, posY, posZ;
            m_creature->GetRandomPoint(x,y,z,spawn_radius, posX, posY, posZ);
            Creature *attacker = m_creature->SummonCreature(creature_id, posX, posY, posZ, o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
            if(attacker)
            {
                attacker->setActive(true);
                attacker->AI()->AttackStart(m_creature);

                store->push_back(attacker->GetGUID());
            }
        }
    }
};

bool QuestAccept_npc_daphne_stilwell(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_PROTECT_DAPHNE)
    {
        if (npc_escortAI* pEscortAI = CAST_AI(npc_daphne_stilwellAI, creature->AI()))
        {
            pEscortAI->Start(true, true, player->GetGUID(), quest);
            pEscortAI->DoSay(SAY_MOVE, LANG_UNIVERSAL, NULL);
        }
    }

    return true;
}

CreatureAI* GetAI_npc_daphne_stilwell(Creature *_Creature)
{
    npc_daphne_stilwellAI* thisAI = new npc_daphne_stilwellAI(_Creature);

    thisAI->AddWaypoint(0, -11466.4, 1530.26, 50.2492);
    thisAI->AddWaypoint(1, -11463.2, 1525.15, 50.9378);
    thisAI->AddWaypoint(2, -11460.5, 1526.95, 50.9395);
    thisAI->AddWaypoint(3, -11463.2, 1525.15, 50.9378);
    thisAI->AddWaypoint(4, -11466.4, 1530.26, 50.2492);
    thisAI->AddWaypoint(5, -11461.2, 1539.06, 52.259, 20000);
    thisAI->AddWaypoint(6, -11466.4, 1530.26, 50.2492);
    thisAI->AddWaypoint(7, -11463.2, 1525.15, 50.9378);
    thisAI->AddWaypoint(8, -11460.5, 1526.95, 50.9395);
    thisAI->AddWaypoint(9, -11463.2, 1525.15, 50.9378);
    thisAI->AddWaypoint(10, -11466.4, 1530.26, 50.2492);
    thisAI->AddWaypoint(11, -11480.7, 1551.8, 49.2635);

    return (CreatureAI*)thisAI;
}

/*######
## npc_defias_traitor
######*/


#define SAY_START                   -1000101
#define SAY_PROGRESS                -1000102
#define SAY_END_TRAITOR             -1000103
#define SAY_AGGRO_1                 -1000104
#define SAY_AGGRO_2                 -1000105

#define QUEST_DEFIAS_BROTHERHOOD    155

struct npc_defias_traitorAI : public npc_escortAI
{
    npc_defias_traitorAI(Creature *c) : npc_escortAI(c) {}

    bool IsWalking;

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();

        if (!player || player->GetTypeId() != TYPEID_PLAYER)
            return;

        switch (i)
        {
            case 35:
                SetRun(false);
                break;
            case 36:
                DoScriptText(SAY_PROGRESS, m_creature, player);
                break;
            case 44:
                DoScriptText(SAY_END_TRAITOR, m_creature, player);
                {
                    ((Player*)player)->GroupEventHappens(QUEST_DEFIAS_BROTHERHOOD,m_creature);
                }
                break;
        }
    }
    void EnterCombat(Unit* who)
    {
        DoScriptText(RAND(SAY_AGGRO_1, SAY_AGGRO_2), m_creature, who);
    }

    void Reset(){}

    void JustDied(Unit* killer)
    {
        if (Player* player = GetPlayerForEscort())
            player->FailQuest(QUEST_DEFIAS_BROTHERHOOD);
    }

    void UpdateAI(const uint32 diff)
    {
        npc_escortAI::UpdateAI(diff);
    }
};

bool QuestAccept_npc_defias_traitor(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_DEFIAS_BROTHERHOOD)
    {
        if (npc_escortAI* pEscortAI = CAST_AI(npc_defias_traitorAI, creature->AI()))
            pEscortAI->Start(true, true, player->GetGUID(), quest, true);
        DoScriptText(SAY_START, creature, player);
    }

    return true;
}

CreatureAI* GetAI_npc_defias_traitor(Creature *_Creature)
{
    npc_defias_traitorAI* thisAI = new npc_defias_traitorAI(_Creature);

    thisAI->AddWaypoint(0, -10508.40, 1068.00, 55.21);
    thisAI->AddWaypoint(1, -10518.30, 1074.84, 53.96);
    thisAI->AddWaypoint(2, -10534.82, 1081.92, 49.88);
    thisAI->AddWaypoint(3, -10546.51, 1084.88, 50.13);
    thisAI->AddWaypoint(4, -10555.29, 1084.45, 45.75);
    thisAI->AddWaypoint(5, -10566.57, 1083.53, 42.10);
    thisAI->AddWaypoint(6, -10575.83, 1082.34, 39.46);
    thisAI->AddWaypoint(7, -10585.67, 1081.08, 37.77);
    thisAI->AddWaypoint(8, -10600.08, 1078.19, 36.23);
    thisAI->AddWaypoint(9, -10608.69, 1076.08, 35.88);
    thisAI->AddWaypoint(10, -10621.26, 1073.00, 35.40);
    thisAI->AddWaypoint(11, -10638.12, 1060.18, 33.61);
    thisAI->AddWaypoint(12, -10655.87, 1038.99, 33.48);
    thisAI->AddWaypoint(13, -10664.68, 1030.54, 32.70);
    thisAI->AddWaypoint(14, -10708.68, 1033.86, 33.32);
    thisAI->AddWaypoint(15, -10754.43, 1017.93, 32.79);
    thisAI->AddWaypoint(16, -10802.26, 1018.01, 32.16);
    thisAI->AddWaypoint(17, -10832.60, 1009.04, 32.71);
    thisAI->AddWaypoint(18, -10866.56, 1006.51, 31.71);     // Fix waypoints from roughly this point, test first to get proper one
    thisAI->AddWaypoint(19, -10879.98, 1005.10, 32.84);
    thisAI->AddWaypoint(20, -10892.45, 1001.32, 34.46);
    thisAI->AddWaypoint(21, -10906.14, 997.11, 36.15);
    thisAI->AddWaypoint(22, -10922.26, 1002.23, 35.74);
    thisAI->AddWaypoint(23, -10936.32, 1023.38, 36.52);
    thisAI->AddWaypoint(24, -10933.35, 1052.61, 35.85);
    thisAI->AddWaypoint(25, -10940.25, 1077.66, 36.49);
    thisAI->AddWaypoint(26, -10957.09, 1099.33, 36.83);
    thisAI->AddWaypoint(27, -10956.53, 1119.90, 36.73);
    thisAI->AddWaypoint(28, -10939.30, 1150.75, 37.42);
    thisAI->AddWaypoint(29, -10915.14, 1202.09, 36.55);
    thisAI->AddWaypoint(30, -10892.59, 1257.03, 33.37);
    thisAI->AddWaypoint(31, -10891.93, 1306.66, 35.45);
    thisAI->AddWaypoint(32, -10896.17, 1327.86, 37.77);
    thisAI->AddWaypoint(33, -10906.03, 1368.05, 40.91);
    thisAI->AddWaypoint(34, -10910.18, 1389.33, 42.62);
    thisAI->AddWaypoint(35, -10915.42, 1417.72, 42.93);
    thisAI->AddWaypoint(36, -10926.37, 1421.18, 43.04);     // walk here and say
    thisAI->AddWaypoint(37, -10952.31, 1421.74, 43.40);
    thisAI->AddWaypoint(38, -10980.04, 1411.38, 42.79);
    thisAI->AddWaypoint(39, -11006.06, 1420.47, 43.26);
    thisAI->AddWaypoint(40, -11021.98, 1450.59, 43.09);
    thisAI->AddWaypoint(41, -11025.36, 1491.59, 43.15);
    thisAI->AddWaypoint(42, -11036.09, 1508.32, 43.28);
    thisAI->AddWaypoint(43, -11060.68, 1526.72, 43.19);
    thisAI->AddWaypoint(44, -11072.75, 1527.77, 43.20, 5000);// say and quest credit

    return (CreatureAI*)thisAI;
}

//#####
//# NPC Mikhail - q 1249
//########

bool QuestAccept_npc_Mikhail(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == 1249)
    {
        if(Creature* trigger = GetClosestCreatureWithEntry(creature, 4962, 10))
        {
            trigger->setFaction(14);
            trigger->Attack(player, true);
            trigger->GetMotionMaster()->MoveChase(player, 0, 0);
        }
    }

    return true;
}

void AddSC_westfall()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_daphne_stilwell";
    newscript->GetAI = &GetAI_npc_daphne_stilwell;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_daphne_stilwell;
    newscript->RegisterSelf();


    newscript = new Script;
    newscript->Name="npc_defias_traitor";
    newscript->GetAI = &GetAI_npc_defias_traitor;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_defias_traitor;
    newscript->RegisterSelf();


    newscript = new Script;
    newscript->Name = "npc_Mikhail";
    newscript->pQuestAcceptNPC = &QuestAccept_npc_Mikhail;
    newscript->RegisterSelf();
}

