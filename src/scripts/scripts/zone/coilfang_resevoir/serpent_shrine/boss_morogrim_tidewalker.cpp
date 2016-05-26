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
SDName: Boss_Morogrim_Tidewalker
SD%Complete: 90
SDComment: Water globules don't explode properly, remove hacks
SDCategory: Coilfang Resevoir, Serpent Shrine Cavern
EndScriptData */

#include "precompiled.h"
#include "def_serpent_shrine.h"

#define SAY_AGGRO                   -1548030
#define SAY_SUMMON1                 -1548031
#define SAY_SUMMON2                 -1548032
#define SAY_SUMMON_BUBL1            -1548033
#define SAY_SUMMON_BUBL2            -1548034
#define SAY_SLAY1                   -1548035
#define SAY_SLAY2                   -1548036
#define SAY_SLAY3                   -1548037
#define SAY_DEATH                   -1548038
#define EMOTE_WATERY_GRAVE          -1548039
#define EMOTE_EARTHQUAKE            -1548040
#define EMOTE_WATERY_GLOBULES       -1548041

#define SPELL_TIDAL_WAVE            37730
#define SPELL_WATERY_GRAVE          38049
#define SPELL_EARTHQUAKE            37764
#define SPELL_WATERY_GRAVE_EXPLOSION 37852

/*#define SPELL_SUMMON_MURLOC_A6    39813
#define SPELL_SUMMON_MURLOC_A7  39814
#define SPELL_SUMMON_MURLOC_A8  39815
#define SPELL_SUMMON_MURLOC_A9  39816
#define SPELL_SUMMON_MURLOC_A10 39817

#define SPELL_SUMMON_MURLOC_B6  39818
#define SPELL_SUMMON_MURLOC_B7  39819
#define SPELL_SUMMON_MURLOC_B8  39820
#define SPELL_SUMMON_MURLOC_B9  39821
#define SPELL_SUMMON_MURLOC_B10 39822*/

uint32 summonGlobules[4] = {37854, 37858, 37860, 37861};
uint32 wateryGraves[4] = {38023, 38024, 38025, 37850};

float MurlocCords[10][5] =
{
    {21920, 424.36, -715.4, -7.14, 0.124},
    {21920, 425.13, -719.3, -7.14, 0.124},
    {21920, 425.05, -724.23, -7.14, 0.124},
    {21920, 424.91, -728.68, -7.14, 0.124},
    {21920, 424.84, -732.18, -7.14, 0.124},
    {21920, 321.05, -734.2, -13.15, 0.124},
    {21920, 321.05, -729.4, -13.15, 0.124},
    {21920, 321.05, -724.03, -13.15, 0.124},
    {21920, 321.05, -718.73, -13.15, 0.124},
    {21920, 321.05, -714.24, -13.15, 0.124}
};

//Creatures
#define WATER_GLOBULE               21913
#define TIDEWALKER_LURKER           21920

