return {
	{ 
		"https://github.com/folke/which-key.nvim", 
		event = "VeryLazy",
		opts = {},
		keys = {
			"<leader>?",
			config = function()
				local wk = require("which-key")
				wk.show({ global = false })
				wk.setup({
					preset = "classic",
					delay = 500,
					plugins = {
						spelling = { enabled = true, suggestions = 20, },
					},
				})
			end,
			desc = "Local keymaps",
		},
	},
	{ 
		"https://github.com/m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup()
		end,
	},
	{
  {
		'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', 
			'nvim-tree/nvim-web-devicons', 
		},
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    version = '^1.0.0',   },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add          = { text = "│" },
				change       = { text = "│" },
				delete       = { text = "_" },
				topdelete    = { text = "‾" },
				changedelete = { text = "~" },
			},
			signcolumn = true,  -- mostra i segni nella signcolumn
			numhl      = false, -- evidenzia il numero di linea
			linehl     = false, -- evidenzia l’intera linea
			current_line_blame = true, -- mostra autore e commit sulla linea corrente
			current_line_blame_opts = {
				delay = 300,
				virt_text_pos = "eol",
			},
		},
	},
	{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup()
		end,
	},
}
