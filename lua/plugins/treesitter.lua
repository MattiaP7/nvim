return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- 1. Forza le variabili d'ambiente per l'eseguibile tree-sitter CLI
		vim.env.CC = "gcc"
		vim.env.CXX = "g++"

		-- 2. Fallback per il sistema di installazione Lua
		require("nvim-treesitter.install").compilers = { "gcc" }

		require("nvim-treesitter").setup({
			sync_install = false,
			ensure_installed = {
				"lua",
				"c",
				"cpp",
				"python",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
				"query",
				"typescript",
				"tsx",
				"javascript",
				"jsx",
			},
			ignore_install = {},
			modules = {},
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "c", "cpp" },
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
				},
			},
		})
	end,
}
