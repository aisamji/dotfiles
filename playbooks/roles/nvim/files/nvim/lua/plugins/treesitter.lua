return {
  {
    "nvim-treesitter/nvim-treesitter",

    config = function()
      local configs = require "nvim-treesitter"
      configs.setup {
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
      }

      -- Treesitter Custom Parsers
      require("nvim-treesitter.parsers").starlark = {
        install_info = {
          url = "https://github.com/tree-sitter-grammars/tree-sitter-starlark",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }

      -- Custom Filetype Assocations
      vim.filetype.add {
        extension = {
          gotmpl = "gotmpl",
          mdx = "markdown",
        },
        pattern = {
          [".*/templates/.*%.tpl"] = "helm",
          [".*/templates/.*%.ya?ml"] = "helm",
          ["helmfile.*%.ya?ml"] = "helm",
          ["Tiltfile"] = "starlark",
        },
      }
    end,
  },
}
