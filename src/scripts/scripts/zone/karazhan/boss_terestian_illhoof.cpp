/* * Copyright (C) 2010-2012 Project SkyFire <http://www.projectskyfire.org/>
* Copyright (C) 2010-2012 Oregon <http://www.oregoncore.com/>
* Copyright (C) 2006-2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
* Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 2 of the License, or (at your
* option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see <http://www.gnu.org/licenses/>.
*/

/* ScriptData
SDName: Boss_Terestian_Illhoof
SD%Complete: 100
SDComment:
SDCategory: Karazhan
EndScriptData */

#include "precompiled.h"
#include "def_karazhan.h"

enum TerestianIllhoof
{
    // SAY_SLAY
    SAY_SLAY1 = -1532065,
    SAY_SLAY2 = -1532066,

    SAY_DEATH = -1532067,
    SAY_AGGRO = -1532068,

    // SAY_SACRIFICE
    SAY_SACRIFICE1 = -1532069,
    SAY_SACRIFICE2 = -1532070,

    // SAY_SUMMON
    SAY_SUMMON1 = -1532071,
    SAY_SUMMON2 = -1532072
};

enum Kilrek
{
    EMOTE_DEATH = -1532115
};

enum Spells
{
    SPELL_SUMMON_DEMONCHAINS = 30120,                   // Summons demonic chains that maintain the ritual of sacrifice.
    SPELL_DEMON_CHAINS = 30206,                   // Instant - Visual Effect
    SPELL_ENRAGE = 23537,                   // Increases the caster's attack speed by 50% and the Physical damage it deals by 219 to 281 for 10 min.
    SPELL_SHADOW_BOLT = 30055,                   // Hurls a bolt of dark magic at an enemy, inflicting Shadow damage.
    SPELL_SACRIFICE = 30115,                   // Teleports and adds the debuff
    SPELL_BERSERK = 32965,                   // Increases attack speed by 75%. Periodically casts Shadow Bolt Volley.
    SPELL_SUMMON_FIENDISIMP = 30184,                   // Summons a Fiendish Imp.
    SPELL_SUMMON_IMP = 30066,                   // Summons Kil'rek

    SPELL_FIENDISH_PORTAL = 30171,                   // Opens portal and summons Fiendish Portal, 2 sec cast
    SPELL_FIENDISH_PORTAL_1 = 30179,                   // Opens portal and summons Fiendish Portal, instant cast

    SPELL_FIREBOLT = 30050,                   // Blasts a target for 150 Fire damage.
    SPELL_BROKEN_PACT = 30065,                   // All damage taken increased by 25%.
    SPELL_AMPLIFY_FLAMES = 30053                 // Increases the Fire damage taken by an enemy by 500 for 25 sec.
};

enum Creatues
{
    NPC_DEMONCHAINS = 17248,
    NPC_FIENDISHIMP = 17267,
    NPC_PORTAL = 17265,
    NPC_KILREK = 17229
};

enum Defines
{
    MAX_COUNT_IMP = 20,
    MAX_COUNT_PORTALS = 2
};

float PortalLocations[2][2] =
{
    { -11252.0205, -1703.97009 },
    { -11241.5742, -1717.40063 }
};

struct mob_demon_chainAI : public ScriptedAI
{
    mob_demon_chainAI(Creature *c) : ScriptedAI(c)
    {
        Initialize();
    }

    void Initialize()
    {
        SacrificeGUID = 0;
    }

    uint64 SacrificeGUID;

    void Reset()
    {
        Initialize();
    }

    void EnterCombat(Unit* /*who*/) {}
    void AttackStart(Unit* /*who*/) {}
    void MoveInLineOfSight(Unit* /*who*/) {}

    void JustDied(Unit * /*killer*/)
    {
        if (SacrificeGUID)
        {
            if (Unit* Sacrifice = Unit::GetUnit((*me), SacrificeGUID))
                Sacrifice->RemoveAurasDueToSpell(SPELL_SACRIFICE);
        }
    }
};

