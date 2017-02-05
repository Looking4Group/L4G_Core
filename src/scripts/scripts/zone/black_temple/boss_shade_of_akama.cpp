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
SDName: Boss_Shade_of_Akama
SD%Complete: 90
SDComment: Seems to be complete.
SDCategory: Black Temple
EndScriptData */

#include "precompiled.h"
#include "def_black_temple.h"

#define SAY_DEATH                   -1564013
#define SAY_LOW_HEALTH              -1564014

// Ending cinematic text
#define SAY_FREE                    -1564015
#define SAY_BROKEN_FREE_01          -1564016
#define SAY_BROKEN_FREE_02          -1564017

#define CHANNELERS_COUNT 6
#define CHANNELERS_Z 118.538f

#define MAX_BROKEN 8

static float BrokenPositions[8][2] =
{
    {505.113, 355.168},
    {513.113, 364.402},
    {517.816, 376.878},
    {517.841, 396.493},
    {516.314, 407.241},
    {514.607, 426.291},
    {514.937, 437.125},
    {508.137, 445.109}
};

static float BrokenMoveTo[8][2] =
{
    {482.526, 367.918},
    {491.073, 371.607},
    {488.4, 383.502},
    {495.84, 394.657},
    {489.34, 410.812},
    {494.039, 424.049},
    {495.574, 436.208},
    {485.928, 443.373}
};

#define SPELL_STEALTH               34189
#define GOSSIP_ITEM                 "We are ready to fight alongside you, Akama"

struct Location
{
    float x, y, o, z;
};

#define SPAWN_Z 112.87f

#define AKAMA_X         514.78
#define AKAMA_Y         400.79
#define AKAMA_Z         112.78

static float moveTo[3][3] =
{
    { 470.00, 400.80, CHANNELERS_Z },
    { 482.45, 400.80, SPAWN_Z },
    { 505.50, 400.80, AKAMA_Z }
};

static float SpawnLocations[2][2]=
{
    { 499.30, 469.37 },
    { 499.06, 331.73 }
};

// Spells
#define SPELL_VERTEX_SHADE_BLACK    39833

#define SPELL_SHADE_SOUL_CHANNEL_CASTED_SPELL    40401
#define SPELL_SHADE_SOUL_CHANNEL_ACTUAL_AURA_SPELL  40520

#define SPELL_DESTRUCTIVE_POISON    40874
#define SPELL_CHAIN_LIGHTNING       40536

#define SPELL_AKAMA_SOUL_CHANNEL    40447
#define SPELL_AKAMA_SOUL_RETRIEVE   40902

#define AKAMA_SOUL_EXPEL            40855
#define SPELL_DEBILITATIG_STRIKE    41178
#define SPELL_SHIELD_BASH           41180
#define SPELL_HEROIC_STRIKE         41975

// Channeler entry
#define CREATURE_CHANNELER          23421
#define CREATURE_SORCERER           23215
#define CREATURE_DEFENDER           23216
#define CREATURE_BROKEN             23319

static const uint32 spawnEntries[3]= {23523, 23318, 23524};

struct mob_ashtongue_channelerAI : public ScriptedAI
{
    mob_ashtongue_channelerAI(Creature* c) : ScriptedAI(c)
    {
        instance = (ScriptedInstance *)c->GetInstanceData();
        ShadeGUID = 0;
    }

    ScriptedInstance *instance;
    uint64 ShadeGUID;
    bool m_channel;

    void Reset()
    {
        me->RemoveAurasDueToSpell(SPELL_SHADE_SOUL_CHANNEL_CASTED_SPELL);
        m_channel = true;
    }

    void OnAuraRemove(Aura *aura, bool stackRemove);
    void EnterCombat(Unit* who) {}
    void AttackStart(Unit* who) {}
    void MoveInLineOfSight(Unit* who) {}

