/* 
 * Copyright (C) 2006-2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2008-2014 Hellground <http://hellground.net/>
 * 
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
SDName: Stair_of_Destiny
SD%Complete: 95%
SDComment: Check timers, factions reaction, ranged defenders
SDCategory: Hellfire Peninsula
EndScriptData */

#include "precompiled.h"

enum DarkPortalCreatures {

    CREATURE_WRATH_MASTER             = 19005,
    CREATURE_FEL_SOLDIER              = 18944,
    CREATURE_INFERNAL_SIEGEBREAKER    = 18946,
    CREATURE_INFERNAL_RELAY           = 19215,
    CREATURE_INFERNAL_TARGET          = 21075,

    CREATURE_CASTER_RIGHT             = 30001,
    CREATURE_CASTER_LEFT              = 30002,
    CREATURE_TARGET_RIGHT             = 30003,
    CREATURE_TARGET_LEFT              = 30004,
    FINAL_POS_TRIGGER                 = 30005
};

/*######
## npc_pit_commander
######*/

#define SPELL_CLEAVE              16044
#define SPELL_RAIN_OF_FIRE        33627
#define SPELL_SUMMON_INFERNALS    33393
#define SPELL_INFERNALS_RAIN      32785

const float FirstFormation[5][4] =
{
    {-218.895f, 1502.76f, 20.7800f, 4.2106f},  // Left 1 - Fel Soldier
    {-209.949f, 1508.24f, 21.9920f, 4.4965f},  // Left 2 - Fel Soldier
    {-236.579f, 1506.04f, 21.4575f, 4.6764f},  // Right 1 - Fel Soldier
    {-241.711f, 1514.15f, 22.6739f, 4.4965f},  // Right 2 - Fel Soldier
    {-229.307f, 1497.77f, 20.1869f, 4.4832f}   // Center - Wrath Master
};

const float SecondFormation[8][4] =
{ 
    {-213.005f, 1496.72f, 20.9439f, 4.4745f},  // 1 1 - Fel Soldier
    {-223.101f, 1499.17f, 20.3675f, 4.4745f},  // 1 2 - Fel Soldier
    {-234.240f, 1501.86f, 20.8176f, 4.4745f},  // 1 3 - Fel Soldier
    {-243.119f, 1503.89f, 21.7681f, 4.4745f},  // 1 4 - Fel Soldier
    {-241.454f, 1514.69f, 22.7010f, 4.4745f},  // 2 1 - Fel Soldier
    {-231.970f, 1512.72f, 22.0880f, 4.4745f},  // 2 2 - Fel Soldier
    {-220.767f, 1509.81f, 21.4782f, 4.4745f},  // 2 3 - Fel Soldier
    {-210.363f, 1507.31f, 21.8889f, 4.4745f}   // 2 4 - Fel Soldier
};

// Waypoints
const uint32 FirstPathList[5]  = {98250, 98251, 98252, 98253, 98254};
const uint32 SecondPathList[8] = {98255, 98256, 98257, 98258, 98259, 98260, 98261, 98262};

struct npc_pit_commanderAI : public ScriptedAI
{
    npc_pit_commanderAI(Creature* creature) : ScriptedAI(creature) {}

    uint32 InfernalTimer;
    uint32 InvadersTimer;
    uint32 CleaveTimer;
    uint32 RainOfFireTimer;

    void Reset()
    {
        InfernalTimer       = 0;
        InvadersTimer       = 0;
        CleaveTimer         = 5000;
        RainOfFireTimer     = 15000;
        me->setActive(true);
    }

    void InfernalEvent()
    {
        // TO-DO: Move this thing to Spell::SendScriptEvent case 33393:
        if (Unit* CasterRight = GetClosestCreatureWithEntry(me, CREATURE_CASTER_RIGHT, 150.0f))
            if (Unit* TargetRight = GetClosestCreatureWithEntry(me, CREATURE_TARGET_RIGHT, 150.0f))
                CasterRight->CastSpell(TargetRight, SPELL_INFERNALS_RAIN, true);

        if (Unit* CasterLeft = GetClosestCreatureWithEntry(me, CREATURE_CASTER_LEFT, 150.0f))
            if (Unit* TargetLeft = GetClosestCreatureWithEntry(me, CREATURE_TARGET_LEFT, 150.0f))
                CasterLeft->CastSpell(TargetLeft, SPELL_INFERNALS_RAIN, true);
    }

