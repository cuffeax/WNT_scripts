@echo off
:: 2015-2020 cuffeax
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title Dusting
color 1F

:: User temp files
del /s /f /q %TEMP%
del /s /f /q %TMP%
del /f /q %appdata%\*.tmp
del /f /q %localappdata%\*.tmp

:: Cleanup Manager
cleanmgr /sagerun:1

exit /b
