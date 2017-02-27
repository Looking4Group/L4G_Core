/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Zulaman
SD%Complete: 90
SDComment: Forest Frog will turn into different NPC's. Workaround to prevent new entry from running this script
SDCategory: Zul'Aman
EndScriptData */

/* ContentData
npc_forest_frog
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"
#include "def_zulaman.h"

/*######
## npc_forest_frog
######*/

#define SPELL_REMOVE_AMANI_CURSE        43732
#define SPELL_PUSH_MOJO                 43923
#define SPELL_SUMMON_MONEY_BAG          43774
#define SPELL_SUMMON_AMANI_CHARM_CHEST  43826
#define ENTRY_FOREST_FROG               24396

enum npc
{
    NPC_KRAZ = 24024,
    NPC_MANNUTH = 24397,
    NPC_DEEZ = 24403,
    NPC_GALATHRYN = 24404,
    NPC_ADARRAH = 24405,
    NPC_FUDGERICK = 24406,
    NPC_DARWEN = 24407,
    NPC_MITZI = 24445,
    NPC_CHRISTIAN = 24448,
    NPC_BRENNAN = 24453,
    NPC_HOLLEE = 24455,
};

struct npc_forest_frogAI : public ScriptedAI
{
    npc_forest_frogAI(Creature* c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    void Reset() { }

    void EnterCombat(Unit *who) { }

    void DoSpawnRandom()
    {
        if (pInstance )
        {
            uint32 cEntry = RAND(NPC_MANNUTH, NPC_DEEZ, NPC_GALATHRYN, NPC_ADARRAH, NPC_FUDGERICK, NPC_DARWEN, NPC_MITZI, NPC_CHRISTIAN, NPC_BRENNAN, NPC_HOLLEE);

            if (!pInstance->GetData(TYPE_RAND_VENDOR_1) )
                if(rand()%10 == 1) cEntry = 24408;      //Gunter
            if (!pInstance->GetData(TYPE_RAND_VENDOR_2) )
                if(rand()%10 == 1) cEntry = 24409;      //Kyren

            if (cEntry ) me->UpdateEntry(cEntry);

            if (cEntry == 24408)
                pInstance->SetData(TYPE_RAND_VENDOR_1,DONE);
            else if (cEntry == 24409)
                pInstance->SetData(TYPE_RAND_VENDOR_2,DONE);
            else
                DoCast(me, RAND(SPELL_SUMMON_MONEY_BAG, SPELL_SUMMON_AMANI_CHARM_CHEST, SPELL_SUMMON_AMANI_CHARM_CHEST, SPELL_SUMMON_AMANI_CHARM_CHEST));
        }
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (spell->Id == SPELL_REMOVE_AMANI_CURSE && caster->GetTypeId() == TYPEID_PLAYER && me->GetEntry() == ENTRY_FOREST_FROG )
        {
            //increase or decrease chance of mojo?
            if (rand()%99 == 50 ) DoCast(caster,SPELL_PUSH_MOJO,true);
            else DoSpawnRandom();
        }
    }
};
CreatureAI* GetAI_npc_forest_frog(Creature *_Creature)
{
    return new npc_forest_frogAI (_Creature);
}

/*######
## scripts for timed event
######*/

#define GOSSIP_ASHLI_1  "It's safe, little gnome. You can come out now."
#define GOSSIP_ASHLI_2  "How'd a perky little gnome like you get caught up in a mess like this?"
#define GOSSIP_KRAZ_1   "What happened to you, orc?"
#define GOSSIP_HARKOR_1 "So, how does a dwarf like you end up in a place like this?"
#define GOSSIP_TANZAR_1 "You're welcome... Now tell us what's going on here!"
#define GOSSIP_TANZAR_2 "What can you tell us about Budd?"

enum Gameobjects
{
    GO_LOOT_BOX                     = 186622,
    GO_EXPLOSION_CHARGE             = 183410, // probably wrong go, but looks ok
    GO_ASHLI_VASE                   = 186671,
    GO_GOLD_COINS1                  = 186633,
    GO_GOLD_COINS2                  = 186634,
};

enum TimeEventSpells
{
    SPELL_SMASH                     = 18944, // most probably wrong spell, but has cool visual
    SPELL_EXPLOSION                 = 43418, // also not sure about this
    SPELL_ASHLI_FIREBALL_COSMETIC   = 43515,
    SPELL_ASHLI_FIREBALL1           = 43520,
    SPELL_ASHLI_FIREBALL2           = 43525
};

enum TimeEventText
{
    YELL_ASHLI_KILL             = -1800518,
    YELL_ASHLI_FREED            = -1800519,
    YELL_ASHLI_FREE_ME1         = -1800520,
    YELL_ASHLI_FREE_ME2         = -1800521,
    YELL_ASHLI_FREE_ME3         = -1800522,
    YELL_ASHLI_VASE1            = -1800523,
    YELL_ASHLI_VASE2            = -1800524,
    YELL_ASHLI_VASE3            = -1800525
};

struct npc_hostageAI : public ScriptedAI
{
    npc_hostageAI(Creature *c) : ScriptedAI(c)
    {
       pInstance = (ScriptedInstance*)c->GetInstanceData();
    }


