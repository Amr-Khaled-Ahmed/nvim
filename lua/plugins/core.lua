return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        window = {
          border = "single",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 1, 1, 1, 1 },
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        ignore_missing = false,
        show_help = true,
        show_keys = true,
        triggers = {"<leader>"},
      })

      wk.register({
        ["<leader>"] = {
          b = { name = "+Buffers" },
          f = { name = "+Find" },
          g = { name = "+Git" },
          s = { name = "+Splits" },
          t = { name = "+Tabs" },
          T = { name = "+Themes" },
          x = { name = "+Terminal" },
        }
      })
    end,
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
}