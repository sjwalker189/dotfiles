require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.bufremove").setup()
require("mini.indentscope").setup({
  symbol = "▏",
  draw = {
    delay = 0,
    animation = require("mini.indentscope").gen_animation.none()
  },
  options = {
    try_as_border = true,
  }
})

local dark_theme = "nordic"
local light_theme = "rose-pine"
local color_mode = "dark"

function ToggleColorMode()
  if color_mode == "dark" then
    color_mode = "light"
    vim.cmd("colorscheme " .. light_theme)
    vim.o.background = "light"
  else
    color_mode = "dark"
    vim.cmd("colorscheme " .. dark_theme)
    vim.o.background = "dark"
  end
end

vim.keymap.set("n", "<leader>kt", ToggleColorMode, { desc = "Toggle color mode" })
