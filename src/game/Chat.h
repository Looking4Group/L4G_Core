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

#ifndef TRINITYCORE_CHAT_H
#define TRINITYCORE_CHAT_H

#include "SharedDefines.h"

class ChatHandler;
class WorldSession;
class Creature;
class Player;
class Unit;
struct GameTele;

class ChatCommand
{
    public:
        const char *       Name;
        uint64             RequiredPermissions;                   // function pointer required correct align (use uint32)
        bool               AllowConsole;
        bool (ChatHandler::*Handler)(const char* args);
        std::string        Help;
        ChatCommand *      ChildCommands;
};

class ChatHandler
{
    public:
        explicit ChatHandler(WorldSession* session) : m_session(session) {}
        explicit ChatHandler(Player* player) : m_session(player->GetSession()) {}
         ~ChatHandler() {}

        static void FillMessageData(WorldPacket *data, WorldSession* session, uint8 type, uint32 language, const char *channelName, uint64 target_guid, const char *message, Unit *speaker);

        void FillMessageData(WorldPacket *data, uint8 type, uint32 language, uint64 target_guid, const char* message)
        {
            FillMessageData(data, m_session, type, language, NULL, target_guid, message, NULL);
        }

        void FillSystemMessageData(WorldPacket *data, const char* message)
        {
            FillMessageData(data, CHAT_MSG_SYSTEM, LANG_UNIVERSAL, 0, message);
        }

        static char* LineFromMessage(char*& pos) { char* start = strtok(pos,"\n"); pos = NULL; return start; }
        static std::string GetNameLink(std::string & name);

        virtual const char *GetTrinityString(int32 entry) const;

        virtual void SendSysMessage( const char *str);
        void SendSysMessage(         int32     entry);
        void PSendSysMessage(        const char *format, ...) ATTR_PRINTF(2,3);
        void PSendSysMessage(        int32     entry, ... );
        void SendGlobalMentoringSysMessage(const char *format, ...);
        std::string PGetParseString(int32 entry, ...);

        int ParseCommands(const char* text);

        bool ContainsNotAllowedSigns(std::string text);

        virtual char const* GetName() const;
        static ChatCommand* getCommandTable();
    protected:
        explicit ChatHandler() : m_session(NULL) {}      // for CLI subclass

        bool hasStringAbbr(const char* name, const char* part);

        virtual bool isAvailable(ChatCommand const& cmd) const;
        virtual bool needReportToTarget(Player* chr) const;

        void SendGlobalSysMessage(const char *str);
        void SendGlobalGMSysMessage(const char *format, ...);
        void SendGlobalGMSysMessage(int32 entry, ...);

        bool SendGMMail(const char* pName, const char* msgSubject, const char* msgText);

        bool ExecuteCommandInTable(ChatCommand *table, const char* text, const std::string& fullcommand);
        bool ShowHelpForCommand(ChatCommand *table, const char* cmd);
        bool ShowHelpForSubCommands(ChatCommand *table, char const* cmd, char const* subcmd);

        bool HandleAccountCommand(const char* args);
        bool HandleAccountCreateCommand(const char* args);
        bool HandleAccountDeleteCommand(const char* args);
        bool HandleAccountOnlineListCommand(const char* args);
        bool HandleAccountSetAddonCommand(const char* args);
        bool HandleAccountSetPermissionsCommand(const char* args);
        bool HandleAccountSetPasswordCommand(const char* args);
        bool HandleAccountSetMultiaccCommand(const char* args);
        bool HandleAccountWeatherCommand(const char*args);
        bool HandleAccountSpecialLogCommand(const char* args);
        bool HandleAccountWhispLogCommand(const char* args);
        bool HandleAccountGuildAnnToggleCommand(const char* args);
        bool HandleAccountBonesHideCommand(const char* args);
        bool HandleAccountXPToggleCommand(const char* args);
        bool HandleAccountBattleGroundAnnCommand(const char* args);
        bool HandleAccountAnnounceBroadcastCommand(const char* args);
        bool HandleAccountDelMultiaccCommand(const char* args);