    ScriptedInstance *pInstance;
    uint32 CheckTimer;
    float dist;
    float angle;
    bool EventStarted;

    void Reset()
    {
        CheckTimer = 5000;
        EventStarted = false;
    }
    void EnterCombat(Unit *who) {}
    void JustDied(Unit *) {}
    virtual bool RewardReached(GameObject* reward) { return true; }

    void MovementInform(uint32 Type, uint32 Id)
    {
        if (Type != POINT_MOTION_TYPE)
            return;

        if(Id == 1)
        {
            uint8 i = GetHostageIndex(me->GetEntry());
            GameObject *target = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_CHEST_0 + i));
            if(target && RewardReached(target))
            {
                me->SetFacingToObject(target);
                target->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                pInstance->SetData(DATA_HOSTAGE_0_STATE + i, HOSTAGE_CHEST_UNLOCKED);
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!EventStarted && pInstance)
        {
            if(CheckTimer < diff)
            {
                uint8 i = GetHostageIndex(me->GetEntry());
                if(pInstance->GetData(DATA_HOSTAGE_0_STATE + i) & HOSTAGE_FREED)
                {
                    GameObject *target = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_CHEST_0 + i));
                    if(target)
                    {
                        float x, y, z;
                        target->GetNearPoint(x, y, z, 0.0f, dist, angle);
                        me->GetMotionMaster()->MovePoint(1, x, y, me->GetPositionZ());
                    }
                    EventStarted = true;
                }
                CheckTimer = 800;
            } else
                CheckTimer -= diff;
        }
    }
};

struct npc_tanzarAI : public npc_hostageAI
{
    npc_tanzarAI(Creature *c) : npc_hostageAI(c)
    {
        dist = 1.5;
        angle = 3.1415;
    }

    bool RewardReached(GameObject *reward)
    {
        me->CastSpell(me, 1804, false); // CHECKME: should do some emote that he is opening chest
        return true;
    }
};

CreatureAI* GetAI_npc_tanzar(Creature *_Creature)
{
    return new npc_tanzarAI(_Creature);
}

struct npc_harkorAI : public npc_hostageAI
{
    npc_harkorAI(Creature *c) : npc_hostageAI(c)
    {
        dist = 3;
        angle = 3.1415;
    }

    bool RewardReached(GameObject *reward)
    {
        GameObject *target = FindGameObject(GO_LOOT_BOX, 10, me);
        if(target)
        {
            me->CastSpell(me, SPELL_SMASH, false); // CHECKME: should do some emote that he is opening chest
            target->Delete();
        }
        return true;
    }
};

CreatureAI* GetAI_npc_harkor(Creature *_Creature)
{
    return new npc_harkorAI(_Creature);
}

struct npc_krazAI : public npc_hostageAI
{
    npc_krazAI(Creature *c) : npc_hostageAI(c)
    {
        dist = 0.1;
        angle = 0;
    }

    uint64 ExplosionChargeGUID;
    bool Move;

    void Reset()
    {
        npc_hostageAI::Reset();

        ExplosionChargeGUID = 0;
        Move = false;
    }

    bool RewardReached(GameObject *reward)
    {
        GameObject *go = me->SummonGameObject(GO_EXPLOSION_CHARGE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, 0, 0, 0, 0, 0);
        if(go)
        {
            go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND);
            ExplosionChargeGUID = go->GetGUID();
            Move = true;
        }
        return false;
    }

    void MovementInform(uint32 Type, uint32 Id)
    {
        npc_hostageAI::MovementInform(Type, Id);
        if (Type != POINT_MOTION_TYPE)
            return;

        if(Id == 2 && ExplosionChargeGUID)
        {
            GameObject *go = me->GetMap()->GetGameObject(ExplosionChargeGUID);
            if(go)
            {
                go->CastSpell(go, SPELL_EXPLOSION);
                go->Delete();
            }
            ExplosionChargeGUID = 0;

            go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_CHEST_KRAZ));
            if(go)
            {
                go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                pInstance->SetData(DATA_HOSTAGE_KRAZ_STATE, HOSTAGE_CHEST_UNLOCKED);
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(Move)
        {
            me->GetMotionMaster()->MovePoint(2, HostageInfo[2].x, HostageInfo[2].y, HostageInfo[2].z);
            Move = false;
        }
        npc_hostageAI::UpdateAI(diff);
    }
};


CreatureAI* GetAI_npc_kraz(Creature *_Creature)
{
    return new npc_krazAI(_Creature);
}

float AshliWP[][3] = {
    {409, 1146, 5},
    {360, 1090, 7},
    {346, 1088, 7},
    {343, 1129, 6},
    {385, 1089, 6},
    {405, 1087, 7}, 
    {374, 1087, 7}
};

