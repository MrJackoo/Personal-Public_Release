

@echo off

for /F %%a in ('echo prompt $E ^| cmd') do (
  set "ESC=%%a"
)

:: This Section here is to put your locations for your server etc along with other stuff

:: Put your server name here without quotes
set /p ServerName= Enter Server Name:

:: This is the location to where your CitizenFX server is located i.e the FXServer.exe file
set FXLOCATION=fxfolderlocationhere

:: This is where your Server.cfg and resources cfg is
set SERVERLOCATION=servercfglocationhere


title %ServerName%

COLOR 01
echo -------------------------------------------
echo ^|                                         ^|
echo ^|       %ESC%[32m %ESC%[32mSTARTING FIVEM SERVER...%ESC%[0m         %ESC%[34m%ESC%[34m^|
echo ^|                                         ^|
echo -------------------------------------------%ESC%[0m


:verification

set numbervariable=9999999

set /a confirmationnumber=%random% %%numbervariable

set /p UserInput=Enter Confirmation Number (%confirmationnumber%):

set /a enteredinfo=UserInput

if %enteredinfo% EQU %confirmationnumber% (
  echo Code Verified Starting Server
  goto launchserver
) ELSE (
  goto verification
)




:launchserver

cd /d %SERVERLOCATION%
%FXLOCATION%\FXServer.exe --trace-warnings +set onesync on +set onesync_population true +set set sv_enforceGameBuild 2699 +set svgui_disable true +exec server.cfg


