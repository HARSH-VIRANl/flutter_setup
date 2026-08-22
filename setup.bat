@echo off
setlocal enabledelayedexpansion

echo.
echo ==========================================
echo    Flutter BLoC Project Setup (Windows)
echo ==========================================
echo.

REM 1. Prerequisites Check
where dart >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Dart SDK not found in PATH.
    echo Please install Flutter SDK: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Flutter SDK not found in PATH.
    echo Please install Flutter SDK: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

REM 2. Activate Melos & Mason CLI Globally
echo [1/3] Activating Melos and Mason CLI globally...
call dart pub global activate melos
call dart pub global activate mason_cli

REM 3. Resolve Workspace Dependencies
echo [2/3] Resolving workspace dependencies...
call flutter pub get

REM 4. Verify Melos Setup
echo [3/3] Melos workspace ready.
echo.
echo ==========================================
echo    Setup completed successfully!
echo ==========================================
echo.
echo You can now run:
echo   melos run
echo   flutter run
echo.
pause
