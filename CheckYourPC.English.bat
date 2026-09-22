@echo off
title Check Your PC v1.0
chcp 65001 >nul
mode con: cols=95 lines=33
color 02

:: ==========================================
:: AUTOMATYCZNE WYMUSZENIE UPRAWNIEŃ ADMINA
:: ==========================================
net session >nul 2>&1
if %errorLevel% == 0 (
    goto intro
) else (
    echo [INFO] Requesting Administrator privileges...
    powershell -Command "Start-Process -FilePath '%0' -ArgumentList 'am_admin' -Verb RunAs"
    exit /b
)

:intro
cls
echo  [INITIALIZING SYSTEM TOOLS...]
echo  ===================================================================
echo    ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗    ██╗   ██╗██████╗  ██████╗
echo   ██╔════╝██║  ██║██╔════╝██╔════╝██║  ██║    ╚██╗ ██╔╝██╔══██╗██╔════╝
echo   ██║     ███████║█████╗  ██║     ███████║     ╚████╔╝ ██████╔╝██║     
echo   ██║     ██╔══██║██╔══╝  ██║     ██╔══██║      ╚██╔╝  ██╔═══╝ ██║     
echo   ╚██████╗██║  ██║███████╗╚██████╗██║  ██║       ██║   ██║     ╚██████╗
echo    ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝       ╚═╝   ╚═╝      ╚═════╝
echo  ===================================================================
timeout /t 2 >nul

:menu
cls
color 02
echo =========================================================================================
echo                                    CHECK YOUR PC - MAIN MENU
echo =========================================================================================
echo   [!] RUNNING WITH FULL ADMINISTRATOR PRIVILEGES
echo =========================================================================================
echo.
echo   1. HARDWARE SPECS   - Check CPU, RAM, OS, and Motherboard info
echo   2. NETWORK SCANNER  - Check local IP, network adapter status, and default gateway
echo   3. DISK CLEANER     - Free up space by deleting basic temporary junk files
echo   4. CLEAR PREFETCH   - Delete system Prefetch cache and DirectX Shader Cache only
echo   5. INTERNET TESTER  - Monitor ping in real-time to check network stability
echo   6. DIGITAL MATRIX   - Launch the iconic falling code matrix animation
echo   7. EXIT PROGRAM     - Safely close the application
echo.
echo =========================================================================================
echo.
set "wybor="
set /p wybor="Enter command number (1-7) #> "

if "%wybor%"=="1" goto specs
if "%wybor%"=="2" goto network
if "%wybor%"=="3" goto cleaner
if "%wybor%"=="4" goto deep_clean
if "%wybor%"=="5" goto net_test
if "%wybor%"=="6" goto matrix
if "%wybor%"=="7" exit
goto menu

:: ==========================================
:: 1. HARDWARE SPECS (CAŁKOWICIE BEZPIECZNE)
:: ==========================================
:specs
cls
echo [SCANNING SYSTEM HARDWARE COMPONENTS...]
echo ----------------------------------------------------
echo OPERATING SYSTEM:
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName | findstr "ProductName"
echo ----------------------------------------------------
echo PROCESSOR (CPU):
reg query "HKLM\Hardware\Description\System\CentralProcessor\0" /v ProcessorNameString | findstr "ProcessorNameString"
echo ----------------------------------------------------
echo MOTHERBOARD:
reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v BaseBoardProduct | findstr "BaseBoardProduct"
reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v BaseBoardManufacturer | findstr "BaseBoardManufacturer"
echo ----------------------------------------------------
echo.
echo Press any key to return to the Main Menu...
pause >nul
goto menu

:: ==========================================
:: 2. NETWORK SCANNER
:: ==========================================
:network
cls
echo [DIAGNOSING NETWORK INTERFACES...]
echo ----------------------------------------------------
echo LOCAL IPv4 ADDRESS DETAILS:
ipconfig | findstr /R "IPv4"
echo ----------------------------------------------------
echo NETWORK ADAPTER STATUS:
netsh interface show interface 2>nul
echo ----------------------------------------------------
echo DEFAULT GATEWAY DATA:
ipconfig | findstr /R "Gateway Brama"
echo ----------------------------------------------------
echo.
echo Press any key to return to the Main Menu...
pause >nul
goto menu

:: ==========================================
:: 3. DISK CLEANER (BASIC)
:: ==========================================
:cleaner
cls
color 0C
echo ====================================================
echo             WARNING: BASIC DISK CLEANING        
echo ====================================================
echo  This operation will delete safe system and user temporary files.
echo.
set /p confirm="Are you sure you want to proceed? (Y/N): "
if /I not "%confirm%"=="Y" goto menu

cls
echo [DELETING TEMPORARY SYSTEM JUNK...]
echo ----------------------------------------------------
del /f /s /q "%systemdrive%\*.tmp" >nul 2>&1
del /f /s /q "%systemdrive%\*._mp" >nul 2>&1
del /f /s /q "%systemdrive%\*.log" >nul 2>&1
del /f /s /q "%windir%\temp\*.*" >nul 2>&1
del /f /s /q "%USERPROFILE%\AppData\Local\Temp\*.*" >nul 2>&1
echo ----------------------------------------------------
color 0A
echo.
echo SUCCESS: Basic optimization complete!
echo.
echo Press any key to return to the Main Menu...
pause >nul
goto menu

:: ==========================================
:: 4. CLEAR PREFETCH FOLDER (ONLY)
:: ==========================================
:deep_clean
cls
color 0C
echo ====================================================
echo             INITIATING PREFETCH FOLDER PURGE        
echo ====================================================
echo  The program will clean only the system Prefetch buffer folder
echo  and the DirectX Shader Cache files.
echo.
set /p confirm="Do you want to clear the Prefetch folder? (Y/N): "
if /I not "%confirm%"=="Y" goto menu

cls
echo [1/2] Cleaning folder C:\Windows\Prefetch...
echo ----------------------------------------------------
del /f /s /q "%windir%\Prefetch\*.*" >nul 2>&1
echo Done.
echo.
echo [2/2] Cleaning DirectX Shader Cache...
echo ----------------------------------------------------
cleanmgr /sagerun:64512 >nul 2>&1
echo Done.
echo ----------------------------------------------------
color 0A
echo.
echo Operation complete.
echo.
echo Press any key to return to the Main Menu...
pause >nul
goto menu

:: ==========================================
:: 5. INTERNET TESTER (LIVE PING MONITOR)
:: ==========================================
:net_test
cls
echo [LAUNCHING LIVE PING MONITOR TO GOOGLE DNS...]
echo [Press Ctrl+C to stop the test and exit]
echo.
ping 8.8.8.8 -t
goto menu

:: ==========================================
:: 6. MATRIX ANIMATION
:: ==========================================
:matrix
cls
color 02
echo [Matrix simulation active. Press Ctrl+C, then select 'N' to exit]
echo.
:matrix_loop
set /a r=%random% %% 10
echo %random%  %random%  %r%  %random%  %random%  %r%  %random%  %random%
ping -n 1 127.0.0.1 >nul
goto matrix_loop
