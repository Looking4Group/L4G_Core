/* Copyright ?2006,2007 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/* ScriptData
SDName: Boss_Hex_Lord_Malacrass
SD%Complete:
SDComment:
SDCategory: Zul'Aman
EndScriptData */

#include "precompiled.h"
#include "def_zulaman.h"

#define YELL_SPIRIT_BOLTS       -1800493
#define YELL_DRAIN_POWER        -1800494
#define YELL_KILL_ONE           -1800495
#define YELL_KILL_TWO           -1800496
#define YELL_DEATH              -1800497

#define YELL_AGGRO              -1800512
#define YELL_ENRAGE             -1800513            // enrage?
#define YELL_SIPHON_SOUL        -1800514
#define YELL_ADD_DEAD1          -1800515
#define YELL_ADD_DEAD2          -1800516
#define YELL_ADD_DEAD3          -1800517

#define SPELL_SPIRIT_BOLTS      43383
#define SPELL_DRAIN_POWER       44131
#define SPELL_SIPHON_SOUL       43501

#define MOB_TEMP_TRIGGER        23920

//Defines for various powers he uses after using soul drain

//Druid
#define SPELL_DR_LIFEBLOOM      43421
#define SPELL_DR_THORNS         43420
#define SPELL_DR_MOONFIRE       43545

//Hunter
#define SPELL_HU_EXPLOSIVE_TRAP 43444
#define SPELL_HU_FREEZING_TRAP  43447
#define SPELL_HU_SNAKE_TRAP     43449

//Mage
#define SPELL_MG_FIREBALL       41383 // fireball is probably obsolete
#define SPELL_MG_FROSTBOLT      43428
#define SPELL_MG_FROST_NOVA     43426
#define SPELL_MG_ICE_LANCE      43427

//Paladin
#define SPELL_PA_CONSECRATION   43429
#define SPELL_PA_HOLY_LIGHT     43451
#define SPELL_PA_AVENGING_WRATH 43430

//Priest
#define SPELL_PR_HEAL           41372
#define SPELL_PR_MIND_CONTROL   43550
#define SPELL_PR_MIND_BLAST     41374
#define SPELL_PR_SW_DEATH       41375
#define SPELL_PR_PSYCHIC_SCREAM 43432
#define SPELL_PR_PAIN_SUPP      33206   // not sure, it's priest's pain suppression

//Rogue
#define SPELL_RO_BLIND          43433
#define SPELL_RO_SLICE_DICE     43547
#define SPELL_RO_WOUND_POISON   39665

//Shaman
#define SPELL_SH_FIRE_NOVA      43436
#define SPELL_SH_HEALING_WAVE   43548
#define SPELL_SH_CHAIN_LIGHT    43435

//Warlock
#define SPELL_WL_CURSE_OF_DOOM  43439
#define SPELL_WL_RAIN_OF_FIRE   43440
#define SPELL_WL_UNSTABLE_AFFL  35183

//Warrior
#define SPELL_WR_SPELL_REFLECT  43443
#define SPELL_WR_WHIRLWIND      43442
#define SPELL_WR_MORTAL_STRIKE  43441

#define ORIENT                  1.5696
#define POS_Y                   921.2795
#define POS_Z                   33.8883

static float Pos_X[4] = {112.8827, 107.8827, 122.8827, 127.8827};

static uint32 AddEntryList[8]=
{
    24240, //Alyson Antille
    24241, //Thurg
    24242, //Slither
    24243, //Lord Raadan
    24244, //Gazakroth
    24245, //Fenstalker
    24246, //Darkheart
    24247  //Koragg
};

enum AbilityTarget
{
    ABILITY_TARGET_SELF = 0,
    ABILITY_TARGET_VICTIM = 1,
    ABILITY_TARGET_ENEMY = 2,
    ABILITY_TARGET_HEAL = 3,
    ABILITY_TARGET_BUFF = 4,
    ABILITY_TARGET_SPECIAL = 5
};

struct PlayerAbilityStruct
{
    uint32 spell;
    AbilityTarget target;
    uint32 startCooldown;
    uint32 cooldown;
};

