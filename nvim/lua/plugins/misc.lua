return {

    -- Identation
    {"tpope/vim-sleuth"},

    -- Comment
    {
        "numToStr/Comment.nvim",
        opts = {},
    },

    -- Buffers helper
    -- {"vim-scripts/BufOnly.vim"},

    -- Surround
    {"tpope/vim-surround"},

    -- Better text objects
    {
        "echasnovski/mini.ai",
        opts = {
            search_method = "cover",
            n_lines = 5000,
        },
    },
    -- Moving lines
    {
        "echasnovski/mini.move",
        opts = {
            mappings = {
                left = "H",
                down = "J",
                up = "K",
                right = "L",
            },
        },
    },
    -- Better quick fix
    {
        "kevinhwang91/nvim-bqf",
        name = "bfq",
        ft = "qf",
        opts = {
                auto_resize_height = false,
                preview = {
                    auto_preview = false,
                },
            },
    }
}
