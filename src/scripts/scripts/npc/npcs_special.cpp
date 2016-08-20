/* 
 * Copyright (C) 2006-2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2008-2014 Looking4Group <http://looking4group.de/>
 * 
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
SDName: Npcs_Special
SD%Complete: 100
SDComment: To be used for special NPCs that are located globally. Support for quest 3861 (Cluck!), 6622 and 6624 (Triage)
SDCategory: NPCs
EndScriptData
*/

/* ContentData
npc_chicken_cluck           100%    support for quest 3861 (Cluck!)
npc_dancing_flames          100%    midsummer event NPC
npc_guardian                100%    guardianAI used to prevent players from accessing off-limits areas. Not in use by SD2
npc_injured_patient         100%    patients for triage-quests (6622 and 6624)
npc_doctor                  100%    Gustaf Vanhowzen and Gregory Victor, quest 6622 and 6624 (Triage)
npc_mount_vendor            100%    Regular mount vendors all over the world. Display gossip if player doesn't meet the requirements to buy
npc_rogue_trainer           80%     Scripted trainers, so they are able to offer item 17126 for class quest 6681
npc_sayge                   100%    Darkmoon event fortune teller, buff player based on answers given
npc_snake_trap_serpents     80%     AI for snakes that summoned by Snake Trap
npc_flight_master           100%    AI for flight masters.
npc_lazy_peon               100%    AI for peons for quest 5441 (Lazy Peons)
npc_mojo                    100%    AI for companion Mojo (summoned by item: 33993)
npc_master_omarion          100%    Master Craftsman Omarion, patterns menu
npc_lorekeeper_lydros       100%    Dialogue (story) + add A Dull and Flat Elven Blade
npc_crashin_thrashin_robot  100%    AI for Crashin' Thrashin' Robot from engineering
npc_gnomish_flame_turret
EndContentData */

#include "precompiled.h"
#include "BattleGround.h"
#include "Totem.h"
#include "PetAI.h"
#include "Language.h"
#include "follower_ai.h"
#include "escort_ai.h"
#include <list>

#include <cstring>

/*########
# npc_chicken_cluck
#########*/

#define QUEST_CLUCK         3861
#define CHICKEN_HELLO_TEXT  50
#define EMOTE_A_HELLO       "looks up at you quizzically. Maybe you should inspect it?"
#define EMOTE_H_HELLO       "looks at you unexpectadly."
#define CLUCK_TEXT2         "starts pecking at the feed."
#define FACTION_FRIENDLY    84
#define FACTION_CHICKEN     31

struct npc_chicken_cluckAI : public ScriptedAI
{
    npc_chicken_cluckAI(Creature *c) : ScriptedAI(c) {}

    uint32 ResetFlagTimer;

    void Reset()
    {
        ResetFlagTimer = 120000;

        me->setFaction(FACTION_CHICKEN);
        me->RemoveFlag(UNIT_NPC_FLAGS, (UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER));
    }

    void EnterCombat(Unit *who) {}

    void UpdateAI(const uint32 diff)
    {
        // Reset flags after a certain time has passed so that the next player has to start the 'event' again
        if(me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER))
        {
            if(ResetFlagTimer < diff)
            {
                EnterEvadeMode();
                return;
            }
            else
                ResetFlagTimer -= diff;
        }

        if(UpdateVictim())
            DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_chicken_cluck(Creature *_Creature)
{
    return new npc_chicken_cluckAI(_Creature);
}

bool ReceiveEmote_npc_chicken_cluck( Player *player, Creature *_Creature, uint32 emote )
{
    if( emote == TEXTEMOTE_CHICKEN )
    {
        if( player->GetTeam() == ALLIANCE )
        {
            if( rand()%30 == 1 )
            {
                if( player->GetQuestStatus(QUEST_CLUCK) == QUEST_STATUS_NONE )
                {
                    _Creature->SetFlag(UNIT_NPC_FLAGS, (UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER));
                    _Creature->setFaction(FACTION_FRIENDLY);
                    _Creature->MonsterTextEmote(EMOTE_A_HELLO, 0);
                }
            }
        }
        else
            _Creature->MonsterTextEmote(EMOTE_H_HELLO,0);
    }
    if( emote == TEXTEMOTE_CHEER && player->GetTeam() == ALLIANCE )
        if( player->GetQuestStatus(QUEST_CLUCK) == QUEST_STATUS_COMPLETE )
        {
            _Creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
            _Creature->setFaction(FACTION_FRIENDLY);
            _Creature->MonsterTextEmote(CLUCK_TEXT2, 0);
        }

    return true;
}

bool GossipHello_npc_chicken_cluck(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu(_Creature->GetGUID());

    player->SEND_GOSSIP_MENU(CHICKEN_HELLO_TEXT, _Creature->GetGUID());

    return true;
}

bool QuestAccept_npc_chicken_cluck(Player *player, Creature *_Creature, const Quest *_Quest )
{
    if(_Quest->GetQuestId() == QUEST_CLUCK)
        ((npc_chicken_cluckAI*)_Creature->AI())->Reset();

    return true;
}

bool QuestComplete_npc_chicken_cluck(Player *player, Creature *_Creature, const Quest *_Quest)
{
    if(_Quest->GetQuestId() == QUEST_CLUCK)
    {
        _Creature->CastSpell(_Creature, 13563, false);  // summon chicken egg as reward
        ((npc_chicken_cluckAI*)_Creature->AI())->Reset();
    }

    return true;
}

/*######
## npc_dancing_flames
######*/

#define SPELL_BRAZIER       45423
#define SPELL_SEDUCTION     47057
#define SPELL_FIERY_AURA    45427

struct npc_dancing_flamesAI : public ScriptedAI
{
    npc_dancing_flamesAI(Creature *c) : ScriptedAI(c) {}

    bool active;
    uint32 can_iteract;

    void Reset()
    {
        active = true;
        can_iteract = 3500;
        DoCast(me,SPELL_BRAZIER,true);
        DoCast(me,SPELL_FIERY_AURA,false);
        float x, y, z;
        me->GetPosition(x,y,z);
        me->Relocate(x,y,z + 0.94f);
        me->SetLevitate(true);
        me->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!active)
        {
            if(can_iteract <= diff)
            {
                active = true;
                can_iteract = 3500;
                me->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
            }
            else
                can_iteract -= diff;
        }
    }
};

CreatureAI* GetAI_npc_dancing_flames(Creature *_Creature)
{
    return new npc_dancing_flamesAI(_Creature);
}

bool ReceiveEmote_npc_dancing_flames( Player *player, Creature *flame, uint32 emote )
{
    if ( ((npc_dancing_flamesAI*)flame->AI())->active &&
            flame->IsWithinLOS(player->GetPositionX(),player->GetPositionY(),player->GetPositionZ()) && flame->IsWithinDistInMap(player,30.0f))
    {
        flame->SetInFront(player);
        ((npc_dancing_flamesAI*)flame->AI())->active = false;

        switch(emote)
        {
        case TEXTEMOTE_KISS:
            flame->HandleEmoteCommand(EMOTE_ONESHOT_SHY);
            break;
        case TEXTEMOTE_WAVE:
            flame->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
            break;
        case TEXTEMOTE_BOW:
            flame->HandleEmoteCommand(EMOTE_ONESHOT_BOW);
            break;
        case TEXTEMOTE_JOKE:
            flame->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
            break;
        case TEXTEMOTE_DANCE:
        {
            if (!player->HasAura(SPELL_SEDUCTION,0))
                flame->CastSpell(player,SPELL_SEDUCTION,true);
        }
        break;
        }
    }
    return true;
}

/*######
## Triage quest
######*/

#define SAY_DOC1 "I'm saved! Thank you, doctor!"
#define SAY_DOC2 "HOORAY! I AM SAVED!"
#define SAY_DOC3 "Sweet, sweet embrace... take me..."

struct Location
{
    float x, y, z, o;
};

#define DOCTOR_ALLIANCE     12939

static Location AllianceCoords[]=
{
    {
        // Top-far-right bunk as seen from entrance
        -3757.38, -4533.05, 14.16, 3.62
    },
    {
        // Top-far-left bunk
        -3754.36, -4539.13, 14.16, 5.13
    },
    {
        // Far-right bunk
        -3749.54, -4540.25, 14.28, 3.34
    },
    {
        // Right bunk near entrance
        -3742.10, -4536.85, 14.28, 3.64
    },
    {
        // Far-left bunk
        -3755.89, -4529.07, 14.05, 0.57
    },
    {
        // Mid-left bunk
        -3749.51, -4527.08, 14.07, 5.26
    },
    {
        // Left bunk near entrance
        -3746.37, -4525.35, 14.16, 5.22
    },
};

#define ALLIANCE_COORDS     7

//alliance run to where
#define A_RUNTOX -3742.96
#define A_RUNTOY -4531.52
#define A_RUNTOZ 11.91

#define DOCTOR_HORDE    12920

static Location HordeCoords[]=
{
    {
        // Left, Behind
        -1013.75, -3492.59, 62.62, 4.34
    },
    {
        // Right, Behind
        -1017.72, -3490.92, 62.62, 4.34
    },
    {
        // Left, Mid
        -1015.77, -3497.15, 62.82, 4.34
    },
    {
        // Right, Mid
        -1019.51, -3495.49, 62.82, 4.34
    },
    {
        // Left, front
        -1017.25, -3500.85, 62.98, 4.34
    },
    {
        // Right, Front
        -1020.95, -3499.21, 62.98, 4.34
    }
};

#define HORDE_COORDS        6

//horde run to where
#define H_RUNTOX -1016.44
#define H_RUNTOY -3508.48
#define H_RUNTOZ 62.96

const uint32 AllianceSoldierId[3] =
{
    12938,                                                  // 12938 Injured Alliance Soldier
    12936,                                                  // 12936 Badly injured Alliance Soldier
    12937                                                   // 12937 Critically injured Alliance Soldier
};

const uint32 HordeSoldierId[3] =
{
    12923,                                                  //12923 Injured Soldier
    12924,                                                  //12924 Badly injured Soldier
    12925                                                   //12925 Critically injured Soldier
};

/*######
## npc_doctor (handles both Gustaf Vanhowzen and Gregory Victor)
######*/

struct npc_doctorAI : public ScriptedAI
{
    npc_doctorAI(Creature *c) : ScriptedAI(c) {}

    uint64 Playerguid;

    uint32 SummonPatient_Timer;
    uint32 SummonPatientCount;
    uint32 PatientDiedCount;
    uint32 PatientSavedCount;

    bool Event;

    std::list<uint64> Patients;
    std::vector<Location*> Coordinates;

    void Reset()
    {
        Event = false;
        SummonPatient_Timer = 10000;
        PatientSavedCount = 0;
        PatientDiedCount = 0;
        Playerguid = 0;
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    }

    void BeginEvent(Player* player);
    void PatientDied(Location* Point);
    void PatientSaved(Creature* soldier, Player* player, Location* Point);
    void UpdateAI(const uint32 diff);
};

/*#####
## npc_injured_patient (handles all the patients, no matter Horde or Alliance)
#####*/

struct npc_injured_patientAI : public ScriptedAI
{
    npc_injured_patientAI(Creature *c) : ScriptedAI(c) {}

    uint64 Doctorguid;

    Location* Coord;

    void Reset()
    {
        Doctorguid = 0;

        Coord = NULL;
        //no select
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        //no regen health
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
        //to make them lay with face down
        me->SetUInt32Value(UNIT_FIELD_BYTES_1, PLAYER_STATE_DEAD);

        uint32 mobId = me->GetEntry();

        switch (mobId)
        {
            //lower max health
        case 12923:
        case 12938:                                     //Injured Soldier
            me->SetHealth(uint32(me->GetMaxHealth()*.75));
            break;
        case 12924:
        case 12936:                                     //Badly injured Soldier
            me->SetHealth(uint32(me->GetMaxHealth()*.50));
            break;
        case 12925:
        case 12937:                                     //Critically injured Soldier
            me->SetHealth(uint32(me->GetMaxHealth()*.25));
            break;
        }
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (caster->GetTypeId() == TYPEID_PLAYER && me->isAlive() && spell->Id == 20804)
        {
            if( (((Player*)caster)->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE) || (((Player*)caster)->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE))
            {
                if(Doctorguid)
                {
                    Creature* Doctor = Unit::GetCreature((*me), Doctorguid);
                    if(Doctor)
                        ((npc_doctorAI*)Doctor->AI())->PatientSaved(me, ((Player*)caster), Coord);
                }
            }
            //make not selectable
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            //regen health
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
            //stand up
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, PLAYER_STATE_NONE);
            DoSay(SAY_DOC1,LANG_UNIVERSAL,NULL);

            uint32 mobId = me->GetEntry();
            me->SetWalk(false);
            switch (mobId)
            {
            case 12923:
            case 12924:
            case 12925:
                me->GetMotionMaster()->MovePoint(0, H_RUNTOX, H_RUNTOY, H_RUNTOZ);
                break;
            case 12936:
            case 12937:
            case 12938:
                me->GetMotionMaster()->MovePoint(0, A_RUNTOX, A_RUNTOY, A_RUNTOZ);
                break;
            }
        }
        return;
    }

    void UpdateAI(const uint32 diff)
    {
        if (me->isAlive() && me->GetHealth() > 6)
        {
            //lower HP on every world tick makes it a useful counter, not officlone though
            me->SetHealth(uint32(me->GetHealth()-5) );
        }

        if (me->isAlive() && me->GetHealth() <= 6)
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->setDeathState(JUST_DIED);
            me->SetFlag(UNIT_DYNAMIC_FLAGS, 32);

            if(Doctorguid)
            {
                Creature* Doctor = (Unit::GetCreature((*me), Doctorguid));
                if(Doctor)
                    ((npc_doctorAI*)Doctor->AI())->PatientDied(Coord);
            }
        }
    }
};

