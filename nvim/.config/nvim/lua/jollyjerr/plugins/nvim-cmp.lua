return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'f3fora/cmp-spell',
        'L3MON4D3/LuaSnip',
    },
    config = function()
        local cmp = require('cmp')
        local cmp_types = require('cmp.types')
        local cmp_context = require('cmp.config.context')
        local luasnip = require('luasnip')

        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

        return {
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
                ghost_text = { cmp_types.cmp.TriggerEvent.TextChanged },
            },
        }
    end,
}
