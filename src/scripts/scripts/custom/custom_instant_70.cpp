/*
########################################################
# This file will be used for Custom TBN NPC. It will   #
# welcome new players and give some explinations about #
# the realm. If the char is on an account without any  #
# existing char on lvl 70 the player will be able to   #
# level up and grand some things.                      #
#######################################################################################
#                                                                                     #
# Batch into Char DB:                                                                 #
#                                                                                     #
# DROP TABLE IF EXISTS `character_push`;                                              #
# CREATE TABLE `character_push` (                                                     #
# `account` int(11) NOT NULL,                                                         #
# `ip` varchar(30) CHARACTER SET utf8 NOT NULL                                        #
# ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='character_push';   #
#                                                                                     #
# Batch into World DB:                                                                #
#                                                                                     #
# INSERT INTO npc_texts bla . . .                                                     #
#######################################################################################
*/

#include "precompiled.h"
#include <cstring>

enum Instant_70_Conversations
{
    START_CONVERSATION = GOSSIP_ACTION_INFO_DEF + 12,
    DPS_WARRIOR        = GOSSIP_ACTION_INFO_DEF + 13,
    TANK_WARRIOR       = GOSSIP_ACTION_INFO_DEF + 14,
    DPS_PALADIN        = GOSSIP_ACTION_INFO_DEF + 15,
    TANK_PALADIN       = GOSSIP_ACTION_INFO_DEF + 16,
    HEAL_PALADIN       = GOSSIP_ACTION_INFO_DEF + 17,
    DPS_HUNTER         = GOSSIP_ACTION_INFO_DEF + 18,
    DPS_ROGUE          = GOSSIP_ACTION_INFO_DEF + 19,
    DPS_PRIEST         = GOSSIP_ACTION_INFO_DEF + 20,
    HEAL_PRIEST        = GOSSIP_ACTION_INFO_DEF + 21,
    ENHANCE_SHAMAN     = GOSSIP_ACTION_INFO_DEF + 22,
    ELEMENTAL_SHAMAN   = GOSSIP_ACTION_INFO_DEF + 23,
    HEAL_SHAMAN        = GOSSIP_ACTION_INFO_DEF + 24,
    DPS_MAGE           = GOSSIP_ACTION_INFO_DEF + 25,
    DPS_WARLOCK        = GOSSIP_ACTION_INFO_DEF + 26,
    CAT_DRUID          = GOSSIP_ACTION_INFO_DEF + 27,
    BALANCE_DRUID      = GOSSIP_ACTION_INFO_DEF + 28,
    HEAL_DRUID         = GOSSIP_ACTION_INFO_DEF + 29,
    TANK_DRUID         = GOSSIP_ACTION_INFO_DEF + 30,
    ALREADY_USED       = GOSSIP_ACTION_INFO_DEF + 31,
};

