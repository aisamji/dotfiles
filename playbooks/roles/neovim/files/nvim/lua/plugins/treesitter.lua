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
                    queries = "queries",
                    generate_from_json = false,
                    files = { "src/parser.c", "src/scanner.c" },
                    branch = "master",
                },
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function(event)
                    local lang = vim.treesitter.language.get_lang(event.match)
                    local parsers = require "nvim-treesitter.parsers"
                    local available = vim.tbl_keys(parsers)
                    if vim.tbl_contains(available, lang) then
                        require("nvim-treesitter").install(lang)
                    end
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "TSUpdate",
                callback = function()
                    vim.treesitter.start()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    -- vim.wo[0][0].foldmethod = "expr"
                end,
            })

            -- Custom Filetype Assocations
            vim.treesitter.language.register("starlark", "tiltfile")

            vim.filetype.add {
                extension = {
                    gotmpl = "gotmpl",
                    mdx = "markdown",
                    j2 = "jinja",
                },
                pattern = {
                    [".*/templates/.*%.tpl"] = "helm",
                    [".*/templates/.*%.ya?ml"] = "helm",
                    ["helmfile.*%.ya?ml"] = "helm",
                    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
                    -- [".*%.%w+%.j2"] = "jinja",
                },
            }
            -- Jinja injections
            vim.treesitter.query.add_directive("inject-jinja-host!", function(_, _, bufnr, _, metadata)
                local fname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
                local inner_fname = fname:match "(.+)%.j2"
                vim.print(inner_fname)
                local filetype = vim.filetype.match { filename = inner_fname }
                if not filetype then
                    return
                end
                local injected_parser = vim.treesitter.language.get_lang(filetype)
                if not injected_parser then
                    return
                end
                metadata["injection.language"] = injected_parser
            end, {})
        end,
    },
}
