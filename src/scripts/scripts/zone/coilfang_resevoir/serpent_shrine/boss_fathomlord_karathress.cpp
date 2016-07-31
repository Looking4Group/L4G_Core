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
SDName: Boss_Fathomlord_Karathress
SD%Complete: 70
SDComment: Cyclone workaround, Sharkkis missing Spell 38374, Tidalvess might have false WF Spell
SDCategory: Coilfang Resevoir, Serpent Shrine Cavern
EndScriptData */

#include "precompiled.h"
#include "def_serpent_shrine.h"
#include "escort_ai.h"

#define SAY_AGGRO                   -1548021
#define SAY_GAIN_BLESSING           -1548022
#define SAY_SLAY1                   -1548026
#define SAY_SLAY2                   -1548027
#define SAY_SLAY3                   -1548028
#define SAY_DEATH                   -1548029

//Karathress spells
#define SPELL_CATACLYSMIC_BOLT          38441
#define SPELL_ENRAGE                    35595
#define SPELL_SEAR_NOVA                 38445
#define SPELL_BLESSING_OF_THE_TIDES     38449

//Sharkkis spells
#define SPELL_LEECHING_THROW            29436
#define SPELL_THE_BEAST_WITHIN          38373
#define SPELL_MULTISHOT                 38366
#define SPELL_SUMMON_FATHOM_LURKER      38433
#define SPELL_SUMMON_FATHOM_SPOREBAT    38431
#define SPELL_PET_ENRAGE                38371

//Tidalvess spells
#define SPELL_FROST_SHOCK               38234
#define SPELL_SPITFIRE_TOTEM            38236
#define SPELL_POISON_CLEANSING_TOTEM    38306
#define SPELL_POISON_CLEANSING_EFFECT   8167
#define SPELL_EARTHBIND_TOTEM           38304
#define SPELL_EARTHBIND_TOTEM_EFFECT    6474
#define SPELL_WINDFURY_WEAPON           38184 // 32911

//Caribdis Spells
#define SPELL_WATER_BOLT_VOLLEY         38335
#define SPELL_TIDAL_SURGE               38358
#define SPELL_TIDAL_SURGE_FREEZE        38357
#define SPELL_HEAL                      38330
#define SPELL_SUMMON_CYCLONE            38337
#define SPELL_CYCLONE_CYCLONE           29538
#define SPELL_INCREASE_CAST_SPEED       39261

//Yells and Quotes
#define SAY_GAIN_BLESSING_OF_TIDES      "Your overconfidence will be your undoing! Guards, lend me your strength!"
#define SOUND_GAIN_BLESSING_OF_TIDES    11278
#define SAY_MISC                        "Alana be'lendor!" //don't know what use this
#define SOUND_MISC                      11283

//Summoned Unit GUIDs
#define CREATURE_CYCLONE                22104
#define CREATURE_SPITFIRE_TOTEM         22091
#define CREATURE_EARTHBIND_TOTEM        22486
#define CREATURE_POISON_CLEANSING_TOTEM 22487

//entry and position for Seer Olum
#define SEER_OLUM                  22820
#define OLUM_X                     446.78f
#define OLUM_Y                     -542.76f
#define OLUM_Z                     -7.54773f
#define OLUM_O                     0.401581f

const uint32 SpellID[2] =
{
    38433,     // summon Sporebat
    38431      // summon Lurker
};
const uint32 PetID[2] =
{
    22120,     // Sporebat entry
    22119      // Lurker entry
};
const int32 AbilityTEXT[3] = { -1548023, -1548024, -1548025 }; // text on ability gain
const uint32 Ability[3]  =
{
    38455,    // Power of Sharkkis
    38452,    // Power of Tidalvess
    38451     // Power of Caribdis
};

//Fathom-Lord Karathress AI
struct boss_fathomlord_karathressAI : public ScriptedAI
{
    boss_fathomlord_karathressAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        m_creature->GetPosition(wLoc);

