local defaults = require('jollyjerr.lsp.defaults')

local elixerls_path = os.getenv("HOME") .. "/.lsp_servers/elixir/language_server.sh"

require('lspconfig').elixirls.setup({
    cmd = { elixerls_path };
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
    settings = {
        elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false
        }
    }
})
