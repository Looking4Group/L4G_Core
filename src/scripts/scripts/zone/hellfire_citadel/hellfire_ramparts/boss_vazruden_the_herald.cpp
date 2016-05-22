/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
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
Name: Boss_Vazruden_the_Herald
%Complete: 95
Comment:
Category: Hellfire Citadel, Hellfire Ramparts
EndScriptData */

#include "precompiled.h"
#include "hellfire_ramparts.h"

#define SAY_INTRO                   -1543017
#define SAY_AGGRO1                  -1543018
#define SAY_AGGRO2                  -1543019
#define SAY_AGGRO3                  -1543020
#define SAY_TAUNT                   -1543021
#define SAY_KILL1                   -1543022
#define SAY_KILL2                   -1543023
#define SAY_DEATH                   -1543024
#define EMOTE_DESCEND               -1543025
#define POINT_ID_CENTER             11
#define POINT_ID_FLYING             12
#define POINT_ID_COMBAT             13
#define SPELL_FIREBALL              (HeroicMode?36920:34653)
#define SPELL_CONE_OF_FIRE          (HeroicMode?36921:30926)
#define SPELL_SUMMON_LIQUID_FIRE    (HeroicMode?30928:23971)
#define SPELL_BELLOW_ROAR           39427
#define SPELL_REVENGE               (HeroicMode?40392:19130)
#define SPELL_BLAZE                 (HeroicMode?32492:30927)
#define SPELL_KIDNEY_SHOT           30621
#define SPELL_FIRE_NOVA_VISUAL      19823
#define SPELL_SUMMON_VAZRUDEN       30717
#define ENTRY_HELLFIRE_SENTRY       17517
#define ENTRY_VAZRUDEN_HERALD       17307
#define ENTRY_VAZRUDEN              17537
#define ENTRY_NAZAN                 17536
#define ENTRY_LIQUID_FIRE           22515
#define ENTRY_REINFORCED_FEL_IRON_CHEST (HeroicMode?185169:185168)

#define PATH_ENTRY                  2081

const float CenterPos[3] = { -1399.401f, 1736.365f, 87.008f};
const float CombatPos[3] = { -1413.848f, 1754.019f, 83.146f};

struct boss_vazruden_the_heraldAI : public ScriptedAI
{
    boss_vazruden_the_heraldAI(Creature* creature) : ScriptedAI(creature)
    {
        pInstance = (creature->GetInstanceData());
        HeroicMode = me->GetMap()->IsHeroic();
    }

    ScriptedInstance* pInstance;

    bool HeroicMode;
    bool SentryDown;
    bool IsEventInProgress;
    bool IsDescending;
    uint8 phase;
    uint32 MovementTimer;
    uint32 FireballTimer;
    uint32 ConeOfFireTimer;
    uint32 BellowingRoarTimer;
    uint32 checktimer;
    uint32 FlyTimer;
    uint64 PlayerGUID;
    uint64 VazrudenGUID;
    uint64 VictimGUID;

    void Reset()
    {
        if (me->GetEntry() != ENTRY_VAZRUDEN_HERALD)
            me->UpdateEntry(ENTRY_VAZRUDEN_HERALD);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        MovementTimer = 0;
        phase = 0;
        SentryDown = false;
        IsEventInProgress = false;
        IsDescending = false;
        PlayerGUID = 0;
        VazrudenGUID = 0;
        VictimGUID = 0;
        checktimer = 0;
        FireballTimer = 0;
        ConeOfFireTimer = 1200+rand()%3000;
        BellowingRoarTimer = 1800+rand()%3000;
        FlyTimer = 45000+rand()%3000;
        me->SetLevitate(true);
        me->SetSpeed(MOVE_FLIGHT, 1.0f);
        me->GetMotionMaster()->MovePath(PATH_ENTRY, true);

        if (Creature* Vazruden = GetClosestCreatureWithEntry(me, ENTRY_VAZRUDEN, 100.0f, false))
        {
            Vazruden->SetLootRecipient(NULL);
            Vazruden->RemoveCorpse();
        }
    }

    void AttackStart(Unit* who)
    {
        if (pInstance && pInstance->GetData(DATA_NAZAN) != IN_PROGRESS)
            return;

        ScriptedAI::AttackStart(who);
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if (!pInstance)
            return;

        if (type == POINT_MOTION_TYPE)
        {
            switch (id)
            {
                case POINT_ID_CENTER:
                    DoSplit();
                    break;
                case POINT_ID_COMBAT:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    pInstance->SetData(DATA_NAZAN, IN_PROGRESS);
                    me->SetLevitate(false);
                    me->SetWalk(true);
                    me->GetMotionMaster()->Clear();

                    if (Unit *victim = SelectUnit(SELECT_TARGET_NEAREST,0))
                        me->AI()->AttackStart(victim);

                    FireballTimer = 5200+rand()%4000;
                    phase = 2;
                    break;
                case POINT_ID_FLYING:
                    if (IsEventInProgress)
                        FireballTimer = 1;
                    break;
            }
        }
    }

