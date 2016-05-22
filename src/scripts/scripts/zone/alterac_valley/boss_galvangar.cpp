/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/* ScriptData
SDName: Boss_Galvangar
SD%Complete:
SDComment: timers should be adjusted
EndScriptData */

#include "precompiled.h"

#define YELL_AGGRO                 -2100021
#define YELL_EVADE                 -2100022

#define SPELL_CLEAVE               15284
#define SPELL_FRIGHTENING_SHOUT    19134
#define SPELL_WHIRLWIND            13736
#define SPELL_MORTAL_STRIKE        16856


struct boss_galvangarAI : public ScriptedAI
{
    boss_galvangarAI(Creature *c) : ScriptedAI(c)
    {
        m_creature->GetPosition(wLoc);
    }


    uint32 CleaveTimer;
    uint32 FrighteningShoutTimer;
    uint32 WhirlwindTimer;
    uint32 MortalStrikeTimer;
    uint32 CheckTimer;
    WorldLocation wLoc;


    void Reset()
    {
        CleaveTimer                = 4000;
        FrighteningShoutTimer      = 10000;
        WhirlwindTimer             = 5000;
        MortalStrikeTimer          = 2000;
        CheckTimer                 = 2000;
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(YELL_AGGRO, m_creature);
    }

    void JustRespawned()
    {
        Reset();
    }

    void KilledUnit(Unit* victim){}

    void JustDied(Unit* Killer){}

    void UpdateTimer(uint32 &timer, const uint32 diff)
    {
        if (timer)
            if (timer > diff)
                timer -= diff;
            else
                timer = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CheckTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 20.0f))
            {
                EnterEvadeMode();
                return;
            }
            CheckTimer = 2000;
        }
        else
            CheckTimer -= diff;


        UpdateTimer(CleaveTimer, diff);
        UpdateTimer(WhirlwindTimer, diff);
        UpdateTimer(FrighteningShoutTimer, diff);
        UpdateTimer(MortalStrikeTimer, diff);

        if (CleaveTimer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_CLEAVE);
            CleaveTimer =  urand(4000, 12000);
        }

        if (FrighteningShoutTimer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_FRIGHTENING_SHOUT);
            FrighteningShoutTimer = urand(14000, 24000);
        }

        if (MortalStrikeTimer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_MORTAL_STRIKE);
            MortalStrikeTimer = 6000;
        }

        if (WhirlwindTimer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_WHIRLWIND);
            WhirlwindTimer = 10000;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_galvangar(Creature *_Creature)
{
    return new boss_galvangarAI (_Creature);
}

void AddSC_boss_galvangar()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_galvangar";
    newscript->GetAI = &GetAI_boss_galvangar;
    newscript->RegisterSelf();
}
