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
						"--query-driver=D:/msys64/ucrt64/bin/g++*",
					},
					capabilities = capabilities,
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
					cmd = { "intelephense", "--stdio" },
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

				vtsls = {
					settings = {
						vtsls = {
							tsserver = {
								filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
								cmd = { "typescript-language-server", "--stdio" },
							},
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
			-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/hover"] = vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				-- border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				-- border = "rounded",
			})
		end,
	},
}
