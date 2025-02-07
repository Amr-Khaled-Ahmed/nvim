return {
    {
      "jose-elias-alvarez/null-ls.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local null_ls = require("null-ls")
  
        null_ls.setup({
          sources = {
            -- Formatters
            null_ls.builtins.formatting.clang_format, -- C, C++
            null_ls.builtins.formatting.black, -- Python
            null_ls.builtins.formatting.prettier, -- JSON, Markdown
  
            -- Linters
            null_ls.builtins.diagnostics.clang_check, -- C, C++
            null_ls.builtins.diagnostics.flake8, -- Python
          },
        })
      end,
    }
  }
  