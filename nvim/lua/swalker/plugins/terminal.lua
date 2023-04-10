return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      open_mapping = "<C-`>",
      direction = "float",
      shade_terminals = true,
      close_on_exit = true,
      float_opts = {
        border = "curved"
      },
      winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end
      },
    }
  },
}
