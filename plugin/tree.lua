local status, nvimtree = pcall(require, "nvim-tree")
if not status then
  return
end

-- disable builtin file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup()

