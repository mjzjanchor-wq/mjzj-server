@echo off
chcp 65001 >nul
echo =============================================
echo   卖家之家服务 - 启动
echo =============================================

REM ── 检查虚拟环境 ──────────────────────────────
if not exist "mjzj-monitor\.venv\Scripts\python.exe" (
    echo [错误] 未找到虚拟环境，请先运行 setup-python.bat
    pause & exit /b 1
)

REM ── 启动监控面板（端口 5001）─────────────────
echo 启动监控面板...
start "mjzj-monitor" /d "%~dp0mjzj-monitor" /min cmd /c ".venv\Scripts\python web.py"

REM ── 等待 2 秒再启动第二个 ─────────────────────
timeout /t 2 /nobreak >nul

REM ── 启动头条生成器（端口 5002）───────────────
echo 启动头条生成器...
start "mjzj-wechat-gen" /d "%~dp0mjzj-wechat-gen" /min cmd /c ".venv\Scripts\python app.py"

timeout /t 3 /nobreak >nul

REM ── 显示内网 IP ───────────────────────────────
echo.
echo =============================================
echo   服务已启动！内网访问地址：
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    set ip=%%a
    setlocal enabledelayedexpansion
    set ip=!ip: =!
    echo   监控面板：   http://!ip!:5001
    echo   头条生成器： http://!ip!:5002
    endlocal
    goto :done
)
:done
echo =============================================
echo   窗口最小化后服务继续在后台运行
echo   停止服务请双击 stop.bat
echo =============================================
pause
