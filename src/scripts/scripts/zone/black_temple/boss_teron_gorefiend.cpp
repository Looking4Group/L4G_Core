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
SDName: Boss_Teron_Gorefiend
SD%Complete: 99.99%
SDComment: Needs tests and probably some minor changes
SDCategory: Black Temple
EndScriptData */

#include "precompiled.h"
#include "def_black_temple.h"

 //Speech'n'sound
#define SAY_INTRO                       -1564037
#define SAY_AGGRO                       -1564038
#define SAY_SLAY1                       -1564039
#define SAY_SLAY2                       -1564040
#define SAY_SPELL1                      -1564042
#define SAY_SPELL2                      -1564044
#define SAY_SPELL3                      -1564043
#define SAY_SPECIAL1                    -1564041
#define SAY_SPECIAL2                    -1564045
#define SAY_ENRAGE                      -1564045
#define SAY_DEATH                       -1564046

//Spells
#define SPELL_INCINERATE                40239
#define SPELL_CRUSHING_SHADOWS          40243
#define SPELL_SHADOWBOLT                40185
#define SPELL_PASSIVE_SHADOWFORM        40326
#define SPELL_SHADOW_STRIKES            40334
#define SPELL_SHADOW_OF_DEATH           40251
#define SPELL_BERSERK                   45078

#define SPELL_ATROPHY                   40327               // Shadowy Constructs use this when they get within melee range of a player

#define CREATURE_DOOM_BLOSSOM           23123
#define CREATURE_SHADOWY_CONSTRUCT      23111

uint32 GhostSpell[5] =
{
    40314,
    40325,
    40157,
    40175,
    40322
};


struct mob_doom_blossomAI : public NullCreatureAI
{
    mob_doom_blossomAI(Creature *c) : NullCreatureAI(c)
    {
        pInstance = (c->GetInstanceData());
        TeronGUID = pInstance ? pInstance->GetData64(DATA_TERONGOREFIEND) : 0;
    }

    ScriptedInstance* pInstance;

    uint32 CheckTeronTimer;
    uint32 ShadowBoltTimer;
    uint64 TeronGUID;

    void Reset()
    {
        CheckTeronTimer = 10000;
        ShadowBoltTimer = 2000;
        Creature* Teron = (Unit::GetCreature((*m_creature), TeronGUID));
        if(Teron)
            m_creature->setFaction(Teron->getFaction());
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        m_creature->SetLevitate(true);

        float newX, newY, newZ;
        m_creature->GetRandomPoint(m_creature->GetPositionX(),m_creature->GetPositionY(),m_creature->GetPositionZ(), 10.0, newX, newY, newZ);

        newZ = 196.0;
        m_creature->GetMotionMaster()->MovePoint(0, newX, newY, newZ);
        m_creature->SetSpeed(MOVE_RUN, 0.2);
    }

