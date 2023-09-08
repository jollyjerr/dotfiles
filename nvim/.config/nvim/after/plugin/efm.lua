local defaults = require('jollyjerr.lsp')

local prettier = {
    formatCommand = 'prettierd "${INPUT}"',
    formatStdin = true,
}

local stylua = {
    formatCommand = 'stylua',
    formatStdin = true,
    rootMarkers = { 'stylua.toml', '.stylua.toml' },
}

require('lspconfig').efm.setup({
    filetypes = {
        'typescript',
        'typescriptreact',
        'javascript',
        'javascriptreact',
        'svelte',
        'vue',
        'markdown',
        'html',
        'lua',
    },
    init_options = { documentFormatting = true },
    rootMarkers = { '.git/' },
    settings = {
        languages = {
            lua = { stylua },
            typescript = { prettier },
            typescriptreact = { prettier },
            javascript = { prettier },
            javascriptreact = { prettier },
            svelte = { prettier },
            vue = { prettier },
            markdown = { prettier },
            html = { stylua },
        },
    },
    on_attach = defaults.on_attach,
    capabilities = defaults.get_capabilities(),
})
