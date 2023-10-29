-- vim-dadbod is loaded only when an sql file is opened
-- vim-dadbod-completion is already loaded; otherwise completion won't work 

local status1, _ = pcall(vim.cmd, "packadd vim-dadbod")
local status2, cmp = pcall(require, "cmp")

if status1 and status2 then
  
  cmp.setup.buffer({ 
    sources = {
      { name = 'vim-dadbod-completion' },
      { name = 'buffer' }
    } 
  })
  
  vim.cmd('DB g:db = mysql:') -- credentials supplied in mariadb config
end

vim.g.sql_type_default = "mysql"

-- remove 80-char column colour
vim.opt.colorcolumn = ""
