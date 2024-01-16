local defaults = require('jollyjerr.lsp')

require('lspconfig').kotlin_language_server.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
})
