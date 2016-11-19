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

uint16 DPS_WARRIOR_ITEMS[]      = {29969,25784,30005,0,29789,29807,29980,29786,30402,29812,30339,25926,29776,31617,25780,0,0,30227};
uint16 TANK_WARRIOR_ITEMS[]     = {32871,29794,30291,0,30270,30380,25979,32866,30225,30264,30006,31528,28042,31617,29777,30278,25624,25971};
uint16 DPS_PALADIN_ITEMS[]      = {29969,25784,30005,0,29789,29807,29980,29786,30402,29812,30339,25926,29776,31617,25780,30394,0,27949};
uint16 TANK_PALADIN_ITEMS[]     = {32871,28027,30381,0,30296,30330,29774,30334,30400,29959,27734,31528,25619,28042,29777,31448,25624,27949};
uint16 HEAL_PALADIN_ITEMS[]     = {25530,30276,31115,0,31765,25948,25929,30968,25592,25566,25542,31730,30293,25634,30338,25492,31732,23201};
uint16 DPS_HUNTER_ITEMS[]       = {30329,30981,30333,0,30255,30001,29968,30273,29785,30336,25779,31527,29776,31617,29792,31701,0,30397};
uint16 DPS_ROGUE_ITEMS[]        = {30362,30981,29810,0,30328,29772,30272,30401,30384,30003,25779,30339,29776,25628,29792,30277,31703,30227};
uint16 DPS_PRIEST_ITEMS[]       = {30271,31818,29954,0,30928,30516,30268,30284,30382,30521,29793,31523,30340,31615,30971,30522,0,30252};
uint16 HEAL_PRIEST_ITEMS[]      = {30294,30276,25925,0,29978,30923,31485,27728,30382,30521,31526,31730,31615,25634,30338,31700,0,29779};
uint16 ENHANCE_SHAMAN_ITEMS[]   = {30329,30981,30333,0,30255,30001,29968,30273,30399,30336,25779,30339,29776,31617,29792,30277,0,22395};
uint16 ELEMENTAL_SHAMAN_ITEMS[] = {29773,29775,31314,0,30363,30342,25568,30004,25592,31515,29793,31523,30340,31615,30971,30522,0,23199};
uint16 HEAL_SHAMAN_ITEMS[]      = {25575,30276,31533,0,25556,31114,25568,25479,25592,31515,25542,31730,30293,25634,30338,31475,31732,23200};
uint16 DPS_MAGE_ITEMS[]         = {30271,31818,29954,0,30928,30516,30268,30284,30382,30521,29793,31523,30340,31615,30971,30522,0,30252};
uint16 DPS_WARLOCK_ITEMS[]      = {31509,29775,30514,0,30518,30383,30517,31312,30520,30930,29793,31523,30340,31615,30971,30522,0,30252};
uint16 FERAL_DRUID_ITEMS[]      = {30362,30981,29810,0,30328,29772,30272,30401,30384,30003,25779,30339,29776,25628,29792,25622,0,28064};
uint16 BALANCE_DRUID_ITEMS[]    = {30946,29775,30262,0,29967,25583,30290,30335,30520,31430,29793,31523,30340,31615,30971,30522,0,23197};
uint16 HEAL_DRUID_ITEMS[]       = {30515,30276,31538,0,30945,31513,30290,27727,29955,25591,31526,31730,31615,25634,30338,31700,0,22398};
uint16 TANK_DRUID_ITEMS[]       = {30269,29794,29999,0,32869,30285,30941,30266,30332,30341,30006,31528,28042,31617,29777,25622,0,28064};


void GiveGearAndLevels(Player* Player, uint16 gearList[])
{
    Player->PushSeventy();
    Player->EquipForPushSeventy(gearList);
    Player->FinishPush();
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
    if (Player->isGameMaster())
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
    }

    Player->PlayerTalkClass->SendGossipMenu(30000, Creature->GetGUID());
    return true;
}

