-- VIM OPTIONS -- 

local opt = vim.opt

-- turn off nvim intro
opt.shortmess = "I"

-- line numbering

opt.number = true
opt.relativenumber = true

-- 80-character indicator
opt.colorcolumn = "80"

-- appearance
opt.termguicolors = true
opt.background = "dark"

-- force nvim to use system clipboard
opt.clipboard:append("unnamedplus")

-- where to put split windows
opt.splitright = true
opt.splitbelow = true

-- treat hyphenated words as one word
opt.iskeyword:append("-")








