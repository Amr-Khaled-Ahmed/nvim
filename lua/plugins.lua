-- lua/plugins.lua

return {
  -- Lazy Plugin Manager
  { "folke/lazy.nvim" },

  -- Mason: LSP Manager
  { "williamboman/mason.nvim" },

  -- NvimTree: File Explorer
  { "nvim-tree/nvim-tree.lua" },

  -- Telescope: Fuzzy Finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Dashboard: Startup Screen
  { "glepnir/dashboard-nvim" },

  -- Which-Key: Leader Menu
  { "folke/which-key.nvim" },

  -- Lualine: Status Bar
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight", -- Use a theme of your choice
        },
      })
    end,
  },

  -- ToggleTerm: Floating Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        direction = "float", -- Floating terminal
      })
    end,
  },

  -- Themes
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "ellisonleao/gruvbox.nvim" },

  -- Markdown Live Preview
  { "iamcco/markdown-preview.nvim", ft = "markdown" },

  -- Noice: Floating Command Box
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup", -- Floating command box
        },
      })
    end,
  },
    
  {
    "voldikss/vim-floaterm",
    config = function()
      -- Floaterm settings
      vim.g.floaterm_keymap_new = "<leader>t"  -- Key to open a new floating terminal
      vim.g.floaterm_keymap_toggle = "<leader>ft"  -- Key to toggle the floating terminal
    end
  }
}


