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
SDName: Boss_Gothik
SD%Complete: 0
SDComment: Placeholder
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

#define SAY_SPEECH                  -1533040
#define SAY_KILL                    -1533041
#define SAY_DEATH                   -1533042
#define SAY_TELEPORT                -1533043

//Gothik
#define SPELL_HARVESTSOUL           28679
#define SPELL_SHADOWBOLT            29317
#define H_SPELL_SHADOWBOLT          56405
//Unrelenting Trainee
#define SPELL_EAGLECLAW             30285
#define SPELL_KNOCKDOWN_PASSIVE     6961

//Unrelenting Deathknight
#define SPELL_CHARGE                22120
#define SPELL_SHADOW_MARK           27825

//Unrelenting Rider
#define SPELL_UNHOLY_AURA           28340
#define SPELL_SHADOWBOLT_VOLLEY     19729                   //Search thru targets and find those who have the SHADOW_MARK to cast this on

//Spectral Trainee
#define SPELL_ARCANE_EXPLOSION      27989

//Spectral Deathknight
#define SPELL_WHIRLWIND             28334
#define SPELL_SUNDER_ARMOR          25051                   //cannot find sunder that reduces armor by 2950
#define SPELL_CLEAVE                20677
#define SPELL_MANA_BURN             17631

//Spectral Rider
#define SPELL_LIFEDRAIN             24300
//USES SAME UNHOLY AURA AS UNRELENTING RIDER

//Spectral Horse
#define SPELL_STOMP                 27993

struct boss_gothikAI : public ScriptedAI
{
    boss_gothikAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (ScriptedInstance*)c->GetInstanceData();
    }

    ScriptedInstance* pInstance;

    void Reset()
    {
        if (pInstance && pInstance->GetData(DATA_GOTHIK_THE_HARVESTER) != DONE)
            pInstance->SetData(DATA_GOTHIK_THE_HARVESTER, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        if (pInstance)
            pInstance->SetData(DATA_GOTHIK_THE_HARVESTER, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_GOTHIK_THE_HARVESTER, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_gothik(Creature *_Creature)
{
    return new boss_gothikAI (_Creature);
}

void AddSC_boss_gothik()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_gothik";
    newscript->GetAI = &GetAI_boss_gothik;
    newscript->RegisterSelf();
}
