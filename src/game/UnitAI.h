/*
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * Copyright (C) 2008-2009 Trinity <http://www.trinitycore.org/>
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

#ifndef LOOKING4GROUP_UNITAI_H
#define LOOKING4GROUP_UNITAI_H

#include "Platform/Define.h"
#include <list>
#include "Unit.h"

class Unit;
class Player;
struct AISpellInfoType;

//Selection method used by SelectTarget
enum SelectAggroTarget
{
    SELECT_TARGET_RANDOM = 0,                               //Just selects a random target
    SELECT_TARGET_TOPAGGRO,                                 //Selects targes from top aggro to bottom
    SELECT_TARGET_BOTTOMAGGRO,                              //Selects targets from bottom aggro to top
    SELECT_TARGET_NEAREST,
    SELECT_TARGET_FARTHEST,
    SELECT_TARGET_LOWEST_HP,
    SELECT_TARGET_HIGHEST_HP,
};

class LOOKING4GROUP_EXPORT UnitAI
{
    protected:
        Unit * const me;
    public:
        explicit UnitAI(Unit *u) : me(u) {}
        virtual bool CanAIAttack(const Unit *who) const { return true; }
        virtual void AttackStart(Unit *);
        virtual void UpdateAI(const uint32 diff) = 0;

        virtual void InitializeAI() { if (!me->isDead()) Reset(); }

        virtual void Reset() {};

        // Called when unit is charmed
        virtual void OnCharmed(bool apply) = 0;

        virtual bool IsVisible() { return true; }

        // Pass parameters between AI
        virtual void DoAction(const int32 param = 0) {}
        virtual uint32 GetData(uint32 id = 0) { return 0; }
        virtual void SetData(uint32 id, uint32 value) {}
        virtual void SetGUID(const uint64 &guid, int32 id = 0) {}
        virtual uint64 GetGUID(int32 id = 0) { return 0; }

        void AttackStartCaster(Unit *victim, float dist);

        void DoCast(uint32 spellId);
        void DoCast(Unit* victim, uint32 spellId, bool triggered = false);
        void DoCastVictim(uint32 spellId, bool triggered = false);
        void DoCastAOE(uint32 spellId, bool triggered = false);

        bool CanCast(Unit* Target, SpellEntry const *Spell, bool Triggered);

        float DoGetSpellMaxRange(uint32 spellId, bool positive = false);

        bool HasEventAISummonedUnits();
        std::list<uint64> eventAISummonedList;

        void DoMeleeAttackIfReady();
        bool DoSpellAttackIfReady(uint32 spell);

        //Returns friendly unit with the most amount of hp missing from max hp
        Unit* SelectLowestHpFriendly(float range, uint32 MinHPDiff = 1);

        //Returns a list of creatures with specified entry in range
        std::list<Creature*> FindAllCreaturesWithEntry(uint32 entry, float range);

        //Returns a list of all friendly units in grid within range
        std::list<Creature*> FindAllFriendlyInGrid(float range);

        //Returns a list of friendly CC'd units within range
        std::list<Creature*> FindFriendlyCC(float range);

        //Returns a list of all friendly units missing a specific buff within range
        std::list<Creature*> FindFriendlyMissingBuff(float range, uint32 spellid);

        //Returns a list of all units that are flagged as DEAD or CORPSE
        std::list<Unit*> FindAllDeadInRange(float range);

        //Return a list of all players in range
        std::list<Player*> FindAllPlayersInRange(float range, Unit* finder = NULL);

        //Selects a unit from the creature's current aggro list
        Unit* SelectUnit(SelectAggroTarget target, uint32 position = 0, float max_dist = 0, bool playerOnly = false, uint64 excludeGUID = 0, float mind_dist = 0.0f);
        Unit* SelectUnit(SelectAggroTarget targetType, uint32 position, float maxdist, bool playerOnly, Powers powerOnly);

        template <class PREDICATE>
        Unit* SelectUnit(SelectAggroTarget targetType, uint32 position, PREDICATE const& predicate)
        {
            std::list<Unit*> targetList;
            SelectUnitList(targetList, 0, targetType, 0, false);

            for (std::list<Unit*>::iterator itr = targetList.begin(); itr != targetList.end();)
            {
                if (!predicate(*itr))
                    targetList.erase(itr++);
                else
                    ++itr;
            }

            if (targetList.empty())
                return NULL;

            return ReturnTargetHelper(targetType, position, targetList);
        }

        void SelectUnitList(std::list<Unit*> &targetList, uint32 num, SelectAggroTarget target, float dist, bool playerOnly, uint64 exclude = 0, float mindist = 0.0f);

        static AISpellInfoType *AISpellInfo;
        static void FillAISpellInfo();

    private:
        Unit *ReturnTargetHelper(SelectAggroTarget target, uint32 position, std::list<Unit*> &targetList);
};

#endif
