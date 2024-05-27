# notes on neovim config 

## my setup

### user configs

~/.config/nvim/ 
|-- init.lua
|-- plugin/
|   |-- these configs are automatically loaded
|   |-- i'll put plugin configs here
|-- lua/
|   |-- these configs need to be required by init.lua
|   |-- i'll put general configs here
|-- tools
|   |-- plugin_manager.sh

### installing plugins

**overall structure**

- can choose anywhere on packpath
- I've chosen ~/.local/share/nvim/site/pack, which is the norm

~/.local/share/nvim/site/pack/
|-- package-name/
|   |-- start/              for startup plugins
|   |   |-- plugin1/        
|   |   |-- plugin2/
|   |-- opt/                for on-demand plugins
|   |   |-- plugin3/        
|   |   |-- plugin4/

**packages**

I'll have two packages:
    - github, for plugins from github
    - mine, for plugins I write myself

so the high-level structure will look like:

~/.local/share/nvim/site/pack/
|-- github/
|-- mine/

**strategy for plugins from github**

- each plugin under github/ is a cloned git repo
- I'll use a bash script to install, update and delete

**strategy for filetype-specific plugins**

if I'm not editing a particular filetype, there's no need to load its plugins
    - therefore, install filetype-specific plugins into opt/
    - then `require` or `packadd` it under ftplugin/

## how configs and startup work in neovim

### startup options

`nvim _file1_ _file2_ _file3_`
- open several buffers

`nvim --clean`
- mimic fresh install

`nvim --startuptime _logfile_`
- write startup timings to _logfile_ 

### environment variables

$EXINIT
- not set

$VIM
- used to locate user files such as config
- /opt/nvim-linux64/share/nvim

$VIMINIT
- not set

$VIMRUNTIME
- used to locate support files such as docs and syntax highlighting rules
- these are distributed with nvim
- /opt/nvim-linux64/share/nvim/runtime

$XDG_CONFIG_HOME
- to locate user config
- if not set, stdpath("config") is used
- ~/.config/nvim

$XDG_CONFIG_DIRS
- config location required by XDG specification
- can also put site configs from sysadmin here
- if not set, stdpath("config_dirs") is used
- list of dirs
- /etc/xdg/xdg-zorin
- /etc/xdg

$XDG_DATA_HOME
- to locate plugins installed by user
- if not set, stdpath("data") is used 
- ~/.local/share/nvim

$XDG_DATA_DIRS
- to locate plugins installed by sysadmin
- if not set, stdpath("data_dirs") is used
- list of dirs 
- I won't need this, so I haven't listed the dirs here

### functions and commands

`require()`
- load and executes file
- avoid executing file twice

`:runtime! <filename>`
- source _all_ occurrences of <filename> in runtimepath 

`:echo &rtp` or `:echo &runtimepath`
- print runtimepath
- if nvim was invoked with `--clean`, then my home dir entries won't be listed

`:echo &packpath`
- print packpath
- default is same as runtimepath

`:echo stdpath("config")`
- print default user config dir

### initialisation

<https://neovim.io/doc/user/starting.html>

1. enable (not load) filetype plugins and indent plugins 
  - same as `:runtime! ftplugin.vim indent.vim`

2. load system config: 
  - $VIM/sysinit.vim (doesn't exist)

3. look for initialisations in:
  - $VIMINIT (not set)
  - $XDG_CONFIG_HOME/nvim/init.lua OR ~/.config/nvim/init.lua if not set
  - $XDG_CONFIG_DIRS/[some-dir]/nvim/init.lua (doesn't exist)
  - $EXINIT (not set)

7. enable filetype detection
  - same as `:runtime! filetype.lua`

8. enable syntax highlighting unless :syntax off
  - same as `:runtime! syntax/syntax.vim`
  - with treesitter highlighting, this would be off 

9. load plugin scripts
  - in nvim, 'plugin' just means extra scripts added by user
  - same as `:runtime! plugin/**/*.{vim,lua}`
  - check dirs in runtimepath for 'plugin' dirs
  - in each 'plugin' dir and each sub-dir (except for sub-dirs called '*after'):
    - source .vim files in alpha order
    - then source .lua files in alpha order

10. load packages 
  - in nvim, 'package' is a directory containing plugins (extra scripts) 
  - check each 'start' dir in 'packpath'
  - packpath default value is same as runtimepath

11. source the files in the '*after' dirs 

### how nvim loads user configs 

<https://neovim.io/doc/user/lua-guide.html#lua-guide-config>

<https://neovim.io/doc/user/options.html#'runtimepath'>

initial configuration
- ~/.config/nvim/init.lua

scripts to execute automatically i.e. without me explicitly 'requiring' them
- in plugin/ on runtimepath
- ~/.config/nvim/plugin/

scripts to execute on demand
- in lua/ on runtimepath
- then load with require()
- ~/.config/nvim/lua/

**example**

~/.config/nvim
|-- init.lua 
|-- plugin/
|   |-- some_script.lua
|-- lua/
|   |-- another_script.lua
|   |-- some_folder/
|       |-- nested_demand_script.lua 

- init.lua and some_script.lua run automatically 
- to run another_script.lua, require('demand_script')
- to run nested_demand_script, require('some_folder.nested_demand_script')

**non-existent scripts or scripts with errors**

- calling script is aborted with error, then startup continues
- can prevent this by using pcall to make a protected call

```
local ok, some_module = pcall(require, 'bad_module')
if not ok then
  print("Module error")
else
  // use the module e.g. call one of its functions
  some_module.function()
end
```

### types of plugins

<https://neovim.io/doc/user/usr_05.html#add-plugin>

**global**
- $VIMRUNTIME/macros
- $VIM/vimfiles/pack/dist/opt
- $VIMRUNTIME/plugin
- can add new ones to plugin/, somewhere in runtimepath
- can also put them into a package, which is what packer does

**packages**

<https://neovim.io/doc/user/repeat.html#packages>

- a package is just a directory that contains plugins
- packages are found in pack/, anywhere on packpath
    - pack/packagename/start contains plugins to load at startup
    - pack/packagename/opt contains plugins to load on demand using :packadd

- the norm is `~/.local/share/nvim/site/`