    void SummonInvaders()
    {
        switch (urand(0,1))
        {
            // First Formation
            case 0:
            {
                for (int i = 0; i < 4; i++)
                {
                    if (Unit *Solider = me->SummonCreature(CREATURE_FEL_SOLDIER, FirstFormation[i][0], FirstFormation[i][1], FirstFormation[i][2], FirstFormation[i][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000))
                    {
                        Solider->setActive(true);
                        Solider->addUnitState(UNIT_STAT_IGNORE_PATHFINDING);
                        Solider->GetMotionMaster()->MovePath(FirstPathList[i], false);
                    }
                }

                if (Unit *WrathMaster = me->SummonCreature(CREATURE_WRATH_MASTER, FirstFormation[4][0], FirstFormation[4][1], FirstFormation[4][2], FirstFormation[4][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000))
                {
                    WrathMaster->setActive(true);
                    WrathMaster->addUnitState(UNIT_STAT_IGNORE_PATHFINDING);
                    WrathMaster->GetMotionMaster()->MovePath(FirstPathList[4], false);
                }
            } break;
            // Second Formation
            case 1:
            { 
                for (int i = 0; i < 8; i++)
                {
                    if (Unit *Solider = me->SummonCreature(CREATURE_FEL_SOLDIER, SecondFormation[i][0], SecondFormation[i][1], SecondFormation[i][2], SecondFormation[i][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000))
                    {
                        Solider->setActive(true);
                        Solider->addUnitState(UNIT_STAT_IGNORE_PATHFINDING);
                        Solider->GetMotionMaster()->MovePath(SecondPathList[i], false);
                    }
                }
            } break;
        } 
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_UNIT)
            return;
    }

    void UpdateAI(const uint32 diff)
    {
        if (InfernalTimer <= diff)
        {
            DoCast(me, SPELL_SUMMON_INFERNALS);
            InfernalEvent();
            InfernalTimer = 40000;
        }
        else InfernalTimer -= diff;
        
        if (InvadersTimer <= diff)
        {
            SummonInvaders();
            InvadersTimer = 60000;
        }
        else InvadersTimer -= diff;

        if (!UpdateVictim())
            return;

        if (CleaveTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_CLEAVE);
            CleaveTimer = 20000;
        }
        else CleaveTimer -= diff;

        if (RainOfFireTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_RAIN_OF_FIRE);
            RainOfFireTimer = 30000;
        }
        else RainOfFireTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_pit_commander(Creature* creature)
{
    return new npc_pit_commanderAI(creature);
}

/*######
## npc_melgromm_highmountain
######*/

#define SPELL_CHAIN_HEAL              33642
#define SPELL_CHAIN_LIGHTNING         33643
#define SPELL_MAGMA_FLOW_TOTEM        33560
#define SPELL_STORM_TOTEM             33570
#define SPELL_EARTH_SHOCK             22885
#define SPELL_REVIVE_SELF             32343

struct npc_melgromm_highmountainAI : public ScriptedAI
{
    npc_melgromm_highmountainAI(Creature* creature) : ScriptedAI(creature) {}

    uint32 StormTotemTimer;
    uint32 ChainHealTimer;
    uint32 ChainLightTimer;
    uint32 MagmaFlowTimer;
    uint32 EarthShockTimer;

    void Reset()
    {
        StormTotemTimer     = 15000;
        ChainHealTimer      = 12000;
        ChainLightTimer     = 10000;
        MagmaFlowTimer      = 5000;
        EarthShockTimer     = 8000;

        me->setActive(true);
        me->SetAggroRange(45.0f);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }

    void JustDied(Unit* Killer)
    {
        // WoWhead: Respawns instantly if killed, so does Justinius. 
        me->Respawn();
    } 

    void UpdateAI(const uint32 diff)
    { 
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(45.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (StormTotemTimer <= diff)
        {
            if (!me->isInCombat())
            {
                Unit * Totem = GetClosestCreatureWithEntry(me, 19225, 20.0f);

                if (!Totem)
                    DoCast(me, SPELL_STORM_TOTEM);
            }
            StormTotemTimer = 15000;
        }
        else StormTotemTimer -= diff;

        if (!UpdateVictim())
            return;

        if (ChainHealTimer <= diff)
        {
            DoCast(me, SPELL_CHAIN_HEAL);
            ChainHealTimer = 12000;
        }
        else ChainHealTimer -= diff;

        if (ChainLightTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_CHAIN_LIGHTNING);
            ChainLightTimer = 10000;
        }
        else ChainLightTimer -= diff;

        if (MagmaFlowTimer <= diff)
        {
            DoCast(me, SPELL_MAGMA_FLOW_TOTEM);
            MagmaFlowTimer = 5000;
        }
        else MagmaFlowTimer -= diff;

        if (EarthShockTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_EARTH_SHOCK);
            EarthShockTimer = 8000;
        }
        else EarthShockTimer -= diff;

        DoMeleeAttackIfReady(); 
    }
};

CreatureAI* GetAI_npc_melgromm_highmountain(Creature* creature)
{
    return new npc_melgromm_highmountainAI(creature);
}

/*######
## npc_justinus_the_harbinger
######*/

#define SPELL_DIVINE_SHIELD              33581
#define SPELL_JUDGEMENT                  33554
#define SPELL_BLESSING_MIGHT             33564
#define SPELL_CONSECRATION               33559
#define SPELL_FLASH_OF_LIGHT             33641

#define AGGRO_YELL                       "Behold the power of the Light! Grace and glory to the Alliance!"

struct npc_justinus_the_harbingerAI : public ScriptedAI
{
    npc_justinus_the_harbingerAI(Creature* creature) : ScriptedAI(creature) {}

