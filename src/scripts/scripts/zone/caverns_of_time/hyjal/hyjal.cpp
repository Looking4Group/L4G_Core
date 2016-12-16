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
SDName: Hyjal
SD%Complete: 99
SDComment: 
SDCategory: Caverns of Time, Mount Hyjal
EndScriptData */

/* ContentData
npc_jaina_proudmoore
npc_thrall
npc_tyrande_whisperwind
EndContentData */

#include "precompiled.h"
#include "hyjalAI.h"

enum HyjalGossipMenu
{
    // Jaina
    GOSSIP_MENU_WINTERCHILL_NOT_STARTED     = 20000,
    GOSSIP_MENU_WINTERCHILL_STARTED         = 20001,
    GOSSIP_MENU_JAINA_EVENT_IN_PROGRESS     = 20002,
    GOSSIP_MENU_WINTERCHILL_KILLED          = 20013,
    GOSSIP_MENU_ANETHERON_STARTED           = 20004,
    GOSSIP_MENU_ANETHERON_KILLED            = 20005,

    // Thrall
    GOSSIP_MENU_KAZROGAL_NOT_STARTED        = 20006,
    GOSSIP_MENU_KAZROGAL_STARTED            = 20007,
    GOSSIP_MENU_THRALL_EVENT_IN_PROGRESS    = 20008,
    GOSSIP_MENU_KAZROGAL_KILLED             = 20009,
    GOSSIP_MENU_AZGALOR_STARTED             = 20010,
    GOSSIP_MENU_AZGALOR_KILLED              = 20011,

    // Tyrande
    GOSSIP_MENU_TYRANDE                     = 20012
};

#define GOSSIP_ITEM_BEGIN_ALLY      "My companions and I are with you, Lady Proudmoore."
#define GOSSIP_ITEM_ANETHERON       "We are ready for whatever Archimonde might send our way, Lady Proudmoore."
#define GOSSIP_ITEM_RETREAT_JAINA   "Until we meet again, Lady Proudmoore."

#define GOSSIP_ITEM_BEGIN_HORDE     "I am with you, Thrall."
#define GOSSIP_ITEM_AZGALOR         "We have nothing to fear."
#define GOSSIP_ITEM_RETREAT_THRALL  "Until we meet again, Thrall."

#define GOSSIP_ITEM_TYRANDE         "I would be grateful for any aid you can provide, Priestess."
#define ITEM_TEAR_OF_GODDESS        24494


CreatureAI* GetAI_npc_jaina_proudmoore(Creature *_Creature)
{
    hyjalAI* ai = new hyjalAI(_Creature);

    ai->Reset();
    ai->EnterEvadeMode();

    ai->Spell[0].SpellId = SPELL_SUMMON_ELEMENTALS;
    ai->Spell[0].CooldownStart = 10000;
    ai->Spell[0].CooldownMin = 100000;
    ai->Spell[0].CooldownMax = 140000;
    ai->Spell[0].TargetType = TARGETTYPE_SELF;

    ai->Spell[1].SpellId = SPELL_BLIZZARD;
    ai->Spell[1].CooldownMin = 15000;
    ai->Spell[1].CooldownMax = 35000;
    ai->Spell[1].TargetType = TARGETTYPE_RANDOM;

    ai->Spell[2].SpellId = SPELL_PYROBLAST;
    ai->Spell[2].CooldownMin = 5500;
    ai->Spell[2].CooldownMax = 9000;
    ai->Spell[2].TargetType = TARGETTYPE_RANDOM;

    return ai;
}

