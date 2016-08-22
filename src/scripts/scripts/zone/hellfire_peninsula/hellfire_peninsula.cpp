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
SDName: Hellfire_Peninsula
SD%Complete: 99
 SDComment: Quest support: 9375, 9410, 9418, 10129, 10146, 10162, 10163, 10340, 10346, 10347, 10382 (Special flight paths), 11516, 10909, 10935, 9545, 10351, 10838, 9472, 9483, 10629
SDCategory: Hellfire Peninsula
EndScriptData */

/* ContentData
npc_aeranas
go_haaleshi_altar
npc_wing_commander_dabiree
npc_gryphoneer_windbellow
npc_wing_commander_brack
npc_wounded_blood_elf
npc_demoniac_scryer
npc_magic_sucker_device_spawner
npc_ancestral_spirit_wolf & npc_earthcaller_ryga
npc_living_flare
npc_felblood_initiate & npc_emaciated_felblood
Ice Stone
npc_hand_berserker
npc_anchorite_relic_bunny
npc_anchorite_barada
npc_darkness_released
npc_foul_purge
npc_sedai_quest_credit_marker
npc_vindicator_sedai
npc_pathaleon_image
npc_viera
npc_deranged_helboar
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"
#include "follower_ai.h"

/*######
## npc_aeranas
######*/

#define SAY_SUMMON                      -1000138
#define SAY_FREE                        -1000139

#define FACTION_HOSTILE                 16
#define FACTION_FRIENDLY                35

#define SPELL_ENVELOPING_WINDS          15535
#define SPELL_SHOCK                     12553

#define C_AERANAS                       17085

struct npc_aeranasAI : public ScriptedAI
{
    npc_aeranasAI(Creature* creature) : ScriptedAI(creature) {}

    uint32 Faction_Timer;
    uint32 EnvelopingWinds_Timer;
    uint32 Shock_Timer;

    void Reset()
    {
        Faction_Timer = 8000;
        EnvelopingWinds_Timer = 9000;
        Shock_Timer = 5000;

        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
        me->setFaction(FACTION_FRIENDLY);

        DoScriptText(SAY_SUMMON, me);
    }

    void EnterCombat(Unit *who) {}

    void UpdateAI(const uint32 diff)
    {
        if (Faction_Timer)
        {
            if (Faction_Timer <= diff)
            {
                me->setFaction(FACTION_HOSTILE);
                Faction_Timer = 0;
            }else Faction_Timer -= diff;
        }

        if (!UpdateVictim())
            return;

        if ((me->GetHealth()*100) / me->GetMaxHealth() < 30)
        {
            me->setFaction(FACTION_FRIENDLY);
            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
            me->RemoveAllAuras();
            me->DeleteThreatList();
            me->CombatStop();
            DoScriptText(SAY_FREE, me);
            return;
        }

        if (Shock_Timer <= diff)
        {
            DoCast(me->getVictim(),SPELL_SHOCK);
            Shock_Timer = 10000;
        }else Shock_Timer -= diff;

        if (EnvelopingWinds_Timer <= diff)
        {
            DoCast(me->getVictim(),SPELL_ENVELOPING_WINDS);
            EnvelopingWinds_Timer = 25000;
        }else EnvelopingWinds_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_aeranas(Creature *creature)
{
    return new npc_aeranasAI (creature);
}

/*######
## go_haaleshi_altar
######*/

bool GOUse_go_haaleshi_altar(Player *player, GameObject* go)
{
    go->SummonCreature(C_AERANAS,-1321.79, 4043.80, 116.24, 1.25, TEMPSUMMON_TIMED_DESPAWN, 180000);
    return false;
}

/*######
## npc_wing_commander_dabiree
######*/

#define GOSSIP_ITEM1_DAB "Fly me to Murketh and Shaadraz Gateways"
#define GOSSIP_ITEM2_DAB "Fly me to Shatter Point"

bool GossipHello_npc_wing_commander_dabiree(Player *player, Creature *creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu( creature->GetGUID() );

    //Mission: The Murketh and Shaadraz Gateways
    if (player->GetQuestStatus(10146) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(2, GOSSIP_ITEM1_DAB, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

    //Shatter Point
    if (!player->GetQuestRewardStatus(10340))
        player->ADD_GOSSIP_ITEM(2, GOSSIP_ITEM2_DAB, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

    player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());

    return true;
}

bool GossipSelect_npc_wing_commander_dabiree(Player *player, Creature *creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF + 1)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,33768,true);               //TaxiPath 585 (Gateways Murket and Shaadraz)
    }
    if (action == GOSSIP_ACTION_INFO_DEF + 2)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,35069,true);               //TaxiPath 612 (Taxi - Hellfire Peninsula - Expedition Point to Shatter Point)
    }
    return true;
}

/*######
## npc_gryphoneer_windbellow
######*/

#define GOSSIP_ITEM1_WIN "Fly me to The Abyssal Shelf"
#define GOSSIP_ITEM2_WIN "Fly me to Honor Point"

bool GossipHello_npc_gryphoneer_windbellow(Player *player, Creature *creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu( creature->GetGUID() );

    //Mission: The Abyssal Shelf || Return to the Abyssal Shelf
    if (player->GetQuestStatus(10163) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(10346) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(2, GOSSIP_ITEM1_WIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

    //Go to the Front
    if (player->GetQuestStatus(10382) != QUEST_STATUS_NONE && !player->GetQuestRewardStatus(10382))
        player->ADD_GOSSIP_ITEM(2, GOSSIP_ITEM2_WIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

    player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());

    return true;
}

bool GossipSelect_npc_gryphoneer_windbellow(Player *player, Creature *creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF + 1)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,33899,true);               //TaxiPath 589 (Aerial Assault Flight (Alliance))
    }
    if (action == GOSSIP_ACTION_INFO_DEF + 2)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,35065,true);               //TaxiPath 607 (Taxi - Hellfire Peninsula - Shatter Point to Beach Head)
    }
    return true;
}

/*######
## npc_wing_commander_brack
######*/

#define GOSSIP_ITEM1_BRA "Fly me to Murketh and Shaadraz Gateways"
#define GOSSIP_ITEM2_BRA "Fly me to The Abyssal Shelf"
#define GOSSIP_ITEM3_BRA "Fly me to Spinebreaker Post"

