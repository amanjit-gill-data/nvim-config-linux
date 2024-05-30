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

install pyright outside of a project env, as it can be used with different versions of python

1. install node - pyright dependency

install this system-wide because:
- pyright doesn't need a specific version of node; just needs to be recent enough
- can use it for other things
- e.g. the latex parser for tree-sitter is compiled using node 

version in apt is too old; download binary from node website instead:
- download binary from https://nodejs.org/en/download/prebuilt-binaries
- extract and put under `/opt/`
- ensure `node` is on path

2. install pipx - to obtain pyright 

- pipx installs packages in isolated envs to avoid interfering with system python
- often used for CLI tools like pyright that can be used for multiple projects

```
sudo apt install pipx           using apt should ensure that pipx and all its 
                                dependencies don't interfere with system python 

pipx ensurepath                 adds ~/.local/bin/ to path 
                                this is where pipx symlinks to installed binaries
```

3. install pyright

```
pipx install pyright            installs into ~/.local/pipx/venvs/ 
                                creates symlink in ~/.local/bin/ 
```

### texlab

I'm setting this up globally, because:
- I'm going to use the same tex distribution for all projects
- The distribution gets very big with all the packages; mitigating the risk of breaking previous projects isn't worth the disk space of separate copies

1. install a typsetting system; I chose tectonic

- download precompiled binary 
- extract and put under `/opt/tectonic`
- ensure `tectonic` is on path

2. install texlab 

- download precompiled binary 
- extract and put under `/opt/texlab`
- ensure `texlab` is on path

## set up completion engine

need:
- `nvim-cmp`; this allows autocompletion from any sources you specify, like language servers, the current buffer, filepaths, etc
- `LuaSnip`; nvim-cmp requires a snippet engine in order to work

sources:
- `cmp-nvim-lsp`; source from lsp 
- `cmp-buffer`
- `cmp-path`
- `cmp-cmdline` 


