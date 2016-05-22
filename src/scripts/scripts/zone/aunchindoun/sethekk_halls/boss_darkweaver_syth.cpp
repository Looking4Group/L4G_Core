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
SDName: Boss_Darkweaver_Syth
SD%Complete: 85
SDComment: Shock spells/times need more work. Heroic partly implemented.
SDCategory: Auchindoun, Sethekk Halls
EndScriptData */

#include "precompiled.h"
#include "def_sethekk_halls.h"

#define SAY_SUMMON                  -1556000

#define SAY_AGGRO_1                 -1556001
#define SAY_AGGRO_2                 -1556002
#define SAY_AGGRO_3                 -1556003

#define SAY_SLAY_1                  -1556004
#define SAY_SLAY_2                  -1556005

#define SAY_DEATH                   -1556006

#define SAY_LAKKA                  -1900253
#define NPC_LAKKA                   18956

#define SPELL_FROST_SHOCK           21401 //37865
#define SPELL_FLAME_SHOCK           34354
#define SPELL_SHADOW_SHOCK          30138
#define SPELL_ARCANE_SHOCK          37132

#define SPELL_CHAIN_LIGHTNING       15659 //15305

#define SPELL_SUMMON_SYTH_FIRE      33537                   // Spawns 19203
#define SPELL_SUMMON_SYTH_ARCANE    33538                   // Spawns 19205
#define SPELL_SUMMON_SYTH_FROST     33539                   // Spawns 19204
#define SPELL_SUMMON_SYTH_SHADOW    33540                   // Spawns 19206

#define SPELL_FLAME_BUFFET          (HeroicMode?38141:33526)
#define SPELL_ARCANE_BUFFET         (HeroicMode?38138:33527)
#define SPELL_FROST_BUFFET          (HeroicMode?38142:33528)
#define SPELL_SHADOW_BUFFET         (HeroicMode?38143:33529)

struct boss_darkweaver_sythAI : public ScriptedAI
{
    boss_darkweaver_sythAI(Creature *c) : ScriptedAI(c)

    {
        HeroicMode = m_creature->GetMap()->IsHeroic();
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance *pInstance;

    uint32 flameshock_timer;
    uint32 arcaneshock_timer;
    uint32 frostshock_timer;
    uint32 shadowshock_timer;
    uint32 chainlightning_timer;
    //add variablen
	uint64 elementar[16];
	uint64 elementara[16];
	uint64 elementarb[16];
	uint64 elementarc[16];
	uint32 anzahl_adds;
	uint32 anzahl_addsa;
	uint32 anzahl_addsb;
	uint32 anzahl_addsc;

    bool summon90;
    bool summon50;
    bool summon10;
    bool HeroicMode;

    void Reset()
    {
        flameshock_timer = 2000;
        arcaneshock_timer = 4000;
        frostshock_timer = 6000;
        shadowshock_timer = 8000;
        chainlightning_timer = 15000;
        //Addcounter auf 0 setzen
		anzahl_adds=0;
		anzahl_addsa=0;
		anzahl_addsb=0;
		anzahl_addsc=0;

        summon90 = false;
        summon50 = false;
        summon10 = false;

        if(pInstance)
            pInstance->SetData(DATA_DARKWEAVEREVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO_1, SAY_AGGRO_2, SAY_AGGRO_3), m_creature);
        if(pInstance)
            pInstance->SetData(DATA_DARKWEAVEREVENT, IN_PROGRESS);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, m_creature);

        if (Creature* lakka = GetClosestCreatureWithEntry(me, NPC_LAKKA, 25.0f))
            DoScriptText(SAY_LAKKA, lakka);

