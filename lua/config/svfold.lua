local M = {}

local cache = {}

local open_patterns = {
	"%f[%w_]module%f[^%w_$]",
	"%f[%w_]interface%f[^%w_$]",
	"%f[%w_]package%f[^%w_$]",
	"%f[%w_]class%f[^%w_$]",
	"%f[%w_]function%f[^%w_$]",
	"%f[%w_]task%f[^%w_$]",
	"%f[%w_]generate%f[^%w_$]",
	"%f[%w_]begin%f[^%w_$]",
	"%f[%w_]case%f[^%w_$]",
	"%f[%w_]fork%f[^%w_$]",
}

local close_patterns = {
	"%f[%w_]endmodule%f[^%w_$]",
	"%f[%w_]endinterface%f[^%w_$]",
	"%f[%w_]endpackage%f[^%w_$]",
	"%f[%w_]endclass%f[^%w_$]",
	"%f[%w_]endfunction%f[^%w_$]",
	"%f[%w_]endtask%f[^%w_$]",
	"%f[%w_]endgenerate%f[^%w_$]",
	"%f[%w_]endcase%f[^%w_$]",
	"%f[%w_]join_any%f[^%w_$]",
	"%f[%w_]join_none%f[^%w_$]",
	"%f[%w_]join%f[^%w_$]",
	"%f[%w_]end%f[^%w_$]",
}

local function strip_comments_and_strings(line, in_block_comment)
	local out = {}
	local i = 1

	while i <= #line do
		local two = line:sub(i, i + 1)

		if in_block_comment then
			if two == "*/" then
				in_block_comment = false
				i = i + 2
			else
				i = i + 1
			end
		elseif two == "//" then
			break
		elseif two == "/*" then
			in_block_comment = true
			i = i + 2
		elseif line:sub(i, i) == '"' then
			i = i + 1
			while i <= #line do
				local char = line:sub(i, i)
				if char == "\\" then
					i = i + 2
				elseif char == '"' then
					i = i + 1
					break
				else
					i = i + 1
				end
			end
		else
			out[#out + 1] = line:sub(i, i)
			i = i + 1
		end
	end

	return table.concat(out), in_block_comment
end

local function count_patterns(line, patterns)
	local count = 0

	for _, pattern in ipairs(patterns) do
		local init = 1
		while true do
			local start_pos, end_pos = line:find(pattern, init)
			if not start_pos then
				break
			end

			count = count + 1
			init = end_pos + 1
		end
	end

	return count
end

local function build_cache(bufnr)
	local changedtick = vim.b[bufnr].changedtick
	local cached = cache[bufnr]

	if cached and cached.changedtick == changedtick then
		return cached
	end

	local levels = {}
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local level = 0
	local in_block_comment = false

	for index, raw_line in ipairs(lines) do
		local line
		line, in_block_comment = strip_comments_and_strings(raw_line, in_block_comment)

		if line:match("^%s*`") then
			line = ""
		end

		local opens = count_patterns(line, open_patterns)
		local closes = count_patterns(line, close_patterns)
		local line_level = level

		if opens > 0 and closes == 0 then
			line_level = level + opens
		end

		levels[index] = math.max(line_level, 0)
		level = math.max(level + opens - closes, 0)
	end

	cached = {
		changedtick = changedtick,
		levels = levels,
	}
	cache[bufnr] = cached

	return cached
end

function M.foldexpr(lnum)
	local bufnr = vim.api.nvim_get_current_buf()
	local cached = build_cache(bufnr)

	return cached.levels[lnum] or 0
end

function M.setup()
	vim.filetype.add({
		extension = {
			v = "verilog",
			vh = "verilog",
			sv = "systemverilog",
			svh = "systemverilog",
		},
	})

	local group = vim.api.nvim_create_augroup("SystemVerilogFolding", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = { "verilog", "systemverilog" },
		callback = function()
			vim.opt_local.foldmethod = "expr"
			vim.opt_local.foldexpr = "v:lua.require'config.svfold'.foldexpr(v:lnum)"
			vim.opt_local.foldlevel = 99
			vim.opt_local.foldenable = true
			vim.opt_local.foldcolumn = "1"
		end,
	})
end

return M
