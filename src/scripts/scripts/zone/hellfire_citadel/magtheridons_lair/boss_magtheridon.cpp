/* Copyright(C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
*(at your option) any later version.
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
SDName: Boss_Magtheridon
SD%Complete: 90?
SDComment: In Development
SDCategory: Hellfire Citadel, Magtheridon's lair
EndScriptData */

#include "precompiled.h"
#include "def_magtheridons_lair.h"

enum MagtheridonTexts
{
    MAGT_RANDOM_YELL_1      = -1544000,
    MAGT_RANDOM_YELL_2      = -1544001,
    MAGT_RANDOM_YELL_3      = -1544002,
    MAGT_RANDOM_YELL_4      = -1544003,
    MAGT_RANDOM_YELL_5      = -1544004,
    MAGT_RANDOM_YELL_6      = -1544005,

    MAGT_SAY_FREED              = -1544006,
    MAGT_SAY_AGGRO              = -1544007,
    MAGT_SAY_BANISH             = -1544008,
    MAGT_SAY_CHAMBER_DESTROY    = -1544009,
    MAGT_SAY_PLAYER_KILLED      = -1544010,
    MAGT_SAY_DEATH              = -1544011
};

enum MagtheridonEmotes
{
    MAGTHERIDON_EMOTE_BERSERK       = -1544012,
    MAGTHERIDON_EMOTE_BLASTNOVA     = -1544013,
    MAGTHERIDON_EMOTE_BEGIN         = -1544014
};

enum MagtheridonMobEntries
{
    MOB_MAGTHERIDON         = 17257,
    MOB_MAGTHERIDON_ROOM    = 17516,
    MOB_HELLFIRE_CHANNELLER = 17256,
    MOB_ABYSSAL             = 17454,
    MOB_MAGTHERIDON_TRIGGER = 19703,
    MOB_BLAZE_FIRE          = 100003
};

enum MagtheridonSpells
{
    SPELL_BLASTNOVA             = 30616,
    SPELL_CLEAVE                = 30619,
    SPELL_QUAKE_TRIGGER         = 30576,    // proper trigger for Quake
    SPELL_BLAZE_TARGET          = 30541,
    SPELL_BLAZE_TRAP            = 30542,
    SPELL_DEBRIS_KNOCKDOWN      = 36449,
    SPELL_DEBRIS                = 30632,
    SPELL_DEBRIS_DAMAGE         = 30631,
    SPELL_CAMERA_SHAKE          = 36455,
    SPELL_BERSERK               = 27680,

    SPELL_SHADOW_CAGE           = 30168,
    SPELL_SHADOW_GRASP          = 30410,
    SPELL_SHADOW_GRASP_VISUAL   = 30166,
    SPELL_MIND_EXHAUSTION       = 44032,

    SPELL_SHADOW_CAGE_C         = 30205,
    SPELL_SHADOW_GRASP_C        = 30207,
    SPELL_SOUL_TRANSFER         = 30531,

    SPELL_SHADOW_BOLT_VOLLEY    = 30510,
    SPELL_DARK_MENDING          = 30528,
    SPELL_FEAR                  = 30530,    //39176
    SPELL_BURNING_ABYSSAL       = 30511,

    SPELL_FIRE_BLAST            = 37110
};

enum MagtheridonEvents
{
    MAGTHERIDON_EVENT_CLEAVE        = 1,
    MAGTHERIDON_EVENT_QUAKE         = 2,
    MAGTHERIDON_EVENT_BLAST_NOVA    = 3,
    MAGTHERIDON_EVENT_BLAZE         = 4,
    MAGTHERIDON_EVENT_DEBRIS        = 5,
    MAGTHERIDON_EVENT_BERSERK       = 6
};

// count of clickers needed to interrupt blast nova
#define CLICKERS_COUNT              5

typedef std::map<uint64, uint64> CubeMap;

struct mob_abyssalAI : public ScriptedAI
{
    mob_abyssalAI(Creature *c) : ScriptedAI(c) { }

    uint32 FireBlast_Timer;

    void Reset()
    {
        FireBlast_Timer = 6000;
    }

