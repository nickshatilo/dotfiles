local config = function()
    local keymap = vim.keymap

    require('telescope').setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-j>"] = "move_selection_next",
                }
            }
        },
        extensions = {
            ['ui-select'] = {
                require('telescope.themes').get_dropdown(),
            },
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        }
    })

    local telescope_builtin = require('telescope.builtin')

    keymap.set('n', '<leader>t', telescope_builtin.find_files, {})
    keymap.set('n', '<leader>sh', telescope_builtin.help_tags, {})
    keymap.set('n', '<leader>sr', telescope_builtin.resume, {})
    keymap.set('n', '\\f', telescope_builtin.live_grep, {})
    keymap.set('n', '\\F', telescope_builtin.git_files, {})
    keymap.set('n', '\\b', telescope_builtin.buffers, {})
    keymap.set('n', '\\B', telescope_builtin.current_buffer_fuzzy_find, {})
    keymap.set('n', '<Leader>qq', telescope_builtin.quickfix, {})
    keymap.set('n', '<Leader>qh', telescope_builtin.quickfixhistory, {})

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
end

return {
    init = function(use)
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.x',
            requires = {
                'nvim-lua/plenary.nvim',
                'BurntSushi/ripgrep',
            },
            config = config
        }
        use {
            'nvim-telescope/telescope-ui-select.nvim'
        }
        use {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        }
    end
}
