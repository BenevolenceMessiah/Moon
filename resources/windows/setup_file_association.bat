@echo off
:: setup_file_association.bat
:: This script helps set up file associations for the Moon Programming Language.
:: It provides options to backup the registry, set file associations, and exit.
:: Enhanced with submenu options for selective registry backups.

:: Enable delayed variable expansion
SETLOCAL ENABLEDELAYEDEXPANSION

:: Function to check for administrative privileges
:CheckAdmin
    net session >nul 2>&1
    if %errorLevel% NEQ 0 (
        echo.
        echo ======================================
        echo    Administrative Privileges Required
        echo ======================================
        echo This script must be run as an administrator.
        echo Please right-click the script and select "Run as administrator".
        echo.
        pause
        exit /b
    )
    goto :eof

:: Function to display the main menu
:Menu
    cls
    echo ====================================
    echo     Moon Programming Language Setup
    echo ====================================
    echo.
    echo Please select an option:
    echo.
    echo [1] Backup Registry
    echo [2] Set File Association
    echo [3] Exit
    echo.
    set /p choice=Enter your choice (1-3): 
    echo.

    :: Handle user input
    if "%choice%"=="1" goto BackupRegistry
    if "%choice%"=="2" goto SetFileAssociation
    if "%choice%"=="3" (
        echo Exiting the setup script.
        echo.
        pause
        exit /b
    )

    echo Invalid choice. Please select a valid option (1-3).
    echo.
    pause
    goto Menu

:: Function to backup the registry with submenu options
:BackupRegistry
    cls
    echo ======================================
    echo           Backup Registry
    echo ======================================
    echo.
    echo Please select a backup option:
    echo.
    echo [1] Backup Entire HKLM Hive
    echo [2] Backup MoonScript Registry Entries
    echo [3] Return to Main Menu
    echo.
    set /p backup_choice=Enter your choice (1-3): 
    echo.

    :: Handle backup submenu input
    if "%backup_choice%"=="1" goto BackupEntireHKLM
    if "%backup_choice%"=="2" goto BackupMoonScript
    if "%backup_choice%"=="3" goto Menu

    echo Invalid choice. Please select a valid option (1-3).
    echo.
    pause
    goto BackupRegistry

:: Function to backup the entire HKLM hive
:BackupEntireHKLM
    echo ======================================
    echo       Backup Entire HKLM Hive
    echo ======================================
    echo.

    :: Define backup directory and filename with timestamp
    SET "BACKUP_DIR=%~dp0..\registry_backups"
    IF NOT EXIST "%BACKUP_DIR%" (
        mkdir "%BACKUP_DIR%"
        if %errorLevel% NEQ 0 (
            echo Error: Failed to create backup directory at "%BACKUP_DIR%".
            echo.
            pause
            goto BackupRegistry
        )
    )

    :: Generate timestamp in format YYYYMMDD_HHMMSS
    for /f "tokens=2 delims==" %%i in ('wmic OS Get localdatetime /value') do set "TIMESTAMP=%%i"
    SET "TIMESTAMP=%TIMESTAMP:~0,8%_%TIMESTAMP:~8,6%"
    SET "BACKUP_FILE=%BACKUP_DIR%\HKLM_backup_%TIMESTAMP%.reg"

    echo Backing up the entire HKLM hive to "%BACKUP_FILE%"...
    
    :: Export the entire HKLM hive
    reg export HKLM "%BACKUP_FILE%" /y
    if %errorLevel% EQU 0 (
        echo Registry backup successful!
        echo Backup saved at "%BACKUP_FILE%".
    ) else (
        echo Error: Failed to backup the registry.
    )
    echo.
    pause
    goto BackupRegistry

