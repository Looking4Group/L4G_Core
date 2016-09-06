/* Copyright (C) 2008 - 2011 Looking4groupDev <http://gamefreedom.pl/>
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 */

/* ScriptData
SDName: Sunwell_Plateau_Trash
SD%Complete: 100% (26/26)
SDComment: Trash NPCs divided by to boss links
SDCategory: Sunwell Plateau
EndScriptData */

#include "precompiled.h"
#include "def_sunwell_plateau.h"

#define AGGRO_RANGE             25.0

/* ============================
*
*      KALECGOS & SATHROVARR & BRUTALLUS & FELMYST
*
* ============================*/

/* Content Data
    * Sunblade Arch Mage
    * Sunblade Cabalist
    * Sunblade Dawn Priest
    * Sunblade Dragonhawk - EventAI
    * Sunblade Dusk Priest
    * Sunblade Protector
    * Sunblade Scout
    * Sunblade Slayer
    * Sunblade Vindicator
*/

uint32 SWPDrainingList[24] =
{
    42587,54824,
    42640,54829,
    42659,42586,
    42592,54825,
    42657,54835,
    42660,42591,
    42574,54817,
    42656,54834,
    43654,42573,
    42647,43439,
    54820,42582,
    42894,54832
};

#define SPELL_FEL_CRYSTAL_COSMETIC      44374

/****************
* Sunblade Arch Mage - id 25367

  Immunities: stun

*****************/

enum SunbladeArchMage
{
    SPELL_ARCANE_EXPLOSION          = 46553,
    SPELL_FROST_NOVA                = 46555,
    SPELL_BLINK                     = 46573
};

struct mob_sunblade_arch_mageAI : public ScriptedAI
{
    mob_sunblade_arch_mageAI(Creature *c) : ScriptedAI(c) { me->SetAggroRange(AGGRO_RANGE); }

    uint32 ArcaneExplosion;
    uint32 FrostNova;
    uint32 Blink;
    uint32 OOCTimer;

    void Reset()
    {
        ClearCastQueue();
        ArcaneExplosion = urand(5000, 12000);
        FrostNova = urand(5000, 10000);
        Blink = urand(3000, 5000);
        OOCTimer = 5000;
    }

    void EnterCombat(Unit*) 
    { 
        DoZoneInCombat(80.0f);
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);    
    }

    void HandleOffCombatEffects()
    {
        for (uint8 i = 0; i < 24; ++i)
        {
            if(me->GetDBTableGUIDLow() == SWPDrainingList[i]) // draining fel crystal
                me->CastSpell((Unit*)NULL, SPELL_FEL_CRYSTAL_COSMETIC, false);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->IsNonMeleeSpellCasted(false) && !me->isInCombat())
        {
            if(OOCTimer < diff)
            {
                HandleOffCombatEffects();
                OOCTimer = 10000;
            }
            else
                OOCTimer -= diff;
        }

        if(!UpdateVictim())
            return;

        if(Blink > 1000 && (me->isFrozen() || me->HasAuraType(SPELL_AURA_MOD_ROOT)))
            Blink = 1000;

        if(ArcaneExplosion < diff)
        {
            AddSpellToCast(SPELL_ARCANE_EXPLOSION, CAST_SELF);
            ArcaneExplosion = urand(4000, 8000);
        }
        else
            ArcaneExplosion -= diff;

        if(FrostNova < diff)
        {
            AddSpellToCast(SPELL_FROST_NOVA, CAST_SELF);
            FrostNova = urand(6000, 16000);
        }
        else
            FrostNova -= diff;

        if(Blink < diff)
        {
            AddSpellToCast(SPELL_BLINK, CAST_SELF);
            Blink = urand(3000, 5000);
        }
        else
            Blink -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_sunblade_arch_mage(Creature *_Creature)
{
    return new mob_sunblade_arch_mageAI(_Creature);
}

/****************
* Sunblade Cabalist - id 25363
  Fire Fiend - id 26101 - EventAI

  Immunities: stun, cyclone

*****************/

enum SunbladeCabalist
{
    SPELL_IGNITE_MANA               = 46543,
    SPELL_SHADOW_BOLT               = 47248,
    SPELL_SUMMON_IMP                = 46544
};

struct mob_sunblade_cabalistAI : public ScriptedAI
{
    mob_sunblade_cabalistAI(Creature *c) : ScriptedAI(c), summons(c) { me->SetAggroRange(AGGRO_RANGE); }

    uint32 IgniteMana;
    uint32 ShadowBolt;
    uint32 SummonImp;
    SummonList summons;
    uint32 OOCTimer;

    void HandleOffCombatEffects()
    {
        for (uint8 i = 0; i < 24; ++i)
        {
            if(me->GetDBTableGUIDLow() == SWPDrainingList[i]) // draining fel crystal
                me->CastSpell((Unit*)NULL, SPELL_FEL_CRYSTAL_COSMETIC, false);
        }
    }

    void Reset()
    {
        ClearCastQueue();
        summons.DespawnAll();
        IgniteMana = urand(3000, 10000);;
        ShadowBolt = urand(500, 1000);
        SummonImp = urand(1000, 8000);
        OOCTimer = 5000;
    }

    void AttackStart(Unit* who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
    }

    void EnterCombat(Unit*) 
    { 
        DoZoneInCombat(80.0f); 
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
    }

    void JustSummoned(Creature* summon)
    {
        summons.Summon(summon);
        if(me->getVictim())
            summon->AI()->AttackStart(me->getVictim());
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->IsNonMeleeSpellCasted(false) && !me->isInCombat())
        {
            if(OOCTimer < diff)
            {
                HandleOffCombatEffects();
                OOCTimer = 10000;
            }
            else
                OOCTimer -= diff;
        }

        if(!UpdateVictim())
            return;

        if(IgniteMana < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 50, true, POWER_MANA))
                AddSpellToCast(target, SPELL_IGNITE_MANA, false, true);
            IgniteMana = urand(8000, 16000);
        }
        else
            IgniteMana -= diff;

        if(ShadowBolt < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 50, true))
                AddSpellToCast(target, SPELL_SHADOW_BOLT, false, true);
            ShadowBolt = urand(2100, 2500);
        }
        else
            ShadowBolt -= diff;

        if(SummonImp < diff)
        {
            AddSpellToCast(SPELL_SUMMON_IMP, CAST_NULL);
            SummonImp = urand(15000, 20000);
        }
        else
            SummonImp -= diff;

        CheckCasterNoMovementInRange(diff, 48.0);
        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_sunblade_cabalist(Creature *_Creature)
{
    return new mob_sunblade_cabalistAI(_Creature);
}

/****************
* Sunblade Dawn Priest - id 25371

  Immunities: stun

*****************/

enum SunbladeDawnPriest
{
    SPELL_HOLYFORM                  = 46565,
    SPELL_HOLY_NOVA                 = 46564,
    SPELL_RENEW                     = 46563
};

struct mob_sunblade_dawn_priestAI : public ScriptedAI
{
    mob_sunblade_dawn_priestAI(Creature *c) : ScriptedAI(c) { me->SetAggroRange(AGGRO_RANGE); }

    uint32 HolyNova;
    uint32 Renew;
    uint32 SelfRenew;
    bool canRenew;
    bool canSelfRenew;
    uint32 OOCTimer;

