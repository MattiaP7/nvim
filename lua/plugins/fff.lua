return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	-- opts = { -- (optional)
	-- 	debug = {
	-- 		enabled = true, -- we expect your collaboration at least during the beta
	-- 		show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
	-- 	},
	-- },
	lazy = false,
	keys = {
		{
			"ff", -- try it if you didn't it is a banger keybinding for a picker
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
	},
}
