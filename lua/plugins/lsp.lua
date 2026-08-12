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

			-- Treat FPGA constraint files as Tcl, and *.mk as Makefiles.
			vim.filetype.add({
				extension = {
					xdc = "tcl",
					sdc = "tcl",
					mk = "make",
				},
			})

			-- Tcl / Vivado Tcl / XDC / SDC
			vim.lsp.config("tcl_lsp", {
				cmd = {
					"python3",
					vim.fn.expand("~/.local/bin/tcl-lsp-server.pyz"),
				},
				filetypes = { "tcl" },
				root_markers = { ".git" },
				single_file_support = true,
				settings = {
					tclLsp = {
						dialect = "xilinx-eda-tcl",
					},
				},
			})

			vim.lsp.enable("tcl_lsp")

			-- GNU Make
			vim.lsp.config("make_ls", {
				cmd = {
					vim.fn.expand("~/.local/bin/make-ls"),
				},
				filetypes = { "make" },
				root_markers = {
					"Makefile",
					"makefile",
					"GNUmakefile",
					".git",
				},
				single_file_support = true,
			})

			vim.lsp.enable("make_ls")

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
							"*.{v,vh,sv,svh}",
							"**/*.{v,vh,sv,svh}",
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
							"build/**",
							".git/**",
							".nvim/svlangserver/**",
							".svlangserver/**",
						},
						defines = {},
						launchConfiguration = "verilator --sv --lint-only --Wall --timing",
						lintOnUnsaved = true,
						formatCommand = "verible-verilog-format",
					},
				},
			})

			vim.lsp.enable("svlangserver")
		end,
	},
}
