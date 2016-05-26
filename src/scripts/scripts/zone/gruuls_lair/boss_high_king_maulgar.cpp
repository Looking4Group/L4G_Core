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
SDName: Boss_High_King_Maulgar
SD%Complete: 90
SDComment:
SDCategory: Gruul's Lair
EndScriptData */

#include "precompiled.h"
#include "def_gruuls_lair.h"

#define SAY_AGGRO               -1565000
#define SAY_ENRAGE              -1565001
#define SAY_OGRE_DEATH1         -1565002
#define SAY_OGRE_DEATH2         -1565003
#define SAY_OGRE_DEATH3         -1565004
#define SAY_OGRE_DEATH4         -1565005
#define SAY_SLAY1               -1565006
#define SAY_SLAY2               -1565007
#define SAY_SLAY3               -1565008
#define SAY_DEATH               -1565009

enum eHKMSpells
{
    SPELL_ARCING_SMASH = 39144,
    SPELL_MIGHTY_BLOW  = 33230,
    SPELL_WHIRLWIND    = 33238,
    SPELL_BERSERKER_C  = 26561,
    SPELL_ROAR         = 16508,
    SPELL_FLURRY       = 33232,
    SPELL_DUAL_WIELD   = 29651
};

enum eHKMEvents
{
    EVENT_ARCING_SMASH = 1,
    EVENT_MIGHTY_BLOW  = 2,
    EVENT_CHARGE_HKM   = 3,
    EVENT_WHIRLWIND    = 4,
    EVENT_ROAR         = 5
};

enum ePhase
{
    PHASE_ONE = 1,
    PHASE_TWO = 2
};

//High King Maulgar AI
struct boss_high_king_maulgarAI : public BossAI
{
    boss_high_king_maulgarAI(Creature *c) : BossAI(c, DATA_MAULGAREVENT) {}

    ePhase _phase;

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        _phase = PHASE_ONE;

        instance->SetData(DATA_MAULGAREVENT, NOT_STARTED);

        events.ScheduleEvent(EVENT_MIGHTY_BLOW, 40000);
        events.ScheduleEvent(EVENT_ARCING_SMASH, 10000);
        events.ScheduleEvent(EVENT_WHIRLWIND, 30000);

        ForceSpellCast(me, SPELL_DUAL_WIELD);
    }

    void KilledUnit()
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2, SAY_SLAY3), me);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, me);
        instance->SetData(DATA_MAULGAREVENT, DONE);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, me);

        instance->SetData(DATA_MAULGAREVENT, IN_PROGRESS);

        DoZoneInCombat();
    }

    void DoAction(const int32 param)
    {
        if (me->isAlive())
            DoScriptText(RAND(SAY_OGRE_DEATH1, SAY_OGRE_DEATH2, SAY_OGRE_DEATH3, SAY_OGRE_DEATH4), me);
    }

    void EnterEvadeMode()
    {
        //if (me->GetFormation())
        //    me->GetFormation()->FormationReset();

        ScriptedAI::EnterEvadeMode();
    }

    void JustReachedHome()
    {
        if (me->GetFormation())
            me->GetFormation()->RespawnFormation(me);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVERYTHING, 200.0f, 1.6f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ARCING_SMASH:
                {
                    AddSpellToCast(SPELL_ARCING_SMASH);
                    events.ScheduleEvent(eventId, 10000);
                    break;
                }
                case EVENT_WHIRLWIND:
                {
                    AddSpellToCast(SPELL_WHIRLWIND, CAST_SELF);
                    events.ScheduleEvent(eventId, 55000);
                    break;
                }
                case EVENT_MIGHTY_BLOW:
                {
                    AddSpellToCast(SPELL_MIGHTY_BLOW);
                    events.ScheduleEvent(eventId, urand(30000, 40000));
                    break;
                }
                case EVENT_CHARGE_HKM:
                {
                    AddSpellToCast(SPELL_BERSERKER_C, CAST_RANDOM);
                    events.ScheduleEvent(eventId, 20000);
                    break;
                }
                case EVENT_ROAR:
                {
                    AddSpellToCast(SPELL_ROAR, CAST_SELF);
                    events.ScheduleEvent(eventId, 20000);
                    break;
                }
            }
        }

        //Entering Phase 2
        if (_phase == PHASE_ONE && HealthBelowPct(50))
        {
            _phase = PHASE_TWO;

            DoScriptText(SAY_ENRAGE, me);

            events.RescheduleEvent(EVENT_WHIRLWIND, 30000);
            events.ScheduleEvent(EVENT_CHARGE_HKM, 2000);
            events.ScheduleEvent(EVENT_ROAR, 3000);

            ForceSpellCast(me, SPELL_DUAL_WIELD);
            ForceSpellCast(me, SPELL_FLURRY);

            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, 0);
            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY+1, 0);
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

