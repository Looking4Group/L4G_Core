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

#include "precompiled.h"
#include "Spell.h"

bool Spell_intimidating_shout_5246(Unit* pCaster, std::list<Unit*> &unitList, SpellCastTargets const& targets, SpellEntry const *pSpell, uint32 effect_index)
{
    if (effect_index == 0)
        return true;

    if (unitList.empty())
        return true;

    // remove current target from AOE Fear, AOE Speed aura our target gets stun effect provided by 1st effect
    unitList.remove(targets.getUnitTarget());
    return true;
}

// Warrior: Deep Wounds dummyeffect implementation: 12162, 12850, 12868
bool Spell_deep_wounds(Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex)
{
    // handle only dummy efect
    if (pSpell->Effect[effectIndex] != SPELL_EFFECT_DUMMY)
        return false;

    if (!pUnit || pCaster->IsFriendlyTo(pUnit))
        return true;

    Unit* pTarget = pUnit;

    float damage;
    if (pCaster->haveOffhandWeapon() && pCaster->getAttackTimer(BASE_ATTACK) > pCaster->getAttackTimer(OFF_ATTACK))
        damage = (pCaster->GetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE) + pCaster->GetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE))/2;
    else
        damage = (pCaster->GetFloatValue(UNIT_FIELD_MINDAMAGE) + pCaster->GetFloatValue(UNIT_FIELD_MAXDAMAGE))/2;

    switch (pSpell->Id)
    {
        case 12162: damage *= 0.2f; break;
        case 12850: damage *= 0.4f; break;
        case 12868: damage *= 0.6f; break;
        default:
            // not handled spell assigned
            return false;
    };

    int32 deepWoundsDotBasePoints0 = int32(damage / 4);

    if (Aura *deepWounds = pUnit->GetAuraByCasterSpell(12721, pCaster->GetGUID()))
    {
        deepWounds->SetAuraDuration(deepWounds->GetAuraMaxDuration());
        deepWounds->UpdateAuraDuration();

        Aura *bloodFrenzy = pUnit->GetAuraByCasterSpell(30070, pCaster->GetGUID());
        bloodFrenzy ? bloodFrenzy = bloodFrenzy/* do nothing */: bloodFrenzy = pUnit->GetAuraByCasterSpell(30069, pCaster->GetGUID());

        if (bloodFrenzy)
        {
            bloodFrenzy->SetAuraDuration(deepWounds->GetAuraMaxDuration());
            bloodFrenzy->UpdateAuraDuration();
        }
        return true;
    }

    pCaster->CastCustomSpell(pTarget, 12721, &deepWoundsDotBasePoints0, NULL, NULL, true, NULL);
    // we handled our effect, returning true will prevent from processing effect by core :]
    return true;
}

bool Spell_seed_of_corruption_proc(Unit* pCaster, std::list<Unit*> &unitList, SpellCastTargets const& targets, SpellEntry const *pSpell, uint32 effect_index)
{
    if (effect_index != 0)
        return true;

    if (unitList.empty())
        return true;

    unitList.remove(targets.getUnitTarget());
    return true;
}

bool Spell_arcane_torrent(Unit* caster, std::list<Unit*> &, SpellCastTargets const&, SpellEntry const *spellInfo, uint32 effectIndex)
{
    if (effectIndex != 0)
        return true;

    switch (spellInfo->Id)
    {
        case 28730:                                 // Arcane Torrent (Mana)
        case 33390:                                 // Arcane Torrent (mana Wretched Devourer)
        {
            Aura* dummy = caster->GetDummyAura(28734);
            if (dummy)
            {
                int32 bp = (2.17*caster->getLevel() + 9.136) * dummy->GetStackAmount();
                caster->CastCustomSpell(caster, 28733, &bp, NULL, NULL, true);
                caster->RemoveAurasDueToSpell(28734);
            }
            break;
        }

        // Arcane Torrent (Energy)
        case 25046:
        {
            // Search Mana Tap auras on caster
            Aura* dummy = caster->GetDummyAura(28734);
            if (dummy)
            {
                int32 bp = dummy->GetStackAmount() * 10;
                caster->CastCustomSpell(caster, 25048, &bp, NULL, NULL, true);
                caster->RemoveAurasDueToSpell(28734);
            }
            break;
        }
    }
    return true;
}

bool Spell_strong_fetish(Unit *caster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex)
{
    if (caster->GetTypeId() != TYPEID_PLAYER)
        return true;

    if (Player* player = caster->ToPlayer())
    {
        if (player->GetQuestStatus(10544) == QUEST_STATUS_INCOMPLETE)
        {
            switch (player->GetAreaId())
            {
                case 3773:
                    player->SummonCreature(21446, player->GetPositionX()+(rand()%4), player->GetPositionY()+(rand()%4), player->GetPositionZ(), player->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    return true;
                    break;
                case 3776:
                    player->SummonCreature(21452, player->GetPositionX()+(rand()%4), player->GetPositionY()+(rand()%4), player->GetPositionZ(), player->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    return true;
                    break;
            }
        }
        return false;
    }

    return true;
}

bool Spell_coax_marmot(Unit *caster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex)
{
    if (caster->GetTypeId() != TYPEID_PLAYER)
        return true;

    if (Player* player = caster->ToPlayer())
    {
        if (player->GetQuestStatus(10720) == QUEST_STATUS_INCOMPLETE)
        {
            if (Creature* marmot = GetClosestCreatureWithEntry(player, 22189, 15.0f))
                player->CastSpell(marmot, 530, true); // not the correct spell, workaround
        }
        return false;
    }

    return true;
}

enum QuestBearTrap
{
    QUEST_PLAGUED_LANDS = 2118,
    RABID_THISTLE_BEAR = 2164,
    CAPTURED_RABID_THISTLE_BEAR = 11836,
    BEAR_ALIVE = true
};

bool spell_bear_capture_trap(Unit *caster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex){

    if (caster->GetTypeId() != TYPEID_PLAYER)
        return true;

    Player *player = caster->ToPlayer();
    if (!player || !player->IsActiveQuest(QUEST_PLAGUED_LANDS))
        return true;

    float range = 30.0f;
    Creature *bear = GetClosestCreatureWithEntry(player, RABID_THISTLE_BEAR, range, true); 
    if (!bear)
        return true;

    Creature *captBear = player->SummonCreature(CAPTURED_RABID_THISTLE_BEAR,
        bear->GetPositionX(), bear->GetPositionY(), bear->GetPositionZ(), bear->GetAngle(bear->GetPositionX(), bear->GetPositionY()),
        TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 10 * 60 * 1000 /* 10 min */);
    bear->DisappearAndDie();
    player->KilledMonster(CAPTURED_RABID_THISTLE_BEAR, 0);
    captBear->GetMotionMaster()->MoveFollow(player, 0, 0);
    return false;
}

void AddSC_spell_scripts()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "spell_intimidating_shout";
    newscript->pSpellTargetMap = &Spell_intimidating_shout_5246;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "spell_deep_wounds";
    newscript->pSpellHandleEffect = &Spell_deep_wounds;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "spell_seed_of_corruption_proc";
    newscript->pSpellTargetMap = &Spell_seed_of_corruption_proc;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "spell_arcane_torrent";
    newscript->pSpellTargetMap = &Spell_arcane_torrent;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "strong_fetish";
    newscript->pSpellHandleEffect = &Spell_strong_fetish;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "coax_marmot";
    newscript->pSpellHandleEffect = &Spell_coax_marmot;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "spell_bear_capture_trap";
    newscript->pSpellHandleEffect = &spell_bear_capture_trap;
    newscript->RegisterSelf();
}
