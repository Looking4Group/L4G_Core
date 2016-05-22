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
SDName: instance_onyxia_lair
SD%Complete: 90%
SDComment: cos pewnie zle dziala
SDCategory: Onyxia's Lair
EndScriptData */

#include "precompiled.h"
#include "def_onyxia_lair.h"

enum SpawnDefinitions;
extern cPosition spawnEntrancePoints[];

enum OnyxiaLair
{
    SPELL_SUMMONWHELP = 17646,
    SPELL_ERUPT       = 17731,
    GO_LAVA_TRAP1     = 177984,
    GO_LAVA_TRAP2     = 177985,
    GO_EGG            = 176511,
    CREATURE_WHELP    = 11262
};

struct instance_onyxia_lair : public ScriptedInstance
{
     instance_onyxia_lair(Map *map) : ScriptedInstance(map) {Initialize();};

     std::list<uint64> m_whelps;

     std::vector<uint64> LavaTraps;

     std::vector<uint64> leftEggs;
     std::vector<uint64> rightEggs;

     uint32 onyxia_encounter;

    void Initialize()
    {
        onyxia_encounter = NOT_STARTED;
        LavaTraps.clear();
    }

    bool IsEncounterInProgress() const
    {
        return onyxia_encounter == IN_PROGRESS;
    }


    void OnObjectCreate(GameObject *go)
    {
        switch(go->GetEntry())
        {
            case GO_LAVA_TRAP1:
            case GO_LAVA_TRAP2:
                LavaTraps.push_back(go->GetGUID());
            break;
            case GO_EGG:
                if (go->GetDistance2d(spawnEntrancePoints[LEFT].x, spawnEntrancePoints[LEFT].y) < go->GetDistance2d(spawnEntrancePoints[RIGHT].x, spawnEntrancePoints[RIGHT].y))
                    leftEggs.push_back(go->GetGUID());
                else
                    rightEggs.push_back(go->GetGUID());
            break;
        }
    }

    void SpawnEggs(uint32 count)
    {
        if (Unit *target = (instance->GetPlayers().begin() != instance->GetPlayers().end()) ? instance->GetPlayers().begin()->getSource() : NULL)
        {
            for (uint32 i = 0; i < count; ++i)
            {
                if (GameObject *egg = instance->GetGameObject(leftEggs[i]))
                {
                    egg->SendCustomAnimation();
                    egg->CastSpell(target, SPELL_SUMMONWHELP);
                }
                if (GameObject *egg = instance->GetGameObject(rightEggs[i]))
                {
                    egg->SendCustomAnimation();
                    egg->CastSpell(target, SPELL_SUMMONWHELP);
                }
            }
        }
    }

    void OnCreatureCreate(Creature *c, uint32 creature_entry)
    {
        switch (creature_entry)
        {
            case CREATURE_WHELP:
                m_whelps.push_back(c->GetGUID());
                break;
        }
    }

    void DespawnWhelps()
    {
        error_log("TSCR: Despawning Whelps in Onyxia's Lair: whelps count %u", m_whelps.size());
        for (std::list<uint64>::const_iterator itr = m_whelps.begin(); itr != m_whelps.end(); ++itr)
        {
            if (Creature *whelp = instance->GetCreature(*itr))
            {
                whelp->setDeathState(JUST_DIED);
                whelp->RemoveCorpse();
            }
        }
    }

    void ActivateEggs(bool activate)
    {
        LootState lootstate = GO_ACTIVATED; // will not hatch if encounter isnt in progress
        if (activate)
            lootstate = GO_READY;

        for (std::vector<uint64>::const_iterator itr = leftEggs.begin(); itr != leftEggs.end(); ++itr)
        {
            if (GameObject *egg = instance->GetGameObject(*itr))
            {
                egg->Respawn();
                egg->SetLootState(lootstate);
            }
        }

        for (std::vector<uint64>::const_iterator itr = rightEggs.begin(); itr != rightEggs.end(); ++itr)
        {
            if (GameObject *egg = instance->GetGameObject(*itr))
            {
                egg->Respawn();
                egg->SetLootState(lootstate);
            }
        }
    }

    void SetData(uint32 index, uint32 data)
    {
        switch (index)
        {
            case DATA_ONYXIA:
                onyxia_encounter = data;
                ActivateEggs(onyxia_encounter == IN_PROGRESS);
                if (data != IN_PROGRESS)
                    DespawnWhelps();
            break;
            case DATA_HATCH_EGGS:
                SpawnEggs(data);
            break;
            case DATA_ERUPT:
                ActivateLavaTraps();
            break;
        }
    }

    void ActivateLavaTraps()
    {
        if (Unit *target = (instance->GetPlayers().begin() != instance->GetPlayers().end()) ? instance->GetPlayers().begin()->getSource() : NULL)
        {
            std::set<uint32> randomized;
            uint32 size = (LavaTraps.size() - 1)/3;
            while (randomized.size() < size)
                randomized.insert(irand(0, LavaTraps.size()-1));

            for (std::set<uint32>::const_iterator itr = randomized.begin(); itr != randomized.end(); ++itr)
            {
                if (GameObject *obj = instance->GetGameObject(LavaTraps[*itr]))
                {
                    obj->CastSpell(target, SPELL_ERUPT);
                    obj->SendCustomAnimation();
                }
            }
        }
    }
};

InstanceData* GetInstance_instance_onyxia_lair(Map *map)
{
    return new instance_onyxia_lair (map);
}

void AddSC_instance_onyxia_lair()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="instance_onyxia_lair";
    newscript->GetInstanceData = &GetInstance_instance_onyxia_lair;
    newscript->RegisterSelf();
}