enum eOlmEvents
{
    EVENT_DARK_DECAY = 1,
    EVENT_SUMMON     = 2,
    EVENT_DEATH_COIL = 3
};

enum eOlmSpells
{
    SPELL_DARK_DECAY = 33129,
    SPELL_DEATH_COIL = 33130,
    SPELL_SUMMON_WFH = 33131,
};

//Olm The Summoner AI
struct boss_olm_the_summonerAI : public BossAI
{
    boss_olm_the_summonerAI(Creature *c) : BossAI(c, DATA_MAULGAREVENT)
    {
        if (SpellEntry * spell = (SpellEntry*) GetSpellStore()->LookupEntry(SPELL_DEATH_COIL))
            spell->Attributes |= SPELL_ATTR_NEGATIVE_1;
    }

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        events.ScheduleEvent(EVENT_DARK_DECAY, 10000);
        events.ScheduleEvent(EVENT_SUMMON, 15000);
        events.ScheduleEvent(EVENT_DEATH_COIL, 20000);
    }

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();
    }

    void JustDied(Unit* Killer)
    {
        // inform leader about our death
        if (me->GetFormation())
            me->GetFormation()->getLeader()->AI()->DoAction();
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_COMBAT_N_SPEED, 200.0f, 2.0f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_DARK_DECAY:
                {
                    AddSpellToCast(SPELL_DARK_DECAY);
                    events.ScheduleEvent(eventId, 20000);
                    break;
                }
                case EVENT_SUMMON:
                {
                    AddSpellToCast(SPELL_SUMMON_WFH, CAST_SELF);
                    events.ScheduleEvent(eventId, 50000);
                    break;
                }
                case EVENT_DEATH_COIL:
                {
                    AddSpellToCast(SPELL_DEATH_COIL, CAST_RANDOM);
                    events.ScheduleEvent(eventId, 20000);
                    break;
                }
            }
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

enum eKigglerSpells
{
    SPELL_GREATER_POLYMORPH = 33173,
    SPELL_LIGHTNING_BOLT    = 36152,
    SPELL_ARCANE_SHOCK      = 33175,
    SPELL_ARCANE_EXPLOSION  = 33237,
};

enum eKigglerEvents
{
    EVENT_POLYMORPH    = 1,
    EVENT_ARCANE_SHOCK = 2,
    EVENT_ARCANE_EXPLO = 3
};

//Kiggler The Crazed AI
struct boss_kiggler_the_crazedAI : public BossAI
{
    boss_kiggler_the_crazedAI(Creature *c) : BossAI(c, DATA_MAULGAREVENT) {}

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        events.ScheduleEvent(EVENT_POLYMORPH, 5000);
        events.ScheduleEvent(EVENT_ARCANE_SHOCK, 20000);
        events.ScheduleEvent(EVENT_ARCANE_EXPLO, 30000);

        SetAutocast(SPELL_LIGHTNING_BOLT, 2200, true);
    }

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();
        StartAutocast();
    }

    void JustDied(Unit* Killer)
    {
        // inform leader about our death
        if (me->GetFormation())
            me->GetFormation()->getLeader()->AI()->DoAction();
    }

    void AttackStart(Unit* who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_COMBAT_N_SPEED, 200.0f, 1.6f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_POLYMORPH:
                {
                    AddSpellToCast(SPELL_GREATER_POLYMORPH, CAST_RANDOM);
                    events.ScheduleEvent(eventId, 20000);
                    break;
                }
                case EVENT_ARCANE_SHOCK:
                {
                    AddSpellToCast(SPELL_ARCANE_SHOCK);
                    events.ScheduleEvent(eventId, 20000);
                    break;
                }
                case EVENT_ARCANE_EXPLO:
                {
                    AddSpellToCast(SPELL_ARCANE_EXPLOSION, CAST_SELF);
                    events.ScheduleEvent(eventId, 30000);
                    break;
                }
            }
        }

        CheckCasterNoMovementInRange(diff, 42.0f);
        CastNextSpellIfAnyAndReady(diff);
    }
};

enum eBlindEvents
{
    EVENT_HEAL   = 1,
    EVENT_SHIELD = 2
};