    void HandleOffCombatEffects()
    {
        for (uint8 i = 0; i < 24; ++i)
        {
            if(me->GetDBTableGUIDLow() == SWPDrainingList[i]) // draining fel crystal
                me->CastSpell((Unit*)NULL, SPELL_FEL_CRYSTAL_COSMETIC, false);
        }
    }

    void Reset()
    {
        ClearCastQueue();
        DoCast(me, SPELL_HOLYFORM);

        HolyNova = urand(5000, 10000);
        Renew = 1000;
        SelfRenew = 500;
        canRenew = true;
        canSelfRenew = true;
        OOCTimer = 5000;
    }

    void EnterCombat(Unit*) 
    { 
        DoZoneInCombat(80.0f); 
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
        DoCast(me, SPELL_HOLYFORM);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->IsNonMeleeSpellCasted(false) && !me->isInCombat())
        {
            if(OOCTimer < diff)
            {
                HandleOffCombatEffects();
                OOCTimer = 10000;
            }
            else
                OOCTimer -= diff;
        }

        if(!UpdateVictim())
            return;

        if(HealthBelowPct(70.0f) && canRenew)
        {
            AddSpellToCast(me, SPELL_RENEW);
            canSelfRenew = false;
            SelfRenew = 15000;
        }

        if(Unit* healTarget = SelectLowestHpFriendly(100, 2000))
        {
            if(canRenew)
            {
                AddSpellToCast(healTarget, SPELL_RENEW);
                canRenew = false;
                Renew = urand(10000, 15000);
            }
        }

        if(!canRenew)
        {
            if(Renew < diff)
                canRenew = true;
            else
                Renew -= diff;
        }
        if(!canSelfRenew)
        {
            if(SelfRenew < diff)
                canSelfRenew = true;
            else
                SelfRenew -= diff;
        }

        if(HolyNova < diff)
        {
            AddSpellToCast(SPELL_HOLY_NOVA, CAST_NULL);
            HolyNova = urand(5000, 10000);
        }
        else
            HolyNova -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_sunblade_dawn_priest(Creature *_Creature)
{
    return new mob_sunblade_dawn_priestAI(_Creature);
}

/****************
* Sunblade Dusk Priest - id 25370

  Immunities: stun, snare

*****************/

enum SunbladeDuskPriest
{
    SPELL_FEAR                      = 46561,
    SPELL_SHADOW_WORD_PAIN          = 46560,
    SPELL_MIND_FLAY                 = 46562
};

struct mob_sunblade_dusk_priestAI : public ScriptedAI
{
    mob_sunblade_dusk_priestAI(Creature *c) : ScriptedAI(c) { me->SetAggroRange(AGGRO_RANGE); }

    uint32 Fear;
    uint32 WordPain;
    uint32 MindFlay;
    uint32 OOCTimer;

    void HandleOffCombatEffects()
    {
        for (uint8 i = 0; i < 24; ++i)
        {
            if(me->GetDBTableGUIDLow() == SWPDrainingList[i]) // draining fel crystal
                me->CastSpell((Unit*)NULL, SPELL_FEL_CRYSTAL_COSMETIC, false);
        }
    }

    void Reset()
    {
        ClearCastQueue();
        Fear = urand(5000, 15000);
        WordPain = urand(6000, 12000);
        MindFlay = urand(2000, 10000);
        OOCTimer = 5000;
    }

    void EnterCombat(Unit*) 
    { 
        DoZoneInCombat(80.0f);
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->IsNonMeleeSpellCasted(false) && !me->isInCombat())
        {
            if(OOCTimer < diff)
            {
                HandleOffCombatEffects();
                OOCTimer = 10000;
            }
            else
                OOCTimer -= diff;
        } 

        if(!UpdateVictim())
            return;

        if(Fear < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 25, true, me->getVictim()->GetGUID()))
                AddSpellToCast(target, SPELL_FEAR);
            Fear = urand(5000, 12000);
        }
        else
            Fear -= diff;

        if(WordPain < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 60, true))
                AddSpellToCast(target, SPELL_SHADOW_WORD_PAIN);
            WordPain = urand(10000, 15000);
        }
        else
            WordPain -= diff;

        if(MindFlay < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 50, true))
                AddSpellToCast(target, SPELL_MIND_FLAY, false, true);
            MindFlay = urand(4000, 8000);
        }
        else
            MindFlay -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_sunblade_dusk_priest(Creature *_Creature)
{
    return new mob_sunblade_dusk_priestAI(_Creature);
}

/****************
* Sunblade Protector - id 25507

  Immunities: bleed, snare, stun, root

*****************/

enum SunbladeProtector
{
    SPELL_FEL_LIGHTNING             = 46480
};

#define PROTECTOR_YELL "Unit entering energy conservation mode."
#define PROTECTOR_AGGRO "Enemy presence detected."
#define PROTECTOR_AGGRO_2 "Local proximity threat detected. Exiting energy conservation mode."
#define PROTECTOR_ACTIVATED "Unit is now operational and attacking targets."

struct mob_sunblade_protectorAI : public ScriptedAI
{
    mob_sunblade_protectorAI(Creature *c) : ScriptedAI(c)
    {
        if(me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE)
        {
            isInactive = true;
            me->SetAggroRange(7.0f);
        }
        else
        {
            isInactive = false;
            me->SetAggroRange(AGGRO_RANGE);
        }
    }

    uint32 FelLightning;
    bool isInactive;

    void Reset()
    {
        ClearCastQueue();
        FelLightning = urand(3000, 6000);
    }

    void EnterEvadeMode()
    {
        if(isInactive)
            DoYell((urand(0,1) ? PROTECTOR_AGGRO : PROTECTOR_AGGRO_2), 0, me);
        CreatureAI::EnterEvadeMode();
    }

    void EnterCombat(Unit*)
    {
        if(!isInactive)
            DoYell(PROTECTOR_AGGRO, 0, me);
        else
            DoYell(PROTECTOR_ACTIVATED, 0, me);
        DoZoneInCombat(80.0f);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(FelLightning < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 60, true))
                AddSpellToCast(target, SPELL_FEL_LIGHTNING);
            FelLightning = urand(1500, 6000);
        }
        else
            FelLightning -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_sunblade_protector(Creature *_Creature)
{
    return new mob_sunblade_protectorAI(_Creature);
}

/****************
* Sunblade Scout - id 25372

  Immunities: root, snares, stunes, poly, detect stealth

*****************/

enum SunbladeScout
{
    SPELL_STEALTH_DETECT                = 18950,
    SPELL_SINISTER_STRIKE               = 46558,
    SPELL_ACTIVATE_SUNBLADE_PROTECTOR   = 46475
};

#define SCOUT_YELL "Enemies Spotted! Attack while I try to activate a Protector!"

struct mob_sunblade_scoutAI : public ScriptedAI
{
    mob_sunblade_scoutAI(Creature *c) : ScriptedAI(c) { me->SetAggroRange(30); }

    uint32 SinisterStrike;
    bool activating_protector;

    void Reset()
    {
        me->GetMotionMaster()->Initialize();
        ClearCastQueue();
        activating_protector = false;
        DoCast(me, SPELL_STEALTH_DETECT, true);

        SinisterStrike = urand(3000, 10000);
    }

