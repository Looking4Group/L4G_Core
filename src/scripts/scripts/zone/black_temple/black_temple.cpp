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
SDName: Black_Temple
SD%Complete: 95
SDComment: Spirit of Olum: Player Teleporter to Seer Kanai Teleport after defeating Naj'entus and Supremus. TODO: Find proper gossip.
SDCategory: Black Temple
EndScriptData */

/* ContentData
npc_spirit_of_olum
EndContentData */

#include "precompiled.h"
#include "def_black_temple.h"


enum SpiritOfOlumUdalo
{
    SPELL_TELEPORT_ASHTONGUE            = 41566,
    SPELL_TELEPORT_ILLIDARI             = 41570,

    WELCOME_GOSSIP                      = 11082,
    TELEPORT_GOSSIP                     = 11081
};

/*###
# npc_spirit_of_olum
####*/

#define GOSSIP_ASHTONGUE        "Take me to the other Deathsworn, Olum."
#define GOSSIP_ILLIDARI         "I'm ready. Take me to the Chamber of Command."

bool GossipHello_npc_spirit_of_olum(Player* player, Creature* _Creature)
{
    ScriptedInstance* pInstance = (_Creature->GetInstanceData());

    if(pInstance)
    {
        if (pInstance->GetData(EVENT_SUPREMUS) >= DONE && pInstance->GetData(EVENT_HIGHWARLORDNAJENTUS) >= DONE)
        {
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ASHTONGUE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            if (pInstance->GetData(EVENT_ILLIDARICOUNCIL) >= DONE)
                player->ADD_GOSSIP_ITEM(0, GOSSIP_ILLIDARI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(TELEPORT_GOSSIP, _Creature->GetGUID());
        }
        else
            player->SEND_GOSSIP_MENU(WELCOME_GOSSIP, _Creature->GetGUID());
    }
    return true;
}

bool GossipSelect_npc_spirit_of_olum(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    switch(action)
    {
        case (GOSSIP_ACTION_INFO_DEF + 1):
            player->InterruptNonMeleeSpells(false);
            player->CastSpell(player, SPELL_TELEPORT_ASHTONGUE, false);
            player->CLOSE_GOSSIP_MENU();
            break;
        case (GOSSIP_ACTION_INFO_DEF + 2):
            player->InterruptNonMeleeSpells(false);
            player->CastSpell(player, SPELL_TELEPORT_ILLIDARI, false);
            player->CLOSE_GOSSIP_MENU();
            break;
        default:
            break;
    }
    return true;
}

/*###
# npc_spirit_of_udalo
####*/

bool GossipHello_npc_spirit_of_udalo(Player* player, Creature* _Creature)
{
    ScriptedInstance* pInstance = (_Creature->GetInstanceData());

    if(pInstance)
    {
            if (pInstance->GetData(EVENT_ILLIDARICOUNCIL) >= DONE)
            {
                player->ADD_GOSSIP_ITEM(0, GOSSIP_ILLIDARI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(TELEPORT_GOSSIP, _Creature->GetGUID());
            }
            else
                player->SEND_GOSSIP_MENU(WELCOME_GOSSIP, _Creature->GetGUID());
    }
    return true;
}

bool GossipSelect_npc_spirit_of_udalo(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    switch(action)
    {
        case (GOSSIP_ACTION_INFO_DEF + 1):
            player->InterruptNonMeleeSpells(false);
            player->CastSpell(player, SPELL_TELEPORT_ILLIDARI, false);
            player->CLOSE_GOSSIP_MENU();
            break;
        default:
            break;
    }
    return true;
}

void AddSC_black_temple()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_spirit_of_olum";
    newscript->pGossipHello = &GossipHello_npc_spirit_of_olum;
    newscript->pGossipSelect = &GossipSelect_npc_spirit_of_olum;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_spirit_of_udalo";
    newscript->pGossipHello = &GossipHello_npc_spirit_of_udalo;
    newscript->pGossipSelect = &GossipSelect_npc_spirit_of_udalo;
    newscript->RegisterSelf();
}

