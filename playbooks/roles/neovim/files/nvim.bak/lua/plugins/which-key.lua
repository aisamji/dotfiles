return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>g", group = "git" },
            { "<leader>a", group = "ai" },
            { "<leader>w", group = "window" },
            { "<leader>r", group = "refactor" },
        })
    end
}
