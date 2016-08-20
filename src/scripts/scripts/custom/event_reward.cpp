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
SDName: Custom_Example
SD%Complete: 100
SDComment: Used for event rewards
SDCategory: Script Examples
EndScriptData */

#include "precompiled.h"
#include <cstring>

#define ITEM_MARKE          1536

#define ITEM_MARKE_COUNT_1  1
#define ITEM_MARKE_COUNT_2  1
#define ITEM_MARKE_COUNT_3  1
#define ITEM_MARKE_COUNT_4  1

#define ITEM_MARKE_COUNT_5  1
#define ITEM_MARKE_COUNT_6  2

#define ITEM_MARKE_COUNT_7  1
#define ITEM_MARKE_COUNT_8  1
#define ITEM_MARKE_COUNT_9  1
#define ITEM_MARKE_COUNT_10 1
#define ITEM_MARKE_COUNT_11 1
#define ITEM_MARKE_COUNT_12 1
#define ITEM_MARKE_COUNT_13 1
#define ITEM_MARKE_COUNT_14 1
#define ITEM_MARKE_COUNT_15 1
#define ITEM_MARKE_COUNT_16 1
#define ITEM_MARKE_COUNT_17 1
#define ITEM_MARKE_COUNT_18 1
#define ITEM_MARKE_COUNT_19 1
#define ITEM_MARKE_COUNT_20 1
#define ITEM_MARKE_COUNT_21 1
#define ITEM_MARKE_COUNT_22 1
#define ITEM_MARKE_COUNT_23 1
#define ITEM_MARKE_COUNT_24 1
#define ITEM_MARKE_COUNT_25 1
#define ITEM_MARKE_COUNT_26 1
#define ITEM_MARKE_COUNT_27 1
#define ITEM_MARKE_COUNT_28 1
#define ITEM_MARKE_COUNT_29 2
#define ITEM_MARKE_COUNT_30 2

/*
20558 - Ehrenabzeichen der Kriegshymnenschlucht
20559 - Ehrenabzeichen des Arathibeckens
20560 - Ehrenabzeichen des Alteractals
29024 - Ehrenabzeichen vom Auge des Sturms 


1000022 - L4G Talent Reset Münze  
1000023 - L4G Maxskill Münze


21886 – Urleben
21885 – Urwasser
21884 – Urfeuer
22451 – Urluft
22452 – Urerde
22456 – Urschatten

32898 - Fläschchen der Stärkung aus Shattrath  
32899 - Fläschchen der mächtigen Wiederherstellung aus Shattrath  
32900 - Fläschchen der obersten Macht aus Shattrath
32901 - Fläschchen des unerbittlichen Angriffs aus Shattrath
35716 - Fläschchen des reinen Todes aus Shattrath
35717 - Fläschchen des blendenden Lichts aus Shattrath


27667 - Würziger Flusskrebs ( +30 Ausdauer)
31673 - Knusperschlange  ( +23 Zauberschaden)
27659 - Doppelwarper  ( +20 Beweglichkeit)
27658 - Gerösteter Grollhuf ( +20 Stärke) 
27666 – Goldfischstäbchen ( +44 Heilzauber)
33872 - Feuriger Würztalbuk ( +20 Trefferwertung)
27655 - Heißer Hetzer ( +40 Angriffskraft)
27656 - Sporlingschmaus ( +20 Ausdauer deines Begleiters)
33874 - Kiblers Häppchen ( +20 Stärke deines Begleiters)
*/
//-------------ITEM IDs-------------------------
#define ITEM_ID_1           20558
#define ITEM_ID_2           20559
#define ITEM_ID_3           20560
#define ITEM_ID_4           29024

#define ITEM_ID_5           1000022
#define ITEM_ID_6           1000023

#define ITEM_ID_7           21886
#define ITEM_ID_8           21885
#define ITEM_ID_9           21884
#define ITEM_ID_10          22451
#define ITEM_ID_11          22452
#define ITEM_ID_12          22456

#define ITEM_ID_13          32898
#define ITEM_ID_14          32899
#define ITEM_ID_15          32900
#define ITEM_ID_16          32901
#define ITEM_ID_17          35716
#define ITEM_ID_18          35717

#define ITEM_ID_19          27667
#define ITEM_ID_20          31673
#define ITEM_ID_21          27659
#define ITEM_ID_22          27658
#define ITEM_ID_23          27666
#define ITEM_ID_24          33872
#define ITEM_ID_25          27655
#define ITEM_ID_26          27656
#define ITEM_ID_27          33874

#define ITEM_ID_28          "ehre"
#define ITEM_ID_29          34492
#define ITEM_ID_30          34493

//-------------ITEM COUNT----------------------------

#define ITEM_COUNT_1        5
#define ITEM_COUNT_2        5
#define ITEM_COUNT_3        5
#define ITEM_COUNT_4        5

#define ITEM_COUNT_5        1
#define ITEM_COUNT_6        1

#define ITEM_COUNT_7        1
#define ITEM_COUNT_8        1
#define ITEM_COUNT_9        1
#define ITEM_COUNT_10       1
#define ITEM_COUNT_11       1
#define ITEM_COUNT_12       1

