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

function Light()
  vim.o.background = "light"
end

function Dark()
  vim.o.background = "dark"
end
