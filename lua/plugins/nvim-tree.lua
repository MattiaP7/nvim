return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 30,
				side = "left",
			},
			renderer = {

				hidden_display = "all",
				icons = {
					git_placement = "before",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						default = "󰈚",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			filters = {
				dotfiles = false, -- Questo mostra i file che iniziano col punto
				git_clean = false,
				no_buffer = false,
				custom = {
					".git",
					"node_modules",
					".cache",
					"__cmake_systeminformation", -- Ignora le verifiche di sistema CMake
				},
				exclude = {},
				git_ignored = false, -- AGGIUNGI QUESTO: mostra i file ignorati da git (come .env)
			},
		})
	end,
}
