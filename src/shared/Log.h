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

#ifndef TRINITYCORE_LOG_H
#define TRINITYCORE_LOG_H

#include "ace/Singleton.h"
#include "ace/Thread_Mutex.h"

#include "Common.h"

class Config;

// bitmask
enum LogFilters
{
    LOG_FILTER_TRANSPORT_MOVES    = 1,
    LOG_FILTER_CREATURE_MOVES     = 2,
    LOG_FILTER_VISIBILITY_CHANGES = 4
};

enum Color
{
    BLACK,
    RED,
    GREEN,
    BROWN,
    BLUE,
    MAGENTA,
    CYAN,
    GREY,
    YELLOW,
    LRED,
    LGREEN,
    LBLUE,
    LMAGENTA,
    LCYAN,
    WHITE
};

enum LogNames
{
    LOG_GM              = 0,
    LOG_DEFAULT         = 1,
    LOG_STATUS          = 2,
    LOG_CHAR            = 3,
    LOG_DB_ERR          = 4,
    LOG_ARENA           = 5,
    LOG_CHEAT           = 6,
    LOG_SPECIAL         = 7,
    LOG_MAIL            = 8,
    LOG_GUILD_ANN       = 9,
    LOG_BOSS            = 10,
    LOG_WARDEN          = 11,
    LOG_AUCTION         = 12,
    LOG_DIFF            = 13,
    LOG_SESSION_DIFF    = 14,
    LOG_CRASH           = 15,
    LOG_DB_DIFF         = 16,
    LOG_EXP             = 17,
    LOG_TRADE           = 18,
    LOG_RACE_CHANGE     = 19,

    LOG_MAX_FILES
};

const int Color_count = int(WHITE)+1;

class Log
{
    friend class ACE_Singleton<Log, ACE_Thread_Mutex>;
    Log();

    ~Log()
    {
        for (uint8 i = LOG_DEFAULT; i < LOG_MAX_FILES; i++)
        {
            if (logFile[i] != NULL)
                fclose(logFile[i]);

            logFile[i] = NULL;
        }
    }

    public:
        void Initialize();
        void InitColors(const std::string& init_str);
        void outTitle(const char * str);
        void outCommand(uint32 account, const char * str, ...) ATTR_PRINTF(3,4);
                                                            // any log level
        void outString();
        void outString(const char * str, ...)       ATTR_PRINTF(2, 3);
        void outLog(LogNames log, const char * str, ...) ATTR_PRINTF(3, 4);
                                                            // log level >= 1
        void outBasic(const char * str, ...)        ATTR_PRINTF(2, 3);
                                                            // log level >= 2
        void outDetail(const char * str, ...)       ATTR_PRINTF(2, 3);
                                                            // log level >= 3
        void outDebugInLine(const char * str, ...)  ATTR_PRINTF(2, 3);
                                                            // log level >= 3
        void outDebug(const char * str, ...)        ATTR_PRINTF(2, 3);
                                                            // any log level
        void outWhisp(uint32 account, const char * str, ...) ATTR_PRINTF(3, 4);
        void outPacket(uint32 glow, const char * str, ...) ATTR_PRINTF(3, 4);

        void SetLogLevel(char * Level);
        void SetLogFileLevel(char * Level);
        void SetColor(bool stdout_stream, Color color);
        void ResetColor(bool stdout_stream);
        void outTime();
        static bool outTimestamp(FILE* file);
        static std::string GetTimestampStr();
        uint32 getLogFilter() const { return m_logFilter; }
        bool IsOutDebug() const { return m_logLevel > 2 || (m_logFileLevel > 2 && logFile[LOG_DEFAULT]); }
        bool IsOutCharDump() const { return m_charLog_Dump; }
        bool IsIncludeTime() const { return m_includeTime; }

        bool IsLogEnabled(LogNames log) const { return logFile[log] != NULL; }

    private:
        FILE* openLogFile(LogNames log);
        FILE* openGmlogPerAccount(uint32 account);

        FILE *logFile[LOG_MAX_FILES];
        std::string logFileNames[LOG_MAX_FILES];

        FILE* openWhisplogPerAccount(uint32 account);

        // log/console control
        uint32 m_logLevel;
        uint32 m_logFileLevel;
        bool m_colored;
        bool m_includeTime;
        Color m_colors[4];
        uint32 m_logFilter;

        // cache values for after initilization use (like gm log per account case)
        std::string m_logsDir;
        std::string m_logsTimestamp;

        // char log control
        bool m_charLog_Dump;

        // gm log control
        bool m_gmlog_per_account;

        std::string m_gmlog_filename_format;

        std::string m_whisplog_filename_format;
};

#define sLog (*ACE_Singleton<Log, ACE_Thread_Mutex>::instance())

#ifdef LOOKING4GROUP_DEBUG
#define DEBUG_LOG sLog.outDebug
#else
#define DEBUG_LOG
#endif

// primary for script library
void outstring_log(const char * str, ...) ATTR_PRINTF(1,2);
void detail_log(const char * str, ...) ATTR_PRINTF(1,2);
void debug_log(const char * str, ...) ATTR_PRINTF(1,2);
void error_log(const char * str, ...) ATTR_PRINTF(1,2);
void error_db_log(const char * str, ...) ATTR_PRINTF(1,2);

// old clean assert from Errors.h
//#define ASSERT(assertion) { if(!(assertion)) { fprintf(stderr, "\n%s:%i ASSERTION FAILED:\n  %s\n", __FILE__, __LINE__, #assertion); assert(#assertion &&0); } }

// i think we should use this assert, cause we see asserts in log files, not only on console (mostly we dont't see it cause the server restarts)
#define ASSERT(assertion) { if(!(assertion)) { error_log("ERROR: %s:%i ASSERTION FAILED:\n  %s\n", __FILE__, __LINE__, #assertion); assert(#assertion &&0); } }

#endif
