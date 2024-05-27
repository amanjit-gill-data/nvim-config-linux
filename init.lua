-- NVIM INITIALISATION --

require('keymaps')
require('options')
 
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "WinNew", "VimResized"}, {
  pattern = {"*.*"},
  command = "let &scrolloff=winheight(win_getid())/3"
})

