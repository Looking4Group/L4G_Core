/* Copyright (C) 2006,2007,2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Boss_ZulJin
SD%Complete: 85%
SDComment:
EndScriptData */

#include "precompiled.h"
#include "def_zulaman.h"

//Speech
#define YELL_TRANSFORM_TO_LYNX              -1800499
#define YELL_TRANSFORM_TO_BEAR              -1800500
#define YELL_TRANSFORM_TO_DRAGONHAWK        -1800501
#define YELL_TRANSFORM_TO_EAGLE             -1800502
#define YELL_KILL_ONE                       -1800503
#define YELL_KILL_TWO                       -1800504
#define YELL_FIRE_BREATH                    -1800505
#define YELL_AGGRO                          -1800506
#define YELL_BERSERK                        -1800507
#define YELL_DEATH                          -1800508
#define YELL_INTRO                          -1800509


//Spells:
// ====== Troll Form
#define SPELL_WHIRLWIND             17207
#define SPELL_GRIEVOUS_THROW        43093   // remove debuff after full healed
// ====== Bear Form
#define SPELL_CREEPING_PARALYSIS    43095   // should cast on the whole raid
#define SPELL_OVERPOWER             43456   // use after melee attack dodged
// ====== Eagle Form
#define SPELL_ENERGY_STORM          43983   // enemy area aura, trigger 42577
#define SPELL_ZAP_INFORM            42577
#define SPELL_ZAP_DAMAGE            43137   // 1250 damage
#define SPELL_SUMMON_CYCLONE        43112   // summon four feather vortex
#define CREATURE_FEATHER_VORTEX     24136
#define SPELL_CYCLONE_VISUAL        43119   // trigger 43147 visual
#define SPELL_CYCLONE_PASSIVE       43120   // trigger 43121 (4y aoe) every second
//Lynx Form
#define SPELL_CLAW_RAGE_HASTE       42583
#define SPELL_CLAW_RAGE_TRIGGER     43149
#define SPELL_CLAW_RAGE_DAMAGE      43150
#define SPELL_LYNX_RUSH_HASTE       43152
#define SPELL_LYNX_RUSH_DAMAGE      43153
//Dragonhawk Form
#define SPELL_FLAME_WHIRL           43213   // trigger two spells
#define SPELL_FLAME_BREATH          43215
#define SPELL_SUMMON_PILLAR         43216   // summon 24187
#define CREATURE_COLUMN_OF_FIRE     24187
#define SPELL_PILLAR_TRIGGER        43218   // trigger 43217

//cosmetic
#define SPELL_SPIRIT_AURA           42466
#define SPELL_SIPHON_SOUL           43501

//Transforms:
#define SPELL_SHAPE_OF_THE_BEAR     42594   // 15% dmg
#define SPELL_SHAPE_OF_THE_EAGLE    42606
#define SPELL_SHAPE_OF_THE_LYNX     42607   // haste melee 30%
#define SPELL_SHAPE_OF_THE_DRAGONHAWK   42608

#define SPELL_BERSERK 45078


#define PHASE_BEAR 0
#define PHASE_EAGLE 1
#define PHASE_LYNX 2
#define PHASE_DRAGONHAWK 3
#define PHASE_TROLL 4

//coords for going for changing form
#define CENTER_X 120.148811
#define CENTER_Y 703.713684
#define CENTER_Z 45.111477

struct SpiritInfoStruct
{
    uint32 entry;
    float x, y, z, orient;
};

static SpiritInfoStruct SpiritInfo[] =
{
    {23878, 147.87, 706.51, 45.11, 3.04},
    {23880, 88.95, 705.49, 45.11, 6.11},
    {23877, 137.23, 725.98, 45.11, 3.71},
    {23879, 104.29, 726.43, 45.11, 5.43}
};

struct TransformStruct
{
    int32 text;
    uint32 spell, unaura;
};

