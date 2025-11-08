-- File: lua/plugins/toggleterm.lua (o dove gestisci i tuoi plugin)

return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		local toggleterm = require('toggleterm')

		toggleterm.setup({
			-- === Impostazioni Globali ===
			size = 20,             -- Altezza predefinita per i terminali a scomparsa (split)
			open_mapping = [[<c-\>]], -- La mappatura predefinita per il toggle (non è obbligatoria)
			direction = 'float',   -- Direzione predefinita per il terminale principale
			terminal_mappings = true, -- Permette l'uso di <c-\> per uscire dalla modalità terminale (t-mode)
			shade_terminals = true, -- Scurisce un po' lo sfondo del terminale
			start_in_insert = true, -- Inizia in modalità inserimento
			hide_numbers = true,   -- Nasconde i numeri di riga nel terminale
			close_on_exit = true,  -- Chiude la finestra se il comando termina (es. 'ls' e poi chiude)

			-- Configurazione per il terminale flottante (quello principale)
			float_opts = {
				shell = "pwsh",
				border = 'rounded',
				winblend = 0, -- Rende la finestra opaca (0-100)
				highlights = {
					border = "Normal",
					background = "Normal",
				}
			},


			{
				name = 'main_float_terminal',
				direction = 'float', -- 'vertical' | 'float' | 'tab' | 'horizontal'
				hidden = true
			},

		})

		-- Funzione helper per il toggle dei terminali specifici
		_G.set_terminal_keymaps = function()
			-- Mappa per uscire dalla modalità terminale e tornare alla modalità normale (come facevi tu)
			-- Questo è CRUCIALE per non distruggere la sessione!
			vim.api.nvim_buf_set_keymap(0, 't', '<esc><esc>', [[<C-\><C-n>]], {
				noremap = true,
				silent = true,
				desc = "Passa alla Modalita' Normale"
			})

			-- Mappa per chiudere il terminale (solo se sei in Modalità Normale (C-\ C-n))
			-- In questo modo, il terminale viene *nascosto* (hidden), non distrutto!
			vim.api.nvim_buf_set_keymap(0, 't', '<leader>h', [[<C-\><C-n><cmd>ToggleTerm<CR>]], {
				noremap = true,
				silent = true,
				desc = "Chiudi Terminale (Toggle)"
			})

			-- Mappa alternativa, spesso più comoda per chiudere subito
			vim.api.nvim_buf_set_keymap(0, 't', '<C-c>', [[<C-\><C-n>]], {
				noremap = true,
				silent = true,
				desc = "Esci dalla modalita' terminale"
			})
		end

		-- Ogni volta che si apre un terminale di toggleterm, imposta i keymaps
		vim.cmd('autocmd TermOpen term://* lua set_terminal_keymaps()')
	end
}
