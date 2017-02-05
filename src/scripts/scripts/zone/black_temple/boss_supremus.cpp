/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/ >
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
SDName: Boss_Supremus
SD%Complete: 95
SDComment: Need to implement molten punch
SDCategory: Black Temple
EndScriptData */

#include "precompiled.h"
#include "def_black_temple.h"

enum
{
    EMOTE_NEW_TARGET    = -1564010,
    EMOTE_PUNCH_GROUND  = -1564011,
    EMOTE_GROUND_CRACK  = -1564012,

    // Spells
    SPELL_MOLTEN_PUNCH      = 40126,
    SPELL_HATEFUL_STRIKE    = 41926,
    SPELL_MOLTEN_FLAME      = 40980,
    SPELL_VOLCANIC_SUMMON   = 40276,
    SPELL_BERSERK           = 45078, 
    SPELL_CHARGE            = 41581, 
    SPELL_DIVE_CUSTOM       = 40279,
    SPELL_SLOW_SELF         = 41922,

    NPC_STALKER             = 23095
};
const float RANGE_START_DASH = 60.0;
const float RANGE_MIN_DASHING = 20.0;
const float SPEED_DASHING = 5.0;
const float SPEED_CHASE = 0.9f;
const float SPEED_NORMAL = 1.7f;

struct boss_supremusAI : public ScriptedAI
{
    boss_supremusAI(Creature *c) : ScriptedAI(c), summons(m_creature)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(worldLocation);

