return {
	-------------------------------------------------
	--               LSP SIGNATURE (ray-x)
	-------------------------------------------------
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				handler_opts = {
					border = "rounded", -- Bordo bello arrotondato
				},
				hint_enable = false, -- Niente hint a fine riga
				floating_window = true,
				floating_window_above_cur_line = true,

				-- 🔥 PULIZIA VISIVA: Rimuove i colori di sintassi orribili nel popup
				-- hi_parameter = "LspSignatureActiveParameter",
				hi_parameter = "Search",
				doc_lines = 10, -- Nasconde la documentazione lunga, lascia solo la firma
				max_height = 12, -- Limita l'altezza
				max_width = 80, -- Limita la larghezza

				-- 🔥 SCORRIMENTO OVERLOAD: usa Alt+n per passare alla firma successiva
				select_signature_key = "<Tab>",

				-- Esclude filetypes noiosi
				exclude_filetypes = { "asm", "nasm", "vmasm" },
			})
		end,
	},

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
			-- Rimosso cmp-nvim-lsp-signature-help
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

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
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
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = { abbr = 45, menu = 45 },
						ellipsis_char = "...",
						show_labelDetails = true,
						before = function(entry, vim_item)
							local menu_icon = {
								nvim_lsp = "[LSP]",
								luasnip = "[Snip]",
								buffer = "[Buf]",
								path = "[Path]",
							}
							vim_item.menu = menu_icon[entry.source.name] or ""

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
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						max_height = 8,
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
					}),
					documentation = cmp.config.disable, -- 🔥 DISABILITA LA FINESTRA DI DOCUMENTAZIONE DI CMP
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" }, { name = "cmdline" } }),
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})
		end,
	},
}
