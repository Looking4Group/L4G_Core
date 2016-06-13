#include "CharmInfo.h"

#include "WorldPacket.h"
#include "Player.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "Spell.h"
#include "SpellMgr.h"

#include "MovementGenerator.h"

////////////////////////////////////////////////////////////
// Methods of class GlobalCooldownMgr
bool CooldownMgr::HasGlobalCooldown(SpellEntry const* spellInfo) const
{
    CooldownList::const_iterator itr = m_GlobalCooldowns.find(spellInfo->StartRecoveryCategory);
    return itr != m_GlobalCooldowns.end() && itr->second.duration && WorldTimer::getMSTimeDiff(itr->second.cast_time, WorldTimer::getMSTime()) < itr->second.duration;
}

void CooldownMgr::AddGlobalCooldown(SpellEntry const* spellInfo, uint32 gcd)
{
    // HACKFIX: find bugged mechanic
    if (spellInfo->Id == 15473)
        return;

    m_GlobalCooldowns[spellInfo->StartRecoveryCategory] = Cooldown(gcd, WorldTimer::getMSTime());
}

void CooldownMgr::CancelGlobalCooldown(SpellEntry const* spellInfo)
{
    m_GlobalCooldowns[spellInfo->StartRecoveryCategory].duration = 0;
}

bool CooldownMgr::HasSpellCategoryCooldown(SpellEntry const* spellInfo) const
{
    CooldownList::const_iterator itr = m_CategoryCooldowns.find(spellInfo->Category);
    return itr != m_CategoryCooldowns.end() && itr->second.duration && WorldTimer::getMSTimeDiff(itr->second.cast_time, WorldTimer::getMSTime()) < itr->second.duration;
}

void CooldownMgr::AddSpellCategoryCooldown(SpellEntry const* spellInfo, uint32 gcd)
{
    m_CategoryCooldowns[spellInfo->Category] = Cooldown(gcd, WorldTimer::getMSTime());
}

void CooldownMgr::CancelSpellCategoryCooldown(SpellEntry const* spellInfo)
{
    m_CategoryCooldowns[spellInfo->Category].duration = 0;
}

bool CooldownMgr::HasSpellIdCooldown(SpellEntry const* spellInfo) const
{
    CooldownList::const_iterator itr = m_SpellCooldowns.find(spellInfo->Id);
    return itr != m_SpellCooldowns.end() && itr->second.duration && WorldTimer::getMSTimeDiff(itr->second.cast_time, WorldTimer::getMSTime()) < itr->second.duration;
}

void CooldownMgr::AddSpellIdCooldown(SpellEntry const* spellInfo, uint32 gcd)
{
    m_SpellCooldowns[spellInfo->Id] = Cooldown(gcd, WorldTimer::getMSTime());
}

void CooldownMgr::CancelSpellIdCooldown(SpellEntry const* spellInfo)
{
    m_SpellCooldowns[spellInfo->Id].duration = 0;
}

CharmInfo::CharmInfo(Unit* unit)
: m_unit(unit), m_CommandState(COMMAND_FOLLOW), m_petnumber(0), m_barInit(false)
{
    for (int i =0; i<4; ++i)
    {
        m_charmspells[i].spellId = 0;
        m_charmspells[i].active = ACT_DISABLED;
    }

    if (m_unit->GetTypeId() == TYPEID_UNIT)
    {
        m_oldReactState = ((Creature*)m_unit)->GetReactState();
        ((Creature*)m_unit)->SetReactState(REACT_PASSIVE);
    }
}

CharmInfo::~CharmInfo()
{
    if (m_unit->GetTypeId() == TYPEID_UNIT)
    {
        ((Creature*)m_unit)->SetReactState(m_oldReactState);
    }
}

