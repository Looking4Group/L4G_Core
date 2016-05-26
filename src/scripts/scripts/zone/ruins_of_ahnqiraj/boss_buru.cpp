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
SDName: Boss_Buru
SD%Complete: 0
SDComment: Place Holder
SDCategory: Ruins of Ahn'Qiraj
EndScriptData */

#include "precompiled.h"
#include "def_ruins_of_ahnqiraj.h"

#define EMOTE_TARGET        -1509002

#define SPELL_CREEPING_PLAGUE   20512   //aura, when HP<20%, 3 ticks, then next stack
#define SPELL_DISMEMBER         96      //cast, when target is in melee range
#define SPELL_THORNS            25640
#define SPELL_FULL_SPEED        1557
#define SPELL_TRANSFORM         24721   //drop armor when HP<20%
#define SPELL_EGG_TRIGGER       26646   //scripted or not?, stun Buru for about 2 seconds, change target, deal 45k to Buru, 100-500 to players nearby

#define BURU_ENRAGE             15507   //model after dropping armor
#define CREATURE_EGG            15514
#define EGG_TRIGGER             15964   //dunno what for
#define SPELL_SUMMON            1881    //Hatchling
#define SPELL_EGG_EXPLOSION     19593
//speedup timer - 15 seconds
//eggs are on 1 minute respawn timer
