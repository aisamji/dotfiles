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
                mapping = cmp.mapping.preset.insert({}),
            }

            cmp.setup(config)
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "FelipeLema/cmp-async-path",
        },
    },
}
