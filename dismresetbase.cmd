@echo off
:: 2015-2020 cuffeax
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title DISM Reset Base
pause
cls

dism /online /cleanup-image /startcomponentcleanup /resetbase
pause

exit /b