        for(int i=0; i<3; ++i)
            Advisors[i] = 0;

    }

    ScriptedInstance* pInstance;

    uint32 PulseCombat_Timer;
    uint32 CataclysmicBolt_Timer;
    uint32 Enrage_Timer;
    uint32 SearNova_Timer;
    bool ExtraAbility[3];

    uint32 TidalSurge_Timer;
    uint32 AuraCheck_Timer;

    bool BlessingOfTides;
    uint8 BlessingOfTidesCounter;

    WorldLocation wLoc;

    uint64 Advisors[3];

    void Reset()
    {
        PulseCombat_Timer = 5000;
        CataclysmicBolt_Timer = 10000;
        Enrage_Timer = 600000;                 // 10 minutes
        SearNova_Timer = urand(20000, 30000);
        AuraCheck_Timer = 3000;
        TidalSurge_Timer = 15000+rand()%5000;

        BlessingOfTides = false;
        BlessingOfTidesCounter = 0;

        if(pInstance)
        {
            uint64 RAdvisors[3];

            if(Creature *sharkkisPet = Unit::GetCreature(*m_creature, pInstance->GetData64(DATA_SHARKKIS_PET)))
                m_creature->Kill(sharkkisPet,false);

            RAdvisors[0] = pInstance->GetData64(DATA_SHARKKIS);
            RAdvisors[1] = pInstance->GetData64(DATA_TIDALVESS);
            RAdvisors[2] = pInstance->GetData64(DATA_CARIBDIS);

            // Don't respawn adds if encounter is done
            if(pInstance->GetData(DATA_KARATHRESSEVENT) == DONE)
            {
                m_creature->SummonCreature(SEER_OLUM, OLUM_X, OLUM_Y, OLUM_Z, OLUM_O, TEMPSUMMON_MANUAL_DESPAWN, 0);
                return;
            }

            //Respawn of the 3 Advisors
            Creature* pAdvisor = NULL;
            for( int i=0; i<3; i++ ){

                ExtraAbility[i] = false;

                if(RAdvisors[i])
                {
                    pAdvisor = (Unit::GetCreature((*m_creature), RAdvisors[i]));
                    if(pAdvisor && !pAdvisor->isAlive())
                    {
                        pAdvisor->Respawn();
                        pAdvisor->AI()->EnterEvadeMode();
                        pAdvisor->GetMotionMaster()->MoveTargetedHome();
                    }
                }
            }
            pInstance->SetData(DATA_KARATHRESSEVENT, NOT_STARTED);
        }
    }

    void EventAdvisorDeath(int adv)
    {
        DoScriptText(AbilityTEXT[adv], m_creature);
        DoCast(m_creature,Ability[adv]);
        ExtraAbility[adv] = true;
    }
    void JustSummoned(Creature *Totem)
    {
        if(Totem && Totem->GetEntry() == CREATURE_SPITFIRE_TOTEM){
           ((Creature*)Totem)->AI()->AttackStart( m_creature->getVictim() );
        }
    }
    void GetAdvisors()
    {
        if (!pInstance)
            return;

        Advisors[0] = pInstance->GetData64(DATA_SHARKKIS);
        Advisors[1] = pInstance->GetData64(DATA_TIDALVESS);
        Advisors[2] = pInstance->GetData64(DATA_CARIBDIS);
    }

    void StartEvent(Unit *who)
    {
        if (!pInstance)
            return;

        GetAdvisors();

        DoScriptText(SAY_AGGRO, m_creature);
        DoZoneInCombat();

        pInstance->SetData64(DATA_KARATHRESSEVENT_STARTER, who->GetGUID());
        pInstance->SetData(DATA_KARATHRESSEVENT, IN_PROGRESS);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2, SAY_SLAY3), m_creature);
    }

    void JustDied(Unit *killer)
    {
        DoScriptText(SAY_DEATH, m_creature);

        if(pInstance)
            pInstance->SetData(DATA_KARATHRESSEVENT, DONE);

        //support for quest 10944
        m_creature->SummonCreature(SEER_OLUM, OLUM_X, OLUM_Y, OLUM_Z, OLUM_O, TEMPSUMMON_TIMED_DESPAWN, 3600000);
    }

    void EnterCombat(Unit *who)
    {
        StartEvent(who);
    }

    void UpdateAI(const uint32 diff)
    {
        //Only if not incombat check if the event is started
        if (!m_creature->isInCombat() && pInstance && pInstance->GetData(DATA_KARATHRESSEVENT))
        {
            Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_KARATHRESSEVENT_STARTER));

            if (target)
            {
                AttackStart(target);
                GetAdvisors();
            }
        }

        //Return since we have no target
        if (!UpdateVictim() )
            return;

        //someone evaded!
        if (pInstance && !pInstance->GetData(DATA_KARATHRESSEVENT))
        {
            EnterEvadeMode();
            return;
        }

        //Aura Check
        if(AuraCheck_Timer < diff)
        {
            if(!m_creature->IsWithinDistInMap(&wLoc, 135.0f))
                EnterEvadeMode();
            else
                DoZoneInCombat();

            for(int i=0;i<3;i++)
            {
                if(ExtraAbility[i] && !m_creature->HasAura(Ability[i],0))
                    m_creature->AddAura(Ability[i],m_creature);
            }

            AuraCheck_Timer = 3000;
        }
        else
            AuraCheck_Timer -= diff;

        //TidalSurge_Timer
        if(ExtraAbility[2])
        {
            if (TidalSurge_Timer < diff)
            {
                Unit *who = SelectUnit(SELECT_TARGET_RANDOM, 0, GetSpellMaxRange(SPELL_TIDAL_SURGE), true, m_creature->getVictimGUID());

                if(who && who->isAlive())
                {
                    DoCast(who, SPELL_TIDAL_SURGE);
                    who->CastSpell( who, SPELL_TIDAL_SURGE_FREEZE, true );
                }

                TidalSurge_Timer = 15000+rand()%5000;
            }
            else
                TidalSurge_Timer -= diff;
        }

        //CataclysmicBolt_Timer
        if(CataclysmicBolt_Timer < diff)
        {
            //if there aren't other units, cast on the tank
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, GetSpellMaxRange(SPELL_CATACLYSMIC_BOLT), true, m_creature->getVictimGUID()))
                DoCast(target, SPELL_CATACLYSMIC_BOLT);
            else
                DoCast(m_creature->getVictim(), SPELL_CATACLYSMIC_BOLT);

            CataclysmicBolt_Timer = 10000;
        }
        else
            CataclysmicBolt_Timer -= diff;

        //SearNova_Timer
        if(SearNova_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_SEAR_NOVA);
            SearNova_Timer = urand(20000, 30000);
        }
        else
            SearNova_Timer -= diff;

        //Enrage_Timer
        if(Enrage_Timer < diff)
        {
            DoCast(m_creature, SPELL_ENRAGE);
            Enrage_Timer = 600000;
        }
        else
            Enrage_Timer -= diff;

        //Blessing of Tides Trigger
        if((m_creature->GetHealth()*100 / m_creature->GetMaxHealth()) <= 75 && !BlessingOfTides)
        {
            BlessingOfTides = true;
            BlessingOfTidesCounter = 0;
            bool continueTriggering = false;
            Creature* Advisor;
            for(uint8 i = 0; i < 3; ++i)
            {
                if(Advisors[i])
                {
                    Advisor = (Creature*)Unit::GetUnit(*m_creature,Advisors[i]);
                    if(Advisor && Advisor->isAlive())
                        BlessingOfTidesCounter++;
                }
            }

            if(BlessingOfTidesCounter)
            {
                DoYell(SAY_GAIN_BLESSING_OF_TIDES, LANG_UNIVERSAL, NULL);
                DoPlaySoundToSet(m_creature, SOUND_GAIN_BLESSING_OF_TIDES);
            }
        }

        if(BlessingOfTides && BlessingOfTidesCounter)
        {
            m_creature->CastSpell(m_creature, SPELL_BLESSING_OF_THE_TIDES,true);
            BlessingOfTidesCounter--;
        }

        DoMeleeAttackIfReady();
    }
};

