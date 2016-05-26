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
SDName: The_Eye
SD%Complete: 100
SDComment:
SDCategory: Tempest Keep, The Eye
EndScriptData */

/* ContentData
mob_crystalcore_devastator
EndContentData */

#include "precompiled.h"
#include "def_the_eye.h"

#define SPELL_COUNTERCHARGE     35035
#define SPELL_KNOCKAWAY         22893

struct mob_crystalcore_devastatorAI : public ScriptedAI
{
    mob_crystalcore_devastatorAI(Creature *c) : ScriptedAI(c) {}

    uint32 Knockaway_Timer;
    uint32 Countercharge_Timer;

    void Reset()
    {
        Countercharge_Timer = 9000;
        Knockaway_Timer = 25000;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        //Check if we have a current target
        //Knockaway_Timer
        if (Knockaway_Timer < diff)
        {
            m_creature->CastSpell(m_creature->getVictim(), SPELL_KNOCKAWAY, true);

            // current aggro target is knocked away pick new target
            Unit* target = SelectUnit(SELECT_TARGET_TOPAGGRO, 0, 60, true, m_creature->getVictimGUID());

            if (target)
                m_creature->TauntApply(target);

            Knockaway_Timer = 23000;
        }
        else
            Knockaway_Timer -= diff;

        //Countercharge_Timer
        if (Countercharge_Timer < diff)
        {
            DoCast(m_creature, SPELL_COUNTERCHARGE);
            Countercharge_Timer = 45000;
        }
        else
            Countercharge_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_crystalcore_devastator(Creature *_Creature)
{
    return new mob_crystalcore_devastatorAI (_Creature);
}

#define SPELL_RECHARGE          37121
#define SPELL_SAWBLADE          37123

struct mob_crystalcore_mechanicAI : public ScriptedAI
{
    mob_crystalcore_mechanicAI(Creature *c) : ScriptedAI(c) {}

    uint32 Recharge_Timer;
    uint32 Sawblade_Timer;
    uint8 Saw_count;

    void Reset()
    {
        Recharge_Timer = 20000;
        Sawblade_Timer = 4000;
        Saw_count=0;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (Recharge_Timer < diff)
        {
            if(Unit* target = FindCreature(20040, 100, m_creature))
            {
                DoCast(target,SPELL_RECHARGE);
                Recharge_Timer = 30000+rand()%10000;
            }
            else if(Unit* target = FindCreature(20041, 100, m_creature))
            {
                DoCast(target,SPELL_RECHARGE);
                Recharge_Timer = 30000+rand()%10000;
            }
        }
        else
            Recharge_Timer -= diff;

        if(Sawblade_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30, true, 0))
                DoCast(target,SPELL_SAWBLADE);

            Saw_count++;
            if(Saw_count < 3)
                Sawblade_Timer = 2000;
            else
            {
                Saw_count = 0;
                Sawblade_Timer = 6000+rand()%4000;
             }
        }
        else
            Sawblade_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};



CreatureAI* GetAI_mob_crystalcore_mechanic(Creature *_Creature)
{
    return new mob_crystalcore_mechanicAI (_Creature);
}

//Phoenix-Hawk Hatchling

#define SPELL_SILENCE          37160
#define SPELL_WINGBUFFET       37319

struct mob_phoenixhawk_hatchlingAI : public ScriptedAI
{
    mob_phoenixhawk_hatchlingAI(Creature *c) : ScriptedAI(c) {}

    uint32 Silence_Timer;
    uint32 WingBuffet_Timer;

