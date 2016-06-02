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
#include "time.h"

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

// 19 Coordinates for Infernal spawns
struct InfernalPoint
{
    float x,y;
};

#define INFERNAL_Z  275.5

static InfernalPoint InfernalPoints[] =
{
    {-10922.8, -1985.2},
    {-10916.2, -1996.2},
    {-10932.2, -2008.1},
    {-10948.8, -2022.1},
    {-10958.7, -1997.7},
    {-10971.5, -1997.5},
    {-10990.8, -1995.1},
    {-10989.8, -1976.5},
    {-10971.6, -1973.0},
    {-10955.5, -1974.0},
    {-10939.6, -1969.8},
    {-10958.0, -1952.2},
    {-10941.7, -1954.8},
    {-10943.1, -1988.5},
    {-10948.8, -2005.1},
    {-10984.0, -2019.3},
    {-10932.8, -1979.6},
    {-10932.8, -1979.6},
    {-10935.7, -1996.0}
};

#define TOTAL_INFERNAL_POINTS 19

//Enfeeble is supposed to reduce hp to 1 and then heal player back to full when it ends
//Along with reducing healing and regen while enfeebled to 0%
//This spell effect will only reduce healing

#define SPELL_ENFEEBLE          30843                       //Enfeeble during phase 1 and 2
#define SPELL_ENFEEBLE_EFFECT   41624

#define SPELL_SHADOWNOVA        30852                       //Shadownova used during all phases
#define SPELL_SW_PAIN           30854                       //Shadow word pain during phase 1 and 3 (different targeting rules though)
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
#define AXE_EQUIP_INFO           33448898

//---------Infernal code first
struct netherspite_infernalAI : public Scripted_NoMovementAI
{
    netherspite_infernalAI(Creature *c) : Scripted_NoMovementAI(c) ,
        malchezaarGUID(0), HellfireTimer(0), CleanupTimer(0), point(NULL)
    {
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_CASTING_SPEED, true);
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_HASTE_SPELLS, true);
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STUN, true);
    }

    uint32 HellfireTimer;
    uint32 CleanupTimer;
    uint64 malchezaarGUID;
    InfernalPoint *point;

    void Reset() {}
    void EnterCombat(Unit*) {}
    void MoveInLineOfSight(Unit*) {}
    void AttackStart(Unit*) {}

    void UpdateAI(const uint32 diff)
    {
        if(HellfireTimer)
        {
            if(HellfireTimer <= diff)
            {
                DoCast(m_creature, SPELL_HELLFIRE);
                HellfireTimer = 0;
            }
            else
               HellfireTimer -= diff;
        }

        if (CleanupTimer)
        {
            if (CleanupTimer <= diff)
            {
                Cleanup();
                CleanupTimer = 0;
            }
            else
                CleanupTimer -= diff;
        }
    }

    void KilledUnit(Unit *who)
    {
        if ( Creature *malchezaar = Unit::GetCreature(*m_creature, malchezaarGUID))
            malchezaar->AI()->KilledUnit(who);
    }

    void SpellHit(Unit *who, const SpellEntry *spell)
    {
        if(spell->Id == SPELL_INFERNAL_RELAY)
        {
            m_creature->SetUInt32Value(UNIT_FIELD_DISPLAYID, m_creature->GetUInt32Value(UNIT_FIELD_NATIVEDISPLAYID));
            m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            HellfireTimer = 4000;
            CleanupTimer = 170000;
        }
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetGUID() != malchezaarGUID)
            damage = 0;
    }

    void Cleanup();
};

