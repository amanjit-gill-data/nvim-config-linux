-- NVIM INITIALISATION --

require('keymaps')
require('options')

-- don't look for a python3 provider for neovim
vim.g.loaded_python3_provider = 0

-- keep cursor one-third from the bottom
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "WinNew", "VimResized"}, {
  pattern = {"*.*"},
  command = "let &scrolloff=winheight(win_getid())/3"
})

