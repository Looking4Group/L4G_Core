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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef LOOKING4GROUP_GRIDNOTIFIERS_H
#define LOOKING4GROUP_GRIDNOTIFIERS_H

#include "ObjectGridLoader.h"
#include "ByteBuffer.h"
#include "UpdateData.h"
#include <iostream>

#include "Corpse.h"
#include "Object.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "Player.h"
#include "Unit.h"
#include "CreatureAI.h"
#include "SpellAuras.h"

class Player;
//class Map;

namespace Looking4group
{
    struct VisibleNotifier
    {
        Camera& _camera;

        UpdateData i_data;
        std::set<WorldObject*> i_visibleNow;
        Player::ClientGUIDs vis_guids;

        VisibleNotifier(Camera &c) : _camera(c), vis_guids(c.GetOwner()->m_clientGUIDs) {}

        void Visit(CameraMapType &m) {}

        template<class T>
        void Visit(GridRefManager<T> &m);

        void SendToSelf(void);
    };

    struct LOOKING4GROUP_EXPORT VisibleChangesNotifier
    {
        WorldObject &_object;

        explicit VisibleChangesNotifier(WorldObject &object) : _object(object) {}

        void Visit(CameraMapType &);

        template<class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED> &) {}
    };

    struct PlayerRelocationNotifier
    {
        Player &_player;
        PlayerRelocationNotifier(Player &pl) : _player(pl) {}

        //void Visit(CameraMapType&);
        void Visit(CreatureMapType&);

        template<class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED>&) {}
    };

    struct CreatureRelocationNotifier
    {
        Creature &_creature;
        CreatureRelocationNotifier(Creature& c) : _creature(c) {}

        void Visit(PlayerMapType&);
        void Visit(CreatureMapType&);

        template<class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED>&) {}
    };

    struct LOOKING4GROUP_EXPORT PacketBroadcaster
    {
        WorldObject &_source;
        WorldPacket *_message;

        typedef std::set<uint64> GUIDSet;
        GUIDSet playerGUIDS;

        float _dist;
        bool _ownTeam;

        PacketBroadcaster(WorldObject&, WorldPacket*, Player* = NULL, float = 0.0f, bool = false);

        void BroadcastPacketTo(Player*);

        void Visit(CameraMapType &);

        template<class SKIP>
        void Visit(GridRefManager<SKIP>&) {}
    };

    struct LOOKING4GROUP_EXPORT ObjectUpdater
    {
        uint32 i_timeDiff;
        explicit ObjectUpdater(const uint32 &diff) : i_timeDiff(diff) {}

        void Visit(PlayerMapType&) {}
        void Visit(CorpseMapType&) {}
        void Visit(CameraMapType&) {}
        void Visit(CreatureMapType &);

        template<class T>
        void Visit(GridRefManager<T> &m);
    };

    struct LOOKING4GROUP_EXPORT DynamicObjectUpdater
    {
        DynamicObject &i_dynobject;
        Unit* i_check;
        DynamicObjectUpdater(DynamicObject &dynobject, Unit* caster) : i_dynobject(dynobject)
        {
            i_check = caster;
            Unit* owner = i_check->GetOwner();
            if (owner)
                i_check = owner;
        }

        template<class T> void Visit(GridRefManager<T> &) {}
        void Visit(CreatureMapType &);
        void Visit(PlayerMapType &);

        void VisitHelper(Unit* target);
    };

