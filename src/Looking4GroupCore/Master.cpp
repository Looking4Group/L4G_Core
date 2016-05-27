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

/** \file
    \ingroup Trinityd
*/

#include <ace/OS_NS_signal.h>
#include <ace/Stack_Trace.h>

#include "WorldSocketMgr.h"
#include "Common.h"
#include "Master.h"
#include "WorldSocket.h"
#include "WorldRunnable.h"
#include "World.h"
#include "Log.h"
#include "MapManager.h"
#include "Timer.h"
#include "SystemConfig.h"
#include "Config/Config.h"
#include "Database/DatabaseEnv.h"
#include "CliRunnable.h"
#include "ScriptMgr.h"
#include "Util.h"
#include "DBCStores.h"

#ifdef WIN32
#include "ServiceWin32.h"
#else
#include "PosixDaemon.h"
#endif

extern RunModes runMode;
volatile uint32 Master::m_masterLoopCounter = 0;

class FreezeDetectorRunnable : public ACE_Based::Runnable
{
public:
    FreezeDetectorRunnable() { _delaytime = 0; }
    uint32 m_loops, m_lastchange;
    uint32 w_loops, w_lastchange;
    uint32 _delaytime;
    uint32 freezeCheckPeriod;
    void SetDelayTime(uint32 t) { _delaytime = t; }
    void run(void)
    {
        if(!_delaytime)
            return;

        m_loops = 0;
        w_loops = 0;
        m_lastchange = 0;
        w_lastchange = 0;

        freezeCheckPeriod = sWorld.getConfig(CONFIG_VMSS_FREEZECHECKPERIOD);
        sLog.outString("Starting up anti-freeze thread (%u seconds max stuck time)...", _delaytime / 1000);

        while(!World::IsStopped())
        {
            ACE_Based::Thread::Sleep(freezeCheckPeriod);

            sMapMgr.GetMapUpdater()->FreezeDetect();

            uint32 curtime = WorldTimer::getMSTime();
            //DEBUG_LOG("anti-freeze: time=%u, counters=[%u; %u]",curtime,Master::m_masterLoopCounter,World::m_worldLoopCounter);

            // normal work
            if(w_loops != World::m_worldLoopCounter)
            {
                w_lastchange = curtime;
                w_loops = World::m_worldLoopCounter;
            }
            // possible freeze
            else
            {
                if(WorldTimer::getMSTimeDiff(w_lastchange,curtime) > _delaytime)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: World Thread hangs, kicking out server!");
                    *((uint32 volatile*)NULL) = 0;                       // bang crash
                }
            }
        }
        sLog.outString("Anti-freeze thread exiting without problems.");
    }
};

Master::Master()
{
}

Master::~Master()
{
}

/// Main function
int Master::Run()
{
    sLog.outString("%s (core-daemon)", _FULLVERSION);
    sLog.outString("<Ctrl-C> to stop.\n");
    /*
    sLog.outTitle(" ______                       __");
    sLog.outTitle("/\\__  _\\       __          __/\\ \\__");
    sLog.outTitle("\\/_/\\ \\/ _ __ /\\_\\    ___ /\\_\\ \\ ,_\\  __  __");
    sLog.outTitle("   \\ \\ \\/\\`'__\\/\\ \\ /' _ `\\/\\ \\ \\ \\/ /\\ \\/\\ \\");
    sLog.outTitle("    \\ \\ \\ \\ \\/ \\ \\ \\/\\ \\/\\ \\ \\ \\ \\ \\_\\ \\ \\_\\ \\");
    sLog.outTitle("     \\ \\_\\ \\_\\  \\ \\_\\ \\_\\ \\_\\ \\_\\ \\__\\\\/`____ \\");
    sLog.outTitle("      \\/_/\\/_/   \\/_/\\/_/\\/_/\\/_/\\/__/ `/___/> \\");
    sLog.outTitle("                                 C O R E  /\\___/");
    sLog.outTitle("http://TrinityCore.org                    \\/__/\n");
    */
    sLog.outString("||           //|       ======");
    sLog.outString("||          //||      //     \\");
    sLog.outString("||         // ||     //");
    sLog.outString("||        //  ||    ||    ==== ");
    sLog.outString("||       =====||==  ||       ||");
    sLog.outString("||            ||     \\       ||");
    sLog.outString("=========     ||      ========/");
    sLog.outString("                       C O R E");
    sLog.outString("http://looking4group.de");

    /// worldd PID file creation
    std::string pidfile = sConfig.GetStringDefault("PidFile", "");
    if(!pidfile.empty())
    {
        uint32 pid = CreatePIDFile(pidfile);
        if(!pid)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Cannot create PID file %s.\n", pidfile.c_str());
            return 1;
        }

        sLog.outString("Daemon PID: %u\n", pid);
    }

