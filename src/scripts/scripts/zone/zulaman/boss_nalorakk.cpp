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
SDName: Boss_Nalorakk
SD%Complete: 100
SDComment:
SDCategory: Zul'Aman
EndScriptData */

#include "precompiled.h"
#include "def_zulaman.h"
#include "GridNotifiers.h"

//Trash Waves
float NalorakkWay[8][3] =
{
    { 18.569, 1414.512, 11.42},// waypoint 1
    {-17.264, 1419.551, 12.62},
    {-52.642, 1419.357, 27.31},// waypoint 2
    {-69.908, 1419.721, 27.31},
    {-79.929, 1395.958, 27.31},
    {-80.072, 1374.555, 40.87},// waypoint 3
    {-80.072, 1314.398, 40.87},
    {-80.072, 1295.775, 48.60} // waypoint 4
};

#define YELL_NALORAKK_WAVE1     -1800472
#define YELL_NALORAKK_WAVE2     -1800473
#define YELL_NALORAKK_WAVE3     -1800474
#define YELL_NALORAKK_WAVE4     -1800475

//Unimplemented SoundIDs
/*
#define SOUND_NALORAKK_EVENT1   12078
#define SOUND_NALORAKK_EVENT2   12079
*/

//General defines
#define YELL_AGGRO              -1800476
#define YELL_KILL_ONE           -1800477
#define YELL_KILL_TWO           -1800478
#define YELL_DEATH              -1800479
#define YELL_BERSERK            -1800480
#define YELL_SURGE              -1800481
#define YELL_SHIFTEDTOTROLL     -1800482
#define YELL_SHIFTEDTOBEAR      -1800483
#define EMOTE_SHIFTEDTOBEAR     -1811005

#define SPELL_BERSERK           45078

//Defines for Troll form
#define SPELL_BRUTALSWIPE       42384
#define SPELL_MANGLE            42389
#define SPELL_MANGLEEFFECT      44955
#define SPELL_SURGE             42402
#define SPELL_BEARFORM          42377

//Defines for Bear form
#define SPELL_LACERATINGSLASH   42395
#define SPELL_RENDFLESH         42397
#define SPELL_DEAFENINGROAR     42398


struct boss_nalorakkAI : public ScriptedAI
{
    boss_nalorakkAI(Creature *c) : ScriptedAI(c)
    {
        MoveEvent = true;
        MovePhase = 0;
        pInstance = (c->GetInstanceData());

        SpellEntry *TempSpell = (SpellEntry*)GetSpellStore()->LookupEntry(SPELL_MANGLE);
        if(TempSpell)
        {
            TempSpell->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ENEMY;
        }
        wLoc.coord_x = NalorakkWay[7][0];
        wLoc.coord_y = NalorakkWay[7][1];
        wLoc.coord_z = NalorakkWay[7][2];
        wLoc.orientation = 0;
        wLoc.mapid = m_creature->GetMapId();
        m_creature->setActive(true);
    }

    ScriptedInstance *pInstance;

    uint32 BrutalSwipe_Timer;
    uint32 Mangle_Timer;
    uint32 Surge_Timer;

    uint32 LaceratingSlash_Timer;
    uint32 RendFlesh_Timer;
    uint32 DeafeningRoar_Timer;

    uint32 ShapeShift_Timer;
    uint32 Berserk_Timer;

    bool inBearForm;
    bool MoveEvent;
    bool inMove;
    uint32 MovePhase;
    uint32 waitTimer;

    uint32 checkTimer;
    WorldLocation wLoc;

