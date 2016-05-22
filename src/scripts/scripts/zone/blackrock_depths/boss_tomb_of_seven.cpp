/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Boss_Tomb_Of_Seven
SD%Complete: 95
SDComment:
SDCategory: Blackrock Depths
EndScriptData */

#include "precompiled.h"
#include "def_blackrock_depths.h"

#define FACTION_NEUTRAL             734
#define FACTION_HOSTILE             754

#define SPELL_SUNDERARMOR           24317
#define SPELL_SHIELDBLOCK           12169
#define SPELL_STRIKE                15580

struct boss_angerrelAI : public ScriptedAI
{
    boss_angerrelAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 SunderArmor_Timer;
    uint32 ShieldBlock_Timer;
    uint32 Strike_Timer;

    void Reset()
    {
        SunderArmor_Timer = 8000;
        ShieldBlock_Timer = 15000;
        Strike_Timer = 12000;

        me->setFaction(FACTION_NEUTRAL);
    }

    void EnterCombat(Unit *who)
    {
    }

    void EnterEvadeMode()
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit *slayer)
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, SPECIAL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //SunderArmor_Timer
        if (SunderArmor_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_SUNDERARMOR);
            SunderArmor_Timer = 28000;
        }
        else
            SunderArmor_Timer -= diff;

        //ShieldBlock_Timer
        if (ShieldBlock_Timer < diff)
        {
            DoCast(me,SPELL_SHIELDBLOCK);
            ShieldBlock_Timer = 25000;
        }
        else
            ShieldBlock_Timer -= diff;

        //Strike_Timer
        if (Strike_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_STRIKE);
            Strike_Timer = 10000;
        }
        else
            Strike_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_angerrel(Creature *creature)
{
    return new boss_angerrelAI (creature);
}

#define SPELL_SINISTERSTRIKE        15581
#define SPELL_BACKSTAB              15582
#define SPELL_GOUGE                 13579

struct boss_doperelAI : public ScriptedAI
{
    boss_doperelAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 SinisterStrike_Timer;
    uint32 BackStab_Timer;
    uint32 Gouge_Timer;

    void Reset()
    {
        SinisterStrike_Timer = 8000;
        BackStab_Timer = 12000;
        Gouge_Timer = 6000;

        me->setFaction(FACTION_NEUTRAL);
    }

    void EnterCombat(Unit *who)
    {
    }

    void EnterEvadeMode()
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit *slayer)
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, SPECIAL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //SinisterStrike_Timer
        if (SinisterStrike_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_SINISTERSTRIKE);
            SinisterStrike_Timer = 7000;
        }
        else
            SinisterStrike_Timer -= diff;

        //BackStab_Timer
        if (BackStab_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_BACKSTAB);
            BackStab_Timer = 6000;
        }
        else
            BackStab_Timer -= diff;

        //Gouge_Timer
        if (Gouge_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_GOUGE);
            Gouge_Timer = 8000;
        }
        else
            Gouge_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_doperel(Creature *creature)
{
    return new boss_doperelAI (creature);
}

#define SPELL_SHADOWBOLT        17483                       //Not sure if right ID
#define SPELL_MANABURN          10876
#define SPELL_SHADOWSHIELD      22417

struct boss_haterelAI : public ScriptedAI
{
    boss_haterelAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 ShadowBolt_Timer;
    uint32 ManaBurn_Timer;
    uint32 ShadowShield_Timer;
    uint32 Strike_Timer;

    void Reset()
    {
        ShadowBolt_Timer = 15000;
        ManaBurn_Timer = 3000;
        ShadowShield_Timer = 8000;
        Strike_Timer = 12000;

        me->setFaction(FACTION_NEUTRAL);
    }

    void EnterCombat(Unit *who)
    {
    }

    void EnterEvadeMode()
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit *slayer)
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, SPECIAL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //ShadowBolt_Timer
        if (ShadowBolt_Timer < diff)
        {
            Unit* target = NULL;
            target = SelectUnit(SELECT_TARGET_RANDOM,0);
            if (target) DoCast(target,SPELL_SHADOWBOLT);
            ShadowBolt_Timer = 7000;
        }
        else
            ShadowBolt_Timer -= diff;

        //ManaBurn_Timer
        if (ManaBurn_Timer < diff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(target,SPELL_MANABURN);

            ManaBurn_Timer = 13000;
        }
        else
            ManaBurn_Timer -= diff;

        //ShadowShield_Timer
        if (ShadowShield_Timer < diff)
        {
            DoCast(me,SPELL_SHADOWSHIELD);
            ShadowShield_Timer = 25000;
        }
        else
            ShadowShield_Timer -= diff;

        //Strike_Timer
        if (Strike_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_STRIKE);
            Strike_Timer = 10000;
        }
        else
            Strike_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_haterel(Creature *creature)
{
    return new boss_haterelAI (creature);
}

