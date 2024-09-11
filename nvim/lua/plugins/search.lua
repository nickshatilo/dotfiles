local init = function(_, _)
    local opts = {
        defaults = {
            mappings = {
                i = {
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-j>"] = "move_selection_next",
                },
            },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown(),
            },
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    }

    local telescope = require("telescope")
    telescope.setup(opts)

    local keymap = vim.keymap

    local telescope_builtin = require("telescope.builtin")

    keymap.set("n", "<leader>t", telescope_builtin.find_files, {})
    keymap.set("n", "<leader>sh", telescope_builtin.help_tags, {})
    keymap.set("n", "<leader>sr", telescope_builtin.resume, {})
    keymap.set("n", "\\f", telescope_builtin.live_grep, {})
    keymap.set("n", "\\F", telescope_builtin.git_files, {})
    keymap.set("n", "\\b", telescope_builtin.buffers, {})
    keymap.set("n", "\\B", telescope_builtin.current_buffer_fuzzy_find, {})
    keymap.set("n", "<Leader>qq", telescope_builtin.quickfix, {})
    keymap.set("n", "<Leader>qh", telescope_builtin.quickfixhistory, {})

    -- Enable telescope extensions, if they are installed
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")
end

return {
    {
        "nvim-telescope/telescope.nvim",
        -- main = "telescope",
        version = "^0.1.0",
        requires = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = init,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },

    -- Customisation functions
    grep_in_folder = function(path)
        local telescope_builtin = require("telescope.builtin")

        telescope_builtin.grep_files({
            prompt_title = "Grep files (in path)",
            cwd = path,
        })
    end,
    find_file_in_folder = function(path)
        local telescope_builtin = require("telescope.builtin")
        telescope_builtin.find_files({
            prompt_title = "Find Files (in path)",
            cwd = path,
        })
    end,
}
