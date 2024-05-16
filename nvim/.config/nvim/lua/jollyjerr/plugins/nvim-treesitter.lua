return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            modules = {},
            ignore_installed = {},
            ensure_installed = {
                'lua',
                'rust',
                'typescript',
                'javascript',
                'elixir',
                'go',
                'svelte',
                'tsx',
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                disable = { 'diff' },
            },
        })
    end,
}