void CharmInfo::InitPetActionBar()
{
    if (m_barInit)
        return;

    // the first 3 SpellOrActions are attack, follow and stay
    for (uint32 i = 0; i < 3; i++)
    {
        PetActionBar[i].Type = ACT_COMMAND;
        PetActionBar[i].SpellOrAction = COMMAND_ATTACK - i;

        PetActionBar[i + 7].Type = ACT_REACTION;
        PetActionBar[i + 7].SpellOrAction = COMMAND_ATTACK - i;
    }
    for (uint32 i=0; i < 4; i++)
    {
        PetActionBar[i + 3].Type = ACT_DISABLED;
        PetActionBar[i + 3].SpellOrAction = 0;
    }
    m_barInit = true;
}

void CharmInfo::InitEmptyActionBar(bool withAttack)
{
    if (m_barInit)
        return;

    for (uint32 x = 0; x < 10; ++x)
    {
        PetActionBar[x].Type = ACT_CAST;
        PetActionBar[x].SpellOrAction = 0;
    }
    if (withAttack)
    {
        PetActionBar[0].Type = ACT_COMMAND;
        PetActionBar[0].SpellOrAction = COMMAND_ATTACK;
    }
    m_barInit = true;
}

void CharmInfo::InitPossessCreateSpells()
{
    uint32 SpiritSpellID[7] =   //Vengeful Spirit's spells
    {
        40325,
        60000,  //to make empty slot
        40157,
        40175,
        40314,
        60000,  //to make empty slot
        40322
    };

    uint32 BlueDrakeID[5] =   //Power of the Blue Flight spells (Kij'jaeden fight)
    {
        45862,
        45856,
        45860,
        60000,  //to make empty slot
        45848
    };

    if (m_unit->GetEntry() == 23109)     //HACK to allow proper spells for Vengeful Spirit
    {
        InitEmptyActionBar(false);

        for (uint32 i = 0; i < 7; ++i)
        {
            uint32 spellid = SpiritSpellID[i];
            AddSpellToActionBar(0, spellid, ACT_CAST);
        }
        return;
    }

    if (m_unit->GetEntry() == 25653)     //HACK to allow proper spells for the Power of the Blue Flight
    {
        InitEmptyActionBar(false);

        for (uint32 i = 0; i < 5; ++i)
        {
            uint32 spellid = BlueDrakeID[i];
            AddSpellToActionBar(0, spellid, ACT_CAST);
        }
        return;
    }

    InitEmptyActionBar();

    if (m_unit->GetTypeId() == TYPEID_UNIT)
    {
        for (uint32 i = 0; i < CREATURE_MAX_SPELLS; ++i)
        {
            uint32 spellid = ((Creature*)m_unit)->m_spells[i];
            if (SpellMgr::IsPassiveSpell(spellid))
                m_unit->CastSpell(m_unit, spellid, true);
            else
            {
                // add spell only if there are cooldown or global cooldown // TODO: find proper solution
                const SpellEntry * tmpSpellEntry = sSpellStore.LookupEntry(spellid);
                if (tmpSpellEntry && (tmpSpellEntry->RecoveryTime || tmpSpellEntry->StartRecoveryTime || tmpSpellEntry->CategoryRecoveryTime))
                    AddSpellToActionBar(0, spellid, ACT_CAST);
            }
        }
    }
}

void CharmInfo::InitCharmCreateSpells()
{
    if (m_unit->GetTypeId() == TYPEID_PLAYER)                //charmed players don't have spells
    {
        InitEmptyActionBar();
        return;
    }

    InitPetActionBar();

    for (uint32 x = 0; x < CREATURE_MAX_SPELLS; ++x)
    {
        uint32 spellId = ((Creature*)m_unit)->m_spells[x];
        m_charmspells[x].spellId = spellId;

        if (!spellId)
            continue;

        if (SpellMgr::IsPassiveSpell(spellId))
        {
            m_unit->CastSpell(m_unit, spellId, true);
            m_charmspells[x].active = ACT_PASSIVE;
        }
        else
        {
            ActiveStates newstate;
            bool onlyselfcast = true;
            SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);

            if (spellInfo)
            {
                for (uint32 i = 0; i < 3; ++i)       //non existent spell will not make any problems as onlyselfcast would be false -> break right away
                {
                    if (spellInfo->EffectImplicitTargetA[i] != TARGET_UNIT_CASTER && spellInfo->EffectImplicitTargetA[i] != 0)
                    {
                        onlyselfcast = false;
                        break;
                    }
                }
            }
            else
                onlyselfcast = false;

            if (onlyselfcast || !SpellMgr::IsPositiveSpell(spellId))   //only self cast and spells versus enemies are autocastable
                newstate = ACT_DISABLED;
            else
                newstate = ACT_CAST;

            // add spell only if there are cooldown or global cooldown // TODO: find proper solution
            if (spellInfo && (spellInfo->RecoveryTime || spellInfo->StartRecoveryTime || spellInfo->CategoryRecoveryTime))
                AddSpellToActionBar(0, spellId, newstate);
        }
    }
}

