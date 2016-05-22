/* Copyright (C) 2008 - 2010 Looking4groupDev <http://gamefreedom.pl/>
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 */

/* ScriptData
SDName: Magister_Terrace_Trash
SD%Complete: 95%
SDComment: Check timers, spell Ids and cosmetics mostly for heroic versions. Implement Sunblade Keeper event.
SDCategory: Magister Terrace
EndScriptData */

#include "precompiled.h"
#include "def_magisters_terrace.h"

/**********
* Contents:
*
* mob_sunwell_mage_guard      - ID 24683
* mob_sunblade_magister       - ID 24685
* mob_sunblade_warlock        - ID 24686
* mob_sunblade_physician      - ID 24687
* mob_sunblade_blood_knight   - ID 24684
* mob_wretched_skulker        - ID 24688
* mob_wretched_bruiser        - ID 24689
* mob_wretched_husk           - ID 24690
* mob_brightscale_wyrm        - ID 24761
* mob_sister_of_torment       - ID 24697
* mob_sunblade_sentinel       - ID 24777
* mob_coilskar_witch          - ID 24696
* mob_ethereum_smuggler       - ID 24698
*
* mob_mgt_kalecgos            - ID 24844
* npc_kalec                   - ID 24848
* go_movie_orb                - ID 187578
*
**********/

// mobs DB GUIDs that should respawn group formation on evade
uint32 KaelTrashDBguid[6]=
{
    96850,
    96781,
    96841,
    96809,
    96770,
    96847
};

#define SPELL_GLAIVE_THROW              (HeroicMode?46028:44478)
#define SPELL_MAGIC_DAMPENING_FIELD     44475
#define NPC_BROKEN_SENTINEL             24808
#define SPELL_FEL_CRYSTAL_COSMETIC      44374
#define SPELL_FEL_ENERGY_COSMETIC       44574

struct mob_sunwell_mage_guardAI : public ScriptedAI
{
    mob_sunwell_mage_guardAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;
    uint32 Glaive_Timer;
    uint32 Magic_Field_Timer;
    uint32 OOCTimer;

    void Reset()
    {
        Glaive_Timer = (HeroicMode?urand(3000, 6000):urand(5000,10000));
        Magic_Field_Timer = (10000, 20000);
        OOCTimer = 5000;
    }

    void EnterEvadeMode()
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 0);
                if(CreatureGroup *formation = me->GetFormation())
                    formation->RespawnFormation(me);
                break;
            }
        }
        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit* killer)
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 1);
            }
        }
    }

    void HandleOffCombatEffects()
    {
        if(Unit* sentinel = FindCreature(NPC_BROKEN_SENTINEL, 10.0f, me))
            DoCast(sentinel, SPELL_FEL_ENERGY_COSMETIC);
    }

    void EnterCombat(Unit* who)
    {
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

      if(Glaive_Timer < diff)
      {
          if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 60.0, true))
              AddSpellToCast(target, SPELL_GLAIVE_THROW);
          Glaive_Timer = urand(14000,20000);
      }
      else
          Glaive_Timer -= diff;

       if(Magic_Field_Timer < diff)
       {
           if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 60.0, true))
               AddSpellToCast(target, SPELL_MAGIC_DAMPENING_FIELD);
           Magic_Field_Timer = urand(50000,65000);
       }
       else
            Magic_Field_Timer -= diff;

       CastNextSpellIfAnyAndReady();
       DoMeleeAttackIfReady();
    }
};

#define SPELL_ARCANE_NOVA                   (HeroicMode?46036:44644)
#define SPELL_FROSTBOLT                     (HeroicMode?46035:44606)
#define SPELL_ENCHANTMENT_OF_SPELL_HASTE    44604
#define SPELL_SPELL_HASTE                   44605

struct mob_sunblade_magisterAI : public ScriptedAI
{
    mob_sunblade_magisterAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 Frostbolt_Timer;
    uint32 Arcane_Nova_Timer;
    uint32 OOCTimer;

    void Reset()
    {
        Frostbolt_Timer = 0;
        Arcane_Nova_Timer = urand (12000, 20000);
        OOCTimer = 5000;
    }