//Fathom-Guard Sharkkis AI
struct boss_fathomguard_sharkkisAI : public ScriptedAI
{
    boss_fathomguard_sharkkisAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 LeechingThrow_Timer;
    uint32 TheBeastWithin_Timer;
    uint32 Multishot_Timer;
    uint32 Pet_Timer;

    bool pet;

    void Reset()
    {
        LeechingThrow_Timer = 20000;
        TheBeastWithin_Timer = 30000;
        Multishot_Timer = urand(7000, 11000);
        Pet_Timer = 10000;

        pet = false;
    }

    void JustSummoned(Creature *Pet)
    {
        if(Pet && (Pet->GetEntry() == PetID[0] || Pet->GetEntry() == PetID[1]))
        {
            Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0);
            if (Pet && target)
            {
                Pet->AI()->AttackStart(target);
                if(pInstance)
                    pInstance->SetData64(DATA_SHARKKIS_PET,Pet->GetGUID());
            }
        }
    }

    void JustDied(Unit *victim)
    {
        if (pInstance)
        {
            Creature *Karathress = NULL;
            Karathress = Unit::GetCreature((*m_creature), pInstance->GetData64(DATA_KARATHRESS));

            if (Karathress && Karathress->isAlive())
                ((boss_fathomlord_karathressAI*)Karathress->AI())->EventAdvisorDeath(0);
       }
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance)
            pInstance->SetData64(DATA_KARATHRESSEVENT_STARTER, who->GetGUID());
    }

    void UpdateAI(const uint32 diff)
    {
        //Only if not incombat check if the event is started
        if (!m_creature->isInCombat() && pInstance && pInstance->GetData(DATA_KARATHRESSEVENT))
        {
            if(Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_KARATHRESSEVENT_STARTER)))
                AttackStart(target);
        }

        //Return since we have no target
        if (!UpdateVictim() )
            return;

        //someone evaded!
        if (pInstance && !pInstance->GetData(DATA_KARATHRESSEVENT))
        {
            EnterEvadeMode();
            return;
        }

        //LeechingThrow_Timer
        if(LeechingThrow_Timer < diff)
        {
            if(Unit *target = SelectUnit(SELECT_TARGET_RANDOM,0,GetSpellMaxRange(SPELL_LEECHING_THROW),true))
                DoCast(target, SPELL_LEECHING_THROW);

            LeechingThrow_Timer = 20000;
        }
        else
            LeechingThrow_Timer -= diff;

        //Multishot_Timer
        if(Multishot_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_MULTISHOT);
            Multishot_Timer = urand(7000, 12000);
        }
        else
            Multishot_Timer -= diff;

        //TheBeastWithin_Timer
        if(TheBeastWithin_Timer < diff)
        {
            DoCast(m_creature, SPELL_THE_BEAST_WITHIN);
            Creature *pet = Unit::GetCreature(*m_creature, pInstance->GetData64(DATA_SHARKKIS_PET));
            if(pet && pet->isAlive())
                pet->CastSpell(pet, SPELL_PET_ENRAGE, true );

            TheBeastWithin_Timer = 30000;
        }
        else
            TheBeastWithin_Timer -= diff;

        if(!pet)
        {
            if(Pet_Timer < diff)
            {
                pet = true;
//                me->Say("Summoning pet", 0, 0);
                DoCast(m_creature, SpellID[rand()%2], true);
            }
            else
                Pet_Timer -= diff;
        }

        DoMeleeAttackIfReady();
    }
};

