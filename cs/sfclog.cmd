@echo off
:: 2015-2020 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title SFClog by mople71
color 1F
cls


echo TASK [SFClog : Vyvolavam System File Checker sken]
echo -----------------------------------------------------
echo off
sfc /scannow
echo. && echo.

echo TASK [SFClog : Generuji log]
echo -----------------------------------------------------
echo off
findstr /c:"[SR]" %systemroot%\Logs\CBS\CBS.log>%TEMP%\sfclog.txt
findstr /c:"Error" %systemroot%\Logs\CBS\CBS.log>>%TEMP%\sfclog.txt
echo.
echo # Log vytvoren. Stisknete libovolnou klavesu pro otevreni.
echo.
echo * Prosim zkopirujte jeho obsah do vaseho tematu.
echo.
echo off
pause
notepad %TEMP%\sfclog.txt


exit /b
