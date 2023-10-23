# Neovim API for Lua

these are notes on how to use lua with neovim
i've taken them from the url given below, but skipped over things i probably won't use just yet.

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
:lua some_lua_code
```

- each `:lua` call has its own scope
- previously defined global variables will work, but `local` ones won't

the second `:lua` can't see the `a` definition
```
:lua local a=1
:lua print(a)
```

check value of lua variable or table
```
:lua =some_var
```

check value of vimscript variable
```
:lua =vim.g.some_var
```

run lua script from an external file
use vim's source command
```
:source path/to/luafile.lua
```

## access vim commands in a lua script

- use `:lua` to use any of these directly in nvim command line
- escape special characters in strings unless using `[[..]]`

### method 1: pass entire command as one string

```
vim.cmd("commandname arg1 arg2") 

vim.cmd("colorscheme habamax") or
vim.cmd([[colorscheme habamax]])
```

can use `[[..]]` to execute multiple vim commands at once
```
vim.cmd([[
  highlight Error guibg=red
  highlight link Warning Error
]])
```

### method 2: pass only the args as strings

```
vim.cmd.commandname("just_one_arg") // pass single arg as string
vim.cmd.commandname({"arg1", "arg2"}) // pass multi args as table of strings 
```

```
vim.cmd.colorscheme("habamax")
vim.cmd.highlight({"Error", "guibg=red"})
vim.cmd.highlight({"link", "Warning", "Error"})
```

## access vimscript functions in a lua script

```
vim.fn.functionname(arg1, arg2, ...)
```

- works with built-in or user-defined
- use `:lua` to use this directly in nvim command line

- to access lua variables, reference them directly
- to access vimscript variables, use `vim.g...` etc 

```
lower = "a_string"
upper = vim.fn.toupper(lower)
print(vim.fn.printf('%s to %s', lower, upper)

vim.g.var = "15"
print(vim.g.var)
```

## write a lua function

- can also be passed into a vimscript function

```
local function func_name(arg1, arg2, ...)
  // lua code here
end
```

## set and get vimscript variables in lua

```
lua wrapper     scope

vim.g           global
vim.b           current buffer
vim.w           current window
vim.t           current tab
vim.v           predefined vimscript variables
vim.env         environment vars defined in this editor session

```

target specific buffers/windows/tabs
```
vim.b[2].myvar = 20         // set myvar for buffer 2

print(vim.b[2].varname)     // get myvar for buffer 2

```

reference vimscript variable names that are invalid for identifiers in lua
```
vim.g['mystuff#var'] = 1    // the # is invalid
```

cannot directly change fields of a vimscript array var
must assign it to a lua table, then change the table
then assign it back to the vimscript var

delete vimscript variable
```
vim.g.myvar = nil           // set it to nil
```

## set and get vim options with Lua

### method 1: vim.opt

```
vim.opt             same as :set
vim.opt global      same as :setglobal
vim.opt local       same as :setlocal
```

```
vim.opt.smarttab = true     same as :set smarttab
vim.opt.smarttab = false    same as :set nosmarttab
```

can use list/map/set-like assignments
```
vim.opt.wildignore = {'*.o', '*.a'} // :set wildignore=*.o,*.a

vim.opt.listchars = {space = '_', tab = '>~'} // :set listchars=space:_,tab:>~

vim.opt.formatoptions = { n = true, j = true} // :set formatoptions=nj
```

to get values, must use :get()
```
print(vim.opt.smarttab) // won't work; outputs hex address

print(vim.opt.smarttab:get())
```

### method 2: vim.o

```
vim.o       same as :set
vim.go      same as :setglobal
vim.bo      buffer-scoped options
vim.wo      window-scoped options
```

can get values directly
```
print(vim.o.smarttab)
```

can target specific buffers or windows
```
vim.bo[4].expandtab = true  // set

print(vim.bo[4].expandtab)  // get
```

## set key mappings with lua

- can map to vim command, lua function or key combination

specify:
- mode(s) as string or table of strings
- keys as string 
- vim command as string / lua function directly / keys as string
- optional fourth arg (buffer/silent/expr/desc/remap)

```
vim.keymap.set('n', '<Leader>j', 'gj')
// in normal mode, map '<Leader>j' to 'gj'

vim.keymap.set({'n', 'c'}, '<Leader>j', 'gj')
// in normal and command modes

vim.keymap.set('n', '<Leader>j', '<cmd>echo "hello"<cr>')
// map to vim command

vim.keymap.set('n', '<Leader>j', vim.treesitter.start)
// map to lua func without arguments

vim.keymap.set('n', '<Leader>j', function() print('hello') end)
// map to lua func with arguments must have `function()` and `end`
```

### delete a mapping

```
vim.keymap.del(mode/s, keys)

vim.keymap.del('n', '<Leader>j')
```

### use key mapping to load plugins

```
vim.keymap.set('n', '<Leader>a', require('pluginname').action)
// loads plugin when key mapping is _defined_, not when it's used

vim.keymap.set('n', '<Leader>a', function() require('pluginname').action() end)
// loads plugin only when mapping is executed

```

## write an autocommand using lua

must specify:
- event as string or table of strings
- opts as table with keys

optional:
- pattern as filetype string / table of strings, OR buffer as integer
- command as string, OR callback as lua function 

```
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = {".c", ".h"},
  command = "echo 'Entering a c file'"
})

vim.api.nvim_create_autocmd("Yankee", {
  callback = function() vim.highlight.on_yank() end
})

```

## group autocommands with lua

- can reuse in different files

step 1. define the overarching group 

specify:
- group name
- whether or not to clear group if it already exists

```
local tab_group = vim.api.nvim_create_augroup('tab_settings', {clear = true})
```

step 2. define each autocmd in the group
in this example, the group tab_group has two autocmds

```
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.py',
  group = tab_group, // or 'tab_settings'
  command = 'set shiftwidth=4',
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.py',
  group = tab_group, // or 'tab_settings'
  command = 'set expandtab',
})
```

### delete an autocommand

```
// Delete all autocmds for the given event(s)
vim.api.nvim_clear_autocmds({event = {"BufEnter", "InsertLeave"}})

// Delete all autocmds for the given event, but only in the given buffer
vim.api.nvim_clear_autocmds({event = "ColorScheme", buffer = 0})

// Delete all autocmds for a given filetype pattern
vim.api.nvim_clear_autocmds({pattern = "*.py"})

// Delete all autocommands in a given group
vim.api.nvim_clear_autocmds({group = "scala"})
```

## write a user command in lua

specify:
- command name with uppercase letter, as a string
- vim commands or lua functions to execute, as a string
- command attributes, as a table (desc/force/preview); may be empty

```
vim.api.nvim_create_user_command('Test', 'echo "hello"', {})
```

run the user command
```
vim.cmd.Test()
```

create a user command specific to a buffer
```
vim.api.nvim_buf_create_user_command(3, 'Test', 'echo "hello"', {})
// specific to buffer 3
```

### delete a user command
```
vim.api.nvim_del_user_command('Upper')          

vim.api.nvim_buf_del_user_command(4, 'Upper')   // specific to buffer 4
```

