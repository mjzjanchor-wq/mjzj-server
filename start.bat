@echo off
chcp 65001 >nul
echo =============================================
echo   卖家之家服务 - 启动
echo =============================================
docker compose up -d
echo.
echo 服务已启动：
echo   监控面板：  http://localhost:5001
echo   头条生成器：http://localhost:5002
echo.
echo 也可通过内网 IP 访问，例如：
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    set ip=%%a
    setlocal enabledelayedexpansion
    set ip=!ip: =!
    echo   http://!ip!:5001  ^(监控面板^)
    echo   http://!ip!:5002  ^(头条生成器^)
    endlocal
    goto :done
)
:done
echo =============================================
pause