        //despawn der adds
        for (int i = 0; i < 16; ++i) {
            Unit *elec = Unit::GetUnit(*m_creature, elementarc[i]);
            if (elec && elec->isAlive())
                elec->DealDamage(elec, elec->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            elementarc[i] = 0;

            Unit *ele = Unit::GetUnit(*m_creature, elementar[i]);
            if (ele && ele->isAlive())
                ele->DealDamage(ele, ele->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            elementar[i] = 0;

            Unit *elea = Unit::GetUnit(*m_creature, elementara[i]);
            if (elea && elea->isAlive())
                elea->DealDamage(elea, elea->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            elementara[i] = 0;

            Unit *eleb = Unit::GetUnit(*m_creature, elementarb[i]);
            if (eleb && eleb->isAlive())
                eleb->DealDamage(eleb, eleb->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            elementarb[i] = 0;
        }

        if(pInstance)
            pInstance->SetData(DATA_DARKWEAVEREVENT, DONE);
    }

    void KilledUnit(Unit* victim)
    {
        if (rand()%2)
            return;

        DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), m_creature);
    }

    void JustSummoned(Creature *summoned)
    {
        if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true))
            summoned->AI()->AttackStart(target);
    }

    void SythSummoning()
    {
        DoScriptText(SAY_SUMMON, m_creature);

        if (m_creature->IsNonMeleeSpellCasted(false))
            m_creature->InterruptNonMeleeSpells(false);
        /*
        DoCast(m_creature,SPELL_SUMMON_SYTH_ARCANE,true);   //front
        DoCast(m_creature,SPELL_SUMMON_SYTH_FIRE,true);     //back
        DoCast(m_creature,SPELL_SUMMON_SYTH_FROST,true);    //left
        DoCast(m_creature,SPELL_SUMMON_SYTH_SHADOW,true);   //right*/

        //neuer spawn um den despawn handhaben zu k�nnen:	 
		
		Creature *ele = m_creature->SummonCreature(19203, me->GetPositionX()+5, me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
		anzahl_adds++;
		elementar[anzahl_adds] = ele->GetGUID();
		Creature *elea = m_creature->SummonCreature(19205, me->GetPositionX(), me->GetPositionY()-5, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
		anzahl_addsa++;
		elementara[anzahl_addsa] = elea->GetGUID();
		Creature *eleb = m_creature->SummonCreature(19204, me->GetPositionX()-5, me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
		anzahl_addsb++;
		elementarb[anzahl_addsb] = eleb->GetGUID();
		Creature *elec = m_creature->SummonCreature(19206, me->GetPositionX(), me->GetPositionY()+5, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
		anzahl_addsc++;
        elementarc[anzahl_addsc] = elec->GetGUID();
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (((m_creature->GetHealth()*100) / m_creature->GetMaxHealth() < 90) && !summon90)
        {
            SythSummoning();
            summon90 = true;
        }

        if (((m_creature->GetHealth()*100) / m_creature->GetMaxHealth() < 50) && !summon50)
        {
            SythSummoning();
            summon50 = true;
        }

        if (((m_creature->GetHealth()*100) / m_creature->GetMaxHealth() < 10) && !summon10)
        {
            SythSummoning();
            summon10 = true;
        }

        if (flameshock_timer < diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 60, true))
                DoCast(target,SPELL_FLAME_SHOCK);

            flameshock_timer = 10000 + rand()%5000;
        } else flameshock_timer -= diff;

        if (arcaneshock_timer < diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 60, true))
                DoCast(target,SPELL_ARCANE_SHOCK);

            arcaneshock_timer = 10000 + rand()%5000;
        } else arcaneshock_timer -= diff;

        if (frostshock_timer < diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true))
                DoCast(target,SPELL_FROST_SHOCK);

            frostshock_timer = 10000 + rand()%5000;
        } else frostshock_timer -= diff;

        if (shadowshock_timer < diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true))
                DoCast(target,SPELL_SHADOW_SHOCK);

            shadowshock_timer = 10000 + rand()%5000;
        } else shadowshock_timer -= diff;

        if (chainlightning_timer < diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true))
                DoCast(target,SPELL_CHAIN_LIGHTNING);

            chainlightning_timer = 25000;
        } else chainlightning_timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_darkweaver_syth(Creature *_Creature)
{
    return new boss_darkweaver_sythAI (_Creature);
}

/* ELEMENTALS */

struct mob_syth_fireAI : public ScriptedAI
{
    mob_syth_fireAI(Creature *c) : ScriptedAI(c)

    {
        HeroicMode = m_creature->GetMap()->IsHeroic();
    }

    uint32 flameshock_timer;
    uint32 flamebuffet_timer;
    bool HeroicMode;

    void Reset()
    {
        m_creature->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
        flameshock_timer = 2500;
        flamebuffet_timer = 5000;
    }

