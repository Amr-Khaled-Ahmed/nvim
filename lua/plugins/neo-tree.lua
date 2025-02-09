return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        filesystem = {
          follow_current_file = true,
          hijack_netrw = true,
          use_libuv_file_watcher = true,
          filtered_items = {
            visible = true, -- Show hidden files
            hide_dotfiles = false, -- Show dotfiles (e.g., .git, .config)
            hide_gitignored = false, -- Show files ignored by .gitignore
          },
        },
        buffers = {
          follow_current_file = true,
        },
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "➜",
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
            
          },
        },
        document_symbols = {
          follow_cursor = true, -- Auto-update as cursor moves
        },
      })
    end,
  }
  