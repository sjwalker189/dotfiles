return {
  {
    'mhartington/formatter.nvim',
    config = function()
      local util = require "formatter.util"
      local formatter = require "formatter"

      formatter.setup {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          lua = {},
          css = {
            require("formatter.filetypes.css").prettier,
          },
          -- ts = {
          --   require("formatter.filetypes.typescript").prettier,
          --   require("formatter.filetypes.typescript").denofmt,
          -- }
        }
      }
    end
  }
}
