vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_next, opts)

require('jollyjerr.lsp.go')
require('jollyjerr.lsp.typescript')
require('jollyjerr.lsp.lua')
