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
SDName: Npc_Innkeeper
SD%Complete: 50
SDComment: This script are currently not in use. EventSystem cannot be used on Windows build of SD2
SDCategory: NPCs
EndScriptData */

#include "precompiled.h"
#include "GameEvent.h"

#define HALLOWEEN_EVENTID       12
#define SPELL_TRICK_OR_TREATED  24755
#define SPELL_TREAT             24715

#define LOCALE_TRICK_OR_TREAT_0 "Trick or Treat!"
#define LOCALE_TRICK_OR_TREAT_2 "Des bonbons ou des blagues!"
#define LOCALE_TRICK_OR_TREAT_3 "S��es oder Saures!"
#define LOCALE_TRICK_OR_TREAT_6 "�Truco o trato!"

bool isEventActive()
{
    return isGameEventActive(HALLOWEEN_EVENTID);
}

bool GossipHello_npc_innkeeper(Player *player, Creature *_Creature)
{

    player->TalkedToCreature(_Creature->GetEntry(),_Creature->GetGUID());

    _Creature->prepareGossipMenu(player,0); //send innkeeper menu too
    
    if (isEventActive()&& !player->GetAura(SPELL_TRICK_OR_TREATED,0))
    {
        const char* localizedEntry;
        switch (player->GetSession()->GetSessionDbLocaleIndex())
        {
            case 0:
                localizedEntry=LOCALE_TRICK_OR_TREAT_0;
                break;
            case 2:
                localizedEntry=LOCALE_TRICK_OR_TREAT_2;
                break;
            case 3:
                localizedEntry=LOCALE_TRICK_OR_TREAT_3;
                break;
            case 6:
                localizedEntry=LOCALE_TRICK_OR_TREAT_6;
                break;
            default:
                localizedEntry=LOCALE_TRICK_OR_TREAT_0;
        }

        player->ADD_GOSSIP_ITEM(0, localizedEntry, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+HALLOWEEN_EVENTID);
    }

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_innkeeper(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF+HALLOWEEN_EVENTID && isEventActive() && !player->GetAura(SPELL_TRICK_OR_TREATED,0))
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player, SPELL_TRICK_OR_TREATED, true);

        // either trick or treat, 50% chance
        if(rand()%2)
        {
            player->CastSpell(player, SPELL_TREAT, true);
        }
        else
        {
            int32 trickspell=0;
            switch (rand()%9)                               // note that female characters can get male costumes and vice versa
            {
                case 0:
                    trickspell=24753;                       // cannot cast, random 30sec
                    break;
                case 1:
                    trickspell=24713;                       // lepper gnome costume
                    break;
                case 2:
                    trickspell=24735;                       // male ghost costume
                    break;
                case 3:
                    trickspell=24736;                       // female ghostcostume
                    break;
                case 4:
                    trickspell=24710;                       // male ninja costume
                    break;
                case 5:
                    trickspell=24711;                       // female ninja costume
                    break;
                case 6:
                    trickspell=24708;                       // male pirate costume
                    break;
                case 7:
                    trickspell=24709;                       // female pirate costume
                    break;
                case 8:
                    trickspell=24723;                       // skeleton costume
                    break;
            }
            player->CastSpell(player, trickspell, true);
        }
        return true;                                        // prevent Trinity core handling
    }
    //Trininty Gossip core handling dont work...
    else if (action == GOSSIP_OPTION_VENDOR)
    {
        player->SEND_VENDORLIST( _Creature->GetGUID() );
    return true;
    }
    else if (action == GOSSIP_OPTION_INNKEEPER)
    {
        player->PlayerTalkClass->CloseGossip();
        player->SetBindPoint( _Creature->GetGUID() );
    return true;
    }

    return false;  // no player selection
}

void AddSC_npc_innkeeper()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="npc_innkeeper";
    newscript->pGossipHello = &GossipHello_npc_innkeeper;
    newscript->pGossipSelect = &GossipSelect_npc_innkeeper;
    newscript->RegisterSelf();
}

