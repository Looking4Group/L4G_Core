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
SDName: Western_Plaguelands
SD%Complete: 90
SDComment: Quest support: 5097, 5098, 5216, 5219, 5222, 5225, 5229, 5231, 5233, 5235. To obtain Vitreous Focuser (could use more spesifics about gossip items)
SDCategory: Western Plaguelands
EndScriptData */

/* ContentData
npcs_dithers_and_arbington
npc_the_scourge_cauldron
npc_andorhal_tower
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"

/*######
## npcs_dithers_and_arbington
######*/

#define GOSSIP_HDA1 "What does the Felstone Field Cauldron need?"
#define GOSSIP_HDA2 "What does the Dalson's Tears Cauldron need?"
#define GOSSIP_HDA3 "What does the Writhing Haunt Cauldron need?"
#define GOSSIP_HDA4 "What does the Gahrron's Withering Cauldron need?"

#define GOSSIP_SDA1 "Thanks, i need a Vitreous Focuser"

bool GossipHello_npcs_dithers_and_arbington(Player *player, Creature *_Creature)
{
    if(_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );
    if (_Creature->isVendor())
        player->ADD_GOSSIP_ITEM(1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

    if(player->GetQuestRewardStatus(5237) || player->GetQuestRewardStatus(5238))
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_HDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        player->ADD_GOSSIP_ITEM(0, GOSSIP_HDA2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        player->ADD_GOSSIP_ITEM(0, GOSSIP_HDA3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
        player->ADD_GOSSIP_ITEM(0, GOSSIP_HDA4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
        player->SEND_GOSSIP_MENU(3985, _Creature->GetGUID());
    }else
        player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npcs_dithers_and_arbington(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch(action)
    {
        case GOSSIP_ACTION_TRADE:
            player->SEND_VENDORLIST( _Creature->GetGUID() );
            break;
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(3980, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(3981, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(3982, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SDA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(3983, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player, 17529, false);
            break;
    }
    return true;
}

/*######
## npc_the_scourge_cauldron
######*/

struct npc_the_scourge_cauldronAI : public ScriptedAI
{
    npc_the_scourge_cauldronAI(Creature *c) : ScriptedAI(c) {}

    void Reset() {}

    void EnterCombat(Unit* who) {}

    void DoDie()
    {
        //summoner dies here
        m_creature->DealDamage(m_creature, m_creature->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        //override any database `spawntimesecs` to prevent duplicated summons
        uint32 rTime = m_creature->GetRespawnDelay();
        if( rTime<600 )
            m_creature->SetRespawnDelay(600);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (!who || who->GetTypeId() != TYPEID_PLAYER)
            return;

        if(who->GetTypeId() == TYPEID_PLAYER)
        {
            switch(m_creature->GetAreaId())
            {
                case 199:                                   //felstone
                    if( ((Player*)who)->GetQuestStatus(5216) == QUEST_STATUS_INCOMPLETE ||
                        ((Player*)who)->GetQuestStatus(5229) == QUEST_STATUS_INCOMPLETE )
                    {
                        DoSpawnCreature(11075,0,0,0,m_creature->GetOrientation(),TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,600000);
                        DoDie();
                    }
                    break;
                case 200:                                   //dalson
                    if( ((Player*)who)->GetQuestStatus(5219) == QUEST_STATUS_INCOMPLETE ||
                        ((Player*)who)->GetQuestStatus(5231) == QUEST_STATUS_INCOMPLETE )
                    {
                        DoSpawnCreature(11077,0,0,0,m_creature->GetOrientation(),TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,600000);
                        DoDie();
                    }
                    break;
                case 201:                                   //gahrron
                    if( ((Player*)who)->GetQuestStatus(5225) == QUEST_STATUS_INCOMPLETE ||
                        ((Player*)who)->GetQuestStatus(5235) == QUEST_STATUS_INCOMPLETE )
                    {
                        DoSpawnCreature(11078,0,0,0,m_creature->GetOrientation(),TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,600000);
                        DoDie();
                    }
                    break;
                case 202:                                   //writhing
                    if( ((Player*)who)->GetQuestStatus(5222) == QUEST_STATUS_INCOMPLETE ||
                        ((Player*)who)->GetQuestStatus(5233) == QUEST_STATUS_INCOMPLETE )
                    {
                        DoSpawnCreature(11076,0,0,0,m_creature->GetOrientation(),TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,600000);
                        DoDie();
                    }
                    break;
            }
        }
    }
};
CreatureAI* GetAI_npc_the_scourge_cauldron(Creature *_Creature)
{
    return new npc_the_scourge_cauldronAI (_Creature);
}

/*######
## npc_myranda_the_hag
######*/

enum eMyranda
{
    QUEST_SUBTERFUGE        = 5862,
    QUEST_IN_DREAMS         = 5944,
    SPELL_SCARLET_ILLUSION  = 17961
};

#define GOSSIP_ITEM_ILLUSION    "I am ready for the illusion, Myranda."

bool GossipHello_npc_myranda_the_hag(Player* pPlayer, Creature* pCreature)
{
    if (pCreature->isQuestGiver())
        pPlayer->PrepareQuestMenu(pCreature->GetGUID());

    if (pPlayer->GetQuestStatus(QUEST_SUBTERFUGE) == QUEST_STATUS_COMPLETE &&
        !pPlayer->GetQuestRewardStatus(QUEST_IN_DREAMS) && !pPlayer->HasAura(SPELL_SCARLET_ILLUSION, 0))
    {
        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ILLUSION, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        pPlayer->SEND_GOSSIP_MENU(4773, pCreature->GetGUID());
        return true;
    }
    else
        pPlayer->SEND_GOSSIP_MENU(pCreature->GetNpcTextId(), pCreature->GetGUID());

    return true;
}

bool GossipSelect_npc_myranda_the_hag(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
{
    if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        pCreature->CastSpell(pPlayer, SPELL_SCARLET_ILLUSION, false);
        pPlayer->AddAura(SPELL_SCARLET_ILLUSION, pPlayer);
    }
    return true;
}

/*######
##  npc_anchorite_truuen
######*/

enum eTruuen
{
    NPC_GHOST_UTHER             = 17233,
    NPC_THEL_DANIS              = 1854,
    NPC_GHOUL                   = 1791,      //ambush

    QUEST_TOMB_LIGHTBRINGER     = 9446,

    SAY_WP_0                    = -1999981,  //Beware! We are attacked!
    SAY_WP_1                    = -1999982,  //It must be the purity of the Mark of the Lightbringer that is drawing forth the Scourge to attack us. We must proceed with caution lest we be overwhelmed!
    SAY_WP_2                    = -1999983,  //This land truly needs to be cleansed by the Light! Let us continue on to the tomb. It isn't far now...
    SAY_WP_3                    = -1999984,  //Be welcome, friends!
    SAY_WP_4                    = -1999985,  //Thank you for coming here in remembrance of me. Your efforts in recovering that symbol, while unnecessary, are certainly touching to an old man's heart.
    SAY_WP_5                    = -1999986,  //Please, rise my friend. Keep the Blessing as a symbol of the strength of the Light and how heroes long gone might once again rise in each of us to inspire.
    SAY_WP_6                    = -1999987   //Thank you my friend for making this possible. This is a day that I shall never forget! I think I will stay a while. Please return to High Priestess MacDonnell at the camp. I know that she'll be keenly interested to know of what has transpired here.
};

struct npc_anchorite_truuenAI : public npc_escortAI
{
    npc_anchorite_truuenAI(Creature* pCreature) : npc_escortAI(pCreature) { }

    uint32 m_uiChatTimer;
    uint64 UghostGUID;

    void Reset()
    {
        UghostGUID = 0;
        m_uiChatTimer = 7000;
    }

    void JustSummoned(Creature* pSummoned)
    {
        if (pSummoned->GetEntry() == NPC_GHOUL)
            pSummoned->AI()->AttackStart(m_creature);
    }

    void WaypointReached(uint32 i)
    {
        Player* pPlayer = GetPlayerForEscort();
        switch (i)
        {
            case 8:
                DoScriptText(SAY_WP_0, m_creature);
                m_creature->SummonCreature(NPC_GHOUL, m_creature->GetPositionX()+7.0f, m_creature->GetPositionY()+7.0f, m_creature->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                m_creature->SummonCreature(NPC_GHOUL, m_creature->GetPositionX()+5.0f, m_creature->GetPositionY()+5.0f, m_creature->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                break;
            case 9:
                DoScriptText(SAY_WP_1, m_creature);
                break;
            case 14:
                m_creature->SummonCreature(NPC_GHOUL, m_creature->GetPositionX()+7.0f, m_creature->GetPositionY()+7.0f, m_creature->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                m_creature->SummonCreature(NPC_GHOUL, m_creature->GetPositionX()+5.0f, m_creature->GetPositionY()+5.0f, m_creature->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                m_creature->SummonCreature(NPC_GHOUL, m_creature->GetPositionX()+10.0f, m_creature->GetPositionY()+10.0f, m_creature->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                m_creature->SummonCreature(NPC_GHOUL, m_creature->GetPositionX()+8.0f, m_creature->GetPositionY()+8.0f, m_creature->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000);
                break;
            case 15:
                DoScriptText(SAY_WP_2, m_creature);
            case 21:
                if(Creature* Theldanis = GetClosestCreatureWithEntry(m_creature, NPC_THEL_DANIS, 150))
                    DoScriptText(SAY_WP_3, Theldanis, m_creature);
                break;
            case 22:
                break;
            case 23:
                m_creature->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
                if(Creature* Ughost = m_creature->SummonCreature(NPC_GHOST_UTHER, 971.86,-1825.42 ,81.99 , 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                {
                    UghostGUID = Ughost->GetGUID();
                    Ughost->SetLevitate(true);
                    DoScriptText(SAY_WP_4, Ughost, m_creature);
                    m_uiChatTimer = 4000;
                }
                break;
            case 24:
                if(Creature* Ughost = m_creature->GetCreature(*m_creature, UghostGUID))
                {
                    DoScriptText(SAY_WP_5, Ughost, m_creature);
                    m_creature->HandleEmoteCommand(EMOTE_ONESHOT_NONE);
                }
                m_uiChatTimer = 4000;
                break;
            case 25:
                DoScriptText(SAY_WP_6, m_creature);
                m_uiChatTimer = 4000;
                break;
            case 26:
                if (pPlayer)
                    pPlayer->GroupEventHappens(QUEST_TOMB_LIGHTBRINGER, m_creature);
                break;
        }
    }

    void EnterCombat(Unit* pWho){}

     void JustDied(Unit* pKiller)
    {
       Player* pPlayer = GetPlayerForEscort();
        if (pPlayer)
            pPlayer->FailQuest(QUEST_TOMB_LIGHTBRINGER);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        npc_escortAI::UpdateAI(uiDiff);
        DoMeleeAttackIfReady();
        if (HasEscortState(STATE_ESCORT_ESCORTING))
            m_uiChatTimer = 6000;
    }
};

CreatureAI* GetAI_npc_anchorite_truuen(Creature* pCreature)
{
    return new npc_anchorite_truuenAI(pCreature);
}

bool QuestAccept_npc_anchorite_truuen(Player* pPlayer, Creature* pCreature, Quest const *quest)
{
    npc_escortAI* pEscortAI = CAST_AI(npc_anchorite_truuenAI, pCreature->AI());

    if (quest->GetQuestId() == QUEST_TOMB_LIGHTBRINGER)
        pEscortAI->Start(true, true, pPlayer->GetGUID(), quest, true);
    return false;
}

/*######
##    npcs_andorhal_tower
######*/

enum eAndorhalTower
{
    GO_BEACON_TORCH                             = 176093
};

struct npc_andorhal_towerAI : public Scripted_NoMovementAI
{
    npc_andorhal_towerAI(Creature *c) : Scripted_NoMovementAI(c){}

    void MoveInLineOfSight(Unit* who)
    {
        if (!who || who->GetTypeId() != TYPEID_PLAYER)
            return;

        if ((((Player*)who)->GetQuestStatus(5097) == QUEST_STATUS_INCOMPLETE ||
            ((Player*)who)->GetQuestStatus(5098) == QUEST_STATUS_INCOMPLETE) &&
            FindGameObject(GO_BEACON_TORCH, 20.0f, m_creature))
            CAST_PLR(who)->KilledMonster(m_creature->GetEntry(), m_creature->GetGUID());
    }
};

CreatureAI* GetAI_npc_andorhal_tower(Creature* pCreature)
{
    return new npc_andorhal_towerAI (pCreature);
}

/*######
##
######*/

void AddSC_western_plaguelands()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npcs_dithers_and_arbington";
    newscript->pGossipHello = &GossipHello_npcs_dithers_and_arbington;
    newscript->pGossipSelect = &GossipSelect_npcs_dithers_and_arbington;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_the_scourge_cauldron";
    newscript->GetAI = &GetAI_npc_the_scourge_cauldron;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_myranda_the_hag";
    newscript->pGossipHello = &GossipHello_npc_myranda_the_hag;
    newscript->pGossipSelect = &GossipSelect_npc_myranda_the_hag;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_anchorite_truuen";
    newscript->GetAI = &GetAI_npc_anchorite_truuen;
    newscript->pQuestAcceptNPC =  &QuestAccept_npc_anchorite_truuen;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_andorhal_tower";
    newscript->GetAI = &GetAI_npc_andorhal_tower;
    newscript->RegisterSelf();
}

