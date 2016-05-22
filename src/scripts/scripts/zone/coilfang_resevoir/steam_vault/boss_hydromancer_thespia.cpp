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
SDName: Boss_Hydromancer_Thespia
SD%Complete: 90
SDComment: Needs additional adjustments (when instance script is adjusted)
SDCategory: Coilfang Resevoir, The Steamvault
EndScriptData */

/* ContentData
boss_hydromancer_thespia
mob_coilfang_waterelemental
EndContentData */

#include "precompiled.h"
#include "def_steam_vault.h"

#define SAY_SUMMON                  -1545000
#define SAY_AGGRO_1                 -1545001
#define SAY_AGGRO_2                 -1545002
#define SAY_AGGRO_3                 -1545003
#define SAY_SLAY_1                  -1545004
#define SAY_SLAY_2                  -1545005
#define SAY_DEAD                    -1545006

#define SPELL_LIGHTNING_CLOUD       25033
#define SPELL_LUNG_BURST            31481
#define SPELL_ENVELOPING_WINDS      31718

struct boss_thespiaAI : public ScriptedAI
{
    boss_thespiaAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        HeroicMode = me->GetMap()->IsHeroic();
    }

    ScriptedInstance *pInstance;
    bool HeroicMode;

    uint32 LightningCloud_Timer;
    uint32 LungBurst_Timer;
    uint32 EnvelopingWinds_Timer;

    void Reset()
    {
        LightningCloud_Timer = 15000;
        LungBurst_Timer = 7000;
        EnvelopingWinds_Timer = 9000;

        std::list<Creature*> water_elementals = FindAllCreaturesWithEntry(17917, 100);
        for(std::list<Creature*>::iterator it = water_elementals.begin(); it != water_elementals.end(); it++)
        {
            (*it)->Respawn();
            (*it)->AI()->EnterEvadeMode();
            (*it)->GetMotionMaster()->MoveTargetedHome();
        }

        if (pInstance && me->isAlive())
            pInstance->SetData(TYPE_HYDROMANCER_THESPIA, NOT_STARTED);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEAD, me);

        if (pInstance)
            pInstance->SetData(TYPE_HYDROMANCER_THESPIA, DONE);
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO_1, SAY_AGGRO_2, SAY_AGGRO_3), me);

        std::list<Creature*> water_elementals = FindAllCreaturesWithEntry(17917, 100);
        for(std::list<Creature*>::iterator it = water_elementals.begin(); it != water_elementals.end(); it++)
            (*it)->AI()->AttackStart(who);

        if (pInstance)
            pInstance->SetData(TYPE_HYDROMANCER_THESPIA, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //LightningCloud_Timer
        if (LightningCloud_Timer < diff)
        {
            //cast twice in Heroic mode
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(target, SPELL_LIGHTNING_CLOUD);
            if (HeroicMode)
                if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                    DoCast(target, SPELL_LIGHTNING_CLOUD);
            LightningCloud_Timer = 15000+rand()%10000;
        }else LightningCloud_Timer -=diff;

        //LungBurst_Timer
        if (LungBurst_Timer < diff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(target, SPELL_LUNG_BURST);
            LungBurst_Timer = 7000+rand()%5000;
        }else LungBurst_Timer -=diff;

        //EnvelopingWinds_Timer
        if (EnvelopingWinds_Timer < diff)
        {
            //cast twice in Heroic mode
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(target, SPELL_ENVELOPING_WINDS);
            if (HeroicMode)
                if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                    DoCast(target, SPELL_ENVELOPING_WINDS);
            EnvelopingWinds_Timer = 10000+rand()%5000;
        }else EnvelopingWinds_Timer -=diff;

        DoMeleeAttackIfReady();
    }
};

#define SPELL_WATER_BOLT_VOLLEY     34449
#define H_SPELL_WATER_BOLT_VOLLEY   37924

struct mob_coilfang_waterelementalAI : public ScriptedAI
{
    mob_coilfang_waterelementalAI(Creature *c) : ScriptedAI(c) {}

    bool HeroicMode;
    uint32 WaterBoltVolley_Timer;

    void Reset()
    {
        HeroicMode = me->GetMap()->IsHeroic();
        WaterBoltVolley_Timer = 3000+rand()%3000;
    }

    void EnterCombat(Unit *who) { }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (WaterBoltVolley_Timer < diff)
        {
            DoCast(me, HeroicMode ? H_SPELL_WATER_BOLT_VOLLEY : SPELL_WATER_BOLT_VOLLEY);
            WaterBoltVolley_Timer = 7000+rand()%5000;
        }else WaterBoltVolley_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_thespiaAI(Creature *_Creature)
{
    return new boss_thespiaAI (_Creature);
}

CreatureAI* GetAI_mob_coilfang_waterelementalAI(Creature *_Creature)
{
    return new mob_coilfang_waterelementalAI (_Creature);
}

void AddSC_boss_hydromancer_thespia()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_hydromancer_thespia";
    newscript->GetAI = &GetAI_boss_thespiaAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_coilfang_waterelemental";
    newscript->GetAI = &GetAI_mob_coilfang_waterelementalAI;
    newscript->RegisterSelf();
}