//_____________________________________Head,  Neck,Should, 0, Chest, Waist,  Legs,  Feet, Wrist, Hands,    F1,    F2,    T1,    T2,  Back,    MH,    OH, Range
uint16 DPS_WARRIOR_ITEMS[] =        { 28225, 27551, 27771, 0, 28403, 27985, 30538, 28318, 27712, 27497, 27925, 28323, 28034, 28288, 27892, 27872, 27872, 28258 };
uint16 TANK_WARRIOR_ITEMS[] =       { 28350, 27871, 27803, 0, 28262, 27672, 27527, 29239, 27459, 27475, 27822, 28407, 27529, 27891, 27804, 29362, 27887, 28258 };
uint16 HEAL_PALADIN_ITEMS[] =       { 27790, 28419, 27775, 0, 27897, 27548, 27458, 28221, 28194, 28304, 28259, 27780, 24390, 28190, 27946, 28257, 31292, 28296 };
uint16 TANK_PALADIN_ITEMS[] =       { 28285, 27792, 27739, 0, 28203, 27672, 27839, 29239, 27459, 27535, 27822, 28407, 27891, 27529, 27804, 27905, 28316, 27917 };
uint16 DPS_PALADIN_ITEMS[] =        { 28225, 27551, 27771, 0, 28403, 27985, 30538, 28318, 27712, 27497, 27925, 28323, 28034, 28288, 27892, 28253,     0, 23203 };
uint16 DPS_HUNTER_ITEMS[] =         { 28192, 27779, 27713, 0, 28401, 31293, 27936, 27915, 27712, 27528, 25962, 27925, 28034, 28288, 27892, 27903,     0, 31303 };
uint16 DPS_ROGUE_ITEMS[] =          { 28224, 27779, 27797, 0, 28204, 28124, 30538, 27867, 27712, 27509, 27925, 25962, 28034, 28288, 27892, 28189, 28267, 28258 };
uint16 HEAL_PRIEST_ITEMS[] =        { 27866, 28419, 27775, 0, 28230, 28652, 27875, 27525, 28511, 28304, 27491, 27780, 28190, 24390, 27946, 28257, 27714, 27885 };
uint16 DPS_PRIEST_ITEMS[] =         { 28193, 28134, 27796, 0, 27799, 28565, 27907, 29242, 29240, 27465, 28394, 27784, 28223, 28418, 28570, 28341,     0, 28386 };
uint16 ELEMENTAL_SHAMAN_ITEMS[] =   { 28349, 28134, 27802, 0, 27799, 27783, 27909, 29242, 29240, 27510, 28394, 27784, 28223, 28418, 28570, 27741, 27910, 28248 };
uint16 ENHANCE_SHAMAN_ITEMS[] =     { 28192, 29349, 27713, 0, 28401, 31293, 30538, 27867, 27712, 27528, 27925, 25962, 28034, 28288, 27892, 27872, 27872, 22395 };
uint16 HEAL_SHAMAN_ITEMS[] =        { 27759, 28419, 27775, 0, 27912, 27835, 27458, 27549, 28194, 28304, 28259, 27780, 28190, 24390, 27946, 28257, 31292, 27544 };
uint16 DPS_MAGE_ITEMS[] =           { 28193, 28134, 27796, 0, 27799, 27742, 27907, 29242, 29240, 27465, 28394, 27784, 28418, 28223, 28570, 28341,     0, 28386 };
uint16 DPS_WARLOCK_ITEMS[] =        { 28193, 28134, 27796, 0, 27799, 27742, 27907, 29242, 29240, 27465, 28394, 27784, 28418, 28223, 28570, 28341,     0, 28386 };
uint16 BALANCE_DRUID_ITEMS[] =      { 28193, 28134, 27796, 0, 27799, 27783, 27907, 29242, 29240, 27465, 28394, 27784, 28223, 28418, 28570, 28341,     0, 27518 };
uint16 TANK_DRUID_ITEMS[] =         { 28414, 27871, 27776, 0, 25689, 28124, 25690, 25691, 28514, 27509, 27436, 27822, 27891, 32658, 28256, 27757,     0, 23198 };
uint16 FERAL_DRUID_ITEMS[] =        { 28414, 27779, 27995, 0, 27461, 28124, 30538, 27867, 27712, 27509, 25962, 27925, 28288, 28034, 27892, 28325,     0, 28372 };
uint16 HEAL_DRUID_ITEMS[] =         { 27866, 28419, 27775, 0, 28230, 28652, 27875, 28251, 28511, 28304, 27780, 27491, 28190, 24390, 27946, 28257, 27714, 27886 };

void GiveGearAndLevels(Player* Player, uint16 gearList[])
{
    Player->PushSeventy();
    Player->EquipForPushSeventy(gearList);
    Player->FinishPush();
    Player->PushFaction(1011, 9001);
    Player->PushFaction(942, 9001);
    Player->PushFaction(935, 9001);
    Player->PushFaction(989, 9001);
    Player->learnSpell(27028);
    Player->SetSkill(129, 300, 375);
    Player->AddItem(30634, 1);
    Player->AddItem(30623, 1);
    Player->AddItem(30622, 1);
    Player->AddItem(30637, 1);
    Player->AddItem(30635, 1);
    Player->AddItem(30633, 1);
    Player->AddItem(24490, 1);
}

