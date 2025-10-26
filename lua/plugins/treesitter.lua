return {
	"nvim-treesitter/nvim-treesitter", 
	branch = 'master', 
	lazy = false, 
	build = ":TSUpdate",
	config = function()
		require('nvim-treesitter.configs').setup({
	ensure_installed = {
		"vim",
		"lua",
		"vimdoc",
		"html",
		"css",
		"c",
		"cpp",
		"javascript",
		"typescript",
		"tsx",
		"python",
	},
	highlight = {
		enable = true,
		disable = { "c", "cpp" }
	},
	indent = {
		enable = true
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<CR>',
			node_incremental = '<CR>',
			scope_incremental = '<S-CR>',
			node_decremental = '<BS>',
		},
	},
})
	end,
}
