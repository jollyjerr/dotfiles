local defaults = require('jollyjerr.lsp')

require('lspconfig').jdtls.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
})
