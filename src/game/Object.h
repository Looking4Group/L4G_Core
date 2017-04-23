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

#ifndef _OBJECT_H
#define _OBJECT_H

#include "Common.h"
#include "ByteBuffer.h"
#include "UpdateFields.h"
#include "UpdateData.h"
#include "Camera.h"
#include "ObjectGuid.h"
#include "GridDefines.h"
#include "Map.h"
#include "SharedDefines.h"

#include <set>
#include <string>

#define DEFAULT_WORLD_OBJECT_SIZE   0.388999998569489f      // player size, also currently used (correctly?) for any non Unit world objects
#define MAX_STEALTH_DETECT_RANGE    45.0f
#define DEFAULT_COMBAT_REACH        1.5f
#define MIN_MELEE_REACH             2.0f
#define NOMINAL_MELEE_RANGE         5.0f
#define MELEE_RANGE                 (NOMINAL_MELEE_RANGE - MIN_MELEE_REACH * 2) //center to center for players
#define COMMON_ALLOW_HEIGHT_DIFF    4.3f

uint32 GuidHigh2TypeId(uint32 guid_hi);

enum TempSummonType
{
    TEMPSUMMON_TIMED_OR_DEAD_DESPAWN       = 1,             // despawns after a specified time OR when the creature disappears
    TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN     = 2,             // despawns after a specified time OR when the creature dies
    TEMPSUMMON_TIMED_DESPAWN               = 3,             // despawns after a specified time
    TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT = 4,             // despawns after a specified time after the creature is out of combat
    TEMPSUMMON_CORPSE_DESPAWN              = 5,             // despawns instantly after death
    TEMPSUMMON_CORPSE_TIMED_DESPAWN        = 6,             // despawns after a specified time after death
    TEMPSUMMON_DEAD_DESPAWN                = 7,             // despawns when the creature disappears
    TEMPSUMMON_MANUAL_DESPAWN              = 8              // despawns when UnSummon() is called
};
#define MAX_TYPEID         10

enum ActiveObject
{
    ACTIVE_BY_NONE                  = 0x00,
    ACTIVE_BY_MANUAL                = 0x01,
    ACTIVE_BY_WAYPOINT_MOVEMENT     = 0x02,
    ACTIVE_BY_COMBAT                = 0x04,
    ACTIVE_BY_ALL                   = 0xFF
};

class WorldPacket;
class UpdateData;
class ByteBuffer;
class WorldSession;
class Unit;
class Creature;
class Player;
class Totem;
class Pet;
class UpdateMask;
class InstanceData;
class GameObject;
class CreatureAI;
class ZoneScript;
class TerrainInfo;

typedef UNORDERED_MAP<Player*, UpdateData> UpdateDataMapType;

struct Position
{
    Position() : x(0.0f), y(0.0f), z(0.0f), o(0.0f) {}
    float x, y, z, o;

    bool operator!=(Position &b) { return (x != b.x || y != b.y || z != b.z/* || o != b.o*/); }
};

struct WorldLocation
{
    uint32 mapid;
    float coord_x;
    float coord_y;
    float coord_z;
    float orientation;
    explicit WorldLocation(uint32 _mapid = 0, float _x = 0, float _y = 0, float _z = 0, float _o = 0)
        : mapid(_mapid), coord_x(_x), coord_y(_y), coord_z(_z), orientation(_o) {}
    WorldLocation(WorldLocation const &loc)
        : mapid(loc.mapid), coord_x(loc.coord_x), coord_y(loc.coord_y), coord_z(loc.coord_z), orientation(loc.orientation) {}
};

class LOOKING4GROUP_IMPORT_EXPORT Object
{
    public:
        virtual ~Object ();

