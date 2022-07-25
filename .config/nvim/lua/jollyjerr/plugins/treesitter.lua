require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua",
        "rust",
        "typescript",
        "javascript",
        "elixir",
        "go",
        "svelte",
        "tsx",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
})
