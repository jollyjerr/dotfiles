local defaults = require('jollyjerr.modules.lsp')

require('lspconfig').clangd.setup({
  on_attach = defaults.on_attach,
  capabilities = defaults.get_capabilities(),
})
