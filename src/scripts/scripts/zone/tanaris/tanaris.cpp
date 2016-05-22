/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Tanaris
SD%Complete: 80
SDComment: Quest support: 648, 1560, 2882, 2954, 4005, 10277, 10279(Special flight path). Noggenfogger vendor
SDCategory: Tanaris
EndScriptData */

/* ContentData
mob_aquementas
npc_custodian_of_time
npc_marin_noggenfogger
npc_steward_of_time
npc_stone_watcher_of_norgannon
npc_OOX17
go_landmark_treasure
npc_tooga
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"
#include "follower_ai.h"

/*######
## mob_aquementas
######*/

#define AGGRO_YELL_AQUE     -1000350

#define SPELL_AQUA_JET      13586
#define SPELL_FROST_SHOCK   15089

struct mob_aquementasAI : public ScriptedAI
{
    mob_aquementasAI(Creature *c) : ScriptedAI(c) {}

    uint32 SendItem_Timer;
    uint32 SwitchFaction_Timer;
    bool isFriendly;

    uint32 FrostShock_Timer;
    uint32 AquaJet_Timer;

    void Reset()
    {
        SendItem_Timer = 0;
        SwitchFaction_Timer = 10000;
        me->setFaction(35);
        isFriendly = true;

        AquaJet_Timer = 5000;
        FrostShock_Timer = 1000;
    }