    void EnterCombat(Unit *who){ return; }
    void Despawn()
    {
        m_creature->DealDamage(m_creature, m_creature->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        m_creature->RemoveCorpse();
    }

    void UpdateAI(const uint32 diff)
    {
        if(CheckTeronTimer < diff)
        {
            Creature* Teron = (Unit::GetCreature((*m_creature), TeronGUID));
            if(Teron && Teron->isInCombat())
            {
                DoZoneInCombat();

                Creature* Teron = (Unit::GetCreature((*m_creature), TeronGUID));
                if((Teron) && (!Teron->isAlive() || Teron->IsInEvadeMode()))
                    Despawn();

                float newX, newY, newZ;
                m_creature->GetRandomPoint(m_creature->GetPositionX(),m_creature->GetPositionY(),m_creature->GetPositionZ(), 3.0, newX, newY, newZ);

                newZ = (newZ < 200.0) ? (newZ + 1.0) : newZ;
                m_creature->GetMotionMaster()->MovePoint(1, newX, newY, newZ);
                m_creature->SetSpeed(MOVE_RUN, 0.1);
            }
            else
                Despawn();

            CheckTeronTimer = 5000;
        }
        else
            CheckTeronTimer -= diff;

        if(ShadowBoltTimer < diff)
        {
            Creature* Teron = (Unit::GetCreature((*m_creature), TeronGUID));
            if(!Teron)
                return;

            if(Unit *target = ((ScriptedAI*)Teron->AI())->SelectUnit(SELECT_TARGET_RANDOM, 0, 200, true))
                DoCast(target, SPELL_SHADOWBOLT);

            ShadowBoltTimer = 1500+rand()%1000;
        }
        else
            ShadowBoltTimer -= diff;

        return;
    }
};

struct mob_shadowy_constructAI : public ScriptedAI
{
    mob_shadowy_constructAI(Creature* c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 DelayTimer;
    uint32 CheckTeronTimer;
    uint32 ChangeTarget;

    void Reset()
    {
        DoCast(m_creature, SPELL_PASSIVE_SHADOWFORM, false);
        DoCast(m_creature, SPELL_SHADOW_STRIKES, false);

        CheckTeronTimer = 5000;
        ChangeTarget = 4000;
        DelayTimer = 2000;

        me->SetSpeed(MOVE_RUN, 1.0f);
        me->setActive(true);
    }

    void MoveInLineOfSight(Unit *who)
    {
    }

    void JustDied(Unit *pKiller)
    {
        me->RemoveCorpse();
    }
    void AttackStart(Unit* who)
    {
        // unit or target with posses spirit immune cannot be taken as targets
        if(DelayTimer || who->GetTypeId() != TYPEID_PLAYER || who->HasAura(40282, 0) || who->HasAura(40251, 0) || who->HasAura(40268,0))
            return;

        if(me->getVictim())
            DoModifyThreatPercent(me->getVictim(), -100);

        ScriptedAI::AttackStart(who);

        me->AddThreat(who, 10000000.0f);
        ChangeTarget = 5000;
    }

    void KilledUnit(Unit *who)
    {
        ChangeTarget = 0;
    }

    void DamageTaken(Unit* done_by, uint32 &damage)
    {
        if(!done_by->HasAura(40268,2))
            damage = 0;                                         // Only the ghost can deal damage.
    }

    void DamageMade(Unit* target, uint32 &dmg, bool direct)
    {
        if(dmg && direct)
            DoCast(target, SPELL_ATROPHY);
    }

    void OnAuraApply(Aura* aura, Unit* caster, bool addStack)  // Only ghost spells are working
    {
        for(uint8 i = 0; i < 5; ++i)
        {
            if(aura->GetId() == GhostSpell[i])
                return;
        }

        if(aura->GetId() != SPELL_PASSIVE_SHADOWFORM && aura->GetId() != SPELL_SHADOW_STRIKES)
            m_creature->RemoveAurasByCasterSpell(aura->GetId(), caster->GetGUID());
    }

    void UpdateTarget(uint32 diff)
    {
        if(ChangeTarget < diff)
        {
            DoZoneInCombat();
            if(Creature* pTeron = pInstance->GetCreature(pInstance->GetData64(DATA_TERONGOREFIEND)))
            {
                if(Unit* pTarget = ((ScriptedAI*)pTeron->AI())->SelectUnit(SELECT_TARGET_RANDOM, 1, 100, true))
                    AttackStart(pTarget);
            }

            if(!UpdateVictim())
            {
                if(Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 1, 200, true))
                    AttackStart(pTarget);
            }
        }
        else
            ChangeTarget -= diff;
    }

    void UpdateAI(const uint32 diff)
    {
        if(DelayTimer > diff)
        {
            DelayTimer -= diff;
            return;
        }
        else if(DelayTimer)
        {
            DelayTimer = 0;
        }

        UpdateTarget(diff);

        if(CheckTeronTimer < diff)
        {
            Creature *pTeron = pInstance->GetCreature(pInstance->GetData64(DATA_TERONGOREFIEND));
            if(!pTeron || !pTeron->isInCombat())
                 m_creature->Kill(m_creature, false);

            CheckTeronTimer = 2000;
        }
        else
            CheckTeronTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

struct boss_teron_gorefiendAI : public ScriptedAI
{
    boss_teron_gorefiendAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);

        SpellEntry *ShadowTempSpell = (SpellEntry*)GetSpellStore()->LookupEntry(SPELL_CRUSHING_SHADOWS);
        if(ShadowTempSpell)
            ShadowTempSpell->MaxAffectedTargets = 5;
    }

