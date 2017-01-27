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
SDName: Boss_Kelidan_The_Breaker
SD%Complete: 100
SDComment:
SDCategory: Hellfire Citadel, Blood Furnace
EndScriptData */

/* ContentData
boss_kelidan_the_breaker
mob_shadowmoon_channeler
EndContentData */

#include "precompiled.h"
#include "def_blood_furnace.h"

#define SAY_WAKE                    -1542000

#define SAY_ADD_AGGRO_1             -1542001
#define SAY_ADD_AGGRO_2             -1542002
#define SAY_ADD_AGGRO_3             -1542003

#define SAY_KILL_1                  -1542004
#define SAY_KILL_2                  -1542005
#define SAY_NOVA                    -1542006
#define SAY_DIE                     -1542007

#define SPELL_CORRUPTION            30938
#define SPELL_EVOCATION             30935
#define SPELL_BURNING_NOVA          30940
#define SPELL_VORTEX                37370
#define SPELL_FIRE_NOVA             (HeroicMode ? 37371 : 33132)
#define SPELL_SHADOW_BOLT_VOLLEY    (HeroicMode ? 40070 : 28599)

#define ENTRY_KELIDAN               17377
#define ENTRY_CHANNELER             17653

const float ShadowmoonChannelers[5][4]=
{
    {302,-87,-24.4,0.157},
    {321,-63.5,-24.6,4.887},
    {346,-74.5,-24.6,3.595},
    {344,-103.5,-24.5,2.356},
    {316,-109,-24.6,1.257}
};

class BurningNovaAura : public Aura
{
    public:
        BurningNovaAura(SpellEntry *spell, uint32 eff, Unit *target, Unit *caster) : Aura(spell, eff, NULL, target, caster, NULL){}
};

