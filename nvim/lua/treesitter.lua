local function config()
    require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the four listed parsers should always be installed)
        ensure_installed = { "lua", "vim", "javascript", "typescript", "solidity", "terraform", "markdown", "vimdoc", "html", "css", "json", "yaml" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            additional_vim_regex_highlighting = false,

            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(_, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,

        },

        indent = {
            enable = true
        },

        refactor = {
            navigation = {
                enable = true,
                keymaps = {
                    goto_definition = false,
                    list_definitions = false,
                    list_definitions_toc = false,
                    goto_next_usage = false,
                    goto_previous_usage = false,
                },
            },
  },
    }

end

return {
    init = function(use)
        use {
            'nvim-treesitter/nvim-treesitter',
            tag = 'v0.9.2',
            run = ':TSUpdate',
            config = config
        }
        use {
            'nvim-treesitter/nvim-treesitter-context',
            config = function ()
                require'treesitter-context'.setup{
                    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                    line_numbers = true,
                    multiline_threshold = 20, -- Maximum number of lines to show for a single context
                    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                    -- Separator between context and content. Should be a single character string, like '-'.
                    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                    separator = nil,
                    zindex = 20, -- The Z-index of the context window
                    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
                }
            end
        }
        use {'nvim-treesitter/nvim-treesitter-refactor'}
    end
}
