/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Boss_Mother_Shahraz
SD%Complete: 80
SDComment: Saber Lash missing, Fatal Attraction slightly incorrect; need to damage only if affected players are within range of each other
SDCategory: Black Temple
EndScriptData */

#include "precompiled.h"
#include "def_black_temple.h"

//Speech'n'Sounds
enum MotherSay
{
    SAY_TAUNT1              = -1564018,
    SAY_TAUNT2              = -1564019,
    SAY_TAUNT3              = -1564020,
    SAY_AGGRO               = -1564021,
    SAY_SPELL1              = -1564022,
    SAY_SPELL2              = -1564023,
    SAY_SPELL3              = -1564024,
    SAY_SLAY1               = -1564025,
    SAY_SLAY2               = -1564026,
    SAY_ENRAGE              = -1564027,
    SAY_DEATH               = -1564028,
    EMOTE_ENRAGE            = -1564097
};

//Spells
enum MotherSpells
{
    SPELL_SILENCING_SHRIEK  = 40823,
    SPELL_ENRAGE            = 34670,
    SPELL_SABER_LASH        = 40810,
    SPELL_FATAL_ATTRACTION  = 40869,
    SPELL_BERSERK           = 45078,

    SPELL_PRISMATIC_SHIELD  = 40879,
    SPELL_SABER_LASH_AURA   = 40816
};

float positions[34][2] =
{
    {927.979, 181.61},
    {942.904, 181.996},
    {956.791, 180.219},
    {972.212, 186.743},
    {961.126, 195.864},
    {947.358, 192.311},
    {932.846, 191.636},
    {931.008, 202.818},
    {940.404, 206.899},
    {951.583, 205.207},
    {961.637, 207.041},
    {966.439, 219.553},
    {955.098, 218.286},
    {945.183, 220.835},
    {927.697, 220.758},
    {926.898, 231.017},
    {939.866, 233.547},
    {961.485, 234.489},
    {976.464, 240.407},
    {967.097, 248.814},
    {952.011, 251.172},
    {943.619, 250.804},
    {933.353, 250.352},
    {920.665, 247.924},
    {919.703, 262.54},
    {937.174, 262.04},
    {946.208, 258.092},
    {955.213, 262.29},
    {971.454, 261.922},
    {970.511, 271.813},
    {958.936, 272.276},
    {947.011, 271.858},
    {938.205, 271.412},
    {929.774, 262.897}
};

enum beamSpells
{
    SPELL_SINFUL_BEAM   = 40862,
    SPELL_SINISTER_BEAM = 40863,
    SPELL_VILE_BEAM     = 40865,
    SPELL_WICKED_BEAM   = 40866
};