    void Reset()
    {
        Silence_Timer = 2000;
        WingBuffet_Timer = 4000;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(Silence_Timer < diff)
        {
            DoCast(m_creature,SPELL_SILENCE);
            Silence_Timer = 6000+rand()%4000;
        }
        else
            Silence_Timer -= diff;

        if(WingBuffet_Timer < diff)
        {
            DoCast(m_creature,SPELL_WINGBUFFET);
            WingBuffet_Timer = 16000+rand()%14000;
        }
        else
            WingBuffet_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_phoenixhawk_hatchling(Creature *_Creature)
{
    return new mob_phoenixhawk_hatchlingAI (_Creature);
}

//Phoenix-Hawk

#define SPELL_MANABURNE        37159
#define SPELL_DIVE             37156

struct mob_phoenix_hawkAI : public ScriptedAI
{
    mob_phoenix_hawkAI(Creature *c) : ScriptedAI(c) {}

    uint32 ManaBurn_Timer;
    uint32 Dive_Timer;

    void Reset()
    {
        ManaBurn_Timer = 15000;
        Dive_Timer = 4000;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(ManaBurn_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30, true, 0))
                DoCast(target,SPELL_MANABURNE);

            ManaBurn_Timer = 20000+rand()%14000;
        }
        else
            ManaBurn_Timer -= diff;

        if(Dive_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30, true, 0))
                DoCast(target,SPELL_DIVE);

            Dive_Timer = 16000+rand()%4000;
        }
        else
            Dive_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_phoenix_hawk(Creature *_Creature)
{
    return new mob_phoenix_hawkAI (_Creature);
}

//Tempest Falconer

#define SPELL_FIRESHIELD       37318
#define SPELL_IMMOLATIONARROW  37154
#define SPELL_KNOCKBACK        37317
#define SPELL_SHOOT            39079

struct mob_tempest_falconerAI : public ScriptedAI
{
    mob_tempest_falconerAI(Creature *c) : ScriptedAI(c) {}

    uint32 FireShield_Timer;
    uint32 ImmolationArrow_Timer;
    uint32 Knockback_Timer;
    uint32 Shoot_Timer;

    void Reset()
    {
        FireShield_Timer = 2000;
        ImmolationArrow_Timer = 10000+rand()%4000;
        Knockback_Timer = 5000;
        Shoot_Timer = 3000;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(FireShield_Timer < diff)
        {
            DoCast(m_creature,SPELL_FIRESHIELD);
            FireShield_Timer = 60000;
        }
        else
            FireShield_Timer -= diff;

        if(ImmolationArrow_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30, true, 0))
                DoCast(target,SPELL_IMMOLATIONARROW);

            ImmolationArrow_Timer = 10000+rand()%4000;
        }
        else
            ImmolationArrow_Timer -= diff;

        if(Knockback_Timer < diff)
        {
            DoCast(m_creature,SPELL_KNOCKBACK);
            Knockback_Timer = 8000;
        }
        else
            Knockback_Timer -= diff;

        if(Shoot_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_SHOOT);
            Shoot_Timer = 3000+rand()%2000;
        }
        else
            Shoot_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_tempest_falconer(Creature *_Creature)
{
    return new mob_tempest_falconerAI (_Creature);
}

//Crimson Hand Blood Knight

#define SPELL_CLEANSE          39078
#define SPELL_FLASHOFLIGHT     37257
#define SPELL_HAMMEROFJUSTICE  39077
#define SPELL_HAMMEROFWRATH    37259
#define SPELL_RENEW            37260

struct mob_crimson_hand_blood_knightAI : public ScriptedAI
{
    mob_crimson_hand_blood_knightAI(Creature *c) : ScriptedAI(c) {}

    uint32 Cleanse_Timer;
    uint32 FlashofLight_Timer;
    uint32 HammerofJustice_Timer;
    uint32 HammerofWrath_Timer;
    uint32 Renew_Timer;

    void Reset()
    {
        Cleanse_Timer = 20000;
        FlashofLight_Timer = 10000+rand()%4000;
        HammerofJustice_Timer = 3000;
        HammerofWrath_Timer = 5000;
        Renew_Timer = 5000;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (Cleanse_Timer < diff )
        {
            std::list<Creature*> pList = FindFriendlyCC(30);
            if(!pList.empty())
            {
                Unit* target = *(pList.begin());
                DoCast(target,SPELL_CLEANSE);
            }
            Cleanse_Timer = 3000+rand()%1000;
        }
        else
            Cleanse_Timer -= diff;

        if(FlashofLight_Timer < diff)
        {
            Unit* target = SelectLowestHpFriendly(50, 1000);
            if(target)
            {
                DoCast(target,SPELL_FLASHOFLIGHT);
                if(target->GetHealth() <= target->GetMaxHealth()*0.5)
                    FlashofLight_Timer = 0;
                else
                    FlashofLight_Timer = rand()%7000;
            }
            FlashofLight_Timer += 2000;
        }
        else
            FlashofLight_Timer -= diff;

        if(HammerofJustice_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_HAMMEROFJUSTICE);
            HammerofJustice_Timer = 18000;
        }
        else
            HammerofJustice_Timer -= diff;

