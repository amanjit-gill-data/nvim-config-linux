# Neovim API for Lua

<https://neovim.io/doc/user/lua-guide.html>

three components:

1. vim API
- inherited from vim
- ex-commands, built-in functions, vimscript functions
- access via `vim.cmd()` and `vim.fn`

2. nvim API
- for use in remote plugins and GUIs
- access via `vim.api`

3. lua API
- specifically for lua
- access via vim.* not mentioned already

## execute lua code inside nvim

```
:lua _some_lua_code_
:lua print("hello")
```

each `:lua` call has its own scope
so previously defined `local` variables won't work

```
:lua local a=1
:lua print(a)
```
the second `:lua` can't see the `a` definition

check value of variable or table
```
:lua =some_var
```

run lua script from an external file
use vim's source command
```
:source path/to/luafile.lua
```

## access vim commands in a lua script

remember:
- use `:lua` to use any of these directly in nvim command line
- escape special characters in strings

```
vim.cmd("colorscheme habamax") or
vim.cmd([[colorscheme habamax]])
```

use [[..]] to run multiple vim commands at once
```
vim.cmd([[
  highlight Error guibg=red
  highlight link Warning Error
]])
```

can also use `vim.cmd.commandname(arguments)` to achieve the above:
```
vim.cmd.commandname("just_one_arg")
vim.cmd.commandname({"arg1", "arg2", "arg3"})

vim.cmd.colorscheme("habamax")
vim.cmd.highlight({"Error", "guibg=red"})
vim.cmd.highlight({"link", "Warning", "Error"})
```

## access vimscript functions in a lua script

remember to use `:lua` to use any of these directly in nvim command line

















