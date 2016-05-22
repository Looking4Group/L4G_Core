/*
 * Copyright (C) 2005-2008 MaNGOS <http://www.mangosproject.org/>
 *
 * Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
 *
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

#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "World.h"
#include "ObjectMgr.h"
#include "SpellMgr.h"
#include "Log.h"
#include "Opcodes.h"
#include "Spell.h"
#include "ObjectAccessor.h"
#include "MapManager.h"
#include "CreatureAI.h"
#include "Util.h"
#include "Pet.h"
#include "Language.h"

void WorldSession::HandlePetAction(WorldPacket & recv_data)
{
    Player *pPlayer = GetPlayer();

    uint64 charmGUID;
    uint64 targetGUID;
    uint16 spellId;
    uint16 flag;

    recv_data >> charmGUID;                                 // pet guid
    recv_data >> spellId;
    recv_data >> flag;                                      // delete = 0x0700 CastSpell = C100
    recv_data >> targetGUID;                                // tag guid

    // used also for charmed creature
    Unit* pCharm = pPlayer->GetUnit(charmGUID);
    if (!pCharm || (charmGUID != pPlayer->GetPetGUID() && charmGUID != pPlayer->GetCharmGUID()))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: PetHandler:: charm(%u), player doesn't have such pet/charm.", uint32(GUID_LOPART(charmGUID)));
        return;
    }

    // charm is dead, ignore
    if (!pCharm->isAlive())
        return;

    // charmed player can perform only attack
    if (pCharm->GetTypeId() == TYPEID_PLAYER)
    {
        if (flag != ACT_COMMAND && spellId != COMMAND_ATTACK)
            return;
    }

    CharmInfo *pCharmInfo = pCharm->GetCharmInfo();
    if (!pCharmInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: WorldSession::HandlePetAction: object " UI64FMTD " is considered pet-like but doesn't have a charminfo!", charmGUID);
        return;
    }

    switch (flag)
    {
        case ACT_COMMAND:                                   //0x0700
            // Possessed or shared vision pets are only able to attack
            if ((pCharm->isPossessed() || pCharm->HasAuraType(SPELL_AURA_BIND_SIGHT)) && spellId != COMMAND_ATTACK)
                return;

            switch (spellId)
            {
                case COMMAND_STAY:                          // flat=1792  // STAY
                    pCharmInfo->HandleStayCommand();
                    break;
                case COMMAND_FOLLOW:                        // spellid=1792  // FOLLOW
                    pCharmInfo->HandleFollowCommand();
                    break;
                case COMMAND_ATTACK:                        //spellid=1792  //ATTACK
                    pCharmInfo->HandleAttackCommand(targetGUID);
                    break;
                case COMMAND_ABANDON:                       // abandon (hunter pet) or dismiss (summoned pet)
                    if (Pet* pPet = pCharm->ToPet())
                    {
                        if (pPet->getPetType() == HUNTER_PET)
                            pPlayer->RemovePet(pPet, PET_SAVE_AS_DELETED);
                        else
                            pPet->setDeathState(CORPSE);
                    }
                    else                                    // charmed or possessed
                        pPlayer->Uncharm();
                    break;
                default:
                    sLog.outLog(LOG_DEFAULT, "ERROR: WORLD: unknown PET flag Action %i and spellid %i.\n", flag, spellId);
            }
            break;
        case ACT_REACTION:                                  // 0x600
            switch (spellId)
            {
                case REACT_PASSIVE:                         //passive
                    if (Pet* pPet = pCharm->ToPet())
                    {
                        pPet->AttackStop();
                        pPet->InterruptNonMeleeSpells(false);
                        pPet->GetMotionMaster()->MoveFollow(pPet->GetCharmerOrOwner(), PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                    }
                    if (pCharm->GetTypeId() == TYPEID_UNIT)
                    {
                        pCharm->ToCreature()->SetReactState(ReactStates(spellId));
                    }
                    break;
                case REACT_DEFENSIVE:                       //recovery
                    if (pCharm->GetTypeId() == TYPEID_UNIT)
                    {
                        pCharm->ToCreature()->SetReactState(ReactStates(spellId));
                    }
                    break;
                case REACT_AGGRESSIVE:                      //activete
                    if (pCharm->GetTypeId() == TYPEID_UNIT){
                        pCharm->ToCreature()->SetReactState(ReactStates(spellId));
                    }
                    break;
            }
            break;
        case ACT_DISABLED:                                  //0x8100    spell (disabled), ignore
        case ACT_CAST:                                      //0x0100
        case ACT_ENABLED:                                   //0xc100    spell
        {
            pCharmInfo->HandleSpellActCommand(targetGUID, spellId);
            break;
        }
        default:
            sLog.outLog(LOG_DEFAULT, "ERROR: WORLD: unknown PET flag Action %i and spellid %i.\n", flag, spellId);
    }
}

void WorldSession::HandlePetNameQuery(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data,4+8);

    sLog.outDetail("HandlePetNameQuery. CMSG_PET_NAME_QUERY\n");

    uint32 petnumber;
    uint64 petguid;

    recv_data >> petnumber;
    recv_data >> petguid;

    SendPetNameQuery(petguid,petnumber);
}

void WorldSession::SendPetNameQuery(uint64 petguid, uint32 petnumber)
{
    Creature* pet = _player->GetMap()->GetCreatureOrPet(petguid);
    if (!pet || !pet->GetCharmInfo() || pet->GetCharmInfo()->GetPetNumber() != petnumber)
    {
        WorldPacket data(SMSG_PET_NAME_QUERY_RESPONSE, (4+1+4+1));
        data << uint32(petnumber);
        data << uint8(0);
        data << uint32(0);
        data << uint8(0);
        _player->SendPacketToSelf(&data);
        return;
    }

    char const* name = pet->GetName();

    // creature pets have localization like other creatures
    if (!IS_PLAYER_GUID(pet->GetOwnerGUID()))
    {
        int loc_idx = GetSessionDbLocaleIndex();
        sObjectMgr.GetCreatureLocaleStrings(pet->GetEntry(), loc_idx, &name);
    }

    WorldPacket data(SMSG_PET_NAME_QUERY_RESPONSE, (4+4+strlen(name)+1));
    data << uint32(petnumber);
    data << name;
    data << uint32(pet->GetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP));

    if (pet->isPet() && ((Pet*)pet)->GetDeclinedNames())
    {
        data << uint8(1);
        for (int i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
            data << ((Pet*)pet)->GetDeclinedNames()->name[i];
    }
    else
        data << uint8(0);

    _player->SendPacketToSelf(&data);
}

void WorldSession::HandlePetSetAction(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data, 8+4+2+2);

    sLog.outDetail("HandlePetSetAction. CMSG_PET_SET_ACTION\n");

    uint64 petguid;
    uint32 position;
    uint16 spell_id;
    uint16 act_state;
    uint8  count;

    recv_data >> petguid;

    if (ObjectAccessor::FindPlayer(petguid))
        return;

    Creature* pet = _player->GetMap()->GetCreatureOrPet(petguid);

    if (!pet || (pet != _player->GetPet() && pet != _player->GetCharm()))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: HandlePetSetAction: Unknown pet or pet owner.\n");
        return;
    }

    CharmInfo *charmInfo = pet->GetCharmInfo();
    if (!charmInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: WorldSession::HandlePetSetAction: object " UI64FMTD " is considered pet-like but doesn't have a charminfo!", pet->GetGUID());
        return;
    }

    count = (recv_data.size() == 24) ? 2 : 1;
    for (uint8 i = 0; i < count; i++)
    {
        recv_data >> position;
        recv_data >> spell_id;
        recv_data >> act_state;

        sLog.outDetail("Player %s has changed pet spell action. Position: %u, Spell: %u, State: 0x%X\n", _player->GetName(), position, spell_id, act_state);

                                                            //if it's act for spell (en/disable/cast) and there is a spell given (0 = remove spell) which pet doesn't know, don't add
        if (!((act_state == ACT_ENABLED || act_state == ACT_DISABLED || act_state == ACT_CAST) && spell_id && !pet->HasSpell(spell_id)))
        {
            //sign for autocast
            if (act_state == ACT_ENABLED && spell_id)
            {
                if (pet->isCharmed())
                    charmInfo->ToggleCreatureAutocast(spell_id, true);
                else
                    ((Pet*)pet)->ToggleAutocast(spell_id, true);
            }
            //sign for no/turn off autocast
            else if (act_state == ACT_DISABLED && spell_id)
            {
                if (pet->isCharmed())
                    charmInfo->ToggleCreatureAutocast(spell_id, false);
                else
                    ((Pet*)pet)->ToggleAutocast(spell_id, false);
            }

            charmInfo->GetActionBarEntry(position)->Type = act_state;
            charmInfo->GetActionBarEntry(position)->SpellOrAction = spell_id;
        }
    }
}

void WorldSession::HandlePetRename(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data, 8+1);

    sLog.outDetail("HandlePetRename. CMSG_PET_RENAME\n");

    uint64 petguid;
    uint8 isdeclined;

    std::string name;
    DeclinedName declinedname;

    recv_data >> petguid;
    recv_data >> name;
    CHECK_PACKET_SIZE(recv_data, recv_data.rpos() + 1);
    recv_data >> isdeclined;

    Pet* pet = ObjectAccessor::GetPet(petguid);
                                                            // check it!
    if (!pet || !pet->isPet() || ((Pet*)pet)->getPetType()!= HUNTER_PET ||
        pet->GetByteValue(UNIT_FIELD_BYTES_2, 2) != UNIT_RENAME_ALLOWED ||
        pet->GetOwnerGUID() != _player->GetGUID() || !pet->GetCharmInfo())
        return;

    if (!ObjectMgr::IsValidPetName(name))
    {
        SendPetNameInvalid(PET_NAME_INVALID, name, NULL);
        return;
    }

    if (sObjectMgr.IsReservedName(name))
    {
        SendPetNameInvalid(PET_NAME_RESERVED, name, NULL);
        return;
    }

    pet->SetName(name);

    Unit *owner = pet->GetOwner();
    if (owner && (owner->GetTypeId() == TYPEID_PLAYER) && ((Player*)owner)->GetGroup())
        ((Player*)owner)->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_NAME);

    pet->SetByteValue(UNIT_FIELD_BYTES_2, 2, UNIT_RENAME_NOT_ALLOWED);

    if (isdeclined)
    {
        for (int i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
        {
            CHECK_PACKET_SIZE(recv_data, recv_data.rpos() + 1);
            recv_data >> declinedname.name[i];
        }

        std::wstring wname;
        Utf8toWStr(name, wname);
        if (!ObjectMgr::CheckDeclinedNames(GetMainPartOfName(wname,0),declinedname))
        {
            SendPetNameInvalid(PET_NAME_DECLENSION_DOESNT_MATCH_BASE_NAME, name, &declinedname);
            return;
        }
    }

    RealmDataDatabase.BeginTransaction();
    if (isdeclined)
    {
        for (int i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
            RealmDataDatabase.escape_string(declinedname.name[i]);
        RealmDataDatabase.PExecute("DELETE FROM character_pet_declinedname WHERE owner = '%u' AND id = '%u'", _player->GetGUIDLow(), pet->GetCharmInfo()->GetPetNumber());
        RealmDataDatabase.PExecute("INSERT INTO character_pet_declinedname (id, owner, genitive, dative, accusative, instrumental, prepositional) VALUES ('%u','%u','%s','%s','%s','%s','%s')",
            pet->GetCharmInfo()->GetPetNumber(), _player->GetGUIDLow(), declinedname.name[0].c_str(), declinedname.name[1].c_str(), declinedname.name[2].c_str(), declinedname.name[3].c_str(), declinedname.name[4].c_str());
    }

    RealmDataDatabase.escape_string(name);
    RealmDataDatabase.PExecute("UPDATE character_pet SET name = '%s', renamed = '1' WHERE owner = '%u' AND id = '%u'", name.c_str(), _player->GetGUIDLow(), pet->GetCharmInfo()->GetPetNumber());
    RealmDataDatabase.CommitTransaction();

    pet->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, time(NULL));
}

void WorldSession::HandlePetAbandon(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data, 8);

    uint64 guid;
    recv_data >> guid;                                      //pet guid
    sLog.outDetail("HandlePetAbandon. CMSG_PET_ABANDON pet guid is %u", GUID_LOPART(guid));

    if (!_player->IsInWorld())
        return;

    // pet/charmed
    Creature* pet = _player->GetMap()->GetCreatureOrPet(guid);
    if (pet)
    {
        if (pet->isPet())
        {
            if (pet->GetGUID() == _player->GetPetGUID())
            {
                uint32 feelty = pet->GetPower(POWER_HAPPINESS);
                pet->SetPower(POWER_HAPPINESS ,(feelty-50000) > 0 ?(feelty-50000) : 0);
            }

            _player->RemovePet((Pet*)pet,PET_SAVE_AS_DELETED);
        }
        else if (pet->GetGUID() == _player->GetCharmGUID())
            _player->Uncharm();
    }
}

void WorldSession::HandlePetUnlearnOpcode(WorldPacket& recvPacket)
{
    CHECK_PACKET_SIZE(recvPacket,8);

    sLog.outDetail("CMSG_PET_UNLEARN");
    uint64 guid;
    recvPacket >> guid;

    Pet* pet = _player->GetPet();

    if (!pet || pet->getPetType() != HUNTER_PET || pet->m_spells.size() <= 1)
        return;

    if (guid != pet->GetGUID())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: HandlePetUnlearnOpcode.Pet %u isn't pet of player %s .\n", uint32(GUID_LOPART(guid)),GetPlayer()->GetName());
        return;
    }

    CharmInfo *charmInfo = pet->GetCharmInfo();
    if (!charmInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: WorldSession::HandlePetUnlearnOpcode: object " UI64FMTD " is considered pet-like but doesn't have a charminfo!", pet->GetGUID());
        return;
    }

    uint32 cost = pet->resetTalentsCost();

    if (GetPlayer()->GetMoney() < cost)
    {
        GetPlayer()->SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, 0, 0, 0);
        return;
    }

    for (PetSpellMap::iterator itr = pet->m_spells.begin(); itr != pet->m_spells.end();)
    {
        uint32 spell_id = itr->first;                       // Pet::removeSpell can invalidate iterator at erase NEW spell
        ++itr;
        pet->removeSpell(spell_id);
    }

    pet->SetTP(pet->getLevel() * (pet->GetLoyaltyLevel() - 1));

    for (uint8 i = 0; i < 10; i++)
    {
        if (charmInfo->GetActionBarEntry(i)->SpellOrAction && charmInfo->GetActionBarEntry(i)->Type == ACT_ENABLED || charmInfo->GetActionBarEntry(i)->Type == ACT_DISABLED)
            charmInfo->GetActionBarEntry(i)->SpellOrAction = 0;
    }

    // relearn pet passives
    pet->LearnPetPassives();

    pet->m_resetTalentsTime = time(NULL);
    pet->m_resetTalentsCost = cost;
    GetPlayer()->ModifyMoney(-(int32)cost);

    GetPlayer()->PetSpellInitialize();
}

void WorldSession::HandlePetSpellAutocastOpcode(WorldPacket& recvPacket)
{
    CHECK_PACKET_SIZE(recvPacket,8+2+2+1);

    sLog.outDetail("CMSG_PET_SPELL_AUTOCAST");
    uint64 guid;
    uint16 spellid;
    uint16 spellid2;                                        //maybe second spell, automatically toggled off when first toggled on?
    uint8  state;                                           //1 for on, 0 for off
    recvPacket >> guid >> spellid >> spellid2 >> state;

    if (!_player->GetPet() && !_player->GetCharm())
        return;

    if (ObjectAccessor::FindPlayer(guid))
        return;

    Creature* pet = _player->GetMap()->GetCreatureOrPet(guid);

    if (!pet || (pet != _player->GetPet() && pet != _player->GetCharm()))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: HandlePetSpellAutocastOpcode.Pet %u isn't pet of player %s .\n", uint32(GUID_LOPART(guid)),GetPlayer()->GetName());
        return;
    }

    // do not add not learned spells/ passive spells
    if (!pet->HasSpell(spellid) || SpellMgr::IsPassiveSpell(spellid))
        return;

    CharmInfo *charmInfo = pet->GetCharmInfo();
    if (!charmInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: WorldSession::HandlePetSpellAutocastOpcod: object " UI64FMTD " is considered pet-like but doesn't have a charminfo!", pet->GetGUID());
        return;
    }

    if (pet->isCharmed())
                                                            //state can be used as boolean
        pet->GetCharmInfo()->ToggleCreatureAutocast(spellid, state);
    else
        ((Pet*)pet)->ToggleAutocast(spellid, state);

    for (uint8 i = 0; i < 10; ++i)
    {
        if ((charmInfo->GetActionBarEntry(i)->Type == ACT_ENABLED || charmInfo->GetActionBarEntry(i)->Type == ACT_DISABLED) && spellid == charmInfo->GetActionBarEntry(i)->SpellOrAction)
            charmInfo->GetActionBarEntry(i)->Type = state ? ACT_ENABLED : ACT_DISABLED;
    }
}

void WorldSession::HandlePetCastSpellOpcode(WorldPacket& recvPacket)
{
    sLog.outDetail("WORLD: CMSG_PET_CAST_SPELL");

    CHECK_PACKET_SIZE(recvPacket,8+4);
    uint64 guid;
    uint32 spellid;

    recvPacket >> guid >> spellid;

    // This opcode is also sent from charmed and possessed units (players and creatures)
    if (!_player->GetPet() && !_player->GetCharm())
        return;

    Unit* caster = _player->GetMap()->GetUnit(guid);

    if (!caster || (caster != _player->GetPet() && caster != _player->GetCharm()))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: HandlePetCastSpellOpcode: Pet %u isn't pet of player %s .\n", uint32(GUID_LOPART(guid)),GetPlayer()->GetName());
        return;
    }

    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellid);
    if (!spellInfo)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: WORLD: unknown PET spell id %i\n", spellid);
        return;
    }

    // do not cast not learned spells
    if (!caster->HasSpell(spellid) || SpellMgr::IsPassiveSpell(spellid))
        return;

    if (spellInfo->StartRecoveryCategory > 0) //Check if spell is affected by GCD
        if (caster->GetTypeId() == TYPEID_UNIT && caster->GetCharmInfo() && caster->GetCharmInfo()->GetCooldownMgr().HasGlobalCooldown(spellInfo))
        {
            caster->SendPetCastFail(spellid, SPELL_FAILED_NOT_READY);
            return;
        }

    SpellCastTargets targets;

    recvPacket >> targets.ReadForCaster(caster);

    uint64 charmerGuid = caster->isCharmed() ? caster->GetCharmerGUID() : 0;
    Spell *spell = new Spell(caster, spellInfo, spellid == 33395, charmerGuid); // water elemental can cast freeze as triggered
    spell->m_targets = targets;

    SpellCastResult result = spell->CheckPetCast(NULL);
    if(result == SPELL_CAST_OK)
    {
        if (caster->GetTypeId() == TYPEID_UNIT)
        {
            Creature* pet = (Creature*)caster;
            pet->AddCreatureSpellCooldown(spellid);
            if (pet->isPet())
            {
                Pet* p = (Pet*)pet;
                p->CheckLearning(spellid);
                // 10% chance to play special pet attack talk, else growl
                // actually this only seems to happen on special spells, fire shield for imp, torment for voidwalker, but it's stupid to check every spell
                if (p->getPetType() == SUMMON_PET && (urand(0, 100) < 10))
                    pet->SendPetTalk((uint32)PET_TALK_SPECIAL_SPELL);
                else
                    pet->SendPetAIReaction(guid);
            }
        }

        //caster-->GetMotionMaster()->StopMovement();
        //caster->GetMotionMaster()->MovementExpired(false);

        spell->prepare(&(spell->m_targets));
    }
    else
    {
        caster->SendPetCastFail(spellid, result);
        if (caster->GetTypeId() == TYPEID_PLAYER)
        {
            if (!((Player*)caster)->HasSpellCooldown(spellid))
                caster->SendPetClearCooldown(spellid);
        }
        else
        {
            if (!((Creature*)caster)->HasSpellCooldown(spellid))
                caster->SendPetClearCooldown(spellid);
        }

        spell->finish(false);
        delete spell;
    }
}

void WorldSession::SendPetNameInvalid(uint32 error, const std::string& name, DeclinedName *declinedName)
{
    WorldPacket data(SMSG_PET_NAME_INVALID, 4 + name.size() + 1 + 1);
    data << uint32(error);
    data << name;
    if (declinedName)
    {
        data << uint8(1);
        for (uint32 i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
            data << declinedName->name[i];
    }
    else
        data << uint8(0);
    SendPacket(&data);
}
