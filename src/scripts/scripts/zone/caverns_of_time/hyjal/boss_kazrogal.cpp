
#include "precompiled.h"
#include "def_hyjal.h"
#include "hyjal_trash.h"

#define SPELL_CLEAVE   31436
#define SPELL_WARSTOMP 31480
#define SPELL_MARK     31447
#define SPELL_CRIPPLE  31477

#define SOUND_ONDEATH 11018

#define SAY_ONSLAY1 "Shaza-Kiel!"
#define SAY_ONSLAY2 "You... are nothing!"
#define SAY_ONSLAY3 "Miserable nuisance!"
#define SOUND_ONSLAY1 11017
#define SOUND_ONSLAY2 11053
#define SOUND_ONSLAY3 11054

#define SAY_MARK1 "Your death will be a painful one."
#define SAY_MARK2 "You... are marked."
#define SOUND_MARK1 11016
#define SOUND_MARK2 11052

#define SAY_ONAGGRO "Cry for mercy! Your meaningless lives will soon be forfeit."
#define SOUND_ONAGGRO 11015

struct boss_kazrogalAI : public hyjal_trashAI
{
    boss_kazrogalAI(Creature *c) : hyjal_trashAI(c)
    {
        pInstance = (c->GetInstanceData());
        go = false;
        pos = 0;

        SpellEntry *TempSpell = (SpellEntry*)GetSpellStore()->LookupEntry(SPELL_WARSTOMP);
        if(TempSpell)
        {
            TempSpell->Effect[1] = 2;
        }
    }

    uint32 CleaveTimer;
    uint32 WarStompTimer;
    uint32 MarkTimer;
    uint32 MarkTimerBase;
    uint32 CheckTimer;
    uint32 CrippleTimer;

    bool go;
    uint32 pos;

    void Reset()
    {
        damageTaken = 0;
        CleaveTimer = 5000;
        WarStompTimer = urand(12000, 18000);
        MarkTimer = 45000;
        MarkTimerBase = 45000;
        CheckTimer = 3000;
        CrippleTimer = urand(6000, 11000);

        if(pInstance && IsEvent)
            pInstance->SetData(DATA_KAZROGALEVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance && IsEvent)
            pInstance->SetData(DATA_KAZROGALEVENT, IN_PROGRESS);

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
            pInstance->SetData(DATA_KAZROGALEVENT, DONE);
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

        if(CleaveTimer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_CLEAVE);
            CleaveTimer = urand(6000, 21000);
        }
        else
            CleaveTimer -= diff;

        if(WarStompTimer < diff)
        {
            DoCast(m_creature, SPELL_WARSTOMP);
            WarStompTimer = urand(15000, 25000);
        }
        else
            WarStompTimer -= diff;

        if(CrippleTimer < diff)
        {
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 1, 20, true))
                DoCast(target, SPELL_CRIPPLE);

            CrippleTimer = urand(10000, 12000);
        }
        else
            CrippleTimer -= diff;

        if(MarkTimer < diff)
        {
            m_creature->CastSpell(m_creature, SPELL_MARK, false);

            MarkTimerBase -= 5000;

            if(MarkTimerBase <= 5500)
                MarkTimerBase = 10500;

            MarkTimer = MarkTimerBase;
            switch(rand()%3)
            {
                case 0:
                    DoPlaySoundToSet(m_creature, SOUND_MARK1);
                    DoYell(SAY_MARK1, LANG_UNIVERSAL, NULL);
                    break;
                case 1:
                    DoPlaySoundToSet(m_creature, SOUND_MARK2);
                    DoYell(SAY_MARK2, LANG_UNIVERSAL, NULL);
                    break;
            }
        }
        else
            MarkTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_kazrogal(Creature *_Creature)
{
    return new boss_kazrogalAI (_Creature);
}

void AddSC_boss_kazrogal()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_kazrogal";
    newscript->GetAI = &GetAI_boss_kazrogal;
    newscript->RegisterSelf();
}
