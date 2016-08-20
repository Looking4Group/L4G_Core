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
SDName: Isle_of_Queldanas
SD%Complete: 100
SDComment: Quest support: 11524, 11525, 11532, 11533, 11542, 11543, 11541
SDCategory: Isle Of Quel'Danas
EndScriptData */

/* ContentData
npc_archmage_nethul
npc_ayren_cloudbreaker
npc_converted_sentry
npc_unrestrained_dragonhawk
npc_greengill_slave
npc_madrigosa
npc_brutallus
EndContentData */

#include "precompiled.h"
#include "GameEvent.h"

/*######
## npc_archmage_nethul
######*/

bool GossipHello_npc_archmage_nethul(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu(_Creature->GetGUID());

    int32 text = 0;
    player->ADD_GOSSIP_ITEM(0, "Wie ist der aktuelle Status", GOSSIP_SENDER_MAIN,1);
    /*player->ADD_GOSSIP_ITEM(1, "SWP Event: Aktivste Gilde", GOSSIP_SENDER_MAIN,2);
    player->ADD_GOSSIP_ITEM(2, "SWP Event: Aktivste Spieler", GOSSIP_SENDER_MAIN,3);
    player->ADD_GOSSIP_ITEM(3, "SWP Event: Beliebteste Daily", GOSSIP_SENDER_MAIN,4);*/
    player->ADD_GOSSIP_ITEM(3, "Auf Wiedersehen", GOSSIP_SENDER_MAIN,5);
    player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,_Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_archmage_nethul(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (!player)
        return false;

    switch(action)
    {
    case 1:
        {
            QueryResultAutoPtr query = GameDataDatabase.PQuery("SELECT * FROM `new_swp_event` WHERE `id`= 1");
            if (query)
            {
                Field *fields = query->Fetch();
                uint64 quests_needed_p1    = fields[0].GetUInt64(); //for SWP Opening
                uint64 quests_needed_p2    = fields[1].GetUInt64(); //for Boss 1,2 and 3
                uint64 quests_needed_p3    = fields[2].GetUInt64(); //for Boss 4 and 5
                uint64 quests_needed_p4    = fields[3].GetUInt64(); //for Last Boss
                uint64 quests_done        = fields[4].GetUInt64();
                uint64 quests_phase        = fields[5].GetUInt64();

                if (quests_phase == -1)
                {
                    player->GetSession()->SendAreaTriggerMessage("SWP Event nicht gestartet");
                }

                if (quests_phase == 0)
                {
                    uint16 percent_done = 0;
                    percent_done = quests_done * 100 / quests_needed_p1;

                    if (quests_done >= quests_needed_p1)
                    {
                        QueryResultAutoPtr query = GameDataDatabase.PQuery("UPDATE `new_swp_event` SET `quests_phase`= 1 WHERE `id`= 1");
                        quests_phase++;
                    }
                    else
                    {
                        player->GetSession()->SendAreaTriggerMessage("Sonnenbrunnenplateau geschlossen! %u Prozent Quests fuer Phase 1!", percent_done);
                    }

                }
                if (quests_phase == 1)
                {
                    uint16 percent_done = 0;
                    percent_done = quests_done * 100 / quests_needed_p2;

                    if (quests_done >= quests_needed_p2)
                    {
                        QueryResultAutoPtr query = GameDataDatabase.PQuery("UPDATE `new_swp_event` SET `quests_phase`= 2 WHERE `id`= 1");
                        quests_phase++;
                    }
                    else
                    {
                        player->GetSession()->SendAreaTriggerMessage("Phase 1 abgeschlossen, 3 Bosse im Sonnenbrunnenplateau freigeschaltet!  %u Prozent Quests fuer Phase 2!", percent_done);
                    }

                }
                if (quests_phase == 2)
                {
                    uint16 percent_done = 0;
                    percent_done = quests_done * 100 / quests_needed_p3;

                    if (quests_done >= quests_needed_p3)
                    {
                        QueryResultAutoPtr query = GameDataDatabase.PQuery("UPDATE `new_swp_event` SET `quests_phase`= 3 WHERE `id`= 1");
                        quests_phase++;
                    }
                    else
                    {
                        player->GetSession()->SendAreaTriggerMessage("Phase 1 abgeschlossen, 5 Bosse im Sonnenbrunnenplateau freigeschaltet!  %u Prozent Quests fuer Phase 3!", percent_done);
                    }
                }
                if (quests_phase == 3)
                {
                    player->GetSession()->SendAreaTriggerMessage("Sonnenbrunnenplateau komplett geoeffnet!");
                }
            }

            player->PlayerTalkClass->ClearMenus();
            player->CLOSE_GOSSIP_MENU();
            break;
        }     
    case 2:
        {
            player->CLOSE_GOSSIP_MENU();
            break;
        }
   /* case 3:
        {
            player->CLOSE_GOSSIP_MENU();
            break;
        }
    case 4:
        {
            player->CLOSE_GOSSIP_MENU();
            break;
        }
    case 5:
        {
            player->CLOSE_GOSSIP_MENU();
            break;
        }*/
    }
    return true;
}

/*######
## npc_ayren_cloudbreaker
######*/

#define GOSSIP_FLY1 "Speaking of action, I've been ordered to undertake an air strike."
#define GOSSIP_FLY2 "I need to intercept the Dawnblade reinforcements."
bool GossipHello_npc_ayren_cloudbreaker(Player *player, Creature *_Creature)
{
    if( player->GetQuestStatus(11532) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(11533) == QUEST_STATUS_INCOMPLETE ||
        (player->GetQuestStatus(11532) == QUEST_STATUS_COMPLETE && !player->GetQuestRewardStatus(11532)) || (player->GetQuestStatus(11533) == QUEST_STATUS_COMPLETE && !player->GetQuestRewardStatus(11533)))
        player->ADD_GOSSIP_ITEM(0, GOSSIP_FLY1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    if( player->GetQuestStatus(11542) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(11543) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_FLY2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);

    player->SEND_GOSSIP_MENU(12252,_Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_ayren_cloudbreaker(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,45071,true);               //TaxiPath 779
    }
    if (action == GOSSIP_ACTION_INFO_DEF+2)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,45113,true);               //TaxiPath 784
    }
    return true;
}