    uint32 DivineShieldTimer;
    uint32 JudgementTimer;
    uint32 BlessingMightTimer;
    uint32 ConsecrationTimer;
    uint32 FlashofLightTimer;

    void Reset()
    {
        DivineShieldTimer     = 20000;
        JudgementTimer        = 5000;
        BlessingMightTimer    = 30000;
        ConsecrationTimer     = 8000;
        FlashofLightTimer     = 12000;

        me->setActive(true);
        me->SetAggroRange(45.0f);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;

        if (who->GetEntry() == CREATURE_INFERNAL_SIEGEBREAKER)
            DoYell(AGGRO_YELL, 0, 0);
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }

    void JustDied(Unit* Killer)
    {
        // WoWhead: Respawns instantly if killed, so does Mulgromm. 
        me->Respawn();
    } 

    void UpdateAI(const uint32 diff)
    { 
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(45.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (BlessingMightTimer <= diff)
        {
            DoCast(me, SPELL_BLESSING_MIGHT);
            BlessingMightTimer = 30000;
        }
        else BlessingMightTimer -= diff;

        if (!UpdateVictim())
            return;

        if (DivineShieldTimer <= diff)
        {
            DoCast(me, SPELL_DIVINE_SHIELD);
            DivineShieldTimer = 20000;
        }
        else DivineShieldTimer -= diff;

        if (JudgementTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_JUDGEMENT);
            JudgementTimer = 5000;
        }
        else JudgementTimer -= diff;

        if (ConsecrationTimer <= diff)
        {
            DoCast(me, SPELL_CONSECRATION);
            ConsecrationTimer = 8000;
        }
        else ConsecrationTimer -= diff;

        if (FlashofLightTimer <= diff)
        {
            DoCast(me, SPELL_FLASH_OF_LIGHT);
            FlashofLightTimer = 12000;
        }
        else FlashofLightTimer -= diff;

        DoMeleeAttackIfReady(); 
    }
};

CreatureAI* GetAI_npc_justinus_the_harbinger(Creature* creature)
{
    return new npc_justinus_the_harbingerAI(creature);
}

/*######
## npc_stormwind_mage
######*/

#define SPELL_FIREBALL  33417
#define SPELL_ARCANE_E  33623
#define SPELL_BLIZZARD  33624

struct npc_stormwind_mageAI : public ScriptedAI
{
    npc_stormwind_mageAI(Creature* creature) : ScriptedAI(creature) {}

