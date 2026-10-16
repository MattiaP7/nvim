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
			-- AGGIUNGI QUESTO BLOCCO PER LE LINEE DI PROFONDITÀ
			renderer = {
				indent_markers = {
					enable = true,
					icons = {
						corner = "└ ",
						edge = "│ ",
						none = "  ",
					},
				},
				group_empty = true,
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
			-- AGGIUNGI QUESTO BLOCCO PER GLI INDICATORI DI DIAGNOSTICA
			diagnostics = {
				enable = true, -- Abilita la visualizzazione
				show_on_dirs = true, -- Mostra l'icona anche sulle cartelle
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			filters = {
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				custom = {
					".git",
					"node_modules",
					".cache",
					"__cmake_systeminformation",
				},
				exclude = {},
				git_ignored = false,
			},
		})
	end,
}
