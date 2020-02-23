@echo off
:: 2015-2020 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title WMI Repository Rebase by mople71
color 1F
pause
cls


echo TASK [WMISalvage : Zastavuji potrebne sluzby]
echo -------------------------------------------------------
echo off
net stop vmms
net stop iphlpsvc
net stop winmgmt
echo. && echo.

echo TASK [WMISalvage : Oveuji uspesne zastaveni winmgmt]
echo -------------------------------------------------------
echo off
sc query winmgmt
pause
echo. && echo.

echo TASK [WMISalvage : Rozbijim stavajici WMI repozitar]
echo -------------------------------------------------------
echo off
del /f /q %systemroot%\System32\wbem\Repository\*.*
echo. && echo.

echo TASK [WMISalvage : Spoustim zastavene sluzby]
echo -------------------------------------------------------
echo off
net start vmms
net start iphlpsvc
net start winmgmt
echo. && echo.

echo TASK [WMISalvage : Oveuji uspesne spusteni winmgmt]
echo -------------------------------------------------------
echo off
sc query winmgmt
pause
echo. && echo.

echo TASK [WMISalvage : Vytvarim novy repozitar]
echo -------------------------------------------------------
echo.
echo * Muze chvili trvat.
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


echo =======================================================
echo.
echo Hotovo! Prosim restartujte.
echo.
echo off
pause
exit /b
