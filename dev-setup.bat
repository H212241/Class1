@echo off
setlocal
echo ===== Dev Environment Setup =====
echo This installs: Git, Python, Node.js LTS, Java JDK 21, VS Code, GCC/G++, Claude Code
echo Already-installed items are skipped. It may take 10-20 minutes.
echo.

where winget >nul 2>&1
if errorlevel 1 (
  echo [ERROR] winget not found. Install "App Installer" from Microsoft Store, then run again.
  pause
  exit /b 1
)

call :install "Git"            Git.Git
call :install "Python 3.13"    Python.Python.3.13
call :install "Node.js LTS"    OpenJS.NodeJS.LTS
call :install "Java JDK 21"    EclipseAdoptium.Temurin.21.JDK
call :install "VS Code"        Microsoft.VisualStudioCode
call :install "GCC/G++"        BrechtSanders.WinLibs.POSIX.UCRT

echo.
echo ----- Claude Code -----
where claude >nul 2>&1
if errorlevel 1 (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://claude.ai/install.ps1 | iex"
) else (
  echo Claude Code already installed.
)

echo.
echo ===== Done =====
echo 1. Close this window and open a NEW CMD window (to refresh PATH).
echo 2. Run dev-check.bat to verify everything.
echo 3. Run "claude" and log in.
pause
exit /b

:install
echo.
echo ----- %~1 -----
winget install -e --id %2 --silent --accept-package-agreements --accept-source-agreements
goto :eof
