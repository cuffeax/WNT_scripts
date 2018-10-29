@echo off
:: 2015-2018 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title SFClog by mople71
cls
color 1F

echo * Initiating System File Checker scan...
echo.
echo off
sfc /scannow
cls

echo Scan complete.
echo.
echo * Creating a log...
echo.
echo off
findstr /c:"[SR]" %systemroot%\Logs\CBS\CBS.log>%TEMP%\sfclog.txt
findstr /c:"Error" %systemroot%\Logs\CBS\CBS.log>>%TEMP%\sfclog.txt
echo.
echo The log has been created.
echo.
echo * Please copy its content into your thread.
echo.
echo off
notepad.exe %TEMP%\sfclog.txt
pause
exit /b
