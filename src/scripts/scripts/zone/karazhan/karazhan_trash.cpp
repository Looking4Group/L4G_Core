#include "precompiled.h"
#include "def_karazhan.h"

//#define SPELL_DANCE_VIBE            29521
#define SPELL_SEARING_PAIN          29492
#define SPELL_IMMOLATE              29928
#define SPELL_THROW                 29582
#define SPELL_IMPALE                29583
#define SPELL_GOBLIN_DRAGON_GUN     29513
#define SPELL_THROW_DYNAMITE        29579
#define SPELL_PUNCH                 29581
#define SPELL_CURSE_OF_AGONY        29930
#define SPELL_HEAL                  29580
#define SPELL_HOLY_NOVA             29514

#define GO_CHAIR                    183776


struct mob_phantom_guestAI : public ScriptedAI
{
    mob_phantom_guestAI(Creature* c) : ScriptedAI(c) 
    {
        Type = urand(0, 4);   
    }

    uint32 Type;
    uint32 MainTimer;
    uint32 SecondaryTimer;
    uint32 Zcheck;

    void Reset()
    {
        //me->CastSpell(me, SPELL_DANCE_VIBE, true); //something is wrong cause nearly all mobs of the ini got the spell

        MainTimer = 0;
        SecondaryTimer = urand(5000, 20000);
        Zcheck = 1000;

        if(GameObject *chair = FindGameObject(GO_CHAIR, 5.0, me))
            chair->Use(me);
    }

    void AttackStart(Unit *who)
    {
        if(Type == 0 || Type == 1)
            ScriptedAI::AttackStartNoMove(who, Type == 0 ? CHECK_TYPE_CASTER : CHECK_TYPE_SHOOTER);
        else
            ScriptedAI::AttackStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        // to avoid melting in textures on cb
        if(Zcheck < diff)
        {
            float x, y, z;
            me->GetPosition(x, y, z);
            if (me->IsNonMeleeSpellCasted(false))
                me->GetMap()->CreatureRelocation(me, x, y, z+0.8, me->GetOrientation());
            Zcheck = 1000;
        }
        else
            Zcheck -= diff;

        if(MainTimer < diff)
        {
            switch(Type)
            {
            case 0:
                AddSpellToCast(SPELL_SEARING_PAIN, CAST_TANK);
                MainTimer = 3500;
                break;
            case 1:
                AddSpellToCast(SPELL_THROW, CAST_TANK);
                MainTimer = 2000;
                break;
            case 2:
                AddSpellToCast(SPELL_GOBLIN_DRAGON_GUN, CAST_SELF);
                MainTimer = 20000;
                break;
            case 3:
                AddSpellToCast(SPELL_PUNCH, CAST_TANK);
                MainTimer = urand(10000, 30000);
                break;
            case 4:
                AddSpellToCast(SPELL_HEAL, CAST_LOWEST_HP_FRIENDLY);
                MainTimer = urand(5000, 20000);
                break;
            }
        } 
        else
            MainTimer -= diff;

        if(SecondaryTimer < diff)
        {
            switch(Type)
            {
            case 0:
                AddSpellToCast(SPELL_IMMOLATE, CAST_RANDOM);
                SecondaryTimer = urand(7000, 30000);
                break;
            case 1:
                AddSpellToCast(SPELL_IMPALE, CAST_RANDOM);
                SecondaryTimer = urand(5000, 30000);
                break;
            case 2:
                AddSpellToCast(SPELL_THROW_DYNAMITE, CAST_RANDOM);
                SecondaryTimer = urand(15000, 40000);
                break;
            case 3:
                AddSpellToCast(SPELL_CURSE_OF_AGONY, CAST_RANDOM);
                SecondaryTimer = urand(10000, 30000);
                break;
            case 4:
                AddSpellToCast(SPELL_HOLY_NOVA, CAST_SELF);
                SecondaryTimer = urand(10000, 30000);
                break;
            }
        }
        else
            SecondaryTimer -= diff;

        if(Type == 0)
            CheckCasterNoMovementInRange(diff, 30.0);
        else if(Type == 1)
            CheckShooterNoMovementInRange(diff, 30.0);
        CastNextSpellIfAnyAndReady(diff);
        DoMeleeAttackIfReady();
    }    
};

CreatureAI* GetAI_mob_phantom_guest(Creature *_Creature)
{
    return new mob_phantom_guestAI(_Creature);
}

#define SPELL_DUAL_WIELD    674
#define SPELL_SHOT          29575
#define SPELL_MULTI_SHOT    29576

