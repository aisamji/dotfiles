return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = "shut-up",
				completion = {
					always = true,
				},
				keymap = {
					recommended = false,
				},
			}
		end,
        build = function()
			vim.cmd.COQdeps()
        end,
		config = function()
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						check = {
							-- Disable clippy due to clippy not showing errors beyond the first in the workspace.
							-- command = "clippy"
							command = "check",
						},
					},
				},
			})
			require("mason").setup()
			require("mason-lspconfig").setup()
			vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and "; " or ":") .. vim.env.PATH
			vim.keymap.set("n", "=", vim.lsp.buf.format)

            -- Configure COQ
			require("coq_3p")({
				{ src = "nvimlua", short_name = "NVIM" },
				{
					src = "repl",
					sh = "bash",
					shell = { p = "python3" },
					max_lines = 99,
					deadline = 500,
					unsafe = { "rm", "poweroff", "mv" },
				},
				{ src = "bc", short_name = "MATH", precision = 6 },
			})
		end,
	},
}
