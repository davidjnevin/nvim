return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ansiblels",
                "bashls",
                "yamlls",
                "lua_ls",
                "ruff",
                "rust_analyzer",
                "ts_ls",
                "gopls",
            },
            handlers = {
                -- function(server_name) -- default handler (optional)
                --     require("lspconfig")[server_name].setup {
                --         capabilities = capabilities,
                --     }
                -- end,

                ["ruff"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ruff.setup {
                        capabilities = capabilities,
                        filetypes = { "python" },
                    }
                end,
                -- ["jdtls"] = function()
                --     local javacongif = require('java')
                --     local lspconfig = require("lspconfig")
                --     javacongif.setup()
                --     lspconfig.jdtls.setup {
                --         capabilities = capabilities,
                --         filetypes = { "java" },
                --     }
                -- end,
                ["gopls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.gopls.setup {
                        capabilities = capabilities,
                        filetypes = { "go", "gomod", "gowork", "gotmpl" },
                    }
                end,

                ["yamlls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.yamlls.setup {
                        capabilities = capabilities,
                        filetypes =
                        { "yml", "yaml", "yaml.docker-compose", "yaml.gitlab" },
                        settings = {
                            yaml = {
                                schemas = {
                                    kubernetes = "k8s-*.yaml",
                                    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                                    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                                    ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
                                    ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                                    ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                                    ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                                    ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
                                },
                            },
                        }
                    }
                end,

                ["ansiblels"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ansiblels.setup {
                        capabilities = capabilities,
                        settings = {
                            ansible = {
                                ansible = {
                                    path = "ansible"
                                },
                                executionEnvironment = {
                                    enabled = false
                                },
                                python = {
                                    interpreterPath = "python"
                                },
                                validation = {
                                    enabled = true,
                                    lint = {
                                        enabled = true,
                                        path = "ansible-lint"
                                    }
                                }
                            }
                        }
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                workspace = { checkThirdParty = false },
                                diagnostics = {
                                    disable = { "missing-fields" },
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
