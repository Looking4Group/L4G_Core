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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "Common.h"
#include "WorldPacket.h"
#include "Log.h"
#include "Corpse.h"
#include "GameObject.h"
#include "Player.h"
#include "ObjectAccessor.h"
#include "WorldSession.h"
#include "LootMgr.h"
#include "Object.h"
#include "Group.h"
#include "World.h"
#include "Util.h"
#include "GuildMgr.h"
#include "Guild.h"

void WorldSession::HandleAutostoreLootItemOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data,1);

    sLog.outDebug("WORLD: CMSG_AUTOSTORE_LOOT_ITEM");
    Player  *player =   GetPlayer();
    uint64   lguid =    player->GetLootGUID();
    Loot    *loot;
    uint8    lootSlot;

    recv_data >> lootSlot;

    if (IS_GAMEOBJECT_GUID(lguid))
    {
        GameObject *go = player->GetMap()->GetGameObject(lguid);

        // not check distance for GO in case owned GO (fishing bobber case, for example) or Fishing hole GO
        if (!go || (go->GetOwnerGUID() != _player->GetGUID() && go->GetGoType() != GAMEOBJECT_TYPE_FISHINGHOLE) && !go->IsWithinDistInMap(_player,INTERACTION_DISTANCE))
        {
            player->SendLootRelease(lguid);
            return;
        }

        loot = &go->loot;
    }
    else if (IS_ITEM_GUID(lguid))
    {
        Item *pItem = player->GetItemByGuid(lguid);

        if (!pItem)
        {
            player->SendLootRelease(lguid);
            return;
        }

        loot = &pItem->loot;
    }
    else if (IS_CORPSE_GUID(lguid))
    {
        Corpse *bones = ObjectAccessor::GetCorpse(*player, lguid);
        if (!bones)
        {
            player->SendLootRelease(lguid);
            return;
        }
        loot = &bones->loot;
    }
    else
    {
        Creature* pCreature = GetPlayer()->GetMap()->GetCreature(lguid);

        bool ok_loot = pCreature && pCreature->isAlive() == (player->getClass()==CLASS_ROGUE && pCreature->lootForPickPocketed);

        if (!ok_loot || !pCreature->IsWithinDistInMap(_player,INTERACTION_DISTANCE))
        {
            player->SendLootRelease(lguid);
            return;
        }

        loot = &pCreature->loot;
    }

    QuestItem *qitem = NULL;
    QuestItem *ffaitem = NULL;
    QuestItem *conditem = NULL;

    LootItem *item = loot->LootItemInSlot(lootSlot,player,&qitem,&ffaitem,&conditem);

    if (!item)
    {
        player->SendEquipError(EQUIP_ERR_ALREADY_LOOTED, NULL, NULL);
        return;
    }

    // questitems use the blocked field for other purposes
    if (!qitem && item->is_blocked)
    {
        player->SendLootRelease(lguid);
        return;
    }

    ItemPosCountVec dest;
    uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, item->itemid, item->count);
    if (msg == EQUIP_ERR_OK)
    {
        Item * newitem = player->StoreNewItem(dest, item->itemid, true, item->randomPropertyId);

        if (qitem)
        {
            qitem->is_looted = true;
            //freeforall is 1 if everyone's supposed to get the quest item.
            if (item->freeforall || loot->GetPlayerQuestItems().size() == 1)
                player->SendNotifyLootItemRemoved(lootSlot);
            else
                loot->NotifyQuestItemRemoved(qitem->index);
        }
        else
        {
            if (ffaitem)
            {
                //freeforall case, notify only one player of the removal
                ffaitem->is_looted = true;

                player->SendNotifyLootItemRemoved(lootSlot);
            }
            else
            {
                //not freeforall, notify everyone
                if (conditem)
                    conditem->is_looted = true;

                loot->NotifyItemRemoved(lootSlot);
            }
        }

        //if only one person is supposed to loot the item, then set it to looted
        if (!item->freeforall)
            loot->setItemLooted(item, player);

        --loot->unlootedCount;
        player->SendNewItem(newitem, uint32(item->count), false, false, true);
    }
    else
        player->SendEquipError(msg, NULL, NULL);
}

