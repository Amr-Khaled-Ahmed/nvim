-- plugins/git.lua

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

          -- Key mappings for GitSigns
          map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
          map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
          map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
          map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
          map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
          map("n", "<leader>gb", function() gs.blame_line{ full = true } end, { desc = "Blame Line" })
          map("n", "<leader>gd", gs.diffthis, { desc = "Diff This" })
        end,
      })

      -- Define custom highlights for Git signs
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#98c379" }) -- Green for added lines
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e5c07b" }) -- Yellow for changed lines
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff6c6b" }) -- Red for deleted lines
    end,
  },
}