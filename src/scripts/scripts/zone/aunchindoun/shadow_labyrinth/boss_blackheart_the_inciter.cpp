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
SDName: Boss_Blackheart_the_Inciter
SD%Complete: 100
SDComment:
SDCategory: Auchindoun, Shadow Labyrinth
EndScriptData */

#include "precompiled.h"
#include "def_shadow_labyrinth.h"
#include "PlayerAI.h"

#define SPELL_INCITE_CHAOS    33676
#define SPELL_CHARGE          33709
#define SPELL_WAR_STOMP       33707

#define SAY_INTRO1          -1555008
#define SAY_INTRO2          -1555009
#define SAY_INTRO3          -1555010
#define SAY_AGGRO1          -1555011
#define SAY_AGGRO2          -1555012
#define SAY_AGGRO3          -1555013
#define SAY_SLAY1           -1555014
#define SAY_SLAY2           -1555015
#define SAY_HELP            -1555016
#define SAY_DEATH           -1555017

#define SAY2_INTRO1         -1555018
#define SAY2_INTRO2         -1555019
#define SAY2_INTRO3         -1555020
#define SAY2_AGGRO1         -1555021
#define SAY2_AGGRO2         -1555022
#define SAY2_AGGRO3         -1555023
#define SAY2_SLAY1          -1555024
#define SAY2_SLAY2          -1555025
#define SAY2_HELP           -1555026
#define SAY2_DEATH          -1555027

static uint32 trashEntry[]=
{
    18631,
    18633,
    18635,
    18637,
    18640,
    18642,
    18848
};

struct boss_blackheart_the_inciterAI : public ScriptedAI
{
    boss_blackheart_the_inciterAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    bool InciteChaos;
    uint32 InciteChaos_Timer;
    uint32 InciteChaosWait_Timer;
    uint32 Charge_Timer;
    uint32 Knockback_Timer;

    void Reset()
    {
        InciteChaos = false;
        InciteChaos_Timer = 20000;
        InciteChaosWait_Timer = 15000;
        Charge_Timer = 5000;
        Knockback_Timer = 15000;

        if (pInstance)
            pInstance->SetData(DATA_BLACKHEARTTHEINCITEREVENT, NOT_STARTED);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2), me);
    }

    void JustDied(Unit *victim)
    {
        DoScriptText(SAY_DEATH, me);

        if( pInstance )
            pInstance->SetData(DATA_BLACKHEARTTHEINCITEREVENT, DONE);
    }

    void TrashAggro()
    {
        std::list<Creature*> TrashEntryList;
        std::list<Creature*> TrashList;

        TrashList.clear();

        for(uint8 i = 0; i < 7; ++i)
        {
            TrashEntryList.clear();
            TrashEntryList = FindAllCreaturesWithEntry(trashEntry[i], 100.0f);

            for(std::list<Creature*>::iterator iter = TrashEntryList.begin(); iter != TrashEntryList.end(); ++iter)
                TrashList.push_back(*iter);
        }

        if(!TrashList.empty())
             for(std::list<Creature*>::iterator i = TrashList.begin(); i != TrashList.end(); ++i)
             {
                 (*i)->setActive(true);
                 (*i)->AI()->AttackStart(me->getVictim());
             }
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), me);

        TrashAggro();

        if (pInstance)
            pInstance->SetData(DATA_BLACKHEARTTHEINCITEREVENT, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        if(InciteChaos)
        {
            if(InciteChaosWait_Timer < diff)
            {
                InciteChaos = false;
                DoZoneInCombat();
                DoResetThreat();

                Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 50, true);
                if(target)
                    AttackStart(target);
            }
            else
                InciteChaosWait_Timer -= diff;

            return;
        }

        if (!UpdateVictim())
            return;
        else
            TrashAggro();

        if(InciteChaos_Timer < diff)
        {
            DoCast(me, SPELL_INCITE_CHAOS);

            Map *map = me->GetMap();
            Map::PlayerList const &PlayerList = map->GetPlayers();

            if(PlayerList.isEmpty())
                return;

            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                Player *plr = i->getSource();
                if(plr && plr->IsAIEnabled)
                {
                    Player *target = (Player*)plr->AI()->SelectUnit(SELECT_TARGET_NEAREST, 0, 60, true, plr->GetGUID());
                    if (target)
                        plr->AI()->AttackStart(target);
                }
            }

            //DoResetThreat();
            InciteChaos = true;
            InciteChaos_Timer = 40000;
            InciteChaosWait_Timer = 16000;
            return;
        }
        else
            InciteChaos_Timer -= diff;

        //Charge_Timer
        if (Charge_Timer < diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 50, true))
                DoCast(target, SPELL_CHARGE);
            Charge_Timer = 25000;
        }
        else
            Charge_Timer -= diff;

        //Knockback_Timer
        if (Knockback_Timer < diff)
        {
            DoCast(me, SPELL_WAR_STOMP);
            Knockback_Timer = 20000;
        }
        else
            Knockback_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_blackheart_the_inciter(Creature *_Creature)
{
    return new boss_blackheart_the_inciterAI (_Creature);
}

void AddSC_boss_blackheart_the_inciter()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_blackheart_the_inciter";
    newscript->GetAI = &GetAI_boss_blackheart_the_inciter;
    newscript->RegisterSelf();
}

