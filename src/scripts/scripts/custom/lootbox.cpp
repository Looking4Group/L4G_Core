/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: item_lootbox
SD%Complete: 100
SDComment: Used for l4g level item vendors
SDCategory: Items
EndScriptData */

#include "precompiled.h"

bool ItemUse_item_lootbox(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    if (!FindCreature(1000010, 50.0f, player))
        switch (_Item->GetEntry())
        {
            case 1000033: 
                player->SummonCreature(1000010, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 120000);
                break;
            case 12346: 
                player->SummonCreature(23456, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 120000);
                break;
            default: return false;
        }       
    return true;
}

void AddSC_item_lootbox()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="item_lootbox";
    newscript->pItemUse = &ItemUse_item_lootbox;
    newscript->RegisterSelf();
}