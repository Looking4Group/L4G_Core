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
#include "DBCStores.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "ObjectMgr.h"
#include "SpellMgr.h"
#include "Log.h"
#include "Opcodes.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "BattleGround.h"
#include "MapManager.h"
#include "ScriptMgr.h"
#include "Totem.h"
#include "TemporarySummon.h"

void WorldSession::HandleUseItemOpcode(WorldPacket& recvPacket)
{
    Player* pUser = _player;
    uint8 bagIndex, slot;
    uint8 spell_count;                                      // number of spells at item, not used
    uint8 cast_count;                                       // next cast if exists (single or not)
    uint64 item_guid;

    recvPacket >> bagIndex >> slot >> spell_count >> cast_count >> item_guid;

    Item *pItem = pUser->GetItemByPos(bagIndex, slot);
    if (!pItem)
    {
        pUser->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, NULL, NULL);
        return;
    }

    if (pItem->GetGUID() != item_guid)
    {
        pUser->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, NULL, NULL);
        return;
    }

    sLog.outDetail("WORLD: CMSG_USE_ITEM packet, bagIndex: %u, slot: %u, spell_count: %u , cast_count: %u, Item: %u, data length = %i", bagIndex, slot, spell_count, cast_count, pItem->GetEntry(), recvPacket.size());

    ItemPrototype const *proto = pItem->GetProto();
    if (!proto)
    {
        pUser->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pItem, NULL);
        return;
    }

    // some item classes can be used only in equipped state
    if (proto->InventoryType != INVTYPE_NON_EQUIP && !pItem->IsEquipped())
    {
        pUser->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pItem, NULL);
        return;
    }

    uint8 msg = pUser->CanUseItem(pItem);
    if (msg != EQUIP_ERR_OK)
    {
        pUser->SendEquipError(msg, pItem, NULL);
        return;
    }

    // only allow conjured consumable, bandage, poisons (all should have the 2^21 item flag set in DB)
    if (proto->Class == ITEM_CLASS_CONSUMABLE &&
        !(proto->Flags & ITEM_FLAGS_USEABLE_IN_ARENA) &&
        pUser->InArena())
    {
        pUser->SendEquipError(EQUIP_ERR_NOT_DURING_ARENA_MATCH,pItem,NULL);
        return;
    }

    if (pUser->isInCombat())
    {
        for (int i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
        {
            if (SpellEntry const *spellInfo = sSpellStore.LookupEntry(proto->Spells[i].SpellId))
            {
                if (SpellMgr::IsNonCombatSpell(spellInfo))
                {
                    pUser->SendEquipError(EQUIP_ERR_NOT_IN_COMBAT,pItem,NULL);
                    return;
                }
            }
        }
    }

    // check also  BIND_WHEN_PICKED_UP and BIND_QUEST_ITEM for .additem or .additemset case by GM (not binded at adding to inventory)
    if (pItem->GetProto()->Bonding == BIND_WHEN_USE || pItem->GetProto()->Bonding == BIND_WHEN_PICKED_UP || pItem->GetProto()->Bonding == BIND_QUEST_ITEM)
    {
        if (!pItem->IsSoulBound())
        {
            pItem->SetState(ITEM_CHANGED, pUser);
            pItem->SetBinding(true);
        }
    }

    SpellCastTargets targets;

    recvPacket >> targets.ReadForCaster(pUser);

    if (!targets.getUnitTarget())
    {
        for (int i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
        {
            _Spell const& spellData = pItem->GetProto()->Spells[i];
            if (!spellData.SpellId)
                continue;

            // wrong triggering type
            if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_USE && spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_NO_DELAY_USE)
                continue;

            SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellData.SpellId);
            if (!spellInfo)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Item (Entry: %u) in have wrong spell id %u, ignoring ",proto->ItemId, spellData.SpellId);
                continue;
            }

            if (spellInfo->EffectImplicitTargetA[0] == TARGET_UNIT_TARGET_ENEMY || spellInfo->EffectImplicitTargetA[1] == TARGET_UNIT_TARGET_ENEMY || spellInfo->EffectImplicitTargetA[2] == TARGET_UNIT_TARGET_ENEMY)
                if (Unit *tUnit = Unit::GetUnit(*GetPlayer(), GetPlayer()->GetSelection()))
                    targets.setUnitTarget(tUnit);

            if (spellInfo->EffectImplicitTargetA[0] == TARGET_UNIT_CASTER || spellInfo->EffectImplicitTargetA[1] == TARGET_UNIT_CASTER || spellInfo->EffectImplicitTargetA[2] == TARGET_UNIT_CASTER)
                targets.setUnitTarget(pUser);
        }
    }

    //Note: If script stop casting it must send appropriate data to client to prevent stuck item in gray state.
    if (!sScriptMgr.OnItemUse(pUser, pItem, targets))
    {
        // no script or script not process request by self

        // special learning case
        if (pItem->GetProto()->Spells[0].SpellId==SPELL_ID_GENERIC_LEARN)
        {
            uint32 learning_spell_id = pItem->GetProto()->Spells[1].SpellId;

            SpellEntry const *spellInfo = sSpellStore.LookupEntry(SPELL_ID_GENERIC_LEARN);
            if (!spellInfo)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Item (Entry: %u) in have wrong spell id %u, ignoring ",proto->ItemId, SPELL_ID_GENERIC_LEARN);
                pUser->SendEquipError(EQUIP_ERR_NONE,pItem,NULL);
                return;
            }

            Spell *spell = new Spell(pUser, spellInfo, false);
            spell->m_CastItem = pItem;
            spell->m_cast_count = cast_count;               //set count of casts
            spell->m_currentBasePoints[0] = learning_spell_id;
            spell->prepare(&targets);
            return;
        }

        // use triggered flag only for items with many spell casts and for not first cast
        int count = 0;

        for (int i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
        {
            _Spell const& spellData = pItem->GetProto()->Spells[i];

            // no spell
            if (!spellData.SpellId)
                continue;

            // wrong triggering type
            if (spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_USE && spellData.SpellTrigger != ITEM_SPELLTRIGGER_ON_NO_DELAY_USE)
                continue;

            SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellData.SpellId);
            if (!spellInfo)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Item (Entry: %u) in have wrong spell id %u, ignoring ",proto->ItemId, spellData.SpellId);
                continue;
            }

            Spell *spell = new Spell(pUser, spellInfo, (count > 0));
            spell->m_CastItem = pItem;
            spell->m_cast_count = cast_count;               //set count of casts

            bool fillMap = spellInfo->NeedFillTargetMapForTargets(0);
            if (fillMap)
                spell->FillTargetMap();

            spell->prepare(fillMap ? &spell->m_targets : &targets);
            ++count;
        }
    }
}