bool GossipHello_npc_wing_commander_brack(Player *player, Creature *creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu( creature->GetGUID() );

    //Mission: The Murketh and Shaadraz Gateways
    if (player->GetQuestStatus(10129) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(2, GOSSIP_ITEM1_BRA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

    //Mission: The Abyssal Shelf || Return to the Abyssal Shelf
    if (player->GetQuestStatus(10162) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(10347) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(2, GOSSIP_ITEM2_BRA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

    //Spinebreaker Post
    if (player->GetQuestStatus(10242) == QUEST_STATUS_COMPLETE && !player->GetQuestRewardStatus(10242))
        player->ADD_GOSSIP_ITEM(2, GOSSIP_ITEM3_BRA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

    player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());

    return true;
}

bool GossipSelect_npc_wing_commander_brack(Player *player, Creature *creature, uint32 sender, uint32 action )
{
    switch(action)
    {
    case GOSSIP_ACTION_INFO_DEF + 1:
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,33659,true);               //TaxiPath 584 (Gateways Murket and Shaadraz)
        break;
    case GOSSIP_ACTION_INFO_DEF + 2:
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,33825,true);               //TaxiPath 587 (Aerial Assault Flight (Horde))
        break;
    case GOSSIP_ACTION_INFO_DEF + 3:
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,34578,true);               //TaxiPath 604 (Taxi - Reaver's Fall to Spinebreaker Ridge)
        break;
    }
        return true;
}

/*######
## npc_wounded_blood_elf
######*/

#define SAY_ELF_START               -1000117
#define SAY_ELF_SUMMON1             -1000118
#define SAY_ELF_RESTING             -1000119
#define SAY_ELF_SUMMON2             -1000120
#define SAY_ELF_COMPLETE            -1000121
#define SAY_ELF_AGGRO               -1000122

#define QUEST_ROAD_TO_FALCON_WATCH  9375

struct npc_wounded_blood_elfAI : public npc_escortAI
{
    npc_wounded_blood_elfAI(Creature *creature) : npc_escortAI(creature) {}

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();
        if (!player)
            return;

        switch (i)
        {
        case 0:
            DoScriptText(SAY_ELF_START, me, player);
            break;
        case 9:
            DoScriptText(SAY_ELF_SUMMON1, me, player);
            // Spawn two Haal'eshi Talonguard
            DoSpawnCreature(16967, -15, -15, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
            DoSpawnCreature(16967, -17, -17, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
            break;
        case 13:
            DoScriptText(SAY_ELF_RESTING, me, player);
            // make the NPC kneel
            me->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
            break;
        case 14:
            DoScriptText(SAY_ELF_SUMMON2, me, player);
            // Spawn two Haal'eshi Windwalker
            DoSpawnCreature(16966, -15, -15, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
            DoSpawnCreature(16966, -17, -17, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
            break;
        case 27:
            DoScriptText(SAY_ELF_COMPLETE, me, player);
            // Award quest credit
            player->GroupEventHappens(QUEST_ROAD_TO_FALCON_WATCH,me);
            break;
        }
    }

    void Reset() { }

    void EnterCombat(Unit* who)
    {
        if (HasEscortState(STATE_ESCORT_ESCORTING))
            DoScriptText(SAY_ELF_AGGRO, me);
    }

    void JustSummoned(Creature* summoned)
    {
        summoned->AI()->AttackStart(me);
    }
};

CreatureAI* GetAI_npc_wounded_blood_elf(Creature* creature)
{
    return new npc_wounded_blood_elfAI(creature);
}

bool QuestAccept_npc_wounded_blood_elf(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_ROAD_TO_FALCON_WATCH)
    {
        if (npc_escortAI* pEscortAI = CAST_AI(npc_wounded_blood_elfAI, creature->AI()))
            pEscortAI->Start(true, false, player->GetGUID());

        // Change faction so mobs attack
        creature->setFaction(775);
    }

    return true;
}


/*######
## npc_demoniac_scryer
######*/

#define GOSSIP_ITEM_ATTUNE    "Yes, Scryer. You may possess me."
#define FINISHED_WHISPER    "Thank you for allowing me to visit, $N. You have a very colorful soul, but it's a little brighter than I prefer... or I might have stayed longer!"

enum
{
    GOSSIP_TEXTID_PROTECT           = 10659,
    GOSSIP_TEXTID_ATTUNED           = 10643,

    QUEST_DEMONIAC                  = 10838,
    NPC_HELLFIRE_WARDLING           = 22259,
    NPC_ORC_HA                      = 22273,
    NPC_BUTTRESS                    = 22267,
    NPC_BUTTRESS_SPAWNER            = 22260,

    MAX_BUTTRESS                    = 4,
    TIME_TOTAL                      = MINUTE*10*IN_MILISECONDS,

    SPELL_SUMMONED                  = 7741,
    SPELL_DEMONIAC_VISITATION       = 38708,
    SPELL_BUTTRESS_APPERANCE        = 38719,
    SPELL_SUCKER_CHANNEL            = 38721,
    SPELL_SUCKER_DESPAWN_MOB        = 38691,
};

struct npc_demoniac_scryerAI : public ScriptedAI
{
    npc_demoniac_scryerAI(Creature* creature) : ScriptedAI(creature) {}

    bool IfIsComplete;

    uint32 SpawnDemonTimer;
    uint32 SpawnOrcTimer;
    uint32 SpawnButtressTimer;
    uint32 EndTimer;
    uint32 ButtressCount;
    std::list<uint64> PlayersWithQuestList;

    void Reset()
    {
        IfIsComplete = false;
        SpawnDemonTimer = 15000;
        SpawnOrcTimer = 30000;
        SpawnButtressTimer = 45000;
        EndTimer = 262000;
        ButtressCount = 0;
        PlayersWithQuestList.clear();

        std::list<Unit*> PlayerList;
        uint32 questDist = 60;                      // sWorld.getConfig(CONFIG_GROUP_XP_DISTANCE);
        Looking4group::AnyUnitInObjectRangeCheck  check(me, questDist);
        Looking4group::UnitListSearcher<Looking4group::AnyUnitInObjectRangeCheck > searcher(PlayerList, check);
        Cell::VisitAllObjects(me, searcher, questDist);

        for(std::list<Unit*>::iterator i = PlayerList.begin(); i != PlayerList.end(); i++)
        {
            if((*i)->GetTypeId() != TYPEID_PLAYER)
                continue;
            Player *player = (Player*)(*i);
            if(player->GetQuestStatus(QUEST_DEMONIAC) == QUEST_STATUS_INCOMPLETE)
                PlayersWithQuestList.push_back(player->GetGUID());
        }
    }

    void AttackedBy(Unit* pEnemy) {}
    void AttackStart(Unit* pEnemy) {}
 
    void DoSpawnButtress()
    {
        ++ButtressCount;

        float fAngle = 0.0f;

        switch(ButtressCount)
        {
            case 1: fAngle = 0.0f; break;
            case 2: fAngle = 4.6f; break;
            case 3: fAngle = 1.5f; break;
            case 4: fAngle = 3.1f; break;
        }

        float fX, fY, fZ;
        me->GetNearPoint(fX, fY, fZ, 0.0f, 5.0f, fAngle);

        uint32 m_Time = TIME_TOTAL - (SpawnButtressTimer * ButtressCount);
        me->SummonCreature(NPC_BUTTRESS, fX, fY, fZ, me->GetAngle(fX, fY), TEMPSUMMON_TIMED_DESPAWN, m_Time);
        me->SummonCreature(NPC_BUTTRESS_SPAWNER, fX, fY, fZ, me->GetAngle(fX, fY), TEMPSUMMON_TIMED_DESPAWN, m_Time);
    }

    void DoSpawnDemon()
    {
        float fX, fY, fZ;
        me->GetRandomPoint(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 20.0f, fX, fY, fZ);
        me->SummonCreature(NPC_HELLFIRE_WARDLING, fX, fY, fZ, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
    }

    void DospawnOrc()
    {
        float fX, fY, fZ;
        me->GetRandomPoint(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 20.0f, fX, fY, fZ);
        me->SummonCreature(NPC_ORC_HA, fX, fY, fZ, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
    }

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == NPC_HELLFIRE_WARDLING)
        {
            summoned->CastSpell(summoned, SPELL_SUMMONED, false);
            summoned->AI()->AttackStart(me);
        }
        if (summoned->GetEntry() == NPC_ORC_HA)
        {
            summoned->CastSpell(summoned, SPELL_SUMMONED, false);
            summoned->AI()->AttackStart(me);
        }
        if (summoned->GetEntry() == NPC_BUTTRESS)
        {
            summoned->CastSpell(summoned, SPELL_BUTTRESS_APPERANCE, false);
        }
        else
        {
            if (summoned->GetEntry() == NPC_BUTTRESS_SPAWNER)
            {
                summoned->CastSpell(me, SPELL_SUCKER_CHANNEL, true);
            }
        }
    }

    void SpellHitTarget(Unit* target, const SpellEntry* spell)
    {
        if (target->GetEntry() == NPC_BUTTRESS && spell->Id == SPELL_SUCKER_DESPAWN_MOB)
            ((Creature*)target)->setDeathState(CORPSE);
        if (target->GetEntry() == NPC_BUTTRESS_SPAWNER && spell->Id == SPELL_SUCKER_DESPAWN_MOB)
            ((Creature*)target)->setDeathState(CORPSE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (EndTimer <= diff)
        {
            me->setDeathState(CORPSE);
            EndTimer = 262000;
        }
        else EndTimer -= diff;

        if (IfIsComplete)
            return;

        if (SpawnButtressTimer <= diff)
        {
            if (ButtressCount >= MAX_BUTTRESS)
            {
                DoCast(me, SPELL_SUCKER_DESPAWN_MOB);
                for(std::list<uint64>::iterator i = PlayersWithQuestList.begin(); i != PlayersWithQuestList.end(); i++)
                {
                    if(Unit* player = Unit::GetUnit(*me, (*i)))
                    {      
                        me->Whisper(FINISHED_WHISPER, (*i));
                        //me->CastSpell(player, 38708, true);
                    }
                }
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                IfIsComplete = true;
                return;
            }
            SpawnButtressTimer = 45000;
            DoSpawnButtress();
        }
        else SpawnButtressTimer -= diff;

        if (SpawnDemonTimer <= diff)
        {
            DoSpawnDemon();
            SpawnDemonTimer = 15000;
        }
        else SpawnDemonTimer -= diff;

        if (SpawnOrcTimer <= diff)
        {
            DospawnOrc();
            SpawnOrcTimer = 30000;
        }
        else SpawnOrcTimer -= diff;
    }
};

CreatureAI* GetAI_npc_demoniac_scryer(Creature* creature)
{
    return new npc_demoniac_scryerAI(creature);
}

bool GossipHello_npc_demoniac_scryer(Player* player, Creature* creature)
{
    if (npc_demoniac_scryerAI* pScryerAI = dynamic_cast<npc_demoniac_scryerAI*>(creature->AI()))
    {
        if (pScryerAI->IfIsComplete)
        {
            if (player->GetQuestStatus(QUEST_DEMONIAC) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ATTUNE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ATTUNED, creature->GetObjectGuid());
            return true;
        }
    }
    player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_PROTECT, creature->GetObjectGuid());
    return true;
}

bool GossipSelect_npc_demoniac_scryer(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF + 1)
    {
        player->CLOSE_GOSSIP_MENU();
        creature->CastSpell(player, SPELL_DEMONIAC_VISITATION, false);
    }
    return true;
}

/*######
## npc_magic_sucker_device_spawner
######*/

enum
{
    SPELL_EFFECT    = 38724,
    NPC_SCRYER      = 22258,
    NPC_BUTTRES     = 22267
};

struct npc_magic_sucker_device_spawnerAI : public ScriptedAI
{
    npc_magic_sucker_device_spawnerAI(Creature* creature) : ScriptedAI(creature) {}

    uint32 CastTimer;
    uint32 CheckTimer;

    void Reset()
    {
        CastTimer = 1800;
        CheckTimer = 5000;
    }

    void UpdateAI(const uint32 diff)
    {
        if (CastTimer <= diff)
        {
            DoCast(me, SPELL_EFFECT);
            CastTimer = 1800;
        }
        else CastTimer -= diff;

        if (CheckTimer <= diff)
        {
            if (Creature* pScr = GetClosestCreatureWithEntry(me, NPC_SCRYER, 15.0f, false))
            {
                if (Creature* pBut = GetClosestCreatureWithEntry(me, NPC_BUTTRES, 5.0f))
                {
                    pBut->setDeathState(CORPSE);
                    me->setDeathState(CORPSE);
                }
            }

            CheckTimer = 5000;
        }
        else CheckTimer -= diff;
    }
};
CreatureAI* GetAI_npc_magic_sucker_device_spawner(Creature* creature)
{
    return new npc_magic_sucker_device_spawnerAI(creature);
}

/*######
## npc_ancestral_spirit_wolf & npc_earthcaller_ryga
######*/

enum AncestralSpiritWolf
{
    EMOTE_HEAD_UP                           = -1811000,
    EMOTE_HOWL                              = -1811001,
    EMOTE_RYGA                              = -1811002,
    SPELL_ANCESTRAL_SPIRIT_WOLF_BUFF_TIMER  = 29981,
};

struct npc_earthcaller_rygaAI : public npc_escortAI
{
    npc_earthcaller_rygaAI(Creature *creature) : npc_escortAI(creature) {}

    void Reset() { }

    void WaypointReached(uint32 i)
    {
        switch (i)
        {
            case 1:
                DoScriptText(EMOTE_RYGA, me);
                break;
        }
    }
};

CreatureAI* GetAI_npc_earthcaller_ryga(Creature *creature)
{
    CreatureAI* newAI = new npc_earthcaller_rygaAI(creature);
    return newAI;
}

struct npc_ancestral_spirit_wolfAI : public npc_escortAI
{
    npc_ancestral_spirit_wolfAI(Creature *creature) : npc_escortAI(creature) {}

    void Reset()
    {
        if(!me->HasAura(SPELL_ANCESTRAL_SPIRIT_WOLF_BUFF_TIMER, 0))
            me->AddAura(SPELL_ANCESTRAL_SPIRIT_WOLF_BUFF_TIMER, me);
        me->setFaction(7);
        if(Unit* owner = me->GetOwner())
        {
            if(owner->GetTypeId() == TYPEID_PLAYER)
            {
                Start(false, false, owner->GetGUID());
                SetMaxPlayerDistance(40.0f);
            }
        }
    }

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();
        if (!player)
            return;

        switch (i)
        {
            case 2:
                DoScriptText(EMOTE_HEAD_UP, me);
                break;
            case 6:
                SetRun();
                me->SetSpeed(MOVE_RUN, 0.75);
                DoScriptText(EMOTE_HOWL, me);
                break;
            case 36:
                if(Unit* Ryga = FindCreature(17123, 50, me))
                {
                    if (npc_escortAI* pEscortAI = CAST_AI(npc_earthcaller_rygaAI, ((Creature*)Ryga)->AI()))
                        pEscortAI->Start(false, false, 0, 0, true);
                }
                break;
        }
    }

    void EnterCombat(Unit* who) { return; }
};

CreatureAI* GetAI_npc_ancestral_spirit_wolf(Creature *creature)
{
    CreatureAI* newAI = new npc_ancestral_spirit_wolfAI(creature);
    return newAI;
}

/*######
## npc_living_flare
######*/

enum LivingFlare
{
    NPC_LIVING_FLARE                        = 24916,
    NPC_UNSTABLE_LIVING_FLARE               = 24958,
    NPC_GENERIC_TRIGGER                     = 24959,

    OBJECT_LARGE_FIRE                       = 187084,
    UNSTABLE_LIVING_FLARE_EXPLODE_EMOTE     = -1811010,

    SPELL_FEL_FLAREUP                       = 44944,
    SPELL_LIVING_FLARE_COSMETIC             = 44880,
    SPELL_LIVING_FLARE_MASTER               = 44877,
    SPELL_UNSTABLE_LIVING_FLARE_COSMETIC    = 46196,
    SPELL_LIVING_FLARE_TO_UNSTABLE          = 44943,

    QUEST_BLAST_THE_GATEWAY                 = 11516
};

float FirePos[3][3] = 
{
    {840.9, 2521.0, 293.4},
    {836.5, 2508.0, 292.0},
    {826.5, 2513.4, 291.7}
};

struct npc_living_flareAI : public FollowerAI
{
    npc_living_flareAI(Creature *creature) : FollowerAI(creature) {}

    void Reset()
    {
        if(Unit* owner = me->GetOwner())
        {
            if(owner->GetTypeId() == TYPEID_PLAYER)
                StartFollow(((Player*)owner));
        }
        if(me->GetEntry() == NPC_UNSTABLE_LIVING_FLARE)
            return;

        if(!me->HasAura(SPELL_LIVING_FLARE_COSMETIC, 0))
            me->AddAura(SPELL_LIVING_FLARE_COSMETIC, me);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if(who->GetEntry() == NPC_GENERIC_TRIGGER && me->IsWithinDistInMap(who, 10.0f, true))
            Detonate();
    }

    void Detonate()
    {
        if(Unit* owner = me->GetOwner())
        {
            for(uint8 i=0;i<3;++i)
                owner->SummonGameObject(OBJECT_LARGE_FIRE, FirePos[i][0], FirePos[i][1], FirePos[i][2], owner->GetOrientation(), 0, 0, 0, 0, 30);
            if(owner->GetTypeId() == TYPEID_PLAYER)
                if(((Player*)owner)->GetQuestStatus(QUEST_BLAST_THE_GATEWAY) == QUEST_STATUS_INCOMPLETE)
                    ((Player*)owner)->AreaExploredOrEventHappens(QUEST_BLAST_THE_GATEWAY);
        }
        DoCast(me, SPELL_LIVING_FLARE_TO_UNSTABLE);
        DoScriptText(UNSTABLE_LIVING_FLARE_EXPLODE_EMOTE, me);
        me->SetVisibility(VISIBILITY_OFF);
        me->setDeathState(JUST_DIED);
        me->RemoveCorpse();
    }

    void MorphToUnstable()
    {
        if(me->GetEntry() != NPC_UNSTABLE_LIVING_FLARE)
        {
            DoCast(me, SPELL_FEL_FLAREUP);
            me->UpdateEntry(NPC_UNSTABLE_LIVING_FLARE);
        }
        else
            return;
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        if(Unit* owner = me->GetOwner())
            me->setFaction(owner->getFaction());
        if(me->HasAura(SPELL_LIVING_FLARE_COSMETIC, 0))
            me->RemoveAurasDueToSpell(SPELL_LIVING_FLARE_COSMETIC);
        DoCast(me, SPELL_LIVING_FLARE_TO_UNSTABLE);
        DoCast(me, SPELL_UNSTABLE_LIVING_FLARE_COSMETIC);
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(spell->Id == SPELL_LIVING_FLARE_MASTER)
        {
            uint32 stack = 0;
            if(me->HasAura(SPELL_FEL_FLAREUP, 0))
            {
                if(Aura* Flare = me->GetAura(SPELL_FEL_FLAREUP, 0))
                    stack = Flare->GetStackAmount();
            }
            if(stack < 7)
                DoCast(me, SPELL_FEL_FLAREUP);
            else
                MorphToUnstable();
        }
    }

    void EnterCombat(Unit* who) { return; }
};

CreatureAI* GetAI_npc_living_flare(Creature *creature)
{
    CreatureAI* newAI = new npc_living_flareAI(creature);
    return newAI;
}

struct npc_abyssal_shelf_questAI : public ScriptedAI
{
    npc_abyssal_shelf_questAI(Creature* creature) : ScriptedAI(creature) {}

    void UpdateAI(const uint32 diff)
    {
         if (!UpdateVictim())
             return;

         DoMeleeAttackIfReady();
    }

    void JustDied(Unit* killer)
    {
        me->RemoveCorpse();
    }
};

CreatureAI* GetAI_npc_abyssal_shelf_quest(Creature *creature)
{
    CreatureAI* newAI = new npc_abyssal_shelf_questAI(creature);
    return newAI;
}

/*######
## npc_felblood_initiate & npc_emaciated_felblood
######*/

#define SPELL_FELBLOOD_CHANNEL      44864
#define SPELL_BITTER_WITHDRAWAL     29098
#define SPELL_SINISTER_STRIKE       14873
#define SPELL_SPELLBREAKER          35871
#define SPELL_FEL_SIPHON_QUEST      44936
#define SPELL_SELF_STUN             45066

#define MOB_EMACIATED_FELBLOOD      24955

const char* YellChange[3] = 
{
    "No... no... NO!!!!!",
    "My power... is gone!",
    "What have you done!"
};
const char* YellSiphon[4] = 
{
    "More... more... MORE!!!",
    "I will soon be stronger than any elf! I will serve at Kil'jaeden's side!",
    "Unparalleled power... I... crave... more!",
    "Your life force is my nourishment, demon... Kil'jaeden's gift to us!"
};

struct npc_felblood_initiateAI : public ScriptedAI
{
    npc_felblood_initiateAI(Creature *creature) : ScriptedAI(creature) { }

    uint32 Spellbreaker;
    uint32 ChangeTimer;
    uint32 OOCTimer;
    uint32 BitterWithdrawal;
    uint32 SinisterStrike;

    void Reset()
    {
        Spellbreaker = urand(6000, 10000);
        ChangeTimer = 0;
        OOCTimer = 5000;
        BitterWithdrawal = urand(10000, 15000);
        SinisterStrike = urand(5000, 15000);
    }

    void HandleOffCombatEffects()
    {
        DoCast((Unit*)NULL, SPELL_FELBLOOD_CHANNEL);
    }

    void EnterCombat(Unit* who)
    {
        if(me->IsNonMeleeSpellCasted(false))
            me->InterruptNonMeleeSpells(false);
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(spell->Id == SPELL_FEL_SIPHON_QUEST)
        {
            DoCast(me, SPELL_SELF_STUN);
            ChangeTimer = 3000;
        }
    }

    void UpdateAI(const uint32 diff)
    {
      if(!me->isInCombat())
      {
          if(OOCTimer < diff)
          {
              if(!me->IsNonMeleeSpellCasted(false))
                  HandleOffCombatEffects();
              if(roll_chance_i(3))
                  me->Yell(YellSiphon[urand(0,3)], 0, 0);
              OOCTimer = 60000;
          }
          else
              OOCTimer -= diff;
      }

      if(!UpdateVictim())
          return;

      if(ChangeTimer)
      {
          if(ChangeTimer <= diff)
          {
              me->UpdateEntry(MOB_EMACIATED_FELBLOOD);
              me->Yell(YellChange[urand(0,2)], 0, 0);
              me->RemoveAurasDueToSpell(SPELL_SELF_STUN);
              me->AI()->AttackStart(me->getVictim());
              ChangeTimer = 0;
          }
          else ChangeTimer -= diff;
      }

      if(me->GetEntry() == MOB_EMACIATED_FELBLOOD)
      {
          if(BitterWithdrawal < diff)
          {
              AddSpellToCast(SPELL_BITTER_WITHDRAWAL);
              BitterWithdrawal = urand(12000, 18000);
          }
          else
              BitterWithdrawal -= diff;

           if(SinisterStrike < diff)
           {
               AddSpellToCast(SPELL_SINISTER_STRIKE);
               SinisterStrike = urand(10000, 15000);
           }
           else
                SinisterStrike -= diff;
      }
      else
      {
          if(Spellbreaker < diff)
          {
              AddSpellToCast(SPELL_SPELLBREAKER);
              Spellbreaker = urand(8000, 12000);
          }
          else
                Spellbreaker -= diff;
      }

       CastNextSpellIfAnyAndReady();
       DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_felblood_initiate(Creature *creature)
{
    CreatureAI* newAI = new npc_felblood_initiateAI(creature);
    return newAI;
}

///////
/// Ice Stone
///////

#define GOSSIP_ICE_STONE        "Place your hands on stone"

enum
{
    NPC_FROSTWAVE_LIEUTENANT    = 26116,
    NPC_HAILSTONE_LIEUTENANT    = 26178,
    NPC_CHILLWIND_LIEUTENANT    = 26204,
    NPC_FRIGID_LIEUTENANT       = 26214,
    NPC_GLACIAL_LIEUTENANT      = 26215,
    NPC_GLACIAL_TEMPLAR         = 26216,
};

uint32 GetIceStoneQuestID(uint32 zone)
{
    switch (zone)
    {
        case 33:    return 11948;   // Stranglethorn Vale
        case 51:    return 11952;   // Searing Gorge
        case 331:   return 11917;   // Ashenvale
        case 405:   return 11947;   // Desolace
        case 1377:  return 11953;   // Silithus
        case 3483:  return 11954;   // Hellfire Peninsula
        default:    return 0;
    }
}

bool GossipHello_go_ice_stone(Player *player, GameObject *go)
{
    if (uint32 quest = GetIceStoneQuestID(player->GetZoneId()))
    {
        player->PlayerTalkClass->ClearMenus();

        if (player->GetQuestStatus(quest) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ICE_STONE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        player->SEND_GOSSIP_MENU(go->GetGOInfo()->questgiver.gossipID, go->GetGUID());
    }

    return true;
}

void SendActionMenu_go_ice_stone(Player *player, GameObject* go, uint32 action)
{
    go->SetGoState(GO_STATE_ACTIVE);
    go->SetRespawnTime(300);
    player->CLOSE_GOSSIP_MENU();

    if (action == GOSSIP_ACTION_INFO_DEF)
    {
        uint32 npcId;

        switch (player->GetZoneId())
        {
            case 33:    npcId = NPC_CHILLWIND_LIEUTENANT;   break;  // Stranglethorn Vale
            case 51:    npcId = NPC_FRIGID_LIEUTENANT;      break;  // Searing Gorge
            case 331:   npcId = NPC_FROSTWAVE_LIEUTENANT;   break;  // Ashenvale
            case 405:   npcId = NPC_HAILSTONE_LIEUTENANT;   break;  // Desolace
            case 1377:  npcId = NPC_GLACIAL_LIEUTENANT;     break;  // Silithus
            case 3483:  npcId = NPC_GLACIAL_TEMPLAR;        break;  // Hellfire Peninsula
            default:    return;
        }

        if (GetClosestCreatureWithEntry(player, npcId, 20.0f))
            return;

        float x,y,z;
        player->GetNearPoint(x,y,z, 0.0f, 2.0f, frand(0, M_PI));
        player->SummonCreature(npcId, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 600000);
    }
}

bool GossipSelect_go_ice_stone(Player *player, GameObject *go, uint32 sender, uint32 action)
{
    if (sender == GOSSIP_SENDER_MAIN)
        SendActionMenu_go_ice_stone(player, go, action);

    return true;
}

/*######
## npc_hand_berserker
######*/

enum
{
    SPELL_SOUL_BURDEN       = 38879,
    SPELL_ENRAGE            = 8599,
    SPELL_CHARGE            = 35570,

    NPC_BUNNY               = 22444
};

struct npc_hand_berserkerAI : public ScriptedAI
{
    npc_hand_berserkerAI(Creature* creature) : ScriptedAI(creature) {}

    void Reset() {}

    void EnterCombat(Unit* who)
    {
        if (rand()%60)
        {
            DoCast(who, SPELL_CHARGE);
        }
    }   

    void DamageTaken(Unit* doneby, uint32 & damage)
    {
        if (me->HasAura(SPELL_ENRAGE))
            return;

        if (doneby->GetTypeId() == TYPEID_PLAYER && (me->GetHealth()*100 - damage) / me->GetMaxHealth() < 30)
        {
            DoCast(me, SPELL_ENRAGE);
        }
    }

    void JustDied(Unit* who)
    {
        if (Creature* Bunny = GetClosestCreatureWithEntry(me, NPC_BUNNY, 17.5f))
        {
            Bunny->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            DoCast(Bunny, SPELL_SOUL_BURDEN);
        }
    }
};

CreatureAI* GetAI_npc_hand_berserker(Creature* creature)
{
    return new npc_hand_berserkerAI(creature);
}

/*######
## npc_anchorite_relic_bunny
######*/

enum
{
    NPC_HAND_BERSERKER      = 16878,
    NPC_FEL_SPIRIT          = 22454,
    SPELL_CHANNELS          = 39184,

    GO_RELIC                = 185298,
    SAY_SP                  = -1900130
};

struct npc_anchorite_relic_bunnyAI : public ScriptedAI
{
    npc_anchorite_relic_bunnyAI(Creature* creature) : ScriptedAI(creature) {}

    uint32 ChTimer;
    uint32 EndTimer;

    void Reset()
    {
        ChTimer = 2000;
        EndTimer = 60000;
    }

    void AttackedBy(Unit* pEnemy) {}
    void AttackStart(Unit* pEnemy) {}

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == NPC_FEL_SPIRIT)
        {
            DoScriptText(SAY_SP, summoned);
            summoned->AI()->AttackStart(summoned->getVictim());
        }
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (spell->Id == SPELL_SOUL_BURDEN)
        {
            me->InterruptNonMeleeSpells(false);
            me->SummonCreature(NPC_FEL_SPIRIT, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            ChTimer = 2000;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (ChTimer <= diff)
        {
            if (Creature* Ber = GetClosestCreatureWithEntry(me, NPC_HAND_BERSERKER, 17.5f, true))
            {
                {
                    DoCast(Ber, SPELL_CHANNELS, false);
                    ChTimer = 95000;
                }
            }
            else me->InterruptNonMeleeSpells(false);
        }
        else ChTimer -= diff;

        if (EndTimer <= diff)
        {
            if (GameObject* relic = GetClosestGameObjectWithEntry(me, GO_RELIC, 5.0f))
            {
                relic->RemoveFromWorld();
                me->setDeathState(JUST_DIED);
                me->RemoveCorpse();
            }

            EndTimer = 60000;
        }
        else EndTimer -= diff;
    }
};

CreatureAI* GetAI_npc_anchorite_relic_bunny(Creature* creature)
{
    return new npc_anchorite_relic_bunnyAI(creature);
}

/*######
## npc_anchorite_barada
######*/

#define GOSSIP_ITEM_START      "I am ready Amchorite.Let us begin the exorcim."
#define SAY_BARADA1            -1900100
#define SAY_BARADA2            -1900101
#define SAY_BARADA3            -1900104
#define SAY_BARADA4            -1900105
#define SAY_BARADA5            -1900106
#define SAY_BARADA6            -1900107
#define SAY_BARADA7            -1900108
#define SAY_BARADA8            -1900109
#define SAY_COLONEL1           -1900110
#define SAY_COLONEL2           -1900111
#define SAY_COLONEL3           -1900112
#define SAY_COLONEL4           -1900113
#define SAY_COLONEL5           -1900114
#define SAY_COLONEL6           -1900115
#define SAY_COLONEL7           -1900116
#define SAY_COLONEL8           -1900117

enum
{
    QUEST_THE_EXORCIM          = 10935,
    NPC_COLONEL_JULES          = 22432,
    NPC_DARKNESS_RELEASED      = 22507,

    SPELL_EXORCIM              = 39277,
    SPELL_EXORCIM2             = 39278,
    SPELL_COLONEL1             = 39283,         
    SPELL_COLONEL2             = 39294,
    SPELL_COLONEL3             = 39284,
    SPELL_COLONEL4             = 39294,
    SPELL_COLONEL5             = 39295,
    SPELL_COLONEL7             = 39381,
    SPELL_COLONEL8             = 39380
};

struct Points
{
    float x, y, z;
};

static Points P[]=
{
    {-710.111f, 2754.346f, 102.367f},
    {-710.611f, 2753.435f, 103.774f},
    {-707.784f, 2749.562f, 103.774f},
    {-708.558f, 2744.923f, 103.774f},
    {-713.406f, 2744.240f, 103.774f},
    {-714.212f, 2750.606f, 103.774f},
    {-710.792f, 2750.693f, 103.774f},

    {-707.702f, 2749.038f, 101.590f},
    {-710.810f, 2748.376f, 101.590f},
    {-706.726f, 2751.632f, 101.591f},
    {-707.382f, 2753.994f, 101.591f},

    {-710.924f, 2754.683f, 105.0f}
};

struct npc_anchorite_baradaAI : public ScriptedAI
{
    npc_anchorite_baradaAI(Creature* creature) : ScriptedAI(creature) {}

    bool Exorcim;

    uint32 StepsTimer;
    uint32 Steps;
    uint64 PlayerGUID;

    void Reset()
    {
        Exorcim = false;
        StepsTimer = 0;
        Steps = 0;
        PlayerGUID = 0;
    }

    void AttackedBy(Unit* who) {}
    void AttackStart(Unit* who) {}

    void DoSpawnDarkness()
    {
        me->SummonCreature(NPC_DARKNESS_RELEASED, P[11].x, P[11].y, P[11].z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 20000);
    }

    uint32 NextStep(uint32 Steps)
    {
        if (Creature* Colonel = GetClosestCreatureWithEntry(me, NPC_COLONEL_JULES, 15))
        {
            switch(Steps)
            {
                case 1:me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        me->SetStandState(UNIT_STAND_STATE_STAND);return 2000;
                case 2:DoScriptText(SAY_BARADA1, me,0);return 5000;
                case 3:DoScriptText(SAY_BARADA2, me,0);return 3000;
                case 4:DoScriptText(SAY_COLONEL1, Colonel, 0);return 3000;
                case 5:me->SetWalk(true);;return 3000;
                case 6:me->GetMotionMaster()->MovePoint(0, P[7].x, P[7].y, P[7].z);return 2000;
                case 7:me->GetMotionMaster()->MovePoint(0, P[8].x, P[8].y, P[8].z);return 2100;
                case 8:me->SetFacingToObject(Colonel);return 2000;
                case 9:me->CastSpell(me, SPELL_EXORCIM , false);return 10000;
                case 10:DoScriptText(SAY_BARADA3, me,0); return 10000;
                case 11:DoScriptText(SAY_COLONEL2, Colonel, 0);return 8000;
                case 12:me->RemoveAllAuras();
                case 13:me->CastSpell(me, SPELL_EXORCIM2 , false);
                case 14:Colonel->CastSpell(Colonel, SPELL_COLONEL1, false);
                case 15:Colonel->SetSpeed(MOVE_FLIGHT, 0.15f);
                        Colonel->SetLevitate(true);
                        Colonel->GetMotionMaster()->MovePoint(0, P[1].x, P[1].y, P[1].z);
                        Colonel->CastSpell(Colonel, SPELL_COLONEL3, false);return 14000;
                case 16:DoScriptText(SAY_COLONEL3, Colonel, 0);
                        DoSpawnDarkness();
                        DoSpawnDarkness();return 14000;
                case 17:DoScriptText(SAY_BARADA4, me, 0);
                        DoSpawnDarkness();
                        DoSpawnDarkness();return 14000;
                case 18:DoScriptText(SAY_COLONEL4, Colonel, 0);
                        DoSpawnDarkness();return 14000;
                case 19:DoScriptText(SAY_BARADA5, me, 0); return 14000;
                case 20:Colonel->CastSpell(Colonel, SPELL_COLONEL4, false);
                        Colonel->CastSpell(Colonel, SPELL_COLONEL2, false);
                        DoSpawnDarkness();return 1500;
                case 21:Colonel->GetMotionMaster()->MovePoint(0, P[4].x, P[4].y, P[4].z);return 7000;
                case 22:DoScriptText(SAY_COLONEL5, Colonel, 0);return 1000;
                case 23:Colonel->GetMotionMaster()->MovePoint(0, P[2].x, P[2].y, P[2].z);
                        DoSpawnDarkness();return 5000;
                case 24:Colonel->GetMotionMaster()->MovePoint(0, P[3].x, P[3].y, P[3].z);
                        Colonel->CastSpell(me,SPELL_COLONEL5, false);return 3500;
                case 25:DoScriptText(SAY_BARADA6, me, 0);
                case 26:Colonel->GetMotionMaster()->MovePoint(0, P[4].x, P[4].y, P[4].z);
                        DoSpawnDarkness();return 2000;
                case 27:Colonel->GetMotionMaster()->MovePoint(0, P[5].x, P[5].y, P[4].z);return 4000;
                case 28:Colonel->GetMotionMaster()->MovePoint(0, P[2].x, P[2].y, P[2].z);
                        DoScriptText(SAY_COLONEL6, Colonel, 0);
                        DoSpawnDarkness();return 4000;
                case 29:Colonel->GetMotionMaster()->MovePoint(0, P[5].x, P[5].y, P[5].z);return 4000;
                case 30:Colonel->GetMotionMaster()->MovePoint(0, P[2].x, P[2].y, P[2].z);return 4000;
                case 31: DoScriptText(SAY_BARADA7, me, 0); return 0;
                case 32:Colonel->GetMotionMaster()->MovePoint(0, P[3].x, P[3].y, P[3].z);
                        DoSpawnDarkness();return 4000;
                case 33:Colonel->GetMotionMaster()->MovePoint(0, P[4].x, P[4].y, P[4].z);return 4000;
                case 34:Colonel->GetMotionMaster()->MovePoint(0, P[5].x, P[5].y, P[5].z);
                        DoScriptText(SAY_COLONEL7, Colonel, 0);
                        DoSpawnDarkness();return 4000;
                case 35:Colonel->GetMotionMaster()->MovePoint(0, P[4].x, P[4].y, P[4].z);return 4000;
                case 36:Colonel->GetMotionMaster()->MovePoint(0, P[5].x, P[5].y, P[5].z);
                        DoSpawnDarkness();return 4000;
                case 37:DoScriptText(SAY_BARADA6, me, 0);
                case 38:Colonel->GetMotionMaster()->MovePoint(0, P[2].x, P[2].y, P[2].z);return 2500;
                case 39:Colonel->GetMotionMaster()->MovePoint(0, P[3].x, P[3].y, P[3].z);return 4000;
                case 40:Colonel->GetMotionMaster()->MovePoint(0, P[4].x, P[4].y, P[4].z);
                        DoScriptText(SAY_COLONEL8, Colonel, 0);return 4000;
                case 41:Colonel->GetMotionMaster()->MovePoint(0, P[5].x, P[5].y, P[5].z);return 4000;
                case 42:Colonel->GetMotionMaster()->MovePoint(0, P[2].x, P[2].y, P[2].z);return 4000;
                case 43:DoScriptText(SAY_BARADA6, me, 0); return 1000;
                case 44:Colonel->GetMotionMaster()->MovePoint(0, P[3].x, P[3].y, P[3].z);return 4000;
                case 45:Colonel->GetMotionMaster()->MovePoint(0, P[4].x, P[4].y, P[4].z);
                        Colonel->CastSpell(Colonel, SPELL_COLONEL8, false);return 4000;
                case 46:Colonel->GetMotionMaster()->MovePoint(0, P[5].x, P[5].y, P[5].z);
                        Colonel->CastSpell(Colonel, SPELL_COLONEL7, false);return 4000;
                case 47:Colonel->GetMotionMaster()->MovePoint(0, P[6].x, P[6].y, P[6].z);return 5000;
                case 48:DoScriptText(SAY_BARADA8, me, 0); return 1000;
                case 49:Colonel->GetMotionMaster()->MovePoint(0, P[0].x, P[0].y, P[0].z);return 3000;
                case 50:Colonel->RemoveAllAuras();
                case 51:me->RemoveAllAuras();return 2000;
                case 52:me->SetWalk(true);return 2000;
                case 53:me->GetMotionMaster()->MovePoint(0, P[9].x, P[9].y, P[9].z);return 2200;
                case 54:me->GetMotionMaster()->MovePoint(0, P[10].x, P[10].y, P[10].z);return 7000;
                case 55:me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        me->CombatStop();return 3000;
                case 56:Colonel->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);return 20000;
                case 57:me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        Colonel->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                case 58:
                    {
                        if (Player* plr = Unit::GetPlayer(PlayerGUID))
                            if (plr->IsInRange(me,0,15))
                                plr->GroupEventHappens(QUEST_THE_EXORCIM ,me);
                    Reset();
                    }
            default: return 0;
            }
        }
        return 0;
    }

    void JustDied(Unit* who)
    {
        if (Creature* Colonel = GetClosestCreatureWithEntry(me, NPC_COLONEL_JULES, 15.0f))
        {
            Colonel->GetMotionMaster()->MovePoint(0, P[0].x, P[0].y, P[0].z);
            Colonel->RemoveAllAuras();
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (StepsTimer <= diff)
        {
            if (Exorcim)
                StepsTimer = NextStep(++Steps);
        }
        else StepsTimer -= diff;
    }
};

CreatureAI* GetAI_npc_anchorite_barada(Creature* creature)
{
    return new npc_anchorite_baradaAI(creature);
}

bool GossipHello_npc_anchorite_barada(Player *player, Creature *creature)
{
    if (player->GetQuestStatus(QUEST_THE_EXORCIM) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_START, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
    return true;
}

bool GossipSelect_npc_anchorite_barada(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        ((npc_anchorite_baradaAI*)creature->AI())->PlayerGUID = player->GetGUID();
        ((npc_anchorite_baradaAI*)creature->AI())->Exorcim = true;
        player->CLOSE_GOSSIP_MENU();
    }
    return true;
}

/*######
## npc_darkness_released
######*/

enum
{
    SPELL_AURA_ME     = 39303,
    SPELL_DARKNESS    = 39307,
    NPC_BARADA        = 22431
};

struct Move
{
    float x, y, z;
};

static Move M[]=
{
    {-714.212f, 2750.606f, 105.0f},
    {-713.406f, 2744.240f, 105.0f},
    {-707.784f, 2749.562f, 105.0f},
    {-708.558f, 2744.923f, 105.0f}
};

struct npc_darkness_releasedAI : public ScriptedAI
{
    npc_darkness_releasedAI(Creature* creature) : ScriptedAI(creature) 
    {
        ChTimer = 5000;
        AtTimer = 10000;
        DoCast(me, SPELL_AURA_ME);
        me->SetLevitate(true);
        me->SetSpeed(MOVE_FLIGHT, 0.08f);
        switch(urand(0,3))
        {
            case 0: me->GetMotionMaster()->MovePoint(0, M[0].x, M[0].y, M[0].z); break;
            case 1: me->GetMotionMaster()->MovePoint(0, M[1].x, M[1].y, M[1].z); break;
            case 2: me->GetMotionMaster()->MovePoint(0, M[2].x, M[2].y, M[2].z); break;
            case 3: me->GetMotionMaster()->MovePoint(0, M[3].x, M[3].y, M[3].z); break;
        }
    }

    uint32 AtTimer;
    uint32 ChTimer;

    void Reset() { }

    void AttackedBy(Unit* who) {}
    void AttackStart(Unit* who) {}

    void JustDied(Unit* who)
    {
        me->RemoveCorpse();
    }

    void UpdateAI(const uint32 diff)
    {
        if (AtTimer <= diff)
        {
            DoCast(me, SPELL_DARKNESS);
            switch (urand(0,3))
            {
                case 0: me->GetMotionMaster()->MovePoint(0, M[0].x, M[0].y, M[0].z); break;
                case 1: me->GetMotionMaster()->MovePoint(0, M[1].x, M[1].y, M[1].z); break;
                case 2: me->GetMotionMaster()->MovePoint(0, M[2].x, M[2].y, M[2].z); break;
                case 3: me->GetMotionMaster()->MovePoint(0, M[3].x, M[3].y, M[3].z); break;
            }

        AtTimer = 10000;
        }
        else AtTimer -= diff;

        if (ChTimer <= diff)
        {
            if (Creature* Bar = GetClosestCreatureWithEntry(me, NPC_BARADA, 15.0f, false))
            {
                me->setDeathState(CORPSE);
            }

            if (Creature* Bara = GetClosestCreatureWithEntry(me, NPC_BARADA, 15.0f))
            {
                if (!Bara->HasAura(SPELL_EXORCIM2))
                    me->setDeathState(CORPSE);
            }

            ChTimer = 5000;
        }
        else ChTimer -= diff;
    }
};

CreatureAI* GetAI_npc_darkness_released(Creature* creature)
{
    return new npc_darkness_releasedAI(creature);
}

/*######
## npc_foul_purge
######*/

struct npc_foul_purgeAI : public ScriptedAI
{
    npc_foul_purgeAI(Creature* creature) : ScriptedAI(creature) 
    {
        if (Creature* Bara = GetClosestCreatureWithEntry(me, NPC_BARADA, 15.0f))
        {
            me->GetMotionMaster()->MovePoint(0, Bara->GetPositionX(), Bara->GetPositionY(), Bara->GetPositionZ());
            AttackStart(Bara);
        }
        ChTimer = 4000;
    }

    uint32 ChTimer;

    void Reset() { }

    void JustDied(Unit* who)
    {
        me->RemoveCorpse();
    }

    void UpdateAI(const uint32 diff)
    {
        if (ChTimer <= diff)
        {
            if (Creature* Bar = GetClosestCreatureWithEntry(me, NPC_BARADA, 15.0f, false))
            {
                me->setDeathState(CORPSE);
            }

            if (Creature* Bara = GetClosestCreatureWithEntry(me, NPC_BARADA, 15.0f))
            {
                if (!Bara->HasAura(SPELL_EXORCIM2))
                    me->setDeathState(CORPSE);
            }

            ChTimer = 4000;
        }
        else ChTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_foul_purge(Creature* creature)
{
    return new npc_foul_purgeAI(creature);
}

/*######
## npc_sedai_quest_credit_marker
######*/

enum
{
    NPC_ESCORT1    = 17417,
    NPC_SEDAI      = 17404
};

struct npc_sedai_quest_credit_markerAI : public ScriptedAI
{
    npc_sedai_quest_credit_markerAI(Creature* creature) : ScriptedAI(creature) {}

    void Reset()
    {
        DoSpawn();
    }

    void DoSpawn()
    {
        me->SummonCreature(NPC_SEDAI, 225.908, 4124.034, 82.505, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 100000);
        me->SummonCreature(NPC_ESCORT1, 229.257, 4125.271, 83.388, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 40000);
    }

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == NPC_ESCORT1)
        {
            summoned->SetWalk(true);
            summoned->GetMotionMaster()->MovePoint(0, 208.029f, 4134.618f, 77.763f);
        }
    }
};

CreatureAI* GetAI_npc_sedai_quest_credit_marker(Creature* creature)
{
    return new npc_sedai_quest_credit_markerAI(creature);
}

/*######
## npc_vindicator_sedai
######*/

#define SAY_MAG_ESSCORT    -1900125
#define SAY_SEDAI1         -1900126
#define SAY_SEDAI2         -1900127
#define SAY_KRUN           -1900128

enum
{
    NPC_ESCORT        = 17417,
    NPC_AMBUSHER      = 17418,
    NPC_KRUN          = 17405,

    SPELL_STUN        = 13005,
    SPELL_HOLYFIRE    = 17141
};

struct npc_vindicator_sedaiAI : public ScriptedAI
{
    npc_vindicator_sedaiAI(Creature* creature) : ScriptedAI(creature) {}

    bool Vision;

    ObjectGuid PlayerGUID;
    uint32 StepsTimer;
    uint32 Steps;

    void Reset()
    {
        Vision = true;
        StepsTimer =0;
        Steps = 0;
        me->SetWalk(true);
    }

    void DoSpawnEscort()
    {
        me->SummonCreature(NPC_ESCORT, 227.188f, 4121.116f, 82.745f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 40000);
    }

    void DoSpawnAmbusher()
    {
        me->SummonCreature(NPC_AMBUSHER, 223.408f, 4120.086f, 81.843f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 30000);
    }

    void DoSpawnKrun()
    {
        me->SummonCreature(NPC_KRUN, 192.872f, 4129.417f, 73.655f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 8000);
    }

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == NPC_ESCORT)
        {
            summoned->SetWalk(true);
            summoned->GetMotionMaster()->MovePoint(0, 205.660f, 4130.663f, 77.175f);
        }

        if (summoned->GetEntry() == NPC_AMBUSHER)
        {
            Creature* pEscort = GetClosestCreatureWithEntry(summoned, NPC_ESCORT, 15);
            summoned->AI()->AttackStart(pEscort);
        }
        else
        {
            if (summoned->GetEntry() == NPC_KRUN)
            {
                summoned->SetWalk(false);
                summoned->GetMotionMaster()->MovePoint(0, 194.739868f, 4143.145996f, 73.798088f);
                DoScriptText(SAY_KRUN, summoned,0);
                summoned->AI()->AttackStart(me);
            }
        }
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
        {
            if (((Player*)who)->GetQuestStatus(9545) == QUEST_STATUS_INCOMPLETE)
            {
                if (me->IsWithinDistInMap(((Player *)who), 10))
                {
                    PlayerGUID = who->GetObjectGuid();
                }
            }
        }
    }

    uint32 NextStep(uint32 Steps)
    {
        switch(Steps)
        {
            case 1:DoSpawnEscort();
            case 2:me->GetMotionMaster()->MovePoint(0, 204.877f, 4133.172f, 76.897f);return 2900;
            case 3:if (Creature* Esc = GetClosestCreatureWithEntry(me, NPC_ESCORT, 20))
                   {
                       DoScriptText(SAY_MAG_ESSCORT, Esc,0);
                   };
                   return 1000;
            case 4:if (Creature* Esc = GetClosestCreatureWithEntry(me, NPC_ESCORT, 20))
                   {
                       Esc->GetMotionMaster()->MovePoint(0, 229.257f, 4125.271f, 83.388f);
                   };
                   return 1500;
            case 5:if (Creature* Esc = GetClosestCreatureWithEntry(me, NPC_ESCORT, 20))
                   {
                       Esc->GetMotionMaster()->MovePoint(0, 227.188f, 4121.116f, 82.745f);
                   };
                   return 1000;
            case 6:DoScriptText(SAY_SEDAI1, me,0);return 1000;
            case 7:DoSpawnAmbusher();return 3000;
            case 8:DoSpawnAmbusher();return 1000;
            case 9:if (Creature* Amb = GetClosestCreatureWithEntry(me, NPC_AMBUSHER, 35))
                   {
                       me->AI()->AttackStart(Amb);
                   };
                   return 2000;
            case 10:if (Creature* Amb = GetClosestCreatureWithEntry(me, NPC_AMBUSHER, 35))
                    {
                        me->CastSpell(Amb, SPELL_STUN , false);
                    };
                    return 2000;
            case 11:if (Creature* Amb = GetClosestCreatureWithEntry(me, NPC_AMBUSHER, 35))
                    {
                        Amb->setDeathState(JUST_DIED);
                    };
                    return 1500;
            case 12:if (Creature* Esc = GetClosestCreatureWithEntry(me, NPC_ESCORT, 20))
                    {
                        Esc->setDeathState(JUST_DIED);
                    };
            case 13:if (Creature* Amb = GetClosestCreatureWithEntry(me, NPC_AMBUSHER, 35))
                    {
                        me->AI()->AttackStart(Amb);
                    };
            case 14:if (Creature* Amb = GetClosestCreatureWithEntry(me, NPC_AMBUSHER, 35))
                    {
                        if (Creature* pEsc = GetClosestCreatureWithEntry(me, NPC_ESCORT, 20))
                        {
                            pEsc->AI()->AttackStart(Amb);
                        }
                    };
                    return 1000;
            case 15:if (Creature* Amb = GetClosestCreatureWithEntry(me, NPC_AMBUSHER, 35))
                    {
                        me->CastSpell(Amb, SPELL_HOLYFIRE , false);
                    };
                    return 6000;
            case 16:if (Creature* Amb = GetClosestCreatureWithEntry(me, NPC_AMBUSHER, 35))
                    {
                        Amb->setDeathState(JUST_DIED);
                    };
                    return 1000;
            case 17:if (Creature* Esc = GetClosestCreatureWithEntry(me, NPC_ESCORT, 20))
                    {
                        Esc->GetMotionMaster()->MovePoint(0, 235.063f, 4117.826f, 84.471f);
                    };
                    return 1000;
            case 18:me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(0, 199.706f, 4134.302f, 75.404f);return 6000;       
            case 19:me->GetMotionMaster()->MovePoint(0, 193.524f, 4147.451f, 73.605f);return 7000;              
            case 21:me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    DoScriptText(SAY_SEDAI2, me,0);return 5000;
            case 22:DoSpawnKrun();return 1000;
            case 23:if (Creature* Krun = GetClosestCreatureWithEntry(me, NPC_KRUN, 20))
                    {
                        me->CastSpell(Krun, SPELL_HOLYFIRE, false);
                    };
                    return 3000;
            case 24:if (Creature * Cr = GetClosestCreatureWithEntry(me, 17413, 6.0f))
                    {
                        if (Player* player = me->GetPlayer(PlayerGUID))
                        {
                            float Radius = 10.0f;
                            if (me->IsWithinDistInMap(player, Radius))
                            {
                                ((Player*)player)->KilledMonster(17413, Cr->GetObjectGuid());
                            }
                        }
                    };
                    return 1500;
            case 25:me->setDeathState(JUST_DIED);
        default: return 0;
        }
    }

    void UpdateAI(const uint32 diff)
    {

        if (StepsTimer <= diff)
        {
            if (Vision)
                StepsTimer = NextStep(++Steps);
        }
        else StepsTimer -= diff;        
    }
};

CreatureAI* GetAI_npc_vindicator_sedai(Creature* creature)
{
    return new npc_vindicator_sedaiAI(creature);
}

/*######
## npc_pathaleon_image
######*/

enum
{
    SAY_PATHALEON1         = -1900165,
    SAY_PATHALEON2         = -1900166,
    SAY_PATHALEON3         = -1900167,
    SAY_PATHALEON4         = -1900168,

    SPELL_ROOTS            = 35468,
    SPELL_INSECT           = 35471,
    SPELL_LIGHTING         = 35487,
    SPELL_TELE             = 7741,

    NPC_TARGET_TRIGGER     = 20781,
    NPC_CRYSTAL_TRIGGER    = 20617,
    NPC_GOLIATHON          = 19305,
};

struct Pos
{
    float x, y, z;
};

static Pos S[]=
{
    {113.29f, 4858.19f, 74.37f},
    {81.20f, 4806.26f, 51.75f},
    {106.21f, 4834.39f, 79.56f},
    {124.98f, 4813.17f, 79.66f},
    {124.01f, 4778.61f, 77.86f},
    {46.37f, 4795.72f, 66.73f},
    {60.14f, 4830.46f, 77.83f}
};

struct npc_pathaleon_imageAI : public ScriptedAI
{
    npc_pathaleon_imageAI(Creature* creature) : ScriptedAI(creature) {}

    bool Event;
    bool SummonTrigger;

    uint32 SumTimer;
    uint32 StepsTimer;
    uint32 Steps;

    void Reset()
    {
        SumTimer = 5000;
        StepsTimer = 0;
        Steps = 0;
        Event = true;
        SummonTrigger = false;
    }

    void DoSpawnGoliathon()
    {
        me->SummonCreature(NPC_GOLIATHON, S[0].x, S[0].y, S[0].z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
    }

    void DoSpawnTrigger()
    {
        me->SummonCreature(NPC_TARGET_TRIGGER, S[1].x, S[1].y, S[1].z, 2.25f, TEMPSUMMON_TIMED_DESPAWN, 120000);
    }

    void DoSpawnCtrigger()
    {
        me->SummonCreature(NPC_CRYSTAL_TRIGGER, S[2].x, S[2].y, S[2].z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 7000);
        me->SummonCreature(NPC_CRYSTAL_TRIGGER, S[3].x, S[3].y, S[3].z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 7000);
        me->SummonCreature(NPC_CRYSTAL_TRIGGER, S[4].x, S[4].y, S[4].z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 7000);
        me->SummonCreature(NPC_CRYSTAL_TRIGGER, S[5].x, S[5].y, S[5].z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 7000);
        me->SummonCreature(NPC_CRYSTAL_TRIGGER, S[6].x, S[6].y, S[6].z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 7000);
    }

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == NPC_GOLIATHON)
        {
            summoned->CastSpell(summoned, SPELL_TELE, false);
            summoned->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
        }
        if (summoned->GetEntry() == NPC_CRYSTAL_TRIGGER)
        {
            summoned->CastSpell(summoned, SPELL_INSECT, false);
            summoned->CastSpell(summoned, SPELL_LIGHTING, false);
        }
        else
        {
            if (summoned->GetEntry() == NPC_TARGET_TRIGGER)
            {
                summoned->CastSpell(summoned, SPELL_ROOTS, false);
            }
        }
    }

    int32 NextStep(uint32 Steps)
    {              
        switch (Steps)
        {
            case 1:
                return 10000;
            case 2:
                DoSpawnTrigger();
                SummonTrigger = true;
                return 2000;
            case 3:
                DoScriptText(SAY_PATHALEON1, me, 0);
                return 15000;
            case 4:
                DoScriptText(SAY_PATHALEON2, me, 0);
                return 15000;
            case 5:
                DoScriptText(SAY_PATHALEON3, me, 0);
                return 15000;
            case 6:
                DoScriptText(SAY_PATHALEON4, me, 0);
                return 5000;
            case 7:
                DoSpawnGoliathon();
                return 1000;
            case 8:
                DoCast(me, SPELL_TELE);
                return 600;
            case 9:
                me->SetVisibility(VISIBILITY_OFF);
                return 60000;
            case 10:
                me->setDeathState(CORPSE);
            default: return 0;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (StepsTimer <= diff)
        {
            if (Event)
                StepsTimer = NextStep(++Steps);
        }
        else StepsTimer -= diff;

        if (SummonTrigger)
        {
            if (SumTimer <= diff)
            {
                DoSpawnCtrigger();
                SumTimer = 5000;
            }
            else SumTimer -= diff;
        }
    }
};

CreatureAI* GetAI_npc_pathaleon_image(Creature* creature)
{
    return new npc_pathaleon_imageAI(creature);
}

/*######
## npc_viera
######*/

#define SAY_VIERA1                       -1900172
#define SAY_VIERA2                       -1900173

#define QUEST_LIVE_IS_FINER_PLEASURES    9483

#define NPC_CAT                          17230

struct npc_vieraAI : public npc_escortAI
{
    npc_vieraAI(Creature* creature) : npc_escortAI(creature) {}

    uint32 EndsTimer;

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();

        if (!player)
            return;

        switch (i)
        {
            case 0:
                me->SetStandState(UNIT_STAND_STATE_STAND);
                DoSpawnCreature(NPC_CAT, 5, 5, 0, 0, TEMPSUMMON_TIMED_DESPAWN, 85000);
                break;
            case 9:
                me->SetFacingToObject(player);
                DoScriptText(SAY_VIERA1, me, player);
                me->SetStandState(UNIT_STAND_STATE_SIT);
                EndsTimer = 40000;
                SetEscortPaused(true);
                SetRun();
                break;
            case 10:
                if (Creature* Cat = GetClosestCreatureWithEntry(me, NPC_CAT, 20))
                {
                    Cat->ForcedDespawn();
                }
                break;
        }
    }

    void Reset()
    {
        EndsTimer = 0;
    }

    void EnterCombat(Unit* who) {}

    void JustSummoned(Creature* summoned)
    {
        summoned->GetMotionMaster()->MoveFollow(me, PET_FOLLOW_DIST,  summoned->GetFollowAngle());
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(spell->Id == 30077)
        {
            DoScriptText(SAY_VIERA2, me, 0);
            SetEscortPaused(false);
        }
    }

    void UpdateEscortAI(const uint32 diff)
    {
        if (EndsTimer <= diff)
        {
            SetEscortPaused(false);
        }
        else EndsTimer -= diff;
    }
};

bool QuestRewarded_npc_viera(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_LIVE_IS_FINER_PLEASURES)
    {
        if (npc_escortAI* pEscortAI = CAST_AI(npc_vieraAI, creature->AI()))
            pEscortAI->Start(false, false, player->GetGUID(), quest);
    }
    return true;
}

