local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
  return
end

-- KEYMAPS for lsp features

local add_keymaps = function(bufnr)

  local options = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, options)

  -- navigate to diagnostics on other lines 
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, options)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, options)

  -- add diagnostics on current line to location list
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, options)
  
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, options)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, options)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, options)
 
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, options)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, options)
  
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, options)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, options)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, options)
 
  -- list files and lines where current object is referenced
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, options) 
  
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, options)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, options)
  vim.keymap.set('n', '<space>f', function() 
    vim.lsp.buf.format { async = true }
  end, options)

end

-- SET UP language servers

-- only attach lsp keymaps when language server is attached to buffer
-- also enable omnifunc to work alongside lsp
on_attach = function(client, bufnr)
  add_keymaps(bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

lspconfig.pyright.setup {
  capabilities = cmp_nvim_lsp.default_capabilities(),
  on_attach = on_attach
}

