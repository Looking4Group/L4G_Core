/*
 * Copyright (C) 2005-2011 MaNGOS <http://getmangos.com/>
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

/// \addtogroup realmd Realm Daemon
/// @{
/// \file

#include "Common.h"
#include "Database/DatabaseEnv.h"
#include "RealmList.h"

#include "Config/Config.h"
#include "Log.h"
#include "AuthSocket.h"
#include "SystemConfig.h"
#include "revision.h"
#include "Util.h"
#include <openssl/opensslv.h>
#include <openssl/crypto.h>

#include <ace/Get_Opt.h>
#include <ace/Dev_Poll_Reactor.h>
#include <ace/TP_Reactor.h>
#include <ace/ACE.h>
#include <ace/Acceptor.h>
#include <ace/SOCK_Acceptor.h>

#include <ace/Get_Opt.h>

#ifdef WIN32
#include "ServiceWin32.h"
char serviceName[] = "realmd";
char serviceLongName[] = "Trinity realm service";
char serviceDescription[] = "Massive Network Game Object Server";
#else
#include "PosixDaemon.h"
#endif

/*
 *  0 - not in daemon/service mode
 *  1 - windows service stopped
 *  2 - windows service running
 *  3 - windows service paused
 *  6 - linux daemon
 */

RunModes runMode = MODE_NORMAL;

bool StartDB();
void UnhookSignals();
void HookSignals();

bool stopEvent = false;                                     ///< Setting it to true stops the server

DatabaseType AccountsDatabase;                                 ///< Accessor to the realm server database

/// Print out the usage string for this program on the console.
void usage(const char *prog)
{
    sLog.outString("Usage: \n %s [<options>]\n"
        "    -v, --version            print version and exist\n\r"
        "    -c config_file           use config_file as configuration file\n\r"
        #ifdef WIN32
        "    Running as service functions:\n\r"
        "    -s run                   run as service\n\r"
        "    -s install               install service\n\r"
        "    -s uninstall             uninstall service\n\r"
        #else
        "    Running as daemon functions:\n\r"
        "    -s run                   run as daemon\n\r"
        "    -s stop                  stop daemon\n\r"
        #endif
        ,prog);
}

/// Launch the realm server
extern int main(int argc, char **argv)
{
    ///- Command line parsing
    char const* cfg_file = _LOOKING4GROUP_REALM_CONFIG;

    char const *options = ":c:s:";

    ACE_Get_Opt cmd_opts(argc, argv, options);
    cmd_opts.long_option("version", 'v');

    char serviceDaemonMode = '\0';

    int option;
    while ((option = cmd_opts()) != EOF)
    {
        switch (option)
        {
            case 'c':
                cfg_file = cmd_opts.opt_arg();
                break;
            case 'v':
                printf("%s\n", _FULLVERSION);
                return 0;

            case 's':
            {
                const char *mode = cmd_opts.opt_arg();

                if (!strcmp(mode, "run"))
                    serviceDaemonMode = 'r';
#ifdef WIN32
                else if (!strcmp(mode, "install"))
                    serviceDaemonMode = 'i';
                else if (!strcmp(mode, "uninstall"))
                    serviceDaemonMode = 'u';
#else
                else if (!strcmp(mode, "stop"))
                    serviceDaemonMode = 's';
#endif
                else
                {
                    printf("Runtime-Error: -%c unsupported argument %s", cmd_opts.opt_opt(), mode);
                    usage(argv[0]);
                    return 1;
                }
                break;
            }
            case ':':
                printf("Runtime-Error: -%c option requires an input argument", cmd_opts.opt_opt());
                usage(argv[0]);
                return 1;
            default:
                printf("Runtime-Error: bad format of commandline arguments");
                usage(argv[0]);
                return 1;
        }
    }

#ifdef WIN32                                                // windows service command need execute before config read
    switch (serviceDaemonMode)
    {
        case 'i':
            if (WinServiceInstall())
                printf("Installing service");
            return 1;
        case 'u':
            if (WinServiceUninstall())
                printf("Uninstalling service");
            return 1;
        case 'r':
            WinServiceRun();
            break;
    }
#endif

    if (!sConfig.SetSource(cfg_file))
    {
        printf("Could not find configuration file %s.", cfg_file);
        return 1;
    }

#ifndef WIN32                                               // posix daemon commands need apply after config read
    switch (serviceDaemonMode)
    {
        case 'r':
            startDaemon("Realm");
            break;
        case 's':
            stopDaemon();
            break;
    }
#endif

    sLog.Initialize();

    sLog.outString( "%s (realm-daemon)", _FULLVERSION );
    sLog.outString( "<Ctrl-C> to stop.\n" );
    sLog.outString("Using configuration file %s.", cfg_file);

    ///- Check the version of the configuration file
    uint32 confVersion = sConfig.GetIntDefault("ConfVersion", 0);
    if (confVersion < _REALMDCONFVERSION)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: **********************************************************************************");
        sLog.outLog(LOG_DEFAULT, "ERROR:  WARNING: Your trinityrealm.conf version indicates your conf file is out of date!");
        sLog.outLog(LOG_DEFAULT, "ERROR:           Please check for updates, as your current default values may cause");
        sLog.outLog(LOG_DEFAULT, "ERROR:           strange behavior.");
        sLog.outLog(LOG_DEFAULT, "ERROR: **********************************************************************************");
        clock_t pause = 3000 + clock();

        while (pause > clock()) {}
    }

    sLog.outDetail("%s (Library: %s)", OPENSSL_VERSION_TEXT, SSLeay_version(SSLEAY_VERSION));
    if (SSLeay() < 0x009080bfL )
    {
        sLog.outDetail("WARNING: Outdated version of OpenSSL lib. Logins to server may not work!");
        sLog.outDetail("WARNING: Minimal required version [OpenSSL 0.9.8k]");
    }

    sLog.outDetail("Using ACE: %s", ACE_VERSION);

