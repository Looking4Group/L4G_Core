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
SDName: Boss_Felblood_Kaelthas
SD%Complete: 95
SDComment: Final debugging, force him to make death animations
SDCategory: Magisters' Terrace
EndScriptData */

#include "precompiled.h"
#include "def_magisters_terrace.h"
#include "WorldPacket.h"

#define SAY_AGGRO                   -1585023
#define SAY_PHOENIX                 -1585024
#define SAY_FLAMESTRIKE             -1585025
#define SAY_GRAVITY_LAPSE           -1585026
#define SAY_TIRED                   -1585027
#define SAY_RECAST_GRAVITY          -1585028
#define SAY_DEATH                   -1585029
#define EMOTE_HEROIC_PYROBLAST      -1585030

/*** Spells ***/

// Phase 1 spells

#define SPELL_FIREBALL                (HeroicMode?46164:44189)

#define SPELL_PHOENIX                 44194
#define SPELL_REBIRTH_PHOENIX         44196
#define SPELL_REBIRTH_EGG             44200
#define SPELL_PHOENIX_BURN            44197 //triggers 44198 each 2 sec
#define SPELL_PHOENIX_FIREBALL        (HeroicMode?44237:44202)
#define SPELL_EMBER_BLAST             44199

#define SPELL_TELEPORT_PLAYER         20477 // should also prevent phoenix kiting ?

#define SPELL_SUMMON_FLAMESTRIKE      44192
#define SPELL_FLAMESTRIKE_VISUAL      44191
#define SPELL_FLAMESTRIKE            (HeroicMode?46163:44190)

#define SPELL_SHOCK_BARRIER           46165
#define SPELL_PYROBLAST               36819

// Phase 2 spells

#define SPELL_TELEPORT_CENTER         44218 // Teleports boss to the center. 44219-44223 teleports player around Kael, managed by Script Effect
#define SPELL_GRAVITY_LAPSE           44224 // Cast at the beginning of every Gravity Lapse
#define SPELL_GRAVITY_LAPSE_DOT       (HeroicMode?44226:49887)  // managed by Script Effect
#define SPELL_GRAVITY_LAPSE_FLY       44227

#define SPELL_SUMMON_ARCANE_SPHERE    44265
#define SPELL_ARCANE_SPHERE_PASSIVE   44263 // Passive auras on Arcane Spheres

#define SPELL_POWER_FEEDBACK          (HeroicMode?47109:44233)

// Miscalenous
#define SPELL_ESCAPE_TO_IOQD          46841

/*** Creatures ***/
#define CREATURE_PHOENIX              24674
#define CREATURE_PHOENIX_EGG          24675
#define CREATURE_ARCANE_SPHERE        24708

