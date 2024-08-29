return {
    -- Icons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- Themes
    {
        "catppuccin/nvim",
        main = "catppuccin",
        opts = {
            flavour = "mocha",
        },
        init = function()
            vim.cmd("colorscheme catppuccin")
        end,
        lazy = false,
        priority = 1000,
    },
    { "lunarvim/Onedarker.nvim", lazy = true },

    -- Line
    {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        lazy = false,
        opts = {
            options = { theme = "nightfly" },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
}