void WorldSession::HandleLootMoneyOpcode(WorldPacket & /*recv_data*/)
{
    sLog.outDebug("WORLD: CMSG_LOOT_MONEY");

    Player *player = GetPlayer();
    uint64 guid = player->GetLootGUID();
    if (!guid)
        return;

    Loot *pLoot = NULL;

    switch (GUID_HIPART(guid))
    {
        case HIGHGUID_GAMEOBJECT:
        {
            GameObject *pGameObject = GetPlayer()->GetMap()->GetGameObject(guid);

            // not check distance for GO in case owned GO (fishing bobber case, for example)
            if (pGameObject && (pGameObject->GetOwnerGUID()==_player->GetGUID() || pGameObject->IsWithinDistInMap(_player,INTERACTION_DISTANCE)))
                pLoot = &pGameObject->loot;

            break;
        }
        case HIGHGUID_CORPSE:                               // remove insignia ONLY in BG
        {
            Corpse *bones = ObjectAccessor::GetCorpse(*GetPlayer(), guid);

            if (bones && bones->IsWithinDistInMap(_player,INTERACTION_DISTANCE))
                pLoot = &bones->loot;

            break;
        }
        case HIGHGUID_ITEM:
        {
            if (Item *item = GetPlayer()->GetItemByGuid(guid))
                pLoot = &item->loot;
            break;
        }
        case HIGHGUID_UNIT:
        {
             Creature* pCreature = GetPlayer()->GetMap()->GetCreature(guid);

            bool ok_loot = pCreature && pCreature->isAlive() == (player->getClass()==CLASS_ROGUE && pCreature->lootForPickPocketed);

            if (ok_loot && pCreature->IsWithinDistInMap(_player,INTERACTION_DISTANCE))
                pLoot = &pCreature->loot ;

            break;
        }
        default:
            return;                                         // unlootable type
    }

    if (pLoot)
    {
        if (!IS_ITEM_GUID(guid) && player->GetGroup())      //item can be looted only single player
        {
            Group *group = player->GetGroup();

            std::vector<Player*> playersNear;
            for (GroupReference *itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
            {
                Player* playerGroup = itr->getSource();
                if (!playerGroup)
                    continue;
                if (player->GetDistance2d(playerGroup) < sWorld.getConfig(CONFIG_GROUP_XP_DISTANCE))
                    playersNear.push_back(playerGroup);
            }

            uint32 money_per_player = uint32((pLoot->gold)/(playersNear.size()));

            for (std::vector<Player*>::iterator i = playersNear.begin(); i != playersNear.end(); ++i)
            {
                (*i)->ModifyMoney(money_per_player);
                //Offset surely incorrect, but works
                WorldPacket data(SMSG_LOOT_MONEY_NOTIFY, 4);
                data << uint32(money_per_player);
                (*i)->SendPacketToSelf(&data);
            }
        }
        else
        {
            uint32 gold = pLoot->gold;
            player->ModifyMoney(gold);
        }

        pLoot->gold = 0;
        pLoot->NotifyMoneyRemoved();
    }
}

void WorldSession::HandleLootOpcode(WorldPacket & recv_data)
{
   if (GetPlayer()->HasAuraType(SPELL_AURA_MOD_STEALTH))
        GetPlayer()->RemoveSpellsCausingAura(SPELL_AURA_MOD_STEALTH);

    CHECK_PACKET_SIZE(recv_data,8);

    sLog.outDebug("WORLD: CMSG_LOOT");

    uint64 guid;
    recv_data >> guid;

    GetPlayer()->SendLoot(guid, LOOT_CORPSE);
}

void WorldSession::HandleLootReleaseOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data,8);

    sLog.outDebug("WORLD: CMSG_LOOT_RELEASE");

    // cheaters can modify lguid to prevent correct apply loot release code and re-loot
    // use internal stored guid
    //uint64   lguid;
    //recv_data >> lguid;

    if (uint64 lguid = GetPlayer()->GetLootGUID())
        DoLootRelease(lguid);
}

