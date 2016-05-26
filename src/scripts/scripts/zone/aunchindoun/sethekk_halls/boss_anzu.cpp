#include "precompiled.h"
#include "def_sethekk_halls.h"


#define SPELL_SPELL_BOMB                40303
#define SPELL_CYCLONE_OF_FEATHERS       40321
#define SPELL_PARALYZING_SCREECH        40184
#define SPELL_BANISH                    42354   // probably completly wrong spell

#define SPELL_PROTECTION_OF_THE_HAWK    40237
#define SPELL_SPITE_OF_THE_EAGLE        40240
#define SPELL_SPEED_OF_THE_FALCON       40241

#define NPC_HAWK_SPIRIT                 23134
#define NPC_EAGLE_SPIRIT                23136
#define NPC_FALCON_SPIRIT               23135

#define NPC_BROOD_OF_ANZU               23132

#define GO_RAVENS_CLAW                   185554

uint32 AnzuSpirits[] = {NPC_HAWK_SPIRIT, NPC_EAGLE_SPIRIT, NPC_FALCON_SPIRIT};

float AnzuSpiritLoc[][3] = {
    { -113, 293, 27 },
    { -77, 315, 27 },
    { -62, 288, 27 }
};

struct boss_anzuAI : public ScriptedAI
{
    boss_anzuAI(Creature* c) : ScriptedAI(c), summons(c)
    {
        pInstance = c->GetInstanceData();
    }

    SummonList summons;
    ScriptedInstance* pInstance;

    bool Banished;
    uint32 Banish_Timer;
    uint32 SpellBomb_Timer;
    uint32 CycloneOfFeathers_Timer;
    uint32 ParalyzingScreech_Timer;
    uint8 BanishedTimes;
    uint8 BroodCount;

    void Reset()
    {
        ClearCastQueue();
        summons.DespawnAll();

        Banished = false;
        Banish_Timer = 0;
        SpellBomb_Timer = 22000; 
        CycloneOfFeathers_Timer = 5000;
        ParalyzingScreech_Timer = 14000;
        BanishedTimes = 2;

        if(pInstance)
            pInstance->SetData(DATA_ANZUEVENT, NOT_STARTED);
    }

    void IsSummonedBy(Unit *summoner) 
    {
        GameObject* go = FindGameObject(GO_RAVENS_CLAW, 20, me);
        if(go)
        {
            go->Delete();
        }

    }

    void JustSummoned(Creature *summon)
    {
        if(summon->GetEntry() == NPC_BROOD_OF_ANZU)
        {
            summon->AI()->AttackStart(me->getVictim());
            BroodCount++;
        }
        summons.Summon(summon);
    }

    void SummonedCreatureDespawn(Creature *summon)
    {
        if(summon->GetEntry() == NPC_BROOD_OF_ANZU)
            BroodCount--;
        summons.Despawn(summon);
    }


    void SummonSpirits()
    {
        for(uint8 i = 0; i < 3; i++)
            me->SummonCreature(AnzuSpirits[i], AnzuSpiritLoc[i][0], AnzuSpiritLoc[i][1], AnzuSpiritLoc[i][2], 0, TEMPSUMMON_MANUAL_DESPAWN, 0);
    }

    void SummonBrood()
    {
        for(uint8 i = 0; i < 5; i++)
            DoSummon(NPC_BROOD_OF_ANZU, me, 5, 0, TEMPSUMMON_CORPSE_DESPAWN);
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance)
            pInstance->SetData(DATA_ANZUEVENT, IN_PROGRESS);  
        SummonSpirits();
    }

    void JustDied(Unit* Killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_ANZUEVENT, DONE);
        summons.DespawnAll();
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(Banished)
        {
            if(BroodCount == 0 || Banish_Timer < diff)
            {
                Banished = false;
                me->RemoveAurasDueToSpell(SPELL_BANISH);
            } else 
                Banish_Timer -= diff;
        } else {

            if(ParalyzingScreech_Timer < diff)
            {
                AddSpellToCast(me, SPELL_PARALYZING_SCREECH);
                ParalyzingScreech_Timer = 26000;
            } else 
                ParalyzingScreech_Timer -= diff;

            if(SpellBomb_Timer < diff)
            {
                if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    AddSpellToCast(target, SPELL_SPELL_BOMB);
                SpellBomb_Timer = 30000;
            } else
                SpellBomb_Timer -= diff;

            if(CycloneOfFeathers_Timer < diff)
            {
                if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 1, 45.0f, true))
                    AddSpellToCast(target, SPELL_CYCLONE_OF_FEATHERS);
                CycloneOfFeathers_Timer = 21000;
            } else
                CycloneOfFeathers_Timer -= diff;

            if(HealthBelowPct(33*BanishedTimes))
            {
                BanishedTimes--;
                Banished = true;
                Banish_Timer = 45000;
                ForceSpellCast(me, SPELL_BANISH, INTERRUPT_AND_CAST_INSTANTLY, true);
                SummonBrood();
            }          
        }
        
        CastNextSpellIfAnyAndReady();
        if(!Banished)
            DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_anzu(Creature *_Creature)
{
    return new boss_anzuAI (_Creature);
}

struct npc_anzu_spiritAI : public Scripted_NoMovementAI
{
    npc_anzu_spiritAI(Creature* c, uint32 spell) : Scripted_NoMovementAI(c)
    {
        Spell = spell;
    }

    uint32 Spell;
    uint32 Timer;

    void Reset() {
        Timer = 5000;
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_PL_SPELL_TARGET);
    }

    bool isDruidHotSpell(const SpellEntry *spellProto)
    {
        return spellProto->SpellFamilyName == SPELLFAMILY_DRUID && (spellProto->SpellFamilyFlags & 0x1000000050LL);
    }

    void OnAuraApply(Aura *aur, Unit *caster, bool stackApply)
    {
        if(isDruidHotSpell(aur->GetSpellProto()))
        {
            DoCast(me, Spell);
            Timer = 5000;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(Timer < diff)
        {
            const Unit::AuraList& auras = me->GetAurasByType(SPELL_AURA_PERIODIC_HEAL);
            for(Unit::AuraList::const_iterator i = auras.begin(); i != auras.end(); ++i)
            {
                if(isDruidHotSpell((*i)->GetSpellProto()))
                {
                    DoCast(me, Spell);
                    break;
                }
            }
            Timer = 5000;
        } else
            Timer -= diff;
    }
};

CreatureAI* GetAI_npc_eagle_spirit(Creature *_Creature)
{
    return new npc_anzu_spiritAI (_Creature, SPELL_SPITE_OF_THE_EAGLE);
}

CreatureAI* GetAI_npc_hawk_spirit(Creature *_Creature)
{
    return new npc_anzu_spiritAI (_Creature, SPELL_PROTECTION_OF_THE_HAWK);
}

CreatureAI* GetAI_npc_falcon_spirit(Creature *_Creature)
{
    return new npc_anzu_spiritAI (_Creature, SPELL_SPEED_OF_THE_FALCON);
}

void AddSC_boss_anzu()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_anzu";
    newscript->GetAI = &GetAI_boss_anzu;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_eagle_spirit";
    newscript->GetAI = &GetAI_npc_eagle_spirit;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_falcon_spirit";
    newscript->GetAI = &GetAI_npc_falcon_spirit;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_hawk_spirit";
    newscript->GetAI = &GetAI_npc_hawk_spirit;
    newscript->RegisterSelf();
}
