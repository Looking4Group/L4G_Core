/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
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
SDName: Durotar
SD%Complete: 100
SDComment: Quest support: 5441.
SDCategory: Durotar
EndScriptData */

/* ContentData
npc_lazy_peon
EndContentData */

#include "precompiled.h"

/*######
## npc_lazy_peon
######*/

enum LazyPeon
{
    SAY_SPELL_HIT             = -1000622,

    MIN_TIME_TO_GO_ASLEEP     = 60000,         //1 minute
    MAX_TIME_TO_GO_ASLEEP     = 600000,        //10 minutes

    QUEST_LAZY_PEONS          = 5441,
    GO_LUMBERPILE             = 175784,
    SPELL_BUFF_SLEEP          = 17743,
    SPELL_AWAKEN_PEON         = 19938
};

struct npc_lazy_peonAI : public ScriptedAI
{
    npc_lazy_peonAI(Creature *c) : ScriptedAI(c) {}

    uint64 uiPlayerGUID;

    uint32 m_uiRebuffTimer;
    bool work;

    void Reset ()
    {
        uiPlayerGUID = 0;
        work = false;
    }

    void MovementInform(uint32 /*type*/, uint32 id)
    {
        if (id == 1)
        {
            work = true;
            if (GameObject* Lumberpile = FindGameObject(GO_LUMBERPILE, 20, me))
                me->SetFacingToObject(Lumberpile);
        }
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (spell->Id == SPELL_AWAKEN_PEON && caster->GetTypeId() == TYPEID_PLAYER)
        {
            DoScriptText(SAY_SPELL_HIT, me, caster);
            me->RemoveAllAuras();
            if (GameObject* Lumberpile = FindGameObject(GO_LUMBERPILE, 20, me))
                me->GetMotionMaster()->MovePoint(1,Lumberpile->GetPositionX()-1,Lumberpile->GetPositionY(),Lumberpile->GetPositionZ());
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (work == true)
            me->HandleEmoteCommand(466);

        if (m_uiRebuffTimer <= uiDiff)
        {
            DoCast(me, SPELL_BUFF_SLEEP);
            m_uiRebuffTimer = urand(MIN_TIME_TO_GO_ASLEEP, MAX_TIME_TO_GO_ASLEEP);        //Rebuff agian in 1-10 minutes
        }
        else
            m_uiRebuffTimer -= uiDiff;

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_lazy_peon(Creature* pCreature)
{
    return new npc_lazy_peonAI(pCreature);
}

void AddSC_durotar()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_lazy_peon";
    newscript->GetAI = &GetAI_npc_lazy_peon;
    newscript->RegisterSelf();
}