#define SPELL_MINDBLAST             15587
#define SPELL_HEAL                  15586
#define SPELL_PRAYEROFHEALING       15585
#define SPELL_SHIELD                10901

struct boss_vilerelAI : public ScriptedAI
{
    boss_vilerelAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 MindBlast_Timer;
    uint32 Heal_Timer;
    uint32 PrayerOfHealing_Timer;
    uint32 Shield_Timer;

    void Reset()
    {
        MindBlast_Timer = 10000;
        Heal_Timer = 35000;
        PrayerOfHealing_Timer = 25000;
        Shield_Timer = 3000;

        me->setFaction(FACTION_NEUTRAL);
    }

    void EnterCombat(Unit *who)
    {
    }

    void EnterEvadeMode()
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit *slayer)
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, SPECIAL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //MindBlast_Timer
        if (MindBlast_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_MINDBLAST);
            MindBlast_Timer = 7000;
        }
        else
            MindBlast_Timer -= diff;

        //Heal_Timer
        if (Heal_Timer < diff)
        {
            DoCast(me,SPELL_HEAL);
            Heal_Timer = 20000;
        }
        else
            Heal_Timer -= diff;

        //PrayerOfHealing_Timer
        if (PrayerOfHealing_Timer < diff)
        {
            DoCast(me,SPELL_PRAYEROFHEALING);
            PrayerOfHealing_Timer = 30000;
        }
        else
            PrayerOfHealing_Timer -= diff;

        //Shield_Timer
        if (Shield_Timer < diff)
        {
            DoCast(me,SPELL_SHIELD);
            Shield_Timer = 30000;
        }
        else
            Shield_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_vilerel(Creature *creature)
{
    return new boss_vilerelAI (creature);
}

#define SPELL_FROSTBOLT         16799
#define SPELL_FROSTARMOR        15784                       //This is actually a buff he gives himself
#define SPELL_BLIZZARD          19099
#define SPELL_FROSTNOVA         15063
#define SPELL_FROSTWARD         15004

struct boss_seethrelAI : public ScriptedAI
{
    boss_seethrelAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 FrostArmor_Timer;
    uint32 Frostbolt_Timer;
    uint32 Blizzard_Timer;
    uint32 FrostNova_Timer;
    uint32 FrostWard_Timer;

    void Reset()
    {
        FrostArmor_Timer = 2000;
        Frostbolt_Timer = 6000;
        Blizzard_Timer = 18000;
        FrostNova_Timer = 12000;
        FrostWard_Timer = 25000;

        me->CastSpell(me,SPELL_FROSTARMOR,true);
        me->setFaction(FACTION_NEUTRAL);
    }

    void EnterCombat(Unit *who)
    {
    }

    void EnterEvadeMode()
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit *slayer)
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, SPECIAL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //FrostArmor_Timer
        if (FrostArmor_Timer < diff)
        {
            DoCast(me, SPELL_FROSTARMOR);
            FrostArmor_Timer = 180000;
        }
        else
            FrostArmor_Timer -= diff;

        //Frostbolt_Timer
        if (Frostbolt_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_FROSTBOLT);
            Frostbolt_Timer = 15000;
        }
        else
            Frostbolt_Timer -= diff;

        //Blizzard_Timer
        if (Blizzard_Timer < diff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(target,SPELL_BLIZZARD);

            Blizzard_Timer = 22000;
        }
        else
            Blizzard_Timer -= diff;

        //FrostNova_Timer
        if (FrostNova_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_FROSTNOVA);
            FrostNova_Timer = 14000;
        }
        else
            FrostNova_Timer -= diff;

        //FrostWard_Timer
        if (FrostWard_Timer < diff)
        {
            DoCast(me,SPELL_FROSTWARD);
            FrostWard_Timer = 68000;
        }
        else
            FrostWard_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_seethrel(Creature *creature)
{
    return new boss_seethrelAI (creature);
}

#define SPELL_HAMSTRING             9080
#define SPELL_CLEAVE                15579
#define SPELL_MORTALSTRIKE          15708