enum eBlindSpells
{
    SPELL_GREATER_PW_SHIELD = 33147,
    SPELL_HEAL              = 33144,
    SPELL_PRAYEROFHEALING   = 33152
};

//Blindeye The Seer AI
struct boss_blindeye_the_seerAI : public BossAI
{
    boss_blindeye_the_seerAI(Creature *c) : BossAI(c, DATA_MAULGAREVENT) {}

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        events.ScheduleEvent(EVENT_SHIELD, 15000);
        events.ScheduleEvent(EVENT_HEAL, urand(7000, 10000));
    }

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();
    }

    void JustDied(Unit* Killer)
    {
        // inform leader about our death
        if (me->GetFormation())
            me->GetFormation()->getLeader()->AI()->DoAction();
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_COMBAT_N_SPEED, 200.0f, 1.6f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_HEAL:
                {
                    AddSpellToCast(SPELL_HEAL, CAST_SELF);
                    events.ScheduleEvent(eventId, urand(10000, 35000));
                    break;
                }
                case EVENT_SHIELD:
                {
                    AddSpellToCast(SPELL_GREATER_PW_SHIELD, CAST_SELF);
                    AddSpellToCast(SPELL_PRAYEROFHEALING, CAST_SELF);
                    events.ScheduleEvent(eventId, urand(30000, 40000));
                    break;
                }
            }
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

enum eKroshEvents
{
    EVENT_SPELL_SHIELD = 1,
    EVENT_BLAST_WAVE   = 2
};

enum eKroshSpells
{
    SPELL_GREATER_FIREBALL = 33051,
    SPELL_SPELLSHIELD      = 33054,
    SPELL_BLAST_WAVE       = 33061
};

//Krosh Firehand AI
struct boss_krosh_firehandAI : public BossAI
{
    boss_krosh_firehandAI(Creature *c) : BossAI(c, DATA_MAULGAREVENT) {}

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        events.ScheduleEvent(EVENT_SPELL_SHIELD, 31000);
        events.ScheduleEvent(EVENT_BLAST_WAVE, 5000);

        SetAutocast(SPELL_GREATER_FIREBALL, 4000, true);
    }

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();

        ForceSpellCast(me, SPELL_SPELLSHIELD, INTERRUPT_AND_CAST);
        StartAutocast();
    }

    void AttackStart(Unit* who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
    }

    void JustDied(Unit* Killer)
    {
        // inform leader about our death
        if (me->GetFormation())
            me->GetFormation()->getLeader()->AI()->DoAction();
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_COMBAT_N_SPEED, 200.0f, 1.6f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SPELL_SHIELD:
                {
                    ForceSpellCast(me, SPELL_SPELLSHIELD);
                    events.ScheduleEvent(eventId, 31000);
                    break;
                }
                case EVENT_BLAST_WAVE:
                {
                    if (Unit *pTarget = SelectUnit(SELECT_TARGET_NEAREST, 0, 15.0f, true))
                        ForceSpellCast(SPELL_BLAST_WAVE, CAST_SELF);

                    events.ScheduleEvent(eventId, urand(3000, 5000));
                    break;
                }
            }
        }

        CheckCasterNoMovementInRange(diff, 42.0f);
        CastNextSpellIfAnyAndReady(diff);
    }
};

CreatureAI* GetAI_boss_high_king_maulgar(Creature *_Creature)
{
    return new boss_high_king_maulgarAI (_Creature);
}

CreatureAI* GetAI_boss_olm_the_summoner(Creature *_Creature)
{
    return new boss_olm_the_summonerAI (_Creature);
}

CreatureAI *GetAI_boss_kiggler_the_crazed(Creature *_Creature)
{
    return new boss_kiggler_the_crazedAI (_Creature);
}

CreatureAI *GetAI_boss_blindeye_the_seer(Creature *_Creature)
{
    return new boss_blindeye_the_seerAI (_Creature);
}

CreatureAI *GetAI_boss_krosh_firehand(Creature *_Creature)
{
    return new boss_krosh_firehandAI (_Creature);
}

void AddSC_boss_high_king_maulgar()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_high_king_maulgar";
    newscript->GetAI = &GetAI_boss_high_king_maulgar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_kiggler_the_crazed";
    newscript->GetAI = &GetAI_boss_kiggler_the_crazed;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_blindeye_the_seer";
    newscript->GetAI = &GetAI_boss_blindeye_the_seer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_olm_the_summoner";
    newscript->GetAI = &GetAI_boss_olm_the_summoner;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_krosh_firehand";
    newscript->GetAI = &GetAI_boss_krosh_firehand;
    newscript->RegisterSelf();
}
