-- TODO: Find a way to make colorschemes truly lazy-loaded
return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = true,
    },
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme carbonfox]])
        end,
        opts = {
            options = {
                dim_inactive = true,
                transparent = false,
                styles = {
                    comments = "italic",
                    keywords = "bold",
                    types = "italic,bold",
                },
                inverse = { -- Inverse highlight for different types
                    match_paren = false,
                    visual = false,
                    search = false,
                },
            },
        },
    },
}
