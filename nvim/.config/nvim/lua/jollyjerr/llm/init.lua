vim.api.nvim_set_keymap('n', '<space>ll', ':lua SendBufferToLlm()<CR>', { noremap = true, silent = true })

function _G.SendBufferToLlm()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = table.concat(lines, '\n')

    local system = "Consider this context when responding:" .. content .. ""
    local escaped_system = vim.fn.shellescape(system)
    local window_cmd = string.format("llm chat -s %s", escaped_system)
    local escaped_window = vim.fn.shellescape(window_cmd)
    local tmux_cmd = string.format("tmux split-window -p 40 -h %s", escaped_window)

    vim.fn.system(tmux_cmd)
end