#pragma region Searchers
    template<class T, class Check>
    struct LOOKING4GROUP_EXPORT ObjectSearcher
    {
        T* &_object;
        Check &_check;

        ObjectSearcher(T* &result, Check& check) : _object(result), _check(check) {}

        void Visit(GridRefManager<T> &);

        template <class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED> &) {}
    };

    template<class T, class Check>
    struct LOOKING4GROUP_EXPORT ObjectLastSearcher
    {
        T* &_object;
        Check &_check;

        ObjectLastSearcher(T* &result, Check& check) : _object(result), _check(check) {}

        void Visit(GridRefManager<T> &);

        template <class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED> &) {}
    };

    template<class T, class Check>
    struct LOOKING4GROUP_EXPORT ObjectListSearcher
    {
        std::list<T*> &_objects;
        Check& _check;

        ObjectListSearcher(std::list<T*> &objects, Check& check) : _objects(objects), _check(check) {}

        void Visit(GridRefManager<T> &);

        template <class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED> &) {}
    };

    template<class Check>
    struct LOOKING4GROUP_EXPORT UnitSearcher
    {
        Unit* &i_object;
        Check & i_check;

        UnitSearcher(Unit* & result, Check & check) : i_object(result),i_check(check) {}

        void Visit(CreatureMapType &m);
        void Visit(PlayerMapType &m);

        template<class NOT_INTERESTED> void Visit(GridRefManager<NOT_INTERESTED> &) {}
    };

    template<class Check>
    struct LOOKING4GROUP_EXPORT UnitLastSearcher
    {
        Unit* &i_object;
        Check & i_check;

        UnitLastSearcher(Unit* & result, Check & check) : i_object(result),i_check(check) {}

        void Visit(CreatureMapType &m);
        void Visit(PlayerMapType &m);

        template<class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED> &) {}
    };

    template<class Check>
    struct LOOKING4GROUP_EXPORT UnitListSearcher
    {
        std::list<Unit*> &i_objects;
        Check& i_check;

        UnitListSearcher(std::list<Unit*> &objects, Check & check) : i_objects(objects),i_check(check) {}

        void Visit(PlayerMapType &m);
        void Visit(CreatureMapType &m);

        template<class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED> &) {}
    };
#pragma endregion Searchers

