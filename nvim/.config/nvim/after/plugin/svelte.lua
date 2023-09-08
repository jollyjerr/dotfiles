local defaults = require('jollyjerr.lsp')

require('lspconfig').svelte.setup({
  on_attach = defaults.on_attach,
  capabilities = defaults.get_capabilities(),
})