        const bool& IsInWorld() const { return m_inWorld; }
        virtual void AddToWorld()
        {
            if (m_inWorld)
                return;

            ASSERT(m_uint32Values);

            m_inWorld = true;

            // synchronize values mirror with values array (changes will send in updatecreate opcode any way
            ClearUpdateMask(false);
        }
        virtual void RemoveFromWorld()
        {
            if (!m_inWorld)
                return;

            m_inWorld = false;

            // if we remove from world then sending changes not required
            ClearUpdateMask(true);
        }

#pragma region ObjectGuid

        ObjectGuid const& GetObjectGuid() const { return GetGuidValue(OBJECT_FIELD_GUID); }
        std::string GetGuidStr() const { return GetObjectGuid().GetString(); }

        ObjectGuid const& GetGuidValue(uint16 index) const { return *reinterpret_cast<ObjectGuid const*>(&GetUInt64Value(index)); }
        void SetGuidValue(uint16 index, ObjectGuid const& value) { SetUInt64Value(index, value.GetRawValue()); }

#pragma endregion ObjectGuid

        const uint64& GetGUID() const { return GetUInt64Value(0); }
        uint32 GetGUIDLow() const { return GUID_LOPART(GetUInt64Value(0)); }
        uint32 GetGUIDMid() const { return GUID_ENPART(GetUInt64Value(0)); }
        uint32 GetGUIDHigh() const { return GUID_HIPART(GetUInt64Value(0)); }
        PackedGuid const& GetPackGUID() const { return m_PackGUID; }
        uint32 GetEntry() const { return GetUInt32Value(OBJECT_FIELD_ENTRY); }
        void SetEntry(uint32 entry) { SetUInt32Value(OBJECT_FIELD_ENTRY, entry); }

        uint8 GetTypeId() const { return m_objectTypeId; }
        bool isType(uint16 mask) const { return (mask & m_objectType); }

        virtual void BuildCreateUpdateBlockForPlayer(UpdateData *data, Player *target) const;
        void SendCreateUpdateToPlayer(Player* player);

        void BuildValuesUpdateBlockForPlayer(UpdateData *data, Player *target) const;
        void BuildOutOfRangeUpdateBlock(UpdateData *data) const;

        virtual void DestroyForPlayer(Player *target) const;

        inline const int32& GetInt32Value(uint16 index) const
        {
            ASSERT(index < m_valuesCount || PrintIndexError(index , false));
            return m_int32Values[ index ];
        }

        inline const uint32& GetUInt32Value(uint16 index) const
        {
            ASSERT(index < m_valuesCount || PrintIndexError(index , false));
            return m_uint32Values[ index ];
        }

        std::string GetUInt32ValuesString() const;

        inline const uint64& GetUInt64Value(uint16 index) const
        {
            ASSERT(index + 1 < m_valuesCount || PrintIndexError(index , false));
            return *((uint64*)&(m_uint32Values[ index ]));
        }

        inline const float& GetFloatValue(uint16 index) const
        {
            ASSERT(index < m_valuesCount || PrintIndexError(index , false));
            return m_floatValues[ index ];
        }

        inline uint8 GetByteValue(uint16 index, uint8 offset) const
        {
            ASSERT(index < m_valuesCount || PrintIndexError(index , false));
            ASSERT(offset < 4);
            return *(((uint8*)&m_uint32Values[ index ])+offset);
        }

        inline uint16 GetUInt16Value(uint16 index, uint8 offset) const
        {
            ASSERT(index < m_valuesCount || PrintIndexError(index , false));
            ASSERT(offset < 2);
            return *(((uint16*)&m_uint32Values[ index ])+offset);
        }

        void SetInt32Value( uint16 index,        int32  value);
        void SetUInt32Value(uint16 index,       uint32  value);
        void SetUInt64Value(uint16 index, const uint64 &value);
        void SetFloatValue( uint16 index,       float   value);
        void SetByteValue(  uint16 index, uint8 offset, uint8 value);
        void SetUInt16Value(uint16 index, uint8 offset, uint16 value);
        inline void SetInt16Value( uint16 index, uint8 offset, int16 value) { SetUInt16Value(index,offset,(uint16)value); }
        void SetStatFloatValue(uint16 index, float value);
        void SetStatInt32Value(uint16 index, int32 value);