    void EnterCombat(Unit *who) { }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(flameshock_timer < diff)
        {
            if( Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true) )
                DoCast(target,SPELL_FLAME_SHOCK);

            flameshock_timer = 5000;
        }
        else
            flameshock_timer -= diff;

        if(flamebuffet_timer < diff)
        {
            if( Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true) )
                DoCast(target,SPELL_FLAME_BUFFET);

            flamebuffet_timer = 5000;
        }
        else
            flamebuffet_timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_syth_fire(Creature *_Creature)
{
    return new mob_syth_fireAI (_Creature);
}

struct mob_syth_arcaneAI : public ScriptedAI
{
    mob_syth_arcaneAI(Creature *c) : ScriptedAI(c)

    {
        HeroicMode = m_creature->GetMap()->IsHeroic();
    }

    uint32 arcaneshock_timer;
    uint32 arcanebuffet_timer;
    bool HeroicMode;

    void Reset()
    {
        m_creature->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_ARCANE, true);
        arcaneshock_timer = 2500;
        arcanebuffet_timer = 5000;
    }

    void EnterCombat(Unit *who) { }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(arcaneshock_timer < diff)
        {
            if( Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true) )
                DoCast(target,SPELL_ARCANE_SHOCK);

            arcaneshock_timer = 5000;
        }
        else
            arcaneshock_timer -= diff;

        if(arcanebuffet_timer < diff)
        {
            if( Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true) )
                DoCast(target,SPELL_ARCANE_BUFFET);

            arcanebuffet_timer = 5000;
        }
        else
            arcanebuffet_timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_syth_arcane(Creature *_Creature)
{
    return new mob_syth_arcaneAI (_Creature);
}

struct mob_syth_frostAI : public ScriptedAI
{
    mob_syth_frostAI(Creature *c) : ScriptedAI(c)

    {
        HeroicMode = m_creature->GetMap()->IsHeroic();
    }

    uint32 frostshock_timer;
    uint32 frostbuffet_timer;
    bool HeroicMode;

    void Reset()
    {
        m_creature->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FROST, true);
        frostshock_timer = 2500;
        frostbuffet_timer = 5000;
    }

    void EnterCombat(Unit *who) { }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(frostshock_timer < diff)
        {
            if( Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true) )
                DoCast(target,SPELL_FROST_SHOCK);

            frostshock_timer = 5000;
        }
        else
            frostshock_timer -= diff;

        if(frostbuffet_timer < diff)
        {
            if( Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true) )
                DoCast(target,SPELL_FROST_BUFFET);

            frostbuffet_timer = 5000;
        }
        else
            frostbuffet_timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_syth_frost(Creature *_Creature)
{
    return new mob_syth_frostAI (_Creature);
}

struct mob_syth_shadowAI : public ScriptedAI
{
    mob_syth_shadowAI(Creature *c) : ScriptedAI(c)

    {
        HeroicMode = m_creature->GetMap()->IsHeroic();
    }

    uint32 shadowshock_timer;
    uint32 shadowbuffet_timer;
    bool HeroicMode;

    void Reset()
    {
        m_creature->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_SHADOW, true);
        shadowshock_timer = 2500;
        shadowbuffet_timer = 5000;
    }

    void EnterCombat(Unit *who) { }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(shadowshock_timer < diff)
        {
            if( Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true) )
                DoCast(target,SPELL_SHADOW_SHOCK);

            shadowshock_timer = 5000;
        }
        else
            shadowshock_timer -= diff;

        if(shadowbuffet_timer < diff)
        {
            if( Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0, 60, true) )
                DoCast(target,SPELL_SHADOW_BUFFET);

            shadowbuffet_timer = 5000;
        }
        else
            shadowbuffet_timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_syth_shadow(Creature *_Creature)
{
    return new mob_syth_shadowAI (_Creature);
}

void AddSC_boss_darkweaver_syth()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_darkweaver_syth";
    newscript->GetAI = &GetAI_boss_darkweaver_syth;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_syth_fire";
    newscript->GetAI = &GetAI_mob_syth_fire;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_syth_arcane";
    newscript->GetAI = &GetAI_mob_syth_arcane;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_syth_frost";
    newscript->GetAI = &GetAI_mob_syth_frost;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_syth_shadow";
    newscript->GetAI = &GetAI_mob_syth_shadow;
    newscript->RegisterSelf();
}

