return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	lazy = false,
	keys = {
		{
			"ff",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
	},
	config = function()
		require("fff").setup({
			base_path = vim.fn.getcwd(),
			-- ICONA NERD FONT: Una lente d'ingrandimento o una cartella stilizzata
			prompt = "   ", -- In alternativa: ' 󰍉 ', '  ' o '  '
			title = " FFFiles ",
			max_results = 100,
			layout = {
				height = 0.8,
				width = 0.8,
				prompt_position = "bottom",
				preview_position = "right",
				preview_size = 0.5,
				border = "rounded", -- Bordi arrotondati per il look moderno
			},
			-- INTEGRAZIONE COLORI TOKYO NIGHT
			hl = {
				border = "FloatBorder", -- Usa i bordi azzurrini di Tokyo Night
				normal = "NormalFloat", -- Sfondo coerente con i popup
				cursor = "Visual", -- Evidenziazione riga stile Tokyo Night
				matched = "TelescopeMatching", -- Colore arancio/oro per le lettere combacianti
				title = "Title",
				prompt = "Identifier", -- Prompt colorato (azzurro)
				directory_path = "Comment",
				-- Git colors (molto importanti per il tuo setup)
				git_modified = "DiagnosticWarn",
				git_staged = "DiagnosticInfo",
				git_untracked = "DiagnosticHint",
			},
			keymaps = {
				close = "<Esc>",
				select = "<CR>",
				move_up = { "<Up>", "<C-p>" },
				move_down = { "<Down>", "<C-n>" },
			},
		})
	end,
}
