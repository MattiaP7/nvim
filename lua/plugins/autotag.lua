return {
	"windwp/nvim-ts-autotag",
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Chiude il tag dopo ">"
				enable_rename = true, -- Rinomina il tag di chiusura se cambi quello di apertura
				enable_close_on_slash = true, -- Chiude il tag su "/"
			},
		})
	end,
}
