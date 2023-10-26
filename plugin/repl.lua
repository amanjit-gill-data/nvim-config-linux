-- nvim shell must be cmd for other shells to launch properly in winOS 
vim.opt.shell = 'cmd'

-- launch bash through powershell to prevent conda init errors
vim.g.repl_default = 'powershell bash --login'

vim.g.repl_filetype_commands = {
  python = 'ipython --no-autoindent',
  sql = 'mariadb'
}

vim.keymap.set('n', '<leader><leader>e', ':ReplToggle<CR>', { noremap = true })

-- cell marker is defined by repl as #%% or # %%
vim.keymap.set("n", "nc", "i# %% ")
vim.keymap.set('n', '<leader>ec', ':ReplRunCell<CR>', { noremap = true })

-- send paragraph (e.g. sql query, bash block) to repl
-- then move to next paragraph (assume separated by a single empty line)
vim.keymap.set("n", "<leader>eq", "vip:ReplSendVisual<CR>vip<Esc>jj")