    void UpdateAI(const uint32 diff)
    {
        if (!m_channel)
            return;

        if (ShadeGUID)
        {
            if (!me->GetUInt64Value(UNIT_FIELD_CHANNEL_OBJECT))
            {
                me->RemoveAurasDueToSpell(SPELL_SHADE_SOUL_CHANNEL_CASTED_SPELL);
                if (Unit *shade = me->GetUnit(*me, ShadeGUID))
                {
					if (shade->isAlive())
					{
						me->SetFacingToObject(shade);
						DoCast(shade, SPELL_SHADE_SOUL_CHANNEL_CASTED_SPELL);
					}


                }
            }
        }
        else
        {
            if (instance)
                ShadeGUID = instance->GetData64(DATA_SHADEOFAKAMA);
        }
    }
};

struct mob_ashtongue_sorcererAI : public ScriptedAI
{
    mob_ashtongue_sorcererAI(Creature* c) : ScriptedAI(c)
    {
        instance = (ScriptedInstance *)c->GetInstanceData();
    }

    ScriptedInstance *instance;

    uint32 m_checkTimer;
    uint64 m_shadeGUID;

    bool m_channeling;

    void Reset()
    {
        m_checkTimer = 1000;

        m_channeling = false;
        m_shadeGUID = instance->GetData64(DATA_SHADEOFAKAMA);
    }

    void OnAuraRemove(Aura *aura, bool stackRemove)
    {
        if (aura->GetSpellProto()->Id == SPELL_SHADE_SOUL_CHANNEL_CASTED_SPELL)
        {
            if (Unit *pShade = me->GetUnit(*me, m_shadeGUID))
                pShade->RemoveSingleAuraFromStack(SPELL_SHADE_SOUL_CHANNEL_ACTUAL_AURA_SPELL, 0);
        }
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if (type != POINT_MOTION_TYPE)
            return;

        if (Unit *pShade = me->GetUnit(*me, m_shadeGUID))
        {
            me->SetSelection(m_shadeGUID);
            DoCast(pShade, SPELL_SHADE_SOUL_CHANNEL_CASTED_SPELL);
        }

        m_channeling = true;
    }

    void EnterCombat(Unit* who) {}
    void AttackStart(Unit* who) {}
    void MoveInLineOfSight(Unit* who) {}
    void UpdateAI(const uint32 diff)
    {
        if (!m_channeling)
            return;

        if (m_checkTimer < diff)
        {
            if (!me->IsNonMeleeSpellCasted(true, false, true)) // that shouldn't happen
            {
                if (Unit *pShade = me->GetUnit(*me, m_shadeGUID))
                {
                    if (pShade->isAlive())
                    {
                        me->SetSelection(m_shadeGUID);
                        DoCast(pShade, SPELL_SHADE_SOUL_CHANNEL_CASTED_SPELL);
                    }
                }
            }
            m_checkTimer = 1000;

        }
        else
            m_checkTimer -= diff;
    }
};

enum phases
{
	NOT_YET_STARTED				= 0,
    START_EVENT					= 1,  // start event
	GAUNTLET					= 2,
    AKAMA_FIGHTS				= 3,  // start fight with akama
    AKAMA_DEATHS				= 4  // Akama dies after 60s of fight with shade
};

enum deadAdds
{
	ZERO_ADD_DEAD = 0,
	ONE_ADD_DEAD = 1,
	TWO_ADD_DEAD = 2,
	THREE_ADD_DEAD = 3,
	FOUR_ADD_DEAD = 4,
	FIVE_ADD_DEAD = 5,
	SIX_ADD_DEAD = 6
};

struct boss_shade_of_akamaAI : public ScriptedAI
{

	ScriptedInstance* instance;

	std::list<uint64> m_channelers;
	std::list<uint64> m_sorcerers;
	SummonList m_summons;

	uint64 AkamaGUID;

	uint32 m_damageTimer;

	uint32 m_waveTimer;
	uint32 m_guardTimer;
	uint32 m_sorcTimer;
	uint32 m_checkTimer;

	uint32 m_freeSlot;

	uint16 event_phase;
	uint16 dead_adds;

	bool reachedAkama;

    boss_shade_of_akamaAI(Creature* c) : ScriptedAI(c), m_summons(c)
    {
        instance = (ScriptedInstance*)c->GetInstanceData();
        AkamaGUID = instance ? instance->GetData64(DATA_AKAMA_SHADE) : 0;

        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
        me->ApplySpellImmune(0, IMMUNITY_EFFECT,SPELL_EFFECT_ATTACK_ME, true);

		Init();
    }