#pragma region Workers
    template<class T, class Do>
    struct LOOKING4GROUP_EXPORT ObjectWorker
    {
        Do& _do;

        explicit ObjectWorker(Do& ddo) : _do(ddo) {}

        void Visit(GridRefManager<T> &m)
        {
            for (typename GridRefManager<T>::iterator itr= m.begin(); itr != m.end(); ++itr)
                _do(itr->getSource());
        }

        template <class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED> &) {}
    };

    template<class Do>
    struct LOOKING4GROUP_EXPORT CameraDistWorker
    {
        WorldObject const* i_searcher;
        float i_dist;
        Do& i_do;

        CameraDistWorker(WorldObject const* searcher, float _dist, Do& _do) : i_searcher(searcher), i_dist(_dist), i_do(_do) {}

        void Visit(CameraMapType &m)
        {
            for(CameraMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
                if (itr->getSource()->GetBody()->IsWithinDist(i_searcher, i_dist))
                    i_do(itr->getSource()->GetOwner());
        }

        template<class NOT_INTERESTED>
        void Visit(GridRefManager<NOT_INTERESTED> &) {}
    };

    // CHECKS && DO classes

    // WorldObject check classes
    class CannibalizeObjectCheck
    {
        public:
            CannibalizeObjectCheck(Unit* funit, float range) : i_funit(funit), i_range(range) {}
            bool operator()(Player* u)
            {
                if (i_funit->IsFriendlyTo(u) || u->isAlive() || u->IsTaxiFlying())
                    return false;

                if (i_funit->IsWithinDistInMap(u, i_range))
                    return true;

                return false;
            }
            bool operator()(Corpse* u);
            bool operator()(Creature* u)
            {
                if (i_funit->IsFriendlyTo(u) || u->isAlive() || u->IsTaxiFlying() ||
                    (u->GetCreatureTypeMask() & CREATURE_TYPEMASK_HUMANOID_OR_UNDEAD)==0)
                    return false;

                if (i_funit->IsWithinDistInMap(u, i_range))
                    return true;

                return false;
            }
            template<class NOT_INTERESTED> bool operator()(NOT_INTERESTED*) { return false; }
        private:
            Unit* const i_funit;
            float i_range;
    };

    // WorldObject do classes

    class RespawnDo
    {
        public:
            RespawnDo() {}
            void operator()(Creature* u) const { u->Respawn(); }
            void operator()(GameObject* u) const { u->Respawn(); }
            void operator()(WorldObject*) const {}
            void operator()(Corpse*) const {}
    };

    // GameObject checks

    class GameObjectFocusCheck
    {
        public:
            GameObjectFocusCheck(Unit const* unit,uint32 focusId) : i_unit(unit), i_focusId(focusId) {}
            bool operator()(GameObject* go) const
            {
                if (go->GetGOInfo()->type != GAMEOBJECT_TYPE_SPELL_FOCUS)
                    return false;

                if (go->GetGOInfo()->spellFocus.focusId != i_focusId)
                    return false;

                float dist = (float)((go->GetGOInfo()->spellFocus.dist)/2);

                return go->IsWithinDistInMap(i_unit, dist);
            }
        private:
            Unit const* i_unit;
            uint32 i_focusId;
    };

    // Find the nearest Fishing hole and return true only if source object is in range of hole
    class NearestGameObjectFishingHole
    {
        public:
            NearestGameObjectFishingHole(WorldObject const& obj, float range) : i_obj(obj), i_range(range) {}
            bool operator()(GameObject* go)
            {
                if (go->GetGOInfo()->type == GAMEOBJECT_TYPE_FISHINGHOLE && go->isSpawned() && i_obj.IsWithinDistInMap(go, i_range) && i_obj.IsWithinDistInMap(go, go->GetGOInfo()->fishinghole.radius))
                {
                    i_range = i_obj.GetDistance(go);
                    return true;
                }
                return false;
            }
            float GetLastRange() const { return i_range; }
        private:
            WorldObject const& i_obj;
            float  i_range;

            // prevent clone
            NearestGameObjectFishingHole(NearestGameObjectFishingHole const&);
    };

    // Success at unit in range, range update for next check (this can be use with GameobjectLastSearcher to find nearest GO)
    class NearestGameObjectEntryInObjectRangeCheck
    {
        public:
            NearestGameObjectEntryInObjectRangeCheck(WorldObject const& obj,uint32 entry, float range) : i_obj(obj), i_entry(entry), i_range(range) {}
            bool operator()(GameObject* go)
            {
                if (go->GetEntry() == i_entry && i_obj.IsWithinDistInMap(go, i_range) && go->getLootState() == GO_READY)
                {
                    i_range = i_obj.GetDistance(go);        // use found GO range as new range limit for next check
                    return true;
                }
                return false;
            }
            float GetLastRange() const { return i_range; }
        private:
            WorldObject const& i_obj;
            uint32 i_entry;
            float  i_range;

            // prevent clone this object
            NearestGameObjectEntryInObjectRangeCheck(NearestGameObjectEntryInObjectRangeCheck const&);
    };

    class GameObjectWithDbGUIDCheck
    {
        public:
            GameObjectWithDbGUIDCheck(WorldObject const& obj,uint32 db_guid) : i_obj(obj), i_db_guid(db_guid) {}
            bool operator()(GameObject const* go) const
            {
                return go->GetDBTableGUIDLow() == i_db_guid;
            }
        private:
            WorldObject const& i_obj;
            uint32 i_db_guid;
    };

    // Unit checks

    class AnyUnfriendlyUnitInObjectRangeCheck
    {
        public:
            AnyUnfriendlyUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) : i_obj(obj), i_funit(funit), i_range(range) {}
            bool operator()(Unit* u)
            {
                if (i_obj->GetTypeId()==TYPEID_UNIT || i_obj->GetTypeId()==TYPEID_PLAYER)   // cant target when out of phase -> invisibility 10
                {
                    if (u->m_invisibilityMask && u->m_invisibilityMask & (1 << 10) && !u->canDetectInvisibilityOf((Unit*)i_obj, u))
                        return false;
                }

                if (u->isAlive() && i_obj->IsWithinDistInMap(u, i_range) && !i_funit->IsFriendlyTo(u))
                    return true;
                else
                    return false;
            }
        private:
            WorldObject const* i_obj;
            Unit const* i_funit;
            float i_range;
    };

    class AnyUnfriendlyNoTotemUnitInObjectRangeCheck
    {
        public:
            AnyUnfriendlyNoTotemUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) : i_obj(obj), i_funit(funit), i_range(range) {}
            bool operator()(Unit* u)
            {
                if (!u->isAlive())
                    return false;

                if (i_obj->GetTypeId()==TYPEID_UNIT || i_obj->GetTypeId()==TYPEID_PLAYER)   // cant target when out of phase -> invisibility 10
                {
                    if (u->m_invisibilityMask && u->m_invisibilityMask & (1 << 10) && !u->canDetectInvisibilityOf((Unit*)i_obj, u))
                        return false;
                }

                if (u->GetTypeId()==TYPEID_UNIT && ((Creature*)u)->isTotem())
                    return false;

                if (/*u->hasUnitState(UNIT_STAT_ISOLATED) || */u->HasFlag(UNIT_FIELD_FLAGS, (UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE)))
                    return false;

                return i_obj->IsWithinDistInMap(u, i_range) && !i_funit->IsFriendlyTo(u);
            }
        private:
            WorldObject const* i_obj;
            Unit const* i_funit;
            float i_range;
    };

    class CreatureWithDbGUIDCheck
    {
        public:
            CreatureWithDbGUIDCheck(WorldObject const* obj, uint32 lowguid) : i_obj(obj), i_lowguid(lowguid) {}
            bool operator()(Creature* u)
            {
                return u->GetDBTableGUIDLow() == i_lowguid;
            }
        private:
            WorldObject const* i_obj;
            uint32 i_lowguid;
    };

    class AnyFriendlyUnitInObjectRangeCheck
    {
        public:
            AnyFriendlyUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) : i_obj(obj), i_funit(funit), i_range(range) {}
            bool operator()(Unit* u)
            {
                if (u->isAlive() && i_obj->IsWithinDistInMap(u, i_range) && i_funit->IsFriendlyTo(u))
                    return true;
                else
                    return false;
            }
        private:
            WorldObject const* i_obj;
            Unit const* i_funit;
            float i_range;
    };

    class AnyFriendlyNonSelfUnitInObjectRangeCheck
    {
        public:
            AnyFriendlyNonSelfUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) : i_obj(obj), i_funit(funit), i_range(range) {}
            bool operator()(Unit* u)
            {
                if (u->isAlive() && u->GetGUID() != i_obj->GetGUID() && i_obj->IsWithinDistInMap(u, i_range) && i_funit->IsFriendlyTo(u))
                    return true;
                else
                    return false;
            }
        private:
            WorldObject const* i_obj;
            Unit const* i_funit;
            float i_range;
    };

    class AnyUnitInObjectRangeCheck
    {
        public:
            AnyUnitInObjectRangeCheck(WorldObject const* obj, float range) : i_obj(obj), i_range(range) {}
            bool operator()(Unit* u)
            {
                if (u->isAlive() && i_obj->IsWithinDistInMap(u, i_range))
                    return true;

                return false;
            }
        private:
            WorldObject const* i_obj;
            float i_range;
    };

    // Success at unit in range, range update for next check (this can be use with UnitLastSearcher to find nearest unit)
    class NearestAttackableUnitInObjectRangeCheck
    {
        public:
            NearestAttackableUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) : i_obj(obj), i_funit(funit), i_range(range) {}
            bool operator()(Unit* u)
            {
                if (u->isTargetableForAttack() && i_obj->IsWithinDistInMap(u, i_range) &&
                    !i_funit->IsFriendlyTo(u) && u->isVisibleForOrDetect(i_funit, i_funit, false) )
                {
                    i_range = i_obj->GetDistance(u);        // use found unit range as new range limit for next check
                    return true;
                }

                return false;
            }
        private:
            WorldObject const* i_obj;
            Unit const* i_funit;
            float i_range;

            // prevent clone this object
            NearestAttackableUnitInObjectRangeCheck(NearestAttackableUnitInObjectRangeCheck const&);
    };

    class AnyAoETargetUnitInObjectRangeCheck
    {
        public:
            AnyAoETargetUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range)
                : i_obj(obj), i_funit(funit), i_range(range)
            {
                Unit const* check = i_funit;
                Unit const* owner = i_funit->GetOwner();
                if (owner)
                    check = owner;
                i_targetForPlayer = (check->GetTypeId()==TYPEID_PLAYER);
            }
            bool operator()(Unit* u)
            {
                // Check contains checks for: live, non-selectable, non-attackable flags, invisibility mask, flight check and GM check, ignore totems
                if (!u->isTargetableForAttack())
                    return false;
                if (i_obj->GetTypeId()==TYPEID_UNIT || i_obj->GetTypeId()==TYPEID_PLAYER)   // cant target when out of phase -> invisibility 10
                {
                    if (u->m_invisibilityMask && u->m_invisibilityMask & (1 << 10) && !u->canDetectInvisibilityOf((Unit*)i_obj, u))
                        return false;
                }
                if (u->GetTypeId()==TYPEID_UNIT && ((Creature*)u)->isTotem())
                    return false;

                if ((i_targetForPlayer ? !i_funit->IsFriendlyTo(u) : i_funit->IsHostileTo(u))&& i_obj->IsWithinDistInMap(u, i_range))
                    return true;

                return false;
            }
        private:
            bool i_targetForPlayer;
            WorldObject const* i_obj;
            Unit const* i_funit;
            float i_range;
    };

    // do attack at call of help to friendly crearture
    class CallOfHelpCreatureInRangeDo
    {
        public:
            CallOfHelpCreatureInRangeDo(Unit* funit, Unit* enemy, float range)
                : i_funit(funit), i_enemy(enemy), i_range(range)
            {}
            void operator()(Creature* u)
            {
                if (u == i_funit)
                    return;

                if (!u->CanAssistTo(i_funit, i_enemy, false))
                    return;

                // too far
                if (!i_funit->IsWithinDistInMap(u, i_range))
                    return;

                // only if see assisted creature
                if (!i_funit->IsWithinLOSInMap(u))
                    return;

                if (u->AI())
                    u->AI()->AttackStart(i_enemy);
            }
        private:
            Unit* const i_funit;
            Unit* const i_enemy;
            float i_range;
    };
