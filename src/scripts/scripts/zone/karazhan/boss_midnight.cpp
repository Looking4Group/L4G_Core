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
SDName: Boss_Midnight
SD%Complete: 100
SDComment:
SDCategory: Karazhan
EndScriptData */

#include "precompiled.h"
#include "def_karazhan.h"

#define SAY_MIDNIGHT_KILL           -1532000
#define SAY_APPEAR1                 -1532001
#define SAY_APPEAR2                 -1532002
#define SAY_APPEAR3                 -1532003
#define SAY_MOUNT                   -1532004
#define SAY_KILL1                   -1532005
#define SAY_KILL2                   -1532006
#define SAY_DISARMED                -1532007
#define SAY_DEATH                   -1532008
#define SAY_RANDOM1                 -1532009
#define SAY_RANDOM2                 -1532010

#define SPELL_SHADOWCLEAVE          29832
#define SPELL_INTANGIBLE_PRESENCE   29833
#define SPELL_BERSERKER_CHARGE      26561                   //Only when mounted

#define MOUNTED_DISPLAYID           16040

//Attumen (TODO: Use the summoning spell instead of creature id. It works , but is not convenient for us)
#define SUMMON_ATTUMEN 15550

struct boss_midnightAI : public ScriptedAI
{
    boss_midnightAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);
    }

    uint64 Attumen;
    uint8 Phase;
    uint32 Mount_Timer;
    uint32 CheckTimer;

    ScriptedInstance *pInstance;
    WorldLocation wLoc;

    void Reset()
    {
        Phase = 1;
        Attumen = 0;
        Mount_Timer = 0;
        CheckTimer = 3000;

        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        m_creature->SetVisibility(VISIBILITY_ON);

        if(pInstance->GetData(DATA_ATTUMEN_EVENT) != DONE)
            pInstance->SetData(DATA_ATTUMEN_EVENT, NOT_STARTED);
        else
        {
            m_creature->Kill(m_creature, false);
            m_creature->RemoveCorpse();
        }
    }

    void EnterCombat(Unit* who)
    {
        pInstance->SetData(DATA_ATTUMEN_EVENT, IN_PROGRESS);
    }

    void KilledUnit(Unit *victim)
    {
        if (Phase == 2)
            if (Unit *pUnit = Unit::GetUnit(*m_creature, Attumen))
                DoScriptText(SAY_MIDNIGHT_KILL, pUnit);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CheckTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 50.0f))
                EnterEvadeMode();
            else
                DoZoneInCombat();

            CheckTimer = 3000;
        }
        else
            CheckTimer -= diff;

        switch (Phase)
        {
            case 1:
            {
                if ((m_creature->GetHealth()*100)/m_creature->GetMaxHealth() < 95)
                {
                    Phase = 2;
                    Creature *pAttumen = m_creature->SummonCreature(SUMMON_ATTUMEN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 30000); //DoSpawnCreature(SUMMON_ATTUMEN, 0, 0, 0, 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 30000);
                    if (pAttumen)
                    {
                        Attumen = pAttumen->GetGUID();
                        pAttumen->AI()->AttackStart(m_creature->getVictim());
                        SetMidnight(pAttumen, m_creature->GetGUID());

                        DoScriptText(RAND(SAY_APPEAR1, SAY_APPEAR2, SAY_APPEAR3), pAttumen);
                    }
                }
                break;
            }
            case 2:
            {
                if ((m_creature->GetHealth()*100)/m_creature->GetMaxHealth() < 25)
                    if (Unit *pAttumen = Unit::GetUnit(*m_creature, Attumen))
                        Mount(pAttumen);
                break;
            }
            case 3:
            {
                if (Mount_Timer)
                {
                    if (Mount_Timer <= diff)
                    {
                        Mount_Timer = 0;
                        m_creature->SetVisibility(VISIBILITY_OFF);
                        m_creature->GetMotionMaster()->MoveIdle();
                        if (Creature *pAttumen = Unit::GetCreature(*m_creature, Attumen))
                        {
                            pAttumen->SetUInt32Value(UNIT_FIELD_DISPLAYID, MOUNTED_DISPLAYID);
                            pAttumen->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            if (pAttumen->getVictim())
                            {
                                pAttumen->GetMotionMaster()->MoveChase(pAttumen->getVictim());
                                pAttumen->SetSelection(pAttumen->getVictimGUID());
                            }
                            pAttumen->SetFloatValue(OBJECT_FIELD_SCALE_X,1);
                        }
                    }
                    else
                        Mount_Timer -= diff;
                }
                return;
            }
        }

        DoMeleeAttackIfReady();
    }

    void Mount(Unit *pAttumen)
    {
        DoScriptText(SAY_MOUNT, pAttumen);
        Phase = 3;
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        pAttumen->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        float angle = m_creature->GetAngle(pAttumen);
        float distance = m_creature->GetDistance2d(pAttumen);
        float newX = m_creature->GetPositionX() + cos(angle)*(distance/2) ;
        float newY = m_creature->GetPositionY() + sin(angle)*(distance/2) ;
        float newZ = 50;
        //m_creature->Relocate(newX,newY,newZ,angle);
        //m_creature->SendMonsterMove(newX, newY, newZ, 0, true, 1000);
        m_creature->GetMotionMaster()->Clear();
        m_creature->GetMotionMaster()->MovePoint(0, newX, newY, newZ);
        distance += 10;
        newX = m_creature->GetPositionX() + cos(angle)*(distance/2) ;
        newY = m_creature->GetPositionY() + sin(angle)*(distance/2) ;
        pAttumen->GetMotionMaster()->Clear();
        pAttumen->GetMotionMaster()->MovePoint(0, newX, newY, newZ);
        //pAttumen->Relocate(newX,newY,newZ,-angle);
        //pAttumen->SendMonsterMove(newX, newY, newZ, 0, true, 1000);
        Mount_Timer = 1000;
    }

    void SetMidnight(Creature *, uint64);                   //Below ..
};

