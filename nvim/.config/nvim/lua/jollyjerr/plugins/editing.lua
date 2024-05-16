return {
    'tpope/vim-surround',
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'f3fora/cmp-spell',
        },
        config = function()
            local cmp = require('cmp')
            local cmp_context = require('cmp.config.context')
            local luasnip = require('luasnip')
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')

            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
            vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-b>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer', keyword_length = 5 },
                    { name = 'luasnip' },
                    {
                        name = 'spell',
                        option = {
                            keep_all_entries = true,
                            enable_in_context = function()
                                return cmp_context.in_treesitter_capture('spell')
                            end,
                        },
                    },
                }, {
                    { name = 'buffer' },
                }),
                experimental = {
                    native_menu = false,
                    ghost_text = { hl_group = 'CmpGhostText' },
                },
            })
        end,
    },
    {
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
    },
}
