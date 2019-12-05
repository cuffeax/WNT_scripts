@echo off
:: 2015-2019 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title WMI Repository Rebase
color 1F
pause
cls

echo Stopping necessary services...
echo off
net stop vmms
net stop iphlpsvc
net stop winmgmt
sc query winmgmt
pause
cls

echo Purging WMI repository...
echo off
del /f /q %systemroot%\System32\wbem\Repository\*.*
pause
cls

echo Starting previously stopped services...
echo off
net start vmms
net start iphlpsvc
net start winmgmt
sc query winmgmt
pause
cls

echo Building new repository...
echo.
echo * This may take a while.
echo.
echo off
wmic os
wmic cpu
wmic bios
wmic diskdrive
wmic group
wmic memorychip
wmic nic
wmic voltage
pause
cls

echo All set! Please reboot.
echo.
echo off
pause
exit /b
