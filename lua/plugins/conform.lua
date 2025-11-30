return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				c = {
					"clang-format",
					args = { "--style=file" },
				},
				cpp = {
					"clang-format",
					args = { "--style=file" },
				},
				python = { "black" },
				php = { "pretty-php" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
			},

			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		})
	end,
}
