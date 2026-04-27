@echo off
chcp 65001 >nul
echo =============================================
echo   卖家之家服务 - 首次部署初始化
echo =============================================
echo.

REM ── 检查 Docker 是否运行 ──────────────────────
docker info >nul 2>&1
if errorlevel 1 (
    echo [错误] Docker Desktop 未运行，请先启动 Docker Desktop
    pause & exit /b 1
)
echo [OK] Docker Desktop 正在运行

REM ── 检查子目录是否已克隆 ─────────────────────
if not exist "mjzj-monitor\web.py" (
    echo [错误] 未找到 mjzj-monitor 目录，请先执行：
    echo   git clone https://github.com/YOUR_NAME/mjzj-monitor
    pause & exit /b 1
)
if not exist "mjzj-wechat-gen\app.py" (
    echo [错误] 未找到 mjzj-wechat-gen 目录，请先执行：
    echo   git clone https://github.com/YOUR_NAME/mjzj-wechat-gen
    pause & exit /b 1
)
echo [OK] 两个项目目录已存在

REM ── 创建数据目录 ──────────────────────────────
if not exist "data\monitor\drafts" mkdir data\monitor\drafts
if not exist "data\wechat-gen"     mkdir data\wechat-gen
echo [OK] 数据目录已就绪

REM ── 初始化 .env 文件 ──────────────────────────
if not exist "mjzj-monitor\.env" (
    copy "mjzj-monitor\.env.example" "mjzj-monitor\.env" >nul
    echo [需要操作] 已创建 mjzj-monitor\.env，请用记事本打开并填入 API Key
)
if not exist "mjzj-wechat-gen\.env" (
    copy "mjzj-wechat-gen\.env.example" "mjzj-wechat-gen\.env" >nul
    echo [需要操作] 已创建 mjzj-wechat-gen\.env，请用记事本打开并填入 API Key
)

echo.
echo =============================================
echo   请完成以下操作后再启动服务：
echo   1. 编辑 mjzj-monitor\.env 填入 API Key
echo   2. 编辑 mjzj-wechat-gen\.env 填入 API Key
echo   3. 填好后双击 start.bat 启动服务
echo =============================================
pause