CreatureAI* GetAI_npc_viera(Creature* creature)
{
    return new npc_vieraAI(creature);
}

/*######
## npc_deranged_helboar
######*/

enum
{
    SPELL_BURNING_SPOKES                           = 33908,
    SPELL_ENRAGES                                  = 8599,
    //SPELL_TELL_DOG_I_JUST_DEAD                     = 37689,
    SPELL_SUMMON_POODAD                            = 37688,

    NPC_FEL_GUARD_HOUND                            = 21847
};

struct npc_deranged_helboarAI : public ScriptedAI
{
    npc_deranged_helboarAI(Creature* creature) : ScriptedAI(creature) {}

    Unit* Hound;

    void Reset()
    {
        Hound = 0;
    }

    void EnterCombat(Unit* who)
    {
        DoCast(me, SPELL_BURNING_SPOKES);
    } 

    void DamageTaken(Unit* doneby, uint32 & damage)
    {
        if (me->HasAura(SPELL_ENRAGES))
            return;

        if (doneby->GetTypeId() == TYPEID_PLAYER && (me->GetHealth()*100 - damage) / me->GetMaxHealth() < 30)
        {
            DoCast(me, SPELL_ENRAGES);
        }
    }

    void JustDied(Unit* slayer)
    {
        if(slayer->GetTypeId()==TYPEID_PLAYER && ((Player*)(slayer))->GetQuestStatus(10629)==QUEST_STATUS_INCOMPLETE)
        {
            Hound = FindCreature(NPC_FEL_GUARD_HOUND, 8, me);

            if(Hound && Hound->GetOwner()==slayer)
            {
                Hound->GetMotionMaster()->MoveChase(me);
                Hound->CastSpell(Hound, SPELL_SUMMON_POODAD, false);
            }
        }
    }
};