#pragma endregion Workers

#pragma region Checks
    // Prepare using Builder localized packets with caching and send to player
    template<class Builder>
    class LocalizedPacketDo
    {
        public:
            explicit LocalizedPacketDo(Builder& builder) : i_builder(builder) {}

            ~LocalizedPacketDo()
            {
                for (size_t i = 0; i < i_data_cache.size(); ++i)
                    delete i_data_cache[i];
            }
            void operator()( Player* p );

        private:
            Builder& i_builder;
            std::vector<WorldPacket*> i_data_cache;         // 0 = default, i => i-1 locale index
    };

    struct AnyDeadUnitCheck
    {
        bool operator()(Unit* u) { return !u->isAlive(); }
    };

    struct AnyStealthedCheck
    {
        bool operator()(Unit* u) { return u->GetVisibility()==VISIBILITY_GROUP_STEALTH; }
    };

    class NearestHostileUnitInAttackDistanceCheck
    {
        public:
            explicit NearestHostileUnitInAttackDistanceCheck(Creature const* creature, float dist = 0, bool force = false) : m_creature(creature), m_force(force)
            {
                m_range = (dist == 0 ? 80.0f : dist);
            }
            bool operator()(Unit* u)
            {
                // TODO: add threat for every enemy in range?
                if (!m_creature->IsWithinDistInMap(u, m_range))
                    return false;

                if (m_force)
                {
                    if (!m_creature->canAttack(u))
                        return false;
                }
                else
                {
                    if (!m_creature->canStartAttack(u))
                        return false;
                }

                m_range = m_creature->GetDistance(u);
                return true;
            }
            float GetLastRange() const { return m_range; }
        private:
            Creature const *m_creature;
            float m_range;
            bool m_force;
            NearestHostileUnitInAttackDistanceCheck(NearestHostileUnitInAttackDistanceCheck const&);
    };

    class NearestAssistCreatureInCreatureRangeCheck
    {
        public:
            NearestAssistCreatureInCreatureRangeCheck(Creature* obj,Unit* enemy, float range)
                : i_obj(obj), i_enemy(enemy), i_range(range) {}

            bool operator()(Creature* u)
            {
                if (u->getFaction() == i_obj->getFaction() && !u->isInCombat() && !u->GetCharmerOrOwnerGUID() && u->IsHostileTo(i_enemy) && u->isAlive()&& i_obj->IsWithinDistInMap(u, i_range) && i_obj->IsWithinLOSInMap(u))
                {
                    i_range = i_obj->GetDistance(u);         // use found unit range as new range limit for next check
                    return true;
                }
                return false;
            }
            float GetLastRange() const { return i_range; }
        private:
            Creature* const i_obj;
            Unit* const i_enemy;
            float  i_range;

            // prevent clone this object
            NearestAssistCreatureInCreatureRangeCheck(NearestAssistCreatureInCreatureRangeCheck const&);
    };

    class AnyAssistCreatureInRangeCheck
    {
        public:
            AnyAssistCreatureInRangeCheck(Unit* funit, Unit* enemy, float range)
                : i_funit(funit), i_enemy(enemy), i_range(range)
            {
            }
            bool operator()(Creature* u)
            {
                if (u == i_funit)
                    return false;

                if (!u->CanAssistTo(i_funit, i_enemy))
                    return false;

                // too far
                if (!i_funit->IsWithinDistInMap(u, i_range))
                    return false;

                // only if see assisted creature
                if (!i_funit->IsWithinLOSInMap(u))
                    return false;

                return true;
            }
        private:
            Unit* const i_funit;
            Unit* const i_enemy;
            float i_range;
    };

    // Success at unit in range, in LoS if needed, range update for next check (this can be use with CreatureLastSearcher to find nearest creature)
    class NearestCreatureEntryWithLiveStateInObjectRangeCheck
    {
        public:
            NearestCreatureEntryWithLiveStateInObjectRangeCheck(WorldObject const& obj,uint32 entry, bool alive, float range, bool inLoS)
                : i_obj(obj), i_entry(entry), i_alive(alive), i_range(range), i_inLoS(inLoS) {}

            bool operator()(Creature* u)
            {
                if (u->GetEntry() == i_entry && u->isAlive()==i_alive && i_obj.IsWithinDistInMap(u, i_range) && (!i_inLoS || i_obj.IsWithinLOSInMap(u)))
                {
                    i_range = i_obj.GetDistance(u);         // use found unit range as new range limit for next check
                    return true;
                }
                return false;
            }
            float GetLastRange() const { return i_range; }
        private:
            WorldObject const& i_obj;
            uint32 i_entry;
            bool   i_alive;
            float  i_range;
            bool   i_inLoS;

            // prevent clone this object
            NearestCreatureEntryWithLiveStateInObjectRangeCheck(NearestCreatureEntryWithLiveStateInObjectRangeCheck const&);
    };

    class AnyPlayerInObjectRangeCheck
    {
    public:
        AnyPlayerInObjectRangeCheck(WorldObject const* obj, float range, bool alive = true) : i_obj(obj), i_range(range), i_alive(alive) {}
        bool operator()(Player* u)
        {
            if ((i_alive && u->isAlive() || !i_alive && !u->isAlive()) && i_obj->IsWithinDistInMap(u, i_range))
                return true;

            return false;
        }
    private:
        WorldObject const* i_obj;
        float i_range;
        bool i_alive;
    };

    // Searchers used by ScriptedAI
    class MostHPMissingInRange
    {
    public:
        MostHPMissingInRange(Unit const* obj, float range, uint32 hp) : i_obj(obj), i_range(range), i_hp(hp) {}
        bool operator()(Unit* u)
        {
            if (u->isAlive() && u->isInCombat() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) && u->GetMaxHealth() - u->GetHealth() > i_hp)
            {
                i_hp = u->GetMaxHealth() - u->GetHealth();
                return true;
            }
            return false;
        }
    private:
        Unit const* i_obj;
        float i_range;
        uint32 i_hp;
    };

    class FriendlyCCedInRange
    {
    public:
        FriendlyCCedInRange(Unit const* obj, float range) : i_obj(obj), i_range(range) {}
        bool operator()(Unit* u)
        {
            if (u->isAlive() && u->isInCombat() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) &&
                u->isCrowdControlled())
            {
                return true;
            }
            return false;
        }
    private:
        Unit const* i_obj;
        float i_range;
    };

    class FriendlyMissingBuffInRange
    {
    public:
        FriendlyMissingBuffInRange(Unit const* obj, float range, uint32 spellid) : i_obj(obj), i_range(range), i_spell(spellid) {}
        bool operator()(Unit* u)
        {
            if (u->isAlive() && u->isInCombat() && /*!i_obj->IsHostileTo(u)*/ i_obj->IsFriendlyTo(u) && i_obj->IsWithinDistInMap(u, i_range) &&
                !(u->HasAura(i_spell, 0) || u->HasAura(i_spell, 1) || u->HasAura(i_spell, 2)))
            {
                return true;
            }
            return false;
        }
    private:
        Unit const* i_obj;
        float i_range;
        uint32 i_spell;
    };

    class AllFriendlyCreaturesInGrid
    {
    public:
        AllFriendlyCreaturesInGrid(Unit const* obj) : pUnit(obj) {}
        bool operator() (Unit* u)
        {
            if (u->isAlive() && u->GetVisibility() == VISIBILITY_ON && u->IsFriendlyTo(pUnit))
                return true;

            return false;
        }
    private:
        Unit const* pUnit;
    };

    class AllGameObjectsWithEntryInGrid
    {
    public:
        AllGameObjectsWithEntryInGrid(uint32 ent) : entry(ent) {}
        bool operator() (GameObject* g)
        {
            if (g->GetEntry() == entry)
                return true;

            return false;
        }
    private:
        uint32 entry;
    };

    class AllGameObjectsInRange
    {
    public:
        AllGameObjectsInRange(Unit const * pUn, uint32 ran) : pUnit(pUn), range(range) {}
        bool operator() (GameObject* g)
        {
            return pUnit->IsWithinDistInMap(g, range);
        }
    private:
        Unit const * pUnit;
        uint32 range;
    };

    class AllCreaturesOfEntryInRange
    {
    public:
        AllCreaturesOfEntryInRange(Unit const* obj, uint32 ent, float ran) : pUnit(obj), entry(ent), range(ran) {}
        bool operator() (Unit* u)
        {
            if (u->GetEntry() == entry && pUnit->IsWithinDistInMap(u, range))
                return true;

            return false;
        }
    private:
        Unit const* pUnit;
        uint32 entry;
        float range;
    };

    class AllDeadUnitsInRange
    {
    public:
        AllDeadUnitsInRange(Unit const* obj, float range) : i_obj(obj), i_range(range) {}
        bool operator()(Unit* u)
        {
            if (!u->isAlive() && i_obj->IsWithinDistInMap(u, i_range))
                return true;
            return false;
        }
    private:
        Unit const* i_obj;
        float i_range;
    };

    class ObjectGUIDCheck
    {
        public:
            ObjectGUIDCheck(uint64 GUID) : _GUID(GUID) {}
            bool operator()(WorldObject* object)
            {
                return object->GetGUID() == _GUID;
            }

        private:
            uint64 _GUID;
    };

    class ObjectTypeIdCheck
    {
        public:
            ObjectTypeIdCheck(TypeID typeId, bool equals) : _typeId(typeId), _equals(equals) {}
            bool operator()(WorldObject* object)
            {
                return (object->GetTypeId() == _typeId) == _equals;
            }

        private:
            TypeID _typeId;
            bool _equals;
    };

    class ObjectIsTotemCheck
    {
        public:
            ObjectIsTotemCheck(bool equals) : _equals(equals) {}
            bool operator()(WorldObject* object)
            {
                if(object->GetTypeId() != TYPEID_UNIT)
                    return !_equals;
                return (((Creature*)object)->isTotem()) == _equals;
            }

        private:
            bool _equals;
    };

    class UnitAuraCheck
    {
        public:
            UnitAuraCheck(bool present, uint32 spellId, uint32 effectIdx = 0) : _present(present), _spellId(spellId), _effectIdx(effectIdx) {}
            bool operator()(Unit* unit)
            {
                return unit->HasAura(_spellId, _effectIdx) == _present;
            }

        private:
            bool _present;
            uint32 _spellId;
            uint32 _effectIdx;
    };

    class UnitPowerTypeCheck
    {
        public:
            UnitPowerTypeCheck(Powers power, bool present = true) : _present(present), _power(power) {}
            bool operator()(Unit* unit)
            {
                return ((_present && unit->getPowerType() == _power) || (!_present && unit->getPowerType() != _power));
            }

        private:
            bool _present;
            uint32 _power;
    };

    class ObjectDistanceCheck
    {
        public:
            ObjectDistanceCheck(WorldObject *source, uint32 dist, bool greater) : _source(source), _dist(dist), _greater(greater) {}
            bool operator()(WorldObject* object)
            {
                return (_greater ? _source->GetExactDistSq(object->GetPositionX(), object->GetPositionY(), object->GetPositionZ()) > (_dist*_dist) : _source->GetExactDistSq(object->GetPositionX(), object->GetPositionY(), object->GetPositionZ()) < (_dist*_dist));
            }

        private:
            WorldObject *_source;
            uint32 _dist;
            bool _greater;
    };

    class IsWithinLOSCheck
    {
        public:
            IsWithinLOSCheck(WorldObject* source, bool within) : _source(source), _within(within) {}
            bool operator()(WorldObject* object)
            {
                return (_source->IsWithinLOSInMap(object) == _within);
            }

        private:
            WorldObject *_source;
            bool _within;
    };
#pragma endregion Checks

#pragma region Sorters
    // sorter
    struct ObjectDistanceOrder : public std::binary_function<const Unit *, const Unit *, bool>
    {
        const Unit * me;
        ObjectDistanceOrder(const Unit* Target) : me(Target) {};
        // functor for operator ">"
        bool operator()(const Unit * _Left, const Unit * _Right) const
        {
            return (me->GetExactDistSq(_Left->GetPositionX(), _Left->GetPositionY(), _Left->GetPositionZ()) < me->GetExactDistSq(_Right->GetPositionX(), _Right->GetPositionY(), _Right->GetPositionZ()));
        }
    };
}
#pragma endregion Sorters

#endif
