return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>gb", function() vim.cmd.Gitsigns "blame_line" end, desc = "Git blame line" },
            { "<leader>gB", function() vim.cmd.Gitsigns "blame" end,      desc = "Git blame file" },
        },
        config = true,
    },
    {
        "NeogitOrg/neogit",
        cmd = {
            "Neogit",
        },
        keys = {
            {
                "<leader>gg",
                vim.cmd.Neogit,
                mode = "n",
                desc = "Launch Neogit",
            },
        },
        opts = {
            disable_insert_on_commit = true,
            process_spinner = true,
            commit_editor = {
                show_staged_diff = true,
            },
            mappings = {
                commit_editor = {
                    ["q"] = false,
                    ["<c-c><c-c>"] = false,
                    ["<c-c><c-k>"] = false,
                },
                rebase_editor = {
                    ["p"] = false,
                    ["r"] = false,
                    ["e"] = false,
                    ["s"] = false,
                    ["f"] = false,
                    ["x"] = false,
                    ["d"] = false,
                    ["b"] = false,
                    ["q"] = false,
                    ["<cr>"] = false,
                    ["gk"] = false,
                    ["gj"] = false,
                    ["<c-c><c-c>"] = false,
                    ["<c-c><c-k>"] = false,
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",   -- required
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true,
    },
    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewFileHistory",
        },
        config = function()
            local actions = require "diffview.actions"

            require("diffview").setup {
                view = {
                    merge_tool = {
                        layout = "diff3_mixed",
                    },
                },
                keymaps = {
                    disable_defaults = true, -- Disable the default keymaps
                    view = {
                        { "n", "]f",        actions.select_next_entry,  { desc = "Open the diff for the next file" } },
                        { "n", "[f",        actions.select_prev_entry,  { desc = "Open the diff for the previous file" } },
                        { "n", "[F",        actions.select_first_entry, { desc = "Open the diff for the first file" } },
                        { "n", "]F",        actions.select_last_entry,  { desc = "Open the diff for the last file" } },
                        { "n", "<leader>e", actions.focus_files,        { desc = "Bring focus to the file panel" } },
                        { "n", "<C-n",      actions.toggle_files,       { desc = "Toggle the file panel." } },
                        {
                            "n",
                            "[x",
                            actions.prev_conflict,
                            { desc = "In the merge-tool: jump to the previous conflict" },
                        },
                        {
                            "n",
                            "]x",
                            actions.next_conflict,
                            { desc = "In the merge-tool: jump to the next conflict" },
                        },
                        {
                            "n",
                            "<localleader>o",
                            actions.conflict_choose "ours",
                            { desc = "Choose the OURS version of a conflict" },
                        },
                        {
                            "n",
                            "<localleader>t",
                            actions.conflict_choose "theirs",
                            { desc = "Choose the THEIRS version of a conflict" },
                        },
                        {
                            "n",
                            "<localleader>b",
                            actions.conflict_choose "base",
                            { desc = "Choose the BASE version of a conflict" },
                        },
                        {
                            "n",
                            "<localleader>a",
                            actions.conflict_choose "all",
                            { desc = "Choose all the versions of a conflict" },
                        },
                        { "n", "dx", actions.conflict_choose "none", { desc = "Delete the conflict region" } },
                        {
                            "n",
                            "<localleader>O",
                            actions.conflict_choose_all "ours",
                            { desc = "Choose the OURS version of a conflict for the whole file" },
                        },
                        {
                            "n",
                            "<localleader>T",
                            actions.conflict_choose_all "theirs",
                            { desc = "Choose the THEIRS version of a conflict for the whole file" },
                        },
                        {
                            "n",
                            "<localleader>B",
                            actions.conflict_choose_all "base",
                            { desc = "Choose the BASE version of a conflict for the whole file" },
                        },
                        {
                            "n",
                            "<localleader>A",
                            actions.conflict_choose_all "all",
                            { desc = "Choose all the versions of a conflict for the whole file" },
                        },
                        {
                            "n",
                            "dX",
                            actions.conflict_choose_all "none",
                            { desc = "Delete the conflict region for the whole file" },
                        },
                    },
                    diff1 = {
                        -- Mappings in single window diff layouts
                        { "n", "g?", actions.help { "view", "diff1" }, { desc = "Open the help panel" } },
                    },
                    diff2 = {
                        -- Mappings in 2-way diff layouts
                        { "n", "g?", actions.help { "view", "diff2" }, { desc = "Open the help panel" } },
                    },
                    diff3 = {
                        -- Mappings in 3-way diff layouts
                        { "n", "g?", actions.help { "view", "diff3" }, { desc = "Open the help panel" } },
                    },
                    file_panel = {
                        { "n", "j",         actions.next_entry,         { desc = "Bring the cursor to the next file entry" } },
                        { "n", "<down>",    actions.next_entry,         { desc = "Bring the cursor to the next file entry" } },
                        { "n", "k",         actions.prev_entry,         { desc = "Bring the cursor to the previous file entry" } },
                        { "n", "<up>",      actions.prev_entry,         { desc = "Bring the cursor to the previous file entry" } },
                        { "n", "<cr>",      actions.select_entry,       { desc = "Open the diff for the selected entry" } },
                        { "n", "s",         actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
                        { "n", "S",         actions.stage_all,          { desc = "Stage all entries" } },
                        { "n", "U",         actions.unstage_all,        { desc = "Unstage all entries" } },
                        { "n", "X",         actions.restore_entry,      { desc = "Restore entry to the state on the left side" } },
                        { "n", "]f",        actions.select_next_entry,  { desc = "Open the diff for the next file" } },
                        { "n", "[f",        actions.select_prev_entry,  { desc = "Open the diff for the previous file" } },
                        { "n", "[F",        actions.select_first_entry, { desc = "Open the diff for the first file" } },
                        { "n", "]F",        actions.select_last_entry,  { desc = "Open the diff for the last file" } },
                        { "n", "<leader>e", actions.focus_files,        { desc = "Bring focus to the file panel" } },
                        { "n", "<C-n",      actions.toggle_files,       { desc = "Toggle the file panel" } },
                        { "n", "g?",        actions.help "file_panel",  { desc = "Open the help panel" } },
                        { "n", "[x",        actions.prev_conflict,      { desc = "Go to the previous conflict" } },
                        { "n", "]x",        actions.next_conflict,      { desc = "Go to the next conflict" } },
                        {
                            "n",
                            "<localleader>O",
                            actions.conflict_choose_all "ours",
                            { desc = "Choose the OURS version of a conflict for the whole file" },
                        },
                        {
                            "n",
                            "<localleader>T",
                            actions.conflict_choose_all "theirs",
                            { desc = "Choose the THEIRS version of a conflict for the whole file" },
                        },
                        {
                            "n",
                            "<localleader>B",
                            actions.conflict_choose_all "base",
                            { desc = "Choose the BASE version of a conflict for the whole file" },
                        },
                        {
                            "n",
                            "<localleader>A",
                            actions.conflict_choose_all "all",
                            { desc = "Choose all the versions of a conflict for the whole file" },
                        },
                        {
                            "n",
                            "dX",
                            actions.conflict_choose_all "none",
                            { desc = "Delete the conflict region for the whole file" },
                        },
                    },
                    option_panel = {
                        { "n", "<esc>", actions.close,               { desc = "Close the panel" } },
                        { "n", "g?",    actions.help "option_panel", { desc = "Open the help panel" } },
                    },
                    help_panel = {
                        { "n", "<esc>", actions.close, { desc = "Close help menu" } },
                    },
                },
            }
        end,
    },
}
