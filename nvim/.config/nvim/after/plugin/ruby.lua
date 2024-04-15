local defaults = require('jollyjerr.lsp')

require('lspconfig').ruby_lsp.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
})
