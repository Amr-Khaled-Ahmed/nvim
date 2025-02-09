-- lua/config/noice.lua

require("noice").setup({
  -- Optimize LSP features for speed
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
      ["vim.lsp.util.stylize_markdown"] = false,
      ["cmp.entry.get_documentation"] = false,
    },
    signature = { enabled = false }, -- Disable signature help for speed
    progress = { enabled = false }, -- Hide LSP progress notifications
    hover = { enabled = false }, -- Disable hover popups (optional)
  },

  -- UI Presets
  presets = {
    bottom_search = true, -- Show search box at bottom
    command_palette = true, -- Floating command line
    long_message_to_split = true, -- Send long messages to a split
    inc_rename = false, -- Disable inc-rename (can be slow)
    lsp_doc_border = true, -- Keep border for LSP hover docs
  },

  -- Routes: Skip unnecessary messages to reduce noise
  routes = {
    -- Hide "written" messages
    {
      filter = { event = "msg_show", kind = "", find = "written" },
      opts = { skip = true },
    },
    -- Hide "search hit BOTTOM" messages
    {
      filter = { event = "msg_show", kind = "search_count" },
      opts = { skip = true },
    },
    -- Auto-send large messages to a split
    {
      filter = { event = "msg_show", min_length = 200 },
      view = "split",
    },
    -- Hide "Failed to load parser" error
    {
      filter = { event = "msg_show", find = "Failed to load parser" },
      opts = { skip = true },
    },
  },

  -- Views: Customize notification behavior
  views = {
    notify = {
      replace = true, -- Replace old notifications
      merge = true, -- Merge similar notifications
      timeout = 1500, -- Shorter timeout for notifications
    },
    cmdline_popup = {
      position = { row = "10%", col = "50%" }, -- Centered command line
      border = {
        style = "rounded",
        text = {
          top = " Command Line ", -- Title for the command line box
          top_align = "center", -- Center-align the title
        },
      },
      size = { width = 40, height = 1 }, -- Adjust size as needed
    },
    popupmenu = { backend = "cmp" }, -- Ensure Noice manages popups
  },

  -- General Performance Optimizations
  messages = { enabled = false }, -- Disable Noice messages
  markdown = { hover = { enabled = false }, highlights = false }, -- Disable markdown processing
})