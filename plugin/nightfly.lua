-- safely start theme
local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
  print("Colour scheme not found")
  return
end


