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
        opts = {
            sources = {
                { name = "nvim_lsp" },
                { name = "async_path" },
            },
        },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "FelipeLema/cmp-async-path",
        },
    },
}
