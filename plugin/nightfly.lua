-- safely start colour scheme
local status, scheme = pcall(vim.cmd, 'colorscheme nightfly')
if not status then
  print("Colour scheme not found")
  return
end

-- source for custom bg and tints:
-- https://www.color-hex.com/color/0C0C17

-- set custom bg
vim.cmd.highlight('Normal', 'guibg=#181b1f')

-- set colour for 80-char column to a 'tint' of the custom bg
vim.cmd.highlight('ColorColumn', 'guibg=#2f3135')

-- remove bg from gutter and line numbering so it always matches Normal
-- set line numbering to a 'tint' of the custom bg
vim.cmd.highlight('SignColumn', 'guibg=NONE')
vim.cmd.highlight('LineNr', 'guibg=NONE', 'guifg=#5d5f62')

-- change string colour to a less mustardy yellow
vim.cmd.highlight('String', 'guifg=#efd18a')




