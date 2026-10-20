@echo off
setlocal
set OUT=%USERPROFILE%\Desktop\dev-checklist.txt
echo ===== Dev Environment Checklist (%DATE% %TIME%) ===== > "%OUT%"

call :check "Git"          git      "git --version"
call :check "Python"       python   "python --version"
call :check "pip"          pip      "pip --version"
call :check "Node.js"      node     "node --version"
call :check "npm"          npm      "npm --version"
call :check "Java JDK"     java     "java -version"
call :check "javac"        javac    "javac -version"
call :check "GCC C"        gcc      "gcc --version"
call :check "G++ C++"      g++      "g++ --version"
call :check "VS Code"      code     "code --version"
call :check "Claude Code"  claude   "claude --version"
call :check "Docker"       docker   "docker --version"

echo. >> "%OUT%"
echo ----- Run tests ----- >> "%OUT%"
python -c "print('[OK]   Python run test')" >> "%OUT%" 2>&1 || echo [FAIL] Python run test >> "%OUT%"
node -e "console.log('[OK]   Node run test')" >> "%OUT%" 2>&1 || echo [FAIL] Node run test >> "%OUT%"

type "%OUT%"
echo.
echo Saved to: %OUT%
pause
exit /b

:check
where %2 >nul 2>&1
if errorlevel 1 (
  echo [MISSING] %~1 >> "%OUT%"
) else (
  for /f "delims=" %%v in ('%~3 2^>^&1') do (
    echo [OK]   %~1 : %%v >> "%OUT%"
    goto :eof
  )
)
goto :eof
