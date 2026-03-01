# 王里鑫的工作 - 酷炫记事本

一个功能丰富、界面美观的在线记事本应用，专为工作和学习设计。

## 🌟 主要功能

### 📝 核心功能
- **新建笔记**：快速创建新笔记
- **编辑笔记**：点击笔记卡片即可编辑
- **删除笔记**：支持笔记删除操作
- **搜索功能**：实时搜索笔记标题和内容
- **本地存储**：所有笔记自动保存到浏览器本地存储

### 🎨 设计特色
- **渐变背景**：动态渐变背景效果
- **响应式设计**：完美适配桌面和移动设备
- **平滑动画**：所有交互都有流畅的动画
- **卡片布局**：优雅的笔记展示方式
- **模态框设计**：现代化的编辑界面

### ⌨️ 快捷键支持
- `Ctrl/Cmd + N`：新建笔记
- `Ctrl/Cmd + F`：聚焦搜索框
- `Esc`：关闭模态框

## 🚀 部署到 GitHub Pages

### 方法一：使用部署脚本（Windows）

1. 双击运行 `deploy.bat`
2. 按照提示操作：
   - 如果是首次运行，会自动初始化 Git 仓库
   - 需要您手动在 GitHub 上创建一个新仓库
   - 复制仓库地址粘贴到脚本中
3. 脚本会自动完成部署

### 方法二：手动部署

1. **创建 GitHub 仓库**
   - 访问 https://github.com/new
   - 仓库名建议：`wanglixin-notes` 或 `notes-app`
   - 选择 Public（公开）
   - 不要初始化 README、.gitignore 或 LICENSE

2. **初始化本地仓库**
   ```bash
   git init
   git config user.name "王里鑫"
   git config user.email "your@email.com"
   git add index.html style.css script.js deploy.bat README.md
   git commit -m "初始化笔记项目"
   ```

3. **连接远程仓库**
   ```bash
   git remote add origin https://github.com/yourusername/repositoryname.git
   ```

4. **部署到 GitHub Pages**
   ```bash
   git checkout -b gh-pages
   git push -u origin gh-pages
   ```

5. **启用 GitHub Pages**
   - 进入仓库的 Settings
   - 找到 Pages 选项
   - 选择部署源为 Deploy from a branch
   - 选择 gh-pages 分支
   - 点击 Save

## 📱 使用说明

1. **本地使用**：直接双击 `index.html` 即可在浏览器中打开
2. **在线使用**：部署后访问您的 GitHub Pages 地址
3. **数据存储**：所有笔记都会保存到浏览器本地存储中

## 🛠️ 技术栈

- **HTML5**：语义化结构
- **CSS3**：现代样式和动画
- **JavaScript ES6+**：功能实现
- **LocalStorage**：数据存储
- **Font Awesome**：图标（通过 CDN）

## 🎯 项目结构

```
.
├── index.html     # 主页面
├── style.css      # 样式文件
├── script.js      # 功能实现
├── deploy.bat     # Windows 部署脚本
└── README.md      # 项目说明
```

## 🔄 常见问题

### 1. 笔记数据在哪里？
- 笔记数据保存在浏览器的 LocalStorage 中
- 每个浏览器的数据是独立的
- 清除浏览器数据会导致笔记丢失

### 2. 部署后访问不了？
- 检查 GitHub Pages 是否已启用
- 确认分支是否正确（gh-pages）
- 等待几分钟，部署可能需要时间

### 3. 如何更新内容？
- 修改文件后重新运行 `deploy.bat`
- 或手动执行 `git add` 和 `git commit` 后重新推送

## 📄 许可证

MIT License

## 🤝 反馈与建议

如有任何问题或建议，请通过以下方式联系：
- 邮箱：your@email.com
- GitHub Issues：仓库的 Issues 页面