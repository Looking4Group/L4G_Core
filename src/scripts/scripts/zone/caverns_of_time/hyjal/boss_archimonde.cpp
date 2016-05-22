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
SDName: Boss_Archimonde
SD%Complete: 92
SDComment: Doomfires to be tested. Draining tree visuals to be fixed. Tyrande and second phase not fully implemented.
SDCategory: Caverns of Time, Mount Hyjal
EndScriptData */

#include "precompiled.h"
#include "def_hyjal.h"
#include "SpellAuras.h"
#include "hyjal_trash.h"

//text id -1534018 are the text used when previous events complete. Not part of this script.
#define SAY_AGGRO                   -1534019
#define SAY_DOOMFIRE1               -1534020
#define SAY_DOOMFIRE2               -1534021
#define SAY_AIR_BURST1              -1534022
#define SAY_AIR_BURST2              -1534023
#define SAY_SLAY1                   -1534024
#define SAY_SLAY2                   -1534025
#define SAY_SLAY3                   -1534026
#define SAY_ENRAGE                  -1534027
#define SAY_DEATH                   -1534028
#define SAY_SOUL_CHARGE1            -1534029
#define SAY_SOUL_CHARGE2            -1534030

#define SPELL_DENOUEMENT_WISP      32124
#define SPELL_ANCIENT_SPARK        39349
#define SPELL_PROTECTION_OF_ELUNE  38528

#define SPELL_DRAIN_WORLD_TREE      39140
#define SPELL_DRAIN_WORLD_TREE_2    39141

#define SPELL_FINGER_OF_DEATH       31984
#define SPELL_HAND_OF_DEATH         35354
#define SPELL_AIR_BURST             32014
#define SPELL_GRIP_OF_THE_LEGION    31972
#define SPELL_DOOMFIRE_STRIKE       31903   // this spell seems to be working fine
#define SPELL_DOOMFIRE_SPAWN        32074   // visual when Doomfire spawned
#define SPELL_DOOMFIRE              31945
#define SPELL_DOOMFIRE_DAMAGE       31944   // triggered by doomfire persistent aura
#define SPELL_UNLEASH_SOUL_YELLOW   32054
#define SPELL_UNLEASH_SOUL_GREEN    32057
#define SPELL_UNLEASH_SOUL_RED      32053
#define SPELL_FEAR                  31970

#define CREATURE_ARCHIMONDE             17968
#define CREATURE_DOOMFIRE               18095
#define CREATURE_DOOMFIRE_TARGETING     18104
#define CREATURE_ANCIENT_WISP           17946
#define CREATURE_CHANNEL_TARGET         22418

#define NORDRASSIL_X        5503.713
#define NORDRASSIL_Y       -3523.436
#define NORDRASSIL_Z        1608.781

struct mob_ancient_wispAI : public ScriptedAI
{
    mob_ancient_wispAI(Creature* c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    InstanceData* pInstance;
    uint32 CheckTimer;

    void Reset()
    {
        CheckTimer = 1000;
    }

    void DamageTaken(Unit* done_by, uint32 &damage)
    {
        damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if(CheckTimer < diff)
        {
            if (Unit* pArchimonde = Unit::GetUnit((*me), pInstance->GetData64(DATA_ARCHIMONDE)))
            {
                if (pArchimonde->isAlive())
                    DoCast(pArchimonde, SPELL_ANCIENT_SPARK);
                else
                    EnterEvadeMode();
            }
            CheckTimer = 1000;
        }
        else
            CheckTimer -= diff;
    }
};

/* This is the script for the Doomfire Targetting Mob. This mob simply follows players and/or travels in random directions and spawns Doomfire Persistent Area Aura which deals dmg to players in range.  */
struct mob_doomfire_targettingAI : public NullCreatureAI
{
    mob_doomfire_targettingAI(Creature* c) : NullCreatureAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    InstanceData * pInstance;

    uint32 ChangeTargetTimer;
    uint32 SummonTimer;     // This timer will serve to check on Archionde

