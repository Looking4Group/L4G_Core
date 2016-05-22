#include "PlayerAI.h"
#include "Player.h"
#include "DBCStores.h"
#include "SpellMgr.h"

class Player;
struct SpellEntry;

bool PlayerAI::UpdateVictim(float range)
{
    if (Unit *charmer = me->GetCharmer())
    {
        if (charmer->isAlive())
        {
            if (!me->getVictim() || !me->getVictim()->isAlive())
            {
                if (Unit *victim = me->SelectNearbyTarget(range))
                    AttackStart(victim);
                else
                    if (charmer->getVictim())
                        AttackStart(charmer->getVictim());
             }
        }
        else
        {
            me->RemoveCharmAuras();
            return false;
        }
    }
    else
    {
        me->RemoveCharmAuras();
        return false;
    }

    if (Unit *target = me->getVictim())
        me->SetInFront(target);

    return me->getVictim();
}

void WarriorAI::UpdateAI(const uint32 diff)
{
    if (!UpdateVictim())
        return;

    if (TC_Timer < diff)
    {
        if (CanCast(me->getVictim(), TCSpell, false))
        {
            me->CastSpell(me->getVictim(), TCSpell, false);
            TC_Timer = TCSpell->RecoveryTime ? TCSpell->RecoveryTime +diff : 10000;
        }
    }
    else
        TC_Timer -= diff;

    if (Bloodrage_Timer < diff)
    {
        if (CanCast(me, BloodrageSpell, false))
        {
            me->CastSpell(me, BloodrageSpell, false);
            Bloodrage_Timer = 60000;
        }
    }
    else
        Bloodrage_Timer -= diff;

    if (Demo_Timer < diff)
    {
        if (CanCast(me->getVictim(), DemoSpell, false))
        {
            me->CastSpell(me->getVictim(), DemoSpell, false);
            Demo_Timer = DemoSpell->RecoveryTime ? DemoSpell->RecoveryTime +diff : 12000;
        }
    }
    else
        Demo_Timer -= diff;
}

void HunterAI::UpdateAI(const uint32 diff)
{
    if (!UpdateVictim())
        return;

    if (Steady_Timer < diff)
    {
        if (CanCast(me->getVictim(), SteadySpell, false))
        {
            me->CastSpell(me->getVictim(), SteadySpell, false);
            Steady_Timer = 2000 + urand(0, 4000);
        }
    }
    else
        Steady_Timer -= diff;

    if (Arcane_Timer < diff)
    {
        if (CanCast(me->getVictim(), ArcaneSpell, false))
        {
            me->CastSpell(me->getVictim(), ArcaneSpell, false);
            Arcane_Timer = 6000+urand(0, 6000);
        }
    }
    else
        Arcane_Timer -= diff;

    if (Multi_Timer < diff)
    {
        if (CanCast(me->getVictim(), MultiSpell, false))
        {
            me->CastSpell(me->getVictim(), MultiSpell, false);
            Multi_Timer = MultiSpell->RecoveryTime ? MultiSpell->RecoveryTime +diff : 12000;
        }
    }
    else
        Multi_Timer -= diff;

    if (Volley_Timer < diff)
    {
        if (CanCast(me->getVictim(), VolleySpell, false))
        {
            me->CastSpell(me->getVictim(), VolleySpell, false);
            Volley_Timer = VolleySpell->RecoveryTime ? VolleySpell->RecoveryTime +diff : 10000;
        }
    }
    else
        Volley_Timer -= diff;

    if (Rapid_Timer < diff)
    {
        if (CanCast(me, RapidSpell, false))
        {
            me->CastSpell(me, RapidSpell, false);
            Rapid_Timer = 60000;
        }
    }
    else
        Rapid_Timer -= diff;

    if (Bestial_Timer < diff)
    {
        if (CanCast(me, BestialSpell, false))
        {
            me->CastSpell(me, BestialSpell, false);
            Bestial_Timer = 120000;
        }
    }
    else
        Bestial_Timer -= diff;

    if (Auto_Timer < diff)
    {
        if (CanCast(me->getVictim(), AutoSpell, false))
        {
            me->CastSpell(me->getVictim(), AutoSpell, false);
            Auto_Timer = 4000;
        }
    }
    else
        Auto_Timer -= diff;
}

