@echo off
:: 2015-2019 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title DISM Reset Base
color 1F
pause
cls
dism /online /cleanup-image /startcomponentcleanup /resetbase
pause
exit /b
