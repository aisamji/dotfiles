return {
    {
        'sindrets/winshift.nvim',
        keys = {
            { mode = "n", "<leader>W", vim.cmd.WinShift, desc = "Activate WinShift" },
        },
        cmd = {
            "WinShift",
        },
        branch = 'main',
    },
}