struct mob_fiendish_portalAI : public PassiveAI
{
    mob_fiendish_portalAI(Creature *c) : PassiveAI(c), summons(me){}

    SummonList summons;

    void Reset()
    {
        DespawnAllImp();
    }

    void JustSummoned(Creature* summon)
    {
        summons.Summon(summon);
        DoZoneInCombat();
    }

    void DespawnAllImp()
    {
        summons.DespawnAll();
    }
};

struct boss_terestianAI : public ScriptedAI
{
    boss_terestianAI(Creature *c) : ScriptedAI(c)
    {
        instance = c->GetInstanceData();
        Initialize();
        me->GetPosition(wLoc);
    }

    void Initialize()
    {
        PortalsCount = 0;
        ImpCount = 0;
        SacrificeTimer = 30000;
        ShadowboltTimer = 100;
        PortalTimer = 10000;
        SummonPortalTimer = 0;
        SummonImpTimer = 0;
        SummonKilrekTimer = 5000;
        BerserkTimer = 600000;
        CheckTimer = 3000;

        SummonedPortals = false;
        Berserk = false;
    }

    ScriptedInstance *instance;

    uint64 PortalGUID[2];
    uint8 PortalsCount;
    uint8 ImpCount;

    uint32 SacrificeTimer;
    uint32 ShadowboltTimer;
    uint32 PortalTimer;
    uint32 SummonPortalTimer;
    uint32 SummonImpTimer;
    uint32 SummonKilrekTimer;
    uint32 BerserkTimer;
    uint32 CheckTimer;

    WorldLocation wLoc;

    bool SummonedPortals;
    bool Berserk;

    void Reset()
    {
        for (uint8 i = 0; i < 2; ++i)
        {
            if (PortalGUID[i])
            {
                if (Creature* pPortal = Unit::GetCreature(*me, PortalGUID[i]))
                {
                    pPortal->ForcedDespawn();
                }

                PortalGUID[i] = 0;
            }
        }

        for (uint8 i = 0; i <= 20; i++)
        {
            Unit* imp = NULL;
            if (imp = GetClosestCreatureWithEntry(me, 17267, 50))
                imp->ToCreature()->ForcedDespawn();
        }

        Initialize();

        instance->SetData(DATA_TERESTIAN_EVENT, NOT_STARTED);

        me->RemoveAurasDueToSpell(SPELL_BROKEN_PACT);
    }

    void EnterEvadeMode()
    {
        if (Unit* Kilrek = FindCreature(NPC_KILREK, 40, me))
        {
            if (Kilrek->isAlive())
                Kilrek->ToCreature()->ForcedDespawn();
        }

        ScriptedAI::EnterEvadeMode();
    }

    void EnterCombat(Unit* /*who*/)
    {
        DoScriptText(SAY_AGGRO, me);
    }

    void JustSummoned(Creature* pSummoned)
    {
        if (pSummoned->GetEntry() == NPC_PORTAL)
        {
            PortalGUID[PortalsCount] = pSummoned->GetGUID();
            ++PortalsCount;

            if (pSummoned->GetUInt32Value(UNIT_CREATED_BY_SPELL) == SPELL_FIENDISH_PORTAL_1)
            {
                DoScriptText(RAND(SAY_SUMMON1, SAY_SUMMON2), me);
                SummonedPortals = true;
            }
        }
    }

