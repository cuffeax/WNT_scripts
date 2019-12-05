@echo off
:: 2015-2019 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title SFClog by mople71
cls
color 1F

echo * Vyvolavam System File Checker sken...
echo.
echo off
sfc /scannow
cls

echo Sken dokoncen.
echo.
echo * Generuji log...
echo.
echo off
findstr /c:"[SR]" %systemroot%\Logs\CBS\CBS.log>%TEMP%\sfclog.txt
findstr /c:"Error" %systemroot%\Logs\CBS\CBS.log>>%TEMP%\sfclog.txt
echo.
echo Log vytvoren.
echo.
echo * Prosim zkopirujte jeho obsah do vaseho tematu.
echo.
echo off
notepad.exe %TEMP%\sfclog.txt
pause
exit /b
