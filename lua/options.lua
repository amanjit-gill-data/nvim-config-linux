-- VIM OPTIONS -- 

local opt = vim.opt

-- turn off nvim intro
opt.shortmess = "I"

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
opt.smartindent = true -- smarter autoindenting
opt.expandtab = true	-- turn tab into spaces
opt.tabstop = 2		-- no. spaces for each tab step 
opt.shiftwidth = 2	-- no. spaces for each autoindent step

-- where to put split windows
opt.splitright = true
opt.splitbelow = true

-- folding 
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false -- folds should initially be open 

vim.g.markdown_folding = 1 -- enable markdown folding 

