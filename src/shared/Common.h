/*
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * Copyright (C) 2008-2010 Trinity <http://www.trinitycore.org/>
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

#ifndef TRINITYCORE_COMMON_H
#define TRINITYCORE_COMMON_H

// config.h needs to be included 1st
// TODO this thingy looks like hack ,but its not, need to
// make separate header however, because It makes mess here.
#ifdef HAVE_CONFIG_H
// Remove Some things that we will define
// This is in case including another config.h
// before trinity config.h
#ifdef PACKAGE
#undef PACKAGE
#endif //PACKAGE
#ifdef PACKAGE_BUGREPORT
#undef PACKAGE_BUGREPORT
#endif //PACKAGE_BUGREPORT
#ifdef PACKAGE_NAME
#undef PACKAGE_NAME
#endif //PACKAGE_NAME
#ifdef PACKAGE_STRING
#undef PACKAGE_STRING
#endif //PACKAGE_STRING
#ifdef PACKAGE_TARNAME
#undef PACKAGE_TARNAME
#endif //PACKAGE_TARNAME
#ifdef PACKAGE_VERSION
#undef PACKAGE_VERSION
#endif //PACKAGE_VERSION
#ifdef VERSION
#undef VERSION
#endif //VERSION
# include "config.h"
#undef PACKAGE
#undef PACKAGE_BUGREPORT
#undef PACKAGE_NAME
#undef PACKAGE_STRING
#undef PACKAGE_TARNAME
#undef PACKAGE_VERSION
#undef VERSION
#endif //HAVE_CONFIG_H

#include "Platform/Define.h"

#if COMPILER == COMPILER_MICROSOFT
#   pragma warning(disable:4996)                            // 'function': was declared deprecated
#ifndef __SHOW_STUPID_WARNINGS__
#   pragma warning(disable:4005)                            // 'identifier' : macro redefinition
#   pragma warning(disable:4018)                            // 'expression' : signed/unsigned mismatch
#   pragma warning(disable:4244)                            // 'argument' : conversion from 'type1' to 'type2', possible loss of data
#   pragma warning(disable:4267)                            // 'var' : conversion from 'size_t' to 'type', possible loss of data
#   pragma warning(disable:4305)                            // 'identifier' : truncation from 'type1' to 'type2'
#   pragma warning(disable:4311)                            // 'variable' : pointer truncation from 'type' to 'type'
#   pragma warning(disable:4355)                            // 'this' : used in base member initializer list
#   pragma warning(disable:4800)                            // 'type' : forcing value to bool 'true' or 'false' (performance warning)
#   pragma warning(disable:4522)                            //warning when class has 2 constructors
#endif                                                      // __SHOW_STUPID_WARNINGS__
#endif                                                      // __GNUC__

#include "Utilities/UnorderedMap.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <errno.h>
#include <signal.h>
#include <assert.h>

#if PLATFORM == PLATFORM_WINDOWS
#define STRCASECMP stricmp
#else
#define STRCASECMP strcasecmp
#endif

#include <set>
#include <list>
#include <string>
#include <map>
#include <queue>
#include <sstream>
#include <algorithm>

#include "LockedQueue.h"
#include "Threading.h"

#include <ace/Basic_Types.h>
#include <ace/Guard_T.h>
#include <ace/RW_Thread_Mutex.h>
#include <ace/Thread_Mutex.h>

#if PLATFORM == PLATFORM_WINDOWS
#  define FD_SETSIZE 4096
#  include <ace/config-all.h>
// XP winver - needed to compile with standard leak check in MemoryLeaks.h
// uncomment later if needed
//#define _WIN32_WINNT 0x0501
#  include <ws2tcpip.h>
//#undef WIN32_WINNT
#else
#  include <sys/types.h>
#  include <sys/ioctl.h>
#  include <sys/socket.h>
#  include <netinet/in.h>
#  include <unistd.h>
#  include <netdb.h>
#endif

#if COMPILER == COMPILER_MICROSOFT

#include <float.h>

#define I32FMT "%08I32X"
#define I64FMT "%016I64X"
#define snprintf _snprintf
#define atoll __atoi64
#define vsnprintf _vsnprintf
#define finite(X) _finite(X)

#else

#define stricmp strcasecmp
#define strnicmp strncasecmp
#define I32FMT "%08X"
#define I64FMT "%016llX"

#endif

#define UI64FMTD ACE_UINT64_FORMAT_SPECIFIER
#define UI64LIT(N) ACE_UINT64_LITERAL(N)

#define SI64FMTD ACE_INT64_FORMAT_SPECIFIER
#define SI64LIT(N) ACE_INT64_LITERAL(N)

#define SIZEFMTD ACE_SIZE_T_FORMAT_SPECIFIER

inline float finiteAlways(float f) { return finite(f) ? f : 0.0f; }

#define atol(a) strtoul( a, NULL, 10)

#define STRINGIZE(a) #a

enum TimeConstants
{
    MINUTE = 60,
    HOUR   = MINUTE*60,
    DAY    = HOUR*24,
    WEEK   = DAY*7,
    MONTH  = DAY*30,
    YEAR   = MONTH*12,
    IN_MILISECONDS = 1000
};

enum AccountPermissionMasks
{
    PERM_PLAYER         = 0x000001,
    PERM_DEVELOPER      = 0x000002,

    VIP                 = 0x000100,
    PERM_GM_HELPER      = 0x000200,

    PERM_GM_HEAD        = 0x000800,

    PERM_ADM_NORM       = 0x001000,
    PERM_ADM_HEAD       = 0x002000,

    PERM_CONSOLE        = 0x800000,

    PERM_GMT            = PERM_GM_HELPER | PERM_GM_HEAD,
    PERM_ADM            = PERM_ADM_NORM | PERM_ADM_HEAD,
    PERM_HIGH_GMT       = PERM_ADM | PERM_GM_HEAD,
    PERM_GMT_DEV        = PERM_GMT | PERM_DEVELOPER,
    PERM_HIGH_DEV       = PERM_HIGH_GMT | PERM_DEVELOPER,
    PERM_ALL            = PERM_PLAYER | PERM_GMT_DEV | PERM_ADM
};

enum AccountStates
{
    ACCOUNT_STATE_ACTIVE    = 1,
    ACCOUNT_STATE_IP_LOCKED = 2,
    ACCOUNT_STATE_FROZEN    = 3
};

enum PunishmentTypes
{
    PUNISHMENT_MUTE     = 1,
    PUNISHMENT_BAN      = 2
};

enum ClientOSVersion
{
    CLIENT_OS_UNKNOWN   = 0,        // unknown system client
    CLIENT_OS_WIN       = 1,        // Windows client
    CLIENT_OS_OSX       = 2,        // OSX client
    CLIENT_OS_CHAT      = 3,        // WoW Chat client
};

// Used in mangosd/realmd
enum RealmFlags
{
    REALM_FLAG_NONE         = 0x00,
    REALM_FLAG_INVALID      = 0x01,
    REALM_FLAG_OFFLINE      = 0x02,
    REALM_FLAG_SPECIFYBUILD = 0x04,                         // client will show realm version in RealmList screen in form "RealmName (major.minor.revision.build)"
    REALM_FLAG_UNK1         = 0x08,
    REALM_FLAG_UNK2         = 0x10,
    REALM_FLAG_NEW_PLAYERS  = 0x20,
    REALM_FLAG_RECOMMENDED  = 0x40,
    REALM_FLAG_FULL         = 0x80
};

enum LocaleConstant
{
    LOCALE_enUS = 0,
    LOCALE_koKR = 1,
    LOCALE_frFR = 2,
    LOCALE_deDE = 3,
    LOCALE_zhCN = 4,
    LOCALE_zhTW = 5,
    LOCALE_esES = 6,
    LOCALE_esMX = 7,
    LOCALE_ruRU = 8
};

#define MAX_LOCALE 9

extern char const* localeNames[MAX_LOCALE];

LocaleConstant GetLocaleByName(const std::string& name);

//operator new[] based version of strdup() function! Release memory by using operator delete[] !
inline char * mangos_strdup(const char * source)
{
    const size_t length = strlen(source);
    char * dest = new char[length + 1];
    //set terminating end-of-string symbol
    dest[length] = 0;
    strcpy(dest, source);
    return dest;
}

enum RunModes
{
    MODE_NORMAL             = 0,
    MODE_SERVICE_STOPPED    = 1,
    MODE_SERVICE_RUNNING    = 2,
    MODE_SERVICE_PAUSED     = 3,

    MODE_DAEMON             = 6
};

// we always use stdlibc++ std::max/std::min, undefine some not C++ standard defines (Win API and some other platforms)
#ifdef max
#undef max
#endif

#ifdef min
#undef min
#endif

#ifndef M_PI
#define M_PI            3.14159265358979323846
#endif

// used for creating values for respawn for example
#define MAKE_PAIR64(l, h)  uint64(uint32(l) | (uint64(h) << 32))
#define PAIR64_HIPART(x)   (uint32)((uint64(x) >> 32) & UI64LIT(0x00000000FFFFFFFF))
#define PAIR64_LOPART(x)   (uint32)(uint64(x)         & UI64LIT(0x00000000FFFFFFFF))

#define MAKE_PAIR32(l, h)  uint32(uint16(l) | (uint32(h) << 16))
#define PAIR32_HIPART(x)   (uint16)((uint32(x) >> 16) & 0x0000FFFF)
#define PAIR32_LOPART(x)   (uint16)(uint32(x)         & 0x0000FFFF)

#ifdef MAP_UPDATE_DIFF_INFO
    #define MAP_UPDATE_DIFF(t) t;
#else
    #define MAP_UPDATE_DIFF(t)
#endif

#endif
