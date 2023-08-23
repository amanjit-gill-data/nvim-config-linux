# notes on neovim config 

these are just my rough notes, taken from the neovim documentation, on how neovim searches for and loads config files

## arguments

nvim _file1_ _file2_ _file3_
- open several buffers

nvim --clean
- mimic fresh install

nvim --startuptime _logfile_
- write startup timings to _logfile_ 

## relevant variables

$EXINIT
> not defined 

$VIM
    C:/Program Files/Neovim/share/nvim 

$VIMINIT
    not defined 

$VIMRUNTIME
    C:/Program Files/Neovim/share/nvim/runtime

$XDG_CONFIG_DIRS
    list of dirs
    not defined 

$XDG_CONFIG_HOME
    ~/AppData/Local

runtimepath
- $XDG_CONFIG_HOME/nvim                     
- $XDG_CONFIG_DIRS[1,2,...]/nvim            - not defined
- $XDG_DATA_HOME/nvim[-data]/site           - not defined
- $XDG_DATA_DIRS[1,2,...]/nvim/site         - not defined
- $VIMRUNTIME
- $XDG_DATA_DIRS[1,2,...]/nvim/site/after   - not defined 
- $XDG_DATA_HOME/nvim[-data]/site/after     - not defined
- $XDG_CONFIG_DIRS[1,2,...]/nvim/after      - not defined 
- $XDG_CONFIG_HOME/nvim/after

## relevant functions or commands

require()
  loads and executes file
  avoids executing file twice

:runtime! {file}
  sources _all_ occurrences of {file} in runtimepath 

:echo rtp
  

## initialisation

<https://neovim.io/doc/user/starting.html>

1. enable filetype plugins and indent plugins 
  - same as :runtime! ftplugin.vim indent.vim

2. load system config: 
  - $VIM/sysinit.vim (file doesn't exist)

3. look for initialisations in:
  - $VIMINIT (doesn't exist)
  - $XDG_CONFIG_HOME/nvim/init.lua 
  - $XDG_CONFIG_DIRS[1,2,...]/nvim/init.lua (doesn't exist)
  - $EXINIT (doesn't exist)

7. enable filetype detection
  - same as :runtime! filetype.lua

8. enable syntax highlighting unless :syntax off
  - same as :runtime! syntax/syntax.vim
  - with treesitter highlighting, this would be off 

9. load plugin scripts
  - same as :runtime! plugin/**/*.{vim,lua}
  - check dirs in runtimepath for 'plugin' dirs
  - in each 'plugin' dir and each sub-dir (except for sub-dirs called '*after'):
    - source .vim files in alpha order
    - then source .lua files in alpha order

10. load packages (I have none)
  - these are plugins located in each 'start' dir of 'packpath'

11. source the files in the '*after' dirs 

## loading lua files on startup 

<https://neovim.io/doc/user/lua-guide.html#lua-guide-config>

initial configuration
- init.lua in ~/AppData/Local/nvim/ i.e. $XDG_CONFIG_HOME/nvim 

scripts to execute automatically 
- in plugin/ on runtimepath 

scripts to execute on demand
- in lua/ on runtimepath
- then load with require()

### example

~/AppData/Local/nvim/ 
|-- init.lua 
|-- plugin/
|   |-- auto_script.lua
|-- lua/
|   |-- demand_script.lua
|   |-- some_folder/
|       |-- nested_demand_script.lua 

init.lua and auto_script.lua run automatically 
to run demand_script.lua, require('demand_script')
to run nested_demand_script, require('some_folder.nested_demand_script')

### require non-existent scripts or scripts with errors

calling script is aborted
prevent this by using pcall to make a protected call

local ok, some_module = pcall(require, 'bad_module')
if not ok then
  print("Module error")
else
  // use the module e.g. call one of its functions
  some_module.function()
end

## types of plugins
<https://neovim.io/doc/user/usr_05.html#add-plugin>

1. global:
- $VIMRUNTIME/macros
- $VIM/vimfiles/pack/dist/opt
- $VIMRUNTIME/plugin
- add new ones to plugin/, somewhere in runtimepath

## planning for new config 

move filetype-specific plugins into ftplugin 

implement lazy-loading where possible

try installing plugins without a plugin manager like packer 
packer seems to use a lot of startup time 


