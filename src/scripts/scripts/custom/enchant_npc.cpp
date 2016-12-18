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
        Creature->Say("You are infight!",LANG_UNIVERSAL, 0);
        return true;
    }

    Player->ADD_GOSSIP_ITEM(9,"Head Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1 );
    Player->ADD_GOSSIP_ITEM(9,"Shoulder Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+2 );
    Player->ADD_GOSSIP_ITEM(9,"Cloak Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+3 );
    Player->ADD_GOSSIP_ITEM(9,"Chest Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+4 );
    Player->ADD_GOSSIP_ITEM(9,"Wrist Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+5 );
    Player->ADD_GOSSIP_ITEM(9,"Glove Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+6 );
    Player->ADD_GOSSIP_ITEM(9,"Leg Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+7 );
    Player->ADD_GOSSIP_ITEM(9,"Boots Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+8 );
    Player->ADD_GOSSIP_ITEM(9,"Ring Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+9 );
    Player->ADD_GOSSIP_ITEM(9,"Ring2 Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+10 );
    Player->ADD_GOSSIP_ITEM(9,"2h Weap Enchantment ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+11 );
    Player->ADD_GOSSIP_ITEM(9,"Mainhand Enchantmentn ",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+12 );
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
        Player->ADD_GOSSIP_ITEM(9,"34 Attackpower 16 Hitrating ",EQUIPMENT_SLOT_HEAD,35452);
        Player->ADD_GOSSIP_ITEM(9,"17 Strength 16 Int ",EQUIPMENT_SLOT_HEAD,37891);
        Player->ADD_GOSSIP_ITEM(9,"22 Spelldmg 14 Spellhit ",EQUIPMENT_SLOT_HEAD,35447);
        Player->ADD_GOSSIP_ITEM(9,"35 Heal 12 Spell 7 mp5",EQUIPMENT_SLOT_HEAD,35445);
        Player->ADD_GOSSIP_ITEM(9,"18 Stam 20 Resi ",EQUIPMENT_SLOT_HEAD,35453);
        Player->ADD_GOSSIP_ITEM(9,"16 Def 17 Dodge ",EQUIPMENT_SLOT_HEAD,35443);
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
        Player->ADD_GOSSIP_ITEM(9,"30 Attackpower 10 crit ",EQUIPMENT_SLOT_SHOULDERS,35417);
        Player->ADD_GOSSIP_ITEM(9,"26 Attackpower 14 crit ",EQUIPMENT_SLOT_SHOULDERS,29483);
        Player->ADD_GOSSIP_ITEM(9,"20 Attackpower 15 crit ",EQUIPMENT_SLOT_SHOULDERS,35439);
        Player->ADD_GOSSIP_ITEM(9,"18 Spelldamage 10 crit ",EQUIPMENT_SLOT_SHOULDERS,35406);
        Player->ADD_GOSSIP_ITEM(9,"15 Spelldamage 14 crit ",EQUIPMENT_SLOT_SHOULDERS,29467);
        Player->ADD_GOSSIP_ITEM(9,"12 Spelldamage 15 crit ",EQUIPMENT_SLOT_SHOULDERS,35437);
        Player->ADD_GOSSIP_ITEM(9,"33 Heal 11 Spelldamage 4 mp5",EQUIPMENT_SLOT_SHOULDERS,35404);
        Player->ADD_GOSSIP_ITEM(9,"31 Heal 11 Spelldamage 5 mp5",EQUIPMENT_SLOT_SHOULDERS,29475);
        Player->ADD_GOSSIP_ITEM(9,"22 Heal 6 mp5 ",EQUIPMENT_SLOT_SHOULDERS,35435);
        Player->ADD_GOSSIP_ITEM(9,"16 Stam 100 Armor ",EQUIPMENT_SLOT_SHOULDERS,29480);
        Player->ADD_GOSSIP_ITEM(9,"10 Dodge 15 Def ",EQUIPMENT_SLOT_SHOULDERS,35433);
        Player->ADD_GOSSIP_ITEM(9,"15 Dodge 10 Def ",EQUIPMENT_SLOT_SHOULDERS,35402);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+3)
    {
        Player->ADD_GOSSIP_ITEM(9,"12 Agi ",EQUIPMENT_SLOT_BACK,34004);
        Player->ADD_GOSSIP_ITEM(9,"20 Spellpen ",EQUIPMENT_SLOT_BACK,34003);
        Player->ADD_GOSSIP_ITEM(9,"15 Fire resistance ",EQUIPMENT_SLOT_BACK,25081);
        Player->ADD_GOSSIP_ITEM(9,"15 Arcane resistance ",EQUIPMENT_SLOT_BACK,34005);
        Player->ADD_GOSSIP_ITEM(9,"15 Shadow resistance ",EQUIPMENT_SLOT_BACK,34006);
        Player->ADD_GOSSIP_ITEM(9,"15 Nature resistance ",EQUIPMENT_SLOT_BACK,25082);
        Player->ADD_GOSSIP_ITEM(9,"7 all resistance ",EQUIPMENT_SLOT_BACK,27962);
        Player->ADD_GOSSIP_ITEM(9,"12 Dodge ",EQUIPMENT_SLOT_BACK,25086);
        Player->ADD_GOSSIP_ITEM(9,"12 Def ",EQUIPMENT_SLOT_BACK,47051);
        Player->ADD_GOSSIP_ITEM(9,"120 Armor ",EQUIPMENT_SLOT_BACK,27961);
        Player->ADD_GOSSIP_ITEM(9,"Stealthdetection ",EQUIPMENT_SLOT_BACK,25083);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+4)
    {
        Player->ADD_GOSSIP_ITEM(9,"15 Resi ",EQUIPMENT_SLOT_CHEST,33992);
        Player->ADD_GOSSIP_ITEM(9,"6 all stats ",EQUIPMENT_SLOT_CHEST,27960);
        Player->ADD_GOSSIP_ITEM(9,"15 Spirit ",EQUIPMENT_SLOT_CHEST,33990);
        Player->ADD_GOSSIP_ITEM(9,"15 Def ",EQUIPMENT_SLOT_CHEST,46594);
        Player->ADD_GOSSIP_ITEM(9,"150 HP ",EQUIPMENT_SLOT_CHEST,27957);
        Player->ADD_GOSSIP_ITEM(9,"150 Mana ",EQUIPMENT_SLOT_CHEST,27958);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+5)
    {
        Player->ADD_GOSSIP_ITEM(9,"24 Attackpower ",EQUIPMENT_SLOT_WRISTS,34002);
        Player->ADD_GOSSIP_ITEM(9,"15 Spelldamage ",EQUIPMENT_SLOT_WRISTS,27917);
        Player->ADD_GOSSIP_ITEM(9,"30 Heal 10 Spelldamage ",EQUIPMENT_SLOT_WRISTS,27911);
        Player->ADD_GOSSIP_ITEM(9,"12 Stam ",EQUIPMENT_SLOT_WRISTS,27914);
        Player->ADD_GOSSIP_ITEM(9,"12 Def ",EQUIPMENT_SLOT_WRISTS,27906);
        Player->ADD_GOSSIP_ITEM(9,"12 Strength ",EQUIPMENT_SLOT_WRISTS,27899);
        Player->ADD_GOSSIP_ITEM(9,"12 Int ",EQUIPMENT_SLOT_WRISTS,34001);
        Player->ADD_GOSSIP_ITEM(9,"4 all stats ",EQUIPMENT_SLOT_WRISTS,27905);
        Player->ADD_GOSSIP_ITEM(9,"6 mp5 ",EQUIPMENT_SLOT_WRISTS,27913);
        Player->ADD_GOSSIP_ITEM(9,"9 Spirit ",EQUIPMENT_SLOT_WRISTS,20009);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+6)
    {
        Player->ADD_GOSSIP_ITEM(9,"26 Attackpower ",EQUIPMENT_SLOT_HANDS,33996);
        Player->ADD_GOSSIP_ITEM(9,"15 Strength ",EQUIPMENT_SLOT_HANDS,33995);
        Player->ADD_GOSSIP_ITEM(9,"15 Agi ",EQUIPMENT_SLOT_HANDS,25080);
        Player->ADD_GOSSIP_ITEM(9,"20 Spelldamage ",EQUIPMENT_SLOT_HANDS,33997);
        Player->ADD_GOSSIP_ITEM(9,"35 Heal 12 Spelldamage ",EQUIPMENT_SLOT_HANDS,33999);
        Player->ADD_GOSSIP_ITEM(9,"15 Spellhit ",EQUIPMENT_SLOT_HANDS,33994);
        Player->ADD_GOSSIP_ITEM(9,"10 Spellcrit ",EQUIPMENT_SLOT_HANDS,33993);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+7)
    {
        Player->ADD_GOSSIP_ITEM(9,"50 Attackpower 12 Crit ",EQUIPMENT_SLOT_LEGS,29535);
        Player->ADD_GOSSIP_ITEM(9,"40 Stam 12 Agi ",EQUIPMENT_SLOT_LEGS,35495);
        Player->ADD_GOSSIP_ITEM(9,"35 Spelldamage 20 Stam ",EQUIPMENT_SLOT_LEGS,31372);
        Player->ADD_GOSSIP_ITEM(9,"66 Heal 22 Spelldamage 20 Stam ",EQUIPMENT_SLOT_LEGS,31370);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+8)
    {
        Player->ADD_GOSSIP_ITEM(9,"Movespeed 6 Agi ",EQUIPMENT_SLOT_FEET,34007);
        Player->ADD_GOSSIP_ITEM(9,"Movespeed 9 Stam ",EQUIPMENT_SLOT_FEET,34008);
        Player->ADD_GOSSIP_ITEM(9,"10 Hit",EQUIPMENT_SLOT_FEET,27954);
        Player->ADD_GOSSIP_ITEM(9,"12 Agi ",EQUIPMENT_SLOT_FEET,27951);
        Player->ADD_GOSSIP_ITEM(9,"12 Stam ",EQUIPMENT_SLOT_FEET,27950);
        Player->ADD_GOSSIP_ITEM(9,"4 hp/mp5 ",EQUIPMENT_SLOT_FEET,27948);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+9)
    {
        Player->ADD_GOSSIP_ITEM(9,"4 all stats ",EQUIPMENT_SLOT_FINGER1,27927);
        Player->ADD_GOSSIP_ITEM(9,"12 Spelldamage ",EQUIPMENT_SLOT_FINGER1,27924);
        Player->ADD_GOSSIP_ITEM(9,"20 Heal 7 Spelldamage ",EQUIPMENT_SLOT_FINGER1,27926);
        Player->ADD_GOSSIP_ITEM(9,"2 Weapondamage ",EQUIPMENT_SLOT_FINGER1,27920);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+10)
    {
        Player->ADD_GOSSIP_ITEM(9,"4 all stats ",EQUIPMENT_SLOT_FINGER2,27927);
        Player->ADD_GOSSIP_ITEM(9,"12 Spelldamage ",EQUIPMENT_SLOT_FINGER2,27924);
        Player->ADD_GOSSIP_ITEM(9,"20 Heal 7 Spelldamage ",EQUIPMENT_SLOT_FINGER2,27926);
        Player->ADD_GOSSIP_ITEM(9,"2 Weapondamage ",EQUIPMENT_SLOT_FINGER2,27920);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+11)
    {
        Player->ADD_GOSSIP_ITEM(9,"70 Attackpower ",EQUIPMENT_SLOT_MAINHAND,27971);
        Player->ADD_GOSSIP_ITEM(9,"35 Agi ",EQUIPMENT_SLOT_MAINHAND,27977);
        Player->ADD_GOSSIP_ITEM(9,"9 Damage ",EQUIPMENT_SLOT_MAINHAND,20030);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+12)
    {
        Player->ADD_GOSSIP_ITEM(9,"Mongoose ",EQUIPMENT_SLOT_MAINHAND,27984);
        Player->ADD_GOSSIP_ITEM(9,"Executioner ",EQUIPMENT_SLOT_MAINHAND,42974);
        Player->ADD_GOSSIP_ITEM(9,"20 Strenght ",EQUIPMENT_SLOT_MAINHAND,27972);
        Player->ADD_GOSSIP_ITEM(9,"20 Agi ",EQUIPMENT_SLOT_MAINHAND,42620);
        Player->ADD_GOSSIP_ITEM(9,"40 Spelldamage ",EQUIPMENT_SLOT_MAINHAND,27975);
        Player->ADD_GOSSIP_ITEM(9,"81 Heal 27 Spelldamage ",EQUIPMENT_SLOT_MAINHAND,34010);
        Player->ADD_GOSSIP_ITEM(9,"20 Spirit ",EQUIPMENT_SLOT_MAINHAND,23803);
        Player->ADD_GOSSIP_ITEM(9,"7 Weapondamage ",EQUIPMENT_SLOT_MAINHAND,27967);
        Player->ADD_GOSSIP_ITEM(9,"50 Arcane/Fire Spelldamage ",EQUIPMENT_SLOT_MAINHAND,27981);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->ADD_GOSSIP_ITEM(9,"Next -> ",GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+13);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+13)
    {
        Player->ADD_GOSSIP_ITEM(9,"30 Int ",EQUIPMENT_SLOT_MAINHAND,27968);
        Player->ADD_GOSSIP_ITEM(9,"Battlemaster ",EQUIPMENT_SLOT_MAINHAND,28004);
        Player->ADD_GOSSIP_ITEM(9,"Lifestealing ",EQUIPMENT_SLOT_MAINHAND,20032);
        Player->ADD_GOSSIP_ITEM(9,"Crusader ",EQUIPMENT_SLOT_MAINHAND,20034);
        Player->ADD_GOSSIP_ITEM(9,"Deathfrost ",EQUIPMENT_SLOT_MAINHAND,46578);
        Player->ADD_GOSSIP_ITEM(9,"Fiery Weapon ",EQUIPMENT_SLOT_MAINHAND,13898);
        Player->ADD_GOSSIP_ITEM(9,"Icy Chill ",EQUIPMENT_SLOT_MAINHAND,20029);
        Player->ADD_GOSSIP_ITEM(9,"Spellsurge ",EQUIPMENT_SLOT_MAINHAND,28003);
        Player->ADD_GOSSIP_ITEM(9,"Adamantite Weapon Chain ",EQUIPMENT_SLOT_MAINHAND,42687);
        Player->ADD_GOSSIP_ITEM(9,"54 Shadow/Frost Spelldamage ",EQUIPMENT_SLOT_MAINHAND,27982);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+14)
    {
        Player->ADD_GOSSIP_ITEM(9,"Mongoose ",EQUIPMENT_SLOT_OFFHAND,27984);
        Player->ADD_GOSSIP_ITEM(9,"Executioner ",EQUIPMENT_SLOT_OFFHAND,42974);
        Player->ADD_GOSSIP_ITEM(9,"20 Strength ",EQUIPMENT_SLOT_OFFHAND,27972);
        Player->ADD_GOSSIP_ITEM(9,"20 Agi ",EQUIPMENT_SLOT_OFFHAND,42620);
        Player->ADD_GOSSIP_ITEM(9,"7 Weapondamage ",EQUIPMENT_SLOT_OFFHAND,27967);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->ADD_GOSSIP_ITEM(9,"Next -> ",GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+15);
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
        Player->ADD_GOSSIP_ITEM(9,"28 Crit ",EQUIPMENT_SLOT_RANGED,30260);
        Player->ADD_GOSSIP_ITEM(9,"30 Hit ",EQUIPMENT_SLOT_RANGED,22779);
        Player->ADD_GOSSIP_ITEM(9,"12 Rangedamage ",EQUIPMENT_SLOT_RANGED,30252);
        Player->ADD_GOSSIP_ITEM(9,"<- Back ",0,0);
        Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    }
    else if (action == GOSSIP_ACTION_INFO_DEF+17)
    {
        Player->ADD_GOSSIP_ITEM(9,"12 Resi ",EQUIPMENT_SLOT_OFFHAND,44383);
        Player->ADD_GOSSIP_ITEM(9,"18 Stam ",EQUIPMENT_SLOT_OFFHAND,34009);
        Player->ADD_GOSSIP_ITEM(9,"12 Int ",EQUIPMENT_SLOT_OFFHAND,27945);
        Player->ADD_GOSSIP_ITEM(9,"5 all resistance ",EQUIPMENT_SLOT_OFFHAND,27947);
        Player->ADD_GOSSIP_ITEM(9,"15 Shield Block ",EQUIPMENT_SLOT_OFFHAND,27946);
        Player->ADD_GOSSIP_ITEM(9,"9 Spirit ",EQUIPMENT_SLOT_OFFHAND,20016);
        Player->ADD_GOSSIP_ITEM(9,"8 Frost resistance ",EQUIPMENT_SLOT_OFFHAND,11224);
        Player->ADD_GOSSIP_ITEM(9,"30 Armor ",EQUIPMENT_SLOT_OFFHAND,13464);
        Player->ADD_GOSSIP_ITEM(9,"26-38 Damage, if blocked ",EQUIPMENT_SLOT_OFFHAND,29454);
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