bool CharmInfo::AddSpellToActionBar(uint32 oldid, uint32 newid, ActiveStates newstate)
{
    for (uint8 i = 0; i < 10; i++)
    {
        if ((PetActionBar[i].Type == ACT_DISABLED || PetActionBar[i].Type == ACT_ENABLED || PetActionBar[i].Type == ACT_CAST) && PetActionBar[i].SpellOrAction == oldid)
        {
            PetActionBar[i].SpellOrAction = newid;
            if (!oldid)
            {
                if (newstate == ACT_DECIDE)
                    PetActionBar[i].Type = ACT_DISABLED;
                else
                    PetActionBar[i].Type = newstate;
            }

            return true;
        }
    }
    return false;
}

void CharmInfo::ToggleCreatureAutocast(uint32 spellid, bool apply)
{
    if (SpellMgr::IsPassiveSpell(spellid))
        return;

    for (uint32 x = 0; x < CREATURE_MAX_SPELLS; ++x)
    {
        if (spellid == m_charmspells[x].spellId)
        {
            m_charmspells[x].active = apply ? ACT_ENABLED : ACT_DISABLED;
        }
    }
}

void CharmInfo::SetPetNumber(uint32 petnumber, bool statwindow)
{
    m_petnumber = petnumber;
    if (statwindow)
        m_unit->SetUInt32Value(UNIT_FIELD_PETNUMBER, m_petnumber);
    else
        m_unit->SetUInt32Value(UNIT_FIELD_PETNUMBER, 0);
}

void CharmInfo::HandleStayCommand()
{
    SetCommandState(COMMAND_STAY);

    m_unit->AttackStop();
    m_unit->InterruptNonMeleeSpells(false);

    m_unit->GetMotionMaster()->MoveIdle();
}

