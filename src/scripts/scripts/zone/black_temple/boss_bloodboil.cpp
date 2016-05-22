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
SDName: Boss_Bloodboil
SD%Complete: 80
SDComment: Bloodboil not working correctly, missing enrage
SDCategory: Black Temple
EndScriptData */

#include "precompiled.h"
#include "def_black_temple.h"

//Speech'n'Sound
#define SAY_AGGRO               -1564029
#define SAY_SLAY1               -1564030
#define SAY_SLAY2               -1564031
#define SAY_SPECIAL1            -1564032
#define SAY_SPECIAL2            -1564033
#define SAY_ENRAGE1             -1564034
#define SAY_ENRAGE2             -1564035
#define SAY_DEATH               -1564036

//Spells diff in p1 and p2
#define SPELL_ARCING_SMASH          Phase1 ? 40457 : 40599
#define SPELL_FEL_ACID              Phase1 ? 40508 : 40595
#define SPELL_EJECT                 Phase1 ? 40486 : 40597

// Phase1
#define SPELL_BEWILDERING_STRIKE    40491
#define SPELL_BLOODBOIL             42005
#define SPELL_ACIDIC_WOUND          40481 /*40484*/

//Phase2
#define SPELL_SUMMON_FEL_GEYSER     40569
#define SPELL_FEL_GEYSER_AOE        40593
#define NPC_FEL_GEYSER              23254

//Fel Rage
#define SPELL_INSIGNIFIGANCE        40618
#define SPELL_TAUNT_GURTOGG         40603
#define SPELL_FEL_RAGE_SELF         40594
#define SPELL_FEL_RAGE_1            40604
#define SPELL_FEL_RAGE_2            40616
#define SPELL_FEL_RAGE_3            41625
#define SPELL_FEL_RAGE_SCALE        46787

#define SPELL_CHARGE                40602

//Enrage
#define SPELL_BERSERK               45078

//This is used to sort the players by distance in preparation for the Bloodboil cast.
struct ObjectDistanceOrderReversed : public std::binary_function<const WorldObject, const WorldObject, bool>
{
    const Unit* m_pSource;
    ObjectDistanceOrderReversed(const Unit* pSource) : m_pSource(pSource) {};

    bool operator()(const WorldObject* pLeft, const WorldObject* pRight) const
    {
        return !m_pSource->GetDistanceOrder(pLeft, pRight, false);
    }
};

