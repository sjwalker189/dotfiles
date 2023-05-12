-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

--
-- Language Servers
--
local lspconfig = require("lspconfig")
local lspcore = require("swalker.config.lsp.core")

local format_onsave = true
local formatters = {
  default = function() 
    vim.lsp.buf.format()
  end,
  prettier = function()
    vim.cmd("Prettier")
  end
}

local default_options = {
  settings = {},
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    lspcore.on_attach(client, bufnr, formatters.default, format_onsave)
  end,
}

local function with_defaults(options = {})
  local opts = {}

  -- Apply default options
  for k, v in default_options do
    opts[k] = v
  end

  -- Apply provided options
  for k, v in options do
    opts[k] = v
  end

  return opts
end


-- require("mason").setup({
--   ensure_installed = {
--     "html",
--     "cssls",
--     "tailwindcss",
--     "tsserver",
--     "bashls",
--     "lua_ls",
--     "denols",
--     "rust_analyzer",
--     "gopls",
--   }
-- })
-- require('mason-lspconfig').setup({
-- })
--

-- Web Essentials
-- lspconfig.tailwindcss.setup(with_defaults())
-- lspconfig.html.setup(with_defaults())
-- lspconfig.cssls.setup(with_defaults())
-- lspconfig.tsserver.setup(with_defaults({
--   root_dir = lspconfig.util.root_pattern("package.json"),
--   single_file_support = false,
--   on_attach = function(client, bufnr)
--     lspcore.on_attach(client, bufnr, formatters.prettier, format_onsave)
--   end
-- }))

-- Vue
-- lspconfig.volar.setup(with_defaults({
--   cmd = {'vue-language-server', '--stdio'},
--   root_dir = lspconfig.util.root_pattern("package.json"),
--   settings = {
--     filetypes = {
--       'typescript',
--       'javascript',
--       'javascriptreact',
--       'typescriptreact',
--       'vue',
--       'json',
--     },
--   },
--   on_attach = function(client, bufnr)
--     lspcore.on_attach(client, bufnr, formatters.prettier, format_onsave)
--   end
-- }))

-- Rust
-- lspconfig.rust_analyzer.setup(with_defaults({
--   settings = {
--     ["rust-analyzer"] = {
--       checkOnSave = {
--         command = "clippy",
--       }
--     }
--   }
-- }))
--
-- Misc
-- lspconfig.bashls.setup(with_defaults({}))
-- lspconfig.lua_ls.setup(with_defaults({
--   settings = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--     },
--   }
-- }))
