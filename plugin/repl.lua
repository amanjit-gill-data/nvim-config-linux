-- cmd is required for any repl to work on windows os
-- but cmd causes git-related error when nvim-tree is opened
-- therefore use powershell as default nvim shell
-- and use bash (invoked from powershell) as default repl
vim.opt.shell = "powershell"
vim.g.repl_default = "bash --login"

vim.g.repl_filetype_commands = {
  python = 'ipython --no-autoindent',
  sql = 'mysql -u ag -p'
}

vim.keymap.set('n', '<leader><leader>e', ':ReplToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ec', ':ReplRunCell<CR>', { noremap = true })

-- select paragraph (e.g. sql query, bash block, etc) and send to repl
vim.keymap.set("n", "<leader>eq", "vip:ReplSendVisual<CR>")