        void ApplyModUInt32Value(uint16 index, int32 val, bool apply);
        void ApplyModInt32Value(uint16 index, int32 val, bool apply);
        void ApplyModUInt64Value(uint16 index, int32 val, bool apply);
        void ApplyModPositiveFloatValue(uint16 index, float val, bool apply);
        void ApplyModSignedFloatValue(uint16 index, float val, bool apply);

        void ApplyPercentModFloatValue(uint16 index, float val, bool apply)
        {
            val = val > -100.0f ? val : -99.9f ;
            SetFloatValue(index, GetFloatValue(index) * (apply?(100.0f+val)/100.0f : 100.0f / (100.0f+val)));
        }

        void SetFlag(uint16 index, uint32 newFlag);
        void RemoveFlag(uint16 index, uint32 oldFlag);

        void ToggleFlag(uint16 index, uint32 flag)
        {
            if (HasFlag(index, flag))
                RemoveFlag(index, flag);
            else
                SetFlag(index, flag);
        }

        bool HasFlag(uint16 index, uint32 flag) const
        {
            ASSERT(index < m_valuesCount || PrintIndexError(index , false));
            return (m_uint32Values[ index ] & flag) != 0;
        }

        void SetByteFlag(uint16 index, uint8 offset, uint8 newFlag);
        void RemoveByteFlag(uint16 index, uint8 offset, uint8 newFlag);

        void ToggleFlag(uint16 index, uint8 offset, uint8 flag)
        {
            if (HasByteFlag(index, offset, flag))
                RemoveByteFlag(index, offset, flag);
            else
                SetByteFlag(index, offset, flag);
        }

        bool HasByteFlag(uint16 index, uint8 offset, uint8 flag) const
        {
            ASSERT(index < m_valuesCount || PrintIndexError(index , false));
            ASSERT(offset < 4);
            return (((uint8*)&m_uint32Values[index])[offset] & flag) != 0;
        }

        void ApplyModFlag(uint16 index, uint32 flag, bool apply)
        {
            if (apply) SetFlag(index,flag); else RemoveFlag(index,flag);
        }

        void SetFlag64(uint16 index, uint64 newFlag)
        {
            uint64 oldval = GetUInt64Value(index);
            uint64 newval = oldval | newFlag;
            SetUInt64Value(index,newval);
        }

        void RemoveFlag64(uint16 index, uint64 oldFlag)
        {
            uint64 oldval = GetUInt64Value(index);
            uint64 newval = oldval & ~oldFlag;
            SetUInt64Value(index,newval);
        }

        void ToggleFlag64(uint16 index, uint64 flag)
        {
            if (HasFlag64(index, flag))
                RemoveFlag64(index, flag);
            else
                SetFlag64(index, flag);
        }

        bool HasFlag64(uint16 index, uint64 flag) const
        {
            ASSERT(index < m_valuesCount || PrintIndexError(index , false));
            return (GetUInt64Value(index) & flag) != 0;
        }

        void ApplyModFlag64(uint16 index, uint64 flag, bool apply)
        {
            if (apply) SetFlag64(index,flag); else RemoveFlag64(index,flag);
        }

        void ClearUpdateMask(bool remove);

        bool LoadValues(const char* data);

        uint16 GetValuesCount() const { return m_valuesCount; }

        virtual bool hasQuest(uint32 /* quest_id */) const { return false; }
        virtual bool hasInvolvedQuest(uint32 /* quest_id */) const { return false; }

        virtual void BuildUpdate(UpdateDataMapType&) {}
        void BuildFieldsUpdate(Player *, UpdateDataMapType &) const;

        virtual void AddToClientUpdateList() =0;
        virtual void RemoveFromClientUpdateList() =0;

