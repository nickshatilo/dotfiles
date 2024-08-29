return {
    "stevearc/conform.nvim",
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        vim.keymap.set("n", "<Leader>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end)
    end,
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = {
                "prettierd",
                "prettier",
                stop_after_first = true,
            },
            typescript = {
                "prettierd",
                "prettier",
                stop_after_first = true,
            },
            json = {
                "prettierd",
                "prettier",
                stop_after_first = true,
            },
            solidity = { "solhint" },
            ["*"] = { "trim_whitespace" },
            ["_"] = { "auto_indent" },
        },
        formatters = {
            solhint = {
                command = "solhint",
                args = { "--fix" },
                format = "raw",
            },
            auto_indent = {
                format = function(_)
                    local view = vim.fn.winsaveview()
                    vim.cmd("silent! normal! gg=G")
                    vim.fn.winrestview(view)

                    return true
                end,
            },
        },
    },
}
