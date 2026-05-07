vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })

vim.keymap.set("n", "<leader>ds", function() vim.diagnostic.setloclist() end, { desc = "Show file diagnostics" })
vim.keymap.set("n", "<leader>dS", function() vim.diagnostic.setqflist() end, { desc = "Show workspace diagnostics" })
