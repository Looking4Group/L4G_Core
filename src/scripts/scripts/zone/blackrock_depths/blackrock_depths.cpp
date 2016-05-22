/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Blackrock_Depths
SD%Complete: 95
SDComment: Quest support: 4001, 4342, 7604, 4322. Vendor Lokhtos Darkbargainer.
SDCategory: Blackrock Depths
EndScriptData */

/* ContentData
at_ring_of_law
npc_grimstone
mob_phalanx
npc_kharan_mighthammer
npc_lokhtos_darkbargainer
npc_dughal_stormwing
npc_marshal_windsor
npc_marshal_reginald_windsor
npc_tobias_seecher
npc_rocknot
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"
#include "def_blackrock_depths.h"

#define C_GRIMSTONE         10096


//4 or 6 in total? 1+2+1 / 2+2+2 / 3+3. Depending on this, code should be changed.
#define MOB_AMOUNT          4

uint32 RingMob[]=
{
    8925,                                                   // Dredge Worm
    8926,                                                   // Deep Stinger
    8927,                                                   // Dark Screecher
    8928,                                                   // Burrowing Thundersnout
    8933,                                                   // Cave Creeper
    8932,                                                   // Borer Beetle
};

uint32 RingBoss[]=
{
    9027,                                                   // Gorosh
    9028,                                                   // Grizzle
    9029,                                                   // Eviscerator
    9030,                                                   // Ok'thor
    9031,                                                   // Anub'shiah
    9032,                                                   // Hedrum
};

float RingLocations[6][3]=
{
    {604.802673, -191.081985, -54.058590},                  // ring
    {604.072998, -222.106918, -52.743759},                  // first gate
    {621.400391, -214.499054, -52.814453},                  // hiding in corner
    {601.300781, -198.556992, -53.950256},                  // ring
    {631.818359, -180.548126, -52.654770},                  // second gate
    {627.390381, -201.075974, -52.692917}                   // hiding in corner
};

bool AreaTrigger_at_ring_of_law(Player *player, AreaTriggerEntry const* at)
{
    ScriptedInstance* pInstance = (player->GetInstanceData());

    if (pInstance)
    {
        if (pInstance->GetData(TYPE_RING_OF_LAW) == IN_PROGRESS || pInstance->GetData(TYPE_RING_OF_LAW) == DONE)
            return false;

        pInstance->SetData(TYPE_RING_OF_LAW,IN_PROGRESS);
        player->SummonCreature(C_GRIMSTONE,625.559,-205.618,-52.735,2.609,TEMPSUMMON_DEAD_DESPAWN,0);

        return false;
    }
    return false;
}

/*######
## npc_grimstone
######*/

//TODO: implement quest part of event (different end boss)
struct npc_grimstoneAI : public npc_escortAI
{
    npc_grimstoneAI(Creature *c) : npc_escortAI(c)
    {
        pInstance = (c->GetInstanceData());
        MobSpawnId = rand()%6;
    }

    ScriptedInstance* pInstance;

    uint8 EventPhase;
    uint32 Event_Timer;

    uint8 MobSpawnId;
    uint8 MobCount;
    uint32 MobDeath_Timer;

    uint64 RingMobGUID[4];
    uint64 RingBossGUID;

    bool CanWalk;

    void Reset()
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

        EventPhase = 0;
        Event_Timer = 1000;

        MobCount = 0;
        MobDeath_Timer = 0;

        for(uint8 i = 0; i < MOB_AMOUNT; i++)
            RingMobGUID[i] = 0;

        RingBossGUID = 0;
        DoGate(DATA_ARENA4,0);
        CanWalk = false;
    }

    void EnterCombat(Unit *who) { }

    void DoGate(uint32 id, uint32 state)
    {
        if (GameObject *go = GameObject::GetGameObject(*me,pInstance->GetData64(id)))
            go->SetGoState(GOState(state));

        debug_log("TSCR: npc_grimstone, arena gate update state.");
    }

    //TODO: move them to center
    void SummonRingMob()
    {
        if (Creature* tmp = me->SummonCreature(RingMob[MobSpawnId],608.960,-235.322,-53.907,1.857,TEMPSUMMON_DEAD_DESPAWN,0))
            RingMobGUID[MobCount] = tmp->GetGUID();

        ++MobCount;

        if (MobCount == MOB_AMOUNT)
            MobDeath_Timer = 2500;
    }

    //TODO: move them to center
    void SummonRingBoss()
    {
        if (Creature* tmp = me->SummonCreature(RingBoss[rand()%6],644.300,-175.989,-53.739,3.418,TEMPSUMMON_DEAD_DESPAWN,0))
            RingBossGUID = tmp->GetGUID();

        MobDeath_Timer = 2500;
    }

    void WaypointReached(uint32 i)
    {
        switch(i)
        {
        case 0:
            DoScriptText(-1000002, me);//2
            CanWalk = false;
            Event_Timer = 5000;
            break;
        case 1:
            DoScriptText(-1000003, me);//4
            CanWalk = false;
            Event_Timer = 5000;
            break;
        case 2:
            CanWalk = false;
            break;
        case 3:
            DoScriptText(-1000005, me);//5
            break;
        case 4:
            DoScriptText(-1000006, me);//6
            CanWalk = false;
            Event_Timer = 5000;
            break;
        case 5:
            if (pInstance)
            {
                pInstance->SetData(TYPE_RING_OF_LAW,DONE);
                debug_log("TSCR: npc_grimstone: event reached end and set complete.");
            }
            break;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!pInstance)
            return;

        if (MobDeath_Timer)
        {
            if (MobDeath_Timer <= diff)
            {
                MobDeath_Timer = 2500;

                if (RingBossGUID)
                {
                    Creature *boss = Unit::GetCreature(*me,RingBossGUID);
                    if (boss && !boss->isAlive() && boss->isDead())
                    {
                        RingBossGUID = 0;
                        Event_Timer = 5000;
                        MobDeath_Timer = 0;
                        return;
                    }
                    return;
                }

                for(uint8 i = 0; i < MOB_AMOUNT; i++)
                {
                    Creature *mob = Unit::GetCreature(*me,RingMobGUID[i]);
                    if (mob && !mob->isAlive() && mob->isDead())
                    {
                        RingMobGUID[i] = 0;
                        --MobCount;

                        //seems all are gone, so set timer to continue and discontinue this
                        if (!MobCount)
                        {
                            Event_Timer = 5000;
                            MobDeath_Timer = 0;
                        }
                    }
                }
            }
            else
                MobDeath_Timer -= diff;
        }

        if (Event_Timer)
        {
            if (Event_Timer <= diff)
            {
                switch(EventPhase)
                {
                case 0:
                    DoScriptText(-1000001, me);//1
                    DoGate(DATA_ARENA4,1);
                    Start(false, false);
                    CanWalk = true;
                    Event_Timer = 0;
                    break;
                case 1:
                    CanWalk = true;
                    Event_Timer = 0;
                    break;
                case 2:
                    Event_Timer = 2000;
                    break;
                case 3:
                    DoGate(DATA_ARENA1,0);
                    Event_Timer = 3000;
                    break;
                case 4:
                    CanWalk = true;
                    me->SetVisibility(VISIBILITY_OFF);
                    SummonRingMob();
                    Event_Timer = 8000;
                    break;
                case 5:
                    SummonRingMob();
                    SummonRingMob();
                    Event_Timer = 8000;
                    break;
                case 6:
                    SummonRingMob();
                    Event_Timer = 0;
                    break;
                case 7:
                    me->SetVisibility(VISIBILITY_ON);
                    DoGate(DATA_ARENA1,1);
                    DoScriptText(-1000004, me);//4
                    CanWalk = true;
                    Event_Timer = 0;
                    break;
                case 8:
                    DoGate(DATA_ARENA2,0);
                    Event_Timer = 5000;
                    break;
                case 9:
                    me->SetVisibility(VISIBILITY_OFF);
                    SummonRingBoss();
                    Event_Timer = 0;
                    break;
                case 10:
                    //if quest, complete
                    DoGate(DATA_ARENA2,1);
                    DoGate(DATA_ARENA3,0);
                    DoGate(DATA_ARENA4,0);
                    CanWalk = true;
                    Event_Timer = 0;
                    break;
                }
                ++EventPhase;
            }
            else
                Event_Timer -= diff;
        }

        if (CanWalk)
            npc_escortAI::UpdateAI(diff);
       }
};