struct npc_ashliAI : public ScriptedAI
{
    npc_ashliAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (ScriptedInstance*)c->GetInstanceData();
    }

    ScriptedInstance *pInstance;
    uint32 CheckTimer;
    bool EventStarted;
    bool Move;
    bool Fire;
    bool FillTargets;
    bool BossKilled;
    bool YellAshliVaseDone[3];
    uint32 FreeMeTimer;
    uint32 MovePoint;
    std::list<uint64> targets;

    void Reset()
    {
        CheckTimer = 10000;
        EventStarted = false;
        MovePoint = 0;
        Move = false;
        Fire = false;
        BossKilled = false;
        FreeMeTimer = 0;
        targets.clear();
        for(uint8 i = 0; i<3; i++)
            YellAshliVaseDone[i] = false;
    }

    void EnterCombat(Unit *who) {}
    void JustDied(Unit *) {}

    void MovementInform(uint32 Type, uint32 Id)
    {
        if (Type != POINT_MOTION_TYPE)
            return;

        if(Id >= 6)
            return;

        Fire = true;
        targets.clear();
        std::list<Creature*> t = FindAllCreaturesWithEntry(23746, 25);
        for(std::list<Creature*>::iterator i = t.begin(); i != t.end(); ++i)
            targets.push_back((*i)->GetGUID());

    }

    void SpellHitTarget(Unit *target, const SpellEntry *entry)
    {
        GameObject *go = FindGameObject(GO_ASHLI_VASE, 25, target);
        if(!YellAshliVaseDone[1] && MovePoint == 3)
        {
            DoScriptText(YELL_ASHLI_VASE2, me);
            YellAshliVaseDone[1] = true;
        }
        if(!YellAshliVaseDone[2] && MovePoint == 6)
        {
            DoScriptText(YELL_ASHLI_VASE3, me);
            YellAshliVaseDone[2] = true;
        }
        if(go)
            go->Delete();
    }

    void UpdateAI(const uint32 diff)
    {
        if(!EventStarted && pInstance)
        {
            if(FreeMeTimer)
            {
                if(FreeMeTimer < diff)
                {
                    DoScriptText(RAND(YELL_ASHLI_FREE_ME1, YELL_ASHLI_FREE_ME2, YELL_ASHLI_FREE_ME3), me);
                    FreeMeTimer = 20000;
                } else
                    FreeMeTimer -= diff;
            }

            if(CheckTimer < diff)
            {
                if(!BossKilled && pInstance->GetData(DATA_HOSTAGE_ASHLI_STATE) & HOSTAGE_SAVED)
                {
                    BossKilled = true;
                    DoScriptText(YELL_ASHLI_KILL, me);
                    FreeMeTimer = 20000;
                }
                if(pInstance->GetData(DATA_HOSTAGE_ASHLI_STATE) & HOSTAGE_FREED)
                {
                    Move = true;
                    EventStarted = true;
                    DoScriptText(YELL_ASHLI_FREED, me);
                }
                CheckTimer = 800;
            } else
                CheckTimer -= diff;
        }

        if(Fire && !me->hasUnitState(UNIT_STAT_CASTING))
        {
            Unit *target = NULL;
            if(!targets.empty())
            {
                target = me->GetUnit(targets.front());
                targets.pop_front();
            }
            if(target)
            {
                me->CastSpell(target, SPELL_ASHLI_FIREBALL1, false);
                if(!YellAshliVaseDone[0] && MovePoint == 1)
                {
                    DoScriptText(YELL_ASHLI_VASE1, me);
                    YellAshliVaseDone[0] = true;
                }
            }
            else
            {
                Fire = false;
                Move = true;
                MovePoint++;
                if(MovePoint == 6)
                {
                    GameObject *target = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_CHEST_ASHLI));
                    if(target)
                    {
                        target->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                        pInstance->SetData(DATA_HOSTAGE_ASHLI_STATE, HOSTAGE_CHEST_UNLOCKED);
                    }
                }
            }
        }

        if(Move)
        {
            me->GetMotionMaster()->MovePoint(MovePoint, AshliWP[MovePoint][0], AshliWP[MovePoint][1], AshliWP[MovePoint][2]);
            Move = false;
        }
    }
};

CreatureAI* GetAI_npc_ashli(Creature *_Creature)
{
    return new npc_ashliAI(_Creature);
}

bool GOUse_go_zulaman_cage(Player* pPlayer, GameObject* pGo)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)pGo->GetInstanceData();
    if(!pInstance)
        return true;

    int i = GetHostageIndex(pGo->GetEntry());
    if(pInstance->GetData(DATA_HOSTAGE_0_STATE + i) & HOSTAGE_SAVED)
    {
        pInstance->SetData(DATA_HOSTAGE_0_STATE + i, HOSTAGE_FREED);
        pGo->SetGoState(GO_STATE_ACTIVE);
        return false;
    }
    return true;
}

bool GOUse_go_zulaman_timed_event_chest(Player* pPlayer, GameObject* pGo)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)pGo->GetInstanceData();
    if(!pInstance)
        return true;

    int i = GetHostageIndex(pGo->GetEntry());
    if(pInstance->GetData(DATA_HOSTAGE_0_STATE + i) & HOSTAGE_CHEST_UNLOCKED)
    {
        pInstance->SetData(DATA_HOSTAGE_0_STATE + i, HOSTAGE_CHEST_LOOTED);
        return false;
    }
    return false;
}

bool GossipHello_npc_tanzar(Player* player, Creature* _Creature)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)_Creature->GetInstanceData();
    if(!pInstance)
        return false;

    if(pInstance->GetData(DATA_HOSTAGE_TANZAR_STATE) >= HOSTAGE_CHEST_UNLOCKED)
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_TANZAR_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(25025, _Creature->GetGUID());
    } else
        return false;

    return true;
}

