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

bool GossipHello_custom_gossip_codebox(Player *Player, Creature *Creature) {
    //Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
    Player->ADD_GOSSIP_ITEM(0, "I want to get set to level 60!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
    Player->PlayerTalkClass->SendGossipMenu(30000, Creature->GetGUID());
    return true;
}

bool GossipSelect_custom_gossip_codebox(Player* Player, Creature* Creature, uint32 /*sender*/, uint32 action)
{
    uint32 professions = 0;
    switch (action) {
        case GOSSIP_ACTION_INFO_DEF + 2:
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            Player->PlayerTalkClass->SendGossipMenu(30001, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 3:
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            Player->PlayerTalkClass->SendGossipMenu(30002, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 4:
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
            Player->PlayerTalkClass->SendGossipMenu(30003, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 5:
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
            Player->PlayerTalkClass->SendGossipMenu(30004, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 6:
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            Player->PlayerTalkClass->SendGossipMenu(30005, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 7:
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
            Player->PlayerTalkClass->SendGossipMenu(30006, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 8:
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);
            Player->PlayerTalkClass->SendGossipMenu(30007, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 9:
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
            Player->PlayerTalkClass->SendGossipMenu(30008, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 10:
        {
            switch(Player->GetValidForPush())
            {
                case 0: // zu hohes level aber noch einen char frei fuer push
                {
                    Player->ADD_GOSSIP_ITEM(0, "Close", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 111);
                    Player->PlayerTalkClass->SendGossipMenu(30014, Creature->GetGUID());
                    return true;
                }
                case 1: // zu hohes level und sowieso bereits 2 ueber 60
                {
                    Player->ADD_GOSSIP_ITEM(0, "Close", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 111);
                    Player->PlayerTalkClass->SendGossipMenu(30015, Creature->GetGUID());
                    return true;
                }
                case 2: // bereits zu viele auf zu hohem level
                {
                    Player->ADD_GOSSIP_ITEM(0, "Close", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 111);
                    Player->PlayerTalkClass->SendGossipMenu(30010, Creature->GetGUID());
                    return true;
                }
                case 3: // alles okay, gib feuer
                {
                    Player->ADD_GOSSIP_ITEM(0, "Set me to level 70", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                    Player->PlayerTalkClass->SendGossipMenu(30009, Creature->GetGUID());
                    return true;
                }
                case 4: // Second Account
                {
                    Player->ADD_GOSSIP_ITEM(0, "Close", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 111);
                    Player->PlayerTalkClass->SendGossipMenu(30020, Creature->GetGUID());
                    return true;
                }
                case 5: // ein char über 60, aber noch kein 2.
                {
                    Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 112);
                    Player->PlayerTalkClass->SendGossipMenu(30021, Creature->GetGUID());
                    return true;
                }
                default:
                    return false;
            }
        }
        case GOSSIP_ACTION_INFO_DEF + 11:
            Player->Push();
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
            Player->PlayerTalkClass->SendGossipMenu(30011, Creature->GetGUID());
            break;
       case GOSSIP_ACTION_INFO_DEF + 112:
            Player->PushSixty();
            Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2112);
            Player->PlayerTalkClass->SendGossipMenu(30011, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 111:
            Player->PlayerTalkClass->CloseGossip();
            return false;
        case GOSSIP_ACTION_INFO_DEF + 12:
            switch (Player->getClass()) {
                case CLASS_WARRIOR:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
                    Player->ADD_GOSSIP_ITEM(0, "Tank", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
                    break;
                case CLASS_PALADIN:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 15);
                    // do we realy need a shokadin?
                    // Player->ADD_GOSSIP_ITEM(0, "DD - Shocka", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+151);
                    Player->ADD_GOSSIP_ITEM(0, "Tank", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 16);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 17);
                    break;
                case CLASS_HUNTER:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 18);
                    break;
                case CLASS_ROGUE:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 19);
                    break;
                case CLASS_PRIEST:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 20);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 21);
                    break;
                case CLASS_SHAMAN:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer - Enhancer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 22);
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer - Ele", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 23);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 24);
                    break;
                case CLASS_MAGE:

                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 25);
                    break;
                case CLASS_WARLOCK:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 26);
                    break;
                case CLASS_DRUID:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer - Cat", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 27);
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer - Owl", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 28);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 29);
                    Player->ADD_GOSSIP_ITEM(0, "Tank", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 30);
                    break;
            }
            Player->PlayerTalkClass->SendGossipMenu(30012, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 13:
        {
            // WARRIOR - DD -fertig
            uint16 items[] = {29969,25784,30005,0,29789,29807,29980,29786,30402,29812,30339,25926,29776,31617,25780,0,0,30227};
            Player->EquipForPush(items);
            if (!Player->HasItemCount(28056, 200, true))
                Player->AddItem(28056, 200);
            Player->AddItem(30364, 1);
            Player->AddItem(31423, 1);
            Player->AddItem(31701, 1);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 14:
        {
            // WARRIOR - TANK -ü
            uint16 items[] = {32871,29794,30291,0,30270,30380,25979,32866,30225,30264,30006,31528,28042,31617,29777,30278,25624,25971};
            Player->EquipForPush(items);
            if (!Player->HasItemCount(28056, 200, true))
                Player->AddItem(28056, 200);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 15:
        {
            // PALADIN - DD - fertig
            uint16 items[] = {29969,25784,30005,0,29789,29807,29980,29786,30402,29812,30339,25926,29776,31617,25780,30394,0,27949};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 151:
        {
            // PALADIN - DD - Shockadin
            uint16 items[] = {29969, 25784, 30005, 0, 29789, 29807, 29980, 29786, 30402, 29812, 30339, 25926, 29776, 31617, 25780, 30394, 0, 30227};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 16:
        {
            // PALADIN - TANK -ü
            uint16 items[] = {32871,28027,30381,0,30296,30330,29774,30334,30400,29959,27734,31528,25619,28042,29777,31448,25624,27949};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 17:
        {
            // PALADIN - Healer -ü
            uint16 items[] = {25530,30276,31115,0,31765,25948,25929,30968,25592,25566,25542,31730,30293,25634,30338,25492,31732,23201};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 18:
        {
            // HUNTER - fertig
            uint16 items[] = {30329,30981,30333,0,30255,30001,29968,30273,29785,30336,25779,31527,29776,31617,29792,31701,0,30397};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 19:
        {
            // ROGUE - fertig
            uint16 items[] = {30362,30981,29810,0,30328,29772,30272,30401,30384,30003,25779,30339,29776,25628,29792,30277,31703,30227};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 20:
        {
            // PRIEST - DD - fertig
            uint16 items[] = {30271, 31818, 29954, 0, 30928, 30516, 30268, 30284, 30382, 30521, 29793, 31523, 30340, 31615, 30971, 30522, 0, 30252};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 21:
        {
            // PRIEST - Healer -ü
            uint16 items[] = {30294,30276,25925,0,29978,30923,31485,27728,30382,30521,31526,31730,31615,25634,30338,31700,0,29779};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 22:
        {
            // SHAMANE - VERSTÄRKER - fertig
            uint16 items[] = {30329,30981,30333,0,30255,30001,29968,30273,30399,30336,25779,30339,29776,31617,29792,30277,0,22395};
            Player->EquipForPush(items);
            Player->AddItem(14487, 1);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 23:
        {
            // SHAMANE - ELEMENTAR -fertig
            uint16 items[] = {29773,29775,31314,0,30363,30342,25568,30004,25592,31515,29793,31523,30340,31615,30971,30522,0,23199};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 24:
        {
            // SHAMANE - Healer -ü
            uint16 items[] = {25575,30276,31533,0,25556,31114,25568,25479,25592,31515,25542,31730,30293,25634,30338,31475,31732,23200};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 25:
        {
            // MAGE -fertig
            uint16 items[] = {30271, 31818, 29954,0, 30928, 30516, 30268, 30284, 30382, 30521, 29793, 31523, 30340, 31615, 30971, 30522, 0, 30252};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 26:
        {
            // WARLOCK -fertig
            uint16 items[] = {31509,29775,30514,0,30518,30383,30517,31312,30520,30930,29793,31523,30340,31615,30971,30522,0,30252};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 27:
        {
            // DRUID - KATZE -fertig
            uint16 items[] = {30362,30981,29810,0,30328,29772,30272,30401,30384,30003,25779,30339,29776,25628,29792,25622,0,28064};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 28:
        {
            // DRUID - EULE -ü
            uint16 items[] = {30946,29775,30262,0,29967,25583,30290,30335,30520,31430,29793,31523,30340,31615,30971,30522,0,23197};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 29:
        {
            // DRUID - BAUM -ü
            uint16 items[] = {30515,30276,31538,0,30945,31513,30290,27727,29955,25591,31526,31730,31615,25634,30338,31700,0,22398};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 30:
        {
            // DRUID - BÄR -ü
            uint16 items[] = {30269,29794,29999,0,32869,30285,30941,30266,30332,30341,30006,31528,28042,31617,29777,25622,0,28064};
            Player->EquipForPush(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 31:
        {
            professions = 0;
            QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT guid FROM characters WHERE account in (SELECT account FROM characters WHERE guid = '%u')", GUID_LOPART(Player->GetGUID()));
            Field *fields = NULL;
            uint32 maxchars = 0;

            do
            {
                fields = result->Fetch();
                QueryResultAutoPtr level = RealmDataDatabase.PQuery("SELECT level FROM characters WHERE guid = %u", fields->GetUInt32());
                if (level->Fetch()->GetUInt32() >= 69)
                    maxchars++;
            } while (result->NextRow());
            if (maxchars >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
                break;
            }
                
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Alchemy", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 401);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Mining", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 402);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Engeneering", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 403);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Jewelcrafting", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 404);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Herbalism", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 405);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Skinning", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 406);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Leatherworking", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 407);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Blacksmithing", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 408);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Tailoring", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 409);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Enchanting", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 410);
                Player->ADD_GOSSIP_ITEM(0, "I dont want any profession", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30016, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 401: //Alchi
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(28596);
                Player->SetSkill(171,375,375);
                Player->AddItem(9149, 1);
                Player->AddItem(8925, 20);
                Player->AddItem(18256, 20);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 402: //Bergbau
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(29354);
                Player->SetSkill(186,375,375);
                Player->AddItem(2901, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 403: //Ingi
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(30350);
                Player->SetSkill(202,375,375);
                Player->AddItem(6219, 1);
                Player->AddItem(10498, 1);
                professions++;
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 404: //Juwe
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(28897);
                Player->SetSkill(755,375,375);
                Player->learnSpell(31252);
                Player->AddItem(20815, 1);
                Player->AddItem(20824, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 405: //Kräuter
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(28695);
                Player->SetSkill(182,375,375);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 406: //Kürschner
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(32678);
                Player->SetSkill(393,375,375);
                Player->AddItem(7005, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 407: //Leder
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(32549);
                Player->SetSkill(165,375,375);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 408: //Schmied
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(29844);
                Player->SetSkill(164,375,375);
                Player->AddItem(5956, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 409: //Schneider
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(26790);
                Player->SetSkill(197,375,375);
                Player->AddItem(14341, 20);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 410: //VZ
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 40);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(28029);
                Player->SetSkill(333,375,375);
                Player->AddItem(22462, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 2112:
            switch (Player->getClass()) {
                case CLASS_WARRIOR:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 113);
                    Player->ADD_GOSSIP_ITEM(0, "Tank", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 114);
                    break;
                case CLASS_PALADIN:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 115);
                    // do we realy need a shokadin?
                    // Player->ADD_GOSSIP_ITEM(0, "DD - Shocka", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+151);
                    Player->ADD_GOSSIP_ITEM(0, "Tank", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 116);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 117);
                    break;
                case CLASS_HUNTER:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 118);
                    break;
                case CLASS_ROGUE:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 119);
                    break;
                case CLASS_PRIEST:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 120);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 121);
                    break;
                case CLASS_SHAMAN:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer - Enhancer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 122);
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer - Ele", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 123);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 124);
                    break;
                case CLASS_MAGE:

                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 125);
                    break;
                case CLASS_WARLOCK:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 126);
                    break;
                case CLASS_DRUID:
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer - Cat", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 127);
                    Player->ADD_GOSSIP_ITEM(0, "Damage dealer - Owl", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 128);
                    Player->ADD_GOSSIP_ITEM(0, "Healer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 129);
                    Player->ADD_GOSSIP_ITEM(0, "Tank", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 130);
                    break;
            }
            Player->PlayerTalkClass->SendGossipMenu(30012, Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 113:
        {
            // WARRIOR - DD -fertig
            //               Helm,   Kette, Schulter, 0, Brust, Gurt,  Beine, F??e,  Arme,  H?nde, Ring,  Ring2, Schmuck, Schmuck, Umhang, Waffe, 2HWaffe, Fernk
            uint16 items[] = {16731, 22340, 16733,    0, 16730, 16736, 16732, 16734, 16735, 16737, 18701, 13098, 7734,    22321,   13397,  22404, 14487,   18680};
            Player->EquipForPushSixty(items);
            if (!Player->HasItemCount(28053, 200, true))
                Player->AddItem(28053, 200);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 114:
        {
            // WARRIOR - TANK -?
            uint16 items[] = {12620,13177,22001,0,18503,21503,22000,20710,21996,14525,22680, 19912,21784,21567,19888,19968,12602,19993};
            Player->EquipForPushSixty(items);
            if (!Player->HasItemCount(28053, 200, true))
                Player->AddItem(28053, 200);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 115:
        {
            // PALADIN - DD - fertig
            uint16 items[] = {16727, 22340, 16729, 0, 16726, 16723, 16728, 16725, 16722, 16724, 18701, 13098, 7734, 22321, 13397, 12583, 0, 22401};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1151:
        {
            // PALADIN - DD - Shockadin
            uint16 items[] = {29969, 25784, 30005, 0, 29789, 29807, 29980, 29786, 30402, 29812, 30339, 25926, 29776, 31617, 25780, 30394, 0, 30227};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 116:
        {
            // PALADIN - TANK -?
            uint16 items[] = {23276,21792,18384,0,15413,14620,14623,14621,21996, 23274,22680, 11669,12930,13515,19888,18396,22336,22401};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 117:
        {
            // PALADIN - Healer -?
            uint16 items[] = {12633,18723,14548,0,15047,18702,20266,20711,13969,18527,13178, 16058,18472,12930,18389,22380,22336,23201};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 118:
        {
            // HUNTER - fertig
            uint16 items[] = {16677, 22340, 16679, 0, 16674, 16680, 16678, 16675, 16681, 16676, 18701, 13098, 7734, 18537, 13397, 13368, 13368, 18680};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 119:
        {
            // ROGUE - fertig
            uint16 items[] = {16707, 22340, 16708, 0, 16721, 16713, 16709, 16711, 16710, 16712, 18701, 13098, 7734, 22321, 13397, 22404, 13368, 28972};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 120:
        {
            // PRIEST - DD - fertig
            uint16 items[] = {16693, 22403, 16695, 0, 16690, 16696, 16694, 16691, 16697, 16692, 22433, 13345, 7734, 12930, 12968, 22335, 0, 13938};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 121:
        {
            // PRIEST - Healer -?
            uint16 items[] = {13102,18723,22405,0,13346,18327,18386,12556,18497,12554,22334, 18395,18469,12930,18389,22380,18523,21801};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 122:
        {
            // SHAMANE - VERST?RKER - fertig
            uint16 items[] = {16667, 22340, 16669, 0, 16666, 16673, 16668, 16670, 16671, 16672, 18701, 13098, 7734, 22321, 13397, 22404, 0, 22395};
            Player->EquipForPushSixty(items);
            Player->AddItem(14487, 1);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 123:
        {
            // SHAMANE - ELEMENTAR -fertig
            uint16 items[] = {16667, 22403, 16669, 0, 16666, 16673, 16668, 16670, 16671, 16672, 22433, 13345, 7734, 12930, 12968, 22335, 0, 22395};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 124:
        {
            // SHAMANE - Healer -?
            uint16 items[] = {18807,18723,14548,0,15047,18721,14522,18318,13969, 18527,13178, 22334,12930,18471,18389,22380,22336,23200};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 125:
        {
            // MAGE -fertig
            uint16 items[] = {16686, 22403, 16689, 0, 16688, 16685, 16687, 16682, 16683, 16684, 22433, 13345, 7734, 12930, 12968, 22335, 0, 13938};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 126:
        {
            // WARLOCK -fertig
            uint16 items[] = {16698, 22403, 16701, 0, 16700, 16702, 16699, 16704, 16703, 16705, 22433, 13345, 7734, 12930, 12968, 22335, 0, 13938};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 127:
        {
            // DRUID - KATZE -fertig
            uint16 items[] = {16720, 22340, 16718, 0, 16706, 16716, 16719, 16715, 16714, 16717, 18701, 13098, 7734, 22321, 13397, 13372, 0, 22397};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 128:
        {
            // DRUID - EULE -?
            uint16 items[] = {16720, 22403, 16718, 0, 16706, 16716, 16719, 16715, 16714, 16717, 22433, 13345, 7734, 12930, 12968, 22335, 0, 22398};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 129:
        {
            // DRUID - BAUM -?
            uint16 items[] = {17740,18723,15061,0,22272,18391,18682,22275,13208,12547,22334, 18395,18470,12930,18389,22380,18523,22398};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 130:
        {
            // DRUID - B?R -?
            uint16 items[] = {14539,13091,15058,0,15056,20261,15057,19052,18700,18377,22680, 11669,21784,11810,19888,20556,0,23198};
            Player->EquipForPushSixty(items);
            Player->ADD_GOSSIP_ITEM(0, "Take me to class trainer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
            Player->PlayerTalkClass->SendGossipMenu(30013, Creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 131:
        {
            professions = 0;   
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Alchemy", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1401);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Mining", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1402);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Engeneering", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1403);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Jewelcrafting", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1404);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Herbalism", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1405);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Skinning", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1406);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Leatherworking", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1407);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Blacksmithing", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1408);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Tailoring", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1409);
                Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Enchanting", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1410);
                Player->ADD_GOSSIP_ITEM(0, "I dont want any profession", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30016, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1401: //Alchi
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(11611);
                Player->SetSkill(171,300,300);
                Player->AddItem(9149, 1);
                Player->AddItem(8925, 20);
                Player->AddItem(18256, 20);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1402: //Bergbau
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(10248);
                Player->SetSkill(186,300,300);
                Player->AddItem(2901, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1403: //Ingi
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(12656);
                Player->SetSkill(202,300,300);
                Player->AddItem(6219, 1);
                Player->AddItem(10498, 1);
                professions++;
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1404: //Juwe
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(28895);
                Player->SetSkill(755,300,300);
                Player->learnSpell(31252);
                Player->AddItem(20815, 1);
                Player->AddItem(20824, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1405: //Kr?uter
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(11993);
                Player->SetSkill(182,300,300);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1406: //K?rschner
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(10768);
                Player->SetSkill(393,300,300);
                Player->AddItem(7005, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1407: //Leder
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(10662);
                Player->SetSkill(165,300,300);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1408: //Schmied
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(9785);
                Player->SetSkill(164,300,300);
                Player->AddItem(5956, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1409: //Schneider
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(12180);
                Player->SetSkill(197,300,300);
                Player->AddItem(14341, 20);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 1410: //VZ
        {
            professions = 0;
            if (Player->HasSkill(SKILL_ALCHEMY))
                professions++;
            if (Player->HasSkill(SKILL_BLACKSMITHING))
                professions++;
            if (Player->HasSkill(SKILL_ENCHANTING))
                professions++;
            if (Player->HasSkill(SKILL_ENGINERING))
                professions++;
            if (Player->HasSkill(SKILL_HERBALISM))
                professions++;
            if (Player->HasSkill(SKILL_JEWELCRAFTING))
                professions++;
            if (Player->HasSkill(SKILL_LEATHERWORKING))
                professions++;
            if (Player->HasSkill(SKILL_MINING))
                professions++;
            if (Player->HasSkill(SKILL_SKINNING))
                professions++;
            if (Player->HasSkill(SKILL_TAILORING))
                professions++;
            if (professions >= 2)
            {
                Player->ADD_GOSSIP_ITEM(0, "Take me to my class trainer!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30017, Creature->GetGUID());
            }
            else
            {
                Player->learnSpell(13920);
                Player->SetSkill(333,300,300);
                Player->AddItem(22461, 1);
                Player->ADD_GOSSIP_ITEM(0, "continue", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 140);
                Player->PlayerTalkClass->SendGossipMenu(30019, Creature->GetGUID());
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 40:
        {
            Player->FinishPush();
            return true;
        }
        case GOSSIP_ACTION_INFO_DEF + 140:
        {
            Player->FinishPushSixty();
            return true;
        }
        default:
            return false;
    }
    return true;
}

void AddSC_custom_gossip_codebox() {

    Script *newscript;
    newscript = new Script;
    newscript->Name = "custom_gossip_codebox";
    newscript->pGossipHello = &GossipHello_custom_gossip_codebox;
    newscript->pGossipSelect = &GossipSelect_custom_gossip_codebox;
    newscript->RegisterSelf();
}
