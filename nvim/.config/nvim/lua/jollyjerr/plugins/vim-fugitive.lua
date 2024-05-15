return {
    'tpope/vim-fugitive',
    config = function()
        local set = vim.keymap.set

        set('n', '<leader>gaa', '<cmd>Git add .<cr>')
        set('n', '<leader>gc', '<cmd>Git commit<cr>')
        set('n', '<leader>gpo', '<cmd>Git push origin<cr>')
        set('n', '<leader>gs', '<cmd>Git status<cr>')
        set('n', '<leader>gl', '<cmd>Git log<cr>')
        set('n', '<leader>cd', '<cmd>Git diff<cr>')
        set('n', '<leader>ds', '<cmd>Git diff --staged<cr>')
        set('n', '<leader>gb', '<cmd>Git blame<cr>')
        set('n', '<leader>prb', '<cmd>G difftool main<cr>')
    end,
}
