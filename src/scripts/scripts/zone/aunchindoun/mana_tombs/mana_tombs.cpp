/* Copyright (C) 2013 Looking4group <https://http://looking4group.net//>
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
HGName: mana_tombs
HG%Complete: 100
HGComment: support the quest 10218.
HGCategory: Auchindoun, Mana Tombs
EndScriptData */

/* ContentData
npc_shaheen
go_transportercp
EndContentData */

#include "precompiled.h"
#include "def_mana_tombs.h"
#include "escort_ai.h"

enum
{
    SAY_INTRO          = -1900235,
    SAY_STOP           = -1900236,
    SAY_START          = -1900237,
    SAY_1              = -1900238,
    SAY_2              = -1900239,
    SAY_3              = -1900240,
    SAY_4              = -1900241,
    SAY_5              = -1900242,
    SAY_6              = -1900243,
    SAY_7              = -1900244,
    SAY_8              = -1900245,
    SAY_9              = -1900246,
    SAY_10             = -1900247,
    SAY_11             = -1900248,
    SAY_12             = -1900249,
    SAY_13             = -1900250,
    SAY_14             = -1900251,
    SAY_END            = -1900252,

    QUEST_HARD_WORK    = 10218,
    QUEST_SAFETY       = 10216,

    NPC_SHAHEEN        = 19671,
    NPC_LABORER        = 19672,

    NPC_THEURGIST      = 18315,
    NPC_SPELLBRINGER   = 18312,
    NPC_SORCERER       = 18313,
    NPC_RAIDER         = 18311,
    NPC_TERROR         = 19307,
    NPC_LEECH          = 19306,
    NPC_XIRAXIS        = 19666,

    SPELL_BOLT         = 38340
};

struct Pos
{
    float x, y, z, o;
};

static Pos pos[]=
{
    {-364.60f, -60.08f, -0.96f, 0.0f},
    {-376.29f, -58.26f, -0.96f, 0.0f},
    {-385.13f, -69.05f, -0.96f, 0.0f},
    {-380.36f, -83.57f, -0.96f, 0.0f},
    {-369.68f, -85.28f, -0.96f, 0.0f},
    {-373.27f, -128.49f, -0.95f, 0.0f},
    {-373.25f, -198.86f, -0.95, 0.0f},
    {-233.20f, -173.49f, -0.95f, 0.0f},
    {-285.71f, -179.32f, -1.52, 0.0f},
    {-27.67f, -224.44f, 0.11, 3.0f},
    {-67.107f, -13.641f, -0.94, 0.0f},
    {-67.85f, -66.42f, -0.84, 0.0f}
};

struct npc_shaheenAI : public npc_escortAI
{
    npc_shaheenAI(Creature *creature) : npc_escortAI(creature)
    {
        pInstance = creature->GetInstanceData();    
    }

    ScriptedInstance *pInstance;

    uint8 Part;
    uint32 EventTimer;
    uint8 EventStage;
    uint64 XiraxisGUID;

    void Reset()
    {
        Part = 0;
        EventTimer = 0;
        EventStage = 0;
        XiraxisGUID = 0;
    }

    void AttackStart(Unit* who)
    {
        DoCast(me->getVictim(), SPELL_BOLT);
        npc_escortAI::AttackStart(who);
    }

    void JustSummoned(Creature* summoned)
    {
        switch (summoned->GetEntry())
        {
            case NPC_TERROR:
                break;
            case NPC_XIRAXIS:
                XiraxisGUID = summoned->GetGUID();
                summoned->SetReactState(REACT_PASSIVE);
                summoned->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                summoned->setFaction(1731);
                summoned->GetMotionMaster()->MovePoint(0, pos[11].x, pos[11].y, pos[11].z);
                break;
            case NPC_LABORER:
                summoned->GetMotionMaster()->MoveFleeing(summoned, 3000);
                break;
            default:
                summoned->AI()->AttackStart(me);
                break;
        }
    }