    uint32 ReadyToCast;

    void Reset()
    {
        ReadyToCast = 3000;

        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(45.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (!UpdateVictim())
            return;

        if (ReadyToCast <= diff)
        {
            switch (urand(0,1))
            {
                case 0:
                    DoCast(me->getVictim(), SPELL_FIREBALL);
                    break;
                case 1:
                    DoCast(me->getVictim(), SPELL_BLIZZARD);
                    break;
            }
            ReadyToCast = 3000;
        }
        else ReadyToCast -= diff;

        DoMeleeAttackIfReady(); 
    }
};

CreatureAI* GetAI_npc_stormwind_mage(Creature* creature)
{
    return new npc_stormwind_mageAI(creature);
}

/*######
## npc_undercity_mage
######*/

#define SPELL_ICEBOLT   33463
#define SPELL_ARCANE_E  33623
#define SPELL_BLIZZARD  33624

struct npc_undercity_mageAI : public ScriptedAI
{
    npc_undercity_mageAI(Creature* creature) : ScriptedAI(creature) {}

    uint32 ReadyToCast;

    void Reset()
    {
        ReadyToCast = 3000;

        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(45.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (!UpdateVictim())
            return;

        if (ReadyToCast <= diff)
        {
            switch (urand(0,1))
            {
                case 0:
                    DoCast(me->getVictim(), SPELL_ICEBOLT);
                    break;
                case 1:
                    DoCast(me->getVictim(), SPELL_BLIZZARD);
                    break;
            }
            ReadyToCast = 3000;
        }
        else ReadyToCast -= diff;

        DoMeleeAttackIfReady(); 
    }
};

CreatureAI* GetAI_npc_undercity_mage(Creature* creature)
{
    return new npc_undercity_mageAI(creature);
}

/*########
# npc_dark_portal_invader
#########*/

#define SPELL_CLEAVE         15496
#define SPELL_CUTDOWN        32009

const float runPosition[2][3] =
{ 
    {-240.848f, 1094.25f, 41.7500f},
    {-261.527f, 1093.32f, 41.7500f}
};

struct npc_dark_portal_invaderAI : public ScriptedAI
{
    npc_dark_portal_invaderAI(Creature* c) : ScriptedAI(c) {}

    uint32 CleaveTimer;
    uint32 CutDownTimer;
    uint32 ReadyToInvadeTimer;

    bool atFinalPosition;

    void Reset() 
    {  
        CleaveTimer        = urand(3000, 5000);
        CutDownTimer       = urand(6000, 8000);
        ReadyToInvadeTimer = 15000;

        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
        atFinalPosition = false;
    }

    void EnterEvadeMode()
    {
        if (atFinalPosition)
            return;

        ScriptedAI::EnterEvadeMode();
    }

    void UpdateAI(const uint32 diff)
    {
        // at Final position
        if (GetClosestCreatureWithEntry(me, FINAL_POS_TRIGGER, 0.01f) && !atFinalPosition)         
            atFinalPosition = true;

        if (ReadyToInvadeTimer <= diff)
        {
            if (atFinalPosition)
            {
                me->clearUnitState(UNIT_STAT_IGNORE_PATHFINDING);

                switch (urand(0,1))
                {
                    case 0:
                        me->GetMotionMaster()->MovePoint(0, runPosition[0][0], runPosition[0][1], runPosition[0][2]);
                        break;
                    case 1:
                        me->GetMotionMaster()->MovePoint(0, runPosition[1][0], runPosition[1][1], runPosition[1][2]);
                        break;
                }
            }
            ReadyToInvadeTimer = 15000;
        }
        else ReadyToInvadeTimer -= diff;  

        if (!UpdateVictim())
            return;

        if (me->GetEntry() == CREATURE_FEL_SOLDIER)
        {
            if (CleaveTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_CLEAVE);
                CleaveTimer = urand(3000, 5000);
            }
            else CleaveTimer -= diff;

            if (CutDownTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_CUTDOWN);
                CutDownTimer = urand(6000, 8000);
            }
            else CutDownTimer -= diff;
        }

