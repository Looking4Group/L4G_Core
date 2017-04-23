/*
 * Copyright (C) 2005-2008 MaNGOS <http://www.mangosproject.org/>
 *
 * Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
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

#include "PetAI.h"
#include "Log.h"
#include "Pet.h"
#include "Player.h"
#include "DBCStores.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "ObjectAccessor.h"
#include "SpellMgr.h"
#include "Creature.h"
#include "Util.h"
#include "BattleGround.h"
#include "BattleGroundMgr.h"

int PetAI::Permissible(const Creature *creature)
{
    if (creature->isPet())
        return PERMIT_BASE_SPECIAL;

    return PERMIT_BASE_NO;
}

PetAI::PetAI(Creature *c) : CreatureAI(c), i_tracker(TIME_INTERVAL_LOOK), m_forceTimer(0)
{
    m_AllySet.clear();
    m_owner = me->GetCharmerOrOwner();

    targetHasCC = false;

    UpdateAllies();
}

void PetAI::EnterEvadeMode()
{
}

bool PetAI::targetHasInterruptableAura(Unit *target) const
{
    if (!target)
        return false;

    if (m_forceTimer)
        return false;

    Unit::AuraMap const &auramap = target->GetAuras();
    for (Unit::AuraMap::const_iterator itr = auramap.begin(); itr != auramap.end(); ++itr)
    {
        if (itr->second && (itr->second->GetSpellProto()->AuraInterruptFlags & (AURA_INTERRUPT_FLAG_DIRECT_DAMAGE | AURA_INTERRUPT_FLAG_HITBYSPELL | AURA_INTERRUPT_FLAG_DAMAGE)))
            return true;
    }
    return false;
}

bool PetAI::_needToStop()
{
    // This is needed for charmed creatures, as once their target was reset other effects can trigger threat
    if (me->isCharmed() && me->getVictim() == me->GetCharmer() ||
    (me->GetOwner() && me->GetOwner()->isInSanctuary() &&  me->getVictim()->GetCharmerOrOwnerPlayerOrPlayerItself()))
        return true;

    //if (_CheckTargetCC(me->getVictim()) && !targetHasCC)
        //return true;

    if (me->GetOwner() && me->getVictim() && (me->getVictim()->GetTypeId() == TYPEID_PLAYER && me->GetOwner()->GetTypeId() == TYPEID_PLAYER))
        if (me->GetOwner()->IsInRaidWith(me->getVictim()) && (me->GetOwner()->ToPlayer()->GetBGTeam() == me->getVictim()->ToPlayer()->GetBGTeam()))
            return true;

    return targetHasInterruptableAura(me->getVictim()) || !me->canAttack(me->getVictim());
}

void PetAI::_stopAttack()
{
    if (!me->isAlive())
    {
        DEBUG_LOG("Creature stoped attacking cuz his dead [guid=%u]", me->GetGUIDLow());

        me->GetMotionMaster()->MoveIdle();
        me->CombatStop();
        me->getHostilRefManager().deleteReferences();

        return;
    }

    UpdateMotionMaster();

    me->CombatStop();
}

void PetAI::UpdateMotionMaster()
{
    if (m_owner && me->GetCharmInfo() && me->GetCharmInfo()->HasCommandState(COMMAND_FOLLOW) && !m_creature->hasUnitState(UNIT_STAT_CASTING))
        me->GetMotionMaster()->MoveFollow(m_owner,PET_FOLLOW_DIST,PET_FOLLOW_ANGLE);
    else
        me->GetMotionMaster()->MoveIdle();
}

void PetAI::PrepareSpellForAutocast(uint32 spellID)
{
    if (!spellID)
        return;

    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellID);
    if (!spellInfo)
        return;

    bool inCombat = me->getVictim();

    // ignore some combinations of combat state and combat/noncombat spells
    if (!inCombat)
    {
        if (!SpellMgr::IsPositiveSpell(spellInfo->Id))
            return;
    }
    else
    {
        if (SpellMgr::IsNonCombatSpell(spellInfo))
            return;
    }
/*
    if (m_owner && m_owner->GetTypeId() == TYPEID_PLAYER)
        if(((Player*)m_owner)->HasSpellCooldown(spellID))
            return;
*/
    Spell *spell = new Spell(me, spellInfo, false, 0);

    if (inCombat && !me->hasUnitState(UNIT_STAT_FOLLOW) && spell->CanAutoCast(me->getVictim()))
    {
        m_targetSpellStore.push_back(std::make_pair/*<Unit*, Spell*>*/(me->getVictim(), spell));
        return;
    }
    else
    {

        bool spellUsed = false;
        for (std::set<uint64>::iterator tar = m_AllySet.begin(); tar != m_AllySet.end(); ++tar)
        {
            Unit* Target = me->GetMap()->GetUnit(*tar);

            //only buff targets that are in combat, unless the spell can only be cast while out of combat
            if (!Target)
                continue;

            if (spell->CanAutoCast(Target))
            {
                m_targetSpellStore.push_back(std::make_pair/*<Unit*, Spell*>*/(Target, spell));
                spellUsed = true;
                break;
            }
        }
        if (!spellUsed)
            delete spell;
    }
}

