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
SDName: Boss_Broggok
SD%Complete: 100
SDComment:
SDCategory: Hellfire Citadel, Blood Furnace
EndScriptData */

#include "precompiled.h"
#include "def_blood_furnace.h"

#define SAY_AGGRO               -1542008

#define SPELL_SLIME_SPRAY       (HeroicMode ? 38458 : 30913)
#define SPELL_POISON_BOLT       (HeroicMode ? 38459 : 30917)
#define SPELL_POISON_CLOUD      30916

enum eEvents
{
    EVENT_NULL,   //0
    EVENT_START,  //1
    EVENT_2_CAGE, //2
    EVENT_3_CAGE, //3
    EVENT_4_CAGE, //4
    EVENT_FIGHT   //5
};

struct CellPosition
{
    float x, y, z, o;
};



static CellPosition CellLocation[]=
{
    { 411.689f, 115.502f, 9.657f, 6.196f },
    { 500.440f, 115.296f, 9.657f, 3.141f },
    { 411.324f,  84.250f, 9.657f, 0.004f },
    { 501.118f,  84.228f, 9.657f, 3.188f }
};

struct boss_broggokAI : public ScriptedAI
{
    boss_broggokAI(Creature *c) : ScriptedAI(c), summons(c)
    {
        pInstance = c->GetInstanceData();
    }

    uint32 AcidSpray_Timer;
    uint32 PoisonSpawn_Timer;
    uint32 PoisonBolt_Timer;
    uint32 checkTimer;
    
    Map *pMap;

    SummonList summons;
    ScriptedInstance *pInstance;

    eEvents phase;

    std::map<uint64, uint8> prisoners;

    void Reset()
    {        
        pMap = me->GetMap();

        AcidSpray_Timer = 10000;
        PoisonSpawn_Timer = urand(8000, 12000);
        PoisonBolt_Timer = 7000;
        checkTimer = 3000;

        summons.DespawnAll();
        prisoners.clear();

        if (pInstance)
        {
            pInstance->SetData(DATA_BROGGOKEVENT, NOT_STARTED);
        }

        me->SetReactState(REACT_PASSIVE);

        phase = EVENT_NULL;

        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

        for (int i = 1; i <= 5; i++)
            pInstance->HandleGameObject(pInstance->GetData64(i), false, NULL);

        for (int i = 0; i < 4; i++)
        {
            for(int j = 0; j < 4; j++)
            {
                if (Creature *pPrisoner = me->SummonCreature(17429, CellLocation[i].x +frand(-2.0, 2.0), CellLocation[i].y +frand(-2.0, 2.0), CellLocation[i].z,  CellLocation[i].o, TEMPSUMMON_DEAD_DESPAWN, 2000))
                {
                    pPrisoner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    pPrisoner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    pPrisoner->SetReactState(REACT_PASSIVE);

                    pPrisoner->SetDisplayId(16332);
                    summons.Summon(pPrisoner);

                    prisoners[pPrisoner->GetGUID()] = i+1;
                }
            }
        }
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, m_creature);

