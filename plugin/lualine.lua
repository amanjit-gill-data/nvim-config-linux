local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- colours suggested by josean
local new_colours = {
  blue = "#65D1FF",
  green = "#3EFFDC",
  violet = "#FF61EF",
  yellow = "#FFDA7B",
  black = "#000000"
}

-- lualine includes a theme to match nightfly colour scheme
-- define easy handle to access its config 
local nightfly = require("lualine.themes.nightfly")

-- set background colours for different modes
nightfly.normal.a.bg = new_colours.blue
nightfly.insert.a.bg = new_colours.green
nightfly.visual.a.bg = new_colours.violet

-- the code for command mode is different because lualine doesn't have a 
-- setting for it, so I define it myself
nightfly.command = {
  a = {
    gui = "bold",
    bg = new_colours.yellow,
    fg = new_colours.black
  }
}

lualine.setup({
  options = {
    theme = nightfly
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {'diagnostics'},

    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  }
})
