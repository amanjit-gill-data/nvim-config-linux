# notes on setting up lsp servers

## overview

lsp servers can provide **diagnostics** and **omnicompletion**, etc

### required plugins for lsp

`nvim-lspconfig` contains configurations for various languages
`mason` can help manage lsp servers (install, update, etc) from within neovim

i'm going to use `nvim-lspconfig` so i don't have to configure each server manually; but i won't use `mason` as i can install the servers myself.

for **autocompletion**, will also need a completion plugin like `nvim-cmp`
set this up after lsp is working

## set up lsp

1. install `nvim-lspconfig` plugin

2. install lsp servers

e.g. for python:
```
conda install pyright
```

3. create config file under plugin/ to `require` lspconfig

4. in the config file, call `setup` for each lsp server

e.g. for python:
```
lspconfig.pyright.setup{}       add language-specific configs in here
```




