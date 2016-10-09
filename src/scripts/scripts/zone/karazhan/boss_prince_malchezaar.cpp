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
SDName: Boss_Prince_Malchezzar
SD%Complete: 100
SDComment:
SDCategory: Karazhan
EndScriptData */

#include "precompiled.h"
#include "def_karazhan.h"
#include "instance_karazhan.h"

#define SAY_AGGRO           -1532091
#define SAY_AXE_TOSS1       -1532092
#define SAY_AXE_TOSS2       -1532093
#define SAY_SPECIAL1        -1532094
#define SAY_SPECIAL2        -1532095
#define SAY_SPECIAL3        -1532096
#define SAY_SLAY1           -1532097
#define SAY_SLAY2           -1532098
#define SAY_SLAY3           -1532099
#define SAY_SUMMON1         -1532100
#define SAY_SUMMON2         -1532101
#define SAY_DEATH           -1532102

//Enfeeble is supposed to reduce hp to 1 and then heal player back to full when it ends
//Along with reducing healing and regen while enfeebled to 0%
//This spell effect will only reduce healing

#define SPELL_ENFEEBLE          30843                       //Enfeeble during phase 1 and 2
#define SPELL_ENFEEBLE_EFFECT   41624

#define SPELL_SHADOWNOVA        30852                       //Shadownova used during all phases

#define SPELL_SW_PAIN_PHASE1    30854                    // Shadow word pain during phase 1
#define SPELL_SW_PAIN_PHASE3    30898                    // Shadow word pain during phase 3


#define SPELL_THRASH_PASSIVE    12787                       //Extra attack chance during phase 2
#define SPELL_SUNDER_ARMOR      30901                       //Sunder armor during phase 2
#define SPELL_THRASH_AURA       3417                        //Passive proc chance for thrash
#define SPELL_EQUIP_AXES        30857                       //Visual for axe equiping
#define SPELL_AMPLIFY_DAMAGE    39095                       //Amplifiy during phase 3
#define SPELL_HELLFIRE          30859                       //Infenals' hellfire aura
#define SPELL_CLEAVE            30131                       //Same as Nightbane.
#define NETHERSPITE_INFERNAL    17646                       //The netherspite infernal creature
#define MALCHEZARS_AXE          17650                       //Malchezar's axes (creatures), summoned during phase 3

#define INFERNAL_MODEL_INVISIBLE 11686                      //Infernal Effects
#define SPELL_INFERNAL_RELAY     30834

#define AXE_EQUIP_MODEL          40066                      //Axes info
#define AXE_EQUIP_INFO           33490690

#define AGGRO_RANGE              28.0

struct boss_malchezaarAI : public ScriptedAI
{
    boss_malchezaarAI(Creature *c) : ScriptedAI(c)
    {
        pInstance =  (instance_karazhan*)c->GetInstanceData();
        m_creature->GetPosition(wLoc);
        m_creature->SetAggroRange(AGGRO_RANGE); 
    }

    instance_karazhan *pInstance;
    uint32 EnfeebleTimer;
    uint32 EnfeebleResetTimer;
    uint32 ShadowNovaTimer;
    uint32 SWPainTimer;
    uint32 SunderArmorTimer;
    uint32 AmplifyDamageTimer;
    uint32 InfernalTimer;
    uint32 AxesTargetSwitchTimer;
    uint32 CheckTimer;
    uint32 Cleave_Timer;

    WorldLocation wLoc;

    uint64 axes[2];
    uint64 enfeeble_targets[5];
    uint64 enfeeble_health[5];

    uint32 phase;

    bool Enabled;

