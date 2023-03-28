local defaults = require('jollyjerr.modules.lsp')
local lspconfig = require('lspconfig')
local maps = require('jollyjerr.modules.keymaps')

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false

    local options = defaults.get_buffer_options(bufnr)
    defaults.add_read_only_maps(options)
  end,
  capabilities = defaults.get_capabilities(),
})

local null_ls = require('null-ls')
local prettier = require('prettier')

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
  },
  on_attach = function(client, _)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd('nnoremap <silent><buffer> <Leader>F :lua vim.lsp.buf.format({async = true})<CR>')
    end
    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd('nnoremap <silent><buffer> <Leader>F :lua vim.lsp.buf.range_formatting({})<CR>')
    end

    maps.nmap('<leader>P', ':Prettier<cr>')
    maps.nmap('<leader>E', ':EslintFixAll<cr>')
  end,
})

prettier.setup({
  bin = 'prettier',
  filetypes = {
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'less',
    'markdown',
    'scss',
    'typescript',
    'typescriptreact',
    'yaml',
  },
})