CreatureAI* GetAI_npc_deranged_helboar(Creature* creature)
{
    return new npc_deranged_helboarAI(creature);
}

/*###
# Quest 10792 "Zeth'Gor Must Burn!" (Horde) - Visual Effect
####*/

enum Quest10792
{
    SPELL_FIRE                  = 35724,
    GO_FIRE                     = 183816
};
struct npc_east_hovelAI : public ScriptedAI
{
    npc_east_hovelAI(Creature* creature) : ScriptedAI(creature) {}

    bool Summon;
    uint32 ResetTimer;
    void Reset()
    {
        Summon = true;
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(spell->Id == SPELL_FIRE)
        {
            if(Summon)
            {
                me->SummonGameObject(GO_FIRE, -934.393005, 1934.01001, 82.031601, 3.35103, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -927.877991, 1927.44995, 81.048897, 5.25344, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -935.54303, 1921.160034, 82.4132, 2.67035, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -944.015015, 1928.160034, 82.105499, 5.98648, 0, 0, 0, 0, 15);
                ResetTimer = 15000;
                Summon = false;
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!Summon)
        {
            if (ResetTimer <= diff)
            {
                Summon = true;
            }
            else ResetTimer -= diff;
        }
    }
};
CreatureAI* GetAI_npc_east_hovel(Creature* creature)
{
    return new npc_east_hovelAI(creature);
}

struct npc_west_hovelAI : public ScriptedAI
{
    npc_west_hovelAI(Creature* creature) : ScriptedAI(creature) {}

