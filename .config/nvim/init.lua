require('init-plugins')

vim.cmd([[
if has('termguicolors')
  set termguicolors
endif

let g:edge_style = 'aura'
let g:edge_better_performance = 1
colorscheme edge
]])

require('maps')
require('options')

require('plugins.coc')
require('plugins.autopairs')
require('plugins.feline')
