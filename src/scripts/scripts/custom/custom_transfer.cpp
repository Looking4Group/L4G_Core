/*
##################################################
# This file will be used for Custom Transfer NPC.#
##################################################
*/

#include "precompiled.h"
#include <cstring>

enum Instant_70_Conversations
{
    START_CONVERSATION = GOSSIP_ACTION_INFO_DEF + 12,
    WARRIOR_ARMS       = GOSSIP_ACTION_INFO_DEF + 13,
    WARRIOR_FURY       = GOSSIP_ACTION_INFO_DEF + 14,
    WARRIOR_PROTECTION = GOSSIP_ACTION_INFO_DEF + 15,
    DPS_PALADIN        = GOSSIP_ACTION_INFO_DEF + 16,
    TANK_PALADIN       = GOSSIP_ACTION_INFO_DEF + 17,
    HEAL_PALADIN       = GOSSIP_ACTION_INFO_DEF + 18,
    DPS_HUNTER         = GOSSIP_ACTION_INFO_DEF + 19,
    DPS_ROGUE          = GOSSIP_ACTION_INFO_DEF + 20,
    DPS_PRIEST         = GOSSIP_ACTION_INFO_DEF + 21,
    HEAL_PRIEST        = GOSSIP_ACTION_INFO_DEF + 22,
    ENHANCE_SHAMAN     = GOSSIP_ACTION_INFO_DEF + 23,
    ELEMENTAL_SHAMAN   = GOSSIP_ACTION_INFO_DEF + 24,
    HEAL_SHAMAN        = GOSSIP_ACTION_INFO_DEF + 25,
    DPS_MAGE           = GOSSIP_ACTION_INFO_DEF + 26,
    DPS_WARLOCK        = GOSSIP_ACTION_INFO_DEF + 27,
    CAT_DRUID          = GOSSIP_ACTION_INFO_DEF + 28,
    BALANCE_DRUID      = GOSSIP_ACTION_INFO_DEF + 29,
    HEAL_DRUID         = GOSSIP_ACTION_INFO_DEF + 30,
    TANK_DRUID         = GOSSIP_ACTION_INFO_DEF + 31,
    FACTION_LOWER_CITY = GOSSIP_ACTION_INFO_DEF + 32,
    FACTION_CENARION_EXPEDITION = GOSSIP_ACTION_INFO_DEF + 33,
    FACTION_THRALLMAR = GOSSIP_ACTION_INFO_DEF + 34,
    FACTION_HONOR_HOLD = GOSSIP_ACTION_INFO_DEF + 35,
    FACTION_SHA_TAR = GOSSIP_ACTION_INFO_DEF + 36,
    FACTION_KEEPERS_OF_TIME = GOSSIP_ACTION_INFO_DEF + 37,
    ALDOR_SCRYER_SELECT = GOSSIP_ACTION_INFO_DEF + 39,
    FACTION_ALDOR = GOSSIP_ACTION_INFO_DEF + 40,
    FACTION_SCRYER = GOSSIP_ACTION_INFO_DEF + 41,
    FLYING_MOUNT_SELECT = GOSSIP_ACTION_INFO_DEF + 42,
    FLYING_MOUNT_YES = GOSSIP_ACTION_INFO_DEF + 43,
    FLYING_MOUNT_NO = GOSSIP_ACTION_INFO_DEF + 44,
    LOWER_CITY_NEUTRAL = GOSSIP_ACTION_INFO_DEF + 45,
    LOWER_CITY_FRIENDLY = GOSSIP_ACTION_INFO_DEF + 46,
    LOWER_CITY_HONORED = GOSSIP_ACTION_INFO_DEF + 47,
    CENARION_EXPEDITION_NEUTRAL = GOSSIP_ACTION_INFO_DEF + 48,
    CENARION_EXPEDITION_FRIENDLY = GOSSIP_ACTION_INFO_DEF + 49,
    CENARION_EXPEDITION_HONORED = GOSSIP_ACTION_INFO_DEF + 50,
    THRALLMAR_NEUTRAL = GOSSIP_ACTION_INFO_DEF + 51,
    THRALLMAR_FRIENDLY = GOSSIP_ACTION_INFO_DEF + 52,
    THRALLMAR_HONORED = GOSSIP_ACTION_INFO_DEF + 53,
    HONOR_HOLD_NEUTRAL = GOSSIP_ACTION_INFO_DEF + 54,
    HONOR_HOLD_FRIENDLY = GOSSIP_ACTION_INFO_DEF + 55,
    HONOR_HOLD_HONORED = GOSSIP_ACTION_INFO_DEF + 56,
    SHA_TAR_NEUTRAL = GOSSIP_ACTION_INFO_DEF + 57,
    SHA_TAR_FRIENDLY = GOSSIP_ACTION_INFO_DEF + 58,
    SHA_TAR_HONORED = GOSSIP_ACTION_INFO_DEF + 59,
    KEEPERS_OF_TIME_NEUTRAL = GOSSIP_ACTION_INFO_DEF + 60,
    KEEPERS_OF_TIME_FRIENDLY = GOSSIP_ACTION_INFO_DEF + 61,
    KEEPERS_OF_TIME_HONORED = GOSSIP_ACTION_INFO_DEF + 62,
    ALDOR_NOTHING = GOSSIP_ACTION_INFO_DEF + 63,
    ALDOR_HONORED = GOSSIP_ACTION_INFO_DEF + 64,
    SCRYER_NOTHING = GOSSIP_ACTION_INFO_DEF + 65,
    SCRYER_HONORED = GOSSIP_ACTION_INFO_DEF + 66
};



