return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			preset = "obsidian",

			bullet = {
				right_pad = 1,
			},

			checkbox = {
				right_pad = 1,

				custom = {
					todo = {
						raw = "[-]",
						rendered = "◐ ",
						highlight = "RenderMarkdownTodo",
					},

					cancelled = {
						raw = "[~]",
						rendered = "× ",
						highlight = "Comment",
					},

					important = {
						raw = "[!]",
						rendered = "! ",
						highlight = "RenderMarkdownWarn",
					},

					forwarded = {
						raw = "[>]",
						rendered = "→ ",
						highlight = "RenderMarkdownInfo",
					},
				},
			},

			quote = {
				icon = "│ ",
			},

			completions = {
				lsp = {
					enabled = true,
				},
			},
		},
	},
}
