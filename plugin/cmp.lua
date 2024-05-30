local status, cmp = pcall(require, "cmp")
if not status then
  return
end

local status, luasnip = pcall(require, "luasnip")
if not status then
  return
end

-- set up editor completion
cmp.setup({

  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(), -- highlight prev suggestion
    ['<C-j>'] = cmp.mapping.select_next_item(), -- highlight next suggestion
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(), -- show suggestions
    ['<C-e>'] = cmp.mapping.abort(), -- close completion window
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- from language servers
    { name = "buffer" },
    { name = "path", option = { trailing_slash = true }}
  })

})

-- set up command-line completion 
cmp.setup.cmdline(":", {
  
  mapping = cmp.mapping.preset.cmdline(),
  
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" }
  })

})

-- set up search completion
cmp.setup.cmdline({"/", "?"}, {
  
  mapping = cmp.mapping.preset.cmdline(),
  
  sources = {
     { name = "buffer" }
  }
})


