
#include "precompiled.h"
#include "def_hyjal.h"
#include "hyjal_trash.h"

#define SPELL_RAIN_OF_FIRE 31340
#define SPELL_DOOM 31347
#define SPELL_HOWL_OF_AZGALOR 31344
#define SPELL_CLEAVE 31345
#define SPELL_BERSERK 26662

#define SAY_ONDEATH "Your time is almost... up"
#define SOUND_ONDEATH 11002

#define SAY_ONSLAY1 "Reesh, hokta!"
#define SAY_ONSLAY2 "Don't fight it"
#define SAY_ONSLAY3 "No one is going to save you"
#define SOUND_ONSLAY1 11001
#define SOUND_ONSLAY2 11048
#define SOUND_ONSLAY3 11047

#define SAY_DOOM1 "Just a taste... of what awaits you"
#define SAY_DOOM2 "Suffer you despicable insect!"
#define SOUND_DOOM1 11046
#define SOUND_DOOM2 11000

#define SAY_ONAGGRO "Abandon all hope! The legion has returned to finish what was begun so many years ago. This time there will be no escape!"
#define SOUND_ONAGGRO 10999

struct boss_azgalorAI : public hyjal_trashAI
{
    boss_azgalorAI(Creature *c) : hyjal_trashAI(c)
    {
        pInstance = (c->GetInstanceData());
        go = false;
        pos = 0;
        SpellEntry *TempSpell = (SpellEntry*)GetSpellStore()->LookupEntry(SPELL_HOWL_OF_AZGALOR);
        if(TempSpell)
            TempSpell->EffectRadiusIndex[0] = 12;//100yards instead of 50000?!
    }

    uint32 RainTimer;
    uint32 DoomTimer;
    uint32 HowlTimer;
    uint32 CleaveTimer;
    uint32 EnrageTimer;
    uint32 CheckTimer;
    bool enraged;

    bool go;
    uint32 pos;

    void Reset()
    {
        damageTaken = 0;
        RainTimer = urand(9000, 20000);
        DoomTimer = urand(35000, 45000);
        HowlTimer = urand(15000, 21000);
        CleaveTimer = urand(5000, 10000);
        EnrageTimer = 600000;
        CheckTimer = 3000;
        enraged = false;

        if(pInstance && IsEvent)
            pInstance->SetData(DATA_AZGALOREVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance && IsEvent)
            pInstance->SetData(DATA_AZGALOREVENT, IN_PROGRESS);

        DoPlaySoundToSet(m_creature, SOUND_ONAGGRO);
        DoYell(SAY_ONAGGRO, LANG_UNIVERSAL, NULL);
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
            Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
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
            pInstance->SetData(DATA_AZGALOREVENT, DONE);

        DoPlaySoundToSet(m_creature, SOUND_ONDEATH);
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
                    AddWaypoint(0, 5492.91,    -2404.61,    1462.63);
                    AddWaypoint(1, 5531.76,    -2460.87,    1469.55);
                    AddWaypoint(2, 5554.58,    -2514.66,    1476.12);
                    AddWaypoint(3, 5554.16,    -2567.23,    1479.90);
                    AddWaypoint(4, 5540.67,    -2625.99,    1480.89);
                    AddWaypoint(5, 5508.16,    -2659.2,    1480.15);
                    AddWaypoint(6, 5489.62,    -2704.05,    1482.18);
                    AddWaypoint(7, 5457.04,    -2726.26,    1485.10);
                    Start(false, true);
                    SetDespawnAtEnd(false);
                }
            }
        }

        //Return since we have no target
        if (!UpdateVictim() )
            return;

        if(CheckTimer < diff)
        {
            DoZoneInCombat();
            m_creature->SetSpeed(MOVE_RUN, 3.0);
            CheckTimer = 3000;
        }
        else
            CheckTimer -= diff;

        if(RainTimer < diff)
        {
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 40, true))
            {
                DoCast(target, SPELL_RAIN_OF_FIRE);
                RainTimer = urand(20000, 35000);
            }
        }
        else
            RainTimer -= diff;

        //only set timer when target exist, cause with exclude defined we return NULL that now can be acceptable spell target
        if(DoomTimer < diff)
        {
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 100, true, m_creature->getVictimGUID()))
            {
                DoCast(target, SPELL_DOOM);//never on tank
                DoomTimer = urand(45000, 50000);
            }
        }
        else
            DoomTimer -= diff;

        if(HowlTimer < diff)
        {
            DoCast(m_creature, SPELL_HOWL_OF_AZGALOR);
            HowlTimer = urand(15000, 22000);
        }
        else
            HowlTimer -= diff;

        if(CleaveTimer < diff)
        {
            if(Unit *target = m_creature->getVictim())
            {
                DoCast(target, SPELL_CLEAVE);
                CleaveTimer = urand(10000, 16000);
            }
        }
        else
            CleaveTimer -= diff;

        if(EnrageTimer < diff && !enraged)
        {
            m_creature->InterruptNonMeleeSpells(false);
            DoCast(m_creature, SPELL_BERSERK, true);
            enraged = true;
            EnrageTimer = 600000;
        }
        else
            EnrageTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_azgalor(Creature *_Creature)
{
    return new boss_azgalorAI (_Creature);
}

#define SPELL_THRASH 12787
#define SPELL_CRIPPLE 31406
#define SPELL_WARSTOMP 31408

struct mob_lesser_doomguardAI : public hyjal_trashAI
{
    mob_lesser_doomguardAI(Creature *c) : hyjal_trashAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    uint32 CrippleTimer;
    uint32 WarstompTimer;
    uint32 CheckTimer;

    ScriptedInstance* pInstance;

    void Reset()
    {
        CrippleTimer = urand(12000, 18000);
        WarstompTimer = urand(7000, 11000);
        CheckTimer = 2000;
    }

    void WaypointReached(uint32){}

    void JustRespawned()
    {
        DoCast(m_creature, SPELL_THRASH, true);
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
                Creature *pAzgalor = pInstance->GetCreature(pInstance->GetData64(DATA_AZGALOR));
                if(!pAzgalor || !pAzgalor->isAlive())
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
        if (!UpdateVictim() )
            return;

        if(WarstompTimer < diff)
        {
            DoCast(m_creature, SPELL_WARSTOMP);
            WarstompTimer = urand(11000, 18000);
        }
        else
            WarstompTimer -= diff;

        if(CrippleTimer < diff)
        {
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0,100,true))
            {
                DoCast(target, SPELL_CRIPPLE);
                CrippleTimer = urand(13000, 20000);
            }
        }
        else
            CrippleTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_lesser_doomguard(Creature *_Creature)
{
    return new mob_lesser_doomguardAI (_Creature);
}

void AddSC_boss_azgalor()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_azgalor";
    newscript->GetAI = &GetAI_boss_azgalor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_lesser_doomguard";
    newscript->GetAI = &GetAI_mob_lesser_doomguard;
    newscript->RegisterSelf();
}
