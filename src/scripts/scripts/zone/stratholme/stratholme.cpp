/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Stratholme
SD%Complete: 100
SDComment: Misc mobs for instance. GO-script to apply aura and start event for quest 8945
SDCategory: Stratholme
EndScriptData */

/* ContentData
go_gauntlet_gate
mob_freed_soul
mob_restless_soul
mobs_spectral_ghostly_citizen
EndContentData */

#include "precompiled.h"
#include "def_stratholme.h"

/*######
## go_gauntlet_gate (this is the _first_ of the gauntlet gates, two exist)
######*/

bool GOUse_go_gauntlet_gate(Player *player, GameObject* _GO)
{
    ScriptedInstance* pInstance = (ScriptedInstance*)_GO->GetInstanceData();

    if (!pInstance)
        return false;

    if (pInstance->GetData(TYPE_BARON_RUN) != NOT_STARTED)
        return false;

    if (Group *pGroup = player->GetGroup())
    {
        for(GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
        {
            Player* pGroupie = itr->getSource();
            if (!pGroupie)
                continue;

            if (pGroupie->GetQuestStatus(QUEST_DEAD_MAN_PLEA) == QUEST_STATUS_INCOMPLETE &&
                !pGroupie->HasAura(SPELL_BARON_ULTIMATUM,0) &&
                pGroupie->GetMap() == _GO->GetMap())
                pGroupie->CastSpell(pGroupie,SPELL_BARON_ULTIMATUM,true);
        }
    } else if (player->GetQuestStatus(QUEST_DEAD_MAN_PLEA) == QUEST_STATUS_INCOMPLETE &&
                !player->HasAura(SPELL_BARON_ULTIMATUM,0) &&
                player->GetMap() == _GO->GetMap())
                player->CastSpell(player,SPELL_BARON_ULTIMATUM,true);

    pInstance->SetData(TYPE_BARON_RUN,IN_PROGRESS);
    return false;
}

/*######
## mob_freed_soul
######*/

//Possibly more of these quotes around.
#define SAY_ZAPPED0 "Thanks to Egan"
#define SAY_ZAPPED1 "Rivendare must die"
#define SAY_ZAPPED2 "Who you gonna call?"
#define SAY_ZAPPED3 "Don't cross those beams!"

struct mob_freed_soulAI : public ScriptedAI
{
    mob_freed_soulAI(Creature *c) : ScriptedAI(c) {}

    void Reset()
    {
        switch (rand()%4)
        {
            case 0: DoSay(SAY_ZAPPED0,LANG_UNIVERSAL,NULL); break;
            case 1: DoSay(SAY_ZAPPED1,LANG_UNIVERSAL,NULL); break;
            case 2: DoSay(SAY_ZAPPED2,LANG_UNIVERSAL,NULL); break;
            case 3: DoSay(SAY_ZAPPED3,LANG_UNIVERSAL,NULL); break;
        }
    }
};

CreatureAI* GetAI_mob_freed_soul(Creature *_Creature)
{
    return new mob_freed_soulAI (_Creature);
}

/*######
## mob_restless_soul
######*/

#define SPELL_EGAN_BLASTER  17368
#define SPELL_SOUL_FREED    17370
#define QUEST_RESTLESS_SOUL 5282
#define ENTRY_RESTLESS      11122
#define ENTRY_FREED         11136

struct mob_restless_soulAI : public ScriptedAI
{
    mob_restless_soulAI(Creature *c) : ScriptedAI(c) {}

    uint64 Tagger;
    uint32 Die_Timer;
    bool Tagged;

    void Reset()
    {
        Tagger = 0;
        Die_Timer = 5000;
        Tagged = false;
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (caster->GetTypeId() == TYPEID_PLAYER)
        {
            if (!Tagged && spell->Id == SPELL_EGAN_BLASTER && ((Player*)caster)->GetQuestStatus(QUEST_RESTLESS_SOUL) == QUEST_STATUS_INCOMPLETE)
            {
                Tagged = true;
                Tagger = caster->GetGUID();
            }
        }
    }

    void JustSummoned(Creature *summoned)
    {
        summoned->CastSpell(summoned,SPELL_SOUL_FREED,false);
    }

    void JustDied(Unit* Killer)
    {
        if (Tagged)
            DoSpawnCreature(ENTRY_FREED, 0, 0, 0, 0, TEMPSUMMON_TIMED_DESPAWN, 300000);
    }

    void UpdateAI(const uint32 diff)
    {
        if (Tagged)
        {
            if (Die_Timer < diff)
            {
                if (Unit* temp = Unit::GetUnit(*m_creature,Tagger))
                    temp->DealDamage(m_creature, m_creature->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            }else Die_Timer -= diff;
        }
    }
};

CreatureAI* GetAI_mob_restless_soul(Creature *_Creature)
{
    return new mob_restless_soulAI (_Creature);
}

/*######
## mobs_spectral_ghostly_citizen
######*/

#define SPELL_HAUNTING_PHANTOM  16336

struct mobs_spectral_ghostly_citizenAI : public ScriptedAI
{
    mobs_spectral_ghostly_citizenAI(Creature *c) : ScriptedAI(c) {}

    uint32 Die_Timer;
    bool Tagged;

    void Reset()
    {
        Die_Timer = 5000;
        Tagged = false;
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (!Tagged && spell->Id == SPELL_EGAN_BLASTER)
            Tagged = true;
    }

    void JustDied(Unit* Killer)
    {
        if (Tagged)
        {
            for(uint32 i = 1; i <= 4; i++)
            {
                float x,y,z;
                 m_creature->GetRandomPoint(m_creature->GetPositionX(),m_creature->GetPositionY(),m_creature->GetPositionZ(),20.0f,x,y,z);

                 //100%, 50%, 33%, 25% chance to spawn
                 uint32 j = urand(1,i);
                 if (j==1)
                     m_creature->SummonCreature(ENTRY_RESTLESS,x,y,z,0,TEMPSUMMON_CORPSE_DESPAWN,600000);
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (Tagged)
        {
            if (Die_Timer < diff)
            {
                m_creature->DealDamage(m_creature, m_creature->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            }else Die_Timer -= diff;
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mobs_spectral_ghostly_citizen(Creature *_Creature)
{
    return new mobs_spectral_ghostly_citizenAI (_Creature);
}

bool ReciveEmote_mobs_spectral_ghostly_citizen(Player *player, Creature *_Creature, uint32 emote)
{
    switch(emote)
    {
        case TEXTEMOTE_DANCE:
            ((mobs_spectral_ghostly_citizenAI*)_Creature->AI())->EnterEvadeMode();
            break;
        case TEXTEMOTE_RUDE:
            //Should instead cast spell, kicking player back. Spell not found.
            if (_Creature->IsWithinDistInMap(player, 5))
                _Creature->HandleEmoteCommand(EMOTE_ONESHOT_RUDE);
            else
                _Creature->HandleEmoteCommand(EMOTE_ONESHOT_RUDE);
            break;
        case TEXTEMOTE_WAVE:
            _Creature->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
            break;
        case TEXTEMOTE_BOW:
            _Creature->HandleEmoteCommand(EMOTE_ONESHOT_BOW);
            break;
        case TEXTEMOTE_KISS:
            _Creature->HandleEmoteCommand(EMOTE_ONESHOT_FLEX);
            break;
    }

    return true;
}

void AddSC_stratholme()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "go_gauntlet_gate";
    newscript->pGOUse = &GOUse_go_gauntlet_gate;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_freed_soul";
    newscript->GetAI = &GetAI_mob_freed_soul;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_restless_soul";
    newscript->GetAI = &GetAI_mob_restless_soul;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mobs_spectral_ghostly_citizen";
    newscript->GetAI = &GetAI_mobs_spectral_ghostly_citizen;
    newscript->pReceiveEmote = &ReciveEmote_mobs_spectral_ghostly_citizen;
    newscript->RegisterSelf();
}

