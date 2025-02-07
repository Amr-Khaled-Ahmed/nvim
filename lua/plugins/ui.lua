return {
  -- Lualine (Status Bar)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              file_status = true,
              path = 1,
              symbols = {
                modified = "●",
                readonly = "",
                unnamed = "[No Name]",
              },
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy", "quickfix" },
      })
    end,
  },

  -- Indent Blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help", "alpha", "dashboard", "neo-tree",
          "Trouble", "lazy", "notify", "toggleterm",
        },
      },
    },
    main = "ibl",
  },

  -- Dressing (UI Enhancements)
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- Bufferline (Tabs)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs",
          numbers = "ordinal",
          separator_style = "slant",
          show_buffer_close_icons = false,
          show_close_icon = false,
          color_icons = true,
          enforce_regular_tabs = true,
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      })
    end,
  },

  -- Dashboard (Start Screen)
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      -- List of multiple ASCII headers
      local headers = {
        {
          "  _    _          _   _  _____ __  __          _   _ ",
          " | |  | |   /\\   | \\ | |/ ____|  \\/  |   /\\   | \\ | |",
          " | |__| |  /  \\  |  \\| | |  __| \\  / |  /  \\  |  \\| |",
          " |  __  | / /\\ \\ | . ` | | |_ | |\\/| | / /\\ \\ | . ` |",
          " | |  | |/ ____ \\| |\\  | |__| | |  | |/ ____ \\| |\\  |",
          " |_|  |_/_/    \\_\\_| \\_|\\_____|_|  |_/_/    \\_\\_| \\_|",
        },
        { 
          " ▄  █ ▄█     ██   █▀▄▀█ █▄▄▄▄ ",
          " █   █ ██     █ █  █ █ █ █  ▄▀ ",
          " ██▀▀█ ██     █▄▄█ █ ▄ █ █▀▀▌  ",
          " █   █ ▐█     █  █ █   █ █  █  ",
          "    █   ▐        █    █    █   ",
          "   ▀            █    ▀    ▀    ",
          "               ▀               ",
        }
      }

      -- Select a random header
      local header = headers[math.random(#headers)]

      require("dashboard").setup({
        theme = "hyper",
        config = {
          header = header,
          shortcut = {
            { icon = " ", desc = "Find File", action = "Telescope find_files", key = "f" },
            { icon = " ", desc = "Grep Text", action = "Telescope live_grep", key = "g" },
            { icon = " ", desc = "Config", action = "e ~/.config/nvim/init.lua", key = "c" },
            { icon = " ", desc = "Quit", action = "q", key = "q" },
          },
          packages = { enable = false },
          footer = { " Neovim loaded in " .. vim.fn.printf("%.3f", vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))) .. "s" },
        },
      })

      -- Custom highlights
      vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#61afef", bold = true })
      vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#98c379", bold = true })
      vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#e5c07b", bold = true })
      vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#c678dd", bold = true })
      vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#56b6c2", italic = true })
    end,
  },

  -- Theme: TokyoNight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
