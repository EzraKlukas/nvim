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
			-- Verilog / SystemVerilog
			vim.lsp.config("svlangserver", {
				cmd = { "svlangserver" },
				filetypes = { "verilog", "systemverilog" },
				root_markers = { ".svlangserver", ".git" },
				settings = {
					systemverilog = {
						includeIndexing = {
							"source/hdl/**/*.{v,vh,sv,svh}",
							"source/tests/**/*.{v,vh,sv,svh}",
						},
						excludeIndexing = {
							"IP/**/*.{v,vh,sv,svh}",
							"build/**/*.{v,vh,sv,svh}",
							"Vivado_CtrlSysV4/**/*.{v,vh,sv,svh}",
							"**/.git/**",
							"**/build/**",
							"**/.Xil/**",
							"**/sim/**",
							"**/xsim.dir/**",
							"**/ip_user_files/**",
						},
						defines = {},
						launchConfiguration = "verilator --sv --lint-only --Wall",
						formatCommand = "verible-verilog-format",
					},
				},
			})

			vim.lsp.enable("svlangserver")
		end,
	},
}
