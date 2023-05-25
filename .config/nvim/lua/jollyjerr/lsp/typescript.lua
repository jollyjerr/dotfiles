local defaults = require('jollyjerr.modules.lsp')
local lspconfig = require('lspconfig')
local maps = require('jollyjerr.modules.keymaps')
local null_ls = require('null-ls')

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false

    local options = defaults.get_buffer_options(bufnr)
    defaults.add_read_only_maps(options)
  end,
  capabilities = defaults.get_capabilities(),
})

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.keymap.set('n', '<leader>F', function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = '[lsp] format' })
    end

    maps.nmap('<leader>EE', ':EslintFixAll<cr>')
  end,
})
