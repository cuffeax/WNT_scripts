@echo off
:: 2015-2020 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title SFClog by mople71
color 1F
cls


echo TASK [SFClog : Initiate System File Checker scan]
echo ----------------------------------------------------
echo off
sfc /scannow
echo. && echo.

echo TASK [SFClog : Generate a log]
echo ----------------------------------------------------
echo off
findstr /c:"[SR]" %systemroot%\Logs\CBS\CBS.log>%TEMP%\sfclog.txt
findstr /c:"Error" %systemroot%\Logs\CBS\CBS.log>>%TEMP%\sfclog.txt
echo.
echo # Log has been created. Press any key to open.
echo.
echo * Please copy its content into your thread.
echo.
echo off
pause
notepad %TEMP%\sfclog.txt


exit /b
