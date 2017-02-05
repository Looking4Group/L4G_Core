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
SDName: Shadowmoon_Valley
SD%Complete: 100
SDComment: Quest support: 10519, 10583, 10601, 10814, 10804, 10854, 10458, 10481, 10480, 11082, 10781, 10451. Vendor Drake Dealer Hurlunk.
SDCategory: Shadowmoon Valley
EndScriptData */

/* ContentData
mob_mature_netherwing_drake
mob_enslaved_netherwing_drake
npc_drake_dealer_hurlunk
npcs_flanis_swiftwing_and_kagrosh
npc_murkblood_overseer
npc_neltharaku
npc_karynaku
npc_oronok_tornheart
npc_overlord_morghor
npc_earthmender_wilda
mob_torloth_the_magnificent
mob_illidari_spawn
npc_lord_illidan_stormrage
go_crystal_prison
npc_enraged_spirit
npc_overlord_orbarokh
npc_thane_yoregar
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"


/*#####
# mob_azaloth
#####*/

#define SPELL_CLEAVE                   40504
#define SPELL_CRIPPLE                  11443
#define SPELL_RAIN_OF_FIRE             38741
#define SPELL_WARSTOMP                 38750
#define SPELL_BANISH                   37833
#define TIME_TO_BANISH                 60000
#define SPELL_VISUAL_BANISH            38722

struct mob_azalothAI : public ScriptedAI
{
    mob_azalothAI(Creature* c) : ScriptedAI(c)   {}

    uint32 cleave_timer;
    uint32 cripple_timer;
    uint32 rain_timer;
    uint32 warstomp_timer;
    uint64 banish_timer;


    void JustRespawned()
    {
        DoCast(m_creature,SPELL_BANISH);
        std::list<Creature*> warlocks = FindAllCreaturesWithEntry(21503, 30.0f);
        for (std::list<Creature*>::iterator itr = warlocks.begin(); itr != warlocks.end(); ++itr)
            (*itr)->CastSpell(me,SPELL_VISUAL_BANISH, false);
    }

    void EnterCombat()
    {
        DoCast(m_creature->getVictim(),SPELL_CRIPPLE);
        banish_timer  = TIME_TO_BANISH;
    }

    void Reset()
    {
        cleave_timer  = 6000;
        cripple_timer = 18000;
        rain_timer    = 15000;
        warstomp_timer= 10000;
        banish_timer  = TIME_TO_BANISH;
    }

    void UpdateAI(const uint32 diff)
    {
        if (banish_timer < diff)
        {
            DoCast(m_creature,SPELL_BANISH);
            banish_timer  = TIME_TO_BANISH;
        }

        std::list<Creature*> warlocks = FindAllCreaturesWithEntry(21503, 20.0f);
        for (std::list<Creature*>::iterator itr = warlocks.begin(); itr != warlocks.end(); ++itr)
        {
            (*itr)->GetMotionMaster()->Clear(false);
            (*itr)->StopMoving();
            (*itr)->CastSpell(me,SPELL_VISUAL_BANISH, false);
        }

        if (!UpdateVictim())
        {
            banish_timer-=diff;
            return;
        }

        //spell cleave
        if (cleave_timer<diff)
        {
            DoCast(m_creature->getVictim(), SPELL_CLEAVE);
            cleave_timer  = 6000;
        }
        else
            cleave_timer-=diff;

        //spell cripple
        if (cripple_timer<diff)
        {
            DoCast(m_creature->getVictim(), SPELL_CRIPPLE);
           cripple_timer = 40000;
        }
        else
            cripple_timer-=diff;

        //spell rain of fire
        if (rain_timer<diff)
        {
            DoCast(m_creature->getVictim(), SPELL_RAIN_OF_FIRE);
            rain_timer    = 15000;
        }
        else
            rain_timer-=diff;

        //spell warstomp
        if (warstomp_timer<diff)
        {
            DoCast(m_creature->getVictim(), SPELL_WARSTOMP);
            warstomp_timer= 10000;
        }
        else
            warstomp_timer-=diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_azaloth(Creature *_creature)
{
    return new mob_azalothAI(_creature);
}


/*#####
# mob_mature_netherwing_drake
#####*/

#define SPELL_PLACE_CARCASS             38439
#define SPELL_JUST_EATEN                38502
#define SPELL_NETHER_BREATH             38467

#define SAY_JUST_EATEN                  -1000222
#define GO_FLAYER_CARCASS               185155

struct mob_mature_netherwing_drakeAI : public npc_escortAI
{
    mob_mature_netherwing_drakeAI(Creature* creature) : npc_escortAI(creature) {}

    uint32 CastTimer;

    void Reset()
    {
        CastTimer = 5000;
    }

    void WaypointReached(uint32 i)
    {
        switch(i)
        {
            case 0:
                if (GameObject* go = GetClosestGameObjectWithEntry(me, GO_FLAYER_CARCASS, INTERACTION_DISTANCE))
                    me->SetFacingToObject(go);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ATTACKUNARMED);
                break;
            case 1:
                DoCast(me, SPELL_JUST_EATEN);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                DoScriptText(SAY_JUST_EATEN, m_creature);
                if (GameObject* go = GetClosestGameObjectWithEntry(me, GO_FLAYER_CARCASS, INTERACTION_DISTANCE))
                    go->Delete();
                if (Player* player = GetPlayerForEscort())
                    player->KilledMonster(22131, m_creature->GetGUID());
                me->GetUnitStateMgr().PushAction(UNIT_ACTION_DOWAYPOINTS);
                break;
        }
    }

     void OnAuraRemove(Aura* aur, bool)
    {
        if(aur->GetId() == SPELL_JUST_EATEN)
            me->setFaction(1824);
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(!caster)
            return;

        if(caster->GetTypeId() == TYPEID_PLAYER && spell->Id == SPELL_PLACE_CARCASS && !me->HasAura(SPELL_JUST_EATEN, 0))
        {
            if (caster->ToPlayer()->GetQuestStatus(10804) == QUEST_STATUS_INCOMPLETE)
            {
                float x, y, z;
                caster->GetNearPoint(x, y, z, me->GetObjectSize());
                AddWaypoint(0, x, y, z, 15000);
                AddWaypoint(1, x+0.1f, y-0.1f, z, 1000);
                me->GetRespawnCoord(x, y, z);
                AddWaypoint(2, x, y, z, 5000);
                ((npc_escortAI*)(me->AI()))->SetClearWaypoints(true);
                ((npc_escortAI*)(me->AI()))->SetDespawnAtEnd(false);
                ((npc_escortAI*)(me->AI()))->SetDespawnAtFar(false);
                me->setFaction(35);
                me->GetUnitStateMgr().DropAction(UNIT_ACTION_DOWAYPOINTS);
                Start(false, true, caster->GetGUID());
            }
        }
    }

    void UpdateEscortAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CastTimer < diff)
        {
            DoCast(me->getVictim(), SPELL_NETHER_BREATH);
            CastTimer = 5000;
        }
        else CastTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_mature_netherwing_drake(Creature* creature)
{
    return new mob_mature_netherwing_drakeAI(creature);
}

/*###
# mob_enslaved_netherwing_drake
####*/

#define FACTION_DEFAULT     62
#define FACTION_FRIENDLY    1840                            // Not sure if this is correct, it was taken off of Mordenai.

#define SPELL_HIT_FORCE_OF_NELTHARAKU   38762
#define SPELL_FORCE_OF_NELTHARAKU       38775

#define CREATURE_DRAGONMAW_SUBJUGATOR   21718
#define CREATURE_ESCAPE_DUMMY           22317

struct mob_enslaved_netherwing_drakeAI : public ScriptedAI
{
    mob_enslaved_netherwing_drakeAI(Creature* c) : ScriptedAI(c)
    {
        PlayerGUID = 0;
        Tapped = false;
    }

    uint64 PlayerGUID;
    uint32 FlyTimer;
    bool Tapped;

