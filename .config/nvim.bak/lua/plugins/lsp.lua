return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "ms-jpq/coq_nvim",      branch = "coq" },
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        -- { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
    init = function()
        vim.g.coq_settings = {
            auto_start = 'shut-up',
            completion = {
                always = false,
            },
            keymap = {
                recommended = false,
                manual_complete = "<C-space>"
            }
        }
    end,
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        on_init = function(client, _)
                            client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
                        end
                    })
                end,
            }
        })
        vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and "; " or ":") .. vim.env.PATH
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
        vim.keymap.set("n", "=", vim.lsp.buf.format)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.code_action)
    end
}
