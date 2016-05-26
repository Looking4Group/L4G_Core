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
SDName: Stranglethorn_Vale
SD%Complete: 100
SDComment: Quest support: 592
SDCategory: Stranglethorn Vale
EndScriptData */

/* ContentData
mob_yenniku
EndContentData */

#include "precompiled.h"

/*######
## mob_yenniku
######*/

struct mob_yennikuAI : public ScriptedAI
{
    mob_yennikuAI(Creature *c) : ScriptedAI(c)
    {
        bReset = false;
    }

    uint32 Reset_Timer;
    bool bReset;

    void Reset()
    {
        Reset_Timer = 0;
        m_creature->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
    }

    void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        if (caster->GetTypeId() == TYPEID_PLAYER)
        {
                                                            //Yenniku's Release
            if(!bReset && ((Player*)caster)->GetQuestStatus(592) == QUEST_STATUS_INCOMPLETE && spell->Id == 3607)
            {
                m_creature->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STUN);
                m_creature->CombatStop();                   //stop combat
                m_creature->DeleteThreatList();             //unsure of this
                m_creature->setFaction(83);                 //horde generic

                bReset = true;
                Reset_Timer = 60000;
                
            }
        }
        return;
    }

    void EnterCombat(Unit *who) {}

    void UpdateAI(const uint32 diff)
    {
        if (bReset)
        {
            if(Reset_Timer < diff)
            {
                EnterEvadeMode();
                bReset = false;
                m_creature->setFaction(28);                     //troll, bloodscalp
                return;
            }
            else Reset_Timer -= diff;

            if(m_creature->isInCombat() && m_creature->getVictim())
            {
                if(m_creature->getVictim()->GetTypeId() == TYPEID_PLAYER)
                {
                    Unit *victim = m_creature->getVictim();
                    if(((Player*)victim)->GetTeam() == HORDE)
                    {
                        m_creature->CombatStop();
                        m_creature->DeleteThreatList();
                    }
                }
            }
         }

        //Return since we have no target
        if (!UpdateVictim() )
            return;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_mob_yenniku(Creature *_Creature)
{
    return new mob_yennikuAI (_Creature);
}

bool ChooseReward_npc_Riggle_Bassbait(Player *player, Creature *_Creature, const Quest *_Quest){
    if(_Quest->GetQuestId()==8193){
    _Creature->Yell("We have this week Stranglethorn Fishing Extravaganza winner. Congratulations $N",0,player->GetGUID());
    player->Kill(_Creature);
    _Creature->SetVisibility(VISIBILITY_OFF);
    }
    return true;
}

bool ChooseReward_npc_Jang(Player *player, Creature *_Creature, const Quest *_Quest)
{
    if(_Quest->GetQuestId()==8194)
    {
        uint32 lvl = player->getLevel();
        int money;
        if(lvl==70)
            money = 11200;
        else
            money = (pow(lvl,3.43)*0.0053);   // approx. formula according to official data
        player->ModifyMoney(money);
    }
    return true;
}

/*######
##
######*/

void AddSC_stranglethorn_vale()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "mob_yenniku";
    newscript->GetAI = &GetAI_mob_yenniku;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_riggle_bassbait";
    newscript->pQuestRewardedNPC = &ChooseReward_npc_Riggle_Bassbait;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_jang";
    newscript->pQuestRewardedNPC = &ChooseReward_npc_Jang;
    newscript->RegisterSelf();
}