struct boss_gurtogg_bloodboilAI : public ScriptedAI
{
    boss_gurtogg_bloodboilAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);

        me->SetAggroRange(45.0f);
    }

    ScriptedInstance* pInstance;
    WorldLocation wLoc;

    uint64 m_targetGUID;
    float m_targetThreat;

    uint32 BloodboilTimer;

    uint32 BewilderingStrikeTimer;
    uint32 AcidicWoundTimer;

    uint32 ArcingSmashTimer;
    uint32 FelAcidTimer;
    uint32 EjectTimer;

    uint32 PhaseChangeTimer;

    uint32 EnrageTimer;

    uint32 ChargeTimer;
    uint32 CheckTimer;

    bool Phase1;

    void Reset()
    {
        ClearCastQueue();

        if(pInstance)
            pInstance->SetData(EVENT_GURTOGGBLOODBOIL, NOT_STARTED);

        m_targetGUID = 0;
        m_targetThreat = 0;

        BloodboilTimer = 10000;

        BewilderingStrikeTimer = urand(5000, 65000);
        AcidicWoundTimer = 2000;

        ArcingSmashTimer = 10000;
        FelAcidTimer = urand(20000, 25000);
        EjectTimer = 15000;

        PhaseChangeTimer = 59000;
        CheckTimer = 1000;

        EnrageTimer = 600000;

        Phase1 = true;
        ChargeTimer = 2000;

        //DoCast(m_creature, SPELL_ACIDIC_WOUND, true);
    }

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();
        DoScriptText(SAY_AGGRO, m_creature);
        if(pInstance)
            pInstance->SetData(EVENT_GURTOGGBLOODBOIL, IN_PROGRESS);
    }

    void JustSummoned(Unit *pSummon)
    {
        /*przeniesione do OnCreatureCreate()
        if (pSummon->GetTypeId() == TYPEID_UNIT)
        {
            if (pSummon->GetEntry() == NPC_FEL_GEYSER)
            {
                pSummon->setFaction(me->getFaction());
                pSummon->CastSpell(pSummon, SPELL_FEL_GEYSER_AOE, false);
            }
        }*/
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2), m_creature);
    }

    void JustDied(Unit *victim)
    {
        if(pInstance)
            pInstance->SetData(EVENT_GURTOGGBLOODBOIL, DONE);

        DoScriptText(SAY_DEATH, m_creature);
    }

    void CastBloodboil()
    {
        std::list<Unit *> targets;
        Map *map = m_creature->GetMap();
        if (map->IsDungeon())
        {
            InstanceMap::PlayerList const &PlayerList = ((InstanceMap*)map)->GetPlayers();
            for (InstanceMap::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (Player* i_pl = i->getSource())
                {
                    if(i_pl && i_pl->isAlive() && !i_pl->isGameMaster())
                        targets.push_back(i_pl);
                }
            }
        }

        if (targets.empty())
            return;

        targets.sort(ObjectDistanceOrderReversed(m_creature));
        targets.resize(5);

        //Aura each player in the targets list with Bloodboil.
        for (std::list<Unit *>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
        {
            Unit* target = *itr;
            if (target && target->isAlive())
                ForceSpellCast(target, SPELL_BLOODBOIL, INTERRUPT_AND_CAST_INSTANTLY, true);
        }
        targets.clear();
    }

    void OnAuraRemove(Aura * aur, bool removeStack)
    {
        if (aur->GetId() == SPELL_FEL_RAGE_SELF)
        {
            if (Unit *pTarget = Unit::GetUnit(*m_creature, m_targetGUID))
            {
                m_targetGUID = 0;
                pTarget->RemoveAurasDueToSpell(SPELL_INSIGNIFIGANCE);
                me->RemoveAurasDueToSpell(SPELL_INSIGNIFIGANCE);
                if(DoGetThreat(pTarget))
                    DoModifyThreatPercent(pTarget, -100);

                m_creature->AddThreat(pTarget, m_targetThreat);
                m_targetThreat = 0;
            }
            PhaseChangeTimer = 0;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CheckTimer < diff)
        {
            DoZoneInCombat();
            CheckTimer = 1000;
            m_creature->SetSpeed(MOVE_RUN, Phase1 ? 2.0 : 3.0);
        }
        else
            CheckTimer -= diff;

        if (EnrageTimer)
        {
            if (EnrageTimer <= diff)
            {
                EnrageTimer = 0;
                ForceSpellCastWithScriptText(m_creature, SPELL_BERSERK, RAND(SAY_ENRAGE1, SAY_ENRAGE2), INTERRUPT_AND_CAST_INSTANTLY);
            }
            else
                EnrageTimer -= diff;
        }

        if (ArcingSmashTimer < diff)
        {
            ForceSpellCast(m_creature->getVictim(), SPELL_ARCING_SMASH, DONT_INTERRUPT, false, true);
            ArcingSmashTimer = 10000;
        }
        else
            ArcingSmashTimer -= diff;

        if (FelAcidTimer < diff)
        {
            if (Phase1)
            {
                if (Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 15, true))
                {
                    AddSpellToCast(pTarget, SPELL_FEL_ACID, false, true);
                    FelAcidTimer = urand(20000, 25000);
                }
            }
            else
            {
                AddSpellToCast(m_creature->getVictim(), SPELL_FEL_ACID);
                FelAcidTimer = urand(5000, 25000);
            }
        }
        else
            FelAcidTimer -= diff;

        if (Phase1)
        {
            if (AcidicWoundTimer < diff)
            {
                AddSpellToCast(m_creature->getVictim(), SPELL_ACIDIC_WOUND);
                AcidicWoundTimer = 2000;
            }
            else
                AcidicWoundTimer -= diff;

            if (BewilderingStrikeTimer < diff)
            {
                AddSpellToCast(m_creature->getVictim(), SPELL_BEWILDERING_STRIKE);
                BewilderingStrikeTimer = urand(5000, 65000);
            }
            else
                BewilderingStrikeTimer -= diff;

            if (BloodboilTimer < diff)
            {
                CastBloodboil();
                BloodboilTimer = 10000;
            }
            else
                BloodboilTimer -= diff;


            if (EjectTimer < diff)
            {
                AddSpellToCast(m_creature->getVictim(), SPELL_EJECT);
                EjectTimer = 15000;
            }
            else
                EjectTimer -= diff;
        }
        else
        {
            if (ChargeTimer <= diff)
            {
                Unit *pVictim = m_creature->getVictim();
                if (!m_creature->IsWithinDistInMap(pVictim, 5.0f))
                {
                    ForceSpellCast(pVictim, SPELL_EJECT);
                    ForceSpellCast(pVictim, SPELL_CHARGE);
                }
                ChargeTimer = 2000;
            }
            else
                ChargeTimer -= diff;
        }

        if (PhaseChangeTimer < diff)
        {
            if (Phase1)
            {
                if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 65.0f, true))
                {
                    ClearCastQueue();
                    ForceSpellCast(pTarget, SPELL_SUMMON_FEL_GEYSER, INTERRUPT_AND_CAST_INSTANTLY);
                    //m_creature->RemoveAurasDueToSpell(SPELL_ACIDIC_WOUND);

                    m_creature->SetSpeed(MOVE_RUN, 3.0);

                    m_creature->SetSelection(pTarget->GetGUID());

                    pTarget->CastSpell(m_creature, SPELL_TAUNT_GURTOGG, true);

                    ForceSpellCast(pTarget, SPELL_FEL_RAGE_1, INTERRUPT_AND_CAST_INSTANTLY);
                    ForceSpellCast(pTarget, SPELL_FEL_RAGE_2, INTERRUPT_AND_CAST_INSTANTLY);
                    ForceSpellCast(pTarget, SPELL_FEL_RAGE_3, INTERRUPT_AND_CAST_INSTANTLY);
                    ForceSpellCast(pTarget, SPELL_FEL_RAGE_SCALE, INTERRUPT_AND_CAST_INSTANTLY);

                    ForceSpellCast(m_creature, SPELL_FEL_RAGE_SELF, INTERRUPT_AND_CAST);
                    ForceSpellCast(m_creature, SPELL_INSIGNIFIGANCE, INTERRUPT_AND_CAST);

                    DoScriptText(RAND(SAY_SPECIAL1, SAY_SPECIAL2), m_creature);

                    ArcingSmashTimer = 10000;
                    FelAcidTimer = urand(5000, 25000);
                    ChargeTimer = 2000;

                    if (m_targetThreat = DoGetThreat(pTarget))
                        DoModifyThreatPercent(pTarget, -100);

                    m_targetGUID = pTarget->GetGUID();
                    m_creature->AddThreat(pTarget, 5000000.0f);

                    PhaseChangeTimer = 39000;
                    Phase1 = false;
                }
            }
            else
            {
                Phase1 = true;
                /*if (Unit *pTarget = Unit::GetUnit(*m_creature, m_targetGUID))
                {
                    m_targetGUID = 0;
                    if(DoGetThreat(pTarget))
                        DoModifyThreatPercent(pTarget, -100);

                    m_creature->AddThreat(pTarget, m_targetThreat);
                    m_targetThreat = 0;
                }*/

                BewilderingStrikeTimer = urand(5000, 65000);
                BloodboilTimer = 10000;
                ArcingSmashTimer = 10000;
                FelAcidTimer = urand(20000, 25000);
                EjectTimer = 15000;
                PhaseChangeTimer = 59000;

                m_creature->SetSpeed(MOVE_RUN, 2.0);
                //ForceSpellCast(m_creature, SPELL_ACIDIC_WOUND, INTERRUPT_AND_CAST_INSTANTLY);
            }
        }
        else
            PhaseChangeTimer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_gurtogg_bloodboil(Creature *_Creature)
{
    return new boss_gurtogg_bloodboilAI (_Creature);
}

void AddSC_boss_gurtogg_bloodboil()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_gurtogg_bloodboil";
    newscript->GetAI = &GetAI_boss_gurtogg_bloodboil;
    newscript->RegisterSelf();
}
