local defaults = require('jollyjerr.modules.lsp')

require('lspconfig').sumneko_lua.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim"
                }
            }
        }
    }
})