    void EnterEvadeMode()
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 0);
                if(CreatureGroup *formation = me->GetFormation())
                    formation->RespawnFormation(me);
                break;
            }
        }
        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit* killer)
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 1);
            }
        }
    }

    void HandleOffCombatEffects()
    {
        if(Unit* sentinel = FindCreature(NPC_BROKEN_SENTINEL, 10.0f, me))
            DoCast(sentinel, SPELL_FEL_ENERGY_COSMETIC);
    }

    void EnterCombat(Unit* who)
    {
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
    }

    void AttackStart(Unit* who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
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

      if(Frostbolt_Timer < diff)
      {
          AddSpellToCast(me->getVictim(), SPELL_FROSTBOLT);
          Frostbolt_Timer = SpellMgr::GetSpellCastTime(GetSpellStore()->LookupEntry(SPELL_FROSTBOLT))-(diff+100);
      }
      else
          Frostbolt_Timer -= diff;

      if(Arcane_Nova_Timer < diff)
      {
          ClearCastQueue();
          AddSpellToCast(SPELL_ARCANE_NOVA, CAST_SELF);
          Arcane_Nova_Timer = urand(16000, 20000);
      }
      else
          Arcane_Nova_Timer -= diff;

      CheckCasterNoMovementInRange(diff, 35.0);
      CastNextSpellIfAnyAndReady();
      DoMeleeAttackIfReady();
    }
};

#define SPELL_FEL_ARMOR                     44520
#define SPELL_SUMMON_SUNBLADE_IMP           44517
#define SPELL_IMMOLATE                      (HeroicMode?46042:44518)
#define SPELL_INCINERATE                    (HeroicMode?46043:44519)

struct mob_sunblade_warlockAI : public ScriptedAI
{
    mob_sunblade_warlockAI(Creature *c) : ScriptedAI(c), Summons(me)
    {
        pInstance = (c->GetInstanceData());
        FelArmor_Timer = 120000;    //check each 2 minutes
        SummonGUID = 0;
    }

    ScriptedInstance* pInstance;
    SummonList Summons;

    uint32 SummonImp_Timer;
    uint32 FelArmor_Timer;
    uint32 Immolate_Timer;
    uint32 OOCTimer;
    uint64 SummonGUID;

    void Reset()
    {
        SummonImp_Timer = 5000;
        DoCast(me, SPELL_FEL_ARMOR, true);
        SetAutocast(SPELL_INCINERATE, 1900, true);
        Immolate_Timer = urand(8000, 12000);
        OOCTimer = 5000;
    }

    void EnterEvadeMode()
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 0);
                if(CreatureGroup *formation = me->GetFormation())
                    formation->RespawnFormation(me);
                break;
            }
        }
        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit* killer)
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 1);
            }
        }
        Summons.DespawnAll();
    }

    void HandleOffCombatEffects()
    {
        if(Unit* sentinel = FindCreature(NPC_BROKEN_SENTINEL, 10.0f, me))
            DoCast(sentinel, SPELL_FEL_ENERGY_COSMETIC);
    }

    void EnterCombat(Unit* who)
    {
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
    }

    void JustSummoned(Creature* summoned)
    {
        SummonGUID = summoned->GetGUID();
        Summons.Summon(summoned);
    }

    void AttackStart(Unit* who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
        if(Creature* Imp = me->GetMap()->GetCreature(SummonGUID))
            Imp->AI()->AttackStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
      if(!me->isInCombat())
      {
          if(SummonImp_Timer < diff)
          {
              // check if still having pet ;]
              if(!me->GetMap()->GetCreature(SummonGUID))
                  SummonGUID = 0;

              if(!SummonGUID)
                  DoCast(m_creature, SPELL_SUMMON_SUNBLADE_IMP, false);
              SummonImp_Timer = 15000;
          }
          else
              SummonImp_Timer -= diff;
      }

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

      if(FelArmor_Timer < diff)
      {
          if(!me->HasAura(SPELL_FEL_ARMOR, 0))
              DoCast(me, SPELL_FEL_ARMOR, true);
          FelArmor_Timer = 120000;
      }
      else
          FelArmor_Timer -= diff;

      if(Immolate_Timer < diff)
      {
          ClearCastQueue();
          AddSpellToCast(m_creature->getVictim(), SPELL_IMMOLATE);
          Immolate_Timer = urand(16000, 25000);
      }
      else
          Immolate_Timer -= diff;

      CheckCasterNoMovementInRange(diff);
      CastNextSpellIfAnyAndReady(diff);
      DoMeleeAttackIfReady();
    }
};

#define SPELL_FIREBALL                      (HeroicMode?46044:44577)

struct mob_sunblade_impAI : public ScriptedAI
{
    mob_sunblade_impAI(Creature *c) : ScriptedAI(c) { }

    void Reset() { }

    void AttackStart(Unit* who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
        SetAutocast(SPELL_FIREBALL, 1900, true);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

      CheckCasterNoMovementInRange(diff);
      CastNextSpellIfAnyAndReady(diff);
    }
};

