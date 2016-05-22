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
SDName: Boss_Ayamiss
SD%Complete: 50
SDComment: VERIFY SCRIPT, Wasp include missing, larvas and sacrifice too, not flying in phase one
SDCategory: Ruins of Ahn'Qiraj
EndScriptData */

#include "precompiled.h"
#include "def_ruins_of_ahnqiraj.h"

/*
To do:
make him fly from 70-100%
*/

#define SPELL_STINGERSPRAY      25749
#define SPELL_POISONSTINGER     25748                           //only used in phase1
#define SPELL_SUMMONSWARMER     25844                           //might be 25708
#define SPELL_PARALYZE          25725                           //23414(wtf?) doesnt work correct (core)

#define CREATURE_LARVA  15555       //tries to eat paralyzed target
#define SPELL_FEED      25721       //used by larva on paralyzed target

#define CREATURE_SWARMER        15546                           //propably we need to summon them manually

static float position[3] =
{
    -9664.55,
    1562.54,
    22.05
};

struct boss_ayamissAI : public ScriptedAI
{
    boss_ayamissAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (ScriptedInstance*)c->GetInstanceData();
    }

    ScriptedInstance * pInstance;
    Unit *pTarget;
    uint32 STINGERSPRAY_Timer;
    uint32 POISONSTINGER_Timer;
    uint32 SUMMONSWARMER_Timer;
    uint32 phase;

    void Reset()
    {
        pTarget = NULL;
        STINGERSPRAY_Timer = 30000;
        POISONSTINGER_Timer = 3500;
        SUMMONSWARMER_Timer = 60000;
        phase=1;
        m_creature->SetLevitate(true);

        if (pInstance)
            pInstance->SetData(DATA_AYAMISS_THE_HUNTER, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        pTarget = who;
        m_creature->SetLevitate(true);
        m_creature->GetMotionMaster()->MovePoint(0, position[0], position[1], position[2]);

        if (pInstance)
            pInstance->SetData(DATA_AYAMISS_THE_HUNTER, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_AYAMISS_THE_HUNTER, DONE);
    }

    void AttackStart(Unit* who)
    {
        if(phase==1)
            AttackStartNoMove(who);
        else
            ScriptedAI::AttackStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim() )
            return;

        //If he is 70% start phase 2
        if (phase==1 && m_creature->GetHealth()*100 / m_creature->GetMaxHealth() <= 70 && !m_creature->IsNonMeleeSpellCasted(false))
        {
            phase=2;
        }

        //STINGERSPRAY_Timer
        if (STINGERSPRAY_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_STINGERSPRAY);
            STINGERSPRAY_Timer = 30000;
        }
        else STINGERSPRAY_Timer -= diff;

        //POISONSTINGER_Timer (only in phase1)
        if (phase==1 && POISONSTINGER_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_POISONSTINGER);
            POISONSTINGER_Timer = 3500;
        }
        else POISONSTINGER_Timer -= diff;

        //SUMMONSWARMER_Timer
        if (SUMMONSWARMER_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_SUMMONSWARMER);
            SUMMONSWARMER_Timer = 60000;
        }
        else SUMMONSWARMER_Timer -= diff;

        //melee in phase 2 only
        if (phase!=1)
        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_ayamiss(Creature *_Creature)
{
    return new boss_ayamissAI (_Creature);
}

struct larvaAI : public ScriptedAI
{
    larvaAI(Creature *c) : ScriptedAI(c){}

    uint32 WP;

    void Reset()
    {
        WP = 0;
    }
    void UpdateAI(const uint32 diff)
    {}
};

CreatureAI* GetAI_larva(Creature *_Creature)
{
    return new larvaAI (_Creature);
}

void AddSC_boss_ayamiss()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_ayamiss";
    newscript->GetAI = &GetAI_boss_ayamiss;
    newscript->RegisterSelf();
}

void AddSC_larva()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="larva";
    newscript->GetAI = &GetAI_larva;
    newscript->RegisterSelf();
}
