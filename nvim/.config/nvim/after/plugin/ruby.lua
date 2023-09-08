local defaults = require('jollyjerr.lsp')

require('lspconfig').ruby_ls.setup({
  on_attach = defaults.on_attach,
  capabilities = defaults.get_capabilities(),
})
