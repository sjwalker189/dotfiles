return {
	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				theme = 'auto',
				component_separators = '|',
				section_separators = '',
				globalstatus = true,
			},
		},
	},
}