CreatureAI* GetAI_npc_grimstone(Creature *creature)
{
    npc_grimstoneAI* Grimstone_AI = new npc_grimstoneAI(creature);

    for(uint8 i = 0; i < 6; ++i)
        Grimstone_AI->AddWaypoint(i, RingLocations[i][0], RingLocations[i][1], RingLocations[i][2]);

    return (CreatureAI*)Grimstone_AI;

}

/*######
## mob_phalanx
######*/

#define SPELL_THUNDERCLAP       8732
#define SPELL_FIREBALLVOLLEY    22425
#define SPELL_MIGHTYBLOW        14099

struct mob_phalanxAI : public ScriptedAI
{
    mob_phalanxAI(Creature *c) : ScriptedAI(c) {}

    uint32 ThunderClap_Timer;
    uint32 FireballVolley_Timer;
    uint32 MightyBlow_Timer;

    void Reset()
    {
        ThunderClap_Timer = 12000;
        FireballVolley_Timer =0;
        MightyBlow_Timer = 15000;
    }

    void EnterCombat(Unit *who)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        //ThunderClap_Timer
        if (ThunderClap_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_THUNDERCLAP);
            ThunderClap_Timer = 10000;
        }
        else
            ThunderClap_Timer -= diff;

        //FireballVolley_Timer
        if (me->GetHealth()*100 / me->GetMaxHealth() < 51)
        {
            if (FireballVolley_Timer < diff)
            {
                DoCast(me->getVictim(),SPELL_FIREBALLVOLLEY);
                FireballVolley_Timer = 15000;
            }
            else
                FireballVolley_Timer -= diff;
        }

        //MightyBlow_Timer
        if (MightyBlow_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_MIGHTYBLOW);
            MightyBlow_Timer = 10000;
        }
        else
            MightyBlow_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_mob_phalanx(Creature *creature)
{
    return new mob_phalanxAI (creature);
}

/*######
## npc_kharan_mighthammer
######*/

#define QUEST_4001  4001
#define QUEST_4342  4342

#define GOSSIP_ITEM_KHARAN_1    "I need to know where the princess are, Kharan!"
#define GOSSIP_ITEM_KHARAN_2    "All is not lost, Kharan!"

#define GOSSIP_ITEM_KHARAN_3    "Gor'shak is my friend, you can trust me."
#define GOSSIP_ITEM_KHARAN_4    "Not enough, you need to tell me more."
#define GOSSIP_ITEM_KHARAN_5    "So what happened?"
#define GOSSIP_ITEM_KHARAN_6    "Continue..."
#define GOSSIP_ITEM_KHARAN_7    "So you suspect that someone on the inside was involved? That they were tipped off?"
#define GOSSIP_ITEM_KHARAN_8    "Continue with your story please."
#define GOSSIP_ITEM_KHARAN_9    "Indeed."
#define GOSSIP_ITEM_KHARAN_10   "The door is open, Kharan. You are a free man."

bool GossipHello_npc_kharan_mighthammer(Player *player, Creature *creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu(creature->GetGUID());

    if (player->GetQuestStatus(QUEST_4001) == QUEST_STATUS_INCOMPLETE)
         player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    if (player->GetQuestStatus(4342) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);

    if (player->GetTeam() == HORDE)
        player->SEND_GOSSIP_MENU(2473, creature->GetGUID());
    else
        player->SEND_GOSSIP_MENU(2474, creature->GetGUID());

    return true;
}

