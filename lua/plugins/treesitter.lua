return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require('nvim-treesitter.configs').setup({
			sync_install = true,
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
				"markdown",
				"markdown_inline"
			},
			ignore_install = {},
			modules = {},
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "c", "cpp" },
				use_languagetree = true,
				additional_vim_regex_highlighting = false
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
