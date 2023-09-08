local defaults = require('jollyjerr.lsp')

require('lspconfig').rust_analyzer.setup({
  on_attach = defaults.on_attach,
  capabilities = defaults.get_capabilities(),
})