void PetAI::AddSpellForAutocast(uint32 spellID, Unit* target)
{
    if (!spellID)
        return;

    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellID);
    if (!spellInfo)
        return;

    Spell *spell = new Spell(me, spellInfo, false, 0);
    if (spell->CanAutoCast(target))
        m_targetSpellStore.push_back(std::make_pair/*<Unit*, Spell*>*/(target, spell));
    else
        delete spell;
}

void PetAI::AutocastPreparedSpells()
{
    //found units to cast on to
    if (!m_targetSpellStore.empty())
    {
        uint32 index = urand(0, m_targetSpellStore.size() - 1);

        Spell* spell  = m_targetSpellStore[index].second;
        Unit*  target = m_targetSpellStore[index].first;

        if (!m_creature->isInCombat())
        {
            switch (spell->GetSpellInfo()->Id)
            {
                //Spurt 1-3
                case 23110:
                case 23109:
                case 23099:
                //Sturzflug 1-3
                case 23145:
                case 23147:
                case 23148:
                //Wutgeheul 1-4
                case 24604:
                case 24605:
                case 24603:
                case 24597:                
                    return;
                    break;
            }
        }

        m_targetSpellStore.erase(m_targetSpellStore.begin() + index);

        SpellCastTargets targets;

        if (!target || !target->isAlive() || !me->IsWithinLOSInMap(target))
            return;
        
        targets.setUnitTarget(target);
        if (!me->HasInArc(M_PI, target))
        {
            me->SetInFront(target);
            if (target->GetTypeId() == TYPEID_PLAYER)
                me->SendCreateUpdateToPlayer((Player*)target);

            if (m_owner && m_owner->GetTypeId() == TYPEID_PLAYER)
                me->SendCreateUpdateToPlayer((Player*)m_owner);
        }

        me->AddCreatureSpellCooldown(spell->GetSpellInfo()->Id);

        if (me->isPet())
            ((Pet*)me)->CheckLearning(spell->GetSpellInfo()->Id);

        spell->prepare(&targets);
    }

    while (!m_targetSpellStore.empty())
    {
        Spell *temp = m_targetSpellStore.begin()->second;
        m_targetSpellStore.erase(m_targetSpellStore.begin());
        delete temp;
    }
}

void PetAI::MovementInform(uint32 type, uint32 data)
{
    if (type != CHASE_MOTION_TYPE || data != 2) // target reached only
        return;

    if (Unit *target = me->getVictim())
        if (target->getVictim() && target->getVictim() != me && target->isInFront(me, 7.0f, M_PI))
        {
            float x, y, z;
            target->GetGroundPointAroundUnit(x, y, z, target->GetObjectSize(), M_PI);
            me->GetMotionMaster()->MovePoint(0, x, y, z);
        }
}

