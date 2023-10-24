-- VIM OPTIONS -- 

local opt = vim.opt

-- turn off nvim intro
opt.shortmess = "I"

-- avoid dos-style line endings
vim.opt.fileformats = "unix"

-- line numbering
opt.number = true
opt.relativenumber = true

-- always show column for git signs
opt.signcolumn = "yes"

-- 80-character indicator
opt.colorcolumn = "80"

-- appearance
opt.termguicolors = true
opt.background = "dark"

-- use system clipboard
opt.clipboard:append("unnamedplus")

-- indentation
opt.autoindent = true 	-- copy indent of prev line
opt.expandtab = true	-- turn tab into spaces
opt.tabstop = 2		-- no. spaces for each tab step 
opt.shiftwidth = 2	-- no. spaces for each autoindent step

-- where to put split windows
opt.splitright = true
opt.splitbelow = true

