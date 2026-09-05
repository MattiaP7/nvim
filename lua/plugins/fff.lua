return -- Package name changed from `fff.nvim` to `fff`. If you installed fff.nvim before, clean with `:Lazy clean`
{
	"dmtrKovalenko/fff",
	build = function()
		-- downloads a prebuilt binary or falls back to cargo build
		require("fff.download").download_or_build_binary()
	end,
	opts = {
		prompt = " 󰍉 ",
		-- debug = {
		-- 	enabled = true,
		-- 	show_scores = true,
		-- },
	},
	lazy = false, -- the plugin lazy-initialises itself
	keys = {
		{
			"ff",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
		{
			"fg",
			function()
				require("fff").live_grep()
			end,
			desc = "LiFFFe grep",
		},
		{
			"fz",
			function()
				require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
			end,
			desc = "Live fffuzy grep",
		},
	},
}
