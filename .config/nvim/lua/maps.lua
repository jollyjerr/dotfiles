vim.g.mapleader = ' '
vim.keymap.set('i', 'kj', '<ESC>')

vim.cmd('nnoremap <leader>gaa :Git add .')
vim.cmd('nnoremap <leader>gc :Git commit')
vim.cmd('nnoremap <leader>gcm :Git commit -m "')
vim.cmd('nnoremap <leader>gpo :Git push origin')
vim.cmd('nnoremap <leader>gs :Git status')
vim.cmd('nnoremap <leader>gst :Git stash')
vim.cmd('nnoremap <leader>gsp :Git stash pop')
vim.cmd('nnoremap <leader>gsl :Git stash list')
vim.cmd('nnoremap <leader>gmain :! git checkout main && git pull origin main && git remote update && git fetch')
vim.cmd('nnoremap <leader>gback :Git checkout -')
vim.cmd('nnoremap <leader>d :Git diff')
vim.cmd('nnoremap <leader>ds :Git diff --staged')
vim.cmd('nnoremap <leader>gb :Git blame')

 vim.cmd([[
nnoremap <leader>% :%s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>q <C-w>q
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>o :b#<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>w :wa!<CR>
 ]])

vim.cmd('nnoremap <C-p> <cmd>Telescope find_files<cr>')
vim.cmd('nnoremap <leader>fp <cmd>Telescope live_grep<cr>')
vim.cmd('nnoremap <leader>of <cmd>Telescope oldfiles<cr>')

vim.cmd('nnoremap <leader>rnf <cmd>CocCommand workspace.renameCurrentFile<cr>')
vim.cmd('nnoremap <leader>i <cmd>CocDiagnostics<cr>')
