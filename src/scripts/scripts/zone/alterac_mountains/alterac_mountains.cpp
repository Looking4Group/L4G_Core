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
SDName: Alterac_Mountains
SD%Complete: 100
SDComment: Quest support: 6681, 1713
SDCategory: Alterac Mountains
EndScriptData */

/* ContentData
npc_ravenholdt
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"

/*######
## npc_ravenholdt
######*/

struct npc_ravenholdtAI : public ScriptedAI
{
    npc_ravenholdtAI(Creature *creature) : ScriptedAI(creature) {}

    void Reset() { }

    void MoveInLineOfSight(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            if (((Player*)who)->GetQuestStatus(6681) == QUEST_STATUS_INCOMPLETE)
                ((Player*)who)->KilledMonster(me->GetEntry(), me->GetGUID());
    }
};

CreatureAI* GetAI_npc_ravenholdt(Creature *creature)
{
    return new npc_ravenholdtAI (creature);
}

/*######
## npc_windwatcher
######*/

#define SAY_START          -1900233
#define SAY_SUMMONING      -1900234

#define QUEST_SUMMONING    1713
#define SPELL_SUMMON       8606

struct npc_windwatcherAI : public npc_escortAI
{
    npc_windwatcherAI(Creature* creature) : npc_escortAI(creature) {}

    void Reset() {}

    void EnterCombat(Unit* who){}

    void JustSummoned(Creature *summoned)
    {
        if (Player* player = GetPlayerForEscort())
            summoned->AI()->AttackStart(player);
    }

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();

        switch(i)
        {
            case 6:
                DoScriptText(SAY_SUMMONING, me, player);
                DoCast(me, SPELL_SUMMON);
                break;
            case 13:
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                me->SetFacingTo(1.39f);
                break;
        }
    }
};

CreatureAI* GetAI_npc_windwatcher(Creature* creature)
{
    return new npc_windwatcherAI(creature);
}

bool QuestAccept_npc_windwatcher(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_SUMMONING)
    {
        if (npc_escortAI* pEscortAI = CAST_AI(npc_windwatcherAI, creature->AI()))
        {
            pEscortAI->SetClearWaypoints(true);
            pEscortAI->SetDespawnAtEnd(false);
            pEscortAI->SetDespawnAtFar(false);
            pEscortAI->Start(false, false, player->GetGUID(), quest);
        }
        DoScriptText(SAY_START, creature, player);
    }
    return true;
}

void AddSC_alterac_mountains()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_ravenholdt";
    newscript->GetAI = &GetAI_npc_ravenholdt;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_windwatcher";
    newscript->GetAI = &GetAI_npc_windwatcher;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_windwatcher;
    newscript->RegisterSelf();
}

