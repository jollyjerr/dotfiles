return {
    {
        'EdenEast/nightfox.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('duskfox')
        end,
    },
    {
        'nanozuki/tabby.nvim',
        event = 'VimEnter',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            if vim.g.vscode then
                return
            end

            local theme = {
                fill = 'TabLineFill',
                head = 'TabLine',
                current_tab = 'TabLineSel',
                tab = 'TabLine',
                win = 'TabLine',
                tail = 'TabLine',
            }
            require('tabby.tabline').set(function(line)
                return {
                    {
                        { '  ', hl = theme.head },
                        line.sep('', theme.head, theme.fill),
                    },
                    line.tabs().foreach(function(tab)
                        local hl = tab.is_current() and theme.current_tab or theme.tab
                        return {
                            line.sep('', hl, theme.fill),
                            tab.is_current() and '' or '󰆣',
                            tab.number(),
                            tab.name(),
                            line.sep('', hl, theme.fill),
                            hl = hl,
                            margin = ' ',
                        }
                    end),
                    line.spacer(),
                    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                        return {
                            line.sep('', theme.win, theme.fill),
                            win.is_current() and '' or '',
                            win.buf_name(),
                            line.sep('', theme.win, theme.fill),
                            hl = theme.win,
                            margin = ' ',
                        }
                    end),
                    {
                        line.sep('', theme.tail, theme.fill),
                        { '  ', hl = theme.tail },
                    },
                    hl = theme.fill,
                }
            end)
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        'folke/zen-mode.nvim',
        opts = {
            window = {
                options = {
                    number = false,
                    relativenumber = false, -- disable relative numbers
                    cursorline = false, -- disable cursorline
                    cursorcolumn = false, -- disable cursor column
                },
            },
            plugins = {
                kitty = {
                    enabled = true,
                    font = '+8',
                },
            },
            on_open = function()
                vim.opt.colorcolumn = '0'
                vim.opt.signcolumn = 'no'
                vim.opt.laststatus = 0

                vim.keymap.set('n', '<Right>', '<cmd>bnext<cr>')
                vim.keymap.set('n', '<Left>', '<cmd>bprevious<cr>')

                require('ibl').update({ enabled = false })
            end,
            on_close = function()
                vim.opt.colorcolumn = '100'
                vim.opt.signcolumn = 'yes'
                vim.opt.laststatus = 2

                vim.keymap.del('n', '<Right>')
                vim.keymap.del('n', '<Left>')

                require('ibl').update({ enabled = true })
            end,
        },
    },
    { -- View marks in gutter
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        opts = {},
        config = function()
            require('marks').setup()
        end,
    },
    -- {
    --     'sphamba/smear-cursor.nvim',
    --     config = true,
    -- },
}