    void DoStart()
    {
        if (MovementTimer || IsEventInProgress)
            return;

        if (pInstance)
        {
            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            DoMoveToCenter();
            IsEventInProgress = true;
        }

        phase = 1;
    }

    void DoMoveToCenter()
    {
        DoScriptText(SAY_INTRO, me);
        me->GetMotionMaster()->MovePoint(POINT_ID_CENTER, CenterPos[0], CenterPos[1], CenterPos[2]);
    }

    void DoSplit()
    {
        me->UpdateEntry(ENTRY_NAZAN);
        DoCast(me, SPELL_SUMMON_VAZRUDEN);
        MovementTimer = 2000;
        checktimer = 10000;
        me->SetSpeed(MOVE_FLIGHT, 2.0f);
        me->GetMotionMaster()->MoveIdle();
    }

    void DoMoveToAir()
    {
        float x, y, z, o;
        me->GetHomePosition(x, y, z, o);
        me->GetMotionMaster()->MovePoint(POINT_ID_FLYING, x, y, z);
    }

    void DoMoveToCombat()
    {
        if (IsDescending || !pInstance || pInstance->GetData(DATA_NAZAN) == IN_PROGRESS)
            return;

        IsDescending = true;
        me->GetMotionMaster()->MovePoint(POINT_ID_COMBAT, CombatPos[0], CombatPos[1], CombatPos[2]);
        DoScriptText(EMOTE_DESCEND, me);
    }

    void SpellHitTarget(Unit* target, const SpellEntry* entry)
    {

    }

    void JustSummoned(Creature* summoned)
    {
        switch (summoned->GetEntry())
        {
            case ENTRY_VAZRUDEN:
                if (Player* pPlayer = Unit::GetPlayer(PlayerGUID))
                    summoned->AI()->AttackStart(pPlayer);

                VazrudenGUID = summoned->GetGUID();
                break;
            case ENTRY_LIQUID_FIRE:
                summoned->SetLevel(me->getLevel());
                summoned->setFaction(me->getFaction());
                break;
        }
    }

    void DoDescend()
    {
        if (IsDescending)
            return;

        DoMoveToCombat();
    }

    void SentryDownBy(Unit* who)
    {
        if (SentryDown)
        { 
            PlayerGUID = who->GetGUID();
            DoStart();
            SentryDown = false;
        }
        else
            SentryDown = true;
    }

    void SelectVictim(Unit* victim)
    {
        VictimGUID = victim->GetGUID();
    }

    void JustDied(Unit* killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_NAZAN, DONE);
    }

    void JustReachedHome()
    {
        if (pInstance)
            pInstance->SetData(DATA_NAZAN, FAIL);
    }

    void UpdateAI(const uint32 diff)
    {
       

        switch (phase)
        {
            case 0:
                return;
                break;
            case 1: // flight
                if (MovementTimer)
                {
                    if (MovementTimer <= diff)
                    {
                        DoMoveToAir();
                        MovementTimer = 0;
                    }
                    else
                        MovementTimer -= diff;
                }

                if (VazrudenGUID && FireballTimer)
                {
                    if (FireballTimer <= diff)
                    {
                        if (Creature* Vazruden = me->GetMap()->GetCreature(VazrudenGUID))
                        {
                            Vazruden->AI()->DoAction();

                            if (Unit* victim = Unit::GetUnit(*me, VictimGUID))
                            {
                                DoCast(victim, SPELL_FIREBALL);
                                FireballTimer = 4000+rand()%3000;
                            }
                        }
                    }
                    else
                        FireballTimer -= diff;
                 }

                 if (FlyTimer <= diff)
                 {
                     DoDescend();
                 }
                 else
                     FlyTimer -= diff;

                 if ((me->GetHealth())*100 / me->GetMaxHealth() < 20)
                     DoMoveToCombat();

                 if (checktimer < diff && me->isAlive())
                 {
                     if (Creature* Vazruden = me->GetMap()->GetCreature(VazrudenGUID))
                     {
                         if (Vazruden && Vazruden->getVictim() || me->GetMotionMaster()->GetCurrentMovementGeneratorType() == POINT_MOTION_TYPE)
                             return;
                         else
                             EnterEvadeMode();
                     }

                     checktimer = 2000;
                        
                }
                else
                    checktimer -= diff;
                break;
            case 2: // In Combat
                if (FireballTimer <= diff)
                {
                    if (Unit *victim = SelectUnit(SELECT_TARGET_RANDOM,0))
                    {
                        DoCast(victim, SPELL_FIREBALL);
                        FireballTimer = 7000+rand()%3000;
                    }
                }
                else
                    FireballTimer -= diff;

                if (ConeOfFireTimer <= diff)
                {
                    DoCast(me->getVictim(), SPELL_CONE_OF_FIRE);
                    ConeOfFireTimer = 8300+rand()%3000;
                }
                else
                    ConeOfFireTimer -= diff;

                if (HeroicMode)
                {
                    if (BellowingRoarTimer <= diff)
                    {
                        DoCast(me, SPELL_BELLOW_ROAR);
                        BellowingRoarTimer = 35000+rand()%4000;
                    }
                    else
                        BellowingRoarTimer -= diff;
                }

                DoMeleeAttackIfReady();

                if (checktimer <= diff)
                {
                    if (!me->getVictim())
                    {
                        if (Unit *victim = SelectUnit(SELECT_TARGET_NEAREST,0))
                            me->AI()->AttackStart(victim);
                        else
                            EnterEvadeMode();
                    }
                        
                    checktimer = 2000;
                        
                }
                else
                    checktimer -= diff;
                break;
        }
     }
};

