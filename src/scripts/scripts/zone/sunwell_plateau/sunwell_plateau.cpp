/* Copyright (C) 2009 Trinity <http://www.trinitycore.org/>
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
SDName: Sunwell_Plateau
SD%Complete: 0
SDComment: Placeholder, Epilogue after Kil'jaeden, Captain Selana Gossips
EndScriptData */

/* ContentData
npc_prophet_velen
npc_captain_selana
EndContentData */

#include "precompiled.h"
#include "def_sunwell_plateau.h"
#include "GameEvent.h"

/*######
## npc_prophet_velen
######*/

enum ProphetSpeeches
{
    PROPHET_SAY1 = -1580099,
    PROPHET_SAY2 = -1580100,
    PROPHET_SAY3 = -1580101,
    PROPHET_SAY4 = -1580102,
    PROPHET_SAY5 = -1580103,
    PROPHET_SAY6 = -1580104,
    PROPHET_SAY7 = -1580105,
    PROPHET_SAY8 = -1580106
};

enum LiadrinnSpeeches
{
    LIADRIN_SAY1 = -1580107,
    LIADRIN_SAY2 = -1580108,
    LIADRIN_SAY3 = -1580109
};

/*######
## npc_vindicator_moorba
######*/

#define GOSSIP_SWP_STATE "What is the current progress on Sunwell's offensive?"
#define GOSSIP_TELEPORT_APEX "With Kalecgos freed, can you provide a teleport up to Apex Point?"
#define GOSSIP_TELEPORT_SANCTUM "Now that Lady Sacrolash and Grand Warlock Alythess have been defeated, can you teleport me to the Witch's Sanctum."
#define GOSSIP_TELEPORT_SUNWELL "We've cleared the way to Kil'jaeden! Can you transport me close to the Sunwell?"

bool GossipHello_npc_vindicator_moorba(Player *player, Creature *_Creature)
{
    ScriptedInstance* pInstance = _Creature->GetInstanceData();

    for(uint32 i = 50; i < 54; ++i)
    {
        if(isGameEventActive(i))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SWP_STATE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+i);
            break;
        }
    }

    if (pInstance->GetData(DATA_MURU_EVENT) == DONE)
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_TELEPORT_SUNWELL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
    else if (pInstance->GetData(DATA_EREDAR_TWINS_EVENT) == DONE)
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_TELEPORT_SANCTUM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
    else if (pInstance->GetData(DATA_KALECGOS_EVENT) == DONE)
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_TELEPORT_APEX, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    // when gates event in SWP is finished
    if(isGameEventActive(54))
        player->SEND_GOSSIP_MENU(12403,_Creature->GetGUID());
    else
        player->SEND_GOSSIP_MENU(12309,_Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_vindicator_moorba(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    switch(action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->CastSpell(player, 46881, true); // teleport to Apex Point
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->CastSpell(player, 46883, true); // teleport to Witch's Sanctum
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->CastSpell(player, 46884, true); // teleport close to the Sunwell
            break;
        case GOSSIP_ACTION_INFO_DEF+50:
            HandleWorldEventGossip(player, _Creature);
            player->SEND_GOSSIP_MENU(12400, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+51:
            HandleWorldEventGossip(player, _Creature);
            player->SEND_GOSSIP_MENU(12401, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+52:
            HandleWorldEventGossip(player, _Creature);
            player->SEND_GOSSIP_MENU(12402, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+54:
            HandleWorldEventGossip(player, _Creature);
            player->SEND_GOSSIP_MENU(12403, _Creature->GetGUID());
            break;
        default:
            break;
    }
    return true;
}

/*######
## npc_captain_selana
######*/

#define CS_GOSSIP1 "Give me a situation report, Captain."
#define CS_GOSSIP2 "What went wrong?"
#define CS_GOSSIP3 "Why did they stop?"
#define CS_GOSSIP4 "Your insight is appreciated."

bool GossipHello_npc_captain_selana(Player *player, Creature *_Creature)
{
    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, CS_GOSSIP1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
    player->SEND_GOSSIP_MENU(12588, _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_captain_selana(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, CS_GOSSIP2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(12589, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, CS_GOSSIP3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(12590, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, CS_GOSSIP4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->SEND_GOSSIP_MENU(12591, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->SEND_GOSSIP_MENU(12592, _Creature->GetGUID());
            break;
    }
    return true;
}

void AddSC_sunwell_plateau()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_vindicator_moorba";
    newscript->pGossipHello = &GossipHello_npc_vindicator_moorba;
    newscript->pGossipSelect = &GossipSelect_npc_vindicator_moorba;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_captain_selana";
    newscript->pGossipHello =  &GossipHello_npc_captain_selana;
    newscript->pGossipSelect = &GossipSelect_npc_captain_selana;
    newscript->RegisterSelf();
}
