# notes on setting up tree-sitter 

1. install nvim-treesitter 

2. start nvim; it should automatically install parsers for the languages mentioned in the user config (treesitter.lua)

3. latex parser won't install without `tree-sitter CLI` and `nodejs` 

3.1. download tree-sitter zip; it contains just one file, the binary itself 

3.2. move tree-sitter binary into `/opt/tree-sitter/`; need root privileges 

3.3. make tree-sitter binary executable: `chmod +x tree-sitter`

3.4. add `/opt/tree-sitter/` to PATH

3.5. install node: `sudo apt install nodejs`