        // FG: some hacky helpers
        void ForceValuesUpdateAtIndex(uint32);

    protected:

        Object ();

        void _InitValues();
        void _Create (uint32 guidlow, uint32 entry, HighGuid guidhigh);

        virtual void _SetUpdateBits(UpdateMask *updateMask, Player *target) const;

        virtual void _SetCreateBits(UpdateMask *updateMask, Player *target) const;

        void BuildMovementUpdate(ByteBuffer * data, uint8 updateFlags) const;
        void BuildValuesUpdate(uint8 updatetype, ByteBuffer *data, UpdateMask *updateMask, Player *target) const;

        uint16 m_objectType;

        uint8 m_objectTypeId;
        uint8 m_updateFlag;

        union
        {
            int32  *m_int32Values;
            uint32 *m_uint32Values;
            float  *m_floatValues;
        };

        uint32 *m_uint32Values_mirror;

        uint16 m_valuesCount;

        bool m_objectUpdated;

    private:
        bool m_inWorld;

        PackedGuid m_PackGUID;

        // for output helpfull error messages from asserts
        bool PrintIndexError(uint32 index, bool set) const;
        Object(const Object&);                              // prevent generation copy constructor
        Object& operator=(Object const&);                   // prevent generation assigment operator
};

struct WorldObjectChangeAccumulator;

class LOOKING4GROUP_IMPORT_EXPORT WorldObject : public Object//, public WorldLocation
{
    friend struct WorldObjectChangeAccumulator;

    public:
        class LOOKING4GROUP_IMPORT_EXPORT UpdateHelper
        {
            public:
                explicit UpdateHelper(WorldObject* obj) : m_obj(obj) {}
                ~UpdateHelper() {}

                void Update(uint32 time_diff)
                {
                    m_obj->Update(GetTimeElapsed(), time_diff);
                    m_obj->m_updateTracker.Reset();
                }

                //bool ProcessUpdate();

                static bool ProcessUpdate(Creature*);
                static bool ProcessUpdate(WorldObject*);

                time_t GetTimeElapsed() const { return m_obj->m_updateTracker.timeElapsed(); }

            private:
                UpdateHelper& operator=(const UpdateHelper&);
                UpdateHelper(const UpdateHelper& o);

                WorldObject* m_obj;
        };

        virtual ~WorldObject () {}

        virtual void Update(uint32 /*update_diff*/, uint32 /*time_diff*/) {}

        void _Create(uint32 guidlow, HighGuid guidhigh, uint32 mapid);

        void Relocate(float x, float y, float z, float orientation);
        void Relocate(float x, float y, float z);
        void Relocate(Position pos);
        void SetOrientation(float orientation);

        float GetPositionX() const { return m_positionX; }
        float GetPositionY() const { return m_positionY; }
        float GetPositionZ() const { return m_positionZ; }
        float GetOrientation() const { return m_orientation; }

        void GetPosition(float &x, float &y, float &z) const
            { x = m_positionX; y = m_positionY; z = m_positionZ; }

        void GetPosition(WorldLocation &loc) const
            { loc.mapid = GetMapId(); GetPosition(loc.coord_x, loc.coord_y, loc.coord_z); loc.orientation = GetOrientation(); }

        void GetPosition(Position &pos) const
            { pos.x = m_positionX; pos.y = m_positionY; pos.z = m_positionZ; pos.o = m_orientation; }

        virtual float GetObjectBoundingRadius() const { return DEFAULT_WORLD_OBJECT_SIZE; }

        float GetObjectSize() const
        {
            return (m_valuesCount > UNIT_FIELD_COMBATREACH) ? m_floatValues[UNIT_FIELD_COMBATREACH] : DEFAULT_WORLD_OBJECT_SIZE;
        }
        bool IsPositionValid() const;

#pragma region Move all this shit to Position struct
        void UpdateGroundPositionZ(float x, float y, float &z) const;
        void UpdateAllowedPositionZ(float x, float y, float &z) const;