struct boss_vazrudenAI : public ScriptedAI
{
    boss_vazrudenAI(Creature* creature) : ScriptedAI(creature)
    {
        pInstance = (creature->GetInstanceData());
        HeroicMode = me->GetMap()->IsHeroic();
    }

    ScriptedInstance* pInstance;

    bool HeroicMode;
    bool HealthBelow;

    uint32 RevengeTimer;
    uint64 VazHeraldGUID;
    
    void Reset()
    {
        HealthBelow = false;
        RevengeTimer = 4000+rand()%3000;
        VazHeraldGUID = 0;
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), me);
    }

    void JustDied(Unit* killer)
    {
        DoScriptText(SAY_DEATH, me);

        if (pInstance)
        {
            if (uint64 VazHeraldGUID = pInstance->GetData64(DATA_VAZHERALD))
            {
                Creature* Nazan = (Unit::GetCreature(*me, VazHeraldGUID));
                CAST_AI(boss_vazruden_the_heraldAI, Nazan->AI())->DoDescend();
            }
        }
    }

    void JustReachedHome()
    {
        me->SetVisibility(VISIBILITY_OFF);
        me->ForcedDespawn();
    }

    void KilledUnit(Unit* pVictim)
    {
        DoScriptText(RAND(SAY_KILL1, SAY_KILL2), me);
    }

    void DamageTaken(Unit* dealer, uint32& damage)
    {
        if (!HealthBelow && pInstance && (me->GetHealth()*100 - damage) / me->GetMaxHealth() < 30)
        {
            if (uint64 VazHeraldGUID = pInstance->GetData64(DATA_VAZHERALD))
            {
                Creature* Nazan = (Unit::GetCreature(*me, VazHeraldGUID));
                CAST_AI(boss_vazruden_the_heraldAI, Nazan->AI())->DoDescend();
            }

            HealthBelow = true;
        }
    }

    void DoAction(const int32 action)
    {
        if (Unit *victim = SelectUnit(SELECT_TARGET_RANDOM,0))
        {
            if (uint64 VazHeraldGUID = pInstance->GetData64(DATA_VAZHERALD))
            {
                Creature* Nazan = (Unit::GetCreature(*me, VazHeraldGUID));
                CAST_AI(boss_vazruden_the_heraldAI, Nazan->AI())->SelectVictim(victim);
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (RevengeTimer < diff)
        {
            DoCast(me->getVictim(), SPELL_REVENGE);
            RevengeTimer = 10000+rand()%3000;
        }
        else
            RevengeTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

struct mob_hellfire_sentryAI : public ScriptedAI
{
    mob_hellfire_sentryAI(Creature *creature) : ScriptedAI(creature)
    {
        pInstance = (creature->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 KidneyShot_Timer;
    uint64 VazHeraldGUID;

    void Reset()
    {
        KidneyShot_Timer = 3000+rand()%4000;
        VazHeraldGUID = 0;
    }

    void JustDied(Unit* who)
    {
        if (uint64 VazHeraldGUID = pInstance->GetData64(DATA_VAZHERALD))
        {
            Creature* Nazan = (Unit::GetCreature(*me, VazHeraldGUID));
            CAST_AI(boss_vazruden_the_heraldAI, Nazan->AI())->SentryDownBy(who);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (KidneyShot_Timer <= diff)
        {
            if (Unit *victim = me->getVictim())
                DoCast(victim, SPELL_KIDNEY_SHOT);

            KidneyShot_Timer = 18000+rand()%3000;
        }
        else
            KidneyShot_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_vazruden_the_herald(Creature *creature)
{
    return new boss_vazruden_the_heraldAI (creature);
}

CreatureAI* GetAI_boss_vazruden(Creature *creature)
{
    return new boss_vazrudenAI (creature);
}

CreatureAI* GetAI_mob_hellfire_sentry(Creature *creature)
{
    return new mob_hellfire_sentryAI (creature);
}

void AddSC_boss_vazruden_the_herald()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_vazruden_the_herald";
    newscript->GetAI = &GetAI_boss_vazruden_the_herald;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_vazruden";
    newscript->GetAI = &GetAI_boss_vazruden;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_hellfire_sentry";
    newscript->GetAI = &GetAI_mob_hellfire_sentry;
    newscript->RegisterSelf();
}
