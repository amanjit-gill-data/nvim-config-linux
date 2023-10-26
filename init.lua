require('keymaps')
require('options')

-- open bash through powershell to prevent conda init errors
vim.cmd("command Term terminal powershell bash --login")

-- keep cursor above bottom
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "WinNew", "VimResized"}, {
  pattern = {"*.*"},
  command = "set scrolloff=10"
})
