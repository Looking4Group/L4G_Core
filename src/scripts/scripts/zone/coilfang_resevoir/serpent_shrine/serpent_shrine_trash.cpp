#include "precompiled.h"
#include "def_serpent_shrine.h"


#define SPELL_FRIGHTENING_SHOUT     38945
#define SPELL_FRENZY                38947
#define SPELL_KNOCKBACK             38576
#define SPELL_EXECUTE               38959
#define SPELL_MORTAL_CLEAVE         38572

struct mob_vashjir_honor_guardAI : public ScriptedAI
{
    mob_vashjir_honor_guardAI(Creature *c) : ScriptedAI(c) {}

    uint32 Shout_Timer;
    uint32 Knockback_Timer;
    uint32 Execute_Timer;
    uint32 Cleave_Timer;
    bool Frenzy_Casted;

    uint32 Talk_Timer;
    uint32 Check_Timer;
    bool Talking;
    uint64 Talk_Creature;

    void Reset()
    {
        Shout_Timer = urand(25000, 40000);
        Knockback_Timer = urand(10000, 30000);
        Execute_Timer = 0;
        Cleave_Timer = urand(3000, 6000);
        Frenzy_Casted = false;
        Talk_Timer = 10000;
        Check_Timer = 1000;
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
        {
            //UpdateAIOOC(diff);  // not working in 100%
            return;
        }

        if(Shout_Timer < diff)
        {
            AddSpellToCast(SPELL_FRIGHTENING_SHOUT, CAST_TANK);
            Shout_Timer = urand(30000, 40000);
        }
        else
            Shout_Timer -= diff;

        if(Knockback_Timer < diff)
        {
            AddSpellToCast(SPELL_KNOCKBACK, CAST_TANK);
            Knockback_Timer = urand(10000, 15000);
        }
        else
            Knockback_Timer -= diff;

        if(Execute_Timer < diff)
        {
            if(me->getVictim()->GetHealth() * 5 <= me->getVictim()->GetMaxHealth()) // below 20%
            {
                AddSpellToCast(SPELL_EXECUTE, CAST_TANK);
                Execute_Timer = 30000;
            }
        }
        else
            Execute_Timer -= diff;

        if(Cleave_Timer < diff)
        {
            AddSpellToCast(SPELL_MORTAL_CLEAVE, CAST_TANK);
            Cleave_Timer = urand(3000, 6000);
        }
        else
            Cleave_Timer -= diff;

        if(!Frenzy_Casted && HealthBelowPct(50))
        {
            AddSpellToCast(SPELL_FRENZY, CAST_SELF);
            Frenzy_Casted = true;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }

    void UpdateAIOOC(const uint32 diff)
    {
        // need some tweaking
        if(!Talking)
        {
            if(Talk_Timer < diff)
            {
                if(Check_Timer < diff)
                {
                    std::list<Creature*> friends = FindAllFriendlyInGrid(3);
                    if(!friends.empty())
                    {

                        Creature *c = friends.front();
                        c->GetMotionMaster()->MoveIdle();
                        c->SetInFront(me);
                        me->GetMotionMaster()->MoveIdle();
                        me->SetInFront(c);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ROAR);

                        Check_Timer = 1500;
                        Talk_Timer = urand(4000, 6000);
                        Talking = true;
                        Talk_Creature = c->GetGUID();

                        //c->Say("Check1", 0, 0);
                        //me->Say("Check0", 0, 0);
                    }
                }
                else
                    Check_Timer -= diff;
            }
            else
                Talk_Timer -= diff;
        }
        else // Talking
        {
            if(Check_Timer)
            {
                if(Check_Timer <= diff)
                {
                    //me->Say("Check2", 0, 0);
                    if(Creature *c = me->GetCreature(Talk_Creature))
                    {
                        c->SetInFront(me);
                        me->SetInFront(c);
                        c->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_TALK);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_TALK);
                    }
                    Check_Timer = 0;
                }
                else
                    Check_Timer -= diff;
            }

            if(Talk_Timer < diff)
            {
                //me->Say("Check3", 0, 0);
                Talking = false;
                Talk_Timer = urand(4000, 8000);
                me->GetMotionMaster()->MovementExpired();
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);

