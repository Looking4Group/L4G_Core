/*
 * Copyright (C) 2005-2008 MaNGOS <http://www.mangosproject.org/>
 *
 * Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
 *
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

#ifndef LOOKING4GROUP_PLAYERAI_H
#define LOOKING4GROUP_PLAYERAI_H

#include "UnitAI.h"
#include "Player.h"
#include "SpellMgr.h"

struct PlayerAI : public UnitAI
{
    PlayerAI(Player *pPlayer) : UnitAI((Unit *)pPlayer), me(pPlayer) {}

    bool UpdateVictim(float = /*20.0*/100.0f);   // test more range for Felmyst, if no problems, should stay
    virtual void OnCharmed(bool){}

    protected:
        Player *me;
};

#define THUNDERCLAP_R1        6343
#define BLOODRAGE            2687
#define DEMORALIZING_R1        1160

struct WarriorAI: public PlayerAI
{
    WarriorAI(Player *pPlayer): PlayerAI(pPlayer) {}

void Reset()
    {
        TCSpell = SpellMgr::GetHighestSpellRankForPlayer(THUNDERCLAP_R1, me);
        BloodrageSpell = SpellMgr::GetHighestSpellRankForPlayer(BLOODRAGE, me);
        DemoSpell = SpellMgr::GetHighestSpellRankForPlayer(DEMORALIZING_R1, me);

        TC_Timer = 3000+urand(0, 10000);
        Bloodrage_Timer = 3000+urand(0, 10000);
        Demo_Timer = 3000+urand(0, 10000);
    }

    void UpdateAI(const uint32 diff);

    uint32 TC_Timer;
    SpellEntry const *TCSpell;

    uint32 Bloodrage_Timer;
    SpellEntry const *BloodrageSpell;

    uint32 Demo_Timer;
    SpellEntry const *DemoSpell;
};

#define STEADY_R1        34120
#define ARCANE_R1        3044
#define MULTI_R1        2643
#define VOLLEY_R1        1510
#define RAPIDFIRE        3045
#define BESTIAL            19574
#define AUTO            75

struct HunterAI: public PlayerAI
{
    HunterAI(Player *pPlayer): PlayerAI(pPlayer) {}

void Reset()
    {
        SteadySpell = SpellMgr::GetHighestSpellRankForPlayer(STEADY_R1, me);
        ArcaneSpell = SpellMgr::GetHighestSpellRankForPlayer(ARCANE_R1, me);
        MultiSpell = SpellMgr::GetHighestSpellRankForPlayer(MULTI_R1, me);
        VolleySpell = SpellMgr::GetHighestSpellRankForPlayer(VOLLEY_R1, me);
        RapidSpell = SpellMgr::GetHighestSpellRankForPlayer(RAPIDFIRE, me);
        AutoSpell = SpellMgr::GetHighestSpellRankForPlayer(AUTO, me);
        if (!(BestialSpell = SpellMgr::GetHighestSpellRankForPlayer(BESTIAL, me)))
            bestial = false;

        Steady_Timer = 1000+urand(0, 4000);
        Arcane_Timer = 1000+urand(0, 6000);
        Multi_Timer = 1000+urand(0, 7000);
        Volley_Timer = 1000+urand(0, 10000);
        Rapid_Timer = urand(0, 20000);
        Bestial_Timer = urand(0, 20000);
        Auto_Timer=500;
    }

    void UpdateAI(const uint32 diff);
    bool bestial;

    uint32 Steady_Timer;
    SpellEntry const *SteadySpell;

    uint32 Arcane_Timer;
    SpellEntry const *ArcaneSpell;

    uint32 Multi_Timer;
    SpellEntry const *MultiSpell;

    uint32 Volley_Timer;
    SpellEntry const *VolleySpell;

    uint32 Rapid_Timer;
    SpellEntry const *RapidSpell;

    uint32 Bestial_Timer;
    SpellEntry const *BestialSpell;

    uint32 Auto_Timer;
    SpellEntry const *AutoSpell;
};

#define AVENGING            31884
#define CRUSADER_R1         35395
#define CONSECRATION_R1     26573
#define JUDGEMENT           20271
#define HOLY_SHOCK_R1       20473
#define FLASH_LIGHT_R1      19750