//Fathom-Guard Tidalvess AI
struct boss_fathomguard_tidalvessAI : public ScriptedAI
{
    boss_fathomguard_tidalvessAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 FrostShock_Timer;
    uint32 Spitfire_Timer;
    uint32 PoisonCleansing_Timer;
    uint32 Earthbind_Timer;

    void Reset()
    {
        FrostShock_Timer = 25000;
        Spitfire_Timer = 60000;
        PoisonCleansing_Timer = 30000;
        Earthbind_Timer = 45000;
    }

    void JustDied(Unit *victim)
    {
        if(pInstance)
        {
            Creature *Karathress = Unit::GetCreature((*m_creature), pInstance->GetData64(DATA_KARATHRESS));

            if(Karathress && Karathress->isAlive())
                ((boss_fathomlord_karathressAI*)Karathress->AI())->EventAdvisorDeath(1);
        }
    }

    void EnterCombat(Unit *who)
    {
        if (pInstance)
            pInstance->SetData64(DATA_KARATHRESSEVENT_STARTER, who->GetGUID());

        DoCast(m_creature, SPELL_WINDFURY_WEAPON);
    }

    void UpdateAI(const uint32 diff)
    {
        //Only if not incombat check if the event is started
        if (!m_creature->isInCombat() && pInstance && pInstance->GetData(DATA_KARATHRESSEVENT))
        {
            if(Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_KARATHRESSEVENT_STARTER)))
                AttackStart(target);
        }

        //Return since we have no target
        if (!UpdateVictim() )
            return;

        //someone evaded!
        if(pInstance && !pInstance->GetData(DATA_KARATHRESSEVENT))
        {
            EnterEvadeMode();
            return;
        }

        if(!m_creature->HasAura(SPELL_WINDFURY_WEAPON, 0) )
            DoCast(m_creature, SPELL_WINDFURY_WEAPON);

        //FrostShock_Timer
        if (FrostShock_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_FROST_SHOCK);
            FrostShock_Timer = urand(25000, 30000);
        }
        else
            FrostShock_Timer -= diff;

        //Spitfire_Timer
        if(Spitfire_Timer < diff)
        {
            DoCast(m_creature, SPELL_SPITFIRE_TOTEM);
            Unit *SpitfireTotem = Unit::GetUnit( *m_creature, CREATURE_SPITFIRE_TOTEM );
            if( SpitfireTotem )
                ((Creature*)SpitfireTotem)->AI()->AttackStart( m_creature->getVictim() );

            Spitfire_Timer = 60000;
        }
        else
            Spitfire_Timer -= diff;

        //PoisonCleansing_Timer
        if(PoisonCleansing_Timer < diff)
        {
            DoCast(m_creature, SPELL_POISON_CLEANSING_TOTEM);
            PoisonCleansing_Timer = 30000;
        }
        else
            PoisonCleansing_Timer -= diff;

        //Earthbind_Timer
        if(Earthbind_Timer < diff)
        {
            DoCast(m_creature, SPELL_EARTHBIND_TOTEM);
            Earthbind_Timer = 45000;
        }
        else
            Earthbind_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

