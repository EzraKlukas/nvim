return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            local languages = {
                "c",
                "cpp",
                "rust",
                "toml",
                "lua",
                "cmake",
                "make",
                "bash",
                "python",
                "markdown",
                "markdown_inline",
            }

            ts.setup({})

            pcall(function()
                ts.install(languages)
            end)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = languages,
                callback = function()
                    local ok = pcall(vim.treesitter.start)

                    if ok then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
}
