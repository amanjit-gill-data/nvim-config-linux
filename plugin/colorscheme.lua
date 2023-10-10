-- safely start colour scheme
local status, scheme = pcall(vim.cmd, 'colorscheme nightfly')
if not status then
  print("Colour scheme not found")
  return
end

-- set custom background
vim.cmd.highlight('Normal', 'guibg=#121c26')

-- remove background from gutter and line numbering so it always matches Normal
vim.cmd.highlight('LineNr', 'guibg=NONE')

-- change string colour to a less mustardy yellow
vim.cmd.highlight('String', 'guifg=#ffdd88')