#define SPELL_INJECT_POISON                 (HeroicMode?46046:44599)
#define SPELL_PRAYER_OF_MENDING             (HeroicMode?46045:44583)

struct mob_sunblade_physicianAI : public ScriptedAI
{
    mob_sunblade_physicianAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 Poison_Timer;
    uint32 Prayer_of_Mending_Timer;
    uint32 OOCTimer;

    void Reset()
    {
        Poison_Timer = urand(5000, 8000);
        Prayer_of_Mending_Timer = urand(3000, 8000);
        OOCTimer = 5000;
    }

    void EnterEvadeMode()
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 0);
                if(CreatureGroup *formation = me->GetFormation())
                    formation->RespawnFormation(me);
                break;
            }
        }
        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit* killer)
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 1);
            }
        }
    }

    void HandleOffCombatEffects()
    {
        if(Unit* sentinel = FindCreature(NPC_BROKEN_SENTINEL, 10.0f, me))
            DoCast(sentinel, SPELL_FEL_ENERGY_COSMETIC);
    }

    void EnterCombat(Unit* who)
    {
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
    }

    bool CanCastPoM()
    {
        std::list<Creature*> FriendList = FindAllFriendlyInGrid(40);
        if(FriendList.empty())
            return false;

        for(std::list<Creature*>::iterator i = FriendList.begin(); i !=  FriendList.end(); ++i)
        {
            if((*i)->HasAura(44586, 0))
                return false;
        }
        return true;
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

      if(Poison_Timer < diff)
      {
          AddSpellToCast(SPELL_INJECT_POISON, CAST_SELF);
          Poison_Timer = urand(16000, 20000);
      }
      else
          Poison_Timer -= diff;

      if(Prayer_of_Mending_Timer < diff)
      {
          if(CanCastPoM())  // only one PoM active at a time
          {
              if(Unit* healTarget = SelectLowestHpFriendly(40))
                  AddSpellToCast(healTarget, SPELL_PRAYER_OF_MENDING);
          }
          Prayer_of_Mending_Timer = urand(7000, 12000);
      }
      else
          Prayer_of_Mending_Timer -= diff;

      CastNextSpellIfAnyAndReady();
      DoMeleeAttackIfReady();
    }
};

#define SPELL_SEAL_OF_WRATH                 (HeroicMode?46030:44480)
#define SPELL_JUDGEMENT_OF_WRATH            (HeroicMode?46033:44482)
#define SPELL_HOLY_LIGHT                    (HeroicMode?46029:44479)

struct mob_sunblade_blood_knightAI : public ScriptedAI
{
    mob_sunblade_blood_knightAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 Judgement_Timer;
    uint32 Holy_Light_Timer;
    uint32 Seal_Timer;
    uint32 OOCTimer;

    void Reset()
    {
        Seal_Timer = urand(1000, 6000);
        Judgement_Timer = urand(10000, 15000);
        Holy_Light_Timer = urand(8000, 20000);
        OOCTimer = 5000;
    }

    void EnterEvadeMode()
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 0);
                if(CreatureGroup *formation = me->GetFormation())
                    formation->RespawnFormation(me);
                break;
            }
        }
        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit* killer)
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 1);
            }
        }
    }

    void HandleOffCombatEffects()
    {
        if(Unit* sentinel = FindCreature(NPC_BROKEN_SENTINEL, 10.0f, me))
            DoCast(sentinel, SPELL_FEL_ENERGY_COSMETIC);
    }

    void EnterCombat(Unit* who)
    {
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

        if(Seal_Timer < diff)
        {
            AddSpellToCast(SPELL_SEAL_OF_WRATH, CAST_SELF);
            Seal_Timer = urand(20000, 30000);
        }
        else
            Seal_Timer -= diff;

        if(Judgement_Timer < diff)
        {
            if(me->HasAura(SPELL_SEAL_OF_WRATH, 0))
            {
                AddSpellToCast(me->getVictim(), SPELL_JUDGEMENT_OF_WRATH);
                me->RemoveAurasDueToSpell(SPELL_SEAL_OF_WRATH);
                Seal_Timer = urand(5000, 10000);
                Judgement_Timer = urand(13000, 20000);
            }
        }
        else
            Judgement_Timer -= diff;

        if(Holy_Light_Timer < diff)
        {
            Unit* healTarget = SelectLowestHpFriendly(40.0f, 10000);
            AddSpellToCast(healTarget, SPELL_HOLY_LIGHT);
            Holy_Light_Timer = urand(7000, 10000);
        }
        else
            Holy_Light_Timer -= diff;

        CastNextSpellIfAnyAndReady(diff);
        DoMeleeAttackIfReady();
    }
};

