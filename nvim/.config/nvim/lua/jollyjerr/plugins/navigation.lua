return {
    'tpope/vim-vinegar',
    'buztard/vim-rel-jump',
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
            },
        },
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            local set = vim.keymap.set
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')

            telescope.load_extension('fzf')

            set('n', '<C-f>', builtin.find_files)
            set('n', '<leader>fp', builtin.live_grep)
            set('n', '<leader>fo', builtin.oldfiles)
            set('n', '<leader>fm', builtin.marks)
            set('n', '<leader>fs', builtin.spell_suggest)
            set('n', '<leader>fk', builtin.keymaps)
            set('n', '<leader>fb', builtin.current_buffer_fuzzy_find)
            set('n', '<leader>fr', builtin.registers)
            set('n', '<leader>fd', builtin.diagnostics)
            set('n', '<leader>fq', builtin.quickfix)

            telescope.setup({
                defaults = {
                    file_ignore_patterns = { '%.git/', '%.lock' },
                },
                pickers = {
                    find_files = {
                        git_files = false,
                        hidden = true,
                    },
                },
                extensions = {
                    fzf = {},
                    wrap_results = true,
                },
            })
        end,
    },
}
