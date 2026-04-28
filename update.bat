@echo off
chcp 65001 >nul
echo =============================================
echo   卖家之家服务 - 更新
echo =============================================
echo.

cd /d "%~dp0"

echo [1/5] 更新部署配置...
git pull origin main
if errorlevel 1 ( echo [警告] 部署配置 pull 失败，继续... )

echo.
echo [2/5] 更新监控程序代码...
cd mjzj-monitor
git pull origin main
if errorlevel 1 ( echo [错误] mjzj-monitor pull 失败 & cd .. & pause & exit /b 1 )
cd ..

echo.
echo [3/5] 更新头条生成器代码...
cd mjzj-wechat-gen
git pull origin main
if errorlevel 1 ( echo [错误] mjzj-wechat-gen pull 失败 & cd .. & pause & exit /b 1 )
cd ..

echo.
echo [4/5] 安装新增依赖（如有）...
cd mjzj-monitor
.venv\Scripts\pip install -r requirements.txt -q --index-url https://pypi.tuna.tsinghua.edu.cn/simple
cd ..
cd mjzj-wechat-gen
.venv\Scripts\pip install -r requirements.txt -q --index-url https://pypi.tuna.tsinghua.edu.cn/simple
cd ..

echo.
echo [5/5] 重启服务...
call "%~dp0stop.bat" >nul
timeout /t 2 /nobreak >nul
call "%~dp0start.bat"
