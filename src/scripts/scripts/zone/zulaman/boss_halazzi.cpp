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

/* ScriptData
SDName: boss_Halazzi
SD%Complete: 80
SDComment:
SDCategory: Zul'Aman
EndScriptData */

#include "precompiled.h"
#include "def_zulaman.h"
//#include "spell.h"

#define YELL_AGGRO                      -1800484
#define YELL_SABER_ONE                  -1800485
#define YELL_SABER_TWO                  -1800486
#define YELL_SPLIT                      -1800487
#define YELL_MERGE                      -1800488
#define YELL_KILL_ONE                   -1800489
#define YELL_KILL_TWO                   -1800490
#define YELL_DEATH                      -1800491
#define YELL_BERSERK                    -1800492
#define YELL_INTRO1                     -1800510
#define YELL_INTRO2                     -1800511

#define SPELL_DUAL_WIELD                29651
#define SPELL_SABER_LASH                43267
#define SPELL_FRENZY                    43139
#define SPELL_FLAMESHOCK                43303
#define SPELL_EARTHSHOCK                43305
#define SPELL_TRANSFORM_SPLIT           43142
#define SPELL_TRANSFORM_SPLIT2          43573
#define SPELL_TRANSFORM_MERGE           43271
#define SPELL_SUMMON_LYNX               43143
#define SPELL_SUMMON_TOTEM              43302
#define SPELL_BERSERK                   45078

#define MOB_SPIRIT_LYNX                 24143
#define SPELL_LYNX_FRENZY               43290
#define SPELL_SHRED_ARMOR               43243

#define MOB_TOTEM                       24224
#define SPELL_LIGHTNING                 43301

enum PhaseHalazzi
{
    PHASE_NONE = 0,
    PHASE_LYNX = 1,
    PHASE_SPLIT = 2,
    PHASE_HUMAN = 3,
    PHASE_MERGE = 4,
    PHASE_ENRAGE = 5
};