    bool ActivateProtector(Unit* who)
    {
        if(Unit* Protector = GetClosestCreatureWithEntry(me, 25507, 100, true, true))
        {
            if(Protector->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE)
            {
                DoYell(SCOUT_YELL, 0, who);
                float x, y, z;
                me->GetMotionMaster()->Clear();
                Protector->GetNearPoint(x, y, z, 0, urand(10, 20), Protector->GetAngle(me));
                Protector->UpdateAllowedPositionZ(x, y, z);
                me->SetWalk(false);
                me->GetMotionMaster()->MovePoint(0, x, y, z);
                me->SetSelection(Protector->GetGUID());
                return true;
            }
        }
        return false;
    }

    void MovementInform(uint32 MovementType, uint32 Id)
    {
        if(MovementType != POINT_MOTION_TYPE)
            return;
        if(Id == 0)
        {
            me->GetMotionMaster()->MoveIdle();
            DoCast((Unit*)NULL, SPELL_ACTIVATE_SUNBLADE_PROTECTOR);
            activating_protector = true;
        }
    }

    void EnterCombat(Unit* who) {DoZoneInCombat(80.0f);}

    void AttackStart(Unit* pWho)
    {
        if (!pWho)
            return;

        if (me->Attack(pWho, true) && !activating_protector)
        {
            if(!ActivateProtector(pWho))
                DoStartMovement(pWho);
            activating_protector = true;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(activating_protector && me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
            activating_protector = false;

        if(!UpdateVictim() || activating_protector)
            return;

        if(SinisterStrike < diff)
        {
            AddSpellToCast(me->getVictim(), SPELL_SINISTER_STRIKE);
            SinisterStrike = urand(4000, 8000);
        }
        else
            SinisterStrike -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_sunblade_scout(Creature *_Creature)
{
    return new mob_sunblade_scoutAI(_Creature);
}

/****************
* Sunblade Slayer - id 25368

  Immunities: stun

*****************/

enum SunbladeSlayer
{
    SPELL_DUAL_WIELD                    = 29651,
    SPELL_SCATTER_SHOT                  = 46681,
    SPELL_SHOOT                         = 47001,
    SPELL_SLAYING_SHOT                  = 46557
};

struct mob_sunblade_slayerAI : public ScriptedAI
{
    mob_sunblade_slayerAI(Creature *c) : ScriptedAI(c) { me->SetAggroRange(AGGRO_RANGE); }

    uint32 ScatterShot;
    uint32 Shoot;
    uint32 SlayingShot;
    uint32 OOCTimer;

    void HandleOffCombatEffects()
    {
        for (uint8 i = 0; i < 24; ++i)
        {
            if(me->GetDBTableGUIDLow() == SWPDrainingList[i]) // draining fel crystal
                me->CastSpell((Unit*)NULL, SPELL_FEL_CRYSTAL_COSMETIC, false);
        }
    }

    void Reset()
    {
        ClearCastQueue();
        ScatterShot = urand(6000, 12000);
        Shoot = urand(100, 1000);
        SlayingShot = urand(8000, 15000);
        DoCast(me, SPELL_DUAL_WIELD, true);
        OOCTimer = 5000;
    }

    void EnterCombat(Unit*) 
    { 
        DoZoneInCombat(80.0f); 
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
    }

    void AttackStart(Unit* who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_SHOOTER);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->IsNonMeleeSpellCasted(false) && !me->isInCombat())
        {
            if(OOCTimer < diff)
            {
                HandleOffCombatEffects();
                OOCTimer = 10000;
            }
            else
                OOCTimer -= diff;
        }

        if(!UpdateVictim())
            return;

        if(ScatterShot < diff)
        {
            AddSpellToCast(SPELL_SCATTER_SHOT, CAST_TANK);
            ScatterShot = urand(6000, 12000);
        }
        else
            ScatterShot -= diff;

        if(Shoot < diff)
        {
            AddSpellToCast(SPELL_SHOOT, CAST_TANK);
            Shoot = urand(2500, 4000);
        }
        else
            Shoot -= diff;

        if(SlayingShot < diff)
        {
            AddSpellToCast(SPELL_SLAYING_SHOT, CAST_TANK);
            SlayingShot = urand(8000, 15000);
        }
        else
            SlayingShot -= diff;

        CheckShooterNoMovementInRange(diff, 40.0);
        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_sunblade_slayer(Creature *_Creature)
{
    return new mob_sunblade_slayerAI(_Creature);
}

/****************
* Sunblade Vindicator - id 25369

  Immunities: stun

*****************/

enum SunbladeVindicator
{
    SPELL_CLEAVE                        = 46559,
    SPELL_MORTAL_STRIKE                 = 44268
};

struct mob_sunblade_vindicatorAI : public ScriptedAI
{
    mob_sunblade_vindicatorAI(Creature *c) : ScriptedAI(c) { me->SetAggroRange(AGGRO_RANGE); }

    uint32 Cleave;
    uint32 MortalStrike;
    uint32 OOCTimer;

    void HandleOffCombatEffects()
    {
        for (uint8 i = 0; i < 24; ++i)
        {
            if(me->GetDBTableGUIDLow() == SWPDrainingList[i]) // draining fel crystal
                me->CastSpell((Unit*)NULL, SPELL_FEL_CRYSTAL_COSMETIC, false);
        }
    }

    void Reset()
    {
        ClearCastQueue();
        Cleave = urand(4000, 9000);
        MortalStrike = urand(5000, 15000);
        OOCTimer = 5000;
    }

    void EnterCombat(Unit*) 
    {
       DoZoneInCombat(80.0f);
       if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->IsNonMeleeSpellCasted(false) && !me->isInCombat())
        {
            if(OOCTimer < diff)
            {
                HandleOffCombatEffects();
                OOCTimer = 10000;
            }
            else
                OOCTimer -= diff;
        }

        if(!UpdateVictim())
            return;

        if(Cleave < diff)
        {
            AddSpellToCast(SPELL_CLEAVE, CAST_TANK);
            Cleave = urand(4000, 9000);
        }
        else
            Cleave -= diff;

        if(MortalStrike < diff)
        {
            AddSpellToCast(SPELL_MORTAL_STRIKE, CAST_TANK);
            MortalStrike = urand(8000, 15000);
        }
        else
            MortalStrike -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_sunblade_vindicator(Creature *_Creature)
{
    return new mob_sunblade_vindicatorAI(_Creature);
}

/* ============================
*
*      EREDAR TWINS
*
* ============================*/

/* Content Data
    * Shadowsword Assassin
    * Shadowsword Commander - responsible for gauntlet
    * Shadowsword Deathbringer - gauntlet
    * Shadowsword Lifeshaper
    * Shadowsword Manafiend
    * Shadowsword Soulbinder
    * Shadowsword Vanquisher
    * Volatile Fiend - gauntlet
*/

/****************
* Shadowsword Assassin - id 25484

  Immunities: disarm, fear, stun, polymorph

*****************/

#define GAUNTLET_PATH    2501

enum ShadowswordAssassin
{
    SPELL_ASSASSINS_MARK            = 46459,
    SPELL_AIMED_SHOT                = 46460,    // not clear if  & when used?
    SPELL_GREATER_INVISIBILITY      = 16380,
    SPELL_SHADOWSTEP                = 46463
};

struct mob_shadowsword_assassinAI : public ScriptedAI
{
    mob_shadowsword_assassinAI(Creature *c) : ScriptedAI(c) { pInstance = c->GetInstanceData(); }

    uint32 Shadowstep;
    uint32 CheckTimer;
    ScriptedInstance* pInstance;

    void Reset()
    {
        ClearCastQueue();
        CheckTimer = 2000;
        Shadowstep = urand(10000, 20000);
        DoCast(me, SPELL_GREATER_INVISIBILITY, true);
    }

    void JustDied(Unit* killer)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == DONE)
            me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        else
            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
    }

    void EnterEvadeMode()
    {
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void DoRandomShadowstep(Unit* who)
    {
        Map::PlayerList const &plList = me->GetMap()->GetPlayers();
        if (plList.isEmpty())
            return;
        for (Map::PlayerList::const_iterator i = plList.begin(); i != plList.end(); ++i)
        {
            if (Player* plr = i->getSource())
            {
                if (plr->isGameMaster() || plr->IsFriendlyTo(me))
                    continue;
                if (plr->isAlive() && me->IsWithinDistInMap(plr, 35))
                {
                    DoCast(plr, SPELL_ASSASSINS_MARK, true);
                    DoCast(plr, SPELL_SHADOWSTEP);
                    AttackStart(plr);
                }
            }
        }
    }

    void MoveInLineOfSight(Unit *who)
    {
        if(!me->isAlive())
            return;
        if(me->IsWithinLOSInMap(who) && !me->isInCombat())
            DoRandomShadowstep(who);
    }

    void EnterCombat(Unit* who)
    {
        if(pInstance->GetData(DATA_FELMYST_EVENT) != DONE)
            return;
        DoZoneInCombat(80.0f);
        DoRandomShadowstep(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(CheckTimer < diff)
        {
            if(me->isInRoots())
                DoCast(me->getVictim(), SPELL_SHADOWSTEP);
            CheckTimer = 2000;
        }
        else
            CheckTimer -= diff;

        if(Shadowstep < diff)
        {
            AddSpellToCast(SPELL_SHADOWSTEP, CAST_TANK);
            Shadowstep = urand(10000, 20000);
        }
        else
            Shadowstep -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_shadowsword_assassin(Creature *_Creature)
{
    return new mob_shadowsword_assassinAI(_Creature);
}

/****************
* Shadowsword Commander - id 25837

  Immunities: polymorph, stun, fear, disarm, root, silence

*****************/

enum ShadowswordCommander
{
    SPELL_BATTLE_SHOUT              = 46763,
    SPELL_SHIELD_SLAM               = 46762,

    MOB_VOLATILE_FIEND              = 25851,
    MOB_SHADOWSWORD_DEATHBRINGER    = 25485,
    MOB_GAUNTLET_IMP_TRIGGER        = 25848,

    YELL_GAUNTLET_START             = -1811006
};

struct mob_shadowsword_commanderAI : public ScriptedAI
{
    mob_shadowsword_commanderAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 ShieldSlam;
    uint32 Yell_timer;
    uint32 ShoutTimer;
    uint64 TriggerGUID;

    void Reset()
    {
        me->setActive(true);
        ShieldSlam = urand(5000, 10000);
        Yell_timer = 3000;
        ShoutTimer = 30000;
        TriggerGUID = 0;
    }

    void EnterEvadeMode()
    {
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void EnterCombat(Unit* who)
    {
        if(pInstance->GetData(DATA_FELMYST_EVENT) != DONE)
            return;
        DoZoneInCombat(80.0f);
        DoCast(me, SPELL_BATTLE_SHOUT);
    }

    void MoveInLineOfSight(Unit* who)
    {
        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustDied(Unit* killer)
    {
        if(Creature* ImpTrigger = me->GetCreature(TriggerGUID))
        {
            ImpTrigger->Kill(ImpTrigger, false);
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, DONE);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
        {
            if(!TriggerGUID)
            {
                if(Creature* ImpTrigger = GetClosestCreatureWithEntry(me, MOB_GAUNTLET_IMP_TRIGGER, 70))
                    TriggerGUID = ImpTrigger->GetGUID();
            }
            if(Yell_timer && TriggerGUID)
            {
                if(Yell_timer <= diff)
                {
                    me->YellToZone(YELL_GAUNTLET_START, 0, me->GetGUID());
                    Yell_timer = 0;
                }
                else
                    Yell_timer -= diff;
            }
        }

        if(!UpdateVictim())
            return;

        if(ShieldSlam < diff)
        {
            AddSpellToCast(SPELL_SHIELD_SLAM, CAST_TANK);
            ShieldSlam = urand(8000, 12000);
        }
        else
            ShieldSlam -= diff;

        if(ShoutTimer < diff)
        {
            DoCast(me, SPELL_BATTLE_SHOUT);
            ShoutTimer = 30000;
        }
        else
            ShoutTimer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_shadowsword_commander(Creature *_Creature)
{
    return new mob_shadowsword_commanderAI(_Creature);
}

/****************
* Shadowsword Deathbringer - id 25485

  Immunities: stun, polymorph, interrupt, silence

*****************/

enum ShadowswordDeathbringer
{
    SPELL_DISEASE_BUFFET            = 46481,
    SPELL_VOLATILE_DISEASE          = 46483
};

struct mob_shadowsword_deathbringerAI : public ScriptedAI
{
    mob_shadowsword_deathbringerAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
        me->SetAggroRange(AGGRO_RANGE);
    }

    uint32 DiseaseBuffet;
    uint32 VolatileDisease;
    uint32 DespawnTimer;
    ScriptedInstance* pInstance;

    void Reset()
    {
        me->setActive(true);
        DiseaseBuffet = urand(5000, 10000);
        VolatileDisease = urand(3000, 6000);
        DespawnTimer = 15000;
        DoCast(me, SPELL_DUAL_WIELD, true);
    }

    void EnterEvadeMode()
    {
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void EnterCombat(Unit*) { DoZoneInCombat(80.0f); }

    void IsSummonedBy(Unit *summoner)
    {
        me->SetSpeed(MOVE_RUN, 1.5);
        me->GetMotionMaster()->MovePath(GAUNTLET_PATH, false);
    }

    void UpdateAI(const uint32 diff)
    {
        if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE && !me->isInCombat())
        {
            if (DespawnTimer < diff)
                me->ForcedDespawn();
            else
                DespawnTimer -= diff;
        }

        if(!UpdateVictim())
            return;

        if(DiseaseBuffet < diff)
        {
            AddSpellToCast(SPELL_DISEASE_BUFFET);
            DiseaseBuffet = urand(10000, 14000);
        }
        else
            DiseaseBuffet -= diff;

        if(VolatileDisease < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 8.0f, true))
                AddSpellToCast(target, SPELL_VOLATILE_DISEASE);
            VolatileDisease = urand(10000, 16000);
        }
        else
            VolatileDisease -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_shadowsword_deathbringer(Creature *_Creature)
{
    return new mob_shadowsword_deathbringerAI(_Creature);
}

/****************
* Shadowsword Lifeshaper - id 25506

  Immunities: interrupt, stun, silence, confusion

*****************/

enum ShadowswordLifeshaper
{
    SPELL_DRAIN_LIFE                = 46466,
    SPELL_HEALTH_FUNNEL             = 46467,
};

struct mob_shadowsword_lifeshaperAI : public ScriptedAI
{
    mob_shadowsword_lifeshaperAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 DrainLife;
    uint32 HealthFunnel;
    bool canFunnelHP;

    void Reset()
    {
        ClearCastQueue();
        DrainLife = (4000, 10000);
        HealthFunnel = 8000;
        canFunnelHP = true;
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == DONE)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);
    }

    void JustDied(Unit* killer)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == DONE)
            me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        else
            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
    }

    void EnterEvadeMode()
    {
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void MoveInLineOfSight(Unit* who)
    {
        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == NOT_STARTED)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, IN_PROGRESS);

        DoZoneInCombat(80.0f);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(!canFunnelHP)
        {
            if(HealthFunnel < diff)
                canFunnelHP = true;
            else
                HealthFunnel -= diff;
        }

        if(Unit* healTarget = SelectLowestHpFriendly(25, 50000))
        {
            if(!HealthBelowPct(35) && canFunnelHP)
            {
                AddSpellToCast(healTarget, SPELL_HEALTH_FUNNEL);
                canFunnelHP = false;
                HealthFunnel = 8000;
            }
        }

        if(DrainLife < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 50, true))
                AddSpellToCast(target, SPELL_DRAIN_LIFE);
            DrainLife = urand(10000,15000);
        }
        else
            DrainLife -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_shadowsword_lifeshaper(Creature *_Creature)
{
    return new mob_shadowsword_lifeshaperAI(_Creature);
}

/****************
* Shadowsword Manafiend - id 25483

  Immunities: stun, confusion

*****************/

enum ShadowswordManafiend
{
    SPELL_ARCANE_EXPLOSION_2        = 46457,
    SPELL_CHILLING_TOUCH_AURA       = 46744,
    SPELL_DRAIN_MANA                = 46453
};

struct mob_shadowsword_manafiendAI : public ScriptedAI
{
    mob_shadowsword_manafiendAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 ArcaneExplosion;
    uint32 DrainMana;
    uint32 CheckTimer;

    void Reset()
    {
        ClearCastQueue();
        DoCast(me, SPELL_CHILLING_TOUCH_AURA);
        DrainMana = urand(3000, 5000);
        CheckTimer = 1000;
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == DONE)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);
    }

    void JustDied(Unit* killer)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == DONE)
            me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        else
            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
    }

    void EnterEvadeMode()
    {
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void MoveInLineOfSight(Unit* who)
    {
        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == NOT_STARTED)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, IN_PROGRESS);

        DoZoneInCombat(80.0f);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(CheckTimer < diff)
        {
            if(me->IsWithinDistInMap(me->getVictim(), 15))
                AddSpellToCast(SPELL_ARCANE_EXPLOSION_2, CAST_SELF);
            CheckTimer = urand(4000, 8000);
        }
        else
            CheckTimer -= diff;

        if(DrainMana < diff)
        {
            AddSpellToCast(SPELL_DRAIN_MANA, CAST_NULL);
            DrainMana = urand(10000, 20000);
        }
        else
            DrainMana -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_shadowsword_manafiend(Creature *_Creature)
{
    return new mob_shadowsword_manafiendAI(_Creature);
}

/****************
* Shadowsword Soulbinder - id 25373

  Immunities: polymorph, charm, disarm, stun, root, silence/interrupt, snare

*****************/

enum ShadowswordSoulbinder
{
    SPELL_CURSE_OF_EXHAUSTION       = 46434,
    SPELL_DOMINATION                = 46427,
    SPELL_FLASH_OF_DARKNESS         = 46442
};

struct mob_shadowsword_soulbinderAI : public ScriptedAI
{
    mob_shadowsword_soulbinderAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 CurseOfExhaustion;
    uint32 Domination;
    uint32 FlashOfDarkness;

    void Reset()
    {
        ClearCastQueue();
        CurseOfExhaustion = urand(4000, 8000);
        Domination = urand(6000, 10000);
        FlashOfDarkness = urand(2000, 6000);
    }

    void JustDied(Unit* killer)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == DONE)
            me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        else
            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
    }