        void GetNearPoint(float &x, float &y, float &z, float searcher_size, float distance2d = 0.0f,float absAngle = 0.0f) const;

        void GetGroundPoint(float &x, float &y, float &z, float dist, float angle);
        void GetGroundPointAroundUnit(float &x, float &y, float &z, float dist, float angle)
        {
            GetPosition(x, y, z);
            GetGroundPoint(x, y, z, dist, angle);
        }

        void GetRandomPoint(float x, float y, float z, float distance, float &rand_x, float &rand_y, float &rand_z) const;
        void GetValidPointInAngle(Position &pos, float dist, float angle, bool meAsSourcePo, bool ignoreLOSOffset = false, float allowHeightDifference = COMMON_ALLOW_HEIGHT_DIFF) const;
        void GetValidFishPointInAngle(Position &pos, float dist, float angle, bool meAsSourcePo, bool ignoreLOSOffset = false, float allowHeightDifference = COMMON_ALLOW_HEIGHT_DIFF) const;

#pragma endregion Move all this shit to Position struct

        void SetMapId(uint32 newMap) { m_mapId = newMap; m_map = NULL; }
        uint32 GetMapId() const { return m_mapId; }
        void SetInstanceId(uint32 val) { m_InstanceId = val; m_map = NULL; }
        uint32 GetInstanceId() const { return m_InstanceId; }

        uint32 GetZoneId() const;
        uint32 GetAreaId() const;

        InstanceData* GetInstanceData();

        const char* GetName() const { return m_name.c_str(); }
        void SetName(const std::string& newname) { m_name=newname; }

        virtual const char* GetNameForLocaleIdx(int32 /*locale_idx*/) const { return GetName(); }

        float GetDistance(WorldObject const* obj) const;
        float GetDistance(const float x, const float y, const float z) const;
        float GetDistanceSq(const float &x, const float &y, const float &z) const;
        float GetDistance2d(WorldObject const* obj) const;
        float GetDistance2d(const float x, const float y) const;
        bool GetDistanceOrder(WorldObject const* obj1, WorldObject const* obj2, bool is3D = true) const;
        float GetExactDistance2d(const float x, const float y) const;
        float GetDistanceZ(WorldObject const* obj) const;

        float GetExactDist2dSq(float x, float y) const
            { float dx = m_positionX - x; float dy = m_positionY - y; return dx*dx + dy*dy; }
        float GetExactDist2d(const float x, const float y) const
            { return sqrt(GetExactDist2dSq(x, y)); }
        float GetExactDist2dSq(const WorldLocation *pos) const
            { float dx = m_positionX - pos->coord_x; float dy = m_positionY - pos->coord_y; return dx*dx + dy*dy; }
        float GetExactDist2d(const WorldLocation *pos) const
            { return sqrt(GetExactDist2dSq(pos)); }
        float GetExactDistSq(float x, float y, float z) const
            { float dz = m_positionZ - z; return GetExactDist2dSq(x, y) + dz*dz; }
        float GetExactDist(float x, float y, float z) const
            { return sqrt(GetExactDistSq(x, y, z)); }
        float GetExactDistSq(const WorldLocation *pos) const
            { float dx = m_positionX - pos->coord_x; float dy = m_positionY - pos->coord_y; float dz = m_positionZ - pos->coord_z; return dx*dx + dy*dy + dz*dz; }
        float GetExactDist(const WorldLocation *pos) const
            { return sqrt(GetExactDistSq(pos)); }

        bool IsInMap(WorldObject const* obj) const
        {
            return IsInWorld() && obj->IsInWorld() && GetMapId()==obj->GetMapId() &&
                GetInstanceId()==obj->GetInstanceId();
        }

