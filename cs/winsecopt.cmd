@echo off
:: 2015-2020 mople71
:: Licensed under The Unlicense | https://unlicense.org/UNLICENSE
title WinSecOpt by mople71
cls
color 1F

echo =========================================
echo # WinSecOpt (drive SafeSVC)
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
echo ** Zvolte verzi OS:
echo --------------------------------------------------------------------------------
echo.
echo [1] Windows 10
echo [2] Windows 8.1
echo.
echo * Vyberte jednu z moznosti a stisknete Enter.
echo.
echo off
set /p op=Zvolte (1/2):
if %op%==1 goto master
if %op%==2 goto legacy
goto error


:: ===============
:: #  Windows
:: ===============

:master
cls
echo TASK [W10 : Optimalizuji sluzby]
echo -----------------------------------
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
:: Sluzbu DNS Cache nelze vypnout standardnim zpusobem
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
:: Volitelna optimalizace
:: sc config WSearch start= demand
cls

echo TASK [W10 : Optimalizuji konfiguraci]
echo ----------------------------------------
echo off
:: Nepotrebne funkce
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "Value" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "Value" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
:: Telemetrie
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Telemetry" /v "Enabled" /t REG_DWORD /d 0 /f
:: Nastaveni Windows Defender
PowerShell -Command "Set-MpPreference -PUAProtection Enabled"
PowerShell -Command "Set-MpPreference -SubmitSamplesConsent 1"


:: ===================
:: #  Spolecna cast
:: ===================

:common
cls
echo TASK [WNT : Optimalizuji funkce Windows]
echo -------------------------------------------
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

echo TASK [WNT : Optimalizuji ulohy Windows]
echo ------------------------------------------
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

echo TASK [WNT : Optimalizuji nastaveni Windows]
echo ----------------------------------------------
echo off
bitsadmin /reset /allusers
:: Telemetrie
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
:: Zakazuje podporu 16-bit aplikaci (pouze na 32-bit OS)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "VDMDisallowed" /t REG_DWORD /d 1 /f
:: Zakazuje ICMP
netsh firewall set icmpsetting type= All mode= Disable
cls


echo --------------------------------------------------------------------------------
echo ** Prejete si zakazat Usnadneni pristupu?
echo --------------------------------------------------------------------------------
echo.
echo * Bude zakazano spusteni na prihlasovaci obrazovce.
echo.
echo * Budou vypnuty klavesove zkratky jako 5x Shift apod.
echo.
echo [1] Ano
echo [2] Ne
echo off
set /p op=Zvolte (1/2):
if %op%==1 goto eou
if %op%==2 goto end
goto error

:eou
cls
echo TASK [WNT : Vypinam Usnadneni pristupu]
echo ------------------------------------------
echo off
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f
takeown /f %systemroot%\System32\utilman.exe /a
icacls %systemroot%\System32\utilman.exe /deny Everyone:(x)


:end
cls
echo Hotovo!
echo.
echo * Je potreba restartovat OS... Muzeme?
echo.
echo off
pause
shutdown /r
exit /b


:: ===============
:: #  WNT 6.3
:: ===============

:legacy
cls
echo TASK [W8.1 : Optimalizuji sluzby]
echo ------------------------------------
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
:: Volitelna optimalizace
:: sc config HomeGroupListener start= disabled
:: sc config HomeGroupProvider start= disabled
:: sc config WSearch start= demand
cls

echo TASK [W8.1 : Optimalizuji konfiguraci]
echo -----------------------------------------
echo off
:: Nastaveni Windows Defender
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f

:: Spolecna WNT cast
goto common
