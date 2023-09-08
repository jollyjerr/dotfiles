local defaults = require('jollyjerr.lsp')

require('lspconfig').elixirls.setup({
  on_attach = defaults.on_attach,
  capabilities = defaults.get_capabilities(),
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
})