bool GossipSelect_npc_tanzar(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    switch(action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_TANZAR_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(25026, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            player->SEND_GOSSIP_MENU(25027, _Creature->GetGUID());
            break;
    }
    return true;
}

bool GossipHello_npc_harkor(Player* player, Creature* _Creature)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)_Creature->GetInstanceData();
    if(!pInstance)
        return false;

    if(pInstance->GetData(DATA_HOSTAGE_HARKOR_STATE) >= HOSTAGE_CHEST_UNLOCKED )
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_HARKOR_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(25028, _Creature->GetGUID());
    } else
        return false;

    return true;
}

bool GossipSelect_npc_harkor(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    switch(action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->SEND_GOSSIP_MENU(25029, _Creature->GetGUID());
            break;
    }
    return true;
}

bool GossipHello_npc_kraz(Player* player, Creature* _Creature)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)_Creature->GetInstanceData();
    if(!pInstance)
        return false;

    if(pInstance->GetData(DATA_HOSTAGE_KRAZ_STATE) >= HOSTAGE_CHEST_UNLOCKED)
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_KRAZ_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(25030, _Creature->GetGUID());
    } else
        return false;

    return true;
}

bool GossipSelect_npc_kraz(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    switch(action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->SEND_GOSSIP_MENU(25031, _Creature->GetGUID());
            break;
    }
    return true;
}

bool GossipHello_npc_ashli(Player* player, Creature* _Creature)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)_Creature->GetInstanceData();
    if(!pInstance)
        return false;

    if(pInstance->GetData(DATA_HOSTAGE_ASHLI_STATE) & HOSTAGE_SAVED)
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ASHLI_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(25032, _Creature->GetGUID());
    }
    else if(pInstance->GetData(DATA_HOSTAGE_ASHLI_STATE) >= HOSTAGE_CHEST_UNLOCKED )
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ASHLI_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        player->SEND_GOSSIP_MENU(25033, _Creature->GetGUID());
    } else
        return false;

    return true;
}

bool GossipSelect_npc_ashli(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    switch(action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->CLOSE_GOSSIP_MENU();
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            player->SEND_GOSSIP_MENU(25034, _Creature->GetGUID());
            break;
    }
    return true;
}

/*######
## npc_harrison_jones_za
######*/

enum
{
    SAY_START               = -1568079,
    SAY_AT_GONG             = -1568080,
    SAY_OPENING_ENTRANCE    = -1568081,
    SAY_OPEN_GATE           = -1568082,

    SPELL_BANGING_THE_GONG  = 45222,

    SOUND_GONG              = 12204,
    SOUND_CELEBRATE         = 12135
};

#define GOSSIP_ITEM_BEGIN "Thanks for the concern, but we intend to explore Zul'Aman."

struct npc_harrison_jones_zaAI : public npc_escortAI
{
    npc_harrison_jones_zaAI(Creature* pCreature) : npc_escortAI(pCreature)
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        RespawnDelay = me->GetRespawnDelay();
        Reset();
    }

    ScriptedInstance* m_pInstance;
    uint32 RespawnDelay;

    void DamageTaken(Unit* done_by, uint32 &damage)
    {
        // if hitted by Amani'shi Guardian, killed immediately
        if(done_by->GetTypeId() == TYPEID_UNIT && damage)
        {
            damage = me->GetMaxHealth();
            done_by->GetMotionMaster()->MoveChase(GetPlayerForEscort());
        }
    }

    void WaypointReached(uint32 uiPointId)
    {
        if (!m_pInstance)
            return;

        switch(uiPointId)
        {
            case 2:
                //modify respawn if event fails (out of LOS)
                me->SetRespawnDelay(10); // then sec for a nice respawn effect
                
                DoScriptText(SAY_AT_GONG, me);

                if (GameObject* pEntranceDoor = m_pInstance->instance->GetGameObject(m_pInstance->GetData64(DATA_GO_GONG)))
                    pEntranceDoor->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOTSELECTABLE);

                //Start bang gong for 10min
                me->CastSpell(me, SPELL_BANGING_THE_GONG, false);
                SetEscortPaused(true);
                break;
            case 3:
                DoScriptText(SAY_OPENING_ENTRANCE, me);
                break;
            case 4:
                DoScriptText(SAY_OPEN_GATE, me);
                break;
            case 5:
                m_pInstance->SetData(TYPE_EVENT_RUN,SPECIAL);
                me->SetRespawnDelay(RespawnDelay);
                break;
            case 6:
                std::list<Creature*> trolls = FindAllCreaturesWithEntry(23889, 100);
                for(std::list<Creature *>::iterator i = trolls.begin(); i != trolls.end(); i++)
                {
                    (*i)->AI()->DoZoneInCombat();
                    (*i)->AddThreat(me, 1000);
                }
                trolls = FindAllCreaturesWithEntry(23597, 100);
                for(std::list<Creature *>::iterator i = trolls.begin(); i != trolls.end(); i++)
                {
                    (*i)->AI()->DoZoneInCombat();
                    (*i)->AddThreat(me, 1000);
                }
//                ((Creature*)Guardian)->GetMotionMaster()->MoveChase(me);
                SetEscortPaused(true);
                DoGlobalScriptText(SAY_INST_BEGIN, HEXLORD, me->GetMap());
                break;
                //TODO: Spawn group of Amani'shi Savage and make them run to entrance
        }
    }

    void Reset()
    {
        me->RemoveAllAuras();
        me->setActive(true);    // very important due to grid issues
        //if event not started respawn on reset
        if (m_pInstance->GetData(TYPE_EVENT_RUN) == NOT_STARTED)
            me->Respawn();
    }

    void StartEvent(Player* pPlayer)
    {
        DoScriptText(SAY_START, me);
        Start(true, false, pPlayer->GetGUID(), 0, true, true);
    }

    void SetHoldState(bool bOnHold)
    {
        SetEscortPaused(bOnHold);

        me->InterruptNonMeleeSpells(false);
        //Stop banging gong if still
        if (me->HasAura(SPELL_BANGING_THE_GONG, 0))
        {
            me->RemoveAurasDueToSpell(SPELL_BANGING_THE_GONG);
            DoPlaySoundToSet(me, SOUND_CELEBRATE);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        npc_escortAI::UpdateAI(diff);
    }
};

