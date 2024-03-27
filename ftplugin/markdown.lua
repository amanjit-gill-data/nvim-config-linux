local status, _ = pcall(vim.cmd, "packadd clipboard-image.nvim")
if status then
  require('clipboard-image').setup {
    markdown = {
      img_dir = { "%:p:h", "images" }, -- actual path
      img_dir_txt = { "images" }, -- path to show in markdown 
      affix = '<img src="%s">' 
    }
  }
  vim.cmd("command P PasteImg")
end

-- remaining config will continue even if plugin fails

local opt = vim.opt

-- enable line wrap
opt.wrap = true

-- ensure that the start of the next line isn't a space
opt.linebreak = true

-- remove 80-char column colour
opt.colorcolumn = ""
