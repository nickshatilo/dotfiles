local silent_noremap_opts = { silent = true, noremap = true }

local api = vim.api
local g = vim.g
local opt = vim.opt
local keymap = vim.keymap

opt.ignorecase = true
opt.smartcase = true
-- opt.


opt.smarttab = true
opt.smartindent = true

opt.number = true
opt.rnu = true
opt.autoread = true

-- opt.laststatus = 0

-- ?
opt.termguicolors = true

-- Makes clipboard system one
opt.clipboard = "unnamedplus"

g.mapleader = ","
g.maplocalleader = ","

api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", {})
api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", {})

-- NVIM-tree asks to disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Search unhighlighting
api.nvim_set_keymap('n', '\\q', ':nohlsearch<CR>', {})

-- Reload current file
api.nvim_set_keymap('n', '\\e', ':e<CR>', {})
api.nvim_set_keymap('n', '\\!e', ':e!<CR>', {})
-- Copy current file absolute path
api.nvim_set_keymap('n', 'cp', ':let @+ = expand("%")<CR>', {})

-- Split navigation
api.nvim_set_keymap('n', '<C-j>', '<C-W>j', {})
api.nvim_set_keymap('n', '<C-k>', '<C-W>k', {})
api.nvim_set_keymap('n', '<C-h>', '<C-W>h', {})
api.nvim_set_keymap('n', '<C-l>', '<C-W>l', {})

-- Close buffer without closing a split
api.nvim_set_keymap('', '<Leader>w', ':bp<bar>sp<bar>bn<bar>bd<CR>', {})

-- Close current split
api.nvim_set_keymap('', '<Leader>x', ':hide<CR>', silent_noremap_opts)
api.nvim_set_keymap('', '<Leader>X', ':hide!<CR>', silent_noremap_opts)

-- Focus current split
api.nvim_set_keymap('', '<Leader>O', ':only<CR>', silent_noremap_opts)

-- Edit VIM config
api.nvim_set_keymap('n', 'm<Leader><Leader>', ':edit $MYVIMRC<CR>', silent_noremap_opts)
-- Reloading VIM config
api.nvim_set_keymap('n', '<Leader><Leader>', ':luafile $MYVIMRC<CR>', silent_noremap_opts)

-- Open git
api.nvim_set_keymap('n', '<Leader>g', ':Git<CR>', silent_noremap_opts)
api.nvim_set_keymap('n', '<Leader>G', ':Git<CR>:only<CR>', silent_noremap_opts)

-- Undotree
api.nvim_set_keymap('n', '<Leader>u', ':UndotreeToggle<CR>', silent_noremap_opts)

-- Shows trailing spaces
vim.cmd [[
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
]]
-- Delete all trailing spaces
api.nvim_set_keymap('n', '\\<Space>', ':%s/\\s\\+$//e<CR>', {})

-- Skip quickfix window when switching buffers
vim.cmd [[
augroup qf
autocmd!
autocmd FileType qf set nobuflisted
augroup EN
]]

-- Folds
api.nvim_set_keymap('v', '<space>', 'zf', { noremap = true }) -- fold
api.nvim_set_keymap('n', '<space>', 'za', { noremap = true }) -- unfold

-- Packer setup

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end

    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }

    use {
        'lunarvim/Onedarker.nvim'
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end,
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use {
        'tpope/vim-surround'
    }

    -- Searches
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }

    -- LSP
    -- Auto-completion

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' }, -- Optional
            { 'hrsh7th/cmp-path' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    -- Tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- GIT

    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'


    -- Bufferline
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
        end
    }

    -- Undotree

    use {
        'mbbill/undotree',
        config = function()
        end
    }

    use 'tpope/vim-projectionist'

    use 'vim-scripts/BufOnly.vim'

    -- Auto night mode

    -- use {
    --     'f-person/auto-dark-mode.nvim'
    -- }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- THEME SETUP


local lualine = require('lualine')