    void Reset()
    {
        ChangeTargetTimer = 100;
        SummonTimer = 1000;
        me->SetWalk(false);
        me->setActive(true);
        me->SetSpeed(MOVE_RUN, 0.85);
        DoCast(me, SPELL_DOOMFIRE_SPAWN, true);
        DoCast(me, SPELL_DOOMFIRE);
    }

    Player* SelectPlayerForChasing(float mindist, float maxdist)
    {
        Map *map = me->GetMap();
        if(map->GetId() != 534) // Battle for MH
            return NULL;

        Unit* Archi = pInstance->GetCreature(pInstance->GetData64(DATA_ARCHIMONDE));
        if(!Archi || !Archi->isAlive())
            return NULL;

        Map::PlayerList const &PlayerList = map->GetPlayers();
        if (PlayerList.isEmpty())
            return NULL;

        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
        {
            if (Player* pl = i->getSource())
            {
                if (pl->isGameMaster()) // omit GMs
                    continue;
                if (pl->IsWithinDistInMap(me, mindist) || me->GetDistance(pl) > maxdist)
                    continue;
                if (pl->IsWithinDistInMap(Archi, 15.0))   // do not chase in 15yd range around Archimonde
                    continue;
                return pl;
            }
        }
        return NULL;
    }

    uint32 ChangeWaypointAndTimer()
    {
        Unit* Archi = pInstance->GetCreature(pInstance->GetData64(DATA_ARCHIMONDE));
        if(!Archi || !Archi->isAlive())
            return 0;

        //1. select victim at proper distance, and not in Archimonde proximity
        Player* ChaseVictim = SelectPlayerForChasing(10.0, 40.0);
        if(ChaseVictim)
        {
            me->GetMotionMaster()->MoveChase(ChaseVictim);
            return urand(4000, 11000);
        }
        //2. if no victim than linear movement in random direction but not towards the boss unless far away
        else
        {
            Position dest;
            if(me->GetDistance2d(Archi) >= 60)
            {
                // we are far from boss, choose any angle
                float angle = frand(0, 2*M_PI);
                me->GetValidPointInAngle(dest, 24, angle, true);
            }
            else
            {
                float angle = Archi->GetAngle(me);
                // select angle in +/- 30 degree from Archimonde opposite direction
                float direction = angle+frand(-M_PI/4, M_PI/4);
                me->GetValidPointInAngle(dest, 24, direction, true);
            }
            me->GetMotionMaster()->MovePoint(1, dest.x, dest.y, dest.z);
            return 6000;
        }
    }

    /* temporary test
    void MoveInLineOfSight(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(who, 5))
            ChangeTargetTimer = 200;
    }
    */

    void UpdateAI(const uint32 diff)
    {
        if (SummonTimer < diff)
        {
            Unit* pArchimonde = pInstance->GetCreature(pInstance->GetData64(DATA_ARCHIMONDE));
            if (pArchimonde && pArchimonde->isAlive())
            {
                if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE)
                {
                    Position dest;
                    me->GetValidPointInAngle(dest, 12, frand(0, M_PI), true);
                    me->GetMotionMaster()->MovePoint(2, dest.x, dest.y, dest.z);
                    ChangeTargetTimer = 2200;
                }
                SummonTimer = 1000;
            }
            else
                me->Kill(me, false);
        }
        else
            SummonTimer -= diff;