void PaladinAI::UpdateAI(const uint32 diff)
{
    if (!UpdateVictim())
        return;

    if (Avenging_Timer < diff)
    {
        if (CanCast(me, AvengingSpell, false))
        {
            me->CastSpell(me, AvengingSpell, false);
            Avenging_Timer = 300000;
        }
    }
    else
        Avenging_Timer -= diff;

    if (crusader!=false && Crusader_Timer < diff)
    {
        if (CanCast(me->getVictim(), CrusaderSpell, false))
        {
            me->CastSpell(me->getVictim(), CrusaderSpell, false);
            Crusader_Timer = 6000+urand(0, 6000);
        }
    }
    else
        Crusader_Timer -= diff;

    if (Consecration_Timer < diff)
    {
        if (CanCast(me, ConsecrationSpell, false))
        {
            me->CastSpell(me, ConsecrationSpell, false);
            Consecration_Timer = ConsecrationSpell->RecoveryTime ? ConsecrationSpell->RecoveryTime +diff : 12000;
        }
    }
    else
        Consecration_Timer -= diff;

    if (Judgement_Timer < diff)
    {
        if (CanCast(me->getVictim(), JudgementSpell, false))
        {
            me->CastSpell(me->getVictim(), JudgementSpell, false);
            Judgement_Timer = JudgementSpell->RecoveryTime ? JudgementSpell->RecoveryTime +diff : 30000;
        }
    }
    else
        Judgement_Timer -= diff;

    if (shock!=false && Shock_Timer < diff)
    {
        if (CanCast(me->GetCharmer(), ShockSpell, false))
        {
            me->CastSpell(me->GetCharmer(), ShockSpell, false);
            Shock_Timer = 10000+urand(0, 10000);
        }
    }
    else
        Shock_Timer -= diff;

    if (Flash_Timer < diff)
    {
        if (CanCast(me->GetCharmer(), FlashSpell, false))
        {
            me->CastSpell(me->GetCharmer(), FlashSpell, false);
            Flash_Timer = urand(4000, 10000);
        }
    }
    else
        Flash_Timer -= diff;
}

void WarlockAI::UpdateAI(const uint32 diff)
{
    if (!UpdateVictim())
        return;


    if (Fear_Timer < diff)
    {
        if (CanCast(me, FearSpell, false))
        {
            me->CastSpell(me, FearSpell, false);
            Fear_Timer = FearSpell->RecoveryTime ? FearSpell->RecoveryTime +diff : 15000;
        }
    }
    else
        Fear_Timer -= diff;

    if (DOT_Timer < diff)
    {
        if (CanCast(me->getVictim(), DOTSpell, false))
        {
            me->CastSpell(me->getVictim(), DOTSpell, false);
            DOT_Timer = 15000;
        }
    }
    else
        DOT_Timer -= diff;

    if (AOE_Timer < diff)
    {
        if (CanCast(me->getVictim(), AOESpell, false))
        {
            me->CastSpell(me->getVictim(), AOESpell, false);
            AOE_Timer = AOESpell->RecoveryTime ? AOESpell->RecoveryTime +diff : 10000;
        }
    }
    else
        AOE_Timer -= diff;

    if (NormalSpell_Timer < diff)
    {
        if (CanCast(me->getVictim(), NormalSpell, false))
        {
            me->CastSpell(me->getVictim(), NormalSpell, false);
            NormalSpell_Timer = NormalSpell->RecoveryTime + diff;
        }
    }
    else
        NormalSpell_Timer -= diff;
}

