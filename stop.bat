@echo off
chcp 65001 >nul
echo =============================================
echo   卖家之家服务 - 停止
echo =============================================
docker compose down
echo 服务已全部停止
pause