#ifndef WIN32
    detachDaemon();
#endif

    ///- Start the databases
    if (!_StartDB())
        return 1;

    // set server offline (not connectable)
    AccountsDatabase.DirectPExecute("UPDATE realms SET flags = %u WHERE realm_id = '%d'", REALM_FLAG_OFFLINE, realmID);

    ///- Initialize the World
    sWorld.SetInitialWorldSettings();

    //server loaded successfully => enable async DB requests
    //this is done to forbid any async transactions during server startup!
    RealmDataDatabase.AllowAsyncTransactions();
    GameDataDatabase.AllowAsyncTransactions();
    AccountsDatabase.AllowAsyncTransactions();

    RealmDataDatabase.EnableLogging();
    GameDataDatabase.EnableLogging();
    AccountsDatabase.EnableLogging();

    ACE_SIGACTION action;
    action.sa_handler = _OnSignal;
    action.sa_flags = 0; //SA_RESTART

    ACE_OS::sigemptyset(&action.sa_mask);
    ACE_OS::sigaction(SIGTERM, &action, NULL);

    // Register signal handlers.
    ACE_OS::sigaction(SIGINT, &action, NULL);
    ACE_OS::sigaction(SIGTERM, &action, NULL);

    #ifdef _WIN32
    ACE_OS::sigaction(SIGBREAK, &action, NULL);
    #endif

    if (sWorld.getConfig(CONFIG_VMSS_ENABLE))
    {
        // VMSS handler
        ACE_OS::sigaction(SIGFPE, &action, NULL);
        ACE_OS::sigaction(SIGABRT, &action, NULL);
        ACE_OS::sigaction(SIGSEGV, &action, NULL);
    }

    ///- Launch WorldRunnable thread
    ACE_Based::Thread world_thread(new WorldRunnable);
    world_thread.setPriority(ACE_Based::Highest);

    // set realmbuilds depend on realm expected builds, and set server online
    {
        std::string builds = AcceptableClientBuildsListStr();
        AccountsDatabase.escape_string(builds);
        AccountsDatabase.DirectPExecute("UPDATE realms SET flags = flags & ~(%u), population = 0, allowed_builds = '%s'  WHERE realm_id = '%u'", REALM_FLAG_OFFLINE, builds.c_str(), realmID);
    }

    // console should be disabled in service/daemon mode
    if (sConfig.GetBoolDefault("Console.Enable", true) && (runMode == MODE_NORMAL))
    {
        ///- Launch CliRunnable thread
        ACE_Based::Thread cli_thread(new CliRunnable);
    }

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

                if(!curAff)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: Processors marked in UseProcessors bitmask (hex) %x not accessible for Trinityd. Accessible processors bitmask (hex): %x", Aff, appAff);
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

        //if(Prio && (m_ServiceStatus == -1)/* need set to default process priority class in service mode*/)
        if(Prio)
        {
            if(SetPriorityClass(hProcess, HIGH_PRIORITY_CLASS))
                sLog.outString("TrinityCore process priority class set to HIGH");
            else
                sLog.outLog(LOG_DEFAULT, "ERROR: Can't set TrinityCore process priority class.");
        }
    }
    #endif

    uint32 realCurrTime, realPrevTime;
    realCurrTime = realPrevTime = WorldTimer::getMSTime();

    uint32 socketSelecttime = sWorld.getConfig(CONFIG_SOCKET_SELECTTIME);

    // maximum counter for next ping
    uint32 numLoops = (sConfig.GetIntDefault("MaxPingTime", 30) * (MINUTE * 1000000 / socketSelecttime));
    uint32 loopCounter = 0;

    ///- Start up freeze catcher thread
    ACE_Based::Thread* freeze_thread = NULL;
    uint32 freeze_delay = sConfig.GetIntDefault("MaxCoreStuckTime", 0);
    if(freeze_delay)
    {
        FreezeDetectorRunnable *fdr = new FreezeDetectorRunnable();
        fdr->SetDelayTime(freeze_delay * 1000);
        freeze_thread = new ACE_Based::Thread(fdr);
        freeze_thread->setPriority(ACE_Based::Highest);
    }

    ///- Launch the world listener socket
    uint16 wsport = sWorld.getConfig(CONFIG_PORT_WORLD);
    std::string bind_ip = sConfig.GetStringDefault("BindIP", "0.0.0.0");

    if (sWorldSocketMgr->StartNetwork(wsport, bind_ip) == -1)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Failed to start network");
        World::StopNow(ERROR_EXIT_CODE);
        // go down and shutdown the server
    }

    sWorldSocketMgr->Wait();

    ///- Set server offline in realms
    AccountsDatabase.DirectPExecute("UPDATE realms SET flags = flags | %u WHERE realm_id = '%u'", REALM_FLAG_OFFLINE, realmID);

    // when the main thread closes the singletons get unloaded
    // since worldrunnable uses them, it will crash if unloaded after master
    world_thread.wait();

    ///- Clean database before leaving
    clearOnlineAccounts();

    sLog.outString("Halting process...");

    #ifdef WIN32
    if (sConfig.GetBoolDefault("Console.Enable", true))
    {
        // this only way to terminate CLI thread exist at Win32 (alt. way exist only in Windows Vista API)
        //_exit(1);
        // send keyboard input to safely unblock the CLI thread
        INPUT_RECORD b[5];
        HANDLE hStdIn = GetStdHandle(STD_INPUT_HANDLE);
        b[0].EventType = KEY_EVENT;
        b[0].Event.KeyEvent.bKeyDown = TRUE;
        b[0].Event.KeyEvent.uChar.AsciiChar = 'X';
        b[0].Event.KeyEvent.wVirtualKeyCode = 'X';
        b[0].Event.KeyEvent.wRepeatCount = 1;

        b[1].EventType = KEY_EVENT;
        b[1].Event.KeyEvent.bKeyDown = FALSE;
        b[1].Event.KeyEvent.uChar.AsciiChar = 'X';
        b[1].Event.KeyEvent.wVirtualKeyCode = 'X';
        b[1].Event.KeyEvent.wRepeatCount = 1;

        b[2].EventType = KEY_EVENT;
        b[2].Event.KeyEvent.bKeyDown = TRUE;
        b[2].Event.KeyEvent.dwControlKeyState = 0;
        b[2].Event.KeyEvent.uChar.AsciiChar = '\r';
        b[2].Event.KeyEvent.wVirtualKeyCode = VK_RETURN;
        b[2].Event.KeyEvent.wRepeatCount = 1;
        b[2].Event.KeyEvent.wVirtualScanCode = 0x1c;

        b[3].EventType = KEY_EVENT;
        b[3].Event.KeyEvent.bKeyDown = FALSE;
        b[3].Event.KeyEvent.dwControlKeyState = 0;
        b[3].Event.KeyEvent.uChar.AsciiChar = '\r';
        b[3].Event.KeyEvent.wVirtualKeyCode = VK_RETURN;
        b[3].Event.KeyEvent.wVirtualScanCode = 0x1c;
        b[3].Event.KeyEvent.wRepeatCount = 1;
        DWORD numb;
        BOOL ret = WriteConsoleInput(hStdIn, b, 4, &numb);
    }
    #endif

    ///- Wait for delay threads to end
    RealmDataDatabase.HaltDelayThread();
    GameDataDatabase.HaltDelayThread();
    AccountsDatabase.HaltDelayThread();

    // Exit the process with specified return value
    delete freeze_thread;
    return World::GetExitCode();
}

