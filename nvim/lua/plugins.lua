local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end

    return false
end

local init_packer = function (callback)
    local is_packer_bootstrap = ensure_packer()

    local packer = require('packer')

    packer.startup(function(use)
        use {'wbthomason/packer.nvim'}

        callback(use)

        if is_packer_bootstrap then
            packer.sync()
        end
    end)
end

return {
    init_packer = init_packer
}
