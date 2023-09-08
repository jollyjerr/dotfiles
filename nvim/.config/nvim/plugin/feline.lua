local style = require('jollyjerr.style')

local function generate_pallet_from_colorscheme()
    local color_map = {
        black = { index = 0, default = '#393b44' },
        red = { index = 1, default = '#c94f6d' },
        green = { index = 2, default = '#81b29a' },
        yellow = { index = 3, default = '#dbc074' },
        blue = { index = 4, default = '#719cd6' },
        magenta = { index = 5, default = '#9d79d6' },
        cyan = { index = 6, default = '#63cdcf' },
        white = { index = 7, default = '#dfdfe0' },
    }

    local diagnostic_map = {
        hint = { hl = 'DiagnosticHint', default = color_map.green.default },
        info = { hl = 'DiagnosticInfo', default = color_map.blue.default },
        warn = { hl = 'DiagnosticWarn', default = color_map.yellow.default },
        error = { hl = 'DiagnosticError', default = color_map.red.default },
    }

    local pallet = {}
    for name, value in pairs(color_map) do
        local global_name = 'terminal_color_' .. value.index
        pallet[name] = vim.g[global_name] and vim.g[global_name] or value.default
    end

    for name, value in pairs(diagnostic_map) do
        pallet[name] = style.get_highlight(value.hl).fg or value.default
    end

    pallet.sl = style.get_highlight('StatusLine')
    pallet.sel = style.get_highlight('TabLineSel')

    return pallet
end

local function generate_user_statusline_highlights()
    local pal = generate_pallet_from_colorscheme()

    local sl_colors = {
        Black = { fg = pal.black, bg = pal.white },
        Red = { fg = pal.red, bg = pal.sl.bg },
        Green = { fg = pal.green, bg = pal.sl.bg },
        Yellow = { fg = pal.yellow, bg = pal.sl.bg },
        Blue = { fg = pal.blue, bg = pal.sl.bg },
        Magenta = { fg = pal.magenta, bg = pal.sl.bg },
        Cyan = { fg = pal.cyan, bg = pal.sl.bg },
        White = { fg = pal.white, bg = pal.black },
    }

    local colors = {}
    for name, value in pairs(sl_colors) do
        colors['User' .. name] = { fg = value.fg, bg = value.bg, bold = true }
        colors['UserRv' .. name] = { fg = value.bg, bg = value.fg, bold = true }
    end

    local status = vim.o.background == 'dark' and { fg = pal.black, bg = pal.white }
        or { fg = pal.white, bg = pal.black }

    local groups = {
        UserSLHint = { fg = pal.sl.bg, bg = pal.hint, bold = true },
        UserSLInfo = { fg = pal.sl.bg, bg = pal.info, bold = true },
        UserSLWarn = { fg = pal.sl.bg, bg = pal.warn, bold = true },
        UserSLError = { fg = pal.sl.bg, bg = pal.error, bold = true },
        UserSLStatus = { fg = status.fg, bg = status.bg, bold = true },

        UserSLFtHint = { fg = pal.sel.bg, bg = pal.hint },
        UserSLHintInfo = { fg = pal.hint, bg = pal.info },
        UserSLInfoWarn = { fg = pal.info, bg = pal.warn },
        UserSLWarnError = { fg = pal.warn, bg = pal.error },
        UserSLErrorStatus = { fg = pal.error, bg = status.bg },
        UserSLStatusBg = { fg = status.bg, bg = pal.sl.bg },

        UserSLAlt = pal.sel,
        UserSLAltSep = { fg = pal.sl.bg, bg = pal.sel.bg },
        UserSLGitBranch = { fg = pal.yellow, bg = pal.sl.bg },
    }

    style.set_highlights(vim.tbl_extend('force', colors, groups))
end

