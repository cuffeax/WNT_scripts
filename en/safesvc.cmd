@echo off
:: 2015-2019 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title SafeSVC by mople71
cls
color 1F

echo =========================================
echo ** SafeSVC
echo =========================================
echo.
echo This script performs basic (not just) securitywise OS optimization.
echo.
echo * Please close all your applications.
echo.
echo off
pause
cls

echo --------------------------------------------------------------------------------
echo ** Please choose the OS version.
echo --------------------------------------------------------------------------------
echo.
echo [1] Windows 10
echo [2] Windows 8.1
echo [3] Windows 7 (advice: migrate to a newer OS)
echo.
echo * Pick from the options and press Enter.
echo.
echo off
set /p op=Choose (1/2/3):
if %op%==1 goto master
if %op%==2 goto elderwnt
if %op%==3 goto legacy
goto error

:: -------------
:: Windows
:: -------------

:master
cls
echo Optimizing Windows services...
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

echo Optimizing Windows features...
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

echo Optimizing telemetry...
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

echo Optimizing Windows tasks...
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
echo ** Would you like to disable Ease of Use?
echo --------------------------------------------------------------------------------
echo.
echo * Its execution on the logon screen will be disabled.
echo.
echo * Keyboard shortcuts such as 5x Shift etc. will no longer work.
echo.
echo [1] Yes
echo [2] No
echo off
set /p op=Choose (1/2):
if %op%==1 goto master_eou
if %op%==2 goto master_end
goto error

:master_eou
cls
echo Turning off the Ease of Use...
echo off
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe" /v "Debugger" /t REG_SZ /d "systray.exe" /f
cls

:master_end
echo Final tweaks...
echo off
:: Turns off 16-bit app support
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "VDMDisallowed" /t REG_DWORD /d 1 /f
netsh firewall set icmpsetting type= All mode= Disable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 1 /f
bitsadmin /reset /allusers
cls
echo Done & done!
echo.
echo * A reboot is required... Shall we?
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
echo Optimizing Windows services...
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

echo Optimizing Windows features...
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

echo Optimizing telemetry...
echo off
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
cls

echo Optimizing Windows tasks...
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
echo ** Would you like to disable Ease of Use?
echo --------------------------------------------------------------------------------
echo.
echo * Its execution on the logon screen will be disabled.
echo.
echo * Keyboard shortcuts such as 5x Shift etc. will no longer work.
echo.
echo [1] Yes
echo [2] No
echo off
set /p op=Choose (1/2):
if %op%==1 goto master_eou
if %op%==2 goto master_end
goto error

:elderwnt_eou
cls
echo Turning off the Ease of Use...
echo off
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe" /v "Debugger" /t REG_SZ /d "systray.exe" /f
cls

:elderwnt_end
echo Final tweaks...
echo off
:: Turns off 16-bit app support
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "VDMDisallowed" /t REG_DWORD /d 1 /f
netsh firewall set icmpsetting type= All mode= Disable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 1 /f
bitsadmin /reset /allusers
cls
echo Done & done!
echo.
echo * A reboot is required... Shall we?
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
echo Optimizing Windows services...
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

echo Optimizing Windows features...
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

echo Optimizing telemetry...
echo off
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
cls

echo Optimizing Windows tasks...
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
echo ** Would you like to disable Ease of Use?
echo --------------------------------------------------------------------------------
echo.
echo * Its execution on the logon screen will be disabled.
echo.
echo * Keyboard shortcuts such as 5x Shift etc. will no longer work.
echo.
echo [1] Yes
echo [2] No
echo off
set /p op=Choose (1/2):
if %op%==1 goto master_eou
if %op%==2 goto master_end
goto error

:legacy_eou
cls
echo Turning off the Ease of Use...
echo off
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe" /v "Debugger" /t REG_SZ /d "systray.exe" /f
cls

:legacy_end
echo Final tweaks...
echo off
:: Turns off 16-bit app support
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "VDMDisallowed" /t REG_DWORD /d 1 /f
netsh firewall set icmpsetting type= All mode= Disable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 1 /f
bitsadmin /reset /allusers
cls
echo Done & done!
echo.
echo * A reboot is required... Shall we?
echo.
echo off
pause
shutdown /r
exit /b