bool GossipSelect_npc_kharan_mighthammer(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
             player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(2475, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->SEND_GOSSIP_MENU(2476, creature->GetGUID());
            break;

        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            player->SEND_GOSSIP_MENU(2477, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(2478, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
             player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
            player->SEND_GOSSIP_MENU(2479, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+6:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_8, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+7);
            player->SEND_GOSSIP_MENU(2480, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+7:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_9, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+8);
            player->SEND_GOSSIP_MENU(2481, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+8:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KHARAN_10, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+9);
            player->SEND_GOSSIP_MENU(2482, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+9:
            player->CLOSE_GOSSIP_MENU();
            if (player->GetTeam() == HORDE)
                player->AreaExploredOrEventHappens(QUEST_4001);
            else
                player->AreaExploredOrEventHappens(QUEST_4342);
            break;
    }
    return true;
}

/*######
## npc_lokhtos_darkbargainer
######*/

#define ITEM_THRORIUM_BROTHERHOOD_CONTRACT               18628
#define ITEM_SULFURON_INGOT                              17203
#define QUEST_A_BINDING_CONTRACT                         7604
#define SPELL_CREATE_THORIUM_BROTHERHOOD_CONTRACT_DND    23059

#define GOSSIP_ITEM_SHOW_ACCESS     "Show me what I have access to, Lothos."
#define GOSSIP_ITEM_GET_CONTRACT    "Get Thorium Brotherhood Contract"

bool GossipHello_npc_lokhtos_darkbargainer(Player *player, Creature *creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu(creature->GetGUID());

    if (creature->isVendor() && player->GetReputationMgr().GetRank(59) >= REP_FRIENDLY)
          player->ADD_GOSSIP_ITEM(1, GOSSIP_ITEM_SHOW_ACCESS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

    if (player->GetQuestRewardStatus(QUEST_A_BINDING_CONTRACT) != 1 &&
        !player->HasItemCount(ITEM_THRORIUM_BROTHERHOOD_CONTRACT, 1, true) &&
        player->HasItemCount(ITEM_SULFURON_INGOT, 1))
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_GET_CONTRACT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
    }

    if (player->GetReputationMgr().GetRank(59) < REP_FRIENDLY)
        player->SEND_GOSSIP_MENU(3673, creature->GetGUID());
    else
        player->SEND_GOSSIP_MENU(3677, creature->GetGUID());

    return true;
}

bool GossipSelect_npc_lokhtos_darkbargainer(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF + 1)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player, SPELL_CREATE_THORIUM_BROTHERHOOD_CONTRACT_DND, false);
    }
    if (action == GOSSIP_ACTION_TRADE)
        player->SEND_VENDORLIST(creature->GetGUID());

    return true;
}

/*######
## npc_rocknot
######*/

#define SAY_GOT_BEER        -1230000
#define SPELL_DRUNKEN_RAGE  14872
#define QUEST_ALE           4295

float BarWpLocations[8][3]=
{
    {883.294861, -188.926300, -43.703655},
    {872.763550, -185.605621, -43.703655},                  //b1
    {867.923401, -188.006393, -43.703655},                  //b2
    {863.295898, -190.795212, -43.703655},                  //b3
    {856.139587, -194.652756, -43.703655},                  //b4
    {851.878906, -196.928131, -43.703655},                  //b5
    {877.035217, -187.048080, -43.703655},
    {891.198000, -197.924000, -43.620400}                   //home
};

uint32 BarWpWait[8]=
{
    0,
    5000,
    5000,
    5000,
    5000,
    15000,
    0,
    0
};

struct npc_rocknotAI : public npc_escortAI
{
    npc_rocknotAI(Creature *c) : npc_escortAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 BreakKeg_Timer;
    uint32 BreakDoor_Timer;

    void Reset()
    {
        if (HasEscortState(STATE_ESCORT_ESCORTING))
            return;

        BreakKeg_Timer = 0;
        BreakDoor_Timer = 0;
    }

    void EnterCombat(Unit *who) { }

    void DoGo(uint32 id, uint32 state)
    {
        if (GameObject *go = GameObject::GetGameObject(*me,pInstance->GetData64(id)))
            go->SetGoState(GOState(state));
    }

    void WaypointReached(uint32 i)
    {
        if (!pInstance)
            return;

        switch(i)
        {
        case 1:
            me->HandleEmoteCommand(EMOTE_ONESHOT_KICK);
            break;
        case 2:
            me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACKUNARMED);
            break;
        case 3:
            me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACKUNARMED);
            break;
        case 4:
            me->HandleEmoteCommand(EMOTE_ONESHOT_KICK);
            break;
        case 5:
            me->HandleEmoteCommand(EMOTE_ONESHOT_KICK);
            BreakKeg_Timer = 2000;
            break;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!pInstance)
            return;

        if (BreakKeg_Timer)
        {
            if (BreakKeg_Timer <= diff)
            {
                DoGo(DATA_GO_BAR_KEG,0);
                BreakKeg_Timer = 0;
                BreakDoor_Timer = 1000;
            }
            else
                BreakKeg_Timer -= diff;
        }

        if (BreakDoor_Timer)
        {
            if (BreakDoor_Timer <= diff)
            {
                DoGo(DATA_GO_BAR_DOOR,2);
                DoGo(DATA_GO_BAR_KEG_TRAP,0);               //doesn't work very well, leaving code here for future
                //spell by trap has effect61, this indicate the bar go hostile

                if (Unit *tmp = Unit::GetUnit(*me,pInstance->GetData64(DATA_PHALANX)))
                    tmp->setFaction(14);

                //for later, this event(s) has alot more to it.
                //optionally, DONE can trigger bar to go hostile.
                pInstance->SetData(TYPE_BAR,DONE);

                BreakDoor_Timer = 0;
            }
            else
                BreakDoor_Timer -= diff;
        }

        npc_escortAI::UpdateAI(diff);
    }
};

CreatureAI* GetAI_npc_rocknot(Creature *creature)
{
    npc_rocknotAI* Rocknot_AI = new npc_rocknotAI(creature);

    for(uint8 i = 0; i < 8; ++i)
        Rocknot_AI->AddWaypoint(i, BarWpLocations[i][0], BarWpLocations[i][1], BarWpLocations[i][2], BarWpWait[i]);

    return (CreatureAI*)Rocknot_AI;
}

bool ChooseReward_npc_rocknot(Player *player, Creature *creature, const Quest *_Quest)
{
    ScriptedInstance* pInstance = (creature->GetInstanceData());

    if (!pInstance)
        return true;

    if (pInstance->GetData(TYPE_BAR) == DONE || pInstance->GetData(TYPE_BAR) == SPECIAL)
        return true;

    if (_Quest->GetQuestId() == QUEST_ALE)
    {
        if (pInstance->GetData(TYPE_BAR) != IN_PROGRESS)
            pInstance->SetData(TYPE_BAR,IN_PROGRESS);

        pInstance->SetData(TYPE_BAR,SPECIAL);

        //keep track of amount in instance script, returns SPECIAL if amount ok and event in progress
        if (pInstance->GetData(TYPE_BAR) == SPECIAL)
        {
            DoScriptText(SAY_GOT_BEER, creature);
            creature->CastSpell(creature,SPELL_DRUNKEN_RAGE,false);
            if (npc_escortAI* pEscortAI = CAST_AI(npc_rocknotAI, creature->AI()))
                pEscortAI->Start(false, false);
        }
    }

    return true;
}

/*######
## npc_marshal_windsor
######*/

