-- board.lua

local header = {
  "███████╗██████╗ ██╗   ██╗██╗███╗   ███╗",
  "██╔════╝██╔══██╗██║   ██║██║████╗ ████║",
  "█████╗  ██████╔╝██║   ██║██║██╔████╔██║",
  "██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║",
  "███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

require("dashboard").setup({
  theme = "hyper",
  config = {
    header = header,
    shortcut = {
      {
        icon = " ",
        desc = "Find File",
        group = "Label",
        action = "Telescope find_files",
        key = "f",
      },
      {
        icon = " ",
        desc = "Grep Text",
        group = "Label",
        action = "Telescope live_grep",
        key = "g",
      },
      {
        icon = " ",
        desc = "Config",
        group = "Label",
        action = "e ~/.config/nvim/init.lua",
        key = "c",
      },
      {
        icon = " ",
        desc = "Quit",
        group = "Label",
        action = "q",
        key = "q",
      },
    },
    packages = { enable = false }, -- Disable package stats
    footer = { "⚡ Neovim loaded in " .. vim.fn.printf("%.3f", vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))) .. " seconds" },
  },
})

-- Add custom highlights for the dashboard
vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#61afef", bold = true })
vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#98c379", bold = true })
vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#e5c07b", bold = true })
vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#c678dd", bold = true })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#56b6c2", italic = true })

-- Apply highlights to the dashboard
vim.cmd([[
  highlight! link DashboardHeader DashboardHeader
  highlight! link DashboardIcon DashboardIcon
  highlight! link DashboardDesc DashboardDesc
  highlight! link DashboardKey DashboardKey
  highlight! link DashboardFooter DashboardFooter
]])