struct boss_shahrazAI : public ScriptedAI
{
    boss_shahrazAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
        c->GetPosition(wLoc);
    }

    ScriptedInstance* pInstance;

    uint8 m_position;
    WorldLocation wLoc;

    uint32 m_shriekTimer;
    uint32 m_yellTimer;
    uint32 m_attractionTimer;
    uint32 m_enrageTimer;
    uint32 m_enragePeriodic;

    uint32 m_checkTimer;
    uint32 prevBeam;

    bool m_enraged;
    bool b_canEnrage;
    bool castBeam;

    void SpellHitTarget(Unit *pTarget, const SpellEntry *pSpell)
    {
        if (pTarget->GetTypeId() != TYPEID_PLAYER)
            return;

        if (pSpell->Id == SPELL_FATAL_ATTRACTION)
        {
            float x = positions[m_position][0];
            float y = positions[m_position][1];
            float z = 192.82;

            ((Player *)pTarget)->TeleportTo(pTarget->GetMapId(), x, y, z, 0.0f, TELE_TO_NOT_LEAVE_COMBAT | TELE_TO_NOT_UNSUMMON_PET);
        }
    }

    void Reset()
    {
        ClearCastQueue();

        if (!pInstance)
            pInstance = (me->GetInstanceData());

        pInstance->SetData(EVENT_MOTHERSHAHRAZ, NOT_STARTED);

        m_attractionTimer = urand(20000, 30000);
        m_shriekTimer = 20000;
        m_yellTimer = urand(70000, 111000);
        m_enrageTimer = 600000;
        m_enragePeriodic = 2000;
        m_enraged = false;
        b_canEnrage = false;
        castBeam = false;
        prevBeam = 0;

        m_checkTimer = 1000;

        m_position = 0;
    }

    void OnAuraRemove(Aura *pAura, bool removeStack)
    {
        if (pInstance->GetData(EVENT_MOTHERSHAHRAZ) != IN_PROGRESS)
            return;

        //ClearCastQueue();
        prevBeam = pAura->GetId();
        castBeam = true;
    }

    void EnterCombat(Unit *who)
    {
        // Cleanup prismatic shield auras
        me->RemoveAurasDueToSpell(SPELL_PRISMATIC_SHIELD);
        ForceSpellCast(me, SPELL_PRISMATIC_SHIELD);

        // Cleanup saber lash auras
        me->RemoveAurasDueToSpell(SPELL_SABER_LASH_AURA);
        ForceSpellCast(me, SPELL_SABER_LASH_AURA);

        // Cleanup beam auras
        me->RemoveAurasDueToSpell(SPELL_SINFUL_BEAM);
        me->RemoveAurasDueToSpell(SPELL_SINISTER_BEAM);
        me->RemoveAurasDueToSpell(SPELL_WICKED_BEAM);
        me->RemoveAurasDueToSpell(SPELL_VILE_BEAM);
        ForceSpellCast(me, RAND(SPELL_SINFUL_BEAM, SPELL_SINISTER_BEAM, SPELL_WICKED_BEAM, SPELL_VILE_BEAM));

        DoScriptText(SAY_AGGRO, me);

        pInstance->SetData(EVENT_MOTHERSHAHRAZ, IN_PROGRESS);

        DoZoneInCombat();
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(SAY_SLAY1, SAY_SLAY2), me);
    }

    void JustDied(Unit *victim)
    {
        pInstance->SetData(EVENT_MOTHERSHAHRAZ, DONE);

        DoScriptText(SAY_DEATH, me);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (m_checkTimer < diff)
        {
            if(me->GetDistance(wLoc.coord_x, wLoc.coord_y, wLoc.coord_z) > 110)
            {
                EnterEvadeMode();
                return;
            }
            DoZoneInCombat();
            me->SetSpeed(MOVE_RUN, 3.0);

            m_checkTimer = 2000;
        }
        else
            m_checkTimer -= diff;

        if (!m_enraged && ((me->GetHealth()*100 / me->GetMaxHealth()) < 10))
        {

            DoScriptText(EMOTE_ENRAGE, m_creature);
            DoScriptText(SAY_ENRAGE, m_creature);
            m_enraged = true;
            b_canEnrage = true;
        }

        if (b_canEnrage)
        {
            if (m_enragePeriodic < diff)
            {
                DoScriptText(SAY_ENRAGE, m_creature);
                ForceSpellCast(me, SPELL_ENRAGE);
                m_enragePeriodic = urand(20000, 30000);
            }
            else
                m_enragePeriodic -= diff;
        }

        // Select 3 random targets (can select same target more than once), teleport to a random location then make them cast explosions until they get away from each other.
        if (m_attractionTimer < diff)
        {
            m_position = urand(0, 33);
            ForceSpellCastWithScriptText(me, SPELL_FATAL_ATTRACTION, RAND(SAY_SPELL2, SAY_SPELL3));

            m_attractionTimer = urand(23000, 30000);
        }
        else
            m_attractionTimer -= diff;

        if (m_shriekTimer < diff)
        {
            if(!urand(0, 2))
                DoScriptText(SAY_SPELL1, m_creature);
            AddSpellToCast(me->getVictim(), SPELL_SILENCING_SHRIEK);
            m_shriekTimer = 20000;
        }
        else
            m_shriekTimer -= diff;

        //Enrage
        if (m_enrageTimer)
        {
            if (!me->HasAura(SPELL_BERSERK, 0))
            {
                if (m_enrageTimer <= diff)
                {
                    m_enrageTimer = 0;
                    ForceSpellCastWithScriptText(me, SPELL_BERSERK, SAY_ENRAGE, INTERRUPT_AND_CAST);
                }
                else
                    m_enrageTimer -= diff;
            }
        }

        //Random taunts
        if (m_yellTimer < diff)
        {
            DoScriptText(RAND(SAY_TAUNT1, SAY_TAUNT2, SAY_TAUNT3), me);
            m_yellTimer = urand(15000, 35000);
        }
        else
            m_yellTimer -= diff;

        if (castBeam)
        {
            switch (prevBeam)
            {
                case SPELL_SINFUL_BEAM:
                    //ForceSpellCast(me, RAND(SPELL_SINISTER_BEAM, SPELL_VILE_BEAM, SPELL_WICKED_BEAM));
                    me->AddAura(RAND(SPELL_SINISTER_BEAM, SPELL_VILE_BEAM, SPELL_WICKED_BEAM), me);
                    break;
                case SPELL_SINISTER_BEAM:
                    //ForceSpellCast(me, RAND(SPELL_SINFUL_BEAM, SPELL_VILE_BEAM, SPELL_WICKED_BEAM));
                    me->AddAura(RAND(SPELL_SINFUL_BEAM, SPELL_VILE_BEAM, SPELL_WICKED_BEAM), me);
                    break;
                case SPELL_VILE_BEAM:
                    //ForceSpellCast(me, RAND(SPELL_SINFUL_BEAM, SPELL_SINISTER_BEAM, SPELL_WICKED_BEAM));
                    me->AddAura(RAND(SPELL_SINFUL_BEAM, SPELL_SINISTER_BEAM, SPELL_WICKED_BEAM), me);
                    break;
                case SPELL_WICKED_BEAM:
                    //ForceSpellCast(me, RAND(SPELL_SINFUL_BEAM, SPELL_SINISTER_BEAM, SPELL_VILE_BEAM));
                    me->AddAura(RAND(SPELL_SINFUL_BEAM, SPELL_SINISTER_BEAM, SPELL_VILE_BEAM), me);
                    break;
            }
            castBeam = false;
        }

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_shahraz(Creature *_Creature)
{
    return new boss_shahrazAI (_Creature);
}

void AddSC_boss_mother_shahraz()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_mother_shahraz";
    newscript->GetAI = &GetAI_boss_shahraz;
    newscript->RegisterSelf();
}
