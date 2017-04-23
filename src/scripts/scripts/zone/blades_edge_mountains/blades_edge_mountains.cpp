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
SDName: Blades_Edge_Mountains
SD%Complete: 98
SDComment: Quest support: 10503, 10504, 10556, 10609, 10682, 10980, 10518, 10859, 10674, 11058 ,11080, 11059, 10675, 10867, 10557, 10710, 10711, 10712, 10821, 10911, 10723, 10802, 11000, 11026, 11051, 10506. Assault on Bash'ir Landing!. Ogri'la->Skettis Flight. (npc_daranelle needs bit more work before consider complete)
SDCategory: Blade's Edge Mountains
EndScriptData */

/* ContentData
mobs_nether_drake
npc_daranelle
npc_overseer_nuaar
npc_saikkal_the_elder
npc_skyguard_handler_irena
npc_bloodmaul_brutebane
npc_ogre_brute
npc_vim_bunny
npc_aether_ray
npc_wildlord_antelarion
npc_kolphis_darkscale
npc_prophecy_trigger
go_thunderspike
go_apexis_relic
go_simon_cluster
npc_simon_bunny
npc_orb_attracter
npc_razaan_event
npc_razaani_raide
npc_rally_zapnabber
npc_anger_camp
go_obeliks
npc_cannon_target
npc_gargrom
npc_soulgrinder
npc_bashir_landing
npc_banishing_crystal
mob_phase_wyrm
npc_bloodmaul_dire_wolf
EndContentData */

#include "precompiled.h"

/*######
## mobs_nether_drake
######*/

#define SAY_NIHIL_1                 -1000396
#define SAY_NIHIL_2                 -1000397
#define SAY_NIHIL_3                 -1000398
#define SAY_NIHIL_4                 -1000399
#define SAY_NIHIL_INTERRUPT         -1000400

#define ENTRY_WHELP                 20021
#define ENTRY_PROTO                 21821
#define ENTRY_ADOLE                 21817
#define ENTRY_MATUR                 21820
#define ENTRY_NIHIL                 21823

#define SPELL_T_PHASE_MODULATOR     37573

#define SPELL_ARCANE_BLAST          38881
#define SPELL_MANA_BURN             38884
#define SPELL_INTANGIBLE_PRESENCE   36513

struct mobs_nether_drakeAI : public ScriptedAI
{
    mobs_nether_drakeAI(Creature* creature) : ScriptedAI(creature) {}

    bool IsNihil;
    uint32 NihilSpeech_Timer;
    uint32 NihilSpeech_Phase;

    uint32 ArcaneBlast_Timer;
    uint32 ManaBurn_Timer;
    uint32 IntangiblePresence_Timer;

    void Reset()
    {
        NihilSpeech_Timer = 2000;
        IsNihil = false;

        if (me->GetEntry() == ENTRY_NIHIL)
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            IsNihil = true;
        }

        NihilSpeech_Phase = 1;

