require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<leader>gb", function()
  vim.cmd.Gitsigns "blame_line"
end, { desc = "Git blame line." })
map("n", "<leader>gB", function()
  vim.cmd.Gitsigns "blame"
end, { desc = "Git blame file." })
map("n", "=", vim.lsp.buf.format, { desc = "Format file" })