        if (ChangeTargetTimer)
        {
            if (ChangeTargetTimer <= diff)
            {
                /*
                Unit* pArchimonde = pInstance->GetCreature(pInstance->GetData64(DATA_ARCHIMONDE));
                if (pArchimonde && pArchimonde->isAlive())
                {
                    float angle = me->GetAngle(pArchimonde);
                    Position dest;
                    me->GetPosition(dest);
                    if(!me->IsWithinDistInMap(pArchimonde, 30))
                        angle = frand(0, 2*M_PI);
                    Position dest;

                    float angle = frand(0.0f, 3.0f); //randomise angle, a bit less than M_PI

                    float ArchiX = pArchimonde->GetPositionX();
                    float ArchiY = pArchimonde->GetPositionY();

                    me->GetPosition(dest);

                    float diffX = dest.x - ArchiX;
                    float diffY = -dest.y + ArchiY; // position Y is here below 0

                    if (diffX > 0) // make doomfire move away from actual boss position
                    {
                        if (diffY > 0)
                            angle = (angle > 3*M_PI/4) ? (2*M_PI - angle) : angle;
                        else
                            angle = (angle > M_PI/4) ? (2*M_PI - angle) : angle;
                    }
                    else
                    {
                        if (diffY > 0)
                            angle = (angle < M_PI/4) ? (M_PI + angle) : angle;
                        else
                            angle = (angle < 3*M_PI/4) ? (2*M_PI - angle) : angle;
                    }

                    (diffX > 0) ? dest.x += (40.0f * cos(angle)) : dest.x -= (40.0f * cos(angle));
                    (diffY > 0) ? dest.y += (40.0f * cos(angle)) : dest.y -= (40.0f * cos(angle));

                    me->GetValidPointInAngle(dest, 40, angle, false);
                    //me->GetValidPointInAngle(dest, 5.0f, angle, false);     //find point on the ground 5 yd from first destination location
                    me->GetMotionMaster()->MovePoint(0, dest.x, dest.y, dest.z);*/
                    ChangeTargetTimer = ChangeWaypointAndTimer();
            }
            else
                ChangeTargetTimer -= diff;
        }
    }
};

/*
   Finally, Archimonde's script. His script isn't extremely complex, most are simply spells on timers.
   The only complicated aspect of the battle is Finger of Death and Doomfire, with Doomfire being the
   hardest bit to code. Finger of Death is simply a distance check - if no one is in melee range, then
   select a random target and cast the spell on them. However, if someone IS in melee range, and this
   is NOT the main tank (creature's victim), then we aggro that player and they become the new victim.
*/

struct boss_archimondeAI : public hyjal_trashAI
{
    boss_archimondeAI(Creature *c) : hyjal_trashAI(c)
    {
        pInstance = (c->GetInstanceData());
        me->GetPosition(wLoc);
    }

    InstanceData* pInstance;
    WorldLocation wLoc;

    uint32 DrainNordrassilTimer;
    uint32 FearTimer;
    uint32 AirBurstTimer;
    uint32 GripOfTheLegionTimer;
    uint32 DoomfireTimer;
    uint32 SoulChargeTimer;
    uint32 SoulChargeCount;
    uint32 SoulChargeUnleashTimer;
    uint32 MeleeRangeCheckTimer;
    uint32 HandOfDeathTimer;
    uint32 SummonWispTimer;
    uint32 WispCount;
    uint32 EnrageTimer;
    uint32 CheckDistanceTimer;
    uint32 CheckTimer;

    uint32 chargeSpell;
    uint32 unleashSpell;

    bool Enraged;
    bool HasProtected;
    bool IsChanneling;
    bool SoulChargeUnleash;