struct boss_halazziAI : public ScriptedAI
{
    boss_halazziAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        // need to find out what controls totem's spell cooldown
        SpellEntry *TempSpell = (SpellEntry*)GetSpellStore()->LookupEntry(SPELL_LIGHTNING);
        if(TempSpell && TempSpell->CastingTimeIndex != 5)
            TempSpell->CastingTimeIndex = 5; // 2000 ms casting time
        m_creature->GetPosition(wLoc);
    }

    ScriptedInstance *pInstance;

    uint32 FrenzyTimer;
    uint32 SaberlashTimer;
    uint32 ShockTimer;
    uint32 TotemTimer;
    uint32 CheckTimer;
    uint32 BerserkTimer;

    uint32 TransformCount;

    PhaseHalazzi Phase;

    uint64 LynxGUID;

    uint32 checkTimer2;
    WorldLocation wLoc;
    bool Intro;

    void Reset()
    {
        if(pInstance && pInstance->GetData(DATA_HALAZZIEVENT) != DONE)
            pInstance->SetData(DATA_HALAZZIEVENT, NOT_STARTED);

        TransformCount = 0;
        BerserkTimer = 600000;
        CheckTimer = 1000;

        DoCast(m_creature, SPELL_DUAL_WIELD, true);

        Phase = PHASE_NONE;
        EnterPhase(PHASE_LYNX);

        checkTimer2 = 3000;
        Intro = false;
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance)
            pInstance->SetData(DATA_HALAZZIEVENT, IN_PROGRESS);

        DoScriptText(YELL_AGGRO, m_creature);

        EnterPhase(PHASE_LYNX);
    }

    void JustSummoned(Creature* summon)
    {
        summon->AI()->DoZoneInCombat();
        summon->AI()->AttackStart(m_creature->getVictim());
        if(summon->GetEntry() == MOB_SPIRIT_LYNX)
            LynxGUID = summon->GetGUID();
        
    }

    void MoveInLineOfSight(Unit *who)
    {
        if(!Intro && me->IsHostileTo(who) && who->IsWithinDist(me, 64, false))
        {
            Intro = true;
            DoScriptText(RAND(YELL_INTRO1, YELL_INTRO2), m_creature);
        }
        CreatureAI::MoveInLineOfSight(who);
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if(damage >= m_creature->GetHealth() && Phase != PHASE_ENRAGE)
            damage = 0;
    }

    void SpellHit(Unit*, const SpellEntry *spell)
    {
        if(spell->Id == SPELL_TRANSFORM_SPLIT2)
            EnterPhase(PHASE_HUMAN);
    }

    void AttackStart(Unit *who)
    {
        if(Phase != PHASE_MERGE) ScriptedAI::AttackStart(who);
    }

    void EnterPhase(PhaseHalazzi NextPhase)
    {
        switch(NextPhase)
        {
        case PHASE_LYNX:
        case PHASE_ENRAGE:
            if(Phase == PHASE_MERGE)
            {
                ForceSpellCast(m_creature, SPELL_TRANSFORM_MERGE, INTERRUPT_AND_CAST_INSTANTLY, true);
                m_creature->Attack(m_creature->getVictim(), true);
                m_creature->GetMotionMaster()->MoveChase(m_creature->getVictim());
            }
            if(Unit *Lynx = Unit::GetUnit(*m_creature, LynxGUID))
            {
                Lynx->SetVisibility(VISIBILITY_OFF);
                Lynx->setDeathState(JUST_DIED);
            }
            m_creature->SetMaxHealth(600000);
            m_creature->SetHealth(600000 - 150000 * TransformCount);
            FrenzyTimer = 16000;
            SaberlashTimer = 5000;
            ShockTimer = 10000;
            TotemTimer = 12000;
            break;
        case PHASE_SPLIT:
            AddSpellToCastWithScriptText(m_creature, SPELL_TRANSFORM_SPLIT, YELL_SPLIT, true);
            break;
        case PHASE_HUMAN:
            //DoCast(m_creature, SPELL_SUMMON_LYNX, true);
            DoSpawnCreature(MOB_SPIRIT_LYNX, 5,5,0,0, TEMPSUMMON_CORPSE_DESPAWN, 0);
            m_creature->SetMaxHealth(400000);
            m_creature->SetHealth(400000);
            ShockTimer = 10000;
            TotemTimer = 12000;
            break;
        case PHASE_MERGE:
            if(Unit *Lynx = Unit::GetUnit(*m_creature, LynxGUID))
            {
                DoScriptText(YELL_MERGE, m_creature);
                Lynx->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                Lynx->GetMotionMaster()->Clear();
                Lynx->GetMotionMaster()->MoveFollow(m_creature, 0, 0);
                m_creature->GetMotionMaster()->Clear();
                m_creature->GetMotionMaster()->MoveFollow(Lynx, 0, 0);
                TransformCount++;
            }break;
        default:
            break;
        }
        Phase = NextPhase;
    }

     void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if (checkTimer2 < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 50))
                EnterEvadeMode();
            else
                DoZoneInCombat();
            checkTimer2 = 3000;
        }
        else
            checkTimer2 -= diff;

        if(BerserkTimer < diff)
        {
            AddSpellToCastWithScriptText(m_creature, SPELL_BERSERK, YELL_BERSERK);
            BerserkTimer = 60000;
        }else BerserkTimer -= diff;

        if(Phase == PHASE_LYNX || Phase == PHASE_ENRAGE)
        {
            if(SaberlashTimer < diff)
            {
                AddSpellToCastWithScriptText(m_creature->getVictim(), SPELL_SABER_LASH, RAND(YELL_SABER_ONE, YELL_SABER_TWO));
                SaberlashTimer = 5000 + rand() % 10000;
            }else SaberlashTimer -= diff;

            if(FrenzyTimer < diff)
            {
                AddSpellToCast(m_creature, SPELL_FRENZY);
                FrenzyTimer = (10+rand()%5)*1000;
            }else FrenzyTimer -= diff;

            if(Phase == PHASE_LYNX)
                if(CheckTimer < diff)
                {
                    if(m_creature->GetHealth() * 4 < m_creature->GetMaxHealth() * (3 - TransformCount))
                        EnterPhase(PHASE_SPLIT);
                    CheckTimer = 1000;
                }else CheckTimer -= diff;
        }

        if(Phase == PHASE_HUMAN || Phase == PHASE_ENRAGE)
        {
            if(TotemTimer < diff)
            {
                AddSpellToCast(m_creature, SPELL_SUMMON_TOTEM);
                TotemTimer = 20000;
            }else TotemTimer -= diff;

            if(ShockTimer < diff)
            {
                if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0,GetSpellMaxRange(SPELL_EARTHSHOCK), true))
                {
                    if(target->IsNonMeleeSpellCasted(false))
                        AddSpellToCast(target,SPELL_EARTHSHOCK);
                    else
                        AddSpellToCast(target,SPELL_FLAMESHOCK);
                    ShockTimer = 10000 + rand()%5000;
                }
            }else ShockTimer -= diff;

            if(Phase == PHASE_HUMAN)
                if(CheckTimer < diff)
                {
                    if( ((m_creature->GetHealth()*100) / m_creature->GetMaxHealth() <= 20)/*m_creature->GetHealth() * 10 < m_creature->GetMaxHealth()*/)
                        EnterPhase(PHASE_MERGE);
                    else
                    {
                        Unit *Lynx = Unit::GetUnit(*m_creature, LynxGUID);
                        if(Lynx && ((Lynx->GetHealth()*100) / Lynx->GetMaxHealth() <= 20)/*Lynx->GetHealth() * 10 < Lynx->GetMaxHealth()*/)
                            EnterPhase(PHASE_MERGE);
                    }
                    CheckTimer = 1000;
                }else CheckTimer -= diff;
        }

        if(Phase == PHASE_MERGE)
        {
            if(CheckTimer < diff)
            {
                Unit *Lynx = Unit::GetUnit(*m_creature, LynxGUID);
                if(Lynx)
                {
                    Lynx->GetMotionMaster()->MoveFollow(m_creature, 0, 0);
                    m_creature->GetMotionMaster()->MoveFollow(Lynx, 0, 0);
                    if(m_creature->IsWithinDistInMap(Lynx, 6.0f))
                    {
                        if(TransformCount < 3)
                            EnterPhase(PHASE_LYNX);
                        else
                            EnterPhase(PHASE_ENRAGE);
                    }
                }
                CheckTimer = 1000;
            }else CheckTimer -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(RAND(YELL_KILL_ONE, YELL_KILL_TWO), m_creature);
    }

    void JustDied(Unit* Killer)
    {
        if(pInstance)
            pInstance->SetData(DATA_HALAZZIEVENT, DONE);

        DoScriptText(YELL_DEATH, m_creature);
    }
};

