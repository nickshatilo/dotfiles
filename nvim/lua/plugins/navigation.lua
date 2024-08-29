return {
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        lazy = false,
        opts = {
                options = {
                    buffer_close_icon = "",
                    modified_icon = "●",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Explorer",
                            text_align = "left",
                            separator = true,
                        },
                    },
                    color_icons = true,
                }
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        opts = {
            filters = {
                git_ignored = false,
                dotfiles = false,
                git_clean = false,
                no_buffer = false,
            },
            on_attach = function(bf)
                local api = require("nvim-tree.api")
                local search = require("plugins.search")
                local opts = { buffer = bf, noremap = true, silent = false, nowait = true }

                -- default mappings
                api.config.mappings.default_on_attach(bf)

                local get_current_directory = function()
                    local node = api.tree.get_node_under_cursor()

                    if node.type == nil then
                        return vim.fn.getcwd()
                    elseif node.type == "directory" then
                        return node.absolute_path
                    else
                        return node.parent.absolute_path
                    end
                end

                local grep_in_directory = function()
                    search.grep_in_folder(get_current_directory())
                end

                local find_file_in_directory = function()
                    search.find_file_in_folder(get_current_directory())
                end

                vim.keymap.set("n", "\\f", grep_in_directory, opts)
                vim.keymap.set("n", "<Leader>t", find_file_in_directory, opts)
            end,
        },
        init = function()
            vim.api.nvim_set_keymap("", "<Leader>n", ":NvimTreeToggle<CR>", {})
            vim.api.nvim_set_keymap("", "<Leader><Space>n", ":NvimTreeFindFileToggle<CR>", {})

            -- Close NvimTree on quit
            vim.api.nvim_create_autocmd({ "QuitPre" }, {
                callback = function()
                    vim.cmd("NvimTreeClose")
                end,
            })
        end,
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        lazy = false,
        init = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "\\h", ui.toggle_quick_menu, {})
            vim.keymap.set("n", "<Leader>a", mark.add_file, {})

            vim.keymap.set("n", "<M-n>", ui.nav_next, {})
            vim.keymap.set("n", "<M-p>", ui.nav_prev, {})

            for i = 1, 9 do
                vim.keymap.set("n", string.format("<Leader>%d", i), function()
                    ui.nav_file(i)
                end, {})
            end
        end,
    }
}
