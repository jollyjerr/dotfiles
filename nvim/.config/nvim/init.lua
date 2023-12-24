-- lazy.nvim requires mapleader to be set before installing
vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- core plugins
    {
        'EdenEast/nightfox.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme duskfox')
        end,
    },
    'nvim-lua/plenary.nvim',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- navigation and editing
    'nvim-telescope/telescope.nvim',
    'tpope/vim-vinegar',
    'tpope/vim-surround',
    'svermeulen/vim-yoink',
    'windwp/nvim-autopairs',
    'buztard/vim-rel-jump',
    'numToStr/Comment.nvim',
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
            },
        },
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
        },
    },

    -- git
    'tpope/vim-fugitive',

    -- LSP servers, DAP servers, linters, and formatters
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'folke/neodev.nvim',

    -- code completion
    'L3MON4D3/LuaSnip',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'f3fora/cmp-spell',

    -- a e s t h e t i c
    'lewis6991/gitsigns.nvim',
    'kyazdani42/nvim-web-devicons',
    'feline-nvim/feline.nvim',
    'nanozuki/tabby.nvim',
    'lukas-reineke/indent-blankline.nvim',

    -- ai dev tools
    {
        'jackMort/ChatGPT.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
    },
})