void CharmInfo::HandleFollowCommand()
{
    if (m_unit->hasUnitState(UNIT_STAT_CAN_NOT_REACT) || m_unit->hasUnitState(UNIT_STAT_NOT_MOVE))
        return;

    if (m_unit->GetMotionMaster()->GetCurrentMovementGeneratorType() == FOLLOW_MOTION_TYPE)
        return;

    SetCommandState(COMMAND_FOLLOW);

    m_unit->AttackStop();
    m_unit->InterruptNonMeleeSpells(false);

    m_unit->GetMotionMaster()->MoveFollow(m_unit->GetCharmerOrOwner(), PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
}

void CharmInfo::HandleAttackCommand(uint64 targetGUID)
{
    Unit* pOwner = m_unit->GetCharmerOrOwner();
    // Can't attack if owner is pacified
    if (pOwner->HasAuraType(SPELL_AURA_MOD_PACIFY))
         return;

    //remove invisibility from sukkubus
    if (m_unit->HasAura(7870))
        m_unit->RemoveAurasDueToSpell(7870);

    // only place where pet can be player
    Unit *pTarget = pOwner->GetUnit(targetGUID);
    if (!pTarget)
        return;

    if (!m_unit->canAttack(pTarget))
         return;

    if (Creature* pCharm = m_unit->ToCreature())
    {
        pCharm->AI()->AttackStart(pTarget);

        Pet *pPet = m_unit->ToPet();
        if (pPet && pPet->getPetType() == SUMMON_PET && roll_chance_i(10))
        {
            // 10% chance for special talk
            pPet->SendPetTalk(uint32(PET_TALK_ATTACK));
            return;
        }
    }
    else
    {
        if (m_unit->getVictimGUID() != targetGUID)
             m_unit->AttackStop();

        m_unit->Attack(pTarget, true);
    }

    m_unit->SendPetAIReaction(targetGUID);
}

void CharmInfo::HandleSpellActCommand(uint64 targetGUID, uint32 spellId)
{
    // do not cast unknown spells
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);
    if (!spellInfo)
        return;

    // Global Cooldown, stop cast
    if (spellInfo->StartRecoveryCategory > 0 && GetCooldownMgr().HasGlobalCooldown(spellInfo))
        return;

    for (uint32 i = 0; i < 3;i++)
         if (spellInfo->EffectImplicitTargetA[i] == TARGET_UNIT_AREA_ENEMY_SRC || spellInfo->EffectImplicitTargetA[i] == TARGET_UNIT_AREA_ENEMY_DST || spellInfo->EffectImplicitTargetA[i] == TARGET_DEST_DYNOBJ_ENEMY)
             return;

    // do not cast not learned spells
    if (!m_unit->HasSpell(spellId) || SpellMgr::IsPassiveSpell(spellId))
        return;

    uint64 charmerGUID = m_unit->GetCharmerGUID();

    Spell *spell = new Spell(m_unit, spellInfo, spellId == 33395, charmerGUID);

    Unit* pTarget = m_unit->GetUnit(targetGUID);

    SpellCastResult result = spell->CheckPetCast(pTarget);

    // auto turn to target unless possessed
    if (result == SPELL_FAILED_UNIT_NOT_INFRONT && !m_unit->isPossessed())
    {
        if (Unit *pTarget2 = targetGUID ? pTarget : spell->m_targets.getUnitTarget())
            m_unit->SetFacingToObject(pTarget2);

        result = SPELL_CAST_OK;
    }

    if (result == SPELL_CAST_OK)
    {
        Creature* pCreature = m_unit->ToCreature();

        pCreature->AddCreatureSpellCooldown(spellId);
        if (Pet* pPet = m_unit->ToPet())
        {
            pPet->CheckLearning(spellId);
            if (pPet->getPetType() == SUMMON_PET && roll_chance_i(10))
                pPet->SendPetTalk(uint32(PET_TALK_SPECIAL_SPELL));
            else
                pPet->SendPetAIReaction(charmerGUID);
        }
        else
            m_unit->SendPetAIReaction(charmerGUID);

        Unit *pSpellTarget = spell->m_targets.getUnitTarget();

        if (pSpellTarget && !m_unit->isPossessed() && !m_unit->GetCharmerOrOwner()->IsFriendlyTo(pSpellTarget))
        {
            if (m_unit->getVictim())
                m_unit->AttackStop();

            if (pCreature->IsAIEnabled)
                pCreature->AI()->AttackStart(pSpellTarget);
        }

        //m_unit->GetMotionMaster()->StopMovement();
        //m_unit->GetMotionMaster()->MovementExpired(false);

        spell->prepare(&(spell->m_targets));
    }
    else
    {
        if (m_unit->isPossessed())
        {
            WorldPacket data(SMSG_CAST_FAILED, (4+1+1));
            data << uint32(spellId);
            data << uint8(2);
            data << uint8(result);

            switch (result)
            {
                case SPELL_FAILED_REQUIRES_SPELL_FOCUS:
                    data << uint32(spellInfo->RequiresSpellFocus);
                    break;
                case SPELL_FAILED_REQUIRES_AREA:
                    data << uint32(spellInfo->AreaId);
                    break;
            }

            Player *pPlayer = m_unit->GetCharmer()->ToPlayer();
            pPlayer->SendPacketToSelf(&data);
        }
        else
            m_unit->SendPetCastFail(spellId, result);

        if (!m_unit->ToCreature()->HasSpellCooldown(spellId))
            m_unit->SendPetClearCooldown(spellId);

        spell->finish(false);
        delete spell;
    }
}
