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
SDName: Boss_Shade_of_Aran
SD%Complete: 95
SDComment: Flame wreath missing cast animation, mods won't triggere.
SDCategory: Karazhan
EndScriptData */

#include "precompiled.h"
#include "../../creature/simple_ai.h"
#include "def_karazhan.h"
#include "GameObject.h"

#define SAY_AGGRO1                  -1532073
#define SAY_AGGRO2                  -1532074
#define SAY_AGGRO3                  -1532075
#define SAY_FLAMEWREATH1            -1532076
#define SAY_FLAMEWREATH2            -1532077
#define SAY_BLIZZARD1               -1532078
#define SAY_BLIZZARD2               -1532079
#define SAY_EXPLOSION1              -1532080
#define SAY_EXPLOSION2              -1532081
#define SAY_DRINK                   -1532082                //Low Mana / AoE Pyroblast
#define SAY_ELEMENTALS              -1532083
#define SAY_KILL1                   -1532084
#define SAY_KILL2                   -1532085
#define SAY_TIMEOVER                -1532086
#define SAY_DEATH                   -1532087
#define SAY_ATIESH                  -1532088                //Atiesh is equipped by a raid member

//Spells
#define SPELL_FROSTBOLT         29954
#define SPELL_FIREBALL          29953
#define SPELL_ARCMISSLE         29955
#define SPELL_CHAINSOFICE       29991
#define SPELL_DRAGONSBREATH     29964
#define SPELL_MASSSLOW          30035
#define SPELL_FLAME_WREATH      30004
#define SPELL_AOE_CS            29961
#define SPELL_AEXPLOSION        29973
#define SPELL_MASS_POLY         29963
#define SPELL_BLINK_CENTER      29967
#define SPELL_ELEMENTAL1        29962
#define SPELL_ELEMENTAL2        37053
#define SPELL_ELEMENTAL3        37051
#define SPELL_ELEMENTAL4        37052
#define SPELL_CONJURE           29975
#define SPELL_DRINK             30024
#define SPELL_POTION            32453
#define SPELL_AOE_PYROBLAST     29978
#define SPELL_SUMMON_BLIZZARD   29969
#define SPELL_MAGNETIC_PULL     29979
#define SPELL_TELEPORT_MIDDLE   39567           // used also by npc_berthold not sure if valid here

//Creature Spells
#define SPELL_CIRCULAR_BLIZZARD     29952
#define SPELL_WATERBOLT             37054
#define SPELL_SHADOW_PYRO           29978
#define SPELL_FROSTBOLT_VOLLEY      38837
#define SPELL_AMISSILE_VOLLEY       29960

//Creatures
#define CREATURE_WATER_ELEMENTAL         17167
#define CREATURE_SHADOW_OF_ARAN          18254

enum SuperSpell
{
    SUPER_FLAME = 0,
    SUPER_BLIZZARD,
    SUPER_AE,
};

enum DrinkingState
{
    DRINKING_NO_DRINKING,
    DRINKING_PREPARING,
    DRINKING_DONE_DRINKING,
    DRINKING_POTION
};

float ElementalSpawnPoints[2][4] = {
    {-11143.5, -11167.6, -11186.8, -11162.6},   // X coord
    {-1914.26, -1933.8,  -1909.7,  -1895.4}     // Y coord
};

float shadowOfAranSpawnPoints[2][8] = {
    {-11143.5, -11152.1, -11167.6, -11181.3, -11186.8, -11178,  -11162.6, -11148.6},// X coord
    {-1914.26, -1928.2,  -1933.8,  -1925.05, -1909.7,  -1895.7, -1895.4,  -1899}    // Y coord
};