#define QUEST_JAIL_BREAK            4322
#define SAY_WINDSOR_AGGRO1          "You locked up the wrong Marshal. Prepare to be destroyed!"
#define SAY_WINDSOR_AGGRO2          "I bet you're sorry now, aren't you !?!!"
#define SAY_WINDSOR_AGGRO3          "You better hold me back $N or they are going to feel some prison house beatings."
#define SAY_WINDSOR_1               "Let's get a move on. My gear should be in the storage area up this way..."
#define SAY_WINDSOR_4_1             "Check that cell, $N. If someone is alive in there, we need to get them out."
#define SAY_WINDSOR_4_2             "Get him out of there!"
#define SAY_WINDSOR_4_3             "Good work! We're almost there, $N. This way."
#define SAY_WINDSOR_6               "This is it, $N. My stuff should be in that room. Cover me, I'm going in!"
#define SAY_WINDSOR_9               "Ah, there it is!"
#define MOB_ENTRY_REGINALD_WINDSOR  9682
#define GO_STORE_DOOR               170561

struct npc_marshal_windsorAI : public npc_escortAI
{
    npc_marshal_windsorAI(Creature *c) : npc_escortAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    void WaypointReached(uint32 i)
    {
        Player *player = GetPlayerForEscort();

        if (!player)
            return;

        switch (i)
        {
        case 1:
            me->Say(SAY_WINDSOR_1, LANG_UNIVERSAL, player->GetGUID());
            break;
        case 7:
            me->HandleEmoteCommand(EMOTE_STATE_POINT);
            me->Say(SAY_WINDSOR_4_1, LANG_UNIVERSAL, player->GetGUID());
            if (pInstance)
            {
                if (Creature* dughal = Unit::GetCreature(*me, pInstance->GetData64(DATA_DUGHAL)))
                {
                    if (!dughal->isAlive())
                        dughal->Respawn();
                    dughal->SetVisibility(VISIBILITY_ON);
                    dughal->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                }
            }
            SetEscortPaused(true);
            break;
        case 10:
            me->setFaction(534);
            break;
        case 12:
            me->Say(SAY_WINDSOR_6, LANG_UNIVERSAL, player->GetGUID());
            break;
        case 13:
            if (GameObject* door = FindGameObject(GO_STORE_DOOR, INTERACTION_DISTANCE, me))
                door->UseDoorOrButton(60);
            me->HandleEmoteCommand(EMOTE_STATE_USESTANDING);
            break;
        case 14:
            me->setFaction(11);
            break;
        case 16:
            me->Say(SAY_WINDSOR_9, LANG_UNIVERSAL, player->GetGUID());
            break;
        case 17:
            me->HandleEmoteCommand(EMOTE_STATE_USESTANDING);
            break;
        case 19:      
            if (Creature* reginald = me->SummonCreature(MOB_ENTRY_REGINALD_WINDSOR, 403.61, -51.71, -63.92, 3.600434, TEMPSUMMON_DEAD_DESPAWN , 0))
                pInstance->SetData64(DATA_REGINALD, reginald->GetGUID());
            me->SetVisibility(VISIBILITY_OFF);
            me->ForcedDespawn();
            break;
        }
    }

    void EnterCombat(Unit* who)
    {
        switch(rand()%3)
        {
            case 0:
                me->Say(SAY_WINDSOR_AGGRO1, LANG_UNIVERSAL, who->GetGUID());
                break;
            case 1:
                me->Say(SAY_WINDSOR_AGGRO2, LANG_UNIVERSAL, who->GetGUID());
                break;
            case 2:
                me->Say(SAY_WINDSOR_AGGRO3, LANG_UNIVERSAL, who->GetGUID());
                break;
        }
    }

    void Reset()
    {
        me->setFaction(35);

        if (pInstance)
        {
            if (pInstance->GetData(DATA_QUEST_JAIL_BREAK) == NOT_STARTED)
                me->SetVisibility(VISIBILITY_ON);
            else
                me->SetVisibility(VISIBILITY_OFF);
        }
    }

    void DoAction(const int32 param)
    {
        SetEscortPaused(false);
    }

    void JustDied(Unit *slayer)
    {
        pInstance->SetData(DATA_QUEST_JAIL_BREAK, FAIL);
    }

    void UpdateEscortAI() {}
};

CreatureAI* GetAI_npc_marshal_windsor(Creature *creature)
{
    npc_marshal_windsorAI* marshal_windsorAI = new npc_marshal_windsorAI(creature);

    marshal_windsorAI->AddWaypoint(0, 316.336,-225.528, -77.7258,8000);
    marshal_windsorAI->AddWaypoint(1, 316.336,-225.528, -77.7258,2000);
    marshal_windsorAI->AddWaypoint(2, 322.96,-207.13, -77.87,0);
    marshal_windsorAI->AddWaypoint(3, 281.05,-172.16, -75.12,0);
    marshal_windsorAI->AddWaypoint(4, 272.19,-139.14, -70.61,0);
    marshal_windsorAI->AddWaypoint(5, 283.62,-116.09, -70.21,0);
    marshal_windsorAI->AddWaypoint(6, 296.18,-94.30, -74.08,0);
    marshal_windsorAI->AddWaypoint(7, 294.57,-93.11, -74.08,0);
    marshal_windsorAI->AddWaypoint(8, 314.31,-74.31, -76.09,0);
    marshal_windsorAI->AddWaypoint(9, 360.22,-62.93, -66.77,0);
    marshal_windsorAI->AddWaypoint(10, 383.38,-69.40, -63.25,0);
    marshal_windsorAI->AddWaypoint(11, 389.99,-67.86, -62.57,0);
    marshal_windsorAI->AddWaypoint(12, 400.98,-72.01, -62.31,0);
    marshal_windsorAI->AddWaypoint(13, 404.22,-62.30, -63.50,2300);
    marshal_windsorAI->AddWaypoint(14, 404.22,-62.30, -63.50,1500);
    marshal_windsorAI->AddWaypoint(15, 407.65,-51.86, -63.96,0);
    marshal_windsorAI->AddWaypoint(16, 403.61,-51.71, -63.92,1000);
    marshal_windsorAI->AddWaypoint(17, 403.61,-51.71, -63.92,3000);
    marshal_windsorAI->AddWaypoint(18, 403.61,-51.71, -63.92,2000);
    marshal_windsorAI->AddWaypoint(19, 403.61,-51.71, -63.92,1000);

    return (CreatureAI*)marshal_windsorAI;
}

