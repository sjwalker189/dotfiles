return {
	{
		"rose-pine/neovim",
		priority = 1000, -- make sure to load this before all the other start plugins
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				dark_variant = "main",
			})
		end
	},
	{
		'AlexvZyl/nordic.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('nordic').load()
			require('nordic').setup({
				theme = "onedark",
				nordic = {
					reduced_blue = true,
				}
			})
		end
	},
}
