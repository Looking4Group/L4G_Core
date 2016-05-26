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
SDName: Boss_Pyroguard_Emberseer
SD%Complete: 100
SDComment: Event to activate Emberseer NYI
SDCategory: Blackrock Spire
EndScriptData */

#include "precompiled.h"
#include "def_blackrock_spire.h"

#define SPELL_FIRENOVA          16079
#define SPELL_FLAMEBUFFET       16536
#define SPELL_PYROBLAST         17274
#define SPELL_GROWING           16048
#define SPELL_TRANSFORM         16052
#define SPELL_DESPAWN           16078

enum EmberseerEvents
{
    EMBERSEER_EVENT_GROWING       = 1,
    EMBERSEER_EVENT_TRANSFORM     = 2,
    EMBERSEER_EVENT_FIRENOVA      = 3,
    EMBERSEER_EVENT_FLAMEBUFFET   = 4,
    EMBERSEER_EVENT_PYROBLAST     = 5
};

struct boss_pyroguard_emberseerAI : public BossAI
{
    boss_pyroguard_emberseerAI(Creature *c) : BossAI(c, DATA_EMBERSEER)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 FireNova_Timer;
    uint32 FlameBuffet_Timer;
    uint32 PyroBlast_Timer;

    void Reset()
    {
        FireNova_Timer = 6000;
        FlameBuffet_Timer = 3000;
        PyroBlast_Timer = 14000;
        pInstance->SetData(bossId, NOT_STARTED);
        events.Reset();

        events.SetPhase(0);
    }

    void DoAction(const int32 param)
    {
        switch(param)
        {
            case 1:         //start event
            {
                events.SetPhase(1);
                events.ScheduleEvent(EMBERSEER_EVENT_GROWING, 500, 0, 1);
                events.ScheduleEvent(EMBERSEER_EVENT_TRANSFORM, 60000, 0, 1);
                break;
            }
        }
        BossAI::DoAction(param);
    }

    void JustDied(Unit* killer)
    {
        events.Reset();
        pInstance->SetData(DATA_EMBERSEER, DONE);
    }

    void EnterEvadeMode()
    {
        me->CastSpell(me, SPELL_DESPAWN, false);
        me->ForcedDespawn();
        pInstance->SetData(DATA_EMBERSEER, FAIL);
    }

    void UpdateAI(const uint32 diff)
    {
        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EMBERSEER_EVENT_GROWING:
                {
                    me->CastSpell(me, SPELL_GROWING, true);
                    break;
                }
                case EMBERSEER_EVENT_TRANSFORM:
                {
                    DoScriptText(-2100023, me);
                    DoScriptText(-2100024, me);
                    me->CastSpell(me, SPELL_TRANSFORM, true);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PASSIVE);
                    events.SetPhase(2);
                    events.ScheduleEvent(EMBERSEER_EVENT_FIRENOVA, 6000, 0, 2);
                    events.ScheduleEvent(EMBERSEER_EVENT_FLAMEBUFFET, 3000, 0, 2);
                    events.ScheduleEvent(EMBERSEER_EVENT_PYROBLAST, 14000, 0, 2);
                    break;
                }
                case EMBERSEER_EVENT_FIRENOVA:
                {
                    AddSpellToCast(SPELL_FIRENOVA, CAST_SELF);
                    events.ScheduleEvent(EMBERSEER_EVENT_FIRENOVA, 6000, 0, 2);
                    break;
                }
                case EMBERSEER_EVENT_FLAMEBUFFET:
                {
                    AddSpellToCast(SPELL_FLAMEBUFFET, CAST_TANK);
                    events.ScheduleEvent(EMBERSEER_EVENT_FLAMEBUFFET, 3000, 0, 2);
                    break;
                }
                case EMBERSEER_EVENT_PYROBLAST:
                {
                    AddSpellToCast(SPELL_PYROBLAST, CAST_RANDOM);
                    events.ScheduleEvent(EMBERSEER_EVENT_PYROBLAST, 14000, 0, 2);
                    break;
                }
            }
        }

        if (!UpdateVictim())
        {
            return;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_pyroguard_emberseer(Creature *_Creature)
{
    return new boss_pyroguard_emberseerAI (_Creature);
}

void AddSC_boss_pyroguard_emberseer()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_pyroguard_emberseer";
    newscript->GetAI = &GetAI_boss_pyroguard_emberseer;
    newscript->RegisterSelf();
}

