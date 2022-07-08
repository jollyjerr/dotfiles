local maps = require "jollyjerr.keymaps"

maps.nmap('<C-p>', '<cmd>Telescope find_files<cr>')
maps.nmap('<leader>fp', '<cmd>Telescope live_grep<cr>')
maps.nmap('<leader>of', '<cmd>Telescope oldfiles<cr>')
