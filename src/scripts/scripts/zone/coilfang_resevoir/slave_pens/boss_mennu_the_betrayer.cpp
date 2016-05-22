
#include "precompiled.h"

#define SPELL_HEALING_WARD              34980
#define SPELL_CORRUPTED_NOVA_TOTEM      31991
#define SPELL_LIGHTNING_BOLT            35010
#define SPELL_EARTHGRAB_TOTEM           31981
#define SPELL_STONESKIN_TOTEM           31985

#define SPELL_HEALING_WARD_HEAL         34977
#define SPELL_H_HEALING_WARD_HEAL       38800
#define SPELL_FIRE_NOVA                 33132
#define SPELL_ENTANGLING_ROOTS          20654
#define SPELL_STONESKIN                 31986

#define NPC_HEALING_WARD                20208
#define NPC_H_HEALING_WARD              22322
#define NPC_STONESKIN_TOTEM             18177
#define NPC_H_STONESKIN_TOTEM           19900


struct boss_mennu_the_betrayerAI : public ScriptedAI
{
    boss_mennu_the_betrayerAI(Creature *c) : ScriptedAI(c), Summons(m_creature)
    {
        pInstance = (c->GetInstanceData());
        HeroicMode = m_creature->GetMap()->IsHeroic();
    }


    ScriptedInstance *pInstance;
    bool HeroicMode;

    SummonList Summons;

    uint32 HealingWard_Timer;
    uint32 NovaTotem_Timer;
    uint32 LightningBolt_Timer;
    uint32 EarthGrab_Timer;
    uint32 StoneSkin_Timer;


    void Reset()
    {
        ClearCastQueue();

        HealingWard_Timer = 15000;
        NovaTotem_Timer = 45000;
        LightningBolt_Timer = 10000;
        EarthGrab_Timer = 15000;
        StoneSkin_Timer = 15000;
        Summons.DespawnAll();
    }

    void EnterCombat(Unit *who)
    {
    }


    void JustSummoned(Creature* summoned)
    {
        switch(summoned->GetEntry())
        {
            case NPC_STONESKIN_TOTEM:
            case NPC_H_STONESKIN_TOTEM:
                summoned->CastSpell(summoned, SPELL_STONESKIN, true);
                summoned->SetDefaultMovementType(IDLE_MOTION_TYPE);
                break;
        }
        Summons.Summon(summoned);
    }

    void SummonedCreatureDespawn(Creature *summon)
    {
        Summons.Despawn(summon);
    }

    void DamageTaken(Unit*, uint32 &)
    {
    }

    void JustDied(Unit *u)
    {
        Summons.DespawnAll();
    }


    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(HealingWard_Timer < diff)
        {
            AddSpellToCast(m_creature, SPELL_HEALING_WARD);
            HealingWard_Timer = 30000;
        }
        else
            HealingWard_Timer -= diff;

        if(NovaTotem_Timer < diff)
        {
            AddSpellToCast(m_creature, SPELL_CORRUPTED_NOVA_TOTEM);
            NovaTotem_Timer = 45000;
        }
        else
            NovaTotem_Timer -= diff;

        if(LightningBolt_Timer < diff)
        {
            if (HeroicMode)
                AddCustomSpellToCast(m_creature->getVictim(), SPELL_LIGHTNING_BOLT,142,0,0);
            else
            AddCustomSpellToCast(m_creature->getVictim(), SPELL_LIGHTNING_BOLT,175,0,0);
            LightningBolt_Timer = 10000;
        }
        else
            LightningBolt_Timer -= diff;

        if(EarthGrab_Timer < diff)
        {
            AddSpellToCast(m_creature, SPELL_EARTHGRAB_TOTEM);
            EarthGrab_Timer = 30000;
        }
        else
            EarthGrab_Timer -= diff;

