require('keymaps')
require('options')

-- open bash through powershell to prevent conda init errors
vim.cmd("command Term terminal powershell bash --login")