    void EnterEvadeMode()
    {
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void MoveInLineOfSight(Unit* who)
    {
        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == NOT_STARTED)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, IN_PROGRESS);

        DoZoneInCombat(80.0f);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(CurseOfExhaustion < diff)
        {
            AddSpellToCast(SPELL_CURSE_OF_EXHAUSTION, CAST_RANDOM);
            CurseOfExhaustion = urand(5000,10000);
        }
        else
            CurseOfExhaustion -= diff;

        if(Domination < diff)
        {
            AddSpellToCast(SPELL_DOMINATION, CAST_TANK);
            Domination = urand(14000, 24000);
        }
        else
            Domination -= diff;

        if(FlashOfDarkness < diff)
        {
            AddSpellToCast(SPELL_FLASH_OF_DARKNESS, CAST_NULL);
            FlashOfDarkness = urand(10000, 15000);
        }
        else
            FlashOfDarkness -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_shadowsword_soulbinder(Creature *_Creature)
{
    return new mob_shadowsword_soulbinderAI(_Creature);
}

/****************
* Shadowsword Vanquisher - id 25486

  Immunities: stun, disarm, taunt

*****************/

enum ShadowswordVanquisher
{
    SPELL_CLEAVE_2                  = 46468,
    SPELL_MELT_AROMOR               = 46469
};

struct mob_shadowsword_vanquisherAI : public ScriptedAI
{
    mob_shadowsword_vanquisherAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
        emote = false;
    }