    void Reset()
    {
        ClearCastQueue();

        pInstance->SetData(DATA_ARCHIMONDEEVENT, NOT_STARTED);

        damageTaken = 0;
        DrainNordrassilTimer = 0;
        FearTimer = 42000;
        AirBurstTimer = 30000;
        GripOfTheLegionTimer = urand(5000, 25000);
        DoomfireTimer = 20000;
        SoulChargeTimer = 3000;
        SoulChargeCount = 0;
        SoulChargeUnleashTimer = 5000;
        MeleeRangeCheckTimer = 15000;
        HandOfDeathTimer = 2000;
        WispCount = 0;                                      // When ~30 wisps are summoned, Archimonde dies
        EnrageTimer = 600000;                               // 10 minutes
        CheckTimer = 3000;
        CheckDistanceTimer = 30000;                         // This checks if he's too close to the World Tree (75 yards from a point on the tree), if true then he will enrage
        SummonWispTimer = 0;
        chargeSpell = 0;
        unleashSpell = 0;

        Enraged = false;
        HasProtected = false;
        IsChanneling = false;
        SoulChargeUnleash = false;

        RemoveSoulCharges();
        me->SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, 10);   //custom, should be verified
        me->SetFloatValue(UNIT_FIELD_COMBATREACH, 12);
    }

    void RemoveSoulCharges()
    {
        me->RemoveAurasDueToSpell(SPELL_SOUL_CHARGE_YELLOW);
        me->RemoveAurasDueToSpell(SPELL_SOUL_CHARGE_GREEN);
        me->RemoveAurasDueToSpell(SPELL_SOUL_CHARGE_RED);
    }

    void EnterCombat(Unit *who)
    {
        me->InterruptSpell(CURRENT_CHANNELED_SPELL);
        DoScriptText(SAY_AGGRO, me);
        RemoveSoulCharges();
        DoZoneInCombat();

        pInstance->SetData(DATA_ARCHIMONDEEVENT, IN_PROGRESS);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (!me->isInCombat() && me->IsWithinDistInMap(who, 50) && me->IsHostileTo(who))
            me->AI()->AttackStart(who);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2, SAY_SLAY3), me);
    }

    void JustDied(Unit *victim)
    {
        hyjal_trashAI::JustDied(victim);

        DoScriptText(SAY_DEATH, me);

        pInstance->SetData(DATA_ARCHIMONDEEVENT, DONE);
    }

    bool CanUseFingerOfDeath()
    {
        if (!me->getVictim())
            return true;

        if (me->IsWithinDistInMap(me->getVictim(), 5.0))
            return false;

        if (Unit *target = me->SelectNearestTarget(me->GetAttackDistance(me->getVictim())))
        {
            me->AddThreat(target, DoGetThreat(me->getVictim()));
            return false;
        }

        float BossDiffZ = (me->GetPositionZ() - me->GetTerrain()->GetHeight(me->GetPositionX(), me->GetPositionY(), MAX_HEIGHT, true));

        if (BossDiffZ > 4 || BossDiffZ < -4) // do not use finger of death when walking above ground level
            return false;

        return true;
    }

    /*void SummonDoomfire()
    {
        Position dest;
        me->GetValidPointInAngle(dest, 20.0f, frand(0.0f, 2*M_PI), true);

        if (Creature* pDoomfire = me->SummonCreature(CREATURE_DOOMFIRE_TARGETING, dest.x, dest.y, dest.z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
        {
            pDoomfire->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            pDoomfire->SetLevel(me->getLevel());
            pDoomfire->setFaction(me->getFaction());
            pDoomfire->CastSpell(pDoomfire, SPELL_DOOMFIRE_SPAWN, true);

            if (roll_chance_f(20.0f)) //20% chance on yell
                DoScriptText(RAND(SAY_DOOMFIRE1, SAY_DOOMFIRE2), me);
        }
    }*/


    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat())
        {
            if (pInstance)
            {
                // Do not let the raid skip straight to Archimonde. Visible and hostile ONLY if Azagalor is finished and Archimond is not saved as done.
                if ((pInstance->GetData(DATA_AZGALOREVENT) < DONE || pInstance->GetData(DATA_ARCHIMONDEEVENT) >= DONE) && ((me->GetVisibility() != VISIBILITY_OFF) || (me->getFaction() != 35)))
                {
                    me->SetVisibility(VISIBILITY_OFF);
                    me->setFaction(35);
                }
                else if ((pInstance->GetData(DATA_AZGALOREVENT) >= DONE) && ((me->GetVisibility() != VISIBILITY_ON) || (me->getFaction() == 35)))
                {
                    me->setFaction(1720);
                    me->SetVisibility(VISIBILITY_ON);
                }
            }

            if (DrainNordrassilTimer < diff)
            {
                if (!IsChanneling)
                {
                    if (Creature* pNordrassil = me->SummonCreature(CREATURE_CHANNEL_TARGET, NORDRASSIL_X, NORDRASSIL_Y, NORDRASSIL_Z, 0, TEMPSUMMON_TIMED_DESPAWN, 1200000))
                    {
                        pNordrassil->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        pNordrassil->SetUInt32Value(UNIT_FIELD_DISPLAYID, 11686);

                        DoCast(pNordrassil, SPELL_DRAIN_WORLD_TREE);
                        IsChanneling = true;
                    }
                }

                if (Creature* pNordrassil = me->SummonCreature(CREATURE_CHANNEL_TARGET, NORDRASSIL_X, NORDRASSIL_Y, NORDRASSIL_Z, 0, TEMPSUMMON_TIMED_DESPAWN, 5000))
                {
                    pNordrassil->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    pNordrassil->SetUInt32Value(UNIT_FIELD_DISPLAYID, 11686);
                    pNordrassil->CastSpell(me, SPELL_DRAIN_WORLD_TREE_2, true);

                    DrainNordrassilTimer = 5000;
                }
            }
            else
                DrainNordrassilTimer -= diff;
        }

        if (!UpdateVictim() && !HealthBelowPct(10.0f))
            return;

        if (CheckTimer < diff)
        {
            if (!me->IsWithinDistInMap(&wLoc, 125))
            {
                EnterEvadeMode();
                return;
            }

            DoZoneInCombat();
            me->SetSpeed(MOVE_RUN, 3.0);

            CheckTimer = 1000;
        }
        else
            CheckTimer -= diff;

        if (!Enraged)
        {
            if (EnrageTimer < diff)
            {
                if (!HealthBelowPct(10.0f))
                {
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    Enraged = true;
                    DoScriptText(SAY_ENRAGE, me);
                }
            }
            else
                EnrageTimer -= diff;

            if(CheckDistanceTimer < diff)
            {
                if(me->GetDistance2d(wLoc.coord_x, wLoc.coord_y) > 80.0)
                {
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    Enraged = true;
                    if(me->GetPositionX() < 5580.0f)    // if near to the tree, do say enrage yell
                        DoScriptText(SAY_ENRAGE, me);
                }
                CheckDistanceTimer = 5000;
            }
            else
                CheckDistanceTimer -= diff;
        }

        if (HealthBelowPct(10.0f))
        {
            if (!HasProtected)
            {
                me->GetMotionMaster()->Clear(false);
                me->GetMotionMaster()->MoveIdle();
                //all members of raid must get this buff
                ForceSpellCast(me->getVictim(), SPELL_PROTECTION_OF_ELUNE, INTERRUPT_AND_CAST_INSTANTLY);
                HasProtected = true;
                Enraged = true;
            }

            if (SummonWispTimer < diff)
            {
                if (Creature* pWisp = DoSpawnCreature(CREATURE_ANCIENT_WISP, rand()%40, rand()%40, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                    pWisp->AI()->AttackStart(me);

                SummonWispTimer = 1500;
                ++WispCount;
            }
            else
                SummonWispTimer -= diff;

            if (WispCount >= 30)
            {
                if (Unit* pWisp = FindCreature(CREATURE_ANCIENT_WISP, 100, me))
                    pWisp->CastSpell(me, SPELL_DENOUEMENT_WISP, false);
                else
                    me->DealDamage(me, me->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            }
        }

        if (Enraged)
        {
            if (HandOfDeathTimer < diff)
            {
                ForceSpellCast(me, SPELL_HAND_OF_DEATH, INTERRUPT_AND_CAST_INSTANTLY);
                HandOfDeathTimer = 2000;
            }
            else
                HandOfDeathTimer -= diff;
            return;                                         // Don't do anything after this point.
        }

        if (SoulChargeTimer < diff)
        {
            if (!SoulChargeUnleash)
            {
                if (me->HasAura(SPELL_SOUL_CHARGE_YELLOW, 0))
                {
                    SoulChargeUnleash = true;
                    chargeSpell = SPELL_SOUL_CHARGE_YELLOW;
                    unleashSpell = SPELL_UNLEASH_SOUL_YELLOW;
                    SoulChargeUnleashTimer = urand(5000, 10000);
                }
                else if (me->HasAura(SPELL_SOUL_CHARGE_RED, 0))
                {
                    SoulChargeUnleash = true;
                    chargeSpell = SPELL_SOUL_CHARGE_RED;
                    unleashSpell = SPELL_UNLEASH_SOUL_RED;
                    SoulChargeUnleashTimer = urand(5000, 10000);
                }
                else if(me->HasAura(SPELL_SOUL_CHARGE_GREEN, 0))
                {
                    SoulChargeUnleash = true;
                    chargeSpell = SPELL_SOUL_CHARGE_GREEN;
                    unleashSpell = SPELL_UNLEASH_SOUL_GREEN;
                    SoulChargeUnleashTimer = urand(5000, 10000);
                }
                SoulChargeTimer = 3000;
            }
        }
        else
            SoulChargeTimer -= diff;

        if (SoulChargeUnleash)
        {
            if (SoulChargeUnleashTimer < diff)
            {
                while (me->HasAura(chargeSpell, 0))
                {
                    SoulChargeCount++;
                    me->RemoveSingleAuraFromStack(chargeSpell, 0);
                }
                if (SoulChargeCount)
                {
                    SoulChargeCount--;
                    AddSpellToCast(me, unleashSpell);
                    SoulChargeTimer = 1000;
                    SoulChargeUnleashTimer = 1500;
                }
                else
                {
                    SoulChargeUnleash = false;
                    SoulChargeTimer = 4000;
                }
            }
            else
                SoulChargeUnleashTimer -= diff;
        }

        if (GripOfTheLegionTimer < diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 100, true))
            {
                AddSpellToCast(target, SPELL_GRIP_OF_THE_LEGION);

                if (AirBurstTimer < 3000)
                    AirBurstTimer = 3000;

                GripOfTheLegionTimer = urand(5000, 25000);
            }
        }
        else
            GripOfTheLegionTimer -= diff;

        if (AirBurstTimer < diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 100, true, me->getVictimGUID()))
            {
                AddSpellToCastWithScriptText(target, SPELL_AIR_BURST, RAND(SAY_AIR_BURST1, SAY_AIR_BURST2), false, true);

                if (FearTimer < 10000)
                    FearTimer = 10000;

                AirBurstTimer = urand(25000, 35000);
            }
        }
        else
            AirBurstTimer -= diff;

        if (FearTimer < diff)
        {
            AddSpellToCast(me, SPELL_FEAR);
            FearTimer = 42000;
        }
        else
            FearTimer -= diff;

        if (DoomfireTimer < diff)
        {
            //SummonDoomfire();
            if (roll_chance_f(20.0f)) //20% chance on yell
                DoScriptText(RAND(SAY_DOOMFIRE1, SAY_DOOMFIRE2), me);
            AddSpellToCast(SPELL_DOOMFIRE_STRIKE, CAST_SELF);
            DoomfireTimer = urand(9000, 12000);
        }
        else
            DoomfireTimer -= diff;

        if (MeleeRangeCheckTimer < diff)
        {
            if (CanUseFingerOfDeath())
            {
                if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 150, true))
                    AddSpellToCast(target, SPELL_FINGER_OF_DEATH);

                MeleeRangeCheckTimer = 1000;
            }
            else
                MeleeRangeCheckTimer = 5000;
        }
        else
            MeleeRangeCheckTimer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
    void WaypointReached(uint32 /*i*/) {}
};

CreatureAI* GetAI_boss_archimonde(Creature *_Creature)
{
    return new boss_archimondeAI (_Creature);
}

CreatureAI* GetAI_mob_doomfire_targetting(Creature* _Creature)
{
    return new mob_doomfire_targettingAI(_Creature);
}

CreatureAI* GetAI_mob_ancient_wisp(Creature* _Creature)
{
    return new mob_ancient_wispAI(_Creature);
}

void AddSC_boss_archimonde()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_archimonde";
    newscript->GetAI = &GetAI_boss_archimonde;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_doomfire_targetting";
    newscript->GetAI = &GetAI_mob_doomfire_targetting;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_ancient_wisp";
    newscript->GetAI = &GetAI_mob_ancient_wisp;
    newscript->RegisterSelf();
}
