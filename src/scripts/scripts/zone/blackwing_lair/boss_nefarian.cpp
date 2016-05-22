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
SDName: Boss_Nefarian
SD%Complete: 80
SDComment: Some issues with class calls effecting more than one class, his throne is actually a portal -_-, should be changed
SDCategory: Blackwing Lair
EndScriptData */

#include "precompiled.h"
#include "def_blackwing_lair.h"

#define SAY_AGGRO               -1469007
#define SAY_XHEALTH             -1469008
#define SAY_SHADOWFLAME         -1469009
#define SAY_RAISE_SKELETONS     -1469010
#define SAY_SLAY                -1469011
#define SAY_DEATH               -1469012

#define SAY_MAGE                -1469013
#define SAY_WARRIOR             -1469014
#define SAY_DRUID               -1469015
#define SAY_PRIEST              -1469016
#define SAY_PALADIN             -1469017
#define SAY_SHAMAN              -1469018
#define SAY_WARLOCK             -1469019
#define SAY_HUNTER              -1469020
#define SAY_ROGUE               -1469021

#define SPELL_SHADOWFLAME_INITIAL   22972
#define SPELL_SHADOWFLAME           22539
#define SPELL_BELLOWINGROAR         22686
#define SPELL_VEILOFSHADOW          7068
#define SPELL_CLEAVE                20691
#define SPELL_TAILLASH              23364
#define SPELL_BONECONTRUST          23363                   //23362, 23361

#define SPELL_MAGE                  23410                   //wild magic
#define SPELL_WARRIOR               23397                   //beserk
#define SPELL_DRUID                 23398                   // cat form
#define SPELL_PRIEST                23401                   // corrupted healing
#define SPELL_PALADIN               23418                   //syphon blessing
#define SPELL_SHAMAN                23425                   //totems
#define SPELL_WARLOCK               23427                   //infernals
#define SPELL_HUNTER                23436                   //bow broke
#define SPELL_ROGUE                 23414                   //Paralise

struct boss_nefarianAI : public ScriptedAI
{
    boss_nefarianAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (ScriptedInstance*)c->GetInstanceData();
    }

    ScriptedInstance * pInstance;
    uint32 ShadowFlame_Timer;
    uint32 BellowingRoar_Timer;
    uint32 VeilOfShadow_Timer;
    uint32 Cleave_Timer;
    uint32 TailLash_Timer;
    uint32 ClassCall_Timer;
    bool Phase3;

    uint32 DespawnTimer;

    void Reset()
    {
        ShadowFlame_Timer = 12000;                          //These times are probably wrong
        BellowingRoar_Timer = 30000;
        VeilOfShadow_Timer = 15000;
        Cleave_Timer = 7000;
        TailLash_Timer = 10000;
        ClassCall_Timer = 35000;                            //35-40 seconds
        Phase3 = false;

        DespawnTimer = 5000;

        if (pInstance && pInstance->GetData(DATA_NEFARIAN_EVENT) != DONE)
            pInstance->SetData(DATA_NEFARIAN_EVENT, NOT_STARTED);
    }

    void KilledUnit(Unit* Victim)
    {
        if (rand()%5)
            return;

        DoScriptText(SAY_SLAY, m_creature, Victim);
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, m_creature);

        if (pInstance)
            pInstance->SetData(DATA_NEFARIAN_EVENT, DONE);
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_XHEALTH, SAY_AGGRO, SAY_SHADOWFLAME), m_creature);

        DoCast(who,SPELL_SHADOWFLAME_INITIAL);
        DoZoneInCombat();

        if (pInstance)
            pInstance->SetData(DATA_NEFARIAN_EVENT, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        if(DespawnTimer < diff)
        {
            if(!UpdateVictim())
            {
                m_creature->SetHealth(0);
                m_creature->setDeathState(JUST_DIED);
                m_creature->RemoveCorpse();
            }
            DespawnTimer = 5000;
        }
        else
            DespawnTimer -= diff;

        if (!UpdateVictim() )
            return;

        //ShadowFlame_Timer
        if (ShadowFlame_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_SHADOWFLAME);
            ShadowFlame_Timer = 12000;
        }
        else
            ShadowFlame_Timer -= diff;

        //BellowingRoar_Timer
        if (BellowingRoar_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_BELLOWINGROAR);
            BellowingRoar_Timer = 30000;
        }
        else
            BellowingRoar_Timer -= diff;

        //VeilOfShadow_Timer
        if (VeilOfShadow_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_VEILOFSHADOW);
            VeilOfShadow_Timer = 15000;
        }
        else
            VeilOfShadow_Timer -= diff;

        //Cleave_Timer
        if (Cleave_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_CLEAVE);
            Cleave_Timer = 7000;
        }
        else
            Cleave_Timer -= diff;

        //TailLash_Timer
        if (TailLash_Timer < diff)
        {
            //Cast NYI since we need a better check for behind target
            //DoCast(m_creature->getVictim(),SPELL_TAILLASH);

            TailLash_Timer = 10000;
        }
        else
            TailLash_Timer -= diff;

        //ClassCall_Timer
        if (ClassCall_Timer < diff)
        {
            //Cast a random class call
            //On official it is based on what classes are currently on the hostil list
            //but we can't do that yet so just randomly call one

            switch (rand()%9)
            {
                case 0:
                    DoScriptText(SAY_MAGE, m_creature);
                    DoCast(m_creature,SPELL_MAGE);
                    break;
                case 1:
                    DoScriptText(SAY_WARRIOR, m_creature);
                    DoCast(m_creature,SPELL_WARRIOR);
                    break;
                case 2:
                    DoScriptText(SAY_DRUID, m_creature);
                    DoCast(m_creature,SPELL_DRUID);
                    break;
                case 3:
                    DoScriptText(SAY_PRIEST, m_creature);
                    DoCast(m_creature,SPELL_PRIEST);
                    break;
                case 4:
                    DoScriptText(SAY_PALADIN, m_creature);
                    DoCast(m_creature,SPELL_PALADIN);
                    break;
                case 5:
                    DoScriptText(SAY_SHAMAN, m_creature);
                    DoCast(m_creature,SPELL_SHAMAN);
                    break;
                case 6:
                    DoScriptText(SAY_WARLOCK, m_creature);
                    DoCast(m_creature,SPELL_WARLOCK);
                    break;
                case 7:
                    DoScriptText(SAY_HUNTER, m_creature);
                    DoCast(m_creature,SPELL_HUNTER);
                    break;
                case 8:
                    DoScriptText(SAY_ROGUE, m_creature);
                    DoCast(m_creature,SPELL_ROGUE);
                    break;
            }

            ClassCall_Timer = 35000 + (rand() % 5000);
        }
        else
            ClassCall_Timer -= diff;

        //Phase3 begins when we are below X health
        if (!Phase3 && (m_creature->GetHealth()*100 / m_creature->GetMaxHealth()) < 20)
        {
            Phase3 = true;
            DoScriptText(SAY_RAISE_SKELETONS, m_creature);
        }

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_nefarian(Creature *_Creature)
{
    return new boss_nefarianAI (_Creature);
}

void AddSC_boss_nefarian()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_nefarian";
    newscript->GetAI = &GetAI_boss_nefarian;
    newscript->RegisterSelf();
}

