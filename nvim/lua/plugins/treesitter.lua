return {
    -- General treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        version = "v0.9.x",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            -- A list of parser names, or "all" (the four listed parsers should always be installed)
            ensure_installed = {
                "lua",
                "vim",
                "javascript",
                "typescript",
                "solidity",
                "terraform",
                "markdown",
                "vimdoc",
                "html",
                "css",
                "json",
                "yaml",
                "func",
                "tlb",
            },

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
                enable = true,
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
        },
        config = function(_, opts)
            -- TLB Support
            vim.filetype.add({
                extension = {
                    tlb = "tlb",
                },
            })
            vim.filetype.add({
                extension = {
                    func = "func",
                },
            })

            vim.treesitter.language.register("tlb", "tlb")
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

            parser_config.tlb = {
                install_info = {
                    url = "~/Dev/own/sspp/tree-sitter-tlb", -- local path or git repo
                    files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
                    -- optional entries:
                    branch = "main", -- default branch in case of git repo if different from master
                    generate_requires_npm = true, -- if stand-alone parser without npm dependencies
                    requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
                },
                filetype = "tlb", -- if filetype does not match the parser name
            }

            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        main = "treesitter-context",
        opts = {
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20, -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        },
    },

    -- Custom lang support
    { "vyperlang/vim-vyper" },
}
