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
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

      parser_configs.starlark = {
        install_info = {
          url = "https://github.com/tree-sitter-grammars/tree-sitter-starlark",
          files = { "src/parser.c", "src/scanner.c" },
          -- files = { '/path/to/tree_sitter_starlark.so' },
          branch = "master",
        },
      }

      local configs = require "nvim-treesitter.configs"
      -- TODO: Use this as default
      -- require "nvchad.configs.treesitter"

      configs.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = {
          "lua",
          "luadoc",
          " vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
          "yaml",
          "toml",
          "gitcommit",
          "gitignore",
          "git_config",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,

        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = { "yaml" },
        },
      }

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
}