    void EnterCombat(Unit*)
    {
        DoZoneInCombat();
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (FireBlast_Timer < diff)
        {
            AddSpellToCast(SPELL_FIRE_BLAST, CAST_TANK);
            FireBlast_Timer = urand(5000, 15000);
        }
        else
            FireBlast_Timer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

struct boss_magtheridonAI : public BossAI
{
    boss_magtheridonAI(Creature *c) : BossAI(c, DATA_MAGTHERIDON)
    {
        m_creature->SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, 10);
        m_creature->SetFloatValue(UNIT_FIELD_COMBATREACH, 10);
    }

    uint8 clickersCount;
    uint32 RandChat_Timer;

    bool Phase3;

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        instance->SetData(DATA_COLLAPSE, false);
        instance->SetData(DATA_MAGTHERIDON_EVENT, NOT_STARTED);

        events.ScheduleEvent(MAGTHERIDON_EVENT_BERSERK, 1320000);
        events.ScheduleEvent(MAGTHERIDON_EVENT_BLAST_NOVA, 60000);
        events.ScheduleEvent(MAGTHERIDON_EVENT_BLAZE, urand(10000, 30000));
        events.ScheduleEvent(MAGTHERIDON_EVENT_CLEAVE, 15000);
        events.ScheduleEvent(MAGTHERIDON_EVENT_QUAKE, 40000);

        RandChat_Timer = 90000;

        Phase3 = false;

        clickersCount = 0;

        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2);
        me->CastSpell(me, SPELL_SHADOW_CAGE_C, true);
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(MAGT_SAY_PLAYER_KILLED, me);
    }

    void JustDied(Unit* Killer)
    {
        instance->SetData(DATA_MAGTHERIDON_EVENT, DONE);

        DoScriptText(MAGT_SAY_DEATH, me);
    }

    void MoveInLineOfSight(Unit*) {}

    void AttackStart(Unit *who)
    {
        if (!me->HasAura(SPELL_SHADOW_CAGE_C, 0))
            ScriptedAI::AttackStart(who);
    }

    void EnterCombat(Unit *who)
    {
        instance->SetData(DATA_MAGTHERIDON_EVENT, IN_PROGRESS);
        DoZoneInCombat();
        DoScriptText(MAGTHERIDON_EMOTE_BEGIN, me, me, true);
   }

    void OnAuraRemove(Aura* aur, bool removeStack)
    {
        switch (aur->GetId())
        {
            case SPELL_SHADOW_CAGE_C:
                m_creature->SetHealth(m_creature->GetMaxHealth());
                DoResetThreat();
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2);
                DoScriptText(MAGT_SAY_FREED, me);
                break;
            case SPELL_SHADOW_GRASP:
                if (--clickersCount < 5 && me->HasAura(SPELL_SHADOW_CAGE))
                    m_creature->RemoveAurasDueToSpell(SPELL_SHADOW_CAGE);
                break;
            default:
                break;
        }
    }

    void OnAuraApply(Aura * aur, Unit * caster, bool stackApply)
    {
        if (aur->GetId() == SPELL_SHADOW_GRASP)
        {
            if (++clickersCount == 5)
            {
                DoScriptText(MAGT_SAY_BANISH, m_creature);
                m_creature->CastSpell(m_creature, SPELL_SHADOW_CAGE, true);
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
        {
            if (RandChat_Timer < diff)
            {
                DoScriptText(RAND(MAGT_RANDOM_YELL_1, MAGT_RANDOM_YELL_2, MAGT_RANDOM_YELL_3, MAGT_RANDOM_YELL_4, MAGT_RANDOM_YELL_5, MAGT_RANDOM_YELL_6), m_creature);
                RandChat_Timer = 90000;
            }
            else
                RandChat_Timer -= diff;

            return;
        }

        DoSpecialThings(diff, DO_COMBAT_N_EVADE, 100.0f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case MAGTHERIDON_EVENT_CLEAVE:
                {
                    AddSpellToCast(SPELL_CLEAVE, CAST_TANK);
                    events.ScheduleEvent(MAGTHERIDON_EVENT_CLEAVE, 10000);
                    break;
                }
                case MAGTHERIDON_EVENT_QUAKE:
                {
                    AddSpellToCast(SPELL_QUAKE_TRIGGER, CAST_SELF);
                    events.ScheduleEvent(MAGTHERIDON_EVENT_QUAKE, 50000);
                    break;
                }
                case MAGTHERIDON_EVENT_BLAST_NOVA:
                {
                    AddSpellToCastWithScriptText(SPELL_BLASTNOVA, CAST_NULL, MAGTHERIDON_EMOTE_BLASTNOVA);
                    events.ScheduleEvent(MAGTHERIDON_EVENT_BLAST_NOVA, 60000);
                    break;
                }
                case MAGTHERIDON_EVENT_BLAZE:
                {
                    Unit * tar = SelectUnit(SELECT_TARGET_RANDOM, 0, 0, true);
                    if (tar){
                        //m_creature->SummonCreature(MOB_BLAZE_FIRE, tar->GetPositionX(), tar->GetPositionY(), tar->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 120000);
                        AddSpellToCast(tar, SPELL_BLAZE_TARGET);
                    }
                    events.ScheduleEvent(MAGTHERIDON_EVENT_BLAZE, urand(20000, 40000));
                    break;
                }
                case MAGTHERIDON_EVENT_DEBRIS:
                {
                    Unit * tar = SelectUnit(SELECT_TARGET_RANDOM, 0, 0, true);
                    if (tar)
                        m_creature->SummonCreature(MOB_MAGTHERIDON_TRIGGER, tar->GetPositionX(), tar->GetPositionY(), tar->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 7500);

                    events.ScheduleEvent(MAGTHERIDON_EVENT_DEBRIS, 10000);
                    break;
                }
                case MAGTHERIDON_EVENT_BERSERK:
                {
                    ForceSpellCastWithScriptText(SPELL_BERSERK, CAST_SELF, MAGTHERIDON_EMOTE_BERSERK);
                    events.ScheduleEvent(MAGTHERIDON_EVENT_BERSERK, 60000);
                    break;
                }
            }
        }

        // don't do rest of script if in earth quake mode :P
        if (m_creature->hasUnitState(UNIT_STAT_STUNNED))
            return;

        if (!Phase3 && HealthBelowPct(30))
        {
            Phase3 = true;
            ForceSpellCastWithScriptText(SPELL_DEBRIS_KNOCKDOWN, CAST_SELF, MAGT_SAY_CHAMBER_DESTROY);
            ForceSpellCast(SPELL_CAMERA_SHAKE, CAST_SELF);
            events.ScheduleEvent(MAGTHERIDON_EVENT_DEBRIS, 10000);

            instance->SetData(DATA_COLLAPSE, true);
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

struct mob_hellfire_channelerAI : public ScriptedAI
{
    mob_hellfire_channelerAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = m_creature->GetInstanceData();
        m_creature->setActive(true);
    }

    ScriptedInstance* pInstance;

    uint32 ShadowBoltVolley_Timer;
    uint32 DarkMending_Timer;
    uint32 Fear_Timer;
    uint32 Infernal_Timer;
    uint32 Check_Timer;

    void Reset()
    {
        ShadowBoltVolley_Timer = urand(8000, 10000);
        DarkMending_Timer = 10000;
        Fear_Timer = urand(15000, 20000);
        Infernal_Timer = urand(10000, 50000);

        Check_Timer = 5000;
    }

    void EnterCombat(Unit *who)
    {
        Creature * magtheridon = me->GetCreature(pInstance->GetData64(DATA_MAGTHERIDON));
        if (magtheridon)
            magtheridon->AI()->DoZoneInCombat();

        me->InterruptNonMeleeSpells(false);
        DoZoneInCombat();
        AttackStart(who);
    }

    void MoveInLineOfSight(Unit*) {}

    void DamageTaken(Unit * /*done_by*/, uint32 & dmg)
    {
        if (dmg > me->GetHealth())
            me->CastSpell(me, SPELL_SOUL_TRANSFER, true);
    }

    void JustReachedHome()
    {
        me->CastSpell((Unit*)NULL, SPELL_SHADOW_GRASP_C, false);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (ShadowBoltVolley_Timer < diff)
        {
            AddSpellToCast(SPELL_SHADOW_BOLT_VOLLEY, CAST_SELF);
            ShadowBoltVolley_Timer = urand(10000, 20000);
        }
        else
            ShadowBoltVolley_Timer -= diff;

        if (DarkMending_Timer < diff)
        {
            Unit * target = SelectLowestHpFriendly(30.0f);
            if (!target && HealthBelowPct(50))
                target = me;

            if (target)
                AddSpellToCast(target, SPELL_DARK_MENDING);

            DarkMending_Timer = urand(10000, 20000);
        }
        else
            DarkMending_Timer -= diff;

        if (Fear_Timer < diff)
        {
            AddSpellToCast(SPELL_FEAR, CAST_RANDOM_WITHOUT_TANK);
            Fear_Timer = urand(25000, 40000);
        }
        else
            Fear_Timer -= diff;

        if (Infernal_Timer)
        {
            if (Infernal_Timer <= diff)
            {
                AddSpellToCast(SPELL_BURNING_ABYSSAL, CAST_RANDOM);
                Infernal_Timer = 0;
            }
            else
                Infernal_Timer -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

struct mob_magtheridon_triggerAI : public Scripted_NoMovementAI
{
    mob_magtheridon_triggerAI(Creature *c) : Scripted_NoMovementAI(c)
    {
        m_creature->setActive(true);
    }

    uint32 debrisTimer;

    void JustRespawned()
    {
        me->CastSpell(me, SPELL_DEBRIS, true);
        debrisTimer = 5000;
    }

    void UpdateAI(const uint32 diff)
    {
        if (debrisTimer)
        {
            if (debrisTimer <= diff)
            {
                me->CastSpell(me, SPELL_DEBRIS_DAMAGE, true);
                debrisTimer = 0;
            }
            else
                debrisTimer -= diff;
        }
    }
};

struct mob_blaze_fireAI : public Scripted_NoMovementAI
{
    mob_blaze_fireAI(Creature *c) : Scripted_NoMovementAI(c)
    {
        m_creature->setActive(true);
    }

    uint32 blazeTimer;

    void JustRespawned()
    {
        me->CastSpell(me, 30757, true);
        blazeTimer = 1000;
    }

    void UpdateAI(const uint32 diff)
    {
        if (blazeTimer)
        {
            if (blazeTimer <= diff)
            {
                me->CastSpell(me, 30757, true);
                blazeTimer = 1000;
            }
            else
                blazeTimer -= diff;
        }
    }
};

//Manticron Cube
bool GOUse_go_Manticron_Cube(Player *player, GameObject* _GO)
{
    ScriptedInstance* pInstance =(ScriptedInstance*)_GO->GetInstanceData();

    if (!pInstance)
        return true;

    if (pInstance->GetData(DATA_MAGTHERIDON_EVENT) != IN_PROGRESS)
        return true;

    Creature *Magtheridon = _GO->GetMap()->GetCreature(pInstance->GetData64(DATA_MAGTHERIDON));

    if (!Magtheridon || !Magtheridon->isAlive())
        return true;

    // if exhausted or already channeling return
    if (player->HasAura(SPELL_MIND_EXHAUSTION, 0) || player->HasAura(SPELL_SHADOW_GRASP))
        return true;

    Unit * owner = _GO->GetOwner();

    if (owner && owner->HasAura(SPELL_SHADOW_GRASP))
        owner->InterruptNonMeleeSpells(false);

    _GO->SetOwnerGUID(player->GetGUID());

    player->InterruptNonMeleeSpells(false);
    player->CastSpell((Unit*)NULL, SPELL_SHADOW_GRASP, false);
    return true;
}

CreatureAI* GetAI_boss_magtheridon(Creature *_Creature)
{
    return new boss_magtheridonAI(_Creature);
}

CreatureAI* GetAI_mob_hellfire_channeler(Creature *_Creature)
{
    return new mob_hellfire_channelerAI(_Creature);
}

CreatureAI* GetAI_mob_abyssalAI(Creature *_Creature)
{
    return new mob_abyssalAI(_Creature);
}

CreatureAI* GetAI_mob_magtheridon_triggerAI(Creature *_Creature)
{
    return new mob_magtheridon_triggerAI(_Creature);
}

CreatureAI* GetAI_mob_blaze_fireAI(Creature *_Creature)
{
    return new mob_blaze_fireAI(_Creature);
}

void AddSC_boss_magtheridon()
{
    Script *newscript;
    newscript = new Script();
    newscript->Name = "boss_magtheridon";
    newscript->GetAI = &GetAI_boss_magtheridon;
    newscript->RegisterSelf();

    newscript = new Script();
    newscript->Name = "mob_hellfire_channeler";
    newscript->GetAI = &GetAI_mob_hellfire_channeler;
    newscript->RegisterSelf();

    newscript = new Script();
    newscript->Name = "go_manticron_cube";
    newscript->pGOUse = &GOUse_go_Manticron_Cube;
    newscript->RegisterSelf();

    newscript = new Script();
    newscript->Name = "mob_abyssal";
    newscript->GetAI = &GetAI_mob_abyssalAI;
    newscript->RegisterSelf();

    newscript = new Script();
    newscript->Name = "mob_magtheridon_trigger";
    newscript->GetAI = &GetAI_mob_magtheridon_triggerAI;
    newscript->RegisterSelf();

    newscript = new Script();
    newscript->Name = "mob_blaze_fire";
    newscript->GetAI = &GetAI_mob_blaze_fireAI;
    newscript->RegisterSelf();
}
