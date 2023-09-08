local defaults = require('jollyjerr.lsp')

require('lspconfig').eslint.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
})
