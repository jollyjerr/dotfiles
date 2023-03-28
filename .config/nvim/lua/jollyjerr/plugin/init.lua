return {
  -- Core plugins everything else uses
  'wbthomason/packer.nvim',
  'nvim-lua/plenary.nvim',
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Navigation and editing
  'nvim-telescope/telescope.nvim',
  'tpope/vim-vinegar',
  'tpope/vim-surround',
  'svermeulen/vim-yoink',
  'windwp/nvim-autopairs',
  'buztard/vim-rel-jump',
  'numToStr/Comment.nvim',

  -- Git
  'tpope/vim-fugitive',
  'sindrets/diffview.nvim',

  -- LSP servers, DAP servers, linters, and formatters
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'jose-elias-alvarez/null-ls.nvim',
  'MunifTanjim/prettier.nvim',

  -- Code Completion
  'L3MON4D3/LuaSnip',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'f3fora/cmp-spell',

  -- a e s t h e t i c
  'EdenEast/nightfox.nvim',
  'lewis6991/gitsigns.nvim',
  'kyazdani42/nvim-web-devicons',
  'feline-nvim/feline.nvim',
  'nanozuki/tabby.nvim',
}