        if(StoneSkin_Timer < diff)
        {
            AddSpellToCast(m_creature, SPELL_STONESKIN_TOTEM);
            StoneSkin_Timer = 60000;
        }
        else
            StoneSkin_Timer -= diff;

        CastNextSpellIfAnyAndReady(diff);
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_mennu_the_betrayer(Creature *_Creature)
{
    return new boss_mennu_the_betrayerAI (_Creature);
}

struct npc_corrupted_nova_totemAI : public Scripted_NoMovementAI
{
    npc_corrupted_nova_totemAI(Creature *c) : Scripted_NoMovementAI(c)
    {
        pInstance = (c->GetInstanceData());
        HeroicMode = m_creature->GetMap()->IsHeroic();
    }

    ScriptedInstance *pInstance;
    bool HeroicMode;
    uint32 Life_Timer;
    uint32 Phase;

    void Reset()
    {
        Life_Timer = HeroicMode?15000:5000;
        Phase = 0;
    }

    void JustDied(Unit *u)
    {

    }

    void DamageTaken(Unit*, uint32& damage)
    {
        if(Phase == 0)
        {
            if(damage >= m_creature->GetHealth())
            {
                DoCast(m_creature, SPELL_FIRE_NOVA);
                Life_Timer = 1500;
                Phase = 1;
                m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            }
        }
        if(Phase == 1)
            damage = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if(Life_Timer < diff)
        {
            if(Phase == 1)
                Phase = 2;
            if(Phase < 2)
                m_creature->DealDamage(m_creature, m_creature->GetHealth(), DIRECT_DAMAGE);
        }
        else
            Life_Timer -= diff;
    }

};

CreatureAI* GetAI_npc_corrupted_nova_totem(Creature *_Creature)
{
    return new npc_corrupted_nova_totemAI (_Creature);
}

struct npc_mennu_healing_wardAI : public ScriptedAI
{
    npc_mennu_healing_wardAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        HeroicMode = m_creature->GetMap()->IsHeroic();
    }

    ScriptedInstance *pInstance;
    bool HeroicMode;

    uint32 Timer;

    void Reset()
    {
        Timer = 2000;
    }

    void JustDied(Unit *u)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        if(Timer < diff)
        {
            DoCast(m_creature, HeroicMode?SPELL_H_HEALING_WARD_HEAL:SPELL_HEALING_WARD_HEAL);
            Timer = 2000;
        }
        else
            Timer -= diff;
    }

};

CreatureAI* GetAI_npc_mennu_healing_ward(Creature *_Creature)
{
    return new npc_mennu_healing_wardAI (_Creature);
}

struct npc_earthgrab_totemAI : public Scripted_NoMovementAI
{
    npc_earthgrab_totemAI(Creature *c) : Scripted_NoMovementAI(c)
    {
    }

    uint32 Earthgrab_Timer;

    void Reset()
    {
        Earthgrab_Timer = 4000;
    }

    void JustDied(Unit *u)
    {
    }


    void UpdateAI(const uint32 diff)
    {
        if(Earthgrab_Timer < diff)
        {
            DoCast(m_creature, SPELL_ENTANGLING_ROOTS);
            Earthgrab_Timer = 18000 + rand()%4000;
        }
        else
            Earthgrab_Timer -= diff;
    }

};

CreatureAI* GetAI_npc_earthgrab_totem(Creature *_Creature)
{
    return new npc_earthgrab_totemAI (_Creature);
}

void AddSC_boss_mennu_the_betrayer()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_mennu_the_betrayer";
    newscript->GetAI = &GetAI_boss_mennu_the_betrayer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_corrupted_nova_totem";
    newscript->GetAI = &GetAI_npc_corrupted_nova_totem;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_earthgrab_totem";
    newscript->GetAI = &GetAI_npc_earthgrab_totem;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_mennu_healing_ward";
    newscript->GetAI = &GetAI_npc_mennu_healing_ward;
    newscript->RegisterSelf();
}
