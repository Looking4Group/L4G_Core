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

#ifndef LOOKING4GROUP_CREATUREAI_H
#define LOOKING4GROUP_CREATUREAI_H

#include "UnitAI.h"
#include "Common.h"

class Unit;
class Creature;
class Player;
class Aura;
struct SpellEntry;
class WorldObject;

#define TIME_INTERVAL_LOOK   5000
#define VISIBILITY_RANGE    10000

//Spell targets used by SelectSpell
enum SelectTargetType
{
    SELECT_TARGET_DONTCARE = 0,                             //All target types allowed

    SELECT_TARGET_SELF,                                     //Only Self casting

    SELECT_TARGET_SINGLE_ENEMY,                             //Only Single Enemy
    SELECT_TARGET_AOE_ENEMY,                                //Only AoE Enemy
    SELECT_TARGET_ANY_ENEMY,                                //AoE or Single Enemy

    SELECT_TARGET_SINGLE_FRIEND,                            //Only Single Friend
    SELECT_TARGET_AOE_FRIEND,                               //Only AoE Friend
    SELECT_TARGET_ANY_FRIEND,                               //AoE or Single Friend
};

//Spell Effects used by SelectSpell
enum SelectEffect
{
    SELECT_EFFECT_DONTCARE = 0,                             //All spell effects allowed
    SELECT_EFFECT_DAMAGE,                                   //Spell does damage
    SELECT_EFFECT_HEALING,                                  //Spell does healing
    SELECT_EFFECT_AURA,                                     //Spell applies an aura
};

//Selection method used by SelectTarget
enum SCEquip
{
    EQUIP_NO_CHANGE = -1,
    EQUIP_UNEQUIP   = 0
};

class LOOKING4GROUP_IMPORT_EXPORT CreatureAI : public UnitAI
{
    protected:
        Creature * const me;
        Creature * const m_creature;

        bool UpdateVictim();
        bool UpdateVictimWithGaze();
        bool UpdateCombatState();

        void SelectNearestTarget(Unit *who);

        void SetGazeOn(Unit *target);

        Creature *DoSummon(uint32 uiEntry, const WorldLocation &pos, uint32 uiDespawntime = 30000, TempSummonType uiType = TEMPSUMMON_CORPSE_TIMED_DESPAWN);
        Creature *DoSummon(uint32 uiEntry, WorldObject *obj, float fRadius = 5.0f, uint32 uiDespawntime = 30000, TempSummonType uiType = TEMPSUMMON_CORPSE_TIMED_DESPAWN);
        Creature *DoSummonFlyer(uint32 uiEntry, WorldObject *obj, float fZ, float fRadius = 5.0f, uint32 uiDespawntime = 30000, TempSummonType uiType = TEMPSUMMON_CORPSE_TIMED_DESPAWN);

    public:
        explicit CreatureAI(Creature *c) : UnitAI((Unit*)c), me(c), m_creature(c), m_MoveInLineOfSight_locked(false) {}

        virtual ~CreatureAI() {}

        ///== Reactions At =================================

        // Called if IsVisible(Unit *who) is true at each *who move, reaction at visibility zone enter
        void MoveInLineOfSight_Safe(Unit *who);

         // Called for reaction at stopping attack at no attackers or targets
        virtual void EnterEvadeMode();

        // Called for reaction at enter to combat if not in combat yet (enemy can be NULL)
        virtual void EnterCombat(Unit* /*enemy*/) {}

        // Called at any Damage from any attacker (before damage apply)
        // Note: it for recalculation damage or special reaction at damage
        // for attack reaction use AttackedBy called for not DOT damage in Unit::DealDamage also
        virtual void DamageTaken(Unit *done_by, uint32 & /*damage*/) {}

        // Called when the creature is killed
        virtual void JustDied(Unit *) {}

        // Called when the creature kills a unit
        virtual void KilledUnit(Unit *) {}

        // Called when the creature summon successfully other creature
        virtual void JustSummoned(Creature*) {}
        virtual void IsSummonedBy(Unit *summoner) {}

        virtual void SummonedCreatureDespawn(Creature* /*unit*/) {}

        // Called when hit by a spell
        virtual void SpellHit(Unit*, const SpellEntry*) {}

        // Called when aura is applied
        virtual void OnAuraApply(Aura* aura, Unit* caster, bool addStack) {}

        // Called when aura is removed
        virtual void OnAuraRemove(Aura* aur, bool removeStack) {}

        // Called when spell hits a target
        virtual void SpellHitTarget(Unit* target, const SpellEntry*) {}

        //Called when creature deals damage to player
        virtual void DamageMade(Unit* target, uint32 & , bool direct_damage, uint8 school_mask) {}

        // Called when the creature is target of hostile action: swing, hostile spell landed, fear/etc)
        //virtual void AttackedBy(Unit* attacker);
        virtual bool IsEscorted() { return false; }

        // Called when creature is spawned or respawned (for reseting variables)
        virtual void JustRespawned() {}

        // Called at waypoint reached or point movement finished
        virtual void MovementInform(uint32 /*MovementType*/, uint32 /*Data*/) {}

        void OnCharmed(bool apply);

        //virtual void SpellClick(Player *player) {}
 
        // Called at reaching home after evade
        virtual void JustReachedHome() {}
 
        void DoZoneInCombat(float max_dist = 200.0f);
 
        // Called at text emote receive from player 
        virtual void ReceiveEmote(Player* pPlayer, uint32 text_emote) {}
        virtual void ReceiveScriptText(WorldObject *pSource, int32 iTextEntry) {}

        ///== Triggered Actions Requested ==================
 
        // Called when creature attack expected (if creature can and no have current victim)
        // Note: for reaction at hostile action must be called AttackedBy function.
        //virtual void AttackStart(Unit *) {}

        // Called at World update tick
        //virtual void UpdateAI(const uint32 diff) {}

        ///== State checks =================================

        // Is unit visible for MoveInLineOfSight
        //virtual bool IsVisible(Unit *) const { return false; }

        // Called when victim entered water and creature can not enter water
        //virtual bool canReachByRangeAttack(Unit*) { return false; }

        ///== Fields =======================================

        // Pointer to controlled by AI creature
        //Creature* const m_creature;

        virtual uint32 GetData(uint32 /*id = 0*/) { return 0; }
        virtual void SetData(uint32 /*id*/, uint32 /*value*/) {}
        virtual void SetGUID(uint64 /*guid*/, int32 /*id*/ = 0) {}
        virtual uint64 GetGUID(int32 /*id*/ = 0) { return 0; }

        virtual void PassengerBoarded(Unit *who, int8 seatId, bool apply) {}
        bool _EnterEvadeMode();

    protected:
        virtual void MoveInLineOfSight(Unit *);


    private:
        bool m_MoveInLineOfSight_locked;
};

enum Permitions
{
    PERMIT_BASE_NO                 = -1,
    PERMIT_BASE_IDLE               = 1,
    PERMIT_BASE_REACTIVE           = 100,
    PERMIT_BASE_PROACTIVE          = 200,
    PERMIT_BASE_FACTION_SPECIFIC   = 400,
    PERMIT_BASE_SPECIAL            = 800
};

#endif
