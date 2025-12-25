@echo off
REM CardioCare Flutter - Quick Start Script for Windows
REM This script helps you get the app running quickly

echo ========================================
echo CardioCare AI - Flutter Setup
echo ========================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Flutter is not installed!
    echo [INFO] Please install Flutter first:
    echo        Visit: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

echo [OK] Flutter is installed
flutter --version
echo.

REM Check Flutter doctor
echo [INFO] Checking Flutter environment...
flutter doctor
echo.

REM Navigate to project directory
cd /d "%~dp0"

echo [INFO] Installing dependencies...
flutter pub get

if %ERRORLEVEL% EQU 0 (
    echo [OK] Dependencies installed successfully!
    echo.
) else (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)

REM Check for available devices
echo [INFO] Checking for available devices...
flutter devices
echo.

REM Ask user if they want to run the app
echo [INFO] Ready to run the app!
echo.
echo Choose an option:
echo 1) Run on default device
echo 2) Run on Android emulator
echo 3) List devices and exit
echo 4) Exit without running
echo.
set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" (
    echo [RUN] Running on default device...
    flutter run
) else if "%choice%"=="2" (
    echo [RUN] Running on Android emulator...
    flutter run -d android
) else if "%choice%"=="3" (
    echo [INFO] Available devices:
    flutter devices
) else if "%choice%"=="4" (
    echo [INFO] Goodbye!
    exit /b 0
) else (
    echo [ERROR] Invalid choice!
    pause
    exit /b 1
)

echo.
echo [OK] Setup complete!
echo [INFO] For more information, see:
echo        - README.md - Project overview
echo        - SETUP.md - Detailed setup guide
echo        - PROJECT_SUMMARY.md - Complete implementation details
pause
