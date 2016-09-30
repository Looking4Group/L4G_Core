#include "precompiled.h"
#include "slave_pens.h"

#define SPELL_HAMSTRING     9080
#define SPELL_HEAD_CRACK    16172
#define YELL_AGGRO          -678
#define YELL_OOC1           -679
#define YELL_OOC2           -680
#define YELL_OOC3           -681
#define YELL_OOC4           -683
#define YELL_OOC5           -684
#define YELL_OOC6           -685


struct mob_coilfang_slavehandlerAI : public ScriptedAI
{
    mob_coilfang_slavehandlerAI(Creature *c) : ScriptedAI(c) {}

    uint32 hamstringtimer;
    uint32 headcracktimer;
    uint32 yelltimer;

    void Reset()
    {
        hamstringtimer = urand(5800,6200);
        headcracktimer = 11100;
        yelltimer = urand(60000,120000);
    }

    void JustDied(Unit* )
    {
        StartRun();
    }

    void StartRun()
    {
        std::list<Creature*> alist= FindAllCreaturesWithEntry(17963, 100);
        std::list<Creature*> blist= FindAllCreaturesWithEntry(17964, 100);
        for(std::list<Creature*>::iterator itr = blist.begin(); itr != blist.end(); itr++)
            alist.push_front(*itr);
        for(std::list<Creature*>::iterator itr = alist.begin(); itr != alist.end(); itr++)
        {
            if ((*itr)->GetFormation() == me->GetFormation())
            {
                if ((*itr)->isAlive())
                {
                    (*itr)->RemoveAllAuras();
                    (*itr)->DeleteThreatList();
                    (*itr)->CombatStop();

                    if (me->GetPositionY() > -150.0f)
                        (*itr)->GetMotionMaster()->MovePoint(1, 115.0f, -98.0f, -1.5f);
                    else
                        (*itr)->GetMotionMaster()->MovePoint(2, -102.0f, -121.0f, -2.1f);

                    (*itr)->ForcedDespawn(7000);
                } 
            }
        }
    }

    void EnterCombat(Unit* attacker)
    {
        me->Yell(YELL_AGGRO,0,0);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->isInCombat())
            if(yelltimer < diff)
            {
                me->Yell(RAND(YELL_OOC1,YELL_OOC2,YELL_OOC3,YELL_OOC4,YELL_OOC5,YELL_OOC6),0,0);
                yelltimer = urand(60000,120000);
            }
            else
                yelltimer -=diff;

        if(!UpdateVictim())
            return;

        if(hamstringtimer < diff)
        {
            AddSpellToCast(SPELL_HAMSTRING);
            hamstringtimer = 9000;
        }
        else
            hamstringtimer -= diff;

        if(headcracktimer < diff)
        {
            AddSpellToCast(SPELL_HEAD_CRACK,CAST_RANDOM);
            headcracktimer = urand(20000,25000);
        }
        else
            headcracktimer -= diff;

        DoMeleeAttackIfReady();
        CastNextSpellIfAnyAndReady(diff);
    }
};

CreatureAI* GetAI_mob_coilfang_slavehandler(Creature *_creature)
{
    return new mob_coilfang_slavehandlerAI (_creature);
}

// SV
#define SPELL_DISARM        6713
#define SPELL_GEYSER        10987
#define SPELL_FRENZY        8269

struct npc_coilfang_slavemasterAI : public ScriptedAI
{
    npc_coilfang_slavemasterAI(Creature *c) : ScriptedAI(c) {}

    uint32 hamstringtimer;
    uint32 headcracktimer;
    uint32 yelltimer;

    bool frenzy;

    void Reset()
    {
        hamstringtimer = urand(5800,6200);
        headcracktimer = 11100;
        yelltimer = urand(60000,120000);
        frenzy = false;
    }

    void JustDied(Unit* )
    {
        StartRun();
    }

    void StartRun()
    {
        std::list<Creature*> alist= FindAllCreaturesWithEntry(17799, 100);
        for(std::list<Creature*>::iterator itr = alist.begin(); itr != alist.end(); itr++)
        {
            if ((*itr)->GetFormation() == me->GetFormation())
            {
                if ((*itr)->isAlive())
                {
                    (*itr)->RemoveAllAuras();
                    (*itr)->DeleteThreatList();
                    (*itr)->CombatStop();
                    (*itr)->GetMotionMaster()->MovePoint(1, -149.0f, -295.0f, -7.6f);
                    (*itr)->ForcedDespawn(7000);
                } 
            }
        }
    }

    void EnterCombat(Unit* attacker)
    {
        me->Yell(YELL_AGGRO,0,0);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->isInCombat())
            if(yelltimer < diff)
            {
                me->Yell(RAND(YELL_OOC1,YELL_OOC2,YELL_OOC3,YELL_OOC4,YELL_OOC5,YELL_OOC6),0,0);
                yelltimer = urand(60000,120000);
            }
            else
                yelltimer -=diff;

        if(!UpdateVictim())
            return;

        if(hamstringtimer < diff)
        {
            AddSpellToCast(SPELL_DISARM);
            hamstringtimer = 9000;
        }
        else
            hamstringtimer -= diff;

