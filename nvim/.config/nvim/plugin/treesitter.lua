require('nvim-treesitter.configs').setup({
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
    -- so close, but not good enough yet
    -- indent = {
    --   enable = true,
    -- },
})
