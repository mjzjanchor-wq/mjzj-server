@echo off
chcp 65001 >nul
echo =============================================
echo   卖家之家服务 - 停止
echo =============================================

REM 按窗口标题关闭
taskkill /fi "WINDOWTITLE eq mjzj-monitor" /f >nul 2>&1
taskkill /fi "WINDOWTITLE eq mjzj-wechat-gen" /f >nul 2>&1

REM 按端口兜底
for /f "tokens=5" %%a in ('netstat -aon 2^>nul ^| findstr ":5001 "') do (
    taskkill /pid %%a /f >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -aon 2^>nul ^| findstr ":5002 "') do (
    taskkill /pid %%a /f >nul 2>&1
)

echo 服务已停止
pause
