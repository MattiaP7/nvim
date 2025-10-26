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
				icons = {
					git_placement = "before",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						git = {
							unstaged = "✗",
							staged = "✓",
							untracked = "★",
						},	
					},
				}
			},
			filters = {
				dotfiles = false,
			},
		})
  end,
}