bool GossipHello_npc_harrison_jones_za(Player* pPlayer, Creature* pCreature)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)pCreature->GetInstanceData();

    if (pCreature->isQuestGiver())
        pPlayer->PrepareQuestMenu(pCreature->GetGUID());

    if (pInstance && pInstance->GetData(TYPE_EVENT_RUN) == NOT_STARTED)
        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BEGIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    pPlayer->SEND_GOSSIP_MENU(pCreature->GetNpcTextId(), pCreature->GetGUID());
    return true;
}

bool GossipSelect_npc_harrison_jones_za(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
{
    if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
    {
        if (npc_harrison_jones_zaAI* pHarrisonAI = dynamic_cast<npc_harrison_jones_zaAI*>(pCreature->AI()))
            pHarrisonAI->StartEvent(pPlayer);

        pPlayer->CLOSE_GOSSIP_MENU();
    }
    return true;
}

CreatureAI* GetAI_npc_harrison_jones_za(Creature* pCreature)
{
    return new npc_harrison_jones_zaAI(pCreature);
}

/*######
## go_strange_gong
######*/

bool GOUse_go_strange_gong(Player* pPlayer, GameObject* pGo)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)pGo->GetInstanceData();

    if (!pInstance || pPlayer->HasAura(SPELL_BANGING_THE_GONG, 0))
        return false;

    pPlayer->CastSpell(pPlayer, SPELL_BANGING_THE_GONG, false);
    return false;
}

struct npc_zulaman_door_triggerAI : public Scripted_NoMovementAI
{
    npc_zulaman_door_triggerAI(Creature *c) : Scripted_NoMovementAI(c)
    {
        pInstance = (ScriptedInstance*)c->GetInstanceData();
        Reset();
    }

    ScriptedInstance* pInstance;
    uint32 CheckTimer;
    uint32 StoperTime;

    uint32 CountChannelingPlayers()
    {
        uint32 count = 0;
        Map::PlayerList const& players = me->GetMap()->GetPlayers();
        if (!players.isEmpty())
        {
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* plr = itr->getSource())
                {
                    if(plr->HasAura(SPELL_BANGING_THE_GONG, 0))
                        count += (plr->isGameMaster()) ? 5 : 1; //possibility for gamemaster to start this event solo
                }
            }
        }
        return count;
    }

    void StopBanging()
    {
        Map::PlayerList const& players = me->GetMap()->GetPlayers();
        if (!players.isEmpty())
        {
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* plr = itr->getSource())
                {
                    if(plr->HasAura(SPELL_BANGING_THE_GONG, 0))
                        plr->InterruptNonMeleeSpells(false);
                }
            }
        }
    }

    void Reset()
    {
        StoperTime = 0;
        CheckTimer = 2000;
    }

    void UpdateAI(const uint32 diff)
    {
        if(CheckTimer < diff)
        {
            if(CountChannelingPlayers() >= 5)
                StoperTime += (2000+diff);
            CheckTimer = 2000;
        }
        else
            CheckTimer -= diff;

        if(StoperTime >= 30000) // to be verified
        {
            StopBanging();
            if(Creature* pCreature = me->GetMap()->GetCreature(pInstance->GetData64(DATA_HARRISON)))
            {
                if (npc_harrison_jones_zaAI* pHarrisonAI = dynamic_cast<npc_harrison_jones_zaAI*>(pCreature->AI()))
                    pHarrisonAI->SetHoldState(false);
            }
            if(GameObject* pGo = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_GO_GONG)))
                pGo->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOTSELECTABLE);
            
            Map* m = me->GetMap();
            Player *creditedPlayer = m->GetPlayers().begin() != m->GetPlayers().end() ? m->GetPlayers().begin()->getSource() : NULL;
            ((InstanceMap *)m)->PermBindAllPlayers(creditedPlayer);

            StoperTime = 0;
        }
    }
};

CreatureAI* GetAI_npc_zulaman_door_trigger(Creature *_Creature)
{
    return new npc_zulaman_door_triggerAI(_Creature);
}

/*####################
# Akilzon Gauntlet event
#######################*/