        bool HandleBanAccountCommand(const char* args);
        bool HandleBanCharacterCommand(const char* args);
        bool HandleBanEmailCommand(const char* args);
        bool HandleBanIPCommand(const char* args);
        bool HandleBanInfoAccountCommand(const char* args);
        bool HandleBanInfoCharacterCommand(const char* args);
        bool HandleBanInfoEmailCommand(const char* args);
        bool HandleBanInfoIPCommand(const char* args);
        bool HandleBanListAccountCommand(const char* args);
        bool HandleBanListCharacterCommand(const char* args);
        bool HandleBanListIPCommand(const char* args);
        bool HandleBanListEmailCommand(const char* args);

        bool HandleCastCommand(const char *args);
        bool HandleCastBackCommand(const char *args);
        bool HandleCastDistCommand(const char *args);
        bool HandleCastNullCommand(const char *args);
        bool HandleCastSelfCommand(const char *args);
        bool HandleCastTargetCommand(const char *args);

        bool HandleCrashMapCommand(const char *args);
        bool HandleCrashServerCommand(const char *args);

        bool HandleDebugAddFormationToFileCommand(const char* args);
        bool HandleDebugAnimCommand(const char* args);
        bool HandleDebugArenaCommand(const char * args);
        bool HandleDebugBattleGroundCommand(const char * args);
        bool HandleDebugGetInstanceDataCommand(const char* args);
        bool HandleDebugGetInstanceData64Command(const char* args);
        bool HandleDebugGetItemState(const char * args);
        bool HandleDebugGetLootRecipient(const char * args);
        bool HandleDebugGetValue(const char* args);
        bool HandleDebugMod32Value(const char* args);
        bool HandleDebugSetInstanceDataCommand(const char* args);
        bool HandleDebugSetInstanceData64Command(const char* args);
        bool HandleDebugSetItemFlagCommand(const char * args);
        bool HandleDebugSetValue(const char* args);
        bool HandleDebugShowCombatStats(const char* args);
        bool HandleDebugThreatList(const char * args);
        bool HandleDebugUnitState(const char * args);
        bool HandleDebugUpdate(const char* args);
        bool HandleDebugUpdateWorldStateCommand(const char* args);
        bool HandleDebugWPCommand(const char* args);


        bool HandleDebugPlayCinematicCommand(const char* args);
        bool HandleDebugPlaySoundCommand(const char* args);

        bool HandleDebugSendBuyErrorCommand(const char* args);
        bool HandleDebugSendChannelNotifyCommand(const char* args);
        bool HandleDebugSendChatMsgCommand(const char* args);
        bool HandleDebugSendEquipErrorCommand(const char* args);
        bool HandleDebugSendOpcodeCommand(const char* args);
        bool HandleDebugSendPoiCommand(const char* args);
        bool HandleDebugSendQuestPartyMsgCommand(const char* args);
        bool HandleDebugSendQuestInvalidMsgCommand(const char* args);
        bool HandleDebugSendSellErrorCommand(const char* args);
        bool HandleDebugSendSpellFailCommand(const char* args);

        bool HandleEventActiveListCommand(const char* args);
        bool HandleEventStartCommand(const char* args);
        bool HandleEventStopCommand(const char* args);
        bool HandleEventInfoCommand(const char* args);

        bool HandleGameObjectActivateCommand(const char* args);
        bool HandleGameObjectAddCommand(const char* args);
        bool HandleGameObjectAddTempCommand(const char* args);
        bool HandleGameObjectDeleteCommand(const char* args);
        bool HandleGameObjectGridCommand(const char* args);
        bool HandleGameObjectMoveCommand(const char* args);
        bool HandleGameObjectNearCommand(const char* args);
        bool HandleGameObjectResetCommand(const char* args);
        bool HandleGameObjectStateCommand(const char* args);
        bool HandleGameObjectTargetCommand(const char* args);
        bool HandleGameObjectTurnCommand(const char* args);

