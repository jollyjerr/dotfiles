local M = {}

M.map = function(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

M.nmap = function(shortcut, command)
    M.map('n', shortcut, command)
end

M.imap = function(shortcut, command)
    M.map('i', shortcut, command)
end

return M