struct boss_felblood_kaelthasAI : public ScriptedAI
{
    boss_felblood_kaelthasAI(Creature* c) : ScriptedAI(c), summons(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    SummonList summons;
    uint32 FireballTimer;
    uint32 PhoenixTimer;
    uint32 FlameStrikeTimer;
    uint32 TrashCheckTimer;
    uint32 CheckTimer;
    uint32 IntroTimer;
    uint32 OutroTimer;
    bool Intro;
    bool Outro;

    //Heroic only
    uint32 PyroblastTimer;

    uint32 GravityLapseTimer;
    uint32 GravityLapsePhase;

    uint8 Phase;
    // 1 = Fireball; Summon Phoenix; Flamestrike
    // 2 = Gravity Lapses

    void Reset()
    {
        FireballTimer = 0;
        PhoenixTimer = urand(15000,20000);
        FlameStrikeTimer = urand(25000, 35000);
        TrashCheckTimer = 2000;
        CheckTimer = 2000;
        IntroTimer = 36000;
        OutroTimer = 11000;
        Intro = false;
        Outro = false;
        summons.DespawnAll();

        PyroblastTimer = 60000;

        GravityLapseTimer = 0;
        GravityLapsePhase = 0;

        Phase = 0;
        me->HandleEmoteCommand(EMOTE_STATE_NONE);
        me->setFaction(16); // probably should be using another faction here

        if(pInstance)
        {
            pInstance->SetData(DATA_KAELTHAS_EVENT, NOT_STARTED);
            pInstance->SetData(DATA_KAEL_PHASE, Phase);
            if(pInstance->GetData(DATA_KAEL_TRASH_EVENT) != DONE)
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }
        ResetStatues(true);
    }

    void DamageTaken(Unit* done_by, uint32 &damage)
    {
        if(damage > m_creature->GetHealth() && done_by->GetGUID() != me->GetGUID())
        {
            damage = 0;
            me->InterruptNonMeleeSpells(true);
            DoScriptText(SAY_DEATH, m_creature);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            RemoveGravityLapse();
            me->DeleteThreatList();
            me->RemoveAllAuras();
            me->CombatStop(true);
            me->setFaction(35);
            me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
            if(pInstance)
                pInstance->SetData(DATA_KAELTHAS_EVENT, DONE);
            me->SetLootRecipient(done_by);
            if(!Outro)
                Outro = true;
        }
    }

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();
        Phase = 1;
        me->GetMotionMaster()->MoveIdle();
        if(pInstance)
        {
            pInstance->SetData(DATA_KAELTHAS_EVENT, IN_PROGRESS);
            pInstance->SetData(DATA_KAEL_PHASE, Phase);
        }
    }

