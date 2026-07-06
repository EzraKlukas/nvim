local term_count = 0

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		term_count = term_count + 1
		vim.cmd("file terminal-" .. term_count)
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.dat",
	command = "set filetype=text", -- change to csv or yaml if applicable
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
	end,
})