    ScriptedInstance* pInstance;

    uint32 IncinerateTimer;
    uint32 SummonDoomBlossomTimer;
    uint32 EnrageTimer;
    uint32 CrushingShadowsTimer;
    uint32 ShadowOfDeathTimer;
    uint32 SummonShadowsTimer;
    uint32 RandomYellTimer;
    uint32 AggroTimer;
    uint32 CheckTimer;

    WorldLocation wLoc;

    uint64 AggroTargetGUID;

    enum eIntro
    {
        INTRO_NOT_STARTED,
        INTRO_IN_PROGRESS,
        INTRO_DONE
    };

    uint8 Intro;

    void Reset()
    {
        ClearCastQueue();

        if(pInstance)
            pInstance->SetData(EVENT_TERONGOREFIEND, NOT_STARTED);

        IncinerateTimer = 40000;
        SummonDoomBlossomTimer = 10000;
        EnrageTimer = 600000;
        CrushingShadowsTimer = 30000;
        ShadowOfDeathTimer = 10000;
        RandomYellTimer = 50000;
        CheckTimer = 3000;

        m_creature->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STUN, true);

        // Start off unattackable so that the intro is done properly
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

        AggroTimer = 20000;
        AggroTargetGUID = 0;
        Intro = INTRO_NOT_STARTED;
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, m_creature);

        if(pInstance)
            pInstance->SetData(EVENT_TERONGOREFIEND, IN_PROGRESS);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if(!who || !who->isAlive())
            return;

