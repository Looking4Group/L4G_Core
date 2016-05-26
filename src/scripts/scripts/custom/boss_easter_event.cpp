/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

#include "precompiled.h"

//Say-texte

#define say_aggro       "Eindringlinge geortet, ergreife Bereinigungsmaßnahmen."
#define say_phase2      "Schutzsysteme Stufe1 ineffizient, Bedrohung nicht eliminierbar"
#define say_initiate    "Wechsle zu Stufe2, Angriff durch Kollateral-Angriffszauber"
#define say_done        "Vorbereitungen abgeschlossen, beginne Reinigungsprozess"
#define say_enrage      "Kritischen Schaden erlitten, wechsle zu Stufe3"
#define say_kill        "Problem bereinigt."
#define say_death       "......."

//Displays
#define disp_standard   8395
#define disp_feuer      9189   //Braucht mob scale 0.7
#define disp_enrage     8179  //Braucht mob scale 0.7
//Mobs

#define mob_diener_flamme   61551
#define mob_diener_stein    61552



//Spells Phase 1
#define schmerzhafter_schlag    33813        //Angriff auf zweithöchsten in Aggroliste
#define erdbeben                37764                   // 4k dmg 1sec cd                   
#define versteinern             46288                // 8 sec stun, dispellbar, 1.5 sec Castzeit
#define erneuerung              36679                 // HoT vom Gronnpriester
#define fluch_sprachen          13338             // instant; 15 secs dauer 

//Spells Phase 2

#define druckwelle  33061                 // 7k dmg + slow für 5 secs
#define feuerball   30282                  // mind. 40y range, max 100y

//Spells Phase 3
#define steinblick  33128                 // 10 sec stun auf alle im kegelbereich vorm boss, 3 sec castzeit
#define charge      33709                     // ca 2 secs stun
#define feuerboden  30129

//Spells Adds
#define drachenodem     35250
#define verlangsamen    22356

struct boss_easter_eventAI : public ScriptedAI
{
    boss_easter_eventAI(Creature *c) : ScriptedAI(c)
    {
    }
    //Phase1
    uint32 schlag_timer;
    uint32 versteinern_timer;
    uint32 hot_timer;
    uint32 fluch_timer;
    uint32 erdbeben_timer;

    //Phase2
    uint32 prepare_timer;
    uint32 mobspawn_timer;
    uint32 druckwelle_timer; 
    uint32 feuerball_timer;
    uint32 switch_timer;

    //Phase3
    uint32 mob_timer;
    uint32 steinblick_timer;
    uint32 charge_timer; 
    uint32 feuerboden_timer; 

    Unit *global_tar;


    bool phase1;
    bool phase2;
    bool phase3;
    bool is_initial; // Abfrage Vorbereitungszeit für Spieler auf Phase 2
    bool is_say_done; //Abfrage für einmalige Textausgabe
    bool is_enabled; //Abfrage für Hauptphase nach Vorbereitungszeit
    bool is_changed; //Abfrage Display für Phase 3


