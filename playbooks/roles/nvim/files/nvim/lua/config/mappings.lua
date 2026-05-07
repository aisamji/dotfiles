vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })

vim.keymap.set("n", "<leader>ds", function() vim.diagnostic.setloclist() end, { desc = "Show file diagnostics" })
vim.keymap.set("n", "<leader>dS", function() vim.diagnostic.setqflist() end, { desc = "Show workspace diagnostics" })

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "-", "<cmd>Oil<cr>")
