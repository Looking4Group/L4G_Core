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
SDName: Uldaman
SD%Complete: 100
SDComment: Quest support: 2240, 2278 + 1 trash mob
SDCategory: Uldaman
EndScriptData */

/* ContentData
mob_jadespine_basilisk
npc_lore_keeper_of_norgannon
go_keystone_chamber
at_map_chamber
EndContentData */

#include "precompiled.h"
#include "def_uldaman.h"

#define QUEST_HIDDEN_CHAMBER 2240



/*######
## mob_jadespine_basilisk
######*/

#define SPELL_CSLUMBER        3636

struct mob_jadespine_basiliskAI : public ScriptedAI
{
    mob_jadespine_basiliskAI(Creature *c) : ScriptedAI(c) {}

    uint32 Cslumber_Timer;

    void Reset()
    {
        Cslumber_Timer = 2000;
    }

    void EnterCombat(Unit *who)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        //Cslumber_Timer
        if (Cslumber_Timer < diff)
        {
            //Cast
            // DoCast(m_creature->getVictim(),SPELL_CSLUMBER);
            m_creature->CastSpell(m_creature->getVictim(),SPELL_CSLUMBER, true);

            //Stop attacking target thast asleep and pick new target
            Cslumber_Timer = 28000;

            Unit* Target = SelectUnit(SELECT_TARGET_TOPAGGRO, 0);

            if (!Target || Target == m_creature->getVictim())
                Target = SelectUnit(SELECT_TARGET_RANDOM, 0);

            if (Target)
                m_creature->TauntApply(Target);

        }else Cslumber_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_jadespine_basilisk(Creature *_Creature)
{
    return new mob_jadespine_basiliskAI (_Creature);
}

/*######
## npc_lore_keeper_of_norgannon
######*/

bool GossipHello_npc_lore_keeper_of_norgannon(Player *player, Creature *_Creature)
{
    if (player->GetQuestStatus(2278) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, "Who are the Earthen?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(1079, _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_lore_keeper_of_norgannon(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM( 0, "What is a \"subterranean being matrix\"?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(1080, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM( 0, "What are the anomalies you speak of?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->SEND_GOSSIP_MENU(1081, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM( 0, "What is a resilient foundation of construction?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            player->SEND_GOSSIP_MENU(1082, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->ADD_GOSSIP_ITEM( 0, "So... the Earthen were made out of stone?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(1083, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
            player->ADD_GOSSIP_ITEM( 0, "Anything else I should know about the Earthen?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
            player->SEND_GOSSIP_MENU(1084, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+6:
            player->ADD_GOSSIP_ITEM( 0, "I think I understand the Creators' design intent for the Earthen now. What are the Earthen's anomalies that you spoke of earlier?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+7);
            player->SEND_GOSSIP_MENU(1085, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+7:
            player->ADD_GOSSIP_ITEM( 0, "What high-stress environments would cause the Earthen to destabilize?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+8);
            player->SEND_GOSSIP_MENU(1086, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+8:
            player->ADD_GOSSIP_ITEM( 0, "What happens when the Earthen destabilize?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+9);
            player->SEND_GOSSIP_MENU(1087, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+9:
            player->ADD_GOSSIP_ITEM( 0, "Troggs?! Are the troggs you mention the same as the ones in the world today?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+10);
            player->SEND_GOSSIP_MENU(1088, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+10:
            player->ADD_GOSSIP_ITEM( 0, "You mentioned two results when the Earthen destabilize. What is the second?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+11);
            player->SEND_GOSSIP_MENU(1089, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+11:
            player->ADD_GOSSIP_ITEM( 0, "Dwarves!!! Now you're telling me that dwarves originally came from the Earthen?!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+12);
            player->SEND_GOSSIP_MENU(1090, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+12:
            player->ADD_GOSSIP_ITEM( 0, "These dwarves are the same ones today, yes? Do the dwarves maintain any other links to the Earthen?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+13);
            player->SEND_GOSSIP_MENU(1091, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+13:
            player->ADD_GOSSIP_ITEM( 0, "Who are the Creators?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+14);
            player->SEND_GOSSIP_MENU(1092, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+14:
            player->ADD_GOSSIP_ITEM( 0, "This is a lot to think about.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+15);
            player->SEND_GOSSIP_MENU(1093, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+15:
            player->ADD_GOSSIP_ITEM( 0, "I will access the discs now.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+16);
            player->SEND_GOSSIP_MENU(1094, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+16:
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(2278);
            break;
    }
    return true;
}


/*######
## go_keystone_chamber
######*/

bool GOUse_go_keystone_chamber(Player *player, GameObject* go)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)go->GetInstanceData();

    if(!pInstance)
        return false;

    if (pInstance)
        pInstance->SetData(DATA_IRONAYA_SEAL, IN_PROGRESS); //door animation and save state.

    return false;
}


/*######
## at_map_chamber
######*/

bool AT_map_chamber(Player *pPlayer, AreaTriggerEntry const* at)
{
    if (pPlayer && ((Player*)pPlayer)->GetQuestStatus(QUEST_HIDDEN_CHAMBER) == QUEST_STATUS_INCOMPLETE)
        pPlayer->AreaExploredOrEventHappens(QUEST_HIDDEN_CHAMBER);

    return true;
}



void AddSC_uldaman()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="mob_jadespine_basilisk";
    newscript->GetAI = &GetAI_mob_jadespine_basilisk;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_lore_keeper_of_norgannon";
    newscript->pGossipHello = &GossipHello_npc_lore_keeper_of_norgannon;
    newscript->pGossipSelect = &GossipSelect_npc_lore_keeper_of_norgannon;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name="go_keystone_chamber";
    newscript->pGOUse = &GOUse_go_keystone_chamber;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="at_map_chamber";
    newscript->pAreaTrigger = &AT_map_chamber;
    newscript->RegisterSelf();
}

