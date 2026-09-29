return {
	-- 1. nvim-dap core
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- nvim-dap-ui e nvim-nio (nvim-dap-ui richiede nvim-nio)
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			-- Gestione unificata di Mason e nvim-dap
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = {
					"williamboman/mason.nvim",
					"mfussenegger/nvim-dap",
				},
				opts = {
					-- Specificare quali adapter installare automaticamente
					ensure_installed = { "codelldb" },
					-- Non utilizzare la configurazione automatica di handler, gestire manualmente
					handlers = {},
				},
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- 2. Configurazione dell'interfaccia DAP UI (apertura e chiusura automatica durante il debug)
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- 3. Configurazione dell'adapter codelldb (parte più critica di questa configurazione)
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					-- ⚠️ Punto chiave su Windows: utilizzare codelldb.cmd invece di codelldb
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb.cmd",
					args = { "--port", "${port}" },
				},
			}

			-- 4. Configurazione di avvio per C / C++
			local codelldb_config = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					-- Chiedere il percorso dell'eseguibile all'avvio del debug
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.c = codelldb_config
			dap.configurations.cpp = codelldb_config

			-- 5. Scorciatoie consigliate
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue / Start Debug" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		end,
	},
}
