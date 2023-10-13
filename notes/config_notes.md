# notes on neovim config 

these are rough notes, taken from the neovim documentation, on how neovim searches for and loads config files

## arguments

nvim _file1_ _file2_ _file3_
- open several buffers

nvim --clean
- mimic fresh install

nvim --startuptime _logfile_
- write startup timings to _logfile_ 

## relevant variables

$EXINIT
- not defined 

$VIM
- C:/Program Files/Neovim/share/nvim 

$VIMINIT
- not defined 

$VIMRUNTIME
- C:/Program Files/Neovim/share/nvim/runtime

$XDG_CONFIG_DIRS
- list of dirs
- not defined 

$XDG_CONFIG_HOME
- ~/AppData/Local

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
- loads and executes file
- avoids executing file twice

:runtime! {file}
- sources _all_ occurrences of {file} in runtimepath 

:echo &rtp
- prints out runtimepath

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

10. load packages 
  - these contain plugins located in each 'start' dir of 'packpath'
  - packpath default value is same as runtimepath

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
- can add new ones to plugin/, somewhere in runtimepath
- can also put them into a package, which is what packer does

### packages

<https://neovim.io/doc/user/repeat.html#packages>

a package is just a directory that contains plugins
packages are found in pack/, somewhere in runtimepath

- pack/packagename/start contains plugins to load at startup
- pack/packagename/opt contains plugins to load on demand using :packadd

how packer handles plugins:

- packer creates one package, called packer, at 
~/AppData/Local/nvim-data/site/pack/packer

- as required by neovim, this package contains start/ and /opt directories

- when i add a plugin, packer puts it into packer/start 

## planning for new config 

install filetype-specific plugins into opt/

then `require` or `packadd` it under ftplugin/

implement lazy-loading where possible

install plugins without a plugin manager like packer 
packer seems to use a lot of startup time 

### structure

for lua config files:

XDG_CONFIG_HOME/nvim/ 
|-- init.lua
|-- tools
|   |-- plugin_manager.sh   <- my own script to add/update/remove plugins
|-- plugin/
|   |-- these configs are automatically loaded
|   |-- i'll put plugin configs here
|-- lua/
|   |-- these configs need to be required by init.lua
|   |-- i'll put general configs here

for plugins:

- runtimepath includes XDG_DATA_HOME/nvim-data/site
- XDG_DATA_HOME is not defined 
- so if i set XDG_DATA_HOME to ~/AppData/Local,
- and put a package into ~/AppData/Local/nvim-data/site/pack/,
- then neovim will find the package and load the plugins it contains

XDG_DATA_HOME/nvim-data/site/pack/
|-- package_name/
|   |-- start/              <- for startup plugins
|   |   |-- plugin_dir1/    <- each plugin goes into its own folder
|   |   |-- plugin_dir2/
|   |-- opt/                <- for on-demand plugins
|   |   |-- plugin_dir1/    <- each plugin goes into its own folder
|   |   |-- plugin_dir2/

i'll have two packages:
- one for plugins i clone from github
- one for plugins i write myself

- each plugin_dir is a git repo so i can easily update it 
- i can use a bash script to update all the cloned github plugins
- for my own plugins, i can maintain those git repos myself

### using git to manage plugins

create plugin_manager.sh in XDG_CONFIG_HOME/nvim/tools

to add a new plugin:

```
./plugin_manager add <plugin_name> [--opt]
```
- by default, install into start/
- can optionally specify opt/

to update a plugin:

```
./plugin_manager update [plugin_name]...  
```
- by default, update all plugins
- can optionally specify one or more plugins


