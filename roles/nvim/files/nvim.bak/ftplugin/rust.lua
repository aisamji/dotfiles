vim.keymap.set("n", "<localleader>c", ":tab terminal cargo check<CR>G",
    { desc = "Compile Code", silent = true })
vim.keymap.set("n", "<localleader>x", ":tab terminal cargo run<CR>i",
    { desc = "Execute Cargo binary", silent = true })
vim.keymap.set("n", "<localleader>t", ":tab terminal cargo test<CR>G",
    { desc = "Run Test Suite", silent = true })
vim.keymap.set("n", "<localleader>T", ":tab terminal cargo test -- --include-ignored<CR>G",
    { desc = "Run Test Suite", silent = true })
