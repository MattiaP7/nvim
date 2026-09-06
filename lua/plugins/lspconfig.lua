return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-------------------------------------------------
			--             DIAGNOSTICS & SIGNS
			-------------------------------------------------
			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
				underline = true,
				update_in_insert = false,
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

			vim.diagnostic.enable()

			-------------------------------------------------
			--                  KEYMAP LSP
			-------------------------------------------------
			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
			end

			-------------------------------------------------
			--                 CAPABILITIES
			-------------------------------------------------
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.resolveSupport = {
				properties = { "documentation", "detail", "additionalTextEdits" },
			}

			-------------------------------------------------
			--             HANDLERS CORRETTI
			-------------------------------------------------
			-- Hover handler con bordo arrotondato
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			-- Signature help handler con bordo arrotondato
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signatureHelp, { border = "rounded" })

			-------------------------------------------------
			--             CONFIGURAZIONE SERVER
			-------------------------------------------------
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					},
				},

				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--suggest-missing-includes",
						-- IMPORTANTE: Specifica il path ESATTO di g++
						-- Cambia questo con il tuo path reale!
						"--query-driver=D:/msys64/ucrt64/bin/g++.exe",
					},
					root_markers = { "compile_commands.json", ".git", "CMakeLists.txt" },
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},

				pylsp = {
					settings = {
						pylsp = {
							plugins = {
								pycodestyle = {
									ignore = { "W391", "E305", "E501", "W503", "E704" },
									maxLineLength = 100,
								},
							},
						},
					},
				},

				intelephense = {
					filetypes = { "php" },
					root_markers = { ".git", "composer.json" },
				},

				html = {
					filetypes = { "html", "htm", "php", "javascript" },
				},

				cssls = {
					settings = {
						css = { validate = true },
						scss = { validate = true },
						less = { validate = true },
					},
				},

				-- ⚠️ VTSLS - CONFIGURAZIONE CORRETTA
				vtsls = {
					settings = {
						-- Per TypeScript
						typescript = {
							inlayHints = {
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},
							preferences = {
								importModuleSpecifierPreference = "non-relative",
							},
						},
						-- Per JavaScript
						javascript = {
							inlayHints = {
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
							},
						},
					},
					-- NON aggiungere 'cmd' qui - vtsls sa come trovare se stesso
					-- Filetypes supportati
					filetypes = {
						"typescript",
						"javascript",
						"javascriptreact",
						"typescriptreact",
						"vue",
					},
				},

				tailwindcss = {},
				neocmake = {},

				emmet_language_server = {
					filetypes = {
						"html",
						"htm",
						"php",
						"css",
						"scss",
						"javascriptreact",
						"typescriptreact",
						"svelte",
					},
				},
			}

			-------------------------------------------------
			--             AVVIO AUTOMATICO LSP (Neovim 0.11+)
			-------------------------------------------------
			-- Impostare configurazione di default per tutti i server
			vim.lsp.config("*", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- Configurare server specifici
			for name, opts in pairs(servers) do
				-- Assicurati che on_attach e capabilities siano impostati
				opts.capabilities = opts.capabilities or capabilities
				opts.on_attach = opts.on_attach or on_attach

				-- Registrare la config con vim.lsp.config
				-- Se usi lspconfig, questo funziona come wrapper
				vim.lsp.config[name] = opts
			end

			-- Abilitare i server
			-- Modifica questa lista con i server che vuoi abilitare al startup
			vim.lsp.enable({
				"clangd",
				"lua_ls",
				"pylsp",
				"intelephense",
				"html",
				"cssls",
				"vtsls",
				"tailwindcss",
				"emmet_language_server",
			})
		end,
	},
}
