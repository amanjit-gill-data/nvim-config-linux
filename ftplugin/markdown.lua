function setup_paster()
  vim.cmd('packadd clipboard-image.nvim')
  require'clipboard-image'.setup()
end

-- protected call to set up clipboard plugin, but proceed with config if fails
local status, _ = pcall(setup_paster)

local opt = vim.opt

-- enable line wrap
opt.wrap = true

-- ensure that the start of the next line isn't a space
opt.linebreak = true

-- remove 80-char column colour
opt.colorcolumn = ""
