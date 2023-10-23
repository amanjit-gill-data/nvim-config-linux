-- settings for tex files

local opt = vim.opt

-- enable line wrap
opt.wrap = true

-- ensure that the start of the next line isn't a space
opt.linebreak = true

-- remove 80-char column colour
opt.colorcolumn = ""

vim.cmd("command TB TexlabBuild")
