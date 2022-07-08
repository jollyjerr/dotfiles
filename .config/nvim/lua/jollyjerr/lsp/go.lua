local defaults = require('jollyjerr.lsp.defaults')

require('lspconfig').gopls.setup{
    on_attach = defaults.on_attach,
    capabilities = defaults.capabilities,
}
