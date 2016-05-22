/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
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
SDName: Instance_Shattered_Halls
SD%Complete: 99
SDComment:
SDCategory: Hellfire Citadel, Shattered Halls
EndScriptData */

#include "precompiled.h"
#include "def_shattered_halls.h"

#define ENCOUNTERS           6

#define DOOR_NETHEKURSE1     182539
#define DOOR_NETHEKURSE2     182540
#define NPC_FEL_ORC          17083
#define NPC_NETHEKURSE       16807
#define NPC_WARBRINGER       16809
#define NPC_KARGATH          16808
#define SPELL_SHADOW_SEAR    30735

enum
{
    NPC_EXECUTIONER                = 17301,
    NPC_SOLDIER_ALLIANCE_1         = 17288,
    NPC_SOLDIER_ALLIANCE_2         = 17289,
    NPC_SOLDIER_ALLIANCE_3         = 17292,
    NPC_OFFICER_ALLIANCE           = 17290,

    NPC_SOLDIER_HORDE_1            = 17294,
    NPC_SOLDIER_HORDE_2            = 17295,
    NPC_SOLDIER_HORDE_3            = 17297,
    NPC_OFFICER_HORDE              = 17296,

    SPELL_KARGATH_EXECUTIONER_1    = 39288,
    SPELL_KARGATH_EXECUTIONER_2    = 39289,
    SPELL_KARGATH_EXECUTIONER_3    = 39290,

    //SAY_KARGATH_EXECUTE_ALLY = ?,
    //SAY_KARGATH_EXECUTE_HORDE = ?
};

struct SpawnLocation
{
    uint32 AllianceEntry, HordeEntry;
    float fX, fY, fZ, fO;
};

const float afExecutionerLoc[4] = {151.443f, -84.439f, 1.938f, 6.283f};

static SpawnLocation aSoldiersLocs[]=
{
    {0, NPC_SOLDIER_HORDE_1, 119.609f, 256.127f, -45.254f, 5.133f},
    {NPC_SOLDIER_ALLIANCE_1, 0, 131.106f, 254.520f, -45.236f, 3.951f},
    {NPC_SOLDIER_ALLIANCE_3, NPC_SOLDIER_HORDE_3, 151.040f, -91.558f, 1.936f, 1.559f},
    {NPC_SOLDIER_ALLIANCE_2, NPC_SOLDIER_HORDE_2, 150.669f, -77.015f, 1.933f, 4.705f},
    {NPC_OFFICER_ALLIANCE, NPC_OFFICER_HORDE, 138.241f, -84.198f, 1.907f, 0.055f}
};

enum Summon
{
    NOT_SUMMONED    = 0,
    WAIT_FOR_SUMMON = 1,
    SUMMONED        = 2
};

struct instance_shattered_halls : public ScriptedInstance
{
    instance_shattered_halls(Map *map) : ScriptedInstance(map) {Initialize();};

    uint32 Encounter[ENCOUNTERS];
    std::list<uint64> OrcGUID;
    uint64 nethekurseGUID;
    uint64 warbringerGUID;
    uint64 nethekurseDoor1GUID;
    uint64 nethekurseDoor2GUID;
    uint64 kargathGUID;
    uint64 executionerGUID;
    uint64 officeraGUID;
    uint64 officerhGUID;
    uint64 soldiera2GUID;
    uint64 soldiera3GUID;
    uint64 soldierh2GUID;
    uint64 soldierh3GUID;

    uint32 ExecutionTimer;
    uint32 Team;
    uint8 ExecutionStage;

    Summon summon;

    void Initialize()
    {
        nethekurseGUID = 0;
        warbringerGUID = 0;
        nethekurseDoor1GUID = 0;
        nethekurseDoor2GUID = 0;
        kargathGUID = 0;
        executionerGUID = 0;
        officeraGUID = 0;
        officerhGUID = 0;
        soldiera2GUID = 0;
        soldiera3GUID = 0;
        soldierh2GUID = 0;
        soldierh3GUID = 0;

        Team = 0;
        ExecutionStage =0;
        ExecutionTimer = 55*MINUTE*IN_MILISECONDS;

        summon = NOT_SUMMONED;

        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounter[i] = NOT_STARTED;
    }