uint32 DrainingList[8] =
{
    96837, 96829,
    96828, 96838,
    96836, 96826,
    96835, 96831
};

const char* SAY_OOC1     = "The power! More, more, more!";
const char* SAY_OOC2     = "It seethes and burns...";
const char* SAY_AGGRO1   = "Get away from my crystals!";
const char* SAY_AGGRO2   = "It's MINE!";
const char* SAY_AGGRO3   = "You wish to steal the power! Die!";

#define SPELL_DRINK_FEL_INFUSION            44505
#define SPELL_WRETCHED_STAB                 44533
#define SPELL_DUAL_WIELD                    29651

struct mob_wretched_skulkerAI : public ScriptedAI
{
    mob_wretched_skulkerAI(Creature *c) : ScriptedAI(c) {}

    uint32 Drink_Timer;
    uint32 Wretched_Stab_Timer;
    uint32 OOCTimer;

    void Reset()
    {
        me->SetStandState(PLAYER_STATE_SIT);
        DoCast(me, SPELL_DUAL_WIELD);
        OOCTimer = 10000;
        Drink_Timer = HeroicMode?urand(5000, 18000):urand(10000, 25000);
        Wretched_Stab_Timer = urand(4000, 7000);
    }

    void EnterCombat(Unit* who)
    {
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
        if(roll_chance_f(10.0))
            DoSay(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), 0, me->getVictim());
    }

    void HandleOffCombatEffects()
    {
        for (uint8 i = 0; i < 8; ++i)
        {
            if(me->GetDBTableGUIDLow() == DrainingList[i]) // draining fel crystal
                me->CastSpell((Unit*)NULL, SPELL_FEL_CRYSTAL_COSMETIC, false);
            if(roll_chance_f(2.0f))
                    DoSay(RAND(SAY_OOC1, SAY_OOC2), 0, me);
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

        if(Drink_Timer < diff)
        {
            AddSpellToCast(SPELL_DRINK_FEL_INFUSION, CAST_SELF);
            Drink_Timer = HeroicMode?urand(10000, 18000):urand(15000, 25000);
        }
        else
            Drink_Timer -= diff;

       if(Wretched_Stab_Timer < diff)
       {
           AddSpellToCast(m_creature->getVictim(), SPELL_WRETCHED_STAB);
           Wretched_Stab_Timer = urand(3000, 7000);
       }
       else
           Wretched_Stab_Timer -= diff;

       CastNextSpellIfAnyAndReady(diff);
       DoMeleeAttackIfReady();
    }
};

#define SPELL_WRETCHED_STRIKE               44534

struct mob_wretched_bruiserAI : public ScriptedAI
{
    mob_wretched_bruiserAI(Creature *c) : ScriptedAI(c) {}

    uint32 OOCTimer;
    uint32 Drink_Timer;
    uint32 Wretched_Strike_Timer;

    void Reset()
    {
        me->SetStandState(PLAYER_STATE_SIT);
        OOCTimer = 10000;
        Drink_Timer = HeroicMode?urand(5000, 18000):urand(10000, 25000);
        Wretched_Strike_Timer = urand(6000, 10000);
    }

    void EnterCombat(Unit* who)
    {
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
        if(roll_chance_f(10.0))
            DoSay(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), 0, me->getVictim());
    }

    void HandleOffCombatEffects()
    {
        for (uint8 i = 0; i < 8; ++i)
        {
            if(me->GetDBTableGUIDLow() == DrainingList[i]) // draining fel crystal
                me->CastSpell((Unit*)NULL, SPELL_FEL_CRYSTAL_COSMETIC, false);
            if(roll_chance_f(2.0f))
                    DoSay(RAND(SAY_OOC1, SAY_OOC2), 0, me);
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

        if(Drink_Timer < diff)
        {
            AddSpellToCast(SPELL_DRINK_FEL_INFUSION, CAST_SELF);
            Drink_Timer = HeroicMode?urand(10000, 18000):urand(15000, 25000);
        }
        else
            Drink_Timer -= diff;

        if(Wretched_Strike_Timer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_WRETCHED_STRIKE);
            Wretched_Strike_Timer = urand(7000, 16000);
        }
        else
            Wretched_Strike_Timer -= diff;

        CastNextSpellIfAnyAndReady(diff);
        DoMeleeAttackIfReady();
    }
};

