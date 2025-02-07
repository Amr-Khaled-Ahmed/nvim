return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })

      -- Improved custom command
      vim.api.nvim_create_user_command("Telescope", function(opts)
        if #opts.fargs == 0 then
          builtin.builtin() -- Open list of all pickers if no argument is provided
        else
          local cmd = builtin[opts.fargs[1]]
          if cmd then
            cmd()
          else
            print("Invalid Telescope command: " .. opts.fargs[1])
          end
        end
      end, {
        nargs = "?",
        complete = function()
          return vim.tbl_keys(builtin)
        end,
      })
    end,
  },
}