        bool HandleGMAnnounceCommand(const char* args);
        bool HandleGMCommand(const char* args);
        bool HandleGMChatCommand(const char* args);
        bool HandleGMFlyCommand(const char* args);
        bool HandleGMListFullCommand(const char* args);
        bool HandleGMNameAnnounceCommand(const char* args);
        bool HandleGMNotifyCommand(const char* args);
        bool HandleGMVisibleCommand(const char* args);

        bool HandleGuildAnnounceCommand(const char *args);
        bool HandleGuildCreateCommand(const char* args);
        bool HandleGuildInviteCommand(const char* args);
        bool HandleGuildUninviteCommand(const char* args);
        bool HandleGuildRankCommand(const char* args);
        bool HandleGuildDeleteCommand(const char* args);
        bool HandleADGreduceCommand(const char* args);

        bool HandleGuildDisableAnnounceCommand(const char *args);
        bool HandleGuildEnableAnnounceCommand(const char *args);

        bool HandleHonorAddCommand(const char* args);
        bool HandleHonorAddKillCommand(const char* args);
        bool HandleHonorUpdateCommand(const char* args);

        bool HandleInstanceListBindsCommand(const char* args);
        bool HandleInstanceUnbindCommand(const char* args);
        bool HandleInstanceSelfUnbindCommand(const char* args);
        bool HandleInstanceStatsCommand(const char* args);
        bool HandleInstanceSaveDataCommand(const char * args);
        bool HandleInstanceBindCommand(const char* args);
        bool HandleInstanceResetEncountersCommand(const char* args);

        bool HandleMmapPathCommand(const char* args);
        bool HandleMmapLocCommand(const char* args);
        bool HandleMmapLoadedTilesCommand(const char* args);
        bool HandleMmapStatsCommand(const char* args);
        bool HandleMmapOffsetCreateCommand(const char* /*args*/);
        bool HandleMmap(const char* args);
        bool HandleMmapTestArea(const char* args);

        bool HandleLearnCommand(const char* args);
        bool HandleLearnAllCommand(const char* args);
        bool HandleLearnAllGMCommand(const char* args);
        bool HandleLearnAllCraftsCommand(const char* args);
        bool HandleLearnAllRecipesCommand(const char* args);
        bool HandleLearnAllDefaultCommand(const char* args);
        bool HandleLearnAllLangCommand(const char* args);
        bool HandleLearnAllMyClassCommand(const char* args);
        bool HandleLearnAllMySpellsCommand(const char* args);
        bool HandleLearnAllMyTalentsCommand(const char* args);

        bool HandleListAurasCommand(const char * args);
        bool HandleListCreatureCommand(const char* args);
        bool HandleListItemCommand(const char* args);
        bool HandleListObjectCommand(const char* args);

        bool HandleLookupAreaCommand(const char* args);
        bool HandleLookupCreatureCommand(const char* args);
        bool HandleLookupEventCommand(const char* args);
        bool HandleLookupFactionCommand(const char * args);
        bool HandleLookupItemCommand(const char * args);
        bool HandleLookupItemSetCommand(const char * args);
        bool HandleLookupObjectCommand(const char* args);
        bool HandleLookupPlayerIpCommand(const char* args);
        bool HandleLookupPlayerIpListCommand(const char* args);
        bool HandleLookupPlayerAccountCommand(const char* args);
        bool HandleLookupPlayerEmailCommand(const char* args);
        bool HandleLookupQuestCommand(const char* args);
        bool HandleLookupSkillCommand(const char* args);
        bool HandleLookupSpellCommand(const char* args);
        bool HandleLookupTeleCommand(const char * args);