struct boss_aranAI : public ScriptedAI
{
    boss_aranAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);

        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_CASTING_SPEED, true);
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_HASTE_SPELLS, true);
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_SILENCE, true);
    }

    ScriptedInstance* pInstance;

    uint32 SecondarySpellTimer;
    uint32 NormalCastTimer;
    uint32 SuperCastTimer;
    uint32 BerserkTimer;

    uint8 LastSuperSpell;

    uint32 ArcaneCooldown;
    uint32 FireCooldown;
    uint32 FrostCooldown;
    uint32 CheckTimer;
    uint32 PyroblastTimer;

    uint64 shadeOfAranTeleportCreatures[8];
    WorldLocation wLoc;

    uint32 DrinkInturruptTimer;

    bool ElementalsSpawned;
    DrinkingState Drinking;
    uint32 DrinkingDelay;



    void Reset()
    {
        ClearCastQueue();

        SecondarySpellTimer = 5000;
        NormalCastTimer     = 0;
        SuperCastTimer      = 30000;
        BerserkTimer        = 720000;
        CheckTimer          = 3000;
        PyroblastTimer      = 0;
        DrinkingDelay       = 0;


        LastSuperSpell = rand()%3;


        ArcaneCooldown     = 0;
        FireCooldown       = 0;
        FrostCooldown      = 0;

        ElementalsSpawned       = false;
        Drinking                = DRINKING_NO_DRINKING;

        if (pInstance)
            pInstance->SetData(DATA_SHADEOFARAN_EVENT, NOT_STARTED);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_KILL1, SAY_KILL2), m_creature);
    }

    void JustDied(Unit *victim)
    {
        DoScriptText(SAY_DEATH, m_creature);

        if(pInstance)
            pInstance->SetData(DATA_SHADEOFARAN_EVENT, DONE);
        
        Unit *Blizzard = FindCreature(17161, 40, me);
        if (Blizzard)
            Blizzard->ToCreature()->DisappearAndDie();
    }

    bool PlayerHaveAtiesh()
    {
        Map::PlayerList const &PlayerList = ((InstanceMap*)m_creature->GetMap())->GetPlayers();
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
        {
            Player* i_pl = i->getSource();
            if (i_pl->HasEquiped(22632) ||
                i_pl->HasEquiped(22631) ||
                i_pl->HasEquiped(22630) ||
                i_pl->HasEquiped(22589))
                return true;
        }

        return false;
    }

    void EnterCombat(Unit *who)
    {
        if (PlayerHaveAtiesh())
            DoScriptText(SAY_ATIESH, m_creature);
        else
            DoScriptText(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), m_creature);

        if (pInstance)
            pInstance->SetData(DATA_SHADEOFARAN_EVENT, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //Check_Timer
        if (CheckTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 35.0f))
                EnterEvadeMode();
            else
                DoZoneInCombat();

            CheckTimer = 3000;
        }
        else
            CheckTimer -= diff;

        //Cooldowns for casts
        if (ArcaneCooldown)
        {
            if (ArcaneCooldown >= diff)
                ArcaneCooldown -= diff;
            else
                ArcaneCooldown = 0;
        }

        if (FireCooldown)
        {
            if (FireCooldown >= diff)
                FireCooldown -= diff;
            else
                FireCooldown = 0;
        }

        if (FrostCooldown)
        {
            if (FrostCooldown >= diff)
                FrostCooldown -= diff;
            else
                FrostCooldown = 0;
        }

        if (DrinkingDelay)
        {
            if (DrinkingDelay <= diff)
                DrinkingDelay = 0;
            else
                DrinkingDelay -= diff;
        }

        if (!DrinkingDelay && Drinking == DRINKING_NO_DRINKING && (m_creature->GetPower(POWER_MANA)*100 / m_creature->GetMaxPower(POWER_MANA)) < 20)
        {
            ClearCastQueue();
            Drinking = DRINKING_PREPARING;
            AddSpellToCast(SPELL_MASS_POLY, CAST_SELF);
            AddSpellToCastWithScriptText(SPELL_CONJURE, CAST_SELF, SAY_DRINK);
            AddSpellToCast(SPELL_DRINK, CAST_SELF); 
        }

        if (Drinking == DRINKING_DONE_DRINKING)
        {
            AddSpellToCast(SPELL_POTION, CAST_SELF);
            PyroblastTimer = 2000;
            Drinking = DRINKING_POTION;
        }

        if (PyroblastTimer)
        {
            if (PyroblastTimer <= diff)
            {
                AddSpellToCast(SPELL_AOE_PYROBLAST, CAST_SELF);
                Drinking = DRINKING_NO_DRINKING;
                PyroblastTimer = 0;
            }
            else
                PyroblastTimer -= diff;
        }

        if(Drinking == DRINKING_NO_DRINKING)
        {
            //Normal casts
            if (NormalCastTimer < diff)
            {
                if (!m_creature->IsNonMeleeSpellCasted(false))
                {
                    uint32 Spells[3];
                    uint8 AvailableSpells = 0;
                    //Check for what spells are not on cooldown
                    if (!ArcaneCooldown)
                        Spells[AvailableSpells++] = SPELL_ARCMISSLE;

                    if (!FireCooldown)
                        Spells[AvailableSpells++] = SPELL_FIREBALL;

                    if (!FrostCooldown)
                        Spells[AvailableSpells++] = SPELL_FROSTBOLT;

                    //If no available spells wait 1 second and try again
                    if (AvailableSpells)
                        AddSpellToCast(Spells[rand() % AvailableSpells], CAST_RANDOM, false, true);
                }
                NormalCastTimer = 1000;
            }
            else
                NormalCastTimer -= diff;

            if (SecondarySpellTimer < diff)
            {
                AddSpellToCast(SPELL_AOE_CS, CAST_SELF);
                SecondarySpellTimer = urand(10000, 40000);
            }
            else
                SecondarySpellTimer -= diff;

            if (SuperCastTimer < diff)
            {
                uint8 Available[2];
                ClearCastQueue();

                switch (LastSuperSpell)
                {
                    case SUPER_AE:
                        Available[0] = SUPER_FLAME;
                        Available[1] = SUPER_BLIZZARD;
                        break;
                    case SUPER_FLAME:
                        Available[0] = SUPER_BLIZZARD;
                        Available[1] = SUPER_AE;
                        break;
                    case SUPER_BLIZZARD:
                        Available[0] = SUPER_FLAME;
                        Available[1] = SUPER_AE;
                        break;
                }

                LastSuperSpell = Available[rand()%2];

                switch (LastSuperSpell)
                {
                    case SUPER_AE:
                        AddSpellToCast(SPELL_TELEPORT_MIDDLE, CAST_SELF);
                        AddSpellToCast(SPELL_MAGNETIC_PULL, CAST_SELF);  
                        AddSpellToCast(SPELL_MASSSLOW, CAST_SELF);
                        AddSpellToCastWithScriptText(SPELL_AEXPLOSION, CAST_SELF, RAND(SAY_EXPLOSION1, SAY_EXPLOSION2));
                        DrinkingDelay = 15000;
                        break;

                    case SUPER_FLAME:
                        AddSpellToCastWithScriptText(SPELL_FLAME_WREATH, CAST_SELF, RAND(SAY_FLAMEWREATH1, SAY_FLAMEWREATH2));
                        DrinkingDelay = 25000;
                        break;

                    case SUPER_BLIZZARD:
                        AddSpellToCastWithScriptText(SPELL_SUMMON_BLIZZARD, CAST_NULL, RAND(SAY_BLIZZARD1, SAY_BLIZZARD2));
                        DrinkingDelay = 30000;
                        break;
                }

                SuperCastTimer = urand(35000, 40000);
            }
            else
                SuperCastTimer -= diff;

            if (!ElementalsSpawned && ((m_creature->GetHealth()*100)/ m_creature->GetMaxHealth()) <= 40)
            {
                ElementalsSpawned = true;
                AddSpellToCastWithScriptText(SPELL_ELEMENTAL1, CAST_SELF, SAY_ELEMENTALS);
                AddSpellToCast(SPELL_ELEMENTAL2, CAST_SELF);
                AddSpellToCast(SPELL_ELEMENTAL3, CAST_SELF);
                AddSpellToCast(SPELL_ELEMENTAL4, CAST_SELF);
            }
        }

        if (BerserkTimer < diff)
        {
            for (uint32 i = 0; i < 8; i++)
            {
                Creature* pUnit = m_creature->SummonCreature(CREATURE_SHADOW_OF_ARAN, shadowOfAranSpawnPoints[0][i], shadowOfAranSpawnPoints[1][i], m_creature->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                if (pUnit)
                {
                    pUnit->Attack(m_creature->getVictim(), true);
                    pUnit->setFaction(m_creature->getFaction());
                }
            }
            DoScriptText(SAY_TIMEOVER, m_creature);

            BerserkTimer = 60000;
        }
        else
            BerserkTimer -= diff;

        CastNextSpellIfAnyAndReady();
        if(Drinking == DRINKING_NO_DRINKING)
            DoMeleeAttackIfReady();
    }


    void SpellHitTarget(Unit *target, const SpellEntry *spell)
    {
        if (spell->Id == SPELL_MAGNETIC_PULL)
        {
            target->RemoveAurasDueToSpell(29947);
            target->CastSpell(target, SPELL_BLINK_CENTER, true);
        } 
        else if(spell->Id == SPELL_FROSTBOLT && roll_chance_i(33))
        {
            me->CastSpell(target, SPELL_CHAINSOFICE, true);
        }
    }

    void JustSummoned(Creature *c)
    {
        if (c->GetEntry() == 17167)
        {
            c->AI()->AttackStart(m_creature->getVictim());
            c->setFaction(m_creature->getFaction());
        }
    }

    void OnAuraRemove(Aura *aura, bool)
    {
        if(aura->GetId() == SPELL_DRINK)
        {
            m_creature->SetUInt32Value(UNIT_FIELD_BYTES_1, 0); // stand up
            Drinking = DRINKING_DONE_DRINKING;
        }
    }

    void OnAuraApply(Aura *aura, Unit *caster, bool)
    {
        if(aura->GetId() == SPELL_DRINK)
        {
            m_creature->GetMotionMaster()->MoveIdle();
            m_creature->SetUInt32Value(UNIT_FIELD_BYTES_1, 1); // sit down
        }

    }

    void SpellHit(Unit* pAttacker, const SpellEntry* spellEntry)
    {
        //We only care about inturrupt effects and only if they are durring a spell currently being casted
        if ((spellEntry->Effect[0] != SPELL_EFFECT_INTERRUPT_CAST &&
            spellEntry->Effect[1] != SPELL_EFFECT_INTERRUPT_CAST &&
            spellEntry->Effect[2] != SPELL_EFFECT_INTERRUPT_CAST) || !m_creature->IsNonMeleeSpellCasted(false))
            return;

        //Normally we would set the cooldown equal to the spell duration
        //but we do not have access to the DurationStore
        switch (me->GetCurrentSpellId())
        {
            case SPELL_ARCMISSLE:
                ArcaneCooldown = 5000;
                m_creature->InterruptNonMeleeSpells(false);
                break;
            case SPELL_FIREBALL:
                FireCooldown = 5000;
                m_creature->InterruptNonMeleeSpells(false);
                break;
            case SPELL_FROSTBOLT:
                FrostCooldown = 5000;
                m_creature->InterruptNonMeleeSpells(false);
                break;
            default:
                break;
        }
    }
};

