local filename = vim.fn.expand("%:t")
if filename == "Cargo.toml" then
    vim.cmd.runtime({ "ftplugin/rust.lua", bang = true })
end
