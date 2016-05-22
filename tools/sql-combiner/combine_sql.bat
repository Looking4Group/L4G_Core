@echo off
setlocal EnableDelayedExpansion
set WorldUpdates=combined_world.sql
set CharactersUpdates=combined_characters.sql
set AuthUpdates=combined_realm.sql

if exist %CharactersUpdates% del %CharactersUpdates%
if exist %AuthUpdates% del %AuthUpdates%
if exist %WorldUpdates% del %WorldUpdates%

for %%a in (updates\world\*.sql) do (
echo /* >>%WorldUpdates%
echo * %%a >>%WorldUpdates%
echo */ >>%WorldUpdates%
copy/b %WorldUpdates%+"%%a" %WorldUpdates%
echo. >>%WorldUpdates%
echo. >>%WorldUpdates%)


for %%a in (updates\characters\*.sql) do (
echo /* >>%CharactersUpdates%
echo * %%a >>%CharactersUpdates%
echo */ >>%CharactersUpdates%
copy/b %CharactersUpdates%+"%%a" %CharactersUpdates%
echo. >>%CharactersUpdates%
echo. >>%CharactersUpdates%)


for %%a in (updates\realm\*.sql) do (
echo /* >>%AuthUpdates%
echo * %%a >>%AuthUpdates%
echo */ >>%AuthUpdates%
copy/b %AuthUpdates%+"%%a" %AuthUpdates%
echo. >>%AuthUpdates%
echo. >>%AuthUpdates%)