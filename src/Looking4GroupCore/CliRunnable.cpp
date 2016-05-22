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

/// \addtogroup Trinityd
/// @{
/// \file

#include "Common.h"
#include "Language.h"
#include "Log.h"
#include "World.h"
#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "WorldSession.h"
#include "Config/Config.h"
#include "Util.h"
#include "AccountMgr.h"
#include "CliRunnable.h"
#include "MapManager.h"
#include "Player.h"
#include "Chat.h"

#if PLATFORM != WINDOWS
#include <readline/readline.h>
#include <readline/history.h>

char * command_finder(const char* text, int state)
{
  static int idx,len;
  const char* ret;
  ChatCommand *cmd = ChatHandler::getCommandTable();

  if(!state)
    {
      idx = 0;
      len = strlen(text);
    }

  while(ret = cmd[idx].Name)
    {
      if(!cmd[idx].AllowConsole)
    {
    idx++;
    continue;
    }

      idx++;
      //printf("Checking %s \n", cmd[idx].Name);
      if (strncmp(ret, text, len) == 0)
    return mangos_strdup(ret);
      if(cmd[idx].Name == NULL)
    break;
    }

  return ((char*)NULL);

}

char ** cli_completion(const char * text, int start, int end)
{
  char ** matches;
  matches = (char**)NULL;

  if(start == 0)
    matches = rl_completion_matches((char*)text,&command_finder);
  else
    rl_bind_key('\t',rl_abort);
  return (matches);
}

#endif

void utf8print(const char* str)
{
#if PLATFORM == PLATFORM_WINDOWS
    wchar_t wtemp_buf[6000];
    size_t wtemp_len = 6000-1;
    if(!Utf8toWStr(str,strlen(str),wtemp_buf,wtemp_len))
        return;

    char temp_buf[6000];
    CharToOemBuffW(&wtemp_buf[0],&temp_buf[0],wtemp_len+1);
    printf(temp_buf);
#else
    printf(str);
#endif
}

/// Delete a user account and all associated characters in this realm
/// \todo This function has to be enhanced to respect the login/realm split (delete char, delete account chars in realm, delete account chars in realm then delete account
bool ChatHandler::HandleAccountDeleteCommand(const char* args)
{
    if(!*args)
        return false;

    ///- Get the account name from the command line
    char *account_name_str = strtok((char*)args," ");
    if (!account_name_str)
        return false;

    std::string account_name = account_name_str;
    if(!AccountMgr::normilizeString(account_name))
    {
        PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, account_name.c_str());
        SetSentErrorMessage(true);
        return false;
    }

    uint32 account_id = AccountMgr::GetId(account_name);
    if(!account_id)
    {
        PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, account_name.c_str());
        SetSentErrorMessage(true);
        return false;
    }

    /// Commands not recommended call from chat, but support anyway
    if(m_session)
    {
        /// can delete only for account with less security
        /// This is also reject self apply in fact
        if (AccountMgr::GetPermissions(account_id) >= m_session->GetPermissions())
        {
            SendSysMessage (LANG_YOURS_SECURITY_IS_LOW);
            SetSentErrorMessage (true);
            return false;
        }
    }

    AccountOpResult result = AccountMgr::DeleteAccount(account_id);
    switch(result)
    {
        case AOR_OK:
            PSendSysMessage(LANG_ACCOUNT_DELETED, account_name.c_str());
            break;
        case AOR_NAME_NOT_EXIST:
            PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, account_name.c_str());
            SetSentErrorMessage(true);
            return false;
        case AOR_DB_INTERNAL_ERROR:
            PSendSysMessage(LANG_ACCOUNT_NOT_DELETED_SQL_ERROR, account_name.c_str());
            SetSentErrorMessage(true);
            return false;
        default:
            PSendSysMessage(LANG_ACCOUNT_NOT_DELETED, account_name.c_str());
            SetSentErrorMessage(true);
            return false;
    }

    return true;
}

bool ChatHandler::HandleCharacterDeleteCommand(const char* args)
{
    if(!*args)
        return false;

    char *character_name_str = strtok((char*)args," ");
    if(!character_name_str)
        return false;

    std::string character_name = character_name_str;
    if(!normalizePlayerName(character_name))
        return false;

    uint64 character_guid;
    uint32 account_id;

    Player *player = sObjectMgr.GetPlayer(character_name.c_str());
    if(player)
    {
        character_guid = player->GetGUID();
        account_id = player->GetSession()->GetAccountId();
        player->GetSession()->KickPlayer();
    }
    else
    {
        character_guid = sObjectMgr.GetPlayerGUIDByName(character_name);
        if(!character_guid)
        {
            PSendSysMessage(LANG_NO_PLAYER, character_name.c_str());
            SetSentErrorMessage(true);
            return false;
        }

        account_id = sObjectMgr.GetPlayerAccountIdByGUID(character_guid);
    }

    std::string account_name;
    AccountMgr::GetName (account_id, account_name);

    Player::DeleteFromDB(character_guid, account_id, true);
    PSendSysMessage(LANG_CHARACTER_DELETED, character_name.c_str(), GUID_LOPART(character_guid), account_name.c_str(), account_id);
    return true;
}