struct water_elementalAI : public ScriptedAI
{
    water_elementalAI(Creature *c) : ScriptedAI(c) {}

    uint32 CastTimer;

    void Reset()
    {
        ClearCastQueue();

        CastTimer = urand(2000, 5000);
    }

    void AttackStart(Unit *who)
    {
        ScriptedAI::AttackStartNoMove(who, CHECK_TYPE_CASTER);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CastTimer < diff)
        {
            //AddSpellToCast(m_creature->getVictim(), SPELL_WATERBOLT);
            DoCast(m_creature->getVictim(), SPELL_WATERBOLT);
            CastTimer = 2000 + (rand()%3000);
        }
        else
            CastTimer -= diff;

        CheckCasterNoMovementInRange(diff, 45.0);
        CastNextSpellIfAnyAndReady();
    }
};

struct shadow_of_aranAI : public ScriptedAI
{
    shadow_of_aranAI(Creature *c) : ScriptedAI(c) {}

    uint32 CastTimer;

    void Reset()
    {
        CastTimer = 2000;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CastTimer < diff)
        {
            if (rand()%3)
            {
                m_creature->CastSpell(m_creature, SPELL_FROSTBOLT_VOLLEY, false);
                CastTimer = 5000;
            }
            else
            {
                m_creature->CastSpell(m_creature, SPELL_AMISSILE_VOLLEY, false);
                CastTimer = 20000;
            }
        }
        else
            CastTimer -= diff;
    }
};