        bool IsWithinDist2d(float x, float y, float dist2compare) const;
        bool IsWithinDist3d(float x, float y, float z, float dist2compare) const;

        bool _IsWithinDist(WorldObject const* obj, float dist2compare, bool is3D) const;
        bool _IsWithinDist(WorldLocation const* wLoc, float dist2compare, bool is3D) const;
        bool IsWithinDist(WorldObject const* obj, float dist2compare, bool is3D = true) const
        {
            return obj && _IsWithinDist(obj,dist2compare,is3D);
        }
        bool IsWithinDistInMap(WorldObject const* obj, float dist2compare, bool is3D = true) const
        {
            return obj && IsInMap(obj) && _IsWithinDist(obj,dist2compare,is3D);
        }
        bool IsWithinDistInMap(WorldLocation const* wLoc, float dist2compare, bool is3D = true) const
        {
            return wLoc && GetMapId() == wLoc->mapid && _IsWithinDist(wLoc,dist2compare,is3D);
        }
        bool IsWithinLOS(const float x, const float y, const float z) const;
        bool IsWithinLOSInMap(WorldObject const* obj) const;

        bool IsInRange(WorldObject const* obj, float minRange, float maxRange, bool is3D = true) const;
        bool IsInRange2d(float x, float y, float minRange, float maxRange) const;
        bool IsInRange3d(float x, float y, float z, float minRange, float maxRange) const;

        float GetAngle(WorldObject const* obj) const;
        float GetAngle(const float x, const float y) const;
        bool HasInArc(const float arcangle, WorldObject const* obj) const;

        virtual void CleanupsBeforeDelete(); // used in destructor or explicitly before mass creature delete to remove cross-references to already deleted units

        // method used to broadcast packets to all players around object
        void BroadcastPacket(WorldPacket*, bool);
        // method used to broadcast packets to players in specific range around object
        void BroadcastPacketInRange(WorldPacket*, float, bool, bool = false);
        void BroadcastPacketExcept(WorldPacket*, Player*);

        void MonsterSay(const char* text, uint32 language, uint64 TargetGuid);
        void MonsterYell(const char* text, uint32 language, uint64 TargetGuid);
        void MonsterTextEmote(const char* text, uint64 TargetGuid, bool IsBossEmote = false);
        void MonsterWhisper(const char* text, uint64 receiver, bool IsBossWhisper = false);
        void MonsterSay(int32 textId, uint32 language, uint64 TargetGuid);
        void MonsterYell(int32 textId, uint32 language, uint64 TargetGuid);
        void MonsterTextEmote(int32 textId, uint64 TargetGuid, bool IsBossEmote = false, bool withoutPrename = false);
        void MonsterTextEmoteToZone(int32 textId, uint64 TargetGuid, bool IsBossEmote, bool withoutPrename = false);
        void MonsterWhisper(int32 textId, uint64 receiver, bool IsBossWhisper = false);
        void MonsterYellToZone(int32 textId, uint32 language, uint64 TargetGuid);
        void BuildMonsterChat(WorldPacket *data, uint8 msgtype, char const* text, uint32 language, char const* name, uint64 TargetGuid, bool withoutPrename = false) const;
        void BuildMonsterChat(WorldPacket *data, uint8 msgtype, int32 iTextEntry, uint32 language, char const* name, uint64 targetGuid, bool withoutPrename = false) const;

        void PlayDistanceSound(uint32 sound_id, Player* target = NULL);
        void PlayDirectSound(uint32 sound_id, Player* target = NULL);

        void SendObjectDeSpawnAnim(uint64 guid);
        void SendGameObjectCustomAnim(uint64 guid);

        virtual void SaveRespawnTime() {}

        void AddObjectToRemoveList();

        virtual void UpdateVisibilityAndView();
        virtual void UpdateObjectVisibility(bool forced = true);

        void BuildUpdate(UpdateDataMapType&);