	void Init()
	{
		me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
		me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);

		event_phase = NOT_YET_STARTED;
		dead_adds = ZERO_ADD_DEAD;
		reachedAkama = false;

		m_freeSlot = 0;
		m_checkTimer = 3000;

		m_damageTimer = 10000;
		m_waveTimer = 7000;
		m_guardTimer = 9000;
		m_sorcTimer = 9000;

		if (instance)
			instance->SetData(EVENT_SHADEOFAKAMA, NOT_YET_STARTED);

		me->GetMotionMaster()->Clear(false);
	}

    void Reset()
    {
		Init();
		SpawnChannelers();

		if (Creature *akama = me->GetCreature(*me, AkamaGUID))
		{
			if (akama->isDead())
				akama->Respawn();

			akama->AI()->EnterEvadeMode();
		}
    }


	void EnterEvadeMode()
	{
		// just in case
		m_summons.DespawnAll();

		if (!_EnterEvadeMode())
			return;

		me->SetHealth(me->GetMaxHealth());
		DespawnChannelersAndSorcerers();

		if (Unit *owner = me->GetCharmerOrOwner())
		{
			me->GetMotionMaster()->Clear(false);
			me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle());
			Reset();
		}
		else
			me->GetMotionMaster()->MoveTargetedHome();
	}



    void ProcessSpawning(const uint32 diff)
    {
        if (m_waveTimer < diff)
        {
            Creature *akama = me->GetCreature(*me, AkamaGUID);
            for (int i = 0; i < 2; ++i)
            {
                for (int j = 0; j < 3; ++j)
                {
                    if (Creature *pAttacker = me->SummonCreature(spawnEntries[j], SpawnLocations[i][0], SpawnLocations[i][1], SPAWN_Z, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 15000))
                    {
                        m_summons.Summon(pAttacker);
                        pAttacker->GetMotionMaster()->MovePoint(0, 486.90f, 401.33f, SPAWN_Z);
                    }
                }
            }
            m_waveTimer = 35000;
        }
        else
            m_waveTimer -= diff;

        if (m_guardTimer < diff)
        {
            if (Creature *pDefender = me->SummonCreature(CREATURE_DEFENDER, SpawnLocations[0][0], SpawnLocations[0][1], SPAWN_Z, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 15000))
            {
                m_summons.Summon(pDefender);
                if(Creature *pAkama = me->GetCreature(*me, AkamaGUID))
                {
                    pDefender->AddThreat(pAkama, 100000.0f);
                    pDefender->AI()->AttackStart(pAkama);
                }
            }
            m_guardTimer = 30000;
        }
        else
            m_guardTimer -= diff;

        if (m_sorcTimer < diff)
        {
            if (!m_freeSlot)
            {
                m_sorcTimer = 5000;
                return;
            }

            if (Creature *pSorcerer = me->SummonCreature(CREATURE_SORCERER, SpawnLocations[1][0], SpawnLocations[1][1], SPAWN_Z, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 15000))
            {
                m_sorcerers.push_back(pSorcerer->GetGUID());

                WorldLocation sLoc;
                me->GetNearPoint(sLoc.coord_x, sLoc.coord_y, sLoc.coord_z, 0, 10.0f, frand(4.30, 5.31));
                pSorcerer->GetMotionMaster()->MovePoint(0, sLoc.coord_x, sLoc.coord_y, sLoc.coord_z);
            }
            m_sorcTimer = 30000;
        }
        else
            m_sorcTimer -= diff;
    }

	void JustDied(Unit* killer);

    void SummonedCreatureDespawn(Creature *summon)
    {
        if (summon->GetEntry() == CREATURE_CHANNELER || summon->GetEntry() == CREATURE_SORCERER)
            return;

        m_summons.Despawn(summon);
    }

    void OnAuraApply(Aura *aura, Unit *, bool stackApply)
    {
        if (aura->GetSpellProto()->Id == SPELL_AKAMA_SOUL_CHANNEL)
            event_phase = START_EVENT;
    }
    void OnAuraRemove(Aura *aura, bool stackRemove)
    {
        if (aura->GetSpellProto()->Id == SPELL_SHADE_SOUL_CHANNEL_ACTUAL_AURA_SPELL)
        {
            m_freeSlot++;

			if (event_phase == GAUNTLET)
				dead_adds++;
        }
    }

    void DamageTaken(Unit *pDoneBy, uint32)
    {
        if (!me->GetLootRecipient() && pDoneBy->GetTypeId() == TYPEID_PLAYER)
            me->SetLootRecipient(pDoneBy);
    }

    void JustReachedHome()
    {
        Reset();
    }

    void DespawnChannelersAndSorcerers()
    {
        for (std::list<uint64>::const_iterator itr = m_channelers.begin(); itr != m_channelers.end(); ++itr)
        {
            Creature *channeler = me->GetCreature(*me, *itr);
            if (channeler)
            {
                channeler->setDeathState(JUST_DIED);
                channeler->RemoveCorpse();
            }
        }
        m_channelers.clear();

        for (std::list<uint64>::const_iterator itr = m_sorcerers.begin(); itr != m_sorcerers.end(); ++itr)
        {
            Creature *sorc = me->GetCreature(*me, *itr);
            if (sorc)
            {
                sorc->setDeathState(JUST_DIED);
                sorc->RemoveCorpse();;
            }
        }
        m_sorcerers.clear();
    }

    void SpawnChannelers()
    {
        if (m_channelers.empty())
        {
            float pos_x = me->GetPositionX();
            float pos_y = me->GetPositionY();
            for (int i = 0; i < CHANNELERS_COUNT; ++i)
            {
                float x = pos_x + 15.0f * cos(M_PI/3 * i);
                float y = pos_y + 15.0f * sin(M_PI/3 * i);
                Creature *channeler = me->SummonCreature(CREATURE_CHANNELER, x, y, CHANNELERS_Z, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0);
                if (channeler)
                {
                    m_channelers.push_back(channeler->GetGUID());
                    channeler->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    channeler->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                }
            }
        }
        else
        {
            for (std::list<uint64>::const_iterator itr = m_channelers.begin(); itr != m_channelers.end(); ++itr)
            {
                Creature *channeler = me->GetCreature(*me, *itr);
                if (channeler)
                {
                    me->DealDamage(channeler, channeler->GetMaxHealth());
                    channeler->Respawn();
					channeler->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    channeler->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                }
            }
        }

        // despawn sorcerers here
        for (std::list<uint64>::const_iterator itr = m_sorcerers.begin(); itr != m_sorcerers.end(); ++itr)
        {
            Creature *sorc = me->GetCreature(*me, *itr);
            if (sorc)
            {
                sorc->setDeathState(JUST_DIED);
                sorc->RemoveCorpse();
            }
        }
        m_sorcerers.clear();
    }

    void SetAkamaGUID(uint64 guid) { AkamaGUID = guid; }

	void CheckAndSetShadeSpeed()
	{
		switch (dead_adds)
		{
		case ZERO_ADD_DEAD:
		{
			me->SetSpeed(MOVE_WALK, 0.10, true);
			break;
		}
		case ONE_ADD_DEAD:
		{
			me->SetSpeed(MOVE_WALK, 0.20, true);
			break;
		}
		case TWO_ADD_DEAD:
		{
			me->SetSpeed(MOVE_WALK, 0.30, true);
			break;
		}
		case THREE_ADD_DEAD:
		{
			me->SetSpeed(MOVE_WALK, 0.40, true);
			break;
		}
		case FOUR_ADD_DEAD:
		{
			me->SetSpeed(MOVE_WALK, 0.50, true);
			break;
		}
		case FIVE_ADD_DEAD:
		{
			me->SetSpeed(MOVE_WALK, 0.60, true);
			break;
		}
		case SIX_ADD_DEAD:
		{
			me->SetSpeed(MOVE_WALK, 0.70, true);
			break;
		}
		}
	}

	void MovementInform(uint32 type, uint32 id)
	{
		if (type != POINT_MOTION_TYPE)
			return;

		switch (id)
		{
			case 999:
			{
				if (!instance)
				{
					EnterEvadeMode();
					return;
				}

				reachedAkama = true;
				if (Creature *akama = me->GetCreature(*me, AkamaGUID))
				{
					me->AddThreat(akama, 100000.0f);
					AttackStart(akama);
				}
			}
		}
	}

	inline bool UpdateVictim()
	{
		return false;
	}

	void AttackAkama(const uint32 diff)
	{
		if (m_damageTimer < diff)
		{
			if (!AkamaGUID)
				return;

			if (Creature *akama = me->GetCreature(*me, AkamaGUID))
			{
				if (akama->isAlive())
				{
					int damage = akama->GetMaxHealth() / 24;
					me->DealDamage(akama, damage, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
					m_damageTimer = 2850;
				}
				else
					event_phase = AKAMA_DEATHS;
			}
		}
		else
		{
			m_damageTimer -= diff;
		}

		DoMeleeAttackIfReady();
	}

    void UpdateAI(const uint32 diff)
    {

		if (instance->GetData(EVENT_SHADEOFAKAMA) != IN_PROGRESS)
			return;


		switch (event_phase)
		{
			case NOT_YET_STARTED:
			{
				if (!AkamaGUID && instance)
				{
					AkamaGUID = instance->GetData64(DATA_AKAMA_SHADE);
					me->SetWalk(true);
					return;
				}

				break;
			}
			case START_EVENT:
			{
				for (std::list<uint64>::const_iterator itr = m_channelers.begin(); itr != m_channelers.end(); ++itr)
				{
					if (Creature *channeler = me->GetCreature(*me, *itr))
					{
						channeler->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
						channeler->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
					}
				}

				me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
				dead_adds = ZERO_ADD_DEAD;

				me->GetMotionMaster()->MovementExpired();
				me->StopMoving();

				//MOVE TO AKAMA.
				if (Creature *pAkama = me->GetCreature(*me, AkamaGUID))
				{
					me->GetMotionMaster()->MovePoint(999, moveTo[2][0], moveTo[2][1], moveTo[2][2]);
				}

				event_phase = GAUNTLET;
				break;
			}
			case GAUNTLET:
			{
				CheckAndSetShadeSpeed();

				if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
					ProcessSpawning(diff);

				if (reachedAkama)
				{
					AttackAkama(diff);

					if (dead_adds == SIX_ADD_DEAD)
					{
						event_phase = AKAMA_FIGHTS;
					}
				}

				break;
			}
			case AKAMA_FIGHTS:
			{
				me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
				me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

				AttackAkama(diff);

				break;
			}
		}
    }
};

