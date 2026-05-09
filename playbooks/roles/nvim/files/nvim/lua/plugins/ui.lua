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
        opts = {
            options = {
                globalstatus = true,
                theme = 'tokyonight',
            },
            sections = {
                lualine_x = { 'lsp_status', 'filetype' },
                lualine_y = { 'encoding', 'fileformat' },
            },
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('tokyonight').setup {}
            vim.cmd [[colorscheme tokyonight]]
        end
    },
}
