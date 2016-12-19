/*
##################################################################
#Verzuaberungs NPC wie er auf AT war                             #
#Für den NPC in der Datenbank:                                     #    
INSERT INTO `creature_template` (`entry`, `modelid_A`, `modelid_H`, `name`, `subname`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `type`, `ScriptName`) VALUES ('1000033', '17870', '17870', 'Verzauberungskunst', 'BETA', '70', '70', '10000', '10000', '10000', '10000', '10000', '35', '35', '10', 'enchant_npc');
UPDATE `creature_template` SET `npcflag`='1', `scale`='0.5'     WHERE (`entry`='1000033');                                                                    
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
        Creature->Say("You are in combat!",LANG_UNIVERSAL, 0);
        return true;
    }

    Player->ADD_GOSSIP_ITEM(9,"Head Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1 );
    Player->ADD_GOSSIP_ITEM(9,"Shoulder Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+2 );
    Player->ADD_GOSSIP_ITEM(9,"Cloak Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+3 );
    Player->ADD_GOSSIP_ITEM(9,"Chest Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+4 );
    Player->ADD_GOSSIP_ITEM(9,"Wrist Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+5 );
    Player->ADD_GOSSIP_ITEM(9,"Hands Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+6 );
    Player->ADD_GOSSIP_ITEM(9,"Legs Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+7 );
    Player->ADD_GOSSIP_ITEM(9,"Feet Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+8 );
    Player->ADD_GOSSIP_ITEM(9,"Ring Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+9 );
    Player->ADD_GOSSIP_ITEM(9,"Ring2 Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+10 );
    Player->ADD_GOSSIP_ITEM(9,"2h Weapon Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+11 );
    Player->ADD_GOSSIP_ITEM(9,"Mainhand Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+12 );
    //Player->ADD_GOSSIP_ITEM(9,"Waffenhand Verzauberungen 2",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+13 );
    Player->ADD_GOSSIP_ITEM(9,"Offhand Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+14 );
    Player->ADD_GOSSIP_ITEM(9,"Ranged Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+16 );
    Player->ADD_GOSSIP_ITEM(9,"Shield Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+17 );
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
        Player->ADD_GOSSIP_ITEM(9,"34 attack power 16 hit ",EQUIPMENT_SLOT_HEAD,35452);
        Player->ADD_GOSSIP_ITEM(9,"17 strength 16 intellect ",EQUIPMENT_SLOT_HEAD,37891);
        Player->ADD_GOSSIP_ITEM(9,"22 spell damage 14 spell hit ",EQUIPMENT_SLOT_HEAD,35447);
        Player->ADD_GOSSIP_ITEM(9,"35 healing 12 spell damage 7 mp5",EQUIPMENT_SLOT_HEAD,35445);
        Player->ADD_GOSSIP_ITEM(9,"18 stamina 20 resilience ",EQUIPMENT_SLOT_HEAD,35453);
        Player->ADD_GOSSIP_ITEM(9,"16 defense 17 dodge ",EQUIPMENT_SLOT_HEAD,35443);
        Player->ADD_GOSSIP_ITEM(9,"20 Fire resistance ",EQUIPMENT_SLOT_HEAD,35456);
        Player->ADD_GOSSIP_ITEM(9,"20 Arcane resistance ",EQUIPMENT_SLOT_HEAD,35455);
        Player->ADD_GOSSIP_ITEM(9,"20 Shadow resistance ",EQUIPMENT_SLOT_HEAD,35458);
        Player->ADD_GOSSIP_ITEM(9,"20 Nature resistance ",EQUIPMENT_SLOT_HEAD,35454);
        Player->ADD_GOSSIP_ITEM(9,"20 Frost resistance ",EQUIPMENT_SLOT_HEAD,35457);
        Player->ADD_GOSSIP_ITEM(9,"8 all resistance ",EQUIPMENT_SLOT_HEAD,37889);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+2)
    {
        Player->ADD_GOSSIP_ITEM(9,"30 attack power 10 crit ",EQUIPMENT_SLOT_SHOULDERS,35417);
        Player->ADD_GOSSIP_ITEM(9,"26 attack power 14 crit ",EQUIPMENT_SLOT_SHOULDERS,29483);
        Player->ADD_GOSSIP_ITEM(9,"20 attack power 15 crit ",EQUIPMENT_SLOT_SHOULDERS,35439);
        Player->ADD_GOSSIP_ITEM(9,"18 spell damage 10 spell crit ",EQUIPMENT_SLOT_SHOULDERS,35406);
        Player->ADD_GOSSIP_ITEM(9,"15 spell damage 14 spell crit ",EQUIPMENT_SLOT_SHOULDERS,29467);
        Player->ADD_GOSSIP_ITEM(9,"12 spell damage 15 spell crit ",EQUIPMENT_SLOT_SHOULDERS,35437);
        Player->ADD_GOSSIP_ITEM(9,"33 healing 11 spell damage 4 mp5",EQUIPMENT_SLOT_SHOULDERS,35404);
        Player->ADD_GOSSIP_ITEM(9,"31 healing 11 spell damage 5 mp5",EQUIPMENT_SLOT_SHOULDERS,29475);
        Player->ADD_GOSSIP_ITEM(9,"22 healing 6 mp5 ",EQUIPMENT_SLOT_SHOULDERS,35435);
        Player->ADD_GOSSIP_ITEM(9,"16 stamina 100 armor ",EQUIPMENT_SLOT_SHOULDERS,29480);
        Player->ADD_GOSSIP_ITEM(9,"10 dodge 15 defense ",EQUIPMENT_SLOT_SHOULDERS,35433);
        Player->ADD_GOSSIP_ITEM(9,"15 dodge 10 defense ",EQUIPMENT_SLOT_SHOULDERS,35402);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+3)
    {
        Player->ADD_GOSSIP_ITEM(9,"12 agility ",EQUIPMENT_SLOT_BACK,34004);
        Player->ADD_GOSSIP_ITEM(9,"20 spell penetration ",EQUIPMENT_SLOT_BACK,34003);
        Player->ADD_GOSSIP_ITEM(9,"15 Fire resistance ",EQUIPMENT_SLOT_BACK,25081);
        Player->ADD_GOSSIP_ITEM(9,"15 Arcane resistance ",EQUIPMENT_SLOT_BACK,34005);
        Player->ADD_GOSSIP_ITEM(9,"15 Shadow resistance ",EQUIPMENT_SLOT_BACK,34006);
        Player->ADD_GOSSIP_ITEM(9,"15 Nature resistance ",EQUIPMENT_SLOT_BACK,25082);
        Player->ADD_GOSSIP_ITEM(9,"7 all resistance ",EQUIPMENT_SLOT_BACK,27962);
        Player->ADD_GOSSIP_ITEM(9,"12 dodge ",EQUIPMENT_SLOT_BACK,25086);
        Player->ADD_GOSSIP_ITEM(9,"12 defense ",EQUIPMENT_SLOT_BACK,47051);
        Player->ADD_GOSSIP_ITEM(9,"120 armor ",EQUIPMENT_SLOT_BACK,27961);
        Player->ADD_GOSSIP_ITEM(9,"increase stealth ",EQUIPMENT_SLOT_BACK,25083);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+4)
    {
        Player->ADD_GOSSIP_ITEM(9,"15 resilience ",EQUIPMENT_SLOT_CHEST,33992);
        Player->ADD_GOSSIP_ITEM(9,"6 to all stats ",EQUIPMENT_SLOT_CHEST,27960);
        Player->ADD_GOSSIP_ITEM(9,"15 spirit ",EQUIPMENT_SLOT_CHEST,33990);
        Player->ADD_GOSSIP_ITEM(9,"15 defense ",EQUIPMENT_SLOT_CHEST,46594);
        Player->ADD_GOSSIP_ITEM(9,"150 hp ",EQUIPMENT_SLOT_CHEST,27957);
        Player->ADD_GOSSIP_ITEM(9,"150 Mana ",EQUIPMENT_SLOT_CHEST,27958);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+5)
    {
        Player->ADD_GOSSIP_ITEM(9,"24 attack power ",EQUIPMENT_SLOT_WRISTS,34002);
        Player->ADD_GOSSIP_ITEM(9,"15 spell damage ",EQUIPMENT_SLOT_WRISTS,27917);
        Player->ADD_GOSSIP_ITEM(9,"30 healing 10 spell damage ",EQUIPMENT_SLOT_WRISTS,27911);
        Player->ADD_GOSSIP_ITEM(9,"12 stamina ",EQUIPMENT_SLOT_WRISTS,27914);
        Player->ADD_GOSSIP_ITEM(9,"12 defense ",EQUIPMENT_SLOT_WRISTS,27906);
        Player->ADD_GOSSIP_ITEM(9,"12 strength ",EQUIPMENT_SLOT_WRISTS,27899);
        Player->ADD_GOSSIP_ITEM(9,"12 intellect  ",EQUIPMENT_SLOT_WRISTS,34001);
        Player->ADD_GOSSIP_ITEM(9,"4 to all stats ",EQUIPMENT_SLOT_WRISTS,27905);
        Player->ADD_GOSSIP_ITEM(9,"6 mp5 ",EQUIPMENT_SLOT_WRISTS,27913);
        Player->ADD_GOSSIP_ITEM(9,"9 spirit ",EQUIPMENT_SLOT_WRISTS,20009);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+6)
    {
        Player->ADD_GOSSIP_ITEM(9,"26 attack power ",EQUIPMENT_SLOT_HANDS,33996);
        Player->ADD_GOSSIP_ITEM(9,"15 strength ",EQUIPMENT_SLOT_HANDS,33995);
        Player->ADD_GOSSIP_ITEM(9,"15 agility ",EQUIPMENT_SLOT_HANDS,25080);
        Player->ADD_GOSSIP_ITEM(9,"20 spell damage ",EQUIPMENT_SLOT_HANDS,33997);
        Player->ADD_GOSSIP_ITEM(9,"35 healing 12 spell damage ",EQUIPMENT_SLOT_HANDS,33999);
        Player->ADD_GOSSIP_ITEM(9,"15 spell hit ",EQUIPMENT_SLOT_HANDS,33994);
        Player->ADD_GOSSIP_ITEM(9,"10 spell crit ",EQUIPMENT_SLOT_HANDS,33993);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+7)
    {
        Player->ADD_GOSSIP_ITEM(9,"50 attack power 12 crit ",EQUIPMENT_SLOT_LEGS,29535);
        Player->ADD_GOSSIP_ITEM(9,"40 stamina 12 agility ",EQUIPMENT_SLOT_LEGS,35495);
        Player->ADD_GOSSIP_ITEM(9,"35 spell damage 20 stamina ",EQUIPMENT_SLOT_LEGS,31372);
        Player->ADD_GOSSIP_ITEM(9,"66 healing 22 spell damage 20 stamina ",EQUIPMENT_SLOT_LEGS,31370);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+8)
    {
        Player->ADD_GOSSIP_ITEM(9,"Movespeed 6 agility ",EQUIPMENT_SLOT_FEET,34007);
        Player->ADD_GOSSIP_ITEM(9,"Movespeed 9 stamina ",EQUIPMENT_SLOT_FEET,34008);
        Player->ADD_GOSSIP_ITEM(9,"5% snare and root resistance 10 hit ",EQUIPMENT_SLOT_FEET,27954);
        Player->ADD_GOSSIP_ITEM(9,"12 agility ",EQUIPMENT_SLOT_FEET,27951);
        Player->ADD_GOSSIP_ITEM(9,"12 stamina ",EQUIPMENT_SLOT_FEET,27950);
        Player->ADD_GOSSIP_ITEM(9,"4 hp/mp5 ",EQUIPMENT_SLOT_FEET,27948);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+9)
    {
        Player->ADD_GOSSIP_ITEM(9,"4 to all stats ",EQUIPMENT_SLOT_FINGER1,27927);
        Player->ADD_GOSSIP_ITEM(9,"12 spell damage ",EQUIPMENT_SLOT_FINGER1,27924);
        Player->ADD_GOSSIP_ITEM(9,"20 healing 7 spell damage ",EQUIPMENT_SLOT_FINGER1,27926);
        Player->ADD_GOSSIP_ITEM(9,"2 damage to physical attacks ",EQUIPMENT_SLOT_FINGER1,27920);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+10)
    {
        Player->ADD_GOSSIP_ITEM(9,"4 to all stats ",EQUIPMENT_SLOT_FINGER2,27927);
        Player->ADD_GOSSIP_ITEM(9,"12 spell damage ",EQUIPMENT_SLOT_FINGER2,27924);
        Player->ADD_GOSSIP_ITEM(9,"20 healing 7 spell damage ",EQUIPMENT_SLOT_FINGER2,27926);
        Player->ADD_GOSSIP_ITEM(9,"2 physical damage",EQUIPMENT_SLOT_FINGER2,27920);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+11)
    {
        Player->ADD_GOSSIP_ITEM(9,"70 attack power ",EQUIPMENT_SLOT_MAINHAND,27971);
        Player->ADD_GOSSIP_ITEM(9,"35 agility ",EQUIPMENT_SLOT_MAINHAND,27977);
        Player->ADD_GOSSIP_ITEM(9,"9 physical damage ",EQUIPMENT_SLOT_MAINHAND,20030);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+12)
    {
        Player->ADD_GOSSIP_ITEM(9,"Mongoose ",EQUIPMENT_SLOT_MAINHAND,27984);
        Player->ADD_GOSSIP_ITEM(9,"Executioner ",EQUIPMENT_SLOT_MAINHAND,42974);
        Player->ADD_GOSSIP_ITEM(9,"20 strenght ",EQUIPMENT_SLOT_MAINHAND,27972);
        Player->ADD_GOSSIP_ITEM(9,"20 agility ",EQUIPMENT_SLOT_MAINHAND,42620);
        Player->ADD_GOSSIP_ITEM(9,"40 spell damage ",EQUIPMENT_SLOT_MAINHAND,27975);
        Player->ADD_GOSSIP_ITEM(9,"81 healing 27 spell damage ",EQUIPMENT_SLOT_MAINHAND,34010);
        Player->ADD_GOSSIP_ITEM(9,"20 spirit ",EQUIPMENT_SLOT_MAINHAND,23803);
        Player->ADD_GOSSIP_ITEM(9,"7 physical damage ",EQUIPMENT_SLOT_MAINHAND,27967);
        Player->ADD_GOSSIP_ITEM(9,"50 Arcane/Fire spell damage ",EQUIPMENT_SLOT_MAINHAND,27981);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->ADD_GOSSIP_ITEM(9,"Next Page -> ",GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+13);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+13)
    {
        Player->ADD_GOSSIP_ITEM(9,"30 intellect ",EQUIPMENT_SLOT_MAINHAND,27968);
        Player->ADD_GOSSIP_ITEM(9,"Battlemaster ",EQUIPMENT_SLOT_MAINHAND,28004);
        Player->ADD_GOSSIP_ITEM(9,"Lifestealing ",EQUIPMENT_SLOT_MAINHAND,20032);
        Player->ADD_GOSSIP_ITEM(9,"Crusader ",EQUIPMENT_SLOT_MAINHAND,20034);
        Player->ADD_GOSSIP_ITEM(9,"Deathfrost ",EQUIPMENT_SLOT_MAINHAND,46578);
        Player->ADD_GOSSIP_ITEM(9,"Fiery Weapon ",EQUIPMENT_SLOT_MAINHAND,13898);
        Player->ADD_GOSSIP_ITEM(9,"Icy Chill ",EQUIPMENT_SLOT_MAINHAND,20029);
        Player->ADD_GOSSIP_ITEM(9,"Spellsurge ",EQUIPMENT_SLOT_MAINHAND,28003);
        Player->ADD_GOSSIP_ITEM(9,"Adamantite Weapon Chain ",EQUIPMENT_SLOT_MAINHAND,42687);
        Player->ADD_GOSSIP_ITEM(9,"54 Shadow/Frost spell damage ",EQUIPMENT_SLOT_MAINHAND,27982);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+14)
    {
        Player->ADD_GOSSIP_ITEM(9,"Mongoose ",EQUIPMENT_SLOT_OFFHAND,27984);
        Player->ADD_GOSSIP_ITEM(9,"Executioner ",EQUIPMENT_SLOT_OFFHAND,42974);
        Player->ADD_GOSSIP_ITEM(9,"20 strength ",EQUIPMENT_SLOT_OFFHAND,27972);
        Player->ADD_GOSSIP_ITEM(9,"20 agility ",EQUIPMENT_SLOT_OFFHAND,42620);
        Player->ADD_GOSSIP_ITEM(9,"7 physical damage ",EQUIPMENT_SLOT_OFFHAND,27967);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->ADD_GOSSIP_ITEM(9,"Next Page -> ",GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+15);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+15)
    {
        Player->ADD_GOSSIP_ITEM(9,"Battlemaster ",EQUIPMENT_SLOT_OFFHAND,28004);
        Player->ADD_GOSSIP_ITEM(9,"Lifestealing ",EQUIPMENT_SLOT_OFFHAND,20032);
        Player->ADD_GOSSIP_ITEM(9,"Crusader ",EQUIPMENT_SLOT_OFFHAND,20034);
        Player->ADD_GOSSIP_ITEM(9,"Deathfrost ",EQUIPMENT_SLOT_OFFHAND,46578);
        Player->ADD_GOSSIP_ITEM(9,"Fiery Weapon ",EQUIPMENT_SLOT_OFFHAND,13898);
        Player->ADD_GOSSIP_ITEM(9,"Icy Chill ",EQUIPMENT_SLOT_OFFHAND,20029);
        Player->ADD_GOSSIP_ITEM(9,"Adamantite Weapon Chain",EQUIPMENT_SLOT_OFFHAND,42687);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+16)
    {
        Player->ADD_GOSSIP_ITEM(9,"28 crit ",EQUIPMENT_SLOT_RANGED,30260);
        Player->ADD_GOSSIP_ITEM(9,"30 hit ",EQUIPMENT_SLOT_RANGED,22779);
        Player->ADD_GOSSIP_ITEM(9,"12 Rangedamage ",EQUIPMENT_SLOT_RANGED,30252);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+17)
    {
        Player->ADD_GOSSIP_ITEM(9,"12 resilience  ",EQUIPMENT_SLOT_OFFHAND,44383);
        Player->ADD_GOSSIP_ITEM(9,"18 stamina ",EQUIPMENT_SLOT_OFFHAND,34009);
        Player->ADD_GOSSIP_ITEM(9,"12 intellect ",EQUIPMENT_SLOT_OFFHAND,27945);
        Player->ADD_GOSSIP_ITEM(9,"5 to all resistance ",EQUIPMENT_SLOT_OFFHAND,27947);
        Player->ADD_GOSSIP_ITEM(9,"15 Shield Block ",EQUIPMENT_SLOT_OFFHAND,27946);
        Player->ADD_GOSSIP_ITEM(9,"9 spirit ",EQUIPMENT_SLOT_OFFHAND,20016);
        Player->ADD_GOSSIP_ITEM(9,"8 Frost resistance ",EQUIPMENT_SLOT_OFFHAND,11224);
        Player->ADD_GOSSIP_ITEM(9,"30 armor ",EQUIPMENT_SLOT_OFFHAND,13464);
        Player->ADD_GOSSIP_ITEM(9,"26-38 damage if blocked ",EQUIPMENT_SLOT_OFFHAND,29454);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
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