        if(HammerofWrath_Timer < diff)
        {
            Map* pMap = m_creature->GetMap();
            Map::PlayerList const &PlayerList = pMap->GetPlayers();
            if(!PlayerList.isEmpty())
            {
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                {
                    Player *p = i->getSource();
                    if(p->isAlive() && p->GetHealth() <= p->GetMaxHealth()*0.2)
                    {
                        DoCast(p, SPELL_HAMMEROFWRATH);
                        break;
                    }
                }
            }
            HammerofWrath_Timer = 3000+rand()%2000;
        }
        else
            HammerofWrath_Timer -= diff;

        if(Renew_Timer < diff)
        {
            Unit* target = SelectLowestHpFriendly(50, 1000);
            if(target)
                DoCast(target,SPELL_RENEW);

            Renew_Timer = 10000+rand()%2000;
        }
        else
            Renew_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_crimson_hand_blood_knight(Creature *_Creature)
{
    return new mob_crimson_hand_blood_knightAI (_Creature);
}

//Bloodwarder Squire

#define SPELL_CLEANSE_BW_SQUIRE          39078
#define SPELL_FLASHOFLIGHT_BW_SQUIRE     37254
#define SPELL_HAMMEROFJUSTICE_BW_SQUIRE  39077
#define SPELL_HAMMEROFWRATH_BW_SQUIRE    37255

struct mob_Bloodwarder_SquireAI : public ScriptedAI
{
    mob_Bloodwarder_SquireAI(Creature *c) : ScriptedAI(c) {}

    uint32 Cleanse_Timer;
    uint32 FlashofLight_Timer;
    uint32 HammerofJustice_Timer;
    uint32 HammerofWrath_Timer;

    void Reset()
    {
        Cleanse_Timer = 20000;
        FlashofLight_Timer = 10000+rand()%4000;
        HammerofJustice_Timer = 3000;
        HammerofWrath_Timer = 5000;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (Cleanse_Timer < diff )
        {
            std::list<Creature*> pList = FindFriendlyCC(30);
            if (!pList.empty())
            {
                Unit* target = *(pList.begin());
                DoCast(target,SPELL_CLEANSE_BW_SQUIRE);
            }
            Cleanse_Timer = 3000+rand()%1000;
        }
        else
            Cleanse_Timer -= diff;

        if(FlashofLight_Timer < diff)
        {
            Unit* target = SelectLowestHpFriendly(50, 1000);
            if(target)
            {
                DoCast(target,SPELL_FLASHOFLIGHT_BW_SQUIRE);

                if(target->GetHealth() <= target->GetMaxHealth()*0.5)
                    FlashofLight_Timer = 0;
                else
                    FlashofLight_Timer = rand()%7000;
            }
            FlashofLight_Timer+=2000;
        }
        else
            FlashofLight_Timer -= diff;

        if(HammerofJustice_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_HAMMEROFJUSTICE_BW_SQUIRE);
            HammerofJustice_Timer = 18000;
        }
        else
            HammerofJustice_Timer -= diff;

        if(HammerofWrath_Timer < diff)
        {
            Map* pMap = m_creature->GetMap();
            Map::PlayerList const &PlayerList = pMap->GetPlayers();
            if(!PlayerList.isEmpty())
            {
                for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                {
                    Player *p = i->getSource();
                    if(p->isAlive() && p->GetHealth() <= p->GetMaxHealth()*0.2)
                    {
                        DoCast(p, SPELL_HAMMEROFWRATH_BW_SQUIRE);
                        break;
                    }
                }
            }
            HammerofWrath_Timer = 3000+rand()%2000;
        }
        else
            HammerofWrath_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_Bloodwarder_Squire(Creature *_Creature)
{
    return new mob_Bloodwarder_SquireAI (_Creature);
}

//Bloodwarder Vindicator

#define SPELL_CLEANSE_BW_VINDICATOR          39078
#define SPELL_FLASHOFLIGHT_BW_VINDICATOR     37249
#define SPELL_HAMMEROFJUSTICE_BW_VINDICATOR  13005
#define SPELL_HAMMEROFWRATH_BW_VINDICATOR    37251

struct mob_Bloodwarder_VindicatorAI : public ScriptedAI
{
    mob_Bloodwarder_VindicatorAI(Creature *c) : ScriptedAI(c) {}