struct PaladinAI: public PlayerAI
{
    PaladinAI(Player *pPlayer): PlayerAI(pPlayer) {}

void Reset()
    {
        AvengingSpell = SpellMgr::GetHighestSpellRankForPlayer(AVENGING, me);
        if (!(CrusaderSpell = SpellMgr::GetHighestSpellRankForPlayer(CRUSADER_R1, me)))
            crusader=false;
        ConsecrationSpell = SpellMgr::GetHighestSpellRankForPlayer(CONSECRATION_R1, me);
        JudgementSpell = SpellMgr::GetHighestSpellRankForPlayer(JUDGEMENT, me);
        if (!(ShockSpell = SpellMgr::GetHighestSpellRankForPlayer(HOLY_SHOCK_R1, me)))
            shock=false;
        FlashSpell = SpellMgr::GetHighestSpellRankForPlayer(FLASH_LIGHT_R1, me);

        Avenging_Timer = urand (0, 35000);
        Crusader_Timer = 1000+urand(0, 6000);
        Consecration_Timer = 1000+urand(0, 8000);
        Judgement_Timer = 1000+urand(0, 4000);
        Shock_Timer = 1000+urand(0, 12000);
        Flash_Timer = 1000+urand(0, 6000);
    }

    void UpdateAI(const uint32 diff);
    bool crusader;
    bool shock;

    uint32 Avenging_Timer;
    SpellEntry const *AvengingSpell;

    uint32 Crusader_Timer;
    SpellEntry const *CrusaderSpell;

    uint32 Consecration_Timer;
    SpellEntry const *ConsecrationSpell;

    uint32 Judgement_Timer;
    SpellEntry const *JudgementSpell;

    uint32 Shock_Timer;
    SpellEntry const *ShockSpell;

    uint32 Flash_Timer;
    SpellEntry const *FlashSpell;
};

#define RAINOFFIRE_R1   5740
#define SHADOWFURY_R1   30283
#define SHADOWBOLT_R1   686
#define INCINERATE_R1   29722
#define CORRUPTION_R1   172
#define UNSTABLEAFF_R1  30108
#define IMMOLATE_R1     348
#define HOWLOFTERROR_R1 5484


struct WarlockAI: public PlayerAI
{
    WarlockAI(Player *pPlayer): PlayerAI(pPlayer) {}

    void Reset()
    {
        if (!(AOESpell = SpellMgr::GetHighestSpellRankForPlayer(SHADOWFURY_R1, me)))
            AOESpell = SpellMgr::GetHighestSpellRankForPlayer(RAINOFFIRE_R1, me);

        bool fire = me->SpellBaseDamageBonus(SPELL_SCHOOL_MASK_FIRE) > me->SpellBaseDamageBonus(SPELL_SCHOOL_MASK_SHADOW);

        DOTSpell = NULL;
        if (!(DOTSpell = SpellMgr::GetHighestSpellRankForPlayer(UNSTABLEAFF_R1, me)))
        {
            if (fire)
                DOTSpell = SpellMgr::GetHighestSpellRankForPlayer(IMMOLATE_R1, me);
            if (!DOTSpell)
                DOTSpell = SpellMgr::GetHighestSpellRankForPlayer(CORRUPTION_R1, me);
        }

        FearSpell = SpellMgr::GetHighestSpellRankForPlayer(HOWLOFTERROR_R1, me);

        NormalSpell = NULL;
        if (fire)
            NormalSpell = SpellMgr::GetHighestSpellRankForPlayer(INCINERATE_R1, me);
        if (!NormalSpell)
            NormalSpell = SpellMgr::GetHighestSpellRankForPlayer(SHADOWBOLT_R1, me);

        AOE_Timer = 5000;
        Fear_Timer = 3000;
        DOT_Timer = 1500;
        NormalSpell_Timer = 3500;

    }

    void UpdateAI(const uint32 diff);

    uint32 AOE_Timer;
    SpellEntry const *AOESpell;

    uint32 DOT_Timer;
    SpellEntry const *DOTSpell;

    uint32 Fear_Timer;
    SpellEntry const *FearSpell;

    uint32 NormalSpell_Timer;
    SpellEntry const *NormalSpell;
};

#define DIREBEAR            9635
#define CAT                    3025
#define MOONKIN                24905
#define TREE                33891
#define MANGLE_C_R1            33876
#define MANGLE_B_R1            33878
#define DEMOROAR_R1            99
#define REJUVENATION_R1        774
#define LIFEBLOOM            33763
#define REGROWTH_R1            8936
#define MOONFIRE_R1            8921
#define WRATH_R1            5176
#define STARFIRE_R1            2912
#define HURRICANE_R1        16914


struct DruidAI: public PlayerAI
{
    DruidAI(Player *pPlayer): PlayerAI(pPlayer) {}