void PetAI::UpdateAI(const uint32 diff)
{
    m_owner = me->GetCharmerOrOwner();
    Unit* owner = m_creature->GetCharmerOrOwner();
    // quest support - Razorthorn Ravager, switch to ScriptedAI when charmed and not in combat
    if (me->GetEntry() == 24922 && me->isCharmed() && !me->isInCombat())
        me->NeedChangeAI = true;

    updateAlliesTimer.Update(diff);
    if (updateAlliesTimer.Passed())
        UpdateAllies();

    if (m_forceTimer)
    {
        if (m_forceTimer < diff)
            m_forceTimer = 0;
        else
            m_forceTimer -= diff;
    }

    if (m_creature->getVictim())
    {
        if (_needToStop())
        {            
            _stopAttack();
            return;
        }

        bool meleeReach = m_creature->IsWithinMeleeRange(m_creature->getVictim());

        if (m_creature->IsStopped() || meleeReach)
        {
            // required to be stopped cases
            if (m_creature->IsStopped() && m_creature->IsNonMeleeSpellCasted(false))
            {
                if (m_creature->hasUnitState(UNIT_STAT_FOLLOW) && !m_creature->hasUnitState(UNIT_STAT_CASTING) && me->GetCurrentSpellId() != 6358)
                    m_creature->InterruptNonMeleeSpells(false);
                else
                    return;
            }

            //targetHasCC = _CheckTargetCC(me->getVictim());
            // not required to be stopped case

            if (me->GetCurrentSpellId() != 6358 && !m_creature->hasUnitState(UNIT_STAT_CASTING))
                DoMeleeAttackIfReady();
            
            if (!m_creature->getVictim())
                return;

            // if pet misses its target, it will also be the first in threat list
            m_creature->getVictim()->AddThreat(m_creature, 1.0);

            if (_needToStop() && m_creature->getVictim()->HasAura(6358))
                _stopAttack();
        }
    }
    else if (owner && m_creature->GetCharmInfo())
    {
        if (owner->isInCombat() && !(m_creature->HasReactState(REACT_PASSIVE) || m_creature->GetCharmInfo()->HasCommandState(COMMAND_STAY)))
        {
            Unit *target =NULL;
            target = owner->getAttackerForHelper();
            if (!target)
            {
                target = m_creature->getAttackerForHelper();
            }
            if (target && !m_creature->hasUnitState(UNIT_STAT_CASTING)){
                AttackStart(target);
            }
            else
            {
                std::list<HostilReference*>& m_threatlist = m_creature->getThreatManager().getThreatList();
                std::list<HostilReference*>::iterator itr;

                for(itr = m_threatlist.begin(); itr != m_threatlist.end(); ++itr)
                {
                    Unit* pUnit = NULL;
                    pUnit = Unit::GetUnit((*m_creature), (*itr)->getUnitGuid());
                    if(pUnit && pUnit->isAlive() && !me->hasUnitState(UNIT_STAT_CASTING))
                    AttackStart(pUnit);
                }
            }
        }
        else if (m_creature->GetCharmInfo()->HasCommandState(COMMAND_FOLLOW))
        {
            //Do not move while channeling or if beeing stunned/freezed
            if (!(m_creature->GetCurrentSpellProto(CURRENT_CHANNELED_SPELL) 
                && (m_creature->GetCurrentSpellProto(CURRENT_CHANNELED_SPELL)->ChannelInterruptFlags & CHANNEL_INTERRUPT_FLAG_INTERRUPT)))
                if (!m_creature->hasUnitState(UNIT_STAT_FOLLOW)
                    && !m_creature->hasUnitState(UNIT_STAT_CAN_NOT_REACT) && !m_creature->hasUnitState(UNIT_STAT_NOT_MOVE))
                {
                    m_creature->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                }
        }
    }

    if (!me->hasUnitState(UNIT_STAT_CASTING) && !(me->GetEntry() == 24922))
    {
        //Autocast
        for (uint8 i = 0; i < me->GetPetAutoSpellSize(); i++)
        {
            uint32 petspell = me->GetPetAutoSpellOnPos(i);
            if (petspell)
                PrepareSpellForAutocast(petspell);
        }

        AutocastPreparedSpells();
    }
}

