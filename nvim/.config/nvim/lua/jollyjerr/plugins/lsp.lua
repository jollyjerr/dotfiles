local set = vim.keymap.set
local lsp_handlers = vim.lsp.handlers

local function add_read_only_maps(bufopts)
    set('n', '<leader>rr', '<cmd>LspRestart<cr>', bufopts)

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
    set('n', '<leader>F', function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
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

        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local function get_capabilities()
            return capabilities
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

        local original_showMessage_handler = lsp_handlers['window/showMessage']
        lsp_handlers['window/showMessage'] = function(err, result, ctx, config)
            local message = result and result.message

            -- Temporary workaround for elixirls annoyance
            local ignore_phrases = {
                'Quokka is not loaded',
                'OTP compiled without',
            }

            if message then
                for _, phrase in ipairs(ignore_phrases) do
                    if message:find(phrase) then
                        return
                    end
                end
            end

            if original_showMessage_handler then
                original_showMessage_handler(err, result, ctx, config)
            end
        end

        local servers = {
            clangd = {},
            gopls = {},
            html = {},
            -- htmx = {},
            jdtls = {},
            kotlin_language_server = {},
            -- ruby_lsp = {},
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
                handlers = lsp_handlers,
            },
            -- lexical = {
            --     cmd = { home .. '/code/@opensource/expert/expert_darwin_arm64', '--stdio' },
            --     -- root_dir = function(fname)
            --     --     return require('lspconfig').util.root_pattern('mix.exs', '.git')(fname) or vim.loop.cwd()
            --     -- end,
            --     root_markers = { 'mix.exs', '.git' },
            --     filetypes = { 'elixir', 'eelixir', 'heex' },
            -- },
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
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
                    -- 'typescript'
                },
            },
            eslint = {
                on_attach = function(_, _)
                    set('n', '<leader>EE', ':EslintFixAll<cr>')
                end,
            },
            cssls = {

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
            local name = custom_config.mason_name or key
            table.insert(server_names, name)
        end

        for key, custom_config in pairs(servers) do
            local final_config = {
                on_attach = on_attach,
                capabilities = get_capabilities(),
            }

            for k, v in pairs(custom_config) do
                final_config[k] = v
            end

            vim.lsp.config(key, final_config)
            vim.lsp.enable(key)
        end

        require('mason-lspconfig').setup({
            automatic_installation = true,
            ensure_installed = server_names,
            automatic_enable = false,
        })
    end,
}