    ScriptedInstance* pInstance;
    uint32 Cleave;
    uint32 MeltArmor;
    bool emote;

    void Reset()
    {
        ClearCastQueue();
        Cleave = urand(5000, 16000);
        MeltArmor = urand(3000, 10000);
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == DONE)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);
    }

    void JustDied(Unit* killer)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == DONE)
            me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        else
            me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
    }

    void EnterEvadeMode()
    {
        if (pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void MoveInLineOfSight(Unit* who)
    {
        if ((me->GetDBTableGUIDLow() == 44465 || me->GetDBTableGUIDLow() == 44468) &&
            who->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(who, 35) && !emote)
        {
            if (Creature* Manafiend = GetClosestCreatureWithEntry(me, 25483, 20))
                Manafiend->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_STATE_READY1H);
            if (me->GetDBTableGUIDLow() == 44465)
                me->Yell("Intruders! Do not let them into the Sanctum!", 0, who->GetGUID());
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_STATE_READY1H);
            emote = true;
        }
        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == NOT_STARTED)
            pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, IN_PROGRESS);

        DoZoneInCombat(80.0f);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(MeltArmor < diff)
        {
            AddSpellToCast(SPELL_MELT_AROMOR, CAST_TANK);
            MeltArmor = urand(8000, 16000);
        }
        else
            MeltArmor -= diff;

        if(Cleave < diff)
        {
            AddSpellToCast(SPELL_CLEAVE_2, CAST_TANK);
            Cleave = urand(4000, 9000);
        }
        else
            Cleave -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_shadowsword_vanquisher(Creature *_Creature)
{
    return new mob_shadowsword_vanquisherAI(_Creature);
}

/****************
* Volatile Fiend - id 25851

  Immunities: banish, enslave, turn, fear, horror

*****************/

enum VolatileFiend
{
    SPELL_BURNING_WINGS                 = 46308,
    SPELL_BURNING_DESTRUCTION           = 47287,
    SPELL_BURNING_DESTRUCTION_EXPLOSION = 46218,
    SPELL_FELFIRE_FISSION               = 45779
};