bool QuestAccept_npc_marshal_windsor(Player *player, Creature *creature, Quest const *quest)
{
    if (quest->GetQuestId() == QUEST_JAIL_BREAK)
    {
        ScriptedInstance *pInstance = (creature->GetInstanceData());

        if (!pInstance)
            return false;

        if (pInstance->GetData(DATA_QUEST_JAIL_BREAK) == NOT_STARTED)
        {
            ((npc_escortAI*)(creature->AI()))->SetMaxPlayerDistance(88.0f);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
            pInstance->SetData64(Q_STARTER, player->GetGUID());
            pInstance->SetData(DATA_QUEST_JAIL_BREAK, IN_PROGRESS);
            creature->setFaction(11);
        }
    }
    return false;
}

/*######
## npc_marshal_reginald_windsor
######*/

#define SAY_REGINALD_WINDSOR_0_1    "Can you feel the power, $N??? It's time to ROCK!"
#define SAY_REGINALD_WINDSOR_0_2    "Now we just have to free Tobias and we can get out of here. This way!"
#define SAY_REGINALD_WINDSOR_5_1    "Open it."
#define SAY_REGINALD_WINDSOR_5_2    "I never did like those two. Let's get moving."
#define SAY_REGINALD_WINDSOR_7_1    "Open it and be careful this time!"
#define SAY_REGINALD_WINDSOR_7_2    "That intolerant dirtbag finally got what was coming to him. Good riddance!"
#define SAY_REGINALD_WINDSOR_7_3    "Alright, let's go."
#define SAY_REGINALD_WINDSOR_13_1   "Open it. We need to hurry up. I can smell those Dark Irons coming a mile away and I can tell you one thing, they're COMING!"
#define SAY_REGINALD_WINDSOR_13_2   "Administering fists of fury on Crest Killer!"
#define SAY_REGINALD_WINDSOR_13_3   "He has to be in the last cell. Unless... they killed him."
#define SAY_REGINALD_WINDSOR_14_1   "Get him out of there!"
#define SAY_REGINALD_WINDSOR_14_2   "Excellent work, $N. Let's find the exit. I think I know the way. Follow me!"
#define SAY_REGINALD_WINDSOR_20_1   "We made it!"
#define SAY_REGINALD_WINDSOR_20_2   "Meet me at Maxwell's encampment. We'll go over the next stages of the plan there and figure out a way to decode my tablets without the decryption ring."

