/*
##################################################################
#Verzuaberungs NPC wie er auf AT war							 #
#Für den NPC in der Datenbank:									 #	
INSERT INTO `creature_template` (`entry`, `modelid_A`, `modelid_H`, `name`, `subname`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `type`, `ScriptName`) VALUES ('1000033', '17870', '17870', 'Verzauberungskunst', 'BETA', '70', '70', '10000', '10000', '10000', '10000', '10000', '35', '35', '10', 'enchant_npc');
UPDATE `creature_template` SET `npcflag`='1', `scale`='0.5'	 WHERE (`entry`='1000033');																	
##################################################################
*/

#include "precompiled.h"
#include <cstring>
#include "Chat.h"
#include "Player.h"

bool GossipHello_enchant_npc(Player *Player, Creature *Creature)
{
	if (Player->isInCombat())
	{
		Creature->Say("Du befindest dich im Kampf!",LANG_UNIVERSAL, 0);
		return true;
	}

	Player->ADD_GOSSIP_ITEM(9,"Kopf Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1 );
	Player->ADD_GOSSIP_ITEM(9,"Schulter Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+2 );
	Player->ADD_GOSSIP_ITEM(9,"Ruecken Verzaubernungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+3 );
	Player->ADD_GOSSIP_ITEM(9,"Burst Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+4 );
	Player->ADD_GOSSIP_ITEM(9,"Handgelenke Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+5 );
	Player->ADD_GOSSIP_ITEM(9,"Handschuhe Verzuaberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+6 );
	Player->ADD_GOSSIP_ITEM(9,"Bein Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+7 );
	Player->ADD_GOSSIP_ITEM(9,"Stiefel Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+8 );
	Player->ADD_GOSSIP_ITEM(9,"Finger Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+9 );
	Player->ADD_GOSSIP_ITEM(9,"Finger2 Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+10 );
	Player->ADD_GOSSIP_ITEM(9,"Zweihandwaffen Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+11 );
	Player->ADD_GOSSIP_ITEM(9,"Waffenhand Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+12 );
	//Player->ADD_GOSSIP_ITEM(9,"Waffenhand Verzauberungen 2",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+13 );
	Player->ADD_GOSSIP_ITEM(9,"Schildhand Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+14 );
	Player->ADD_GOSSIP_ITEM(9,"Fernkampfwaffen Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+16 );
	Player->ADD_GOSSIP_ITEM(9,"Schild Verzauberungen ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+17 );
	Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	return true;
}

bool GossipSelect_enchant_npc(Player* Player, Creature* Creature, uint32 sender, uint32 action)
{
	if (Player->isInCombat())
	{
		Creature->Say("Du befindest dich im Kampf!",LANG_UNIVERSAL, 0);
		return true;
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+1)
	{
		Player->ADD_GOSSIP_ITEM(9,"34 Angriffskraft 16 Trefferwertung ",EQUIPMENT_SLOT_HEAD,35452);
		Player->ADD_GOSSIP_ITEM(9,"17 Staerke 16 Intelligenz ",EQUIPMENT_SLOT_HEAD,37891);
		Player->ADD_GOSSIP_ITEM(9,"22 Zauberschaden 14 Trefferwertung ",EQUIPMENT_SLOT_HEAD,35447);
		Player->ADD_GOSSIP_ITEM(9,"35 Heilung 12 Zauberschaden 7 mp5",EQUIPMENT_SLOT_HEAD,35445);
		Player->ADD_GOSSIP_ITEM(9,"18 Ausdauer 20 Abhaertungswertung ",EQUIPMENT_SLOT_HEAD,35453);
		Player->ADD_GOSSIP_ITEM(9,"16 Verteidigung 17 Ausweichen ",EQUIPMENT_SLOT_HEAD,35443);
		Player->ADD_GOSSIP_ITEM(9,"20 Feuer Resistenz ",EQUIPMENT_SLOT_HEAD,35456);
		Player->ADD_GOSSIP_ITEM(9,"20 Arkan Resistenz ",EQUIPMENT_SLOT_HEAD,35455);
		Player->ADD_GOSSIP_ITEM(9,"20 Schatten Resistenz ",EQUIPMENT_SLOT_HEAD,35458);
		Player->ADD_GOSSIP_ITEM(9,"20 Natur Resistenz ",EQUIPMENT_SLOT_HEAD,35454);
		Player->ADD_GOSSIP_ITEM(9,"20 Frost Resistenz ",EQUIPMENT_SLOT_HEAD,35457);
		Player->ADD_GOSSIP_ITEM(9,"8 Alle Widerstaende ",EQUIPMENT_SLOT_HEAD,37889);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+2)
	{
		Player->ADD_GOSSIP_ITEM(9,"30 Angriffskraft 10 Krit ",EQUIPMENT_SLOT_SHOULDERS,35417);
		Player->ADD_GOSSIP_ITEM(9,"26 Angriffskraft 14 Krit ",EQUIPMENT_SLOT_SHOULDERS,29483);
		Player->ADD_GOSSIP_ITEM(9,"20 Angriffskraft 15 Krit ",EQUIPMENT_SLOT_SHOULDERS,35439);
		Player->ADD_GOSSIP_ITEM(9,"18 Zauberschaden 10 Krit ",EQUIPMENT_SLOT_SHOULDERS,35406);
		Player->ADD_GOSSIP_ITEM(9,"15 Zauberschaden 14 Krit ",EQUIPMENT_SLOT_SHOULDERS,29467);
		Player->ADD_GOSSIP_ITEM(9,"12 Zauberschaden 15 Krit ",EQUIPMENT_SLOT_SHOULDERS,35437);
		Player->ADD_GOSSIP_ITEM(9,"33 Heilung 11 Zauberschaden 4 mp5",EQUIPMENT_SLOT_SHOULDERS,35404);
		Player->ADD_GOSSIP_ITEM(9,"31 Heilung 11 Zauberschaden 5 mp5",EQUIPMENT_SLOT_SHOULDERS,29475);
		Player->ADD_GOSSIP_ITEM(9,"22 Heilung 6 mp5 ",EQUIPMENT_SLOT_SHOULDERS,35435);
		Player->ADD_GOSSIP_ITEM(9,"16 Ausdauer 100 Ruestung ",EQUIPMENT_SLOT_SHOULDERS,29480);
		Player->ADD_GOSSIP_ITEM(9,"10 Ausweichen 15 Verteidigung ",EQUIPMENT_SLOT_SHOULDERS,35433);
		Player->ADD_GOSSIP_ITEM(9,"15 Ausweichen 10 Verteidigung ",EQUIPMENT_SLOT_SHOULDERS,35402);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+3)
	{
		Player->ADD_GOSSIP_ITEM(9,"12 Beweglichkeit ",EQUIPMENT_SLOT_BACK,34004);
		Player->ADD_GOSSIP_ITEM(9,"20 Zauberdurchschlagskraft ",EQUIPMENT_SLOT_BACK,34003);
		Player->ADD_GOSSIP_ITEM(9,"15 Feuer Resistenz ",EQUIPMENT_SLOT_BACK,25081);
		Player->ADD_GOSSIP_ITEM(9,"15 Arkan Resistenz ",EQUIPMENT_SLOT_BACK,34005);
		Player->ADD_GOSSIP_ITEM(9,"15 Schatten Resistenz ",EQUIPMENT_SLOT_BACK,34006);
		Player->ADD_GOSSIP_ITEM(9,"15 Natur Resistenz ",EQUIPMENT_SLOT_BACK,25082);
		Player->ADD_GOSSIP_ITEM(9,"7 Alle Widerstaende ",EQUIPMENT_SLOT_BACK,27962);
		Player->ADD_GOSSIP_ITEM(9,"12 Ausweichen ",EQUIPMENT_SLOT_BACK,25086);
		Player->ADD_GOSSIP_ITEM(9,"12 Verteidigung ",EQUIPMENT_SLOT_BACK,47051);
		Player->ADD_GOSSIP_ITEM(9,"120 Ruestung ",EQUIPMENT_SLOT_BACK,27961);
		Player->ADD_GOSSIP_ITEM(9,"Unsichtbarkeitserhoeung ",EQUIPMENT_SLOT_BACK,25083);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+4)
	{
		Player->ADD_GOSSIP_ITEM(9,"15 Abhaertungswertung ",EQUIPMENT_SLOT_CHEST,33992);
		Player->ADD_GOSSIP_ITEM(9,"6 Alle Werte ",EQUIPMENT_SLOT_CHEST,27960);
		Player->ADD_GOSSIP_ITEM(9,"15 Willenskraft ",EQUIPMENT_SLOT_CHEST,33990);
		Player->ADD_GOSSIP_ITEM(9,"15 Verteidigung ",EQUIPMENT_SLOT_CHEST,46594);
		Player->ADD_GOSSIP_ITEM(9,"150 Gesundheit ",EQUIPMENT_SLOT_CHEST,27957);
		Player->ADD_GOSSIP_ITEM(9,"150 Mana ",EQUIPMENT_SLOT_CHEST,27958);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+5)
	{
		Player->ADD_GOSSIP_ITEM(9,"24 Angriffskraft ",EQUIPMENT_SLOT_WRISTS,34002);
		Player->ADD_GOSSIP_ITEM(9,"15 Zauberschaden ",EQUIPMENT_SLOT_WRISTS,27917);
		Player->ADD_GOSSIP_ITEM(9,"30 Heilung 10 Zauberschaden ",EQUIPMENT_SLOT_WRISTS,27911);
		Player->ADD_GOSSIP_ITEM(9,"12 Ausdauer ",EQUIPMENT_SLOT_WRISTS,27914);
		Player->ADD_GOSSIP_ITEM(9,"12 Verteidigung ",EQUIPMENT_SLOT_WRISTS,27906);
		Player->ADD_GOSSIP_ITEM(9,"12 Staerke ",EQUIPMENT_SLOT_WRISTS,27899);
		Player->ADD_GOSSIP_ITEM(9,"12 Intelligenz ",EQUIPMENT_SLOT_WRISTS,34001);
		Player->ADD_GOSSIP_ITEM(9,"4 Alle Werte ",EQUIPMENT_SLOT_WRISTS,27905);
		Player->ADD_GOSSIP_ITEM(9,"6 mp5 ",EQUIPMENT_SLOT_WRISTS,27913);
		Player->ADD_GOSSIP_ITEM(9,"9 Willenskraft ",EQUIPMENT_SLOT_WRISTS,20009);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+6)
	{
		Player->ADD_GOSSIP_ITEM(9,"26 Angriffskraft ",EQUIPMENT_SLOT_HANDS,33996);
		Player->ADD_GOSSIP_ITEM(9,"15 Staerke ",EQUIPMENT_SLOT_HANDS,33995);
		Player->ADD_GOSSIP_ITEM(9,"15 Beweglichkeit ",EQUIPMENT_SLOT_HANDS,25080);
		Player->ADD_GOSSIP_ITEM(9,"20 Zauberschaden ",EQUIPMENT_SLOT_HANDS,33997);
		Player->ADD_GOSSIP_ITEM(9,"35 Heilung 12 Zauberschaden ",EQUIPMENT_SLOT_HANDS,33999);
		Player->ADD_GOSSIP_ITEM(9,"15 Zauber Trefferwertung ",EQUIPMENT_SLOT_HANDS,33994);
		Player->ADD_GOSSIP_ITEM(9,"10 Zauber Krit ",EQUIPMENT_SLOT_HANDS,33993);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+7)
	{
		Player->ADD_GOSSIP_ITEM(9,"50 Angriffskraft 12 Krit ",EQUIPMENT_SLOT_LEGS,29535);
		Player->ADD_GOSSIP_ITEM(9,"40 Ausdauer 12 Beweglichkeit ",EQUIPMENT_SLOT_LEGS,35495);
		Player->ADD_GOSSIP_ITEM(9,"35 Zauberschaden 20 Ausdauer ",EQUIPMENT_SLOT_LEGS,31372);
		Player->ADD_GOSSIP_ITEM(9,"66 Heilung 22 Zauberschaden 20 Ausdauer ",EQUIPMENT_SLOT_LEGS,31370);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+8)
	{
		Player->ADD_GOSSIP_ITEM(9,"Geringe Bewegungstempo Erhoeung 6 Beweglichkeit ",EQUIPMENT_SLOT_FEET,34007);
		Player->ADD_GOSSIP_ITEM(9,"Geringe Bewegungstempo Erhoeung 9 Ausdauer ",EQUIPMENT_SLOT_FEET,34008);
		Player->ADD_GOSSIP_ITEM(9,"Sicherer Stand",EQUIPMENT_SLOT_FEET,27954);
		Player->ADD_GOSSIP_ITEM(9,"12 Beweglichkeit ",EQUIPMENT_SLOT_FEET,27951);
		Player->ADD_GOSSIP_ITEM(9,"12 Ausdauer ",EQUIPMENT_SLOT_FEET,27950);
		Player->ADD_GOSSIP_ITEM(9,"4 hp/mp5 ",EQUIPMENT_SLOT_FEET,27948);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+9)
	{
		Player->ADD_GOSSIP_ITEM(9,"4 Alle Werte ",EQUIPMENT_SLOT_FINGER1,27927);
		Player->ADD_GOSSIP_ITEM(9,"12 Zauberschaden ",EQUIPMENT_SLOT_FINGER1,27924);
		Player->ADD_GOSSIP_ITEM(9,"20 Heilung 7 Zauberschaden ",EQUIPMENT_SLOT_FINGER1,27926);
		Player->ADD_GOSSIP_ITEM(9,"2 Waffenschaden ",EQUIPMENT_SLOT_FINGER1,27920);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+10)
	{
		Player->ADD_GOSSIP_ITEM(9,"4 Alle Werte ",EQUIPMENT_SLOT_FINGER2,27927);
		Player->ADD_GOSSIP_ITEM(9,"12 Zauberschaden ",EQUIPMENT_SLOT_FINGER2,27924);
		Player->ADD_GOSSIP_ITEM(9,"20 Heilung 7 Zauberschaden ",EQUIPMENT_SLOT_FINGER2,27926);
		Player->ADD_GOSSIP_ITEM(9,"2 Waffenschaden ",EQUIPMENT_SLOT_FINGER2,27920);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+11)
	{
		Player->ADD_GOSSIP_ITEM(9,"70 Angriffskraft ",EQUIPMENT_SLOT_MAINHAND,27971);
		Player->ADD_GOSSIP_ITEM(9,"35 Beweglichkeit ",EQUIPMENT_SLOT_MAINHAND,27977);
		Player->ADD_GOSSIP_ITEM(9,"9 Schaden ",EQUIPMENT_SLOT_MAINHAND,20030);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+12)
	{
		Player->ADD_GOSSIP_ITEM(9,"Mungo ",EQUIPMENT_SLOT_MAINHAND,27984);
		Player->ADD_GOSSIP_ITEM(9,"Scharfrichter ",EQUIPMENT_SLOT_MAINHAND,42974);
		Player->ADD_GOSSIP_ITEM(9,"20 Staerke ",EQUIPMENT_SLOT_MAINHAND,27972);
		Player->ADD_GOSSIP_ITEM(9,"20 Beweglichkeit ",EQUIPMENT_SLOT_MAINHAND,42620);
		Player->ADD_GOSSIP_ITEM(9,"40 Zauberschaden ",EQUIPMENT_SLOT_MAINHAND,27975);
		Player->ADD_GOSSIP_ITEM(9,"81 Heilung 27 Zauberschaden ",EQUIPMENT_SLOT_MAINHAND,34010);
		Player->ADD_GOSSIP_ITEM(9,"20 Willenskraft ",EQUIPMENT_SLOT_MAINHAND,23803);
		Player->ADD_GOSSIP_ITEM(9,"7 Waffenschaden ",EQUIPMENT_SLOT_MAINHAND,27967);
		Player->ADD_GOSSIP_ITEM(9,"50 Arkan/Feuer Zauberschaden ",EQUIPMENT_SLOT_MAINHAND,27981);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->ADD_GOSSIP_ITEM(9,"Weiter -> ",GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+13);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+13)
	{
		Player->ADD_GOSSIP_ITEM(9,"30 Intelligenz ",EQUIPMENT_SLOT_MAINHAND,27968);
		Player->ADD_GOSSIP_ITEM(9,"Meister des Kampfes ",EQUIPMENT_SLOT_MAINHAND,28004);
		Player->ADD_GOSSIP_ITEM(9,"Lebensdiebstahl ",EQUIPMENT_SLOT_MAINHAND,20032);
		Player->ADD_GOSSIP_ITEM(9,"Kreuzfahrer ",EQUIPMENT_SLOT_MAINHAND,20034);
		Player->ADD_GOSSIP_ITEM(9,"Todeskaelte ",EQUIPMENT_SLOT_MAINHAND,46578);
		Player->ADD_GOSSIP_ITEM(9,"Feurige Waffe ",EQUIPMENT_SLOT_MAINHAND,13898);
		Player->ADD_GOSSIP_ITEM(9,"Eisige Waffe ",EQUIPMENT_SLOT_MAINHAND,20029);
		Player->ADD_GOSSIP_ITEM(9,"Zauberflut ",EQUIPMENT_SLOT_MAINHAND,28003);
		Player->ADD_GOSSIP_ITEM(9,"Adamantitwaffenkette ",EQUIPMENT_SLOT_MAINHAND,42687);
		Player->ADD_GOSSIP_ITEM(9,"54 Schatten/Frost Zauberschaden ",EQUIPMENT_SLOT_MAINHAND,27982);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+14)
	{
		Player->ADD_GOSSIP_ITEM(9,"Mungo ",EQUIPMENT_SLOT_OFFHAND,27984);
		Player->ADD_GOSSIP_ITEM(9,"Scharfrichter ",EQUIPMENT_SLOT_OFFHAND,42974);
		Player->ADD_GOSSIP_ITEM(9,"20 Staerke ",EQUIPMENT_SLOT_OFFHAND,27972);
		Player->ADD_GOSSIP_ITEM(9,"20 Beweglichkeit ",EQUIPMENT_SLOT_OFFHAND,42620);
		Player->ADD_GOSSIP_ITEM(9,"7 Waffenschaden ",EQUIPMENT_SLOT_OFFHAND,27967);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->ADD_GOSSIP_ITEM(9,"Weiter -> ",GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+15);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+15)
	{
		Player->ADD_GOSSIP_ITEM(9,"Meister des Kampfes ",EQUIPMENT_SLOT_OFFHAND,28004);
		Player->ADD_GOSSIP_ITEM(9,"Lebensdiebstahl ",EQUIPMENT_SLOT_OFFHAND,20032);
		Player->ADD_GOSSIP_ITEM(9,"Kreuzfahrer ",EQUIPMENT_SLOT_OFFHAND,20034);
		Player->ADD_GOSSIP_ITEM(9,"Todeskarlte ",EQUIPMENT_SLOT_OFFHAND,46578);
		Player->ADD_GOSSIP_ITEM(9,"Feurige Waffe ",EQUIPMENT_SLOT_OFFHAND,13898);
		Player->ADD_GOSSIP_ITEM(9,"Eisige Waffe ",EQUIPMENT_SLOT_OFFHAND,20029);
		Player->ADD_GOSSIP_ITEM(9,"Adamantitwaffenkette",EQUIPMENT_SLOT_OFFHAND,42687);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+16)
	{
		Player->ADD_GOSSIP_ITEM(9,"28 Krit ",EQUIPMENT_SLOT_RANGED,30260);
		Player->ADD_GOSSIP_ITEM(9,"30 Trefferwertung ",EQUIPMENT_SLOT_RANGED,22779);
		Player->ADD_GOSSIP_ITEM(9,"12 Distanzkampfschaden ",EQUIPMENT_SLOT_RANGED,30252);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+17)
	{
		Player->ADD_GOSSIP_ITEM(9,"12 Abhaertungswertung ",EQUIPMENT_SLOT_OFFHAND,44383);
		Player->ADD_GOSSIP_ITEM(9,"18 Ausdauer ",EQUIPMENT_SLOT_OFFHAND,34009);
		Player->ADD_GOSSIP_ITEM(9,"12 Intelligenz ",EQUIPMENT_SLOT_OFFHAND,27945);
		Player->ADD_GOSSIP_ITEM(9,"5 Alle Widerstaende ",EQUIPMENT_SLOT_OFFHAND,27947);
		Player->ADD_GOSSIP_ITEM(9,"15 Schild Block ",EQUIPMENT_SLOT_OFFHAND,27946);
		Player->ADD_GOSSIP_ITEM(9,"9 Willenskraft ",EQUIPMENT_SLOT_OFFHAND,20016);
		Player->ADD_GOSSIP_ITEM(9,"8 Frost Resistenz ",EQUIPMENT_SLOT_OFFHAND,11224);
		Player->ADD_GOSSIP_ITEM(9,"30 Ruestung ",EQUIPMENT_SLOT_OFFHAND,13464);
		Player->ADD_GOSSIP_ITEM(9,"26-38 Schaden, wenn geblockt ",EQUIPMENT_SLOT_OFFHAND,29454);
		Player->ADD_GOSSIP_ITEM(9,"<- Zurueck ",0,0);
		Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
	}
	else if (action == GOSSIP_ACTION_INFO_DEF+0)
		GossipHello_enchant_npc(Player,Creature);
	else
	{
		Player->EnchantItem(action,sender);
		GossipHello_enchant_npc(Player,Creature);
	}
	return true;
}

void AddSC_enchant_npc()
{
	Script *newscript;

	newscript = new Script;
	newscript->Name="enchant_npc";
	newscript->pGossipHello =           &GossipHello_enchant_npc;
	newscript->pGossipSelect =          &GossipSelect_enchant_npc;
	newscript->RegisterSelf();
}