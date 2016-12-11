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
SDName: Boss_Warlord_Najentus
SD%Complete: 95
SDComment:
SDCategory: Black Temple
EndScriptData */

#include "precompiled.h"
#include "def_black_temple.h"

enum Quotes
{
    YELL_AGGRO    = -1564000, // You will die in the name of Lady Vashj!
    YELL_NEEDLE1  = -1564001, // Stick around...
    YELL_NEEDLE2  = -1564002, // I'll deal with you later.
    YELL_SLAY1    = -1564003, // Your success was short-lived!
    YELL_SLAY2    = -1564004, // Time for you to go.
    YELL_SPECIAL1 = -1564005, // Be'lanen dalorei!
    YELL_SPECIAL2 = -1564006, // Blood... will... flow!
    YELL_ENRAGE1  = -1564007, // Bal, lamer zhita!
    YELL_ENRAGE2  = -1564008, // My patience has run out! Die! Die!
    YELL_DEATH    = -1564009  // Lord Illidan will... crush you!
};

enum Spells
{
    SPELL_NEEDLE_SPINE_TARGETTING = 39992,
    SPELL_TIDAL_BURST             = 39878,
    SPELL_TIDAL_SHIELD            = 39872,
    SPELL_IMPALING_SPINE          = 39837,
    SPELL_CREATE_NAJENTUS_SPINE   = 39956,
    SPELL_HURL_SPINE              = 39948,
    SPELL_BERSERK                 = 45078
};

enum GameObjects
{
    GOBJECT_SPINE = 185584
};

