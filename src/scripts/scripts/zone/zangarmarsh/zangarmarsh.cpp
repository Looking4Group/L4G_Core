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
SDName: Zangarmarsh
SD%Complete: 99
SDComment: Quest support: 9785, 9803, 10009, 9752. Mark Of ... buffs. 9816
SDCategory: Zangarmarsh
EndScriptData */

/* ContentData
npcs_ashyen_and_keleth
npc_cooshcoosh
npc_elder_kuruti
npc_mortog_steamhead
npc_kayra_longmane
npc_baby_murloc
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"

/*######
## npcs_ashyen_and_keleth
######*/

#define GOSSIP_ITEM_BLESS_ASH     "Grant me your mark, wise ancient."
#define GOSSIP_ITEM_BLESS_KEL     "Grant me your mark, mighty ancient."
#define GOSSIP_REWARD_BLESS       -1000359
//#define TEXT_BLESSINGS        "<You need higher standing with Cenarion Expedition to recive a blessing.>"

bool GossipHello_npcs_ashyen_and_keleth(Player *player, Creature *creature )
{
    if (player->GetReputationMgr().GetRank(942) > REP_NEUTRAL)
    {
        if ( creature->GetEntry() == 17900)
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_BLESS_ASH, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        if ( creature->GetEntry() == 17901)
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_BLESS_KEL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
    }
    player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());

    return true;
}

bool GossipSelect_npcs_ashyen_and_keleth(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        creature->setPowerType(POWER_MANA);
        creature->SetMaxPower(POWER_MANA,200);             //set a "fake" mana value, we can't depend on database doing it in this case
        creature->SetPower(POWER_MANA,200);

        if ( creature->GetEntry() == 17900)                //check which creature we are dealing with
        {
            switch (player->GetReputationMgr().GetRank(942))
            {                                               //mark of lore
                case REP_FRIENDLY:
                    creature->CastSpell(player, 31808, true);
                    DoScriptText(GOSSIP_REWARD_BLESS, creature);
                    break;
                case REP_HONORED:
                    creature->CastSpell(player, 31810, true);
                    DoScriptText(GOSSIP_REWARD_BLESS, creature);
                    break;
                case REP_REVERED:
                    creature->CastSpell(player, 31811, true);
                    DoScriptText(GOSSIP_REWARD_BLESS, creature);
                    break;
                case REP_EXALTED:
                    creature->CastSpell(player, 31815, true);
                    DoScriptText(GOSSIP_REWARD_BLESS, creature);
                    break;
            }
        }

        if ( creature->GetEntry() == 17901)
        {
            switch (player->GetReputationMgr().GetRank(942))         //mark of war
            {
                case REP_FRIENDLY:
                    creature->CastSpell(player, 31807, true);
                    DoScriptText(GOSSIP_REWARD_BLESS, creature);
                    break;
                case REP_HONORED:
                    creature->CastSpell(player, 31812, true);
                    DoScriptText(GOSSIP_REWARD_BLESS, creature);
                    break;
                case REP_REVERED:
                    creature->CastSpell(player, 31813, true);
                    DoScriptText(GOSSIP_REWARD_BLESS, creature);
                    break;
                case REP_EXALTED:
                    creature->CastSpell(player, 31814, true);
                    DoScriptText(GOSSIP_REWARD_BLESS, creature);
                    break;
            }
        }
        player->CLOSE_GOSSIP_MENU();
        player->TalkedToCreature(creature->GetEntry(), creature->GetGUID());
    }
    return true;
}

/*######
## npc_cooshcoosh
######*/

#define GOSSIP_COOSH            "You owe Sim'salabim money. Hand them over or die!"

#define FACTION_HOSTILE_CO      45
#define FACTION_FRIENDLY_CO     35

#define SPELL_LIGHTNING_BOLT    9532

struct npc_cooshcooshAI : public ScriptedAI
{
    npc_cooshcooshAI(Creature* creature) : ScriptedAI(creature) {}

    uint32 LightningBolt_Timer;

    void Reset()
    {
        LightningBolt_Timer = 2000;
        me->setFaction(FACTION_FRIENDLY_CO);
    }

