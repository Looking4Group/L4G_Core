@ECHO OFF
@title TrinityCore
CLS
ECHO Initializing Core (World-Server)...
:1
start "Trinity Core" /B /MIN /WAIT TrinityCore.exe -c TrinityCore.conf
if %errorlevel% == 0 goto end
goto 1
:end