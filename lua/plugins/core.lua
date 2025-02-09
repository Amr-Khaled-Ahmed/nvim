return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500  -- Increased slightly for better usability
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
          presets = {
            operators = true,    -- adds help for operators like d, y, ...
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,           -- bindings for folds, spelling and others prefixed with z
            g = true,           -- bindings for prefixed with g
          },
        },
        operators = { gc = "Comments" },
        key_labels = {
          ["<space>"] = "SPC",
          ["<cr>"] = "RET",
          ["<tab>"] = "TAB",
        },
        window = {
          border = "single",       -- Changed to single for better visibility
          position = "bottom",     -- Bottom of the screen
          margin = { 1, 0, 1, 0 }, -- Adjust margins [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- More padding for better readability
          winblend = 0,            -- No transparency for better readability
        },
        layout = {
          height = { min = 4, max = 25 },    -- Allow for more vertical space
          width = { min = 20, max = 50 },    -- Allow for more horizontal space
          spacing = 3,                       -- More space between columns
          align = "center",                  -- Center alignment looks better
        },
        ignore_missing = true,               -- Don't show undefined mappings
        show_help = true,                    -- Show help message
        show_keys = true,                    -- Show the currently pressed key combination
        triggers = "auto",                   -- Automatically setup triggers
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          i = { "j", "k" },
          v = { "j", "k" },
        },
        -- Modern color scheme
        colors = {
          bg = "#24273a",           -- Darker background
          fg = "#cad3f5",           -- Brighter text
          border = "#8aadf4",       -- Prominent border
          heading = "#8aadf4",      -- Match border color
          prefix = "#ed8796",       -- Distinctive prefix color
          description = "#a5adcb",  -- Slightly muted description
          group = "#f5a97f",        -- Distinctive group color
        },
        icons = {
          breadcrumb = "»",         -- Breadcrumb separator
          separator = "→",          -- Mapping separator
          group = "+" ,            -- Group prefix
        },
      })

      -- Register your keymaps with better organization and icons
      wk.register({
        ["<leader>"] = {
          name = "Leader",  -- Name for the leader key group
          b = { 
            name = "📂 Buffers",
            description = "Buffer operations"
          },
          f = { 
            name = "🔍 Find",
            description = "Search operations"
          },
          g = { 
            name = "🔥 Git",
            description = "Git operations"
          },
          s = { 
            name = "📑 Splits",
            description = "Window splits"
          },
          t = { 
            name = "📌 Tabs",
            description = "Tab operations"
          },
          T = { 
            name = "🎨 Themes",
            description = "Theme settings"
          },
          x = { 
            name = "🖥️ Terminal",
            description = "Terminal operations"
          },
          w = { 
            name = "📝 Workspace",
            description = "Workspace operations"
          },
          z = { 
            name = "🔧 Tools",
            description = "Tools and utilities"
          },
        },
      })

      -- Optional: Set a better help message
      wk.setup({
        popup_mappings = {
          scroll_down = '<c-d>',
          scroll_up = '<c-u>',
        },
      })
    end,
  },
  {
    "Exafunction/codeium.vim",
    event = "InsertEnter",
    config = function()
      vim.g.codeium_enabled = true
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { 
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" },
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
        highlight = {
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        },
      })
    end
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 90,
        options = {
          number = true,
          relativenumber = true,
        }
      },
    }
  },
  -- Intelligent auto-completion (like VS Code)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
  },
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      -- Force the use of specific browser on Windows
      vim.g.mkdp_browser = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
      -- or for Microsoft Edge:
      -- vim.g.mkdp_browser = 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe'
      vim.g.mkdp_theme = 'dark'
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
    end,
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        -- Add your NvimTree configuration here
      })
    end,
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        stages = "fade_in_slide_out",
        timeout = 3000,
        background_colour = "#1e1e2e",
        render = "minimal",
      })
      -- Set as default notify handler
      vim.notify = require("notify")
    end,
  },

  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
}