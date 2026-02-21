return {
    {
        'sindrets/winshift.nvim',
        branch = 'main',
        keys = {
            { mode = "n", "<leader>ww", vim.cmd.WinShift },
        },
    },
}