    void KilledUnit(Unit * /*victim*/)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2), me);
    }

    void JustDied(Unit * /*killer*/)
    {
        for (uint8 i = 0; i < 2; ++i)
        {
            if (PortalGUID[i])
            {
                if (Creature* pPortal = Unit::GetCreature((*me), PortalGUID[i]))
                    pPortal->ForcedDespawn();

                PortalGUID[i] = 0;
            }
        }

        DoScriptText(SAY_DEATH, me);

        instance->SetData(DATA_TERESTIAN_EVENT, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CheckTimer < diff)
        {
            if (!me->IsWithinDistInMap(&wLoc, 35.0f))
                EnterEvadeMode();
            else
                DoZoneInCombat();

            CheckTimer = 3000;
        }
        else
            CheckTimer -= diff;

        if (SacrificeTimer <= diff)
        {
            if (Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1, GetSpellMaxRange(SPELL_SACRIFICE), true))
            {
                if (pTarget->isAlive())
                {
                    DoCast(pTarget, SPELL_SACRIFICE, true);
                    DoCast(pTarget, SPELL_SUMMON_DEMONCHAINS, true);

                    if (Unit* Chain = FindCreature(NPC_DEMONCHAINS, 100, me))
                        if (Creature* Chains = Chain->ToCreature())
                        {
                            CAST_AI(mob_demon_chainAI, Chains->AI())->SacrificeGUID = pTarget->GetGUID();
                            Chains->CastSpell(Chains, SPELL_DEMON_CHAINS, true);
                            DoScriptText(RAND(SAY_SACRIFICE1, SAY_SACRIFICE2), me);
                            SacrificeTimer = 30000;
                        }
                }
            }
        }
        else
            SacrificeTimer -= diff;

        if (SummonKilrekTimer && SummonKilrekTimer <= diff)
        {
            DoCast(me, SPELL_SUMMON_IMP, true);
            me->RemoveAurasDueToSpell(SPELL_BROKEN_PACT);
            SummonKilrekTimer = 0;
        }
        else
            SummonKilrekTimer -= diff;

        if (ShadowboltTimer <= diff)
        {
            DoCast(SelectUnit(SELECT_TARGET_TOPAGGRO, 0), SPELL_SHADOW_BOLT);
            ShadowboltTimer = 10000;
        }
        else
            ShadowboltTimer -= diff;

        if (!SummonedPortals)
        {
            if (PortalTimer && PortalTimer <= diff)
            {
                DoScriptText(RAND(SAY_SUMMON1, SAY_SUMMON2), me);
                DoCast(me, SPELL_FIENDISH_PORTAL, false); // Effect removed in SpellMgr.cpp
                SummonPortalTimer = 2000;
                PortalTimer = 0;
            }
            else
                PortalTimer -= diff;

            if (SummonPortalTimer && SummonPortalTimer <= diff)
            {
                /* Should be fixed in Spell::EffectSummonType to use data from spell_target_position
                if (!PortalGUID[0])
                DoCast(me, SPELL_FIENDISH_PORTAL, false);

                if (!PortalGUID[1])
                DoCast(me, SPELL_FIENDISH_PORTAL_1, false);
                */

                for (uint8 i = 0; i < MAX_COUNT_PORTALS; ++i)
                {
                    if (PortalsCount <= MAX_COUNT_PORTALS)
                        me->SummonCreature(NPC_PORTAL, PortalLocations[i][0], PortalLocations[i][1], me->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_DESPAWN, 20000);
                }

                SummonImpTimer = 5000; // CastingTime (Id 5) = 2.00 + 5000
                SummonedPortals = true;
            }
            else
                SummonPortalTimer -= diff;
        }

        if (SummonImpTimer && SummonImpTimer <= diff)
        {
            if (PortalGUID[0] && PortalGUID[1])
            {
                if (ImpCount < MAX_COUNT_IMP)
                {
                    if (Creature* pPortal = Unit::GetCreature(*me, PortalGUID[urand(0, 1)]))
                    {
                        pPortal->CastSpell(me->getVictim(), SPELL_SUMMON_FIENDISIMP, false);
                        ++ImpCount;
                    }
                }

                SummonImpTimer = urand(2000, 7000);
            }
        }
        else
            SummonImpTimer -= diff;

        if (!Berserk)
        {
            if (BerserkTimer <= diff)
            {
                DoCast(me, SPELL_BERSERK);
                Berserk = true;
            }
            else
                BerserkTimer -= diff;
        }

        DoMeleeAttackIfReady();
    }
};

