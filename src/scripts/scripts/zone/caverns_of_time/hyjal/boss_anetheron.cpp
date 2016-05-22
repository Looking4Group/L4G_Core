
#include "precompiled.h"
#include "def_hyjal.h"
#include "hyjal_trash.h"

#define SPELL_CARRION_SWARM 31306
#define SPELL_SLEEP 31298
#define SPELL_VAMPIRIC_AURA 31317
#define SPELL_INFERNO 31299

#define SAY_ONDEATH "The clock... is still... ticking."
#define SOUND_ONDEATH 10982

#define SAY_ONSLAY1 "Your hopes are lost!"
#define SAY_ONSLAY2 "Scream for me!"
#define SAY_ONSLAY3 "Pity, no time for a slow death!"
#define SOUND_ONSLAY1 10981
#define SOUND_ONSLAY2 11038
#define SOUND_ONSLAY3 11039

#define SAY_SWARM1 "The swarm is eager to feed!"
#define SAY_SWARM2 "Pestilence upon you!"
#define SOUND_SWARM1 10979
#define SOUND_SWARM2 11037

#define SAY_SLEEP1 "You look tired..."
#define SAY_SLEEP2 "Sweet dreams..."
#define SOUND_SLEEP1 10978
#define SOUND_SLEEP2 11545

#define SAY_INFERNO1 "Let fire rain from above!"
#define SAY_INFERNO2 "Earth and sky shall burn!"
#define SOUND_INFERNO1 10980
#define SOUND_INFERNO2 11036

#define SAY_ONAGGRO "You are defenders of a doomed world! Flee here, and perhaps you will prolong your pathetic lives!"
#define SOUND_ONAGGRO 10977

struct boss_anetheronAI : public hyjal_trashAI
{
    boss_anetheronAI(Creature *c) : hyjal_trashAI(c)
    {
        pInstance = (c->GetInstanceData());
        go = false;
        pos = 0;
    }

    uint32 SwarmTimer;
    uint32 SleepTimer;
    uint32 CheckTimer;
    uint32 InfernoTimer;
    bool go;
    uint32 pos;

    void Reset()
    {
        ClearCastQueue();

        damageTaken = 0;
        SwarmTimer = 10000;
        SleepTimer = 60000;
        InfernoTimer = 60000;
        CheckTimer = 3000;

        if(pInstance && IsEvent)
            pInstance->SetData(DATA_ANETHERONEVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance && IsEvent)
            pInstance->SetData(DATA_ANETHERONEVENT, IN_PROGRESS);

        DoPlaySoundToSet(m_creature, SOUND_ONAGGRO);
        DoYell(SAY_ONAGGRO, LANG_UNIVERSAL, NULL);
        DoCast(m_creature, SPELL_VAMPIRIC_AURA, true);
    }

