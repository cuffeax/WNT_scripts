@echo off
:: 2015-2019 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title Dusting
cls
if exist "%userprofile%\hkcubackup.hiv" del /s /f /q %userprofile%\hkcubackup.hiv
reg save hkcu %userprofile%\hkcubackup.hiv
del /s /f /q %TEMP%
del /s /f /q %TMP%
cleanmgr /sagerun:1
exit /b
