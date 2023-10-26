-- vim-dadbod is loaded only when an sql file is opened
-- vim-dadbod-completion is always loaded; otherwise completion won't work 

local status1, _ = pcall(vim.cmd, "packadd vim-dadbod")
local status2, cmp = pcall(require, "cmp")

if status1 and status2 then
  cmp.setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
  vim.cmd('DB g:db = mysql:')
end

