return {
  -- GitSigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+", hl = "GitSignsAdd" },
          change = { text = "~", hl = "GitSignsChange" },
          delete = { text = "_", hl = "GitSignsDelete" },
          topdelete = { text = "‾", hl = "GitSignsDelete" },
          changedelete = { text = "~", hl = "GitSignsChange" },
        },
        on_attach = function(bufnr)
          local gs = require("gitsigns")
          local function map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          -- Hunk navigation
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { desc = "Next Hunk", expr = true })

          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { desc = "Previous Hunk", expr = true })

          -- GitSigns actions
          map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
          map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
          map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
          map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
          map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
          map("n", "<leader>gb", function() gs.blame_line{ full = true } end, { desc = "Blame Line" })
          map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
          map("n", "<leader>gd", gs.diffthis, { desc = "Diff This" })
          map("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Diff Against Index" })
          map("n", "<leader>gO", function() gs.diffthis("origin/HEAD") end, { desc = "Diff Against Origin" })
          map("n", "<leader>gD", gs.toggle_deleted, { desc = "Toggle Deleted Lines" })

          -- Git status and LazyGit
          map("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Git Status" })
          map("n", "<leader>gG", "<cmd>FloatermNew lazygit<CR>", { desc = "LazyGit" })
        end,
      })

      -- Define custom highlights for Git signs
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#98c379" }) -- Green for added lines
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e5c07b" }) -- Yellow for changed lines
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff6c6b" }) -- Red for deleted lines
    end,
  },
}
