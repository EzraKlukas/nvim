local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<M-l>", ":bnext<CR>", { silent = true })
map("n", "<M-h>", ":bprevious<CR>", { silent = true })
map("n", "<Leader>bd", ":bp | sp | bn | bd<CR>", { silent = true, desc = "Delete buffer keeping layout" })

-- Verilog / SystemVerilog helpers
map("n", "<leader>vf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format HDL buffer" })

map("n", "<leader>vv", ":w<CR>:!verilator --sv --lint-only --Wall %<CR>", {
	desc = "Verilator lint current HDL file",
})

map("n", "<leader>vl", ":w<CR>:!verible-verilog-lint %<CR>", {
	desc = "Verible lint current HDL file",
})

map("n", "<leader>vi", ":LspSvlangserverBuildIndex<CR>", {
	desc = "SystemVerilog build index",
})

-- Rust / Cargo commands
map("n", "<leader>rr", ":w<CR>:!cargo run<CR>", {
	desc = "Cargo run",
})

map("n", "<leader>rb", ":w<CR>:!cargo build<CR>", {
	desc = "Cargo build",
})

map("n", "<leader>rc", ":w<CR>:!cargo check<CR>", {
	desc = "Cargo check",
})

map("n", "<leader>rt", ":w<CR>:!cargo test<CR>", {
	desc = "Cargo test",
})

map("n", "<leader>rl", ":w<CR>:!cargo clippy<CR>", {
	desc = "Cargo clippy",
})

map("n", "<leader>rf", ":w<CR>:!cargo fmt<CR>", {
	desc = "Cargo fmt",
})

-- lsp keybindings
map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "gr", vim.lsp.buf.references, opts)

map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<C-k>", vim.lsp.buf.signature_help, opts)

map("n", "<leader>cc", ":w<CR>:!g++ -std=c++20 -Wall -Wextra -g % -o %:r<CR>", {
	desc = "Compile current C++ file",
})

vim.keymap.set("n", "<leader>cr", ":!./%:r<CR>", {
	desc = "Run compiled C++ file",
})

vim.keymap.set("n", "<leader>cb", ":w<CR>:!cmake --build build<CR>", {
	desc = "CMake build",
})

vim.keymap.set("n", "<leader>ct", ":!ctest --test-dir build --output-on-failure<CR>", {
	desc = "Run CTest",
})

vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()", {
	desc = "Code action",
})

-- lsp-config keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.keymap.set("n", "<leader>oi", function()
	local line = vim.api.nvim_get_current_line()
	local current_dir = vim.fn.expand("%:p:h")
	local cwd = vim.fn.getcwd()

	local candidates = {}

	-- Obsidian/wiki image syntax:
	-- ![[Pasted image 20260423225922.png]]
	-- ![[custom-name.png]]
	local wiki_img = line:match("!%[%[([^%]]+)%]%]")
	if wiki_img then
		table.insert(candidates, wiki_img)
	end

	-- Markdown image syntax:
	-- ![](attachments/image.png)
	-- ![alt text](attachments/image.png)
	local md_img = line:match("!%[[^%]]*%]%(([^%)]+)%)")
	if md_img then
		table.insert(candidates, md_img)
	end

	-- Fallback: word/path under cursor
	local cfile = vim.fn.expand("<cfile>")
	if cfile and cfile ~= "" then
		table.insert(candidates, cfile)
	end

	local search_dirs = {
		current_dir,
		current_dir .. "/attachments",
		cwd,
		cwd .. "/attachments",
	}

	for _, img in ipairs(candidates) do
		-- remove URL-style escapes for spaces
		img = img:gsub("%%20", " ")

		-- absolute path
		if vim.fn.filereadable(img) == 1 then
			vim.fn.jobstart({ "imv", img }, { detach = true })
			return
		end

		-- relative path candidates
		for _, dir in ipairs(search_dirs) do
			local path = dir .. "/" .. img
			if vim.fn.filereadable(path) == 1 then
				vim.fn.jobstart({ "imv", path }, { detach = true })
				return
			end
		end
	end

	print("Image not found")
end, { desc = "Open image under cursor" })
