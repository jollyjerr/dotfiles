local M = {}

local system_prompt = [[
## General Behavior

* Respond as **briefly** as possible, using **few words**.
* Assume the user is **knowledgeable** and **already understands the context**.
* If responding with a **code snippet**, send **only the snippet** with no additional words.
* When considering multiple approaches, provide **only the best one** unless explicitly asked for alternatives.

## Conversation specifics

]]

function M.llm_chat_with_buffer_context()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = table.concat(lines, '\n')

    local system = system_prompt .. 'Consider this context when responding:' .. content .. ''
    local escaped_system = vim.fn.shellescape(system)
    local window_cmd = string.format('llm chat -s %s', escaped_system)
    local escaped_window = vim.fn.shellescape(window_cmd)
    local tmux_cmd = string.format('tmux split-window -p 40 -h %s', escaped_window)

    vim.fn.system(tmux_cmd)
end

function M.llm_chat_with_yank_context()
    local yank_content = vim.fn.getreg('"')

    local system = system_prompt .. 'Consider this context when responding:' .. yank_content .. ''
    local escaped_system = vim.fn.shellescape(system)
    local window_cmd = string.format('llm chat -s %s', escaped_system)
    local escaped_window = vim.fn.shellescape(window_cmd)
    local tmux_cmd = string.format('tmux split-window -p 40 -h %s', escaped_window)

    vim.fn.system(tmux_cmd)
end

local set = vim.keymap.set

set('n', '<leader>mlb', M.llm_chat_with_buffer_context, { noremap = true, silent = true })
set('n', '<leader>mly', M.llm_chat_with_yank_context, { noremap = true, silent = true })

return M
