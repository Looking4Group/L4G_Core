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

/// \addtogroup Trinityd Trinity Daemon
/// @{
/// \file

#include "SystemConfig.h"
#include "revision.h"

#include "Common.h"
#include "Database/DatabaseEnv.h"
#include "Config/Config.h"
#include "ProgressBar.h"
#include "Log.h"
#include "Master.h"
#include "vmap/VMapCluster.h"

#include <ace/Get_Opt.h>

#ifdef WIN32
#include "ServiceWin32.h"
char serviceName[] = "Trinityd";
char serviceLongName[] = "Trinity core service";
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

DatabaseType GameDataDatabase;                              ///< Accessor to the world database
DatabaseType RealmDataDatabase;                             ///< Accessor to the character database
DatabaseType AccountsDatabase;                              ///< Accessor to the realm/login database

uint32 realmID;                                             ///< Id of the realm

/// Print out the usage string for this program on the console.
void usage(const char *prog)
{
    sLog.outString("Usage: \n %s [<options>]\n"
        "    -v, --version            print version and exit\n\r"
        "    -c config_file           use config_file as configuration file\n\r"
        #ifdef WIN32
        "    Running as service functions:\n\r"
        "    -s run                run as service\n\r"
        "    -s install               install service\n\r"
        "    -s uninstall             uninstall service\n\r"
        #endif
        , prog);
}

/// Launch the Trinity server
extern int main(int argc, char **argv)
{
    ///- Command line parsing
    char const* cfg_file = _LOOKING4GROUP_CORE_CONFIG;

    char const *options = ":a:c:s:p:i:";

    char const *process = 0;
    int process_id = 0;

    ACE_Get_Opt cmd_opts(argc, argv, options);
    cmd_opts.long_option("version", 'v', ACE_Get_Opt::NO_ARG);

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
                    printf("Runtime-Error: -%c unsupported argument %s\n", cmd_opts.opt_opt(), mode);
                    usage(argv[0]);
                    return 1;
                }
                break;
            }
            case 'p':
            {
                process = cmd_opts.opt_arg();
                break;
            }
            case 'i':
            {
                process_id = atoi(cmd_opts.opt_arg());
                break;
            }
            case ':':
                printf("Runtime-Error: -%c option requires an input argument\n", cmd_opts.opt_opt());
                usage(argv[0]);
                return 1;
            default:
                printf("Runtime-Error: bad format of commandline arguments\n");
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

    int vmapProcesses = sConfig.GetIntDefault("vmap.clusterProcesses", 1);
    bool vmapCluster = sConfig.GetBoolDefault("vmap.enableCluster", false);

    if(process)
    {
        if(strcmp(process, VMAP_CLUSTER_MANAGER_PROCESS) == 0)
        {
            VMAP::VMapClusterManager vmap_manager(vmapProcesses);
            return vmap_manager.Start();
        }
        else if(strcmp(process, VMAP_CLUSTER_PROCESS) == 0)
        {
            VMAP::VMapClusterProcess vmapProcess(process_id);
            return vmapProcess.Start();
        }
        else
            printf("Runtime-Error: bad format of process arguments\n");
            return 1;
    }

#ifdef USING_FIFO_PIPES
    if(vmapCluster)
    {
        ACE_OS::system("rm -f " VMAP_CLUSTER_PREFIX "*");
    }
#endif

#ifndef WIN32                                               // posix daemon commands need apply after config read
    switch (serviceDaemonMode)
    {
    case 'r':
        startDaemon("Core");
        runMode = MODE_DAEMON;
        break;
    case 's':
        stopDaemon();
        break;
    }
#endif

    sLog.Initialize();

    sLog.outString("Using configuration file %s.", cfg_file);

    uint32 confVersion = sConfig.GetIntDefault("ConfVersion", 0);
    if (confVersion < _LOOKING4GROUP_CORE_CONFVER)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: *********************************************************************************");
        sLog.outLog(LOG_DEFAULT, "ERROR:  WARNING: Your trinitycore.conf version indicates your conf file is out of date!");
        sLog.outLog(LOG_DEFAULT, "ERROR:           Please check for updates, as your current default values may cause");
        sLog.outLog(LOG_DEFAULT, "ERROR:           strange behavior.");
        sLog.outLog(LOG_DEFAULT, "ERROR: *********************************************************************************");
        clock_t pause = 3000 + clock();

        while (pause > clock()) {}
    }

    BarGoLink::SetOutputState(sConfig.GetBoolDefault("ShowProgressBars", false));


    if(vmapCluster)
        VMAP::VMapClusterManager::SpawnVMapProcesses(argv[0], cfg_file, vmapProcesses);

    ///- and run the 'Master'
    /// \todo Why do we need this 'Master'? Can't all of this be in the Main as for Realmd?
    return sMaster.Run();

    // at sMaster return function exist with codes
    // 0 - normal shutdown
    // 1 - shutdown at error
    // 2 - restart command used, this code can be used by restarter for restart Trinityd
}

/// @}