#define SPELL_WRETCHED_FIREBALL               44503
#define SPELL_WRETCHED_FROSTBOLT              44504

struct mob_wretched_huskAI : public ScriptedAI
{
    mob_wretched_huskAI(Creature *c) : ScriptedAI(c) {}

    uint32 OOCTimer;
    uint32 Drink_Timer;
    uint32 Wretched_Cast_Timer;

    void Reset()
    {
        me->SetStandState(PLAYER_STATE_SIT);
        OOCTimer = 5000;
        Drink_Timer = HeroicMode?urand(5000, 18000):urand(15000, 25000);
        Wretched_Cast_Timer = 0;
    }

    void AttackStart(Unit* who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
    }

    void EnterCombat(Unit* who)
    {
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
        if(roll_chance_f(10.0))
            DoSay(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), 0, me->getVictim());
    }

    void HandleOffCombatEffects()
    {
        for (uint8 i = 0; i < 8; ++i)
        {
            if(me->GetDBTableGUIDLow() == DrainingList[i]) // draining fel crystal
            {
                me->CastSpell((Unit*)NULL, SPELL_FEL_CRYSTAL_COSMETIC, false);
                if(roll_chance_f(2.0f))
                    DoSay(RAND(SAY_OOC1, SAY_OOC2), 0, me);
            }
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

        if(Drink_Timer < diff)
        {
            ClearCastQueue();
            AddSpellToCast(SPELL_DRINK_FEL_INFUSION, CAST_SELF);
            Drink_Timer = HeroicMode?urand(10000, 18000):urand(15000, 25000);
        }
        else
            Drink_Timer -= diff;

       if(Wretched_Cast_Timer < diff)
       {
           AddSpellToCast(m_creature->getVictim(), RAND(SPELL_WRETCHED_FIREBALL, SPELL_WRETCHED_FROSTBOLT));
           Wretched_Cast_Timer = me->HasAura(SPELL_DRINK_FEL_INFUSION, 1) ? 1400 : 2900;
       }
       else
           Wretched_Cast_Timer -= diff;

       CheckCasterNoMovementInRange(diff, 35.0);
       CastNextSpellIfAnyAndReady(diff);
       DoMeleeAttackIfReady();
    }
};

#define SPELL_ENERGY_INFUSION                 44406

struct mob_brightscale_wyrmAI : public ScriptedAI
{
    mob_brightscale_wyrmAI(Creature *c) : ScriptedAI(c) {}
    //TODO: make Nether Energy Feeding cosmetics when Sunblade Keeper implemented?
    void Reset()
    {
        me->SetLevitate(true);
    }

    void DamageTaken(Unit* done_by, uint32& damage)
    {
        if(damage && damage >= me->GetHealth())
            DoCast((Unit*)NULL, SPELL_ENERGY_INFUSION);
    }

    void UpdateAI(const uint32 diff)
    {
       DoMeleeAttackIfReady();
    }
};

#define SPELL_LASH_OF_PAIN              44640
#define SPELL_DEADLY_EMRACE             44547

struct mob_sister_of_tormentAI : public ScriptedAI
{
    mob_sister_of_tormentAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 LashOfPain_Timer;
    uint32 DeadlyEmbrace_Timer;
    uint32 OOCTimer;

    void Reset()
    {
        LashOfPain_Timer = urand(8000,14000);
        DeadlyEmbrace_Timer = (17000, 23000);
        OOCTimer = 5000;
    }

    void EnterEvadeMode()
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 0);
                if(CreatureGroup *formation = me->GetFormation())
                    formation->RespawnFormation(me);
                break;
            }
        }
        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit* killer)
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 1);
            }
        }
    }

    void HandleOffCombatEffects()
    {
        if(Unit* sentinel = FindCreature(NPC_BROKEN_SENTINEL, 10.0f, me))
            DoCast(sentinel, SPELL_FEL_ENERGY_COSMETIC);
    }

    void EnterCombat(Unit* who)
    {
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

      if(LashOfPain_Timer < diff)
      {
          AddSpellToCast(SPELL_LASH_OF_PAIN, CAST_TANK);
          LashOfPain_Timer = urand(8000,14000);
      }
      else
          LashOfPain_Timer -= diff;

       if(DeadlyEmbrace_Timer < diff)
       {
           if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 20.0, true))
               AddSpellToCast(target, SPELL_DEADLY_EMRACE);
           DeadlyEmbrace_Timer = (17000, 23000);
       }
       else
            DeadlyEmbrace_Timer -= diff;

       CastNextSpellIfAnyAndReady();
       DoMeleeAttackIfReady();
    }
};

