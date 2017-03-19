/*
 * Copyright (C) 2005-2008 MaNGOS <http://www.mangosproject.org/>
 *
 * Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "Common.h"
#include "Language.h"
#include "Database/DatabaseEnv.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "Log.h"
#include "World.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "UpdateMask.h"
#include "Chat.h"
#include "MapManager.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "TicketMgr.h"

bool ChatHandler::load_command_table = true;

ChatCommand * ChatHandler::getCommandTable()
{
    static ChatCommand accountSetCommandTable[] =
    {
        { "addon",          PERM_ADM,       true,   &ChatHandler::HandleAccountSetAddonCommand,       "", NULL },
        { "permissions",    PERM_ADM,       true,   &ChatHandler::HandleAccountSetPermissionsCommand, "", NULL },
        { "password",       PERM_ADM,       true,   &ChatHandler::HandleAccountSetPasswordCommand,    "", NULL },
        { "multiacc",       PERM_GMT,       true,   &ChatHandler::HandleAccountSetMultiaccCommand,    "", NULL },
        { NULL,             0,              false,  NULL,                                             "", NULL }
    };

    static ChatCommand accountAnnounceCommandTable[] =
    {
        { "battleground",   PERM_PLAYER,        false, &ChatHandler::HandleAccountBattleGroundAnnCommand,   "", NULL },
        { "bg",             PERM_PLAYER,        false, &ChatHandler::HandleAccountBattleGroundAnnCommand,   "", NULL },
        { "broadcast",      PERM_PLAYER,        false, &ChatHandler::HandleAccountAnnounceBroadcastCommand, "", NULL },
        { "guild",          PERM_PLAYER,        false, &ChatHandler::HandleAccountGuildAnnToggleCommand,    "", NULL },
        { NULL,             0,                  false,  NULL,                                               "", NULL }
    };

    static ChatCommand accountCommandTable[] =
    {
        { "announce",       PERM_PLAYER,    false,  NULL,                                           "", accountAnnounceCommandTable },
        { "create",         PERM_CONSOLE,   true,   &ChatHandler::HandleAccountCreateCommand,       "", NULL },
        { "bgann",          PERM_PLAYER,    false,  &ChatHandler::HandleAccountBattleGroundAnnCommand, "", NULL },
        { "delete",         PERM_CONSOLE,   true,   &ChatHandler::HandleAccountDeleteCommand,       "", NULL },
        { "gann",           PERM_PLAYER,    false,  &ChatHandler::HandleAccountGuildAnnToggleCommand, "", NULL },
        { "bones",          PERM_PLAYER,    false,  &ChatHandler::HandleAccountBonesHideCommand,    "", NULL },
        { "log",            PERM_ADM,       true,   &ChatHandler::HandleAccountSpecialLogCommand,   "", NULL },
        { "onlinelist",     PERM_CONSOLE,   true,   &ChatHandler::HandleAccountOnlineListCommand,   "", NULL },
        { "set",            PERM_ADM,       true,   NULL,                                           "", accountSetCommandTable },
        { "xp",             PERM_PLAYER,    false,  &ChatHandler::HandleAccountXPToggleCommand,     "", NULL },
        { "whisp",          PERM_ADM,       true,   &ChatHandler::HandleAccountWhispLogCommand,     "", NULL },
        { "delmultiacc",    PERM_GMT,       true,   &ChatHandler::HandleAccountDelMultiaccCommand,  "", NULL },
        { "mentor",         PERM_PLAYER,    false,  &ChatHandler::HandleMentorCommand,              "", NULL },
        { "",               PERM_PLAYER,    false,  &ChatHandler::HandleAccountCommand,             "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand serverSetCommandTable[] =
    {
        { "difftime",       PERM_CONSOLE,   true,   &ChatHandler::HandleServerSetDiffTimeCommand,   "", NULL },
        { "loglevel",       PERM_CONSOLE,   true,   &ChatHandler::HandleServerSetLogLevelCommand,   "", NULL },
        { "motd",           PERM_ADM,       true,   &ChatHandler::HandleServerSetMotdCommand,       "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand sendCommandTable[] =
    {
        { "items",          PERM_ADM,       true,   &ChatHandler::HandleSendItemsCommand,           "", NULL },
        { "mail",           PERM_GMT,       true,   &ChatHandler::HandleSendMailCommand,            "", NULL },
        { "message",        PERM_ADM,       true,   &ChatHandler::HandleSendMessageCommand,         "", NULL },
        { "money",          PERM_ADM,       true,   &ChatHandler::HandleSendMoneyCommand,           "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand serverIdleRestartCommandTable[] =
    {
        { "cancel",         PERM_ADM,       true,   &ChatHandler::HandleServerShutDownCancelCommand,"", NULL },
        { ""   ,            PERM_ADM,       true,   &ChatHandler::HandleServerIdleRestartCommand,   "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand serverIdleShutdownCommandTable[] =
    {
        { "cancel",         PERM_ADM,       true,   &ChatHandler::HandleServerShutDownCancelCommand,"", NULL },
        { ""   ,            PERM_ADM,       true,   &ChatHandler::HandleServerIdleShutDownCommand,  "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand serverRestartCommandTable[] =
    {
        { "cancel",         PERM_ADM,       true,   &ChatHandler::HandleServerShutDownCancelCommand,"", NULL },
        { ""   ,            PERM_ADM,       true,   &ChatHandler::HandleServerRestartCommand,       "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand serverShutdownCommandTable[] =
    {
        { "cancel",         PERM_ADM,       true,   &ChatHandler::HandleServerShutDownCancelCommand,"", NULL },
        { ""   ,            PERM_ADM,       true,   &ChatHandler::HandleServerShutDownCommand,      "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand serverCommandTable[] =
    {
        { "corpses",        PERM_HIGH_GMT,  true,   &ChatHandler::HandleServerCorpsesCommand,       "", NULL },
        { "exit",           PERM_CONSOLE,   true,   &ChatHandler::HandleServerExitCommand,          "", NULL },
        { "idlerestart",    PERM_ADM,       true,   NULL,                                           "", serverIdleRestartCommandTable },
        { "idleshutdown",   PERM_ADM,       true,   NULL,                                           "", serverShutdownCommandTable },
        { "info",           PERM_PLAYER,    true,   &ChatHandler::HandleServerInfoCommand,          "", NULL },
        { "events",         PERM_PLAYER,    true,   &ChatHandler::HandleServerEventsCommand,        "", NULL },
        { "motd",           PERM_PLAYER,    true,   &ChatHandler::HandleServerMotdCommand,          "", NULL },
        { "mute",           PERM_ADM,       true,   &ChatHandler::HandleServerMuteCommand,          "", NULL },
        { "pvp",            PERM_PLAYER,    false,  &ChatHandler::HandleServerPVPCommand,           "", NULL },
        { "restart",        PERM_ADM,       true,   NULL,                                           "", serverRestartCommandTable },
        { "rollshutdown",   PERM_ADM,       true,   &ChatHandler::HandleServerRollShutDownCommand,  "", NULL},
        { "set",            PERM_ADM,       true,   NULL,                                           "", serverSetCommandTable },
        { "shutdown",       PERM_ADM,       true,   NULL,                                           "", serverShutdownCommandTable },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand mmapCommandTable[] =
    {
        { "path",           PERM_GMT,       false, &ChatHandler::HandleMmapPathCommand,            "", NULL },
        { "loc",            PERM_GMT,       false, &ChatHandler::HandleMmapLocCommand,             "", NULL },
        { "loadedtiles",    PERM_GMT,       false, &ChatHandler::HandleMmapLoadedTilesCommand,     "", NULL },
        { "stats",          PERM_GMT,       false, &ChatHandler::HandleMmapStatsCommand,           "", NULL },
        { "testarea",       PERM_GMT,       false, &ChatHandler::HandleMmapTestArea,               "", NULL },
        { "offmesh",        PERM_GMT,       false, &ChatHandler::HandleMmapOffsetCreateCommand,    "", NULL },
        { "",               PERM_ADM,       false, &ChatHandler::HandleMmap,                       "", NULL },
        { NULL,             0,              false, NULL,                                           "", NULL }
    };

    static ChatCommand modifyCommandTable[] =
    {
        { "arena",          PERM_ADM,       false,  &ChatHandler::HandleModifyArenaCommand,         "", NULL },
        { "aspeed",         PERM_GMT,       false,  &ChatHandler::HandleModifyASpeedCommand,        "", NULL },
        { "bit",            PERM_GMT,       false,  &ChatHandler::HandleModifyBitCommand,           "", NULL },
        { "bwalk",          PERM_GMT,       false,  &ChatHandler::HandleModifyBWalkCommand,         "", NULL },
        { "drunk",          PERM_GMT,       false,  &ChatHandler::HandleModifyDrunkCommand,         "", NULL },
        { "energy",         PERM_GMT,       false,  &ChatHandler::HandleModifyEnergyCommand,        "", NULL },
        { "faction",        PERM_GMT,       false,  &ChatHandler::HandleModifyFactionCommand,       "", NULL },
        { "fly",            PERM_GMT,       false,  &ChatHandler::HandleModifyFlyCommand,           "", NULL },
        { "gender",         PERM_ADM,       false,  &ChatHandler::HandleModifyGenderCommand,        "", NULL },
        { "honor",          PERM_ADM,       false,  &ChatHandler::HandleModifyHonorCommand,         "", NULL },
        { "hp",             PERM_GMT,       false,  &ChatHandler::HandleModifyHPCommand,            "", NULL },
        { "mana",           PERM_GMT,       false,  &ChatHandler::HandleModifyManaCommand,          "", NULL },
        { "money",          PERM_ADM,       false,  &ChatHandler::HandleModifyMoneyCommand,         "", NULL },
        { "morph",          PERM_GMT,       false,  &ChatHandler::HandleModifyMorphCommand,         "", NULL },
        { "mount",          PERM_GMT,       false,  &ChatHandler::HandleModifyMountCommand,         "", NULL },
        { "rage",           PERM_GMT,       false,  &ChatHandler::HandleModifyRageCommand,          "", NULL },
        { "rep",            PERM_ADM,       false,  &ChatHandler::HandleModifyRepCommand,           "", NULL },
        { "scale",          PERM_GMT,       false,  &ChatHandler::HandleModifyScaleCommand,         "", NULL },
        { "speed",          PERM_GMT,       false,  &ChatHandler::HandleModifySpeedCommand,         "", NULL },
        { "spell",          PERM_GMT,       false,  &ChatHandler::HandleModifySpellCommand,         "", NULL },
        { "standstate",     PERM_GMT,       false,  &ChatHandler::HandleModifyStandStateCommand,    "", NULL },
        { "swim",           PERM_GMT,       false,  &ChatHandler::HandleModifySwimCommand,          "", NULL },
        { "titles",         PERM_ADM,       false,  &ChatHandler::HandleModifyKnownTitlesCommand,   "", NULL },
        { "tp",             PERM_ADM,       false,  &ChatHandler::HandleModifyTalentCommand,        "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand wpCommandTable[] =
    {
        { "add",            PERM_DEVELOPER, false, &ChatHandler::HandleWpAddCommand,                "", NULL },
        { "event",          PERM_DEVELOPER, false, &ChatHandler::HandleWpEventCommand,              "", NULL },
        { "load",           PERM_DEVELOPER, false, &ChatHandler::HandleWpLoadPathCommand,           "", NULL },
        { "modify",         PERM_DEVELOPER, false, &ChatHandler::HandleWpModifyCommand,             "", NULL },
        { "reloadpath",     PERM_ADM,       false, &ChatHandler::HandleWpReloadPath,                "", NULL },
        { "show",           PERM_DEVELOPER, false, &ChatHandler::HandleWpShowCommand,               "", NULL },
        { "tofile",         PERM_ADM,       false, &ChatHandler::HandleWPToFileCommand,             "", NULL },
        { "unload",         PERM_DEVELOPER, false, &ChatHandler::HandleWpUnLoadPathCommand,         "", NULL },
        { NULL,             0,              false, NULL,                                            "", NULL }
    };


    static ChatCommand banCommandTable[] =
    {
        { "account",        PERM_GMT,       true,  &ChatHandler::HandleBanAccountCommand,           "", NULL },
        { "character",      PERM_GMT,       true,  &ChatHandler::HandleBanCharacterCommand,         "", NULL },
        { "email",          PERM_ADM,       true,  &ChatHandler::HandleBanEmailCommand,             "", NULL },
        { "ip",             PERM_GMT,       true,  &ChatHandler::HandleBanIPCommand,                "", NULL },
        { NULL,             0,              false, NULL,                                            "", NULL }
    };

    static ChatCommand baninfoCommandTable[] =
    {
        { "account",        PERM_GMT,       true,  &ChatHandler::HandleBanInfoAccountCommand,       "", NULL },
        { "character",      PERM_GMT,       true,  &ChatHandler::HandleBanInfoCharacterCommand,     "", NULL },
        { "email",          PERM_ADM,       true,  &ChatHandler::HandleBanInfoEmailCommand,         "", NULL },
        { "ip",             PERM_GMT,       true,  &ChatHandler::HandleBanInfoIPCommand,            "", NULL },
        { NULL,             0,              false, NULL,                                            "", NULL }
    };

    static ChatCommand banlistCommandTable[] =
    {
        { "account",        PERM_GMT,       true,  &ChatHandler::HandleBanListAccountCommand,       "", NULL },
        { "character",      PERM_GMT,       true,  &ChatHandler::HandleBanListCharacterCommand,     "", NULL },
        { "email",          PERM_ADM,       true,  &ChatHandler::HandleBanListEmailCommand,         "", NULL },
        { "ip",             PERM_GMT,       true,  &ChatHandler::HandleBanListIPCommand,            "", NULL },
        { NULL,             0,              false, NULL,                                            "", NULL }
    };

    static ChatCommand unbanCommandTable[] =
    {
        { "account",        PERM_GMT,       true,  &ChatHandler::HandleUnBanAccountCommand,         "", NULL },
        { "character",      PERM_GMT,       true,  &ChatHandler::HandleUnBanCharacterCommand,       "", NULL },
        { "email",          PERM_ADM,       true,  &ChatHandler::HandleUnBanEmailCommand,           "", NULL },
        { "ip",             PERM_GMT,       true,  &ChatHandler::HandleUnBanIPCommand,              "", NULL },
        { NULL,             0,              false, NULL,                                            "", NULL }
    };

    static ChatCommand debugPlayCommandTable[] =
    {
        { "cinematic",      PERM_DEVELOPER, false, &ChatHandler::HandleDebugPlayCinematicCommand,   "", NULL },
        { "sound",          PERM_DEVELOPER, false, &ChatHandler::HandleDebugPlaySoundCommand,       "", NULL },
        { NULL,             0,              false, NULL,                                            "", NULL }
    };

    static ChatCommand debugSendCommandTable[] =
    {
        { "buyerror",       PERM_ADM,       false, &ChatHandler::HandleDebugSendBuyErrorCommand,        "", NULL },
        { "channelnotify",  PERM_ADM,       false, &ChatHandler::HandleDebugSendChannelNotifyCommand,   "", NULL },
        { "chatmessage",    PERM_ADM,       false, &ChatHandler::HandleDebugSendChatMsgCommand,         "", NULL },
        { "equiperror",     PERM_ADM,       false, &ChatHandler::HandleDebugSendEquipErrorCommand,      "", NULL },
        { "opcode",         PERM_ADM,       false, &ChatHandler::HandleDebugSendOpcodeCommand,          "", NULL },
        { "poi",            PERM_ADM,       false, &ChatHandler::HandleDebugSendPoiCommand,             "", NULL },
        { "qpartymsg",      PERM_ADM,       false, &ChatHandler::HandleDebugSendQuestPartyMsgCommand,   "", NULL },
        { "qinvalidmsg",    PERM_ADM,       false, &ChatHandler::HandleDebugSendQuestInvalidMsgCommand, "", NULL },
        { "sellerror",      PERM_ADM,       false, &ChatHandler::HandleDebugSendSellErrorCommand,       "", NULL },
        { "spellfail",      PERM_ADM,       false, &ChatHandler::HandleDebugSendSpellFailCommand,       "", NULL },
        { NULL,             0,              false, NULL,                                                "", NULL }
    };

    static ChatCommand debugCommandTable[] =
    {
        { "addformation",   PERM_DEVELOPER, false,  &ChatHandler::HandleDebugAddFormationToFileCommand, "", NULL },
        { "anim",           PERM_GMT_DEV,   false,  &ChatHandler::HandleDebugAnimCommand,               "", NULL },
        { "arena",          PERM_ADM,       false,  &ChatHandler::HandleDebugArenaCommand,              "", NULL },
        { "bg",             PERM_ADM,       false,  &ChatHandler::HandleDebugBattleGroundCommand,       "", NULL },
        { "getitemstate",   PERM_ADM,       false,  &ChatHandler::HandleDebugGetItemState,              "", NULL },
        { "getinstdata",    PERM_ADM,       false,  &ChatHandler::HandleDebugGetInstanceDataCommand,    "", NULL },
        { "getinstdata64",  PERM_ADM,       false,  &ChatHandler::HandleDebugGetInstanceData64Command,  "", NULL },
        { "getvalue",       PERM_ADM,       false,  &ChatHandler::HandleDebugGetValue,                  "", NULL },
        { "hostilelist",    PERM_GMT_DEV,   false,  &ChatHandler::HandleDebugHostilRefList,             "", NULL },
        { "lootrecipient",  PERM_GMT_DEV,   false,  &ChatHandler::HandleDebugGetLootRecipient,          "", NULL },
        { "Mod32Value",     PERM_ADM,       false,  &ChatHandler::HandleDebugMod32Value,                "", NULL },
        { "play",           PERM_DEVELOPER, false,  NULL,                                               "", debugPlayCommandTable },
        { "poolstats",      PERM_GMT_DEV,   false,  &ChatHandler::HandleGetPoolObjectStatsCommand,      "", NULL },
        { "rel",            PERM_ADM,       false,  &ChatHandler::HandleRelocateCreatureCommand,        "", NULL },
        { "send",           PERM_ADM,       false,  NULL,                                               "", debugSendCommandTable },
        { "setinstdata",    PERM_ADM,       false,  &ChatHandler::HandleDebugSetInstanceDataCommand,    "", NULL },
        { "setinstdata64",  PERM_ADM,       false,  &ChatHandler::HandleDebugSetInstanceData64Command,  "", NULL },
        { "setitemflag",    PERM_ADM,       false,  &ChatHandler::HandleDebugSetItemFlagCommand,        "", NULL },
        { "setvalue",       PERM_ADM,       false,  &ChatHandler::HandleDebugSetValue,                  "", NULL },
        { "showcombatstats",PERM_ADM,       false,  &ChatHandler::HandleDebugShowCombatStats,           "", NULL },
        { "threatlist",     PERM_GMT_DEV,   false,  &ChatHandler::HandleDebugThreatList,                "", NULL },
        { "printstate",     PERM_PLAYER,    false,  &ChatHandler::HandleDebugUnitState,                 "", NULL },
        { "update",         PERM_ADM,       false,  &ChatHandler::HandleDebugUpdate,                    "", NULL },
        { "uws",            PERM_ADM,       false,  &ChatHandler::HandleDebugUpdateWorldStateCommand,   "", NULL },
        { NULL,             0,              false,  NULL,                                               "", NULL }
    };

    static ChatCommand eventCommandTable[] =
    {
        { "activelist",     PERM_GMT_DEV,   true,   &ChatHandler::HandleEventActiveListCommand,     "", NULL },
        { "start",          PERM_HIGH_GMT,  true,   &ChatHandler::HandleEventStartCommand,          "", NULL },
        { "stop",           PERM_HIGH_GMT,  true,   &ChatHandler::HandleEventStopCommand,           "", NULL },
        { "",               PERM_GMT_DEV,   true,   &ChatHandler::HandleEventInfoCommand,           "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand learnCommandTable[] =
    {
        { "all",            PERM_ADM,       false,  &ChatHandler::HandleLearnAllCommand,            "", NULL },
        { "all_crafts",     PERM_GMT,       false,  &ChatHandler::HandleLearnAllCraftsCommand,      "", NULL },
        { "all_default",    PERM_GMT,       false,  &ChatHandler::HandleLearnAllDefaultCommand,     "", NULL },
        { "all_gm",         PERM_GMT,       false,  &ChatHandler::HandleLearnAllGMCommand,          "", NULL },
        { "all_lang",       PERM_GMT,       false,  &ChatHandler::HandleLearnAllLangCommand,        "", NULL },
        { "all_myclass",    PERM_ADM,       false,  &ChatHandler::HandleLearnAllMyClassCommand,     "", NULL },
        { "all_myspells",   PERM_ADM,       false,  &ChatHandler::HandleLearnAllMySpellsCommand,    "", NULL },
        { "all_mytalents",  PERM_ADM,       false,  &ChatHandler::HandleLearnAllMyTalentsCommand,   "", NULL },
        { "all_recipes",    PERM_GMT,       false,  &ChatHandler::HandleLearnAllRecipesCommand,     "", NULL },
        { "",               PERM_ADM,       false,  &ChatHandler::HandleLearnCommand,               "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand reloadCommandTable[] =
    {
        { "all",            PERM_ADM,       true,   &ChatHandler::HandleReloadAllCommand,           "", NULL },
        { "all_item",       PERM_ADM,       true,   &ChatHandler::HandleReloadAllItemCommand,       "", NULL },
        { "all_locales",    PERM_ADM,       true,   &ChatHandler::HandleReloadAllLocalesCommand,    "", NULL },
        { "all_loot",       PERM_ADM,       true,   &ChatHandler::HandleReloadAllLootCommand,       "", NULL },
        { "all_npc",        PERM_ADM,       true,   &ChatHandler::HandleReloadAllNpcCommand,        "", NULL },
        { "all_quest",      PERM_ADM,       true,   &ChatHandler::HandleReloadAllQuestCommand,      "", NULL },
        { "all_scripts",    PERM_ADM,       true,   &ChatHandler::HandleReloadAllScriptsCommand,    "", NULL },
        { "all_spell",      PERM_ADM,       true,   &ChatHandler::HandleReloadAllSpellCommand,      "", NULL },

        { "config",         PERM_ADM,       true,   &ChatHandler::HandleReloadConfigCommand,        "", NULL },

        { "areatrigger_tavern",          PERM_ADM,  true,   &ChatHandler::HandleReloadAreaTriggerTavernCommand,         "", NULL },
        { "areatrigger_teleport",        PERM_ADM,  true,   &ChatHandler::HandleReloadAreaTriggerTeleportCommand,       "", NULL },
        { "access_requirement",          PERM_ADM,  true,   &ChatHandler::HandleReloadAccessRequirementCommand,         "", NULL },
        { "areatrigger_involvedrelation",PERM_ADM,  true,   &ChatHandler::HandleReloadQuestAreaTriggersCommand,         "", NULL },
        { "auctions",                    PERM_ADM,  true,   &ChatHandler::HandleReloadAuctionsCommand,                  "", NULL },
        { "autobroadcast",               PERM_ADM,  true,   &ChatHandler::HandleReloadAutobroadcastCommand,             "", NULL },
        { "command",                     PERM_ADM,  true,   &ChatHandler::HandleReloadCommandCommand,                   "", NULL },
        { "creature_involvedrelation",   PERM_ADM,  true,   &ChatHandler::HandleReloadCreatureQuestInvRelationsCommand, "", NULL },
        { "creature_linked_respawn",     PERM_ADM,  true,   &ChatHandler::HandleReloadCreatureLinkedRespawnCommand,     "", NULL },
        { "creature_loot_template",      PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesCreatureCommand,     "", NULL },
        { "creature_questrelation",      PERM_ADM,  true,   &ChatHandler::HandleReloadCreatureQuestRelationsCommand,    "", NULL },
        { "creature_ai_scripts",         PERM_ADM,  true,   &ChatHandler::HandleReloadEventAIScriptsCommand,            "", NULL },
        { "disenchant_loot_template",    PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesDisenchantCommand,   "", NULL },
        { "eventai",                     PERM_ADM,  true,   &ChatHandler::HandleReloadEventAICommand,                   "", NULL },
        { "event_scripts",               PERM_ADM,  true,   &ChatHandler::HandleReloadEventScriptsCommand,              "", NULL },
        { "fishing_loot_template",       PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesFishingCommand,      "", NULL },
        { "game_graveyard_zone",         PERM_ADM,  true,   &ChatHandler::HandleReloadGameGraveyardZoneCommand,         "", NULL },
        { "game_tele",                   PERM_ADM,  true,   &ChatHandler::HandleReloadGameTeleCommand,                  "", NULL },
        { "gameobject_involvedrelation", PERM_ADM,  true,   &ChatHandler::HandleReloadGOQuestInvRelationsCommand,       "", NULL },
        { "gameobject_loot_template",    PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesGameobjectCommand,   "", NULL },
        { "gameobject_questrelation",    PERM_ADM,  true,   &ChatHandler::HandleReloadGOQuestRelationsCommand,          "", NULL },
        { "gameobject_scripts",          PERM_ADM,  true,   &ChatHandler::HandleReloadGameObjectScriptsCommand,         "", NULL },
        { "gm_tickets",                  PERM_ADM,  true,   &ChatHandler::HandleReloadGMTicketCommand,                  "", NULL },
        { "item_enchantment_template",   PERM_ADM,  true,   &ChatHandler::HandleReloadItemEnchantementsCommand,         "", NULL },
        { "item_loot_template",          PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesItemCommand,         "", NULL },
        { "locales_creature",            PERM_ADM,  true,   &ChatHandler::HandleReloadLocalesCreatureCommand,           "", NULL },
        { "locales_gameobject",          PERM_ADM,  true,   &ChatHandler::HandleReloadLocalesGameobjectCommand,         "", NULL },
        { "locales_item",                PERM_ADM,  true,   &ChatHandler::HandleReloadLocalesItemCommand,               "", NULL },
        { "locales_npc_text",            PERM_ADM,  true,   &ChatHandler::HandleReloadLocalesNpcTextCommand,            "", NULL },
        { "locales_page_text",           PERM_ADM,  true,   &ChatHandler::HandleReloadLocalesPageTextCommand,           "", NULL },
        { "locales_quest",               PERM_ADM,  true,   &ChatHandler::HandleReloadLocalesQuestCommand,              "", NULL },
        { "npc_gossip",                  PERM_ADM,  true,   &ChatHandler::HandleReloadNpcGossipCommand,                 "", NULL },
        { "npc_option",                  PERM_ADM,  true,   &ChatHandler::HandleReloadNpcOptionCommand,                 "", NULL },
        { "npc_trainer",                 PERM_ADM,  true,   &ChatHandler::HandleReloadNpcTrainerCommand,                "", NULL },
        { "npc_vendor",                  PERM_ADM,  true,   &ChatHandler::HandleReloadNpcVendorCommand,                 "", NULL },
        { "page_text",                   PERM_ADM,  true,   &ChatHandler::HandleReloadPageTextsCommand,                 "", NULL },
        { "pickpocketing_loot_template", PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesPickpocketingCommand,"", NULL},
        { "prospecting_loot_template",   PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesProspectingCommand,  "", NULL },
        { "quest_mail_loot_template",    PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesQuestMailCommand,    "", NULL },
        { "quest_end_scripts",           PERM_ADM,  true,   &ChatHandler::HandleReloadQuestEndScriptsCommand,           "", NULL },
        { "quest_start_scripts",         PERM_ADM,  true,   &ChatHandler::HandleReloadQuestStartScriptsCommand,         "", NULL },
        { "quest_template",              PERM_ADM,  true,   &ChatHandler::HandleReloadQuestTemplateCommand,             "", NULL },
        { "reference_loot_template",     PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesReferenceCommand,    "", NULL },
        { "reserved_name",               PERM_ADM,  true,   &ChatHandler::HandleReloadReservedNameCommand,              "", NULL },
        { "reputation_reward_rate",      PERM_ADM,  true,   &ChatHandler::HandleReloadReputationRewardRateCommand,      "", NULL },
        { "reputation_spillover_template", PERM_ADM, true, &ChatHandler::HandleReloadReputationSpilloverTemplateCommand, "", NULL },
        { "skill_discovery_template",    PERM_ADM,  true,   &ChatHandler::HandleReloadSkillDiscoveryTemplateCommand,    "", NULL },
        { "skill_extra_item_template",   PERM_ADM,  true,   &ChatHandler::HandleReloadSkillExtraItemTemplateCommand,    "", NULL },
        { "skill_fishing_base_level",    PERM_ADM,  true,   &ChatHandler::HandleReloadSkillFishingBaseLevelCommand,     "", NULL },
        { "skinning_loot_template",      PERM_ADM,  true,   &ChatHandler::HandleReloadLootTemplatesSkinningCommand,     "", NULL },
        { "spell_affect",                PERM_ADM,  true,   &ChatHandler::HandleReloadSpellAffectCommand,               "", NULL },
        { "spell_required",              PERM_ADM,  true,   &ChatHandler::HandleReloadSpellRequiredCommand,             "", NULL },
        { "spell_elixir",                PERM_ADM,  true,   &ChatHandler::HandleReloadSpellElixirCommand,               "", NULL },
        { "spell_learn_spell",           PERM_ADM,  true,   &ChatHandler::HandleReloadSpellLearnSpellCommand,           "", NULL },
        { "spell_linked_spell",          PERM_ADM,  true,   &ChatHandler::HandleReloadSpellLinkedSpellCommand,          "", NULL },
        { "spell_pet_auras",             PERM_ADM,  true,   &ChatHandler::HandleReloadSpellPetAurasCommand,             "", NULL },
        { "spell_proc_event",            PERM_ADM,  true,   &ChatHandler::HandleReloadSpellProcEventCommand,            "", NULL },
        { "spell_enchant_proc_data",     PERM_ADM,  true,   &ChatHandler::HandleReloadSpellEnchantDataCommand,          "", NULL },
        { "spell_script_target",         PERM_ADM,  true,   &ChatHandler::HandleReloadSpellScriptTargetCommand,         "", NULL },
        { "spell_scripts",               PERM_ADM,  true,   &ChatHandler::HandleReloadSpellScriptsCommand,              "", NULL },
        { "spell_target_position",       PERM_ADM,  true,   &ChatHandler::HandleReloadSpellTargetPositionCommand,       "", NULL },
        { "spell_threats",               PERM_ADM,  true,   &ChatHandler::HandleReloadSpellThreatsCommand,              "", NULL },
        { "spell_disabled",              PERM_ADM,  true,   &ChatHandler::HandleReloadSpellDisabledCommand,             "", NULL },
        { "looking4group_string",           PERM_ADM,  true,   &ChatHandler::HandleReloadLooking4groupStringCommand,          "", NULL },
        { "unqueue_account",             PERM_ADM,  true,   &ChatHandler::HandleReloadUnqueuedAccountListCommand,       "", NULL },
        { "waypoint_scripts",            PERM_ADM,  true,   &ChatHandler::HandleReloadWpScriptsCommand,                 "", NULL },

        { "",                            PERM_ADM,  true,   &ChatHandler::HandleReloadCommand,                          "", NULL },
        { NULL,                          0,         false,  NULL,                                                       "", NULL }
    };

    static ChatCommand honorCommandTable[] =
    {
        { "add",            PERM_HIGH_GMT,  false,  &ChatHandler::HandleHonorAddCommand,            "", NULL },
        { "addkill",        PERM_HIGH_GMT,  false,  &ChatHandler::HandleHonorAddKillCommand,        "", NULL },
        { "update",         PERM_HIGH_GMT,  false,  &ChatHandler::HandleHonorUpdateCommand,         "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand guildDisableCommandTable[] =
    {
        { "announce",       PERM_GMT,       true,   &ChatHandler::HandleGuildDisableAnnounceCommand,    "", NULL},
        { NULL,             0,              false,  NULL,                                               "", NULL}
    };

    static ChatCommand guildEnableCommandTable[] =
    {
        { "announce",       PERM_GMT,       true,   &ChatHandler::HandleGuildEnableAnnounceCommand,     "", NULL},
        { NULL,             0,              false,  NULL,                                               "", NULL}
    };

    static ChatCommand guildCommandTable[] =
    {
        { "ann",            PERM_PLAYER,    false,  &ChatHandler::HandleGuildAnnounceCommand,       "", NULL },
        { "create",         PERM_HIGH_GMT,  true,   &ChatHandler::HandleGuildCreateCommand,         "", NULL },
        { "delete",         PERM_HIGH_GMT,  true,   &ChatHandler::HandleGuildDeleteCommand,         "", NULL },
        { "disable",        PERM_GMT,       true,   NULL,                                           "", guildDisableCommandTable },
        { "enable",         PERM_GMT,       true,   NULL,                                           "", guildEnableCommandTable },
        { "invite",         PERM_HIGH_GMT,  true,   &ChatHandler::HandleGuildInviteCommand,         "", NULL },
        { "rank",           PERM_HIGH_GMT,  true,   &ChatHandler::HandleGuildRankCommand,           "", NULL },
        { "uninvite",       PERM_HIGH_GMT,  true,   &ChatHandler::HandleGuildUninviteCommand,       "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand petCommandTable[] =
    {
        { "create",         PERM_GMT,       false,  &ChatHandler::HandleCreatePetCommand,           "", NULL },
        { "learn",          PERM_GMT,       false,  &ChatHandler::HandlePetLearnCommand,            "", NULL },
        { "tp",             PERM_GMT,       false,  &ChatHandler::HandlePetTpCommand,               "", NULL },
        { "unlearn",        PERM_GMT,       false,  &ChatHandler::HandlePetUnlearnCommand,          "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };


    static ChatCommand groupCommandTable[] =
    {
        { "disband",        PERM_ADM,       false,   &ChatHandler::HandleGroupDisbandCommand,    "", NULL },
        { "leader",         PERM_ADM,       false,   &ChatHandler::HandleGroupLeaderCommand,     "", NULL },
        { "remove",         PERM_ADM,       false,   &ChatHandler::HandleGroupRemoveCommand,     "", NULL },
        { "join",           PERM_ADM,       false,   &ChatHandler::HandleGroupJoinCommand,       "", NULL },
        { NULL,             0,              false,   NULL,                                       "", NULL }
    };

    static ChatCommand lookupPlayerCommandTable[] =
    {
        { "account",        PERM_GMT,       true,   &ChatHandler::HandleLookupPlayerAccountCommand, "", NULL },
        { "email",          PERM_HIGH_GMT,  true,   &ChatHandler::HandleLookupPlayerEmailCommand,   "", NULL },
        { "ip",             PERM_GMT,       true,   &ChatHandler::HandleLookupPlayerIpCommand,      "", NULL },
        { "iplist",         PERM_GMT,       true,   &ChatHandler::HandleLookupPlayerIpListCommand,  "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand lookupCommandTable[] =
    {
        { "area",           PERM_GMT,       true,   &ChatHandler::HandleLookupAreaCommand,          "", NULL },
        { "creature",       PERM_ADM,       true,   &ChatHandler::HandleLookupCreatureCommand,      "", NULL },
        { "event",          PERM_GMT,       true,   &ChatHandler::HandleLookupEventCommand,         "", NULL },
        { "faction",        PERM_ADM,       true,   &ChatHandler::HandleLookupFactionCommand,       "", NULL },
        { "item",           PERM_ADM,       true,   &ChatHandler::HandleLookupItemCommand,          "", NULL },
        { "itemset",        PERM_ADM,       true,   &ChatHandler::HandleLookupItemSetCommand,       "", NULL },
        { "object",         PERM_ADM,       true,   &ChatHandler::HandleLookupObjectCommand,        "", NULL },
        { "player",         PERM_HIGH_GMT,  true,   NULL,                                           "", lookupPlayerCommandTable },
        { "quest",          PERM_ADM,       true,   &ChatHandler::HandleLookupQuestCommand,         "", NULL },
        { "skill",          PERM_ADM,       true,   &ChatHandler::HandleLookupSkillCommand,         "", NULL },
        { "spell",          PERM_ADM,       true,   &ChatHandler::HandleLookupSpellCommand,         "", NULL },
        { "tele",           PERM_GMT,       true,   &ChatHandler::HandleLookupTeleCommand,          "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand resetCommandTable[] =
    {
        { "all",            PERM_ADM,       false,  &ChatHandler::HandleResetAllCommand,            "", NULL },
        { "honor",          PERM_ADM,       false,  &ChatHandler::HandleResetHonorCommand,          "", NULL },
        { "level",          PERM_ADM,       false,  &ChatHandler::HandleResetLevelCommand,          "", NULL },
        { "spells",         PERM_ADM,       false,  &ChatHandler::HandleResetSpellsCommand,         "", NULL },
        { "stats",          PERM_ADM,       false,  &ChatHandler::HandleResetStatsCommand,          "", NULL },
        { "talents",        PERM_ADM,       false,  &ChatHandler::HandleResetTalentsCommand,        "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand castCommandTable[] =
    {
        { "back",           PERM_ADM,       false,  &ChatHandler::HandleCastBackCommand,            "", NULL },
        { "dist",           PERM_ADM,       false,  &ChatHandler::HandleCastDistCommand,            "", NULL },
        { "null",           PERM_ADM,       false,  &ChatHandler::HandleCastNullCommand,            "", NULL },
        { "self",           PERM_ADM,       false,  &ChatHandler::HandleCastSelfCommand,            "", NULL },
        { "target",         PERM_ADM,       false,  &ChatHandler::HandleCastTargetCommand,          "", NULL },
        { "",               PERM_ADM,       false,  &ChatHandler::HandleCastCommand,                "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand listCommandTable[] =
    {
        { "auras",          PERM_ADM,       false,  &ChatHandler::HandleListAurasCommand,           "", NULL },
        { "creature",       PERM_ADM,       true,   &ChatHandler::HandleListCreatureCommand,        "", NULL },
        { "item",           PERM_ADM,       true,   &ChatHandler::HandleListItemCommand,            "", NULL },
        { "object",         PERM_ADM,       true,   &ChatHandler::HandleListObjectCommand,          "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand teleCommandTable[] =
    {
        { "add",            PERM_ADM,       false,  &ChatHandler::HandleTeleAddCommand,             "", NULL },
        { "del",            PERM_ADM,       true,   &ChatHandler::HandleTeleDelCommand,             "", NULL },
        { "group",          PERM_GMT,       false,  &ChatHandler::HandleTeleGroupCommand,           "", NULL },
        { "name",           PERM_GMT,       true,   &ChatHandler::HandleTeleNameCommand,            "", NULL },
        { "",               PERM_GMT,       false,  &ChatHandler::HandleTeleCommand,                "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand npcCommandTable[] =
    {
        { "add",            PERM_HIGH_GMT,  false,  &ChatHandler::HandleNpcAddCommand,              "", NULL },
        { "addformation",   PERM_DEVELOPER, false,  &ChatHandler::HandleNpcAddFormationCommand,     "", NULL },
        { "additem",        PERM_HIGH_GMT,  false,  &ChatHandler::HandleNpcAddItemCommand,          "", NULL },
        { "addmove",        PERM_DEVELOPER, false,  &ChatHandler::HandleNpcAddMoveCommand,          "", NULL },
        { "addtemp",        PERM_HIGH_GMT,  false,  &ChatHandler::HandleNpcAddTempCommand,          "", NULL },
        { "changeentry",    PERM_ADM,       false,  &ChatHandler::HandleNpcChangeEntryCommand,      "", NULL },
        { "changelevel",    PERM_HIGH_GMT,  false,  &ChatHandler::HandleNpcChangeLevelCommand,      "", NULL },
        { "delete",         PERM_HIGH_GMT,  false,  &ChatHandler::HandleNpcDeleteCommand,           "", NULL },
        { "deleteformation",PERM_DEVELOPER, false,  &ChatHandler::HandleNpcDeleteFormationCommand,  "", NULL },
        { "delitem",        PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcDelItemCommand,          "", NULL },
        { "doaction",       PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcDoActionCommand,         "", NULL },
        { "enterevademode", PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcEnterEvadeModeCommand,   "", NULL },
        { "factionid",      PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcFactionIdCommand,        "", NULL },
        { "extraflag",      PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcExtraFlagCommand,        "", NULL },
        { "fieldflag",      PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcFieldFlagCommand,        "", NULL },
        { "flag",           PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcFlagCommand,             "", NULL },
        { "follow",         PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcFollowCommand,           "", NULL },
        { "info",           PERM_PLAYER,    false,  &ChatHandler::HandleNpcInfoCommand,             "", NULL },
        { "move",           PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcMoveCommand,             "", NULL },
        { "playemote",      PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcPlayEmoteCommand,        "", NULL },
        { "resetai",        PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcResetAICommand,          "", NULL },
        { "say",            PERM_GMT,       false,  &ChatHandler::HandleNpcSayCommand,              "", NULL },
        { "setlink",        PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcSetLinkCommand,          "", NULL },
        { "setmodel",       PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcSetModelCommand,         "", NULL },
        { "setmovetype",    PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcSetMoveTypeCommand,      "", NULL },
        { "spawndist",      PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcSpawnDistCommand,        "", NULL },
        { "spawntime",      PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcSpawnTimeCommand,        "", NULL },
        { "textemote",      PERM_GMT,       false,  &ChatHandler::HandleNpcTextEmoteCommand,        "", NULL },
        { "unfollow",       PERM_GMT_DEV,   false,  &ChatHandler::HandleNpcUnFollowCommand,         "", NULL },
        { "whisper",        PERM_GMT,       false,  &ChatHandler::HandleNpcWhisperCommand,          "", NULL },
        { "yell",           PERM_GMT,       false,  &ChatHandler::HandleNpcYellCommand,             "", NULL },

        //{ TODO: fix or remove this commands
        { "name",           PERM_GMT,       false,  &ChatHandler::HandleNameCommand,                "", NULL },
        { "subname",        PERM_GMT,       false,  &ChatHandler::HandleSubNameCommand,             "", NULL },
        { "addweapon",      PERM_ADM,       false,  &ChatHandler::HandleAddWeaponCommand,           "", NULL },
        //}

        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand goCommandTable[] =
    {
        { "creature",       PERM_GMT_DEV,   false,  &ChatHandler::HandleGoCreatureCommand,          "", NULL },
        { "direct",         PERM_GMT_DEV,   false,  &ChatHandler::HandleGoCreatureDirectCommand,    "", NULL },
        { "graveyard",      PERM_GMT_DEV,   false,  &ChatHandler::HandleGoGraveyardCommand,         "", NULL },
        { "grid",           PERM_GMT_DEV,   false,  &ChatHandler::HandleGoGridCommand,              "", NULL },
        { "object",         PERM_GMT_DEV,   false,  &ChatHandler::HandleGoObjectCommand,            "", NULL },
        { "ticket",         PERM_GMT,       false,  &ChatHandler::HandleGoTicketCommand,            "", NULL },
        { "trigger",        PERM_GMT_DEV,   false,  &ChatHandler::HandleGoTriggerCommand,           "", NULL },
        { "zonexy",         PERM_GMT_DEV,   false,  &ChatHandler::HandleGoZoneXYCommand,            "", NULL },
        { "xy",             PERM_GMT_DEV,   false,  &ChatHandler::HandleGoXYCommand,                "", NULL },
        { "xyz",            PERM_GMT_DEV,   false,  &ChatHandler::HandleGoXYZCommand,               "", NULL },
        { "",               PERM_GMT_DEV,   false,  &ChatHandler::HandleGoXYZCommand,               "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand gobjectCommandTable[] =
    {
        { "activate",       PERM_GMT_DEV,   false,  &ChatHandler::HandleGameObjectActivateCommand,  "", NULL },
        { "add",            PERM_HIGH_GMT,  false,  &ChatHandler::HandleGameObjectAddCommand,       "", NULL },
        { "addtemp",        PERM_HIGH_GMT,  false,  &ChatHandler::HandleGameObjectAddTempCommand,   "", NULL },
        { "delete",         PERM_HIGH_GMT,  false,  &ChatHandler::HandleGameObjectDeleteCommand,    "", NULL },
        { "grid",           PERM_GMT_DEV,   false,  &ChatHandler::HandleGameObjectGridCommand,      "", NULL },
        { "move",           PERM_GMT_DEV,   false,  &ChatHandler::HandleGameObjectMoveCommand,      "", NULL },
        { "near",           PERM_GMT_DEV,   false,  &ChatHandler::HandleGameObjectNearCommand,      "", NULL },
        { "reset",          PERM_GMT,        false,  &ChatHandler::HandleGameObjectResetCommand,      "", NULL },
        { "target",         PERM_GMT_DEV,   false,  &ChatHandler::HandleGameObjectTargetCommand,    "", NULL },
        { "turn",           PERM_GMT_DEV,   false,  &ChatHandler::HandleGameObjectTurnCommand,      "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand questCommandTable[] =
    {
        { "add",            PERM_HIGH_GMT,  false,  &ChatHandler::HandleQuestAdd,                   "", NULL },
        { "complete",       PERM_HIGH_GMT,  false,  &ChatHandler::HandleQuestComplete,              "", NULL },
        { "remove",         PERM_HIGH_GMT,  false,  &ChatHandler::HandleQuestRemove,                "", NULL },
        { "showlowlevel",   PERM_PLAYER,    false,  &ChatHandler::HandleShowLowLevelQuestCommand,   "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand gmCommandTable[] =
    {
        { "announce",       PERM_HIGH_GMT,  true,   &ChatHandler::HandleGMAnnounceCommand,          "", NULL },
        { "chat",           PERM_GMT,       false,  &ChatHandler::HandleGMChatCommand,              "", NULL },
        { "fly",            PERM_HIGH_GMT,  false,  &ChatHandler::HandleGMFlyCommand,               "", NULL },
        { "list",           PERM_ADM,       true,   &ChatHandler::HandleGMListFullCommand,          "", NULL },
        { "nameannounce",   PERM_GMT,       false,  &ChatHandler::HandleGMNameAnnounceCommand,      "", NULL },
        { "notify",         PERM_HIGH_GMT,  true,   &ChatHandler::HandleGMNotifyCommand,            "", NULL },
        { "visible",        PERM_GMT,       false,  &ChatHandler::HandleGMVisibleCommand,           "", NULL },
        { "",               PERM_GMT,       false,  &ChatHandler::HandleGMCommand,                  "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand instanceCommandTable[] =
    {
        { "listbinds",      PERM_GMT_DEV,   false,  &ChatHandler::HandleInstanceListBindsCommand,   "", NULL },
        { "savedata",       PERM_GMT,       false,  &ChatHandler::HandleInstanceSaveDataCommand,    "", NULL },
        { "selfunbind",     PERM_GMT,       false,  &ChatHandler::HandleInstanceSelfUnbindCommand,  "", NULL },
        { "stats",          PERM_GMT_DEV,   true,   &ChatHandler::HandleInstanceStatsCommand,       "", NULL },
        { "unbind",         PERM_HIGH_GMT,  false,  &ChatHandler::HandleInstanceUnbindCommand,      "", NULL },
        { "bind",           PERM_GMT,       false,  &ChatHandler::HandleInstanceBindCommand,        "", NULL },
        { "resetencounters", PERM_GMT,      false,  &ChatHandler::HandleInstanceResetEncountersCommand, "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand ticketCommandTable[] =
    {
        { "assign",         PERM_GMT,       false,  &ChatHandler::HandleGMTicketAssignToCommand,    "", NULL },
        { "close",          PERM_GMT,       false,  &ChatHandler::HandleGMTicketCloseByIdCommand,   "", NULL },
        { "closedlist",     PERM_GMT,       false,  &ChatHandler::HandleGMTicketListClosedCommand,  "", NULL },
        { "comment",        PERM_GMT,       false,  &ChatHandler::HandleGMTicketCommentCommand,     "", NULL },
        { "delete",         PERM_ADM,       false,  &ChatHandler::HandleGMTicketDeleteByIdCommand,  "", NULL },
        { "history",        PERM_GMT,       false,  &ChatHandler::HandleGMTicketHistoryCommand,     "", NULL },
        { "list",           PERM_GMT,       false,  &ChatHandler::HandleGMTicketListCommand,        "", NULL },
        { "onlinelist",     PERM_GMT,       false,  &ChatHandler::HandleGMTicketListOnlineCommand,  "", NULL },
        { "response",       PERM_GMT,       false,  &ChatHandler::HandleGMTicketResponseCommand,    "", NULL },
        { "unassign",       PERM_GMT,       false,  &ChatHandler::HandleGMTicketUnAssignCommand,    "", NULL },
        { "viewid",         PERM_GMT,       false,  &ChatHandler::HandleGMTicketGetByIdCommand,     "", NULL },
        { "viewname",       PERM_GMT,       false,  &ChatHandler::HandleGMTicketGetByNameCommand,   "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand channelCommandTable[] =
    {
        { "kick",           PERM_ADM,       false,  &ChatHandler::HandleChannelKickCommand,         "", NULL },
        { "list",           PERM_GMT,       false,  &ChatHandler::HandleChannelListCommand,         "", NULL },
        { "masskick",       PERM_ADM,       false,  &ChatHandler::HandleChannelMassKickCommand,     "", NULL },
        { "pass",           PERM_ADM,       false,  &ChatHandler::HandleChannelPassCommand,         "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand crashCommandTable[] =
    {
        { "map",            PERM_HIGH_GMT,  false,  &ChatHandler::HandleCrashMapCommand,            "", NULL },
        { "server",         PERM_ADM,       true,   &ChatHandler::HandleCrashServerCommand,         "", NULL },
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    static ChatCommand commandTable[] =
    {
        { "account",        PERM_PLAYER,    true,   NULL,                                           "", accountCommandTable },
        { "ban",            PERM_GMT,       true,   NULL,                                           "", banCommandTable },
        { "baninfo",        PERM_GMT,       false,  NULL,                                           "", baninfoCommandTable },
        { "banlist",        PERM_GMT,       true,   NULL,                                           "", banlistCommandTable },
        { "cast",           PERM_GMT,       false,  NULL,                                           "", castCommandTable },
        { "channel",        PERM_GMT,       false,  NULL,                                           "", channelCommandTable},
        { "crash",          PERM_HIGH_GMT,  false,  NULL,                                           "", crashCommandTable },
        { "debug",          PERM_GMT,       false,  NULL,                                           "", debugCommandTable },
        { "event",          PERM_GMT,       false,  NULL,                                           "", eventCommandTable },
        { "gm",             PERM_GMT,       true,   NULL,                                           "", gmCommandTable },
        { "go",             PERM_GMT_DEV,   false,  NULL,                                           "", goCommandTable },
        { "gobject",        PERM_GMT_DEV,   false,  NULL,                                           "", gobjectCommandTable },
        { "guild",          PERM_HIGH_GMT,  true,   NULL,                                           "", guildCommandTable },
        { "honor",          PERM_HIGH_GMT,  false,  NULL,                                           "", honorCommandTable },
        { "instance",       PERM_GMT_DEV,   true,   NULL,                                           "", instanceCommandTable },
        { "learn",          PERM_GMT,       false,  NULL,                                           "", learnCommandTable },
        { "list",           PERM_ADM,       true,   NULL,                                           "", listCommandTable },
        { "lookup",         PERM_GMT,       true,   NULL,                                           "", lookupCommandTable },
        { "modify",         PERM_GMT,       false,  NULL,                                           "", modifyCommandTable },
        { "mmap",           PERM_GMT_DEV,   false,  NULL,                                           "", mmapCommandTable },
        { "npc",            PERM_GMT_DEV,   false,  NULL,                                           "", npcCommandTable },
        { "path",           PERM_GMT_DEV,   false,  NULL,                                           "", wpCommandTable },
        { "pet",            PERM_GMT,       false,  NULL,                                           "", petCommandTable },
        { "quest",          PERM_HIGH_GMT,  false,  NULL,                                           "", questCommandTable },
        { "reload",         PERM_ADM,       true,   NULL,                                           "", reloadCommandTable },
        { "reset",          PERM_ADM,       false,  NULL,                                           "", resetCommandTable },
        { "send",           PERM_GMT,       true,   NULL,                                           "", sendCommandTable },
        { "server",         PERM_ADM,       true,   NULL,                                           "", serverCommandTable },
        { "tele",           PERM_GMT_DEV,   true,   NULL,                                           "", teleCommandTable },
        { "ticket",         PERM_GMT,       false,  NULL,                                           "", ticketCommandTable },
        { "unban",          PERM_GMT,       true,   NULL,                                           "", unbanCommandTable },
        { "wp",             PERM_GMT_DEV,   false,  NULL,                                           "", wpCommandTable },

        { "additem",        PERM_ADM,       false,  &ChatHandler::HandleAddItemCommand,             "", NULL },
        { "additemset",     PERM_ADM,       false,  &ChatHandler::HandleAddItemSetCommand,          "", NULL },
        { "allowmove",      PERM_ADM,       false,  &ChatHandler::HandleAllowMovementCommand,       "", NULL },
        { "announce",       PERM_GMT,       true,   &ChatHandler::HandleAnnounceCommand,            "", NULL },
        { "aura",           PERM_ADM,       false,  &ChatHandler::HandleAuraCommand,                "", NULL },
        { "bank",           PERM_ADM,       false,  &ChatHandler::HandleBankCommand,                "", NULL },
        { "bindfollow",     PERM_ADM,       false,  &ChatHandler::HandleBindFollowCommand,          "", NULL },
        { "bindsight",      PERM_ADM,       false,  &ChatHandler::HandleBindSightCommand,           "", NULL },
        { "cd",             PERM_ADM,       false,  &ChatHandler::HandleCooldownCommand,            "", NULL },
        { "chardelete",     PERM_CONSOLE,   true,   &ChatHandler::HandleCharacterDeleteCommand,     "", NULL },
        { "combatstop",     PERM_GMT,       false,  &ChatHandler::HandleCombatStopCommand,          "", NULL },
        { "cometome",       PERM_GMT,       false,  &ChatHandler::HandleComeToMeCommand,            "", NULL },
        { "commands",       PERM_PLAYER,    true,   &ChatHandler::HandleCommandsCommand,            "", NULL },
        { "cooldown",       PERM_HIGH_GMT,  false,  &ChatHandler::HandleCooldownCommand,            "", NULL },
        { "damage",         PERM_ADM,       false,  &ChatHandler::HandleDamageCommand,              "", NULL },
        { "demorph",        PERM_GMT,       false,  &ChatHandler::HandleDeMorphCommand,             "", NULL },
        { "die",            PERM_ADM,       false,  &ChatHandler::HandleDieCommand,                 "", NULL },
        { "dismount",       PERM_PLAYER,    false,  &ChatHandler::HandleDismountCommand,            "", NULL },
        { "distance",       PERM_GMT_DEV,   false,  &ChatHandler::HandleGetDistanceCommand,         "", NULL },
        { "explorecheat",   PERM_ADM,       false,  &ChatHandler::HandleExploreCheatCommand,        "", NULL },
        { "flusharenapoints",PERM_ADM,      false,  &ChatHandler::HandleFlushArenaPointsCommand,    "", NULL },
        { "freeze",         PERM_GMT,       false,  &ChatHandler::HandleFreezeCommand,              "", NULL },
        { "goname",         PERM_GMT,       false,  &ChatHandler::HandleGonameCommand,              "", NULL },
        { "gps",            PERM_GMT_DEV,   false,  &ChatHandler::HandleGPSCommand,                 "", NULL },
        { "info",           PERM_GMT,       false,  &ChatHandler::HandleInfoCommand,                "", NULL },
        { "groupgo",        PERM_GMT,       false,  &ChatHandler::HandleGroupgoCommand,             "", NULL },
        { "guid",           PERM_GMT_DEV,   false,  &ChatHandler::HandleGUIDCommand,                "", NULL },
        { "help",           PERM_PLAYER,    true,   &ChatHandler::HandleHelpCommand,                "", NULL },
        { "hidearea",       PERM_ADM,       false,  &ChatHandler::HandleHideAreaCommand,            "", NULL },
        { "hover",          PERM_ADM,       false,  &ChatHandler::HandleHoverCommand,               "", NULL },
        { "itemmove",       PERM_ADM,       false,  &ChatHandler::HandleItemMoveCommand,            "", NULL },
        { "kick",           PERM_GMT,       true,   &ChatHandler::HandleKickPlayerCommand,          "", NULL },
        { "levelup",        PERM_HIGH_GMT,  false,  &ChatHandler::HandleLevelUpCommand,             "", NULL },
        { "linkgrave",      PERM_GMT_DEV,   false,  &ChatHandler::HandleLinkGraveCommand,           "", NULL },
        { "listfreeze",     PERM_GMT,       false,  &ChatHandler::HandleListFreezeCommand,          "", NULL },
        { "loadscripts",    PERM_ADM,       true,   &ChatHandler::HandleLoadScriptsCommand,         "", NULL },
        { "lockaccount",    PERM_PLAYER,    false,  &ChatHandler::HandleLockAccountCommand,         "", NULL },
        { "maxskill",       PERM_HIGH_GMT,  false,  &ChatHandler::HandleMaxSkillCommand,            "", NULL },
        { "movegens",       PERM_GMT_DEV,   false,  &ChatHandler::HandleMovegensCommand,            "", NULL },
        { "mute",           PERM_GMT,       true,   &ChatHandler::HandleMuteCommand,                "", NULL },
        { "muteinfo",       PERM_GMT,       true,   &ChatHandler::HandleMuteInfoCommand,            "", NULL },
        { "nameannounce",   PERM_GMT,       false,  &ChatHandler::HandleNameAnnounceCommand,        "", NULL },
        { "namego",         PERM_GMT,       false,  &ChatHandler::HandleNamegoCommand,              "", NULL },
        { "neargrave",      PERM_GMT_DEV,   false,  &ChatHandler::HandleNearGraveCommand,           "", NULL },
        { "notify",         PERM_HIGH_GMT,  true,   &ChatHandler::HandleNotifyCommand,              "", NULL },
        { "password",       PERM_PLAYER,    false,  &ChatHandler::HandlePasswordCommand,            "", NULL },
        { "pinfo",          PERM_GMT,       true,   &ChatHandler::HandlePInfoCommand,               "", NULL },
        { "playall",        PERM_ADM,       false,  &ChatHandler::HandlePlayAllCommand,             "", NULL },
        { "plimit",         PERM_ADM,       true,   &ChatHandler::HandlePLimitCommand,              "", NULL },
        { "possess",        PERM_ADM,       false,  &ChatHandler::HandlePossessCommand,             "", NULL },
        { "recall",         PERM_GMT,       false,  &ChatHandler::HandleRecallCommand,              "", NULL },
        { "rename",         PERM_HIGH_GMT,  true,   &ChatHandler::HandleRenameCommand,              "", NULL },
        { "repairitems",    PERM_GMT,       false,  &ChatHandler::HandleRepairitemsCommand,         "", NULL },
        { "respawn",        PERM_ADM,       false,  &ChatHandler::HandleRespawnCommand,             "", NULL },
        { "revive",         PERM_ADM,       false,  &ChatHandler::HandleReviveCommand,              "", NULL },
        { "revivegroup",    PERM_ADM,       false,  &ChatHandler::HandleReviveGroupCommand,         "", NULL },
        { "save",           PERM_PLAYER,    false,  &ChatHandler::HandleSaveCommand,                "", NULL },
        { "setskill",       PERM_ADM,       false,  &ChatHandler::HandleSetSkillCommand,            "", NULL },
        { "showarea",       PERM_ADM,       false,  &ChatHandler::HandleShowAreaCommand,            "", NULL },
        { "start",          PERM_PLAYER,    false,  &ChatHandler::HandleStartCommand,               "", NULL },
        { "taxicheat",      PERM_HIGH_GMT,  false,  &ChatHandler::HandleTaxiCheatCommand,           "", NULL },
        { "unaura",         PERM_ADM,       false,  &ChatHandler::HandleUnAuraCommand,              "", NULL },
        { "unbindfollow",   PERM_ADM,       false,  &ChatHandler::HandleUnbindFollowCommand,        "", NULL },
        { "unbindsight",    PERM_ADM,       false,  &ChatHandler::HandleUnbindSightCommand,         "", NULL },
        { "unfreeze",       PERM_ADM,       false,  &ChatHandler::HandleUnFreezeCommand,            "", NULL },
        { "unlearn",        PERM_ADM,       false,  &ChatHandler::HandleUnLearnCommand,             "", NULL },
        { "unmute",         PERM_GMT,       true,   &ChatHandler::HandleUnmuteCommand,              "", NULL },
        { "unpossess",      PERM_ADM,       false,  &ChatHandler::HandleUnPossessCommand,           "", NULL },
        { "waterwalk",      PERM_ADM,       false,  &ChatHandler::HandleWaterwalkCommand,           "", NULL },
        { "wchange",        PERM_ADM,       false,  &ChatHandler::HandleChangeWeather,              "", NULL },
        { "weather",        PERM_PLAYER,    true,   &ChatHandler::HandleAccountWeatherCommand,      "", NULL },
        { "whispers",       PERM_GMT,       false,  &ChatHandler::HandleWhispersCommand,            "", NULL },
        { "vipadd",         PERM_ADM,       true,   &ChatHandler::HandleAddVIPAccountCommand,       "", NULL },
        { "vipdel",         PERM_ADM,       true,   &ChatHandler::HandleDelVIPAccountCommand,       "", NULL },
        { "charstoplevel",  PERM_PLAYER,    true,   &ChatHandler::HandleStopLevelCharacterCommand,  "", NULL },
        { "charactivatelevel", PERM_PLAYER, true,   &ChatHandler::HandleActivateLevelCharacterCommand, "", NULL },
        { "changeaccount",  PERM_GMT,       true,   &ChatHandler::HandleChangeAccountCommand,     "", NULL },
        { "mentoring",      PERM_PLAYER,    true,   &ChatHandler::HandleMentoringCommand,           "", NULL},
        { "mentorlist",     PERM_PLAYER,    false,  &ChatHandler::HandleMentorListCommand,          "", NULL },
        { "adgreduce",      PERM_GMT,       true,   &ChatHandler::HandleADGreduceCommand,           "", NULL },
        { "settitle",      PERM_ADM,       true,   &ChatHandler::HandleSetTitleCommand,           "", NULL },        
        { NULL,             0,              false,  NULL,                                           "", NULL }
    };

    if (load_command_table)
    {
        load_command_table = false;

        QueryResultAutoPtr result = GameDataDatabase.Query("SELECT name, permission_mask, help FROM command");
        if (result)
        {
            do
            {
                Field *fields = result->Fetch();
                std::string name = fields[0].GetCppString();
                for (uint32 i = 0; commandTable[i].Name != NULL; i++)
                {
                    if (name == commandTable[i].Name)
                    {
                        commandTable[i].RequiredPermissions = fields[1].GetUInt64();
                        commandTable[i].Help = fields[2].GetCppString();
                    }
                    if (commandTable[i].ChildCommands != NULL)
                    {
                        ChatCommand *ptable = commandTable[i].ChildCommands;
                        for (uint32 j = 0; ptable[j].Name != NULL; j++)
                        {
                            // first case for "" named subcommand
                            if (ptable[j].Name[0]=='\0' && name == commandTable[i].Name ||
                                name == fmtstring("%s %s", commandTable[i].Name, ptable[j].Name))
                            {
                                ptable[j].RequiredPermissions = fields[1].GetUInt64();
                                ptable[j].Help = fields[2].GetCppString();
                            }
                        }
                    }
                }
            }
            while (result->NextRow());
        }
    }

    return commandTable;
}

const char *ChatHandler::GetTrinityString(int32 entry) const
{
    return m_session->GetTrinityString(entry);
}

bool ChatHandler::isAvailable(ChatCommand const& cmd) const
{
    // check security level only for simple  command (without child commands)
    return m_session->HasPermissions(cmd.RequiredPermissions);
}

bool ChatHandler::hasStringAbbr(const char* name, const char* part)
{
    // non "" command
    if (*name)
    {
        // "" part from non-"" command
        if (!*part)
            return false;

        for (;;)
        {
            if (!*part)
                return true;
            else if (!*name)
                return false;
            else if (tolower(*name) != tolower(*part))
                return false;
            ++name; ++part;
        }
    }
    // allow with any for ""

    return true;
}

void ChatHandler::SendSysMessage(const char *str)
{
    WorldPacket data;

    // need copy to prevent corruption by strtok call in LineFromMessage original string
    char* buf = mangos_strdup(str);
    char* pos = buf;

    while (char* line = LineFromMessage(pos))
    {
        FillSystemMessageData(&data, line);
        m_session->SendPacket(&data);
    }

    delete [] buf;
}

void ChatHandler::SendGlobalSysMessage(const char *str)
{
    // Chat output
    WorldPacket data;

    // need copy to prevent corruption by strtok call in LineFromMessage original string
    char* buf = mangos_strdup(str);
    char* pos = buf;

    while (char* line = LineFromMessage(pos))
    {
        FillSystemMessageData(&data, line);
        sWorld.SendGlobalMessage(&data);
    }

    delete [] buf;
}

void ChatHandler::SendGlobalGMSysMessage(int32 entry, ...)
{
    const char *format = GetTrinityString(entry);
    va_list ap;
    char str [1024];
    va_start(ap, entry);
    vsnprintf(str,1024,format, ap);
    va_end(ap);
    SendGlobalGMSysMessage(str, NULL);
}

void ChatHandler::SendGlobalGMSysMessage(const char *format, ...)
{
    va_list ap;
    char str [1024];
    va_start(ap, format);
    vsnprintf(str,1024,format, ap);
    va_end(ap);
    
    // Chat output
    WorldPacket data;

    // need copy to prevent corruption by strtok call in LineFromMessage original string
    char* buf = mangos_strdup(str);
    char* pos = buf;

    while (char* line = LineFromMessage(pos))
    {
        FillSystemMessageData(&data, line);
        sWorld.SendGlobalGMMessage(&data);
     }
    delete [] buf;
}

void ChatHandler::SendGlobalMentoringSysMessage(const char *format, ...)
{
    va_list ap;
    char str [1024];
    va_start(ap, format);
    vsnprintf(str,1024,format, ap);
    va_end(ap);
    
    // Chat output
    WorldPacket data;

    // need copy to prevent corruption by strtok call in LineFromMessage original string
    char* buf = mangos_strdup(str);
    char* pos = buf;

    while (char* line = LineFromMessage(pos))
    {
        FillSystemMessageData(&data, line);
        sWorld.SendGlobalMentoringMessage(&data);
     }
    delete [] buf;
}


void ChatHandler::SendSysMessage(int32 entry)
{
    SendSysMessage(GetTrinityString(entry));
}

void ChatHandler::PSendSysMessage(int32 entry, ...)
{
    const char *format = GetTrinityString(entry);
    va_list ap;
    char str [1024];
    va_start(ap, entry);
    vsnprintf(str,1024,format, ap);
    va_end(ap);
    SendSysMessage(str);
}

void ChatHandler::PSendSysMessage(const char *format, ...)
{
    va_list ap;
    char str [1280];
    va_start(ap, format);
    vsnprintf(str,1280,format, ap);
    va_end(ap);
    SendSysMessage(str);
}

bool ChatHandler::ExecuteCommandInTable(ChatCommand *table, const char* text, const std::string& fullcmd)
{
    char const* oldtext = text;
    std::string cmd = "";

    while (*text != ' ' && *text != '\0')
    {
        cmd += *text;
        ++text;
    }

    while (*text == ' ') ++text;

    for (uint32 i = 0; table[i].Name != NULL; i++)
    {
        if (!hasStringAbbr(table[i].Name, cmd.c_str()))
            continue;

        // select subcommand from child commands list
        if (table[i].ChildCommands != NULL)
        {
            if (!ExecuteCommandInTable(table[i].ChildCommands, text, fullcmd))
            {
                if (text && text[0] != '\0')
                    SendSysMessage(LANG_NO_SUBCMD);
                else
                    SendSysMessage(LANG_CMD_SYNTAX);

                ShowHelpForCommand(table[i].ChildCommands,text);
            }

            return true;
        }

        // must be available and have handler
        if (!table[i].Handler || !isAvailable(table[i]))
            continue;

        SetSentErrorMessage(false);
        // table[i].Name == "" is special case: send original command to handler
        if ((this->*(table[i].Handler))(strlen(table[i].Name)!=0 ? text : oldtext))
        {
            if (table[i].RequiredPermissions & sWorld.getConfig(CONFIG_MIN_GM_COMMAND_LOG_LEVEL))
            {
                // chat case
                if (m_session)
                {
                    Player* p = m_session->GetPlayer();
                    uint64 sel_guid = p->GetSelection();
                    if (table[i].Name != "password")
                        sLog.outCommand(m_session->GetAccountId(),"Command: %s [Player: %s (Account: %u) X: %f Y: %f Z: %f Map: %u Selected: (GUID: %u)]",
                            fullcmd.c_str(),p->GetName(),m_session->GetAccountId(),p->GetPositionX(),p->GetPositionY(),p->GetPositionZ(),p->GetMapId(),
                            GUID_LOPART(sel_guid));
                    else 
                        sLog.outCommand(m_session->GetAccountId(),"Command: PASSWORDCMD!!! [Player: %s (Account: %u) X: %f Y: %f Z: %f Map: %u Selected: (GUID: %u)]",
                            p->GetName(),m_session->GetAccountId(),p->GetPositionX(),p->GetPositionY(),p->GetPositionZ(),p->GetMapId(),
                            GUID_LOPART(sel_guid));
                }
            }
        }
        // some commands have custom error messages. Don't send the default one in these cases.
        else if (!sentErrorMessage)
        {
            if (!table[i].Help.empty())
                SendSysMessage(table[i].Help.c_str());
            else
                SendSysMessage(LANG_CMD_SYNTAX);
        }

        return true;
    }

    return false;
}

bool ChatHandler::ContainsNotAllowedSigns(std::string text /*copy of text because we change it*/)
{
    for (uint32 i = 0; i < text.length(); ++i)
        text[i] = tolower(text[i]);

    if ((text.find(".blp") != text.npos) || (text.find("t|t") != text.npos))
        return true;
    return false;
}