        // main visibility check function in normal case (ignore gray zone distance check)
        bool isVisibleFor(Player const* u, WorldObject const* viewPoint) const { return isVisibleForInState(u,viewPoint,false); }

        // low level function for visibility change code, must be define in all main world object subclasses
        virtual bool isVisibleForInState(Player const*, WorldObject const*, bool) const = 0;

        // Low Level Packets
        void SendPlaySound(uint32 Sound, bool OnlySelf);

        Map* GetMap() const { return m_map ? m_map : const_cast<WorldObject*>(this)->_getMap(); }
        void SetMap(Map *newMap) { m_map = newMap; }

        // obtain terrain data for map where this object belong...
        TerrainInfo const* GetTerrain() const;

        void SetZoneScript();

        void BuildUpdateData(UpdateDataMapType &);
        void AddToClientUpdateList();
        void RemoveFromClientUpdateList();

        Creature* SummonCreature(uint32 id, float x, float y, float z, float ang,TempSummonType spwtype,uint32 despwtime);
        GameObject* SummonGameObject(uint32 entry, float x, float y, float z, float ang, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime);
        Creature* SummonTrigger(float x, float y, float z, float ang, uint32 dur, CreatureAI* (*GetAI)(Creature*) = NULL);

        uint32 isActiveObject() const { return m_activeBy || m_viewPoint.hasViewers(); }
        void setActive(bool isActiveObject, ActiveObject activeBy = ACTIVE_BY_MANUAL);
        void SetWorldObject(bool apply);

        bool IsTempWorldObject;

        Player const* ToPlayer() const { if (GetObjectGuid().IsPlayer()) return (const Player*)((Player*)this); else return NULL; }
        Player* ToPlayer() { if (GetObjectGuid().IsPlayer()) return reinterpret_cast<Player*>(this); else return NULL; }

        Creature const* ToCreature() const {if (GetTypeId() == TYPEID_UNIT) return (const Creature*)((Creature*)this); else return NULL; }
        Creature* ToCreature(){ if (GetTypeId() == TYPEID_UNIT) return reinterpret_cast<Creature*>(this); else return NULL; }

        Unit* ToUnit(){ if (GetTypeId() == TYPEID_UNIT || GetTypeId() == TYPEID_PLAYER) return reinterpret_cast<Unit*>(this); else return NULL; }
        const Unit* ToUnit() const {if (GetTypeId() == TYPEID_UNIT || GetTypeId() == TYPEID_PLAYER) return (const Unit*)((Unit*)this); else return NULL; }
        GameObject* ToGameObject(){ if (GetTypeId() == TYPEID_GAMEOBJECT) return reinterpret_cast<GameObject*>(this); else return NULL; }
        const GameObject* ToGameObject() const {if (GetTypeId() == TYPEID_GAMEOBJECT) return (const GameObject*)((GameObject*)this); else return NULL; }

        Corpse* ToCorpse(){ if (GetTypeId() == TYPEID_CORPSE) return reinterpret_cast<Corpse*>(this); else return NULL; }
        const Corpse* ToCorpse() const {if (GetTypeId() == TYPEID_CORPSE) return (const Corpse*)((Corpse*)this); else return NULL; }

        Totem* ToTotem();
        const Totem* ToTotem() const;

        Pet* ToPet();
        const Pet* ToPet() const;

        ViewPoint& GetViewPoint() { return m_viewPoint; }
        WorldUpdateCounter& GetUpdateCounter() { return m_updateTracker; }

    protected:
        explicit WorldObject();
        std::string m_name;
        uint32 m_activeBy;

        ZoneScript *m_zoneScript;

    private:
        uint32 m_mapId;
        uint32 m_InstanceId;

        Map* m_map;
        Map* _getMap();

        float m_positionX;
        float m_positionY;
        float m_positionZ;
        float m_orientation;

        WorldUpdateCounter m_updateTracker;

        ViewPoint m_viewPoint;
};

#endif