    void AttackStart(Unit* who)
    {
        if(Phase == 2)
            DoStartNoMovement(who);
        else
            ScriptedAI::AttackStart(who);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if(Intro || (pInstance && pInstance->GetData(DATA_KAEL_TRASH_EVENT) != DONE))
            return;
        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustSummoned(Creature* summon)
    {
        summons.Summon(summon);
        if(summon->GetEntry() == CREATURE_PHOENIX)
            summon->CastSpell(summon, SPELL_REBIRTH_PHOENIX, false);
    }

    void RemoveGravityLapse()
    {
        Map *map = m_creature->GetMap();
        Map::PlayerList const &PlayerList = map->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
        {
            if(Player* player = i->getSource())
            {
                if(player->isGameMaster())
                    continue;
                player->RemoveAurasDueToSpell(SPELL_GRAVITY_LAPSE_FLY);
                player->RemoveAurasDueToSpell(SPELL_GRAVITY_LAPSE_DOT);
            }
        }
    }

    void CastGravityLapseFly()
    {
        Map *map = m_creature->GetMap();
        Map::PlayerList const &PlayerList = map->GetPlayers();
        Map::PlayerList::const_iterator i;
        for (i = PlayerList.begin(); i != PlayerList.end(); ++i)
        {
            if (Player* player = i->getSource())
            {
                if(player->isAlive())
                    player->CastSpell(player, SPELL_GRAVITY_LAPSE_FLY, true, 0, 0, m_creature->GetGUID());
            }
        }
    }

    void ResetStatues(bool deactivate)
    {
        if(pInstance)
        {
            if(GameObject* LeftStatue = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_KAEL_STATUE_LEFT)))
                LeftStatue->SetGoState(GOState(deactivate));
            if(GameObject* RightStatue = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_KAEL_STATUE_RIGHT)))
                RightStatue->SetGoState(GOState(deactivate));
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(pInstance && pInstance->GetData(DATA_KAEL_TRASH_EVENT) != DONE)
        {
            if(TrashCheckTimer < diff)
            {
                if(pInstance->GetData(DATA_KAEL_TRASH_COUNTER) >= 6)
                {
                    pInstance->SetData(DATA_KAEL_TRASH_EVENT, DONE);
                    DoScriptText(SAY_AGGRO, m_creature);
                    Intro = true;
                }
                TrashCheckTimer = 2000;
            }
            else
                TrashCheckTimer -= diff;
        }

        if(Intro)
        {
            if(IntroTimer < diff)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                Intro = false;
            }
            IntroTimer -= diff;
        }

        if(Outro)
        {
            if(OutroTimer < diff)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->DealDamage(me, me->GetHealth());
            }
            OutroTimer -= diff;
            return;
        }

        if(!UpdateVictim() && Phase != 2)
            return;

        if(CheckTimer < diff)
        {
            if(pInstance)
            {
                if(pInstance->GetData(DATA_KAELTHAS_EVENT) == IN_PROGRESS)
                {
                    DoZoneInCombat();
                    // teleport victim to self if not in range or not in LoS
                    if(!me->IsWithinDistInMap(me->getVictim(), 40) || !me->IsWithinLOSInMap(me->getVictim()))
                        ForceSpellCast(SPELL_TELEPORT_PLAYER, CAST_TANK, INTERRUPT_AND_CAST);
                }
            }
            CheckTimer = 2000;
        }
        else
            CheckTimer -= diff;

        switch(Phase)
        {
            case 1:
            {
                if(HeroicMode)
                {
                    if(PyroblastTimer < diff)
                    {
                        ForceSpellCastWithScriptText(SPELL_SHOCK_BARRIER, CAST_SELF, EMOTE_HEROIC_PYROBLAST, INTERRUPT_AND_CAST);
                        AddSpellToCast(SPELL_PYROBLAST, CAST_TANK);
                        PyroblastTimer = 60000;
                    }
                    else
                        PyroblastTimer -= diff;
                }

                if(FireballTimer < diff)
                {
                    AddSpellToCast(SPELL_FIREBALL, CAST_TANK);
                    if(me->IsWithinMeleeRange(me->getVictim()))
                    {
                        if(me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE)
                            me->GetMotionMaster()->MoveChase(me->getVictim());
                        FireballTimer = urand(2500, 6000);
                    }
                    else
                    {
                        if(me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
                            me->GetMotionMaster()->MoveIdle();
                        FireballTimer = 2000;
                    }
                }
                else
                    FireballTimer -= diff;

                if(PhoenixTimer < diff)
                {
                    AddSpellToCastWithScriptText(SPELL_PHOENIX, CAST_SELF, SAY_PHOENIX);
                    PhoenixTimer = urand(45000, 55000);
                }
                else
                    PhoenixTimer -= diff;

                if(FlameStrikeTimer < diff)
                {
                    AddSpellToCast(SPELL_SUMMON_FLAMESTRIKE, CAST_RANDOM);
                    if(roll_chance_f(40))
                        DoScriptText(SAY_FLAMESTRIKE, me);
                    FlameStrikeTimer = urand(25000, 35000);
                }
                else
                    FlameStrikeTimer -= diff;

                // Below 50%
                if(HealthBelowPct(50))
                {
                    ResetStatues(false);    // shatter statues
                    ClearCastQueue();
                    StopAutocast();
                    me->SetSelection(0);
                    ForceSpellCastWithScriptText(SPELL_TELEPORT_CENTER, CAST_SELF, SAY_GRAVITY_LAPSE, INTERRUPT_AND_CAST_INSTANTLY);
                    m_creature->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                    m_creature->StopMoving();
                    DoStartNoMovement(me->getVictim());
                    GravityLapseTimer = 0;
                    GravityLapsePhase = 1;
                    Phase = 2;
                    if(pInstance)
                        pInstance->SetData(DATA_KAEL_PHASE, Phase);
                }
                DoMeleeAttackIfReady();
            }
            break;

            case 2:
            {
                if(GravityLapseTimer < diff)
                {
                    switch(GravityLapsePhase)
                    {
                        case 0:
                            DoScriptText(SAY_RECAST_GRAVITY, m_creature);
                            GravityLapsePhase++;
                            GravityLapseTimer = 500;
                            break;
                        case 1:
                            AddSpellToCast(m_creature, SPELL_GRAVITY_LAPSE);
                            GravityLapseTimer = 3000;// Don't interrupt the visual spell
                            GravityLapsePhase++;
                            break;
                        case 2:
                            CastGravityLapseFly();
                            for(uint8 i = 0; i < 3; ++i)
                            {
                                AddSpellToCast(SPELL_SUMMON_ARCANE_SPHERE, CAST_SELF);
                            }
                            GravityLapseTimer = 29000;
                            GravityLapsePhase++;
                            break;
                        case 3:
                            me->InterruptNonMeleeSpells(false);
                            RemoveGravityLapse();
                            AddSpellToCastWithScriptText(SPELL_POWER_FEEDBACK, CAST_SELF, SAY_TIRED);
                            GravityLapseTimer = 10000;
                            GravityLapsePhase = 0;
                            break;
                    }
                }
                else
                    GravityLapseTimer -= diff;
            }
            break;
        }
        CastNextSpellIfAnyAndReady();
    }
};

