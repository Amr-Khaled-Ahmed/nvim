-- keymap.lua

-- Set leader key to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Ensure line numbers are visible
vim.opt.number = true
vim.opt.relativenumber = true

-- Ensure which-key loads safely
local wk_status, wk = pcall(require, "which-key")
if not wk_status then
  vim.notify("Which-key not found!", vim.log.levels.ERROR)
  return
end

-- Register general key mappings
wk.register({
  e = { "<cmd>NvimTreeToggle<CR>", "File Explorer" },
  s = { "<cmd>w<CR>", "Save File" },
  q = { "<cmd>q<CR>", "Quit Neovim" },
  r = { "<cmd>source $MYVIMRC<CR>", "Reload Config" },
  f = { "<cmd>Telescope find_files<CR>", "Search Files" },
}, { prefix = "<leader>" })

-- ✅ Git commands under <leader>g
wk.register({
  s = { "<cmd>!git status<CR>", "Git Status" },
  p = { "<cmd>!git push<CR>", "Git Push" },
  P = { "<cmd>!git pull<CR>", "Git Pull" },
  c = { "<cmd>!git commit<CR>", "Git Commit" },
  C = { "<cmd>!git commit --amend<CR>", "Git Commit Amend" },  -- Amend last commit
  f = { "<cmd>!git push --force<CR>", "Git Force Push" },  -- Force Push
  l = { "<cmd>!git log<CR>", "Git Log" },
}, { prefix = "<leader>g" })

-- ✅ PowerShell 7 terminal keybindings
wk.register({
  tv = { ":vsplit | term pwsh.exe<CR>", "Open PowerShell 7 (Vertical Split)" },
  th = { ":botright split | resize 12 | term pwsh.exe<CR>", "Open PowerShell 7 (Bottom Split)" },
  tf = { ":FloatermNew --height=0.9 --width=0.9 pwsh.exe<CR>", "Open PowerShell 7 (Large Floating Terminal)" },
}, { prefix = "<leader>t" })

-- ✅ Clipboard keybindings (system clipboard)
vim.keymap.set("n", "<C-c>", '"+y', { silent = true })
vim.keymap.set("n", "<C-x>", '"+d', { silent = true })
vim.keymap.set("n", "<C-v>", '"+p', { silent = true })

-- ✅ Split Resizing with Shift + Ctrl + Arrow Keys
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -2<CR>", { silent = true })

-- ✅ Force which-key to reload on entering a new buffer (fixes <leader> issue)
vim.cmd([[
  augroup FixLeader
    autocmd!
    autocmd BufEnter * lua require("which-key").setup()
  augroup END
]])

-- ✅ Force apply line numbers (fixes missing numbers in some files)
vim.cmd([[
  augroup FixNumbers
    autocmd!
    autocmd BufEnter * set number relativenumber
  augroup END
]])

