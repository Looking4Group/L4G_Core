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
SDName: Item_Scripts
SD%Complete: 100
SDComment: Items for a range of different items. See content below (in script)
SDCategory: Items
EndScriptData */

/* ContentData
item_attuned_crystal_cores(i34368)  Prevent abuse(quest 11524 & 11525)
item_blackwhelp_net(i31129)         Quest Whelps of the Wyrmcult (q10747). Prevents abuse
item_draenei_fishing_net(i23654)    Hacklike implements chance to spawn item or creature
item_disciplinary_rod               Prevents abuse
item_nether_wraith_beacon(i31742)   Summons creatures for quest Becoming a Spellfire Tailor (q10832)
item_flying_machine(i34060,i34061)  Engineering crafted flying machines
item_gor_dreks_ointment(i30175)     Protecting Our Own(q10488)
item_muiseks_vessel                 Cast on creature, they must be dead(q 3123,3124,3125,3126,3127)
item_only_for_flight                Items which should only useable while flying
item_protovoltaic_magneto_collector Prevents abuse
item_razorthorn_flayer_gland        Quest Discovering Your Roots (q11520) and Rediscovering Your Roots (q11521). Prevents abuse
item_tame_beast_rods(many)          Prevent cast on any other creature than the intended (for all tame beast quests)
item_soul_cannon(i32825)            Prevents abuse of this item
item_sparrowhawk_net(i32321)        Quest To Catch A Sparrowhawk (q10987). Prevents abuse
item_voodoo_charm                   Provide proper error message and target(q2561)
item_vorenthals_presence(i30259)    Prevents abuse of this item
item_yehkinyas_bramble(i10699)      Allow cast spell on vale screecher only and remove corpse if cast sucessful (q3520)
item_zezzak_shard(i31463)           Quest The eyes of Grillok (q10813). Prevents abuse
item_inoculating_crystal            Quest Inoculating. Prevent abuse
EndContentData */

#include "precompiled.h"
#include "SpellMgr.h"
#include "Spell.h"
#include "WorldPacket.h"
#include "Chat.h"

/*#####
# item_only_for_flight
#####*/

bool ItemUse_item_only_for_flight(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    uint32 itemId = _Item->GetEntry();
    bool disabled = false;

    //for special scripts
    switch(itemId)
    {
       case 24538:
           if(player->GetCachedArea() != 3628)
               disabled = true;
               break;
       case 28132:
           if(player->GetCachedArea() != 3803)
               disabled = true;
               break;
       case 34489:
           if(player->GetCachedZone() != 4080)
               disabled = true;
               break;
    }

    // allow use in flight only
    if( player->IsTaxiFlying() && !disabled)
        return false;

    // error
    player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW,_Item,NULL);
    return true;
}

/*#####
# item_blackwhelp_net
#####*/

bool ItemUse_item_blackwhelp_net(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    Unit *target = targets.getUnitTarget();

    if(!target || target->GetTypeId() != TYPEID_UNIT || target->GetEntry() != 21387)
        return true;
    else
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 31130, 1);
        if( msg == EQUIP_ERR_OK )
        {
            Item* item = player->StoreNewItem(dest,31130,true);
            if( item )
                player->SendNewItem(item,1,false,true);
            else
                player->SendEquipError(msg,NULL,NULL);

            target->Kill(target, false);
            ((Creature*)target)->RemoveCorpse();
        }
        return false;
    }

    player->SendEquipError(EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM,_Item,NULL);
    return true;
}

/*#####
# item_draenei_fishing_net
#####*/

//This is just a hack and should be removed from here.
//Creature/Item are in fact created before spell are sucessfully casted, without any checks at all to ensure proper/expected behavior.
bool ItemUse_item_draenei_fishing_net(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    if( player->GetQuestStatus(9452) == QUEST_STATUS_INCOMPLETE )
    {
        GameObject* pGo = GetClosestGameObjectWithEntry(player, 181616, 10.0f);

        if(!pGo)
            return true;

        if( roll_chance_i(35) )
        {
            Creature *Murloc = player->SummonCreature(17102,player->GetPositionX() ,player->GetPositionY()+20, player->GetPositionZ(), 0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,10000);
            if( Murloc )
                Murloc->AI()->AttackStart(player);
        }
        else
        {
            ItemPosCountVec dest;
            uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 23614, 1);
            if( msg == EQUIP_ERR_OK )
            {
                Item* item = player->StoreNewItem(dest,23614,true);
                if( item )
                    player->SendNewItem(item,1,false,true);
            }
            else
                player->SendEquipError(msg,NULL,NULL);
        }
    }
    return false;
}


