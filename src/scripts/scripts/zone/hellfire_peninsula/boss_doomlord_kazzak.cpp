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
SDName: Boss_Doomlord_Kazzak
SD%Complete: 70
SDComment: Using incorrect spell for Mark of Kazzak
SDCategory: Hellfire Peninsula
EndScriptData */

#include "precompiled.h"

#define EVENT_KAZZAK 1

enum eTexts
{
    SAY_INTRO     = -1000375,
    SAY_AGGRO1    = -1000376,
    SAY_AGGRO2    = -1000377,
    SAY_SURPREME1 = -1000378,
    SAY_SURPREME2 = -1000379,
    SAY_KILL1     = -1000380,
    SAY_KILL2     = -1000381,
    SAY_KILL3     = -1000382,
    SAY_DEATH     = -1000383,
    EMOTE_FRENZY  = -1000384,
    SAY_RAND1     = -1000385,
    SAY_RAND2     = -1000386,
};

enum eSpells
{
    SPELL_SHADOWVOLLEY      = 32963,
    SPELL_CLEAVE            = 31779,
    SPELL_THUNDERCLAP       = 36706,
    SPELL_VOIDBOLT          = 39329,
    SPELL_MARKOFKAZZAK      = 32960,
    SPELL_ENRAGE            = 32964,
    SPELL_CAPTURESOUL       = 32966,
    SPELL_TWISTEDREFLECTION = 21063,
};

enum
{
    EVENT_SHADOW_VOLLEY = 1,
    EVENT_CLEAVE        = 2,
    EVENT_THUNDER_CLAP  = 3,
    EVENT_MARKOFKAZZAK  = 4,
    EVENT_TWIST_REFLECT = 5,
    EVENT_VOID_BOLT     = 6,

    EVENT_ENRAGE        = 7
};
struct boss_doomlordkazzakAI : public BossAI
{
    boss_doomlordkazzakAI(Creature *c) : BossAI(c, EVENT_KAZZAK) {}

    void Reset()
    {
        events.Reset();
        ClearCastQueue();

        events.ScheduleEvent(EVENT_SHADOW_VOLLEY, 3000);
        events.ScheduleEvent(EVENT_CLEAVE, 5000);
        events.ScheduleEvent(EVENT_THUNDER_CLAP, urand(12000, 20000));
        events.ScheduleEvent(EVENT_VOID_BOLT, 30000);
        events.ScheduleEvent(EVENT_MARKOFKAZZAK, 25000);
        events.ScheduleEvent(EVENT_TWIST_REFLECT, 33000);

        events.ScheduleEvent(EVENT_ENRAGE, 60000);

        QueryResultAutoPtr resultWorldBossRespawn = QueryResultAutoPtr(NULL); 
        resultWorldBossRespawn = GameDataDatabase.PQuery("SELECT RespawnTime FROM worldboss_respawn WHERE BossEntry = %i", m_creature->GetEntry());
        if (resultWorldBossRespawn)
        {
            Field* fieldsWBR = resultWorldBossRespawn->Fetch();
            uint64 last_time_killed = fieldsWBR[0].GetUInt64();
            last_time_killed += 259200;
            if (last_time_killed >= time(0))
                me->DisappearAndDie();
        }
    }

    void JustRespawned()
    {
        DoScriptText(SAY_INTRO, me);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO1, SAY_AGGRO2), me);
    }

    void KilledUnit(Unit* pVictim)
    {
        if (pVictim->ToPlayer())
            return;

        if (!HealthBelowPct(1))
            ForceSpellCast(SPELL_CAPTURESOUL, CAST_SELF);

        DoScriptText(RAND(SAY_KILL1, SAY_KILL2, SAY_KILL3), me);
    }

    void JustDied(Unit *victim)
    {
        DoScriptText(SAY_DEATH, me);
        GameDataDatabase.PExecute("REPLACE INTO worldboss_respawn VALUES (%i, UNIX_TIMESTAMP())", m_creature->GetEntry());
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoSpecialThings(diff, DO_EVADE_CHECK, 60.0f);

        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SHADOW_VOLLEY:
                {
                    AddSpellToCast(SPELL_SHADOWVOLLEY, CAST_NULL);
                    events.ScheduleEvent(EVENT_SHADOW_VOLLEY, 3000);
                    break;
                }
                case EVENT_CLEAVE:
                {
                    AddSpellToCast(SPELL_CLEAVE);
                    events.ScheduleEvent(EVENT_CLEAVE, urand(8000, 12000));
                    break;
                }
                case EVENT_THUNDER_CLAP:
                {
                    AddSpellToCast(SPELL_THUNDERCLAP, CAST_SELF);
                    events.ScheduleEvent(EVENT_THUNDER_CLAP, urand(10000, 14000));
                    break;
                }
                case EVENT_MARKOFKAZZAK:
                {
                    if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 60.0, true, POWER_MANA))
                        AddSpellToCast(pTarget, SPELL_MARKOFKAZZAK);

                    events.ScheduleEvent(EVENT_MARKOFKAZZAK, 20000);
                    break;
                }
                case EVENT_TWIST_REFLECT:
                {
                    if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                        AddSpellToCast(pTarget, SPELL_TWISTEDREFLECTION);

                    events.ScheduleEvent(EVENT_TWIST_REFLECT, 15000);
                    break;
                }
                case EVENT_VOID_BOLT:
                {
                    AddSpellToCast(SPELL_VOIDBOLT);
                    events.ScheduleEvent(EVENT_VOID_BOLT, urand(15000, 18000));
                    break;
                }
                case EVENT_ENRAGE:
                {
                    AddSpellToCastWithScriptText(me, SPELL_ENRAGE, EMOTE_FRENZY);
                    events.ScheduleEvent(EVENT_ENRAGE, 40000);
                    events.RescheduleEvent(EVENT_SHADOW_VOLLEY, 12000);
                    break;
                }
                default:
                    break;
            }
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }

};

CreatureAI* GetAI_boss_doomlordkazzak(Creature *_Creature)
{
    return new boss_doomlordkazzakAI (_Creature);
}

void AddSC_boss_doomlordkazzak()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_doomlord_kazzak";
    newscript->GetAI = &GetAI_boss_doomlordkazzak;
    newscript->RegisterSelf();
}
