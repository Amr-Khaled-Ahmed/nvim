-- lua/plugins.lua

return {
  -- Lazy Plugin Manager
  { "folke/lazy.nvim" },

  -- Mason: LSP Manager
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- LSP Config
  { "neovim/nvim-lspconfig" },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Git Plugins
  { "lewis6991/gitsigns.nvim" },
  { "kdheepak/lazygit.nvim" },
  -- Additional Git Plugins
  { "tpope/vim-fugitive" },  -- Git commands in Vim
  { "junegunn/gv.vim" },      -- Git commit browser
  { "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },  -- Git diff viewer




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

    end
  }
}