bool GossipHello_npc_jaina_proudmoore(Player *player, Creature *_Creature)
{
    hyjalAI* ai = ((hyjalAI*)_Creature->AI());

    uint32 RageEncounter = ai->GetInstanceData(DATA_RAGEWINTERCHILLEVENT);
    uint32 AnetheronEncounter = ai->GetInstanceData(DATA_ANETHERONEVENT);

    if (player->isGameMaster())
        player->ADD_GOSSIP_ITEM(2, "[GM] Toggle Debug Timers", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    if (ai->EventBegun)
    {
        player->SEND_GOSSIP_MENU(GOSSIP_MENU_JAINA_EVENT_IN_PROGRESS, _Creature->GetGUID());
    }
    else if (RageEncounter == NOT_STARTED)
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_BEGIN_ALLY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        if (player->GetSession()->GetPermissions() > PERM_PLAYER) // isGameMaster() won't work here because it requires .GM to be on
            player->ADD_GOSSIP_ITEM(0, "<GM> Skip trash waves and spawn Rage Winterchill", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_WINTERCHILL_NOT_STARTED, _Creature->GetGUID());
    }
    else if (RageEncounter == DONE && AnetheronEncounter == NOT_STARTED)
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_ANETHERON, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        if (player->GetSession()->GetPermissions() > PERM_PLAYER) // isGameMaster() won't work here because it requires .GM to be on
            player->ADD_GOSSIP_ITEM(0, "<GM> Skip trash waves and spawn Anetheron", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_WINTERCHILL_KILLED, _Creature->GetGUID());
    }
    else if (RageEncounter == DONE && AnetheronEncounter == DONE)
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_RETREAT_JAINA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ANETHERON_KILLED, _Creature->GetGUID());
    }

    return true;
}

bool GossipSelect_npc_jaina_proudmoore(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    hyjalAI* ai = ((hyjalAI*)_Creature->AI());
    switch(action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_WINTERCHILL_STARTED, _Creature->GetGUID());
            ai->StartEvent(player);
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_ANETHERON_STARTED, _Creature->GetGUID());
            ai->FirstBossDead = true;
            ai->WaveCount = 9;
            ai->StartEvent(player);
            break;
        case GOSSIP_ACTION_INFO_DEF + 3:
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_ANETHERON_KILLED, _Creature->GetGUID());
            ai->Retreat();
            break;
        case GOSSIP_ACTION_INFO_DEF + 4: // GM Spawn Winterchill
            ai->StartEvent(player);
            ai->WaveCount = 8;
            break;
        case GOSSIP_ACTION_INFO_DEF + 5: // GM Spawn Anetheron
            ai->FirstBossDead = true;
            ai->WaveCount = 17;
            ai->StartEvent(player);
            break;
         case GOSSIP_ACTION_INFO_DEF:
            ai->Debug = !ai->Debug;
            debug_log("TSCR: HyjalAI - Debug mode has been toggled");
            break;
    }
    return true;
}

CreatureAI* GetAI_npc_thrall(Creature *_Creature)
{
    hyjalAI* ai = new hyjalAI(_Creature);

    ai->Reset();
    ai->EnterEvadeMode();

    ai->Spell[1].SpellId = SPELL_CHAIN_LIGHTNING;
    ai->Spell[1].CooldownMin = 3000;
    ai->Spell[1].CooldownMax = 8000;
    ai->Spell[1].TargetType = TARGETTYPE_VICTIM;

    ai->Spell[0].SpellId = SPELL_SUMMON_DIRE_WOLF;
    ai->Spell[0].CooldownStart = 9000;
    ai->Spell[0].CooldownMin = 40000;
    ai->Spell[0].CooldownMax = 80000;
    ai->Spell[0].TargetType = TARGETTYPE_RANDOM;

    return ai;
}

bool GossipHello_npc_thrall(Player *player, Creature *_Creature)
{
    hyjalAI* ai = ((hyjalAI*)_Creature->AI());

    uint32 AnetheronEvent = ai->GetInstanceData(DATA_ANETHERONEVENT);

    // Only let them start the Horde phases if Anetheron is dead.
    if (AnetheronEvent == DONE && ai->GetInstanceData(DATA_ALLIANCE_RETREAT))
    {
        uint32 KazrogalEvent = ai->GetInstanceData(DATA_KAZROGALEVENT);
        uint32 AzgalorEvent  = ai->GetInstanceData(DATA_AZGALOREVENT);

        if (player->isGameMaster())
            player->ADD_GOSSIP_ITEM(2, "[GM] Toggle Debug Timers", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        if (ai->EventBegun)
        {
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_THRALL_EVENT_IN_PROGRESS, _Creature->GetGUID());
        }
        else if (KazrogalEvent == NOT_STARTED)
        {
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_BEGIN_HORDE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            if (player->GetSession()->GetPermissions() > PERM_PLAYER) // isGameMaster() won't work here because it requires .GM to be on
                player->ADD_GOSSIP_ITEM(0, "<GM> Skip trash waves and spawn Kazrogal", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

            player->SEND_GOSSIP_MENU(GOSSIP_MENU_KAZROGAL_NOT_STARTED, _Creature->GetGUID());
        }
        else if (KazrogalEvent == DONE && AzgalorEvent != DONE && AzgalorEvent != IN_PROGRESS)
        {
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_AZGALOR, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

            if (player->GetSession()->GetPermissions() > PERM_PLAYER) // isGameMaster() won't work here because it requires .GM to be on
                player->ADD_GOSSIP_ITEM(0, "<GM> Skip trash waves and spawn Azgalor", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);

            player->SEND_GOSSIP_MENU(GOSSIP_MENU_KAZROGAL_KILLED, _Creature->GetGUID());
        }
        else if (AzgalorEvent == DONE)
        {
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_RETREAT_THRALL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_AZGALOR_KILLED, _Creature->GetGUID());
        }
    }
    else
    {
        // Anetheron has not been killed yet.
        player->SEND_GOSSIP_MENU(907, _Creature->GetGUID());
    }

    return true;
}

