local defaults = require('jollyjerr.modules.lsp')

require('lspconfig').eslint.setup({
    on_attach = function(_, bufnr)
        defaults.on_attach(bufnr)

        vim.cmd('autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll')
    end,
    capabilities = defaults.get_capabilities()
})
