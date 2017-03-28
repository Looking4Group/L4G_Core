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
SDName: Darkshore
SD%Complete: 20
SDComment: Placeholder Quest support 731, 945
SDCategory: Darkshore
EndScriptData */

/* ContentData
npc_prospector_remtravel
npc_therylune
npc_kerlonian
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"
#include "follower_ai.h"

/*####
# npc_kerlonian
####*/

enum
{
    SAY_KER_START = -1000434,

    EMOTE_KER_SLEEP_1 = -1000435,
    EMOTE_KER_SLEEP_2 = -1000436,
    EMOTE_KER_SLEEP_3 = -1000437,

    SAY_KER_SLEEP_1 = -1000438,
    SAY_KER_SLEEP_2 = -1000439,
    SAY_KER_SLEEP_3 = -1000440,
    SAY_KER_SLEEP_4 = -1000441,

    EMOTE_KER_AWAKEN = -1000445,

    SAY_KER_ALERT_1 = -1000442,
    SAY_KER_ALERT_2 = -1000443,

    SAY_KER_END = -1000444,

    SPELL_BEAR_FORM = 18309,
    SPELL_SLEEP_VISUAL = 25148,
    SPELL_AWAKEN = 17536,

    QUEST_SLEEPER_AWAKENED = 5321,

    NPC_LILADRIS = 11219                     // attackers entries unknown
};

// TODO: make concept similar as "ringo" -escort. Find a way to run the scripted attacks, _if_ player are choosing road.
struct npc_kerlonianAI : public FollowerAI
{
    npc_kerlonianAI(Creature* pCreature) : FollowerAI(pCreature) { Reset(); }

    uint32 m_uiFallAsleepTimer;

    void Reset() override
    {
        m_uiFallAsleepTimer = urand(10000, 45000);

        if (!HasFollowState(STATE_FOLLOW_INPROGRESS))
            DoCast(m_creature, SPELL_BEAR_FORM);
    }

    void MoveInLineOfSight(Unit* pWho) override
    {
        FollowerAI::MoveInLineOfSight(pWho);

        if (!m_creature->getVictim() && !HasFollowState(STATE_FOLLOW_COMPLETE) && pWho->GetEntry() == NPC_LILADRIS)
        {
            if (m_creature->IsWithinDistInMap(pWho, INTERACTION_DISTANCE * 5))
            {
                if (Player* pPlayer = GetLeaderForFollower())
                {
                    if (pPlayer->GetQuestStatus(QUEST_SLEEPER_AWAKENED) == QUEST_STATUS_INCOMPLETE)
                        pPlayer->GroupEventHappens(QUEST_SLEEPER_AWAKENED, m_creature);

                    DoScriptText(SAY_KER_END, m_creature);
                }

                SetFollowComplete();
            }
        }
    }

    void SpellHit(Unit* pCaster, const SpellEntry* pSpell)
    {
        if (HasFollowState(STATE_FOLLOW_INPROGRESS | STATE_FOLLOW_PAUSED) && pSpell->Id == SPELL_AWAKEN)
            ClearSleeping();
    }

    // Function to set npc to sleep mode
    void SetSleeping()
    {
        SetFollowPaused(true);

        switch (urand(0, 2))
        {
        case 0: DoScriptText(EMOTE_KER_SLEEP_1, m_creature); break;
        case 1: DoScriptText(EMOTE_KER_SLEEP_2, m_creature); break;
        case 2: DoScriptText(EMOTE_KER_SLEEP_3, m_creature); break;
        }

        switch (urand(0, 3))
        {
        case 0: DoScriptText(SAY_KER_SLEEP_1, m_creature); break;
        case 1: DoScriptText(SAY_KER_SLEEP_2, m_creature); break;
        case 2: DoScriptText(SAY_KER_SLEEP_3, m_creature); break;
        case 3: DoScriptText(SAY_KER_SLEEP_4, m_creature); break;
        }

        DoCast(m_creature, SPELL_SLEEP_VISUAL);
        m_creature->SetStandState(UNIT_STAND_STATE_SLEEP);
    }

    // Function to clear sleep mode
    void ClearSleeping()
    {
        m_creature->RemoveAurasDueToSpell(SPELL_SLEEP_VISUAL);
        m_creature->SetStandState(UNIT_STAND_STATE_STAND);

        DoScriptText(EMOTE_KER_AWAKEN, m_creature);

        SetFollowPaused(false);
    }

