return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-------------------------------------------------
			--         PATH ENVIRONMENT FIX FOR CARGO
			-------------------------------------------------
			local cargo_bin = vim.fn.expand("~/.cargo/bin")
			if vim.fn.isdirectory(cargo_bin) == 1 then
				vim.env.PATH = cargo_bin .. ";" .. vim.env.PATH
			end

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
			--                 KEYMAP LSP
			-------------------------------------------------
			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)

				-- Notazione corretta con i due punti (client:supports_method)
				if client:supports_method("textDocument/signatureHelp") then
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				end
			end

			-------------------------------------------------
			--                CAPABILITIES
			-------------------------------------------------
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.resolveSupport = {
				properties = { "documentation", "detail", "additionalTextEdits" },
			}

			-------------------------------------------------
			--              HANDLERS CUSTOM
			-------------------------------------------------
			-- Silenzia l'errore "No information available" per i server che non implementano signatureHelp
			vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
				if err then
					-- Ignora silenziosamente qualsiasi errore (incluso RequestFailed)
					return
				end
				return vim.lsp.handlers.signature_help(
					err,
					result,
					ctx,
					vim.tbl_extend("force", { border = "rounded" }, config or {})
				)
			end

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
								jedi = {
									environment = "C:/Users/7matt/AppData/Local/Programs/Python/Python313/python.exe",
								},
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

				vtsls = {
					settings = {
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
						javascript = {
							inlayHints = {
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
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

				asm_lsp = {
					filetypes = { "asm", "vmasm", "nasm" },
					root_markers = { ".git", ".asm-lsp.toml" },
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
			--         AVVIO AUTOMATICO LSP (Neovim 0.11+)
			-------------------------------------------------
			vim.lsp.config("*", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			for name, opts in pairs(servers) do
				opts.capabilities = opts.capabilities or capabilities
				opts.on_attach = opts.on_attach or on_attach

				vim.lsp.config[name] = opts
				vim.lsp.enable(name)
			end
		end,
	},
}