struct mob_volatile_fiendAI : public ScriptedAI
{
    mob_volatile_fiendAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
        me->SetAggroRange(AGGRO_RANGE);
    }

    bool summoned, exploding;
    uint32 explosion_timer;
    ScriptedInstance* pInstance;

    void Reset()
    {
        summoned = false;
        exploding = false;
        explosion_timer = 2000;
    }

    void EnterCombat(Unit*)
    {
        DoZoneInCombat(80.0f);
        if (summoned)
        {
            DoCast(me, SPELL_BURNING_DESTRUCTION);
            exploding = true;
        }
    }

    void IsSummonedBy(Unit *summoner)
    {
        summoned = true;
        DoCast(me, SPELL_BURNING_WINGS);
        me->SetSpeed(MOVE_RUN, 1.5);
        me->GetMotionMaster()->MovePath(GAUNTLET_PATH, false);
    }

    void DamageTaken(Unit* pDone_by, uint32& damage)
    {
        if (!summoned && damage > me->GetHealth())
            DoCast(me, SPELL_FELFIRE_FISSION, true);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (!summoned && pInstance->GetData(DATA_EREDAR_TWINS_EVENT) != DONE)
            return;

        if(who->GetTypeId() != TYPEID_PLAYER || (summoned && exploding))
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (summoned && me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE &&
            !me->isInCombat() && pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
                pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, FAIL);

        if(exploding)
        {
            if(explosion_timer < diff)
            {
                me->Kill(me,false);
                exploding = false;
                explosion_timer = 2000;
            }
            explosion_timer -= diff;
        }

        if(!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_volatile_fiend(Creature *_Creature)
{
    return new mob_volatile_fiendAI(_Creature);
}

/* ============================
*
*      M'URU & ENTROPIUS
*
* ============================*/

/* Content Data
    * Apocalypse Guard
    * Cataclysm Hound
    * Chaos Gazer
    * Doomfire Destroyer
    * Doomfire Shard
    * Oblivion Mage
    * Painbringer
    * Priestess of Torment
*/

/****************
* Apocalypse Guard - id 25593

  Immunities: banish, enslave, turn, horror, confuse, stun, fear, horror, silence

*****************/

enum ApocalypseGuard
{
    SPELL_CLEAVE_3                  = 40504,
    SPELL_CORRUPTING_STRIKE         = 45029,
    SPELL_DEATH_COIL                = 46283,
    SPELL_INFERNAL_DEFENSE          = 46287
};

struct mob_apocalypse_guardAI : public ScriptedAI
{
    mob_apocalypse_guardAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 Cleave;
    uint32 CorruptingStrike;
    uint32 DeathCoil;
    bool InfernalDefense;

    void Reset()
    {
        Cleave = urand(3500, 5500);
        CorruptingStrike = urand(4000, 10000);
        DeathCoil = urand(3000, 7000);
        InfernalDefense = false;
    }


    void MoveInLineOfSight(Unit* who)
    {
        if (pInstance->GetData(DATA_EREDAR_TWINS_EVENT) != DONE)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*) { DoZoneInCombat(80.0f); }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(HealthBelowPct(7.0f) && !InfernalDefense)
        {
            DoCast(me, SPELL_INFERNAL_DEFENSE, true);
            InfernalDefense = true;
        }

        if(Cleave < diff)
        {
            AddSpellToCast(SPELL_CLEAVE_3, CAST_TANK);
            Cleave = urand(4000, 8000);
        }
        else
            Cleave -= diff;

        if(CorruptingStrike < diff)
        {
            AddSpellToCast(SPELL_CORRUPTING_STRIKE, CAST_TANK);
            CorruptingStrike = urand(6000, 12000);
        }
        else
            CorruptingStrike -= diff;

        if(DeathCoil < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30.0, true, me->getVictimGUID(), 5.0))
                AddSpellToCast(target, SPELL_DEATH_COIL, false, true);
            DeathCoil = urand(7000, 12000);
        }
        else
            DeathCoil -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_apocalypse_guard(Creature *_Creature)
{
    return new mob_apocalypse_guardAI(_Creature);
}

/****************
* Cataclysm Hound - id 25599

  Immunities: banish, enslave, turn, horror, root, confuse, stun, fear, horror, silence, taunt

*****************/

enum CataclysmHound
{
    SPELL_ENRAGE                    = 47399,
    SPELL_CATACLYSM_BREATH          = 46292
};

struct mob_cataclysm_houndAI : public ScriptedAI
{
    mob_cataclysm_houndAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 Enrage;
    uint32 CataclysmBreath;

    void Reset()
    {
        Enrage = urand(10000, 20000);
        CataclysmBreath = urand(4000, 10000);
    }


    void MoveInLineOfSight(Unit* who)
    {
        if (pInstance->GetData(DATA_EREDAR_TWINS_EVENT) != DONE)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*) { DoZoneInCombat(80.0f); }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(Enrage < diff)
        {
            AddSpellToCast(SPELL_ENRAGE, CAST_SELF);
            Enrage = urand(10000, 12000);
        }
        else
            Enrage -= diff;

        if(CataclysmBreath < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 20, true))
            {
                ClearCastQueue();
                me->SetInFront(target);
                AddSpellToCast(target, SPELL_CATACLYSM_BREATH, false, true);
            }
            CataclysmBreath = 8000;
        }
        else
            CataclysmBreath -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_cataclysm_hound(Creature *_Creature)
{
    return new mob_cataclysm_houndAI(_Creature);
}

/****************
* Chaos Gazer - id 25595

  Immunities: banish, enslave, turn, horror, confuse, stun, fear, horror, interrupt, silence

*****************/

enum ChaosGazer
{
    SPELL_DRAIN_LIFE_1              = 46291,
    SPELL_PETRIFY                   = 46288,
    SPELL_TENTACLE_SWEEP            = 46290
};

struct mob_chaos_gazerAI : public ScriptedAI
{
    mob_chaos_gazerAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 DrainLifeCD;
    uint32 Petrify;
    uint32 TentacleSweep;
    bool canDrainLife;

    void Reset()
    {
        DrainLifeCD = urand(10000, 12000);
        Petrify = urand(3000, 7000);
        TentacleSweep = Petrify + urand(1000, 1500);
        canDrainLife = true;
    }


    void MoveInLineOfSight(Unit* who)
    {
        if (pInstance->GetData(DATA_EREDAR_TWINS_EVENT) != DONE)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*) { DoZoneInCombat(80.0f); }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(HealthBelowPct(75.0f) && canDrainLife)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 22.0, true, 0, 16.0))
            {
                ForceSpellCast(target, SPELL_DRAIN_LIFE_1, DONT_INTERRUPT, false, true);
                DrainLifeCD = urand(10000, 12000);
            }
            else
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 16.0, true, 0, 8.0))
            {
                ForceSpellCast(target, SPELL_DRAIN_LIFE_1, DONT_INTERRUPT, false, true);
                DrainLifeCD = urand(10000, 12000);
            }
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 8.0, true, me->getVictimGUID()))
            {
                ForceSpellCast(target, SPELL_DRAIN_LIFE_1, DONT_INTERRUPT, false, true);
                DrainLifeCD = urand(10000, 12000);
            }
            else
                DrainLifeCD = 1000;
            canDrainLife = false;
        }

        if(!canDrainLife)
        {
            if(DrainLifeCD <= diff)
                canDrainLife = true;
            else
                DrainLifeCD -= diff;
        }

        if(Petrify < diff)
        {
            AddSpellToCast(SPELL_PETRIFY, CAST_TANK);
            Petrify = urand(9000, 12000);
        }
        else
            Petrify -= diff;

        if(TentacleSweep < diff)
        {
            AddSpellToCast(SPELL_TENTACLE_SWEEP, CAST_TANK);
            TentacleSweep = urand(7000, 12000);
        }
        else
            TentacleSweep -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_chaos_gazer(Creature *_Creature)
{
    return new mob_chaos_gazerAI(_Creature);
}


