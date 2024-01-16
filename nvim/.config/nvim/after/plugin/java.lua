local defaults = require('jollyjerr.lsp')

require('lspconfig').java_language_server.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
})
