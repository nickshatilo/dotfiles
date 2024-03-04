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
        }
    }

end

return {
    init = function(use)
        use {
            'nvim-treesitter/nvim-treesitter',
            tag = 'v0.9.1',
            run = ':TSUpdate',
            config = config
        }
    end
}