//Morogrim Tidewalker AI
struct boss_morogrim_tidewalkerAI : public ScriptedAI
{
    boss_morogrim_tidewalkerAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);
    }

    ScriptedInstance* pInstance;

    uint32 TidalWave_Timer;
    uint32 WateryGrave_Timer;
    uint32 Earthquake_Timer;
    uint32 WateryGlobules_Timer;

    WorldLocation wLoc;

    bool Earthquake;
    bool Phase2;

    void Reset()
    {
        TidalWave_Timer = 10000;
        WateryGrave_Timer = 30000;
        Earthquake_Timer = 40000;
        WateryGlobules_Timer = 0;

        Earthquake = false;
        Phase2 = false;

        pInstance->SetData(DATA_MOROGRIMTIDEWALKEREVENT, NOT_STARTED);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2, SAY_SLAY3), m_creature);
    }

    void JustDied(Unit *victim)
    {
        DoScriptText(SAY_DEATH, m_creature);
        pInstance->SetData(DATA_MOROGRIMTIDEWALKEREVENT, DONE);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, m_creature);
        pInstance->SetData(DATA_MOROGRIMTIDEWALKEREVENT, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim() )
            return;

        DoSpecialThings(diff, DO_EVERYTHING, 135.0f);

        //Earthquake_Timer
        if (Earthquake_Timer < diff)
        {
            if (!Earthquake)
            {
                AddSpellToCastWithScriptText(SPELL_EARTHQUAKE, CAST_NULL, EMOTE_EARTHQUAKE);
                Earthquake = true;
                Earthquake_Timer = 10000;
            }
            else
            {
                DoScriptText(RAND(SAY_SUMMON1, SAY_SUMMON2), m_creature);

                for (uint8 i = 0; i < 10; ++i)
                {
                    Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                    Creature* Murloc = m_creature->SummonCreature(MurlocCords[i][0], MurlocCords[i][1], MurlocCords[i][2], MurlocCords[i][3], MurlocCords[i][4], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);

                    if (target && Murloc)
                    {
                        Murloc->setActive(true);
                        Murloc->AI()->AttackStart(target);
                    }
                }

                Earthquake = false;
                Earthquake_Timer = urand(40000, 45000);
            }
        }
        else
            Earthquake_Timer -= diff;

        //TidalWave_Timer
        if (TidalWave_Timer < diff)
        {
            AddSpellToCast(SPELL_TIDAL_WAVE, CAST_NULL);
            TidalWave_Timer = 20000;
        }
        else
            TidalWave_Timer -= diff;

        if (!Phase2)
        {
            //WateryGrave_Timer
            if (WateryGrave_Timer < diff)
            {
                //Teleport 4 players under the waterfalls
                std::list<Unit*> tmpList;
                SelectUnitList(tmpList, 4, SELECT_TARGET_RANDOM, 200.0f, true, me->getVictimGUID());

                int i = 0;
                for (std::list<Unit*>::const_iterator itr = tmpList.begin(); itr != tmpList.end(); ++itr)
                    (*itr)->CastSpell(*itr, wateryGraves[i++], true);

                DoScriptText(RAND(SAY_SUMMON_BUBL1, SAY_SUMMON_BUBL2), m_creature);
                DoScriptText(EMOTE_WATERY_GRAVE, m_creature);
                WateryGrave_Timer = 30000;
            }
            else
                WateryGrave_Timer -= diff;

            //Start Phase2
            if (HealthBelowPct(25))
                Phase2 = true;
        }
        else
        {
            //WateryGlobules_Timer
            if (WateryGlobules_Timer < diff)
            {
                std::list<Unit*> tmpList;
                SelectUnitList(tmpList, 4, SELECT_TARGET_RANDOM, 200.0f, true, me->getVictimGUID());

                int i = 0;
                for (std::list<Unit*>::const_iterator itr = tmpList.begin(); itr != tmpList.end(); ++itr)
                    (*itr)->CastSpell((*itr), summonGlobules[i++], true);

                DoScriptText(EMOTE_WATERY_GLOBULES, m_creature);
                WateryGlobules_Timer = 25000;
            }
            else
                WateryGlobules_Timer -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

//Water Globule AI
#define SPELL_GLOBULE_EXPLOSION 37871

struct mob_water_globuleAI : public ScriptedAI
{
    mob_water_globuleAI(Creature *c) : ScriptedAI(c)
    {
        c->GetPosition(wLoc);
    }

    uint32 Check_Timer;
    WorldLocation wLoc;

    void Reset()
    {
        Check_Timer = 1000;

        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        m_creature->setFaction(14);
    }

    void EnterCombat(Unit *who) {}

    void JustSummoned(Creature * summoner)
    {
        DoZoneInCombat(200.0f);

        Unit * tmpUnit = SelectUnit(SELECT_TARGET_RANDOM, 0, 0, true);

        if (!tmpUnit)
            tmpUnit = summoner;

        m_creature->AddThreat(tmpUnit, 20000.0f);
        AttackStart(tmpUnit);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        if (Check_Timer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 85.0f))
            {
                m_creature->ForcedDespawn();
                return;
            }

            if (m_creature->IsWithinDistInMap(m_creature->getVictim(), 5))
            {
                m_creature->CastSpell(m_creature->getVictim(), SPELL_GLOBULE_EXPLOSION, false);
                m_creature->ForcedDespawn();
            }

            Check_Timer = 1000;
        }
        else
            Check_Timer -= diff;

        //do NOT deal any melee damage to the target.
    }
};

CreatureAI* GetAI_boss_morogrim_tidewalker(Creature *_Creature)
{
    return new boss_morogrim_tidewalkerAI (_Creature);
}

CreatureAI* GetAI_mob_water_globule(Creature *_Creature)
{
    return new mob_water_globuleAI (_Creature);
}

void AddSC_boss_morogrim_tidewalker()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_morogrim_tidewalker";
    newscript->GetAI = &GetAI_boss_morogrim_tidewalker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_water_globule";
    newscript->GetAI = &GetAI_mob_water_globule;
    newscript->RegisterSelf();
}
