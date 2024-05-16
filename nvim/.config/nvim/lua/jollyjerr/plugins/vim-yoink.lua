return {
    'svermeulen/vim-yoink',
    config = function()
        local set = vim.keymap.set

        set('n', '<leader>Y', '<cmd>Yanks<cr>')

        vim.cmd([[
            nmap <c-n> <plug>(YoinkPostPasteSwapBack)
            nmap <c-p> <plug>(YoinkPostPasteSwapForward)

            nmap p <plug>(YoinkPaste_p)
            nmap P <plug>(YoinkPaste_P)
            nmap gp <plug>(YoinkPaste_gp)
            nmap gP <plug>(YoinkPaste_gP)

            nmap [y <plug>(YoinkRotateBack)
            nmap ]y <plug>(YoinkRotateForward)

            nmap y <plug>(YoinkYankPreserveCursorPosition)
            xmap y <plug>(YoinkYankPreserveCursorPosition)
        ]])
    end,
}
