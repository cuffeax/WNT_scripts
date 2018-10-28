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