void mob_ashtongue_channelerAI::OnAuraRemove(Aura *aura, bool stackRemove)
{
    if (aura->GetSpellProto()->Id == SPELL_SHADE_SOUL_CHANNEL_CASTED_SPELL)
    {
        if (Unit *shade = me->GetUnit(*me, ShadeGUID))
            shade->RemoveSingleAuraFromStack(SPELL_SHADE_SOUL_CHANNEL_ACTUAL_AURA_SPELL, 0);
    }
}








struct npc_akamaAI : public Scripted_NoMovementAI
{
    npc_akamaAI(Creature* c) : Scripted_NoMovementAI(c), m_summons(me), isCasting(false)
    {
        instance = (ScriptedInstance *)c->GetInstanceData();
        ShadeGUID = instance ? instance->GetData64(DATA_SHADEOFAKAMA) : 0;
    }

    void ShadeKilled()
    {
        me->InterruptNonMeleeSpells(false);
        m_talk = 0;
        m_talkTimer = 3000;
        if (instance)
            instance->SetData(EVENT_SHADEOFAKAMA, DONE);
    }

    ScriptedInstance* instance;

    uint64 ShadeGUID;

    uint32 m_destructiveTimer;
    uint32 m_lightningBoltTimer;

    uint32 m_talk;
    uint32 m_talkTimer;