    bool Summon;
    uint32 ResetTimer;
    void Reset()
    {
        Summon = true;
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(spell->Id == SPELL_FIRE)
        {
            if(Summon)
            {
                me->SummonGameObject(GO_FIRE, -1145.410034, 2064.830078, 80.782600, 5.044, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -1156.839966, 2060.870117, 79.176399, 3.83972, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -1152.719971, 2073.5, 80.622902, 2.00713, 0, 0, 0, 0, 15);
                ResetTimer = 15000;
                Summon = false;
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!Summon)
        {
            if (ResetTimer <= diff)
            {
                Summon = true;
            }
            else ResetTimer -= diff;
        }
    }
};
CreatureAI* GetAI_npc_west_hovel(Creature* creature)
{
    return new npc_west_hovelAI(creature);
}

struct npc_stableAI : public ScriptedAI
{
    npc_stableAI(Creature* creature) : ScriptedAI(creature) {}

    bool Summon;
    uint32 ResetTimer;
    void Reset()
    {
        Summon = true;
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(spell->Id == SPELL_FIRE)
        {
            if(Summon)
            {
                me->SummonGameObject(GO_FIRE, -1067.280029, 1998.949951, 76.286301, 5.86431, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -1052.189941, 2012.099976, 80.946198, 5.95157, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -1043.439941, 2002.140015, 76.030502, 2.00713, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -1052.26001, 1996.339966, 79.377502, 0.628319, 0, 0, 0, 0, 15);
                ResetTimer = 15000;
                Summon = false;
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!Summon)
        {
            if (ResetTimer <= diff)
            {
                Summon = true;
            }
            else ResetTimer -= diff;
        }
    }
};
CreatureAI* GetAI_npc_stable(Creature* creature)
{
    return new npc_stableAI(creature);
}

struct npc_barracksAI : public ScriptedAI
{
    npc_barracksAI(Creature* creature) : ScriptedAI(creature) {}

