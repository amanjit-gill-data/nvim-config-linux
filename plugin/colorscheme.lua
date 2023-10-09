-- safely start colour scheme
local status, scheme = pcall(vim.cmd, 'colorscheme nightfly')
if not status then
  print("Colour scheme not found")
  return
end

vim.cmd.highlight('SignColumn', 'guibg=#070d12')
vim.cmd.highlight('Normal', 'guibg=#070d12')