struct boss_gloomrelAI : public ScriptedAI
{
    boss_gloomrelAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 Hamstring_Timer;
    uint32 Cleave_Timer;
    uint32 MortalStrike_Timer;

    void Reset()
    {
        Hamstring_Timer = 19000;
        Cleave_Timer = 6000;
        MortalStrike_Timer = 10000;

        me->setFaction(FACTION_NEUTRAL);
    }

    void EnterCombat(Unit *who)
    {
    }

    void EnterEvadeMode()
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit *slayer)
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, SPECIAL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim() )
            return;

        //Hamstring_Timer
        if (Hamstring_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_HAMSTRING);
            Hamstring_Timer = 14000;
        }
        else
            Hamstring_Timer -= diff;

        //Cleave_Timer
        if (Cleave_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_CLEAVE);
            Cleave_Timer = 8000;
        }
        else
            Cleave_Timer -= diff;

        //MortalStrike_Timer
        if (MortalStrike_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_MORTALSTRIKE);
            MortalStrike_Timer = 12000;
        }
        else
            MortalStrike_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_gloomrel(Creature *creature)
{
    return new boss_gloomrelAI (creature);
}

#define GOSSIP_ITEM_TEACH_1 "Teach me the art of smelting dark iron"
#define GOSSIP_ITEM_TEACH_2 "Continue..."
#define GOSSIP_ITEM_TRIBUTE "I want to pay tribute"

bool GossipHello_boss_gloomrel(Player *player, Creature *creature)
{
    if (player->GetQuestRewardStatus(4083) == 1 && player->GetSkillValue(SKILL_MINING) >= 230 && !player->HasSpell(14891) )
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_TEACH_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

    if (player->GetQuestRewardStatus(4083) == 0 && player->GetSkillValue(SKILL_MINING) >= 230)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_TRIBUTE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
    player->SEND_GOSSIP_MENU(2601, creature->GetGUID());
    return true;
}

