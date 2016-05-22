/* Copyright (C) 2008 - 2010 Looking4groupDev <http://gamefreedom.pl/>
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 */

/* ScriptData
SDName: Desolace
SD%Complete:
SDComment: Quest support: 1440, 5561, 5381, 6132
SDCategory: Desolace
EndScriptData */

/* ContentData
npc_aged_dying_ancient_kodo
go_iruxos
npc_dalinda_malem
npc_melizza_brimbuzzle
npc_rokaro
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"

/*######
## npc_aged_dying_ancient_kodo. Quest 5561
######*/

enum eDyingKodo
{
    // signed for 9999
    SAY_SMEED_HOME_1                = -1000348,
    SAY_SMEED_HOME_2                = -1000349,
    SAY_SMEED_HOME_3                = -1000350,

    QUEST_KODO                      = 5561,

    NPC_SMEED                       = 11596,
    NPC_AGED_KODO                   = 4700,
    NPC_DYING_KODO                  = 4701,
    NPC_ANCIENT_KODO                = 4702,
    NPC_TAMED_KODO                  = 11627,

    SPELL_KODO_KOMBO_ITEM           = 18153,
    SPELL_KODO_KOMBO_PLAYER_BUFF    = 18172,                //spells here have unclear function, but using them at least for visual parts and checks
    SPELL_KODO_KOMBO_DESPAWN_BUFF   = 18377,
    SPELL_KODO_KOMBO_GOSSIP         = 18362

};

struct npc_aged_dying_ancient_kodoAI : public ScriptedAI
{
    npc_aged_dying_ancient_kodoAI(Creature* pCreature) : ScriptedAI(pCreature) { Reset(); }

    uint32 m_uiDespawnTimer;

    void Reset()
    {
        m_uiDespawnTimer = 0;
    }

