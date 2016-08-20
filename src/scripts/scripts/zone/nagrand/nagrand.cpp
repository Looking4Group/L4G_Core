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
SDName: Nagrand
SD%Complete: 99
SDComment: Quest support: 9849, 9868, 9879, 9918, 9874, 9923, 9924, 9954, 9991, 10107, 10108, 10044, 10168, 10172, 10646, 10085, 10987. TextId's unknown for altruis_the_sufferer and greatmother_geyah (npc_text), 9932, 10011
SDCategory: Nagrand
EndScriptData */

/* ContentData
mob_shattered_rumbler
mob_ancient_orc_ancestor
mob_lump
npc_altruis_the_sufferer
npc_greatmother_geyah
npc_lantresor_of_the_blade
npc_creditmarker_visit_with_ancestors
mob_sparrowhawk
npc_corki_capitive
go_corki_cage
npc_nagrand_captive (npc_maghar_captive and npc_kurenai_captive in 1)
go_maghar_prison
npc_maghar_prisoner
npc_warmaul_pyre
npc_fel_cannon
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"

/*######
## mob_shattered_rumbler - this should be done with ACID
######*/

struct mob_shattered_rumblerAI : public ScriptedAI
{
    bool Spawn;

    mob_shattered_rumblerAI(Creature *creature) : ScriptedAI(creature) {}

    void Reset()
    {
        Spawn = false;
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if(spell->Id == 32001 && !Spawn)
        {
            float x = me->GetPositionX();
            float y = me->GetPositionY();
            float z = me->GetPositionZ();

            caster->SummonCreature(18181,x+(0.7 * (rand()%30)),y+(rand()%5),z,0,TEMPSUMMON_CORPSE_TIMED_DESPAWN,60000);
            caster->SummonCreature(18181,x+(rand()%5),y-(rand()%5),z,0,TEMPSUMMON_CORPSE_TIMED_DESPAWN,60000);
            caster->SummonCreature(18181,x-(rand()%5),y+(0.5 *(rand()%60)),z,0,TEMPSUMMON_CORPSE_TIMED_DESPAWN,60000);
            me->setDeathState(CORPSE);
            Spawn = true;
        }
        return;
    }
};
CreatureAI* GetAI_mob_shattered_rumbler(Creature *creature)
{
    return new mob_shattered_rumblerAI (creature);
}

/*######
## mob_ancient_orc_ancestor - this should be done with ACID also
######*/

struct mob_ancient_orc_ancestorAI : public ScriptedAI
{
    bool Spawn;

    mob_ancient_orc_ancestorAI(Creature *creature) : ScriptedAI(creature) {}

    void Reset()
    {
        Spawn = false;
    }

    void SpellHit(Unit *hitter, const SpellEntry *spellkind)
    {
        if(spellkind->Id == 34063 && !Spawn)
        {
            float x = me->GetPositionX();
            float y = me->GetPositionY();
            float z = me->GetPositionZ();
            hitter->SummonCreature(19480,x,y,z,0,TEMPSUMMON_CORPSE_TIMED_DESPAWN,60000);
            me->setDeathState(CORPSE);
            Spawn = true;
        }
        return;
    }
};
CreatureAI* GetAI_mob_ancient_orc_ancestor(Creature *creature)
{
    return new mob_ancient_orc_ancestorAI (creature);
}

/*######
## mob_lump
######*/

#define SPELL_VISUAL_SLEEP  16093
#define SPELL_SPEAR_THROW   32248

#define LUMP_SAY0 -1000293
#define LUMP_SAY1 -1000294

#define LUMP_DEFEAT -1000295

#define GOSSIP_HL "I need answers, ogre!"
#define GOSSIP_SL1 "Why are Boulderfist out this far? You know that this is Kurenai territory."
#define GOSSIP_SL2 "And you think you can just eat anything you want? You're obviously trying to eat the Broken of Telaar."
#define GOSSIP_SL3 "This means war, Lump! War I say!"

struct mob_lumpAI : public ScriptedAI
{
    mob_lumpAI(Creature *creature) : ScriptedAI(creature)
    {
        bReset = false;
    }

    uint32 Reset_Timer;
    uint32 Spear_Throw_Timer;
    bool bReset;

    void Reset()
    {
        Reset_Timer = 60000;
        Spear_Throw_Timer = 2000;

        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
    }

    void DamageTaken(Unit *done_by, uint32 & damage)
    {
        if (done_by->GetTypeId() == TYPEID_PLAYER && (me->GetHealth() - damage)*100 / me->GetMaxHealth() < 30)
        {
            if (!bReset && ((Player*)done_by)->GetQuestStatus(9918) == QUEST_STATUS_INCOMPLETE)
            {
                //Take 0 damage
                damage = 0;

                ((Player*)done_by)->AttackStop();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->RemoveAllAuras();
                me->DeleteThreatList();
                me->CombatStop();
                me->setFaction(1080);               //friendly
                me->SetUInt32Value(UNIT_FIELD_BYTES_1, PLAYER_STATE_SIT);
                DoScriptText(LUMP_DEFEAT, me);

                bReset = true;
            }
        }
    }

    void EnterCombat(Unit *who)
    {
        if (me->HasAura(SPELL_VISUAL_SLEEP,0))
            me->RemoveAura(SPELL_VISUAL_SLEEP,0);

        if (!me->IsStandState())
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, PLAYER_STATE_NONE);

