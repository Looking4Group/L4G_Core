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
SDName: Boss_Omar_The_Unscarred
SD%Complete: 98
SDComment:
SDCategory: Hellfire Citadel, Hellfire Ramparts
EndScriptData */

#include "precompiled.h"
#include "hellfire_ramparts.h"

#define SAY_AGGRO_1                 -1543009
#define SAY_AGGRO_2                 -1543010
#define SAY_AGGRO_3                 -1543011
#define SAY_SUMMON                  -1543012
#define SAY_CURSE                   -1543013
#define SAY_KILL_1                  -1543014
#define SAY_DIE                     -1543015
#define SAY_WIPE                    -1543016

#define SPELL_ORBITAL_STRIKE        30637
#define SPELL_SHADOW_WHIP           30638
#define SPELL_BANE_OF_AURA_TREACHERY (HeroicMode ? 37566 : 30695)
#define SPELL_DEMONIC_SHIELD        31901
#define SPELL_SHADOW_BOLT           (HeroicMode ? 39297 : 30686)
#define SPELL_SUMMON_FIENDISH_HOUND 30707

struct boss_omor_the_unscarredAI : public ScriptedAI
{
    boss_omor_the_unscarredAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 OrbitalStrike_Timer;
    uint32 ShadowWhip_Timer;
    uint32 Aura_Timer;
    uint32 DemonicShield_Timer;
    uint32 Shadowbolt_Timer;
    uint32 Summon_Timer;
    uint64 playerGUID;
    bool CanPullBack;

    void Reset()
    {
        DoScriptText(SAY_WIPE, me);

        OrbitalStrike_Timer = 22000;
        ShadowWhip_Timer = 2000;
        Aura_Timer = urand(12300, 23300);
        DemonicShield_Timer = 1000;
        Shadowbolt_Timer = 1;
        Summon_Timer = 20000;
        playerGUID = 0;
        CanPullBack = false;

        if (pInstance)
            pInstance->SetData(DATA_OMOR, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO_1, SAY_AGGRO_2, SAY_AGGRO_3), me);

        if (pInstance)
            pInstance->SetData(DATA_OMOR, IN_PROGRESS);
    }

    void KilledUnit(Unit* victim)
    {
        if (rand()%2)
            return;

        DoScriptText(SAY_KILL_1, me);
    }

    void JustSummoned(Creature* summoned)
    {
        DoScriptText(SAY_SUMMON, me);

        if (Unit* random = SelectUnit(SELECT_TARGET_RANDOM,0))
            summoned->AI()->AttackStart(random);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DIE, me);

        if (pInstance)
            pInstance->SetData(DATA_OMOR, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (Summon_Timer < diff)
        {
            AddSpellToCast(me, SPELL_SUMMON_FIENDISH_HOUND);
            Summon_Timer = 18000;
        }
        else
            Summon_Timer -= diff;

        if (CanPullBack)
        {
            if (ShadowWhip_Timer < diff)
            {
                if (Unit* temp = Unit::GetUnit(*me,playerGUID))
                {
                    if (temp->HasUnitMovementFlag(MOVEFLAG_FALLINGFAR))
                    {
                        me->InterruptNonMeleeSpells(false);
                        DoCast(temp, SPELL_SHADOW_WHIP);
                    }
                    else 
                    {
                        if (!temp->HasUnitMovementFlag(MOVEFLAG_FALLINGFAR))
                        {
                            playerGUID = 0;
                            CanPullBack = false;
                        }
                    }
                }
                ShadowWhip_Timer = 2200;
            }
            else
                ShadowWhip_Timer -= diff;
        }
        else if (OrbitalStrike_Timer < diff)
        {
            Unit *temp = SelectUnit(SELECT_TARGET_NEAREST, 0, 100, true);

            if (temp && temp->GetTypeId() == TYPEID_PLAYER && me->IsWithinMeleeRange(temp))
            {
                me->InterruptNonMeleeSpells(false);
                DoCast(temp, SPELL_ORBITAL_STRIKE);
                OrbitalStrike_Timer = 22000;
                playerGUID = temp->GetGUID();

                if (playerGUID)
                {
                    CanPullBack = true;
                    ShadowWhip_Timer = 3000;
                }
            }
        }
        else
            OrbitalStrike_Timer -= diff;

        if ((me->GetHealth()*100) / me->GetMaxHealth() < 20)
        {
            if (DemonicShield_Timer < diff)
            {
                AddSpellToCast(me, SPELL_DEMONIC_SHIELD);
                DemonicShield_Timer = 15000;
            }
            else
                DemonicShield_Timer -= diff;
        }

        if (Aura_Timer < diff)
        {
            DoScriptText(SAY_CURSE, me);

            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
            {
                AddSpellToCast(target, SPELL_BANE_OF_AURA_TREACHERY);
                Aura_Timer = urand(8000, 16000);
            }
        }
        else
            Aura_Timer -= diff;

        if (Shadowbolt_Timer < diff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
            {
                if(!me->IsWithinMeleeRange(target))
                {
                    AddSpellToCast(target, SPELL_SHADOW_BOLT);
                    Shadowbolt_Timer = 3000;
                }
            }
        }
        else
            Shadowbolt_Timer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_omor_the_unscarredAI(Creature *_Creature)
{
    return new boss_omor_the_unscarredAI (_Creature);
}

void AddSC_boss_omor_the_unscarred()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_omor_the_unscarred";
    newscript->GetAI = &GetAI_boss_omor_the_unscarredAI;
    newscript->RegisterSelf();
}

