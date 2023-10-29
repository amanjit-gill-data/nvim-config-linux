-- GENERAL KEYMAPS --

-- plugin-specific keymaps are located in the plugin configs 

-- set leading character for custom keymaps to '\'
vim.g.mapleader = "\\"

local km = vim.keymap

-- move directly up/down even when word wrap is on
km.set("n", "j", "gj")
km.set("n", "k", "gk")
km.set("n", "<Down>", "gj")
km.set("n", "<Up>", "gk")

-- navigate to start of next paragraph
-- assumes each paragraph is separated by a single line
km.set("n", "<leader>np", "vip<Esc>jj")

-- delete single character without saving it to clipboard
km.set("n", "x", '"_x')

-- easier keymap to turn off search highlighting
km.set("n", "<leader>nh", ":nohl<CR>")

-- easier keymaps for window splits
km.set("n", "<leader>sv", "<C-w>v") -- vertical split
km.set("n", "<leader>sh", "<C-w>s") -- horizontal split 
km.set("n", "<leader>se", "<C-w>=") -- make split equal in width & height
km.set("n", "<leader>sc", ":close<CR>") -- close current split window

-- easier keymaps for tabs
km.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
km.set("n", "<leader>tc", ":tabclose<CR>") -- close current tab
km.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
km.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- toggle b/w start/end of line
-- press 0 to move to end of line
-- press again to move to start of line
function LineStartEnd()
  r, c = unpack(vim.api.nvim_win_get_cursor(0))
  line_length = vim.fn.col('$') - 1

  if c+1 ~= line_length then
    vim.api.nvim_win_set_cursor(0, {r, line_length})
  else 
    vim.api.nvim_win_set_cursor(0, {r, 0})
  end 
end

km.set("n", "0", ":lua LineStartEnd()<CR>") 

