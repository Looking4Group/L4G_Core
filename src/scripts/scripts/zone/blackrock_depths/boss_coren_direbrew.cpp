#include "precompiled.h"
#include "def_blackrock_depths.h"


#define BOSS_COREN_DIREBREW             23872
#define NPC_ILSA_DIREBREW               26764
#define NPC_URSULA_DIREBREW             26822
#define NPC_DARK_IRON_ANTAGONIST        23795
#define COREN_TEXT              "You'll pay for this insult!"

#define SPELL_SUMMON_MINION_KNOCKBACK   50313 //wrong?
#define SPELL_SUMMON_MINION             47375
#define SPELL_DIREBREW_CHARGE           47718
#define SPELL_DIREBREWS_DISARM          47310
#define SPELL_DISARM_GROW               47409
#define SPELL_SUMMON_MOLE_MACHINE       43563


//////////////////////
//Coren Direbrew
//////////////////////
struct boss_coren_direbrewAI : public ScriptedAI
{
    boss_coren_direbrewAI(Creature *c) : ScriptedAI(c) { }

    uint32 Disarm_Timer;
    uint32 Summon_Timer;
    uint32 Drink_Timer;
    uint32 Ilsa_Timer;
    uint32 Ursula_Timer;

    void Reset()
    {
        Disarm_Timer = 20000;
        Summon_Timer = 15000;
        Ilsa_Timer = 0;
        Ursula_Timer = 0;
        
        //me->setFaction(35);

        std::list<Creature*> antagonistList;
        Looking4group::AllCreaturesOfEntryInRange check(me, NPC_DARK_IRON_ANTAGONIST, 100);
        Looking4group::ObjectListSearcher<Creature, Looking4group::AllCreaturesOfEntryInRange> searcher(antagonistList, check);

        Cell::VisitGridObjects(me, searcher, 100);

        if(antagonistList.size())
        {
            for(std::list<Creature*>::iterator i = antagonistList.begin(); i != antagonistList.end(); ++i)
            {
                //(*i)->setFaction(35);
                (*i)->Respawn();
            }
        }

    }

    void SummonedCreatureDespawn(Creature * creature)
    {
        switch(creature->GetEntry())
        {
            case NPC_ILSA_DIREBREW:
                Ilsa_Timer = 5000;
                break;
            case NPC_URSULA_DIREBREW:
                Ursula_Timer = 10000;
                break;
            default:
                break;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(Disarm_Timer < diff)
        {
            AddSpellToCast(SPELL_DISARM_GROW, CAST_SELF, true);
            AddSpellToCast(SPELL_DISARM_GROW, CAST_SELF, true);
            AddSpellToCast(SPELL_DISARM_GROW, CAST_SELF, true);
            AddSpellToCast(SPELL_DIREBREWS_DISARM, CAST_NULL);
            Disarm_Timer = 30000;
        }
        else Disarm_Timer -= diff;

        if(Summon_Timer < diff)
        {
            if(Unit * target = SelectUnit(SELECT_TARGET_RANDOM, 0, 45, true))
            {
                AddSpellToCast(target, SPELL_SUMMON_MOLE_MACHINE);
                //me->SummonGameObject(188478, me->getVictim()->GetPositionX(), me->getVictim()->GetPositionY(), me->getVictim()->GetPositionZ(), 0,0 ,0 ,0 ,0, 4);
                //me->getVictim()->KnockBackFrom(me, 4, 7);
                //AddSpellToCast(me, SPELL_SUMMON_MINION_KNOCKBACK);
                AddSpellToCast(target, SPELL_SUMMON_MINION, true);
                Summon_Timer = 15000;
            }
        }
        else Summon_Timer -= diff;

        if(float(me->GetHealth())/float(me->GetMaxHealth()) < 0.66f)
        {
            if(Ilsa_Timer < diff)
            {
                Creature * Ilsa = GetClosestCreatureWithEntry(me, NPC_ILSA_DIREBREW, 100);
                if (!Ilsa)
                {
                    me->SummonCreature(NPC_ILSA_DIREBREW, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_CORPSE_DESPAWN, 0);
                }
                Ilsa_Timer = 300000;
            }
            else Ilsa_Timer -= diff;
        }

        if(float(me->GetHealth())/float(me->GetMaxHealth()) < 0.33f)
        {
            if(Ursula_Timer < diff)
            {
                Creature * Ursula = GetClosestCreatureWithEntry(me, NPC_URSULA_DIREBREW, 100);
                if (!Ursula)
                {
                    me->SummonCreature(NPC_URSULA_DIREBREW, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_CORPSE_DESPAWN, 0);
                }
                Ursula_Timer = 300000;
            }
            else Ursula_Timer -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_coren_direbrew(Creature *creature)
{
    return new boss_coren_direbrewAI (creature);
}



//////////////////////
//Trigger
//////////////////////
struct direbrew_starter_triggerAI : public ScriptedAI
{
    direbrew_starter_triggerAI(Creature *c) : ScriptedAI(c) { }

    uint32 Start_Timer;

    void Reset()
    {
        Start_Timer = 1000;
    }

    void UpdateAI(const uint32 diff)
    {
        if(Start_Timer < diff)
        {
            Creature * Coren = GetClosestCreatureWithEntry(me, BOSS_COREN_DIREBREW, 20);
            if (Coren && Coren->isAlive())
            {
                Coren->Say(COREN_TEXT, LANG_UNIVERSAL, 0);
                Coren->setFaction(54);

                std::list<Creature*> antagonistList;
                Looking4group::AllCreaturesOfEntryInRange check(me, NPC_DARK_IRON_ANTAGONIST, 100);
                Looking4group::ObjectListSearcher<Creature, Looking4group::AllCreaturesOfEntryInRange> searcher(antagonistList, check);

                Cell::VisitGridObjects(me, searcher, 100);

                if(antagonistList.size())
                {
                    for(std::list<Creature*>::iterator i = antagonistList.begin(); i != antagonistList.end(); ++i)
                    {
                        (*i)->setFaction(54);
                    }
                }

                me->ForcedDespawn(0);
            }
        }
        else Start_Timer -= diff;
    }
};

CreatureAI* GetAI_direbrew_starter_trigger(Creature *creature)
{
    return new direbrew_starter_triggerAI (creature);
}

void AddSC_boss_coren_direbrew()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="direbrew_starter_trigger";
    newscript->GetAI = &GetAI_direbrew_starter_trigger;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_coren_direbrew";
    newscript->GetAI = &GetAI_boss_coren_direbrew;
    newscript->RegisterSelf();
}