bool GossipSelect_boss_gloomrel(Player *player, Creature *creature, uint32 sender, uint32 action )
{
    static uint64 SpectralChaliceGUID = 0;
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_TEACH_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
            player->SEND_GOSSIP_MENU(2606, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+11:
            player->CLOSE_GOSSIP_MENU();
            creature->CastSpell(player, 14894, false);
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(0, "[PH] Continue...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 22);
            player->SEND_GOSSIP_MENU(2604, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+22:
            player->CLOSE_GOSSIP_MENU();
            if(!creature->GetMap()->GetGameObject(SpectralChaliceGUID))
            {
                GameObject *spectralChalice = creature->SummonGameObject(164869, 1232, -239, -85, 4.05, 0, 0, 0, 0, 0);
                if(spectralChalice)
                    SpectralChaliceGUID = spectralChalice->GetGUID();
            }
            break;
    }
    return true;
}

#define SPELL_SHADOWBOLTVOLLEY               17228
#define SPELL_IMMOLATE                       15505
#define SPELL_CURSEOFWEAKNESS                17227
#define SPELL_DEMONARMOR                     11735
#define SPELL_SUMMON_VOIDS                   15092
#define GO_CHEST_SEVEN                       169243

struct boss_doomrelAI : public ScriptedAI
{
    boss_doomrelAI(Creature *c) : ScriptedAI(c), voids(me) 
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    SummonList voids;
    uint32 ShadowVolley_Timer;
    uint32 Immolate_Timer;
    uint32 CurseOfWeakness_Timer;
    uint32 DemonArmor_Timer;
    bool Voidwalkers;

    uint64 DoomGUID;

    void Reset()
    {
        ShadowVolley_Timer = 10000;
        Immolate_Timer = 18000;
        CurseOfWeakness_Timer = 5000;
        DemonArmor_Timer = 16000;
        Voidwalkers = false;

        DoomGUID = 0;

        me->setFaction(FACTION_NEUTRAL);
    }

    void EnterCombat(Unit *who)
    {
    }

    void JustSummoned(Creature* summoned)
    {
        voids.Summon(summoned);
        summoned->AI()->AttackStart(me->getVictim());
    }

    void EnterEvadeMode()
    {
        voids.DespawnAll();

        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, FAIL);

        ScriptedAI::EnterEvadeMode();
    }

    void JustDied(Unit *slayer)
    {
        if(pInstance)
            pInstance->SetData(TYPE_TOMB_OF_SEVEN, DONE);

        slayer->SummonGameObject(GO_CHEST_SEVEN, 1265.96f, -284.121f, -78.2191, 3.8531f, 0, 0, 0, 0, 0);
    }

    void DoAction(const int32 param)
    {
        switch (param)
        {
            case 1:
                DoomGUID = pInstance->GetData64(DATA_ANGERREL);
                break;
            case 2:
                DoomGUID = pInstance->GetData64(DATA_SEETHREL);
                break;
            case 3:
                DoomGUID = pInstance->GetData64(DATA_DOPEREL);
                break;
            case 4:
                DoomGUID = pInstance->GetData64(DATA_GLOOMREL);
                break;
            case 5:
                DoomGUID = pInstance->GetData64(DATA_VILEREL);
                break;
            case 6:
                DoomGUID = pInstance->GetData64(DATA_HATEREL);
                break;
            default:
                me->setFaction(FACTION_HOSTILE);
                DoZoneInCombat();
                return;
        }

        if (Creature *boss = me->GetCreature(DoomGUID))
        {
            boss->setFaction(FACTION_HOSTILE);
            boss->AI()->DoZoneInCombat();
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //ShadowVolley_Timer
        if (ShadowVolley_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_SHADOWBOLTVOLLEY);
            ShadowVolley_Timer = 12000;
        }
        else
            ShadowVolley_Timer -= diff;

        //Immolate_Timer
        if (Immolate_Timer < diff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(target,SPELL_IMMOLATE);

            Immolate_Timer = 25000;
        }
        else
            Immolate_Timer -= diff;

        //CurseOfWeakness_Timer
        if (CurseOfWeakness_Timer < diff)
        {
            DoCast(me->getVictim(),SPELL_CURSEOFWEAKNESS);
            CurseOfWeakness_Timer = 45000;
        }
        else
            CurseOfWeakness_Timer -= diff;

        //DemonArmor_Timer
        if (DemonArmor_Timer < diff)
        {
            DoCast(me,SPELL_DEMONARMOR);
            DemonArmor_Timer = 300000;
        }
        else
            DemonArmor_Timer -= diff;

        //Summon Voidwalkers
        if (!Voidwalkers && me->GetHealth()*100 / me->GetMaxHealth() < 51 )
        {
            DoCast(me->getVictim(), SPELL_SUMMON_VOIDS);
            Voidwalkers = true;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_doomrel(Creature *creature)
{
    return new boss_doomrelAI (creature);
}

#define GOSSIP_ITEM_CHALLENGE   "Your bondage is at an end, Doom'rel. I challenge you!"
#define SAY_START    "You have challenged the Seven, and now you will die!"

bool GossipHello_boss_doomrel(Player *player, Creature *creature)
{
    ScriptedInstance *pInstance = (creature->GetInstanceData());

    if (pInstance->GetData(TYPE_TOMB_OF_SEVEN) == NOT_STARTED || pInstance->GetData(TYPE_TOMB_OF_SEVEN) == FAIL)
    {
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_CHALLENGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(2601, creature->GetGUID());
    }

    return true;
}

bool GossipSelect_boss_doomrel(Player *player, Creature *creature, uint32 sender, uint32 action )
{
    ScriptedInstance *pInstance = (creature->GetInstanceData());

    if (action == GOSSIP_ACTION_INFO_DEF + 1)
    {
        player->CLOSE_GOSSIP_MENU();
        creature->Say(SAY_START, LANG_UNIVERSAL, player->GetGUID());
        pInstance->SetData(TYPE_TOMB_OF_SEVEN, IN_PROGRESS);
    }

    return true;
}

void AddSC_boss_tomb_of_seven()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_angerrel";
    newscript->GetAI = &GetAI_boss_angerrel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_doperel";
    newscript->GetAI = &GetAI_boss_doperel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_haterel";
    newscript->GetAI = &GetAI_boss_haterel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_vilerel";
    newscript->GetAI = &GetAI_boss_vilerel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_seethrel";
    newscript->GetAI = &GetAI_boss_seethrel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_gloomrel";
    newscript->GetAI = &GetAI_boss_gloomrel;
    newscript->pGossipHello = &GossipHello_boss_gloomrel;
    newscript->pGossipSelect = &GossipSelect_boss_gloomrel;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_doomrel";
    newscript->GetAI = &GetAI_boss_doomrel;
    newscript->pGossipHello = &GossipHello_boss_doomrel;
    newscript->pGossipSelect = &GossipSelect_boss_doomrel;
    newscript->RegisterSelf();
}

