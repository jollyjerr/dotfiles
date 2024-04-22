require('mason').setup()
require('mason-lspconfig').setup({
    automatic_installation = true,
    ensure_installed = {
        'efm',
        'ruby_lsp',
        'clangd',
        'elixirls',
        'eslint',
        'gopls',
        'lua_ls',
        'pylsp',
        'rust_analyzer',
        'svelte',
        'tailwindcss',
        'tsserver',
    },
})