        bool HandleModifyKnownTitlesCommand(const char* args);
        bool HandleModifyHPCommand(const char* args);
        bool HandleModifyManaCommand(const char* args);
        bool HandleModifyRageCommand(const char* args);
        bool HandleModifyEnergyCommand(const char* args);
        bool HandleModifyMoneyCommand(const char* args);
        bool HandleModifyASpeedCommand(const char* args);
        bool HandleModifySpeedCommand(const char* args);
        bool HandleModifyBWalkCommand(const char* args);
        bool HandleModifyFlyCommand(const char* args);
        bool HandleModifySwimCommand(const char* args);
        bool HandleModifyScaleCommand(const char* args);
        bool HandleModifyMountCommand(const char* args);
        bool HandleModifyBitCommand(const char* args);
        bool HandleModifyFactionCommand(const char* args);
        bool HandleModifySpellCommand(const char* args);
        bool HandleModifyTalentCommand (const char* args);
        bool HandleModifyHonorCommand (const char* args);
        bool HandleModifyRepCommand(const char* args);
        bool HandleModifyArenaCommand(const char* args);
        bool HandleModifyGenderCommand(const char* args);

        bool HandleNpcAddCommand(const char* args);
        bool HandleNpcAddMoveCommand(const char* args);
        bool HandleNpcChangeEntryCommand(const char *args);
        bool HandleNpcDeleteCommand(const char* args);
        bool HandleNpcFactionIdCommand(const char* args);
        bool HandleNpcExtraFlagCommand(const char* args);
        bool HandleNpcFieldFlagCommand(const char* args);
        bool HandleNpcFlagCommand(const char* args);
        bool HandleNpcFollowCommand(const char* args);
        bool HandleNpcInfoCommand(const char* args);
        bool HandleNpcMoveCommand(const char* args);
        bool HandleNpcPlayEmoteCommand(const char* args);
        bool HandleNpcSayCommand(const char* args);
        bool HandleNpcSetModelCommand(const char* args);
        bool HandleNpcSetMoveTypeCommand(const char* args);
        bool HandleNpcSpawnDistCommand(const char* args);
        bool HandleNpcSpawnTimeCommand(const char* args);
        bool HandleNpcTameCommand(const char* args);
        bool HandleNpcTextEmoteCommand(const char* args);
        bool HandleNpcUnFollowCommand(const char* args);
        bool HandleNpcWhisperCommand(const char* args);
        bool HandleNpcYellCommand(const char* args);
        bool HandleNpcAddFormationCommand(const char* args);
        bool HandleNpcDeleteFormationCommand(const char* args);
        bool HandleNpcSetLinkCommand(const char* args);
        bool HandleNpcResetAICommand(const char* args);
        bool HandleNpcDoActionCommand(const char* args);
        bool HandleNpcEnterEvadeModeCommand(const char* args);

        bool HandleQuestAdd(const char * args);
        bool HandleQuestRemove(const char * args);
        bool HandleQuestComplete(const char * args);

        bool HandleReloadCommand(const char* args);
        bool HandleReloadAllCommand(const char* args);
        bool HandleReloadAllAreaCommand(const char* args);
        bool HandleReloadAllItemCommand(const char* args);
        bool HandleReloadAllLootCommand(const char* args);
        bool HandleReloadAllNpcCommand(const char* args);
        bool HandleReloadAllQuestCommand(const char* args);
        bool HandleReloadAllScriptsCommand(const char* args);
        bool HandleReloadAllSpellCommand(const char* args);
        bool HandleReloadAllLocalesCommand(const char* args);

        bool HandleReloadConfigCommand(const char* args);