                if(Creature *c = me->GetCreature(Talk_Creature))
                {
                    c->GetMotionMaster()->MovementExpired();
                    c->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                }
            }
            else
                Talk_Timer -= diff;
        }
    }
};

CreatureAI* GetAI_mob_vashjir_honor_guard(Creature *_Creature)
{
    return new mob_vashjir_honor_guardAI(_Creature);
}

#define SPELL_SUMMON_SERPENTSHRINE_PARASITE         39053
#define SPELL_INITIAL_INFECTION                     39032
#define SPELL_SPORE_QUAKE                           38976
#define SPELL_ACID_GEYSER                           38971
#define SPELL_ATHROPIC_BLOW                         39015
#define SPELL_ENRAGE                                39031
#define SPELL_FIRE_VULNERABILITY                    38715
#define SPELL_FROST_VULNERABILITY                   38714
#define SPELL_NATURE_VULNERABILITY                  38717
#define SPELL_TOXIC_POOL                            38718

#define NPC_MUSHROM                                 22335
#define NPC_COLOSSUS_LURKER                         22347
#define NPC_COLOSSUS_RAGER                          22352


struct mob_underbog_colossusAI : public ScriptedAI
{
    mob_underbog_colossusAI(Creature *c) : ScriptedAI(c)
    {
        type = urand(0, 2);
        Vulnerability = RAND(SPELL_FIRE_VULNERABILITY, SPELL_FROST_VULNERABILITY, SPELL_NATURE_VULNERABILITY);
    }

    uint8 type;
    uint32 Vulnerability;

    uint32 Infection_Timer;
    uint32 Parasite_Timer;
    uint32 Quake_Timer;
    uint32 Geyser_Timer;
    uint32 Blow_Timer;
    uint32 Enrage_Timer;

    void Reset()
    {
        Infection_Timer = urand(0, 10000);
        Parasite_Timer = 10000;
        Quake_Timer = urand(10000, 40000);
        Geyser_Timer = 15000;
        Blow_Timer = 1000;
        Enrage_Timer = 15000;
        me->CastSpell(me, Vulnerability, false);
    }

