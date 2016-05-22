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
SDName: Dustwallow_Marsh
SD%Complete: 95
SDComment: Quest support: 1270, 1222, 11180, 558, 11126, 11174. Vendor Nat Pagle
SDCategory: Dustwallow Marsh
EndScriptData */

/* ContentData
npc_cassa_crimsonwing
mobs_risen_husk_spirit
npc_restless_apparition
npc_deserter_agitator
npc_dustwallow_lady_jaina_proudmoore
npc_nat_pagle
npc_theramore_combat_dummy
mob_mottled_drywallow_crocolisks
npc_morokk
npc_ogron
npc_private_hendel
npc_stinky
mob_swamp_ooze
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"
#include "Object.h"

/*######
## npc_cassa_crimsonwing
######*/

#define GOSSIP_SURVEY_ALCAZ_ISLAND "Lady Jaina told me to speak to you about using a Gryphon to survey Alcaz Island."

bool GossipHello_npc_cassa_crimsonwing(Player *player, Creature *_Creature)
{
    if( player->GetQuestStatus(11142) == QUEST_STATUS_INCOMPLETE)
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_SURVEY_ALCAZ_ISLAND, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
    }

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(),_Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_cassa_crimsonwing(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        player->CLOSE_GOSSIP_MENU();
        _Creature->CastSpell(player,42295,false);               //TaxiPath 724
    }
    return true;
}

/*######
## mobs_risen_husk_spirit
######*/

#define SPELL_SUMMON_RESTLESS_APPARITION    42511
#define SPELL_CONSUME_FLESH                 37933           //Risen Husk
#define SPELL_INTANGIBLE_PRESENCE           43127           //Risen Spirit

struct mobs_risen_husk_spiritAI : public ScriptedAI
{
    mobs_risen_husk_spiritAI(Creature *c) : ScriptedAI(c) {}

    uint32 ConsumeFlesh_Timer;
    uint32 IntangiblePresence_Timer;

    void Reset()
    {
        ConsumeFlesh_Timer = 10000;
        IntangiblePresence_Timer = 5000;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if( done_by->GetTypeId() == TYPEID_PLAYER )
            if( damage >= m_creature->GetHealth() && ((Player*)done_by)->GetQuestStatus(11180) == QUEST_STATUS_INCOMPLETE )
                m_creature->CastSpell(done_by,SPELL_SUMMON_RESTLESS_APPARITION,false);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if( ConsumeFlesh_Timer < diff )
        {
            if( m_creature->GetEntry() == 23555 )
                DoCast(m_creature,SPELL_CONSUME_FLESH);
            ConsumeFlesh_Timer = 15000;
        } else ConsumeFlesh_Timer -= diff;

        if( IntangiblePresence_Timer < diff )
        {
            if( m_creature->GetEntry() == 23554 )
                DoCast(m_creature,SPELL_INTANGIBLE_PRESENCE);
            IntangiblePresence_Timer = 20000;
        } else IntangiblePresence_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_mobs_risen_husk_spirit(Creature *_Creature)
{
    return new mobs_risen_husk_spiritAI (_Creature);
}

/*######
## npc_restless_apparition
######*/

bool GossipHello_npc_restless_apparition(Player *player, Creature *_Creature)
{
    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    player->TalkedToCreature(_Creature->GetEntry(), _Creature->GetGUID());
    _Creature->SetInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

    return true;
}

/*######
## npc_deserter_agitator
######*/

struct npc_deserter_agitatorAI : public ScriptedAI
{
    npc_deserter_agitatorAI(Creature *c) : ScriptedAI(c) {}

    uint32 switchfaction_timer;

    void Reset()
    {
        m_creature->setFaction(894);
        switchfaction_timer = 120000;
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
        {
            if (switchfaction_timer < diff)
            {
                m_creature->setFaction(894);
                switchfaction_timer = 120000;
            }
            else
                switchfaction_timer -= diff;
            return;
        }

        /*
        Some AI TODO here
        */

        DoMeleeAttackIfReady();
        
    }
};

CreatureAI* GetAI_npc_deserter_agitator(Creature *_Creature)
{
    return new npc_deserter_agitatorAI (_Creature);
}

bool GossipHello_npc_deserter_agitator(Player *player, Creature *_Creature)
{
    if (player->GetQuestStatus(11126) == QUEST_STATUS_INCOMPLETE)
    {
        _Creature->setFaction(16);
        _Creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2);
        _Creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PASSIVE);
        player->TalkedToCreature(_Creature->GetEntry(), _Creature->GetGUID());
    }
    else
        player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

/*######
## npc_dustwallow_lady_jaina_proudmoore - TODO: should also have own scripted AI when horde attacks her
######*/

#define GOSSIP_ITEM_JAINA "I know this is rather silly but i have a young ward who is a bit shy and would like your autograph."
#define GOSSIP_TELE_TO_STORMWIND "I'm ready to travel to Stormwind."

struct npc_dustwallow_lady_jaina_proudmooreAI : public ScriptedAI
{
    npc_dustwallow_lady_jaina_proudmooreAI(Creature *c) : ScriptedAI(c) {}

