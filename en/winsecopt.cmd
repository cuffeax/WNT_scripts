@echo off
:: 2015-2020 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title WinSecOpt by mople71
color 1F
cls


echo =========================================
echo # WinSecOpt (former SafeSVC)
echo =========================================
echo.
echo This script performs elementary (not only) security-wise OS optimization.
echo.
echo * Please close all apps.
echo. && echo.
echo off
pause
cls

echo --------------------------------------------------------------------------------
echo ** Choose OS version:
echo --------------------------------------------------------------------------------
echo.
echo [1] Windows 10
echo [2] Windows 8.1
echo.
echo * Pick one of the options and press Enter.
echo.
:askversion
echo off
set /p op=Select (1/2):
if %op%==1 goto master
if %op%==2 goto legacy
goto askversion


:: ===============
:: #  Windows
:: ===============

:master
cls
echo TASK [W10 : Optimize services]
echo ----------------------------------------------
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
sc config MSiSCSI start= disabled
sc config RpcLocator start= disabled
sc config KtmRm start= disabled
sc config PerfHost start= disabled
sc config PNRPAutoReg start= disabled
sc config RemoteRegistry start= disabled
sc config TermService start= disabled
sc config WinRM start= disabled
sc config SysMain start= disabled
sc config WMPNetworkSvc start= disabled
:: DNS Cache service cannot be disabled the standard way
reg add "HKLM\SYSTEM\ControlSet001\Services\Dnscache" /v "Start" /t REG_DWORD /d 4 /f
sc config Fax start= disabled
sc config lmhosts start= disabled
sc config workfolderssvc start= disabled
sc config wcncsvc start= disabled
sc config UmRdpService start= disabled
sc config FDResPub start= disabled
sc config SensorDataService start= disabled
sc config SensrSvc start= disabled
sc config SEMgrSvc start= disabled
sc config wlpasvc start= disabled
sc config icssvc start= disabled
sc config lfsvc start= disabled
sc config RasAuto start= disabled
sc config TapiSrv start= disabled
sc config RetailDemo start= disabled
sc config shpamsvc start= disabled
:: Space for custom rules
:: sc config WSearch start= demand
cls

echo TASK [W10 : Optimize configuration]
echo ----------------------------------------------
echo off
:: Unneeded features
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "Value" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "Value" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
:: Telemetry
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Telemetry" /v "Enabled" /t REG_DWORD /d 0 /f
:: Windows Defender
PowerShell -Command "Set-MpPreference -PUAProtection Enabled"
PowerShell -Command "Set-MpPreference -SubmitSamplesConsent 1"


:: ===================
:: #  Common WNT
:: ===================

:common
cls
echo TASK [WNT : Optimize Windows features]
echo ----------------------------------------------
echo off
dism /online /Disable-Feature /FeatureName:FaxServicesClientPackage /norestart
dism /online /disable-feature /FeatureName:SMB1Protocol /norestart
dism /online /disable-feature /FeatureName:WorkFolders-Client /norestart
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 0 /f
net stop server
net start server
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
cls

echo TASK [WNT : Optimize Windows tasks]
echo ----------------------------------------------
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

echo TASK [WNT : Optimize Windows configuration]
echo ----------------------------------------------
echo off
bitsadmin /reset /allusers
:: Telemetry
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
:: Disable 16-bit app support (only for 32-bit OSs)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "VDMDisallowed" /t REG_DWORD /d 1 /f
:: Deny ICMP
netsh firewall set icmpsetting type= All mode= Disable
cls


echo --------------------------------------------------------------------------------
echo ** Would you like to turn off Ease of Use?
echo --------------------------------------------------------------------------------
echo.
echo * Execution on logon screen will be restricted.
echo.
echo * Keyboard shortcuts like 5x Shift etc. will no longer work.
echo.
echo [Y] Yes
echo [N] No
:askeou
echo off
set /p op=Select (Y/N):
if %op%==Y goto eou
if %op%==N goto end
goto askeou

:eou
cls
echo TASK [WNT : Turning off Ease of Use]
echo ----------------------------------------------
echo off
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f
takeown /f %systemroot%\System32\utilman.exe /a
icacls %systemroot%\System32\utilman.exe /deny Everyone:(x)


:end
cls
echo All set!
echo.
echo * Reboot is required... Shall we?
echo. && echo.
echo off
pause
shutdown /r
exit /b


:: ===============
:: #  WNT 6.3
:: ===============

:legacy
cls
echo TASK [W8.1 : Optimize services]
echo ----------------------------------------------
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
:: Space for custom rules
:: sc config HomeGroupListener start= disabled
:: sc config HomeGroupProvider start= disabled
:: sc config WSearch start= demand
cls

echo TASK [W8.1 : Optimize configuration]
echo ----------------------------------------------
echo off
:: Windows Defender
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f

:: Common WNT part
goto common