//Fathom-Guard Caribdis AI
struct boss_fathomguard_caribdisAI : public ScriptedAI
{
    boss_fathomguard_caribdisAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance* pInstance;

    uint32 WaterBoltVolley_Timer;
    uint32 TidalSurge_Timer;
    uint32 Heal_Timer;
    uint32 Cyclone_Timer;

    void Reset()
    {
        WaterBoltVolley_Timer = 35000;
        TidalSurge_Timer = 10000+rand()%5000;
        Heal_Timer = 15000+rand()%5000;
        Cyclone_Timer = 3000+rand()%10000;
    }

    Unit* selectAdvisorUnit()
    {
        Unit* pUnit = NULL;

        if(pInstance)
        {
            pUnit = RAND (Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_KARATHRESS)),
                          Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_SHARKKIS)),
                          Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_TIDALVESS)),
                          (Unit*)m_creature);
        }
        else
            pUnit = m_creature;

        return pUnit;
    }

    void JustDied(Unit *victim)
    {
        if(pInstance)
        {
            Creature *Karathress = Creature::GetCreature((*m_creature), pInstance->GetData64(DATA_KARATHRESS));
            if(Karathress && Karathress->isAlive())
                ((boss_fathomlord_karathressAI*)Karathress->AI())->EventAdvisorDeath(2);
        }
    }

    void EnterCombat(Unit *who)
    {
        if(pInstance)
            pInstance->SetData64(DATA_KARATHRESSEVENT_STARTER, who->GetGUID());
    }

    void UpdateAI(const uint32 diff)
    {
        //Only if not incombat check if the event is started
        if(pInstance && !m_creature->isInCombat() && pInstance->GetData(DATA_KARATHRESSEVENT))
        {
            if(Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_KARATHRESSEVENT_STARTER)))
                AttackStart(target);
        }

        //Return since we have no target
        if (!UpdateVictim() )
            return;

        //someone evaded!
        if(pInstance && !pInstance->GetData(DATA_KARATHRESSEVENT))
        {
            EnterEvadeMode();
            return;
        }

        //WaterBoltVolley_Timer
        if (WaterBoltVolley_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_WATER_BOLT_VOLLEY);
            WaterBoltVolley_Timer = 30000;
        }
        else
            WaterBoltVolley_Timer -= diff;

        //TidalSurge_Timer
        if(TidalSurge_Timer < diff)
        {
            if(Unit *target = m_creature->getVictim())
            {
                DoCast(target, SPELL_TIDAL_SURGE);
                target->CastSpell( target, SPELL_TIDAL_SURGE_FREEZE, true );
            }
            TidalSurge_Timer = 10000+rand()%5000;
        }
        else
            TidalSurge_Timer -= diff;

        //Cyclone_Timer
        if(Cyclone_Timer < diff)
        {
            //DoCast(m_creature, SPELL_SUMMON_CYCLONE); // Doesn't work
            Cyclone_Timer = 30000+rand()%10000;
            Creature *Cyclone = m_creature->SummonCreature(CREATURE_CYCLONE, m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), (rand()%5), TEMPSUMMON_TIMED_DESPAWN, 20000);
            if( Cyclone )
            {
                ((Creature*)Cyclone)->SetFloatValue(OBJECT_FIELD_SCALE_X, 3.0f);
                Cyclone->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                Cyclone->setFaction(m_creature->getFaction());
                Cyclone->CastSpell(Cyclone, 32332, true);
                Cyclone->CastSpell(Cyclone, 43120, false);
            }
        }
        else
            Cyclone_Timer -= diff;

        //Heal_Timer
        if(Heal_Timer < diff)
        {
            // It can be cast on any of the mobs
            Unit *pUnit = NULL;

            while( pUnit == NULL || !pUnit->isAlive() )
                pUnit = selectAdvisorUnit();

            if(pUnit && pUnit->isAlive())
                DoCast(pUnit, SPELL_HEAL);

            Heal_Timer = 15000+rand()%5000;
        }
        else
            Heal_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

