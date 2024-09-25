local function git_signs_attach(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            gs.next_hunk()
        end)
        return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            gs.prev_hunk()
        end)
        return "<Ignore>"
    end, { expr = true })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk)
    map("n", "<leader>hr", gs.reset_hunk)
    map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)
    map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)
    map("n", "<leader>ha", gs.stage_buffer)
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hR", gs.reset_buffer)
    map("n", "<leader>hp", gs.preview_hunk)

    map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
    end)

    map("n", "<leader>htb", gs.toggle_current_line_blame)
    map("n", "<leader>htd", gs.toggle_deleted)
    map("n", "<leader>hd", gs.diffthis)

    map("n", "<leader>hD", function()
        gs.diffthis("~")
    end)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

return {
    {
        "tpope/vim-fugitive",
        dependencies = { "tpope/vim-dispatch" },
        init = function()
            vim.api.nvim_set_keymap("n", "<Leader>gg", ":Git<CR>", {})
            vim.api.nvim_set_keymap("n", "<Leader>go", ":Git<CR>:only<CR>", {})

            -- Set up an autocommand to run this function when entering diff mode
            vim.api.nvim_create_autocmd("OptionSet", {
                pattern = "diff",
                callback = function()
                    if vim.v.option_new == "1" then
                        if vim.wo.diff then
                            local opts = { noremap = true, silent = true }

                            -- "Take ours" for current conflict
                            vim.api.nvim_buf_set_keymap(0, "n", "co", "<cmd>diffget //2<CR>", opts)

                            -- "Take theirs" for current conflict
                            vim.api.nvim_buf_set_keymap(0, "n", "ct", "<cmd>diffget //3<CR>", opts)

                            -- "Apply all ours"
                            vim.api.nvim_buf_set_keymap(
                                0,
                                "n",
                                "<leader>co",
                                "<cmd>%diffget //2 | diffupdate<CR>",
                                opts
                            )

                            -- "Apply all theirs"
                            vim.api.nvim_buf_set_keymap(
                                0,
                                "n",
                                "<leader>ct",
                                "<cmd>%diffget //3 | diffupdate<CR>",
                                opts
                            )
                        end
                    end
                end,
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        main = "gitsigns",
        opts = { on_attach = git_signs_attach },
    },
    {
        "ruifm/gitlinker.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
}
