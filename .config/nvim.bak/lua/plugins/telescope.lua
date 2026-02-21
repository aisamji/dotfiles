return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { mode = "n", "<leader>pp", function() vim.cmd.Telescope("find_files") end },
            {
                mode = "n",
                "<leader>pl",
                function()
                    vim.cmd.vnew()
                    vim.cmd.Telescope("find_files")
                end
            },
            {
                mode = "n",
                "<leader>pk",
                function()
                    vim.cmd.new()
                    vim.cmd.Telescope("find_files")
                end
            },
            {
                mode = "n",
                "<leader>pt",
                function()
                    vim.cmd.Texplore("~")
                    vim.cmd.Telescope("find_files")
                end
            },
            { mode = "n", "<leader>po", function() vim.cmd.Telescope("buffers") end },
            { mode = "n", "<leader>p/", function() vim.cmd.Telescope("live_grep") end },
            -- { mode = "n", "<leader>fd", function() vim.cmd.Telescope("diagnostics") end },
            { mode = "n", "gr",         function() vim.cmd.Telescope("lsp_references") end },
            { mode = "n", "gd",         function() vim.cmd.Telescope("lsp_definitions") end },
            { mode = "n", "gR",         function() vim.cmd.Telescope("lsp_implementations") end },
            { mode = "n", "gD",         function() vim.cmd.Telescope("lsp_type_definitions") end },
        },
    },
    {
        'airblade/vim-rooter',
        config = function()
            vim.g.rooter_silent_chdir = 1
            vim.g.rooter_patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", }
        end
    }
}
