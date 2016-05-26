/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Boss_Vanndar
SD%Complete:
SDComment: Some spells listed on wowwiki but doesn't exist on wowhead
EndScriptData */

#include "precompiled.h"

#define YELL_AGGRO              -2100008

#define YELL_EVADE              -2100009
#define YELL_RESPAWN1           -2100010
#define YELL_RESPAWN2           -2100011

#define YELL_RANDOM1            -2100012
#define YELL_RANDOM2            -2100013
#define YELL_RANDOM3            -2100014
#define YELL_RANDOM4            -2100015
#define YELL_RANDOM5            -2100016
#define YELL_RANDOM6            -2100017
#define YELL_RANDOM7            -2100018


#define SPELL_AVATAR            19135
#define SPELL_THUNDERCLAP       15588
#define SPELL_STORMBOLT         20685 // not sure

#define AV_VANDAR_NPC_COUNT     5

uint32 avVandarNpcIds[AV_VANDAR_NPC_COUNT] =
{
    14762,
    14763,
    14764,
    14765,
    11948
};

struct boss_vanndarAI : public ScriptedAI
{
    boss_vanndarAI(Creature *c) : ScriptedAI(c)
    {
        m_creature->GetPosition(wLoc);
    }

    uint32 AvatarTimer;
    uint32 ThunderclapTimer;
    uint32 StormboltTimer;
    uint32 YellTimer;
    uint32 CheckTimer;
    WorldLocation wLoc;

    void Reset()
    {
        AvatarTimer             = 3000;
        ThunderclapTimer        = 4000;
        StormboltTimer          = 6000;
        YellTimer               = urand(20000, 30000); //20 to 30 seconds
        CheckTimer              = 2000;
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(YELL_AGGRO, m_creature);

        // pull rest
        std::for_each(avVandarNpcIds, avVandarNpcIds + AV_VANDAR_NPC_COUNT,
                  [this, who] (uint32 a)->void
                  {
                        if (a == me->GetEntry())
                            return;

                        Creature * c = me->GetMap()->GetCreatureById(a);
                        if (c && c->isAlive() && c->IsAIEnabled && c->AI())
                            c->AI()->AttackStart(who);
                  });
    }

    void JustRespawned()
    {
        Reset();
        DoScriptText(RAND(YELL_RESPAWN1, YELL_RESPAWN2), m_creature);
    }

    void EnterEvadeMode()
    {
        if (!me->isInCombat() || me->IsInEvadeMode())
            return;

        CreatureAI::EnterEvadeMode();

        // evade rest
        std::for_each(avVandarNpcIds, avVandarNpcIds + AV_VANDAR_NPC_COUNT,
                  [this] (uint32 a)->void
                  {
                        if (a == me->GetEntry())
                            return;

                        Creature * c = me->GetMap()->GetCreatureById(a);
                        if (c && c->IsAIEnabled && c->AI())
                            c->AI()->EnterEvadeMode();
                  });
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CheckTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 20.0f))
                EnterEvadeMode();

            me->SetSpeed(MOVE_WALK, 2.0f, true);
            me->SetSpeed(MOVE_RUN, 2.0f, true);

            CheckTimer = 2000;
        }
        else
            CheckTimer -= diff;

        if (AvatarTimer < diff)
        {
            ForceSpellCast(m_creature->getVictim(), SPELL_AVATAR);
            AvatarTimer = urand(15000, 20000);
        }
        else
            AvatarTimer -= diff;

        if (ThunderclapTimer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_THUNDERCLAP);
            ThunderclapTimer = urand(5000, 15000);
        }
        else
            ThunderclapTimer -= diff;

        if (StormboltTimer < diff)
        {
            Unit * victim = SelectUnit(SELECT_TARGET_RANDOM, 1, 30.0f, true);
            if (victim)
                AddSpellToCast(victim, SPELL_STORMBOLT);
            StormboltTimer = urand(10000, 25000);
        }
        else
            StormboltTimer -= diff;

        if (YellTimer < diff)
        {
            DoScriptText(RAND(YELL_RANDOM1, YELL_RANDOM2, YELL_RANDOM3, YELL_RANDOM4, YELL_RANDOM5, YELL_RANDOM6, YELL_RANDOM7), m_creature);
            YellTimer = urand(20000, 30000); //20 to 30 seconds
        }
        else
            YellTimer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

