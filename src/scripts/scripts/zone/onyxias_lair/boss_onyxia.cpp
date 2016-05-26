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
SDName: Boss_Onyxia
SD%Complete: 90
SDComment: Spell Heated Ground is wrong, flying animation, visual for area effect
SDCategory: Onyxia's Lair
EndScriptData */

#include "precompiled.h"
#include "def_onyxia_lair.h"

#define SAY_AGGRO                   -1249000
#define SAY_KILL                    -1249001
#define SAY_PHASE_2_TRANS           -1249002
#define SAY_PHASE_3_TRANS           -1249003
#define EMOTE_BREATH                -1249004

enum OnyxiaSpells
{
    // Phase 1 & 3
    SPELL_FLAMEBREATH           = 18435,
    SPELL_CLEAVE                = 19983, // find correct id
    SPELL_WINGBUFFET            = 18500,
    SPELL_TAILSWEEP             = 15847,
    SPELL_KNOCK_AWAY            = 19633, // this prob too

    // Phase 2
    SPELL_SUMMONWHELP           = 17646,
    SPELL_FIREBALL              = 18392,
    SPELL_DEEPBREATH            = 23461,

    // Phase 3
    SPELL_BELLOWINGROAR         = 18431,

    // Whelp Spell
    SPELL_PYROBLAST             = 20228
};


#define SPELL_ENGULFINGFLAMES   20019
#define CREATURE_WHELP          11262
#define NPC_ONYXIAN_WARDER      12129

struct Position;
enum SpawnDefinitions;
extern cPosition spawnEntrancePoints[MAX];

static cPosition center = {-24.8694, -214.071, -89.246};

static cPosition flyLocations[] =
{
    {-65.5955, -222.839, -84.3624},
    {-48.26, -196.624, -86.1145},
    {-12.4892, -213.19, -88.0036},
    {20.0359, -216.578, -85.3187},
    {-66.6432, -214.359, -84.2238}
};

enum PhaseMask
{
    PHASE_1 = 0x01,
    PHASE_2 = 0x02,
    PHASE_3 = 0x04
};

struct boss_onyxiaAI : public ScriptedAI
{
    boss_onyxiaAI(Creature* c) : ScriptedAI(c)
    {
        pInstance = (ScriptedInstance *)c->GetInstanceData();
    }

    ScriptedInstance *pInstance;

    uint32 m_phaseMask;

    uint32 m_rangeCheckTimer;
    uint32 m_flameBreathTimer;
    uint32 m_cleaveTimer;
    uint32 m_tailSweepTimer;
    uint32 m_knockBackTimer;
    uint32 m_wingBuffetTimer;

    uint32 m_summonWhelpsTimer;

    uint32 m_eruptionTimer;
    uint32 m_eruption;
    uint32 m_fearTimer;

    uint32 m_nextWay;
    uint32 m_nextMoveTimer;

    void Fly()
    {
        if (m_creature->IsLevitating())
        {
            m_creature->SendMeleeAttackStart(m_creature->getVictim());
            m_creature->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
            m_creature->SetLevitate(false);
            DoStartMovement(m_creature->getVictim());
        }
        else
        {
            m_creature->SendMeleeAttackStop(m_creature->getVictim());
            m_creature->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
            m_creature->SetLevitate(true);
        }
    }

    void DoMeleeAttackIfReady()
    {
        if(me->hasUnitState(UNIT_STAT_CASTING))
            return;

        if (m_phaseMask & PHASE_2)
        {
            if (!m_nextWay || m_nextWay == 6)
                return;

            m_creature->SendMeleeAttackStop(m_creature->getVictim());
            DoCast(m_creature->getVictim(), SPELL_FIREBALL);
            m_creature->getThreatManager().modifyThreatPercent(m_creature->getVictim(), 100);
        }
        else
        {
            //Make sure our attack is ready and we aren't currently casting before checking distance
            if (me->isAttackReady())
            {
                //If we are within range melee the target
                if (me->IsWithinMeleeRange(me->getVictim()))
                {
                    me->AttackerStateUpdate(me->getVictim());
                    me->resetAttackTimer();
                }
            }
            if (me->haveOffhandWeapon() && me->isAttackReady(OFF_ATTACK))
            {
                //If we are within range melee the target
                if (me->IsWithinMeleeRange(me->getVictim()))
                {
                    me->AttackerStateUpdate(me->getVictim(), OFF_ATTACK);
                    me->resetAttackTimer(OFF_ATTACK);
                }
            }
        }
    }