void DruidAI::UpdateAI(const uint32 diff)
{
    if (!UpdateVictim())
        return;

    if (Heal_Timer < diff && me->HasAura(TREE, 0))
    {
        int heal=urand(0, 2);
        if (heal==0 && CanCast(me->GetCharmer(), Heal1Spell, false))
        {
            me->CastSpell(me->GetCharmer(), Heal1Spell, false);
            Heal_Timer = 9000;
        }
        else if (heal==1 && CanCast(me->GetCharmer(), Heal2Spell, false))
        {
            me->CastSpell(me->GetCharmer(), Heal2Spell, false);
            Heal_Timer = 6000;
        }
        else if (heal==2 && CanCast(me->GetCharmer(), Heal3Spell, false))
        {
            me->CastSpell(me->GetCharmer(), Heal3Spell, false);
            Heal_Timer = 12000;
        }
    }
    else
        Heal_Timer -= diff;

    if (Dmg_Timer < diff && me->HasAura(MOONKIN, 0))
    {
        int dmg=urand(0, 2);
        if (dmg==0 && CanCast(me->getVictim(), Dmg1Spell, false))
        {
            me->CastSpell(me->getVictim(), Dmg1Spell, false);
            Dmg_Timer = 3000 + urand(0, 2000);
        }
        else if (dmg==1 && CanCast(me->getVictim(), Dmg2Spell, false))
        {
            me->CastSpell(me->getVictim(), Dmg2Spell, false);
            Dmg_Timer = 3000 + urand(0, 3000);
        }
        else if (dmg==2 && CanCast(me->getVictim(), Dmg3Spell, false))
        {
            me->CastSpell(me->getVictim(), Dmg3Spell, false);
            Dmg_Timer = 3000 + urand(0, 2000);
        }
    }
    else
        Dmg_Timer -= diff;

    if (feral!=false && MangleB_Timer < diff && me->HasAura(DIREBEAR, 0))
    {
        if (CanCast(me->getVictim(), MangleBSpell, false))
            {
                me->CastSpell(me->getVictim(), MangleBSpell, false);
                MangleB_Timer = 7000;
            }
    }
    else 
        MangleB_Timer -= diff;

    if (feral!=false && Demo_Timer < diff && me->HasAura(DIREBEAR, 0))
    {
        if (CanCast(me, DemoSpell, false))
            {
                me->CastSpell(me, DemoSpell, false);
                Demo_Timer = 9000;
            }
    }
    else 
        Demo_Timer -= diff;

    if (feral!=false && MangleC_Timer < diff && me->HasAura(CAT, 0))
    {
        if (CanCast(me->getVictim(), MangleCSpell, false))
            {
                me->CastSpell(me->getVictim(), MangleCSpell, false);
                MangleC_Timer = 6000;
            }
    }
    else
        MangleC_Timer -= diff;

}

void RogueAI::UpdateAI(const uint32 diff)
{
    if (!UpdateVictim())
        return;

    if (blade!=false && Flurry_Timer < diff)
    {
        if (CanCast(me, FlurrySpell, false))
        {
            me->CastSpell(me, FlurrySpell, false);
            Flurry_Timer = 120000;
        }
    }
    else
        Flurry_Timer -= diff;

    if (Gouge_Timer < diff)
    {
        if (CanCast(me->getVictim(), GougeSpell, false))
        {
            me->CastSpell(me->getVictim(), GougeSpell, false);
            Gouge_Timer = urand(10000, 30000);
        }
    }
    else
        Gouge_Timer -= diff;

    if (Sinister_Timer < diff)
    {
        if (CanCast(me->getVictim(), SinisterSpell, false))
        {
            me->CastSpell(me->getVictim(), SinisterSpell, false);
            Sinister_Timer = urand(2000, 4500);
        }
    }
    else
        Sinister_Timer -= diff;
}

void ShamanAI::UpdateAI(const uint32 diff)
{
    if (!UpdateVictim())
        return;

    if (BL_Timer < diff && BL_Timer>0)
    {
        if (CanCast(me, BLSpell, false))
        {
            me->CastSpell(me->GetCharmer(), BLSpell, false);
            BL_Timer = BLSpell->RecoveryTime + diff;
        }
    }
    else
        BL_Timer -= diff;

    if (Shield_Timer < diff)
    {
        if (!heal && (CanCast(me, ShieldSpell, false)))
        {
            me->CastSpell(me, ShieldSpell, false);
            Shield_Timer = 30000;
        }
        else if (CanCast(me->GetCharmer(), ShieldSpell, false))
        {
            me->CastSpell(me->GetCharmer(), ShieldSpell, false);
            Shield_Timer = 30000;
        }
    }
    else
        Shield_Timer -= diff;

    if (Heal_Timer < diff)
    {
        if (CanCast(me->GetCharmer(), HealSpell, false))
        {
            me->CastSpell(me->GetCharmer(), HealSpell, false);
            Heal_Timer = 10000;
        }
    }
    else
        Heal_Timer -= diff;

    if (Lightning_Timer < diff)
    {
        if (CanCast(me->getVictim(), LightningSpell, false))
        {
            me->CastSpell(me->getVictim(), LightningSpell, false);
            Lightning_Timer = LightningSpell->RecoveryTime + diff;
        }
    }
    else
        Lightning_Timer -= diff;
}

