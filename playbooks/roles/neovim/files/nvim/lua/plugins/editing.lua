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
                    { name = "nvim_lsp" },
                    { name = "async_path" },
                },
                window = {
                    documentation = cmp.config.window.bordered(),
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
    -- {
    --     "olimorris/codecompanion.nvim",
    --     version = "^19.0.0",
    --     opts = {
    --         adapters = {
    --             acp = {
    --                 claude_code = function()
    --                     return require("codecompanion.adapters").extend("claude_code", {
    --                         env = {
    --                             CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",
    --                         },
    --                     })
    --                 end,
    --             },
    --         },
    --         interactions = {
    --             chat = {
    --                 adapter = "claude_code",
    --             },
    --         },
    --     },
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    -- },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        ---@module 'copilot'
        ---@type CopilotConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            ---@diagnostic disable-next-line: missing-fields
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = false,
                keymap = {
                    accept = "<Tab>",
                    accept_line = false,
                    accept_word = false,
                    dismiss = false,
                    next = false,
                    prev = false,
                },
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
                    accept_and_goto = "gs",
                    dismiss = false,
                },
            },
            filetypes = {
                plaintext = false,
                markdown = false,
                toml = false,
                yaml = false,
                oil = false,
                gitcommit = false,
                gitrebase = false,
            },
        },
        dependencies = {
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
