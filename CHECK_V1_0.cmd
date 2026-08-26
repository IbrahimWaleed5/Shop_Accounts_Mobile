@echo off
setlocal
cd /d "%~dp0"

set FLUTTER=C:\src\flutter\bin\flutter.bat

if not exist "%FLUTTER%" (
  echo [ERROR] Flutter SDK not found at:
  echo %FLUTTER%
  exit /b 1
)

echo.
echo ==========================================
echo Shop Accounts v1.0 - Final Flutter Check
echo ==========================================
echo.

call "%FLUTTER%" pub get
if errorlevel 1 goto :failed

call "%FLUTTER%" analyze
if errorlevel 1 goto :failed

call "%FLUTTER%" test
if errorlevel 1 goto :failed

echo.
echo ==========================================
echo FLUTTER V1.0 CHECK PASSED
echo ==========================================
echo.
exit /b 0

:failed
echo.
echo ==========================================
echo FLUTTER V1.0 CHECK FAILED
echo ==========================================
echo.
exit /b 1