struct mob_caribdis_cycloneAI : public ScriptedAI
{
    mob_caribdis_cycloneAI(Creature *c) : ScriptedAI(c) {}

    uint32 Check_Timer;
    uint32 Swap_Timer;

    void Reset()
    {
        Check_Timer = 1000;
        Swap_Timer = 0;
    }

    void EnterCombat(Unit *who)
    {
        AttackStart(who);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim() )
            return;

        if(Swap_Timer < diff)
        {
            if(Unit* target = SelectUnit(SELECT_TARGET_FARTHEST, 0, 100, true))
            {
                if(target)
                {
                    DoResetThreat();
                    m_creature->GetMotionMaster()->Clear();
                    m_creature->GetMotionMaster()->MovePoint(0,target->GetPositionX(),target->GetPositionY(),target->GetPositionZ());
                }
                Swap_Timer = 5000;
            }
        }
        else
            Swap_Timer -= diff;

        if(Check_Timer < diff)
        {
            Map* pMap = m_creature->GetMap();
            Map::PlayerList const &PlayerList = pMap->GetPlayers();
            if (!PlayerList.isEmpty())
            {
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                {
                    if(m_creature->IsWithinMeleeRange(i->getSource()))
                    {
                        Player *p = i->getSource();
                        if(!p->HasAura(SPELL_CYCLONE_CYCLONE, 0))
                        {
                            DoCast(p, SPELL_CYCLONE_CYCLONE);
                            DoCast(p, SPELL_INCREASE_CAST_SPEED);
                        }
                    }
                }
            }
            Check_Timer = 500;
        }
        else
            Check_Timer -= diff;
    }
};

CreatureAI* GetAI_boss_fathomlord_karathress(Creature *_Creature)
{
    return new boss_fathomlord_karathressAI (_Creature);
}

CreatureAI* GetAI_boss_fathomguard_sharkkis(Creature *_Creature)
{
    return new boss_fathomguard_sharkkisAI (_Creature);
}

CreatureAI* GetAI_boss_fathomguard_tidalvess(Creature *_Creature)
{
    return new boss_fathomguard_tidalvessAI (_Creature);
}

CreatureAI* GetAI_boss_fathomguard_caribdis(Creature *_Creature)
{
    return new boss_fathomguard_caribdisAI (_Creature);
}

CreatureAI* GetAI_mob_caribdis_cyclone(Creature *_Creature)
{
    return new mob_caribdis_cycloneAI (_Creature);
}

void AddSC_boss_fathomlord_karathress()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_fathomlord_karathress";
    newscript->GetAI = &GetAI_boss_fathomlord_karathress;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_fathomguard_sharkkis";
    newscript->GetAI = &GetAI_boss_fathomguard_sharkkis;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_fathomguard_tidalvess";
    newscript->GetAI = &GetAI_boss_fathomguard_tidalvess;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="boss_fathomguard_caribdis";
    newscript->GetAI = &GetAI_boss_fathomguard_caribdis;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_caribdis_cyclone";
    newscript->GetAI = &GetAI_mob_caribdis_cyclone;
    newscript->RegisterSelf();
}

