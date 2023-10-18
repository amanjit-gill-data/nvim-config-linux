# notes on setting up lsp servers

## overview

lsp servers can provide **diagnostics** and **omnicompletion**, etc

### required plugins for lsp

`nvim-lspconfig` contains configurations for various languages
`mason` can help manage lsp servers (install, update, etc) from within neovim

i will use `nvim-lspconfig` so i don't have to configure each server manually
but i won't use `mason` as i can install the servers myself.

for **autocompletion**, will also need a completion engine like `nvim-cmp`
set this up after lsp is working

## set up lsp

1. install `nvim-lspconfig` plugin

2. install lsp servers

e.g. 
```
conda install pyright
pip install ruff-lsp
```

3. create config file under plugin/ to `require` lspconfig

4. in the config file, call `setup` for each lsp server

e.g. for python:
```
lspconfig.pyright.setup{}       add language-specific configs in here
```
## set up autocompletion

a 'completion engine' plugin can be used to achieve autocompletion
it can use the installed language servers (like pyright) as sources
it can also use a snippet engine, the current buffer, and filepaths

i've chosen `nvim-cmp` as my completion engine
this requires a snippet engine in order to work
so i've chosen `LuaSnip` for that, although i won't actually use this as a source

i'm also using `cmp-buffer` and `cmp-path` as sources

`cmp-nvim-lsp` is also required, because:
- neovim offers lsp capabilities
- but nvim-cmp offers *more* capabilities
- so cmp-nvim-lsp overrides the capabilities offered by neovim

1. install `nvim-cmp` and `cmp-nvim-lsp` plugin

2. install `LuaSnip` plugin; a snippet engine is needed for `nvim-cmp` to work

3. create config file under plugin/ to 'require' nvim-cmp

4. in the config file, `setup` cmp to:

- `require` the snippet engine LuaSnip
- define completion mappings
- specify completion sources

5. in the lspconfig config, set the default capabilities to those offered by nvim-cmp