    void StartEscortPartOne (Player* player)
    {
        Part = 1;
        AddWaypoint(0, -354.10, -67.69, -0.96, 0);
        AddWaypoint(1, -354.93, -65.83, -0.96, 10000);
        AddWaypoint(2, -355.44, -66.31, -0.96, 0);
        AddWaypoint(3, -364.55, -72.08, -0.96, 1000);
        ((npc_escortAI*)(me->AI()))->SetClearWaypoints(true);
        ((npc_escortAI*)(me->AI()))->SetDespawnAtEnd(false);
        ((npc_escortAI*)(me->AI()))->SetDespawnAtFar(false);
        Start(false, false, player->GetGUID());
    }

    void StartEscortPartTwo (Player* player)
    {
        Part = 2;
        ((npc_escortAI*)(me->AI()))->SetDespawnAtEnd(true);
        ((npc_escortAI*)(me->AI()))->SetDespawnAtFar(false);
        Start(true, false, player->GetGUID());
    }

    void WaypointReached(uint32 i)
    {
        switch (Part)
        {
            case 1:
                switch(i)
                {
                    case 1:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_WORK_NOSHEATHE);
                        break;
                    case 2:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                        me->SummonCreature(NPC_LABORER, pos[0].x, pos[0].y, pos[0].z, pos[0].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                        me->SummonCreature(NPC_LABORER, pos[1].x, pos[1].y, pos[1].z, pos[1].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                        me->SummonCreature(NPC_LABORER, pos[2].x, pos[2].y, pos[2].z, pos[2].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                        me->SummonCreature(NPC_LABORER, pos[3].x, pos[3].y, pos[3].z, pos[3].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                        me->SummonCreature(NPC_LABORER, pos[4].x, pos[4].y, pos[4].z, pos[4].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                        break;
                     case 3:
                        me->SetFacingTo(0.19f);
                        DoScriptText(SAY_STOP, me);
                        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                        break;
                }
                break;
            case 2:
                switch(i)
                {
                    case 0:
                        DoScriptText(SAY_1, me);
                        break;
                    case 4:
                        DoScriptText(SAY_2, me);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_WORK_NOSHEATHE);
                        me->SummonCreature(NPC_THEURGIST, pos[5].x, pos[5].y, pos[5].z, pos[5].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_SPELLBRINGER, pos[5].x+(rand()%4), pos[5].y-(rand()%4), pos[5].z, pos[5].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_THEURGIST, pos[6].x, pos[6].y, pos[6].z, pos[6].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_SPELLBRINGER, pos[6].x+(rand()%4), pos[6].y-(rand()%4), pos[6].z, pos[6].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        break;
                    case 5:
                        DoScriptText(SAY_3, me);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                        break;
                    case 9:
                        DoScriptText(SAY_4, me);
                        me->SetFacingTo(5.19f);
                        break;
                    case 10:
                        DoScriptText(SAY_5, me);
                        me->SetFacingTo(0.76f);
                        break;
                    case 13:
                        DoScriptText(SAY_6, me);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_WORK_NOSHEATHE);
                        me->SummonCreature(NPC_SORCERER, pos[7].x, pos[7].y, pos[7].z, pos[7].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_RAIDER, pos[7].x+(rand()%4), pos[7].y-(rand()%4), pos[7].z, pos[7].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_SORCERER, pos[8].x, pos[8].y, pos[8].z, pos[8].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_RAIDER, pos[8].x+(rand()%4), pos[8].y-(rand()%4), pos[8].z, pos[8].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        break;
                    case 14:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                        break;
                    case 19:
                        me->SummonCreature(NPC_TERROR, pos[9].x, pos[9].y, pos[9].z, pos[9].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                        break;
                    case 22:
                        DoScriptText(SAY_7, me);
                        EventTimer = 10000;
                        break;
                    case 24:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_WORK_NOSHEATHE);
                        break;
                    case 25:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                        DoScriptText(SAY_8, me);
                        break;
                    case 26:
                        DoScriptText(SAY_9, me);
                        break;
                    case 27:
                        DoScriptText(SAY_10, me);
                        break;
                    case 31:
                        EventTimer = 8000;
                        break;
                    case 32:
                        DoScriptText(SAY_14, me);
                        break;
                    case 33:
                        SetRun();
                        DoScriptText(SAY_END, me);
                        if (Player* player = GetPlayerForEscort())
                            player->GroupEventHappens(QUEST_HARD_WORK, me);
                        break;
                }
                break;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        npc_escortAI::UpdateAI(diff);

        if (EventTimer)
        {
            if (EventTimer <= diff)
            {
                switch (EventStage)
                {
                    case 0:
                        me->SummonCreature(NPC_TERROR, pos[9].x, pos[9].y, pos[9].z, pos[9].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_LEECH, pos[9].x+(rand()%4), pos[9].y-(rand()%4), pos[9].z, pos[9].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_LEECH, pos[9].x+(rand()%4), pos[9].y+(rand()%4), pos[9].z, pos[9].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_LEECH, pos[9].x+(rand()%4), pos[9].y-(rand()%4), pos[9].z, pos[9].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_LEECH, pos[9].x+(rand()%4), pos[9].y+(rand()%4), pos[9].z, pos[9].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_LEECH, pos[9].x+(rand()%4), pos[9].y-(rand()%4), pos[9].z, pos[9].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        me->SummonCreature(NPC_LEECH, pos[9].x+(rand()%4), pos[9].y+(rand()%4), pos[9].z, pos[9].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        EventTimer = 0;
                        break;
                    case 1:
                        me->SummonCreature(NPC_XIRAXIS, pos[10].x, pos[10].y, pos[10].z, pos[10].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                        EventTimer = 5000;
                        break;
                    case 2:
                        if (Creature* Xiraxis = (Unit::GetCreature(*me, XiraxisGUID)))
                            DoScriptText(SAY_11, Xiraxis);
                        EventTimer = 8000;
                        break;
                    case 3:
                        DoScriptText(SAY_12, me);
                        EventTimer = 8000;
                        break;
                    case 4:
                        if (Creature* Xiraxis = (Unit::GetCreature(*me, XiraxisGUID)))
                        {
                            DoScriptText(SAY_13, Xiraxis);
                            Xiraxis->SetReactState(REACT_AGGRESSIVE);
                            Xiraxis->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            Xiraxis->setFaction(14);
                            Xiraxis->AI()->AttackStart(me);
                        }
                        EventTimer = 0;
                        break;
                }

                ++EventStage;
            }
            else EventTimer -= diff;
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_shaheen(Creature* creature)
{
    return new npc_shaheenAI(creature);
}

bool QuestAccept_npc_shaheen(Player* player, Creature* creature, const Quest* quest)
{
    if (quest->GetQuestId() == QUEST_HARD_WORK)
    {
        if (npc_shaheenAI* escortAI = dynamic_cast<npc_shaheenAI*>(creature->AI()))
        {
            creature->setFaction(FACTION_ESCORT_N_NEUTRAL_PASSIVE);
            DoScriptText(SAY_START, creature);
            escortAI->StartEscortPartTwo(player);
        }
    }

    return true;
}

/*######
## go_transportercp
######*/

bool GOUse_go_transportercp(Player *player, GameObject* go)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)go->GetInstanceData();

    if (!pInstance)
        return true;

    if (pInstance->GetData(DATA_SHAHEENEVENT) == DONE)
        return true;

    if (!player->GetQuestRewardStatus(QUEST_HARD_WORK) && player->GetQuestRewardStatus(QUEST_SAFETY))
    {
        pInstance->SetData(DATA_SHAHEENEVENT, DONE);

        if (Creature* shaheen = go->SummonCreature(NPC_SHAHEEN, -351.21f, -69.19f, -0.962f, 3.414f, TEMPSUMMON_CORPSE_DESPAWN, 10000))
        {
            DoScriptText(SAY_INTRO, shaheen, player);
            if (npc_shaheenAI* escortAI = dynamic_cast<npc_shaheenAI*>(shaheen->AI()))
                escortAI->StartEscortPartOne(player);
        }
    }
    return false;

    return true;
}

void AddSC_mana_tombs()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_shaheen";
    newscript->GetAI = &GetAI_npc_shaheen;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_shaheen;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="go_transportercp";
    newscript->pGOUse = &GOUse_go_transportercp;
    newscript->RegisterSelf();
}