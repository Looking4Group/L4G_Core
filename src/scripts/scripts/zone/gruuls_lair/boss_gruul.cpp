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
SDName: Boss_Gruul
SD%Complete: 25
SDComment: Ground Slam seriously messed up due to core problem
SDCategory: Gruul's Lair
EndScriptData */

#include "precompiled.h"
#include "def_gruuls_lair.h"

#include "../framework/Utilities/EventProcessor.h"

/* Yells & Quotes */
#define SAY_AGGRO                   -1565010
#define SAY_SLAM1                   -1565011
#define SAY_SLAM2                   -1565012
#define SAY_SHATTER1                -1565013
#define SAY_SHATTER2                -1565014
#define SAY_SLAY1                   -1565015
#define SAY_SLAY2                   -1565016
#define SAY_SLAY3                   -1565017
#define SAY_DEATH                   -1565018
#define EMOTE_GROW                  -1565019
#define EMOTE_SHATTER               -1565020

/* Spells */
#define SPELL_GROWTH                36300
#define SPELL_CAVE_IN               36240
#define SPELL_GROUND_SLAM           33525                   // AoE Ground Slam applying Ground Slam to everyone with a script effect (most likely the knock back, we can code it to a set knockback)
#define SPELL_REVERBERATION         36297                   // AoE Silence
#define SPELL_SHATTER               33654
#define SPELL_SHATTER_EFFECT        33671
#define SPELL_HURTFUL_STRIKE        33813
#define SPELL_STONED                33652                   // Spell is self cast -> linked on ground slam fade
#define SPELL_GRONN_LORDS_GRASP     33572                   // Triggered by Ground Slam

class ChaseEvent : public BasicEvent
{
    public:
        ChaseEvent(uint64 targetGUID, Unit& owner) : _targetGUID(targetGUID), _owner(owner) {};
        virtual ~ChaseEvent() {};

        virtual bool Execute(uint64 e_time, uint32 p_time)
        {
            if (Unit *pTarget = _owner.GetUnit(_targetGUID))
                _owner.GetMotionMaster()->MoveChase(pTarget);

            return true;
        }
        virtual void Abort(uint64 e_time) {}

    private:
        uint64 _targetGUID;
        Unit& _owner;
};

struct boss_gruulAI : public ScriptedAI
{
    boss_gruulAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
        c->GetPosition(wLoc);
    }

    ScriptedInstance *pInstance;

    WorldLocation wLoc;

    uint32 Growth_Timer;
    uint32 CaveIn_Timer;
    uint32 GroundSlamTimer;
    uint32 ShatterTimer;
    uint32 PerformingGroundSlam;
    uint32 HurtfulStrike_Timer;
    uint32 Reverberation_Timer;
    uint32 Check_Timer;
    uint32 CaveInReduce;
    uint8 ReduceCount;

    void Reset()
    {
        Growth_Timer = 30000;
        CaveIn_Timer = 27000;
        GroundSlamTimer = 35000;
        ShatterTimer = 0;
        HurtfulStrike_Timer = 8000;
        Reverberation_Timer = 105000;
        Check_Timer = 3000;
        CaveInReduce = 2000;
        ReduceCount = 0;

        pInstance->SetData(DATA_GRUULEVENT, NOT_STARTED);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, me);
        pInstance->SetData(DATA_GRUULEVENT, DONE);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_AGGRO, me);
        DoZoneInCombat();
        pInstance->SetData(DATA_GRUULEVENT, IN_PROGRESS);
    }

    void KilledUnit()
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2, SAY_SLAY3), me);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        if (Check_Timer < diff)
        {
            if (!me->IsWithinDistInMap(&wLoc, 74.0f))
            {
               EnterEvadeMode();
               return;
            }

            DoZoneInCombat();
            //me->SetSpeed(MOVE_RUN, 2.0f);
            Check_Timer= 3000;
        }
        else
            Check_Timer -= diff;

        // Growth
        // Gruul can cast this spell up to 30 times
        if (Growth_Timer < diff)
        {
            AddSpellToCast(me, SPELL_GROWTH);
            DoScriptText(EMOTE_GROW, me);
            Growth_Timer = 30000;
        }
        else
            Growth_Timer -= diff;

        // Reverberation - timer should expiring even if in ground slam mode
        if (Reverberation_Timer < diff)
        {
            AddSpellToCast(SPELL_REVERBERATION, CAST_NULL);
            Reverberation_Timer = 30000;
        }
        else
            Reverberation_Timer -= diff;

        if (ShatterTimer)
        {
            if (ShatterTimer <= diff)
            {
                me->GetMotionMaster()->Clear();

                Unit *victim = me->getVictim();
                if (victim)
                {
                    // re-chase target after 2 seconds
                    me->m_Events.AddEvent(new ChaseEvent(me->getVictimGUID(), *me), me->m_Events.CalculateTime(2000), true);
                    me->SetSelection(victim->GetGUID());
                }

                HurtfulStrike_Timer = 8000;
                ShatterTimer = 0;

                //The dummy shatter spell is cast
                ForceSpellCastWithScriptText(SPELL_SHATTER, CAST_SELF, RAND(SAY_SHATTER1, SAY_SHATTER2), INTERRUPT_AND_CAST_INSTANTLY);
            }
            else
                ShatterTimer -= diff;

            CastNextSpellIfAnyAndReady();
        }
        else
        {
            // Hurtful Strike
            if (HurtfulStrike_Timer < diff)
            {
                Unit* target = SelectUnit(SELECT_TARGET_TOPAGGRO, 0, me->GetMeleeReach(), true, me->getVictimGUID());
                if (!target)
                    target = me->getVictim();

                AddSpellToCast(target, SPELL_HURTFUL_STRIKE);
                HurtfulStrike_Timer = 8000;
            }
            else
                HurtfulStrike_Timer -= diff;

            // Cave In
            if (CaveIn_Timer < diff)
            {
                if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                    AddSpellToCast(target, SPELL_CAVE_IN);

                CaveIn_Timer = 27000-(ReduceCount*CaveInReduce);
                ReduceCount++;
                if (CaveIn_Timer <= 5000)
                    CaveIn_Timer = 5000;
            }
            else
                CaveIn_Timer -= diff;

            // Ground Slam, Gronn Lord's Grasp, Stoned, Shatter
            if (GroundSlamTimer < diff)
            {
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();
                me->SetSelection(0);

                ShatterTimer = 10000;
                GroundSlamTimer = urand(60000, 65000);

                // is this true ? Oo
                if (Reverberation_Timer < 10000 + ShatterTimer)
                    Reverberation_Timer = 10000 + ShatterTimer;

                DoScriptText(EMOTE_SHATTER, me);
                ForceSpellCastWithScriptText(SPELL_GROUND_SLAM, CAST_SELF, RAND(SAY_SLAM1, SAY_SLAM2));
            }
            else
                GroundSlamTimer -= diff;

            CastNextSpellIfAnyAndReady();
            DoMeleeAttackIfReady();
        }
    }
};

CreatureAI* GetAI_boss_gruul(Creature *_Creature)
{
    return new boss_gruulAI (_Creature);
}

void AddSC_boss_gruul()
{
    Script *newscript;
    newscript           = new Script;
    newscript->Name     = "boss_gruul";
    newscript->GetAI    = &GetAI_boss_gruul;
    newscript->RegisterSelf();
}
