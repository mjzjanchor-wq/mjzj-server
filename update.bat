@echo off
chcp 65001 >nul
echo =============================================
echo   卖家之家服务 - 更新
echo =============================================
echo.

cd /d "%~dp0"

echo [1/4] 更新部署配置...
git pull origin main
if errorlevel 1 ( echo [警告] 部署配置 pull 失败，继续... )

echo.
echo [2/4] 更新监控程序代码...
cd mjzj-monitor
git pull origin main
if errorlevel 1 ( echo [错误] mjzj-monitor pull 失败 & cd .. & pause & exit /b 1 )
cd ..

echo.
echo [3/4] 更新头条生成器代码...
cd mjzj-wechat-gen
git pull origin main
if errorlevel 1 ( echo [错误] mjzj-wechat-gen pull 失败 & cd .. & pause & exit /b 1 )
cd ..

echo.
echo [4/4] 重新构建并重启服务（保留所有配置和数据）...
docker compose up -d --build

echo.
echo =============================================
echo   更新完成！
echo   监控面板：  http://localhost:5001
echo   头条生成器：http://localhost:5002
echo =============================================
pause
