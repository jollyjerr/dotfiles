local set = vim.keymap.set

local function add_read_only_maps(bufopts)
    set('n', '<leader>rr', '<cmd>LspRestart<cr>')

    set('n', 'K', vim.lsp.buf.hover, bufopts)

    set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', bufopts)
    set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', bufopts)
    set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', bufopts)
    set('n', 'gr', '<cmd>Telescope lsp_references<cr>', bufopts)

    set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    set('n', '<leader>nF', vim.lsp.buf.add_workspace_folder, bufopts)
    set('n', '<leader>dF', vim.lsp.buf.remove_workspace_folder, bufopts)

    set('n', '<leader>qf', vim.lsp.buf.code_action, bufopts)
end

local function add_formatting(bufopts)
    set('n', '<leader>F', vim.lsp.buf.format, bufopts)
end

local function get_buffer_options(buffer_number)
    return { noremap = true, silent = true, buffer = buffer_number }
end

local function on_attach(_, buffer_number)
    local options = get_buffer_options(buffer_number)

    add_read_only_maps(options)
    add_formatting(options)
end

return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim',
        'folke/neodev.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        require('mason').setup()
        require('neodev').setup()

        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        local function get_capabilities()
            cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
        end

        local prettier = {
            formatCommand = 'prettierd "${INPUT}"',
            formatStdin = true,
        }

        local stylua = {
            formatCommand = 'stylua',
            formatStdin = true,
            rootMarkers = { 'stylua.toml', '.stylua.toml' },
        }

        local home = os.getenv('HOME')

        local servers = {
            clangd = {},
            gopls = {},
            html = {},
            htmx = {},
            jdtls = {},
            kotlin_language_server = {},
            ruby_lsp = {},
            rust_analyzer = {},
            svelte = {},
            elixirls = {
                settings = {
                    elixirLS = {
                        dialyzerEnabled = false,
                        fetchDeps = false,
                    },
                },
                cmd = { home .. '/.local/share/nvim/mason/bin/elixir-ls' },
            },
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                'vim',
                            },
                        },
                    },
                },
            },
            pylsp = {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = { 'W391' },
                                maxLineLength = 100,
                            },
                        },
                    },
                },
            },
            tailwindcss = {
                settings = {
                    tailwindCSS = {
                        classAttributes = { 'class', 'className', 'classList' },
                    },
                },
            },
            ts_ls = {
                -- mason_name = 'tsserver',
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false

                    local options = get_buffer_options(bufnr)
                    add_read_only_maps(options)
                end,
            },
            denols = {
                filetypes = {
                    'javascript',
                },
            },
            eslint = {
                on_attach = function()
                    set('n', '<leader>EE', ':EslintFixAll<cr>')
                end,
            },
            efm = {
                filetypes = {
                    'typescript',
                    'typescriptreact',
                    'javascript',
                    'javascriptreact',
                    'svelte',
                    'vue',
                    'markdown',
                    'html',
                    'lua',
                },
                init_options = { documentFormatting = true },
                rootMarkers = { '.git/' },
                settings = {
                    languages = {
                        lua = { stylua },
                        typescript = { prettier },
                        typescriptreact = { prettier },
                        javascript = { prettier },
                        javascriptreact = { prettier },
                        svelte = { prettier },
                        vue = { prettier },
                        markdown = { prettier },
                        html = { stylua },
                    },
                },
            },
        }

        local server_names = {}
        for key, custom_config in pairs(servers) do
            local name = custom_config['mason_name'] == nil and key or custom_config['mason_name']
            table.insert(server_names, name)

            local default_config = {
                on_attach = on_attach,
                capabilities = get_capabilities(),
            }

            for a, b in pairs(custom_config) do
                default_config[a] = b
            end

            lspconfig[key].setup(default_config)
        end

        require('mason-lspconfig').setup({
            automatic_installation = true,
            ensure_installed = server_names,
        })
    end,
}
