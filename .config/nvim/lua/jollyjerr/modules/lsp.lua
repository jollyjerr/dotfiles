local M = {}

M.add_read_only_maps = function(bufopts)
    vim.keymap.set('n', '<leader>rr', '<cmd>LspRestart<cr>')

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', bufopts)
    vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', bufopts)
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', bufopts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', bufopts)

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>nF', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>dF', vim.lsp.buf.remove_workspace_folder, bufopts)

    vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, bufopts)
end

M.add_formatting = function(bufopts)
    vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.format()
      augroup END
    ]]
end

M.get_buffer_options = function(buffer_number)
    return { noremap = true, silent = true, buffer = buffer_number }
end

M.on_attach = function(_, bufnr)
    local options = M.get_buffer_options(bufnr)

    M.add_read_only_maps(options)
    M.add_formatting(options)
end

M.get_capabilities = function() require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()) end

return M
