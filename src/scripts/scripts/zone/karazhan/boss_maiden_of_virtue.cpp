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
SDName: Boss_Maiden_of_Virtue
SD%Complete: 100
SDComment:
SDCategory: Karazhan
EndScriptData */

#include "precompiled.h"
#include "def_karazhan.h"

#define SAY_AGGRO               -1532018
#define SAY_SLAY1               -1532019
#define SAY_SLAY2               -1532020
#define SAY_SLAY3               -1532021
#define SAY_REPENTANCE1         -1532022
#define SAY_REPENTANCE2         -1532023
#define SAY_DEATH               -1532024

#define SPELL_REPENTANCE        29511
#define SPELL_HOLYFIRE          29522
#define SPELL_HOLYWRATH         32445
#define SPELL_HOLYGROUND        29512
#define SPELL_BERSERK           26662

struct boss_maiden_of_virtueAI : public ScriptedAI
{
    boss_maiden_of_virtueAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);
    }

    ScriptedInstance *pInstance;

    uint32 Repentance_Timer;
    uint32 Holyfire_Timer;
    uint32 Holywrath_Timer;
    uint32 Holyground_Timer;
    uint32 Enrage_Timer;
    uint32 CheckTimer;

    WorldLocation wLoc;

    bool Enraged;

    void Reset()
    {
        Repentance_Timer    = urand(30000, 40000);
        Holyfire_Timer      = urand(8000, 25000);
        Holywrath_Timer     = urand(20000, 25000);
        Holyground_Timer    = 3000;
        Enrage_Timer        = 600000;
        CheckTimer = 3000;

        if(pInstance && pInstance->GetData(DATA_MAIDENOFVIRTUE_EVENT) != DONE)
            pInstance->SetData(DATA_MAIDENOFVIRTUE_EVENT, NOT_STARTED);

        Enraged = false;
    }

    void KilledUnit(Unit* Victim)
    {
        if(rand()%2)
            return;

        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2, SAY_SLAY3), m_creature);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, m_creature);

        if (pInstance)
            pInstance->SetData(DATA_MAIDENOFVIRTUE_EVENT, DONE);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, m_creature);
        if (pInstance)
            pInstance->SetData(DATA_MAIDENOFVIRTUE_EVENT, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim() )
            return;

        if(CheckTimer < diff)
        {
            if(!m_creature->IsWithinDistInMap(&wLoc, 30.0f))
                EnterEvadeMode();
            else
                DoZoneInCombat();

            CheckTimer = 3000;
        }
        else
            CheckTimer -= diff;

        if(Enrage_Timer < diff && !Enraged)
        {
            DoCast(m_creature, SPELL_BERSERK,true);
            Enraged = true;
        }
        else
            Enrage_Timer -=diff;

        if(Holyground_Timer < diff)
        {
            DoCast(m_creature, SPELL_HOLYGROUND, true);     //Triggered so it doesn't interrupt her at all
            Holyground_Timer = 3000;
        }
        else
            Holyground_Timer -= diff;

        if (Repentance_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_REPENTANCE);

            DoScriptText(RAND(SAY_REPENTANCE1, SAY_REPENTANCE2), m_creature);

            Repentance_Timer = urand(30000, 40000);        //A little randomness on that spell
            Holyfire_Timer += 6000;
        }
        else
            Repentance_Timer -= diff;

        if(Holyfire_Timer < diff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0,GetSpellMaxRange(SPELL_HOLYFIRE), true))
                DoCast(target,SPELL_HOLYFIRE);

                Holyfire_Timer = urand(8000, 25000); //Anywhere from 8 to 25 seconds, good luck having several of those in a row!
        }
        else
            Holyfire_Timer -= diff;

        if(Holywrath_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0,GetSpellMaxRange(SPELL_HOLYWRATH), true))
                DoCast(target,SPELL_HOLYWRATH);

            Holywrath_Timer = urand(20000, 25000);     //20-25 secs sounds nice

        }
        else
            Holywrath_Timer -= diff;

        DoMeleeAttackIfReady();
    }

};

CreatureAI* GetAI_boss_maiden_of_virtue(Creature *_Creature)
{
    return new boss_maiden_of_virtueAI (_Creature);
}

void AddSC_boss_maiden_of_virtue()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_maiden_of_virtue";
    newscript->GetAI = &GetAI_boss_maiden_of_virtue;
    newscript->RegisterSelf();
}

