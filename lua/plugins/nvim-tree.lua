return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>E", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
	},
	config = function()
		---@type nvim_tree.config
		local config = {
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		}

		require("nvim-tree").setup(config)
	end,
}