    void Reset()
    {
        if (!(MangleBSpell = SpellMgr::GetHighestSpellRankForPlayer(MANGLE_B_R1, me)))
                    feral=false;

        DemoSpell = SpellMgr::GetHighestSpellRankForPlayer(DEMOROAR_R1, me);
        MangleBSpell = SpellMgr::GetHighestSpellRankForPlayer(MANGLE_B_R1, me);
        MangleCSpell = SpellMgr::GetHighestSpellRankForPlayer(MANGLE_C_R1, me);
        Heal1Spell = SpellMgr::GetHighestSpellRankForPlayer(REJUVENATION_R1, me);
        Heal2Spell = SpellMgr::GetHighestSpellRankForPlayer(LIFEBLOOM, me);
        Heal3Spell = SpellMgr::GetHighestSpellRankForPlayer(REGROWTH_R1, me);
        Dmg1Spell = SpellMgr::GetHighestSpellRankForPlayer(WRATH_R1, me);
        Dmg2Spell = SpellMgr::GetHighestSpellRankForPlayer(STARFIRE_R1, me);
        Dmg3Spell = SpellMgr::GetHighestSpellRankForPlayer(MOONFIRE_R1, me);
        HurricaneSpell = SpellMgr::GetHighestSpellRankForPlayer(TREE, me);

        Demo_Timer = 500;
        MangleB_Timer = 1000;
        MangleC_Timer = 1000;
        Heal_Timer = 3000;
        Dmg_Timer = 2000;
        Hurricane_Timer = 15000;

    }

    void UpdateAI(const uint32 diff);

    bool feral;

    uint32 Demo_Timer;
    SpellEntry const *DemoSpell;

    uint32 MangleB_Timer;
    SpellEntry const *MangleBSpell;

    uint32 MangleC_Timer;
    SpellEntry const *MangleCSpell;

    uint32 Heal_Timer;
    SpellEntry const *Heal1Spell;
    SpellEntry const *Heal2Spell;
    SpellEntry const *Heal3Spell;

    uint32 Dmg_Timer;
    SpellEntry const *Dmg1Spell;
    SpellEntry const *Dmg2Spell;
    SpellEntry const *Dmg3Spell;

    uint32 Hurricane_Timer;
    SpellEntry const *HurricaneSpell;

};

#define BLADE_FLURRY    13877
#define GOUGE_R1        1776
#define SINISTER_R1        1752

struct RogueAI: public PlayerAI
{
    RogueAI(Player *pPlayer): PlayerAI(pPlayer) {}

void Reset()
    {
        if (!(FlurrySpell = SpellMgr::GetHighestSpellRankForPlayer(BLADE_FLURRY, me)))
            blade=false;
        GougeSpell = SpellMgr::GetHighestSpellRankForPlayer(GOUGE_R1, me);
        SinisterSpell = SpellMgr::GetHighestSpellRankForPlayer(SINISTER_R1, me);

        Flurry_Timer = 3000+urand(0, 30000);
        Gouge_Timer = 3000+urand(0, 10000);
        Sinister_Timer = 2000+urand(0, 3000);
    }

    void UpdateAI(const uint32 diff);

    bool blade;
    uint32 Flurry_Timer;
    SpellEntry const *FlurrySpell;

    uint32 Gouge_Timer;
    SpellEntry const *GougeSpell;

    uint32 Sinister_Timer;
    SpellEntry const *SinisterSpell;

};

#define BL                  2825
#define HERO                32182
#define LIGHTNING_SHIELD_R1 324
#define WATER_SHIELD_R1     24398
#define EARTH_SHIELD_R1     974
#define CHAIN_HEAL_R1       1064
#define CHAIN_LIGHTNING_R1  421

struct ShamanAI: public PlayerAI
{
    ShamanAI(Player *pPlayer): PlayerAI(pPlayer) {}

    void Reset()
    {
        if (Totem = SpellMgr::GetHighestSpellRankForPlayer(30706, me))
            ShieldSpell = SpellMgr::GetHighestSpellRankForPlayer(WATER_SHIELD_R1, me);
        else if (ShieldSpell = SpellMgr::GetHighestSpellRankForPlayer(EARTH_SHIELD_R1, me))
            heal = true;
        else
            ShieldSpell = SpellMgr::GetHighestSpellRankForPlayer(LIGHTNING_SHIELD_R1, me);

        HealSpell = SpellMgr::GetHighestSpellRankForPlayer(CHAIN_HEAL_R1, me);
        LightningSpell = SpellMgr::GetHighestSpellRankForPlayer(CHAIN_LIGHTNING_R1, me);

        if (!(BLSpell = SpellMgr::GetHighestSpellRankForPlayer(BL, me)))
            BLSpell = SpellMgr::GetHighestSpellRankForPlayer(HERO, me);

        Shield_Timer = 10000;
        Heal_Timer = 15000;
        BL_Timer = 500;
        Lightning_Timer = 17000;
    }

    bool heal;

    uint32 Totem_Timer;
    SpellEntry const *Totem;

    uint32 Shield_Timer;
    SpellEntry const *ShieldSpell;

    uint32 Heal_Timer;
    SpellEntry const *HealSpell;

    uint32 BL_Timer;
    SpellEntry const *BLSpell;

    uint32 Lightning_Timer;
    SpellEntry const *LightningSpell;