struct boss_malchezaarAI : public ScriptedAI
{
    boss_malchezaarAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);
    }

    ScriptedInstance *pInstance;
    uint32 EnfeebleTimer;
    uint32 EnfeebleResetTimer;
    uint32 ShadowNovaTimer;
    uint32 SWPainTimer;
    uint32 SunderArmorTimer;
    uint32 AmplifyDamageTimer;
    uint32 InfernalTimer;
    uint32 AxesTargetSwitchTimer;
    uint32 InfernalCleanupTimer;
    uint32 CheckTimer;
    uint32 Cleave_Timer;

    WorldLocation wLoc;

    std::vector<uint64> infernals;
    std::vector<InfernalPoint*> positions;

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
        positions.clear();

        for(int i =0; i < 5; ++i)
            enfeeble_targets[i] = 0;

        for(int i = 0; i < TOTAL_INFERNAL_POINTS; ++i)
            positions.push_back(&InfernalPoints[i]);

        EnfeebleTimer = 30000;
        EnfeebleResetTimer = 38000;
        ShadowNovaTimer = 35000;
        SWPainTimer = 20000;
        AmplifyDamageTimer = 5000;
        Cleave_Timer = 8000;
        InfernalTimer = 45000;
        InfernalCleanupTimer = 47000;
        AxesTargetSwitchTimer = 7500 + rand()%12500;
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
        positions.clear();

        for(int i = 0; i < TOTAL_INFERNAL_POINTS; ++i)
            positions.push_back(&InfernalPoints[i]);

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
        //Infernal Cleanup
        for(std::vector<uint64>::iterator itr = infernals.begin(); itr!= infernals.end(); ++itr)
        {
            Unit *pInfernal = Unit::GetUnit(*m_creature, *itr);
            if(pInfernal && pInfernal->isAlive())
            {
                pInfernal->SetVisibility(VISIBILITY_OFF);
                pInfernal->setDeathState(JUST_DIED);
            }
        }
        infernals.clear();
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

    void SummonInfernal(const uint32 diff)
    {
        InfernalPoint *point = NULL;
        float posX,posY,posZ;
        if( (m_creature->GetMapId() != 532) || positions.empty())
        {
            m_creature->GetRandomPoint(m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), 60, posX, posY, posZ);
        }
        else
        {
            // Generate new seed (For some reason, rand() was generating same number... casusing infernals to spawn same point)
            // Infernals spawning together is still possible 1/19 chance of happening
            srand(time(NULL));
            std::vector<InfernalPoint*>::iterator itr = positions.begin() + rand() % positions.size();
            point = *itr;
            positions.erase(itr);

            posX = point->x;
            posY = point->y;
            posZ = INFERNAL_Z;
        }

        // Change infernal despawn to 180001 (for some reason respawn and despawn of infernal timing would only cause 1 to go off)
        Creature *Infernal = m_creature->SummonCreature(NETHERSPITE_INFERNAL, posX, posY, posZ, 0, TEMPSUMMON_TIMED_DESPAWN, 180001);

        if (Infernal)
        {
            Infernal->SetUInt32Value(UNIT_FIELD_DISPLAYID, INFERNAL_MODEL_INVISIBLE);
            Infernal->setFaction(m_creature->getFaction());
            if(point)
                ((netherspite_infernalAI*)Infernal->AI())->point=point;
            ((netherspite_infernalAI*)Infernal->AI())->malchezaarGUID=m_creature->GetGUID();

            infernals.push_back(Infernal->GetGUID());
            DoCast(Infernal, SPELL_INFERNAL_RELAY);
        }

        DoScriptText(RAND(SAY_SUMMON1, SAY_SUMMON2), m_creature);
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
        if (!Enabled && pInstance->GetData(DATA_OPERA_EVENT) == DONE)
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
                SunderArmorTimer = 15000;

            }else SunderArmorTimer -= diff;

            if(Cleave_Timer < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_CLEAVE);
                Cleave_Timer = 6000 + rand()%6000;
            }else Cleave_Timer -= diff;
        }
        else
        {
            if(AxesTargetSwitchTimer < diff)
            {
                AxesTargetSwitchTimer = 7500 + rand()%12500 ;

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

                AmplifyDamageTimer = 20000 + rand()%10000;
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
            ShadowNovaTimer = phase == 3 ? 35000 : -1;
        }
        else
            ShadowNovaTimer -= diff;

        if(phase != 2)
        {
            if(SWPainTimer < diff)
            {
                Unit* target = NULL;
                if(phase == 1)
                    target = m_creature->getVictim();       // the tank
                else                                        //anyone but the tank
                    target = SelectUnit(SELECT_TARGET_RANDOM, 1, GetSpellMaxRange(SPELL_SW_PAIN), true, m_creature->getVictimGUID());

                if (target)
                    DoCast(target, SPELL_SW_PAIN);

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

    void Cleanup(Creature *infernal, InfernalPoint *point)
    {
        for(std::vector<uint64>::iterator itr = infernals.begin(); itr!= infernals.end(); ++itr)
            if(*itr == infernal->GetGUID())
        {
            infernals.erase(itr);
            break;
        }

        positions.push_back(point);
    }
};

void netherspite_infernalAI::Cleanup()
{
    Unit *pMalchezaar = Unit::GetUnit(*m_creature, malchezaarGUID);

    if(pMalchezaar && pMalchezaar->isAlive())
        ((boss_malchezaarAI*)((Creature*)pMalchezaar)->AI())->Cleanup(m_creature, point);
}

CreatureAI* GetAI_netherspite_infernal(Creature *_Creature)
{
    return new netherspite_infernalAI (_Creature);
}

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

    newscript = new Script;
    newscript->Name="netherspite_infernal";
    newscript->GetAI = &GetAI_netherspite_infernal;
    newscript->RegisterSelf();
}