#define ITEM_COUNT_13       1
#define ITEM_COUNT_14       1
#define ITEM_COUNT_15       1
#define ITEM_COUNT_16       1
#define ITEM_COUNT_17       1
#define ITEM_COUNT_18       1

#define ITEM_COUNT_19       3
#define ITEM_COUNT_20       3
#define ITEM_COUNT_21       3
#define ITEM_COUNT_22       3
#define ITEM_COUNT_23       3
#define ITEM_COUNT_24       3
#define ITEM_COUNT_25       3
#define ITEM_COUNT_26       3
#define ITEM_COUNT_27       3

#define ITEM_COUNT_28       700
#define ITEM_COUNT_29       1
#define ITEM_COUNT_30       1

//---------------------------ITEM NAME--------------------------------

#define ITEM_NAME_1         "5 Ehrenabzeichen der Kriegshymnenschlucht"
#define ITEM_NAME_2         "5 Ehrenabzeichen des Arathibeckens"
#define ITEM_NAME_3         "5 Ehrenabzeichen des Alteractals"
#define ITEM_NAME_4         "5 Ehrenabzeichen vom Auge des Sturms"

#define ITEM_NAME_5         "L4G Talent Reset Coin"
#define ITEM_NAME_6         "L4G Maxskill Coin"

#define ITEM_NAME_7         "Urleben"
#define ITEM_NAME_8         "Urwasser"
#define ITEM_NAME_9         "Urfeuer"
#define ITEM_NAME_10        "Urluft"
#define ITEM_NAME_11        "Urerde"
#define ITEM_NAME_12        "Urschatten"

#define ITEM_NAME_13        "Flaeschchen der Staerkung aus Shattrath "
#define ITEM_NAME_14        "Flaeschchen der maechtigen Wiederherstellung aus Shattrath"
#define ITEM_NAME_15        "Flaeschchen der obersten Macht aus Shattrath"
#define ITEM_NAME_16        "Flaeschchen des unerbittlichen Angriffs aus Shattrath"
#define ITEM_NAME_17        "Flaeschchen des reinen Todes aus Shattrath"
#define ITEM_NAME_18        "Flaeschchen des blendenden Lichts aus Shattrath"

#define ITEM_NAME_19        "3 Wuerziger Flusskrebs ( +30 Ausdauer)"
#define ITEM_NAME_20        "3 Knusperschlange  ( +23 Zauberschaden)"
#define ITEM_NAME_21        "3 Doppelwarper  ( +20 Beweglichkeit)"
#define ITEM_NAME_22        "3 Geroesteter Grollhuf ( +20 Staerke)"
#define ITEM_NAME_23        "3 Goldfischstaebchen ( +44 Heilzauber)"
#define ITEM_NAME_24        "3 Feuriger Wuerztalbuk ( +20 Trefferwertung)"
#define ITEM_NAME_25        "3 Heisser Hetzer ( +40 Angriffskraft)"
#define ITEM_NAME_26        "3 Sporlingschmaus ( +20 Ausdauer deines Begleiters)"
#define ITEM_NAME_27        "3 Kiblers Haeppchen ( +20 Staerke deines Begleiters)"

#define ITEM_NAME_28        "700 Ehre"
#define ITEM_NAME_29        "Raketenhuehnchen"
#define ITEM_NAME_30        "Papierdrache"


//--------------------------- PAGE -----------------------------

#define CATEGORY_1          "Ehrenabzeichen"
#define CATEGORY_2          "L4G Coins"
#define CATEGORY_3          "Urmats"
#define CATEGORY_4          "Buffood & Flasks"
#define CATEGORY_5          "Ehre & Pets"
#define CATEGORY_6          "Frei"


