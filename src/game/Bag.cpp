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
#include "Bag.h"
#include "ObjectMgr.h"
#include "Database/DatabaseEnv.h"
#include "Log.h"
#include "WorldPacket.h"
#include "UpdateData.h"
#include "WorldSession.h"

Bag::Bag(): Item()
{
    m_objectType |= TYPEMASK_CONTAINER;
    m_objectTypeId = TYPEID_CONTAINER;

    m_valuesCount = CONTAINER_END;

    memset(m_bagslot, 0, sizeof(Item *) * MAX_BAG_SIZE);
}

Bag::~Bag()
{
    for (int i = 0; i < MAX_BAG_SIZE; ++i)
    {
        if (m_bagslot[i] && m_bagslot[i] != this)
        {
            Item *item = m_bagslot[i];
            if (item->IsInWorld())
                item->RemoveFromWorld();

            delete m_bagslot[i];
        }
    }
}

void Bag::AddToWorld()
{
    Item::AddToWorld();

    for (uint32 i = 0;  i < GetBagSize(); ++i)
        if (m_bagslot[i])
        {
            if (m_bagslot[i] == this)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: Bag has self in slot: %u, bag size: %u, owner: " I64FMT, GetSlotByItemGUID(m_bagslot[i]->GetGUID()), GetBagSize(), GetOwnerGUID());
                continue;
            }
            m_bagslot[i]->AddToWorld();
        }
}

void Bag::RemoveFromWorld()
{
    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i] && m_bagslot[i] != this)
            m_bagslot[i]->RemoveFromWorld();

    Item::RemoveFromWorld();
}

bool Bag::Create(uint32 guidlow, uint32 itemid, Player const* owner)
{
    ItemPrototype const * itemProto = ObjectMgr::GetItemPrototype(itemid);

    if (!itemProto || itemProto->ContainerSlots > MAX_BAG_SIZE)
        return false;

    Object::_Create(guidlow, 0, HIGHGUID_CONTAINER);

    SetEntry(itemid);
    SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0f);

    SetUInt64Value(ITEM_FIELD_OWNER, owner ? owner->GetGUID() : 0);
    SetUInt64Value(ITEM_FIELD_CONTAINED, owner ? owner->GetGUID() : 0);

    SetUInt32Value(ITEM_FIELD_MAXDURABILITY, itemProto->MaxDurability);
    SetUInt32Value(ITEM_FIELD_DURABILITY, itemProto->MaxDurability);
    SetUInt32Value(ITEM_FIELD_FLAGS, itemProto->Flags);
    SetUInt32Value(ITEM_FIELD_STACK_COUNT, 1);

    // Setting the number of Slots the Container has
    SetUInt32Value(CONTAINER_FIELD_NUM_SLOTS, itemProto->ContainerSlots);

    // Cleaning 20 slots
    for (uint8 i = 0; i < MAX_BAG_SIZE; i++)
    {
        SetUInt64Value(CONTAINER_FIELD_SLOT_1 + (i*2), 0);
        m_bagslot[i] = NULL;
    }

    return true;
}

void Bag::SaveToDB()
{
    Item::SaveToDB();
}

bool Bag::LoadFromDB(uint32 guid, uint64 owner_guid, QueryResultAutoPtr result)
{
    if (!Item::LoadFromDB(guid, owner_guid, result))
        return false;

    // cleanup bag content related item value fields (its will be filled correctly from `character_inventory`)
    for (int i = 0; i < MAX_BAG_SIZE; ++i)
    {
        SetUInt64Value(CONTAINER_FIELD_SLOT_1 + (i*2), 0);
        if (m_bagslot[i])
        {
            delete m_bagslot[i];
            m_bagslot[i] = NULL;
        }
    }

    return true;
}

void Bag::DeleteFromDB()
{
    for (int i = 0; i < MAX_BAG_SIZE; i++)
        if (m_bagslot[i])
            m_bagslot[i]->DeleteFromDB();

    Item::DeleteFromDB();
}

uint32 Bag::GetFreeSlots() const
{
    uint32 slots = 0;
    for (uint32 i=0; i < GetBagSize(); i++)
        if (!m_bagslot[i])
            ++slots;

    return slots;
}

void Bag::RemoveItem(uint8 slot, bool /*update*/)
{
    ASSERT(slot < MAX_BAG_SIZE);

    if (m_bagslot[slot])
        m_bagslot[slot]->SetContainer(NULL);

    m_bagslot[slot] = NULL;
    SetUInt64Value(CONTAINER_FIELD_SLOT_1 + (slot * 2), 0);
}

void Bag::StoreItem(uint8 slot, Item *pItem, bool /*update*/)
{
    if (slot >= MAX_BAG_SIZE)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Player GUID " UI64FMTD " tried to manipulate packets and crash the server.", GetOwnerGUID());
        return;
    }

    if (pItem && pItem->GetGUID() != GetGUID())
    {
        m_bagslot[slot] = pItem;
        SetUInt64Value(CONTAINER_FIELD_SLOT_1 + (slot * 2), pItem->GetGUID());
        pItem->SetUInt64Value(ITEM_FIELD_CONTAINED, GetGUID());
        pItem->SetUInt64Value(ITEM_FIELD_OWNER, GetOwnerGUID());
        pItem->SetContainer(this);
        pItem->SetSlot(slot);
    }
}

void Bag::BuildCreateUpdateBlockForPlayer(UpdateData *data, Player *target) const
{
    Item::BuildCreateUpdateBlockForPlayer(data, target);

    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i])
            m_bagslot[i]->BuildCreateUpdateBlockForPlayer(data, target);
}

// If the bag is empty returns true
bool Bag::IsEmpty() const
{
    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i])
            return false;

    return true;
}

uint32 Bag::GetItemCount(uint32 item, Item* eItem) const
{
    Item *pItem;
    uint32 count = 0;
    for (uint32 i=0; i < GetBagSize(); ++i)
    {
        pItem = m_bagslot[i];
        if (pItem && pItem != eItem && pItem->GetEntry() == item)
            count += pItem->GetCount();
    }

    if (eItem && eItem->GetProto()->GemProperties)
    {
        for (uint32 i=0; i < GetBagSize(); ++i)
        {
            pItem = m_bagslot[i];
            if (pItem && pItem != eItem && pItem->GetProto()->Socket[0].Color)
                count += pItem->GetGemCountWithID(item);
        }
    }

    return count;
}

uint8 Bag::GetSlotByItemGUID(uint64 guid) const
{
    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i] != 0)
            if (m_bagslot[i]->GetGUID() == guid)
                return i;

    return NULL_SLOT;
}

Item* Bag::GetItemByPos(uint8 slot) const
{
    if (slot < GetBagSize())
        return m_bagslot[slot];

    return NULL;
}

