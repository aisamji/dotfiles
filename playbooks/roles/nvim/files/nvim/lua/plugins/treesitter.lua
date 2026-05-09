return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            -- Treesitter Custom Parsers
            require("nvim-treesitter.parsers").starlark = {
                install_info = {
                    url = "https://github.com/tree-sitter-grammars/tree-sitter-starlark",
                    files = { "src/parser.c", "src/scanner.c" },
                    branch = "master",
                },
            }

            vim.api.nvim_create_autocmd('FileType', {
                pattern = '*',
                callback = function(event)
                    local lang = vim.treesitter.language.get_lang(event.match)
                    if lang then
                        require('nvim-treesitter').install(lang)
                    end
                end,
            })

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
