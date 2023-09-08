vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')
local cmp_types = require('cmp.types')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
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
                    return require('cmp.config.context').in_treesitter_capture('spell')
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
})