int ChatHandler::ParseCommands(const char* text)
{
    ASSERT(text);
    ASSERT(*text);

    std::string fullcmd = text;

    /// chat case (.command format)
    if (m_session)
    {
        if (text[0] != '.')
            return 0;
    }

    /// ignore single . and ! in line
    if (strlen(text) < 2)
        return 0;
    // original `text` can't be used. It content destroyed in command code processing.

    /// ignore messages staring from many dots.
    if (text[0] == '.' && text[1] == '.')
        return 0;

    /// skip first . (in console allowed use command with . and without its)
    if (text[0] == '.')
        ++text;

    if (!ExecuteCommandInTable(getCommandTable(), text, fullcmd))
    {
        if (m_session && !m_session->HasPermissions(PERM_GMT))
            return 0;
        SendSysMessage(LANG_NO_CMD);
    }
    return 1;
}

bool ChatHandler::ShowHelpForSubCommands(ChatCommand *table, char const* cmd, char const* subcmd)
{
    std::string list;
    for (uint32 i = 0; table[i].Name != NULL; ++i)
    {
        // must be available (ignore handler existence for show command with possibe avalable subcomands
        if (!isAvailable(table[i]))
            continue;

        /// for empty subcmd show all available
        if (*subcmd && !hasStringAbbr(table[i].Name, subcmd))
            continue;

        if (m_session)
            list += "\n    ";
        else
            list += "\n\r    ";

        list += table[i].Name;

        if (table[i].ChildCommands)
            list += " ...";
    }

    if (list.empty())
        return false;

    if (table==getCommandTable())
    {
        SendSysMessage(LANG_AVIABLE_CMD);
        PSendSysMessage("%s",list.c_str());
    }
    else
        PSendSysMessage(LANG_SUBCMDS_LIST,cmd,list.c_str());

    return true;
}

