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
    WARRIOR_ARMS = GOSSIP_ACTION_INFO_DEF + 13,
    WARRIOR_FURY = GOSSIP_ACTION_INFO_DEF + 14,
    WARRIOR_PROTECTION = GOSSIP_ACTION_INFO_DEF + 15,
    DPS_PALADIN = GOSSIP_ACTION_INFO_DEF + 16,
    TANK_PALADIN = GOSSIP_ACTION_INFO_DEF + 17,
    HEAL_PALADIN = GOSSIP_ACTION_INFO_DEF + 18,
    DPS_HUNTER = GOSSIP_ACTION_INFO_DEF + 19,
    DPS_ROGUE = GOSSIP_ACTION_INFO_DEF + 20,
    DPS_PRIEST = GOSSIP_ACTION_INFO_DEF + 21,
    HEAL_PRIEST = GOSSIP_ACTION_INFO_DEF + 22,
    ENHANCE_SHAMAN = GOSSIP_ACTION_INFO_DEF + 23,
    ELEMENTAL_SHAMAN = GOSSIP_ACTION_INFO_DEF + 24,
    HEAL_SHAMAN = GOSSIP_ACTION_INFO_DEF + 25,
    DPS_MAGE = GOSSIP_ACTION_INFO_DEF + 26,
    DPS_WARLOCK = GOSSIP_ACTION_INFO_DEF + 27,
    CAT_DRUID = GOSSIP_ACTION_INFO_DEF + 28,
    BALANCE_DRUID = GOSSIP_ACTION_INFO_DEF + 29,
    HEAL_DRUID = GOSSIP_ACTION_INFO_DEF + 30,
    TANK_DRUID = GOSSIP_ACTION_INFO_DEF + 31,
    FACTION_LOWER_CITY = GOSSIP_ACTION_INFO_DEF + 32,
    FACTION_CENARION_EXPEDITION = GOSSIP_ACTION_INFO_DEF + 33,
    FACTION_THRALLMAR = GOSSIP_ACTION_INFO_DEF + 34,
    FACTION_HONOR_HOLD = GOSSIP_ACTION_INFO_DEF + 35,
    FACTION_SHA_TAR = GOSSIP_ACTION_INFO_DEF + 36,
    FACTION_KEEPERS_OF_TIME = GOSSIP_ACTION_INFO_DEF + 37,
    ALDOR_SCRYER_SELECT = GOSSIP_ACTION_INFO_DEF + 39,    
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
    SCRYER_HONORED = GOSSIP_ACTION_INFO_DEF + 66,
    FACTION_ALDOR_SELECT = GOSSIP_ACTION_INFO_DEF + 67,
    FACTION_SCRYER_SELECT = GOSSIP_ACTION_INFO_DEF + 68,
    CLASS_SELECT = GOSSIP_ACTION_INFO_DEF + 69,
    FACTION_MAIN_SELECT = GOSSIP_ACTION_INFO_DEF + 70
};



// Head, Neck, Should, 0, Chest, Waist,  Legs,  Feet,Wrists, Hands,    F1,    F2,    T1,    T2,  Back, MHand, OHand, Ranged 
uint16 DRUID_BALANCE_ITEMS[] = { 28193, 28134, 27796, 0, 27799, 27783, 27907, 29242, 29240, 27465, 28394, 27784, 28223, 28418, 28570, 28341, 0, 27518 };
uint16 DRUID_BEAR_ITEMS[] = { 28414, 27871, 27776, 0, 31285, 28124, 30538, 28339, 28514, 27509, 27436, 28121, 27891, 32658, 28256, 27757, 0, 23198 };
uint16 DRUID_CAT_ITEMS[] = { 28414, 27779, 27995, 0, 27461, 28124, 30538, 27867, 27712, 27509, 25962, 27925, 28288, 28034, 27892, 28325,     0, 28372 };
uint16 DRUID_RESTO_ITEMS[] = { 27866, 28419, 27775, 0, 28230, 28652, 27875, 28251, 28511, 28304, 27780, 27491, 28190, 24390, 27946, 28257, 27714, 27886 };

uint16 HUNTER_ITEMS[] = { 28192, 27779, 27713, 0, 28401, 31293, 27936, 27915, 27712, 27528, 25962, 27925, 28034, 28288, 27892, 27903,     0, 31303 };