    void Reset()
    {
        if(!Tapped)
            m_creature->setFaction(FACTION_DEFAULT);

        FlyTimer = 10000;
        m_creature->SetLevitate(false);
        m_creature->SetVisibility(VISIBILITY_ON);
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(!caster)
            return;

        if(caster->GetTypeId() == TYPEID_PLAYER && spell->Id == SPELL_HIT_FORCE_OF_NELTHARAKU && !Tapped)
        {
            Tapped = true;
            PlayerGUID = caster->GetGUID();

            m_creature->setFaction(FACTION_FRIENDLY);
            DoCast(caster, SPELL_FORCE_OF_NELTHARAKU, true);

            Unit* Dragonmaw = FindCreature(CREATURE_DRAGONMAW_SUBJUGATOR, 50, m_creature);

            if(Dragonmaw)
            {
                m_creature->AddThreat(Dragonmaw, 100000.0f);
                AttackStart(Dragonmaw);
            }

            HostilReference* ref = m_creature->getThreatManager().getOnlineContainer().getReferenceByTarget(caster);
            if(ref)
                ref->removeReference();
        }
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if(type != POINT_MOTION_TYPE)
            return;

        if(id == 1)
        {
            if(PlayerGUID)
            {
                Unit* plr = Unit::GetUnit((*m_creature), PlayerGUID);
                if(plr)
                    DoCast(plr, SPELL_FORCE_OF_NELTHARAKU, true);

                PlayerGUID = 0;
            }
            m_creature->SetVisibility(VISIBILITY_OFF);
            m_creature->SetLevitate(false);
            m_creature->DealDamage(m_creature, m_creature->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            m_creature->RemoveCorpse();
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
        {
            if(Tapped)
                if(FlyTimer < diff)
            {
                Tapped = false;
                if(PlayerGUID)
                {
                    Player* plr = Unit::GetPlayer(PlayerGUID);
                    if(plr && plr->GetQuestStatus(10854) == QUEST_STATUS_INCOMPLETE)
                    {
                        plr->KilledMonster(22316, m_creature->GetGUID());
                        /*
                        float x,y,z;
                        m_creature->GetPosition(x,y,z);

                        float dx,dy,dz;
                        m_creature->GetRandomPoint(x, y, z, 20, dx, dy, dz);
                        dz += 20; // so it's in the air, not ground*/

                        float dx, dy, dz;

                        Unit* EscapeDummy = FindCreature(CREATURE_ESCAPE_DUMMY, 30, m_creature);
                        if(EscapeDummy)
                            EscapeDummy->GetPosition(dx, dy, dz);
                        else
                        {
                            m_creature->GetRandomPoint(m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), 20, dx, dy, dz);
                            dz += 25;
                        }

                        m_creature->SetLevitate(true);
                        m_creature->GetMotionMaster()->MovePoint(1, dx, dy, dz);
                    }
                }
            }else FlyTimer -= diff;
            return;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_enslaved_netherwing_drake(Creature* _Creature)
{
    return new mob_enslaved_netherwing_drakeAI(_Creature);
}

/*#####
# mob_dragonmaw_peon
#####*/

struct mob_dragonmaw_peonAI : public ScriptedAI
{
    mob_dragonmaw_peonAI(Creature* c) : ScriptedAI(c) {}

    uint64 PlayerGUID;
    bool Tapped;
    uint32 PoisonTimer;

    void Reset()
    {
        PlayerGUID = 0;
        Tapped = false;
        PoisonTimer = 0;
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(!caster)
            return;

        if(caster->GetTypeId() == TYPEID_PLAYER && spell->Id == 40468 && !Tapped)
        {
            PlayerGUID = caster->GetGUID();

            Tapped = true;
            float x, y, z;
            caster->GetNearPoint(x, y, z, m_creature->GetObjectSize());

            m_creature->SetWalk(false);
            m_creature->GetMotionMaster()->MovePoint(1, x, y, z);
        }
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if(type != POINT_MOTION_TYPE)
            return;

        if(id)
        {
            m_creature->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_EAT);
            PoisonTimer = 15000;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(PoisonTimer)
            if(PoisonTimer <= diff)
        {
            if(PlayerGUID)
            {
                Player* plr = Unit::GetPlayer(PlayerGUID);
                if(plr && plr->GetQuestStatus(11020) == QUEST_STATUS_INCOMPLETE)
                    plr->KilledMonster(23209, m_creature->GetGUID());
            }
            PoisonTimer = 0;
            m_creature->DealDamage(m_creature, m_creature->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }else PoisonTimer -= diff;

         DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_dragonmaw_peon(Creature* _Creature)
{
    return new mob_dragonmaw_peonAI(_Creature);
}

/*######
## npc_drake_dealer_hurlunk
######*/

bool GossipHello_npc_drake_dealer_hurlunk(Player *player, Creature *_Creature)
{
    if (_Creature->isVendor() && player->GetReputationMgr().GetRank(1015) == REP_EXALTED)
        player->ADD_GOSSIP_ITEM(1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_drake_dealer_hurlunk(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_TRADE)
        player->SEND_VENDORLIST( _Creature->GetGUID() );

    return true;
}

/*######
## npc_flanis_swiftwing_and_kagrosh
######*/

#define GOSSIP_HSK1 "Take Flanis's Pack"
#define GOSSIP_HSK2 "Take Kagrosh's Pack"

bool GossipHello_npcs_flanis_swiftwing_and_kagrosh(Player *player, Creature *_Creature)
{
    if (player->GetQuestStatus(10583) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(30658,1,true))
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HSK1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
    if (player->GetQuestStatus(10601) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(30659,1,true))
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HSK2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npcs_flanis_swiftwing_and_kagrosh(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem( NULL_BAG, NULL_SLOT, dest, 30658, 1, NULL);
        if( msg == EQUIP_ERR_OK )
        {
            player->StoreNewItem( dest, 30658, 1, true);
            player->PlayerTalkClass->ClearMenus();
        }
    }
    if (action == GOSSIP_ACTION_INFO_DEF+2)
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem( NULL_BAG, NULL_SLOT, dest, 30659, 1, NULL);
        if( msg == EQUIP_ERR_OK )
        {
            player->StoreNewItem( dest, 30659, 1, true);
            player->PlayerTalkClass->ClearMenus();
        }
    }
    return true;
}

/*######
## npc_grand_commander_ruusk
######*/

#define QUEST_10577    10577

#define GOSSIP_HGCR "I bring word from Lord Illidan."
#define GOSSIP_SGCR1 "The cipher fragment is to be moved. Have it delivered to Zuluhed."
#define GOSSIP_SGCR2 "Perhaps you did not hear me, Ruusk. I am giving you an order from Illidan himself!"
#define GOSSIP_SGCR3 "Very well. I will return to the Black Temple and notify Lord Illidan of your unwillingness to carry out his wishes. I suggest you make arrangements with your subordinates and let them know that you will soon be leaving this world."
#define GOSSIP_SGCR4 "Do I need to go into all the gory details? I think we are both well aware of what Lord Illidan does with those that would oppose his word. Now, I must be going! Farewell, Ruusk! Forever..."
#define GOSSIP_SGCR5 "Ah, good of you to come around, Ruusk. Thank you and farewell."

bool GossipHello_npc_grand_commander_ruusk(Player *player, Creature *_Creature)
{
    if (player->GetQuestStatus(QUEST_10577) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HGCR, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(10401, _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_grand_commander_ruusk(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SGCR1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(10405, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SGCR2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->SEND_GOSSIP_MENU(10406, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SGCR3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            player->SEND_GOSSIP_MENU(10407, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SGCR4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(10408, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SGCR5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
            player->SEND_GOSSIP_MENU(10409, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+6:
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(QUEST_10577);
            break;
    }
    return true;
}

/*######
## npc_murkblood_overseer
######*/

#define QUEST_11082     11082

#define GOSSIP_HMO "I am here for you, overseer."
#define GOSSIP_SMO1 "How dare you question an overseer of the Dragonmaw!"
#define GOSSIP_SMO2 "Who speaks of me? What are you talking about, broken?"
#define GOSSIP_SMO3 "Continue please."
#define GOSSIP_SMO4 "Who are these bidders?"
#define GOSSIP_SMO5 "Well... yes."

bool GossipHello_npc_murkblood_overseer(Player *player, Creature *_Creature)
{
    if (player->GetQuestStatus(QUEST_11082) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HMO, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(10940, _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_murkblood_overseer(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SMO1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                                                            //correct id not known
            player->SEND_GOSSIP_MENU(10940, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SMO2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
                                                            //correct id not known
            player->SEND_GOSSIP_MENU(10940, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SMO3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
                                                            //correct id not known
            player->SEND_GOSSIP_MENU(10940, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SMO4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
                                                            //correct id not known
            player->SEND_GOSSIP_MENU(10940, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SMO5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
                                                            //correct id not known
            player->SEND_GOSSIP_MENU(10940, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+6:
                                                            //correct id not known
            player->SEND_GOSSIP_MENU(10940, _Creature->GetGUID());
            _Creature->CastSpell(player,41121,false);
            player->AreaExploredOrEventHappens(QUEST_11082);
            break;
    }
    return true;
}

/*######
## npc_neltharaku
######*/

#define GOSSIP_HN "I am listening, dragon"
#define GOSSIP_SN1 "But you are dragons! How could orcs do this to you?"
#define GOSSIP_SN2 "Your mate?"
#define GOSSIP_SN3 "I have battled many beasts, dragon. I will help you."

bool GossipHello_npc_neltharaku(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if (player->GetQuestStatus(10814) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_HN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(10613, _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_neltharaku(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SN1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(10614, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SN2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->SEND_GOSSIP_MENU(10615, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_SN3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            player->SEND_GOSSIP_MENU(10616, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(10814);
            break;
    }
    return true;
}

/*######
## npc_oronok
######*/

#define GOSSIP_ORONOK1 "I am ready to hear your story, Oronok."
#define GOSSIP_ORONOK2 "How do I find the cipher?"
#define GOSSIP_ORONOK3 "How do you know all of this?"
#define GOSSIP_ORONOK4 "Yet what? What is it, Oronok?"
#define GOSSIP_ORONOK5 "Continue, please."
#define GOSSIP_ORONOK6 "So what of the cipher now? And your boys?"
#define GOSSIP_ORONOK7 "I will find your boys and the cipher, Oronok."

bool GossipHello_npc_oronok_tornheart(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );
    if (_Creature->isVendor())
        player->ADD_GOSSIP_ITEM(1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

    if (player->GetQuestStatus(10519) == QUEST_STATUS_INCOMPLETE)
    {
        player->ADD_GOSSIP_ITEM( 0, GOSSIP_ORONOK1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        player->SEND_GOSSIP_MENU(10312, _Creature->GetGUID());
    }else
    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_oronok_tornheart(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_TRADE:
            player->SEND_VENDORLIST( _Creature->GetGUID() );
            break;
        case GOSSIP_ACTION_INFO_DEF:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ORONOK2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(10313, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ORONOK3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(10314, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ORONOK4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->SEND_GOSSIP_MENU(10315, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ORONOK5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            player->SEND_GOSSIP_MENU(10316, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ORONOK6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(10317, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
            player->ADD_GOSSIP_ITEM( 0, GOSSIP_ORONOK7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
            player->SEND_GOSSIP_MENU(10318, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+6:
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(10519);
            break;
    }
    return true;
}

/*####
# npc_karynaku
####*/

bool QuestAccept_npc_karynaku(Player* player, Creature* creature, Quest const* quest)
{
    if(quest->GetQuestId() == 10870)                        // Ally of the Netherwing
    {
        std::vector<uint32> nodes;

        nodes.resize(2);
        nodes[0] = 161;                                     // From Karynaku
        nodes[1] = 162;                                     // To Mordenai
        error_log("TSCR: Player %s started quest 10870 which has disabled taxi node, need to be fixed in core", player->GetName());
        //player->ActivateTaxiPathTo(nodes, 20811);
    }

    return true;
}

/*####
# npc_overlord_morghor
####*/

#define QUEST_LORD_ILLIDAN_STORMRAGE 11108

#define C_ILLIDAN 22083
#define C_YARZILL 23141

#define SPELL_ONE 39990 // Red Lightning Bolt
#define SPELL_TWO 41528 // Mark of Stormrage
#define SPELL_THREE 40216 // Dragonaw Faction
#define SPELL_FOUR 42016 // Dragonaw Trasform

#define OVERLORD_SAY_1 -1000206
#define OVERLORD_SAY_2 -1000207
#define OVERLORD_SAY_3 -1000208
#define OVERLORD_SAY_4 -1000209
#define OVERLORD_SAY_5 -1000210
#define OVERLORD_SAY_6 -1000211

#define OVERLORD_YELL_1 -1000212
#define OVERLORD_YELL_2 -1000213

#define LORD_ILLIDAN_SAY_1 -1000214
#define LORD_ILLIDAN_SAY_2 -1000215
#define LORD_ILLIDAN_SAY_3 -1000216
#define LORD_ILLIDAN_SAY_4 -1000217
#define LORD_ILLIDAN_SAY_5 -1000218
#define LORD_ILLIDAN_SAY_6 -1000219
#define LORD_ILLIDAN_SAY_7 -1000220

#define YARZILL_THE_MERC_SAY -1000221

struct npc_overlord_morghorAI : public ScriptedAI
{
    npc_overlord_morghorAI(Creature *c) : ScriptedAI(c) {}

    uint64 PlayerGUID;
    uint64 IllidanGUID;

    uint32 ConversationTimer;
    uint32 Step;
    uint32 resetTimer;

    bool Event;

    void Reset()
    {
        PlayerGUID = 0;
        IllidanGUID = 0;

        ConversationTimer = 0;
        Step = 0;

        resetTimer = 180000;

        Event = false;
        m_creature->SetUInt32Value(UNIT_NPC_FLAGS, 2);
    }

    void StartEvent()
    {
        m_creature->SetUInt32Value(UNIT_NPC_FLAGS, 0);
        m_creature->SetUInt32Value(UNIT_FIELD_BYTES_1,0);
        Unit* Illidan = m_creature->SummonCreature(C_ILLIDAN, -5107.83, 602.584, 85.2393, 4.92598, TEMPSUMMON_CORPSE_DESPAWN, 0);
        if(Illidan)
        {
            IllidanGUID = Illidan->GetGUID();
            Illidan->SetVisibility(VISIBILITY_OFF);
        }
        if(PlayerGUID)
        {
            Player* player = Unit::GetPlayer(PlayerGUID);
            if(player)
                DoScriptText(OVERLORD_SAY_1, m_creature, player);
        }
        ConversationTimer = 4200;
        Step = 0;
        Event = true;
    }

    uint32 NextStep(uint32 Step)
    {
        Player* plr = Unit::GetPlayer(PlayerGUID);

        Creature* Illi = Unit::GetCreature((*m_creature), IllidanGUID);

        if(!plr || (!Illi && Step < 23))
        {
            EnterEvadeMode();
            return 0;
        }

        switch(Step)
        {
        case 0: return 0; break;
        case 1: m_creature->GetMotionMaster()->MovePoint(0, -5104.41, 595.297, 85.6838); return 9000; break;
        case 2: DoScriptText(OVERLORD_YELL_1, m_creature, plr); return 4500; break;
        case 3: m_creature->SetInFront(plr); return 3200;  break;
        case 4: DoScriptText(OVERLORD_SAY_2, m_creature, plr); return 2000; break;
        case 5: Illi->SetVisibility(VISIBILITY_ON);
             Illi->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE); return 350; break;
        case 6:
            Illi->CastSpell(Illi, SPELL_ONE, true);
            Illi->SetSelection(m_creature->GetGUID());
            m_creature->SetSelection(IllidanGUID);
            return 2000; break;
        case 7: DoScriptText(OVERLORD_YELL_2, m_creature); return 4500; break;
        case 8: m_creature->SetUInt32Value(UNIT_FIELD_BYTES_1, 8); return 2500; break;
        case 9: DoScriptText(OVERLORD_SAY_3, m_creature); return 6500; break;
        case 10: DoScriptText(LORD_ILLIDAN_SAY_1, Illi); return 5000;  break;
        case 11: DoScriptText(OVERLORD_SAY_4, m_creature, plr); return 6000; break;
        case 12: DoScriptText(LORD_ILLIDAN_SAY_2, Illi); return 5500; break;
        case 13: DoScriptText(LORD_ILLIDAN_SAY_3, Illi); return 4000; break;
        case 14: Illi->SetSelection(PlayerGUID); return 1500; break;
        case 15: DoScriptText(LORD_ILLIDAN_SAY_4, Illi); return 1500; break;
        case 16:
            if (plr)
            {
                Illi->CastSpell(plr, SPELL_TWO, true);
                plr->RemoveAurasDueToSpell(SPELL_THREE);
                plr->RemoveAurasDueToSpell(SPELL_FOUR);
                return 5000;
            }
            else
            {
             // if !plr we can't do that!
             //   plr->FailQuest(QUEST_LORD_ILLIDAN_STORMRAGE);
                Step = 30; return 100;
            }
            break;
        case 17: DoScriptText(LORD_ILLIDAN_SAY_5, Illi); return 5000; break;
        case 18: DoScriptText(LORD_ILLIDAN_SAY_6, Illi); return 5000; break;
        case 19: DoScriptText(LORD_ILLIDAN_SAY_7, Illi); return 5000; break;
        case 20:
            Illi->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
            Illi->SetLevitate(true);
            return 500; break;
        case 21: DoScriptText(OVERLORD_SAY_5, m_creature); return 500; break;
        case 22:
            Illi->SetVisibility(VISIBILITY_OFF);
            Illi->setDeathState(JUST_DIED);
            return 1000; break;
        case 23: m_creature->SetUInt32Value(UNIT_FIELD_BYTES_1,0); return 2000; break;
        case 24: m_creature->SetSelection(PlayerGUID); return 5000; break;
        case 25: DoScriptText(OVERLORD_SAY_6, m_creature); return 2000; break;
        case 26:
            if(plr)
                plr->GroupEventHappens(QUEST_LORD_ILLIDAN_STORMRAGE, m_creature);
            return 6000; break;
        case 27:
            {
            Unit* Yarzill = FindCreature(C_YARZILL, 50, m_creature);
            if (Yarzill)
                Yarzill->SetUInt64Value(UNIT_FIELD_TARGET, PlayerGUID);
            return 500; }break;
        case 28:
            plr->RemoveAurasDueToSpell(SPELL_TWO);
            plr->RemoveAurasDueToSpell(41519);
            plr->CastSpell(plr, SPELL_THREE, true);
            plr->CastSpell(plr, SPELL_FOUR, true);
            return 1000; break;
        case 29:
            {
            Unit* Yarzill = FindCreature(C_YARZILL, 50, m_creature);
            if(Yarzill)
                DoScriptText(YARZILL_THE_MERC_SAY, Yarzill, plr);
            return 5000; }break;
        case 30:
            {
            Unit* Yarzill = FindCreature(C_YARZILL, 50, m_creature);
            if (Yarzill)
                Yarzill->SetUInt64Value(UNIT_FIELD_TARGET, 0);
            return 5000; }break;
        case 31:
            {
            Unit* Yarzill = FindCreature(C_YARZILL, 50, m_creature);
            if (Yarzill)
                Yarzill->CastSpell(plr, 41540, true);
            return 1000;}break;
        case 32: m_creature->GetMotionMaster()->MovePoint(0, -5085.77, 577.231, 86.6719); return 5000; break;
        case 33: EnterEvadeMode(); return 100; break;

        default : return 0;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(!ConversationTimer)
            return;

        if(ConversationTimer <= diff)
        {
            if(Event && IllidanGUID && PlayerGUID)
            {
                ConversationTimer = NextStep(++Step);
            }
        }else ConversationTimer -= diff;
    }
};

CreatureAI* GetAI_npc_overlord_morghorAI(Creature *_Creature)
{
return new npc_overlord_morghorAI(_Creature);
}

bool QuestAccept_npc_overlord_morghor(Player *player, Creature *_Creature, const Quest *_Quest )
{
    if(_Quest->GetQuestId() == QUEST_LORD_ILLIDAN_STORMRAGE)
    {
        ((npc_overlord_morghorAI*)_Creature->AI())->PlayerGUID = player->GetGUID();
        ((npc_overlord_morghorAI*)_Creature->AI())->StartEvent();
        return true;
    }
    return false;
}

/*####
# npc_earthmender_wilda
####*/

#define SAY_START -1000223
#define SAY_AGGRO1 -1000224
#define SAY_AGGRO2 -1000225
#define ASSASSIN_SAY_AGGRO1 -1000226
#define ASSASSIN_SAY_AGGRO2 -1000227
#define SAY_PROGRESS1 -1000228
#define SAY_PROGRESS2 -1000229
#define SAY_PROGRESS3 -1000230
#define SAY_PROGRESS4 -1000231
#define SAY_PROGRESS5 -1000232
#define SAY_PROGRESS6 -1000233
#define SAY_END -1000234

#define QUEST_ESCAPE_FROM_COILSKAR_CISTERN 10451
#define NPC_COILSKAR_ASSASSIN 21044

struct npc_earthmender_wildaAI : public npc_escortAI
{
    npc_earthmender_wildaAI(Creature *c) : npc_escortAI(c) {}

    bool Completed;

    void EnterCombat(Unit *who)
    {
        Player* player = GetPlayerForEscort();

        if(who->GetTypeId() == TYPEID_UNIT && who->GetEntry() == NPC_COILSKAR_ASSASSIN)
            DoScriptText(SAY_AGGRO2, m_creature, player);
        else
            DoScriptText(SAY_AGGRO1, m_creature, player);
    }

    void Reset()
    {
        m_creature->setFaction(1726);
        Completed = false;
    }

    void WaypointReached(uint32 i)
    {
        Player* player = GetPlayerForEscort();
        if (!player)
            return;

        switch(i)
        {
               case 0: DoScriptText(SAY_START, m_creature, player); break;
               case 13: DoScriptText(SAY_PROGRESS1, m_creature, player);
                   SummonAssassin();
                   break;
               case 14: SummonAssassin(); break;
               case 15: DoScriptText(SAY_PROGRESS3, m_creature, player); break;
               case 19:
                   DoScriptText(RAND(SAY_PROGRESS2, SAY_PROGRESS4, SAY_PROGRESS5), m_creature, player);
                   break;
               case 20: SummonAssassin(); break;
               case 26:
                   DoScriptText(RAND(SAY_PROGRESS2, SAY_PROGRESS4, SAY_PROGRESS5), m_creature, player);
                   break;
               case 27: SummonAssassin(); break;
               case 33:
                   DoScriptText(RAND(SAY_PROGRESS2, SAY_PROGRESS4, SAY_PROGRESS5), m_creature, player);
                   break;
               case 34: SummonAssassin(); break;
               case 37:
                   DoScriptText(RAND(SAY_PROGRESS2, SAY_PROGRESS4, SAY_PROGRESS5), m_creature, player);
                   break;
               case 38: SummonAssassin(); break;
               case 39: DoScriptText(SAY_PROGRESS6, m_creature, player); break;
               case 43:
                   DoScriptText(RAND(SAY_PROGRESS2, SAY_PROGRESS4, SAY_PROGRESS5), m_creature, player);
                   break;
               case 44: SummonAssassin(); break;
               case 50:
                   DoScriptText(SAY_END, m_creature, player);
                   player->GroupEventHappens(QUEST_ESCAPE_FROM_COILSKAR_CISTERN, m_creature);
                   Completed = true;
                   break;
               }
       }

       void SummonAssassin()
       {
           Player* player = GetPlayerForEscort();

           Unit* CoilskarAssassin = m_creature->SummonCreature(NPC_COILSKAR_ASSASSIN, m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), m_creature->GetOrientation(), TEMPSUMMON_DEAD_DESPAWN, 0);
           if( CoilskarAssassin )
           {
               DoScriptText(RAND(ASSASSIN_SAY_AGGRO1, ASSASSIN_SAY_AGGRO2), CoilskarAssassin, player);

               ((Creature*)CoilskarAssassin)->AI()->AttackStart(m_creature);
           }
           else error_log("TSCR ERROR: Coilskar Assassin couldn't be summmoned");
       }

       void JustDied(Unit* killer)
       {
           if (!Completed)
           {
               Player* player = GetPlayerForEscort();
               if (player)
                   player->FailQuest(QUEST_ESCAPE_FROM_COILSKAR_CISTERN);
           }
       }

       void UpdateAI(const uint32 diff)
       {
               npc_escortAI::UpdateAI(diff);
       }
};

CreatureAI* GetAI_npc_earthmender_wildaAI(Creature *_Creature)
{
    npc_earthmender_wildaAI* earthmender_wildaAI = new npc_earthmender_wildaAI(_Creature);

       earthmender_wildaAI->AddWaypoint(0, -2637.466064, 1359.977905, 35.889114, 2000); // SAY_START
       earthmender_wildaAI->AddWaypoint(1, -2666.364990, 1348.222656, 34.445557);
       earthmender_wildaAI->AddWaypoint(2, -2693.789307, 1336.964966, 34.445557);
       earthmender_wildaAI->AddWaypoint(3, -2715.495361, 1328.054443, 34.106014);
       earthmender_wildaAI->AddWaypoint(4, -2742.530762, 1314.138550, 33.606144);
       earthmender_wildaAI->AddWaypoint(5, -2745.077148, 1311.108765, 33.630898);
       earthmender_wildaAI->AddWaypoint(6, -2749.855225, 1302.737915, 33.475632);
       earthmender_wildaAI->AddWaypoint(7, -2753.639648, 1294.059448, 33.314930);
       earthmender_wildaAI->AddWaypoint(8, -2756.796387, 1285.122192, 33.391262);
       earthmender_wildaAI->AddWaypoint(9, -2750.042969, 1273.661987, 33.188259);
       earthmender_wildaAI->AddWaypoint(10, -2740.378418, 1258.846680, 33.212521);
       earthmender_wildaAI->AddWaypoint(11, -2733.629395, 1248.259766, 33.640598);
       earthmender_wildaAI->AddWaypoint(12, -2727.212646, 1238.606445, 33.520847);
       earthmender_wildaAI->AddWaypoint(13, -2726.377197, 1237.264526, 33.461823, 4000); // SAY_PROGRESS1
       earthmender_wildaAI->AddWaypoint(14, -2746.383301, 1266.390625, 33.191952, 2000);
       earthmender_wildaAI->AddWaypoint(15, -2746.383301, 1266.390625, 33.191952, 4000); // SAY_PROGRESS3
       earthmender_wildaAI->AddWaypoint(16, -2758.927734, 1285.134155, 33.341728);
       earthmender_wildaAI->AddWaypoint(17, -2761.845703, 1292.313599, 33.209042);
       earthmender_wildaAI->AddWaypoint(18, -2758.871826, 1300.677612, 33.285332);
       earthmender_wildaAI->AddWaypoint(19, -2758.871826, 1300.677612, 33.285332);
       earthmender_wildaAI->AddWaypoint(20, -2753.928955, 1307.755859, 33.452457);
       earthmender_wildaAI->AddWaypoint(20, -2738.612061, 1316.191284, 33.482975);
       earthmender_wildaAI->AddWaypoint(21, -2727.897461, 1320.013916, 33.381111);
       earthmender_wildaAI->AddWaypoint(22, -2709.458740, 1315.739990, 33.301838);
       earthmender_wildaAI->AddWaypoint(23, -2704.658936, 1301.620361, 32.463303);
       earthmender_wildaAI->AddWaypoint(24, -2704.120117, 1298.922607, 32.768162);
       earthmender_wildaAI->AddWaypoint(25, -2691.798340, 1292.846436, 33.852642);
       earthmender_wildaAI->AddWaypoint(26, -2682.879639, 1288.853882, 32.995399);
       earthmender_wildaAI->AddWaypoint(27, -2661.869141, 1279.682495, 26.686783);
       earthmender_wildaAI->AddWaypoint(28, -2648.943604, 1270.272827, 24.147522);
       earthmender_wildaAI->AddWaypoint(29, -2642.506836, 1262.938721, 23.512444);
       earthmender_wildaAI->AddWaypoint(20, -2636.984863, 1252.429077, 20.418257);
       earthmender_wildaAI->AddWaypoint(31, -2648.113037, 1224.984863, 8.691818);
       earthmender_wildaAI->AddWaypoint(32, -2658.393311, 1200.136719, 5.492243);
       earthmender_wildaAI->AddWaypoint(33, -2668.504395, 1190.450562, 3.127407);
       earthmender_wildaAI->AddWaypoint(34, -2685.930420, 1174.360840, 5.163924);
       earthmender_wildaAI->AddWaypoint(35, -2701.613770, 1160.026367, 5.611311);
       earthmender_wildaAI->AddWaypoint(36, -2714.659668, 1149.980347, 4.342373);
       earthmender_wildaAI->AddWaypoint(37, -2721.443359, 1145.002808, 1.913474);
       earthmender_wildaAI->AddWaypoint(38, -2733.962158, 1143.436279, 2.620415);
       earthmender_wildaAI->AddWaypoint(39, -2757.876709, 1146.937500, 6.184002, 2000); // SAY_PROGRESS6
       earthmender_wildaAI->AddWaypoint(40, -2772.300537, 1166.052734, 6.331811);
       earthmender_wildaAI->AddWaypoint(41, -2790.265381, 1189.941650, 5.207958);
       earthmender_wildaAI->AddWaypoint(42, -2805.448975, 1208.663940, 5.557623);
       earthmender_wildaAI->AddWaypoint(43, -2820.617676, 1225.870239, 6.266103);
       earthmender_wildaAI->AddWaypoint(44, -2831.926758, 1237.725830, 5.808506);
       earthmender_wildaAI->AddWaypoint(45, -2842.578369, 1252.869629, 6.807481);
       earthmender_wildaAI->AddWaypoint(46, -2846.344971, 1258.727295, 7.386168);
       earthmender_wildaAI->AddWaypoint(47, -2847.556396, 1266.771729, 8.208790);
       earthmender_wildaAI->AddWaypoint(48, -2841.654541, 1285.809204, 7.933223);
       earthmender_wildaAI->AddWaypoint(49, -2841.754883, 1289.832520, 6.990304);
       earthmender_wildaAI->AddWaypoint(50, -2871.398438, 1302.348145, 6.807335, 8000); // SAY_END

       return (CreatureAI*)earthmender_wildaAI;
}

bool QuestAccept_npc_earthmender_wilda(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_ESCAPE_FROM_COILSKAR_CISTERN)
    {
        creature->setFaction(113);
        if (npc_earthmender_wildaAI* pEscortAI = CAST_AI(npc_earthmender_wildaAI, creature->AI()))
            pEscortAI->Start(false, false, player->GetGUID(), quest);
    }
    return true;
}

/*#####
# Quest: Battle of the crimson watch
#####*/

/* ContentData
Battle of the crimson watch - creatures, gameobjects and defines
mob_illidari_spawn : Adds that are summoned in the Crimson Watch battle.
mob_torloth_the_magnificent : Final creature that players have to face before quest is completed
npc_lord_illidan_stormrage : Creature that controls the event.
go_crystal_prison : GameObject that begins the event and hands out quest
EndContentData */

#define END_TEXT -1000366

#define QUEST_BATTLE_OF_THE_CRIMSON_WATCH 10781
#define EVENT_AREA_RADIUS 65 //65yds
#define EVENT_COOLDOWN 30000 //in ms. appear after event completed or failed (should be = Adds despawn time)

struct TorlothCinematic
{
    int32 TextId;
    uint32 Creature, Timer;
};

// Creature 0 - Torloth, 1 - Illidan
static TorlothCinematic TorlothAnim[]=
{
    {-1000367, 0, 2000},
    {-1000368, 1, 7000},
    {-1000369, 0, 3000},
    {0, 0, 2000}, // Torloth stand
    {-1000370, 0, 1000},
    {0, 0, 3000},
    {0, 0, 0}
};

struct Location
{
    float x, y, z, o;
};

//Cordinates for Spawns
static Location SpawnLocation[]=
{
    //Cords used for:
    {-4615.8556, 1342.2532, 139.9, 1.612},//Illidari Soldier
    {-4598.9365, 1377.3182, 139.9, 3.917},//Illidari Soldier
    {-4598.4697, 1360.8999, 139.9, 2.427},//Illidari Soldier
    {-4589.3599, 1369.1061, 139.9, 3.165},//Illidari Soldier
    {-4608.3477, 1386.0076, 139.9, 4.108},//Illidari Soldier
    {-4633.1889, 1359.8033, 139.9, 0.949},//Illidari Soldier
    {-4623.5791, 1351.4574, 139.9, 0.971},//Illidari Soldier
    {-4607.2988, 1351.6099, 139.9, 2.416},//Illidari Soldier
    {-4633.7764, 1376.0417, 139.9, 5.608},//Illidari Soldier
    {-4600.2461, 1369.1240, 139.9, 3.056},//Illidari Mind Breaker
    {-4631.7808, 1367.9459, 139.9, 0.020},//Illidari Mind Breaker
    {-4600.2461, 1369.1240, 139.9, 3.056},//Illidari Highlord
    {-4631.7808, 1367.9459, 139.9, 0.020},//Illidari Highlord
    {-4615.5586, 1353.0031, 139.9, 1.540},//Illidari Highlord
    {-4616.4736, 1384.2170, 139.9, 4.971},//Illidari Highlord
    {-4627.1240, 1378.8752, 139.9, 2.544} //Torloth The Magnificent
};

struct WaveData
{
    uint8 SpawnCount, UsedSpawnPoint;
    uint32 CreatureId, SpawnTimer,YellTimer;
    int32 WaveTextId;
};

static WaveData WavesInfo[]=
{
    {9, 0, 22075, 10000, 7000, -1000371},   //Illidari Soldier
    {2, 9, 22074, 10000, 7000, -1000372},   //Illidari Mind Breaker
    {4, 11, 19797, 10000, 7000, -1000373},  //Illidari Highlord
    {1, 15, 22076, 10000, 7000, -1000374}   //Torloth The Magnificent
};

struct SpawnSpells
{
 uint32 Timer1, Timer2, SpellId;
};

static SpawnSpells SpawnCast[]=
{
    {10000, 15000, 35871},  // Illidari Soldier Cast - Spellbreaker
    {10000, 10000, 38985},  // Illidari Mind Breake Cast - Focused Bursts
    {35000, 35000, 22884},  // Illidari Mind Breake Cast - Psychic Scream
    {20000, 20000, 17194},  // Illidari Mind Breake Cast - Mind Blast
    {8000, 15000, 38010},   // Illidari Highlord Cast - Curse of Flames
    {12000, 20000, 16102},  // Illidari Highlord Cast - Flamestrike
    {10000, 15000, 15284},  // Torloth the Magnificent Cast - Cleave
    {18000, 20000, 39082},  // Torloth the Magnificent Cast - Shadowfury
    {25000, 28000, 33961}   // Torloth the Magnificent Cast - Spell Reflection
};

/*######
# mob_illidari_spawn
######*/

struct mob_illidari_spawnAI : public ScriptedAI
{
    mob_illidari_spawnAI(Creature* c) : ScriptedAI(c) {}

    uint64 LordIllidanGUID;
    uint32 SpellTimer1, SpellTimer2, SpellTimer3;
    bool Timers;

    void Reset()
    {
        LordIllidanGUID = 0;
        Timers = false;
    }

    void EnterCombat(Unit* who) {}
    void JustDied(Unit* slayer);

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;

        if(!Timers)
        {
            if(m_creature->GetEntry() == 22075)//Illidari Soldier
            {
                SpellTimer1 = SpawnCast[0].Timer1 + (rand()%4 * 1000);
            }
            if(m_creature->GetEntry() == 22074)//Illidari Mind Breaker
            {
                SpellTimer1 = SpawnCast[1].Timer1 + (rand()%10 * 1000);
                SpellTimer2 = SpawnCast[2].Timer1 + (rand()%4 * 1000);
                SpellTimer3 = SpawnCast[3].Timer1 + (rand()%4 * 1000);
            }
            if(m_creature->GetEntry() == 19797)// Illidari Highlord
            {
                SpellTimer1 = SpawnCast[4].Timer1 + (rand()%4 * 1000);
                SpellTimer2 = SpawnCast[5].Timer1 + (rand()%4 * 1000);
            }
            Timers = true;
        }
        //Illidari Soldier
        if(m_creature->GetEntry() == 22075)
        {
            if(SpellTimer1 < diff)
            {
                DoCast(m_creature->getVictim(), SpawnCast[0].SpellId);//Spellbreaker
                SpellTimer1 = SpawnCast[0].Timer2 + (rand()%5 * 1000);
            }else SpellTimer1 -= diff;
        }
        //Illidari Mind Breaker
        if(m_creature->GetEntry() == 22074)
        {
            if(SpellTimer1 < diff)
            {
                if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0))
                {
                    if(target->GetTypeId() == TYPEID_PLAYER)
                    {
                        DoCast(target, SpawnCast[1].SpellId); //Focused Bursts
                        SpellTimer1 = SpawnCast[1].Timer2 + (rand()%5 * 1000);
                    }else SpellTimer1 = 2000;
                }
            }else SpellTimer1 -= diff;

            if(SpellTimer2 < diff)
            {
                DoCast(m_creature->getVictim(), SpawnCast[2].SpellId);//Psychic Scream
                SpellTimer2 = SpawnCast[2].Timer2 + (rand()%13 * 1000);
            }else SpellTimer2 -= diff;

            if(SpellTimer3 < diff)
            {
                DoCast(m_creature->getVictim(), SpawnCast[3].SpellId);//Mind Blast
                SpellTimer3 = SpawnCast[3].Timer2 + (rand()%8 * 1000);
            }else SpellTimer3 -= diff;
        }
        //Illidari Highlord
        if(m_creature->GetEntry() == 19797)
        {
            if(SpellTimer1 < diff)
            {
                DoCast(m_creature->getVictim(), SpawnCast[4].SpellId);//Curse Of Flames
                SpellTimer1 = SpawnCast[4].Timer2 + (rand()%10 * 1000);
            }else SpellTimer1 -= diff;

            if(SpellTimer2 < diff)
            {
                DoCast(m_creature->getVictim(), SpawnCast[5].SpellId);//Flamestrike
                SpellTimer2 = SpawnCast[5].Timer2 + (rand()%7 * 13000);
            }else SpellTimer2 -= diff;
        }

        DoMeleeAttackIfReady();
    }
};

/*######
# mob_torloth_the_magnificent
#####*/

struct mob_torloth_the_magnificentAI : public ScriptedAI
{
    mob_torloth_the_magnificentAI(Creature* c) : ScriptedAI(c) {}

    uint32 AnimationTimer, SpellTimer1, SpellTimer2, SpellTimer3;

    uint8 AnimationCount;

    uint64 LordIllidanGUID;
    uint64 AggroTargetGUID;

    bool Timers;

    void Reset()
    {
        AnimationTimer = 4000;
        AnimationCount = 0;
        LordIllidanGUID = 0;
        AggroTargetGUID = 0;
        Timers = false;

        m_creature->addUnitState(UNIT_STAT_ROOT);
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        m_creature->SetSelection(0);
    }

    void HandleAnimation()
    {
        Creature* pCreature = m_creature;

        if(TorlothAnim[AnimationCount].Creature == 1)
        {
            pCreature = (Unit::GetCreature(*m_creature, LordIllidanGUID));

            if(!pCreature)
                return;
        }

        if(TorlothAnim[AnimationCount].TextId)
            DoScriptText(TorlothAnim[AnimationCount].TextId, pCreature);

        AnimationTimer = TorlothAnim[AnimationCount].Timer;

        switch(AnimationCount)
        {
        case 0:
            m_creature->SetUInt32Value(UNIT_FIELD_BYTES_1,8);
            break;
        case 3:
            m_creature->RemoveFlag(UNIT_FIELD_BYTES_1,8);
            break;
        case 5:
            if(Player* AggroTarget = (Unit::GetPlayer(AggroTargetGUID)))
            {
                m_creature->SetSelection(AggroTarget->GetGUID());
                m_creature->AddThreat(AggroTarget, 1);
                m_creature->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
            }
            break;
        case 6:
            if(Player* AggroTarget = (Unit::GetPlayer(AggroTargetGUID)))
            {
                m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                m_creature->clearUnitState(UNIT_STAT_ROOT);

                float x, y, z;
                AggroTarget->GetPosition(x,y,z);
                m_creature->GetMotionMaster()->MovePoint(0,x,y,z);
            }
            break;
        }
        ++AnimationCount;
    }

    void UpdateAI(const uint32 diff)
    {
        if(AnimationTimer)
        {
            if(AnimationTimer <= diff)
            {
                HandleAnimation();
            }else AnimationTimer -= diff;
        }

        if(AnimationCount < 6)
        {
            m_creature->CombatStop();
        }else if(!Timers)
        {

            SpellTimer1 = SpawnCast[6].Timer1;
            SpellTimer2 = SpawnCast[7].Timer1;
            SpellTimer3 = SpawnCast[8].Timer1;
            Timers = true;
        }

        if(Timers)
        {
            if(SpellTimer1 < diff)
            {
                DoCast(m_creature->getVictim(), SpawnCast[6].SpellId);//Cleave
                SpellTimer1 = SpawnCast[6].Timer2 + (rand()%10 * 1000);
            }else SpellTimer1 -= diff;

            if(SpellTimer2 < diff)
            {
                DoCast(m_creature->getVictim(), SpawnCast[7].SpellId);//Shadowfury
                SpellTimer2 = SpawnCast[7].Timer2 + (rand()%5 * 1000);
            }else SpellTimer2 -= diff;

            if(SpellTimer3 < diff)
            {
                DoCast(m_creature, SpawnCast[8].SpellId);
                SpellTimer3 = SpawnCast[8].Timer2 + (rand()%7 * 1000);//Spell Reflection
            }else SpellTimer3 -= diff;
        }

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* slayer)
    {
        if(slayer)
            switch(slayer->GetTypeId())
        {
            case TYPEID_UNIT:
                if(((Creature*)slayer)->isPet() && ((Pet*)slayer)->GetOwner()->GetTypeId() == TYPEID_PLAYER)
                    ((Player*)((Pet*)slayer->GetOwner()))->GroupEventHappens(QUEST_BATTLE_OF_THE_CRIMSON_WATCH, m_creature);
                break;

            case TYPEID_PLAYER:
                ((Player*)slayer)->GroupEventHappens(QUEST_BATTLE_OF_THE_CRIMSON_WATCH, m_creature);
                break;
        }

        if(Creature* LordIllidan = (Unit::GetCreature(*m_creature, LordIllidanGUID)))
        {
            DoScriptText(END_TEXT, LordIllidan, slayer);
            LordIllidan->AI()->EnterEvadeMode();
        }
    }
};

/*#####
# npc_lord_illidan_stormrage
#####*/

struct npc_lord_illidan_stormrageAI : public ScriptedAI
{
    npc_lord_illidan_stormrageAI(Creature* c) : ScriptedAI(c) {}

    uint64 PlayerGUID;

    uint32 WaveTimer;
    uint32 AnnounceTimer;

    int8 LiveCount;
    uint8 WaveCount;

    bool EventStarted;
    bool Announced;
    bool Failed;

    void Reset()
    {
        PlayerGUID = 0;

        WaveTimer = 10000;
        AnnounceTimer = 7000;
        LiveCount = 0;
        WaveCount = 0;

        EventStarted = false;
        Announced = false;
        Failed = false;

        m_creature->SetVisibility(VISIBILITY_OFF);
    }

    void MoveInLineOfSight(Unit* who) {}
    void AttackStart(Unit* who) {}

    void SummonNextWave()
    {
        uint8 count = WavesInfo[WaveCount].SpawnCount;
        uint8 locIndex = WavesInfo[WaveCount].UsedSpawnPoint;
        srand(time(NULL));//initializing random seed
        uint8 FelguardCount = 0;
        uint8 DreadlordCount = 0;

        for(uint8 i = 0; i < count; ++i)
        {
            Creature* Spawn = NULL;
            float X = SpawnLocation[locIndex + i].x;
            float Y = SpawnLocation[locIndex + i].y;
            float Z = SpawnLocation[locIndex + i].z;
            float O = SpawnLocation[locIndex + i].o;
            Spawn = m_creature->SummonCreature(WavesInfo[WaveCount].CreatureId, X, Y, Z, O, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
            ++LiveCount;

            if(Spawn)
            {
                Spawn->LoadCreaturesAddon();

                if(WaveCount == 0)//1 Wave
                {
                    if(rand()%3 == 1 && FelguardCount<2)
                    {
                        Spawn->SetUInt32Value(UNIT_FIELD_DISPLAYID,18654);
                        ++FelguardCount;
                    }
                    else if(DreadlordCount < 3)
                    {
                        Spawn->SetUInt32Value(UNIT_FIELD_DISPLAYID,19991);
                        ++DreadlordCount;
                    }
                    else if(FelguardCount<2)
                    {
                        Spawn->SetUInt32Value(UNIT_FIELD_DISPLAYID,18654);
                        ++FelguardCount;
                    }
                }

                if(WaveCount < 3)//1-3 Wave
                {
                    if(PlayerGUID)
                    {
                        if(Player* pTarget = Unit::GetPlayer(PlayerGUID))
                        {
                            float x, y, z;
                            pTarget->GetPosition(x,y,z);
                            Spawn->GetMotionMaster()->MovePoint(0,x, y, z);
                        }
                    }
                    ((mob_illidari_spawnAI*)Spawn->AI())->LordIllidanGUID = m_creature->GetGUID();
                }

                if(WavesInfo[WaveCount].CreatureId == 22076) // Torloth
                {
                    ((mob_torloth_the_magnificentAI*)Spawn->AI())->LordIllidanGUID = m_creature->GetGUID();
                    if(PlayerGUID)
                        ((mob_torloth_the_magnificentAI*)Spawn->AI())->AggroTargetGUID = PlayerGUID;
                }
            }
        }
        ++WaveCount;
        WaveTimer = WavesInfo[WaveCount].SpawnTimer;
        AnnounceTimer = WavesInfo[WaveCount].YellTimer;
    }

    void CheckEventFail()
    {
        Player* pPlayer = Unit::GetPlayer(PlayerGUID);

        if(!pPlayer)
            return;

        if(Group *EventGroup = pPlayer->GetGroup())
        {
            Player* GroupMember;

            uint8 GroupMemberCount = 0;
            uint8 DeadMemberCount = 0;
            uint8 FailedMemberCount = 0;

            const Group::MemberSlotList members = EventGroup->GetMemberSlots();

            for(Group::member_citerator itr = members.begin(); itr!= members.end(); itr++)
            {
                GroupMember = (Unit::GetPlayer(itr->guid));
                if(!GroupMember)
                    continue;
                if(!GroupMember->IsWithinDistInMap(m_creature, EVENT_AREA_RADIUS) && GroupMember->GetQuestStatus(QUEST_BATTLE_OF_THE_CRIMSON_WATCH) == QUEST_STATUS_INCOMPLETE)
                {
                    GroupMember->FailQuest(QUEST_BATTLE_OF_THE_CRIMSON_WATCH);
                    GroupMember->SetQuestStatus(QUEST_BATTLE_OF_THE_CRIMSON_WATCH, QUEST_STATUS_NONE);
                    ++FailedMemberCount;
                }
                ++GroupMemberCount;

                if(GroupMember->isDead())
                {
                    ++DeadMemberCount;
                }
            }

            if(GroupMemberCount == FailedMemberCount)
            {
                Failed = true;
            }

            if(GroupMemberCount == DeadMemberCount)
            {
                for(Group::member_citerator itr = members.begin(); itr!= members.end(); itr++)
                {
                    GroupMember = Unit::GetPlayer(itr->guid);

                    if(GroupMember && GroupMember->GetQuestStatus(QUEST_BATTLE_OF_THE_CRIMSON_WATCH) == QUEST_STATUS_INCOMPLETE)
                    {
                        GroupMember->FailQuest(QUEST_BATTLE_OF_THE_CRIMSON_WATCH);
                        GroupMember->SetQuestStatus(QUEST_BATTLE_OF_THE_CRIMSON_WATCH, QUEST_STATUS_NONE);
                    }
                }
                Failed = true;
            }
        }else if (pPlayer->isDead() || !pPlayer->IsWithinDistInMap(m_creature, EVENT_AREA_RADIUS))
        {
            pPlayer->FailQuest(QUEST_BATTLE_OF_THE_CRIMSON_WATCH);
            Failed = true;
        }
    }

    void LiveCounter()
    {
        --LiveCount;
        if(!LiveCount)
            Announced = false;
    }

    void UpdateAI(const uint32 diff)
    {
        if(!PlayerGUID || !EventStarted)
            return;

        if(!LiveCount && WaveCount < 4)
        {
            if(!Announced && AnnounceTimer < diff)
            {
                DoScriptText(WavesInfo[WaveCount].WaveTextId, m_creature);
                Announced = true;
            }else AnnounceTimer -= diff;

            if(WaveTimer < diff)
            {
                SummonNextWave();
            }else WaveTimer -= diff;
        }
        CheckEventFail();

        if(Failed)
            EnterEvadeMode();
    }
};

void mob_illidari_spawnAI::JustDied(Unit *slayer)
{
    m_creature->RemoveCorpse();
    if(Creature* LordIllidan = (Unit::GetCreature(*m_creature, LordIllidanGUID)))
        if(LordIllidan)
            ((npc_lord_illidan_stormrageAI*)LordIllidan->AI())->LiveCounter();
}

/*#####
# go_crystal_prison
######*/

bool GOQuestAccept_GO_crystal_prison(Player* plr, GameObject* go, Quest const* quest)
{
    if(quest->GetQuestId() == QUEST_BATTLE_OF_THE_CRIMSON_WATCH )
    {
        Unit* Illidan = FindCreature(22083, 50, plr);

        if(Illidan && !(((npc_lord_illidan_stormrageAI*)((Creature*)Illidan)->AI())->EventStarted))
        {
            ((npc_lord_illidan_stormrageAI*)((Creature*)Illidan)->AI())->Reset();
            ((npc_lord_illidan_stormrageAI*)((Creature*)Illidan)->AI())->PlayerGUID = plr->GetGUID();
            ((npc_lord_illidan_stormrageAI*)((Creature*)Illidan)->AI())->LiveCount = 0;
            ((npc_lord_illidan_stormrageAI*)((Creature*)Illidan)->AI())->EventStarted=true;
        }
    }
 return true;
}

CreatureAI* GetAI_npc_lord_illidan_stormrage(Creature* c)
{
    return new npc_lord_illidan_stormrageAI(c);
}

CreatureAI* GetAI_mob_illidari_spawn(Creature* c)
{
    return new mob_illidari_spawnAI(c);
}

CreatureAI* GetAI_mob_torloth_the_magnificent(Creature* c)
{
    return new mob_torloth_the_magnificentAI(c);
}

/*####
# npc_enraged_spirits
####*/

/* QUESTS */
#define QUEST_ENRAGED_SPIRITS_FIRE_EARTH 10458
#define QUEST_ENRAGED_SPIRITS_AIR 10481
#define QUEST_ENRAGED_SPIRITS_WATER 10480

/* Totem */
#define ENTRY_TOTEM_OF_SPIRITS 21071
#define RADIUS_TOTEM_OF_SPIRITS 15

/* SPIRITS */
#define ENTRY_ENRAGED_EARTH_SPIRIT 21050
#define ENTRY_ENRAGED_FIRE_SPIRIT 21061
#define ENTRY_ENRAGED_AIR_SPIRIT 21060
#define ENTRY_ENRAGED_WATER_SPIRIT 21059

/* SOULS */
#define ENTRY_EARTHEN_SOUL 21073
#define ENTRY_FIERY_SOUL 21097
#define ENTRY_ENRAGED_AIRY_SOUL 21116
#define ENTRY_ENRAGED_WATERY_SOUL 21109  // wrong model

/* SPELL KILLCREDIT - not working!?! - using KilledMonster */
#define SPELL_EARTHEN_SOUL_CAPTURED_CREDIT 36108
#define SPELL_FIERY_SOUL_CAPTURED_CREDIT 36117
#define SPELL_AIRY_SOUL_CAPTURED_CREDIT 36182
#define SPELL_WATERY_SOUL_CAPTURED_CREDIT 36171

/* KilledMonster Workaround */
#define CREDIT_FIRE 21094
#define CREDIT_WATER 21095
#define CREDIT_AIR 21096
#define CREDIT_EARTH 21092

/* Captured Spell/Buff */
#define SPELL_SOUL_CAPTURED 36115

/* Factions */
#define ENRAGED_SOUL_FRIENDLY 35
#define ENRAGED_SOUL_HOSTILE 14

struct npc_enraged_spiritAI : public ScriptedAI
{
    npc_enraged_spiritAI(Creature *c) : ScriptedAI(c) {}

    void Reset()   { }

    void EnterCombat(Unit *who){}

    void JustDied(Unit* killer)
    {
        // always spawn spirit on death
        // if totem around
        // move spirit to totem and cast kill count
        uint32 entry = 0;
        uint32 credit = 0;

        switch(m_creature->GetEntry()) {
          case ENTRY_ENRAGED_FIRE_SPIRIT:
            entry  = ENTRY_FIERY_SOUL;
            //credit = SPELL_FIERY_SOUL_CAPTURED_CREDIT;
            credit = CREDIT_FIRE;
          break;
          case ENTRY_ENRAGED_EARTH_SPIRIT:
            entry  = ENTRY_EARTHEN_SOUL;
            //credit = SPELL_EARTHEN_SOUL_CAPTURED_CREDIT;
            credit = CREDIT_EARTH;
          break;
          case ENTRY_ENRAGED_AIR_SPIRIT:
            entry  = ENTRY_ENRAGED_AIRY_SOUL;
            //credit = SPELL_AIRY_SOUL_CAPTURED_CREDIT;
            credit = CREDIT_AIR;
          break;
          case ENTRY_ENRAGED_WATER_SPIRIT:
            entry  = ENTRY_ENRAGED_WATERY_SOUL;
            //credit = SPELL_WATERY_SOUL_CAPTURED_CREDIT;
            credit = CREDIT_WATER;
          break;
        }

        // Spawn Soul on Kill ALWAYS!
        Creature* Summoned = NULL;
        Unit* totemOspirits = NULL;

        if ( entry != 0 )
            Summoned = DoSpawnCreature(entry, 0, 0, 1, 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 5000);

        // FIND TOTEM, PROCESS QUEST
        if (Summoned)
        {
             totemOspirits = FindCreature(ENTRY_TOTEM_OF_SPIRITS, RADIUS_TOTEM_OF_SPIRITS, m_creature);
             if (totemOspirits)
             {
                 Summoned->setFaction(ENRAGED_SOUL_FRIENDLY);
                 Summoned->GetMotionMaster()->MovePoint(0,totemOspirits->GetPositionX(), totemOspirits->GetPositionY(), Summoned->GetPositionZ());

                 Player* Owner = (Player*)totemOspirits->GetOwner();
                 if (Owner)
                     // DoCast(Owner, credit); -- not working!
                     Owner->KilledMonster(credit, Summoned->GetGUID());
                 DoCast(totemOspirits,SPELL_SOUL_CAPTURED);
             }
        }
    }
};

CreatureAI* GetAI_npc_enraged_spirit(Creature *_Creature)
{
return new npc_enraged_spiritAI(_Creature);
}
/*#####
# Akama's cutscene after quest 10628 & Akama BT Prelude after quest 10944
######*/

/*TODO
 - improve Olum's Spirit animation
 - set exact NPC emotes into the db
 - find and setup green glowing flames spell seen with Illidan appearence
*/

// Cutscene after quest 10628 dialogs
#define SAY_DIALOG_VAGATH_1 "Mortals, here? What is the meaning of this, pathetic Broken!"
#define SAY_WHISPER_AKAMA_2 "Have no fear, $c. Just play along."
#define SAY_DIALOG_AKAMA_3  "A mere nuisance, I assure you! Tell the Master his prisoner will not escape while Akama and his Deathsworn watch over her."
#define SAY_DIALOG_VAGATH_4 "You'd do well not to toy with me, Akama. Illidan has given me strict orders to keep watch on the Warden. If I find out you are hiding anything from me, I will crush you with my bare hands!"
#define SAY_DIALOG_AKAMA_5  "Forgive my harsh methods, but the Betrayer cannot learn of the truth. My secret must be kept at all costs!"
#define SAY_DIALOG_MAIEV_6  "If we truly desire the same thing, Akama, then release me! If Illidan is to die, it shall be by my hand!"
#define SAY_DIALOG_AKAMA_7  "In due time, Maiev. I've spent years planning to make my move - I can't afford to put my plans in peril by tipping my hand too soon."
#define SAY_DIALOG_MAIEV_8  "Curse you, Akama! I am not a pawn in your game...my will is my own. When I unleash my wrath upon Illidan it will have nothing to do with your foolish scheme!"

// Cutscene after quest 10628 creatures & spells
#define VAGATH                   21768
#define ILLIDARI_SUCCUBUS        22860
#define MAIEV_SHADOWSONG         21699
#define SPELL_FAKE_KILL_VISUAL   37071      // not blizzlike, blizzlike unknown
#define SPELL_RESURECTION_VISUAL 21074      // not blizzlike, blizzlike unknown

// Cutscene after quest 10628 postions data
static float VagathPos[4] = {-3726.75,1038.05,55.95,4.60};
static float SuccubPos1[4] = {-3723.55,1041.40,55.95,4.60};
static float SuccubPos2[4] = {-3730.46,1041.40,55.95,4.60};

// BT prelude after quest 10944 dialogs & music
#define SAY_DIALOG_OLUM_1           -1563012
#define SAY_DIALOG_PRE_AKAMA_1      -1563001
#define SAY_DIALOG_OLUM_2           -1563013
#define SAY_DIALOG_PRE_AKAMA_2      -1563002
#define SAY_DIALOG_OLUM_3           -1563014
#define SAY_DIALOG_PRE_AKAMA_3      -1563003
#define SAY_DIALOG_OLUM_4           -1563015
#define SAY_DIALOG_PRE_AKAMA_4      -1563004
#define SAY_DIALOG_OLUM_5           -1563016
#define SAY_DIALOG_PRE_AKAMA_5      -1563005
#define SAY_DIALOG_PRE_AKAMA_6      -1563006
#define SAY_DIALOG_ILLIDAN_1        -1563009
#define SAY_DIALOG_PRE_AKAMA_7      -1563007
#define SAY_DIALOG_ILLIDAN_2        -1563010
#define SAY_DIALOG_ILLIDAN_3        -1563011
#define SAY_DIALOG_PRE_AKAMA_8      -1563008
#define BLACK_TEMPLE_PRELUDE_MUSIC     11716
#define ILLIDAN_APPEARING               5756

// BT prelude after quest 10944 creatures & spells & emotes
#define ILLIDAN                     22083
#define SEER_OLUM                   22820
#define OLUMS_SPIRIT                22870
#define SPELL_OLUMS_SACRIFICE       39552
#define STATE_DROWNED                 383

// BT prelude after quest 10944 postions data
static float OlumPos[4] = {-3729.17,1035.63,55.95,5.82};
static float OlumNewPos[4] = {-3721.87,1031.86,55.95,5.90};
static float AkamaPos[4] = {-3714.50,1028.95,55.95,2.57};
static float AkamaNewPos[4] = {-3718.33,1030.27,55.95,2.77};





struct npc_AkamaAI : public ScriptedAI
{
    npc_AkamaAI(Creature* c) : ScriptedAI(c) {}

    uint64 VagathGUID;
    uint64 Succub1GUID;
    uint64 Succub2GUID;

    uint64 OlumGUID;
    uint64 IllidanGUID;
    uint64 OlumSpiritGUID;

    uint32 TalkTimer;
    uint32 Step;

    std::list<uint64> targets;

    bool EventStarted;
    bool PreludeEventStarted;

    void Reset()
    {
        VagathGUID = 0;
        Step = 0;

        TalkTimer = 0;
        EventStarted = false;
        targets.clear();
    }

    void PreludeReset()
    {
        OlumGUID = 0;
        IllidanGUID = 0;
        Step = 0;

        TalkTimer = 0;
        PreludeEventStarted = false;

    }

    void BuildNearbyUnitsList()
    {
        float range = 20.0f;
        std::list<Unit*> tempTargets;
        Looking4group::AnyUnitInObjectRangeCheck check(m_creature, range);
        Looking4group::UnitListSearcher<Looking4group::AnyUnitInObjectRangeCheck> searcher(tempTargets, check);
        Cell::VisitAllObjects(me, searcher, range);
        for (std::list<Unit*>::iterator iter = tempTargets.begin(); iter != tempTargets.end(); ++iter)
            if ((*iter)->GetTypeId() == TYPEID_PLAYER)
                targets.push_back((*iter)->GetGUID());
    }


    void StartEvent()
    {
        Step = 1;
        EventStarted = true;

        Creature* Vagath = m_creature->SummonCreature(VAGATH,VagathPos[0],VagathPos[1],VagathPos[2],VagathPos[3],TEMPSUMMON_CORPSE_TIMED_DESPAWN,0);
        Creature* Succub1 = m_creature->SummonCreature(ILLIDARI_SUCCUBUS,SuccubPos1[0],SuccubPos1[1],SuccubPos1[2],SuccubPos1[3],TEMPSUMMON_CORPSE_TIMED_DESPAWN,0);
        Creature* Succub2 = m_creature->SummonCreature(ILLIDARI_SUCCUBUS,SuccubPos2[0],SuccubPos2[1],SuccubPos2[2],SuccubPos2[3],TEMPSUMMON_CORPSE_TIMED_DESPAWN,0);

        if (!Vagath || !Succub1 || !Succub2)
            return;

        VagathGUID = Vagath->GetGUID();
        Succub1GUID = Succub1->GetGUID();
        Succub2GUID = Succub2->GetGUID();

        Vagath->setFaction(35);
        TalkTimer = 3000;

        BuildNearbyUnitsList();
    }

    uint32 NextStep(uint32 Step)
    {
        Unit* vaga = Unit::GetUnit((*m_creature),VagathGUID);
        Unit* Succub1 = Unit::GetUnit((*m_creature),Succub1GUID);
        Unit* Succub2 = Unit::GetUnit((*m_creature),Succub2GUID);
        Unit* maiev = FindCreature(MAIEV_SHADOWSONG, 50, m_creature);

        switch(Step)
        {
            case 0:
            return 0;

            case 1:
                if (vaga)
                    ((Creature*)vaga)->Say(SAY_DIALOG_VAGATH_1,LANG_UNIVERSAL,0);
                return 3000;

            case 2:
                for (std::list<uint64>::iterator iter = targets.begin(); iter != targets.end(); ++iter)
                {
                    if (Unit * target = me->GetUnit(*iter))
                        DoWhisper(SAY_WHISPER_AKAMA_2, target);

                }
                return 1000;

            case 3:
                for (std::list<uint64>::iterator iter = targets.begin(); iter != targets.end(); ++iter)
                {
                    if (Unit * target = me->GetUnit(*iter))
                        DoCast(target, SPELL_FAKE_KILL_VISUAL);

                }
                return 1000;

            case 4:
                for (std::list<uint64>::iterator iter = targets.begin(); iter != targets.end(); ++iter)
                {
                    if (Unit * target = me->GetUnit(*iter))
                    {
                        target->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                        target->SetHealth(1);
                        ((Player*)target)->setRegenTimer(60000);
                        target->GetUnitStateMgr().PushAction(UNIT_ACTION_STUN);
                    }
                }
                return 3000;

            case 5:
                m_creature->Say(SAY_DIALOG_AKAMA_3,LANG_UNIVERSAL,0);
                return 12000;

            case 6:
                if (vaga)
                    ((Creature*)vaga)->Say(SAY_DIALOG_VAGATH_4,LANG_UNIVERSAL,0);
                return 15000;

            case 7:
                if (vaga)
                    ((Creature*)vaga)->setDeathState(CORPSE);
                if (Succub1)
                    ((Creature*)Succub1)->setDeathState(CORPSE);
                if (Succub2)
                    ((Creature*)Succub2)->setDeathState(CORPSE);
                return 3000;

            case 8:
                for (std::list<uint64>::iterator iter = targets.begin(); iter != targets.end(); ++iter)
                {
                    if (Unit * target = me->GetUnit(*iter))
                        DoCast(target, SPELL_RESURECTION_VISUAL);
                }
                return 2000;

            case 9:
                for (std::list<uint64>::iterator iter = targets.begin(); iter != targets.end(); ++iter)
                {
                    if (Unit * target = me->GetUnit(*iter))
                    {
                        target->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                        target->SetHealth(target->GetMaxHealth());
                        target->GetUnitStateMgr().DropAction(UNIT_ACTION_STUN);
                    }
                }
                m_creature->Say(SAY_DIALOG_AKAMA_5, LANG_UNIVERSAL, 0);
                return 12000;

            case 10:
                if (maiev)
                    ((Creature*)maiev)->Say(SAY_DIALOG_MAIEV_6,LANG_UNIVERSAL,0);
                return 12000;

            case 11:
                m_creature->Say(SAY_DIALOG_AKAMA_7,LANG_UNIVERSAL,0);
                return 12000;

            case 12:
                if (maiev)
                    ((Creature*)maiev)->Say(SAY_DIALOG_MAIEV_8,LANG_UNIVERSAL,0);
                return 1000;

            case 13:
                Reset();
                return 100;

            default:
            return 0;
        }
        return 0;
    }

    void StartPreludeEvent()
    {
        Step = 1;
        PreludeEventStarted = true;

        DoPlaySoundToSet(m_creature,BLACK_TEMPLE_PRELUDE_MUSIC);

        Creature* Olum = m_creature->SummonCreature(SEER_OLUM,OlumPos[0],OlumPos[1],OlumPos[2],OlumPos[3],TEMPSUMMON_CORPSE_TIMED_DESPAWN,45000);    // despawn corpse after 45 seconds - Blizzlike

        if (!Olum)
            return;

        OlumGUID = Olum->GetGUID();
        DoScriptText(SAY_DIALOG_OLUM_1,Olum);

        Olum->MonsterMoveWithSpeed(OlumNewPos[0],OlumNewPos[1],OlumNewPos[2],5000,true);

        TalkTimer = 13000;
    }

    uint32 PreludeNextStep(uint32 Step)
    {
        Unit* olum = Unit::GetUnit((*m_creature),OlumGUID);
        Unit* Illidan = Unit::GetUnit((*m_creature), IllidanGUID);

        switch(Step)
        {
            case 0:
                return 0;

            case 1:
                DoScriptText(SAY_DIALOG_PRE_AKAMA_1,m_creature);
                return 4000;
            case 2:
                if (olum)
                    DoScriptText(SAY_DIALOG_OLUM_2,(Creature*)olum);
                return 8000;
            case 3:
                DoScriptText(SAY_DIALOG_PRE_AKAMA_2,m_creature);
                return 7000;
            case 4:
                if (olum)
                    DoScriptText(SAY_DIALOG_OLUM_3,(Creature*)olum);
                return 27500;
            case 5:
                DoScriptText(SAY_DIALOG_PRE_AKAMA_3,m_creature);
                return 5000;
            case 6:
                if (olum)
                    DoScriptText(SAY_DIALOG_OLUM_4,(Creature*)olum);
                return 16000;
            case 7:
                DoScriptText(SAY_DIALOG_PRE_AKAMA_4,m_creature);
                return 8000;
            case 8:
                if (olum)
                    DoScriptText(SAY_DIALOG_OLUM_5,(Creature*)olum);
                return 14500;
            case 9:
                m_creature->MonsterMoveWithSpeed(AkamaNewPos[0],AkamaNewPos[1],AkamaNewPos[2],2000,true);
                return 2500;
            case 10:
                if (olum)
                    DoCast(olum,SPELL_OLUMS_SACRIFICE);
                return 6800;
            case 11:
                if (olum)
                {
                    olum->setDeathState(JUST_DIED);
                    if (Creature* spirit = m_creature->SummonCreature(OLUMS_SPIRIT,OlumNewPos[0],OlumNewPos[1],OlumNewPos[2],OlumNewPos[3]-2.0f,TEMPSUMMON_TIMED_DESPAWN,16000))
                    {
                        spirit->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        spirit->SetLevitate(true);
                        // spirit->SetUInt32Value(UNIT_NPC_EMOTESTATE,STATE_DROWNED); // improve Olum's Spirit animation using Drowned State, right movement flag or monster move type needed
                        spirit->MonsterMoveWithSpeed(OlumNewPos[0],OlumNewPos[1],OlumNewPos[2]+8.0f,16000,true);
                    }
                }
                return 7000;
            case 12:
                DoScriptText(SAY_DIALOG_PRE_AKAMA_5,m_creature);
                return 12000;
            case 13:
                m_creature->MonsterMoveWithSpeed((AkamaPos[0]+0.1f), (AkamaPos[1]-0.1f), AkamaPos[2], 2000,true);
                return 2100;
            case 14:
                m_creature->MonsterMoveWithSpeed((AkamaPos[0]-0.05f), (AkamaPos[1]), AkamaPos[2], 200,true);    // just to turn back Akama to Illidan
                return 6000;
            case 15:
                DoScriptText(SAY_DIALOG_PRE_AKAMA_6,m_creature);
                m_creature->SetUInt32Value(UNIT_NPC_EMOTESTATE,68);
                return 200;
            case 16:
                if (Illidan)
                    DoPlaySoundToSet(Illidan,ILLIDAN_APPEARING);
                return 7000;
            case 17:
                if (Illidan)
                    DoScriptText(SAY_DIALOG_ILLIDAN_1,(Creature*)Illidan);
                return 14000;
            case 18:
                DoScriptText(SAY_DIALOG_PRE_AKAMA_7,m_creature);
                return 19000;
            case 19:
                if (Illidan)
                    DoScriptText(SAY_DIALOG_ILLIDAN_2,(Creature*)Illidan);
                return 21000;
            case 20:
                if (Illidan)
                    DoScriptText(SAY_DIALOG_ILLIDAN_3,(Creature*)Illidan);
                return 22000;
            case 21:
                DoScriptText(SAY_DIALOG_PRE_AKAMA_8,m_creature);
                return 1000;
            case 22:
                if (Illidan)
                    Illidan->setDeathState(CORPSE);
                return 1000;
            case 23:
                PreludeReset();
                return 100;
            default:
            return 0;
        }
        return 0;
    }

    void UpdateAI(const uint32 diff)
    {
        if (EventStarted && VagathGUID)
        {
            if (TalkTimer < diff)
            {
                TalkTimer = NextStep(Step++);
            }
            else
                TalkTimer -= diff;
        }

        if(PreludeEventStarted && OlumGUID)
        {
            if (Step == 16 && !IllidanGUID && TalkTimer < diff)
            {
                Creature* Illidan = m_creature->SummonCreature(ILLIDAN,OlumNewPos[0]-3.0f,OlumNewPos[1]+0.5f,OlumNewPos[2],OlumNewPos[3],TEMPSUMMON_CORPSE_DESPAWN,0);
                Illidan->SetFloatValue(OBJECT_FIELD_SCALE_X,0.65f);
                Illidan->SetVisibility(VISIBILITY_ON);
                Illidan->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE);
                IllidanGUID = Illidan->GetGUID();
            }
            if (TalkTimer < diff)
            {
                TalkTimer = PreludeNextStep(Step++);
            }
            else
                TalkTimer -= diff;
        }
    }
};

CreatureAI* GetAI_npc_Akama(Creature *_Creature)
{
    return new npc_AkamaAI(_Creature);
}
bool ChooseReward_npc_Akama(Player *player, Creature *_Creature, const Quest *_Quest)
{
    bool EventStarted = ((npc_AkamaAI*)_Creature->AI())->EventStarted;
    bool PreludeEventStarted = ((npc_AkamaAI*)_Creature->AI())->PreludeEventStarted;

    if (EventStarted || PreludeEventStarted)
        return false;

    if (!EventStarted && _Quest->GetQuestId() == 10628)
        ((npc_AkamaAI*)_Creature->AI())->StartEvent();

    if (!PreludeEventStarted && _Quest->GetQuestId() == 10944)
        ((npc_AkamaAI*)_Creature->AI())->StartPreludeEvent();

    return false;
}

/*#####
# Quest: The Ata'mal Terrace
#####*/

/* ContentData
npc_shadowlord_trigger : trigger that brings Deathwail when dies, spawns trash
mob_shadowlord_deathwail : main boss, spams fel seeds when soulstelers aggroed, goes down when trigger dies
mob_shadowmoon_soulstealer : not moves, when aggro spawns Retainers
felfire_summoner : invisible NPC to set fel fireball visuals
TO DO: make Heart of Fury GO despawn when Deathwail lands
TO DO: re-check all timers and "crush" test event
EndContentData */

/*#####
# npc_shadowlord_trigger
######*/

struct npc_shadowlord_triggerAI : public Scripted_NoMovementAI
{
    npc_shadowlord_triggerAI(Creature* c) : Scripted_NoMovementAI(c)
    {
        x = m_creature->GetPositionX();
        y = m_creature->GetPositionY();
        z = m_creature->GetPositionZ();
    }

    std::list<Creature*> SoulstealerList;
    uint32 Check_Timer;
    uint32 Wave_Timer;
    uint32 Reset_Timer;
    uint32 counter;         //is alive counter
    uint32 Ccounter;        //is in combat counter
    float x, y, z;

    static const int32
        SpawnX = -3249,
        SpawnY = 347,
        SpawnZ = 127;

    void Reset()
    {
        Reset_Timer = 0;
        Check_Timer = 0;
        Wave_Timer = 0;
        counter = 0;
        Ccounter = 0;
        SoulstealerList.clear();
        SoulstealerList = FindAllCreaturesWithEntry(22061, 80.0f);
        m_creature->Relocate(x, y, z);
    }

    void EnterCombat(Unit* who)
    {
        m_creature->GetMotionMaster()->Clear();
        m_creature->GetMotionMaster()->MoveIdle();
    }

    void UpdateAI(const uint32 diff)
    {
        if(!m_creature->isInCombat())
            return;

        if(Check_Timer < diff)
        {
            SoulstealerList.clear();
            counter = 0;
            Ccounter = 0;
            m_creature->CallAssistance();
            SoulstealerList = FindAllCreaturesWithEntry(22061, 80.0f);
            if(!SoulstealerList.empty())
                for(std::list<Creature*>::iterator i = SoulstealerList.begin(); i != SoulstealerList.end(); ++i)
                {
                    if((*i)->isAlive())
                        counter++;
                    if((*i)->isInCombat())
                        ++Ccounter;
                }
            Check_Timer = 5000;

            float NewX, NewY, NewZ;
            m_creature->GetRandomPoint(x, y, z, 14.0, NewX, NewY, NewZ);
            NewZ = 137.15;  //normalize Z
            DoTeleportTo(NewX, NewY, NewZ);
            m_creature->Relocate(NewX, NewY, NewZ);
            if(!Ccounter && counter && !Reset_Timer)
                Reset_Timer = 20000;
        }
        else
            Check_Timer -= diff;

        if(counter)
        {
            if(Wave_Timer < diff)
            {
                float x,y,z;
                for(uint8 i = 0; i < 3; ++i)
                {
                    m_creature->GetRandomPoint(SpawnX,SpawnY,SpawnZ,3.0f,x,y,z);
                    z = SpawnZ;
                    Unit *Retainer = m_creature->SummonCreature(22102,x,y,z,m_creature->GetOrientation(),
                    TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,80000);
                    Retainer->GetMotionMaster()->MoveChase(me->getVictim());
                }
                Wave_Timer = 25000;
            }
            else
                Wave_Timer -= diff;
        }
        else
        {
            Unit* HeartVisual = FindCreature(22058, 80.0, m_creature);
            if(HeartVisual)
            {
                HeartVisual->Kill(HeartVisual, false);
                ((Creature*)HeartVisual)->RemoveCorpse();
            }
            m_creature->Kill(m_creature, false);
            m_creature->RemoveCorpse();
        }

        if(Reset_Timer)
        {
            if(Reset_Timer < diff)
            {
                EnterEvadeMode();
                Reset_Timer = 0;
            }
            else
                Reset_Timer -= diff;
        }
    }
};

CreatureAI* GetAI_npc_shadowlord_trigger(Creature *_Creature)
{
    return new npc_shadowlord_triggerAI(_Creature);
}

/*#####
# mob_shadowlord_deathwail
######*/

#define DEATHWAIL_FLYPATH            2095
#define SPELL_SHADOWBOLT            12471
#define SPELL_SHADOWBOLT_VALLEY     15245
#define SPELL_DEATHCOIL             32709
#define SPELL_FEAR                  27641
#define SPELL_FEL_FIREBALL          38312

struct mob_shadowlord_deathwailAI : public ScriptedAI
{
    mob_shadowlord_deathwailAI(Creature* c) : ScriptedAI(c) {}

    CreatureInfo* cInfo;
    uint32 Check_Timer;
    uint32 Patrol_Timer;
    uint32 Shadowbolt_Timer;
    uint32 ShadowboltVoley_Timer;
    uint32 Fear_Timer;
    uint32 Deathcoil_Timer;

    uint64 HeartGUID;

    bool landed;
    bool felfire;

    void Reset()
    {
        ClearCastQueue();

        m_creature->SetNoCallAssistance(true);
        Check_Timer = 2000;
        felfire = false;

        Shadowbolt_Timer = 4000;
        ShadowboltVoley_Timer = 13000;
        Fear_Timer = 20000;
        Deathcoil_Timer = 8000;

        m_creature->GetMotionMaster()->Initialize();
        m_creature->SetLevitate(true);
        //m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        //m_creature->GetMotionMaster()->MovePath(DEATHWAIL_FLYPATH, true);
        //this waypoints are to far away from home and npc resets during travel
        m_creature->GetMotionMaster()->MovePoint(0, -3247, 284, 187);
        landed = false;

        Unit* trigger = FindCreature(22096, 100, m_creature);
        if (trigger && !trigger->isAlive())
            ((Creature*)trigger)->Respawn();
    }

    void AttackStart(Unit* who)
    {
        if (m_creature->Attack(who, true))
        {
            m_creature->AddThreat(who, 0.0f);
            m_creature->SetInCombatWith(who);
            who->SetInCombatWith(m_creature);

            DoStartMovement(who);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(Check_Timer < diff)
        {
            Unit* trigger = FindCreature(22096, 100, m_creature);

            if(trigger && !trigger->isAlive() && !landed)
            {
                m_creature->setFaction(1813);
                m_creature->GetMotionMaster()->Initialize();
                m_creature->SetLevitate(true);
                m_creature->GetMotionMaster()->MovePoint(1, -3247, 284, 138.1);
                m_creature->SetHomePosition( -3247, 284, 138.1, 0);
                m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                DoZoneInCombat(50);
                landed = true;
                felfire = false;
            }
            if(!m_creature->isInCombat() && landed && trigger && trigger->isAlive())
                Reset();

            if(!m_creature->IsWalking() && m_creature->GetPositionZ() < 142)
            {
                me->SetWalk(true);
                m_creature->SetSpeed(MOVE_WALK, 4.0);
                m_creature->SetSpeed(MOVE_RUN, 2.0);
            }
            if(felfire && trigger && !trigger->isInCombat())
                felfire = false;
            if(felfire)
                AddSpellToCast(m_creature, SPELL_FEL_FIREBALL);
            Check_Timer = 5000;
        }
        else
            Check_Timer -= diff;

        if(!landed || !UpdateVictim())
            return;

        if(Shadowbolt_Timer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_SHADOWBOLT);
            Shadowbolt_Timer = 12000+rand()%6000;
        }
        else
            Shadowbolt_Timer -= diff;

        if(ShadowboltVoley_Timer < diff)
        {
            AddSpellToCast(m_creature->getVictim(), SPELL_SHADOWBOLT);
            ShadowboltVoley_Timer = 25000+rand()%15000;
        }
        else
            ShadowboltVoley_Timer -= diff;

        if(Fear_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30.0, true))
                AddSpellToCast(target, SPELL_FEAR);
            Fear_Timer = 10000+rand()%20000;
        }
        else
            Fear_Timer -= diff;

        if(Deathcoil_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_RANDOM, 0, 30.0, true, m_creature->getVictimGUID()))
                AddSpellToCast(target, SPELL_DEATHCOIL);
            else
                AddSpellToCast(m_creature->getVictim(), SPELL_DEATHCOIL);
            Deathcoil_Timer = 15000+rand()%30000;
        }
        else
            Deathcoil_Timer -= diff;
       
        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();

    }
};

CreatureAI* GetAI_mob_shadowlord_deathwail(Creature *_Creature)
{
    return new mob_shadowlord_deathwailAI(_Creature);
}

/*#####
# mob_shadowmoon_soulstealer
######*/

struct mob_shadowmoon_soulstealerAI : public Scripted_NoMovementAI
{
    mob_shadowmoon_soulstealerAI(Creature* c) : Scripted_NoMovementAI(c) {}

    void Reset()
    {
        DoCast(m_creature, 38250);
    }

    void MoveInLineOfSight(Unit *who)
    {
        std::list<Unit*> party;

        if(!m_creature->isInCombat() && who->GetTypeId() == TYPEID_PLAYER  && m_creature->IsWithinDistInMap(who, 15.0f))
        {
            who->GetPartyMember(party, 50.0f);
            for(std::list<Unit*>::iterator i = party.begin(); i != party.end(); ++i)
            {
                AttackStart(*i);
            }
        }

    }

    void EnterCombat(Unit* who)
    {
        m_creature->GetUnitStateMgr().PushAction(UNIT_ACTION_STUN);
        m_creature->CombatStart(who);
        if(Unit* Deathwail = FindCreature(22006, 100.0, m_creature))
            ((mob_shadowlord_deathwailAI*)((Creature*) Deathwail)->AI())->felfire = true;
        if(Unit* trigger = FindCreature(22096, 100.0, m_creature))
            ((npc_shadowlord_triggerAI*)((Creature*) trigger)->AI())->AttackStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;
    }
};

CreatureAI* GetAI_mob_shadowmoon_soulstealer(Creature *_Creature)
{
    return new mob_shadowmoon_soulstealerAI(_Creature);
}

/*#####
# felfire_summoner
######*/

struct felfire_summonerAI : public NullCreatureAI
{
    felfire_summonerAI(Creature *c) : NullCreatureAI(c) {}
};

CreatureAI* GetAI_felfire_summoner(Creature *_Creature)
{
    return new felfire_summonerAI (_Creature);
}

/*#####
# Quest: A Distraction for Akama
#####*/

/* ContentData

npc_maiev_BT_attu
npc_akama_BT_attu
npc_ashtongue_deathsworn
mob_vagath
mob_illidari_shadowlord
npc_xiri
Xi'ri gossips

EndContentData */

//NPC Entries
#define NPC_MAIEV_SHADOWSONG        22989
#define NPC_AKAMA_BT                22990
#define NPC_ASHTONGUE_DEATHSWORN    21701
#define MOB_VAGATH                  23152
#define MOB_ILLIDARI_SHADOWLORD     22988

//NPC Spells
#define SPELL_FAN_OF_BLADES         39954
#define SPELL_STEALTH               34189
#define CHAIN_LIGHTNING             39945
#define SPELL_BLINGING_LIGHT        36950   //not used
#define SPELL_LIGHT_OF_THE_NAARU_1  39828
#define SPELL_LIGHT_OF_THE_NAARU_2  39831   //spell_linked
#define SPELL_CARRION_SWARM         39942
#define SPELL_INFERNO               39941
#define SPELL_SLEEP                 12098

//NPC text's
#define MAIEV_YELL        "I've waited for this moment for years. Illidan and his lapdogs will be destroyed! "
#define AKAMA_START       "Now it's the time, Maiev! Unleash your wrath!"
#define AKAMA_YELL        "Slay all who see us! Word must not get back to Illidan."
#define AKAMA_KILL        "Akama has no master. Not anymore."
#define VAGATH_AGGRO      "Pitiful wretches. You dared to assault Illidan's temple? Very well, I shall make it your death bed!"
#define VAGATH_INTRO      "A miserable defense from Light-swollen fools. Xi'ri, I will consume you myself! "
#define VAGATH_DEATH      "You'ves sealed your fate, Akama! The master will learn of your betrayal! "
#define XIRI_GOSSIP_HELLO "I am ready to join your forces in Battle Xi'ri"

//NPC spawn positions and Waypoints
static float MaievBT[4] =
{
    -3554.0, 740.0, -15.4, 4.70
};

static float MaievWaypoint[][3] =
{
    {-3554.0, 731.0, -15.0},
    {-3554.0, 700.0, - 9.3},
    {-3554.0, 650.0,  1.71},
    {-3554.0, 600.0,  9.30},
    {-3554.0, 540.0,  16.5},
    {-3561.8, 523.0,  17.9},
    {-3556.4, 490.0,  22.0},
    {-3570.0, 462.0,  24.5},
    {-3576.6, 428.7,  28.6},
    {-3586.0, 414.2,  31.2},
    {-3593.0, 382.6,  34.0},
    {-3599.1, 362.4,  35.2},
    {-3606.4, 345.7,  39.3},
    {-3633.1, 327.7,  38.8}
};

static float AkamaBT[4] =
{
    -3570.2, 684.5, -5.22, 4.70
};

static float AkamaWaypoint[][3] =
{
    {-3570.2, 654.5, 0.76},
    {-3570.2, 624.5, 5.78},
    {-3570.2, 594.5, 9.71},
    {-3570.2, 564.5, 12.7},
    {-3559.8, 534.5, 16.9},
    {-3559.8, 473.0, 23.3},
    {-3568.5, 423.0, 28.4},
    {-3568.0, 375.0, 32.7},
    {-3614.5, 330.2, 40.3},
    {-3644.6, 315.4, 37.4}
};

static float Deathsworn[8][4] =
{
    {-3561.0, 720.0, -12.0, 1.56},
    {-3557.0, 730.0, -13.6, 1.56},
    {-3553.0, 735.0, -15.8, 1.56},
    {-3549.0, 740.0, -16.7, 1.56},
    {-3546.0, 745.0, -16.7, 1.56},
    {-3565.0, 733.0, -13.0, 1.56},
    {-3569.0, 738.0, -12.6, 1.56},
    {-3573.0, 743.0, -11.9, 1.56}
};

static float DeathswornPath[8][3] =
{
    {-3561.0, 600.0, 9.20},
    {-3557.0, 610.0, 8.00},
    {-3553.0, 615.0, 7.60},
    {-3549.0, 620.0, 7.30},
    {-3545.0, 625.0, 7.10},
    {-3565.0, 613.0, 7.40},
    {-3569.0, 618.0, 6.80},
    {-3573.0, 623.0, 6.10}
};

static float DeathswornWaypoint[][3] =
{
    {-3561.3, 537.2, 16.6},
    {-3553.4, 500.9, 20.0},
    {-3566.0, 484.6, 22.4},
    {-3567.3, 457.0, 25.1},
    {-3571.0, 417.7, 28.9},
    {-3562.5, 379.2, 32.2},
    {-3603.7, 346.0, 39.2},
    {-3631.7, 327.1, 38.8}
};

static float Vagath[4] =
{
    -3570.7, 453.4, 25.72, 1.56
};

static float ShadowlordPos[6][4] =
{
    {-3555.9, 522.2, 18.20, 1.64},
    {-3549.0, 519.4, 19.00, 1.54},
    {-3540.5, 517.0, 20.30, 1.73},
    {-3572.6, 486.4, 22.50, 1.34},
    {-3582.3, 489.8, 23.29, 1.30},
    {-3592.0, 487.5, 24.23, 1.25}
};

/*#####
# npc_maiev_BT_attu
######*/

struct npc_maiev_BT_attuAI : public npc_escortAI
{
    npc_maiev_BT_attuAI(Creature* c) : npc_escortAI(c) {}

    bool moving;
    uint32 FanOfBlades;

    void Reset()
    {
        moving = false;
        FanOfBlades = urand(2000, 6000);
    }

    void MoveInLineOfSight(Unit* who)
    {
        if(!m_creature->isInCombat() && (who->GetEntry() == 22988 || who->GetEntry() == 23152) && m_creature->IsWithinDistInMap(who, 20))
            m_creature->AI()->AttackStart(who);
    }

    void WaypointReached(uint32 id)
    {
        if(id == 3)
            DoYell(MAIEV_YELL, 0, 0);
        if(id == 10)
            DoCast(m_creature, SPELL_STEALTH);
    }

    void UpdateAI(const uint32 diff)
    {
        npc_escortAI::UpdateAI(diff);

        if(!moving)
        {
            if(!HasEscortState(STATE_ESCORT_ESCORTING))
                npc_escortAI::Start(true, true);
            moving = true;
        }

        if(UpdateVictim())
        {
            if(FanOfBlades < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_FAN_OF_BLADES);
                FanOfBlades = urand(8000, 16000);
            }
            else
                FanOfBlades -= diff;
        }
    }

};

CreatureAI* GetAI_npc_maiev_BT_attu(Creature *_Creature)
{
    npc_maiev_BT_attuAI* Maiev_BTattu_AI = new npc_maiev_BT_attuAI (_Creature);

    for(uint32 i = 0; i < 14; ++i)
    {
        Maiev_BTattu_AI->AddWaypoint(i+1, MaievWaypoint[i][0], MaievWaypoint[i][1], MaievWaypoint[i][2]);
    }

    return (CreatureAI*)Maiev_BTattu_AI;
}

/*#####
# npc_akama_BT_attu
######*/

struct npc_akama_BT_attuAI : public npc_escortAI
{
    npc_akama_BT_attuAI(Creature* c) : npc_escortAI(c) {}

    bool moving;
    bool yell;
    bool say;
    uint32 ChainLightning;
    uint32 YellCounter;
    uint32 KillSayTimer;

    void Reset()
    {
        ChainLightning = 1000;
        moving = false;
        say = false;
        yell = false;
    }

    void MoveInLineOfSight(Unit* who)
    {
        if(!m_creature->isInCombat() && (who->GetEntry() == 22988 || who->GetEntry() == 23152) && m_creature->IsWithinDistInMap(who, 20))
            m_creature->AI()->AttackStart(who);
    }

    void WaypointReached(uint32 id)
    {
        if(id == 2)
            DoYell(AKAMA_START, 0, 0);
        if(id == 4)
        {
            yell = true;
            YellCounter = 10000;
        }
        if(id == 7)
        {
            say = true;
            KillSayTimer = 3000;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        npc_escortAI::UpdateAI(diff);

        if(yell && YellCounter < diff)
        {
            DoYell(AKAMA_YELL, 0, 0);
            yell = false;
        }
        else
            YellCounter -= diff;

        if(say && KillSayTimer < diff)
        {
            DoSay(AKAMA_KILL, 0, 0);
            say = false;
        }
        else
            KillSayTimer -= diff;

        if(!moving)
        {
            if(!HasEscortState(STATE_ESCORT_ESCORTING))
                npc_escortAI::Start(true, true);
            moving = true;
        }

        if(UpdateVictim())
        {
            if(ChainLightning < diff)
            {
                DoCast(m_creature->getVictim(), CHAIN_LIGHTNING);
                ChainLightning = urand(5000, 10000);
            }
            else
                ChainLightning -= diff;
        }
    }

};

CreatureAI* GetAI_npc_akama_BT_attu(Creature *_Creature)
{
    npc_akama_BT_attuAI* Akama_BTattu_AI = new npc_akama_BT_attuAI (_Creature);

    for(uint32 i = 0; i < 3; ++i)
    {
        Akama_BTattu_AI->AddWaypoint(i+1, AkamaWaypoint[i][0], AkamaWaypoint[i][1], AkamaWaypoint[i][2]);
    }
    Akama_BTattu_AI->AddWaypoint(4, AkamaWaypoint[3][0], AkamaWaypoint[3][1], AkamaWaypoint[3][2], 15000);
    for(uint32 i = 4; i < 6; ++i)
    {
        Akama_BTattu_AI->AddWaypoint(i+1, AkamaWaypoint[i][0], AkamaWaypoint[i][1], AkamaWaypoint[i][2]);
    }
    Akama_BTattu_AI->AddWaypoint(7, AkamaWaypoint[6][0], AkamaWaypoint[6][1], AkamaWaypoint[6][2], 5000);
    for(uint32 i = 7; i < 10; ++i)
    {
        Akama_BTattu_AI->AddWaypoint(i+1, AkamaWaypoint[i][0], AkamaWaypoint[i][1], AkamaWaypoint[i][2]);
    }
    return (CreatureAI*)Akama_BTattu_AI;
}

/*#####
# npc_ashtongue_deathsworn
######*/

struct npc_ashtongue_deathswornAI : public npc_escortAI
{
    npc_ashtongue_deathswornAI(Creature* c) : npc_escortAI(c) {}

    uint32 AttackTimer;
    bool intro;

    void Reset()
    {
        if(!HasEscortState(STATE_ESCORT_ESCORTING))
        {
            AttackTimer = 25000;
            intro = false;
        }
    }

    void MoveInLineOfSight(Unit* who)
    {
        if(!m_creature->isInCombat() && (who->GetEntry() == 22988 || who->GetEntry() == 23152 || who->GetEntry() == 21166) && m_creature->IsWithinDistInMap(who, 30))
            m_creature->AI()->AttackStart(who);
    }

    void WaypointReached(uint32) { }

    void UpdateAI(const uint32 diff)
    {
        if(!intro && AttackTimer < diff)
        {
            intro = true;
            if(!HasEscortState(STATE_ESCORT_ESCORTING))
                npc_escortAI::Start(true, true);
        }
        else
            AttackTimer -= diff;

        npc_escortAI::UpdateAI(diff);
    }
};

CreatureAI* GetAI_npc_ashtongue_deathsworn(Creature *_Creature)
{
    npc_ashtongue_deathswornAI* Deathsworn_AI = new npc_ashtongue_deathswornAI (_Creature);

    for(uint32 i = 0; i < 8; ++i)
    {
        Deathsworn_AI->AddWaypoint(i+2, DeathswornWaypoint[i][0], DeathswornWaypoint[i][1], DeathswornWaypoint[i][2]);
    }
    return (CreatureAI*)Deathsworn_AI;
}

/*#####
# mob_vagath
######*/

struct mob_vagathAI : public ScriptedAI
{
    mob_vagathAI(Creature* c) : ScriptedAI(c) {}

    void Reset()
    {
        DoYell(VAGATH_INTRO, 0, 0);
    }

    void EnterCombat(Unit* who)
    {
        DoYell(VAGATH_AGGRO, 0, 0);
    }

    void JustDied(Unit* killer)
    {
        DoYell(VAGATH_DEATH, 0, 0);
    }

    void UpdateAI(const uint32 diff)
    {
        if(UpdateVictim())
            DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_vagath(Creature* _Creature)
{
    return new mob_vagathAI(_Creature);
}

/*#####
# mob_illidari_shadowlord
######*/

struct mob_illidari_shadowlordAI : public ScriptedAI
{
    mob_illidari_shadowlordAI(Creature* c) : ScriptedAI(c) {}

    uint32 CarrionSwarm;
    uint32 Inferno;
    uint32 Sleep;

    void Reset()
    {
        CarrionSwarm = urand(4000, 10000);
        Inferno = urand(6000, 15000);
        Sleep = urand(2000, 30000);
    }

    void UpdateAI(const uint32 diff)
    {
        if(UpdateVictim())
        {
            if(CarrionSwarm < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_CARRION_SWARM);
                CarrionSwarm = urand(8000, 16000);
            }
            else
                CarrionSwarm -= diff;

            if(Inferno < diff)
            {
                DoCast(m_creature->getVictim(), SPELL_INFERNO);
                Inferno = urand(35000, 50000);
            }
            else
                Inferno -= diff;

            if(Sleep < diff)
            {
                if(!urand(0, 3))
                    DoCast(m_creature->getVictim(), SPELL_SLEEP);
                Sleep = 60000;
            }
            else
                Sleep -= diff;

            DoMeleeAttackIfReady();
        }
    }
};

CreatureAI* GetAI_mob_illidari_shadowlord(Creature* _Creature)
{
    return new mob_illidari_shadowlordAI(_Creature);
}

/*#####
# npc_xiri
######*/

struct npc_xiriAI : public Scripted_NoMovementAI
{
    npc_xiriAI(Creature* c) : Scripted_NoMovementAI(c) {}

    bool EventStarted;
    uint64 PlayerGUID;
    uint32 QuestTimer;

    void Reset()
    {
        QuestTimer = 140000;
        PlayerGUID = 0;
        EventStarted = false;
    }

    void StartEvent()
    {
        DoPlaySoundToSet(m_creature,BLACK_TEMPLE_PRELUDE_MUSIC);
        SummonEnemies();
        SummonAttackers();
        DoCast(m_creature, SPELL_LIGHT_OF_THE_NAARU_1);
        EventStarted = true;
    }

    void SummonEnemies()
    {
        //Summon Shadowlords
        for(uint32 i = 0; i < 6; i++)
            m_creature->SummonCreature(MOB_ILLIDARI_SHADOWLORD, ShadowlordPos[i][0], ShadowlordPos[i][1], ShadowlordPos[i][2], ShadowlordPos[i][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
        //Summon Vagath
        m_creature->SummonCreature(MOB_VAGATH, Vagath[0], Vagath[1], Vagath[2], Vagath[3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
    }

    void SummonAttackers()
    {
        //Summon Akama
        m_creature->SummonCreature(NPC_AKAMA_BT, AkamaBT[0], AkamaBT[1], AkamaBT[2], AkamaBT[3], TEMPSUMMON_CORPSE_DESPAWN, 0);
        //Summon Maiev
        m_creature->SummonCreature(NPC_MAIEV_SHADOWSONG, MaievBT[0], MaievBT[1], MaievBT[2], MaievBT[3], TEMPSUMMON_CORPSE_DESPAWN, 0);
        //Summon Ashtongue Deathsworns
        for(uint32 i = 0; i < 8; ++i)
        {
            Creature* DeathswornAttacker = m_creature->SummonCreature(NPC_ASHTONGUE_DEATHSWORN, Deathsworn[i][0], Deathsworn[i][1], Deathsworn[i][2], Deathsworn[i][3], TEMPSUMMON_CORPSE_DESPAWN, 0);
            if(DeathswornAttacker)
            {
                if(DeathswornAttacker->IsWalking())
                    DeathswornAttacker->SetWalk(false);
                DeathswornAttacker->GetMotionMaster()->MovePoint(1, DeathswornPath[i][0], DeathswornPath[i][1], DeathswornPath[i][2]);
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(EventStarted)
        {
            if(QuestTimer < diff)
            {
                Player* pl = m_creature->GetPlayer(PlayerGUID);
                if(pl && pl->GetQuestStatus(10985) == QUEST_STATUS_INCOMPLETE)
                    pl->GroupEventHappens(10985, m_creature);
                Reset();
            }
            else
                QuestTimer -= diff;
        }

    }
};

CreatureAI* GetAI_npc_xiri(Creature *_Creature)
{
    return new npc_xiriAI (_Creature);
}

/*#####
# Xi'ri gossips
######*/

bool GossipHello_npc_xiri(Player *player, Creature *_Creature)
{
    bool EventStarted = ((npc_xiriAI*)_Creature->AI())->EventStarted;

    if(EventStarted)
        return false;

    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if (player->GetQuestStatus(10985) == QUEST_STATUS_INCOMPLETE)
    {
        player->ADD_GOSSIP_ITEM( 0, XIRI_GOSSIP_HELLO, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    }
    else
        player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_xiri(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch(action)
    {
        case GOSSIP_ACTION_INFO_DEF:
            player->CLOSE_GOSSIP_MENU();
            ((npc_xiriAI*)_Creature->AI())->StartEvent();
            ((npc_xiriAI*)_Creature->AI())->PlayerGUID = player->GetGUID();
            break;
    }
    return true;
}

/*#######
# Quest: To Legion Hold
########*/

/*#####
# mob_deathbringer_joovan
######*/

#define IMAGE_OF_WARBRINGER     21502

#define DEATHBRINGER_SAY1   "Everything is in readiness, warbringer."
#define WARBRINGER_SAY1     "Doom Lord Kazzak will be pleased. You are to increase the pace of your attacks. Destroy the orcish and dwarven strongholds with all haste."
#define DEATHBRINGER_SAY2   "Warbringer, that will require the use of all the hold's infernals. It may leave us vulnerable to a counterattack."
#define WARBRINGER_SAY2     "Don't worry about that. I've increased production at the Deathforge. You'll have all the infernals you need to carry out your orders. Don't fail, Jovaan."
#define DEATHBRINGER_SAY3   "It shall be as you say, warbringer. One last question, if I may..."
#define WARBRINGER_SAY3     "Yes?"
#define DEATHBRINGER_SAY4   "What's in the crate?"
#define WARBRINGER_SAY4     "Crate? I didn't send you a crate, Jovaan. Don't you have more important things to worry about? Go see to them!"

float deathbringer_joovanWP[2][3] = {
    { -3320, 2948, 172 },
    { -3304, 2931, 171 }
};

float imageOfWarbringerSP[4] = { -3300, 2927, 173.4, 2.40 };

struct mob_deathbringer_joovanAI : public ScriptedAI
{
    bool EventStarted;
    bool ContinueMove;
    uint64 ImageOfWarbringerGUID;
    uint32 EventTimer;
    uint8 EventCounter;

    mob_deathbringer_joovanAI(Creature* c) : ScriptedAI(c)
    {
        ImageOfWarbringerGUID = 0;
    }


    void Reset()
    {
        me->GetMotionMaster()->MovePoint(0, deathbringer_joovanWP[0][0], deathbringer_joovanWP[0][1], deathbringer_joovanWP[0][2]);
        EventStarted = false;

        if(ImageOfWarbringerGUID)
        {
            if(Unit* unit = me->GetUnit(*me, ImageOfWarbringerGUID))
            {
                unit->CombatStop();
                unit->AddObjectToRemoveList();
            }
            ImageOfWarbringerGUID = 0;
        }
        ContinueMove = false;
    }

    void JustSummoned(Creature *creature)
    {
        ImageOfWarbringerGUID = creature->GetGUID();
        EventStarted = true;
        EventTimer = 0;
        EventCounter = 0;
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if(type != POINT_MOTION_TYPE)
            return;

        switch(id)
        {
            case 0:
                ContinueMove = true;
                break;
            case 1:
                me->SummonCreature(IMAGE_OF_WARBRINGER, imageOfWarbringerSP[0], imageOfWarbringerSP[1], imageOfWarbringerSP[2], imageOfWarbringerSP[3], TEMPSUMMON_TIMED_DESPAWN, 120000);
                me->SetStandState(PLAYER_STATE_KNEEL);
                break;
            case 2:
            {
                if(Creature* warbringer = (Creature*)me->GetUnit(*me, ImageOfWarbringerGUID))
                {
                    warbringer->CombatStop();
                    warbringer->AddObjectToRemoveList();
                }
                me->CombatStop();
                me->AddObjectToRemoveList();
                break;
            }

        }
    }

    void WarbringerSay(const char* text)
    {
        if(Creature* unit = (Creature*)me->GetUnit(*me, ImageOfWarbringerGUID))
            unit->Say(text, 0, 0);
    }

    void UpdateAI(const uint32 diff)
    {
        if(ContinueMove)
        {
            me->GetMotionMaster()->MovePoint(1, deathbringer_joovanWP[1][0], deathbringer_joovanWP[1][1], deathbringer_joovanWP[1][2]);
            ContinueMove = false;
        }

        if(EventStarted)
        {
            if(EventTimer < diff)
            {
                switch(EventCounter)
                {
                    case 0:
                        me->Say(DEATHBRINGER_SAY1, 0, 0);
                        break;
                    case 1:
                        WarbringerSay(WARBRINGER_SAY1);
                        break;
                    case 2:
                        me->Say(DEATHBRINGER_SAY2, 0, 0);
                        break;
                    case 3:
                        WarbringerSay(WARBRINGER_SAY2);
                        break;
                    case 4:
                        me->Say(DEATHBRINGER_SAY3, 0, 0);
                        break;
                    case 5:
                        WarbringerSay(WARBRINGER_SAY3);
                        break;
                    case 6:
                        me->Say(DEATHBRINGER_SAY4, 0, 0);
                        break;
                    case 7:
                    {
                        WarbringerSay(WARBRINGER_SAY4);

                        std::list<Unit*> pList;
                        Looking4group::AnyUnitInObjectRangeCheck u_check(me, 20.0f);
                        Looking4group::UnitListSearcher<Looking4group::AnyUnitInObjectRangeCheck> searcher(pList, u_check);

                        Cell::VisitAllObjects(me, searcher, 20.0f);

                        Creature* warbringer = (Creature*)me->GetUnit(*me, ImageOfWarbringerGUID);
                        if(!warbringer)
                            break;

                        for(std::list<Unit*>::iterator it = pList.begin(); it != pList.end(); it++)
                        {
                            if((*it)->GetTypeId() == TYPEID_PLAYER)
                            {
                                Player *p = (Player*)(*it);
                                if(p->HasAura(37097, 0))
                                {
                                    // event happens nie dziala, a powinien!
                                    p->AreaExploredOrEventHappens(10596);
                                    p->AreaExploredOrEventHappens(10563);
                                    // dlatego recznie musimy complete quest dac
                                    p->CompleteQuest(10596);
                                    p->CompleteQuest(10563);
                                }
                            }
                        }
                        break;
                    }
                    case 8:
                    {
                        me->GetMotionMaster()->MovePoint(2, deathbringer_joovanWP[0][0], deathbringer_joovanWP[0][1], deathbringer_joovanWP[0][2]);
                        break;
                    }
                }
                EventCounter++;
                if(EventCounter == 8)
                    EventTimer = 1000;
                else
                    EventTimer = 4000;
            }
            else
                EventTimer -= diff;
        }
/*
        if(!UpdateVictim())
            return;

        me->Say("Deathbringer victim found, stopping event", 0, 0);

        EventStarted = false;
       DoMeleeAttackIfReady();*/
    }
};

CreatureAI* GetAI_mob_deathbringer_joovanAI(Creature *_Creature)
{
    return new mob_deathbringer_joovanAI(_Creature);
}

/*####
# npc_overlord_orbarokh
####*/

#define GOSSIP_ITEM_ORBAROKH "Restore Kor'kron Flare Gun."

bool GossipHello_npc_overlord_orbarokh(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

        if(player->GetQuestStatus(10751) || player->GetQuestStatus(10765) || player->GetQuestStatus(10768) || player->GetQuestStatus(10769) == QUEST_STATUS_INCOMPLETE )
            if(!player->HasItemCount(31108,1))
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_ORBAROKH, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO );
                player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_overlord_orbarokh(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if( action == GOSSIP_SENDER_INFO )
    {
            ItemPosCountVec dest;
            uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 31108, 1);
            if (msg == EQUIP_ERR_OK)
            {
                 Item* item = player->StoreNewItem(dest, 31108, true);
                     player->SendNewItem(item,1,true,false,true);
            }
    }
    return true;
}

/*####
# npc_thane_yoregar
####*/

#define GOSSIP_ITEM_YOREGAR "Restore Wildhammer Flare Gun."

bool GossipHello_npc_thane_yoregar(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

        if(player->GetQuestStatus(10773) || player->GetQuestStatus(10774) || player->GetQuestStatus(10775) || player->GetQuestStatus(10776) == QUEST_STATUS_INCOMPLETE )
            if(!player->HasItemCount(31310,1))
                player->ADD_GOSSIP_ITEM( 0, GOSSIP_ITEM_YOREGAR, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO );
                player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_thane_yoregar(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if( action == GOSSIP_SENDER_INFO )
    {
            ItemPosCountVec dest;
            uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 31310, 1);
            if (msg == EQUIP_ERR_OK)
            {
                 Item* item = player->StoreNewItem(dest, 31310, true);
                     player->SendNewItem(item,1,true,false,true);
            }
    }
    return true;
}

bool GOUse_go_forged_illidari_bane(Player *pPlayer, GameObject *pGo)
{
    ItemPosCountVec dest;
    uint8 msg = pPlayer->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 30876, 1);
    if (msg == EQUIP_ERR_OK)
    {
        if (Item* item = pPlayer->StoreNewItem(dest,30876,true))
            pPlayer->SendNewItem(item,1,false,true);
        else
            pPlayer->SendEquipError(msg,NULL,NULL);
    }

    pGo->SetLootState(GO_JUST_DEACTIVATED);
    return true;
}


void AddSC_shadowmoon_valley()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "mob_azaloth";
    newscript->GetAI = &GetAI_mob_azaloth;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_mature_netherwing_drake";
    newscript->GetAI = &GetAI_mob_mature_netherwing_drake;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_enslaved_netherwing_drake";
    newscript->GetAI = &GetAI_mob_enslaved_netherwing_drake;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_dragonmaw_peon";
    newscript->GetAI = &GetAI_mob_dragonmaw_peon;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_drake_dealer_hurlunk";
    newscript->pGossipHello =  &GossipHello_npc_drake_dealer_hurlunk;
    newscript->pGossipSelect = &GossipSelect_npc_drake_dealer_hurlunk;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npcs_flanis_swiftwing_and_kagrosh";
    newscript->pGossipHello =  &GossipHello_npcs_flanis_swiftwing_and_kagrosh;
    newscript->pGossipSelect = &GossipSelect_npcs_flanis_swiftwing_and_kagrosh;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_grand_commander_ruusk";
    newscript->pGossipHello =  &GossipHello_npc_grand_commander_ruusk;
    newscript->pGossipSelect = &GossipSelect_npc_grand_commander_ruusk;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_murkblood_overseer";
    newscript->pGossipHello =  &GossipHello_npc_murkblood_overseer;
    newscript->pGossipSelect = &GossipSelect_npc_murkblood_overseer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_neltharaku";
    newscript->pGossipHello =  &GossipHello_npc_neltharaku;
    newscript->pGossipSelect = &GossipSelect_npc_neltharaku;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_karynaku";
    newscript->pQuestAcceptNPC = &QuestAccept_npc_karynaku;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_oronok_tornheart";
    newscript->pGossipHello =  &GossipHello_npc_oronok_tornheart;
    newscript->pGossipSelect = &GossipSelect_npc_oronok_tornheart;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_overlord_morghor";
    newscript->GetAI = &GetAI_npc_overlord_morghorAI;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_overlord_morghor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_earthmender_wilda";
    newscript->GetAI = &GetAI_npc_earthmender_wildaAI;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_earthmender_wilda;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_lord_illidan_stormrage";
    newscript->GetAI = &GetAI_npc_lord_illidan_stormrage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_crystal_prison";
    newscript->pQuestAcceptGO = &GOQuestAccept_GO_crystal_prison;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_illidari_spawn";
    newscript->GetAI = &GetAI_mob_illidari_spawn;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_torloth_the_magnificent";
    newscript->GetAI = &GetAI_mob_torloth_the_magnificent;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_enraged_spirit";
    newscript->GetAI = &GetAI_npc_enraged_spirit;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_Akama";
    newscript->GetAI = &GetAI_npc_Akama;
    newscript->pQuestRewardedNPC = &ChooseReward_npc_Akama;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_shadowlord_trigger";
    newscript->GetAI = &GetAI_npc_shadowlord_trigger;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadowmoon_soulstealer";
    newscript->GetAI = &GetAI_mob_shadowmoon_soulstealer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_shadowlord_deathwail";
    newscript->GetAI = &GetAI_mob_shadowlord_deathwail;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="felfire_summoner";
    newscript->GetAI = &GetAI_felfire_summoner;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_maiev_BT_attu";
    newscript->GetAI = &GetAI_npc_maiev_BT_attu;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_akama_BT_attu";
    newscript->GetAI = &GetAI_npc_akama_BT_attu;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_ashtongue_deathsworn";
    newscript->GetAI = &GetAI_npc_ashtongue_deathsworn;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_vagath";
    newscript->GetAI = &GetAI_mob_vagath;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_illidari_shadowlord";
    newscript->GetAI = &GetAI_mob_illidari_shadowlord;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_xiri";
    newscript->pGossipHello =  &GossipHello_npc_xiri;
    newscript->pGossipSelect = &GossipSelect_npc_xiri;
    newscript->GetAI = &GetAI_npc_xiri;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_deathbringer_joovan";
    newscript->GetAI = &GetAI_mob_deathbringer_joovanAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_overlord_orbarokh";
    newscript->pGossipHello = &GossipHello_npc_overlord_orbarokh;
    newscript->pGossipSelect = &GossipSelect_npc_overlord_orbarokh;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_thane_yoregar";
    newscript->pGossipHello = &GossipHello_npc_thane_yoregar;
    newscript->pGossipSelect = &GossipSelect_npc_thane_yoregar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="go_forged_illidari_bane";
    newscript->pGOUse = &GOUse_go_forged_illidari_bane;
    newscript->RegisterSelf();
}
