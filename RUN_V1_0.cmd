@echo off
setlocal
cd /d "%~dp0"

set FLUTTER=C:\src\flutter\bin\flutter.bat

if not exist "%FLUTTER%" (
  echo.
  echo [ERROR] Flutter SDK not found:
  echo %FLUTTER%
  echo.
  pause
  exit /b 1
)

echo.
echo ==========================================
echo Shop Accounts v1.0 - Flutter Web
echo ==========================================
echo.

call "%FLUTTER%" pub get
if errorlevel 1 goto :failed

call "%FLUTTER%" run -d chrome --dart-define=API_BASE_URL=http://127.0.0.1:8000/api
exit /b %errorlevel%

:failed
echo.
echo Flutter command failed.
pause
exit /b 1