#define SPELL_FEL_LIGHTNING_AURA        (HeroicMode?46048:44537)

struct mob_sunblade_sentinelAI : public ScriptedAI
{
    mob_sunblade_sentinelAI(Creature *c) : ScriptedAI(c) {}

    void EnterCombat(Unit* )
    {
        DoCast(me, SPELL_FEL_LIGHTNING_AURA);
    }

    void UpdateAI(const uint32 diff)
    {
      if(!UpdateVictim())
          return;
       DoMeleeAttackIfReady();
    }
};

#define SPELL_SHOOT                     (HeroicMode?22907:35946)   // 5-30 yd
#define SPELL_MANA_SHIELD               (HeroicMode?46151:17741)
#define SPELL_FROST_ARROW               44639
#define SPELL_FORKED_LIGHTNING          (HeroicMode?46150:20299)

struct mob_coilskar_witchAI : public ScriptedAI
{
    mob_coilskar_witchAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 Check_Timer;
    uint32 Shoot_Timer;
    uint32 FrostArrow_Timer;
    uint32 ForkedLightning_Timer;
    uint32 OOCTimer;
    bool canShield;

    void Reset()
    {
        Check_Timer = 1500;
        Shoot_Timer = 0;
        FrostArrow_Timer = urand(2000, 12000);;
        ForkedLightning_Timer = urand(5000, 10000);
        OOCTimer = 5000;
        canShield = true;
    }

    void EnterEvadeMode()
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 0);
                if(CreatureGroup *formation = me->GetFormation())
                    formation->RespawnFormation(me);
                break;
            }
        }
        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit* killer)
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 1);
            }
        }
    }

    void HandleOffCombatEffects()
    {
        if(Unit* sentinel = FindCreature(NPC_BROKEN_SENTINEL, 10.0f, me))
            DoCast(sentinel, SPELL_FEL_ENERGY_COSMETIC);
    }

    void EnterCombat(Unit* who)
    {
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

      if(Check_Timer < diff)
      {
          if(HealthBelowPct(51) && canShield)
          {
              canShield = false;
              ForceSpellCast(SPELL_MANA_SHIELD, CAST_SELF);
          }
          Check_Timer = 1500;
      }
      else
          Check_Timer -= diff;

      if(Shoot_Timer < diff)
      {
          if(me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE)
          {
              if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30.0f, true, 5.0f))
                  AddSpellToCast(target, SPELL_SHOOT);
          }
          Shoot_Timer = 3000;
      }
      else
          Shoot_Timer -= diff;

      if(FrostArrow_Timer < diff)
      {
          if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 50.0f, true))
              AddSpellToCast(target, SPELL_FROST_ARROW);
          FrostArrow_Timer = urand(9000, 12000);
      }
      else
          FrostArrow_Timer -= diff;

      if(ForkedLightning_Timer < diff)
      {
          AddSpellToCast(SPELL_FORKED_LIGHTNING, CAST_NULL);
          ForkedLightning_Timer = urand(12000, 18000);
      }
      else
          ForkedLightning_Timer -= diff;

      CheckShooterNoMovementInRange(diff);
      CastNextSpellIfAnyAndReady();
      DoMeleeAttackIfReady();
    }
};

#define SPELL_ARCANE_EXPLOSION          44538

struct mob_ethereum_smugglerAI : public ScriptedAI
{
    mob_ethereum_smugglerAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 ExplosionCombo_Timer;
    uint32 Check_Timer;
    uint32 OOCTimer;

    void Reset()
    {
        Check_Timer = 0;
        ExplosionCombo_Timer = 5000;
        OOCTimer = 5000;
    }

    void EnterEvadeMode()
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 0);
                if(CreatureGroup *formation = me->GetFormation())
                    formation->RespawnFormation(me);
                break;
            }
        }
        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit* killer)
    {
        for(uint8 i = 0; i < 6; ++i)
        {
            if(me->GetDBTableGUIDLow() == KaelTrashDBguid[i])
            {
                if(pInstance)
                    pInstance->SetData(DATA_KAEL_TRASH_COUNTER, 1);
            }
        }
    }

    void HandleOffCombatEffects()
    {
        if(Unit* sentinel = FindCreature(NPC_BROKEN_SENTINEL, 10.0f, me))
            DoCast(sentinel, SPELL_FEL_ENERGY_COSMETIC);
    }

    void EnterCombat(Unit* who)
    {
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

      if(Check_Timer)
      {
          // when not casting AE, chase victim
          if(Check_Timer <= diff)
          {
              me->setHover(false);
              DoStartMovement(me->getVictim());
              Check_Timer = 0;
          }
          else
              Check_Timer -= diff;
      }

      if(ExplosionCombo_Timer < diff)
      {
          if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 100.0f, true))
          {
              float x, y, z;
              target->GetPosition(x, y, z);
              DoTeleportTo(x, y, z);
              me->setHover(true);
              me->GetMotionMaster()->MoveIdle();
              for(uint8 i = 0; i < 3; ++i)
                AddSpellToCast(SPELL_ARCANE_EXPLOSION, CAST_NULL);
              Check_Timer = 2500;
          }
          ExplosionCombo_Timer = 30000;
      }
      else
          ExplosionCombo_Timer -= diff;

      CastNextSpellIfAnyAndReady();
      DoMeleeAttackIfReady();
    }
};

