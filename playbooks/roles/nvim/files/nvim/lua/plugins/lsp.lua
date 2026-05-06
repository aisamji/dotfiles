return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
            })
        end,
    },
}