void WorldSession::DoLootRelease(uint64 lguid)
{
    Player  *player = GetPlayer();
    Loot    *loot;

    player->SetLootGUID(0);
    player->SendLootRelease(lguid);

    player->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_LOOTING);

    if (!player->IsInWorld())
        return;

    if (IS_GAMEOBJECT_GUID(lguid))
    {
        GameObject *go = GetPlayer()->GetMap()->GetGameObject(lguid);

        // not check distance for GO in case owned GO (fishing bobber case, for example) or Fishing hole GO
        if (!go || (go->GetOwnerGUID() != _player->GetGUID() && go->GetGoType() != GAMEOBJECT_TYPE_FISHINGHOLE) && !go->IsWithinDistInMap(_player,INTERACTION_DISTANCE))
            return;

        loot = &go->loot;

        if (go->GetGoType() == GAMEOBJECT_TYPE_DOOR)
        {
            // locked doors are opened with spelleffect openlock, prevent remove its as looted
            go->UseDoorOrButton();
        }
        else if ((go->GetGoType() == GAMEOBJECT_TYPE_CHEST && go->GetGOInfo()->chest.consumable) || loot->isLooted())
        {
            if (go->GetGoType() == GAMEOBJECT_TYPE_FISHINGHOLE)
            {                                               // The fishing hole used once more
                go->AddUse();                               // if the max usage is reached, will be despawned in next tick
                if (go->GetUseCount()>=irand(go->GetGOInfo()->fishinghole.minSuccessOpens,go->GetGOInfo()->fishinghole.maxSuccessOpens))
                {
                    go->SetLootState(GO_JUST_DEACTIVATED);
                }
                else
                    go->SetLootState(GO_READY);
            }
            else if (go->GetGoType() == GAMEOBJECT_TYPE_FISHINGNODE)
                go->SetLootState(GO_JUST_DEACTIVATED);

            loot->clear();
        }
    }
    else if (IS_CORPSE_GUID(lguid))        // ONLY remove insignia at BG
    {
        Corpse *corpse = ObjectAccessor::GetCorpse(*player, lguid);
        if (!corpse || !corpse->IsWithinDistInMap(_player,INTERACTION_DISTANCE))
            return;

        loot = &corpse->loot;

        if (loot->isLooted())
        {
            loot->clear();
            corpse->RemoveFlag(CORPSE_FIELD_DYNAMIC_FLAGS, CORPSE_DYNFLAG_LOOTABLE);
        }
    }
    else if (IS_ITEM_GUID(lguid))
    {
        Item *pItem = player->GetItemByGuid(lguid);
        if (!pItem)
            return;

        ItemPrototype const* proto = pItem->GetProto();
        // destroy only 5 items from stack in case prospecting and milling
        if ((proto->BagFamily & BAG_FAMILY_MASK_MINING_SUPP) &&
            proto->Class == ITEM_CLASS_TRADE_GOODS)
        {
            pItem->m_lootGenerated = false;
            pItem->loot.clear();

            uint32 count = 5;
            player->DestroyItemCount(pItem, count, true);
        }
        else
            // FIXME: item don't must be deleted in case not fully looted state. But this pre-request implement loot saving in DB at item save. Or checting possible.
            player->DestroyItem(pItem->GetBagSlot(),pItem->GetSlot(), true);
        return;                                             // item can be looted only single player
    }
    else
    {
        Creature* pCreature = GetPlayer()->GetMap()->GetCreature(lguid);

        bool ok_loot = pCreature && pCreature->isAlive() == (player->getClass()==CLASS_ROGUE && pCreature->lootForPickPocketed);
        if (!ok_loot || !pCreature->IsWithinDistInMap(_player,INTERACTION_DISTANCE))
            return;

        loot = &pCreature->loot;

        if (player->GetGUID() == loot->looterGUID)
        {
            loot->looterGUID = 0;
            if (Group *group = player->GetGroup())
                group->SendRoundRobin(loot, pCreature);
        }

        if (loot->isLooted())
        {
            // skip pickpocketing loot for speed, skinning timer redunction is no-op in fact
            if (!pCreature->isAlive())
                pCreature->AllLootRemovedFromCorpse();

            pCreature->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
            loot->clear();
        }
    }

    //Player is not looking at loot list, he doesn't need to see updates on the loot list
    loot->RemoveLooter(player->GetGUID());

    // should be fixed after some research in loot implementation etc
//    loot->RemoveQuestLoot(player);
}

void WorldSession::HandleLootMasterGiveOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data,8+1+8);

    uint8 slotid;
    uint64 lootguid, target_playerguid;

    recv_data >> lootguid >> slotid >> target_playerguid;

    if (!_player->GetGroup() || _player->GetGroup()->GetLooterGuid() != _player->GetGUID())
    {
        _player->SendLootRelease(GetPlayer()->GetLootGUID());
        return;
    }

    Player *target = ObjectAccessor::FindPlayer(MAKE_NEW_GUID(target_playerguid, 0, HIGHGUID_PLAYER));
    if (!target)
        return;

    sLog.outDebug("WorldSession::HandleLootMasterGiveOpcode (CMSG_LOOT_MASTER_GIVE, 0x02A3) Target = [%s].", target->GetName());

    if (_player->GetLootGUID() != lootguid)
        return;

    if (_player->GetInstanceId() != target->GetInstanceId())
        return;

    Loot *pLoot = NULL;

    if (IS_CREATURE_GUID(GetPlayer()->GetLootGUID()))
    {
        Creature *pCreature = GetPlayer()->GetMap()->GetCreature(lootguid);
        if (!pCreature)
            return;

        pLoot = &pCreature->loot;
    }
    else if (IS_GAMEOBJECT_GUID(GetPlayer()->GetLootGUID()))
    {
        GameObject *pGO = GetPlayer()->GetMap()->GetGameObject(lootguid);
        if (!pGO)
            return;

        pLoot = &pGO->loot;
    }

    if (!pLoot)
        return;

    if (slotid > pLoot->items.size())
    {
        sLog.outDebug("AutoLootItem: Player %s might be using a hack! (slot %d, size %d)",GetPlayer()->GetName(), slotid, pLoot->items.size());
        return;
    }

    LootItem& item = pLoot->items[slotid];

    ItemPosCountVec dest;
    uint8 msg = target->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, item.itemid, item.count);
    if (msg != EQUIP_ERR_OK)
    {
        target->SendEquipError(msg, NULL, NULL);
        _player->SendEquipError(msg, NULL, NULL);         // send duplicate of error massage to master looter
        return;
    }

    // not move item from loot to target inventory
    Item * newitem = target->StoreNewItem(dest, item.itemid, true, item.randomPropertyId);
    target->SendNewItem(newitem, uint32(item.count), false, false, true);

    target->SaveToDB();

    // mark as looted
    item.count=0;

    pLoot->setItemLooted(&item, target);
    pLoot->NotifyItemRemoved(slotid);
    --pLoot->unlootedCount;
}