        m_creature->SetAggroRange(50.0f);
    }

    ScriptedInstance* pInstance;

    uint32 MoltenPunchTimer;
    uint32 SwitchTargetTimer;
    uint32 PhaseSwitchTimer;
    uint32 CustomDiveTimer;
    uint32 SummonVolcanoTimer;
    uint32 HatefulStrikeTimer;
    uint32 BerserkTimer;

    WorldLocation worldLocation;

    bool Phase1;

    SummonList summons;

    void Reset()
    {
        ClearCastQueue();

        if (pInstance)
            pInstance->SetData(EVENT_SUPREMUS, NOT_STARTED);

        HatefulStrikeTimer = urand(1500, 5000);
        MoltenPunchTimer = 20000;
        SwitchTargetTimer = urand(10000, 16666);
        CustomDiveTimer = 8000;
        PhaseSwitchTimer = 60000;
        SummonVolcanoTimer = urand(7000, 10000);
        BerserkTimer = 900000;                              // 15 minute enrage

        WorldLocation worldLocation;

        Phase1 = true;
        summons.DespawnAll();

        m_creature->SetSpeed(MOVE_RUN, SPEED_NORMAL);
    }

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();

        if (pInstance)
            pInstance->SetData(EVENT_SUPREMUS, IN_PROGRESS);
    }

    void ToggleDoors(bool close)
    {
        if (!pInstance)
            return;

        if (GameObject* Doors = GameObject::GetGameObject(*m_creature, pInstance->GetData64(DATA_GAMEOBJECT_SUPREMUS_DOORS)))
        {
            if (close)
                Doors->SetGoState(GO_STATE_READY);                   // Closed
            else
                Doors->SetGoState(GO_STATE_ACTIVE);                   // Opened
        }
    }

    void JustDied(Unit *killer)
    {
        if (pInstance)
        {
            pInstance->SetData(EVENT_SUPREMUS, DONE);
            ToggleDoors(false);
        }
        summons.DespawnAll();
    }

    void JustSummoned(Creature *summon)
    {
        summons.Summon(summon);

        if (summon->GetEntry() == NPC_STALKER)
        {
            Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
            if (!pTarget)
                pTarget = m_creature->getVictim();

            if (pTarget)
            {
                summon->GetMotionMaster()->Clear();
                summon->GetMotionMaster()->MoveFollow(pTarget, 0.0f, 0.0f);
                summon->CastSpell(summon, SPELL_MOLTEN_FLAME, false, nullptr, nullptr, m_creature->GetObjectGuid());
            }
        }
    }

    void SummonedCreatureDespawn(Creature *summon) 
    {
        summons.Despawn(summon);
    }

    Unit* CalculateHatefulStrikeTarget()
    {
        uint32 health = 0;
        Unit* target = NULL;

        std::list<HostilReference*>& m_threatlist = m_creature->getThreatManager().getThreatList();
        std::list<HostilReference*>::iterator i = m_threatlist.begin();
        for (i = m_threatlist.begin(); i!= m_threatlist.end();++i)
        {
            Unit* pUnit = Unit::GetUnit((*m_creature), (*i)->getUnitGuid());
            if (pUnit && m_creature->IsWithinMeleeRange(pUnit))
            {
                if (pUnit->GetHealth() > health)
                {
                    health = pUnit->GetHealth();
                    target = pUnit;
                }
            }
        }

        return target;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (BerserkTimer)
        {
            if (BerserkTimer <= diff)
            {
                DoCast(m_creature, SPELL_BERSERK);
                if (m_creature->HasAura(SPELL_BERSERK, 0))
                    BerserkTimer = 0;
            }
            else
                BerserkTimer -= diff;
        }

        if (MoltenPunchTimer <= diff)
        {
            AddSpellToCast(m_creature, SPELL_MOLTEN_PUNCH);
            MoltenPunchTimer = 20000;
        }
        else
            MoltenPunchTimer -= diff;

        if (Phase1)
        {
            if (HatefulStrikeTimer <= diff)
            {
                if (Unit* target = CalculateHatefulStrikeTarget())
                {
                    AddSpellToCast(target, SPELL_HATEFUL_STRIKE);
                    HatefulStrikeTimer = urand(1500, 5000);
                }
            }
            else
                HatefulStrikeTimer -= diff;
        }
        else
        {
            if (SwitchTargetTimer <= diff)
            {
                if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 100, true, m_creature->getVictimGUID()))
                {
                    DoResetThreat();
                    m_creature->getThreatManager().setCurrentVictim((HostilReference*)target);
                    m_creature->AI()->AttackStart(target);
                    m_creature->AddThreat(target, 5000000.0f);
                    DoScriptText(EMOTE_NEW_TARGET, m_creature, 0, true);
                    SwitchTargetTimer = urand(10000, 16666); // He should switch target 3-5 times per phase (first target not included)
                    // If Supremus is very far away from his new target he will charge to it. (Hard to find an exact value here)
                    //if (!m_creature->IsWithinDistInMap(target, 60))
                    //{
                    //    m_creature->GetMotionMaster()->MovementExpired();
                    //    m_creature->CastSpell(target, SPELL_CHARGE, true);
                    //    CustomDiveTimer = urand(8000, 12000); // Give the new target some time to get away if charged
                    //}

                    // Try the cmangos(ish) way of doing the dash 
                    if (m_creature->GetCombatDistance(m_creature->getVictim()) > RANGE_START_DASH)
                    {
                        //m_creature->RemoveAurasDueToSpell(SPELL_SLOW_SELF);
                        m_creature->SetSpeed(MOVE_RUN, SPEED_DASHING);
                    }
                }
            }
            else
                SwitchTargetTimer -= diff;

            // Try the cmangos(ish) way of doing the dash 
            if (m_creature->GetSpeedRate(MOVE_RUN) > SPEED_CHASE && m_creature->GetCombatDistance(m_creature->getVictim()) < RANGE_MIN_DASHING)
            {
                //m_creature->SetSpeed(MOVE_RUN, SPEED_NORMAL);
                //DoCast(m_creature, SPELL_SLOW_SELF);
                m_creature->SetSpeed(MOVE_RUN, SPEED_CHASE);
            }


            //if (CustomDiveTimer <= diff)
            //{
            //    Unit *target = m_creature->getVictim();
            //    float customDiveRange = 30.0 - (m_creature->GetFloatValue(UNIT_FIELD_BOUNDINGRADIUS) / 2); // Since distance is currently calculated from bounding radius in our core
            //    if (target)
            //    {
            //        if (m_creature->IsWithinDistInMap(target, customDiveRange)) 
            //        {
            //            // Workaround to make dmg when distance is < 40yd
            //            // All sources say Molten Punch is the ability that should deal this damage, but Molten Punch has no such effect. (Confusing)
            //            int32 damage = 5600;
            //            int32 knock = 175;
            //            m_creature->GetMotionMaster()->MovementExpired();
            //            m_creature->CastCustomSpell(target, SPELL_DIVE_CUSTOM, NULL, &damage, &knock, false);
            //            m_creature->SetSpeed(MOVE_RUN, SPEED_CHASE);
            //        }
            //    }
            //    CustomDiveTimer = urand(8000,12000);
            //}
            //else
            //    CustomDiveTimer -= diff;

            if (SummonVolcanoTimer <= diff)
            {
                if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 999, true))
                {
                    m_creature->CastSpell(target, SPELL_VOLCANIC_SUMMON, true);
                    SummonVolcanoTimer = urand(7000,10000);
                }
            }
            else
                SummonVolcanoTimer -= diff;
        }

        if (PhaseSwitchTimer <= diff)
        {
            if (!Phase1)
            {
                Phase1 = true;
                DoResetThreat();
                PhaseSwitchTimer = 60000;
                //m_creature->RemoveAurasDueToSpell(SPELL_SLOW_SELF);
                m_creature->SetSpeed(MOVE_RUN, SPEED_NORMAL);
                DoScriptText(EMOTE_PUNCH_GROUND, m_creature, 0, true);
                DoZoneInCombat();
                m_creature->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, false);
            }
            else
            {
                Phase1 = false;
                DoResetThreat();
                SwitchTargetTimer = 1000; // Pick a fixate target right away
                SummonVolcanoTimer = 2000;
                PhaseSwitchTimer = 60000;
                //DoCast(m_creature, SPELL_SLOW_SELF);
                m_creature->SetSpeed(MOVE_RUN, SPEED_CHASE);
                DoScriptText(EMOTE_GROUND_CRACK, m_creature, 0, true);
                DoZoneInCombat();
                m_creature->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
            }
        }
        else
            PhaseSwitchTimer -= diff;

        DoMeleeAttackIfReady();
        CastNextSpellIfAnyAndReady();
    }
};

CreatureAI* GetAI_boss_supremus(Creature *_Creature)
{
    return new boss_supremusAI (_Creature);
}

void AddSC_boss_supremus()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_supremus";
    newscript->GetAI = &GetAI_boss_supremus;
    newscript->RegisterSelf();
}

