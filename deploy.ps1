<#
    王里鑫的工作 - 笔记部署脚本 (PowerShell 版本)
#>

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "      王里鑫的工作 - 笔记部署脚本" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# 检查是否已安装 Git
try {
    $gitVersion = git --version
    Write-Host "[信息] Git 版本: $gitVersion"
} catch {
    Write-Host "[错误] 未检测到 Git，请先安装 Git 后再运行此脚本" -ForegroundColor Red
    Write-Host "下载地址: https://git-scm.com/downloads" -ForegroundColor Yellow
    Read-Host "按任意键退出"
    exit 1
}

# 检查是否已初始化 Git 仓库
if (-not (Test-Path -Path .git -PathType Container)) {
    Write-Host "[信息] 首次运行，初始化 Git 仓库..." -ForegroundColor Green
    git init
    git config user.name "王里鑫"
    git config user.email "wanglixin@example.com"
    git add index.html style.css script.js deploy.bat deploy_gbk.bat deploy.ps1 README.md
    git commit -m "初始化笔记项目"
    Write-Host "[成功] Git 仓库已初始化" -ForegroundColor Green
} else {
    Write-Host "[信息] Git 仓库已存在" -ForegroundColor Green
    git add index.html style.css script.js deploy.bat deploy_gbk.bat deploy.ps1 README.md
    git commit -m "更新笔记内容" 2>$null | Out-Null
    if ($LASTEXITCODE -eq 1) {
        Write-Host "[信息] 无内容需要提交" -ForegroundColor Yellow
    } else {
        Write-Host "[成功] 内容已提交" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "部署步骤：" -ForegroundColor White
Write-Host "1. 访问 GitHub 创建新仓库 (https://github.com/new)" -ForegroundColor White
Write-Host "2. 仓库名建议: wanglixin-notes 或 notes-app" -ForegroundColor White
Write-Host "3. 仓库类型选择 Public" -ForegroundColor White
Write-Host "4. 不要初始化 README、.gitignore 或 LICENSE" -ForegroundColor White
Write-Host "5. 创建完成后，复制仓库的 HTTPS 地址" -ForegroundColor White
Write-Host "6. 在下方输入仓库地址" -ForegroundColor White
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$remoteUrl = Read-Host "请输入 GitHub 仓库地址"

# 添加远程仓库
git remote remove origin 2>$null | Out-Null
git remote add origin $remoteUrl

# 创建 gh-pages 分支
Write-Host ""
Write-Host "[信息] 创建部署分支..." -ForegroundColor Green
git branch -D gh-pages 2>$null | Out-Null
git checkout -b gh-pages

# 推送到 GitHub
Write-Host ""
Write-Host "[信息] 正在推送到 GitHub Pages..." -ForegroundColor Green
git push -u origin gh-pages --force

if ($LASTEXITCODE -eq 1) {
    Write-Host ""
    Write-Host "[错误] 推送失败！" -ForegroundColor Red
    Write-Host "请检查：" -ForegroundColor White
    Write-Host "1. GitHub 仓库地址是否正确" -ForegroundColor White
    Write-Host "2. 是否已登录 GitHub（可能需要在命令行登录）" -ForegroundColor White
    Write-Host "3. 网络连接是否正常" -ForegroundColor White
    Read-Host "按任意键退出"
    exit 1
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "[成功] 部署完成！" -ForegroundColor Green
Write-Host ""
Write-Host "您的笔记已成功部署到：" -ForegroundColor White
$deployUrl = $remoteUrl -replace "https://github.com/", "https://"
$deployUrl = $deployUrl -replace ".git", ".github.io/"
Write-Host $deployUrl -ForegroundColor Yellow
Write-Host ""
Write-Host "访问路径示例：" -ForegroundColor White
Write-Host "如果仓库地址是 https://github.com/yourusername/notes.git" -ForegroundColor White
Write-Host "访问地址就是 https://yourusername.github.io/notes/" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "请访问 https://github.com/settings/pages 启用 Pages 功能" -ForegroundColor White
Write-Host "部署通常需要几到十分钟生效" -ForegroundColor White
Read-Host "按任意键退出"