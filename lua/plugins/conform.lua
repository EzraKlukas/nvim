return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
				rust = { "rustfmt" },
				lua = { "stylua" },
				verilog = { "verible" },
				systemverilog = { "verible" },
			},
			formatters = {
				verible = {
					prepend_args = {
						"--column_limit=100",
						"--indentation_spaces=4",
					},
				},
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
		},
	},
}