        bool HandleReloadWpScriptsCommand(const char* args);
        bool HandleReloadAreaTriggerTavernCommand(const char* args);
        bool HandleReloadAreaTriggerTeleportCommand(const char* args);
        bool HandleReloadAccessRequirementCommand(const char* args);
        bool HandleReloadAutobroadcastCommand(const char* args);
        bool HandleReloadEventScriptsCommand(const char* args);
        bool HandleReloadCommandCommand(const char* args);
        bool HandleReloadCreatureQuestRelationsCommand(const char* args);
        bool HandleReloadCreatureQuestInvRelationsCommand(const char* args);
        bool HandleReloadCreatureLinkedRespawnCommand(const char* args);
        bool HandleReloadUnqueuedAccountListCommand(const char* args);
        bool HandleReloadDbScriptStringCommand(const char* args);
        bool HandleReloadGameGraveyardZoneCommand(const char* args);
        bool HandleReloadGameObjectScriptsCommand(const char* args);
        bool HandleReloadGameTeleCommand(const char* args);
        bool HandleReloadGMTicketCommand(const char*);
        bool HandleReloadGOQuestRelationsCommand(const char* args);
        bool HandleReloadGOQuestInvRelationsCommand(const char* args);
        bool HandleReloadLootTemplatesCreatureCommand(const char* args);
        bool HandleReloadLootTemplatesDisenchantCommand(const char* args);
        bool HandleReloadLootTemplatesFishingCommand(const char* args);
        bool HandleReloadLootTemplatesGameobjectCommand(const char* args);
        bool HandleReloadLootTemplatesItemCommand(const char* args);
        bool HandleReloadLootTemplatesPickpocketingCommand(const char* args);
        bool HandleReloadLootTemplatesProspectingCommand(const char* args);
        bool HandleReloadLootTemplatesReferenceCommand(const char* args);
        bool HandleReloadLootTemplatesQuestMailCommand(const char* args);
        bool HandleReloadLootTemplatesSkinningCommand(const char* args);
        bool HandleReloadLooking4groupStringCommand(const char* args);
        bool HandleReloadNpcGossipCommand(const char* args);
        bool HandleReloadNpcOptionCommand(const char* args);
        bool HandleReloadNpcTrainerCommand(const char* args);
        bool HandleReloadNpcVendorCommand(const char* args);
        bool HandleReloadQuestAreaTriggersCommand(const char* args);
        bool HandleReloadQuestEndScriptsCommand(const char* args);
        bool HandleReloadQuestStartScriptsCommand(const char* args);
        bool HandleReloadQuestTemplateCommand(const char* args);
        bool HandleReloadReservedNameCommand(const char*);
        bool HandleReloadReputationRewardRateCommand(const char* args);
        bool HandleReloadReputationSpilloverTemplateCommand(const char* args);
        bool HandleReloadSkillDiscoveryTemplateCommand(const char* args);
        bool HandleReloadSkillExtraItemTemplateCommand(const char* args);
        bool HandleReloadSkillFishingBaseLevelCommand(const char* args);
        bool HandleReloadSpellAffectCommand(const char* args);
        bool HandleReloadSpellRequiredCommand(const char* args);
        bool HandleReloadSpellElixirCommand(const char* args);
        bool HandleReloadSpellLearnSpellCommand(const char* args);
        bool HandleReloadSpellLinkedSpellCommand(const char* args);
        bool HandleReloadSpellProcEventCommand(const char* args);
        bool HandleReloadSpellEnchantDataCommand(const char*);
        bool HandleReloadSpellScriptTargetCommand(const char* args);
        bool HandleReloadEventAIScriptsCommand(const char* args);
        bool HandleReloadSpellScriptsCommand(const char* args);
        bool HandleReloadSpellTargetPositionCommand(const char* args);
        bool HandleReloadSpellThreatsCommand(const char* args);
        bool HandleReloadSpellPetAurasCommand(const char* args);
        bool HandleReloadSpellDisabledCommand(const char* args);
        bool HandleReloadPageTextsCommand(const char* args);
        bool HandleReloadItemEnchantementsCommand(const char* args);
        bool HandleReloadLocalesCreatureCommand(const char* args);
        bool HandleReloadLocalesGameobjectCommand(const char* args);
        bool HandleReloadLocalesItemCommand(const char* args);
        bool HandleReloadLocalesNpcTextCommand(const char* args);
        bool HandleReloadLocalesPageTextCommand(const char* args);
        bool HandleReloadLocalesQuestCommand(const char* args);
        bool HandleReloadAuctionsCommand(const char* args);
        bool HandleReloadEventAICommand(const char* args);

