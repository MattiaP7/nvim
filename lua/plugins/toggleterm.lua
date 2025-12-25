return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")

		toggleterm.setup({
			size = 20,
			-- Mappatura universale predefinita (Ctrl + \)
			open_mapping = [[<c-\>]],
			direction = "float",
			shade_terminals = true,
			start_in_insert = true,
			hide_numbers = true,
			close_on_exit = true,
			float_opts = {
				border = "rounded",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		-- Funzione per gestire i tasti QUANDO IL TERMINALE È APERTO
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }

			-- Esci dalla modalità "scrittura" ed entra in modalità "normale" di Neovim
			-- Usiamo due volte Esc per non interferire con i singoli Esc dei programmi shell
			vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], opts)

			-- CHIUDERE il terminale mentre sei in modalità inserimento
			-- Ho cambiato <leader>h in <C-h> (Ctrl+h) per evitare che lo "spazio" blocchi la scrittura
			vim.keymap.set("t", "<C-h>", [[<C-\><C-n><cmd>ToggleTerm<CR>]], opts)

			-- Navigazione rapida tra finestre (anche dal terminale)
			vim.keymap.set("t", "<C-w>h", [[<C-\><C-n><C-w>h]], opts)
			vim.keymap.set("t", "<C-w>j", [[<C-\><C-n><C-w>j]], opts)
			vim.keymap.set("t", "<C-w>k", [[<C-\><C-n><C-w>k]], opts)
			vim.keymap.set("t", "<C-w>l", [[<C-\><C-n><C-w>l]], opts)
		end

		-- Applica le mappature sopra solo quando si apre un terminale
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
