/* Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
 *
 * Thanks to the original authors: ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software licensed under GPL version 2
 * Please see the included DOCS/LICENSE.TXT for more information */

#ifndef SC_SCRIPTMGR_H
#define SC_SCRIPTMGR_H

#include "Common.h"
#include "Platform/CompilerDefs.h"
#include "DBCStructure.h"

class Player;
class Creature;
class CreatureAI;
class InstanceData;
class Quest;
class Object;
class Item;
class GameObject;
class Aura;
class SpellCastTargets;
class Map;
class Unit;
class WorldObject;
struct ItemPrototype;

#define MAX_SCRIPTS         5000                            //72 bytes each (approx 351kb)
#define VISIBLE_RANGE       (166.0f)                        //MAX visible range (size of grid)
#define DEFAULT_TEXT        "<Trinity Script Text Entry Missing!>"

struct Script
{
    Script() :
        pGossipHello(NULL), pGossipSelect(NULL), pGossipSelectGO(NULL),
        pGossipSelectWithCode(NULL), pGossipSelectGOWithCode(NULL),
        pDialogStatusNPC(NULL), pDialogStatusGO(NULL),
        pQuestAcceptNPC(NULL), pQuestAcceptGO(NULL), pQuestAcceptItem(NULL),
        pQuestRewardedNPC(NULL), pQuestRewardedGO(NULL),
        pGOUse(NULL), pItemUse(NULL), pAreaTrigger(NULL), pCompletedCinematic(NULL),
        pProcessEventId(NULL), pReceiveEmote(NULL),
        pEffectDummyNPC(NULL), pEffectDummyGO(NULL), pEffectDummyItem(NULL), pEffectAuraDummy(NULL),
        GetAI(NULL), GetInstanceData(NULL),

        //spell scripts
        pSpellTargetMap(NULL), pSpellHandleEffect(NULL)
    {}

    std::string Name;

    bool (*pGossipHello             )(Player*, Creature*);
    bool (*pGossipSelect            )(Player*, Creature*, uint32, uint32);
    bool (*pGossipSelectGO          )(Player*, GameObject*, uint32, uint32);
    bool (*pGossipSelectWithCode    )(Player*, Creature*, uint32, uint32, const char*);
    bool (*pGossipSelectGOWithCode  )(Player*, GameObject*, uint32, uint32, const char*);
    uint32 (*pDialogStatusNPC       )(Player*, Creature*);
    uint32 (*pDialogStatusGO        )(Player*, GameObject*);
    bool (*pQuestAcceptNPC          )(Player*, Creature*, Quest const*);
    bool (*pQuestAcceptGO           )(Player*, GameObject*, Quest const*);
    bool (*pQuestAcceptItem         )(Player*, Item*, Quest const*);
    bool (*pQuestRewardedNPC        )(Player*, Creature*, Quest const*);
    bool (*pQuestRewardedGO         )(Player*, GameObject*, Quest const*);
    bool (*pGOUse                   )(Player*, GameObject*);
    bool (*pItemUse                 )(Player*, Item*, SpellCastTargets const&);
    bool (*pAreaTrigger             )(Player*, AreaTriggerEntry const*);
    bool (*pCompletedCinematic      )(Player*, CinematicSequencesEntry const*);
    bool (*pProcessEventId          )(uint32, Object*, Object*, bool);
    bool (*pEffectDummyNPC          )(Unit*, uint32, uint32, Creature*);
    bool (*pEffectDummyGO           )(Unit*, uint32, uint32, GameObject*);
    bool (*pEffectDummyItem         )(Unit*, uint32, uint32, Item*);
    bool (*pEffectAuraDummy         )(const Aura*, bool);

    bool (*pReceiveEmote            )(Player*, Creature*, uint32);

    //spell scripts
    bool (*pSpellTargetMap          )(Unit*, std::list<Unit*> &, SpellCastTargets const&, SpellEntry const *, uint32);
    bool (*pSpellHandleEffect       )(Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex);

    CreatureAI* (*GetAI             )(Creature*);
    InstanceData* (*GetInstanceData )(Map*);

    void RegisterSelf(bool bReportError = true);
};

//Generic scripting text function
void DoScriptText(int32 textEntry, WorldObject* pSource, Unit* target = NULL, bool withoutPrename = false);
void DoGlobalScriptText(int32 iTextEntry, const char *npcName, Map *map);
void ScriptText(int32 textEntry, Unit* pSource, Unit* target = NULL);

#if COMPILER == COMPILER_GNU
#define FUNC_PTR(name, callconvention, returntype, parameters)    typedef returntype(*name)parameters __attribute__ ((callconvention));
#else
#define FUNC_PTR(name, callconvention, returntype, parameters)    typedef returntype(callconvention *name)parameters;
#endif

#ifdef WIN32
#define LOOKING4GROUP_DLL_EXPORT extern "C" __declspec(dllexport)
#elif defined( __GNUC__ )
#define LOOKING4GROUP_DLL_EXPORT extern "C"
#else
#define LOOKING4GROUP_DLL_EXPORT extern "C" export
#endif

#endif
