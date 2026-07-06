return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- C / C++
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
					"--cross-file-rename",
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			})

			vim.lsp.enable("clangd")

			-- Rust
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						check = {
							command = "clippy",
						},
						diagnostics = {
							enable = true,
						},
					},
				},
			})

			vim.lsp.enable("rust_analyzer")
		end,
	},
}
