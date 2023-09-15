local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local defaults = require('jollyjerr.lsp')

local lexical_config = {
    filetypes = { "elixir", "eelixir", },
    cmd = { "/Users/jeremiah.tabb/code/source/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
    settings = {},
}

if not configs.lexical then
    configs.lexical = {
        default_config = {
            filetypes = lexical_config.filetypes,
            cmd = lexical_config.cmd,
            root_dir = function(fname)
                return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
            end,
            settings = lexical_config.settings,
        },
    }
end

lspconfig.lexical.setup({
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
})

-- trying out lexical for now
-- elixirls is timing out on long projects
-- lspconfig.elixirls.setup({
--     on_attach = defaults.on_attach,
--     capabilities = defaults.get_capabilities(),
--     settings = {
--         elixirLS = {
--             dialyzerEnabled = false,
--             fetchDeps = false,
--         },
--     },
-- })
