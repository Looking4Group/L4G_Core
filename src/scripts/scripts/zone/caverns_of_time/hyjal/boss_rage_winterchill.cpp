
#include "precompiled.h"
#include "def_hyjal.h"
#include "hyjal_trash.h"

enum
{
    // Spells
    SPELL_FROST_ARMOR = 31256,
    SPELL_DEATH_AND_DECAY = 31258,
    SPELL_FROST_NOVA = 31250,
    SPELL_ICEBOLT = 31249,
    SPELL_BERSERK = 28498,

    // Texts
    YELL_ONAGGRO = -1999980,
    YELL_ONDEATH = -1999973,

    YELL_ONSLAY1 = -1999979,
    YELL_ONSLAY2 = -1999978,

    YELL_DECAY1 = -1999977,
    YELL_DECAY2 = -1999976,

    YELL_NOVA1 = -1999975,
    YELL_NOVA2 = -1999974
};

struct boss_rage_winterchillAI : public hyjal_trashAI
{
    boss_rage_winterchillAI(Creature *c) : hyjal_trashAI(c)
    {
        pInstance = (c->GetInstanceData());
        go = false;
        pos = 0;
    }

    uint32 FrostArmorTimer;
    uint32 DecayTimer;
    uint32 NovaTimer;
    uint32 IceboltTimer;
    uint32 CheckTimer;
    uint32 EnrageTimer;

    bool go;
    uint32 pos;

    void Reset()
    {
        ClearCastQueue();

        damageTaken = 0;
        FrostArmorTimer = 20000;
        DecayTimer = 45000;
        NovaTimer = 15000;
        IceboltTimer = 10000;
        CheckTimer = 3000;
        EnrageTimer = 600000;

        if (pInstance && IsEvent)
            pInstance->SetData(DATA_RAGEWINTERCHILLEVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {
        if (pInstance && IsEvent)
            pInstance->SetData(DATA_RAGEWINTERCHILLEVENT, IN_PROGRESS);

        DoScriptText(YELL_ONAGGRO, m_creature);
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(RAND(YELL_ONSLAY1, YELL_ONSLAY2), m_creature);
    }

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 7 && pInstance)
        {
            Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_JAINAPROUDMOORE));
            if (target && target->isAlive())
            {
                m_creature->AddThreat(target, 0.0);
                AttackStart(target);
            }
            else
            {
                if (target = m_creature->SelectNearbyTarget(200.0))
                    AttackStart(target);
            }
        }
    }

    void JustDied(Unit *victim)
    {
        hyjal_trashAI::JustDied(victim);
        if (pInstance && IsEvent)
            pInstance->SetData(DATA_RAGEWINTERCHILLEVENT, DONE);

        DoScriptText(YELL_ONDEATH, m_creature);
    }

    void UpdateAI(const uint32 diff)
    {
        if (IsEvent)
        {
            //Must update npc_escortAI
            npc_escortAI::UpdateAI(diff);
            if (!go)
            {
                go = true;
                if (pInstance)
                {
                    AddWaypoint(0, 4896.08, -1576.35, 1333.65);
                    AddWaypoint(1, 4898.68, -1615.02, 1329.48);
                    AddWaypoint(2, 4907.12, -1667.08, 1321.00);
                    AddWaypoint(3, 4963.18, -1699.35, 1340.51);
                    AddWaypoint(4, 4989.16, -1716.67, 1335.74);
                    AddWaypoint(5, 5026.27, -1736.89, 1323.02);
                    AddWaypoint(6, 5037.77, -1770.56, 1324.36);
                    AddWaypoint(7, 5067.23, -1789.95, 1321.17);
                    Start(false, true);
                    SetDespawnAtEnd(false);
                }
            }
        }

        //Return since we have no target
        if (!UpdateVictim())
            return;

        if (CheckTimer <= diff)
        {
            DoZoneInCombat();
            //m_creature->SetSpeed(MOVE_RUN, 3.0); // Why is this here?
            CheckTimer = 3000;
        }
        else
            CheckTimer -= diff;

        if (FrostArmorTimer <= diff)
        {
            DoCast(m_creature, SPELL_FROST_ARMOR, true);
            FrostArmorTimer = urand(30000, 45000);
        }
        else
            FrostArmorTimer -= diff;

        if (DecayTimer <= diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 70, true))
                DoCast(target, SPELL_DEATH_AND_DECAY);

            if (NovaTimer <= 20000)
                NovaTimer = 20000 + diff; // Don't cast Frost Nova while casting Death and Decay

            IceboltTimer = urand(16000, 20000) + diff; // Don't cast Icebolt while casting Death and Decay

            DecayTimer = 35000;

            DoScriptText(RAND(YELL_DECAY1, YELL_DECAY2), m_creature);
        }
        else
            DecayTimer -= diff;

        if (NovaTimer <= diff)
        {
            if (Unit *target = m_creature->getVictim())
                DoCast(target, SPELL_FROST_NOVA, true);

            NovaTimer = urand(19000, 26000);

            DoScriptText(RAND(YELL_NOVA1, YELL_NOVA2), m_creature);
        }
        else
            NovaTimer -= diff;

        if (IceboltTimer <= diff)
        {
            if (Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0, 40, true))
                DoCast(target, SPELL_ICEBOLT, true);

            IceboltTimer = urand(5000, 10000);
        }
        else
            IceboltTimer -= diff;

        if (EnrageTimer <= diff)
        {
            DoCast(m_creature, SPELL_BERSERK);
            EnrageTimer = 300000;
        }
        else
            EnrageTimer -= diff;

        CastNextSpellIfAnyAndReady();
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_rage_winterchill(Creature *_Creature)
{
    return new boss_rage_winterchillAI(_Creature);
}

void AddSC_boss_rage_winterchill()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_rage_winterchill";
    newscript->GetAI = &GetAI_boss_rage_winterchill;
    newscript->RegisterSelf();
}
