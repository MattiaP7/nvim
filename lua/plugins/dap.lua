return {
	-- nvim-dap core
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- DAP UI e dipendenze
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			-- Visualizzazione testo virtuale (visualizza i valori delle variabili inline)
			{ "theHamsta/nvim-dap-virtual-text", opts = {} },
			-- Gestione integrazione Mason
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = {
					"williamboman/mason.nvim",
					"mfussenegger/nvim-dap",
				},
				opts = {
					-- Installazione automatica dell'adapter codelldb
					ensure_installed = { "codelldb" },
					-- Non utilizzare la configurazione automatica degli handler, gestita manualmente
					handlers = {},
				},
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- ============================================================
			-- 1. Configurazione DAP UI (versione migliorata)
			-- ============================================================
			dapui.setup({
				icons = { expanded = "", collapsed = "", current_frame = "" },
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "right",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "single",
					mappings = { close = { "q", "<Esc>" } },
				},
				windows = { indent = 1 },
				render = {
					max_value_lines = 100,
				},
			})

			-- Apertura/chiusura automatica di DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- ============================================================
			-- 2. Configurazione adapter codelldb
			-- ============================================================
			-- Ottieni il percorso di installazione di codelldb
			local mason_registry = require("mason-registry")
			local codelldb_pkg = mason_registry.get_package("codelldb")
			local codelldb_path = codelldb_pkg:get_install_path()

			-- Metodo 1: utilizzare type = "executable" (consigliato per codelldb >= 1.11.0)
			dap.adapters.codelldb = {
				type = "executable",
				command = codelldb_path .. "/extension/adapter/codelldb.exe",
				-- Su Windows potrebbe essere necessario decommentare la riga seguente
				detached = false,
			}

			-- Metodo 2: se si utilizza una versione precedente, utilizzare il metodo server
			-- dap.adapters.codelldb = {
			-- 	type = "server",
			-- 	port = "${port}",
			-- 	executable = {
			-- 		command = vim.fn.stdpath("data") .. "/mason/bin/codelldb.cmd",
			-- 		args = { "--port", "${port}" },
			-- 		detached = false,
			-- 	},
			-- }

			-- ============================================================
			-- 3. Configurazione di debug C/C++
			-- ============================================================
			local codelldb_config = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Percorso eseguibile: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					-- Instrada l'output del programma nella console DAP, altrimenti non sarà visibile su Windows
					terminal = "integrated",
				},
				{
					name = "Attach to process",
					type = "codelldb",
					request = "attach",
					pid = function()
						local pid = vim.fn.input("PID: ")
						return tonumber(pid)
					end,
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.c = codelldb_config
			dap.configurations.cpp = codelldb_config

			-- ============================================================
			-- 4. Comandi e scorciatoie di debug
			-- ============================================================
			-- Punti di interruzione
			vim.keymap.set(
				"n",
				"<leader>db",
				dap.toggle_breakpoint,
				{ desc = "Attiva/disattiva punto di interruzione" }
			)

			-- Controllo sessione
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Avvia/Continua" })
			vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Termina sessione di debug" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Ripeti ultimo debug" })

			-- Esecuzione passo-passo
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Entra nella funzione" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Passa alla riga successiva" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Esci dalla funzione" })

			-- UI
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Attiva/disattiva UI debug" })
			vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Attiva/disattiva REPL" })
			vim.keymap.set("n", "<leader>dw", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Suggerimento variabile" })
		end,
	},
}
