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
            local wk = require "which-key"
            wk.add {
                { "<leader>f", group = "fuzzy find" },
                { "<leader>g", group = "git" },
                { "<leader>d", group = "diagnostics" },
            }
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                globalstatus = true,
                theme = "tokyonight",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = {
                    "diagnostics",
                    {
                        "filename",
                        path = 1, -- Show as relative path
                    },
                },
                lualine_x = { "filetype", "lsp_status" },
                lualine_y = { "encoding", "fileformat" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "oil" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup {}
            vim.cmd [[colorscheme tokyonight]]
        end,
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            notification = {
                override_vim_notify = true,
            },
        },
    },
}
