local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
  return
end

-- require nvim-cmp to enable parentheses to be added after completions
local status, cmp = pcall(require, "cmp")
if not status then
  return
end

local status, autopairs_cmp = pcall(require, "nvim-autopairs.completion.cmp")
if not status then
  return
end

cmp.event:on(
  'confirm_done', 
  autopairs_cmp.on_confirm_done()
)

autopairs.setup()


