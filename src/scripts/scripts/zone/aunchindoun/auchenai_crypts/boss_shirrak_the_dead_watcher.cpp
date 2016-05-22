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
Name: Boss_Shirrak_the_dead_watcher
%Complete: 80
Comment: InhibitMagic should stack slower far from the boss, proper Visual for Focus Fire, heroic implemented
Category: Auchindoun, Auchenai Crypts
EndScriptData */

#include "precompiled.h"

#define SPELL_INHIBITMAGIC          32264
#define SPELL_ATTRACTMAGIC          32265
#define N_SPELL_CARNIVOROUSBITE     36383
#define H_SPELL_CARNIVOROUSBITE     39382
#define SPELL_CARNIVOROUSBITE       (HeroicMode?H_SPELL_CARNIVOROUSBITE:N_SPELL_CARNIVOROUSBITE)

#define ENTRY_FOCUS_FIRE            18374

#define N_SPELL_FIERY_BLAST         32302
#define H_SPELL_FIERY_BLAST         38382
#define SPELL_FIERY_BLAST           (HeroicMode?H_SPELL_FIERY_BLAST:N_SPELL_FIERY_BLAST)
#define SPELL_FOCUS_FIRE_VISUAL     42075 //need to find better visual

struct boss_shirrak_the_dead_watcherAI : public ScriptedAI
{
    boss_shirrak_the_dead_watcherAI(Creature *c) : ScriptedAI(c)
    {
        HeroicMode = m_creature->GetMap()->IsHeroic();
    }

    uint32 Inhibitmagic_Timer;
    uint32 Attractmagic_Timer;
    uint32 Carnivorousbite_Timer;
    uint32 FocusFire_Timer;
    bool HeroicMode;
    Unit *focusedTarget;

    void Reset()
    {
        Inhibitmagic_Timer = 0;
        Attractmagic_Timer = 28000;
        Carnivorousbite_Timer = 10000;
        FocusFire_Timer = 17000;
        focusedTarget = NULL;
    }

    void EnterCombat(Unit *who)
    {
    }

    void JustDied(Unit *killer)
    {
            Map *map = m_creature->GetMap();
            Map::PlayerList const &PlayerList = map->GetPlayers();
            for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if(Player* i_pl = i->getSource())
                    i_pl->RemoveAurasDueToSpell(SPELL_INHIBITMAGIC,0);
            }
    }

    void JustSummoned(Creature *summoned)
    {
        if (summoned && summoned->GetEntry() == ENTRY_FOCUS_FIRE)
        {
            summoned->CastSpell(summoned,SPELL_FOCUS_FIRE_VISUAL,false);
            summoned->setFaction(m_creature->getFaction());
            summoned->SetLevel(m_creature->getLevel());
            summoned->addUnitState(UNIT_STAT_ROOT);

            if(focusedTarget)
                summoned->AI()->AttackStart(focusedTarget);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        //Inhibitmagic_Timer
        if(Inhibitmagic_Timer < diff)
        {
            float dist;
            Map *map = m_creature->GetMap();
            Map::PlayerList const &PlayerList = map->GetPlayers();
            for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (Player* i_pl = i->getSource())
                {
                    if(i_pl->isAlive() && (dist = i_pl->GetDistance(m_creature)) <= 45)
                    {
                        i_pl->RemoveAurasDueToSpell(SPELL_INHIBITMAGIC,0);
                        m_creature->AddAura(SPELL_INHIBITMAGIC, i_pl);
                        if(Aura *inh_magic = i_pl->GetAura(SPELL_INHIBITMAGIC,0))
                        {
                            if(dist < 35)
                                m_creature->AddAura(SPELL_INHIBITMAGIC, i_pl);
                            if(dist < 25)
                                m_creature->AddAura(SPELL_INHIBITMAGIC, i_pl);
                            if(dist < 15)
                               m_creature->AddAura(SPELL_INHIBITMAGIC, i_pl);
                        }
                    }
                }
            }
            Inhibitmagic_Timer = 3500;
        }
        else
            Inhibitmagic_Timer -= diff;

        //Return since we have no target
        if (!UpdateVictim())
            return;

        //Attractmagic_Timer
        if (Attractmagic_Timer < diff)
        {
            DoCast(m_creature,SPELL_ATTRACTMAGIC);
            Attractmagic_Timer = 30000;
            Carnivorousbite_Timer = 1500;
        }
        else
            Attractmagic_Timer -= diff;

        //Carnivorousbite_Timer
        if (Carnivorousbite_Timer < diff)
        {
            DoCast(m_creature,SPELL_CARNIVOROUSBITE);
            Carnivorousbite_Timer = 10000;
        }
        else
            Carnivorousbite_Timer -= diff;

        //FocusFire_Timer
        if (FocusFire_Timer < diff)
        {
            // Summon Focus Fire & Emote
            Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0,60, true, m_creature->getVictimGUID());
            if (target && target->GetTypeId() == TYPEID_PLAYER && target->isAlive())
            {
                focusedTarget = target;
                m_creature->SummonCreature(ENTRY_FOCUS_FIRE,target->GetPositionX(),target->GetPositionY(),target->GetPositionZ(),0,TEMPSUMMON_TIMED_DESPAWN,5500);

                // Emote
                std::string *emote = new std::string("focuses on ");
                emote->append(target->GetName());
                emote->append("!");
                DoTextEmote(emote->c_str(),NULL,true);
                delete emote;
            }
            FocusFire_Timer = 15000+(rand()%5000);
        }
        else
            FocusFire_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_shirrak_the_dead_watcher(Creature *_Creature)
{
    return new boss_shirrak_the_dead_watcherAI (_Creature);
}

struct mob_focus_fireAI : public ScriptedAI
{
    mob_focus_fireAI(Creature *c) : ScriptedAI(c)
    {
        HeroicMode = m_creature->GetMap()->IsHeroic();
    }

    bool HeroicMode;
    uint32 FieryBlast_Timer;
    bool fiery1, fiery2;

    void Reset()
    {
        FieryBlast_Timer = 3000+(rand()%1000);
        fiery1 = fiery2 = true;
    }

    void EnterCombat(Unit *who)
    { }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim() )
            return;

        //FieryBlast_Timer
        if (fiery2 && FieryBlast_Timer < diff)
        {
            DoCast(m_creature,SPELL_FIERY_BLAST);

            if(fiery1)
                fiery1 = false;
            else
                if(fiery2)
                    fiery2 = false;

            FieryBlast_Timer = 1000;
        }
        else
            FieryBlast_Timer -= diff;

        //DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_focus_fire(Creature *_Creature)
{
    return new mob_focus_fireAI (_Creature);
}

void AddSC_boss_shirrak_the_dead_watcher()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_shirrak_the_dead_watcher";
    newscript->GetAI = &GetAI_boss_shirrak_the_dead_watcher;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_focus_fire";
    newscript->GetAI = &GetAI_mob_focus_fire;
    newscript->RegisterSelf();
}