    void Reset()
    {
        m_creature->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
        m_creature->SetUInt32Value(UNIT_FIELD_BYTES_1, 3); // Lie animation
        if (pInstance)
            pInstance->SetData(DATA_ONYXIA, NOT_STARTED);

        m_creature->SetLevitate(false);
        m_phaseMask = PHASE_1;

        m_nextWay = 0;
        m_nextMoveTimer = 0;

        m_rangeCheckTimer = 3000;
        m_flameBreathTimer = 20000;
        m_cleaveTimer = 8000;
        m_tailSweepTimer = 5000;
        m_knockBackTimer = 15000;
        m_wingBuffetTimer = 12000;

        m_summonWhelpsTimer = 10000;

        m_eruption = 20;
        m_eruptionTimer = 12000;
        m_fearTimer = 10000;
    }

    void EnterCombat(Unit* who)
    {
        m_creature->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
        DoScriptText(SAY_AGGRO, m_creature);
        DoZoneInCombat();

        std::list<Creature*> warders = FindAllCreaturesWithEntry(NPC_ONYXIAN_WARDER, 200.0f);

        for (std::list<Creature*>::iterator i = warders.begin(); i != warders.end(); ++i)
            if (!(*i)->isAlive())
            {
                (*i)->setDeathState(DEAD);
                (*i)->Respawn();
            }

        if (pInstance)
            pInstance->SetData(DATA_ONYXIA, IN_PROGRESS);
    }

    void JustDied(Unit* Killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_ONYXIA, DONE);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(SAY_KILL, m_creature);
    }

    void UpdatePhase()
    {
        switch (m_phaseMask)
        {
            case PHASE_1:
                if ((m_creature->GetHealth()*100/m_creature->GetMaxHealth()) < 60.0f)
                {
                    m_phaseMask = PHASE_2;
                    DoScriptText(SAY_PHASE_2_TRANS, m_creature);
                    m_creature->GetMotionMaster()->MovePoint(0, center.x, center.y, center.z);
                }
                break;
            case PHASE_2:
                if ((m_creature->GetHealth()*100/m_creature->GetMaxHealth()) < 30.0f)
                {
                    m_phaseMask = PHASE_1 | PHASE_3;
                    DoScriptText(SAY_PHASE_3_TRANS, m_creature);
                    m_creature->GetMotionMaster()->MovePoint(1, center.x, center.y, center.z);
                }
                break;
            default:
                break;
        }
    }

    void MovementInform(uint32 type, uint32 i)
    {
        if (type != POINT_MOTION_TYPE)
            return;

        switch (i)
        {
            // Phase Change
            case 0:
                m_nextWay = 2;
                m_nextMoveTimer = 3000;
                if (pInstance)
                    pInstance->SetData(DATA_HATCH_EGGS, 7);
            case 1:
                Fly();
                break;
            // Random Movements in phase 2
            case 2:
            case 3:
            case 4:
                m_nextWay = i + 1;
                m_nextMoveTimer = irand(12, 24)*1000;
                break;
            // Deep Breath
            case 5:
                m_nextWay = i + 1;
                m_nextMoveTimer = 2500;
                //DoTextEmote("Onyxia takes in a deep breath...", NULL, true);//DoScriptText(EMOTE_BREATH, m_creature);
                m_creature->SendMeleeAttackStop(m_creature->getVictim());
                DoCast(m_creature, SPELL_DEEPBREATH);
                m_creature->SetSpeed(MOVE_RUN, 2.5f);
                break;
            case 6:
                m_nextWay = 2;
                m_nextMoveTimer = 2000;
                m_creature->SetSpeed(MOVE_RUN, 1.0f);
                break;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVADE_CHECK, 75.0f);

        UpdatePhase();

        if (m_rangeCheckTimer < diff)
        {
            Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();

            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                if (Player* plr = i->getSource())
                    if (plr->isAlive() && !plr->isGameMaster() && !plr->IsWithinDistInMap(me, 100.0f))
                        plr->TeleportTo(me->GetMapId(), me->GetPositionX(), me->GetPositionY(),
                            me->GetPositionZ(), plr->GetOrientation(), TELE_TO_NOT_LEAVE_COMBAT);

            m_rangeCheckTimer = 3000;
        }
        else
            m_rangeCheckTimer -= diff;

        if (m_phaseMask & PHASE_1)
        {
            if (m_flameBreathTimer < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_FLAMEBREATH);
                m_flameBreathTimer = irand(16, 28) * 1000;
            }
            else
                m_flameBreathTimer -= diff;

            if (m_cleaveTimer < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_CLEAVE);
                m_cleaveTimer = irand(4, 10) * 1000;
            }
            else
                m_cleaveTimer -= diff;

            if (m_tailSweepTimer < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_TAILSWEEP);
                m_tailSweepTimer = irand(6, 14) * 1000;
            }
            else
                m_tailSweepTimer -= diff;

            if (m_knockBackTimer < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_KNOCK_AWAY);
                m_knockBackTimer = irand(22, 32) * 1000;
            }
            else
                m_knockBackTimer -= diff;

            if (m_wingBuffetTimer < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_WINGBUFFET);
                m_wingBuffetTimer = irand(24, 36) * 1000;
            }
            else
                m_wingBuffetTimer -= diff;
        }

        if (m_phaseMask & PHASE_3)
        {
            if (m_eruptionTimer < diff)
            {
                if (pInstance)
                    pInstance->SetData(DATA_ERUPT, 0);
                if ((m_eruption -= 3) == 2)
                    m_eruption = 20;
                m_eruptionTimer = m_eruption * 500;
            }
            else
                m_eruptionTimer -= diff;

            if (m_fearTimer < diff)
            {
                m_fearTimer = irand(10, 30) * 1000;
                DoCast(m_creature->getVictim(), SPELL_BELLOWINGROAR);
            }
            else
                m_fearTimer -= diff;
        }

        if (m_phaseMask & PHASE_2)
        {
            if (m_nextWay)
            {
                if (m_nextMoveTimer < diff)
                {
                    m_creature->InterruptNonMeleeSpells(false);
                    m_creature->GetMotionMaster()->MovePoint(m_nextWay, flyLocations[m_nextWay-2].x, flyLocations[m_nextWay-2].y, flyLocations[m_nextWay-2].z);
                    m_nextWay = 0;
                }
                else
                    m_nextMoveTimer -= diff;
            }
        }

        if (m_phaseMask & (PHASE_3 | PHASE_2))
        {
            if (m_summonWhelpsTimer < diff)
            {
                if (pInstance)
                    pInstance->SetData(DATA_HATCH_EGGS, 2);
                m_summonWhelpsTimer = irand(18, 24) * 1000;
                if (m_phaseMask & PHASE_3)
                    m_summonWhelpsTimer *= 2.0;
            }
            else
                m_summonWhelpsTimer -= diff;
        }
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_onyxiaAI(Creature *_Creature)
{
    return new boss_onyxiaAI (_Creature);
}