    bool Summon;
    uint32 ResetTimer;
    void Reset()
    {
        Summon = true;
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(spell->Id == SPELL_FIRE)
        {
            if(Summon)
            {
                me->SummonGameObject(GO_FIRE, -1176.709961, 1972.189941, 107.182999, 5.18363, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -1120.219971, 1929.890015, 92.360901, 0.89011, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -1137.099976, 1951.25, 94.115898, 2.32129, 0, 0, 0, 0, 15);
                me->SummonGameObject(GO_FIRE, -1152.890015, 1961.48999, 92.9795, 0.994838, 0, 0, 0, 0, 15);
                ResetTimer = 15000;
                Summon = false;
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!Summon)
        {
            if (ResetTimer <= diff)
            {
                Summon = true;
            }
            else ResetTimer -= diff;
        }
    }
};
CreatureAI* GetAI_npc_barracks(Creature* creature)
{
    return new npc_barracksAI(creature);
}

void AddSC_hellfire_peninsula()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_abyssal_shelf_quest";
    newscript->GetAI = &GetAI_npc_abyssal_shelf_quest;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_aeranas";
    newscript->GetAI = &GetAI_npc_aeranas;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_haaleshi_altar";
    newscript->pGOUse = &GOUse_go_haaleshi_altar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_wing_commander_dabiree";
    newscript->pGossipHello =   &GossipHello_npc_wing_commander_dabiree;
    newscript->pGossipSelect =  &GossipSelect_npc_wing_commander_dabiree;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_gryphoneer_windbellow";
    newscript->pGossipHello =   &GossipHello_npc_gryphoneer_windbellow;
    newscript->pGossipSelect =  &GossipSelect_npc_gryphoneer_windbellow;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_wing_commander_brack";
    newscript->pGossipHello =   &GossipHello_npc_wing_commander_brack;
    newscript->pGossipSelect =  &GossipSelect_npc_wing_commander_brack;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_wounded_blood_elf";
    newscript->GetAI = &GetAI_npc_wounded_blood_elf;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_wounded_blood_elf;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_demoniac_scryer";
    newscript->pGossipHello =  &GossipHello_npc_demoniac_scryer;
    newscript->pGossipSelect = &GossipSelect_npc_demoniac_scryer;
    newscript->GetAI = &GetAI_npc_demoniac_scryer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_magic_sucker_device_spawner";
    newscript->GetAI = &GetAI_npc_magic_sucker_device_spawner;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_ancestral_spirit_wolf";
    newscript->GetAI = &GetAI_npc_ancestral_spirit_wolf;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_earthcaller_ryga";
    newscript->GetAI = &GetAI_npc_earthcaller_ryga;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_living_flare";
    newscript->GetAI = &GetAI_npc_living_flare;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_felblood_initiate";
    newscript->GetAI = &GetAI_npc_felblood_initiate;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="go_ice_stone";
    newscript->pGOUse  = &GossipHello_go_ice_stone;
    newscript->pGossipSelectGO = &GossipSelect_go_ice_stone;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_hand_berserker";
    newscript->GetAI = &GetAI_npc_hand_berserker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_anchorite_relic_bunny";
    newscript->GetAI = &GetAI_npc_anchorite_relic_bunny;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_anchorite_barada";
    newscript->pGossipHello =  &GossipHello_npc_anchorite_barada;
    newscript->pGossipSelect = &GossipSelect_npc_anchorite_barada;
    newscript->GetAI = &GetAI_npc_anchorite_barada;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_darkness_released";
    newscript->GetAI = &GetAI_npc_darkness_released;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_foul_purge";
    newscript->GetAI = &GetAI_npc_foul_purge;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_sedai_quest_credit_marker";
    newscript->GetAI = &GetAI_npc_sedai_quest_credit_marker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_vindicator_sedai";
    newscript->GetAI = &GetAI_npc_vindicator_sedai;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_pathaleon_image";
    newscript->GetAI = &GetAI_npc_pathaleon_image;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_viera";
    newscript->GetAI = &GetAI_npc_viera;
    newscript->pQuestRewardedNPC = &QuestRewarded_npc_viera;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_deranged_helboar";
    newscript->GetAI = &GetAI_npc_deranged_helboar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_east_hovel";
    newscript->GetAI = &GetAI_npc_east_hovel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_west_hovel";
    newscript->GetAI = &GetAI_npc_west_hovel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_stable";
    newscript->GetAI = &GetAI_npc_stable;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_barracks";
    newscript->GetAI = &GetAI_npc_barracks;
    newscript->RegisterSelf();
}
