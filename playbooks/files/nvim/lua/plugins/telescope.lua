return {
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        keys = {
            {
                '<leader>ff',
                require('telescope.builtin').find_files,
                desc = 'Find File (Regex)'
            },
            {
                '<leader>fg',
                require('telescope.builtin').live_grep,
                desc = 'Find Text (Regex)'
            },
        },
        opts = {
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                    "--follow",
                    -- TODO: Ensure `.git/` is in ~/.rgignore
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    follow = true,
                }
            },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-tree/nvim-web-devicons',
        }
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        event = "VeryLazy",
        config = function()
            require("telescope").load_extension "ui-select"
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {},
                    },
                },
            }
        end,
        dependencies = {
            'nvim-telescope/telescope.nvim',
        }
    },
}