#define OPEN_CHEST 11437
#define OPEN_SAFE 11535
#define OPEN_CAGE 11792
#define OPEN_BOOTY_CHEST 5107
#define OPEN_STRONGBOX 8517

void WorldSession::HandleOpenItemOpcode(WorldPacket& recvPacket)
{
    CHECK_PACKET_SIZE(recvPacket,1+1);

    sLog.outDetail("WORLD: CMSG_OPEN_ITEM packet, data length = %i",recvPacket.size());

    Player* pUser = _player;
    uint8 bagIndex, slot;

    recvPacket >> bagIndex >> slot;

    sLog.outDetail("bagIndex: %u, slot: %u",bagIndex,slot);

    Item *pItem = pUser->GetItemByPos(bagIndex, slot);
    if (!pItem)
    {
        pUser->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, NULL, NULL);
        return;
    }

    ItemPrototype const *proto = pItem->GetProto();
    if (!proto)
    {
        pUser->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pItem, NULL);
        return;
    }

    // locked item
    uint32 lockId = proto->LockID;
    if (lockId)
    {
        LockEntry const *lockInfo = sLockStore.LookupEntry(lockId);

        if (!lockInfo)
        {
            pUser->SendEquipError(EQUIP_ERR_ITEM_LOCKED, pItem, NULL);
            sLog.outLog(LOG_DEFAULT, "ERROR: WORLD::OpenItem: item [guid = %u] has an unknown lockId: %u!", pItem->GetGUIDLow() , lockId);
            return;
        }

        // required picklocking
        if (lockInfo->Skill[1] || lockInfo->Skill[0])
        {
            pUser->SendEquipError(EQUIP_ERR_ITEM_LOCKED, pItem, NULL);
            return;
        }
    }

    if (pItem->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAGS_WRAPPED))// wrapped?
    {
        QueryResultAutoPtr result = RealmDataDatabase.PQuery("SELECT entry, flags FROM character_gifts WHERE item_guid = '%u'", pItem->GetGUIDLow());
        if (result)
        {
            Field *fields = result->Fetch();
            uint32 entry = fields[0].GetUInt32();
            uint32 flags = fields[1].GetUInt32();

            pItem->SetUInt64Value(ITEM_FIELD_GIFTCREATOR, 0);
            pItem->SetEntry(entry);
            pItem->SetUInt32Value(ITEM_FIELD_FLAGS, flags);
            pItem->SetState(ITEM_CHANGED, pUser);
        }
        else
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Wrapped item %u don't have record in character_gifts table and will deleted", pItem->GetGUIDLow());
            pUser->DestroyItem(pItem->GetBagSlot(), pItem->GetSlot(), true);
            return;
        }
        RealmDataDatabase.PExecute("DELETE FROM character_gifts WHERE item_guid = '%u'", pItem->GetGUIDLow());
    }
    else
        pUser->SendLoot(pItem->GetGUID(),LOOT_CORPSE);
}