CreatureAI* GetAI_boss_midnight(Creature *_Creature)
{
    return new boss_midnightAI(_Creature);
}

struct boss_attumenAI : public ScriptedAI
{
    boss_attumenAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        Phase = 1;

        CleaveTimer = urand(10000, 16000);
        CurseTimer = 30000;
        RandomYellTimer = urand(30000, 61000);         //Occasionally yell
        ChargeTimer = 20000;
        ResetTimer = 0;
    }

    ScriptedInstance *pInstance;

    uint64 Midnight;
    uint8 Phase;
    uint32 CleaveTimer;
    uint32 CurseTimer;
    uint32 RandomYellTimer;
    uint32 ChargeTimer;                                     //only when mounted
    uint32 ResetTimer;

    void Reset()
    {
        ResetTimer = 2000;
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_KILL1, SAY_KILL2), m_creature);
    }

    void JustDied(Unit *victim)
    {
        DoScriptText(SAY_DEATH, m_creature);
        if (Unit *pMidnight = Unit::GetUnit(*m_creature, Midnight))
            pMidnight->DealDamage(pMidnight, pMidnight->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);

        pInstance->SetData(DATA_ATTUMEN_EVENT, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (ResetTimer)
        {
            if (ResetTimer <= diff)
            {
                ResetTimer = 0;
                Unit *pMidnight = Unit::GetUnit(*m_creature, Midnight);
                if (pMidnight)
                {
                    pMidnight->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    pMidnight->SetVisibility(VISIBILITY_ON);
                }
                Midnight = 0;
                m_creature->SetVisibility(VISIBILITY_OFF);
                m_creature->DealDamage(m_creature, m_creature->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            }
        }
        else
            ResetTimer -= diff;

        //Return since we have no target
        if (!UpdateVictim())
            return;

        if (m_creature->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE ))
            return;

        if (CleaveTimer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_SHADOWCLEAVE);
            CleaveTimer = urand(10000, 16000);
        }
        else
            CleaveTimer -= diff;

        if (CurseTimer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_INTANGIBLE_PRESENCE);
            CurseTimer = 30000;
        }
        else
            CurseTimer -= diff;

        if (RandomYellTimer < diff)
        {
            DoScriptText(RAND(SAY_RANDOM1, SAY_RANDOM2), m_creature);

            RandomYellTimer = urand(30000, 61000);
        }
        else
            RandomYellTimer -= diff;

        if (m_creature->GetUInt32Value(UNIT_FIELD_DISPLAYID) == MOUNTED_DISPLAYID)
        {
            if (ChargeTimer < diff)
            {
                if (Unit * target = SelectUnit(SELECT_TARGET_RANDOM, 0, 100.0f, true, 0, 5.0f))
                    AddSpellToCast(target, SPELL_BERSERKER_CHARGE);

                ChargeTimer = 20000;
            }
            else
                ChargeTimer -= diff;
        }
        else
        {
            if ((m_creature->GetHealth()*100)/m_creature->GetMaxHealth() < 25)
            {
                Creature *pMidnight = Unit::GetCreature(*m_creature, Midnight);
                if (pMidnight && pMidnight->GetTypeId() == TYPEID_UNIT)
                {
                    ((boss_midnightAI*)(pMidnight->AI()))->Mount(m_creature);
                    m_creature->SetHealth(pMidnight->GetHealth());
                    DoResetThreat();
                }
            }
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }

    void SpellHit(Unit *source, const SpellEntry *spell)
    {
        if (spell->Mechanic == MECHANIC_DISARM)
            DoScriptText(SAY_DISARMED, m_creature);
    }
};

void boss_midnightAI::SetMidnight(Creature *pAttumen, uint64 value)
{
    ((boss_attumenAI*)pAttumen->AI())->Midnight = value;
}

CreatureAI* GetAI_boss_attumen(Creature *_Creature)
{
    return new boss_attumenAI (_Creature);
}

void AddSC_boss_attumen()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_attumen";
    newscript->GetAI = &GetAI_boss_attumen;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_midnight";
    newscript->GetAI = &GetAI_boss_midnight;
    newscript->RegisterSelf();
}
