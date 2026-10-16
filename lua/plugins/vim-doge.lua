-- ~/.config/nvim/lua/plugins/vim-doge.lua
return {
	"kkoomen/vim-doge",
	-- Esegue l'installazione del binario helper dopo l'installazione del plugin
	build = ":call doge#install()",
	-- Non caricare immediatamente, carica su richiesta tramite keymap
	event = { "BufReadPre", "BufNewFile" },
	-- Disabilita i keymap predefiniti, definisci manualmente per evitare conflitti
	init = function()
		vim.g.doge_enable_mappings = 0
	end,
	config = function()
		-- ==================== Specifiche della documentazione per linguaggio ====================
		-- C/C++: usa stile Doxygen (puoi anche scegliere kernel_doc o doxygen_qt)
		vim.g.doge_doc_standard_c = "doxygen_javadoc"
		vim.g.doge_doc_standard_cpp = "doxygen_javadoc"

		-- JavaScript/TypeScript: stile JSDoc
		vim.g.doge_doc_standard_javascript = "jsdoc"

		-- Python: puoi scegliere reST (predefinito), numpy, google, sphinx, doxygen
		vim.g.doge_doc_standard_python = "google"

		-- Lua: LDoc
		vim.g.doge_doc_standard_lua = "ldoc"

		-- ==================== Impostazioni specifiche per linguaggio ====================
		-- Carattere dei tag Doxygen: usa '@' o '\'
		vim.g.doge_doxygen_settings = { char = "@" }

		-- Impostazioni JavaScript: genera doc per destructuring, non omettere il tipo dei parametri
		vim.g.doge_javascript_settings = {
			destructuring_props = 1,
			omit_redundant_param_types = 0,
		}

		-- Impostazioni Python: non usare virgolette singole, omettere il tipo dei parametri ridondante
		vim.g.doge_python_settings = {
			single_quotes = 0,
			omit_redundant_param_types = 1,
		}

		-- ==================== Keymap ====================
		-- Genera commento di documentazione (modalità normale)
		vim.keymap.set(
			"n",
			"<Leader>nf",
			"<Plug>(doge-generate)",
			{ silent = true, desc = "Genera commento di documentazione" }
		)

		-- Salto interattivo tra segnaposto TODO (modalità normale/inserimento/selezione)
		local jump_opts = { silent = true, desc = "Salta al prossimo segnaposto" }
		vim.keymap.set("n", "<Tab>", "<Plug>(doge-comment-jump-forward)", jump_opts)
		vim.keymap.set("n", "<S-Tab>", "<Plug>(doge-comment-jump-backward)", jump_opts)
		vim.keymap.set("i", "<Tab>", "<Plug>(doge-comment-jump-forward)", jump_opts)
		vim.keymap.set("i", "<S-Tab>", "<Plug>(doge-comment-jump-backward)", jump_opts)
		vim.keymap.set("x", "<Tab>", "<Plug>(doge-comment-jump-forward)", jump_opts)
		vim.keymap.set("x", "<S-Tab>", "<Plug>(doge-comment-jump-backward)", jump_opts)
	end,
}
