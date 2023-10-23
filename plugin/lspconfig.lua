local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
  return
end

-- KEYMAPS for lsp features
-- will only apply when a language server is attached

local add_keymaps = function(bufnr)

  local options = { noremap = true, silent = true, buffer = bufnr }
  local km = vim.keymap

  km.set('n', '<space>e', vim.diagnostic.open_float, options)

  -- navigate to diagnostics on other lines 
  km.set('n', '[d', vim.diagnostic.goto_prev, options)
  km.set('n', ']d', vim.diagnostic.goto_next, options)

  -- add diagnostics on current line to location list
  km.set('n', '<space>q', vim.diagnostic.setloclist, options)
  
  km.set('n', 'gD', vim.lsp.buf.declaration, options)
  km.set('n', 'gd', vim.lsp.buf.definition, options)
  km.set('n', 'gt', vim.lsp.buf.type_definition, options)
 
  km.set('n', '<C-k>', vim.lsp.buf.hover, options)
  km.set('i', '<C-k>', vim.lsp.buf.signature_help, options)
  
  km.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, options)
  km.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, options)
  km.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, options)
 
  -- list files and lines where current object is referenced
  km.set('n', 'gr', vim.lsp.buf.references, options) 
  
  km.set('n', '<space>rn', vim.lsp.buf.rename, options)
  km.set('n', '<space>ca', vim.lsp.buf.code_action, options)
  km.set('n', '<space>f', function() 
    vim.lsp.buf.format { async = true }
  end, options)

end

-- SET UP language servers

local capabilities = cmp_nvim_lsp.default_capabilities()

on_attach = function(client, bufnr)
  add_keymaps(bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

lspconfig.texlab.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    texlab = {
      build = {
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--keep-logs",
          "--keep-intermediates"
        },
        onSave = true
      }
    }
  }
}

lspconfig.bashls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "bash-language-server.cmd",  "start" },
  root_dir = function(fname)
    return vim.loop.cwd()
  end
}

