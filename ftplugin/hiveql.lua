-- Config for Hive QL scripts --

-- use sql highlighting for hiveql 
vim.treesitter.language.register("sql", "hiveql")

-- when nvim-repl is invoked, ssh to remote and immediately launch hive 
-- if hive is exited, don't close the connection; exit out to remote bash 
vim.g.repl_filetype_commands = {
  hiveql = "ssh -t bodhi 'hive; bash'"
}



