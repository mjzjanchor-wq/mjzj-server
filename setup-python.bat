@echo off
chcp 65001 >nul
echo =============================================
echo   卖家之家服务 - 首次部署初始化（Python模式）
echo =============================================
echo.

REM ── 检查 Python ───────────────────────────────
python --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Python，请关闭此窗口，重新打开 PowerShell 再试
    echo        如果刚装完 Python，需要重启电脑后再运行
    pause & exit /b 1
)
for /f "tokens=*" %%v in ('python --version') do echo [OK] %%v

REM ── 检查子目录 ────────────────────────────────
if not exist "mjzj-monitor\web.py" (
    echo [错误] 未找到 mjzj-monitor，请先执行 git clone
    pause & exit /b 1
)
if not exist "mjzj-wechat-gen\app.py" (
    echo [错误] 未找到 mjzj-wechat-gen，请先执行 git clone
    pause & exit /b 1
)
echo [OK] 两个项目目录已存在

REM ── 创建数据目录 ──────────────────────────────
if not exist "data\monitor\drafts" mkdir data\monitor\drafts
if not exist "data\wechat-gen"     mkdir data\wechat-gen
echo [OK] 数据目录已就绪

REM ── 安装监控程序依赖 ──────────────────────────
echo.
echo [1/2] 安装监控程序依赖（可能需要几分钟）...
cd /d "%~dp0mjzj-monitor"
python -m venv .venv
.venv\Scripts\pip install -r requirements.txt -q --index-url https://pypi.tuna.tsinghua.edu.cn/simple
if errorlevel 1 ( echo [错误] 依赖安装失败 & pause & exit /b 1 )
echo [OK] 监控程序依赖安装完成

REM ── 安装生成器依赖 ────────────────────────────
echo.
echo [2/2] 安装头条生成器依赖（可能需要几分钟）...
cd /d "%~dp0mjzj-wechat-gen"
python -m venv .venv
.venv\Scripts\pip install -r requirements.txt -q --index-url https://pypi.tuna.tsinghua.edu.cn/simple
if errorlevel 1 ( echo [错误] 依赖安装失败 & pause & exit /b 1 )
echo [OK] 头条生成器依赖安装完成

REM ── 初始化 .env 配置文件 ──────────────────────
cd /d "%~dp0"
if not exist "mjzj-monitor\.env" (
    copy "mjzj-monitor\.env.example" "mjzj-monitor\.env" >nul
    echo [需要填写] mjzj-monitor\.env 已创建，请用记事本填入 API Key
)
if not exist "mjzj-wechat-gen\.env" (
    copy "mjzj-wechat-gen\.env.example" "mjzj-wechat-gen\.env" >nul
    REM 自动写入草稿目录路径（Windows 绝对路径）
    echo MONITOR_DRAFTS_DIR=%~dp0mjzj-monitor\data\drafts>> "mjzj-wechat-gen\.env"
    echo [需要填写] mjzj-wechat-gen\.env 已创建，请用记事本填入 API Key
)

echo.
echo =============================================
echo   初始化完成！下一步：
echo   1. 用记事本打开并填写两个 .env 文件的 API Key
echo   2. 填好后双击 start.bat 启动服务
echo =============================================
pause
