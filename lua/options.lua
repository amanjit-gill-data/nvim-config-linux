-- VIM OPTIONS -- 

local opt = vim.opt

-- turn off nvim intro
opt.shortmess = "I"

-- line numbering

opt.number = true
opt.relativenumber = true

-- tabs and indents

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true

-- line wrap
opt.wrap = false

-- search case
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- keep cursor above bottom
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "WinNew", "VimResized"}, {
  pattern = {"*.*"},
  command = "set scrolloff=10"
})

-- cursor shape and blinking
opt.guicursor = "i:blinkwait100-blinkon500-blinkoff500,i:ver20"

-- 80-character indicator
opt.colorcolumn = "80"

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- force nvim to use system clipboard
opt.clipboard:append("unnamedplus")

-- where to put split windows
opt.splitright = true
opt.splitbelow = true

-- treat hyphenated words as one word
opt.iskeyword:append("-")








