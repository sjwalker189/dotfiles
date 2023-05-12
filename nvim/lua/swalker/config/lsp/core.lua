local M = {}

M.create_buffer_nmap = function(prefix, bufnr)
  return function(keys, func, desc)
    if desc then
      desc = prefix .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
end

M.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Keymaps
  local nmap = M.create_buffer_nmap("LSP: ", bufnr)
  local format = function()
    vim.lsp.buf.format()
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame Token')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gt', vim.lsp.buf.type_definition, '[G]oto Type [D]efinition')
  nmap('gds', require('telescope.builtin').lsp_document_symbols, '[G]oto [D]ocument [S]ymbols')
  nmap('gws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[G]oto [W]orkspace [S]ymbols')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')


  -- Formatting
  if client.server_capabilities.documentFormattingProvider then
    -- Automatically format file on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = format,
    })

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", format, {
      desc = "Format current buffer with LSP"
    })
  end
end

return M
