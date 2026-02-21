require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyzer", "yamlls", "basedpyright", "ruff", "taplo", "ts_ls" }

vim.lsp.config["basedpyright"] = {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { "*" },
      },
    },
  },
}

vim.lsp.config["ruff"] = {
  init_options = {
    settings = {
      lint = {
        ignore = { "F401" },
      },
    },
  },
}

vim.lsp.config["rust_analyzer"] = {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        command = "clippy",
        extra_args = { "--no-deps" },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers
