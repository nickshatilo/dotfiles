return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    build = "make",
    opts = {
        provider = "claude",
        -- provider = "deepseek",
        file_selector = {
            provider = "telescope",
        },
        providers = {
            deepseek = {
                __inherited_from = "openai",
                api_key_name = "DEEPSEEK_API_KEY",
                endpoint = "https://api.deepseek.com",
                model = "deepseek-reasoner",
            },
            groq = {
                __inherited_from = 'openai',
                api_key_name = 'GROQ_API_KEY',
                endpoint = 'https://api.groq.com/openai/v1/',
                model = 'qwen-2.5-coder-32b',
                timeout = 100000, -- Timeout in milliseconds
                max_tokens = 40960,
            },
        },
        cursor_applying_provider = 'groq',
        auto_suggestions_provider = 'claude',
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            enable_cursor_planning_mode = true,
        },
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
            "<leader>ac",
            function()
                require("avante.api").chat()
            end,
            desc = "avante: chat",
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
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "nvim-telescope/telescope.nvim",
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
