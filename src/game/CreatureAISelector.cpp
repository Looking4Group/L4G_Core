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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "Creature.h"
#include "CreatureAISelector.h"
#include "PassiveAI.h"
#include "MovementGenerator.h"
#include "ScriptMgr.h"
#include "Pet.h"
#include "TemporarySummon.h"
#include "CreatureAIFactory.h"

namespace FactorySelector
{
    CreatureAI* selectAI(Creature *creature)
    {
        const CreatureAICreator *ai_factory = NULL;
        CreatureAIRegistry &ai_registry(*CreatureAIRepository::instance());

        //script name in db
        if ((!creature->isPet() || !((Pet*)creature)->isControlled()) && !creature->isCharmed())
            if (CreatureAI* scriptedAI = sScriptMgr.GetCreatureAI(creature))
                return scriptedAI;

        // AIname in db
        std::string ainame = creature->GetAIName();
        if (!ainame.empty())
            ai_factory = ai_registry.GetRegistryItem(ainame.c_str());

        // select by NPC flags
        if (!ai_factory || ((creature->isPet() && ((Pet*)creature)->getPetType() == HUNTER_PET) || (creature->isPet() && ((Pet*)creature)->getPetType() == SUMMON_PET)))
        {
            if (creature->isGuard() && creature->GetOwner() && creature->GetOwner()->GetTypeId() == TYPEID_PLAYER)
                ai_factory = ai_registry.GetRegistryItem("PetAI");
            else if (creature->isGuard())
                ai_factory = ai_registry.GetRegistryItem("GuardAI");
            else if (creature->isPet() || (creature->isCharmed() && !creature->isPossessed()))
            {
                switch (creature->GetEntry())
                {
                    case 416:
                        ai_factory = ai_registry.GetRegistryItem("ImpAI");
                        break;
                    case 417:
                        ai_factory = ai_registry.GetRegistryItem("FelhunterAI");
                        break;
                    default:
                        ai_factory = ai_registry.GetRegistryItem("PetAI");
                        break;
                }
            }
            else if (creature->isTotem())
                ai_factory = ai_registry.GetRegistryItem("TotemAI");
            else if (creature->isTrigger())
            {
                if (creature->m_spells[0])
                    ai_factory = ai_registry.GetRegistryItem("TriggerAI");
                else
                    ai_factory = ai_registry.GetRegistryItem("NullCreatureAI");
            }
            else if (creature->GetCreatureType() == CREATURE_TYPE_CRITTER)
                ai_factory = ai_registry.GetRegistryItem("CritterAI");
        }

        if (!ai_factory)
        {
            for (uint32 i = 0; i < CREATURE_MAX_SPELLS; ++i)
            {
                if (creature->m_spells[i])
                {
                    ai_factory = ai_registry.GetRegistryItem("CombatAI");
                    break;
                }
            }
        }

        // select by permit check
        if (!ai_factory)
        {
            int best_val = PERMIT_BASE_NO;
            typedef CreatureAIRegistry::RegistryMapType RMT;
            RMT const &l = ai_registry.GetRegisteredItems();
            for (RMT::const_iterator iter = l.begin(); iter != l.end(); ++iter)
            {
                const CreatureAICreator *factory = iter->second;
                const SelectableAI *p = dynamic_cast<const SelectableAI *>(factory);
                ASSERT(p != NULL);
                int val = p->Permit(creature);
                if (val > best_val)
                {
                    best_val = val;
                    ai_factory = p;
                }
            }
        }

        // select NullCreatureAI if not another cases
        ainame = (ai_factory == NULL) ? "NullCreatureAI" : ai_factory->key();

        DEBUG_LOG("Creature %u used AI is %s.", creature->GetGUIDLow(), ainame.c_str());
        return (ai_factory == NULL ? new NullCreatureAI(creature) : ai_factory->Create(creature));
    }

    MovementGenerator* selectMovementGenerator(Creature *creature)
    {
        MovementGeneratorRegistry &mv_registry(*MovementGeneratorRepository::instance());
        const MovementGeneratorCreator *mv_factory = mv_registry.GetRegistryItem(creature->GetDefaultMovementType());
        return (mv_factory == NULL ? NULL : mv_factory->Create(creature));
    }
}