    uint32 Cleanse_Timer;
    uint32 FlashofLight_Timer;
    uint32 HammerofJustice_Timer;
    uint32 HammerofWrath_Timer;

    void Reset()
    {
        Cleanse_Timer = 20000;
        FlashofLight_Timer = 10000+rand()%4000;
        HammerofJustice_Timer = 3000;
        HammerofWrath_Timer = 5000;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(Cleanse_Timer < diff )
        {
            std::list<Creature*> pList = FindFriendlyCC(30);
            if (!pList.empty())
            {
                Unit* target = *(pList.begin());
                DoCast(target,SPELL_CLEANSE_BW_VINDICATOR);
            }
            Cleanse_Timer = 3000+rand()%1000;
        }
        else
            Cleanse_Timer -= diff;

        if(FlashofLight_Timer < diff)
        {
            Unit* target = SelectLowestHpFriendly(50, 1000);
            if(target)
            {
                DoCast(target,SPELL_FLASHOFLIGHT_BW_VINDICATOR);

                if(target->GetHealth() <= target->GetMaxHealth()*0.5)
                    FlashofLight_Timer = 2000;
                else
                    FlashofLight_Timer = 2000 +rand()%7000;
            }
        }
        else
            FlashofLight_Timer -= diff;

        if(HammerofJustice_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_HAMMEROFJUSTICE_BW_VINDICATOR);
            HammerofJustice_Timer = 18000;
        }
        else
            HammerofJustice_Timer -= diff;

        if(HammerofWrath_Timer < diff)
        {
            Map* pMap = m_creature->GetMap();
            Map::PlayerList const &PlayerList = pMap->GetPlayers();
            if (!PlayerList.isEmpty())
            {
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                {
                    Player *p = i->getSource();
                    if(p->isAlive() && p->GetHealth() <= p->GetMaxHealth()*0.2)
                    {
                        DoCast(p, SPELL_HAMMEROFWRATH_BW_VINDICATOR);
                        break;
                    }
                }
            }
            HammerofWrath_Timer = 3000+rand()%2000;
        }
        else
            HammerofWrath_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_Bloodwarder_Vindicator(Creature *_Creature)
{
    return new mob_Bloodwarder_VindicatorAI (_Creature);
}

//Tempest-Smith

#define SPELL_FEAGMENTATIONBOMB           37120
#define SPELL_GOLEMREPAIR                 34946
#define SPELL_POWERUP                     37112
#define SPELL_SHELLSHOCK                  37118

struct mob_tempest_smithAI : public ScriptedAI
{
    mob_tempest_smithAI(Creature *c) : ScriptedAI(c) {}

    uint32 Fragmentation_Bomb_Timer;
    uint32 Golem_Repair_Timer;
    uint32 Power_Up_Timer;
    uint32 Shell_Shock_Timer;

    void Reset()
    {
        Fragmentation_Bomb_Timer= 7000;
        Golem_Repair_Timer = 10000+rand()%4000;
        Power_Up_Timer = 20000;
        Shell_Shock_Timer = 11000;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(Fragmentation_Bomb_Timer < diff )
        {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30, true, 0);
            if(target)
                DoCast(target,SPELL_FEAGMENTATIONBOMB);

            Fragmentation_Bomb_Timer = 5000+rand()%3000;
        }
        else
            Fragmentation_Bomb_Timer -= diff;

        if(Golem_Repair_Timer < diff)
        {
            if(Unit* target = FindCreature(20040, 25, m_creature))
            {
                DoCast(target,SPELL_RECHARGE);
                Golem_Repair_Timer = 30000+rand()%10000;
            }
            else if(Unit* target = FindCreature(20041, 25, m_creature))
            {
                DoCast(target,SPELL_RECHARGE);
                Golem_Repair_Timer = 30000+rand()%10000;
            }
        }
        else
            Golem_Repair_Timer -= diff;

