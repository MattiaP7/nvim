return {

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern", -- 'classic' | 'modern' | 'helix'
			delay = 500,
			plugins = {
				spelling = {
					enabled = true,
					suggestions = 20,
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Local keymaps",
			},
		},
	},
	{
		"https://github.com/m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup()
		end,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {},
		version = "^1.0.0",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			signcolumn = true, -- mostra i segni nella signcolumn
			numhl = false, -- evidenzia il numero di linea
			linehl = false, -- evidenzia l’intera linea
			current_line_blame = true, -- mostra autore e commit sulla linea corrente
			current_line_blame_opts = {
				delay = 300,
				virt_text_pos = "eol",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},
	{
		"danymat/neogen",
		version = "*",
		config = function()
			require("neogen").setup()
		end,
	},
	{
		-- if your at the begin of a function use 'h' for folding it, use 'l' for expand it.
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {}, -- needed even when using default config

		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
		event = "VeryLazy",
		config = function()
			require("dressing").setup({
				input = {
					get_config = function()
						-- disable for nvim tree
						if vim.api.nvim_buf_get_option(0, "filetype") == "NvimTree" then
							return { enabled = false }
						end
					end,
				},
			})
		end,
	},
}