uint16 DRUID_BALANCE_ITEMS[]     = { 28193,28134,27796,28570,27799,29240,27465,27783,27907,29242,27784,28394,28223,28418,28341,27518 };
uint16 DRUID_BEAR_ITEMS[]        = { 28414,27871,27776,28256,31285,28514,27509,28124,30538,28339,27436,27436,28121,27891,27757,23198 };
uint16 DRUID_CAT_ITEMS[]         = { 28414,27779,27995,27892,27461,27712,27509,28124,30538,27867,27925,25962,28288,28034,28325,28372 };
uint16 DRUID_RESTO_ITEMS[]       = { 27866,28419,27775,27946,28230,28511,28304,28652,27875,28251,27780,27491,28190,24390,28257,27714,27886 };

uint16 HUNTER_ITEMS[]            = { 28192,27779,27713,27892,28401,27712,27528,31293,27936,27915,27925,25962,28034,28288,27903,31303 };
uint16 MAGE_ITEMS[]              = { 28193,28134,27796,28570,27799,29240,27465,27742,27907,29242,27784,28394,28223,28418,28341,28386 };
uint16 WARLOCK_ITEMS[]           = { 28193,28134,27796,28570,27799,29240,27465,27742,27907,29242,27784,28394,28223,28418,28341,28386 };

uint16 PALADIN_HOLY_ITEMS[]      = { 27790,28419,27775,27946,27897,28194,28304,27548,27458,28221,27780,28259,28190,24390,28257,31292,28296 };
uint16 PALADIN_PROT_ITEMS[]      = { 28285,27792,27739,27804,28203,27459,27535,27672,27839,29239,27805,27805,27529,27891,27905,28316,27917 };
uint16 PALADIN_RET_ITEMS[]       = { 28225,27551,27771,27892,28403,27712,27497,27985,30538,28318,27925,28323,28034,28288,27497,23203 };

uint16 PRIEST_HEAL_ITEMS[]       = { 27866,28419,27775,27946,28230,28511,28304,28652,27875,27525,27780,27491,28190,24390,28257,27714,27885 };
uint16 PRIEST_SHADOW_ITEMS[]     = { 28193,28134,27796,28570,27799,29240,27465,28565,27907,29242,27784,28394,28223,28418,28341,28386 };

uint16 ROGUE_ITEMS[]             = { 28224,27779,27797,27892,28204,27712,27509,28124,30538,27867,27925,25962,28034,28288,28267,28189,27526 };

uint16 SHAMAN_ELE_ITEMS[]        = { 28349,28134,27802,28570,27799,29240,27510,27783,27909,29242,27784,28394,28223,28418,27741,27910,28248,5175,5176,5177,5178 };
uint16 SHAMAN_ENHANCER_ITEMS[]   = { 28192,29349,27713,27892,28401,27712,27528,31293,30538,27867,27925,25962,28034,28288,27872,27872,22395,5175,5176,5177,5178 };
uint16 SHAMAN_RESTO_ITEMS[]      = { 27759,28419,27775,27946,27912,28194,28304,27835,27458,27549,27780,28259,28190,24390,28257,31292,27544,5175,5176,5177,5178 };