bool ChatHandler::ShowHelpForCommand(ChatCommand *table, const char* cmd)
{
    if (*cmd)
    {
        for (uint32 i = 0; table[i].Name != NULL; ++i)
        {
            // must be available (ignore handler existence for show command with possibe avalable subcomands
            if (!isAvailable(table[i]))
                continue;

            if (!hasStringAbbr(table[i].Name, cmd))
                continue;

            // have subcommand
            char const* subcmd = (*cmd) ? strtok(NULL, " ") : "";

            if (table[i].ChildCommands && subcmd && *subcmd)
            {
                if (ShowHelpForCommand(table[i].ChildCommands, subcmd))
                    return true;
            }

            if (!table[i].Help.empty())
                SendSysMessage(table[i].Help.c_str());

            if (table[i].ChildCommands)
                if (ShowHelpForSubCommands(table[i].ChildCommands,table[i].Name,subcmd ? subcmd : ""))
                    return true;

            return !table[i].Help.empty();
        }
    }
    else
    {
        for (uint32 i = 0; table[i].Name != NULL; ++i)
        {
            // must be available (ignore handler existence for show command with possibe avalable subcomands
            if (!isAvailable(table[i]))
                continue;

            if (strlen(table[i].Name))
                continue;

            if (!table[i].Help.empty())
                SendSysMessage(table[i].Help.c_str());

            if (table[i].ChildCommands)
                if (ShowHelpForSubCommands(table[i].ChildCommands,"",""))
                    return true;

            return !table[i].Help.empty();
        }
    }

    return ShowHelpForSubCommands(table,"",cmd);
}

