-- Cursorline and RelativeLineNumbers on active buffer
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  desc = "Turn on aesthetics for active buffer.",
  callback = function(_)
    if vim.wo.number then
      vim.wo.relativenumber = vim.api.nvim_get_mode().mode ~= "i"
      vim.wo.cursorline = vim.api.nvim_get_mode().mode ~= "i"
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  desc = "Turn off aesthetics for inactive buffer.",
  callback = function(_)
    if vim.wo.number then
      vim.wo.relativenumber = false
      vim.wo.cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    desc = "Auto-reload buffer modified externally.",
    command = "if mode() != 'c' | checktime | endif",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>:lclose<CR>", { buffer = true, silent = true })
    end,
})