bool GossipHello_event_reward(Player *Player, Creature *Creature) {
    if (Creature->isVendor())
        Player->ADD_GOSSIP_ITEM( 1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

    Player->ADD_GOSSIP_ITEM(0, CATEGORY_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1000);
    Player->ADD_GOSSIP_ITEM(0, CATEGORY_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2000);
    Player->ADD_GOSSIP_ITEM(0, CATEGORY_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3000);
    Player->ADD_GOSSIP_ITEM(0, CATEGORY_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4000);
    Player->ADD_GOSSIP_ITEM(0, CATEGORY_5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5000);
    Player->PlayerTalkClass->SendGossipMenu(40001, Creature->GetGUID());
    return true;
}

bool GossipSelect_event_reward(Player* Player, Creature* Creature, uint32 /*sender*/, uint32 action) {
    switch (action) {
         case GOSSIP_ACTION_TRADE:
         {
            Player->SEND_VENDORLIST( Creature->GetGUID() );
            break;
         }
         case GOSSIP_ACTION_INFO_DEF + 1000:
         {
            Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            break;
         }
         case GOSSIP_ACTION_INFO_DEF + 2000:
         {
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
             Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
             Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
             break;
         }
         case GOSSIP_ACTION_INFO_DEF + 3000:
         {
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_8, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_9, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_10, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_11, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_12, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
             Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
             Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
             break;
         }
         case GOSSIP_ACTION_INFO_DEF + 4000:
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_13, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_14, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_15, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 15);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_16, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 16);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_17, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 17);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_18, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 18);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_19, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 19);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_20, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 20);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_21, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 21);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_22, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 22);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_23, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 23);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_24, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 24);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_25, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 25);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_26, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 26);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_27, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 27);
             Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
             Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
             break;
         case GOSSIP_ACTION_INFO_DEF + 5000:
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_28, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 28);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_29, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 29);
             Player->ADD_GOSSIP_ITEM(0, ITEM_NAME_30, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 30);
             Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
             Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
             break;
         case GOSSIP_ACTION_INFO_DEF + 1:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_1, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_1, true, false);
                Player->AddItem(ITEM_ID_1, ITEM_COUNT_1);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_2, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_2, true, false);
                Player->AddItem(ITEM_ID_2, ITEM_COUNT_2);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 3:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_3, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_3, true, false);
                Player->AddItem(ITEM_ID_3, ITEM_COUNT_3);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 4:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_4, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_4, true, false);
                Player->AddItem(ITEM_ID_4, ITEM_COUNT_4);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 5:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_5, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_5, true, false);
                Player->AddItem(ITEM_ID_5, ITEM_COUNT_5);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 6:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_6, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_6, true, false);
                Player->AddItem(ITEM_ID_6, ITEM_COUNT_6);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 7:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_7, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_7, true, false);
                Player->AddItem(ITEM_ID_7, ITEM_COUNT_7);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 8:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_8, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_8, true, false);
                Player->AddItem(ITEM_ID_8, ITEM_COUNT_8);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 9:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_9, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_9, true, false);
                Player->AddItem(ITEM_ID_9, ITEM_COUNT_9);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 10:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_10, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_10, true, false);
                Player->AddItem(ITEM_ID_10, ITEM_COUNT_10);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 11:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_11, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_11, true, false);
                Player->AddItem(ITEM_ID_11, ITEM_COUNT_11);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 12:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_12, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_12, true, false);
                Player->AddItem(ITEM_ID_12, ITEM_COUNT_12);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 13:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_13, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_13, true, false);
                Player->AddItem(ITEM_ID_13, ITEM_COUNT_13);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 14:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_14, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_14, true, false);
                Player->AddItem(ITEM_ID_14, ITEM_COUNT_14);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 15:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_15, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_15, true, false);
                Player->AddItem(ITEM_ID_15, ITEM_COUNT_15);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 16:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_16, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_16, true, false);
                Player->AddItem(ITEM_ID_16, ITEM_COUNT_16);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 17:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_17, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_17, true, false);
                Player->AddItem(ITEM_ID_17, ITEM_COUNT_17);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 18:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_18, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_18, true, false);
                Player->AddItem(ITEM_ID_18, ITEM_COUNT_18);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 19:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_19, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_19, true, false);
                Player->AddItem(ITEM_ID_19, ITEM_COUNT_19);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 20:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_20, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_20, true, false);
                Player->AddItem(ITEM_ID_20, ITEM_COUNT_20);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 21:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_21, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_21, true, false);
                Player->AddItem(ITEM_ID_21, ITEM_COUNT_21);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 22:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_22, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_22, true, false);
                Player->AddItem(ITEM_ID_22, ITEM_COUNT_22);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 23:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_23, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_23, true, false);
                Player->AddItem(ITEM_ID_23, ITEM_COUNT_23);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 24:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_24, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_24, true, false);
                Player->AddItem(ITEM_ID_24, ITEM_COUNT_24);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 25:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_25, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_25, true, false);
                Player->AddItem(ITEM_ID_25, ITEM_COUNT_25);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 26:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_26, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_26, true, false);
                Player->AddItem(ITEM_ID_26, ITEM_COUNT_26);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 27:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_27, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_27, true, false);
                Player->AddItem(ITEM_ID_27, ITEM_COUNT_27);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 28:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_28, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_28, true, false);
                Player->ModifyHonorPoints(ITEM_COUNT_28);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 29:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_29, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_29, true, false);
                Player->AddItem(ITEM_ID_29, ITEM_COUNT_29);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 30:
            Player->ADD_GOSSIP_ITEM(0, "Zurueck", 0, 0);
            if (Player->HasItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_30, false))
            {
                Player->DestroyItemCount(ITEM_MARKE, ITEM_MARKE_COUNT_30, true, false);
                Player->AddItem(ITEM_ID_30, ITEM_COUNT_30);
                Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
            }
            else
                Player->PlayerTalkClass->SendGossipMenu(40002,Creature->GetGUID());
            break;
        default:
            GossipHello_event_reward(Player,Creature);
    }
    return true;
}

void AddSC_event_reward() {

    Script *newscript;
    newscript = new Script;
    newscript->Name = "event_reward";
    newscript->pGossipHello = &GossipHello_event_reward;
    newscript->pGossipSelect = &GossipSelect_event_reward;
    newscript->RegisterSelf();
}