static PlayerAbilityStruct PlayerAbility[][3] =
{
    // 1 warrior
    {{SPELL_WR_SPELL_REFLECT, ABILITY_TARGET_SELF, 3000, 5000},
    {SPELL_WR_WHIRLWIND, ABILITY_TARGET_SELF, 5000, 12000},
    {SPELL_WR_MORTAL_STRIKE, ABILITY_TARGET_VICTIM, 1000, 8000}},  // 5s duration
    // 2 paladin
    {{SPELL_PA_CONSECRATION, ABILITY_TARGET_SELF, 10000, 15000},   // 20s duration
    {SPELL_PA_HOLY_LIGHT, ABILITY_TARGET_HEAL, 1000, 10000},
    {SPELL_PA_AVENGING_WRATH, ABILITY_TARGET_SELF, 5000, 20000}}, //10s duration
    // 3 hunter
    {{SPELL_HU_EXPLOSIVE_TRAP, ABILITY_TARGET_SELF, 3000, 10000},
    {SPELL_HU_FREEZING_TRAP, ABILITY_TARGET_SELF, 8000, 13000},
    {SPELL_HU_SNAKE_TRAP, ABILITY_TARGET_SELF, 10000, 15000}},
    // 4 rogue
    {{SPELL_RO_WOUND_POISON, ABILITY_TARGET_VICTIM, 1000, 3000},
    {SPELL_RO_SLICE_DICE, ABILITY_TARGET_SELF, 10000, 60000},    // 40s duration
    {SPELL_RO_BLIND, ABILITY_TARGET_ENEMY, 5000, 20000}},
    // 5 priest
    {{SPELL_PR_PAIN_SUPP, ABILITY_TARGET_HEAL, 5000, 16000},   // 8s duration
    {SPELL_PR_HEAL, ABILITY_TARGET_HEAL, 1000, 10000},
    {SPELL_PR_PSYCHIC_SCREAM, ABILITY_TARGET_SELF, 10000, 15000}},
    // 5* shadow priest
    {{SPELL_PR_MIND_CONTROL, ABILITY_TARGET_VICTIM, 10000, 18000},
    {SPELL_PR_MIND_BLAST, ABILITY_TARGET_ENEMY, 1000, 5000},
    {SPELL_PR_SW_DEATH, ABILITY_TARGET_ENEMY, 5000, 10000}},
    // 7 shaman
    {{SPELL_SH_FIRE_NOVA, ABILITY_TARGET_SELF, 5000, 13000},
    {SPELL_SH_HEALING_WAVE, ABILITY_TARGET_HEAL, 1000, 10000},
    {SPELL_SH_CHAIN_LIGHT, ABILITY_TARGET_ENEMY, 3000, 8000}},
    // 8 mage
    {{SPELL_MG_FROST_NOVA, ABILITY_TARGET_ENEMY, 5000, 15000},
    {SPELL_MG_FROSTBOLT, ABILITY_TARGET_ENEMY, 2000, 5000},
    {SPELL_MG_ICE_LANCE, ABILITY_TARGET_SPECIAL, 3000, 2000}},
    // 9 warlock
    {{SPELL_WL_CURSE_OF_DOOM, ABILITY_TARGET_ENEMY, 8000, 15000},
    {SPELL_WL_RAIN_OF_FIRE, ABILITY_TARGET_ENEMY, 2000, 10000},
    {SPELL_WL_UNSTABLE_AFFL, ABILITY_TARGET_ENEMY, 5000, 10000}},
    // 11 druid
    {{SPELL_DR_LIFEBLOOM, ABILITY_TARGET_HEAL, 2000, 10000},
    {SPELL_DR_THORNS, ABILITY_TARGET_SELF, 1000, 50000},   // 40s duration
    {SPELL_DR_MOONFIRE, ABILITY_TARGET_ENEMY, 5000, 8000}}
};

struct boss_hexlord_addAI : public ScriptedAI
{
    ScriptedInstance* pInstance;

    boss_hexlord_addAI(Creature* c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        SpellEntry *TempSpell = (SpellEntry*)GetSpellStore()->LookupEntry(SPELL_PR_MIND_CONTROL);
        if(TempSpell)
            TempSpell->MaxAffectedTargets = 1;      // not sure about it. better then whole party under mc effect
    }

    void Reset() {}

    void EnterCombat(Unit* who) {DoZoneInCombat();}