enum AkilzonGauntletEvent
{
    AKILZON_GAUNTLET_NOT_STARTED        = 0,
    AKILZON_GAUNTLET_IN_PROGRESS        = 10,
    AKILZON_GAUNTLET_TEMPEST_ENGAGED    = 11,
    AKILZON_GAUNTLET_TEMPEST_DEAD       = 12,

    NPC_AMANISHI_WARRIOR            = 24225,
    NPC_AMANISHI_EAGLE              = 24159,
    SPELL_TALON                     = 43517,
    SPELL_CHARGE                    = 43519,
    SPELL_KICK                      = 43518,
    SAY_GAUNTLET_START           = -1568025
};

int32 GauntletWP[][3] =
{
    { 226, 1492, 26 },
    { 227, 1439, 26 },
    { 227, 1369, 48 },
    { 284, 1379, 49 },
    { 301, 1385, 58 },
};

struct npc_amanishi_lookoutAI : public ScriptedAI
{
    npc_amanishi_lookoutAI(Creature *c) : ScriptedAI(c), Summons(c)
    {
        pInstance = c->GetInstanceData();
        me->setActive(true);
    }

    ScriptedInstance *pInstance;

    bool EventStarted;
    bool Move;
    uint8 MovePoint;
    SummonList Summons;

    uint32 warriorsTimer;
    uint32 eaglesTimer;

    void Reset()
    {
        me->SetReactState(REACT_AGGRESSIVE);
        me->SetVisibility(VISIBILITY_ON);
        me->setActive(true);
        EventStarted = false;
        warriorsTimer = 40000;
        eaglesTimer = 1000;
        Move = false;
        Summons.DespawnAll();

        if(pInstance)
            pInstance->SetData(DATA_AKILZONGAUNTLET, AKILZON_GAUNTLET_NOT_STARTED);
    }

    void StartEvent()
    {
        me->SetUnitMovementFlags(0);
        me->GetMotionMaster()->MovePoint(0, 226, 1461, 26);
        EventStarted = true;
        DoZoneInCombat();
        if(pInstance && pInstance->GetData(DATA_AKILZONEVENT) != DONE)
            DoGlobalScriptText(SAY_GAUNTLET_START, AKILZON, me->GetMap());
    }

    void JustDied(Unit* Killer)
    {
        if(Killer != me)
        {
            me->Respawn();
            me->AI()->EnterEvadeMode();
        }
    }


    void JustSummoned(Creature* summoned)
    {
        Summons.Summon(summoned);
    }


    void SummonedCreatureDespawn(Creature *summon)
    {
        Summons.Despawn(summon);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if(me->getVictim())
            return;

        if (me->canStartAttack(who))
        {
            AttackStart(who);
            who->CombatStart(me);
            StartEvent();
            if(pInstance)
                pInstance->SetData(DATA_AKILZONGAUNTLET, AKILZON_GAUNTLET_IN_PROGRESS);
        }
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if(type == POINT_MOTION_TYPE)
        {
            if(id > 3)
            {
                me->SetVisibility(VISIBILITY_OFF);
                me->SetReactState(REACT_PASSIVE);
            }
            else
            {
                Move = true;
                MovePoint = id + 1;
            }
        }
    }

    void AttackStart(Unit *pWho)
    {
        me->Attack(pWho, true);
    }

    void UpdateAI(const uint32 diff)
    {
        // Event started by entering combat with gauntlet mob
        if(!EventStarted && pInstance && pInstance->GetData(DATA_AKILZONGAUNTLET) != AKILZON_GAUNTLET_NOT_STARTED)
        {
            StartEvent();
        }

        if(Move)
        {
            me->GetMotionMaster()->MovePoint(MovePoint, GauntletWP[MovePoint][0], GauntletWP[MovePoint][1], GauntletWP[MovePoint][2]);
            Move = false;
        }

        else if (pInstance && pInstance->GetData(DATA_AKILZONGAUNTLET) == AKILZON_GAUNTLET_IN_PROGRESS)
        {
            if(warriorsTimer < diff)
            {
                for(uint8 i = 0; i < 2; i++)
                    me->SummonCreature(NPC_AMANISHI_WARRIOR, GauntletWP[0][0] + 2*i, GauntletWP[0][1] + 2*i, GauntletWP[0][2], 3.1415f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                warriorsTimer = 40000;
            }
            else
                warriorsTimer -= diff;

            if(eaglesTimer < diff)
            {
                uint8 maxEagles = RAND(5, 6);
                for(uint8 i = 0; i < maxEagles; i++)
                    me->SummonCreature(NPC_AMANISHI_EAGLE, GauntletWP[4][0] + 2*(i%2)-4, GauntletWP[4][1] + 2*(i/2) - 4, GauntletWP[4][2], 3.1415f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                eaglesTimer = 25000;
            }
            else
                eaglesTimer -= diff;
        }

        else if(pInstance && pInstance->GetData(DATA_AKILZONGAUNTLET) == AKILZON_GAUNTLET_TEMPEST_DEAD)
        {
            me->Kill(me, false);
            me->ForcedDespawn(0);
        }

        if(EventStarted && !UpdateVictim())
        {
            Reset();
        }
    }
};

CreatureAI* GetAI_npc_amanishi_lookout(Creature *_Creature)
{
    return new npc_amanishi_lookoutAI (_Creature);
}

struct npc_amanishi_warriorAI : public npc_escortAI
{
    npc_amanishi_warriorAI(Creature *c) : npc_escortAI(c)
    {
        pInstance = c->GetInstanceData();
        me->setActive(true);
        SetDespawnAtEnd(false);
        Reset();
    }

    ScriptedInstance *pInstance;

    uint32 KickTimer;
    uint32 ChargeTimer;

    void Reset()
    {
        Start(true, true);
        KickTimer = 9000;
        ChargeTimer = 2000;
    }

    void UpdateEscortAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(KickTimer < diff)
        {
            DoCast(me->getVictim(), SPELL_KICK);
            KickTimer = 9000;
        } else
            KickTimer -= diff;

        if(ChargeTimer < diff)
        {
            DoCast(me->getVictim(), SPELL_CHARGE);
            ChargeTimer = 5000;
        } else
            ChargeTimer -= diff;

        DoMeleeAttackIfReady();
    }

    void WaypointReached(uint32 )
    {
    }
};

CreatureAI* GetAI_npc_amanishi_warrior(Creature *_Creature)
{
    npc_escortAI* ai = new npc_amanishi_warriorAI (_Creature);
    ai->AddWaypoint(0, GauntletWP[1][0], GauntletWP[1][1], GauntletWP[1][2]);
    ai->AddWaypoint(1, GauntletWP[2][0], GauntletWP[2][1], GauntletWP[2][2]);
    ai->AddWaypoint(2, GauntletWP[3][0], GauntletWP[3][1], GauntletWP[3][2]);
    ai->AddWaypoint(3, GauntletWP[4][0], GauntletWP[4][1], GauntletWP[4][2]);
    return ai;
}

struct npc_amani_eagleAI : public npc_escortAI
{
    npc_amani_eagleAI(Creature *c) : npc_escortAI(c)
    {
        pInstance = c->GetInstanceData();
        me->setActive(true);
        SetDespawnAtEnd(false);
        Reset();
    }

