-- NVIM INITIALISATION --

require('keymaps')
require('options')

-- open bash through powershell to prevent conda init errors
vim.cmd("command Term terminal powershell bash --login")

vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "WinNew", "VimResized"}, {
  pattern = {"*.*"},
  command = "let &scrolloff=winheight(win_getid())/3"
})

vim.filetype.add({
  extension = {
    hql = 'hiveql'
  }
})
