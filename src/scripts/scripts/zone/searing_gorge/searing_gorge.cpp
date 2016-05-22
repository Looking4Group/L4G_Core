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
SDName: Searing_Gorge
SD%Complete: 80
SDComment: Quest support: 3377, 3441 (More accurate info on Kalaran needed). Lothos Riftwaker teleport to Molten Core.
SDCategory: Searing Gorge
EndScriptData */

/* ContentData
npc_kalaran_windblade
npc_lothos_riftwaker
npc_zamael_lunthistle
EndContentData */

#include "precompiled.h"

/*######
## npc_kalaran_windblade
######*/

bool GossipHello_npc_kalaran_windblade(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if (player->GetQuestStatus(3441) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, "Tell me what drives this vengance?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_kalaran_windblade(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF:
            player->ADD_GOSSIP_ITEM( 0, "Continue please", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(1954, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM( 0, "Let me confer with my colleagues", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(1955, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(3441);
            break;
    }
    return true;
}

/*######
## npc_lothos_riftwaker
######*/

bool GossipHello_npc_lothos_riftwaker(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if (player->GetQuestRewardStatus(7487) || player->GetQuestRewardStatus(7848))
        player->ADD_GOSSIP_ITEM(0, "Teleport me to the Molten Core", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_lothos_riftwaker(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF + 1)
    {
        player->CLOSE_GOSSIP_MENU();
        player->TeleportTo(409, 1096, -467, -104.6, 3.64);
    }

    return true;
}

/*######
## npc_zamael_lunthistle
######*/

bool GossipHello_npc_zamael_lunthistle(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if (player->GetQuestStatus(3377) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, "Tell me your story", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(1920, _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_zamael_lunthistle(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF:
            player->ADD_GOSSIP_ITEM( 0, "Please continue...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(1921, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM( 0, "Goodbye", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(1922, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(3377);
            break;
    }
    return true;
}

/*######
##
######*/

void AddSC_searing_gorge()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_kalaran_windblade";
    newscript->pGossipHello =  &GossipHello_npc_kalaran_windblade;
    newscript->pGossipSelect = &GossipSelect_npc_kalaran_windblade;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_lothos_riftwaker";
    newscript->pGossipHello          = &GossipHello_npc_lothos_riftwaker;
    newscript->pGossipSelect         = &GossipSelect_npc_lothos_riftwaker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_zamael_lunthistle";
    newscript->pGossipHello =  &GossipHello_npc_zamael_lunthistle;
    newscript->pGossipSelect = &GossipSelect_npc_zamael_lunthistle;
    newscript->RegisterSelf();
}

