@ECHO OFF
@title TrinityRealm
CLS
ECHO Initializing Realm (Logon-Server)...
:1
start "Trinity Realm" /B /MIN /WAIT TrinityRealm.exe -c TrinityRealm.conf
if %errorlevel% == 0 goto end
goto 1
:end