CreatureAI* GetAI_npc_injured_patient(Creature *_Creature)
{
    return new npc_injured_patientAI (_Creature);
}

/*
npc_doctor (continue)
*/

void npc_doctorAI::BeginEvent(Player* player)
{
    Playerguid = player->GetGUID();

    SummonPatient_Timer = 10000;
    SummonPatientCount = 0;
    PatientDiedCount = 0;
    PatientSavedCount = 0;

    switch(me->GetEntry())
    {
    case DOCTOR_ALLIANCE:
        for(uint8 i = 0; i < ALLIANCE_COORDS; ++i)
            Coordinates.push_back(&AllianceCoords[i]);
        break;

    case DOCTOR_HORDE:
        for(uint8 i = 0; i < HORDE_COORDS; ++i)
            Coordinates.push_back(&HordeCoords[i]);
        break;
    }

    Event = true;

    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
}

void npc_doctorAI::PatientDied(Location* Point)
{
    Player* player = Unit::GetPlayer(Playerguid);
    if(player && ((player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)))
    {
        PatientDiedCount++;
        if (PatientDiedCount > 5 && Event)
        {
            if(player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE)
                player->FailQuest(6624);
            else if(player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)
                player->FailQuest(6622);

            Event = false;
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }

        Coordinates.push_back(Point);
    }
    else
        Reset();
}

void npc_doctorAI::PatientSaved(Creature* soldier, Player* player, Location* Point)
{
    if(player && Playerguid == player->GetGUID())
    {
        if((player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE))
        {
            PatientSavedCount++;
            if(PatientSavedCount == 15)
            {
                if(!Patients.empty())
                {
                    std::list<uint64>::iterator itr;
                    for(itr = Patients.begin(); itr != Patients.end(); ++itr)
                    {
                        Creature* Patient = Unit::GetCreature((*me), *itr);
                        if( Patient )
                            Patient->setDeathState(JUST_DIED);
                    }
                }

                if(player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE)
                    player->AreaExploredOrEventHappens(6624);
                else if(player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)
                    player->AreaExploredOrEventHappens(6622);

                Reset();
            }

            Coordinates.push_back(Point);
        }
    }
    else
        Reset();
}

void npc_doctorAI::UpdateAI(const uint32 diff)
{
    if(Event && SummonPatientCount >= 20)
        Reset();

    if(Event)
        if(SummonPatient_Timer < diff)
        {
            Creature* Patient = NULL;
            Location* Point = NULL;

            if(Coordinates.empty())
                return;

            std::vector<Location*>::iterator itr = Coordinates.begin()+rand()%Coordinates.size();
            uint32 patientEntry = 0;

            switch(me->GetEntry())
            {
            case DOCTOR_ALLIANCE:
                patientEntry = AllianceSoldierId[rand()%3];
                break;
            case DOCTOR_HORDE:
                patientEntry = HordeSoldierId[rand()%3];
                break;
            default:
                error_log("TSCR: Invalid entry for Triage doctor. Please check your database");
                return;
            }

            Point = *itr;

            Patient = me->SummonCreature(patientEntry, Point->x, Point->y, Point->z, Point->o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);

            if(Patient)
            {
                Patients.push_back(Patient->GetGUID());
                ((npc_injured_patientAI*)Patient->AI())->Doctorguid = me->GetGUID();
                if(Point)
                    ((npc_injured_patientAI*)Patient->AI())->Coord = Point;
                Coordinates.erase(itr);
            }
            SummonPatient_Timer = 10000;
            SummonPatientCount++;
        }
        else
            SummonPatient_Timer -= diff;
}

bool QuestAccept_npc_doctor(Player *player, Creature *creature, Quest const *quest )
{
    if((quest->GetQuestId() == 6624) || (quest->GetQuestId() == 6622))
        ((npc_doctorAI*)creature->AI())->BeginEvent(player);

    return true;
}

CreatureAI* GetAI_npc_doctor(Creature *_Creature)
{
    return new npc_doctorAI (_Creature);
}

/*######
## npc_guardian
######*/

#define SPELL_DEATHTOUCH                5
#define SAY_AGGRO                       "This area is closed!"

struct npc_guardianAI : public ScriptedAI
{
    npc_guardianAI(Creature *c) : ScriptedAI(c) {}

    void Reset()
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
    }

    void EnterCombat(Unit *who)
    {
        DoYell(SAY_AGGRO, LANG_UNIVERSAL, NULL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (me->isAttackReady())
        {
            me->CastSpell(me->getVictim(), SPELL_DEATHTOUCH, true);
            me->resetAttackTimer();
        }
    }
};

CreatureAI* GetAI_npc_guardian(Creature *_Creature)
{
    return new npc_guardianAI (_Creature);
}

/*######
## npc_mount_vendor
######*/

bool GossipHello_npc_mount_vendor(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    bool canBuy;
    canBuy = false;
    uint32 vendor = _Creature->GetEntry();
    uint8 race = player->getRace();

    switch (vendor)
    {
    case 384:                                           //Katie Hunter
    case 1460:                                          //Unger Statforth
    case 2357:                                          //Merideth Carlson
    case 4885:                                          //Gregor MacVince
        if (player->GetReputationMgr().GetRank(72) != REP_EXALTED && race != RACE_HUMAN)
            player->SEND_GOSSIP_MENU(5855, _Creature->GetGUID());
        else canBuy = true;
        break;
    case 1261:                                          //Veron Amberstill
        if (player->GetReputationMgr().GetRank(47) != REP_EXALTED && race != RACE_DWARF)
            player->SEND_GOSSIP_MENU(5856, _Creature->GetGUID());
        else canBuy = true;
        break;
    case 3362:                                          //Ogunaro Wolfrunner
        if (player->GetReputationMgr().GetRank(76) != REP_EXALTED && race != RACE_ORC)
            player->SEND_GOSSIP_MENU(5841, _Creature->GetGUID());
        else canBuy = true;
        break;
    case 3685:                                          //Harb Clawhoof
        if (player->GetReputationMgr().GetRank(81) != REP_EXALTED && race != RACE_TAUREN)
            player->SEND_GOSSIP_MENU(5843, _Creature->GetGUID());
        else canBuy = true;
        break;
    case 4730:                                          //Lelanai
        if (player->GetReputationMgr().GetRank(69) != REP_EXALTED && race != RACE_NIGHTELF)
            player->SEND_GOSSIP_MENU(5844, _Creature->GetGUID());
        else canBuy = true;
        break;
    case 4731:                                          //Zachariah Post
        if (player->GetReputationMgr().GetRank(68) != REP_EXALTED && race != RACE_UNDEAD_PLAYER)
            player->SEND_GOSSIP_MENU(5840, _Creature->GetGUID());
        else canBuy = true;
        break;
    case 7952:                                          //Zjolnir
        if (player->GetReputationMgr().GetRank(530) != REP_EXALTED && race != RACE_TROLL)
            player->SEND_GOSSIP_MENU(5842, _Creature->GetGUID());
        else canBuy = true;
        break;
    case 7955:                                          //Milli Featherwhistle
        if (player->GetReputationMgr().GetRank(54) != REP_EXALTED && race != RACE_GNOME)
            player->SEND_GOSSIP_MENU(5857, _Creature->GetGUID());
        else canBuy = true;
        break;
    case 16264:                                         //Winaestra
        if (player->GetReputationMgr().GetRank(911) != REP_EXALTED && race != RACE_BLOODELF)
            player->SEND_GOSSIP_MENU(10305, _Creature->GetGUID());
        else canBuy = true;
        break;
    case 17584:                                         //Torallius the Pack Handler
        if (player->GetReputationMgr().GetRank(930) != REP_EXALTED && race != RACE_DRAENEI)
            player->SEND_GOSSIP_MENU(10239, _Creature->GetGUID());
        else canBuy = true;
        break;
    }

    if (canBuy)
    {
        if (_Creature->isVendor())
            player->ADD_GOSSIP_ITEM( 1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
        player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    }
    return true;
}

bool GossipSelect_npc_mount_vendor(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_TRADE)
        player->SEND_VENDORLIST( _Creature->GetGUID() );

    return true;
}

/*######
## npc_rogue_trainer
######*/

