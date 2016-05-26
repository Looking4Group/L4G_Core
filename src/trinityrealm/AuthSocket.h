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

/// \addtogroup realmd
/// @{
/// \file

#ifndef _AUTHSOCKET_H
#define _AUTHSOCKET_H

#include "Common.h"
#include "Auth/BigNumber.h"
#include "Auth/Sha1.h"
#include "ByteBuffer.h"

#include <regex>
#define REGEX_NAMESPACE std

#include "BufferedSocket.h"

#ifdef REGEX_NAMESPACE
typedef std::list<std::pair<REGEX_NAMESPACE::regex, REGEX_NAMESPACE::regex > > PatternList; // <IP pattern, LocalIP pattern>
#endif

/// Handle login commands
class AuthSocket: public BufferedSocket
{
    public:
        const static int s_BYTE_SIZE = 32;

        AuthSocket();
        ~AuthSocket();

        void OnAccept();
        void OnRead();
        void SendProof(Sha1Hash sha);
        void LoadRealmlist(ByteBuffer &pkt, uint32 acctid);

        bool _HandleLogonChallenge();
        bool _HandleLogonProof();
        bool _HandleReconnectChallenge();
        bool _HandleReconnectProof();
        bool _HandleRealmList();
        //data transfer handle for patch

        bool _HandleXferResume();
        bool _HandleXferCancel();
        bool _HandleXferAccept();

        void _SetVSFields(const std::string& rI);

#ifdef REGEX_NAMESPACE
        static PatternList pattern_banned;
#endif

    private:

        BigNumber N, s, g, v;
        BigNumber b, B;
        BigNumber K;
        BigNumber _reconnectProof;

        bool _authed;

        std::string _login;
        std::string _safelogin;
        std::string operatingSystem_;
        std::string localIp_;

        // Since GetLocaleByName() is _NOT_ bijective, we have to store the locale as a string. Otherwise we can't differ
        // between enUS and enGB, which is important for the patch system
        std::string _localizationName;
        uint16 _build;
        uint64 accountPermissionMask_;

        ACE_HANDLE patch_;

        void InitPatch();
};
#endif
/// @}
