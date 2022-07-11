local download_packer = function()
    if vim.fn.input "Download Packer? (y for yes)" ~= "y" then
        return
    end

    local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")
    vim.fn.mkdir(directory, "p")

    local out = vim.fn.system(
        string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
    )

    print(out)
    print "Downloading packer.nvim..."
    print "( You'll need to restart now )"
    vim.cmd [[qa]]
end

return function()
    if not pcall(require, "packer") then
        download_packer()
        return true
    end

    local packer = require('packer')

    packer.startup(function(use)
        use "wbthomason/packer.nvim"
        use 'nvim-lua/plenary.nvim'

        use 'sainnhe/edge'
        use 'lewis6991/gitsigns.nvim'
        use 'kyazdani42/nvim-web-devicons'
        use 'feline-nvim/feline.nvim'

        use 'nvim-telescope/telescope.nvim'
        use 'tpope/vim-fugitive'
        use 'tpope/vim-vinegar'
        use 'tpope/vim-surround'

        use "windwp/nvim-autopairs"
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate'
        }
        use 'neovim/nvim-lspconfig'

        use('jose-elias-alvarez/null-ls.nvim')
        use('MunifTanjim/prettier.nvim')

        use 'L3MON4D3/LuaSnip'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'

        -- TODO remove this when tree sitter elixir works
        use 'elixir-editors/vim-elixir'
    end)

    return false
end