    void Reset() { }

    void EnterCombat(Unit *who) {}

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        /*
        Some AI TODO here
        */

        DoMeleeAttackIfReady();
    }
};

bool GossipHello_npc_dustwallow_lady_jaina_proudmoore(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if (player->GetQuestStatus(558) == QUEST_STATUS_INCOMPLETE )
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_JAINA, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO);

    if (player->GetQuestStatus(11222) == QUEST_STATUS_COMPLETE && !player->GetQuestRewardStatus(11222))   // Warn Bolvar!
        player->ADD_GOSSIP_ITEM(0, GOSSIP_TELE_TO_STORMWIND, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_dustwallow_lady_jaina_proudmoore(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_SENDER_INFO)
    {
        player->SEND_GOSSIP_MENU( 7012, _Creature->GetGUID() );
        player->CastSpell( player, 23122, false);
    }
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        player->CLOSE_GOSSIP_MENU();
        // teleport to Highlord Bolvar
        _Creature->CastSpell(player, 42710, true);
    }
    return true;
}

CreatureAI* GetAI_npc_dustwallow_lady_jaina_proudmoore(Creature *_creature)
{
    return new npc_dustwallow_lady_jaina_proudmooreAI(_creature);
}

/*######
## npc_nat_pagle
######*/

bool GossipHello_npc_nat_pagle(Player *player, Creature *_Creature)
{
    if(_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if(_Creature->isVendor() && player->GetQuestRewardStatus(8227))
    {
        player->ADD_GOSSIP_ITEM(1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
        player->SEND_GOSSIP_MENU( 7640, _Creature->GetGUID() );
    }
    else
        player->SEND_GOSSIP_MENU( 7638, _Creature->GetGUID() );

    return true;
}

bool GossipSelect_npc_nat_pagle(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    if(action == GOSSIP_ACTION_TRADE)
        player->SEND_VENDORLIST( _Creature->GetGUID() );

    return true;
}

/*######
## npc_theramore_combat_dummy
######*/

struct npc_theramore_combat_dummyAI : public Scripted_NoMovementAI
{
    npc_theramore_combat_dummyAI(Creature *c) : Scripted_NoMovementAI(c)  { }

    uint64 AttackerGUID;
    uint32 Check_Timer;

    void Reset()
    {
        m_creature->SetNoCallAssistance(true);
        m_creature->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STUN, true);
        AttackerGUID = 0;
        Check_Timer = 0;
    }

    void EnterCombat(Unit* who)
    {
        AttackerGUID = ((Player*)who)->GetGUID();
        m_creature->GetUnitStateMgr().PushAction(UNIT_ACTION_STUN, UNIT_ACTION_PRIORITY_END);
    }

    void DamageTaken(Unit *attacker, uint32 &damage)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        Player* attacker = Player::GetPlayer(AttackerGUID);

        if (!UpdateVictim())
            return;

        if (attacker && Check_Timer < diff)
        {
            if(m_creature->GetDistance2d(attacker) > 12.0f)
                EnterEvadeMode();

            Check_Timer = 3000;
        }
        else
            Check_Timer -= diff;
    }
};

CreatureAI* GetAI_npc_theramore_combat_dummy(Creature *_Creature)
{
    return new npc_theramore_combat_dummyAI (_Creature);
}

#define QUEST_THE_GRIMTOTEM_WEAPON      11169
#define AURA_CAPTURED_TOTEM             42454
#define NPC_CAPTURED_TOTEM              23811

/*######
## mob_mottled_drywallow_crocolisks
######*/

struct mob_mottled_drywallow_crocolisksAI : public ScriptedAI
{
   mob_mottled_drywallow_crocolisksAI(Creature *c) : ScriptedAI(c) {}