    void KilledUnit(Unit *victim)
    {
        switch(rand()%3)
        {
            case 0:
                DoPlaySoundToSet(m_creature, SOUND_ONSLAY1);
                DoYell(SAY_ONSLAY1, LANG_UNIVERSAL, NULL);
                break;
            case 1:
                DoPlaySoundToSet(m_creature, SOUND_ONSLAY2);
                DoYell(SAY_ONSLAY2, LANG_UNIVERSAL, NULL);
                break;
            case 2:
                DoPlaySoundToSet(m_creature, SOUND_ONSLAY3);
                DoYell(SAY_ONSLAY3, LANG_UNIVERSAL, NULL);
                break;
        }
    }

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 7 && pInstance)
        {
            Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_JAINAPROUDMOORE));
            if (target && target->isAlive())
            {
                m_creature->AddThreat(target,0.0);
                AttackStart(target);
            }
            else
            {
                if(target = m_creature->SelectNearbyTarget(200.0))
                    AttackStart(target);
            }
        }
    }

    void JustDied(Unit *victim)
    {
        hyjal_trashAI::JustDied(victim);
        if(pInstance && IsEvent)
            pInstance->SetData(DATA_ANETHERONEVENT, DONE);

        DoPlaySoundToSet(m_creature, SOUND_ONDEATH);
        DoYell(SAY_ONDEATH, LANG_UNIVERSAL, NULL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (IsEvent)
        {
            //Must update npc_escortAI
            npc_escortAI::UpdateAI(diff);
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    AddWaypoint(0, 4896.08,    -1576.35,    1333.65);
                    AddWaypoint(1, 4898.68,    -1615.02,    1329.48);
                    AddWaypoint(2, 4907.12,    -1667.08,    1321.00);
                    AddWaypoint(3, 4963.18,    -1699.35,    1340.51);
                    AddWaypoint(4, 4989.16,    -1716.67,    1335.74);
                    AddWaypoint(5, 5026.27,    -1736.89,    1323.02);
                    AddWaypoint(6, 5037.77,    -1770.56,    1324.36);
                    AddWaypoint(7, 5067.23,    -1789.95,    1321.17);
                    Start(false, true);
                    SetDespawnAtEnd(false);
                }
            }
        }

        //back to victim target facing
        if (!UpdateVictim())
            return;

        if(CheckTimer < diff)
        {
            DoZoneInCombat();
            if(!m_creature->IsNonMeleeSpellCasted(true))
            {
                if(m_creature->GetSelection() != m_creature->getVictimGUID())
                    m_creature->SetSelection(m_creature->getVictimGUID());
            }
            m_creature->SetSpeed(MOVE_RUN, 3.0);
            CheckTimer = 2000;
        }
        else
            CheckTimer -= diff;

        if(SwarmTimer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0,65,true))
            {
                AddSpellToCast(target, SPELL_CARRION_SWARM, false, true);
                SwarmTimer = 12000+rand()%6000;

                switch(rand()%2)
                {
                    case 0:
                        DoPlaySoundToSet(m_creature, SOUND_SWARM1);
                        DoYell(SAY_SWARM1, LANG_UNIVERSAL, NULL);
                    break;
                    case 1:
                        DoPlaySoundToSet(m_creature, SOUND_SWARM2);
                        DoYell(SAY_SWARM2, LANG_UNIVERSAL, NULL);
                    break;
                }
            }
        }
        else
            SwarmTimer -= diff;

        if(SleepTimer < diff)
        {
            DoCast(m_creature, SPELL_SLEEP, true);

            SleepTimer = 60000;

            switch(rand()%2)
            {
                case 0:
                    DoPlaySoundToSet(m_creature, SOUND_SLEEP1);
                    DoYell(SAY_SLEEP1, LANG_UNIVERSAL, NULL);
                    break;
                case 1:
                    DoPlaySoundToSet(m_creature, SOUND_SLEEP2);
                    DoYell(SAY_SLEEP2, LANG_UNIVERSAL, NULL);
                    break;
            }
        }
        else
            SleepTimer -= diff;

        if(InfernoTimer < diff)
        {
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0,200,true))
            {
                m_creature->CastStop();
                AddSpellToCast(target, SPELL_INFERNO, false, true);

                switch(rand()%2)
                {
                    case 0:
                        DoPlaySoundToSet(m_creature, SOUND_INFERNO1);
                        DoYell(SAY_INFERNO1, LANG_UNIVERSAL, NULL);
                    break;
                    case 1:
                        DoPlaySoundToSet(m_creature, SOUND_INFERNO2);
                        DoYell(SAY_INFERNO2, LANG_UNIVERSAL, NULL);
                    break;
                }
                InfernoTimer = 60000;
            }
        }
        else
            InfernoTimer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_anetheron(Creature *_Creature)
{
    return new boss_anetheronAI (_Creature);
}

#define SPELL_IMMOLATION 31304
#define SPELL_INFERNO_EFFECT 31302

struct mob_towering_infernalAI : public ScriptedAI
{
    mob_towering_infernalAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    uint32 CheckTimer;
    uint32 WaitTimer;
    ScriptedInstance* pInstance;

    void Reset()
    {
        m_creature->setFaction(1720);
        m_creature->ApplySpellImmune(2, IMMUNITY_MECHANIC, MECHANIC_BANISH, true);
        CheckTimer = 5000;
        WaitTimer = 3500;
    }

    void JustRespawned()
    {
        DoCast(m_creature, SPELL_INFERNO_EFFECT);
        DoCast(m_creature, SPELL_IMMOLATION);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (!m_creature->isInCombat() && m_creature->IsWithinDistInMap(who, 50) && m_creature->IsHostileTo(who))
        {
            m_creature->AddThreat(who,0.0);
            m_creature->Attack(who,false);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(CheckTimer < diff)
        {
            if(pInstance)
            {
                Creature *pAnetheron = pInstance->GetCreature(pInstance->GetData64(DATA_ANETHERON));
                if(!pAnetheron || !pAnetheron->isAlive())
                {
                    m_creature->setDeathState(JUST_DIED);
                    m_creature->RemoveCorpse();
                    return;
                }
            }
            CheckTimer = 2000;
        }
        else
            CheckTimer -= diff;

        //Return since we have no target
        if (!UpdateVictim())
            return;

        if(WaitTimer > diff)
        {
            WaitTimer -= diff;
            return;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_towering_infernal(Creature *_Creature)
{
    return new mob_towering_infernalAI (_Creature);
}

void AddSC_boss_anetheron()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_anetheron";
    newscript->GetAI = &GetAI_boss_anetheron;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_towering_infernal";
    newscript->GetAI = &GetAI_mob_towering_infernal;
    newscript->RegisterSelf();
}
