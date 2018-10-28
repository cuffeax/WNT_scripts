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

title SafeSVC by mople71
cls
color 1F

echo =========================================
echo ** SafeSVC
echo =========================================
echo.
echo Tento skript provede zakladni (nejen) bezpecnostni optimalizaci OS.
echo.
echo * Ukoncete prosim vsechny aplikace.
echo.
echo off
pause
cls

echo --------------------------------------------------------------------------------
echo ** Zvolte prosim verzi OS.
echo --------------------------------------------------------------------------------
echo.
echo [1] Windows 10
echo [2] Windows 8.1
echo [3] Windows 7 (doporuceni: prejdete na novejsi OS)
echo.
echo Vyberte z moznosti a stisknete Enter.
echo.
echo off
set /p op=Zvolte (1/2/3):
if %op%==1 goto master
if %op%==2 goto elderwnt
if %op%==3 goto legacy
goto error

:: -------------
:: Windows
:: -------------

:master
cls
echo Optimalizuji sluzby Windows...
echo off
net stop WMPNetworkSvc
net stop Dnscache
net stop DiagTrack
net stop dmwappushservice
net stop diagnosticshub.standardcollector.service

sc config DiagTrack start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config dmwappushservice start= disabled
sc config TrkWks start= disabled
sc config alg start= disabled
sc config IPBusEnum start= disabled
sc config Mcx2Svc start= disabled
sc config NetTcpPortSharing start= disabled
sc config P2psvc start= disabled
sc config PeerDistSvc start= disabled
sc config Browser start= disabled
sc config QWAVE start= disabled
sc config p2pimsvc start= disabled
sc config PNRPsvc start= disabled
sc config PNRPAutoReg start= disabled
sc config SharedAccess start= disabled
sc config KtmRm start= disabled
sc config PerfHost start= disabled
sc config PNRPAutoReg start= disabled
sc config RemoteRegistry start= disabled
sc config TermService start= disabled
sc config WinRM start= disabled
sc config SysMain start= disabled
sc config WMPNetworkSvc start= disabled
reg add "HKLM\SYSTEM\ControlSet001\Services\Dnscache" /v "Start" /t REG_DWORD /d 4 /f
sc config Fax start= disabled
sc config lmhosts start= disabled
sc config workfolderssvc start= disabled
sc config wcncsvc start= disabled
sc config UmRdpService start= disabled
sc config FDResPub start= disabled
sc config SensorDataService start= disabled
sc config wlpasvc start= disabled
sc config icssvc start= disabled
sc config lfsvc start= disabled
sc config RasAuto start= disabled
sc config TapiSrv start= disabled
sc config RetailDemo start= disabled
sc config shpamsvc start= disabled
:: sc config WSearch start= demand
cls

echo Optimalizuji funkce Windows...
echo off
dism /online /Disable-Feature /FeatureName:FaxServicesClientPackage /quiet /norestart
dism /online /disable-feature /FeatureName:SMB1Protocol /quiet /norestart
dism /online /disable-feature /FeatureName:WorkFolders-Client /quiet /norestart
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 0 /f
net stop server
net start server
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "Value" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "Value" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
cls

echo Optimalizuji telemetrii...
echo off
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Telemetry" /v "Enabled" /t REG_DWORD /d 0 /f
cls

echo Optimalizuji ulohy Windows...
echo off
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
cls

echo --------------------------------------------------------------------------------
echo ** Chcete zakazat Usnadneni pristupu?
echo --------------------------------------------------------------------------------
echo.
echo * Bude zakazano spusteni na prihlasovaci obrazovce.
echo.
echo * Budou zakazany klavesove zkratky jako 5x Shift apod.
echo.
echo [1] Ano
echo [2] Ne
echo off
set /p op=Zvolte (1/2):
if %op%==1 goto master_eou
if %op%==2 goto master_end
goto error

:master_eou
cls
echo Vypinam Usnadneni pristupu...
echo off
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe" /v "Debugger" /t REG_SZ /d "systray.exe" /f
cls

:master_end
echo Finalni upravy...
echo off
:: Zakazuje podporu 16-bit aplikaci
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "VDMDisallowed" /t REG_DWORD /d 1 /f
netsh firewall set icmpsetting type= All mode= Disable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 1 /f
bitsadmin /reset /allusers
cls
echo Hotovo!
echo.
echo * Je potreba restartovat OS... Muzeme?
echo.
echo off
pause
shutdown /r
exit /b

:: -------------
:: WNT 6.3
:: -------------

:elderwnt
cls
echo Optimalizuji sluzby Windows...
echo off
net stop WMPNetworkSvc
net stop Dnscache
net stop DiagTrack