    void JustDied(Unit* )
    {
        if(pInstance)
            if(Unit *hex = me->GetUnit(pInstance->GetData64(DATA_HEXLORDEVENT)))
                DoScriptText(RAND(YELL_ADD_DEAD1, YELL_ADD_DEAD2, YELL_ADD_DEAD3), hex);
    }

    void UpdateAI(const uint32 diff)
    {
        if(pInstance && pInstance->GetData(DATA_HEXLORDEVENT) != IN_PROGRESS)
        {
            EnterEvadeMode();
            return;
        }

        DoMeleeAttackIfReady();
    }
};

struct boss_hex_lord_malacrassAI : public ScriptedAI
{
    boss_hex_lord_malacrassAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        SelectAddEntry();
        for(uint8 i = 0; i < 4; ++i)
            AddGUID[i] = 0;

        wLoc.coord_x = 119.223;
        wLoc.coord_y = 1035.45;
        wLoc.coord_z = 29.4481;
        wLoc.mapid = c->GetMapId();
    }

    ScriptedInstance *pInstance;

    WorldLocation wLoc;

    uint64 AddGUID[4];
    uint32 AddEntry[4];

    uint64 PlayerGUID;

    uint32 SpiritBolts_Timer;
    uint32 DrainPower_Timer;
    uint32 SiphonSoul_Timer;
    uint32 PlayerAbility_Timer[3];
    uint32 CheckAddState_Timer;
    uint32 ResetTimer;
    uint32 MC_Target_Timer;
    uint32 MC_Target_Timer_2nd;

    uint32 PlayerClass;

    Unit* SoulDrainTarget;
    Unit* MC_Target;
    Unit* MC_Target_2nd;
    bool Intro;
    bool MC_Casted;
    bool MC_Casted_2nd;
    float MC_Target_Threat;
    float MC_Target_Threat_2nd;

    void Reset()
    {
        if(pInstance && pInstance->GetData(DATA_HEXLORDEVENT)!= DONE)
            pInstance->SetData(DATA_HEXLORDEVENT, NOT_STARTED);

        SpiritBolts_Timer = 20000;
        DrainPower_Timer = 0;
        SiphonSoul_Timer = 100000;
        CheckAddState_Timer = 5000;
        ResetTimer = 5000;
        MC_Target_Timer = 20000;
        MC_Target_Timer_2nd = 20000;

        PlayerClass = 0;
        SpawnAdds();

        m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, 46916);
        m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO, 50268674);
        m_creature->SetByteValue(UNIT_FIELD_BYTES_2, 0, SHEATH_STATE_MELEE);
        Intro = false;
        MC_Casted = false;
        MC_Casted_2nd = false;
        MC_Target = NULL;
        MC_Target_2nd = NULL;
        MC_Target_Threat = 0;
        MC_Target_Threat_2nd = 0;
        for(uint8 i = 0; i < 3; i++)
            PlayerAbility_Timer[i] = 999999;
    }

    void MoveInLineOfSight(Unit *who)
    {
        if(!Intro && me->IsHostileTo(who) && who->IsWithinDist(me, 80, false))
        {
            Intro = true;
            // No intro, just placeholder
        }
        CreatureAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit* who)
    {
        if(pInstance)
            pInstance->SetData(DATA_HEXLORDEVENT, IN_PROGRESS);

        DoZoneInCombat();
        DoScriptText(YELL_AGGRO, m_creature);

        for(uint8 i = 0; i < 4; ++i)
        {
            Unit* Temp = Unit::GetUnit((*m_creature),AddGUID[i]);
            if(Temp && Temp->isAlive())
                ((Creature*)Temp)->AI()->AttackStart(m_creature->getVictim());
            else
            {
                EnterEvadeMode();
                break;
            }
        }
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(RAND(YELL_KILL_ONE,YELL_KILL_TWO), m_creature);
    }

    void JustDied(Unit* victim)
    {
        if(pInstance)
            pInstance->SetData(DATA_HEXLORDEVENT, DONE);

        DoScriptText(YELL_DEATH, m_creature);

        for(uint8 i = 0; i < 4 ; ++i)
        {
            Unit* Temp = Unit::GetUnit((*m_creature),AddGUID[i]);
            if(Temp && Temp->isAlive())
                Temp->DealDamage(Temp, Temp->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }
    }

    void SelectAddEntry()
    {
        std::vector<uint32> AddList;

        for(uint8 i = 0; i < 8; ++i)
            AddList.push_back(AddEntryList[i]);

        while(AddList.size() > 4)
            AddList.erase(AddList.begin()+rand()%AddList.size());

        uint8 i = 0;
        for(std::vector<uint32>::iterator itr = AddList.begin(); itr != AddList.end(); ++itr, ++i)
            AddEntry[i] = *itr;
    }

    void SpawnAdds()
    {
        for(uint8 i = 0; i < 4; ++i)
        {
            Creature *pCreature = (Unit::GetCreature((*m_creature), AddGUID[i]));
            if(!pCreature || !pCreature->isAlive())
            {
                if(pCreature) pCreature->setDeathState(DEAD);
                pCreature = m_creature->SummonCreature(AddEntry[i], Pos_X[i], POS_Y, POS_Z, ORIENT, TEMPSUMMON_DEAD_DESPAWN, 0);
                if(pCreature) AddGUID[i] = pCreature->GetGUID();
            }
            else
            {
                pCreature->AI()->EnterEvadeMode();
                pCreature->Relocate(Pos_X[i], POS_Y, POS_Z, ORIENT);
                pCreature->StopMoving();
            }
        }
    }

    void SummonedCreatureDespawn(Creature *c)
    {
        if(c->GetEntry() == 24320 && c->GetHealth() > 0)
            c->CastSpell(c, 43464, true);
    }

    void UpdateAI(const uint32 diff)
    {
        if (MC_Casted)
        {
            if (!MC_Target || MC_Target && !MC_Target->isAlive())
            {
                MC_Casted = false;
                MC_Target = NULL; // in case that target is not alive but present
                MC_Target_Threat = 0;
            }
            else
            {
                if (!MC_Target->HasAura(SPELL_PR_MIND_CONTROL))
                {
                    m_creature->AddThreat(MC_Target, MC_Target_Threat);
                    MC_Casted = false;
                    MC_Target = NULL;
                    MC_Target_Threat = 0;
                }
                else if (MC_Target_Timer < diff)
                {
                    MC_Casted = false;
                    MC_Target->RemoveAurasDueToSpell(SPELL_PR_MIND_CONTROL);
                    m_creature->AddThreat(MC_Target, MC_Target_Threat);
                    MC_Target = NULL;
                    MC_Target_Threat = 0;
                }
                else MC_Target_Timer -= diff;
            }
        }

        if (MC_Casted_2nd)
        {
            if (!MC_Target_2nd || MC_Target_2nd && !MC_Target_2nd->isAlive())
            {
                MC_Casted_2nd = false;
                MC_Target_2nd = NULL; // in case that target is not alive but present
                MC_Target_Threat_2nd = 0;
            }
            else
            {
                if (!MC_Target_2nd->HasAura(SPELL_PR_MIND_CONTROL))
                {
                    m_creature->AddThreat(MC_Target_2nd, MC_Target_Threat_2nd);
                    MC_Casted_2nd = false;
                    MC_Target_2nd = NULL;
                    MC_Target_Threat_2nd = 0;
                }
                else if (MC_Target_Timer_2nd < diff)
                {
                    MC_Casted_2nd = false;
                    MC_Target_2nd->RemoveAurasDueToSpell(SPELL_PR_MIND_CONTROL);
                    m_creature->AddThreat(MC_Target_2nd, MC_Target_Threat_2nd);
                    MC_Target_2nd = NULL;
                    MC_Target_Threat_2nd = 0;
                }
                else MC_Target_Timer_2nd -= diff;
            }
        }

        if (m_creature->getThreatManager().isThreatListEmpty())
        {
            if (MC_Target_Threat > MC_Target_Threat_2nd)
            {
                if (MC_Casted && MC_Target && MC_Target->isAlive())
                {
                    MC_Casted = false;
                    MC_Target->RemoveAurasDueToSpell(SPELL_PR_MIND_CONTROL);
                    m_creature->AddThreat(MC_Target, MC_Target_Threat);
                    MC_Target_Threat = 0;
                }
                else
                {
                    UpdateVictim();
                }
            }
            else
            {
                if (MC_Casted_2nd && MC_Target_2nd && MC_Target_2nd->isAlive())
                {
                    MC_Casted_2nd = false;
                    MC_Target_2nd->RemoveAurasDueToSpell(SPELL_PR_MIND_CONTROL);
                    m_creature->AddThreat(MC_Target_2nd, MC_Target_Threat_2nd);
                    MC_Target_Threat_2nd = 0;
                }
                else
                {
                    UpdateVictim();
                }
            }
        }

        if(!UpdateVictim())
            return;

        if(ResetTimer < diff)
        {
            if(m_creature->IsWithinDistInMap(&wLoc, 10))
            {
                EnterEvadeMode();
                return;
            }
            else
                DoZoneInCombat();

            ResetTimer = 5000;
        }else ResetTimer -= diff;

        if(CheckAddState_Timer < diff)
        {
            for(uint8 i = 0; i < 4; ++i)
            {
                Unit* Temp = Unit::GetUnit((*m_creature),AddGUID[i]);
                if(Temp && Temp->isAlive() && !Temp->getVictim())
                    ((Creature*)Temp)->AI()->AttackStart(m_creature->getVictim());
            }
            CheckAddState_Timer = 5000;
        }else CheckAddState_Timer -= diff;

        if(HealthBelowPct(80))
        {
            if(DrainPower_Timer < diff)
            {
                ForceSpellCastWithScriptText(m_creature, SPELL_DRAIN_POWER, YELL_DRAIN_POWER, INTERRUPT_AND_CAST_INSTANTLY);
                DrainPower_Timer = 40000 + rand()%10000;    // must cast in 60 sec, or buff/debuff will disappear
            }else
                DrainPower_Timer -= diff;
        }

        if(SpiritBolts_Timer < diff)
        {
            if(DrainPower_Timer && DrainPower_Timer < 12000)    // channel 10 sec
                SpiritBolts_Timer = 13000;  // cast drain power first
            else
            {
                ClearCastQueue();
                AddSpellToCastWithScriptText(m_creature, SPELL_SPIRIT_BOLTS, YELL_SPIRIT_BOLTS);
                SpiritBolts_Timer = 40000;
                SiphonSoul_Timer = 10000;  // ready to drain
                for(uint8 i = 0; i <3; i++)
                    PlayerAbility_Timer[i] = 99999;
            }
        }else SpiritBolts_Timer -= diff;

        if(SiphonSoul_Timer < diff)
        {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, GetSpellMaxRange(SPELL_SIPHON_SOUL), true);
            Unit *trigger = DoSpawnCreature(MOB_TEMP_TRIGGER, 0, 0, 0, 0, TEMPSUMMON_TIMED_DESPAWN, 30000);
            if(!target || !trigger)
            {
                EnterEvadeMode();
                return;
            }
            else
            {
                /*
                trigger->SetUInt32Value(UNIT_FIELD_DISPLAYID, 11686);
                trigger->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                trigger->CastSpell(target, SPELL_SIPHON_SOUL, true);
                trigger->GetMotionMaster()->MoveChase(m_creature);
*/
                DoCast(target, SPELL_SIPHON_SOUL, true);
                //m_creature->CastSpell(target, SPELL_SIPHON_SOUL, true);
                //m_creature->SetUInt64Value(UNIT_FIELD_CHANNEL_OBJECT, target->GetGUID());
                //m_creature->SetUInt32Value(UNIT_CHANNEL_SPELL, SPELL_SIPHON_SOUL);

                PlayerGUID = target->GetGUID();
                PlayerClass = target->getClass() - 1;
                if(PlayerClass == 10) PlayerClass = 9; // druid
                if(PlayerClass == 4 && target->HasSpell(15473)) PlayerClass = 5; // shadow priest

                for(uint8 i = 0; i < 3; i++)
                    PlayerAbility_Timer[i] = PlayerAbility[PlayerClass][i].startCooldown;
                SiphonSoul_Timer = 99999;   // buff lasts 30 sec
            }
            DoScriptText(YELL_SIPHON_SOUL, m_creature);
        }else
            SiphonSoul_Timer -= diff;

        for(uint8 i = 0; i < 3; i++)
        {
            if(PlayerAbility_Timer[i] < diff)
            {
                UseAbility(i);
                PlayerAbility_Timer[i] = PlayerAbility[PlayerClass][i].cooldown;
            }else
                PlayerAbility_Timer[i] -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }

    void UseAbility(uint8 i)
    {
        Unit *target = NULL;
        switch(PlayerAbility[PlayerClass][i].target)
        {
        case ABILITY_TARGET_SELF:
            target = m_creature;
            break;
        case ABILITY_TARGET_VICTIM:
            target = m_creature->getVictim();
            break;
        case ABILITY_TARGET_HEAL:
            target = SelectLowestHpFriendly(50, 0);
            break;
        case ABILITY_TARGET_BUFF:
            {
                std::list<Creature*> templist = FindFriendlyMissingBuff(50, PlayerAbility[PlayerClass][i].spell);
                if(!templist.empty()) target = *(templist.begin());
            }
            break;
        case ABILITY_TARGET_ENEMY:
        default:
            target = SelectUnit(SELECT_TARGET_RANDOM, 0);
            break;
        }
        if(target)
        {
            if (PlayerAbility[PlayerClass][i].spell == SPELL_PR_MIND_CONTROL)
            {
                if (!MC_Casted)
                {
                    MC_Target = target;
                    MC_Casted = true;
                    MC_Target_Timer = 20000;
                    MC_Target_Threat = m_creature->getThreatManager().getThreat(target);
                }
                else
                {
                    MC_Target_2nd = target;
                    MC_Casted_2nd = true;
                    MC_Target_Timer_2nd = 20000;
                    MC_Target_Threat_2nd = m_creature->getThreatManager().getThreat(target);
                }
            }
            AddSpellToCast(target, PlayerAbility[PlayerClass][i].spell, false);
        }
    }
};

