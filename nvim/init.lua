require('general')

require('plugins').init_packer(function(use)
    -- Appearance
    use {
        'lunarvim/Onedarker.nvim',
        config = function()
            -- vim.cmd('colorscheme onedarker')
        end
    }
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require('catppuccin').setup({
                flavour = "mocha",
            })

            vim.cmd('colorscheme catppuccin')
        end
    }

    -- Navigation
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
                options = {
                    buffer_close_icon = '',
                    modified_icon = '●',
                    close_icon = '',
                    left_trunc_marker = '',
                    right_trunc_marker = '',
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Explorer",
                            text_align = "left",
                            separator = true
                        }
                    },
                    color_icons = true,
                }
            }
        end
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup({
                filters = {
                    git_ignored = false,
                    dotfiles = false,
                    git_clean = false,
                    no_buffer = false
                }
            })

            vim.api.nvim_set_keymap('', '<Leader>n', ':NvimTreeToggle<CR>', {})
            vim.api.nvim_set_keymap('', '<Leader><Space>n', ':NvimTreeFindFileToggle<CR>', {})

            -- Close NvimTree on quit
            vim.api.nvim_create_autocmd({ "QuitPre" }, {
                callback = function() vim.cmd("NvimTreeClose") end,
            })
        end,
    }
    -- Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function ()
            require('lualine').setup {
                options = { theme = 'nightfly' },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                }
            }
        end
    }

    -- LSP
    require('lsp').init(use)

    -- Telescope
    require('search').init(use)

    -- GIT
    require('git').init(use)

    -- Tresitter
    require('treesitter').init(use)

    -- Identation
    use 'tpope/vim-sleuth'

    -- Comment
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Buffers helper
    use 'vim-scripts/BufOnly.vim'

    -- Surround
    use {
        'tpope/vim-surround'
    }

    -- Better text objects
    use {
        'echasnovski/mini.ai',
        config = function()
            require('mini.ai').setup()
        end
    }
end)