struct boss_najentusAI : public ScriptedAI
{
    boss_najentusAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(worldLocation);
    }

    ScriptedInstance* pInstance;

    uint32 EnrageTimer;
    uint32 NeedleSpineTimer;
    uint32 ImpalingSpineTimer;
    uint32 CheckTimer;

    uint8 ImpalingSpineCount;

    WorldLocation worldLocation;

    // Key Value: GameObject (spine) GUID / Mapped Value: Player (with spine) GUID
    std::map<uint64, uint64> SpinePlayerMap;

    void Reset()
    {
        EnrageTimer        = 480000; // 8 minute enrage timer
        ImpalingSpineTimer = 20000;
        NeedleSpineTimer   = urand(2000, 4000);
        CheckTimer         = 3000;

        ImpalingSpineCount = 0;

        std::map<uint64, uint64>::iterator spineTarget = SpinePlayerMap.begin();
        for(;spineTarget != SpinePlayerMap.end(); ++spineTarget)
        {
            if (GameObject *go = GameObject::GetGameObject(*m_creature, spineTarget->first))
            {
                go->SetLootState(GO_JUST_DEACTIVATED);
                go->SetRespawnTime(0);
            }
        }

        SpinePlayerMap.clear();
        DestroyItemSpine();

        if (pInstance)
        {
            pInstance->SetData(EVENT_HIGHWARLORDNAJENTUS, NOT_STARTED);
        }
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(YELL_SLAY1, YELL_SLAY2), m_creature);
    }

    void JustDied(Unit *victim)
    {
        if (pInstance)
        {
            pInstance->SetData(EVENT_HIGHWARLORDNAJENTUS, DONE);
        }

        DestroyItemSpine();

        DoScriptText(YELL_DEATH, m_creature);
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (spell->Id == SPELL_HURL_SPINE && m_creature->HasAura(SPELL_TIDAL_SHIELD, 0))
        {
            DoScriptText(RAND(YELL_SPECIAL1, YELL_SPECIAL2), m_creature);
            m_creature->RemoveAurasDueToSpell(SPELL_TIDAL_SHIELD);
            m_creature->CastSpell(m_creature, SPELL_TIDAL_BURST, true);
        }
    }

    void EnterCombat(Unit *who)
    {
        if (pInstance)
        {
            pInstance->SetData(EVENT_HIGHWARLORDNAJENTUS, IN_PROGRESS);
        }

        DoScriptText(YELL_AGGRO, m_creature);
        DoZoneInCombat();
        DestroyItemSpine();
    }

    void DestroyItemSpine()
    {
        Map *pMap = m_creature->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();

        if (PlayerList.isEmpty())
        {
            return;
        }

        for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
        {
            Player *player = i->getSource();
            if (player && player->HasItemCount(32408, 1))
            {
                player->DestroyItemCount(32408, 5, true); // Even if the player only has 1 spine, attempt to remove 5 (the maximum stack size)
            }
        }
    }

    bool RemoveImpalingSpine(uint64 go_guid)
    {
        if (SpinePlayerMap.empty())
        {
            return false;
        }

        std::map<uint64, uint64>::iterator spineTarget = SpinePlayerMap.find(go_guid);
        if (spineTarget == SpinePlayerMap.end())
        {
            return false;
        }

        Unit *target = Unit::GetUnit(*m_creature, spineTarget->second);
        if (target && target->HasAura(SPELL_IMPALING_SPINE, 1))
        {
            target->RemoveAurasDueToSpell(SPELL_IMPALING_SPINE);
        }

        SpinePlayerMap.erase(spineTarget);

        return true;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
        {
            return;
        }

        if (CheckTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&worldLocation, 105))
            {
                EnterEvadeMode();
            }
            else
            {
                DoZoneInCombat();
            }
            CheckTimer = 3000;
        }
        else
        {
            CheckTimer -= diff;
        }

        if (EnrageTimer < diff)
        {
            DoScriptText(RAND(YELL_ENRAGE1, YELL_ENRAGE2), m_creature);
            m_creature->CastSpell(m_creature, SPELL_BERSERK, true);
            EnrageTimer = 480000;
        }
        else
        {
            EnrageTimer -= diff;
        }

        if (NeedleSpineTimer < diff)
        {
            m_creature->CastSpell(m_creature, SPELL_NEEDLE_SPINE_TARGETTING, true);
            NeedleSpineTimer = urand(2000, 4000);
        }
        else
        {
            NeedleSpineTimer -= diff;
        }

        if (ImpalingSpineTimer < diff)
        {
            // If the count less than 2 then cast impaling spine
            // If the count is 2 or more then cast tidal shield (and reset the count)
            // Spine -> spine -> shield and repeat
            if (ImpalingSpineCount < 2)
            {
                ImpalingSpineCount++;

                Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 150, true, m_creature->getVictimGUID());

                if (!target)
                {
                    target = m_creature->getVictim();
                }

                if (target)
                {
                    m_creature->CastSpell(target, SPELL_IMPALING_SPINE, true);

                    // Target must summon the spine, otherwise it is not interactable by players
                    GameObject *_go = target->SummonGameObject(GOBJECT_SPINE, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), m_creature->GetOrientation(), 0, 0, 0, 0, 30);

                    if(_go)
                    {
                        std::pair<uint64, uint64> spineTarget(_go->GetGUID(), target->GetGUID());
                        SpinePlayerMap.insert(spineTarget);
                    }

                    DoScriptText(RAND(YELL_NEEDLE1, YELL_NEEDLE2), m_creature);
                }
            }
            else
            {
                m_creature->CastSpell(m_creature, SPELL_TIDAL_SHIELD, true);

                // Reset the count
                ImpalingSpineCount = 0;

                // Stop throwing needle spines for 10 seconds after shield activation
                NeedleSpineTimer = 10000;
            }
            ImpalingSpineTimer = 20000;
        }
        else
        {
            ImpalingSpineTimer -= diff;
        }

        DoMeleeAttackIfReady();
    }
};

bool GOUse_go_najentus_spine(Player *player, GameObject* _GO)
{
    if(ScriptedInstance* pInstance = (ScriptedInstance*)_GO->GetInstanceData())
    {
        if(Creature* Najentus = Unit::GetCreature(*_GO, pInstance->GetData64(DATA_HIGHWARLORDNAJENTUS)))
        {
            if(((boss_najentusAI*)Najentus->AI())->RemoveImpalingSpine(_GO->GetGUID()))
            {
                player->CastSpell(player, SPELL_CREATE_NAJENTUS_SPINE, true);
                _GO->SetLootState(GO_JUST_DEACTIVATED);
                _GO->SetRespawnTime(0);
            }
        }
    }
    return true;
}

CreatureAI* GetAI_boss_najentus(Creature *_Creature)
{
    return new boss_najentusAI (_Creature);
}

void AddSC_boss_najentus()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_najentus";
    newscript->GetAI = &GetAI_boss_najentus;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_najentus_spine";
    newscript->pGOUse = &GOUse_go_najentus_spine;
    newscript->RegisterSelf();
}