//Note: target_guid used only in CHAT_MSG_WHISPER_INFORM mode (in this case channelName ignored)
void ChatHandler::FillMessageData(WorldPacket *data, WorldSession* session, uint8 type, uint32 language, const char *channelName, uint64 target_guid, const char *message, Unit *speaker)
{
    uint32 messageLength = (message ? strlen(message) : 0) + 1;

    data->Initialize(SMSG_MESSAGECHAT, 100);                // guess size
    *data << uint8(type);
    if ((type != CHAT_MSG_CHANNEL && type != CHAT_MSG_WHISPER) || language == LANG_ADDON)
        *data << uint32(language);
    else
        *data << uint32(LANG_UNIVERSAL);

    switch (type)
    {
        case CHAT_MSG_SAY:
        case CHAT_MSG_PARTY:
        case CHAT_MSG_RAID:
        case CHAT_MSG_GUILD:
        case CHAT_MSG_OFFICER:
        case CHAT_MSG_YELL:
        case CHAT_MSG_WHISPER:
        case CHAT_MSG_CHANNEL:
        case CHAT_MSG_RAID_LEADER:
        case CHAT_MSG_RAID_WARNING:
        case CHAT_MSG_BG_SYSTEM_NEUTRAL:
        case CHAT_MSG_BG_SYSTEM_ALLIANCE:
        case CHAT_MSG_BG_SYSTEM_HORDE:
        case CHAT_MSG_BATTLEGROUND:
        case CHAT_MSG_BATTLEGROUND_LEADER:
            target_guid = session ? session->GetPlayer()->GetGUID() : 0;
            break;
        case CHAT_MSG_MONSTER_SAY:
        case CHAT_MSG_MONSTER_PARTY:
        case CHAT_MSG_MONSTER_YELL:
        case CHAT_MSG_MONSTER_WHISPER:
        case CHAT_MSG_MONSTER_EMOTE:
        case CHAT_MSG_RAID_BOSS_WHISPER:
        case CHAT_MSG_RAID_BOSS_EMOTE:
        {
            *data << uint64(speaker->GetGUID());
            *data << uint32(0);                             // 2.1.0
            *data << uint32(strlen(speaker->GetName()) + 1);
            *data << speaker->GetName();
            uint64 listener_guid = 0;
            *data << uint64(listener_guid);
            if (listener_guid && !IS_PLAYER_GUID(listener_guid))
            {
                *data << uint32(1);                         // string listener_name_length
                *data << uint8(0);                          // string listener_name
            }
            *data << uint32(messageLength);
            *data << message;
            *data << uint8(0);
            return;
        }
        default:
            if (type != CHAT_MSG_REPLY && type != CHAT_MSG_IGNORED && type != CHAT_MSG_DND && type != CHAT_MSG_AFK)
                target_guid = 0;                            // only for CHAT_MSG_WHISPER_INFORM used original value target_guid
            break;
    }

    *data << uint64(target_guid);                           // there 0 for BG messages
    *data << uint32(0);                                     // can be chat msg group or something

    if (type == CHAT_MSG_CHANNEL)
    {
        ASSERT(channelName);
        *data << channelName;
    }

    *data << uint64(target_guid);
    *data << uint32(messageLength);
    *data << message;
    if (session != 0 && type != CHAT_MSG_REPLY && type != CHAT_MSG_DND && type != CHAT_MSG_AFK)
        *data << uint8(session->GetPlayer()->chatTag());
    else
        *data << uint8(0);
}