    ScriptedInstance *pInstance;
    uint32 TalonTimer;

    void Reset()
    {
        Start(true, true);
        TalonTimer = 10000;
    }

    void UpdateEscortAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(TalonTimer < diff)
        {
            DoCast(me->getVictim(), SPELL_TALON);
            TalonTimer = 10000;
        } else
            TalonTimer -= diff;

        DoMeleeAttackIfReady();
    }
    void WaypointReached(uint32 )
    {
    }
};

CreatureAI* GetAI_npc_amani_eagle(Creature *_Creature)
{
    npc_escortAI* ai = new npc_amani_eagleAI (_Creature);
    ai->AddWaypoint(0, GauntletWP[3][0], GauntletWP[3][1], GauntletWP[3][2]);
    ai->AddWaypoint(1, GauntletWP[2][0], GauntletWP[2][1], GauntletWP[2][2]);
    ai->AddWaypoint(2, GauntletWP[1][0], GauntletWP[1][1], GauntletWP[1][2]);
    ai->AddWaypoint(3, GauntletWP[0][0], GauntletWP[0][1], GauntletWP[0][2]);
    return ai;
}

enum AmanishiScout
{
    YELL_SCOUT_AGGRO        = -1811003,
    SPELL_ALERT_DRUMS       =    42177,
    SPELL_SUMMON_SENTRIES1  =    42183,
    SPELL_SUMMON_SENTRIES2  =    42182,
    SPELL_SUMMON_SENTRIES3  =    42181,
    MOB_SENTRY              =    23587
};

struct npc_amanishi_scoutAI : public ScriptedAI
{
    npc_amanishi_scoutAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance *pInstance;
    uint32 SummonTimer;

    void Reset()
    {
        SummonTimer = 0;
        me->GetMotionMaster()->Initialize();
    }

    void AttackStart(Unit *pWho)
    {
        me->Attack(pWho, true);
    }

    void JustSummoned(Creature *c)
    {
        c->AI()->AttackStart(me->getVictim());
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if(type == POINT_MOTION_TYPE && id == 1)
            SummonTimer = 1;
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(YELL_SCOUT_AGGRO, me);
        me->SetWalk(false);
        Unit *drums = FindCreature(22515, 50, me);
        if(drums)
            me->GetMotionMaster()->MovePoint(1, drums->GetPositionX(), drums->GetPositionY(), drums->GetPositionZ());
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(SummonTimer)
        {
            if(SummonTimer <= diff)
            {
                m_creature->GetMotionMaster()->Clear();
                DoCast(me, SPELL_ALERT_DRUMS, false);
                DoCast(me, SPELL_SUMMON_SENTRIES1, false);
                DoCast(me, SPELL_SUMMON_SENTRIES2, false);
                if (urand(0, 100) < 25)
                DoCast(me, SPELL_SUMMON_SENTRIES3, false);

                SummonTimer = urand(2000, 3000);
            } else
                SummonTimer -= diff;
        }
    }
};

CreatureAI* GetAI_npc_amanishi_scout(Creature *_Creature)
{
    return new npc_amanishi_scoutAI (_Creature);
}