generate_user_statusline_highlights()
vim.api.nvim_create_augroup('UserStatuslineHighlightGroups', { clear = true })
vim.api.nvim_create_autocmd({ 'SessionLoadPost', 'ColorScheme' }, {
    callback = function()
        generate_user_statusline_highlights()
    end,
})

local vi = {
    -- Map vi mode to text name
    text = {
        n = 'NORMAL',
        no = 'NORMAL',
        i = 'INSERT',
        v = 'VISUAL',
        V = 'V-LINE',
        [''] = 'V-BLOCK',
        c = 'COMMAND',
        cv = 'COMMAND',
        ce = 'COMMAND',
        R = 'REPLACE',
        Rv = 'REPLACE',
        s = 'SELECT',
        S = 'SELECT',
        [''] = 'SELECT',
        t = 'TERMINAL',
    },

    -- Maps vi mode to highlight group color defined above
    colors = {
        n = 'UserRvCyan',
        no = 'UserRvCyan',
        i = 'UserSLStatus',
        v = 'UserRvMagenta',
        V = 'UserRvMagenta',
        [''] = 'UserRvMagenta',
        R = 'UserRvRed',
        Rv = 'UserRvRed',
        r = 'UserRvBlue',
        rm = 'UserRvBlue',
        s = 'UserRvMagenta',
        S = 'UserRvMagenta',
        [''] = 'FelnMagenta',
        c = 'UserRvYellow',
        ['!'] = 'UserRvBlue',
        t = 'UserRvBlue',
    },

    -- Maps vi mode to seperator highlight goup defined above
    sep = {
        n = 'UserCyan',
        no = 'UserCyan',
        i = 'UserSLStatusBg',
        v = 'UserMagenta',
        V = 'UserMagenta',
        [''] = 'UserMagenta',
        R = 'UserRed',
        Rv = 'UserRed',
        r = 'UserBlue',
        rm = 'UserBlue',
        s = 'UserMagenta',
        S = 'UserMagenta',
        [''] = 'FelnMagenta',
        c = 'UserYellow',
        ['!'] = 'UserBlue',
        t = 'UserBlue',
    },
}

local icons = {
    locker = '', -- #f023
    page = '☰', -- 2630
    line_number = '', -- e0a1
    connected = '', -- f817
    mathematical_L = '𝑳',
    vertical_bar = '┃',
    vertical_bar_thin = '│',
    left = '',
    right = '',
    block = '█',
    left_filled = '',
    right_filled = '',
    slant_left = '',
    slant_left_thin = '',
    slant_right = '',
    slant_right_thin = '',
    slant_left_2 = '',
    slant_left_2_thin = '',
    slant_right_2 = '',
    slant_right_2_thin = '',
    left_rounded = '',
    left_rounded_thin = '',
    right_rounded = '',
    right_rounded_thin = '',
    circle = '●',
}

---Get the number of diagnostic messages for the provided severity
---@param str string [ERROR | WARN | INFO | HINT]
---@return string
local function get_diag(str)
    local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity[str] })
    local count = #diagnostics

    return (count > 0) and ' ' .. count .. ' ' or ''
end

---Get highlight group from vi mode
---@return string
local function vi_mode_hl()
    return vi.colors[vim.fn.mode()] or 'UserSLViBlack'
end

---Get sep highlight group from vi mode
local function vi_sep_hl()
    return vi.sep[vim.fn.mode()] or 'UserSLBlack'
end