#define SENTRY_SAY_AGGRO1   "What is this?"
#define SENTRY_SAY_AGGRO2   "Stop them!"
#define SENTRY_SAY_AGGRO3   "Invaders in the tower!"
#define SENTRY_SAY_DEATH1   "I have failed..." 
#define SENTRY_SAY_RANDOM   "It's great assigment, yeah, but \"all looking and no touching\" gets old after a while."

struct mob_spectral_sentryAI : public ScriptedAI
{
    mob_spectral_sentryAI(Creature* c) : ScriptedAI(c) {}

    uint32 ShotTimer;
    uint32 MultiShotTimer;
    uint32 RandomSayTimer;

    void Reset()
    {
        me->CastSpell(me, SPELL_DUAL_WIELD, true);

        ShotTimer = 0;
        MultiShotTimer = 8000;
        RandomSayTimer = urand(40000, 80000);
    }
    
    void EnterCombat(Unit *who)
    {
        if(roll_chance_i(70))
            me->Say(RAND<const char*>(SENTRY_SAY_AGGRO1, SENTRY_SAY_AGGRO2, SENTRY_SAY_AGGRO3), 0, 0);
    }

    void AttackStart(Unit *who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_SHOOTER);
    }

    void JustDied(Unit *)
    {
        if(roll_chance_i(30))
            me->Say(SENTRY_SAY_DEATH1, 0, 0);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
        {
            if (RandomSayTimer < diff)
            {
                if(roll_chance_i(30))
                    me->Say(SENTRY_SAY_RANDOM, 0, 0);
                RandomSayTimer = urand(40000, 80000);
            }
            else 
                RandomSayTimer -= diff;
            return;
        }

        if(ShotTimer < diff)
        {
            AddSpellToCast(SPELL_SHOT, CAST_TANK);
            ShotTimer = 2000;
        } 
        else
            ShotTimer -= diff;

        if(MultiShotTimer < diff)
        {
            AddSpellToCast(SPELL_MULTI_SHOT, CAST_RANDOM);
            MultiShotTimer = 8000;
        }
        else
            MultiShotTimer -= diff;

        CheckShooterNoMovementInRange(diff, 20.0);
        CastNextSpellIfAnyAndReady(diff);
        DoMeleeAttackIfReady();
    }    
};

CreatureAI* GetAI_mob_spectral_sentry(Creature *_Creature)
{
    return new mob_spectral_sentryAI(_Creature);
}

#define SPELL_RETURN_FIRE1  29793
#define SPELL_RETURN_FIRE2  29794
#define SPELL_RETURN_FIRE3  29788
#define SPELL_FIST_OF_STONE 29840
#define SPELL_DETONATE      29876
#define SPELL_SEAR          29864
#define NPC_ASTRAL_SPARK    17283


struct mob_arcane_protectorAI : public ScriptedAI
{
    mob_arcane_protectorAI(Creature* c) : ScriptedAI(c) {}

    uint32 SkillTimer;

    void Reset()
    {
        SkillTimer = urand(10000, 20000);
    }
    
    void EnterCombat(Unit *who)
    {
        me->CastSpell(me, RAND(SPELL_RETURN_FIRE1, SPELL_RETURN_FIRE2, SPELL_RETURN_FIRE3), false); 
    }

    void JustSummoned(Creature *c)
    {
        if (c->GetEntry() == NPC_ASTRAL_SPARK)
        {
            c->CastSpell(me, SPELL_DETONATE, true);
            c->CastSpell(me, SPELL_SEAR, true);
        }
    }

    void OnAuraApply(Aura *aur, Unit*, bool stack)
    {
        if(aur->GetEffIndex() == 0)
        {
            switch(aur->GetId())
            {
            case SPELL_RETURN_FIRE1:
                me->Say("Activating defence mode EL-2S.", 0, 0);
                break;
            case SPELL_RETURN_FIRE2:
                me->Say("Activating defence mode EL-5R.", 0, 0);
                break;
            case SPELL_RETURN_FIRE3:
                me->Say("Activating defence mode EL-7M.", 0, 0);
                break;
            }
        }
    }

    void JustDied(Unit *)
    {
        if(roll_chance_i(30))
            me->Say(RAND<const char*>("You will not make it out alive!",
                                      "This... changes nothing. Eternal damnation awaits you!",
                                      "Others will take my place"), 0, 0);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(SkillTimer < diff)
        {
            if(roll_chance_i(50))
                me->SummonCreature(NPC_ASTRAL_SPARK, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(),
                        TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
            else
                me->CastSpell(me, SPELL_FIST_OF_STONE, false);
            SkillTimer = urand(15000, 30000);
        }
        else
            SkillTimer -= diff;

        CastNextSpellIfAnyAndReady(diff);
        DoMeleeAttackIfReady();
    }    
};

CreatureAI* GetAI_mob_arcane_protector(Creature *_Creature)
{
    return new mob_arcane_protectorAI(_Creature);
}

#define SPELL_WARP_BREACH_AOE       29919
#define SPELL_WARP_BREACH_VISUAL    37079

struct mob_mana_warpAI : public ScriptedAI
{
    mob_mana_warpAI(Creature* c) : ScriptedAI(c) {}