    void SendItem(Unit* receiver)
    {
        if (CAST_PLR(receiver)->HasItemCount(11169,1,false) &&
            CAST_PLR(receiver)->HasItemCount(11172,11,false) &&
            CAST_PLR(receiver)->HasItemCount(11173,1,false) &&
            !CAST_PLR(receiver)->HasItemCount(11522,1,true))
        {
            ItemPosCountVec dest;
            uint8 msg = CAST_PLR(receiver)->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 11522, 1);
            if (msg == EQUIP_ERR_OK)
                CAST_PLR(receiver)->StoreNewItem(dest, 11522, 1, true);
        }
    }

    void EnterCombat(Unit* who)
    {
        DoScriptText(AGGRO_YELL_AQUE, me, who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (isFriendly)
        {
            if (SwitchFaction_Timer <= diff)
            {
                me->setFaction(91);
                isFriendly = false;
            } else SwitchFaction_Timer -= diff;
        }

        if (!UpdateVictim())
            return;

        if (!isFriendly)
        {
            if (SendItem_Timer <= diff)
            {
                if (me->getVictim()->GetTypeId() == TYPEID_PLAYER)
                    SendItem(me->getVictim());
                SendItem_Timer = 5000;
            } else SendItem_Timer -= diff;
        }

        if (FrostShock_Timer <= diff)
        {
            DoCast(me->getVictim(), SPELL_FROST_SHOCK);
            FrostShock_Timer = 15000;
        } else FrostShock_Timer -= diff;

        if (AquaJet_Timer <= diff)
        {
            DoCast(me, SPELL_AQUA_JET);
            AquaJet_Timer = 15000;
        } else AquaJet_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_mob_aquementas(Creature* pCreature)
{
    return new mob_aquementasAI (pCreature);
}

/*######
## npc_custodian_of_time
######*/

#define WHISPER_CUSTODIAN_1     -1000150
#define WHISPER_CUSTODIAN_2     -1000151
#define WHISPER_CUSTODIAN_3     -1000152
#define WHISPER_CUSTODIAN_4     -1000153
#define WHISPER_CUSTODIAN_5     -1000154
#define WHISPER_CUSTODIAN_6     -1000155
#define WHISPER_CUSTODIAN_7     -1000156
#define WHISPER_CUSTODIAN_8     -1000157
#define WHISPER_CUSTODIAN_9     -1000158
#define WHISPER_CUSTODIAN_10    -1000159
#define WHISPER_CUSTODIAN_11    -1000160
#define WHISPER_CUSTODIAN_12    -1000161
#define WHISPER_CUSTODIAN_13    -1000162
#define WHISPER_CUSTODIAN_14    -1000163

struct npc_custodian_of_timeAI : public npc_escortAI
{
    npc_custodian_of_timeAI(Creature *c) : npc_escortAI(c) {}

    void WaypointReached(uint32 i)
    {
        Player *pPlayer = GetPlayerForEscort();
        if (!pPlayer)
            return;

        switch(i)
        {
            case 0: DoScriptText(WHISPER_CUSTODIAN_1, me, pPlayer); break;
            case 1: DoScriptText(WHISPER_CUSTODIAN_2, me, pPlayer); break;
            case 2: DoScriptText(WHISPER_CUSTODIAN_3, me, pPlayer); break;
            case 3: DoScriptText(WHISPER_CUSTODIAN_4, me, pPlayer); break;
            case 5: DoScriptText(WHISPER_CUSTODIAN_5, me, pPlayer); break;
            case 6: DoScriptText(WHISPER_CUSTODIAN_6, me, pPlayer); break;
            case 7: DoScriptText(WHISPER_CUSTODIAN_7, me, pPlayer); break;
            case 8: DoScriptText(WHISPER_CUSTODIAN_8, me, pPlayer); break;
            case 9: DoScriptText(WHISPER_CUSTODIAN_9, me, pPlayer); break;
            case 10: DoScriptText(WHISPER_CUSTODIAN_4, me, pPlayer); break;
            case 13: DoScriptText(WHISPER_CUSTODIAN_10, me, pPlayer); break;
            case 14: DoScriptText(WHISPER_CUSTODIAN_4, me, pPlayer); break;
            case 16: DoScriptText(WHISPER_CUSTODIAN_11, me, pPlayer); break;
            case 17: DoScriptText(WHISPER_CUSTODIAN_12, me, pPlayer); break;
            case 18: DoScriptText(WHISPER_CUSTODIAN_4, me, pPlayer); break;
            case 22: DoScriptText(WHISPER_CUSTODIAN_13, me, pPlayer); break;
            case 23: DoScriptText(WHISPER_CUSTODIAN_4, me, pPlayer); break;
            case 24:
                DoScriptText(WHISPER_CUSTODIAN_14, me, pPlayer);
                DoCast(pPlayer, 34883);
                // below here is temporary workaround, to be removed when spell works properly
                pPlayer->AreaExploredOrEventHappens(10277);
                break;
        }
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (HasEscortState(STATE_ESCORT_ESCORTING))
            return;

        if (who->GetTypeId() == TYPEID_PLAYER)
        {
            if (who->HasAura(34877,1) && CAST_PLR(who)->GetQuestStatus(10277) == QUEST_STATUS_INCOMPLETE)
            {
                float Radius = 10.0;
                if (me->IsWithinDistInMap(who, Radius))
                {
                    Start(false, false, who->GetGUID());
                }
            }
        }
    }

    void EnterCombat(Unit* /*who*/) {}
    void Reset() { }

    void UpdateAI(const uint32 diff)
    {
        npc_escortAI::UpdateAI(diff);
    }
};

CreatureAI* GetAI_npc_custodian_of_time(Creature* pCreature)
{
    return new npc_custodian_of_timeAI(pCreature);
}

/*######
## npc_marin_noggenfogger
######*/

bool GossipHello_npc_marin_noggenfogger(Player* pPlayer, Creature* pCreature)
{
    if (pCreature->isQuestGiver())
        pPlayer->PrepareQuestMenu(pCreature->GetGUID());

    if (pCreature->isVendor() && pPlayer->GetQuestRewardStatus(2662))
        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

    pPlayer->SEND_GOSSIP_MENU(pCreature->GetNpcTextId(), pCreature->GetGUID());

    return true;
}

bool GossipSelect_npc_marin_noggenfogger(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
{
    if (uiAction == GOSSIP_ACTION_TRADE)
        pPlayer->SEND_VENDORLIST(pCreature->GetGUID());

    return true;
}

/*######
## npc_steward_of_time
######*/

#define GOSSIP_ITEM_FLIGHT  "Please take me to the master's lair."

bool GossipHello_npc_steward_of_time(Player* pPlayer, Creature* pCreature)
{
    if (pCreature->isQuestGiver())
        pPlayer->PrepareQuestMenu(pCreature->GetGUID());

    if (pPlayer->GetQuestStatus(10279) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestRewardStatus(10279))
    {
        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_FLIGHT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        pPlayer->SEND_GOSSIP_MENU(9978, pCreature->GetGUID());
    }
    else
        pPlayer->SEND_GOSSIP_MENU(9977, pCreature->GetGUID());

    return true;
}

bool QuestAccept_npc_steward_of_time(Player* pPlayer, Creature* /*pCreature*/, Quest const *quest)
{
    if (quest->GetQuestId() == 10279)                      //Quest: To The Master's Lair
        pPlayer->CastSpell(pPlayer,34891,true);               //(Flight through Caverns)

    return false;
}

bool GossipSelect_npc_steward_of_time(Player* pPlayer, Creature* /*pCreature*/, uint32 /*uiSender*/, uint32 uiAction)
{
    if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        pPlayer->CastSpell(pPlayer,34891,true);               //(Flight through Caverns)

    return true;
}

/*######
## npc_stone_watcher_of_norgannon
######*/

#define GOSSIP_ITEM_NORGANNON_1     "What function do you serve?"
#define GOSSIP_ITEM_NORGANNON_2     "What are the Plates of Uldum?"
#define GOSSIP_ITEM_NORGANNON_3     "Where are the Plates of Uldum?"
#define GOSSIP_ITEM_NORGANNON_4     "Excuse me? We've been \"reschedueled for visitations\"? What does that mean?!"
#define GOSSIP_ITEM_NORGANNON_5     "So, what's inside Uldum?"
#define GOSSIP_ITEM_NORGANNON_6     "I will return when i have the Plates of Uldum."

bool GossipHello_npc_stone_watcher_of_norgannon(Player* pPlayer, Creature* pCreature)
{
    if (pCreature->isQuestGiver())
        pPlayer->PrepareQuestMenu(pCreature->GetGUID());

    if (pPlayer->GetQuestStatus(2954) == QUEST_STATUS_INCOMPLETE)
        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    pPlayer->SEND_GOSSIP_MENU(1674, pCreature->GetGUID());

    return true;
}

bool GossipSelect_npc_stone_watcher_of_norgannon(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
{
    switch (uiAction)
    {
        case GOSSIP_ACTION_INFO_DEF:
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            pPlayer->SEND_GOSSIP_MENU(1675, pCreature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+1:
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            pPlayer->SEND_GOSSIP_MENU(1676, pCreature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            pPlayer->SEND_GOSSIP_MENU(1677, pCreature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            pPlayer->SEND_GOSSIP_MENU(1678, pCreature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            pPlayer->SEND_GOSSIP_MENU(1679, pCreature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
            pPlayer->CLOSE_GOSSIP_MENU();
            pPlayer->AreaExploredOrEventHappens(2954);
            break;
    }
    return true;
}

/*######
## npc_OOX17
######*/

enum e00X17
{
    //texts are signed for 7806
    SAY_OOX_START           = -1060000,
    SAY_OOX_AGGRO1          = -1060001,
    SAY_OOX_AGGRO2          = -1060002,
    SAY_OOX_AMBUSH          = -1060003,
    SAY_OOX17_AMBUSH_REPLY  = -1060004,
    SAY_OOX_END             = -1060005,

    Q_OOX17                 = 648,
    SPAWN_FIRST             = 7803,
    SPAWN_SECOND_1          = 5617,
    SPAWN_SECOND_2          = 7805
};

struct npc_OOX17AI : public npc_escortAI
{
    npc_OOX17AI(Creature *c) : npc_escortAI(c) {}

    void Reset() {}

    void EnterCombat(Unit* /*who*/)
    {
        DoScriptText(RAND(SAY_OOX_AGGRO1,SAY_OOX_AGGRO2), me);
    }

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == SPAWN_SECOND_1)
            DoScriptText(SAY_OOX17_AMBUSH_REPLY, summoned);

        summoned->AI()->AttackStart(me);
    }

    void WaypointReached(uint32 i)
    {
        Player* pPlayer = GetPlayerForEscort();

        if (!pPlayer)
            return;

        switch(i)
        {
            case 23:
                DoScriptText(SAY_OOX_AMBUSH, me);
                break;
            case 24:
                for (uint8 i = 0; i < 3; ++i)
                {
                    float x, y, z;
                    switch (i)
                    {
                        case 0:
                            me->GetNearPoint(x, y, z, 0.0f, 15.0f, 0.0f);
                            me->SummonCreature(SPAWN_FIRST, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                            break;
                        case 1:
                            me->GetNearPoint(x, y, z, 0.0f, 15.0f, 2.0f);
                            me->SummonCreature(SPAWN_FIRST, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                            break;
                        case 2:
                            me->GetNearPoint(x, y, z, 0.0f, 15.0f, 4.0f);
                            me->SummonCreature(SPAWN_FIRST, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                            break;
                    }
                }
                break;
            case 57:
                DoScriptText(SAY_OOX_AMBUSH, me);
                break;
            case 58:
                for (uint8 i = 0; i < 3; ++i)
                {
                    float x, y, z;
                    switch (i)
                    {
                        case 0:
                            me->GetNearPoint(x, y, z, 0.0f, 15.0f, 0.0f);
                            me->SummonCreature(SPAWN_SECOND_1, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                            break;
                        case 1:
                            me->GetNearPoint(x, y, z, 0.0f, 15.0f, 2.0f);
                            me->SummonCreature(SPAWN_SECOND_2, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                            break;
                        case 2:
                            me->GetNearPoint(x, y, z, 0.0f, 15.0f, 4.0f);
                            me->SummonCreature(SPAWN_SECOND_2, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                            break;
                    }
                }
                break;
            case 88:
                if (pPlayer)
                {
                    DoScriptText(SAY_OOX_END, me);
                    pPlayer->GroupEventHappens(Q_OOX17, me);
                }
                break;
        }
    }
};

bool QuestAccept_npc_OOX17(Player* pPlayer, Creature* pCreature, Quest const* quest)
{
    if (quest->GetQuestId() == Q_OOX17)
    {
        pCreature->SetStandState(UNIT_STAND_STATE_STAND);
        DoScriptText(SAY_OOX_START, pCreature);

        if (npc_escortAI* pEscortAI = CAST_AI(npc_OOX17AI, pCreature->AI()))
            pEscortAI->Start(true, true, pPlayer->GetGUID());
    }
    return true;
}

CreatureAI* GetAI_npc_OOX17(Creature* pCreature)
{
    return new npc_OOX17AI(pCreature);
}

/*######
## go_landmark_treasure
######*/

#define QUEST_CUERGOS_GOLD 2882

#define NPC_BUCCANEER      7902
#define NPC_PIRATE         7899
#define NPC_SWASHBUCKLER   7901

#define GO_TREASURE        142194

#define PATH_ENTRY_1       2090
#define PATH_ENTRY_2       2091
#define PATH_ENTRY_3       2092
#define PATH_ENTRY_4       2093
#define PATH_ENTRY_5       2094

bool GOUse_go_landmark_treasure(Player *player, GameObject* _GO)
{
    if (player->GetQuestStatus(QUEST_CUERGOS_GOLD) != QUEST_STATUS_INCOMPLETE)
        return false;

    Creature * spawn = NULL;

    spawn = player->SummonCreature(NPC_PIRATE, -10029.78, -4032.54, 19.41, 3.40, TEMPSUMMON_TIMED_DESPAWN, 340000);
    if (spawn)
        spawn->GetMotionMaster()->MovePath(PATH_ENTRY_1, true);
    spawn = player->SummonCreature(NPC_PIRATE, -10031.64, -4032.14, 19.11, 3.40, TEMPSUMMON_TIMED_DESPAWN, 340000);
    if (spawn)
        spawn->GetMotionMaster()->MovePath(PATH_ENTRY_3, true);

    spawn = player->SummonCreature(NPC_SWASHBUCKLER, -10029.86, -4030.51, 20.02, 3.40, TEMPSUMMON_TIMED_DESPAWN, 340000);
    if (spawn)
        spawn->GetMotionMaster()->MovePath(PATH_ENTRY_4, true);
    spawn = player->SummonCreature(NPC_SWASHBUCKLER, -10031.83, -4030.70, 19.52, 3.40, TEMPSUMMON_TIMED_DESPAWN, 340000);
    if (spawn)
        spawn->GetMotionMaster()->MovePath(PATH_ENTRY_5, true);

    spawn = player->SummonCreature(NPC_BUCCANEER, -10028.90, -4029.65, 20.53, 3.40, TEMPSUMMON_TIMED_DESPAWN, 340000);
    if (spawn)
        spawn->GetMotionMaster()->MovePath(PATH_ENTRY_2, true);

    player->SummonGameObject(GO_TREASURE, -10119.70, -4050.45, 5.33, 0, 0, 0, 0, 0, 240);

    return true;
};

/*####
# npc_tooga
####*/

enum eTooga
{
    SAY_TOOG_THIRST             = -1600391,
    SAY_TOOG_WORRIED            = -1600392,
    SAY_TOOG_POST_1             = -1600393,
    SAY_TORT_POST_2             = -1600394,
    SAY_TOOG_POST_3             = -1600395,
    SAY_TORT_POST_4             = -1600396,
    SAY_TOOG_POST_5             = -1600397,
    SAY_TORT_POST_6             = -1600398,

    QUEST_TOOGA                 = 1560,
    NPC_TORTA                   = 6015,

    POINT_ID_TO_WATER           = 1,
    FACTION_TOOG_ESCORTEE       = 113
};

const float m_afToWaterLoc[] = {-7032.664551f, -4906.199219f, -1.606446f};

struct npc_toogaAI : public FollowerAI
{
    npc_toogaAI(Creature* pCreature) : FollowerAI(pCreature) { }

    uint32 m_uiCheckSpeechTimer;
    uint32 m_uiPostEventTimer;
    uint32 m_uiPhasePostEvent;

    uint64 TortaGUID;

    void Reset()
    {
        m_uiCheckSpeechTimer = 2500;
        m_uiPostEventTimer = 1000;
        m_uiPhasePostEvent = 0;

        TortaGUID = 0;
    }

    void MoveInLineOfSight(Unit *pWho)
    {
        FollowerAI::MoveInLineOfSight(pWho);

        if (!me->getVictim() && !HasFollowState(STATE_FOLLOW_COMPLETE | STATE_FOLLOW_POSTEVENT) && pWho->GetEntry() == NPC_TORTA)
        {
            if (me->IsWithinDistInMap(pWho, INTERACTION_DISTANCE))
            {
                if (Player* pPlayer = GetLeaderForFollower())
                {
                    if (pPlayer->GetQuestStatus(QUEST_TOOGA) == QUEST_STATUS_INCOMPLETE)
                        pPlayer->GroupEventHappens(QUEST_TOOGA, me);
                }

                TortaGUID = pWho->GetGUID();
                SetFollowComplete(true);
            }
        }
    }

    void MovementInform(uint32 uiMotionType, uint32 uiPointId)
    {
        FollowerAI::MovementInform(uiMotionType, uiPointId);

        if (uiMotionType != POINT_MOTION_TYPE)
            return;

        if (uiPointId == POINT_ID_TO_WATER)
            SetFollowComplete();
    }

    void UpdateFollowerAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
        {
            //we are doing the post-event, or...
            if (HasFollowState(STATE_FOLLOW_POSTEVENT))
            {
                if (m_uiPostEventTimer <= uiDiff)
                {
                    m_uiPostEventTimer = 5000;

                    Unit *pTorta = Unit::GetUnit(*me, TortaGUID);
                    if (!pTorta || !pTorta->isAlive())
                    {
                        //something happened, so just complete
                        SetFollowComplete();
                        return;
                    }

                    switch(m_uiPhasePostEvent)
                    {
                        case 1:
                            DoScriptText(SAY_TOOG_POST_1, me);
                            break;
                        case 2:
                            DoScriptText(SAY_TORT_POST_2, pTorta);
                            break;
                        case 3:
                            DoScriptText(SAY_TOOG_POST_3, me);
                            break;
                        case 4:
                            DoScriptText(SAY_TORT_POST_4, pTorta);
                            break;
                        case 5:
                            DoScriptText(SAY_TOOG_POST_5, me);
                            break;
                        case 6:
                            DoScriptText(SAY_TORT_POST_6, pTorta);
                            me->GetMotionMaster()->MovePoint(POINT_ID_TO_WATER, m_afToWaterLoc[0], m_afToWaterLoc[1], m_afToWaterLoc[2]);
                            break;
                    }

                    ++m_uiPhasePostEvent;
                }
                else
                    m_uiPostEventTimer -= uiDiff;
            }
            //...we are doing regular speech check
            else if (HasFollowState(STATE_FOLLOW_INPROGRESS))
            {
                if (m_uiCheckSpeechTimer <= uiDiff)
                {
                    m_uiCheckSpeechTimer = 5000;

                    if (urand(0,9) > 8)
                        DoScriptText(RAND(SAY_TOOG_THIRST,SAY_TOOG_WORRIED), me);
                }
                else
                    m_uiCheckSpeechTimer -= uiDiff;
            }

            return;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_tooga(Creature* pCreature)
{
    return new npc_toogaAI(pCreature);
}

bool QuestAccept_npc_tooga(Player* pPlayer, Creature* pCreature, const Quest* pQuest)
{
    if (pQuest->GetQuestId() == QUEST_TOOGA)
    {
        if (npc_toogaAI* pToogaAI = CAST_AI(npc_toogaAI, pCreature->AI()))
            pToogaAI->StartFollow(pPlayer, FACTION_TOOG_ESCORTEE, pQuest);
    }

    return true;
}

struct npc_anachronosAI : public ScriptedAI
{
    npc_anachronosAI(Creature* pCreature) : ScriptedAI(pCreature) { }

    uint32 checkTimer;

    void Reset()
    {
        me->SetVisibility(VISIBILITY_ON);
        checkTimer = 3000;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (checkTimer < diff)
        {
            if (HealthBelowPct(20))
            {
                me->Yell("A terrible and costly mistake you have made. It is not my time, mortals.", LANG_UNIVERSAL, 0);
                me->SetVisibility(VISIBILITY_OFF);
                me->DestroyForNearbyPlayers();
                me->Kill(me, false);
                return;
            }

            checkTimer = 3000;
        }
        else
            checkTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_anachronos(Creature* pCreature)
{
    return new npc_anachronosAI(pCreature);
}

void AddSC_tanaris()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "mob_aquementas";
    newscript->GetAI = &GetAI_mob_aquementas;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_custodian_of_time";
    newscript->GetAI = &GetAI_npc_custodian_of_time;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_marin_noggenfogger";
    newscript->pGossipHello =  &GossipHello_npc_marin_noggenfogger;
    newscript->pGossipSelect = &GossipSelect_npc_marin_noggenfogger;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_steward_of_time";
    newscript->pGossipHello =  &GossipHello_npc_steward_of_time;
    newscript->pGossipSelect = &GossipSelect_npc_steward_of_time;
    newscript->pQuestAcceptNPC =  &QuestAccept_npc_steward_of_time;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_stone_watcher_of_norgannon";
    newscript->pGossipHello =  &GossipHello_npc_stone_watcher_of_norgannon;
    newscript->pGossipSelect = &GossipSelect_npc_stone_watcher_of_norgannon;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_OOX17";
    newscript->GetAI = &GetAI_npc_OOX17;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_OOX17;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_landmark_treasure";
    newscript->pGOUse = &GOUse_go_landmark_treasure;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_tooga";
    newscript->GetAI = &GetAI_npc_tooga;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_tooga;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_anachronos";
    newscript->GetAI = &GetAI_npc_anachronos;
    newscript->RegisterSelf();
}
