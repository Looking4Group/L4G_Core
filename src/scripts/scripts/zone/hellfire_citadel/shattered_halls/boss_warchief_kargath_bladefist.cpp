/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
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
SDName: Instance_Shattered_Halls
SD%Complete: 95
SDComment:
SDCategory: Hellfire Citadel, Shattered Halls
EndScriptData */

/* ContentData
boss_warchief_kargath_bladefist
EndContentData */

#include "precompiled.h"
#include "def_shattered_halls.h"

#define SPELL_BLADE_DANCE               30739
#define H_SPELL_CHARGE                  25821

#define TARGET_NUM                      5

#define MOB_SHATTERED_ASSASSIN          17695
#define MOB_HEARTHEN_GUARD              17621
#define MOB_SHARPSHOOTER_GUARD          17622
#define MOB_REAVER_GUARD                17623

float AssassEntrance[3] = {275.136,-84.29,2.3}; // y +-8
float AssassExit[3] = {184.233,-84.29,2.3}; // y +-8
float AddsEntrance[3] = {306.036,-84.29,1.93};

#define SAY_AGGRO1                      -1540042
#define SAY_AGGRO2                      -1540043
#define SAY_AGGRO3                      -1540044
#define SAY_SLAY1                       -1540045
#define SAY_SLAY2                       -1540046
#define SAY_DEATH                       -1540047

