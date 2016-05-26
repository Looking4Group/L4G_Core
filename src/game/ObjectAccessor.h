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

#ifndef LOOKING4GROUP_OBJECTACCESSOR_H
#define LOOKING4GROUP_OBJECTACCESSOR_H

#include "Platform/Define.h"

#include <ace/Singleton.h>
#include <ace/Thread_Mutex.h>

#include "ByteBuffer.h"
#include "UpdateData.h"

#include "GridDefines.h"
#include "Object.h"
#include "Player.h"

#include <tbb/concurrent_hash_map.h>

#include <set>

class Creature;
class Corpse;
class Unit;
class GameObject;
class DynamicObject;
class WorldObject;
class Map;

template <class T>
class HashMapHolder
{
    public:

        typedef tbb::concurrent_hash_map<uint64, T*>  MapType;
        typedef ACE_Thread_Mutex LockType;

        static bool Insert(T* o)
        {
            typename MapType::accessor a;
            if (m_objectMap.insert(a, o->GetGUID()))
            {
                a->second = o;
                return true;
            }

            return false;
        }

        static bool Remove(T* o)
        {
            typename MapType::accessor a;

            if (m_objectMap.find(a, o->GetGUID()))
                return m_objectMap.erase(a);

            return false;
        }

        static bool Remove(uint64 guid)
        {
            typename MapType::accessor a;

            if (m_objectMap.find(a, guid))
                return m_objectMap.erase(a);

            return false;
        }

        static T* Find(uint64 guid)
        {
            typename MapType::const_accessor a;

            if (m_objectMap.find(a, guid))
                return a->second;
            else
                return NULL;
        }

        static MapType& GetContainer() { return m_objectMap; }

        static LockType* GetLock() { return &i_lock; }
    private:

        //Non instanceable only static
        HashMapHolder() {}

        static LockType i_lock;
        static MapType  m_objectMap;
};

class ObjectAccessor
{
    friend class ACE_Singleton<ObjectAccessor, ACE_Thread_Mutex>;
    ObjectAccessor(){}

    public:
    ~ObjectAccessor(){}
    ObjectAccessor(const ObjectAccessor &);
    ObjectAccessor& operator=(const ObjectAccessor &);

    public:
        typedef tbb::concurrent_hash_map<uint64, Corpse*> Player2CorpsesMapType;
        typedef tbb::concurrent_hash_map<std::string, Player*> PlayerName2PlayerMapType;

        static Pet* GetPet(uint64 guid);

        static Player* FindPlayer(uint64);
        static Player* GetPlayer(uint64 guid);

        static Corpse * GetCorpse(uint64 guid);
        static Corpse * GetCorpse(WorldObject const &u, uint64 guid);
        static Corpse * GetCorpse(uint32 mapid, float x, float y, uint64 guid);

        HashMapHolder<Player>::MapType& GetPlayers();

        Player* GetPlayerByName(const char *name);
        Player* GetPlayerByName(std::string &name);

        bool RemovePlayerName(Player *pl);
        bool RemovePlayer(Player *pl);
        bool RemovePlayer(uint64 guid);

        bool AddPlayerName(Player *pl);
        bool AddPlayer(Player *pl);

        void AddPet(Pet* pet);
        void RemovePet(Pet* pet);
        void RemovePet(uint64 pet);

        Corpse* GetCorpseForPlayerGUID(uint64 guid);
        void RemoveCorpse(Corpse *corpse);
        void AddCorpse(Corpse* corpse);
        void AddCorpsesToGrid(GridPair const& gridpair,GridType& grid,Map* map);
        Corpse* ConvertCorpseForPlayer(uint64 player_guid, bool insignia = false);

        void RemoveOldCorpses();

        typedef ACE_Thread_Mutex LockType;
        std::list<Player*> playersToDelete;

    private:
        Player2CorpsesMapType       i_player2corpse;
        PlayerName2PlayerMapType    i_playerName2Player;

        void _update(void);
        LockType i_playerGuard;
        LockType i_corpseGuard;
};

#define sObjectAccessor (*ACE_Singleton<ObjectAccessor, ACE_Thread_Mutex>::instance())
#endif
