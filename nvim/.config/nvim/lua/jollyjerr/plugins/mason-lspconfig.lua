return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim',
        'folke/neodev.nvim',
        'neovim/nvim-lspconfig',
    },
    config = function()
        local mason = require('mason')

        mason.setup()

        return {
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
        }
    end,
}
