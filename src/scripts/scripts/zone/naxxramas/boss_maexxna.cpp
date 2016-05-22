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
SDName: Boss_Maexxna
SD%Complete: ??
SDComment:
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

enum MaexxnaSpells
{
    SPELL_WEB_WRAP          = 28622,    // Spell is normally used by the webtrap on the wall NOT by Maexxna
    SPELL_WEB_SPRAY         = 29484,
    SPELL_POISON_SHOCK      = 28741,
    SPELL_NECROTIC_POISON   = 28776,
//    SPELL_SUMMON_SPIDERLING = 29434,    // invalid ? Oo
    SPELL_ENRAGE            = 28747,
};

enum MaexxnaEvents
{
    EVENT_WEB_WRAP          = 1,
    EVENT_WEB_SPRAY         = 2,
    EVENT_POISON_SHOCK      = 3,
    EVENT_NECROTIC_POISON   = 4,
    EVENT_SUMMON_SPIDERLING = 5
};

#define MAEXXNA_SPIDERLING_ID   17055
#define WEB_WRAP_ID             16486

float webWrapLocations[3][3] =
{
    {3546.796,  -3869.082, 296.450},
    {3531.271, -3847.424, 299.450},
    {3497.067, -3843.384, 302.384}
};

struct mob_webwrapAI : public ScriptedAI
{
    mob_webwrapAI(Creature *c) : ScriptedAI(c) { }

    uint64 victimGUID;

    void Reset()
    {
        victimGUID = 0;
    }

    void SetVictim(Unit* victim)
    {
        if (victim)
        {
            victimGUID = victim->GetGUID();
            victim->CastSpell(victim, SPELL_WEB_WRAP, true);
        }
    }

    void JustDied(Unit * /*killer*/)
    {
        if (Unit * victim = me->GetUnit(victimGUID))
            victim->RemoveAurasDueToSpell(SPELL_WEB_WRAP);
    }

    void UpdateAI(const uint32 diff) { }
};

struct boss_maexxnaAI : public BossAI
{
    boss_maexxnaAI(Creature *c) : BossAI(c, DATA_MAEXXNA) { }

    bool enraged;

    void Reset()
    {
        enraged = false;
        events.Reset();
        events.ScheduleEvent(EVENT_WEB_WRAP, 20000);            // 20 sec init, 40 sec normal
        events.ScheduleEvent(EVENT_WEB_SPRAY, 40000);           // 40 seconds
        events.ScheduleEvent(EVENT_POISON_SHOCK, 20000);        // 20 seconds
        events.ScheduleEvent(EVENT_NECROTIC_POISON, 30000);     // 30 seconds
        events.ScheduleEvent(EVENT_SUMMON_SPIDERLING, 30000);   // 30 sec init, 40 sec normal

        instance->SetData(DATA_MAEXXNA, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        instance->SetData(DATA_MAEXXNA, IN_PROGRESS);
    }

    void JustDied(Unit * killer)
    {
        instance->SetData(DATA_MAEXXNA, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVERYTHING, 130.0f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_WEB_WRAP:
                {
                    std::list<Unit*> tmpList;
                    int i = 0;

                    SelectUnitList(tmpList, 3, SELECT_TARGET_RANDOM, 0.0f, true, me->getVictimGUID());

                    for (std::list<Unit*>::const_iterator itr = tmpList.begin(); itr != tmpList.end(); ++itr)
                    {
                        DoTeleportPlayer(*itr, webWrapLocations[i][0], webWrapLocations[i][1], webWrapLocations[i][2], (*itr)->GetOrientation());

                        // this can be done in nicer way by implementing script effect for 28673 to summon web wrap, linking this spell to web wrap spell and little changing web wrap AI ^^"
                        // but ... maybe in future xD
                        if (Creature * wrap = m_creature->SummonCreature(WEB_WRAP_ID, webWrapLocations[i][0], webWrapLocations[i][1], webWrapLocations[i][2], 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000))
                        {
                            wrap->setFaction(m_creature->getFaction());
                            ((mob_webwrapAI*)wrap->AI())->SetVictim(*itr);
                        }
                    }

                    events.ScheduleEvent(EVENT_WEB_WRAP, 40000);
                    break;
                }
                case EVENT_WEB_SPRAY:
                {
                    AddSpellToCast(SPELL_WEB_SPRAY, CAST_NULL);
                    events.ScheduleEvent(EVENT_WEB_SPRAY, 40000);
                    break;
                }
                case EVENT_POISON_SHOCK:
                {
                    AddSpellToCast(SPELL_POISON_SHOCK, CAST_NULL);
                    events.ScheduleEvent(EVENT_POISON_SHOCK, 20000);
                    break;
                }
                case EVENT_NECROTIC_POISON:
                {
                    AddSpellToCast(SPELL_NECROTIC_POISON, CAST_TANK);
                    events.ScheduleEvent(EVENT_NECROTIC_POISON, 30000);
                    break;
                }
                case EVENT_SUMMON_SPIDERLING:
                {
                    uint8 count = urand(8, 10);
                    Position tmpPos;
                    m_creature->GetPosition(tmpPos);

                    for (uint8 i = 0; i < count; ++i)
                        if (Creature * spiderling = m_creature->SummonCreature(MAEXXNA_SPIDERLING_ID, tmpPos.x, tmpPos.y, tmpPos.z, tmpPos.o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 20000))
                            if (Unit * tmpUnit = SelectUnit(SELECT_TARGET_RANDOM))
                                spiderling->AI()->AttackStart(tmpUnit);

                    events.ScheduleEvent(EVENT_SUMMON_SPIDERLING, 40000);
                    break;
                }
                default:
                    break;
            }
        }

        //Enrage if not already enraged and below 30%
        if (!enraged && HealthBelowPct(30))
        {
            ForceSpellCast(SPELL_ENRAGE, CAST_SELF);
            enraged = true;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_webwrap(Creature* _Creature)
{
    return new mob_webwrapAI (_Creature);
}

CreatureAI* GetAI_boss_maexxna(Creature *_Creature)
{
    return new boss_maexxnaAI (_Creature);
}

void AddSC_boss_maexxna()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_maexxna";
    newscript->GetAI = &GetAI_boss_maexxna;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_webwrap";
    newscript->GetAI = &GetAI_mob_webwrap;
    newscript->RegisterSelf();
}
