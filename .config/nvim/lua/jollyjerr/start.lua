local download_packer = function()
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
        -- Core plugins everything else uses
        use 'wbthomason/packer.nvim'
        use 'nvim-lua/plenary.nvim'
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate'
        }

        -- Navigation and editing
        use 'nvim-telescope/telescope.nvim'
        use 'tpope/vim-vinegar'
        use 'tpope/vim-surround'
        use 'svermeulen/vim-yoink'
        use 'windwp/nvim-autopairs'
        use 'buztard/vim-rel-jump'
        use 'numToStr/Comment.nvim'

        -- Git
        use 'tpope/vim-fugitive'
        use 'sindrets/diffview.nvim'

        -- LSP servers, DAP servers, linters, and formatters
        use 'neovim/nvim-lspconfig'
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'
        use 'jose-elias-alvarez/null-ls.nvim'
        use 'MunifTanjim/prettier.nvim'

        -- Code Completion
        use 'L3MON4D3/LuaSnip'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'

        -- a e s t h e t i c
        use 'EdenEast/nightfox.nvim'
        use 'lewis6991/gitsigns.nvim'
        use 'kyazdani42/nvim-web-devicons'
        use 'feline-nvim/feline.nvim'
        use 'nanozuki/tabby.nvim'
    end)

    return false
end
