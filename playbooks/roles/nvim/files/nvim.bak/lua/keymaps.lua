-- Workspace Management keymaps (prefix: `<leader>p`)
vim.keymap.set("n", "<leader>pL", vim.cmd.vsplit)     -- open current file in new split pane to the right
vim.keymap.set("n", "<leader>pK", vim.cmd.split)      -- open current file in new split pane below
vim.keymap.set("n", "<leader>p<C-t>", vim.cmd.tabnew) -- open scratch buffer in new tab
vim.keymap.set("n", "<leader>pT", vim.cmd.tabclose)   -- close current tab
vim.keymap.set("n", "<leader>pP", vim.cmd.Explore)    -- open netrw file explorer in current buffer

-- terminal keymaps
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>t", ":vert term<CR>i", { noremap = true, silent = true })

-- tab/splitpane navigation keymaps
vim.keymap.set("n", "<tab>", "<C-w><C-w>", { noremap = true, silent = true })   -- switch to pane below, topmost of right column, or cycle back to top-left pane.
vim.keymap.set("n", "<S-tab>", "<C-w><S-w>", { noremap = true, silent = true }) -- switch to pane above, bottomost of left column, or cycle back to bottom-right pane.
vim.keymap.set("n", "<C-A-tab>", "gt", { noremap = true, silent = false })      -- switch to tab on right, or cycle back to leftmost tab.
vim.keymap.set("n", "<C-S-A-tab>", "gT", { noremap = true, silent = true })     -- switch to tab on left, or cycel back to rightmost tab.
-- vim.keymap.set("n", "<C-S-Down>", "10<C-w>+", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-S-Left>", "10<C-w><", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-S-Up>", "10<C-w>-", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-S-Right>", "10<C-w>>", { noremap = true, silent = true })

-- clipboard/pasteboard keymaps
vim.keymap.set("n", "<leader>ry", "\"+Y", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>ry", "\"+y", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rp", "\"+p", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>rp", "\"+p", { noremap = true, silent = true })

vim.keymap.set({ "n", "i" }, "<c-j>", vim.diagnostic.open_float)

vim.keymap.set("n", "H", "^") -- jump to first character in line
vim.keymap.set("n", "L", "$") -- jump to end of line