static TransformStruct Transform[] =
{
    {YELL_TRANSFORM_TO_BEAR, SPELL_SHAPE_OF_THE_BEAR, SPELL_WHIRLWIND},
    {YELL_TRANSFORM_TO_EAGLE, SPELL_SHAPE_OF_THE_EAGLE, SPELL_SHAPE_OF_THE_BEAR},
    {YELL_TRANSFORM_TO_LYNX, SPELL_SHAPE_OF_THE_LYNX, SPELL_SHAPE_OF_THE_EAGLE},
    {YELL_TRANSFORM_TO_DRAGONHAWK, SPELL_SHAPE_OF_THE_DRAGONHAWK, SPELL_SHAPE_OF_THE_LYNX}
};

struct boss_zuljinAI : public ScriptedAI
{
    boss_zuljinAI(Creature *c) : ScriptedAI(c), Summons(m_creature)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);
    }
    ScriptedInstance *pInstance;

    uint64 SpiritGUID[4];
    uint64 ClawTargetGUID;
    uint64 TankGUID;

    uint32 Phase;
    uint32 health_20;

    uint32 Intro_Timer;
    uint32 Berserk_Timer;

    uint32 Whirlwind_Timer;
    uint32 Grievous_Throw_Timer;

    uint32 Creeping_Paralysis_Timer;
    uint32 Overpower_Timer;

    uint32 Claw_Rage_Timer;
    uint32 Lynx_Rush_Timer;
    uint32 Claw_Counter;
    uint32 Claw_Loop_Timer;

    uint32 Flame_Whirl_Timer;
    uint32 Flame_Breath_Timer;
    uint32 Pillar_Of_Fire_Timer;

    uint32 checkTimer;
    WorldLocation wLoc;

    SummonList Summons;
    bool Intro;

    void Reset()
    {
        if(pInstance && pInstance->GetData(DATA_ZULJINEVENT) != DONE)
            pInstance->SetData(DATA_ZULJINEVENT, NOT_STARTED);

        Phase = 0;

        health_20 = m_creature->GetMaxHealth()*0.2;

        Intro_Timer = 37000;
        Berserk_Timer = 600000;

        Whirlwind_Timer = 7000;
        Grievous_Throw_Timer = 8000;

        Creeping_Paralysis_Timer = 7000;
        Overpower_Timer = 0;

        Claw_Rage_Timer = 5000;
        Lynx_Rush_Timer = 14000;
        Claw_Loop_Timer = 0;
        Claw_Counter = 0;

        Flame_Whirl_Timer = 5000;
        Flame_Breath_Timer = 6000;
        Pillar_Of_Fire_Timer = 7000;

        ClawTargetGUID = 0;
        TankGUID = 0;

        checkTimer = 3000;

        Summons.DespawnAll();

        m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, 47174);
        m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO, 218172674);
        m_creature->SetByteValue(UNIT_FIELD_BYTES_2, 0, SHEATH_STATE_MELEE);
        Intro = false;
    }

    void MoveInLineOfSight(Unit *who)
    {
        if(!Intro && me->IsHostileTo(who) && who->IsWithinDist(me, 80, false))
        {
            Intro = true;
            DoScriptText(YELL_INTRO, m_creature);
        }
        CreatureAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance)
            pInstance->SetData(DATA_ZULJINEVENT, IN_PROGRESS);

        DoZoneInCombat();

        DoScriptText(YELL_AGGRO, m_creature);
        SpawnAdds();
        EnterPhase(0);
    }

    void KilledUnit(Unit* victim)
    {
        if(Intro_Timer)
            return;
        DoScriptText(RAND(YELL_KILL_ONE, YELL_KILL_TWO), m_creature);
    }

    void JustDied(Unit* Killer)
    {
        if(pInstance)
            pInstance->SetData(DATA_ZULJINEVENT, DONE);

        DoScriptText(YELL_DEATH, m_creature);
        Summons.DespawnEntry(CREATURE_COLUMN_OF_FIRE);

        if(Unit *Temp = Unit::GetUnit(*m_creature, SpiritGUID[3]))
            Temp->SetUInt32Value(UNIT_FIELD_BYTES_1,PLAYER_STATE_DEAD);
    }

    void AttackStart(Unit *who)
    {
        if(Phase == 2)
            AttackStartNoMove(who);
        else
            ScriptedAI::AttackStart(who);
    }

    void DoMeleeAttackIfReady()
    {
        if( !m_creature->IsNonMeleeSpellCasted(false))
        {
            if(m_creature->isAttackReady() && m_creature->IsWithinMeleeRange(m_creature->getVictim()))
            {
                if(Phase == 1 && !Overpower_Timer)
                {
                    uint32 health = m_creature->getVictim()->GetHealth();
                    m_creature->AttackerStateUpdate(m_creature->getVictim());
                    if(m_creature->getVictim() && health == m_creature->getVictim()->GetHealth())
                    {
                        DoCast(m_creature->getVictim(), SPELL_OVERPOWER, false);
                        Overpower_Timer = 5000;
                    }
                }else m_creature->AttackerStateUpdate(m_creature->getVictim());
                m_creature->resetAttackTimer();
            }
        }
    }

    void SpawnAdds()
    {
        Creature *pCreature = NULL;
        for(uint8 i = 0; i < 4; i++)
        {
            pCreature = m_creature->SummonCreature(SpiritInfo[i].entry, SpiritInfo[i].x, SpiritInfo[i].y, SpiritInfo[i].z, SpiritInfo[i].orient, TEMPSUMMON_DEAD_DESPAWN, 0);
            if(pCreature)
            {
                pCreature->CastSpell(pCreature, SPELL_SPIRIT_AURA, true);
                pCreature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                pCreature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                SpiritGUID[i] = pCreature->GetGUID();
            }
        }
    }

    void DespawnAdds()
    {
        for(uint8 i = 0; i < 4; i++)
        {
            Unit* Temp = NULL;
            if(SpiritGUID[i])
            {
                if(Temp = Unit::GetUnit(*m_creature, SpiritGUID[i]))
                {
                    Temp->SetVisibility(VISIBILITY_OFF);
                    Temp->setDeathState(DEAD);
                }
            }
            SpiritGUID[i] = 0;
        }
    }

    void JustSummoned(Creature *summon)
    {
        Summons.Summon(summon);
    }

    void SummonedCreatureDespawn(Creature *summon)
    {
        Summons.Despawn(summon);
    }

    void EnterPhase(uint32 NextPhase)
    {
        switch(NextPhase)
        {
        case 0:
            break;
        case 1:
        case 2:
        case 3:
        case 4:
            DoTeleportTo(CENTER_X, CENTER_Y, CENTER_Z, 100);
            DoResetThreat();
            m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, 0);
            m_creature->RemoveAurasDueToSpell(Transform[Phase].unaura);
            DoCast(m_creature, Transform[Phase].spell);
            DoScriptText(Transform[Phase].text, m_creature);
            if(Phase > 0)
            {
                if(Unit *Temp = Unit::GetUnit(*m_creature, SpiritGUID[Phase - 1]))
                    Temp->SetUInt32Value(UNIT_FIELD_BYTES_1,PLAYER_STATE_DEAD);
            }
            if(Unit *Temp = Unit::GetUnit(*m_creature, SpiritGUID[NextPhase - 1]))
                Temp->CastSpell(m_creature, SPELL_SIPHON_SOUL, false); // should m cast on temp
            if(NextPhase == 2)
            {
                m_creature->GetMotionMaster()->Clear();
                m_creature->CastSpell(m_creature, SPELL_ENERGY_STORM, true); // enemy aura
                m_creature->CastSpell(m_creature, SPELL_SUMMON_CYCLONE, true);
            }
            else
                m_creature->AI()->AttackStart(m_creature->getVictim());
            if(NextPhase == 3)
            {
                m_creature->RemoveAurasDueToSpell(SPELL_ENERGY_STORM);
                Summons.DespawnEntry(CREATURE_FEATHER_VORTEX);
                m_creature->GetMotionMaster()->MoveChase(m_creature->getVictim());
            }
            break;
        default:
            break;
        }
        Phase = NextPhase;
    }

    void UpdateAI(const uint32 diff)
    {
        if(!TankGUID)
        {
            if(!UpdateVictim())
                return;

            if(m_creature->GetHealth() < health_20 * (4 - Phase))
                EnterPhase(Phase + 1);
        }

        if (checkTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 100))
                EnterEvadeMode();
            else
                DoZoneInCombat();
            checkTimer = 3000;
        }
        else
            checkTimer -= diff;

        if(Berserk_Timer < diff)
        {
            m_creature->CastSpell(m_creature, SPELL_BERSERK, true);
            DoScriptText(YELL_BERSERK, m_creature);
            Berserk_Timer = 60000;
        }else Berserk_Timer -= diff;

        switch (Phase)
        {
        case 0:
            if(Whirlwind_Timer < diff)
            {
                DoCast(m_creature, SPELL_WHIRLWIND);
                Whirlwind_Timer = 15000 + rand()%5000;
            }else Whirlwind_Timer -= diff;

            if(Grievous_Throw_Timer < diff)
            {
                if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, GetSpellMaxRange(SPELL_GRIEVOUS_THROW), true))
                    m_creature->CastSpell(target, SPELL_GRIEVOUS_THROW, false);
                Grievous_Throw_Timer = 10000;
            }else Grievous_Throw_Timer -= diff;
            break;

        case 1:
            if(Creeping_Paralysis_Timer < diff)
            {
                DoCast(m_creature, SPELL_CREEPING_PARALYSIS);
                Creeping_Paralysis_Timer = 20000;
            }else Creeping_Paralysis_Timer -= diff;

            if(Overpower_Timer < diff)
            {
                // implemented in DoMeleeAttackIfReady()
                Overpower_Timer = 0;
            }else Overpower_Timer -= diff;
            break;

        case 2:
            return;

        case 3:
            if(Claw_Rage_Timer <= diff)
            {
                if(!TankGUID)
                {
                    if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    {
                        TankGUID = m_creature->getVictimGUID();
                        m_creature->SetSpeed(MOVE_RUN, 5.0f);
                        AttackStart(target); // change victim
                        Claw_Rage_Timer = 0;
                        Claw_Loop_Timer = 500;
                        Claw_Counter = 0;
                    }
                }
                else if(!Claw_Rage_Timer) // do not do this when Lynx_Rush
                {
                    if(Claw_Loop_Timer < diff)
                    {
                        Unit* target = m_creature->getVictim();
                        if(!target || !target->isTargetableForAttack())
                            target = Unit::GetUnit(*m_creature, TankGUID);

                        if(!target || !target->isTargetableForAttack())
                            target = SelectUnit(SELECT_TARGET_RANDOM, 0);

                        if(target)
                        {
                            AttackStart(target);
                            m_creature->SetSpeed(MOVE_RUN, 5.0f);
                            if(m_creature->IsWithinMeleeRange(target))
                            {
                                m_creature->CastSpell(target, SPELL_CLAW_RAGE_DAMAGE, true);
                                Claw_Counter++;
                                if(Claw_Counter == 12)
                                {
                                    Claw_Rage_Timer = 15000 + rand()%5000;
                                    m_creature->SetSpeed(MOVE_RUN, 1.2f);
                                    AttackStart(Unit::GetUnit(*m_creature, TankGUID));
                                    TankGUID = 0;
                                    return;
                                }
                                else
                                    Claw_Loop_Timer = 500;
                            }
                        }
                        else
                        {
                            EnterEvadeMode(); // if(target)
                            return;
                        }
                    }else Claw_Loop_Timer -= diff;
                } //if(TankGUID)
            }else Claw_Rage_Timer -= diff;

            if(Lynx_Rush_Timer <= diff)
            {
                if(!TankGUID)
                {
                    if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    {
                        TankGUID = m_creature->getVictimGUID();
                        m_creature->SetSpeed(MOVE_RUN, 5.0f);
                        AttackStart(target); // change victim
                        Lynx_Rush_Timer = 0;
                        Claw_Counter = 0;
                    }
                }
                else if(!Lynx_Rush_Timer)
                {
                    Unit* target = m_creature->getVictim();
                    if(!target || !target->isTargetableForAttack())
                    {
                        if(target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                            AttackStart(target);
                    }

                    if(target)
                    {
                        m_creature->SetSpeed(MOVE_RUN, 5.0f);
                        if(m_creature->IsWithinMeleeRange(target))
                        {
                            m_creature->CastSpell(target, SPELL_LYNX_RUSH_DAMAGE, true);
                            Claw_Counter++;
                            if(Claw_Counter == 9)
                            {
                                Lynx_Rush_Timer = 15000 + rand()%5000;
                                m_creature->SetSpeed(MOVE_RUN, 1.2f);
                                AttackStart(Unit::GetUnit(*m_creature, TankGUID));
                                TankGUID = 0;
                            }
                            else
                            {
                                if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                                    AttackStart(target);
                            }
                        }
                    }
                    else
                    {
                        EnterEvadeMode(); // if(target)
                        return;
                    }
                } //if(TankGUID)
            }else Lynx_Rush_Timer -= diff;

            break;
        case 4:
            if(Flame_Whirl_Timer < diff)
            {
                DoCast(m_creature, SPELL_FLAME_WHIRL);
                Flame_Whirl_Timer = 12000;
            }Flame_Whirl_Timer -= diff;

            if(Pillar_Of_Fire_Timer < diff)
            {
                if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, GetSpellMaxRange(SPELL_SUMMON_PILLAR), true))
                    DoCast(target, SPELL_SUMMON_PILLAR);
                Pillar_Of_Fire_Timer = 10000;
            }else Pillar_Of_Fire_Timer -= diff;

            if(Flame_Breath_Timer < diff)
            {
                if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    m_creature->SetInFront(target);
                DoCast(m_creature, SPELL_FLAME_BREATH);
                DoScriptText(YELL_FIRE_BREATH, m_creature);
                Flame_Breath_Timer = 10000;
            }else Flame_Breath_Timer -= diff;
            break;

        default:
            break;
        }

        if(!TankGUID)
            DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_zuljin(Creature *_Creature)
{
    return new boss_zuljinAI (_Creature);
}

struct feather_vortexAI : public ScriptedAI
{
    feather_vortexAI(Creature *c) : ScriptedAI(c) {}

    void Reset() 
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        me->SetSpeed(MOVE_RUN, 1.0f);
    }

    void EnterCombat(Unit* ) {
        me->CastSpell(me, SPELL_CYCLONE_PASSIVE, false);
        me->CastSpell(me, SPELL_CYCLONE_VISUAL, false);

        if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0))
            AttackStart(target);
    }

    void DamageTaken(Unit* done_by, uint32 &damage)
    {
        damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        //if the vortex reach the target, it change his target to another player
        if(!m_creature->getVictim() || m_creature->IsWithinMeleeRange(m_creature->getVictim()) || !m_creature->getVictim()->isAlive())
        {
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0))
                AttackStart(target);
        }
    }
};

CreatureAI* GetAI_feather_vortexAI(Creature *_Creature)
{
    return new feather_vortexAI (_Creature);
}

void AddSC_boss_zuljin()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_zuljin";
    newscript->GetAI = &GetAI_boss_zuljin;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_zuljin_vortex";
    newscript->GetAI = &GetAI_feather_vortexAI;
    newscript->RegisterSelf();
}