struct boss_kelidan_the_breakerAI : public ScriptedAI
{
    boss_kelidan_the_breakerAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
        for(int i=0; i<5; ++i) Channelers[i] = 0;
    }

    ScriptedInstance* pInstance;

    uint32 ShadowVolley_Timer;
    uint32 BurningNova_Timer;
    uint32 Firenova_Timer;
    uint32 Corruption_Timer;
    uint32 check_Timer;

    bool Firenova;
    bool addYell;

    uint64 Channelers[5];

    void Reset()
    {
        ShadowVolley_Timer = 1000;
        BurningNova_Timer = 15000;
        Corruption_Timer = 5000;
        check_Timer = 0;
        Firenova = false;
        addYell = false;

        if (pInstance)
            pInstance->SetData(DATA_KELIDANEVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(SAY_WAKE, m_creature);

        if (pInstance)
            pInstance->SetData(DATA_KELIDANEVENT, IN_PROGRESS);

        if (m_creature->IsNonMeleeSpellCasted(false))
            m_creature->InterruptNonMeleeSpells(true);
        DoStartMovement(who);
    }

    void KilledUnit(Unit* victim)
    {
        if (rand()%2)
            return;

        DoScriptText(RAND(SAY_KILL_1, SAY_KILL_2), m_creature);
    }

    void ChannelerEngaged(Unit* who)
    {
        if(who && !addYell)
        {
            addYell = true;
            DoScriptText(RAND(SAY_ADD_AGGRO_1, SAY_ADD_AGGRO_2, SAY_ADD_AGGRO_3), m_creature);
        }

        for(int i=0; i<5; ++i)
        {
            Creature *channeler = Unit::GetCreature(*m_creature, Channelers[i]);
            if(who && channeler && !channeler->isInCombat())
                channeler->AI()->AttackStart(who);
        }
    }

    void ChannelerDied(Unit* killer)
    {
        for(int i=0; i<5; ++i)
        {
            Creature *channeler = Unit::GetCreature(*m_creature, Channelers[i]);
            if(channeler && channeler->isAlive())
                return;
        }

        if(killer)
            m_creature->AI()->AttackStart(killer);
    }

    uint64 GetChanneled(Creature *channeler1)
    {
        SummonChannelers();
        if(!channeler1) return 0;
        int i;
        for(i=0; i<5; ++i)
        {
            Creature *channeler = Unit::GetCreature(*m_creature, Channelers[i]);
            if(channeler && channeler->GetGUID()==channeler1->GetGUID())
                break;
        }
        return Channelers[(i+2)%5];
    }

    void SummonChannelers()
    {
        for(int i=0; i<5; ++i)
        {
            Creature *channeler = Unit::GetCreature(*m_creature, Channelers[i]);
            if(!channeler || channeler->isDead())
                channeler = m_creature->SummonCreature(ENTRY_CHANNELER,ShadowmoonChannelers[i][0],ShadowmoonChannelers[i][1],ShadowmoonChannelers[i][2],ShadowmoonChannelers[i][3],TEMPSUMMON_CORPSE_TIMED_DESPAWN,300000);
            if(channeler)
                Channelers[i] = channeler->GetGUID();
            else
                Channelers[i] = 0;
        }
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DIE, m_creature);

        if(pInstance)
            pInstance->SetData(DATA_KELIDANEVENT, DONE);
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if (type != POINT_MOTION_TYPE)
            return;

        if (id == 1)
        {
            SummonChannelers();
            DoCast(m_creature,SPELL_EVOCATION);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
        {
            if(check_Timer < diff)
            {
                if (!m_creature->IsNonMeleeSpellCasted(false))
                {
                    float x, y, z;
                    me->GetRespawnCoord(x, y, z);
                    me->GetMotionMaster()->MovePoint(1, x, y, z);
                }

                check_Timer = 5000;
            }
            else
                check_Timer -= diff;

            return;
        }

        if (Firenova)
        {
            if (Firenova_Timer < diff)
            {
                ForceSpellCast(me, SPELL_FIRE_NOVA, INTERRUPT_AND_CAST_INSTANTLY);
                Firenova = false;
                ShadowVolley_Timer = 2000;
            }
            else
                Firenova_Timer -=diff;

            return;
        }

        if (ShadowVolley_Timer < diff)
        {
            AddSpellToCast(m_creature, SPELL_SHADOW_BOLT_VOLLEY);
            ShadowVolley_Timer = urand(5000, 13000);
        }
        else
            ShadowVolley_Timer -=diff;

        if (Corruption_Timer < diff)
        {
            AddSpellToCast(me,SPELL_CORRUPTION);
            Corruption_Timer = urand(30000, 50000);
        }
        else
            Corruption_Timer -=diff;

        if (BurningNova_Timer < diff)
        {
            if (m_creature->IsNonMeleeSpellCasted(false))
                m_creature->InterruptNonMeleeSpells(true);

            DoScriptText(SAY_NOVA, m_creature);

            if (HeroicMode)
                ForceSpellCast(me, SPELL_VORTEX, INTERRUPT_AND_CAST_INSTANTLY);

            if (SpellEntry *nova = (SpellEntry*)GetSpellStore()->LookupEntry(SPELL_BURNING_NOVA))
            {
                for (uint32 i = 0; i < 3; ++i)
                {
                    if (nova->Effect[i] == SPELL_EFFECT_APPLY_AURA)
                    {
                        Aura *Aur = new BurningNovaAura(nova, i, m_creature, m_creature);
                        m_creature->AddAura(Aur);
                    }
                }
            }

            BurningNova_Timer = urand(20000, 28000);
            Firenova_Timer= 5000;
            Firenova = true;
        }
        else
            BurningNova_Timer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_kelidan_the_breaker(Creature *_Creature)
{
    return new boss_kelidan_the_breakerAI (_Creature);
}

/*######
## mob_shadowmoon_channeler
######*/

#define SPELL_SHADOW_BOLT       (HeroicMode ? 15472 : 12739)

#define SPELL_MARK_OF_SHADOW    30937
#define SPELL_CHANNELING        39123

struct mob_shadowmoon_channelerAI : public ScriptedAI
{
    mob_shadowmoon_channelerAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());

        if (Creature *Kelidan = (Creature *)FindCreature(ENTRY_KELIDAN, 30, m_creature))
            ((boss_kelidan_the_breakerAI*)Kelidan->AI())->m_creature->GetPosition(kelidanWorldLoc);

        m_creature->GetPosition(summonerWorldLoc);
    }

    ScriptedInstance* pInstance;

    uint32 ShadowBolt_Timer;
    uint32 MarkOfShadow_Timer;
    uint32 check_Timer;

    WorldLocation kelidanWorldLoc;
    WorldLocation summonerWorldLoc;

    void Reset()
    {
        ShadowBolt_Timer = urand(1000, 2000);
        MarkOfShadow_Timer = urand(5000, 7000);
        check_Timer = 0;
        if (m_creature->IsNonMeleeSpellCasted(false))
            m_creature->InterruptNonMeleeSpells(true);
    }

    void EnterCombat(Unit* who)
    {
        if(Creature *Kelidan = (Creature *)FindCreature(ENTRY_KELIDAN, 100, m_creature))
            ((boss_kelidan_the_breakerAI*)Kelidan->AI())->ChannelerEngaged(who);

        if (m_creature->IsNonMeleeSpellCasted(false))
            m_creature->InterruptNonMeleeSpells(true);

        DoStartMovement(who);
    }

    void JustDied(Unit* Killer)
    {
       if(Creature *Kelidan = (Creature *)FindCreature(ENTRY_KELIDAN, 125, m_creature))
           ((boss_kelidan_the_breakerAI*)Kelidan->AI())->ChannelerDied(Killer);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
        {
            if (check_Timer < diff)
            {
                if (!m_creature->IsWithinDistInMap(&summonerWorldLoc, 0.5f))
                {
                    EnterEvadeMode();
                }
                else if (!m_creature->IsNonMeleeSpellCasted(false)) // Don't start channeling until reaching home position
                {
                    if (Creature *Kelidan = (Creature *)FindCreature(ENTRY_KELIDAN, 30, m_creature))
                    {
                        uint64 channeler = ((boss_kelidan_the_breakerAI*)Kelidan->AI())->GetChanneled(m_creature);
                        if (Unit *channeled = Unit::GetUnit(*m_creature, channeler))
                            DoCast(channeled, SPELL_CHANNELING);
                    }
                }

                check_Timer = 5000;
            }
            else
                check_Timer -= diff;

            return;
        }

        if (UpdateVictim())
        {
            if (check_Timer < diff)
            {
                if (!m_creature->IsWithinDistInMap(&kelidanWorldLoc, 120.0f)) // If they die too far away from Kelidan he will be forever non-attackable. 
                {
                    EnterEvadeMode();
                }

                check_Timer = 5000;
            }
            else
                check_Timer -= diff;
        }

        if (MarkOfShadow_Timer < diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0))
                AddSpellToCast(target,SPELL_MARK_OF_SHADOW);

            MarkOfShadow_Timer = 15000+rand()%5000;
        }
        else
            MarkOfShadow_Timer -=diff;

        if (ShadowBolt_Timer < diff)
        {
            AddSpellToCast(me->getVictim(), SPELL_SHADOW_BOLT);
            ShadowBolt_Timer = urand(5000, 6000);
        }
        else
            ShadowBolt_Timer -=diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_shadowmoon_channeler(Creature *_Creature)
{
    return new mob_shadowmoon_channelerAI (_Creature);
}

void AddSC_boss_kelidan_the_breaker()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_kelidan_the_breaker";
    newscript->GetAI = &GetAI_boss_kelidan_the_breaker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_shadowmoon_channeler";
    newscript->GetAI = &GetAI_mob_shadowmoon_channeler;
    newscript->RegisterSelf();
}

