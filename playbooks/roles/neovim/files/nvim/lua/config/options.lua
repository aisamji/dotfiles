vim.g.mapleader = " "
vim.g.maplocalleader = ";"
vim.o.number = true
vim.o.scrolloff = 8
vim.o.tabstop = 4
vim.o.softtabstop = -1
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.mouse = ""
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.completeopt = "menu,menuone,noselect"

require("vim._core.ui2").enable()
