return {
    {
        "saghen/blink.cmp",
        version = "1.*",

        opts = {
            keymap = {
                preset = "none",

                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },

                ["<CR>"] = { "accept", "fallback" }, -- Enter to confirm

                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            snippets = {
                preset = "luasnip",
            },
        },
    },
}