/*#####
# item_nether_wraith_beacon
#####*/

bool ItemUse_item_nether_wraith_beacon(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    if (player->GetQuestStatus(10832) == QUEST_STATUS_INCOMPLETE)
    {
        Creature *Nether;
        Nether = player->SummonCreature(22408,player->GetPositionX() ,player->GetPositionY()+20, player->GetPositionZ(), 0,TEMPSUMMON_TIMED_DESPAWN,180000);
        Nether = player->SummonCreature(22408,player->GetPositionX() ,player->GetPositionY()-20, player->GetPositionZ(), 0,TEMPSUMMON_TIMED_DESPAWN,180000);
        if (Nether)
            ((CreatureAI*)Nether->AI())->AttackStart(player);
    }
    return false;
}

/*#####
# item_flying_machine
#####*/

bool ItemUse_item_flying_machine(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    uint32 itemId = _Item->GetEntry();
    if( itemId == 34060 )
        if( player->GetBaseSkillValue(SKILL_RIDING) >= 225 )
            return false;

    if( itemId == 34061 )
        if( player->GetBaseSkillValue(SKILL_RIDING) == 300 )
            return false;

    debug_log("TSCR: Player attempt to use item %u, but did not meet riding requirement",itemId);
    player->SendEquipError(EQUIP_ERR_ERR_CANT_EQUIP_SKILL,_Item,NULL);
    return true;
}

/*#####
# item_gor_dreks_ointment
#####*/

bool ItemUse_item_gor_dreks_ointment(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    if( targets.getUnitTarget() && targets.getUnitTarget()->GetTypeId()==TYPEID_UNIT &&
        targets.getUnitTarget()->GetEntry() == 20748 && !targets.getUnitTarget()->HasAura(32578,0) )
        return false;

    player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW,_Item,NULL);
    return true;
}

/*#####
# item_muiseks_vessel
#####*/

bool ItemUse_item_muiseks_vessel(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    Unit* uTarget = targets.getUnitTarget();
    uint32 itemSpell = _Item->GetProto()->Spells[0].SpellId;
    uint32 cEntry = 0;
    uint32 cEntry2 = 0;
    uint32 cEntry3 = 0;
    uint32 cEntry4 = 0;

    if(itemSpell)
    {
        switch(itemSpell)
        {
            case 11885:                                     //Wandering Forest Walker
                cEntry =  7584;
                break;
            case 11886:                                     //Owlbeasts
                cEntry =  2927;
                cEntry2 = 2928;
                cEntry3 = 2929;
                cEntry4 = 7808;
                break;
            case 11887:                                     //Freyfeather Hippogryphs
                cEntry =  5300;
                cEntry2 = 5304;
                cEntry3 = 5305;
                cEntry4 = 5306;
                break;
            case 11888:                                     //Sprite Dragon Sprite Darters
                cEntry =  5276;
                cEntry2 = 5278;
                break;
            case 11889:                                     //Zapped Land Walker Land Walker Zapped Cliff Giant Cliff Giant
                cEntry =  5357;
                cEntry2 = 5358;
                cEntry3 = 14640;
                cEntry4 = 14604;
                break;
        }
        if( uTarget && uTarget->GetTypeId()==TYPEID_UNIT && uTarget->isDead() &&
            (uTarget->GetEntry()==cEntry || uTarget->GetEntry()==cEntry2 || uTarget->GetEntry()==cEntry3 || uTarget->GetEntry()==cEntry4) )
        {
            ((Creature*)uTarget)->RemoveCorpse();
            return false;
        }
    }

    WorldPacket data(SMSG_CAST_FAILED, (4+2));              // prepare packet error message
    data << uint32(_Item->GetEntry());                      // itemId
    data << uint8(SPELL_FAILED_BAD_TARGETS);                // reason
    player->GetSession()->SendPacket(&data);                // send message: Invalid target

    player->SendEquipError(EQUIP_ERR_NONE,_Item,NULL);      // break spell
    return true;
}

/*#####
# item_tame_beast_rods
#####*/