Player * ChatHandler::getSelectedPlayer()
{
    if (!m_session)
        return NULL;

    uint64 guid  = m_session->GetPlayer()->GetSelection();

    if (guid == 0)
        return m_session->GetPlayer();

    return sObjectMgr.GetPlayer(guid);
}

Unit* ChatHandler::getSelectedUnit()
{
    if (!m_session)
        return NULL;

    uint64 guid = m_session->GetPlayer()->GetSelection();

    if (guid == 0)
        return m_session->GetPlayer();

    return m_session->GetPlayer()->GetMap()->GetUnit(guid);
}

Creature* ChatHandler::getSelectedCreature()
{
    if (!m_session)
        return NULL;

    Player * tmp = m_session->GetPlayer();

    return tmp->GetMap()->GetCreatureOrPet(tmp->GetSelection());
}

char* ChatHandler::extractKeyFromLink(char* text, char const* linkType, char** something1)
{
    // skip empty
    if (!text)
        return NULL;

    // skip spaces
    while (*text==' '||*text=='\t'||*text=='\b')
        ++text;

    if (!*text)
        return NULL;

    // return non link case
    if (text[0]!='|')
        return strtok(text, " ");

    // [name] Shift-click form |color|linkType:key|h[name]|h|r
    // or
    // [name] Shift-click form |color|linkType:key:something1:...:somethingN|h[name]|h|r

    char* check = strtok(text, "|");                        // skip color
    if (!check)
        return NULL;                                        // end of data

    char* cLinkType = strtok(NULL, ":");                    // linktype
    if (!cLinkType)
        return NULL;                                        // end of data

    if (strcmp(cLinkType,linkType) != 0)
    {
        strtok(NULL, " ");                                  // skip link tail (to allow continue strtok(NULL,s) use after retturn from function
        SendSysMessage(LANG_WRONG_LINK_TYPE);
        return NULL;
    }

    char* cKeys = strtok(NULL, "|");                        // extract keys and values
    char* cKeysTail = strtok(NULL, "");

    char* cKey = strtok(cKeys, ":|");                       // extract key
    if (something1)
        *something1 = strtok(NULL, ":|");                   // extract something

    strtok(cKeysTail, "]");                                 // restart scan tail and skip name with possible spaces
    strtok(NULL, " ");                                      // skip link tail (to allow continue strtok(NULL,s) use after retturn from function
    return cKey;
}