uint16 MAGE_ITEMS[] = { 28193, 28134, 27796, 0, 27799, 27742, 27907, 29242, 29240, 27465, 28394, 27784, 28418, 28223, 28570, 28341,     0, 28386 };

uint16 WARLOCK_ITEMS[] = { 28193, 28134, 27796, 0, 27799, 27742, 27907, 29242, 29240, 27465, 28394, 27784, 28418, 28223, 28570, 28341,     0, 28386 };

uint16 PALADIN_HOLY_ITEMS[] = { 27790, 28419, 27775, 0, 27897, 27548, 27458, 28221, 28194, 28304, 28259, 27780, 24390, 28190, 27946, 28257, 31292, 28296 };
uint16 PALADIN_PROT_ITEMS[] = { 28285, 27792, 27739, 0, 28203, 27672, 27839, 29239, 27459, 27535, 27822, 28407, 27891, 27529, 27804, 27905, 28316, 27917 };
uint16 PALADIN_RET_ITEMS[] = { 28225, 27551, 27771, 0, 28403, 27985, 30538, 28318, 27712, 27497, 27925, 28323, 28034, 28288, 27892, 28253,     0, 23203 };

uint16 PRIEST_HEAL_ITEMS[] = { 27866, 28419, 27775, 0, 28230, 28652, 27875, 27525, 28511, 28304, 27491, 27780, 28190, 24390, 27946, 28257, 27714, 27885 };
uint16 PRIEST_SHADOW_ITEMS[] = { 28193, 28134, 27796, 0, 27799, 28565, 27907, 29242, 29240, 27465, 28394, 27784, 28223, 28418, 28570, 28341,     0, 28386 };

uint16 ROGUE_ITEMS[] = { 28224, 27779, 27797, 0, 28204, 28124, 30538, 27867, 27712, 27509, 27925, 25962, 28034, 28288, 27892, 28189, 28267, 27526 };

uint16 SHAMAN_ELE_ITEMS[] = { 28349, 28134, 27802, 0, 27799, 27783, 27909, 29242, 29240, 27510, 28394, 27784, 28223, 28418, 28570, 27741, 27910, 28248 };
uint16 SHAMAN_ENHANCER_ITEMS[] = { 28192, 29349, 27713, 0, 28401, 31293, 30538, 27867, 27712, 27528, 27925, 25962, 28034, 28288, 27892, 27872, 27872, 22395 };
uint16 SHAMAN_RESTO_ITEMS[] = { 27759, 28419, 27775, 0, 27912, 27835, 27458, 27549, 28194, 28304, 28259, 27780, 28190, 24390, 27946, 28257, 31292, 27544 };

uint16 WARRIOR_ARMS_ITEMS[] = { 28225, 27551, 27771, 0, 28403, 27985, 30538, 28318, 27712, 27497, 27925, 28323, 28288, 28034, 27892, 28253,     0, 27526 };
uint16 WARRIOR_FURY_ITEMS[] = { 28225, 27551, 27771, 0, 28403, 27985, 30538, 28318, 27712, 27497, 27925, 28323, 28034, 28288, 27892, 27872, 27872, 27526 };
uint16 WARRIOR_PROT_ITEMS[] = { 28350, 27871, 27803, 0, 28262, 27672, 27527, 29239, 27459, 27475, 27822, 28407, 27529, 27891, 27804, 29362, 27887, 28258 };

void GiveGearLevels(Player* Player, uint16 gearList[])
{
    Player->PushSeventy();
    Player->EquipForPushSeventy(gearList);
    Player->FinishTransferQuests();
    Player->FinishPushTransfer();
}

bool GossipHello_custom_transfer(Player *Player, Creature *Creature)
{

    Player->ADD_GOSSIP_ITEM(0, "Level & equip", GOSSIP_SENDER_MAIN, CLASS_SELECT);
    Player->ADD_GOSSIP_ITEM(0, "Factions", GOSSIP_SENDER_MAIN, FACTION_MAIN_SELECT);
    Player->ADD_GOSSIP_ITEM(0, "Flying mount", GOSSIP_SENDER_MAIN, FLYING_MOUNT_SELECT);

    Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    return true;
}

