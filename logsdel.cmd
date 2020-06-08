@echo off
:: 2015-2020 cuffeax
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title Logsdel
pause
cls

for /f %%a in ('WEVTUTIL EL') do WEVTUTIL CL "%%a"

exit /b