    void OnPlayerEnter(Player* player)
    {
        if (!instance->IsHeroic())
            return;

        if (summon == NOT_SUMMONED)
            summon = WAIT_FOR_SUMMON;
    }

    bool IsEncounterInProgress() const
    {
        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounter[i] == IN_PROGRESS)
                return true;
        return false;
    }

    Player* GetPlayerInMap()
    {
        Map::PlayerList const& players = instance->GetPlayers();

        if (!players.isEmpty())
        {
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* plr = itr->getSource())
                    return plr;
            }
        }

        debug_log("TSCR: Instance Shattered Halls: GetPlayerInMap, but PlayerList is empty!");
        return NULL;
    }

    void OnObjectCreate(GameObject *go)
    {
        switch (go->GetEntry())
        {
            case DOOR_NETHEKURSE1:
                nethekurseDoor1GUID = go->GetGUID();
                if(GetData(TYPE_NETHEKURSE) == DONE)
                    HandleGameObject(nethekurseDoor1GUID, 0);
                break;
            case DOOR_NETHEKURSE2:
                nethekurseDoor2GUID = go->GetGUID();
                if(GetData(TYPE_NETHEKURSE) == DONE)
                    HandleGameObject(nethekurseDoor2GUID, 0);
                break;
        }
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        switch (creature_entry)
        {
            case NPC_NETHEKURSE: nethekurseGUID = creature->GetGUID(); break;
            case NPC_WARBRINGER: warbringerGUID = creature->GetGUID(); break;
            case NPC_KARGATH: kargathGUID = creature->GetGUID(); break;
            case NPC_EXECUTIONER: executionerGUID = creature->GetGUID(); break;
            case NPC_SOLDIER_ALLIANCE_2: soldiera2GUID = creature->GetGUID(); break;
            case NPC_SOLDIER_ALLIANCE_3: soldiera3GUID = creature->GetGUID(); break;
            case NPC_OFFICER_ALLIANCE: officeraGUID = creature->GetGUID(); break;
            case NPC_SOLDIER_HORDE_2: soldierh2GUID = creature->GetGUID(); break;
            case NPC_SOLDIER_HORDE_3: soldierh3GUID = creature->GetGUID(); break;
            case NPC_OFFICER_HORDE: officerhGUID = creature->GetGUID(); break;
            case NPC_FEL_ORC: OrcGUID.push_back(creature->GetGUID()); break;
        }
    }

    void SetData(uint32 type, uint32 data)
    {
        switch( type )
        {
            case TYPE_NETHEKURSE:
                if (data == FAIL)
                {
                    for (std::list<uint64>::iterator itr = OrcGUID.begin(); itr != OrcGUID.end(); ++itr)
                    {
                        if (Creature* Orc = instance->GetCreature(*itr))
                        {
                            if (!Orc->isAlive())
                            {
                                Orc->ForcedDespawn();
                                Orc->Respawn();
                            }
                        }
                    }
                }
                if (data == SPECIAL)
                {
                    for (std::list<uint64>::iterator itr = OrcGUID.begin(); itr != OrcGUID.end(); ++itr)
                    {
                        if (Creature* Orc = instance->GetCreature(*itr))
                        {
                            if (Orc->isAlive())
                            {
                                if (Creature* neth = instance->GetCreature(nethekurseGUID))
                                    neth->CastSpell(Orc, SPELL_SHADOW_SEAR, true);

                            }
                        }
                    }
                }
                if (data == DONE)
                {
                    HandleGameObject(nethekurseDoor1GUID, 0);
                    HandleGameObject(nethekurseDoor2GUID, 0);
                }

                if (Encounter[0] != DONE)
                    Encounter[0] = data;
                break;
            case TYPE_WARBRINGER:
                if (Encounter[1] != DONE)
                    Encounter[1] = data;
                break;
            case TYPE_PORUNG:
                if (Encounter[2] != DONE)
                    Encounter[2] = data;
                break;
            case TYPE_KARGATH:
                if (data == DONE)
                {
                    if (Creature* Executioner = instance->GetCreature(executionerGUID))
                        Executioner->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                }
                else
                    Encounter[3] = data;
                break;
            case TYPE_EXECUTION:
                if (data == DONE && !instance->GetCreature(executionerGUID))
                {
                    if (Player* player = GetPlayerInMap())
                    {
                        for (uint8 i = 2; i < 5; ++i)
                            player->SummonCreature(Team == ALLIANCE ? aSoldiersLocs[i].AllianceEntry : aSoldiersLocs[i].HordeEntry, aSoldiersLocs[i].fX, aSoldiersLocs[i].fY, aSoldiersLocs[i].fZ, aSoldiersLocs[i].fO, TEMPSUMMON_DEAD_DESPAWN, 0);

                        if (Creature* Executioner = player->SummonCreature(NPC_EXECUTIONER, afExecutionerLoc[0], afExecutionerLoc[1], afExecutionerLoc[2], afExecutionerLoc[3], TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 80*MINUTE*IN_MILISECONDS))
                            Executioner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

                        DoCastGroupDebuff(SPELL_KARGATH_EXECUTIONER_1);
                        ExecutionTimer = 55*MINUTE*IN_MILISECONDS;
                   }
               }
               else
                   Encounter[4] = data;
               break;
            case TYPE_EXECUTION_DONE:
               if (data == DONE)
               {
                   if (Creature* Officer = instance->GetCreature(Team == ALLIANCE ? officeraGUID : officerhGUID))
                       Officer->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
               }
               else
                   Encounter[5] = data;
               break;
        }

        if (data == DONE)
        {
            SaveToDB();
            OUT_SAVE_INST_DATA_COMPLETE;
        }
    }

    uint32 GetData(uint32 type)
    {
        switch (type)
        {
            case TYPE_NETHEKURSE:
                return Encounter[0];
            case TYPE_WARBRINGER:
                return Encounter[1];
            case TYPE_PORUNG:
                return Encounter[2];
            case TYPE_KARGATH:
                return Encounter[3];
            case TYPE_EXECUTION:
                return Encounter[4];
            case TYPE_EXECUTION_DONE:
                return Encounter[5];
        }
        return 0;
    }

    uint64 GetData64(uint32 data)
    {
        switch (data)
        {
            case DATA_NETHEKURSE:
                return nethekurseGUID;
            case DATA_WARBRINGER:
                return warbringerGUID;
        }
        return 0;
    }

    void OnCreatureDeath(Creature* pCreature)
    {
        if (pCreature->GetEntry() == NPC_EXECUTIONER)
            SetData(TYPE_EXECUTION_DONE, DONE);
    }

    void DoCastGroupDebuff(uint32 SpellId)
    {
        Map::PlayerList const& lPlayers = instance->GetPlayers();

        if (lPlayers.isEmpty())
            return;

        for (Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
        {
            Player* player = itr->getSource();
            if (player && !player->HasAura(SpellId, 0))
                player->CastSpell(player, SpellId, true);
        }
    }

    void HandleGameObject(uint64 guid, uint32 state)
    {
        Player *player = GetPlayerInMap();

        if (!player || !guid)
            return;

        if (GameObject *go = GameObject::GetGameObject(*player,guid))
            go->SetGoState(GOState(state));
    }

    void Update(uint32 diff)
    {
        if (ExecutionTimer)
        {
            if (ExecutionTimer <= diff)
            {
                switch(ExecutionStage)
                {
                    case 0:
                        if (Creature* Soldier = instance->GetCreature(Team == ALLIANCE ? officeraGUID : officerhGUID))
                            Soldier->DealDamage(Soldier, Soldier->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);

                        //DoScriptText(Team == ALLIANCE ? SAY_KARGATH_EXECUTE_ALLY : SAY_KARGATH_EXECUTE_HORDE, instance->GetCreature(kargathGUID));

                        DoCastGroupDebuff(SPELL_KARGATH_EXECUTIONER_2);
                        ExecutionTimer = 10*MINUTE*IN_MILISECONDS;
                        break;
                    case 1:
                        if (Creature* Soldier = instance->GetCreature(Team == ALLIANCE ? soldiera2GUID : soldierh2GUID))
                            Soldier->DealDamage(Soldier, Soldier->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);

                        DoCastGroupDebuff(SPELL_KARGATH_EXECUTIONER_3);
                        ExecutionTimer = 15*MINUTE*IN_MILISECONDS;
                        break;
                     case 2:
                         if (Creature* Soldier = instance->GetCreature(Team == ALLIANCE ? soldiera3GUID : soldierh3GUID))
                             Soldier->DealDamage(Soldier, Soldier->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);

                         SetData(TYPE_EXECUTION_DONE, FAIL);
                         ExecutionTimer = 0;
                         break;
                }
                ++ExecutionStage;
            }
            else ExecutionTimer -= diff;
        }

        if (summon == WAIT_FOR_SUMMON)
        {
            if (instance->GetPlayers().isEmpty() || Team)
                return;

            Player* player = instance->GetPlayers().begin()->getSource();
            Team = player->GetTeam();

            if (Team == ALLIANCE)
                player->SummonCreature(aSoldiersLocs[1].AllianceEntry, aSoldiersLocs[1].fX, aSoldiersLocs[1].fY, aSoldiersLocs[1].fZ, aSoldiersLocs[1].fO, TEMPSUMMON_DEAD_DESPAWN, 0);
            else
                player->SummonCreature(aSoldiersLocs[0].HordeEntry, aSoldiersLocs[0].fX, aSoldiersLocs[0].fY, aSoldiersLocs[0].fZ, aSoldiersLocs[0].fO, TEMPSUMMON_DEAD_DESPAWN, 0);

            summon = SUMMONED;
        }
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << Encounter[0] << " ";
        stream << Encounter[1] << " ";
        stream << Encounter[2] << " ";
        stream << Encounter[3] << " ";
        stream << Encounter[4] << " ";
        stream << Encounter[5] ;

        OUT_SAVE_INST_DATA_COMPLETE;

        return stream.str();
    }

    void Load(const char* in)
    {
        if(!in)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }

        OUT_LOAD_INST_DATA(in);

        std::istringstream stream(in);
        stream  >> Encounter[0] >> Encounter[1] >> Encounter[2] >> Encounter[3] >> Encounter[4] >> Encounter[5];

        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounter[i] == IN_PROGRESS)
                Encounter[i] = NOT_STARTED;

        if (Encounter[0] == DONE)
        {
            HandleGameObject(nethekurseDoor1GUID, 0);
            HandleGameObject(nethekurseDoor2GUID, 0);
        }

        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_shattered_halls(Map* map)
{
    return new instance_shattered_halls(map);
}

bool AreaTrigger_at_shattered_halls(Player* player, AreaTriggerEntry const* /*pAt*/)
{
    if (player->isGameMaster() || player->isDead())
        return false;

    instance_shattered_halls* pInstance = (instance_shattered_halls*)player->GetInstanceData();

    if (!pInstance)
        return false;

    if (!pInstance->instance->IsHeroic())
        return false;

    if (pInstance->GetData(TYPE_KARGATH) == DONE || pInstance->GetData(TYPE_WARBRINGER) == DONE)
        return false;

    if (pInstance->GetData(TYPE_EXECUTION) == NOT_STARTED)
        pInstance->SetData(TYPE_EXECUTION, DONE);

    return true;
}

void AddSC_instance_shattered_halls()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_shattered_halls";
    newscript->GetInstanceData = &GetInstanceData_instance_shattered_halls;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "at_shattered_halls";
    newscript->pAreaTrigger = &AreaTrigger_at_shattered_halls;
    newscript->RegisterSelf();
}