        ArcaneBlast_Timer = 7500;
        ManaBurn_Timer = 10000;
        IntangiblePresence_Timer = 15000;
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if (spell->Id == SPELL_T_PHASE_MODULATOR && caster->GetTypeId() == TYPEID_PLAYER)
        {
            uint32 cEntry = 0;

            switch (me->GetEntry())
            {
                case ENTRY_WHELP:
                    cEntry = RAND(ENTRY_PROTO, ENTRY_ADOLE, ENTRY_MATUR, ENTRY_NIHIL);
                    break;
                case ENTRY_PROTO:
                    cEntry = RAND(ENTRY_ADOLE, ENTRY_MATUR, ENTRY_NIHIL);
                    break;
                case ENTRY_ADOLE:
                    cEntry = RAND(ENTRY_PROTO, ENTRY_MATUR, ENTRY_NIHIL);
                    break;
                case ENTRY_MATUR:
                    cEntry = RAND(ENTRY_PROTO, ENTRY_ADOLE, ENTRY_NIHIL);
                    break;
                case ENTRY_NIHIL:
                    if (NihilSpeech_Phase)
                    {
                        DoScriptText(SAY_NIHIL_INTERRUPT, me);
                        IsNihil = false;
                        cEntry = RAND(ENTRY_PROTO, ENTRY_ADOLE, ENTRY_MATUR);
                    }
                    break;
            }

            if (cEntry)
            {
                me->UpdateEntry(cEntry);

                if (cEntry == ENTRY_NIHIL)
                {
                    me->InterruptNonMeleeSpells(true);
                    me->RemoveAllAuras();
                    me->DeleteThreatList();
                    me->CombatStop(true);
                    Reset();
                }
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (IsNihil)
        {
            if (NihilSpeech_Phase)
            {
                if (NihilSpeech_Timer <= diff)
                {
                    switch (NihilSpeech_Phase)
                    {
                        case 1:
                            DoScriptText(SAY_NIHIL_1, me);
                            ++NihilSpeech_Phase;
                            break;
                        case 2:
                            DoScriptText(SAY_NIHIL_2, me);
                            ++NihilSpeech_Phase;
                            break;
                        case 3:
                            DoScriptText(SAY_NIHIL_3, me);
                            ++NihilSpeech_Phase;
                            break;
                        case 4:
                            DoScriptText(SAY_NIHIL_4, me);
                            ++NihilSpeech_Phase;
                            break;
                        case 5:
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            me->SetLevitate(true);
                            //then take off to random location. creature is initially summoned, so don't bother do anything else.
                            me->GetMotionMaster()->MovePoint(0, me->GetPositionX()+100, me->GetPositionY(), me->GetPositionZ()+100);
                            NihilSpeech_Phase = 0;
                            break;
                    }
                    NihilSpeech_Timer = 5000;
                }
                else
                    NihilSpeech_Timer -=diff;
            }
            return;                                         //anything below here is not interesting for Nihil, so skip it
        }

        if (!UpdateVictim())
            return;

        if (IntangiblePresence_Timer <= diff)
        {
            DoCast(me->getVictim(),SPELL_INTANGIBLE_PRESENCE);
            IntangiblePresence_Timer = 15000+rand()%15000;
        }
        else
            IntangiblePresence_Timer -= diff;

        if (ManaBurn_Timer <= diff)
        {
            Unit* target = me->getVictim();
            if (target && target->getPowerType() == POWER_MANA)
                DoCast(target,SPELL_MANA_BURN);
            ManaBurn_Timer = 8000+rand()%8000;
        }
        else
            ManaBurn_Timer -= diff;

        if (ArcaneBlast_Timer <= diff)
        {
            DoCast(me->getVictim(),SPELL_ARCANE_BLAST);
            ArcaneBlast_Timer = 2500+rand()%5000;
        }
        else
            ArcaneBlast_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_mobs_nether_drake(Creature* creature)
{
    return new mobs_nether_drakeAI (creature);
}

/*######
## npc_daranelle
######*/

#define SAY_DARANELLE -1000401

struct npc_daranelleAI : public ScriptedAI
{
    npc_daranelleAI(Creature* creature) : ScriptedAI(creature) {}

    void Reset()
    {
    }

    void MoveInLineOfSight(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
        {
            if (who->HasAura(36904,0))
            {
                DoScriptText(SAY_DARANELLE, me, who);
                //TODO: Move the below to updateAI and run if this statement == true
                ((Player*)who)->KilledMonster(21511, me->GetGUID());
                ((Player*)who)->RemoveAurasDueToSpell(36904);
            }
        }

        ScriptedAI::MoveInLineOfSight(who);
    }
};

CreatureAI* GetAI_npc_daranelle(Creature* creature)
{
    return new npc_daranelleAI (creature);
}

/*######
## npc_overseer_nuaar
######*/

#define GOSSIP_HON "Overseer, I am here to negotiate on behalf of the Cenarion Expedition."

bool GossipHello_npc_overseer_nuaar(Player* player, Creature* creature)
{
    if (player->GetQuestStatus(10682) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_HON, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(10532, creature->GetGUID());

    return true;
}

bool GossipSelect_npc_overseer_nuaar(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        player->SEND_GOSSIP_MENU(10533, creature->GetGUID());
        player->AreaExploredOrEventHappens(10682);
    }
    return true;
}

/*######
## npc_saikkal_the_elder
######*/

#define GOSSIP_HSTE "Yes... yes, it's me."
#define GOSSIP_SSTE "Yes elder. Tell me more of the book."

bool GossipHello_npc_saikkal_the_elder(Player* player, Creature* creature)
{
    if (player->GetQuestStatus(10980) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_HSTE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(10794, creature->GetGUID());

    return true;
}

bool GossipSelect_npc_saikkal_the_elder(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_SSTE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(10795, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->TalkedToCreature(creature->GetEntry(), creature->GetGUID());
            player->SEND_GOSSIP_MENU(10796, creature->GetGUID());
            break;
    }
    return true;
}

/*######
## npc_skyguard_handler_irena
######*/

#define GOSSIP_SKYGUARD "Fly me to Skettis please"

bool GossipHello_npc_skyguard_handler_irena(Player* player, Creature* creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu(creature->GetGUID());

    if (player->GetReputationMgr().GetRank(1031) >= REP_HONORED)
        player->ADD_GOSSIP_ITEM(2, GOSSIP_SKYGUARD, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());

    return true;
}

bool GossipSelect_npc_skyguard_handler_irena(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        player->CLOSE_GOSSIP_MENU();

        std::vector<uint32> nodes;

        nodes.resize(2);
        nodes[0] = 172;                                     //from ogri'la
        nodes[1] = 171;                                     //end at skettis
        player->ActivateTaxiPathTo(nodes);                  //TaxiPath 706
    }
    return true;
}

/*######
## npc_bloodmaul_brutebane
######*/

enum eBloodmaul
{
    NPC_OGRE_BRUTE                       = 19995,
    NPC_QUEST_CREDIT                     = 21241,
    GO_KEG                               = 184315
};

struct npc_bloodmaul_brutebaneAI : public ScriptedAI
{
    npc_bloodmaul_brutebaneAI(Creature* creature) : ScriptedAI(creature){}

    void IsSummonedBy(Unit* pOwner)
    {
       if (Creature* pOgre = GetClosestCreatureWithEntry(me, NPC_OGRE_BRUTE, 50.0f))
       {
           pOgre->SetReactState(REACT_DEFENSIVE);
           pOgre->GetMotionMaster()->MovePoint(1, me->GetPositionX()-1, me->GetPositionY()+1, me->GetPositionZ());

           if (Player* plOwner = pOwner->GetCharmerOrOwnerPlayerOrPlayerItself())
               plOwner->KilledMonster(NPC_QUEST_CREDIT, pOgre->GetGUID());
       }
       else if (Creature* pOgre = GetClosestCreatureWithEntry(me, 20726, 50.0f))
       {
           pOgre->SetReactState(REACT_DEFENSIVE);
           pOgre->GetMotionMaster()->MovePoint(1, me->GetPositionX()-1, me->GetPositionY()+1, me->GetPositionZ());

           if (Player* plOwner = pOwner->GetCharmerOrOwnerPlayerOrPlayerItself())
               plOwner->KilledMonster(NPC_QUEST_CREDIT, pOgre->GetGUID());
       }
       else if (Creature* pOgre = GetClosestCreatureWithEntry(me, 20731, 50.0f))
       {
           pOgre->SetReactState(REACT_DEFENSIVE);
           pOgre->GetMotionMaster()->MovePoint(1, me->GetPositionX()-1, me->GetPositionY()+1, me->GetPositionZ());

           if (Player* plOwner = pOwner->GetCharmerOrOwnerPlayerOrPlayerItself())
               plOwner->KilledMonster(NPC_QUEST_CREDIT, pOgre->GetGUID());
       }
    }

    void UpdateAI(const uint32 uiDiff){}
};

CreatureAI* GetAI_npc_bloodmaul_brutebane(Creature* creature)
{
    return new npc_bloodmaul_brutebaneAI (creature);
}

/*######
## npc_ogre_brute
######*/

struct npc_ogre_bruteAI : public ScriptedAI
{
    npc_ogre_bruteAI(Creature* creature) : ScriptedAI(creature){}

    void MovementInform(uint32 type, uint32 id)
    {
        if (type != POINT_MOTION_TYPE || id != 1)
            return;

        if (GameObject* pKeg = FindGameObject(GO_KEG, 20.0, me))
            pKeg->Delete();

        me->HandleEmoteCommand(7);
        me->SetReactState(REACT_AGGRESSIVE);

        if (!me->getVictim())
            me->GetMotionMaster()->MoveTargetedHome();
        else
            me->GetMotionMaster()->MoveChase(me->getVictim());
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_ogre_brute(Creature* creature)
{
    return new npc_ogre_bruteAI(creature);
}

/*######
## npc_vim_bunny
######*/

#define SPELL_PENTAGRAM 39921
#define GO_FLAME_CIRCLE 185555
#define PENTAGRAM_TRIGGER 23040
#define MAIN_SPAWN 22911

struct npc_vim_bunnyAI : public ScriptedAI
{
    npc_vim_bunnyAI(Creature* creature) : ScriptedAI(creature){}

    uint32 CheckTimer;

    void Reset()
    {
        CheckTimer = 1000;
    }

    bool GetPlayer()
    {
        Player* pPlayer = NULL;
        Looking4group::AnyPlayerInObjectRangeCheck p_check(me, 3.0f);
        Looking4group::ObjectSearcher<Player, Looking4group::AnyPlayerInObjectRangeCheck> searcher(pPlayer, p_check);

        Cell::VisitAllObjects(me, searcher, 3.0f);
        return pPlayer;
    }

    void UpdateAI(const uint32 diff)
    {
        if (CheckTimer < diff)
        {
            if (me->GetDistance2d(3279.80f, 4639.76f) < 5.0)
            {
                if (GetClosestCreatureWithEntry(me, MAIN_SPAWN, 80.0f))
                {
                    CheckTimer = 20000;
                    return;
                }

                // WE NEED HERE TO BE SURE THAT SPAWN IS VALID !
                std::list<Creature*> triggers = FindAllCreaturesWithEntry(PENTAGRAM_TRIGGER, 50.0);
                if (triggers.size() >= 5)
                {
                    DoSpawnCreature(MAIN_SPAWN,0,0,0,0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    CheckTimer = 20000;
                    return;
                }
                CheckTimer = 1000;
            }
            else
            {
                if (GetPlayer())
                {
                    Unit* temp = DoSpawnCreature(PENTAGRAM_TRIGGER,0,0,2.0,0, TEMPSUMMON_TIMED_DESPAWN, 15000);
                    temp->CastSpell(temp, SPELL_PENTAGRAM, false);
                    CheckTimer = 16000;
                    return;
                }
                CheckTimer = 2000;
            }
        }
        else
            CheckTimer -= diff;
    }
};

CreatureAI* GetAI_npc_vim_bunny(Creature* creature)
{
    return new npc_vim_bunnyAI (creature);
}

/*######
## Wrangle Some Aether Rays
######*/

// Spells
#define EMOTE_WEAK     "appears ready to be wrangled."
#define SPELL_SUMMON_WRANGLED   40917
#define SPELL_CHANNEL           40626

struct mob_aetherrayAI : public ScriptedAI
{
    mob_aetherrayAI(Creature* creature) : ScriptedAI(creature) {}

    bool Weak;
    uint64 PlayerGUID;

    void Reset()
    {
        Weak = false;
    }

    void EnterCombat(Unit* who)
    {
        if (Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself())
            PlayerGUID = player->GetGUID();
    }

    void JustSummoned(Creature* summoned)
    {
        summoned->GetMotionMaster()->MoveFollow(Unit::GetPlayer(PlayerGUID), PET_FOLLOW_DIST, me->GetFollowAngle());
    }

    void UpdateAI(const uint32 diff)
    {

    if (!UpdateVictim())
            return;

    if (PlayerGUID) // start: support for quest 11066 and 11065
        {
            Player* target = Unit::GetPlayer(PlayerGUID);

            if (target && !Weak && me->GetHealth() < (me->GetMaxHealth() / 100 *40)
                && (target->GetQuestStatus(11066) == QUEST_STATUS_INCOMPLETE || target->GetQuestStatus(11065) == QUEST_STATUS_INCOMPLETE))
            {
                me->MonsterTextEmote(EMOTE_WEAK, 0, false);
                Weak = true;
            }

            if (Weak && me->HasAura(40856, 0))
            {
                me->CastSpell(target, SPELL_SUMMON_WRANGLED, false);
                target->KilledMonster(23343, me->GetGUID());
                me->AttackStop(); // delete the normal mob
                me->DealDamage(me, me->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                me->RemoveCorpse();
            }
        }

        DoMeleeAttackIfReady();
    }


};

CreatureAI* GetAI_mob_aetherray(Creature* creature)
{
    return new mob_aetherrayAI (creature);
}

/*####
# npc_wildlord_antelarion
####*/

#define GOSSIP_ITEM_WILDLORD "Restore Felsworn Gas Mask."
#define GOSSIP_ITEM2_WILDLORD "Restore Druid Signal"

bool GossipHello_npc_wildlord_antelarion(Player* player, Creature* creature)
{
    if (creature->isQuestGiver())
    {
        player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(10819) || player->GetQuestStatus(10820) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(31366,1))
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_WILDLORD, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO);

         if (player->GetQuestStatus(10910) || player->GetQuestStatus(10910) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(31763,1))
             player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM2_WILDLORD, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO+1);

        player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());
    }
    return true;
}

bool GossipSelect_npc_wildlord_antelarion(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    uint32 entry = 0;
    if (action == GOSSIP_SENDER_INFO)
        entry = 31366;
    else if (action == GOSSIP_SENDER_INFO +1)
        entry = 31763;

    if (entry != 0)
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, entry, 1);
        if (msg == EQUIP_ERR_OK)
        {
            Item* item = player->StoreNewItem(dest, entry, true);
            player->SendNewItem(item,1,true,false,true);
        }
        player->CLOSE_GOSSIP_MENU();
    }
    return true;
}

/*########
# npc_kolphis_darkscale
#########*/

#define GOSSIP_ITEM_KOLPHIS1 "I'm fine, thank you. You asked for me?"
#define GOSSIP_ITEM_KOLPHIS2 "Oh, it's not my fault. I can assure you."
#define GOSSIP_ITEM_KOLPHIS3 "Um, no...no, I don't want that at all."
#define GOSSIP_ITEM_KOLPHIS4 "Impressive. When do we attack?"
#define GOSSIP_ITEM_KOLPHIS5 "Absolutely!"

bool GossipHello_npc_kolphis_darkscale(Player* player, Creature* creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu(creature->GetGUID());
    if (player->GetQuestStatus(10722) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KOLPHIS1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(25019, creature->GetGUID());

    return true;
}

bool GossipSelect_npc_kolphis_darkscale(Player* player, Creature* creature, uint32 sender, uint32 action)
{
  switch (action)
  {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KOLPHIS2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(25020, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KOLPHIS3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->SEND_GOSSIP_MENU(25021, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KOLPHIS4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
            player->SEND_GOSSIP_MENU(25022, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+4:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_KOLPHIS5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
            player->SEND_GOSSIP_MENU(25023, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+5:
            player->CompleteQuest(10722);
            player->SEND_GOSSIP_MENU(25024, creature->GetGUID());
            break;
  }
    return true;
}

/*#########
# npc_prophecy_trigger
#########*/

struct npc_prophecy_triggerAI : public ScriptedAI
{
    npc_prophecy_triggerAI(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void MoveInLineOfSight(Unit* pWho)
    {
        if (Player* plWho = pWho->GetCharmerOrOwnerPlayerOrPlayerItself())
        {
            if (plWho->GetQuestStatus(10607) == QUEST_STATUS_INCOMPLETE && plWho->HasAura(37466,0) && plWho->GetDistance(me) < 20.0f)
            {
                switch  (me->GetEntry())
                {
                    case 22798:
                        me->Whisper("From the darkest night shall rise again the raven, shall take flight in the shadows, shall reveal the nature of its kind. Prepare yourself for its coming, for the faithful shall be elevated to take flight with the raven, the rest be forgotten to walk upon the ground, clipped wings and shame.", plWho->GetGUID());
                        break;
                    case 22799:
                        me->Whisper("Steel your minds and guard your thoughts. The dark wings will cloud and consume the minds of the weak, a flock of thralls whose feet may never leave the ground.", plWho->GetGUID());
                        break;
                    case 22800:
                        me->Whisper("The old blood will flow once again with the coming of the raven, the return of the darkness in the skies. Scarlet night, and the rise of the old.", plWho->GetGUID());
                        break;
                    case 22801:
                        me->Whisper("The raven was struck down once for flying too high, unready. The eons have prepared the Dark Watcher for its ascent, to draw the dark cloak across the horizon.", plWho->GetGUID());
                        break;
                }

                plWho->KilledMonster(me->GetEntry(), me->GetGUID());
                me->DisappearAndDie();
            }
        }
    }
};

CreatureAI* GetAI_npc_prophecy_trigger(Creature* creature)
{
    return new npc_prophecy_triggerAI(creature);
}

/*#########
# go_thunderspike
# UPDATE `gameobject_template` SET `ScriptName` = "go_thunderspike" WHERE `entry` = 184729;
#########*/

#define Q_THE_THUNDERSPIKE 10526
#define GOR_GRIMGUT_ENTRY  21319

bool GOUse_go_thunderspike(Player* player, GameObject* go)
{
    if (player->GetQuestStatus(Q_THE_THUNDERSPIKE) == QUEST_STATUS_INCOMPLETE)
    {
        // to prevent spawn spam :)
        if (Creature* pGor = GetClosestCreatureWithEntry(player, GOR_GRIMGUT_ENTRY, 50.0f))
        {
            if (!pGor->getVictim() && pGor->isAlive())
                pGor->AI()->AttackStart(player);

            return false;
        }

        Position dest;
        player->GetValidPointInAngle(dest, 5.0f, frand(0.0f, 2*M_PI), true);

        if (Creature* pGor = player->SummonCreature(GOR_GRIMGUT_ENTRY, dest.x, dest.y, dest.z, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000))
            pGor->AI()->AttackStart(player);
    }

    return false;
}

/*######
## Simon Game - An Apexis Relic
######*/

enum SimonGame
{
    NPC_SIMON_BUNNY                 = 22923,
    NPC_APEXIS_GUARDIAN             = 22275,

    GO_APEXIS_RELIC                 = 185890,
    GO_APEXIS_MONUMENT              = 185944,
    GO_AURA_BLUE                    = 185872,
    GO_AURA_GREEN                   = 185873,
    GO_AURA_RED                     = 185874,
    GO_AURA_YELLOW                  = 185875,

    GO_BLUE_CLUSTER_DISPLAY         = 7369,
    GO_GREEN_CLUSTER_DISPLAY        = 7371,
    GO_RED_CLUSTER_DISPLAY          = 7373,
    GO_YELLOW_CLUSTER_DISPLAY       = 7375,
    GO_BLUE_CLUSTER_DISPLAY_LARGE   = 7364,
    GO_GREEN_CLUSTER_DISPLAY_LARGE  = 7365,
    GO_RED_CLUSTER_DISPLAY_LARGE    = 7366,
    GO_YELLOW_CLUSTER_DISPLAY_LARGE = 7367,

    SPELL_PRE_GAME_BLUE             = 40176,
    SPELL_PRE_GAME_GREEN            = 40177,
    SPELL_PRE_GAME_RED              = 40178,
    SPELL_PRE_GAME_YELLOW           = 40179,
    SPELL_VISUAL_BLUE               = 40244,
    SPELL_VISUAL_GREEN              = 40245,
    SPELL_VISUAL_RED                = 40246,
    SPELL_VISUAL_YELLOW             = 40247,

    SOUND_BLUE                      = 11588,
    SOUND_GREEN                     = 11589,
    SOUND_RED                       = 11590,
    SOUND_YELLOW                    = 11591,
    SOUND_DISABLE_NODE              = 11758,

    SPELL_AUDIBLE_GAME_TICK         = 40391,
    SPELL_VISUAL_START_PLAYER_LEVEL = 40436,
    SPELL_VISUAL_START_AI_LEVEL     = 40387,

    SPELL_BAD_PRESS_TRIGGER         = 41241,
    SPELL_BAD_PRESS_DAMAGE          = 40065,
    SPELL_REWARD_BUFF_1             = 40310,
    SPELL_REWARD_BUFF_2             = 40311,
    SPELL_REWARD_BUFF_3             = 40312,
};

enum SimonEvents
{
    EVENT_SIMON_SETUP_PRE_GAME         = 1,
    EVENT_SIMON_PLAY_SEQUENCE          = 2,
    EVENT_SIMON_RESET_CLUSTERS         = 3,
    EVENT_SIMON_PERIODIC_PLAYER_CHECK  = 4,
    EVENT_SIMON_TOO_LONG_TIME          = 5,
    EVENT_SIMON_GAME_TICK              = 6,
    EVENT_SIMON_ROUND_FINISHED         = 7,

    ACTION_SIMON_CORRECT_FULL_SEQUENCE = 8,
    ACTION_SIMON_WRONG_SEQUENCE        = 9,
    ACTION_SIMON_ROUND_FINISHED        = 10,
};

enum SimonColors
{
    SIMON_BLUE          = 0,
    SIMON_RED           = 1,
    SIMON_GREEN         = 2,
    SIMON_YELLOW        = 3,
    SIMON_MAX_COLORS    = 4,
};

struct npc_simon_bunnyAI : public ScriptedAI
{
    npc_simon_bunnyAI(Creature* creature) : ScriptedAI(creature) { }

    bool large;
    bool listening;
    uint8 gameLevel;
    uint8 fails;
    uint8 gameTicks;
    uint64 playerGUID;
    uint32 clusterIds[SIMON_MAX_COLORS];
    float zCoordCorrection;
    float searchDistance;
    EventMap _events;
    std::list<uint8> colorSequence, playableSequence, playerSequence;

    void UpdateAI(const uint32 diff)
    {
        _events.Update(diff);
        switch (_events.ExecuteEvent())
        {
            case EVENT_SIMON_PERIODIC_PLAYER_CHECK:
                if (!CheckPlayer())
                    ResetNode();
                else
                    _events.ScheduleEvent(EVENT_SIMON_PERIODIC_PLAYER_CHECK, 2000);
                break;
            case EVENT_SIMON_SETUP_PRE_GAME:
                SetUpPreGame();
                _events.CancelEvent(EVENT_SIMON_GAME_TICK);
                _events.ScheduleEvent(EVENT_SIMON_PLAY_SEQUENCE, 1000);
                break;
            case EVENT_SIMON_PLAY_SEQUENCE:
                if (!playableSequence.empty())
                {
                    PlayNextColor();
                    _events.ScheduleEvent(EVENT_SIMON_PLAY_SEQUENCE, 1500);
                }
                else
                {
                    listening = true;
                    AddSpellToCast(SPELL_VISUAL_START_PLAYER_LEVEL, CAST_NULL);
                    playerSequence.clear();
                    PrepareClusters();
                    gameTicks = 0;
                    _events.ScheduleEvent(EVENT_SIMON_GAME_TICK, 3000);
                }
                break;
            case EVENT_SIMON_GAME_TICK:
                AddSpellToCast(SPELL_AUDIBLE_GAME_TICK, CAST_NULL);
                
                if (gameTicks > gameLevel)
                    _events.ScheduleEvent(EVENT_SIMON_TOO_LONG_TIME, 500);
                else
                    _events.ScheduleEvent(EVENT_SIMON_GAME_TICK, 3000);
                gameTicks++;
                break;
            case EVENT_SIMON_RESET_CLUSTERS:
                PrepareClusters(true);
                break;
            case EVENT_SIMON_TOO_LONG_TIME:
                DoAction(ACTION_SIMON_WRONG_SEQUENCE);
                break;
            case EVENT_SIMON_ROUND_FINISHED:
                DoAction(ACTION_SIMON_ROUND_FINISHED);
                break;
        }
        CastNextSpellIfAnyAndReady();
    }

    void DoAction(const int32 action)
    {
        switch (action)
        {
            case ACTION_SIMON_ROUND_FINISHED:
                listening = false;
                AddSpellToCast(SPELL_VISUAL_START_AI_LEVEL, CAST_NULL);
                GiveRewardForLevel(gameLevel);
                _events.CancelEventsByGCD(0);
                if (gameLevel == 10)
                    ResetNode();
                else
                    _events.ScheduleEvent(EVENT_SIMON_SETUP_PRE_GAME, 1000);
                break;
            case ACTION_SIMON_CORRECT_FULL_SEQUENCE:
                gameLevel++;
                DoAction(ACTION_SIMON_ROUND_FINISHED);
                break;
            case ACTION_SIMON_WRONG_SEQUENCE:
                GivePunishment();
                DoAction(ACTION_SIMON_ROUND_FINISHED);
                break;
        }
    }

    // Called by color clusters script (go_simon_cluster) and used for knowing the button pressed by player
    void SetData(uint32 type, uint32 /*data*/)
    {
        if (!listening)
            return;

        uint8 pressedColor;

        if (type == clusterIds[SIMON_RED])
            pressedColor = SIMON_RED;
        else if (type == clusterIds[SIMON_BLUE])
            pressedColor = SIMON_BLUE;
        else if (type == clusterIds[SIMON_GREEN])
            pressedColor = SIMON_GREEN;
        else if (type == clusterIds[SIMON_YELLOW])
            pressedColor = SIMON_YELLOW;

        PlayColor(pressedColor);
        playerSequence.push_back(pressedColor);
        _events.ScheduleEvent(EVENT_SIMON_RESET_CLUSTERS, 500);
        CheckPlayerSequence();
    }

    // Used for getting involved player guid. Parameter id is used for defining if is a large(Monument) or small(Relic) node
    void SetGUID(uint64 guid, int32 id)
    {
        ClearCastQueue();

        me->SetLevitate(true);

        large = (bool)id;
        playerGUID = guid;
        StartGame();
    }

    /*
    Resets all variables and also find the ids of the four closests color clusters, since every simon
    node have diferent ids for clusters this is absolutely NECESSARY.
    */
    void StartGame()
    {
        listening = false;
        gameLevel = 0;
        fails = 0;
        gameTicks = 0;
        zCoordCorrection = large ? 8.0f : 2.75f;
        searchDistance = large ? 13.0f : 5.0f;
        colorSequence.clear();
        playableSequence.clear();
        playerSequence.clear();
        me->SetFloatValue(OBJECT_FIELD_SCALE_X, large ? 2 : 1);

        std::list<GameObject*> ClusterList;
        Looking4group::AllGameObjectsInRange objects(me, searchDistance);
        Looking4group::ObjectListSearcher<GameObject, Looking4group::AllGameObjectsInRange> searcher(ClusterList, objects);
        Cell::VisitGridObjects(me, searcher, searchDistance);

        for (std::list<GameObject*>::const_iterator i = ClusterList.begin(); i != ClusterList.end(); ++i)
        {
            if (GameObject* go = (*i)->ToGameObject())
            {
                // We are checking for displayid because all simon nodes have 4 clusters with different entries
                if (large)
                {
                    switch (go->GetGOInfo()->displayId)
                    {
                        case GO_BLUE_CLUSTER_DISPLAY_LARGE: clusterIds[SIMON_BLUE] = go->GetEntry(); break;
                        case GO_RED_CLUSTER_DISPLAY_LARGE: clusterIds[SIMON_RED] = go->GetEntry(); break;
                        case GO_GREEN_CLUSTER_DISPLAY_LARGE: clusterIds[SIMON_GREEN] = go->GetEntry(); break;
                        case GO_YELLOW_CLUSTER_DISPLAY_LARGE: clusterIds[SIMON_YELLOW] = go->GetEntry(); break;
                    }
                }
                else
                {
                    switch (go->GetGOInfo()->displayId)
                    {
                        case GO_BLUE_CLUSTER_DISPLAY: clusterIds[SIMON_BLUE] = go->GetEntry(); break;
                        case GO_RED_CLUSTER_DISPLAY: clusterIds[SIMON_RED] = go->GetEntry(); break;
                        case GO_GREEN_CLUSTER_DISPLAY: clusterIds[SIMON_GREEN] = go->GetEntry(); break;
                        case GO_YELLOW_CLUSTER_DISPLAY: clusterIds[SIMON_YELLOW] = go->GetEntry(); break;
                    }
                }
            }
        }

        _events.Reset();
        _events.ScheduleEvent(EVENT_SIMON_ROUND_FINISHED, 1000);
        _events.ScheduleEvent(EVENT_SIMON_PERIODIC_PLAYER_CHECK, 2000);

        if (GameObject* relic = GetClosestGameObjectWithEntry(me, large ? GO_APEXIS_MONUMENT : GO_APEXIS_RELIC, searchDistance))
            relic->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOTSELECTABLE);
    }

    // Called when despawning the bunny. Sets all the node GOs to their default states.
    void ResetNode()
    {
        DoPlaySoundToSet(me, SOUND_DISABLE_NODE);

        for (uint32 clusterId = SIMON_BLUE; clusterId < SIMON_MAX_COLORS; clusterId++)
            if (GameObject* cluster = GetClosestGameObjectWithEntry(me, clusterIds[clusterId], searchDistance))
                cluster->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOTSELECTABLE);

        for (uint32 auraId = GO_AURA_BLUE; auraId <= GO_AURA_YELLOW; auraId++)
            if (GameObject* auraGo = GetClosestGameObjectWithEntry(me, auraId, searchDistance))
                auraGo->RemoveFromWorld();

        if (GameObject* relic = GetClosestGameObjectWithEntry(me, large ? GO_APEXIS_MONUMENT : GO_APEXIS_RELIC, searchDistance))
            relic->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOTSELECTABLE);

        me->ForcedDespawn(1000);
    }

    /*
    Called on every button click of player. Adds the clicked color to the player created sequence and
    checks if it corresponds to the AI created sequence. If so, incremente gameLevel and start a new
    round, if not, give punishment and restart current level.
    */
    void CheckPlayerSequence()
    {
        bool correct = true;
        if (playerSequence.size() <= colorSequence.size())
            for (std::list<uint8>::const_iterator i = playerSequence.begin(), j = colorSequence.begin(); i != playerSequence.end(); ++i, ++j)
                if ((*i) != (*j))
                    correct = false;

        if (correct && (playerSequence.size() == colorSequence.size()))
            DoAction(ACTION_SIMON_CORRECT_FULL_SEQUENCE);
        else if (!correct)
            DoAction(ACTION_SIMON_WRONG_SEQUENCE);
    }

    /*
    Generates a random sequence of colors depending on the gameLevel. We also copy this sequence to
    the playableSequence wich will be used when playing the sequence to the player.
    */
    void GenerateColorSequence()
    {
        colorSequence.clear();
        for (uint8 i = 0; i <= gameLevel; i++)
            colorSequence.push_back(RAND(SIMON_BLUE, SIMON_RED, SIMON_GREEN, SIMON_YELLOW));

        for (std::list<uint8>::const_iterator i = colorSequence.begin(); i != colorSequence.end(); ++i)
            playableSequence.push_back(*i);
    }


    // Remove any existant glowing auras over clusters and set clusters ready for interating with them.
    void PrepareClusters(bool clustersOnly = false)
    {
        for (uint32 clusterId = SIMON_BLUE; clusterId < SIMON_MAX_COLORS; clusterId++)
            if (GameObject* cluster = GetClosestGameObjectWithEntry(me, clusterIds[clusterId], searchDistance))
                cluster->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOTSELECTABLE);

        if (clustersOnly)
            return;

        for (uint32 auraId = GO_AURA_BLUE; auraId <= GO_AURA_YELLOW; auraId++)
            if (GameObject* auraGo = GetClosestGameObjectWithEntry(me, auraId, searchDistance))
                auraGo->RemoveFromWorld();
    }

    /*
    Called when AI is playing the sequence for player. We cast the visual spell and then remove the
    casted color from the casting sequence.
    */
    void PlayNextColor()
    {
        PlayColor(*playableSequence.begin());
        playableSequence.erase(playableSequence.begin());
    }

    // Casts a spell and plays a sound depending on parameter color.
    void PlayColor(uint8 color)
    {
        switch (color)
        {
            case SIMON_BLUE:
                AddSpellToCast(SPELL_VISUAL_BLUE, CAST_NULL);
                DoPlaySoundToSet(me, SOUND_BLUE);
                break;
            case SIMON_GREEN:
                AddSpellToCast(SPELL_VISUAL_GREEN, CAST_NULL);
                DoPlaySoundToSet(me, SOUND_GREEN);
                break;
            case SIMON_RED:
                AddSpellToCast(SPELL_VISUAL_RED, CAST_NULL);
                DoPlaySoundToSet(me, SOUND_RED);
                break;
            case SIMON_YELLOW:
                AddSpellToCast(SPELL_VISUAL_YELLOW, CAST_NULL);
                DoPlaySoundToSet(me, SOUND_YELLOW);
                break;
        }
    }

    /*
    Creates the transparent glowing auras on every cluster of this node.
    After calling this function bunny is teleported to the center of the node.
    */
    void SetUpPreGame()
    {
        for (uint32 clusterId = SIMON_BLUE; clusterId < SIMON_MAX_COLORS; clusterId++)
        {
            if (GameObject* cluster = GetClosestGameObjectWithEntry(me,clusterIds[clusterId], 2.0f*searchDistance))
            {
                cluster->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOTSELECTABLE);

                // break since we don't need glowing auras for large clusters
                if (large)
                    break;

                float x, y, z, o = 0.0f;
                cluster->GetPosition(x, y, z);
                me->NearTeleportTo(x, y, z, o);

                uint32 preGameSpellId;
                if (cluster->GetEntry() == clusterIds[SIMON_RED])
                    preGameSpellId = SPELL_PRE_GAME_RED;
                else if (cluster->GetEntry() == clusterIds[SIMON_BLUE])
                    preGameSpellId = SPELL_PRE_GAME_BLUE;
                else if (cluster->GetEntry() == clusterIds[SIMON_GREEN])
                    preGameSpellId = SPELL_PRE_GAME_GREEN;
                else if (cluster->GetEntry() == clusterIds[SIMON_YELLOW])
                    preGameSpellId = SPELL_PRE_GAME_YELLOW;
                else
                    break;

                me->CastSpell(cluster, preGameSpellId, true);
            }
        }

        if (GameObject* relic = GetClosestGameObjectWithEntry(me, large ? GO_APEXIS_MONUMENT : GO_APEXIS_RELIC, searchDistance))
        {
            float x, y, z, o = 0.0f;
            relic->GetPosition(x, y, z);
            me->NearTeleportTo(x, y, z + zCoordCorrection, o);
        }

        GenerateColorSequence();
    }

    // Handles the spell rewards. The spells also have the QuestCompleteEffect, so quests credits are working.
    void GiveRewardForLevel(uint8 level)
    {
        uint32 rewSpell;
        switch (level)
        {
            case 6:
                if (large)
                    GivePunishment();
                else
                    rewSpell = SPELL_REWARD_BUFF_1;
                break;
            case 8:
                rewSpell = SPELL_REWARD_BUFF_2;
                break;
            case 10:
                rewSpell = SPELL_REWARD_BUFF_3;
                break;
            default:
                rewSpell = 0;
        }

        if (rewSpell)
            if (Player* player = me->GetPlayer(playerGUID))
                player->CastSpell(player, rewSpell, true);
    }

    /*
    Depending on the number of failed pushes for player the damage of the spell scales, so we first
    cast the spell on the target that hits for 50 and shows the visual and then forces the player
    to cast the damaging spell on it self with the modified basepoints.
    4 fails = death.
    On large nodes punishment and reward are the same, summoning the Apexis Guardian.
    */
    void GivePunishment()
    {
        if (large)
        {
            if (Player* player = me->GetPlayer(playerGUID))
                if (Creature* guardian = me->SummonCreature(NPC_APEXIS_GUARDIAN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() - zCoordCorrection, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 20000))
                    guardian->AI()->AttackStart(player);

            ResetNode();
        }
        else
        {
            fails++;

            if (Player* player = me->GetPlayer(playerGUID))
                DoCast(player, SPELL_BAD_PRESS_TRIGGER, true);

            if (fails >= 4)
                ResetNode();
        }
    }

    void SpellHitTarget(Unit* target, const SpellEntry* spell)
    {
        // Cast SPELL_BAD_PRESS_DAMAGE with scaled basepoints when the visual hits the target.
        // Need Fix: When SPELL_BAD_PRESS_TRIGGER hits target it triggers spell SPELL_BAD_PRESS_DAMAGE by itself
        // so player gets damage equal to calculated damage  dbc basepoints for SPELL_BAD_PRESS_DAMAGE (~50)
        if (spell->Id == SPELL_BAD_PRESS_TRIGGER)
        {
            int32 bp = (int32)((float)(fails)*0.33f*target->GetMaxHealth());
            target->CastCustomSpell(target, SPELL_BAD_PRESS_DAMAGE, &bp, NULL, NULL, true);
        }
    }

    // Checks if player has already die or has get too far from the current node
    bool CheckPlayer()
    {
        if (Player* player = me->GetPlayer(playerGUID))
        {
            if (player->isDead())
                return false;

            if (player->GetDistance2d(me) >= 2.0f*searchDistance)
            {
                GivePunishment();
                return false;
            }
        }
        else
            return false;

        return true;
    }
};

CreatureAI* Get_npc_simon_bunnyAI(Creature* creature)
{
    return new npc_simon_bunnyAI(creature);
}

bool OnGossipHello_go_simon_cluster(Player* player, GameObject* go)
{
    if (Creature* bunny = GetClosestCreatureWithEntry(go, NPC_SIMON_BUNNY, 13.0f, true))
        CAST_AI(npc_simon_bunnyAI, bunny->AI())->SetData(go->GetEntry(), 0);

    player->CastSpell(player, go->GetGOInfo()->goober.spellId, true);
    go->AddUse();
    return true;
}

enum ApexisRelic
{
    QUEST_APEXIS                 = 11058,
    QUEST_EMANATION              = 11080,
    QUEST_GUARDIAN               = 11059,
    GOSSIP_TEXT_ID               = 10948,

    ITEM_APEXIS_SHARD            = 32569,
    SPELL_TAKE_REAGENTS_SOLO     = 41145,
    SPELL_TAKE_REAGENTS_GROUP    = 41146,
};

#define GOSSIP_ITEM_1 "Insert an Apexis Shard, and begin!"
#define GOSSIP_ITEM_2 "Insert Apexis Shards, and begin!"

bool OnGossipHello_go_apexis_relic(Player* player, GameObject* go)
{
    bool large = (go->GetEntry() == GO_APEXIS_MONUMENT);

    if (player->HasItemCount(ITEM_APEXIS_SHARD, large ? 35 : 1) && large ? player->GetQuestStatus(QUEST_GUARDIAN) == QUEST_STATUS_INCOMPLETE : (player->GetQuestStatus(QUEST_APEXIS) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(QUEST_EMANATION) == QUEST_STATUS_INCOMPLETE))
        player->ADD_GOSSIP_ITEM(0, large ? GOSSIP_ITEM_2 : GOSSIP_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
    player->SEND_GOSSIP_MENU(GOSSIP_TEXT_ID, go->GetGUID());

    return true;
}

bool OnGossipSelect_go_apexis_relic(Player* player, GameObject* go, uint32 sender, uint32 action)
{
    bool large = (go->GetEntry() == GO_APEXIS_MONUMENT);

    if (player->HasItemCount(ITEM_APEXIS_SHARD, large ? 35 : 1))
    {
        player->CastSpell(player, large ? SPELL_TAKE_REAGENTS_GROUP : SPELL_TAKE_REAGENTS_SOLO, false);

        if (Creature* bunny = player->SummonCreature(NPC_SIMON_BUNNY, go->GetPositionX(), go->GetPositionY(), go->GetPositionZ(), 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
            CAST_AI(npc_simon_bunnyAI, bunny->AI())->SetGUID(player->GetGUID(), large);

        player->CLOSE_GOSSIP_MENU();
    } 
    return false;
}

/*#########
# Q 10674 && 10859
#########*/

enum Entries
{
    NPC_LIGHT_ORB         = 20635,
    NPC_QUEST_CREDIT2     = 21929,
};

struct AttractOrbs
{
    AttractOrbs(Creature* t) : totem(t) {}
    Creature* totem;

    void operator()(Creature* orb)
    {
        if (orb->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
            orb->GetMotionMaster()->MovePoint(0, totem->GetPositionX(), totem->GetPositionY(), totem->GetPositionZ(), true);

        if (orb->IsWithinDistInMap(totem, 2.0f))
        {
            orb->ForcedDespawn();
            KillCredit();
        }
    }

    void KillCredit()
    { 
        Map* map = totem->GetMap();
        Map::PlayerList const &PlayerList = map->GetPlayers();

        for(Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
        {
            if (Player* player = itr->getSource())
            {
                if (totem->IsWithinDistInMap(player, 15.0f) && (player->GetQuestStatus(10674) || player->GetQuestStatus(10859) == QUEST_STATUS_INCOMPLETE))
                    player->KilledMonster(NPC_QUEST_CREDIT2, totem->GetGUID());
            }
        }
    }
};

struct npc_orb_attracterAI : public Scripted_NoMovementAI
{
    npc_orb_attracterAI(Creature* creature) : Scripted_NoMovementAI(creature) {}

    TimeTrackerSmall attractTimer;

    void Reset()
    {
        me->SetReactState(REACT_PASSIVE);
        attractTimer.Reset(1500);
        me->ForcedDespawn(10000);
    }

    void UpdateAI(const uint32 diff)
    {
        attractTimer.Update(diff);

        if (attractTimer.Passed())
        {
            std::list<Creature*> orbs = FindAllCreaturesWithEntry(NPC_LIGHT_ORB, 35.0f);
            std::for_each(orbs.begin(), orbs.end(), AttractOrbs(me));

            attractTimer.Reset(1000);
        }
    }
};

CreatureAI* Get_npc_orb_attracterAI(Creature* creature)
{
    return new npc_orb_attracterAI(creature);
}

/*######
## npc_razaan_event
######*/

enum
{
    QUEST_MERCY        = 10675,
    QUEST_RESPONSE     = 10867,

    GO_SOULS           = 185033,

    YELL_RAZAAN        = -1900225,

    NPC_RAZAAN         = 21057
};

struct npc_razaan_eventAI : public ScriptedAI
{
    npc_razaan_eventAI(Creature* creature) : ScriptedAI(creature) {}

    bool Check;

    uint32 CheckTimer;
    uint32 Count;

    void Reset()
    {
        Check = false;
        CheckTimer = 0;
        Count = 0;
    }

    void HeyYa()
    {
        ++Count;

        if (Count == 6)
        {
            me->SummonCreature(NPC_RAZAAN, me->GetPositionX()+2.9f, me->GetPositionY()-5.8f, me->GetPositionZ()-8.9f, me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
            Check = true;
            CheckTimer = 5000;
            Count = 0;
        }
    }

    void JustSummoned(Creature* summoned)
    {
        DoScriptText(YELL_RAZAAN, summoned);
    }

    void UpdateAI(const uint32 diff)
    {
        if (Check)
        {
            if (CheckTimer <= diff)
            {
                if (Creature* razaan = GetClosestCreatureWithEntry(me, NPC_RAZAAN, 75.0f, true))
                {
                    CheckTimer = 5000;
                    return;
                }
                else
                {
                    if (Creature* razaan = GetClosestCreatureWithEntry(me, NPC_RAZAAN, 75.0f, false))
                        me->SummonGameObject(GO_SOULS, razaan->GetPositionX(), razaan->GetPositionY(), razaan->GetPositionZ()+3.0f, razaan->GetOrientation(), 0, 0, 0, 0, 50);

                    Reset();
                }
            }
            else CheckTimer -= diff;
        }
    }
};

CreatureAI* GetAI_npc_razaan_event(Creature* creature)
{
    return new npc_razaan_eventAI (creature);
}

/*######
## npc_razaani_raider
######*/

enum
{
    SPELL_FLARE        = 35922,
    SPELL_WARP         = 32920,

    NPC_EORB           = 21025,
    NPC_DEADSOUL       = 20845
};

struct npc_razaani_raiderAI : public ScriptedAI
{
    npc_razaani_raiderAI(Creature* creature) : ScriptedAI(creature) {}

    uint64 PlayerGUID;
    uint32 FlareTimer;
    uint32 WarpTimer;

    void Reset()
    {
        PlayerGUID = 0;
        FlareTimer = urand(4000, 8000);
        WarpTimer = urand(8000, 13000);
    }

    void AttackStart(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
        {
            if (((Player*)who)->GetQuestStatus(QUEST_MERCY)== QUEST_STATUS_INCOMPLETE || ((Player*)who)->GetQuestStatus(QUEST_RESPONSE) == QUEST_STATUS_INCOMPLETE)
                PlayerGUID = who->GetGUID();
        }

        ScriptedAI::AttackStart(who);
    }

    void JustSummoned(Creature* summoned)
    {
        Map* tmpMap = me->GetMap();

        if (!tmpMap)
            return;

        if (Creature*  eorb = tmpMap->GetCreature(tmpMap->GetCreatureGUID(NPC_EORB)))
        {
            summoned->SetLevitate(true);
            summoned->GetMotionMaster()->MovePoint(0, eorb->GetPositionX(), eorb->GetPositionY(), eorb->GetPositionZ());
        }
    }

    void JustDied(Unit* who)
    {
        if (PlayerGUID != 0)
        {
            me->SummonCreature(NPC_DEADSOUL, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+3, me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 20000);

            Map* tmpMap = me->GetMap();

            if (!tmpMap)
                return;

            if (Creature*  eorb = tmpMap->GetCreature(tmpMap->GetCreatureGUID(NPC_EORB)))
                CAST_AI(npc_razaan_eventAI, eorb->AI())->HeyYa();
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (FlareTimer <= diff)
        {
            DoCast (me->getVictim(), SPELL_FLARE);
            FlareTimer = urand(9000, 14000);
        }
        else FlareTimer -= diff;

        if (WarpTimer <= diff)
        {
            DoCast (me->getVictim(), SPELL_WARP);
            WarpTimer = urand(14000, 18000);
        }
        else WarpTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_razaani_raider(Creature* creature)
{
    return new npc_razaani_raiderAI (creature);
}

/*######
## npc_rally_zapnabber
######*/

enum
{
    SPELL_10557              = 37910,
    SPELL_10710              = 37962,
    SPELL_10711              = 36812,
    SPELL_10712              = 37968,
    //SPELL_10716            = 37940,
    SPELL_CANNON_CHANNEL     = 36795,
    SPELL_PORT               = 38213,
    SPELL_CHARGED            = 37108,
    SPELL_STATE1             = 36790,
    SPELL_STATE2             = 36792,
    SPELL_STATE3             = 36800,

    QUEST_JAGGED             = 10557,
    QUEST_SINGING            = 10710,
    QUEST_RAZAAN             = 10711,
    QUEST_RUUAN              = 10712,

    ITEM_WAIVER_SIGNED       = 30539,

    NPC_CHANNELER            = 21393,
    NPC_CH_TARGET            = 21394
};

float Port[3] =
{
    1920.163,
    5581.826,
    269.222
};

struct npc_rally_zapnabberAI : public ScriptedAI
{
    npc_rally_zapnabberAI(Creature* creature) : ScriptedAI(creature) {}

    bool Flight;

    uint64 playerGUID;
    uint32 FlightTimer;
    uint32 EffectTimer;
    uint8 flights;
    uint8 Count;

    void Reset() 
    {
        Flight = false;
        playerGUID = 0;
        FlightTimer = 0;
        EffectTimer = 0;
        flights = 0;
        Count = 0;
        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
    }

    void TestFlight(uint64 guid, uint8 flight)
    {
        playerGUID = guid;
        flights = flight;

        if (Player* player = me->GetPlayer(playerGUID))
        {
            if (player->IsMounted())
            {
                player->Unmount();
                player->RemoveSpellsCausingAura(SPELL_AURA_MOUNTED);
            }

            player->GetUnitStateMgr().PushAction(UNIT_ACTION_STUN);

            switch  (flights)
            {
                 case 1:
                     DoTeleportPlayer(player, Port[0], Port[1], Port[2], 5.1f);
                     break;
                 case 2:
                     DoTeleportPlayer(player, Port[0], Port[1], Port[2], 1.1f);
                     break;
                 case 3:
                     DoTeleportPlayer(player, Port[0], Port[1], Port[2], 2.7f);
                     break;
                 case 4:
                     DoTeleportPlayer(player, Port[0], Port[1], Port[2], 3.0f);
                     break;
            }

            player->CastSpell(player, SPELL_PORT, true);

            Map* tmpMap = me->GetMap();

            if (!tmpMap)
                return;
 
            if (Creature*  channeler = tmpMap->GetCreature(tmpMap->GetCreatureGUID(NPC_CHANNELER)))
                channeler->CastSpell(channeler, SPELL_CANNON_CHANNEL, true);

            Flight = true;
            EffectTimer = 3000;
            FlightTimer = 10000;
        }
    }

    void Flights()
    {
        if (Player* player = me->GetPlayer(playerGUID))
        {
            switch  (flights)
            {
                case 1:
                    player->GetUnitStateMgr().DropAction(UNIT_ACTION_STUN);
                    player->CastSpell(player, SPELL_10557, true);
                    player->CastSpell(player, SPELL_CHARGED, true);
                    Reset();
                    break;
                case 2:
                    player->GetUnitStateMgr().DropAction(UNIT_ACTION_STUN);
                    player->CastSpell(player, SPELL_10710, true);
                    player->CastSpell(player, SPELL_CHARGED, true);
                    Reset();
                    break;
                case 3:
                    player->GetUnitStateMgr().DropAction(UNIT_ACTION_STUN);
                    player->CastSpell(player, SPELL_10711, true);
                    player->CastSpell(player, SPELL_CHARGED, true);
                    Reset();
                    break;
                case 4:
                    player->GetUnitStateMgr().DropAction(UNIT_ACTION_STUN);
                    player->CastSpell(player, SPELL_10712, true);
                    player->CastSpell(player, SPELL_CHARGED, true);
                    Reset();
                    break;
            }
        }
    }


    void UpdateAI(const uint32 diff)
    {
        if (Flight)
        {
            if (EffectTimer <= diff)
            {
                Map* tmpMap = me->GetMap();

                if (!tmpMap)
                    return;

                if (Creature*  target = tmpMap->GetCreature(tmpMap->GetCreatureGUID(NPC_CH_TARGET)))
                {
                    ++Count;

                    switch  (Count)
                    {
                        case 1:
                            target->CastSpell(target, SPELL_STATE1, true);
                            break;
                        case 2:
                            target->CastSpell(target, SPELL_STATE2, true);
                            break;
                        case 3:
                            target->CastSpell(target, SPELL_STATE3, true);
                            break;
                    }
                }

                EffectTimer = 3000;
 
            }
            else EffectTimer -= diff;

            if (FlightTimer <= diff)
            {
                Flights();
            }
            else FlightTimer -= diff;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_rally_zapnabber(Creature* creature)
{
    return new npc_rally_zapnabberAI (creature);
}

#define GOSSIP_ITEM_FLIGHT1 "I'm ready for my test flight!"
#define GOSSIP_ITEM_FLIGHT2 "Take me to Singing Ridge."
#define GOSSIP_ITEM_FLIGHT3 "Take me to Razaan's Landing."
#define GOSSIP_ITEM_FLIGHT4 "Take me to Ruuan Weald."
#define GOSSIP_ITEM_FLIGHT5 "I have the signed waiver! Fire me into the Singing Ridge!"
#define GOSSIP_ITEM_FLIGHT6 "I want to fly to an old location!"
#define GOSSIP_ITEM_FLIGHT7 "Take me to Jagged Ridge!"
#define GOSSIP_ITEM_FLIGHT8 "Take me to The Singing Ridge!"
#define GOSSIP_ITEM_FLIGHT9 "Take me to Razaan's Landing!"
#define GOSSIP_ITEM_FLIGHT10 "Take me to Ruuan Weald!"

bool GossipHello_npc_rally_zapnabber(Player* player, Creature* creature)
{
    if (player->GetQuestStatus(QUEST_JAGGED) == QUEST_STATUS_INCOMPLETE && !player->HasAura(SPELL_CHARGED))
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

    if (player->GetQuestStatus(QUEST_SINGING) == QUEST_STATUS_INCOMPLETE && !player->HasAura(SPELL_CHARGED))
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);

    if (player->GetQuestStatus(QUEST_RAZAAN) == QUEST_STATUS_INCOMPLETE && !player->HasAura(SPELL_CHARGED))
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

    if (player->GetQuestStatus(QUEST_RUUAN) == QUEST_STATUS_INCOMPLETE && !player->HasAura(SPELL_CHARGED))
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

    if ((player->GetQuestRewardStatus(QUEST_JAGGED) || player->GetQuestRewardStatus(QUEST_SINGING) || player->GetQuestRewardStatus(QUEST_RAZAAN) || player->GetQuestRewardStatus(QUEST_RUUAN)) && !player->HasAura(SPELL_CHARGED))
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);

    player->SEND_GOSSIP_MENU(creature->GetNpcTextId(), creature->GetGUID());

    return true;
}

bool GossipSelect_npc_rally_zapnabber(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    uint8 flight;
    flight = 0;

    switch  (action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            flight = 1;
            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            CAST_AI(npc_rally_zapnabberAI, creature->AI())->TestFlight(player->GetGUID(), flight);
            player->CLOSE_GOSSIP_MENU();
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            if (player->HasItemCount(ITEM_WAIVER_SIGNED, 1))
            {
                flight = 2;
                creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                CAST_AI(npc_rally_zapnabberAI, creature->AI())->TestFlight(player->GetGUID(), flight);
                player->CLOSE_GOSSIP_MENU();
            }
            else player->CLOSE_GOSSIP_MENU();
            break;
        case GOSSIP_ACTION_INFO_DEF + 3:
            flight = 3;
            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            CAST_AI(npc_rally_zapnabberAI, creature->AI())->TestFlight(player->GetGUID(), flight);
            player->CLOSE_GOSSIP_MENU();
            break;
        case GOSSIP_ACTION_INFO_DEF + 4:
            flight = 4;
            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            CAST_AI(npc_rally_zapnabberAI, creature->AI())->TestFlight(player->GetGUID(), flight);
            player->CLOSE_GOSSIP_MENU();
            break;
        case GOSSIP_ACTION_INFO_DEF + 5:
            flight = 2;
            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            CAST_AI(npc_rally_zapnabberAI, creature->AI())->TestFlight(player->GetGUID(), flight);
            player->CLOSE_GOSSIP_MENU();
            break;
        case GOSSIP_ACTION_INFO_DEF + 6:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(10561, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 7:
            if (player->GetQuestRewardStatus(QUEST_JAGGED) && !player->HasAura(SPELL_CHARGED))
                player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            if (player->GetQuestRewardStatus(QUEST_SINGING) && !player->HasAura(SPELL_CHARGED))
                player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT8, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);

            if (player->GetQuestRewardStatus(QUEST_RAZAAN) && !player->HasAura(SPELL_CHARGED))
                player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT9, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

            if (player->GetQuestRewardStatus(QUEST_RUUAN) && !player->HasAura(SPELL_CHARGED))
                player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_FLIGHT10, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            player->SEND_GOSSIP_MENU(10562, creature->GetGUID());
            break;
    }

    return true;
}

/*######
## Q 10821
######*/

enum
{
    SPELL_BEAM        = 35846,

    QUEST_FIRED       = 10821,

    NPC_ANGER         = 22422,
    NPC_INVISB        = 20736,
    NPC_DOOMCRYER     = 19963
};

struct npc_anger_campAI : public ScriptedAI
{
    npc_anger_campAI(Creature* creature) : ScriptedAI(creature) {}

    uint8 Count;

    void Reset() 
    {
        Count = 0;
    }

    void Activate()
    {
        ++Count;

        if (Count == 5)
        {
            me->SummonCreature(NPC_DOOMCRYER, me->GetPositionX()+26.8f, me->GetPositionY()+9.1f, me->GetPositionZ()-9.6f, me->GetOrientation()/2.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
            Reset();
        }
    }
};

CreatureAI* GetAI_npc_anger_camp(Creature* creature)
{
    return new npc_anger_campAI (creature);
}

bool GOUse_go_obeliks(Player* player, GameObject* go)
{
    if (player->GetQuestStatus(QUEST_FIRED) == QUEST_STATUS_INCOMPLETE)
    {
        Map* tmpMap = go->GetMap();

        if (!tmpMap)
            return true;

        if (Creature* anger = tmpMap->GetCreature(tmpMap->GetCreatureGUID(NPC_ANGER)))
        {
            if (Creature* bunny = go->SummonCreature(NPC_INVISB, go->GetPositionX()-2.0f, go->GetPositionY(), go->GetPositionZ(), go->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 181000))
            {
                bunny->CastSpell(anger, SPELL_BEAM, true);
                CAST_AI(npc_anger_campAI, anger->AI())->Activate();
            }
        }
    }
    return false;
}

/*######
## npc_cannon_target
######*/

enum
{
    SPELL_ARTILLERY      = 39221,
    SPELL_IMP_AURA       = 39227,
    SPELL_HOUND_AURA     = 39275,

    NPC_IMP              = 22474,
    NPC_HOUND            = 22500,
    NPC_SOUTH_GATE       = 22472,
    NPC_NORTH_GATE       = 22471,
    CREDIT_SOUTH         = 22504,
    CREDIT_NORTH         = 22503,

    GO_FIRE              = 185317,
    GO_BIG_FIRE          = 185319
};

struct npc_cannon_targetAI : public ScriptedAI
{
    npc_cannon_targetAI(Creature* creature) : ScriptedAI(creature) {}

    bool PartyTime;

    uint64 PlayerGUID;
    uint64 CannonGUID;
    uint32 PartyTimer;
    uint8 Count;

    void Reset() 
    {
        PartyTime= false;
        PlayerGUID = 0;
        CannonGUID = 0;
        PartyTimer = 0;
        Count = 0;
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if (spell->Id ==  SPELL_ARTILLERY)
        {
            ++Count;

            if (Count == 1)
            {
                if (Player* player = caster->GetCharmerOrOwnerPlayerOrPlayerItself())
                    PlayerGUID = player->GetGUID();

                CannonGUID = caster->GetGUID();
                PartyTime = true;
                PartyTimer = 3000;
            }

            if (Count == 3)
                me->SummonGameObject(GO_FIRE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 130);

            if (Count == 7)
            {
                if (Player* player = me->GetPlayer(PlayerGUID))
                {
                    if (Creature* bunny = GetClosestCreatureWithEntry(me, NPC_SOUTH_GATE, 200.0f))
                        player->KilledMonster(CREDIT_SOUTH, me->GetGUID());
                    else
                    {   
                        if (Creature* bunny = GetClosestCreatureWithEntry(me, NPC_NORTH_GATE, 200.0f))
                            player->KilledMonster(CREDIT_NORTH, me->GetGUID());
                    }
                }

                me->SummonGameObject(GO_BIG_FIRE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 60);
                Reset();
            }
        }

        return;
    }

    void JustSummoned(Creature* summoned)
    {
        if (summoned->GetEntry() == NPC_IMP)
            summoned->CastSpell(summoned, SPELL_IMP_AURA, true);
        else
        {
            if (summoned->GetEntry() == NPC_HOUND)
                summoned->CastSpell(summoned, SPELL_HOUND_AURA, true);
        }

        if (Creature* cannon = me->GetCreature(CannonGUID))
            summoned->AI()->AttackStart(cannon); 
    }

    void UpdateAI(const uint32 diff)
    {
        if (PartyTime)
        {
            if (PartyTimer <= diff)
            {
                if (Creature* cannon = me->GetCreature(CannonGUID))
                {
                    if (cannon->isDead())
                        Reset();
                }

                if (roll_chance_i(20))
                    me->SummonCreature(NPC_HOUND, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                else
                    me->SummonCreature(NPC_IMP, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);

                PartyTimer = 3000;
            }
            else PartyTimer -= diff;
        }
    }
};

CreatureAI* GetAI_npc_cannon_target(Creature* creature)
{
    return new npc_cannon_targetAI (creature);
}

/*######
## npc_gargrom
######*/

#define GO_TEMP    185232

struct Pos
{
    float x, y, z;
};

static Pos sum[]=
{
    {3610.64f, 7180.36f, 139.98f},
    {3611.35f, 7179.39f, 140.10f}
};

struct npc_gargromAI : public ScriptedAI
{
    npc_gargromAI(Creature* creature) : ScriptedAI(creature) {}

    void Reset() 
    {
        me->SetWalk(true);
        me->GetMotionMaster()->MovePoint(0, sum[0].x, sum[0].y, sum[0].z);
    }

    void MovementInform(uint32 type, uint32 id)
    {
        if (type == POINT_MOTION_TYPE)
        {
            me->setDeathState(JUST_DIED);
            me->SummonGameObject(GO_TEMP, sum[1].x, sum[1].y, sum[1].z, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 25);
            me->SummonGameObject(GO_TEMP, sum[1].x-(rand()%4), sum[1].y-(rand()%4), sum[1].z, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 25);
        }
    }
};

CreatureAI* GetAI_npc_gargrom(Creature* creature)
{
    return new npc_gargromAI (creature);
}

/*######
## npc_soulgrinder
######*/

enum
{
    SPELL_VRITUAL            = 39918,
    SPELL_GTRANSFORM         = 39916,
    SPELL_RBEAM              = 39920,
    SPELL_SHADOWFORMONE      = 39943,
    SPELL_SHADOWFORMTWO      = 39944,
    SPELL_SHADOWFORMTHREE    = 39946,
    SPELL_SHADOWFORMFOUR     = 39947,

    NPC_SOULGRINGER          = 23019,
    NPC_SSPIRIT              = 22912,
    NPC_BRITUAL              = 23037,
    NPC_SCULLOC              = 22910,

    QUEST_SOULGRINGER        = 11000
};

struct Ev
{
    float x, y, z, o;
};

static Ev ent[]=
{
    {3493.81f, 5530.01f, 19.57f, 0.80f},
    {3466.89f, 5566.49f, 20.24f, 0.30f},
    {3486.58f, 5551.74f, 7.51f, 0.65f},
    {3515.08f, 5527.14f, 20.17f, 1.20f},
    {3470.48f, 5583.96f, 20.68f, 6.20f}
};

struct npc_soulgrinderAI : public ScriptedAI
{
    npc_soulgrinderAI(Creature* creature) : ScriptedAI(creature), summons(me) {}

    bool DoSpawns;

    SummonList summons;
    uint32 SpawnTimer;
    uint32 BeamTimer;
    uint8 Count;
    uint64 PlayerGUID;
    uint64 SkullocGUID;

    void Reset() 
    {
        if (Creature* bm = GetClosestCreatureWithEntry(me, NPC_SOULGRINGER, 10.0f))
        {
            if (me->GetGUID() != bm->GetGUID())
                me->ForcedDespawn();
        }

        DoSpawns = true;
        SpawnTimer = 5000;
        BeamTimer = 35000;
        Count = 0;
        PlayerGUID = 0;
        SkullocGUID = 0;
        DoCast(me, SPELL_VRITUAL, true);
        INeedTarget();
    }

    void INeedTarget()
    { 
        Map* map = me->GetMap();
        Map::PlayerList const &PlayerList = map->GetPlayers();

        for(Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
        {
            if (Player* player = itr->getSource())
            {
                if (me->IsWithinDistInMap(player, 10.0f) && player->GetQuestStatus(QUEST_SOULGRINGER) == QUEST_STATUS_INCOMPLETE)
                    PlayerGUID = player->GetGUID();
            }
        }
    }

    void DoSpawn()
    {
        float fx, fy, fz;

        me->GetNearPoint(fx, fy, fz, 0.0f, 20.0f, 0.0f);
        me->SummonCreature(NPC_SSPIRIT, fx, fy, fz, me->GetAngle(fx, fy), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
        me->GetNearPoint(fx, fy, fz, 0.0f, 20.0f, 4.6f);
        me->SummonCreature(NPC_SSPIRIT, fx, fy, fz, me->GetAngle(fx, fy), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);

        if (roll_chance_i(60))
        {
            me->GetNearPoint(fx, fy, fz, 0.0f, 20.0f, 1.5f);
            me->SummonCreature(NPC_SSPIRIT, fx, fy, fz, me->GetAngle(fx, fy), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
        }

        if (roll_chance_i(50))
        {
            me->GetNearPoint(fx, fy, fz, 0.0f, 20.0f, 3.1f);
            me->SummonCreature(NPC_SSPIRIT, fx, fy, fz, me->GetAngle(fx, fy), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
        }
    }

    void JustSummoned(Creature* summoned)
    {
        summons.Summon(summoned);

        if (summoned->GetEntry() == NPC_SSPIRIT)
        {
            summoned->CastSpell(summoned , SPELL_GTRANSFORM, true);

            if (Unit* target = me->GetPlayer(PlayerGUID))
                summoned->AI()->AttackStart(target);
        }

        if (summoned->GetEntry() == NPC_BRITUAL)
        {
            summoned->CastSpell(me, SPELL_RBEAM, true);
        }
        else 
        {
            if (summoned->GetEntry() == NPC_SCULLOC)
                SkullocGUID = summoned->GetGUID();
        }
    }

    void Beam()
    {
        ++Count;

        switch (Count)
        {
            case 1:
                DoCast(me, SPELL_SHADOWFORMONE, true);
                me->SummonCreature(NPC_BRITUAL, ent[0].x, ent[0].y, ent[0].z, ent[0].o, TEMPSUMMON_DEAD_DESPAWN, 5000);
                break;
            case 2:
                DoCast(me, SPELL_SHADOWFORMTWO, true);
                me->SummonCreature(NPC_BRITUAL, ent[1].x, ent[1].y, ent[1].z, ent[1].o, TEMPSUMMON_DEAD_DESPAWN, 5000);
                me->SummonCreature(NPC_SCULLOC, ent[2].x, ent[2].y, ent[2].z, ent[2].o, TEMPSUMMON_DEAD_DESPAWN, 5000);
                break;
            case 3:
                DoCast(me, SPELL_SHADOWFORMTHREE, true);
                me->SummonCreature(NPC_BRITUAL, ent[3].x, ent[3].y, ent[3].z, ent[3].o, TEMPSUMMON_DEAD_DESPAWN, 5000);
                break;
            case 4:
                DoCast(me, SPELL_SHADOWFORMFOUR, true);
                me->SummonCreature(NPC_BRITUAL, ent[4].x, ent[4].y, ent[4].z, ent[4].o, TEMPSUMMON_DEAD_DESPAWN, 5000);
                break;
            case 5:
                DoSpawns = false;
                summons.DespawnEntry(NPC_BRITUAL);

                if (Creature* Skulloc = me->GetCreature(SkullocGUID))
                    Skulloc->CastSpell(me, SPELL_RBEAM, true);
                break;
            case 6:
                summons.DespawnEntry(NPC_SSPIRIT);

                if (Creature* Skulloc = me->GetCreature(SkullocGUID))
                    Skulloc->SetVisibility(VISIBILITY_OFF);

                summons.DespawnEntry(NPC_SCULLOC);

                if (Creature* Skulloc = me->SummonCreature(NPC_SCULLOC, ent[2].x, ent[2].y, ent[2].z, ent[2].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                {
                    Skulloc->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

                    if (Unit* target = me->GetPlayer(PlayerGUID))
                        Skulloc->AI()->AttackStart(target);
                }
                me->ForcedDespawn();
                break;
        }

    }

    void UpdateAI(const uint32 diff)
    {
        if (DoSpawns)
        {            
            if (SpawnTimer <= diff)
            {
                DoSpawn();

                SpawnTimer = 20000;
            }
            else SpawnTimer -= diff;
        }

        if (BeamTimer <= diff)
        {
            Beam();

            if (Count == 5)
                BeamTimer = 5000;
            else BeamTimer = 80000;
        }
        else BeamTimer -= diff;
    }
};

CreatureAI* GetAI_npc_soulgrinder(Creature* creature)
{
    return new npc_soulgrinderAI (creature);
}

/*######
## Assault on Bash'ir Landing!
######*/

enum
{
    YELL_AETHER_1     = -1900226,
    YELL_AETHER_2     = -1900227,
    YELL_AETHER_3     = -1900230,
    YELL_AETHER_4     = -1900232,
    YELL_ASSISTANT    = -1900228,
    YELL_ADEPT        = -1900229,
    YELL_MASTER       = -1900231,

    NPC_SSLAVE        = 23246,
    NPC_FFIEND        = 23249,
    NPC_SUBPRIMAL     = 23247,
    NPC_CONTROLLER    = 23368,
    NPC_HARBRINGER    = 23390,
    NPC_INQUISITOR    = 23414,
    NPC_RECKONER      = 23332,
    NPC_GCOLLECTOR    = 23333,
    NPC_DISRUPTORT    = 23250,
    NPC_AETHER        = 23241,
    NPC_ASSISTANT     = 23243,
    NPC_ADEPT         = 23244,
    NPC_MASTER        = 23245,
    NPC_SRANGER       = 23242,
    NPC_LIEUTENANT    = 23430
};

struct Assault
{
    float x, y, z, o;
};

static Assault AssaultPos[]=
{
    { 4014.87f, 5891.27f, 267.870f, 0.608f },
    { 4018.21f, 5888.22f, 267.870f, 1.271f },
    { 4013.54f, 5895.92f, 267.870f, 6.138f },
    { 2529.85f, 7323.99f, 375.353, 5.834f },
    { 3063.00f, 6708.12f, 585.281, 5.834f },
};

static Assault AssaultPosone[]=
{
    { 3975.04f, 5860.19f, 266.310, 0.674f },
    { 3974.83f, 5871.05f, 265.135, 0.674f },
    { 3966.80f, 5874.23f, 265.294, 0.674f },
    { 3969.07f, 5884.81f, 266.298, 0.674f },
    { 3981.83f, 5856.02f, 266.298, 0.674f },
    { 3981.12f, 5845.82f, 266.712, 0.674f },
    { 3989.52f, 5845.91f, 266.793, 0.674f },
    { 3968.80f, 5856.74f, 266.725, 0.674f }
};

static Assault AssaultPostwo[]=
{
    { 4005.12f, 5894.48f, 267.348, 4.926f },
    { 4014.66f, 5880.12f, 267.871, 2.499f },
    { 4011.16f, 5888.21f, 267.826, 3.779f }
};

struct npc_bashir_landingAI : public ScriptedAI
{
    npc_bashir_landingAI(Creature* creature) : ScriptedAI(creature), summons(me) {}

    bool Assault;
    bool CanStart;
    bool Next;

    SummonList summons;
    std::list<uint64> attackers;

    uint32 CheckTimer;
    uint32 SpawnTimer;
    uint32 StartSpawnTimer;
    uint32 EndTimer;
    uint8 Wave;
    uint64 AetherGUID;
    uint64 CollectorGUID;

    void Reset() 
    {
        CanStart = true;
        Assault = false;
        Next = true;
        CheckTimer = 3000;
        SpawnTimer = 60000;
        StartSpawnTimer = 240000;
        EndTimer = 1500000;
        attackers.clear();
        Wave = 0;
        AetherGUID = 0;
        CollectorGUID = 0;
        SpawnDefenders();
    }

    void SpawnDefenders()
    {
        for (int i = 0; i < 4; i++)
        {
            switch (i)
            {
                case 0:
                    me->SummonCreature(NPC_AETHER, AssaultPos[i].x, AssaultPos[i].y, AssaultPos[i].z,  AssaultPos[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                    break;
                case 1:
                    me->SummonCreature(NPC_SRANGER, AssaultPos[i].x, AssaultPos[i].y, AssaultPos[i].z,  AssaultPos[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                    break;
                case 2:
                    me->SummonCreature(NPC_SRANGER, AssaultPos[i].x, AssaultPos[i].y, AssaultPos[i].z,  AssaultPos[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                    break;
                case 3:
                    me->SummonCreature(NPC_LIEUTENANT, AssaultPos[i].x, AssaultPos[i].y, AssaultPos[i].z,  AssaultPos[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                    break;
            }
        }
    }

    void JustSummoned(Creature* summoned)
    {
        summons.Summon(summoned);

        if (summoned->GetEntry() == NPC_SRANGER)
            summoned->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USESTANDING);

        if (summoned->GetEntry() == NPC_SUBPRIMAL ||
            summoned->GetEntry() == NPC_CONTROLLER ||
            summoned->GetEntry() == NPC_HARBRINGER ||
            summoned->GetEntry() == NPC_INQUISITOR ||
            summoned->GetEntry() == NPC_RECKONER)
        {
            attackers.push_back(summoned->GetGUID());
            summoned->GetMotionMaster()->MoveFleeing(summoned, 3000);
        }

        if (summoned->GetEntry() == NPC_SSLAVE ||
            summoned->GetEntry() == NPC_FFIEND)
        {
            attackers.push_back(summoned->GetGUID());
            summoned->GetMotionMaster()->MoveFleeing(summoned, 3000);

            if (Creature* Aether = me->GetCreature(AetherGUID))
                summoned->AI()->AttackStart(Aether);
        }

        if (summoned->GetEntry() == NPC_GCOLLECTOR)
        {
            attackers.push_back(summoned->GetGUID());
            CollectorGUID = summoned->GetGUID();
            summoned->SetReactState(REACT_PASSIVE);
        }
        
        if (summoned->GetEntry() == NPC_DISRUPTORT)
        {
            attackers.push_back(summoned->GetGUID());
            if (Creature* Aether = me->GetCreature(AetherGUID))
                Aether->AI()->AttackStart(summoned);
        }

        if (summoned->GetEntry() == NPC_AETHER)
        {
            AetherGUID = summoned->GetGUID();
            DoScriptText(YELL_AETHER_1, summoned);
            summoned->SetReactState(REACT_AGGRESSIVE);
            summoned->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USESTANDING);
        }

        if (summoned->GetEntry() == NPC_ASSISTANT)
            DoScriptText(YELL_ASSISTANT, summoned);

        if (summoned->GetEntry() == NPC_ADEPT)
            DoScriptText(YELL_ADEPT, summoned);

        if (summoned->GetEntry() == NPC_MASTER)
        {
            DoScriptText(YELL_MASTER, summoned);
            if (Creature* Aether = me->GetCreature(AetherGUID))
                DoScriptText(YELL_AETHER_4, Aether);
        }

        if (summoned->GetEntry() == NPC_LIEUTENANT)
        {
            summoned->Mount(21152);
            summoned->SetLevitate(true);
            summoned->SetSpeed(MOVE_FLIGHT, 1.00f);
            summoned->GetMotionMaster()->MovePoint(0, AssaultPos[4].x, AssaultPos[4].y, AssaultPos[4].z);
            summoned->ForcedDespawn(40000);
        }
    }

    void NextWave()
    {
        ++Wave;

        switch (Wave)
        {
            case 1: //1.1
                for (int i = 0; i < 7; i++)
                    me->SummonCreature(NPC_SSLAVE, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                break;
            case 2: //1.2
                for (int i = 0; i < 7; i++)
                {
                    switch (i)
                    {
                        case 0:
                            me->SummonCreature(NPC_FFIEND, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                        case 1:
                        case 2:
                        case 3:
                        case 4:
                        case 5:
                        case 6:
                            me->SummonCreature(NPC_SSLAVE, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                    }
                }
                Next = false;
                break;
            case 3: //2.1
                me->SummonCreature(NPC_ASSISTANT, AssaultPostwo[0].x, AssaultPostwo[0].y, AssaultPostwo[0].z,  AssaultPostwo[0].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);

                for (int i = 0; i < 7; i++)
                    me->SummonCreature(NPC_SUBPRIMAL, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);

                for (int i = 0; i < 7; i++)
                    me->SummonCreature(NPC_SSLAVE, AssaultPosone[i].x+(rand()%6), AssaultPosone[i].y+(rand()%6), AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);

                Next = true;
                break;
            case 4: //2.2
                if (Creature* Aether = me->GetCreature(AetherGUID))
                    DoScriptText(YELL_AETHER_2, Aether);

                for (int i = 0; i < 7; i++)
                {
                    switch (i)
                    {
                        case 0:
                        case 3:
                        case 6:
                            me->SummonCreature(NPC_DISRUPTORT, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                        case 1:
                        case 2:
                        case 4:
                        case 5:
                            me->SummonCreature(NPC_SUBPRIMAL, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                    }
                }
                Next = false;
                break;
            case 5: //3.1
                me->SummonCreature(NPC_ADEPT, AssaultPostwo[1].x, AssaultPostwo[1].y, AssaultPostwo[1].z,  AssaultPostwo[1].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);

                for (int i = 0; i < 7; i++)
                {
                    switch (i)
                    {
                        case 0:
                            me->SummonCreature(NPC_CONTROLLER, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                        case 3:
                        case 6:
                            me->SummonCreature(NPC_HARBRINGER, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                        case 1:
                        case 4:
                            me->SummonCreature(NPC_INQUISITOR, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                        case 2:
                        case 5:
                            me->SummonCreature(NPC_RECKONER, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                    }
                }
                Next = true;
                break;
            case 6: //3.2
                if (Creature* Aether = me->GetCreature(AetherGUID))
                    DoScriptText(YELL_AETHER_3, Aether);

                for (int i = 0; i < 8; i++)
                {
                    switch (i)
                    {
                        case 1:
                        case 4:
                            me->SummonCreature(NPC_INQUISITOR, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                        case 2:
                        case 5:
                            me->SummonCreature(NPC_RECKONER, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                        case 0:
                        case 3:
                        case 6:
                            me->SummonCreature(NPC_HARBRINGER, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                        case 7:
                            me->SummonCreature(NPC_GCOLLECTOR, AssaultPosone[i].x, AssaultPosone[i].y, AssaultPosone[i].z,  AssaultPosone[i].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                            break;
                    }
                }
                break;
            case 7:
                if (Creature* Aether = me->GetCreature(AetherGUID))
                {
                    if (Creature* Collector = me->GetCreature(CollectorGUID))
                    {
                        Collector->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        Collector->SetReactState(REACT_AGGRESSIVE);
                        Collector->AI()->AttackStart(Aether);
                    }
                }
                Next = false;
                break;
            case 8:
                me->SummonCreature(NPC_MASTER, AssaultPostwo[2].x, AssaultPostwo[2].y, AssaultPostwo[2].z,  AssaultPostwo[2].o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1500000);
                Assault = true;
                break;
        }
    }

    void EventFail()
    {
        summons.DespawnAll();
        attackers.clear();
        Assault = true;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!Assault)
        {
            if (CheckTimer <= diff)
            {
                Map* tmpMap = me->GetMap();

                if (!tmpMap)
                    return;

                if (!attackers.empty())
                {
                    bool alive = false;
                    for (std::list<uint64>::iterator itr = attackers.begin(); itr != attackers.end(); ++itr)
                    {
                        if (Creature* attacker = tmpMap->GetCreature((*itr)))
                        {
                            if (attacker->isAlive())
                            {
                                alive = true;
                                break;
                            }
                        }
                    }

                    if (!alive)
                    {
                        NextWave();
                        SpawnTimer = 180000;
                    }
                 }

                 CheckTimer = 3000;

                 if (Creature* Aether = me->GetCreature(AetherGUID))
                 {
                     if (Aether->isAlive())
                         return;
                     else EventFail();
                 }
            }
            else CheckTimer -= diff;

            if (Next)
            {
                if (SpawnTimer <= diff) 
                {
                    NextWave();
                    SpawnTimer = 180000;
                }
                else SpawnTimer -= diff;
            }
        }

        if (CanStart)
        {
            if (StartSpawnTimer <= diff) 
            {
                NextWave();
                CanStart = false;
            }
            else StartSpawnTimer -= diff;
        }

        if (EndTimer <= diff) 
        {
            EventFail();
        }
        else EndTimer -= diff;
    }
};

CreatureAI* GetAI_npc_bashir_landing(Creature* creature)
{
    return new npc_bashir_landingAI (creature);
}

/*######
## npc_banishing_crystal
######*/

enum
{
    SPELL_MASTER        = 40828,
    SPELL_BANISHMENT    = 40857,

    NPC_BCREDIT         = 23327
};

struct npc_banishing_crystalAI : public ScriptedAI
{
    npc_banishing_crystalAI(Creature* creature) : ScriptedAI(creature) {}

    uint64 PlayerGUID;

    void Reset() 
    {
        PlayerGUID = 0;
        DoCast(me, SPELL_BANISHMENT);
        GetPlayer();
    }

    void GetPlayer()
    { 
        Map* map = me->GetMap();
        Map::PlayerList const &PlayerList = map->GetPlayers();

        for(Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
        {
            if (Player* player = itr->getSource())
            {
                if (me->IsWithinDistInMap(player, 30.0f) && (player->GetQuestStatus(11026) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(11051) == QUEST_STATUS_INCOMPLETE))
                    PlayerGUID = player->GetGUID();
            }
        }
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if (spell->Id == SPELL_MASTER)
        {
            if (Player* player = me->GetPlayer(PlayerGUID))
                player->KilledMonster(NPC_BCREDIT, me->GetGUID());
        }
    }
};

CreatureAI* GetAI_npc_banishing_crystal(Creature* creature)
{
    return new npc_banishing_crystalAI (creature);
}

/*######
## mob_phase_wyrm
######*/

struct mob_phase_wyrmAI : public ScriptedAI
{
    mob_phase_wyrmAI(Creature *c) : ScriptedAI(c) {
        NeedReset = false;
    }

    bool NeedReset;

    void Reset()
    {
        if (NeedReset)
        {
            me->DealDamage(me, me->GetMaxHealth());
            NeedReset = false;
            me->Respawn();
        }
        NeedReset = false;
        me->CastSpell(me, 44588, false);
    } 

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
        {
            if (NeedReset)
                me->AI()->Reset();
            return;
        }
        else
            NeedReset = true;

        DoMeleeAttackIfReady();        
    }
};

CreatureAI* GetAI_mob_phase_wyrm(Creature *_Creature)
{
    return new mob_phase_wyrmAI (_Creature);
}

/*######
## npc_bloodmaul_dire_wolf
######*/

enum
{
    SPELL_REND = 13443,
    SPELL_RINAS_DIMINUTION_POWDER = 36310,

    NPC_DIRE_WOLF_TRIGGER = 21176,

    QUEST_A_DIRE_SITUATION = 10506,

    FACTION_FRIENDLY = 35,
};

struct npc_bloodmaul_dire_wolfAI : public ScriptedAI
{
    npc_bloodmaul_dire_wolfAI(Creature* pCreature) : ScriptedAI(pCreature) { }

    bool m_bSpellHit;
    uint32 m_uiUnfriendlyTimer; // Timer before resetting after quest item being used
    uint32 m_uiRendTimer;

    void Reset()
    {
        m_bSpellHit = false;
        m_creature->RestoreFaction();

        m_uiUnfriendlyTimer = 0;
        m_uiRendTimer = urand(3000, 6000);
    }

    void SpellHit(Unit* pCaster, const SpellEntry* pSpell)
    {
        if (!pCaster)
            return;

        if (pCaster->GetTypeId() == TYPEID_PLAYER && pSpell->Id == SPELL_RINAS_DIMINUTION_POWDER && !m_bSpellHit)
        {
            m_bSpellHit = true;
            
            if (pCaster->ToPlayer()->GetQuestStatus(QUEST_A_DIRE_SITUATION) == QUEST_STATUS_INCOMPLETE)
                pCaster->ToPlayer()->KilledMonster(NPC_DIRE_WOLF_TRIGGER, m_creature->GetGUID());

            m_creature->setFaction(FACTION_FRIENDLY);
            m_creature->CombatStop();
            m_uiUnfriendlyTimer = 60000;
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        // Reset npc on timer
        if (m_uiUnfriendlyTimer)
        {
            if (m_uiUnfriendlyTimer <= uiDiff)
                EnterEvadeMode();
            else
                m_uiUnfriendlyTimer -= uiDiff;
        }

        if (!UpdateVictim())
            return;

        if (m_uiRendTimer < uiDiff)
        {
            DoCastVictim(SPELL_REND);
            m_uiRendTimer = urand(8000, 13000);
        }
        else
            m_uiRendTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_bloodmaul_dire_wolf(Creature* pCreature)
{
    return new npc_bloodmaul_dire_wolfAI(pCreature);
}

/*######
## AddSC
######*/

void AddSC_blades_edge_mountains()
{
    Script* newscript;

    newscript = new Script;
    newscript->Name="mobs_nether_drake";
    newscript->GetAI = &GetAI_mobs_nether_drake;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_daranelle";
    newscript->GetAI = &GetAI_npc_daranelle;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_overseer_nuaar";
    newscript->pGossipHello = &GossipHello_npc_overseer_nuaar;
    newscript->pGossipSelect = &GossipSelect_npc_overseer_nuaar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_saikkal_the_elder";
    newscript->pGossipHello = &GossipHello_npc_saikkal_the_elder;
    newscript->pGossipSelect = &GossipSelect_npc_saikkal_the_elder;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_skyguard_handler_irena";
    newscript->pGossipHello =  &GossipHello_npc_skyguard_handler_irena;
    newscript->pGossipSelect = &GossipSelect_npc_skyguard_handler_irena;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_bloodmaul_brutebane";
    newscript->GetAI = &GetAI_npc_bloodmaul_brutebane;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_ogre_brute";
    newscript->GetAI = &GetAI_npc_ogre_brute;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_vim_bunny";
    newscript->GetAI = &GetAI_npc_vim_bunny;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_aetherray";
    newscript->GetAI = &GetAI_mob_aetherray;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_wildlord_antelarion";
    newscript->pGossipHello = &GossipHello_npc_wildlord_antelarion;
    newscript->pGossipSelect = &GossipSelect_npc_wildlord_antelarion;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_kolphis_darkscale";
    newscript->pGossipHello = &GossipHello_npc_kolphis_darkscale;
    newscript->pGossipSelect = &GossipSelect_npc_kolphis_darkscale;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_prophecy_trigger";
    newscript->GetAI = &GetAI_npc_prophecy_trigger;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_thunderspike";
    newscript->pGOUse = &GOUse_go_thunderspike;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_apexis_relic";
    newscript->pGOUse = &OnGossipHello_go_apexis_relic;
    newscript->pGossipSelectGO = &OnGossipSelect_go_apexis_relic;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_simon_cluster";
    newscript->pGOUse = &OnGossipHello_go_simon_cluster;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_simon_bunny";
    newscript->GetAI = &Get_npc_simon_bunnyAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_orb_attracter";
    newscript->GetAI = &Get_npc_orb_attracterAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_razaan_event";
    newscript->GetAI = &GetAI_npc_razaan_event;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_razaani_raider";
    newscript->GetAI = &GetAI_npc_razaani_raider;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_rally_zapnabber";
    newscript->GetAI = &GetAI_npc_rally_zapnabber;
    newscript->pGossipHello =   &GossipHello_npc_rally_zapnabber;
    newscript->pGossipSelect =  &GossipSelect_npc_rally_zapnabber;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_anger_camp";
    newscript->GetAI = &GetAI_npc_anger_camp;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_obeliks";
    newscript->pGOUse = &GOUse_go_obeliks;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_cannon_target";
    newscript->GetAI = &GetAI_npc_cannon_target;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_gargrom";
    newscript->GetAI = &GetAI_npc_gargrom;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_soulgrinder";
    newscript->GetAI = &GetAI_npc_soulgrinder;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_bashir_landing";
    newscript->GetAI = &GetAI_npc_bashir_landing;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_banishing_crystal";
    newscript->GetAI = &GetAI_npc_banishing_crystal;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_phase_wyrm";
    newscript->GetAI = &GetAI_mob_phase_wyrm;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_bloodmaul_dire_wolf";
    newscript->GetAI = &GetAI_npc_bloodmaul_dire_wolf;
    newscript->RegisterSelf();
}