/// Initialize connection to the databases
bool Master::_StartDB()
{
    ///- Get world database info from configuration file
    std::string dbstring = sConfig.GetStringDefault("WorldDatabaseInfo", "");
    if(dbstring.empty())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Database not specified in configuration file");
        return false;
    }

    int nConnections = sConfig.GetIntDefault("WorldDatabaseConnections", 1);
    sLog.outString("World Database: total connections: %i", nConnections + 1);

    ///- Initialise the world database
    if(!GameDataDatabase.Initialize(dbstring.c_str(), nConnections))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Cannot connect to world database.");
        return false;
    }

    dbstring = sConfig.GetStringDefault("CharacterDatabaseInfo", "");
    if(dbstring.empty())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Character Database not specified in configuration file");
        return false;
    }
    nConnections = sConfig.GetIntDefault("CharacterDatabaseConnections", 1);
    sLog.outString("Character Database: total connections: %i", nConnections + 1);

    ///- Initialise the Character database
    if(!RealmDataDatabase.Initialize(dbstring.c_str(), nConnections))
    {
         sLog.outLog(LOG_DEFAULT, "ERROR: Cannot connect to characters database.");
        return false;
    }

    ///- Get login database info from configuration file
    dbstring = sConfig.GetStringDefault("LoginDatabaseInfo", "");
    if(dbstring.empty())
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Login database not specified in configuration file");
        return false;
    }
    nConnections = sConfig.GetIntDefault("LoginDatabaseConnections", 1);
    ///- Initialise the login database
    sLog.outString("Login Database: total connections: %i", nConnections + 1);
    if(!AccountsDatabase.Initialize(dbstring.c_str(), nConnections))
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Cannot connect to login database.");
        return false;
    }

    ///- Get the realm Id from the configuration file
    realmID = sConfig.GetIntDefault("RealmID", 0);
    if(!realmID)
    {
        sLog.outLog(LOG_DEFAULT, "ERROR: Realm ID not defined in configuration file");
        return false;
    }
    sLog.outString("Realm running as realm ID %d", realmID);

    ///- Clean the database before starting
    clearOnlineAccounts();

    ///- Insert version info into DB
    GameDataDatabase.PExecute("UPDATE `version` SET `core_version` = '%s', `core_revision` = '%s'", _FULLVERSION, _REVISION);

    sWorld.LoadDBVersion();

    //sLog.outString("Using %s", sWorld.GetDBVersion());
    return true;
}

