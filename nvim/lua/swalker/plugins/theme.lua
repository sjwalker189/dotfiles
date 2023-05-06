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
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = {
					light = "latte",
					dark = "mocha",
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					notify = false,
					mini = false,
				},
			})
		end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
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
	}
}
