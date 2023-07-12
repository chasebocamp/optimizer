@echo off

REM Check if running with administrator privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if "%errorlevel%" NEQ "0" (
    echo This script requires administrative privileges. Please run as administrator.
    pause
    exit /b
)

REM Disable SysMain (SuperFetch)
echo Disabling SysMain (SuperFetch)...
sc config "SysMain" start=disabled
sc stop "SysMain"

REM Disable Telemetry
echo Disabling Telemetry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

REM Optimize Windows OS based on hardware
echo Optimizing Windows OS based on hardware...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

echo Windows optimization and settings applied successfully.

pause