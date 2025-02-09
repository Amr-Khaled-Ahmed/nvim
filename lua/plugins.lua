-- lua/plugins.lua

return {
    -- Lazy Plugin Manager
    { "folke/lazy.nvim" },
  
    -- Core Plugins
    { import = "plugins.core" },
  
    -- UI Plugins
    { import = "plugins.ui" },
  
    -- LSP Plugins
    { import = "plugins.lsp" },
  
    -- Git Plugins
    { import = "plugins.git" },
  
    -- Tools Plugins
    { import = "plugins.tools" },
  
    -- Telescope Plugins
    { import = "plugins.telescope" },
  
    -- Debugging Plugins
    { import = "plugins.dap" },
    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim", -- Dependency for UI components
        "rcarriga/nvim-notify",  -- Optional: For notifications
      },
      config = function()
        require("config.noice") -- Load noice configuration
      end,
    },
  }

  