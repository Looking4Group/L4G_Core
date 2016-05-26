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
SDName: Zulfarrak
SD%Complete: 70
SDComment: TODO: gossips ; make blastfuse blast the doors with spell
SDCategory: Zul'Farrak
EndScriptData */

/* ContentData
npc_sergeant_bly
npc_weegli_blastfuse
EndContentData */

#include "precompiled.h"
#include "def_zul_farrak.h"

/*######
## npc_sergeant_bly
######*/

#define FACTION_HOSTILE             14
#define FACTION_FRIENDLY            35

#define SPELL_SHIELD_BASH           11972
#define SPELL_REVENGE               12170

#define GOSSIP_BLY                  "[PH] In that case, i will take my reward!"

struct npc_sergeant_blyAI : public ScriptedAI
{
    npc_sergeant_blyAI(Creature *c) : ScriptedAI(c) {}

    uint32 ShieldBash_Timer;
    uint32 Revenge_Timer;                                   //this is wrong, spell should never be used unless m_creature->getVictim() dodge, parry or block attack. Trinity support required.

    void Reset()
    {
        ShieldBash_Timer = 5000;
        Revenge_Timer = 8000;

        m_creature->setFaction(FACTION_FRIENDLY);
    }

    void EnterCombat(Unit *who) {}

    void JustDied(Unit *victim) {}

    void UpdateAI(const uint32 diff)
    {
        if( !UpdateVictim() )
            return;

        if( ShieldBash_Timer < diff )
        {
            DoCast(m_creature->getVictim(),SPELL_SHIELD_BASH);
            ShieldBash_Timer = 15000;
        }else ShieldBash_Timer -= diff;

        if( Revenge_Timer < diff )
        {
            DoCast(m_creature->getVictim(),SPELL_REVENGE);
            Revenge_Timer = 10000;
        }else Revenge_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_npc_sergeant_bly(Creature *_Creature)
{
    return new npc_sergeant_blyAI (_Creature);
}

bool GossipHello_npc_sergeant_bly(Player *player, Creature *_Creature )
{
    ScriptedInstance* pInstance = (ScriptedInstance*)_Creature->GetInstanceData();
    if(!pInstance)
        return false;
    if( pInstance->GetData(DATA_PYRAMID_BATTLE) == DONE )
    {
    player->ADD_GOSSIP_ITEM(1, GOSSIP_BLY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
    player->SEND_GOSSIP_MENU(1517, _Creature->GetGUID());
    }
    else if( pInstance->GetData(DATA_PYRAMID_BATTLE) == IN_PROGRESS )
        player->SEND_GOSSIP_MENU(1516, _Creature->GetGUID());
    else
        player->SEND_GOSSIP_MENU(1515, _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_sergeant_bly(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if( action == GOSSIP_ACTION_INFO_DEF)
    {
        player->CLOSE_GOSSIP_MENU();
        _Creature->setFaction(FACTION_HOSTILE);
        ((npc_sergeant_blyAI*)_Creature->AI())->AttackStart(player);
    }
    return true;
}

/*######
## npc_weegli_blastfuse
######*/

#define SPELL_BOMB                  8858
#define SPELL_GOBLIN_LAND_MINE      21688
#define SPELL_SHOOT                 6660
#define SPELL_WEEGLIS_BARREL        10772 // this one should open door

#define GOSSIP_WEEGLI               "[PH] Please blow up the door."

struct npc_weegli_blastfuseAI : public ScriptedAI
{
    npc_weegli_blastfuseAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    void Reset() {}

    void EnterCombat(Unit *who) {}

    void MovementInform(uint32 motiontype ,uint32 wpid)
    {
        if (motiontype != POINT_MOTION_TYPE)
            return;

        if (wpid == 2)
        {
            // do things with blowing up the doors
            m_creature->GetMotionMaster()->MovePoint(3,1876.11,1201.75,8.88);
        }
        if (wpid == 3 && pInstance)
            pInstance->SetData(DATA_DOOR_EVENT,DONE); // after implementing spell remove it

    }

    void JustDied(Unit *victim)
    {
        if (pInstance)
            pInstance->SetData(DATA_DOOR_EVENT,FAIL);
    }

    void UpdateAI(const uint32 diff)
    {
        if( !UpdateVictim() )
            return;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_npc_weegli_blastfuse(Creature *_Creature)
{
    return new npc_weegli_blastfuseAI (_Creature);
}

bool GossipHello_npc_weegli_blastfuse(Player *player, Creature *_Creature )
{
    ScriptedInstance* pInstance = (ScriptedInstance*)_Creature->GetInstanceData();
    if(!pInstance)
        return false;

    if( pInstance->GetData(DATA_PYRAMID_BATTLE) == DONE )
    {
        player->ADD_GOSSIP_ITEM(1, GOSSIP_WEEGLI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        player->SEND_GOSSIP_MENU(1514, _Creature->GetGUID());
    }
    else if( pInstance->GetData(DATA_PYRAMID_BATTLE) == IN_PROGRESS )
        player->SEND_GOSSIP_MENU(1513, _Creature->GetGUID());
    else
    player->SEND_GOSSIP_MENU(1511, _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_weegli_blastfuse(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    ScriptedInstance* pInstance = (ScriptedInstance*)_Creature->GetInstanceData();
    if (!pInstance)
        return false;

    if( action == GOSSIP_ACTION_INFO_DEF)
    {
        player->CLOSE_GOSSIP_MENU();
        pInstance->SetData(DATA_DOOR_EVENT,DONE);
        _Creature->GetMotionMaster()->MovePoint(2,1856.92,1146.26,15.15);
    }
    return true;
}

void AddSC_zulfarrak()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_sergeant_bly";
    newscript->GetAI = &GetAI_npc_sergeant_bly;
    newscript->pGossipHello =  &GossipHello_npc_sergeant_bly;
    newscript->pGossipSelect = &GossipSelect_npc_sergeant_bly;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_weegli_blastfuse";
    newscript->GetAI = &GetAI_npc_weegli_blastfuse;
    newscript->pGossipHello =  &GossipHello_npc_weegli_blastfuse;
    newscript->pGossipSelect = &GossipSelect_npc_weegli_blastfuse;
    newscript->RegisterSelf();
}