void WorldSession::HandleGameObjectUseOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data, 8);

    uint64 guid;

    recv_data >> guid;

    sLog.outDebug("WORLD: Recvd CMSG_GAMEOBJ_USE Message [guid=%u]", GUID_LOPART(guid));
    GameObject *obj = GetPlayer()->GetMap()->GetGameObject(guid);

    if (!obj)
        return;

    obj->Use(_player);
}

void WorldSession::HandleCastSpellOpcode(WorldPacket& recvPacket)
{
    CHECK_PACKET_SIZE(recvPacket,4+1+2);

    uint32 spellId;
    uint8  cast_count;
    recvPacket >> spellId;
    recvPacket >> cast_count;

    sLog.outDebug("WORLD: got cast spell packet, spellId - %u, cast_count: %u data length = %i",
        spellId, cast_count, recvPacket.size());

    // can't use our own spells when we're in possession of another unit,
    if (_player->isPossessing())
        return;

    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);

    if (!spellInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: WORLD: unknown spell id %u", spellId);
        return;
    }

    // not have spell or spell passive and not casted by client
    if (!_player->HasSpell(spellId) || SpellMgr::IsPassiveSpell(spellId))
    {
        //cheater? kick? ban?
        return;
    }

    // client provided targets
    SpellCastTargets targets;
    recvPacket >> targets.ReadForCaster(_player);

    // auto-selection buff level base at target level (in spellInfo)
    if (Unit* target = targets.getUnitTarget())
    {
        // if rank not found then function return NULL but in explicit cast case original spell can be casted and later failed with appropriate error message
        if (SpellEntry const *actualSpellInfo = sSpellMgr.SelectAuraRankForPlayerLevel(spellInfo, target->getLevel()))
            spellInfo = actualSpellInfo;
    }

    if (spellInfo->AttributesEx2 & SPELL_ATTR_EX2_AUTOREPEAT_FLAG)
    {
        if (_player->m_currentSpells[CURRENT_AUTOREPEAT_SPELL] && _player->m_currentSpells[CURRENT_AUTOREPEAT_SPELL]->GetSpellInfo()->Id == spellInfo->Id)
            return;
    }

    Spell *spell = new Spell(_player, spellInfo, false);
    spell->m_cast_count = cast_count;                       // set count of casts
    spell->prepare(&targets);
}

void WorldSession::HandleCancelCastOpcode(WorldPacket& recvPacket)
{
    CHECK_PACKET_SIZE(recvPacket,4);

    uint32 spellId;
    recvPacket >> spellId;

    if (!_player->isCharmed() && !_player->isPossessed() && _player->IsNonMeleeSpellCasted(false))
        _player->InterruptNonMeleeSpells(false,spellId,false);
}

void WorldSession::HandleCancelAuraOpcode(WorldPacket& recvPacket)
{
    uint32 spellId;
    recvPacket >> spellId;

    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);
    if (!spellInfo)
        return;

    // not allow remove non positive spells and spells with attr SPELL_ATTR_CANT_CANCEL
    if (spellInfo->Attributes & SPELL_ATTR_CANT_CANCEL)
        return;

    if (!SpellMgr::IsPositiveSpell(spellId))
    {
        // ignore for remote control state
        if (_player->GetFarsightTarget())
        {
            // except own aura spells
            bool allow = false;
            for (int k = 0; k < 3; ++k)
            {
                if (spellInfo->EffectApplyAuraName[k] == SPELL_AURA_MOD_POSSESS ||
                    spellInfo->EffectApplyAuraName[k] == SPELL_AURA_MOD_POSSESS_PET)
                {
                    allow = true;
                    break;
                }
            }

            // this also include case when aura not found
            if (!allow)
                return;
        }
        else
            return;
    }

    // channeled spell case (it currently casted then)
    if (SpellMgr::IsChanneledSpell(spellInfo))
    {
        if (_player->m_currentSpells[CURRENT_CHANNELED_SPELL] &&
            _player->m_currentSpells[CURRENT_CHANNELED_SPELL]->GetSpellInfo()->Id==spellId)
            _player->InterruptSpell(CURRENT_CHANNELED_SPELL);
        return;
    }

    // non channeled case
    _player->RemoveAurasDueToSpellByCancel(spellId);
}

