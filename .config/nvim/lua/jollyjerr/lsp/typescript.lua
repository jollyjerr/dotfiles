local defaults = require('jollyjerr.lsp.defaults')

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false

        -- TODO: find a way to just map.merge with defaults and overwrite keys
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', bufopts)
        vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', bufopts)
        vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', bufopts)
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', bufopts)

        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>nF', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>dF', vim.lsp.buf.remove_workspace_folder, bufopts)

        vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, bufopts)

        vim.keymap.set('n', '<leader>rr', '<cmd>LspRestart<cr>')
    end,
    capabilities = defaults.get_capabilities(),
})

local null_ls = require("null-ls")
local prettier = require("prettier")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
    },
    on_attach = function(client, _)
        if client.resolved_capabilities.document_formatting then
            vim.cmd("nnoremap <silent><buffer> <Leader>F :lua vim.lsp.buf.formatting()<CR>")
        end

        if client.resolved_capabilities.document_range_formatting then
            vim.cmd("xnoremap <silent><buffer> <Leader>F :lua vim.lsp.buf.range_formatting({})<CR>")
        end

        vim.cmd [[
          augroup lsp_buf_format
            au! BufWritePre <buffer>
            autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
          augroup END
        ]]
    end,
})

prettier.setup({
    bin = 'prettier',
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
})
