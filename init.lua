require('keymaps')
require('options')

-- keep cursor above bottom
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "WinNew", "VimResized"}, {
  pattern = {"*.*"},
  command = "set scrolloff=10"
})
