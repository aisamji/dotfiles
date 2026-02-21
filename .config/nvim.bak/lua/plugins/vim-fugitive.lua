return {
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gs", vim.cmd.Git,                             mode = "n" },
            { "<leader>gl", function() vim.cmd.Git("log") end,       mode = "n" },
            { "<leader>gw", function() vim.cmd.Git("blame") end,     mode = "n" },
            { "<leader>gp", function() vim.cmd.Git("pull") end,      mode = "n" },
            { "<leader>gP", function() vim.cmd.Git("push") end,      mode = "n" },
            { "<leader>gu", function() vim.cmd.Git("stash -u") end,  mode = "n" },
            { "<leader>gU", function() vim.cmd.Git("stash pop") end, mode = "n" },
            { "<leader>gb", ":Git branch ",                          noremap = true, mode = "n" },
            { "<leader>gC", ":Git checkout -b ",                     noremap = true, mode = "n" },
            { "<leader>gc", ":Git checkout ",                        noremap = true, mode = "n" },
        },
    },
    {
        "tpope/vim-rhubarb",
        dependencies = { 'tpope/vim-fugitive' },
        keys = {
            { "<leader>go", ":GBrowse<CR>",  noremap = true, silent = true, mode = "v" },
            { "<leader>go", vim.cmd.GBrowse, mode = "n" },
        }
    },
}
