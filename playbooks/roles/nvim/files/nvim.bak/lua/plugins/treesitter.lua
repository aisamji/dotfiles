return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

            parser_configs.starlark = {
                install_info = {
                    url = 'https://github.com/tree-sitter-grammars/tree-sitter-starlark',
                    files = { 'src/parser.c', 'src/scanner.c' },
                    -- files = { '/path/to/tree_sitter_starlark.so' },
                    branch = 'master'
                },
            }

            local configs = require("nvim-treesitter.configs")

            configs.setup {
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

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
                    disable = { 'yaml' },
                },

            }

            vim.filetype.add({
                extension = {
                    gotmpl = 'gotmpl',
                },
                pattern = {
                    [".*/templates/.*%.tpl"] = "helm",
                    [".*/templates/.*%.ya?ml"] = "helm",
                    ["helmfile.*%.ya?ml"] = "helm",
                    ["Tiltfile"] = "starlark",
                },
            })
        end
    },
    {
        "davidmh/mdx.nvim",
        config = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
}
