#include "precompiled.h"

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


#define SPELL_MARK_OF_BITE         34906
#define MOB_COILFANG_CHAMPION      17957
#define MOB_COILFANG_ENCHANTRESS   17961
#define MOB_COILFANG_SOOTHSAYER    17960

struct npc_naturalist_biteAI : public ScriptedAI
{
    npc_naturalist_biteAI(Creature *c) : ScriptedAI(c) {}

    bool screamed, buffed;

    void Reset()
    {
        screamed = false;

    }

    void MoveInLineOfSight(Unit *u)
    {
        if (!screamed)
        {
            m_creature->Yell("Hier bin ich! Holt mich hier raus!", LANG_UNIVERSAL, u->GetGUID());
            screamed = true;
        }
    }

    void BuffPlayers(Player *player)
    {
        if (!buffed)
        {
            //Buff every Player in map..
            Map *map = me->GetMap();
            if(!map->IsDungeon()) return;
            Map::PlayerList const &PlayerList = map->GetPlayers();
            for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (Unit* i_pl = i->getSource()->ToUnit())
                    if(i_pl->isAlive())
                        me->CastSpell(i_pl, SPELL_MARK_OF_BITE, true);                    
            }
            GameObject *go = FindGameObject(182094, 20, me);
            go->SetGoState(GO_STATE_ACTIVE);
            Creature *c1 = me->SummonCreature(MOB_COILFANG_CHAMPION, -120.0f, -752.0f, 37.5f, 0, TEMPSUMMON_CORPSE_DESPAWN, 12000);
            Creature *c2 = me->SummonCreature(MOB_COILFANG_ENCHANTRESS, -120.0f, -752.0f, 37.5f, 0, TEMPSUMMON_CORPSE_DESPAWN, 12000);
            Creature *c3 = me->SummonCreature(MOB_COILFANG_SOOTHSAYER, -120.0f, -752.0f, 37.5f, 0, TEMPSUMMON_CORPSE_DESPAWN, 12000);
            c1->GetMotionMaster()->MoveChase(player);
            c1->Attack(player, true);
            c2->Attack(player, false);
            c3->Attack(player, false);
            //me->GetMotionMaster()->MovePoint(0, -195.0f, -797.0f, 44.0f);
        }

    }

};

CreatureAI* GetAI_npc_naturalist_bite(Creature *_creature)
{
    return new npc_naturalist_biteAI(_creature);
}


bool GossipHello_npc_naturalist_bite(Player *Player, Creature *Creature)
{
    Player->ADD_GOSSIP_ITEM(0,"Ich helfe euch...",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1 );
    Player->PlayerTalkClass->SendGossipMenu(1,Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_naturalist_bite(Player* Player, Creature* Creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        ((npc_naturalist_biteAI*)Creature->AI())->BuffPlayers(Player);
        Player->PlayerTalkClass->CloseGossip();
    }
    return true;
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
