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
SDName: Boss_Pandemonius
SD%Complete: 75
SDComment: Not known how void blast is done (amount of rapid cast seems to be related to players in party). All mobs remaining in surrounding area should aggro when engaged.
SDCategory: Auchindoun, Mana Tombs
EndScriptData */

#include "precompiled.h"
#include "def_mana_tombs.h"

#define SAY_AGGRO_1                     -1557008
#define SAY_AGGRO_2                     -1557009
#define SAY_AGGRO_3                     -1557010

#define SAY_KILL_1                      -1557011
#define SAY_KILL_2                      -1557012

#define SAY_DEATH                       -1557013

#define EMOTE_DARK_SHELL                -1557014

#define SPELL_VOID_BLAST                32325
#define H_SPELL_VOID_BLAST              38760
#define SPELL_DARK_SHELL                32358
#define H_SPELL_DARK_SHELL              38759

struct boss_pandemoniusAI : public ScriptedAI
{
    boss_pandemoniusAI(Creature *c) : ScriptedAI(c)
    {
        HeroicMode = m_creature->GetMap()->IsHeroic();
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance *pInstance;

    bool HeroicMode;
    uint32 VoidBlast_Timer;
    uint32 DarkShell_Timer;
    uint32 VoidBlast_Counter;

    void Reset()
    {
        VoidBlast_Timer = 30000;
        DarkShell_Timer = 20000;
        VoidBlast_Counter = 0;

        if(pInstance)
            pInstance->SetData(DATA_PANDEMONIUSEVENT, NOT_STARTED);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, m_creature);

        if(pInstance)
            pInstance->SetData(DATA_PANDEMONIUSEVENT, DONE);
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(RAND(SAY_KILL_1, SAY_KILL_2), m_creature);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO_1, SAY_AGGRO_2, SAY_AGGRO_3), m_creature);

        if(pInstance)
            pInstance->SetData(DATA_PANDEMONIUSEVENT, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if( VoidBlast_Timer < diff )
        {
            if( Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 60, true) )
            {
                DoCast(target,HeroicMode ? H_SPELL_VOID_BLAST : SPELL_VOID_BLAST);
                VoidBlast_Timer = 500;
                ++VoidBlast_Counter;
            }

            if( VoidBlast_Counter == 5 )
            {
                VoidBlast_Timer = 25000+rand()%10000;
                VoidBlast_Counter = 0;
            }
        }
        else
            VoidBlast_Timer -= diff;

        if( !VoidBlast_Counter )
        {
            if( DarkShell_Timer < diff )
            {
                if( m_creature->IsNonMeleeSpellCasted(false) )
                    m_creature->InterruptNonMeleeSpells(true);

                DoScriptText(EMOTE_DARK_SHELL, m_creature);

                DoCast(m_creature,HeroicMode ? H_SPELL_DARK_SHELL : SPELL_DARK_SHELL);
                DarkShell_Timer = 20000;
            }
            else
                DarkShell_Timer -= diff;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_pandemonius(Creature *_Creature)
{
    return new boss_pandemoniusAI (_Creature);
}

void AddSC_boss_pandemonius()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_pandemonius";
    newscript->GetAI = &GetAI_boss_pandemonius;
    newscript->RegisterSelf();
}