void PetAI::UpdateAllies()
{
    Group *pGroup = NULL;

    updateAlliesTimer.Reset(10000);                            //update friendly targets every 10 seconds, lesser checks increase performance

    if (!m_owner)
        return;
    else if (m_owner->GetTypeId() == TYPEID_PLAYER)
        pGroup = ((Player*)m_owner)->GetGroup();

    //only pet and owner/not in group->ok
    if (m_AllySet.size() == 2 && !pGroup)
        return;
    //owner is in group; group members filled in already (no raid -> subgroupcount = whole count)
    if (pGroup && !pGroup->isRaidGroup() && m_AllySet.size() == (pGroup->GetMembersCount() + 2))
        return;

    m_AllySet.clear();
    m_AllySet.insert(me->GetGUID());
    if (pGroup)                                              //add group
    {
        for (GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
        {
            Player* Target = itr->getSource();
            if (!Target || !pGroup->SameSubGroup((Player*)m_owner, Target))
                continue;

            m_AllySet.insert(Target->GetGUID());
        }
    }
    else                                                    //remove group
        m_AllySet.insert(m_owner->GetGUID());
}

int ImpAI::Permissible(const Creature *creature)
{
    if (creature->isPet())
        return PERMIT_BASE_SPECIAL;

    return PERMIT_BASE_NO;
}

void ImpAI::AttackStart(Unit *victim)
{
    if (!victim)
        return;

    if (me->Attack(victim, true))
    {
        me->GetMotionMaster()->MoveChase(victim, 0, 0);
        m_chasing = true;
    }
}

void ImpAI::UpdateAI(const uint32 diff)
{
    if (!me->isAlive())
        return;

    m_owner = me->GetCharmerOrOwner();

    updateAlliesTimer.Update(diff);
    if (updateAlliesTimer.Passed())
        UpdateAllies();

    if (m_forceTimer)
    {
        if (m_forceTimer < diff)
            m_forceTimer = 0;
        else
            m_forceTimer -= diff;
    }

   // me->getVictim() can't be used for check in case stop fighting, me->getVictim() clear at Unit death etc.
    if (Unit *target = me->getVictim())
    {
        if (_needToStop())
        {
            DEBUG_LOG("Pet AI stoped attacking [guid=%u]", me->GetGUIDLow());
            _stopAttack();
            return;
        }
        float dist = me->GetDistance2d(target);
        if (dist < 30 && m_chasing)
        {
            me->clearUnitState(UNIT_STAT_FOLLOW);
            me->GetMotionMaster()->MoveIdle();
            m_chasing = false;
        }
        if (dist > 30 && !m_chasing)
        {
            me->GetMotionMaster()->MoveChase(target);
            m_chasing = true;
        }
    }
    else
    {
        if (me->isInCombat())
        {
            if (!m_owner|| !m_owner->GetObjectGuid().IsPlayer())
                _stopAttack();
        }
        else if (m_owner && me->GetCharmInfo()) //no victim
        {
            if (m_owner->isInCombat() && !(me->HasReactState(REACT_PASSIVE) || me->GetCharmInfo()->HasCommandState(COMMAND_STAY)))
                AttackStart(m_owner->getAttackerForHelper());
            else if (me->GetCharmInfo()->HasCommandState(COMMAND_FOLLOW) && !me->hasUnitState(UNIT_STAT_FOLLOW) && !m_creature->hasUnitState(UNIT_STAT_CASTING))
                me->GetMotionMaster()->MoveFollow(m_owner,PET_FOLLOW_DIST,PET_FOLLOW_ANGLE);
        }
    }

    if (!me->GetCharmInfo())
        return;

    if (!me->hasUnitState(UNIT_STAT_CASTING))
    {
        //Autocast
        for (uint8 i = 0; i < me->GetPetAutoSpellSize(); i++)
            PrepareSpellForAutocast(me->GetPetAutoSpellOnPos(i));

        AutocastPreparedSpells();
    }
}

int FelhunterAI::Permissible(const Creature *creature)
{
    if (creature->isPet())
        return PERMIT_BASE_SPECIAL;

    return PERMIT_BASE_NO;
}

void FelhunterAI::PrepareSpellForAutocast(uint32 spellID)
{
    if (!spellID)
        return;

    if (sSpellMgr.GetFirstSpellInChain(spellID) == 19505) // Devour Magic
    {
        SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellID);
        Unit *target = me->getVictim();
        if (!spellInfo || !target)
            return;
        Unit::AuraMap const& auras = target->GetAuras();
        for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
        {
            Aura *aur = (*itr).second;
            if (aur && aur->GetSpellProto()->Dispel == DISPEL_MAGIC)
            {
                if (aur->IsPositive())
                {
                    AddSpellForAutocast(spellID, target);
                    return;
                }
            }
        }
    }
    else
        PetAI::PrepareSpellForAutocast(spellID);
}

bool PetAI::_CheckTargetCC(Unit *target)
{
    if (!target)
        return false;

    if (target->HasCCAura())
        return true;

    return false;
}