struct npc_zulaman_zuljinevent_triggerAI : public Scripted_NoMovementAI
{
    npc_zulaman_zuljinevent_triggerAI(Creature *c) : Scripted_NoMovementAI(c)
    {
        pInstance = (ScriptedInstance*)c->GetInstanceData();
        Reset();
    }

    ScriptedInstance* pInstance;

    void Reset() 
    {
    }

    void MoveInLineOfSight(Unit* pPlayer)
    {
        if (pPlayer->GetDistance2d(me) < 15.0f && 
           (pInstance->GetData(DATA_HEXLORDEVENT) == DONE) && pInstance->GetData(DATA_ZJ_EVENT) == false)
        {
            pInstance->SetData(DATA_ZJ_EVENT, 1);
            for (uint32 i = 0; i < 15; i++)
            {
                if (Creature *troll = me->SummonCreature(23889, 105.14f, 811.48f, 33.4f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                {
                    troll->GetMotionMaster()->MoveChase(pPlayer, 1.0f, 1.0f);
                    troll->SetSpeed(MOVE_RUN, frand(1.0f, 2.0f), true);
                }
            }

            for (uint32 i = 0; i < 15 ; i++)
            {
                if (Creature *troll = me->SummonCreature(23889, 137.01f, 813.24f, 33.4f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                {
                    troll->GetMotionMaster()->MoveChase(pPlayer, 1.0f, 1.0f);
                    troll->SetSpeed(MOVE_RUN, frand(1.0f, 2.0f), true);
                }
            }
        }
    }

    void UpdateAI(const uint32 diff) {}

};


CreatureAI* GetAI_npc_zulaman_zuljinevent_trigger(Creature *_Creature)
{
    return new npc_zulaman_zuljinevent_triggerAI (_Creature);
}

#define SPELL_HARMSTRING        9080
#define SPELL_REND              12054
#define SPELL_SUNDER_ARMOR      11971

struct mob_amanshi_savageAI : public ScriptedAI
{
    mob_amanshi_savageAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance *pInstance;
    uint32 HarmstringTimer, RendTimer, SunderArmorTimer;

    void Reset()
    {
        HarmstringTimer = 2000;
        RendTimer = 6000;
        SunderArmorTimer = 8000;
    }

    void EnterCombat(Unit *who)
    {
        if (Creature *ZulJin = pInstance->GetCreature(pInstance->GetData64(DATA_ZULJINEVENT)))
            ZulJin->AI()->AttackStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(HarmstringTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_HARMSTRING, false);
            HarmstringTimer = 10000;
        } else
            HarmstringTimer -= diff;

        if(RendTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_REND, false);
            RendTimer = 20000;
        } else
            RendTimer -= diff;

        if(SunderArmorTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_SUNDER_ARMOR, false);
            SunderArmorTimer = 5000;
        } else
            SunderArmorTimer -= diff;
        
        DoMeleeAttackIfReady();
    }

};

CreatureAI* GetAI_mob_amanshi_savage(Creature *_Creature)
{
    return new mob_amanshi_savageAI (_Creature);
}

void AddSC_zulaman()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_amanishi_scout";
    newscript->GetAI = &GetAI_npc_amanishi_scout;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_amanishi_warrior";
    newscript->GetAI = &GetAI_npc_amanishi_warrior;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_amani_eagle";
    newscript->GetAI = &GetAI_npc_amani_eagle;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_amanishi_lookout";
    newscript->GetAI = &GetAI_npc_amanishi_lookout;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_forest_frog";
    newscript->GetAI = &GetAI_npc_forest_frog;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_ashli";
    newscript->GetAI = &GetAI_npc_ashli;
    newscript->pGossipHello = &GossipHello_npc_ashli;
    newscript->pGossipSelect = &GossipSelect_npc_ashli;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_kraz";
    newscript->GetAI = &GetAI_npc_kraz;
    newscript->pGossipHello = &GossipHello_npc_kraz;
    newscript->pGossipSelect = &GossipSelect_npc_kraz;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_harkor";
    newscript->GetAI = &GetAI_npc_harkor;
    newscript->pGossipHello = &GossipHello_npc_harkor;
    newscript->pGossipSelect = &GossipSelect_npc_harkor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_tanzar";
    newscript->GetAI = &GetAI_npc_tanzar;
    newscript->pGossipHello = &GossipHello_npc_tanzar;
    newscript->pGossipSelect = &GossipSelect_npc_tanzar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_zulaman_cage";
    newscript->pGOUse = &GOUse_go_zulaman_cage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_zulaman_timed_event_chest";
    newscript->pGOUse = &GOUse_go_zulaman_timed_event_chest;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_harrison_jones_za";
    newscript->GetAI = &GetAI_npc_harrison_jones_za;
    newscript->pGossipHello = &GossipHello_npc_harrison_jones_za;
    newscript->pGossipSelect = &GossipSelect_npc_harrison_jones_za;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_strange_gong";
    newscript->pGOUse = &GOUse_go_strange_gong;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_zulaman_door_trigger";
    newscript->GetAI = &GetAI_npc_zulaman_door_trigger;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_zulaman_zuljinevent_trigger";
    newscript->GetAI = &GetAI_npc_zulaman_zuljinevent_trigger;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_amanshi_savage";
    newscript->GetAI = &GetAI_mob_amanshi_savage;
    newscript->RegisterSelf();
}