        bool HandleResetAllCommand(const char * args);
        bool HandleResetHonorCommand(const char * args);
        bool HandleResetLevelCommand(const char * args);
        bool HandleResetSpellsCommand(const char * args);
        bool HandleResetStatsCommand(const char * args);
        bool HandleResetTalentsCommand(const char * args);

        bool HandleSendItemsCommand(const char* args);
        bool HandleSendMailCommand(const char* args);
        bool HandleSendMessageCommand(const char * args);
        bool HandleSendMoneyCommand(const char* args);

        bool HandleServerCorpsesCommand(const char* args);
        bool HandleServerExitCommand(const char* args);
        bool HandleServerIdleRestartCommand(const char* args);
        bool HandleServerIdleShutDownCommand(const char* args);
        bool HandleServerInfoCommand(const char* args);
        bool HandleServerEventsCommand(const char* args);
        bool HandleServerMotdCommand(const char* args);
        bool HandleServerMuteCommand(const char* args);
        bool HandleServerRestartCommand(const char* args);
        bool HandleServerSetMotdCommand(const char* args);
        bool HandleServerSetLogLevelCommand(const char* args);
        bool HandleServerSetDiffTimeCommand(const char* args);
        bool HandleServerShutDownCommand(const char* args);
        bool HandleServerRollShutDownCommand(const char* args);
        bool HandleServerShutDownCancelCommand(const char* args);
        bool HandleServerPVPCommand(const char* args);

        bool HandleTeleCommand(const char * args);
        bool HandleTeleAddCommand(const char * args);
        bool HandleTeleDelCommand(const char * args);
        bool HandleTeleGroupCommand(const char* args);
        bool HandleTeleNameCommand(const char* args);

        bool HandleUnBanAccountCommand(const char* args);
        bool HandleUnBanCharacterCommand(const char* args);
        bool HandleUnBanIPCommand(const char* args);
        bool HandleUnBanEmailCommand(const char* args);

        bool HandleAddVIPAccountCommand(const char* args);
        bool HandleDelVIPAccountCommand(const char* args);

        bool HandleChangeAccountCommand(const char* args);

        bool HandleSetTitleCommand(const char* args);

        bool HandleWpAddCommand(const char* args);
        bool HandleWpEventCommand(const char* args);
        bool HandleWpLoadPathCommand(const char* args);
        bool HandleWpModifyCommand(const char* args);
        bool HandleWpReloadPath(const char *args);
        bool HandleWpShowCommand(const char* args);
        bool HandleWPToFileCommand(const char* args);
        bool HandleWpUnLoadPathCommand(const char* args);

        bool HandleHelpCommand(const char* args);
        bool HandleCommandsCommand(const char* args);
        bool HandleStartCommand(const char* args);
        bool HandleDismountCommand(const char* args);
        bool HandleSaveCommand(const char* args);

        bool HandleNamegoCommand(const char* args);
        bool HandleGonameCommand(const char* args);
        bool HandleGroupgoCommand(const char* args);
        bool HandleRecallCommand(const char* args);
        bool HandleAnnounceCommand(const char* args);
        bool HandleNameAnnounceCommand(const char* args);
        bool HandleNotifyCommand(const char* args);
        bool HandleGPSCommand(const char* args);
        bool HandleInfoCommand(const char* args);
        bool HandleTaxiCheatCommand(const char* args);
        bool HandleWhispersCommand(const char* args);
        bool HandleModifyDrunkCommand(const char* args);

        bool HandleLoadScriptsCommand(const char* args);

        bool HandleAddFormationCommand(const char* args);
        bool HandleRelocateCreatureCommand(const char *args);

