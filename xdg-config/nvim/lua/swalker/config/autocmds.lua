local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup("YankHighlight"),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
-- local _augroups = {}
-- local get_augroup = function(client)
--   if not _augroups[client.id] then
--     local group_name = 'kickstart-lsp-format-' .. client.name
--     local id = vim.api.nvim_create_augroup(group_name, { clear = true })
--     _augroups[client.id] = id
--   end
--
--   return _augroups[client.id]
-- end

-- Whenever an LSP attaches to a buffer, we will run this function.
--
-- See `:help LspAttach` for more information about this autocmd event.
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
--   -- This is where we attach the autoformatting for reasonable clients
--   callback = function(args)
--     local client_id = args.data.client_id
--     local client = vim.lsp.get_client_by_id(client_id)
--     local bufnr = args.buf
--
--     -- Only attach to clients that support document formatting
--     if not client.server_capabilities.documentFormattingProvider then
--       return
--     end
--
--     -- Tsserver usually works poorly. Sorry you work with bad languages
--     -- You can remove this line if you know what you're doing :)
--     if client.name == 'tsserver' then
--       return
--     end
--     if client.name == 'volar' then
--       return
--     end
--
--
--     local function format()
--       vim.lsp.buf.format({
--         async = false,
--         filter = function(c)
--           return c.id == client.id
--         end
--       })
--     end
--
--     vim.api.nvim_buf_create_user_command(bufnr, 'Format', format, { desc = "LSP: Format buffer" })
--     vim.keymap.set('n', '<S-C-i>', format, { desc = "LSP: Format buffer" })
--   end,
-- })
