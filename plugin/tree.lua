local status, nvimtree = pcall(require, "nvim-tree")
if not status then
  return
end

-- disable builtin file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup {

  git = {
    ignore = false,
    show_on_open_dirs = false
  },

  renderer = {
    icons = {
      glyphs = {
        git = {
          unstaged = "",
          untracked = "u",
          staged = "",
          ignored = ""
        },
      }
    }
  }
  
}

vim.keymap.set("n", "<leader><leader>t", ":NvimTreeToggle<CR>")