---Get the path of the file relative to the cwd
---@return string
local function file_info()
    local list = {}
    if vim.bo.readonly then
        table.insert(list, '🔒')
    end

    if vim.bo.modified then
        table.insert(list, '●')
    end

    table.insert(list, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.'))

    return table.concat(list, ' ')
end

-- Create a table that contians every status line commonent
local c = {
    vimode = {
        provider = function()
            return style.fmt(' %s ', vi.text[vim.fn.mode()])
        end,
        hl = vi_mode_hl,
        right_sep = { str = ' ', hl = vi_sep_hl },
    },
    gitbranch = {
        provider = 'git_branch',
        icon = ' ',
        hl = 'UserSLGitBranch',
        right_sep = { str = '  ', hl = 'UserSLGitBranch' },
        enabled = function()
            return vim.b.gitsigns_status_dict ~= nil
        end,
    },
    file_type = {
        provider = function()
            return style.fmt(' %s ', vim.bo.filetype:upper())
        end,
        hl = 'UserSLAlt',
    },
    fileinfo = {
        provider = { name = 'file_info', opts = { type = 'relative' } },
        hl = 'UserSLAlt',
        left_sep = { str = ' ', hl = 'UserSLAltSep' },
        right_sep = { str = ' ', hl = 'UserSLAltSep' },
    },
    cur_position = {
        provider = function()
            return style.fmt(' %3d:%-2d ', unpack(vim.api.nvim_win_get_cursor(0)))
        end,
        hl = vi_mode_hl,
        left_sep = { str = icons.block, hl = vi_sep_hl },
    },
    cur_percent = {
        provider = function()
            return ' ' .. require('feline.providers.cursor').line_percentage() .. '  '
        end,
        hl = vi_mode_hl,
        left_sep = { str = icons.left, hl = vi_mode_hl },
    },
    default = { -- needed to pass the parent StatusLine hl group to right hand side
        provider = '',
        hl = 'StatusLine',
    },
    lsp_status = {
        provider = function()
            return vim.tbl_count(vim.lsp.buf_get_clients(0)) == 0 and '' or ' ◦ '
        end,
        hl = 'UserSLStatus',
        left_sep = { str = '', hl = 'UserSLStatusBg', always_visible = true },
        right_sep = { str = '', hl = 'UserSLErrorStatus', always_visible = true },
    },
    lsp_error = {
        provider = function()
            return get_diag('ERROR')
        end,
        hl = 'UserSLError',
        right_sep = { str = '', hl = 'UserSLWarnError', always_visible = true },
    },
    lsp_warn = {
        provider = function()
            return get_diag('WARN')
        end,
        hl = 'UserSLWarn',
        right_sep = { str = '', hl = 'UserSLInfoWarn', always_visible = true },
    },
    lsp_info = {
        provider = function()
            return get_diag('INFO')
        end,
        hl = 'UserSLInfo',
        right_sep = { str = '', hl = 'UserSLHintInfo', always_visible = true },
    },
    lsp_hint = {
        provider = function()
            return get_diag('HINT')
        end,
        hl = 'UserSLHint',
        right_sep = { str = '', hl = 'UserSLFtHint', always_visible = true },
    },

    in_fileinfo = {
        provider = 'file_info',
        hl = 'StatusLine',
    },
    in_position = {
        provider = 'position',
        hl = 'StatusLine',
    },
    file_winbar = {
        provider = file_info,
        hl = 'Comment',
    },
}

local active = {
    { -- left
        c.vimode,
        c.gitbranch,
        c.fileinfo,
        c.default, -- must be last
    },
    { -- right
        c.lsp_status,
        c.lsp_error,
        c.lsp_warn,
        c.lsp_info,
        c.lsp_hint,
        c.file_type,
        c.cur_position,
        c.cur_percent,
    },
}

local inactive = {
    { c.in_fileinfo }, -- left
    { c.in_position }, -- right
}

require('gitsigns').setup()
require('feline').setup({
    components = { active = active, inactive = inactive },
    highlight_reset_triggers = {},
    force_inactive = {
        filetypes = {
            'NvimTree',
            'packer',
            'dap-repl',
            'dapui_scopes',
            'dapui_stacks',
            'dapui_watches',
            'dapui_repl',
            'LspTrouble',
            'qf',
            'help',
        },
        buftypes = { 'terminal' },
        bufnames = {},
    },
    disable = {
        filetypes = {
            'dashboard',
            'startify',
        },
    },
})