        if(!m_creature->isInCombat() && who->isTargetableForAttack() && who->isInAccessiblePlacefor(m_creature) && m_creature->IsHostileTo(who))
        {
            float attackRadius = m_creature->GetAttackDistance(who);

            if (Intro == INTRO_DONE && m_creature->IsWithinDistInMap(who, attackRadius) && m_creature->GetDistanceZ(who) <= CREATURE_Z_ATTACK_RANGE && m_creature->IsWithinLOSInMap(who))
            {
                AttackStart(who);
                DoZoneInCombat();
            }

            if(Intro == INTRO_NOT_STARTED && m_creature->IsWithinDistInMap(who, 60.0f) && (who->GetTypeId() == TYPEID_PLAYER))
            {
                m_creature->GetMotionMaster()->Clear(false);
                DoScriptText(SAY_INTRO, m_creature);
                m_creature->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_TALK);
                AggroTargetGUID = who->GetGUID();
                Intro = INTRO_IN_PROGRESS;
            }
        }
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2), m_creature);
    }

    void JustDied(Unit *victim)
    {
        if(pInstance)
            pInstance->SetData(EVENT_TERONGOREFIEND, DONE);

        const Map::PlayerList& players = me->GetMap()->GetPlayers();
        for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
            i->getSource()->RemoveAurasDueToSpell(SPELL_SHADOW_OF_DEATH);

        DoScriptText(SAY_DEATH, m_creature);
    }

    void DamageTaken(Unit* done_by, uint32 &damage)
    {
        if(done_by->HasAura(40268,2))
            damage = 0;                                         // Boss cannot be damaged by ghosts.
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)    // Ghosts spells cant be applied on Teron
    {
        if(caster->GetTypeId() == TYPEID_UNIT && caster->isPossessedByPlayer())
            m_creature->RemoveAurasByCasterSpell(spell->Id, caster->GetGUID());

    }

    void SpellHitTarget(Unit *target, const SpellEntry *spell)
    {
        if(!pInstance)
            return;

        if(spell->Id == SPELL_SHADOW_OF_DEATH)
            pInstance->SetData64(DATA_SHADOWOFDEATH_APPLY, target->GetGUID());
    }

    float CalculateRandomLocation(float Loc, uint32 radius)
    {
        float coord = Loc;
        switch(rand()%2)
        {
            case 0:
                coord += rand()%radius;
                break;
            case 1:
                coord -= rand()%radius;
                break;
        }
        return coord;
    }

    void SetThreatList(Creature* Blossom)
    {
        if(!Blossom) return;

        std::list<HostilReference*>& m_threatlist = m_creature->getThreatManager().getThreatList();
        std::list<HostilReference*>::iterator i = m_threatlist.begin();
        for(i = m_threatlist.begin(); i != m_threatlist.end(); i++)
        {
            Unit* pUnit = Unit::GetUnit((*m_creature), (*i)->getUnitGuid());
            if(pUnit && pUnit->isAlive())
            {
                float threat = DoGetThreat(pUnit);
                Blossom->AddThreat(pUnit, threat);
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(Intro == INTRO_IN_PROGRESS)
        {
            if(AggroTimer < diff)
            {
                m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                m_creature->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                Intro = INTRO_DONE;
            }
            else
                AggroTimer -= diff;
        }

        if(!UpdateVictim() || Intro == INTRO_IN_PROGRESS)
            return;

        if (CheckTimer < diff)
        {
            if(!m_creature->IsWithinDistInMap(&wLoc, 90))
                EnterEvadeMode();
            else
                DoZoneInCombat();

            m_creature->SetSpeed(MOVE_RUN, 2.5);

            CheckTimer = 1500;
        }
        else
            CheckTimer -= diff;

        if(SummonDoomBlossomTimer < diff)
        {
            AddSpellToCast(m_creature, 40188);
            SummonDoomBlossomTimer = 25000+rand()%15000;
        }
        else
            SummonDoomBlossomTimer -= diff;

        if(IncinerateTimer < diff)
        {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 200, true, m_creature->getVictimGUID());
            if(!target)
                target = m_creature->getVictim();

            if(target)
            {
                AddSpellToCastWithScriptText(target, SPELL_INCINERATE, RAND(SAY_SPECIAL1, SAY_SPECIAL2));
                IncinerateTimer = urand(5000, 40000);
            }
        }
        else
            IncinerateTimer -= diff;

        if(CrushingShadowsTimer < diff)
        {
            AddSpellToCastWithScriptText(m_creature, SPELL_CRUSHING_SHADOWS, SAY_SPELL3);
            CrushingShadowsTimer = urand(17000, 42000);
        }
        else
            CrushingShadowsTimer -= diff;


        if(ShadowOfDeathTimer < diff)
        {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 100, true, m_creature->getVictimGUID());

            if(target && target->isAlive() && !target->HasAura(SPELL_SHADOW_OF_DEATH, 0) && !target->HasAura(40282, 0) )
            {
                AddSpellToCast(target, SPELL_SHADOW_OF_DEATH, false, true);
                ShadowOfDeathTimer = 30000;
            }
        }
        else
            ShadowOfDeathTimer -= diff;

        if(RandomYellTimer < diff)
        {
            DoScriptText(RAND(SAY_SPELL1, SAY_SPELL2), m_creature);
            RandomYellTimer = 50000 + rand()%51000;
        }
        else
            RandomYellTimer -= diff;

        if(!m_creature->HasAura(SPELL_BERSERK, 0))
        {
            if(EnrageTimer < diff)
            {
                AddSpellToCastWithScriptText(m_creature, SPELL_BERSERK, SAY_ENRAGE);
            }
            else
                EnrageTimer -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_doom_blossom(Creature *_Creature)
{
    return new mob_doom_blossomAI(_Creature);
}

CreatureAI* GetAI_mob_shadowy_construct(Creature *_Creature)
{
    return new mob_shadowy_constructAI(_Creature);
}

CreatureAI* GetAI_boss_teron_gorefiend(Creature *_Creature)
{
    return new boss_teron_gorefiendAI (_Creature);
}

void AddSC_boss_teron_gorefiend()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "mob_doom_blossom";
    newscript->GetAI = &GetAI_mob_doom_blossom;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadowy_construct";
    newscript->GetAI = &GetAI_mob_shadowy_construct;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_teron_gorefiend";
    newscript->GetAI = &GetAI_boss_teron_gorefiend;
    newscript->RegisterSelf();
}

