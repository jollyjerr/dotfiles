local defaults = require('jollyjerr.lsp')

require("neodev").setup({})

require('lspconfig').lua_ls.setup({
  on_attach = defaults.on_attach,
  capabilities = defaults.get_capabilities(),
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim',
        },
      },
    },
  },
})
