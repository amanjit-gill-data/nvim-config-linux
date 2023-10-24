-- nvim shell must be set to cmd for other shells to launch properly
vim.opt.shell = 'cmd'

-- bash is launched from powershell to prevent conda env-related errors 
vim.g.repl_default = "powershell bash --login"

vim.g.repl_filetype_commands = {
  python = 'ipython --no-autoindent',
  sql = 'mariadb' -- auto login using credentials hidden elsewhere
}

vim.keymap.set('n', '<leader><leader>e', ':ReplToggle<CR>', { noremap = true })

-- cell marker is defined by repl as #%%
vim.keymap.set('n', '<leader>ec', ':ReplRunCell<CR>', { noremap = true })

-- select paragraph (e.g. sql query, bash block, etc) and send to repl
-- move to next paragraph (assumes separated by a single empty line)
vim.keymap.set("n", "<leader>eq", "vip:ReplSendVisual<CR>vip<Esc>jj")




