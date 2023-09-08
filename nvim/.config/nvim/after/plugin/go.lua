local defaults = require('jollyjerr.lsp')

require('lspconfig').gopls.setup({
  on_attach = defaults.on_attach,
  capabilities = defaults.get_capabilities(),
})