sc config DiagTrack start= disabled
sc config TrkWks start= disabled
sc config alg start= disabled
sc config IPBusEnum start= disabled
sc config Mcx2Svc start= disabled
sc config NetTcpPortSharing start= disabled
sc config P2psvc start= disabled
sc config QWAVE start= disabled
sc config RemoteRegistry start= disabled
sc config TermService start= disabled
sc config WinRM start= disabled
sc config WMPNetworkSvc start= disabled
sc config Dnscache start= disabled
sc config Fax start= disabled
:: sc config HomeGroupListener start= disabled
:: sc config HomeGroupProvider start= disabled
:: sc config WSearch start= demand
cls

echo Optimalizuji funkce Windows...
echo off
dism /online /Disable-Feature /FeatureName:FaxServicesClientPackage /quiet /norestart
dism /online /disable-feature /FeatureName:SMB1Protocol /quiet /norestart
dism /online /disable-feature /FeatureName:WorkFolders-Client /quiet /norestart
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 0 /f
net stop server
net start server
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
cls

echo Optimalizuji telemetrii...
echo off
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
cls

echo Optimalizuji ulohy Windows...
echo off
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
cls

echo --------------------------------------------------------------------------------
echo ** Chcete zakazat Usnadneni pristupu?
echo --------------------------------------------------------------------------------
echo.
echo * Bude zakazano spusteni na prihlasovaci obrazovce.
echo.
echo * Budou zakazany klavesove zkratky jako 5x Shift apod.
echo.
echo [1] Ano
echo [2] Ne
echo off
set /p op=Zvolte (1/2):
if %op%==1 goto elderwnt_eou
if %op%==2 goto elderwnt_end
goto error

:elderwnt_eou
cls
echo Vypinam Usnadneni pristupu...
echo off
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe" /v "Debugger" /t REG_SZ /d "systray.exe" /f
cls

:elderwnt_end
echo Finalni upravy...
echo off
:: Zakazuje podporu 16-bit aplikaci
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "VDMDisallowed" /t REG_DWORD /d 1 /f
netsh firewall set icmpsetting type= All mode= Disable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 1 /f
bitsadmin /reset /allusers
cls
echo Hotovo!
echo.
echo * Je potreba restartovat OS... Muzeme?
echo.
echo off
pause
shutdown /r
exit /b

:: -------------
:: Legacy WNT
:: -------------

:legacy
cls
echo Zastavuji a vypinam nebezpecne sluzby...
echo off
net stop WMPNetworkSvc
net stop Dnscache
net stop WinDefend
net stop DiagTrack

sc config DiagTrack start= disabled
sc config WinDefend start= disabled
sc config TrkWks start= disabled
sc config alg start= disabled
sc config IPBusEnum start= disabled
sc config Mcx2Svc start= disabled
sc config NetTcpPortSharing start= disabled
sc config P2psvc start= disabled
sc config QWAVE start= disabled
sc config RemoteRegistry start= disabled
sc config TermService start= disabled
sc config WinRM start= disabled
sc config WMPNetworkSvc start= disabled
sc config Dnscache start= disabled
sc config Fax start= disabled
:: sc config HomeGroupListener start= disabled
:: sc config HomeGroupProvider start= disabled
:: sc config WSearch start= demand
cls

echo Optimalizuji funkce Windows...
echo off
dism /online /Disable-Feature /FeatureName:WindowsGadgetPlatform /quiet /norestart
dism /online /Disable-Feature /FeatureName:TabletPCOC /quiet /norestart
dism /online /Disable-Feature /FeatureName:FaxServicesClientPackage /quiet /norestart
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 0 /f
net stop server
net start server
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
cls

echo Optimalizuji telemetrii...
echo off
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
cls

echo Optimalizuji ulohy Windows...
echo off
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
cls

echo --------------------------------------------------------------------------------
echo ** Chcete zakazat Usnadneni pristupu?
echo --------------------------------------------------------------------------------
echo.
echo * Bude zakazano spusteni na prihlasovaci obrazovce.
echo.
echo * Budou zakazany klavesove zkratky jako 5x Shift apod.
echo.
echo [1] Ano
echo [2] Ne
echo off
set /p op=Zvolte (1/2):
if %op%==1 goto legacy_eou
if %op%==2 goto legacy_end
goto error

:legacy_eou
cls
echo Vypinam Usnadneni pristupu...
echo off
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe" /v "Debugger" /t REG_SZ /d "systray.exe" /f
cls

:legacy_end
echo Finalni upravy...
echo off
:: Zakazuje podporu 16-bit aplikaci
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "VDMDisallowed" /t REG_DWORD /d 1 /f
netsh firewall set icmpsetting type= All mode= Disable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 1 /f
bitsadmin /reset /allusers
cls
echo Hotovo!
echo.
echo * Je potreba restartovat OS... Muzeme?
echo.
echo off
pause
shutdown /r
exit /b
