local set = vim.keymap.set

set('i', 'kj', '<ESC>')

set('n', '<leader>v', '<C-w>v')
set('n', '<leader>s', '<C-w>s')
set('n', '<leader>h', '<C-w>h')
set('n', '<leader>l', '<C-w>l')
set('n', '<leader>q', '<C-w>q')
set('n', '<leader>j', '<C-w>j')
set('n', '<leader>k', '<C-w>k')
set('n', '<leader>o', '<C-w>o')
set('n', '<leader>O', ':%bd|e#|bd#<cr>')
set('n', '<leader>P', ':e ')

set('n', '<leader>T', '<cmd>tabnew<cr>')
set('n', '<leader>tc', '<cmd>tabclose<cr>')
set('n', '<leader>tn', '<cmd>tabnext<cr>')
set('n', '<leader>tp', '<cmd>tabprevious<cr>')

set('n', '<leader>dn', vim.diagnostic.goto_next)
set('n', '<leader>dp', vim.diagnostic.goto_prev)

set('n', '<leader>Q', ':qa!<cr>')
set('n', '<leader>w', ':wa!<cr>')
set('n', '<leader>W', ':wqa!<cr>')

set('n', '<leader>,', '<cmd>noh<cr>')
set('n', '<leader>cp', '<cmd>let @+=@%<cr>')
