local defaults = require('jollyjerr.lsp')

require('lspconfig').pylsp.setup({
  on_attach = defaults.on_attach,
  capabilities = defaults.get_capabilities(),
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100,
        },
      },
    },
  },
})