uint16 WARRIOR_ARMS_ITEMS[]      = { 28056, 28225,27551,27771,27892,28403,27712,27497,27985,30538,28318,27925,28323,28034,28288,27497,27526 };
uint16 WARRIOR_FURY_ITEMS[]      = { 28056, 28225,27551,27771,27892,28403,27712,27497,27985,30538,28318,27925,28323,28034,28288,27872,27872,27526 };
uint16 WARRIOR_PROT_ITEMS[]      = { 28056, 28350,27871,27803,27804,28262,27459,27475,27672,27527,29239,28407,27822,27529,27891,29362,27887,28258 };




void GiveGearAndLevels(Player* Player, uint16 gearList[])
{
    Player->PushSeventy();
    Player->EquipForPushSeventy(gearList);
    Player->FinishTransferQuests();
    Player->FinishPushTransfer();
}

bool GossipHello_custom_transfer(Player *Player, Creature *Creature) 
{
    Player->ADD_GOSSIP_ITEM(0, "Let's do this!", GOSSIP_SENDER_MAIN, START_CONVERSATION);
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
                    Player->ADD_GOSSIP_ITEM(0, "Arms", GOSSIP_SENDER_MAIN, WARRIOR_ARMS);
                    Player->ADD_GOSSIP_ITEM(0, "Fury", GOSSIP_SENDER_MAIN, WARRIOR_FURY);
                    Player->ADD_GOSSIP_ITEM(0, "Protection", GOSSIP_SENDER_MAIN, WARRIOR_PROTECTION);
                    break;
                case CLASS_PALADIN:
                    Player->ADD_GOSSIP_ITEM(0, "Holy", GOSSIP_SENDER_MAIN, DPS_PALADIN);
                    Player->ADD_GOSSIP_ITEM(0, "Protection", GOSSIP_SENDER_MAIN, TANK_PALADIN);
                    Player->ADD_GOSSIP_ITEM(0, "Retribution", GOSSIP_SENDER_MAIN, HEAL_PALADIN);
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
                    Player->ADD_GOSSIP_ITEM(0, "DPS - Enhancer", GOSSIP_SENDER_MAIN, ENHANCE_SHAMAN);
                    Player->ADD_GOSSIP_ITEM(0, "DPS - Elemental", GOSSIP_SENDER_MAIN, ELEMENTAL_SHAMAN);
                    Player->ADD_GOSSIP_ITEM(0, "Restoration", GOSSIP_SENDER_MAIN, HEAL_SHAMAN);
                    break;
                case CLASS_MAGE:
                    Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_MAGE);
                    break;
                case CLASS_WARLOCK:
                    Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_WARLOCK);
                    break;
                case CLASS_DRUID:
                    Player->ADD_GOSSIP_ITEM(0, "Feral - Cat", GOSSIP_SENDER_MAIN, CAT_DRUID);
                    Player->ADD_GOSSIP_ITEM(0, "Feral - Bear", GOSSIP_SENDER_MAIN, BALANCE_DRUID);
                    Player->ADD_GOSSIP_ITEM(0, "Balance", GOSSIP_SENDER_MAIN, HEAL_DRUID);
                    Player->ADD_GOSSIP_ITEM(0, "Restoration", GOSSIP_SENDER_MAIN, TANK_DRUID);
                    break;
            }
            Player->PlayerTalkClass->SendGossipMenu(30012, Creature->GetGUID());
            break;
        }
        case WARRIOR_ARMS:
        {
            GiveGearAndLevels(Player, WARRIOR_ARMS_ITEMS);            
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case WARRIOR_FURY:
        {
            GiveGearAndLevels(Player, WARRIOR_FURY_ITEMS);            
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case WARRIOR_PROTECTION:
        {
            GiveGearAndLevels(Player, WARRIOR_PROT_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case DPS_PALADIN:
        {
            GiveGearAndLevels(Player, PALADIN_RET_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case TANK_PALADIN:
        {
            GiveGearAndLevels(Player, PALADIN_PROT_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case HEAL_PALADIN:
        {
            GiveGearAndLevels(Player, PALADIN_HOLY_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case DPS_HUNTER:
        {
            GiveGearAndLevels(Player, HUNTER_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case DPS_ROGUE:
        {
            GiveGearAndLevels(Player, ROGUE_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case DPS_PRIEST:
        {
            GiveGearAndLevels(Player, PRIEST_SHADOW_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case HEAL_PRIEST:
        {
            GiveGearAndLevels(Player, PRIEST_HEAL_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case ENHANCE_SHAMAN:
        {
            GiveGearAndLevels(Player, SHAMAN_ENHANCER_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case ELEMENTAL_SHAMAN:
        {
            GiveGearAndLevels(Player, SHAMAN_ELE_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case HEAL_SHAMAN:
        {
            GiveGearAndLevels(Player, SHAMAN_RESTO_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case DPS_MAGE:
        {
            GiveGearAndLevels(Player, MAGE_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case DPS_WARLOCK:
        {
            GiveGearAndLevels(Player, WARLOCK_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case CAT_DRUID:
        {
            GiveGearAndLevels(Player, DRUID_CAT_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case BALANCE_DRUID:
        {
            GiveGearAndLevels(Player, DRUID_BALANCE_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case HEAL_DRUID:
        {
            GiveGearAndLevels(Player, DRUID_RESTO_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case TANK_DRUID:
        {
            GiveGearAndLevels(Player, DRUID_BEAR_ITEMS);
            Player->PlayerTalkClass->SendGossipMenu(30032, Creature->GetGUID());
            break;
        }
        case FACTION_LOWER_CITY:
        {
            Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, LOWER_CITY_NEUTRAL);
            Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, LOWER_CITY_FRIENDLY);
            Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, LOWER_CITY_HONORED);
        }
        case FACTION_CENARION_EXPEDITION:
        {
            Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, CENARION_EXPEDITION_NEUTRAL);
            Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, CENARION_EXPEDITION_FRIENDLY);
            Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, CENARION_EXPEDITION_HONORED);
        }
        case FACTION_THRALLMAR:
        {
            Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, THRALLMAR_NEUTRAL);
            Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, THRALLMAR_FRIENDLY);
            Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, THRALLMAR_HONORED);
        }
        case FACTION_HONOR_HOLD:
        {
            Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, HONOR_HOLD_NEUTRAL);
            Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, HONOR_HOLD_FRIENDLY);
            Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, HONOR_HOLD_HONORED);
        }
        case FACTION_SHA_TAR:
        {
            Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, SHA_TAR_NEUTRAL);
            Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, SHA_TAR_FRIENDLY);
            Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, SHA_TAR_HONORED);
        }
        case FACTION_KEEPERS_OF_TIME:
        {
            Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, KEEPERS_OF_TIME_NEUTRAL);
            Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, KEEPERS_OF_TIME_FRIENDLY);
            Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, KEEPERS_OF_TIME_HONORED);
        }
        case LOWER_CITY_NEUTRAL:
        {
            break;
            Player->PlayerTalkClass->SendGossipMenu(30033, Creature->GetGUID());
        }
        case LOWER_CITY_FRIENDLY:
        {
            Player->PushFaction(1011, 3001);
            Player->PlayerTalkClass->SendGossipMenu(30033, Creature->GetGUID());
            break;
        }
        case LOWER_CITY_HONORED:
        {
            Player->PushFaction(1011, 9001);
            Player->AddItem(30633, 1);
            Player->PlayerTalkClass->SendGossipMenu(30033, Creature->GetGUID());
            break;
        }
        case CENARION_EXPEDITION_NEUTRAL:
        {
            Player->PlayerTalkClass->SendGossipMenu(30034, Creature->GetGUID());
            break;
        }
        case CENARION_EXPEDITION_FRIENDLY:
        {
            Player->PlayerTalkClass->SendGossipMenu(30034, Creature->GetGUID());
            Player->PushFaction(942, 3001);
            break;
        }
        case CENARION_EXPEDITION_HONORED:
        {
            Player->AddItem(30623, 1);
            Player->PlayerTalkClass->SendGossipMenu(30034, Creature->GetGUID());
            Player->PushFaction(942, 9001);
            break;
        }
        case THRALLMAR_NEUTRAL:
        {
            Player->PlayerTalkClass->SendGossipMenu(30035, Creature->GetGUID());
            break;
        }
        case THRALLMAR_FRIENDLY:
        {
            Player->PlayerTalkClass->SendGossipMenu(30035, Creature->GetGUID());
            Player->PushFaction(947, 3001);
            break;
        }
        case THRALLMAR_HONORED:
        {
            Player->AddItem(30637, 1);
            Player->PlayerTalkClass->SendGossipMenu(30035, Creature->GetGUID());
            Player->PushFaction(947, 9001);
            break;
        }
        case HONOR_HOLD_NEUTRAL:
        {
            Player->PlayerTalkClass->SendGossipMenu(30036, Creature->GetGUID());
            break;
        }
        case HONOR_HOLD_FRIENDLY:
        {
            Player->PlayerTalkClass->SendGossipMenu(30036, Creature->GetGUID());
            Player->PushFaction(946, 3001);
            break;
        }
        case HONOR_HOLD_HONORED:
        {
            Player->AddItem(30622, 1);
            Player->PlayerTalkClass->SendGossipMenu(30036, Creature->GetGUID());
            Player->PushFaction(946, 9001);
            break;
        }
        case SHA_TAR_NEUTRAL:
        {
            Player->PlayerTalkClass->SendGossipMenu(30037, Creature->GetGUID());
            break;
        }
        case SHA_TAR_FRIENDLY:
        {
            Player->PlayerTalkClass->SendGossipMenu(30037, Creature->GetGUID());
            Player->PushFaction(935, 3001);
            break;
        }
        case SHA_TAR_HONORED:
        {
            Player->AddItem(30634, 1);
            Player->PlayerTalkClass->SendGossipMenu(30037, Creature->GetGUID());
            Player->PushFaction(935, 9001);
            break;
        }
        case KEEPERS_OF_TIME_NEUTRAL:
        {
            Player->PlayerTalkClass->SendGossipMenu(30039, Creature->GetGUID());
            break;
        }
        case KEEPERS_OF_TIME_FRIENDLY:
        {
            Player->PlayerTalkClass->SendGossipMenu(30039, Creature->GetGUID());
            Player->PushFaction(989, 3001);            
            break;
        }
        case KEEPERS_OF_TIME_HONORED:
        {
            Player->AddItem(30635, 1);
            Player->PlayerTalkClass->SendGossipMenu(30039, Creature->GetGUID());
            Player->PushFaction(989, 9001);
            break;
        }
        case ALDOR_SCRYER_SELECT:
        {
            Player->ADD_GOSSIP_ITEM(0, "Aldor", GOSSIP_SENDER_MAIN, FACTION_ALDOR_SELECT);
            Player->ADD_GOSSIP_ITEM(0, "Scryer", GOSSIP_SENDER_MAIN, FACTION_SCRYER_SELECT);
        }
        case FACTION_ALDOR_SELECT:
        {
            Player->ADD_GOSSIP_ITEM(0, "Nothing", GOSSIP_SENDER_MAIN, ALDOR_NOTHING);
            Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, ALDOR_HONORED);
        }
        case FACTION_SCRYER_SELECT:
        {
            Player->ADD_GOSSIP_ITEM(0, "Nothing", GOSSIP_SENDER_MAIN, SCRYER_NOTHING);
            Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, SCRYER_HONORED);
        }
        case ALDOR_NOTHING:
        {
            break;
        }
        case ALDOR_HONORED:
        {
            Player->PlayerTalkClass->SendGossipMenu(30042, Creature->GetGUID());
            Player->PushFaction(932, 5501);
            break;
        }
        case SCRYER_NOTHING:
        {
            break;
        }
        case SCRYER_HONORED:
        {
            Player->PlayerTalkClass->SendGossipMenu(30042, Creature->GetGUID());
            Player->PushFaction(934, 5501);
            break;
        }
        case FLYING_MOUNT_SELECT:
        {
            Player->ADD_GOSSIP_ITEM(0, "Yes", GOSSIP_SENDER_MAIN, FLYING_MOUNT_YES);
            Player->ADD_GOSSIP_ITEM(0, "No", GOSSIP_SENDER_MAIN, FLYING_MOUNT_NO);
        }
        case FLYING_MOUNT_YES:
        {
            switch (Player->GetTeam())
            {
                //225 riding
                Player->learnSpell(34090);
            case ALLIANCE:
                Player->AddItem(25470, 1);
                break;
            case HORDE:
                Player->AddItem(25475, 1);
                break;
            default:
                break;
            }
        }
        case FLYING_MOUNT_NO:
        {
            break;
        }
        default:
            return false;
    }   

    return true;
}

void AddSC_custom_transfer() {

    Script *newscript;
    newscript = new Script;
    newscript->Name = "customer_transfer";
    newscript->pGossipHello = &GossipHello_custom_transfer;
    newscript->pGossipSelect = &GossipHello_custom_transfer;
    newscript->RegisterSelf();
}