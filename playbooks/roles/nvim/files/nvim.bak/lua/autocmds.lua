-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = 'Auto create directory upon file write.',
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Disable LSP semantic tokens
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Disable LSP semantic highlights',
    callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = id and vim.lsp.get_client_by_id(id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

-- Cursorline and RelativeLineNumbers on active buffer
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
    desc = 'Turn on aesthetics for active buffer.',
    callback = function(_)
        if vim.wo.number then
            vim.wo.relativenumber = vim.api.nvim_get_mode().mode ~= 'i'
            vim.wo.cursorline = vim.api.nvim_get_mode().mode ~= 'i'
        end
    end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
    desc = 'Turn off aesthetics for inactive buffer.',
    callback = function(_)
        if vim.wo.number then
            vim.wo.relativenumber = false
            vim.wo.cursorline = false
        end
    end,
})