        bool HandleGUIDCommand(const char* args);
        bool HandleNameCommand(const char* args);
        bool HandleSubNameCommand(const char* args);
        bool HandleItemMoveCommand(const char* args);
        bool HandleDeMorphCommand(const char* args);
        bool HandleNpcAddItemCommand(const char* args);
        bool HandleNpcDelItemCommand(const char* args);
        bool HandleNpcChangeLevelCommand(const char* args);
        bool HandleGoCreatureCommand(const char* args);
        bool HandleGoCreatureDirectCommand(const char* args);
        bool HandleGoObjectCommand(const char* args);
        bool HandleGoTicketCommand(const char* args);
        bool HandleGoTriggerCommand(const char* args);
        bool HandleGoGraveyardCommand(const char* args);
        bool HandlePInfoCommand(const char* args);
        bool HandlePLimitCommand(const char* args);
        bool HandleMuteCommand(const char* args);
        bool HandleUnmuteCommand(const char* args);
        bool HandleMuteInfoCommand(const char* args);
        bool HandleMovegensCommand(const char* args);
        bool HandleFreezeCommand(const char *args);
        bool HandleUnFreezeCommand(const char *args);
        bool HandleListFreezeCommand(const char* args);

        bool HandleCharacterDeleteCommand(const char* args);
        bool HandleGoXYCommand(const char* args);
        bool HandleGoXYZCommand(const char* args);
        bool HandleGoZoneXYCommand(const char* args);
        bool HandleGoGridCommand(const char* args);
        bool HandleAddWeaponCommand(const char* args);
        bool HandleAllowMovementCommand(const char* args);
        bool HandleGoCommand(const char* args);

        bool HandleCooldownCommand(const char* args);
        bool HandleUnLearnCommand(const char* args);
        bool HandleGetDistanceCommand(const char* args);
        bool HandleModifyStandStateCommand(const char* args);
        bool HandleDieCommand(const char* args);
        bool HandleDamageCommand(const char *args);
        bool HandleReviveCommand(const char* args);
        bool HandleReviveGroupCommand(const char* args);
        bool HandleModifyMorphCommand(const char* args);
        bool HandleAuraCommand(const char* args);
        bool HandleUnAuraCommand(const char* args);
        bool HandleLinkGraveCommand(const char* args);
        bool HandleNearGraveCommand(const char* args);
        bool HandleSpawnTransportCommand(const char* args);
        bool HandleExploreCheatCommand(const char* args);
        bool HandleHoverCommand(const char* args);
        bool HandleWaterwalkCommand(const char* args);
        bool HandleLevelUpCommand(const char* args);
        bool HandleShowAreaCommand(const char* args);
        bool HandleHideAreaCommand(const char* args);
        bool HandleAddItemCommand(const char* args);
        bool HandleAddItemSetCommand(const char* args);
        bool HandlePetTpCommand(const char* args);
        bool HandlePetUnlearnCommand(const char* args);
        bool HandlePetLearnCommand(const char* args);
        bool HandleCreatePetCommand(const char* args);

        //Group related
        bool HandleGroupLeaderCommand(const char* args);
        bool HandleGroupDisbandCommand(const char* args);
        bool HandleGroupRemoveCommand(const char* args);
        bool HandleGroupJoinCommand(const char* args);

        bool HandleBankCommand(const char* args);
        bool HandleShowLowLevelQuestCommand(const char* args);
        bool HandleChangeWeather(const char* args);
        bool HandleKickPlayerCommand(const char * args);
        bool HandleMentoringCommand(const char* args);
        bool HandleMentorCommand(const char* args);
        bool HandleMentorListCommand(const char* args);

        // accpremium commands
        bool HandleStopLevelCharacterCommand(const char* args);
        bool HandleActivateLevelCharacterCommand(const char* args);