#define SPELL_BLOODLUST       43578
#define SPELL_CLEAVE          15496

struct boss_thurgAI : public boss_hexlord_addAI
{

    boss_thurgAI(Creature *c) : boss_hexlord_addAI(c) {}

    uint32 bloodlust_timer;
    uint32 cleave_timer;

    void Reset()
    {
        bloodlust_timer = 15000;
        cleave_timer = 10000;

        boss_hexlord_addAI::Reset();
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim() )
            return;

        if(bloodlust_timer < diff)
        {
            std::list<Creature*> templist = FindFriendlyMissingBuff(50, SPELL_BLOODLUST);
            if(!templist.empty())
            {
                if(Unit* target = *(templist.begin()))
                    m_creature->CastSpell(target, SPELL_BLOODLUST, false);
            }
            bloodlust_timer = 12000;
        }else bloodlust_timer -= diff;

        if(cleave_timer < diff)
        {
            m_creature->CastSpell(m_creature->getVictim(),SPELL_CLEAVE, false);
            cleave_timer = 12000; //3 sec cast
        }else cleave_timer -= diff;

        boss_hexlord_addAI::UpdateAI(diff);
    }
};

#define SPELL_FLASH_HEAL     43575
#define SPELL_DISPEL_MAGIC   43577

struct boss_alyson_antilleAI : public boss_hexlord_addAI
{
    //Holy Priest
    boss_alyson_antilleAI(Creature *c) : boss_hexlord_addAI(c) {}

