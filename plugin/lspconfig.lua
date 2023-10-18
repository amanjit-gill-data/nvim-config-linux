local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
  return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.pyright.setup {
  capabilities = capabilities
}