    void MoveInLineOfSight(Unit* pWho)
    {
        if (pWho->GetEntry() == NPC_SMEED)
        {
            if (m_creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
                return;

            if (m_creature->IsWithinDistInMap(pWho, 10.0f))
            {
                DoScriptText(RAND(SAY_SMEED_HOME_1,SAY_SMEED_HOME_2,SAY_SMEED_HOME_3), pWho);

                //spell have no implemented effect (dummy), so useful to notify spellHit
                DoCast(m_creature, SPELL_KODO_KOMBO_GOSSIP, true);
            }
        }
    }

    void SpellHit(Unit* pCaster, SpellEntry const* pSpell)
    {
        if (pSpell->Id == SPELL_KODO_KOMBO_GOSSIP)
        {
            m_creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            m_uiDespawnTimer = 60000;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        //timer should always be == 0 unless we already updated entry of creature. Then not expect this updated to ever be in combat.
        if (m_uiDespawnTimer && m_uiDespawnTimer <= diff)
        {
            if (!m_creature->getVictim() && m_creature->isAlive())
            {
                Reset();
                m_creature->setDeathState(JUST_DIED);
                m_creature->Respawn();
                return;
            }
        } else m_uiDespawnTimer -= diff;

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_aged_dying_ancient_kodo(Creature* pCreature)
{
    return new npc_aged_dying_ancient_kodoAI(pCreature);
}

bool EffectDummyCreature_npc_aged_dying_ancient_kodo(Unit *pCaster, uint32 spellId, uint32 effIndex, Creature *pCreatureTarget)
{
    //always check spellid and effectindex
    if (spellId == SPELL_KODO_KOMBO_ITEM && effIndex == 0)
    {
        //no effect if player/creature already have aura from spells
        if (pCaster->HasAura(SPELL_KODO_KOMBO_PLAYER_BUFF, 0) || pCreatureTarget->HasAura(SPELL_KODO_KOMBO_DESPAWN_BUFF, 0))
            return true;

        if (pCreatureTarget->GetEntry() == NPC_AGED_KODO ||
            pCreatureTarget->GetEntry() == NPC_DYING_KODO ||
            pCreatureTarget->GetEntry() == NPC_ANCIENT_KODO)
        {
            pCaster->CastSpell(pCaster,SPELL_KODO_KOMBO_PLAYER_BUFF,true);

            pCreatureTarget->UpdateEntry(NPC_TAMED_KODO);
            pCreatureTarget->CastSpell(pCreatureTarget,SPELL_KODO_KOMBO_DESPAWN_BUFF,false);

            if (pCreatureTarget->GetMotionMaster()->GetCurrentMovementGeneratorType() == WAYPOINT_MOTION_TYPE)
                pCreatureTarget->GetMotionMaster()->MoveIdle();

            pCreatureTarget->GetMotionMaster()->MoveFollow(pCaster, PET_FOLLOW_DIST,  pCreatureTarget->GetFollowAngle());
        }

        //always return true when we are handling this spell and effect
        return true;
    }
    return false;
}

bool GossipHello_npc_aged_dying_ancient_kodo(Player* pPlayer, Creature* pCreature)
{
    if (pPlayer->HasAura(SPELL_KODO_KOMBO_PLAYER_BUFF, 0) && pCreature->HasAura(SPELL_KODO_KOMBO_DESPAWN_BUFF, 0))
    {
        //the expected quest objective
        pPlayer->CastedCreatureOrGO(pCreature->GetEntry(), pCreature->GetGUID(), SPELL_KODO_KOMBO_GOSSIP);

        pPlayer->RemoveAurasDueToSpell(SPELL_KODO_KOMBO_PLAYER_BUFF);
        pCreature->GetMotionMaster()->MoveIdle();
    }

    pPlayer->SEND_GOSSIP_MENU(pCreature->GetNpcTextId(), pCreature->GetGUID());
    return true;
}

/*######
## go_iruxos. Quest 5381
######*/

bool GOUse_go_iruxos(Player *pPlayer, GameObject* pGO)
{
        if (pPlayer->GetQuestStatus(5381) == QUEST_STATUS_INCOMPLETE)
        {
            Creature* Demon = pPlayer->SummonCreature(11876, pPlayer->GetPositionX()+frand(-2,2),pPlayer->GetPositionY()+frand(-2,2),pPlayer->GetPositionZ(),0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,10000);
            if(Demon)
            {
                Demon->AI()->AttackStart(pPlayer);
                pGO->SetLootState(GO_JUST_DEACTIVATED);
                return true;
            }
        }
        return false;
}

/*######
## npc_dalinda_malem. Quest 1440
######*/

#define QUEST_RETURN_TO_VAHLARRIEL     1440

struct npc_dalindaAI : public npc_escortAI
{
    npc_dalindaAI(Creature* pCreature) : npc_escortAI(pCreature) { }

    void WaypointReached(uint32 i)
    {
        Player* pPlayer = GetPlayerForEscort();
        switch (i)
        {
            case 1:
                me->SetStandState(PLAYER_STATE_NONE);
                break;
            case 15:
                if (pPlayer)
                pPlayer->GroupEventHappens(QUEST_RETURN_TO_VAHLARRIEL, m_creature);
                break;
            case 16:
                me->Kill(me, false);
                me->Respawn();
                break;
        }
    }

    void EnterCombat(Unit* pWho) { }

    void Reset()
    {
        me->SetStandState(PLAYER_STATE_KNEEL);
    }

    void JustDied(Unit* pKiller)
    {
        if(pKiller->GetGUID() == me->GetGUID())
            return;
        Player* pPlayer = GetPlayerForEscort();
        if (pPlayer)
            pPlayer->FailQuest(QUEST_RETURN_TO_VAHLARRIEL);
        return;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        npc_escortAI::UpdateAI(uiDiff);
        if (!UpdateVictim())
            return;
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_dalinda(Creature* pCreature)
{
    return new npc_dalindaAI(pCreature);
}

bool QuestAccept_npc_dalinda(Player* pPlayer, Creature* pCreature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_RETURN_TO_VAHLARRIEL)
   {
        if (npc_escortAI* pEscortAI = CAST_AI(npc_dalindaAI, pCreature->AI()))
        {
            pEscortAI->Start(true, false, pPlayer->GetGUID(), quest, true);
            pCreature->setFaction(113);
        }
    }
    return false;
}

/*#######
## npc_melizza_brimbuzzle
#######*/

enum
{
    SAY_START                   = -1000607,
    SAY_COMPLETE                = -1000608,
    SAY_POST_EVENT_1            = -1000609,
    SAY_POST_EVENT_2            = -1000610,
    SAY_POST_EVENT_3            = -1000611,

    NPC_MARAUDINE_BONEPAW       = 4660,
    NPC_MARAUDINE_SCOUT         = 4654,

    GO_MELIZZAS_CAGE            = 177706,
    QUEST_GET_ME_OUT_OF_HERE    = 6132
};

static float m_afAmbushSpawn[4][3]=
{
    {-1388.37f, 2427.81f, 88.8286f},
    {-1388.78f, 2431.85f, 88.7838f},
    {-1386.95f, 2429.76f, 88.8444f},
    {-1389.99f, 2429.93f, 88.7692f} 
};

struct npc_melizza_brimbuzzleAI : public npc_escortAI
{
    npc_melizza_brimbuzzleAI(Creature* pCreature) : npc_escortAI(pCreature) { }

    uint32 m_uiPostEventCount;
    uint64 m_uiPostEventTimer;
        
    void Reset()
    {
        m_uiPostEventCount = 0;
        m_uiPostEventTimer = 0;
    }

    void WaypointReached(uint32 uiPointId)
    {
        if (Player* pPlayer = GetPlayerForEscort())
        {
            switch (uiPointId)
            {
            case 1:
                me->setFaction(113);
                DoScriptText(SAY_START, me, pPlayer);
                break;
            case 7:
                 me->SummonCreature(NPC_MARAUDINE_SCOUT, m_afAmbushSpawn[0][0], m_afAmbushSpawn[0][1], m_afAmbushSpawn[0][2], 1.6f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                 me->SummonCreature(NPC_MARAUDINE_SCOUT, m_afAmbushSpawn[1][0], m_afAmbushSpawn[1][1], m_afAmbushSpawn[1][2], 1.6f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                 me->SummonCreature(NPC_MARAUDINE_SCOUT, m_afAmbushSpawn[2][0], m_afAmbushSpawn[2][1], m_afAmbushSpawn[2][2], 1.6f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                 me->SummonCreature(NPC_MARAUDINE_BONEPAW, m_afAmbushSpawn[3][0], m_afAmbushSpawn[3][1], m_afAmbushSpawn[3][2], 1.6f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                 break;
            case 10:
                DoScriptText(SAY_COMPLETE, me);
                me->RestoreFaction();
                SetRun();
                pPlayer->GroupEventHappens(QUEST_GET_ME_OUT_OF_HERE, me);
                break;
            case 15:
                m_uiPostEventCount = 1;
                break;

            }
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {        
        npc_escortAI::UpdateAI(uiDiff);

        if (!UpdateVictim())
        {
            if (m_uiPostEventCount && HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (m_uiPostEventTimer <= uiDiff)
                {
                    m_uiPostEventTimer = 3000;

                    if (Unit* pPlayer = GetPlayerForEscort())
                    {
                        switch(m_uiPostEventCount)
                        {
                            case 1:
                                DoScriptText(SAY_POST_EVENT_1, me);
                                ++m_uiPostEventCount;
                                break;
                            case 2:
                                DoScriptText(SAY_POST_EVENT_2, me);
                                ++m_uiPostEventCount;
                                break;
                            case 3:
                                DoScriptText(SAY_POST_EVENT_3, me);
                                m_uiPostEventCount = 0;
                                me->ForcedDespawn(60000);
                                break;
                        }
                    }
                }
                else
                    m_uiPostEventTimer -= uiDiff;
            }

            return;
        }

        DoMeleeAttackIfReady();
    }

    void JustSummoned(Creature* pSummoned)
    {
        pSummoned->AI()->AttackStart(me);
    }
};

CreatureAI* GetAI_npc_melizza_brimbuzzle(Creature* pCreature)
{
    return new npc_melizza_brimbuzzleAI(pCreature);
}

bool QuestAccept_npc_melizza_brimbuzzle(Player* pPlayer, Creature* pCreature, Quest const* pQuest)
{
    if (pQuest->GetQuestId() == QUEST_GET_ME_OUT_OF_HERE)
    {
        if (GameObject* pGo = FindGameObject(GO_MELIZZAS_CAGE, INTERACTION_DISTANCE, pCreature))
            pGo->UseDoorOrButton();

        if (npc_melizza_brimbuzzleAI* pEscortAI = CAST_AI(npc_melizza_brimbuzzleAI, pCreature->AI()))
            pEscortAI->Start(false, false, pPlayer->GetGUID(), pQuest);
    }
    return true;
}

/*####
# npc_rokaro
####*/

#define GOSSIP_ITEM_ROKARO "Restore Drakefire Amulet."

bool GossipHello_npc_rokaro(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if(player->GetQuestRewardStatus(6602) && !player->HasItemCount(16309,1))
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_ROKARO, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO );
        player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_rokaro(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if( action == GOSSIP_SENDER_INFO )
    {
            ItemPosCountVec dest;
            uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 16309, 1);
            if (msg == EQUIP_ERR_OK)
            {
                 Item* item = player->StoreNewItem(dest, 16309, true);
                 player->SendNewItem(item,1,true,false,true);
            }
    player->CLOSE_GOSSIP_MENU();
    }
    return true;
}

void AddSC_desolace()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_aged_dying_ancient_kodo";
    newscript->GetAI = &GetAI_npc_aged_dying_ancient_kodo;
    newscript->pEffectDummyNPC = &EffectDummyCreature_npc_aged_dying_ancient_kodo;
    newscript->pGossipHello = &GossipHello_npc_aged_dying_ancient_kodo;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_iruxos";
    newscript->pGOUse = &GOUse_go_iruxos;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_dalinda";
    newscript->GetAI = &GetAI_npc_dalinda;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_dalinda;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_melizza_brimbuzzle";
    newscript->GetAI = &GetAI_npc_melizza_brimbuzzle;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_melizza_brimbuzzle;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name="npc_rokaro";
    newscript->pGossipHello = &GossipHello_npc_rokaro;
    newscript->pGossipSelect = &GossipSelect_npc_rokaro;
    newscript->RegisterSelf();
}
