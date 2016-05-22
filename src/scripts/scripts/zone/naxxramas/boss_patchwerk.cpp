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
SDName: Boss_Patchwerk
SD%Complete: 100 ?
SDComment: Some issues with hateful strike inturrupting the melee swing timer ?
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

enum PatchwerkTexts
{
    SAY_AGGRO1              = -1533017,
    SAY_AGGRO2              = -1533018,
    SAY_SLAY                = -1533019,
    SAY_DEATH               = -1533020,

    EMOTE_BERSERK           = -1533021,
    EMOTE_ENRAGE            = -1533022
};

enum PatchwerkSpells
{
    SPELL_HATEFULSTRIKE     = 28308,
    SPELL_ENRAGE            = 2813,
    SPELL_SLIMEBOLT         = 32309,
    SPELL_BERSERK           = 26662
};

enum PatchwerkEvents
{
    EVENT_HATEFULLSTRIKE    = 1,
    EVENT_BERSERK           = 2,
    EVENT_SLIMEBOLT         = 3
};

struct boss_patchwerkAI : public BossAI
{
    boss_patchwerkAI(Creature* c) : BossAI(c, DATA_PATCHWERK) { }

    bool Enraged;

    void Reset()
    {
        events.Reset();
        events.ScheduleEvent(EVENT_HATEFULLSTRIKE, 1200);   // 1.2 seconds
        events.ScheduleEvent(EVENT_BERSERK, 420000);        // 7 minutes 420,000
        events.ScheduleEvent(EVENT_SLIMEBOLT, 450000);      // 7.5 minutes 450,000

        Enraged = false;

        instance->SetData(DATA_PATCHWERK, NOT_STARTED);
    }

    void KilledUnit(Unit* Victim)
    {
        if (rand()%5)
            return;

        DoScriptText(SAY_SLAY, m_creature);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, m_creature);
        instance->SetData(DATA_PATCHWERK, DONE);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO1, SAY_AGGRO2), m_creature);
        instance->SetData(DATA_PATCHWERK, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_COMBAT_N_SPEED, 200.0f, 1.5f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_HATEFULLSTRIKE:
                {
                    Unit * target = SelectUnit(SELECT_TARGET_HIGHEST_HP, 0, m_creature->GetCombatReach(), true);

                    if (!target)
                        target = me->getVictim();

                    if (target)
                        AddSpellToCast(target, SPELL_HATEFULSTRIKE);

                    events.ScheduleEvent(EVENT_HATEFULLSTRIKE, 1200);
                    break;
                }
                case EVENT_BERSERK:
                {
                    AddSpellToCastWithScriptText(SPELL_BERSERK, CAST_SELF, EMOTE_BERSERK);
                    break;
                }
                case EVENT_SLIMEBOLT:
                {
                    AddSpellToCast(SPELL_SLIMEBOLT, CAST_NULL);
                    events.ScheduleEvent(EVENT_SLIMEBOLT, 5000);
                    break;
                }
                default:
                    break;
            }
        }

        //Enrage if not already enraged and below 5%
        if (!Enraged && HealthBelowPct(5))
        {
            ForceSpellCastWithScriptText(m_creature, SPELL_ENRAGE, EMOTE_ENRAGE);
            Enraged = true;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_patchwerk(Creature *_Creature)
{
    return new boss_patchwerkAI (_Creature);
}

void AddSC_boss_patchwerk()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_patchwerk";
    newscript->GetAI = &GetAI_boss_patchwerk;
    newscript->RegisterSelf();
}
