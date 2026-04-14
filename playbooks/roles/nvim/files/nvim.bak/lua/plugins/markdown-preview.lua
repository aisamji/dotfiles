return {
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        -- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
        keys = {
            { mode = "n", "<localleader>p", vim.cmd.MarkdownPreview, desc = "Preview Markdown", ft = "markdown" },
        },
        config = function() end,
        -- config = function()
        --     vim.g.mkdp_auto_start = 1
        --     vim.g.mkdp_auto_close = 1
        -- end
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
        dependencies = { 'nvim-treesitter/nvim-treesitter', { 'nvim-mini/mini.icons', version = false } }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            sign = {
                enabled = false,
            },
        },
    },
}
