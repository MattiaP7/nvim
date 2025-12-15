return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				signs = true,
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

			local signs = {
				Error = " ",
				Warn = " ",
				Hint = " ",
				Info = " ",
			}

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.enable()

			-------------------------------------------------
			--                 KEYMAP LSP
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

			-------------------------------------------------
			--              CONFIGURAZIONE SERVER
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
						"--function-arg-placeholders=0",
						"-j=12",
						"--clang-tidy",
					},
					capabilities = clangd_capabilities,
					init_options = { documentFormatting = true },
				},

				pylsp = {
					settings = {
						pylsp = {
							plugins = {
								pycodestyle = {
									ignore = { "W391", "E305", "E501" },
									maxLineLength = 100,
								},
							},
						},
					},
				},

				intelephense = {},

				-------------------------------------------------
				--          🌐 HTML / CSS / JS / EMMET
				-------------------------------------------------

				html = {
					filetypes = { "html", "htm", "php" },
				},

				cssls = {
					settings = {
						css = { validate = true },
						scss = { validate = true },
						less = { validate = true },
					},
				},

				vtsls = {
					settings = {
						vtsls = {
							tsserver = {},
						},
					},
					filetypes = {
						"typescript",
						"javascript",
						"javascriptreact",
						"typescriptreact",
						"vue",
					},
				},

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
			--             AVVIO AUTOMATICO LSP
			-------------------------------------------------

			for name, opts in pairs(servers) do
				opts.capabilities = opts.capabilities or capabilities
				opts.on_attach = on_attach
				vim.lsp.config[name] = opts
				vim.lsp.enable(name)
			end

			-------------------------------------------------
			--             FINESTRE CON BORDI
			-------------------------------------------------

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", focusable = false })
		end,
	},
}
