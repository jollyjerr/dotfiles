vim.opt.guicursor = ''

vim.opt.scrolloff = 10
vim.opt.relativenumber = true
vim.opt.nu = true
vim.wo.wrap = false
vim.opt.signcolumn = 'yes'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.w.nohlsearch = true
vim.opt.incsearch = true
vim.opt.hidden = true

vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.laststatus = 3
vim.opt.emoji = false
vim.opt.colorcolumn = '100'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.updatetime = 80

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.spelllang = { 'en_us' }
vim.o.showtabline = 2

vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    virtual_text = false,
    virtual_lines = false,
    float = {
        severity_sort = true,
        max_width = 120,
        source = 'always'
    },
})
