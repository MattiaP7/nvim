return {
	"danymat/neogen",
	dependencies = "L3MON4D3/LuaSnip",
	-- config = true,
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip",
		})

		vim.keymap.set("n", "<Leader>nf", function()
			require("neogen").generate()
		end, { desc = "Neogen generate docs" })
	end,
}
