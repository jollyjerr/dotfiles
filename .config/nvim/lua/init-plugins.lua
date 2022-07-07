local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'sainnhe/edge'
  use 'kyazdani42/nvim-web-devicons'
  use 'feline-nvim/feline.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 
        {'nvim-lua/plenary.nvim'}
    }
  }
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
  }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-vinegar'

  use {'neoclide/coc.nvim', branch = 'release'}
  use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use 'elixir-editors/vim-elixir'

  -- Leave this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

