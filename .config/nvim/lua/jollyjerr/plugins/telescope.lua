local maps = require "jollyjerr.keymaps"

maps.nmap('<C-p>', '<cmd>Telescope find_files<cr>')
maps.nmap('<leader>fp', '<cmd>Telescope live_grep<cr>')
maps.nmap('<leader>fo', '<cmd>Telescope oldfiles<cr>')
maps.nmap('<leader>fm', '<cmd>Telescope marks<cr>')
maps.nmap('<leader>fs', '<cmd>Telescope spell_suggest<cr>')
maps.nmap('<leader>fk', '<cmd>Telescope keymaps<cr>')
maps.nmap('<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

-- TODO bug with Telescope breaking this?
maps.nmap('<leader>fr', '<cmd>reg<cr>')

maps.nmap('<leader>da', '<cmd>Telescope diagnostics<cr>')