bool ItemUse_item_tame_beast_rods(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    uint32 itemSpell = _Item->GetProto()->Spells[0].SpellId;
    uint32 cEntry = 0;

    if(itemSpell)
    {
        switch(itemSpell)
        {
            case 19548: cEntry =  1196; break;              //Ice Claw Bear
            case 19674: cEntry =  1126; break;              //Large Crag Boar
            case 19687: cEntry =  1201; break;              //Snow Leopard
            case 19688: cEntry =  2956; break;              //Adult Plainstrider
            case 19689: cEntry =  2959; break;              //Prairie Stalker
            case 19692: cEntry =  2970; break;              //Swoop
            case 19693: cEntry =  1998; break;              //Webwood Lurker
            case 19694: cEntry =  3099; break;              //Dire Mottled Boar
            case 19696: cEntry =  3107; break;              //Surf Crawler
            case 19697: cEntry =  3126; break;              //Armored Scorpid
            case 19699: cEntry =  2043; break;              //Nightsaber Stalker
            case 19700: cEntry =  1996; break;              //Strigid Screecher
            case 30646: cEntry = 17217; break;              //Barbed Crawler
            case 30653: cEntry = 17374; break;              //Greater Timberstrider
            case 30654: cEntry = 17203; break;              //Nightstalker
            case 30099: cEntry = 15650; break;              //Crazed Dragonhawk
            case 30102: cEntry = 15652; break;              //Elder Springpaw
            case 30105: cEntry = 16353; break;              //Mistbat
        }
        if( targets.getUnitTarget() && targets.getUnitTarget()->GetTypeId()==TYPEID_UNIT &&
            targets.getUnitTarget()->GetEntry() == cEntry )
            return false;
    }

    WorldPacket data(SMSG_CAST_FAILED, (4+2));              // prepare packet error message
    data << uint32(_Item->GetEntry());                      // itemId
    data << uint8(SPELL_FAILED_BAD_TARGETS);                // reason
    player->GetSession()->SendPacket(&data);                // send message: Invalid target

    player->SendEquipError(EQUIP_ERR_NONE,_Item,NULL);      // break spell
    return true;
}


/*#####
# item_specific_target
#####*/

enum aliveMask
{
    T_ALIVE = 0x1,
    T_DEAD  = 0x2
};

#define MAX_TARGETS 4