enum AVVanndarOfficerSpells
{
    AV_VO_CHARGE    = 22911,
    AV_VO_CLEAVE    = 40504,
    AV_VO_DEMOSHOUT = 23511,
    AV_VO_WHIRLWIND = 13736,
    AV_VO_ENRAGE    = 8599
};

struct boss_vanndarOfficerAI : public ScriptedAI
{
    boss_vanndarOfficerAI(Creature *c) : ScriptedAI(c)
    {
        m_creature->GetPosition(wLoc);
    }

    uint32 chargeTimer;
    uint32 cleaveTimer;
    uint32 demoShoutTimer;
    uint32 whirlwindTimer;
    uint32 CheckTimer;
    WorldLocation wLoc;

    void Reset()
    {
        chargeTimer             = urand(7500, 20000);
        cleaveTimer             = urand(5000, 10000);
        demoShoutTimer          = urand(2000, 4000);
        whirlwindTimer          = urand(9000, 13000);
        CheckTimer              = 2000;
    }

    void EnterCombat(Unit *who)
    {
        // pull rest
        std::for_each(avVandarNpcIds, avVandarNpcIds + AV_VANDAR_NPC_COUNT,
                  [this, who] (uint32 a)->void
                  {
                        if (a == me->GetEntry())
                            return;

                        Creature * c = me->GetMap()->GetCreatureById(a);
                        if (c && c->isAlive() && c->IsAIEnabled && c->AI())
                            c->AI()->AttackStart(who);
                  });
    }

    void JustRespawned()
    {
        Reset();
    }

    void EnterEvadeMode()
    {
        if (!me->isInCombat() || me->IsInEvadeMode())
            return;

        CreatureAI::EnterEvadeMode();

        // evade rest
        std::for_each(avVandarNpcIds, avVandarNpcIds + AV_VANDAR_NPC_COUNT,
                  [this] (uint32 a)->void
                  {
                        if (a == me->GetEntry())
                            return;

                        Creature * c = me->GetMap()->GetCreatureById(a);
                        if (c && c->isInCombat() && c->IsAIEnabled && c->AI())
                            c->AI()->EnterEvadeMode();
                  });
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CheckTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 20.0f))
                EnterEvadeMode();

            me->SetSpeed(MOVE_WALK, 1.5f, true);
            me->SetSpeed(MOVE_RUN, 1.5f, true);

            CheckTimer = 2000;
        }
        else
            CheckTimer -= diff;

        if (chargeTimer < diff)
        {
            Unit * target = SelectUnit(SELECT_TARGET_RANDOM, 0, 25.0f, true, 0, 8.0f);

            if (target)
                AddSpellToCast(target, AV_VO_CHARGE);

            chargeTimer = urand(7500, 20000);
        }
        else
            chargeTimer -= diff;

        if (cleaveTimer < diff)
        {
            AddSpellToCast(AV_VO_CLEAVE, CAST_TANK);
            cleaveTimer = urand(5000, 10000);
        }
        else
            cleaveTimer -= diff;

        if (demoShoutTimer < diff)
        {
            AddSpellToCast(AV_VO_DEMOSHOUT, CAST_NULL);
            demoShoutTimer = urand(14000, 25000);
        }
        else
            demoShoutTimer -= diff;

        if (whirlwindTimer < diff)
        {
            AddSpellToCast(AV_VO_WHIRLWIND, CAST_SELF);
            whirlwindTimer = urand(9000, 13000);
        }
        else
            whirlwindTimer -= diff;


        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_vanndar(Creature *_Creature)
{
    return new boss_vanndarAI (_Creature);
}

CreatureAI* GetAI_boss_vanndarOfficer(Creature *_Creature)
{
    return new boss_vanndarOfficerAI (_Creature);
}

void AddSC_boss_vanndar()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_vanndar";
    newscript->GetAI = &GetAI_boss_vanndar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_vanndar_officer";
    newscript->GetAI = &GetAI_boss_vanndarOfficer;
    newscript->RegisterSelf();
}
