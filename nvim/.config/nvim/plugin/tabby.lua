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

  local pallet = {}
  for name, value in pairs(color_map) do
    local global_name = 'terminal_color_' .. value.index
    pallet[name] = vim.g[global_name] and vim.g[global_name] or value.default
  end

  pallet.sl = style.get_highlight('StatusLine')
  pallet.tab = style.get_highlight('TabLine')
  pallet.sel = style.get_highlight('TabLineSel')
  pallet.fill = style.get_highlight('TabLineFill')

  return pallet
end

local function genreate_user_tabline_highlights()
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

  local groups = {
    UserTLHead = { fg = pal.fill.bg, bg = pal.cyan },
    UserTLHeadSep = { fg = pal.cyan, bg = pal.fill.bg },
    UserTLActive = { fg = pal.sel.fg, bg = pal.sel.bg, bold = true },
    UserTLActiveSep = { fg = pal.sel.bg, bg = pal.fill.bg },
    UserTLBoldLine = { fg = pal.tab.fg, bg = pal.tab.bg, bold = true },
    UserTLLineSep = { fg = pal.tab.bg, bg = pal.fill.bg },
  }

  style.set_highlights(vim.tbl_extend('force', colors, groups))
end

genreate_user_tabline_highlights()
vim.api.nvim_create_augroup('UserTablineHighlightGroups', { clear = true })
vim.api.nvim_create_autocmd({ 'SessionLoadPost', 'ColorScheme' }, {
  callback = function()
    genreate_user_tabline_highlights()
  end,
})

local filename = require('tabby.filename')

local cwd = function()
  return '  ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
end

local line = {
  hl = 'TabLineFill',
  layout = 'active_wins_at_tail',
  head = {
    { cwd, hl = 'UserTLHead' },
    { '', hl = 'UserTLHeadSep' },
  },
  active_tab = {
    label = function(tabid)
      return {
        '  ' .. tabid .. ' ',
        hl = 'UserTLActive',
      }
    end,
    left_sep = { '', hl = 'UserTLActiveSep' },
    right_sep = { '', hl = 'UserTLActiveSep' },
  },
  inactive_tab = {
    label = function(tabid)
      return {
        '  ' .. tabid .. ' ',
        hl = 'UserTLBoldLine',
      }
    end,
    left_sep = { '', hl = 'UserTLLineSep' },
    right_sep = { '', hl = 'UserTLLineSep' },
  },
  top_win = {
    label = function(winid)
      return {
        '  ' .. filename.unique(winid) .. ' ',
        hl = 'TabLine',
      }
    end,
    left_sep = { '', hl = 'UserTLLineSep' },
    right_sep = { '', hl = 'UserTLLineSep' },
  },
  win = {
    label = function(winid)
      return {
        '  ' .. filename.unique(winid) .. ' ',
        hl = 'TabLine',
      }
    end,
    left_sep = { '', hl = 'UserTLLineSep' },
    right_sep = { '', hl = 'UserTLLineSep' },
  },
  tail = {
    { '', hl = 'UserTLHeadSep' },
    { '  ', hl = 'UserTLHead' },
  },
}

require('tabby').setup({
  tabline = line,
})