    void UpdateFollowerAI(const uint32 uiDiff) override
    {
        if (!UpdateVictim())
        {
            if (!HasFollowState(STATE_FOLLOW_INPROGRESS))
                return;

            if (!HasFollowState(STATE_FOLLOW_PAUSED))
            {
                if (m_uiFallAsleepTimer < uiDiff)
                {
                    SetSleeping();
                    m_uiFallAsleepTimer = urand(25000, 90000);
                }
                else
                    m_uiFallAsleepTimer -= uiDiff;
            }

            return;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_kerlonian(Creature* pCreature)
{
    return new npc_kerlonianAI(pCreature);
}

bool QuestAccept_npc_kerlonian(Player* pPlayer, Creature* pCreature, const Quest* pQuest)
{
    if (pQuest->GetQuestId() == QUEST_SLEEPER_AWAKENED)
    {
        if (npc_kerlonianAI* pKerlonianAI = dynamic_cast<npc_kerlonianAI*>(pCreature->AI()))
        {
            pCreature->RemoveAurasDueToSpell(SPELL_BEAR_FORM);
            pCreature->SetStandState(UNIT_STAND_STATE_STAND);
            DoScriptText(SAY_KER_START, pCreature, pPlayer);
            pKerlonianAI->StartFollow(pPlayer, FACTION_ESCORT_N_FRIEND_PASSIVE, pQuest);
        }
    }

    return true;
}

/*######
## npc_prospector_remtravel
######*/

#define Q_Absent_Minded_Prospector 731
#define SAY_prospector_ACC     -1581001
#define SAY_prospector_AGGRO_1 -1581011
#define SAY_prospector_AGGRO_2 -1581012
#define SAY_prospector_AGGRO_3 -1581013
#define SAY_prospector_COMP    -1581010

struct npc_prospector_remtravel : public npc_escortAI
{
    npc_prospector_remtravel(Creature *c) : npc_escortAI(c) {}

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();

        if (!player)
            return;

        switch(i) {
        case 10: DoScriptText(-1581002, m_creature);break;
        case 12: DoScriptText(-1581003, m_creature);break;
        case 14: DoScriptText(-1581004, m_creature);break;
        case 16: DoScriptText(-1581005, m_creature);break;
        case 17:
            DoScriptText(-1581006, m_creature);
            m_creature->SummonCreature(2158, 4628.38, 638.456, 6.402, 6.20, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            m_creature->SummonCreature(2158, 4625.13, 645.962, 6.73182, 6.27, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            break;
        case 25: DoScriptText(-1581007, m_creature);break;
        case 32: DoScriptText(-1581008, m_creature);break;
        case 35:
            m_creature->SummonCreature(2158, 4570.04, 557.292, 1.989, 6.20, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            m_creature->SummonCreature(2159, 4573.17, 557.583, 3.328, 6.27, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            m_creature->SummonCreature(2160, 4564.94, 551.357, 5.91, 6.27, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            break;
        case 42: DoScriptText(-1581009, m_creature);break;
        case 56:
            DoScriptText(SAY_prospector_COMP, m_creature, player);
            player->GroupEventHappens(Q_Absent_Minded_Prospector, m_creature);
            break;
        }
    }

    void Reset(){}

    void EnterCombat(Unit* who)
    {
        DoScriptText(RAND(SAY_prospector_AGGRO_1, SAY_prospector_AGGRO_2, SAY_prospector_AGGRO_3), m_creature);

        m_creature->Attack(who, true);
    }

    void JustSummoned(Creature* summoned)
    {
        summoned->AI()->AttackStart(m_creature);
    }
};

CreatureAI* GetAI_npc_prospector_remtravel(Creature *_Creature)
{
    npc_prospector_remtravel* prospector_remtravel = new npc_prospector_remtravel(_Creature);

    prospector_remtravel->AddWaypoint(0, 4677.35, 582.882, 21.3481);
    prospector_remtravel->AddWaypoint(1, 4673.13, 582.741, 20.7995);
    prospector_remtravel->AddWaypoint(2, 4672.99, 593.263, 17.5914);
    prospector_remtravel->AddWaypoint(3, 4668.94, 600.76, 14.6225);
    prospector_remtravel->AddWaypoint(4, 4659.59, 609.162, 9.36938);
    prospector_remtravel->AddWaypoint(5, 4651.6, 615.518, 8.56175);
    prospector_remtravel->AddWaypoint(6, 4644, 621.083, 8.57906);
    prospector_remtravel->AddWaypoint(7, 4634.77, 624.85, 7.57635);
    prospector_remtravel->AddWaypoint(8, 4633.5, 631.041, 6.61543);
    prospector_remtravel->AddWaypoint(9, 4634.23, 633.058, 7.01277);
    prospector_remtravel->AddWaypoint(10, 4640.83, 638.327, 13.4057);
    prospector_remtravel->AddWaypoint(11, 4645.78, 633.204, 13.4303);
    prospector_remtravel->AddWaypoint(12, 4639.92, 637.669, 13.3612);
    prospector_remtravel->AddWaypoint(13, 4636.84, 635.289, 10.3009);
    prospector_remtravel->AddWaypoint(14, 4630.55, 631.307, 6.32709);
    prospector_remtravel->AddWaypoint(15, 4627.73, 637.741, 6.36486);
    prospector_remtravel->AddWaypoint(16, 4622.89, 637.517, 6.31533);
    prospector_remtravel->AddWaypoint(17, 4625.13, 645.962, 6.73182);
    prospector_remtravel->AddWaypoint(18, 4628.38, 638.456, 6.402);
    prospector_remtravel->AddWaypoint(19, 4615.94, 640.499, 6.67037);
    prospector_remtravel->AddWaypoint(20, 4624.88, 635.098, 6.30605);
    prospector_remtravel->AddWaypoint(21, 4623.39, 631.595, 6.24625);
    prospector_remtravel->AddWaypoint(22, 4617.66, 631.987, 6.25943);
    prospector_remtravel->AddWaypoint(23, 4614.22, 619.818, 5.84416);
    prospector_remtravel->AddWaypoint(24, 4609.45, 613.739, 5.24473);
    prospector_remtravel->AddWaypoint(25, 4599.65, 607.006, 1.94703);
    prospector_remtravel->AddWaypoint(26, 4589.98, 599.73, 1.16939);
    prospector_remtravel->AddWaypoint(27, 4581.11, 593.133, 1.01014);
    prospector_remtravel->AddWaypoint(28, 4565.69, 582.105, 1.04814);
    prospector_remtravel->AddWaypoint(29, 4558.03, 571.718, 1.28869);
    prospector_remtravel->AddWaypoint(30, 4553.65, 566.054, 5.31751);
    prospector_remtravel->AddWaypoint(31, 4550.6, 562.106, 7.30321);
    prospector_remtravel->AddWaypoint(32, 4544.58, 568.095, 7.27242);
    prospector_remtravel->AddWaypoint(33, 4551.83, 564.466, 7.19855);
    prospector_remtravel->AddWaypoint(34, 4557.01, 571.599, 1.27336);
    prospector_remtravel->AddWaypoint(35, 4565.46, 557.54, 3.03739);
    prospector_remtravel->AddWaypoint(36, 4564.94, 551.357, 5.91);
    prospector_remtravel->AddWaypoint(37, 4573.17, 557.583, 3.328);
    prospector_remtravel->AddWaypoint(39, 4570.04, 557.292, 1.989);
    prospector_remtravel->AddWaypoint(40, 4578.1, 565.285, 1.02112);
    prospector_remtravel->AddWaypoint(41, 4589.62, 564.402, 0.923398);
    prospector_remtravel->AddWaypoint(42, 4595.54, 572.613, 1.10837);
    prospector_remtravel->AddWaypoint(43, 4600.8, 572.295, 1.23612);
    prospector_remtravel->AddWaypoint(45, 4607.06, 566.704, 1.26906);
    prospector_remtravel->AddWaypoint(46, 4590.98, 571.303, 1.13302);
    prospector_remtravel->AddWaypoint(47, 4574.5, 571.384, 1.10307);
    prospector_remtravel->AddWaypoint(48, 4575.81, 581.597, 0.979237);
    prospector_remtravel->AddWaypoint(49, 4600.36, 604.279, 2.03134);
    prospector_remtravel->AddWaypoint(50, 4614.11, 613.762, 5.50871);
    prospector_remtravel->AddWaypoint(51, 4629.06, 620.1, 6.59015);
    prospector_remtravel->AddWaypoint(52, 4636.06, 624.593, 7.78406);
    prospector_remtravel->AddWaypoint(53, 4640.59, 625.475, 8.21139);
    prospector_remtravel->AddWaypoint(54, 4656.98, 613.055, 8.56197);
    prospector_remtravel->AddWaypoint(55, 4675.34, 598.581, 17.3818);
    prospector_remtravel->AddWaypoint(56, 4687.96, 590.182, 23.839,5000);

    return (CreatureAI*)prospector_remtravel;
}

bool QuestAccept_npc_prospector_remtravel(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == Q_Absent_Minded_Prospector)
    {
        creature->setFaction(113);
        creature->SetHealth(creature->GetMaxHealth());
        creature->SetUInt32Value(UNIT_FIELD_BYTES_1,0);
        creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2);
        DoScriptText(SAY_prospector_ACC, creature, player);
        ((npc_escortAI*)creature->AI())->Start(true, false, player->GetGUID(), quest);
    }
    return true;
}

/*######
## npc_therylune
######*/

#define Q_Therylune_Escape 945
#define SAY_therylune_ACC     -1581014
#define SAY_therylune_COMP    -1581015

struct npc_therylune : public npc_escortAI
{
    npc_therylune(Creature *c) : npc_escortAI(c) {}

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();

        if (!player)
            return;

        switch(i) {
        case 20:
            DoScriptText(SAY_therylune_COMP, m_creature, player);
            player->GroupEventHappens(Q_Therylune_Escape, m_creature);
            break;
        }
    }

    void Reset(){}

    void EnterCombat(Unit* who)
    {
        m_creature->Attack(who, true);
    }

    void JustDied(Unit* killer)
    {
        if (Player* player = GetPlayerForEscort())
            player->FailQuest(Q_Therylune_Escape);
    }


    void UpdateAI(const uint32 diff)
    {
        npc_escortAI::UpdateAI(diff);
        if (!UpdateVictim())
            return;
    }
};

bool QuestAccept_npc_therylune(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == Q_Therylune_Escape)
    {
        creature->setFaction(113);
        creature->SetHealth(creature->GetMaxHealth());
        creature->SetUInt32Value(UNIT_FIELD_BYTES_1,0);
        creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2);
        DoScriptText(SAY_therylune_ACC, creature, player);
        ((npc_escortAI*)creature->AI())->Start(true, true, player->GetGUID(), quest);

    }
    return true;
}

CreatureAI* GetAI_npc_therylune(Creature *_Creature)
{
    npc_therylune* therylune = new npc_therylune(_Creature);

    therylune->AddWaypoint(0, 4520.4, 420.235, 33.5284);
    therylune->AddWaypoint(1,  4512.26, 408.881, 32.9308);
    therylune->AddWaypoint(2,  4507.94, 396.47, 32.9476);
    therylune->AddWaypoint(3,  4507.53, 383.781, 32.995);
    therylune->AddWaypoint(4,  4512.1, 374.02, 33.166);
    therylune->AddWaypoint(5,  4519.75, 373.241, 33.1574);
    therylune->AddWaypoint(6, 4592.41, 369.127, 31.4893);
    therylune->AddWaypoint(7,  4598.55, 364.801, 31.4947);
    therylune->AddWaypoint(8,  4602.76, 357.649, 32.9265);
    therylune->AddWaypoint(9,  4597.88, 352.629, 34.0317);
    therylune->AddWaypoint(10,  4590.23, 350.9, 36.2977);
    therylune->AddWaypoint(11,  4581.5, 348.254, 38.3878);
    therylune->AddWaypoint(12,  4572.05, 348.059, 42.3539);
    therylune->AddWaypoint(13,  4564.75, 344.041, 44.2463);
    therylune->AddWaypoint(14,  4556.63, 341.003, 47.6755);
    therylune->AddWaypoint(15,  4554.38, 334.968, 48.8003);
    therylune->AddWaypoint(16,  4557.63, 329.783, 49.9532);
    therylune->AddWaypoint(17,  4563.32, 316.829, 53.2409);
    therylune->AddWaypoint(18,  4566.09, 303.127, 55.0396);
    therylune->AddWaypoint(19, 4561.65, 295.456, 57.0984);
    therylune->AddWaypoint(20,  4551.03, 293.333, 57.1534);
    return (CreatureAI*)therylune;
}

/*######
## AddSC
######*/

void AddSC_darkshore()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_kerlonian";
    newscript->GetAI = &GetAI_npc_kerlonian;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_kerlonian;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_prospector_remtravel";
    newscript->GetAI = &GetAI_npc_prospector_remtravel;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_prospector_remtravel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_therylune";
    newscript->GetAI = &GetAI_npc_therylune;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_therylune;
    newscript->RegisterSelf();
}
