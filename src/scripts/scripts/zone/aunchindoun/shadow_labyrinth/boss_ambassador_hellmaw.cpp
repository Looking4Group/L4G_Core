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
SDName: Boss_Ambassador_Hellmaw
SD%Complete: 99
SDComment: It appears that it's done now.
SDCategory: Auchindoun, Shadow Labyrinth
EndScriptData */

#include "precompiled.h"
#include "def_shadow_labyrinth.h"

#define SAY_INTRO       -1555000

#define SAY_AGGRO1      -1555001
#define SAY_AGGRO2      -1555002
#define SAY_AGGRO3      -1555003

#define SAY_HELP        -1555004

#define SAY_SLAY1       -1555005
#define SAY_SLAY2       -1555006

#define SAY_DEATH       -1555007

#define SPELL_BANISH            42354
#define SPELL_CORROSIVE_ACID    33551
#define SPELL_FEAR              33547
#define SPELL_ENRAGE            26662

#define PATH_PATROL              2100
#define PATH_FINAL               2101

struct boss_ambassador_hellmawAI : public ScriptedAI
{
    boss_ambassador_hellmawAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        HeroicMode = me->GetMap()->IsHeroic();
    }

    ScriptedInstance* pInstance;
    bool HeroicMode;

    uint32 EventCheck_Timer;
    uint32 Banish_Timer;
    uint32 CorrosiveAcid_Timer;
    uint32 Fear_Timer;
    uint32 Enrage_Timer;
    uint32 OnPath_Delay;
    bool Intro;
    bool IsBanished;
    bool patrol;

    void Reset()
    {
        EventCheck_Timer = 5000;
        Banish_Timer = 0;
        CorrosiveAcid_Timer = 25000;
        Fear_Timer = 40000;
        Enrage_Timer = 180000;
        Intro = false;
        IsBanished = false;

        if (pInstance)
        {
            if (pInstance->GetData(TYPE_HELLMAW) ==  NOT_STARTED)
            {
                DoCast(me,SPELL_BANISH, true);
                IsBanished = true;
            }
        }
    }

    void DoIntro()
    {
        DoScriptText(SAY_INTRO, me);

        if (me->HasAura(SPELL_BANISH,0))
            me->RemoveAurasDueToSpell(SPELL_BANISH);

        IsBanished = false;
        Intro = true;

        if (pInstance)
            pInstance->SetData(TYPE_HELLMAW, IN_PROGRESS);
    }

    void EnterCombat(Unit *who)
    {
        if(IsBanished)
            EnterEvadeMode();

        me->GetMotionMaster()->Clear();
        DoScriptText(RAND(SAY_AGGRO1, SAY_AGGRO2, SAY_AGGRO3), me);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2), me);
    }

    void JustDied(Unit *victim)
    {
        DoScriptText(SAY_DEATH, me);

        if (pInstance)
            pInstance->SetData(TYPE_HELLMAW, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!pInstance)
            return;

        if(IsBanished)
        {
             if(Banish_Timer < diff)
             {
                 DoCast(me,SPELL_BANISH, true);
                 Banish_Timer = 40000;
             }
             else
                 Banish_Timer -= diff;
        }

        if (!Intro)
        {
            if (EventCheck_Timer < diff)
            {
                if(pInstance->GetData(TYPE_RITUALIST) == DONE)
                {
                        OnPath_Delay = 0;
                        DoIntro();
                }
                EventCheck_Timer = 5000;
            }
            else
                EventCheck_Timer -= diff;
        }

        if (!me->isInCombat() && !IsBanished && !OnPath_Delay)
        {
            me->GetMotionMaster()->MovePath(PATH_PATROL, false);
            OnPath_Delay = 55000;
            patrol = false;
        }

        if (!me->isInCombat() && !patrol && OnPath_Delay < diff)
        {
            me->GetMotionMaster()->MovePath(PATH_FINAL, true);
            patrol = true;
        }
        else
            OnPath_Delay -= diff;

        if (!UpdateVictim() )
            return;

        if (CorrosiveAcid_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_CORROSIVE_ACID);
            CorrosiveAcid_Timer = 25000;
        }
        else
            CorrosiveAcid_Timer -= diff;

        if (Fear_Timer < diff)
        {
            DoCast(me,SPELL_FEAR);
            Fear_Timer = 25000;
        }
        else
            Fear_Timer -= diff;

        if (HeroicMode)
        {
            if (Enrage_Timer < diff)
            {
                DoCast(me,SPELL_ENRAGE);
                Enrage_Timer = 5*MINUTE*1000;
            }
            else
                Enrage_Timer -= diff;
        }

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_ambassador_hellmaw(Creature *_Creature)
{
    return new boss_ambassador_hellmawAI (_Creature);
}

void AddSC_boss_ambassador_hellmaw()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_ambassador_hellmaw";
    newscript->GetAI = &GetAI_boss_ambassador_hellmaw;
    newscript->RegisterSelf();
}

