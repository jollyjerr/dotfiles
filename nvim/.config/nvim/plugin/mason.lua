require('mason').setup()
require('mason-lspconfig').setup({
    automatic_installation = true,
    ensure_installed = {
        'efm',
        'ruby_ls',
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