// Spirits Lynx AI

struct boss_spiritlynxAI : public ScriptedAI
{
    boss_spiritlynxAI(Creature *c) : ScriptedAI(c) {}

    uint32 FrenzyTimer;
    uint32 shredder_timer;

    void Reset()
    {
        FrenzyTimer = (30+rand()%20)*1000;  //frenzy every 30-50 seconds
        shredder_timer = 4000;
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if(damage >= m_creature->GetHealth())
            damage = 0;
    }

    void AttackStart(Unit *who)
    {
        if(!m_creature->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
            ScriptedAI::AttackStart(who);
    }

    void EnterCombat(Unit *who) {/*DoZoneInCombat();*/}

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(FrenzyTimer < diff)
        {
            DoCast(m_creature, SPELL_LYNX_FRENZY);
            FrenzyTimer = (30+rand()%20)*1000;
        }else FrenzyTimer -= diff;

        if(shredder_timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_SHRED_ARMOR);
            shredder_timer = 4000;
        }else shredder_timer -= diff;

        DoMeleeAttackIfReady();
    }

};

CreatureAI* GetAI_boss_halazziAI(Creature *_Creature)
{
    return new boss_halazziAI (_Creature);
}

CreatureAI* GetAI_boss_spiritlynxAI(Creature *_Creature)
{
    return new boss_spiritlynxAI (_Creature);
}

void AddSC_boss_halazzi()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_halazzi";
    newscript->GetAI = &GetAI_boss_halazziAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_halazzi_lynx";
    newscript->GetAI = &GetAI_boss_spiritlynxAI;
    newscript->RegisterSelf();
}

