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
SDName: Eastern_Plaguelands
SD%Complete: 100
SDComment: Quest support: 5211, 5742. Special vendor Augustus the Touched
SDCategory: Eastern Plaguelands
EndScriptData */

/* ContentData
mobs_ghoul_flayer
npc_augustus_the_touched
npc_darrowshire_spirit
npc_tirion_fordring
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"

//id8530 - cannibal ghoul
//id8531 - gibbering ghoul
//id8532 - diseased flayer

struct mobs_ghoul_flayerAI : public ScriptedAI
{
    mobs_ghoul_flayerAI(Creature *c) : ScriptedAI(c) {}

    void Reset() { }

    void JustDied(Unit* Killer)
    {
        if( Killer->GetTypeId() == TYPEID_PLAYER )
            DoSpawnCreature(11064, 0, 0, 0, 0, TEMPSUMMON_TIMED_DESPAWN, 60000);
    }
};

CreatureAI* GetAI_mobs_ghoul_flayer(Creature *_Creature)
{
    return new mobs_ghoul_flayerAI (_Creature);
}

/*######
## npc_augustus_the_touched
######*/

bool GossipHello_npc_augustus_the_touched(Player *player, Creature *_Creature)
{
    if( _Creature->isQuestGiver() )
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if( _Creature->isVendor() && player->GetQuestRewardStatus(6164) )
        player->ADD_GOSSIP_ITEM(1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(),_Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_augustus_the_touched(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if( action == GOSSIP_ACTION_TRADE )
        player->SEND_VENDORLIST( _Creature->GetGUID() );
    return true;
}

/*######
## npc_darrowshire_spirit
######*/

#define SPELL_SPIRIT_SPAWNIN    17321

struct npc_darrowshire_spiritAI : public ScriptedAI
{
    npc_darrowshire_spiritAI(Creature *c) : ScriptedAI(c) {}

    void Reset()
    {
        DoCast(m_creature,SPELL_SPIRIT_SPAWNIN);
        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    }

    void EnterCombat(Unit *who) { }

};
CreatureAI* GetAI_npc_darrowshire_spirit(Creature *_Creature)
{
    return new npc_darrowshire_spiritAI (_Creature);
}

bool GossipHello_npc_darrowshire_spirit(Player *player, Creature *_Creature)
{
    player->SEND_GOSSIP_MENU(3873,_Creature->GetGUID());
    player->TalkedToCreature(_Creature->GetEntry(), _Creature->GetGUID());
    _Creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    return true;
}

/*######
## npc_tirion_fordring
######*/

bool GossipHello_npc_tirion_fordring(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if (player->GetQuestStatus(5742) == QUEST_STATUS_INCOMPLETE && player->getStandState() == PLAYER_STATE_SIT )
        player->ADD_GOSSIP_ITEM( 0, "I am ready to hear your tale, Tirion.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_tirion_fordring(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM( 0, "Thank you, Tirion.  What of your identity?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(4493, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM( 0, "That is terrible.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            player->SEND_GOSSIP_MENU(4494, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM( 0, "I will, Tirion.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            player->SEND_GOSSIP_MENU(4495, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(5742);
            break;
    }
    return true;
}

#define SPELL_SHOOT             23073//6660
#define NPC_INJURED_PEASANT     14484
#define NPC_PLAGUED_PEASANT     14485
#define NPC_SCOURGE_FOOTSOLDIER 14486
#define SPELL_DEATHS_DOOR       23127
#define SPELL_SEETHING_PLAGUE   23072
#define NPC_THE_CLEANER         14503
#define QUEST_THE_BALANCE_OF_LIGHT_AND_SHADOW   7622

struct mobs_scourge_archerAI : public ScriptedAI
{
    mobs_scourge_archerAI(Creature *c) : ScriptedAI(c) 
    {}

    uint32 Shoot_Timer;

    void MoveInLineOfSight(Unit * unit)
    {
        if(me->isInCombat())
            return;

        if(unit->GetEntry() == NPC_INJURED_PEASANT)
            AttackStart(unit);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->getVictim())
            return;

        if (Shoot_Timer <= diff)
        {
            if(Unit * target = GetClosestCreatureWithEntry(me, RAND(NPC_INJURED_PEASANT, NPC_PLAGUED_PEASANT) , 50))
            {
                AddSpellToCast(target, SPELL_SHOOT, true);
                Shoot_Timer = 2000;
            }
        }
        else Shoot_Timer -= diff;

        CastNextSpellIfAnyAndReady();    
    }
};

CreatureAI* GetAI_mobs_scourge_archer(Creature *_Creature)
{
    return new mobs_scourge_archerAI (_Creature);
}

struct trigger_epic_staffAI : public TriggerAI
{
    trigger_epic_staffAI(Creature *c) : TriggerAI(c) { }

    uint32 Summon_Timer;
    uint32 Summon_Footsoldier_Timer;
    uint32 Summon_Counter;
    uint32 Counter;
    uint32 FailCounter;
    uint64 priest;

    void Reset()
    {
        Summon_Timer = 0;
        Summon_Footsoldier_Timer = 0;
        Summon_Counter = 0;
        Counter = 0;
        FailCounter = 0;
        priest = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (Summon_Footsoldier_Timer < diff)
        {
            for(int i = 0; i<3; i++)
            {
                float x,y,z;
                me->GetNearPoint(x,y,z, 0.0f, 7.0f, frand(0, 2*M_PI));
                me->SummonCreature(NPC_SCOURGE_FOOTSOLDIER, x,y,z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000);
            }
            Summon_Footsoldier_Timer = 20000;
        }
        else Summon_Footsoldier_Timer -= diff;

        if (Summon_Timer <= diff && Summon_Counter < 6)
        {
            for(int i = 0; i < 9; i++)
            {
                float x,y,z;
                me->GetNearPoint(x,y,z, 0.0f, 6.0f, frand(0, 2*M_PI));
                me->SummonCreature(NPC_INJURED_PEASANT, x,y,z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 45000);
            }
            for(int i = 0; i < 3; i++)
            {
                float x,y,z;
                me->GetNearPoint(x,y,z, 0.0f, 6.0f, frand(0, 2*M_PI));
                me->SummonCreature(NPC_PLAGUED_PEASANT, x,y,z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 45000);
            }
            Summon_Timer = 40000;
            Summon_Counter++;
        }
        else Summon_Timer -= diff;

        if ((Counter >= 50 || FailCounter >= 15) && Summon_Counter < 7)
        {
            if(Player * player = (Player*)(me->GetUnit(priest)))
            {
                if(FailCounter <= 15)
                    player->AreaExploredOrEventHappens(QUEST_THE_BALANCE_OF_LIGHT_AND_SHADOW);
                else
                    player->FailQuest(QUEST_THE_BALANCE_OF_LIGHT_AND_SHADOW);
            }
            Summon_Counter = 7;
        }
    }

    void SummonedCreatureDespawn(Creature * creature)
    {
        if(creature->GetEntry() == NPC_INJURED_PEASANT || creature->GetEntry() == NPC_PLAGUED_PEASANT)
        { 
            if(creature->isAlive())
                Counter++;
            else
                FailCounter++;
        }
    }

    void VerifyPlayer(Unit * unit)
    {
        Player * player;
        if(unit->GetTypeId() == TYPEID_PLAYER)
        {
            player = (Player*)unit;
        }
        else if(unit->GetOwner() && unit->GetOwner()->GetTypeId() == TYPEID_PLAYER)
        {
            player = (Player*)unit->GetOwner();
        }
        else 
            return;
            
        if(priest == player->GetGUID())
            return;

        if(player->GetQuestStatus(QUEST_THE_BALANCE_OF_LIGHT_AND_SHADOW) == QUEST_STATUS_INCOMPLETE)
        {
            if(!priest)
            {
                priest = unit->GetGUID();
                return;
            }
        }

        me->SummonCreature(NPC_THE_CLEANER, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
    }
};

CreatureAI* GetAI_trigger_epic_staff(Creature *_Creature)
{
    return new trigger_epic_staffAI (_Creature);
}

struct mobs_Scourge_FootsoldierAI : public ScriptedAI
{
    mobs_Scourge_FootsoldierAI(Creature *c) : ScriptedAI(c) 
    {}

    uint64 Summoner;

    void MoveInLineOfSight(Unit * unit)
    {
        if(me->isInCombat())
            return;

        if(unit->GetTypeId() == TYPEID_PLAYER)
            AttackStart(unit);
    }

    void IsSummonedBy(Unit * summoner)
    {
        Summoner = summoner->GetGUID();
    }

    void DamageTaken(Unit *pDone_by, uint32 &uiDamage)
    {
        if(Creature * trigger = (Creature*)me->GetUnit(Summoner))
        {
            ((trigger_epic_staffAI*)trigger->AI())->VerifyPlayer(pDone_by);
        }
    }
};

CreatureAI* GetAI_mobs_Scourge_Footsoldier(Creature *_Creature)
{
    return new mobs_Scourge_FootsoldierAI (_Creature);
}

struct mobs_peasantsAI : public ScriptedAI
{
    mobs_peasantsAI(Creature *c) : ScriptedAI(c) 
    {
    }

    uint32 DeathsDoor_Timer;
    uint64 Summoner;

    void EnterEvadeMode()
    {
        return;
    }

    void AttackStart(Unit * unit)
    {
        return;
    }

    void UpdateAI(const uint32 diff)
    {
        if (DeathsDoor_Timer <= diff)
        {
            if(!urand(0, 9))
                AddSpellToCast(me, SPELL_DEATHS_DOOR, true);
            DeathsDoor_Timer = 15000;
        }
        else DeathsDoor_Timer -= diff;

        CastNextSpellIfAnyAndReady();    
    }

    void IsSummonedBy(Unit * summoner)
    {
        Summoner = summoner->GetGUID();
    }

    void SpellHit(Unit * caster, const SpellEntry * spell)
    {
        if(Creature * trigger = (Creature*)me->GetUnit(Summoner))
        {
            ((trigger_epic_staffAI*)trigger->AI())->VerifyPlayer(caster);
        }
    }
};

CreatureAI* GetAI_mobs_peasants(Creature *_Creature)
{
    return new mobs_peasantsAI(_Creature);   
}

struct mobs_plagued_peasantAI : public mobs_peasantsAI
{
    mobs_plagued_peasantAI(Creature *c) : mobs_peasantsAI(c) { }

    uint32 SeethingPlague_Timer;

    void UpdateAI(const uint32 diff)
    {
        if (SeethingPlague_Timer <= diff)
        {
            if(!urand(0, 2))
                AddSpellToCast(me, SPELL_SEETHING_PLAGUE, true);
            SeethingPlague_Timer = 10000;
        }
        else SeethingPlague_Timer -= diff;

        mobs_peasantsAI::UpdateAI(diff);
    }
};

CreatureAI* GetAI_mobs_plagued_peasant(Creature *_Creature)
{
    return new mobs_plagued_peasantAI (_Creature);
}

void AddSC_eastern_plaguelands()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="mobs_ghoul_flayer";
    newscript->GetAI = &GetAI_mobs_ghoul_flayer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_augustus_the_touched";
    newscript->pGossipHello = &GossipHello_npc_augustus_the_touched;
    newscript->pGossipSelect = &GossipSelect_npc_augustus_the_touched;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_darrowshire_spirit";
    newscript->GetAI = &GetAI_npc_darrowshire_spirit;
    newscript->pGossipHello = &GossipHello_npc_darrowshire_spirit;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_tirion_fordring";
    newscript->pGossipHello =  &GossipHello_npc_tirion_fordring;
    newscript->pGossipSelect = &GossipSelect_npc_tirion_fordring;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mobs_scourge_archer";
    newscript->GetAI = &GetAI_mobs_scourge_archer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mobs_Scourge_Footsoldier";
    newscript->GetAI = &GetAI_mobs_Scourge_Footsoldier;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mobs_peasants";
    newscript->GetAI = &GetAI_mobs_peasants;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mobs_plagued_peasant";
    newscript->GetAI = &GetAI_mobs_plagued_peasant;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="trigger_epic_staff";
    newscript->GetAI = &GetAI_trigger_epic_staff;
    newscript->RegisterSelf();
}