bool ItemUse_item_specific_target(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    Unit *uTarget = targets.getUnitTarget() ? targets.getUnitTarget() : Unit::GetUnit(*player, player->GetSelection());

    uint32 iEntry = _Item->GetEntry();
    uint32 cEntry[MAX_TARGETS] = { 0, 0, 0, 0 };

    uint8 targetState = T_ALIVE & T_DEAD;

    switch(iEntry)
    {
        case 8149:  cEntry[0] = 7318; targetState = T_DEAD; break; // Voodoo Charm
        case 22783: cEntry[0] = 16329; break; // Sunwell Blade
        case 22784: cEntry[0] = 16329; break; // Sunwell Orb
        case 22962: cEntry[0] = 16518; break; // Inoculating Crystal
        case 30259: cEntry[0] = 20132; break; // Voren'thal's Presence
        case 30656: cEntry[0] = 21729; break; // Protovoltaic Magneto Collector
        case 31463: cEntry[0] = 19440; break; // Zezzak's Shard
        case 32321: cEntry[0] = 22979; break; // Sparrowhawk Net
        case 32825: cEntry[0] = 22357; break; // Soul Cannon
        case 34255: cEntry[0] = 24922; break; // Razorthorn Flayer Gland
        case 25552: cEntry[0] = 17148; cEntry[1] = 17147; cEntry[2] = 17146; targetState = T_DEAD; break; // Warmaul Ogre Banner
        case 22473: cEntry[0] = 15941; cEntry[1] = 15945; break; // Disciplinary Rod
        case 34368: cEntry[0] = 24972; targetState = T_DEAD; break; // Attuned Crystal Cores
        case 29513: cEntry[0] = 19354; break; // Staff of the Dreghood Elders
        case 32680: cEntry[0] = 23311; targetState = T_ALIVE; break; // Booterang
        case 30251: cEntry[0] = 20058; break; // Rina's Diminution Powder
        case 23417: cEntry[0] = 16975; break; // Sanctified Crystal
        case 32698: cEntry[0] = 22181; break; // Wrangling Rope
        case 34257: cEntry[0] = 24918; targetState = T_ALIVE; break; // Fel Siphon
        case 28547: cEntry[0] = 18881; cEntry[1] = 18865; break; //Elemental power extractor
        case 12284: cEntry[0] = 7047; cEntry[1] = 7048; cEntry[2] = 7049; break; // Draco-Incarcinatrix 900
        case 23337: cEntry[0] = 16880; targetState = T_ALIVE; break;    // Cenarion Antidote
        case 29818: cEntry[0] = 20774; targetState = T_ALIVE; break;    // Energy Field Modulator
        case 13289: cEntry[0] = 10384; cEntry[1] = 10385; targetState = T_ALIVE; break;    // Egan's Blaster
        case 10699: cEntry[0] = 5307;  cEntry[1] = 5308;  targetState = T_DEAD; break;  // Yehkinyas Bramble
    }

    if(uTarget && uTarget->GetTypeId() == TYPEID_UNIT)
    {
        bool properTarget = false;
        for(uint8 i = 0; i < MAX_TARGETS; i++)
        {
            if(uTarget->GetEntry() == cEntry[i])
            {
                properTarget = true;
                break;
            }
        }

        if(properTarget)
        {
            switch(targetState)
            {
                case(T_ALIVE & T_DEAD):
                    return false;
                case T_ALIVE:
                {
                    if(uTarget->isAlive())
                        return false;
                    else
                    {
                        WorldPacket data(SMSG_CAST_FAILED, (4+2));              // prepare packet error message
                        data << uint32(_Item->GetEntry());                      // itemId
                        data << uint8(SPELL_FAILED_TARGETS_DEAD);               // reason
                        player->GetSession()->SendPacket(&data);                // send message: Invalid target
                        player->SendEquipError(EQUIP_ERR_NONE,_Item,NULL);
                        return true;
                    }
                }
                case T_DEAD:
                {
                    if(uTarget->getDeathState() == CORPSE)
                        return false;
                    else if (uTarget->getDeathState() != DEAD)
                    {
                        WorldPacket data(SMSG_CAST_FAILED, (4+2));              // prepare packet error message
                        data << uint32(_Item->GetEntry());                      // itemId
                        data << uint8(SPELL_FAILED_TARGET_NOT_DEAD);            // reason
                        player->GetSession()->SendPacket(&data);                // send message: Invalid target
                        player->SendEquipError(EQUIP_ERR_NONE,_Item,NULL);
                        return true;
                    }
                    // if deathstate == dead corpse should be invisible and untargettable, so invalid target
                }
            }
        }
    }

    WorldPacket data(SMSG_CAST_FAILED, (4+2));              // prepare packet error message
    data << uint32(_Item->GetEntry());                      // itemId
    data << uint8(SPELL_FAILED_BAD_TARGETS);                // reason
    player->GetSession()->SendPacket(&data);                // send message: Invalid target

    player->SendEquipError(EQUIP_ERR_NONE,_Item,NULL);      // break spell
    return true;
}

/*#####
# item_rood_rofl - custom event mount
#####*/

bool ItemUse_item_rood_rofl(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    // player must have riding skill
    if(!player->HasSkill(762))
    {
        player->SendEquipError(EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM,_Item,NULL);
        return true;
    }
    // player must have possibility to use 60% flying mount
    if(player->GetBaseSkillValue(762) < 225)
    {
        player->SendEquipError(EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM,_Item,NULL);
        return true;
    }

    if (player->HasAuraType(SPELL_AURA_MOUNTED))
        player->RemoveSpellsCausingAura(SPELL_AURA_MOUNTED);

    return false;
}

/*#####
# item_chest_of_containment_coffers
#####*/

#define MOB_RIFT_SPAWN          6492
#define SPELL_SELF_STUN_30SEC   9032

bool ItemUse_item_chest_of_containment_coffers(Player *player, Item* _Item, SpellCastTargets const& targets)
{
    std::list<Creature*> SpawnList;
    Looking4group::AllCreaturesOfEntryInRange u_check(player, MOB_RIFT_SPAWN, 20.0);
    Looking4group::ObjectListSearcher<Creature, Looking4group::AllCreaturesOfEntryInRange> searcher(SpawnList, u_check);
    Cell::VisitAllObjects(player, searcher, 20.0);

    if(!SpawnList.empty())
    {
        for(std::list<Creature*>::iterator i = SpawnList.begin(); i != SpawnList.end(); ++i)
        {
            if((*i)->HasAura(SPELL_SELF_STUN_30SEC))
                return false;
        }
    }

    WorldPacket data(SMSG_CAST_FAILED, (4+2));              // prepare packet error message
    data << uint32(_Item->GetEntry());                      // itemId
    data << uint8(SPELL_FAILED_BAD_TARGETS);                // reason
    player->GetSession()->SendPacket(&data);                // send message: Invalid target

    player->SendEquipError(EQUIP_ERR_NONE,_Item,NULL);      // break spell
    return true;
}

