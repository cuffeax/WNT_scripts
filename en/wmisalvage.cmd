@echo off
:: 2015-2020 cuffeax
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title WMI Repository Rebase
color 1F
pause
cls


echo TASK [WMISalvage : Stop necessary services]
echo --------------------------------------------------------
echo off
net stop vmms
net stop iphlpsvc
net stop winmgmt
echo. && echo.

echo TASK [WMISalvage : Verify winmgmt stopped]
echo --------------------------------------------------------
echo off
sc query winmgmt
pause
echo. && echo.

echo TASK [WMISalvage : Purge WMI repository]
echo --------------------------------------------------------
echo off
del /f /q %systemroot%\System32\wbem\Repository\*.*
echo. && echo.

echo TASK [WMISalvage : Start previously stopped services]
echo --------------------------------------------------------
echo off
net start vmms
net start iphlpsvc
net start winmgmt
echo. && echo.

echo TASK [WMISalvage : Verify winmgmt started]
echo --------------------------------------------------------
echo off
sc query winmgmt
pause
echo. && echo.

echo TASK [WMISalvage : Build new repository]
echo --------------------------------------------------------
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
echo. && echo.


echo ========================================================
echo.
echo All set! Please reboot.
echo.
echo off
pause
exit /b