char* ChatHandler::extractKeyFromLink(char* text, char const* const* linkTypes, int* found_idx, char** something1)
{
    // skip empty
    if (!text)
        return NULL;

    // skip spaces
    while (*text==' '||*text=='\t'||*text=='\b')
        ++text;

    if (!*text)
        return NULL;

    // return non link case
    if (text[0]!='|')
        return strtok(text, " ");

    // [name] Shift-click form |color|linkType:key|h[name]|h|r
    // or
    // [name] Shift-click form |color|linkType:key:something1:...:somethingN|h[name]|h|r

    char* check = strtok(text, "|");                        // skip color
    if (!check)
        return NULL;                                        // end of data

    char* cLinkType = strtok(NULL, ":");                    // linktype
    if (!cLinkType)
        return NULL;                                        // end of data

    for (int i = 0; linkTypes[i]; ++i)
    {
        if (strcmp(cLinkType,linkTypes[i]) == 0)
        {
            char* cKeys = strtok(NULL, "|");                // extract keys and values
            char* cKeysTail = strtok(NULL, "");

            char* cKey = strtok(cKeys, ":|");               // extract key
            if (something1)
                *something1 = strtok(NULL, ":|");           // extract something

            strtok(cKeysTail, "]");                         // restart scan tail and skip name with possible spaces
            strtok(NULL, " ");                              // skip link tail (to allow continue strtok(NULL,s) use after return from function
            if (found_idx)
                *found_idx = i;
            return cKey;
        }
    }

    strtok(NULL, " ");                                      // skip link tail (to allow continue strtok(NULL,s) use after return from function
    SendSysMessage(LANG_WRONG_LINK_TYPE);
    return NULL;
}

