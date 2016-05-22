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
SDName: Arcatraz
SD%Complete: 90
SDComment:
SDCategory: Tempest Keep, The Arcatraz
EndScriptData */

/* ContentData
npc_millhouse_manastorm
npc_warden_mellichar
mob_zerekethvoidzone
EndContentData */

#include "precompiled.h"
#include "def_arcatraz.h"

/*#####
# npc_millhouse_manastorm
#####*/

#define SAY_INTRO_1                 -1552010
#define SAY_INTRO_2                 -1552011
#define SAY_WATER                   -1552012
#define SAY_BUFFS                   -1552013
#define SAY_DRINK                   -1552014
#define SAY_READY                   -1552015
#define SAY_KILL_1                  -1552016
#define SAY_KILL_2                  -1552017
#define SAY_PYRO                    -1552018
#define SAY_ICEBLOCK                -1552019
#define SAY_LOWHP                   -1552020
#define SAY_DEATH                   -1552021
#define SAY_COMPLETE                -1552022

#define SPELL_CONJURE_WATER         36879
#define SPELL_ARCANE_INTELLECT      36880
#define SPELL_ICE_ARMOR             36881

#define SPELL_ARCANE_MISSILES       33833
#define SPELL_CONE_OF_COLD          12611
#define SPELL_FIRE_BLAST            13341
#define SPELL_FIREBALL              14034
#define SPELL_FROSTBOLT             15497
#define SPELL_PYROBLAST             33975

struct npc_millhouse_manastormAI : public ScriptedAI
{
    npc_millhouse_manastormAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 EventProgress_Timer;
    uint32 Phase;
    bool Init;
    bool LowHp;

    uint32 Pyroblast_Timer;
    uint32 Fireball_Timer;

    void Reset()
    {
        EventProgress_Timer = 2000;
        LowHp = false;
        Init = false;
        Phase = 1;

        Pyroblast_Timer = 1000;
        Fireball_Timer = 2500;

        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2);

        if( pInstance )
        {
            if( pInstance->GetData(TYPE_WARDEN_2) == DONE )
                Init = true;

            if( pInstance->GetData(TYPE_HARBINGERSKYRISS) == DONE )
            {
                DoScriptText(SAY_COMPLETE, me);
                me->ForcedDespawn(20000);
            }
        }
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if (type != POINT_MOTION_TYPE)
            return;