#if defined (ACE_HAS_EVENT_POLL) || defined (ACE_HAS_DEV_POLL)
    ACE_Reactor::instance(new ACE_Reactor(new ACE_Dev_Poll_Reactor(ACE::max_handles(), 1), 1), true);
#else
    ACE_Reactor::instance(new ACE_Reactor(new ACE_TP_Reactor(), true), true);
#endif

    sLog.outBasic("Max allowed open files is %d", ACE::max_handles());

    /// realmd PID file creation
    std::string pidfile = sConfig.GetStringDefault("PidFile", "");
    if(!pidfile.empty())
    {
        uint32 pid = CreatePIDFile(pidfile);
        if( !pid )
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Cannot create PID file %s.\n", pidfile.c_str());
            return 1;
        }

        sLog.outString("Daemon PID: %u\n", pid);
    }

    ///- Initialize the database connection
    if(!StartDB())
        return 1;

    ///- Get the list of realms for the server
    sRealmList.Initialize(sConfig.GetIntDefault("RealmsStateUpdateDelay", 20));
    if (sRealmList.size() == 0)
        sLog.outLog(LOG_DEFAULT, "ERROR: No valid realms specified.");
    sRealmList.ChatboxOsName = sConfig.GetStringDefault("ChatboxClientOsName","");

#ifdef REGEX_NAMESPACE
    QueryResultAutoPtr result = AccountsDatabase.PQuery("SELECT ip_pattern, local_ip_pattern FROM pattern_banned");
    if (result)
    {
        AuthSocket::pattern_banned.clear();
        do
        {
            Field *fields = result->Fetch();
            AuthSocket::pattern_banned.push_back(std::make_pair(REGEX_NAMESPACE::regex(fields[0].GetString()), REGEX_NAMESPACE::regex(fields[1].GetString())));
        }
        while (result->NextRow());
    }
#else
        sLog.outLog(LOG_DEFAULT, "ERROR: No Valid Regex Library for your Compiler, the pattern_banned feature will be disabled");