        DoMeleeAttackIfReady();
    }       
};

CreatureAI* GetAI_npc_dark_portal_invader(Creature* creature)
{
    return new npc_dark_portal_invaderAI(creature);
}

/*########
# npc_stormwind_soldier
#########*/

#define SPELL_STRIKE         33626

struct npc_stormwind_soldierAI : public ScriptedAI
{
    npc_stormwind_soldierAI(Creature* c) : ScriptedAI(c) {}

    uint32 StrikeTimer;

    void Reset() 
    {  
        StrikeTimer = urand(3000, 5000);
        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(30.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (!UpdateVictim())
            return;

        if (StrikeTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_STRIKE);
            StrikeTimer = urand(5000, 8000);
        }
        else StrikeTimer -= diff;

        DoMeleeAttackIfReady();
    }       
};

CreatureAI* GetAI_npc_stormwind_soldier(Creature* creature)
{
    return new npc_stormwind_soldierAI(creature);
}

/*########
# npc_orgrimmar_grunt
#########*/

#define SPELL_STRIKE         33626

struct npc_orgrimmar_gruntAI : public ScriptedAI
{
    npc_orgrimmar_gruntAI(Creature* c) : ScriptedAI(c) {}

    uint32 StrikeTimer;

    void Reset() 
    {  
        StrikeTimer = urand(3000, 5000);
        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(39.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (!UpdateVictim())
            return;

        if (StrikeTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_STRIKE);
            StrikeTimer = urand(5000, 8000);
        }
        else StrikeTimer -= diff;

        DoMeleeAttackIfReady();
    }       
};

CreatureAI* GetAI_npc_orgrimmar_grunt(Creature* creature)
{
    return new npc_orgrimmar_gruntAI(creature);
}

/*########
# npc_ironforge_paladin
#########*/

#define SPELL_EXORCISM             33632
#define SPELL_HAMMER_OF_JUSTICE    13005
#define SPELL_SEAL_OF_SACRIFICE    13903

struct npc_ironforge_paladinAI : public ScriptedAI
{
    npc_ironforge_paladinAI(Creature* c) : ScriptedAI(c) {}

    uint32 ExorcismTimer;
    uint32 JusticeTimer;
    uint32 SacrificeTimer;

    void Reset() 
    {  
        ExorcismTimer  = urand(2000, 3000);
        JusticeTimer   = urand(7000, 9000);
        SacrificeTimer = urand(10000, 12000);
        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
    }
    
    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(30.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (!UpdateVictim())
            return;

        if (ExorcismTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_EXORCISM);
            ExorcismTimer = urand(2000, 3000);
        }
        else ExorcismTimer -= diff;

        if (JusticeTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_HAMMER_OF_JUSTICE);
            JusticeTimer = urand(7000, 9000);
        }
        else JusticeTimer -= diff;

        if (SacrificeTimer <= diff)
        {
            DoCast(me, SPELL_SEAL_OF_SACRIFICE);
            SacrificeTimer = urand(10000, 12000);
        }
        else SacrificeTimer -= diff;

        DoMeleeAttackIfReady();
    }       
};

CreatureAI* GetAI_npc_ironforge_paladin(Creature* creature)
{
    return new npc_ironforge_paladinAI(creature);
}

/*########
# npc_darnassian_archer
#########*/

#define SPELL_SHOT    15547  // Sure not correct?

struct npc_darnassian_archerAI : public ScriptedAI
{
    npc_darnassian_archerAI(Creature* c) : ScriptedAI(c) {}

    uint32 ShootTimer;

    void Reset() 
    {  
        ShootTimer = 1500;
        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }


    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(30.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (!UpdateVictim())
            return;

        DoStartNoMovement(me->getVictim());

        if (ShootTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_SHOT);
            ShootTimer = 1500;
        }
        else ShootTimer -= diff;

        DoMeleeAttackIfReady();
    }       
};

CreatureAI* GetAI_npc_darnassian_archer(Creature* creature)
{
    return new npc_darnassian_archerAI(creature);
}

/*########
# npc_darkspear_axe_thrower
#########*/

