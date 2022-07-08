local M = {}

M.map = function(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

M.nmap = function(shortcut, command)
  M.map('n', shortcut, command)
end

M.imap = function(shortcut, command)
  M.map('i', shortcut, command)
end

vim.g.mapleader = ' '

M.imap('kj', '<ESC>')

M.nmap('<leader>v', '<C-w>v', {buffer=0})
M.nmap('<leader>s', '<C-w>s')
M.nmap('<leader>h', '<C-w>h')
M.nmap('<leader>l', '<C-w>l')
M.nmap('<leader>q', '<C-w>q')
M.nmap('<leader>j', '<C-w>j')
M.nmap('<leader>k', '<C-w>k')
M.nmap('<leader>o', '<C-w>o')

M.nmap('<leader>Q', ':qa!<cr>')
M.nmap('<leader>w', ':wa!<cr>')
M.nmap('<leader>W', ':wqa!<cr>')

return M
