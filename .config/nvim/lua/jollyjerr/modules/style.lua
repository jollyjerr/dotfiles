local M = {}

M.fmt = string.format

---Convert color number to hex string
---@param n number
---@return string
M.hex = function(n)
    if n then
        return M.fmt("#%06x", n)
    end
    return ""
end

---Parse `style` string into nvim_set_hl options
---@param style string
---@return table
M.parse_style = function(style)
    if not style or style == "NONE" then
        return {}
    end

    local result = {}
    for token in string.gmatch(style, "([^,]+)") do
        result[token] = true
    end

    return result
end

---Get highlight opts for a given highlight group name
---@param name string
---@return table
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

---Set highlight group from provided table
---@param groups table
M.set_highlights = function(groups)
    for group, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

return M
