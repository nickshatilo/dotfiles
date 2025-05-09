return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    build = "make",
    opts = {
        provider = "claude",
        -- auto_suggestions_provider = "copilot",
    },
    behaviour = {
        auto_suggestions = false, -- Experimental stage
    },
    keys = {
        {
            "<leader>aa",
            function()
                require("avante.api").ask()
            end,
            desc = "avante: ask",
            mode = { "n", "v" },
        },
        {
            "<leader>ar",
            function()
                require("avante.api").refresh()
            end,
            desc = "avante: refresh",
        },
        {
            "<leader>at",
            function()
                require("avante.api").toggle()
            end,
            desc = "avante: toggle",
        },
        {
            "<leader>ae",
            function()
                require("avante.api").edit()
            end,
            desc = "avante: edit",
            mode = "v",
        },
    },
    dependencies = {
        -- "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            "MeanderingProgrammer/render-markdown.nvim",
            lazy = true,
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