    void Reset() {}
    void JustDied (Unit* killer)
    {
        Player *pPlayer = NULL;

        if(!IS_PLAYER_GUID(killer->GetGUID()))
        {
            if(!IS_PLAYER_GUID(killer->GetCharmerOrOwnerGUID()))
                return;
            else
                pPlayer = killer->GetPlayer(killer->GetCharmerOrOwnerGUID());
        }
        else
            pPlayer = (Player*)killer;

        if(!pPlayer)
            return;

        if(pPlayer->GetQuestStatus(QUEST_THE_GRIMTOTEM_WEAPON) == QUEST_STATUS_INCOMPLETE)
        {
            if(Unit* totem = FindCreature(NPC_CAPTURED_TOTEM, 20.0, m_creature))   //blizzlike(?) check by dummy aura is NOT working, mysteriously...
                pPlayer->KilledMonster(NPC_CAPTURED_TOTEM, pPlayer->GetGUID());
        }
    }
    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_mottled_drywallow_crocolisks(Creature *_Creature)
{
    return new mob_mottled_drywallow_crocolisksAI (_Creature);
}

/*######
## npc_morokk
######*/

enum
{
    SAY_MOR_CHALLENGE               = -1800499,
    SAY_MOR_SCARED                  = -1800500,

    QUEST_CHALLENGE_MOROKK          = 1173,

    FACTION_MOR_HOSTILE             = 168,
    FACTION_MOR_RUNNING             = 35
};

struct npc_morokkAI : public npc_escortAI
{
    npc_morokkAI(Creature* pCreature) : npc_escortAI(pCreature)
    {
        m_bIsSuccess = false;
        Reset();
    }

    bool m_bIsSuccess;

    void Reset() {}

    void WaypointReached(uint32 uiPointId)
    {
        switch(uiPointId)
        {
            case 0:
                SetEscortPaused(true);
                break;
            case 1:
                if (m_bIsSuccess)
                    DoScriptText(SAY_MOR_SCARED, me);
                else
                {
                    me->setDeathState(JUST_DIED);
                    me->Respawn();
                }
                break;
        }
    }

    void AttackedBy(Unit* pAttacker)
    {
        if (me->getVictim())
            return;

        if (me->IsFriendlyTo(pAttacker))
            return;

        AttackStart(pAttacker);
    }

    void DamageTaken(Unit* pDoneBy, uint32 &uiDamage)
    {
        if (HasEscortState(STATE_ESCORT_ESCORTING))
        {
            if (me->GetHealth()*100 < me->GetMaxHealth()*30.0f)
            {
                if (Player* pPlayer = GetPlayerForEscort())
                    pPlayer->GroupEventHappens(QUEST_CHALLENGE_MOROKK, me);

                me->setFaction(FACTION_MOR_RUNNING);
                SetRun(true);

                m_bIsSuccess = true;
                EnterEvadeMode();

                uiDamage = 0;
            }
        }
    }