    void Reset()
    {
        AxesCleanup();
        ClearWeapons();
        InfernalCleanup();

        for(int i =0; i < 5; ++i)
            enfeeble_targets[i] = 0;

        EnfeebleTimer = 30000;
        EnfeebleResetTimer = 38000;
        ShadowNovaTimer = 35500;
        SWPainTimer = 20000;
        AmplifyDamageTimer = 5000;
        Cleave_Timer = 8000;
        InfernalTimer = 45000;
        AxesTargetSwitchTimer = urand(7500, 20000);
        CheckTimer = 3000;
        phase = 1;

        if(pInstance)
        {
            GameObject* Door = GameObject::GetGameObject((*m_creature),pInstance->GetData64(DATA_GAMEOBJECT_NETHER_DOOR));
            if(Door)
            {
                Door->SetGoState(GO_STATE_ACTIVE);
            }

            if (pInstance->GetData(DATA_MALCHEZZAR_EVENT) != DONE)
                pInstance->SetData(DATA_MALCHEZZAR_EVENT, NOT_STARTED);
        }

        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        Enabled = false;
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2, SAY_SLAY3), m_creature);
    }

    void JustDied(Unit *victim)
    {
        DoScriptText(SAY_DEATH, m_creature);

        AxesCleanup();
        ClearWeapons();
        InfernalCleanup();

        if(pInstance)
        {
            GameObject* Door = GameObject::GetGameObject((*m_creature),pInstance->GetData64(DATA_GAMEOBJECT_NETHER_DOOR));
            if(Door)
            {
                Door->SetGoState(GO_STATE_ACTIVE);
            }

            pInstance->SetData(DATA_MALCHEZZAR_EVENT, DONE);
        }
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, m_creature);

        if(pInstance)
        {
            GameObject* Door = GameObject::GetGameObject((*m_creature),pInstance->GetData64(DATA_GAMEOBJECT_NETHER_DOOR));
            if(Door)
            {
                Door->SetGoState(GO_STATE_READY);
            }
            pInstance->SetData(DATA_MALCHEZZAR_EVENT, IN_PROGRESS);
        }
    }

    void InfernalCleanup()
    {
        std::list<Creature*> infernalList =  FindAllCreaturesWithEntry(NETHERSPITE_INFERNAL, 300.0f);

        for(std::list<Creature*>::iterator itr = infernalList.begin(); itr!= infernalList.end(); ++itr)
        {
            Creature *infernal = *itr;
            if(infernal)
            {
                infernal->ForcedDespawn();
            }
        }
    }

    void AxesCleanup()
    {
        for(int i=0; i<2;++i)
        {
            Unit *axe = Unit::GetUnit(*m_creature, axes[i]);
            if(axe && axe->isAlive())
                axe->DealDamage(axe, axe->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            axes[i] = 0;
        }
    }

    void ClearWeapons()
    {
        m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, 0);
        m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO, 0);

        m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY+1, 0);
        m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO+2, 0);

        //damage
        const CreatureInfo *cinfo = m_creature->GetCreatureInfo();
        m_creature->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, cinfo->mindmg);
        m_creature->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, cinfo->maxdmg);
        m_creature->UpdateDamagePhysical(BASE_ATTACK);
    }

    void EnfeebleHealthEffect()
    {
        const SpellEntry *info = GetSpellStore()->LookupEntry(SPELL_ENFEEBLE_EFFECT);
        if(!info)
            return;

        std::list<HostilReference *> t_list = m_creature->getThreatManager().getThreatList();
        std::vector<Unit *> targets;

        if(!t_list.size())
            return;

        //begin + 1 , so we don't target the one with the highest threat
        std::list<HostilReference *>::iterator itr = t_list.begin();
        std::advance(itr, 1);
        for( ; itr!= t_list.end(); ++itr)                   //store the threat list in a different container
        {
            Unit *target = Unit::GetUnit(*m_creature, (*itr)->getUnitGuid());
                                                            //only on alive players
            if(target && target->isAlive() && target->GetTypeId() == TYPEID_PLAYER )
                targets.push_back( target);
        }

        //cut down to size if we have more than 5 targets
        while(targets.size() > 5)
            targets.erase(targets.begin()+rand()%targets.size());

        int i = 0;
        for(std::vector<Unit *>::iterator itr = targets.begin(); itr!= targets.end(); ++itr, ++i)
        {
            Unit *target = *itr;
            if(target)
            {
                enfeeble_targets[i] = target->GetGUID();
                enfeeble_health[i] = target->GetHealth();

                target->CastSpell(target, SPELL_ENFEEBLE, true, 0, 0, m_creature->GetGUID());
                target->SetHealth(1);
            }
        }

    }

    void EnfeebleResetHealth()
    {
        for(int i = 0; i < 5; ++i)
        {
            Unit *target = Unit::GetUnit(*m_creature, enfeeble_targets[i]);
            if(target && target->isAlive())
                target->SetHealth(enfeeble_health[i]);
            enfeeble_targets[i] = 0;
            enfeeble_health[i] = 0;
        }
    }

    // Function that returns a valid relay target
    Unit* GetInfernalRelayTarget()
    {
        if (!pInstance)
            return nullptr;

        // Check if the Infernal targets doesn't already have a Netherspite infernal
        std::vector<uint64> lTargetsGuidList;
        pInstance->GetInfernalTargetsList(lTargetsGuidList);

        std::vector<Creature*> vAvailableTargets;
        vAvailableTargets.reserve(lTargetsGuidList.size());

        for (std::vector<uint64>::const_iterator itr = lTargetsGuidList.begin(); itr != lTargetsGuidList.end(); ++itr)
        {
            if (Creature* pInfernalTarget = m_creature->GetMap()->GetCreature(*itr))
            {
                if (!GetClosestCreatureWithEntry(pInfernalTarget, NETHERSPITE_INFERNAL, 5.0f))
                    vAvailableTargets.push_back(pInfernalTarget);
            }
        }

        if (vAvailableTargets.empty())
            return nullptr;

        Creature* pTarget = vAvailableTargets[urand(0, vAvailableTargets.size() - 1)];
        if (pTarget)
            return pTarget;

        return nullptr;
    }

    void SummonInfernal(const uint32 diff)
    {
        if (Creature* pRelay = m_creature->GetMap()->GetCreature(pInstance->GetRelayGuid()))
        {
            if (Unit* pTarget = GetInfernalRelayTarget())
            {
                pRelay->CastSpell(pTarget, SPELL_INFERNAL_RELAY, true, nullptr, nullptr, m_creature->GetObjectGuid());
                DoScriptText(urand(0, 1) ? SAY_SUMMON1 : SAY_SUMMON2, m_creature);
            }
        }
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if(!done_by->IsWithinDistInMap(&wLoc, 95.0f))
        {
            damage = 0;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!Enabled /*&& pInstance->GetData(DATA_OPERA_EVENT) == DONE*/)
        {
            m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            Enabled = true;
        }

        if (!UpdateVictim() )
            return;

        if(CheckTimer < diff)
        {
            if(!m_creature->IsWithinDistInMap(&wLoc, 95.0f))
                DoResetThreat();
            else
                DoZoneInCombat();

            CheckTimer = 3000;
        }else CheckTimer -= diff;

        if(EnfeebleResetTimer)
            if(EnfeebleResetTimer <= diff)                  //Let's not forget to reset that
        {
            EnfeebleResetHealth();
            EnfeebleResetTimer=0;
        }else EnfeebleResetTimer -= diff;

        if(m_creature->hasUnitState(UNIT_STAT_STUNNED))     //While shifting to phase 2 malchezaar stuns himself
            return;

        if(m_creature->GetSelection() != m_creature->getVictimGUID())
            m_creature->SetSelection(m_creature->getVictimGUID());

        if(phase == 1)
        {
            if( (m_creature->GetHealth()*100) / m_creature->GetMaxHealth() < 60)
            {
                m_creature->InterruptNonMeleeSpells(false);

                phase = 2;

                //animation
                DoCast(m_creature, SPELL_EQUIP_AXES);

                //text
                DoScriptText(SAY_AXE_TOSS1, m_creature);

                //passive thrash aura
                m_creature->CastSpell(m_creature, SPELL_THRASH_AURA, true);

                //models
                m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, AXE_EQUIP_MODEL);
                m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO, AXE_EQUIP_INFO);

                m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY+1, AXE_EQUIP_MODEL);
                m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO+2, AXE_EQUIP_INFO);

                //damage
                const CreatureInfo *cinfo = m_creature->GetCreatureInfo();
                m_creature->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, 2*cinfo->mindmg);
                m_creature->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, 2*cinfo->maxdmg);
                m_creature->UpdateDamagePhysical(BASE_ATTACK);

                m_creature->SetBaseWeaponDamage(OFF_ATTACK, MINDAMAGE, cinfo->mindmg);
                m_creature->SetBaseWeaponDamage(OFF_ATTACK, MAXDAMAGE, cinfo->maxdmg);
                //Sigh, updating only works on main attack , do it manually ....
                m_creature->SetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE, cinfo->mindmg);
                m_creature->SetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE, cinfo->maxdmg);

                m_creature->SetAttackTime(OFF_ATTACK, (m_creature->GetAttackTime(BASE_ATTACK)*150)/100);
            }
        }
        else if(phase == 2)
        {
            if( (m_creature->GetHealth()*100) / m_creature->GetMaxHealth() < 30)
            {
                InfernalTimer = 15000;

                phase = 3;

                ClearWeapons();

                //remove thrash
                m_creature->RemoveAurasDueToSpell(SPELL_THRASH_AURA);

                DoScriptText(SAY_AXE_TOSS2, m_creature);

                Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                for(uint32 i=0; i<2; ++i)
                {
                    Creature *axe = m_creature->SummonCreature(MALCHEZARS_AXE, m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
                    if(axe)
                    {
                        axe->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, AXE_EQUIP_MODEL);
                        axe->SetUInt32Value(UNIT_VIRTUAL_ITEM_INFO, AXE_EQUIP_INFO);

                        axe->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        axe->setFaction(m_creature->getFaction());
                        axes[i] = axe->GetGUID();
                        if(target)
                        {
                            axe->AI()->AttackStart(target);
                            // axe->getThreatManager().tauntApply(target); //Taunt Apply and fade out does not work properly
                                                            // So we'll use a hack to add a lot of threat to our target
                            axe->AddThreat(target, 10000000.0f);
                        }
                    }
                }

                if(ShadowNovaTimer > 35000)
                    ShadowNovaTimer = EnfeebleTimer + 5000;

                return;
            }

            if(SunderArmorTimer < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_SUNDER_ARMOR);
                SunderArmorTimer = urand(10000, 18000);

            }else SunderArmorTimer -= diff;

            if(Cleave_Timer < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_CLEAVE);
                Cleave_Timer = urand(6000, 12000);
            }else Cleave_Timer -= diff;
        }
        else
        {
            if(AxesTargetSwitchTimer < diff)
            {
                AxesTargetSwitchTimer = urand(7500, 20000);

                Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                if(target)
                {
                    for(int i = 0; i < 2; ++i)
                    {
                        Unit *axe = Unit::GetUnit(*m_creature, axes[i]);
                        if(axe)
                        {
                            float threat = 1000000.0f;
                            if(axe->getVictim() && DoGetThreat(axe->getVictim()))
                            {
                                threat = axe->getThreatManager().getThreat(axe->getVictim());
                                axe->getThreatManager().modifyThreatPercent(axe->getVictim(), -100);
                            }
                            if(target)
                                axe->AddThreat(target, threat);
                            //axe->getThreatManager().tauntFadeOut(axe->getVictim());
                            //axe->getThreatManager().tauntApply(target);
                        }
                    }
                }
            }
            else
                AxesTargetSwitchTimer -= diff;

            if(AmplifyDamageTimer < diff)
            {
                if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, GetSpellMaxRange(SPELL_AMPLIFY_DAMAGE), true))
                    DoCast(target, SPELL_AMPLIFY_DAMAGE);

                AmplifyDamageTimer = urand(20000, 30000);
            }
            else
                AmplifyDamageTimer -= diff;
        }

        //Time for global and double timers
        if(InfernalTimer < diff)
        {
            SummonInfernal(diff);
            InfernalTimer =  phase == 3 ? 15000 : 45000;    //15 secs in phase 3, 45 otherwise
        }
        else
            InfernalTimer -= diff;

        if(ShadowNovaTimer < diff)
        {
            DoCast(m_creature, SPELL_SHADOWNOVA);
            ShadowNovaTimer = phase == 3 ? 30000 : -1;
        }
        else
            ShadowNovaTimer -= diff;

        if(phase != 2)
        {
            if(SWPainTimer < diff)
            {
                Unit* target = (phase == 1) ? m_creature->getVictim() : (SelectUnit(SELECT_TARGET_RANDOM, 1, GetSpellMaxRange(SPELL_SW_PAIN_PHASE3), true, m_creature->getVictimGUID()));
                CastSWP(target, phase);
                SWPainTimer = 20000;
            }
            else
                SWPainTimer -= diff;
        }

        if(phase != 3)
        {
            if(EnfeebleTimer < diff)
            {
                EnfeebleHealthEffect();
                EnfeebleTimer = 30000;
                ShadowNovaTimer = 5000;
                EnfeebleResetTimer = 9000;
            }
            else
                EnfeebleTimer -= diff;
        }

        if(phase==2)
            DoMeleeAttacksIfReady();
        else
            DoMeleeAttackIfReady();
    }

    void CastSWP(Unit* target, uint32 phase)
    {
        if (target)
        {
            if (phase == 1)
                DoCast(target, SPELL_SW_PAIN_PHASE1);
            else
                DoCast(target, SPELL_SW_PAIN_PHASE3);
        }
    }

    void DoMeleeAttacksIfReady()
    {
        if( m_creature->IsWithinMeleeRange(m_creature->getVictim()) && !m_creature->IsNonMeleeSpellCasted(false))
        {
            //Check for base attack
            if( m_creature->isAttackReady() && m_creature->getVictim() )
            {
                m_creature->AttackerStateUpdate(m_creature->getVictim());
                m_creature->resetAttackTimer();
            }
            //Check for offhand attack
            if( m_creature->isAttackReady(OFF_ATTACK) && m_creature->getVictim() )
            {
                m_creature->AttackerStateUpdate(m_creature->getVictim(), OFF_ATTACK);
                m_creature->resetAttackTimer(OFF_ATTACK);
            }
        }
    }
};

CreatureAI* GetAI_boss_malchezaar(Creature *_Creature)
{
    return new boss_malchezaarAI (_Creature);
}

void AddSC_boss_malchezaar()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_malchezaar";
    newscript->GetAI = &GetAI_boss_malchezaar;
    newscript->RegisterSelf();
}