/// Exit the realm
bool ChatHandler::HandleServerExitCommand(const char* args)
{
    SendSysMessage(LANG_COMMAND_EXIT);
    World::StopNow(SHUTDOWN_EXIT_CODE);
    return true;
}

/// Display info on users currently in the realm
bool ChatHandler::HandleAccountOnlineListCommand(const char* args)
{
    ///- Get the list of accounts ID logged to the realm
    QueryResultAutoPtr resultDB = RealmDataDatabase.Query("SELECT name, account FROM characters WHERE online > 0");
    if (!resultDB)
        return true;

    ///- Display the list of account/characters online
    SendSysMessage("=====================================================================");
    SendSysMessage(LANG_ACCOUNT_LIST_HEADER);
    SendSysMessage("=====================================================================");

    ///- Circle through accounts
    do
    {
        Field *fieldsDB = resultDB->Fetch();
        std::string name = fieldsDB[0].GetCppString();
        uint32 account = fieldsDB[1].GetUInt32();

        ///- Get the username, last IP and GM level of each account
        // No SQL injection. account is uint32.
        //                                                                  0         1          2              3
        QueryResultAutoPtr resultLogin = AccountsDatabase.PQuery("SELECT username, last_ip, permission_mask, expansion_id "
                                                                 "FROM account JOIN account_permissions ON account.account_id = account_permissions.account_id "
                                                                 "WHERE account_id = '%u' AND realm_id = '%u'", account, realmID);

        if(resultLogin)
        {
            Field *fieldsLogin = resultLogin->Fetch();
            PSendSysMessage("|%15s| %20s | %15s |%4d|%5d|",
                fieldsLogin[0].GetString(),name.c_str(),fieldsLogin[1].GetString(),fieldsLogin[2].GetUInt32(),fieldsLogin[3].GetUInt32());
        }
        else
            PSendSysMessage(LANG_ACCOUNT_LIST_ERROR, name.c_str());

    }
    while(resultDB->NextRow());

    SendSysMessage("=====================================================================");
    return true;
}

/// Create an account
bool ChatHandler::HandleAccountCreateCommand(const char* args)
{
    if(!*args)
        return false;

    ///- %Parse the command line arguments
    char *szAcc = strtok((char*)args, " ");
    char *szPassword = strtok(NULL, " ");
    if(!szAcc || !szPassword)
        return false;

    // normilized in AccountMgr::CreateAccount
    std::string account_name = szAcc;
    std::string password = szPassword;

    AccountOpResult result = AccountMgr::CreateAccount(account_name, password);
    switch(result)
    {
        case AOR_OK:
            PSendSysMessage(LANG_ACCOUNT_CREATED, account_name.c_str());
            break;
        case AOR_NAME_TOO_LONG:
            SendSysMessage(LANG_ACCOUNT_TOO_LONG);
            SetSentErrorMessage(true);
            return false;
        case AOR_NAME_ALREDY_EXIST:
            SendSysMessage(LANG_ACCOUNT_ALREADY_EXIST);
            SetSentErrorMessage(true);
            return false;
        case AOR_DB_INTERNAL_ERROR:
            PSendSysMessage(LANG_ACCOUNT_NOT_CREATED_SQL_ERROR, account_name.c_str());
            SetSentErrorMessage(true);
            return false;
        default:
            PSendSysMessage(LANG_ACCOUNT_NOT_CREATED, account_name.c_str());
            SetSentErrorMessage(true);
            return false;
    }

    return true;
}

bool ChatHandler::HandleAccountSpecialLogCommand(const char* args)
{
    if(!*args)
        return false;

    if(uint32 account_id = AccountMgr::GetId(args))
    {
        QueryResultAutoPtr result = AccountsDatabase.PQuery("SELECT account_flags FROM account WHERE account_id = '%u'", account_id);
        if (!result)
            return false;

        Field * fields = result->Fetch();

        uint64 accFlags = fields[0].GetUInt64();

        if (WorldSession *session = sWorld.FindSession(account_id))
        {
            if (session->IsAccountFlagged(ACC_SPECIAL_LOG))
                session->RemoveAccountFlag(ACC_SPECIAL_LOG);
            else
                session->AddAccountFlag(ACC_SPECIAL_LOG);
        }
        else
        {
            if (accFlags & ACC_SPECIAL_LOG)
                WorldSession::SaveAccountFlags(account_id, accFlags &= ~ACC_SPECIAL_LOG);
            else
                WorldSession::SaveAccountFlags(account_id, accFlags |= ACC_SPECIAL_LOG);
        }

        if (accFlags & ACC_SPECIAL_LOG)
            PSendSysMessage("SpecialLog have been enabled for account: %u.", account_id);
        else
            PSendSysMessage("SpecialLog have been disabled for account: %u.", account_id);
    }
    else
    {
        PSendSysMessage("Specified account not found.");
        SetSentErrorMessage(true);
        return false;
    }

    return true;
}