    bool Exploded;

    void Reset()
    {
        Exploded = false;
    }
    
    void DamageTaken(Unit* pDone_by, uint32& uiDamage)
    {
        if(me->IsNonMeleeSpellCasted(true) && uiDamage > me->GetHealth())
            uiDamage = me->GetHealth() - 1;
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(!Exploded && HealthBelowPct(10))
        {
            me->CastSpell(me, SPELL_WARP_BREACH_AOE, false);
            me->CastSpell(me, SPELL_WARP_BREACH_VISUAL, true);
            Exploded = true;
        }

        DoMeleeAttackIfReady();
    }    
};

CreatureAI* GetAI_mob_mana_warp(Creature *_Creature)
{
    return new mob_mana_warpAI(_Creature);
}

bool Spell_charge(const Aura* aura, bool apply)
{
    if(!apply)
    {
        if(Unit* caster = aura->GetCaster())
            caster->CastSpell(aura->GetTarget(), 29321, true);      // trigger fear after charge
    }
    return true;
}

#define SPELL_SEARING_PAIN      29492
#define SPELL_IMMOLATE          29928
#define SPELL_CURSE_OF_AGONY    29930

struct mob_shadow_pillagerAI : public ScriptedAI
{
    mob_shadow_pillagerAI(Creature* c) : ScriptedAI(c) {}

    uint32 DotTimer;

    void Reset()
    {
        SetAutocast(SPELL_SEARING_PAIN, 2500, true);
        DotTimer = urand(2000, 6000);
    }
    
    void AttackStart(Unit *who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;
        
        if(DotTimer < diff)
        {
            AddSpellToCast(roll_chance_i(50) ? SPELL_IMMOLATE : SPELL_CURSE_OF_AGONY, CAST_RANDOM);
            DotTimer = urand(2000, 8000);
        } 
        else
            DotTimer -= diff;

        CheckCasterNoMovementInRange(diff, 40.0);
        CastNextSpellIfAnyAndReady(diff);
    }    
};

CreatureAI* GetAI_mob_shadow_pillager(Creature *_Creature)
{
    return new mob_shadow_pillagerAI(_Creature);
}


#define SPELL_FIREBOLT    30180

struct mob_homunculusAI : public ScriptedAI
{
    mob_homunculusAI(Creature* c) : ScriptedAI(c) {}

    void Reset()
    {
        SetAutocast(SPELL_FIREBOLT, 2000, true);
    }
    
    void AttackStart(Unit *who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        CheckCasterNoMovementInRange(diff, 40.0);
        CastNextSpellIfAnyAndReady(diff);
    }    
};

CreatureAI* GetAI_mob_homunculus(Creature *_Creature)
{
    return new mob_homunculusAI(_Creature);
}

#define  ASTRAL_BITE        29908

struct mob_mana_feederAI : public ScriptedAI
{
    mob_mana_feederAI(Creature* c) : ScriptedAI(c) {}

    void Reset()
    {
        me->CastSpell(me, ASTRAL_BITE, false);
        me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_MAGIC, true);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }    
};

CreatureAI* GetAI_mob_mana_feeder(Creature *_Creature)
{
    return new mob_mana_feederAI(_Creature);
}


void AddSC_karazhan_trash()
{
    Script* newscript;
    newscript = new Script;
    newscript->Name = "spell_charge_29320";
    newscript->pEffectAuraDummy = &Spell_charge;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_phantom_guest";
    newscript->GetAI = &GetAI_mob_phantom_guest;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_spectral_sentry";
    newscript->GetAI = &GetAI_mob_spectral_sentry;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_arcane_protector";
    newscript->GetAI = &GetAI_mob_arcane_protector;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_mana_warp";
    newscript->GetAI = &GetAI_mob_mana_warp;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadow_pillager";
    newscript->GetAI = &GetAI_mob_shadow_pillager;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_homunculus";
    newscript->GetAI = &GetAI_mob_homunculus;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_mana_feeder";
    newscript->GetAI = &GetAI_mob_mana_feeder;
    newscript->RegisterSelf();
}