#define SPELL_TRANSFORM_INTO_KALEC       44670
#define NPC_MGT_KALECGOS                 24844
#define NPC_MGT_KALEC                    24848

struct mob_mgt_kalecgosAI : public ScriptedAI
{
    mob_mgt_kalecgosAI(Creature *c) : ScriptedAI(c) { }

    uint32 Timer;
    uint32 step;

    void Reset()
    {
        Timer = 1000;
        step = 0;
        me->setActive(true);
        me->SetLevitate(true);
        me->SetSpeed(MOVE_FLIGHT, 2.0);
    }

    void MovementInform(uint32 Type, uint32 Id)
    {
        if(Type == POINT_MOTION_TYPE)
        {
            switch(Id)
            {
                case 1:
                    me->GetMap()->CreatureRelocation(me, 198.4, -273.3, -8.72, me->GetOrientation());
                    Timer = 500;
                    break;
                default:
                    break;
            }
        }
    }

    void DoFlight(uint32 step)
    {
        switch(step)
        {
            case 0:
                me->GetMotionMaster()->MovePoint(1, 198.4, -273.3, -8.72);
                Timer = 6000;
                break;
            case 1:
                DoYell("Be still, mortals, and hearken to my words.", 0, 0);
                Timer = 60000;
                break;
            case 2:
                me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                Timer = 1000;
                break;
            case 3:
                {
                float x, y, z;
                me->GetPosition(x, y, z);
                me->GetMap()->CreatureRelocation(me, x, y, z, 2*M_PI);
                Timer = 1500;
                break;
                }
            case 4:
                DoCast(me, SPELL_TRANSFORM_INTO_KALEC);
                Timer = 1000;
                break;
            case 5:
                me->SetVisibility(VISIBILITY_OFF);
                DoSpawnCreature(NPC_MGT_KALEC, 0, 0, 0, me->GetOrientation(), TEMPSUMMON_CORPSE_DESPAWN, 0);
                Timer = 2000;
                break;
            case 6:
                me->Kill(me, false);
                break;
            default:
                break;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(Timer < diff)
        {
            DoFlight(step);
            ++step;
        }
        else
            Timer -= diff;
    }
};

#define KALEC_WELCOME1      "Who are you?"
#define KALEC_WELCOME2      "What brings you to the Sunwell?"
#define KALEC_CONTINUE1     "What can we do to assist you?"
#define KALEC_CONTINUE2A    "You're not alone here?"
#define KALEC_CONTINUE2B    "What would Kil'jaeden want with a mortal woman?"

bool GossipHello_npc_kalec(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu(_Creature->GetGUID());

    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, KALEC_WELCOME1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, KALEC_WELCOME2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);

