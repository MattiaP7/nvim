return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},

	{ "RRethy/base16-nvim", lazy = false, priority = 1000 },

	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		-- config = true,
		opts = {
			terminal_colors = true,
			transparent_mode = false,
			dim_inactive = false,
			overrides = {
				NvimTreeNormal = { link = "Normal" },
				NvimTreeNormalNC = { link = "Normal" },
				NvimTreeEndOfBuffer = { link = "EndOfBuffer" },
			},
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)
		end,
	},

	{ "Mofiqul/dracula.nvim" },

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 900,
	},

	{
		"tiagovla/tokyodark.nvim",
		opts = {
			-- custom options here
		},
		config = function(_, opts)
			require("tokyodark").setup(opts) -- calling setup is optional
			vim.cmd([[colorscheme tokyodark]])
		end,
	},

	{
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 800,
	},

	{ "sainnhe/sonokai", lazy = true, event = "VeryLazy" },
	{ "vague2k/vague.nvim", lazy = true, event = "VeryLazy" },
	{ "rose-pine/neovim", lazy = true, event = "VeryLazy" },
	{ "ficd0/ashen.nvim", lazy = true, event = "VeryLazy" },
	{ "gmr458/vscode_modern_theme.nvim", lazy = true, event = "VeryLazy" },
}
