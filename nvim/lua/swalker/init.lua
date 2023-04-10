require "swalker.preflight"
require "swalker.config.settings"
require "swalker.config.keymaps"
require "swalker.config.autocmds"

require('lazy').setup("swalker.plugins", {
    checker = {
        enabled = true,
    },
})