bool GossipSelect_npc_thrall(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    hyjalAI* ai = ((hyjalAI*)_Creature->AI());
    ai->DeSpawnVeins();//despawn the alliance veins
    switch(action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_KAZROGAL_STARTED, _Creature->GetGUID());
            ai->StartEvent(player);
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_AZGALOR_STARTED, _Creature->GetGUID());
            ai->FirstBossDead = true;
            ai->WaveCount = 9;
            ai->StartEvent(player);
            break;
        case GOSSIP_ACTION_INFO_DEF + 3:
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_AZGALOR_KILLED, _Creature->GetGUID());
            ai->Retreat();
            break;
        case GOSSIP_ACTION_INFO_DEF + 4:
            ai->WaveCount = 8;
            ai->StartEvent(player);
            break;
        case GOSSIP_ACTION_INFO_DEF + 5:
            ai->FirstBossDead = true;
            ai->WaveCount = 17;
            ai->StartEvent(player);
            break;
        case GOSSIP_ACTION_INFO_DEF:
            ai->Debug = !ai->Debug;
            debug_log("TSCR: HyjalAI - Debug mode has been toggled");
            break;
    }
    return true;
}

CreatureAI* GetAI_npc_tyrande_whisperwind(Creature *_Creature)
{
    hyjalAI* ai = new hyjalAI(_Creature);
    ai->Reset();
    ai->EnterEvadeMode();
    return ai;
}

bool GossipHello_npc_tyrande_whisperwind(Player* player, Creature* _Creature)
{
    hyjalAI* ai = ((hyjalAI*)_Creature->AI());
    uint32 AzgalorEvent = ai->GetInstanceData(DATA_AZGALOREVENT);

    // Only let them get item if Azgalor is dead.
    if (AzgalorEvent == DONE)
    {
        if (!player->HasItemCount(ITEM_TEAR_OF_GODDESS, 1))
        {
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_TYRANDE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_TYRANDE, _Creature->GetGUID());
    }
    else
    {
        player->SEND_GOSSIP_MENU(907, _Creature->GetGUID()); // Azgalor not killed yet
    }

    return true;
}

bool GossipSelect_npc_tyrande_whisperwind(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF)
    {
            ItemPosCountVec dest;
            uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, ITEM_TEAR_OF_GODDESS, 1);
            if (msg == EQUIP_ERR_OK)
            {
                 Item* item = player->StoreNewItem(dest, ITEM_TEAR_OF_GODDESS, true);
                 if(item && player)
                     player->SendNewItem(item,1,true,false,true);
            }
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_TYRANDE, _Creature->GetGUID());
            hyjalAI* ai = ((hyjalAI*)_Creature->AI());
    }
    return true;
}

void AddSC_hyjal()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_jaina_proudmoore";
    newscript->GetAI = &GetAI_npc_jaina_proudmoore;
    newscript->pGossipHello = &GossipHello_npc_jaina_proudmoore;
    newscript->pGossipSelect = &GossipSelect_npc_jaina_proudmoore;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_thrall";
    newscript->GetAI = &GetAI_npc_thrall;
    newscript->pGossipHello = &GossipHello_npc_thrall;
    newscript->pGossipSelect = &GossipSelect_npc_thrall;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_tyrande_whisperwind";
    newscript->pGossipHello = &GossipHello_npc_tyrande_whisperwind;
    newscript->pGossipSelect = &GossipSelect_npc_tyrande_whisperwind;
    newscript->GetAI = &GetAI_npc_tyrande_whisperwind;
    newscript->RegisterSelf();
}

