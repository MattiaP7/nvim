return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_pending = " ",
						package_installed = " ",
						package_uninstalled = " ",
					},
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {}
			},
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd", "pyright" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Configurazione diagnostica
			vim.diagnostic.config({
				virtual_text = true, -- Messaggi inline
				signs = true,    -- Segni a sinistra
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = true,
					header = "",
					prefix = "",
				},
			})

			-- Segni per le diagnostiche
			-- Definisci i segni diagnostici direttamente con vim.diagnostic.config
			vim.diagnostic.config({
				signs = {
					active = {
						Error = " ",
						Warn  = " ",
						Hint  = " ",
						Info  = " "
					}
				},
				virtual_text = {
					prefix = "●", -- simbolo del testo virtuale
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Abilita la diagnostica
			vim.diagnostic.enable()
			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem = {
				documentationFormat = { "markdown", "plaintext" },
				snippetSupport = true,
				preselectSupport = true,
				insertReplaceSupport = true,
				labelDetailsSupport = true,
				deprecatedSupport = true,
				commitCharactersSupport = true,
				tagSupport = { valueSet = { 1 } },
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}
			local clangd_capabilities = vim.deepcopy(capabilities)
			clangd_capabilities["offsetEncoding"] = "utf-8"

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = 'LuaJIT' },
							diagnostics = { globals = { 'vim' } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
							telemetry = { enable = false },
						}
					}
				},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--function-arg-placeholders=0",
						"-j=12",
						"--clang-tidy",
					},
					capabilities = clangd_capabilities,
					init_options = {
						documentFormatting = true,
					},
				},

				pyright = {
					root_markers = { ".git", "pyproject.toml", "setup.py", "requirements.txt", "." },
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},
			}

			-- Configura tutti i server
			for name, opts in pairs(servers) do
				opts.capabilities = capabilities
				opts.on_attach = on_attach
				vim.lsp.config[name] = opts
				vim.lsp.enable(name)
			end

			vim.lsp.enable(servers)
			vim.lsp.handlers["textDocument/hover"] = {
				border = "rounded"
			}

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
				focusable = false,
			})
		end,
	},
}