    bool m_yell;
	bool isCasting;

    SummonList m_summons;

    void Reset()
    {
        ClearCastQueue();

        m_destructiveTimer = 5000;
        m_lightningBoltTimer = 8000;

        m_yell = false;
		isCasting = false;
        m_talk = 0;
        m_talkTimer = 0;

        if (instance)
        {
            if (instance->GetData(EVENT_SHADEOFAKAMA) == NOT_YET_STARTED)
            {
                DoCast(me, SPELL_STEALTH);
                me->SetUInt32Value(UNIT_NPC_FLAGS, 0);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_PL_SPELL_TARGET);
            }
        }
        m_summons.DespawnAll();
    }

    void SummonedCreatureDespawn(Creature *summon)
    {
        m_summons.Despawn(summon);
    }

    void BeginEvent(Player* pl)
    {
        instance->SetData(EVENT_SHADEOFAKAMA, IN_PROGRESS);
        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        me->RemoveAurasDueToSpell(SPELL_STEALTH);
		me->SetWalk(true);
        me->GetMotionMaster()->MovePoint(0, AKAMA_X, AKAMA_Y, AKAMA_Z);
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if (type != POINT_MOTION_TYPE)
            return;

        switch (id)
        {
            case 0:
            {
                if (!instance)
                {
                    EnterEvadeMode();
                    return;
                }

                ShadeGUID = instance->GetData64(DATA_SHADEOFAKAMA);
                if (!ShadeGUID)
                {
                    EnterEvadeMode();
                    return;
                }

                if (Unit *pShade = me->GetUnit(*me, ShadeGUID))
                {
					me->SetSelection(ShadeGUID);
                    DoCast(pShade, SPELL_AKAMA_SOUL_CHANNEL);
					isCasting = true;
                }
            }
            break;
            case 1:
            {
                m_talkTimer  = 500;
                m_talk = 1;
            }
            break;
            case 2:
            {
                // upstairs
                m_talkTimer = 500;
                m_talk = 2;
            }
            break;
            case 3:
            {
                m_talkTimer = 500;
                m_talk = 3;
            }
            break;
            case 4:
            {
                m_talkTimer = 500;
                m_talk = 4;
            }
            break;
        }
    }

    void JustDied(Unit* killer)
    {
        DoScriptText(SAY_DEATH, me);
        Creature *shade = me->GetCreature(*me, ShadeGUID);
		if (shade && shade->isAlive())
		{
			shade->AI()->EnterEvadeMode();
			instance->SetData(EVENT_SHADEOFAKAMA, NOT_YET_STARTED);
		}

        m_summons.DespawnAll();
    }

    inline bool UpdateVictim()
    {
        if (instance && instance->GetData(EVENT_SHADEOFAKAMA) == IN_PROGRESS)
        {
            if (!me->isInCombat())
                return false;

            if (Creature *pShade = me->GetCreature(*me, ShadeGUID))
            {
                me->InterruptNonMeleeSpells(false);
                AttackStart(pShade);
                return me->getVictim();
            }
        }
        return false;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!instance)
            return;

		if (isCasting)
		{
			me->SetSelection(ShadeGUID);
			return;
		}

        if (m_talkTimer)
        {
            if (m_talkTimer <= diff)
            {
                m_talkTimer = 0;
                switch (m_talk)
                {
                    case 0:
                        me->GetMotionMaster()->MovePoint(1, moveTo[1][0], moveTo[1][1], moveTo[1][2]);
                    break;
                    case 1:
                        me->GetMotionMaster()->MovePoint(2, moveTo[0][0], moveTo[0][1], moveTo[0][2]);
                    break;
                    case 2:
                        me->GetMotionMaster()->MovePoint(3, moveTo[0][0]-5.0f, moveTo[0][1], moveTo[0][2]);
                    break;
                    case 3:
                        me->GetMotionMaster()->MovePoint(4, moveTo[0][0]-4.0f, moveTo[0][1], moveTo[0][2]);
                    break;
                    case 4:
                    {
                        me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                        ++m_talk;
                        m_talkTimer = 1500;
                    }
                    break;
                    case 5:
                    {
                        DoScriptText(SAY_FREE, me);
                        DoCast(me, 40927, true);
                        if (Creature *shade = me->GetCreature(*me, ShadeGUID))
                            DoCast(shade, SPELL_AKAMA_SOUL_RETRIEVE);

                        ++m_talk;
                        m_talkTimer = 60000;
                        for (int i = 0; i < MAX_BROKEN; ++i)
                        {
                            Creature *broken = me->SummonCreature(CREATURE_BROKEN, BrokenPositions[i][0], BrokenPositions[i][1], AKAMA_Z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 45000);
                            if (broken)
                            {
                                m_summons.Summon(broken);
                                broken->SetWalk(true);
                                broken->GetMotionMaster()->MovePoint(0, BrokenMoveTo[i][0], BrokenMoveTo[i][1], SPAWN_Z);
                                broken->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_KNEEL);
                            }
                        }
                    }
                    break;
                    default:
                        me->AI()->EnterEvadeMode();
                    break;
                }
            }
            else
                m_talkTimer -= diff;
        }

        if (instance->GetData(EVENT_SHADEOFAKAMA) != IN_PROGRESS)
            return;

        if (!m_yell && (me->GetHealth()*100 / me->GetMaxHealth()) < 15)
        {
            DoScriptText(SAY_LOW_HEALTH, me);
            m_yell = true;
        }

        if (!UpdateVictim())
            return;

        if (me->m_currentSpells[CURRENT_CHANNELED_SPELL])
            return;

        if (m_destructiveTimer < diff)
        {
            AddSpellToCast(me->getVictim(), SPELL_DESTRUCTIVE_POISON, true);
            m_destructiveTimer = 5000;
        }
        else
            m_destructiveTimer -= diff;

        if (m_lightningBoltTimer < diff)
        {
            AddSpellToCast(me->getVictim(), SPELL_CHAIN_LIGHTNING);
            m_lightningBoltTimer = 8000;
        }
        else
            m_lightningBoltTimer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_shade_of_akama(Creature *_Creature)
{
    return new boss_shade_of_akamaAI (_Creature);
}