struct npc_marshal_reginald_windsorAI : public npc_escortAI
{
    npc_marshal_reginald_windsorAI(Creature *c) : npc_escortAI(c)
    {
        pInstance = (ScriptedInstance*)(c->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    void WaypointReached(uint32 i)
    {
        Player *player = GetPlayerForEscort();

        if (!player)
            return;

        switch(i)
        {
            case 0:
                me->Say(SAY_REGINALD_WINDSOR_0_1, LANG_UNIVERSAL, player->GetGUID());
            break;
            case 1:
                me->Say(SAY_REGINALD_WINDSOR_0_2, LANG_UNIVERSAL, player->GetGUID());
            break;
            case 7:
                me->HandleEmoteCommand(EMOTE_STATE_POINT);
                me->Say(SAY_REGINALD_WINDSOR_5_1, LANG_UNIVERSAL, player->GetGUID());
                if (pInstance)
                {
                    if (Creature* jaz = Unit::GetCreature(*me, pInstance->GetData64(DATA_JAZ)))
                    {
                        if (!jaz->isAlive())
                            jaz->Respawn();
                        jaz->SetVisibility(VISIBILITY_ON);
                        jaz->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    }
                }
                SetEscortPaused(true);
                break;
            case 8:
                me->Say(SAY_REGINALD_WINDSOR_5_2, LANG_UNIVERSAL, player->GetGUID());
            break;
            case 11:
                me->HandleEmoteCommand(EMOTE_STATE_POINT);
                me->Say(SAY_REGINALD_WINDSOR_7_1, LANG_UNIVERSAL, player->GetGUID());
                if (pInstance)
                {
                    if (Creature* shill = Unit::GetCreature(*me, pInstance->GetData64(DATA_SHILL)))
                    {
                        if (!shill->isAlive())
                            shill->Respawn();
                        shill->SetVisibility(VISIBILITY_ON);
                        shill->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    }
                }
                SetEscortPaused(true);
            break;
            case 12:
                me->Say(SAY_REGINALD_WINDSOR_7_2, LANG_UNIVERSAL, player->GetGUID());
            break;
            case 13:
                me->Say(SAY_REGINALD_WINDSOR_7_3, LANG_UNIVERSAL, player->GetGUID());
            break;
            case 20:
                me->HandleEmoteCommand(EMOTE_STATE_POINT);
                me->Say(SAY_REGINALD_WINDSOR_13_1, LANG_UNIVERSAL, player->GetGUID());
                if (pInstance)
                {
                    if (Creature* crest = Unit::GetCreature(*me, pInstance->GetData64(DATA_CREST)))
                    {
                        if (!crest->isAlive())
                            crest->Respawn();
                        crest->SetVisibility(VISIBILITY_ON);
                        crest->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    }
                }
                SetEscortPaused(true);
            break;
            case 21:
                me->Say(SAY_REGINALD_WINDSOR_13_3, LANG_UNIVERSAL, player->GetGUID());
            break;
            case 23:
                me->HandleEmoteCommand(EMOTE_STATE_POINT);
                me->Say(SAY_REGINALD_WINDSOR_14_1, LANG_UNIVERSAL, player->GetGUID());
                if (pInstance)
                {
                    if (Creature* tobias = Unit::GetCreature(*me, pInstance->GetData64(DATA_TOBIAS)))
                    {
                        if (!tobias->isAlive())
                            tobias->Respawn();
                        tobias->SetVisibility(VISIBILITY_ON);
                        tobias->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    }
                }
                SetEscortPaused(true);
            break;
            case 24:
                me->Say(SAY_REGINALD_WINDSOR_14_2, LANG_UNIVERSAL, player->GetGUID());
            break;
            case 31:
                me->Say(SAY_REGINALD_WINDSOR_20_1, LANG_UNIVERSAL, player->GetGUID());
            break;
            case 32:
                me->Say(SAY_REGINALD_WINDSOR_20_2, LANG_UNIVERSAL, player->GetGUID());

                if (pInstance)
                {
                    if (Unit *qstarter = Unit::GetUnit(*me, pInstance->GetData64(Q_STARTER)))
                        ((Player*)qstarter)->GroupEventHappens(QUEST_JAIL_BREAK, me);
                }
                pInstance->SetData(DATA_QUEST_JAIL_BREAK, DONE);
            break;
        }
    }

    void Reset()
    {
        if (pInstance)
        {
            if (Unit *qstarter = Unit::GetUnit(*me, pInstance->GetData64(Q_STARTER)))
            {
                ((npc_escortAI*)(me->AI()))->SetMaxPlayerDistance(88.0f);
                CAST_AI(npc_escortAI, (me->AI()))->Start(true, true, qstarter->GetGUID());
                me->setFaction(11);
            }
        }
    }

    void DoAction(const int32 param)
    {
        SetEscortPaused(false);
    }

    void EnterCombat(Unit* who)
    {
        switch(rand()%3)
        {
            case 0:
                me->Say(SAY_WINDSOR_AGGRO1, LANG_UNIVERSAL, who->GetGUID());
                break;
            case 1:
                me->Say(SAY_WINDSOR_AGGRO2, LANG_UNIVERSAL, who->GetGUID());
                break;
            case 2:
                me->Say(SAY_WINDSOR_AGGRO3, LANG_UNIVERSAL, who->GetGUID());
                break;
        }
    }

    void JustDied(Unit *slayer)
    {
        if (pInstance)
            pInstance->SetData(DATA_QUEST_JAIL_BREAK, FAIL);
    }

    void UpdateEscortAI() {}
};

CreatureAI* GetAI_npc_marshal_reginald_windsor(Creature *creature)
{
    npc_marshal_reginald_windsorAI* marshal_reginald_windsorAI = new npc_marshal_reginald_windsorAI(creature);

    marshal_reginald_windsorAI->AddWaypoint(0, 403.61,-52.71, -63.92,4000);
    marshal_reginald_windsorAI->AddWaypoint(1, 403.61,-52.71, -63.92,4000);
    marshal_reginald_windsorAI->AddWaypoint(2, 406.33,-54.87, -63.95,0);
    marshal_reginald_windsorAI->AddWaypoint(3, 407.99,-73.91, -62.26,0);
    marshal_reginald_windsorAI->AddWaypoint(4, 557.03,-119.71, -61.83,0);
    marshal_reginald_windsorAI->AddWaypoint(5, 573.40,-124.39, -65.07,0);
    marshal_reginald_windsorAI->AddWaypoint(6, 593.91,-130.29, -69.25,0);
    marshal_reginald_windsorAI->AddWaypoint(7, 593.21,-132.16, -69.25,0);
    marshal_reginald_windsorAI->AddWaypoint(8, 593.21,-132.16, -69.25,3000);
    marshal_reginald_windsorAI->AddWaypoint(9, 622.81,-135.55, -71.92,0);
    marshal_reginald_windsorAI->AddWaypoint(10, 634.68,-151.29, -70.32,0);
    marshal_reginald_windsorAI->AddWaypoint(11, 635.06,-153.25, -70.32,0);
    marshal_reginald_windsorAI->AddWaypoint(12, 635.06,-153.25, -70.32,3000);
    marshal_reginald_windsorAI->AddWaypoint(13, 635.06,-153.25, -70.32,1500);
    marshal_reginald_windsorAI->AddWaypoint(14, 655.25,-172.39, -73.72,0);
    marshal_reginald_windsorAI->AddWaypoint(15, 654.79,-226.30, -83.06,0);
    marshal_reginald_windsorAI->AddWaypoint(16, 622.85,-268.85, -83.96,0);
    marshal_reginald_windsorAI->AddWaypoint(17, 579.45,-275.56, -80.44,0);
    marshal_reginald_windsorAI->AddWaypoint(18, 561.19,-266.85, -75.59,0);
    marshal_reginald_windsorAI->AddWaypoint(19, 547.91,-253.92, -70.34,0);
    marshal_reginald_windsorAI->AddWaypoint(20, 549.20,-252.40, -70.34,0);
    marshal_reginald_windsorAI->AddWaypoint(21, 549.20,-252.40, -70.34,4000);
    marshal_reginald_windsorAI->AddWaypoint(22, 555.33,-269.16, -74.40,0);
    marshal_reginald_windsorAI->AddWaypoint(23, 554.31,-270.88, -74.40,0);
    marshal_reginald_windsorAI->AddWaypoint(24, 554.31,-270.88, -74.40,4000);
    marshal_reginald_windsorAI->AddWaypoint(25, 536.10,-249.60, -67.47,0);
    marshal_reginald_windsorAI->AddWaypoint(26, 520.94,-216.65, -59.28,0);
    marshal_reginald_windsorAI->AddWaypoint(27, 505.99,-148.74, -62.17,0);
    marshal_reginald_windsorAI->AddWaypoint(28, 484.21,-56.24, -62.43,0);
    marshal_reginald_windsorAI->AddWaypoint(29, 470.39,-6.01, -70.10,0);
    marshal_reginald_windsorAI->AddWaypoint(30, 451.27,30.85, -70.07,0);
    marshal_reginald_windsorAI->AddWaypoint(31, 452.45,29.85, -70.37,1500);
    marshal_reginald_windsorAI->AddWaypoint(32, 452.45,29.85, -70.37,7000);
    marshal_reginald_windsorAI->AddWaypoint(33, 452.45,29.85, -70.37,10000);
    marshal_reginald_windsorAI->AddWaypoint(34, 451.27,31.85, -70.07,0);

    return (CreatureAI*)marshal_reginald_windsorAI;
}

/*######
## npc_dughal_stormwing
######*/

#define SAY_DUGHAL_FREE         "Thank you, $N! I'm free!!!"
#define GOSSIP_DUGHAL           "You're free, Dughal! Get out of here!"

struct npc_dughal_stormwingAI : public npc_escortAI
{
    npc_dughal_stormwingAI(Creature *c) : npc_escortAI(c)
    {
        pInstance = (ScriptedInstance*)(c->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    void WaypointReached(uint32 i)
    {
        Player *player = GetPlayerForEscort();

        if (!player)
            return;

        switch(i)
        {
            case 0:
                me->Say(SAY_DUGHAL_FREE, LANG_UNIVERSAL, player->GetGUID());
                break;
            case 2:
                if (pInstance)
                {
                    if (Creature* windsor = Unit::GetCreature(*me, pInstance->GetData64(DATA_WINDSOR)))
                    {
                        windsor->Say(SAY_WINDSOR_4_3, LANG_UNIVERSAL, player->GetGUID());
                        windsor->AI()->DoAction();
                    }
                }
            break;
        }
    }

    void Reset()
    {
        me->SetVisibility(VISIBILITY_OFF);
    }

    void JustDied(Unit* killer)
    {
        if (pInstance)
        {
            if (Creature* windsor = Unit::GetCreature(*me, pInstance->GetData64(DATA_WINDSOR)))
                windsor->AI()->DoAction();
        }
    }

    void UpdateEscortAI(const uint32 diff) {}
};

CreatureAI* GetAI_npc_dughal_stormwing(Creature *creature)
{
    npc_dughal_stormwingAI* dughal_stormwingAI = new npc_dughal_stormwingAI(creature);

    dughal_stormwingAI->AddWaypoint(0, 280.42,-82.86, -77.12,0);
    dughal_stormwingAI->AddWaypoint(1, 287.64,-87.01, -76.79,0);
    dughal_stormwingAI->AddWaypoint(2, 354.63,-64.95, -67.53,1000);

    return (CreatureAI*)dughal_stormwingAI;
}
bool GossipHello_npc_dughal_stormwing(Player *player, Creature *creature)
{
    ScriptedInstance *pInstance = (ScriptedInstance*)(creature->GetInstanceData());

    if (!pInstance)
        return false;

    if (player->GetQuestStatus(QUEST_JAIL_BREAK) == QUEST_STATUS_INCOMPLETE && pInstance->GetData(DATA_QUEST_JAIL_BREAK) == IN_PROGRESS)
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_DUGHAL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(2846, creature->GetGUID());
    }
    return true;
}

bool GossipSelect_npc_dughal_stormwing(Player *player, Creature *creature, uint32 sender, uint32 action )
{
    ScriptedInstance *pInstance = (ScriptedInstance*)(creature->GetInstanceData());

    if (!pInstance)
        return false;

    if (action == GOSSIP_ACTION_INFO_DEF + 1)
    {
        player->CLOSE_GOSSIP_MENU();
        ((npc_escortAI*)(creature->AI()))->SetDespawnAtFar(false);
        CAST_AI(npc_escortAI, (creature->AI()))->Start(false, false, player->GetGUID());
    }
    return true;
}

/*######
## npc_tobias_seecher
######*/

#define SAY_TOBIAS_FREE         "Thank you! I will run for safety immediately!"

struct npc_tobias_seecherAI : public npc_escortAI
{
    npc_tobias_seecherAI(Creature *c) :npc_escortAI(c)
    {
        pInstance = (ScriptedInstance*)(c->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    void Reset()
    {
        me->SetVisibility(VISIBILITY_OFF);
    }

    void JustDied(Unit* killer)
    {
        if (pInstance)
        {
            if (Creature* reginald = Unit::GetCreature(*me, pInstance->GetData64(DATA_REGINALD)))
                reginald->AI()->DoAction();
        }
    }

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();
        
        if (!player)
            return;

        switch(i)
        {
        case 0:
            me->Say(SAY_TOBIAS_FREE, LANG_UNIVERSAL, player->GetGUID());
            break;
        case 2:
            if (pInstance)
            {
                if (Creature* reginald = Unit::GetCreature(*me, pInstance->GetData64(DATA_REGINALD)))
                    reginald->AI()->DoAction();
            }
            break;
        }
    }

    void UpdateEscortAI(const uint32 diff) {}
};

CreatureAI* GetAI_npc_tobias_seecher(Creature *creature)
{
    npc_tobias_seecherAI* tobias_seecherAI = new npc_tobias_seecherAI(creature);

    tobias_seecherAI->AddWaypoint(0, 549.21, -281.07, -75.27);
    tobias_seecherAI->AddWaypoint(1, 554.39, -267.39, -73.68);
    tobias_seecherAI->AddWaypoint(2, 533.59, -249.38, -67.04);
    tobias_seecherAI->AddWaypoint(3, 519.44, -217.02, -59.34);
    tobias_seecherAI->AddWaypoint(4, 506.55, -153.49, -62.34);

    return (CreatureAI*)tobias_seecherAI;
}

bool GossipHello_npc_tobias_seecher(Player *player, Creature *creature)
{
    ScriptedInstance *pInstance = (ScriptedInstance*)(creature->GetInstanceData());

    if (!pInstance)
        return false;

    if (player->GetQuestStatus(QUEST_JAIL_BREAK) == QUEST_STATUS_INCOMPLETE && pInstance->GetData(DATA_QUEST_JAIL_BREAK) == IN_PROGRESS)
    {
        player->ADD_GOSSIP_ITEM(0, "Get out of here, Tobias, you're free!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(2847, creature->GetGUID());
    }
    return true;
}

bool GossipSelect_npc_tobias_seecher(Player *player, Creature *creature, uint32 sender, uint32 action )
{
    ScriptedInstance *pInstance = (ScriptedInstance*)(creature->GetInstanceData());

    if (!pInstance)
        return false;

    if (action == GOSSIP_ACTION_INFO_DEF + 1)
    {
        player->CLOSE_GOSSIP_MENU();
        ((npc_escortAI*)(creature->AI()))->SetDespawnAtFar(false);
        CAST_AI(npc_escortAI, (creature->AI()))->Start(false, false, player->GetGUID());
    }
    return true;
}

//npc_shill
struct npc_shillAI : public npc_escortAI
{
    npc_shillAI(Creature *creature) :npc_escortAI(creature)
    {
        pInstance = (ScriptedInstance*)(creature->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    void Reset()
    {
        me->SetVisibility(VISIBILITY_OFF);
    }

    void WaypointReached(uint32 i) {}
};

CreatureAI* GetAI_npc_shill(Creature* creature)
{
    return new npc_shillAI (creature);
}

bool GossipHello_npc_shill(Player *player, Creature *creature)
{
    ScriptedInstance *pInstance = (ScriptedInstance*)(creature->GetInstanceData());

    if (!pInstance)
        return false;

    if (player->GetQuestStatus(QUEST_JAIL_BREAK) == QUEST_STATUS_INCOMPLETE && pInstance->GetData(DATA_QUEST_JAIL_BREAK) == IN_PROGRESS)
    {
        if (Creature* reginald = Unit::GetCreature(*creature, pInstance->GetData64(DATA_REGINALD)))
            reginald->AI()->DoAction();
    }

    return true;
}

//npc_crest
struct npc_crestAI : public npc_escortAI
{
    npc_crestAI(Creature *creature) :npc_escortAI(creature)
    {
        pInstance = (ScriptedInstance*)(creature->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    void Reset()
    {
        me->SetVisibility(VISIBILITY_OFF);
    }

    void WaypointReached(uint32 i) {}
};

CreatureAI* GetAI_npc_crest(Creature* creature)
{
    return new npc_crestAI (creature);
}

bool GossipHello_npc_crest(Player *player, Creature *creature)
{
    ScriptedInstance *pInstance = (ScriptedInstance*)(creature->GetInstanceData());

    if (!pInstance)
        return false;

    if (player->GetQuestStatus(QUEST_JAIL_BREAK) == QUEST_STATUS_INCOMPLETE && pInstance->GetData(DATA_QUEST_JAIL_BREAK) == IN_PROGRESS)
    {
        if (Creature* reginald = Unit::GetCreature(*creature, pInstance->GetData64(DATA_REGINALD)))
            reginald->AI()->DoAction();
    }

    return true;
}

//npc_jazz
struct npc_jazAI : public npc_escortAI
{
    npc_jazAI(Creature *creature) :npc_escortAI(creature)
    {
        pInstance = (ScriptedInstance*)(creature->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    void Reset()
    {
        me->SetVisibility(VISIBILITY_OFF);
    }

    void WaypointReached(uint32 i) {}
};

CreatureAI* GetAI_npc_jaz(Creature* creature)
{
    return new npc_jazAI (creature);
}

bool GossipHello_npc_jaz(Player *player, Creature *creature)
{
    ScriptedInstance *pInstance = (ScriptedInstance*)(creature->GetInstanceData());

    if (!pInstance)
        return false;

    if (player->GetQuestStatus(QUEST_JAIL_BREAK) == QUEST_STATUS_INCOMPLETE && pInstance->GetData(DATA_QUEST_JAIL_BREAK) == IN_PROGRESS)
    {
        if (Creature* reginald = Unit::GetCreature(*creature, pInstance->GetData64(DATA_REGINALD)))
            reginald->AI()->DoAction();
    }

    return true;
}
/*######
##Thunderbrew Lager Keg workaround
######*/
bool GOUse_go_thunderbrew_lager_keg(Player *player, GameObject* _GO)
{
    if (player->GetQuestStatus(4134) == QUEST_STATUS_INCOMPLETE)
    {
        _GO->SummonCreature(9537, _GO->GetPositionX(), _GO->GetPositionY(), _GO->GetPositionZ(), 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN, 12000);
        _GO->SummonCreature(9541, _GO->GetPositionX(), _GO->GetPositionY(), _GO->GetPositionZ(), 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN, 12000);
        _GO->SummonCreature(9541, _GO->GetPositionX(), _GO->GetPositionY(), _GO->GetPositionZ(), 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN, 12000);
        _GO->SummonCreature(9541, _GO->GetPositionX(), _GO->GetPositionY(), _GO->GetPositionZ(), 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN, 12000);
    }
    return true;
}

/*######
##relic coffer
######*/
bool GOUse_go_relic_coffer(Player *player, GameObject* _GO)
{
    if (player->GetQuestStatus(4123) == QUEST_STATUS_INCOMPLETE)
    {
        if (!player->GetMap()->GetCreatureGUID(9476))
        {
            _GO->SummonCreature(9476, _GO->GetPositionX(), _GO->GetPositionY(), _GO->GetPositionZ(), 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1200000);
            _GO->SummonCreature(8905, _GO->GetPositionX(), _GO->GetPositionY(), _GO->GetPositionZ(), 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN, 12000);
            _GO->SummonCreature(8905, _GO->GetPositionX(), _GO->GetPositionY(), _GO->GetPositionZ(), 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN, 12000);
            _GO->SummonCreature(8905, _GO->GetPositionX(), _GO->GetPositionY(), _GO->GetPositionZ(), 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN, 12000);
        }
    }
    return true;
}

struct mob_watchman_doomgripAI : public ScriptedAI
{
    mob_watchman_doomgripAI(Creature *c) : ScriptedAI(c) {}

    uint32 Cast_Timer;

    void JustDied(Unit* Killer)
    {
        Killer->SummonGameObject(165554, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 5.48, 0, 0, 0, 0, 0);
    }

    void Reset()
    {
        Cast_Timer = 5000;
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(Cast_Timer < diff)
        {
            me->CastSpell(me->getVictim(), 15504, false);
            Cast_Timer = 5000;
        }
        else
            Cast_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_watchman_doomgrip(Creature *_Creature)
{
    return new mob_watchman_doomgripAI (_Creature);
}

void AddSC_blackrock_depths()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "at_ring_of_law";
    newscript->pAreaTrigger = &AreaTrigger_at_ring_of_law;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_grimstone";
    newscript->GetAI = &GetAI_npc_grimstone;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_phalanx";
    newscript->GetAI = &GetAI_mob_phalanx;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_kharan_mighthammer";
    newscript->pGossipHello =  &GossipHello_npc_kharan_mighthammer;
    newscript->pGossipSelect = &GossipSelect_npc_kharan_mighthammer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_lokhtos_darkbargainer";
    newscript->pGossipHello =  &GossipHello_npc_lokhtos_darkbargainer;
    newscript->pGossipSelect = &GossipSelect_npc_lokhtos_darkbargainer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_rocknot";
    newscript->GetAI = &GetAI_npc_rocknot;
    newscript->pQuestRewardedNPC = &ChooseReward_npc_rocknot;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_marshal_windsor";
    newscript->pQuestAcceptNPC = &QuestAccept_npc_marshal_windsor;
    newscript->GetAI = &GetAI_npc_marshal_windsor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_marshal_reginald_windsor";
    newscript->GetAI = &GetAI_npc_marshal_reginald_windsor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_dughal_stormwing";
    newscript->pGossipHello =  &GossipHello_npc_dughal_stormwing;
    newscript->pGossipSelect = &GossipSelect_npc_dughal_stormwing;
    newscript->GetAI = &GetAI_npc_dughal_stormwing;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_tobias_seecher";
    newscript->pGossipHello =  &GossipHello_npc_tobias_seecher;
    newscript->pGossipSelect = &GossipSelect_npc_tobias_seecher;
    newscript->GetAI = &GetAI_npc_tobias_seecher;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_shill";
    newscript->pGossipHello =  &GossipHello_npc_shill;
    newscript->GetAI = &GetAI_npc_shill;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_crest";
    newscript->pGossipHello =  &GossipHello_npc_crest;
    newscript->GetAI = &GetAI_npc_crest;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_jaz";
    newscript->pGossipHello =  &GossipHello_npc_jaz;
    newscript->GetAI = &GetAI_npc_jaz;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_thunderbrew_lager_keg";
    newscript->pGOUse = &GOUse_go_thunderbrew_lager_keg;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_relic_coffer";
    newscript->pGOUse = &GOUse_go_relic_coffer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_watchman_doomgrip";
    newscript->GetAI = &GetAI_mob_watchman_doomgrip;
    newscript->RegisterSelf();
}