void WorldSession::HandlePetCancelAuraOpcode(WorldPacket& recvPacket)
{
    uint64 guid;
    uint32 spellId;

    recvPacket >> guid;
    recvPacket >> spellId;

    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);
    if (!spellInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: WORLD: unknown PET spell id %u", spellId);
        return;
    }

    Creature* pet = _player->GetMap()->GetCreatureOrPet(guid);

    if (!pet)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Pet %u not exist.", uint32(GUID_LOPART(guid)));
        return;
    }

    if (pet != GetPlayer()->GetPet() && pet != GetPlayer()->GetCharm())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: HandlePetCancelAura.Pet %u isn't pet of player %s", uint32(GUID_LOPART(guid)),GetPlayer()->GetName());
        return;
    }

    if (!pet->isAlive())
    {
        pet->SendPetActionFeedback(FEEDBACK_PET_DEAD);
        return;
    }

    pet->RemoveAurasDueToSpell(spellId);

    pet->AddCreatureSpellCooldown(spellId);
}

void WorldSession::HandleCancelGrowthAuraOpcode(WorldPacket& /*recvPacket*/)
{
    // nothing do
}

void WorldSession::HandleCancelAutoRepeatSpellOpcode(WorldPacket& /*recvPacket*/)
{
    // may be better send SMSG_CANCEL_AUTO_REPEAT?
    // cancel and prepare for deleting
    _player->InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
}

/// \todo Complete HandleCancelChanneling function
void WorldSession::HandleCancelChanneling(WorldPacket & /*recv_data */)
{
    /*
        CHECK_PACKET_SIZE(recv_data, 4);

        uint32 spellid;
        recv_data >> spellid;
    */
}

void WorldSession::HandleTotemDestroy(WorldPacket& recvPacket)
{
    CHECK_PACKET_SIZE(recvPacket, 1);

    uint8 slotId;

    recvPacket >> slotId;

    if (slotId >= MAX_TOTEM)
        return;

    if (!_player->m_TotemSlot[slotId])
        return;

    Creature* totem = GetPlayer()->GetMap()->GetCreature(_player->m_TotemSlot[slotId]);
    // Don't unsummon sentry totem
    if (totem && totem->isTotem() && totem->GetEntry() != SENTRY_TOTEM_ENTRY)
        ((Totem*)totem)->UnSummon();
}

void WorldSession::HandleSelfResOpcode(WorldPacket & /*recv_data*/)
{
    sLog.outDebug("WORLD: CMSG_SELF_RES");                  // empty opcode

    if (_player->GetUInt32Value(PLAYER_SELF_RES_SPELL))
    {
        SpellEntry const *spellInfo = sSpellStore.LookupEntry(_player->GetUInt32Value(PLAYER_SELF_RES_SPELL));
        if (spellInfo)
            _player->CastSpell(_player,spellInfo,false,0);

        _player->SetUInt32Value(PLAYER_SELF_RES_SPELL, 0);
    }
}

void WorldSession::HandleGetMirrorimageData(WorldPacket& recv_data)
{
    sLog.outDebug("WORLD: CMSG_GET_MIRRORIMAGE_DATA");

    ObjectGuid guid;
    recv_data >> guid;

    Creature* pCreature = _player->GetMap()->GetCreature(guid);

    if (!pCreature)
        return;

    Unit::AuraList const& images = pCreature->GetAurasByType(SPELL_AURA_MIRROR_IMAGE);

    if (images.empty())
        return;

    Unit* pCaster = images.front()->GetCaster();

    WorldPacket data(SMSG_MIRRORIMAGE_DATA, 68);

    data << guid;
    data << (uint32)pCreature->GetDisplayId();

    data << (uint8)pCreature->getRace();
    data << (uint8)pCreature->getGender();
    // data << (uint8)pCreature->getClass();

    if (pCaster->GetTypeId() == TYPEID_PLAYER)
    {
        Player* pPlayer = (Player*)pCaster;

        // skin, face, hair, haircolor
        data << (uint8)pPlayer->GetByteValue(PLAYER_BYTES, 0);
        data << (uint8)pPlayer->GetByteValue(PLAYER_BYTES, 1);
        data << (uint8)pPlayer->GetByteValue(PLAYER_BYTES, 2);
        data << (uint8)pPlayer->GetByteValue(PLAYER_BYTES, 3);

        // facial hair
        data << (uint8)pPlayer->GetByteValue(PLAYER_BYTES_2, 0);

        // guild id
        data << (uint32)pPlayer->GetGuildId();

        if (pPlayer->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM))
            data << (uint32)0;
        else
            data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD);

        data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS);
        data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BODY);
        data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST);
        data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST);
        data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS);
        data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET);
        data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS);
        data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS);

        if (pPlayer->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_CLOAK))
            data << (uint32)0;
        else
            data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK);

        data << (uint32)pPlayer->GetItemDisplayIdInSlot(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TABARD);
    }
    else
    {
        // No data when cloner is not player, data is taken from CreatureDisplayInfoExtraEntry by model already
        data << (uint8)0;
        data << (uint8)0;
        data << (uint8)0;
        data << (uint8)0;

        data << (uint8)0;

        data << (uint32)0;

        for (int i = 0; i < 11; ++i)
            data << (uint32)0;
    }

    SendPacket(&data);
}