struct mob_felkael_flamestrikeAI : public Scripted_NoMovementAI
{
    mob_felkael_flamestrikeAI(Creature *c) : Scripted_NoMovementAI(c) { }

    uint32 FlameStrikeTimer;

    void Reset()
    {
        FlameStrikeTimer = 5000;
        DoCast(m_creature, SPELL_FLAMESTRIKE_VISUAL, true);
    }
    void UpdateAI(const uint32 diff)
    {
        if(FlameStrikeTimer < diff)
        {
            DoCast(me, SPELL_FLAMESTRIKE, true);
            me->Kill(me, false);
        }
        else
            FlameStrikeTimer -= diff;
    }
};

struct mob_felkael_phoenix_eggAI : public Scripted_NoMovementAI
{
    mob_felkael_phoenix_eggAI(Creature *c) : Scripted_NoMovementAI(c)
    {
        pInstance = (c->GetInstanceData());
    }
    uint32 CheckTimer;
    uint32 HatchTimer;
    ScriptedInstance* pInstance;

    void Reset()
    {
        CheckTimer = 2000;
        HatchTimer = 15000;
    }

    void UpdateAI(const uint32 diff)
    {
        if(CheckTimer < diff)
        {
            if(pInstance && pInstance->GetData(DATA_KAELTHAS_EVENT) != IN_PROGRESS)
                me->Kill(me, false);
            CheckTimer = 2000;
        }
        else
            CheckTimer -= diff;

        if(HatchTimer < diff)
        {
            Creature* phoenix = DoSpawnCreature(CREATURE_PHOENIX, 0, 0, 0, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
            if(phoenix)
                phoenix->CastSpell((Unit*)NULL, SPELL_REBIRTH_EGG, true);
            me->Kill(me, false);
        }
        else
            HatchTimer -= diff;
    }
};

struct mob_felkael_phoenixAI : public ScriptedAI
{
    mob_felkael_phoenixAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }
    uint8 phase;
    uint32 CheckTimer;
    uint64 EggGUID;
    ScriptedInstance* pInstance;

    void Reset()
    {
        DoZoneInCombat();
        me->SetWalk(false);
        me->SetSpeed(MOVE_RUN, 0.6f);
        AddSpellToCast(SPELL_PHOENIX_BURN, CAST_SELF);
        CheckTimer = 1000;
        phase = 0;
    }

    void JustDied(Unit* killer)
    {
        ForceSpellCast(SPELL_EMBER_BLAST, CAST_SELF, INTERRUPT_AND_CAST_INSTANTLY);
        DoSpawnCreature(CREATURE_PHOENIX_EGG, 0, 0, 0, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
        me->RemoveCorpse();
    }

    void UpdateAI(const uint32 diff)
    {
        if(CheckTimer < diff)
        {
            if (pInstance)
            {
                if(pInstance->GetData(DATA_KAELTHAS_EVENT) != IN_PROGRESS)
                    me->Kill(me, false);
                if(pInstance->GetData(DATA_KAEL_PHASE) == 2)
                    phase = 2;
            }
            CheckTimer = 1000;
        }
        else
            CheckTimer -= diff;

        if(!UpdateVictim())
        {
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 200, true))
                AttackStart(target);
            else
                me->Kill(me, false);
        }

