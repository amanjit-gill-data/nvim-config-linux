# notes on using lsp for autocompletion and diagnostics

## overview

to get autocompletion and diagnostics, need:

- lsp; on its own, this achieves smarter *omni* completion, as well as diagnostics

- completion engine; this gives *auto* completion

## 1. set up lsp 

need:

- `nvim-lspconfig`; contains lsp configurations for various languages
- language servers like pyright, ruff-lsp, etc 

could use `mason` to manage language servers, but i've chosen to install them myself, using conda, pip, etc 

## 2. set up completion engine

need:
- `nvim-cmp`; this allows autocompletion from any sources you specify, like language servers, the current buffer, filepaths, etc
- `LuaSnip`; nvim-cmp requires a snippet engine in order to work

sources:
- `cmp-nvim-lsp`; source from lsp 
- `cmp-buffer`
- `cmp-path`
- `cmp-cmdline` 