    void EnterCombat(Unit *who) {}

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if( LightningBolt_Timer < diff )
        {
            DoCast(me->getVictim(),SPELL_LIGHTNING_BOLT);
            LightningBolt_Timer = 5000;
        }else LightningBolt_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_npc_cooshcoosh(Creature *creature)
{
    return new npc_cooshcooshAI (creature);
}

bool GossipHello_npc_cooshcoosh(Player *player, Creature *creature )
{
    if( player->GetQuestStatus(10009) == QUEST_STATUS_INCOMPLETE )
        player->ADD_GOSSIP_ITEM(1, GOSSIP_COOSH, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(9441, creature->GetGUID());
    return true;
}

bool GossipSelect_npc_cooshcoosh(Player *player, Creature *creature, uint32 sender, uint32 action )
{
    if( action == GOSSIP_ACTION_INFO_DEF )
    {
        player->CLOSE_GOSSIP_MENU();
        creature->setFaction(FACTION_HOSTILE_CO);
        ((npc_cooshcooshAI*)creature->AI())->AttackStart(player);
    }
    return true;
}

/*######
## npc_elder_kuruti
######*/

#define GOSSIP_ITEM_KUR1 "Offer treat"
#define GOSSIP_ITEM_KUR2 "Im a messenger for Draenei"
#define GOSSIP_ITEM_KUR3 "Get message"

bool GossipHello_npc_elder_kuruti(Player *player, Creature *creature )
{
    if( player->GetQuestStatus(9803) == QUEST_STATUS_INCOMPLETE )
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_KUR1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(9226,creature->GetGUID());

    return true;
}

bool GossipSelect_npc_elder_kuruti(Player *player, Creature *creature, uint32 sender, uint32 action )
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_KUR2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(9227, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_KUR3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(9229, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
        {
            if( !player->HasItemCount(24573,1) )
            {
                ItemPosCountVec dest;
                uint8 msg = player->CanStoreNewItem( NULL_BAG, NULL_SLOT, dest, 24573, 1);
                if( msg == EQUIP_ERR_OK )
                {
                    player->StoreNewItem( dest, 24573, true);
                }
                else
                    player->SendEquipError( msg,NULL,NULL );
            }
            player->SEND_GOSSIP_MENU(9231, creature->GetGUID());
            break;
        }
    }
    return true;
}

/*######
## npc_mortog_steamhead
######*/

bool GossipHello_npc_mortog_steamhead(Player *player, Creature *creature)
{
    if (creature->isVendor() && player->GetReputationMgr().GetRank(942) == REP_EXALTED)
        player->ADD_GOSSIP_ITEM(1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

    player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());

    return true;
}

bool GossipSelect_npc_mortog_steamhead(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_TRADE)
    {
        player->SEND_VENDORLIST( creature->GetGUID() );
    }
    return true;
}

/*######
## npc_kayra_longmane
######*/

#define SAY_PROGRESS_1  -1000360
#define SAY_PROGRESS_2  -1000361
#define SAY_PROGRESS_3  -1000362
#define SAY_PROGRESS_4  -1000363
#define SAY_PROGRESS_5  -1000364
#define SAY_PROGRESS_6  -1000365

#define QUEST_EFU   9752
#define MOB_AMBUSH  18042

struct npc_kayra_longmaneAI : public npc_escortAI
{
    npc_kayra_longmaneAI(Creature* creature) : npc_escortAI(creature) {}

    bool Completed;

    void Reset()
    {
        me->setFaction(1660);
    }

    void EnterCombat(Unit* who){}

    void JustSummoned(Creature *summoned)
    {
        summoned->AI()->AttackStart(me);
        summoned->setFaction(14);
    }

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();

        switch(i)
        {
        case 0: DoScriptText(SAY_PROGRESS_1, me, player); break;
        case 5: DoScriptText(SAY_PROGRESS_2, me, player);
            me->SummonCreature(MOB_AMBUSH, -922.24, 5357.98, 17.93, 5.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
            me->SummonCreature(MOB_AMBUSH, -922.24, 5357.98, 17.93, 5.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
            break;
        case 6: DoScriptText(SAY_PROGRESS_3, me, player);
            me->SetWalk(false);
            break;
        case 18: DoScriptText(SAY_PROGRESS_4, me, player);
            me->SummonCreature(MOB_AMBUSH, -671.86, 5379.81, 22.12, 5.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
            me->SummonCreature(MOB_AMBUSH, -671.86, 5379.81, 22.12, 5.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
            break;
        case 19: me->SetWalk(false);
            DoScriptText(SAY_PROGRESS_5, me, player); break;
        case 26: DoScriptText(SAY_PROGRESS_6, me, player);
            if(player)
                player->GroupEventHappens(QUEST_EFU, me);
            break;
        }
    }
};

CreatureAI* GetAI_npc_kayra_longmane(Creature* creature)
{
    return new npc_kayra_longmaneAI(creature);
}

bool QuestAccept_npc_kayra_longmane(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_EFU)
    {
        if (npc_escortAI* pEscortAI = CAST_AI(npc_kayra_longmaneAI, creature->AI()))
            pEscortAI->Start(true, true, player->GetGUID(), quest);
        creature->setFaction(113);
    }
    return true;
}

/*######
## npc_baby_murloc
######*/

enum
{
    NPC_PURPLE_MURLOC          = 15357,
    NPC_GREEN_MURLOC           = 15360,
    NPC_BLUE_MURLOC            = 15356,
    NPC_PINK_MURLOC            = 15359,
    NPC_ORANGE_MURLOC          = 15361,

    SPELL_SING                 = 32041
};

struct Pos
{
    float x, y, z;
};

static Pos M[]=
{
    {1206.926f, 8139.298f, 19.70f},
    {1206.927f, 8158.908f, 19.51f},
    {1220.742f, 8093.757f, 18.120f},
    {1128.926f, 8137.008f, 20.664f},
    {1230.289f, 8156.368f, 18.40f},
    {1216.511f, 8188.199f, 18.70f}
};

struct npc_baby_murlocAI : public ScriptedAI
{
    npc_baby_murlocAI(Creature* creature) : ScriptedAI(creature) {}

    ObjectGuid PlayerGUID;
    uint32 CheckTimer;
    uint32 EndTimer;

    void Reset()
    {
        PlayerGUID = 0;
        CheckTimer = 7000;
        EndTimer = 55000;
        DoSummon();
        me->GetMotionMaster()->MovePoint(0, M[0].x, M[0].y, M[0].z);
        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_DANCE);
    }

    void DoSummon()
    {
        me->SummonCreature(NPC_PURPLE_MURLOC, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000);
        me->SummonCreature(NPC_GREEN_MURLOC, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 9000);
        me->SummonCreature(NPC_BLUE_MURLOC, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 9000);
        me->SummonCreature(NPC_PINK_MURLOC, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 9000);
        me->SummonCreature(NPC_ORANGE_MURLOC, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 9000);
    }

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == NPC_PURPLE_MURLOC)
        {
            summoned->SetWalk(false);
            summoned->GetMotionMaster()->MovePoint(0, M[1].x, M[1].y, M[1].z);
            summoned->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_DANCE);
        }