    void JustDied(Unit *)
    {
        uint32 count = 0;
        uint32 entry = 0;

        switch(urand(0, 4))
        {
        case 0:
            // nothing
            break;
        case 1:
            count = 4;
            entry = NPC_MUSHROM;
            break;
        case 2:
            count = urand(2, 3);
            entry = NPC_COLOSSUS_LURKER;
            break;
        case 3:
            count = urand(8, 10);
            entry = NPC_COLOSSUS_RAGER;
            break;
        case 4:
            me->CastSpell(me, SPELL_TOXIC_POOL, true);
            break;
        }

        for(uint8 i = 0; i < count; i++)
        {
            float x, y, z;
            me->GetPosition(x, y, z);
            // FIXME: ponizsze nie dziala, chociaz mialoby lepszy efekt
            //            me->GetRandomPoint(x, y, z, frand(5, 10), x, y, z);
            //            me->GetValidPointInAngle(dest, 10.0f, frand(0, 2*M_PI), true);
            me->SummonCreature(entry, x, y, z, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 20000);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        switch(type)
        {
        case 0:
            if (Infection_Timer < diff)
            {
                AddSpellToCast(SPELL_INITIAL_INFECTION, CAST_RANDOM);
                Infection_Timer = urand(25000, 35000);
            }
            else
                Infection_Timer -= diff;

            if (Quake_Timer < diff)
            {
                AddSpellToCast(SPELL_SPORE_QUAKE, CAST_SELF);
                Quake_Timer = urand(30000, 60000);
            }
            else
                Quake_Timer -= diff;
            break;
        case 1:
            if (Geyser_Timer < diff)
            {
                AddSpellToCast(SPELL_ACID_GEYSER, CAST_RANDOM_WITHOUT_TANK);
                Geyser_Timer = urand(30000, 60000);
            }
            else
                Geyser_Timer -= diff;

            if (Parasite_Timer < diff)
            {
                AddSpellToCast(SPELL_SUMMON_SERPENTSHRINE_PARASITE, CAST_RANDOM);
                Parasite_Timer = urand(10000, 20000);
            }
            else
                Parasite_Timer -= diff;
            break;
        case 2:
            if (Enrage_Timer < diff)
            {
                AddSpellToCast(SPELL_ENRAGE, CAST_SELF);
                Enrage_Timer = urand(30000, 50000);
            }
            else
                Enrage_Timer -= diff;

            if (Blow_Timer < diff)
            {
                AddSpellToCast(SPELL_ATHROPIC_BLOW, CAST_TANK);
                Blow_Timer = 1500;
            }
            else
                Blow_Timer -= diff;
            break;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }

};

CreatureAI* GetAI_mob_underbog_colossus(Creature *_Creature)
{
    return new mob_underbog_colossusAI(_Creature);
}

#define SPELL_SERPENTSHRINE_PARASITE    39053

struct mob_serpentshrine_parasiteAI : public ScriptedAI
{
    mob_serpentshrine_parasiteAI(Creature *c) : ScriptedAI(c) {}

    uint64 TargetGUID;
    uint32 Check_Timer;

    void Reset()
    {
        TargetGUID = 0;
        Check_Timer = 100;
    }

    void UpdateAI(const uint32 diff)
    {
        if (Check_Timer < diff)
        {
            Unit *target = me->GetUnit(TargetGUID);
            if(!target || !target->isAlive())
                TargetGUID = 0;
            else if(me->IsWithinDist(target, 5))
            {
                me->CastSpell(target, SPELL_SERPENTSHRINE_PARASITE, true);
                me->Kill(me);
                return;
            }

            Check_Timer = 1000;
        }
        else
            Check_Timer -= diff;

        if(!TargetGUID)
        {
            std::list<Player*> players = FindAllPlayersInRange(50);
            if(players.empty())
            {
                me->Kill(me);
                std::list<Player*>::iterator i = players.begin();
                advance(i, urand(0, players.size()-1));
                Player *target = *i;
                if(target->isAlive())
                {
                    TargetGUID = target->GetGUID();
                    me->GetMotionMaster()->MoveChase(target);
                }
            }
        }
    }
};

CreatureAI* GetAI_mob_serpentshrine_parasite(Creature *_Creature)
{
    return new mob_serpentshrine_parasiteAI(_Creature);
}


struct mob_coilfang_frenzyAI : public ScriptedAI
{
    mob_coilfang_frenzyAI(Creature *c) : ScriptedAI(c) {}

    void Reset()
    {

    }

    void EnterEvadeMode()
    {
        float x, y, z;
        me->GetPosition(x, y, z);
        me->SetHomePosition(x, y, z, me->GetOrientation());
        ScriptedAI::EnterEvadeMode();
    }

    void UpdateAI(const uint32 diff)
    {
        float x, y, z;
        me->GetPosition(x, y, z);

        if(z > WATER_Z)
            me->Relocate(x, y, WATER_Z, me->GetOrientation());

        if(!UpdateVictim())
            return;

        Unit *victim = me->getVictim();

        victim->GetPosition(x, y, z);
        if(z - 0.5f > WATER_Z)
        {
            EnterEvadeMode();
            return;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_coilfang_frenzy(Creature *_Creature)
{
    return new mob_coilfang_frenzyAI(_Creature);
}


struct mob_serpent_shrine_priestressAI : public ScriptedAI
{
    mob_serpent_shrine_priestressAI(Creature *c) : ScriptedAI(c) {}

    uint32 smite_timer;
    uint32 holy_fire_timer;
    bool twenty, fifty;

    void Reset()
    {
        smite_timer = 12500;
        holy_fire_timer = 7000;
        twenty, fifty = false;
    }

    void JustDied(){}

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if (!fifty && (m_creature->GetHealth()*100 / m_creature->GetMaxHealth()) < 50)
        {
            me->CastSpell(me, 38580, false);
            fifty = true;
        }

        if (!twenty && (m_creature->GetHealth()*100 / m_creature->GetMaxHealth()) < 20)
        {
            me->CastSpell(me, 38580, false);
            twenty = true;
        }

        if ((m_creature->GetHealth()*100 / m_creature->GetMaxHealth()) < 5)
        {
            me->CastSpell(me, 27827, false);
        }

        if (holy_fire_timer <= diff)
        {
            me->CastSpell(me->getVictim(), 38585, false);
            holy_fire_timer = 7000;
        }
        else holy_fire_timer -= diff;

        if (smite_timer <= diff)
        {
            me->CastSpell(me->getVictim(), 38585, false);
            smite_timer = 12500;
        }
        else smite_timer -= diff;
    }
};

CreatureAI* GetAI_mob_serpent_shrine_priestress(Creature *_Creature)
{
    return new mob_serpent_shrine_priestressAI(_Creature);
}

struct mob_coilfang_serpentguardAI : public ScriptedAI
{
    mob_coilfang_serpentguardAI(Creature *c) : ScriptedAI(c) {}

    uint32 reflect_timer;
    uint32 melee_timer;

    void Reset()
    {
        reflect_timer = 15000;
        melee_timer = 7000;
        me->CastSpell(me, 38603, false);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if (melee_timer <= diff)
        {
            me->CastSpell(me->getVictim(), 31345, false);
            melee_timer = 7000;
        }
        else melee_timer -= diff;

        if (reflect_timer <= diff)
        {
            me->CastSpell(me->getVictim(), 38599, false);
            reflect_timer = 15000;
        }
        else reflect_timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_coilfang_serpentguard(Creature *_Creature)
{
    return new mob_coilfang_serpentguardAI(_Creature);
}


struct mob_greyheart_tidecallerAI : public ScriptedAI
{
    mob_greyheart_tidecallerAI(Creature *c) : ScriptedAI(c) {}

    uint32 elemental_timer;
    uint32 totem_timer;
    uint32 check_timer;
    bool totem, elemental;

    void Reset()
    {
        elemental_timer = 15000;
        totem_timer = 7000;
        check_timer = 1000;
        totem, elemental = false;
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if (!elemental && elemental_timer <= diff)
        {
            me->CastSpell(me, 39027, false);
            elemental = true;
        }
        else elemental_timer -= diff;

        if (!totem && totem_timer <= diff)
        {
            me->CastSpell(me->getVictim(), 38624, false);
            totem = true;
        }
        else totem_timer -= diff;

        if (check_timer <= diff)
        {
            if (!FindCreature(22236, 50, me) && FindCreature(22238, 50, me))
                if (Creature *Ele = (Creature *)FindCreature(22238, 50, me))
                    Ele->DisappearAndDie();

            if (FindCreature(22236, 50, me) && FindCreature(22238, 50, me))
                if (Creature *Totem = (Creature *)FindCreature(22236, 50, me))
                    if (Totem->isDead())
                        if (Creature *Ele = (Creature *)FindCreature(22238, 50, me))
                            Ele->DisappearAndDie();

            if (Creature *Ele = (Creature *)FindCreature(22238, 50, me))
            {
                Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30.0f, true);
                Ele->Attack(target, false);
            }

            check_timer = 1000;
        }
        else check_timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_greyheart_tidecaller(Creature *_Creature)
{
    return new mob_greyheart_tidecallerAI(_Creature);
}

void AddSC_serpent_shrine_trash()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "mob_vashjir_honor_guard";
    newscript->GetAI = &GetAI_mob_vashjir_honor_guard;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_underbog_colossus";
    newscript->GetAI = &GetAI_mob_underbog_colossus;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_serpentshrine_parasite";
    newscript->GetAI = &GetAI_mob_serpentshrine_parasite;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_coilfang_frenzy";
    newscript->GetAI = &GetAI_mob_coilfang_frenzy;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_serpent_shrine_priestress";
    newscript->GetAI = &GetAI_mob_coilfang_frenzy;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_coilfang_serpentguard";
    newscript->GetAI = &GetAI_mob_coilfang_frenzy;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_greyheart_tidecaller";
    newscript->GetAI = &GetAI_mob_greyheart_tidecaller;
    newscript->RegisterSelf();

}