CreatureAI* GetAI_mob_ashtongue_channeler(Creature *_Creature)
{
    return new mob_ashtongue_channelerAI (_Creature);
}

CreatureAI* GetAI_mob_ashtongue_sorcerer(Creature *_Creature)
{
    return new mob_ashtongue_sorcererAI (_Creature);
}



CreatureAI* GetAI_npc_akama_shade(Creature *_Creature)
{
    return new npc_akamaAI (_Creature);
}


void boss_shade_of_akamaAI::JustDied(Unit *)
{
	DespawnChannelersAndSorcerers();
	m_summons.DespawnAll();
	if (Creature *akama = me->GetCreature(*me, AkamaGUID))
		((npc_akamaAI *)akama->AI())->ShadeKilled();
}

bool GossipSelect_npc_akama(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (ScriptedInstance *instance = (ScriptedInstance *)_Creature->GetInstanceData())
    {
        if (instance->GetData(EVENT_SHADEOFAKAMA) != NOT_YET_STARTED)
        {
            player->CLOSE_GOSSIP_MENU();
            return true;
        }

        if (action == GOSSIP_ACTION_INFO_DEF + 1)               //Fight time
        {
            player->CLOSE_GOSSIP_MENU();
            ((npc_akamaAI*)_Creature->AI())->BeginEvent(player);
        }
    }
    return true;
}

bool GossipHello_npc_akama(Player *player, Creature *_Creature)
{
    if (ScriptedInstance *instance = (ScriptedInstance *)_Creature->GetInstanceData())
    {
        if (instance->GetData(EVENT_SHADEOFAKAMA) == NOT_YET_STARTED)
        {
            if (player->isAlive())
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(907, _Creature->GetGUID());
            }
        }
    }
    return true;
}

void AddSC_boss_shade_of_akama()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_shade_of_akama";
    newscript->GetAI = &GetAI_boss_shade_of_akama;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_ashtongue_channeler";
    newscript->GetAI = &GetAI_mob_ashtongue_channeler;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_ashtongue_sorcerer";
    newscript->GetAI = &GetAI_mob_ashtongue_sorcerer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_akama_shade";
    newscript->GetAI = &GetAI_npc_akama_shade;
    newscript->pGossipHello = &GossipHello_npc_akama;
    newscript->pGossipSelect = &GossipSelect_npc_akama;
    newscript->RegisterSelf();
}