        phase = EVENT_FIGHT;
    }

    void JustDied(Unit *pKiller)
    {
        if (pInstance)
            pInstance->SetData(DATA_BROGGOKEVENT, DONE);

        summons.DespawnAll();
        prisoners.clear();
    }

    void DoAction(const int32 param)
    {
        //The lever has been pulled, phase 1 - start the encounter.
        if (param == EVENT_START)
        {
            if (pInstance)
                pInstance->SetData(DATA_BROGGOKEVENT, IN_PROGRESS);
        }
        //Boss is ready to fight.
        else if (param == EVENT_FIGHT)
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_AGGRESSIVE);

            DoZoneInCombat();
            pInstance->HandleGameObject(pInstance->GetData64(5), true, NULL);
            return;            
        }

        phase = eEvents(param);

        pInstance->HandleGameObject(pInstance->GetData64(phase), true, NULL);
        for (std::map<uint64, uint8>::iterator it = prisoners.begin(); it != prisoners.end(); it++)
        {
            if (it->second == phase)
            {
                if (Creature *pPrisoner = me->GetCreature(it->first))
                {
                    // std::cout << "Should see this 4 times per phase." << std::endl;
                    pPrisoner->SetAggroRange(90.0f);
                    pPrisoner->SetReactState(REACT_AGGRESSIVE);

                    pPrisoner->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    pPrisoner->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    pPrisoner->AI()->DoZoneInCombat();
                }
            }
        }
    }

    //This is called either per instance ID, or per player for that instance ID.
    //It calls this even if you're out of instance - as long as you have an ID.
    //When you reset instance, it stops calling it.
    //Then: The very moment you enter the dungeon, it begins calling it.
    //It's called about 5 times per second.
    //It STOPS executing this method once the boss dies.
    void UpdateAI(const uint32 diff)
    {
        //Save processing power by preventing many if statements being called.
        if (phase == EVENT_NULL)
            return;
        else
        {
            //Here is a fix to a bug. There was no way to reset the boss gauntlet packs if you wiped on it.
            //Therefore, when you run back, encounter is still in progress, and you can simply pull next pack.
            //They should reset.
            if (pMap->GetAlivePlayersCountExceptGMs() == 0)
            {
                //Reset it! We wiped!
                Reset();
            }
        }

        //If the boss does not have a victim yet (Calls ScriptedAI --> CreatureAI --> UpdateVictim)
        if (!UpdateVictim())
        {
            if (checkTimer < diff)
            {
                if (phase != EVENT_FIGHT)
                {
                    bool found = false;
                    for (std::map<uint64, uint8>::iterator it = prisoners.begin(); it != prisoners.end(); it++)
                    {
                        if (it->second == phase)
                        {
                            if (Creature *pPrisoner = me->GetCreature(it->first))
                            {
                                if (pPrisoner->isAlive())
                                {
                                    found = true;
                                    break;
                                }
                            }
                        }
                    }

                    if (!found)
                        DoAction(uint8(phase) +1);
                }
                checkTimer = 2000;
            }
            else
                checkTimer -= diff;

            return;
        }

        if (AcidSpray_Timer < diff)
        {
            AddSpellToCast(me->getVictim(),SPELL_SLIME_SPRAY);
            AcidSpray_Timer = urand(4000, 12000);
        }
        else
            AcidSpray_Timer -=diff;

        if (PoisonBolt_Timer < diff)
        {
            AddSpellToCast(me->getVictim(), SPELL_POISON_BOLT);
            PoisonBolt_Timer = urand(4000, 12000);;
        }
        else
            PoisonBolt_Timer -=diff;

        if (PoisonSpawn_Timer < diff)
        {
            AddSpellToCast(me, SPELL_POISON_CLOUD);
            PoisonSpawn_Timer = 20000;
        }
        else
            PoisonSpawn_Timer -=diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_broggokAI(Creature *_Creature)
{
    return new boss_broggokAI (_Creature);
}

bool GOUse_go_broggok_lever(Player* pPlayer, GameObject* pGo)
{
    if(InstanceData *pInstance = pGo->GetInstanceData())
    {
        if (pInstance->GetData(DATA_BROGGOKEVENT) == IN_PROGRESS)
            return true;

        if (Creature *pBoss = GetClosestCreatureWithEntry(pPlayer, 17380, 200.0f))
            pBoss->AI()->DoAction(EVENT_START);
    }
    pGo->UseDoorOrButton(5);
    return true;
}

//This actually adds the script so it knows it exists.
void AddSC_boss_broggok()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_broggok";
    newscript->GetAI = &GetAI_boss_broggokAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_broggok_lever";
    newscript->pGOUse = &GOUse_go_broggok_lever;
    newscript->RegisterSelf();
}
