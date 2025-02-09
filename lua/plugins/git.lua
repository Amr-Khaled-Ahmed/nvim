return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cond = function()
      return vim.fn.system("git rev-parse --is-inside-work-tree") == "true\n"
    end,
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│", hl = "GitSignsAdd" },
          change = { text = "┃", hl = "GitSignsChange" },
          delete = { text = "▁", hl = "GitSignsDelete" },
          topdelete = { text = "▔", hl = "GitSignsDelete" },
          changedelete = { text = "═", hl = "GitSignsChange" },
        },
        update_debounce = 200,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 500,
          virt_text_pos = "eol",
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        word_diff = true, -- Highlight word changes
        diff_opts = {
          internal = true,
        },
        preview_config = {
          border = "rounded",
          style = "minimal",
        },
      })

      -- Auto-refresh GitSigns after writing files
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*",
        callback = function()
          require("gitsigns").refresh()
        end,
      })

      -- Custom highlight colors
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#50fa7b", bold = true })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffb86c", bold = true })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff5555", bold = true })
    end,
  },
}
