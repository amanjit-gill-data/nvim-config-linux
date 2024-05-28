# notes on using lsp for autocompletion and diagnostics

## overview

to get autocompletion and diagnostics, need:

- lsp; on its own, this achieves smarter *omni* completion, as well as diagnostics

- completion engine; this gives *auto* completion

## set up lsp 

need:

- `nvim-lspconfig`; contains lsp configurations for various languages
- language servers like pyright, ruff-lsp, etc 

could use `mason` to manage language servers, but i've chosen to install them myself, using pip, etc

### pyright

1. install node

I'm installing this system-wide, not within the python env, because:
- pyright doesn't need a specific version; just needs to be recent enough
- node is also used to compile some tree-sitter parsers

version in apt is too old; download binary from node website instead:
- download binary from https://nodejs.org/en/download/prebuilt-binaries
- extract and put under `/opt/`
- ensure `node` is on path

2. install pyright

I'm putting pyright in the python env it will be used for, in case different python versions need different pyrights (not sure)

```
source venv_name/bin/activate       first make sure env is activated
pip install pyright         
```

### texlab

I'm setting this up centrally, because:
- I'm going to use the same tex distribution for all projects
- The distribution gets very big with all the packages; mitigating the risk of breaking previous projects isn't worth the disk space of separate copies

1. install a typsetting system; I chose tectonic

- download precompiled binary 
- extract and put under `/opt/`
- ensure `tectonic` is on path

2. install texlab 

- download precompiled binary 
- extract and put under `/opt/`
- ensure `texlab` is on path

### bash-language-server



## set up completion engine

need:
- `nvim-cmp`; this allows autocompletion from any sources you specify, like language servers, the current buffer, filepaths, etc
- `LuaSnip`; nvim-cmp requires a snippet engine in order to work

sources:
- `cmp-nvim-lsp`; source from lsp 
- `cmp-buffer`
- `cmp-path`
- `cmp-cmdline` 


