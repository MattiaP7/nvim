return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup({
				defaults = {
					prompt_prefix = "   ",
					mappings = {
						i = {
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
						},
					},
					layout_config = {
						horizontal = {
							preview_width = 0.6
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					}
				}
			})
		end,
	},
	{
		'https://github.com/andrew-george/telescope-themes',
		config = function()
			require('telescope').load_extension('themes')
		end
	},
}
