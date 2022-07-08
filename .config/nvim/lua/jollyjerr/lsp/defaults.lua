local M = {}

M.on_attach = function(_client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

  vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', bufopts)
  vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', bufopts)
  vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>nF', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>dF', vim.lsp.buf.remove_workspace_folder, bufopts)

  vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end

return M
