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
        'stevearc/aerial.nvim',
        opts = {},
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
            require('aerial').setup({})
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'princejoogie/dir-telescope.nvim' },
        },
        config = function()
            local set = vim.keymap.set
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')

            telescope.load_extension('fzf')
            telescope.load_extension('dir')

            local pickers = require('telescope.pickers')
            local finders = require('telescope.finders')
            local sorters = require('telescope.sorters')
            local previewers = require('telescope.previewers')

            local changes_on_branch = function()
                pickers
                    .new({
                        results_title = 'PR',
                        finder = finders.new_oneshot_job({
                            'git',
                            'diff',
                            '--name-only',
                            '--relative',
                            'main',
                        }, {}),
                        sorter = sorters.get_fuzzy_file(),
                        previewer = previewers.new_termopen_previewer({
                            get_command = function(entry)
                                return {
                                    'git',
                                    'diff',
                                    '--relative',
                                    'main',
                                    entry.value,
                                }
                            end,
                        }),
                    }, {})
                    :find()
            end

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
            set('n', '<leader>pr', changes_on_branch)

            telescope.setup({
                defaults = {
                    file_ignore_patterns = { '%.git/', '%.lock' },
                },
                pickers = {
                    find_files = {
                        git_files = false,
                        hidden = true,
                        theme = 'ivy',
                    },
                    live_grep = { theme = 'ivy' },
                    oldfiles = { theme = 'ivy' },
                    marks = { theme = 'ivy' },
                    spell_suggest = { theme = 'ivy' },
                    keymaps = { theme = 'ivy' },
                    current_buffer_fuzzy_find = { theme = 'ivy' },
                    registers = { theme = 'ivy' },
                    diagnostics = { theme = 'ivy' },
                    quickfix = { theme = 'ivy' },
                },
                extensions = {
                    fzf = {},
                    dir = {},
                    wrap_results = true,
                },
            })
        end,
    },
}
