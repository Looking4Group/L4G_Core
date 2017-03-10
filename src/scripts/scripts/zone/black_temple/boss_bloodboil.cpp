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
SD%Complete: 90
SDComment: Geyser/Charge?
SDCategory: Black Temple
EndScriptData */

#include "precompiled.h"
#include "def_black_temple.h"

enum Bloodboil
{
    //Speech'n'Sound
    SAY_AGGRO                   = -1564029,
    SAY_SLAY1                   = -1564030,
    SAY_SLAY2                   = -1564031,
    SAY_SPECIAL1                = -1564032,
    SAY_SPECIAL2                = -1564033,
    SAY_ENRAGE1                 = -1564034,
    SAY_ENRAGE2                 = -1564035,
    SAY_DEATH                   = -1564036,

    // Phase1
    SPELL_BEWILDERING_STRIKE    =    40491,
    SPELL_BLOODBOIL             =    42005,
    SPELL_ACIDIC_WOUND          =    40481, //40484

    //Phase2
    SPELL_ACID_GEYSER           =    40630, //not confirmed who casts this.
    SPELL_SUMMON_FEL_GEYSER     =    40569,
    SPELL_FEL_GEYSER_AOE        =    40593,
    NPC_FEL_GEYSER              =    23254,

    //Fel Rage
    SPELL_FEL_GEYSER_STUN       =    40591,
    SPELL_INSIGNIFIGANCE        =    40618,
    SPELL_TAUNT_GURTOGG         =    40603,
    SPELL_FEL_RAGE_SELF         =    40594,
    SPELL_FEL_RAGE_1            =    40604,
    SPELL_FEL_RAGE_2            =    40616,
    SPELL_FEL_RAGE_3            =    41625,
    SPELL_FEL_RAGE_SCALE        =    46787,
    SPELL_CHARGE                =    40602, // spell not confirmed

    //Enrage
    SPELL_BERSERK               =    27680
};

#define SPELL_ARCING_SMASH          Phase1 ? 40457 : 40599
#define SPELL_FEL_ACID              Phase1 ? 40508 : 40595
#define SPELL_EJECT                 Phase1 ? 40486 : 40597

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

        BewilderingStrikeTimer = 15000;
        AcidicWoundTimer = 2000;

        ArcingSmashTimer = 10000;
        FelAcidTimer = urand(20000, 25000);
        EjectTimer = 10000;

        PhaseChangeTimer = 59000;
        CheckTimer = 1000;

        EnrageTimer = 600000;

        Phase1 = true;
    }

    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();
        DoScriptText(SAY_AGGRO, m_creature);
        if(pInstance)
            pInstance->SetData(EVENT_GURTOGGBLOODBOIL, IN_PROGRESS);
    }

    void JustSummoned(Unit *pSummon){}

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

        if (EjectTimer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_EJECT);
            EjectTimer = 15000;
        }
        else
            EjectTimer -= diff;

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
                BewilderingStrikeTimer = 20000;
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
        }

        if (PhaseChangeTimer < diff)
        {
            if (Phase1)
            {
                if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 65.0f, true))
                {
                    ClearCastQueue();
                    ForceSpellCast(pTarget, SPELL_SUMMON_FEL_GEYSER, INTERRUPT_AND_CAST_INSTANTLY);

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

                    if (m_targetThreat = DoGetThreat(pTarget))
                        DoModifyThreatPercent(pTarget, -100);

                    m_targetGUID = pTarget->GetGUID();
                    m_creature->AddThreat(pTarget, 5000000.0f);

                    PhaseChangeTimer = 31000;
                    Phase1 = false;
                }
            }
            else
            {
                Phase1 = true;
                
                BewilderingStrikeTimer += 2000;
                BloodboilTimer = 10000;
                ArcingSmashTimer += 2000;
                FelAcidTimer += 2000;
                EjectTimer += 2000;
                PhaseChangeTimer = 59000;
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
