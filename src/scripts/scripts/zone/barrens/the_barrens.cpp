/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: The_Barrens
SD%Complete: 90
SDComment: Quest support: 2458, 4921, 6981, 1719, 863, 898
SDCategory: Barrens
EndScriptData */

/* ContentData
npc_beaten_corpse
npc_gilthares
npc_sputtervalve
npc_taskmaster_fizzule
npc_twiggy_flathead
npc_wizzlecrank_shredder
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"

/*######
## npc_beaten_corpse
######*/

#define GOSSIP_CORPSE "Examine corpse in detail..."

bool GossipHello_npc_beaten_corpse(Player *player, Creature *_Creature)
{
    if( player->GetQuestStatus(4921) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(4921) == QUEST_STATUS_COMPLETE)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_CORPSE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(3557, _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_beaten_corpse(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if(action == GOSSIP_ACTION_INFO_DEF +1)
    {
        player->SEND_GOSSIP_MENU(3558, _Creature->GetGUID());
        player->KilledMonster( 10668,_Creature->GetGUID() );
    }
    return true;
}

/*######
# npc_gilthares
######*/

enum eGilthares
{
    SAY_GIL_START               = -1600370,
    SAY_GIL_AT_LAST             = -1600371,
    SAY_GIL_PROCEED             = -1600372,
    SAY_GIL_FREEBOOTERS         = -1600373,
    SAY_GIL_AGGRO_1             = -1600374,
    SAY_GIL_AGGRO_2             = -1600375,
    SAY_GIL_AGGRO_3             = -1600376,
    SAY_GIL_AGGRO_4             = -1600377,
    SAY_GIL_ALMOST              = -1600378,
    SAY_GIL_SWEET               = -1600379,
    SAY_GIL_FREED               = -1600380,

    QUEST_FREE_FROM_HOLD        = 898,
    AREA_MERCHANT_COAST         = 391,
    FACTION_ESCORTEE            = 232                       //guessed, possible not needed for this quest
};

struct npc_giltharesAI : public npc_escortAI
{
    npc_giltharesAI(Creature* pCreature) : npc_escortAI(pCreature) { }

    void Reset() { }

    void WaypointReached(uint32 uiPointId)
    {
        Player* pPlayer = GetPlayerForEscort();

        if (!pPlayer)
            return;

        switch(uiPointId)
        {
            case 16:
                DoScriptText(SAY_GIL_AT_LAST, me, pPlayer);
                break;
            case 17:
                DoScriptText(SAY_GIL_PROCEED, me, pPlayer);
                break;
            case 18:
                DoScriptText(SAY_GIL_FREEBOOTERS, me, pPlayer);
                break;
            case 37:
                DoScriptText(SAY_GIL_ALMOST, me, pPlayer);
                break;
            case 47:
                DoScriptText(SAY_GIL_SWEET, me, pPlayer);
                break;
            case 53:
                DoScriptText(SAY_GIL_FREED, me, pPlayer);
                pPlayer->GroupEventHappens(QUEST_FREE_FROM_HOLD, me);
                break;
        }
    }

    void EnterCombat(Unit* pWho)
    {
        //not always use
        if (rand()%4)
            return;

        //only aggro text if not player and only in this area
        if (pWho->GetTypeId() != TYPEID_PLAYER && me->GetAreaId() == AREA_MERCHANT_COAST)
        {
            //appears to be pretty much random (possible only if escorter not in combat with pWho yet?)
            DoScriptText(RAND(SAY_GIL_AGGRO_1, SAY_GIL_AGGRO_2, SAY_GIL_AGGRO_3, SAY_GIL_AGGRO_4), me, pWho);
        }
    }
};

CreatureAI* GetAI_npc_gilthares(Creature* pCreature)
{
    return new npc_giltharesAI(pCreature);
}

bool QuestAccept_npc_gilthares(Player* pPlayer, Creature* pCreature, const Quest* pQuest)
{
    if (pQuest->GetQuestId() == QUEST_FREE_FROM_HOLD)
    {
        pCreature->setFaction(FACTION_ESCORTEE);
        pCreature->SetStandState(UNIT_STAND_STATE_STAND);

        DoScriptText(SAY_GIL_START, pCreature, pPlayer);

        if (npc_giltharesAI* pEscortAI = CAST_AI(npc_giltharesAI, pCreature->AI()))
            pEscortAI->Start(false, false, pPlayer->GetGUID(), pQuest);
    }
    return true;
}

/*######
## npc_sputtervalve
######*/

#define GOSSIP_SPUTTERVALVE "Can you tell me about this shard?"

bool GossipHello_npc_sputtervalve(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if( player->GetQuestStatus(6981) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_SPUTTERVALVE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_sputtervalve(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if(action == GOSSIP_ACTION_INFO_DEF)
    {
        player->SEND_GOSSIP_MENU(2013, _Creature->GetGUID());
        player->AreaExploredOrEventHappens(6981);
    }
    return true;
}

/*######
## npc_taskmaster_fizzule
######*/

//#define FACTION_HOSTILE_F     430
#define FACTION_HOSTILE_F       16
#define FACTION_FRIENDLY_F      35

#define SPELL_FLARE             10113
#define SPELL_FOLLY             10137

struct npc_taskmaster_fizzuleAI : public ScriptedAI
{
    npc_taskmaster_fizzuleAI(Creature* c) : ScriptedAI(c) {}

    bool IsFriend;
    uint32 Reset_Timer;
    uint32 FlareCount;

    void Reset()
    {
        IsFriend = false;
        Reset_Timer = 120000;
        FlareCount = 0;
        m_creature->setFaction(FACTION_HOSTILE_F);
        m_creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
    }

    //This is a hack. Spellcast will make creature aggro but that is not
    //supposed to happen (Trinity not implemented/not found way to detect this spell kind)
    void DoUglyHack()
    {
        m_creature->RemoveAllAuras();
        m_creature->DeleteThreatList();
        m_creature->CombatStop();
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if( spell->Id == SPELL_FLARE || spell->Id == SPELL_FOLLY )
        {
            DoUglyHack();
            ++FlareCount;
            if( FlareCount >= 2 )
            {
                m_creature->setFaction(FACTION_FRIENDLY_F);
                IsFriend = true;
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if( IsFriend )
        {
            if( Reset_Timer < diff )
            {
                EnterEvadeMode();
                return;
            } else Reset_Timer -= diff;
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_npc_taskmaster_fizzule(Creature *_Creature)
{
    return new npc_taskmaster_fizzuleAI (_Creature);
}

bool ReciveEmote_npc_taskmaster_fizzule(Player *player, Creature *_Creature, uint32 emote)
{
    if( emote == TEXTEMOTE_SALUTE )
    {
        if( ((npc_taskmaster_fizzuleAI*)_Creature->AI())->FlareCount >= 2 )
        {
            _Creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
            _Creature->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
        }
    }
    return true;
}
/*#####
## npc_twiggy_flathead
#####*/

#define BIG_WILL 6238
#define AFFRAY_CHALLENGER 6240
#define SAY_BIG_WILL_READY                  -1000267
#define SAY_TWIGGY_FLATHEAD_BEGIN           -1000268
#define SAY_TWIGGY_FLATHEAD_FRAY            -1000269
#define SAY_TWIGGY_FLATHEAD_DOWN            -1000270
#define SAY_TWIGGY_FLATHEAD_OVER            -1000271

float AffrayChallengerLoc[6][4]=
{
    {-1683, -4326, 2.79, 0},
    {-1682, -4329, 2.79, 0},
    {-1683, -4330, 2.79, 0},
    {-1680, -4334, 2.79, 1.49},
    {-1674, -4326, 2.79, 3.49},
    {-1677, -4334, 2.79, 1.66}
};

struct npc_twiggy_flatheadAI : public ScriptedAI
{
    npc_twiggy_flatheadAI(Creature *c) : ScriptedAI(c) {}

    bool EventInProgress;
    bool EventGrate;
    bool EventBigWill;
    bool Challenger_down[6];
    uint32 Wave;
    uint32 Wave_Timer;
    uint32 Challenger_checker;
    uint64 PlayerGUID;
    uint64 AffrayChallenger[6];
    uint64 BigWill;

    void Reset()
    {
        EventInProgress = false;
        EventGrate = false;
        EventBigWill = false;
        Wave_Timer = 600000;
        Challenger_checker = 0;
        Wave = 0;
        PlayerGUID = 0;

        for(uint8 i = 0; i < 6; ++i)
        {
            AffrayChallenger[i] = 0;
            Challenger_down[i] = false;
        }
        BigWill = 0;
    }

    void EnterCombat(Unit *who) { }

    void MoveInLineOfSight(Unit *who)
    {
        if(!who || (!who->isAlive())) return;

        if (m_creature->IsWithinDistInMap(who, 10.0f) && (who->GetTypeId() == TYPEID_PLAYER) && ((Player*)who)->GetQuestStatus(1719) == QUEST_STATUS_INCOMPLETE && !EventInProgress)
        {
            PlayerGUID = who->GetGUID();
            EventInProgress = true;
        }
    }

    void KilledUnit(Unit *victim) { }

    void UpdateAI(const uint32 diff)
    {
        if (EventInProgress)
        {
            Player* pWarrior = NULL;

            if(PlayerGUID)
                pWarrior = Unit::GetPlayer(PlayerGUID);

            if(!pWarrior)
            {
                Reset();
                return;
            }

            if(!pWarrior->isAlive() && pWarrior->GetQuestStatus(1719) == QUEST_STATUS_INCOMPLETE)
            {
                EventInProgress = false;
                DoScriptText(SAY_TWIGGY_FLATHEAD_DOWN, m_creature);
                pWarrior->FailQuest(1719);

                for(uint8 i = 0; i < 6; ++i)
                {
                    if (AffrayChallenger[i])
                    {
                        Creature* pCreature = Unit::GetCreature((*m_creature), AffrayChallenger[i]);
                        if(pCreature)
                        {
                            if(pCreature->isAlive())
                            {
                                pCreature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
                                pCreature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                pCreature->setDeathState(JUST_DIED);
                            }
                        }
                    }
                    AffrayChallenger[i] = 0;
                    Challenger_down[i] = false;
                }

                if (BigWill)
                {
                    Creature* pCreature = Unit::GetCreature((*m_creature), BigWill);
                    if(pCreature)
                    {
                        if(pCreature->isAlive())
                        {
                            pCreature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
                            pCreature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            pCreature->setDeathState(JUST_DIED);
                        }
                    }
                }
                BigWill = 0;
                Reset();
                return;
            }

            if (!EventGrate && EventInProgress)
            {
                float x,y,z;
                pWarrior->GetPosition(x, y, z);

                if (x >= -1684 && x <= -1674 && y >= -4334 && y <= -4324) {
                    pWarrior->AreaExploredOrEventHappens(1719);
                    DoScriptText(SAY_TWIGGY_FLATHEAD_BEGIN, m_creature);

                    for(uint8 i = 0; i < 6; ++i)
                    {
                        Creature* pCreature = m_creature->SummonCreature(AFFRAY_CHALLENGER, AffrayChallengerLoc[i][0], AffrayChallengerLoc[i][1], AffrayChallengerLoc[i][2], AffrayChallengerLoc[i][3], TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000);
                        if(!pCreature)
                            continue;

                        pCreature->setFaction(35);
                        pCreature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        pCreature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        pCreature->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                        AffrayChallenger[i] = pCreature->GetGUID();
                    }
                    Wave_Timer = 5000;
                    Challenger_checker = 1000;
                    EventGrate = true;
                }
            }
            else if (EventInProgress)
            {
                if (Challenger_checker < diff)
                {
                    for(uint8 i = 0; i < 6; ++i)
                    {
                        if (AffrayChallenger[i])
                        {
                            Creature* pCreature = Unit::GetCreature((*m_creature), AffrayChallenger[i]);
                            if((!pCreature || (!pCreature->isAlive())) && !Challenger_down[i])
                            {
                                DoScriptText(SAY_TWIGGY_FLATHEAD_DOWN, m_creature);
                                Challenger_down[i] = true;
                            }
                        }
                    }
                    Challenger_checker = 1000;
                }
                else
                    Challenger_checker -= diff;

                if(Wave_Timer < diff)
                {
                    if (AffrayChallenger[Wave] && Wave < 6 && !EventBigWill)
                    {
                        DoScriptText(SAY_TWIGGY_FLATHEAD_FRAY, m_creature);
                        Creature* pCreature = Unit::GetCreature((*m_creature), AffrayChallenger[Wave]);
                        if(pCreature && (pCreature->isAlive()))
                        {
                            pCreature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            pCreature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            pCreature->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                            pCreature->setFaction(14);
                            ((CreatureAI*)pCreature->AI())->AttackStart(pWarrior);
                            ++Wave;
                            Wave_Timer = 20000;
                        }
                    }
                    else if (Wave >= 6 && !EventBigWill)
                    {
                        if(Creature* pCreature = m_creature->SummonCreature(BIG_WILL, -1722, -4341, 6.12, 6.26, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 480000))
                        {
                            BigWill = pCreature->GetGUID();
                            //pCreature->GetMotionMaster()->MovePoint(0, -1693, -4343, 4.32);
                            //pCreature->GetMotionMaster()->MovePoint(1, -1684, -4333, 2.78);
                            pCreature->GetMotionMaster()->MovePoint(2, -1682, -4329, 2.79);
                            //pCreature->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                            pCreature->HandleEmoteCommand(EMOTE_STATE_READYUNARMED);
                            EventBigWill = true;
                            Wave_Timer = 1000;
                        }
                    }
                    else if (Wave >= 6 && EventBigWill && BigWill)
                    {
                        Creature* pCreature = Unit::GetCreature((*m_creature), BigWill);
                        if (!pCreature || !pCreature->isAlive())
                        {
                            DoScriptText(SAY_TWIGGY_FLATHEAD_OVER, m_creature);
                            EnterEvadeMode();
                        }
                    }
                }
                else
                    Wave_Timer -= diff;
            }
        }
    }
};

CreatureAI* GetAI_npc_twiggy_flathead(Creature *_Creature)
{
    return new npc_twiggy_flatheadAI (_Creature);
}

/*#####
## npc_wizzlecrank_shredder
#####*/

enum eEnums_Wizzlecrank
{
    SAY_START           = -1000272,
    SAY_STARTUP1        = -1000273,
    SAY_STARTUP2        = -1000274,
    SAY_MERCENARY       = -1000275,
    SAY_PROGRESS_1      = -1000276,
    SAY_PROGRESS_2      = -1000277,
    SAY_PROGRESS_3      = -1000278,
    SAY_END             = -1000279,

    QUEST_ESCAPE        = 863,
    FACTION_RATCHET     = 637,
    NPC_PILOT_WIZZ      = 3451,
    NPC_MERCENARY       = 3282,
};

struct npc_wizzlecrank_shredderAI : public npc_escortAI
{
    npc_wizzlecrank_shredderAI(Creature* c) : npc_escortAI(c)
    {
        m_bIsPostEvent = false;
        m_uiPostEventTimer = 1000;
        m_uiPostEventCount = 0;
    }

    bool m_bIsPostEvent;
    uint32 m_uiPostEventTimer;
    uint32 m_uiPostEventCount;

    void Reset()
    {
        if (!HasEscortState(STATE_ESCORT_ESCORTING))
        {
            m_creature->setDeathState(ALIVE);
            m_bIsPostEvent = false;
            m_uiPostEventTimer = 1000;
            m_uiPostEventCount = 0;
        }
    }

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();

        if(!player)
            return;

        switch(i)
        {
        case 0:
            DoScriptText(SAY_STARTUP1, m_creature);
            break;
        case 9:
            SetRun(false);
            break;
        case 17:
            if (Creature* pTemp = m_creature->SummonCreature(NPC_MERCENARY, 1128.489f, -3037.611f, 92.701f, 1.472f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000))
            {
                DoScriptText(SAY_MERCENARY, pTemp);
                m_creature->SummonCreature(NPC_MERCENARY, 1160.172f, -2980.168f, 97.313f, 3.690f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
            }
            break;
        case 24:
            m_bIsPostEvent = true;
            break;
        }
    }

    void WaypointStart(uint32 uiPointId)
    {
        Player* pPlayer = GetPlayerForEscort();
        if (!pPlayer)
            return;

        switch(uiPointId)
        {
            case 9:
                DoScriptText(SAY_STARTUP2, m_creature, pPlayer);
                break;
            case 18:
                DoScriptText(SAY_PROGRESS_1, m_creature, pPlayer);
                SetRun();
                break;
        }
    }

    void JustSummoned(Creature* pSummoned)
    {
        if (pSummoned->GetEntry() == NPC_PILOT_WIZZ)
            m_creature->setDeathState(JUST_DIED);

        if (pSummoned->GetEntry() == NPC_MERCENARY)
            pSummoned->AI()->AttackStart(m_creature);
    }

    void EnterCombat(Unit* who){}

    void UpdateEscortAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
        {
            if (m_bIsPostEvent)
            {
                if (m_uiPostEventTimer < uiDiff)
                {
                    switch(m_uiPostEventCount)
                    {
                        case 0:
                            DoScriptText(SAY_PROGRESS_2, m_creature);
                            break;
                        case 1:
                            DoScriptText(SAY_PROGRESS_3, m_creature);
                            break;
                        case 2:
                            DoScriptText(SAY_END, m_creature);
                            break;
                        case 3:
                            if (Player* pPlayer = GetPlayerForEscort())
                            {
                                pPlayer->GroupEventHappens(QUEST_ESCAPE, m_creature);
                                m_creature->SummonCreature(NPC_PILOT_WIZZ, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 180000);
                            }
                            break;
                    }

                    ++m_uiPostEventCount;
                    m_uiPostEventTimer = 5000;
                }
                else
                    m_uiPostEventTimer -= uiDiff;
            }

            return;
        }

        DoMeleeAttackIfReady();
    }
};

bool QuestAccept_npc_wizzlecrank_shredder(Player* pPlayer, Creature* pCreature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_ESCAPE)
    {
        pCreature->setFaction(FACTION_RATCHET);
        if (npc_escortAI* pEscortAI = CAST_AI(npc_wizzlecrank_shredderAI, pCreature->AI()))
            pEscortAI->Start(true, false, pPlayer->GetGUID());
    }
    return true;
}

CreatureAI* GetAI_npc_wizzlecrank_shredderAI(Creature *_Creature)
{
    npc_wizzlecrank_shredderAI* thisAI = new npc_wizzlecrank_shredderAI(_Creature);

    thisAI->AddWaypoint(0, 1109.15, -3104.11, 82.41, 6000);
    thisAI->AddWaypoint(1, 1105.39, -3102.86, 82.74, 2000);
    thisAI->AddWaypoint(2, 1104.97, -3108.52, 83.10, 1000);
    thisAI->AddWaypoint(3, 1110.01, -3110.48, 82.81, 1000);
    thisAI->AddWaypoint(4, 1111.72, -3103.03, 82.21, 1000);
    thisAI->AddWaypoint(5, 1106.98, -3099.44, 82.18, 1000);
    thisAI->AddWaypoint(6, 1103.74, -3103.29, 83.05, 1000);
    thisAI->AddWaypoint(7, 1112.55, -3106.56, 82.31, 1000);
    thisAI->AddWaypoint(8, 1108.12, -3111.04, 82.99, 1000);
    thisAI->AddWaypoint(9, 1109.32, -3100.39, 82.08, 1000);
    thisAI->AddWaypoint(10, 1109.32, -3100.39, 82.08, 6000);
    thisAI->AddWaypoint(11, 1098.92, -3095.14, 82.97);
    thisAI->AddWaypoint(12, 1100.94, -3082.60, 82.83);
    thisAI->AddWaypoint(13, 1101.12, -3068.83, 82.53);
    thisAI->AddWaypoint(14, 1096.97, -3051.99, 82.50);
    thisAI->AddWaypoint(15, 1094.06, -3036.79, 82.70);
    thisAI->AddWaypoint(16, 1098.22, -3027.84, 83.79);
    thisAI->AddWaypoint(17, 1109.51, -3015.92, 85.73);
    thisAI->AddWaypoint(18, 1119.87, -3007.21, 87.08);
    thisAI->AddWaypoint(19, 1130.23, -3002.49, 91.27, 5000);
    thisAI->AddWaypoint(20, 1130.23, -3002.49, 91.27, 3000);
    thisAI->AddWaypoint(21, 1130.23, -3002.49, 91.27, 4000);
    thisAI->AddWaypoint(22, 1129.73, -2985.89, 92.46);
    thisAI->AddWaypoint(23, 1124.10, -2983.29, 92.81);
    thisAI->AddWaypoint(24, 1111.74, -2992.38, 91.59);
    thisAI->AddWaypoint(25, 1111.06, -2976.54, 91.81);
    thisAI->AddWaypoint(26, 1099.91, -2991.17, 91.67);
    thisAI->AddWaypoint(27, 1096.32, -2981.55, 91.73);
    thisAI->AddWaypoint(28, 1091.28, -2985.82, 91.74, 4000);
    thisAI->AddWaypoint(29, 1091.28, -2985.82, 91.74, 3000);
    thisAI->AddWaypoint(30, 1091.28, -2985.82, 91.74, 7000);
    thisAI->AddWaypoint(31, 1091.28, -2985.82, 91.74, 3000);

    return (CreatureAI*)thisAI;
}

void AddSC_the_barrens()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_beaten_corpse";
    newscript->pGossipHello = &GossipHello_npc_beaten_corpse;
    newscript->pGossipSelect = &GossipSelect_npc_beaten_corpse;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_gilthares";
    newscript->GetAI = &GetAI_npc_gilthares;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_gilthares;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_sputtervalve";
    newscript->pGossipHello = &GossipHello_npc_sputtervalve;
    newscript->pGossipSelect = &GossipSelect_npc_sputtervalve;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_taskmaster_fizzule";
    newscript->GetAI = &GetAI_npc_taskmaster_fizzule;
    newscript->pReceiveEmote = &ReciveEmote_npc_taskmaster_fizzule;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_twiggy_flathead";
    newscript->GetAI = &GetAI_npc_twiggy_flathead;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_wizzlecrank_shredder";
    newscript->GetAI = &GetAI_npc_wizzlecrank_shredderAI;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_wizzlecrank_shredder;
    newscript->RegisterSelf();
}