    uint32 flashheal_timer;
    uint32 dispelmagic_timer;

    void Reset()
    {
        flashheal_timer = 2500;
        dispelmagic_timer = 10000;

        //AcquireGUID();

        boss_hexlord_addAI::Reset();
    }
/*  Ponizszy kod powoduj ze Alyson ucieka pod tekstury, bardzo niefajne
    void AttackStart(Unit* who)
    {
        if (!who)
            return;

        if (who->isTargetableForAttack())
        {
            if(m_creature->Attack(who, false))
            {
                m_creature->GetMotionMaster()->MoveChase(who, 20);
                m_creature->AddThreat(who, 0.0f);
            }

            if (!m_creature->isInCombat())
                EnterCombat(who);
        }
    }
*/
    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim() )
            return;

        if(flashheal_timer < diff)
        {
            Unit* target = SelectLowestHpFriendly(99, 30000);
            if(target)
            {
                if(target->IsWithinDistInMap(m_creature, 50))
                    m_creature->CastSpell(target,SPELL_FLASH_HEAL, false);
                else
                {
                    // bugged
                    //m_creature->GetMotionMaster()->Clear();
                    //m_creature->GetMotionMaster()->MoveChase(target, 20);
                }
            }
            else
            {
                if(rand()%2)
                {
                    if(Unit* target = SelectLowestHpFriendly(50, 0))
                        m_creature->CastSpell(target, SPELL_DISPEL_MAGIC, false);
                }
                else if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, GetSpellMaxRange(SPELL_DISPEL_MAGIC), true))
                    m_creature->CastSpell(target, SPELL_DISPEL_MAGIC, false);
            }
            flashheal_timer = 2500;
        }else flashheal_timer -= diff;

        boss_hexlord_addAI::UpdateAI(diff);
    }
};

