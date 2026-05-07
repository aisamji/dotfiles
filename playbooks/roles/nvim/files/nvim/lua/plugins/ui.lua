return {
    {
        "ya2s/nvim-cursorline",
        opts = {
            cursorline = {
                timeout = 0,
            },
            cursorword = {
                enable = false,
            },
        },
        config = true,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.add({
                { "<leader>f", group = "fuzzy find" },
                { "<leader>g", group = "git" },
                { "<leader>d", group = "diagnostics" },
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = true,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }
}
