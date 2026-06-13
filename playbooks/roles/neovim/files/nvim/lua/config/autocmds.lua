-- Cursorline and RelativeLineNumbers on active buffer
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "WinEnter" }, {
    desc = "Turn on aesthetics for active buffer.",
    callback = function(_)
        if vim.wo.number then
            vim.wo.relativenumber = true
            vim.wo.cursorline = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
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

vim.api.nvim_create_autocmd("User", {
    pattern = { "LazyUpdate", "LazyInstall", "LazyClean" },
    desc = "Commit lazy-lock to dotfiles repo.",
    callback = function(_)
        local src_file = vim.fn.expand "~/.config/nvim/lazy-lock.json"
        local dest_file = vim.fn.expand "~/.dotfiles/playbooks/roles/neovim/files/nvim/lazy-lock.json"
        local dotfiles_repo = vim.fn.expand "~/.dotfiles"

        -- These events are triggered before the lock file is updated, resulting in no diff.
        -- So vim.schedule will trigger this function on the next event, by which time the lock file will be updated.
        vim.schedule(function()
            if not vim.uv.fs_stat(dest_file) or (vim.fn.system { "diff", src_file, dest_file } ~= "") then
                vim.uv.fs_copyfile(src_file, dest_file, { excl = false, ficlone = false, ficlone_force = false })
                vim.fn.system { "git", "-C", dotfiles_repo, "add", dest_file }
                vim.fn.system { "git", "-C", dotfiles_repo, "commit", "-m", "chore(neovim): lazy update" }
            end
        end)
    end,
})
