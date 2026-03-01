// 笔记数据存储
let notes = JSON.parse(localStorage.getItem('wanglixinNotes')) || [];
let currentNoteId = null;

// DOM 元素
const notesGrid = document.getElementById('notesGrid');
const newNoteBtn = document.getElementById('newNoteBtn');
const noteModal = document.getElementById('noteModal');
const closeModal = document.getElementById('closeModal');
const cancelBtn = document.getElementById('cancelBtn');
const saveBtn = document.getElementById('saveBtn');
const modalTitle = document.getElementById('modalTitle');
const noteTitle = document.getElementById('noteTitle');
const noteContent = document.getElementById('noteContent');
const searchInput = document.getElementById('searchInput');

// 初始化
document.addEventListener('DOMContentLoaded', () => {
    renderNotes();
    setupEventListeners();
});

// 设置事件监听器
function setupEventListeners() {
    newNoteBtn.addEventListener('click', openNewNoteModal);
    closeModal.addEventListener('click', closeNoteModal);
    cancelBtn.addEventListener('click', closeNoteModal);
    saveBtn.addEventListener('click', saveNote);
    searchInput.addEventListener('input', searchNotes);

    // 点击模态框外部关闭
    noteModal.addEventListener('click', (e) => {
        if (e.target === noteModal) {
            closeNoteModal();
        }
    });

    // ESC 键关闭模态框
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && noteModal.classList.contains('active')) {
            closeNoteModal();
        }
    });
}

// 打开新建笔记模态框
function openNewNoteModal() {
    currentNoteId = null;
    modalTitle.textContent = '新建笔记';
    noteTitle.value = '';
    noteContent.value = '';
    noteModal.classList.add('active');
    noteTitle.focus();
}

// 打开编辑笔记模态框
function openEditNoteModal(id) {
    const note = notes.find(note => note.id === id);
    if (note) {
        currentNoteId = id;
        modalTitle.textContent = '编辑笔记';
        noteTitle.value = note.title;
        noteContent.value = note.content;
        noteModal.classList.add('active');
        noteTitle.focus();
    }
}

// 关闭模态框
function closeNoteModal() {
    noteModal.classList.remove('active');
    currentNoteId = null;
    noteTitle.value = '';
    noteContent.value = '';
}

// 保存笔记
function saveNote() {
    const title = noteTitle.value.trim();
    const content = noteContent.value.trim();

    if (!title && !content) {
        alert('请输入笔记标题或内容');
        return;
    }

    const noteData = {
        title: title,
        content: content,
        updatedAt: new Date().toISOString()
    };

    if (currentNoteId) {
        // 编辑现有笔记
        const index = notes.findIndex(note => note.id === currentNoteId);
        if (index !== -1) {
            notes[index] = { ...notes[index], ...noteData };
        }
    } else {
        // 新建笔记
        const newNote = {
            id: Date.now().toString(),
            ...noteData,
            createdAt: new Date().toISOString()
        };
        notes.unshift(newNote);
    }

    saveNotes();
    renderNotes();
    closeNoteModal();
}

// 删除笔记
function deleteNote(id) {
    if (confirm('确定要删除这篇笔记吗？')) {
        notes = notes.filter(note => note.id !== id);
        saveNotes();
        renderNotes();
    }
}

// 保存到本地存储
function saveNotes() {
    localStorage.setItem('wanglixinNotes', JSON.stringify(notes));
}

// 渲染笔记
function renderNotes(notesToRender = notes) {
    notesGrid.innerHTML = '';

    if (notesToRender.length === 0) {
        notesGrid.innerHTML = `
            <div class="empty-state">
                <h3>📝 暂无笔记</h3>
                <p>点击"新建笔记"开始记录你的工作灵感</p>
            </div>
        `;
        return;
    }

    notesToRender.forEach(note => {
        const noteCard = createNoteCard(note);
        notesGrid.appendChild(noteCard);
    });
}

// 创建笔记卡片
function createNoteCard(note) {
    const card = document.createElement('div');
    card.className = 'note-card';

    const formattedDate = formatDate(note.updatedAt);

    card.innerHTML = `
        <div class="note-header">
            <h3 class="note-title">${escapeHtml(note.title) || '无标题'}</h3>
            <span class="note-date">${formattedDate}</span>
        </div>
        <p class="note-content">${escapeHtml(note.content)}</p>
        <div class="note-actions">
            <button class="action-btn edit-btn" data-id="${note.id}">
                ✏️
            </button>
            <button class="action-btn delete-btn" data-id="${note.id}">
                🗑️
            </button>
        </div>
    `;

    // 添加点击事件
    card.addEventListener('click', (e) => {
        if (e.target.closest('.edit-btn')) {
            openEditNoteModal(note.id);
        } else if (e.target.closest('.delete-btn')) {
            deleteNote(note.id);
        } else {
            openEditNoteModal(note.id);
        }
    });

    return card;
}

// 搜索笔记
function searchNotes() {
    const searchTerm = searchInput.value.toLowerCase().trim();

    if (!searchTerm) {
        renderNotes();
        return;
    }

    const filteredNotes = notes.filter(note =>
        note.title.toLowerCase().includes(searchTerm) ||
        note.content.toLowerCase().includes(searchTerm)
    );

    renderNotes(filteredNotes);
}

// 格式化日期
function formatDate(dateString) {
    const date = new Date(dateString);
    const now = new Date();
    const diff = now - date;

    // 小于 1 分钟
    if (diff < 60000) {
        return '刚刚';
    }

    // 小于 1 小时
    if (diff < 3600000) {
        const minutes = Math.floor(diff / 60000);
        return `${minutes}分钟前`;
    }

    // 小于 24 小时
    if (diff < 86400000) {
        const hours = Math.floor(diff / 3600000);
        return `${hours}小时前`;
    }

    // 小于 7 天
    if (diff < 604800000) {
        const days = Math.floor(diff / 86400000);
        return `${days}天前`;
    }

    // 显示完整日期
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

// HTML 转义函数
function escapeHtml(text) {
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };

    return text.replace(/[&<>"]/g, function(m) { return map[m]; });
}

// 添加键盘快捷键支持
document.addEventListener('keydown', (e) => {
    // Ctrl/Cmd + N 新建笔记
    if ((e.ctrlKey || e.metaKey) && e.key === 'n') {
        e.preventDefault();
        openNewNoteModal();
    }

    // Ctrl/Cmd + F 搜索
    if ((e.ctrlKey || e.metaKey) && e.key === 'f') {
        e.preventDefault();
        searchInput.focus();
    }
});