:: Function to backup only MoonScript registry entries
:BackupMoonScript
    echo ======================================
    echo  Backup MoonScript Registry Entries
    echo ======================================
    echo.

    :: Define backup directory and filename with timestamp
    SET "BACKUP_DIR=%~dp0..\registry_backups"
    IF NOT EXIST "%BACKUP_DIR%" (
        mkdir "%BACKUP_DIR%"
        if %errorLevel% NEQ 0 (
            echo Error: Failed to create backup directory at "%BACKUP_DIR%".
            echo.
            pause
            goto BackupRegistry
        )
    )

    :: Generate timestamp in format YYYYMMDD_HHMMSS
    for /f "tokens=2 delims==" %%i in ('wmic OS Get localdatetime /value') do set "TIMESTAMP=%%i"
    SET "TIMESTAMP=%TIMESTAMP:~0,8%_%TIMESTAMP:~8,6%"
    SET "BACKUP_FILE=%BACKUP_DIR%\MoonScript_backup_%TIMESTAMP%.reg"

    echo Backing up MoonScript registry entries to "%BACKUP_FILE%"...

    :: Export specific MoonScript registry keys
    reg export "HKEY_CLASSES_ROOT\.moon" "%BACKUP_FILE%" /y
    reg export "HKEY_CLASSES_ROOT\.🌙" "%BACKUP_FILE%" /y
    reg export "HKEY_CLASSES_ROOT\MoonScript" "%BACKUP_FILE%" /y

    if %errorLevel% EQU 0 (
        echo MoonScript registry backup successful!
        echo Backup saved at "%BACKUP_FILE%".
    ) else (
        echo Error: Failed to backup MoonScript registry entries.
    )
    echo.
    pause
    goto BackupRegistry

:: Function to set file associations
:SetFileAssociation
    cls
    echo ======================================
    echo      Set File Association
    echo ======================================
    echo.

    :: Define paths
    SET "SCRIPT_DIR=%~dp0"
    SET "ICON_PATH=%SCRIPT_DIR%\..\resources\icons\moon_multi_icon.ico"
    SET "REG_FILE=%SCRIPT_DIR%\moon_file_association.reg"
    SET "IDE_PATH=%SCRIPT_DIR%\..\tools\ide\lunar_eclipse.exe"

    :: Validate icon file existence
    IF NOT EXIST "%ICON_PATH%" (
        echo Error: Icon file not found at "%ICON_PATH%".
        echo Please ensure that "moon_multi_icon.ico" exists in the "resources\icons" directory.
        echo.
        pause
        goto Menu
    )

    :: Validate IDE executable existence
    IF NOT EXIST "%IDE_PATH%" (
        echo Error: Moon IDE executable not found at "%IDE_PATH%".
        echo Please ensure that "lunar_eclipse.exe" exists in the "tools\ide" directory.
        echo.
        pause
        goto Menu
    )

    :: Create the .reg file with dynamic paths
    echo Creating registry script...
    (
    echo Windows Registry Editor Version 5.00
    echo.
    echo ; Associate .moon extension with MoonScript ProgID
    echo [HKEY_CLASSES_ROOT\.moon]
    echo @="MoonScript"
    echo "Content Type"="text/plain"
    echo.
    echo ; Associate .🌙 extension with MoonScript ProgID
    echo [HKEY_CLASSES_ROOT\.🌙]
    echo @="MoonScript"
    echo "Content Type"="text/plain"
    echo.
    echo ; Define MoonScript ProgID
    echo [HKEY_CLASSES_ROOT\MoonScript]
    echo @="MoonScript File"
    echo.
    echo ; Set the default icon for MoonScript ProgID
    echo [HKEY_CLASSES_ROOT\MoonScript\DefaultIcon]
    echo @="%ICON_PATH%"
    echo.
    echo ; Define the open command for MoonScript files
    echo [HKEY_CLASSES_ROOT\MoonScript\shell\open\command]
    echo @="\"%IDE_PATH%\" \"%%1\""
    ) > "%REG_FILE%"

    if %errorLevel% NEQ 0 (
        echo Error: Failed to create the registry script.
        echo.
        pause
        goto Menu
    )

    echo Registry script created at "%REG_FILE%".

    :: Apply the registry script
    echo Applying registry changes...
    regedit.exe /s "%REG_FILE%"

    if %errorLevel% EQU 0 (
        echo File associations set successfully!
    ) else (
        echo Error: Failed to apply registry changes.
    )

    echo.
    pause
    goto Menu

:: Start of the script
:Start
    call :CheckAdmin
    goto Menu

:: End of script
ENDLOCAL
