local defaults = require('jollyjerr.lsp')

require('lspconfig').html.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
})
