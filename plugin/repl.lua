-- assumes ipython is installed to active env
vim.g.repl_filetype_commands = {
  python = 'ipython3 --no-autoindent',
  r = 'R'
}

vim.keymap.set('n', '<leader><leader>e', '<Cmd>ReplToggle<CR>', { noremap = true })

-- cell marker is defined by repl as # %%
vim.cmd("iab nc # %%")

-- send cell 
vim.keymap.set('n', "<leader>ec", "<Plug>ReplSendCell")

-- send line 
vim.keymap.set("n", "<leader>el", "<Plug>ReplSendLine")

-- send paragraph i.e. block with no newlines
vim.keymap.set("n", "<leader>ep", "vip<Plug>ReplSendVisual<Esc>vipjj<Esc>")