        if(Power_Up_Timer < diff)
        {
            if(Unit* target = FindCreature(20040, 25, m_creature))
            {
                DoCast(target,SPELL_POWERUP);
                Power_Up_Timer = 20000+rand()%5000;
            }
            else if(Unit* target = FindCreature(20041, 25, m_creature))
            {
                DoCast(target,SPELL_POWERUP);
                Power_Up_Timer = 20000+rand()%5000;
            }
        }
        else
            Power_Up_Timer -= diff;

        if(Shell_Shock_Timer < diff)
        {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30, true, 0);
            if(target)
                DoCast(target,SPELL_SHELLSHOCK);

            Shell_Shock_Timer = 8000+rand()%8000;
        }
        else
            Shell_Shock_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_tempest_smith(Creature *_Creature)
{
    return new mob_tempest_smithAI (_Creature);
}

//Novice Astromancer

#define SPELL_FIRENOVA                      38728
#define SPELL_FIRESHIELD_NOVICE_ASTROMANCER 37282
#define SPELL_FIREBALL                      37111
#define SPELL_RAINOFFIRE                    37279

struct mob_novice_astromancerAI : public ScriptedAI
{
    mob_novice_astromancerAI(Creature *c) : ScriptedAI(c) {}

    uint32 Fire_Nova_Timer;
    uint32 Fire_Shield_Timer;
    uint32 Fireball_Timer;
    uint32 Rain_of_Fire_Timer;

    void Reset()
    {
        Fire_Nova_Timer= 7000+rand()%2000;
        Fire_Shield_Timer = 1000;
        Fireball_Timer = 2000;
        Rain_of_Fire_Timer = 5000+rand()%2000;
    }

    void EnterCombat(Unit *who)
    {
        m_creature->CombatStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(Fire_Nova_Timer < diff )
        {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30, true, 0);
            if(target)
                DoCast(target,SPELL_FIRENOVA);

            Fire_Nova_Timer = 5000+rand()%3000;
        }
        else
            Fire_Nova_Timer -= diff;

        if(Fire_Shield_Timer < diff)
        {
            DoCast(m_creature,SPELL_FIRESHIELD_NOVICE_ASTROMANCER);
            Fire_Shield_Timer = 60000;
        }
        else
            Fire_Shield_Timer -= diff;

        if(Fireball_Timer < diff)
        {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 50, true, 0);
            if(target)
                DoCast(target,SPELL_FIREBALL);

            Fireball_Timer = 2000+rand()%2000;
        }
        else
            Fireball_Timer -= diff;

        if(Rain_of_Fire_Timer < diff)
        {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30, true, 0);
            if(target)
                DoCast(target,SPELL_RAINOFFIRE);

            Rain_of_Fire_Timer = 8000+rand()%3000;
        }
        else
            Rain_of_Fire_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_novice_astromancer(Creature *_Creature)
{
    return new mob_novice_astromancerAI (_Creature);
}

void AddSC_the_eye()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="mob_crystalcore_devastator";
    newscript->GetAI = &GetAI_mob_crystalcore_devastator;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_crystalcore_mechanic";
    newscript->GetAI = &GetAI_mob_crystalcore_mechanic;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_phoenixhawk_hatchling";
    newscript->GetAI = &GetAI_mob_phoenixhawk_hatchling;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_phoenix_hawk";
    newscript->GetAI = &GetAI_mob_phoenix_hawk;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_tempest_falconer";
    newscript->GetAI = &GetAI_mob_tempest_falconer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_crimson_hand_blood_knight";
    newscript->GetAI = &GetAI_mob_crimson_hand_blood_knight;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_tempest_smith";
    newscript->GetAI = &GetAI_mob_tempest_smith;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_novice_astromancer";
    newscript->GetAI = &GetAI_mob_novice_astromancer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_Bloodwarder_Squire";
    newscript->GetAI = &GetAI_mob_Bloodwarder_Squire;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_Bloodwarder_Vindicator";
    newscript->GetAI = &GetAI_mob_Bloodwarder_Vindicator;
    newscript->RegisterSelf();
}
