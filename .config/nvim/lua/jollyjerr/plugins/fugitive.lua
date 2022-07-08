local maps = require "jollyjerr.keymaps"

maps.nmap('<leader>gaa', '<cmd>Git add .<cr>')
maps.nmap('<leader>gc', '<cmd>Git commit<cr>')
maps.nmap('<leader>gpo', '<cmd>Git push origin<cr>')
maps.nmap('<leader>gs', '<cmd>Git status<cr>')
maps.nmap('<leader>cd', '<cmd>Git diff<cr>')
maps.nmap('<leader>ds', '<cmd>Git diff --staged<cr>')
maps.nmap('<leader>gb', '<cmd>Git blame<cr>')