struct circular_blizzardAI : public ScriptedAI
{
    circular_blizzardAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    uint16 currentWaypoint;
    uint16 waypointTimer;
    WorldLocation wLoc;
    ScriptedInstance *pInstance;
    float blizzardWaypoints[2][8];
    bool move;

    void Reset()
    {
        move = false;
        currentWaypoint = 0;
        waypointTimer = 0;
        SetBlizzardWaypoints();
    }

    void ChangeBlizzardWaypointsOrder(uint16 change)
    {
        float temp[2] = {0, 0};
        for (int16 i = 0; i < change; i++)
        {
            temp[0] = blizzardWaypoints[0][0];
            temp[1] = blizzardWaypoints[1][0];
            for (int16 j = 0; j < 7; j++)
            {
                blizzardWaypoints[0][j] = blizzardWaypoints[0][j + 1];
                blizzardWaypoints[1][j] = blizzardWaypoints[1][j + 1];
            }
            blizzardWaypoints[0][7] = temp[0];
            blizzardWaypoints[1][7] = temp[1];
        }
    }


    void SetBlizzardWaypoints()
    {
        blizzardWaypoints[0][0] = -11154.3;    blizzardWaypoints[1][0] = -1903.3;
        blizzardWaypoints[0][1] = -11163.6;    blizzardWaypoints[1][1] = -1898.7;
        blizzardWaypoints[0][2] = -11173.6;    blizzardWaypoints[1][2] = -1901.2;
        blizzardWaypoints[0][3] = -11178.1;    blizzardWaypoints[1][3] = -1910.4;
        blizzardWaypoints[0][4] = -11175.4;    blizzardWaypoints[1][4] = -1920.6;
        blizzardWaypoints[0][5] = -11166.6;    blizzardWaypoints[1][5] = -1925.1;
        blizzardWaypoints[0][6] = -11156.5;    blizzardWaypoints[1][6] = -1922.8;
        blizzardWaypoints[0][7] = -11151.8;    blizzardWaypoints[1][7] = -1913.5;
    }

