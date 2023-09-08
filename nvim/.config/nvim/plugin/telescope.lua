require('telescope').setup({
    defaults = {
        file_ignore_patterns = { '%.git/', '%.lock' },
    },
    pickers = {
        find_files = {
            git_files = false,
            hidden = true,
        },
    },
})

local maps = require('jollyjerr.keymaps')

maps.nmap('<C-f>', '<cmd>Telescope find_files<cr>')

maps.nmap('<leader>fp', '<cmd>Telescope live_grep<cr>')
maps.nmap('<leader>fo', '<cmd>Telescope oldfiles<cr>')
maps.nmap('<leader>fm', '<cmd>Telescope marks<cr>')
maps.nmap('<leader>fs', '<cmd>Telescope spell_suggest<cr>')
maps.nmap('<leader>fk', '<cmd>Telescope keymaps<cr>')
maps.nmap('<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
maps.nmap('<leader>fr', '<cmd>Telescope registers<cr>')
maps.nmap('<leader>fd', '<cmd>Telescope diagnostics<cr>')
maps.nmap('<leader>fq', '<cmd>Telescope quickfix<cr>')