        // GM ticket command handlers
        bool HandleGMTicketListCommand(const char* args);
        bool HandleGMTicketListOnlineCommand(const char* args);
        bool HandleGMTicketListClosedCommand(const char* args);
        bool HandleGMTicketGetByIdCommand(const char* args);
        bool HandleGMTicketGetByNameCommand(const char* args);
        bool HandleGMTicketCloseByIdCommand(const char* args);
        bool HandleGMTicketResponseCommand(const char* args);
        bool HandleGMTicketAssignToCommand(const char* args);
        bool HandleGMTicketUnAssignCommand(const char* args);
        bool HandleGMTicketCommentCommand(const char* args);
        bool HandleGMTicketDeleteByIdCommand(const char* args);
        bool HandleGMTicketHistoryCommand(const char* args);

        bool HandleMaxSkillCommand(const char* args);
        bool HandleSetSkillCommand(const char* args);
        bool HandlePasswordCommand(const char* args);
        bool HandleLockAccountCommand(const char* args);
        bool HandleRespawnCommand(const char* args);

        bool HandleRenameCommand(const char * args);
        bool HandleComeToMeCommand(const char *args);
        bool HandleCombatStopCommand(const char *args);
        bool HandleCharDeleteCommand(const char *args);
        bool HandleFlushArenaPointsCommand(const char *args);
        bool HandlePlayAllCommand(const char* args);
        bool HandleRepairitemsCommand(const char* args);

        bool HandleNpcAddTempCommand(const char* args);

        //! Development Commands
        bool HandleSet32Bit(const char* args);
        bool HandleDebugHostilRefList(const char * args);
        bool HandlePossessCommand(const char* args);
        bool HandleUnPossessCommand(const char* args);
        bool HandleBindSightCommand(const char* args);
        bool HandleUnbindSightCommand(const char* args);
        bool HandleGetPoolObjectStatsCommand(const char* args);

        bool HandleBindFollowCommand(const char* args);
        bool HandleUnbindFollowCommand(const char* args);

        bool HandleChannelListCommand(const char* args);
        bool HandleChannelPassCommand(const char* args);
        bool HandleChannelKickCommand(const char* args);
        bool HandleChannelMassKickCommand(const char* args);

        Player*   getSelectedPlayer();
        Creature* getSelectedCreature();
        Unit*     getSelectedUnit();
        char*     extractKeyFromLink(char* text, char const* linkType, char** something1 = NULL);
        char*     extractKeyFromLink(char* text, char const* const* linkTypes, int* found_idx, char** something1 = NULL);
        uint32    extractSpellIdFromLink(char* text);
        GameTele const* extractGameTeleFromLink(char* text);
        bool GetPlayerGroupAndGUIDByName(const char* cname, Player* &plr, Group* &group, uint64 &guid, bool offline = false);

        GameObject* GetObjectGlobalyWithGuidOrNearWithDbGuid(uint32 lowguid,uint32 entry);

        // Utility methods for commands
        bool LookupPlayerSearchCommand(QueryResultAutoPtr result, int32 limit);
        bool HandleBanListHelper(QueryResultAutoPtr result);
        bool HandleBanHelper(BanMode mode,char const* args);
        bool HandleBanInfoHelper(uint32 accountid, char const* accountname);
        bool HandleUnBanHelper(BanMode mode,char const* args);

        void ShowItemListHelper(uint32 itemId, int loc_idx);//, Player* target = NULL);

        void SetSentErrorMessage(bool val){ sentErrorMessage = val;};
    private:
        WorldSession * m_session;                           // != NULL for chat command call and NULL for CLI command

        // common global flag
        static bool load_command_table;
        bool sentErrorMessage;
};

class CliHandler : public ChatHandler
{
    public:
        typedef void Print(char const*);
        explicit CliHandler(Print* zprint) : m_print(zprint) {}

        // overwrite functions
        const char *GetTrinityString(int32 entry) const;
        bool isAvailable(ChatCommand const& cmd) const;
        void SendSysMessage(const char *str);
        char const* GetName() const;
        bool needReportToTarget(Player* chr) const;

    private:
        Print* m_print;
};

char const *fmtstring(char const *format, ...);

#endif

