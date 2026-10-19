return {
	-------------------------------------------------
	--                  SNIPPETS
	-------------------------------------------------
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},

	-------------------------------------------------
	--                 COMPLETAMENTO
	-------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- NOTA: "hrsh7th/cmp-nvim-lsp-signature-help" rimosso per evitare
			-- conflitti con "ray-x/lsp_signature.nvim" (che gestisce la firma)
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- Carica gli snippet in formato VSCode
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				-------------------------------------------------
				--                  SNIPPET
				-------------------------------------------------
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				-------------------------------------------------
				--                  MAPPING
				-------------------------------------------------
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				-------------------------------------------------
				--                 SORGENTI
				-------------------------------------------------
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),

				-------------------------------------------------
				--               FORMATTAZIONE
				-------------------------------------------------
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = {
							abbr = 45, -- Limita la larghezza del testo
							menu = 45, -- Limita la larghezza del menu
						},
						ellipsis_char = "...",
						show_labelDetails = true,
						before = function(entry, vim_item)
							-- Etichette per identificare la sorgente
							local menu_icon = {
								nvim_lsp = "[LSP]",
								luasnip = "[Snip]",
								buffer = "[Buf]",
								path = "[Path]",
							}
							vim_item.menu = menu_icon[entry.source.name] or ""

							-- Icone per i tipi di dato
							local kind_icons = {
								Text = "󰉿",
								Method = "󰆧",
								Function = "󰊕",
								Constructor = "",
								Field = "󰜢",
								Variable = "󰀫",
								Class = "󰠱",
								Interface = "",
								Module = "",
								Property = "󰜢",
								Unit = "󰑭",
								Value = "󰎠",
								Enum = "",
								Keyword = "󰌋",
								Snippet = "",
								Color = "󰏘",
								File = "󰈙",
								Reference = "󰈇",
								Folder = "󰉋",
								EnumMember = "",
								Constant = "󰏿",
								Struct = "󰙅",
								Event = "",
								Operator = "󰆕",
								TypeParameter = "",
							}
							vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)

							return vim_item
						end,
					}),
				},

				-------------------------------------------------
				--                 FINESTRE
				-------------------------------------------------
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						-- 🔥 LIMITE DI ALTEZZA (evita che il menu copra la firma)
						max_height = 8,
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
						max_width = 80,
						max_height = 20,
					}),
				},
			})

			-------------------------------------------------
			--             CMDLINE COMPLETION
			-------------------------------------------------
			-- Completamento per i comandi (es. :e, :w)
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})

			-- Completamento per la ricerca (es. /parola)
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
		end,
	},
}