        if(headcracktimer < diff)
        {
            AddSpellToCast(SPELL_GEYSER);
            headcracktimer = urand(20000,25000);
        }
        else
            headcracktimer -= diff;

        if (HealthBelowPct(20.0f) && !frenzy)
        {
            ForceSpellCast(me, SPELL_FRENZY, INTERRUPT_AND_CAST_INSTANTLY);
            frenzy = true;
        }

        DoMeleeAttackIfReady();
        CastNextSpellIfAnyAndReady(diff);
    }
};

CreatureAI* GetAI_npc_coilfang_slavemaster(Creature *_creature)
{
    return new npc_coilfang_slavemasterAI (_creature);
}


enum Misc
{
    SPELL_MARK_OF_BITE          = 34906,
    COILFANG_CHAMPION           = 17957,
    COILFANG_SOOTHSAYER         = 17960,
    COILFANG_ENCHANTRESS        = 17961,
    QUEST_LOST_IN_ACTION        = 9738,
    NPC_NATURALIST_BITE_ENTRY   = 17893
};

struct npc_naturalist_biteAI : public ScriptedAI
{
    npc_naturalist_biteAI(Creature *c) : ScriptedAI(c) {}

    bool HasYelled, HasSummoned;
    uint32 GossipTimer;

    void Reset()
    {
        HasYelled = false;
        HasSummoned = false;
        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        GossipTimer = 0;
    }

    void EnterCombat(Unit *who)
    {
        me->Say("Uh oh! It would appear that all of the noise you've been making has attracted some unwanted attention!", 0, 0);
    }

    void MoveInLineOfSight(Unit *u)
    {
        if (u->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(u, 50.0f) && !HasYelled)
        {
            me->Yell("Hey! Over here! Yeah, over here... I'm in the cage!!", 0, 0);
            HasYelled= true;
        }
    }

    void JustSummoned(Creature* summoned)
    {
        summoned->AI()->AttackStart(me);
    }

    void SummonMobs()
    {
        me->SummonCreature(COILFANG_CHAMPION, -138.0847f, -758.946f, 37.892f, 3.699f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 3*MINUTE*IN_MILISECONDS);
        me->SummonCreature(COILFANG_SOOTHSAYER, -141.585f, -754.85f, 37.892f, 3.762f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 3*MINUTE*IN_MILISECONDS);
        me->SummonCreature(COILFANG_ENCHANTRESS, -144.608f, -751.4299f, 37.8923f, 3.762f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 3*MINUTE*IN_MILISECONDS);
        
        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        GossipTimer = 45000;
        HasSummoned = true;
    }

    void UpdateAI(const uint32 diff)
    {
        if (GossipTimer <= diff)
            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        else
            GossipTimer -= diff;
        
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

bool GossipHello_npc_naturalist_bite(Player *player, Creature *creature)
{
    ScriptedInstance* instance = creature->GetInstanceData();

    if (!instance)
        return false;

    if (player->GetQuestStatus(QUEST_LOST_IN_ACTION) == QUEST_STATUS_INCOMPLETE)
        player->KilledMonster(NPC_NATURALIST_BITE_ENTRY, NULL);

    if (npc_naturalist_biteAI* naturalist = dynamic_cast<npc_naturalist_biteAI*>(creature->AI()))
        if (!naturalist->HasSummoned)
            player->ADD_GOSSIP_ITEM(0, "Alright, Bite, I'll let you out.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

    if (instance->GetData(TYPE_NATURALIST_EVENT) == DONE && !player->HasAura(SPELL_MARK_OF_BITE, 0))
        player->ADD_GOSSIP_ITEM(0, "Naturalist, please grant me your boon.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
    
    //TODO: Add correct gossip texts
    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
    return true;
}

bool GossipSelect_npc_naturalist_bite(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    ScriptedInstance* instance = creature->GetInstanceData();

    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->CLOSE_GOSSIP_MENU();
            if (instance)
            {
                instance->HandleGameObject(instance->GetData64(DATA_CAGE), true);
                instance->SetData(TYPE_NATURALIST_EVENT, DONE);
                dynamic_cast<npc_naturalist_biteAI*>(creature->AI())->SummonMobs();
            }
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            player->CLOSE_GOSSIP_MENU();
            creature->CastSpell(player, SPELL_MARK_OF_BITE, true);
            break;
    }
    return true;
}

CreatureAI* GetAI_npc_naturalist_bite(Creature *_creature)
{
    return new npc_naturalist_biteAI(_creature);
}

void AddSC_slave_pens_trash()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="mob_coilfang_slavehandler";
    newscript->GetAI = &GetAI_mob_coilfang_slavehandler;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_coilfang_slavemaster";
    newscript->GetAI = &GetAI_npc_coilfang_slavemaster;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_naturalist_bite";
    newscript->pGossipHello = &GossipHello_npc_naturalist_bite;
    newscript->pGossipSelect = &GossipSelect_npc_naturalist_bite;
    newscript->GetAI = &GetAI_npc_naturalist_bite;
    newscript->RegisterSelf();
}
