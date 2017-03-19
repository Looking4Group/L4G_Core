/*
 * Copyright (C) 2005-2008 MaNGOS <http://www.mangosproject.org/>
 *
 * Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
 *
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

// THIS FILE IS DEPRECATED

#ifndef LOOKING4GROUP_SYSTEMCONFIG_H
#define LOOKING4GROUP_SYSTEMCONFIG_H

#include "Platform/Define.h"
#include "revision.h"


#define _PACKAGENAME "Looking4GroupCore "
#define _CODENAME "YUME"

#if LOOKING4GROUP_ENDIAN == LOOKING4GROUP_BIGENDIAN
# define _ENDIAN_STRING "big-endian"
#else
# define _ENDIAN_STRING "little-endian"
#endif

#define VERSION_STR _PACKAGENAME "Rev: " REVISION_ID

#define DEFAULT_PLAYER_LIMIT 100
#define DEFAULT_WORLDSERVER_PORT 8085                       //8129
#define DEFAULT_REALMSERVER_PORT 3724
#define DEFAULT_SOCKET_SELECT_TIME 10000

// The path to config files
#ifndef SYSCONFDIR
# define SYSCONFDIR ""
#endif

#define _LOOKING4GROUP_CORE_CONFIG SYSCONFDIR "looking4groupcore.conf"
#define _LOOKING4GROUP_REALM_CONFIG SYSCONFDIR "trinityrealm.conf"

// Format is YYYYMMDDRR where RR is the change in the conf file
// for that day.
#ifndef _LOOKING4GROUP_CORE_CONFVER
# define _LOOKING4GROUP_CORE_CONFVER 2012070901
#endif //_LOOKING4GROUP_CORE_CONFVER

// Format is YYYYMMDDRR where RR is the change in the conf file
// for that day.
#ifndef _REALMDCONFVERSION
# define _REALMDCONFVERSION 2011092901
#endif

#endif

