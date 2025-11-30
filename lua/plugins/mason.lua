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
				opts = {},
			},
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pylsp",
					"intelephense",
					"html",
					"cssls",
					"vtsls",
					"emmet_language_server",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- FORMATTER
					"stylua",
					"prettier",
					"black",
					"clang-format",
					"pretty-php",
				},
				auto_update = false,
				run_on_start = true,
			})
		end,
	},
}