bool ChatHandler::HandleAccountWhispLogCommand(const char* args)
{
    if(!*args)
        return false;

    if (uint32 account_id = AccountMgr::GetId(args))
    {
        QueryResultAutoPtr result = AccountsDatabase.PQuery("SELECT account_flags FROM account WHERE account_id = '%u'", account_id);
        if (!result)
            return false;

        Field * fields = result->Fetch();

        uint64 accFlags = fields[0].GetUInt64();

        if (WorldSession *session = sWorld.FindSession(account_id))
        {
            if (accFlags & ACC_WHISPER_LOG)
                session->RemoveAccountFlag(ACC_WHISPER_LOG);
            else
                session->AddAccountFlag(ACC_WHISPER_LOG);
        }
        else
        {
            if (accFlags & ACC_WHISPER_LOG)
                WorldSession::SaveAccountFlags(account_id, accFlags &= ~ACC_WHISPER_LOG);
            else
                WorldSession::SaveAccountFlags(account_id, accFlags |= ACC_WHISPER_LOG);
        }

        if (accFlags & ACC_WHISPER_LOG)
            PSendSysMessage("WhispLog have been disabled for account: %u.", account_id);
        else
            PSendSysMessage("WhispLog have been enabled for account: %u.", account_id);
    }
    else
    {
        PSendSysMessage("Specified account not found.");
        SetSentErrorMessage(true);
        return false;
    }

    return true;
}

/// Set the level of logging
bool ChatHandler::HandleServerSetLogLevelCommand(const char *args)
{
    if(!*args)
        return false;

    char *NewLevel = strtok((char*)args, " ");
    if (!NewLevel)
        return false;

    sLog.SetLogLevel(NewLevel);
    return true;
}

/// set diff time record interval
bool ChatHandler::HandleServerSetDiffTimeCommand(const char *args)
{
    if(!*args)
        return false;

    char *NewTimeStr = strtok((char*)args, " ");
    if(!NewTimeStr)
        return false;

    int32 NewTime = atoi(NewTimeStr);
    if(NewTime < 0)
        return false;

    sWorld.SetRecordDiffInterval(NewTime);
    printf("Record diff every %u ms\n", NewTime);
    return true;
}


/// @}

#ifdef linux
// Non-blocking keypress detector, when return pressed, return 1, else always return 0
int kb_hit_return()
{
    struct timeval tv;
    fd_set fds;
    tv.tv_sec = 0;
    tv.tv_usec = 0;
    FD_ZERO(&fds);
    FD_SET(STDIN_FILENO, &fds);
    select(STDIN_FILENO+1, &fds, NULL, NULL, &tv);
    return FD_ISSET(STDIN_FILENO, &fds);
}
#endif

/// %Thread start
void CliRunnable::run()
{
    ///- Init new SQL thread for the world database (one connection call enough)
    GameDataDatabase.ThreadStart();                                // let thread do safe mySQL requests

    char commandbuf[256];
    bool canflush = true;
    ///- Display the list of available CLI functions then beep
    sLog.outString();
    #if PLATFORM != WINDOWS
    rl_attempted_completion_function = cli_completion;
    #endif
    if(sConfig.GetBoolDefault("BeepAtStart", true))
        printf("\a");                                       // \a = Alert

    ///- As long as the World is running (no World::m_stopEvent), get the command line and handle it
    while (!World::IsStopped())
    {
        fflush(stdout);

        char *command_str ;             // = fgets(commandbuf,sizeof(commandbuf),stdin);

        #if PLATFORM == WINDOWS
        command_str = fgets(commandbuf,sizeof(commandbuf),stdin);
        #else
        rl_bind_key('\t',rl_complete);
        command_str = readline("TC> ");
        #endif
        if (command_str != NULL)
        {
            for(int x=0;command_str[x];x++)
                if(command_str[x]=='\r'||command_str[x]=='\n')
                {
                    command_str[x]=0;
                    break;
                }

            if(!*command_str)
            {
                #if PLATFORM == WINDOWS
                    printf("TC> ");
                #endif
                continue;
            }

            std::string command;
            if(!consoleToUtf8(command_str,command))         // convert from console encoding to utf8
            {
                #if PLATFORM == WINDOWS
                printf("TC> ");
                #endif
                continue;
            }
            fflush(stdout);
            sWorld.QueueCliCommand(&utf8print,command.c_str());
            #if PLATFORM != WINDOWS
            add_history(command.c_str());
            #endif
        }
        else if (feof(stdin))
        {
            World::StopNow(SHUTDOWN_EXIT_CODE);
        }

    }

    ///- End the database thread
    GameDataDatabase.ThreadEnd();                                  // free mySQL thread resources
}

