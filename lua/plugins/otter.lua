return {
	"jmbuhr/otter.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("otter").setup({})
	end,
}
