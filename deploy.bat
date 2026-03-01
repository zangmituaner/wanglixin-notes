@echo off
chcp 65001 >nul
echo ==========================================
echo       王里鑫的工作 - 笔记部署脚本
echo ==========================================
echo.

:: 检查是否已安装 Git
git --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Git，请先安装 Git 后再运行此脚本
    echo 下载地址: https://git-scm.com/downloads
    pause
    exit /b 1
)

:: 检查是否已初始化 Git 仓库
if not exist ".git" (
    echo [信息] 首次运行，初始化 Git 仓库...
    git init
    git config user.name "王里鑫"
    git config user.email "wanglixin@example.com"
    git add index.html style.css script.js deploy.bat README.md
    git commit -m "初始化笔记项目"
    echo [成功] Git 仓库已初始化
) else (
    echo [信息] Git 仓库已存在
    git add index.html style.css script.js deploy.bat README.md
    git commit -m "更新笔记内容" 2>nul || echo [信息] 无内容需要提交
)

echo.
echo ==========================================
echo 部署步骤：
echo 1. 访问 GitHub 创建新仓库 (https://github.com/new)
echo 2. 仓库名建议: wanglixin-notes 或 notes-app
echo 3. 仓库类型选择 "Public" (公开)
echo 4. 不要初始化 README、.gitignore 或 LICENSE
echo 5. 创建完成后，复制仓库的 HTTPS 地址
echo 6. 在下方输入仓库地址
echo ==========================================
echo.

set /p remote_url="请输入 GitHub 仓库地址: "

:: 添加远程仓库
git remote remove origin 2>nul
git remote add origin %remote_url%

:: 创建 gh-pages 分支
echo.
echo [信息] 创建部署分支...
git branch -D gh-pages 2>nul
git checkout -b gh-pages

:: 推送到 GitHub
echo.
echo [信息] 正在推送到 GitHub Pages...
git push -u origin gh-pages --force

if errorlevel 1 (
    echo.
    echo [错误] 推送失败！
    echo 请检查：
    echo 1. GitHub 仓库地址是否正确
    echo 2. 是否已登录 GitHub（可能需要在命令行登录）
    echo 3. 网络连接是否正常
    pause
    exit /b 1
)

echo.
echo ==========================================
echo [成功] 部署完成！
echo.
echo 您的笔记已成功部署到：
echo https://%remote_url:https://github.com/=%/
echo.
echo 访问路径示例：
echo 如果仓库地址是 https://github.com/yourusername/notes
echo 访问地址就是 https://yourusername.github.io/notes/
echo ==========================================
echo.
echo 请访问 https://github.com/settings/pages 启用 Pages 功能
echo 部署通常需要几到十分钟生效
pause