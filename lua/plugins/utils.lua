return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix", -- 'classic' | 'modern' | 'helix'
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
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				enable_check_bracket_line = true,
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
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
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		config = function()
			local function lsp_status()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if #clients == 0 then
					return ""
				end

				local names = {}
				for _, client in ipairs(clients) do
					if client.name ~= "null-ls" and client.name ~= "none-ls" then
						table.insert(names, client.name)
					end
				end

				if #names == 0 then
					return ""
				end

				return "󰒋 " .. table.concat(names, ", ")
			end

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = {
						statusline = { "dashboard", "alpha", "starter" },
					},
					component_separators = {
						left = "│",
						right = "│",
					},
					section_separators = {
						left = "",
						right = "",
					},
					icons_enabled = true,
					always_divide_middle = true,
					always_show_tabline = false,
				},

				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return str:upper()
							end,
						},
					},

					lualine_b = {
						{
							"branch",
							icon = "",
						},
						{
							"diff",
							symbols = {
								added = " ",
								modified = " ",
								removed = " ",
							},
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							sections = { "error", "warn", "info", "hint" },
							symbols = {
								error = " ",
								warn = " ",
								info = " ",
								hint = "󰌵 ",
							},
							colored = true,
							update_in_insert = false,
							always_visible = false,
						},
					},

					lualine_c = {
						{
							"filename",
							path = 1,
							symbols = {
								modified = " ●",
								readonly = " 󰌾",
								unnamed = "[No Name]",
								newfile = "  ",
							},
							color = { gui = "bold" },
						},
						{
							lsp_status,
							color = { gui = "italic" },
						},
					},

					lualine_x = {
						{
							"encoding",
							fmt = function(str)
								return str:upper()
							end,
						},
						"fileformat",
						{
							"filetype",
							icon_only = false,
						},
					},

					lualine_y = {
						{
							"progress",
							separator = " ",
						},
					},

					lualine_z = {
						{
							"location",
							fmt = function(str)
								return "Ln/Col " .. str
							end,
						},
					},
				},
			})
		end,
	},

	{
		-- if your at the begin of a function use 'h' for folding it, use 'l' for expand it.
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {
			autoFold = {
				enabled = false,
			},
		}, -- needed even when using default config

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
