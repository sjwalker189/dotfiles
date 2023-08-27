return {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',

    "editorconfig/editorconfig-vim",

    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        opts = {
            char = "▏",
            -- char = '┊',
            show_trailing_blankline_indent = false,
        },
    },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Laravel Blade
    {'jwalton512/vim-blade'}
}
