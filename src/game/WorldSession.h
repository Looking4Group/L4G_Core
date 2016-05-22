/*
 * Copyright (C) 2005-2011 MaNGOS <http://getmangos.com/>
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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/// \addtogroup u2w
/// @{
/// \file

#ifndef __WORLDSESSION_H
#define __WORLDSESSION_H

#include "Common.h"
#include "Log.h"
#include "SharedDefines.h"
#include "QueryResult.h"
#include "AuctionHouseMgr.h"
#include "WardenBase.h"
#include "Item.h"

struct ItemPrototype;
struct AuctionEntry;
struct AuctionHouseEntry;
struct DeclinedName;

class ObjectGuid;
class Creature;
class Item;
class Object;
class Player;
class Unit;
class WorldPacket;
class WorldSocket;
class QueryResult;
class LoginQueryHolder;
class CharacterHandler;
class MovementInfo;

struct OpcodeHandler;

//enum Opcodes;

#define CHECK_PACKET_SIZE(P,S) if ((P).size() < (S)) return SizeError((P),(S));

enum OpcodeDisabled
{
    OPC_DISABLE_WEATHER  = 0x01
};

enum AccountFlags
{
    ACC_SPECIAL_LOG         = 0x0001,   // all incoming/outgoing trade/mails/auctions etc. are logged to file
    ACC_WHISPER_LOG         = 0x0002,   // all incoming and outgoing whispers are logged o file
    ACC_DISABLED_GANN       = 0x0004,   // account flagged with this won't display messages related to guild announces system
    ACC_BLIZZLIKE_RATES     = 0x0008,   // enables fully blizzlike rates for account. ex: XP, QXP etc
    ACC_HIDE_BONES          = 0x0010,   // client won't show bones created from corpses
    ACC_DISABLED_BGANN      = 0x0020,   // BG start announce will be disabled for this account
    ACC_DISABLED_BROADCAST  = 0x0040,   // Broadcast accounces will be disabled for this account
    ACC_CUSTOM_XP_RATE_3    = 0x0080    // enables 3x blizzlike rates for account. ex: XP, QXP etc
};

enum PartyOperation
{
    PARTY_OP_INVITE = 0,
    PARTY_OP_LEAVE = 2
};

enum PartyResult
{
    PARTY_RESULT_OK                   = 0,
    PARTY_RESULT_CANT_FIND_TARGET     = 1,
    PARTY_RESULT_NOT_IN_YOUR_PARTY    = 2,
    PARTY_RESULT_NOT_IN_YOUR_INSTANCE = 3,
    PARTY_RESULT_PARTY_FULL           = 4,
    PARTY_RESULT_ALREADY_IN_GROUP     = 5,
    PARTY_RESULT_YOU_NOT_IN_GROUP     = 6,
    PARTY_RESULT_YOU_NOT_LEADER       = 7,
    PARTY_RESULT_TARGET_UNFRIENDLY    = 8,
    PARTY_RESULT_TARGET_IGNORE_YOU    = 9,
    PARTY_RESULT_INVITE_RESTRICTED    = 13
};

enum OvertimeMethod
{
    OVERTIME_NONE   = 0,
    OVERTIME_LOG    = 1,
    OVERTIME_KICK   = 2,
    OVERTIME_ACCBAN = 3,
    OVERTIME_IPBAN  = 4
};

//class to deal with packet processing
//allows to determine if next packet is safe to be processed
class PacketFilter
{
public:
    explicit PacketFilter(WorldSession * pSession) : m_pSession(pSession) {}
    virtual ~PacketFilter() {}

    virtual bool Process(WorldPacket * packet) = 0;
    virtual bool ProcessLogout() const  = 0;
    virtual bool ProcessTimersUpdate() const = 0;
    virtual bool ProcessWardenUpdate() const = 0;

protected:
    WorldSession * const m_pSession;
};

//process only thread-safe packets in Map::Update()
class MapSessionFilter : public PacketFilter
{
    public:
        explicit MapSessionFilter(WorldSession * pSession) : PacketFilter(pSession) {}
        ~MapSessionFilter() {}

        bool Process(WorldPacket * packet);
        //in Map::Update() we do not process player logout!
        bool ProcessLogout() const { return false; }
        bool ProcessTimersUpdate() const { return false; }
        bool ProcessWardenUpdate() const { return false; }
};

//class used to filer only thread-unsafe packets from queue
//in order to update only be used in World::UpdateSessions()
class WorldSessionFilter : public PacketFilter
{
    public:
        explicit WorldSessionFilter(WorldSession * pSession) : PacketFilter(pSession) {}
        ~WorldSessionFilter() {}

        virtual bool Process(WorldPacket* packet);
        bool ProcessLogout() const { return true; }
        bool ProcessTimersUpdate() const { return true; }
        bool ProcessWardenUpdate() const { return true; }
};

/// Player session in the World
class LOOKING4GROUP_IMPORT_EXPORT WorldSession
{
    friend class CharacterHandler;
    public:
        WorldSession(uint32 id, WorldSocket *sock, uint64 permissions, uint8 expansion, LocaleConstant locale, time_t mute_time = 0, std::string mute_reason = "", uint64 accFlags = 0, uint16 opcDisabled = 0);
        ~WorldSession();

        bool PlayerLoading() const { return m_playerLoading; }
        bool PlayerLogout() const { return m_playerLogout; }
        bool PlayerLogoutWithSave() const { return m_playerLogout && m_playerSave; }

        void SizeError(WorldPacket const& packet, uint32 size) const;

        void SendPacket(WorldPacket const* packet);
        void SendNotification(const char *format,...) ATTR_PRINTF(2,3);
        void SendNotification(int32 string_id,...);
        void SendPetNameInvalid(uint32 error, const std::string& name, DeclinedName *declinedName);
        void SendLfgResult(uint32 type, uint32 entry, uint8 lfg_type);
        void SendLFM(uint32 type, uint32 entry);
        void SendLFG(uint32 type, uint32 entry);
        void SendUpdateLFG();
        void SendUpdateLFM();
        void SendLFGDisabled();
        void SendPartyResult(PartyOperation operation, const std::string& member, PartyResult res);
        void SendAreaTriggerMessage(const char* Text, ...) ATTR_PRINTF(2,3);

        uint32 RecordSessionTimeDiff(const char *text, ...);
        uint32 RecordVerboseTimeDiff(bool reset);

        uint64 GetPermissions() const { return m_permissions; }
        bool HasPermissions(uint64 perms) const { return m_permissions & perms; }
        uint32 GetAccountId() const { return _accountId; }
        Player* GetPlayer() const { return _player; }
        char const* GetPlayerName() const;
        void SetSecurity(uint64 permissions) { m_permissions = permissions; }
        std::string const& GetRemoteAddress() { return m_Address; }
        void SetPlayer(Player *plr) { _player = plr; }
        uint8 Expansion() const { return m_expansion; }

        void SaveAccountFlags();
        static void SaveAccountFlags(uint32 accountId, uint64 flags);

        bool IsAccountFlagged(AccountFlags flag) const { return m_accFlags & flag; }
        void AddAccountFlag(AccountFlags flag);
        void RemoveAccountFlag(AccountFlags flag);

        void SaveOpcodesDisableFlags();
        void AddOpcodeDisableFlag(uint16 flag);
        void RemoveOpcodeDisableFlag(uint16 flag);
        uint16 GetOpcodesDisabledFlag() { return m_opcodesDisabled;}

        void InitWarden(BigNumber *K, uint8& OperatingSystem);

        /// Session in auth.queue currently
        void SetInQueue(bool state) { m_inQueue = state; }

        /// Is the user engaged in a log out process?
        bool isLogingOut() const { return _logoutTime || m_playerLogout; }

        /// Engage the logout process for the user
        void LogoutRequest(time_t requestTime)
        {
            _logoutTime = requestTime;
        }

        /// Is logout cooldown expired?
        bool ShouldLogOut(time_t currTime) const
        {
            return (_logoutTime > 0 && currTime >= _logoutTime + 20);
        }

        void LogoutPlayer(bool Save);
        void KickPlayer();

        void QueuePacket(WorldPacket* new_packet);
        void ProcessPacket(WorldPacket* packet);
        bool Update(uint32 diff, PacketFilter& updater);

        /// Handle the authentication waiting queue (to be completed)
        void SendAuthWaitQue(uint32 position);

        //void SendTestCreatureQueryOpcode(uint32 entry, uint64 guid, uint32 testvalue);
        void SendNameQueryOpcode(Player* p);
        void SendNameQueryOpcodeFromDB(uint64 guid);
        static void SendNameQueryOpcodeFromDBCallBack(QueryResultAutoPtr result, uint32 accountId);

        void SendTrainerList(uint64 guid);
        void SendTrainerList(uint64 guid, const std::string& strTitle);
        void SendListInventory(uint64 guid);
        void SendShowBank(uint64 guid);
        void SendTabardVendorActivate(uint64 guid);
        void SendSpiritResurrect();
        void SendBindPoint(Creature* npc);
        void SendGMTicketGetTicket(uint32 status, char const* text);

        void SendAttackStop(Unit const* enemy);

        void SendBattlegGroundList(ObjectGuid guid, BattleGroundTypeId bgTypeId);

        void SendTradeStatus(uint32 status);
        void SendCancelTrade();

        void SendStablePet(uint64 guid);
        void SendPetitionQueryOpcode(uint64 petitionguid);
        void SendUpdateTrade();

        //pet
        void SendPetNameQuery(uint64 guid, uint32 petnumber);

        bool SendItemInfo(uint32 itemid, WorldPacket data);

        // External Mail
        static void SendExternalMails();
        TimeTrackerSmall _mailSendTimer;

        //auction
        void SendAuctionHello(Unit *unit);
        void SendAuctionCommandResult(AuctionEntry *auc, AuctionAction Action, AuctionError ErrorCode, InventoryResult invError = EQUIP_ERR_OK);
        void SendAuctionBidderNotification(AuctionEntry *auction, bool won);
        void SendAuctionOwnerNotification(AuctionEntry *auction, bool sold);
        void SendAuctionRemovedNotification(AuctionEntry* auction);
        static void SendAuctionOutbiddedMail(AuctionEntry *auction);
        void SendAuctionCancelledToBidderMail(AuctionEntry *auction);
        void BuildListAuctionItems(std::vector<AuctionEntry*> const& auctions, WorldPacket& data, std::wstring const& searchedname, uint32 listfrom, uint32 levelmin,
            uint32 levelmax, uint32 usable, uint32 inventoryType, uint32 itemClass, uint32 itemSubClass, uint32 quality, uint32& count, uint32& totalcount, bool isFull);
        void BuildListAuctionItems(AuctionHouseObject::AuctionEntryMap const& auctions, WorldPacket& data, std::wstring const& searchedname, uint32 listfrom, uint32 levelmin,
            uint32 levelmax, uint32 usable, uint32 inventoryType, uint32 itemClass, uint32 itemSubClass, uint32 quality, uint32& count, uint32& totalcount, bool isFull);

        AuctionHouseEntry const* GetCheckedAuctionHouseForAuctioneer(ObjectGuid guid);

        //Item Enchantment
        void SendEnchantmentLog(uint64 Target, uint64 Caster,uint32 ItemID,uint32 SpellID);
        void SendItemEnchantTimeUpdate(uint64 Playerguid, uint64 Itemguid,uint32 slot,uint32 Duration);

        //Taxi
        void SendTaxiStatus(uint64 guid);
        void SendTaxiMenu(Creature* unit);
        void SendDoFlight(uint16 MountId, uint32 path, uint32 pathNode = 0);
        bool SendLearnNewTaxiNode(Creature* unit);

        // Guild/Arena Team
        void SendGuildCommandResult(uint32 typecmd, const std::string& str, uint32 cmdresult);
        void SendArenaTeamCommandResult(uint32 team_action, const std::string& team, const std::string& player, uint32 error_id);
        void BuildArenaTeamEventPacket(WorldPacket *data, uint8 eventid, uint8 str_count, const std::string& str1, const std::string& str2, const std::string& str3);
        void SendNotInArenaTeamPacket(uint8 type);
        void SendPetitionShowList(uint64 guid);
        void SendSaveGuildEmblem(uint32 msg);
        void SendBattleGroundOrArenaJoinError(uint8 err);

        // Looking For Group
        // TRUE values set by client sending CMSG_LFG_SET_AUTOJOIN and CMSG_LFM_CLEAR_AUTOFILL before player login
        bool LookingForGroup_auto_join;
        bool LookingForGroup_auto_add;

        void BuildPartyMemberStatsChangedPacket(Player *player, WorldPacket *data);

        void DoLootRelease(uint64 lguid);

        // Account mute time
        time_t m_muteTime;
        std::string m_muteReason;

        // Locales
        LocaleConstant GetSessionDbcLocale() const { return m_sessionDbcLocale; }
        int GetSessionDbLocaleIndex() const { return m_sessionDbLocaleIndex; }
        const char *GetTrinityString(int32 entry) const;

        uint32 GetLatency() const { return m_latency; }
        void SetLatency(uint32 latency) { m_latency = latency; }
        uint32 getDialogStatus(Player *pPlayer, Object* questgiver, uint32 defstatus);

    public:                                                 // opcodes handlers

        void Handle_NULL(WorldPacket& recvPacket);          // not used
        void Handle_EarlyProccess(WorldPacket& recvPacket);// just mark packets processed in WorldSocket::OnRead
        void Handle_ServerSide(WorldPacket& recvPacket);    // sever side only, can't be accepted from client
        void Handle_Deprecated(WorldPacket& recvPacket);    // never used anymore by client

        void HandleCharEnumOpcode(WorldPacket& recvPacket);
        void HandleCharDeleteOpcode(WorldPacket& recvPacket);
        void HandleCharCreateOpcode(WorldPacket& recvPacket);
        void HandlePlayerLoginOpcode(WorldPacket& recvPacket);
        void HandleCharEnum(QueryResultAutoPtr result);
        void HandlePlayerLogin(LoginQueryHolder * holder);

        // played time
        void HandlePlayedTime(WorldPacket& recvPacket);

        // new
        void HandleMoveUnRootAck(WorldPacket& recvPacket);
        void HandleMoveRootAck(WorldPacket& recvPacket);
        void HandleLookingForGroup(WorldPacket& recvPacket);

        // new inspect
        void HandleInspectOpcode(WorldPacket& recvPacket);

        // new party stats
        void HandleInspectHonorStatsOpcode(WorldPacket& recvPacket);

        void HandleMoveWaterWalkAck(WorldPacket& recvPacket);
        void HandleFeatherFallAck(WorldPacket &recv_data);

        void HandleMoveHoverAck(WorldPacket & recv_data);

        void HandleMountSpecialAnimOpcode(WorldPacket &recvdata);

        // character view
        void HandleToggleHelmOpcode(WorldPacket& recv_data);
        void HandleToggleCloakOpcode(WorldPacket& recv_data);

        // repair
        void HandleRepairItemOpcode(WorldPacket& recvPacket);

        // Knockback
        void HandleMoveKnockBackAck(WorldPacket& recvPacket);

        void HandleMoveTeleportAck(WorldPacket& recvPacket);
        void HandleForceSpeedChangeAck(WorldPacket & recv_data);

        void HandlePingOpcode(WorldPacket& recvPacket);
        void HandleAuthSessionOpcode(WorldPacket& recvPacket);
        void HandleRepopRequestOpcode(WorldPacket& recvPacket);
        void HandleAutostoreLootItemOpcode(WorldPacket& recvPacket);
        void HandleLootMoneyOpcode(WorldPacket& recvPacket);
        void HandleLootOpcode(WorldPacket& recvPacket);
        void HandleLootReleaseOpcode(WorldPacket& recvPacket);
        void HandleLootMasterGiveOpcode(WorldPacket& recvPacket);
        void HandleWhoOpcode(WorldPacket& recvPacket);
        void HandleLogoutRequestOpcode(WorldPacket& recvPacket);
        void HandlePlayerLogoutOpcode(WorldPacket& recvPacket);
        void HandleLogoutCancelOpcode(WorldPacket& recvPacket);

        // GM Ticket opcodes
         void HandleGMTicketCreateOpcode(WorldPacket& recvPacket);
         void HandleGMTicketUpdateOpcode(WorldPacket& recvPacket);
         void HandleGMTicketDeleteOpcode(WorldPacket& recvPacket);
         void HandleGMTicketGetTicketOpcode(WorldPacket& recvPacket);
         void HandleGMTicketSystemStatusOpcode(WorldPacket& recvPacket);

        //void HandleGMSurveySubmit(WorldPacket& recvPacket);

        void HandleTogglePvP(WorldPacket& recvPacket);

        void HandleZoneUpdateOpcode(WorldPacket& recvPacket);
        void HandleSetTargetOpcode(WorldPacket& recvPacket);
        void HandleSetSelectionOpcode(WorldPacket& recvPacket);
        void HandleStandStateChangeOpcode(WorldPacket& recvPacket);
        void HandleEmoteOpcode(WorldPacket& recvPacket);
        void HandleFriendListOpcode(WorldPacket& recvPacket);
        void HandleAddFriendOpcode(WorldPacket& recvPacket);
        static void HandleAddFriendOpcodeCallBack(QueryResultAutoPtr result, uint32 accountId, std::string friendNote);
        void HandleDelFriendOpcode(WorldPacket& recvPacket);
        void HandleAddIgnoreOpcode(WorldPacket& recvPacket);
        static void HandleAddIgnoreOpcodeCallBack(QueryResultAutoPtr result, uint32 accountId);
        void HandleDelIgnoreOpcode(WorldPacket& recvPacket);
        void HandleSetFriendNoteOpcode(WorldPacket& recvPacket);
        void HandleBugOpcode(WorldPacket& recvPacket);
        void HandleSetAmmoOpcode(WorldPacket& recvPacket);
        void HandleItemNameQueryOpcode(WorldPacket& recvPacket);

        void HandleAreaTriggerOpcode(WorldPacket& recvPacket);

        void HandleSetFactionAtWar(WorldPacket & recv_data);
        void HandleSetWatchedFactionIndexOpcode(WorldPacket & recv_data);
        void HandleSetWatchedFactionInactiveOpcode(WorldPacket & recv_data);

        void HandleUpdateAccountData(WorldPacket& recvPacket);
        void HandleRequestAccountData(WorldPacket& recvPacket);
        void HandleSetActionButtonOpcode(WorldPacket& recvPacket);

        void HandleGameObjectUseOpcode(WorldPacket& recPacket);
        void HandleMeetingStoneInfo(WorldPacket& recPacket);

        void HandleNameQueryOpcode(WorldPacket& recvPacket);

        void HandleQueryTimeOpcode(WorldPacket& recvPacket);

        void HandleCreatureQueryOpcode(WorldPacket& recvPacket);

        void HandleGameObjectQueryOpcode(WorldPacket& recvPacket);

        void HandleMoveWorldportAckOpcode(WorldPacket& recvPacket);
        void HandleMoveWorldportAckOpcode();                // for server-side calls

        void HandleMovementOpcodes(WorldPacket& recvPacket);
        void HandleMoverRelocation(MovementInfo&);

        void HandleSetActiveMoverOpcode(WorldPacket &recv_data);
        void HandleMoveNotActiveMoverOpcode(WorldPacket &recv_data);
        void HandleMoveTimeSkippedOpcode(WorldPacket &recv_data);

        void HandleRequestRaidInfoOpcode(WorldPacket & recv_data);

        void HandleBattlefieldStatusOpcode(WorldPacket &recv_data);
        void HandleBattleMasterHelloOpcode(WorldPacket &recv_data);

        void HandleGroupInviteOpcode(WorldPacket& recvPacket);
        //void HandleGroupCancelOpcode(WorldPacket& recvPacket);
        void HandleGroupAcceptOpcode(WorldPacket& recvPacket);
        void HandleGroupDeclineOpcode(WorldPacket& recvPacket);
        void HandleGroupUninviteNameOpcode(WorldPacket& recvPacket);
        void HandleGroupUninviteGuidOpcode(WorldPacket& recvPacket);
        void HandleGroupSetLeaderOpcode(WorldPacket& recvPacket);
        void HandleGroupLeaveOpcode(WorldPacket& recvPacket);
        void HandleGroupPassOnLootOpcode(WorldPacket &recv_data);
        void HandleLootMethodOpcode(WorldPacket& recvPacket);
        void HandleLootRoll(WorldPacket &recv_data);
        void HandleRequestPartyMemberStatsOpcode(WorldPacket &recv_data);
        void HandleRaidIconTargetOpcode(WorldPacket & recv_data);
        void HandleRaidReadyCheckOpcode(WorldPacket & recv_data);
        void HandleRaidReadyCheckFinishOpcode(WorldPacket & recv_data);
        void HandleRaidConvertOpcode(WorldPacket & recv_data);
        void HandleGroupChangeSubGroupOpcode(WorldPacket & recv_data);
        void HandleGroupAssistantOpcode(WorldPacket & recv_data);
        void HandleGroupPromoteOpcode(WorldPacket & recv_data);

        void HandlePetitionBuyOpcode(WorldPacket& recv_data);
        void HandlePetitionShowSignOpcode(WorldPacket& recv_data);
        void HandlePetitionQueryOpcode(WorldPacket& recv_data);
        void HandlePetitionRenameOpcode(WorldPacket& recv_data);
        void HandlePetitionSignOpcode(WorldPacket& recv_data);
        void HandlePetitionDeclineOpcode(WorldPacket& recv_data);
        void HandleOfferPetitionOpcode(WorldPacket& recv_data);
        void HandleTurnInPetitionOpcode(WorldPacket& recv_data);

        void HandleGuildQueryOpcode(WorldPacket& recvPacket);
        void HandleGuildCreateOpcode(WorldPacket& recvPacket);
        void HandleGuildInviteOpcode(WorldPacket& recvPacket);
        void HandleGuildRemoveOpcode(WorldPacket& recvPacket);
        void HandleGuildAcceptOpcode(WorldPacket& recvPacket);
        void HandleGuildDeclineOpcode(WorldPacket& recvPacket);
        void HandleGuildInfoOpcode(WorldPacket& recvPacket);
        void HandleGuildEventLogOpcode(WorldPacket& recvPacket);
        void HandleGuildRosterOpcode(WorldPacket& recvPacket);
        void HandleGuildPromoteOpcode(WorldPacket& recvPacket);
        void HandleGuildDemoteOpcode(WorldPacket& recvPacket);
        void HandleGuildLeaveOpcode(WorldPacket& recvPacket);
        void HandleGuildDisbandOpcode(WorldPacket& recvPacket);
        void HandleGuildLeaderOpcode(WorldPacket& recvPacket);
        void HandleGuildMOTDOpcode(WorldPacket& recvPacket);
        void HandleGuildSetPublicNoteOpcode(WorldPacket& recvPacket);
        void HandleGuildSetOfficerNoteOpcode(WorldPacket& recvPacket);
        void HandleGuildRankOpcode(WorldPacket& recvPacket);
        void HandleGuildAddRankOpcode(WorldPacket& recvPacket);
        void HandleGuildDelRankOpcode(WorldPacket& recvPacket);
        void HandleGuildChangeInfoOpcode(WorldPacket& recvPacket);
        void HandleGuildSaveEmblemOpcode(WorldPacket& recvPacket);

        void HandleTaxiNodeStatusQueryOpcode(WorldPacket& recvPacket);
        void HandleTaxiQueryAvailableNodes(WorldPacket& recvPacket);
        void HandleActivateTaxiOpcode(WorldPacket& recvPacket);
        void HandleActivateTaxiFarOpcode(WorldPacket& recvPacket);
        void HandleMoveSplineDoneOpcode(WorldPacket& recvPacket);

        void HandleTabardVendorActivateOpcode(WorldPacket& recvPacket);
        void HandleBankerActivateOpcode(WorldPacket& recvPacket);
        void HandleBuyBankSlotOpcode(WorldPacket& recvPacket);
        void HandleTrainerListOpcode(WorldPacket& recvPacket);
        void HandleTrainerBuySpellOpcode(WorldPacket& recvPacket);
        void HandlePetitionShowListOpcode(WorldPacket& recvPacket);
        void HandleGossipHelloOpcode(WorldPacket& recvPacket);
        void HandleGossipSelectOptionOpcode(WorldPacket& recvPacket);
        void HandleSpiritHealerActivateOpcode(WorldPacket& recvPacket);
        void HandleNpcTextQueryOpcode(WorldPacket& recvPacket);
        void HandleBinderActivateOpcode(WorldPacket& recvPacket);
        void HandleListStabledPetsOpcode(WorldPacket& recvPacket);
        void HandleStablePet(WorldPacket& recvPacket);
        void HandleUnstablePet(WorldPacket& recvPacket);
        void HandleBuyStableSlot(WorldPacket& recvPacket);
        void HandleStableRevivePet(WorldPacket& recvPacket);
        void HandleStableSwapPet(WorldPacket& recvPacket);

        void HandleDuelAcceptedOpcode(WorldPacket& recvPacket);
        void HandleDuelCancelledOpcode(WorldPacket& recvPacket);

        void HandleAcceptTradeOpcode(WorldPacket& recvPacket);
        void HandleBeginTradeOpcode(WorldPacket& recvPacket);
        void HandleBusyTradeOpcode(WorldPacket& recvPacket);
        void HandleCancelTradeOpcode(WorldPacket& recvPacket);
        void HandleClearTradeItemOpcode(WorldPacket& recvPacket);
        void HandleIgnoreTradeOpcode(WorldPacket& recvPacket);
        void HandleInitiateTradeOpcode(WorldPacket& recvPacket);
        void HandleSetTradeGoldOpcode(WorldPacket& recvPacket);
        void HandleSetTradeItemOpcode(WorldPacket& recvPacket);
        void HandleUnacceptTradeOpcode(WorldPacket& recvPacket);

        void HandleAuctionHelloOpcode(WorldPacket& recvPacket);
        void HandleAuctionListItems(WorldPacket & recv_data);
        void HandleAuctionListBidderItems(WorldPacket & recv_data);
        void HandleAuctionSellItem(WorldPacket & recv_data);
        void HandleAuctionRemoveItem(WorldPacket & recv_data);
        void HandleAuctionListOwnerItems(WorldPacket & recv_data);
        void HandleAuctionPlaceBid(WorldPacket & recv_data);

        void HandleGetMail(WorldPacket & recv_data);
        void HandleSendMail(WorldPacket & recv_data);
        void HandleTakeMoney(WorldPacket & recv_data);
        void HandleTakeItem(WorldPacket & recv_data);
        void HandleMarkAsRead(WorldPacket & recv_data);
        void HandleReturnToSender(WorldPacket & recv_data);
        void HandleMailDelete(WorldPacket & recv_data);
        void HandleItemTextQuery(WorldPacket & recv_data);
        void HandleMailCreateTextItem(WorldPacket & recv_data);
        void HandleMsgQueryNextMailtime(WorldPacket & recv_data);
        void HandleCancelChanneling(WorldPacket & recv_data);

        void SendItemPageInfo(ItemPrototype *itemProto);
        void HandleSplitItemOpcode(WorldPacket& recvPacket);
        void HandleSwapInvItemOpcode(WorldPacket& recvPacket);
        void HandleDestroyItemOpcode(WorldPacket& recvPacket);
        void HandleAutoEquipItemOpcode(WorldPacket& recvPacket);
        void HandleItemQuerySingleOpcode(WorldPacket& recvPacket);
        void HandleSellItemOpcode(WorldPacket& recvPacket);
        void HandleBuyItemInSlotOpcode(WorldPacket& recvPacket);
        void HandleBuyItemOpcode(WorldPacket& recvPacket);
        void HandleListInventoryOpcode(WorldPacket& recvPacket);
        void HandleAutoStoreBagItemOpcode(WorldPacket& recvPacket);
        void HandleReadItem(WorldPacket& recvPacket);
        void HandleAutoEquipItemSlotOpcode(WorldPacket & recvPacket);
        void HandleSwapItem(WorldPacket & recvPacket);
        void HandleBuybackItem(WorldPacket & recvPacket);
        void HandleAutoBankItemOpcode(WorldPacket& recvPacket);
        void HandleAutoStoreBankItemOpcode(WorldPacket& recvPacket);
        void HandleWrapItemOpcode(WorldPacket& recvPacket);

        void HandleAttackSwingOpcode(WorldPacket& recvPacket);
        void HandleAttackStopOpcode(WorldPacket& recvPacket);
        void HandleSetSheathedOpcode(WorldPacket& recvPacket);

        void HandleUseItemOpcode(WorldPacket& recvPacket);
        void HandleOpenItemOpcode(WorldPacket& recvPacket);
        void HandleCastSpellOpcode(WorldPacket& recvPacket);
        void HandleCancelCastOpcode(WorldPacket& recvPacket);
        void HandleCancelAuraOpcode(WorldPacket& recvPacket);
        void HandleCancelGrowthAuraOpcode(WorldPacket& recvPacket);
        void HandleCancelAutoRepeatSpellOpcode(WorldPacket& recvPacket);

        void HandleLearnTalentOpcode(WorldPacket& recvPacket);
        void HandleTalentWipeOpcode(WorldPacket& recvPacket);
        void HandleUnlearnSkillOpcode(WorldPacket& recvPacket);

        void HandleQuestgiverStatusQueryOpcode(WorldPacket& recvPacket);
        void HandleQuestgiverStatusQueryMultipleOpcode(WorldPacket& recvPacket);
        void HandleQuestgiverHelloOpcode(WorldPacket& recvPacket);
        void HandleQuestgiverAcceptQuestOpcode(WorldPacket& recvPacket);
        void HandleQuestgiverQuestQueryOpcode(WorldPacket& recvPacket);
        void HandleQuestgiverChooseRewardOpcode(WorldPacket& recvPacket);
        void HandleQuestgiverRequestRewardOpcode(WorldPacket& recvPacket);
        void HandleQuestQueryOpcode(WorldPacket& recvPacket);
        void HandleQuestgiverCancel(WorldPacket& recv_data);
        void HandleQuestLogSwapQuest(WorldPacket& recv_data);
        void HandleQuestLogRemoveQuest(WorldPacket& recv_data);
        void HandleQuestConfirmAccept(WorldPacket& recv_data);
        void HandleQuestComplete(WorldPacket& recv_data);
        void HandleQuestAutoLaunch(WorldPacket& recvPacket);
        void HandleQuestPushToParty(WorldPacket& recvPacket);
        void HandleQuestPushResult(WorldPacket& recvPacket);

        void HandleMessagechatOpcode(WorldPacket& recvPacket);
        void HandleTextEmoteOpcode(WorldPacket& recvPacket);
        void HandleChatIgnoredOpcode(WorldPacket& recvPacket);

        void HandleCorpseReclaimOpcode(WorldPacket& recvPacket);
        void HandleCorpseQueryOpcode(WorldPacket& recvPacket);
        void HandleResurrectResponseOpcode(WorldPacket& recvPacket);
        void HandleSummonResponseOpcode(WorldPacket& recv_data);

        void HandleChannelJoin(WorldPacket& recvPacket);
        void HandleChannelLeave(WorldPacket& recvPacket);
        void HandleChannelList(WorldPacket& recvPacket);
        void HandleChannelPassword(WorldPacket& recvPacket);
        void HandleChannelSetOwner(WorldPacket& recvPacket);
        void HandleChannelOwner(WorldPacket& recvPacket);
        void HandleChannelModerator(WorldPacket& recvPacket);
        void HandleChannelUnmoderator(WorldPacket& recvPacket);
        void HandleChannelMute(WorldPacket& recvPacket);
        void HandleChannelUnmute(WorldPacket& recvPacket);
        void HandleChannelInvite(WorldPacket& recvPacket);
        void HandleChannelKick(WorldPacket& recvPacket);
        void HandleChannelBan(WorldPacket& recvPacket);
        void HandleChannelUnban(WorldPacket& recvPacket);
        void HandleChannelAnnounce(WorldPacket& recvPacket);
        void HandleChannelModerate(WorldPacket& recvPacket);
        void HandleChannelRosterQuery(WorldPacket& recvPacket);
        void HandleChannelInfoQuery(WorldPacket& recvPacket);
        void HandleChannelJoinNotify(WorldPacket& recvPacket);
        void HandleChannelDeclineInvite(WorldPacket& recvPacket);

        void HandleCompleteCinema(WorldPacket& recvPacket);
        void HandleNextCinematicCamera(WorldPacket& recvPacket);

        void HandlePageQuerySkippedOpcode(WorldPacket& recvPacket);
        void HandlePageQueryOpcode(WorldPacket& recvPacket);

        void HandleTutorialFlag (WorldPacket & recv_data);
        void HandleTutorialClear(WorldPacket & recv_data);
        void HandleTutorialReset(WorldPacket & recv_data);

        //Pet
        void HandlePetAction(WorldPacket & recv_data);
        void HandlePetNameQuery(WorldPacket & recv_data);
        void HandlePetSetAction(WorldPacket & recv_data);
        void HandlePetAbandon(WorldPacket & recv_data);
        void HandlePetRename(WorldPacket & recv_data);
        void HandlePetCancelAuraOpcode(WorldPacket& recvPacket);
        void HandlePetUnlearnOpcode(WorldPacket& recvPacket);
        void HandlePetSpellAutocastOpcode(WorldPacket& recvPacket);
        void HandlePetCastSpellOpcode(WorldPacket& recvPacket);

        void HandleSetActionBar(WorldPacket& recv_data);

        void HandleChangePlayerNameOpcode(WorldPacket& recv_data);
        static void HandleChangePlayerNameOpcodeCallBack(QueryResultAutoPtr result, uint32 accountId, std::string newname);
        void HandleDeclinedPlayerNameOpcode(WorldPacket& recv_data);

        void HandleTotemDestroy(WorldPacket& recv_data);

        //BattleGround
        void HandleBattleGroundHelloOpcode(WorldPacket &recv_data);
        void HandleBattleGroundJoinOpcode(WorldPacket &recv_data);
        void HandleBattleGroundPlayerPositionsOpcode(WorldPacket& recv_data);
        void HandleBattleGroundPVPlogdataOpcode(WorldPacket &recv_data);
        void HandleBattleGroundPlayerPortOpcode(WorldPacket &recv_data);
        void HandleBattleGroundListOpcode(WorldPacket &recv_data);
        void HandleBattleGroundLeaveOpcode(WorldPacket &recv_data);
        void HandleBattleGroundArenaJoin(WorldPacket &recv_data);
        void HandleBattleGroundReportAFK(WorldPacket &recv_data);

        void HandleWardenDataOpcode(WorldPacket& recv_data);
        void HandleWorldTeleportOpcode(WorldPacket& recv_data);
        void HandleMinimapPingOpcode(WorldPacket& recv_data);
        void HandleRandomRollOpcode(WorldPacket& recv_data);
        void HandleFarSightOpcode(WorldPacket& recv_data);
        void HandleSetLfgOpcode(WorldPacket& recv_data);
        void HandleDungeonDifficultyOpcode(WorldPacket& recv_data);
        void HandleMoveFlyModeChangeAckOpcode(WorldPacket& recv_data);
        void HandleLfgAutoJoinOpcode(WorldPacket& recv_data);
        void HandleLfgCancelAutoJoinOpcode(WorldPacket& recv_data);
        void HandleLfmAutoAddMembersOpcode(WorldPacket& recv_data);
        void HandleLfmCancelAutoAddmembersOpcode(WorldPacket& recv_data);
        void HandleLfgClearOpcode(WorldPacket& recv_data);
        void HandleLfmSetNoneOpcode(WorldPacket& recv_data);
        void HandleLfmSetOpcode(WorldPacket& recv_data);
        void HandleLfgSetCommentOpcode(WorldPacket& recv_data);
        void HandleNewUnknownOpcode(WorldPacket& recv_data);
        void HandleChooseTitleOpcode(WorldPacket& recv_data);
        void HandleRealmStateRequestOpcode(WorldPacket& recv_data);
        void HandleTimeSyncResp(WorldPacket& recv_data);
        void HandleWhoisOpcode(WorldPacket& recv_data);
        void HandleResetInstancesOpcode(WorldPacket& recv_data);

        // Arena Team
        void HandleInspectArenaStatsOpcode(WorldPacket& recv_data);
        void HandleArenaTeamQueryOpcode(WorldPacket& recv_data);
        void HandleArenaTeamRosterOpcode(WorldPacket& recv_data);
        void HandleArenaTeamAddMemberOpcode(WorldPacket& recv_data);
        void HandleArenaTeamInviteAcceptOpcode(WorldPacket& recv_data);
        void HandleArenaTeamInviteDeclineOpcode(WorldPacket& recv_data);
        void HandleArenaTeamLeaveOpcode(WorldPacket& recv_data);
        void HandleArenaTeamRemoveFromTeamOpcode(WorldPacket& recv_data);
        void HandleArenaTeamDisbandOpcode(WorldPacket& recv_data);
        void HandleArenaTeamPromoteToCaptainOpcode(WorldPacket& recv_data);

        void HandleAreaSpiritHealerQueryOpcode(WorldPacket& recv_data);
        void HandleAreaSpiritHealerQueueOpcode(WorldPacket& recv_data);
        void HandleDismountOpcode(WorldPacket& recv_data);
        void HandleSelfResOpcode(WorldPacket& recv_data);
        void HandleReportSpamOpcode(WorldPacket& recv_data);
        void HandleRequestPetInfoOpcode(WorldPacket& recv_data);

        // Socket gem
        void HandleSocketOpcode(WorldPacket& recv_data);

        void HandleCancelTempItemEnchantmentOpcode(WorldPacket& recv_data);

        void HandleChannelEnableVoiceOpcode(WorldPacket & recv_data);
        void HandleVoiceSettingsOpcode(WorldPacket& recv_data);
        void HandleChannelVoiceChatQuery(WorldPacket& recv_data);
        void HandleSetTaxiBenchmarkOpcode(WorldPacket& recv_data);

        // Guild Bank
        void HandleGuildBankGetRights(WorldPacket& recv_data);
        void HandleGuildBankGetMoneyAmount(WorldPacket& recv_data);
        void HandleGuildBankQuery(WorldPacket& recv_data);
        void HandleGuildBankTabColon(WorldPacket& recv_data);
        void HandleGuildBankLog(WorldPacket& recv_data);
        void HandleGuildBankDeposit(WorldPacket& recv_data);
        void HandleGuildBankWithdraw(WorldPacket& recv_data);
        void HandleGuildBankDepositItem(WorldPacket& recv_data);
        void HandleGuildBankModifyTab(WorldPacket& recv_data);
        void HandleGuildBankBuyTab(WorldPacket& recv_data);
        void HandleGuildBankTabText(WorldPacket& recv_data);
        void HandleGuildBankSetTabText(WorldPacket& recv_data);
        
        // Other
        void HandleGetMirrorimageData(WorldPacket& recv_data);

    private:
        // private trade methods
        void moveItems(Item* myItems[], Item* hisItems[]);

        bool CheckMailBox(ObjectGuid& guid);

        // logging helper
        void logUnexpectedOpcode(WorldPacket *packet, const char * reason);
        Player *_player;
        WorldSocket *m_Socket;
        std::string m_Address;

        uint64 m_permissions;
        uint32 _accountId;
        uint8 m_expansion;

        // Warden
        WardenBase * m_Warden;

        time_t _logoutTime;
        bool m_inQueue;                                     // session wait in auth.queue
        bool m_playerLoading;                               // code processed in LoginPlayer
        bool m_playerSave;
        bool m_playerLogout;                                // code processed in LogoutPlayer
        bool m_playerRecentlyLogout;

        uint64 m_accFlags;

        LocaleConstant m_sessionDbcLocale;
        int m_sessionDbLocaleIndex;
        uint32 m_latency;

        TimeTrackerSmall _kickTimer;

        bool m_customRates;

        uint16 m_opcodesDisabled;

        typedef UNORDERED_MAP<uint16,ShortIntervalTimer> OpcodesCooldown;
        OpcodesCooldown _opcodesCooldown;

        ACE_Based::LockedQueue<WorldPacket*, ACE_Thread_Mutex> _recvQueue;

        uint32 m_currentSessionTime;
        uint32 m_currentVerboseTime;
};

struct VerboseLogInfo
{
    VerboseLogInfo(uint16 op, uint32 df) : opcode(op), diff(df) {}
    uint16 opcode;
    uint32 diff;
};

#endif
/// @}
