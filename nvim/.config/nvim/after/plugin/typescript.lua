local defaults = require('jollyjerr.lsp')
local lspconfig = require('lspconfig')
local set = vim.keymap.set

lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false

        local options = defaults.get_buffer_options(bufnr)
        defaults.add_read_only_maps(options)
    end,
    capabilities = defaults.get_capabilities(),
})

lspconfig.eslint.setup({
    on_attach = function()
        set('n', '<leader>EE', ':EslintFixAll<cr>')
    end,
    capabilities = defaults.get_capabilities(),
})