char const *fmtstring(char const *format, ...)
{
    va_list        argptr;
    #define    MAX_FMT_STRING    32000
    static char        temp_buffer[MAX_FMT_STRING];
    static char        string[MAX_FMT_STRING];
    static int        index = 0;
    char    *buf;
    int len;

    va_start(argptr, format);
    vsnprintf(temp_buffer,MAX_FMT_STRING, format, argptr);
    va_end(argptr);

    len = strlen(temp_buffer);

    if (len >= MAX_FMT_STRING)
        return "ERROR";

    if (len + index >= MAX_FMT_STRING-1)
    {
        index = 0;
    }

    buf = &string[index];
    memcpy(buf, temp_buffer, len+1);

    index += len + 1;

    return buf;
}

GameObject* ChatHandler::GetObjectGlobalyWithGuidOrNearWithDbGuid(uint32 lowguid,uint32 entry)
{
    if (!m_session)
        return NULL;

    Player* pl = m_session->GetPlayer();

    GameObject* obj = pl->GetMap()->GetGameObject(MAKE_NEW_GUID(lowguid, entry, HIGHGUID_GAMEOBJECT));

    if (!obj && sObjectMgr.GetGOData(lowguid))                   // guid is DB guid of object
    {
        // search near player then
        Looking4group::GameObjectWithDbGUIDCheck go_check(*pl,lowguid);
        Looking4group::ObjectSearcher<GameObject, Looking4group::GameObjectWithDbGUIDCheck> checker(obj,go_check);

        Cell::VisitGridObjects(pl,checker, pl->GetMap()->GetVisibilityDistance());
    }

    return obj;
}

