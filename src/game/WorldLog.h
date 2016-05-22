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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/// \addtogroup u2w
/// @{
/// \file

#ifndef LOOKING4GROUP_WORLDLOG_H
#define LOOKING4GROUP_WORLDLOG_H

#include "ace/Singleton.h"

#include "Common.h"
#include "Log.h"

#include <stdarg.h>

/// %Log packets to a file
class WorldLog
{
    friend class ACE_Singleton<WorldLog, ACE_Thread_Mutex>;
    WorldLog() : i_file(NULL) { Initialize(); }
    WorldLog(const WorldLog &);
    WorldLog& operator=(const WorldLog &);

    ACE_Thread_Mutex Lock;

    /// Close the file in destructor
    ~WorldLog()
    {
        if (i_file != NULL)
            fclose(i_file);
        i_file = NULL;
    }

    public:
        void Initialize();
        /// Is the world logger active?
        bool LogWorld(void) const { return (i_file != NULL); }
        /// %Log to the file
        void Log(char const *fmt, ...)
        {
            if (LogWorld())
            {
                ACE_GUARD(ACE_Thread_Mutex, Guard, Lock);
                //ASSERT(i_file);

                va_list args;
                va_start(args, fmt);
                vfprintf(i_file, fmt, args);
                va_end(args);

                fflush(i_file);
            }
        }

    private:
        FILE *i_file;
};

#define sWorldLog (*ACE_Singleton<WorldLog, ACE_Thread_Mutex>::instance())

#endif
/// @}