        if (summoned->GetEntry() == NPC_GREEN_MURLOC)
        {
            summoned->SetWalk(false);
            summoned->GetMotionMaster()->MovePoint(0, M[2].x, M[2].y, M[2].z);
        }
        if (summoned->GetEntry() == NPC_BLUE_MURLOC)
        {
            summoned->SetWalk(false);
            summoned->GetMotionMaster()->MovePoint(0, M[3].x, M[3].y, M[3].z);
        }
        if (summoned->GetEntry() == NPC_ORANGE_MURLOC)
        {
            summoned->SetWalk(false);
            summoned->GetMotionMaster()->MovePoint(0, M[4].x, M[4].y, M[4].z);
        }
        else
        {
            if (summoned->GetEntry() == NPC_PINK_MURLOC)
            {
                summoned->SetWalk(false);
                summoned->GetMotionMaster()->MovePoint(0, M[5].x, M[5].y, M[5].z);
            }
        }
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
        {
            if (((Player*)who)->GetQuestStatus(9816) == QUEST_STATUS_INCOMPLETE)
            {
                if (me->IsWithinDistInMap(((Player *)who), 15))
                {
                    PlayerGUID = who->GetObjectGuid();
                }
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (CheckTimer <= diff)
        {
            if (Player* player = me->GetPlayer(PlayerGUID))
            {
                me->SetFacingToObject(player);
                DoCast(me, SPELL_SING);

                if (Creature * Purple = GetClosestCreatureWithEntry(me, NPC_PURPLE_MURLOC, 20.0f))
                {
                    Purple->SetFacingToObject(player);
                    Purple->CastSpell(Purple, SPELL_SING, true);
                }
            }

            CheckTimer = 15000;
        }
        else CheckTimer -= diff;

        if (EndTimer <= diff)
        {
            if (Player* player = me->GetPlayer(PlayerGUID))
            {
                player->AreaExploredOrEventHappens(9816);
            }
        }
        else EndTimer -= diff;
    }
};

CreatureAI* GetAI_npc_baby_murloc(Creature* creature)
{
    return new npc_baby_murlocAI(creature);
}

/*######
## AddSC
######*/

void AddSC_zangarmarsh()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npcs_ashyen_and_keleth";
    newscript->pGossipHello =  &GossipHello_npcs_ashyen_and_keleth;
    newscript->pGossipSelect = &GossipSelect_npcs_ashyen_and_keleth;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_cooshcoosh";
    newscript->pGossipHello =  &GossipHello_npc_cooshcoosh;
    newscript->pGossipSelect = &GossipSelect_npc_cooshcoosh;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_elder_kuruti";
    newscript->pGossipHello =  &GossipHello_npc_elder_kuruti;
    newscript->pGossipSelect = &GossipSelect_npc_elder_kuruti;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_mortog_steamhead";
    newscript->pGossipHello =  &GossipHello_npc_mortog_steamhead;
    newscript->pGossipSelect = &GossipSelect_npc_mortog_steamhead;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_kayra_longmane";
    newscript->GetAI = &GetAI_npc_kayra_longmane;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_kayra_longmane;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_baby_murloc";
    newscript->GetAI = &GetAI_npc_baby_murloc;
    newscript->RegisterSelf();
}