static char const* const spellTalentKeys[] = {
    "Hspell",
    "Htalent",
    0
};

uint32 ChatHandler::extractSpellIdFromLink(char* text)
{
    // number or [name] Shift-click form |color|Hspell:spell_id|h[name]|h|r
    // number or [name] Shift-click form |color|Htalent:talent_id,rank|h[name]|h|r
    int type = 0;
    char* rankS = NULL;
    char* idS = extractKeyFromLink(text,spellTalentKeys,&type,&rankS);
    if (!idS)
        return 0;

    uint32 id = (uint32)atol(idS);

    // spell
    if (type==0)
        return id;

    // talent
    TalentEntry const* talentEntry = sTalentStore.LookupEntry(id);
    if (!talentEntry)
        return 0;

    int32 rank = rankS ? (uint32)atol(rankS) : 0;
    if (rank >= 5)
        return 0;

    if (rank < 0)
        rank = 0;

    return talentEntry->RankID[rank];
}

GameTele const* ChatHandler::extractGameTeleFromLink(char* text)
{
    // id, or string, or [name] Shift-click form |color|Htele:id|h[name]|h|r
    char* cId = extractKeyFromLink(text,"Htele");
    if (!cId)
        return NULL;

    // id case (explicit or from shift link)
    if (cId[0] >= '0' || cId[0] >= '9')
        if (uint32 id = atoi(cId))
            return sObjectMgr.GetGameTele(id);

    return sObjectMgr.GetGameTele(cId);
}

const char *ChatHandler::GetName() const
{
    return m_session->GetPlayer()->GetName();
}

bool ChatHandler::needReportToTarget(Player* chr) const
{
    Player* pl = m_session->GetPlayer();
    return pl != chr && pl->IsVisibleGloballyfor (chr);
}

const char *CliHandler::GetTrinityString(int32 entry) const
{
    return sObjectMgr.GetTrinityStringForDBCLocale(entry);
}

bool CliHandler::isAvailable(ChatCommand const& cmd) const
{
    // skip non-console commands in console case
    return cmd.AllowConsole;
}

void CliHandler::SendSysMessage(const char *str)
{
    m_print(str);
    m_print("\r\n");
}

const char *CliHandler::GetName() const
{
    return GetTrinityString(LANG_CONSOLE_COMMAND);
}

bool CliHandler::needReportToTarget(Player* /*chr*/) const
{
    return true;
}

bool ChatHandler::GetPlayerGroupAndGUIDByName(const char* cname, Player* &plr, Group* &group, uint64 &guid, bool offline)
{
    plr  = NULL;
    guid = 0;

    if (cname)
    {
        std::string name = cname;
        if (!name.empty())
        {
            if (!normalizePlayerName(name))
            {
                PSendSysMessage(LANG_PLAYER_NOT_FOUND);
                SetSentErrorMessage(true);
                return false;
            }

            plr = sObjectMgr.GetPlayer(name.c_str());
            if (offline)
                guid = sObjectMgr.GetPlayerGUIDByName(name.c_str());
        }
    }

    if (plr)
    {
        group = plr->GetGroup();
        if (!guid || !offline)
            guid = plr->GetGUID();
    }
    else
    {
        if (getSelectedPlayer())
            plr = getSelectedPlayer();
        else
            plr = m_session->GetPlayer();

        if (!guid || !offline)
            guid  = plr->GetGUID();
        group = plr->GetGroup();
    }

    return true;
}

std::string ChatHandler::GetNameLink(std::string & name)
{
    return "|Hplayer:" + name + "|h[" + name + "]|h";
}
