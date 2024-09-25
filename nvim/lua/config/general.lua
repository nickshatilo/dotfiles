local silent_noremap_opts = { silent = true, noremap = true }

local api = vim.api
local g = vim.g
local opt = vim.opt
local keymap = vim.keymap

opt.ignorecase = true
opt.smartcase = true

opt.smarttab = true
opt.smartindent = true

opt.number = true
opt.relativenumber = true
opt.autoread = true

-- Proper colors
opt.termguicolors = true

-- Makes clipboard system one
opt.clipboard = "unnamedplus"

-- Save undo history
opt.undofile = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Dont show mode
opt.showmode = false

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Leader
g.mapleader = ","
g.maplocalleader = ","

-- NVIM-tree asks to disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Search unhighlighting
api.nvim_set_keymap("n", "\\q", ":nohlsearch<CR>", {})

-- Reload current file
api.nvim_set_keymap("n", "\\e", ":e<CR>", {})

-- Copy current file absolute path
api.nvim_set_keymap("n", "cp", ':let @+ = expand("%:p")<CR>', {})
-- Copy current file relative path
api.nvim_set_keymap("n", "cP", ':let @+ = expand("%")<CR>', {})

-- Split navigation
api.nvim_set_keymap("n", "<C-j>", "<C-W>j", {})
api.nvim_set_keymap("n", "<C-k>", "<C-W>k", {})
api.nvim_set_keymap("n", "<C-h>", "<C-W>h", {})
api.nvim_set_keymap("n", "<C-l>", "<C-W>l", {})

-- Next buffer
api.nvim_set_keymap("", "<C-n>", ":BufferLineCycleNext<CR>", silent_noremap_opts)
api.nvim_set_keymap("", "<C-p>", ":BufferLineCyclePrev<CR>", silent_noremap_opts)

-- Close buffer without closing a split
api.nvim_set_keymap("", "<Leader>w", ":bp<bar>sp<bar>bn<bar>bd<CR>", {})

-- Focus current split
api.nvim_set_keymap("", "<Leader>o", ":BufferLineCloseOthers<CR>", silent_noremap_opts)

-- Skip quickfix window when switching buffers
vim.cmd([[
augroup qf
autocmd!
autocmd FileType qf set nobuflisted
augroup EN
]])

-- Folds
api.nvim_set_keymap("v", "<space>", "zf", { noremap = true }) -- fold
api.nvim_set_keymap("n", "<space>", "za", { noremap = true }) -- unfold

-- Terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Quickfix toggle
local function is_quickfix_open()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            return true
        end
    end
    return false
end

vim.keymap.set("n", "<Leader>qt", function()
    if is_quickfix_open() then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { silent = true })
