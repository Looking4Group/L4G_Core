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

#define SAY_AGGRO                       -1564000
#define SAY_NEEDLE1                     -1564001
#define SAY_NEEDLE2                     -1564002
#define SAY_SLAY1                       -1564003
#define SAY_SLAY2                       -1564004
#define SAY_SPECIAL1                    -1564005
#define SAY_SPECIAL2                    -1564006
#define SAY_ENRAGE1                     -1564007            //is this text actually in use?
#define SAY_ENRAGE2                     -1564008
#define SAY_DEATH                       -1564009

//Spells
#define SPELL_NEEDLE_SPINE             39835
#define SPELL_TIDAL_BURST              39878
#define SPELL_TIDAL_SHIELD             39872
#define SPELL_IMPALING_SPINE           39837
#define SPELL_CREATE_NAJENTUS_SPINE    39956
#define SPELL_HURL_SPINE               39948
#define SPELL_BERSERK                  45078

#define GOBJECT_SPINE                  185584

struct boss_najentusAI : public ScriptedAI
{
    boss_najentusAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);
    }

    ScriptedInstance* pInstance;

    uint32 NeedleSpineTimer;
    uint32 EnrageTimer;
    uint32 SpecialYellTimer;
    uint32 TidalShieldTimer;
    uint32 ImpalingSpineTimer;
    uint32 CheckTimer;

    uint8 plToNeedle;

    bool checkAura;

    WorldLocation wLoc;

    //       go_guid, target_guid
    std::map<uint64 , uint64> SpineTargetMap;

    void Reset()
    {
        EnrageTimer = 480000;
        SpecialYellTimer = 45000 + (rand()%76)*1000;

        ImpalingSpineTimer = 20000;
        NeedleSpineTimer   = 2000 + rand()%2000;
        TidalShieldTimer   = 60000;

        CheckTimer = 3000;

        plToNeedle = 3;
        checkAura = false;

        std::map<uint64, uint64>::iterator spineTarget = SpineTargetMap.begin();
        for(;spineTarget != SpineTargetMap.end(); ++spineTarget)
        {
            if(GameObject *go = GameObject::GetGameObject(*m_creature, spineTarget->first))
            {
                go->SetLootState(GO_JUST_DEACTIVATED);
                go->SetRespawnTime(0);
            }
        }

        SpineTargetMap.clear();
        DestroySpine();

        if(pInstance)
            pInstance->SetData(EVENT_HIGHWARLORDNAJENTUS, NOT_STARTED);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2), m_creature);
    }

    void JustDied(Unit *victim)
    {
        if(pInstance)
            pInstance->SetData(EVENT_HIGHWARLORDNAJENTUS, DONE);

        DestroySpine();

        DoScriptText(SAY_DEATH, m_creature);
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if(spell->Id == SPELL_HURL_SPINE && m_creature->HasAura(SPELL_TIDAL_SHIELD, 0))
        {
            m_creature->RemoveAurasDueToSpell(SPELL_TIDAL_SHIELD);
            m_creature->CastSpell(m_creature, SPELL_TIDAL_BURST, true);
        }
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance)
            pInstance->SetData(EVENT_HIGHWARLORDNAJENTUS, IN_PROGRESS);

        DoScriptText(SAY_AGGRO, m_creature);
        DoZoneInCombat();
        DestroySpine();
    }

    void DestroySpine()
    {
        Map *pMap = m_creature->GetMap();
        Map::PlayerList const &PlayerList = pMap->GetPlayers();

        if(PlayerList.isEmpty())
            return;

        for(Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
        {
            Player *plr = i->getSource();
            if(plr && plr->HasItemCount(32408,1))
                plr->DestroyItemCount(32408,1, true);
        }
    }

    bool RemoveImpalingSpine(uint64 go_guid)
    {
        if(SpineTargetMap.empty())
            return false;

        std::map<uint64, uint64>::iterator spineTarget = SpineTargetMap.find(go_guid);
        if(spineTarget == SpineTargetMap.end())
            return false;

        Unit *target = Unit::GetUnit(*m_creature, spineTarget->second);
        if(target && target->HasAura(SPELL_IMPALING_SPINE, 1))
            target->RemoveAurasDueToSpell(SPELL_IMPALING_SPINE);
        SpineTargetMap.erase(spineTarget);
        return true;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (CheckTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(&wLoc, 105))
                EnterEvadeMode();
            else
                DoZoneInCombat();
            CheckTimer = 3000;
        }
        else
            CheckTimer -= diff;

        if (checkAura)
        {
            if(m_creature->HasAura(SPELL_TIDAL_SHIELD, 0))
                NeedleSpineTimer = 10000;
            else
                checkAura = false;
        }

        if(TidalShieldTimer < diff)
        {
            m_creature->CastSpell(m_creature, SPELL_TIDAL_SHIELD, true);

            ImpalingSpineTimer = 20000;

            TidalShieldTimer = 60000;
            checkAura = true;
        }
        else
            TidalShieldTimer -= diff;

        if(EnrageTimer < diff)
        {
            DoScriptText(SAY_ENRAGE2, m_creature);
            m_creature->CastSpell(m_creature, SPELL_BERSERK, true);
            EnrageTimer = 600000;
        }
        else
            EnrageTimer -= diff;

        if(NeedleSpineTimer < diff)
        {
            m_creature->CastSpell(m_creature, 39992u, true);
            NeedleSpineTimer = 2000 + rand()%2000;
        }
        else
            NeedleSpineTimer -= diff;

        if(SpecialYellTimer < diff)
        {
            DoScriptText(RAND(SAY_SPECIAL1, SAY_SPECIAL2), m_creature);

            SpecialYellTimer = 25000 + (rand()%76)*1000;
        }
        else
            SpecialYellTimer -= diff;

        if(ImpalingSpineTimer < diff)
        {
            Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 150, true, m_creature->getVictimGUID());

            if(!target)
                target = m_creature->getVictim();

            if(target)
            {
                m_creature->CastSpell(target, SPELL_IMPALING_SPINE, true);

                //must let target summon, otherwise you cannot click the spine
                GameObject *_go = target->SummonGameObject(GOBJECT_SPINE, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), m_creature->GetOrientation(), 0, 0, 0, 0, 30);

                if(_go)
                {
                    std::pair<uint64, uint64> spineTarget(_go->GetGUID(), target->GetGUID());
                    SpineTargetMap.insert(spineTarget);
                }

                DoScriptText(RAND(SAY_NEEDLE1, SAY_NEEDLE2), m_creature);
            }
            ImpalingSpineTimer = 21000;
        }
        else
            ImpalingSpineTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

bool GOUse_go_najentus_spine(Player *player, GameObject* _GO)
{
    if(ScriptedInstance* pInstance = (ScriptedInstance*)_GO->GetInstanceData())
        if(Creature* Najentus = Unit::GetCreature(*_GO, pInstance->GetData64(DATA_HIGHWARLORDNAJENTUS)))
            if(((boss_najentusAI*)Najentus->AI())->RemoveImpalingSpine(_GO->GetGUID()))
            {
                player->CastSpell(player, SPELL_CREATE_NAJENTUS_SPINE, true);
                _GO->SetLootState(GO_JUST_DEACTIVATED);
                _GO->SetRespawnTime(0);
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

