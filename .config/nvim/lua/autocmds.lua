require "nvchad.autocmds"

-- Change working directory to the argument passed to nvim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local first_arg = vim.fn.argv(0)
    if first_arg ~= "" and vim.fn.isdirectory(first_arg) == 1 then
      vim.cmd("cd " .. vim.fn.fnameescape(first_arg))
    end
  end,
})

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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  desc = "Auto-reload buffer modified externally.",
  command = "if mode() != 'c' | checktime | endif",
})

-- QuickFix List Autoclose
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>:lclose<CR>", { buffer = true, silent = true })
  end,
})