    void UpdateAI(const uint32 diff);
};

#define MINDBLAST_R1    8092
#define VAMPIRIC        15286
#define MINDFLY_R1        15407
#define SMITE_R1        585
#define FLASH_R1        2061
#define NOVA_R1            15237
#define HOLY_FIRE_R1    14914
#define PW_SHIELD_R1    17

struct PriestAI: public PlayerAI
{
    PriestAI(Player *pPlayer): PlayerAI(pPlayer) {}

    void Reset()
    {
        if (VampiricSpell = SpellMgr::GetHighestSpellRankForPlayer(VAMPIRIC, me))
            vampiric = true;

        if (!(DOTSpell = SpellMgr::GetHighestSpellRankForPlayer(MINDFLY_R1, me)))
            DOTSpell = SpellMgr::GetHighestSpellRankForPlayer(HOLY_FIRE_R1, me);

        DmgSpell = SpellMgr::GetHighestSpellRankForPlayer(SMITE_R1, me);
        if (vampiric == true)
            DmgSpell = SpellMgr::GetHighestSpellRankForPlayer(MINDBLAST_R1, me);

        FlashSpell = SpellMgr::GetHighestSpellRankForPlayer(FLASH_R1, me);

        if (NovaSpell = SpellMgr::GetHighestSpellRankForPlayer(NOVA_R1, me))
            holynova = true;

        PWShieldSpell = SpellMgr::GetHighestSpellRankForPlayer(PW_SHIELD_R1, me);

        Vampiric_Timer = 500;
        DmgSpell_Timer = 1500;
        Flash_Timer = 0;
        Nova_Timer = 500;
        DOTSpell_Timer = 4000;
        PWShield_Timer = 2000;
    }

    bool vampiric;
    bool holynova;

    uint32 Vampiric_Timer;
    SpellEntry const *VampiricSpell;

    uint32 DmgSpell_Timer;
    SpellEntry const *DmgSpell;

    uint32 Flash_Timer;
    SpellEntry const *FlashSpell;

    uint32 Nova_Timer;
    SpellEntry const *NovaSpell;

    uint32 DOTSpell_Timer;
    SpellEntry const *DOTSpell;

    uint32 PWShield_Timer;
    SpellEntry const *PWShieldSpell;

    void UpdateAI(const uint32 diff);
};

#define BLIZZARD_R1     10
#define CONEOFCOLD_R1   120
#define DRAGONBREATH_R1 31661
#define BLASTWAVE_R1    11113
#define ARCANEEXPLO_R1  1449
#define FIREBALL_R1     133
#define FROSTBOLT_R1    116
#define EVOCATION       12051
#define FLAMESTRIKE_R1  2120

struct MageAI: public PlayerAI
{
    MageAI(Player *plr): PlayerAI(plr) {}

    void Reset()
    {
        bool FireMage = me->SpellBaseDamageBonus(SPELL_SCHOOL_MASK_FIRE) > me->SpellBaseDamageBonus(SPELL_SCHOOL_MASK_FROST);
        bool Special = false;

        if (FireMage)
            MassiveAOESpell = SpellMgr::GetHighestSpellRankForPlayer(FLAMESTRIKE_R1, me);
        else
            MassiveAOESpell = SpellMgr::GetHighestSpellRankForPlayer(BLIZZARD_R1, me);

        if (!(ConeSpell = SpellMgr::GetHighestSpellRankForPlayer(DRAGONBREATH_R1, me)))
            ConeSpell = SpellMgr::GetHighestSpellRankForPlayer(CONEOFCOLD_R1, me);

        if (!(AOESpell = SpellMgr::GetHighestSpellRankForPlayer(BLASTWAVE_R1, me)))
            AOESpell = SpellMgr::GetHighestSpellRankForPlayer(ARCANEEXPLO_R1, me);

        ConeSpell_Timer = 5000;
        MassiveAOE_Timer = 10000;
        AOESpell_Timer = 2000;

        if (FireMage)
            NormalSpell = SpellMgr::GetHighestSpellRankForPlayer(FIREBALL_R1, me);
        else
            NormalSpell = SpellMgr::GetHighestSpellRankForPlayer(FROSTBOLT_R1, me);

        SpecialSpell = SpellMgr::GetHighestSpellRankForPlayer(EVOCATION, me);

        NormalSpell_Timer = 3200;
    }

    uint32 MassiveAOE_Timer;
    SpellEntry const *MassiveAOESpell;

    uint32 ConeSpell_Timer;
    SpellEntry const *ConeSpell;

    uint32 AOESpell_Timer;
    SpellEntry const *AOESpell;

    uint32 NormalSpell_Timer;
    SpellEntry const *NormalSpell;

    bool Special;
    SpellEntry const *SpecialSpell;

    void UpdateAI(const uint32 diff);
};

#endif
