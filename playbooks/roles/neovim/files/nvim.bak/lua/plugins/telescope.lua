return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        cmd = "Telescope",
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
            { mode = "n", "ff",             function() vim.cmd.Telescope("find_files") end,                 desc = "Find file in current project" },
            { mode = "n", "fF",             function() vim.cmd.Telescope({ "find_files", "cwd=~" }) end,    desc = "Find file in Home directory" },
            -- TODO: Add keymap to search .config directory or .config/nvim directory only
            { mode = "n", "fg",             function() vim.cmd.Telescope("live_grep") end,                  desc = "Find text in current project" },
            { mode = "n", "gr",             function() vim.cmd.Telescope("lsp_references") end,             desc = "Go to reference" },
            { mode = "n", "gd",             function() vim.cmd.Telescope("lsp_definitions") end,            desc = "Go to definition" },
            { mode = "n", "gR",             function() vim.cmd.Telescope("lsp_implementations") end,        desc = "Go to implementation (think inheritance)" },
            { mode = "n", "gD",             function() vim.cmd.Telescope("lsp_type_definitions") end,       desc = "Go to type definition" },

            { mode = "n", "<localleader>D", function() vim.cmd.Telescope({ "diagnostics", "bufnr=0" }) end, desc = "Show file diagnostics" },
            -- TODO: Convert file diagnostics into project diagnostics
        },
        config = function()
            require('telescope').setup({
                pickers = {
                    git_bcommits = {
                        git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "--follow" }
                    }
                    -- TODO: Redo keymap to open file in horizontal split via find_files picker
                    -- TODO: Redo keymap to open file in vertical split via find_files picker
                    -- TODO: Add keymap to delete a file in find_files picker
                    -- TODO: Add keymap to copy a file in find_files picker
                    -- TODO: Add keymap to move a file in find_files picker
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }

                        -- pseudo code / specification for writing custom displays, like the one
                        -- for "codeactions"
                        -- specific_opts = {
                        --   [kind] = {
                        --     make_indexed = function(items) -> indexed_items, width,
                        --     make_displayer = function(widths) -> displayer
                        --     make_display = function(displayer) -> function(e)
                        --     make_ordinal = function(e) -> string
                        --   },
                        --   -- for example to disable the custom builtin "codeactions" display
                        --      do the following
                        --   codeactions = false,
                        -- }
                    }
                }
            })
        end
    },
    {
        'airblade/vim-rooter',
        config = function()
            vim.g.rooter_silent_chdir = 1
            vim.g.rooter_patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", }
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        lazy = false,
        config = function()
            require("telescope").load_extension("ui-select")
        end
    },
}
