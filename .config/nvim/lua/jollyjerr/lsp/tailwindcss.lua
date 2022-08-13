local defaults = require('jollyjerr.lsp.defaults')

require('lspconfig').tailwindcss.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
    settings = {
        tailwindCSS = {
            classAttributes = { 'class', 'className', 'classList' }
        }
    }
})
