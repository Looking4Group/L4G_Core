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
SDName: Boss_Ossirian
SD%Complete: 0
SDComment: Place holder
SDCategory: Ruins of Ahn'Qiraj
EndScriptData */

#include "precompiled.h"
#include "def_ruins_of_ahnqiraj.h"

#define SAY_SURPREME2   -1509019
#define SAY_SURPREME3   -1509020

#define SAY_RAND_INTRO1 -1509021
#define SAY_RAND_INTRO2 -1509022
#define SAY_RAND_INTRO3 -1509023
#define SAY_RAND_INTRO4 -1509024                            //possibly old?

#define SAY_AGGRO       -1509025

#define SAY_SLAY        -1509026
#define SAY_DEATH       -1509027

#define SPELL_COT           25195   //curse of tongues
#define SPELL_SUPREME       25176   //buff +300% dmg, dispellable by crystals
#define SPELL_WAR_STOMP     25188
#define SPELL_ENVELOPING    25189

#define GO_CRYSTAL      180619 // 210312 210313?
#define CRYSTAL_TRIGGER 15590
//weaknesses from crystals
#define SPELL_ARCANEW   25181
#define SPELL_FIREW     25177
#define SPELL_FROSTW    25178
#define SPELL_NATUREW   25180
#define SPELL_SHADOWW   25183

#define CREATURE_TORNADO    1 //placeholder