    void Reset()
    {
        if(MoveEvent)
        {
            m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            inMove = false;
            waitTimer = 0;
            m_creature->SetSpeed(MOVE_RUN,2);
            m_creature->SetWalk(false);
        }else
        {
            (*m_creature).GetMotionMaster()->MovePoint(0,NalorakkWay[7][0],NalorakkWay[7][1],NalorakkWay[7][2]);
        }

        if(pInstance && pInstance->GetData(DATA_NALORAKKEVENT) != DONE)
            pInstance->SetData(DATA_NALORAKKEVENT, NOT_STARTED);

        Surge_Timer = 15000 + rand()%5000;
        BrutalSwipe_Timer = 7000 + rand()%5000;
        Mangle_Timer = 10000 + rand()%5000;
        ShapeShift_Timer = 45000 + rand()%5000;
        Berserk_Timer = 600000;

        checkTimer = 3000;

        inBearForm = false;
        m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + 1, 5122);
    }

    void SendAttacker(Unit* target)
    {
        std::list<Creature*> templist;
        float x, y, z;
        m_creature->GetPosition(x, y, z);
        {
            Looking4group::AllFriendlyCreaturesInGrid check(m_creature);
            Looking4group::ObjectListSearcher<Creature, Looking4group::AllFriendlyCreaturesInGrid> searcher(templist, check);

            Cell::VisitGridObjects(me, searcher, me->GetMap()->GetVisibilityDistance());
        }

        if(!templist.size())
            return;

        for(std::list<Creature*>::iterator i = templist.begin(); i != templist.end(); ++i)
        {
            if((*i) && m_creature->IsWithinDistInMap((*i),25))
            {
                (*i)->SetNoCallAssistance(true);
                (*i)->AI()->AttackStart(target);
            }
        }
    }

    void AttackStart(Unit* who)
    {
        if(!MoveEvent)
            ScriptedAI::AttackStart(who);
    }

    void OnAuraApply(Aura *aur, Unit *caster, bool stackApply)
    {
        if(aur->GetId() == SPELL_BEARFORM && aur->GetEffIndex() == 0)
        {
            LaceratingSlash_Timer = 2000;               // dur 18s
            RendFlesh_Timer = 3000;                     // dur 5s
            DeafeningRoar_Timer = 5000 + rand()%5000;   // dur 2s
            inBearForm = true;
            DoScriptText(EMOTE_SHIFTEDTOBEAR, m_creature);
            m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + 1, 0);
            ClearCastQueue();
        }
    }

    void OnAuraRemove(Aura *aur, bool stackRemove)
    {
        if(aur->GetId() == SPELL_BEARFORM && aur->GetEffIndex() == 0)
        {
            m_creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + 1, 5122);
            DoScriptText(YELL_SHIFTEDTOTROLL, m_creature);
            Surge_Timer = 15000 + rand()%5000;
            BrutalSwipe_Timer = 7000 + rand()%5000;
            Mangle_Timer = 10000 + rand()%5000;
            ShapeShift_Timer = 45000 + rand()%5000;
            inBearForm = false;
            ClearCastQueue();
        }
    }

    void MoveInLineOfSight(Unit *who)
    {
        if(!MoveEvent)
        {
            ScriptedAI::MoveInLineOfSight(who);
        }
        else
        {
            if(m_creature->IsHostileTo( who ))
            {
                if(!inMove)
                {
                    switch(MovePhase)
                    {
                        case 0:
                            if(m_creature->IsWithinDistInMap(who, 50))
                            {
                                DoScriptText(YELL_NALORAKK_WAVE1, m_creature);

                                (*m_creature).GetMotionMaster()->MovePoint(1,NalorakkWay[1][0],NalorakkWay[1][1],NalorakkWay[1][2]);
                                MovePhase ++;
                                inMove = true;

                                SendAttacker(who);
                            }
                            break;
                        case 2:
                            if(m_creature->IsWithinDistInMap(who, 40))
                            {
                                DoScriptText(YELL_NALORAKK_WAVE2, m_creature);

                                (*m_creature).GetMotionMaster()->MovePoint(3,NalorakkWay[3][0],NalorakkWay[3][1],NalorakkWay[3][2]);
                                MovePhase ++;
                                inMove = true;

                                SendAttacker(who);
                            }
                            break;
                        case 5:
                            if(m_creature->IsWithinDistInMap(who, 40))
                            {
                                DoScriptText(YELL_NALORAKK_WAVE3, m_creature);

                                (*m_creature).GetMotionMaster()->MovePoint(6,NalorakkWay[6][0],NalorakkWay[6][1],NalorakkWay[6][2]);
                                MovePhase ++;
                                inMove = true;

                                SendAttacker(who);
                            }
                            break;
                        case 7:
                            if(m_creature->IsWithinDistInMap(who, 50))
                            {
                                SendAttacker(who);

                                DoScriptText(YELL_NALORAKK_WAVE4, m_creature);

                                m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                                MoveEvent = false;
                            }
                            break;
                    }
                }
            }
        }
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance)
            pInstance->SetData(DATA_NALORAKKEVENT, IN_PROGRESS);

        DoScriptText(YELL_AGGRO, m_creature);
        DoZoneInCombat();
    }

    void JustDied(Unit* Killer)
    {
        if(pInstance)
            pInstance->SetData(DATA_NALORAKKEVENT, DONE);

        DoScriptText(YELL_DEATH, m_creature);
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(RAND(YELL_KILL_ONE, YELL_KILL_TWO), m_creature);
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if(MoveEvent)
        {
            if(type != POINT_MOTION_TYPE)
                return;

            if(!inMove)
                return;

            if(MovePhase != id)
                return;

            switch(MovePhase)
            {
                case 2:
                    m_creature->SetOrientation(3.1415*2);
                    inMove = false;
                    return;
                case 1:
                case 3:
                case 4:
                case 6:
                    MovePhase ++;
                    waitTimer = 1;
                    inMove = true;
                    return;
                case 5:
                    m_creature->SetOrientation(3.1415*0.5);
                    inMove = false;
                    return;
                case 7:
                    m_creature->SetOrientation(3.1415*0.5);
                    m_creature->SetHomePosition(NalorakkWay[7][0], NalorakkWay[7][1], NalorakkWay[7][2], m_creature->GetOrientation());
                    inMove = false;
                    return;
            }

        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(waitTimer)
        {
            if(inMove)
                if(waitTimer < diff)
                {
                    (*m_creature).GetMotionMaster()->MovementExpired();
                    (*m_creature).GetMotionMaster()->MovePoint(MovePhase,NalorakkWay[MovePhase][0],NalorakkWay[MovePhase][1],NalorakkWay[MovePhase][2]);
                    waitTimer = 0;
                }else 
                    waitTimer -= diff;
        }

        if(!UpdateVictim())
            return;

        if (checkTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 75) && !MoveEvent)
                EnterEvadeMode();
            else
                DoZoneInCombat();
            m_creature->SetSpeed(MOVE_RUN,2);
            checkTimer = 3000;
        }
        else
            checkTimer -= diff;

        if(Berserk_Timer < diff)
        {
            AddSpellToCastWithScriptText(m_creature, SPELL_BERSERK, YELL_BERSERK, true);
            Berserk_Timer = 600000;
        }else 
            Berserk_Timer -= diff;

        if(!inBearForm)
        {
            if(BrutalSwipe_Timer < diff)
            {
                AddSpellToCast(m_creature->getVictim(), SPELL_BRUTALSWIPE);
                BrutalSwipe_Timer = 7000 + rand()%5000;
            }else 
                BrutalSwipe_Timer -= diff;

            if(Mangle_Timer < diff)
            {
                if(m_creature->getVictim() && !m_creature->getVictim()->HasAura(SPELL_MANGLEEFFECT, 0))
                {
                    AddSpellToCast(m_creature->getVictim(), SPELL_MANGLE);
                    Mangle_Timer = 1000;
                }
                else 
                    Mangle_Timer = 10000 + rand()%5000;
            }else 
                Mangle_Timer -= diff;

            if(Surge_Timer < diff)
            {
                if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 1, GetSpellMaxRange(SPELL_SURGE), true, m_creature->getVictimGUID()))
                    AddSpellToCastWithScriptText(target, SPELL_SURGE, YELL_SURGE);
                Surge_Timer = 15000 + rand()%5000;
            }else 
                Surge_Timer -= diff;

            if(ShapeShift_Timer)
            {
                if(ShapeShift_Timer <= diff)
                {
                    AddSpellToCastWithScriptText(m_creature, SPELL_BEARFORM, YELL_SHIFTEDTOBEAR, true);
                    ShapeShift_Timer = 0;
                }else 
                    ShapeShift_Timer -= diff;
            }
        }
        else
        {
            if(LaceratingSlash_Timer < diff)
            {
                AddSpellToCast(m_creature->getVictim(), SPELL_LACERATINGSLASH);
                LaceratingSlash_Timer = 18000 + rand()%5000;
            }else
                LaceratingSlash_Timer -= diff;

            if(RendFlesh_Timer < diff)
            {
                AddSpellToCast(m_creature->getVictim(), SPELL_RENDFLESH);
                RendFlesh_Timer = 5000 + rand()%5000;
            }else
                RendFlesh_Timer -= diff;

            if(DeafeningRoar_Timer < diff)
            {
                AddSpellToCast(m_creature->getVictim(), SPELL_DEAFENINGROAR);
                DeafeningRoar_Timer = 15000 + rand()%5000;
            }else
                DeafeningRoar_Timer -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_nalorakk(Creature *_Creature)
{
    return new boss_nalorakkAI (_Creature);
}

void AddSC_boss_nalorakk()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_nalorakk";
    newscript->GetAI = &GetAI_boss_nalorakk;
    newscript->RegisterSelf();
}