#define SPELL_THROW    29582 // Sure not correct?

struct npc_darkspear_axe_throwerAI : public ScriptedAI
{
    npc_darkspear_axe_throwerAI(Creature* c) : ScriptedAI(c) {}

    uint32 ThrowTimer;

    void Reset() 
    {  
        ThrowTimer = urand(2000, 3000);
        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(30.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (!UpdateVictim())
            return;

        DoStartNoMovement(me->getVictim());

        if (ThrowTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_THROW);
            ThrowTimer = 1500;
        }
        else ThrowTimer -= diff;

        DoMeleeAttackIfReady();
    }       
};

CreatureAI* GetAI_npc_darkspear_axe_thrower(Creature* creature)
{ 
    return new npc_darkspear_axe_throwerAI(creature);
}

/*########
# npc_orgrimmar_shaman
#########*/

#define SPELL_FLAME_SHOCK    15616

struct npc_orgrimmar_shamanAI : public ScriptedAI
{
    npc_orgrimmar_shamanAI(Creature* c) : ScriptedAI(c) {}

    uint32 ShockTimer;

    void Reset() 
    {  
        ShockTimer = urand(2000, 3000);
        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void EnterCombat(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
            return;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER)
            damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!me->isInCombat())
        {
            if (Unit* AliveInvader = me->SelectNearestTarget(15.0f))
                me->AI()->AttackStart(AliveInvader);
        }

        if (!UpdateVictim())
            return;

        if (ShockTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_FLAME_SHOCK);
            ShockTimer = urand(5000, 8000);
        }
        else ShockTimer -= diff;

        DoMeleeAttackIfReady();
    }       
};

CreatureAI* GetAI_npc_orgrimmar_shaman(Creature* creature)
{ 
    return new npc_orgrimmar_shamanAI(creature);
}

/*########
# npc_infernal_siegebreaker
#########*/

#define SPELL_INFERNAL  33637

struct npc_infernal_siegebreakerAI : public ScriptedAI
{
    npc_infernal_siegebreakerAI(Creature* c) : ScriptedAI(c) {}
    
    bool StunedEnemy;

    void Reset() 
    {  
        me->setActive(true);
        me->SetReactState(REACT_AGGRESSIVE);
        StunedEnemy = false;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!StunedEnemy)
        {
            // WoWhead: If you're hit by the large AoE blast that comes as they hit the ground, you take roughly 3500 damage.
            int32 basepoints0 = urand(3400,3600);
            me->CastCustomSpell(me, 33637, &basepoints0, NULL, NULL, true);
            StunedEnemy = true;
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }       
};

CreatureAI* GetAI_npc_infernal_siegebreaker(Creature* creature)
{ 
    return new npc_infernal_siegebreakerAI(creature);
}

void AddSC_stair_of_destiny()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_pit_commander";
    newscript->GetAI = &GetAI_npc_pit_commander;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "npc_melgromm_highmountain";
    newscript->GetAI = &GetAI_npc_melgromm_highmountain;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_justinus_the_harbinger";
    newscript->GetAI = &GetAI_npc_justinus_the_harbinger;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_stormwind_mage";
    newscript->GetAI = &GetAI_npc_stormwind_mage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_undercity_mage";
    newscript->GetAI = &GetAI_npc_undercity_mage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_dark_portal_invader";
    newscript->GetAI = &GetAI_npc_dark_portal_invader;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_stormwind_soldier";
    newscript->GetAI = &GetAI_npc_stormwind_soldier;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_orgrimmar_grunt";
    newscript->GetAI = &GetAI_npc_orgrimmar_grunt;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_ironforge_paladin";
    newscript->GetAI = &GetAI_npc_ironforge_paladin;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_darnassian_archer";
    newscript->GetAI = &GetAI_npc_darnassian_archer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_darkspear_axe_thrower";
    newscript->GetAI = &GetAI_npc_darkspear_axe_thrower;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_orgrimmar_shaman";
    newscript->GetAI = &GetAI_npc_orgrimmar_shaman;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_infernal_siegebreaker";
    newscript->GetAI = &GetAI_npc_infernal_siegebreaker;
    newscript->RegisterSelf();
}
