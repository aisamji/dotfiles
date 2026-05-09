return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                -- css = { "prettier" },
                -- html = { "prettier" },
            },

            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        version = "*",
        config = function()
            local cmp = require 'cmp'
            --- @type cmp.ConfigSchema
            local config = {
                sources = {
                    { name = "nvim_lsp" },
                    { name = "async_path" },
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ['<C-j>'] = {
                        i = cmp.mapping.select_next_item()
                    },
                    ['<C-k>'] = {
                        i = cmp.mapping.select_prev_item()
                    },
                    ['<C-l>'] = {
                        i = cmp.mapping.confirm({ select = false })
                    },
                    ['<C-h>'] = {
                        i = cmp.mapping.abort()
                    },
                },
            }

            cmp.setup(config)
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "FelipeLema/cmp-async-path",
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
