vim.g.mapleader = " "

local keymap = vim.keymap

-- -----------视觉模式 -----------
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ----正常模式------
--窗口

keymap.set("n", "<leader>sv", "<C-w>v") --水平添加窗口
keymap.set("n", "<leader>sh", "<C-w>s") --垂直添加窗口


local keymap = vim.keymap


-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口 
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口
keymap.set('n', '<leader>w', '<cmd>w!<CR>')
keymap.set('n', '<leader>q', '<cmd>q!<CR>')

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")


-- -- 切换buffer
-- keymap.set("n", "<leader>l", ":bnext<CR>")
-- keymap.set("n", "<leader>h", ":bprevious<CR>")

-- ---------- 插件 ---------- ---
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

--nvim-lsp
local bufopts = {noremap = true, silent = true, buffer = bufnr}
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

--BufferLine
keymap.set('n', '<TAB>', ':BufferLineCycleNext <CR>') --移动窗口
keymap.set('n', '<S-TAB>', ':BufferLineCyclePrev <CR>')