const char* WretchedQuotes[3] =
{
    "It's not meant for you! Get away from here!",
    "Mine! You shall not take this place!",
    "The rift's power is ours!"
};

/*######
## npc_wretched_devourer
######*/

#define SPELL_ARCANE_TORRENT        33390
#define SPELL_MANA_TAP              33483
#define SPELL_NETHER_SHOCK          35334
// do not regenerates mana OOC - creature extra flag (dec value 16777216)

struct npc_wretched_devourerAI : public ScriptedAI
{
    npc_wretched_devourerAI(Creature* c) : ScriptedAI(c) {}

    uint32 ArcaneTorrent;
    uint32 ManaTap;
    uint32 NetherShock;

    void Reset()
    {
        me->SetPower(POWER_MANA, 0);
        ArcaneTorrent = RAND(urand(1500, 4500),urand(5000, 10000));
        ManaTap = urand(3000, 6000);
        NetherShock = urand(4000, 8000);
    }

    void EnterCombat(Unit* who)
    {
        if(roll_chance_f(20))
            DoYell(WretchedQuotes[urand(0,2)], LANG_THALASSIAN, who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;
        if(ArcaneTorrent < diff)
        {
            AddSpellToCast(SPELL_ARCANE_TORRENT, CAST_SELF);
            ArcaneTorrent = RAND(urand(1500, 4500),urand(6000, 11000));
        }
        else
            ArcaneTorrent -= diff;
        if(ManaTap < diff)
        {
            AddSpellToCast(SPELL_MANA_TAP, CAST_TANK);
            ManaTap = urand(15000, 24000);
        }
        else
            ManaTap -= diff;
        if(NetherShock < diff)
        {
            AddSpellToCast(SPELL_NETHER_SHOCK, CAST_TANK);
            NetherShock = urand(4000, 8000);
        }
        else
            NetherShock -= diff;
        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_wretched_devourer(Creature* _Creature)
{
    return new npc_wretched_devourerAI(_Creature);
}

/*######
## npc_wretched_fiend
######*/

#define SPELL_SUNDER_ARMOR          11971
#define SPELL_BITTER_WITHDRAWAL     29098

#define SPELL_SLEEPING_SLEEP        42648
// do not regenerates mana OOC - creature extra flag (dec value 16777216)

struct npc_wretched_fiendAI : public ScriptedAI
{
    npc_wretched_fiendAI(Creature* c) : ScriptedAI(c) {}

    uint32 SunderArmor;
    uint32 BitterWithdrawal;

    void Reset()
    {
        me->SetPower(POWER_MANA, 0);
        SunderArmor = urand(6000, 10000);
        BitterWithdrawal = 1000;
    }

    void EnterCombat(Unit* who)
    {
        if(roll_chance_f(20))
            DoYell(WretchedQuotes[urand(0,2)], LANG_THALASSIAN, who);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!UpdateVictim())
            return;
        if(SunderArmor < diff)
        {
            AddSpellToCast(SPELL_SUNDER_ARMOR, CAST_TANK);
            SunderArmor = urand(12000, 16000);
        }
        else
            SunderArmor -= diff;
        if(HealthBelowPct(85))
        {
            if(BitterWithdrawal < diff)
            {
                AddSpellToCast(SPELL_BITTER_WITHDRAWAL, CAST_TANK);
                BitterWithdrawal = urand(10000, 15000);
            }
            else
                BitterWithdrawal -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_wretched_fiend(Creature* _Creature)
{
    return new npc_wretched_fiendAI(_Creature);
}

/*######
## npc_erratic_sentry
######*/
#define YELL_CORE_OVERLOAD    "Core overload detected. System malfunction detected..."

#define CAPACITATOR_OVERLOAD        45014
#define SPELL_SUPPRESSION           35892
#define SPELL_ELECTRICAL_OVERLOAD   45336
#define SPELL_CRYSTAL_STRIKE        33688
// do not regenerates health OOC, but self repairs when at or below 50%- creature extra flag (dec value 33554432)

struct npc_erratic_sentryAI : public ScriptedAI
{
    npc_erratic_sentryAI(Creature* c) : ScriptedAI(c) {}

    uint32 CapacitatorOverload;
    uint32 Suppression;
    uint32 ElectricalOverload;
    uint32 CrystalStrike;

    void Reset()
    {
        CapacitatorOverload = 5000;
        Suppression = urand(3000, 10000);
        ElectricalOverload = 1000;
        CrystalStrike = urand(2000, 14000);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->isInCombat())
        {
            if(HealthBelowPct(90))
            {
                if(!me->HasAura(44994))
                {
                    if(CapacitatorOverload < diff)
                    {
                        DoCast(me, CAPACITATOR_OVERLOAD, true);
                        CapacitatorOverload = 500;
                    }
                    else
                        CapacitatorOverload -= diff;
                }
            }
            else
            {
                if(CapacitatorOverload < diff)
                {
                    if(roll_chance_i(5))
                    {
                        int32 dmg = 1714;
                        me->CastCustomSpell(me, CAPACITATOR_OVERLOAD, 0, 0, 0, true);
                        CapacitatorOverload = 500;
                        return;
                    }
                    if(HealthBelowPct(100) && roll_chance_i(15))
                        me->SetHealth(me->GetMaxHealth());
                    CapacitatorOverload = 5000;
                }
                else
                    CapacitatorOverload -= diff;
            }
        }

        if(!UpdateVictim())
            return;

        if(Suppression < diff)
        {
            AddSpellToCast(SPELL_SUPPRESSION, CAST_NULL);
            Suppression = urand(15000, 25000);
        }
        else
            Suppression -= diff;

        if(CrystalStrike < diff)
        {
            AddSpellToCast(SPELL_CRYSTAL_STRIKE, CAST_TANK);
            CrystalStrike = 14000;
        }
        else
            CrystalStrike -= diff;

        if(HealthBelowPct(80) && !HealthBelowPct(50))
        {
            if(ElectricalOverload < diff)
            {
                if(roll_chance_i(20))
                    DoYell(YELL_CORE_OVERLOAD, 0, me->getVictim());
                AddSpellToCast(SPELL_ELECTRICAL_OVERLOAD, CAST_SELF);
                ElectricalOverload = 10000;
            }
            else
                ElectricalOverload -= diff;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_erratic_sentry(Creature* _Creature)
{
    return new npc_erratic_sentryAI(_Creature);
}

/*######
## npc_sunblade_lookout
######*/

#define SPELL_LOOKOUT_SHOOT     45172

const char* LookoutYell[3] =
{
    "Shattered Sun scum! Fire at will!",
    "Don't let that dragonhawk through! Open fire!",
    "Dragonhawk incoming from the west! Shoot that $c down!"
};

struct npc_sunblade_lookoutAI : public Scripted_NoMovementAI
{
    npc_sunblade_lookoutAI(Creature* c) : Scripted_NoMovementAI(c) {}
    void MoveInLineOfSight(Unit *who)
    {
        if(who->GetTypeId() == TYPEID_PLAYER && who->IsTaxiFlying())
        {
            if(me->IsWithinDistInMap(who, 80))
            {
                if(roll_chance_i(8))
                    DoCast(who, SPELL_LOOKOUT_SHOOT);
                if(roll_chance_f(0.3))
                    me->Yell(LookoutYell[urand(0,2)], 0, who->GetGUID());
            }
        }
    }
};

CreatureAI* GetAI_npc_sunblade_lookout(Creature* _Creature)
{
    return new npc_sunblade_lookoutAI(_Creature);
}

/*######
## npc_wrath_enforcer
######*/

#define SPELL_DUAL_WIELD            29651
#define SPELL_FLAME_WAVE            33803
#define MOB_RAVAGER                 25028
#define MOB_GHOUL                   25027

struct npc_wrath_enforcerAI : public ScriptedAI
{
    npc_wrath_enforcerAI(Creature* c) : ScriptedAI(c) {}

    uint32 FlameWave;

    void Reset()
    {
        me->setActive(true);
        DoCast(me, 29651, true);
        FlameWave = urand(5000, 35000);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->isInCombat())
        {
            Unit* Ravager = GetClosestCreatureWithEntry(me, MOB_RAVAGER, 50);
            Unit* Ghoul = GetClosestCreatureWithEntry(me, MOB_GHOUL, 50);
            Unit* target = NULL;

            if(Ravager && Ghoul)
                target = me->GetDistance(Ravager)>me->GetDistance(Ghoul)?Ghoul:Ravager;
            else
                target = Ravager?Ravager:(Ghoul?Ghoul:NULL);
            if(target)
            {
                me->AddThreat(target, 10.0f);
                AttackStart(target);
            }
        }

        if(!UpdateVictim())
            return;

        if(FlameWave < diff)
        {
            AddSpellToCast(SPELL_FLAME_WAVE, CAST_SELF);
            FlameWave = urand(20000, 30000);
        }
        else
            FlameWave -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_wrath_enforcer(Creature* _Creature)
{
    return new npc_wrath_enforcerAI(_Creature);
}

/*######
## npc_flame_wave
######*/

#define SPELL_BURN          33802

struct npc_flame_waveAI : public ScriptedAI
{
    npc_flame_waveAI(Creature* c) : ScriptedAI(c) {}

    uint32 Burn;

    void IsSummonedBy(Unit *summoner)
    {
        Burn = 0;
        me->SetReactState(REACT_PASSIVE);
        float x, y, z;
        me->SetWalk(true);
        me->SetSpeed(MOVE_WALK, 1.7);
        me->GetNearPoint( x, y, z, 0, 20, summoner->GetAngle(me));
        me->UpdateAllowedPositionZ(x, y, z);
        me->GetMotionMaster()->MovePoint(1, x, y, z);
    }
    void UpdateAI(const uint32 diff)
    {
        if(Burn < diff)
        {
            DoCast(me, SPELL_BURN, true);
            Burn = 500;
        }
        else
            Burn -= diff;
    }
};

CreatureAI* GetAI_npc_flame_wave(Creature* _Creature)
{
    return new npc_flame_waveAI(_Creature);
}

/*######
## npc_pit_overlord
######*/

#define SPELL_CLEAVE                15284
#define SPELL_CONE_OF_FIRE          19630
#define SPELL_DEATH_COIL            32709

struct npc_pit_overlordAI : public ScriptedAI
{
    npc_pit_overlordAI(Creature* c) : ScriptedAI(c) {}

    uint32 Cleave;
    uint32 ConeOfFire;
    uint32 DeathCoil;

    void Reset()
    {
        me->setActive(true);
        Cleave = urand(5000, 15000);
        ConeOfFire = urand(1000, 5000);
        DeathCoil = urand(3000, 8000);
    }

    void UpdateAI(const uint32 diff)
    {
        if(!me->isInCombat())
        {
            Unit* Ravager = GetClosestCreatureWithEntry(me, MOB_RAVAGER, 50);
            Unit* Ghoul = GetClosestCreatureWithEntry(me, MOB_GHOUL, 50);
            Unit* target = NULL;

            if(Ravager && Ghoul)
                target = me->GetDistance(Ravager)>me->GetDistance(Ghoul)?Ghoul:Ravager;
            else
                target = Ravager?Ravager:(Ghoul?Ghoul:NULL);
            if(target)
            {
                me->AddThreat(target, 10.0f);
                AttackStart(target);
            }
        }

        if(!UpdateVictim())
            return;

        if(Cleave < diff)
        {
            AddSpellToCast(SPELL_CLEAVE);
            Cleave = urand(10000, 20000);
        }
        else
            Cleave -= diff;

        if(ConeOfFire < diff)
        {
            AddSpellToCast(SPELL_CONE_OF_FIRE, CAST_NULL);
            ConeOfFire = urand(8000, 16000);
        }
        else
            ConeOfFire -= diff;

        if(DeathCoil < diff)
        {
            AddSpellToCast(SPELL_DEATH_COIL);
            DeathCoil = urand(8000, 12000);
        }
        else
            DeathCoil -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_pit_overlord(Creature* _Creature)
{
    return new npc_pit_overlordAI(_Creature);
}

/*######
## npc_eredar_sorcerer
######*/

#define SPELL_FLAMES_OF_DOOM        45046

struct npc_eredar_sorcererAI : public Scripted_NoMovementAI
{
    npc_eredar_sorcererAI(Creature* c) : Scripted_NoMovementAI(c) {}

    void Reset()
    {
        //me->setActive(true);
        //SetAutocast(SPELL_FLAMES_OF_DOOM, 10000, true);
    }

    void UpdateAI(const uint32 diff)
    {
        /*if(!me->isInCombat())
        {
        Unit* Ravager = GetClosestCreatureWithEntry(me, MOB_RAVAGER, 100);
        Unit* Ghoul = GetClosestCreatureWithEntry(me, MOB_GHOUL, 100);
        Unit* target = NULL;

        if(Ravager && Ghoul)
        target = me->GetDistance(Ravager)>me->GetDistance(Ghoul)?Ghoul:Ravager;
        else
        target = Ravager?Ravager:(Ghoul?Ghoul:NULL);
        if(target)
        {
        me->AddThreat(target, 10.0f);
        AttackStart(target);
        }
        }*/
        if(!UpdateVictim())
            return;
        //CastNextSpellIfAnyAndReady(diff);
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_eredar_sorcerer(Creature* _Creature)
{
    return new npc_eredar_sorcererAI(_Creature);
}

/*######
## npc_shattered_sun_bombardier
######*/

#define BOMBARDIER_FLY_PATH     1776

const char* BombardierYell[6] =
{
    "Fall into formation! We're approaching the Dead Scar.",
    "Keep your eye on the demons. We're not concerned with killing Scourge today.",
    "Be quick with those charges. Some of those demons are going to take more than one direct hit to bring down.",
    "Move up and hit them from above. Let's try to get $n some cover.",
    "It's show time! Blast them hard, blast them fast!",
    "We've got your back, $n"
};

struct npc_shattered_sun_bombardierAI : public ScriptedAI
{
    npc_shattered_sun_bombardierAI(Creature* c) : ScriptedAI(c) {}

    uint64 PlayerGUID;
    uint32 yell_timer;
    uint8 yell;
    bool PathFly;

    void Reset()
    {
        me->SetVisibility(VISIBILITY_OFF);
        me->setActive(true);
        PlayerGUID = 0;
        yell_timer = 60000000;
        PathFly = false;
        yell = 0;
        me->GetMotionMaster()->MoveIdle();
    }

    void MoveInLineOfSight(Unit* who)
    {
        if(who->GetTypeId() != TYPEID_PLAYER)
            return;

        if (who->IsTaxiFlying() && who->IsWithinDistInMap(me, 40) && !PathFly)
        {
            PlayerGUID = who->GetGUID();
            me->GetMotionMaster()->Clear(false);
            m_creature->SetLevitate(true);
            m_creature->GetMotionMaster()->MovePath(BOMBARDIER_FLY_PATH, false);
            me->SetSpeed(MOVE_WALK, 1.4*who->GetSpeed(MOVE_FLIGHT));
            me->SetVisibility(VISIBILITY_ON);
            yell_timer = 5000;
            PathFly = true;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (yell_timer < diff)
        {
            switch(yell)
            {
            case 0:
                if(me->GetGUIDLow() == 85370)
                    me->Yell(BombardierYell[rand()%3], 0, PlayerGUID);
                me->SetSpeed(MOVE_WALK, 1.01*me->GetSpeed(MOVE_WALK));
                yell++;
                yell_timer = 7000;
                break;
            case 1:
                if(me->GetGUIDLow() == 85370)
                    me->Yell(BombardierYell[3+rand()%3], 0, PlayerGUID);
                yell++;
                yell_timer = 7000;
                break;
            case 2:
                me->DisappearAndDie();
                me->Respawn();
                break;
            default:
                break;
            }
        }
        else
            yell_timer -= diff;
    }
};

CreatureAI* GetAI_npc_shattered_sun_bombardierAI(Creature* _Creature)
{
    return new npc_shattered_sun_bombardierAI(_Creature);
}

/*######
## npc_unrestrained_dragonhawk
######*/

#define GOSSIP_UD "<Ride the dragonhawk to Sun's Reach>"

bool GossipHello_npc_unrestrained_dragonhawk(Player *player, Creature *_Creature)
{
    player->ADD_GOSSIP_ITEM(0, GOSSIP_UD, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
    player->SEND_GOSSIP_MENU(12371,_Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_unrestrained_dragonhawk(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,45353,true);               //TaxiPath 788
    }
    return true;
}

/*######
## npc_greengill_slave
######*/

#define ENRAGE  45111
#define ORB     45109
#define QUESTG  11541
#define DM      25060
#define SIREN   25073

struct npc_greengill_slaveAI : public ScriptedAI
{
    npc_greengill_slaveAI(Creature* c) : ScriptedAI(c) {}

    uint64 PlayerGUID;
    uint32 enrageTimer;

    void Reset()
    {
        PlayerGUID = 0;
        enrageTimer = 30000;
    }
    void MovementInform(uint32 type, uint32 id)
    {
        if(type == POINT_MOTION_TYPE && id == 1)
            me->ForcedDespawn();
    }
    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(!caster)
            return;

        if(caster->GetTypeId() == TYPEID_PLAYER && spell->Id == ORB && !m_creature->HasAura(ENRAGE))
        {
            PlayerGUID = caster->GetGUID();
            if(PlayerGUID)
            {
                Player* plr = Unit::GetPlayer(PlayerGUID);
                if(plr && plr->GetQuestStatus(QUESTG) == QUEST_STATUS_INCOMPLETE)
                    plr->KilledMonster(25086, m_creature->GetGUID());
            }
            DoCast(m_creature, ENRAGE);
            me->SetWalk(false);
            me->SetSpeed(MOVE_RUN, 1.5);
            Unit* Myrmidon = GetClosestCreatureWithEntry(me, DM, 100);
            Unit* Siren = GetClosestCreatureWithEntry(me, SIREN, 100);
            Unit* target = NULL;
            if(Myrmidon && Siren)
                target = me->GetDistance(Myrmidon)>me->GetDistance(Siren)?Siren:Myrmidon;
            else
                target = Myrmidon?Myrmidon:(Siren?Siren:NULL);
            if(target)
            {
                me->AddThreat(target, 100000.0f);
                AttackStart(target);
            }
            else
            {
                float x, y, z;
                me->GetNearPoint( x, y, z, 0, 50, frand(0,2*M_PI));
                me->UpdateAllowedPositionZ(x, y, z);
                me->GetMotionMaster()->MovePoint(1, x, y, z);
            }
        }
    }
    void UpdateAI(const uint32 diff)
    {
        if(me->HasAura(ENRAGE))
        {
            if(enrageTimer < diff)
            {
                me->CombatStop();
                float x, y, z;
                me->GetNearPoint( x, y, z, 0, 15, frand(0,2*M_PI));
                me->UpdateAllowedPositionZ(x, y, z);
                me->GetMotionMaster()->MovePoint(1, x, y, z);
                enrageTimer = 60000;
            }
            else
                enrageTimer -= diff;
        }
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_greengill_slaveAI(Creature* _Creature)
{
    return new npc_greengill_slaveAI(_Creature);
}


const char* BrutalYell[10] =
{
    //when hitted by q item spell
    "What is this pathetic magic? How about you come back with twenty-four of your best friends and try again, $c",
    //random yells
    "No horror here can compare with what you'll face whe I'm through with you!",
    "Beat or be beaten! This is the way of the Legion!",
    "Burn their bodies, shred their skins, crush their creaking carapaces!",
    "Crush these stinking husks!",
    "Smash them! Grind the bones into the dirt!",
    "Harder, maggots! We must keep the sunwell clear for the master's return!",
    //Brutallus to Magrigosa
    "Grraaarrr! You think to make an icicle out of me? Come down, then I will add real fire to your life."
    "Come down! I tear your wings from your shoulders and feed you to the dirt. Then YOU be the maggot, dragon!"
    "Big talk from a blue birdie! How about you come down and see if you can pluck this maggot from the dirt!"
};

/*######
## npc_ioqd_brutallus
######*/

struct npc_ioqd_brutallusAI : public ScriptedAI
{
    npc_ioqd_brutallusAI(Creature* c) : ScriptedAI(c) {}

    uint32 RandYell_timer;

    void Reset()
    {
        RandYell_timer = urand(15000, 25000);
    }

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(spell->Id == 45072 && caster->GetTypeId() == TYPEID_PLAYER && caster->IsInWorld())
        {
            if(roll_chance_i(40))
                DoYell(BrutalYell[0], 0, caster);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(RandYell_timer < diff)
        {
            DoYell(BrutalYell[urand(1, 6)], 0, 0);
            RandYell_timer = urand(15000, 25000);
        }
        else
            RandYell_timer -= diff;

        // TODO-> answers to taunting
    }
};

CreatureAI* GetAI_npc_ioqd_brutallus(Creature* _Creature)
{
    return new npc_ioqd_brutallusAI(_Creature);
}

#define SPELL_FROST_BLAST       45201
#define MADRIGOSA_PATH          2499

/*######
## npc_ioqd_madrigosa
######*/

struct npc_ioqd_madrigosaAI : public ScriptedAI
{
    npc_ioqd_madrigosaAI(Creature* c) : ScriptedAI(c) {}

    uint32 RandYell_timer;

    void Reset()
    {
        me->SetLevitate(true);
        me->SetSpeed(MOVE_FLIGHT, 1.5);
        me->GetMotionMaster()->MovePath(MADRIGOSA_PATH, true);
        RandYell_timer = urand(15000, 25000);
    }

    void UpdateAI(const uint32 diff)
    {
        // taunting and casting TODO
    }
};

CreatureAI* GetAI_npc_ioqd_madrigosa(Creature* _Creature)
{
    return new npc_ioqd_madrigosaAI(_Creature);
}

void AddSC_isle_of_queldanas()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_archmage_nethul";
    newscript->pGossipHello = &GossipHello_npc_archmage_nethul;
    newscript->pGossipSelect = &GossipSelect_npc_archmage_nethul;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_ayren_cloudbreaker";
    newscript->pGossipHello = &GossipHello_npc_ayren_cloudbreaker;
    newscript->pGossipSelect = &GossipSelect_npc_ayren_cloudbreaker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_wretched_devourer";
    newscript->GetAI = &GetAI_npc_wretched_devourer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_wretched_fiend";
    newscript->GetAI = &GetAI_npc_wretched_fiend;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_erratic_sentry";
    newscript->GetAI = &GetAI_npc_erratic_sentry;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_sunblade_lookout";
    newscript->GetAI = &GetAI_npc_sunblade_lookout;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_wrath_enforcer";
    newscript->GetAI = &GetAI_npc_wrath_enforcer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_flame_wave";
    newscript->GetAI = &GetAI_npc_flame_wave;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_pit_overlord";
    newscript->GetAI = &GetAI_npc_pit_overlord;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_eredar_sorcerer";
    newscript->GetAI = &GetAI_npc_eredar_sorcerer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_shattered_sun_bombardier";
    newscript->GetAI = &GetAI_npc_shattered_sun_bombardierAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_unrestrained_dragonhawk";
    newscript->pGossipHello = &GossipHello_npc_unrestrained_dragonhawk;
    newscript->pGossipSelect = &GossipSelect_npc_unrestrained_dragonhawk;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_greengill_slave";
    newscript->GetAI = &GetAI_npc_greengill_slaveAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_ioqd_brutallus";
    newscript->GetAI = &GetAI_npc_ioqd_brutallus;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_ioqd_madrigosa";
    newscript->GetAI = &GetAI_npc_ioqd_madrigosa;
    newscript->RegisterSelf();
}