void PriestAI::UpdateAI(const uint32 diff)
{
    if (!UpdateVictim())
        return;

    if ((vampiric==true) && Vampiric_Timer < diff)
    {
        if (CanCast(me->getVictim(), VampiricSpell, false))
        {
            me->CastSpell(me->getVictim(), VampiricSpell, false);
            Vampiric_Timer = 30000;
        }
    }
    else
        Vampiric_Timer -= diff;

    if (DmgSpell_Timer < diff)
    {
        if (CanCast(me->getVictim(), DmgSpell, false))
        {
            me->CastSpell(me->getVictim(), DmgSpell, false);
            DmgSpell_Timer = 2500;
            if (vampiric == true) DmgSpell_Timer +=3500;
        }
    }
    else
        DmgSpell_Timer -= diff;
    
    if (Flash_Timer < diff)
    {
        if (CanCast(me->GetCharmer(), FlashSpell, false))
        {
            me->RemoveAurasDueToSpell(15473);
            me->CastSpell(me->GetCharmer(), FlashSpell, false);
            if (!vampiric)
                Flash_Timer = 3000;
            else 
                Flash_Timer = 10000;
        }
    }
    else
        Flash_Timer -= diff;

    if (holynova && Nova_Timer < diff)
    {
        if (CanCast(me, NovaSpell, false))
        {
            me->CastSpell(me, NovaSpell, false);
            Nova_Timer = 5000;
        }
    }
    else
        Nova_Timer -= diff;

    if (DOTSpell_Timer < diff)
    {
        if (CanCast(me->getVictim(), DOTSpell, false))
        {
            me->CastSpell(me->getVictim(), DOTSpell, false);
            DOTSpell_Timer = 15000;
            if (vampiric == true) DOTSpell_Timer/=5;
        }
    }
    else
        DOTSpell_Timer -= diff;

    if (PWShield_Timer < diff)
    {
        if (CanCast(me->GetCharmer(), PWShieldSpell, false))
        {
            me->CastSpell(me->GetCharmer(), PWShieldSpell, false);
            PWShield_Timer = 16000;
        }
    }
    else
        PWShield_Timer -= diff;
}

void MageAI::UpdateAI(const uint32 diff)
{
    if (!UpdateVictim())
        return;
    
    if (!Special && (me->GetPower(POWER_MANA)*100 / me->GetMaxPower(POWER_MANA) < 20))
    {
        if (CanCast(me, SpecialSpell, false))
        {
            me->CastSpell(me, SpecialSpell, false);
            Special = true;
        }
    }

    if (MassiveAOE_Timer < diff)
    {
        if (Unit *target = me->SelectNearbyTarget(25.0))
        if (CanCast(target, MassiveAOESpell, false))
        {
            me->CastSpell(target, MassiveAOESpell, false);
            MassiveAOE_Timer = 20000 +rand()%7000;
        }
    }
    else
        MassiveAOE_Timer -= diff;

    if (ConeSpell_Timer < diff)
    {
        if (CanCast(me, ConeSpell, false))
        {
            me->CastSpell(me->getVictim(), ConeSpell, false);
            ConeSpell_Timer = ConeSpell->RecoveryTime +diff;
        }
    }
    else
        ConeSpell_Timer -= diff;

    if (AOESpell_Timer < diff)
    {
        if (CanCast(me, AOESpell, false))
        {
            me->CastSpell(me, AOESpell, false);
            AOESpell_Timer = AOESpell->RecoveryTime ? AOESpell->RecoveryTime +diff : 6000;
        }
    }
    else
        AOESpell_Timer -= diff;

    if (NormalSpell_Timer < diff)
    {
        if (CanCast(me->getVictim(), NormalSpell, false))
        {
            me->CastSpell(me->getVictim(), NormalSpell, false);
            NormalSpell_Timer = NormalSpell->RecoveryTime +diff;
        }
    }
    else
        NormalSpell_Timer -= diff;
}
