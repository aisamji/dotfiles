return {
    {
        "MagicDuck/grug-far.nvim",
        opts = {},
    },
    {
        'fei6409/log-highlight.nvim',
        ft = { "log" },
        config = true,
    },
    {
        "j-hui/fidget.nvim",
        tag = "v1.6.1",
        opts = {
            notification = {
                override_vim_notify = true,
            },
        },
    },
    -- {
    --     'ms-jpq/chadtree',
    --     branch = 'chad',
    --     build = function()
    --         vim.cmd.CHADdeps()
    --     end
    -- },
}
