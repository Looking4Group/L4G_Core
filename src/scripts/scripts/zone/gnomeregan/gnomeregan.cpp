/* 
 * Copyright (C) 2006-2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2008-2014 Looking4Group <http://looking4group.de/>
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

/* ScriptData
SDName: Gnomeregan
SD%Complete: 100
SDComment: Support for Quest 2904 (A fine mess)
SDCategory: Gnomeregan
EndScriptData
*/

/* ContentData
npc_kernobee
EndContentData */

#include "precompiled.h"
#include "PetAI.h"
#include "Language.h"
#include "follower_ai.h"
#include "escort_ai.h"
#include <list>

#include <cstring>


enum eKernobee
{
    QUEST_A_FINE_MESS = 2904,
    LOC_X             = -339,
    LOC_Y             = 1,
    LOC_Z             = -153
};

struct npc_kernobee : public FollowerAI
{
    npc_kernobee(Creature* c) : FollowerAI(c) {}

    uint32 CheckTimer;

    void Reset() 
    {
        CheckTimer = 1000;
    }

    void UpdateFollowerAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
        {
            if (CheckTimer <= uiDiff) //Less stress
            {
                if (me->GetDistance(LOC_X, LOC_Y, LOC_Z) < 20)
                {
                    if (Player* pPlayer = GetLeaderForFollower())
                    {
                        if (pPlayer->GetQuestStatus(QUEST_A_FINE_MESS) == QUEST_STATUS_INCOMPLETE)
                        {
                            pPlayer->GroupEventHappens(QUEST_A_FINE_MESS, me);
                            SetFollowComplete(true);
                        }
                    }
                }
                CheckTimer = 1000;
            }
            else 
                CheckTimer -= uiDiff;
        }
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_kernobee(Creature *_Creature)
{
    return new npc_kernobee(_Creature);
}

bool QuestAccept_npc_kernobee(Player* pPlayer, Creature* pCreature, const Quest* pQuest)
{
    if (pQuest->GetQuestId() == QUEST_A_FINE_MESS)
    {
        if (npc_kernobee* pkernobee = CAST_AI(npc_kernobee, pCreature->AI()))
        {
            pCreature->SetStandState(UNIT_STAND_STATE_STAND);
            pkernobee->StartFollow(pPlayer, 0, pQuest);
        }
    }

    return true;
}

void AddSC_gnomeregan()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_kernobee";
    newscript->GetAI = &GetAI_npc_kernobee;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_kernobee;
    newscript->RegisterSelf();
}