    void dispchange()
    {
        if(phase2)
        {
            m_creature->SetUInt32Value(UNIT_FIELD_DISPLAYID,disp_feuer);
            m_creature->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.70f);
            m_creature->SetSpeed(MOVE_RUN, 0.75f);
        }
        if(phase3)
        {
            m_creature->SetUInt32Value(UNIT_FIELD_DISPLAYID,disp_enrage);
            m_creature->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.70f);
            m_creature->SetSpeed(MOVE_RUN, 1.00f);
            DoSay(say_enrage,LANG_UNIVERSAL,NULL);
            is_changed=true; 
        }
    }

    void prepare()  //Sub-programm für Vorbereitungszeit zu Phase2
    {
        if(!is_say_done)
        {
            DoSay(say_initiate,LANG_UNIVERSAL,NULL); 
            is_say_done=true;
        }


    }


    void verfluchen()
    {

        std::list<HostilReference *> t_list = m_creature->getThreatManager().getThreatList();
        std::vector<Unit *> targets;

        if(!t_list.size())
            return;

        //begin + 1 , so we don't target the one with the highest threat
        std::list<HostilReference *>::iterator itr = t_list.begin();
        std::advance(itr, 1);
        for( ; itr!= t_list.end(); ++itr)                   //store the threat list in a different container
        {
            Unit *target = Unit::GetUnit(*m_creature, (*itr)->getUnitGuid());
            //only on alive players
            if(target && target->isAlive() && target->GetTypeId() == TYPEID_PLAYER )
                targets.push_back( target);
        }

        int i = 0;
        for(std::vector<Unit *>::iterator itr = targets.begin(); itr!= targets.end(); ++itr, ++i)
        {
            Unit *target = *itr;
            if(target)
            {
                DoCast(target, fluch_sprachen);
            }
        }
    }

    void Reset()
    {

        m_creature->SetUInt32Value(UNIT_FIELD_DISPLAYID,disp_standard);
        m_creature->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.70f);

        //Phase1
        schlag_timer=8500;
        versteinern_timer=6500;
        hot_timer=17000;
        fluch_timer=15000;
        erdbeben_timer=30000;

        //Phase2
        prepare_timer=8000;
        mobspawn_timer=5000;
        druckwelle_timer=6000;
        feuerball_timer=10000;
        switch_timer = 13000;

        //Phase3

        mob_timer=15000;
        steinblick_timer=20000;
        charge_timer=12000;
        feuerboden_timer=16000;



        //Abfragen
        phase1=true;
        phase2=false;
        phase3=false; 
        is_initial=false; // prepare() nicht freigegeben
        is_say_done=false;// Text noch nicht gesagt
        is_enabled=false; // False=Kann nicht vor Ende der Vorbereitungszeit beginnen
        is_changed=false; 


    }

    void KilledUnit(Unit* victim)
    {
        DoSay(say_kill,LANG_UNIVERSAL,NULL);
    }

    void JustDied(Unit* Killer)
    {
        DoSay(say_death,LANG_UNIVERSAL,NULL);

    }

    void EnterCombat(Unit *who)
    {
        DoSay(say_aggro,LANG_UNIVERSAL,NULL);

    }

    void MoveInLineOfSight(Unit* who)
    {

    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if ((m_creature->GetHealth()*100 / m_creature->GetMaxHealth() <75) && phase1)
        {
            phase1=false;
            phase2=true;
        }
        if ((m_creature->GetHealth()*100 / m_creature->GetMaxHealth() <45) && phase2)
        {
            phase2=false;
            phase3=true;
        }

        //Beginn Block Phase 1
        if(phase1)
        {
            //Schmerzhafter Schlag 
            if (schlag_timer < diff)
            {
                Unit* target = SelectUnit(SELECT_TARGET_TOPAGGRO, 0, me->GetMeleeReach(), true, me->getVictimGUID());
                if (!target)
                    target = me->getVictim();

                DoCast(target, schmerzhafter_schlag);
                schlag_timer = 8000;
            }
            else
                schlag_timer -= diff;

            //Versteinern (Singletarget)

            if (versteinern_timer < diff)
            {
                Unit* target = SelectUnit(SELECT_TARGET_TOPAGGRO, 0, me->GetMeleeReach(), true, me->getVictimGUID());
                if (!target)
                    target = me->getVictim();

                DoCast(target, versteinern);
                versteinern_timer = 6500;
            }
            else
                versteinern_timer -= diff;

            if(hot_timer < diff)
            {
                DoCast(me, erneuerung);
                hot_timer=17000;

            }
            else
                hot_timer-= diff;

            if(fluch_timer < diff)
            {
                verfluchen();
                fluch_timer=15000;
            }
            else fluch_timer-=diff;


            if(erdbeben_timer < diff)
            {
                DoCast(me, erdbeben);
                erdbeben_timer=30000;
            }
            else erdbeben_timer-=diff;
        }             
        //Ende Block Phase 1

        //Beginn Block Phase 2


        if (phase2) //Beginn Block Phase 2
        {
            if(!is_initial)
            {
                prepare();
                me->GetMotionMaster()->MovementExpired();
                if(prepare_timer < diff)
                {
                    is_initial=true;
                    is_enabled=true; //Hauptteil von Phase 2 freigegeben
                    me->GetMotionMaster()->MoveChase(me->getVictim());
                    dispchange();
                    DoSay(say_done,LANG_UNIVERSAL,NULL); 

                }
            else prepare_timer-=diff;
            }
            if(is_enabled)
            {
                //Beginn Hauptblock für Phase 2
                if(mobspawn_timer< diff)
                {
                    mobspawn_timer=15000;
                    Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0);

                    if(target && (target->isAlive()))
                    {
                        Creature* steindiener = m_creature->SummonCreature(mob_diener_stein, target->GetPositionX() + 10, target->GetPositionY() + 10, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                        steindiener->Attack(target, true);
                        steindiener->GetMotionMaster()->MoveChase(me->getVictim());
                    }
                }
                else mobspawn_timer-=diff;

                if(druckwelle_timer < diff)
                {
                    DoCast(me, druckwelle);
                    druckwelle_timer=6000;
                }
                else druckwelle_timer-=diff;

                if(feuerball_timer < diff)
                {
                    DoCast(me, feuerball );
                    feuerball_timer=10000;
                }
                else feuerball_timer-=diff;

                if(switch_timer < diff)
                {
                    if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 100, true, m_creature->getVictimGUID()))
                    {
                        DoResetThreat();
                        m_creature->getThreatManager().setCurrentVictim((HostilReference*)target);
                        m_creature->AI()->AttackStart(target);
                        m_creature->AddThreat(target, 5000000.0f);
                        switch_timer=13000;
                    }                    
                }
                else switch_timer-=diff;

                //Ende Hauptblock für Phase 2

            }

        } //Ende Block Phase 2

        if(phase3) //Beginn Hauptblock Phase3
        {
            if(!is_changed)
            {
                dispchange();
            }

            if(mob_timer < diff)
            {
                Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                global_tar = target;
                if(target && (target->isAlive()))
                {
                    global_tar = target;
                    Creature* feuerdiener = m_creature->SummonCreature(mob_diener_flamme, target->GetPositionX() + 10, target->GetPositionY() + 10, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    feuerdiener->Attack(target, true);
                    feuerdiener->GetMotionMaster()->MoveChase(me->getVictim());
                }

                mob_timer=15000;
            }
            else mob_timer-=diff;

            if(steinblick_timer < diff)
            {
                if (global_tar)
                    DoCast(global_tar, steinblick );
                else 
                    DoCast(me->getVictim(), steinblick );
                steinblick_timer=20000;
            }
            else steinblick_timer-=diff;

            if(charge_timer<=diff)
            {
                if (Unit * target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                {              
                    DoCast(target, charge);
                }
                charge_timer=12000;
            }
            else charge_timer-=diff;

            if(feuerboden_timer<=diff)
            {
                if (Unit * target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                {              
                    DoCast(target, feuerboden);
                }
                feuerboden_timer=16000;
            }
            else feuerboden_timer-=diff;

        } //Ende Hauptblock Phase 3


        DoMeleeAttackIfReady();
    }
};

struct add_feuer_eventAI : public ScriptedAI
{
    add_feuer_eventAI(Creature *c) : ScriptedAI(c)
    {        
    }
    uint32 odem_timer;

    void Reset()
    {
        odem_timer=8000;
    }

    void KilledUnit(Unit* victim)
    {
    }

    void JustDied(Unit* Killer)
    {
    }

    void EnterCombat(Unit *who)
    {
        me->GetMotionMaster()->MoveChase(me->getVictim());
    }

    void MoveInLineOfSight(Unit* who)
    {

    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(odem_timer < diff)
        {
            DoCast(me->getVictim(), drachenodem );
            odem_timer=8000;
        }
        else odem_timer-=diff;


        DoMeleeAttackIfReady();
    }
};

struct add_stein_eventAI : public ScriptedAI
{
    add_stein_eventAI(Creature *c) : ScriptedAI(c)
    {        
    }
    uint32 slow_timer;

    void Reset()
    {
        slow_timer=10000;
    }

    void KilledUnit(Unit* victim)
    {
    }

    void JustDied(Unit* Killer)
    {
    }

    void EnterCombat(Unit *who)
    {
        me->GetMotionMaster()->MoveChase(me->getVictim());
    }

    void MoveInLineOfSight(Unit* who)
    {

    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(slow_timer < diff)
        {
            DoCast(me, verlangsamen);
            slow_timer=10000;
        }
        else slow_timer-=diff;


        DoMeleeAttackIfReady();
    }
};



CreatureAI* GetAI_boss_easter_event(Creature *_Creature)
{
    return new boss_easter_eventAI (_Creature);
}

CreatureAI* GetAI_add_feuer_event(Creature *_Creature)
{
    return new add_feuer_eventAI (_Creature);
}

CreatureAI* GetAI_add_stein_event(Creature *_Creature)
{
    return new add_stein_eventAI (_Creature);
}




void AddSC_boss_easter_event()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_easter_event";
    newscript->GetAI = &GetAI_boss_easter_event;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "add_feuer_event";
    newscript->GetAI = &GetAI_add_feuer_event;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "add_stein_event";
    newscript->GetAI = &GetAI_add_stein_event;
    newscript->RegisterSelf();
}
