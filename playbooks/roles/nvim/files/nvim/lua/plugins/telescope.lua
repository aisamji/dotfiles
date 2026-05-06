return {
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        keys = {
            { '<leader>ff', require('telescope.builtin').find_files, },
            { '<leader>fg', require('telescope.builtin').live_grep, },
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
}
