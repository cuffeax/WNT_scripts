@echo off

:: 2015-2018 @mople71

:: This is free and unencumbered software released into the public domain.

:: Anyone is free to copy, modify, publish, use, compile, sell, or
:: distribute this software, either in source code form or as a compiled
:: binary, for any purpose, commercial or non-commercial, and by any
:: means.

:: In jurisdictions that recognize copyright laws, the author or authors
:: of this software dedicate any and all copyright interest in the
:: software to the public domain. We make this dedication for the benefit
:: of the public at large and to the detriment of our heirs and
:: successors. We intend this dedication to be an overt act of
:: relinquishment in perpetuity of all present and future rights to this
:: software under copyright law.

:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
:: EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
:: MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
:: IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
:: OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
:: ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
:: OTHER DEALINGS IN THE SOFTWARE.

:: For more information, please refer to <https://unlicense.org>

title Duster by mople71
cls
color 1F
echo =========================================
echo ** Duster
echo =========================================
echo.
echo Tento skript provede dukladnejsi procisteni instalace OS Windows.
echo.
echo * Ulozte si prosim veskerou nedokoncenou praci.
echo.
echo * Ukoncete prosim vsechny aplikace.
echo.
echo off
pause
cls

echo Zalohuji uzivatelsky registr...
echo off
if exist "%userprofile%\hkcubackup.hiv" del /s /f /q %userprofile%\hkcubackup.hiv
reg save hkcu %userprofile%\hkcubackup.hiv
cls

echo Nyni bude otevren seznam aplikaci...
echo.
echo * Odinstalujte prosim veskere cistici aplikace.
echo.
echo * Doufejte, ze v OS nenapachaly nevratne skody.
echo.
echo * Take se podivejte, zdali nemate nainstalovane zbytecne aplikace.
echo.
echo * Pripadne napravte.
echo.
echo * Po odinstalaci seznam aplikaci zavrete a pokracujte dale.
echo.
echo off
pause
echo.
echo (pokud se okno neobjevi hned, mejte prosim chvili strpeni)
echo.
echo off
appwiz.cpl
pause
cls

echo Mazu prebytecne soubory...
echo off
del /f /q %systemdrive%\*.tmp
del /f /q %systemdrive%\*.exe
del /s /f /q %systemroot%\*.tmp
del /s /f /q %systemroot%\Temp\*.*
del /s /f /q %appdata%\*.tmp
del /s /f /q %localappdata%\*.tmp
del /s /f /q %programdata%\*.tmp
del /s /f /q %programfiles%\*.tmp
del /s /f /q %programfiles(x86)%\*.tmp
del /s /f /q %TEMP%
del /s /f /q %TMP%
:: echo.
:: echo Mazu prebytecne veci po spusteni...
:: echo off
:: reg delete HKLM\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg /f
:: reg add HKLM\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg /f
echo off
cls

echo Nyni nastavime Disk Space Cleanup Manager...
echo.
echo * Po nastaveni jiz bude fungovat plne automatizovane.
echo.
echo * V nasledne otevrenem okne pridejte zatrzitka u vsech dostupnych moznosti krome:
echo.
echo "Zalozni soubory aktualizace", "Instalacni soubory Windows ESD"
echo.
echo a kliknete na "OK".
echo.
echo.
echo off
pause
echo.
echo (pokud se okno neobjevi hned, mejte prosim chvili strpeni)
echo.
echo off
cleanmgr /sageset:1
pause
echo.
echo Nyni Disk Cleanup spustime s parametry, ktere jsme pred par okamziky nastavili...
echo.
echo off
cleanmgr /sagerun:1
cls

echo Mazu stare body obnovy...
echo.
echo off
vssadmin delete shadows /for=%systemdrive% /all /quiet
vssadmin resize shadowstorage /for=%systemdrive% /on=%systemdrive% /maxsize=2GB
cls

echo Provadim posledni upravy...
echo off
bitsadmin /reset /allusers
ipconfig /flushdns
cls

echo --------------------------------------------------------------------------------
echo Mate zajem o kontrolu integrity OS?
echo --------------------------------------------------------------------------------
echo.
echo Vyhleda a opravi poskozene soubory OS...
echo.
echo * Casova narocnost je prumerne okolo 30 minut.
echo.
echo * Tento krok neni k cisteni OS nutne potrebny.
echo.
echo * Na druhou stranu muze opravit poskozeni OS a zlepsit tim jeho funkcionalitu.
echo.
echo [1] ANO
echo [2] NE
echo off
set /p op=Zvolte (1/2):
if %op%==1 goto sfc
if %op%==2 goto END
goto error

:sfc
cls
echo Vyvolavam sken integrity...
echo.
echo off
sfc /scannow
echo.
echo off
pause
goto END

:END
@echo off
cls
echo Cisteni OS bylo uspesne dokonceno!
echo.
echo * Pro pravidelne cisteni OS pouzijte 2. skript.
echo.
echo * Navod na jeho automatizaci naleznete ve clanku.
echo.
echo Je potreba restartovat OS... Muzeme?
echo off
pause
shutdown /r
exit /b
