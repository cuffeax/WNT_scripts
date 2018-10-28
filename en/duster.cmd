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
echo This script performs a thorough cleanup of your Windows installation.
echo.
echo * Please save all your work.
echo.
echo * Please close all your applications.
echo.
echo off
pause
cls

echo Backing up user's registry...
echo off
if exist "%userprofile%\hkcubackup.hiv" del /s /f /q %userprofile%\hkcubackup.hiv
reg save hkcu %userprofile%\hkcubackup.hiv
cls

echo Windows installed apps list will open...
echo.
echo * Please remove all previous cleaning apps.
echo.
echo * Pray they haven't already harmed the OS.
echo.
echo * Also make sure there are no unnecessary applications.
echo.
echo * If there are, remove them.
echo.
echo * After the successful removal, close the app list and proceed.
echo.
echo off
pause
echo.
echo (this may take a while, please be patient)
echo.
echo off
appwiz.cpl
pause
cls

echo Removing unnecessary files...
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
:: echo Removing unnecessary startup entries...
:: echo off
:: reg delete HKLM\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg /f
:: reg add HKLM\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg /f
echo off
cls

echo Now let's set up the Disk Space Cleanup Manager...
echo.
echo * The cleanup will be fully automated after the setup.
echo.
echo * In the opened window, tick all options except the following:
echo.
echo "Zalozni soubory aktualizace", "Instalacni soubory Windows ESD"
echo.
echo and click "OK".
echo.
echo.
echo off
pause
echo.
echo (this may take a while, please be patient)
echo.
echo off
cleanmgr /sageset:1
pause
echo.
echo Now let's run the Disk Cleanup with the configured parameters...
echo.
echo off
cleanmgr /sagerun:1
cls

echo Purging old restore points...
echo.
echo off
vssadmin delete shadows /for=%systemdrive% /all /quiet
vssadmin resize shadowstorage /for=%systemdrive% /on=%systemdrive% /maxsize=2GB
cls

echo Making final adjustments...
echo off
bitsadmin /reset /allusers
ipconfig /flushdns
cls

echo --------------------------------------------------------------------------------
echo Would you like to perform an integrity check of the OS?
echo --------------------------------------------------------------------------------
echo.
echo Finds and repairs corrupted OS files...
echo.
echo * Average duration of the check is 30ish minutes.
echo.
echo * The following step is not essential for OS cleanup.
echo.
echo * However, it can remove corruption from the OS and enhance its functionallity.
echo.
echo [1] Yes
echo [2] No
echo off
set /p op=Choose (1/2):
if %op%==1 goto sfc
if %op%==2 goto END
goto error

:sfc
cls
echo Initiating System File Checker scan...
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
echo Cleanup has successfully finished.
echo.
echo * For regular maintenance, use the 2nd script.
echo.
echo * You can find a guide for its automation in the article.
echo.
echo * A reboot is required... Shall we?
echo off
pause
shutdown /r
exit /b
