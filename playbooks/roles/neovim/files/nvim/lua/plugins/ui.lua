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
        event = "VimEnter",
        config = function()
            require("lualine").setup {
                options = {
                    globalstatus = true,
                    theme = "tokyonight",
                    disabled_filetypes = { "TelescopePrompt", "checkhealth" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff" },
                    lualine_c = {
                        "diagnostics",
                    },
                    lualine_x = {
                        function()
                            return require("lsp-progress").progress()
                        end,
                        "filetype",
                    },
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
                winbar = {
                    lualine_c = {
                        {
                            "filename",
                            path = 1, -- Show as relative path
                        },
                    },
                },
                inactive_winbar = {
                    lualine_c = {
                        {
                            "filename",
                            path = 1, -- Show as relative path
                        },
                    },
                },
                extensions = { "oil" },
            }

            -- listen to lsp-progress event and refresh
            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = "lualine_augroup",
                pattern = "LspProgressStatusUpdated",
                callback = require("lualine").refresh,
            })
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            {
                "linrongbin16/lsp-progress.nvim",
                config = true,
            },
        },
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
}
