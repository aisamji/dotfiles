return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        ---@module 'conform'
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                -- css = { "prettier" },
                html = { "prettier" },
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
            local cmp = require "cmp"
            --- @type cmp.ConfigSchema
            local config = {
                sources = {
                    { name = "async_path" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "calc" },
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered(),
                },
                mapping = {
                    ["<C-j>"] = {
                        i = cmp.mapping.select_next_item(),
                    },
                    ["<C-k>"] = {
                        i = cmp.mapping.select_prev_item(),
                    },
                    ["<C-l>"] = {
                        i = cmp.mapping.confirm { select = false },
                    },
                    ["<C-h>"] = {
                        i = cmp.mapping.abort(),
                    },
                },
            }

            cmp.setup(config)
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp-signature-help",
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
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        init = function()
            -- remove default <Tab> and <S-Tab> mappings
            vim.keymap.del("i", "<Tab>")
            vim.keymap.del("i", "<S-Tab>")
        end,
        ---@module 'copilot'
        ---@type CopilotConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            ---@diagnostic disable-next-line: missing-fields
            suggestion = {
                enabled = false,
            },
            ---@diagnostic disable-next-line: missing-fields
            panel = {
                enabled = false,
            },
            server_opts_overrides = {
                settings = {
                    advanced = {
                        length = 500,
                        temperature = 0.1,
                        top_p = 1,
                    },
                },
            },
            nes = {
                enabled = true,
                auto_trigger = false,
                keymap = {
                    accept = false,
                    accept_and_goto = "<Tab>",
                    dismiss = false,
                },
            },
            filetypes = {
                markdown = false,
                text = false,
                oil = false,
                gitcommit = false,
                gitrebase = false,
                yaml = true,
            },
        },
        dependencies = {
            {
                "zbirenbaum/copilot-cmp",
                config = true,
            },
            {
                "copilotlsp-nvim/copilot-lsp",
                config = function()
                    require("copilot-lsp").setup {
                        ---@diagnostic disable-next-line: missing-fields
                        nes = {
                            move_count_threshold = 10,
                            count_horizontal_moves = false,
                        },
                    }

                    -- After copilot loads, replace the NES autocmd group with sensible triggers
                    vim.api.nvim_create_autocmd("LspAttach", {
                        callback = function(args)
                            -- TODO: Fix triggers to ensure that NES is only requested in normal mode. It is still being requested in insert mode for an unknown reason.
                            local client = vim.lsp.get_client_by_id(args.data.client_id)
                            if client and client.name == "copilot" then
                                -- Replace with sane triggers
                                local nes = require "copilot-lsp.nes"
                                local debounced = require("copilot-lsp.util").debounce(
                                    nes.request_nes,
                                    vim.g.copilot_nes_debounce or 500
                                )

                                -- The name of the group must match the one used by copilot-lsp in order to override it
                                vim.api.nvim_create_augroup("copilotlsp.init", { clear = true })
                                vim.api.nvim_create_autocmd({ "ModeChanged" }, {
                                    pattern = "i:n", -- only when leaving insert mode
                                    callback = function()
                                        debounced(client)
                                    end,
                                    group = "copilotlsp.init",
                                })

                                -- Trigger NES when text is changed in normal mode.
                                vim.api.nvim_create_autocmd({ "TextChanged" }, {
                                    callback = function()
                                        debounced(client)
                                    end,
                                    group = "copilotlsp.init",
                                })

                                -- Clear NES when entering insert mode (prevents stale diffs)
                                vim.api.nvim_create_autocmd("InsertEnter", {
                                    callback = function()
                                        nes.clear()
                                    end,
                                    group = "copilotlsp.init",
                                })
                            end
                        end,
                    })
                end,
            },
        },
    },
}
