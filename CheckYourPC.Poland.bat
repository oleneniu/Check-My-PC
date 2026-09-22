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
    echo [INFO] Żądanie uprawnień Administratora...
    powershell -Command "Start-Process -FilePath '%0' -ArgumentList 'am_admin' -Verb RunAs"
    exit /b
)

:intro
cls
echo  [INICJALIZACJA NARZĘDZI SYSTEMOWYCH...]
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
echo                                    CHECK YOUR PC - MENU GŁÓWNE
echo =========================================================================================
echo   [!] URUCHOMIONO Z PEŁNYMI UPRAWNIENIAMI ADMINISTRATORA
echo =========================================================================================
echo.
echo   1. SPECYFIKACJA SPRZĘTU - Sprawdź procesor, płytę główną i wersję systemu Windows
echo   2. SKANER SIECIOWY      - Sprawdź lokalne IP, status kart sieciowych i bramę domyślną
echo   3. CZYSZCZENIE DYSKU    - Zwolnij miejsce usuwając podstawowe pliki tymczasowe
echo   4. CZYSZCZENIE PREFETCH - Usuń systemową pamięć podręczną Prefetch i Shader Cache
echo   5. TEST INTERNETU       - Monitoruj ping na żywo, aby sprawdzić stabilność sieci
echo   6. CYFROWY MATRIX       - Uruchom kultową animację spadającego kodu w tle
echo   7. ZAMKNIJ PROGRAM      - Bezpiecznie wyjdź z aplikacji
echo.
echo =========================================================================================
echo.
set "wybor="
set /p wybor="Wprowadź numer polecenia (1-7) #> "

if "%wybor%"=="1" goto specs
if "%wybor%"=="2" goto network
if "%wybor%"=="3" goto cleaner
if "%wybor%"=="4" goto deep_clean
if "%wybor%"=="5" goto net_test
if "%wybor%"=="6" goto matrix
if "%wybor%"=="7" exit
goto menu

:: ==========================================
:: 1. SPECYFIKACJA SPRZĘTU (BEZPIECZNY REJESTR)
:: ==========================================
:specs
cls
echo [SKANOWANIE PODZESPOŁÓW SYSTEMU...]
echo ----------------------------------------------------
echo SYSTEM OPERACYJNY:
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName | findstr "ProductName"
echo ----------------------------------------------------
echo PROCESOR (CPU):
reg query "HKLM\Hardware\Description\System\CentralProcessor\0" /v ProcessorNameString | findstr "ProcessorNameString"
echo ----------------------------------------------------
echo PŁYTA GŁÓWNA:
reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v BaseBoardProduct | findstr "BaseBoardProduct"
reg query "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v BaseBoardManufacturer | findstr "BaseBoardManufacturer"
echo ----------------------------------------------------
echo.
echo Naciśnij dowolny klawisz, aby wrócić do Menu Głównego...
pause >nul
goto menu

:: ==========================================
:: 2. SKANER SIECIOWY
:: ==========================================
:network
cls
echo [DIAGNOSTYKA INTERFEJSÓW SIECIOWYCH...]
echo ----------------------------------------------------
echo SZCZEGÓŁY LOKALNEGO ADRESU IPv4:
ipconfig | findstr /R "IPv4"
echo ----------------------------------------------------
echo STATUS KART SIECIOWYCH:
netsh interface show interface 2>nul
echo ----------------------------------------------------
echo DANE BRAMY DOMYŚLNEJ:
ipconfig | findstr /R "Gateway Brama"
echo ----------------------------------------------------
echo.
echo Naciśnij dowolny klawisz, aby wrócić do Menu Głównego...
pause >nul
goto menu

:: ==========================================
:: 3. CZYSZCZENIE DYSKU (PODSTAWOWE)
:: ==========================================
:cleaner
cls
color 0C
echo ====================================================
echo             OSTRZEŻENIE: PODSTAWOWE CZYSZCZENIE DYSKU        
echo ====================================================
echo  Ta operacja usunie bezpieczne pliki tymczasowe systemowe i użytkownika.
echo.
set /p confirm="Czy na pewno chcesz kontynuować? (T/N): "
if /I not "%confirm%"=="T" goto menu

cls
echo [USUWANIE TYMCZASOWYCH ŚMIECI SYSTEMOWYCH...]
echo ----------------------------------------------------
del /f /s /q "%systemdrive%\*.tmp" >nul 2>&1
del /f /s /q "%systemdrive%\*._mp" >nul 2>&1
del /f /s /q "%systemdrive%\*.log" >nul 2>&1
del /f /s /q "%windir%\temp\*.*" >nul 2>&1
del /f /s /q "%USERPROFILE%\AppData\Local\Temp\*.*" >nul 2>&1
echo ----------------------------------------------------
color 0A
echo.
echo SUKCES: Podstawowa optymalizacja zakończona!
echo.
echo Naciśnij dowolny klawisz, aby wrócić do Menu Głównego...
pause >nul
goto menu

:: ==========================================
:: 4. CZYSZCZENIE FOLDERU PREFETCH (TYLKO)
:: ==========================================
:deep_clean
cls
color 0C
echo ====================================================
echo             INICJACJA CZYSZCZENIA FOLDERU PREFETCH        
echo ====================================================
echo  Program wyczyści wyłącznie systemowy folder buforu Prefetch
echo  oraz pliki pamięci podręcznej DirectX Shader Cache.
echo.
set /p confirm="Czy chcesz wyczyścić folder Prefetch? (T/N): "
if /I not "%confirm%"=="T" goto menu

cls
echo [1/2] Czyszczenie folderu C:\Windows\Prefetch...
echo ----------------------------------------------------
del /f /s /q "%windir%\Prefetch\*.*" >nul 2>&1
echo Gotowe.
echo.
echo [2/2] Czyszczenie pamięci podręcznej DirectX Shader Cache...
echo ----------------------------------------------------
cleanmgr /sagerun:64512 >nul 2>&1
echo Gotowe.
----------------------------------------------------
color 0A
echo.
echo Operacja zakończona pomyślnie.
echo.
echo Naciśnij dowolny klawisz, aby wrócić do Menu Głównego...
pause >nul
goto menu

:: ==========================================
:: 5. TEST INTERNETU (MONITOR PING NA ŻYWO)
:: ==========================================
:net_test
cls
echo [URUCHAMIANIE MONITORA PING DO SERWERA GOOGLE DNS...]
echo [Naciśnij Ctrl+C, aby zatrzymać test i wyjść]
echo.
ping 8.8.8.8 -t
goto menu

:: ==========================================
:: 6. ANIMACJA MATRIXA
:: ==========================================
:matrix
cls
color 02
echo [Symulacja Matrix aktywna. Naciśnij Ctrl+C, a następnie 'N', aby wyjść]
echo.
:matrix_loop
set /a r=%random% %% 10
echo %random%  %random%  %r%  %random%  %random%  %r%  %random%  %random%
ping -n 1 127.0.0.1 >nul
goto matrix_loop