#endif

    // cleanup query
    // set expired bans to inactive
    AccountsDatabase.Execute("DELETE FROM ip_banned WHERE unban_date <= UNIX_TIMESTAMP() AND unban_date <> ban_date");

    ///- Launch the listening network socket
    ACE_Acceptor<AuthSocket, ACE_SOCK_Acceptor> acceptor;

    uint16 rmport = sConfig.GetIntDefault("RealmServerPort", DEFAULT_REALMSERVER_PORT);
    std::string bind_ip = sConfig.GetStringDefault("BindIP", "0.0.0.0");

    ACE_INET_Addr bind_addr(rmport, bind_ip.c_str());

    if (acceptor.open(bind_addr, ACE_Reactor::instance(), ACE_NONBLOCK) == -1)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: TrinityRealm can not bind to %s:%d", bind_ip.c_str(), rmport);
        return 1;
    }

    ///- Catch termination signals
    HookSignals();

    ///- Handle affinity for multiple processors and process priority on Windows
    #ifdef WIN32
    {
        HANDLE hProcess = GetCurrentProcess();

        uint32 Aff = sConfig.GetIntDefault("UseProcessors", 0);
        if(Aff > 0)
        {
            ULONG_PTR appAff;
            ULONG_PTR sysAff;

            if(GetProcessAffinityMask(hProcess,&appAff,&sysAff))
            {
                ULONG_PTR curAff = Aff & appAff;            // remove non accessible processors

                if(!curAff )
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: Processors marked in UseProcessors bitmask (hex) %x not accessible for realmd. Accessible processors bitmask (hex): %x",Aff,appAff);
                }
                else
                {
                    if(SetProcessAffinityMask(hProcess,curAff))
                        sLog.outString("Using processors (bitmask, hex): %x", curAff);
                    else
                        sLog.outLog(LOG_DEFAULT, "ERROR: Can't set used processors (hex): %x", curAff);
                }
            }
        }

        bool Prio = sConfig.GetBoolDefault("ProcessPriority", false);

        if(Prio)
        {
            if(SetPriorityClass(hProcess,HIGH_PRIORITY_CLASS))
                sLog.outString("TrinityRealm process priority class set to HIGH");
            else
                sLog.outLog(LOG_DEFAULT, "ERROR: Can't set TrinityRealm process priority class.");
        }
    }
    #endif

    //server has started up successfully => enable async DB requests
    AccountsDatabase.AllowAsyncTransactions();
    AccountsDatabase.EnableLogging();

    // maximum counter for next ping
    uint32 numLoops = (sConfig.GetIntDefault("MaxPingTime", 30) * (MINUTE * 1000000 / 100000));
    uint32 loopCounter = 0;

#ifndef WIN32
    detachDaemon();
#endif

    ///- Wait for termination signal
    while (!stopEvent)
    {
        // dont move this outside the loop, the reactor will modify it
        ACE_Time_Value interval(0, 100000);

        if (ACE_Reactor::instance()->run_reactor_event_loop(interval) == -1)
            break;

        if( (++loopCounter) == numLoops )
        {
            loopCounter = 0;
            sLog.outDetail("Ping MySQL to keep connection alive");
            AccountsDatabase.Ping();
        }
#ifdef WIN32
        if (runMode == MODE_SERVICE_STOPPED)
            stopEvent = true;

        while (runMode == MODE_SERVICE_PAUSED)
            Sleep(1000);
#endif
    }

    ///- Wait for the delay thread to exit
    AccountsDatabase.HaltDelayThread();

    ///- Remove signal handling before leaving
    UnhookSignals();

    sLog.outString("Halting process...");
    return 0;
}

/// Handle termination signals
/** Put the global variable stopEvent to 'true' if a termination signal is caught **/
void OnSignal(int s)
{
    switch (s)
    {
        case SIGINT:
        case SIGTERM:
            stopEvent = true;
            break;
        #ifdef _WIN32
        case SIGBREAK:
            stopEvent = true;
            break;
        #endif
    }

    signal(s, OnSignal);
}

/// Initialize connection to the database
bool StartDB()
{
    std::string dbstring = sConfig.GetStringDefault("LoginDatabaseInfo", "");
    if(dbstring.empty())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Database not specified");
        return false;
    }

    //sLog.outString("Database: %s", dbstring.c_str() );

    if(!AccountsDatabase.Initialize(dbstring.c_str()))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Cannot connect to database");
        return false;
    }

    return true;
}

/// Define hook 'OnSignal' for all termination signals
void HookSignals()
{
    signal(SIGINT, OnSignal);
    signal(SIGTERM, OnSignal);
    #ifdef _WIN32
    signal(SIGBREAK, OnSignal);
    #endif
}

/// Unhook the signals before leaving
void UnhookSignals()
{
    signal(SIGINT, 0);
    signal(SIGTERM, 0);
    #ifdef _WIN32
    signal(SIGBREAK, 0);
    #endif
}

/// @}