struct mob_onyxiawhelpAI : public ScriptedAI
{
    mob_onyxiawhelpAI(Creature* c) : ScriptedAI(c) {}

    uint32 m_pyroblastTimer;

    void Reset()
    {
        m_pyroblastTimer = irand(2, 8)*1000;
        if (!UpdateVictim())
        {
            uint32 moveTo = RIGHT;
            if (m_creature->GetDistance2d(spawnEntrancePoints[LEFT].x, spawnEntrancePoints[LEFT].y) < m_creature->GetDistance2d(spawnEntrancePoints[RIGHT].x, spawnEntrancePoints[RIGHT].y))
                moveTo = LEFT;

            m_creature->GetMotionMaster()->MovePoint(0, spawnEntrancePoints[moveTo].x, spawnEntrancePoints[moveTo].y, spawnEntrancePoints[moveTo].z);
        }
    }

    void MovementInform(uint32 type, uint32 i)
    {
        if (type != POINT_MOTION_TYPE)
            return;

        switch (i)
        {
            case 0:
            DoZoneInCombat();
            break;
        }
    }

    void EnterCombat(Unit* who)
    {
        DoZoneInCombat();
    }

    void JustDied(Unit* Killer) {}

    void KilledUnit(Unit *victim) {}

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if (m_pyroblastTimer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_PYROBLAST);
            m_pyroblastTimer = 6000 + irand(0, 6)*1000;
        }
        else
            m_pyroblastTimer -= diff;
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_onyxiawhelpAI(Creature *_Creature)
{
    return new mob_onyxiawhelpAI (_Creature);
}

void AddSC_boss_onyxia()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_onyxia";
    newscript->GetAI = &GetAI_boss_onyxiaAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_onyxia_whelp";
    newscript->GetAI = &GetAI_mob_onyxiawhelpAI;
    newscript->RegisterSelf();
}