        me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 4.8f);
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_KILL_1, SAY_KILL_2), me);
    }

    void JustDied(Unit *victim)
    {
        DoScriptText(SAY_DEATH, me);

        /*for questId 10886 (heroic mode only)
        if( pInstance && pInstance->GetData(TYPE_HARBINGERSKYRISS) != DONE )
            ->FailQuest();*/
    }

    void UpdateAI(const uint32 diff)
    {
        if( !Init )
        {
            if( EventProgress_Timer < diff )
            {
                if( Phase < 8 )
                {
                    switch( Phase )
                    {
                        case 1:
                            DoScriptText(SAY_INTRO_1, me);
                            EventProgress_Timer = 18000;
                            break;
                        case 2:
                            DoScriptText(SAY_INTRO_2, me);
                            EventProgress_Timer = 18000;
                            break;
                        case 3:
                            if( pInstance )
                                pInstance->SetData(TYPE_WARDEN_2,DONE);
                            EventProgress_Timer = 7000;
                            break;
                        case 4:
                            DoScriptText(SAY_WATER, me);
                            DoCast(me,SPELL_CONJURE_WATER);
                            EventProgress_Timer = 10000;
                            break;
                        case 5:
                            DoScriptText(SAY_BUFFS, me);
                            DoCast(me,SPELL_ICE_ARMOR);
                            EventProgress_Timer = 10000;
                            break;
                        case 6:
                             DoScriptText(SAY_DRINK, me);
                            DoCast(me,SPELL_ARCANE_INTELLECT);
                            EventProgress_Timer = 7000;
                            break;
                        case 7:
                            DoScriptText(SAY_READY, me);
                            Init = true;
                            break;
                    }
                    ++Phase;
                }
            } else EventProgress_Timer -= diff;
        }

        if( !UpdateVictim() )
            return;

        if( !LowHp && ((me->GetHealth()*100 / me->GetMaxHealth()) < 20) )
        {
            DoScriptText(SAY_LOWHP, me);
            LowHp = true;
        }

        if( Pyroblast_Timer < diff )
        {
            if( me->IsNonMeleeSpellCasted(false) )
                return;

             DoScriptText(SAY_PYRO, me);

            DoCast(me->getVictim(),SPELL_PYROBLAST);
            Pyroblast_Timer = 40000;
        }else Pyroblast_Timer -=diff;

        if( Fireball_Timer < diff )
        {
            DoCast(me->getVictim(),SPELL_FIREBALL);
            Fireball_Timer = 4000;
        }else Fireball_Timer -=diff;

        //DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_millhouse_manastorm(Creature *_Creature)
{
    return new npc_millhouse_manastormAI (_Creature);
}

/*#####
# npc_warden_mellichar
#####*/

#define YELL_INTRO1         -1552023
#define YELL_INTRO2         -1552024
#define YELL_RELEASE1       -1552025
#define YELL_RELEASE2A      -1552026
#define YELL_RELEASE2B      -1552027
#define YELL_RELEASE3       -1552028
#define YELL_RELEASE4       -1552029
#define YELL_WELCOME        -1552030

//phase 2(acid mobs)
#define ENTRY_TRICKSTER     20905
#define ENTRY_PH_HUNTER     20906
//phase 3
#define ENTRY_MILLHOUSE     20977
//phase 4(acid mobs)
#define ENTRY_AKKIRIS       20908
#define ENTRY_SULFURON      20909
//phase 5(acid mobs)
#define ENTRY_TW_DRAK       20910
#define ENTRY_BL_DRAK       20911
//phase 6
#define ENTRY_SKYRISS       20912

//TARGET_SCRIPT
#define SPELL_TARGET_ALPHA  36856
#define SPELL_TARGET_BETA   36854
#define SPELL_TARGET_DELTA  36857
#define SPELL_TARGET_GAMMA  36858
#define SPELL_TARGET_OMEGA  36852
#define SPELL_BUBBLE_VISUAL 36849

#define SPELL_ETHEREAL_TELEPORT 34427

struct npc_warden_mellicharAI : public ScriptedAI
{
    npc_warden_mellicharAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    bool IsRunning;
    bool CanSpawn;

    uint32 EventProgress_Timer;
    uint32 Phase;

    void Reset()
    {
        IsRunning = false;
        CanSpawn = false;

        EventProgress_Timer = 22000;
        Phase = 1;

        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        DoCast(me,SPELL_TARGET_OMEGA);

        if( pInstance && !(pInstance->GetData(TYPE_HARBINGERSKYRISS) == DONE))
            pInstance->SetData(TYPE_HARBINGERSKYRISS,NOT_STARTED);
        if(Unit* millhouse = (Unit*)FindCreature(ENTRY_MILLHOUSE, 100, me))
            millhouse->ToCreature()->ForcedDespawn(0);
    }

    void AttackStart(Unit* who) {}

    void MoveInLineOfSight(Unit *who)
    {
        if( IsRunning )
            return;

        if( !me->getVictim() && who->isTargetableForAttack() && ( me->IsHostileTo( who )) && who->isInAccessiblePlacefor(me) )
        {
            if (!me->CanFly() && me->GetDistanceZ(who) > CREATURE_Z_ATTACK_RANGE)
                return;
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            float attackRadius = me->GetAttackDistance(who)/10;
            if( me->IsWithinDistInMap(who, attackRadius) && me->IsWithinLOSInMap(who) )
                EnterCombat(who);
        }
    }

    void EnterCombat(Unit *who)
    {
        if (!IsRunning)
        {
            DoScriptText(YELL_INTRO1, me);
            DoCast(me,SPELL_BUBBLE_VISUAL);
        }

        if( pInstance )
        {
            pInstance->HandleGameObject(pInstance->GetData64(DATA_SPHERE_SHIELD),false);
            IsRunning = true;
        }
    }

    bool CanProgress()
    {
        if( pInstance )
        {
            if( Phase == 7 && pInstance->GetData(TYPE_WARDEN_4) == DONE )
                return true;
            if( Phase == 6 && pInstance->GetData(TYPE_WARDEN_3) == DONE )
                return true;
            if( Phase == 5 && pInstance->GetData(TYPE_WARDEN_2) == DONE )
                return true;
            if( Phase == 4 || Phase == 1 || Phase == 2)
                return true;
            if( Phase == 3 && pInstance->GetData(TYPE_WARDEN_1) == DONE )
                return true;
            return false;
        }
        return false;
    }

    void DoPrepareForPhase()
    {
        if( pInstance )
        {
            me->InterruptNonMeleeSpells(true);
            me->RemoveSpellsCausingAura(SPELL_AURA_DUMMY);

            switch( Phase )
            {
                case 2:
                    DoCast(me,SPELL_TARGET_ALPHA);
                    pInstance->HandleGameObject(pInstance->GetData64(DATA_POD_A),true);
                    break;
                case 3:
                    DoCast(me,SPELL_TARGET_BETA);
                    pInstance->HandleGameObject(pInstance->GetData64(DATA_POD_B),true);
                    break;
                case 5:
                    DoCast(me,SPELL_TARGET_DELTA);
                    pInstance->HandleGameObject(pInstance->GetData64(DATA_POD_D),true);
                    break;
                case 6:
                    DoCast(me,SPELL_TARGET_GAMMA);
                    pInstance->HandleGameObject(pInstance->GetData64(DATA_POD_G),true);
                    break;
                case 7:
                    pInstance->HandleGameObject(pInstance->GetData64(DATA_POD_O),true);
                    pInstance->SetData(TYPE_HARBINGERSKYRISS,IN_PROGRESS);
                    break;
            }
            CanSpawn = true;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if( !IsRunning )
            return;

        if( EventProgress_Timer < diff )
        {
            if( pInstance )
            {
                if( pInstance->GetData(TYPE_HARBINGERSKYRISS) == FAIL )
                    Reset();
            }

            if( CanSpawn )
            {
                //continue beam omega pod, unless we are about to summon skyriss
                if( Phase != 7 )
                    DoCast(me,SPELL_TARGET_OMEGA);

                switch( Phase )
                {
                    case 2:
                        if (Creature* temp = me->SummonCreature(RAND(ENTRY_TRICKSTER, ENTRY_PH_HUNTER), 478.326, -148.505, 42.56, 3.19, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000))
                            temp->CastSpell(temp, SPELL_ETHEREAL_TELEPORT, false);
                        break;
                    case 3:
                        if (Creature* temp = me->SummonCreature(ENTRY_MILLHOUSE,413.292,-148.378,42.56,6.27,TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,600000))
                        {
                            temp->CastSpell(temp, SPELL_ETHEREAL_TELEPORT, false);
                            temp->SetReactState(REACT_PASSIVE);
                        }
                        break;
                    case 4:
                        DoScriptText(YELL_RELEASE2B, me);
                        break;
                    case 5:
                        if (Creature* temp = me->SummonCreature(RAND(ENTRY_AKKIRIS, ENTRY_SULFURON), 420.179, -174.396, 42.58, 0.02, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000))
                           temp->CastSpell(temp, SPELL_ETHEREAL_TELEPORT, false);
                        break;
                    case 6:
                        if (Creature* temp = me->SummonCreature(RAND(ENTRY_TW_DRAK,ENTRY_BL_DRAK), 471.795, -174.58, 42.58, 3.06, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000))
                            temp->CastSpell(temp, SPELL_ETHEREAL_TELEPORT, false);

                        if (Creature* millhouse = GetClosestCreatureWithEntry(me, ENTRY_MILLHOUSE, 100))
                        {
                            millhouse->SetWalk(true);
                            millhouse->GetMotionMaster()->MovePoint(0, 445.55f, -157.658f, 43.06f);
                        }
                        break;
                    case 7:
                        if (Creature* temp = me->SummonCreature(ENTRY_SKYRISS,445.763,-191.639,44.64,1.60,TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,600000))
                            temp->CastSpell(temp, SPELL_ETHEREAL_TELEPORT, false);
                        DoScriptText(YELL_WELCOME, me);
                        break;
                }
                CanSpawn = false;
                ++Phase;
            }
            if( CanProgress() )
            {
                switch( Phase )
                {
                    case 1:
                        DoScriptText(YELL_INTRO2, me);
                        EventProgress_Timer = 10000;
                        ++Phase;
                        break;
                    case 2:
                        DoScriptText(YELL_RELEASE1, me);
                        DoPrepareForPhase();
                        EventProgress_Timer = 7000;
                        break;
                    case 3:
                        DoScriptText(YELL_RELEASE2A, me);
                        DoPrepareForPhase();
                        EventProgress_Timer = 10000;
                        break;
                    case 4:
                        DoPrepareForPhase();
                        EventProgress_Timer = 15000;
                        break;
                    case 5:
                        DoScriptText(YELL_RELEASE3, me);
                        DoPrepareForPhase();
                        EventProgress_Timer = 15000;
                        break;
                    case 6:
                        DoScriptText(YELL_RELEASE4, me);
                        DoPrepareForPhase();
                        EventProgress_Timer = 15000;
                        break;
                    case 7:
                        DoPrepareForPhase();
                        EventProgress_Timer = 15000;
                        break;
                }
            }
        } else EventProgress_Timer -= diff;
    }
};

CreatureAI* GetAI_npc_warden_mellichar(Creature *_Creature)
{
    return new npc_warden_mellicharAI (_Creature);
}

/*######
## npc_felfire_wave
######*/

#define SPELL_FELFIRE          35769

struct npc_felfire_waveAI : public ScriptedAI
{
    npc_felfire_waveAI(Creature* c) : ScriptedAI(c) {}

    uint32 Burn;

    void IsSummonedBy(Unit *summoner)
    {
        Burn = 0;
        float x, y, z;
        me->SetSpeed(MOVE_RUN, 1.1);
        me->GetNearPoint(x, y, z, 0, 20, summoner->GetAngle(me));
        me->UpdateAllowedPositionZ(x, y, z);
        me->GetMotionMaster()->MovePoint(1, x, y, z);
    }

    void AttackStart(Unit* who) {}

    void MovementInform(uint32 type, uint32 id)
    {
        if (type != POINT_MOTION_TYPE || id != 1)
            return;

        me->ForcedDespawn(5000);
    }

    void UpdateAI(const uint32 diff)
    {
        if(Burn < diff)
        {
            DoCast(me, SPELL_FELFIRE, true);
            Burn = 450;
        }
        else
            Burn -= diff;
    }
};

CreatureAI* GetAI_npc_felfire_wave(Creature* _Creature)
{
    return new npc_felfire_waveAI(_Creature);
}

#define SPELL_AURA   (HeroicMode ? 38828 : 36716)

struct npc_arcatraz_sentinelAI : public ScriptedAI
{
    npc_arcatraz_sentinelAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        HeroicMode = me->GetMap()->IsHeroic();
    }

    uint32 Reset_Timer;

    ScriptedInstance *pInstance;
    bool HeroicMode;

    void Reset()
    {
        me->SetUInt32Value(UNIT_DYNAMIC_FLAGS, 32);
        me->SetUInt32Value(UNIT_FIELD_BYTES_1, 7);
        DoCast(me, SPELL_AURA);
        Reset_Timer = 10000;
    }

    void EnterCombat(Unit *who)
    {
        me->SetUInt32Value(UNIT_DYNAMIC_FLAGS, 0);
        me->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
        uint32 hp = (me->GetMaxHealth()*40)/100;
        if (hp)
            me->SetHealth(hp);
    }

    void JustDied(Unit *killer) 
    {
        //Hack to let quests update .. in gm mode one kill will count as two now
        if (killer->GetTypeId() == TYPEID_PLAYER)
            killer->ToPlayer()->RewardPlayerAndGroupAtKill(me);
    }

    void EnterEvadeMode()
    {
        me->RemoveAllAuras();
        me->DeleteThreatList();
        me->CombatStop();
        
        if (!me->isAlive())
            return;    

        me->GetMotionMaster()->MoveTargetedHome();
    }

    void JustReachedHome()
    {
        Reset();
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if( Reset_Timer < diff )
        {
            DoResetThreat();
            Reset_Timer = 10000;

        }else Reset_Timer -=diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_arcatraz_sentinel(Creature *_Creature)
{
    return new npc_arcatraz_sentinelAI (_Creature);
}

#define SPELL_SUMMON   36593

struct npc_warder_corpseAI : public ScriptedAI
{
    npc_warder_corpseAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    bool summon;

    void Reset()
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        me->SetUInt32Value(UNIT_DYNAMIC_FLAGS, 32);
        me->SetUInt32Value(UNIT_FIELD_BYTES_1, 7);
        summon = false;
    }

    void EnterCombat(Unit *who) {}
    void AttackStart(Unit* who) {}

    void MoveInLineOfSight(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER && me->IsWithinMeleeRange(who) && !summon) //no GM support they fail last days :P
        {
            DoCast(me, SPELL_SUMMON, true);
            summon = true;
        }
    }
};

CreatureAI* GetAI_npc_warder_corpse(Creature *_Creature)
{
    return new npc_warder_corpseAI (_Creature);
}

void AddSC_arcatraz()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_millhouse_manastorm";
    newscript->GetAI = &GetAI_npc_millhouse_manastorm;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_warden_mellichar";
    newscript->GetAI = &GetAI_npc_warden_mellichar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_felfire_wave";
    newscript->GetAI = &GetAI_npc_felfire_wave;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="arcatraz_sentinel";
    newscript->GetAI = &GetAI_npc_arcatraz_sentinel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="warder_corpse";
    newscript->GetAI = &GetAI_npc_warder_corpse;
    newscript->RegisterSelf();
}

