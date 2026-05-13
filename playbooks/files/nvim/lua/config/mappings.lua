vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })
vim.keymap.set("n", "grl", function()
    vim.cmd.tabnew(vim.lsp.log.get_filename())
    vim.bo.readonly = true
    vim.bo.modifiable = false
end, { desc = "vim.lsp.log" })

vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set("n", "<leader>db", vim.diagnostic.setloclist, { desc = "Show buffer diagnostics" })
vim.keymap.set("n", "<leader>dw", vim.diagnostic.setqflist, { desc = "Show workspace diagnostics" })

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "-", "<cmd>Oil<cr>")
