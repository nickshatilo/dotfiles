local config_directory = vim.fn.fnamemodify(vim.env.MYVIMRC, ":h")
_G.is_maintenance = false
_G.last_directory = nil
_G.last_file = nil
_G.last_line = nil

local toggle_maintenance = function()
    if _G.is_maintenance then
        if _G.last_directory and _G.last_file then
            vim.fn.chdir(_G.last_directory)

            vim.cmd("silent NvimTreeClose")
            vim.cmd("silent enew")
            vim.cmd("silent BufferLineCloseOthers")
            vim.cmd("silent only")

            -- Open the last file and go to the last line
            vim.cmd("edit " .. _G.last_file)
            vim.api.nvim_win_set_cursor(0, {_G.last_line, 0})

            _G.is_maintenance = false
            _G.last_directory = nil
            _G.last_file = nil
            _G.last_line = nil
        else
            vim.notify("No last directory or file saved")
        end
    else
        _G.last_directory = vim.fn.getcwd()
        _G.last_file = vim.fn.expand("%:p")
        _G.last_line = vim.fn.line(".")
        vim.fn.chdir(config_directory)
        vim.cmd("silent NvimTreeFocus")
        vim.cmd("only")

        _G.is_maintenance = true
    end
end

-- Edit VIM config
vim.keymap.set("n", "m<Leader><Leader>", toggle_maintenance, { silent = true, noremap = true })
