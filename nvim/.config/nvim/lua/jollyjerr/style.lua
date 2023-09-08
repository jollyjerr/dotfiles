local M = {}

M.fmt = string.format

M.hex = function(n)
    if n then
        return M.fmt('#%06x', n)
    end
    return ''
end

M.parse_style = function(style)
    if not style or style == 'NONE' then
        return {}
    end

    local result = {}
    for token in string.gmatch(style, '([^,]+)') do
        result[token] = true
    end

    return result
end

M.get_highlight = function(name)
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    if hl.link then
        return M.get_highlight(hl.link)
    end

    local result = M.parse_style(hl.style)
    result.fg = hl.foreground and M.hex(hl.foreground)
    result.bg = hl.background and M.hex(hl.background)
    result.sp = hl.special and M.hex(hl.special)

    return result
end

M.set_highlights = function(groups)
    for group, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

return M