bool GossipHello_npc_rogue_trainer(Player *player, Creature *_Creature)
{
    if( _Creature->isQuestGiver() )
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if( _Creature->isTrainer() )
        player->ADD_GOSSIP_ITEM(2, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);

    if( _Creature->isCanTrainingAndResetTalentsOf(player) )
        player->ADD_GOSSIP_ITEM(2, "I wish to unlearn my talents", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_UNLEARNTALENTS);

    if( player->getClass() == CLASS_ROGUE && player->getLevel() >= 24 && !player->HasItemCount(17126,1) && !player->GetQuestRewardStatus(6681) )
    {
        player->ADD_GOSSIP_ITEM(0, "<Take the letter>", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        player->SEND_GOSSIP_MENU(5996, _Creature->GetGUID());
    }
    else
        player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_rogue_trainer(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch( action )
    {
    case GOSSIP_ACTION_INFO_DEF+1:
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,21100,false);
        break;
    case GOSSIP_ACTION_TRAIN:
        player->SEND_TRAINERLIST( _Creature->GetGUID() );
        break;
    case GOSSIP_OPTION_UNLEARNTALENTS:
        player->CLOSE_GOSSIP_MENU();
        player->SendTalentWipeConfirm( _Creature->GetGUID() );
        break;
    }
    return true;
}

/*######
## npc_sayge
######*/

#define SPELL_DMG       23768                               //dmg
#define SPELL_RES       23769                               //res
#define SPELL_ARM       23767                               //arm
#define SPELL_SPI       23738                               //spi
#define SPELL_INT       23766                               //int
#define SPELL_STM       23737                               //stm
#define SPELL_STR       23735                               //str
#define SPELL_AGI       23736                               //agi
#define SPELL_FORTUNE   23765                               //faire fortune

bool GossipHello_npc_sayge(Player *player, Creature *_Creature)
{
    if(_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if( player->HasSpellCooldown(SPELL_INT) ||
            player->HasSpellCooldown(SPELL_ARM) ||
            player->HasSpellCooldown(SPELL_DMG) ||
            player->HasSpellCooldown(SPELL_RES) ||
            player->HasSpellCooldown(SPELL_STR) ||
            player->HasSpellCooldown(SPELL_AGI) ||
            player->HasSpellCooldown(SPELL_STM) ||
            player->HasSpellCooldown(SPELL_SPI) )
        player->SEND_GOSSIP_MENU(7393, _Creature->GetGUID());
    else
    {
        player->ADD_GOSSIP_ITEM(0, "Yes", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        player->SEND_GOSSIP_MENU(7339, _Creature->GetGUID());
    }

    return true;
}

void SendAction_npc_sayge(Player *player, Creature *_Creature, uint32 action)
{
    switch(action)
    {
    case GOSSIP_ACTION_INFO_DEF+1:
        player->ADD_GOSSIP_ITEM(0, "Slay the Man",                      GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        player->ADD_GOSSIP_ITEM(0, "Turn him over to liege",            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
        player->ADD_GOSSIP_ITEM(0, "Confiscate the corn",               GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
        player->ADD_GOSSIP_ITEM(0, "Let him go and have the corn",      GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
        player->SEND_GOSSIP_MENU(7340, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+2:
        player->ADD_GOSSIP_ITEM(0, "Execute your friend painfully",     GOSSIP_SENDER_MAIN+1, GOSSIP_ACTION_INFO_DEF);
        player->ADD_GOSSIP_ITEM(0, "Execute your friend painlessly",    GOSSIP_SENDER_MAIN+2, GOSSIP_ACTION_INFO_DEF);
        player->ADD_GOSSIP_ITEM(0, "Let your friend go",                GOSSIP_SENDER_MAIN+3, GOSSIP_ACTION_INFO_DEF);
        player->SEND_GOSSIP_MENU(7341, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+3:
        player->ADD_GOSSIP_ITEM(0, "Confront the diplomat",             GOSSIP_SENDER_MAIN+4, GOSSIP_ACTION_INFO_DEF);
        player->ADD_GOSSIP_ITEM(0, "Show not so quiet defiance",        GOSSIP_SENDER_MAIN+5, GOSSIP_ACTION_INFO_DEF);
        player->ADD_GOSSIP_ITEM(0, "Remain quiet",                      GOSSIP_SENDER_MAIN+2, GOSSIP_ACTION_INFO_DEF);
        player->SEND_GOSSIP_MENU(7361, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+4:
        player->ADD_GOSSIP_ITEM(0, "Speak against your brother openly", GOSSIP_SENDER_MAIN+6, GOSSIP_ACTION_INFO_DEF);
        player->ADD_GOSSIP_ITEM(0, "Help your brother in",              GOSSIP_SENDER_MAIN+7, GOSSIP_ACTION_INFO_DEF);
        player->ADD_GOSSIP_ITEM(0, "Keep your brother out without letting him know", GOSSIP_SENDER_MAIN+8, GOSSIP_ACTION_INFO_DEF);
        player->SEND_GOSSIP_MENU(7362, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+5:
        player->ADD_GOSSIP_ITEM(0, "Take credit, keep gold",            GOSSIP_SENDER_MAIN+5, GOSSIP_ACTION_INFO_DEF);
        player->ADD_GOSSIP_ITEM(0, "Take credit, share the gold",       GOSSIP_SENDER_MAIN+4, GOSSIP_ACTION_INFO_DEF);
        player->ADD_GOSSIP_ITEM(0, "Let the knight take credit",        GOSSIP_SENDER_MAIN+3, GOSSIP_ACTION_INFO_DEF);
        player->SEND_GOSSIP_MENU(7363, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF:
        player->ADD_GOSSIP_ITEM(0, "Thanks",                            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
        player->SEND_GOSSIP_MENU(7364, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+6:
        _Creature->CastSpell(player, SPELL_FORTUNE, false);
        player->SEND_GOSSIP_MENU(7365, _Creature->GetGUID());
        break;
    }
}

bool GossipSelect_npc_sayge(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    switch(sender)
    {
    case GOSSIP_SENDER_MAIN:
        SendAction_npc_sayge(player, _Creature, action);
        break;
    case GOSSIP_SENDER_MAIN+1:
        _Creature->CastSpell(player, SPELL_DMG, false);
        player->AddSpellCooldown(SPELL_DMG,0,time(NULL) + 7200);
        SendAction_npc_sayge(player, _Creature, action);
        break;
    case GOSSIP_SENDER_MAIN+2:
        _Creature->CastSpell(player, SPELL_RES, false);
        player->AddSpellCooldown(SPELL_RES,0,time(NULL) + 7200);
        SendAction_npc_sayge(player, _Creature, action);
        break;
    case GOSSIP_SENDER_MAIN+3:
        _Creature->CastSpell(player, SPELL_ARM, false);
        player->AddSpellCooldown(SPELL_ARM,0,time(NULL) + 7200);
        SendAction_npc_sayge(player, _Creature, action);
        break;
    case GOSSIP_SENDER_MAIN+4:
        _Creature->CastSpell(player, SPELL_SPI, false);
        player->AddSpellCooldown(SPELL_SPI,0,time(NULL) + 7200);
        SendAction_npc_sayge(player, _Creature, action);
        break;
    case GOSSIP_SENDER_MAIN+5:
        _Creature->CastSpell(player, SPELL_INT, false);
        player->AddSpellCooldown(SPELL_INT,0,time(NULL) + 7200);
        SendAction_npc_sayge(player, _Creature, action);
        break;
    case GOSSIP_SENDER_MAIN+6:
        _Creature->CastSpell(player, SPELL_STM, false);
        player->AddSpellCooldown(SPELL_STM,0,time(NULL) + 7200);
        SendAction_npc_sayge(player, _Creature, action);
        break;
    case GOSSIP_SENDER_MAIN+7:
        _Creature->CastSpell(player, SPELL_STR, false);
        player->AddSpellCooldown(SPELL_STR,0,time(NULL) + 7200);
        SendAction_npc_sayge(player, _Creature, action);
        break;
    case GOSSIP_SENDER_MAIN+8:
        _Creature->CastSpell(player, SPELL_AGI, false);
        player->AddSpellCooldown(SPELL_AGI,0,time(NULL) + 7200);
        SendAction_npc_sayge(player, _Creature, action);
        break;
    }
    return true;
}

#define SPELL_TONK_MINE_DETONATE 25099
#define NPC_STEAM_TONK 19405

struct npc_tonk_mineAI : public ScriptedAI
{
    npc_tonk_mineAI(Creature *c) : ScriptedAI(c)
    {
        me->SetReactState(REACT_PASSIVE);
    }

    uint32 ArmingTimer;
    uint32 CheckTimer;

    void Reset()
    {
        ArmingTimer = 3000;
        CheckTimer = 1000;
    }

    void EnterCombat(Unit *who) {}
    void AttackStart(Unit *who) {}
    void MoveInLineOfSight(Unit *who) {}

    void UpdateAI(const uint32 diff)
    {
        if(ArmingTimer)
        {
            if(ArmingTimer <= diff)
            {
                ArmingTimer = 0;
            }
            else
                ArmingTimer -= diff;
        }
        else
        {
            if (CheckTimer < diff)
            {
                if(GetClosestCreatureWithEntry(me, NPC_STEAM_TONK, 2))
                {
                    me->CastSpell(me, SPELL_TONK_MINE_DETONATE, true);
                    me->setDeathState(DEAD);
                }
                CheckTimer = 1000;
            }
            else
                CheckTimer -= diff;
        }
    }
};

CreatureAI* GetAI_npc_tonk_mine(Creature *_Creature)
{
    return new npc_tonk_mineAI(_Creature);
}

/*####
## npc_winter_reveler
####*/

bool ReceiveEmote_npc_winter_reveler( Player *player, Creature *_Creature, uint32 emote )
{
    if ((!player->HasAura(26218))&&(emote == TEXTEMOTE_KISS))
    {
        _Creature->CastSpell(player, 26218, false);
        return true;
    }
    
    return false;
}

/*####
## npc_brewfest_reveler
####*/

bool ReceiveEmote_npc_brewfest_reveler( Player *player, Creature *_Creature, uint32 emote )
{
    if( emote == TEXTEMOTE_DANCE )
        _Creature->CastSpell(player, 41586, false);

    return true;
}

/*####
## npc_snake_trap_serpents
####*/

#define SPELL_MIND_NUMBING_POISON  8692    // Viper
#define SPELL_DEADLY_POISON        34655   // Venomous Snake
#define SPELL_CRIPPLING_POISON     3409    // Viper

#define SNAKE_VIPER                19921

struct npc_snake_trap_serpentsAI : public ScriptedAI
{
    npc_snake_trap_serpentsAI(Creature *c) : ScriptedAI(c) { me->SetAggroRange(15.0f); }

    Timer checkTimer;

    void EnterCombat(Unit*)
    {
        if (roll_chance_f(66.0f))
        {
            SetAutocast(me->GetEntry() == SNAKE_VIPER ? RAND(SPELL_MIND_NUMBING_POISON, SPELL_CRIPPLING_POISON) : SPELL_DEADLY_POISON, urand(1000, 3000), false, CAST_TANK);
            StartAutocast();
        }

        checkTimer.Reset(2000);

        me->SetReactState(REACT_AGGRESSIVE);
        me->setAttackTimer(BASE_ATTACK, urand(500, 1500));
    }

    bool UpdateVictim()
    {
        if (ScriptedAI::UpdateVictim())
            return true;

        if (Unit* target = me->SelectNearestTarget(5.0f))
            AttackStart(target);

        return me->getVictim();
    }

    void UpdateAI(const uint32 diff)
    {
        checkTimer.Update(diff);
        if (checkTimer.Passed())
        {
            Unit* owner = me->GetOwner();
            if (!owner || !owner->IsInMap(me))
            {
                me->ForcedDespawn();
                return;
            }
            checkTimer.Reset(2000);
        }

        if (!UpdateVictim())
            return;

        CastNextSpellIfAnyAndReady(diff);
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_snake_trap_serpents(Creature *_Creature)
{
    return new npc_snake_trap_serpentsAI(_Creature);
}

/*################
# Flight Master  #
################*/

uint32 ADVISOR[] =
{
    9297,      // ENRAGED_WYVERN
    9526,      // ENRAGED_GRYPHON
    9521,      // ENRAGED_FELBAT
    9527,      // ENRAGED_HIPPOGRYPH
    27946      // SILVERMOON_DRAGONHAWK
};
const char type[] = "WGBHD";

struct npc_flight_masterAI : public ScriptedAI
{
    npc_flight_masterAI(Creature *c) : ScriptedAI(c) {}

    void Reset() {}
    void SummonAdvisor()
    {
        const char *subname = me->GetSubName();
        for(uint8 i = 0; i<5; i++)
        {
            if(subname[0] == type[i])
            {
                DoSpawnCreature(ADVISOR[i], 0, 0, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1);
                DoSpawnCreature(ADVISOR[i], 0, 0, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1);
                break;
            }
        }
    }

    void JustSummoned(Creature *add)
    {
        if(add)
        {
            add->setFaction(me->getFaction());
            add->SetLevel(me->getLevel());
            add->AI()->AttackStart(me->getVictim());
        }
    }

    void EnterCombat(Unit *who)
    {
        SummonAdvisor();
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_flight_master(Creature *_Creature)
{
    return new npc_flight_masterAI(_Creature);
}

/*######
## npc_garments_of_quests
######*/

enum
{
    SPELL_LESSER_HEAL_R2    = 2052,
    SPELL_FORTITUDE_R1      = 1243,

    QUEST_MOON              = 5621,
    QUEST_LIGHT_1           = 5624,
    QUEST_LIGHT_2           = 5625,
    QUEST_SPIRIT            = 5648,
    QUEST_DARKNESS          = 5650,

    ENTRY_SHAYA             = 12429,
    ENTRY_ROBERTS           = 12423,
    ENTRY_DOLF              = 12427,
    ENTRY_KORJA             = 12430,
    ENTRY_DG_KEL            = 12428,

    SAY_COMMON_HEALED       = -1000531,
    SAY_DG_KEL_THANKS       = -1000532,
    SAY_DG_KEL_GOODBYE      = -1000533,
    SAY_ROBERTS_THANKS      = -1000556,
    SAY_ROBERTS_GOODBYE     = -1000557,
    SAY_KORJA_THANKS        = -1000558,
    SAY_KORJA_GOODBYE       = -1000559,
    SAY_DOLF_THANKS         = -1000560,
    SAY_DOLF_GOODBYE        = -1000561,
    SAY_SHAYA_THANKS        = -1000562,
    SAY_SHAYA_GOODBYE       = -1000563,
};

float RunTo[5][3]=
{
    {9661.724, 869.803, 1270.742},                          //shaya
    {-9543.747, -117.770, 57.893},                          //roberts
    {-5650.226, -473.517, 397.027},                         //dolf
    {189.175, -4747.069, 11.215},                           //kor'ja
    {2471.303, 371.101, 30.919},                            //kel
};

struct npc_garments_of_questsAI : public ScriptedAI
{
    npc_garments_of_questsAI(Creature *c) : ScriptedAI(c)
    {
        Reset();
    }

    uint64 caster;

    bool IsHealed;
    bool CanRun;

    uint32 RunAwayTimer;

    void Reset()
    {
        caster = 0;
        IsHealed = false;
        CanRun = false;

        RunAwayTimer = 5000;

        me->SetStandState(PLAYER_STATE_KNEEL);
        me->SetHealth(int(me->GetMaxHealth()*0.7));
        me->SetVisibility(VISIBILITY_ON);
    }

    void EnterCombat(Unit *who) {}

    void SpellHit(Unit* pCaster, const SpellEntry *Spell)
    {
        if(Spell->Id == SPELL_LESSER_HEAL_R2 || Spell->Id == SPELL_FORTITUDE_R1)
        {
            //not while in combat
            if(me->isInCombat())
                return;

            //nothing to be done now
            if(IsHealed && CanRun)
                return;

            if(pCaster->GetTypeId() == TYPEID_PLAYER)
            {
                switch(me->GetEntry())
                {
                case ENTRY_SHAYA:
                    if (((Player*)pCaster)->GetQuestStatus(QUEST_MOON) == QUEST_STATUS_INCOMPLETE)
                    {
                        if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                        {
                            DoScriptText(SAY_SHAYA_THANKS,me,pCaster);
                            CanRun = true;
                        }
                        else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                        {
                            caster = pCaster->GetGUID();
                            me->SetStandState(PLAYER_STATE_NONE);
                            DoScriptText(SAY_COMMON_HEALED,me,pCaster);
                            IsHealed = true;
                        }
                    }
                    break;
                case ENTRY_ROBERTS:
                    if (((Player*)pCaster)->GetQuestStatus(QUEST_LIGHT_1) == QUEST_STATUS_INCOMPLETE)
                    {
                        if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                        {
                            DoScriptText(SAY_ROBERTS_THANKS,me,pCaster);
                            CanRun = true;
                        }
                        else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                        {
                            caster = pCaster->GetGUID();
                            me->SetStandState(PLAYER_STATE_NONE);
                            DoScriptText(SAY_COMMON_HEALED,me,pCaster);
                            IsHealed = true;
                        }
                    }
                    break;
                case ENTRY_DOLF:
                    if (((Player*)pCaster)->GetQuestStatus(QUEST_LIGHT_2) == QUEST_STATUS_INCOMPLETE)
                    {
                        if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                        {
                            DoScriptText(SAY_DOLF_THANKS,me,pCaster);
                            CanRun = true;
                        }
                        else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                        {
                            caster = pCaster->GetGUID();
                            me->SetStandState(PLAYER_STATE_NONE);
                            DoScriptText(SAY_COMMON_HEALED,me,pCaster);
                            IsHealed = true;
                        }
                    }
                    break;
                case ENTRY_KORJA:
                    if (((Player*)pCaster)->GetQuestStatus(QUEST_SPIRIT) == QUEST_STATUS_INCOMPLETE)
                    {
                        if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                        {
                            DoScriptText(SAY_KORJA_THANKS,me,pCaster);
                            CanRun = true;
                        }
                        else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                        {
                            caster = pCaster->GetGUID();
                            me->SetStandState(PLAYER_STATE_NONE);
                            DoScriptText(SAY_COMMON_HEALED,me,pCaster);
                            IsHealed = true;
                        }
                    }
                    break;
                case ENTRY_DG_KEL:
                    if (((Player*)pCaster)->GetQuestStatus(QUEST_DARKNESS) == QUEST_STATUS_INCOMPLETE)
                    {
                        if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                        {
                            DoScriptText(SAY_DG_KEL_THANKS,me,pCaster);
                            CanRun = true;
                        }
                        else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                        {
                            caster = pCaster->GetGUID();
                            me->SetStandState(PLAYER_STATE_NONE);
                            DoScriptText(SAY_COMMON_HEALED,me,pCaster);
                            IsHealed = true;
                        }
                    }
                    break;
                }

                //give quest credit, not expect any special quest objectives
                if (CanRun)
                    ((Player*)pCaster)->TalkedToCreature(me->GetEntry(),me->GetGUID());
            }
        }
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if (type != POINT_MOTION_TYPE)
            return;

        //we reached destination, kill ourselves
        if (id == 0)
        {
            me->SetVisibility(VISIBILITY_OFF);
            me->setDeathState(JUST_DIED);
            me->SetHealth(0);
            me->CombatStop();
            me->DeleteThreatList();
            me->RemoveCorpse();
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (CanRun && !me->isInCombat())
        {
            if (RunAwayTimer <= diff)
            {
                if (Unit *pUnit = Unit::GetUnit(*me,caster))
                {
                    switch(me->GetEntry())
                    {
                    case ENTRY_SHAYA:
                        DoScriptText(SAY_SHAYA_GOODBYE,me,pUnit);
                        me->GetMotionMaster()->MovePoint(0, RunTo[0][0], RunTo[0][1], RunTo[0][2]);
                        break;
                    case ENTRY_ROBERTS:
                        DoScriptText(SAY_ROBERTS_GOODBYE,me,pUnit);
                        me->GetMotionMaster()->MovePoint(0, RunTo[1][0], RunTo[1][1], RunTo[1][2]);
                        break;
                    case ENTRY_DOLF:
                        DoScriptText(SAY_DOLF_GOODBYE,me,pUnit);
                        me->GetMotionMaster()->MovePoint(0, RunTo[2][0], RunTo[2][1], RunTo[2][2]);
                        break;
                    case ENTRY_KORJA:
                        DoScriptText(SAY_KORJA_GOODBYE,me,pUnit);
                        me->GetMotionMaster()->MovePoint(0, RunTo[3][0], RunTo[3][1], RunTo[3][2]);
                        break;
                    case ENTRY_DG_KEL:
                        DoScriptText(SAY_DG_KEL_GOODBYE,me,pUnit);
                        me->GetMotionMaster()->MovePoint(0, RunTo[4][0], RunTo[4][1], RunTo[4][2]);
                        break;
                    }
                }
                else
                    EnterEvadeMode();                       //something went wrong

                RunAwayTimer = 30000;
            }
            else
                RunAwayTimer -= diff;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_garments_of_quests(Creature* pCreature)
{
    return new npc_garments_of_questsAI(pCreature);
}

/*########
# npc_mojo
#########*/

#define SPELL_FEELING_FROGGY    43906
#define SPELL_HEARTS            20372   //wrong ?
#define MOJO_WHISPS_COUNT       8

struct npc_mojoAI : public ScriptedAI
{
    npc_mojoAI(Creature *c) : ScriptedAI(c) {}

    uint32 heartsResetTimer;
    bool hearts;

    void Reset()
    {
        heartsResetTimer = 15000;
        hearts = false;
        me->GetMotionMaster()->MoveFollow(me->GetOwner(), 2.0, M_PI/2);
    }

    void EnterCombat(Unit *who) {}

    void OnAuraApply(Aura* aur, Unit* caster, bool stackApply)
    {
        if (aur->GetId() == SPELL_HEARTS)
        {
            hearts = true;
            heartsResetTimer = 15000;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (hearts)
        {
            if (heartsResetTimer <= diff)
            {
                me->RemoveAurasDueToSpell(SPELL_HEARTS);
                hearts = false;
                me->GetMotionMaster()->MoveFollow(me->GetOwner(), 2.0, M_PI/2);
                me->SetSelection(0);
            }
            else
                heartsResetTimer -= diff;
        }
    }
};

bool ReceiveEmote_npc_mojo( Player *player, Creature *_Creature, uint32 emote )
{
    if( emote == TEXTEMOTE_KISS )
    {
        if (!_Creature->HasAura(SPELL_HEARTS, 0))
        {
            //affect only the same conflict side (horde -> horde or ally -> ally)
            if( player->GetTeam() == _Creature->GetCharmerOrOwnerPlayerOrPlayerItself()->GetTeam() )
            {
                player->CastSpell(player, SPELL_FEELING_FROGGY, false);
                _Creature->CastSpell(_Creature, SPELL_HEARTS, false);
                _Creature->SetSelection(player->GetGUID());

                _Creature->GetMotionMaster()->MoveFollow(player, 1.0, 0);

                const char* text;

                switch (urand(0, MOJO_WHISPS_COUNT))
                {
                case 0:
                    text = "Now that's what I call froggy-style!";
                    break;
                case 1:
                    text = "Your lily pad or mine?";
                    break;
                case 2:
                    text = "This won't take long, did it?";
                    break;
                case 3:
                    text = "I thought you'd never ask!";
                    break;
                case 4:
                    text = "I promise not to give you warts...";
                    break;
                case 5:
                    text = "Feelin' a little froggy, are ya?";
                    break;
                case 6:
                    text = "Listen, $n, I know of a little swamp not too far from here....";
                    break;
                default:
                    text = "There's just never enough Mojo to go around...";
                    break;
                }

                _Creature->Whisper(text, player->GetGUID(), false);
            }
        }
    }

    return true;
}

CreatureAI* GetAI_npc_mojo(Creature *_Creature)
{
    return new npc_mojoAI(_Creature);
}


/*########
# npc_woeful_healer
#########*/

#define SPELL_PREYER_OF_HEALING     30604

struct npc_woeful_healerAI : public ScriptedAI
{
    npc_woeful_healerAI(Creature *c) : ScriptedAI(c)
    {
        Reset();
    }

    uint32 healTimer;

    void Reset()
    {
        healTimer = urand(2500, 7500);
        me->GetMotionMaster()->MoveFollow(me->GetOwner(), 2.0, M_PI/2);
    }

    void EnterCombat(Unit *who) {}

    void UpdateAI(const uint32 diff)
    {
        Unit * owner = me->GetCharmerOrOwner();

        if (healTimer <= diff)
        {
            healTimer = urand(2500, 7500);
            if (!owner || !owner->isInCombat())
                return;
            me->CastSpell(me, SPELL_PREYER_OF_HEALING, false);
        }
        else
            healTimer -= diff;
    }
};

CreatureAI* GetAI_npc_woeful_healer(Creature* pCreature)
{
    return new npc_woeful_healerAI(pCreature);
}

#define GOSSIP_VIOLET_SIGNET    "I have lost my Violet Signet, could you make me a new one?"
#define GOSSIP_ETERNAL_BAND    "I have lost my Eternal Band, could you make me a new one?"

// Archmage Leryda from Karazhan and Soridormi from Mount Hyjal
bool GossipHello_npc_ring_specialist(Player* player, Creature* _Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );
    uint32 entry = _Creature->GetEntry();
    switch(entry)
    {
        // Archmage Leryda
    case 18253:
        // player has none of the rings
        if((!player->HasItemCount(29287, 1, true) && !player->HasItemCount(29279, 1, true) && !player->HasItemCount(29283, 1, true) && !player->HasItemCount(29290, 1, true))
                && // and had completed one of the chains
                (player->GetQuestRewardStatus(10725) || player->GetQuestRewardStatus(10728) || player->GetQuestRewardStatus(10727) || player->GetQuestRewardStatus(10726)))
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_VIOLET_SIGNET, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        break;
        // Soridormi
    case 19935:
        // player has none of the rings
        if((!player->HasItemCount(29305, 1, true) && !player->HasItemCount(29309, 1, true) && !player->HasItemCount(29301, 1, true) && !player->HasItemCount(29297, 1, true))
                && // and had completed one of the chains
                (player->GetQuestRewardStatus(10472) || player->GetQuestRewardStatus(10473) || player->GetQuestRewardStatus(10474) || player->GetQuestRewardStatus(10475)))
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ETERNAL_BAND,   GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        break;
    }

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    return true;
}

void RestoreQuestRingItem(Player* player, uint32 id)
{
    ItemPosCountVec dest;
    uint8 msg = player->CanStoreNewItem( NULL_BAG, NULL_SLOT, dest, id, 1);
    if( msg == EQUIP_ERR_OK )
    {
        Item* item = player->StoreNewItem( dest, id, true);
        player->SendNewItem(item, 1, true, false);
    }
}

bool GossipSelect_npc_ring_specialist(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    switch( action )
    {
    case GOSSIP_ACTION_INFO_DEF + 1:
        if(player->GetQuestRewardStatus(10725))
            RestoreQuestRingItem(player, 29287);
        if(player->GetQuestRewardStatus(10728))
            RestoreQuestRingItem(player, 29279);
        if(player->GetQuestRewardStatus(10727))
            RestoreQuestRingItem(player, 29283);
        if(player->GetQuestRewardStatus(10726))
            RestoreQuestRingItem(player, 29290);
        player->CLOSE_GOSSIP_MENU();
        break;
    case GOSSIP_ACTION_INFO_DEF + 2:
        if(player->GetQuestRewardStatus(10472))
            RestoreQuestRingItem(player, 29305);
        if(player->GetQuestRewardStatus(10473))
            RestoreQuestRingItem(player, 29309);
        if(player->GetQuestRewardStatus(10474))
            RestoreQuestRingItem(player, 29301);
        if(player->GetQuestRewardStatus(10475))
            RestoreQuestRingItem(player, 29297);
        player->CLOSE_GOSSIP_MENU();
        break;
    }
    return true;
}

/*######
# npc_fire_elemental_guardian
######*/
#define SPELL_FIRENOVA          12470                   // wrong, spell disabled in code
#define SPELL_FIRESHIELD        13376                   // this spell is not an aura, it's instant cast aoe
#define SPELL_FIREBLAST         8413                    // we won't find the proper one fireblast, so we use the one with the best matching stats

struct npc_fire_elemental_guardianAI : public ScriptedAI
{
    npc_fire_elemental_guardianAI(Creature* c) : ScriptedAI(c){}

    uint32 FireNova_Timer;
    uint32 FireBlast_Timer;
    uint32 FireShield_Timer;

    void Reset()
    {
//        FireNova_Timer = 5000 + rand() % 15000; // 5-20 sec cd
        FireBlast_Timer = 10000 +rand() % 5000; // 10-15 sec cd
        FireShield_Timer = 2000; // 1 tick/ 2sec
        me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
        me->SetReactState(REACT_DEFENSIVE);
        me->SetAggroRange(0);
        me->CombatStopWithPets();
        me->ClearInCombat();
        me->AttackStop();
    }

    void UpdateAI(const uint32 diff)
    {
       Creature *pTotem = me->GetCreature(me->GetOwnerGUID());
       Unit *victim = pTotem->SelectNearestTarget(20.0f);
       Unit *attacker = pTotem->getAttackerForHelper();

       if (pTotem)
       {
          if (!pTotem->isAlive())
          {
             me->ForcedDespawn();
             return;
          }
          if (!me->IsWithinDistInMap(pTotem, 30.0f) || (!victim || !attacker))
          {
             if (!me->getVictim()|| !me->IsWithinDistInMap(pTotem, 30.0f))
                if (!me->hasUnitState(UNIT_STAT_FOLLOW)) 
                {
                   victim = NULL;
                   attacker = NULL;
                   me->GetMotionMaster()->MoveFollow(pTotem, 2.0f, M_PI);
                   Reset();
                   return;
                }
          }
          if (me->getVictim() && me->getVictim()->GetCharmerOrOwnerPlayerOrPlayerItself() &&
              (pTotem->isInSanctuary() || me->isInSanctuary() || me->getVictim()->isInSanctuary() ||
              (me->getVictim()->GetMap()->IsDungeon() || me->getVictim()->GetMap()->IsRaid())))
          {
             victim = NULL;
             attacker = NULL;
             me->GetMotionMaster()->MoveFollow(pTotem, 2.0f, M_PI);
             Reset();
             return;
          }

          if ((victim || attacker))
          {
             if (attacker)
             {
                me->SetInCombatWith(attacker);
                AttackStart(attacker);
             }
             else
             {
                me->SetInCombatWith(victim);
                AttackStart(victim);
             }
             if (me->hasUnitState(UNIT_STAT_CASTING))
                return;

             if (FireShield_Timer <= diff)
             {
                DoCast(me->getVictim(), SPELL_FIRESHIELD);
                FireShield_Timer = 2000;
             }
             else
                FireShield_Timer -= diff;



             if (FireBlast_Timer <= diff)
             {
                DoCast(me->getVictim(), SPELL_FIREBLAST);
                FireBlast_Timer = 10000 + rand() % 5000; // 10-15 sec cd
             }
             else
                FireBlast_Timer -= diff;


/*
             if (FireNova_Timer <= diff)
             {
                DoCast(me->getVictim(), SPELL_FIRENOVA);
                FireNova_Timer = 5000 + rand() % 15000; // 5-20 sec cd
             }
             else
                FireNova_Timer -= diff;
*/

             DoMeleeAttackIfReady();
          }
       }
    }
};

CreatureAI *GetAI_npc_fire_elemental_guardian(Creature* c)
{
     return new npc_fire_elemental_guardianAI(c);
};

/*######
# npc_earth_elemental_guardian
######*/
#define SPELL_ANGEREDEARTH        36213

struct npc_earth_elemental_guardianAI : public ScriptedAI
{
    npc_earth_elemental_guardianAI(Creature* c) : ScriptedAI(c) {}

    uint32 AngeredEarth_Timer;

    void Reset()
    {
        AngeredEarth_Timer = 1000;
        me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
        me->SetReactState(REACT_DEFENSIVE);
        me->SetAggroRange(0);
        me->CombatStopWithPets();
        me->ClearInCombat();
        me->AttackStop();
    }

    void UpdateAI(const uint32 diff)
    {
       Creature *pTotem = me->GetCreature(me->GetOwnerGUID());
       Unit *victim = pTotem->SelectNearestTarget(20.0f);
       Unit *attacker = pTotem->getAttackerForHelper();

       if (pTotem)
       {
          if (!pTotem->isAlive())
          {
             me->ForcedDespawn();
             return;
          }

          if (!me->IsWithinDistInMap(pTotem, 30.0f) || (!victim || !attacker))
          {
             if (!me->getVictim() || !me->IsWithinDistInMap(pTotem, 30.0f))
                if (!me->hasUnitState(UNIT_STAT_FOLLOW)) 
                {
                   victim = NULL;
                   attacker = NULL;
                   me->GetMotionMaster()->MoveFollow(pTotem, 2.0f, M_PI);
                   Reset();
                   return;
                }
          }

          if (me->getVictim() && me->getVictim()->GetCharmerOrOwnerPlayerOrPlayerItself() &&
              (pTotem->isInSanctuary() || me->isInSanctuary() || me->getVictim()->isInSanctuary() ||
              (me->getVictim()->GetMap()->IsDungeon() || me->getVictim()->GetMap()->IsRaid())))
          {
             victim = NULL;
             attacker = NULL;
             me->GetMotionMaster()->MoveFollow(pTotem, 2.0f, M_PI);
             Reset();
             return;
          }


          if ((victim || attacker))
          {

             if (attacker)
                AttackStart(attacker);
             else
                AttackStart(victim);

             if (AngeredEarth_Timer <= diff)
             {
                DoCast(me->getVictim(), SPELL_ANGEREDEARTH);
                AngeredEarth_Timer = 5000 + rand() % 15000; // 5-20 sec cd
             }
             else
                AngeredEarth_Timer -= diff;

             DoMeleeAttackIfReady();
          }
       }
    }
};

CreatureAI *GetAI_npc_earth_elemental_guardian(Creature* c)
{
    return new npc_earth_elemental_guardianAI(c);
};

/*########
# npc_master_omarion
#########*/

//Blacksmithing
#define GOSSIP_ITEM_OMARION0  "Learn Icebane Bracers pattern."
#define GOSSIP_ITEM_OMARION1  "Learn Icebane Gauntlets pattern."
#define GOSSIP_ITEM_OMARION2  "Learn Icebane Breastplate pattern."
//Leatherworking
#define GOSSIP_ITEM_OMARION3  "Learn Polar Bracers pattern."
#define GOSSIP_ITEM_OMARION4  "Learn Polar Gloves pattern."
#define GOSSIP_ITEM_OMARION5  "Learn Polar Tunic pattern."
#define GOSSIP_ITEM_OMARION6  "Learn Icy Scale Bracers pattern."
#define GOSSIP_ITEM_OMARION7  "Learn Icy Scale Gauntlets pattern."
#define GOSSIP_ITEM_OMARION8  "Learn Icy Scale Breastplate pattern."
//Tailoring
#define GOSSIP_ITEM_OMARION9  "Learn Glacial Wrists pattern."
#define GOSSIP_ITEM_OMARION10 "Learn Glacial Gloves pattern."
#define GOSSIP_ITEM_OMARION11 "Learn Glacial Vest pattern."
#define GOSSIP_ITEM_OMARION12 "Learn Glacial Cloak pattern."

bool GossipHello_npc_master_omarion(Player *player, Creature *_Creature)
{
    bool isexalted,isrevered;
    isexalted = false;
    isrevered = false;
    if(player->GetReputationMgr().GetReputation(529) >= 21000)
    {
        isrevered = true;
        if(player->GetReputationMgr().GetReputation(529) >= 42000)
            isexalted = true;
    }

    if(player->GetBaseSkillValue(SKILL_BLACKSMITHING)>=300) // Blacksmithing +300
    {
        if(isrevered)
        {
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION0    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION1    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            if(isexalted)
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION2    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            }
        }
    }
    if(player->GetBaseSkillValue(SKILL_LEATHERWORKING)>=300) // Leatherworking +300
    {
        if(isrevered)
        {
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION3    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION4    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
            if(isexalted)
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION5    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
            }
        }
        if(isrevered)
        {
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION6    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION7    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
            if(isexalted)
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION8    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);
            }
        }
    }
    if(player->GetBaseSkillValue(SKILL_TAILORING)>=300) // Tailoring +300
    {
        if(isrevered)
        {
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION9    , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION10   , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
            if(isexalted)
            {
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION11   , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_OMARION12   , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
            }
        }
    }
    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_master_omarion(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    switch (action)
    {
    case GOSSIP_ACTION_INFO_DEF + 1:         // Icebane Bracers
        player->learnSpell( 28244 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 2:         // Icebane Gauntlets
        player->learnSpell( 28243 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 3:         // Icebane Breastplate
        player->learnSpell( 28242 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 4:         // Polar Bracers
        player->learnSpell( 28221 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 5:         // Polar Gloves
        player->learnSpell( 28220 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 6:         // Polar Tunic
        player->learnSpell( 28219 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 7:         // Icy Scale Bracers
        player->learnSpell( 28224 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 8:         // Icy Scale Gauntlets
        player->learnSpell( 28223 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 9:         // Icy Scale Breastplate
        player->learnSpell( 28222 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 10:        // Glacial Wrists
        player->learnSpell( 28209 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 11:        // Glacial Gloves
        player->learnSpell( 28205 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 12:        // Glacial Vest
        player->learnSpell( 28207 );
        break;
    case GOSSIP_ACTION_INFO_DEF + 13:        // Glacial Cloak
        player->learnSpell( 28208 );
        break;
    }
    player->CLOSE_GOSSIP_MENU();
    return true;
}


/*########
# npc_lorekeeper_lydros
#########*/

#define GOSSIP_ITEM_LOREKEEPER1 "Fascinating, Lorekeeper. Continue please."
#define GOSSIP_ITEM_LOREKEEPER2 "(Continue)"
#define GOSSIP_ITEM_LOREKEEPER3 "Eh?"
#define GOSSIP_ITEM_LOREKEEPER4 "Maybe... What do I do now?"

bool GossipHello_npc_lorekeeper_lydros(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );
    if(player->GetQuestRewardStatus(7507) && !player->HasItemCount(18513,1))
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_LOREKEEPER1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1 );

    player->SEND_GOSSIP_MENU(24999, _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_lorekeeper_lydros(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    switch (action)
    {
    case GOSSIP_ACTION_INFO_DEF+1:
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_LOREKEEPER2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        player->SEND_GOSSIP_MENU(25000, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+2:
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_LOREKEEPER2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
        player->SEND_GOSSIP_MENU(25001, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+3:
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_LOREKEEPER2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
        player->SEND_GOSSIP_MENU(25002, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+4:
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_LOREKEEPER3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
        player->SEND_GOSSIP_MENU(25003, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+5:
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_LOREKEEPER4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
        player->SEND_GOSSIP_MENU(25004, _Creature->GetGUID());
        break;
    case GOSSIP_ACTION_INFO_DEF+6:
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 18513, 1);
        if (msg == EQUIP_ERR_OK)
        {
            Item* item = player->StoreNewItem(dest, 18513, true);
            player->SendNewItem(item,1,true,false,true);
        }
        player->CLOSE_GOSSIP_MENU();
        break;
    }
    return true;
}


/*########
# npc_crashin_trashin_robot
#########*/

#define SPELL_MACHINE_GUN           42382
#define SPELL_NET                   41580
#define SPELL_ELECTRICAL            42372
#define CRASHIN_TRASHIN_ROBOT_ID    17299

struct npc_crashin_trashin_robotAI : public ScriptedAI
{
    npc_crashin_trashin_robotAI(Creature *c) : ScriptedAI(c) {}

    uint32 machineGunTimer;
    uint32 netTimer;
    uint32 electricalTimer;
    uint32 checkTimer;
    uint32 moveTimer;
    uint32 despawnTimer;
    uint32 waitTimer;

    void Reset()
    {
        waitTimer = 5000;
        machineGunTimer = urand(1000, 3000);
        netTimer = urand(10000, 20000);
        electricalTimer = urand(5000, 35000);
        checkTimer = 3000;
        me->SetDefaultMovementType(RANDOM_MOTION_TYPE);

        me->GetMotionMaster()->MoveRandom(10.0);
        moveTimer = urand(1000, 10000);
        despawnTimer = 180000;
    }

    void EnterCombat(Unit *who)
    {
        checkTimer = 0;
    }

    std::list<Creature*> FindCrashinTrashinRobots()
    {
        std::list<Creature*> crashinTrashinRobots = FindAllCreaturesWithEntry(CRASHIN_TRASHIN_ROBOT_ID, 10.0);

        for (std::list<Creature*>::iterator itr = crashinTrashinRobots.begin(); itr != crashinTrashinRobots.end();)
        {
            std::list<Creature*>::iterator tmpItr = itr;
            ++itr;
            if ((*tmpItr)->GetGUID() == me->GetGUID())
            {
                crashinTrashinRobots.erase(tmpItr);
                break;
            }
        }

        return crashinTrashinRobots;
    }

    void SpellHit(Unit * caster, const SpellEntry * spell)
    {
        if (me->isInCombat() || !caster || !spell || caster->GetEntry() != CRASHIN_TRASHIN_ROBOT_ID)
            return;

        me->SetInCombatWith(caster);
        caster->SetInCombatWith(me);
    }

    void UpdateAI(const uint32 diff)
    {
        if (waitTimer)
        {
            if (waitTimer <= diff)
                waitTimer = 0;
            else
                waitTimer -= diff;

            return;
        }

        if (!me->isAlive())
            return;

        if (despawnTimer < diff)
        {
            me->Kill(me, false);
            return;
        }
        else
            despawnTimer -= diff;

        if (checkTimer)
        {
            if (checkTimer <= diff)
            {
                if (!(FindCrashinTrashinRobots().empty()))
                    checkTimer = 0;
                else
                    checkTimer = 3000;
            }
            else
                checkTimer -= diff;

            return;
        }

        std::list<Creature*> otherCrashinTrashinRobots;
        std::list<Creature*>::iterator itr;

        if (moveTimer < diff)
        {
            if (!me->HasAura(SPELL_NET, 0))
                otherCrashinTrashinRobots = FindCrashinTrashinRobots();

            int count = otherCrashinTrashinRobots.size();

            if (count)
            {
                float x, y, z;
                itr = otherCrashinTrashinRobots.begin();

                if (count > 1)
                    advance(itr, rand()%(count - 1));

                Creature * tmp = *(itr);

                tmp->GetNearPoint(x, y, z, 0, 5.0f, frand(0.0f, M_PI*2));
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, x, y, z);
            }

            moveTimer = urand(5000, 15000);
        }
        else
            moveTimer -= diff;

        if (machineGunTimer < diff)
        {
            if (otherCrashinTrashinRobots.empty())
                otherCrashinTrashinRobots = FindCrashinTrashinRobots();

            int count = otherCrashinTrashinRobots.size();

            if (count)
            {
                itr = otherCrashinTrashinRobots.begin();

                if (count > 1)
                    advance(itr, rand()%(count - 1));

                AddSpellToCast(*itr, SPELL_MACHINE_GUN, false, true);
            }

            machineGunTimer = urand(500, 2000);
        }
        else
            machineGunTimer -= diff;

        if (netTimer < diff)
        {
            if (otherCrashinTrashinRobots.empty())
                otherCrashinTrashinRobots = FindCrashinTrashinRobots();

            int count = otherCrashinTrashinRobots.size();

            if (count)
            {
                itr = otherCrashinTrashinRobots.begin();

                if (count > 1)
                    advance(itr, rand()%(count - 1));

                AddSpellToCast(*itr, SPELL_NET, false, true);
            }

            netTimer = urand(10000, 30000);
        }
        else
            netTimer -= diff;

        if (electricalTimer < diff)
        {
            if (otherCrashinTrashinRobots.empty())
                otherCrashinTrashinRobots = FindCrashinTrashinRobots();

            int count = otherCrashinTrashinRobots.size();

            if (count)
            {
                itr = otherCrashinTrashinRobots.begin();
                if (count > 1)
                    advance(itr, rand()%(count - 1));

                AddSpellToCast(*itr, SPELL_ELECTRICAL, false, true);
            }

            electricalTimer = urand(5000, 45000);
        }
        else
            electricalTimer -= diff;

        CastNextSpellIfAnyAndReady();
    }
};

CreatureAI* GetAI_npc_crashin_trashin_robot(Creature* pCreature)
{
    return new npc_crashin_trashin_robotAI(pCreature);
}

/*########
# npc_Oozeling
#########*/

#define GO_DARK_IRON_ALE_MUG    165578

struct pet_AleMugDrinkerAI : public ScriptedAI
{
    pet_AleMugDrinkerAI(Creature *c) : ScriptedAI(c) {}

    uint32 wait;
    bool aleMug_drink;

    void Reset()
    {
        wait = 0;
        aleMug_drink = false;
        me->GetMotionMaster()->MoveFollow(me->GetOwner(), 2.0, M_PI/2);
    }

    void SpellHit(Unit * caster, const SpellEntry * spell)
    {
        if(spell->Id == 14813 && caster)
        {
            wait = 3000;
            aleMug_drink = true;
            float x, y, z;
            caster->GetPosition(x,y,z);
            me->GetMotionMaster()->MovePoint(0, x, y, z);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!aleMug_drink)
            return;

        if (wait < diff)
        {
            if (GameObject* mug = FindGameObject(GO_DARK_IRON_ALE_MUG, 20.0, me))
                mug->Delete();
            Reset();
        }
        else wait -= diff;
    }
};

CreatureAI* GetAI_pet_AleMugDrinker(Creature* pCreature)
{
    return new pet_AleMugDrinkerAI(pCreature);
}

/*########
# brewfest triggers
#########*/

struct trigger_appleAI : public ScriptedAI
{
    trigger_appleAI(Creature *c) : ScriptedAI(c) {}

    void MoveInLineOfSight(Unit *who)
    {
        if (!who)
            return;

        if (me->IsWithinDistInMap(who, 7.0f) && who->HasAura(43052, 0))
        {
            who->RemoveAurasDueToSpell(43052);
        }
    }
};

CreatureAI* GetAI_trigger_apple(Creature* pCreature)
{
    return new trigger_appleAI(pCreature);
}

struct trigger_deliveryAI : public ScriptedAI
{
    trigger_deliveryAI(Creature *c) : ScriptedAI(c) {}

    void MoveInLineOfSight(Unit *who)
    {
        if (!who || who->GetTypeId() != TYPEID_PLAYER)
            return;

        if (me->IsWithinDistInMap(who, 20.0f) && (who->HasAura(43880, 0) || who->HasAura(43883, 0)) && ((Player*)who)->HasItemCount(33797, 1))
        {
            who->CastSpell(me, 43662, true);
            who->CastSpell(who, 44601, true);
            ((Player*)who)->DestroyItemCount(33797, 1, true);

            if(who->HasAura(43534, 0))
            {
                who->CastSpell(who, 44501, true);
                who->CastSpell(who, 43755, true);
            }
        }
    }
};

CreatureAI* GetAI_trigger_delivery(Creature* pCreature)
{
    return new trigger_deliveryAI(pCreature);
}

struct trigger_delivery_kegAI : public ScriptedAI
{
    trigger_delivery_kegAI(Creature *c) : ScriptedAI(c) {}

    void MoveInLineOfSight(Unit *who)
    {
        if (!who || who->GetTypeId() != TYPEID_PLAYER)
            return;

        if (me->IsWithinDistInMap(who, 20.0f) && (who->HasAura(43880, 0) || who->HasAura(43883, 0)) && !((Player*)who)->HasItemCount(33797, 1))
        {
            who->CastSpell(who, 43660, true);
        }
    }
};

CreatureAI* GetAI_trigger_delivery_keg(Creature* pCreature)
{
    return new trigger_delivery_kegAI(pCreature);
}

bool GossipHello_npc_delivery_daily(Player *player, Creature *_Creature)
{
    if( _Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if(!player->HasAura(44689, 0) && (player->GetQuestStatus(11122) == QUEST_STATUS_COMPLETE || player->GetQuestStatus(11412) == QUEST_STATUS_COMPLETE))
    {
        player->PlayerTalkClass->GetGossipMenu().AddMenuItem(0, "Do you have additional work?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF, "", 0);
    }

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_delivery_daily(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if(action == GOSSIP_ACTION_INFO_DEF)
    {
        player->CLOSE_GOSSIP_MENU();
        _Creature->CastSpell(player, 44368, true);
        _Creature->CastSpell(player, 44262, true);
    }

    return true;
}

struct trigger_barkerAI : public ScriptedAI
{
    trigger_barkerAI(Creature *c) : ScriptedAI(c) {}

    void MoveInLineOfSight(Unit *who)
    {
        if (!who || who->GetTypeId() != TYPEID_PLAYER)
            return;

        if (me->IsWithinDistInMap(who, 10.0f) && who->HasAura(43883, 0))
        {
            ((Player*)who)->CastedCreatureOrGO(me->GetEntry(), me->GetGUID(), 0);
        }
    }
};

CreatureAI* GetAI_trigger_barker(Creature* pCreature)
{
    return new trigger_barkerAI(pCreature);
}

//This function is called when the player opens the gossip menubool
bool GossipHello_npc_arena_spectator(Player *player, Creature *_Creature)
{
    player->ADD_GOSSIP_ITEM_EXTENDED(0, "Whose arena do ypu wanna to watch?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1, "", 0, true);
    player->ADD_GOSSIP_ITEM(0, "I'm not interested", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);

    player->PlayerTalkClass->SendGossipMenu(907,_Creature->GetGUID());
    return true;
}

bool GossipSelectWithCode_npc_arena_spectator(Player *player, Creature *_Creature, uint32 sender, uint32 action, const char* sCode)
{
    if (sender == GOSSIP_SENDER_MAIN)
    {
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            if (Player *pPlayer = player->GetPlayerByName(sCode))
            {
                if (!pPlayer->InArena())
                    return false;

                // temp, for now I have no idea if cross map bindsight is allowed :p
                if (Creature *pSpectator = pPlayer->GetBGCreature(ARENA_NPC_SPECTATOR))
                {
                    player->SetVisibility(VISIBILITY_OFF);

                    player->SetBattleGroundId(pPlayer->GetBattleGroundId(), pPlayer->GetBattleGroundTypeId());
                    player->SetBattleGroundEntryPoint(player->GetMapId(), player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation());

                    player->TeleportTo(pSpectator->GetMapId(), pSpectator->GetPositionX(), pSpectator->GetPositionY(), pSpectator->GetPositionZ(), pSpectator->GetOrientation());

                    player->SetClientControl(player, false);
                    player->SetFlying(true);

                    player->GetCamera().SetView(player);
                }
            }
            player->CLOSE_GOSSIP_MENU();
            return true;
        }
    }
    return false;
}

/*###
# npc_land_mine
# UPDATE `creature_template` SET `ScriptName` = 'npc_land_mine' WHERE `entry` = 7527;
###*/

struct npc_land_mineAI : public Scripted_NoMovementAI
{
    npc_land_mineAI(Creature *c) : Scripted_NoMovementAI(c), _done(false)
    {
        me->SetAggroRange(5.0f);
    }

    bool _done;
    void IsSummonedBy(Unit *summoner)
    {
        me->setFaction(summoner->getFaction());
        me->SetOwnerGUID(summoner->GetGUID());

        // despawn after 10s
        me->ForcedDespawn(10000);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (_done || !me->canStartAttack(who))
            return;

        int32 damage = urand(394, 507);
        me->CastCustomSpell(me, 27745, &damage, 0, 0, true);
        me->ForcedDespawn();

        _done = true;
    }
};

CreatureAI* GetAI_npc_land_mine(Creature* pCreature)
{
    return new npc_land_mineAI(pCreature);
}

enum MiniPetsInfo
{
    NPC_PANDA                   = 11325,
    SPELL_PANDA_SLEEP           = 19231,
    SPELL_PANDA_ROAR            = 40664,

    NPC_DIABLO                  = 11326,
    SPELL_DIABLO_FLAME          = 18874,

    NPC_ZERGLING                = 11327,
    SPELL_ZERGLING              = 19227,

    NPC_WILLY                   = 23231,
    SPELL_WILLY_SLEEP           = 40663,
    SPELL_WILLY_TRIGGER         = 40619,

    NPC_DRAGON_KITE             = 25110,
    SPELL_DRAGON_KITE_LIGHTNING = 45197,
    SPELL_DRAGON_KITE_STRING    = 45192,

    NPC_MURKY                   = 15186,
    NPC_LURKY                   = 15358,
    NPC_GURKY                   = 16069,
    SPELL_MURKY_DANCE           = 25165,

    NPC_EGBERT                  = 23258,
    SPELL_EGBERT_HAPPYNESS      = 40669,

    NPC_SCORCHLING              = 25706,
    SPELL_SCORCHLING_BLAST      = 45889,

    NPC_DISGUSTING_OOZELING     = 15429,
};

struct npc_small_pet_handlerAI : public ScriptedAI
{
    npc_small_pet_handlerAI(Creature* pCreature) : ScriptedAI(pCreature) {}

    bool m_bIsIdle;
    bool m_bIsInAction;

    uint32 m_uiCheckTimer;
    uint32 m_uiActionTimer;

    void Reset()
    {
        ClearCastQueue();

        m_bIsIdle = false;
        m_bIsInAction = false;

        m_uiCheckTimer = 1000;
        m_uiActionTimer = urand(10000, 30000);

        me->GetMotionMaster()->MoveFollow(me->GetOwner(), PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);

        PetCreateAction(me->GetEntry());
    }

    void AttackStart(Unit* who) {}

    void EnterCombat(Unit *who) {}

    void UpdateAI(const uint32 uiDiff)
    {
        // Check if pet is moving
        if (m_uiCheckTimer < uiDiff)
        {
            if (Unit* pUnit = me->GetOwner())
            {
                Player *pPlayer = pUnit->ToPlayer();

                // Change speed if owner is mounted
                if (pPlayer->IsMounted())
                    me->SetSpeed(MOVE_RUN, 2.0f, true);
                else
                    me->SetSpeed(MOVE_RUN, 1.0f, true);

                // Check if owner is stopped
                if (pPlayer->isMoving() && m_bIsIdle)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_NONE);

                    if (me->IsNonMeleeSpellCasted(false))
                        me->InterruptNonMeleeSpells(false);

                    m_bIsIdle = false;
                    m_uiActionTimer = urand(10000, 20000);
                }
                else if (me->IsWithinDistInMap(pPlayer, 1.5f) && !m_bIsIdle)
                {
                    m_bIsIdle = true;
                }
            }
            m_uiCheckTimer = 1000;
        }
        else
            m_uiCheckTimer -= uiDiff;

        // Return if pet is moving
        if (!m_bIsIdle)
        {
            m_bIsInAction = false;
            return;
        }

        // Do pet's action
        if (m_uiActionTimer < uiDiff)
        {
            // Do action
            if (!m_bIsInAction)
            {
                m_uiActionTimer = urand(30000, 60000); // Prevent stopping action too early
                m_bIsInAction = true;
                PetAction(me->GetEntry());
            }
            // Stop action
            else
            {
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                if (me->IsNonMeleeSpellCasted(false))
                    me->InterruptNonMeleeSpells(false);

                m_uiActionTimer = urand(10000, 30000);
                m_bIsInAction = false;
            }
        }
        else
            m_uiActionTimer -= uiDiff;

        CastNextSpellIfAnyAndReady();
    }

    void PetCreateAction(uint32 uiPetEntry)
    {
        if (!uiPetEntry)
            return;

        switch (uiPetEntry)
        {
            case NPC_DRAGON_KITE:
            {
                AddSpellToCast(me->GetOwner(), SPELL_DRAGON_KITE_STRING);
                break;
            }
            case NPC_WILLY:
            {
                AddSpellToCast(me,SPELL_WILLY_TRIGGER);
                break;
            }
            default:
                break;
        }
    }

    void PetAction(uint32 uiPetEntry)
    {
        if (!uiPetEntry)
            return;

        switch (uiPetEntry)
        {
            case NPC_PANDA:
            {
                AddSpellToCast(RAND(SPELL_PANDA_SLEEP, SPELL_PANDA_ROAR), CAST_SELF);
                break;
            }
            case NPC_DIABLO:
            {
                AddSpellToCast(SPELL_DIABLO_FLAME, CAST_SELF);
                break;
            }
            case NPC_ZERGLING:
            {
                AddSpellToCast(SPELL_ZERGLING, CAST_SELF);
                break;
            }
            case NPC_WILLY:
            {
                AddSpellToCast(SPELL_WILLY_SLEEP, CAST_SELF);
                break;
            }
            case NPC_DRAGON_KITE:
            {
                if (Unit* pOwner = me->GetCharmerOrOwner())
                    AddSpellToCast(pOwner, SPELL_DRAGON_KITE_LIGHTNING);
                break;
            }
            case NPC_MURKY:
            case NPC_LURKY:
            case NPC_GURKY:
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
                AddSpellToCast(SPELL_MURKY_DANCE);
                break;
            }
            case NPC_EGBERT:
            {
                AddSpellToCast(SPELL_EGBERT_HAPPYNESS, CAST_SELF);
                break;
            }
            case NPC_SCORCHLING:
            {
                AddSpellToCast(SPELL_SCORCHLING_BLAST, CAST_SELF);
                break;
            }
        }
    }
};

CreatureAI* GetAI_npc_small_pet_handler(Creature* pCreature)
{
    return new npc_small_pet_handlerAI(pCreature);
}

bool GossipHello_npc_combatstop(Player* player, Creature* _Creature) 
{ 
    player->ADD_GOSSIP_ITEM(0, "Clear in combat state.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1); 

    // Hey there, $N. How can I help you?
    player->SEND_GOSSIP_MENU(2, _Creature->GetGUID()); 
    return true; 
} 

bool GossipSelect_npc_combatstop(Player* player, Creature* _Creature, uint32 sender, uint32 action) 
{ 
    if (action == GOSSIP_ACTION_INFO_DEF + 1)
        player->CombatStop(true); 

    return true; 
}

struct npc_resurrectAI : public Scripted_NoMovementAI
{
    npc_resurrectAI(Creature* c) : Scripted_NoMovementAI(c) {}

    TimeTrackerSmall timer;

    void Reset() override
    {
        me->SetReactState(REACT_PASSIVE);
        timer.Reset(2000);
    }

    void MoveInLineOfSight(Unit *who) override {}
    void AttackStart(Unit* who) override {}
    void EnterCombat(Unit *who) override {}

    void UpdateAI(const uint32 uiDiff) override
    {
        timer.Update(uiDiff);
        if (timer.Passed())
        {
            std::list<Player*> players;
            Looking4group::AnyPlayerInObjectRangeCheck check(me, 15.0f, false);
            Looking4group::ObjectListSearcher<Player, Looking4group::AnyPlayerInObjectRangeCheck> searcher(players, check);
            Cell::VisitAllObjects(me, searcher, 15.0f);

            players.remove_if([this](Player* plr) -> bool { return me->IsHostileTo(plr); });

            while (!players.empty())
            {
                Player* player = players.front();

                players.pop_front();

                player->ResurrectPlayer(10.0f);
                player->CastSpell(player, SPELL_RESURRECTION_VISUAL, true);   // Resurrection visual
            }
            timer.Reset(2000);
        }
    }
};

CreatureAI* GetAI_npc_resurrect(Creature* pCreature)
{
    return new npc_resurrectAI(pCreature);
}

enum TargetDummySpells
{
    TARGET_DUMMY_PASSIVE = 4044,
    TARGET_DUMMY_SPAWN_EFFECT = 4507,

    ADVANCED_TARGET_DUMMY_PASSIVE = 4048,
    ADVANCED_TARGET_DUMMY_SPAWN_EFFECT = 4092,

    MASTER_TARGET_DUMMY_PASSIVE = 19809,
};

enum TargetDummyEntry
{
    TARGET_DUMMY = 2673,
    ADV_TARGET_DUMMY = 2674,
    MASTER_TARGET_DUMMY = 12426
};

struct npc_target_dummyAI : public Scripted_NoMovementAI
{
    npc_target_dummyAI(Creature* c) : Scripted_NoMovementAI(c) {}

    void Reset() override
    {
        me->SetReactState(REACT_PASSIVE);

        ClearCastQueue();

        TargetDummySpells spawneffect;
        TargetDummySpells passive;

        switch (me->GetEntry())
        {
            case TARGET_DUMMY:
            {
                spawneffect = TARGET_DUMMY_SPAWN_EFFECT;
                passive = TARGET_DUMMY_PASSIVE;
                break;
            }
            case ADV_TARGET_DUMMY:
            {
                spawneffect = ADVANCED_TARGET_DUMMY_SPAWN_EFFECT;
                passive = ADVANCED_TARGET_DUMMY_PASSIVE;
                break;
            }
            case MASTER_TARGET_DUMMY:
            {
                spawneffect = ADVANCED_TARGET_DUMMY_SPAWN_EFFECT;
                passive = MASTER_TARGET_DUMMY_PASSIVE;
                break;
            }
        }

        AddSpellToCast(passive, CAST_SELF);
        AddSpellToCast(spawneffect, CAST_SELF);
    }

    void AttackStart(Unit* who) override {}
    void EnterCombat(Unit *who) override {}
    void MoveInLineOfSight(Unit* who) override {}

    void UpdateAI(const uint32 diff) override
    {
        CastNextSpellIfAnyAndReady();
    }
};

CreatureAI* GetAI_npc_target_dummy(Creature* pCreature)
{
    return new npc_target_dummyAI(pCreature);
}

enum ExplosiveSheepExplosion
{
    EXPLOSIVE_SHEEP_EXPLOSION = 4050,
    HIGH_EXPLOSIVE_SHEEP_EXPLOSION = 44279,
};

enum ExplosiveSheepEntry
{
    EXPLOSIVE_SHEEP = 2675,
    HIGH_EXPLOSIVE_SHEEP = 24715
};

struct npc_explosive_sheepAI : public ScriptedAI
{
    npc_explosive_sheepAI(Creature* c) : ScriptedAI(c) {}

    TimeTrackerSmall explosionTimer;

    void JustRespawned() override
    {
        explosionTimer.Reset(10000);
    }

    void Reset() override
    {
        me->SetReactState(REACT_PASSIVE);

        ClearCastQueue();
    }

    void AttackStart(Unit* who) override {}
    void EnterCombat(Unit *who) override {}
    void MoveInLineOfSight(Unit* who) override {}

    void UpdateAI(const uint32 diff) override
    {
        explosionTimer.Update(diff);
        if (explosionTimer.Passed())
        {
            ForceSpellCast(me->GetEntry() == EXPLOSIVE_SHEEP ? EXPLOSIVE_SHEEP_EXPLOSION : HIGH_EXPLOSIVE_SHEEP_EXPLOSION, CAST_SELF, INTERRUPT_AND_CAST, true);
            me->ForcedDespawn();
            return;
        }

        if (me->getVictim() == nullptr)
        {
            if (Unit* target = me->SelectNearestTarget())
                ScriptedAI::AttackStart(target);
        }
        else
        {
            if (me->IsWithinDistInMap(me->getVictim(), 2.0f))
            {
                ForceSpellCast(me->GetEntry() == EXPLOSIVE_SHEEP ? EXPLOSIVE_SHEEP_EXPLOSION : HIGH_EXPLOSIVE_SHEEP_EXPLOSION, CAST_SELF, INTERRUPT_AND_CAST, true);
                me->ForcedDespawn();
                return;
            }
        }

        CastNextSpellIfAnyAndReady();
    }
};

CreatureAI* GetAI_npc_explosive_sheep(Creature* pCreature)
{
    return new npc_explosive_sheepAI(pCreature);
}

/*######
## Meridith the Mermaiden
######*/

#define GOSSIP_HELLO "Thank you for your help"
#define LOVE_SONG_QUEST_ID 8599
#define SIREN_SONG 25678

bool GossipHello_npc_meridith_the_mermaiden(Player *player, Creature *creature)
{
    if( player->GetQuestStatus(LOVE_SONG_QUEST_ID) == QUEST_STATUS_COMPLETE )
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_HELLO, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
    }
    player->PlayerTalkClass->SendGossipMenu(7916,creature->GetGUID());
    return true;
}

bool GossipSelect_npc_meridith_the_mermaiden(Player *player, Creature * creature, uint32 sender, uint32 action )
{
    if(action == GOSSIP_ACTION_INFO_DEF+1)
    {
        creature->Say("Farewell!", LANG_UNIVERSAL, 0);
        creature->CastSpell(player, SIREN_SONG, false);
        player->CLOSE_GOSSIP_MENU();
    }
    return true;
}

// npc_gnomish_flame_turret
#define SPELL_GNOMISH_FLAME_TURRET 43050

struct npc_gnomish_flame_turret : public Scripted_NoMovementAI
{
    npc_gnomish_flame_turret(Creature* c) : Scripted_NoMovementAI(c)
    {
        me->SetAggroRange(10.0f); // radius of spell
    }
    Timer CheckTimer;

    void Reset() 
    {
        SetAutocast(SPELL_GNOMISH_FLAME_TURRET, 1000);
        StartAutocast();
        me->SetReactState(REACT_AGGRESSIVE);
        CheckTimer.Reset(2000);
    }

    bool UpdateVictim()
    {
        if (ScriptedAI::UpdateVictim())
            return true;

        if (Unit* target = me->SelectNearestTarget(10.0f))
            AttackStart(target);

        return me->getVictim();
    }

    void UpdateAI(const uint32 diff)
    {
        CheckTimer.Update(diff);
        if (CheckTimer.Passed())
        {
            Unit* owner = me->GetOwner();
            if (!owner || !owner->IsInMap(me))
            {
                me->ForcedDespawn();
                return;
            }
            CheckTimer.Reset(2000);
        }

        if (!UpdateVictim())
            return;

        CastNextSpellIfAnyAndReady(diff);
    }
};

CreatureAI* GetAI_npc_gnomish_flame_turret(Creature *_Creature)
{
    return new npc_gnomish_flame_turret(_Creature);
}

/*######
 # dummy park control
 ######*/
#define DUMMY_PARK_ON "Start dummy park event"
#define DUMMY_PARK_OFF "Stop dummy park event"
#define DUMMY_PARK_OBJECTS 16
#define DUMMY_PARK_NPCS 8

float dummyparkstorage[3] = {-1899, 5607, -33};

float dummyparkobjectlocs[DUMMY_PARK_OBJECTS][3] = {
    {-1945.59, 5559.70, -12.428},
    {-1917.56, 5571.52, -12.428},
    {-1937.18, 5542.79, -12.428},
    {-1940.55, 5554.45, -12.427},
    {-1915.94, 5564.6, -12.427},
    {-1909.43, 5556.58, -12.428},
    {-1934.38, 5539.64, -12.428},
    {-1932.02, 5536.95, -12.427},
    {-1932.02, 5536.95, -11.184},
    {-1908.28, 5552.2, -12.426},
    {-1907.54, 5548.75, -12.428},
    {-1907.54, 5548.75, -11.185},
    {-1930.43, 5535.41, -12.428},
    {-1907.17, 5546.7, -12.426},
    {-1933.35, 5570.6, -12.427},
    {-1933.36, 5570.6, -12.427}
};

uint32 dummyparkobjects[DUMMY_PARK_OBJECTS][2] ={
    {13228578,184380},
    {13228592,184381},
    {13231451,173223},
    {13228737,173223},
    {13228733,173223},
    {13231535,173223},
    {13229544,187225},
    {13231413,183992},
    {13231420,186738},
    {13229522,187225},
    {13231299,183992},
    {13231325,186738},
    {13266292,173223},
    {13266474,173223},
    {13266692,183319},
    {13246219,180423}
};

float dummyparknpclocs[DUMMY_PARK_NPCS][3] ={
    {-1919.98, 5551.57, -12.426},
    {-1926.75, 5548.27, -12.426},
    {-1928.70, 5560.42, -12.428},
    {-1913.47, 5560.28, -12.428},
    {-1933.36, 5570.6, -12.427},
    {-1938.83, 5548.67, -12.427},
    {-1922.58, 5565.43, -12.427},
    {-1936.90, 5560.12, -12.427}
};

uint32 dummyparknpcs[DUMMY_PARK_NPCS][2] ={
    {29312,66700},
    {29337,66701},
    {29437,66702},
    {29461,66703},
    {133929,66704},
    {60062,66709},
    {126618,66712},
    {126714,66713}
};

bool GossipHello_npc_dummy_park(Player *player, Creature *creature)
{
    if (player->isGameMaster())
    {
        player->ADD_GOSSIP_ITEM(0, DUMMY_PARK_ON, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        player->ADD_GOSSIP_ITEM(0, DUMMY_PARK_OFF, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }
    return true;
}

bool GossipSelect_npc_dummy_park(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    if (player->isGameMaster())
    {
        if(action == GOSSIP_ACTION_INFO_DEF+1)
        {
            creature->Whisper("Preparing dummy park!",player->GetGUID());
            GameObject* gob;
            for (uint8 i = 0 ; i < DUMMY_PARK_OBJECTS ; i++)
            {
                gob = NULL;
                gob = player->GetMap()->GetGameObject(MAKE_NEW_GUID(dummyparkobjects[i][0], dummyparkobjects[i][1], HIGHGUID_GAMEOBJECT));
                if (gob)
                {
                    Map* map = gob->GetMap();
                    gob->Relocate(dummyparkobjectlocs[i][0], dummyparkobjectlocs[i][1], dummyparkobjectlocs[i][2], gob->GetOrientation());
                    gob->SetFloatValue(GAMEOBJECT_POS_X, dummyparkobjectlocs[i][0]);
                    gob->SetFloatValue(GAMEOBJECT_POS_Y, dummyparkobjectlocs[i][1]);
                    gob->SetFloatValue(GAMEOBJECT_POS_Z, dummyparkobjectlocs[i][2]);
                    gob->SaveToDB();
                    gob->Refresh();
                }
            }
            Creature* mCreature;
            for (uint8 i = 0 ; i < DUMMY_PARK_NPCS ; i++)
            {

                mCreature = NULL;
                mCreature = player->GetMap()->GetCreature(MAKE_NEW_GUID(dummyparknpcs[i][0],dummyparknpcs[i][1],HIGHGUID_UNIT));
                if (mCreature)
                {
                    Map* map = mCreature->GetMap();
                    mCreature->SetHomePosition(dummyparknpclocs[i][0], dummyparknpclocs[i][1], dummyparknpclocs[i][2], mCreature->GetOrientation());
                    map->CreatureRelocation(mCreature,dummyparknpclocs[i][0], dummyparknpclocs[i][1], dummyparknpclocs[i][2], mCreature->GetOrientation());
                }
                GameDataDatabase.PExecuteLog("UPDATE creature SET position_x = '%f', position_y = '%f', position_z = '%f' WHERE guid = '%u'",
                    dummyparknpclocs[i][0], dummyparknpclocs[i][1], dummyparknpclocs[i][2], dummyparknpcs[i][0]);
            }
        }
        else if(action == GOSSIP_ACTION_INFO_DEF+2)
        {
            creature->Whisper("Removing dummy park!",player->GetGUID());
            GameObject* gob;
            for (uint8 i = 0 ; i < DUMMY_PARK_OBJECTS ; i++)
            {
                gob = NULL;
                gob = player->GetMap()->GetGameObject(MAKE_NEW_GUID(dummyparkobjects[i][0], dummyparkobjects[i][1], HIGHGUID_GAMEOBJECT));
                if (gob)
                {
                    Map* map = gob->GetMap();
                    gob->Relocate(dummyparkstorage[0], dummyparkstorage[1], dummyparkstorage[2], gob->GetOrientation());
                    gob->SetFloatValue(GAMEOBJECT_POS_X, dummyparkstorage[0]);
                    gob->SetFloatValue(GAMEOBJECT_POS_Y, dummyparkstorage[1]);
                    gob->SetFloatValue(GAMEOBJECT_POS_Z, dummyparkstorage[2]);
                    gob->SaveToDB();
                    gob->Refresh();
                }
            }
            Creature* mCreature;
            for (uint8 i = 0 ; i < DUMMY_PARK_NPCS ; i++)
            {
                mCreature = NULL;
                mCreature = player->GetMap()->GetCreature(MAKE_NEW_GUID(dummyparknpcs[i][0],dummyparknpcs[i][1],HIGHGUID_UNIT));
                if (mCreature)
                {
                    Map* map = mCreature->GetMap();
                    mCreature->SetHomePosition(dummyparknpclocs[i][0], dummyparknpclocs[i][1], dummyparknpclocs[i][2], mCreature->GetOrientation());
                    map->CreatureRelocation(mCreature,dummyparkstorage[0], dummyparkstorage[1], dummyparkstorage[2], mCreature->GetOrientation());
                }
                GameDataDatabase.PExecuteLog("UPDATE creature SET position_x = '%f', position_y = '%f', position_z = '%f' WHERE guid = '%u'",
                    dummyparkstorage[0], dummyparkstorage[1], dummyparkstorage[2], dummyparknpcs[i][0]);
            }
        }
    }
    return true;
}

struct npc_nearly_dead_combat_dummyAI : public Scripted_NoMovementAI
{
    npc_nearly_dead_combat_dummyAI(Creature *c) : Scripted_NoMovementAI(c)
    {
    }

    uint64 AttackerGUID;
    uint32 Check_Timer;

    void Reset()
    {
        m_creature->SetHealth(m_creature->GetMaxHealth()/11);
        m_creature->SetNoCallAssistance(true);
        m_creature->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STUN, true);
        AttackerGUID = 0;
        Check_Timer = 0;
    }

    void EnterCombat(Unit* who)
    {
        AttackerGUID = ((Player*)who)->GetGUID();
        m_creature->GetUnitStateMgr().PushAction(UNIT_ACTION_STUN, UNIT_ACTION_PRIORITY_END);
    }

    void DamageTaken(Unit *attacker, uint32 &damage)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        Player* attacker = Player::GetPlayer(AttackerGUID);

        if (!UpdateVictim())
            return;

        if (attacker && Check_Timer < diff)
        {
            if(m_creature->GetDistance2d(attacker) > 12.0f)
                EnterEvadeMode();

            Check_Timer = 3000;
        }
        else
            Check_Timer -= diff;
    }
};

CreatureAI* GetAI_npc_nearly_dead_combat_dummy(Creature *_Creature)
{
    return new npc_nearly_dead_combat_dummyAI(_Creature);
}


struct npc_fel_cannon_master : public Scripted_NoMovementAI
{
    npc_fel_cannon_master(Creature* c) : Scripted_NoMovementAI(c)
    {
        me->SetAggroRange(25.0f); // radius of spell
    }
    uint32 CheckTimer;

    void Reset() 
    {
        CheckTimer = 3000;
    }

    bool UpdateVictim()
    {
        if (ScriptedAI::UpdateVictim())
            return true;

        if (Unit* target = me->SelectNearestTarget(25.0f))
            AttackStart(target);

        return me->getVictim();
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CheckTimer < diff)
        {
            me->CastSpell(me->getVictim(), 36238, false);
            CheckTimer = 3000;
        }
        else
            CheckTimer -= diff;
    }
};

CreatureAI* GetAI_npc_fel_cannon_master(Creature *_Creature)
{
    return new npc_fel_cannon_master(_Creature);
}

void AddSC_npcs_special()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_garments_of_quests";
    newscript->GetAI = &GetAI_npc_garments_of_quests;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_chicken_cluck";
    newscript->GetAI = &GetAI_npc_chicken_cluck;
    newscript->pReceiveEmote =  &ReceiveEmote_npc_chicken_cluck;
    newscript->pGossipHello =  &GossipHello_npc_chicken_cluck;
    newscript->pQuestAcceptNPC =   &QuestAccept_npc_chicken_cluck;
    newscript->pQuestRewardedNPC = &QuestComplete_npc_chicken_cluck;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_dancing_flames";
    newscript->GetAI = &GetAI_npc_dancing_flames;
    newscript->pReceiveEmote =  &ReceiveEmote_npc_dancing_flames;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_injured_patient";
    newscript->GetAI = &GetAI_npc_injured_patient;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_doctor";
    newscript->GetAI = &GetAI_npc_doctor;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_doctor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_guardian";
    newscript->GetAI = &GetAI_npc_guardian;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_mount_vendor";
    newscript->pGossipHello =  &GossipHello_npc_mount_vendor;
    newscript->pGossipSelect = &GossipSelect_npc_mount_vendor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_rogue_trainer";
    newscript->pGossipHello =  &GossipHello_npc_rogue_trainer;
    newscript->pGossipSelect = &GossipSelect_npc_rogue_trainer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_sayge";
    newscript->pGossipHello = &GossipHello_npc_sayge;
    newscript->pGossipSelect = &GossipSelect_npc_sayge;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_tonk_mine";
    newscript->GetAI = &GetAI_npc_tonk_mine;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_winter_reveler";
    newscript->pReceiveEmote =  &ReceiveEmote_npc_winter_reveler;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_brewfest_reveler";
    newscript->pReceiveEmote =  &ReceiveEmote_npc_brewfest_reveler;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_snake_trap_serpents";
    newscript->GetAI = &GetAI_npc_snake_trap_serpents;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_flight_master";
    newscript->GetAI = &GetAI_npc_flight_master;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_mojo";
    newscript->GetAI = &GetAI_npc_mojo;
    newscript->pReceiveEmote =  &ReceiveEmote_npc_mojo;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_woeful_healer";
    newscript->GetAI = &GetAI_npc_woeful_healer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_ring_specialist";
    newscript->pGossipHello = &GossipHello_npc_ring_specialist;
    newscript->pGossipSelect = &GossipSelect_npc_ring_specialist;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_fire_elemental_guardian";
    newscript->GetAI = &GetAI_npc_fire_elemental_guardian;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_earth_elemental_guardian";
    newscript->GetAI = &GetAI_npc_earth_elemental_guardian;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_master_omarion";
    newscript->pGossipHello =  &GossipHello_npc_master_omarion;
    newscript->pGossipSelect = &GossipSelect_npc_master_omarion;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_lorekeeper_lydros";
    newscript->pGossipHello =  &GossipHello_npc_lorekeeper_lydros;
    newscript->pGossipSelect = &GossipSelect_npc_lorekeeper_lydros;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_crashin_trashin_robot";
    newscript->GetAI = &GetAI_npc_crashin_trashin_robot;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "pet_AleMugDrinker";
    newscript->GetAI = GetAI_pet_AleMugDrinker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "trigger_apple";
    newscript->GetAI = GetAI_trigger_apple;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "trigger_delivery";
    newscript->GetAI = GetAI_trigger_delivery;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "trigger_delivery_daily";
    newscript->pGossipHello = &GossipHello_npc_delivery_daily;
    newscript->pGossipSelect = &GossipSelect_npc_delivery_daily;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "trigger_delivery_keg";
    newscript->GetAI = GetAI_trigger_delivery_keg;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "trigger_barker";
    newscript->GetAI = GetAI_trigger_barker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_arena_spectator";
    newscript->pGossipHello =           &GossipHello_npc_arena_spectator;
    newscript->pGossipSelectWithCode =  &GossipSelectWithCode_npc_arena_spectator;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_land_mine";
    newscript->GetAI = &GetAI_npc_land_mine;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_small_pet_handler";
    newscript->GetAI = &GetAI_npc_small_pet_handler;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_combatstop";
    newscript->pGossipHello =  &GossipHello_npc_combatstop;
    newscript->pGossipSelect = &GossipSelect_npc_combatstop;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_resurrect";
    newscript->GetAI = &GetAI_npc_resurrect;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_target_dummy";
    newscript->GetAI = &GetAI_npc_target_dummy;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_explosive_sheep";
    newscript->GetAI = &GetAI_npc_explosive_sheep;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_meridith_the_mermaiden";
    newscript->pGossipHello = &GossipHello_npc_meridith_the_mermaiden;
    newscript->pGossipSelect = &GossipSelect_npc_meridith_the_mermaiden;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_gnomish_flame_turret";
    newscript->GetAI = &GetAI_npc_gnomish_flame_turret;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name="npc_dummy_park_controller";
    newscript->pGossipHello =  &GossipHello_npc_dummy_park;
    newscript->pGossipSelect = &GossipSelect_npc_dummy_park;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_nearly_dead_combat_dummy";
    newscript->GetAI = &GetAI_npc_nearly_dead_combat_dummy;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_fel_cannon_master";
    newscript->GetAI = &GetAI_npc_fel_cannon_master;
    newscript->RegisterSelf();
}