    player->SEND_GOSSIP_MENU(12498, _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_kalec(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch(action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, KALEC_CONTINUE1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(12500, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->SEND_GOSSIP_MENU(12502, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, KALEC_CONTINUE2A, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, KALEC_CONTINUE2B, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(12606, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->SEND_GOSSIP_MENU(12607, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
            player->SEND_GOSSIP_MENU(12608, _Creature->GetGUID());
            break;
    }
    return true;
}

bool GOUse_go_movie_orb(Player *player, GameObject* _GO)
{
    uint32 ScryingOrbCinematicId = 164;
    if (player)
    {
        player->SendCinematicStart(ScryingOrbCinematicId);

        if (player->GetQuestStatus(11490) == QUEST_STATUS_INCOMPLETE)
            player->KilledMonster(25042, 0);
    }
    return true;
}

bool CompletedCinematic_scrying_orb_cinematic(Player* player, CinematicSequencesEntry const* cinematic)
{
    if (player)
    {
        ScriptedInstance* pInstance = player->GetInstanceData();
        if(pInstance && pInstance->GetData(DATA_KALEC) != DONE)
        {
            pInstance->SetData(DATA_KALEC, DONE);
            player->SummonCreature(NPC_MGT_KALECGOS, 133.3, -384.3, 13.0, 0, TEMPSUMMON_CORPSE_DESPAWN, 0);
        }
    }
    return true;
}

CreatureAI* GetAI_mob_sunwell_mage_guard(Creature *_Creature)
{
    return new mob_sunwell_mage_guardAI (_Creature);
}
CreatureAI* GetAI_mob_sunblade_magister(Creature *_Creature)
{
    return new mob_sunblade_magisterAI (_Creature);
}
CreatureAI* GetAI_mob_sunblade_warlock(Creature *_Creature)
{
    return new mob_sunblade_warlockAI (_Creature);
}
CreatureAI* GetAI_mob_sunblade_imp(Creature *_Creature)
{
    return new mob_sunblade_impAI (_Creature);
}
CreatureAI* GetAI_mob_sunblade_physician(Creature *_Creature)
{
    return new mob_sunblade_physicianAI (_Creature);
}
CreatureAI* GetAI_mob_sunblade_blood_knight(Creature *_Creature)
{
    return new mob_sunblade_blood_knightAI (_Creature);
}
CreatureAI* GetAI_mob_wretched_skulker(Creature *_Creature)
{
    return new mob_wretched_skulkerAI (_Creature);
}
CreatureAI* GetAI_mob_wretched_bruiser(Creature *_Creature)
{
    return new mob_wretched_bruiserAI (_Creature);
}
CreatureAI* GetAI_mob_wretched_husk(Creature *_Creature)
{
    return new mob_wretched_huskAI (_Creature);
}
CreatureAI* GetAI_mob_brightscale_wyrm(Creature *_Creature)
{
    return new mob_brightscale_wyrmAI (_Creature);
}
CreatureAI* GetAI_mob_sister_of_torment(Creature *_Creature)
{
    return new mob_sister_of_tormentAI (_Creature);
}
CreatureAI* GetAI_mob_sunblade_sentinel(Creature *_Creature)
{
    return new mob_sunblade_sentinelAI (_Creature);
}
CreatureAI* GetAI_mob_coilskar_witch(Creature *_Creature)
{
    return new mob_coilskar_witchAI (_Creature);
}
CreatureAI* GetAI_mob_ethereum_smuggler(Creature *_Creature)
{
    return new mob_ethereum_smugglerAI (_Creature);
}
CreatureAI* GetAI_mob_mgt_kalecgos(Creature *_Creature)
{
    return new mob_mgt_kalecgosAI (_Creature);
}

void AddSC_magisters_terrace_trash()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "mob_sunwell_mage_guard";
    newscript->GetAI = &GetAI_mob_sunwell_mage_guard;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_magister";
    newscript->GetAI = &GetAI_mob_sunblade_magister;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_warlock";
    newscript->GetAI = &GetAI_mob_sunblade_warlock;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_imp";
    newscript->GetAI = &GetAI_mob_sunblade_imp;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_physician";
    newscript->GetAI = &GetAI_mob_sunblade_physician;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_blood_knight";
    newscript->GetAI = &GetAI_mob_sunblade_blood_knight;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_wretched_skulker";
    newscript->GetAI = &GetAI_mob_wretched_skulker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_wretched_bruiser";
    newscript->GetAI = &GetAI_mob_wretched_bruiser;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_wretched_husk";
    newscript->GetAI = &GetAI_mob_wretched_husk;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_brightscale_wyrm";
    newscript->GetAI = &GetAI_mob_brightscale_wyrm;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sister_of_torment";
    newscript->GetAI = &GetAI_mob_sister_of_torment;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_sunblade_sentinel";
    newscript->GetAI = &GetAI_mob_sunblade_sentinel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_coilskar_witch";
    newscript->GetAI = &GetAI_mob_coilskar_witch;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_ethereum_smuggler";
    newscript->GetAI = &GetAI_mob_ethereum_smuggler;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_mgt_kalecgos";
    newscript->GetAI = &GetAI_mob_mgt_kalecgos;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_mgt_kalec";
    newscript->pGossipHello = &GossipHello_npc_kalec;
    newscript->pGossipSelect = &GossipSelect_npc_kalec;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="go_movie_orb";
    newscript->pGOUse = &GOUse_go_movie_orb;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="scrying_orb_cinematic";
    newscript->pCompletedCinematic = &CompletedCinematic_scrying_orb_cinematic;
    newscript->RegisterSelf();
}
