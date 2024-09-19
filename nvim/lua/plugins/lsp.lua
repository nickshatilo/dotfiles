local function on_lsp_attach(_, bufnr)
    local silent_noremap_opts = { noremap = true, silent = true }

    -- Jumps
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", silent_noremap_opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent_noremap_opts)

    -- References - Implementation searches
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", silent_noremap_opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gR",
        "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
        silent_noremap_opts
    )

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", silent_noremap_opts)

    -- Code action
    vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent_noremap_opts)

    -- Workspace folders
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<space>wa",
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
        silent_noremap_opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<space>wr",
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        silent_noremap_opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<space>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        silent_noremap_opts
    )

    -- Hover magic
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", silent_noremap_opts)

    -- Rename
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", silent_noremap_opts)

    -- Diagnostics
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", silent_noremap_opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", silent_noremap_opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", silent_noremap_opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", silent_noremap_opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>',
    --     silent_noremap_opts)
end

local function init(_, _)
    local lsp = require("lsp-zero").preset({})

    lsp.on_attach(on_lsp_attach)

    -- Enables neovim config to properly use lua auto-completion
    require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()

    lsp.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "",
    })

    vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = {
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })
end

function init_cmp(_, _)
    local cmp = require("cmp")
    local cmp_action = require("lsp-zero.cmp").action()

    require("luasnip.loaders.from_vscode").lazy_load()

    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
            return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    cmp.setup({
        preselect = "item",
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        window = {
            documention = cmp.config.window.bordered(),
        },
        sources = {

            { name = "path", group_index = 2 },
            { name = "buffer", group_index = 2, keyword_length = 3 },

            { name = "nvim_lsp", group_index = 2 },
            { name = "nvim_lua", group_index = 2 },

            { name = "copilot", group_index = 2 },

            { name = "luasnip", group_index = 2, keyword_length = 2 },
        },
        mapping = {
            -- confirm completion item
            ["<CR>"] = cmp.mapping.confirm({ select = false }),

            -- toggle completion menu
            ["<C-a>"] = cmp_action.toggle_completion(),

            -- tab complete
            ["<Tab>"] = vim.schedule_wrap(function(fallback)
                if cmp.visible() and has_words_before() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),

            -- navigate between snippet placeholder
            ["<C-d>"] = cmp_action.luasnip_jump_forward(),
            ["<C-b>"] = cmp_action.luasnip_jump_backward(),

            -- scroll documention window
            ["<C-f>"] = cmp.mapping.scroll_docs(5),
            ["<C-u>"] = cmp.mapping.scroll_docs(-5),
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                require("copilot_cmp.comparators").prioritize,

                -- Below is the default comparitor list and order for nvim-cmp
                cmp.config.compare.offset,
                -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
    })
end

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        -- main = "lsp-zero",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
        config = init,
    },
    -- Auto provisioning
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
        },
        main = "mason-lspconfig",
        opts = {
            ensure_installed = { "ts_ls", "lua_ls", "solidity_ls" },
        },
        priority = 49,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp", -- Required
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional
            { "zbirenbaum/copilot-cmp" },
        },
        config = init_cmp,
    },
    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        main = "copilot",
        enabled = true,
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                sh = function()
                    if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env") then
                        return false
                    end
                    return true
                end,
            },
        },
        config = function(_, opts)
            require("copilot_cmp").setup()
            require("copilot").setup(opts)
        end,
    },
}
