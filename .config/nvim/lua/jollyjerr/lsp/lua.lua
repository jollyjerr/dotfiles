local defaults = require('jollyjerr.lsp.defaults')

require('lspconfig').sumneko_lua.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
})
