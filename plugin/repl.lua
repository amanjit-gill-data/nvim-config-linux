-- nvim shell must be cmd for other shells to launch properly in winOS 
vim.opt.shell = 'cmd'

-- launch bash through powershell to prevent conda init errors
vim.g.repl_default = 'powershell bash --login'

vim.g.repl_filetype_commands = {
  python = 'ipython', -- no-autoindent already set in ipython config 
  sql = 'mariadb'
}

vim.cmd("command PySpark ReplOpen pyspark")

vim.keymap.set('n', '<leader><leader>e', '<Cmd>ReplToggle<CR>', { noremap = true })

-- cell marker is defined by repl as # %%
vim.cmd("iab nc # %%")

vim.keymap.set('n', "<leader>ec", "<Plug>ReplSendCell")

-- send line (e.g. pyspark method) to repl 
vim.keymap.set("n", "<leader>el", "<Plug>ReplSendLine")

-- send paragraph (e.g. sql query, bash block) to repl
vim.keymap.set("n", "<leader>ep", "vip<Plug>ReplSendVisual<Esc>vipjj<Esc>")

