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
SD%Complete: 99
SDComment:
SDCategory: Hellfire Citadel, Shattered Halls
EndScriptData */

/* ContentData
boss_blood_guard_porung
EndContentData */

#include "precompiled.h"
#include "def_shattered_halls.h"

#define SPELL_CLEAVE 15496

struct SumonPos
{
    float x, y, z;
};

static SumonPos Pos[]=
{
    {502.24f, 339.12f, 2.105f},
    {503.24f, 292.17f, 1.937f}
};


struct boss_blood_guard_porungAI : public ScriptedAI
{
    boss_blood_guard_porungAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;
    uint32 Cleave_Timer;
    uint64 playerGUID;
    uint8 wave;
    bool waveone;
    bool wavetwo;


    void Reset() 
    {
        Cleave_Timer = 10000;
        playerGUID = 0;
        waveone = false;
        wavetwo = false;
        wave = 0;

        if (pInstance)
            pInstance->SetData(TYPE_PORUNG, NOT_STARTED); 
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER && !((Player*)who)->isGameMaster())
        {
            if (who->IsWithinDistInMap(me, 126.0f) && !waveone)
            {
                playerGUID = who->GetGUID();
                DoSummon();
                ++wave;
                waveone = true;
            }

            if (who->IsWithinDistInMap(me, 76.0f) && !wavetwo)
            {
                playerGUID = who->GetGUID();
                DoSummon();
                wavetwo = true;
            }
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void DoSummon()
    {
        for (uint8 i = 0; i < 4; ++i)
        {
            me->SummonCreature(17462, Pos[wave].x, Pos[wave].y, Pos[wave].z, me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
        }
    }

    void JustSummoned(Creature* summoned)
    {
        if (Player* player = Unit::GetPlayer(playerGUID))
            summoned->AI()->AttackStart(player);
    }

    void JustDied(Unit* Killer)
    {
        if (pInstance)
            pInstance->SetData(TYPE_PORUNG, DONE);
    }

    void EnterCombat(Unit *who)
    {
        if (pInstance)
            pInstance->SetData(TYPE_PORUNG, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (Cleave_Timer < diff)
        {
            DoCast(me->getVictim(), SPELL_CLEAVE, false);
            Cleave_Timer = 7500 + rand()%5000;
        }
        else
            Cleave_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_blood_guard_porung(Creature *_Creature)
{
    return new boss_blood_guard_porungAI (_Creature);
}

struct npc_blood_guardAI : public ScriptedAI
{
    npc_blood_guardAI(Creature *c) : ScriptedAI(c) {}

    uint64 playerGUID;
    uint8 wave;
    bool waveone;
    bool wavetwo;

    void Reset() 
    {
        playerGUID = 0;
        waveone = false;
        wavetwo = false;
        wave = 0;
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER && !((Player*)who)->isGameMaster())
        {
            if (who->IsWithinDistInMap(me, 126.0f) && !waveone)
            {
                playerGUID = who->GetGUID();
                DoSummon();
                ++wave;
                waveone = true;
            }

            if (who->IsWithinDistInMap(me, 76.0f) && !wavetwo)
            {
                playerGUID = who->GetGUID();
                DoSummon();
                wavetwo = true;
            }
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void DoSummon()
    {
        for (uint8 i = 0; i < 4; ++i)
        {
            me->SummonCreature(17462, Pos[wave].x, Pos[wave].y, Pos[wave].z, me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
        }
    }

    void JustSummoned(Creature* summoned)
    {
        if (Player* player = Unit::GetPlayer(playerGUID))
            summoned->AI()->AttackStart(player);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_blood_guard(Creature *_Creature)
{
    return new npc_blood_guardAI (_Creature);
}

void AddSC_boss_blood_guard_porung()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_blood_guard_porung";
    newscript->GetAI = &GetAI_boss_blood_guard_porung;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_blood_guard";
    newscript->GetAI = &GetAI_npc_blood_guard;
    newscript->RegisterSelf();
}
