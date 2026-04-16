return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

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

        -- highlight = {
        --   enable = true,
        --   -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        --   -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        --   -- Using this option may slow down your editor, and you may see some duplicate highlights.
        --   -- Instead of true it can also be a list of languages
        --   additional_vim_regex_highlighting = false,
        -- },
        -- indent = {
        --   enable = true,
        --   disable = { "yaml" },
        -- },
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
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension "ui-select"
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "MagicDuck/grug-far.nvim",
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require("grug-far").setup {
        -- options, see Configuration section below
        -- there are no required options atm
      }
    end,
  },
}