    void UpdateEscortAI(const uint32 uiDiff)
    {
        if (!me->getVictim())
        {
            if (HasEscortState(STATE_ESCORT_PAUSED))
            {
                if (Player* pPlayer = GetPlayerForEscort())
                {
                    m_bIsSuccess = false;
                    DoScriptText(SAY_MOR_CHALLENGE, me, pPlayer);
                    me->setFaction(FACTION_MOR_HOSTILE);
                    AttackStart(pPlayer);
                }

                SetEscortPaused(false);
            }

            return;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_morokk(Creature* pCreature)
{
    return new npc_morokkAI(pCreature);
}

bool QuestAccept_npc_morokk(Player* pPlayer, Creature* pCreature, const Quest* pQuest)
{
    if (pQuest->GetQuestId() == QUEST_CHALLENGE_MOROKK)
    {
        if (npc_morokkAI* pEscortAI = CAST_AI(npc_morokkAI, pCreature->AI()))
            pEscortAI->Start(true, false, pPlayer->GetGUID(), pQuest);

        return true;
    }

    return false;
}


/*######
## npc_ogron
######*/

enum
{
    SAY_OGR_START                       = -1800452,
    SAY_OGR_SPOT                        = -1800453,
    SAY_OGR_RET_WHAT                    = -1800454,
    SAY_OGR_RET_SWEAR                   = -1800455,
    SAY_OGR_REPLY_RET                   = -1800456,
    SAY_OGR_RET_TAKEN                   = -1800457,
    SAY_OGR_TELL_FIRE                   = -1800458,
    SAY_OGR_RET_NOCLOSER                = -1800459,
    SAY_OGR_RET_NOFIRE                  = -1800460,
    SAY_OGR_RET_HEAR                    = -1800461,
    SAY_OGR_CAL_FOUND                   = -1800462,
    SAY_OGR_CAL_MERCY                   = -1800463,
    SAY_OGR_HALL_GLAD                   = -1800464,
    EMOTE_OGR_RET_ARROW                 = -1800465,
    SAY_OGR_RET_ARROW                   = -1800466,
    SAY_OGR_CAL_CLEANUP                 = -1800467,
    SAY_OGR_NODIE                       = -1800468,
    SAY_OGR_SURVIVE                     = -1800469,
    SAY_OGR_RET_LUCKY                   = -1800470,
    SAY_OGR_THANKS                      = -1800471,

    QUEST_QUESTIONING                   = 1273,

    FACTION_GENERIC_FRIENDLY            = 35,
    FACTION_THER_HOSTILE                = 151,

    NPC_REETHE                          = 4980,
    NPC_CALDWELL                        = 5046,
    NPC_HALLAN                          = 5045,
    NPC_SKIRMISHER                      = 5044,

    SPELL_FAKE_SHOT                     = 7105,

    PHASE_INTRO                         = 0,
    PHASE_GUESTS                        = 1,
    PHASE_FIGHT                         = 2,
    PHASE_COMPLETE                      = 3
};

static float m_afSpawn[] = {-3383.501953f, -3203.383301f, 36.149f};
static float m_afMoveTo[] = {-3371.414795f, -3212.179932f, 34.210f};

struct npc_ogronAI : public npc_escortAI
{
    npc_ogronAI(Creature* pCreature) : npc_escortAI(pCreature)
    {
        lCreatureList.clear();
        m_uiPhase = 0;
        m_uiPhaseCounter = 0;
        Reset();
    }

    std::list<Creature*> lCreatureList;

    uint32 m_uiPhase;
    uint32 m_uiPhaseCounter;
    uint32 m_uiGlobalTimer;

    void Reset()
    {
        m_uiGlobalTimer = 5000;

        /*if (HasEscortState(STATE_ESCORT_PAUSED) && m_uiPhase == PHASE_FIGHT)
            m_uiPhase = PHASE_COMPLETE;*/

        if (!HasEscortState(STATE_ESCORT_ESCORTING))
        {
            lCreatureList.clear();
            m_uiPhase = 0;
            m_uiPhaseCounter = 0;
        }
    }

    void MoveInLineOfSight(Unit* pWho)
    {
        if (HasEscortState(STATE_ESCORT_ESCORTING) && pWho->GetEntry() == NPC_REETHE && lCreatureList.empty())
            lCreatureList.push_back((Creature*)pWho);

        npc_escortAI::MoveInLineOfSight(pWho);
    }

    void WaypointReached(uint32 uiPointId)
    {
        switch(uiPointId)
        {
            case 9:
                DoScriptText(SAY_OGR_SPOT, me);
                break;
            case 10:
                if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                    DoScriptText(SAY_OGR_RET_WHAT, pReethe);
                break;
            case 11:
                SetEscortPaused(true);
                break;
        }
    }

    void JustSummoned(Creature* pSummoned)
    {
        lCreatureList.push_back(pSummoned);

        pSummoned->setFaction(FACTION_GENERIC_FRIENDLY);

        if (pSummoned->GetEntry() == NPC_CALDWELL)
            pSummoned->GetMotionMaster()->MovePoint(0, m_afMoveTo[0], m_afMoveTo[1], m_afMoveTo[2]);
        else
        {
            if (Creature* pCaldwell = GetClosestCreatureWithEntry(me, NPC_CALDWELL, 15.0f))
            {
                //will this conversion work without compile warning/error?
                size_t iSize = lCreatureList.size();
                pSummoned->GetMotionMaster()->MoveFollow(pCaldwell, 0.5f, (M_PI/2)*(int)iSize);
            }
        }
    }

    void DoStartAttackMe()
    {
        if (!lCreatureList.empty())
        {
            for(std::list<Creature*>::iterator itr = lCreatureList.begin(); itr != lCreatureList.end(); ++itr)
            {
                if ((*itr)->GetEntry() == NPC_REETHE)
                    continue;

                if ((*itr)->isAlive())
                {
                    (*itr)->setFaction(FACTION_THER_HOSTILE);
                    (*itr)->AI()->AttackStart(me);
                }
            }
        }
    }

    void UpdateEscortAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
        {
            if (HasEscortState(STATE_ESCORT_PAUSED))
            {
                if (m_uiGlobalTimer < uiDiff)
                {
                    m_uiGlobalTimer = 5000;

                    switch(m_uiPhase)
                    {
                        case PHASE_INTRO:
                        {
                            switch(m_uiPhaseCounter)
                            {
                                case 0:
                                    if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                                        DoScriptText(SAY_OGR_RET_SWEAR, pReethe);
                                    break;
                                case 1:
                                    DoScriptText(SAY_OGR_REPLY_RET, me);
                                    break;
                                case 2:
                                    if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                                        DoScriptText(SAY_OGR_RET_TAKEN, pReethe);
                                    break;
                                case 3:
                                    DoScriptText(SAY_OGR_TELL_FIRE, me);
                                    if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                                        DoScriptText(SAY_OGR_RET_NOCLOSER, pReethe);
                                    break;
                                case 4:
                                    if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                                        DoScriptText(SAY_OGR_RET_NOFIRE, pReethe);
                                    break;
                                case 5:
                                    if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                                        DoScriptText(SAY_OGR_RET_HEAR, pReethe);

                                    me->SummonCreature(NPC_CALDWELL, m_afSpawn[0], m_afSpawn[1], m_afSpawn[2], 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                                    me->SummonCreature(NPC_HALLAN, m_afSpawn[0], m_afSpawn[1], m_afSpawn[2], 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                                    me->SummonCreature(NPC_SKIRMISHER, m_afSpawn[0], m_afSpawn[1], m_afSpawn[2], 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                                    me->SummonCreature(NPC_SKIRMISHER, m_afSpawn[0], m_afSpawn[1], m_afSpawn[2], 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);

                                    m_uiPhase = PHASE_GUESTS;
                                    break;
                            }
                            break;
                        }

                        case PHASE_GUESTS:
                        {
                            switch(m_uiPhaseCounter)
                            {
                                case 6:
                                    if (Creature* pCaldwell = GetClosestCreatureWithEntry(me, NPC_CALDWELL, 15.0f))
                                        DoScriptText(SAY_OGR_CAL_FOUND, pCaldwell);
                                    break;
                                case 7:
                                    if (Creature* pCaldwell = GetClosestCreatureWithEntry(me, NPC_CALDWELL, 15.0f))
                                        DoScriptText(SAY_OGR_CAL_MERCY, pCaldwell);
                                    break;
                                case 8:
                                    if (Creature* pHallan = GetClosestCreatureWithEntry(me, NPC_HALLAN, 15.0f))
                                    {
                                        DoScriptText(SAY_OGR_HALL_GLAD, pHallan);

                                        if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                                            pHallan->CastSpell(pReethe, SPELL_FAKE_SHOT, false);
                                    }
                                    break;
                                case 9:
                                    if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                                    {
                                        DoScriptText(EMOTE_OGR_RET_ARROW, pReethe);
                                        DoScriptText(SAY_OGR_RET_ARROW, pReethe);
                                    }
                                    break;
                                case 10:
                                    if (Creature* pCaldwell = GetClosestCreatureWithEntry(me, NPC_CALDWELL, 15.0f))
                                        DoScriptText(SAY_OGR_CAL_CLEANUP, pCaldwell);

                                    DoScriptText(SAY_OGR_NODIE, me);
                                    break;
                                case 11:
                                    DoStartAttackMe();
                                    m_uiPhase = PHASE_COMPLETE;
                                    break;
                            }
                            break;
                        }

                        case PHASE_COMPLETE:
                        {
                            switch(m_uiPhaseCounter)
                            {
                                case 12:
                                    if (Player* pPlayer = GetPlayerForEscort())
                                        pPlayer->GroupEventHappens(QUEST_QUESTIONING, me);
                                    DoScriptText(SAY_OGR_SURVIVE, me);
                                    break;
                                case 13:
                                    if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                                        DoScriptText(SAY_OGR_RET_LUCKY, pReethe);
                                    break;
                                case 14:
                                    if (Creature* pReethe = GetClosestCreatureWithEntry(me, NPC_REETHE, 15.0f))
                                        pReethe->setDeathState(JUST_DIED);
                                    break;
                                case 15:
                                    DoScriptText(SAY_OGR_THANKS, me);
                                    SetRun(true);
                                    SetEscortPaused(false);
                                    break;
                            }
                            break;
                        }
                    }
                        ++m_uiPhaseCounter;
                }
                else
                    m_uiGlobalTimer -= uiDiff;
            }

            return;
        }

        DoMeleeAttackIfReady();
    }
};

bool QuestAccept_npc_ogron(Player* pPlayer, Creature* pCreature, const Quest* pQuest)
{
    if (pQuest->GetQuestId() == QUEST_QUESTIONING)
    {
        pCreature->setFaction(FACTION_ESCORT_N_FRIEND_PASSIVE);
        DoScriptText(SAY_OGR_START, pCreature, pPlayer);

        if (npc_ogronAI* pEscortAI = CAST_AI(npc_ogronAI, (pCreature->AI())))
            pEscortAI->Start(false, false, pPlayer->GetGUID(), pQuest, true);
    }

    return true;
}

CreatureAI* GetAI_npc_ogron(Creature* pCreature)
{
    return new npc_ogronAI(pCreature);
}

/*######
## npc_private_hendel
######*/

enum eHendel
{
    SAY_PROGRESS_1_TER          = -1600413,
    SAY_PROGRESS_2_HEN          = -1600414,
    SAY_PROGRESS_3_TER          = -1600415,
    SAY_PROGRESS_4_TER          = -1600416,
    EMOTE_SURRENDER             = -1600417,

    QUEST_MISSING_DIPLO_PT16    = 1324,
    FACTION_HOSTILE             = 168,

    NPC_SENTRY                  = 5184,
    NPC_JAINA                   = 4968,
    NPC_TERVOSH                 = 4967,
    NPC_PAINED                  = 4965,

    PHASE_ATTACK                = 1,
    PHASE_COMPLETED             = 2
};

struct EventLocation
{
    float m_fX, m_fY, m_fZ;
};

EventLocation m_afEventMoveTo[] =
{
    {-2943.92f, -3319.41f, 29.8336f},
    {-2933.01f, -3321.05f, 29.5781f}

};

struct npc_private_hendelAI : public ScriptedAI
{
    npc_private_hendelAI(Creature* pCreature) : ScriptedAI(pCreature) { Reset(); }

    std::list<Creature*> lCreatureList;

    uint32 m_uiPhaseCounter;
    uint32 m_uiEventTimer;
    uint32 m_uiPhase;
    uint64 PlayerGUID;

    void Reset()
    {
        PlayerGUID = 0;
        m_uiPhase = 0;
        m_uiEventTimer = 0;
        m_uiPhaseCounter = 0;
        lCreatureList.clear();
    }

    void AttackedBy(Unit* pAttacker)
    {
        if (me->getVictim())
            return;

        if (me->IsFriendlyTo(pAttacker))
            return;

        AttackStart(pAttacker);
    }

    void JustSummoned(Creature* pSummoned)
    {
        pSummoned->SetWalk(false);

        if (pSummoned->GetEntry() == NPC_TERVOSH)
        {
            pSummoned->GetMotionMaster()->MovePoint(0, -2889.48f, -3349.37f, 32.0619f);
            return;
        }
        if (pSummoned->GetEntry() == NPC_JAINA)
        {
            pSummoned->GetMotionMaster()->MovePoint(0, -2889.27f, -3347.17f, 32.2615f);
            return;
        }
        pSummoned->GetMotionMaster()->MovePoint(0, -2890.31f,-3345.23f,32.3087f);
    }

    void DoAttackPlayer()
    {
        Player* pPlayer = Unit::GetPlayer(PlayerGUID);
        if(!pPlayer)
            return;

        me->setFaction(FACTION_HOSTILE);
        me->AI()->AttackStart(pPlayer);

        lCreatureList = FindAllCreaturesWithEntry(NPC_SENTRY, 20);

        if (!lCreatureList.empty())
        {
            for(std::list<Creature*>::iterator itr = lCreatureList.begin(); itr != lCreatureList.end(); ++itr)
            {
                if ((*itr)->isAlive())
                {
                    (*itr)->setFaction(FACTION_HOSTILE);
                    (*itr)->AI()->AttackStart(pPlayer);
                }
            }
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim() && m_uiPhase)
        {
            switch(m_uiPhase)
            {
            case PHASE_ATTACK:
                DoAttackPlayer();
                break;

            case PHASE_COMPLETE:
                if (m_uiEventTimer <= uiDiff)
                {
                    m_uiEventTimer = 5000;

                    switch (m_uiPhaseCounter)
                    {
                    case 0:
                        DoScriptText(EMOTE_SURRENDER, me);
                        break;
                    case 1:
                        if (Creature* pTervosh = GetClosestCreatureWithEntry(me, NPC_TERVOSH, 10.0f))
                            DoScriptText(SAY_PROGRESS_1_TER, pTervosh);
                        break;
                    case 2:
                        DoScriptText(SAY_PROGRESS_2_HEN, me);
                        break;
                    case 3:
                        if (Creature* pTervosh = GetClosestCreatureWithEntry(me, NPC_TERVOSH, 10.0f))
                            DoScriptText(SAY_PROGRESS_3_TER, pTervosh);
                        break;
                    case 4:
                        if (Creature* pTervosh = GetClosestCreatureWithEntry(me, NPC_TERVOSH, 10.0f))
                                DoScriptText(SAY_PROGRESS_4_TER, pTervosh);
                        if (Player* pPlayer = Unit::GetPlayer(PlayerGUID))
                            pPlayer->GroupEventHappens(QUEST_MISSING_DIPLO_PT16, me);
                        Reset();
                        break;
                    }
                    ++m_uiPhaseCounter;
                }
                else
                    m_uiEventTimer -= uiDiff;
            }
        }
        return;
    }

    void DamageTaken(Unit* pDoneBy, uint32 &uiDamage)
    {
        if (uiDamage > me->GetHealth() || ((me->GetHealth() - uiDamage)*100 / me->GetMaxHealth() < 20))
        {
            uiDamage = 0;
            m_uiPhase = PHASE_COMPLETE;
            m_uiEventTimer = 2000;

            me->RestoreFaction();
            me->RemoveAllAuras();
            me->DeleteThreatList();
            me->CombatStop(true);
            me->SetWalk(false);
            me->SetHomePosition(-2892.28f,-3347.81f,31.8609f,0.160719f);
            me->GetMotionMaster()->MoveTargetedHome();

            if (Player* pPlayer = Unit::GetPlayer(PlayerGUID))
                pPlayer->CombatStop(true);

            if (!lCreatureList.empty())
            {
                uint16 N = -1;

                for(std::list<Creature*>::iterator itr = lCreatureList.begin(); itr != lCreatureList.end(); ++itr)
                {
                    if ((*itr)->isAlive())
                    {
                        N = N + 1;
                        (*itr)->RestoreFaction();
                        (*itr)->RemoveAllAuras();
                        (*itr)->DeleteThreatList();
                        (*itr)->CombatStop(true);
                        (*itr)->SetWalk(false);
                        (*itr)->GetMotionMaster()->MovePoint(0, m_afEventMoveTo[N].m_fX,  m_afEventMoveTo[N].m_fY,  m_afEventMoveTo[N].m_fZ);
                        (*itr)->ForcedDespawn(5000);
                    }
                }
            }
            lCreatureList.clear();

            me->ForcedDespawn(60000);
            me->SummonCreature(NPC_TERVOSH, -2876.66f, -3346.96f, 35.6029f, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
            me->SummonCreature(NPC_JAINA, -2876.95f, -3342.78f, 35.6244f, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
            me->SummonCreature(NPC_PAINED, -2877.67f, -3338.63f, 35.2548f, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
        }
    }
};

bool QuestAccept_npc_private_hendel(Player* pPlayer, Creature* pCreature, const Quest* pQuest)
{
    if (pQuest->GetQuestId() == QUEST_MISSING_DIPLO_PT16)
    {
        CAST_AI(npc_private_hendelAI, pCreature->AI())->m_uiPhase = PHASE_ATTACK;
        CAST_AI(npc_private_hendelAI, pCreature->AI())->PlayerGUID = pPlayer->GetGUID();
    }

    return true;
}

CreatureAI* GetAI_npc_private_hendel(Creature* pCreature)
{
    return new npc_private_hendelAI(pCreature);
}

/*#####
## npc_stinky
#####*/

enum eStinky
{
    QUEST_STINKYS_ESCAPE_H                       = 1270,
    QUEST_STINKYS_ESCAPE_A                       = 1222,
    SAY_QUEST_ACCEPTED                           = -1000612,
    SAY_STAY_1                                   = -1000613,
    SAY_STAY_2                                   = -1000614,
    SAY_STAY_3                                   = -1000615,
    SAY_STAY_4                                   = -1000616,
    SAY_STAY_5                                   = -1000617,
    SAY_STAY_6                                   = -1000618,
    SAY_QUEST_COMPLETE                           = -1000619,
    SAY_ATTACKED_1                               = -1000620,
    EMOTE_DISAPPEAR                              = -1000621
};

struct npc_stinkyAI : public npc_escortAI
{
    npc_stinkyAI(Creature* pCreature) : npc_escortAI(pCreature) { }

    void WaypointReached(uint32 i)
    {
        Player* pPlayer = GetPlayerForEscort();
        if (!pPlayer)
            return;

        switch (i)
        {
        case 7:
            DoScriptText(SAY_STAY_1, me, pPlayer);
            break;
        case 11:
            DoScriptText(SAY_STAY_2, me, pPlayer);
            break;
        case 25:
            DoScriptText(SAY_STAY_3, me, pPlayer);
            break;
        case 26:
            DoScriptText(SAY_STAY_4, me, pPlayer);
            break;
        case 27:
            DoScriptText(SAY_STAY_5, me, pPlayer);
            break;
        case 28:
            DoScriptText(SAY_STAY_6, me, pPlayer);
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
            break;
        case 29:
            me->SetStandState(UNIT_STAND_STATE_STAND);
            break;
        case 37:
            DoScriptText(SAY_QUEST_COMPLETE, me, pPlayer);
            SetRun();
            if (pPlayer && pPlayer->GetQuestStatus(QUEST_STINKYS_ESCAPE_H))
                pPlayer->GroupEventHappens(QUEST_STINKYS_ESCAPE_H, me);
            if (pPlayer && pPlayer->GetQuestStatus(QUEST_STINKYS_ESCAPE_A))
                pPlayer->GroupEventHappens(QUEST_STINKYS_ESCAPE_A, me);
            break;
        case 39:
            DoScriptText(EMOTE_DISAPPEAR, me);
            break;
        }
    }

    void EnterCombat(Unit* pWho)
    {
        DoScriptText(SAY_ATTACKED_1, me, pWho);
    }

    void Reset() {}

    void JustDied(Unit* /*pKiller*/)
    {
        Player* pPlayer = GetPlayerForEscort();

        if (HasEscortState(STATE_ESCORT_ESCORTING) && pPlayer)
        {
            if (pPlayer->GetQuestStatus(QUEST_STINKYS_ESCAPE_H))
                pPlayer->FailQuest(QUEST_STINKYS_ESCAPE_H);
            if (pPlayer->GetQuestStatus(QUEST_STINKYS_ESCAPE_A))
                pPlayer->FailQuest(QUEST_STINKYS_ESCAPE_A);
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        npc_escortAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_stinky(Creature* pCreature)
{
    return new npc_stinkyAI(pCreature);
}

bool QuestAccept_npc_stinky(Player* pPlayer, Creature* pCreature, Quest const *quest)
{
    if (quest->GetQuestId() == QUEST_STINKYS_ESCAPE_H || QUEST_STINKYS_ESCAPE_A)
    {
        if (npc_stinkyAI* pEscortAI = CAST_AI(npc_stinkyAI, pCreature->AI()))
        {
            pCreature->setFaction(FACTION_ESCORT_N_NEUTRAL_ACTIVE);
            pCreature->SetStandState(UNIT_STAND_STATE_STAND);
            DoScriptText(SAY_QUEST_ACCEPTED, pCreature);
            pEscortAI->Start(false, false, pPlayer->GetGUID());
        }
    }
    return true;
}

/*######
## mob_swamp_ooze
######*/

struct mob_swamp_oozeAI : public ScriptedAI
{
    mob_swamp_oozeAI(Creature *c) : ScriptedAI(c) {}

    void Reset(){}

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (spell->Id == 42489)
        {
            if (FindGameObject(186441, 40, me))
            {
                caster->ToPlayer()->KilledMonster(23797, me->GetGUID());
                me->DisappearAndDie();
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        DoMeleeAttackIfReady();        
    }
};

CreatureAI* GetAI_mob_swamp_ooze(Creature *_Creature)
{
    return new mob_swamp_oozeAI (_Creature);
}

void AddSC_dustwallow_marsh()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_cassa_crimsonwing";
    newscript->pGossipHello = &GossipHello_npc_cassa_crimsonwing;
    newscript->pGossipSelect = &GossipSelect_npc_cassa_crimsonwing;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mobs_risen_husk_spirit";
    newscript->GetAI = &GetAI_mobs_risen_husk_spirit;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_restless_apparition";
    newscript->pGossipHello =   &GossipHello_npc_restless_apparition;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_deserter_agitator";
    newscript->GetAI = &GetAI_npc_deserter_agitator;
    newscript->pGossipHello = &GossipHello_npc_deserter_agitator;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_dustwallow_lady_jaina_proudmoore";
    newscript->GetAI = &GetAI_npc_dustwallow_lady_jaina_proudmoore;
    newscript->pGossipHello = &GossipHello_npc_dustwallow_lady_jaina_proudmoore;
    newscript->pGossipSelect = &GossipSelect_npc_dustwallow_lady_jaina_proudmoore;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_nat_pagle";
    newscript->pGossipHello = &GossipHello_npc_nat_pagle;
    newscript->pGossipSelect = &GossipSelect_npc_nat_pagle;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_theramore_combat_dummy";
    newscript->GetAI = &GetAI_npc_theramore_combat_dummy;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_mottled_drywallow_crocolisks";
    newscript->GetAI = &GetAI_mob_mottled_drywallow_crocolisks;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_morokk";
    newscript->GetAI = &GetAI_npc_morokk;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_morokk;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_ogron";
    newscript->GetAI = &GetAI_npc_ogron;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_ogron;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_private_hendel";
    newscript->GetAI = &GetAI_npc_private_hendel;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_private_hendel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_stinky";
    newscript->GetAI = &GetAI_npc_stinky;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_stinky;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_swamp_ooze";
    newscript->GetAI = &GetAI_mob_swamp_ooze;
    newscript->RegisterSelf();
}

