local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

lspconfig.pyright.setup{}


