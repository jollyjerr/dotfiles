local maps = require('jollyjerr.keymaps')

maps.imap('kj', '<ESC>')

maps.nmap('<leader>v', '<C-w>v')
maps.nmap('<leader>s', '<C-w>s')
maps.nmap('<leader>h', '<C-w>h')
maps.nmap('<leader>l', '<C-w>l')
maps.nmap('<leader>q', '<C-w>q')
maps.nmap('<leader>j', '<C-w>j')
maps.nmap('<leader>k', '<C-w>k')
maps.nmap('<leader>o', '<C-w>o')
maps.nmap('<leader>O', ':%bd|e#|bd#<cr>')
maps.nmap('<leader>P', ':e ')

maps.nmap('<leader>T', '<cmd>tabnew<cr>')
maps.nmap('<leader>tc', '<cmd>tabclose<cr>')
maps.nmap('<leader>tn', '<cmd>tabnext<cr>')
maps.nmap('<leader>tp', '<cmd>tabprevious<cr>')

maps.nmap('<leader>dn', vim.diagnostic.goto_next)
maps.nmap('<leader>dp', vim.diagnostic.goto_prev)

maps.nmap('<leader>Q', ':qa!<cr>')
maps.nmap('<leader>w', ':wa!<cr>')
maps.nmap('<leader>W', ':wqa!<cr>')

maps.nmap('<leader>,', '<cmd>noh<cr>')
maps.nmap('<leader>cp', '<cmd>let @+=@%<cr>')
