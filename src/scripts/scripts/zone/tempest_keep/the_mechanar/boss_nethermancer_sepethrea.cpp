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
SDName: Boss_Nethermancer_Sepethrea
SD%Complete: 99
SDComment: Check melee dmg and immunities
SDCategory: Tempest Keep, The Mechanar
EndScriptData */

#include "precompiled.h"
#include "def_mechanar.h"

enum NethermancerSepethrea
{
    AGGRO_RANGE                 = 24,
    SAY_AGGRO                   = -1554013,
    SAY_SUMMON                  = -1554014,
    SAY_DRAGONS_BREATH_1        = -1554015,
    SAY_DRAGONS_BREATH_2        = -1554016,
    SAY_SLAY1                   = -1554017,
    SAY_SLAY2                   = -1554018,
    SAY_DEATH                   = -1554019,

    SPELL_SUMMON_RAGIN_FLAMES   = 35275,
    H_SPELL_SUMMON_RAGIN_FLAMES = 39084,
    SPELL_FROST_ATTACK          = 45195,
    SPELL_ARCANE_BLAST          = 35314,
    SPELL_DRAGONS_BREATH        = 35250
};


struct boss_nethermancer_sepethreaAI : public ScriptedAI
{
    boss_nethermancer_sepethreaAI(Creature *c) : ScriptedAI(c), summons(me)
    {
        pInstance = c->GetInstanceData();
        HeroicMode = me->GetMap()->IsHeroic();
        me->GetPosition(wLoc);
        me->SetAggroRange(AGGRO_RANGE);
    }

    ScriptedInstance *pInstance;
    WorldLocation wLoc;
    bool HeroicMode;

    uint32 arcane_blast_Timer;
    uint32 dragons_breath_Timer;
    uint32 resummon_Timer;
    uint32 check_Timer;

    SummonList summons;

    void Reset()
    {
        arcane_blast_Timer = urand(12000, 18000);
        dragons_breath_Timer = urand(22000, 28000);
        resummon_Timer = 900000;
        check_Timer = 6000;

        pInstance->SetData(DATA_NETHERMANCER_EVENT, NOT_STARTED);

        summons.DespawnAll();
    }

    void EnterCombat(Unit *who)
    {
        pInstance->SetData(DATA_NETHERMANCER_EVENT, IN_PROGRESS);

        DoScriptText(SAY_AGGRO, me);
        AddSpellToCast(HeroicMode ? H_SPELL_SUMMON_RAGIN_FLAMES : SPELL_SUMMON_RAGIN_FLAMES, CAST_SELF);
    }

    void KilledUnit(Unit* victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2), me);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, me);
        pInstance->SetData(DATA_NETHERMANCER_EVENT, DONE);
        pInstance->SetData(DATA_BRIDGE_EVENT, DONE);
        summons.DespawnAll();
    }

    void JustSummoned(Creature * summoned)
    {
        if (summoned)
            summons.Summon(summoned);
    }

    void DamageMade(Unit* target, uint32 & , bool direct, uint8 school_mask)
    {
        if (direct && !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED))
            if(roll_chance_i(40))
                me->CastSpell(target, SPELL_FROST_ATTACK, true);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim() )
            return;

        if (check_Timer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 80.0f))
                EnterEvadeMode();
            else
                DoZoneInCombat();

            check_Timer = 3000;
        }
        else
            check_Timer -= diff;

        //Arcane Blast with knockback, reducing threat by 50%
        if (arcane_blast_Timer < diff)
        {
            AddSpellToCast(SPELL_ARCANE_BLAST, CAST_TANK);
            arcane_blast_Timer = urand(15000, 30000);
            me->getThreatManager().modifyThreatPercent(me->getVictim(), -50.0f);
        }
        else
            arcane_blast_Timer -= diff;

        if (dragons_breath_Timer < diff)
        {
            AddSpellToCast(SPELL_DRAGONS_BREATH, CAST_TANK, false, true);
            {
                if (urand(0, 1))
                    DoScriptText(urand(0, 1) ? SAY_DRAGONS_BREATH_1 : SAY_DRAGONS_BREATH_2, m_creature);

                dragons_breath_Timer = urand(20000, 35000);
            }
        }
        else
            dragons_breath_Timer -= diff;

        if(resummon_Timer)
        {
            if (resummon_Timer <= diff)
            {
                DoScriptText(SAY_SUMMON, me);
                AddSpellToCast(HeroicMode ? H_SPELL_SUMMON_RAGIN_FLAMES : SPELL_SUMMON_RAGIN_FLAMES, CAST_SELF);
                resummon_Timer = 900000;
            }
            else
                resummon_Timer -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_nethermancer_sepethrea(Creature *_Creature)
{
    return new boss_nethermancer_sepethreaAI (_Creature);
}

enum RagingFlames
{
    // SPELL_INFERNO_NH    = 35268, using 39346 only as 35268 doesnt trigger periodic, could be ported to db if all spells would work as intended.
    SPELL_INFERNO_HC    = 39346,
    SPELL_RAGING_FLAMES = 35278
};

struct mob_ragin_flamesAI : public ScriptedAI
{
    mob_ragin_flamesAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        HeroicMode = me->GetMap()->IsHeroic();
    }

    ScriptedInstance *pInstance;

    bool HeroicMode;
    bool canMelee;
    uint32 infernoTimer;
    uint64 currentTarget;

    void Reset()
    {
        infernoTimer = urand(15700, 31300);
        canMelee = true;
        me->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, true);
        SetAutocast(SPELL_RAGING_FLAMES, HeroicMode ? 700 : 1200, true, CAST_SELF);
    }

    void ChangeTarget()
    {
        if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 500, true, me->getVictimGUID()))
        {
            Unit * prevTarUnit = me->GetMap()->GetUnit(currentTarget);
            if (prevTarUnit)
                me->AddThreat(prevTarUnit, -5000000.0f);

            currentTarget = target->GetGUID();
            me->AI()->AttackStart(target);
            me->AddThreat(target, 5000000.0f);
        }
    }

    void JustRespawned()
    {
        DoZoneInCombat();
        ChangeTarget();
    }

    void OnAuraApply(Aura* aur, Unit* caster, bool stackApply)
    {
        if (aur->GetId() == (SPELL_INFERNO_HC))
        {
            StopAutocast();
            canMelee = false;
        }
    }

    void OnAuraRemove(Aura* aur, bool stackApply)
    {
        if (aur->GetId() == (SPELL_INFERNO_HC))
        {
            StartAutocast();
            ChangeTarget();
            canMelee = true;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (infernoTimer < diff)
        {
            AddSpellToCast(SPELL_INFERNO_HC, CAST_SELF);
            infernoTimer = urand(15700, 28900);
        }
        else
            infernoTimer -= diff;

        CastNextSpellIfAnyAndReady(diff);
        if(canMelee)
            DoMeleeAttackIfReady();
    }

};

CreatureAI* GetAI_mob_ragin_flames(Creature *_Creature)
{
    return new mob_ragin_flamesAI (_Creature);
}

void AddSC_boss_nethermancer_sepethrea()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_nethermancer_sepethrea";
    newscript->GetAI = &GetAI_boss_nethermancer_sepethrea;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_ragin_flames";
    newscript->GetAI = &GetAI_mob_ragin_flames;
    newscript->RegisterSelf();
}