struct mob_fiendish_impAI : public ScriptedAI
{
    mob_fiendish_impAI(Creature *c) : ScriptedAI(c)
    {
        instance = c->GetInstanceData();
        Initialize();
    }

    ScriptedInstance *instance;

    void Initialize()
    {
        FireboltTimer = 2000;
    }

    uint32 FireboltTimer;

    void Reset()
    {
        Initialize();

        me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
    }

    void JustDied(Unit * /*killer*/)
    {
        if (Creature* Terestian = Unit::GetUnit((*me), instance->GetData64(DATA_TERESTIAN))->ToCreature())
            if (Terestian->isAlive())
                CAST_AI(boss_terestianAI, Terestian->AI())->ImpCount--;
    }

    void EnterCombat(Unit * /*who*/) {}

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            if (Creature* Terestian = Unit::GetUnit((*me), instance->GetData64(DATA_TERESTIAN))->ToCreature())
            {
                if (Terestian->isAlive())
                    me->Attack(Terestian->getVictim(), false);
            }
            else
                return;

        if (FireboltTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_FIREBOLT);
            FireboltTimer = 2200;
        }
        else FireboltTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

struct mob_kilrekAI : public ScriptedAI
{
    mob_kilrekAI(Creature *c) : ScriptedAI(c)
    {
        instance = c->GetInstanceData();
    }

    ScriptedInstance* instance;

    uint32 AmplifyTimer;

    void Reset()
    {
        AmplifyTimer = 2000;
    }

    void JustDied(Unit* /*Killer*/)
    {
        if (Creature* Terestian = Unit::GetUnit((*me), instance->GetData64(DATA_TERESTIAN))->ToCreature())
            if (Terestian->isAlive())
            {
                DoScriptText(EMOTE_DEATH, me);
                CAST_AI(boss_terestianAI, Terestian->AI())->SummonKilrekTimer = 45000;
                DoCast(Terestian, SPELL_BROKEN_PACT, true);
                me->ForcedDespawn(15000);
            }
    }

    void UpdateAI(const uint32 diff)
    {
        // Return since we have no target
        if (!UpdateVictim())
            if (Creature* Terestian = Unit::GetUnit((*me), instance->GetData64(DATA_TERESTIAN))->ToCreature())
            {
                if (Terestian->isAlive())
                    me->Attack(Terestian->getVictim(), false);
            }
            else
                return;

        if (AmplifyTimer <= diff)
        {
            me->InterruptNonMeleeSpells(false);
            DoCast(me->getVictim(), SPELL_AMPLIFY_FLAMES);

            AmplifyTimer = urand(10000, 20000);
        }
        else AmplifyTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_kilrek(Creature* creature)
{
    return new mob_kilrekAI(creature);
}

CreatureAI* GetAI_mob_fiendish_imp(Creature* creature)
{
    return new mob_fiendish_impAI(creature);
}

CreatureAI* GetAI_mob_fiendish_portal(Creature* creature)
{
    return new mob_fiendish_portalAI(creature);
}

CreatureAI* GetAI_boss_terestian_illhoof(Creature* creature)
{
    return new boss_terestianAI(creature);
}

CreatureAI* GetAI_mob_demon_chain(Creature* creature)
{
    return new mob_demon_chainAI(creature);
}

void AddSC_boss_terestian_illhoof()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_terestian_illhoof";
    newscript->GetAI = &GetAI_boss_terestian_illhoof;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_fiendish_imp";
    newscript->GetAI = &GetAI_mob_fiendish_imp;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_fiendish_portal";
    newscript->GetAI = &GetAI_mob_fiendish_portal;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_kilrek";
    newscript->GetAI = &GetAI_mob_kilrek;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_demon_chain";
    newscript->GetAI = &GetAI_mob_demon_chain;
    newscript->RegisterSelf();
}