vim.cmd 'colorscheme onedarker'
lualine.setup {
    options = { theme = 'nightfly' }
}

-- local auto_dark_mode = require('auto-dark-mode')

-- auto_dark_mode.setup({
-- 	set_dark_mode = function()
--         vim.cmd 'colorscheme onedarker'
--         lualine.setup {
--             options = { theme = 'nightfly' }
--         }
-- 	end,
-- 	set_light_mode = function()
-- 		vim.cmd('colorscheme gruvbox')
--         lualine.setup {
--             options = { theme = 'gruvbox' }
--         }
-- 	end,
-- })
-- auto_dark_mode.init()




-- NVIM TREE SETUP

require('nvim-tree').setup()

api.nvim_set_keymap('', '<Leader>n', ':NvimTreeToggle<CR>', silent_noremap_opts)
api.nvim_set_keymap('', '<Leader><Space>n', ':NvimTreeFindFileToggle<CR>', silent_noremap_opts)


-- BUFFERLINE SETUP

require('bufferline').setup {
    options = {
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        --  diagnostics = false | "nvim_lsp" | "coc",
        -- diagnostics_update_in_insert = false,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        offsets = {
            {
                filetype = "NvimTree",
                text = "Explorer",
                text_align = "left",
                separator = true
            }
        },
        color_icons = true, -- whether or not to add the filetype icon highlights
        -- show_buffer_close_icons = true | false,
        --show_buffer_default_icon = true | false, -- whether or not an unrecognised filetype should show a default icon
    }
}


api.nvim_set_keymap('', '<C-n>', ':BufferLineCycleNext<CR>', silent_noremap_opts)
api.nvim_set_keymap('', '<C-p>', ':BufferLineCyclePrev<CR>', silent_noremap_opts)


-- TELESCOPE SETUP

require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-k>"] = "move_selection_previous",
                ["<C-j>"] = "move_selection_next",
            }
        }
    },

}

local telescope_builtin = require('telescope.builtin')

keymap.set('n', '<leader>t', telescope_builtin.find_files, {})

keymap.set('n', '\\f', telescope_builtin.live_grep, {})
keymap.set('n', '\\F', telescope_builtin.git_files, {})
keymap.set('n', ';', telescope_builtin.buffers, {})

-- LSP SETUP

local lsp = require('lsp-zero')

lsp.preset({
    name = 'minimal',
    set_lsp_keymaps = false,
    manage_nvim_cmp = true,
    suggest_lsp_servers = true,
})

lsp.ensure_installed({
    'tsserver',
    -- 'eslint',
})

lsp.on_attach(function(_, bufnr)
    -- Jumps
    api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', silent_noremap_opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', silent_noremap_opts)

    -- References - Implementation searches
    api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', silent_noremap_opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gR', "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
        silent_noremap_opts)

    api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', silent_noremap_opts)

    -- Code action
    api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', silent_noremap_opts)

    -- Workspace folders
    api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
        silent_noremap_opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
        silent_noremap_opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', silent_noremap_opts)

    -- Hover magic
    api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', silent_noremap_opts)

    -- Rename
    api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', silent_noremap_opts)

    -- Diagnostics
    api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', silent_noremap_opts)

    api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', silent_noremap_opts)
    api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', silent_noremap_opts)

    api.nvim_buf_set_keymap(bufnr, 'n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', silent_noremap_opts)

    api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>',
        silent_noremap_opts)
end)

-- Enables neovim config to properly use lua auto-completion
lsp.nvim_workspace({
    library = vim.api.nvim_get_runtime_file('', true)
})

lsp.setup()

-- Shows errors as virtual text
vim.diagnostic.config({
    virtual_text = true,
})

-- TREESITTER

require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "lua", "vim", "help", "javascript", "typescript", "solidity" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        additional_vim_regex_highlighting = false,

        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(_lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

    },

    indent = {
        enable = true
    }
}
