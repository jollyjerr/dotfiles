local Maps = {}

Maps.map = function(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

Maps.nmap = function(shortcut, command)
  Maps.map('n', shortcut, command)
end

Maps.imap = function(shortcut, command)
  Maps.map('i', shortcut, command)
end

vim.g.mapleader = ' '

Maps.imap('kj', '<ESC>')

Maps.nmap('<leader>v', '<C-w>v')
Maps.nmap('<leader>s', '<C-w>s')
Maps.nmap('<leader>h', '<C-w>h')
Maps.nmap('<leader>l', '<C-w>l')
Maps.nmap('<leader>q', '<C-w>q')
Maps.nmap('<leader>j', '<C-w>j')
Maps.nmap('<leader>k', '<C-w>k')

Maps.nmap('<leader>Q', ':qa!<cr>')
Maps.nmap('<leader>w', ':wa!<cr>')
Maps.nmap('<leader>W', ':wqa!<cr>')

return Maps
