return {
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp_signature").setup({
				hint_enable = false,
				handler_opts = {
					border = "rounded"
				},
				toggle_key = "<M-x>",
				floating_window = true,
				floating_window_above_cur_line = true,
				fix_pos = true,
				always_trigger = true
			})
		end
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets"
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp-signature-help",
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

			-- Carica snippet
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
					-- { name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),

				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						before = function(entry, vim_item)
							-- Mostra la sorgente
							vim_item.menu = ({
								nvim_lsp = "[LSP]",
								nvim_lsp_signature_help = "[Sig]",
								luasnip = "[Snip]",
								buffer = "[Buf]",
								path = "[Path]",
							})[entry.source.name]

							vim_item.dup = ({
								nvim_lsp = 0,
								luasnip = 0,
								buffer = 0,
								path = 0
							})[entry.source.name] or 0

							return vim_item
						end,
					}),
				},

				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
						max_width = 80,
						max_height = 20,
					}),
				},
			})
		end,
	},
}