bool GossipSelect_custom_transfer(Player* Player, Creature* Creature, uint32 /*sender*/, uint32 action)
{
    if (action == CLASS_SELECT)
    {
        if (Player->getClass() == CLASS_WARRIOR)
        {
            Player->ADD_GOSSIP_ITEM(0, "Arms", GOSSIP_SENDER_MAIN, WARRIOR_ARMS);
            Player->ADD_GOSSIP_ITEM(0, "Fury", GOSSIP_SENDER_MAIN, WARRIOR_FURY);
            Player->ADD_GOSSIP_ITEM(0, "Protection", GOSSIP_SENDER_MAIN, WARRIOR_PROTECTION);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }
        else if (Player->getClass() == CLASS_PALADIN) {
            Player->ADD_GOSSIP_ITEM(0, "Holy", GOSSIP_SENDER_MAIN, HEAL_PALADIN);
            Player->ADD_GOSSIP_ITEM(0, "Protection", GOSSIP_SENDER_MAIN, TANK_PALADIN);
            Player->ADD_GOSSIP_ITEM(0, "Retribution", GOSSIP_SENDER_MAIN, DPS_PALADIN);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }
        else if (Player->getClass() == CLASS_HUNTER)
        {
            Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_HUNTER);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());

        }
        else if (Player->getClass() == CLASS_ROGUE) {
            Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_ROGUE);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }
        else if (Player->getClass() == CLASS_PRIEST) {
            Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_PRIEST);
            Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, HEAL_PRIEST);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }
        else if (Player->getClass() == CLASS_SHAMAN) {
            Player->ADD_GOSSIP_ITEM(0, "DPS - Enhancer", GOSSIP_SENDER_MAIN, ENHANCE_SHAMAN);
            Player->ADD_GOSSIP_ITEM(0, "DPS - Elemental", GOSSIP_SENDER_MAIN, ELEMENTAL_SHAMAN);
            Player->ADD_GOSSIP_ITEM(0, "Restoration", GOSSIP_SENDER_MAIN, HEAL_SHAMAN);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }

        else if (Player->getClass() == CLASS_MAGE) {
            Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_MAGE);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }
        else if (Player->getClass() == CLASS_WARLOCK) {
            Player->ADD_GOSSIP_ITEM(0, "DPS", GOSSIP_SENDER_MAIN, DPS_WARLOCK);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }
        else if (Player->getClass() == CLASS_DRUID) {
            Player->ADD_GOSSIP_ITEM(0, "Feral - Cat", GOSSIP_SENDER_MAIN, CAT_DRUID);
            Player->ADD_GOSSIP_ITEM(0, "Feral - Bear", GOSSIP_SENDER_MAIN, TANK_DRUID);
            Player->ADD_GOSSIP_ITEM(0, "Balance", GOSSIP_SENDER_MAIN, BALANCE_DRUID);
            Player->ADD_GOSSIP_ITEM(0, "Restoration", GOSSIP_SENDER_MAIN, HEAL_DRUID);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }
    }
    if (action == FACTION_MAIN_SELECT) {
        Player->ADD_GOSSIP_ITEM(0, "Lower city", GOSSIP_SENDER_MAIN, FACTION_LOWER_CITY);
        Player->ADD_GOSSIP_ITEM(0, "Cenarion Expedition", GOSSIP_SENDER_MAIN, FACTION_CENARION_EXPEDITION);
        Player->ADD_GOSSIP_ITEM(0, "Thrallmar", GOSSIP_SENDER_MAIN, FACTION_THRALLMAR);
        Player->ADD_GOSSIP_ITEM(0, "Honor Hold", GOSSIP_SENDER_MAIN, FACTION_HONOR_HOLD);
        Player->ADD_GOSSIP_ITEM(0, "Sha'tar", GOSSIP_SENDER_MAIN, FACTION_SHA_TAR);
        Player->ADD_GOSSIP_ITEM(0, "Keepers of Time", GOSSIP_SENDER_MAIN, FACTION_KEEPERS_OF_TIME);
        Player->ADD_GOSSIP_ITEM(0, "Aldor", GOSSIP_SENDER_MAIN, FACTION_ALDOR_SELECT);
        Player->ADD_GOSSIP_ITEM(0, "Scryer", GOSSIP_SENDER_MAIN, FACTION_SCRYER_SELECT);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    if (action == FLYING_MOUNT_SELECT)
    {
        Player->ADD_GOSSIP_ITEM(0, "Yes", GOSSIP_SENDER_MAIN, FLYING_MOUNT_YES);
        Player->ADD_GOSSIP_ITEM(0, "No", GOSSIP_SENDER_MAIN, FLYING_MOUNT_NO);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == WARRIOR_ARMS)
    {
        GiveGearLevels(Player, WARRIOR_ARMS_ITEMS);        
        Player->AddItem(28056, 200);            
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == WARRIOR_FURY)
    {
        GiveGearLevels(Player, WARRIOR_FURY_ITEMS);
        Player->AddItem(28056, 200);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == WARRIOR_PROTECTION)
    {
        GiveGearLevels(Player, WARRIOR_PROT_ITEMS);
        Player->AddItem(28056, 200);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == DPS_PALADIN)
    {
        GiveGearLevels(Player, PALADIN_RET_ITEMS);        
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == TANK_PALADIN)
    {
        GiveGearLevels(Player, PALADIN_PROT_ITEMS);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == HEAL_PALADIN)
    {
        GiveGearLevels(Player, PALADIN_HOLY_ITEMS);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == DPS_HUNTER)
    {
        GiveGearLevels(Player, HUNTER_ITEMS);        
        Player->AddItem(28056, 200);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == DPS_ROGUE)
    {
        GiveGearLevels(Player, ROGUE_ITEMS);
        Player->AddItem(28056, 200);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == DPS_PRIEST)
    {
        GiveGearLevels(Player, PRIEST_SHADOW_ITEMS);                
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == HEAL_PRIEST)
    {
        GiveGearLevels(Player, PRIEST_HEAL_ITEMS);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == ENHANCE_SHAMAN)
    {
        GiveGearLevels(Player, SHAMAN_ENHANCER_ITEMS);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == ELEMENTAL_SHAMAN)
    {
        GiveGearLevels(Player, SHAMAN_ELE_ITEMS);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == HEAL_SHAMAN)
    {
        GiveGearLevels(Player, SHAMAN_RESTO_ITEMS);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == DPS_MAGE)
    {
        GiveGearLevels(Player, MAGE_ITEMS);        
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == DPS_WARLOCK)
    {
        GiveGearLevels(Player, WARLOCK_ITEMS);        
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == CAT_DRUID)
    {
        GiveGearLevels(Player, DRUID_CAT_ITEMS);        
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == BALANCE_DRUID)
    {
        GiveGearLevels(Player, DRUID_BALANCE_ITEMS);        
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == HEAL_DRUID)
    {
        GiveGearLevels(Player, DRUID_RESTO_ITEMS);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == TANK_DRUID)
    {
        GiveGearLevels(Player, DRUID_BEAR_ITEMS);        
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == FACTION_LOWER_CITY)
    {
        Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, LOWER_CITY_NEUTRAL);
        Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, LOWER_CITY_FRIENDLY);
        Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, LOWER_CITY_HONORED);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == FACTION_CENARION_EXPEDITION)
    {
        Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, CENARION_EXPEDITION_NEUTRAL);
        Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, CENARION_EXPEDITION_FRIENDLY);
        Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, CENARION_EXPEDITION_HONORED);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == FACTION_THRALLMAR)
    {
        Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, THRALLMAR_NEUTRAL);
        Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, THRALLMAR_FRIENDLY);
        Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, THRALLMAR_HONORED);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == FACTION_HONOR_HOLD)
    {
        Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, HONOR_HOLD_NEUTRAL);
        Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, HONOR_HOLD_FRIENDLY);
        Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, HONOR_HOLD_HONORED);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == FACTION_SHA_TAR)
    {
        Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, SHA_TAR_NEUTRAL);
        Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, SHA_TAR_FRIENDLY);
        Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, SHA_TAR_HONORED);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == FACTION_KEEPERS_OF_TIME)
    {
        Player->ADD_GOSSIP_ITEM(0, "Neutral", GOSSIP_SENDER_MAIN, KEEPERS_OF_TIME_NEUTRAL);
        Player->ADD_GOSSIP_ITEM(0, "Friendly", GOSSIP_SENDER_MAIN, KEEPERS_OF_TIME_FRIENDLY);
        Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, KEEPERS_OF_TIME_HONORED);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == LOWER_CITY_NEUTRAL)
    {
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == LOWER_CITY_FRIENDLY)
    {
        Player->PushFaction(1011, 3001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == LOWER_CITY_HONORED)
    {
        Player->PushFaction(1011, 9001);
        Player->AddItem(30633, 1);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == CENARION_EXPEDITION_NEUTRAL)
    {
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == CENARION_EXPEDITION_FRIENDLY)
    {
        Player->PushFaction(942, 3001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == CENARION_EXPEDITION_HONORED)
    {
        Player->AddItem(30623, 1);
        Player->PushFaction(942, 9001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == THRALLMAR_NEUTRAL)
    {
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == THRALLMAR_FRIENDLY)
    {
        Player->PushFaction(947, 3001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == THRALLMAR_HONORED)
    {
        Player->AddItem(30637, 1);
        Player->PushFaction(947, 9001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == HONOR_HOLD_NEUTRAL)
    {
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());

    }
    else if (action == HONOR_HOLD_FRIENDLY)
    {
        Player->PushFaction(946, 3001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == HONOR_HOLD_HONORED)
    {
        Player->AddItem(30622, 1);
        Player->PushFaction(946, 9001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == SHA_TAR_NEUTRAL)
    {
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == SHA_TAR_FRIENDLY)
    {
        Player->PushFaction(935, 3001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == SHA_TAR_HONORED)
    {
        Player->AddItem(30634, 1);
        Player->PushFaction(935, 9001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == KEEPERS_OF_TIME_NEUTRAL)
    {
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == KEEPERS_OF_TIME_FRIENDLY)
    {
        Player->PushFaction(989, 3001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == KEEPERS_OF_TIME_HONORED)
    {
        Player->AddItem(30635, 1);
        Player->PushFaction(989, 9001);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());

    }
    else if (action == ALDOR_SCRYER_SELECT)
    {
        Player->ADD_GOSSIP_ITEM(0, "Aldor", GOSSIP_SENDER_MAIN, FACTION_ALDOR_SELECT);
        Player->ADD_GOSSIP_ITEM(0, "Scryer", GOSSIP_SENDER_MAIN, FACTION_SCRYER_SELECT);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == FACTION_ALDOR_SELECT)
    {
        Player->ADD_GOSSIP_ITEM(0, "Nothing", GOSSIP_SENDER_MAIN, ALDOR_NOTHING);
        Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, ALDOR_HONORED);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == FACTION_SCRYER_SELECT)
    {
        Player->ADD_GOSSIP_ITEM(0, "Nothing", GOSSIP_SENDER_MAIN, SCRYER_NOTHING);
        Player->ADD_GOSSIP_ITEM(0, "Honored", GOSSIP_SENDER_MAIN, SCRYER_HONORED);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == ALDOR_NOTHING)
    {
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == ALDOR_HONORED)
    {
        Player->PushFaction(932, 5501);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == SCRYER_NOTHING)
    {
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == SCRYER_HONORED)
    {
        Player->PushFaction(934, 5501);
        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }
    else if (action == FLYING_MOUNT_YES)
    {
        //225 riding
        Player->learnSpell(34090);


        if (Player->GetTeam() == 469)
        {

            Player->AddItem(25470, 1);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }
        if (Player->GetTeam() == 67) {

            Player->AddItem(25475, 1);
            Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
            Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
        }
    }
    else if (action == FLYING_MOUNT_NO)
    {

        Player->ADD_GOSSIP_ITEM(0, "Back to main select", 0, 0);
        Player->PlayerTalkClass->SendGossipMenu(1, Creature->GetGUID());
    }

    if (action == 0) {
        GossipHello_custom_transfer(Player, Creature);
    }
    return true;
}

void AddSC_custom_transfer() {

    Script *newscript;
    newscript = new Script;
    newscript->Name = "custom_transfer";
    newscript->pGossipHello = &GossipHello_custom_transfer;
    newscript->pGossipSelect = &GossipSelect_custom_transfer;
    newscript->RegisterSelf();
}