#define SPELL_FIREBOLT        43584

struct boss_gazakrothAI : public boss_hexlord_addAI
{
    boss_gazakrothAI(Creature *c) : boss_hexlord_addAI(c)  {}

    uint32 firebolt_timer;

    void Reset()
    {
        firebolt_timer = 2000;
        boss_hexlord_addAI::Reset();
    }
/*  Ponizszy kod spowoduje ze imp bedzie wchodzil pod tekstury :(
    void AttackStart(Unit* who)
    {
        if (!who)
            return;

        if (who->isTargetableForAttack())
        {
            if(m_creature->Attack(who, false))
            {
                m_creature->GetMotionMaster()->MoveChase(who, 20);
                m_creature->AddThreat(who, 0.0f);
            }
        }
    }
*/
    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim() )
            return;

        if(firebolt_timer < diff)
        {
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0))
            {
                m_creature->CastSpell(target,SPELL_FIREBOLT, false);
                firebolt_timer = 700;
            }
        }else firebolt_timer -= diff;

        boss_hexlord_addAI::UpdateAI(diff);
    }
};

#define SPELL_FLAME_BREATH    43582
#define SPELL_THUNDERCLAP     43583

struct boss_lord_raadanAI : public boss_hexlord_addAI
{
    boss_lord_raadanAI(Creature *c) : boss_hexlord_addAI(c)  {}