void TryToBoost(Player * Player)
{
    if (Player->GetValidForPushSeventy())
    {
        Player->ADD_GOSSIP_ITEM(0, "Make me level 70. (Your Hearthstone will be set to Shattrath)", GOSSIP_SENDER_MAIN, START_CONVERSATION);
    }
    else
    {
        Player->ADD_GOSSIP_ITEM(0, "Sorry. You are already level 70.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);        
    }
}

bool GossipHello_custom_instant_70_uncommon(Player *Player, Creature *Creature) 
{
    //Left in for future reference of time based access
    /*if (Player->isGameMaster())
    {
        TryToBoost(Player);
    }
    else
    {
        if (time(0) < 1479553200)
        {
            Player->ADD_GOSSIP_ITEM(0, "The event will start saturday at 12:00 UTC+1.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        }
        else if (time(0) > 1479553200 && time(0) < 1479682799)
        {
            TryToBoost(Player);
        }
        else if (time(0) > 1479682799)
        {
            Player->ADD_GOSSIP_ITEM(0, "Sorry, the event has finished.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        }
    }*/
    TryToBoost(Player);
    Player->PlayerTalkClass->SendGossipMenu(30000, Creature->GetGUID());
    return true;
}

bool GossipSelect_custom_instant_70_uncommon(Player* Player, Creature* Creature, uint32 /*sender*/, uint32 action)
{    
    switch (action) 
    {  
        case START_CONVERSATION:
        {
            switch (Player->getClass()) 
            {
                case CLASS_WARRIOR:
                    Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_WARRIOR);
                    Player->ADD_GOSSIP_ITEM(0, "Tank", GOSSIP_SENDER_MAIN, TANK_WARRIOR);
                    break;
                case CLASS_PALADIN:
                    Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_PALADIN);
                    Player->ADD_GOSSIP_ITEM(0, "Tank", GOSSIP_SENDER_MAIN, TANK_PALADIN);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, HEAL_PALADIN);
                    break;
                case CLASS_HUNTER:
                    Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_HUNTER);
                    break;
                case CLASS_ROGUE:
                    Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_ROGUE);
                    break;
                case CLASS_PRIEST:
                    Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_PRIEST);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, HEAL_PRIEST);
                    break;
                case CLASS_SHAMAN:
                    Player->ADD_GOSSIP_ITEM(0, "DPS - Enhancement", GOSSIP_SENDER_MAIN, ENHANCE_SHAMAN);
                    Player->ADD_GOSSIP_ITEM(0, "DPS - Elemental", GOSSIP_SENDER_MAIN, ELEMENTAL_SHAMAN);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, HEAL_SHAMAN);
                    break;
                case CLASS_MAGE:

                    Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_MAGE);
                    break;
                case CLASS_WARLOCK:
                    Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_WARLOCK);
                    break;
                case CLASS_DRUID:
                    Player->ADD_GOSSIP_ITEM(0, "DPS - Feral", GOSSIP_SENDER_MAIN, CAT_DRUID);
                    Player->ADD_GOSSIP_ITEM(0, "DPS - Balance", GOSSIP_SENDER_MAIN, BALANCE_DRUID);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, HEAL_DRUID);
                    Player->ADD_GOSSIP_ITEM(0, "Tank", GOSSIP_SENDER_MAIN, TANK_DRUID);
                    break;
            }
            Player->PlayerTalkClass->SendGossipMenu(30012, Creature->GetGUID());
            break;
        }
        case DPS_WARRIOR:
        {
            Player->AddItem(28253, 1);
            Player->AddItem(35411, 1);
            Player->AddItem(35407, 1);
            Player->AddItem(35410, 1);
            Player->AddItem(35408, 1);    
            
            Player->AddItem(18834, 1);
            GiveGearAndLevels(Player, DPS_WARRIOR_ITEMS);
            break;
        }
        case TANK_WARRIOR:
        {
            Player->AddItem(28288, 1);
            Player->AddItem(28034, 1);
            Player->AddItem(28253, 1);
            Player->AddItem(35411, 1);
            Player->AddItem(35407, 1);
            Player->AddItem(35410, 1);
            Player->AddItem(35408, 1);

            Player->AddItem(18834, 1);
            GiveGearAndLevels(Player, TANK_WARRIOR_ITEMS);
            break;
        }
        case DPS_PALADIN:
        {
            Player->AddItem(35414, 1);
            Player->AddItem(35416, 1);
            Player->AddItem(35412, 1);
            Player->AddItem(35415, 1);

            Player->AddItem(18864, 1);
            GiveGearAndLevels(Player, DPS_PALADIN_ITEMS);
            break;
        }
        case TANK_PALADIN:
        {
            Player->AddItem(28253, 1);
            Player->AddItem(23203, 1);
            Player->AddItem(28288, 1);
            Player->AddItem(28034, 1);
            Player->AddItem(35414, 1);
            Player->AddItem(35416, 1);
            Player->AddItem(35412, 1);
            Player->AddItem(35415, 1);

            Player->AddItem(18864, 1);
            GiveGearAndLevels(Player, TANK_PALADIN_ITEMS);
            break;
        }
        case HEAL_PALADIN:
        {
            Player->AddItem(35402, 1);
            Player->AddItem(35403, 1);
            Player->AddItem(35404, 1);
            Player->AddItem(35405, 1);

            Player->AddItem(18864, 1);
            GiveGearAndLevels(Player, HEAL_PALADIN_ITEMS);
            break;
        }
        case DPS_HUNTER:
        {
            Player->AddItem(35376, 1);
            Player->AddItem(35378, 1);
            Player->AddItem(35379, 1);
            Player->AddItem(35380, 1);

            Player->AddItem(18846, 1);
            GiveGearAndLevels(Player, DPS_HUNTER_ITEMS);
            break;
        }
        case DPS_ROGUE:
        {
            Player->AddItem(35367, 1);
            Player->AddItem(35368, 1);
            Player->AddItem(35369, 1);
            Player->AddItem(35370, 1);

            Player->AddItem(18849, 1);
            GiveGearAndLevels(Player, DPS_ROGUE_ITEMS);
            break;
        }
        case DPS_PRIEST:
        {
            Player->AddItem(35338, 1);
            Player->AddItem(35340, 1);
            Player->AddItem(35341, 1);
            Player->AddItem(35342, 1);

            Player->AddItem(18851, 1);
            GiveGearAndLevels(Player, DPS_PRIEST_ITEMS);
            break;
        }
        case HEAL_PRIEST:
        {
            Player->AddItem(35333, 1);
            Player->AddItem(35334, 1);
            Player->AddItem(35335, 1);
            Player->AddItem(35336, 1);

            Player->AddItem(18851, 1);
            GiveGearAndLevels(Player, HEAL_PRIEST_ITEMS);
            break;
        }
        case ENHANCE_SHAMAN:
        {
            Player->AddItem(35381, 1);
            Player->AddItem(35382, 1);
            Player->AddItem(35384, 1);
            Player->AddItem(35385, 1);

            Player->AddItem(18845, 1);
            GiveGearAndLevels(Player, ENHANCE_SHAMAN_ITEMS);

            break;
        }
        case ELEMENTAL_SHAMAN:
        {
            Player->AddItem(35387, 1);
            Player->AddItem(35388, 1);
            Player->AddItem(35389, 1);
            Player->AddItem(35390, 1);

            Player->AddItem(18845, 1);
            GiveGearAndLevels(Player, ELEMENTAL_SHAMAN_ITEMS);
            break;
        }
        case HEAL_SHAMAN:
        {
            Player->AddItem(35391, 1);
            Player->AddItem(35393, 1);
            Player->AddItem(35394, 1);
            Player->AddItem(35395, 1);

            Player->AddItem(18845, 1);
            GiveGearAndLevels(Player, HEAL_SHAMAN_ITEMS);
            break;
        }
        case DPS_MAGE:
        {
            Player->AddItem(35344, 1);
            Player->AddItem(35345, 1);
            Player->AddItem(35346, 1);
            Player->AddItem(35347, 1);

            Player->AddItem(18850, 1);
            GiveGearAndLevels(Player, DPS_MAGE_ITEMS);
            break;
        }
        case DPS_WARLOCK:
        {
            Player->AddItem(35328, 1);
            Player->AddItem(35329, 1);
            Player->AddItem(35330, 1);
            Player->AddItem(35331, 1);

            Player->AddItem(18852, 1);    
            GiveGearAndLevels(Player, DPS_WARLOCK_ITEMS);
            break;
        }
        case CAT_DRUID:
        {
            Player->AddItem(35356, 1);
            Player->AddItem(35357, 1);
            Player->AddItem(35358, 1);
            Player->AddItem(35359, 1);

            Player->AddItem(18853, 1);
            GiveGearAndLevels(Player, FERAL_DRUID_ITEMS);
            break;
        }
        case BALANCE_DRUID:
        {
            Player->AddItem(35372, 1);
            Player->AddItem(35373, 1);
            Player->AddItem(35374, 1);
            Player->AddItem(35375, 1);

            Player->AddItem(18853, 1);
            GiveGearAndLevels(Player, BALANCE_DRUID_ITEMS);
            break;
        }
        case HEAL_DRUID:
        {
            Player->AddItem(35361, 1);
            Player->AddItem(35362, 1);
            Player->AddItem(35363, 1);
            Player->AddItem(35365, 1);

            Player->AddItem(18853, 1);
            GiveGearAndLevels(Player, HEAL_DRUID_ITEMS);
            break;
        }
        case TANK_DRUID:
        {
            Player->AddItem(28325, 1);
            Player->AddItem(28372, 1);
            Player->AddItem(28288, 1);
            Player->AddItem(28034, 1);
            Player->AddItem(28339, 1);
            Player->AddItem(30538, 1);
            Player->AddItem(31285, 1);

            Player->AddItem(35356, 1);
            Player->AddItem(35357, 1);
            Player->AddItem(35358, 1);
            Player->AddItem(35359, 1);

            Player->AddItem(18853, 1);
            GiveGearAndLevels(Player, TANK_DRUID_ITEMS);
            break;
        }
        default:
            return false;
    }
    return true;
}

void AddSC_custom_instant_70_uncommon() {

    Script *newscript;
    newscript = new Script;
    newscript->Name = "custom_instant_70_uncommon";
    newscript->pGossipHello = &GossipHello_custom_instant_70_uncommon;
    newscript->pGossipSelect = &GossipSelect_custom_instant_70_uncommon;
    newscript->RegisterSelf();
}