/****************
* Doomfire Destroyer - id 25592

  Immunities: banish, enslave, turn, confuse, stun, fear, horror

*****************/

enum DoomfireDestroyer
{
    SPELL_CREATE_DOMMFIRE_SHARD     = 46306,
    SPELL_IMMOLATION_AURA           = 31722
};

struct mob_doomfire_destroyerAI : public ScriptedAI
{
    mob_doomfire_destroyerAI(Creature *c) : ScriptedAI(c), summons(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 SummonTimer;
    SummonList summons;

    void Reset()
    {
        DoCast(me, SPELL_IMMOLATION_AURA, true);
        SummonTimer = 1000;
        summons.DespawnAll();
    }

    void EnterEvadeMode()
    {
        summons.DespawnAll();
        ScriptedAI::EnterEvadeMode();
    }

    void JustSummoned(Creature *summon)
    {
        summons.Summon(summon);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (pInstance->GetData(DATA_EREDAR_TWINS_EVENT) != DONE)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*)
    {
        DoZoneInCombat(80.0f);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(SummonTimer < diff)
        {
            AddSpellToCast(SPELL_CREATE_DOMMFIRE_SHARD, CAST_NULL);
            SummonTimer = urand(5500, 7000);
        }
        else
            SummonTimer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_doomfire_destroyer(Creature *_Creature)
{
    return new mob_doomfire_destroyerAI(_Creature);
}

/****************
* Doomfire Shard - id 25948

  Immunities: banish, enslave, turn, confuse, stun, fear, horror

*****************/

enum DoomfireShard
{
    SPELL_AVENGING_RAGE             = 46305
};

struct mob_doomfire_shardAI : public ScriptedAI
{
    mob_doomfire_shardAI(Creature *c) : ScriptedAI(c)
    {
        DestroyerGUID = 0;
    }

    uint64 DestroyerGUID;

    void Reset()
    {
        DoCast(me, SPELL_IMMOLATION_AURA, true);
    }

    void IsSummonedBy(Unit *pSummoner)
    {
        if (pSummoner)
        {
            DestroyerGUID = pSummoner->GetGUID();
            DoZoneInCombat(80.0f);
        }
    }

    void DamageTaken(Unit* pDone_by, uint32& damage)
    {
        if (damage > me->GetHealth())
        {
            if (Unit* Destroyer = me->GetUnit(DestroyerGUID))
            {
                if (Destroyer->isAlive())
                    DoCast(Destroyer, SPELL_AVENGING_RAGE, true);
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_doomfire_shard(Creature *_Creature)
{
    return new mob_doomfire_shardAI(_Creature);
}

/****************
* Oblivion Mage - id 25597

  Immunities: silence, interrupt, spell haste reduction, polymorph, stun, fear, horror

*****************/

enum OblivionMage
{
    SPELL_FLAME_BUFFET              = 46279,
    SPELL_POLYMORPH                 = 46280,
    SPELL_FIRE_CHANNELING           = 46219,

    NPC_DOOMFIRE_DESTROYER          = 25592
};

struct mob_oblivion_mageAI : public ScriptedAI
{
    mob_oblivion_mageAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(20.0);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 Polymorph;
    uint32 EvadeTimer;
    bool channeling;

    void Reset()
    {
        SetAutocast(SPELL_FLAME_BUFFET, 2000, true);
        Polymorph = 1000;
        EvadeTimer = 10000;
        channeling = false;
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (pInstance->GetData(DATA_EREDAR_TWINS_EVENT) != DONE)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*)
    {
        DoZoneInCombat(80.0f);
        if (me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat() && !channeling)
        {
            if(EvadeTimer <= diff)
            {
                if (Unit* Destroyer = FindCreature(NPC_DOOMFIRE_DESTROYER, 20, me))
                    DoCast(me, SPELL_FIRE_CHANNELING);
                channeling = true;
            }
            else
                EvadeTimer -= diff;
        }

        if(!UpdateVictim())
            return;

        if(!me->getVictim()->IsWithinDistInMap(me, 20) && !me->IsNonMeleeSpellCasted(false))
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 20.0, true))
                AttackStart(target, false);
        }

        if(Polymorph < diff)
        {
            ClearCastQueue();
            AddSpellToCast(SPELL_POLYMORPH, CAST_RANDOM_WITHOUT_TANK, false, true);
            Polymorph = urand(5000, 8000);
        }
        else
            Polymorph -= diff;

        CastNextSpellIfAnyAndReady(diff);
    }
};

CreatureAI* GetAI_mob_oblivion_mage(Creature *_Creature)
{
    return new mob_oblivion_mageAI(_Creature);
}

/****************
* Painbringer - id 25591

  Immunities: banish, enslave, turn, horror, fear, disorient, root

*****************/

enum Painbringer
{
    SPELL_BRING_PAIN_AURA           = 46277
};

struct mob_painbringerAI : public ScriptedAI
{
    mob_painbringerAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;

    void Reset()
    {
        DoCast(me, SPELL_BRING_PAIN_AURA, true);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (pInstance->GetData(DATA_EREDAR_TWINS_EVENT) != DONE)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*) { DoZoneInCombat(80.0f); }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_painbringer(Creature *_Creature)
{
    return new mob_painbringerAI(_Creature);
}

/****************
* Priestess of Torment - id 25509

  Immunities: banish, enslave, turn, stun, fear, horror, confuse, root

*****************/

enum PriestessOfTorment
{
    SPELL_BURN_MANA_AURA            = 46267,
    SPELL_WHIRLWIND                 = 46270,
};

struct mob_priestess_of_tormentAI : public ScriptedAI
{
    mob_priestess_of_tormentAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 Whirlwind;
    uint32 MoveTimer;
    bool moving;

    void Reset()
    {
        DoCast(me, SPELL_BURN_MANA_AURA, true);
        Whirlwind = urand(2500, 4500);
        MoveTimer = 1000;
        moving = false;
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (pInstance->GetData(DATA_EREDAR_TWINS_EVENT) != DONE)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*) { DoZoneInCombat(80.0f); }

    void OnAuraRemove(Aura* Aur, bool stack)
    {
        if(Aur->GetId() == SPELL_WHIRLWIND)
        {
            moving = false;
            AttackStart(me->getVictim());
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if (moving)
        {
            if(MoveTimer < diff)
            {
                float x, y, z = 0;
                if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                {
                    target->GetGroundPointAroundUnit(x, y, z, 5.0, 3.14*RAND(0, 1/6, 2/6, 3/6, 4/6, 5/6, 1));
                    me->GetMotionMaster()->Clear(false);
                    me->SetSpeed(MOVE_RUN, 1.5, true);
                    me->GetMotionMaster()->MovePoint(0, x, y, z);
                }
                MoveTimer = urand(1000, 2500);
            }
            else
                MoveTimer -= diff;
        }

        if(Whirlwind < diff)
        {
            DoCast(me, SPELL_WHIRLWIND);
            moving = true;
            Whirlwind = urand(13000, 16000);
        }
        else
            Whirlwind -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_priestess_of_torment(Creature *_Creature)
{
    return new mob_priestess_of_tormentAI(_Creature);
}

/* ============================
*
*      KIL'JAEDEN
*
* ============================*/

/* Content Data
    * Shadowsword Guardian
    * Hand of the Deceiver - at KJ script
*/

/****************
* Shadowsword Guardian - id 25508

  Immunities: TBD

*****************/

enum ShadowswordGuardian
{
    SPELL_BEAR_DOWN                 = 46239,
    SPELL_EARTHQUAKE                = 46932
};

struct mob_shadowsword_guardianAI : public ScriptedAI
{
    mob_shadowsword_guardianAI(Creature *c) : ScriptedAI(c)
    {
        me->SetAggroRange(AGGRO_RANGE);
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;
    uint32 BearDown;

    void Reset()
    {
        BearDown = urand(7000, 10000);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (pInstance->GetData(DATA_MURU_EVENT) != DONE)
            return;

        ScriptedAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit*)
    {
        if (pInstance->GetData(DATA_MURU_EVENT) != DONE)
        {
            EnterEvadeMode();
            return;
        }
        DoCast(me, SPELL_EARTHQUAKE);
        DoZoneInCombat(80.0f);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(BearDown < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 50.0f, true, me->getVictimGUID(), 7.0f))
                AddSpellToCast(target, SPELL_BEAR_DOWN, false, true);
            BearDown = urand(7000, 14000);
        }
        else
            BearDown -= diff;

        DoMeleeAttackIfReady();
        CastNextSpellIfAnyAndReady();
    }
};

CreatureAI* GetAI_mob_shadowsword_guardian(Creature *_Creature)
{
    return new mob_shadowsword_guardianAI(_Creature);
}

/****************
* Gauntlet Imp Trigger - id 25848
*
*****************/

#define SPELL_SUMMON_VISUAL    46172

struct npc_gauntlet_imp_triggerAI : public Scripted_NoMovementAI
{
    npc_gauntlet_imp_triggerAI(Creature *c) : Scripted_NoMovementAI(c), summons(c)
    {
        me->SetAggroRange(2*AGGRO_RANGE);
        pInstance = c->GetInstanceData();
        me->GetPosition(wLoc);
    }

    ScriptedInstance* pInstance;
    WorldLocation wLoc;
    SummonList summons;
    uint32 Deathbringer_timer;
    uint32 Imp_timer;

    void Reset()
    {
        me->setActive(true);
        Deathbringer_timer = 30000;
        Imp_timer = 1000;
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        summons.DespawnAll();
    }

    void JustRespawned()
    {
        pInstance->SetData(DATA_TRASH_GAUNTLET_EVENT, NOT_STARTED);
        if(me->HasAura(SPELL_SUMMON_VISUAL))
            me->RemoveAura(SPELL_SUMMON_VISUAL, 0);
        summons.DespawnAll();
    }

    void JustSummoned(Creature *summon)
    {
        summons.Summon(summon);
    }

    void EnterCombat(Unit* who)
    {
        return;
    }

    void UpdateAI(const uint32 diff)
    {
        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == IN_PROGRESS)
        {
            if(!me->HasAura(SPELL_SUMMON_VISUAL))
                DoCast(me, SPELL_SUMMON_VISUAL, true);

            if(Imp_timer < diff)
            {
                me->SummonCreature(MOB_VOLATILE_FIEND, wLoc.coord_x, wLoc.coord_y, wLoc.coord_z, wLoc.orientation, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                Imp_timer = 12000;
            }
            else
                Imp_timer -= diff;

            if(Deathbringer_timer < diff)
            {
                me->SummonCreature(MOB_SHADOWSWORD_DEATHBRINGER, wLoc.coord_x, wLoc.coord_y, wLoc.coord_z, wLoc.orientation, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                Deathbringer_timer = 45000;
            }
            Deathbringer_timer -= diff;
        }

        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == FAIL)
            JustRespawned();

        if(pInstance->GetData(DATA_TRASH_GAUNTLET_EVENT) == DONE)
        {
            me->Kill(me, false);
            JustRespawned();
        }
    }
};

CreatureAI* GetAI_npc_gauntlet_imp_trigger(Creature *_Creature)
{
    return new npc_gauntlet_imp_triggerAI(_Creature);
}

void AddSC_sunwell_plateau_trash()
{
    Script *newscript;

    // Kalecgos & Sathovarr & Brutallus & Felmyst
    newscript = new Script;
    newscript->Name = "mob_sunblade_arch_mage";
    newscript->GetAI = &GetAI_mob_sunblade_arch_mage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_cabalist";
    newscript->GetAI = &GetAI_mob_sunblade_cabalist;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_dawn_priest";
    newscript->GetAI = &GetAI_mob_sunblade_dawn_priest;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_dusk_priest";
    newscript->GetAI = &GetAI_mob_sunblade_dusk_priest;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_protector";
    newscript->GetAI = &GetAI_mob_sunblade_protector;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_scout";
    newscript->GetAI = &GetAI_mob_sunblade_scout;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_slayer";
    newscript->GetAI = &GetAI_mob_sunblade_slayer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_vindicator";
    newscript->GetAI = &GetAI_mob_sunblade_vindicator;
    newscript->RegisterSelf();

    // Eredar Twins
    newscript = new Script;
    newscript->Name = "mob_shadowsword_assassin";
    newscript->GetAI = &GetAI_mob_shadowsword_assassin;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadowsword_commander";
    newscript->GetAI = &GetAI_mob_shadowsword_commander;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadowsword_deathbringer";
    newscript->GetAI = &GetAI_mob_shadowsword_deathbringer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadowsword_lifeshaper";
    newscript->GetAI = &GetAI_mob_shadowsword_lifeshaper;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadowsword_manafiend";
    newscript->GetAI = &GetAI_mob_shadowsword_manafiend;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadowsword_soulbinder";
    newscript->GetAI = &GetAI_mob_shadowsword_soulbinder;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadowsword_vanquisher";
    newscript->GetAI = &GetAI_mob_shadowsword_vanquisher;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_volatile_fiend";
    newscript->GetAI = &GetAI_mob_volatile_fiend;
    newscript->RegisterSelf();

    // M'uru
    newscript = new Script;
    newscript->Name = "mob_apocalypse_guard";
    newscript->GetAI = &GetAI_mob_apocalypse_guard;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_cataclysm_hound";
    newscript->GetAI = &GetAI_mob_cataclysm_hound;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_chaos_gazer";
    newscript->GetAI = &GetAI_mob_chaos_gazer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_doomfire_destroyer";
    newscript->GetAI = &GetAI_mob_doomfire_destroyer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_doomfire_shard";
    newscript->GetAI = &GetAI_mob_doomfire_shard;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_oblivion_mage";
    newscript->GetAI = &GetAI_mob_oblivion_mage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_painbringer";
    newscript->GetAI = &GetAI_mob_painbringer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_priestess_of_torment";
    newscript->GetAI = &GetAI_mob_priestess_of_torment;
    newscript->RegisterSelf();

    // Kil'jaeden
    newscript = new Script;
    newscript->Name = "mob_shadowsword_guardian";
    newscript->GetAI = &GetAI_mob_shadowsword_guardian;
    newscript->RegisterSelf();

    // others
    newscript = new Script;
    newscript->Name = "npc_gauntlet_imp_trigger";
    newscript->GetAI = &GetAI_npc_gauntlet_imp_trigger;
    newscript->RegisterSelf();
}
