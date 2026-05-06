return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            vim.keymap.set("n", "=", vim.lsp.buf.format)
            require("mason").setup()
            require("mason-lspconfig").setup()
        end,
    },
}