    uint32 flamebreath_timer;
    uint32 thunderclap_timer;

    void Reset()
    {
        flamebreath_timer = 8000;
        thunderclap_timer = 13000;

        boss_hexlord_addAI::Reset();

    }
    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim() )
            return;

        if (thunderclap_timer < diff)
        {
            m_creature->CastSpell(m_creature->getVictim(),SPELL_THUNDERCLAP, false);
            thunderclap_timer = 12000;
        }else thunderclap_timer -= diff;

        if (flamebreath_timer < diff)
        {
            m_creature->CastSpell(m_creature->getVictim(),SPELL_FLAME_BREATH, false);
            flamebreath_timer = 12000;
        }else flamebreath_timer -= diff;

        boss_hexlord_addAI::UpdateAI(diff);
    }
};

#define SPELL_PSYCHIC_WAIL   43590

struct boss_darkheartAI : public boss_hexlord_addAI
{
    boss_darkheartAI(Creature *c) : boss_hexlord_addAI(c)  {}

    uint32 psychicwail_timer;

    void Reset()
    {
        psychicwail_timer = 8000;

        boss_hexlord_addAI::Reset();

    }
    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim() )
            return;

        if (psychicwail_timer < diff)
        {
            m_creature->CastSpell(m_creature->getVictim(),SPELL_PSYCHIC_WAIL, false);
            psychicwail_timer = 12000;
        }else psychicwail_timer -= diff;

        boss_hexlord_addAI::UpdateAI(diff);
    }
};

#define SPELL_VENOM_SPIT    43579

struct boss_slitherAI : public boss_hexlord_addAI
{
    boss_slitherAI(Creature *c) : boss_hexlord_addAI(c) {}

    uint32 venomspit_timer;


    void Reset()
    {
        venomspit_timer = 5000;
        boss_hexlord_addAI::Reset();
    }
/*
    void AttackStart(Unit* who)
    {
        if (!who)
            return;

        if (who->isTargetableForAttack())
        {
            if(m_creature->Attack(who, false))
            {
                m_creature->GetMotionMaster()->MoveChase(who, 20);
                m_creature->AddThreat(who, 0.0f);
            }
        }
    }
*/
    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim() )
            return;

        if (venomspit_timer < diff)
        {
            if(Unit* victim = SelectUnit(SELECT_TARGET_RANDOM, 0, GetSpellMaxRange(SPELL_VENOM_SPIT), true))
                m_creature->CastSpell(victim,SPELL_VENOM_SPIT, false);
            venomspit_timer = 2500;
        }else venomspit_timer -= diff;

        boss_hexlord_addAI::UpdateAI(diff);
    }
};

