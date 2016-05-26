/* 
 * Copyright (C) 2006-2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2008-2014 Looking4Group <http://looking4group.de/>
 * 
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
SDName: Thaddius encounter
SD%Complete: 0
SDComment:
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

//Stalagg
#define SAY_STAL_AGGRO          -1533023
#define SAY_STAL_SLAY           -1533024
#define SAY_STAL_DEATH          -1533025

//Feugen
#define SAY_FEUG_AGGRO          -1533026
#define SAY_FEUG_SLAY           -1533027
#define SAY_FEUG_DEATH          -1533028

//Thaddus
#define SAY_GREET               -1533029
#define SAY_AGGRO1              -1533030
#define SAY_AGGRO2              -1533031
#define SAY_AGGRO3              -1533032
#define SAY_SLAY                -1533033
#define SAY_ELECT               -1533034
#define SAY_DEATH               -1533035
#define SAY_SCREAM1             -1533036
#define SAY_SCREAM2             -1533037
#define SAY_SCREAM3             -1533038
#define SAY_SCREAM4             -1533039

#define GO_TESLA_COIL1    181477
#define GO_TESLA_COIL2    181478    //those 2 are not spawned

enum eSpells
{
    // Fuegen
    SPELL_MANA_BURN               = 28135,
    SPELL_CHAIN_F                 = 28111,
    SPELL_TESLA_PASSIVE_F         = 28109,
    SPELL_MAGNETIC_PULL_F         = 28338,

    // Stalagg
    SPELL_CHAIN_S                 = 28096,
    SPELL_POWER_SURGE             = 28134,
    SPELL_TESLA_PASSIVE_S         = 28097,
    SPELL_MAGNETIC_PULL_S         = 28339,

    // shared
    SPELL_WAR_STOMP               = 28125,

    // Thaddius
    SPELL_SELF_STUN               = 28160,
    SPELL_BALL_LIGHTNING          = 28299,
    SPELL_POLARITY_SHIFT          = 28089,

    SPELL_CHAIN_LIGHTNING         = 28167,
    SPELL_BERSERK                 = 26662
};

enum eEvents
{
    // 1st phase shared
    EVENT_WAR_STOMP         = 1,
    EVENT_PULL_TANK         = 2,

    // Fuegen
    EVENT_MANA_BURN         = 3,

    // Stalagg
    EVENT_POWER_SURGE       = 4,

    // Thaddius
    EVENT_POLARITY_SHIFT    = 5,
    EVENT_BERSERK           = 6,
    EVENT_CHAIN_LIGHTNING   = 7
};

struct boss_thaddiusAI : public BossAI
{
    boss_thaddiusAI(Creature *c) : BossAI(c, DATA_THADDIUS) {}

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        events.ScheduleEvent(EVENT_POLARITY_SHIFT, 30000);
        events.ScheduleEvent(EVENT_BERSERK, 300000);
        events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, urand(15000, 45000));   // GUESSED

        me->SetReactState(REACT_PASSIVE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    }

    void EnterEvadeMode()
    {
        events.Reset();
        ClearCastQueue();

        if (Creature *pStalagg = instance->GetCreature(instance->GetData64(DATA_STALAGG)))
            if (!pStalagg->isAlive())
                pStalagg->Respawn();

        if (Creature *pFeugen = instance->GetCreature(instance->GetData64(DATA_FEUGEN)))
            if (!pFeugen->isAlive())
                pFeugen->Respawn();

        CreatureAI::EnterEvadeMode();
    }

    void Engage()
    {
        me->SetReactState(REACT_AGGRESSIVE);
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        DoZoneInCombat();
    }

    void EnterCombat(Unit*)
    {
        DoScriptText(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), me);
    }

    void KilledUnit(Unit*)
    {
        if (roll_chance_f(20.0f))
            DoScriptText(SAY_SLAY, me);
    }

    void JustDied(Unit*)
    {
        DoScriptText(SAY_DEATH, me);
    }

    // i'm not sure :P but probably he shouldn't move
    void AttackStart(Unit* pWho)
    {
        if (!pWho)
            return;

        if (m_creature->Attack(pWho, true))
            DoStartNoMovement(pWho);
    }

    void DoMeleeAttackIfReady()
    {
        if (m_creature->hasUnitState(UNIT_STAT_CASTING))
            return;

        Unit *temp = m_creature->getVictim();

        if (!temp)
            temp = SelectUnit(SELECT_TARGET_TOPAGGRO, 0, 5.0f);

        if (!temp || !me->IsWithinMeleeRange(temp))
        {
            ForceSpellCast(SPELL_BALL_LIGHTNING, CAST_TANK);
            return;
        }

        // set selection back to attacked victim if not selected (after spell casting)
        if (((Creature*)me)->GetSelection() != temp->GetGUID())
            ((Creature*)me)->SetSelection(temp->GetGUID());

        //Make sure our attack is ready
        if (me->isAttackReady())
        {
            me->AttackerStateUpdate(temp);
            me->resetAttackTimer();
        }

        if (me->haveOffhandWeapon() && me->isAttackReady(OFF_ATTACK))
        {
            me->AttackerStateUpdate(temp, OFF_ATTACK);
            me->resetAttackTimer(OFF_ATTACK);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVADE_CHECK, 100.0f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_POLARITY_SHIFT:
                {
                    AddSpellToCast(SPELL_POLARITY_SHIFT, CAST_NULL);
                    events.ScheduleEvent(EVENT_POLARITY_SHIFT, 30000);
                    break;
                }
                case EVENT_BERSERK:
                {
                    AddSpellToCast(SPELL_BERSERK, CAST_SELF);
                    break;
                }
                case EVENT_CHAIN_LIGHTNING:
                {
                    AddSpellToCast(SPELL_CHAIN_LIGHTNING, CAST_RANDOM);
                    events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, urand(15000, 45000));
                    break;
                }
                default:
                    break;
            }
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_thaddius(Creature *_Creature)
{
    return new boss_thaddiusAI(_Creature);
}

struct boss_stalaggAI : public BossAI
{
    boss_stalaggAI(Creature *c) : BossAI(c, DATA_STALAGG) {}

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        // proper timers
        events.ScheduleEvent(EVENT_PULL_TANK, 20500);

        // guessed timers, to FIX
        events.ScheduleEvent(EVENT_POWER_SURGE, 10000);
        events.ScheduleEvent(EVENT_WAR_STOMP, 30000);

        me->RemoveAurasDueToSpell(SPELL_TESLA_PASSIVE_S);
    }

    void EnterEvadeMode()
    {
        if (Creature *pFeugen = instance->GetCreature(instance->GetData64(DATA_FEUGEN)))
            if (!pFeugen->isAlive())
                pFeugen->Respawn();

        CreatureAI::EnterEvadeMode();
    }

    void EnterCombat(Unit*)
    {
        DoScriptText(SAY_STAL_AGGRO, me);
        ForceSpellCast(SPELL_TESLA_PASSIVE_S, CAST_SELF);
    }

    void KilledUnit(Unit*)
    {
        if (roll_chance_f(20.0f))
            DoScriptText(SAY_STAL_SLAY, me);
    }

    void JustDied(Unit *pKiller)
    {
        DoScriptText(SAY_STAL_DEATH, me);

        if (Creature *pFeugen = instance->GetCreature(instance->GetData64(DATA_FEUGEN)))
        {
            if (!pFeugen->HealthBelowPct(2))
            {
                me->setDeathState(JUST_DIED);
                me->Respawn();
                return;
            }

            if (pFeugen->isDead())
                if (Creature *pThaddius = instance->GetCreature(instance->GetData64(DATA_THADDIUS)))
                    ((boss_thaddiusAI*) (pThaddius->AI()))->Engage();
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVADE_CHECK, 100.0f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_POWER_SURGE:
                {
                    AddSpellToCast(SPELL_POWER_SURGE, CAST_SELF);
                    events.ScheduleEvent(EVENT_POWER_SURGE, 20000); // guessed timer
                    break;
                }
                case EVENT_WAR_STOMP:
                {
                    AddSpellToCast(SPELL_WAR_STOMP, CAST_SELF);
                    events.ScheduleEvent(EVENT_WAR_STOMP, 15000); // guessed timer
                    break;
                }
                case EVENT_PULL_TANK:
                {
                    AddSpellToCast(SPELL_MAGNETIC_PULL_S, CAST_NULL);
                    events.ScheduleEvent(EVENT_PULL_TANK, 20500);
                    break;
                }
                default:
                    break;
            }
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_stalagg(Creature *_Creature)
{
    return new boss_stalaggAI(_Creature);
}

struct boss_feugenAI : public BossAI
{
    boss_feugenAI(Creature *c): BossAI(c, DATA_FEUGEN) {}

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        // proper timers
        events.ScheduleEvent(EVENT_PULL_TANK, 20500);

        // guessed timers, to FIX
        events.ScheduleEvent(EVENT_MANA_BURN, 10000);
        events.ScheduleEvent(EVENT_WAR_STOMP, 30000);

        me->RemoveAurasDueToSpell(SPELL_TESLA_PASSIVE_F);
    }

    void EnterEvadeMode()
    {
        if (Creature *pStalagg = instance->GetCreature(instance->GetData64(DATA_STALAGG)))
            if (!pStalagg->isAlive())
                pStalagg->Respawn();

        CreatureAI::EnterEvadeMode();
    }

    void EnterCombat(Unit*)
    {
        DoScriptText(SAY_FEUG_AGGRO, me);
        ForceSpellCast(SPELL_TESLA_PASSIVE_F, CAST_SELF);
    }

    void KilledUnit(Unit*)
    {
        if (roll_chance_f(20.0f))
            DoScriptText(SAY_FEUG_SLAY, me);
    }

    void JustDied(Unit *pKiller)
    {
        DoScriptText(SAY_FEUG_DEATH, me);

        if (Creature *pStalagg = instance->GetCreature(instance->GetData64(DATA_STALAGG)))
        {
            if (!pStalagg->HealthBelowPct(2))
            {
                me->setDeathState(JUST_DIED);
                me->Respawn();
                return;
            }

            if (pStalagg->isDead())
                if (Creature *pThaddius = instance->GetCreature(instance->GetData64(DATA_THADDIUS)))
                    ((boss_thaddiusAI*) (pThaddius->AI()))->Engage();
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVADE_CHECK, 100.0f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_MANA_BURN:
                {
                    AddSpellToCast(SPELL_MANA_BURN, CAST_SELF);
                    events.ScheduleEvent(EVENT_MANA_BURN, 10000); // guessed timer
                    break;
                }
                case EVENT_WAR_STOMP:
                {
                    AddSpellToCast(SPELL_WAR_STOMP, CAST_SELF);
                    events.ScheduleEvent(EVENT_WAR_STOMP, 15000); // guessed timer
                    break;
                }
                case EVENT_PULL_TANK:
                {
                    AddSpellToCast(SPELL_MAGNETIC_PULL_F, CAST_NULL);
                    events.ScheduleEvent(EVENT_PULL_TANK, 20500);
                    break;
                }
                default:
                    break;
            }
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_feugen(Creature *_Creature)
{
    return new boss_feugenAI(_Creature);
}

void AddSC_boss_thaddius()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_thaddius";
    newscript->GetAI = &GetAI_boss_thaddius;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_feugen";
    newscript->GetAI = &GetAI_mob_feugen;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_stalagg";
    newscript->GetAI = &GetAI_mob_stalagg;
    newscript->RegisterSelf();
}