        if(phase == 2)
        {
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
            SetAutocast(SPELL_PHOENIX_FIREBALL, 2000, true, CAST_RANDOM, 200, true);
            phase++;    //set autocast only once
        }

        CastNextSpellIfAnyAndReady(diff);
    }
};

struct mob_arcane_sphereAI : public ScriptedAI
{
    mob_arcane_sphereAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }
    uint32 DespawnTimer;
    uint32 ChangeTargetTimer;
    uint32 CheckTimer;

    ScriptedInstance* pInstance;

    void Reset()
    {
        DoZoneInCombat();
        m_creature->SetLevitate(true);
        m_creature->SetSpeed(MOVE_FLIGHT, 0.6);
        DoCast(m_creature, SPELL_ARCANE_SPHERE_PASSIVE, true);
        DespawnTimer = 29000;
        ChangeTargetTimer = 1000;
        CheckTimer = 1000;
    }

    void MovementInform(uint32 Type, uint32 Id)
    {
        if(Type == POINT_MOTION_TYPE)
            if(Id == 1)
                ChangeTargetTimer = 0;
    }

    void UpdateAI(const uint32 diff)
    {

        if(CheckTimer < diff)
        {
            m_creature->SetSpeed(MOVE_FLIGHT, 0.6);    // to be tested
            if(pInstance && pInstance->GetData(DATA_KAELTHAS_EVENT) != IN_PROGRESS)
                DespawnTimer = 0;
            CheckTimer = 1000;

            if (!me->getVictim() || !me->getVictim()->isAlive())
                ChangeTargetTimer = 500;
        }
        else
            CheckTimer -= diff;

        if(DespawnTimer < diff)
        {
            me->DisappearAndDie();
        }
        else
            DespawnTimer -= diff;

        if(ChangeTargetTimer < diff)
        {
            DoResetThreat();
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 200, true, me->getVictimGUID()))
                me->GetMotionMaster()->MovePoint(1, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), false, true, UNIT_ACTION_DOWAYPOINTS);
            ChangeTargetTimer = 7000;   // to be tested
        }
        else
            ChangeTargetTimer -= diff;
    }
};

bool GOUse_go_kael_orb(Player *player, GameObject* _GO)
{
    ScriptedInstance* pInst = (ScriptedInstance*)_GO->GetInstanceData();
    if (pInst)
    {
        if(pInst->GetData(DATA_KAELTHAS_EVENT) == DONE)
            player->CastSpell(player, SPELL_ESCAPE_TO_IOQD, true);
    }
    return true;
}

CreatureAI* GetAI_boss_felblood_kaelthas(Creature* c)
{
    return new boss_felblood_kaelthasAI(c);
}

CreatureAI* GetAI_mob_arcane_sphere(Creature* c)
{
    return new mob_arcane_sphereAI(c);
}

CreatureAI* GetAI_mob_felkael_phoenix(Creature* c)
{
    return new mob_felkael_phoenixAI(c);
}

CreatureAI* GetAI_mob_felkael_phoenix_egg(Creature* c)
{
    return new mob_felkael_phoenix_eggAI(c);
}

CreatureAI* GetAI_mob_felkael_flamestrike(Creature* c)
{
    return new mob_felkael_flamestrikeAI(c);
}

void AddSC_boss_felblood_kaelthas()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_felblood_kaelthas";
    newscript->GetAI = &GetAI_boss_felblood_kaelthas;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_arcane_sphere";
    newscript->GetAI = &GetAI_mob_arcane_sphere;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_felkael_phoenix";
    newscript->GetAI = &GetAI_mob_felkael_phoenix;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_felkael_phoenix_egg";
    newscript->GetAI = &GetAI_mob_felkael_phoenix_egg;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_felkael_flamestrike";
    newscript->GetAI = &GetAI_mob_felkael_flamestrike;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="go_kael_orb";
    newscript->pGOUse = &GOUse_go_kael_orb;
    newscript->RegisterSelf();
}