//Fenstalker
#define SPELL_VOLATILE_INFECTION 43586

struct boss_fenstalkerAI : public boss_hexlord_addAI
{
    boss_fenstalkerAI(Creature *c) : boss_hexlord_addAI(c) {}

    uint32 volatileinf_timer;


    void Reset()
    {
        volatileinf_timer = 15000;
        boss_hexlord_addAI::Reset();

    }
    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim() )
            return;

        if (volatileinf_timer < diff)
        {
            // core bug
            m_creature->getVictim()->CastSpell(m_creature->getVictim(),SPELL_VOLATILE_INFECTION, false);
            volatileinf_timer = 12000;
        }else volatileinf_timer -= diff;

        boss_hexlord_addAI::UpdateAI(diff);
    }
};

//Koragg
#define SPELL_COLD_STARE      43593
#define SPELL_MIGHTY_BLOW     43592


struct boss_koraggAI : public boss_hexlord_addAI
{
    boss_koraggAI(Creature *c) : boss_hexlord_addAI(c) {}

    uint32 coldstare_timer;
    uint32 mightyblow_timer;


    void Reset()
    {
        coldstare_timer = 15000;
        mightyblow_timer = 10000;
        boss_hexlord_addAI::Reset();

    }
    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim() )
            return;

        if (mightyblow_timer < diff)
        {
            m_creature->CastSpell(m_creature->getVictim(),SPELL_MIGHTY_BLOW, false);
            mightyblow_timer = 12000;
        }
        if (coldstare_timer < diff)
        {
            if(Unit* victim = SelectUnit(SELECT_TARGET_RANDOM, 0, GetSpellMaxRange(SPELL_COLD_STARE), true))
                m_creature->CastSpell(victim,SPELL_COLD_STARE, false);
            coldstare_timer = 12000;
        }

        boss_hexlord_addAI::UpdateAI(diff);
    }
};

CreatureAI* GetAI_boss_hex_lord_malacrass(Creature *_Creature)
{
    return new boss_hex_lord_malacrassAI (_Creature);
}

CreatureAI* GetAI_boss_thurg(Creature *_Creature)
{
    return new boss_thurgAI (_Creature);
}

CreatureAI* GetAI_boss_alyson_antille(Creature *_Creature)
{
    return new boss_alyson_antilleAI (_Creature);
}

CreatureAI* GetAI_boss_gazakroth(Creature *_Creature)
{
    return new boss_gazakrothAI (_Creature);
}

CreatureAI* GetAI_boss_lord_raadan(Creature *_Creature)
{
    return new boss_lord_raadanAI (_Creature);
}

CreatureAI* GetAI_boss_darkheart(Creature *_Creature)
{
    return new boss_darkheartAI (_Creature);
}

CreatureAI* GetAI_boss_slither(Creature *_Creature)
{
    return new boss_slitherAI (_Creature);
}

CreatureAI* GetAI_boss_fenstalker(Creature *_Creature)
{
    return new boss_fenstalkerAI (_Creature);
}

CreatureAI* GetAI_boss_koragg(Creature *_Creature)
{
    return new boss_koraggAI (_Creature);
}
void AddSC_boss_hex_lord_malacrass()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_hexlord_malacrass";
    newscript->GetAI = &GetAI_boss_hex_lord_malacrass;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_thurg";
    newscript->GetAI = &GetAI_boss_thurg;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_gazakroth";
    newscript->GetAI = &GetAI_boss_gazakroth;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_lord_raadan";
    newscript->GetAI = &GetAI_boss_lord_raadan;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_darkheart";
    newscript->GetAI = &GetAI_boss_darkheart;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_slither";
    newscript->GetAI = &GetAI_boss_slither;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_fenstalker";
    newscript->GetAI = &GetAI_boss_fenstalker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_koragg";
    newscript->GetAI = &GetAI_boss_koragg;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_alyson_antille";
    newscript->GetAI = &GetAI_boss_alyson_antille;
    newscript->RegisterSelf();
}
