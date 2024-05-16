return {
    {
        'EdenEast/nightfox.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme duskfox')
        end,
    },
    'nvim-lua/plenary.nvim',
    'tpope/vim-vinegar',
    'tpope/vim-surround',
    'buztard/vim-rel-jump',
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },
    'lewis6991/gitsigns.nvim',
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
}