bool GossipSelect_custom_instant_70_uncommon(Player* Player, Creature* Creature, uint32 /*sender*/, uint32 action)
{
    //Prevent anyone spamming the database:
    if (action == ALREADY_USED)
        return true;

    if (!Player->isGameMaster())
    {
        if (action > (GOSSIP_ACTION_INFO_DEF + 12)) //HAS SELECTED A CLASS/SPEC - WILL BE TELEPORTED
        {
            uint32 account_id = Player->GetSession()->GetAccountId();
            const char * ip_address = Player->GetSession()->GetRemoteAddress().c_str();

            QueryResultAutoPtr result = AccountsDatabase.PQuery("SELECT 1 FROM account_70_promo WHERE account_id = '%u' OR registration_ip = '%s'", account_id, ip_address);

            //Does this account ID -- OR IP ADDRESS -- exist in the table?
            if (!result)
            {
                if (!AccountsDatabase.PExecute("INSERT INTO account_70_promo(account_id, registration_ip, already_used) VALUES ('%u', '%s', '%s')", account_id, ip_address, "YES"))
                {
                    //Failure
                    action = ALREADY_USED;
                }
            }
            else
            {
                //Already exists
                action = ALREADY_USED;
            }
        }
    }


    
    switch (action) 
    {
        case ALREADY_USED:
        {
            // Player->ADD_GOSSIP_ITEM(0, "Sorry, but you have already used this feature.", GOSSIP_SENDER_MAIN, ALREADY_USED);
            Player->PlayerTalkClass->SendGossipMenu(30024, Creature->GetGUID());
            return true;
        }
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
                    Player->ADD_GOSSIP_ITEM(0, "DPS - Enhance", GOSSIP_SENDER_MAIN, ENHANCE_SHAMAN);
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
            Player->AddItem(28056, 200);
            Player->AddItem(30364, 1);
            Player->AddItem(31423, 1);
            Player->AddItem(31701, 1);

            GiveGearAndLevels(Player, DPS_WARRIOR_ITEMS);
            break;
        }
        case TANK_WARRIOR:
        {
            Player->AddItem(28056, 200);
            GiveGearAndLevels(Player, TANK_WARRIOR_ITEMS);
            break;
        }
        case DPS_PALADIN:
        {
            GiveGearAndLevels(Player, DPS_PALADIN_ITEMS);
            break;
        }
        case TANK_PALADIN:
        {
            GiveGearAndLevels(Player, TANK_PALADIN_ITEMS);
            break;
        }
        case HEAL_PALADIN:
        {
            GiveGearAndLevels(Player, HEAL_PALADIN_ITEMS);
            break;
        }
        case DPS_HUNTER:
        {
            GiveGearAndLevels(Player, DPS_HUNTER_ITEMS);
            break;
        }
        case DPS_ROGUE:
        {
            GiveGearAndLevels(Player, DPS_ROGUE_ITEMS);
            break;
        }
        case DPS_PRIEST:
        {
            GiveGearAndLevels(Player, DPS_PRIEST_ITEMS);
            break;
        }
        case HEAL_PRIEST:
        {
            GiveGearAndLevels(Player, HEAL_PRIEST_ITEMS);
            break;
        }
        case ENHANCE_SHAMAN:
        {
            // SHAMAN - ENHANCEMENT
            Player->AddItem(14487, 1);
            GiveGearAndLevels(Player, ENHANCE_SHAMAN_ITEMS);

            break;
        }
        case ELEMENTAL_SHAMAN:
        {
            GiveGearAndLevels(Player, ELEMENTAL_SHAMAN_ITEMS);
            break;
        }
        case HEAL_SHAMAN:
        {
            GiveGearAndLevels(Player, HEAL_SHAMAN_ITEMS);
            break;
        }
        case DPS_MAGE:
        {
            GiveGearAndLevels(Player, DPS_MAGE_ITEMS);
            break;
        }
        case DPS_WARLOCK:
        {
            GiveGearAndLevels(Player, DPS_WARLOCK_ITEMS);
            break;
        }
        case CAT_DRUID:
        {
            GiveGearAndLevels(Player, FERAL_DRUID_ITEMS);
            break;
        }
        case BALANCE_DRUID:
        {
            GiveGearAndLevels(Player, BALANCE_DRUID_ITEMS);
            break;
        }
        case HEAL_DRUID:
        {
            GiveGearAndLevels(Player, HEAL_DRUID_ITEMS);
            break;
        }
        case TANK_DRUID:
        {
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