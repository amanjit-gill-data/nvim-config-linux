-- cmd is required for any repl to work on windows os
-- but cmd causes git on nvim-tree to stop working
-- therefore use powershell as default nvim shell
-- and use bash (invoked from powershell) as default repl
vim.opt.shell = "powershell"
vim.g.repl_default = "bash --login"

vim.g.repl_filetype_commands = {
  python = 'ipython --no-autoindent',
  sql = 'mysql -u ag -p'
}

vim.keymap.set('n', '<leader><leader>e', ':ReplToggle<CR>', { noremap = true })


