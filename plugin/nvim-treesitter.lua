-- safely import
local status, ts_configs = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

ts_configs.setup {

  -- default dir is parser/, where nvim-treesitter is located
  ensure_installed = {"python", "r", "sql", "markdown", "latex", "lua", "bash"},
  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
}