    void JustDied(Unit* killer){}

    void SpellHit(Unit * caster, const SpellEntry * spell)
    {
        if (spell->Id == SPELL_SUMMON_BLIZZARD)
        {
            uint64 AranGUID = 0;
            if(pInstance)
                AranGUID = pInstance->GetData64(DATA_ARAN);
            me->CastSpell(me, SPELL_CIRCULAR_BLIZZARD, false, 0, 0, AranGUID);

            ChangeBlizzardWaypointsOrder(urand(0, 7));

            wLoc.coord_x = blizzardWaypoints[0][0];
            wLoc.coord_y = blizzardWaypoints[1][0];
            wLoc.coord_z = me->GetPositionZ();

            DoTeleportTo(wLoc.coord_x, wLoc.coord_y, wLoc.coord_z);

            currentWaypoint = 0;
            waypointTimer = 0;
            move = true;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!move)
            return;

        if (waypointTimer < diff)
        {
            if (currentWaypoint < 7)
                ++currentWaypoint;
            else
            {
                currentWaypoint = 0;
                move = false;
            }

            wLoc.coord_x = blizzardWaypoints[0][currentWaypoint];
            wLoc.coord_y = blizzardWaypoints[1][currentWaypoint];

            m_creature->GetMotionMaster()->MovePoint(currentWaypoint, wLoc.coord_x, wLoc.coord_y, wLoc.coord_z);
            waypointTimer = 3000;
        }
        else
            waypointTimer -= diff;
    }
};

CreatureAI* GetAI_boss_aran(Creature *_Creature)
{
    return new boss_aranAI (_Creature);
}

CreatureAI* GetAI_water_elemental(Creature *_Creature)
{
    return new water_elementalAI (_Creature);
}

CreatureAI* GetAI_shadow_of_aran(Creature *_Creature)
{
    shadow_of_aranAI* shadowAI = new shadow_of_aranAI(_Creature);

    return (CreatureAI*)shadowAI;
}

CreatureAI* GetAI_circular_blizzard(Creature *_Creature)
{
    circular_blizzardAI* blizzardAI = new circular_blizzardAI(_Creature);

    return (CreatureAI*)blizzardAI;
}

bool FlameWreathHandleEffect(Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex)
{
    if(!pCaster || !pUnit)
        return true;

    pCaster->CastSpell(pUnit, 29946, true);
    return true;
}

void AddSC_boss_shade_of_aran()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_shade_of_aran";
    newscript->GetAI = &GetAI_boss_aran;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_shadow_of_aran";
    newscript->GetAI = &GetAI_shadow_of_aran;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_aran_elemental";
    newscript->GetAI = &GetAI_water_elemental;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_aran_blizzard";
    newscript->GetAI = &GetAI_circular_blizzard;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="spell_flame_wreath";
    newscript->pSpellHandleEffect = &FlameWreathHandleEffect;
    newscript->RegisterSelf();
}