/// Clear 'online' status for all accounts with characters in this realm
void Master::clearOnlineAccounts()
{
    // Cleanup online status for characters hosted at current realm
    QueryResultAutoPtr result = RealmDataDatabase.Query("SELECT DISTINCT account FROM characters WHERE online <> 0");

    if (!result)
        return;

    Field * fields = result->Fetch();
    SqlStatementID updateAccount;

    AccountsDatabase.BeginTransaction();
    do
    {
        SqlStatement stmt = AccountsDatabase.CreateStatement(updateAccount, "UPDATE account SET online = 0 WHERE account_id = ?");
        stmt.PExecute(fields[0].GetUInt32());
    }
    while (result->NextRow());
    AccountsDatabase.CommitTransaction();

    RealmDataDatabase.Execute("UPDATE characters SET online = 0");
}

/// Handle termination signals
void Master::_OnSignal(int s)
{
    switch (s)
    {
        case SIGFPE:
        case SIGSEGV:
        case SIGABRT:
        {
            ACE_thread_t const threadId = ACE_OS::thr_self();
            ACE_Stack_Trace stackTrace;
            if (MapUpdateInfo const* mapUpdateInfo = sMapMgr.GetMapUpdater()->GetMapUpdateInfo(threadId))
            {
                sLog.outLog(LOG_CRASH, "CRASH[%i]: mapid: %u, instanceid: %u", s, mapUpdateInfo->GetId(), mapUpdateInfo->GetInstanceId());
                sLog.outLog(LOG_CRASH, "\r\n************ BackTrace *************\r\n%s\r\n***********************************\r\n", stackTrace.c_str());

                if (Map *map = sMapMgr.FindMap(mapUpdateInfo->GetId(), mapUpdateInfo->GetInstanceId()))
                    map->SetBroken(true);

                sMapMgr.GetMapUpdater()->unregister_thread(ACE_OS::thr_self());
                sMapMgr.GetMapUpdater()->update_finished();
            }
            else
            {
                sLog.outLog(LOG_CRASH, "Signal Handler: Thread is not virtual map server. Stopping world.");
                sLog.outLog(LOG_CRASH, "\r\n************ BackTrace *************\r\n%s\r\n***********************************\r\n", stackTrace.c_str());
            }


            ACE_SIGACTION action;
            action.sa_handler = SIG_DFL;
            action.sa_flags = 0; //SA_RESTART

            ACE_OS::sigaction(s, &action, NULL);
            ACE_OS::kill(getpid(), s);
            break;
        }
        case SIGINT:
            World::StopNow(RESTART_EXIT_CODE);
            break;
        #ifdef _WIN32
        case SIGBREAK:
            World::StopNow(SHUTDOWN_EXIT_CODE);
            break;
        #endif
        default:
            break;
    }
}