/*#####
# item_reset_talents
#####*/
bool ItemUse_item_reset_talents(Player *player, Item* _Item, SpellCastTargets const& /*targets*/)
{
    if (player)
    {
        if (player->getLevel() < 10)
        {
            WorldPacket data(SMSG_CAST_FAILED, (4+2));              // prepare packet error message
            data << uint32(_Item->GetEntry());                      // itemId
            data << uint8(SPELL_FAILED_LEVEL_REQUIREMENT);          // reason
            player->GetSession()->SendPacket(&data);                // send message: Invalid target
        }
        else
        {
            if (player->GetMap()->IsBattleGroundOrArena())
            {
                WorldPacket data(SMSG_CAST_FAILED, (4+2));              // prepare packet error message
                data << uint32(_Item->GetEntry());                      // itemId
                data << uint8(SPELL_FAILED_NOT_IN_ARENA);               // reason
                player->GetSession()->SendPacket(&data);                // send message: Invalid target
            }
            else
            {
                player->resetTalents(true);
                //player->DestroyItemCount(1000022, 1, true, false);
                player->Whisper("Deine Talente wurden zurueckgesetzt", LANG_UNIVERSAL, player->GetGUID());
                return true;
            }
        }
    }
    else
        return false;
}

/*#####
# item_maxskill
#####*/
bool ItemUse_item_maxskill(Player *player, Item* _Item, SpellCastTargets const& /*targets*/)
{
    if (player){
        player->UpdateSkillsToMaxSkillsForLevel(true);
        player->DestroyItemCount(1000023, 1, true, false);
        return true;
    }
    else
        return false;
}

/*#####
# item_gnomisator
#####*/
bool ItemUse_item_gnomisator(Player *player, Item* _Item, SpellCastTargets const& /*targets*/)
{
    if (player){
        player->SetDisplayId(6923);
        return true;
    }
    else
        return false;
}

/*#####
# item_arenapoints
#####*/
bool ItemUse_item_arenapoints(Player *player, Item* _Item, SpellCastTargets const& /*targets*/)
{
    if (player){
        player->ModifyArenaPoints(10);
        player->DestroyItemCount(11683, 1, true, false);
        return true;
    }
    else
        return false;
}

void AddSC_item_scripts()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="item_only_for_flight";
    newscript->pItemUse = &ItemUse_item_only_for_flight;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_blackwhelp_net";
    newscript->pItemUse = &ItemUse_item_blackwhelp_net;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_draenei_fishing_net";
    newscript->pItemUse = &ItemUse_item_draenei_fishing_net;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_nether_wraith_beacon";
    newscript->pItemUse = &ItemUse_item_nether_wraith_beacon;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_flying_machine";
    newscript->pItemUse = &ItemUse_item_flying_machine;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_gor_dreks_ointment";
    newscript->pItemUse = &ItemUse_item_gor_dreks_ointment;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_muiseks_vessel";
    newscript->pItemUse = &ItemUse_item_muiseks_vessel;
    newscript->RegisterSelf();


    newscript = new Script;
    newscript->Name="item_tame_beast_rods";
    newscript->pItemUse = &ItemUse_item_tame_beast_rods;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_specific_target";
    newscript->pItemUse = &ItemUse_item_specific_target;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_rood_rofl";
    newscript->pItemUse = &ItemUse_item_rood_rofl;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_chest_of_containment_coffers";
    newscript->pItemUse = &ItemUse_item_chest_of_containment_coffers;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_reset_talents";
    newscript->pItemUse = &ItemUse_item_reset_talents;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_maxskill";
    newscript->pItemUse = &ItemUse_item_maxskill;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_gnomisator";
    newscript->pItemUse = &ItemUse_item_gnomisator;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="item_arenapoints";
    newscript->pItemUse = &ItemUse_item_arenapoints;
    newscript->RegisterSelf();
}