        DoScriptText(RAND(LUMP_SAY0, LUMP_SAY1), me);
    }

    void UpdateAI(const uint32 diff)
    {
        //check if we waiting for a reset
        if (bReset)
        {
            if (Reset_Timer < diff)
            {
                EnterEvadeMode();
                bReset = false;
                me->setFaction(1711);               //hostile
                return;
            }
            else Reset_Timer -= diff;
        }

        //Return since we have no target
        if (!UpdateVictim())
            return;

        //Spear_Throw_Timer
        if (Spear_Throw_Timer < diff)
        {
            DoCast(me->getVictim(), SPELL_SPEAR_THROW);
            Spear_Throw_Timer = 20000;
        }else Spear_Throw_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_lump(Creature *creature)
{
    return new mob_lumpAI(creature);
}

bool GossipHello_mob_lump(Player *player, Creature *creature)
{
    if (player->GetQuestStatus(9918) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(9352, creature->GetGUID());

    return true;
}

bool GossipSelect_mob_lump(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SL1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(9353, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SL2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(9354, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SL3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            player->SEND_GOSSIP_MENU(9355, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->SEND_GOSSIP_MENU(9356, creature->GetGUID());
            player->TalkedToCreature(18354, creature->GetGUID());
            break;
    }
    return true;
}

/*######
## npc_altruis_the_sufferer
######*/

#define GOSSIP_HATS1 "I see twisted steel and smell sundered earth."
#define GOSSIP_HATS2 "Well...?"
#define GOSSIP_HATS3 "[PH] Story about Illidan's Pupil"

#define GOSSIP_SATS1 "Legion?"
#define GOSSIP_SATS2 "And now?"
#define GOSSIP_SATS3 "How do you see them now?"
#define GOSSIP_SATS4 "Forge camps?"
#define GOSSIP_SATS5 "Ok."
#define GOSSIP_SATS6 "[PH] Story done"

bool GossipHello_npc_altruis_the_sufferer(Player *player, Creature *creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu( creature->GetGUID() );

    //gossip before obtaining Survey the Land
    if ( player->GetQuestStatus(9991) == QUEST_STATUS_NONE )
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HATS1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+10);

    //gossip when Survey the Land is incomplete (technically, after the flight)
    if (player->GetQuestStatus(9991) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HATS2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+20);

    //wowwiki.com/Varedis
    if (player->GetQuestStatus(10646) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HATS3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+30);

    player->SEND_GOSSIP_MENU(9419, creature->GetGUID());

    return true;
}

bool GossipSelect_npc_altruis_the_sufferer(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF+10:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SATS1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
            player->SEND_GOSSIP_MENU(9420, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+11:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SATS2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
            player->SEND_GOSSIP_MENU(9421, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+12:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SATS3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
            player->SEND_GOSSIP_MENU(9422, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+13:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SATS4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
            player->SEND_GOSSIP_MENU(9423, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+14:
            player->SEND_GOSSIP_MENU(9424, creature->GetGUID());
            break;

        case GOSSIP_ACTION_INFO_DEF+20:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SATS5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 21);
            player->SEND_GOSSIP_MENU(9427, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+21:
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(9991);
            break;

        case GOSSIP_ACTION_INFO_DEF+30:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SATS6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
            player->SEND_GOSSIP_MENU(384, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+31:
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(10646);
            break;
    }
    return true;
}

bool QuestAccept_npc_altruis_the_sufferer(Player *player, Creature *creature, Quest const *quest )
{
    if ( !player->GetQuestRewardStatus(9991) )              //Survey the Land, q-id 9991
    {
        player->CLOSE_GOSSIP_MENU();

        std::vector<uint32> nodes;

        nodes.resize(2);
        nodes[0] = 113;                                     //from
        nodes[1] = 114;                                     //end at
        player->ActivateTaxiPathTo(nodes);                  //TaxiPath 532
    }
    return true;
}

/*######
## npc_greatmother_geyah
######*/

#define GOSSIP_HGG1 "Hello, Greatmother. Garrosh told me that you wanted to speak with me."
#define GOSSIP_HGG2 "Garrosh is beyond redemption, Greatmother. I fear that in helping the Mag'har, I have convinced Garrosh that he is unfit to lead."

#define GOSSIP_SGG1 "You raised all of the orcs here, Greatmother?"
#define GOSSIP_SGG2 "Do you believe that?"
#define GOSSIP_SGG3 "What can be done? I have tried many different things. I have done my best to help the people of Nagrand. Each time I have approached Garrosh, he has dismissed me."
#define GOSSIP_SGG4 "Left? How can you choose to leave?"
#define GOSSIP_SGG5 "What is this duty?"
#define GOSSIP_SGG6 "Is there anything I can do for you, Greatmother?"
#define GOSSIP_SGG7 "I have done all that I could, Greatmother. I thank you for your kind words."
#define GOSSIP_SGG8 "Greatmother, you are the mother of Durotan?"
#define GOSSIP_SGG9 "Greatmother, I never had the honor. Durotan died long before my time, but his heroics are known to all on my world. The orcs of Azeroth reside in a place known as Durotar, named after your son. And ... (You take a moment to breathe and think through what you are about to tell the Greatmother.)"
#define GOSSIP_SGG10 "It is my Warchief, Greatmother. The leader of my people. From my world. He ... He is the son of Durotan. He is your grandchild."
#define GOSSIP_SGG11 "I will return to Azeroth at once, Greatmother."

//all the textId's for the below is unknown, but i do believe the gossip item texts are proper.
bool GossipHello_npc_greatmother_geyah(Player *player, Creature *creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu( creature->GetGUID() );

    if (player->GetQuestStatus(10044) == QUEST_STATUS_INCOMPLETE)
    {
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HGG1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(creature->GetNpcTextId(),creature->GetGUID());
    }
    else if (player->GetQuestStatus(10172) == QUEST_STATUS_INCOMPLETE)
    {
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HGG2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
        player->SEND_GOSSIP_MENU(creature->GetNpcTextId(),creature->GetGUID());
    }
    else

        player->SEND_GOSSIP_MENU(creature->GetNpcTextId(),creature->GetGUID());

    return true;
}

bool GossipSelect_npc_greatmother_geyah(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 3:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 4:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 5:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 6:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 7:
            player->AreaExploredOrEventHappens(10044);
            player->CLOSE_GOSSIP_MENU();
            break;

        case GOSSIP_ACTION_INFO_DEF + 10:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 11:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG8, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 12:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG9, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 13:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG10, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 14:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SGG11, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 15);
            player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 15:
            player->AreaExploredOrEventHappens(10172);
            player->CLOSE_GOSSIP_MENU();
            break;
    }
    return true;
}

/*######
## npc_lantresor_of_the_blade
######*/

#define GOSSIP_HLB "I have killed many of your ogres, Lantresor. I have no fear."
#define GOSSIP_SLB1 "Should I know? You look like an orc to me."
#define GOSSIP_SLB2 "And the other half?"
#define GOSSIP_SLB3 "I have heard of your kind, but I never thought to see the day when I would meet a half-breed."
#define GOSSIP_SLB4 "My apologies. I did not mean to offend. I am here on behalf of my people."
#define GOSSIP_SLB5 "My people ask that you pull back your Boulderfist ogres and cease all attacks on our territories. In return, we will also pull back our forces."
#define GOSSIP_SLB6 "We will fight you until the end, then, Lantresor. We will not stand idly by as you pillage our towns and kill our people."
#define GOSSIP_SLB7 "What do I need to do?"

bool GossipHello_npc_lantresor_of_the_blade(Player *player, Creature *creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu( creature->GetGUID() );

    if (player->GetQuestStatus(10107) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(10108) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HLB, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(9361, creature->GetGUID());

    return true;
}

bool GossipSelect_npc_lantresor_of_the_blade(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SLB1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(9362, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SLB2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(9363, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SLB3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            player->SEND_GOSSIP_MENU(9364, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SLB4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            player->SEND_GOSSIP_MENU(9365, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SLB5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
            player->SEND_GOSSIP_MENU(9366, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SLB6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
            player->SEND_GOSSIP_MENU(9367, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+6:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SLB7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            player->SEND_GOSSIP_MENU(9368, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+7:
            player->SEND_GOSSIP_MENU(9369, creature->GetGUID());
            if (player->GetQuestStatus(10107) == QUEST_STATUS_INCOMPLETE)
                player->AreaExploredOrEventHappens(10107);
            if (player->GetQuestStatus(10108) == QUEST_STATUS_INCOMPLETE)
                player->AreaExploredOrEventHappens(10108);
            break;
    }
    return true;
}

/*######
## npc_creditmarker_visist_with_ancestors
######*/

struct npc_creditmarker_visit_with_ancestorsAI : public ScriptedAI
{
    npc_creditmarker_visit_with_ancestorsAI(Creature* creature) : ScriptedAI(creature) {}

    void Reset() {}

    void MoveInLineOfSight(Unit *who)
    {
        if(!who)
            return;

        if(who->GetTypeId() == TYPEID_PLAYER)
        {
            if(((Player*)who)->GetQuestStatus(10085) == QUEST_STATUS_INCOMPLETE)
            {
                uint32 creditMarkerId = me->GetEntry();
                if((creditMarkerId >= 18840) && (creditMarkerId <= 18843))
                {
                    // 18840: Sunspring, 18841: Laughing, 18842: Garadar, 18843: Bleeding
                    if(!((Player*)who)->GetReqKillOrCastCurrentCount(10085, creditMarkerId))
                        ((Player*)who)->KilledMonster(creditMarkerId, me->GetGUID());
                }
            }
        }
    }
};

CreatureAI* GetAI_npc_creditmarker_visit_with_ancestors(Creature *creature)
{
    return new npc_creditmarker_visit_with_ancestorsAI (creature);
}

/*######
## mob_sparrowhawk
######*/

#define SPELL_SPARROWHAWK_NET 39810
#define SPELL_ITEM_CAPTIVE_SPARROWHAWK 39812

struct mob_sparrowhawkAI : public ScriptedAI
{

    mob_sparrowhawkAI(Creature *creature) : ScriptedAI(creature) {}

    uint32 Check_Timer;
    uint64 PlayerGUID;
    bool fleeing;

    void Reset()
    {
        me->RemoveAurasDueToSpell(SPELL_SPARROWHAWK_NET);
        Check_Timer = 1000;
        PlayerGUID = 0;
        fleeing = false;
    }
    void AttackStart(Unit *who)
    {
        if(PlayerGUID)
            return;

        ScriptedAI::AttackStart(who);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if(!who || PlayerGUID)
            return;

        if(!PlayerGUID && who->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(((Player *)who), 30) && ((Player *)who)->GetQuestStatus(10987) == QUEST_STATUS_INCOMPLETE)
        {
            PlayerGUID = who->GetGUID();
            return;
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(Check_Timer < diff)
        {
            if(PlayerGUID)
            {
                if(fleeing && me->GetMotionMaster()->GetCurrentMovementGeneratorType() != FLEEING_MOTION_TYPE)
                    fleeing = false;

                Player *player = (Player *)Unit::GetUnit((*me), PlayerGUID);
                if(player && me->IsWithinDistInMap(player, 30))
                {
                    if(!fleeing)
                    {
                        me->DeleteThreatList();
                        me->GetMotionMaster()->MoveFleeing(player);
                        fleeing = true;
                    }
                }
                else if(fleeing)
                {
                    me->GetMotionMaster()->MovementExpired(false);
                    PlayerGUID = 0;
                    fleeing = false;
                }
            }
            Check_Timer = 1000;
        } else Check_Timer -= diff;

        if (PlayerGUID)
            return;

        ScriptedAI::UpdateAI(diff);
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (caster->GetTypeId() == TYPEID_PLAYER)
        {
            if(spell->Id == SPELL_SPARROWHAWK_NET && ((Player*)caster)->GetQuestStatus(10987) == QUEST_STATUS_INCOMPLETE)
            {
                me->CastSpell(caster, SPELL_ITEM_CAPTIVE_SPARROWHAWK, true);
                me->DealDamage(me, me->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
            }
        }
        return;
    }
};

CreatureAI* GetAI_mob_sparrowhawk(Creature *creature)
{
    return new mob_sparrowhawkAI (creature);
}

/*########
## Quests: HELP!, Corki's Gone Missing Again!, Cho'war the Pillager
########*/

enum CorkiCage
{
    QUEST_HELP1            = 9923, // HELP!
    NPC_CORKI_CAPITIVE1    = 18445,
    GO_CORKI_CAGE1         = 182349,

    QUEST_HELP2            = 9924, // Corki's Gone Missing Again!
    NPC_CORKI_CAPITIVE2    = 20812,
    GO_CORKI_CAGE2         = 182350,

    QUEST_HELP3            = 9955, // Cho'war the Pillager
    NPC_CORKI_CAPITIVE3    = 18369,
    GO_CORKI_CAGE3         = 182521,

    SAY_THANKS             = -1900133,
    SAY_KORKI2             = -1900134,
    SAY_KORKI3             = -1900135,
    SAY_KORKI4             = -1900136,
    SAY_KORKI5             = -1900137,
    SAY_KORKI6             = -1900138,
    SAY_THANKS1            = -1900139
};



struct npc_corki_capitiveAI : public ScriptedAI
{
    npc_corki_capitiveAI(Creature *creature) : ScriptedAI(creature){}

    uint64 PlayerGUID;

    void Reset()
    {
        PlayerGUID = 0;
        me->SetWalk(false);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER && ((Player *)who)->GetTeam() == ALLIANCE && me->IsWithinDistInMap(((Player *)who), 20.0f))
        {
            if (PlayerGUID == who->GetGUID())
            {
                return;
            }
            else PlayerGUID = 0;

            switch (urand(0,4))
            {
                case 0:
                    DoScriptText(SAY_KORKI2, me);
                    break;
                case 1: 
                    DoScriptText(SAY_KORKI3, me);
                    break;
                case 2:
                    DoScriptText(SAY_KORKI4, me);
                    break;
                case 3:
                    DoScriptText(SAY_KORKI5, me);
                    break;
                case 4:
                    DoScriptText(SAY_KORKI6, me);
                    break;
            }

            PlayerGUID = who->GetGUID();
        }
    }

    void MovementInform(uint32 MotionType, uint32 i)
    {
        if (MotionType == POINT_MOTION_TYPE)
            me->ForcedDespawn();
    }
};

CreatureAI* GetAI_npc_corki_capitiveAI(Creature* creature)
{
    return new npc_corki_capitiveAI(creature);
}

bool go_corki_cage(Player* player, GameObject* go)
{
   Creature* Creature = NULL;
    switch(go->GetEntry())
    {
        case GO_CORKI_CAGE1:
            if(player->GetQuestStatus(QUEST_HELP1) == QUEST_STATUS_INCOMPLETE)
                Creature = GetClosestCreatureWithEntry(go, NPC_CORKI_CAPITIVE1, 5.0f);
            break;
        case GO_CORKI_CAGE2:
            if(player->GetQuestStatus(QUEST_HELP2) == QUEST_STATUS_INCOMPLETE)
                Creature = GetClosestCreatureWithEntry(go, NPC_CORKI_CAPITIVE2, 5.0f);
            break;
        case GO_CORKI_CAGE3:
            if(player->GetQuestStatus(QUEST_HELP3) == QUEST_STATUS_INCOMPLETE)
                Creature = GetClosestCreatureWithEntry(go, NPC_CORKI_CAPITIVE3, 5.0f);
            break;
    }
    if(Creature)
    {
        switch (Creature->GetEntry())
        {
            case NPC_CORKI_CAPITIVE1:
                DoScriptText(SAY_THANKS, Creature, player);
                Creature->GetMotionMaster()->Clear();
                Creature->GetMotionMaster()->MovePoint(0, -2534.01f, 6269.02f, 17.14f);
                break;
            case NPC_CORKI_CAPITIVE2:
                DoScriptText(SAY_THANKS1, Creature, player);
                Creature->GetMotionMaster()->Clear();
                Creature->GetMotionMaster()->MovePoint(0, -1000.26f, 8113.16f, -95.85f);
                break;
            case NPC_CORKI_CAPITIVE3:
                DoScriptText(SAY_THANKS, Creature, player);
                Creature->GetMotionMaster()->Clear();
                Creature->GetMotionMaster()->MovePoint(0, -897.06f, 8688.03f, 170.47f);
                break;
        }
        player->KilledMonster(Creature->GetEntry(), Creature->GetGUID());
        return false;
    }
    return true;
}

/*#####
## npc_nagrand_captive
#####*/

enum eNagrandCaptive
{
    SAY_MAG_START               = -1000482,
    SAY_MAG_NO_ESCAPE           = -1000483,
    SAY_MAG_MORE                = -1000484,
    SAY_MAG_MORE_REPLY          = -1000485,
    SAY_MAG_LIGHTNING           = -1000486,
    SAY_MAG_SHOCK               = -1000487,
    SAY_MAG_COMPLETE            = -1000488,
    SAY_KUR_COMPLETE            = -1900132,

    SPELL_CHAIN_LIGHTNING       = 16006,
    SPELL_EARTHBIND_TOTEM       = 15786,
    SPELL_FROST_SHOCK           = 12548,
    SPELL_HEALING_WAVE          = 12491,

    QUEST_TOTEM_KARDASH_H       = 9868,
    QUEST_TOTEM_KARDASH_A       = 9879,

    NPC_KUR_CAPTIVE             = 18209,
    NPC_MAG_CAPTIVE             = 18210,
    NPC_MURK_RAIDER             = 18203,
    NPC_MURK_BRUTE              = 18211,
    NPC_MURK_SCAVENGER          = 18207,
    NPC_MURK_PUTRIFIER          = 18202
};

static float AmbushAH[]= {-1568.805786, 8533.873047, 1.958};
static float AmbushAA[]= {-1517.302246, 8439.866211, -4.035};
static float AmbushB[]= {-1442.524780, 8500.364258, 6.381};

struct npc_nagrand_captiveAI : public npc_escortAI
{
    npc_nagrand_captiveAI(Creature* creature) : npc_escortAI(creature) { Reset(); }

    uint32 ChainLightningTimer;
    uint32 HealTimer;
    uint32 FrostShockTimer;;

    void Reset()
    {
        ChainLightningTimer = 1000;
        HealTimer = 0;
        FrostShockTimer = 6000;
    }

    void EnterCombat(Unit* /*who*/)
    {
        DoCast(me, SPELL_EARTHBIND_TOTEM, false);
    }

    void WaypointReached(uint32 i)
    {
        switch(i)
        {
            case 7:
                if (me->GetEntry() == NPC_KUR_CAPTIVE)
                {
                    DoScriptText(SAY_MAG_MORE, me);

                    if (Creature* pTemp = me->SummonCreature(NPC_MURK_PUTRIFIER, AmbushB[0], AmbushB[1], AmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000))
                        DoScriptText(SAY_MAG_MORE_REPLY, pTemp);

                    me->SummonCreature(NPC_MURK_PUTRIFIER, AmbushB[0]-2.5f, AmbushB[1]-2.5f, AmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_MURK_SCAVENGER, AmbushB[0]+2.5f, AmbushB[1]+2.5f, AmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_MURK_SCAVENGER, AmbushB[0]+2.5f, AmbushB[1]-2.5f, AmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                }
                break;
             case 10:
                if (me->GetEntry() == NPC_MAG_CAPTIVE)
                {
                    DoScriptText(SAY_MAG_MORE, me);

                    if (Creature* pTemp = me->SummonCreature(NPC_MURK_PUTRIFIER, AmbushB[0], AmbushB[1], AmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000))
                        DoScriptText(SAY_MAG_MORE_REPLY, pTemp);

                    me->SummonCreature(NPC_MURK_PUTRIFIER, AmbushB[0]-2.5f, AmbushB[1]-2.5f, AmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_MURK_SCAVENGER, AmbushB[0]+2.5f, AmbushB[1]+2.5f, AmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_MURK_SCAVENGER, AmbushB[0]+2.5f, AmbushB[1]-2.5f, AmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                }
                break;
            case 16:
                switch (me->GetEntry())
                {
                    case NPC_MAG_CAPTIVE:
                        DoScriptText(SAY_MAG_COMPLETE, me);
                        break;
                    case NPC_KUR_CAPTIVE:
                        DoScriptText(SAY_KUR_COMPLETE, me);
                        break;
                }

                if (Player* player = GetPlayerForEscort())
                    player->GroupEventHappens(player->GetTeam() == ALLIANCE ? QUEST_TOTEM_KARDASH_A : QUEST_TOTEM_KARDASH_H, me);

                SetRun();
                break;
        }
    }

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == NPC_MURK_BRUTE)
            DoScriptText(SAY_MAG_NO_ESCAPE, summoned);

        if (summoned->isTotem())
            return;

        summoned->SetWalk(false);
        summoned->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
        summoned->AI()->AttackStart(me);

    }

    void SpellHitTarget(Unit* /*target*/, const SpellEntry* spell)
    {
        if (spell->Id == SPELL_CHAIN_LIGHTNING)
        {
            if (rand()%10)
                return;

            DoScriptText(SAY_MAG_LIGHTNING, me);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        npc_escortAI::UpdateAI(diff);
        if (!me->getVictim())
            return;

        if (ChainLightningTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_CHAIN_LIGHTNING);
            ChainLightningTimer = urand(7000, 14000);
        }
        else
            ChainLightningTimer -= diff;

        if (me->GetHealth()*100 < me->GetMaxHealth()*30)
        {
            if (HealTimer <= diff)
            {
                DoCast(me, SPELL_HEALING_WAVE);
                HealTimer = 5000;
            }
            else
                HealTimer -= diff;
        }

        if (FrostShockTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_FROST_SHOCK);
            FrostShockTimer = urand(7500, 15000);
        }
        else
            FrostShockTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

bool QuestAccept_npc_nagrand_captive(Player* player, Creature* creature, const Quest* quest)
{
    switch (quest->GetQuestId())
    {
        case QUEST_TOTEM_KARDASH_H:
            if (npc_nagrand_captiveAI* EscortAI = dynamic_cast<npc_nagrand_captiveAI*>(creature->AI()))
            {
                creature->SetStandState(UNIT_STAND_STATE_STAND);
                creature->setFaction(232);

                EscortAI->Start(true, false, player->GetGUID(), quest);

                DoScriptText(SAY_MAG_START, creature);

                creature->SummonCreature(NPC_MURK_RAIDER, AmbushAH[0]+2.5f, AmbushAH[1]-2.5f, AmbushAH[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_MURK_PUTRIFIER, AmbushAH[0]-2.5f, AmbushAH[1]+2.5f, AmbushAH[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_MURK_BRUTE, AmbushAH[0], AmbushAH[1], AmbushAH[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            }
            break;
        case QUEST_TOTEM_KARDASH_A:
            if (npc_nagrand_captiveAI* EscortAI = dynamic_cast<npc_nagrand_captiveAI*>(creature->AI()))
            {
                creature->SetStandState(UNIT_STAND_STATE_STAND);
                creature->setFaction(231);

                EscortAI->Start(true, false, player->GetGUID(), quest);

                DoScriptText(SAY_MAG_START, creature);

                creature->SummonCreature(NPC_MURK_RAIDER, AmbushAA[0]+2.5f, AmbushAA[1]-2.5f, AmbushAA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_MURK_PUTRIFIER, AmbushAA[0]-2.5f, AmbushAA[1]+2.5f, AmbushAA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_MURK_BRUTE, AmbushAA[0], AmbushAA[1], AmbushAA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            }
            break;
        default:
            return false;
    }

    return true;
}

CreatureAI* GetAI_npc_nagrand_captive(Creature* creature)
{
    return new npc_nagrand_captiveAI(creature);
}

/*####
#  npc_multiphase_disurbanceAI
####*/

#define SPELL_TAKE_MULTIPHASE_READING   46281

struct npc_multiphase_disurbanceAI : public ScriptedAI
{
    npc_multiphase_disurbanceAI(Creature *creature) : ScriptedAI(creature){}

    uint32 despawnTimer;

    void Reset()
    {
        despawnTimer = 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (despawnTimer)
        {
            if (despawnTimer <= diff)
            {
                me->ForcedDespawn();
                despawnTimer = 0;
            }
            else
                despawnTimer -= diff;
        }
    }

    void SpellHit(Unit * /*caster*/, const SpellEntry * spell)
    {
        if (spell && spell->Id == SPELL_TAKE_MULTIPHASE_READING)
            despawnTimer = 2500;
    }
};

CreatureAI* GetAI_npc_multiphase_disturbance(Creature* creature)
{
    return new npc_multiphase_disurbanceAI(creature);
}

/*#####
## go_maghar_prison & npc_maghar_prisoner
#####*/

enum
{
    QUEST_SURVIVORS       = 9948,
    NPC_MPRISONER         = 18428,

    SAY_MAG_PRISONER1     = -1900148,
    SAY_MAG_PRISONER2     = -1900149,
    SAY_MAG_PRISONER3     = -1900150,
    SAY_MAG_PRISONER4     = -1900151,
    SAYT_MAG_PRISONER1    = -1900152,
    SAYT_MAG_PRISONER2    = -1900153,
    SAYT_MAG_PRISONER3    = -1900154,
    SAYT_MAG_PRISONER4    = -1900155
};

struct WP
{
    float x, y, z;
};

static WP M[]=
{
    {-1076.000f, 8945.270f, 101.891f},
    {-782.796f, 8875.171f, 181.745f},
    {-670.298f, 8810.587f, 196.057f},
    {-710.969f, 8763.471f, 186.513f},
    {-865.144f, 8713.610f, 248.041f},
    {-847.285f, 8722.406f, 177.255f},
    {-897.005f, 8689.280f, 170.527},
    {-838.047f, 8691.124f, 180.549f}
};

struct npc_maghar_prisonerAI : public ScriptedAI
{
    npc_maghar_prisonerAI(Creature *creature) : ScriptedAI(creature) {}

    uint64 PlayerGUID;

    void Reset()
    {
        PlayerGUID = 0;
        me->SetWalk(false);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER && ((Player *)who)->GetTeam() == HORDE && me->IsWithinDistInMap(((Player *)who), 20.0f))
        {
            if (PlayerGUID == who->GetGUID())
            {
                return;
            }
            else PlayerGUID = 0;

            switch (urand(0,3))
            {
                case 0:
                    DoScriptText(SAY_MAG_PRISONER1, me);
                    break;
                case 1:
                    DoScriptText(SAY_MAG_PRISONER2, me);
                    break;
                case 2:
                    DoScriptText(SAY_MAG_PRISONER3, me);
                    break;
                case 3:
                    DoScriptText(SAY_MAG_PRISONER4, me);
                    break;
            }
            PlayerGUID = who->GetGUID();
        }
    }

    uint32 WaypointID()
    {
        switch (me->GetGUIDLow())
        {
            case 65828:
            case 65826:
            case 65827:
            case 65825:
            case 65829:
                return 1;
                break;
            case 65823:
            case 65824:
            case 65821:
            case 65815:
                return 2;
                break;
            case 65814:
                return 3;
                break;
            case 65813:
                return 4;
                break;
            case 65819:
            case 65820:
                return 5;
                break;
            case 65817:
            case 65822:
            case 65816:
                return 6;
                break;
            case 65831:
            case 65832:
            case 65830:
                return 7;
                break;
            case 65818:
                return 8;
                break;
            default:
                return 1;
                break;
        }
    }

    void StartRun(Player* player)
    {
        switch (WaypointID())
        {
            case 1:
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, M[0].x, M[0].y, M[0].z);
                break;
            case 2:
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, M[1].x, M[1].y, M[1].z);
                break;
            case 3:
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, M[2].x, M[2].y, M[2].z);
                break;
            case 4:
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, M[3].x, M[3].y, M[3].z);
                break;
            case 5:
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, M[4].x, M[4].y, M[4].z);
                break;
            case 6:
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, M[5].x, M[5].y, M[5].z);
                break;
            case 7:
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, M[6].x, M[6].y, M[6].z);
                break;
            case 8:
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, M[7].x, M[7].y, M[7].z);
                break;
        }
        return;
    }

    void MovementInform(uint32 MotionType, uint32 i)
    {
        if (MotionType == POINT_MOTION_TYPE)
        {
            me->ForcedDespawn();
        }
    }
};

CreatureAI* GetAI_npc_maghar_prisoner(Creature* creature)
{
    return new npc_maghar_prisonerAI(creature);
}

bool go_maghar_prison(Player* player, GameObject* go)
{
    Creature* Prisoner = NULL;

    if (player->GetQuestStatus(QUEST_SURVIVORS) == QUEST_STATUS_INCOMPLETE)
    {
        Prisoner = GetClosestCreatureWithEntry(go, NPC_MPRISONER, 5.0f);

        if(Prisoner)
        {
            player->KilledMonster(NPC_MPRISONER, Prisoner->GetGUID());

            switch (urand(0,3))
            {
                case 0:
                    DoScriptText(SAYT_MAG_PRISONER1, Prisoner, player);
                    break;
                case 1:
                    DoScriptText(SAYT_MAG_PRISONER2, Prisoner, player);
                    break;
                case 2:
                    DoScriptText(SAYT_MAG_PRISONER3, Prisoner, player);
                    break;
                case 3:
                    DoScriptText(SAYT_MAG_PRISONER4, Prisoner, player);
                    break;
            }

            if (npc_maghar_prisonerAI* scriptedAI = CAST_AI(npc_maghar_prisonerAI, Prisoner->AI()))
            {
                scriptedAI->StartRun(player);
            }

            return false;
        }
    }
    return true;
};

/*#####
## npc_warmaul_pyre Q 9932
#####*/

enum
{
    NPC_SABOTEUR         = 18396,
    NPC_CORPSE           = 18397,

    SAY_SABOTEUR1        = -1900192,
    SAY_SABOTEUR2        = -1900193,
    SAY_SABOTEUR3        = -1900194,
    SAY_SABOTEUR4        = -1900195,
    SAY_SABOTEUR5        = -1900196,
    SAY_SABOTEUR6        = -1900197,
    SAY_SABOTEUR7        = -1900198,
    SAY_SABOTEUR8        = -1900199,
    SAY_SABOTEUR9        = -1900200,
    SAY_SABOTEUR10       = -1900201
};

struct Move
{
    float x, y, z;
};

static Move Z[]=
{
    {-885.76f, 7717.75f, 35.24f},
    {-882.96f, 7723.00f, 34.78f},
    {-871.40f, 7724.87f, 33.36f},
    {-873.16F, 7727.59f, 33.35f},
    {-855.66f, 7732.36f, 33.42f},
    {-855.44f, 7735.44f, 33.44f},
    {-843.39f, 7726.59f, 34.50f},
    {-840.20f, 7728.34f, 34.39f},
    {-848.31f, 7714.37f, 34.42f},
    {-845.44f, 7710.70f, 35.05f},
    {-859.99f, 7713.96f, 35.94f},
    {-859.70f, 7710.61f, 36.68f},
    {-873.74f, 7720.35f, 33.98f},
    {-875.16f, 7717.15f, 34.39f}
};

struct npc_warmaul_pyreAI : public ScriptedAI
{
    npc_warmaul_pyreAI(Creature* creature) : ScriptedAI(creature) {}

    bool Event;

    std::list<Creature*> SaboteurList;
    ObjectGuid PlayerGUID;
    uint32 StepsTimer;
    uint32 Steps;
    uint32 CorpseCount;
    uint32 MoveCount;

    void Reset()
    {
        Event = false;
        PlayerGUID = 0;
        StepsTimer =0;
        Steps = 0;
        CorpseCount = 0;
        MoveCount = 1;
        me->SetVisibility(VISIBILITY_OFF);
    }

    void EnterCombat(Unit *who){}

    void DoSpawn()
    {
        me->SummonCreature(NPC_SABOTEUR, Z[0].x, Z[0].y, Z[0].z, 0.6f, TEMPSUMMON_CORPSE_DESPAWN, 60000);
        me->SummonCreature(NPC_SABOTEUR, Z[1].x, Z[1].y, Z[1].z, 3.8f, TEMPSUMMON_CORPSE_DESPAWN, 60000);
    }

    void DoSummon()
    {
        ++CorpseCount;

        uint32 Time = 100000 - (10000 *CorpseCount);

        if (Creature* Saboteur = GetSaboteur(2))
        {
            Saboteur->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
            me->SummonCreature(NPC_CORPSE, Saboteur->GetPositionX(), Saboteur->GetPositionY(), Saboteur->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, Time);
        }

        if (Creature* Saboteur = GetSaboteur(1))
        {
            Saboteur->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
            me->SummonCreature(NPC_CORPSE, Saboteur->GetPositionX(), Saboteur->GetPositionY(), Saboteur->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, Time);
        }
    }

    void Move()
    {
        ++MoveCount;
        if (Creature* Saboteur = GetSaboteur(2))
            Saboteur->GetMotionMaster()->MovePoint(0, Z[MoveCount].x, Z[MoveCount].y, Z[MoveCount].z);

        ++MoveCount;
        if (Creature* Saboteur = GetSaboteur(1))
            Saboteur->GetMotionMaster()->MovePoint(0, Z[MoveCount].x, Z[MoveCount].y, Z[MoveCount].z);
    }

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == NPC_SABOTEUR)
            summoned->SetWalk(true);
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
        {
            if (((Player*)who)->GetQuestStatus(9932) == QUEST_STATUS_INCOMPLETE)
            {
                if (me->IsWithinDistInMap(((Player *)who), 3.0f))
                {
                    PlayerGUID = who->GetObjectGuid();
                    Event = true;                     // this is not the best way to start the event :)
                }
            }
        }
    }

    void Started()
    {
        SaboteurList.clear();

        Looking4group::AllCreaturesOfEntryInRange check(me, NPC_SABOTEUR, 25.0f);
        Looking4group::ObjectListSearcher<Creature, Looking4group::AllCreaturesOfEntryInRange> searcher(SaboteurList, check);
        Cell::VisitGridObjects(me, searcher, 25.0f);
    }

    Creature* GetSaboteur(uint8 ListNum)
    {
        if (!SaboteurList.empty())
        {
            uint8 Num = 1;

            for (std::list<Creature*>::iterator itr = SaboteurList.begin(); itr != SaboteurList.end(); ++itr)
            {
                if (ListNum && ListNum != Num)
                {
                    ++Num;
                    continue;
                }

                if ((*itr)->isAlive() && (*itr)->IsWithinDistInMap(me, 25.0f))
                    return (*itr);
            }
        }

        return NULL;
    }

    uint32 NextStep(uint32 Steps)
    {
        switch(Steps)
        {
            case 1:DoSpawn();
                return 4000;
            case 2:Started();
                return 2900;
            case 3:if (Creature* Saboteur = GetSaboteur(2))
                       DoScriptText(SAY_SABOTEUR1, Saboteur);
                return 5000;
            case 4:if (Creature* Saboteur = GetSaboteur(1))
                       DoScriptText(SAY_SABOTEUR2, Saboteur);
                return 5000;
            case 5:if (Creature* Saboteur = GetSaboteur(2))
                       DoScriptText(SAY_SABOTEUR3, Saboteur);
                return 5000;
            case 6:if (Creature* Saboteur = GetSaboteur(1))
                       DoScriptText(SAY_SABOTEUR4, Saboteur);
                return 4000;
            case 7:Move();
                return 6000;
            case 8:DoSummon();
                return 2000;
            case 9:if (Creature* Saboteur = GetSaboteur(2))
                       DoScriptText(SAY_SABOTEUR5, Saboteur);
                return 2000;
            case 10:Move();
                return 7000;
            case 11:DoSummon();
                return 2000;
            case 12:if (Creature* Saboteur = GetSaboteur(1))
                        DoScriptText(SAY_SABOTEUR6, Saboteur);
                return 2000;
            case 13:Move();
                return 7000;
            case 14:DoSummon();
                return 2000;
            case 15:if (Creature* Saboteur = GetSaboteur(2))
                        DoScriptText(SAY_SABOTEUR7, Saboteur);
                return 3000;
            case 16:if (Creature* Saboteur = GetSaboteur(1))
                        DoScriptText(SAY_SABOTEUR7, Saboteur);
                return 2000;
            case 17:Move();
                return 7000;
            case 18:DoSummon();
                return 2000;     
            case 19:if (Creature* Saboteur = GetSaboteur(2))
                        DoScriptText(SAY_SABOTEUR8, Saboteur);
                return 3000;           
            case 21:if (Creature* Saboteur = GetSaboteur(1))
                        DoScriptText(SAY_SABOTEUR9, Saboteur);
                return 2000; 
            case 22:Move();
                return 7000;
            case 23:DoSummon();
                return 2000;
            case 24:if (Creature* Saboteur = GetSaboteur(2))
                        DoScriptText(SAY_SABOTEUR10, Saboteur);
                return 2000; 
            case 25:Move();
                return 7000;
            case 26:if (Player* player = me->GetPlayer(PlayerGUID))
                    {
                        float Radius = 15.0f;
                        if (me->IsWithinDistInMap(player, Radius))
                            ((Player*)player)->KilledMonster(18395, me->GetObjectGuid());
                    }
                return 2000;
            case 27:Reset();
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
    }
};

CreatureAI* GetAI_npc_warmaul_pyre(Creature *creature)
{
    return new npc_warmaul_pyreAI (creature);
}

/*######
## npc_fel_cannon
######*/

enum
{
    NPC_CANNON_FEAR           = 19210,
    NPC_FEAR_TARGET           = 19211,
    NPC_CANNON_HATE           = 19067,
    NPC_HATE_TARGET           = 19212,

    SPELL_BOLT                = 40109,
    SPELL_HATE                = 33531,
    SPELL_FEAR                = 33532,

    OBJECT_LARGE_FIRE         = 187084,
};

struct npc_fel_cannonAI : public ScriptedAI
{
    npc_fel_cannonAI(Creature *creature) : ScriptedAI(creature) {}

    void Reset(){}

    void EnterCombat(Unit *who){}

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if(spell->Id == SPELL_HATE && me->GetEntry() == NPC_CANNON_HATE)
        {
            if (Creature* Target = GetClosestCreatureWithEntry(me, NPC_HATE_TARGET, 85.5f))
            {
                me->SetFacingToObject(Target);
                DoCast(Target, SPELL_BOLT);
                me->SummonGameObject(OBJECT_LARGE_FIRE, Target->GetPositionX(), Target->GetPositionY(), Target->GetPositionZ(), Target->GetOrientation(), 0, 0, 0, 0, 30);
            }
        }

        if(spell->Id == SPELL_FEAR && me->GetEntry() == NPC_CANNON_FEAR)
        {
            if (Creature* Target = GetClosestCreatureWithEntry(me, NPC_FEAR_TARGET, 85.5f))
            {
                me->SetFacingToObject(Target);
                DoCast(Target, SPELL_BOLT);
                me->SummonGameObject(OBJECT_LARGE_FIRE, Target->GetPositionX(), Target->GetPositionY(), Target->GetPositionZ(), Target->GetOrientation(), 0, 0, 0, 0, 30);
            }
        }
        return;
    }
};
CreatureAI* GetAI_npc_fel_cannon(Creature *creature)
{
    return new npc_fel_cannonAI (creature);
}

enum Spells
{
    SPELL_feuer                = 29948,
    Spell_feuerimmunity        = 7942
};

struct npc_erzuernte_FeuerseeleAI : public ScriptedAI
{
    npc_erzuernte_FeuerseeleAI(Creature *c) : ScriptedAI(c)
        { }

        uint32 t_feuer;

        void Reset()
        {
            t_feuer = 20000;
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->CastSpell(me, Spell_feuerimmunity, false);
            me->AddAura(SPELL_feuer, me->getVictim());
        }
        void UpdateAI (const uint32 diff)
        {
            if (!UpdateVictim())
                return;
            if (t_feuer <= diff)
            {
                me->AddAura(SPELL_feuer, me->getVictim());
                t_feuer = 20000;
            } else t_feuer -= diff;

            DoMeleeAttackIfReady(); 
        }
};

CreatureAI* GetAI_npc_erzuernte_Feuerseele(Creature *creature)
{
    return new npc_erzuernte_FeuerseeleAI(creature);
}
enum FrostSpells
{
    SPELL_wasserball        = 34425,
    Spell_frostimmunity        = 7940
};

struct npc_WasserelementarAI : public ScriptedAI
{
    npc_WasserelementarAI(Creature *c) : ScriptedAI(c)
        { }
        uint32 t_Wasser;
        
        void Reset()
        {
            t_Wasser = 4000;
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->CastSpell(me, Spell_frostimmunity, false);
            me->CastSpell(me->getVictim(), SPELL_wasserball, false);
        }
        void UpdateAI (const uint32 diff)
        {
            if (!UpdateVictim())
                return;
            if (t_Wasser <= diff)
            {
                me->CastSpell(me->getVictim(), SPELL_wasserball, false);
                t_Wasser = 4000;
            } else t_Wasser -= diff;
            
            DoMeleeAttackIfReady(); 
        }
};

CreatureAI* GetAI_npc_Wasserelementar(Creature *creature)
{
    return new npc_WasserelementarAI(creature);
}


void AddSC_nagrand()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="mob_shattered_rumbler";
    newscript->GetAI = &GetAI_mob_shattered_rumbler;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_ancient_orc_ancestor";
    newscript->GetAI = &GetAI_mob_ancient_orc_ancestor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_lump";
    newscript->GetAI = &GetAI_mob_lump;
    newscript->pGossipHello =  &GossipHello_mob_lump;
    newscript->pGossipSelect = &GossipSelect_mob_lump;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_altruis_the_sufferer";
    newscript->pGossipHello =  &GossipHello_npc_altruis_the_sufferer;
    newscript->pGossipSelect = &GossipSelect_npc_altruis_the_sufferer;
    newscript->pQuestAcceptNPC =  &QuestAccept_npc_altruis_the_sufferer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_greatmother_geyah";
    newscript->pGossipHello =  &GossipHello_npc_greatmother_geyah;
    newscript->pGossipSelect = &GossipSelect_npc_greatmother_geyah;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_lantresor_of_the_blade";
    newscript->pGossipHello =  &GossipHello_npc_lantresor_of_the_blade;
    newscript->pGossipSelect = &GossipSelect_npc_lantresor_of_the_blade;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_creditmarker_visit_with_ancestors";
    newscript->GetAI = &GetAI_npc_creditmarker_visit_with_ancestors;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_sparrowhawk";
    newscript->GetAI = &GetAI_mob_sparrowhawk;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_corki_capitive";
    newscript->GetAI = &GetAI_npc_corki_capitiveAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="go_corki_cage";
    newscript->pGOUse = &go_corki_cage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_nagrand_captive";
    newscript->GetAI = &GetAI_npc_nagrand_captive;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_nagrand_captive;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_multiphase_disturbance";
    newscript->GetAI = &GetAI_npc_multiphase_disturbance;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_maghar_prison";
    newscript->pGOUse =  &go_maghar_prison;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_maghar_prisoner";
    newscript->GetAI = &GetAI_npc_maghar_prisoner;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_warmaul_pyre";
    newscript->GetAI = &GetAI_npc_warmaul_pyre;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_fel_cannon";
    newscript->GetAI = &GetAI_npc_fel_cannon;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_erzuernte_Feuerseele";
    newscript->GetAI = &GetAI_npc_erzuernte_Feuerseele;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_Wasserelementar";
    newscript->GetAI = &GetAI_npc_Wasserelementar;
    newscript->RegisterSelf();
}