struct boss_warchief_kargath_bladefistAI : public ScriptedAI
{
    boss_warchief_kargath_bladefistAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        HeroicMode = me->GetMap()->IsHeroic();
    }

    ScriptedInstance* pInstance;
    bool HeroicMode;

    std::vector<uint64> adds;
    std::vector<uint64> assassins;

    uint32 Charge_timer;
    uint32 Blade_Dance_Timer;
    uint32 Summon_Assistant_Timer;
    uint32 Assistant_Timer;
    uint32 resetcheck_timer;
    uint32 Wait_Timer;

    uint32 Assassins_Timer;

    uint32 summoned;
    bool InBlade;
    bool Assistant;

    uint32 target_num;

    void Reset()
    {
        removeAdds();

        me->SetSpeed(MOVE_RUN,2);
        me->SetWalk(false);

        summoned = 1;
        InBlade = false;
        Wait_Timer = 0;
        Assistant = false;

        Charge_timer = 0;
        Blade_Dance_Timer = 30000;
        Summon_Assistant_Timer = (HeroicMode ? 20000 : 30000);
        Assistant_Timer = 120000;
        Assassins_Timer = 5000;
        resetcheck_timer = 5000;

        if (pInstance)
            pInstance->SetData(TYPE_KARGATH, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO1,SAY_AGGRO2,SAY_AGGRO3), me);

        if (pInstance)
        {
            if (pInstance->GetData(TYPE_WARBRINGER) != DONE)
            {
                Creature *War = Unit::GetCreature(*me, pInstance->GetData64(DATA_WARBRINGER));
                if (War && War->isAlive())
                    War->AI()->AttackStart(who);
            }
        }
    }

    void JustSummoned(Creature *summoned)
    {
        switch(summoned->GetEntry())
        {
            case MOB_HEARTHEN_GUARD:
            case MOB_SHARPSHOOTER_GUARD:
            case MOB_REAVER_GUARD:
                summoned->AI()->AttackStart(SelectUnit(SELECT_TARGET_RANDOM,0));
                adds.push_back(summoned->GetGUID());
                break;
            case MOB_SHATTERED_ASSASSIN:
                assassins.push_back(summoned->GetGUID());
                break;
        }
    }

    void KilledUnit(Unit *victim)
    {
        if (victim->GetTypeId() == TYPEID_PLAYER)
        {
            DoScriptText(RAND(SAY_SLAY1,SAY_SLAY2), me);
        }
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, me);
        removeAdds();

        if (pInstance)
            pInstance->SetData(TYPE_KARGATH, DONE);
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if(InBlade)
        {
            if(type != POINT_MOTION_TYPE)
                return;

            if(id != 1)
                return;

            if(target_num > 0) // to prevent loops
            {
                Wait_Timer = 1;
                DoCast(me,SPELL_BLADE_DANCE, true);
                target_num--;
            }
        }
    }

    void removeAdds()
    {
        for (std::vector<uint64>::iterator itr = adds.begin(); itr!= adds.end(); ++itr)
        {
            Unit* temp = Unit::GetUnit((*me), *itr);
            if(temp && temp->isAlive())
            {
                (*temp).GetMotionMaster()->Clear(true);
                me->DealDamage(temp,temp->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                ((Creature*)temp)->RemoveCorpse();
            }
        }
        adds.clear();

        for (std::vector<uint64>::iterator itr = assassins.begin(); itr!= assassins.end(); ++itr)
        {
            Unit* temp = Unit::GetUnit((*me), *itr);
            if(temp && temp->isAlive())
            {
                (*temp).GetMotionMaster()->Clear(true);
                me->DealDamage(temp,temp->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                ((Creature*)temp)->RemoveCorpse();
            }
        }
        assassins.clear();
    }
    void SpawnAssassin()
    {
        me->SummonCreature(MOB_SHATTERED_ASSASSIN,AssassEntrance[0],AssassEntrance[1]+8, AssassEntrance[2], 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN,10000);
        me->SummonCreature(MOB_SHATTERED_ASSASSIN,AssassEntrance[0],AssassEntrance[1]-8, AssassEntrance[2], 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN,10000);
        me->SummonCreature(MOB_SHATTERED_ASSASSIN,AssassExit[0],AssassExit[1]+8, AssassExit[2], 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN,10000);
        me->SummonCreature(MOB_SHATTERED_ASSASSIN,AssassExit[0],AssassExit[1]-8, AssassExit[2], 0,TEMPSUMMON_CORPSE_TIMED_DESPAWN,10000);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (Assassins_Timer)
        {
            if (Assassins_Timer < diff)
            {
                //SpawnAssassin();
                Assassins_Timer = 0;
            }
            else
                Assassins_Timer -= diff;
        }

        if (Assistant_Timer)
        {
            if (Assistant_Timer < diff)
            {
                Assistant = true;
                Assistant_Timer = 0;
            }
            else
                Assistant_Timer -= diff;
        }

        if (InBlade)
        {
            if (Wait_Timer)
                if (Wait_Timer < diff)
                {
                    if (target_num <= 0)
                    {
                        // stop bladedance
                        InBlade = false;
                        me->SetSpeed(MOVE_RUN,2);
                        (*me).GetMotionMaster()->MoveChase(me->getVictim());
                        Blade_Dance_Timer = 30000;
                        Wait_Timer = 0;
                        if (HeroicMode)
                            Charge_timer = 5000;
                    }
                    else
                    {
                        //move in bladedance
                        float x,y,randx,randy;
                        randx = (rand()%40);
                        randy = (rand()%40);
                        x = 210+ randx ;
                        y = -60- randy ;
                        (*me).GetMotionMaster()->MovePoint(1,x,y,me->GetPositionZ());
                        Wait_Timer = 0;
                    }
                }
                else
                    Wait_Timer -= diff;
        }
        else
        {
            if (Blade_Dance_Timer)
            {
                if (Blade_Dance_Timer < diff)
                {
                    target_num = TARGET_NUM;
                    Wait_Timer = 1;
                    InBlade = true;
                    Blade_Dance_Timer = 0;
                    me->SetSpeed(MOVE_RUN,4);
                    return;
                }
                else
                    Blade_Dance_Timer -= diff;
            }

            if (Charge_timer)
            {
                if (Charge_timer < diff)
                {
                    DoCast(SelectUnit(SELECT_TARGET_RANDOM,0), H_SPELL_CHARGE);
                    Charge_timer = 0;
                }
                else
                    Charge_timer -= diff;
            }

            if (Summon_Assistant_Timer < diff)
            {
                Unit* target = NULL;
                Creature* Summoned;

                for (int i = 0; i < summoned; i++)
                    Summoned = me->SummonCreature(RAND(MOB_HEARTHEN_GUARD, MOB_SHARPSHOOTER_GUARD, MOB_REAVER_GUARD), AddsEntrance[0], AddsEntrance[1], AddsEntrance[2], 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);

                if (Assistant)
                {
                    if (rand()%100 < 2)
                        summoned++;
                }

                Summon_Assistant_Timer = (HeroicMode ? 15000 : 20000);
            }
            else
                Summon_Assistant_Timer -= diff;

            DoMeleeAttackIfReady();
        }

        if (resetcheck_timer < diff)
        {
            uint32 tempx,tempy;
            tempx = me->GetPositionX();
            tempy = me->GetPositionY();

            if ( tempx > 255 || tempx < 205)
            {
                EnterEvadeMode();
                return;
            }
            resetcheck_timer = 5000;
        }
        else
            resetcheck_timer -= diff;
    }
};

CreatureAI* GetAI_boss_warchief_kargath_bladefist(Creature *_Creature)
{
    return new boss_warchief_kargath_bladefistAI (_Creature);
}

void AddSC_boss_warchief_kargath_bladefist()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_warchief_kargath_bladefist";
    newscript->GetAI = &GetAI_boss_warchief_kargath_bladefist;
    newscript->RegisterSelf();
}

